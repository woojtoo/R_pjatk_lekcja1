# ZADANIE 1
auta <- read.csv('autaSmall.csv', fileEncoding='utf-8')
View(head(auta, 5))





# ZADANIE 2

# install.packages("httr")
# install.packages("jsonlite")
# 
# require(httr)
library(httr)
library(jsonlite)


endpoint <- "https://api.openweathermap.org/data/2.5/weather?q=Warszawa&units=metric&appid=1765994b51ed366c506d5dc0d0b07b77"
getWeather <- GET(endpoint)
weatherText <- content(getWeather, 'text')
# View(weatherText)
weatherJSON <- fromJSON(weatherText)
wdf <- as.data.frame(weatherJSON)
View(wdf)




# ZADANIE 3
?read.table
df <- read.table('autaSmall.csv', sep=',', header=TRUE, fileEncoding='utf-8', nrows=10)
View(nrow(df))

fileConnection <- file(description='autaSmall.csv', open='r')
View(fileConnection)


install.packages(c('DBI', 'RSQLite'))
library(DBI)
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "db.sqlite")

dbWriteTable(con, "table", df)
dbReadTable(con, "table")
dbDisconnect(con)

View(file.size('autaSmall.csv'))

readToBase <- function(filepath, dbConn, tablename, size, sep=",", header=TRUE, delete=TRUE){
  fileConnection <- file(description=filepath, open='r')
  df <- read.table(fileConnection, fill=TRUE, sep=sep, header=header, fileEncoding='utf-8', nrows=size)
  cols <- names(df)
  dbWriteTable(dbConn, tablename, df, append=!delete, overwrite=delete)

  repeat{
    df <- read.table(fileConnection, fill=TRUE, col.names=cols, sep=sep, header=FALSE, fileEncoding='utf-8', nrows=size)
    dbWriteTable(dbConn, tablename, df, append=TRUE, overwrite=FALSE)
    if(nrow(df) < size){
      break
    }
  }
  dbDisconnect(dbConn)
  close(fileConnection)
}

con <- dbConnect(RSQLite::SQLite(), "db.sqlite")
readToBase('autaSmall.csv', con, 'tabela', 10000)
con <- dbConnect(RSQLite::SQLite(), "db.sqlite")
dbReadTable(con, "tabela")




# ZADANIE 4
res <- dbSendQuery(con, 'select * from tabela')
zBazy <- dbFetch(res)
dbClearResult(res)
dbDisconnect(con)






# ZADANIE 5
# 'http://54.37.136.190:8000/__docs__/'
rowJSON <- fromJSON('http://54.37.136.190:8000/row?id=1')
print(rowJSON)
rdf <- as.data.frame(rowJSON)
View(rdf)






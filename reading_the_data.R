file <- "C:/Users/lijing.soh/Desktop/R-stuff/4-EDA/Consumption/household_power_consumption.txt"

#note that in this dataset missing values are coded as ?
raw <- read.table(file=file, header = TRUE, sep = ";", dec = ".", 
           colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
           stringsAsFactors = FALSE,
           na.strings = "?")


#convert character to date
#raw[['Date']] <- as.POSIXct(raw[['Date']],"%d/%m/%Y")
raw$Date <- as.Date(raw$Date,format = "%d/%m/%Y")

#create new "data" by subseting between two dates
data <- raw[raw$Date >= "2007-2-1" & raw$Date<= "2007-2-2", ]

#remove raw data to save memory
rm(raw)

#install.packages("Rcpp") & ("dplyr")
#Add new column date_time to "data"
library(dplyr)
data <- mutate(data, 
               date_time = as.POSIXct(paste(data$Date, data$Time, sep=" "), 
               template = "%Y-%m-%d %H:%M:%S", tz = Sys.timezone()))

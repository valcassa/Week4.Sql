CREATE DATABASE Ordini; 


CREATE TABLE Prodotto(
IDProdotto [INT] IDENTITY(1,1) PRIMARY KEY,
CodiceProdotto [NVARCHAR](5),
Nome [NVARCHAR](30),
Descrizione [NVARCHAR](100),
Prezzo [DECIMAL],
QtaDisponibile [INTEGER]
)

CREATE TABLE Cliente(
CodiceCliente [VARCHAR](10) PRIMARY KEY,
Nome [NVARCHAR](30),
Cognome [NVARCHAR](100),
DataNascita [DATETIME]
)

CREATE TABLE Indirizzo(
IDIndirizzo [INT] IDENTITY(1,1) PRIMARY KEY,
Tipo [NVARCHAR](50),
Citta [NVARCHAR](50),
Via [NVARCHAR](50),
CAP [NVARCHAR](10),
NumCivico [INTEGER],
Provincia [NVARCHAR](50),
Nazione [NVARCHAR](50),
CodiceCliente [VARCHAR](10) FOREIGN KEY (CodiceCliente) REFERENCES Cliente(CodiceCliente),
)

CREATE TABLE Carta(
CodiceCarta [CHAR](16) PRIMARY KEY,
Tipo [VARCHAR](50),
Scadenza  [DATETIME],
Saldo  [DECIMAL],
CodiceCliente [VARCHAR](10) FOREIGN KEY (CodiceCliente) REFERENCES Cliente(CodiceCliente),
)

CREATE TABLE Ordine(
IDOrdine [INT] IDENTITY(1,1) PRIMARY KEY,
Stato [NVARCHAR](50),
CodiceCliente [VARCHAR](10) FOREIGN KEY (CodiceCliente) REFERENCES Cliente(CodiceCliente),
CodiceCarta [CHAR](16) FOREIGN KEY (CodiceCarta) REFERENCES Carta(CodiceCarta),
IdIndirizzo [INT] FOREIGN KEY (IDIndirizzo) REFERENCES Indirizzo(IDIndirizzo)
)


INSERT INTO Cliente VALUES(002, 'Mario', 'Bianco', 12-03-1986)
INSERT INTO Cliente VALUES(003, 'Anna', 'Rossi', 01-10-1945)
INSERT INTO Cliente VALUES(004,'Sara', 'Belli', 21-07-1998)
INSERT INTO Cliente VALUES(005, 'Francesco', 'Tirone', 02-11-1995)
INSERT INTO Cliente VALUES(006, 'Marco', 'Totti', 12-04-1988)

INSERT INTO Carta VALUES('1234567890','Debito', 2024-03-20, 100.00, 004)
INSERT INTO Carta VALUES('2340567890', 'Credito', 2022-02-15, 350.00, 002)
INSERT INTO Carta VALUES('4530596039', 'Debito', 2025-10-02, 20.00, 003)
INSERT INTO Carta VALUES('987654563', 'Debito', 2023-05-20, 50.00, 005)

INSERT INTO Indirizzo VALUES('Residenza', 'Roma', 'Via Gallia', 00188, '20', 'RM', 'Italia', 003)
INSERT INTO Indirizzo VALUES('Domicilio', 'Milano', 'Viale Buenos Aires', 00200, '310', 'MI', 'Italia', 006)
INSERT INTO Indirizzo VALUES('Residenza', 'Bari', 'Corso Alcide De Gasperi', 70125, '120', 'BA', 'Italia', 004)
INSERT INTO Indirizzo VALUES('Residenza', 'Brighton', 'Street Academy', 4002, '8', 'LO', 'Gran Bretagna', 005)

INSERT INTO Prodotto VALUES('20003', 'Aspirapolvere', 'Dyson che sogno', 800.00, 10)
INSERT INTO Prodotto VALUES('30043', 'Calendario', 'Un Calendario da Tavolo', 5.00, 200)
INSERT INTO Prodotto VALUES('50034', 'Schermo Samsung', '30 pollici LCD', 120.00, 30)
INSERT INTO Prodotto VALUES('9030', 'Asciugacapelli', 'Philips 4W', 25.00, 300)
INSERT INTO Prodotto VALUES('30455', 'Laptop ThinkPad', 'Lenovo Computer Portatile', 785.00, 20)
INSERT INTO Prodotto VALUES('78495', 'Set Bicchieri', 'Da caffé', 18.40, 80)

INSERT INTO Ordine VALUES('Provvisorio', 004, '1234567890', 003)
INSERT INTO Ordine VALUES('Provvisorio', 002, '2340567890', 002)
INSERT INTO Ordine VALUES('Provvisorio', 005, '987654563', 004)
 
 GO
CREATE VIEW Subtotale (QtaDisponibile)
AS(
SELECT SUM(p.QtaDisponibile)
from Prodotto p 
)

GO
select p.Prezzo--10%
from Prodotto p 
HAVING COUNT(p.Nome)>3  
 
 GO
CREATE PROCEDURE InserisciOrdine
@NomeOrdine varchar(50),
@CodiceProdotto varchar(5),
@Qta int,
@Descrizione varchar(100)
 
AS
declare @IDPRODOTTO int
select @IDPRODOTTO=IdProdotto from Prodotto where CodiceProdotto=@CodiceProdotto
insert into Ordine values (@NomeOrdine,@CodiceProdotto,@Qta,@Descrizione, @IDPRODOTTO);
GO



 --Ogni ordine, oltre al riferimento ai prodotti che l’utente desidera acquistare
 --e la relativa quantità, ha anche un totale complessivo dato dalla somma dei 
 --prezzi dei prodotti che deve acquistare.

 

 --L’ordine ha anche uno “stato” che, inizialmente impostato come “provvisorio”, 
 --potrà passare a “confermato” se il cliente conclude l’acquisto relativo a quel
 --codice ordine dopo aver specificato un indirizzo di spedizione e se, dopo aver
 --selezionato con quale carta (non scaduta) vuole pagare, il saldo riesce a “coprire” 
 --la spesa totale.



  --FUNZIONI E STORED
 --iscrizione cliente con relativi indirizzi e carte,
 --creazione ordine, modifica ordine “provvisorio”, 
 --aggiunta prodotti all’ordine, Conferma acquisto.




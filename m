Return-Path: <linux-kernel+bounces-334979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A497DF50
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70AA281F05
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3CF7DA6E;
	Sat, 21 Sep 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Iq5wSdtN"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31720EBE;
	Sat, 21 Sep 2024 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726956275; cv=none; b=RUYWsn4Y8VxJXpNhxaph7k1imTxyYBmzIwOTzltvDHIfOHbLEq0eIdpMOWqqPGzYpls30vQ20Yam+GE6cd5saLwQhxh+luIhKtqi7yRKO93pxlKqZvGDFgB5qe1B3J/53VmCbo9QVPi2z5NKg3L1WY20j9zDrjpqCmfs2NYf4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726956275; c=relaxed/simple;
	bh=+/53jj+UpO74LBrKxvFpEk62+Y1azlF7xuXXd9WPa5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K57nViN1To+ww5o2Pl6ZwvRPAadwU5ga/lwrue6c4J3F579GApB96Lx8MDqXJ+dcNUXBQy8G1J9N6+hGmfA/wHK4i9qah5NcGxXsqKd9uoIbbPON9QNHVJksD8tfzbsh9l5+iVqYs3tMixXZgLm4bnkxlWhW2wO87/KjPu2DNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (2048-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=Iq5wSdtN; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 583E12F2D5A;
	Sat, 21 Sep 2024 23:58:11 +0200 (CEST)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:message-id:date:date:subject:subject:from:from:received
	:received:received; s=dkim20240523; t=1726955888; x=1728770289;
	 bh=lbXmCZEV/t8nONBA5lZliCrm/aSb+rxZyZG+sl2Dhbc=; b=Iq5wSdtN2vFR
	5IY6iNABbYKZzHWqPdctLkOFhjEFJs4m41mmTmpRS/yg7ExjKp8Zc9rMx7tomhiV
	M7QpEabA1mKGVtxDLKZ8a2VQ0UkIfNZFhz/2OUF4X2JmKdDIGDG6o64yjx4HXhWP
	BxY82AVRhm6rIbsdzKBXAewkKNLp8tDiZYbvWcjNa6aNdYzqA9zt8TVSvPbEgmNN
	MsEOJq0LhgdD4OCIV4IHtmgzmt2ls7/Whp/+fdjKcU0nCrq+MDXFAEyeSimViLYa
	/ngzgXu/FYt1SXiSv+SeNfJgevVP3Ouw6cguVSFB/n30ipRBLCL/DDhc86nxeiin
	+dDxfYpnZA==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -0.9
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pKMtM8lv-d33; Sat, 21 Sep 2024 23:58:08 +0200 (CEST)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 3BB7D2F2D59;
	Sat, 21 Sep 2024 23:58:07 +0200 (CEST)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id E688A211D841;
	Sat, 21 Sep 2024 23:58:06 +0200 (CEST)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Davide Benini <davide.benini@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: update I2C summary
Date: Sat, 21 Sep 2024 23:57:29 +0200
Message-Id: <20240921215729.23796-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update Italian translation following these changes

commit d77367fff7c0 ("docs: i2c: summary: document use of inclusive language")
commit 20738cb9fa7a ("docs: i2c: summary: be clearer with 'controller/target' and 'adapter/client' pairs")
commit 1e926ea19003 ("docs: i2c: summary: document 'local' and 'remote' targets")
commit d77367fff7c0 ("docs: i2c: summary: document use of inclusive language")
commit a5b88cb9fdff ("docs: i2c: summary: update speed mode description")
commit 75d148c90a34 ("docs: i2c: summary: update I2C specification link")
commit d18b822c8f62 ("docs: i2c: summary: start sentences consistently.")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/i2c/summary.rst        | 72 ++++++++++++-------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/Documentation/translations/it_IT/i2c/summary.rst b/Documentation/translations/it_IT/i2c/summary.rst
index 1535e13a32e2..99a5b36cfb44 100644
--- a/Documentation/translations/it_IT/i2c/summary.rst
+++ b/Documentation/translations/it_IT/i2c/summary.rst
@@ -3,21 +3,17 @@ Introduzione a I2C e SMBus
 ==========================
 
 I²C (letteralmente "I al quadrato C" e scritto I2C nella documentazione del
-kernel) è un protocollo sviluppato da Philips. É un protocollo lento a 2 fili
-(a velocità variabile, al massimo 400KHz), con un'estensione per le velocità
-elevate (3.4 MHz). Questo protocollo offre un bus a basso costo per collegare
-dispositivi di vario genere a cui si accede sporadicamente e utilizzando
-poca banda. Alcuni sistemi usano varianti che non rispettano i requisiti
-originali, per cui non sono indicati come I2C, ma hanno nomi diversi, per
-esempio TWI (Interfaccia a due fili), IIC.
+kernel) è un protocollo sviluppato da Philips. É un protocollo a 2 fili (a
+velocità variabile, solitamente fino a 400KHz, e in modalità alta velocità fino
+a 5 MHz). Questo protocollo offre un bus a basso costo per collegare dispositivi
+di vario genere a cui si accede sporadicamente e utilizzando poca banda. I2C è
+ampiamente usato nei sistemi integrati. Alcuni sistemi usano varianti che non
+rispettano i requisiti originali, per cui non sono indicati come I2C, ma hanno
+nomi diversi, per esempio TWI (Interfaccia a due fili), IIC.
 
 L'ultima specifica ufficiale I2C è la `"Specifica I2C-bus e manuale utente"
-(UM10204) <https://www.nxp.com/webapp/Download?colCode=UM10204>`_
-pubblicata da NXP Semiconductors. Tuttavia, è necessario effettuare il login
-al sito per accedere al PDF. Una versione precedente della specifica
-(revisione 6) è archiviata
-`qui <https://web.archive.org/web/20210813122132/
-https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_.
+(UM10204) <https://www.nxp.com/docs/en/user-guide/UM10204.pdf>`_ pubblicata da
+NXP Semiconductors, al momento della scrittura si tratta della versione 7
 
 SMBus (Bus per la gestione del sistema) si basa sul protocollo I2C ed è
 principalmente un sottoinsieme di protocolli e segnali I2C. Molti dispositivi
@@ -27,38 +23,62 @@ SMBus. I più comuni dispositivi collegati tramite SMBus sono moduli RAM
 configurati utilizzando EEPROM I2C, e circuiti integrati di monitoraggio
 hardware.
 
-Poiché SMBus è principalmente un sottoinsieme del bus I2C,
-possiamo farne uso su molti sistemi I2C. Ci sono però sistemi che non
-soddisfano i vincoli elettrici sia di SMBus che di I2C; e altri che non possono
-implementare tutta la semantica o messaggi comuni del protocollo SMBus.
+Poiché SMBus è principalmente un sottoinsieme del bus I2C, possiamo farne uso su
+molti sistemi I2C. Ci sono però sistemi che non soddisfano i vincoli elettrici
+sia di SMBus che di I2C; e altri che non possono implementare tutta la semantica
+o messaggi comuni del protocollo SMBus.
 
 
 Terminologia
 ============
 
-Utilizzando la terminologia della documentazione ufficiale, il bus I2C connette
-uno o più circuiti integrati *master* e uno o più circuiti integrati *slave*.
+Il bus I2C connette uno o più circuiti integrati controllori a dei dispositivi.
 
 .. kernel-figure::  ../../../i2c/i2c_bus.svg
-   :alt:    Un semplice bus I2C con un master e 3 slave
+   :alt:    Un semplice bus I2C con un controllore e 3 dispositivi
 
    Un semplice Bus I2C
 
-Un circuito integrato  **master** è un nodo che inizia le comunicazioni con gli
-slave. Nell'implementazione del kernel Linux è chiamato **adattatore** o bus. I
-driver degli adattatori si trovano nella sottocartella ``drivers/i2c/busses/``.
+Un circuito integrato **controllore** (*controller*) è un nodo che inizia le
+comunicazioni con i dispositivi (*targets*). Nell'implementazione del kernel
+Linux è chiamato **adattatore** o bus. I driver degli adattatori si trovano
+nella sottocartella ``drivers/i2c/busses/``.
 
 Un **algoritmo** contiene codice generico che può essere utilizzato per
 implementare una intera classe di adattatori I2C. Ciascun driver dell'
 adattatore specifico dipende da un driver dell'algoritmo nella sottocartella
 ``drivers/i2c/algos/`` o include la propria implementazione.
 
-Un circuito integrato **slave** è un nodo che risponde alle comunicazioni
-quando indirizzato dal master. In Linux è chiamato **client** (dispositivo). I
-driver dei dispositivi sono contenuti in una cartella specifica per la
+Un circuito integrato **dispositivo** è un nodo che risponde alle comunicazioni
+quando indirizzato dal controllore. In Linux è chiamato **client**. Nonostante i
+dispositivi siano circuiti integrati esterni al sistema, Linux può agire come
+dispositivo (se l'hardware lo permette) e rispondere alla richieste di altri
+controllori sul bus. Questo verrà chiamato **dispositivo locale** (*local
+target*). Negli altri casi si parla di **dispositivo remoto** (*remote target*).
+
+I driver dei dispositivi sono contenuti in una cartella specifica per la
 funzionalità che forniscono, ad esempio ``drivers/media/gpio/`` per espansori
 GPIO e ``drivers/media/i2c/`` per circuiti integrati relativi ai video.
 
 Per la configurazione di esempio in figura, avrai bisogno di un driver per il
 tuo adattatore I2C e driver per i tuoi dispositivi I2C (solitamente un driver
 per ciascuno dispositivo).
+
+Sinonimi
+--------
+
+Come menzionato precedentemente, per ragioni storiche l'implementazione I2C del
+kernel Linux usa "adatattore" (*adapter*) per i controllori e "client" per i
+dispositivi. Un certo numero di strutture dati usano questi sinonimi nei loro
+nomi. Dunque, durante le discussioni riguardanti l'implementazione dovrete
+essere a coscienza anche di questi termini. Tuttavia si preferiscono i termini
+ufficiali.
+
+Terminologia obsoleta
+---------------------
+
+Nelle prime specifiche di I2C, il controllore veniva chiamato "master" ed i
+dispositivi "slave". Questi termini sono stati resi obsoleti con la versione 7
+della specifica. Inoltre, il loro uso viene scoraggiato dal codice di condotta
+del kernel Linux. Tuttavia, potreste ancora trovare questi termini in pagine non
+aggiornate. In generale si cerca di usare i termini controllore e dispositivo.
-- 
2.39.5



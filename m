Return-Path: <linux-kernel+bounces-316453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F069C96CFCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6B01F22990
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B1192B95;
	Thu,  5 Sep 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdg/jNFY"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CCD1925AB;
	Thu,  5 Sep 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519242; cv=none; b=rdnN7f7Nos4gOVyO3q5iz3H0P3CnBOcM7dxAORl18gjLI44yAT6XN0Mw0H5uLqJVtI677/LUdZtHGBCyFpugsioPiwzBniDQ18j1fzaC9q3rCpr64y8YlTGqEJtWeHArKPjbJUBSHlfNkMLmrR0u/BlRSAK5jHQopANUdApj37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519242; c=relaxed/simple;
	bh=mZRLfsoTsU7RqYQ4BVH0C6KZId6ilapJ4zMKhdniZvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZKlfiLa27kSTfspzuG5aXHrwaNHc24vxAzBMfTbchAkWFSjbFv3s/ztWfUNpwCckh4D8oSXfmgRlyS9eRuOzXP6qdgq1Qmm3Kvp0zFzktQYzYX85T5vNXIJRa1NIBC9NGqqV7KndlDxju60aJedJ50fOF5ofqo59ANm0Fw3PZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdg/jNFY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c7d14191so792543f8f.0;
        Wed, 04 Sep 2024 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519239; x=1726124039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCjj1MmwVfCqD13mxvraZ2zXL+q3ngdxrGAIeYR3F0g=;
        b=cdg/jNFYVw/M7AwblonFdAVT4VECpP+242YoNYYQ7jZj1gjsG6O4DdQZTXGFnIwP4O
         55gsUkLvX+qMw8Kdj/Eq/q+vBb13CM6bVjgF5CUVomIEFf11QNQ1gNSJD0oo5GXuIx0L
         rhiHxp5g5lKENxnzmr1OBReD03QBZaHM7nHZL+nkprwQ431iGvz9unP9yxWN3QVcaRNI
         k5aybipoW1do8tuN0kuUJ2xSiKq9DobJaKjEPJr3RQFrbpYmoVjFTFZ72uPVrEMkHv/v
         fAiYMwbBZUcZzTQSlgoHvHeM7dG1NsmGvT31NPLq92Ico4HiD5A/DqeWZaWOT0Af2j+X
         HhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519239; x=1726124039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCjj1MmwVfCqD13mxvraZ2zXL+q3ngdxrGAIeYR3F0g=;
        b=aatyUhDdjR//D2p+w0pq+kuT1nQ7Ic6qCQVjVBbpp9hair8+K76ecEqhQei+btUH4E
         At9Xjg0rt9/qgUvzQurov1F46ssyyXcZ+m4YO6pJ+6h7wre9gt2hEMCmgjcOXSZ1jCln
         QqvLy+JwoUY2gBieEfp5oxwRfxdhL0lpL6Pv99w+c97XI+Bv5SytguhUsRRw0eS2bADy
         41L7FufX2wAlJgvEL2z+x3QQpBT/fFWzUgkIDhS3m1cmUyleUQjluwPxUnoNHJHOLuDL
         qixph4f3lBnSorl10nP9VsX3Dt/pS8iBFYzzwygT/ebWw03vtXWgeDivDwT5/0QaHICA
         2myQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd3WycqaI6O/ZyMvUs/Q0GTXkDmErqQ6c1VoC9cP2XdpZ8UNJaFwQPS4SYWYNyFIeuhiTM2GLvDhJDaks=@vger.kernel.org, AJvYcCXjfBbjMWivlFXbdXQr0EumBjMlt028LmRnfUMgXao6T8RPZ9AA+QZNurPDUgG+LU9PG9qf1sjDOofi@vger.kernel.org
X-Gm-Message-State: AOJu0YzjR/RwyElojECChnnozTL+G3Pk6M9iq2BtPD6UireogR+eWs6e
	i9ZaY24AiC3NumKplu1g7AwukBM3phKJuv7sjJoY5FFmKbhrlkil4p2Z2Wzn
X-Google-Smtp-Source: AGHT+IErccV2CysyHRgiNDDFiw4dBuj9LX2wPliTjWA6NMRCisM65fOVBshxyzcs0/IgTdNcQU1Yrw==
X-Received: by 2002:a5d:440e:0:b0:374:cd15:c46c with SMTP id ffacd0b85a97d-3779a6129b6mr2562748f8f.15.1725519238869;
        Wed, 04 Sep 2024 23:53:58 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efb14bfsm18421552f8f.104.2024.09.04.23.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 23:53:58 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: [PATCH v2] usb: typec: tcpci: support edge irq
Date: Thu,  5 Sep 2024 08:53:28 +0200
Message-Id: <20240905065328.7116-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

TCPCI USB PHY - PTN5110 could be used with SOCs that only support
the edge-triggered GPIO interrupts such as TI's K3 device AM69.
Move the interrupt configuration to the firmware which would
allow to accommodate edge triggered interrupts for such SOCs.
In order to support the edge interrupts, register irq line in advance
and keep track of occurrence during port registering.

When the edge interrupts are used, it is observed that some of the
interrupts are missed when tcpci_irq() is serving the current
interrupt. Therefore, check the status register at the end of
tcpci_irq() and re-run the function if the status is not clear
i.e. pending interrupt.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
v2: Re-enable irq irrespective of tcpci_register_port() return status which was disabled before this call
---
 drivers/usb/typec/tcpm/tcpci.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index a2651a2a7f2e..ed32583829be 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -707,10 +707,13 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 {
 	u16 status;
 	int ret;
+	int irq_ret;
 	unsigned int raw;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
+	irq_ret = status & tcpci->alert_mask;
 
+process_status:
 	/*
 	 * Clear alert status for everything except RX_STATUS, which shouldn't
 	 * be cleared until we have successfully retrieved message.
@@ -783,7 +786,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 	else if (status & TCPC_ALERT_TX_FAILED)
 		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
 
-	return IRQ_RETVAL(status & tcpci->alert_mask);
+	tcpci_read16(tcpci, TCPC_ALERT, &status);
+
+	if (status & tcpci->alert_mask)
+		goto process_status;
+
+	return IRQ_RETVAL(irq_ret);
 }
 EXPORT_SYMBOL_GPL(tcpci_irq);
 
@@ -915,20 +923,22 @@ static int tcpci_probe(struct i2c_client *client)
 
 	chip->data.set_orientation = err;
 
-	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
-	if (IS_ERR(chip->tcpci))
-		return PTR_ERR(chip->tcpci);
-
 	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					_tcpci_irq,
-					IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(&client->dev), chip);
-	if (err < 0) {
-		tcpci_unregister_port(chip->tcpci);
+	if (err < 0)
 		return err;
-	}
 
-	return 0;
+	/*
+	 * Disable irq while registering port. If irq is configured as an edge
+	 * irq this allow to keep track and process the irq as soon as it is enabled.
+	 */
+	disable_irq(client->irq);
+	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
+	enable_irq(client->irq);
+
+	return PTR_ERR_OR_ZERO(chip->tcpci);
 }
 
 static void tcpci_remove(struct i2c_client *client)
-- 
2.34.1



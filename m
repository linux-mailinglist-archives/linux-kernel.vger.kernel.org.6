Return-Path: <linux-kernel+bounces-418793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15699D65B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AC72822FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13AE1DFE23;
	Fri, 22 Nov 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lBBNAMA8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0218FC7C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313829; cv=none; b=ljapSQOLQau79h14kL4uRt7cfPPx1zRj6iV8gLjFKbDqddx5g1PYxR+QLz5TG/2y1PucIJTeeuJV9yg2qptbpV6aMdCeDDyfh4PzwlS3me9w31iSQVE0x7I4+c5kFp9snb7ASvLNem8s/0KXOl5pdJlWlAvtMzk7TQfuW3mzsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313829; c=relaxed/simple;
	bh=aZI6nysz82pEP0emeVa6kVzsEW4+gM9gju+4YJnXy/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkvuA1TnmLFr83K2rHtV93BHBc0hxSy3iCK7hajm0pFgrdN+QjdNCbQU+giwqyQ2hdqIslR9BwnWNpLNilCyCxuXB2bX0YtwsBgSIOvR9cBf2mFxS7OXIFOrJ6tXBzgQZgz1u2fzdzn2/CAblLPFlIpdwWSnve/00lu4rgJxHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lBBNAMA8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so4728390e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313825; x=1732918625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlpDyiJR/k7vKSJ97gJNXRm8erHzYQsibasSD5BWwAI=;
        b=lBBNAMA826kS2z6gmmowxrqiHnksOIYc2O+jiPjTFWkgOdb9EZl+Dc6RmuCjTtn3o7
         7vDxWpwjwbwty5GO40i4ot38fHM+XcUCtBLYsENSBpZXXEcMMd/fwNRi6jsYMn5T0Wzq
         4+OpEMMgkgWU2/W9kl1d6tTS6h713own8F92k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313825; x=1732918625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlpDyiJR/k7vKSJ97gJNXRm8erHzYQsibasSD5BWwAI=;
        b=HRIbL+F6peGEhLjqPgFM5wQaI+YImlKRlZxZ+/oMY3irLjoj7cpnOBrdx5zdj8yq0J
         8Q3eAMkzKV9+vcnMFYomSg13eggqPw2aN862gmgRDoWZqweyHosYy/aKC6RI4IKOJMZF
         kuVpQvNmEGkzaIf5tl7nDgfJZyjAo/GR8VnUTb9RnyKmZSyDnA6N/bbsouB45QnF96XL
         vw0p1kLQ1M6oLgi1cUZay5LK7EtMJwmVMHTfknVYCrBSW5f2XS6snw6EvyxXAU7Ep3ao
         V8O5hy29RiysN7wKgn0KHI9iXXNzTnU9xLiaMRyTTvr5jiU7xA1pD1g4eQNq0yQADe9k
         n/UA==
X-Gm-Message-State: AOJu0YxO1lPz0OPSOpUNC8W46/ffPHCVs0/mXJoMuu/9SXJgjiujQVEA
	c57yjXDM/DjrQ09Q2c4yza8CeTujf4NkynR0sxFWs5Kz78OYLs78ce0vvdAeZQ7ivlP5i4XpdKZ
	W
X-Gm-Gg: ASbGncvBnbAA7XEtd8OUM1q9VVbNpwqEHt46Rx2QyskDFa0Fqg4C+oFqEJyaY0eyilQ
	SuXPXcIavX/Fd4/Tgjq7SYoo06qs6/0hJI1tKBzENeZkk3eaCD6jQTMzkpmfP/QEaB/L8rjKlyd
	fKmWBEtISdabhMlrfzBVjvm/t3qlaU68nghd/hQ7AsH9m0FsF92umktJ8W4gl2snDEv0UKzLawK
	vTE4mXWIWK7YYnvwgoTaNiUF7Qbb9TG936u2IawMGb13OmWYJiXHnLXmdrWhZvG0KxweAHrFoS2
	Nee8Alm1W31x29hTvvYnZYcDJ8bRG89M4Lpg6bnLdywxAdjN4F8rQaQcSTWhaG9Ucq4T6dgNbHD
	MWP+TD4P2ECeYCqhG
X-Google-Smtp-Source: AGHT+IFM4zz1P0zcbDlpIS0RlDY0cn+D//lyH7aVLQCevJCESOfOR94A0A1KmXqMkwxRcXzDyP6m0w==
X-Received: by 2002:a05:6512:304c:b0:53d:da89:a491 with SMTP id 2adb3069b0e04-53dda89a8abmr1706753e87.10.1732313825233;
        Fri, 22 Nov 2024 14:17:05 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 09/12] can: sja1000: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:50 +0100
Message-ID: <20241122221650.633981-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sja1000_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. Increment the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/sja1000/sja1000.c | 67 ++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ddb3247948ad..4d245857ef1c 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -416,8 +416,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	int ret = 0;
 
 	skb = alloc_can_err_skb(dev, &cf);
-	if (skb == NULL)
-		return -ENOMEM;
 
 	txerr = priv->read_reg(priv, SJA1000_TXERR);
 	rxerr = priv->read_reg(priv, SJA1000_RXERR);
@@ -425,8 +423,11 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
+
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
@@ -452,7 +453,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (state != CAN_STATE_BUS_OFF) {
+	if (state != CAN_STATE_BUS_OFF && skb) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
@@ -460,33 +461,38 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		ecc = priv->read_reg(priv, SJA1000_ECC);
+		if (skb) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-		/* set error type */
-		switch (ecc & ECC_MASK) {
-		case ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			break;
-		}
+			/* set error type */
+			switch (ecc & ECC_MASK) {
+			case ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				break;
+			}
 
-		/* set error location */
-		cf->data[3] = ecc & ECC_SEG;
+			/* set error location */
+			cf->data[3] = ecc & ECC_SEG;
+		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
+		if ((ecc & ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
+				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
+		}
 	}
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
@@ -502,8 +508,10 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		netdev_dbg(dev, "arbitration lost interrupt\n");
 		alc = priv->read_reg(priv, SJA1000_ALC);
 		priv->can.can_stats.arbitration_lost++;
-		cf->can_id |= CAN_ERR_LOSTARB;
-		cf->data[0] = alc & 0x1f;
+		if (skb) {
+			cf->can_id |= CAN_ERR_LOSTARB;
+			cf->data[0] = alc & 0x1f;
+		}
 	}
 
 	if (state != priv->can.state) {
@@ -516,6 +524,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			can_bus_off(dev);
 	}
 
+	if (!skb)
+		return -ENOMEM;
+
 	netif_rx(skb);
 
 	return ret;
-- 
2.43.0



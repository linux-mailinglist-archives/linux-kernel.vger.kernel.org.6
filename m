Return-Path: <linux-kernel+bounces-418791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F499D65AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC36816163E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7C18DF7F;
	Fri, 22 Nov 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mspf45Y3"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DB189909
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313825; cv=none; b=A87uVNwzbtWX6kwr7tU6yIUYAWFCsYebVZtH8+mahNdG3aqV7FzX9blq3Y2A9Hj7+Rlkt+6j9LouDVvv/nPQ/1cyHGFpiHeL1xAifrV5b6msaT8AVRBjtbseGl5rUzFp5+k+lX3xJNx3+i+42JY0YSFYrkkx1bBr19zRkWZzP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313825; c=relaxed/simple;
	bh=Rrn1AFRXusH8eqUoUkll0VoT1Qat1qd0XiiLbWvCoAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2uaqUicziiuIUVrAqzr7RWZX71+o31XerdS2kLWuGNrMztx8YiQO+0sPupGDzsPxolap2aLfxOVtSPxpIFX2WEX5pskAZDsh4AzXLN3duvzxB4jwXp8VrBX2KQHCiudIWLSpeTo+P6n8OH78/5HxUJEr9Fh1DR+K2nH9J8l/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=mspf45Y3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed49edd41so421322366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313822; x=1732918622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTITGD97t4sTBt1UReGjyzt5Hepohw9TTIeQjkSL1bk=;
        b=mspf45Y3VFa0f8wT0j0QbfpXdDBWZ6rkOkyLUHjLfsmLW6CIHmBa3XBHqCua94bfer
         sYdmOMt3hQI4jjQRvSVKQGvoGiYPzHjfLsyzojxF3cRdaZO02wMxrPUMAR9bdDZ6pbTq
         E5BJkBnf5LbWVYclZMdQWDTWv4k3Dmc9x0U9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313822; x=1732918622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTITGD97t4sTBt1UReGjyzt5Hepohw9TTIeQjkSL1bk=;
        b=DwG8X5/2nNtS/KF2aarOrgPNl+6jStQDzea2bbLcFE7mF58I/S1uO9JDwHIXfFA6lj
         502rxGa7NSHoHcixoETes5MpxYNvlZ1ADgxiW7FkNS2nJfD28m5uCBEJC+ZIrIHeB/05
         uV7AwLonlWQCMb/oVmq1cd/0oYPMJiYcvHDeGcuLZ6ytOod0bqfLmxLtPt6cOkBU827r
         edmqlRhjznP4owF/tXLpAs0MGdVr1wdSxBg7Ak2oi3skNLllSl+g87CZ/e/xe19bJ+6/
         3zehJNk57biJtLuuZ4Rih7CLHgKuBxy4kLh6auvN9dQ2BTspOgHDVwpfapoyNB4/2gIR
         C3CA==
X-Gm-Message-State: AOJu0YxmbMfPbS92D+BbgpOkQCt4oxJRiuc09V74frOmRgBvvM7Dlbgs
	SAbiNVziw3AOX7C54kt8EZ1jqyztO/jr1RRKdkQNvjWLdN6tyOWlPWs7f54EJzXsLKrskaMqEzi
	8
X-Gm-Gg: ASbGnct8jb+Du2MIob+mlAk1KbSCc1kUY3ls+15K/px/Ay5VAhZvlMyYRdpsfSp5G2N
	GWeTCz0GX/RJYttaeA8MZF5Go7acD91O4voej2CliHkTXrntsm/Lk9ut5Qjd9uyyy71GuxoUCWB
	UD36UBUbGXFvUaUilOAoQCV1DqTjf9KgBBGpYTnZS2zG2jzDv0yF+bS5wliCpqsHwm2hLLDxCkA
	pv7i7aDTVyu1tWR2qbnHP9J7qLigEx3FM6YFyjhquJGAPfyZG++HKWoTco5gXxSvEDrTVXZQ6hU
	4oZSgHIS+w1DCkDXJU0lclNeD11lTEkounQ2FySf6r13R0eht4mXl9rvmENRAF0ASCHKb3YsD82
	uXHpVeG7hfvnxQP/g
X-Google-Smtp-Source: AGHT+IHbM7QtSLpq6Jm5tbJClhEmvEjJ+YBVaxImxk8/xeULO+0XP4nXtO4pVvN7FtMdUZSx0Yc92g==
X-Received: by 2002:a17:907:7809:b0:aa5:11fa:6271 with SMTP id a640c23a62f3a-aa511fa6405mr324012266b.49.1732313822235;
        Fri, 22 Nov 2024 14:17:02 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:01 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 07/12] can: ifi_canfd: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:48 +0100
Message-ID: <20241122221650.633981-8-dario.binacchi@amarulasolutions.com>
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

The ifi_canfd_handle_lec_err() function was incorrectly incrementing only
the receive error counter, even in cases of bit or acknowledgment errors
that occur during transmission. The patch fixes the issue by incrementing
the appropriate counter based on the type of error.

Fixes: 5bbd655a8bd0 ("can: ifi: Add more detailed error reporting")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/ifi_canfd/ifi_canfd.c | 58 ++++++++++++++++++---------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index d32b10900d2f..c86b57d47085 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -390,36 +390,55 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 		return 0;
 
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* Propagate the error condition to the CAN stack. */
 	skb = alloc_can_err_skb(ndev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* Read the error counter register and check for new errors. */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST) {
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST) {
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
+	}
 
 	/* Reset the error counter, ack the IRQ and re-enable the counter. */
 	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
@@ -427,6 +446,9 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 	       priv->base + IFI_CANFD_INTERRUPT);
 	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
 
+	if (unlikely(!skb))
+		return 0;
+
 	netif_receive_skb(skb);
 
 	return 1;
-- 
2.43.0



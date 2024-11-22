Return-Path: <linux-kernel+bounces-418792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1B49D65B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF55916128C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D231D12E0;
	Fri, 22 Nov 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hdm4jwGS"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7171DEFFD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313827; cv=none; b=ZGO51LmPkiI+DIDUu2pfBvs4t482Ch5vzi+uVpwO4TgnmgS3vu1EGlOotmnGw1WDCGHduwdyPhKR90VxnkrvSEiu8hDpBv3ERLkVuRAvbbmLrACuQFKKPN2Pmd3qf9AKJyGwMUY2R2PobIjMDS14zP2hMO1j1Wc6utT92GjfY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313827; c=relaxed/simple;
	bh=RCHjtrDYGosX7hVMEeF0eEIsFG3i6FYsIXt5jHBzeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXY2tp749EComaB1p1ihaMsDCJoWM9R764hdOQBnPOuhiFtDTW8mmboz2nt8UB0NQSLBpDu6BV4Vi0l+bhqGs8ok6bMbMdnA/zJ40BafZm9aY0kANNLB4jwbxvg18Hkb1vPFw1e5AJTpVUopQ6wxAqb8eOWZWguRjiiNT6482+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hdm4jwGS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f2b95775so3948483e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313824; x=1732918624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgKjVRJAevY3wmDGnu8dG/wFQ+or5hcDk8y0qLVlEgA=;
        b=hdm4jwGShUM5EpuT17WLUC5TaTdkPsrZvQJHP0hea3mFj29mEQySrAFxa7ix9l56aM
         z33fRn4Jwk2HoOt1z5cRKYXzU/SYVrU9cba3K8KXrPRcdSKT/JzF4ZhJrCdwdY7bN0TD
         OgR8WROyHvWPjHmtyb4G9BdCX1yjvuwLf903M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313824; x=1732918624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgKjVRJAevY3wmDGnu8dG/wFQ+or5hcDk8y0qLVlEgA=;
        b=G7SCYaY7zv5ZU0liIw4hJ1ZCTfR/g4wIpBIlb2nVt4ii4m794YX25oipw+/J8qoroM
         KH5KewHDDMuW4BvxVW4EmXF2cbnLI6ZuAa8uj3q3V71n/OQWIAW2NMDoc48xx4nkZEhP
         cOhj3wONWR2wcO6QHgq30dIy+EepY4t5uAPR08IBhJwl6z16WI8sDYsfFKFYzEcF0LxS
         OZ+1m6ZjJKsZ+UH1lG05MoaySEM2fuhsxPT9DH3w0wD12YEwf4kfu7yNytOvO+za5LwL
         /EMW4xBDJdTSvCprYWyM7YvJPi5ZfTgDAZj/ev357Vehtp5IfHO+ubtYj2KKQ5+lA1PA
         YfaQ==
X-Gm-Message-State: AOJu0YwXkHQnbgEgI5cNURkD8Y8vvr019fJ3Mkfxk/hs1kIHG02ucxMz
	jHvOJ7Fh8+CJhrO/9ZFYes7p2diF6ltVy4Od5ouD9eR6XxCTJo/LPML3O5opWgySHAugRt3RqTZ
	w
X-Gm-Gg: ASbGncvcCAK1iD6gMCSSMPcivBcJei8HFFexCYa5ClrdHv7UwqFCEyIlDD4yip9MxO5
	r7jgagUdeXvTpve0zF5NikbeL2OF1WSUKSbN+W+KZacPYOsYphF4EyGKmx02AZfX4QkUg563Z67
	EwFNgqM8t0DrAO/q+jWeVUUcZsc3tHiQzJUWiJ4vOef1fN5EhM+Oz4PojR19le1zKUhh+al4aqn
	Fkk6swwo4LNld+zmHXYMyvUCJVfNF9oxuNrEps3ZlXb/YohlyGm0CfDBEdc36KDBCWniyxGuWYR
	/MGPyddvYP/BOOZ2NN9CrBw2RyU0479UU04b1XirbqwWt+zOMRicR+XUUpXvS+xpqUkoEqSQGd/
	7XweeDbVLQ4UiDf6v
X-Google-Smtp-Source: AGHT+IHZ/ABLxFIVbFLFvSrsmgIkf3PgZHq1H1ox1bPhmgDf7xN30T44QnNfRAPsf4/UWKxgOeMrTg==
X-Received: by 2002:a05:6512:b97:b0:53d:a2cb:1350 with SMTP id 2adb3069b0e04-53dd369f458mr3917868e87.17.1732313824154;
        Fri, 22 Nov 2024 14:17:04 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 08/12] can: hi311x: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:49 +0100
Message-ID: <20241122221650.633981-9-dario.binacchi@amarulasolutions.com>
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

The hi3110_can_ist() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/spi/hi311x.c | 47 ++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 25d9b32f5701..09ae218315d7 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -696,27 +696,38 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			/* Check for protocol errors */
 			if (eflag & HI3110_ERR_PROTOCOL_MASK) {
 				skb = alloc_can_err_skb(net, &cf);
-				if (!skb)
-					break;
+				if (skb)
+					cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-				cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 				priv->can.can_stats.bus_error++;
-				priv->net->stats.rx_errors++;
-				if (eflag & HI3110_ERR_BITERR)
-					cf->data[2] |= CAN_ERR_PROT_BIT;
-				else if (eflag & HI3110_ERR_FRMERR)
-					cf->data[2] |= CAN_ERR_PROT_FORM;
-				else if (eflag & HI3110_ERR_STUFERR)
-					cf->data[2] |= CAN_ERR_PROT_STUFF;
-				else if (eflag & HI3110_ERR_CRCERR)
-					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-				else if (eflag & HI3110_ERR_ACKERR)
-					cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
-
-				cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
-				cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
+				if (eflag & HI3110_ERR_BITERR) {
+					priv->net->stats.tx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_BIT;
+				} else if (eflag & HI3110_ERR_FRMERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_FORM;
+				} else if (eflag & HI3110_ERR_STUFERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_STUFF;
+				} else if (eflag & HI3110_ERR_CRCERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+				} else if (eflag & HI3110_ERR_ACKERR) {
+					priv->net->stats.tx_errors++;
+					if (skb)
+						cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+				}
+
 				netdev_dbg(priv->net, "Bus Error\n");
-				netif_rx(skb);
+				if (skb) {
+					cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
+					cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
+					netif_rx(skb);
+				}
 			}
 		}
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-520746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6AA3AEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5DD16C8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E06E132122;
	Wed, 19 Feb 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcfdCKoH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F47081D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927432; cv=none; b=nz1sh5g6puAp9BwD66ZemMwFmr9vEx1dqVzfMaT2qMQBQlXZTd5CR218jr0d44TzvErS1gHJw1GU3HcVK5dA520CCndj/E1GZSrMtg+W0TuWW4ikhB+3Jd2fjH6ZHufpnKk0drby8VRwYVCAMmPml2kai61bEsU2bC6d+F4YQw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927432; c=relaxed/simple;
	bh=RtQbQlItwsvYyAN+RFPRuN3sJ2hAVTgTiPu86K3Nfrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvRo1q9bqhMjt0kmiAnODjhVQ0eIYA3iA9JmtmrcHrBk2JmrC0S1trpm74JnC/HDQ65d/Dt6GmOjmQDWmfbqy29kISVpeVkcm3zTBY/FCnHsBFcjDBVw1WojDs4y+RcGqYfzhu8yYooGQJAUt6SHfdW6OWG7W0k8Oztkk7li8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcfdCKoH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2210d92292eso95930595ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739927430; x=1740532230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQfECy+M8cSWsoOJoFSA8ondIMCqsdotHgkIf8xUcO0=;
        b=WcfdCKoH3c0J6jKriLelBkfg1y18gV235IbjB+u/wsczX4H+wkS1phu7ROjwBCUxyN
         hdkhv+ywJN9peDNT5542yd1JH4D74Wi03RKd/nK57mzPUjbjEJRyPjJftyZpLlrCgvW+
         9ENRqGSTSXeiIZGcQaBrRMUNFTUokabf0glzBWbD2No7IsPeH2cz8aebcS8YExWfCp9n
         VVHg8z3zp0p8W5qa8T0JfY53iQn82PJjNIGa6KUkWf9rRFtzweqtY/UGAlJKwTcxDKuc
         fPk2Bckl3/wmQ/7GP4ezAEhzeLHOoLr0+JS9EvkobaQvoRwhbbgfZDxjdwj76tz9V/ES
         5lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927430; x=1740532230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQfECy+M8cSWsoOJoFSA8ondIMCqsdotHgkIf8xUcO0=;
        b=FfupWVwoBnar2PgnQjNJqGyBo5//hoyIqLGD/cHs/pnzL36WV3ExvEIlENFCEiMjwm
         qg19ZTrtNqWR4lOMPhRMVf4uS0N1guwyj2bbqJih6lzuzwoQs+YTK5+60+yNmCbn/Mm6
         6lYw2JqlrngV39i5hnNJAXNu4R1p4ogFsxg9c8HMbPoRS8ZDLy7T2qnBr8yzGLZbypE7
         CctPUhS4YFAP1r90mIKdNEnl5CLyfC3XWnyv6g5YPOH17Xb5GpY2KxbJbZ9DDZ+5jVCl
         SPyc0IMgxBOmEywGEEYm81huPToKMFsD8g0rky8EJFj3wpfGy4nKzc0NhLQxTfav4as9
         V9/A==
X-Gm-Message-State: AOJu0YwSQTKTbGPgWwcjGt9f1m71TXpqlt/Ynr9+TcRCAKdhKrRWcfgX
	8ipW0WMvI0qwJksje+PRCTCp5dgxDIp0Rk9wm97BbEczhycGxWFH
X-Gm-Gg: ASbGncvRnmkJhk2kKXsc8OnBSfrM5+oD+AoM7q6ZKOYe13ChC16aXbqi6tlEkCt6vbb
	yB8Pv9jQ69aYqJ57FjiqM3QJndz98bDqX+HAUeT40Fj1ZqC/0E5xqT7vf0+5j68qeGQ3cuFQYBx
	HtIrTPXxStx/1NLIoGkQg/KeXVkWl99P2Y8+buxE6fUmapbVA6JFTfJ4iOdOCndP2/3E6lq/bjX
	UefB5gKd71V83HWe/lc1ylT6t1rGOtq3VKto0aM+lOnQH0TcUoLx/E6ud8tFbhY1V9KeOFM4HpI
	DmZtl50wqAOZFdkKj1sOhFsyaw==
X-Google-Smtp-Source: AGHT+IEjPOF9KSTzI2MsQxcir5evnluJM/uTeYqKNUB3AIj9hbsInSCZPHWIGW6siNdjzcinklyF0Q==
X-Received: by 2002:a17:902:e84a:b0:220:f87d:9d5b with SMTP id d9443c01a7336-22170988bb4mr27863125ad.24.1739927430304;
        Tue, 18 Feb 2025 17:10:30 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f05sm96080315ad.2.2025.02.18.17.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:10:30 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 2/3] i3c: master: svc: fix npcm845 FIFO empty issue
Date: Wed, 19 Feb 2025 09:10:18 +0800
Message-Id: <20250219011019.1600058-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219011019.1600058-1-yschu@nuvoton.com>
References: <20250219011019.1600058-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

npcm845 HW issue:
I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but
the first transmitted data bit may have the wrong value.
Workaround:
Fill the FIFO in advance to prevent FIFO from becoming empty.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 58 ++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 813839498b2b..22cb1f1c1fdc 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -102,6 +102,7 @@
 #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
 #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
 #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
+#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
 #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
 #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
 
@@ -133,6 +134,16 @@
 #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
+/*
+ * SVC_I3C_QUIRK_FIFO_EMPTY:
+ * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
+ * when new data is written to FIFO, I3C HW resumes the transfer but
+ * the first transmitted data bit may have the wrong value.
+ * Workaround:
+ * Fill the FIFO in advance to prevent FIFO from becoming empty.
+ */
+#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -216,6 +227,7 @@ struct svc_i3c_master {
 	struct mutex lock;
 	u32 enabled_events;
 	u32 mctrl_config;
+	u32 quirks;
 };
 
 /**
@@ -891,6 +903,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	unsigned int dev_nb = 0, last_addr = 0;
 	u32 reg;
 	int ret, i;
+	u32 dyn_addr;
 
 	while (true) {
 		/* clean SVC_I3C_MINT_IBIWON w1c bits */
@@ -931,6 +944,15 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
 			u8 data[6];
 
+			/*
+			 * SVC_I3C_QUIRK_FIFO_EMPTY fix:
+			 * The TX FIFO should be ready before the TX transmission is starting.
+			 */
+			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
+			if (dyn_addr < 0)
+				return dyn_addr;
+			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
+
 			/*
 			 * We only care about the 48-bit provisioned ID yet to
 			 * be sure a device does not nack an address twice.
@@ -1009,21 +1031,20 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (ret)
 			break;
 
-		/* Give the slave device a suitable dynamic address */
-		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
-		if (ret < 0)
-			break;
-
-		addrs[dev_nb] = ret;
+		addrs[dev_nb] = dyn_addr;
 		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
 			dev_nb, addrs[dev_nb]);
-
-		writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
 		last_addr = addrs[dev_nb++];
 	}
 
 	/* Need manual issue STOP except for Complete condition */
 	svc_i3c_master_emit_stop(master);
+	/*
+	 * Dynamic address is written to FIFO in advance for SVC_I3C_QUIRK_FIFO_EMPTY fix.
+	 * Flush FIFO in the failed case.
+	 */
+	if (ret)
+		svc_i3c_master_flush_fifo(master);
 	return ret;
 }
 
@@ -1210,7 +1231,6 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
-
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 		       xfer_type |
@@ -1220,6 +1240,22 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
 
+		if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+			int i, count, space;
+
+			reg = readl(master->regs + SVC_I3C_MDATACTRL);
+			space = SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(reg);
+			count = xfer_len > space ? space : xfer_len;
+			for (i = 0; i < count; i++) {
+				if (i == xfer_len - 1)
+					writel(out[0], master->regs + SVC_I3C_MWDATABE);
+				else
+					writel(out[0], master->regs + SVC_I3C_MWDATAB);
+				out++;
+			}
+			xfer_len -= count;
+		}
+
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
 		if (ret)
@@ -1308,6 +1344,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
@@ -1877,6 +1914,9 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	svc_i3c_master_reset(master);
 
+	if (device_is_compatible(master->dev, "nuvoton,npcm845-i3c"))
+		master->quirks = SVC_I3C_QUIRK_FIFO_EMPTY;
+
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);
-- 
2.34.1



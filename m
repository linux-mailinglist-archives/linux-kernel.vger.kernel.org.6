Return-Path: <linux-kernel+bounces-388498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F79B606C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848651C21349
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370091E47A9;
	Wed, 30 Oct 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bz9mNLCz"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426B1E32DE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285248; cv=none; b=CtNxQ9zMLpa5BQ4ZTIcpqMuIzjK+QwGS37tsE99cWXxzKWSIsGJJTMZKGsgzIr8tGsFwKFd028MHeeFz5D+o8DojzUN9lp2qQ/VzMgWGfX8HXIW0hcfWO1mmd/nOq6GOM/KMO+yDcS0piAP/f4krTIwW/60LMHMAjjhG2i0aylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285248; c=relaxed/simple;
	bh=WXAmA0b3w0csoNcyu9bCVZFa+7i7lNSgINUAn3ZBIrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jstpj5j1BklnbiMFQp57o2lekrCFlPAsZ/5zKGLRgPYoo50Hduw6QQbyPjDCpQTJGqS9pS6NTxQ7Ard+mMpKqH7DOPjMAipNOEdAlhA6CSJcme+clxVBqeYcI9R99uM9u+Gi4sjHW7Um69PGsSMSnlU96g5WN0IjYg/bkPTl2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bz9mNLCz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7836AC000F;
	Wed, 30 Oct 2024 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730285244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYar1NhwlaSFetKjtJnCr/NEvl6DqNyF39VHto9LoRE=;
	b=Bz9mNLCzNjVoBUuvBwq86R9NoQKickHBphpyvI+UHXmYYqBnyNQ0+kcz8wIC5Zze8QTw4j
	/5DfqrdPFzh+4N471vdi6aBtohM5v4d9/Fi7QcMWN6NqC/gq+PD8a1RGH5l6rgNMge4CLw
	8EBcjZwNzCwTvHr+18F+cLY2bo0Mk/5NDBVeLSExVO5Agl34c1FG/jby4FHOZSaV6H8Bkb
	8n1A655pt4X9kndt/0Rw29QLyKe/rsXEzQ5cIDgJc0fgG0kYXWASU6RJa5XmemXBSNQkce
	l4H8A31LGmt5GAKl1lpjWTpCca1L7ttg+9TIm+eZn3Z/L+uEUdGoOAnwmGn8sw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 2/5] memory: ti-aemif: export aemif_set_cs_timing()
Date: Wed, 30 Oct 2024 11:47:14 +0100
Message-ID: <20241030104717.88688-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
References: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Export the aemif_set_cs_timing() symbol so it can be used by other
drivers

Add a spinlock to protect the CS configuration register from concurrent
accesses.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 35 +++++++++++++----------------------
 include/memory/ti-aemif.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 22 deletions(-)
 create mode 100644 include/memory/ti-aemif.h

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 5be6df246075..ee857c16a02c 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -17,6 +17,8 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <memory/ti-aemif.h>
 
 #define TA_SHIFT	2
 #define RHOLD_SHIFT	4
@@ -107,27 +109,6 @@ struct aemif_cs_data {
 	u8	asize;
 };
 
-/**
- * struct aemif_cs_timing: structure to hold cs timing configuration
- * values are expressed in number of clock cycles - 1
- * @ta: minimum turn around time
- * @rhold read hold width
- * @rstrobe read strobe width
- * @rsetup read setup width
- * @whold write hold width
- * @wstrobe write strobe width
- * @wsetup write setup width
- */
-struct aemif_cs_timings {
-	u32	ta;
-	u32	rhold;
-	u32	rstrobe;
-	u32	rsetup;
-	u32	whold;
-	u32	wstrobe;
-	u32	wsetup;
-};
-
 /**
  * struct aemif_device: structure to hold device data
  * @base: base address of AEMIF registers
@@ -136,6 +117,7 @@ struct aemif_cs_timings {
  * @num_cs: number of assigned chip-selects
  * @cs_offset: start number of cs nodes
  * @cs_data: array of chip-select settings
+ * @cs_config_lock: lock used to access CS configuration
  */
 struct aemif_device {
 	void __iomem *base;
@@ -144,6 +126,7 @@ struct aemif_device {
 	u8 num_cs;
 	int cs_offset;
 	struct aemif_cs_data cs_data[NUM_CS];
+	spinlock_t config_cs_lock;
 };
 
 /**
@@ -154,8 +137,9 @@ struct aemif_device {
  *
  * Returns 0 on success, else negative errno.
  */
-static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
+int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
 {
+	unsigned long flags;
 	unsigned int offset;
 	u32 val, set;
 
@@ -176,13 +160,16 @@ static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_
 
 	offset = A1CR_OFFSET + cs * 4;
 
+	spin_lock_irqsave(&aemif->config_cs_lock, flags);
 	val = readl(aemif->base + offset);
 	val &= ~TIMINGS_MASK;
 	val |= set;
 	writel(val, aemif->base + offset);
+	spin_unlock_irqrestore(&aemif->config_cs_lock, flags);
 
 	return 0;
 }
+EXPORT_SYMBOL(aemif_set_cs_timings);
 
 /**
  * aemif_calc_rate - calculate timing data.
@@ -231,6 +218,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	struct aemif_cs_data *data = &aemif->cs_data[csnum];
 	unsigned long clk_rate = aemif->clk_rate;
 	struct aemif_cs_timings timings;
+	unsigned long flags;
 	unsigned offset;
 	u32 set, val;
 
@@ -250,10 +238,12 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	if (data->enable_ss)
 		set |= ACR_SSTROBE_MASK;
 
+	spin_lock_irqsave(&aemif->config_cs_lock, flags);
 	val = readl(aemif->base + offset);
 	val &= ~CONFIG_MASK;
 	val |= set;
 	writel(val, aemif->base + offset);
+	spin_unlock_irqrestore(&aemif->config_cs_lock, flags);
 
 	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &timings);
 }
@@ -396,6 +386,7 @@ static int aemif_probe(struct platform_device *pdev)
 	if (IS_ERR(aemif->base))
 		return PTR_ERR(aemif->base);
 
+	spin_lock_init(&aemif->config_cs_lock);
 	if (np) {
 		/*
 		 * For every controller device node, there is a cs device node
diff --git a/include/memory/ti-aemif.h b/include/memory/ti-aemif.h
new file mode 100644
index 000000000000..a1478387a8d0
--- /dev/null
+++ b/include/memory/ti-aemif.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __TI_AEMIF_H
+#define __TI_AEMIF_H
+
+/**
+ * struct aemif_cs_timing: structure to hold cs timing configuration
+ * values are expressed in number of clock cycles - 1
+ * @ta: minimum turn around time
+ * @rhold read hold width
+ * @rstrobe read strobe width
+ * @rsetup read setup width
+ * @whold write hold width
+ * @wstrobe write strobe width
+ * @wsetup write setup width
+ */
+struct aemif_cs_timings {
+	u32	ta;
+	u32	rhold;
+	u32	rstrobe;
+	u32	rsetup;
+	u32	whold;
+	u32	wstrobe;
+	u32	wsetup;
+};
+
+struct aemif_device;
+
+int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings);
+
+#endif // __TI_AEMIF_H
-- 
2.47.0



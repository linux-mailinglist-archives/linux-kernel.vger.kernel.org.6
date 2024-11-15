Return-Path: <linux-kernel+bounces-410700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5E9CDFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C568028156A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3BA1C2335;
	Fri, 15 Nov 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g7asxWba"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FF1C07C9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677201; cv=none; b=B+qIg3QuqFeMCoYPFVxuBFkPIUbERZlpeuOCLvgWzWwxsjNAcUnKUuxSK+A1eyh50e7mdP0/QbVr3UxbOUYbrXf0BE+GLOIC8mrTNX8Uw56K9MXGHyl0duahDzwK7ElgibzbnmbxM/AWsWMXtPK3kwvi4OWHoHm0godpmZ/TmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677201; c=relaxed/simple;
	bh=eF/TRHcEg5YaWX5BJ4HH88hIW4y7ybIyq2q2fAzOUto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1oI/QHRx2Jtn5xyMowRJhm+H2buaFzPYtdTqxgVFLwhylrVM1XYrTNNjL4dj1cP1yUYuD0x5oBPE3V2pY1awDM0FnwsPkRCWJIALjJUS0sBLYUL9oT8VLEVZBoig7Q24XIzyAOGMsYf2EbwzUpuMm03KjUMxzwuifBova5FIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g7asxWba; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5E66F20010;
	Fri, 15 Nov 2024 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAxIY3vEKHi6h86MqObf/1O8IAWyhpfN7P2mnFaeHmA=;
	b=g7asxWbapX36+XGlwSmvLK4abBAKs30Qm/oU5N53uJZcRkA0MrzatIU7JW7EIG0TeIpVvS
	GsXmSc4OUvjGLOgcHQM6Q+Xx13q9PPNLMaiu2QWn7hdX2jVB0SBeFfo8yAY1q7HZY7VimO
	mf/h4fCd4AB6zIfrsZng8R1FhTclaIqbKt1V6u7Qyms8+xoUDjRwQ7jlwE3i5Ky7QngjVZ
	s8ClkZBsJhWg3J29CXPdKzVCg4qW+2jAoSkktoP+51EAZn1AnGVuO050tYBh0IIJ49S0Ex
	shmg4awBGNNhPhG6+n3n53ZX6pO3r4VM63OGd6Z2B3fPn/rJRoEvqw9Q1CX/XA==
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
Subject: [PATCH v4 06/10] memory: ti-aemif: Export aemif_*_cs_timings()
Date: Fri, 15 Nov 2024 14:26:27 +0100
Message-ID: <20241115132631.264609-7-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Export the aemif_set_cs_timing() and aemif_check_cs_timing() symbols so
they can be used by other drivers

Add a mutex to protect the CS configuration register from concurrent
accesses between the AEMIF and its 'children'.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/ti-aemif.c       | 35 ++++++++++++---------------------
 include/linux/memory/ti-aemif.h | 32 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index dae3441e0cd9..519283028eee 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -13,7 +13,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/memory/ti-aemif.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -79,26 +81,6 @@
 
 #define CONFIG_MASK	(EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | ASIZE_MAX)
 
-/**
- * struct aemif_cs_timings: structure to hold CS timings
- * @wstrobe: write strobe width, number of cycles - 1
- * @rstrobe: read strobe width, number of cycles - 1
- * @wsetup: write setup width, number of cycles - 1
- * @whold: write hold width, number of cycles - 1
- * @rsetup: read setup width, number of cycles - 1
- * @rhold: read hold width, number of cycles - 1
- * @ta: minimum turn around time, number of cycles - 1
- */
-struct aemif_cs_timings {
-	u32	wstrobe;
-	u32	rstrobe;
-	u32	wsetup;
-	u32	whold;
-	u32	rsetup;
-	u32	rhold;
-	u32	ta;
-};
-
 /**
  * struct aemif_cs_data: structure to hold CS parameters
  * @timings: timings configuration
@@ -123,6 +105,7 @@ struct aemif_cs_data {
  * @num_cs: number of assigned chip-selects
  * @cs_offset: start number of cs nodes
  * @cs_data: array of chip-select settings
+ * @config_cs_lock: lock used to access CS configuration
  */
 struct aemif_device {
 	void __iomem *base;
@@ -131,6 +114,7 @@ struct aemif_device {
 	u8 num_cs;
 	int cs_offset;
 	struct aemif_cs_data cs_data[NUM_CS];
+	struct mutex config_cs_lock;
 };
 
 /**
@@ -139,7 +123,7 @@ struct aemif_device {
  *
  * @return: 0 if the timing configuration is valid, negative error number otherwise.
  */
-static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
+int aemif_check_cs_timings(struct aemif_cs_timings *timings)
 {
 	if (timings->ta > TA_MAX)
 		return -EINVAL;
@@ -164,6 +148,7 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
 
 	return 0;
 }
+EXPORT_SYMBOL(aemif_check_cs_timings);
 
 /**
  * aemif_set_cs_timings - Set the timing configuration of a given chip select.
@@ -173,7 +158,7 @@ static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
  *
  * @return: 0 on success, else negative errno.
  */
-static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
+int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
 {
 	unsigned int offset;
 	u32 val, set;
@@ -195,13 +180,16 @@ static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_
 
 	offset = A1CR_OFFSET + cs * 4;
 
+	mutex_lock(&aemif->config_cs_lock);
 	val = readl(aemif->base + offset);
 	val &= ~TIMINGS_MASK;
 	val |= set;
 	writel(val, aemif->base + offset);
+	mutex_unlock(&aemif->config_cs_lock);
 
 	return 0;
 }
+EXPORT_SYMBOL(aemif_set_cs_timings);
 
 /**
  * aemif_calc_rate - calculate timing data.
@@ -257,10 +245,12 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	if (data->enable_ss)
 		set |= ACR_SSTROBE_MASK;
 
+	mutex_lock(&aemif->config_cs_lock);
 	val = readl(aemif->base + offset);
 	val &= ~CONFIG_MASK;
 	val |= set;
 	writel(val, aemif->base + offset);
+	mutex_unlock(&aemif->config_cs_lock);
 
 	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &data->timings);
 }
@@ -399,6 +389,7 @@ static int aemif_probe(struct platform_device *pdev)
 	if (IS_ERR(aemif->base))
 		return PTR_ERR(aemif->base);
 
+	mutex_init(&aemif->config_cs_lock);
 	if (np) {
 		/*
 		 * For every controller device node, there is a cs device node
diff --git a/include/linux/memory/ti-aemif.h b/include/linux/memory/ti-aemif.h
new file mode 100644
index 000000000000..0640d30f6321
--- /dev/null
+++ b/include/linux/memory/ti-aemif.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __TI_AEMIF_H
+#define __TI_AEMIF_H
+
+/**
+ * struct aemif_cs_timings: structure to hold CS timing configuration
+ * values are expressed in number of clock cycles - 1
+ * @ta: minimum turn around time
+ * @rhold: read hold width
+ * @rstrobe: read strobe width
+ * @rsetup: read setup width
+ * @whold: write hold width
+ * @wstrobe: write strobe width
+ * @wsetup: write setup width
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
+int aemif_check_cs_timings(struct aemif_cs_timings *timings);
+
+#endif // __TI_AEMIF_H
-- 
2.47.0



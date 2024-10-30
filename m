Return-Path: <linux-kernel+bounces-388497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AC9B6068
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A79F1F23533
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2BE1E3DF7;
	Wed, 30 Oct 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ESkJAztH"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F42C6A3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285247; cv=none; b=B98oDdc2euBjbIf/BsWNgsmDQ5sR42VyFrX+FoI0T1MsUonuhnVU8HASyd+GtMclQoOuxOgXdiQADL+ui3ThQwMc5wHNN+y7hoCZjo+DzDAePp6U4KECXrs8hEvNzv/exXEmbhYt9uGZU38XmXtFZ7por6DFOSd+55vdu61P1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285247; c=relaxed/simple;
	bh=MlHWuTh5yBgmlDp/sZvOENC+3hMjBC0EtLNcayA5/PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtGJ/wuMn34oQOKTcAqhsJwaOdGdFObRxBBULr70aXwGYmXzv9onEY9eSvVKxyMOgq7x/NuSW5h0rdp5uKIlCaNf3w8Lt9Y72KJYiMwF9Hk5aSP/zHdddJrvcJFMxfUxwMgmaE8FiLWyVgpQA8lVSHdxy2piiBo8qj/FGE4QowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ESkJAztH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id F0A35C000E;
	Wed, 30 Oct 2024 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730285242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFBzuhNdSXqNgNayg9anCpQOhMp/UnCGkxs9tY+mxRc=;
	b=ESkJAztHiiohybeTLEHdA1PKGui5AaTvRnpZvWM4GMw+Z4fynM1VFIB1Q1wx/GbzfwLfCt
	XGhYT9OUCYHu5ChJX5zF9xb4+zo00YMT6IjG+P3SDI82+kff1wZGDXAA/Y8xk1lWE4p2qA
	PVkrOiuhOKYE/xQkj2dd9JofHmhxt/aTUiGIyxxQnIsFhHi3Bfe/wiDstjkrb4OdRhahcs
	NjVNU7jLXq8ZPJqgjZH6NAAIxeJhxq6c5WBNcDfe5hJxkL7MSMO55PT6Y9CPYrZXsDvBlN
	wp+VoDhsJBUpBOJfYJeDf0vfmIoZ8l4FSoBFqbdFyUKyTj+BB721sKWQLlwm2g==
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
Subject: [PATCH 1/5] memory: ti-aemif: Create aemif_set_cs_timings()
Date: Wed, 30 Oct 2024 11:47:13 +0100
Message-ID: <20241030104717.88688-2-bastien.curutchet@bootlin.com>
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

Create an aemif_set_cs_timings() function to isolate the setting of a
chip select timing configuration and ease its exportation.
Move the check of the configuration validity from aemif_calc_rate() to
this new function.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 111 ++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 33 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index d54dc3cfff73..5be6df246075 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -69,15 +69,15 @@
 #define ACR_SSTROBE_MASK	BIT(31)
 #define ASIZE_16BIT	1
 
-#define CONFIG_MASK	(TA(TA_MAX) | \
-				RHOLD(RHOLD_MAX) | \
-				RSTROBE(RSTROBE_MAX) |	\
-				RSETUP(RSETUP_MAX) | \
-				WHOLD(WHOLD_MAX) | \
-				WSTROBE(WSTROBE_MAX) | \
-				WSETUP(WSETUP_MAX) | \
-				EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | \
-				ASIZE_MAX)
+#define TIMINGS_MASK	(TA(TA_MAX) | \
+			RHOLD(RHOLD_MAX) | \
+			RSTROBE(RSTROBE_MAX) |	\
+			RSETUP(RSETUP_MAX) | \
+			WHOLD(WHOLD_MAX) | \
+			WSTROBE(WSTROBE_MAX) | \
+			WSETUP(WSETUP_MAX))
+
+#define CONFIG_MASK	(EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | ASIZE_MAX)
 
 /**
  * struct aemif_cs_data: structure to hold cs parameters
@@ -107,6 +107,27 @@ struct aemif_cs_data {
 	u8	asize;
 };
 
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
 /**
  * struct aemif_device: structure to hold device data
  * @base: base address of AEMIF registers
@@ -125,6 +146,44 @@ struct aemif_device {
 	struct aemif_cs_data cs_data[NUM_CS];
 };
 
+/**
+ * aemif_set_cs_timings - Set the timing configuration of a given chip select.
+ * @aemif: aemif device to configure
+ * @cs: index of the chip select to configure.
+ * @timings: timings configuration to set
+ *
+ * Returns 0 on success, else negative errno.
+ */
+static int aemif_set_cs_timings(struct aemif_device *aemif, u8 cs, struct aemif_cs_timings *timings)
+{
+	unsigned int offset;
+	u32 val, set;
+
+	if (!timings || !aemif)
+		return -EINVAL;
+
+	if (cs > aemif->num_cs)
+		return -EINVAL;
+
+	if (timings->ta > TA_MAX || timings->rhold > RHOLD_MAX || timings->rstrobe > RSTROBE_MAX ||
+	    timings->rsetup > RSETUP_MAX || timings->whold > WHOLD_MAX ||
+	    timings->wstrobe > WSTROBE_MAX || timings->wsetup > WSETUP_MAX)
+		return -EINVAL;
+
+	set = TA(timings->ta) | RHOLD(timings->rhold) | RSTROBE(timings->rstrobe) |
+	      RSETUP(timings->rsetup) | WHOLD(timings->whold) |
+	      WSTROBE(timings->wstrobe) | WSETUP(timings->wsetup);
+
+	offset = A1CR_OFFSET + cs * 4;
+
+	val = readl(aemif->base + offset);
+	val &= ~TIMINGS_MASK;
+	val |= set;
+	writel(val, aemif->base + offset);
+
+	return 0;
+}
+
 /**
  * aemif_calc_rate - calculate timing data.
  * @pdev: platform device to calculate for
@@ -149,10 +208,6 @@ static int aemif_calc_rate(struct platform_device *pdev, int wanted,
 	if (result < 0)
 		result = 0;
 
-	/* ... But configuring tighter timings is not an option. */
-	else if (result > max)
-		result = -EINVAL;
-
 	return result;
 }
 
@@ -174,32 +229,22 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 {
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	struct aemif_cs_data *data = &aemif->cs_data[csnum];
-	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
 	unsigned long clk_rate = aemif->clk_rate;
+	struct aemif_cs_timings timings;
 	unsigned offset;
 	u32 set, val;
 
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 
-	ta	= aemif_calc_rate(pdev, data->ta, clk_rate, TA_MAX);
-	rhold	= aemif_calc_rate(pdev, data->rhold, clk_rate, RHOLD_MAX);
-	rstrobe	= aemif_calc_rate(pdev, data->rstrobe, clk_rate, RSTROBE_MAX);
-	rsetup	= aemif_calc_rate(pdev, data->rsetup, clk_rate, RSETUP_MAX);
-	whold	= aemif_calc_rate(pdev, data->whold, clk_rate, WHOLD_MAX);
-	wstrobe	= aemif_calc_rate(pdev, data->wstrobe, clk_rate, WSTROBE_MAX);
-	wsetup	= aemif_calc_rate(pdev, data->wsetup, clk_rate, WSETUP_MAX);
-
-	if (ta < 0 || rhold < 0 || rstrobe < 0 || rsetup < 0 ||
-	    whold < 0 || wstrobe < 0 || wsetup < 0) {
-		dev_err(&pdev->dev, "%s: cannot get suitable timings\n",
-			__func__);
-		return -EINVAL;
-	}
-
-	set = TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
-		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
+	timings.ta = aemif_calc_rate(pdev, data->ta, clk_rate, TA_MAX);
+	timings.rhold = aemif_calc_rate(pdev, data->rhold, clk_rate, RHOLD_MAX);
+	timings.rstrobe = aemif_calc_rate(pdev, data->rstrobe, clk_rate, RSTROBE_MAX);
+	timings.rsetup = aemif_calc_rate(pdev, data->rsetup, clk_rate, RSETUP_MAX);
+	timings.whold = aemif_calc_rate(pdev, data->whold, clk_rate, WHOLD_MAX);
+	timings.wstrobe = aemif_calc_rate(pdev, data->wstrobe, clk_rate, WSTROBE_MAX);
+	timings.wsetup = aemif_calc_rate(pdev, data->wsetup, clk_rate, WSETUP_MAX);
 
-	set |= (data->asize & ACR_ASIZE_MASK);
+	set = (data->asize & ACR_ASIZE_MASK);
 	if (data->enable_ew)
 		set |= ACR_EW_MASK;
 	if (data->enable_ss)
@@ -210,7 +255,7 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	val |= set;
 	writel(val, aemif->base + offset);
 
-	return 0;
+	return aemif_set_cs_timings(aemif, data->cs - aemif->cs_offset, &timings);
 }
 
 static inline int aemif_cycles_to_nsec(int val, unsigned long clk_rate)
-- 
2.47.0



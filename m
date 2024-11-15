Return-Path: <linux-kernel+bounces-410696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198A49CDFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932D31F23B31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22C1C07C3;
	Fri, 15 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JycdyV6g"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439C1B6D06
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677198; cv=none; b=RZBQpMHQ/SAJVTjPfWPHvXPKs0+IN/2MfLaBe3VQvC3Jz9Yizv441oakhdJ0XGSGqjHzW4qUeElwrsSUcu+jo8Ycb2J2uLMXIP1nkHaShwVesSecKaDzEGekIp37pe+p36rFsFJvLuz+v62TWxc4DrrwCtwGSp3NHU4ELG1U9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677198; c=relaxed/simple;
	bh=02hfe2356yWnCCnK/LwUSmT+Q/joPYGw55r39LSXYk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n26csWaSQDmwDumcVZvGLZI/d4TibtI4cfjflbNgU89Ei6Q6ZVWJxttgAwZtGm0oyItqOu9VEaJYa/NWAbh21iQee1/h9MCITaqC1t9X4FC85IkiVjhXdlydQNcsTguNOFPX1w7MLXxzjfqLAIpY9zTyB4wLBC/QrqyapYSbgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JycdyV6g; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2270F20009;
	Fri, 15 Nov 2024 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icTZu7vpeiRlHtvFDbI5TYKHSlVIZoYt0or7QxZkF+w=;
	b=JycdyV6g5asO9KALxp3/nLfKyzKLE0OPlk3303JC98kgKVJbkaBu0siQmBRyGw4gyYzKG0
	0qYSeyy0moleIVuNBkTwrb6PFvygReTVfW7UqRHumP0AGSa3iy5OAwhH4mU3ZALanoNeeQ
	rcHQ2FEzV6rUvoHwmOllJkp3IsBonoorLMusIe2HkVa2hyAh+oggTq6SLMIsxw4ZZP65qv
	u+u4V0mxG8fgx1itnpwm6k0AiJj5OVYplZjGsL00t0P5+io0QVHOixhoQJve8cL92OM8ZC
	MEqBSWguZZ7ssoaQucaxrDrmQzzz6fAEZt8UJdnUh2/beAe1LucRfScbnvlkMw==
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
Subject: [PATCH v4 01/10] memory: ti-aemif: Store timings parameter in number of cycles - 1
Date: Fri, 15 Nov 2024 14:26:22 +0100
Message-ID: <20241115132631.264609-2-bastien.curutchet@bootlin.com>
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

The CS configuration register expects timings to be expressed in
'number of cycles - 1' but they are stored in ns in the struct
aemif_cs_data. So at init, the timings currently set are converted to ns
by aemif_get_hw_params(), updated with values from the device-tree
properties, and then converted back to 'number of cycles - 1' before
being applied.

Store the timings directly in 'number of cycles - 1' instead of
nanoseconds.
Perform the conversion from nanosecond during the device-tree parsing.
Remove aemif_cycles_to_nsec() as it isn't used anymore.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 137 ++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index d54dc3cfff73..bd0c49ba1939 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -80,28 +80,28 @@
 				ASIZE_MAX)
 
 /**
- * struct aemif_cs_data: structure to hold cs parameters
+ * struct aemif_cs_data: structure to hold CS parameters
  * @cs: chip-select number
- * @wstrobe: write strobe width, ns
- * @rstrobe: read strobe width, ns
- * @wsetup: write setup width, ns
- * @whold: write hold width, ns
- * @rsetup: read setup width, ns
- * @rhold: read hold width, ns
- * @ta: minimum turn around time, ns
+ * @wstrobe: write strobe width, number of cycles - 1
+ * @rstrobe: read strobe width, number of cycles - 1
+ * @wsetup: write setup width, number of cycles - 1
+ * @whold: write hold width, number of cycles - 1
+ * @rsetup: read setup width, number of cycles - 1
+ * @rhold: read hold width, number of cycles - 1
+ * @ta: minimum turn around time, number of cycles - 1
  * @enable_ss: enable/disable select strobe mode
  * @enable_ew: enable/disable extended wait mode
  * @asize: width of the asynchronous device's data bus
  */
 struct aemif_cs_data {
 	u8	cs;
-	u16	wstrobe;
-	u16	rstrobe;
-	u8	wsetup;
-	u8	whold;
-	u8	rsetup;
-	u8	rhold;
-	u8	ta;
+	u32	wstrobe;
+	u32	rstrobe;
+	u32	wsetup;
+	u32	whold;
+	u32	rsetup;
+	u32	rhold;
+	u32	ta;
 	u8	enable_ss;
 	u8	enable_ew;
 	u8	asize;
@@ -175,26 +175,18 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	struct aemif_cs_data *data = &aemif->cs_data[csnum];
 	int ta, rhold, rstrobe, rsetup, whold, wstrobe, wsetup;
-	unsigned long clk_rate = aemif->clk_rate;
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
+	ta	=  data->ta;
+	rhold	=  data->rhold;
+	rstrobe	=  data->rstrobe;
+	rsetup	=  data->rsetup;
+	whold	=  data->whold;
+	wstrobe	=  data->wstrobe;
+	wsetup	=  data->wsetup;
 
 	set = TA(ta) | RHOLD(rhold) | RSTROBE(rstrobe) | RSETUP(rsetup) |
 		WHOLD(whold) | WSTROBE(wstrobe) | WSETUP(wsetup);
@@ -213,11 +205,6 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 	return 0;
 }
 
-static inline int aemif_cycles_to_nsec(int val, unsigned long clk_rate)
-{
-	return ((val + 1) * NSEC_PER_MSEC) / clk_rate;
-}
-
 /**
  * aemif_get_hw_params - function to read hw register values
  * @pdev: platform device to read for
@@ -231,19 +218,18 @@ static void aemif_get_hw_params(struct platform_device *pdev, int csnum)
 {
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	struct aemif_cs_data *data = &aemif->cs_data[csnum];
-	unsigned long clk_rate = aemif->clk_rate;
 	u32 val, offset;
 
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 	val = readl(aemif->base + offset);
 
-	data->ta = aemif_cycles_to_nsec(TA_VAL(val), clk_rate);
-	data->rhold = aemif_cycles_to_nsec(RHOLD_VAL(val), clk_rate);
-	data->rstrobe = aemif_cycles_to_nsec(RSTROBE_VAL(val), clk_rate);
-	data->rsetup = aemif_cycles_to_nsec(RSETUP_VAL(val), clk_rate);
-	data->whold = aemif_cycles_to_nsec(WHOLD_VAL(val), clk_rate);
-	data->wstrobe = aemif_cycles_to_nsec(WSTROBE_VAL(val), clk_rate);
-	data->wsetup = aemif_cycles_to_nsec(WSETUP_VAL(val), clk_rate);
+	data->ta = TA_VAL(val);
+	data->rhold = RHOLD_VAL(val);
+	data->rstrobe = RSTROBE_VAL(val);
+	data->rsetup = RSETUP_VAL(val);
+	data->whold = WHOLD_VAL(val);
+	data->wstrobe = WSTROBE_VAL(val);
+	data->wsetup = WSETUP_VAL(val);
 	data->enable_ew = EW_VAL(val);
 	data->enable_ss = SSTROBE_VAL(val);
 	data->asize = val & ASIZE_MAX;
@@ -261,7 +247,9 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 				      struct device_node *np)
 {
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
+	unsigned long clk_rate = aemif->clk_rate;
 	struct aemif_cs_data *data;
+	int ret;
 	u32 cs;
 	u32 val;
 
@@ -287,26 +275,61 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 	aemif_get_hw_params(pdev, aemif->num_cs++);
 
 	/* override the values from device node */
-	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val))
-		data->ta = val;
+	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, TA_MAX);
+		if (ret < 0)
+			return ret;
 
-	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val))
-		data->rhold = val;
+		data->ta = ret;
+	}
 
-	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val))
-		data->rstrobe = val;
+	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, RHOLD_MAX);
+		if (ret < 0)
+			return ret;
 
-	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val))
-		data->rsetup = val;
+		data->rhold = ret;
+	}
 
-	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val))
-		data->whold = val;
+	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, RSTROBE_MAX);
+		if (ret < 0)
+			return ret;
 
-	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val))
-		data->wstrobe = val;
+		data->rstrobe = ret;
+	}
 
-	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val))
-		data->wsetup = val;
+	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, RSETUP_MAX);
+		if (ret < 0)
+			return ret;
+
+		data->rsetup = ret;
+	}
+
+	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, WHOLD_MAX);
+		if (ret < 0)
+			return ret;
+
+		data->whold = ret;
+	}
+
+	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, WSTROBE_MAX);
+		if (ret < 0)
+			return ret;
+
+		data->wstrobe = ret;
+	}
+
+	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val)) {
+		ret = aemif_calc_rate(pdev, val, clk_rate, WSETUP_MAX);
+		if (ret < 0)
+			return ret;
+
+		data->wsetup = ret;
+	}
 
 	if (!of_property_read_u32(np, "ti,cs-bus-width", &val))
 		if (val == 16)
-- 
2.47.0



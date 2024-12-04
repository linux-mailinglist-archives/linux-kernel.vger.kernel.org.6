Return-Path: <linux-kernel+bounces-430887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A099E36DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A48285D20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824951ADFFB;
	Wed,  4 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OgJ0OEh8"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C91A9B5D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305408; cv=none; b=tbs6BKfQKZ+KjSjU0vui/ygXEzHfRSEShyCklCEpLMh9KwxpSt1yzYfGeWupMiu5dMLhCt7w8sXqnAHl4UuBwmn4Wvdb5rbQ3gFPIrnur6UCPrVP1u8sYF4oefOlbzuTn5TPMt+DUtX0/IbS0K2R9/3oKa3Qsa5ePkcZpV7Msf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305408; c=relaxed/simple;
	bh=yIpIw/yPRhOjS09EiAV0V6ZaBpcd4fwYqe81O6r4jQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdFacFSFOuN53JJChlrMH/xu+lTqXmcZlfSxd2bzbfgVkJifSEtpcjfAXyz9a6UVSNaWlduvT0MUd3WLZ3hCSr8Yn0zajYbXDIhX69dfeu2vtoc5rnqVZQQeeEGrR1qM06K4ev09FA4m28lBF0tcaruid05OCUvNfTfLFtPbVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OgJ0OEh8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 55C016000E;
	Wed,  4 Dec 2024 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1dSLJh1SAr2vIT0aQ/N/d5yFBNgqA0SN9iaVBxJ+xc=;
	b=OgJ0OEh8TT0ynPArYFjdi8h19A0loT1wSX8taMnOcspK+yhepP4Tvx3hQP/enaBZPEy5+k
	D72w9HUkzUesJPkkry7zH147mZw+smiGbv+0rWfXhOyUPtn7DXS3p+5Ng4kB46QLk8Duh3
	6KsSlDZU3qfLi7IoNSLXBPpFw79RaolKfc6wLwcgc2ItV+Z7/+ZTxGo7fq470m4wGJrEbM
	U4jqDYarhXXWQasGwC935PGTaqAD4S6j68YPqTPPf3aON85Mdx59zuVkMP0YheGq7YlAk1
	FW5/+KCaji7nPFETh9KP7OKkKz6VwrMvP1BmzgK660ixyuXalLM/yILqbrBzuQ==
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
Subject: [PATCH v5 3/9] memory: ti-aemif: Wrap CS timings into a struct
Date: Wed,  4 Dec 2024 10:43:13 +0100
Message-ID: <20241204094319.1050826-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

CS timings are store in the struct aemif_cs_data along with other CS
parameters. It isn't convenient for exposing CS timings to other drivers
without also exposing the other parameters.

Wrap the CS timings in a new struct aemif_cs_timings to simplify their
export in upcoming patches.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/ti-aemif.c | 57 ++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index a0e1a6b53256..1d1b30112af5 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -80,8 +80,7 @@
 				ASIZE_MAX)
 
 /**
- * struct aemif_cs_data: structure to hold cs parameters
- * @cs: chip-select number
+ * struct aemif_cs_timings: structure to hold CS timings
  * @wstrobe: write strobe width, number of cycles - 1
  * @rstrobe: read strobe width, number of cycles - 1
  * @wsetup: write setup width, number of cycles - 1
@@ -89,12 +88,8 @@
  * @rsetup: read setup width, number of cycles - 1
  * @rhold: read hold width, number of cycles - 1
  * @ta: minimum turn around time, number of cycles - 1
- * @enable_ss: enable/disable select strobe mode
- * @enable_ew: enable/disable extended wait mode
- * @asize: width of the asynchronous device's data bus
  */
-struct aemif_cs_data {
-	u8	cs;
+struct aemif_cs_timings {
 	u32	wstrobe;
 	u32	rstrobe;
 	u32	wsetup;
@@ -102,6 +97,19 @@ struct aemif_cs_data {
 	u32	rsetup;
 	u32	rhold;
 	u32	ta;
+};
+
+/**
+ * struct aemif_cs_data: structure to hold CS parameters
+ * @timings: timings configuration
+ * @cs: chip-select number
+ * @enable_ss: enable/disable select strobe mode
+ * @enable_ew: enable/disable extended wait mode
+ * @asize: width of the asynchronous device's data bus
+ */
+struct aemif_cs_data {
+	struct aemif_cs_timings timings;
+	u8	cs;
 	u8	enable_ss;
 	u8	enable_ew;
 	u8	asize;
@@ -179,9 +187,10 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 
-	set = TA(data->ta) |
-		RHOLD(data->rhold) | RSTROBE(data->rstrobe) | RSETUP(data->rsetup) |
-		WHOLD(data->whold) | WSTROBE(data->wstrobe) | WSETUP(data->wsetup);
+	set = TA(data->timings.ta) |
+		RHOLD(data->timings.rhold) | RSTROBE(data->timings.rstrobe) |
+		RSETUP(data->timings.rsetup) | WHOLD(data->timings.whold) |
+		WSTROBE(data->timings.wstrobe) | WSETUP(data->timings.wsetup);
 
 	set |= (data->asize & ACR_ASIZE_MASK);
 	if (data->enable_ew)
@@ -215,13 +224,13 @@ static void aemif_get_hw_params(struct platform_device *pdev, int csnum)
 	offset = A1CR_OFFSET + (data->cs - aemif->cs_offset) * 4;
 	val = readl(aemif->base + offset);
 
-	data->ta = TA_VAL(val);
-	data->rhold = RHOLD_VAL(val);
-	data->rstrobe = RSTROBE_VAL(val);
-	data->rsetup = RSETUP_VAL(val);
-	data->whold = WHOLD_VAL(val);
-	data->wstrobe = WSTROBE_VAL(val);
-	data->wsetup = WSETUP_VAL(val);
+	data->timings.ta = TA_VAL(val);
+	data->timings.rhold = RHOLD_VAL(val);
+	data->timings.rstrobe = RSTROBE_VAL(val);
+	data->timings.rsetup = RSETUP_VAL(val);
+	data->timings.whold = WHOLD_VAL(val);
+	data->timings.wstrobe = WSTROBE_VAL(val);
+	data->timings.wsetup = WSETUP_VAL(val);
 	data->enable_ew = EW_VAL(val);
 	data->enable_ss = SSTROBE_VAL(val);
 	data->asize = val & ASIZE_MAX;
@@ -272,7 +281,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->ta = ret;
+		data->timings.ta = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val)) {
@@ -280,7 +289,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rhold = ret;
+		data->timings.rhold = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val)) {
@@ -288,7 +297,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rstrobe = ret;
+		data->timings.rstrobe = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val)) {
@@ -296,7 +305,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rsetup = ret;
+		data->timings.rsetup = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val)) {
@@ -304,7 +313,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->whold = ret;
+		data->timings.whold = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val)) {
@@ -312,7 +321,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->wstrobe = ret;
+		data->timings.wstrobe = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val)) {
@@ -320,7 +329,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->wsetup = ret;
+		data->timings.wsetup = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-bus-width", &val))
-- 
2.47.0



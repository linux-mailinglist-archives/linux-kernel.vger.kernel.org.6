Return-Path: <linux-kernel+bounces-410697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEFD9CDFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD0C28225D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DABD1C07FC;
	Fri, 15 Nov 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E33wVMI7"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1281BC9EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677200; cv=none; b=SZGuzonr6yE38aXtxHxR4tPtK4MPgscwFKu0wm9+oRdFBQfrlHMRxpogkMCQXIpLIsfMPIqFRH2VQjZJRqTgmUih3z9ikf5aE3lkNOyWQIe/vU41tleLcwf3LmWbQC6XtrPnxrs4rYts3h+OZTBl6MOOl/B5vA1YiunFB4HVBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677200; c=relaxed/simple;
	bh=dGK1PB3A3vGOl0J9krAIclpt33dKMtjehIeu+tMqcBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHPzTFZajNfrInreEKGia89l/2zTnRqKqU54uQnqLYogu3O25doIT5s5jZ7Xkaeiw3ZWp8ei31lEUqFM3ZKp+Az6OV5R1R5An+8j8x9Z9lqsCzoLKgC0m6HxYp4rPUyIDmm9j2Za02mYQXq5Ffnn1D6SrsaKG+gGwrZ8pHeoc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E33wVMI7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6CA5C20004;
	Fri, 15 Nov 2024 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QiHpJejC3EVTa3EJGMvQU1Fk7sjFr5HV3ka8xV/Pe8U=;
	b=E33wVMI7vgDcjtpRwTiShitYVZzawMxT1FDsAcCVrCKWWsp0gD6StvhLC7UreK25V7H9iU
	pFY1NSHIDXGOO7LA8pohy2WjE9FzwmQ1wId6pYGf4r3b/uTkQa7jO/5ixDWtLTAtjjonhK
	Q4I7MqXNR+wSA5LkfgAHJ98Rr2VDAXD+oQyA/YLJBsZjbk3951DeYyrIU6ILDuDYSO6w98
	4lgNskqn5GTECGzDVeFbl414f2MLPppeEAeieqNxR+2dou+UpOgYFeZTiy/6FhdqDub37w
	xMNqQmZcJ8fQWoksDb6YJO/D2pfvu2iD4rgH+qb6UaVC5vw9LQcDCjIWMulz4w==
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
Subject: [PATCH v4 03/10] memory: ti-aemif: Wrap CS timings into a struct
Date: Fri, 15 Nov 2024 14:26:24 +0100
Message-ID: <20241115132631.264609-4-bastien.curutchet@bootlin.com>
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

CS timings are store in the struct aemif_cs_data along with other CS
parameters. It isn't convenient for exposing CS timings to other drivers
without also exposing the other parameters.

Wrap the CS timings in a new the struct aemif_cs_timings to simplify
their export in upcoming patches.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 58 ++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 6a751a23d41a..aec6d6464efa 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -78,10 +78,8 @@
 				WSETUP(WSETUP_MAX) | \
 				EW(EW_MAX) | SSTROBE(SSTROBE_MAX) | \
 				ASIZE_MAX)
-
 /**
- * struct aemif_cs_data: structure to hold CS parameters
- * @cs: chip-select number
+ * struct aemif_cs_timings: structure to hold CS timings
  * @wstrobe: write strobe width, number of cycles - 1
  * @rstrobe: read strobe width, number of cycles - 1
  * @wsetup: write setup width, number of cycles - 1
@@ -89,12 +87,8 @@
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
@@ -102,6 +96,19 @@ struct aemif_cs_data {
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
@@ -179,9 +186,10 @@ static int aemif_config_abus(struct platform_device *pdev, int csnum)
 
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
@@ -215,13 +223,13 @@ static void aemif_get_hw_params(struct platform_device *pdev, int csnum)
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
@@ -272,7 +280,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->ta = ret;
+		data->timings.ta = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val)) {
@@ -280,7 +288,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rhold = ret;
+		data->timings.rhold = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val)) {
@@ -288,7 +296,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rstrobe = ret;
+		data->timings.rstrobe = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val)) {
@@ -296,7 +304,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->rsetup = ret;
+		data->timings.rsetup = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val)) {
@@ -304,7 +312,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->whold = ret;
+		data->timings.whold = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val)) {
@@ -312,7 +320,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->wstrobe = ret;
+		data->timings.wstrobe = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val)) {
@@ -320,7 +328,7 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 		if (ret < 0)
 			return ret;
 
-		data->wsetup = ret;
+		data->timings.wsetup = ret;
 	}
 
 	if (!of_property_read_u32(np, "ti,cs-bus-width", &val))
-- 
2.47.0



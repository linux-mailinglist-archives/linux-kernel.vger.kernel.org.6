Return-Path: <linux-kernel+bounces-430888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4ED9E36DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF56C163EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C41AF0A6;
	Wed,  4 Dec 2024 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LW/hS81r"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C081AA1DF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305409; cv=none; b=f2MqEYVwoSLGtSGHK803p6rIS9eMovUEmRTEjmonrggP42gwLOY0nfOnxXfYmUxeNAF4ZnCXgVt+4mCLoK7tbrbUgENxUAiwBpgABTlSTL3f9mcJ3jbuDhAS+HtoaWg0HMtIAxtkh/B5sk2RHdYTnRUYTRsX3mfMiPx4Mwlp9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305409; c=relaxed/simple;
	bh=358hiA8UCYpG8+Xz2xa2XH9M93M67Y6jm521AfBxsPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWdbvYVKEklGbq7GwbBwBAoA3c+W7Bwl1DCbkyaPG8Yj9E+ZfRaj/jmI6CBWLNwrJ+7jypxLm6zaaSIsHxmk7W0+Cb2rY6LBgON6qaA3pXzgPmJtPBAWoj6cHSwqDY+/Tq43ql2sokmDvsMfl02/ZCT8cj7sZEzl/aohPvmVvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LW/hS81r; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0A516000D;
	Wed,  4 Dec 2024 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLNmuyNTbzPAZ139Ma4EX78v29Ja1psgE6Q61skRI0g=;
	b=LW/hS81rrWVrxHLeqjPvjzr2pklCxlxGHd0UCipicJDkS/2hDINzkNeb9SFfjiPTk0T/kq
	kn6CO8dcyNI+e3xGMEnYYzVSJEUQtIMABi0aZWVQo7s05bxyjp1qMp0W2oKBu+XByBc8yO
	jJH4dY89VlN9qfJAiu+5o1qL9+EIT35ogDijhBMAfkEtX0SYA3zqSSUGPy/xtJDtWJ4dL1
	ss+PF7gth4LbOWTjPjf8d4MDQBExaMkH+7FsuJp23ypX539/svrb017aOEMDC3gn+nuXb0
	1xhi+8PKUFq1q9It/EnaesdY49wU9ZYENXzoSe2yHP+aXsC57a3i9RnqsBCnog==
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
Subject: [PATCH v5 4/9] memory: ti-aemif: Create aemif_check_cs_timings()
Date: Wed,  4 Dec 2024 10:43:14 +0100
Message-ID: <20241204094319.1050826-5-bastien.curutchet@bootlin.com>
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

aemif_calc_rate() checks the validity of a new computed timing against a
'max' value given as input. This isn't convenient if we want to check
the CS timing configuration somewhere else in the code.

Wrap the verification of all the chip select's timing configuration into a
single function to ease its exportation in upcoming patches.
Remove the validity check from aemif_calc_rate(). Also remove the no
longer used 'max' input and change the return type to u32.
Remove the check of the aemif_calc_rate()'s return value during
device-tree parsing as aemif_calc_rate() can't fail anymore.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/memory/ti-aemif.c | 111 ++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 1d1b30112af5..ec770a2668e7 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -133,18 +133,48 @@ struct aemif_device {
 	struct aemif_cs_data cs_data[NUM_CS];
 };
 
+/**
+ * aemif_check_cs_timings() - Check the validity of a CS timing configuration.
+ * @timings: timings configuration
+ *
+ * @return: 0 if the timing configuration is valid, negative error number otherwise.
+ */
+static int aemif_check_cs_timings(struct aemif_cs_timings *timings)
+{
+	if (timings->ta > TA_MAX)
+		return -EINVAL;
+
+	if (timings->rhold > RHOLD_MAX)
+		return -EINVAL;
+
+	if (timings->rstrobe > RSTROBE_MAX)
+		return -EINVAL;
+
+	if (timings->rsetup > RSETUP_MAX)
+		return -EINVAL;
+
+	if (timings->whold > WHOLD_MAX)
+		return -EINVAL;
+
+	if (timings->wstrobe > WSTROBE_MAX)
+		return -EINVAL;
+
+	if (timings->wsetup > WSETUP_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * aemif_calc_rate - calculate timing data.
  * @pdev: platform device to calculate for
  * @wanted: The cycle time needed in nanoseconds.
  * @clk: The input clock rate in kHz.
- * @max: The maximum divider value that can be programmed.
  *
- * On success, returns the calculated timing value minus 1 for easy
- * programming into AEMIF timing registers, else negative errno.
+ * @return: the calculated timing value minus 1 for easy
+ * programming into AEMIF timing registers.
  */
-static int aemif_calc_rate(struct platform_device *pdev, int wanted,
-			   unsigned long clk, int max)
+static u32 aemif_calc_rate(struct platform_device *pdev, int wanted, unsigned long clk)
 {
 	int result;
 
@@ -157,10 +187,6 @@ static int aemif_calc_rate(struct platform_device *pdev, int wanted,
 	if (result < 0)
 		result = 0;
 
-	/* ... But configuring tighter timings is not an option. */
-	else if (result > max)
-		result = -EINVAL;
-
 	return result;
 }
 
@@ -250,7 +276,6 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	unsigned long clk_rate = aemif->clk_rate;
 	struct aemif_cs_data *data;
-	int ret;
 	u32 cs;
 	u32 val;
 
@@ -276,68 +301,34 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 	aemif_get_hw_params(pdev, aemif->num_cs++);
 
 	/* override the values from device node */
-	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, TA_MAX);
-		if (ret < 0)
-			return ret;
-
-		data->timings.ta = ret;
-	}
+	if (!of_property_read_u32(np, "ti,cs-min-turnaround-ns", &val))
+		data->timings.ta = aemif_calc_rate(pdev, val, clk_rate);
 
-	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, RHOLD_MAX);
-		if (ret < 0)
-			return ret;
-
-		data->timings.rhold = ret;
-	}
+	if (!of_property_read_u32(np, "ti,cs-read-hold-ns", &val))
+		data->timings.rhold = aemif_calc_rate(pdev, val, clk_rate);
 
-	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, RSTROBE_MAX);
-		if (ret < 0)
-			return ret;
+	if (!of_property_read_u32(np, "ti,cs-read-strobe-ns", &val))
+		data->timings.rstrobe = aemif_calc_rate(pdev, val, clk_rate);
 
-		data->timings.rstrobe = ret;
-	}
+	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val))
+		data->timings.rsetup = aemif_calc_rate(pdev, val, clk_rate);
 
-	if (!of_property_read_u32(np, "ti,cs-read-setup-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, RSETUP_MAX);
-		if (ret < 0)
-			return ret;
+	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val))
+		data->timings.whold = aemif_calc_rate(pdev, val, clk_rate);
 
-		data->timings.rsetup = ret;
-	}
+	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val))
+		data->timings.wstrobe = aemif_calc_rate(pdev, val, clk_rate);
 
-	if (!of_property_read_u32(np, "ti,cs-write-hold-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, WHOLD_MAX);
-		if (ret < 0)
-			return ret;
-
-		data->timings.whold = ret;
-	}
-
-	if (!of_property_read_u32(np, "ti,cs-write-strobe-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, WSTROBE_MAX);
-		if (ret < 0)
-			return ret;
-
-		data->timings.wstrobe = ret;
-	}
-
-	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val)) {
-		ret = aemif_calc_rate(pdev, val, clk_rate, WSETUP_MAX);
-		if (ret < 0)
-			return ret;
-
-		data->timings.wsetup = ret;
-	}
+	if (!of_property_read_u32(np, "ti,cs-write-setup-ns", &val))
+		data->timings.wsetup = aemif_calc_rate(pdev, val, clk_rate);
 
 	if (!of_property_read_u32(np, "ti,cs-bus-width", &val))
 		if (val == 16)
 			data->asize = 1;
 	data->enable_ew = of_property_read_bool(np, "ti,cs-extended-wait-mode");
 	data->enable_ss = of_property_read_bool(np, "ti,cs-select-strobe-mode");
-	return 0;
+
+	return aemif_check_cs_timings(&data->timings);
 }
 
 static const struct of_device_id aemif_of_match[] = {
-- 
2.47.0



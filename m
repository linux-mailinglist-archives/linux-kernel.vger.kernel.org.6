Return-Path: <linux-kernel+bounces-410698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CF9CDFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1746F281E31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB491C07FE;
	Fri, 15 Nov 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FCtTBDlG"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF41BCA0E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677200; cv=none; b=khdtYmPjCdBfhZvTtBqhl26UmgsuDnRZHn8fW/mwB29htUDHeAEQhirvfvzWr866OzsfF1DHkN8jqBw/HESsyrmPJeAkpPxUYbUhtLuRgC6kiD4Gzon8+HC9dqeBX1zIkLpxBzab1ETVagtqMKghYEeWQUQZgnz5qT9btGw6OaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677200; c=relaxed/simple;
	bh=ALQUzwiE16xOKYCY/i+LdpNPhpbUZJ1kmnTSIs4zCII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7O59L+q9lLxUu4o+MZT01F+6oAm89c5HcqapW/I7ppyNjMI8ZJzFfRJ34TP0kYZ/ghClLLI85b3hDlwwyQSbFWE3RjFh3TaP0IqGgQ5hoDqg37REHWn9EKHWYeTyguMP+oVIlwJshdde20gUIuuA1o4mlZKj8uNp8ycD2Z+qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FCtTBDlG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 208AB2000D;
	Fri, 15 Nov 2024 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQvszEaafaOGtmCwU5uw9CwjZ8MoXUS0hbG2Xve76Qg=;
	b=FCtTBDlGQ2miJsQholvB/jA87euFnNj4WPdoQVt3wrc9rmDPmIZZ9/h3ZvsY0RSVGa4Bso
	PNlvZ1m7hgZqIv+xXqnZNuZkxhM7Rx/RCSDMwmVwBCZevL6i3HyQZnXXUNkQkabGGPE+FY
	TxHU/pz1NjwfQgjuBJWBFKKzxJq1fhhQE2zsYAUekZostNxl65z5DTjeKTU71vzxDnO6rh
	SBpJgQfho3WPfBGoCxnomb5B85KBjHPpby4h8CGTOzzey+D8v7r3yC6GVEKDhVne9iXri1
	QHgfnhfxEAXUPwl6kgPqyExxeA9Xaf9cESjji/peP5BugtYBL7e8w6h2brE7dg==
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
Subject: [PATCH v4 04/10] memory: ti-aemif: Create aemif_check_cs_timings()
Date: Fri, 15 Nov 2024 14:26:25 +0100
Message-ID: <20241115132631.264609-5-bastien.curutchet@bootlin.com>
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

aemif_calc_rate() check the validity of a new computed timing against a
'max' value given as input. This isn't convenient if we want to check
the CS timing configuration somewhere else in the code.

Wrap the verification of all the chip select's timing configuration into a
single function to ease its exportation in upcoming patches.
Remove the 'max' input from aemif_calc_rate() as it's no longer used.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/ti-aemif.c | 107 +++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 58 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index aec6d6464efa..5c1c6f95185f 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -132,18 +132,48 @@ struct aemif_device {
 	struct aemif_cs_data cs_data[NUM_CS];
 };
 
+/**
+ * aemif_check_cs_timings - Check the validity of a CS timing configuration.
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
  * On success, returns the calculated timing value minus 1 for easy
  * programming into AEMIF timing registers, else negative errno.
  */
-static int aemif_calc_rate(struct platform_device *pdev, int wanted,
-			   unsigned long clk, int max)
+static int aemif_calc_rate(struct platform_device *pdev, int wanted, unsigned long clk)
 {
 	int result;
 
@@ -156,10 +186,6 @@ static int aemif_calc_rate(struct platform_device *pdev, int wanted,
 	if (result < 0)
 		result = 0;
 
-	/* ... But configuring tighter timings is not an option. */
-	else if (result > max)
-		result = -EINVAL;
-
 	return result;
 }
 
@@ -249,7 +275,6 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
 	struct aemif_device *aemif = platform_get_drvdata(pdev);
 	unsigned long clk_rate = aemif->clk_rate;
 	struct aemif_cs_data *data;
-	int ret;
 	u32 cs;
 	u32 val;
 
@@ -275,68 +300,34 @@ static int of_aemif_parse_abus_config(struct platform_device *pdev,
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



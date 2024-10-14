Return-Path: <linux-kernel+bounces-363742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB999C671
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC71C22B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212B157A55;
	Mon, 14 Oct 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="W5SrG1sB"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5431A270;
	Mon, 14 Oct 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899541; cv=none; b=aG+6yn6I8w163f9eC6chb5sxiaWXFVb8Itie2xSXObsn+o3zoEMgyI7XUx51CKHLew7eAX/Hx+LD/CWwkaQFFbLV1LpkrH/3ALa8bKaL9ljKyh59PtjgllvrvySgoUHHJR3UNl7Gmcr2FF/incDVhscaS4o37qL4QXybFjbMn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899541; c=relaxed/simple;
	bh=mHicux2Sghghav0Fe+EOW1urQ3BtJ5/XdCcM/5RLHl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9CO96PRckkz+kX2Gp/KHbrLknar0YcXaHu/QgT2JRr+5wmDFbHS5r1953bgtDOYSSpkiobhMjv3zXv4abAT6w8S1j6KWOXxO9faChutcQE6fI9Jsugi0rRAXnZfD1Ct5J8aD4N3ZjN2H35q5lFtMTsWwCtn173RwBlgxlfnda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=W5SrG1sB; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4q9EO011934;
	Mon, 14 Oct 2024 04:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=BV5XTXQFrXhWMcDr
	AKJXjLWD0xeZGGeZFGmj7EbRxYU=; b=W5SrG1sBpvRP5+U575d5cd63RU0FflDY
	T94mzJieNOdGTdZpUj1uH1ZJ0Oy1yHUBW0t5AzQb8U2JjXLsbfuFfT9TQATBTdOz
	CTjoPibOmXacXOyQXlwyWQwAYTqfrnKeb/ZNz9W8tNfuIQyv6ME7bhdAdVPiFcCm
	CsoW7KlUslWzVfRWib7UQWUmRI2PNWR0pvgEb2ub7A3YZOegZJR/Fc3sXUzvt2bP
	x0RV29jDE40NFveCgE5FgiOIMpyOhD/naYZMvkgl5T1XPrP0sKja4oOlAWnhh2WY
	/adK7Q63L6ezdn9OczIVW//BgVRed38pprwtlqoD6VNyJ2Av6gelnw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 427nhk1ppp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 04:52:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 10:52:02 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 14 Oct 2024 10:52:02 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1CE6B820248;
	Mon, 14 Oct 2024 09:52:02 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>, <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: cs42l43: Disable IRQs during suspend
Date: Mon, 14 Oct 2024 10:52:02 +0100
Message-ID: <20241014095202.828194-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: paWG5mel22cDprWMLeYMvIvGHLvFWP90
X-Proofpoint-ORIG-GUID: paWG5mel22cDprWMLeYMvIvGHLvFWP90
X-Proofpoint-Spam-Reason: safe

The ASoC CODEC driver masks the IRQs whilst entering and exiting
system suspend to avoid issues where the IRQ handler can run but PM
runtime is disabled. However, as the IRQs could also be used from
other parts of the driver, it would be better to move this handling to
the MFD level.

Remove the handling from the ASoC driver and move it to the MFD
driver. Whilst moving also ensure the IRQs are all masked at the device
level before powering down the device, as per hardware recommendations.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c      | 62 +++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/cs42l43.c | 42 --------------------------
 2 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 3b4efb294471..e5f17fc430e4 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1109,16 +1109,39 @@ EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
 static int cs42l43_suspend(struct device *dev)
 {
 	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+	static const struct reg_sequence mask_all[] = {
+		{ CS42L43_DECIM_MASK,			0xFFFFFFFF, },
+		{ CS42L43_EQ_MIX_MASK,			0xFFFFFFFF, },
+		{ CS42L43_ASP_MASK,			0xFFFFFFFF, },
+		{ CS42L43_PLL_MASK,			0xFFFFFFFF, },
+		{ CS42L43_SOFT_MASK,			0xFFFFFFFF, },
+		{ CS42L43_SWIRE_MASK,			0xFFFFFFFF, },
+		{ CS42L43_MSM_MASK,			0xFFFFFFFF, },
+		{ CS42L43_ACC_DET_MASK,			0xFFFFFFFF, },
+		{ CS42L43_I2C_TGT_MASK,			0xFFFFFFFF, },
+		{ CS42L43_SPI_MSTR_MASK,		0xFFFFFFFF, },
+		{ CS42L43_SW_TO_SPI_BRIDGE_MASK,	0xFFFFFFFF, },
+		{ CS42L43_OTP_MASK,			0xFFFFFFFF, },
+		{ CS42L43_CLASS_D_AMP_MASK,		0xFFFFFFFF, },
+		{ CS42L43_GPIO_INT_MASK,		0xFFFFFFFF, },
+		{ CS42L43_ASRC_MASK,			0xFFFFFFFF, },
+		{ CS42L43_HPOUT_MASK,			0xFFFFFFFF, },
+	};
 	int ret;
 
-	/*
-	 * Don't care about being resumed here, but the driver does want
-	 * force_resume to always trigger an actual resume, so that register
-	 * state for the MCU/GPIOs is returned as soon as possible after system
-	 * resume. force_resume will resume if the reference count is resumed on
-	 * suspend hence the get_noresume.
-	 */
-	pm_runtime_get_noresume(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(cs42l43->dev, "Failed to resume for suspend: %d\n", ret);
+		return ret;
+	}
+
+	/* The IRQs will be re-enabled on resume by the cache sync */
+	ret = regmap_multi_reg_write_bypassed(cs42l43->regmap,
+					      mask_all, ARRAY_SIZE(mask_all));
+	if (ret) {
+		dev_err(cs42l43->dev, "Failed to mask IRQs: %d\n", ret);
+		return ret;
+	}
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret) {
@@ -1133,6 +1156,26 @@ static int cs42l43_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	disable_irq(cs42l43->irq);
+
+	return 0;
+}
+
+static int cs42l43_suspend_noirq(struct device *dev)
+{
+	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+
+	enable_irq(cs42l43->irq);
+
+	return 0;
+}
+
+static int cs42l43_resume_noirq(struct device *dev)
+{
+	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
+
+	disable_irq(cs42l43->irq);
+
 	return 0;
 }
 
@@ -1145,6 +1188,8 @@ static int cs42l43_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	enable_irq(cs42l43->irq);
+
 	ret = pm_runtime_force_resume(dev);
 	if (ret) {
 		dev_err(cs42l43->dev, "Failed to force resume: %d\n", ret);
@@ -1212,6 +1257,7 @@ static int cs42l43_runtime_resume(struct device *dev)
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
 	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend_noirq, cs42l43_resume_noirq)
 	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
 };
 
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index d0098b4558b5..3ede0e3110f3 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2402,49 +2402,7 @@ static int cs42l43_codec_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int cs42l43_codec_suspend(struct device *dev)
-{
-	struct cs42l43_codec *priv = dev_get_drvdata(dev);
-	struct cs42l43 *cs42l43 = priv->core;
-
-	disable_irq(cs42l43->irq);
-
-	return 0;
-}
-
-static int cs42l43_codec_suspend_noirq(struct device *dev)
-{
-	struct cs42l43_codec *priv = dev_get_drvdata(dev);
-	struct cs42l43 *cs42l43 = priv->core;
-
-	enable_irq(cs42l43->irq);
-
-	return 0;
-}
-
-static int cs42l43_codec_resume(struct device *dev)
-{
-	struct cs42l43_codec *priv = dev_get_drvdata(dev);
-	struct cs42l43 *cs42l43 = priv->core;
-
-	enable_irq(cs42l43->irq);
-
-	return 0;
-}
-
-static int cs42l43_codec_resume_noirq(struct device *dev)
-{
-	struct cs42l43_codec *priv = dev_get_drvdata(dev);
-	struct cs42l43 *cs42l43 = priv->core;
-
-	disable_irq(cs42l43->irq);
-
-	return 0;
-}
-
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend, cs42l43_codec_resume)
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs42l43_codec_suspend_noirq, cs42l43_codec_resume_noirq)
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
 };
 
-- 
2.39.5



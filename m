Return-Path: <linux-kernel+bounces-449305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628879F4D01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627DC16D4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4EA1F5423;
	Tue, 17 Dec 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="inxzZVhx"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505751F427C;
	Tue, 17 Dec 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443987; cv=none; b=JmGbSMazf8jBfkHOIf2qHUYCncj78ssvBfsWkzr+6SYJQSm7HHofp56WpyqiSEZOg6iAnSB+yD34z1ZXEXEOc4/yPsHIeqDD03aFRA48oqyNndBqwbSf2B97zdL3zYjinESU9f4UY/JRJeiAGTqw441uC5ukQgGTrO/+u6gOb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443987; c=relaxed/simple;
	bh=tqr3XPSE7t+70hl+aZX6FF8Ohgt8KXetO/xkjjDDnoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4ZeJ0wFJl5nMsKXaI7sOUmTQwJWvbzzlQsVG1gSGiXJ2rHUa/cX9xiZrOua998yKEMycL+KInh9tCaxpIXR98C9MI5Pb57UCmhOgdUTrbvLb5dfQF6ZFXdeM4vImgbcfJppSQXmzfKGybKy3OOdDMzMM6GcSSnTXKQ2EnJGz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=inxzZVhx; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Fb3011049;
	Tue, 17 Dec 2024 07:59:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=73MJAwZPAdUwMl5i27o76ZD7JaXA0vchzkxLA3Nwfyo=; b=
	inxzZVhx81pOeQSKQo8pHY+zPGPwGdDZDVweDSvuTc/20qP7EOuC7a+HzcUZ2gjn
	kT2CG0esYFOqWAdVFaEX9TJQ9j+v7Qi1zTiN+I0XSlWD1JAfGBKmBxuHJkyb/Nh0
	WS65sjBcKYjmLyHB0Q9+xk5nWuwfzN+JVK9Tb5K3AJvbhVbFl21rxg4sZuBbfZK1
	utKluax0k2QkSWjaAvhIuoHJFs23hVaCEMOA5S+laIbqYH0jDfC5a08deHKmz3NA
	5nw5vWqPyJ1ALD87JfuzDEjJAFOJWNxgrOsxOVM3TdoaFdQOC5SjCuwX32tSgEev
	Q0ZOKiAtfBEZSwgChdZQ1w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0q-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:25 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id ED4D6822547;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: rt722-sdca: Make use of new expanded MBQ regmap
Date: Tue, 17 Dec 2024 13:59:21 +0000
Message-ID: <20241217135921.3572496-6-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
References: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HP28pjiloeVNaFTsurXsQ6VZg-MiNyzT
X-Proofpoint-ORIG-GUID: HP28pjiloeVNaFTsurXsQ6VZg-MiNyzT
X-Proofpoint-Spam-Reason: safe

Now the MBQ regmap implementation handles multiple sizes, this driver
can combine its two register maps into one. So remove mbq_regmap and
combine all the registers into regmap.

Also as rt722_sdca_adc_mux_get/put() only exist to access mbq_regmap,
rather than doing any processing, these can now be dropped and the
normal DAPM helpers used.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Note this patch is only build tested, as I do not have rt722 hardware,
would be great is someone could test.

Thanks,
Charles

 sound/soc/codecs/rt722-sdca-sdw.c |  81 ++++++------------
 sound/soc/codecs/rt722-sdca-sdw.h |  99 +++++++++++-----------
 sound/soc/codecs/rt722-sdca.c     | 135 +++++++-----------------------
 sound/soc/codecs/rt722-sdca.h     |   4 +-
 4 files changed, 105 insertions(+), 214 deletions(-)

diff --git a/sound/soc/codecs/rt722-sdca-sdw.c b/sound/soc/codecs/rt722-sdca-sdw.c
index 25fc13687bc8..45d55f317647 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.c
+++ b/sound/soc/codecs/rt722-sdca-sdw.c
@@ -16,7 +16,7 @@
 #include "rt722-sdca.h"
 #include "rt722-sdca-sdw.h"
 
-static bool rt722_sdca_readable_register(struct device *dev, unsigned int reg)
+static int rt722_sdca_mbq_size(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case 0x2f01 ... 0x2f0a:
@@ -32,32 +32,7 @@ static bool rt722_sdca_readable_register(struct device *dev, unsigned int reg)
 			0) ... SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
 			RT722_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
 	case RT722_BUF_ADDR_HID1 ... RT722_BUF_ADDR_HID2:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static bool rt722_sdca_volatile_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case 0x2f01:
-	case 0x2f54:
-	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_GE49, RT722_SDCA_CTL_DETECTED_MODE,
-			0):
-	case SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01, RT722_SDCA_CTL_HIDTX_CURRENT_OWNER,
-			0) ... SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
-			RT722_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
-	case RT722_BUF_ADDR_HID1 ... RT722_BUF_ADDR_HID2:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
+		return 1;
 	case 0x2000000 ... 0x2000024:
 	case 0x2000029 ... 0x200004a:
 	case 0x2000051 ... 0x2000052:
@@ -108,15 +83,32 @@ static bool rt722_sdca_mbq_readable_register(struct device *dev, unsigned int re
 			RT722_SDCA_CTL_FU_CH_GAIN, CH_L):
 	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PLATFORM_FU44,
 			RT722_SDCA_CTL_FU_CH_GAIN, CH_R):
-		return true;
+		return 2;
 	default:
-		return false;
+		return 0;
 	}
 }
 
-static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int reg)
+static struct regmap_sdw_mbq_cfg rt722_mbq_config = {
+	.mbq_size = rt722_sdca_mbq_size,
+};
+
+static bool rt722_sdca_readable_register(struct device *dev, unsigned int reg)
+{
+	return rt722_sdca_mbq_size(dev, reg) > 0;
+}
+
+static bool rt722_sdca_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case 0x2f01:
+	case 0x2f54:
+	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_GE49, RT722_SDCA_CTL_DETECTED_MODE,
+			0):
+	case SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01, RT722_SDCA_CTL_HIDTX_CURRENT_OWNER,
+			0) ... SDW_SDCA_CTL(FUNC_NUM_HID, RT722_SDCA_ENT_HID01,
+			RT722_SDCA_CTL_HIDTX_MESSAGE_LENGTH, 0):
+	case RT722_BUF_ADDR_HID1 ... RT722_BUF_ADDR_HID2:
 	case 0x2000000:
 	case 0x200000d:
 	case 0x2000019:
@@ -135,7 +127,7 @@ static bool rt722_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 
 static const struct regmap_config rt722_sdca_regmap = {
 	.reg_bits = 32,
-	.val_bits = 8,
+	.val_bits = 16,
 	.readable_reg = rt722_sdca_readable_register,
 	.volatile_reg = rt722_sdca_volatile_register,
 	.max_register = 0x44ffffff,
@@ -146,20 +138,6 @@ static const struct regmap_config rt722_sdca_regmap = {
 	.use_single_write = true,
 };
 
-static const struct regmap_config rt722_sdca_mbq_regmap = {
-	.name = "sdw-mbq",
-	.reg_bits = 32,
-	.val_bits = 16,
-	.readable_reg = rt722_sdca_mbq_readable_register,
-	.volatile_reg = rt722_sdca_mbq_volatile_register,
-	.max_register = 0x41000312,
-	.reg_defaults = rt722_sdca_mbq_defaults,
-	.num_reg_defaults = ARRAY_SIZE(rt722_sdca_mbq_defaults),
-	.cache_type = REGCACHE_MAPLE,
-	.use_single_read = true,
-	.use_single_write = true,
-};
-
 static int rt722_sdca_update_status(struct sdw_slave *slave,
 				enum sdw_slave_status status)
 {
@@ -369,18 +347,14 @@ static const struct sdw_slave_ops rt722_sdca_slave_ops = {
 static int rt722_sdca_sdw_probe(struct sdw_slave *slave,
 				const struct sdw_device_id *id)
 {
-	struct regmap *regmap, *mbq_regmap;
+	struct regmap *regmap;
 
 	/* Regmap Initialization */
-	mbq_regmap = devm_regmap_init_sdw_mbq(slave, &rt722_sdca_mbq_regmap);
-	if (IS_ERR(mbq_regmap))
-		return PTR_ERR(mbq_regmap);
-
-	regmap = devm_regmap_init_sdw(slave, &rt722_sdca_regmap);
+	regmap = devm_regmap_init_sdw_mbq_cfg(slave, &rt722_sdca_regmap, &rt722_mbq_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return rt722_sdca_init(&slave->dev, regmap, mbq_regmap, slave);
+	return rt722_sdca_init(&slave->dev, regmap, slave);
 }
 
 static int rt722_sdca_sdw_remove(struct sdw_slave *slave)
@@ -418,7 +392,6 @@ static int __maybe_unused rt722_sdca_dev_suspend(struct device *dev)
 	cancel_delayed_work_sync(&rt722->jack_btn_check_work);
 
 	regcache_cache_only(rt722->regmap, true);
-	regcache_cache_only(rt722->mbq_regmap, true);
 
 	return 0;
 }
@@ -488,8 +461,6 @@ static int __maybe_unused rt722_sdca_dev_resume(struct device *dev)
 	slave->unattach_request = 0;
 	regcache_cache_only(rt722->regmap, false);
 	regcache_sync(rt722->regmap);
-	regcache_cache_only(rt722->mbq_regmap, false);
-	regcache_sync(rt722->mbq_regmap);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt722-sdca-sdw.h b/sound/soc/codecs/rt722-sdca-sdw.h
index 5b43e86f75d1..80b014456940 100644
--- a/sound/soc/codecs/rt722-sdca-sdw.h
+++ b/sound/soc/codecs/rt722-sdca-sdw.h
@@ -31,50 +31,9 @@ static const struct reg_default rt722_sdca_reg_defaults[] = {
 	{ 0x2f5b, 0x07 },
 	{ 0x2f5c, 0x27 },
 	{ 0x2f5d, 0x07 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS01, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
-		0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS11, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
-		0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE12, RT722_SDCA_CTL_REQ_POWER_STATE,
-		0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE40, RT722_SDCA_CTL_REQ_POWER_STATE,
-		0), 0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_MUTE, CH_L),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_MUTE, CH_R),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_MUTE, CH_L),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_MUTE, CH_R),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_CS1F, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
-		0), 0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_01),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_02),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_03),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_04),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_PDE2A, RT722_SDCA_CTL_REQ_POWER_STATE, 0),
-		0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_IT26, RT722_SDCA_CTL_VENDOR_DEF, 0),
-		0x00 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_CS31, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
-		0x09 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_MUTE, CH_L),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_MUTE, CH_R),
-		0x01 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_PDE23, RT722_SDCA_CTL_REQ_POWER_STATE, 0),
-		0x03 },
-	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_OT23, RT722_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
-};
-
-static const struct reg_default rt722_sdca_mbq_defaults[] = {
 	{ 0x200003c, 0xc214 },
 	{ 0x2000046, 0x8004 },
+	{ 0x5810000, 0x702d },
 	{ 0x6100006, 0x0005 },
 	{ 0x6100010, 0x2630 },
 	{ 0x6100011, 0x152f },
@@ -86,27 +45,34 @@ static const struct reg_default rt722_sdca_mbq_defaults[] = {
 	{ 0x6100028, 0x2a2a },
 	{ 0x6100029, 0x4141 },
 	{ 0x6100055, 0x0000 },
-	{ 0x5810000, 0x702d },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_MUTE, CH_L),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_MUTE, CH_R),
+		0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_VOLUME,
 		CH_L), 0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU05, RT722_SDCA_CTL_FU_VOLUME,
 		CH_R), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_MUTE, CH_L),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_MUTE, CH_R),
+		0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_VOLUME,
 		CH_L), 0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_USER_FU0F, RT722_SDCA_CTL_FU_VOLUME,
 		CH_R), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE12, RT722_SDCA_CTL_REQ_POWER_STATE,
+		0), 0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS01, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
+		0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_CS11, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
+		0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PDE40, RT722_SDCA_CTL_REQ_POWER_STATE,
+		0), 0x03 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PLATFORM_FU44, RT722_SDCA_CTL_FU_CH_GAIN,
 		CH_L), 0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT722_SDCA_ENT_PLATFORM_FU44, RT722_SDCA_CTL_FU_CH_GAIN,
 		CH_R), 0x0000 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
-		CH_01), 0x0000 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
-		CH_02), 0x0000 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
-		CH_03), 0x0000 },
-	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
-		CH_04), 0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_FU15, RT722_SDCA_CTL_FU_CH_GAIN, CH_01),
 		0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_FU15, RT722_SDCA_CTL_FU_CH_GAIN, CH_02),
@@ -115,10 +81,41 @@ static const struct reg_default rt722_sdca_mbq_defaults[] = {
 		0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_FU15, RT722_SDCA_CTL_FU_CH_GAIN, CH_04),
 		0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_01),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_02),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_03),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_MUTE, CH_04),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
+		CH_01), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
+		CH_02), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
+		CH_03), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_USER_FU1E, RT722_SDCA_CTL_FU_VOLUME,
+		CH_04), 0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_PDE2A, RT722_SDCA_CTL_REQ_POWER_STATE, 0),
+		0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_CS1F, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX,
+		0), 0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT722_SDCA_ENT_IT26, RT722_SDCA_CTL_VENDOR_DEF, 0),
+		0x00 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_MUTE, CH_L),
+		0x01 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_MUTE, CH_R),
+		0x01 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_VOLUME, CH_L),
 		0x0000 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_USER_FU06, RT722_SDCA_CTL_FU_VOLUME, CH_R),
 		0x0000 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_PDE23, RT722_SDCA_CTL_REQ_POWER_STATE, 0),
+		0x03 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_CS31, RT722_SDCA_CTL_SAMPLE_FREQ_INDEX, 0),
+		0x09 },
+	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT722_SDCA_ENT_OT23, RT722_SDCA_CTL_VENDOR_DEF, 0), 0x00 },
 };
 
 #endif /* __RT722_SDW_H__ */
diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index 908846e994df..a95857c2547b 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -25,11 +25,13 @@
 
 #include "rt722-sdca.h"
 
+#define RT722_NID_ADDR(nid, reg) ((nid) << 20 | (reg))
+
 int rt722_sdca_index_write(struct rt722_sdca_priv *rt722,
 		unsigned int nid, unsigned int reg, unsigned int value)
 {
-	struct regmap *regmap = rt722->mbq_regmap;
-	unsigned int addr = (nid << 20) | reg;
+	struct regmap *regmap = rt722->regmap;
+	unsigned int addr = RT722_NID_ADDR(nid, reg);
 	int ret;
 
 	ret = regmap_write(regmap, addr, value);
@@ -45,8 +47,8 @@ int rt722_sdca_index_read(struct rt722_sdca_priv *rt722,
 		unsigned int nid, unsigned int reg, unsigned int *value)
 {
 	int ret;
-	struct regmap *regmap = rt722->mbq_regmap;
-	unsigned int addr = (nid << 20) | reg;
+	struct regmap *regmap = rt722->regmap;
+	unsigned int addr = RT722_NID_ADDR(nid, reg);
 
 	ret = regmap_read(regmap, addr, value);
 	if (ret < 0)
@@ -361,8 +363,8 @@ static int rt722_sdca_set_gain_put(struct snd_kcontrol *kcontrol,
 		strstr(ucontrol->id.name, "FU0F Capture Volume"))
 		adc_vol_flag = 1;
 
-	regmap_read(rt722->mbq_regmap, mc->reg, &lvalue);
-	regmap_read(rt722->mbq_regmap, mc->rreg, &rvalue);
+	regmap_read(rt722->regmap, mc->reg, &lvalue);
+	regmap_read(rt722->regmap, mc->rreg, &rvalue);
 
 	/* L Channel */
 	gain_l_val = ucontrol->value.integer.value[0];
@@ -402,13 +404,13 @@ static int rt722_sdca_set_gain_put(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	/* Lch*/
-	regmap_write(rt722->mbq_regmap, mc->reg, gain_l_val);
+	regmap_write(rt722->regmap, mc->reg, gain_l_val);
 
 	/* Rch */
-	regmap_write(rt722->mbq_regmap, mc->rreg, gain_r_val);
+	regmap_write(rt722->regmap, mc->rreg, gain_r_val);
 
-	regmap_read(rt722->mbq_regmap, mc->reg, &read_l);
-	regmap_read(rt722->mbq_regmap, mc->rreg, &read_r);
+	regmap_read(rt722->regmap, mc->reg, &read_l);
+	regmap_read(rt722->regmap, mc->rreg, &read_r);
 	if (read_r == gain_r_val && read_l == gain_l_val)
 		return changed;
 
@@ -431,8 +433,8 @@ static int rt722_sdca_set_gain_get(struct snd_kcontrol *kcontrol,
 		strstr(ucontrol->id.name, "FU0F Capture Volume"))
 		adc_vol_flag = 1;
 
-	regmap_read(rt722->mbq_regmap, mc->reg, &read_l);
-	regmap_read(rt722->mbq_regmap, mc->rreg, &read_r);
+	regmap_read(rt722->regmap, mc->reg, &read_l);
+	regmap_read(rt722->regmap, mc->rreg, &read_r);
 
 	if (mc->shift == 8) /* boost gain */
 		ctl_l = read_l / tendB;
@@ -604,7 +606,7 @@ static int rt722_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 
 	/* check all channels */
 	for (i = 0; i < p->count; i++) {
-		regmap_read(rt722->mbq_regmap, p->reg_base + i, &regvalue);
+		regmap_read(rt722->regmap, p->reg_base + i, &regvalue);
 
 		if (!adc_vol_flag) /* boost gain */
 			ctl = regvalue / boost_step;
@@ -637,7 +639,7 @@ static int rt722_sdca_dmic_set_gain_put(struct snd_kcontrol *kcontrol,
 
 	/* check all channels */
 	for (i = 0; i < p->count; i++) {
-		regmap_read(rt722->mbq_regmap, p->reg_base + i, &regvalue[i]);
+		regmap_read(rt722->regmap, p->reg_base + i, &regvalue[i]);
 
 		gain_val[i] = ucontrol->value.integer.value[i];
 		if (gain_val[i] > p->max)
@@ -658,7 +660,7 @@ static int rt722_sdca_dmic_set_gain_put(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	for (i = 0; i < p->count; i++) {
-		err = regmap_write(rt722->mbq_regmap, p->reg_base + i, gain_val[i]);
+		err = regmap_write(rt722->regmap, p->reg_base + i, gain_val[i]);
 		if (err < 0)
 			dev_err(&rt722->slave->dev, "%s: %#08x can't be set\n",
 				__func__, p->reg_base + i);
@@ -739,77 +741,6 @@ static const struct snd_kcontrol_new rt722_sdca_controls[] = {
 			4, 3, boost_vol_tlv),
 };
 
-static int rt722_sdca_adc_mux_get(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component =
-		snd_soc_dapm_kcontrol_component(kcontrol);
-	struct rt722_sdca_priv *rt722 = snd_soc_component_get_drvdata(component);
-	unsigned int val = 0, mask_sft;
-
-	if (strstr(ucontrol->id.name, "ADC 22 Mux"))
-		mask_sft = 12;
-	else if (strstr(ucontrol->id.name, "ADC 24 Mux"))
-		mask_sft = 4;
-	else if (strstr(ucontrol->id.name, "ADC 25 Mux"))
-		mask_sft = 0;
-	else
-		return -EINVAL;
-
-	rt722_sdca_index_read(rt722, RT722_VENDOR_HDA_CTL,
-		RT722_HDA_LEGACY_MUX_CTL0, &val);
-
-	ucontrol->value.enumerated.item[0] = (val >> mask_sft) & 0x7;
-
-	return 0;
-}
-
-static int rt722_sdca_adc_mux_put(struct snd_kcontrol *kcontrol,
-			struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_component *component =
-		snd_soc_dapm_kcontrol_component(kcontrol);
-	struct snd_soc_dapm_context *dapm =
-		snd_soc_dapm_kcontrol_dapm(kcontrol);
-	struct rt722_sdca_priv *rt722 = snd_soc_component_get_drvdata(component);
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int *item = ucontrol->value.enumerated.item;
-	unsigned int val, val2 = 0, change, mask_sft;
-
-	if (item[0] >= e->items)
-		return -EINVAL;
-
-	if (strstr(ucontrol->id.name, "ADC 22 Mux"))
-		mask_sft = 12;
-	else if (strstr(ucontrol->id.name, "ADC 24 Mux"))
-		mask_sft = 4;
-	else if (strstr(ucontrol->id.name, "ADC 25 Mux"))
-		mask_sft = 0;
-	else
-		return -EINVAL;
-
-	val = snd_soc_enum_item_to_val(e, item[0]) << e->shift_l;
-
-	rt722_sdca_index_read(rt722, RT722_VENDOR_HDA_CTL,
-		RT722_HDA_LEGACY_MUX_CTL0, &val2);
-	val2 = (0x7 << mask_sft) & val2;
-
-	if (val == val2)
-		change = 0;
-	else
-		change = 1;
-
-	if (change)
-		rt722_sdca_index_update_bits(rt722, RT722_VENDOR_HDA_CTL,
-			RT722_HDA_LEGACY_MUX_CTL0, 0x7 << mask_sft,
-			val << mask_sft);
-
-	snd_soc_dapm_mux_update_power(dapm, kcontrol,
-		item[0], e, NULL);
-
-	return change;
-}
-
 static const char * const adc22_mux_text[] = {
 	"MIC2",
 	"LINE1",
@@ -821,26 +752,26 @@ static const char * const adc07_10_mux_text[] = {
 	"DMIC2",
 };
 
-static SOC_ENUM_SINGLE_DECL(
-	rt722_adc22_enum, SND_SOC_NOPM, 0, adc22_mux_text);
+static SOC_ENUM_SINGLE_DECL(rt722_adc22_enum,
+			    RT722_NID_ADDR(RT722_VENDOR_HDA_CTL, RT722_HDA_LEGACY_MUX_CTL0),
+			    12, adc22_mux_text);
 
-static SOC_ENUM_SINGLE_DECL(
-	rt722_adc24_enum, SND_SOC_NOPM, 0, adc07_10_mux_text);
+static SOC_ENUM_SINGLE_DECL(rt722_adc24_enum,
+			    RT722_NID_ADDR(RT722_VENDOR_HDA_CTL, RT722_HDA_LEGACY_MUX_CTL0),
+			    4, adc07_10_mux_text);
 
-static SOC_ENUM_SINGLE_DECL(
-	rt722_adc25_enum, SND_SOC_NOPM, 0, adc07_10_mux_text);
+static SOC_ENUM_SINGLE_DECL(rt722_adc25_enum,
+			    RT722_NID_ADDR(RT722_VENDOR_HDA_CTL, RT722_HDA_LEGACY_MUX_CTL0),
+			    0, adc07_10_mux_text);
 
 static const struct snd_kcontrol_new rt722_sdca_adc22_mux =
-	SOC_DAPM_ENUM_EXT("ADC 22 Mux", rt722_adc22_enum,
-			rt722_sdca_adc_mux_get, rt722_sdca_adc_mux_put);
+	SOC_DAPM_ENUM("ADC 22 Mux", rt722_adc22_enum);
 
 static const struct snd_kcontrol_new rt722_sdca_adc24_mux =
-	SOC_DAPM_ENUM_EXT("ADC 24 Mux", rt722_adc24_enum,
-			rt722_sdca_adc_mux_get, rt722_sdca_adc_mux_put);
+	SOC_DAPM_ENUM("ADC 24 Mux", rt722_adc24_enum);
 
 static const struct snd_kcontrol_new rt722_sdca_adc25_mux =
-	SOC_DAPM_ENUM_EXT("ADC 25 Mux", rt722_adc25_enum,
-			rt722_sdca_adc_mux_get, rt722_sdca_adc_mux_put);
+	SOC_DAPM_ENUM("ADC 25 Mux", rt722_adc25_enum);
 
 static int rt722_sdca_fu42_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
@@ -1335,8 +1266,7 @@ static struct snd_soc_dai_driver rt722_sdca_dai[] = {
 	}
 };
 
-int rt722_sdca_init(struct device *dev, struct regmap *regmap,
-			struct regmap *mbq_regmap, struct sdw_slave *slave)
+int rt722_sdca_init(struct device *dev, struct regmap *regmap, struct sdw_slave *slave)
 {
 	struct rt722_sdca_priv *rt722;
 
@@ -1347,7 +1277,6 @@ int rt722_sdca_init(struct device *dev, struct regmap *regmap,
 	dev_set_drvdata(dev, rt722);
 	rt722->slave = slave;
 	rt722->regmap = regmap;
-	rt722->mbq_regmap = mbq_regmap;
 
 	mutex_init(&rt722->calibrate_mutex);
 	mutex_init(&rt722->disable_irq_lock);
@@ -1516,8 +1445,6 @@ int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	if (rt722->first_hw_init) {
 		regcache_cache_only(rt722->regmap, false);
 		regcache_cache_bypass(rt722->regmap, true);
-		regcache_cache_only(rt722->mbq_regmap, false);
-		regcache_cache_bypass(rt722->mbq_regmap, true);
 	} else {
 		/*
 		 * PM runtime is only enabled when a Slave reports as Attached
@@ -1545,8 +1472,6 @@ int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	if (rt722->first_hw_init) {
 		regcache_cache_bypass(rt722->regmap, false);
 		regcache_mark_dirty(rt722->regmap);
-		regcache_cache_bypass(rt722->mbq_regmap, false);
-		regcache_mark_dirty(rt722->mbq_regmap);
 	} else
 		rt722->first_hw_init = true;
 
diff --git a/sound/soc/codecs/rt722-sdca.h b/sound/soc/codecs/rt722-sdca.h
index 2464361a7958..04c3b4232ef3 100644
--- a/sound/soc/codecs/rt722-sdca.h
+++ b/sound/soc/codecs/rt722-sdca.h
@@ -17,7 +17,6 @@
 
 struct  rt722_sdca_priv {
 	struct regmap *regmap;
-	struct regmap *mbq_regmap;
 	struct snd_soc_component *component;
 	struct sdw_slave *slave;
 	struct sdw_bus_params params;
@@ -229,8 +228,7 @@ enum rt722_sdca_jd_src {
 };
 
 int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave);
-int rt722_sdca_init(struct device *dev, struct regmap *regmap,
-			struct regmap *mbq_regmap, struct sdw_slave *slave);
+int rt722_sdca_init(struct device *dev, struct regmap *regmap, struct sdw_slave *slave);
 int rt722_sdca_index_write(struct rt722_sdca_priv *rt722,
 		unsigned int nid, unsigned int reg, unsigned int value);
 int rt722_sdca_index_read(struct rt722_sdca_priv *rt722,
-- 
2.39.5



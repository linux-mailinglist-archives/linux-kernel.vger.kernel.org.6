Return-Path: <linux-kernel+bounces-225513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E609131A5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880661C21B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191C79FE;
	Sat, 22 Jun 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cUeiQ/NN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04338F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719023723; cv=none; b=PCV8+vfOmSFP1J8utXzx6s3NgY7/16zuBuFPVgKTueaOJlt4Xb/Gc2ehwqBss3vZjdfecedxJmffHCC/MM39HCzDJgEBXkQ/vfRzdaZNoqDKyDuiVFO/KidWVoAWUVbgpTWX2tvRklnAzdL1zIO0tVAOocbKlBAGkHPCSAb6iwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719023723; c=relaxed/simple;
	bh=G+yjtXLrPdCvH02NNGK4pofgbsXzHsDy+OMXxT6/MkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m9jhKI7PH461b0JYC2Qka/0swNLGxXkXQVGvnN+mflG3kIC2oJn/Hvl2Z0fOP7nljghuc8uYn0j2iAn9U/irb5bu0rknhpzGccl5d9nJicjNrFGLdCV7G7liaUSLnyf1B5neMF+lKmI3Glb5TdKWun68IGANRMf2sKsN+k1J818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cUeiQ/NN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45M2XnuI076761;
	Fri, 21 Jun 2024 21:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719023629;
	bh=ua1/jswJj1wB4YXYWHi6SELeuhLKvwjWh5Mdn3JiCTc=;
	h=From:To:CC:Subject:Date;
	b=cUeiQ/NN2OxPuQv/x7pl0IFBUH3ANfXaE98hkZSiHwM/aZ+HqzM85DCzqUg2A3/1R
	 eQixO2yGaGXwXjA1ojp+N3q3R/1PBZz8lrLBNOQGDthrpuUC5ekEAI2ffJGhkKvB3b
	 sl5PSU23rLZoOg1cNM2l/dhA9Ssbx9+i2+YidMYs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45M2Xnkn010611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 21:33:49 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 21:33:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 21:33:48 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.66.24])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45M2XdGd099847;
	Fri, 21 Jun 2024 21:33:39 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <zhourui@huaqin.com>,
        <alsa-devel@alsa-project.org>, <i-salazar@ti.com>,
        <linux-kernel@vger.kernel.org>, <j-chadha@ti.com>,
        <liam.r.girdwood@intel.com>, <jaden-yue@ti.com>,
        <yung-chuan.liao@linux.intel.com>, <dipa@ti.com>, <yuhsuan@google.com>,
        <henry.lo@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>, <soyer@irl.hu>,
        <Baojun.Xu@fpt.com>, <judyhsiao@google.com>, <navada@ti.com>,
        <cujomalainey@google.com>, <aanya@ti.com>, <nayeem.mahmud@ti.com>,
        <savyasanchi.shukla@netradyne.com>, <flaviopr@microsoft.com>,
        <jesse-ji@ti.com>, <darren.ye@mediatek.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v2] ASoc: tas2781: Add name_prefix as the prefix name of firmwares and kcontrol to support corresponding TAS2563/TAS2781s
Date: Sat, 22 Jun 2024 10:33:33 +0800
Message-ID: <20240622023335.595-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add name_prefix as the prefix name of firmwares and
kcontrol to support corresponding TAS2563/TAS2781s.
name_prefix is not mandatory.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - Add name_prefix as name prefix of calibration data file.
v1:
 - Changed the copyright year to 2024 in tas2781-comlib.c.
 - Correct the filename in the header comments of tas2781-comlib.c,
   remove the wrong file name.
 - Add name_prefix as name of firmwares and kcontrol.
---
 include/sound/tas2781.h           |  1 +
 sound/soc/codecs/tas2781-comlib.c | 13 +++++++++----
 sound/soc/codecs/tas2781-i2c.c    | 20 ++++++++++++++++----
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 99ca3e401fd1..cd8ce522b78e 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -108,6 +108,7 @@ struct tasdevice_priv {
 	unsigned char coef_binaryname[64];
 	unsigned char rca_binaryname[64];
 	unsigned char dev_name[32];
+	const char *name_prefix;
 	unsigned char ndev;
 	unsigned int magic_num;
 	unsigned int chip_id;
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 3aa81514dad7..6db1a260da82 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// tas2781-lib.c -- TAS2781 Common functions for HDA and ASoC Audio drivers
+// TAS2781 Common functions for HDA and ASoC Audio drivers
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 
@@ -277,8 +277,13 @@ int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 	 */
 	mutex_lock(&tas_priv->codec_lock);
 
-	scnprintf(tas_priv->rca_binaryname, 64, "%sRCA%d.bin",
-		tas_priv->dev_name, tas_priv->ndev);
+	if (tas_priv->name_prefix)
+		scnprintf(tas_priv->rca_binaryname, 64, "%s-%sRCA%d.bin",
+			tas_priv->name_prefix, tas_priv->dev_name,
+			tas_priv->ndev);
+	else
+		scnprintf(tas_priv->rca_binaryname, 64, "%sRCA%d.bin",
+			tas_priv->dev_name, tas_priv->ndev);
 	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
 	tas_priv->codec = codec;
 	ret = request_firmware_nowait(module, FW_ACTION_UEVENT,
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index c64d458e524e..cc765d45c6b5 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -394,8 +394,12 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	 * failing to load DSP firmware is NOT an error.
 	 */
 	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
-	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
-		tas_priv->dev_name);
+	if (tas_priv->name_prefix)
+		scnprintf(tas_priv->rca_binaryname, 64, "%s-%s_coef.bin",
+			tas_priv->name_prefix, tas_priv->dev_name);
+	else
+		scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
+			tas_priv->dev_name);
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
@@ -418,8 +422,15 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	 * calibrated data inside algo.
 	 */
 	for (i = 0; i < tas_priv->ndev; i++) {
-		scnprintf(tas_priv->cal_binaryname[i], 64, "%s_cal_0x%02x.bin",
-			tas_priv->dev_name, tas_priv->tasdevice[i].dev_addr);
+		if (tas_priv->name_prefix)
+			scnprintf(tas_priv->cal_binaryname[i], 64,
+				"%s-%s_cal_0x%02x.bin", tas_priv->name_prefix,
+				tas_priv->dev_name,
+				tas_priv->tasdevice[i].dev_addr);
+		else
+			scnprintf(tas_priv->cal_binaryname[i], 64,
+				"%s_cal_0x%02x.bin", tas_priv->dev_name,
+				tas_priv->tasdevice[i].dev_addr);
 		ret = tas2781_load_calibration(tas_priv,
 			tas_priv->cal_binaryname[i], i);
 		if (ret != 0)
@@ -579,6 +590,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 {
 	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
 
+	tas_priv->name_prefix = codec->name_prefix;
 	return tascodec_init(tas_priv, codec, THIS_MODULE, tasdevice_fw_ready);
 }
 
-- 
2.34.1



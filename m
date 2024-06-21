Return-Path: <linux-kernel+bounces-224765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5585C9126A2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860B41C25A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EDB156643;
	Fri, 21 Jun 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y4oVOyHN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710D155C84
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976301; cv=none; b=WW+L71eUNbELXdafmOjGwhVuIleQCIUKwjyZqnKfr+AXwl2wMGJws7Zs9TDbkvK8VzpUa9b7M6+vKiYrdDQLmqrDawSLxB1nGQ+vG2VlNWd5N6k+mSkH0GlPRGheR8COjGQ6UP4Bf8ZmuLkZh/YrlPxi6aDWK/RUp6eAmGKK+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976301; c=relaxed/simple;
	bh=E1ltYPGReYr7cHgA19i1+OTNxZ2G6c2UHY7yca7ZMTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aXggnz0RAgihTFqx20EZjRFwLDwd0Bvi6jwNAemvWUF7zG5Ai+RJ2yIFl0vl0hMt8m5jFCXx2JrDf8pa3LYMHnBqwkKQvcx2kVNSuDavE9BdiBnjhuM3FYmg3N5cASLqjbNR7Vi0uodgLa83qsJWH++UAhlG5kMfFgkajnjedcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y4oVOyHN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LDNOsa050798;
	Fri, 21 Jun 2024 08:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718976204;
	bh=jA2rl6BiJ1KgklO098yAZ+1ei3qV02tWnwEbSAolu6k=;
	h=From:To:CC:Subject:Date;
	b=Y4oVOyHN9WW5QMWlQlhxrjw8QLL91pvsTSko67OP413/lYlkW+oPdJlg9+9nZVIcG
	 IKk7bR2QN3xiKuQE1Ub6awJhQ4M/zddh6ZwZs9q+BLADKtx0IE0vU9xCfiKYcDvjOZ
	 +s3ApvwKkEvGEb4IhIRwB/klaxV5g4+ydTpe8d+g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LDNOni001981
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 08:23:24 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 08:23:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 08:23:24 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.238])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LDNDcY046768;
	Fri, 21 Jun 2024 08:23:14 -0500
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
Subject: [PATCH v1] ASoc: tas2781: Add name_prefix as the prefix name of firmwares and kcontrol to support corresponding TAS2563/TAS2781s
Date: Fri, 21 Jun 2024 21:23:07 +0800
Message-ID: <20240621132309.564-1-shenghao-ding@ti.com>
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
v1:
 - Changed the copyright year to 2024 in tas2781-comlib.c.
 - Correct the filename in the header comments of tas2781-comlib.c,
   remove the wrong file name.
 - Add name_prefix as name of firmwares and kcontrol.
---
 include/sound/tas2781.h           |  1 +
 sound/soc/codecs/tas2781-comlib.c | 13 +++++++++----
 sound/soc/codecs/tas2781-i2c.c    |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

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
index c64d458e524e..4d1a0d836e77 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -579,6 +579,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 {
 	struct tasdevice_priv *tas_priv = snd_soc_component_get_drvdata(codec);
 
+	tas_priv->name_prefix = codec->name_prefix;
 	return tascodec_init(tas_priv, codec, THIS_MODULE, tasdevice_fw_ready);
 }
 
-- 
2.34.1



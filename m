Return-Path: <linux-kernel+bounces-411632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C859CFD15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302DD1F253CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DA192B99;
	Sat, 16 Nov 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VmzF5U2G"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACD802;
	Sat, 16 Nov 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731743486; cv=none; b=BrmuRC8xpmS9rhtpEC3YlnsLlG6zXkLEYyDJDHFAGsovNBQuVzrH5UKo9X887KnNLkTxGQa91dnGAiggZnQ6zjCl4O3saTFPMwfNgU0yVD+D3VGbA6wPdW+EKpmACW0CrSw2gEE66QNUgjwoD4w55USRIbIM9HAtX6+/eKbJtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731743486; c=relaxed/simple;
	bh=mZPS0730G2HHaSBY6kH55u+UIscYlBGMBKh/hEZW+A8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tm1Ysq2B1Pq/nqFOI6zXXeAF8K1hDKbopZobTs6jV08AujpEwY4088NdkiWny5BVqyw+Lc18fOHr8Y45Vyuqr03vCVQW70Kkow+BDdBcIOAvzCJHbq3N+ijIQoiUVR6/iJY4boFxdArXGmqlJ0LXypUaoLz/IQYEE4Jod/fJPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VmzF5U2G; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7ofrc2945424
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 16 Nov 2024 01:50:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731743442;
	bh=oqfqfZ6VieMQsutlunbcKNC7Mo7XdbEB8zfZM21lNKU=;
	h=From:To:CC:Subject:Date;
	b=VmzF5U2G7hY2S17NpTJOskM1c4/yqDbyi8guUmMdB5qBy5mY77hIH7PKl1lvXApOT
	 lwv1qHntqdJmBMB7Td/UJoc00CFizqFEzy5+Twlh/urzeExX63BonIf+dlHEMtE2Lm
	 qQhjT0kwtSAp/bAHXawEgxnAd/f9d8u3JxZKJKfA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7ofl5112549;
	Sat, 16 Nov 2024 01:50:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 16
 Nov 2024 01:50:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 16 Nov 2024 01:50:41 -0600
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7oXf5030213;
	Sat, 16 Nov 2024 01:50:34 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <shenghao-ding@ti.com>,
        <navada@ti.com>, <13916275206@139.com>, <v-hampiholi@ti.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <antheas.dk@gmail.com>, <philm@manjaro.org>
Subject: [PATCH v5] ALSA: hda/tas2781: Add speaker id check for ASUS projects
Date: Sat, 16 Nov 2024 15:50:06 +0800
Message-ID: <20241116075006.11994-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add speaker id check by gpio in ACPI for ASUS projects.
In other vendors, speaker id was checked by BIOS, and was applied in
last bit of subsys id, so we can load corresponding firmware binary file
for its speaker by subsys id.
But in ASUS project, the firmware binary name will be appended an extra
number to tell the speakers from different vendors. And this single digit
come from gpio level of speaker id in BIOS.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v5:
 - Change length in strncmp(), use strlen().
v4:
 - Change strncasecmp() to strncmp().
 - Add error debug message print for "add driver gpio".
 - Put error information (PTR_ERR) to ret for get gpio.
 - Change %01d to %d in snprintf().
v3:
 - Change strstr() to strncasecmp() for compare subsystem id.
 - Remove result check after devm_acpi_dev_add_driver_gpios().
 - Remove spk_id > 1 check, as result of gpiod_get_value(),
   must be 0 or 1, or negative if error happend.
 - Change scnprintf() to snprintf(), as didn't care the length.
 - Remove changes which not relative current patch.
v2:
 - Change ASUS id from 0x10430000 to "1043".
 - Move gpio setting to tas2781_read_acpi() from probe.
 - Remove interrupt gpio in acpi_gpio_mapping.
 - Add sub and physdev in tas2781_read_acpi() for subsys id read.
 - Add debug log for get acpi resource failed.
 - Return error if get resource or subsys id failed.
 - Return error if get gpio fail for speaker id with ASUS projects.
 - Change fixed buffer lengh to sizeof().
 - Change bits calculator to lower_16_bits().
 - Remove unnecessary empty line in tas2781_hda_i2c_probe().
---
 include/sound/tas2781.h         |  3 ++
 sound/pci/hda/tas2781_hda_i2c.c | 64 +++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 8cd6da0480b7..621ae485d3cb 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -107,6 +107,8 @@
 #define TASDEVICE_CMD_DELAY		0x3
 #define TASDEVICE_CMD_FIELD_W		0x4
 
+#define TAS2781_ASUS_ID			"1043"
+
 enum audio_device {
 	TAS2563,
 	TAS2781,
@@ -156,6 +158,7 @@ struct tasdevice_priv {
 	struct tasdevice_rca rcabin;
 	struct calidata cali_data;
 	struct tasdevice_fw *fmw;
+	struct gpio_desc *speaker_id;
 	struct gpio_desc *reset;
 	struct mutex codec_lock;
 	struct regmap *regmap;
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 370d847517f9..f54bb3e0acd8 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -110,10 +110,19 @@ static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+static const struct acpi_gpio_params speakerid_gpios = { 0, 0, false };
+
+static const struct acpi_gpio_mapping tas2781_speaker_id_gpios[] = {
+	{ "speakerid-gpios", &speakerid_gpios, 1 },
+	{ }
+};
+
 static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 {
 	struct acpi_device *adev;
+	struct device *physdev;
 	LIST_HEAD(resources);
+	const char *sub;
 	int ret;
 
 	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
@@ -123,18 +132,44 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 		return -ENODEV;
 	}
 
-	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
-	if (ret < 0)
-		goto err;
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
+	if (ret < 0) {
+		dev_err(p->dev, "Failed to get ACPI resource.\n");
+		goto err;
+	}
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub)) {
+		dev_err(p->dev, "Failed to get SUBSYS ID.\n");
+		goto err;
+	}
+	// Speaker id was needed for ASUS projects.
+	if (!strncmp(sub, TAS2781_ASUS_ID, strlen(TAS2781_ASUS_ID))) {
+		ret = devm_acpi_dev_add_driver_gpios(p->dev,
+			tas2781_speaker_id_gpios);
+		if (ret < 0)
+			dev_err(p->dev, "Failed to add driver gpio %d.\n",
+			ret);
+		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
+		if (IS_ERR(p->speaker_id)) {
+			dev_err(p->dev, "Failed to get Speaker id.\n");
+			ret = PTR_ERR(p->speaker_id);
+			goto err;
+		}
+	} else {
+		p->speaker_id = NULL;
+	}
 
 	acpi_dev_free_resource_list(&resources);
 	strscpy(p->dev_name, hid, sizeof(p->dev_name));
+	put_device(physdev);
 	acpi_dev_put(adev);
 
 	return 0;
 
 err:
 	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
+	put_device(physdev);
 	acpi_dev_put(adev);
 
 	return ret;
@@ -615,7 +650,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	struct tasdevice_priv *tas_priv = context;
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct hda_codec *codec = tas_priv->codec;
-	int i, ret;
+	int i, ret, spk_id;
 
 	pm_runtime_get_sync(tas_priv->dev);
 	mutex_lock(&tas_priv->codec_lock);
@@ -648,8 +683,25 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_dsp_remove(tas_priv);
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
-	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
-		codec->core.subsystem_id & 0xffff);
+	if (tas_priv->speaker_id != NULL) {
+		// Speaker id need to be checked for ASUS only.
+		spk_id = gpiod_get_value(tas_priv->speaker_id);
+		if (spk_id < 0) {
+			// Speaker id is not valid, use default.
+			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
+			spk_id = 0;
+		}
+		snprintf(tas_priv->coef_binaryname,
+			  sizeof(tas_priv->coef_binaryname),
+			  "TAS2XXX%04X%d.bin",
+			  lower_16_bits(codec->core.subsystem_id),
+			  spk_id);
+	} else {
+		snprintf(tas_priv->coef_binaryname,
+			  sizeof(tas_priv->coef_binaryname),
+			  "TAS2XXX%04X.bin",
+			  lower_16_bits(codec->core.subsystem_id));
+	}
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
-- 
2.43.0



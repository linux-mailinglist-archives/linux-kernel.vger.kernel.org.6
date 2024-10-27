Return-Path: <linux-kernel+bounces-383673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61659B1EEE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92721C21445
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199216DC12;
	Sun, 27 Oct 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bSvR2Oup"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E58489;
	Sun, 27 Oct 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040046; cv=none; b=Y+rwRip1s3tfQuWXPgK6D8SNUjlQyD0Ch47+H3MVIbS+7clF7yEFsRFFPLmZrX9dYq1yHb1tEqLZNis9V2apLUAJYm9rRwAlth84wiiYPlTyvqet1/aw8jUbxBzDtndKjvcVrqFUl+QrJkiKN5MYZzjLNpE6365RWCE+F12LH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040046; c=relaxed/simple;
	bh=y7SnhNkgDAXuwQ0ZGXB4FjyYFKVVE+km2iPqONpuCPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/wMhEEBQea4vJbNjfiGvB439JTRibuwQuc9j5TgWmSpwjJKTxed7MMhWZXng7N4DOyqw3nY9SxOvWQh6xk9dPfZXw4fUgI92C27HLFYBQjPy8Oxtqim/C5VkWjR6hDhIJyVSJKV14c62yWwGEiQnDFupGY3Q7N57NmD1zot36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bSvR2Oup; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49REe9uM089942;
	Sun, 27 Oct 2024 09:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730040009;
	bh=fxeGiGOKwvfl9D2mFjLZqKn/3AkZq8oLkjJt0AaP3uM=;
	h=From:To:CC:Subject:Date;
	b=bSvR2Oup7Rg7PIlQFKlUi/2lC2H2uIsKwjmns08Os9NvUklgwuyeJ9IVFxZiBHaQw
	 5bvKqZOITroyoSV1hqgIAAFbNRxj7fPR/TruiuYAesxuWaqc8KMPJAbS6x1yXow0Al
	 o5ENUUP0aiRPoSN8Wh733f76lIEDDyYhjVyLGWWs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49REe9uu029513
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Oct 2024 09:40:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Oct 2024 09:40:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Oct 2024 09:40:08 -0500
Received: from lelvsmtp6.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49REe0TF060334;
	Sun, 27 Oct 2024 09:40:01 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <shenghao-ding@ti.com>,
        <navada@ti.com>, <13916275206@139.com>, <v-hampiholi@ti.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <antheas.dk@gmail.com>
Subject: [PATCH v3] ALSA: hda/tas2781: Add speaker id check for ASUS projects
Date: Sun, 27 Oct 2024 22:39:35 +0800
Message-ID: <20241027143935.1340-1-baojun.xu@ti.com>
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
 sound/pci/hda/tas2781_hda_i2c.c | 60 +++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

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
index 370d847517f9..3a0d1aeb5aea 100644
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
@@ -122,19 +131,40 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 			"Failed to find an ACPI device for %s\n", hid);
 		return -ENODEV;
 	}
-
-	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
-	if (ret < 0)
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
+	if (ret < 0) {
+		dev_err(p->dev, "Failed to get ACPI resource.\n");
+		goto err;
+	}
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub)) {
+		dev_err(p->dev, "Failed to get SUBSYS ID.\n");
 		goto err;
+	}
+	// Speaker id was needed for ASUS projects.
+	if (!strncasecmp(sub, TAS2781_ASUS_ID, sizeof(TAS2781_ASUS_ID))) {
+		devm_acpi_dev_add_driver_gpios(p->dev,
+			tas2781_speaker_id_gpios);
+		p->speaker_id = devm_gpiod_get(p->dev, "speakerid", GPIOD_IN);
+		if (IS_ERR(p->speaker_id)) {
+			dev_err(p->dev, "Failed to get Speaker id.\n");
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
@@ -615,7 +645,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	struct tasdevice_priv *tas_priv = context;
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct hda_codec *codec = tas_priv->codec;
-	int i, ret;
+	int i, ret, spk_id;
 
 	pm_runtime_get_sync(tas_priv->dev);
 	mutex_lock(&tas_priv->codec_lock);
@@ -648,8 +678,26 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
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
+			  "TAS2XXX%04X%01d.bin",
+			  lower_16_bits(codec->core.subsystem_id),
+			  spk_id);
+	} else {
+		snprintf(tas_priv->coef_binaryname,
+			  sizeof(tas_priv->coef_binaryname),
+			  "TAS2XXX%04X.bin",
+			  lower_16_bits(codec->core.subsystem_id));
+	}
+
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
-- 
2.43.0



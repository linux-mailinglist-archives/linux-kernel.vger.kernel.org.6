Return-Path: <linux-kernel+bounces-371122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7FE9A36BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA2F282CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265E186E27;
	Fri, 18 Oct 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V22gVYxx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A620E30A;
	Fri, 18 Oct 2024 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235540; cv=none; b=mp+/BMFeHvHVVZDjrqMt2d3MG7BP3m37e8PbTkpGQMMVDpCWKqAh/oI+4l7UVTg7/DauhQ0Iv6p/X3lzSNQlhn9mvMM684tRBpN5VcjClRrULRy1JBPiPi8+6nXarhVFYP9MRQgP5jg3twv9kmq8bjh59HgCyy3E2HDdX9wgAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235540; c=relaxed/simple;
	bh=ziEAUsOviZm+pgvvX7Hw0rl7ghCBbXM7mREkgU7jLzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+zUp2FkjnhMlrSVc8K6M6jNlrIttybmE1+3UHObNcjMms1+fVH/5J3K8S7ME8/WT7fh77ENNbFblnmJoQk5QMCjJ6r5ObEU3+52+OfBE4ml1T7wN8ZNblwaUgDw6DQsDFqP6o9BHCtMAZ+H5McVo/Xb95v/XuJVyuz83QctAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V22gVYxx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49I7BqUn048026;
	Fri, 18 Oct 2024 02:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729235512;
	bh=J0+NRNN16oylJlgxctMlI6BarpdwdloO5DpjjabTTgw=;
	h=From:To:CC:Subject:Date;
	b=V22gVYxx1wmyBCA2fVYQvwpvjaGUgHeBC3fwEjp7d7supiyVb4FtU0GbjsTiwE+1s
	 mhOYGqkRZPSSsebJaEFPMcS9JkhzR5BZGGU+2CxU92dVktxrTzKP4KbeuD94bWMYEO
	 gCTIqhxNfjvGntDmWKlvmSU0Pg6ECpmckauxlD8I=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49I7Bq4M073175
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Oct 2024 02:11:52 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Oct 2024 02:11:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Oct 2024 02:11:51 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49I7Bi2r007006;
	Fri, 18 Oct 2024 02:11:45 -0500
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
Subject: [PATCH v2] ALSA: hda/tas2781: Add speaker id check for ASUS projects
Date: Fri, 18 Oct 2024 15:11:18 +0800
Message-ID: <20241018071118.3298-1-baojun.xu@ti.com>
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
 sound/pci/hda/tas2781_hda_i2c.c | 62 +++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 6 deletions(-)

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
index 370d847517f9..4b238bf7e3c1 100644
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
@@ -122,19 +131,44 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 			"Failed to find an ACPI device for %s\n", hid);
 		return -ENODEV;
 	}
-
+	physdev = get_device(acpi_get_first_physical_node(adev));
 	ret = acpi_dev_get_resources(adev, &resources, tas2781_get_i2c_res, p);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(p->dev, "Failed to get ACPI resource.\n");
 		goto err;
+	}
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub)) {
+		dev_err(p->dev, "Failed to get SUBSYS ID.\n");
+		goto err;
+	}
+	// Speaker id was needed for ASUS projects.
+	if (strstr(sub, TAS2781_ASUS_ID)) {
+		ret = devm_acpi_dev_add_driver_gpios(p->dev,
+			tas2781_speaker_id_gpios);
+		if (ret) {
+			dev_err(p->dev, "Unable to add GPIO.\n");
+			goto err;
+		}
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
@@ -615,7 +649,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	struct tasdevice_priv *tas_priv = context;
 	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
 	struct hda_codec *codec = tas_priv->codec;
-	int i, ret;
+	int i, ret, spk_id;
 
 	pm_runtime_get_sync(tas_priv->dev);
 	mutex_lock(&tas_priv->codec_lock);
@@ -648,8 +682,25 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	tasdevice_dsp_remove(tas_priv);
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
-	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X.bin",
-		codec->core.subsystem_id & 0xffff);
+	if (tas_priv->speaker_id != NULL) {
+		// Speaker id need to be checked for ASUS only.
+		spk_id = gpiod_get_value(tas_priv->speaker_id);
+		if (spk_id < 0 || spk_id > 1) {
+			// Speaker id is not valid, use default.
+			dev_dbg(tas_priv->dev, "Wrong spk_id = %d\n", spk_id);
+			spk_id = 0;
+		}
+		scnprintf(tas_priv->coef_binaryname,
+			  sizeof(tas_priv->coef_binaryname),
+			  "TAS2XXX%04X%01d.bin",
+			  lower_16_bits(codec->core.subsystem_id),
+			  spk_id);
+	} else {
+		scnprintf(tas_priv->coef_binaryname,
+			  sizeof(tas_priv->coef_binaryname),
+			  "TAS2XXX%04X.bin",
+			  lower_16_bits(codec->core.subsystem_id));
+	}
 	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
@@ -793,7 +844,6 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	const char *device_name;
 	int ret;
 
-
 	tas_hda = devm_kzalloc(&clt->dev, sizeof(*tas_hda), GFP_KERNEL);
 	if (!tas_hda)
 		return -ENOMEM;
-- 
2.43.0



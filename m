Return-Path: <linux-kernel+bounces-245160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5B92AF18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321C4282D80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF08286A;
	Tue,  9 Jul 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UcVQebIa"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7C374CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499728; cv=none; b=H44ctw6Cqr/EshsLpsrEsKcCg56Lzhtqohd0SSTob4aZAPgckqtNKjvozBZ3GkHt2r+oVCggDViDe7YOBofR1FirEsPQLRStO9MuzqvEw6OBhlW19NuJiKYoImO2qeOMZLsU7Yg0t+ep3CUUFUD6m/QCnj6Fy7HM9sQlEMGDFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499728; c=relaxed/simple;
	bh=NNWrZYQ3fSfkc+brE6dmTFyc6IawVJMriepRcHnfDl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWIfWftkO9I0ZwTUswtpw/D+bcD+s9ehcXa4K1IHP456I/vi0wbEmUbNH+Ev/7l7x4VFafmo7wERFg9M4AkGo4C3bAwBH/7oTuT0XsKaWShcqiGXClyPQkD5z+mmCyIb0oAGWln3O+HPQ/2qPFZj6Oe5kgINys4s0LLWD31QczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UcVQebIa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4694XxKl120595;
	Mon, 8 Jul 2024 23:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720499639;
	bh=107XmrpJyCeilJ0uuF3WC/bbSNyntHG9X4j9WS9Mjfo=;
	h=From:To:CC:Subject:Date;
	b=UcVQebIaKT2GwemNDdVA6cLgF3UrxeImgQlUSEG0/pue1JN1qgTUjyhAOdPmSSYd2
	 g9Cc11qgbg3VtnXTnTZs689aR0BtwtFlSmuoTHW7a7b/deFQfVq1K1yVf/oI+Y6JhY
	 ycZZ8gqNVzscFy2wf1Um35IUXm66e5aY3jPiHJjI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4694XxI3050213
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jul 2024 23:33:59 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 23:33:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 23:33:58 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.70])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4694XnFh104367;
	Mon, 8 Jul 2024 23:33:50 -0500
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
Subject: [PATCH v1] ASoc: TAS2781: rename the tas2781_reset as tasdevice_reset
Date: Tue, 9 Jul 2024 12:33:40 +0800
Message-ID: <20240709043342.946-1-shenghao-ding@ti.com>
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

Rename the tas2781_reset as tasdevice_reset in case of misunderstanding.
RESET register for both tas2563 and tas2781 is same and the use of reset
pin is also same.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Rename tas2781_reset as tasdevice_reset
 - Changed the copyright year to 2024 in tas2781.h.
 - Rename TAS2781_REG_SWRESET_XXX as TASDEVICE_REG_SWRESET_XXX
 - Add tasdevice_reset into tasdevice_i2c_probe.
---
 include/sound/tas2781.h           | 8 ++++----
 sound/pci/hda/tas2781_hda_i2c.c   | 4 ++--
 sound/soc/codecs/tas2781-comlib.c | 8 ++++----
 sound/soc/codecs/tas2781-i2c.c    | 2 ++
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index cd8ce522b78e..a43ad6dcb7c7 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2563/TAS2781 driver implements a flexible and configurable
@@ -43,8 +43,8 @@
 					(page * 128)) + reg)
 
 /*Software Reset */
-#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
-#define TAS2781_REG_SWRESET_RESET	BIT(0)
+#define TASDEVICE_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
+#define TASDEVICE_REG_SWRESET_RESET	BIT(0)
 
 /*I2C Checksum */
 #define TASDEVICE_I2CChecksum		TASDEVICE_REG(0x0, 0x0, 0x7E)
@@ -140,7 +140,7 @@ struct tasdevice_priv {
 	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
 };
 
-void tas2781_reset(struct tasdevice_priv *tas_dev);
+void tasdevice_reset(struct tasdevice_priv *tas_dev);
 int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 	struct module *module,
 	void (*cont)(const struct firmware *fw, void *context));
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 75f7674c66ee..10420360b214 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -834,7 +834,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	pm_runtime_set_active(tas_hda->dev);
 	pm_runtime_enable(tas_hda->dev);
 
-	tas2781_reset(tas_hda->priv);
+	tasdevice_reset(tas_hda->priv);
 
 	ret = component_add(tas_hda->dev, &tas2781_hda_comp_ops);
 	if (ret) {
@@ -929,7 +929,7 @@ static int tas2781_system_resume(struct device *dev)
 		tas_hda->priv->tasdevice[i].cur_prog = -1;
 		tas_hda->priv->tasdevice[i].cur_conf = -1;
 	}
-	tas2781_reset(tas_hda->priv);
+	tasdevice_reset(tas_hda->priv);
 	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
 
 	/* If calibrated data occurs error, dsp will still work with default
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 6db1a260da82..1fbf4560f5cc 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -243,7 +243,7 @@ struct tasdevice_priv *tasdevice_kzalloc(struct i2c_client *i2c)
 }
 EXPORT_SYMBOL_GPL(tasdevice_kzalloc);
 
-void tas2781_reset(struct tasdevice_priv *tas_dev)
+void tasdevice_reset(struct tasdevice_priv *tas_dev)
 {
 	int ret, i;
 
@@ -254,8 +254,8 @@ void tas2781_reset(struct tasdevice_priv *tas_dev)
 	} else {
 		for (i = 0; i < tas_dev->ndev; i++) {
 			ret = tasdevice_dev_write(tas_dev, i,
-				TAS2781_REG_SWRESET,
-				TAS2781_REG_SWRESET_RESET);
+				TASDEVICE_REG_SWRESET,
+				TASDEVICE_REG_SWRESET_RESET);
 			if (ret < 0)
 				dev_err(tas_dev->dev,
 					"dev %d swreset fail, %d\n",
@@ -264,7 +264,7 @@ void tas2781_reset(struct tasdevice_priv *tas_dev)
 	}
 	usleep_range(1000, 1050);
 }
-EXPORT_SYMBOL_GPL(tas2781_reset);
+EXPORT_SYMBOL_GPL(tasdevice_reset);
 
 int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
 	struct module *module,
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index b412f8f2e5d5..d5d95ae57c73 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -742,6 +742,8 @@ static int tasdevice_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		goto err;
 
+	tasdevice_reset(tas_priv);
+
 	ret = devm_snd_soc_register_component(tas_priv->dev,
 		&soc_codec_driver_tasdevice,
 		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
-- 
2.34.1



Return-Path: <linux-kernel+bounces-439154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B139EAB88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010E4188AEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2FB2327A4;
	Tue, 10 Dec 2024 09:11:33 +0000 (UTC)
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628841B14FA;
	Tue, 10 Dec 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821892; cv=none; b=S1zOXztihhlP7yrvkQVpyDJmQSX12kKbDGZRiX5WbkC/HehZsl+C320etu68igoFsibDHrthP27zyoKeWT6DpeWdA65vnsxB2PBoGrL/90kPv/foT9V4DoIgThIzPwqLt8bZTAZVFwcTbUs20eteBIR+/DrKvqD+ewXqMu32apU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821892; c=relaxed/simple;
	bh=t3aWC5THH0nzp/pCYDZLliDgzXFis0JCk2zV52YeGts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObZ81kjAHNPnUZ3KRnIfh82sii3zxBf4am+eUyIjjA7icm9EyfWOlqL2/3r5N7iVnY6uihwuFkFHPv1gFU11OFq1fyjLWjP/0pab2vHyRqRK8Qag8gzbwmGWfxPjZ7B/hSO6AIZBOA8S0gw3wunLo0WaKBaKVhE0HlOh2qXTFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.aaFUC-G_1733821870 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 17:11:16 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	jack.yu@realtek.com,
	neil.armstrong@linaro.org,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	wangweidong.a@awinic.com,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	nuno.sa@analog.com,
	yesanishhere@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 2/2] ASoC: codecs: Add aw88083 amplifier driver
Date: Tue, 10 Dec 2024 17:10:54 +0800
Message-ID: <20241210091054.88779-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210091054.88779-1-wangweidong.a@awinic.com>
References: <20241210091054.88779-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

The driver is for amplifiers aw88083 of Awinic Technology
Corporation. The AW88083 is an intelligent digital audio
amplifier with low noise.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig   |   2 +-
 sound/soc/codecs/aw88081.c | 230 ++++++++++++++++++++++++++-----------
 sound/soc/codecs/aw88081.h |  43 +++++++
 3 files changed, 205 insertions(+), 70 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f2df7c91e18..0ba319683b6b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -692,7 +692,7 @@ config SND_SOC_AW88261
 	  the input amplitude.
 
 config SND_SOC_AW88081
-	tristate "Soc Audio for awinic aw88081"
+	tristate "Soc Audio for awinic aw88081/aw88083"
 	depends on I2C
 	select REGMAP_I2C
 	select SND_SOC_AW88395_LIB
diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index 58b8e002d76f..0ec06421e2f2 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -14,13 +14,18 @@
 #include "aw88081.h"
 #include "aw88395/aw88395_device.h"
 
+enum aw8808x_type {
+	AW88081,
+	AW88083,
+};
+
 struct aw88081 {
 	struct aw_device *aw_pa;
 	struct mutex lock;
 	struct delayed_work start_work;
 	struct regmap *regmap;
 	struct aw_container *aw_cfg;
-
+	enum aw8808x_type devtype;
 	bool phase_sync;
 };
 
@@ -32,6 +37,14 @@ static const struct regmap_config aw88081_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
 
+static const struct regmap_config aw88083_regmap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88083_REG_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
 static int aw88081_dev_get_iis_status(struct aw_device *aw_dev)
 {
 	unsigned int reg_val;
@@ -176,6 +189,21 @@ static void aw88081_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
 			~AW88081_I2STXEN_MASK, AW88081_I2STXEN_DISABLE_VALUE);
 }
 
+static void aw88083_i2c_wen(struct aw88081 *aw88081, bool flag)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+
+	if (aw88081->devtype != AW88083)
+		return;
+
+	if (flag)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+			~AW88083_I2C_WEN_MASK, AW88083_I2C_WEN_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+			~AW88083_I2C_WEN_MASK, AW88083_I2C_WEN_DISABLE_VALUE);
+}
+
 static void aw88081_dev_pwd(struct aw_device *aw_dev, bool pwd)
 {
 	if (pwd)
@@ -196,6 +224,26 @@ static void aw88081_dev_amppd(struct aw_device *aw_dev, bool amppd)
 				~AW88081_EN_PA_MASK, AW88081_EN_PA_WORKING_VALUE);
 }
 
+static void aw88083_dev_amppd(struct aw_device *aw_dev, bool amppd)
+{
+	if (amppd)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_AMPPD_MASK, AW88083_AMPPD_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_AMPPD_MASK, AW88083_AMPPD_WORKING_VALUE);
+}
+
+static void aw88083_dev_pllpd(struct aw_device *aw_dev, bool pllpd)
+{
+	if (pllpd)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_WORKING_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88083_PLL_PD_MASK, AW88083_PLL_PD_POWER_DOWN_VALUE);
+}
+
 static void aw88081_dev_clear_int_status(struct aw_device *aw_dev)
 {
 	unsigned int int_status;
@@ -312,16 +360,28 @@ static int aw88081_dev_reg_update(struct aw88081 *aw88081,
 		reg_addr = reg_data[i];
 		reg_val = reg_data[i + 1];
 
-		if (reg_addr == AW88081_SYSCTRL_REG) {
+		if (reg_addr == AW88081_SYSCTRL_REG && aw88081->devtype == AW88081) {
 			reg_val &= ~(~AW88081_EN_PA_MASK |
-				    ~AW88081_PWDN_MASK |
-				    ~AW88081_HMUTE_MASK |
-				    ~AW88081_ULS_HMUTE_MASK);
+				     ~AW88081_PWDN_MASK |
+				     ~AW88081_HMUTE_MASK |
+				     ~AW88081_ULS_HMUTE_MASK);
 
 			reg_val |= AW88081_EN_PA_POWER_DOWN_VALUE |
 				   AW88081_PWDN_POWER_DOWN_VALUE |
 				   AW88081_HMUTE_ENABLE_VALUE |
 				   AW88081_ULS_HMUTE_ENABLE_VALUE;
+		} else if (reg_addr == AW88081_SYSCTRL_REG && aw88081->devtype == AW88083) {
+			reg_val &= ~(~AW88083_AMPPD_MASK |
+				     ~AW88081_PWDN_MASK |
+				     ~AW88081_HMUTE_MASK |
+				     ~AW88083_PLL_PD_MASK |
+				     ~AW88083_I2C_WEN_MASK);
+
+			reg_val |= AW88083_AMPPD_POWER_DOWN_VALUE |
+				   AW88081_PWDN_POWER_DOWN_VALUE |
+				   AW88081_HMUTE_ENABLE_VALUE |
+				   AW88083_PLL_PD_POWER_DOWN_VALUE |
+				   AW88083_I2C_WEN_ENABLE_VALUE;
 		}
 
 		if (reg_addr == AW88081_SYSCTRL2_REG) {
@@ -331,7 +391,7 @@ static int aw88081_dev_reg_update(struct aw88081 *aw88081,
 		}
 
 		/* i2stxen */
-		if (reg_addr == AW88081_I2SCTRL3_REG) {
+		if (reg_addr == AW88081_I2SCTRL3_REG && aw88081->devtype == AW88081) {
 			/* close tx */
 			reg_val &= AW88081_I2STXEN_MASK;
 			reg_val |= AW88081_I2STXEN_DISABLE_VALUE;
@@ -427,38 +487,51 @@ static int aw88081_dev_start(struct aw88081 *aw88081)
 		return 0;
 	}
 
+	aw88083_i2c_wen(aw88081, true);
+
 	/* power on */
 	aw88081_dev_pwd(aw_dev, false);
 	usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
 
-	ret = aw88081_dev_check_syspll(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "pll check failed cannot start");
-		goto pll_check_fail;
-	}
+	if (aw88081->devtype == AW88081) {
+		ret = aw88081_dev_check_syspll(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "pll check failed cannot start");
+			goto pll_check_fail;
+		}
+		/* amppd on */
+		aw88081_dev_amppd(aw_dev, false);
+		usleep_range(AW88081_1000_US, AW88081_1000_US + 50);
 
-	/* amppd on */
-	aw88081_dev_amppd(aw_dev, false);
-	usleep_range(AW88081_1000_US, AW88081_1000_US + 50);
+		/* check i2s status */
+		ret = aw88081_dev_check_sysst(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "sysst check failed");
+			goto sysst_check_fail;
+		}
 
-	/* check i2s status */
-	ret = aw88081_dev_check_sysst(aw_dev);
-	if (ret) {
-		dev_err(aw_dev->dev, "sysst check failed");
-		goto sysst_check_fail;
-	}
+		/* enable tx feedback */
+		aw88081_dev_i2s_tx_enable(aw_dev, true);
 
-	/* enable tx feedback */
-	aw88081_dev_i2s_tx_enable(aw_dev, true);
+		/* close uls mute */
+		aw88081_dev_uls_hmute(aw_dev, false);
 
-	/* close uls mute */
-	aw88081_dev_uls_hmute(aw_dev, false);
+	} else {
+		aw88083_dev_pllpd(aw_dev, true);
+		/* amppd on */
+		aw88083_dev_amppd(aw_dev, false);
+		usleep_range(AW88081_2000_US, AW88081_2000_US + 50);
+	}
 
 	/* close mute */
 	aw88081_dev_mute(aw_dev, false);
 
-	/* clear inturrupt */
-	aw88081_dev_clear_int_status(aw_dev);
+	if (aw88081->devtype == AW88081)
+		/* clear inturrupt */
+		aw88081_dev_clear_int_status(aw_dev);
+
+	aw88083_i2c_wen(aw88081, false);
+
 	aw_dev->status = AW88081_DEV_PW_ON;
 
 	return 0;
@@ -474,8 +547,10 @@ static int aw88081_dev_start(struct aw88081 *aw88081)
 	return ret;
 }
 
-static int aw88081_dev_stop(struct aw_device *aw_dev)
+static int aw88081_stop(struct aw88081 *aw88081)
 {
+	struct aw_device *aw_dev = aw88081->aw_pa;
+
 	if (aw_dev->status == AW88081_DEV_PW_OFF) {
 		dev_dbg(aw_dev->dev, "already power off");
 		return 0;
@@ -483,23 +558,31 @@ static int aw88081_dev_stop(struct aw_device *aw_dev)
 
 	aw_dev->status = AW88081_DEV_PW_OFF;
 
-	/* clear inturrupt */
-	aw88081_dev_clear_int_status(aw_dev);
+	if (aw88081->devtype == AW88081) {
+		/* clear inturrupt */
+		aw88081_dev_clear_int_status(aw_dev);
+		aw88081_dev_uls_hmute(aw_dev, true);
+	}
+
+	aw88083_i2c_wen(aw88081, true);
 
-	aw88081_dev_uls_hmute(aw_dev, true);
 	/* set mute */
 	aw88081_dev_mute(aw_dev, true);
-
-	/* close tx feedback */
-	aw88081_dev_i2s_tx_enable(aw_dev, false);
-	usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
-
-	/* enable amppd */
-	aw88081_dev_amppd(aw_dev, true);
-
+	if (aw88081->devtype == AW88081) {
+		/* close tx feedback */
+		aw88081_dev_i2s_tx_enable(aw_dev, false);
+		usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
+		aw88081_dev_amppd(aw_dev, true);
+	} else {
+		usleep_range(AW88081_2000_US, AW88081_2000_US + 50);
+		aw88083_dev_amppd(aw_dev, true);
+		aw88083_dev_pllpd(aw_dev, false);
+	}
 	/* set power down */
 	aw88081_dev_pwd(aw_dev, true);
 
+	aw88083_i2c_wen(aw88081, false);
+
 	return 0;
 }
 
@@ -745,7 +828,7 @@ static int aw88081_profile_set(struct snd_kcontrol *kcontrol,
 	}
 
 	if (aw88081->aw_pa->status) {
-		aw88081_dev_stop(aw88081->aw_pa);
+		aw88081_stop(aw88081);
 		aw88081_start(aw88081, AW88081_SYNC_START);
 	}
 
@@ -781,12 +864,16 @@ static int aw88081_volume_set(struct snd_kcontrol *kcontrol,
 	if (value < mc->min || value > mc->max)
 		return -EINVAL;
 
+	aw88083_i2c_wen(aw88081, true);
+
 	if (vol_desc->ctl_volume != value) {
 		vol_desc->ctl_volume = value;
 		aw88081_dev_set_volume(aw88081->aw_pa, vol_desc->ctl_volume);
 		return 1;
 	}
 
+	aw88083_i2c_wen(aw88081, false);
+
 	return 0;
 }
 
@@ -860,13 +947,19 @@ static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct
 		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
 		return ret;
 	}
-	if (chip_id != AW88081_CHIP_ID) {
+
+	switch (chip_id) {
+	case AW88081_CHIP_ID:
+		dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
+		break;
+	case AW88083_CHIP_ID:
+		dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
+		break;
+	default:
 		dev_err(&i2c->dev, "unsupported device");
 		return -ENXIO;
 	}
 
-	dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
-
 	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
 	if (!aw_dev)
 		return -ENOMEM;
@@ -875,7 +968,7 @@ static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct
 	aw_dev->i2c = i2c;
 	aw_dev->regmap = regmap;
 	aw_dev->dev = &i2c->dev;
-	aw_dev->chip_id = AW88081_CHIP_ID;
+	aw_dev->chip_id = chip_id;
 	aw_dev->acf = NULL;
 	aw_dev->prof_info.prof_desc = NULL;
 	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
@@ -912,21 +1005,8 @@ static int aw88081_dev_init(struct aw88081 *aw88081, struct aw_container *aw_cfg
 		return ret;
 	}
 
-	aw88081_dev_clear_int_status(aw_dev);
-
-	aw88081_dev_uls_hmute(aw_dev, true);
-
-	aw88081_dev_mute(aw_dev, true);
-
-	usleep_range(AW88081_5000_US, AW88081_5000_US + 10);
-
-	aw88081_dev_i2s_tx_enable(aw_dev, false);
-
-	usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
-
-	aw88081_dev_amppd(aw_dev, true);
-
-	aw88081_dev_pwd(aw_dev, true);
+	aw_dev->status = AW88081_DEV_PW_ON;
+	aw88081_stop(aw88081);
 
 	return 0;
 }
@@ -977,7 +1057,7 @@ static int aw88081_playback_event(struct snd_soc_dapm_widget *w,
 		aw88081_start(aw88081, AW88081_ASYNC_START);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		aw88081_dev_stop(aw88081->aw_pa);
+		aw88081_stop(aw88081);
 		break;
 	default:
 		break;
@@ -1036,8 +1116,16 @@ static const struct snd_soc_component_driver soc_codec_dev_aw88081 = {
 	.num_controls = ARRAY_SIZE(aw88081_controls),
 };
 
+static const struct i2c_device_id aw88081_i2c_id[] = {
+	{ AW88081_I2C_NAME, AW88081},
+	{ AW88083_I2C_NAME, AW88083},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw88081_i2c_id);
+
 static int aw88081_i2c_probe(struct i2c_client *i2c)
 {
+	const struct i2c_device_id *id;
 	struct aw88081 *aw88081;
 	int ret;
 
@@ -1049,14 +1137,24 @@ static int aw88081_i2c_probe(struct i2c_client *i2c)
 	if (!aw88081)
 		return -ENOMEM;
 
+	id = i2c_match_id(aw88081_i2c_id, i2c);
+	aw88081->devtype = id->driver_data;
+
 	mutex_init(&aw88081->lock);
 
 	i2c_set_clientdata(i2c, aw88081);
 
-	aw88081->regmap = devm_regmap_init_i2c(i2c, &aw88081_regmap_config);
-	if (IS_ERR(aw88081->regmap))
-		return dev_err_probe(&i2c->dev, PTR_ERR(aw88081->regmap),
-						"failed to init regmap\n");
+	if (aw88081->devtype == AW88081) {
+		aw88081->regmap = devm_regmap_init_i2c(i2c, &aw88081_regmap_config);
+		if (IS_ERR(aw88081->regmap))
+			return dev_err_probe(&i2c->dev, PTR_ERR(aw88081->regmap),
+							"failed to init regmap\n");
+	} else {
+		aw88081->regmap = devm_regmap_init_i2c(i2c, &aw88083_regmap_config);
+		if (IS_ERR(aw88081->regmap))
+			return dev_err_probe(&i2c->dev, PTR_ERR(aw88081->regmap),
+							"failed to init regmap\n");
+	}
 
 	/* aw pa init */
 	ret = aw88081_init(aw88081, i2c, aw88081->regmap);
@@ -1068,12 +1166,6 @@ static int aw88081_i2c_probe(struct i2c_client *i2c)
 			aw88081_dai, ARRAY_SIZE(aw88081_dai));
 }
 
-static const struct i2c_device_id aw88081_i2c_id[] = {
-	{ AW88081_I2C_NAME },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, aw88081_i2c_id);
-
 static struct i2c_driver aw88081_i2c_driver = {
 	.driver = {
 		.name = AW88081_I2C_NAME,
diff --git a/sound/soc/codecs/aw88081.h b/sound/soc/codecs/aw88081.h
index b4bf7288021a..c4679476f524 100644
--- a/sound/soc/codecs/aw88081.h
+++ b/sound/soc/codecs/aw88081.h
@@ -231,6 +231,49 @@
 #define AW88081_CCO_MUX_BYPASS_VALUE	\
 	(AW88081_CCO_MUX_BYPASS << AW88081_CCO_MUX_START_BIT)
 
+#define AW88083_I2C_WEN_START_BIT	(14)
+#define AW88083_I2C_WEN_BITS_LEN	(2)
+#define AW88083_I2C_WEN_MASK		\
+	(~(((1<<AW88083_I2C_WEN_BITS_LEN)-1) << AW88083_I2C_WEN_START_BIT))
+
+#define AW88083_I2C_WEN_DISABLE	(0)
+#define AW88083_I2C_WEN_DISABLE_VALUE	\
+	(AW88083_I2C_WEN_DISABLE << AW88083_I2C_WEN_START_BIT)
+
+#define AW88083_I2C_WEN_ENABLE		(2)
+#define AW88083_I2C_WEN_ENABLE_VALUE	\
+	(AW88083_I2C_WEN_ENABLE << AW88083_I2C_WEN_START_BIT)
+
+#define AW88083_PLL_PD_START_BIT	(2)
+#define AW88083_PLL_PD_BITS_LEN	(1)
+#define AW88083_PLL_PD_MASK		\
+	(~(((1<<AW88083_PLL_PD_BITS_LEN)-1) << AW88083_PLL_PD_START_BIT))
+
+#define AW88083_PLL_PD_POWER_DOWN	(1)
+#define AW88083_PLL_PD_POWER_DOWN_VALUE	\
+	(AW88083_PLL_PD_POWER_DOWN << AW88083_PLL_PD_START_BIT)
+
+#define AW88083_PLL_PD_WORKING		(0)
+#define AW88083_PLL_PD_WORKING_VALUE	\
+	(AW88083_PLL_PD_WORKING << AW88083_PLL_PD_START_BIT)
+
+#define AW88083_AMPPD_START_BIT	(1)
+#define AW88083_AMPPD_BITS_LEN		(1)
+#define AW88083_AMPPD_MASK		\
+	(~(((1<<AW88083_AMPPD_BITS_LEN)-1) << AW88083_AMPPD_START_BIT))
+
+#define AW88083_AMPPD_WORKING		(0)
+#define AW88083_AMPPD_WORKING_VALUE	\
+	(AW88083_AMPPD_WORKING << AW88083_AMPPD_START_BIT)
+
+#define AW88083_AMPPD_POWER_DOWN	(1)
+#define AW88083_AMPPD_POWER_DOWN_VALUE	\
+	(AW88083_AMPPD_POWER_DOWN << AW88083_AMPPD_START_BIT)
+
+#define AW88083_REG_MAX		(0x7D)
+#define AW88083_I2C_NAME		"aw88083"
+#define AW88083_CHIP_ID		0x2407
+
 #define AW88081_START_RETRIES		(5)
 #define AW88081_START_WORK_DELAY_MS	(0)
 
-- 
2.47.0



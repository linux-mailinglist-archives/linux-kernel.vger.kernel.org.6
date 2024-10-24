Return-Path: <linux-kernel+bounces-379536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911059AE018
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BBC284C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B171C4A3E;
	Thu, 24 Oct 2024 09:04:16 +0000 (UTC)
Received: from out198-21.us.a.mail.aliyun.com (out198-21.us.a.mail.aliyun.com [47.90.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27751C07CA;
	Thu, 24 Oct 2024 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760654; cv=none; b=FjkUbIBy7OcrM1id6ktbOZlOHpTnBlLSOxpDCLT5Dq4v4j4W83+eJyD9zErIMGRRuOHOpSIp24DMzWPW/qSEuIXBqrR8ebE3aFnKOLydx90/XDHwrW/ok/9EcjWJ67NlMv08gBT7yJwiGSe9EwvQukCutgdTg5P/ZZ2vuduHcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760654; c=relaxed/simple;
	bh=hGFJMaVrnolInsCyk9plThfHrmBNYwl4ILd81hQA9PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdMd8emgEigYmnG/KnCui2mHdU5EbSXyvMDQyAVHEXmahUXIZIRkmHXxqA5Y6KOaeEUqtEWNW43IbdEQ/Hu7qIo11tbX+oejW7nwkIFbYAcRNKYcHWmUek2gifnR3yB0NJ5lNu+3xhuJDP1135gHVuPoxTFwBJLGzuB42bQotdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ZrObs16_1729760621 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 17:03:47 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	neil.armstrong@linaro.org,
	rf@opensource.cirrus.com,
	arnd@arndb.de,
	wangweidong.a@awinic.com,
	luca.ceresoli@bootlin.com,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 2/2] ASoC: codecs: Add aw88081 amplifier driver
Date: Thu, 24 Oct 2024 17:03:24 +0800
Message-ID: <20241024090324.131731-3-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024090324.131731-1-wangweidong.a@awinic.com>
References: <20241024090324.131731-1-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

The driver is for amplifiers aw88081 of Awinic Technology
Corporation. The awinic AW88081 is an I2S/TDM input,
high efficiency digital Smart K audio amplifier

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig   |   12 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/aw88081.c | 1087 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/aw88081.h |  286 ++++++++++
 4 files changed, 1387 insertions(+)
 create mode 100644 sound/soc/codecs/aw88081.c
 create mode 100644 sound/soc/codecs/aw88081.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7092842480ef..1eaca685c1a6 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -57,6 +57,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_AW8738
 	imply SND_SOC_AW87390
 	imply SND_SOC_AW88395
+	imply SND_SOC_AW88081
 	imply SND_SOC_AW88261
 	imply SND_SOC_AW88399
 	imply SND_SOC_BT_SCO
@@ -685,6 +686,17 @@ config SND_SOC_AW88261
 	  boost converter can be adjusted smartly according to
 	  the input amplitude.
 
+config SND_SOC_AW88081
+	tristate "Soc Audio for awinic aw88081"
+	depends on I2C
+	select REGMAP_I2C
+	select SND_SOC_AW88395_LIB
+	help
+	  This option enables support for aw88081 Smart PA.
+	  The awinic AW88081 is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier. Due to its 9uV noise
+	  floor and ultra-low distortion, clean listening is guaranteed.
+
 config SND_SOC_AW87390
 	tristate "Soc Audio for awinic aw87390"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 54cbc3feae32..7cc0cb49b3a2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -49,6 +49,7 @@ snd-soc-arizona-y := arizona.o arizona-jack.o
 snd-soc-audio-iio-aux-y := audio-iio-aux.o
 snd-soc-aw8738-y := aw8738.o
 snd-soc-aw87390-y := aw87390.o
+snd-soc-aw88081-y := aw88081.o
 snd-soc-aw88395-lib-y := aw88395/aw88395_lib.o
 snd-soc-aw88395-y := aw88395/aw88395.o \
 			aw88395/aw88395_device.o
@@ -457,6 +458,7 @@ obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_AUDIO_IIO_AUX)	+= snd-soc-audio-iio-aux.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW87390)	+= snd-soc-aw87390.o
+obj-$(CONFIG_SND_SOC_AW88081)	+= snd-soc-aw88081.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
 obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
new file mode 100644
index 000000000000..58b8e002d76f
--- /dev/null
+++ b/sound/soc/codecs/aw88081.c
@@ -0,0 +1,1087 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88081.c  --  AW88081 ALSA SoC Audio driver
+//
+// Copyright (c) 2024 awinic Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "aw88081.h"
+#include "aw88395/aw88395_device.h"
+
+struct aw88081 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+
+	bool phase_sync;
+};
+
+static const struct regmap_config aw88081_regmap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88081_REG_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static int aw88081_dev_get_iis_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88081_SYSST_REG, &reg_val);
+	if (ret)
+		return ret;
+	if ((reg_val & AW88081_BIT_PLL_CHECK) != AW88081_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw88081_dev_check_mode1_pll(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88081_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88081_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw88081_dev_check_mode2_pll(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88081_PLLCTRL1_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= (~AW88081_CCO_MUX_MASK);
+	if (reg_val == AW88081_CCO_MUX_DIVIDED_VALUE) {
+		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
+		return -EPERM;
+	}
+
+	/* change mode2 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88081_PLLCTRL1_REG,
+			~AW88081_CCO_MUX_MASK, AW88081_CCO_MUX_DIVIDED_VALUE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AW88081_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88081_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 iis check error");
+			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88081_PLLCTRL1_REG,
+			~AW88081_CCO_MUX_MASK, AW88081_CCO_MUX_BYPASS_VALUE);
+	if (ret == 0) {
+		usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+		for (i = 0; i < AW88081_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw88081_dev_check_mode1_pll(aw_dev);
+			if (ret) {
+				dev_err(aw_dev->dev, "mode2 switch to mode1, iis check error");
+				usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+			} else {
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int aw88081_dev_check_syspll(struct aw_device *aw_dev)
+{
+	int ret;
+
+	ret = aw88081_dev_check_mode1_pll(aw_dev);
+	if (ret) {
+		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
+		ret = aw88081_dev_check_mode2_pll(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 check iis failed");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int aw88081_dev_check_sysst(struct aw_device *aw_dev)
+{
+	unsigned int check_val;
+	unsigned int reg_val;
+	unsigned int value;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88081_PWMCTRL4_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val & (~AW88081_NOISE_GATE_EN_MASK))
+		check_val = AW88081_NO_SWS_SYSST_CHECK;
+	else
+		check_val = AW88081_SWS_SYSST_CHECK;
+
+	for (i = 0; i < AW88081_DEV_SYSST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW88081_SYSST_REG, &reg_val);
+		if (ret)
+			return ret;
+
+		value = reg_val & (~AW88081_BIT_SYSST_CHECK_MASK) & check_val;
+		if (value != check_val) {
+			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
+				reg_val, check_val);
+			usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static void aw88081_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
+{
+	if (flag)
+		regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
+			~AW88081_I2STXEN_MASK, AW88081_I2STXEN_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_I2SCTRL3_REG,
+			~AW88081_I2STXEN_MASK, AW88081_I2STXEN_DISABLE_VALUE);
+}
+
+static void aw88081_dev_pwd(struct aw_device *aw_dev, bool pwd)
+{
+	if (pwd)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_PWDN_MASK, AW88081_PWDN_WORKING_VALUE);
+}
+
+static void aw88081_dev_amppd(struct aw_device *aw_dev, bool amppd)
+{
+	if (amppd)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_EN_PA_MASK, AW88081_EN_PA_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_EN_PA_MASK, AW88081_EN_PA_WORKING_VALUE);
+}
+
+static void aw88081_dev_clear_int_status(struct aw_device *aw_dev)
+{
+	unsigned int int_status;
+
+	/* read int status and clear */
+	regmap_read(aw_dev->regmap, AW88081_SYSINT_REG, &int_status);
+	/* make sure int status is clear */
+	regmap_read(aw_dev->regmap, AW88081_SYSINT_REG, &int_status);
+
+	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", int_status);
+}
+
+static void aw88081_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int volume;
+
+	volume = min((value + vol_desc->init_volume), (unsigned int)AW88081_MUTE_VOL);
+
+	regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL2_REG, ~AW88081_VOL_MASK, volume);
+}
+
+static void aw88081_dev_fade_in(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_in_vol = desc->ctl_volume;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
+		aw88081_dev_set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+
+	for (i = AW88081_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
+		aw88081_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
+	}
+
+	if (i != fade_in_vol)
+		aw88081_dev_set_volume(aw_dev, fade_in_vol);
+}
+
+static void aw88081_dev_fade_out(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
+		aw88081_dev_set_volume(aw_dev, AW88081_MUTE_VOL);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= AW88081_MUTE_VOL; i += fade_step) {
+		aw88081_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+
+	if (i != AW88081_MUTE_VOL)
+		aw88081_dev_set_volume(aw_dev, AW88081_MUTE_VOL);
+}
+
+static void aw88081_dev_mute(struct aw_device *aw_dev, bool is_mute)
+{
+	if (is_mute) {
+		aw88081_dev_fade_out(aw_dev);
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_HMUTE_MASK, AW88081_HMUTE_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_HMUTE_MASK, AW88081_HMUTE_DISABLE_VALUE);
+		aw88081_dev_fade_in(aw_dev);
+	}
+}
+
+static void aw88081_dev_uls_hmute(struct aw_device *aw_dev, bool uls_hmute)
+{
+	if (uls_hmute)
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_ULS_HMUTE_MASK,
+				AW88081_ULS_HMUTE_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88081_SYSCTRL_REG,
+				~AW88081_ULS_HMUTE_MASK,
+				AW88081_ULS_HMUTE_DISABLE_VALUE);
+}
+
+static int aw88081_dev_reg_update(struct aw88081 *aw88081,
+					unsigned char *data, unsigned int len)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int read_vol;
+	int data_len, i, ret;
+	int16_t *reg_data;
+	u16 reg_val;
+	u8 reg_addr;
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "reg data is null or len is 0");
+		return -EINVAL;
+	}
+
+	reg_data = (int16_t *)data;
+	data_len = len >> 1;
+
+	if (data_len & 0x1) {
+		dev_err(aw_dev->dev, "data len:%d unsupported",	data_len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data_len; i += 2) {
+		reg_addr = reg_data[i];
+		reg_val = reg_data[i + 1];
+
+		if (reg_addr == AW88081_SYSCTRL_REG) {
+			reg_val &= ~(~AW88081_EN_PA_MASK |
+				    ~AW88081_PWDN_MASK |
+				    ~AW88081_HMUTE_MASK |
+				    ~AW88081_ULS_HMUTE_MASK);
+
+			reg_val |= AW88081_EN_PA_POWER_DOWN_VALUE |
+				   AW88081_PWDN_POWER_DOWN_VALUE |
+				   AW88081_HMUTE_ENABLE_VALUE |
+				   AW88081_ULS_HMUTE_ENABLE_VALUE;
+		}
+
+		if (reg_addr == AW88081_SYSCTRL2_REG) {
+			read_vol = (reg_val & (~AW88081_VOL_MASK)) >>
+				AW88081_VOL_START_BIT;
+			aw_dev->volume_desc.init_volume = read_vol;
+		}
+
+		/* i2stxen */
+		if (reg_addr == AW88081_I2SCTRL3_REG) {
+			/* close tx */
+			reg_val &= AW88081_I2STXEN_MASK;
+			reg_val |= AW88081_I2STXEN_DISABLE_VALUE;
+		}
+
+		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
+		if (ret)
+			return ret;
+	}
+
+	if (aw_dev->prof_cur != aw_dev->prof_index)
+		vol_desc->ctl_volume = 0;
+
+	/* keep min volume */
+	aw88081_dev_set_volume(aw_dev, vol_desc->mute_volume);
+
+	return 0;
+}
+
+static int aw88081_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
+			index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	*prof_name = prof_info->prof_name_list[prof_desc->id];
+
+	return 0;
+}
+
+static int aw88081_dev_get_prof_data(struct aw_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc)
+{
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
+				__func__, index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return 0;
+}
+
+static int aw88081_dev_fw_update(struct aw88081 *aw88081)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	ret = aw88081_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret) {
+		dev_err(aw_dev->dev, "get prof name failed");
+		return -EINVAL;
+	}
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw88081_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret)
+		return ret;
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw88081_dev_reg_update(aw88081, sec_desc[AW88395_DATA_TYPE_REG].data,
+					sec_desc[AW88395_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return 0;
+}
+
+static int aw88081_dev_start(struct aw88081 *aw88081)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	int ret;
+
+	if (aw_dev->status == AW88081_DEV_PW_ON) {
+		dev_dbg(aw_dev->dev, "already power on");
+		return 0;
+	}
+
+	/* power on */
+	aw88081_dev_pwd(aw_dev, false);
+	usleep_range(AW88081_2000_US, AW88081_2000_US + 10);
+
+	ret = aw88081_dev_check_syspll(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/* amppd on */
+	aw88081_dev_amppd(aw_dev, false);
+	usleep_range(AW88081_1000_US, AW88081_1000_US + 50);
+
+	/* check i2s status */
+	ret = aw88081_dev_check_sysst(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	/* enable tx feedback */
+	aw88081_dev_i2s_tx_enable(aw_dev, true);
+
+	/* close uls mute */
+	aw88081_dev_uls_hmute(aw_dev, false);
+
+	/* close mute */
+	aw88081_dev_mute(aw_dev, false);
+
+	/* clear inturrupt */
+	aw88081_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW88081_DEV_PW_ON;
+
+	return 0;
+
+sysst_check_fail:
+	aw88081_dev_i2s_tx_enable(aw_dev, false);
+	aw88081_dev_clear_int_status(aw_dev);
+	aw88081_dev_amppd(aw_dev, true);
+pll_check_fail:
+	aw88081_dev_pwd(aw_dev, true);
+	aw_dev->status = AW88081_DEV_PW_OFF;
+
+	return ret;
+}
+
+static int aw88081_dev_stop(struct aw_device *aw_dev)
+{
+	if (aw_dev->status == AW88081_DEV_PW_OFF) {
+		dev_dbg(aw_dev->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->status = AW88081_DEV_PW_OFF;
+
+	/* clear inturrupt */
+	aw88081_dev_clear_int_status(aw_dev);
+
+	aw88081_dev_uls_hmute(aw_dev, true);
+	/* set mute */
+	aw88081_dev_mute(aw_dev, true);
+
+	/* close tx feedback */
+	aw88081_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
+
+	/* enable amppd */
+	aw88081_dev_amppd(aw_dev, true);
+
+	/* set power down */
+	aw88081_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static int aw88081_reg_update(struct aw88081 *aw88081, bool force)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	int ret;
+
+	if (force) {
+		ret = regmap_write(aw_dev->regmap,
+					AW88081_ID_REG, AW88081_SOFT_RESET_VALUE);
+		if (ret)
+			return ret;
+
+		ret = aw88081_dev_fw_update(aw88081);
+		if (ret)
+			return ret;
+	} else {
+		if (aw_dev->prof_cur != aw_dev->prof_index) {
+			ret = aw88081_dev_fw_update(aw88081);
+			if (ret)
+				return ret;
+		}
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return 0;
+}
+
+static void aw88081_start_pa(struct aw88081 *aw88081)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88081_START_RETRIES; i++) {
+		ret = aw88081_reg_update(aw88081, aw88081->phase_sync);
+		if (ret) {
+			dev_err(aw88081->aw_pa->dev, "fw update failed, cnt:%d\n", i);
+			continue;
+		}
+		ret = aw88081_dev_start(aw88081);
+		if (ret) {
+			dev_err(aw88081->aw_pa->dev, "aw88081 device start failed. retry = %d", i);
+			continue;
+		} else {
+			dev_dbg(aw88081->aw_pa->dev, "start success\n");
+			break;
+		}
+	}
+}
+
+static void aw88081_startup_work(struct work_struct *work)
+{
+	struct aw88081 *aw88081 =
+		container_of(work, struct aw88081, start_work.work);
+
+	mutex_lock(&aw88081->lock);
+	aw88081_start_pa(aw88081);
+	mutex_unlock(&aw88081->lock);
+}
+
+static void aw88081_start(struct aw88081 *aw88081, bool sync_start)
+{
+	if (aw88081->aw_pa->fw_status != AW88081_DEV_FW_OK)
+		return;
+
+	if (aw88081->aw_pa->status == AW88081_DEV_PW_ON)
+		return;
+
+	if (sync_start == AW88081_SYNC_START)
+		aw88081_start_pa(aw88081);
+	else
+		queue_delayed_work(system_wq,
+			&aw88081->start_work,
+			AW88081_START_WORK_DELAY_MS);
+}
+
+static struct snd_soc_dai_driver aw88081_dai[] = {
+	{
+		.name = "aw88081-aif",
+		.id = 1,
+		.playback = {
+			.stream_name = "Speaker_Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88081_RATES,
+			.formats = AW88081_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Speaker_Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88081_RATES,
+			.formats = AW88081_FORMATS,
+		},
+	},
+};
+
+static int aw88081_get_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88081->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
+
+	return 0;
+}
+
+static int aw88081_set_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_in_time) {
+		aw_dev->fade_in_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88081_get_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88081->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
+
+	return 0;
+}
+
+static int aw88081_set_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_out_time) {
+		aw_dev->fade_out_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88081_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	/* check the index whether is valid */
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change */
+	if (aw_dev->prof_index == index)
+		return -EPERM;
+
+	aw_dev->prof_index = index;
+
+	return 0;
+}
+
+static int aw88081_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+	char *prof_name;
+	int count, ret;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw88081->aw_pa->prof_info.count;
+	if (count <= 0) {
+		uinfo->value.enumerated.items = 0;
+		return 0;
+	}
+
+	uinfo->value.enumerated.items = count;
+
+	if (uinfo->value.enumerated.item >= count)
+		uinfo->value.enumerated.item = count - 1;
+
+	count = uinfo->value.enumerated.item;
+
+	ret = aw88081_dev_get_prof_name(aw88081->aw_pa, count, &prof_name);
+	if (ret) {
+		strscpy(uinfo->value.enumerated.name, "null",
+						sizeof(uinfo->value.enumerated.name));
+		return 0;
+	}
+
+	strscpy(uinfo->value.enumerated.name, prof_name, sizeof(uinfo->value.enumerated.name));
+
+	return 0;
+}
+
+static int aw88081_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88081->aw_pa->prof_index;
+
+	return 0;
+}
+
+static int aw88081_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/* pa stop or stopping just set profile */
+	mutex_lock(&aw88081->lock);
+	ret = aw88081_dev_set_profile_index(aw88081->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret) {
+		dev_dbg(codec->dev, "profile index does not change");
+		mutex_unlock(&aw88081->lock);
+		return 0;
+	}
+
+	if (aw88081->aw_pa->status) {
+		aw88081_dev_stop(aw88081->aw_pa);
+		aw88081_start(aw88081, AW88081_SYNC_START);
+	}
+
+	mutex_unlock(&aw88081->lock);
+
+	return 1;
+}
+
+static int aw88081_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88081->aw_pa->volume_desc;
+
+	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
+
+	return 0;
+}
+
+static int aw88081_volume_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88081->aw_pa->volume_desc;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (vol_desc->ctl_volume != value) {
+		vol_desc->ctl_volume = value;
+		aw88081_dev_set_volume(aw88081->aw_pa, vol_desc->ctl_volume);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88081_get_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88081->aw_pa->fade_step;
+
+	return 0;
+}
+
+static int aw88081_set_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw88081->aw_pa->fade_step != value) {
+		aw88081->aw_pa->fade_step = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new aw88081_controls[] = {
+	SOC_SINGLE_EXT("PCM Playback Volume", AW88081_SYSCTRL2_REG,
+		0, AW88081_MUTE_VOL, 0, aw88081_volume_get,
+		aw88081_volume_set),
+	SOC_SINGLE_EXT("Fade Step", 0, 0, AW88081_MUTE_VOL, 0,
+		aw88081_get_fade_step, aw88081_set_fade_step),
+	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, 0,
+		aw88081_get_fade_in_time, aw88081_set_fade_in_time),
+	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, 0,
+		aw88081_get_fade_out_time, aw88081_set_fade_out_time),
+	AW88081_PROFILE_EXT("Profile Set", aw88081_profile_info,
+		aw88081_profile_get, aw88081_profile_set),
+};
+
+static void aw88081_parse_channel_dt(struct aw88081 *aw88081)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 channel_value = AW88081_DEV_DEFAULT_CH;
+
+	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+	aw88081->phase_sync = of_property_read_bool(np, "awinic,sync-flag");
+
+	aw_dev->channel = channel_value;
+}
+
+static int aw88081_init(struct aw88081 *aw88081, struct i2c_client *i2c, struct regmap *regmap)
+{
+	struct aw_device *aw_dev;
+	unsigned int chip_id;
+	int ret;
+
+	/* read chip id */
+	ret = regmap_read(regmap, AW88081_ID_REG, &chip_id);
+	if (ret) {
+		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
+		return ret;
+	}
+	if (chip_id != AW88081_CHIP_ID) {
+		dev_err(&i2c->dev, "unsupported device");
+		return -ENXIO;
+	}
+
+	dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
+
+	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
+	if (!aw_dev)
+		return -ENOMEM;
+
+	aw88081->aw_pa = aw_dev;
+	aw_dev->i2c = i2c;
+	aw_dev->regmap = regmap;
+	aw_dev->dev = &i2c->dev;
+	aw_dev->chip_id = AW88081_CHIP_ID;
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->fade_step = AW88081_VOLUME_STEP_DB;
+	aw_dev->volume_desc.mute_volume = AW88081_MUTE_VOL;
+	aw88081_parse_channel_dt(aw88081);
+
+	return 0;
+}
+
+static int aw88081_dev_init(struct aw88081 *aw88081, struct aw_container *aw_cfg)
+{
+	struct aw_device *aw_dev = aw88081->aw_pa;
+	int ret;
+
+	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW88081_ID_REG, AW88081_SOFT_RESET_VALUE);
+	if (ret)
+		return ret;
+
+	aw_dev->fade_in_time = AW88081_500_US;
+	aw_dev->fade_out_time = AW88081_500_US;
+	aw_dev->prof_cur = AW88081_INIT_PROFILE;
+	aw_dev->prof_index = AW88081_INIT_PROFILE;
+
+	ret = aw88081_dev_fw_update(aw88081);
+	if (ret) {
+		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
+		return ret;
+	}
+
+	aw88081_dev_clear_int_status(aw_dev);
+
+	aw88081_dev_uls_hmute(aw_dev, true);
+
+	aw88081_dev_mute(aw_dev, true);
+
+	usleep_range(AW88081_5000_US, AW88081_5000_US + 10);
+
+	aw88081_dev_i2s_tx_enable(aw_dev, false);
+
+	usleep_range(AW88081_1000_US, AW88081_1000_US + 100);
+
+	aw88081_dev_amppd(aw_dev, true);
+
+	aw88081_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static int aw88081_request_firmware_file(struct aw88081 *aw88081)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw88081->aw_pa->fw_status = AW88081_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW88081_ACF_FILE, aw88081->aw_pa->dev);
+	if (ret)
+		return ret;
+
+	dev_dbg(aw88081->aw_pa->dev, "loaded %s - size: %zu\n",
+			AW88081_ACF_FILE, cont ? cont->size : 0);
+
+	aw88081->aw_cfg = devm_kzalloc(aw88081->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
+	if (!aw88081->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+	aw88081->aw_cfg->len = (int)cont->size;
+	memcpy(aw88081->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw88395_dev_load_acf_check(aw88081->aw_pa, aw88081->aw_cfg);
+	if (ret)
+		return ret;
+
+	mutex_lock(&aw88081->lock);
+	ret = aw88081_dev_init(aw88081, aw88081->aw_cfg);
+	mutex_unlock(&aw88081->lock);
+
+	return ret;
+}
+
+static int aw88081_playback_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&aw88081->lock);
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		aw88081_start(aw88081, AW88081_ASYNC_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		aw88081_dev_stop(aw88081->aw_pa);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&aw88081->lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget aw88081_dapm_widgets[] = {
+	 /* playback */
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, SND_SOC_NOPM, 0, 0,
+					aw88081_playback_event,
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	/* capture */
+	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("ADC Input"),
+};
+
+static const struct snd_soc_dapm_route aw88081_audio_map[] = {
+	{"DAC Output", NULL, "AIF_RX"},
+	{"AIF_TX", NULL, "ADC Input"},
+};
+
+static int aw88081_codec_probe(struct snd_soc_component *component)
+{
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	INIT_DELAYED_WORK(&aw88081->start_work, aw88081_startup_work);
+
+	ret = aw88081_request_firmware_file(aw88081);
+	if (ret)
+		dev_err(aw88081->aw_pa->dev, "%s: request firmware failed\n", __func__);
+
+	return ret;
+}
+
+static void aw88081_codec_remove(struct snd_soc_component *aw_codec)
+{
+	struct aw88081 *aw88081 = snd_soc_component_get_drvdata(aw_codec);
+
+	cancel_delayed_work_sync(&aw88081->start_work);
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw88081 = {
+	.probe = aw88081_codec_probe,
+	.remove = aw88081_codec_remove,
+	.dapm_widgets = aw88081_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aw88081_dapm_widgets),
+	.dapm_routes = aw88081_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(aw88081_audio_map),
+	.controls = aw88081_controls,
+	.num_controls = ARRAY_SIZE(aw88081_controls),
+};
+
+static int aw88081_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw88081 *aw88081;
+	int ret;
+
+	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
+	if (!ret)
+		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed");
+
+	aw88081 = devm_kzalloc(&i2c->dev, sizeof(*aw88081), GFP_KERNEL);
+	if (!aw88081)
+		return -ENOMEM;
+
+	mutex_init(&aw88081->lock);
+
+	i2c_set_clientdata(i2c, aw88081);
+
+	aw88081->regmap = devm_regmap_init_i2c(i2c, &aw88081_regmap_config);
+	if (IS_ERR(aw88081->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw88081->regmap),
+						"failed to init regmap\n");
+
+	/* aw pa init */
+	ret = aw88081_init(aw88081, i2c, aw88081->regmap);
+	if (ret)
+		return ret;
+
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_codec_dev_aw88081,
+			aw88081_dai, ARRAY_SIZE(aw88081_dai));
+}
+
+static const struct i2c_device_id aw88081_i2c_id[] = {
+	{ AW88081_I2C_NAME },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw88081_i2c_id);
+
+static struct i2c_driver aw88081_i2c_driver = {
+	.driver = {
+		.name = AW88081_I2C_NAME,
+	},
+	.probe = aw88081_i2c_probe,
+	.id_table = aw88081_i2c_id,
+};
+module_i2c_driver(aw88081_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW88081 Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88081.h b/sound/soc/codecs/aw88081.h
new file mode 100644
index 000000000000..6757354385a0
--- /dev/null
+++ b/sound/soc/codecs/aw88081.h
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88081.h  --  AW88081 ALSA SoC Audio driver
+//
+// Copyright (c) 2024 awinic Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88081_H__
+#define __AW88081_H__
+
+#define AW88081_ID_REG			(0x00)
+#define AW88081_SYSST_REG		(0x01)
+#define AW88081_SYSINT_REG		(0x02)
+#define AW88081_SYSINTM_REG		(0x03)
+#define AW88081_SYSCTRL_REG		(0x04)
+#define AW88081_SYSCTRL2_REG		(0x05)
+#define AW88081_I2SCTRL1_REG		(0x06)
+#define AW88081_I2SCTRL2_REG		(0x07)
+#define AW88081_I2SCTRL3_REG		(0x08)
+#define AW88081_DACCFG1_REG		(0x09)
+#define AW88081_DACCFG2_REG		(0x0A)
+#define AW88081_DACCFG3_REG		(0x0B)
+#define AW88081_DACCFG4_REG		(0x0C)
+#define AW88081_DACCFG5_REG		(0x0D)
+#define AW88081_DACCFG6_REG		(0x0E)
+#define AW88081_DACCFG7_REG		(0x11)
+#define AW88081_PWMCTRL1_REG		(0x13)
+#define AW88081_PWMCTRL2_REG		(0x14)
+#define AW88081_PWMCTRL3_REG		(0x15)
+#define AW88081_PWMCTRL4_REG		(0x16)
+#define AW88081_I2SCFG1_REG		(0x17)
+#define AW88081_DBGCTRL_REG		(0x18)
+#define AW88081_PDMCTRL_REG		(0x19)
+#define AW88081_DACST_REG		(0x20)
+#define AW88081_PATTERNST_REG		(0x21)
+#define AW88081_I2SINT_REG		(0x26)
+#define AW88081_I2SCAPCNT_REG		(0x27)
+#define AW88081_ANASTA1_REG		(0x28)
+#define AW88081_ANASTA2_REG		(0x29)
+#define AW88081_ANASTA3_REG		(0x2A)
+#define AW88081_VBAT_REG		(0x21)
+#define AW88081_TEMP_REG		(0x22)
+#define AW88081_PVDD_REG		(0x23)
+#define AW88081_ISNDAT_REG		(0x24)
+#define AW88081_VSNDAT_REG		(0x25)
+#define AW88081_DSMCFG1_REG		(0x30)
+#define AW88081_DSMCFG2_REG		(0x31)
+#define AW88081_DSMCFG3_REG		(0x32)
+#define AW88081_DSMCFG4_REG		(0x33)
+#define AW88081_DSMCFG5_REG		(0x34)
+#define AW88081_DSMCFG6_REG		(0x35)
+#define AW88081_DSMCFG7_REG		(0x36)
+#define AW88081_DSMCFG8_REG		(0x37)
+#define AW88081_TESTIN_REG		(0x38)
+#define AW88081_TESTOUT_REG		(0x39)
+#define AW88081_BOPCTRL1_REG		(0x40)
+#define AW88081_BOPCTRL2_REG		(0x41)
+#define AW88081_BOPCTRL3_REG		(0x42)
+#define AW88081_BOPSTA_REG		(0x43)
+#define AW88081_PLLCTRL1_REG		(0x54)
+#define AW88081_PLLCTRL2_REG		(0x55)
+#define AW88081_PLLCTRL3_REG		(0x56)
+#define AW88081_CDACTRL1_REG		(0x57)
+#define AW88081_CDACTRL2_REG		(0x58)
+#define AW88081_CDACTRL3_REG		(0x59)
+#define AW88081_DITHERCFG1_REG		(0x5A)
+#define AW88081_DITHERCFG2_REG		(0x5B)
+#define AW88081_DITHERCFG3_REG		(0x5C)
+#define AW88081_TM_REG			(0x6E)
+#define AW88081_TM2_REG		(0x6F)
+#define AW88081_TESTCTRL1_REG		(0x70)
+#define AW88081_TESTCTRL2_REG		(0x71)
+
+#define AW88081_REG_MAX		(0x72)
+
+#define AW88081_UVLS_START_BIT		(14)
+#define AW88081_UVLS_UVLO		(1)
+#define AW88081_UVLS_UVLO_VALUE	\
+	(AW88081_UVLS_UVLO << AW88081_UVLS_START_BIT)
+
+#define AW88081_SWS_START_BIT		(8)
+#define AW88081_SWS_SWITCHING		(1)
+#define AW88081_SWS_SWITCHING_VALUE	\
+	(AW88081_SWS_SWITCHING << AW88081_SWS_START_BIT)
+
+#define AW88081_NOCLKS_START_BIT	(5)
+#define AW88081_NOCLKS_NO_CLOCK	(1)
+#define AW88081_NOCLKS_NO_CLOCK_VALUE	\
+	(AW88081_NOCLKS_NO_CLOCK << AW88081_NOCLKS_START_BIT)
+
+#define AW88081_CLKS_START_BIT		(4)
+#define AW88081_CLKS_STABLE		(1)
+#define AW88081_CLKS_STABLE_VALUE	\
+	(AW88081_CLKS_STABLE << AW88081_CLKS_START_BIT)
+
+#define AW88081_OCDS_START_BIT		(3)
+#define AW88081_OCDS_OC		(1)
+#define AW88081_OCDS_OC_VALUE		\
+	(AW88081_OCDS_OC << AW88081_OCDS_START_BIT)
+
+#define AW88081_OTHS_START_BIT		(1)
+#define AW88081_OTHS_OT		(1)
+#define AW88081_OTHS_OT_VALUE		\
+	(AW88081_OTHS_OT << AW88081_OTHS_START_BIT)
+
+#define AW88081_PLLS_START_BIT		(0)
+#define AW88081_PLLS_LOCKED		(1)
+#define AW88081_PLLS_LOCKED_VALUE	\
+	(AW88081_PLLS_LOCKED << AW88081_PLLS_START_BIT)
+
+#define AW88081_BIT_PLL_CHECK \
+		(AW88081_CLKS_STABLE_VALUE | \
+		AW88081_PLLS_LOCKED_VALUE)
+
+#define AW88081_BIT_SYSST_CHECK_MASK \
+		(~(AW88081_UVLS_UVLO_VALUE | \
+		AW88081_SWS_SWITCHING_VALUE | \
+		AW88081_NOCLKS_NO_CLOCK_VALUE | \
+		AW88081_CLKS_STABLE_VALUE | \
+		AW88081_OCDS_OC_VALUE | \
+		AW88081_OTHS_OT_VALUE | \
+		AW88081_PLLS_LOCKED_VALUE))
+
+#define AW88081_NO_SWS_SYSST_CHECK \
+		(AW88081_CLKS_STABLE_VALUE | \
+		AW88081_PLLS_LOCKED_VALUE)
+
+#define AW88081_SWS_SYSST_CHECK \
+	(AW88081_SWS_SWITCHING_VALUE | \
+	AW88081_CLKS_STABLE_VALUE | \
+	AW88081_PLLS_LOCKED_VALUE)
+
+#define AW88081_ULS_HMUTE_START_BIT	(14)
+#define AW88081_ULS_HMUTE_BITS_LEN	(1)
+#define AW88081_ULS_HMUTE_MASK		\
+	(~(((1<<AW88081_ULS_HMUTE_BITS_LEN)-1) << AW88081_ULS_HMUTE_START_BIT))
+
+#define AW88081_ULS_HMUTE_DISABLE	(0)
+#define AW88081_ULS_HMUTE_DISABLE_VALUE	\
+	(AW88081_ULS_HMUTE_DISABLE << AW88081_ULS_HMUTE_START_BIT)
+
+#define AW88081_ULS_HMUTE_ENABLE	(1)
+#define AW88081_ULS_HMUTE_ENABLE_VALUE	\
+	(AW88081_ULS_HMUTE_ENABLE << AW88081_ULS_HMUTE_START_BIT)
+
+#define AW88081_HMUTE_START_BIT	(8)
+#define AW88081_HMUTE_BITS_LEN		(1)
+#define AW88081_HMUTE_MASK		\
+	(~(((1<<AW88081_HMUTE_BITS_LEN)-1) << AW88081_HMUTE_START_BIT))
+
+#define AW88081_HMUTE_DISABLE		(0)
+#define AW88081_HMUTE_DISABLE_VALUE	\
+	(AW88081_HMUTE_DISABLE << AW88081_HMUTE_START_BIT)
+
+#define AW88081_HMUTE_ENABLE		(1)
+#define AW88081_HMUTE_ENABLE_VALUE	\
+	(AW88081_HMUTE_ENABLE << AW88081_HMUTE_START_BIT)
+
+#define AW88081_EN_PA_START_BIT	(1)
+#define AW88081_EN_PA_BITS_LEN		(1)
+#define AW88081_EN_PA_MASK		\
+	(~(((1<<AW88081_EN_PA_BITS_LEN)-1) << AW88081_EN_PA_START_BIT))
+
+#define AW88081_EN_PA_WORKING		(1)
+#define AW88081_EN_PA_WORKING_VALUE	\
+	(AW88081_EN_PA_WORKING << AW88081_EN_PA_START_BIT)
+
+#define AW88081_EN_PA_POWER_DOWN	(0)
+#define AW88081_EN_PA_POWER_DOWN_VALUE	\
+	(AW88081_EN_PA_POWER_DOWN << AW88081_EN_PA_START_BIT)
+
+#define AW88081_PWDN_START_BIT		(0)
+#define AW88081_PWDN_BITS_LEN		(1)
+#define AW88081_PWDN_MASK		\
+	(~(((1<<AW88081_PWDN_BITS_LEN)-1) << AW88081_PWDN_START_BIT))
+
+#define AW88081_PWDN_WORKING		(0)
+#define AW88081_PWDN_WORKING_VALUE	\
+	(AW88081_PWDN_WORKING << AW88081_PWDN_START_BIT)
+
+#define AW88081_PWDN_POWER_DOWN	(1)
+#define AW88081_PWDN_POWER_DOWN_VALUE	\
+	(AW88081_PWDN_POWER_DOWN << AW88081_PWDN_START_BIT)
+
+#define AW88081_VOL_START_BIT		(0)
+#define AW88081_VOL_BITS_LEN		(10)
+#define AW88081_VOL_MASK		\
+	(~(((1<<AW88081_VOL_BITS_LEN)-1) << AW88081_VOL_START_BIT))
+
+#define AW88081_VOLUME_STEP_DB		(64)
+#define AW88081_MUTE_VOL		(1023)
+
+#define AW88081_I2STXEN_START_BIT	(6)
+#define AW88081_I2STXEN_BITS_LEN	(1)
+#define AW88081_I2STXEN_MASK		\
+	(~(((1<<AW88081_I2STXEN_BITS_LEN)-1) << AW88081_I2STXEN_START_BIT))
+
+#define AW88081_I2STXEN_DISABLE	(0)
+#define AW88081_I2STXEN_DISABLE_VALUE	\
+	(AW88081_I2STXEN_DISABLE << AW88081_I2STXEN_START_BIT)
+
+#define AW88081_I2STXEN_ENABLE		(1)
+#define AW88081_I2STXEN_ENABLE_VALUE	\
+	(AW88081_I2STXEN_ENABLE << AW88081_I2STXEN_START_BIT)
+
+#define AW88081_NOISE_GATE_EN_START_BIT	(13)
+#define AW88081_NOISE_GATE_EN_BITS_LEN	(1)
+#define AW88081_NOISE_GATE_EN_MASK	\
+		(~(((1<<AW88081_NOISE_GATE_EN_BITS_LEN)-1) << AW88081_NOISE_GATE_EN_START_BIT))
+
+#define AW88081_NOISE_GATE_EN_DISABLE	(0)
+#define AW88081_NOISE_GATE_EN_DISABLE_VALUE	\
+		(AW88081_NOISE_GATE_EN_DISABLE << AW88081_NOISE_GATE_EN_START_BIT)
+
+#define AW88081_NOISE_GATE_EN_ENABLE	(1)
+#define AW88081_NOISE_GATE_EN_ENABLE_VALUE	\
+		(AW88081_NOISE_GATE_EN_ENABLE << AW88081_NOISE_GATE_EN_START_BIT)
+
+#define AW88081_CCO_MUX_START_BIT	(13)
+#define AW88081_CCO_MUX_BITS_LEN	(1)
+#define AW88081_CCO_MUX_MASK		\
+	(~(((1<<AW88081_CCO_MUX_BITS_LEN)-1) << AW88081_CCO_MUX_START_BIT))
+
+#define AW88081_CCO_MUX_DIVIDED	(0)
+#define AW88081_CCO_MUX_DIVIDED_VALUE	\
+	(AW88081_CCO_MUX_DIVIDED << AW88081_CCO_MUX_START_BIT)
+
+#define AW88081_CCO_MUX_BYPASS		(1)
+#define AW88081_CCO_MUX_BYPASS_VALUE	\
+	(AW88081_CCO_MUX_BYPASS << AW88081_CCO_MUX_START_BIT)
+
+#define AW88081_START_RETRIES		(5)
+#define AW88081_START_WORK_DELAY_MS	(0)
+
+#define AW88081_I2C_NAME		"aw88081"
+#define AW88081_CHIP_ID		0x2116
+
+#define AW88081_RATES (SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_96000)
+#define AW88081_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define FADE_TIME_MAX			100000
+
+#define AW88081_DEV_DEFAULT_CH		(0)
+#define AW88081_ACF_FILE		"aw88081_acf.bin"
+#define AW88081_DEV_SYSST_CHECK_MAX	(10)
+#define AW88081_SOFT_RESET_VALUE	(0x55aa)
+
+#define AW88081_INIT_PROFILE		(0)
+
+#define AW88081_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum {
+	AW88081_SYNC_START = 0,
+	AW88081_ASYNC_START,
+};
+
+enum {
+	AW88081_500_US = 500,
+	AW88081_1000_US = 1000,
+	AW88081_2000_US = 2000,
+	AW88081_5000_US = 5000,
+};
+
+enum {
+	AW88081_DEV_PW_OFF = 0,
+	AW88081_DEV_PW_ON,
+};
+
+enum {
+	AW88081_DEV_FW_FAILED = 0,
+	AW88081_DEV_FW_OK,
+};
+
+#endif
-- 
2.47.0



Return-Path: <linux-kernel+bounces-246744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CE392C620
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA85C2810D8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E383193478;
	Tue,  9 Jul 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="n/47RBjV"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337B18FA36;
	Tue,  9 Jul 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563152; cv=none; b=db3Rbv5+PBiuBD0MYxK1HsEHD7lK62M6YKZJFmef+pmYNXP+z6MSoCIPZ1jakfrx1kxh6Cr0/OCSrCgzM0fp5A77j6FdkVCLIgXC/G0XKVznT6wUHoEYOuQ0RpXojqjfBhq9HVaJgK4b2kO4uzha3Hez/9KOV7j3KglH6voMiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563152; c=relaxed/simple;
	bh=xiHVcLWmlWCeXd/xOCMugnSGn8XEcFa6WmCYs7z1GZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rw5tbyN4SQjHWz/g90Z84bTKyCBC53Na5zDJb4WhWcCPIHoVD06VKvsadzTbPnAL1SZ21OWqDyAh/Hpl5T0PgT3Xn3AMOB8cNJTmgYeGMW6+tR5U0OIxbnHsKO5lo2Tp1xL8CqrOKJhHWsd2aaLWMiuohTQuwUgve9EQTweVjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=n/47RBjV; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8E46712000C;
	Wed, 10 Jul 2024 01:12:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8E46712000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720563148;
	bh=ow841DWBqkgErrVIEcSy9LNkBmP48KjNiO7CVdsKRRI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=n/47RBjVSG4wtfxfW0XPQiJQMEbHSaXqx92fzaglavQOm/arsyrd3YKOA01guLX3C
	 MVyzEYMQJaTa8/E/ofIoQH/rRyWJvk+jTxttSS1MgVh5VG3K7Ok0iMZ/HzHU35ozrc
	 HPAielzbwbVbVA8UIlBUtJLfHkUJPOOh1dRmpaAwadMnrps5OBFEHBZxYoINVpQW0v
	 D8QSuM83AonOsgjVuF5hqORsDmAiGbUKpoXS2Nvy+351KQ5JiQTXbPKNBrPFk1AfEp
	 VEGAB7yQd1JiX7i2TpFCshcrKJPTxX0Rca5k/r5S64fOcoYRhewRIVgb6+IOFilLsr
	 mCrYYCu+tiMqw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jul 2024 01:12:28 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jul 2024 01:12:28 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
Date: Wed, 10 Jul 2024 01:12:01 +0300
Message-ID: <20240709221203.92167-5-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709221203.92167-1-ivprusov@salutedevices.com>
References: <20240709221203.92167-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186406 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;datasheetspdf.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 21:28:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 21:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 21:28:00 #25931284
X-KSMG-AntiVirus-Status: Clean, skipped

The NeoFidelity NTP8918 is a two channel amplifier with mixer and
biquad filters.

Datasheet: https://datasheetspdf.com/pdf-down/N/T/P/NTP8918-NeoFidelity.pdf
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 sound/soc/codecs/Kconfig   |   5 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/ntp8918.c | 356 +++++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 sound/soc/codecs/ntp8918.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9583243f1966..d16c983fcb7a 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2495,6 +2495,11 @@ config SND_SOC_NAU8825
 config SND_SOC_NTPFW
 	tristate
 
+config SND_SOC_NTP8918
+	select SND_SOC_NTPFW
+	tristate "NeoFidelity NTP8918 amplifier"
+	depends on I2C
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index eae4ab047c72..a49ab11a98ec 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -183,6 +183,7 @@ snd-soc-nau8821-y := nau8821.o
 snd-soc-nau8822-y := nau8822.o
 snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
+snd-soc-ntp8918-y := ntp8918.o
 snd-soc-ntpfw-y := ntpfw.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
 snd-soc-pcm1681-y := pcm1681.o
@@ -576,6 +577,7 @@ obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
 obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
+obj-$(CONFIG_SND_SOC_NTP8918)	+= snd-soc-ntp8918.o
 obj-$(CONFIG_SND_SOC_NTPFW)	+= snd-soc-ntpfw.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
diff --git a/sound/soc/codecs/ntp8918.c b/sound/soc/codecs/ntp8918.c
new file mode 100644
index 000000000000..185f8b235138
--- /dev/null
+++ b/sound/soc/codecs/ntp8918.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the NTP8918 Audio Amplifier
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/reset.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#include <sound/initval.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-component.h>
+#include <sound/tlv.h>
+
+#include "ntpfw.h"
+
+#define NTP8918_RATES   (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+			 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+
+#define NTP8918_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
+			     SNDRV_PCM_FMTBIT_S20_3LE | \
+			     SNDRV_PCM_FMTBIT_S24_LE | \
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+#define NTP8918_INPUT_FMT			0x0
+#define  NTP8918_INPUT_FMT_MASTER_MODE		BIT(0)
+#define  NTP8918_INPUT_FMT_GSA_MODE		BIT(1)
+#define NTP8918_GSA_FMT				0x1
+#define  NTP8918_GSA_BS_MASK			GENMASK(3, 2)
+#define  NTP8918_GSA_BS(x)			((x) << 2)
+#define  NTP8918_GSA_RIGHT_J			BIT(0)
+#define  NTP8918_GSA_LSB			BIT(1)
+#define NTP8918_MASTER_VOL			0x0C
+#define NTP8918_CHNL_A_VOL			0x17
+#define NTP8918_CHNL_B_VOL			0x18
+#define NTP8918_SOFT_MUTE			0x33
+#define REG_MAX					NTP8918_SOFT_MUTE
+
+#define NTP8918_FW_NAME		"eq_8918.bin"
+#define NTP8918_FW_MAGIC	0x38393138	/* "8918" */
+
+struct ntp8918_priv {
+	struct i2c_client *i2c;
+	struct reset_control *reset;
+	unsigned int format;
+};
+
+static const DECLARE_TLV_DB_SCALE(ntp8918_master_vol_scale, -12550, 50, 0);
+
+static const struct snd_kcontrol_new ntp8918_vol_control[] = {
+	SOC_SINGLE_RANGE_TLV("Playback Volume", NTP8918_MASTER_VOL, 0,
+			     0x04, 0xff, 0, ntp8918_master_vol_scale),
+	SOC_DOUBLE("Playback Switch", NTP8918_SOFT_MUTE, 1, 0, 1, 1),
+};
+
+static void ntp8918_reset_gpio(struct ntp8918_priv *ntp8918, bool active)
+{
+	if (active) {
+		/*
+		 * According to NTP8918 datasheet, 6.2 Timing Sequence 1:
+		 * Deassert for T2 >= 1ms...
+		 */
+		reset_control_deassert(ntp8918->reset);
+		fsleep(1000);
+
+		/* ...Assert for T3 >= 0.1us... */
+		reset_control_assert(ntp8918->reset);
+		fsleep(1);
+
+		/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
+		reset_control_deassert(ntp8918->reset);
+		fsleep(500);
+	} else {
+		reset_control_assert(ntp8918->reset);
+	}
+}
+
+static const struct reg_sequence ntp8918_sound_off[] = {
+	{ NTP8918_MASTER_VOL, 0 },
+};
+
+static const struct reg_sequence ntp8918_sound_on[] = {
+	{ NTP8918_MASTER_VOL, 0b11 },
+};
+
+static int ntp8918_load_firmware(struct ntp8918_priv *ntp8918)
+{
+	int ret;
+
+	ret = ntpfw_load(ntp8918->i2c, NTP8918_FW_NAME, NTP8918_FW_MAGIC);
+	if (ret == -ENOENT) {
+		dev_warn_once(&ntp8918->i2c->dev, "Could not find firmware %s\n",
+			      NTP8918_FW_NAME);
+		return 0;
+	}
+
+	return ret;
+}
+
+static int ntp8918_snd_suspend(struct snd_soc_component *component)
+{
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(component->regmap, true);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8918_sound_off,
+					ARRAY_SIZE(ntp8918_sound_off));
+
+	/*
+	 * According to NTP8918 datasheet, 6.2 Timing Sequence 1:
+	 * wait after sound off for T6 >= 0.5ms
+	 */
+	fsleep(500);
+	ntp8918_reset_gpio(ntp8918, false);
+
+	regcache_mark_dirty(component->regmap);
+
+	return 0;
+}
+
+static int ntp8918_snd_resume(struct snd_soc_component *component)
+{
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ntp8918_reset_gpio(ntp8918, true);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8918_sound_on,
+					ARRAY_SIZE(ntp8918_sound_on));
+
+	ret = ntp8918_load_firmware(ntp8918);
+	if (ret) {
+		dev_err(&ntp8918->i2c->dev, "Failed to load firmware\n");
+		return ret;
+	}
+
+	regcache_cache_only(component->regmap, false);
+	snd_soc_component_cache_sync(component);
+
+	return 0;
+}
+
+static int ntp8918_probe(struct snd_soc_component *component)
+{
+	int ret;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+
+	ret = snd_soc_add_component_controls(component, ntp8918_vol_control,
+					     ARRAY_SIZE(ntp8918_vol_control));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add controls\n");
+
+	ret = ntp8918_load_firmware(ntp8918);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to load firmware\n");
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget ntp8918_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AIFIN", "Playback", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+};
+
+static const struct snd_soc_dapm_route ntp8918_dapm_routes[] = {
+	{ "OUT1", NULL, "AIFIN" },
+	{ "OUT2", NULL, "AIFIN" },
+};
+
+static const struct snd_soc_component_driver soc_component_ntp8918 = {
+	.probe = ntp8918_probe,
+	.suspend = ntp8918_snd_suspend,
+	.resume = ntp8918_snd_resume,
+	.dapm_widgets = ntp8918_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ntp8918_dapm_widgets),
+	.dapm_routes = ntp8918_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ntp8918_dapm_routes),
+};
+
+static int ntp8918_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	unsigned int input_fmt = 0;
+	unsigned int gsa_fmt = 0;
+	unsigned int gsa_fmt_mask;
+	int ret;
+
+	switch (ntp8918->format) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		input_fmt |= NTP8918_INPUT_FMT_GSA_MODE;
+		gsa_fmt |= NTP8918_GSA_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		input_fmt |= NTP8918_INPUT_FMT_GSA_MODE;
+		break;
+	}
+
+	ret = snd_soc_component_update_bits(component, NTP8918_INPUT_FMT,
+					    NTP8918_INPUT_FMT_MASTER_MODE |
+					    NTP8918_INPUT_FMT_GSA_MODE,
+					    input_fmt);
+
+	if (!(input_fmt & NTP8918_INPUT_FMT_GSA_MODE) || ret < 0)
+		return ret;
+
+	switch (params_width(params)) {
+	case 24:
+		gsa_fmt |= NTP8918_GSA_BS(0);
+		break;
+	case 20:
+		gsa_fmt |= NTP8918_GSA_BS(1);
+		break;
+	case 18:
+		gsa_fmt |= NTP8918_GSA_BS(2);
+		break;
+	case 16:
+		gsa_fmt |= NTP8918_GSA_BS(3);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gsa_fmt_mask = NTP8918_GSA_BS_MASK |
+		       NTP8918_GSA_RIGHT_J |
+		       NTP8918_GSA_LSB;
+	return snd_soc_component_update_bits(component, NTP8918_GSA_FMT,
+					     gsa_fmt_mask, gsa_fmt);
+}
+
+static int ntp8918_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_LEFT_J:
+		ntp8918->format = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+struct snd_soc_dai_ops ntp8918_dai_ops = {
+	.hw_params = ntp8918_hw_params,
+	.set_fmt = ntp8918_set_fmt,
+};
+
+static struct snd_soc_dai_driver ntp8918_dai = {
+	.name = "ntp8918-amplifier",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = NTP8918_RATES,
+		.formats = NTP8918_FORMATS,
+	},
+	.ops = &ntp8918_dai_ops,
+};
+
+static struct regmap_config ntp8918_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ntp8918_i2c_probe(struct i2c_client *i2c)
+{
+	struct ntp8918_priv *ntp8918;
+	int ret;
+	struct regmap *regmap;
+
+	ntp8918 = devm_kzalloc(&i2c->dev, sizeof(struct ntp8918_priv), GFP_KERNEL);
+	if (!ntp8918)
+		return -ENOMEM;
+
+	ntp8918->i2c = i2c;
+
+	ntp8918->reset = devm_reset_control_get_shared(&i2c->dev, NULL);
+	if (IS_ERR(ntp8918->reset))
+		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8918->reset), "Failed to get reset\n");
+
+	dev_set_drvdata(&i2c->dev, ntp8918);
+
+	ntp8918_reset_gpio(ntp8918, true);
+
+	regmap = devm_regmap_init_i2c(i2c, &ntp8918_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to allocate regmap\n");
+
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8918,
+					      &ntp8918_dai, 1);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to register component\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id ntp8918_i2c_id[] = {
+	{ "ntp8918", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ntp8918_i2c_id);
+
+static const struct of_device_id ntp8918_of_match[] = {
+	{.compatible = "neofidelity,ntp8918"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ntp8918_of_match);
+
+static struct i2c_driver ntp8918_i2c_driver = {
+	.probe = ntp8918_i2c_probe,
+	.id_table = ntp8918_i2c_id,
+	.driver = {
+		.name = "NTP8918",
+		.of_match_table = ntp8918_of_match,
+	},
+};
+module_i2c_driver(ntp8918_i2c_driver);
+
+MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
+MODULE_DESCRIPTION("NTP8918 Audio Amplifier Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1



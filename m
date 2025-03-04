Return-Path: <linux-kernel+bounces-544509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC75A4E1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026377A692E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5B279339;
	Tue,  4 Mar 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BqKCb6wd"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9526265CA3;
	Tue,  4 Mar 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099820; cv=none; b=ZSHjPIQFHNsGkj12wFQKfMUrH/s1RhP86k11LaA1MC+v3POh6xtZLpn0HRfxj0/p/0verckPyLJ1pZ5JuWycPGxAGEXSIcQL3eS4W/psKeDEcbHG9dpl9IDa4TNKKSI6QJRE2fK6SE3+s2ngfHrXYThaomIxz+w39VVHoQ+2bDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099820; c=relaxed/simple;
	bh=bT4VTJh7PzynB+ATyCSsKg9bsPC7BMXVvWTE719uInM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OoBIOnWkKivNCVFGV7stP/SzXJGoBsXmx8iEJcy4rVKs3oxJqChJAs/9cyJPv7S2eac2wZ+uvcGs1lxfCy6J0U2czLoyh3H53rcJ0NP8LzayNjw0iKG7RbrdO/IJaXEFMRudwVq5uudFCarIpsUq02/8lIq17/8mpkcNal4lJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BqKCb6wd; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5245gdk0021938;
	Tue, 4 Mar 2025 08:50:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/NyZ7xqWW1rXwrmDBBkLwvQwY/oULIoqHA0fdOdKXig=; b=
	BqKCb6wdJVOheoE9Z9EXLHanGwJoFb8f9Uay8STob7UvJPMkOzTW4c+FVMqRfLz1
	JxAFzvjBxZRZDek2MIBqhcJHo5UJ8qAXlH4eZjIbL1g3GOipjYiSl4VOm59pQFsc
	y9OjTmkDmnvBMRydpVkWPjZI3tIK0tYRUYzgbytQw0ERSNgrjlBgXPoOM8CDLo9u
	GuBa2njWkZXYl7Q2ewYWsmn8Tzf70V4BZo6h7NeSuKTtJWU8VPJlqC4enlLIb2H8
	jdqAuR26hTEyLaCzj8nYIidTpBQMDEGoqB2h1vbgkRGcYkBZLPwn5KhxX3GSfX68
	H1vKAyO42PYZIJZqaKrVnw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyyj3j1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:50:14 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:50:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:50:11 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 15BA382026B;
	Tue,  4 Mar 2025 14:50:11 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH for-next 1/2] ASoC: Intel: Add sof_cs35l56 driver for CS35L56 on SSP2.
Date: Tue, 4 Mar 2025 14:50:09 +0000
Message-ID: <20250304145010.288082-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304145010.288082-1-rf@opensource.cirrus.com>
References: <20250304145010.288082-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QwNAgtvo0F472o5qJ31rfCc8s89UOGXL
X-Proofpoint-ORIG-GUID: QwNAgtvo0F472o5qJ31rfCc8s89UOGXL
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c71326 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=Vush7cvIOsCFoR2itYsA:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

Adds a SOF machine driver for CS35L56 using TDM over SSP2.

This sets up an audio configuration of:

48kHz, DSP_A, 8 TDM slots of 16-bits.
SSP2 Playback (2 ch) -> slot 0 and 1, shared by all CS35L56.
SSP2 Capture (8ch) <- Two slots per CS35L56.

This gives stereo playback to all amps, and 8-channel capture
for feedback of 2 channels per amp for 4x amps.

The amps on the CDB35L56-FOUR board can be controlled either over
I2C or SPI, and this affects the device name of the instantiated codec
drivers. The intantiated DAIs are auto-detected by looking for a struct
snd_soc_dai_link_component list that matches the codec DAIs present in
the system.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                          |   1 +
 sound/soc/intel/boards/Kconfig       |  15 ++
 sound/soc/intel/boards/Makefile      |   2 +
 sound/soc/intel/boards/sof_cs35l56.c | 254 +++++++++++++++++++++++++++
 4 files changed, 272 insertions(+)
 create mode 100644 sound/soc/intel/boards/sof_cs35l56.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68aa12e44973..4ef5b22e0c3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5537,6 +5537,7 @@ F:	sound/pci/hda/cs*
 F:	sound/pci/hda/hda_component*
 F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
+F:	sound/soc/intel/boards/sof_cs35l56.c
 
 CIRRUS LOGIC HAPTIC DRIVERS
 M:	James Ogletree <jogletre@opensource.cirrus.com>
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 9b80b19bb8d0..4954bc67a45a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -346,6 +346,21 @@ config SND_SOC_INTEL_SOF_RT5682_MACH
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
+config SND_SOC_INTEL_SOF_CS35L56_MACH
+	tristate "SOF with cs35l56 codec on SSP"
+	depends on I2C || SPI_MASTER
+	depends on ACPI
+	depends on (MFD_INTEL_LPSS || COMPILE_TEST)
+	select SND_SOC_CS35L56_I2C if I2C
+	select SND_SOC_CS35L56_SPI if SPI_MASTER
+	select SND_SOC_INTEL_HDA_DSP_COMMON
+	select SND_SOC_INTEL_SOF_BOARD_HELPERS
+	help
+	   This adds support for ASoC machine driver for SOF platforms
+	   with cs35l56 Smart Amp on SSP port.
+	   Say Y if you have such a device.
+	   If unsure select "N".
+
 config SND_SOC_INTEL_SOF_CS42L42_MACH
 	tristate "SOF with cs42l42 codec in I2S Mode"
 	depends on I2C && ACPI
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index fcd517d6c279..861805ebc342 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -17,6 +17,7 @@ snd-soc-sst-byt-cht-da7213-y := bytcht_da7213.o
 snd-soc-sst-byt-cht-es8316-y := bytcht_es8316.o
 snd-soc-sst-byt-cht-nocodec-y := bytcht_nocodec.o
 snd-soc-sof_rt5682-y := sof_rt5682.o
+snd-soc-sof_cs35l56-y := sof_cs35l56.o
 snd-soc-sof_cs42l42-y := sof_cs42l42.o
 snd-soc-sof_es8336-y := sof_es8336.o
 snd-soc-sof_nau8825-y := sof_nau8825.o
@@ -27,6 +28,7 @@ snd-soc-sof-ssp-amp-y := sof_ssp_amp.o
 snd-soc-sof-sdw-y += sof_sdw.o				\
 			sof_sdw_hdmi.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH) += snd-soc-sof_rt5682.o
+obj-$(CONFIG_SND_SOC_INTEL_SOF_CS35L56_MACH) += snd-soc-sof_cs35l56.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH) += snd-soc-sof_cs42l42.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH) += snd-soc-sof_es8336.o
 obj-$(CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH) += snd-soc-sof_nau8825.o
diff --git a/sound/soc/intel/boards/sof_cs35l56.c b/sound/soc/intel/boards/sof_cs35l56.c
new file mode 100644
index 000000000000..9b7248e25142
--- /dev/null
+++ b/sound/soc/intel/boards/sof_cs35l56.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include "../common/soc-intel-quirks.h"
+#include "sof_board_helpers.h"
+
+#define CS35L56_LINK_ORDER	SOF_LINK_ORDER(SOF_LINK_AMP,		\
+					       SOF_LINK_CODEC,		\
+					       SOF_LINK_DMIC01,		\
+					       SOF_LINK_DMIC16K,	\
+					       SOF_LINK_IDISP_HDMI,	\
+					       SOF_LINK_HDMI_IN,	\
+					       SOF_LINK_NONE)
+
+static const struct snd_soc_dapm_widget sof_widgets[] = {
+	SND_SOC_DAPM_HP("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route sof_map[] = {
+	{"Speaker", NULL, "AMP1 SPK"},
+	{"Speaker", NULL, "AMP2 SPK"},
+	{"Speaker", NULL, "AMP3 SPK"},
+	{"Speaker", NULL, "AMP4 SPK"},
+};
+
+/* sof audio machine driver for cs35l56 codec */
+static struct snd_soc_card sof_audio_card_cs35l56 = {
+	.name = "cs35l56", /* the sof- prefix is added by the core */
+	.owner = THIS_MODULE,
+	.dapm_widgets = sof_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sof_widgets),
+	.dapm_routes = sof_map,
+	.num_dapm_routes = ARRAY_SIZE(sof_map),
+	.fully_routed = true,
+};
+
+static struct snd_soc_dai_link_component cs35l56_component_i2c[] = {
+	{
+		.name = "i2c-CSC355C:00",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "i2c-CSC355C:01",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "i2c-CSC355C:02",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "i2c-CSC355C:03",
+		.dai_name = "cs35l56-asp1",
+	},
+};
+
+static struct snd_soc_dai_link_component cs35l56_component_spi[] = {
+	{
+		.name = "spi-CSC355C:00",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "spi-CSC355C:01",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "spi-CSC355C:02",
+		.dai_name = "cs35l56-asp1",
+	},
+	{
+		.name = "spi-CSC355C:03",
+		.dai_name = "cs35l56-asp1",
+	},
+};
+
+struct cs35l56_dlc_entry {
+	struct snd_soc_dai_link_component *dlc;
+	int n_dlc;
+};
+
+static const struct cs35l56_dlc_entry cs35l56_components[] = {
+	{ cs35l56_component_i2c, ARRAY_SIZE(cs35l56_component_i2c) },
+	{ cs35l56_component_spi, ARRAY_SIZE(cs35l56_component_spi) },
+};
+
+static const char * const sof_cs35l56_name_prefixes[] = {
+	"AMP1", "AMP2", "AMP3", "AMP4",
+};
+
+static int sof_cs35l56_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int i, ret;
+	unsigned int rx_mask = 3;
+	struct snd_soc_dai *codec_dai;
+
+	/* SSP has 8 x 16-bit sample slots and FSYNC=48000, BCLK=6.144 MHz */
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, rx_mask, 8, 16);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, 6144000, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+
+		rx_mask <<= 2;
+	}
+
+	return 0;
+}
+
+static int sof_audio_card_cs35l56_add_name_prefixes(struct device *dev)
+{
+	struct snd_soc_codec_conf *confs;
+	struct snd_soc_dai_link_component *codec;
+	int num_codecs = sof_audio_card_cs35l56.dai_link->num_codecs;
+	int conf_idx, i;
+
+	confs = devm_kcalloc(dev, num_codecs, sizeof(*confs), GFP_KERNEL);
+	if (!confs)
+		return -ENOMEM;
+
+	/* Assumes dailink 0 contains one codec entry per codec */
+	conf_idx = 0;
+	for (i = 0; i < num_codecs; ++i) {
+		codec = snd_soc_link_to_codec(&sof_audio_card_cs35l56.dai_link[0], i);
+		confs[conf_idx].dlc.name = codec->name;
+		confs[conf_idx].name_prefix = sof_cs35l56_name_prefixes[conf_idx];
+		conf_idx++;
+	}
+
+	sof_audio_card_cs35l56.codec_conf = confs;
+	sof_audio_card_cs35l56.num_configs = conf_idx;
+
+	return 0;
+}
+
+static int sof_audio_card_cs35l56_find_codecs(struct device *dev,
+					      const struct cs35l56_dlc_entry *dlce)
+{
+	struct snd_soc_dai_link_component *dlc = dlce->dlc;
+	int n;
+
+	for (n = 0; n < dlce->n_dlc; ++n) {
+		dev_info(dev, "Looking for (%s) on (%s)\n", dlc[n].dai_name, dlc[n].name);
+		if (!snd_soc_find_dai_with_mutex(&dlc[n]))
+			return -ENODEV;
+	}
+
+	return n;
+}
+
+static int sof_card_dai_links_create(struct device *dev, struct snd_soc_card *card,
+				     struct sof_card_private *ctx)
+{
+	struct snd_soc_dai_link_component *dlc = NULL;
+	int i, num_codecs, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_components); ++i) {
+		num_codecs = sof_audio_card_cs35l56_find_codecs(dev, &cs35l56_components[i]);
+		if (num_codecs > 0) {
+			dlc = cs35l56_components[i].dlc;
+			break;
+		}
+	}
+	if (!dlc) {
+		dev_warn(dev, "Couldn't find amp\n");
+		return -EPROBE_DEFER;
+	}
+
+	ret = sof_intel_board_set_dai_link(dev, card, ctx);
+	if (ret)
+		return ret;
+
+	if (!ctx->amp_link) {
+		dev_err(dev, "Amp link not available");
+		return -EINVAL;
+	}
+
+	ctx->amp_link->codecs = dlc;
+	ctx->amp_link->num_codecs = num_codecs;
+	ctx->amp_link->init = sof_cs35l56_init;
+
+	return 0;
+}
+
+static int sof_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
+	unsigned long sof_cs35l56_quirk = (unsigned long)pdev->id_entry->driver_data;
+	struct sof_card_private *ctx;
+	int ret;
+
+	dev_dbg(&pdev->dev, "sof_cs35l56_quirk = %lx\n", sof_cs35l56_quirk);
+
+	ctx = sof_intel_board_get_ctx(&pdev->dev, sof_cs35l56_quirk);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->link_order_overwrite = CS35L56_LINK_ORDER;
+
+	ret = sof_card_dai_links_create(&pdev->dev, &sof_audio_card_cs35l56, ctx);
+	if (ret)
+		return ret;
+
+	ret = sof_audio_card_cs35l56_add_name_prefixes(&pdev->dev);
+	if (ret)
+		return ret;
+
+	sof_audio_card_cs35l56.dev = &pdev->dev;
+
+	/* set platform name for each dailink */
+	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_cs35l56,
+						    mach->mach_params.platform);
+	if (ret)
+		return ret;
+
+	snd_soc_card_set_drvdata(&sof_audio_card_cs35l56, ctx);
+
+	return devm_snd_soc_register_card(&pdev->dev, &sof_audio_card_cs35l56);
+}
+
+static const struct platform_device_id board_ids[] = {
+	{
+		.name = "tgl_cs35l56_ssp2_def",
+		.driver_data = (kernel_ulong_t)(SOF_SSP_PORT_AMP(2)),
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, board_ids);
+
+static struct platform_driver sof_audio = {
+	.probe = sof_audio_probe,
+	.driver = {
+		.name = "sof_cs35l56",
+		.pm = &snd_soc_pm_ops,
+	},
+	.id_table = board_ids,
+};
+module_platform_driver(sof_audio)
+
+/* Module information */
+MODULE_DESCRIPTION("SOF Audio Machine driver for CS35L56");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SND_SOC_INTEL_SOF_BOARD_HELPERS");
-- 
2.39.5



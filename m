Return-Path: <linux-kernel+bounces-531634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD54A44311
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360F5189A822
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CF26B081;
	Tue, 25 Feb 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m1kmohEL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8472F26E628;
	Tue, 25 Feb 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494123; cv=none; b=CXEA/ihMZAKoMLVhG/t6kHc9zZfpNjlH1Urn3BveNCuGdtIsNWFWP8smOZXacYxDy8gO1jwmKEbxlNHVxfV2uGJPevPucV+7zR4ndXmOl8mMoZW1gXC+KcF4x2XSExaOTSjJpwPzL/S7UsMGZ34BXNp2uRpaNE5Hb61dcc+LS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494123; c=relaxed/simple;
	bh=OiZiSyyZ7MKNxaXd9AwEz7Pn4Wq9TqoFSQi1iVVYsvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhRe50HOinqujOA+DATmJPZRnf9F/xF8fRmKA8mRXW1pQJUzWo7u4Gi5xNqktQrPUDuZPRdoDGXchDdR0YWuReqB0gxkkmFmrHgJlNy/D6mzs549qumT54dsogCO4EgqdzBUMw4lvG9PcjDl6KwJXmT/lt+rNvEcgTDRtelTzDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m1kmohEL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494119;
	bh=OiZiSyyZ7MKNxaXd9AwEz7Pn4Wq9TqoFSQi1iVVYsvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m1kmohEL9k0eEQLfDY98oEsj6T/su08C8P/CPaBxgFFyAfzNpNl6MM8SgT4WN/so0
	 JV4MG9eAqM0pU6rSbzdmNLfFyGbuXYQza09rPclVja5xCOkv8quhUzfUJvqY/hqM1H
	 K24rzejGD88St+Vn8cDbCJ5vamRlMIghZGatGrQG7AjJPnITQUI6Qxef9ct80p+ioo
	 oEJRVhmSe8lMs+Puiw55CBxQRQRY4p+PgO5IkzCZL3Ou7gfp/u5RBLHBb9yT/5x2Qy
	 d/WokmAZddiYTNckKmEZY8ulOeLQNUCNclFP5imHuCsJHqrd05LVzM4LtE8LKztf+S
	 jrD2TDTgIn1LA==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1078F17E0E91;
	Tue, 25 Feb 2025 15:35:14 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 25 Feb 2025 11:33:50 -0300
Subject: [PATCH v2 4/8] ASoC: mediatek: mt8188: Add support for DMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-genio700-dmic-v2-4-3076f5b50ef7@collabora.com>
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
In-Reply-To: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

From: parkeryang <Parker.Yang@mediatek.com>

Add support for the DMIC DAIs present on the MT8188 SoC. To achieve
that, add a DAI driver for DMIC and register it during probe, and
describe the AFE routes that connect the DMIC (I004-I011) to the UL9
frontend (O002-O009).

Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/Makefile            |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-common.h |   1 +
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |  24 +
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c   | 682 ++++++++++++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-reg.h        |  17 +-
 5 files changed, 723 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
index 1178bce45c50ba252672a32b3877732a5a76c610..b9f3e4ad7b07ba9e21c846706371c53269f894db 100644
--- a/sound/soc/mediatek/mt8188/Makefile
+++ b/sound/soc/mediatek/mt8188/Makefile
@@ -6,6 +6,7 @@ snd-soc-mt8188-afe-y := \
 	mt8188-afe-pcm.o \
 	mt8188-audsys-clk.o \
 	mt8188-dai-adda.o \
+	mt8188-dai-dmic.o \
 	mt8188-dai-etdm.o \
 	mt8188-dai-pcm.o
 
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-common.h b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
index 1304d685a306bcb43b5131eff165b80051810b04..01aa11242e29c51539903fd1decc4c575d5e97bd 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-common.h
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-common.h
@@ -137,6 +137,7 @@ struct mt8188_afe_private {
 int mt8188_afe_fs_timing(unsigned int rate);
 /* dai register */
 int mt8188_dai_adda_register(struct mtk_base_afe *afe);
+int mt8188_dai_dmic_register(struct mtk_base_afe *afe);
 int mt8188_dai_etdm_register(struct mtk_base_afe *afe);
 int mt8188_dai_pcm_register(struct mtk_base_afe *afe);
 
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index d36520c6272dd8c8302bc3f59da33f82f273f366..a2b57e00ff4e502bfd8bc57835b792825f348c1b 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -652,6 +652,7 @@ static struct snd_soc_dai_driver mt8188_memif_dai_driver[] = {
 
 static const struct snd_kcontrol_new o002_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN2, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I004 Switch", AFE_CONN2, 4, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I012 Switch", AFE_CONN2, 12, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I020 Switch", AFE_CONN2, 20, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I022 Switch", AFE_CONN2, 22, 1, 0),
@@ -662,6 +663,8 @@ static const struct snd_kcontrol_new o002_mix[] = {
 
 static const struct snd_kcontrol_new o003_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN3, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I005 Switch", AFE_CONN3, 5, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I006 Switch", AFE_CONN3, 6, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I013 Switch", AFE_CONN3, 13, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I021 Switch", AFE_CONN3, 21, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I023 Switch", AFE_CONN3, 23, 1, 0),
@@ -672,6 +675,8 @@ static const struct snd_kcontrol_new o003_mix[] = {
 
 static const struct snd_kcontrol_new o004_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN4, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I006 Switch", AFE_CONN4, 6, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I008 Switch", AFE_CONN4, 8, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I014 Switch", AFE_CONN4, 14, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I024 Switch", AFE_CONN4, 24, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I074 Switch", AFE_CONN4_2, 10, 1, 0),
@@ -679,6 +684,8 @@ static const struct snd_kcontrol_new o004_mix[] = {
 
 static const struct snd_kcontrol_new o005_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN5, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I007 Switch", AFE_CONN5, 7, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I010 Switch", AFE_CONN5, 10, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I015 Switch", AFE_CONN5, 15, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I025 Switch", AFE_CONN5, 25, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I075 Switch", AFE_CONN5_2, 11, 1, 0),
@@ -686,6 +693,7 @@ static const struct snd_kcontrol_new o005_mix[] = {
 
 static const struct snd_kcontrol_new o006_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I000 Switch", AFE_CONN6, 0, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I008 Switch", AFE_CONN6, 8, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I016 Switch", AFE_CONN6, 16, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I026 Switch", AFE_CONN6, 26, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I076 Switch", AFE_CONN6_2, 12, 1, 0),
@@ -693,18 +701,21 @@ static const struct snd_kcontrol_new o006_mix[] = {
 
 static const struct snd_kcontrol_new o007_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("I001 Switch", AFE_CONN7, 1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I009 Switch", AFE_CONN7, 9, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I017 Switch", AFE_CONN7, 17, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I027 Switch", AFE_CONN7, 27, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I077 Switch", AFE_CONN7_2, 13, 1, 0),
 };
 
 static const struct snd_kcontrol_new o008_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I010 Switch", AFE_CONN8, 10, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I018 Switch", AFE_CONN8, 18, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I028 Switch", AFE_CONN8, 28, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I078 Switch", AFE_CONN8_2, 14, 1, 0),
 };
 
 static const struct snd_kcontrol_new o009_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I011 Switch", AFE_CONN9, 11, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I019 Switch", AFE_CONN9, 19, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I029 Switch", AFE_CONN9, 29, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I079 Switch", AFE_CONN9_2, 15, 1, 0),
@@ -1275,6 +1286,18 @@ static const struct snd_soc_dapm_route mt8188_memif_routes[] = {
 	{"O002", "I070 Switch", "I070"},
 	{"O003", "I071 Switch", "I071"},
 
+	{"O002", "I004 Switch", "I004"},
+	{"O003", "I005 Switch", "I005"},
+	{"O003", "I006 Switch", "I006"},
+	{"O004", "I006 Switch", "I006"},
+	{"O004", "I008 Switch", "I008"},
+	{"O005", "I007 Switch", "I007"},
+	{"O005", "I010 Switch", "I010"},
+	{"O006", "I008 Switch", "I008"},
+	{"O007", "I009 Switch", "I009"},
+	{"O008", "I010 Switch", "I010"},
+	{"O009", "I011 Switch", "I011"},
+
 	{"O034", "I000 Switch", "I000"},
 	{"O035", "I001 Switch", "I001"},
 	{"O034", "I002 Switch", "I002"},
@@ -3072,6 +3095,7 @@ static int mt8188_dai_memif_register(struct mtk_base_afe *afe)
 typedef int (*dai_register_cb)(struct mtk_base_afe *);
 static const dai_register_cb dai_register_cbs[] = {
 	mt8188_dai_adda_register,
+	mt8188_dai_dmic_register,
 	mt8188_dai_etdm_register,
 	mt8188_dai_pcm_register,
 	mt8188_dai_memif_register,
diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
new file mode 100644
index 0000000000000000000000000000000000000000..4cfbcb71d2d9c73e9c6b355a655f78709a032af5
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek ALSA SoC Audio DAI DMIC I/F Control
+ *
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Bicycle Tsai <bicycle.tsai@mediatek.com>
+ *         Trevor Wu <trevor.wu@mediatek.com>
+ *         Parker Yang <parker.yang@mediatek.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8188-afe-clk.h"
+#include "mt8188-afe-common.h"
+#include "mt8188-reg.h"
+
+/* DMIC HW Gain configuration maximum value. */
+#define DMIC_GAIN_MAX_STEP	GENMASK(19, 0)
+#define DMIC_GAIN_MAX_PER_STEP	GENMASK(7, 0)
+#define DMIC_GAIN_MAX_TARGET	GENMASK(27, 0)
+#define DMIC_GAIN_MAX_CURRENT	GENMASK(27, 0)
+
+#define CLK_PHASE_SEL_CH1 0
+#define CLK_PHASE_SEL_CH2 ((CLK_PHASE_SEL_CH1) + 4)
+
+#define DMIC1_SRC_SEL 0
+#define DMIC2_SRC_SEL 0
+#define DMIC3_SRC_SEL 2
+#define DMIC4_SRC_SEL 0
+#define DMIC5_SRC_SEL 4
+#define DMIC6_SRC_SEL 0
+#define DMIC7_SRC_SEL 6
+#define DMIC8_SRC_SEL 0
+
+enum {
+	SUPPLY_SEQ_DMIC_GAIN,
+	SUPPLY_SEQ_DMIC_CK,
+};
+
+enum {
+	DMIC0,
+	DMIC1,
+	DMIC2,
+	DMIC3,
+	DMIC_NUM,
+};
+
+struct mtk_dai_dmic_ctrl_reg {
+	unsigned int con0;
+};
+
+struct mtk_dai_dmic_hw_gain_ctrl_reg {
+	unsigned int bypass;
+	unsigned int con0;
+};
+
+struct mtk_dai_dmic_priv {
+	unsigned int gain_on[DMIC_NUM];
+	unsigned int channels;
+	bool hires_required;
+};
+
+static const struct mtk_dai_dmic_ctrl_reg dmic_ctrl_regs[DMIC_NUM] = {
+	[DMIC0] = {
+		.con0 = AFE_DMIC0_UL_SRC_CON0,
+	},
+	[DMIC1] = {
+		.con0 = AFE_DMIC1_UL_SRC_CON0,
+	},
+	[DMIC2] = {
+		.con0 = AFE_DMIC2_UL_SRC_CON0,
+	},
+	[DMIC3] = {
+		.con0 = AFE_DMIC3_UL_SRC_CON0,
+	},
+};
+
+static const struct mtk_dai_dmic_ctrl_reg *get_dmic_ctrl_reg(int id)
+{
+	if (id < 0 || id >= DMIC_NUM)
+		return NULL;
+
+	return &dmic_ctrl_regs[id];
+}
+
+static const struct mtk_dai_dmic_hw_gain_ctrl_reg
+	dmic_hw_gain_ctrl_regs[DMIC_NUM] = {
+	[DMIC0] = {
+		.bypass = DMIC_BYPASS_HW_GAIN,
+		.con0 = DMIC_GAIN1_CON0,
+	},
+	[DMIC1] = {
+		.bypass = DMIC_BYPASS_HW_GAIN,
+		.con0 = DMIC_GAIN2_CON0,
+	},
+	[DMIC2] = {
+		.bypass = DMIC_BYPASS_HW_GAIN,
+		.con0 = DMIC_GAIN3_CON0,
+	},
+	[DMIC3] = {
+		.bypass = DMIC_BYPASS_HW_GAIN,
+		.con0 = DMIC_GAIN4_CON0,
+	},
+};
+
+static const struct mtk_dai_dmic_hw_gain_ctrl_reg
+	*get_dmic_hw_gain_ctrl_reg(struct mtk_base_afe *afe, int id)
+{
+	if ((id < 0) || (id >= DMIC_NUM)) {
+		dev_dbg(afe->dev, "%s invalid id\n", __func__);
+		return NULL;
+	}
+
+	return &dmic_hw_gain_ctrl_regs[id];
+}
+
+static void mtk_dai_dmic_hw_gain_bypass(struct mtk_base_afe *afe,
+					unsigned int id, bool bypass)
+{
+	const struct mtk_dai_dmic_hw_gain_ctrl_reg *reg;
+	unsigned int msk;
+
+	reg = get_dmic_hw_gain_ctrl_reg(afe, id);
+	if (!reg)
+		return;
+
+	switch (id) {
+	case DMIC0:
+		msk = DMIC_BYPASS_HW_GAIN_DMIC1_BYPASS;
+		break;
+	case DMIC1:
+		msk = DMIC_BYPASS_HW_GAIN_DMIC2_BYPASS;
+		break;
+	case DMIC2:
+		msk = DMIC_BYPASS_HW_GAIN_DMIC3_BYPASS;
+		break;
+	case DMIC3:
+		msk = DMIC_BYPASS_HW_GAIN_DMIC4_BYPASS;
+		break;
+	default:
+		return;
+	}
+
+	if (bypass)
+		regmap_set_bits(afe->regmap, reg->bypass, msk);
+	else
+		regmap_clear_bits(afe->regmap, reg->bypass, msk);
+}
+
+static void mtk_dai_dmic_hw_gain_on(struct mtk_base_afe *afe, unsigned int id,
+				    bool on)
+{
+	const struct mtk_dai_dmic_hw_gain_ctrl_reg *reg = get_dmic_hw_gain_ctrl_reg(afe, id);
+
+	if (!reg)
+		return;
+
+	if (on)
+		regmap_set_bits(afe->regmap, reg->con0, DMIC_GAIN_CON0_GAIN_ON);
+	else
+		regmap_clear_bits(afe->regmap, reg->con0, DMIC_GAIN_CON0_GAIN_ON);
+}
+
+static const struct reg_sequence mtk_dai_dmic_iir_coeff_reg_defaults[] = {
+	{ AFE_DMIC0_IIR_COEF_02_01, 0x00000000 },
+	{ AFE_DMIC0_IIR_COEF_04_03, 0x00003FB8 },
+	{ AFE_DMIC0_IIR_COEF_06_05, 0x3FB80000 },
+	{ AFE_DMIC0_IIR_COEF_08_07, 0x3FB80000 },
+	{ AFE_DMIC0_IIR_COEF_10_09, 0x0000C048 },
+	{ AFE_DMIC1_IIR_COEF_02_01, 0x00000000 },
+	{ AFE_DMIC1_IIR_COEF_04_03, 0x00003FB8 },
+	{ AFE_DMIC1_IIR_COEF_06_05, 0x3FB80000 },
+	{ AFE_DMIC1_IIR_COEF_08_07, 0x3FB80000 },
+	{ AFE_DMIC1_IIR_COEF_10_09, 0x0000C048 },
+	{ AFE_DMIC2_IIR_COEF_02_01, 0x00000000 },
+	{ AFE_DMIC2_IIR_COEF_04_03, 0x00003FB8 },
+	{ AFE_DMIC2_IIR_COEF_06_05, 0x3FB80000 },
+	{ AFE_DMIC2_IIR_COEF_08_07, 0x3FB80000 },
+	{ AFE_DMIC2_IIR_COEF_10_09, 0x0000C048 },
+	{ AFE_DMIC3_IIR_COEF_02_01, 0x00000000 },
+	{ AFE_DMIC3_IIR_COEF_04_03, 0x00003FB8 },
+	{ AFE_DMIC3_IIR_COEF_06_05, 0x3FB80000 },
+	{ AFE_DMIC3_IIR_COEF_08_07, 0x3FB80000 },
+	{ AFE_DMIC3_IIR_COEF_10_09, 0x0000C048 },
+};
+
+static int mtk_dai_dmic_load_iir_coeff_table(struct mtk_base_afe *afe)
+{
+	return regmap_multi_reg_write(afe->regmap,
+				      mtk_dai_dmic_iir_coeff_reg_defaults,
+				      ARRAY_SIZE(mtk_dai_dmic_iir_coeff_reg_defaults));
+}
+
+static int mtk_dai_dmic_configure_array(struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	const u32 mask = PWR2_TOP_CON_DMIC8_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC7_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC6_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC5_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC4_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC3_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC2_SRC_SEL_MASK |
+			 PWR2_TOP_CON_DMIC1_SRC_SEL_MASK;
+	const u32 val = PWR2_TOP_CON_DMIC8_SRC_SEL_VAL(DMIC8_SRC_SEL) |
+			PWR2_TOP_CON_DMIC7_SRC_SEL_VAL(DMIC7_SRC_SEL) |
+			PWR2_TOP_CON_DMIC6_SRC_SEL_VAL(DMIC6_SRC_SEL) |
+			PWR2_TOP_CON_DMIC5_SRC_SEL_VAL(DMIC5_SRC_SEL) |
+			PWR2_TOP_CON_DMIC4_SRC_SEL_VAL(DMIC4_SRC_SEL) |
+			PWR2_TOP_CON_DMIC3_SRC_SEL_VAL(DMIC3_SRC_SEL) |
+			PWR2_TOP_CON_DMIC2_SRC_SEL_VAL(DMIC2_SRC_SEL) |
+			PWR2_TOP_CON_DMIC1_SRC_SEL_VAL(DMIC1_SRC_SEL);
+
+	return regmap_update_bits(afe->regmap, PWR2_TOP_CON0, mask, val);
+}
+
+/* This function assumes that the caller checked that channels is valid */
+static u8 mtk_dmic_channels_to_dmic_number(unsigned int channels)
+{
+	switch (channels) {
+	case 1:
+		return DMIC0;
+	case 2:
+		return DMIC1;
+	case 3:
+		return DMIC2;
+	case 4:
+	default:
+		return DMIC3;
+	}
+}
+
+static void mtk_dai_dmic_hw_gain_enable(struct mtk_base_afe *afe,
+					unsigned int channels, bool enable)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	u8 dmic_num;
+	int i;
+
+	dmic_num = mtk_dmic_channels_to_dmic_number(channels);
+	for (i = dmic_num; i >= DMIC0; i--) {
+		if (enable && dmic_priv->gain_on[i]) {
+			mtk_dai_dmic_hw_gain_bypass(afe, i, false);
+			mtk_dai_dmic_hw_gain_on(afe, i, true);
+		} else {
+			mtk_dai_dmic_hw_gain_on(afe, i, false);
+			mtk_dai_dmic_hw_gain_bypass(afe, i, true);
+		}
+	}
+}
+
+static int mtk_dmic_gain_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol,
+			       int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	unsigned int channels = dmic_priv->channels;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	if (!channels)
+		return -EINVAL;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		mtk_dai_dmic_hw_gain_enable(afe, channels, true);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		mtk_dai_dmic_hw_gain_enable(afe, channels, false);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dmic_event(struct snd_soc_dapm_widget *w,
+			  struct snd_kcontrol *kcontrol,
+			  int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
+	unsigned int channels = dmic_priv->channels;
+	unsigned int msk;
+	u8 dmic_num;
+	int i;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	if (!channels)
+		return -EINVAL;
+
+	dmic_num = mtk_dmic_channels_to_dmic_number(channels);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* request fifo soft rst */
+		for (i = dmic_num; i >= DMIC0; i--)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
+
+		regmap_set_bits(afe->regmap, PWR2_TOP_CON1, msk);
+
+		msk = AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL;
+
+		for (i = dmic_num; i >= DMIC0; i--) {
+			reg = get_dmic_ctrl_reg(i);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		msk = AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL;
+
+		for (i = dmic_num; i >= DMIC0; i--) {
+			reg = get_dmic_ctrl_reg(i);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+
+		if (dmic_priv->hires_required) {
+			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES1]);
+			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES2]);
+			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES3]);
+			mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES4]);
+		}
+
+		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC1]);
+		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC2]);
+		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC3]);
+		mt8188_afe_enable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC4]);
+
+		/* release fifo soft rst */
+		msk = 0;
+		for (i = dmic_num; i >= DMIC0; i--)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
+
+		regmap_clear_bits(afe->regmap, PWR2_TOP_CON1, msk);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		msk = AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL |
+		      AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL;
+
+		for (i = dmic_num; i >= DMIC0; i--) {
+			reg = get_dmic_ctrl_reg(i);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* should delayed 1/fs(smallest is 8k) = 125us before afe off */
+		usleep_range(125, 126);
+
+		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC1]);
+		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC2]);
+		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC3]);
+		mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_AFE_DMIC4]);
+
+		if (dmic_priv->hires_required) {
+			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES1]);
+			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES2]);
+			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES3]);
+			mt8188_afe_disable_clk(afe, afe_priv->clk[MT8188_CLK_AUD_DMIC_HIRES4]);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int mtk_dai_dmic_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	unsigned int rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
+	u32 val = AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH1(CLK_PHASE_SEL_CH1) |
+		  AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH2(CLK_PHASE_SEL_CH2) |
+		  AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(0);
+	const u32 msk = AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL |
+			AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_MASK |
+			AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK |
+			AFE_DMIC_UL_VOICE_MODE_MASK;
+	u8 dmic_num;
+	int ret;
+	int i;
+
+	if (!channels || channels > 8)
+		return -EINVAL;
+
+	ret = mtk_dai_dmic_configure_array(dai);
+	if (ret < 0)
+		return ret;
+
+	ret = mtk_dai_dmic_load_iir_coeff_table(afe);
+	if (ret < 0)
+		return ret;
+
+	switch (rate) {
+	case 96000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_96K;
+		dmic_priv->hires_required = 1;
+		break;
+	case 48000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
+		dmic_priv->hires_required = 0;
+		break;
+	case 32000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_32K;
+		dmic_priv->hires_required = 0;
+		break;
+	case 16000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_16K;
+		dmic_priv->hires_required = 0;
+		break;
+	case 8000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_8K;
+		dmic_priv->hires_required = 0;
+		break;
+	default:
+		dev_dbg(afe->dev, "%s invalid rate %u, use 48000Hz\n", __func__, rate);
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
+		dmic_priv->hires_required = 0;
+		break;
+	}
+
+	dmic_num = mtk_dmic_channels_to_dmic_number(channels);
+	for (i = dmic_num; i >= DMIC0; i--) {
+		reg = get_dmic_ctrl_reg(i);
+		if (reg) {
+			ret = regmap_update_bits(afe->regmap, reg->con0, msk, val);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	dmic_priv->channels = channels;
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops mtk_dai_dmic_ops = {
+	.hw_params	= mtk_dai_dmic_hw_params,
+};
+
+#define MTK_DMIC_RATES (SNDRV_PCM_RATE_8000 |\
+		       SNDRV_PCM_RATE_16000 |\
+		       SNDRV_PCM_RATE_32000 |\
+		       SNDRV_PCM_RATE_48000 |\
+		       SNDRV_PCM_RATE_96000)
+
+#define MTK_DMIC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mtk_dai_dmic_driver[] = {
+	{
+		.name = "DMIC",
+		.id = MT8188_AFE_IO_DMIC_IN,
+		.capture = {
+			.stream_name = "DMIC Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = MTK_DMIC_RATES,
+			.formats = MTK_DMIC_FORMATS,
+		},
+		.ops = &mtk_dai_dmic_ops,
+	},
+};
+
+static const struct snd_soc_dapm_widget mtk_dai_dmic_widgets[] = {
+	SND_SOC_DAPM_MIXER("I004", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I005", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I006", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I007", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I008", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I009", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I010", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I011", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_SUPPLY_S("DMIC_GAIN_ON", SUPPLY_SEQ_DMIC_GAIN,
+			      SND_SOC_NOPM, 0, 0,
+			      mtk_dmic_gain_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S("DMIC_CK_ON", SUPPLY_SEQ_DMIC_CK,
+			      PWR2_TOP_CON1,
+			      PWR2_TOP_CON1_DMIC_CKDIV_ON_SHIFT, 0,
+			      mtk_dmic_event,
+			      SND_SOC_DAPM_PRE_POST_PMU |
+			      SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_INPUT("DMIC_INPUT"),
+};
+
+static const struct snd_soc_dapm_route mtk_dai_dmic_routes[] = {
+	{"I004", NULL, "DMIC Capture"},
+	{"I005", NULL, "DMIC Capture"},
+	{"I006", NULL, "DMIC Capture"},
+	{"I007", NULL, "DMIC Capture"},
+	{"I008", NULL, "DMIC Capture"},
+	{"I009", NULL, "DMIC Capture"},
+	{"I010", NULL, "DMIC Capture"},
+	{"I011", NULL, "DMIC Capture"},
+	{"DMIC Capture", NULL, "DMIC_CK_ON"},
+	{"DMIC Capture", NULL, "DMIC_GAIN_ON"},
+	{"DMIC Capture", NULL, "DMIC_INPUT"},
+};
+
+static const char * const mt8188_dmic_gain_enable_text[] = {
+	"Bypass", "Connect",
+};
+
+static SOC_ENUM_SINGLE_EXT_DECL(dmic_gain_on_enum,
+				mt8188_dmic_gain_enable_text);
+
+static int mtk_dai_dmic_hw_gain_ctrl_put(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	unsigned int source = ucontrol->value.enumerated.item[0];
+	unsigned int *cached;
+
+	if (source >= e->items)
+		return -EINVAL;
+
+	if (!strcmp(kcontrol->id.name, "DMIC1_HW_GAIN_EN"))
+		cached = &dmic_priv->gain_on[0];
+	else if (!strcmp(kcontrol->id.name, "DMIC2_HW_GAIN_EN"))
+		cached = &dmic_priv->gain_on[1];
+	else if (!strcmp(kcontrol->id.name, "DMIC3_HW_GAIN_EN"))
+		cached = &dmic_priv->gain_on[2];
+	else if (!strcmp(kcontrol->id.name, "DMIC4_HW_GAIN_EN"))
+		cached = &dmic_priv->gain_on[3];
+	else
+		return -EINVAL;
+
+	if (source == *cached)
+		return 0;
+
+	*cached = source;
+	return 1;
+}
+
+static int mtk_dai_dmic_hw_gain_ctrl_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	unsigned int val;
+
+	if (!strcmp(kcontrol->id.name, "DMIC1_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[0];
+	else if (!strcmp(kcontrol->id.name, "DMIC2_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[1];
+	else if (!strcmp(kcontrol->id.name, "DMIC3_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[2];
+	else if (!strcmp(kcontrol->id.name, "DMIC4_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[3];
+	else
+		return -EINVAL;
+
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static const struct snd_kcontrol_new mtk_dai_dmic_controls[] = {
+	SOC_ENUM_EXT("DMIC1_HW_GAIN_EN", dmic_gain_on_enum,
+		     mtk_dai_dmic_hw_gain_ctrl_get,
+		     mtk_dai_dmic_hw_gain_ctrl_put),
+	SOC_ENUM_EXT("DMIC2_HW_GAIN_EN", dmic_gain_on_enum,
+		     mtk_dai_dmic_hw_gain_ctrl_get,
+		     mtk_dai_dmic_hw_gain_ctrl_put),
+	SOC_ENUM_EXT("DMIC3_HW_GAIN_EN", dmic_gain_on_enum,
+		     mtk_dai_dmic_hw_gain_ctrl_get,
+		     mtk_dai_dmic_hw_gain_ctrl_put),
+	SOC_ENUM_EXT("DMIC4_HW_GAIN_EN", dmic_gain_on_enum,
+		     mtk_dai_dmic_hw_gain_ctrl_get,
+		     mtk_dai_dmic_hw_gain_ctrl_put),
+	SOC_SINGLE("DMIC1_HW_GAIN_TARGET", DMIC_GAIN1_CON1,
+		   0, DMIC_GAIN_MAX_TARGET, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_TARGET", DMIC_GAIN2_CON1,
+		   0, DMIC_GAIN_MAX_TARGET, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_TARGET", DMIC_GAIN3_CON1,
+		   0, DMIC_GAIN_MAX_TARGET, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_TARGET", DMIC_GAIN4_CON1,
+		   0, DMIC_GAIN_MAX_TARGET, 0),
+	SOC_SINGLE("DMIC1_HW_GAIN_CURRENT", DMIC_GAIN1_CUR,
+		       0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_CURRENT", DMIC_GAIN2_CUR,
+		       0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_CURRENT", DMIC_GAIN3_CUR,
+		       0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_CURRENT", DMIC_GAIN4_CUR,
+		       0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC1_HW_GAIN_UP_STEP", DMIC_GAIN1_CON3,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_UP_STEP", DMIC_GAIN2_CON3,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_UP_STEP", DMIC_GAIN3_CON3,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_UP_STEP", DMIC_GAIN4_CON3,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC1_HW_GAIN_DOWN_STEP", DMIC_GAIN1_CON2,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_DOWN_STEP", DMIC_GAIN2_CON2,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_DOWN_STEP", DMIC_GAIN3_CON2,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_DOWN_STEP", DMIC_GAIN4_CON2,
+		   0, DMIC_GAIN_MAX_STEP, 0),
+	SOC_SINGLE("DMIC1_HW_GAIN_SAMPLE_PER_STEP", DMIC_GAIN1_CON0,
+		   DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT, DMIC_GAIN_MAX_PER_STEP, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_SAMPLE_PER_STEP", DMIC_GAIN2_CON0,
+		   DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT, DMIC_GAIN_MAX_PER_STEP, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_SAMPLE_PER_STEP", DMIC_GAIN3_CON0,
+		   DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT, DMIC_GAIN_MAX_PER_STEP, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_SAMPLE_PER_STEP", DMIC_GAIN4_CON0,
+		   DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT, DMIC_GAIN_MAX_PER_STEP, 0),
+};
+
+static int init_dmic_priv_data(struct mtk_base_afe *afe)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv;
+
+	dmic_priv = devm_kzalloc(afe->dev, sizeof(struct mtk_dai_dmic_priv),
+				 GFP_KERNEL);
+	if (!dmic_priv)
+		return -ENOMEM;
+
+	afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN] = dmic_priv;
+	return 0;
+}
+
+int mt8188_dai_dmic_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mtk_dai_dmic_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mtk_dai_dmic_driver);
+	dai->dapm_widgets = mtk_dai_dmic_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mtk_dai_dmic_widgets);
+	dai->dapm_routes = mtk_dai_dmic_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mtk_dai_dmic_routes);
+	dai->controls = mtk_dai_dmic_controls;
+	dai->num_controls = ARRAY_SIZE(mtk_dai_dmic_controls);
+
+	return init_dmic_priv_data(afe);
+}
diff --git a/sound/soc/mediatek/mt8188/mt8188-reg.h b/sound/soc/mediatek/mt8188/mt8188-reg.h
index bdd885419ff3874bab80549ea3ff4617172b8245..2e9c65de249da5227ee6f83daa7594a55bc8711c 100644
--- a/sound/soc/mediatek/mt8188/mt8188-reg.h
+++ b/sound/soc/mediatek/mt8188/mt8188-reg.h
@@ -2837,9 +2837,20 @@
 #define PWR2_TOP_CON_DMIC3_SRC_SEL_MASK     GENMASK(16, 14)
 #define PWR2_TOP_CON_DMIC2_SRC_SEL_MASK     GENMASK(13, 11)
 #define PWR2_TOP_CON_DMIC1_SRC_SEL_MASK     GENMASK(10, 8)
+#define PWR2_TOP_CON_DMIC8_SRC_SEL_VAL(x)   ((x) << 29)
+#define PWR2_TOP_CON_DMIC7_SRC_SEL_VAL(x)   ((x) << 26)
+#define PWR2_TOP_CON_DMIC6_SRC_SEL_VAL(x)   ((x) << 23)
+#define PWR2_TOP_CON_DMIC5_SRC_SEL_VAL(x)   ((x) << 20)
+#define PWR2_TOP_CON_DMIC4_SRC_SEL_VAL(x)   ((x) << 17)
+#define PWR2_TOP_CON_DMIC3_SRC_SEL_VAL(x)   ((x) << 14)
+#define PWR2_TOP_CON_DMIC2_SRC_SEL_VAL(x)   ((x) << 11)
+#define PWR2_TOP_CON_DMIC1_SRC_SEL_VAL(x)   ((x) << 8)
 
 /* PWR2_TOP_CON1 */
-#define PWR2_TOP_CON1_DMIC_CKDIV_ON        BIT(1)
+#define PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(x)	BIT(5 + 6 * (x))
+#define PWR2_TOP_CON1_DMIC_CKDIV_ON             BIT(1)
+#define PWR2_TOP_CON1_DMIC_CKDIV_ON_SHIFT       1
+
 
 /* PCM_INTF_CON1 */
 #define PCM_INTF_CON1_SYNC_OUT_INV     BIT(23)
@@ -2921,13 +2932,14 @@
 #define AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL	BIT(23)
 #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL	BIT(22)
 #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL	BIT(21)
-
+#define AFE_DMIC_UL_VOICE_MODE(x)			(((x) & GENMASK(2, 0)) << 17)
 #define AFE_DMIC_UL_VOICE_MODE_MASK			GENMASK(19, 17)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_8K			AFE_DMIC_UL_VOICE_MODE(0)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_16K			AFE_DMIC_UL_VOICE_MODE(1)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_32K			AFE_DMIC_UL_VOICE_MODE(2)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_48K			AFE_DMIC_UL_VOICE_MODE(3)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_96K			AFE_DMIC_UL_VOICE_MODE(4)
+#define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(x)		(((x) & GENMASK(2, 0)) << 7)
 #define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK	GENMASK(9, 7)
 #define AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL		BIT(10)
 #define AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL		BIT(1)
@@ -2944,6 +2956,7 @@
 
 /* DMIC_GAINx_CON0 */
 #define DMIC_GAIN_CON0_GAIN_ON			BIT(0)
+#define DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT	8
 #define DMIC_GAIN_CON0_SAMPLE_PER_STEP_MASK	GENMASK(15, 8)
 
 /* DMIC_GAINx_CON1 */

-- 
2.48.1



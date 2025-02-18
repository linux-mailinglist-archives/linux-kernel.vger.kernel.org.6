Return-Path: <linux-kernel+bounces-520480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36073A3AA63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282518879D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEC01DA10C;
	Tue, 18 Feb 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NnrcAxoN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FF1CBA02;
	Tue, 18 Feb 2025 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912105; cv=none; b=Lz2Ydz/VeTwucsUHvAHx/x6+hgyEun/4sNb0IlrSzQHc3Gv9wJxPJVN9W6Qxh8JmkbjSYPYhjS3SKrifnyr2LKWVQDG9KzwCn1vSk6aOYRri+DKhqqAIr4FaFR31Lp3PHp9ia8IAN16qOjlk+Oeu431Dt0ew5kgipZK5NPCfdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912105; c=relaxed/simple;
	bh=NF0XMXd+efjW8JQVJoiHh5Eh2jYWPz/ZQwiqscBEH24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kP+Uz/Zts+BpWYaOuP9LGVuxC91GTEXHeU8zXKuzgXS6BvGNGXSz5938DXyvPvkYzsYrk0rhBdGOtgwr74oClTQfO8nwVWzj7YDHGhd4KEp67hT1kbKP1WhXszvB/AFyu3mGc68I3z0ZrLqTPscBlpYGyYXNOX9n0bMARq6KPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NnrcAxoN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912100;
	bh=NF0XMXd+efjW8JQVJoiHh5Eh2jYWPz/ZQwiqscBEH24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NnrcAxoNmNTXzu4uu3agYS/pkZPK9UZJgh68csKLsLGs8inaK5OkShnDZGGdYSZ3Z
	 TLT4K3bIbMmC7nEWS1o4XZrzfVvTeRP2malrPoYP8JelijACM7q+jSba+rANBVQmqF
	 CHh7nyzJVu+iMRiCUjSgetg6GyoG8BUTTcwrg/IV3fcpV6/S/w2WVp5R13FLMzzdqP
	 C4uVg6kg9bosoruqlYs1HYNu0U5AF6F77/2r/yUCabBkgVOS6Kur87fb/mJZWg3ytn
	 QKXNfxXCwl8LZ7r2PkxlTTWz1NwXPLNVTOVLJp7Pumfg1oQYzqZJQ3viX7jUG9zsy3
	 bBwm9gSAi2Vbg==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC16917E14E7;
	Tue, 18 Feb 2025 21:54:55 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:16 -0300
Subject: [PATCH 3/6] ASoC: mediatek: mt8188: Add DMIC DAI driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-3-6bc653da60f7@collabora.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
In-Reply-To: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

From: parkeryang <Parker.Yang@mediatek.com>

Add support for the DMIC DAIs present on the MT8188 SoC.

Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c  |   4 -
 sound/soc/mediatek/mt8188/mt8188-dai-dmic.c | 754 ++++++++++++++++++++++++++++
 sound/soc/mediatek/mt8188/mt8188-reg.h      |  18 +-
 3 files changed, 770 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index 73e5c63aeec8783905d656af225c42cd95069049..d36520c6272dd8c8302bc3f59da33f82f273f366 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2855,10 +2855,6 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_DMIC3_SRC_DEBUG_MON0:
 	case AFE_DMIC3_UL_SRC_MON0:
 	case AFE_DMIC3_UL_SRC_MON1:
-	case DMIC_GAIN1_CUR:
-	case DMIC_GAIN2_CUR:
-	case DMIC_GAIN3_CUR:
-	case DMIC_GAIN4_CUR:
 	case ETDM_IN1_MONITOR:
 	case ETDM_IN2_MONITOR:
 	case ETDM_OUT1_MONITOR:
diff --git a/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
new file mode 100644
index 0000000000000000000000000000000000000000..9df08783ff80173095809c20538d0fb073ed7fae
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-dai-dmic.c
@@ -0,0 +1,754 @@
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
+#include <linux/regmap.h>
+#include <sound/pcm_params.h>
+#include "mt8188-afe-clk.h"
+#include "mt8188-afe-common.h"
+#include "mt8188-reg.h"
+
+#define DMIC_MAX_CH (8)
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
+static void mtk_dai_dmic_hw_gain_byass(struct mtk_base_afe *afe,
+				       unsigned int id, bool bypass)
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
+static void mtk_dai_dmic_hw_gain_on(struct mtk_base_afe *afe,
+				    unsigned int id, bool on)
+{
+	const struct mtk_dai_dmic_hw_gain_ctrl_reg *reg;
+	unsigned int msk = DMIC_GAIN_CON0_GAIN_ON;
+
+	reg = get_dmic_hw_gain_ctrl_reg(afe, id);
+	if (!reg)
+		return;
+
+	if (on)
+		regmap_set_bits(afe->regmap, reg->con0, msk);
+	else
+		regmap_clear_bits(afe->regmap, reg->con0, msk);
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
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv = NULL;
+	unsigned int mask =
+			PWR2_TOP_CON_DMIC8_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC7_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC6_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC5_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC4_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC3_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC2_SRC_SEL_MASK |
+			PWR2_TOP_CON_DMIC1_SRC_SEL_MASK;
+	unsigned int val = 0;
+
+	if (dai->id < 0)
+		return -EINVAL;
+
+	dmic_priv = afe_priv->dai_priv[dai->id];
+	val = PWR2_TOP_CON_DMIC8_SRC_SEL_VAL(DMIC8_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC7_SRC_SEL_VAL(DMIC7_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC6_SRC_SEL_VAL(DMIC6_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC5_SRC_SEL_VAL(DMIC5_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC4_SRC_SEL_VAL(DMIC4_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC3_SRC_SEL_VAL(DMIC3_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC2_SRC_SEL_VAL(DMIC2_SRC_SEL) |
+	      PWR2_TOP_CON_DMIC1_SRC_SEL_VAL(DMIC1_SRC_SEL);
+
+	regmap_update_bits(afe->regmap, PWR2_TOP_CON0, mask, val);
+
+	return 0;
+}
+
+static void mtk_dai_dmic_hw_gain_enable(struct mtk_base_afe *afe,
+					unsigned int channels, bool enable)
+{
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv;
+	unsigned int end;
+	unsigned int id;
+
+	if (!channels)
+		return;
+
+	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	if (channels > 3)
+		end = 3;
+	else if (channels > 2)
+		end = 2;
+	else if (channels > 1)
+		end = 1;
+	else if (channels > 0)
+		end = 0;
+
+	for (id = DMIC0; id <= end; id++) {
+		if (enable && dmic_priv->gain_on[id]) {
+			mtk_dai_dmic_hw_gain_byass(afe, id, false);
+			mtk_dai_dmic_hw_gain_on(afe, id, true);
+		} else {
+			mtk_dai_dmic_hw_gain_on(afe, id, false);
+			mtk_dai_dmic_hw_gain_byass(afe, id, true);
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
+	struct mtk_dai_dmic_priv *dmic_priv = NULL;
+	unsigned int channels;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	channels = dmic_priv->channels;
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
+	struct mtk_dai_dmic_priv *dmic_priv = NULL;
+	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
+	unsigned int channels;
+	unsigned int msk;
+
+	dev_dbg(afe->dev, "%s(), name %s, event 0x%x\n",
+		__func__, w->name, event);
+
+	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+	channels = dmic_priv->channels;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* request fifo soft rst */
+		msk = 0;
+		if (channels > 3)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC3);
+		if (channels > 2)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC2);
+		if (channels > 1)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC1);
+		if (channels > 0)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC0);
+
+		regmap_set_bits(afe->regmap, PWR2_TOP_CON1, msk);
+
+		msk = 0;
+		msk |= AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL;
+		msk |= AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL;
+		msk |= AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL;
+		msk |= AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL;
+
+		if (channels > 3) {
+			reg = get_dmic_ctrl_reg(DMIC3);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 2) {
+			reg = get_dmic_ctrl_reg(DMIC2);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 1) {
+			reg = get_dmic_ctrl_reg(DMIC1);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 0) {
+			reg = get_dmic_ctrl_reg(DMIC0);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		msk = AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL;
+		if (channels > 3) {
+			reg = get_dmic_ctrl_reg(DMIC3);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 2) {
+			reg = get_dmic_ctrl_reg(DMIC2);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 1) {
+			reg = get_dmic_ctrl_reg(DMIC1);
+			if (reg)
+				regmap_set_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 0) {
+			reg = get_dmic_ctrl_reg(DMIC0);
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
+		if (channels > 3)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC3);
+		if (channels > 2)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC2);
+		if (channels > 1)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC1);
+		if (channels > 0)
+			msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(DMIC0);
+
+		regmap_clear_bits(afe->regmap, PWR2_TOP_CON1, msk);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		msk =  AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL |
+			AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL |
+			AFE_DMIC_UL_SRC_CON0_UL_SRC_ON_TMP_CTL |
+			AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL |
+			AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL;
+
+		if (channels > 3) {
+			reg = get_dmic_ctrl_reg(DMIC3);
+			if (reg)
+				regmap_clear_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 2) {
+			reg = get_dmic_ctrl_reg(DMIC2);
+			if (reg)
+				regmap_clear_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 1) {
+			reg = get_dmic_ctrl_reg(DMIC1);
+			if (reg)
+				regmap_clear_bits(afe->regmap, reg->con0, msk);
+		}
+		if (channels > 0) {
+			reg = get_dmic_ctrl_reg(DMIC0);
+			if (reg)
+				regmap_clear_bits(afe->regmap, reg->con0, msk);
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
+	struct mtk_dai_dmic_priv *dmic_priv = NULL;
+	unsigned int rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	const struct mtk_dai_dmic_ctrl_reg *reg = NULL;
+	unsigned int val = 0;
+	unsigned int msk = 0;
+
+	if (dai->id < 0)
+		return -EINVAL;
+
+	dmic_priv = afe_priv->dai_priv[dai->id];
+
+	val = AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH1(CLK_PHASE_SEL_CH1) |
+	      AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH2(CLK_PHASE_SEL_CH2) |
+	      AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(0);
+	msk = AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL_MASK |
+	      AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_MASK |
+	      AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK |
+	      AFE_DMIC_UL_VOICE_MODE_MASK;
+
+	mtk_dai_dmic_configure_array(dai);
+	dmic_priv->hires_required = 0;
+
+	switch (rate) {
+	case 96000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_96K;
+		dmic_priv->hires_required = 1;
+		break;
+	case 48000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
+		break;
+	case 32000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_32K;
+		break;
+	case 16000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_16K;
+		break;
+	case 8000:
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_8K;
+		break;
+	default:
+		dev_dbg(afe->dev, "%s invalid rate %u, use 48000Hz\n", __func__, rate);
+		val |= AFE_DMIC_UL_CON0_VOCIE_MODE_48K;
+		break;
+	}
+
+	mtk_dai_dmic_load_iir_coeff_table(afe);
+
+	if (channels > 3) {
+		reg = get_dmic_ctrl_reg(DMIC3);
+		if (reg)
+			regmap_update_bits(afe->regmap, reg->con0, msk, val);
+	}
+	if (channels > 2) {
+		reg = get_dmic_ctrl_reg(DMIC2);
+		if (reg)
+			regmap_update_bits(afe->regmap, reg->con0, msk, val);
+	}
+	if (channels > 1) {
+		reg = get_dmic_ctrl_reg(DMIC1);
+		if (reg)
+			regmap_update_bits(afe->regmap, reg->con0, msk, val);
+	}
+	if (channels > 0) {
+		reg = get_dmic_ctrl_reg(DMIC0);
+		if (reg)
+			regmap_update_bits(afe->regmap, reg->con0, msk, val);
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
+	struct mtk_dai_dmic_priv *dmic_priv;
+	unsigned int source = ucontrol->value.enumerated.item[0];
+	unsigned int *cached = 0;
+
+	if (source >= e->items)
+		return -EINVAL;
+
+	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
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
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	struct mt8188_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_dai_dmic_priv *dmic_priv;
+	unsigned int val = 0;
+
+	dmic_priv = afe_priv->dai_priv[MT8188_AFE_IO_DMIC_IN];
+
+	if (!strcmp(kcontrol->id.name, "DMIC1_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[0];
+	else if (!strcmp(kcontrol->id.name, "DMIC2_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[1];
+	else if (!strcmp(kcontrol->id.name, "DMIC3_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[2];
+	else if (!strcmp(kcontrol->id.name, "DMIC4_HW_GAIN_EN"))
+		val = dmic_priv->gain_on[3];
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
+		   0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC2_HW_GAIN_CURRENT", DMIC_GAIN2_CUR,
+		   0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC3_HW_GAIN_CURRENT", DMIC_GAIN3_CUR,
+		   0, DMIC_GAIN_MAX_CURRENT, 0),
+	SOC_SINGLE("DMIC4_HW_GAIN_CURRENT", DMIC_GAIN4_CUR,
+		   0, DMIC_GAIN_MAX_CURRENT, 0),
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
index bdd885419ff3874bab80549ea3ff4617172b8245..4154548aca36108667036f9889476c30f9b6171a 100644
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
+#define PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(x)	BIT((5 + 6 * x))
+#define PWR2_TOP_CON1_DMIC_CKDIV_ON             BIT(1)
+#define PWR2_TOP_CON1_DMIC_CKDIV_ON_SHIFT       1
+
 
 /* PCM_INTF_CON1 */
 #define PCM_INTF_CON1_SYNC_OUT_INV     BIT(23)
@@ -2919,15 +2930,17 @@
 #define AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_CH2(x)	(((x) & 0x7) << 24)
 #define AFE_DMIC_UL_SRC_CON0_UL_PHASE_SEL_MASK		GENMASK(29, 24)
 #define AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL	BIT(23)
+#define AFE_DMIC_UL_SRC_CON0_UL_TWO_WIRE_MODE_CTL_MASK  BIT(23)
 #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH2_CTL	BIT(22)
 #define AFE_DMIC_UL_SRC_CON0_UL_MODE_3P25M_CH1_CTL	BIT(21)
-
+#define AFE_DMIC_UL_VOICE_MODE(x)			(((x) & 0x7) << 17)
 #define AFE_DMIC_UL_VOICE_MODE_MASK			GENMASK(19, 17)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_8K			AFE_DMIC_UL_VOICE_MODE(0)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_16K			AFE_DMIC_UL_VOICE_MODE(1)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_32K			AFE_DMIC_UL_VOICE_MODE(2)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_48K			AFE_DMIC_UL_VOICE_MODE(3)
 #define AFE_DMIC_UL_CON0_VOCIE_MODE_96K			AFE_DMIC_UL_VOICE_MODE(4)
+#define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL(x)		(((x) & 0x7) << 7)
 #define AFE_DMIC_UL_SRC_CON0_UL_IIR_MODE_CTL_MASK	GENMASK(9, 7)
 #define AFE_DMIC_UL_SRC_CON0_UL_IIR_ON_TMP_CTL		BIT(10)
 #define AFE_DMIC_UL_SRC_CON0_UL_SDM_3_LEVEL_CTL		BIT(1)
@@ -2944,6 +2957,7 @@
 
 /* DMIC_GAINx_CON0 */
 #define DMIC_GAIN_CON0_GAIN_ON			BIT(0)
+#define DMIC_GAIN_CON0_SAMPLE_PER_STEP_SHIFT	8
 #define DMIC_GAIN_CON0_SAMPLE_PER_STEP_MASK	GENMASK(15, 8)
 
 /* DMIC_GAINx_CON1 */

-- 
2.48.1



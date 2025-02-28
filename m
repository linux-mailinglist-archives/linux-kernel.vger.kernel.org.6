Return-Path: <linux-kernel+bounces-537959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DB2A492EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C83A64DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0BA1E008E;
	Fri, 28 Feb 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s87Skr92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575A1DF25E;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729875; cv=none; b=MTXfiuUydBii2ApDEc7hBJkQK/Q9+O7lnFP0RnKmzXQ9baIcLROmRtP8esEVZBgAgiPj8ePH6LLb6NT4Os1yHd+63t1zM3T8oRELaczjMobW8VmF4udRtaq2qSNFsgXpxMtWLuB7GiOPx9xGrQV4Zau5CUpi4Hna88RUhgPifjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729875; c=relaxed/simple;
	bh=iBKf/MqVJS/RaohfLwY6/fVPPDai7O3DFGztOh4ZCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keqC2+8zR9x9CMBXpTqlE6EGl1E2qnYDr6eWyU5uCHIAHRLUXTcQovmmrNXY1FzU2J6n2n8x3DjgEnARxgCvTGzjDoQTeksCww7nwAx/BZOYMTtTZC1XlygmsSmiV/wQGEA4w7JTrxve2wrfzus84RbhwPmnkkyq/FOwvatnNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s87Skr92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F0C6C4CEE4;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740729875;
	bh=iBKf/MqVJS/RaohfLwY6/fVPPDai7O3DFGztOh4ZCQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s87Skr92oLvu1H/wEUIeA7CzEFsm5RWDh3BG0Ob3quhjFei5rxEs79dAHkkpX5LY3
	 qJjysqDG/e1uZVUlO+FWSA7c+ku5NZnzFPjq/B38DR+ulNlADu3G9cs9zsq6FjHyra
	 BuQRfoV+cBPhO3gaKRK+zB57DtCBvKRPdGIjGR7gFDHy67D8hnV8ujJuYo9gIKaG6E
	 CxLzurB1Zk1mN0JK2MGBnVSyhJDZUTXykHwtCMf402OafxLFj7CPHBC814RBzQmy52
	 8ji08bQ0tN+EbEWZzcmmJoQ8SUHLlv5DrTr2+Bi05SEaVgMxD9TnSLvIaXlV3rA6MQ
	 SiwKNNAV1g3bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5715EC282C5;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Fri, 28 Feb 2025 16:04:13 +0800
Subject: [PATCH v3 5/6] ASoC: meson: s4: Add s4 tocodec driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-audio_drvier-v3-5-dbfd30507e4c@amlogic.com>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
In-Reply-To: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740729873; l=4499;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=zvreiq77mtoUZZXMTxU9B9XQTVwpm3omZ1yAdi/Zb+k=;
 b=zuMV2pPva/jm6Re3wgtAZjAq9vq8UXNHNT3J9yfsa5m0aYBMjxXeS9EGuIm3X2P2DlJFjCQV9
 FJCoCXpRWIYBM1xOpsITX2wDd5elHvMOLVwLLx3reg8WkemSo0OXrd9
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

S4 tocodec support 8 lane to input, It need to enable
bclk and mclk control bit when work

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 sound/soc/meson/g12a-toacodec.c | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 531bb8707a3ec4c47814d6a0676d5c62c705da75..41eef9980059285275f0189a06469fc694775955 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -41,6 +41,9 @@
 #define  CTRL0_BCLK_SEL_LSB		4
 #define  CTRL0_MCLK_SEL			GENMASK(2, 0)
 
+#define CTRL0_BCLK_ENABLE_SHIFT		30
+#define CTRL0_MCLK_ENABLE_SHIFT		29
+
 #define TOACODEC_OUT_CHMAX		2
 
 struct g12a_toacodec {
@@ -129,6 +132,10 @@ static const struct snd_kcontrol_new g12a_toacodec_out_enable =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
 				    CTRL0_ENABLE_SHIFT, 1, 0);
 
+static const struct snd_kcontrol_new s4_toacodec_clk_enable =
+	SOC_DAPM_DOUBLE("Switch", TOACODEC_CTRL0,
+			CTRL0_BCLK_ENABLE_SHIFT, CTRL0_MCLK_ENABLE_SHIFT, 1, 0);
+
 static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
 	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
 			 &g12a_toacodec_mux),
@@ -143,6 +150,15 @@ static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
 			    &g12a_toacodec_out_enable),
 };
 
+static const struct snd_soc_dapm_widget s4_toacodec_widgets[] = {
+	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
+			 &sm1_toacodec_mux),
+	SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_toacodec_out_enable),
+	SND_SOC_DAPM_SWITCH("CLK EN", SND_SOC_NOPM, 0, 0,
+			    &s4_toacodec_clk_enable),
+};
+
 static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *params,
 					 struct snd_soc_dai *dai)
@@ -228,6 +244,15 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
 	{ "OUT Capture", NULL, "OUT EN" },
 };
 
+static const struct snd_soc_dapm_route s4_toacodec_routes[] = {
+	{ "SRC", "I2S A", "IN A Playback" },
+	{ "SRC", "I2S B", "IN B Playback" },
+	{ "SRC", "I2S C", "IN C Playback" },
+	{ "OUT EN", "Switch", "SRC" },
+	{ "CLK EN", "Switch", "OUT EN" },
+	{ "OUT Capture", NULL, "CLK EN" },
+};
+
 static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
 	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
 };
@@ -236,6 +261,10 @@ static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
 	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
 };
 
+static const struct snd_kcontrol_new s4_toacodec_controls[] = {
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 7, 0),
+};
+
 static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
 	.probe			= g12a_toacodec_component_probe,
 	.controls		= g12a_toacodec_controls,
@@ -258,6 +287,17 @@ static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
 	.endianness		= 1,
 };
 
+static const struct snd_soc_component_driver s4_toacodec_component_drv = {
+	.probe			= sm1_toacodec_component_probe,
+	.controls		= s4_toacodec_controls,
+	.num_controls		= ARRAY_SIZE(s4_toacodec_controls),
+	.dapm_widgets		= s4_toacodec_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(s4_toacodec_widgets),
+	.dapm_routes		= s4_toacodec_routes,
+	.num_dapm_routes	= ARRAY_SIZE(s4_toacodec_routes),
+	.endianness		= 1,
+};
+
 static const struct regmap_config g12a_toacodec_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -278,6 +318,13 @@ static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
 	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, 4, 6),
 };
 
+static const struct g12a_toacodec_match_data s4_toacodec_match_data = {
+	.component_drv	= &s4_toacodec_component_drv,
+	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, 19, 20),
+	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 12, 14),
+	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, 4, 6),
+};
+
 static const struct of_device_id g12a_toacodec_of_match[] = {
 	{
 		.compatible = "amlogic,g12a-toacodec",
@@ -287,6 +334,10 @@ static const struct of_device_id g12a_toacodec_of_match[] = {
 		.compatible = "amlogic,sm1-toacodec",
 		.data = &sm1_toacodec_match_data,
 	},
+	{
+		.compatible = "amlogic,s4-toacodec",
+		.data = &s4_toacodec_match_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);

-- 
2.43.0




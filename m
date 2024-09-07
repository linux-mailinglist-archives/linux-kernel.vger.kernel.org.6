Return-Path: <linux-kernel+bounces-319573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8C96FECB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C825282F74
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817BCE541;
	Sat,  7 Sep 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbz3QdX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37EDDA1;
	Sat,  7 Sep 2024 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670537; cv=none; b=Q40gNm3PAKYpvMqDhKaq4bURHc3r+hObcA4djskvDY2qIucOimux0YOFQdYlxR5VeHOGbZnL4xmZGTlNGWilLFHvDgVlp8Ca98Amo/vjn4JM47b9vXGeZPKLtPwQ2YuPXNbDA/aenE3lK9Fph+syrlsugFRIX60/UqiQkMHey7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670537; c=relaxed/simple;
	bh=IyWmu4DnoFuCIPAtXWPw8SVtC2zLrvIEG26z/VzRYQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPhjlVmDHavLd2c1lt+DJR+6YmDewC1wK70Cp9ev7UuJx2enfJhJ1g5Qw+aj4XXyh0PQ9TgxCh2TBDYmwGCghRnv8dnx2YtI790aPgfBS2RH2cfpdIeJlYcfGUTV6aiXYqC28eE3puoqR+z/IlJiYWCXfdGFCDkK+3gA7aoKjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbz3QdX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C6C4CEC9;
	Sat,  7 Sep 2024 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725670537;
	bh=IyWmu4DnoFuCIPAtXWPw8SVtC2zLrvIEG26z/VzRYQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbz3QdX8P5AKEBFnJWtZZX1WapHIACqdLWrTGd+HxYRdNrpntBa1lGkacPBWd8iTe
	 QmGiCDsvnjSccG8C9X51YWiyHaWD+CebJE27tXcx0cecUhn0NU7d2BPq/hla5838/1
	 oN9dJDmnp2s5crHV9g0m5SsIHsJTtjEjU/OdzhO2v68nhNjn9DE3mssSGxES/dCMvU
	 h0zb7PvuWZby8GfjpY5Wk2tsNtZQu3C0RNMvAqKReqhLul5472D4ckflWiwxjaLybO
	 eE5GdezE10N1xAeuT4PhPbuGKIPr5CFJWtzThyAixeq+rFQdwWA/8siJi7kKwIBRpM
	 QcdwYlPe6H2wQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Sep 2024 01:53:26 +0100
Subject: [PATCH 1/7] ASoC: mt8365: Open code BIT() to avoid spurious
 warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-asoc-fix-mt8365-build-v1-1-7ad0bac20161@kernel.org>
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=12902; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IyWmu4DnoFuCIPAtXWPw8SVtC2zLrvIEG26z/VzRYQ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm26R9/Ba36Aai3qZF7yqr0peg9E9zHo18oCWB1
 cf92ZALXoaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtukfQAKCRAk1otyXVSH
 0Ad9B/9HMX0ox4ptcHxsyooXsguJhgP3qIOpW8QY/RaZxFlabiG7Zx246FTsgu+COsBb9liQZUb
 z9KK9Yep4XRip7xuGgwbtX6I5yGcBsdz6H76XLt2gNvJtnjRjIaYv9JCbgwhx6B/bnmD1lCNxCo
 N5NP0T/5NK+RNmgiHBrmuPvajxrQ9PgSDtpxMx2o3vR8Wg2PFvz+AkiQpwzvIyOE7M4T+k+p9Vo
 BoTBQaqYS4OsPkskM4MckesWQYMWWLCLyW6NBqhjCV4b518BYp49J9chYqQ6EWIm7KUal1QlMx3
 x+lPdIZHBzdsSsm2LhykhQfpQLHwHcJ4ER8hyTHYdRKgrovi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The mt8365 driver uses bits.h to define bitfields but BIT() uses unsigned
long constants so does not play well with being bitwise negated and
converted to an unsigned int, the compiler complains about width reduction
on a number of architectures. Just open code the shifting to avoid the
issue.

Generated with s/BIT(/(1U << /

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8365/mt8365-reg.h | 214 ++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-reg.h b/sound/soc/mediatek/mt8365/mt8365-reg.h
index b7334c2e64ed..b763cddc93db 100644
--- a/sound/soc/mediatek/mt8365/mt8365-reg.h
+++ b/sound/soc/mediatek/mt8365/mt8365-reg.h
@@ -734,57 +734,57 @@
 #define AFE_IRQ_STATUS_BITS		0x3ff
 
 /* AUDIO_TOP_CON0 (0x0000) */
-#define AUD_TCON0_PDN_TML		BIT(27)
-#define AUD_TCON0_PDN_DAC_PREDIS	BIT(26)
-#define AUD_TCON0_PDN_DAC		BIT(25)
-#define AUD_TCON0_PDN_ADC		BIT(24)
-#define AUD_TCON0_PDN_TDM_IN		BIT(23)
-#define AUD_TCON0_PDN_TDM_OUT		BIT(22)
-#define AUD_TCON0_PDN_SPDIF		BIT(21)
-#define AUD_TCON0_PDN_APLL_TUNER	BIT(19)
-#define AUD_TCON0_PDN_APLL2_TUNER	BIT(18)
-#define AUD_TCON0_PDN_INTDIR		BIT(15)
-#define AUD_TCON0_PDN_24M		BIT(9)
-#define AUD_TCON0_PDN_22M		BIT(8)
-#define AUD_TCON0_PDN_I2S_IN		BIT(6)
-#define AUD_TCON0_PDN_AFE		BIT(2)
+#define AUD_TCON0_PDN_TML		(1U << 27)
+#define AUD_TCON0_PDN_DAC_PREDIS	(1U << 26)
+#define AUD_TCON0_PDN_DAC		(1U << 25)
+#define AUD_TCON0_PDN_ADC		(1U << 24)
+#define AUD_TCON0_PDN_TDM_IN		(1U << 23)
+#define AUD_TCON0_PDN_TDM_OUT		(1U << 22)
+#define AUD_TCON0_PDN_SPDIF		(1U << 21)
+#define AUD_TCON0_PDN_APLL_TUNER	(1U << 19)
+#define AUD_TCON0_PDN_APLL2_TUNER	(1U << 18)
+#define AUD_TCON0_PDN_INTDIR		(1U << 15)
+#define AUD_TCON0_PDN_24M		(1U << 9)
+#define AUD_TCON0_PDN_22M		(1U << 8)
+#define AUD_TCON0_PDN_I2S_IN		(1U << 6)
+#define AUD_TCON0_PDN_AFE		(1U << 2)
 
 /* AUDIO_TOP_CON1 (0x0004) */
-#define AUD_TCON1_PDN_TDM_ASRC		BIT(15)
-#define AUD_TCON1_PDN_GENERAL2_ASRC	BIT(14)
-#define AUD_TCON1_PDN_GENERAL1_ASRC	BIT(13)
-#define AUD_TCON1_PDN_CONNSYS_I2S_ASRC	BIT(12)
-#define AUD_TCON1_PDN_DMIC3_ADC		BIT(11)
-#define AUD_TCON1_PDN_DMIC2_ADC		BIT(10)
-#define AUD_TCON1_PDN_DMIC1_ADC		BIT(9)
-#define AUD_TCON1_PDN_DMIC0_ADC		BIT(8)
-#define AUD_TCON1_PDN_I2S4_BCLK		BIT(7)
-#define AUD_TCON1_PDN_I2S3_BCLK		BIT(6)
-#define AUD_TCON1_PDN_I2S2_BCLK		BIT(5)
-#define AUD_TCON1_PDN_I2S1_BCLK		BIT(4)
+#define AUD_TCON1_PDN_TDM_ASRC		(1U << 15)
+#define AUD_TCON1_PDN_GENERAL2_ASRC	(1U << 14)
+#define AUD_TCON1_PDN_GENERAL1_ASRC	(1U << 13)
+#define AUD_TCON1_PDN_CONNSYS_I2S_ASRC	(1U << 12)
+#define AUD_TCON1_PDN_DMIC3_ADC		(1U << 11)
+#define AUD_TCON1_PDN_DMIC2_ADC		(1U << 10)
+#define AUD_TCON1_PDN_DMIC1_ADC		(1U << 9)
+#define AUD_TCON1_PDN_DMIC0_ADC		(1U << 8)
+#define AUD_TCON1_PDN_I2S4_BCLK		(1U << 7)
+#define AUD_TCON1_PDN_I2S3_BCLK		(1U << 6)
+#define AUD_TCON1_PDN_I2S2_BCLK		(1U << 5)
+#define AUD_TCON1_PDN_I2S1_BCLK		(1U << 4)
 
 /* AUDIO_TOP_CON3 (0x000C) */
-#define AUD_TCON3_HDMI_BCK_INV		BIT(3)
+#define AUD_TCON3_HDMI_BCK_INV		(1U << 3)
 
 /* AFE_I2S_CON (0x0018) */
-#define AFE_I2S_CON_PHASE_SHIFT_FIX	BIT(31)
-#define AFE_I2S_CON_FROM_IO_MUX		BIT(28)
-#define AFE_I2S_CON_LOW_JITTER_CLK	BIT(12)
+#define AFE_I2S_CON_PHASE_SHIFT_FIX	(1U << 31)
+#define AFE_I2S_CON_FROM_IO_MUX		(1U << 28)
+#define AFE_I2S_CON_LOW_JITTER_CLK	(1U << 12)
 #define AFE_I2S_CON_RATE_MASK		GENMASK(11, 8)
-#define AFE_I2S_CON_FORMAT_I2S		BIT(3)
-#define AFE_I2S_CON_SRC_SLAVE		BIT(2)
+#define AFE_I2S_CON_FORMAT_I2S		(1U << 3)
+#define AFE_I2S_CON_SRC_SLAVE		(1U << 2)
 
 /* AFE_ASRC_2CH_CON0 */
-#define ONE_HEART	BIT(31)
-#define CHSET_STR_CLR	BIT(4)
-#define COEFF_SRAM_CTRL	BIT(1)
-#define ASM_ON		BIT(0)
+#define ONE_HEART	(1U << 31)
+#define CHSET_STR_CLR	(1U << 4)
+#define COEFF_SRAM_CTRL	(1U << 1)
+#define ASM_ON		(1U << 0)
 
 /* CON2 */
-#define O16BIT		BIT(19)
-#define CLR_IIR_HISTORY	BIT(17)
-#define IS_MONO		BIT(16)
-#define IIR_EN		BIT(11)
+#define O16BIT		(1U << 19)
+#define CLR_IIR_HISTORY	(1U << 17)
+#define IS_MONO		(1U << 16)
+#define IIR_EN		(1U << 11)
 #define IIR_STAGE_MASK	GENMASK(10, 8)
 
 /* CON5 */
@@ -793,80 +793,80 @@
 #define CALI_96_CYCLE	FIELD_PREP(CALI_CYCLE_MASK, 0x5F)
 #define CALI_441_CYCLE	FIELD_PREP(CALI_CYCLE_MASK, 0x1B8)
 
-#define CALI_AUTORST	BIT(15)
-#define AUTO_TUNE_FREQ5	BIT(12)
-#define COMP_FREQ_RES	BIT(11)
+#define CALI_AUTORST	(1U << 15)
+#define AUTO_TUNE_FREQ5	(1U << 12)
+#define COMP_FREQ_RES	(1U << 11)
 
 #define CALI_SEL_MASK	GENMASK(9, 8)
 #define CALI_SEL_00	FIELD_PREP(CALI_SEL_MASK, 0)
 #define CALI_SEL_01	FIELD_PREP(CALI_SEL_MASK, 1)
 
-#define CALI_BP_DGL		BIT(7) /* Bypass the deglitch circuit */
-#define AUTO_TUNE_FREQ4		BIT(3)
-#define CALI_AUTO_RESTART	BIT(2)
-#define CALI_USE_FREQ_OUT	BIT(1)
-#define CALI_ON			BIT(0)
+#define CALI_BP_DGL		(1U << 7) /* Bypass the deglitch circuit */
+#define AUTO_TUNE_FREQ4		(1U << 3)
+#define CALI_AUTO_RESTART	(1U << 2)
+#define CALI_USE_FREQ_OUT	(1U << 1)
+#define CALI_ON			(1U << 0)
 
-#define AFE_I2S_CON_WLEN_32BIT		BIT(1)
-#define AFE_I2S_CON_EN			BIT(0)
+#define AFE_I2S_CON_WLEN_32BIT		(1U << 1)
+#define AFE_I2S_CON_EN			(1U << 0)
 
-#define AFE_CONN3_I03_O03_S		BIT(3)
-#define AFE_CONN4_I04_O04_S		BIT(4)
-#define AFE_CONN4_I03_O04_S		BIT(3)
+#define AFE_CONN3_I03_O03_S		(1U << 3)
+#define AFE_CONN4_I04_O04_S		(1U << 4)
+#define AFE_CONN4_I03_O04_S		(1U << 3)
 
 /* AFE_I2S_CON1 (0x0034) */
-#define AFE_I2S_CON1_I2S2_TO_PAD	BIT(18)
+#define AFE_I2S_CON1_I2S2_TO_PAD	(1U << 18)
 #define AFE_I2S_CON1_TDMOUT_TO_PAD	(0 << 18)
 #define AFE_I2S_CON1_RATE		GENMASK(11, 8)
-#define AFE_I2S_CON1_FORMAT_I2S		BIT(3)
-#define AFE_I2S_CON1_WLEN_32BIT		BIT(1)
-#define AFE_I2S_CON1_EN			BIT(0)
+#define AFE_I2S_CON1_FORMAT_I2S		(1U << 3)
+#define AFE_I2S_CON1_WLEN_32BIT		(1U << 1)
+#define AFE_I2S_CON1_EN			(1U << 0)
 
 /* AFE_I2S_CON2 (0x0038) */
-#define AFE_I2S_CON2_LOW_JITTER_CLK	BIT(12)
+#define AFE_I2S_CON2_LOW_JITTER_CLK	(1U << 12)
 #define AFE_I2S_CON2_RATE		GENMASK(11, 8)
-#define AFE_I2S_CON2_FORMAT_I2S		BIT(3)
-#define AFE_I2S_CON2_WLEN_32BIT		BIT(1)
-#define AFE_I2S_CON2_EN			BIT(0)
+#define AFE_I2S_CON2_FORMAT_I2S		(1U << 3)
+#define AFE_I2S_CON2_WLEN_32BIT		(1U << 1)
+#define AFE_I2S_CON2_EN			(1U << 0)
 
 /* AFE_I2S_CON3 (0x004C) */
-#define AFE_I2S_CON3_LOW_JITTER_CLK	BIT(12)
+#define AFE_I2S_CON3_LOW_JITTER_CLK	(1U << 12)
 #define AFE_I2S_CON3_RATE		GENMASK(11, 8)
-#define AFE_I2S_CON3_FORMAT_I2S		BIT(3)
-#define AFE_I2S_CON3_WLEN_32BIT		BIT(1)
-#define AFE_I2S_CON3_EN			BIT(0)
+#define AFE_I2S_CON3_FORMAT_I2S		(1U << 3)
+#define AFE_I2S_CON3_WLEN_32BIT		(1U << 1)
+#define AFE_I2S_CON3_EN			(1U << 0)
 
 /* AFE_ADDA_DL_SRC2_CON0 (0x0108) */
 #define AFE_ADDA_DL_SAMPLING_RATE	GENMASK(31, 28)
 #define AFE_ADDA_DL_8X_UPSAMPLE		GENMASK(25, 24)
-#define AFE_ADDA_DL_MUTE_OFF_CH1	BIT(12)
-#define AFE_ADDA_DL_MUTE_OFF_CH2	BIT(11)
-#define AFE_ADDA_DL_VOICE_DATA		BIT(5)
-#define AFE_ADDA_DL_DEGRADE_GAIN	BIT(1)
+#define AFE_ADDA_DL_MUTE_OFF_CH1	(1U << 12)
+#define AFE_ADDA_DL_MUTE_OFF_CH2	(1U << 11)
+#define AFE_ADDA_DL_VOICE_DATA		(1U << 5)
+#define AFE_ADDA_DL_DEGRADE_GAIN	(1U << 1)
 
 /* AFE_ADDA_UL_SRC_CON0 (0x0114) */
 #define AFE_ADDA_UL_SAMPLING_RATE	GENMASK(19, 17)
 
 /* AFE_ADDA_UL_DL_CON0 */
-#define AFE_ADDA_UL_DL_ADDA_AFE_ON	BIT(0)
-#define AFE_ADDA_UL_DL_DMIC_CLKDIV_ON	BIT(1)
+#define AFE_ADDA_UL_DL_ADDA_AFE_ON	(1U << 0)
+#define AFE_ADDA_UL_DL_DMIC_CLKDIV_ON	(1U << 1)
 
 /* AFE_APLL_TUNER_CFG (0x03f0) */
 #define AFE_APLL_TUNER_CFG_MASK		GENMASK(15, 1)
-#define AFE_APLL_TUNER_CFG_EN_MASK	BIT(0)
+#define AFE_APLL_TUNER_CFG_EN_MASK	(1U << 0)
 
 /* AFE_APLL_TUNER_CFG1 (0x03f4) */
 #define AFE_APLL_TUNER_CFG1_MASK	GENMASK(15, 1)
-#define AFE_APLL_TUNER_CFG1_EN_MASK	BIT(0)
+#define AFE_APLL_TUNER_CFG1_EN_MASK	(1U << 0)
 
 /* PCM_INTF_CON1 (0x0550) */
-#define PCM_INTF_CON1_EXT_MODEM		BIT(17)
+#define PCM_INTF_CON1_EXT_MODEM		(1U << 17)
 #define PCM_INTF_CON1_16BIT		(0 << 16)
-#define PCM_INTF_CON1_24BIT		BIT(16)
+#define PCM_INTF_CON1_24BIT		(1U << 16)
 #define PCM_INTF_CON1_32BCK		(0 << 14)
-#define PCM_INTF_CON1_64BCK		BIT(14)
+#define PCM_INTF_CON1_64BCK		(1U << 14)
 #define PCM_INTF_CON1_MASTER_MODE	(0 << 5)
-#define PCM_INTF_CON1_SLAVE_MODE	BIT(5)
+#define PCM_INTF_CON1_SLAVE_MODE	(1U << 5)
 #define PCM_INTF_CON1_FS_MASK		GENMASK(4, 3)
 #define PCM_INTF_CON1_FS_8K		FIELD_PREP(PCM_INTF_CON1_FS_MASK, 0)
 #define PCM_INTF_CON1_FS_16K		FIELD_PREP(PCM_INTF_CON1_FS_MASK, 1)
@@ -875,12 +875,12 @@
 #define PCM_INTF_CON1_SYNC_LEN_MASK	GENMASK(13, 9)
 #define PCM_INTF_CON1_SYNC_LEN(x)	FIELD_PREP(PCM_INTF_CON1_SYNC_LEN_MASK, ((x) - 1))
 #define PCM_INTF_CON1_FORMAT_MASK	GENMASK(2, 1)
-#define PCM_INTF_CON1_SYNC_OUT_INV	BIT(23)
-#define PCM_INTF_CON1_BCLK_OUT_INV	BIT(22)
-#define PCM_INTF_CON1_SYNC_IN_INV	BIT(21)
-#define PCM_INTF_CON1_BCLK_IN_INV	BIT(20)
-#define PCM_INTF_CON1_BYPASS_ASRC	BIT(6)
-#define PCM_INTF_CON1_EN		BIT(0)
+#define PCM_INTF_CON1_SYNC_OUT_INV	(1U << 23)
+#define PCM_INTF_CON1_BCLK_OUT_INV	(1U << 22)
+#define PCM_INTF_CON1_SYNC_IN_INV	(1U << 21)
+#define PCM_INTF_CON1_BCLK_IN_INV	(1U << 20)
+#define PCM_INTF_CON1_BYPASS_ASRC	(1U << 6)
+#define PCM_INTF_CON1_EN		(1U << 0)
 #define PCM_INTF_CON1_CONFIG_MASK	(0xf3fffe)
 
 /* AFE_DMIC0_UL_SRC_CON0 (0x05b4)
@@ -890,9 +890,9 @@
  */
 #define DMIC_TOP_CON_CK_PHASE_SEL_CH1		GENMASK(29, 27)
 #define DMIC_TOP_CON_CK_PHASE_SEL_CH2		GENMASK(26, 24)
-#define DMIC_TOP_CON_TWO_WIRE_MODE		BIT(23)
-#define DMIC_TOP_CON_CH2_ON			BIT(22)
-#define DMIC_TOP_CON_CH1_ON			BIT(21)
+#define DMIC_TOP_CON_TWO_WIRE_MODE		(1U << 23)
+#define DMIC_TOP_CON_CH2_ON			(1U << 22)
+#define DMIC_TOP_CON_CH1_ON			(1U << 21)
 #define DMIC_TOP_CON_VOICE_MODE_MASK		GENMASK(19, 17)
 #define DMIC_TOP_CON_VOICE_MODE_8K		FIELD_PREP(DMIC_TOP_CON_VOICE_MODE_MASK, 0)
 #define DMIC_TOP_CON_VOICE_MODE_16K		FIELD_PREP(DMIC_TOP_CON_VOICE_MODE_MASK, 1)
@@ -900,28 +900,28 @@
 #define DMIC_TOP_CON_VOICE_MODE_48K		FIELD_PREP(DMIC_TOP_CON_VOICE_MODE_MASK, 3)
 #define DMIC_TOP_CON_LOW_POWER_MODE_MASK	GENMASK(15, 14)
 #define DMIC_TOP_CON_LOW_POWER_MODE(x)		FIELD_PREP(DMIC_TOP_CON_LOW_POWER_MODE_MASK, (x))
-#define DMIC_TOP_CON_IIR_ON			BIT(10)
+#define DMIC_TOP_CON_IIR_ON			(1U << 10)
 #define DMIC_TOP_CON_IIR_MODE			GENMASK(9, 7)
-#define DMIC_TOP_CON_INPUT_MODE			BIT(5)
-#define DMIC_TOP_CON_SDM3_LEVEL_MODE		BIT(1)
-#define DMIC_TOP_CON_SRC_ON			BIT(0)
+#define DMIC_TOP_CON_INPUT_MODE			(1U << 5)
+#define DMIC_TOP_CON_SDM3_LEVEL_MODE		(1U << 1)
+#define DMIC_TOP_CON_SRC_ON			(1U << 0)
 #define DMIC_TOP_CON_SDM3_DE_SELECT		(0 << 1)
 #define DMIC_TOP_CON_CONFIG_MASK		(0x3f8ed7a6)
 
 /* AFE_CONN_24BIT (0x0AA4) */
-#define AFE_CONN_24BIT_O10		BIT(10)
-#define AFE_CONN_24BIT_O09		BIT(9)
-#define AFE_CONN_24BIT_O06		BIT(6)
-#define AFE_CONN_24BIT_O05		BIT(5)
-#define AFE_CONN_24BIT_O04		BIT(4)
-#define AFE_CONN_24BIT_O03		BIT(3)
-#define AFE_CONN_24BIT_O02		BIT(2)
-#define AFE_CONN_24BIT_O01		BIT(1)
-#define AFE_CONN_24BIT_O00		BIT(0)
+#define AFE_CONN_24BIT_O10		(1U << 10)
+#define AFE_CONN_24BIT_O09		(1U << 9)
+#define AFE_CONN_24BIT_O06		(1U << 6)
+#define AFE_CONN_24BIT_O05		(1U << 5)
+#define AFE_CONN_24BIT_O04		(1U << 4)
+#define AFE_CONN_24BIT_O03		(1U << 3)
+#define AFE_CONN_24BIT_O02		(1U << 2)
+#define AFE_CONN_24BIT_O01		(1U << 1)
+#define AFE_CONN_24BIT_O00		(1U << 0)
 
 /* AFE_HD_ENGEN_ENABLE */
-#define AFE_22M_PLL_EN		BIT(0)
-#define AFE_24M_PLL_EN		BIT(1)
+#define AFE_22M_PLL_EN		(1U << 0)
+#define AFE_24M_PLL_EN		(1U << 1)
 
 /* AFE_GAIN1_CON0 (0x0410) */
 #define AFE_GAIN1_CON0_EN_MASK			GENMASK(0, 0)
@@ -938,15 +938,15 @@
 /* AFE_CM2_CON0 (0x0e60) */
 #define CM_AFE_CM_CH_NUM_MASK		GENMASK(3, 0)
 #define CM_AFE_CM_CH_NUM(x)		FIELD_PREP(CM_AFE_CM_CH_NUM_MASK, ((x) - 1))
-#define CM_AFE_CM_ON			BIT(4)
+#define CM_AFE_CM_ON			(1U << 4)
 #define CM_AFE_CM_START_DATA_MASK	GENMASK(11, 8)
 
-#define CM_AFE_CM1_VUL_SEL		BIT(12)
+#define CM_AFE_CM1_VUL_SEL		(1U << 12)
 #define CM_AFE_CM1_IN_MODE_MASK		GENMASK(19, 16)
-#define CM_AFE_CM2_TDM_SEL		BIT(12)
-#define CM_AFE_CM2_CLK_SEL		BIT(13)
-#define CM_AFE_CM2_GASRC1_OUT_SEL	BIT(17)
-#define CM_AFE_CM2_GASRC2_OUT_SEL	BIT(16)
+#define CM_AFE_CM2_TDM_SEL		(1U << 12)
+#define CM_AFE_CM2_CLK_SEL		(1U << 13)
+#define CM_AFE_CM2_GASRC1_OUT_SEL	(1U << 17)
+#define CM_AFE_CM2_GASRC2_OUT_SEL	(1U << 16)
 
 /* AFE_CM2_CONN* */
 #define CM2_AFE_CM2_CONN_CFG1(x)	FIELD_PREP(CM2_AFE_CM2_CONN_CFG1_MASK, (x))

-- 
2.39.2



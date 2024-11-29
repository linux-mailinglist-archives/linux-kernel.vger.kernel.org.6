Return-Path: <linux-kernel+bounces-419062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EAB9D690C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7170281988
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0AE1974EA;
	Sat, 23 Nov 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FJ1fziV3"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7EB18A6C4;
	Sat, 23 Nov 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365783; cv=none; b=KErCAyQyYzCmpe3vXEbyBxam+K3LeN76sMwMgSxmaHGxceHHGCsZSFVmCBt5v2mdD4AR4mueTAwO7bMF/HMwX2TeoMxqqX6J9yAP5DQtTIjBublJ2Z5m8SGybY5SR/YuS56grD31KsMX12Pi6G5riDmcClZnvQf9h7XLax6ZJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365783; c=relaxed/simple;
	bh=k+YpPLVK554lTd59xTMB9sLVU9s9cmKCKnNIFgKaf5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Br8DsmzaAbdo5hqqiG1YiRerkG8rKyh2eFroOIxEI4rt2Vhi3DzW1bRzxdu10xSCUULIf3dtLjFTlLfs/LkKvbVe1mGaCKuBjaxMjKkIVXn77rfGyF+rCodtJjbz0Uo2/l9Kni/OpuVRGY0M3Ip6WyoQDgqqRaD7edj2uYid7Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FJ1fziV3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A7CC3A0302;
	Sat, 23 Nov 2024 13:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=bApCI3jXsFpg4u5/FLjh
	NfZYQlLEMj72lhnooHJoW1M=; b=FJ1fziV3WEsF5Hsm0z+KY+E/O03TyoExHwOc
	N9ppNe3CDHKtqZ2qsigQP0/sgPuKH6rORZ7NTwqktBBcFTMAM6YTyOkt8tfMttg5
	0NfUjwfPEiXcSbDlVvVo1OmbaQvorB1T9piUtFlhP1vJxF68suLjX2s48xeIgV9m
	KsaFhJs1rMeRmoDxSuCGjmGFhQfOzAE+Zonxk0B79ecLzZpwMZ8PZjI2TEPx9sQr
	4vpE8pixAHc1+oVGZw8aibG6AGKPxwNQ78G7rzU5DZMcuaHhGVeKpWVc8xmjmxDf
	1bn+Ggwwfj7p7lT/fBuiCKWBAXtJviRiAL5VJSO8zD6PqJ98QKKZaGYZWAGstplD
	TbjDwSOmAjPVqgsoNYIO18pA9bNAZBGKg5SMdzsnwnXDdatmEgmUmEih8qT1kptg
	sIG/UxDtYlXTBHoWFa6cmm+wAnGer3uKsQfvj8QS4ZolseK4ON2pggYfa34r+ggI
	5yEy72knjVPiPdZJpF88WqhD6ZYixmzQURQQcPy1vwWQMSot+70zg0RxC6UfL3V9
	5Tg0EgoWMRE1cBe2rsYwxrYDohydTg1tbl7thqPxhYobFishA0MGG/0oDZah8PbM
	MRMBibxc6mW5+olUFHV+AL/m3eTKDgpUgddiEtlMgs30Hx/AnLGz+DwdkYjKMUR7
	bzsj9yg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>
Subject: [PATCH v6 3/5] ASoC: sun4i-codec: Add support for Allwinner suniv F1C100s
Date: Sat, 23 Nov 2024 13:39:02 +0100
Message-ID: <20241123123900.2656837-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732365777;VERSION=7980;MC=3691182566;ID=80954;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560726B

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has similar but primitive audio codec
comparared to sun4i. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Remove `non_legacy_dai_naming`, add `reg_dac_fifoc` ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Whitespace
    Changes in v6:
    * Rebase again on current master
    * Add `reg_dac_fifoc`

 sound/soc/sunxi/sun4i-codec.c | 353 ++++++++++++++++++++++++++++++++++
 1 file changed, 353 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 275f77f60830..3d6156fefe75 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -5,6 +5,7 @@
  * Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
  * Copyright 2015 Adam Sampson <ats@offog.org>
  * Copyright 2016 Chen-Yu Tsai <wens@csie.org>
+ * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  *
  * Based on the Allwinner SDK driver, released under the GPL.
  */
@@ -267,6 +268,62 @@
 
 #define SUN4I_DMA_MAX_BURST			(8)
 
+/* suniv specific registers */
+
+#define SUNIV_DMA_MAX_BURST			(4)
+
+/* Codec DAC digital controls and FIFO registers */
+#define SUNIV_CODEC_ADC_FIFOC			(0x10)
+#define SUNIV_CODEC_ADC_FIFOC_EN_AD		(28)
+#define SUNIV_CODEC_ADC_FIFOS			(0x14)
+#define SUNIV_CODEC_ADC_RXDATA			(0x18)
+
+/* Output mixer and gain controls */
+#define SUNIV_CODEC_OM_DACA_CTRL			(0x20)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACAREN		(31)
+#define SUNIV_CODEC_OM_DACA_CTRL_DACALEN		(30)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXEN			(29)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXEN			(28)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE		(27)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE		(26)
+#define SUNIV_CODEC_OM_DACA_CTRL_RHPIS			(25)
+#define SUNIV_CODEC_OM_DACA_CTRL_LHPIS			(24)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL		(22)
+#define SUNIV_CODEC_OM_DACA_CTRL_COMPTEN		(21)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN		(20)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN	(19)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN		(18)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC		(17)
+#define SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC		(16)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPPAEN			(15)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN		(12)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN	(11)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN		(10)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC		(9)
+#define SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC		(8)
+#define SUNIV_CODEC_OM_DACA_CTRL_LTLNMUTE		(7)
+#define SUNIV_CODEC_OM_DACA_CTRL_RTLNMUTE		(6)
+#define SUNIV_CODEC_OM_DACA_CTRL_HPVOL			(0)
+
+/* Analog Input Mixer controls */
+#define SUNIV_CODEC_ADC_ACTL		(0x24)
+#define SUNIV_CODEC_ADC_ADCEN		(31)
+#define SUNIV_CODEC_ADC_MICG		(24)
+#define SUNIV_CODEC_ADC_LINEINVOL	(21)
+#define SUNIV_CODEC_ADC_ADCG		(16)
+#define SUNIV_CODEC_ADC_ADCMIX_MIC	(13)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINL	(12)
+#define SUNIV_CODEC_ADC_ADCMIX_FMINR	(11)
+#define SUNIV_CODEC_ADC_ADCMIX_LINEIN	(10)
+#define SUNIV_CODEC_ADC_ADCMIX_LOUT	(9)
+#define SUNIV_CODEC_ADC_ADCMIX_ROUT	(8)
+#define SUNIV_CODEC_ADC_PASPEEDSELECT	(7)
+#define SUNIV_CODEC_ADC_FMINVOL		(4)
+#define SUNIV_CODEC_ADC_MICAMPEN	(3)
+#define SUNIV_CODEC_ADC_MICBOOST	(0)
+
+#define SUNIV_CODEC_ADC_DBG		(0x4c)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1257,6 +1314,228 @@ static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
 	.endianness		= 1,
 };
 
+/*suniv F1C100s codec */
+
+/* headphone controls */
+static const char * const suniv_codec_hp_src_enum_text[] = {
+	"DAC", "Mixer",
+};
+
+static SOC_ENUM_DOUBLE_DECL(suniv_codec_hp_src_enum,
+			    SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_LHPIS,
+			    SUNIV_CODEC_OM_DACA_CTRL_RHPIS,
+			    suniv_codec_hp_src_enum_text);
+
+static const struct snd_kcontrol_new suniv_codec_hp_src[] = {
+	SOC_DAPM_ENUM("Headphone Source Playback Route",
+		      suniv_codec_hp_src_enum),
+};
+
+/* mixer controls */
+static const struct snd_kcontrol_new suniv_codec_adc_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Right Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_ROUT, 1, 0),
+	SOC_DAPM_SINGLE("Left Out Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LOUT, 1, 0),
+	SOC_DAPM_SINGLE("Line In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Right FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINR, 1, 0),
+	SOC_DAPM_SINGLE("Left FM In Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_FMINL, 1, 0),
+	SOC_DAPM_SINGLE("Mic Capture Switch", SUNIV_CODEC_ADC_ACTL,
+			SUNIV_CODEC_ADC_ADCMIX_MIC, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_lmixer_controls[] = {
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXMUTE_MICIN, 1, 0),
+};
+
+static const struct snd_kcontrol_new suniv_codec_dac_rmixer_controls[] = {
+	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LDAC, 1, 0),
+	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_RDAC, 1, 0),
+	SOC_DAPM_SINGLE("FM In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_FMIN, 1, 0),
+	SOC_DAPM_SINGLE("Line In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_LINEIN, 1, 0),
+	SOC_DAPM_SINGLE("Mic In Playback Switch", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXMUTE_MICIN, 1, 0),
+};
+
+static const DECLARE_TLV_DB_SCALE(suniv_codec_dvol_scale, -7308, 116, 0);
+static const DECLARE_TLV_DB_SCALE(suniv_codec_hp_vol_scale, -6300, 100, 1);
+static const DECLARE_TLV_DB_SCALE(suniv_codec_out_mixer_pregain_scale,
+				  -450, 150, 0);
+
+static const DECLARE_TLV_DB_RANGE(suniv_codec_mic_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0),
+);
+
+static const struct snd_kcontrol_new suniv_codec_codec_widgets[] = {
+	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
+		       SUN4I_CODEC_DAC_DPC_DVOL, 0x3f, 1,
+		       suniv_codec_dvol_scale),
+	SOC_SINGLE_TLV("Headphone Playback Volume",
+		       SUNIV_CODEC_OM_DACA_CTRL,
+		       SUNIV_CODEC_OM_DACA_CTRL_HPVOL, 0x3f, 0,
+		       suniv_codec_hp_vol_scale),
+	SOC_DOUBLE("Headphone Playback Switch",
+		   SUNIV_CODEC_OM_DACA_CTRL,
+		   SUNIV_CODEC_OM_DACA_CTRL_LHPPAMUTE,
+		   SUNIV_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+	SOC_SINGLE_TLV("Line In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_LINEINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("FM In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_FMINVOL,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("Mic In Playback Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_MICG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+
+	/* Microphone Amp boost gains */
+	SOC_SINGLE_TLV("Mic Boost Volume", SUNIV_CODEC_ADC_ACTL,
+		       SUNIV_CODEC_ADC_MICBOOST, 0x7, 0,
+		       suniv_codec_mic_gain_scale),
+	SOC_SINGLE_TLV("ADC Capture Volume",
+		       SUNIV_CODEC_ADC_ACTL, SUNIV_CODEC_ADC_ADCG,
+		       0x7, 0, suniv_codec_out_mixer_pregain_scale),
+};
+
+static const struct snd_soc_dapm_widget suniv_codec_codec_dapm_widgets[] = {
+	/* Microphone inputs */
+	SND_SOC_DAPM_INPUT("MIC"),
+
+	/* Microphone Bias */
+	/* deleted: HBIAS, MBIAS */
+
+	/* Mic input path */
+	SND_SOC_DAPM_PGA("Mic Amplifier", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_MICAMPEN, 0, NULL, 0),
+
+	/* Line In */
+	SND_SOC_DAPM_INPUT("LINEIN"),
+
+	/* FM In */
+	SND_SOC_DAPM_INPUT("FMINR"),
+	SND_SOC_DAPM_INPUT("FMINL"),
+
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUNIV_CODEC_ADC_FIFOC,
+			    SUNIV_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("ADC", "Codec Capture", SUNIV_CODEC_ADC_ACTL,
+			 SUNIV_CODEC_ADC_ADCEN, 0),
+
+	/* ADC Mixers */
+	SOC_MIXER_ARRAY("ADC Mixer", SUNIV_CODEC_ADC_ACTL,
+			SND_SOC_NOPM, 0,
+			suniv_codec_adc_mixer_controls),
+
+	/* Digital parts of the DACs */
+	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
+			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
+			    NULL, 0),
+
+	/* Analog parts of the DACs */
+	SND_SOC_DAPM_DAC("Left DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACALEN, 0),
+	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback",
+			 SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_DACAREN, 0),
+
+	/* Mixers */
+	SOC_MIXER_ARRAY("Left Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_LMIXEN, 0,
+			suniv_codec_dac_lmixer_controls),
+	SOC_MIXER_ARRAY("Right Mixer", SUNIV_CODEC_OM_DACA_CTRL,
+			SUNIV_CODEC_OM_DACA_CTRL_RMIXEN, 0,
+			suniv_codec_dac_rmixer_controls),
+
+	/* Headphone output path */
+	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, suniv_codec_hp_src),
+	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUNIV_CODEC_OM_DACA_CTRL,
+			     SUNIV_CODEC_OM_DACA_CTRL_HPPAEN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("HPCOM Protection", SUNIV_CODEC_OM_DACA_CTRL,
+			    SUNIV_CODEC_OM_DACA_CTRL_COMPTEN, 0, NULL, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUNIV_CODEC_OM_DACA_CTRL,
+			 SUNIV_CODEC_OM_DACA_CTRL_HPCOM_CTL, 0x3, 0x3, 0),
+	SND_SOC_DAPM_OUTPUT("HP"),
+};
+
+static const struct snd_soc_dapm_route suniv_codec_codec_dapm_routes[] = {
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+
+	/* Microphone Routes */
+	{ "Mic Amplifier", NULL, "MIC"},
+
+	/* Left Mixer Routes */
+	{ "Left Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "FM In Playback Switch", "FMINL" },
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Left Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* Right Mixer Routes */
+	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "FM In Playback Switch", "FMINR" },
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Right Mixer", "Mic In Playback Switch", "Mic Amplifier" },
+
+	/* ADC Mixer Routes */
+	{ "ADC Mixer", "Right Out Capture Switch", "Right Mixer" },
+	{ "ADC Mixer", "Left Out Capture Switch", "Left Mixer" },
+	{ "ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "ADC Mixer", "Right FM In Capture Switch", "FMINR" },
+	{ "ADC Mixer", "Left FM In Capture Switch", "FMINL" },
+	{ "ADC Mixer", "Mic Capture Switch", "Mic Amplifier" },
+
+	/* Headphone Routes */
+	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
+	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
+	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
+	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
+	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "HP", NULL, "Headphone Amp" },
+	{ "HPCOM", NULL, "HPCOM Protection" },
+
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Mixer" },
+	{ "ADC", NULL, "ADC Enable" },
+};
+
+static const struct snd_soc_component_driver suniv_codec_codec = {
+	.controls		= suniv_codec_codec_widgets,
+	.num_controls		= ARRAY_SIZE(suniv_codec_codec_widgets),
+	.dapm_widgets		= suniv_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(suniv_codec_codec_dapm_widgets),
+	.dapm_routes		= suniv_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(suniv_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
 static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name			= "sun4i-codec",
 	.legacy_dai_naming	= 1,
@@ -1703,6 +1982,56 @@ static struct snd_soc_card *sun50i_h616_codec_create_card(struct device *dev)
 	return card;
 };
 
+static const struct snd_soc_dapm_widget suniv_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+	SND_SOC_DAPM_LINE("Right FM In", NULL),
+	SND_SOC_DAPM_LINE("Left FM In", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
+/* Connect digital side enables to analog side widgets */
+static const struct snd_soc_dapm_route suniv_codec_card_routes[] = {
+	/* ADC Routes */
+	{ "ADC", NULL, "ADC Enable" },
+	{ "Codec Capture", NULL, "ADC" },
+
+	/* DAC Routes */
+	{ "Left DAC", NULL, "DAC Enable" },
+	{ "Right DAC", NULL, "DAC Enable" },
+	{ "Left DAC", NULL, "Codec Playback" },
+	{ "Right DAC", NULL, "Codec Playback" },
+};
+
+static struct snd_soc_card *suniv_codec_create_card(struct device *dev)
+{
+	struct snd_soc_card *card;
+	int ret;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return ERR_PTR(-ENOMEM);
+
+	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
+	if (!card->dai_link)
+		return ERR_PTR(-ENOMEM);
+
+	card->dev		= dev;
+	card->name		= "F1C100s Audio Codec";
+	card->dapm_widgets	= suniv_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(suniv_codec_card_dapm_widgets);
+	card->dapm_routes	= suniv_codec_card_routes;
+	card->num_dapm_routes	= ARRAY_SIZE(suniv_codec_card_routes);
+	card->fully_routed	= true;
+
+	ret = snd_soc_of_parse_audio_routing(card, "allwinner,audio-routing");
+	if (ret)
+		dev_warn(dev, "failed to parse audio-routing: %d\n", ret);
+
+	return card;
+};
+
 static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1753,6 +2082,13 @@ static const struct regmap_config sun50i_h616_codec_regmap_config = {
 	.cache_type	= REGCACHE_NONE,
 };
 
+static const struct regmap_config suniv_codec_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUNIV_CODEC_ADC_DBG,
+};
+
 struct sun4i_codec_quirks {
 	const struct regmap_config *regmap_config;
 	const struct snd_soc_component_driver *codec;
@@ -1855,6 +2191,18 @@ static const struct sun4i_codec_quirks sun50i_h616_codec_quirks = {
 	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
+static const struct sun4i_codec_quirks suniv_f1c100s_codec_quirks = {
+	.regmap_config	= &suniv_codec_regmap_config,
+	.codec		= &suniv_codec_codec,
+	.create_card	= suniv_codec_create_card,
+	.reg_adc_fifoc	= REG_FIELD(SUNIV_CODEC_ADC_FIFOC, 0, 31),
+	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
+	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
+	.reg_adc_rxdata	= SUNIV_CODEC_ADC_RXDATA,
+	.has_reset	= true,
+	.dma_max_burst	= SUNIV_DMA_MAX_BURST,
+};
+
 static const struct of_device_id sun4i_codec_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-codec",
@@ -1884,6 +2232,10 @@ static const struct of_device_id sun4i_codec_of_match[] = {
 		.compatible = "allwinner,sun50i-h616-codec",
 		.data = &sun50i_h616_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,suniv-f1c100s-codec",
+		.data = &suniv_f1c100s_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
@@ -2073,4 +2425,5 @@ MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
 MODULE_AUTHOR("Ryan Walklin <ryan@testtoast.com");
+MODULE_AUTHOR("Mesih Kilinc <mesikilinc@gmail.com>");
 MODULE_LICENSE("GPL");
-- 
2.34.1




Return-Path: <linux-kernel+bounces-545635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2BA4EF73
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A88A172EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095127935B;
	Tue,  4 Mar 2025 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="frOd5W/H"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAA27934B;
	Tue,  4 Mar 2025 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124173; cv=none; b=A1je3Cm/h+d0bVGkOPvKjBeb2oTElyv85lN9BHAgkhkdH4ArjL5XLMn8vDaVRmEJ8VzbSfDM8eaDUKhHhFzyYNuvIU65wB5iDhdTi7LUu9vI6+tVfWNesXeV6PA0T5MZDRBhXN8E/Qj+vd9LqgHbTBV4gbEuLzOrPxO58h0sBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124173; c=relaxed/simple;
	bh=lfPOp8T4qiEf7llUQzd9pn2jZRzzyBoqvXgBW6abtNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tOI/ZyZvzvcy73KO1BlOFCdXLupGVtCwgkzNMrHf/Ep5492x8cGPBm3CI8wIG78V6Ax5o9YHrStGtuyOW26gUDDM9QY3rTnC5trqOf8+Ls27uxi0+UC7LaRXR9guKs4JZfVgOFBIGxeoutE+fDVYqF/sGlra1d3IVlvjYidBCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=frOd5W/H; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741124169;
	bh=lfPOp8T4qiEf7llUQzd9pn2jZRzzyBoqvXgBW6abtNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=frOd5W/HW4h8YdTloOEWiu6R8JWebj5JId0BfN6oZeGwVVGSpiyErflTPYPLAd02v
	 WtWkSh726xvr1X2BEWH2kJzUQbi+uyPcsUZV91kndbiu9ImiNE2WuvODnZLLX4cxss
	 IImWYtML/CW8yKLOum+OEXD/DXXBGxKLhLx/BfPBanzcIxIMEfpMJWGN9y2EY3Ej+k
	 Nc4XVrf4Iojuzhj0jSFsAtqxyL7xTytv4mWMxXLXVp6suav/KIrJORU3KwLvmFdGTE
	 /XXCPUcW6KpnpByk2zJoavFr918BomP3ACwuNltI3u1eiYBtnWqvE+j9JMVj46unda
	 J88pAtw1+VVzw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0110A17E0B56;
	Tue,  4 Mar 2025 22:36:05 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 18:35:38 -0300
Subject: [PATCH v2 3/3] ASoC: mediatek: mt8188-mt6359: Add accdet headset
 jack detect support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt8188-accdet-v2-3-27f496c4aede@collabora.com>
References: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
In-Reply-To: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Zoran Zhan <zoran.zhan@mediatek.com>
X-Mailer: b4 0.14.2

Enable headset jack detection for MT8188 platforms that use the MT6359
ACCDET block for it, indicated by the mediatek,accdet property in DT.
For those platforms, register a jack and initialize the ACCDET block to
report jack events through it.

Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/Kconfig                |  1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 43 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 3033e2d3fe16840631a465dd967da77f7a6ff43c..64155ea7965a1cc50593fef442ce90761836f328 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -237,6 +237,7 @@ config SND_SOC_MT8188_MT6359
 	select SND_SOC_NAU8825
 	select SND_SOC_RT5682S
 	select SND_SOC_ES8326
+	select SND_SOC_MT6359_ACCDET
 	help
 	  This adds support for ASoC machine driver for MediaTek MT8188
 	  boards with the MT6359 and other I2S audio codecs.
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 420b1427b71dc1424a52f7ab6140c14659036733..20dc9470ba76b2a750e79a5ae3dafabd7c597f40 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -17,6 +17,7 @@
 #include "mt8188-afe-common.h"
 #include "../../codecs/nau8825.h"
 #include "../../codecs/mt6359.h"
+#include "../../codecs/mt6359-accdet.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
 #include "../common/mtk-soundcard-driver.h"
@@ -271,6 +272,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
 	},
 };
 
+static struct snd_soc_jack_pin mt8188_headset_jack_pins[] = {
+	{
+		.pin    = "Headphone",
+		.mask   = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin    = "Headset Mic",
+		.mask   = SND_JACK_MICROPHONE,
+	},
+};
+
 static const struct snd_kcontrol_new mt8188_dumb_spk_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
@@ -506,6 +518,35 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int mt8188_mt6359_accdet_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HEADSET];
+	int ret;
+
+	if (!soc_card_data->accdet)
+		return 0;
+
+	ret = snd_soc_card_jack_new_pins(rtd->card, "Headset Jack",
+				   SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				   SND_JACK_BTN_1 | SND_JACK_BTN_2 |
+				   SND_JACK_BTN_3,
+				   jack, mt8188_headset_jack_pins,
+				   ARRAY_SIZE(mt8188_headset_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack create failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = mt6359_accdet_enable_jack_detect(soc_card_data->accdet, jack);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack enable failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *cmpnt_codec =
@@ -518,6 +559,8 @@ static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
 	/* mtkaif calibration */
 	mt8188_mt6359_mtkaif_calibration(rtd);
 
+	mt8188_mt6359_accdet_init(rtd);
+
 	return 0;
 }
 

-- 
2.48.1



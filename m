Return-Path: <linux-kernel+bounces-515172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A5A36140
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7862118902AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940BC2673B1;
	Fri, 14 Feb 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qX9YEGD0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B138266B72;
	Fri, 14 Feb 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546118; cv=none; b=AWoqccOjj2lQn90KQykEm4srBm392dM7RYt1xUvntZ7AQVrnFyTsAGUZsT/ZNog9iSsne/jCqgJ+/eF8Jl9qpWQIdgtd9HCpS7uQ5thyTrcwi3a0bDQvMJbXJ6sdjt42iuppN9vWByxqF84n6BEfvTGje6WvprYWT7fxOJ7KrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546118; c=relaxed/simple;
	bh=gYGJtiW6FSC0FDX8qS6/krawDyDf5GHTiTmU7WJ3Af8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wvxnmyk5WR29PIqE+jw5F17hTbTVcOkXWsaptrufF0gMMbM1/YX9HOIKVq3OcqL97kBO8oG9Q3HGFB8wvCSa73MfnR4Jp0Z5waOS4uAboixzleKiw6f53LI/vrqaP/L8aTMKLIMjh3clZnTrggAK5hFIlVBvZCgyZ3yJoqMHsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qX9YEGD0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739546114;
	bh=gYGJtiW6FSC0FDX8qS6/krawDyDf5GHTiTmU7WJ3Af8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qX9YEGD0ml2gWVx35Ac2J306oISYovWOng1iOF0x/+LFzhhDxHVflwNrxOtJqod5W
	 RMCqYmSg5FwP/N363m6hjsMHKn3yMO0lL7RyVtYm2YZOSt/GQ8gUziuvbgZuGg5Erm
	 NrwHX6N1bHi5+qJ0uRK/6Y2CS/T6KY3Fj07xaoPI3TRG7kjNS2XXcnZNaMEMGOuXW8
	 /i4iSWsrDhPuH4dpv/X209rsVzmN2v6OUNJ3NT3fvN0JgtJ8LH0iFT+YcVmNppcc9n
	 eIPZ0uhmSIuF8gDqD9Ixnmz9afwDvzM3Y8T4s85qqnziGgpntg+QIqxLzJJmiknQ9t
	 NV5YO83cvkgtw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36BB717E1558;
	Fri, 14 Feb 2025 16:15:10 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 12:14:31 -0300
Subject: [PATCH 3/3] ASoC: mediatek: mt8188-mt6359: Add headset jack detect
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt8188-accdet-v1-3-6bbd5483855b@collabora.com>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
In-Reply-To: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
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

Enable headset jack detection for MT8188 platforms using the MT6359
ACCDET block for it.

Co-developed-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Zoran Zhan <zoran.zhan@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 2d0d04e0232da07ba43a030b14853322427d55e7..4e19e6cfad1e1f42863b2e2f27131f880c5883bf 100644
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
@@ -266,6 +267,17 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
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
@@ -500,6 +512,35 @@ static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
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
@@ -512,6 +553,8 @@ static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
 	/* mtkaif calibration */
 	mt8188_mt6359_mtkaif_calibration(rtd);
 
+	mt8188_mt6359_accdet_init(rtd);
+
 	return 0;
 }
 

-- 
2.48.1



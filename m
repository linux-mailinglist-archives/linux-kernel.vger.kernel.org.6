Return-Path: <linux-kernel+bounces-221126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784D90EF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D11B1C218D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7613DB90;
	Wed, 19 Jun 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMrFammY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643B14F11D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804533; cv=none; b=Y6y14MeDezx2/35ZKNP/M7vV1Yo+myzxOlfxYDbdmUgsO0IRlv614xAxtNsXUkOmYPOi6fE7FxOrEIwB8jr77rDAfC2KFxQcZEn7toSkaU/vwcShqSFpjHenP6yanhzaiwnWDCydDbrc7jfC1i2FjtaxSUuQwULyoIs+/v5xQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804533; c=relaxed/simple;
	bh=1VPOAv9zIMTroZQ93L+boCVkV3gJxtdAxqRuReJhhc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHnvyUGxF6kcZSB7ivZh1FSKOZghND+s4L1uyjojIbRopPB8uqqTapUr3UpE2Qo6uf78uaZg5Re9jqZbxVmwlYaOvJayhccDMW59h6y4pDQf89EmLe0JQkfK0B3tuqlj+Ns5SmpVycDZ2VTsndb23bGXIX0E5B4IhvSIOBjQ01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMrFammY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso60387785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718804529; x=1719409329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiIR6yuP6t7uT4C98Yo9Rnz9eEA9tvoFuOc6X7r5ikc=;
        b=qMrFammYCLZKETbqFJs1xyrMeHOoW8Mxfj66Lc18hbIOqBhGwnHl7ScHfwFx+Qt3x5
         7bjQc3e2Puh+fPdS9rum5gPmp32JvT4obMQccvIJJlA3m8pRKZo2HErocako1+6WcYJv
         EuvoxULEBOp0WIZXYNSoJKCewWITX8ACnchW/8G05Q2huzfEqdS7GqvsntfN/sEFgT88
         4OR7JCC2F+KFOdaUnM9z6yO892owlL+vLMVUR9t49GmbgStbZ0rI9ifVftMUOUdIao57
         4jmDMp+zWJV/qhFs5zF057TasQEc7Th48sWb7ayTtk+8pBUnL7HO8BwvgOs+Q7FbN/Ul
         gEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718804529; x=1719409329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiIR6yuP6t7uT4C98Yo9Rnz9eEA9tvoFuOc6X7r5ikc=;
        b=vUtu/sEJmJr7oLBbjuy/3jKW/fcV60IXiUUxExSi6IKVnN6leHIMHE+52fh6aubnWd
         eWOoZucqaLiEuFq/d3imZo3U8CIZOPigk5P8O47oXvsNb+4NLdPuYK5gkoiLrAlf6UII
         rFbk/tgrZFDz/MMHqk5USDnyCx/goWyYg7nyinzLa36sCSnpv0crGAZYqibY45eAnFsi
         sPmvtUg2b5HRnZVJsv7TT8CduabhZmXM3qcjG/Qhs6RBJ28EbB11nb6DvunTzm7U8xCw
         clckJhI0mTZxbWRRnsN7CN5l/B7AVwUuKCTU/qVwzMjbWbo7XcbhvFdlqOEZ+DhiuXyW
         fMIA==
X-Forwarded-Encrypted: i=1; AJvYcCWcWINPztvBZJ0NCET/uSE6+Z7ckx7H/s2jtZMGxR/+FYclBE4EURQBnUCZRkKOUcGnJG0rEDF1T12PjS1lw5LVpP6qSml6ghglvgf4
X-Gm-Message-State: AOJu0YzMfZQUSfdZ9TRWUBTRoycn42kVwRZRgFHYjuVldTK9WBCPxHRz
	5QuiN8hApgo++wwXn8ZEQrYkVdr6inLL1YhHUUK0xogl6D7EBclhwgkmoaATU38=
X-Google-Smtp-Source: AGHT+IEL2E7zktc8nOKJ1ufdgUxYq1LYBMRCdRJ9bS094cQBVvW4nNn3JAwSh7Ya50DMm7FCHGvi4g==
X-Received: by 2002:a05:600c:3b12:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42475296a6emr20195615e9.25.1718804529047;
        Wed, 19 Jun 2024 06:42:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229c60f758sm251639505e9.20.2024.06.19.06.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 06:42:08 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 19 Jun 2024 14:42:01 +0100
Subject: [PATCH v2 2/2] ASoC: codecs:lpass-wsa-macro: Fix logic of enabling
 vi channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-lpass-wsa-vi-v2-2-7aff3f97a490@linaro.org>
References: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
In-Reply-To: <20240619-lpass-wsa-vi-v2-0-7aff3f97a490@linaro.org>
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Manikantan R <quic_manrav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5620;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=1VPOAv9zIMTroZQ93L+boCVkV3gJxtdAxqRuReJhhc8=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmcuArtwkiZyer7O533GpVjO78RzqhHI+cZ4KyM
 O4X8fGEpcWJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZnLgKwAKCRB6of1ZxzRV
 N+0RB/9+gYZdbGdZ/b70cgrn8pao6ixGcNfohMLGf+YPXIRJ7OJe6zJ4bDbEq/obMmyyviDLYJh
 AVpasiryGepcIEYZpSthUBBCiMrPERkwfXKQ6yJaGgWcM+u6GHSCgRfzrEo/bi02gTCAZ9Q38Yy
 g50u29dJFNtBiyiBSQ8aSpqMBySkqK/3i9uV54xKXBSmi7fQbqOZMKXNojFxuAmIOMJicZJivSW
 lHeOrCAa7q3AWS8WsGg1xDYs1WbZpkxIiWMDz4qcydSTkvWTm93VI8WHL98hR4gEfOkDDcst8jm
 om6ZSE7QL1LARqYchT0Yyv7AyWw97er8zJ/yh/2sz3/Xw/Q7
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Existing code only configures one of WSA_MACRO_TX0 or WSA_MACRO_TX1
paths eventhough we enable both of them. Fix this bug by adding proper
checks and rearranging some of the common code to able to allow setting
both TX0 and TX1 paths

Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
Co-developed-by: Manikantan R <quic_manrav@quicinc.com>
Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 112 ++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index ec9f0b5d6778..e02c4f6f6061 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1163,46 +1163,11 @@ static int wsa_macro_mclk_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
-					struct snd_kcontrol *kcontrol,
-					int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
-	u32 tx_reg0, tx_reg1;
-	u32 rate_val;
 
-	switch (wsa->pcm_rate_vi) {
-	case 8000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
-		break;
-	case 16000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
-		break;
-	case 24000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
-		break;
-	case 32000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
-		break;
-	case 48000:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
-		break;
-	default:
-		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
-		break;
-	}
-
-	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
-	} else if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
-		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
-		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+static void wsa_macro_enable_disable_vi_sense(struct snd_soc_component *component, bool enable,
+						u32 tx_reg0, u32 tx_reg1, u32 val)
+{
+	if (enable) {
 		/* Enable V&I sensing */
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
@@ -1212,10 +1177,10 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      rate_val);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_PCM_RATE_MASK,
-					      rate_val);
+					      val);
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_ENABLE);
@@ -1228,9 +1193,7 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_NO_RESET);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		/* Disable V&I sensing */
+	} else {
 		snd_soc_component_update_bits(component, tx_reg0,
 					      CDC_WSA_TX_SPKR_PROT_RESET_MASK,
 					      CDC_WSA_TX_SPKR_PROT_RESET);
@@ -1243,6 +1206,67 @@ static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(component, tx_reg1,
 					      CDC_WSA_TX_SPKR_PROT_CLK_EN_MASK,
 					      CDC_WSA_TX_SPKR_PROT_CLK_DISABLE);
+	}
+}
+
+static void wsa_macro_enable_disable_vi_feedback(struct snd_soc_component *component,
+						 bool enable, u32 rate)
+{
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+	u32 tx_reg0, tx_reg1;
+
+	if (test_bit(WSA_MACRO_TX0, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+		tx_reg0 = CDC_WSA_TX0_SPKR_PROT_PATH_CTL;
+		tx_reg1 = CDC_WSA_TX1_SPKR_PROT_PATH_CTL;
+		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
+	}
+
+	if (test_bit(WSA_MACRO_TX1, &wsa->active_ch_mask[WSA_MACRO_AIF_VI])) {
+		tx_reg0 = CDC_WSA_TX2_SPKR_PROT_PATH_CTL;
+		tx_reg1 = CDC_WSA_TX3_SPKR_PROT_PATH_CTL;
+		wsa_macro_enable_disable_vi_sense(component, enable, tx_reg0, tx_reg1, rate);
+
+	}
+
+}
+
+static int wsa_macro_enable_vi_feedback(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol,
+					int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
+	u32 rate_val;
+
+	switch (wsa->pcm_rate_vi) {
+	case 8000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	case 16000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_16K;
+		break;
+	case 24000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_24K;
+		break;
+	case 32000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_32K;
+		break;
+	case 48000:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_48K;
+		break;
+	default:
+		rate_val = CDC_WSA_TX_SPKR_PROT_PCM_RATE_8K;
+		break;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Enable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, true, rate_val);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable V&I sensing */
+		wsa_macro_enable_disable_vi_feedback(component, false, rate_val);
 		break;
 	}
 

-- 
2.25.1



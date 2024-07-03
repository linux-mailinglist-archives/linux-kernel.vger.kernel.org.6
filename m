Return-Path: <linux-kernel+bounces-239441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985292605A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70FCB30E56
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D0817D892;
	Wed,  3 Jul 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rH6AgwOR"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2517C207
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008688; cv=none; b=L+LuuZP4bRWGk2oIGx3k4PsMBAo8oL2eUY/tb9javzXjVN78cONwlygQsD+uSDgxCFkYHqxIKjQh9WMolLvCd05/NYIkRJhjHcGyu4Kd88Xft4AedfKYqWb0W0TI3UagsHb7JtmYIpWZUYrNQsyCtJFGYvBLr4waeXVfyplO/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008688; c=relaxed/simple;
	bh=ocz/1r0t2NeXjhVsBlqlh8PIa6EhEItAnc8FRU38Kqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nf+dfKVlF8lVu3cHnKg5nslFdGx5MFTstUW0jGw5E9wD0+5IucBW+BFr3Ge6dSAKgnyszMgPISqdZzb85cbyqofLuNXMNMn0tDFw0FE40a9HT7S4laSqpjUKr7nHgktc2czhwx4XFGXzivRZvTuApp9vqV0y94NGaH7q0x28siI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rH6AgwOR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52caebc6137so4863254e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008685; x=1720613485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dztGUki9Ak6jIf4+9h9y7V5UCrSXr1J8tuwOdQ2U8CA=;
        b=rH6AgwORQ8vFCIqqAFZBjFXWRzAzgRCGfyqrqho6o6gwsFUo548aFqS5dMnziwXZW0
         HcYIkezGd0WwySxKf20jcAUAZIvMHmScyZjwA8Q6SGH6PVznZWs90KEh7Bbx+/XO6E6i
         WXf6BtNL90Wikdf8hCOJOVs14eI7HBvAYkQZ+DSnCl0H3yjsvTNlGZzeyDl/+s7oD1C3
         4uGDwLUbqrKVqMX5fkDllEDpRXaaPFarsORlLyG1Mo3nUwhxrHN+NbhNpHRcpuD/oK/m
         umjM815zsqhnht1q3EwuqwQpcbwbDoC7BwNMDP1rDP/oVLpLjt+jm6ifPVXtc1WW+ZXo
         FLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008685; x=1720613485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dztGUki9Ak6jIf4+9h9y7V5UCrSXr1J8tuwOdQ2U8CA=;
        b=ZMZHMYFRue6o6KeHBZqFc5WvYMkICxfOI3bM6KsvzWKR8qGhx2Bx5rRdr958ZoEj/c
         It8MZZKy1tzsh1fOxDWj73dCZK7FTLCtRwRgpu8DAW3SeUvAT+Z6BOrmquFK5R7Cms95
         i9tr9I6gsnL1PolRsQi5UAXaexo+nUnqMgbfS+ulCRY14Gxn+uNKQwQlDEadCnZdgUU1
         gjZ0QSGerh287eyKq9jyG31fF3I45MOuTZd+3u/NMNMPZfgTsl4je0kL2w+xW5rnaeyf
         nHWAsIJ+PxlTmU2DkrYUkQzKeBojXGDvCsToagi1icFx8//Qx9R8Y48Eobob5mWuZM1F
         wF5A==
X-Forwarded-Encrypted: i=1; AJvYcCWxDYtb5S37i0SurCjmPEoXshYkztT3eNDTHVzWq0F6E9ZooH764UR0l8ZbvDaK/PXaOLAjZM7I6oxLLbEFUdk+UspMK8LfbJYnonAm
X-Gm-Message-State: AOJu0YxabLRovqpoWVI9cmw4tH42OWCAwA9cg4ojF+xWphrnD9WES21y
	wCWgrtFiMKNJGGOK/bNVI33Hd7/kLHVXz8X3fkpGGOM10uEGFu9DpHzIcZIc+U4=
X-Google-Smtp-Source: AGHT+IGNlkQo2U/mD/9Q0gW4rGoUl/Mk1IXpMr281TpcdB+aTLXI1fJpFBZHFvhjmGczWXJCD0A4og==
X-Received: by 2002:a05:6512:3a83:b0:52c:dcea:86e2 with SMTP id 2adb3069b0e04-52e82646dd4mr9034143e87.1.1720008684737;
        Wed, 03 Jul 2024 05:11:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:11:05 +0200
Subject: [PATCH 11/11] ASoC: dapm: Simplify
 snd_soc_dai_link_event_pre_pmu() with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-11-71219dfd0aef@linaro.org>
References: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
In-Reply-To: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ocz/1r0t2NeXjhVsBlqlh8PIa6EhEItAnc8FRU38Kqk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/bjwP82Ll7/Nq3E6/J1YP7S7FSG2p3Rdr/N
 yTrQYiInu+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/2wAKCRDBN2bmhouD
 1zcRD/94Lda9sMm0G7QiNx3/BCP8Knn4BEHAJ/1nV+02XXqBJHOiIM3wg/uwJtiTzlQntM24Zat
 3teyDWqFA5YYeSe/86lkREkefYyFQ6nWFGq9QH4Q32fVGpdhJb2gwSRGtvwO4zoLGQIBwsOa83U
 xJy5HJyg4qpx2OHbyncoymS4fSR2mtmnymx9SHl95mAExMKX2g4M55KsGv6fYXnHoZ9EcY+KJVd
 OG1OKvBm8oBBmlpa+gReQhOEqfYNtGZey3+gwHPah/Nsn4sojeFzQ0rRgwejELXxNPiHICokR87
 gSiA0O6A8jGF6Vy8AdzcFbJEFyxOOXIHMnVXT2x4TaDEGdG9VZzEP9ZPnPg9dAsLjQEbwnGBKxk
 6VdqN3VG25DGsYpM5Rmj6G4CSJ10qj1wkgeC41xYHTuPKr+2IpEbU03h7Q4+B4aR88dL+VYmFC0
 zRFI0B4nNnyDI+Ea4V5itvg1aIb5HVy4IQbRHTeKQ/iLMrwanzWCn1yZsRBLGPswwxqUdBHX3cK
 xBIceH3GYOF/+WCN62NKbu5J/JxkH2Bn19S22rIajO2ZZAbBjFMeqhRRUon0YI3GqXO0CreBtwl
 th5pGtju3/Yx8jL8jEVmDKS++OBMCrMPOtjZeo9ypw2ddzgy9EKDqolk6u3XB3b3LScGGh9xZDV
 4125OyJ7qHqKw0w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h in
snd_soc_dai_link_event_pre_pmu() to reduce error handling (less error
paths) and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/soc-dapm.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 236aa3c8eea1..fa6f19d26c78 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3882,11 +3882,10 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_pcm_hw_params *params = NULL;
 	const struct snd_soc_pcm_stream *config = NULL;
 	struct snd_pcm_runtime *runtime = NULL;
 	unsigned int fmt;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * NOTE
@@ -3897,15 +3896,14 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	 * stuff that increases stack usage.
 	 * So, we use kzalloc()/kfree() for params in this function.
 	 */
-	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	struct snd_pcm_hw_params *params __free(kfree) = kzalloc(sizeof(*params),
+								 GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
 
 	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
-	if (!runtime) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!runtime)
+		return -ENOMEM;
 
 	substream->runtime = runtime;
 
@@ -3915,7 +3913,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 
 		ret = snd_soc_dai_startup(source, substream);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		snd_soc_dai_activate(source, substream->stream);
 	}
@@ -3926,7 +3924,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 
 		ret = snd_soc_dai_startup(sink, substream);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		snd_soc_dai_activate(sink, substream->stream);
 	}
@@ -3941,16 +3939,14 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	config = rtd->dai_link->c2c_params + rtd->c2c_params_select;
 	if (!config) {
 		dev_err(w->dapm->dev, "ASoC: link config missing\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Be a little careful as we don't want to overflow the mask array */
 	if (!config->formats) {
 		dev_warn(w->dapm->dev, "ASoC: Invalid format was specified\n");
 
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	fmt = ffs(config->formats) - 1;
@@ -3971,7 +3967,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 
 		ret = snd_soc_dai_hw_params(source, substream, params);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		dapm_update_dai_unlocked(substream, params, source);
 	}
@@ -3982,7 +3978,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 
 		ret = snd_soc_dai_hw_params(sink, substream, params);
 		if (ret < 0)
-			goto out;
+			return ret;
 
 		dapm_update_dai_unlocked(substream, params, sink);
 	}
@@ -3992,11 +3988,7 @@ snd_soc_dai_link_event_pre_pmu(struct snd_soc_dapm_widget *w,
 	runtime->channels = params_channels(params);
 	runtime->rate = params_rate(params);
 
-out:
-	/* see above NOTE */
-	kfree(params);
-
-	return ret;
+	return 0;
 }
 
 static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,

-- 
2.43.0



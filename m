Return-Path: <linux-kernel+bounces-233738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5424D91BC67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868DD1C227DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF7156886;
	Fri, 28 Jun 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2LC3AeK"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE2155335
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569498; cv=none; b=Tt8eVN5KW4kWrEgZ0EUT2+2xiv6qq6voJ6Qck0gluk3L0MXOgzL27VRtAFS32oqdheVYh9CddD2Ulhp4FkmNgWYTYp3vPw4tdL53n0eB4HkR1lDnL2CH+fKGAZw8rU1Am6qd/gSWV1b/PJ8npokxqAYwUiCIRNgTtgTrgzI4kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569498; c=relaxed/simple;
	bh=Ad+uKCGSDe8rakMGGeF23SfGPaAfcaquc5R5IIxLKwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5Zp1IXmQd9NfBz8zrM/0tPcwAqR83wCV4NyhyMFOlnIy/Afv5gjBO6YUSxjdmYns/TzsFrJ/HiOKyGamtpJeaBFO9DfDYiC1dlFhLa7d8IdAdlZoZDqsv+7eJZFH/mLFcNJMzFkfQPBXFgCwW0UldLxKTbI1Lz4RSfvA4aYkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i2LC3AeK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42138eadf64so3921815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719569495; x=1720174295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PicI/VwwrTj8z258jc72WwlXuJ32jmr5AxPeFVRGEyg=;
        b=i2LC3AeKsVPKlQIFUDECy2LQURfmavUlU7ztnUfuhrK5b3peO0Y1gY7/MAHxWy9ws2
         gQ/kYC4qKzxpM8OZVeIPQLyLMe1ynxAB2YYbgKO+WifOBV+SvNZ5lgnG/j25uY0eGy8R
         9NFfStO1PbYa6AE0CUbcbAxfqUbwdCmwCtWUqC0CxwBueDqFB3RyVgBfT2Yb5E89po/Q
         DDX7vkupGdVx9SyzL/ogR7roamddtRRHNPjr/ZxgXUnypefX8Z+AFCIScrDBgPavP+wU
         0XB4H7BUvwM4KaFeU1krUWqsxv0GQKC2YFoDoe32n4dF4Uz/ddHLrY+ck4cO0CdGW/lE
         1wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569495; x=1720174295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PicI/VwwrTj8z258jc72WwlXuJ32jmr5AxPeFVRGEyg=;
        b=ibHcVUwdr45OVG8RGkBv70pWGLKkXuuZpu2HpTszmROKEwlcjGNgN/og27+bbJLLZl
         xg4oc83LNTuxcQrWU86p3ZRLkQwrPnhCaQiokmb3xeiNeNlf6UfixEZRGnn8nqxhFh47
         Dv3UR+caAlHthfUVRZ2qfVTHxhV22p2aZhiGkRp/4pwsrlsfkl9a1AzZw5LPSQBySElm
         iBN4wslgYw1Uoh7UTvvO9QPElQHnyz5zvhimnf0X6y7MV3xTlW/mQVDyyZsHWbtK8U2U
         KzzPOuwQ6UmCjq2pGsQV5r0qQssbgspRgHyEj7QlFtSSInErv+/juI9kMs3pMjMUeZsR
         4O8A==
X-Forwarded-Encrypted: i=1; AJvYcCUUwNLYTSNYMHUKGXrlXHaiPFtsoflF2WB6jkV6Vo70o+KDTm8AOAZba3vkrzGixqlGKrz6y7Sokm+jEFQi5Ciuf69p66Y2yJr8xl2q
X-Gm-Message-State: AOJu0Yy6ma724AE5QpJhTqME7MBWkJsAjdCedbP5hUfk9ve2yG06gBcq
	YIVesphbqyCRwPI2RREym4bUnAbn0K5CTnzWg6gozozKFKWgfQry6uXMaDQnHA3HLvANO9Tj3eL
	M
X-Google-Smtp-Source: AGHT+IF+pgGQZfU5lPr4i1g9vWtUS2+TH+xCGlGbz2/0V8EIqgNIpPGUYP3hYpebbJgktsPW2jhF5Q==
X-Received: by 2002:a05:600c:4f09:b0:425:680b:a6a8 with SMTP id 5b1f17b1804b1-425680ba7camr30266455e9.15.1719569495149;
        Fri, 28 Jun 2024 03:11:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm27024605e9.47.2024.06.28.03.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:11:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 28 Jun 2024 12:10:57 +0200
Subject: [PATCH v2 3/5] ASoC: dapm: Use unsigned for number of widgets in
 snd_soc_dapm_new_controls()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-3-e9741143e485@linaro.org>
References: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
In-Reply-To: <20240628-b4-qcom-audio-lpass-codec-cleanups-v2-0-e9741143e485@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ad+uKCGSDe8rakMGGeF23SfGPaAfcaquc5R5IIxLKwU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfow/CHxJHKXSrU35rkMdrR/G9PK+UceqkN2/f
 TIzT+/6MeyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn6MPwAKCRDBN2bmhouD
 1+KNEACA0txoe8z7xQCp/1czBOAR3nyYD2oUsKtrvoP8vdBhLubYOsiEFloCmFR/ZLXhAUeBpSZ
 Ij3B8o+u+G1bfFTjd0Byp3WN0BPFQCisLH49FSEGr1fBcMNgMJSF25LqOCQwPzBXjG9CDfEmqRU
 bhu6w6HssqzUJOT+ajHvj6zxaAuHvxBeML73axj07tSLsMrs35Ci8hmvs3+F4rqTpV9ByxALm3O
 ci30+PYDQPCCzi+DdYh57C96mDXD3znkqoefIBLTkMy+ALLXZcYN49ZPUxVOh5WBGh1h1uTwrcR
 26MLyFv+4DMlHOCPw0LU4jR9uiEt6YdefoNDSz899AYAN8DPjTzS2lXTl7obdAuc6W+gVg1+TaN
 c+syZ9sPsBTfKI/vQx4aUz3UIe3LTuMwNaNePuPRo56a+/SeuSSMH09UYPQpu6S44mQBIWC+MBs
 6uf8jtC0pkustFnarOJazUm4YZzE2gL0egzCOO6hwcmmcWu+jtHvo0F24nwQ3dthFXaCPTpuT6L
 BZo8SvhUoyLqeoH32Asa57EbAIfGUSDxBtAGRXtplJOKyac/OzY0CLvhnatbSt1dVk25sf0ohxO
 2HrYjJ6ic4Qv9TQrr0iQiESClW1cW9bIGQWUc4/duxR7wZVwweMeWwOX/yPRxretk+Y4oSj96bH
 KK+Fxrl+6oGyE3g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Number of widgets in array passed to snd_soc_dapm_new_controls() cannot
be negative, so make it explicit by using 'unsigned int', just like
snd_soc_add_component_controls() is doing.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-dapm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 667ecd4daa68..12cd7b5a2202 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -457,7 +457,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *uncontrol);
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget, int num);
+	const struct snd_soc_dapm_widget *widget, unsigned int num);
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		const struct snd_soc_dapm_widget *widget);
 struct snd_soc_dapm_widget *snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 16dad4a45443..32cc90d09bc2 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3857,7 +3857,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
  */
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
-	int num)
+	unsigned int num)
 {
 	int i;
 	int ret = 0;

-- 
2.43.0



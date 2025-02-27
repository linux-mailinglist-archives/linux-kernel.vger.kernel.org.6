Return-Path: <linux-kernel+bounces-536248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD8A47D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41297A9588
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF922DFAE;
	Thu, 27 Feb 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZtDuAlC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C162376E1;
	Thu, 27 Feb 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658259; cv=none; b=XkfHd4Q3PDOwXi6MlhQLNwPhklNYsB6sS9bsGXpuudUsZOrNC6c//pe+b4zqV9tEunsShME9B0EYbx7hgn4vKkkl6+a44uhxfYxPbs+fEEQ1YjZ8CUf8bSYapmPD67VGaJ8ydWfFyqYd8cgY0emq2HfhAiUNhmVOLfaIUH7FTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658259; c=relaxed/simple;
	bh=3lO7ERCwM2D7uu+YtrYmtRReUBaTmMpcEzl+3rC+jio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pww5wwBtW9QOAr1RKoBrMl5mpejdxeyApE4zMPNksrhwwW5c/wtHrUdKAqZr7Qrt6hSQYttB74jrj9D2Ydhwewv1zjNG4TyKSypGS4DIM2VLfMBbFBuvE2xx/gCemuEqekE2Y9hmMmdagSkzMphAi24Wxhl1m0TjR3gdhdPySw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZtDuAlC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221206dbd7eso14592515ad.2;
        Thu, 27 Feb 2025 04:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658257; x=1741263057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJTm6Cfm1kOySDY4DzJRdMnhEPIVa8nplOZzWQzwX04=;
        b=AZtDuAlChtrgaFM1dekz5OgPiLtod96KIM5FMJ6cFGKWuAg5DVxkgLQ+B8sWmDfnia
         FFhLnhkeM5yLdWaD55ocXYanGb1d3c6LHlcMiDrA1ZNOgLs2S6+bvIGMISWIvWmlEY8e
         EF/2WlUY58aSZezGqhYhIuP8k5zHcQjPrsLqPqm0WUubeWMCCmOrXN+qNQtzpUC6U2Td
         U/+1Da5RLEs8GKBPuKuuWIu2eq/w1//4I8asDKLjtu6ZdAZGd3y7i1dOdD+dRrZzIYxL
         G7c94zzJmsFXG6gJdZ6vNTDS9BIwc9beHsJNv7ZD/WO17+vnoG5vQGka9FbpYIE0vkFX
         gSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658257; x=1741263057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJTm6Cfm1kOySDY4DzJRdMnhEPIVa8nplOZzWQzwX04=;
        b=foHS4IT7FJ/f0u86RYpKdsAyznvKbtHRU3BUW4ZbobkTGiZNLU5SvUoOO3KwTyBMHO
         3vUXc5PzP2Ma7pW7ESoWLlIj54JTiFu9OGxR+Xf2in4LB9W0tA2tgfVzvORqNPvr2RHz
         VKuQPqjWUhKX/yeEz6AyYya0kplekCXrbhBQmNkgCH0Eju1bIVr7+xAEILuHg3Nq5cAQ
         /fZiMcipJqClyD5WRUrlDYAFAYI+w2ZojvDPeyyDf2Bofkiy6P82OWF5yeYFsARcAqkE
         owgNynM+KG1K4FBfiT5JJGihUtmKFHTbWS11BdNWCKA8AmFcDxI5zNGd77OU+gWtts3X
         WYAw==
X-Forwarded-Encrypted: i=1; AJvYcCULjCQhgEscnl2KsIZmLamDkHLM3pveP0q9qPDf1Jmz1DeRZVmKlYmIIIfXwhPpLXTExLHHJHaWasuk@vger.kernel.org, AJvYcCUnYySXKO0zCCQtgny+xywJ9DqoDiGe04ZF+9iohd/ua1HrRXx5dyZNoBytcfKmDbf0ZmYdLz7dBGIakDc=@vger.kernel.org, AJvYcCVLaukmiNi1zZwwe5W5gbeA28D0pbssZt45SwbuoyYNIHydvob4J80QMTWKj1rtA79FF7KSUqswoQK+rZeQ@vger.kernel.org, AJvYcCX3BxQGyW2Ao6T05U+DPEY3mememOQVeqryfrS6mPT5U4qgC8jtiPU87sJitTYJp2dN3pXey1A6krxdSI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXwFfgpbwf4EfK3C6pgxor99gGCKh53P8sVE2CkIMvTR0PRiy
	d3Eun1bq3n8kMQgKKR+aZKamxSP3CbeIsoyUvxuH46V1FuAfN3hP
X-Gm-Gg: ASbGncvlWx8YodrrROQgen265qy0DRl5Xal1hv8/Kvq3vA9wsL8TgXKCmO/i3nARb4X
	xq0WmMjtVvTE9Utanqoi5/dg2vWk7BXiAHD1PE877iYmee1VNzLwoerUI5Q+xe2vgwc5+kLYBk+
	Ts9LBk4jfHbiO4RyZPRTL2AFF04Hv+szSMH0WZOWJ5x96ZfsFjk8gLF3kRis+KtHXWq+LWoicJz
	naI0PBRm6VmfwpapJ6Bicc+Ktqp3HIJ0te5iRKzzOaCtkY+KSPcbzwQbhrHiw5yMLNW1RuqqVI/
	1bOD3tR+Mts7QJFjxrnQrqeQmsivMIdUtCNAw4GR+p3BREJPwMHNAAUM8sPJh4q6vk3nEyEY9BF
	lskjdqg/LmIDlcpS+2JxZ
X-Google-Smtp-Source: AGHT+IFoh/t7q9w0OOWI5lPWhEYDWQjOP6fwyanC4umHXD3Z3ogI4emvms7MREgszU4VmoxeyK67ew==
X-Received: by 2002:a05:6a00:3d0c:b0:730:9242:e68 with SMTP id d2e1a72fcca58-7348be7ee95mr10144318b3a.23.1740658256980;
        Thu, 27 Feb 2025 04:10:56 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:10:56 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:43 +1000
Subject: [PATCH v3 16/20] ASoC: tas2770: Power cycle amp on ISENSE/VSENSE
 change
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-16-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2687;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=er/NvEhNNS1LjFLGs7pKaGt0I/0LUg0k5iDGaFhFgS0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk+X57cw6iW/6NlTlV684+CiqxUKnPEOv1/P+vBX5
 v9shxflHaUsDGJcDLJiiiwbmoQ8Zhux3ewXqdwLM4eVCWQIAxenAEwkLp2R4c3pVSt/XItr794V
 zx6vtNQ4KPXTzLz1V6a+i1ebl68s+J+RYfX2XxU6h3IWZcqq1hU/UJ4e72fDdnpdeGzv1MB/trI
 svAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

The ISENSE/VSENSE blocks are only powered up when the amplifier
transitions from shutdown to active. This means that if those controls
are flipped on while the amplifier is already playing back audio, they
will have no effect.

Fix this by forcing a power cycle around transitions in those controls.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 30 +++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9cdd3470e9a04d5a5f801c3690d40f8fd131cd94..787356a4f4256627a55e35c851a9e78a1cf29771 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -157,11 +157,37 @@ static const struct snd_kcontrol_new isense_switch =
 static const struct snd_kcontrol_new vsense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2770_PWR_CTRL, 2, 1, 1);
 
+static int sense_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Powering up ISENSE/VSENSE requires a trip through the shutdown state.
+	 * Do that here to ensure that our changes are applied properly, otherwise
+	 * we might end up with non-functional IVSENSE if playback started earlier,
+	 * which would break software speaker protection.
+	 */
+	switch (event) {
+	case SND_SOC_DAPM_PRE_REG:
+		return snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+						    TAS2770_PWR_CTRL_MASK,
+						    TAS2770_PWR_CTRL_SHUTDOWN);
+	case SND_SOC_DAPM_POST_REG:
+		return tas2770_update_pwr_ctrl(tas2770);
+	default:
+		return 0;
+	}
+}
+
 static const struct snd_soc_dapm_widget tas2770_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2770_asi1_mux),
-	SND_SOC_DAPM_SWITCH("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch),
-	SND_SOC_DAPM_SWITCH("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch),
+	SND_SOC_DAPM_SWITCH_E("ISENSE", TAS2770_PWR_CTRL, 3, 1, &isense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
+	SND_SOC_DAPM_SWITCH_E("VSENSE", TAS2770_PWR_CTRL, 2, 1, &vsense_switch,
+		sense_event, SND_SOC_DAPM_PRE_REG | SND_SOC_DAPM_POST_REG),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2770_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_OUTPUT("OUT"),

-- 
2.48.1



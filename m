Return-Path: <linux-kernel+bounces-515825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A5A3696C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB521893DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0231953AD;
	Sat, 15 Feb 2025 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqa/pozB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E713AD1C;
	Sat, 15 Feb 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577905; cv=none; b=Uu0kJJrsTM+1nTLTkxGaWjkfLQDMrq6CC+56J8sygtlZL0ruihQQoVYvrwyckIwJvvCGhhoD7qFz+qi+XdrHyvcxAXl9xqYQW+KUPWyXXbbbVHTn5J7zTRAodR171/SGmPfWzXSzEesYTyLeEQ/2rqsm3TYRSMjawR5OOz5yaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577905; c=relaxed/simple;
	bh=uQHhZisqTXPTDYjiny+MKsSknzKa4qowB3Z1YfED8wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EfP+4i+qF52XWWJts/xJPfISHAbN+Sk1B4lZxbkqAdCApe8eQUiveHD/XfHVfugkWJDM3ir8Y/FaDXfhy4iFy5sbGlXPTvYz/4j6GJm5phg9+h/imKbJ8QWcxWMHHTgmYu+2s5s9g4TGgckUwIF2/ta5e7843epwgQNve9lNXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqa/pozB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22100006bc8so12069675ad.0;
        Fri, 14 Feb 2025 16:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577903; x=1740182703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yev+hy6AL0bBW7Eh6XqRgJcnN9d72JJJp00p8GxRNLQ=;
        b=Qqa/pozBzYip7TaLLm8Sad2dFdj9BDx2Lj56TkH7wj0GRlR9h0VR9u3XbJxlGFCexJ
         2fz/KHvYcw4HRQcnfRwiWLG9eNmv45Km8C7noFZV0C1NGnSihyJHFJ29oFzjb4W6IVYp
         69eKl2R+cyiXDlrswkahLiSgT7bcjqSGDeQXy3Wd9fZoYRYKzsY0/iOkQty+0QQnx3F3
         0SLU7QvnvZ0kPS+313HVtmCglOdHvbQCJAty9sldrCVX21mRUanFtXlxJXPm79M05HFt
         jMzyrKkVtp4m33Kji+S6hNrJMGssjOoV7sCFjg4Ul+c3z6RihJRnH82MkzfFI5/H5hfR
         Z1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577903; x=1740182703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yev+hy6AL0bBW7Eh6XqRgJcnN9d72JJJp00p8GxRNLQ=;
        b=oIh8xI7Gpfj6IVZpY6QC+57CbrgvY8AzdPEdKoruRj3toFLRWqegiwykfLWp4zockf
         Gd3U0FUx5XG+VsMCnpTKmM/jnLZkTYU3ZQv4+NUMcBY/5zJmnaGttjscV+3afNWJ+o0J
         J5krjiLCMxKwBZUpZabuGp5QORj4NzoLscwddKQDs9IYI5M9c58NiaTvjKVd82adgv4U
         +0r3xud0R8yVoe4VwbSlmnlNhosr0f4L6nWhVFqWbavlSQhnR21q4p77DFerbLXJRRKD
         LbipAnq/Eu38K+HWlt8FfRY3ZD7zjgSdsYSyyhivSQmqJtgDWxnrnFRydx9I2oYzzIac
         ijoA==
X-Forwarded-Encrypted: i=1; AJvYcCUgC6QPVHnQUgRrn5pbZtMs+SiRN+hxrrLsSWO90/h/2kB1KznMyUFLOL5/a9uOFxUpYh423XqUKtJJ@vger.kernel.org, AJvYcCVzbMO+VtP1gY3a7YkPPaPKMWak8KmTFi0tBCCrOTzFNAoQMyaAqA006L3Nitw15li9kbxQihBuPwtxv8XO@vger.kernel.org, AJvYcCXuFDk4xRGJ9Anq26tzV8oCLGTZeQT3YXovqiI830EZ5WPqgMG1dolDkGYfpWsmnHwm1OJ0O1Gj7+y7EMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSDVUofeMJVWH0FoPukgHlOgB4cCQ5ii6Fsh1emBKOaygGMVU
	necheJbxEw7A6/Z/hecRFWiLAkGHrqfGV1+g/m7+523otwvSu+i2
X-Gm-Gg: ASbGnctpxlu45/iphbhSPrV2iKTYAnAeYdA/JknEtjlM245wmXlrQUvSHMULlm/XyLG
	5buXGzOtRiGXPgF0rvZWYS6bCas7whNTOx21jJIqd2IdlKNrU/SPHT2fTalJqoXyJXRX0L5OQCn
	dpLPcfOhqojxuzPwKSgCZSZVYJteCr+oLD0g+R8uFt879GqzdyZUNdvxemMYL+unvVG25PDCa5r
	YKfH2n8eywWENqtGJ/XVN6Uin/X7g+hl3lHl4Fb4vfoomIR+3qAQdt3ClS6DgbnYIZb6cYiRD2j
	/HKxlUiRioofLietNUQUUSzRsCTgE/3I/UMbVGkHHoqsTR6ifgZ1m+3hFbxrgIjoEFAp9yyBxlN
	2HpzwWIDQvQ==
X-Google-Smtp-Source: AGHT+IH04yKNMACJp2CHH5fEcKIXFrsOEi1FLLdSN1hohfKFEr4W+plxgLqIoCm9+mjgHicsvBlNfw==
X-Received: by 2002:a17:903:1c5:b0:21f:8099:72e4 with SMTP id d9443c01a7336-2210406aee5mr19980685ad.28.1739577903590;
        Fri, 14 Feb 2025 16:05:03 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:03 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:49 +1000
Subject: [PATCH 16/27] ASoC: tas2764: Add SDZ regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-16-723569b21b19@gmail.com>
References: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
In-Reply-To: <20250215-apple-codec-changes-v1-0-723569b21b19@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=GrvBw3IK7E/2W1Oos8TsyVPe07NNuzWsVHth6J13x2s=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24/ya363ezjfsXizVeVAub/jqlJjvSs8Otcwvt9x
 g/RLWYbO0pZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZiIiBzDX3kZFkHHx8VTwlkv
 8qV/EE+r2KVmvDs9cfKTHL6UN2xidxgZHjwUYa0KEr763H/JCw6JtJqXG66KPeLIDFm5/cJet/r
 pjAA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Multiple amps can be connected to the same SDZ GPIO. Using raw GPIOs for
this breaks, as there is no concept of refcounting/sharing. In order to
model these platforms, introduce support for an SDZ "regulator". This
allows us to represent the SDZ GPIO as a simple regulator-fixed, and
then the regulator core takes care of refcounting so that all codecs are
only powered down once all the driver instances are in the suspend
state.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 39 ++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 2baa7fbb5fdeaf50cfb76a7eddf752cae2511329..d1eb8ee30415e335adf8e14d14aaa207c949ddcb 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -34,6 +34,7 @@ struct tas2764_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
+	struct regulator *sdz_reg;
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
@@ -153,6 +154,8 @@ static int tas2764_codec_suspend(struct snd_soc_component *component)
 	if (tas2764->sdz_gpio)
 		gpiod_set_value_cansleep(tas2764->sdz_gpio, 0);
 
+	regulator_disable(tas2764->sdz_reg);
+
 	regcache_cache_only(tas2764->regmap, true);
 	regcache_mark_dirty(tas2764->regmap);
 
@@ -164,19 +167,26 @@ static int tas2764_codec_resume(struct snd_soc_component *component)
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
 	int ret;
 
+	ret = regulator_enable(tas2764->sdz_reg);
+
+	if (ret) {
+		dev_err(tas2764->dev, "Failed to enable regulator\n");
+		return ret;
+	}
+
 	if (tas2764->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2764->sdz_gpio, 1);
-		usleep_range(1000, 2000);
 	}
 
-	ret = tas2764_update_pwr_ctrl(tas2764);
+	usleep_range(1000, 2000);
 
+	regcache_cache_only(tas2764->regmap, false);
+
+	ret = regcache_sync(tas2764->regmap);
 	if (ret < 0)
 		return ret;
 
-	regcache_cache_only(tas2764->regmap, false);
-
-	return regcache_sync(tas2764->regmap);
+	return tas2764_update_pwr_ctrl(tas2764);
 }
 #else
 #define tas2764_codec_suspend NULL
@@ -209,7 +219,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
-	SND_SOC_DAPM_SIGGEN("IMON")
+	SND_SOC_DAPM_SIGGEN("IMON"),
 };
 
 static const struct snd_soc_dapm_route tas2764_audio_map[] = {
@@ -642,11 +652,18 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 
 	tas2764->component = component;
 
+	ret = regulator_enable(tas2764->sdz_reg);
+	if (ret != 0) {
+		dev_err(tas2764->dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	if (tas2764->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2764->sdz_gpio, 1);
-		usleep_range(1000, 2000);
 	}
 
+	usleep_range(1000, 2000);
+
 	tas2764_reset(tas2764);
 	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
@@ -721,6 +738,9 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 
 static void tas2764_codec_remove(struct snd_soc_component *component)
 {
+	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
+
+	regulator_disable(tas2764->sdz_reg);
 	sysfs_remove_groups(&component->dev->kobj, tas2764_sysfs_groups);
 }
 
@@ -823,6 +843,11 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
 {
 	int ret = 0;
 
+	tas2764->sdz_reg = devm_regulator_get(dev, "SDZ");
+	if (IS_ERR(tas2764->sdz_reg))
+		return dev_err_probe(dev, PTR_ERR(tas2764->sdz_reg),
+				"Failed to get SDZ supply\n");
+
 	tas2764->reset_gpio = devm_gpiod_get_optional(tas2764->dev, "reset",
 						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2764->reset_gpio)) {

-- 
2.48.1



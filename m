Return-Path: <linux-kernel+bounces-518889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E074A395DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303B61794E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B6A22B8D5;
	Tue, 18 Feb 2025 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwWSfVil"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8222FAC3;
	Tue, 18 Feb 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867912; cv=none; b=mz/JsqfmIrMp3RuDZcReEsP8RClg3WNt/YpTNtPMtfBcdjNdLr73Qj/cHRJLkKntPmisdNgFOPYoCYLR5btfGeJvDOWbywGbJaQQJpz/KqOhKrEhGE+fUkJRQzm21J+b7juAvT8+vXg99h4oF5I7Hyjj3NSnVHKUItBakgnm5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867912; c=relaxed/simple;
	bh=A48sQENUp2ByJkXfl8NgeRBNfDPrK42u/ckclupyak0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVKpSaO52fFPHwRk9yJfypYrWvKWNxx048iiZSvYnRSZ7vcxKb6lvXKtcNWu5ao0aCCgGNonnaQjH0g5sA/w1QsM8lvuUyX/nMZxmv779edxlRhathiLOoUjdeKg69jDs62lB8YKqHKStzVpFJrGTdFlpQnIPtv+i5wvZUBCCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwWSfVil; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ca204d04so69050105ad.0;
        Tue, 18 Feb 2025 00:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867910; x=1740472710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQtBu9vnY7YUuYtSr4xuzwpvCGHHh4MxAf44AyPw29Y=;
        b=GwWSfVil+4sAk5Vo77TQz0WQWuBK0nDOZDqHq5QP+xU4r4cx8rcg6BUjtnQQ9pE7cx
         hA+FYPEDjegfkwconG4u9GqO0vbrGSR4QR01c1Zzr5WuWGszFCC5qvQodeqb/vdYN4VU
         u4fVi+/I6zppryQqpszVg7ulzWNaHKa0LqMEzYax34q4BZAL9luxwljIUSU1wARm2tP+
         1E2BZRfP01pwJriwX9TxRMew5TI9+INhhgYrjtOBOqSR+BOgb922i5XlOVhOM+aoBijw
         ZTRfyZB1itbuXOKU6diMYCtWPw1rUrX/K80FIL5ncS1eycLqlxvBtViFn738C8tNACVA
         717w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867910; x=1740472710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQtBu9vnY7YUuYtSr4xuzwpvCGHHh4MxAf44AyPw29Y=;
        b=uj7a/NTyZDGUbHL/y0rYVaf7hiWMEJX2yiyegXVAB2RgvY7q/8XuPAzvTBfLAMR8Kc
         ClYGxSEhCAyZtAJvi5AwFuV5dMeEPNW70AdGtVkv+GOoLGkm3dJQ0GWiBp6rhqUB1vK/
         jYho8//y2E3fuDfUOQDHxK2KEJNoIyCWMQG4CI7A4GKUaRU4Ch7ZUGU7NBor1CEXVPSi
         hE7Li58gNhYx8Yw4DTOAC53M5jcc6uc6AHHPHPA9Ml6ge1Vqb8vmYoZXmRlVv87yBGg+
         BdNL5yFJTD/BNROX9XmsXszU19GS3o8+VwvhDnBF7bLojlhfIU5RsMWFw8fY69pUwbtt
         ++bA==
X-Forwarded-Encrypted: i=1; AJvYcCUvPph9xrXB3h7AiLWh+0TJ8ZfHIMKblbtKggtoWJTLorh3dqled55Ny/0dig0b6Sg0b/G0r8IxQdAwiCco@vger.kernel.org, AJvYcCV7DXMYTGIc+c7oqq4ScgJFuWKcYRAorDLKJUVaCkZlV8yaZb6fXM0owE1atsDxpbYMzWXGaofbrbxb@vger.kernel.org, AJvYcCXkjINOwfw57ODzzb5Xae+CyM2jNxFxu5DI5tlLmMyMLjd+C862uZWn33aLNOQFN3BKpS8+ypgASu8skc4=@vger.kernel.org, AJvYcCXz7/qxaa+HjVuKzDxtuiJONAnAEGa/bkY6qkgGbqqbS2xTdzSk6UDy/FUZINLhWhzdcGsC/YKx2/wBPYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywha79+ZtQMWRcOAtM2n72ca+It42YlKcKyPyawkIxn7zx1tJIK
	D7kKY7OC9xZbMDqvpSYpSNBfgbggjtMezfhCmTfZj5repMU6Dqr0fquEm95s
X-Gm-Gg: ASbGncsgIg99sGmorPmWG0uE9S38dK2ispKk9gOgZv+c0sBIOcUfwA1BFKiHybJfAVk
	kcMuo2OV2LAo+MgkvganT/RadxkbuUtp0dwBR8Zwr7tX9L4zvgBEko5X95GD+JJBsgfbt48pPm+
	Bvxm7cbecC6rwINvESUz2aeXwQZxAXhpn/DxvCZKziy4435dTAfSNbBKAtDKrcYZm4mc1V7CAu6
	sDNg7QOB6mJLOAb3X0y1Yj7T/eqZfexpW/Rqa4nGyL3ypmHCrP1bg4LQK5LfZjcJcfQfhsQQ09s
	yWpjPiGeDfAkNECr6UYysVSL5mDRlxNvZ0aIrlQ0gllrZ0v2Zf3it4pzNdlyjovqOD35i9nKw4C
	7fQzPyt7ycQ==
X-Google-Smtp-Source: AGHT+IH34vYLjX19UvXU10ZXbfhoEcvPc03iB/RyswRJADMdBeXClw2Dv9JqG783BId5B7H/v93pvQ==
X-Received: by 2002:a05:6a20:6a22:b0:1ee:7f20:e44a with SMTP id adf61e73a8af0-1ee8cb15559mr20371390637.9.1739867910127;
        Tue, 18 Feb 2025 00:38:30 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:38:29 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:54 +1000
Subject: [PATCH v2 20/29] ASoC: tas2764: Add SDZ regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-20-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4016;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=kp+o9JoudGtfB13mggEYl995BI1+wbuw/SRFF1jLny4=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JK2KLDnVgs0yatOjOn87f5VYmPDzY7WjXszJ0W8/
 hlmFmvbUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwERyfBj+aVeGMjyKr9zEt9mF
 b1Kr/hL9r7V8rf2rl/E8e/r6V8/RJEaGc/+6gm+9OLzRKsZqXezcEsW99ioX9jvJf0lVVDZNe+3
 FAAA=
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

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2764.c | 39 ++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 7b69ab94c4bbd5f074d57a42f71b32f5fd63d560..5d89d47c1667c1067f88169575b7b76e9a25bda4 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -35,6 +35,7 @@ struct tas2764_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
+	struct regulator *sdz_reg;
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
@@ -154,6 +155,8 @@ static int tas2764_codec_suspend(struct snd_soc_component *component)
 	if (tas2764->sdz_gpio)
 		gpiod_set_value_cansleep(tas2764->sdz_gpio, 0);
 
+	regulator_disable(tas2764->sdz_reg);
+
 	regcache_cache_only(tas2764->regmap, true);
 	regcache_mark_dirty(tas2764->regmap);
 
@@ -165,19 +168,26 @@ static int tas2764_codec_resume(struct snd_soc_component *component)
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
@@ -210,7 +220,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
-	SND_SOC_DAPM_SIGGEN("IMON")
+	SND_SOC_DAPM_SIGGEN("IMON"),
 };
 
 static const struct snd_soc_dapm_route tas2764_audio_map[] = {
@@ -698,11 +708,18 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 
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
 
@@ -777,6 +794,9 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 
 static void tas2764_codec_remove(struct snd_soc_component *component)
 {
+	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
+
+	regulator_disable(tas2764->sdz_reg);
 	sysfs_remove_groups(&component->dev->kobj, tas2764_sysfs_groups);
 }
 
@@ -879,6 +899,11 @@ static int tas2764_parse_dt(struct device *dev, struct tas2764_priv *tas2764)
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



Return-Path: <linux-kernel+bounces-515830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D4A36981
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1633189674C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1B1A072C;
	Sat, 15 Feb 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxKYjHoH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5213D52B;
	Sat, 15 Feb 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577940; cv=none; b=Uy2tNUP/2xaAc3JFxtoHDfig4va045FcfCmlZnqZ+9N6BAc8t1n2zmcJ7XROllx45r0bNfvL6MBdN6V6czh8ne37l2f7C2nHt6nOOILjAFrxlys0KnvrQ53L6NE/SJtIhUI1U5S87jNVuJbW2dsxG300+q7Wtx2CXWpwiMRNsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577940; c=relaxed/simple;
	bh=ra+yRi92IePI/Co7cFytb4QJJLwiNwAxoyCJc2NnbsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx0uYF6IHcgt9p5GFBBPNDKAwfbu5wUTWklknHz66OiyqbFFiIDEqeZDULAeEBnDMN+9UHKy0YXtcv8ABBje5H09OM+ZR/04n/umHzo0fCRxadutgWuA3tvLtqFs5k+ov9WHmJMFzKS3y4M8vfRwD0ny9C4wg+kkKruOE3GEeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxKYjHoH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d39a5627so39212225ad.1;
        Fri, 14 Feb 2025 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577938; x=1740182738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agp2EtTn6ff85lerjx80Fv21qzF7rNE7VnNI5iOBCcU=;
        b=QxKYjHoH8XjA4EoGQyJMx8bMLBmPjJrYfEu9T8FSAmd0ZCwpyHygM08xMapHQSNP3V
         6g5SdV6+tjh4SqP8yjeejnWBpJiDba3oc/jqTdIy/oj6D19f4YUfovycD8FoEet4eQKA
         1FSbWh5krNOwgoF2KAgY3I0RvBwstE+GaLz3GCnznuDAtn9lvK7CPZiqlAAc5mBmY8VT
         RSciuq+3IrCHGKtrOeEbRPPVapByaXU4LvxuxlAxzILsOy+ybhs4GIW+BNnGlOSC99Jp
         XNfywQHimyEk1geHYnas9xGACZsppgqBF6SVQYkS9VeIg0FmLiARel64LayxpigLUjTa
         JI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577938; x=1740182738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agp2EtTn6ff85lerjx80Fv21qzF7rNE7VnNI5iOBCcU=;
        b=BjPR3QgTKlOMkXhM87mTtrpCLKq+JCL30bs0TDgG/JmtoNDDXicpbNtq0roMtnpLQD
         to3aqrvXX3wjIrSDonvHeM0vi2nV3uIu+z9Bumuw1ppjXpvun/jJvRVwem/ICbfKt7Dk
         jk37msMH5O60JyjrDUTHZ9mNGiRleSGgLGI24OQYRnE7wBhwyNvMb7z5H3fR0cpP8GJj
         2hWw3RYiZTlg7Ni8BCoJyeulhMvwg1dKWxSP0j8EXf84sQk01Erc7qLy6ALZHUNjAGQJ
         EPWuiL29OG8yKdw/BYBLDBbqEDc0zYcBHMuGwxQLgbkdzEJ4Wbtzlq+ml7VHjnmLeqnA
         dVjw==
X-Forwarded-Encrypted: i=1; AJvYcCUUdlt9WRo5kISEBRIoNV4tgQ/Smu/qh+N6qsz1+YCy2Y5vAD4hUsff07rphl3mAkiQSPi/9wPSrrojfDE=@vger.kernel.org, AJvYcCW6903nbXrflobb27EMI+Fbz2mTDs8Ta1WAg7Wl+pPu6c+E330jVn81uWrTgBt8bBkaPW9vJ0MiSfbeVd09@vger.kernel.org, AJvYcCWrwIdWVgFxv+LDktYhHOIlQCd+CCIfsPxslwFhjZQol5VrpmkH5yfrZ1TIlFk5CuneobFGBKjkZXWx@vger.kernel.org
X-Gm-Message-State: AOJu0YxVey9LeLTXlMrWqgTUOPHZTd6WhMPD3ewVHdvnB2rT6zeSE1/f
	8pDig3vIvZ814ba6EjxlC4DXJCf76pmfZ0wcElEbw0xACeRfWPPw
X-Gm-Gg: ASbGncvmkZ3cGbm9BTdYpf2hKk1vmST5sr9rjDcf/fQRP+YG4Yv/WWtoCvgpBzXAvXw
	lR1ARZUMLD/XjpkX2MWYqpU/9xGkKaxIOSQ5KYcMDLv7wixfOcFDvhgcAXM2KW5DUUs1HIbr3gy
	5ru7ruhWv5hdsWZf1ChbsVuPfpFYZTddF8i1CRYWP547qHUvZiOgAh/I41qTdWo+WOcyHBeyKcM
	fLxVXl67A0f5lPknD3zO5O7nlZHTtCRi86HGm+NynBMU8tEXWr/zSFGhA9pChC0815SmK3oZpCd
	4T31bcfd6G49adO5YCEvCZ9JAZQ3boaT0H6oRq1jXpnnklt4eVdtk8d6437e5slEwwg9sFzMVEK
	N205nLxE6ZA==
X-Google-Smtp-Source: AGHT+IFc7GBCDsQtxaldyI9+KDsg/DqlWwwQyee+WxEsGp2jKMl8iXnqVhm0eYx3/G8tkcRqznaeoA==
X-Received: by 2002:a17:902:ea11:b0:21f:136a:a374 with SMTP id d9443c01a7336-221040bc267mr20011645ad.43.1739577937988;
        Fri, 14 Feb 2025 16:05:37 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220f26ea127sm15071155ad.96.2025.02.14.16.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:05:37 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sat, 15 Feb 2025 10:02:54 +1000
Subject: [PATCH 21/27] ASoC: tas2770: Add SDZ regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-apple-codec-changes-v1-21-723569b21b19@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=9OK8DI1H0t75YODJO3v563NkJyHzxTPlas8P1GZeEE0=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOnrb24/sHXKoiKHlat/Pjp5p/vIu3nV1ac0Tu65/qhId
 +a8JbftznaUsjCIcTHIiimybGgS8phtxHazX6RyL8wcViaQIQxcnAIwkY1MjAwfeZjKOFkuT+C5
 fvFnV8rWS2/FH111lCk7FnnkYazAgymRjAy3+mPXRUYLs77rvfgs5Lj3q6VWm7zUjB7eLXylufx
 RjRk3AA==
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

This also reworks the sleep/resume logic to copy what tas2764 does,
which makes more sense.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 67 ++++++++++++++++---------
 sound/soc/codecs/tas2770.h |  1 +
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9f3588ec117bb8ed0a6f2bbe5d7dc422862f052b..bac34e1237ce2a5e25face47e0597617308f1343 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -71,23 +71,21 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
-	regcache_cache_only(tas2770->regmap, true);
-	regcache_mark_dirty(tas2770->regmap);
+	ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
+					    TAS2770_PWR_CTRL_MASK,
+					    TAS2770_PWR_CTRL_SHUTDOWN);
+	if (ret < 0)
+		return ret;
 
-	if (tas2770->sdz_gpio) {
+	if (tas2770->sdz_gpio)
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 0);
-	} else {
-		ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
-						    TAS2770_PWR_CTRL_MASK,
-						    TAS2770_PWR_CTRL_SHUTDOWN);
-		if (ret < 0) {
-			regcache_cache_only(tas2770->regmap, false);
-			regcache_sync(tas2770->regmap);
-			return ret;
-		}
 
-		ret = 0;
-	}
+	regulator_disable(tas2770->sdz_reg);
+
+	regcache_cache_only(tas2770->regmap, true);
+	regcache_mark_dirty(tas2770->regmap);
+
+	usleep_range(6000, 7000);
 
 	return ret;
 }
@@ -97,18 +95,26 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	if (tas2770->sdz_gpio) {
-		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
-		usleep_range(1000, 2000);
-	} else {
-		ret = tas2770_update_pwr_ctrl(tas2770);
-		if (ret < 0)
-			return ret;
+	ret = regulator_enable(tas2770->sdz_reg);
+
+	if (ret) {
+		dev_err(tas2770->dev, "Failed to enable regulator\n");
+		return ret;
 	}
 
+	if (tas2770->sdz_gpio)
+		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
+
+
+	usleep_range(1000, 2000);
+
 	regcache_cache_only(tas2770->regmap, false);
 
-	return regcache_sync(tas2770->regmap);
+	ret = regcache_sync(tas2770->regmap);
+	if (ret < 0)
+		return ret;
+
+	return tas2770_update_pwr_ctrl(tas2770);
 }
 #else
 #define tas2770_codec_suspend NULL
@@ -547,11 +553,18 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 	tas2770->component = component;
 
+	ret = regulator_enable(tas2770->sdz_reg);
+	if (ret != 0) {
+		dev_err(tas2770->dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+
 	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
-		usleep_range(1000, 2000);
 	}
 
+	usleep_range(1000, 2000);
+
 	tas2770_reset(tas2770);
 	regmap_reinit_cache(tas2770->regmap, &tas2770_i2c_regmap);
 
@@ -573,7 +586,10 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 static void tas2770_codec_remove(struct snd_soc_component *component)
 {
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
 	sysfs_remove_groups(&component->dev->kobj, tas2770_sysfs_groups);
+	regulator_disable(tas2770->sdz_reg);
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
@@ -713,6 +729,11 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 		tas2770->v_sense_slot = -1;
 	}
 
+	tas2770->sdz_reg = devm_regulator_get(dev, "SDZ");
+	if (IS_ERR(tas2770->sdz_reg))
+		return dev_err_probe(dev, PTR_ERR(tas2770->sdz_reg),
+				     "Failed to get SDZ supply\n");
+
 	tas2770->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2770->sdz_gpio)) {
 		if (PTR_ERR(tas2770->sdz_gpio) == -EPROBE_DEFER)
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index f75f40781ab136cccbe1c272f7129ddd3e4a22a3..f75baf23caf3a194a040474a7484a3d44f673435 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -134,6 +134,7 @@ struct tas2770_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
+	struct regulator *sdz_reg;
 	struct regmap *regmap;
 	struct device *dev;
 	int v_sense_slot;

-- 
2.48.1



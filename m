Return-Path: <linux-kernel+bounces-518893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E2A395E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F6116DC98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCC23BF93;
	Tue, 18 Feb 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqNs8yQj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E222E00E;
	Tue, 18 Feb 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867944; cv=none; b=BiO7Ed0O9oQwf/6rUoBUQe+MACncJTQsmVqbYDTX5EGXnNjpcQXCL/5Y8647Iq8k0R8WUvRGzTDPKwIGdFJZ/wi2PhjNrkKXeNgSppUdzpcoxkC2rBLHSBRReaEy9L4XYmU7k+YmMI8ZGtSiPE/yzKGXToJPihKLZ+UcDhz1mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867944; c=relaxed/simple;
	bh=rfSKe5mZ28D4d/wpG3708ppy30x1Dk7ewBzxd+E8h08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hE5z327UZOWSCeeSzx56ZAgUVjCgztHyGnFZxrtBfS6N5Rh4/zpRZvA72t3g45aEEerlaym7E7f2pYR/cnj+olpMKtb/wh9UDroMkXM3oTmd/wvglvpjj0qLVqBR2j2vbHjbLAIVtiGPpjiejZs2cLcjFsH/gb40pWHDDRgZybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqNs8yQj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220d601886fso67205105ad.1;
        Tue, 18 Feb 2025 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867942; x=1740472742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogdzAXtsfl3vLsucowF8jbn32dNSIkJRvbsQxdRncfg=;
        b=LqNs8yQjGo1jyntgm+aPfsST3CHKHNZw2VEfE34c/kDPQvsK8aw7o8+QJxv+TvMbKq
         Wex41QFeGvhC1yos+UVAXqCTZu9TDuO/7Jvn5NACEmkg7EAa8tYN+vQW4nFS+NSApxYH
         2Da1t7B+i++wIplj8ZqDSA1yehbtZbbiEd1kfuorawh5IgmwU8LrutSPBCvX0SbNPX3Y
         AmpTIQ/+aIpH7uZUICNx0qVv9CB4RGkucgYFqrdGpWo9HP/8yAU+xrK35VHU6AYdoB4q
         ATb6C/5vkh0z6UDAdzKH0Xb9VWKzasUorbvIifFiv4Vz50wZKnAtVuYHK14XWsI3UsxI
         GmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867942; x=1740472742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogdzAXtsfl3vLsucowF8jbn32dNSIkJRvbsQxdRncfg=;
        b=u4lfyHF/Bfe1EpFi3ptdhHSFKpa1OG/83yaeAU7z/MTrnXbvH5IxFoiwy24VctufmZ
         XZR9u/9a8g+6/MkqPZpfWbe57FmPn9xgXCo8Uo5w7bLfRJB05qsZhR+3hh+A+s8rQKhM
         F0UbSDBRmffolz1/66tMq7rf1B0jt3JqF15BUC6V9t+vWAnlD1/VTPBa6kjXd+IaSIz8
         4I1/4FW1fjIVWPPq0m4kvL2gOBgpgc6ga8RrENQOY0Xsi8UURvZvHssrn44ENm/zPnZx
         peWPSMxkjv7ucvAlU6bhoDQaFmVhYyoquMsiiWnxZpI1Ff9/f0XkS3yORdz+RfZDALZO
         X55Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHoLwTWR6Dy1jfwNpkoF1tcQynbV9A3JonypP+yuIK8zrU7EhEoens3rw/nFxsiU6s3HNq0fK0DHt2@vger.kernel.org, AJvYcCUa+TKFvO7AWu7UnifLZcWxUg+Ubm8pO/kc9ssBQtCBu3ShzsQpL6DQxMYwv6GpyOal7sfjiZuGyV776II=@vger.kernel.org, AJvYcCX/dWw4e1x5tTE9GIxi6mbyrpTzHhoAb9zJU2bPYGBHzOhcv2zefxk86O9/V3GNJES2ZvEfd5sBBpMLB3U=@vger.kernel.org, AJvYcCXdTzrM/LKDrUcxJWj2vzNwECRizMOw6Pq1wJb3OOYJwKn73LK8CPLTkbaSvdgQN+ezDv6fPIRowcMlLB3y@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1TpExnilSv8bLJBzNRhnJ+dd7blpXrK1hvO64rhkyXXlGWMY
	PL5lGZ9zmm0jCwLbKRUjKSuh0eIbB9n4EUjtKQkzi7guO7VqzWxt/jYbyZ57
X-Gm-Gg: ASbGnctG9+vrP9BcmcD8oeWiQiBnG9y7iu4UEkvs41MdTNOC7x0jAjod9U+SnO0Si1V
	WRSXsfPmLu32TAtG9bV2q4e5uWjVn8xp0FQ93SjvEYMJ7gsdilurn//BmCAdESn0xjSQ/ldBmLt
	pvrPp95ACn5Rq4EJdm9NY/edq5UZCVO+hTs3HRNf9jy1OD0+lDvDeM0uboD3ldKSQeg5cJPcg47
	0HsAhQ+XuH2QQSCCmOgDWfnSFz1UM7XhclkWOJYOkrtEw4wgROwF2qCH3u6HffaXK12wIBAfA4g
	SfQFJEbbvlH6Zf2qKFQX9+VplkxazxP0/v196AXnJmyU4gOwJqBc8RGYJLKlgS331hk4UxMRokH
	RxzGRHHRabQ==
X-Google-Smtp-Source: AGHT+IHanfwIgxnK+GSgc9xAFapLO97DcmqVFwllMpPjle8zRchZcy+lMRf9zQdA+z6x8TwzFrX7Yw==
X-Received: by 2002:a05:6a20:2591:b0:1ee:69db:b0b7 with SMTP id adf61e73a8af0-1ee8cbf9ce8mr26104509637.32.1739867942036;
        Tue, 18 Feb 2025 00:39:02 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:39:01 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:58 +1000
Subject: [PATCH v2 24/29] ASoC: tas2770: Add SDZ regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-24-932760fd7e07@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4983;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=31ZxtlNvaMyuUtkGM3THLQ+tO/J0r+H3zZSixDq9Hh4=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3JKkpP6pnemN/XBnZoi34AEN12eJp/f084b7d2X/3
 M+Re/lPRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABPZacPwz8jdcMEsjpWLwh5E
 bFacM2/P7hP9wVvqd8y88eV9+8z03V0M/7Pmz8h3WFz58OdD1zkTRZ03606d4W/19K/cdff17h4
 NQmwA
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

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 sound/soc/codecs/tas2770.c | 67 ++++++++++++++++---------
 sound/soc/codecs/tas2770.h |  1 +
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index fee99db904a5885d740c1cfe8ce2645a963c6e1d..6f9e56f02f7ca95d7878c68465d7016213ae417a 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -72,23 +72,21 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
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
@@ -98,18 +96,26 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
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
@@ -603,11 +609,18 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
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
 
@@ -629,7 +642,10 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 static void tas2770_codec_remove(struct snd_soc_component *component)
 {
+	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
+
 	sysfs_remove_groups(&component->dev->kobj, tas2770_sysfs_groups);
+	regulator_disable(tas2770->sdz_reg);
 }
 
 static DECLARE_TLV_DB_SCALE(tas2770_digital_tlv, 1100, 50, 0);
@@ -769,6 +785,11 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
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



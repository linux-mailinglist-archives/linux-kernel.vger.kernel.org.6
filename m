Return-Path: <linux-kernel+bounces-235692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1675491D879
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801EA1F210B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2D058ABC;
	Mon,  1 Jul 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTNFsjh3"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E271747
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817363; cv=none; b=jjY2ZgTSCjAD4SXhDRPz42IGN/BYsjeeOW9w7UE7fffp370XH+fMTZ62vAlB3l8Bh/t/9uU8F9Nx+22YMcYOwrEgjqOIDSuGMIntXlT3dpskH36F4foVTzKb9LmlPho0XtwR/jCEXWX60+e8hc/WBPtzjdfH3Lj7iZc9cdT2x18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817363; c=relaxed/simple;
	bh=UjmSitKNlQ2nMJN5qYvwS/7oolUMY8paivqWw2tn+Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpZNhHlgLSAChlLyi/UNq1NVaJVXtiyslTYuSxIi98VNRxc9ecUltED13i2SddNmIR26WCBekcEnHyRMb6ufYZJ45hYG5MXriuEck10GoMlljPW3qttq2MKVeOgYbIPovwyfTj+tX+TSOHWWuCmxQkXG0gvRrJU42sW9MAakEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTNFsjh3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so30581061fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817359; x=1720422159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3/s/Nj4HWsI125zUFb7bumgBHzMcSwoiGKdlWH04Ns=;
        b=jTNFsjh3/W4X0zWtoKN7pesWuwDGacIvTh/5AP7jvoKdMvWdRL79M0yQ02+u45e2nk
         nGScDprrkWV/BMEbTaUomHb1X5jOJeR1d2ulyyXkdbR3xU8jXTdxKg1FxPPYr86qh1oQ
         C0j07ZmVmd9eqxfvayRK9D/nNP3vdPpdBY2f06wYvDtbJHZfyn8JKqBow0dIICLUGwoO
         LIJSy4XwbPJLzCDMkyyZztozqaGXrtT1hF8AKZzDaHwporBvRZjPxi36BXuJSDsMiJZN
         J6mmLAf1niaWjugpkq3jsHUD172YOICZMX3e3Ajn8uTZ2tOpF6e5xqypJDSJSrXU7Ctz
         6X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817359; x=1720422159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3/s/Nj4HWsI125zUFb7bumgBHzMcSwoiGKdlWH04Ns=;
        b=qUbZWvErkRvT6+uhiag98IPzpcLbjhfwmQkJGqa5xViOx/o27lPxj8JspquhIz34qq
         boad8izlRrHynd3BFuVtaCH2o9H20MM5fnWT2Dfgrua5EQwVViSr5Zdkv4Otk3fFSW+5
         6+5NEbkKZMblsp4jcPVNzOu70p1aFdv17gjma651C8T4hSgn3Wl9NRny/8Z3BjWSUs59
         f24tsG6ULwCYx0yuG+pfxounIktg5V2sepMCAC2E4ECyUwRuCmYlG63qfTvBL5Ar3Yp5
         DaC4QR3yeTTK4silCyayarg3lAGIf+lRkABSlEMs9Vwo7ec3b4suNmajsC25Kv0fKbph
         jX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCURAK4F04TGkcWrD9Azq+dh0NUySut5B7VWhqMpIahd8tQCHzVOaMTjbS+T2UNIEOaRhnL9rD1It6d4+mG4hH2bjzq0bRClzJlVD+wI
X-Gm-Message-State: AOJu0Yyeyk08f+D4M8dmVW8YJ65I6NBXvrdhy/tPidDRUx1/qxKVq11f
	EuNtf9+rq3iD0FtnjDkmw/jHuCB1irXsF1WF/EjvofL1F60OeGrR/S/ff2bEMBM=
X-Google-Smtp-Source: AGHT+IHlLNCx+HzW4mye2WD6CgheWVhB4SQOz1Cwyrm10zDOUU5da2YKF7YBflsCQSH6asfQe2IxGA==
X-Received: by 2002:a2e:300e:0:b0:2ee:5d45:b191 with SMTP id 38308e7fff4ca-2ee5e37de87mr31439981fa.8.1719817359222;
        Mon, 01 Jul 2024 00:02:39 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm4034383a12.34.2024.07.01.00.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:02:37 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 01 Jul 2024 09:02:13 +0200
Subject: [PATCH 2/4] ASoC: tas2781-i2c: Drop weird GPIO code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-asoc-tas-gpios-v1-2-d69ec5d79939@linaro.org>
References: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
In-Reply-To: <20240701-asoc-tas-gpios-v1-0-d69ec5d79939@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shenghao Ding <13916275206@139.com>, alsa-devel@alsa-project.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The tas2781-i2c driver gets an IRQ from either ACPI or device tree,
then proceeds to check if the IRQ has a corresponding GPIO and in
case it does enforce the GPIO as input and set a label on it.

This is abuse of the API:

- First we cannot guarantee that the numberspaces of the GPIOs and
  the IRQs are the same, i.e that an IRQ number corresponds to
  a GPIO number like that.

- Second, GPIO chips and IRQ chips should be treated as orthogonal
  APIs, the irqchip needs to ascertain that the backing GPIO line
  is set to input etc just using the irqchip.

- Third it is using the legacy <linux/gpio.h> API which should not
  be used in new code yet this was added just a year ago.

Delete the offending code.

If this creates problems the GPIO and irqchip maintainers can help
to fix the issues.

It *should* not create any problems, because the irq isn't
used anywhere in the driver, it's just obtained and then
left unused.

Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/sound/tas2781.h           |  7 +------
 sound/pci/hda/tas2781_hda_i2c.c   |  2 +-
 sound/soc/codecs/tas2781-comlib.c |  3 ---
 sound/soc/codecs/tas2781-fmwlib.c |  1 -
 sound/soc/codecs/tas2781-i2c.c    | 24 +++---------------------
 5 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 99ca3e401fd1..6f6e3e2f652c 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -80,11 +80,6 @@ struct tasdevice {
 	bool is_loaderr;
 };
 
-struct tasdevice_irqinfo {
-	int irq_gpio;
-	int irq;
-};
-
 struct calidata {
 	unsigned char *data;
 	unsigned long total_sz;
@@ -92,7 +87,6 @@ struct calidata {
 
 struct tasdevice_priv {
 	struct tasdevice tasdevice[TASDEVICE_MAX_CHANNELS];
-	struct tasdevice_irqinfo irq_info;
 	struct tasdevice_rca rcabin;
 	struct calidata cali_data;
 	struct tasdevice_fw *fmw;
@@ -113,6 +107,7 @@ struct tasdevice_priv {
 	unsigned int chip_id;
 	unsigned int sysclk;
 
+	int irq;
 	int cur_prog;
 	int cur_conf;
 	int fw_state;
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 75f7674c66ee..c5ace7216ecb 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -818,7 +818,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	} else
 		return -ENODEV;
 
-	tas_hda->priv->irq_info.irq = clt->irq;
+	tas_hda->priv->irq = clt->irq;
 	ret = tas2781_read_acpi(tas_hda->priv, device_name);
 	if (ret)
 		return dev_err_probe(tas_hda->dev, ret,
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 3aa81514dad7..0444cf90c511 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -406,8 +405,6 @@ EXPORT_SYMBOL_GPL(tasdevice_dsp_remove);
 
 void tasdevice_remove(struct tasdevice_priv *tas_priv)
 {
-	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
-		gpio_free(tas_priv->irq_info.irq_gpio);
 	mutex_destroy(&tas_priv->codec_lock);
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 265a8ca25cbb..d6afab542da7 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9350972dfefe..1542915b83a2 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -605,7 +604,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 {
 	struct i2c_client *client = (struct i2c_client *)tas_priv->client;
 	unsigned int dev_addrs[TASDEVICE_MAX_CHANNELS];
-	int rc, i, ndev = 0;
+	int i, ndev = 0;
 
 	if (tas_priv->isacpi) {
 		ndev = device_property_read_u32_array(&client->dev,
@@ -620,7 +619,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 				"ti,audio-slots", dev_addrs, ndev);
 		}
 
-		tas_priv->irq_info.irq_gpio =
+		tas_priv->irq =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
 	} else {
 		struct device_node *np = tas_priv->dev->of_node;
@@ -648,7 +647,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 		ndev = 1;
 		dev_addrs[0] = client->addr;
 #endif
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
+		tas_priv->irq = of_irq_get(np, 0);
 	}
 	tas_priv->ndev = ndev;
 	for (i = 0; i < ndev; i++)
@@ -661,23 +660,6 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 			__func__);
 
 	strcpy(tas_priv->dev_name, tasdevice_id[tas_priv->chip_id].name);
-
-	if (gpio_is_valid(tas_priv->irq_info.irq_gpio)) {
-		rc = gpio_request(tas_priv->irq_info.irq_gpio,
-				"AUDEV-IRQ");
-		if (!rc) {
-			gpio_direction_input(
-				tas_priv->irq_info.irq_gpio);
-
-			tas_priv->irq_info.irq =
-				gpio_to_irq(tas_priv->irq_info.irq_gpio);
-		} else
-			dev_err(tas_priv->dev, "%s: GPIO %d request error\n",
-				__func__, tas_priv->irq_info.irq_gpio);
-	} else
-		dev_err(tas_priv->dev,
-			"Looking up irq-gpio property failed %d\n",
-			tas_priv->irq_info.irq_gpio);
 }
 
 static int tasdevice_i2c_probe(struct i2c_client *i2c)

-- 
2.45.2



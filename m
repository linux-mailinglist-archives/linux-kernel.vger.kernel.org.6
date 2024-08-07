Return-Path: <linux-kernel+bounces-278108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F106194AB19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE141C21B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06C81AB4;
	Wed,  7 Aug 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AH2+l3A6"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6B8287E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042963; cv=none; b=MP0murZbK+MB9uwcYgh7D8srJMkZML6GvM+yiQBpq8/fkZlw9kn6Nmmb0zHWzza1+x9As/HkNyHZf6M02RMxbYTf6Ww0Ehj4lXrAQ0CUZimUYMumHoJ3IH21RSRi7+0BeIF/AR9aC9R5Vz5h7ANT6QXnsp5WcznUjlAPT+4nA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042963; c=relaxed/simple;
	bh=7UDfwJmrMLWgAadMr/nmIe/06eQrWV7hakK6EjfMO1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkcsxXGMx9ltlg365o3UrEXvGd9hqaWZdFUFor6VBw65K6tFQCiFpu1ZN3M2O8KJls6QLNlJYdqJmUWri8eZJq9AknNk6OaS18Wgpnpc5+Ja9UvHdwmhGQMgRkVEt/h/8yOHnDACuPIxSWj/DUBKQtS+6zTNyXZI5QU5IhSrhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AH2+l3A6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1858003a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723042959; x=1723647759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOZ9eu7KzFM6ThSYO7rTFdAab7Vy2Og8cSyaXW3jcO4=;
        b=AH2+l3A6C+2EJMkRvwSfM7aZ6WdxCPhm7Ym6bwQSvWmJCPKSqFuWXDF/0E5/zNUlZG
         iX59/EWAc2uq/tPgQAsb2rWnZxKwMfOWcA9NLssZg8gx/JiiFL5xe4dUfPysm6CpVLhj
         bHfLwEQjPfDqoKUrTBYFZkAnmmkfaVnplOThDIXK8+hG7L+M+k+CWSr+MWIIgr9iG6yS
         M53EChJR/s/9YlZpsiFaBtkQZSeb0bYUPla0tO1IbSF4AL2umwjhZZ6PEnDoQqdE0zIz
         EtDKvG35jAaPvACdGEVNmrNvvjPnd9W93He9ocqliPC7TBj6+1HA0JAUYJcc8pdnqVPL
         crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042959; x=1723647759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOZ9eu7KzFM6ThSYO7rTFdAab7Vy2Og8cSyaXW3jcO4=;
        b=NWrR/+wBGljxMMUBY8E03SZgm2miZWSLveI92QGeVO5Skbs7/OMvgV06KR6uyCQnW7
         Rkf52aZWugnPkrBCjS2ttk0B3mnLybyuVej/NfOopkDs4qZEC5GDH3j094W3SLqoDuZp
         WfFN/dsMZC3nt51PXq2XIyaxOfBtYWEOujCMsiP5BDqJ3h2pGJ+al7/eZZun1F3GdnQU
         PoAcycYWYFLhxtMZXwbODxOLisqrxsvpJARQGLdJL4ccUk+rna1ab9nIj0AlMSivnjMp
         2w9nIH7hrGuffct0WSAuELckaXDtWZxC3BDYUr6BgnUxxjxoZhFkNn9kD1a6t9KQfgyy
         nSmA==
X-Forwarded-Encrypted: i=1; AJvYcCUOrjPvIEqPVeSHOcCvPlnHwqZJ3fKC/CzVxyRFuyfqtlSFue4C8YxXh1NgIAF2jqA1G+nsF4UypI9DmlwpaOkprG1mQamOYEHkkugJ
X-Gm-Message-State: AOJu0YwDRymBxpVjiKzx5ARa7xao0ShWCfKi1kl5fU0JsZ7n3ZiajcYo
	fS9ka8PaWNDy46wUHeOai6h2RmADH03CCZ3ZLyARWFXEowuix348+JsE0aHoVw2GgZImGE72ydQ
	g
X-Google-Smtp-Source: AGHT+IGzpq+YuuOIP2PFUJ3vNl0MEGcLj5O6pGV4HEUMI9rYt73RXdKBpR8FRW+FrH9d3cp16wWxwA==
X-Received: by 2002:a05:6402:60f:b0:5a3:a9f8:cf20 with SMTP id 4fb4d7f45d1cf-5b7f58eb70dmr12836219a12.34.1723042958942;
        Wed, 07 Aug 2024 08:02:38 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb90be3a91sm2583047a12.65.2024.08.07.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:02:38 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 07 Aug 2024 17:02:32 +0200
Subject: [PATCH v2 1/3] ASoC: tas2781-i2c: Drop weird GPIO code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-asoc-tas-gpios-v2-1-bd0f2705d58b@linaro.org>
References: <20240807-asoc-tas-gpios-v2-0-bd0f2705d58b@linaro.org>
In-Reply-To: <20240807-asoc-tas-gpios-v2-0-bd0f2705d58b@linaro.org>
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
index 18161d02a96f..dbda552398b5 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -81,11 +81,6 @@ struct tasdevice {
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
@@ -93,7 +88,6 @@ struct calidata {
 
 struct tasdevice_priv {
 	struct tasdevice tasdevice[TASDEVICE_MAX_CHANNELS];
-	struct tasdevice_irqinfo irq_info;
 	struct tasdevice_rca rcabin;
 	struct calidata cali_data;
 	struct tasdevice_fw *fmw;
@@ -115,6 +109,7 @@ struct tasdevice_priv {
 	unsigned int chip_id;
 	unsigned int sysclk;
 
+	int irq;
 	int cur_prog;
 	int cur_conf;
 	int fw_state;
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 49bd7097d892..8a7fe48043d2 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -814,7 +814,7 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 	} else
 		return -ENODEV;
 
-	tas_hda->priv->irq_info.irq = clt->irq;
+	tas_hda->priv->irq = clt->irq;
 	ret = tas2781_read_acpi(tas_hda->priv, device_name);
 	if (ret)
 		return dev_err_probe(tas_hda->dev, ret,
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 1fbf4560f5cc..28d8b4d7b985 100644
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
@@ -411,8 +410,6 @@ EXPORT_SYMBOL_GPL(tasdevice_dsp_remove);
 
 void tasdevice_remove(struct tasdevice_priv *tas_priv)
 {
-	if (gpio_is_valid(tas_priv->irq_info.irq_gpio))
-		gpio_free(tas_priv->irq_info.irq_gpio);
 	mutex_destroy(&tas_priv->codec_lock);
 }
 EXPORT_SYMBOL_GPL(tasdevice_remove);
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 8f9a3ae7153e..f3a7605f0710 100644
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
index e79d613745b4..fdf0840ac6c7 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -757,7 +756,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 {
 	struct i2c_client *client = (struct i2c_client *)tas_priv->client;
 	unsigned int dev_addrs[TASDEVICE_MAX_CHANNELS];
-	int rc, i, ndev = 0;
+	int i, ndev = 0;
 
 	if (tas_priv->isacpi) {
 		ndev = device_property_read_u32_array(&client->dev,
@@ -772,7 +771,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 				"ti,audio-slots", dev_addrs, ndev);
 		}
 
-		tas_priv->irq_info.irq_gpio =
+		tas_priv->irq =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
 	} else if (IS_ENABLED(CONFIG_OF)) {
 		struct device_node *np = tas_priv->dev->of_node;
@@ -784,7 +783,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 			dev_addrs[ndev++] = addr;
 		}
 
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
+		tas_priv->irq = of_irq_get(np, 0);
 	} else {
 		ndev = 1;
 		dev_addrs[0] = client->addr;
@@ -800,23 +799,6 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
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



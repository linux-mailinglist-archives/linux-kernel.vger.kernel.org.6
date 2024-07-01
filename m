Return-Path: <linux-kernel+bounces-235691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232AB91D877
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A220F1F231FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2916F31C;
	Mon,  1 Jul 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvd6i+a/"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841A5103F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817360; cv=none; b=HEhOO2LzvXo8pnSGZt0bDehwMho3moP9zjeZZdlvuE7No3+GWCrgKW9PeSdHsUke5ulZj+ogN2Mzwtn/Il2ovCAvmBpAPMc0whcf6tUUZpHahKv0jNXUOVEiNAA0f+k1Uo6lGGNrHLMKBahZnO4DiPZcxX+8wfnRAavndO1MSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817360; c=relaxed/simple;
	bh=HoYOZ5VZZSoT1oPQmsk8ALI7brrvFdAyk8iW+8VaR4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UC+zoQ4HskFdsAVaVPE1P0dFQVdQ/H2oNNl4+rftUzX5VSBTKhI4cAlw0jnMtLr0eELYQrpVilVoHisLM3gRFCGR1RVSwi1gZpkBCiF6FAMFtbFuXhrYSmEpwZVwJ50fmwPsRoFL1JFkm0LZJiqq5S7PdqWrbYLjWkd7e+xZ2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kvd6i+a/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2835687a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817357; x=1720422157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0uxixe8SRdEtYS3hYnA/51z5ZCVTziscEpNL0ARHP8=;
        b=kvd6i+a/8KSSu0NKX5Qvd7b+ppJhT5FrDmuIKUHmKBGHhieikiXrm2al7Lj4b8vDBj
         nohdvVhGFBVNSw2U1q1V4QR/BDqKj9ll26StvJWYV/CQQI9i3m6YXG0/Y7oyQxz2f7to
         DBcscjENTIycKvdzyMd9k9l660kaaF0MaeCXsg27wcUf9Jrsqz19ubGKmj+v/foojqLN
         lxCJ8LNsIJX0KOQQMMjmRcl50YfWQlCWaeVuwMpc5Z3xKs0v5mbyy31oi1HFhs5OKPOW
         W8qhZnY8wGHL4yoY9mKwq5F5fHJierlkrCYrzZFie+JS62MzwwzX1bbi40e0a3RiUVJg
         4wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817357; x=1720422157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0uxixe8SRdEtYS3hYnA/51z5ZCVTziscEpNL0ARHP8=;
        b=lkSSwmXqf4Tyub96e3/FlawZc0vMSm8MG3Bzq99NhlIHkso1dyPEI/D0MjqlnUFCk3
         sc5/SRIR97upqjjIJqHSlQ4+fe0sRE38evpbYRmcW2HdsUrjLVmOuTvqF4huzCQPLKQr
         L4bRdopmXUAiRuTo4FdyTpTHZWJWQNAcpJTg4paVa7QyT2+j1cxKFiydUHjxfxT5uAzK
         n8aQDjAbeOQOhO98g0EV5b08IU5E7hXohPP/rxMqBVBlf2CuvCYikEXJm1YgTXPtR2Di
         GCQSL1x1UrvVqldJk4ZVbK3NyX9fcnIMFBvnI0EsYqOSc8EggBCxWuWAo5zvudy+Gt/C
         A3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUhAQOawt9PKnc/YVCUOSQSwcKPPntFmIGC8aYtrrnTGAiVpsLWmYXTODottjIOPvtEeVAttXWmYeb1bgt0NfTRWC7BV/MRPaAbQqai
X-Gm-Message-State: AOJu0YwrvzkiHVT76pVl7gGMrQbIRdgUctsYClKlJS9ULspmsg32f08q
	iU1l3DI27DMIF2jnDXVfKdYha2X45hgGHiyLyfSjaX0Tg5Mqroz+sRNldjywewg=
X-Google-Smtp-Source: AGHT+IFpmkqFIW4SYt5Bywcq02sj5OIw8F3oMcyUDj7GJ0VoQuAFnMl+7gJ97FBtnoFNiB+QfU/AHA==
X-Received: by 2002:a05:6402:2547:b0:57d:f9f:133b with SMTP id 4fb4d7f45d1cf-5879f0c4da6mr3053720a12.2.1719817357206;
        Mon, 01 Jul 2024 00:02:37 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm4034383a12.34.2024.07.01.00.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:02:36 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 01 Jul 2024 09:02:12 +0200
Subject: [PATCH 1/4] ASoC: tas5086: Convert to GPIO descriptors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-asoc-tas-gpios-v1-1-d69ec5d79939@linaro.org>
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

Switch the driver to use GPIO descriptors.

Notice that we let the gpiolib handle line inversion for the
active low reset line (nreset !reset).

There are no upstream device trees using the tas5086 compatible
string, if there were, we would need to ascertain that they all
set the GPIO_ACTIVE_LOW flag on their GPIO lines.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/tas5086.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 6d45df3b9ba4..4bc1fdd232bb 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -24,14 +24,13 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -246,7 +245,7 @@ struct tas5086_private {
 	/* Current sample rate for de-emphasis control */
 	int		rate;
 	/* GPIO driving Reset pin, if any */
-	int		gpio_nreset;
+	struct gpio_desc *reset;
 	struct		regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
@@ -462,11 +461,11 @@ static int tas5086_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 
 static void tas5086_reset(struct tas5086_private *priv)
 {
-	if (gpio_is_valid(priv->gpio_nreset)) {
+	if (priv->reset) {
 		/* Reset codec - minimum assertion time is 400ns */
-		gpio_direction_output(priv->gpio_nreset, 0);
+		gpiod_direction_output(priv->reset, 1);
 		udelay(1);
-		gpio_set_value(priv->gpio_nreset, 1);
+		gpiod_set_value(priv->reset, 0);
 
 		/* Codec needs ~15ms to wake up */
 		msleep(15);
@@ -867,9 +866,9 @@ static void tas5086_remove(struct snd_soc_component *component)
 {
 	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
-	if (gpio_is_valid(priv->gpio_nreset))
+	if (priv->reset)
 		/* Set codec to the reset state */
-		gpio_set_value(priv->gpio_nreset, 0);
+		gpiod_set_value(priv->reset, 1);
 
 	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
 };
@@ -914,7 +913,6 @@ static int tas5086_i2c_probe(struct i2c_client *i2c)
 {
 	struct tas5086_private *priv;
 	struct device *dev = &i2c->dev;
-	int gpio_nreset = -EINVAL;
 	int i, ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -940,12 +938,11 @@ static int tas5086_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, priv);
 
-	gpio_nreset = of_get_named_gpio(dev->of_node, "reset-gpio", 0);
-	if (gpio_is_valid(gpio_nreset))
-		if (devm_gpio_request(dev, gpio_nreset, "TAS5086 Reset"))
-			gpio_nreset = -EINVAL;
-
-	priv->gpio_nreset = gpio_nreset;
+	/* Request line asserted */
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+	gpiod_set_consumer_name(priv->reset, "TAS5086 Reset");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
 	if (ret < 0) {

-- 
2.45.2



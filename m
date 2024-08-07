Return-Path: <linux-kernel+bounces-278109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4994AB1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76F31C21824
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B2824BB;
	Wed,  7 Aug 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjM1C5kS"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F484A5C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042966; cv=none; b=gg1x9b28uzhUmrBNGPdBkjjB2IQ0+EuQzWDRJQoKhYbmYCxBK43iT5gN3VYFfdmsHsKij7DUIAG0+CKVIvq+riDARlYtZYnRtMOT55RFrfcOhrQ5wYrj5n3GJ749+JYWTd3/gr88y8GOKkbkroQbMLPdTtyrYBJoSGIyjmf2+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042966; c=relaxed/simple;
	bh=Y7W8wbrOkuNmZ8CQ0WcwZSJsXls2By5/tn0Y2KGbT34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHFjZibw/5CEXJLTOCFI5flMW5eoLefwdIUAnqMy+fK7sWGeWujPtlT54wT4JaeVIm2FbL/V0zZxxPT3GZbs9/Mwl3lBzXGFB/+thWIhZp0drXkeWnjJF4NockxD/xENQsNiJPVqjZN6qmQ64iEGI2Dd/gOx4JbsAjFN2WkPznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GjM1C5kS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso2310305a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723042962; x=1723647762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPaeIu/7/ToaPftt+nmZwaEM7lBvNV082estk80tIAQ=;
        b=GjM1C5kSf+SfapsFA4MuOL0unWnYAvVxP+sq96PLrXGdWi1i4JS+zA6nC8uyRJdZ6C
         zMh1xba5jQbFiDfKeBi4VxiqcnemXs3CBjNLfvvCKkMbNSOMAQcDp3t7iUB54XULDWJ3
         TKzxaruJMd8h0yaIQFihOm7bzrNWZPso8x8wMEzNJcLHpKx5P5K2FZvcaEv0E4BTtQhm
         mLU6ouxmIbzKEXwRkMYUrJovKqq8euTsNfwswkuRcOVCrYyMCrtHaqg4dPbBl2J7gO+S
         pQDMCfd6Z/DH2kshXfGdwmPDD6+CQMwIuzSLuzWJyZmheT1V9sWUc4m0yvTvKGamC7/Q
         Q/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723042962; x=1723647762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPaeIu/7/ToaPftt+nmZwaEM7lBvNV082estk80tIAQ=;
        b=upKA9A1tsxJWRbG/HBTFasWDsxdNANm3ZeWft/65wemSI6unOkPCrC4Ay9wx2mShbp
         BK+sVRrI6uUqaCysquaY+2+4hFo9GQpX8fz0YdrBG23hrCQQmm836ksUOUJLjfG8FSTD
         vmZjc1nAELmP0R4E5ankW3JP7EfFO6QAzkSkquPkWA2Gb1SJmRol/APpxWeHvMFxnHxa
         vSxpaUNKrIK6D6P5mtGBIuRLUN63bXZpjMYwk/ZhUVBsXpXgQiymjuLW8OCuKmGSs01Q
         wuX6z2QTNdc01SpU7YI4ZxqecaNLu7SPWjx17ceN6hlZY1lx24o0l/CU+DGNlj1rSBx5
         ghNw==
X-Forwarded-Encrypted: i=1; AJvYcCUbb/TMxHpSvAv4bUCnT64xBRycSVRVZa2Lf0Ik1QNfkayoTxyoiyqP6aF10gPrIstCSo215y5KbwTwOgKrp5DrjdhD3h59Y4TUJvJ4
X-Gm-Message-State: AOJu0YweoZhrLs22FUGC5nzAtNQwohNyM4Z21j/s7wJGwCu8xJDvvH15
	Gyj3Wn7brwvUILgtDLVoqdowK4J6bICaJS7kDmw+0JS5zMEzlA2wgINnTC1Hq17grbpFyYblvyA
	f
X-Google-Smtp-Source: AGHT+IEYpjjpJDMbHBEqI4Rw2M2UUag+5UjvthzgGzzeXam2hAGeCohE28/rAsaJU5XDD5v2iV+kRw==
X-Received: by 2002:a05:6402:331:b0:5a2:2654:7fd1 with SMTP id 4fb4d7f45d1cf-5b7f59e04d9mr11178515a12.36.1723042961586;
        Wed, 07 Aug 2024 08:02:41 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb90be3a91sm2583047a12.65.2024.08.07.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:02:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 07 Aug 2024 17:02:33 +0200
Subject: [PATCH v2 2/3] ASoC: tas2781-i2c: Get the right GPIO line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-asoc-tas-gpios-v2-2-bd0f2705d58b@linaro.org>
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

The code is obtaining a GPIO reset using the reset GPIO
name "reset-gpios", but the gpiolib is already adding the
suffix "-gpios" to anything passed to this function and
will be looking for "reset-gpios-gpios" which is most
certainly not what the author desired.

Fix it up.

Fixes: ef3bcde75d06 ("ASoC: tas2781: Add tas2781 driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/tas2781-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index fdf0840ac6c7..bac5ea6d99b9 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -793,7 +793,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 		tas_priv->tasdevice[i].dev_addr = dev_addrs[i];
 
 	tas_priv->reset = devm_gpiod_get_optional(&client->dev,
-			"reset-gpios", GPIOD_OUT_HIGH);
+			"reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas_priv->reset))
 		dev_err(tas_priv->dev, "%s Can't get reset GPIO\n",
 			__func__);

-- 
2.45.2



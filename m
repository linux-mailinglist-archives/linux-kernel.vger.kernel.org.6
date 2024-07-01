Return-Path: <linux-kernel+bounces-235693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230391D87B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AC1283474
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C7823AF;
	Mon,  1 Jul 2024 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSA4RBaT"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847139855
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817365; cv=none; b=lHslOXXqJ0fjjX2/rctqDNvpxJKfJ18/F3lS/iqvxTU3NzvlyznsvmXY1genPyzgU/UmlwbKUZEE1eRG64drmd2CC75SmSTFZLP+YL92TsMFzz0znYtSrA5btmHvfnuh3lyALgYxkCzbmsiBSLTQ6zD9GQgMSV5hLFvbT2Q4Apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817365; c=relaxed/simple;
	bh=pcOvFSy9mqnG9tdnejsIswIHJuVcxQ0Q95HAQWqfY2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9IywrrcAWcNyYJeFcNb3KR1Hsbe9FMobXiM3fI2Gqg0jTiGaISoLdRM0NV1QoW3V+3FfWN7XWuLK79E5h0S2/O0Q7Yq/K5/dnbCuV/zhp/IsTNxigNaNwZiqyc7S1r0uMLcqXMtRYGPHc3kACIHvqZpQ/za5ju0rJAACR8GIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSA4RBaT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe785b234so25790971fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719817361; x=1720422161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWt7xul9gaEWvRdXPJZ452zrHt44xP6eq1TOlG30kGE=;
        b=oSA4RBaTJCLVkTNLkMcohSiSe9qnXixHSiIAQlAgPpi0C/yxy2sLFIvKiukccxoEy3
         PFFCDnUo5MbW+mdqoPPBSUlu6+8AQFI9DhQzCZLfbGcGoUa7O2X24RBFZrzDWb18J2tV
         yPmYmAnjYDplRK1NEXrDAOPqBrcF8CxkvQBHXeaXFtO3pyVAZV+qHU8hybUf00UDPCjf
         ZqJndefvhluHRLd2FLnCrTiXFqdMi1Sn297sv7QOcYzyDWKF1OY5VPdYNunVBnpJsPv4
         STg+BFnKD5VYUVd9bxj3VpSsZwjCGJ1ZSR3CSekIwJOUZIIoSlcm4GhF1UaVyliFGoJW
         D5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817361; x=1720422161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWt7xul9gaEWvRdXPJZ452zrHt44xP6eq1TOlG30kGE=;
        b=QpBlhx9BzpQPTyeFSkIuMNihZu0srC1Zr1OsWPuHoQPcpPhyhCmZDgRILe6ClDEQ0r
         8DBOoBFfyegvHDaCmcKGPuqUrD67mo6KWEC9wTCa3I/UeUbJQTwMuYctsO0sNE9GlqkJ
         tCevM5rO2po2fqp0QfkVJu+nU/7rVUoR7puk3IvbOJ6TCm26xe+yxaB4ZWgRr9hKpa47
         knmNjlGvTjmYJedBh9h+gUYXxEbkikMP4KcN4Po+B7pC5SqeRuVv5QBBStaBvMogZgGT
         fHrD3//O6bZUUs9V0WkyfH9gswbkBqWgp1ZC1C4vik1q4tH8LBiu/PiLAn1gMyc9Ys1/
         GQzg==
X-Forwarded-Encrypted: i=1; AJvYcCUMCHHt/JI3v7mTUr0z1Vdzb/FmsIS/6I9XdkphbNJsJS+84ELKa+qU+Jg/0Px2WwpisP/v/vZ4Cgsj/LQt8vigzbgrG64Eh11CovRo
X-Gm-Message-State: AOJu0Yw51Xcc9o7+Kpo+q0KKm6uRybai1dQ4xqfLdweTQTDpsl1Whbcn
	zA3QmQATVs2LvLh2vzfFUtlpAgJUkxEPpmaMkKmr7hSCf0nPyylJY8qEBVjg5JE=
X-Google-Smtp-Source: AGHT+IGPE6k3N5wdR11ZQ2KZFoj1Q7gGsWsY0UPRVz0U0AfRSYWIhLPL3AI9jKB/vygyWqnZmYfNvQ==
X-Received: by 2002:a2e:a801:0:b0:2ee:4c2e:3d3b with SMTP id 38308e7fff4ca-2ee5e390286mr44525361fa.4.1719817361254;
        Mon, 01 Jul 2024 00:02:41 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861324f036sm4034383a12.34.2024.07.01.00.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:02:39 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 01 Jul 2024 09:02:14 +0200
Subject: [PATCH 3/4] ASoC: tas2781-i2c: Get the right GPIO line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-asoc-tas-gpios-v1-3-d69ec5d79939@linaro.org>
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
index 1542915b83a2..256f2e8f1ba9 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -654,7 +654,7 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 		tas_priv->tasdevice[i].dev_addr = dev_addrs[i];
 
 	tas_priv->reset = devm_gpiod_get_optional(&client->dev,
-			"reset-gpios", GPIOD_OUT_HIGH);
+			"reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas_priv->reset))
 		dev_err(tas_priv->dev, "%s Can't get reset GPIO\n",
 			__func__);

-- 
2.45.2



Return-Path: <linux-kernel+bounces-217635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E292C90B26F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52461C240CC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1741CB334;
	Mon, 17 Jun 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uPhcUNEQ"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76451CB313
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632234; cv=none; b=RAHX5+enoicA3PX+5vlLsp3EqzixcqWOMK4Ine0qgqKXhv4dDpbfzRP8x0OAAsKvcezbPzWOb36nZzPh04niZTMkdXYl/mdnbZ41C5oOfwqx+O73rl3RpddjjZF8OZ34+wKCAJ1XhLRB4EizQOp9imXxI+12TnpHIqvgnqT8z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632234; c=relaxed/simple;
	bh=vYvxwaeOXd9WIOr0jyiodES08IYnBg0cNG1tIcDEAbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrpxP1Lx3YuJqA8fs2aO57OqsEyk5EDr0H7N5zqrxDfBwJN7xQO8hPIxXErbXQHZ/qyQzn6GsWgebMmTIPNknfjv++VE78JD44CTy5PkWZgf0KcoPDWUJMu62RnVd7ACXnvIh4Un0M9et7VcfYxA2i3d+EDlji0n4RVM9aUFees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uPhcUNEQ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2277782fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632232; x=1719237032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPhEFIEI65Agzd+gTNE/8pf9Wc0auEQHD6gWw+Mp2Us=;
        b=uPhcUNEQpZaL7TjxVfRpIlBjUf8o16RoIf9j7grR+rzfj0Ati5+Wf0Hj5CFtxKt3Ku
         ISyeqRUkxzFRi8pN2b0qzoQiSakDEziYgMUL+kiNeHorGjI8J4tQsVlk7g2ooJqznZhC
         VCh2ac+6IlBy4EOC9IFjQxLh8qTJ8Rlcv2snvx4N5scMVKCvLfCS6WnGSohkNKcYtB9h
         HaPDX4dzhDNB4079IvhWREg6qX0LsnB/UzHJbTrsudgA0XsOw6KIApx9+R4zmr39vtWO
         sB4ENfOZGYoUsUBMy+8FWIUCL8hweB/YaXVvGCDVUfEAP81segP5ebk69xnZR4h6Mopz
         pdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632232; x=1719237032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPhEFIEI65Agzd+gTNE/8pf9Wc0auEQHD6gWw+Mp2Us=;
        b=p5dsep6tDyf/W0GiU4U3PIsiel4ortW3UvH96Oop38aiDRk/1LA5lOXT5ZwNw799+6
         RBwbZKoDRxMBUUBlYOK5f/S0ZtfxprI3ah3AUy5ZAi1nJq+LIJAiGSJJW5z5WyF9lgt4
         nke5n7EOw8apEnr3LPsKfHBaGkTk6SA1S2ijp4aKs6zmQmAJfxPFJaquGdzVdVqXct0g
         wXLef95PdWDtSrf1SdDd9ziMcmWoH/xrP9C4UyDEpSD5pVLaA0zWLDnnG9you3VMlNuv
         J2acTZ3utgqJP8qFlnifd38Xl7inmYvAITt66xYK8SmYy7om9Za01LcgXi0tL3MXaOvp
         8e9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjVeGYhezGp02tcnfg4X6uITRTjX74sxaBEA2L/s0PyN3pcNaKAWELceVH5kVwl8wikDdTvfoSLPWH4uy4kvbBSOA0G7B3G3XhOcX5
X-Gm-Message-State: AOJu0YyifAE/EDeDNfK1ENJSCU3PnhRnq6bd5Mjd7QibH9C6WWPs00rl
	VM5N+5kc/Nb8ho2A8JZwdDgAyASo65TuLEo6O92pZCmZwM+6SIwlnPkUZyJTwSM=
X-Google-Smtp-Source: AGHT+IESOlQlf6WzweXkTkf8MrnVQGCcG3xC67OqCrm+RTbQElgJSgw2YCA/KexywnTT/s9UGGqyWA==
X-Received: by 2002:a05:6870:c1d4:b0:24f:dd11:4486 with SMTP id 586e51a60fabf-25842ba209bmr11672904fac.36.1718632232087;
        Mon, 17 Jun 2024 06:50:32 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:31 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:02 -0400
Subject: [PATCH v3 22/41] iio: gyro: mpu3050-core: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-22-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/gyro/mpu3050-core.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index a791ba3a693a..ff1c81553045 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -197,8 +197,8 @@ static int mpu3050_start_sampling(struct mpu3050 *mpu3050)
 	int i;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET, MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -513,12 +513,8 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				 "FIFO overflow! Emptying and resetting FIFO\n");
 			fifo_overflow = true;
 			/* Reset and enable the FIFO */
-			ret = regmap_update_bits(mpu3050->map,
-						 MPU3050_USR_CTRL,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST,
-						 MPU3050_USR_CTRL_FIFO_EN |
-						 MPU3050_USR_CTRL_FIFO_RST);
+			ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+					      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 			if (ret) {
 				dev_info(mpu3050->dev, "error resetting FIFO\n");
 				goto out_trigger_unlock;
@@ -799,10 +795,8 @@ static int mpu3050_hw_init(struct mpu3050 *mpu3050)
 	u64 otp;
 
 	/* Reset */
-	ret = regmap_update_bits(mpu3050->map,
-				 MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_RESET,
-				 MPU3050_PWR_MGM_RESET);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_RESET);
 	if (ret)
 		return ret;
 
@@ -872,8 +866,8 @@ static int mpu3050_power_up(struct mpu3050 *mpu3050)
 	msleep(200);
 
 	/* Take device out of sleep mode */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, 0);
+	ret = regmap_clear_bits(mpu3050->map, MPU3050_PWR_MGM,
+				MPU3050_PWR_MGM_SLEEP);
 	if (ret) {
 		regulator_bulk_disable(ARRAY_SIZE(mpu3050->regs), mpu3050->regs);
 		dev_err(mpu3050->dev, "error setting power mode\n");
@@ -895,8 +889,8 @@ static int mpu3050_power_down(struct mpu3050 *mpu3050)
 	 * then we would be wasting power unless we go to sleep mode
 	 * first.
 	 */
-	ret = regmap_update_bits(mpu3050->map, MPU3050_PWR_MGM,
-				 MPU3050_PWR_MGM_SLEEP, MPU3050_PWR_MGM_SLEEP);
+	ret = regmap_set_bits(mpu3050->map, MPU3050_PWR_MGM,
+			      MPU3050_PWR_MGM_SLEEP);
 	if (ret)
 		dev_err(mpu3050->dev, "error putting to sleep\n");
 
@@ -997,11 +991,8 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 			return ret;
 
 		/* Reset and enable the FIFO */
-		ret = regmap_update_bits(mpu3050->map, MPU3050_USR_CTRL,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST,
-					 MPU3050_USR_CTRL_FIFO_EN |
-					 MPU3050_USR_CTRL_FIFO_RST);
+		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
+				      MPU3050_USR_CTRL_FIFO_EN | MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
 			return ret;
 

-- 
2.45.2



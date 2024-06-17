Return-Path: <linux-kernel+bounces-217656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0C90B4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B001B2DA15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350D21D2126;
	Mon, 17 Jun 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hZXZGfed"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04C1D18E6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632273; cv=none; b=Q8Up0fnmfb+Rwt2nx7hZdR6RueT9439i4MMsojpSsxdA4ZKW+a8qA9ZwVj8FvmNRi0GJLMBZwioeqIOR9/x928B8uIvohw3dikEYwWEW9sTAUwzFMmb8mEu4gtni9tkCrKrhB8srBJg97p+xUbGDnF7LLUBOkvp/ss3dx79iapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632273; c=relaxed/simple;
	bh=/iTmUukNGLPGvGh+5363cpZBdKYe1qLwwMB3hsIs3J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EykoAq29jn79nRJNPUJjpQ3ErHQg2XVyISJS1FicRq5/ctr4e0eKGSa6scswdlUzmb3JnD9mo5UW6X5VEly+HqYd38TGbg28S/NYwC2wzFNpoL0b7SdRyJqGhRqCrgBlphe12iIsG2yQ0sY+elJf/CDmq4V9/RT1hxjuZhyYdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hZXZGfed; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7954f8b818fso290944285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632270; x=1719237070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYef8rADT2ijxxEcxYPLN7/oRY6yNh5EaRUGzmb2a/I=;
        b=hZXZGfedqGZ/DvNsGkX5tE4xAdw1NkCaAByg98DAM6mRkVK+7hhc9IDOL7MDFFarr4
         4SnGUKI3mGGx6x6o8Mjo3PUErArmkWud2UV8xZJ5R1B3dMHdN2kX2zXYviJwaCzc7NA9
         irPcuixmQBa5s3/YTD8+4dPuWHgUVo7/tvZHfpVrukT5TiJCo2Cf9jUpXYjNHlLp7466
         dML4fLqKWyjFQfJPH4o4bmsTyYRUYokC7PkGTozMB0YPD+InMd1Iwb4/7bjB4D/hPB9K
         CATwehPSVMi6RiZY72TtfCjH7A/j3JK5A5DHXHMEVmtKczhzOCyTJPtXnTJV5lzXZ4iJ
         3Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632270; x=1719237070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYef8rADT2ijxxEcxYPLN7/oRY6yNh5EaRUGzmb2a/I=;
        b=raGI9dT5uvAsOWlajT5vvsr6B6mp7/e0jjchBzNIq/ZKYWTgRXU/Cf+U48xRPuqvzl
         R8lZNcya+6LLE7lqDq1YGre9wuYYb4X+RJKJok+3L1cqhH9FTLszGZF61xs7rECLHnY0
         Q8RIpVQiT2V940Zl/hLFlKgBiAvmrzaTwLLd37XKHyrL+xkCGLhkG07GwHt9nrcn44Ds
         Gl8iwgu/6EgIE0egcdJ3w1Zf5Ji3TxRiA6ZiYgMyXN3KLGh8fztUq3+4E2wxtbXXuWJD
         5iiRSbHfI2Ah3p2H8yaKaWPx2lwvuLF9EOK8h6VoKGLLVNzXKKO/ADRgOUT7eeWNeRfA
         lPTw==
X-Forwarded-Encrypted: i=1; AJvYcCWGFYqjCOelxXMD6db2eC2lpCVeH6dDhzhdM3wIRpShUeJDn8SF4a9fZmBj6DOxnN8Akpfw/YWthWixZ1Ntp1+1uZO8w55yt9oEzUvk
X-Gm-Message-State: AOJu0YxgqlJtUJ2wsd8GkmUKaI3SMF1xmskjrNEfA/aB9g0CLmEYuRO6
	roLOICpMrDa5xV6FmPYcTNB94LyaxIk5DLNo/BB4wcWLFxS6yIic/eHRgcM0AzQ=
X-Google-Smtp-Source: AGHT+IG+NTpXbmfTtgLV5kgHRYZJqicJgvBNrkkmD2PI5YKClqNlpZ4QFEOEqllRaBP9Jcn3G+Ldqw==
X-Received: by 2002:a05:620a:24d5:b0:795:50ef:4030 with SMTP id af79cd13be357-798d242f345mr1050763085a.41.1718632270523;
        Mon, 17 Jun 2024 06:51:10 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:10 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:20 -0400
Subject: [PATCH v3 40/41] iio: temperature: mlx90632: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-40-88d1338c4cca@baylibre.com>
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

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Acked-by: Crt Mori <cmo@melexis.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/temperature/mlx90632.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 8a57be108620..e7de30f613d2 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -334,8 +334,8 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	unsigned int reg_status;
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
-				 MLX90632_STAT_DATA_RDY, 0);
+	ret = regmap_clear_bits(data->regmap, MLX90632_REG_STATUS,
+				MLX90632_STAT_DATA_RDY);
 	if (ret < 0)
 		return ret;
 

-- 
2.45.2



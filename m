Return-Path: <linux-kernel+bounces-217629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC790B25A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095E92846BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0901C689B;
	Mon, 17 Jun 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yVl15yCM"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C91C6881
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632223; cv=none; b=I9Fx/nBh1eRAYE+NzQL209iUl7XI+CDuTkBCuYbE6RqOCFf5wmeCCp6mZIxSMMcO5rH6YtPzup+gJ+VuNXcyl/sNFcv4sNBIWByQU1qCtizTtvO3wUCM+9qvYGkToAtiWedIbKOt4i1Q0FE67rwL/+fnIq5OCB+p+yASxqvQHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632223; c=relaxed/simple;
	bh=iX/O4thw4u8jxmjQXCGvy7+RStVKhiFFxFMRaqR3WK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u58Xj5VtkRjJ1dHzeTIVMBa4vBLVd5Y2zqI1zBRCT7cf4niEdHL/SJm95XRDspizxmGcZZJTx2wnyzsf6PNoKgJlE5LR9a3GI3IiJPtDuFPP+ln7af1gxu2CvRUMlyaUvrER8dWeftRaJWSRYVoUzfFeGYu8jfQtRKPLbFILaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yVl15yCM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-254e42df409so2771069fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632221; x=1719237021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pghOqqoUrgqxulm8czqYmTg2ejQ+jCMFTS9OcdLe8gI=;
        b=yVl15yCMx8Rq/yn6JRv0Mo+5clGun24H2X3e8y0JsohuP7YFeLbjUgh9HBDNbFDlj5
         4gDa36qo8A9rV0LK6MXn4bT4zitpJcoA3L5KD3A5ea5uHcaiiaOM52Yz3+GUKe4YPGoN
         y26OSFMb/+ZFJDSX8cvcy10F6Mm8S4AE7u8X46xtjsfgN1PU6ICW9BqanAZbmrWZI3vS
         0AGwqBkdrjzF9pchQ4ar3F9+QM/M3FkigDqdQuM2xmRNWX7vMvgoWFMtemzlbpGfGGJY
         XGwFcfqW/zvgbajkMK4ioRFBQ4DWDK29gKr9RMZd4jKTJDPwme9dGXMU4R7HIDqWFHK6
         EhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632221; x=1719237021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pghOqqoUrgqxulm8czqYmTg2ejQ+jCMFTS9OcdLe8gI=;
        b=S9WW9Lm1yNFuQw4rDzIUd0tSQ6hKJtTWGTQNQXw/hiohEdzMN7iNL6ASQLOD1xTQ46
         XnUE7iJ4ejlL0FBTqpKpDTCFT0QJn/FB2RGInF2v+AuP/nZsFINKxNkSXjM5G8ND6Jg9
         M4VaRTE+aAKFc6loRcxwMagm9ghYCYaLjRlFAGznAkxNF8hPDm2hpL5GyHcYvK7qh2rH
         FQwqOuQivpE1VeuV+PtgQHJp5QNDsquFPgRanBCA9K3h+OjcZjXfAFMd7ylOMnVMpojg
         vQUzeW64Y5JEK4jrbYHyR+Y9AjglW64s/mfHjKZss1btcz9QQK4KSz5SYAuy2/GdTIC9
         GMrg==
X-Forwarded-Encrypted: i=1; AJvYcCUsKVRFKdM7FJydK4y20pGM9eOJ2H7rxikYmHe1jqJ4gkrKc4Hdu1xzYJI54FmhBiCsrvmLELqBzB1RgFAtdxFghhnVmGHHM5gXRspk
X-Gm-Message-State: AOJu0YyaT+BIKioCPa8MUQcjtMG6G33ec1cv3XIPfZXH515Z9SAqeURI
	F7uo9MzPMosXOpSM9Qqy3GNfSLWcXwSeTGv1YQqInMAnd1I1aapfmpWTuxoiX0c=
X-Google-Smtp-Source: AGHT+IHPRFjhQJMl5A95ZWgXFtrQQKsMmXYW6RVDp9V1gMjS9xuHYY98wxPGrZXsyYueeiP6Xe3wcg==
X-Received: by 2002:a05:6871:5c9:b0:254:94a4:35d2 with SMTP id 586e51a60fabf-25842b7af81mr10339918fac.45.1718632221358;
        Mon, 17 Jun 2024 06:50:21 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:21 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:57 -0400
Subject: [PATCH v3 17/41] iio: adc: sc27xx_adc: make use of
 regmap_clear_bits(), regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-17-88d1338c4cca@baylibre.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/sc27xx_adc.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index b4a2e057d80f..2535c2c3e60b 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -508,13 +508,13 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		}
 	}
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-				 SC27XX_ADC_EN, SC27XX_ADC_EN);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			      SC27XX_ADC_EN);
 	if (ret)
 		goto regulator_restore;
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
-				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
+			      SC27XX_ADC_IRQ_CLR);
 	if (ret)
 		goto disable_adc;
 
@@ -537,8 +537,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	if (ret)
 		goto disable_adc;
 
-	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-				 SC27XX_ADC_CHN_RUN, SC27XX_ADC_CHN_RUN);
+	ret = regmap_set_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			      SC27XX_ADC_CHN_RUN);
 	if (ret)
 		goto disable_adc;
 
@@ -559,8 +559,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	value &= SC27XX_ADC_DATA_MASK;
 
 disable_adc:
-	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
-			   SC27XX_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->base + SC27XX_ADC_CTL,
+			  SC27XX_ADC_EN);
 regulator_restore:
 	if ((data->var_data->set_volref) && (channel == 30 || channel == 31)) {
 		ret_volref = regulator_set_voltage(data->volref,
@@ -765,15 +765,14 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 {
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, data->var_data->module_en,
-				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
+	ret = regmap_set_bits(data->regmap, data->var_data->module_en,
+			      SC27XX_MODULE_ADC_EN);
 	if (ret)
 		return ret;
 
 	/* Enable ADC work clock and controller clock */
-	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
-				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
-				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
+	ret = regmap_set_bits(data->regmap, data->var_data->clk_en,
+			      SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 	if (ret)
 		goto disable_adc;
 
@@ -789,11 +788,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	return 0;
 
 disable_clk:
-	regmap_update_bits(data->regmap, data->var_data->clk_en,
-			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->clk_en,
+			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 disable_adc:
-	regmap_update_bits(data->regmap, data->var_data->module_en,
-			   SC27XX_MODULE_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->module_en,
+			  SC27XX_MODULE_ADC_EN);
 
 	return ret;
 }
@@ -803,11 +802,11 @@ static void sc27xx_adc_disable(void *_data)
 	struct sc27xx_adc_data *data = _data;
 
 	/* Disable ADC work clock and controller clock */
-	regmap_update_bits(data->regmap, data->var_data->clk_en,
-			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->clk_en,
+			  SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 
-	regmap_update_bits(data->regmap, data->var_data->module_en,
-			   SC27XX_MODULE_ADC_EN, 0);
+	regmap_clear_bits(data->regmap, data->var_data->module_en,
+			  SC27XX_MODULE_ADC_EN);
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {

-- 
2.45.2



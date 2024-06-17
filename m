Return-Path: <linux-kernel+bounces-217618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EC90B231
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF1F1C22C63
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FF1BD010;
	Mon, 17 Jun 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rOTG6Jg6"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF61BC076
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632203; cv=none; b=fWzu7UfBsD/c4dkt2AxPSR5H1JQF7w0TgoTF80OcACUccP2+MoCuj/37EsDskXi7a8QL2+rbrZlg14v3Bk86CMianPL5HMbHLiDJltS81aYf7jgEhhDHuMI6paZRgXP0fHWV1qwoXWisi8N73gXTwb1ZWidzGuhyN7XspLTHuaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632203; c=relaxed/simple;
	bh=StudXC8HM5AaA51joNKIseNwtqaK04Fr9WYaAPBMqi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQ2KJ7hBnjCjuNxN/Z2i9Fgac1uiBrnCGo+eGtty/5Q7EVlq6r3+wbmNepEIOMuJqM/DB0joZ1zaOT95jUBUrhVG0U8EbqndLTPgtMvrz7nvwF5H7NB0GOk45ZMK0KkSnVBxGkdl94Ev1PF144hCMPN4OT5wGgYTk1j4JUWP51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rOTG6Jg6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-797f1287aa3so342720885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632200; x=1719237000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrcJbk8xCEXw8t4EaXrcTeVF+NCC1LSKzcpZFP4BG5g=;
        b=rOTG6Jg6AFDvVQuvhTCMgfNkzi7Kzm7o+vUGfVhwN7vuApciSL3d4JkEooKRzezAnl
         kgU2Abrb/yPqufSoeGsqocss7K6YGumoYv8mW/FN8wsDrILqttu8APaBqglKtx3GRpwR
         10KLQphkQKUKTQeQoUQaTpN15YuRqUOJrKgg9lQYcmP+BurmG45MdHwXtdG79lX6B99M
         MhEIWn2xpq2in4srZC1z/j8rMuOcu7g6guEhaqZ1z+B4MebhQKCTPHuaWHaZP9qI8VPI
         khM5IL2/o1PWaMIPCVowUG6XGaTfZoVwNTWFknN09Fy5FHT1d8stbiiMMVL+JG7Ki3tN
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632200; x=1719237000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrcJbk8xCEXw8t4EaXrcTeVF+NCC1LSKzcpZFP4BG5g=;
        b=pDTR1/Hiolf0oO26WHILq24l7kWUmO9PyNN9NSyhAgjiT72XJAdrspewpE73W5hDQY
         hKs8xLxvBm+6jSrmtiMI1F8B4uD5gzikL2qLqeLgaHrIJ/sGCAdNAP0D6PeqElorhNfZ
         RVqi2wVur1BtltH9yPTQa52qRHVc2U+4p22h85mVVlEyqY2P/M7uGTZOsf4fbaxWGAnS
         RkjbwYYURMpkf3enFlCNoNL7BI31sFaDowJFCkz5iRkAjmHn6l/rNH7xiXVEVfg/uzT4
         euRj5vEXF34BoKbjC9iiGOaf0tJ3eD94B4TSf/G40OXZRdGsP7aoErt01AAYXjQnE3+U
         zAdw==
X-Forwarded-Encrypted: i=1; AJvYcCV+aqNk4SeJTtFGx/kloxv2qXiURmIdqIghAZ/+301Nt7ZgapIVMeOL91aqrcSFe3b5eAK1LEKJhXhfaSRVV9QaO4ULsPE2swZG+oE/
X-Gm-Message-State: AOJu0YwOWf4VcexXd9Eg+81xqi5IaBVpvhidAWgmaL2va0XNwzGrI97h
	W/qPgQkovYZ9cSSiMibQgOP1w3rPdTG4q/BDlOH+kjTzOkqQa+4DLiIPJ7ZiT94=
X-Google-Smtp-Source: AGHT+IE5uBXfLurzd0jxJqKEavsP5xlBerQNz/5zZPhVz/sS8JYp4QTVcbxX+BgweFysUZBWMYLagg==
X-Received: by 2002:a05:620a:1a81:b0:795:4e35:ea9d with SMTP id af79cd13be357-798d2692fc4mr1312471985a.60.1718632199656;
        Mon, 17 Jun 2024 06:49:59 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:59 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:47 -0400
Subject: [PATCH v3 07/41] iio: adc: bcm_iproc_adc: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-7-88d1338c4cca@baylibre.com>
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
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 5bc514bd5ebc..6bc149c51414 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -357,8 +357,8 @@ static int iproc_adc_enable(struct iio_dev *indio_dev)
 	int ret;
 
 	/* Set i_amux = 3b'000, select channel 0 */
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
-				IPROC_ADC_CHANNEL_SEL_MASK, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_ANALOG_CONTROL,
+				IPROC_ADC_CHANNEL_SEL_MASK);
 	if (ret) {
 		dev_err(&indio_dev->dev,
 			"failed to write IPROC_ANALOG_CONTROL %d\n", ret);
@@ -543,8 +543,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (adc_priv->irqno < 0)
 		return adc_priv->irqno;
 
-	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
-				IPROC_ADC_AUXIN_SCAN_ENA, 0);
+	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
+				IPROC_ADC_AUXIN_SCAN_ENA);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
 		return ret;

-- 
2.45.2



Return-Path: <linux-kernel+bounces-217624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC290B245
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7189F1C22D55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D61BE87C;
	Mon, 17 Jun 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lYH4wYUR"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D61BE24D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632213; cv=none; b=rbxstpJHfoTIO/R2tgMofA7OSi9b/19iRuh5aeeXK33S6/hjIO/5Ws2rQko904kOMhLVtC+suFgFaJlTyYIn5SJCuvGqHMUYqisZJnRiVOLBSliudDxJZxo4O0MemaXHQbMdfpXRKIC3HO9WaAHKx0Naw8o1WWDebGQE1deQwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632213; c=relaxed/simple;
	bh=38T/q5mgwk2j8HZtXOQWhbPXZHF8GM5UZOsgQFkjGgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVp3qNNyBmOPCl1T08GrGLChXG5UFonTutYgZE+vVz6vFyv19wRkxb/mRGaXj7Pv5CwQi+yLZ2DCGzS//Ln9Ivq6GyxNAuDMxcoygyLY5BWcI5ASlmvPk08SIsOPU1rLy1GMGpHONVwEz8ynZ7JsBqEsLlkacTmgIRi92keigcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lYH4wYUR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-795fb13b256so419698685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632210; x=1719237010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyBlb3Ba1k/jlth0MsPpVigCEg60zHZmfggBIvSR+YQ=;
        b=lYH4wYURa/QUJ+P2i4w0TShO2gXo4pa2XbV9JrMymcSY5EjsobMXibZ8zYDhZUus+d
         BGutcmcQ46CHy6litGChDif3w730oIffgQoBJMXygE576oJRfZcsoOnRy2ff1lCYrvDP
         ZJhI8EJ/emK5whK3SE2ggNnmFeP8N9X3C8C8b79H5bdXNNSoTZUU5rA2GiCosV/FJbIs
         zWOMc60wS+fEpfNE2s/oXQutmi6K0dZ8eWI+3kwMII6lCOfhgBBm7ptHMbfzvX2a/OZW
         lOJ9sUNEl9QL9D01fjJznzv3jyjenMV7/XYZqxyY7ZixyMIDr1U1Sd4GpiqMA+8AyWde
         g0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632210; x=1719237010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyBlb3Ba1k/jlth0MsPpVigCEg60zHZmfggBIvSR+YQ=;
        b=MTSdzC9YfwkfKvsANe3Ou005Ef7mioOvGLo6yEPexsQ9I816ZUMd4iCcbJliutMl4h
         aqpTPcINrEhYrfFYacuigzORV6cW9t3DYqXsmQu2wpEauKnOusT9wY+xwrrdP0NgUfi1
         R7lvdQaM0px4iPk1XICU2Ee73EVDYWMUTxJt1Zj+5Rn/Huy+3For5K0HWraV2vPPM0D1
         zfs+qUw9KeO3uta0lvkmt9WLIzKiRv17lOkkj/WYzxF50JSqIKaK8xaJBoE6d2gbH2tm
         O7LVQy2Hl1rQwRS2x9UgU0xvfsTakPaa4rdRPr+30ULqN+P1nHxhUs3JM0dG8ni/waa1
         8S6g==
X-Forwarded-Encrypted: i=1; AJvYcCXV5FFO8di1mRKuyedhoXkJixo72wnvliBLALylS9G9/ET0DbXHgbAJlBd5UQwLl/mUFyfDz346JGlFoImGDKAoHlKTt37CsoEaxbzK
X-Gm-Message-State: AOJu0YzEd9aQpd+brwuN/zzWTjeb/kClRttQk95pQUXQ4noANsAt79lr
	8GiYATC5Nz1VzVyBo1cStUl4nPFOjLUiBrh0SZOsakwPESpspIAhOERaeaUzFHk=
X-Google-Smtp-Source: AGHT+IHWmg+UOH3erM5jeRd6l80OV3UNPvKSawdtaAa099apOKn54lBrRboJnTNNmboBsmxvynve5Q==
X-Received: by 2002:a05:620a:408a:b0:799:b171:b1fe with SMTP id af79cd13be357-799b171b5f4mr1409403885a.14.1718632210646;
        Mon, 17 Jun 2024 06:50:10 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:50:10 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:49:52 -0400
Subject: [PATCH v3 12/41] iio: adc: intel_mrfld_adc: make use of
 regmap_clear_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-12-88d1338c4cca@baylibre.com>
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
 drivers/iio/adc/intel_mrfld_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index c7f40ae6e608..0590a126f321 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -81,8 +81,8 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
 
 	reinit_completion(&adc->completion);
 
-	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0);
-	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0);
+	regmap_clear_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL);
+	regmap_clear_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC);
 
 	ret = regmap_read_poll_timeout(regmap, BCOVE_GPADCREQ, req,
 				       !(req & BCOVE_GPADCREQ_BUSY),

-- 
2.45.2



Return-Path: <linux-kernel+bounces-225309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D1912EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EC21F24D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7417C7A2;
	Fri, 21 Jun 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OQMtcmVH"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939417BB28
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003102; cv=none; b=OoLaRgh81TuhwMoGxmu2j7/acrdjU7x8dNTdT5iO04qgfiDYMdCkl17PBcY/ddaBxMaVKHlFyhGuTGQBgNhJmbmYX6mmK968ZwhLKucirKxF0dUDJIFQhevk/NAKRxRZ0VyBwxNa8nqZrsHeTC7auorWT9cHLtPcmZF6KPWKXIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003102; c=relaxed/simple;
	bh=M5ncsogjwIKi7yTwd3on+qTwjMFKb9OhWUuYpkcn5s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjqkV9Z6o5xHa/n6CbvY7pkW4iBJ36IshpltstFhFD5r02Mn8rQhPJh+xvvzSs9hNDVOnBbP9ruI+DMo0GFQ5YzYRgyawhC9aw+EGr8CVUJ9EfQ/XrDxJXUi5n41WO4yDITHSipcNT9aRKDnyp0+plkSi8uPtYbI9dQaPSBlVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OQMtcmVH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d22802674cso1315373b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003100; x=1719607900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=OQMtcmVHb2os4Ig1fSbc4NNPpl18XL6hFGMqxJ/1M1WyX+fBoxFTKG+ayktWk4FB2F
         b358bfJvHJjh5Ibn9Q8UhU7xWaMz73AKXrHVHr4itznrmB0SrADT+q1g7CUAkR8xQzic
         QNEII7HYMX4xZntONgf2IftB81wGXVX4cmQCCEkpeadZ4JH+V9EWPe4jHtoUgFbNlYxy
         GuvYUxoHLWHrA/ZMotsBCBAGI2lOQVZ4auvqaL3k7Q1NMFMynNhu6Whwn4aUUJSWtvqt
         0DpcUnqpkPqEvASsjd5mCIradRm6y8QJqNfk/pNtYzj+enT7NSEudIKMtgbamasyNtBK
         H8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003100; x=1719607900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keq6dAlPadRHMn2hspGHDGXT5Yre2UihnSFV/6UPPyU=;
        b=EDu9A5oatMPK/bu0WnjPErpaxrEu4X18oCVehLHykptyBoi0aMWovdL/So+3Ged8Lk
         ohd5SEERi1ziN7utW9Rhw2Q9MZhFqB/rygIM/vMHonQiKjeZ+bFRHdMmnZXM2jJhhpQj
         omHsY+uqFEXx6eN55hhjaeZ9+yAP+o8x/fJ4r8yhh98Nc05/AeVu2ns91TVJw2l0dEIk
         h0ezLXsm80BgcCIDwRWUEVQTp0289HSNrjXZa1TUN6jvfHnE7xkAsuWpPNiOyzTM0II3
         poc2qu0M3HiZe4yxrD6tmdUOidOzt5H4qmiiwvzXclF9hH5N2kHacSq3hi9gHDASvuSk
         7HeA==
X-Forwarded-Encrypted: i=1; AJvYcCXZuOfeetCjYfXGD9AxhdylSesmE74YkpUJOhSRl+Utp6IAhq2Cl7r6Z9O4Q9J5GlPE6HiDThlAgtouAxnk0D7Xo5Ggo7plCEMZYy5V
X-Gm-Message-State: AOJu0Yyt4Nce5wWuzb/J+87NXneA+j8ILnbmQYFytYNRvExzgNeaiOWF
	/CmWQ6x+2A7RFkzFnNo90mwuLyjITvJnnqGu0V8fczQZRtHNFfhDC4Wc7uBNdwI+ma4UACTFS1i
	Y
X-Google-Smtp-Source: AGHT+IEczRmq7EpJ/frerAFCfsSGm1g7w7xf40xN3hyRyZjge33d8FOSAQi0k4RN4+jkSstOJt1cxg==
X-Received: by 2002:a05:6808:f8b:b0:3d2:2aa8:3b2c with SMTP id 5614622812f47-3d51b9e2b73mr10572440b6e.33.1719003099967;
        Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ad7944: use devm_spi_optimize_message()
Date: Fri, 21 Jun 2024 15:51:32 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-3-3f9dcba6e95e@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use new devm_spi_optimize_message() helper to simplify repeated code
in the ad7944 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 4602ab5ed2a6..a6ac17c13a29 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -134,18 +134,12 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
-static void ad7944_unoptimize_msg(void *msg)
-{
-	spi_unoptimize_message(msg);
-}
-
 static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
 					 const struct iio_chan_spec *chan)
 {
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -175,11 +169,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -188,7 +178,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
 						   : adc->timing_spec->conv_ns;
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: can get better performance from some SPI controllers if we use
@@ -209,11 +198,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
@@ -221,7 +206,6 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 				      u32 n_chain_dev)
 {
 	struct spi_transfer *xfers = adc->xfers;
-	int ret;
 
 	/*
 	 * NB: SCLK has to be low before we toggle CS to avoid triggering the
@@ -249,11 +233,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
 
-	ret = spi_optimize_message(adc->spi, &adc->msg);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
 }
 
 /**

-- 
2.45.2



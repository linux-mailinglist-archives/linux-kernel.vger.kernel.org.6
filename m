Return-Path: <linux-kernel+bounces-439380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E49EAE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C6165BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C052080DA;
	Tue, 10 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W5OXeW03"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E22080C5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827610; cv=none; b=uSYSu267tBNpOZkUMraSb+8RPPyZdUAnqY0mdaC2Fzm5H+zHQLpBL+k2wbXmPx5wpNDVukKL0gt82pRu1iExTTOpj1ULg9I20RNvM97Q3KMQxUpJ/pVFapuBw6E+f5nOHRQXoEsJQnvX8lQKNYV+0dOFiZUNrQDge2xSQf/FjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827610; c=relaxed/simple;
	bh=uS8y4KUjGGFp3SCGu9ptn+1rXRsn3b8FMwtrcYMWjdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1ROQ8x6GmVEj4Mc44hUtBNaWCmBPwaRva+QxlnQJ5rK5OOlJIxOHMvbg4Wwmy3jil68muLx6FxhXnj+KnObKqO+tTfWj7znlwULWe3akoVhEKafnmJk6d/qnEUm1Vxe4TyGQDen6PTlEi+t461EudDJRVxe7yYIbHy5qiW3vgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W5OXeW03; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38637614567so1397897f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827605; x=1734432405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClLnB+cbi04gdhAJC+8T48pecpSeiMZUmRU/A+kfSVc=;
        b=W5OXeW034Evj0+mge19k5u7F+O02JJUPHaDVTuD2LDr00cfqIHVUgce/lVLYWBGuq5
         yFOiKe94mIy4LndyMWOXbHlOlrmnZvkUyzkKgfrga5HYCJvx8t8eO7Qv+ffMuUxjOeOI
         ceo3J4r9q0JUwCWM24mKAuB2M33SUowqpajKGAMny6N+WHkZs7F/eKLRc9LIxJeMajd3
         yVP0tYTi+x/XbOCUCEErGOOlH1NDfrzgpZOo7y9t4umKN9MFx+n5/fgUJkGeTbQTEr2T
         x2jKSsirXFeRKGPmsijCY6kZTI0JGs78bpsspkTYlNuEsD5TqJ0PzYU+nUgiVcpDDNv3
         SUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827605; x=1734432405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClLnB+cbi04gdhAJC+8T48pecpSeiMZUmRU/A+kfSVc=;
        b=AvAeB8DA7X9LdCLOn1FO3qR3iK32A3ew1tuz2si9l85yRFNaDLQqjBt/mS/3/BnLf2
         tYKaWN6odo0I549NjPUOP9mKpBwhx45WnSjeqRuCUsrui+7hcV4UipVVzVOKuw+IJ0f/
         sv/Jl94j2cNUBVofUB1ROJ6yeUXXs/hU6ZA0LOUWchB4aH7HrT1rXXkE25ob/kBlY7f9
         3Qr57dSK1ucBv7oOf3Q2klFO0jURLRmKPenrBVuGLIbJ3/Oxj5m15gUcmGUhMBSFSKCa
         lgEjnlik+TECfW41UePAPPkf+W1qXN347pb61WuZB7Ts+D4U3b3sGQc7uxuYkEWhyyDm
         XEzA==
X-Forwarded-Encrypted: i=1; AJvYcCX8O+fAZDr7MNgS1BcCOjQnE/wM4b9hjFeEMK2WD8/B6A+uAlzRv9WkhCIjbg7JPZfeAAyxQJLfUgXgsYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XW7lOf9XzYcYS24Formcx6QbnsRBjUTRP1boTWkkeZrAF60V
	vM0XkyIFHH+yCdROegnSsNVA2HAGXEFFRkAjm+yDGZsBLrhNiYH/+jQqOZCaPNo=
X-Gm-Gg: ASbGnctBcU/3IzqYksRs1U72rzVIdw6uP6s8FcZ7k65g3wAW/zPpSQq5EWT2dRLwLU9
	SmFBBSE3e9F21OgMaksM1bOqkt8E4rEHfypBd9y+9/BZeAYLfOdLnekB4D1Vu+w2ZroacHVX3C+
	AQp9InDHlCGSZx+hCUv6mSakrhmZijtGz22cr7fYcjkfViuE2/lfxkFN4XVRciSUb5KhA4GBqcO
	4Gh5VqNz9SCDlTigUQthQ8ptbrJ5Ls5ac8NCKJY5FRfRm/nx83cWsU+BNwWMG4SitZxH4sxZNJn
	Xg==
X-Google-Smtp-Source: AGHT+IEvNG9eKB8z/U5t1enk5Oh8ZZGNoVReVi3dRyTC3QcJGhPiAAiO06JHmQbdibv9py/aITHp2w==
X-Received: by 2002:a5d:59a6:0:b0:385:edd1:2245 with SMTP id ffacd0b85a97d-3862b380f68mr10085762f8f.30.1733827605278;
        Tue, 10 Dec 2024 02:46:45 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:44 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:41 +0000
Subject: [PATCH v2 1/9] iio: adc: ad7606: Fix hardcoded offset in the ADC
 channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-1-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=7243;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=uS8y4KUjGGFp3SCGu9ptn+1rXRsn3b8FMwtrcYMWjdE=;
 b=hkwg1GMUOnEH41vU+VyvTShCazCQ+ZNhx/qkEmZgI9x0hhmR0SzOugmDBLZ+0FhJWddgTdi96
 EvY0m0OxcoHDhUQskoHc6Yt/sYWaFYgwDzJuCl8b2yTX2TwI82d5ZHR
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

When introducing num_adc_channels, I overlooked some new functions
created in a meanwhile that had also the hardcoded offset. This commit
adds the new logic to these functions.

Fixes: 7a671afeb592 ("iio: adc: ad7606: Introduce num_adc_channels")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 48 ++++++++++++++++++++++++++++--------------------
 drivers/iio/adc/ad7606.h |  2 +-
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e35d55d03d86..d8e3c7a43678 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -175,17 +175,17 @@ static const struct iio_chan_spec ad7616_channels[] = {
 	AD7606_CHANNEL(15, 16),
 };
 
-static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch);
-static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch);
-static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *chan, int ch);
-static int ad7607_chan_scale_setup(struct ad7606_state *st,
+static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
-static int ad7608_chan_scale_setup(struct ad7606_state *st,
+static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
-static int ad7609_chan_scale_setup(struct ad7606_state *st,
+static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch);
 
 const struct ad7606_chip_info ad7605_4_info = {
@@ -323,9 +323,10 @@ int ad7606_reset(struct ad7606_state *st)
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_reset, "IIO_AD7606");
 
-static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					 struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	if (!st->sw_mode_en) {
@@ -345,10 +346,12 @@ static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
+static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 				  bool *bipolar, bool *differential)
 {
-	unsigned int num_channels = st->chip_info->num_channels - 1;
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int num_channels = st->chip_info->num_adc_channels;
+	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
 	struct device *dev = st->dev;
 	int ret;
 
@@ -364,7 +367,7 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
 			continue;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg == 0 || reg > num_channels) {
+		if (reg < offset || reg > num_channels) {
 			dev_warn(dev,
 				 "Invalid channel number (ignoring): %d\n", reg);
 			continue;
@@ -399,9 +402,10 @@ static int ad7606_get_chan_config(struct ad7606_state *st, int ch,
 	return 0;
 }
 
-static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_18bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 	bool bipolar, differential;
 	int ret;
@@ -413,7 +417,7 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
 	if (ret)
 		return ret;
 
@@ -455,9 +459,10 @@ static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
+static int ad7606c_16bit_chan_scale_setup(struct iio_dev *indio_dev,
 					  struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 	bool bipolar, differential;
 	int ret;
@@ -469,7 +474,7 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 		return 0;
 	}
 
-	ret = ad7606_get_chan_config(st, ch, &bipolar, &differential);
+	ret = ad7606_get_chan_config(indio_dev, ch, &bipolar, &differential);
 	if (ret)
 		return ret;
 
@@ -512,9 +517,10 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7607_chan_scale_setup(struct ad7606_state *st,
+static int ad7607_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -523,9 +529,10 @@ static int ad7607_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7608_chan_scale_setup(struct ad7606_state *st,
+static int ad7608_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -534,9 +541,10 @@ static int ad7608_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
-static int ad7609_chan_scale_setup(struct ad7606_state *st,
+static int ad7609_chan_scale_setup(struct iio_dev *indio_dev,
 				   struct iio_chan_spec *chan, int ch)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
 
 	cs->range = 0;
@@ -1146,8 +1154,8 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 
 static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 {
-	unsigned int num_channels = indio_dev->num_channels - 1;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int offset = indio_dev->num_channels - st->chip_info->num_adc_channels;
 	struct iio_chan_spec *chans;
 	size_t size;
 	int ch, ret;
@@ -1161,8 +1169,8 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	memcpy(chans, indio_dev->channels, size);
 	indio_dev->channels = chans;
 
-	for (ch = 0; ch < num_channels; ch++) {
-		ret = st->chip_info->scale_setup_cb(st, &chans[ch + 1], ch);
+	for (ch = 0; ch < st->chip_info->num_adc_channels; ch++) {
+		ret = st->chip_info->scale_setup_cb(indio_dev, &chans[ch + offset], ch);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 998814a92b82..8778ffe515b3 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -69,7 +69,7 @@
 
 struct ad7606_state;
 
-typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
+typedef int (*ad7606_scale_setup_cb_t)(struct iio_dev *indio_dev,
 				       struct iio_chan_spec *chan, int ch);
 
 /**

-- 
2.34.1



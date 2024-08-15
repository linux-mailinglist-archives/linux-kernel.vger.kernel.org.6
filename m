Return-Path: <linux-kernel+bounces-287905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55462952E19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCBB24E50
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346EA1A00DF;
	Thu, 15 Aug 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MhA6TJj6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE917C996
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723935; cv=none; b=cHDDczAle8G9/lmRUGssflHfKBfI3ynTp/C7PoNamOj9ETR3LP9RznsZhRFK/i6TPv1F3dDJ9uGoGJL8E0IgwQbgeb+lLyc+P39vK6RgkutlOHRXO7I6jpvWYnbXWvP3+YbYrJmVQpOuDVevUzI7I0/dfOhCoj/0u9TechPTQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723935; c=relaxed/simple;
	bh=JiY1QWQ/CFROpK9K5j1ChfJ3QqmS9Qz+FrZxBwt17/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXb5Qrr2MKbl568o73dkBBGnB091+mBDUY0Aghqaghfcevm8g7kqouIsH1VF4ie+Or5mGCrAjkNGWr8V94mWYJKzlLQostXA7YchouYUpx1voDiASPdqlSnMWGd7M7iTOGfHMfJ5tzrWWY813GKqozQAiSL4y//KGq5o+58nNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MhA6TJj6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e3129851so5603165e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723929; x=1724328729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsmWif8uVFiUkeeApAzanMTj92Fpn05eIG5hFqegbKc=;
        b=MhA6TJj6DZgpjrVta0QzL9DGpMbLV74+A6UdjkQWoXfy5n27U4Vsmsulh2+CzL4bAV
         BlOMVDr4v6rxNCYmUiWMdQCk8sJx6LcInOVFphz5ZaODiAtJcthhd+UmOCt0+sNGMiAc
         1brUN+3LAEW9mzQwpRMh8SVsH+4lU/VdNpon4sQ0VeptW7PuzCbq8HBwUrfEvD59+fSo
         S6HeGfO9E9n+trL6+cR7m0U6l2cWiZkqxLeLExiS+sNt1BEHzku+bSfOPrP5D9d2hu4t
         PJ8FyVKg7OQ2wubFknGthLJuCxHIhYApDOFzhT7S30K53ZYpD5P9d8J74UdrUwfZGNEe
         nQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723929; x=1724328729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsmWif8uVFiUkeeApAzanMTj92Fpn05eIG5hFqegbKc=;
        b=CObZKi87Ba9um9knv/BdBAEiSK1OwiJ9Z0+Dvd4ZCbbZOoA26DY7NpAevawNLon4EN
         9yzFubs+HKlTBOW2CCI7N+wIso4NVeaWKh5uU77NQeCV5PEcD0tutzlLi/I/HVjTJgZ9
         Vp2qcZGbV5cDrFQlxuXUKwuaP+A2U8/HENVJc8WHSIQD1Sx3xkavDf6L7m/iSryLkUVw
         E49seKWClnz5/ZaQFuQFmoiX01+x3jhYljwcCBmggoyrjmtC/5lIkBE5H6xFdldP0iEc
         rIotgPPr+7PbC0/TsXpZ4u+DN6myOFDYVO6PDHLEOsxx2wuuCsaeTdNaw/NR36naeypq
         sHEw==
X-Forwarded-Encrypted: i=1; AJvYcCVoDCRLjbWNqwcBIoQdZujewitbCYIqOcGz5yvvXLqBomXaWO1ncYuVcEYPdsdZow/r0QqHIfqt0aXpIEwd75sDassFNb7h0qv++YS2
X-Gm-Message-State: AOJu0Yxe7tSgpgA4Rlm6Tn0UPVN+DhCocBRSD27+PX9mxPnF/n9893d+
	DAMueGTdwbMD38+3IlatRdvLsQzVk6NqhpTckDsnZdyLTwhjMW8q5CCNLxy5IsO2L0sRsAg3N+2
	z
X-Google-Smtp-Source: AGHT+IHvxeihigsp5GgneWlVdLGk/bvPKjkBNuyt7amyr0XnbK5zAh/wd3u73BKr1hIZu+GmBNT5Zg==
X-Received: by 2002:a05:600c:3147:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-429dd24388cmr44635515e9.18.1723723928876;
        Thu, 15 Aug 2024 05:12:08 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:08 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:12:00 +0000
Subject: [PATCH 6/8] iio: adc: ad7606: Add PWM support for conversion
 trigger
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-6-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=9222;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=JiY1QWQ/CFROpK9K5j1ChfJ3QqmS9Qz+FrZxBwt17/E=;
 b=eVkvSg4+8MrEnNbhPKJTAD6OHIQxQobdWOOey4+hytnUCICX7iLYZOARZXlC2b2YgUcrFkai1
 VoA3QLhdWYGCRiMnsCxq0hQnAFjEaVCsUIFwW/rRDryG5WrRJyYhBah
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Until now, the conversion were triggered by setting high the GPIO
connected to the convst pin. This commit gives the possibility to
connect the convst pin to a PWM.
Connecting a PWM allows to have a better control on the samplerate,
but it must be handled with care, as it is completely decorrelated of
the driver's busy pin handling.
Hence it is not recommended to be used "as is" but must be exploited
in conjonction with IIO backend, and for now only a sampling frequency
of 2 kHz is available.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 162 +++++++++++++++++++++++++++++++++++++++--------
 drivers/iio/adc/ad7606.h |   3 +
 2 files changed, 140 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 539e4a8621fe..2c9ddcd0ad77 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -13,11 +13,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/util_macros.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -82,6 +84,76 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7606_pwm_set_high(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static int ad7606_pwm_set_low(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = 0;
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static int ad7606_pwm_set_swing(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return -EINVAL;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
+static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	if (!st->cnvst_pwm)
+		return false;
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	return cnvst_pwm_state.duty_cycle != cnvst_pwm_state.period &&
+	       cnvst_pwm_state.duty_cycle != 0;
+}
+
+static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
+{
+	struct pwm_state cnvst_pwm_state;
+	bool is_swinging = ad7606_pwm_is_swinging(st);
+	bool is_high;
+
+	if (freq == 0)
+		return -EINVAL;
+
+	/*Retrieve the previous state */
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	is_high = cnvst_pwm_state.duty_cycle == cnvst_pwm_state.period;
+
+	cnvst_pwm_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	cnvst_pwm_state.polarity = PWM_POLARITY_NORMAL;
+	if (is_high)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+	else if (is_swinging)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
@@ -141,9 +213,21 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct pwm_state cnvst_pwm_state;
 	int ret;
+	bool pwm_swings = false;
 
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst) {
+		gpiod_set_value(st->gpio_convst, 1);
+	} else {
+		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		/* Keep the current PWM state to switch it back off if needed*/
+		if (ad7606_pwm_is_swinging(st))
+			pwm_swings = true;
+		ret = ad7606_pwm_set_high(st);
+		if (!ret)
+			return ret;
+	}
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret) {
@@ -154,7 +238,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	ret = ad7606_read_samples(st);
 	if (ret == 0)
 		ret = st->data[ch];
-
+	if (!st->gpio_convst) {
+		if (!pwm_swings)
+			ret = ad7606_pwm_set_low(st);
+		else
+			ret = ad7606_pwm_set_swing(st);
+	}
 error_ret:
 	gpiod_set_value(st->gpio_convst, 0);
 
@@ -169,6 +258,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 {
 	int ret, ch = 0;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	struct pwm_state cnvst_pwm_state;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -419,8 +509,9 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
 
-	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
-					 GPIOD_OUT_LOW);
+	st->gpio_convst = devm_gpiod_get_optional(dev, "adi,conversion-start",
+						  GPIOD_OUT_LOW);
+
 	if (IS_ERR(st->gpio_convst))
 		return PTR_ERR(st->gpio_convst);
 
@@ -489,6 +580,7 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 1);
+	ad7606_pwm_set_swing(st);
 
 	return 0;
 }
@@ -498,6 +590,7 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	gpiod_set_value(st->gpio_convst, 0);
+	ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -545,6 +638,11 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static void ad7606_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -635,20 +733,42 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 	}
 
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
-					  indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &ad7606_trigger_ops;
-	iio_trigger_set_drvdata(st->trig, indio_dev);
-	ret = devm_iio_trigger_register(dev, st->trig);
-	if (ret)
-		return ret;
-
-	indio_dev->trig = iio_trigger_get(st->trig);
+	/* If convst pin is not defined, setup PWM*/
+	if (!st->gpio_convst) {
+		st->cnvst_pwm = devm_pwm_get(dev, NULL);
+		if (IS_ERR(st->cnvst_pwm))
+			return PTR_ERR(st->cnvst_pwm);
+		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,
+					       st->cnvst_pwm);
+		if (ret)
+			return ret;
 
+		/*
+		 * Set the sampling rate to 2 kHz so to be sure that the interruption can be
+		 * handled between within a single pulse.
+		 */
+		ret = ad7606_set_sampling_freq(st, 2 * KILO);
+		if (ret)
+			return ret;
+	} else {
+		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return -ENOMEM;
+		st->trig->ops = &ad7606_trigger_ops;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, st->trig);
+		if (ret)
+			return ret;
+		indio_dev->trig = iio_trigger_get(st->trig);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ad7606_trigger_handler,
+						      &ad7606_buffer_ops);
+		if (ret)
+			return ret;
+	}
 	ret = devm_request_threaded_irq(dev, irq,
 					NULL,
 					&ad7606_interrupt,
@@ -657,13 +777,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7606_trigger_handler,
-					      &ad7606_buffer_ops);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
@@ -693,7 +806,6 @@ static int ad7606_resume(struct device *dev)
 		gpiod_set_value(st->gpio_standby, 1);
 		ad7606_reset(st);
 	}
-
 	return 0;
 }
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 0c6a88cc4695..60bac1894a91 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -38,6 +38,8 @@
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
 		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
+struct pwm_device		*cnvst_pwm;
+
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
@@ -94,6 +96,7 @@ struct ad7606_state {
 	const struct ad7606_bus_ops	*bops;
 	unsigned int			range[16];
 	unsigned int			oversampling;
+	struct pwm_device		*cnvst_pwm;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
 	const unsigned int		*scale_avail;

-- 
2.34.1



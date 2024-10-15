Return-Path: <linux-kernel+bounces-365952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F699EE77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A6A1C215AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18801DD0E4;
	Tue, 15 Oct 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k86ZN16M"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BCF1AF0D3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000606; cv=none; b=bkRXyBIDrfJWR7zZ8hJ3mlfzI9atJ5TMQIo9tmJNOHyUw6gklpUZCY1PqCXqtq+zM8aMpDL0Wp5iEk6Pl7ffHvh/5pWx5Lr2LDgs9Gvmi4XVmHHd1/24Bx9PiX6E+LENQZqJWFkH+lrdW5dTm835a6Ni1iQY9ftXur+Nh3mWPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000606; c=relaxed/simple;
	bh=8sj2ik6YIhgGPpUYAJWB3DqY/rpxFFg132670LOYgCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=el1W1C0K2eW6zmni8Qsd2RuGnhdc0QS3Oh6SIPLUlim0zZlFMB0Rh+WYeR7hyvF5BqW+S/LA0K/ahFA/F2bpOygWaDWrF1aZBilnPo6DZ1Kg6g32iU3dNEmcCscPXNMg/JKAuCOIgMMMCHWv+O3NKL2RRsZ6DDVpy+iL6P4GBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k86ZN16M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430576ff251so47361255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729000599; x=1729605399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfimGBiPs/xd5kQ6SFTwCIGnDDLl5cZX78W/oQcH5gw=;
        b=k86ZN16MyOFbYo+4JwKQ1xYBdHCj8NQ7vdKdaNWoDZEWrBO8ejFRucdjROOoFkC/gl
         pmk11MKPXInSGbNBzM/cf0FMne9YQ0uFHNv7kLEY9TQQ7rajZwRjfJZnN+GdykPHkyD0
         3ID4vhIk9+Uafm4PRoohApwNV9HkEcm8OXvKXVP1a4xDRzXj/8nDzr33ZMZUa0r4SFd9
         dSmB937849lTZ5BGX/XvveaKx6MUMZv1xbgP+R0y6X+4kR8r/ufrEylPIAyCRlU0znwO
         QIh1ZD5Y/es7U7z0fi110oiW1GVTjjz/yWL6zAKchw51P3mxfaVOkJX27AIjqnTq7S9r
         ZYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000599; x=1729605399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfimGBiPs/xd5kQ6SFTwCIGnDDLl5cZX78W/oQcH5gw=;
        b=rqH8DoBZly2OiacGD6WQRonH908nwFg8DcYOMuLmFsWTQDoBksAcMMnbX2CCCGfDnj
         sNnXBgUyVpZRYF69AtVYC2DBvSfA0utORZLWEc6YhCzl5BMu5ILga/q2KJRUzeQ54ZJz
         roqs0kI+ud5rXmkY2r6PvixR0g9+2eBBoHbhxMe1o71ndW1ZPyRht/1zmbPjDkXJcN4i
         LiOsjC3Bd6JBlO5jwWPVqGSwKmVQobLsQsHDwf7g0RRS0jJy5JCU78y9ZrjN/uWRvBOz
         vvzJLPtg05vQVkLCZWfMmpSSY9mlp/5w024Og8j7XxTmGIICgt9e4aY/T/+tvWkrUqMT
         bTdw==
X-Forwarded-Encrypted: i=1; AJvYcCVHILJTQ/XkaxQOK5kyfYeXNddJAeNqL1qlzA61ltO117xsiPRZ40ryJvyv4Zlp2hYRsvO6A2i9cYy3I+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZIrkbjSBric3MfUFgEKQF7y36uqUPxeR2sLxflFgHo7/1jf8
	MNi3dyOsl+qMf0nXNF+eO4LjImg6HL6hrk3u2Ayexh0x4Zd2XIPVUqncDouzmCw=
X-Google-Smtp-Source: AGHT+IEKh3xWTi5hf4sbT5P8PdIbNsnQOa5kUn7o9v8bR0uMH7vd17OSHnnAv62Xz75tzpQ58/ip5g==
X-Received: by 2002:a05:600c:1e18:b0:431:166b:fc1e with SMTP id 5b1f17b1804b1-4311df42cdamr131676955e9.25.1729000599280;
        Tue, 15 Oct 2024 06:56:39 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f241sm18848295e9.22.2024.10.15.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 15 Oct 2024 13:56:21 +0000
Subject: [PATCH v5 8/8] iio: adc: ad7606: Disable PWM usage for non backend
 version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-ad7606_add_iio_backend_support-v5-8-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
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
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729000592; l=2658;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=8sj2ik6YIhgGPpUYAJWB3DqY/rpxFFg132670LOYgCg=;
 b=1u2rG+kjJiMqYohGDsnjVlDj3sIi34d9AcBG26SyutZ8VN80TTEQ0g/9rRT0jd/zVf+8HUkLX
 24VBapyaxS3BkB8VGn298idC036IGXhLHEHFHfCi9s6y6b7XT1p5QNF
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since the pwm was introduced before backend, there was a mock use, with
a GPIO emulation. Now that iio backend is introduced, the mock use can
be removed.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 7871552ce5ac..0e830a17fc19 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -470,8 +470,6 @@ static int ad7606_pwm_set_high(struct ad7606_state *st)
 	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
 
 	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
-	/* sleep 2 µS to let finish the current pulse */
-	fsleep(2);
 
 	return ret;
 }
@@ -486,8 +484,6 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
 	cnvst_pwm_state.duty_cycle = 0;
 
 	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
-	/* sleep 2 µS to let finish the current pulse */
-	fsleep(2);
 
 	return ret;
 }
@@ -563,13 +559,7 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 	/* The rising edge of the CONVST signal starts a new conversion. */
-	if (st->gpio_convst) {
-		gpiod_set_value(st->gpio_convst, 1);
-	} else {
-		ret = ad7606_pwm_set_high(st)
-		if (ret < 0)
-			dev_err(st->dev, "Could not set PWM to high.");
-	}
+	gpiod_set_value(st->gpio_convst, 1);
 
 	return IRQ_HANDLED;
 }
@@ -900,10 +890,7 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (st->gpio_convst)
-		gpiod_set_value(st->gpio_convst, 1);
-	else
-		return ad7606_pwm_set_high(st);
+	gpiod_set_value(st->gpio_convst, 1);
 
 	return 0;
 }
@@ -912,10 +899,7 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (st->gpio_convst)
-		gpiod_set_value(st->gpio_convst, 0);
-	else
-		return ad7606_pwm_set_low(st);
+	gpiod_set_value(st->gpio_convst, 0);
 
 	return 0;
 }
@@ -1210,6 +1194,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 		indio_dev->setup_ops = &ad7606_backend_buffer_ops;
 	} else {
+
+		/* Reserve the PWM use only for backend (force gpio_convst definition) */
+		if (!st->gpio_convst)
+			return dev_err_probe(dev, -EINVAL,
+					     "No backend, connect convst to a GPIO");
+
 		init_completion(&st->completion);
 		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						  indio_dev->name,

-- 
2.34.1



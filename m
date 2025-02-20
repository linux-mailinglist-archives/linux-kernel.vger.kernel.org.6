Return-Path: <linux-kernel+bounces-523362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF1A3D5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9642D7A9AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3721F1517;
	Thu, 20 Feb 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fjLMof2j"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38381EDA36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045443; cv=none; b=iR+vO/3SjZbFBLUJenXTxnICaPfwRL1LKCH/4Ls3klLuEkk2+KRgSldulyNzoce1iVE3Tnc03Un6TBApCVNaHkr8qW2ROiRK3sdLDb8HwAENQRbvsoka7BX8NqVVqN8q5jh2VebhNM7E4uNT5fg+MrfO3DVP8k7LrpzcZHC3xeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045443; c=relaxed/simple;
	bh=+Xr6oK/Ht9wHw9nBP+zpmINE/igg0/oGpW7h6Rg2Dvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxRmKxIQyQyzqadG5Qe+ho5lMm8+uVczoYRimgX2IQuMM/HPQg3W2mbnrhtJ6PRMUbOgVlBjVZmZOzBq8QMwXcjOSytNU1rIA5ghbjPpjR0UcHYHt6RHy2+A2SWbVtOZu8N9wPF2QoS64GsbLD3Dq9ZEBXrHuvnXLZc+mS5V3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fjLMof2j; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so351014f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740045438; x=1740650238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sXz+4tNFW/bf9SGPlUIBQPKXDJQTdpVYHzJ1o1hhmw=;
        b=fjLMof2jeBHJ4d5NDU8RazHC4r9XwHb0fqSDwyfvbEd8quItniloWnIaJsuHg4G89M
         mlthpmPNLHLt3m/8UPSt1Tihn7wgwKEZeVMaiEfW/YBljomk1jz3q15kXmswZlv9eOz7
         uwU4f8F81I5AzntKy2Dp6H+GX0MNwJtfjByNfGotadBmA50fPip9yh6K1I2zMTv1s68k
         U+u/u9SMlIU0XKpichv9n/HzN4JSniX5QTo6UuBikKw8j6V3kMdBJtPKoziASOUCpoCI
         /ZyF4z+FrbD+N4OVfZz5AJqC82/F8IP/yvZRTT9Ngh0cBzFkLZ7VQvlSiPg43PC8IEQX
         JWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045438; x=1740650238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sXz+4tNFW/bf9SGPlUIBQPKXDJQTdpVYHzJ1o1hhmw=;
        b=befIk3s6oBQqxp+s/n61OnH4AGY7aWjbzPeWlC0nz4pmkwPsBRw+oRrooCzIem+0bz
         f0L8GeA0S7VsKbU5gflEA3027cbtVJZiGzh20alBqhhsHTNp+atotXYsoaqWKLlZg5CX
         63Nx4DSqQxaJp6MZ2B2S0y4LUC8i3Zy3SgcBgzRqUqMmrmWfZWSTB3zmzzTWm0zflTWl
         wOh5HlISot1fMHFWJCJF1/3SGQZhlXwNiwsS4LcTygcQg5f27H9XZrh8YP+3hIrE9RQb
         DJyn752GcEkESz+gDsNvap2dBBYpTKLPQ2K5rpby/O62j3Bml5tgQeIj2zmo1EU4GyWl
         jTyg==
X-Forwarded-Encrypted: i=1; AJvYcCVUP/M3B0HliqacYzoliC1RBcgxccKdGoN9ouJMxSvIdckXn+UTZ+VQmgnsf7OT29keSKzcd3z1nHR4eys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP1tP8C5cP2BZCo3BXdq02dpwPifq9kl8oKEi+PhbZ4PDQ/9Q
	T9En6i55GrwgCkgbV1uB7eViVD6bbFf+1gu1D1uu/NSLUttx+Pk0SlcH1SGHrgw=
X-Gm-Gg: ASbGncsWKvSZma/h//KW4dAbOo3+FbtotkaZg9UCvYp1i1eVcDAxKL37By+O5hlB0xA
	XT1q8ImoRsS3WZdRDc6ZODogHcFSbSGbaMQzZFmoEx/bxJBQYpKaHt+b4QNzCbnWX48rrxw5uTw
	z25Aiw9uyZIoEk6bglfLcTjx+mOiv61bbnO8aw1akM3a7TlKI//mdb3RwqcBkI9K2El1L+OyJGH
	/byOtcusCLctAZbZBUf6cU/gZ4PemQYY8XlQLrf0OC8a1uCeEzcCl0adDntNxzPeXD7wNaEJ5ru
	NIozKCk=
X-Google-Smtp-Source: AGHT+IEUcIIWgogQ/V2/Cy3TUa1rBPDTehvksRZT7Bu74zZ+4Tf95QDLA/2KI4a6FQNi3GKxdEoTZQ==
X-Received: by 2002:adf:ee86:0:b0:38d:b113:eb8 with SMTP id ffacd0b85a97d-38f33f28774mr14644303f8f.20.1740045437998;
        Thu, 20 Feb 2025 01:57:17 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm20509174f8f.64.2025.02.20.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:57:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 10:57:00 +0100
Subject: [PATCH v2 03/15] gpiolib: wrap gpio_chip::set()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-gpio-set-retval-v2-3-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
In-Reply-To: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=uCnOYzpuHE5Zrq+zDhiY242948Qctv914RGVf27gLnk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBntvx2f5uyro8hvEgFdU3ntj3hHzSe4ZZu7m3re
 pWfOrjmfe+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ7b8dgAKCRARpy6gFHHX
 cjWrD/9sUe5qUSq9ERYH1Bx0qhafbeFnmoXkGkNGZ/QBTTk0S/1szvmMJN8uLK+lcRiUQLqc8sm
 IgORwNWtxFF6Q4HoI62etlIshKoGo5F0uWlTdTgq0DZ9R0coc9Xqwfr1gux6l3avakBARZOBmin
 qb82SvHbS/HYdmZqbwD/2E8ebzpo0GFIAEdjWa6h8O/pqtHf/va5NaYPvkihjwl38U0l0hFTp9U
 MI3U2rYo2M4Yvq7H7PjHUt28BloDVSQljYHFj9Wx0gzPx8f965fLEuLWmaU5f/H4T8pBqv6qgAb
 7kbYx/p14FOIabJBcse8+Vi6aPbUzbh34ddJN/NL4ZTjxN94ndChlVx+0fPNf44mh36owImYQJ2
 GiBZnT81dpIT5g1KLvGA//HM0OFaYSEzBlVZGzy8HomiEUh5GN2DrpH92rewRDmVMVYKi92USzi
 PCVpcaoUzRos8i2hNM6VVMMX0GWqgrkbg2072kQUvz2jqpS60CjJ33BDjyidwWryKpOaX0H/rPd
 iIam0aT1GwJ2yOr6Iz8EjMQOVlVh1BPj+FS8DQhGafVxoTUzIPogkyWtx+2LhYF4tumiNn/QiMr
 MYPKye4WSuHdzE25ai6YkXZDZJtMKGmBA5HJxNZ6qw/oK0w6e3y/L+XLLq4CFSyDZ5H7FIZFsKg
 P2o3tFZ0A23/9dA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have three places where we dereference the gpio_chip::set() callback.
In order to make it easier to incorporate the upcoming new variant of
this callback (one returning an integer value), wrap it in a helper so
that the dereferencing only happens once.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0a47fb38dd61..040b4689eb8e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2755,6 +2755,17 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 	return ret;
 }
 
+static int gpiochip_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	lockdep_assert_held(&gc->gpiodev->srcu);
+
+	if (WARN_ON(unlikely(!gc->set)))
+		return -EOPNOTSUPP;
+
+	gc->set(gc, offset, value);
+	return 0;
+}
+
 static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 {
 	int val = !!value, ret = 0;
@@ -2797,7 +2808,9 @@ static int gpiod_direction_output_raw_commit(struct gpio_desc *desc, int value)
 		 * If we can't actively set the direction, we are some
 		 * output-only chip, so just drive the output as desired.
 		 */
-		guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), val);
+		ret = gpiochip_set(guard.gc, gpio_chip_hwgpio(desc), val);
+		if (ret)
+			return ret;
 	}
 
 	if (!ret)
@@ -3465,9 +3478,7 @@ static int gpiod_set_raw_value_commit(struct gpio_desc *desc, bool value)
 		return -ENODEV;
 
 	trace_gpio_value(desc_to_gpio(desc), 0, value);
-	guard.gc->set(guard.gc, gpio_chip_hwgpio(desc), value);
-
-	return 0;
+	return gpiochip_set(guard.gc, gpio_chip_hwgpio(desc), value);
 }
 
 /*
@@ -3492,7 +3503,7 @@ static void gpio_chip_set_multiple(struct gpio_chip *gc,
 
 		/* set outputs if the corresponding mask bit is set */
 		for_each_set_bit(i, mask, gc->ngpio)
-			gc->set(gc, i, test_bit(i, bits));
+			gpiochip_set(gc, i, test_bit(i, bits));
 	}
 }
 

-- 
2.45.2



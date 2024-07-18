Return-Path: <linux-kernel+bounces-255793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10FF93454E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA60B20C93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146F10F2;
	Thu, 18 Jul 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pd6eqp/T"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55B195
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721261382; cv=none; b=g31kyx7r0vzKYjwe+ySUzrpzcDZbzn/GuIZNlNNCxPBymAtjwGvcBY20wvNt+DD8Edpg8FkRu+yLGaUnPmZOYPAIeQKNtrzKuWiyoyZQQgOYeEu4sGx2V3MAQty+POZ3WLKSJyd4BYyTsPg4PLFhjvE9/iQ2GG4Zc9tb84DVOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721261382; c=relaxed/simple;
	bh=4HNKatqWLU6KJV8ksJ86yC6IMX/1lH46LBS256lNGXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1Ps7bfHJRTZoPlcP2owZPf57oHNeoaQJcHQKhDWAv/gTW5f5IaN8ij/tnsfz5C7OQmvIwzxNjWSatipL14X+aMzq9yi2wSm32q5znTyITye5ubb+ABRw0+u8v/7WCUj2yme9McfOQVVEUFMKc5juPwxem/46V90INpB5AmHkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pd6eqp/T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc587361b6so2599355ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721261378; x=1721866178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygcvHwT21rnyyK9FqsryADEACNrTd1WTS27RQFo+Wzc=;
        b=pd6eqp/TejsfLCemVEb5MWZp7YHDzy0vbhqpfOAil50xzSf4Upzr/7J63crnbGf0N1
         FPde5oXXpjo74Cd+v/NkDtT18xmBHAV8UMI1b/IaDDeMmxygB39G6VFWG5xG5jYkfY8P
         40dn3NbeiTxZStVU8bpGjKpsaY1hnNakjnWKBZ/GM1USJNDKqoMsnX4y6YdlSYff/r3d
         lO0e7IHQkKMGvLYW0bNUH2aoK3nsuaJ1BeRSuLzbCqSrEbqCyGwGIC2C4O4OBZ3lx6BP
         aJCJmhD3CwXZZABlPZRzp0yyOH4rL264cnwZTXS/zkf7atd8Z6vyvxvwuOJPU7blEYp/
         nYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721261378; x=1721866178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygcvHwT21rnyyK9FqsryADEACNrTd1WTS27RQFo+Wzc=;
        b=KX7l1+fhQl5eW4LrHTrxjm2g27N++NSLo5hp4PwEhF9j8mtbReFOb+WJVYsJWhkplr
         V3m9lu3q3DAjZ61YA8cEMW8S1Zo9E5zWuKwl2lE1Rn/yik377j/LjYk0136ZRdT1E+uW
         0FX3qWbdGHdavEdhVXl3ePazjAWnd4rQuc/OflO8Dj7eDTvjlqHK35hME7ViaG2QY3Cx
         1Yhl8ZpfzF8IVGTaKX2mrA1CbxXPMymX0/42lTnLJrIarOBl0I4CBtAeo83bwAliZKSX
         91MjuORB5NzY9kOCpkQfLpt0yqUC8IRUE+SUq2XLRplrrI+kqCuB6Dm7vbF58qNE9DMW
         /XVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVOL1pvVojHXEY51uJsV37hY1R8ysQYqQrtUY09Zpe6KGnZFNriBf8sWJhgiqKJ2YQiAecs2PL0lpmmKMV5osBR6HsRuKvdjEH092J
X-Gm-Message-State: AOJu0Ywek5V6qK+eT7ZN/dX9l4cr7OilIFN4U3dvKaAMye2yY/VozL+l
	u8uqmdrwbicEoui4fHiokKjw5by7wAaA2XoZWyNkCHvJCdrQj/ibsxkRulUUwrI=
X-Google-Smtp-Source: AGHT+IFPUjaMAlNGpqGgBXdgFvh0EM5pFUKWWpK5R28WcGhYVRlg8c4gIgPooiZk1CIzWmbzpNm2wQ==
X-Received: by 2002:a17:903:40c3:b0:1f6:f298:e50 with SMTP id d9443c01a7336-1fc4e683945mr27662155ad.58.1721261377709;
        Wed, 17 Jul 2024 17:09:37 -0700 (PDT)
Received: from localhost (75-172-111-187.tukw.qwest.net. [75.172.111.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3a251sm80628035ad.198.2024.07.17.17.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:09:37 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-gpio@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] gpiolib: expose for_each_gpio_desc() to drivers
Date: Wed, 17 Jul 2024 17:09:32 -0700
Message-ID: <20240718000935.2573288-2-khilman@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718000935.2573288-1-khilman@baylibre.com>
References: <20240718000935.2573288-1-khilman@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for_each_gpio_desc() iterator is a convenient helper and is also
useful for GPIO controller drivers.  Move this helper from the
internal gpiolib.h to driver.h.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/gpio/gpiolib.h      | 5 -----
 include/linux/gpio/driver.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 48e086c2f416..c68be135e137 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -115,11 +115,6 @@ struct gpio_array {
 	unsigned long		invert_mask[];
 };
 
-#define for_each_gpio_desc(gc, desc)					\
-	for (unsigned int __i = 0;					\
-	     __i < gc->ngpio && (desc = gpiochip_get_desc(gc, __i));	\
-	     __i++)							\
-
 #define for_each_gpio_desc_with_flag(gc, desc, flag)			\
 	for_each_gpio_desc(gc, desc)					\
 		if (!test_bit(flag, &desc->flags)) {} else
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 0032bb6e7d8f..3e7e58be31b4 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -813,6 +813,11 @@ const char *gpio_device_get_label(struct gpio_device *gdev);
 struct gpio_device *gpio_device_find_by_label(const char *label);
 struct gpio_device *gpio_device_find_by_fwnode(const struct fwnode_handle *fwnode);
 
+#define for_each_gpio_desc(gc, desc)					\
+	for (unsigned int __i = 0;					\
+	     __i < gc->ngpio && (desc = gpiochip_get_desc(gc, __i));	\
+	     __i++)							\
+
 #else /* CONFIG_GPIOLIB */
 
 #include <asm/bug.h>
-- 
2.45.2



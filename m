Return-Path: <linux-kernel+bounces-531287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C726CA43E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B21316AEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29868267B73;
	Tue, 25 Feb 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KwSkPt55"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70717268689
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484594; cv=none; b=YSCQk7Iz1tK9znzprxuJErBIezuoJ8C54dcT7TLZQy4xTO4biNLadvpiysWbaNTWy+R9g3rpD2Ag1rPEsGx2klSde/sP05hBTRw4vIYzbsPNmy+yADOjvthl4V22LfHUV78xRRuzqH/Eyt81lU16/fG9rdUMgMGkH7y1AAidNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484594; c=relaxed/simple;
	bh=Mti7N7TampMJEA85fEFqM/SWyPHekb4T8hMC5Q9KEIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nr0rnkwwSF5M+YbeRNXKBw1OrVvenH1bySIMu/WTbHsGZbKxIbMYNp7pj48u+e0ypM8ahDBz26QWLJvdUsgf8F3GT7/YC6v+3++/U2CmXuWCvprag83+5eExPMPsMwSM90RQRjNL6tkxNeNMVZHsdeu7vpSI66U7e9N4tg3bZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KwSkPt55; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so52055605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740484590; x=1741089390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VXUEb/ixDS8VUxbNTLQP4mnGoLEwCu+P5iIlLIClao=;
        b=KwSkPt55zD8GpgiTHELk3OCn6SOVqmR0IowNtdRHohS1Uz4l8Vbr6V9s721KB+VJ7j
         /J3xkEYWda7X0jRevxqYr3yb50HqF6EgpOa+SMQRdFNQDUWjLqAiOAlIhs3SNuEPQPQe
         fx89DKthg+lpayiVwf6k8z1KcNOZc1j2Coh+OomI4Ya8Za+cnjD6nId88QSN7eU9jXLM
         weACdEqBew5y3/+BB+tHJPsqI2CijFvhrzOqUn7gHF0ouNYIVmPfqm4BAsSS2ypx8WLX
         R7hzaUfHv+Z5sj6f5dPTg0aQVXutORkfHlZkM9e9QStafrGykvuSZNgbTwD1GVZ5VtDc
         z4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484590; x=1741089390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VXUEb/ixDS8VUxbNTLQP4mnGoLEwCu+P5iIlLIClao=;
        b=eISQB5Mhub7D94iOzO32ix/620NCVu0rVL2gFig+dIK2mp21S7MaIZiPlBm/4csgfF
         nsNfOvqc8E6BMLeGGsJpTBj2uZPnG9e766puszyo0rkBORp6sVFnA1Jkp7Yw0TKzvisL
         pT4gFwvt1KJ3IY7NN8oC3JoRS4NbxK0YAfswUlzvgtz9jxDz6Hr8Z3EZvBhoNMajCEpy
         cUnyXjS5FVipSq21q4FMiXrnBAUZeEkkOdr0vP4zAHalxB9reNEKYt6kbS62zVhkZ2bn
         qPxLEqZ+Re9kk7lIa23hBG6RqNq2KjBqjzBlCXdlXL+/JuIMPDmMq/BlfIKl+pTEKahG
         /1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWsmCFEBci5ZF8NG+fpzGNpuTEEkIUpi/h9E9B4LqcbWdrTLVii4CDeLnXgcb3/C7ov60XKZ3NLE5NRXj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBy39uo2ro50RMpeNYZFH9rccGfPRicyfI9kXPZFCBv2dnn7R2
	vLP38jFEbNLt56JcUXPVrW4n32wgHlRfdeSAfyk6Ta9NgVilcdxNiGYH1TOZ8kg=
X-Gm-Gg: ASbGncusjbD/wSSiGFn1atswZ/RNBl2vEEBT+aT6JeA0iqoINs0jWYJ8Dow9SRvX9BE
	lrSdsbOSQd4fHOmWt32k9DUHokD9LktpoiUqsdgqWbiQeahTSLG5Iw3PWFmY+z9N4yyhxXLp3pS
	Z/SHLvgzIJB5wEPKcYK7x3woPuQJvm9W2QXGNHq9jRwQnoBBGgCMlRrUNmBDRh6+pnvEf4Zy40I
	Mf+/gjT9LJtCEuGWgNoeLp4EuMVMAsmGxztCqbVgNSl6LO8L38JHk258QWSZII+bWh23Zu3l53d
	LEPnzAOntGt5kCJBaVc=
X-Google-Smtp-Source: AGHT+IGhNAzd0cwvKJlCcUBz4fFnTGPxFvxtGsmUDBHWAvkZ/S5MMekNH4MM1kJfOrBEzZienQf0IA==
X-Received: by 2002:a05:6000:186e:b0:38d:e572:4dc2 with SMTP id ffacd0b85a97d-38f70826839mr16768704f8f.40.1740484590445;
        Tue, 25 Feb 2025 03:56:30 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:15ae:2cfe:447a:4a32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883521sm2058054f8f.56.2025.02.25.03.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:56:29 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Feb 2025 12:56:25 +0100
Subject: [PATCH 3/3] gpiolib: don't double-check the gc->get callback's
 existence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-retval-fixes-v1-3-078c4c98517a@linaro.org>
References: <20250225-retval-fixes-v1-0-078c4c98517a@linaro.org>
In-Reply-To: <20250225-retval-fixes-v1-0-078c4c98517a@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6atFFEarXWb+TlxXxAZ8zvN/XwNKSrTyBdSfh9C2z2g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnva/q/AmJ17Wymqe4xC7L2pemu0T0vkY2LjS/L
 033mY+Bz6uJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ72v6gAKCRARpy6gFHHX
 cqegD/96DdPjR+YM/W3XOgAGfDVn4rpB1amn1VB167231QWyCHnDLZcC1GA0i3dBcu8oLunOygq
 ud1Yh7DH821xcPFiYkURVHaM/1UWGDkF91NgroW10LLpCzG9QtxczwyRqVn3Iyx82pvjcm6dt+z
 5H/KlXAqJDpX5jvHh74if1UQ6z+z4Wk3jYq7CGCbSSWJhgheKUenVFxqnMdOFO4cbXZz8kZ8/tW
 9gYBMKLIVhI1wLvVxxxwVRv4AEn4szanmnxSwaR5+oPpzDdOomLNwbmfvzsicjMAfUlmgM6h99E
 fRYX1DX/jZiORTaZS+zGepDSj0jpcRwzY5I1RmdoC7PUdrkon7XeBxgjuF5nqSCDN7A9EQN9KZY
 jYhJE8Obxj6o4WIS6IEm1YsD2bcQMpuJhV4XO/+rLHSRQwGVEgBg8E4NWCqCSD/xtgi4FfR+kpJ
 vkybu+DQLYbPPpA0cnl2btyb4s2b2x9SyA5wUdFz1Wubv0hi8ZtzW6kz3Q2VgYE3qwyct9tdZCA
 CYGGp6W9+y2BPJAnZ3o8PBGH9BAV5fH/1K0ScP98J8lbjvu+WbwbJg+e6U8dYBrwuCKMXuZU8AU
 sKnm1nHNyZv/O+p33x0glx437P59HBdzjAaZDcYyHSwX/8bqmUQHEsyNMy8VcpFmoDPiraXAXKN
 mH9qS4d1LgjjOwQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiochip_get() is called only in two places: in gpio_chip_get_value()
and in gpiochip_get_multiple() where the existence of the gc->get()
callback is already checked. It makes sense to unduplicate the check by
moving it one level up the stack.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: https://lore.kernel.org/all/Z7yekJ8uRh8dphKn@black.fi.intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d076b2ec633f..b8f10192f27e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3158,9 +3158,7 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (!gc->get)
-		return -EIO;
-
+	/* Make sure this is called after checking for gc->get(). */
 	ret = gc->get(gc, offset);
 	if (ret > 1)
 		ret = -EBADE;
@@ -3170,7 +3168,7 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 
 static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *desc)
 {
-	return gpiochip_get(gc, gpio_chip_hwgpio(desc));
+	return gc->get ? gpiochip_get(gc, gpio_chip_hwgpio(desc)) : -EIO;
 }
 
 /* I/O calls are only valid after configuration completed; the relevant

-- 
2.45.2



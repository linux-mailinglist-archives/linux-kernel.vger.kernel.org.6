Return-Path: <linux-kernel+bounces-533506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC8A45B69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995AC172D05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE8124E01B;
	Wed, 26 Feb 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wtjJgX6m"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417224DFFC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564761; cv=none; b=Pvg5nAEDc/RchM4y9UJrEgmNKJGVj8EF79K4D1HFtZkvKLZ2xdm8l+Plnc6L+PwwFMFgjwcQbyUHQZTpesrM1Fa2YyGFyH3TwkqzTK1h/vHpaKrNjloRSPXMzoGVnBS8/x+OW1Igo2hpgML1eU8s1+0ZfmBpBp2Kxz1dP64OfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564761; c=relaxed/simple;
	bh=yl4u373flK8LJfjWUsP2xVHNgE+51/Hq8Uvf8MU1tjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sR5SPr+uGCyeoAJiff6Ya1yY1fF6EaZzzN5iYqavWO+OWd1t+4oNjZJC64o6WN6psUDBmrIVM0/YZHbZ2W07kHgX2Yl8PukStNP5D7AdGcE7Cv5RG3PbtPofcAl1z2VdI+GgDuauudaHSYHxueKmV5zZm0mCLaomb5ZodTFJzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wtjJgX6m; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso439703f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740564757; x=1741169557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPAblM/ytVXYD0FxHSQbshSRnztgL04mI7LHXRwbPuA=;
        b=wtjJgX6md7DIvKYdLF3LoVXjcgfHU3tZqcbgkecSlYGXl8ZH5XvK0qWW56JVKkdRM5
         JxdPB6TljzOEIPdp2Ld8yxscRBXiBwuKudcAZMeMS9PE3QhyP+gvsblTS0VaCqh8iMOC
         k/ksTbs54Ay6a7oFjFrTjcuaHYip5jEDIyE9JgD3LctGQaWmXmMCgSWvhQfw0FbJnGo1
         Urcr7q2wU55BkxcstEOZh5knSroCNwDfyaXDMIANuADlPFm3wyw3bq+GilP0krtWdg+0
         6+O5m9FfMYUP9FmZqnzWgsK3YnUXqvuDdsvTD3dn56uf45THamdQrOd0as0VTJXkfmKO
         i42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564758; x=1741169558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPAblM/ytVXYD0FxHSQbshSRnztgL04mI7LHXRwbPuA=;
        b=CEwN2/huPXITWayksszmv8kLM7cTmBMckDoNkO3bbMrnEH/45WcfmuadapPPnxO5Cs
         BFWRl6dblROz4WjSfU3vSEDNgWUfW2iNgP5qAhn5TR+Jo88uWDLTjkEWaRw1LP815g9A
         7IL822C88Q6oJMAscUF5onnIIKekxwM5YmYj6GuPZZzXULfyY3y06xLrbloGSnXH4YbL
         4gb1tvTUqXCQWnTPgugx+BlS53kaDxDm6NPmROr1jNICyUi1rW2ivAiAkHmEoukRoafE
         /U6QrO1EOza7XBIcwq18YhMOFtcmyy9zukiKQ5Tiqg91/qkyqJcc5SwdvoYko6rF3YMG
         q3bA==
X-Forwarded-Encrypted: i=1; AJvYcCUZWeoQy+Vw0hzfXeu2odaip70PHw4NSoXV1jcvbfklWFN5mWI6/nx9GeBBQxdc8KsArTmzZWY9KHZW0j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwfedhnqVyja+osHSL7gLEsqb1elhEUFELqoiW7Y4wT3plepp
	7RnEdV8NncfueefRArO3dDrjocrFWvh33JM7N0FUT/JNqHrO0hQOUV2jACIoPhY=
X-Gm-Gg: ASbGncv9rXT3PGCG5WG37xVocgweK2kb4axQKtELIT5Tmw6R7tjrIRgwKpkbjkP8wm9
	6T8dFn5EdMSHR5T2iCf1T38NUuoQhkxYbSG8H8JUcHy/GgU0Vmk0fcPZ9vZT44OlNNdWf9LmiOR
	qf8rydg+VszD1teqehkoSi2djY1HxdMtivJUE/QdgVCBUviRwVP/VV2EQ3qVXoLTbdHMjLM9D0T
	G4pZSR75yLd07Np8N5RDWL+VIa/tgzXdq+YdDWzjLHNbvrzim4bujFchWMlPNqmYUVU11YFsxnT
	8K0cjA43fqNC/c1+
X-Google-Smtp-Source: AGHT+IHw+bfS7gpMnzsf2DgNmUri32seSJz1+dPSYtDo9d0ITkyKGqVomiEoZhjVURuzeKQ9X02AOA==
X-Received: by 2002:a05:6000:1f87:b0:38d:ae4e:2267 with SMTP id ffacd0b85a97d-38f6f3cd3cbmr15942757f8f.11.1740564757589;
        Wed, 26 Feb 2025 02:12:37 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:7d02:26:5770:658c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d649cd17sm1483971f8f.79.2025.02.26.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:12:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Feb 2025 11:12:31 +0100
Subject: [PATCH v2 3/3] gpiolib: don't double-check the gc->get callback's
 existence
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-retval-fixes-v2-3-c8dc57182441@linaro.org>
References: <20250226-retval-fixes-v2-0-c8dc57182441@linaro.org>
In-Reply-To: <20250226-retval-fixes-v2-0-c8dc57182441@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=L6UhmUffsmnJ8WOjgKKZG7Z+1T8Z55OqnZX+P3gqo14=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnvukRT1APi8R4HYEl7lqYNlvJr3sIjTg26NOQz
 pE42xfJ8FqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ77pEQAKCRARpy6gFHHX
 cl8fD/4kEkdnFtjtgtYKMBJ0MqwAAwprVYwFXpEpoVTBWEnrkfRVpJPuscxNFGLE0z1ky5ASyge
 5bV3S+XTmZ6qJquvkExLqpl6GprNOr9xfWC5dYJogA7aQCi4AEMvUYFuI2AIwJubMSnq4eHsEwz
 sZYCMag4n0Eu3oUCdN+zgnj/0S2zUFfNAsKySLJ2/lEPYXH2BXfIqrZTKEfetM1OJo/TFJF4vay
 0shro278EkfnTIES3lm8kMqv56JS2SZrh4XkIS1CdWnrrwOb1NhkytzVlpt22KEwaPBy1Q2KE8e
 vVSun3el3Sb7yatNIFY+vfY5BR68/lUvxgCmSWPsky7Pph8aQ6EiQJN1SVNUFcoVBUBuhbnrogt
 sEhZVqVcsvdCCloKBNC1Esh7v7COwScYUFmeJ82Jg+Zu4tR7zGtTODVho/IcOY8YLUECD+R60v/
 g84tWR6ajnc+c6V8iGMQD2oVqlTns9Nc5AwdM5JFYRtS+OF/nxKt3x4++QRhTaG29ZVzD0gpdKI
 15hWMGowbXB0g5NW6QtiiRii4opyvLN6q7eWf+d66hQQk61gfIU321GIBavGvoCaiitsAvhFNvh
 XmilhYkNYq12CvIO+5vx6pkZ7Fs+jnELcGpZuFaHmKjl41ovKGP0CXTB36JuvRpkHvAvQ3XxTGk
 J0yNwM83f2Sr48w==
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6f4efab237e6..855373eb11a8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3167,9 +3167,7 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 
 	lockdep_assert_held(&gc->gpiodev->srcu);
 
-	if (!gc->get)
-		return -EIO;
-
+	/* Make sure this is called after checking for gc->get(). */
 	ret = gc->get(gc, offset);
 	if (ret > 1)
 		ret = -EBADE;
@@ -3179,7 +3177,7 @@ static int gpiochip_get(struct gpio_chip *gc, unsigned int offset)
 
 static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *desc)
 {
-	return gpiochip_get(gc, gpio_chip_hwgpio(desc));
+	return gc->get ? gpiochip_get(gc, gpio_chip_hwgpio(desc)) : -EIO;
 }
 
 /* I/O calls are only valid after configuration completed; the relevant

-- 
2.45.2



Return-Path: <linux-kernel+bounces-533504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4896A45B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D310B3A9CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82D24E015;
	Wed, 26 Feb 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oykU5rVV"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B0226D1B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564760; cv=none; b=PdGanAYrBjaNicoxLvBVqejKrKAAlek9tekHdcttoNdpUP03VjtpkhKnaSgMHNZC/+MxG/FtP7EgzdWqUUwIa7kPK4xxyq7RJ7u+dmb1lkfQkzl9C+s2HhMR1eypc0VnLgWAt9VGB0FLNK3AZmXoRcpe44D7e2yj8J/g/gefzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564760; c=relaxed/simple;
	bh=T+DvWoJ3d600gaZLdiqHUPv0OxB+F9ErVNNtwPoM0so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uvxf3CE1wJmQKSxszhqbrnhpfRp5b2TIT73Qy/QsgN8A/8yH4YHpTmCoN0jPNXLIfTOEC7W8TlrGPM2lMkYuSdx1B60ZoxWFAqmOZCLKfGc9yKJIQoMWJzRuTEwomHknjrMYhRtzj5lJzAPmyKDApxxrrRI5r+oms7kRe126IV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oykU5rVV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390dc0a7605so182869f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740564756; x=1741169556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBuSqv8U6oPt+UruofT1eAcRQvGHYTW9Mm81Y61uXjQ=;
        b=oykU5rVV2nxoCJOvurNAeAOZea2b3Ku6BOry2i7nKHZzN6L3plJD/sfVyqifkcdk/g
         i1hfmmugKG+7w8q85BK/eHd8Abc46EDsv0QA55NoAVy7Xy6qRu8bFYPOB+03QZfjJmTu
         TycL6KA8kmmFP41MU0F13gOmuF1EYmOqQ0Ott9GR0/MoIkNRBqUYWxxKGHMym9/uS0dz
         raxaIxweYgyi3seojouRLDQ2B7fumyClwZswNkyXo7WMUASDOJEIysmLK+ibfUFc5rNx
         Xbc0yZEAHpxEcWO8NeBJZuXD/lK3rbpIE/DJ41uxzuAyMhp/8AAL8BENG+TUKBK4JvR8
         42GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740564756; x=1741169556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBuSqv8U6oPt+UruofT1eAcRQvGHYTW9Mm81Y61uXjQ=;
        b=nx+xlnz1RWWDhypLaTs8s/pvR2VDpLZWK7KuN/ItkHB+vH7xTkdATsOTJdpS6EMeUt
         Anggb5Vfl0ElDLt/C1CQS/JC2tzNRYf6+iRHvM5+kOCAe76gYuWrGY0W7GZemrDZE1Ls
         nzl+zq6fNoG2c8Jx0eIUhpwz5dUdEEOYxwMF229gWRqtzZu2kUV8v/2n2BJcw31UqPf6
         6xEYwppGn6kVs246RG+CHH5ZAIaSUuftQ13XzK56sbGR9Yt1bRPbIuIQH/LFGgGypMAk
         mIhR3Oyi1zpnoCI85mu8IASbtr3KHPc63jrYS/zYUpd6q3vQESqUuuwgBJBRmZ+aa2UB
         KM+g==
X-Forwarded-Encrypted: i=1; AJvYcCUBaYkqKKDPcloXErhikpU4Wv6lJbw6Zn2PlhjdfX9FhJaQSKjHyWanZEVwdojlcn1U2Yq5C1GXpsqEOvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLq1DT8i1Ejd7+6LzmJBC6h3H0t6FhaCxIzoAdXf9g4T8rDw9
	HiNWRUDWaEo1oiTv6JxfbTb4reDuSRAOzB2G7pH8PnWLKa3GqMer7a9G7FldSNU=
X-Gm-Gg: ASbGncsiZEXe9kgK3urn18ldYst/kXsU5Hi9vKwr78g5JvP2VZ9eU+Ku3BjQbojgqv7
	JqzEY8/Fbk9bEMvjQP/rsr9JS0uzBK5tD/uvH/mricAaAoELI/puKTW8MoO9gpWlz5wjECfMSCE
	/ThrC0QUjPJxPq3xMQL6thPoM5yIeQfmRD5M65HSHuzc2cQPZqbn3JDwZZSXtHgZWnA1ORosxe1
	05DdDWR6WC/HAWayCRC8Xn19y1NO9LrY5e3NFWPYyQaxDibSn21rsqp/Vh9Uz9Ix+loPpF/DY9w
	72jlBwD7ybNdjbxC
X-Google-Smtp-Source: AGHT+IGXahza8+pgZHBEcw1zePUFK+hWBCP+n/Guhk4nkRUypakh/M2YyW49+Qbm0D3vBistdRcyPw==
X-Received: by 2002:a05:6000:4026:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-390cc5f5cc8mr5148096f8f.5.1740564755790;
        Wed, 26 Feb 2025 02:12:35 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:7d02:26:5770:658c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d649cd17sm1483971f8f.79.2025.02.26.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:12:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Feb 2025 11:12:29 +0100
Subject: [PATCH v2 1/3] gpiolib: don't use gpiochip_get_direction() when
 registering a chip
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-retval-fixes-v2-1-c8dc57182441@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=T0U7zjnCJI5TuBh0FRLafeo2x7uRS6C7bNJUfU7L0Jo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnvukR0zWoGJb1QaqisH627aepIT6mvQ8MiFtUw
 2MpuzffGEqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ77pEQAKCRARpy6gFHHX
 cvhRD/9Y6xIIcxHUuGIo5YT71HKxn5aN04sPKG5awKJX7eZ0TBA18ifJJ66R5EUZs7pAzBQvnKx
 4vpUaJ+P8cUm91Ah6eGtOWy71tmB8J96aASVF9qLfB63LKdyJ2/r39KIgD2ZJVFs4Nq4avi/o+K
 voZ0FEP7GyX2AQuoqueKHMBHmrLxML8kuL8104AUeMlGDQ1olTPKXoO8/bMIbwJTgCRfiWtvZfU
 IeUCndz6TnI//ruZt7eVqD4y43lAMMlGJRV/WxC3RYn1lKedpVxaHLk25QS1T0+KpsM9upffHTT
 ZxzREAdYKag4TgoB+VWQR6Iua7u5jOi7Dx2O620k2fC9l0B771Kw08F6n1ruSvv9y/269iBrAFK
 Xj3j+GSsOlYAIWY+RaoXGXI9Jr2ouYBr98B54BSWzPTwHI/bcRAbaKICCQlflAseMnHx0zIrJBz
 g+4SunMsmXbOXOaVwqj7aH6R9dwXQFRIGnTroBMCXeK632mBAmVpGK52EG/5yt4wl2ls/khtyNl
 Fde/jmVJD/ye+0f6xV0XzDmhxEmIKm4Wul9RWRq9xuxGcn2RKtNbYDOJmGQh9gjouvgbuGVGCr7
 IFjcZcHAh/0mMU6xL7w5Lzk4IUbKC6l7p4UsdMYgE+P5/LUm6Mmrq7jnKFPZJJPT1FF0PJIRJ6P
 X3hMKkGo7HVgE0g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

During chip registration we should neither check the return value of
gc->get_direction() nor hold the SRCU lock when calling it. The former
is because pin controllers may have pins set to alternate functions and
return errors from their get_direction() callbacks. That's alright - we
should default to the safe INPUT state and not bail-out. The latter is
not needed because we haven't registered the chip yet so there's nothing
to protect against dynamic removal. In fact: we currently hit a lockdep
splat. Revert to calling the gc->get_direction() callback directly and
*not* checking its value.

Fixes: 9d846b1aebbe ("gpiolib: check the return value of gpio_chip::get_direction()")
Fixes: e623c4303ed1 ("gpiolib: sanitize the return value of gpio_chip::get_direction()")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/81f890fc-6688-42f0-9756-567efc8bb97a@samsung.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e8678a6c82ea..0d325cc41af3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1082,24 +1082,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 		desc->gdev = gdev;
 
-		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index)) {
-			ret = gpiochip_get_direction(gc, desc_index);
-			if (ret < 0)
-				/*
-				 * FIXME: Bail-out here once all GPIO drivers
-				 * are updated to not return errors in
-				 * situations that can be considered normal
-				 * operation.
-				 */
-				dev_warn(&gdev->dev,
-					 "%s: get_direction failed: %d\n",
-					 __func__, ret);
-
-			assign_bit(FLAG_IS_OUT, &desc->flags, !ret);
-		} else {
+		/*
+		 * We would typically want to use gpiochip_get_direction() here
+		 * but we must not check the return value and bail-out as pin
+		 * controllers can have pins configured to alternate functions
+		 * and return -EINVAL. Also: there's no need to take the SRCU
+		 * lock here.
+		 */
+		if (gc->get_direction && gpiochip_line_is_valid(gc, desc_index))
+			assign_bit(FLAG_IS_OUT, &desc->flags,
+				   !gc->get_direction(gc, desc_index));
+		else
 			assign_bit(FLAG_IS_OUT,
 				   &desc->flags, !gc->direction_input);
-		}
 	}
 
 	ret = of_gpiochip_add(gc);

-- 
2.45.2



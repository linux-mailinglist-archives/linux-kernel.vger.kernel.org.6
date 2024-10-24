Return-Path: <linux-kernel+bounces-379802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB39AE400
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C621F24684
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7255C1C9EDC;
	Thu, 24 Oct 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vkyZrL8H"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2F1D5174
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769584; cv=none; b=hxBGLGOt4uLcLe7u4HPvwQDPuIwG/2DNfoTUIu+UY1cyl5fIOkPeQpnGwqnITB2gX3XjPaeXJ95B/CB+bXZtzFAyajDYy0UtLmSX/juORffuzS36PiS5Q4z+Pz0X2Cs5lRZ3iIxCUkOITzprcp4Z8oe1LKePrVFlYypn8KFwjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769584; c=relaxed/simple;
	bh=AcP3LRuJVhQQb1vFB0v3JqR/A+j4tQ4v91oKntLbohs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9/SlJye+4hBQPWQiJKZeKs1iKqxy4gnjWNKAb9Ibm6/ZtgpMQwMFS0aCvH/YVaEoBj5uKi5fYwAUO7WVR/8PmzJmaO75Z7+7c+88hHPbRMoofyXHPHdBO7+GYcIwFFSKNrdZCjLL8iuECJ0PjDh+5Otat8kDqqSw9Hwosw20/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vkyZrL8H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431616c23b5so5788685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729769580; x=1730374380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVUCjb6yUFKCfRWoeiG90YmWbQXs1nb8uTKus5VOhlE=;
        b=vkyZrL8HkQ65y+rOY/Ni+9CQD/iBYI3QAfzN3J+souFgYq51zor5Dt2RN32YtMLCx8
         4kcwGYZ7BBispm+Nne6bpuLspMvVbxdbe79XVUaHIg63l555HVhNuBktCeIt+GJPVZmB
         zBk34PRV5Xc7dPmCiU2Zf/AsmeFpWKF2THfHGOzu8WtiIdOqtnWpQVVaVMn/xMovmIxP
         c9kYb/qaP1E0a8a/nkZ2SfbWPvwAiYRNeEz/CzGduaWJSaMDI8BV5WtnydGLvBDNG4fI
         uIQkpAoUsJA6p2U7OWoAVUjZ3kiRmaNRi5TDaJUad7kuY0TUVhgnKFVmvtmlgOOH+Icd
         uV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729769580; x=1730374380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVUCjb6yUFKCfRWoeiG90YmWbQXs1nb8uTKus5VOhlE=;
        b=VRkhFQ1GNU+Fta8SryYIL9/jfNhGkYx4N+qgOX2D4B2Git2Or6c8Hv8U+GRiSnV6Gg
         BwKCTKkH79nFyfqEP+ZFxknF9kgkfMzr6NZQivm78v+Arkao/8a721TcHLZli3LkFXPY
         eRRkB68wB942G3kOskp3QFiD4EpVJrFhhjCaeeIlIrfTdRATXiDPeYsC5V5iXiedpn4w
         khpTQxj8YZfn2PHEcibshW3Qa+IJKHgi4XP/WBKkSYi+YB1NXGb+Gb9+TttaK1XrzdzN
         thHxG1u/QoHVR3qVUo1MNYy5MnY8jddDXOnZZIR3aCM24cdCzYHAYXE0BSBMMktZqCSX
         WK/w==
X-Forwarded-Encrypted: i=1; AJvYcCXGngAoGHYfkZzwAhXjVpUUwCniHtj+3fU7A/YicfVjOLT8ZG2kIICvk7hiM5lumoV7FEAefQOAiv+l2g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJElekBlRwDngT0fYq3xW2uYBIIwXaD+asRX/2s8t6GDDjzA3
	LkhpAeOJXw2AK4MJ4wnZovinAsp9iFtWtn1SQ4P8RfhpcksXOHnyvy+SL9J64J0=
X-Google-Smtp-Source: AGHT+IGSFvBKFRVFvktWFj6u484K80hk9Bkb8d80U6lHG/wU1Z+nh1AwX5AZM6vnAwkGa8gBq5QYhg==
X-Received: by 2002:a05:600c:4689:b0:42c:b826:a26c with SMTP id 5b1f17b1804b1-4318b5a561cmr11467275e9.8.1729769579999;
        Thu, 24 Oct 2024 04:32:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:17a2:e679:56a4:a25a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f484sm14592705e9.13.2024.10.24.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:32:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Oct 2024 13:32:48 +0200
Subject: [PATCH 5/5] gpio: sysfs: emit chardev line-state events on edge
 store
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-gpio-notify-sysfs-v1-5-981f2773e785@linaro.org>
References: <20241024-gpio-notify-sysfs-v1-0-981f2773e785@linaro.org>
In-Reply-To: <20241024-gpio-notify-sysfs-v1-0-981f2773e785@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IMu9CPsbEhOzI49XGiXeQAFdqhkYj9ry4r52yggQ+4c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnGjBlLHjX2h0Wt6sRGmUPUdxKOZh7OEMvVxdYL
 Xp29YZBS2+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxowZQAKCRARpy6gFHHX
 coivD/94qe+Tm5SWXorKelZfrrNlk2Uj6NapVog03yPeDXzF1UewbJKqwVyrI9OEC+4i3tM0eDf
 1rQo9iuhfTq7itJuzOVKFwPh9xn/+a4xrEZDDY+0hrDWJb/ESqJFE3D5i0sA+GprxR/5juR45uo
 rs2sRf8SST63KLOF8REItZrZORCkTwXl/Xc3CqE6wcRaNsg4ROFw8+7qx/x5cQ1qVF4B50yPme6
 VuRN1+rFuOobMOB5AQBDIRHuYbpIsMmMUpgTfaLrYsPq7xWJVzcsyn09l4Nw3K3kUPkx01WkMSv
 cCYdCeIAo0+ngVYlFsbYd28aDG+2VPiHKAyctkbKThmLXcCNml3tyamBbqynxul7HhctamWnyMz
 Z5213noBOjMOLS7Ce7X1FJaC4BYSRzKpNgB0p9lzx8xsedlRqNEr32m8mXIPeg2QDpXWGHVQnbH
 5SnkyCPukEi0v0LgmJj48FrUhvR/E7jSWuq1Y0FXf3Bm93pVlkV3nnHCATg9dTmz2d8Hb8soH0x
 igS30XEYuI9lJmb9KZRqHT/AqfBB9OseGgVYZJScAAEG3cMy7GdZ/nS/qVsRMISqwu/qVBBPcZI
 G9cmvoHcWDvyaVUYTPcfVJeTyXYTVcbqsTyKOl2kCABudaYUCegbrwHrg+wEKjk7OIXbeDmME24
 T4eoJReqzpGrjSQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to emit line-state events on edge changes in sysfs, update the
EDGE flags in the descriptor in gpio_sysfs_request_irq() and emit the
event on a successful store.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index b967b76ea046..87f27a0288f9 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -178,12 +178,16 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 		return -ENODEV;
 
 	irq_flags = IRQF_SHARED;
-	if (flags & GPIO_IRQF_TRIGGER_FALLING)
+	if (flags & GPIO_IRQF_TRIGGER_FALLING) {
 		irq_flags |= test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
 			IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
-	if (flags & GPIO_IRQF_TRIGGER_RISING)
+		set_bit(FLAG_EDGE_FALLING, &desc->flags);
+	}
+	if (flags & GPIO_IRQF_TRIGGER_RISING) {
 		irq_flags |= test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
 			IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;
+		set_bit(FLAG_EDGE_RISING, &desc->flags);
+	}
 
 	/*
 	 * FIXME: This should be done in the irq_request_resources callback
@@ -209,6 +213,8 @@ static int gpio_sysfs_request_irq(struct device *dev, unsigned char flags)
 err_unlock:
 	gpiochip_unlock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
 err_put_kn:
+	clear_bit(FLAG_EDGE_RISING, &desc->flags);
+	clear_bit(FLAG_EDGE_FALLING, &desc->flags);
 	sysfs_put(data->value_kn);
 
 	return ret;
@@ -230,6 +236,8 @@ static void gpio_sysfs_free_irq(struct device *dev)
 	data->irq_flags = 0;
 	free_irq(data->irq, data);
 	gpiochip_unlock_as_irq(guard.gc, gpio_chip_hwgpio(desc));
+	clear_bit(FLAG_EDGE_RISING, &desc->flags);
+	clear_bit(FLAG_EDGE_FALLING, &desc->flags);
 	sysfs_put(data->value_kn);
 }
 
@@ -280,6 +288,8 @@ static ssize_t edge_store(struct device *dev,
 			status = size;
 	}
 
+	gpiod_line_state_notify(data->desc, GPIO_V2_LINE_CHANGED_CONFIG);
+
 	return status;
 }
 static DEVICE_ATTR_RW(edge);

-- 
2.45.2



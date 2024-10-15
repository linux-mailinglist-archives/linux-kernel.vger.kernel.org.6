Return-Path: <linux-kernel+bounces-365600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCB99E4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBA628233E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938D1F4FB4;
	Tue, 15 Oct 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U6e6gJfP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E101E4110
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989802; cv=none; b=m3G6Yp/S6nQ6ob+nOAWdYcpO9jwxEiBREFE1aUOOJS1bUBF7yWEvT+a8cjmmkDSpNVO5dKF2sghQFGR0X87zq6fX4sP6xdIdrAZZCV1QHacznqUyFPn+OMKy8JlksyVjsDRJgPMkXT79m4gIx9hS98IDA7f8Mdbre/mBILuectM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989802; c=relaxed/simple;
	bh=QwLsQS7+YTa0mwb1vrwV8L24m/vFtrTi/0g+0KOyv2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zl9Z579Rha8Yt/f+U+D15sXmNAmct5GJ0RpUvTjPN9IeWKkXw0XbG1rja3GfF9xZP3trY0Z3iF7XWTzYPelrjQsG8wm0TEMpW1WLN+7mOOHjurJZH4mxSPKVfG/gAp0poz03+tXLk+YTjhnIMHwB4DxTVj85EUWFgSU2RgGvmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U6e6gJfP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so39161405e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728989798; x=1729594598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr+76nULAqAGoFwQMgtDIWsEZhtzqWTjmTFSlRdLw5s=;
        b=U6e6gJfPnYHkUUsXTzNXSZ2Z5yC8NOyckMMoufPIi82DXAD56f+VTcizW40lvAErqf
         /L5MoOL1zUfdB+YHqy7h1/m4ReRnbJMgLK8DJ7QqAPpFAzG9dvL2wJlCwyNKN78Z+Oba
         SOE2cCQHxDFrGCVbMJQV/HdnMs/zpVfRGjguYLDp4ayCiZ1rRokQOUtOSA3KNtoinFNI
         56VEyDPhIhvderNqLCdsh9iNiyUiKG2M5XvQxhkLSpY0voKiC1WtNLCA4D6tI8HbZ3J8
         Oj6ivuXaNrxVGXmTNq5QELWarMczmDN7NBoQ5Vv6RVJdpF/LsqP6aQfD/khR+KKYhNmG
         cssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989798; x=1729594598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr+76nULAqAGoFwQMgtDIWsEZhtzqWTjmTFSlRdLw5s=;
        b=ef+4D4QSn6GL7kZ1HR5oAvDm+Hb5siyfwTvTpJZUOavOznflU3sBE6UAs3MXk4fnW4
         ESCuqHN1sTJB/+xyl+fc13KWmhBDDsJzBcsRsluTkS0jS1gWIilWIA2L4+Ditv18bnW1
         ENPnkee3p15wGt8F1RxO6Jsd+bGuBVwOYC0PhPKmnwSOd/9N2zRYR2WRYBXn4LabGpc2
         jLHM6WhD77LuDrGHCbwZbCdMl5619h369sxu2wkDluUTiLzgKQnEWrKtl03hTTxUnsyV
         p7wi4wp8Buv3iEbJNyTD/gUnjinEJr0rWXx6CtO9P9+SQjicJOSAZsMsMHPw5U1SjnY0
         wfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNNQev+DJRCUoKUWqpJAH2G2dZO1737sElDXtDT9/a2bC44eRnirNmY0gSUFzRjbC7J+7hR9sWbPPh/Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7PjH9WWq22ePsgguoC6p3RowTa/1rikWniIckCYa5i+2Hi/i
	uO3F0WR1LTiCvVdUAKg/hLpLYj0hzfkPzeWYaNw1e8aVeCTMhTeIWfOlhwLXeBcVQuz8H6NUQNQ
	3
X-Google-Smtp-Source: AGHT+IG1zc8U83uSOzFrmbYgN2ib98c7nSSxX0OXroh1zj0tYW0kCZmpF+Q+MCRz16Jl9L5ftOfG7Q==
X-Received: by 2002:a5d:688f:0:b0:37d:50e1:b3e1 with SMTP id ffacd0b85a97d-37d551b79c7mr10678598f8f.16.1728989796822;
        Tue, 15 Oct 2024 03:56:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc403d3sm1254115f8f.101.2024.10.15.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:56:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 12:56:17 +0200
Subject: [PATCH v3 5/6] gpiolib: switch the line state notifier to atomic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-gpio-notify-in-kernel-events-v3-5-9edf05802271@linaro.org>
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
In-Reply-To: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3446;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Y2EyvkeErztbFdHhfdU6K77nhrwpBwdGEoPFbeXCRO4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDkpfUZHsriwZiPEi4+AtbBBPPnuAC4IFx9aqh
 ije0Wt6/+SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw5KXwAKCRARpy6gFHHX
 clJaEADNXX83lmyEuAlg/uVQXe0YjUABAvjrsojScMrEtoWdZSDyx3abkfblB33eq2VVnHtQiSg
 6dffmdoYmT673m1HqbfH7A4LGS5Yu0KE0ePqUGJuOe19WLxfkDy6yODSOIHWHUx6snJwMfW+5fN
 4BZDU1madoZqZM2TgEVzMx7q3VeCI0c7rdBe/IpIrbraCu6YFjcYjX97b4nPdnw6Y5EZfGRhRIE
 iyfl0vzceypA7tZp8k2MsiLOO6IhfxcvG0RZxxJQFmRPEI/0HTTjwCSe7cd7Iu6ZQp78g/snbuR
 C2FBMJ13NM0XyQlMApHY+v942NhXRZC6JLH92y6gIU4/GkqoGVxpRWxW6pZ4XB0b0xjXscKELQl
 ZVUrlZg8l583gH2o+DJ9MFU5Jgs7aB2IHyaqo147VqMcvRZhf9lMr8vM616FoKaI4Z/YNB2yQwh
 TYmMhsIIF6F1RGgF8rRRFBRk1L0rxfqXLQbYQKq4eT4Lwmhv/fRKU2YmaT3g/VpX6f93tkYEczX
 H/NXyII6Z22hrhUYieRuUpD3LwDt/cvdGYgM1J0FRdJze9N8NwAU/sydVLGzEcu8tozdtMfdX58
 GhlRKALcQ+YmTtx9rSpPGb7VRsrvMRQILFCNDLLBOJy+jqB3CGprbL6dPI28vQn+GsbMTwNqTGm
 cCPjmtmWylBQLLw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With everything else ready, we can now switch to using the atomic
notifier for line state events which will allow us to notify user-space
about direction changes from atomic context.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 12 ++++++------
 drivers/gpio/gpiolib.c      |  6 +++---
 drivers/gpio/gpiolib.h      |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index a10d6ea22415..f8c69ef33888 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2848,8 +2848,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	cdev->gdev = gpio_device_get(gdev);
 
 	cdev->lineinfo_changed_nb.notifier_call = lineinfo_changed_notify;
-	ret = blocking_notifier_chain_register(&gdev->line_state_notifier,
-					       &cdev->lineinfo_changed_nb);
+	ret = atomic_notifier_chain_register(&gdev->line_state_notifier,
+					     &cdev->lineinfo_changed_nb);
 	if (ret)
 		goto out_free_bitmap;
 
@@ -2873,8 +2873,8 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
 out_unregister_line_notifier:
-	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
-					   &cdev->lineinfo_changed_nb);
+	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
+					 &cdev->lineinfo_changed_nb);
 out_free_bitmap:
 	gpio_device_put(gdev);
 	bitmap_free(cdev->watched_lines);
@@ -2898,8 +2898,8 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 
 	blocking_notifier_chain_unregister(&gdev->device_notifier,
 					   &cdev->device_unregistered_nb);
-	blocking_notifier_chain_unregister(&gdev->line_state_notifier,
-					   &cdev->lineinfo_changed_nb);
+	atomic_notifier_chain_unregister(&gdev->line_state_notifier,
+					 &cdev->lineinfo_changed_nb);
 	bitmap_free(cdev->watched_lines);
 	gpio_device_put(gdev);
 	kfree(cdev);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c09464f70f73..fafa759ce743 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1026,7 +1026,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	ATOMIC_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
 	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
 
 	ret = init_srcu_struct(&gdev->srcu);
@@ -4089,8 +4089,8 @@ EXPORT_SYMBOL_GPL(gpiod_set_array_value_cansleep);
 
 void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action)
 {
-	blocking_notifier_call_chain(&desc->gdev->line_state_notifier,
-				     action, desc);
+	atomic_notifier_call_chain(&desc->gdev->line_state_notifier,
+				   action, desc);
 }
 
 /**
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index d24cd9e8b17c..2799157a1f6b 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -72,7 +72,7 @@ struct gpio_device {
 	const char		*label;
 	void			*data;
 	struct list_head        list;
-	struct blocking_notifier_head line_state_notifier;
+	struct atomic_notifier_head line_state_notifier;
 	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
 	struct srcu_struct	srcu;

-- 
2.43.0



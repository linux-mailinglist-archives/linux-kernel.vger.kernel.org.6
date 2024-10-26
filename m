Return-Path: <linux-kernel+bounces-383194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D79B1855
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76966281DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C41D79BB;
	Sat, 26 Oct 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LlcBlX+E"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D161D619E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729947523; cv=none; b=Q4oUhfBGEZkUEPFFlYfn6V+GcBX741NTodWQ3QywY0rJMC4szHIslrr6N/xkYytswBJojux45pxitdd7HfDlL9ouHsYU9dQIqii8YC/p0OwDjmsjsVNKYmt76LC6Dn6yOndlzYlEKM6Konguhim0ULFlvftb7cSSRX4m4W8b8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729947523; c=relaxed/simple;
	bh=HropV407um4f/G9t3Xi5TzE5XLHPWiScIS+b5zddSj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpNhETa8OXWmAE7MZRTCS8cbPqL2iqWN/EOW8+zS7oEujOcmWZUpllbykfT8MF83Ivo8gDZR9GkkZwmQnNoAoFaPVO7e6MAQQ0Kbnyj5JNw85AnYwnpym1Hd491g/DI80DqjvhiQLaFXt3cscbmaU1BhBN7fZwDX7HiLdMglf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LlcBlX+E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so27636985e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729947519; x=1730552319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE8cLxQdEVDeLv9MNCBstLWMA/Z6NqCZrkQPPjSdQdE=;
        b=LlcBlX+EUKH8azPaDWbsSPasXYl0YOOlwaG2fl+0zgKdM2m7XhPt0nPON5XVCkXc2p
         Kknka80IDEfzaee2Yq/mgUCXPmSCxOMwf7mr3ro5zJAOghd61AVgPzC3wrjn74Jxrs57
         oWFx6GerLyz9kjQyLk8MSJR1u3w5aBuFbUdZDDeHdgjwcosJH9g/cyIEOsgZoRV0Zh0g
         nj/jGorbVZk/WHj4+ED+a1POaTpjc12VkKURlAkYXwWUJpvKVfHtEUhTbfrWt3HzVui7
         wLTHuZBTqSrxv8+bc5npRYw5p5uy4M/+w/qMUFPdxE6wxsURvXjAhovqS9QkHABK2Kr9
         4WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729947519; x=1730552319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE8cLxQdEVDeLv9MNCBstLWMA/Z6NqCZrkQPPjSdQdE=;
        b=CItQql4rGbtoC8FOkwruPHrsapq4NBB7YhIVNysqYplW9PudFTX/2lLjQELBz8P+eD
         IwLeV/gEJhEiv3iKAdKtV+/DGlQirQeN3xb2yfQc1KSNA3RyaXZVU8BQMshBYdqtehJr
         VJ3+I6+ujCn8JZxmsKnpSjrueQbKhOdFEUOQ0+lFH3QyYVmJnD72kg9BSQZKPqUz5H5g
         wK8nZ66BK4RRMjAeNT8e0Hxm1/R8oYaZHY6zEnwbSBNShXYhcrg7fIgrR4mspWpyUqls
         ktxMHD0doamCehySBt1dC/DqLox2GhojczBW18la2VC9UFUqfZjo9Kat0eD1wU9qntEV
         Mgaw==
X-Forwarded-Encrypted: i=1; AJvYcCWn4HOX0qllpvcKc2rsMOCgg7sOEFerHrkoMFpGTJRK8zDm3AZSZlbSxOVBPIc/rnjZTelAtJSpxoebhS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylI1xv/MfQgiaEMUtmXvhCG9AnhsY6zPmUAJVYRdVpfylp1V9t
	FcsK+lEkoMxyrZ+wpfB9X0mHlS2TG+Oxb+NX3IpsMPbq5lEDAvTREBrCp8X/YSQ=
X-Google-Smtp-Source: AGHT+IEnIrHs2M3Ri6ND/0ACKvKwENUZziAR+IDYzheSZ7MtKalmSu787M2k8JCTlFAL4S8HKgF4uA==
X-Received: by 2002:a05:600c:3b14:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-4319ac6f895mr21633785e9.2.1729947519143;
        Sat, 26 Oct 2024 05:58:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:617b:5770:df34:27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a3edasm47498535e9.22.2024.10.26.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:58:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 26 Oct 2024 14:58:30 +0200
Subject: [PATCH v3 2/5] gpio: sysfs: use cleanup guards for the sysfs_lock
 mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-gpio-notify-sysfs-v3-2-ad8f127d12f5@linaro.org>
References: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
In-Reply-To: <20241026-gpio-notify-sysfs-v3-0-ad8f127d12f5@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=dl/3eJiyQ7+gqXB4o2UfBU8KW4Ret4Run1NBj9XzUYA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnHOd6Np20PQ/LpcTx9IIOLDfWKkRigviz6stDr
 AdyWXXJBRyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxznegAKCRARpy6gFHHX
 csywEADYbhXvEw0KE8nTPHezf3eYhdiH8rHBFDB67Jw90cbU952EjjfkQ4vaBD9aSp1bh1jgAIv
 BiAfZhEqfJaeHKiXSs26VRN/whc9I/V97TzdrQTyEzVdC7j2zrDHtaM4DL1cRmfPgB6B8WyqD7O
 waaW/c4Jf/+9eWCfbzT0MhGRYvQUlY6oKb9nZum7M/Dv7W4Jfn2j/wMURjlmWVk9E6wenNqaS6M
 DKT6NLAm389YeuPlrFoSQxKydYl3DMOIlHZFl7XBVBFHQrFetv0g3uy4UVdwOMooFzLXa5x8uNJ
 ylriWfMerXL5cG6a6/4sor2hvN29HiuCVu8H+V1MAeWG9b2CeREVmHFDV40u++q32E+ThW4b//h
 uHHYOSYzVF5LNIVrwHsqUmslPSsQrY+JFcY6hhuviIlhMMFjRfygKdXXVF5e3GNiD9NajMtjDrR
 Ms+xXr7GWSJBcUYVBpHRGUqziMcMxKwcAe4CiSq2b16vqAjyNDlrTmK4GkedILZ4+FHADaOLJe9
 RXO9Yeow83nqfHFFgXJvoopdoJMsFFjSa60Uo9HqM0qA/nFR4kk0KaPFzH+Tn59sr1OaE7aOFBD
 bGYhxisOvJKZ8+7cCf1yAIiGb7KftSc4LynvNfkMEPFgT3yeImmNKOn5XXm+SwV10xH+DGzA6c9
 O3ss23pESVnDD9Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink the code and remove some goto labels by using guards around the
sysfs_lock mutex. While at it: use __free(kfree) when allocating sysfs
callback data.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 64 ++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index a0926a1061ae..72617f929a2d 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -551,7 +551,6 @@ static const struct class gpio_class = {
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
 	struct gpio_device *gdev;
-	struct gpiod_data *data;
 	struct device *dev;
 	int status;
 
@@ -575,24 +574,25 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 
 	gdev = desc->gdev;
 
-	mutex_lock(&sysfs_lock);
+	guard(mutex)(&sysfs_lock);
 
 	/* check if chip is being removed */
 	if (!gdev->mockdev) {
 		status = -ENODEV;
-		goto err_unlock;
+		goto err_clear_bit;
 	}
 
 	if (!test_bit(FLAG_REQUESTED, &desc->flags)) {
 		gpiod_dbg(desc, "%s: unavailable (not requested)\n", __func__);
 		status = -EPERM;
-		goto err_unlock;
+		goto err_clear_bit;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	struct gpiod_data *data __free(kfree) = kzalloc(sizeof(*data),
+							GFP_KERNEL);
 	if (!data) {
 		status = -ENOMEM;
-		goto err_unlock;
+		goto err_clear_bit;
 	}
 
 	data->desc = desc;
@@ -607,16 +607,13 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 					"gpio%u", desc_to_gpio(desc));
 	if (IS_ERR(dev)) {
 		status = PTR_ERR(dev);
-		goto err_free_data;
+		goto err_clear_bit;
 	}
 
-	mutex_unlock(&sysfs_lock);
+	data = NULL;
 	return 0;
 
-err_free_data:
-	kfree(data);
-err_unlock:
-	mutex_unlock(&sysfs_lock);
+err_clear_bit:
 	clear_bit(FLAG_EXPORT, &desc->flags);
 	gpiod_dbg(desc, "%s: status %d\n", __func__, status);
 	return status;
@@ -680,36 +677,28 @@ void gpiod_unexport(struct gpio_desc *desc)
 		return;
 	}
 
-	mutex_lock(&sysfs_lock);
+	scoped_guard(mutex, &sysfs_lock) {
+		if (!test_bit(FLAG_EXPORT, &desc->flags))
+			return;
 
-	if (!test_bit(FLAG_EXPORT, &desc->flags))
-		goto err_unlock;
+		dev = class_find_device(&gpio_class, NULL, desc, match_export);
+		if (!dev)
+			return;
 
-	dev = class_find_device(&gpio_class, NULL, desc, match_export);
-	if (!dev)
-		goto err_unlock;
+		data = dev_get_drvdata(dev);
+		clear_bit(FLAG_EXPORT, &desc->flags);
+		device_unregister(dev);
 
-	data = dev_get_drvdata(dev);
-
-	clear_bit(FLAG_EXPORT, &desc->flags);
-
-	device_unregister(dev);
-
-	/*
-	 * Release irq after deregistration to prevent race with edge_store.
-	 */
-	if (data->irq_flags)
-		gpio_sysfs_free_irq(dev);
-
-	mutex_unlock(&sysfs_lock);
+		/*
+		 * Release irq after deregistration to prevent race with
+		 * edge_store.
+		 */
+		if (data->irq_flags)
+			gpio_sysfs_free_irq(dev);
+	}
 
 	put_device(dev);
 	kfree(data);
-
-	return;
-
-err_unlock:
-	mutex_unlock(&sysfs_lock);
 }
 EXPORT_SYMBOL_GPL(gpiod_unexport);
 
@@ -750,9 +739,8 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	mutex_lock(&sysfs_lock);
+	guard(mutex)(&sysfs_lock);
 	gdev->mockdev = dev;
-	mutex_unlock(&sysfs_lock);
 
 	return 0;
 }

-- 
2.45.2



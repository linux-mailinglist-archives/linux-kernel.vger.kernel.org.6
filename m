Return-Path: <linux-kernel+bounces-358621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A59981D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4970EB2A727
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3E1BC9EE;
	Thu, 10 Oct 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R+ShqlCb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB4BE6F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551440; cv=none; b=exu3fi0KWHvb336JkqQJ3ZN/KIHTWsBhuOOMy1YtHUJqQIxXh+bEc5D8gQ8g+EEWbhYh/Ti0B8A+AYVmsktrDfour2ouer+d3x8iD4ChEX0gqL4XO0TGG5BXBPn7b8XPlZf6CuJj3neOoa/SWo62DtRQdwclAs012mgzi3Ll1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551440; c=relaxed/simple;
	bh=MX5vq2Zw3twCnQ0vfBjrVYXjMbbJ4a2HM8Fa/3xG0y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSZ5qJqYAz4g5WtbkcC37/fZhTQgMXnX0mYIxyf40GcwKFoncvMuarGeKAPeGqt9Z6kKTzFnlDGizyy52nR2XyQ/lTj2HVKk5JemmR1CPVqSCIASUDyqpdEtICCDmeWwnf0XvmSJRBlTW2UTwvhGje4loFRVrGzYtOXUj9XpmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R+ShqlCb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43117917eb9so3801665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728551437; x=1729156237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D00NY3Cf/2JtyTIZtI5Vh9lbTo/8NdpSRAvorBZeEPs=;
        b=R+ShqlCb0TjCOz1jF6BeS4ray2L315uZvqAreieRpfecXQgwtroAM9igJjXZagHvdQ
         c89s5uqIuy2V0ejNxyAJjfhBj1yVougAqrKazwibWsaZoiJ31pJnqF4MQXK+RexKzkXg
         TH/iqQa05k2bjwAWB0etlEf/NbtZgpjXAQaxmqWJ6lBlhA3n+qPaISxK1PhFm4nOYzMq
         dZ6h04h+TKom5Spe3T9lXW9zk2dxHUxeMirUiLjuRc0H58bfJQ2wPyor9en3VTAwvCyL
         rW3qnOkcYkrAPF+AAcgI4J4f+e5zGLDvsAArnFZYUgB6g+e2KYSlK1uyvaAddovEBnOd
         pyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551437; x=1729156237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D00NY3Cf/2JtyTIZtI5Vh9lbTo/8NdpSRAvorBZeEPs=;
        b=wWCQA6gZwUYKeekowbgPGULLLg2O5QLjFBpQ+uHOnQ6GzLNlCfcv1o2hxk8nWE4VIc
         58dBP2jTKRAtY+4O6HKo2PAy/LqgEbD2Q5j6YMr8eeBM0tU0CbvTUKEquNdxoiwUoEHn
         c05ec10oboX5Z2cXN8oTUFKMYPTFqlkkBhJdtBTRId+R3oQHixPThrPi9kHUmXj66ie1
         v1gU9L+gHh7FgnsF7E9GTZWpA4/a2aMfu0rXZ9wGyfFA0LxjoHE/8hRRTvYkA/qgAwKH
         iYMOWCErbVIx/Ggox0hLEdKPPloZXGOxAbTwO0lSyqjtFVDe16MNtT2M5ZGX39cYmOWG
         IxFw==
X-Forwarded-Encrypted: i=1; AJvYcCUQOaZ2WHkgf8GXm0Bor3OuGUyTGlQULCMws2ztjkgXzmKf+rHtWjlMzrmoTuMphzLuSmK3Ec7PHLAr094=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3YQiGxufHcgoC4ez3EoOIZ9Qoci8zOLm8z+D5tCSkRYlhxmYV
	FsHOSMY2leZXxB/EKg3EXAgqXlS7kc2S3hNukCRU+XUi/T0KrLBkorhKXenf6nk=
X-Google-Smtp-Source: AGHT+IGx2rbn6DR2nrQTzVhwJTUvzHvjPmLVLKKmcjkIKfyWANxiyhhnnZqHAVnf00qwcKLpIZz9GA==
X-Received: by 2002:a05:600c:b92:b0:42c:b942:1bba with SMTP id 5b1f17b1804b1-430d59b77c6mr39947815e9.27.1728551436712;
        Thu, 10 Oct 2024 02:10:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5e5d:bfca:20cc:60ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff785sm9913305e9.13.2024.10.10.02.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 02:10:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Oct 2024 11:10:24 +0200
Subject: [PATCH v2 3/6] gpiolib: add a per-gpio_device line state
 notification workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-gpio-notify-in-kernel-events-v2-3-b560411f7c59@linaro.org>
References: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
In-Reply-To: <20241010-gpio-notify-in-kernel-events-v2-0-b560411f7c59@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=MiiIteAMQR4VVa0+5869LlwwwlxisL1Uf9ne26/dPV4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnB5oGhyjG4BkUy5dAGcbZ87CfLoX8TjP7VsVC8
 NjG9KUqPnGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZweaBgAKCRARpy6gFHHX
 cuXdD/0bsnzDAzpD2eUzxe3HvLyNCZfLsljAWOxJ+eSgooWmfgouon2xYO4JKbfIJgvgmB7fDKl
 rMq92ReWHT59gkF3Ca9byG+29J/DDGsvdpdSpw8B1O1M7sbpV6xdjZ2BP8NqqA8nZNP8qL3Y9KC
 QVN9tgM3N8sfp4f7H+2D14x3A5sBbvjxSAIL1jOhVwvSDi+lFuQ5ZznsfzYe2zuort1790cTndk
 WKZaaOrNsaSHtGw7clF/UrZEO6gHKGD75KXBEC4juq7x7z9Uq0y6brICAQjPYUmp5iuDZJWVqax
 sh9NnTafiXXcyy/T0u0wyhvyBhndUzTynzsK9d41tj3QFWuM5YbFB0PedsStMF5s6+4BYF1PmSh
 n1vbqyGoAea/6rEgic1jU6/oZzwOBPLcM3pbbFYnEdY4JBlCzR/ymKQGsPYnwezcRVPvc5gv4Iu
 bGKDBd2NgqKtGHuOkuc/WCh4Oi/IYhc8JjTEltnATnYBkqh5QHMNL1wQFs3vXgEMzd5f4elYJUH
 1ScU6oW0T21pP51rixl6CGOOuy5mKcXAqzmidsUVQrNVTiorZjHYL5KEGoSPuJpBRIRqb4qk6Fs
 NGCawyhSAIXy6zsoYfN9u1mPvk/VzeI6X8h3tJz8WHJn8Pa7sYTbu19xpm2Ck/wCq9Pnu84c78d
 Kr0OAC10kp+5CHQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to prepare the line state notification mechanism for working in
atomic context as well, add a dedicated, high-priority, ordered
workqueue to GPIO device which will be used to queue the events fron any
context for them to be emitted always in process context.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 6 ++++++
 drivers/gpio/gpiolib.h      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 8c48a53b4fa8..dec6c9a6005f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2869,6 +2869,11 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 	gdev->chrdev.owner = THIS_MODULE;
 	gdev->dev.devt = MKDEV(MAJOR(devt), gdev->id);
 
+	gdev->line_state_wq = alloc_ordered_workqueue(dev_name(&gdev->dev),
+						      WQ_HIGHPRI);
+	if (!gdev->line_state_wq)
+		return -ENOMEM;
+
 	ret = cdev_device_add(&gdev->chrdev, &gdev->dev);
 	if (ret)
 		return ret;
@@ -2885,6 +2890,7 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 
 void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
+	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
 	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 067197d61d57..d24cd9e8b17c 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/srcu.h>
+#include <linux/workqueue.h>
 
 #define GPIOCHIP_NAME	"gpiochip"
 
@@ -44,6 +45,8 @@
  * @list: links gpio_device:s together for traversal
  * @line_state_notifier: used to notify subscribers about lines being
  *                       requested, released or reconfigured
+ * @line_state_wq: used to emit line state events from a separate thread in
+ *                 process context
  * @device_notifier: used to notify character device wait queues about the GPIO
  *                   device being unregistered
  * @srcu: protects the pointer to the underlying GPIO chip
@@ -70,6 +73,7 @@ struct gpio_device {
 	void			*data;
 	struct list_head        list;
 	struct blocking_notifier_head line_state_notifier;
+	struct workqueue_struct	*line_state_wq;
 	struct blocking_notifier_head device_notifier;
 	struct srcu_struct	srcu;
 

-- 
2.43.0



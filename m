Return-Path: <linux-kernel+bounces-341406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E643A987FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A14D282596
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1436189511;
	Fri, 27 Sep 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZQL33wck"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0D186E3E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422951; cv=none; b=Buu8aApE3chljdxfA+LNih92z3XQwSFUIjVc9UaJ3IUWpMNnobB/kdRSOnsJ+EV69QVajWcuAJp+Zkz6Li85wz6sQaTKOvM1lqhKSlfydFUKFoOPod9Fed1294COgAZd2CfZaQXLbaeenj1vA4UMYuy3c92ZkoveI8UdnsMCcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422951; c=relaxed/simple;
	bh=WFc3Z2Ci7iK0/myrsyoCWo27iBCWNjw4NgcDOnuMOxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzyxPUqlWtXttjbpS2LelVP6e58eL5NVTZRm2rSa93mb7CpIsNqSNpYA96Iylu/UNYg0iRgeook13awHyuK/HoTEGmJuAyGR6m4qeM0afylY38qFwFlFx/jpws/wUKBy0XePpP8xZz+gZBXQ24aBsivJ7j2c9pIEfewm5D5RV5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZQL33wck; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so11439895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727422946; x=1728027746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOdUobVOVtgiYgdW4L8/ozYZLZuDj7lViLzqUU9bECY=;
        b=ZQL33wckrAnc9qqL0X8NPUuoKfh0zlK7KUiKPwHdLxtHR58LDq8EwIUcwwPTtIyzNC
         PEHkhYnSu904jLbleyTFWMtVQUyQH5C/PtGOWGO91F9yymOUT5qBzEv7aWICFRKvLMSw
         Y8pNudQfFQeR7xsiScYFJLSMvCzrFZ4nwLIS4pzk9FXXmDESIh7yqV7RP+swm4EvhCm1
         pEqQurQtGZGehPkbieB1UFC3jNHD0f8EbNR2rwj27TD2w/3PyLldOAxsbiIUP0ioDym2
         wymx+ZZWb+eTulq3XkuipdKZrz2O3akZMWFNBnEtEJxjlQCm0UrRXHqrbQ2rnIDrd793
         p6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422946; x=1728027746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOdUobVOVtgiYgdW4L8/ozYZLZuDj7lViLzqUU9bECY=;
        b=q0M4VW64KwQwClD8UN+kF8tgR3KkKvajKwa8w+BMwemC4y7EN1qFqSC9g/zQ2kaCKL
         bGwEzv21nF8Vu5wOtl9+4bIv9XkxCM2YtcEgnXO4naGDgNRdqVVXVZECyb3W4kDaH3Wy
         ftXqCcgkCPI1r02TgH5Ts7fTpq9XBGPMLZKP7xk6Zi0HKvaIsZ/1/jwwWo7yhRgoecqC
         0k5AWhXdR0YuUczgsLj3AolDZTaHwnB+0qFb5cUDXubHhnw4OGwBaZ5Noz76vDvyo+Jg
         XRynFLOFjoSXEMFYvk++o/LruHFhjsfREGDbK83Na7c7pkcrHJNzKX0QcVRp8EZFE/tT
         djxw==
X-Forwarded-Encrypted: i=1; AJvYcCVfjjdUL8oazxg8Vr9ollNj3eEjV2nO0/3fDroyfixNuSnyBMi4Hp6SNoWS2qjh8sii4E7XVDuI3yjmDtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgeJg+uiqGrRzNJSD3kUrETndwUkYrBVojX/RGg6+8hebYNDn
	XqE9NAKxYhjk+1UnRCbZ5Si+gM8yed4xwQTx+5QPZ24Tlvhw7gCZlgjpcQJynyE=
X-Google-Smtp-Source: AGHT+IGTLNYx8CXWt5+mDv5PuKKxPV7lSlddClOvc1ENfOSqGWWc0UL48qHYTfSq1l5VF/dXqDa7tA==
X-Received: by 2002:a05:600c:5117:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-42f57fc9204mr13235475e9.11.1727422946272;
        Fri, 27 Sep 2024 00:42:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a28d:27a8:18cd:2c6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm66541265e9.30.2024.09.27.00.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:42:25 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC PATCH] gpio: sysfs: make the sysfs export behavior consistent
Date: Fri, 27 Sep 2024 09:42:21 +0200
Message-ID: <20240927074221.9985-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For drivers or board files that set gpio_chip->names, the links to the
GPIO attribute group created on sysfs export will be named after the
line's name set in that array. For lines that are named using device
properties, the names pointer of the gpio_chip struct is never assigned
so they are exported as if they're not named.

The ABI documentation does not mention the former behavior and given
that the majority of modern systems use device-tree, ACPI or other way
of passing GPIO names using device properties - bypassing gc->names -
it's better to make the behavior consistent by always exporting lines as
"gpioXYZ".

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Story time:

I decided to learn rust. I figured I'd best find me a project to work on
that would involve some proper coding but wouldn't have much impact on
anything important when I inevitably get it wrong the first few times.

I decided to write a sysfs-to-libgpiod compatibility layer based on
FUSE. Since Rust is hard, I started prototyping the thing in python
first to at least have the logic nailed down before I tackle the rust
part.

When working on the exporting part, I vagely recalled that when I used
to work with GPIO sysfs somewhere between 2009 and 2012 (still with
board-file based systems), named lines exported with sysfs would appear
under /sys/class/gpio as symbolic links named like the line and not the
usual "gpioXYZ". I realized that this is not the case now.

Quick glance at the sysfs code reveals that I didn't dream it up, but
that behavior is reserved to drivers setting gc->names. This has been
slowly going out of fashion with device-tree and device properties.

We could easily restore the behavior for everybody by taking the name
from the descriptor we already have access to or even just assign
gc->names from descriptors in gpiolib core but first: the sysfs ABI
document does not mention the named links at all and second: given how
this has naturally effectively been phased out over the years, it would
probably cause more harm than good when the exported names suddenly
change for existing users.

I'm proposing to just drop the named links alogether.

Let me know what you think.

 drivers/gpio/gpiolib-sysfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 17ed229412af..643620d261f5 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -577,7 +577,7 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	struct gpio_device *gdev;
 	struct gpiod_data *data;
 	struct device *dev;
-	int status, offset;
+	int status;
 
 	/* can't export until sysfs is available ... */
 	if (!class_is_registered(&gpio_class)) {
@@ -626,10 +626,6 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	else
 		data->direction_can_change = false;
 
-	offset = gpio_chip_hwgpio(desc);
-	if (guard.gc->names && guard.gc->names[offset])
-		ioname = guard.gc->names[offset];
-
 	dev = device_create_with_groups(&gpio_class, &gdev->dev,
 					MKDEV(0, 0), data, gpio_groups,
 					ioname ? ioname : "gpio%u",
-- 
2.43.0



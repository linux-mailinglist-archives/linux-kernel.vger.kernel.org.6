Return-Path: <linux-kernel+bounces-365596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7399E4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945581C22A35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A521EB9E6;
	Tue, 15 Oct 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DGNbxalC"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F681E7661
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989798; cv=none; b=W8c3sDb1UyeoAwB5xAFRtyagG8Nts8JI16HhfyzukEZQFBiPn4ZngUKOQXQk/vLUYBDxxxsjL12ioChMcSzH4+2O7d1eKBgFfCv6YL63Zmmd4zHbWOspi1z4gvmvk2zr11xgnu1Wou3n8uK6FbCgjEu4sLW3Q93yCsQyM2+IoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989798; c=relaxed/simple;
	bh=UNcQIfeI9Kctix5djTNGZtgwK9Bg+muQhyndnSvCRJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyMADr6xMvHd1OXKuQEhwAiUr2H+ekz0PVbim+LKSjViNzptyWct392KmjwaXSSJWqlPrCYjTHMDcZ3VzPvLhuZGfd5GQWhKkUaybKGWgUm+HOsExRRrgYTPUmUCjn2MgGJf102qgp06z9WO2lXhUTa57T6HVfuBkGaw482KSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DGNbxalC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d41894a32so3492174f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728989795; x=1729594595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WJlWZCGus+48LK34rnVtgH2/1CQrXAPJg0W6vmwbQk=;
        b=DGNbxalCkx51hn2c6oN2woq9L3eWrq8BaAnWjxC0NWmOlsQVkT1JcoK/K/8qf1CXpN
         ZfC9w1mjDDSOcA5r89O0mXXTFy4fDDwsEFRZg/1fBTGBBIKGP/+rLlP5Y676D/cnmSBe
         K4+xQOo1bopah5FoSYNIJXW0eh3EJazFTn7hBlOjnqJo9KUnsiLp9sYszShuNU0I09ss
         tSl4t2RghwqUx5Qn75Q8NZqiFjgurpDkMuiNNyvFPWnCGxGkZ8w3csdyJ3j5pWl7NL+W
         Jl2NvqS6+EoKRMYrTWBMPHbbkIWTZfLgPeJXyIdAGiMuljptr4rpUlEbWuKly1qAq6RM
         0sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989795; x=1729594595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WJlWZCGus+48LK34rnVtgH2/1CQrXAPJg0W6vmwbQk=;
        b=YtoDMJAtuqt+zWAim8gkWHtU3rYBREz+SdpoNy98xyyoITK5o32oSoHxyB4n0ONd1D
         HTEq/gNjkz8vVcB7wwVAlQebJaJlA9r9NOPwdicqf8O0AwhmbCM9cCbvgtikXaSflpYm
         /0OK9PP2kNU+Na/HZq603GQmD87JpskvtOzvclA7/CrGkyc2CHHdQu5NBd9XxDV5DtB5
         ruHa8Eb4gw9ZRjEH+pGHEPIInyoqbceG2gdhK8wRNtOIuJELifm5W/X0G/M8z9JB8dJy
         LdCCZbpyrTe+PAYxWVPY4r3rJYp2d8Q3WjGa3+l8+Om6M+bITQl6QMbvCWh9b71ycFD+
         69pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWgirN7CgElkr31ed+lpo3KLs9AYeyTaG8S7g1HLCukz5X2lp8Hq5NrOdxrQ6r+1PmRgGx4OBk3lCcCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6YSOO1rxnpWzaKalj/nQ1jZc3tzyD30jBHe17eDShtEvHXKc
	0O3Or2R85zv+GxIhJqijhG7ksLMVzm5vsaGEpC+7LaCxPAdenMum/sIYgYldYKOAfkkK45xGT5F
	m
X-Google-Smtp-Source: AGHT+IFvovF5mLQQmZxmCIDVkoFe0BZDeTv+THse/dtpG4Az72bgv1hAENLRayOhrJT1XMvhw3zObQ==
X-Received: by 2002:a5d:6082:0:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-37d86266403mr62456f8f.1.1728989795113;
        Tue, 15 Oct 2024 03:56:35 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc403d3sm1254115f8f.101.2024.10.15.03.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:56:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Oct 2024 12:56:15 +0200
Subject: [PATCH v3 3/6] gpiolib: add a per-gpio_device line state
 notification workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-gpio-notify-in-kernel-events-v3-3-9edf05802271@linaro.org>
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
In-Reply-To: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=mlz3Sg6ePkK9/QjJgP2Wdc6zjCPXTyUO0GrqAzTAxqg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnDkpewwbPIah26/a8p3MigsOLSn2/5qYPfJcSC
 O48WJf9JjuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZw5KXgAKCRARpy6gFHHX
 chl4EADLDr0mXxlXm1se7tuSg+VT7O3SjgeJGyhyhdgbph+/OhURZmgbI3vrmKwIsUUITsntQSM
 L/lVaKN/xxPKzlx1P3JXzRFiOSlWi6RyvM3LnK62/5geCPEMPFf+54JyDdsAwTlv6r+mKmsz6Tw
 gilBfdwphkO07/pRwH3V8DI6oM9mWJ7j+SkBfewdA0C1yN6Kt/mcqksmGvLFEhHsizQBRNmoeus
 j+E302BSi6yZj7/PWYiPgszZy54p+N7N2y15+vwQTLNTR4x1RO87ydrrArgCiCg6y5Y7kdtr+rK
 ylVZdwFJ9ymxyiSCjpN39JUg+5JxPFjAYG1K65GmYR/Y0v9Pf5wbjb3bjPiQ0/VUoAfNV9ETdR0
 XN6AosfT/pP5peI4xZUzOhlu0PARqtZmYQmvsfMDh5lG4AwFFghRiADuIACKxsUmGotiDPw5ql0
 GlarAckfOBopDt6StAnMFs6/iwSzGe2hYXalb6gh9t99f6lb2C0uA3U0xGjqkNTmSQ0M0UOk5Rm
 ovhe0ELKjpj7zLCmPb3T3tHijKm1vO9QVLyknUYBkYWeoP5ji+3FGq8tiMm9WCjHy7f0TThmjpP
 n1zpMzriuSkxcONSiMCQzW1BJZu1rKbJqRya8b1LCg/FPq1o2tk/nKfCA6ItZhl7VyMfB70PTti
 pw9YAF/YGMn/HrA==
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
index b28751242835..5b28a558c9d0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2868,6 +2868,11 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
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
@@ -2884,6 +2889,7 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 
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



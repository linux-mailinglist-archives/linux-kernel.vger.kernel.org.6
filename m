Return-Path: <linux-kernel+bounces-333423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8E97C862
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4CB244FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A919D09C;
	Thu, 19 Sep 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OLCLioOR"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFA19D080
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744429; cv=none; b=fzdIdMZDK+T17dqW8+Wp/jnQln+pDX8kN04pYBDkhYSMS1xThmPNOHi8MyvjtJcJXaJkn9CMz4DJQ2WORAmN1Zd6jKktY9L6KvJQK34oNc7pWOvwOBBohlN0F6fxkFuWDK2pIgmyey8bs4j4EmP9Ug0A/j0Yg7slkjnk813lios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744429; c=relaxed/simple;
	bh=3y23dO6Y97nYE8X9deL/nLK64ZbbD+O9Zzo6y5MiCYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCmC9ZHIrg4j93+7x/NhZTODpbpJuQq9iCcjBnzIN7W9dizz9q13rVXUC6kNZ85UTW06qDza9OZVTaZXBD+kXARpXFp6HeQfAk8wlfP9PVz3eROhCIWVccX90mqO3hObjWMof73fqHDIAyLt6eOCvpeAnrow9tvd1qEpO1LHqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OLCLioOR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c26311c6f0so992509a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726744426; x=1727349226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKd7DzEQ/yD2d5V4p1DBW5zYkDlE5EaHoPjh/5HNDEc=;
        b=OLCLioORh+J40zJg/bdjnCSfYzxg5NN/jcOSjmPUOM7GPYcTmGYJp8jKfK0eqgfJoW
         daBcYx8xE0tcVvivEG1cd6DC6fbPSWw0qKRhYhdbQSaUAEs4KYbEJLwswg0DgZ5A5TuL
         2NldY5t53sDFbwJAGjU3LWjnQt3KWQfI+mtuAp1BXG8iUsQfSxbzeEMDiKTq0qb5bF1k
         LUm7HZMbyfJNOcFYu+EGHSDCHytLQ/dFURvF+3wzc0DwvYwYeqMF200im968kYH2fSN5
         64lZaPmTiFZlfeLGb/1CJmkZvMGQihzmDIrTfcjA6gmksJMKArNG+/U/sPvrrR0zjvpp
         zXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726744426; x=1727349226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKd7DzEQ/yD2d5V4p1DBW5zYkDlE5EaHoPjh/5HNDEc=;
        b=OksM8PZEFLYAyclpnq1FhmVXxKTZCAMVe5Z6tPjBv1/jct32HBPrgsnFIPb8qclgyJ
         fE+wljodHYk/mCrq0yFh4COhYMlixy1hL7QBR/OOHIfOe9RD0O8eQxnMV8Abcx/6hbXI
         Isz0wFlWk/oYJLpJ1cyUsnn4Os29vm2ozcerbX2iTUcX7MyEsXD7gTkHLsDAjlPsUM2o
         caTi/4VTNpJR7LsINHQ1qHjE/hJebSykPTC5zr44x5c5Vk4IQxLIUGVtawliMy4W7KRo
         TXDSDK2X5dcn9hZEygQxrJSJkLVUvzmq7yPTiNjDADEbrT4Ff0A/Iu+MehwHiJL+k3vv
         cqDg==
X-Forwarded-Encrypted: i=1; AJvYcCVP4ozcJLRstPTNwshXfnqflKcwZUefmd2UY5a5rurLgbQqV0w3OdxvXg+y3vZUem1qnkwmGGV9rWFmptg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2x7rn+zkmqkRFM9Z6oP/zreh9+m8R5K8KDAEYSyy79/LRlDL
	2wpR7o0dEOb6bIGcyQp9Ek17bsOsF5uKnenp4MIBaAyuRldOkws99eOgfx53OGE=
X-Google-Smtp-Source: AGHT+IEyILjoL31IaN9SqNI+ApYRmX5ZeF5PTsMtbYjTdQJfDNg5sTBgRiWoFp0Hq7prO7zQaGrkEw==
X-Received: by 2002:a05:6402:2551:b0:5c0:ad76:f6d5 with SMTP id 4fb4d7f45d1cf-5c413e06c29mr22930677a12.5.1726744425536;
        Thu, 19 Sep 2024 04:13:45 -0700 (PDT)
Received: from brgl-uxlite.pool3009.local ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5dcf7sm5933777a12.45.2024.09.19.04.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 04:13:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Herve Codina <herve.codina@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: free irqs that are still requested when the chip is being removed
Date: Thu, 19 Sep 2024 13:13:24 +0200
Message-ID: <20240919111324.10117-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we remove a GPIO chip that is also an interrupt controller with users
not having freed some interrupts, we'll end up leaking resources as
indicated by the following warning:

  remove_proc_entry: removing non-empty directory 'irq/30', leaking at least 'gpio'

As there's no way of notifying interrupt users about the irqchip going
away and the interrupt subsystem is not plugged into the driver model and
so not all cases can be handled by devlinks, we need to make sure to free
all interrupts before the complete the removal of the provider.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Herve: if I say I'll do something, then I'll do it, no need to remind me every
six months. :) Anyway, this is a proposition of fixing the resource leak you
reported with gpiomon in a more generic way so we also address the same issue
for in-kernel users.

 drivers/gpio/gpiolib.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c6afbf434366..f336fd608d58 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -14,6 +14,7 @@
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
@@ -713,6 +714,31 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
+/*
+ * The chip is going away but there may be users who had requested interrupts
+ * on its GPIO lines who have no idea about its removal and have no way of
+ * being notified about it. We need to free any interrupts still in use here or
+ * we'll leak memory and resources (like procfs files).
+ */
+static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
+{
+	struct gpio_desc *desc;
+	struct irq_desc *irqd;
+	void *dev_id;
+	int irq;
+
+	for_each_gpio_desc_with_flag(gc, desc, FLAG_USED_AS_IRQ) {
+		irq = gpiod_to_irq(desc);
+		irqd = irq_to_desc(irq);
+
+		while (irq_desc_has_action(irqd)) {
+			scoped_guard(raw_spinlock_irqsave, &irqd->lock)
+				dev_id = irqd->action->dev_id;
+			free_irq(irq, dev_id);
+		}
+	}
+}
+
 static void gpiodev_release(struct device *dev)
 {
 	struct gpio_device *gdev = to_gpio_device(dev);
@@ -1125,6 +1151,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
 	gpiochip_free_hogs(gc);
+	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
-- 
2.30.2



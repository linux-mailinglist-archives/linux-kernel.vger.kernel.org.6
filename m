Return-Path: <linux-kernel+bounces-525838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC75A3F622
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B117CAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4C20E02F;
	Fri, 21 Feb 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Y1/b85TE"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39120AF84
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144921; cv=none; b=PBub3lIRvz3RKLo+e1lESRLfAJdmivM8k+pGHAQ+p+TE4KdGPdb1VKN41L1Zsh0WodiEoXofdDimAy2GA7BeIHEZ45kLsQJTITcTWXRXeNTHa3O7NTSYuPIPgs9b4m//6Uku53CIloTF5FfiT3+ohV8h2fuIPqc3LSXeIf2YpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144921; c=relaxed/simple;
	bh=IcOH5SAseQKzkHpmHpSjfAE9mkd9Arcd9z68k2xbqrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ6/qkZxNUHnUhj7J6T4T4Do6BQE7B1p6B3k34qenpyiuUoyOMiROjn6e80ivFUEgoWUQ4Vr4lFXcggdo0hvCbKE3MtO2/z2T5EQIS7hxALE+1UDJ0TEzn5PhlzRzNincdTYRKuUCHn71eD3ybPHYbXTdDmQBhFz69CgbyfV9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Y1/b85TE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DDA0F41962
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740144916;
	bh=YUp6LYQRCspZvbFalfM4lFVMvYXlGzGvaMoc9xWJpOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Y1/b85TE0U7hszL0IIQtMYG0YoNvlP/gWPK0BpCd6DwFWVxvbyprp8p/bZYoTI7Tu
	 5FD9lYc84IQzgbfOnProZSHtXM8zgAqr9j/embF50N4bXC4bX5mu5Hgf70OmHc2OB/
	 ONPSOlkIjz5oulgyfn4zP2KXKqZhep4ueXGmzq8UQidFVFT0S/tInLIPZ5Sim4HLQp
	 79ohlBF6Mkk8D/GUBku5/ByTG5m4pOjnCQXzHnr318GI0qBi6N+iwD9pKpsjPyEa/U
	 XBzJG3cYC5TfUQW6y0RLNqubFdxt5iIlZsOW1aSiLq/h5TudcU90VM/yfd1Flv/jDF
	 cwqmHvx6frrIA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so4749876a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144915; x=1740749715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUp6LYQRCspZvbFalfM4lFVMvYXlGzGvaMoc9xWJpOo=;
        b=Rq/ZTEIfd87SSjxx/enX8RxLSZdjNgq5s4oPVqyQzTGwIm9zy5MgRik3aUcOXnzu2b
         Y5/CHp2JBCf8L75MlCbnQYhE0TnhZtRivyBGUcyWbwHw7FmJe+59RV7aLMFNGKRkEt0a
         0e2dWRnwS7MD4u6IxpML26y6DlhMFibrHvc3WKlgFdyLlttbV4vPYVH6ghHjrHaqSOOg
         udxIsOX3ecqmKgIe0fxr1M15khg4FwhNFfyHfBORQNw5WNag4Reba/wObIsT/gQ1IGeH
         qhxJv8m9vJWXNM3nq0PWD/4uKKYv7L+c74HwCZJeSDAeX7IiRuKbS923iY3WStrrh0b3
         591g==
X-Forwarded-Encrypted: i=1; AJvYcCXPeAM89+a2NQloXJuFh2GlM5amPONx2XdG3wgcLBfHBU1q1mKPYYuU8QW4AIz9PhCbf/WCK5ws75XDtag=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUJDjM6fV1Dqu6ah1soI1p6R6qp+EmLEOB30+CDhOBfaeEKWg
	Hm6YOZOaZUirRPtzzZMXx7VRGfUP/m+QiXAVHv7T4l8CW8gfLXPNvZb7TKPa8in3FzdOmTVHmk0
	Ov1G1+JSC2xObt7q05K7VpZ+0EymX12SI0JJOvK0/8tiEqvuEoqtvTL2BNuqpLD+pe86Ri7H9Wg
	7U4A==
X-Gm-Gg: ASbGncskaKl9N86f8MXKs3A/DnHxsCIMRzhiEdQeWkrUP80z+jFNLDEb+wrG3WnsYFf
	EWXMhPjLEpVKzUyqgg5PQYexrP3MTBPKznbo1mbBoJznap2RkOVa0Qj7M9yx2tNGUix+11lBS4c
	nWWWiE0UalRCdxjNn8TXODl0kucHmcpbA7ob+SpbJN8gRYM96ruagTiRDYjnre3uvdMJYJBZhqu
	cSR7AHlQjZPI5t7qZCl+VDGkoEW8pW+XoufafxU5P7VoOF/0k2NTizjkOQKQ6SMDFpsmQITicby
	WLXzqVGeOORwkQ3G
X-Received: by 2002:a05:6a00:238b:b0:732:6248:8f5f with SMTP id d2e1a72fcca58-73426c857f0mr4943455b3a.5.1740144915292;
        Fri, 21 Feb 2025 05:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi1Gsb9VWYRvml0tMN8HhdWYXhcZeJKbfQe1KvSFbipBH1mXtylhLvYgpNx+o4hjB/fsJHog==
X-Received: by 2002:a05:6a00:238b:b0:732:6248:8f5f with SMTP id d2e1a72fcca58-73426c857f0mr4943402b3a.5.1740144914763;
        Fri, 21 Feb 2025 05:35:14 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:2777:7867:71cd:dd56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325d65619bsm12565459b3a.113.2025.02.21.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:35:14 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] gpio: sim: convert to use dev-sync-probe utilities
Date: Fri, 21 Feb 2025 22:35:00 +0900
Message-ID: <20250221133501.2203897-3-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221133501.2203897-1-koichiro.den@canonical.com>
References: <20250221133501.2203897-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update gpio-sim to use the new dev-sync-probe helper functions for
synchronized platform device creation, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig    |  1 +
 drivers/gpio/gpio-sim.c | 84 ++++++-----------------------------------
 2 files changed, 13 insertions(+), 72 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e15405add317..297ad8f78f38 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1909,6 +1909,7 @@ config GPIO_SIM
 	tristate "GPIO Simulator Module"
 	select IRQ_SIM
 	select CONFIGFS_FS
+	select DEV_SYNC_PROBE
 	help
 	  This enables the GPIO simulator - a configfs-based GPIO testing
 	  driver.
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index a086087ada17..2c0729a62fc2 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -10,7 +10,6 @@
 #include <linux/array_size.h>
 #include <linux/bitmap.h>
 #include <linux/cleanup.h>
-#include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -37,6 +36,8 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include "dev-sync-probe.h"
+
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -541,14 +542,9 @@ static struct platform_driver gpio_sim_driver = {
 };
 
 struct gpio_sim_device {
+	struct dev_sync_probe_data probe_data;
 	struct config_group group;
 
-	/*
-	 * If pdev is NULL, the device is 'pending' (waiting for configuration).
-	 * Once the pointer is assigned, the device has been created and the
-	 * item is 'live'.
-	 */
-	struct platform_device *pdev;
 	int id;
 
 	/*
@@ -562,46 +558,11 @@ struct gpio_sim_device {
 	 */
 	struct mutex lock;
 
-	/*
-	 * This is used to synchronously wait for the driver's probe to complete
-	 * and notify the user-space about any errors.
-	 */
-	struct notifier_block bus_notifier;
-	struct completion probe_completion;
-	bool driver_bound;
-
 	struct gpiod_hog *hogs;
 
 	struct list_head bank_list;
 };
 
-/* This is called with dev->lock already taken. */
-static int gpio_sim_bus_notifier_call(struct notifier_block *nb,
-				      unsigned long action, void *data)
-{
-	struct gpio_sim_device *simdev = container_of(nb,
-						      struct gpio_sim_device,
-						      bus_notifier);
-	struct device *dev = data;
-	char devname[32];
-
-	snprintf(devname, sizeof(devname), "gpio-sim.%u", simdev->id);
-
-	if (!device_match_name(dev, devname))
-		return NOTIFY_DONE;
-
-	if (action == BUS_NOTIFY_BOUND_DRIVER)
-		simdev->driver_bound = true;
-	else if (action == BUS_NOTIFY_DRIVER_NOT_BOUND)
-		simdev->driver_bound = false;
-	else
-		return NOTIFY_DONE;
-
-	complete(&simdev->probe_completion);
-
-	return NOTIFY_OK;
-}
-
 static struct gpio_sim_device *to_gpio_sim_device(struct config_item *item)
 {
 	struct config_group *group = to_config_group(item);
@@ -708,7 +669,7 @@ static bool gpio_sim_device_is_live(struct gpio_sim_device *dev)
 {
 	lockdep_assert_held(&dev->lock);
 
-	return !!dev->pdev;
+	return !!dev->probe_data.pdev;
 }
 
 static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
@@ -730,7 +691,7 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	pdev = dev->pdev;
+	pdev = dev->probe_data.pdev;
 	if (pdev)
 		return sprintf(page, "%s\n", dev_name(&pdev->dev));
 
@@ -939,7 +900,6 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 {
 	struct platform_device_info pdevinfo;
 	struct fwnode_handle *swnode;
-	struct platform_device *pdev;
 	struct gpio_sim_bank *bank;
 	int ret;
 
@@ -981,31 +941,13 @@ static int gpio_sim_device_activate(struct gpio_sim_device *dev)
 	pdevinfo.fwnode = swnode;
 	pdevinfo.id = dev->id;
 
-	reinit_completion(&dev->probe_completion);
-	dev->driver_bound = false;
-	bus_register_notifier(&platform_bus_type, &dev->bus_notifier);
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev)) {
-		bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
-		gpio_sim_remove_hogs(dev);
-		gpio_sim_remove_swnode_recursive(swnode);
-		return PTR_ERR(pdev);
-	}
-
-	wait_for_completion(&dev->probe_completion);
-	bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
-
-	if (!dev->driver_bound) {
-		/* Probe failed, check kernel log. */
-		platform_device_unregister(pdev);
+	ret = dev_sync_probe_register(&dev->probe_data, &pdevinfo);
+	if (ret) {
 		gpio_sim_remove_hogs(dev);
 		gpio_sim_remove_swnode_recursive(swnode);
-		return -ENXIO;
+		return ret;
 	}
 
-	dev->pdev = pdev;
-
 	return 0;
 }
 
@@ -1015,11 +957,10 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 
 	lockdep_assert_held(&dev->lock);
 
-	swnode = dev_fwnode(&dev->pdev->dev);
-	platform_device_unregister(dev->pdev);
+	swnode = dev_fwnode(&dev->probe_data.pdev->dev);
+	dev_sync_probe_unregister(&dev->probe_data);
 	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
-	dev->pdev = NULL;
 }
 
 static void
@@ -1117,7 +1058,7 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	guard(mutex)(&dev->lock);
 
 	if (gpio_sim_device_is_live(dev))
-		return device_for_each_child(&dev->pdev->dev, &ctx,
+		return device_for_each_child(&dev->probe_data.pdev->dev, &ctx,
 					     gpio_sim_emit_chip_name);
 
 	return sprintf(page, "none\n");
@@ -1558,8 +1499,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->bank_list);
 
-	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
-	init_completion(&dev->probe_completion);
+	dev_sync_probe_init(&dev->probe_data);
 
 	return &no_free_ptr(dev)->group;
 }
-- 
2.45.2



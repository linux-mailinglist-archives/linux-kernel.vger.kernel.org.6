Return-Path: <linux-kernel+bounces-519799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916BA3A216
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2287A175E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5726E164;
	Tue, 18 Feb 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mfsA4PEy"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01B1459F7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894657; cv=none; b=iwow+Z0WZBVo4lhRLPO+Pi8FLk6oMvRAjNW+qh+wtAf2/JuqxJj5xP4ysOYDMwUrxrqU06Xj3C7I15t8+x/Eniat45TiVZcKGzFBylQUTIf35wFbW6Y0aIrd6L0kiYGBSAhnWXhygO+YgXq91u2hobN3+DeUZqu1L6axWHZJbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894657; c=relaxed/simple;
	bh=sdZ6VzRRB5ZPauONLm1Y6ciUkGYRdBApYYUeFYnndrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPKr+hZxMwmz8ucFD9zehelD42rBTHWZHOfEmElmS/WLx3EKJKAxc/yXXbR1G+w/+pCqhaD8z1dJFUBYUHqFoVD7R6djn6X56afiyhWswgQbV7EGJFWOamcFn6TkcJ5j0fGTLUrT0sto5oyzOc4UWEWaebkNoi8Mx15XL0nFkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mfsA4PEy; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0956C3F16B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739894652;
	bh=RjN5AreZarUYbQVP0Uc0k3mb1KoxJf6GB7t5AILSk3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mfsA4PEyvTH8tEAkzjOjKopK7o4sjBQtF9IP0tUTrqAhDLzNMRD0YPCmTmlX5yiZU
	 jeMiP+J3rt/Qw/Bn86ZySJdf2ww990rerXOUMDmsnat5ezD1OsZq3lWmuZmkU82wih
	 bLaod7STdkv2vwSN3f9yX4fzm683ZkqfKkDTcGQxrs9W0p0Mjmjg3rT9K+OG7ivCnk
	 7ITLHF4smm6d3++t+GegJfM6UPALKjVY7ft6urxxzeltZRG6LqXwPQ8HewtszLNQA/
	 Bd6W/6falHXIXqXaRl+uHObct9FHoBS2/RA2AY7Aui54M0zBGIKIhCVG6Rg9lCbGZs
	 KirfT5opfhu4w==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220d6c10a17so102611465ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894650; x=1740499450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjN5AreZarUYbQVP0Uc0k3mb1KoxJf6GB7t5AILSk3M=;
        b=B7S76euEBrsD4lzw3PQUGtvILd82aZ6ekDWiI4LGu451Vn+N2qKgkL/Qv2jq+ANuzB
         mx8y519MBmT4YXkOlD/JPt+4WnsByIyvr6J/scOL6PCYqeDPTPLG7AMsZ2TX49PWZBfS
         urLXnG29TDhSNOQr8ZWO8U/NR4R0BhOp+OTqBstyT50qdo/GWwZWUDrh59A9gFGIT45g
         u9J551+BJNHNmPgYiUqN1BDjBWkZkq4vvtYtwK7ktmzYMCP5jdHITntknz8N7rKW59mC
         T/rUdxcMdIH/0Dpc5yDcktRBFjKVEz8eCqG7zXjmEEKIa3s7uvcixz8QQv88d31zfcyQ
         lICA==
X-Forwarded-Encrypted: i=1; AJvYcCUEcf7hY6DkbKH5ILOuXHhzb16So+RkBiuXL0O30MiTxs8U59HoBWLfAn52RAyDcXrk3b6yI+XW/twLiuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kKZEFnYdepb/rOttjgtiYRlTipeX5yOxfqW5XfeZdgrKZJnK
	feiz6HM79Bj2Tx8hPAvZD+Nk5VWctT0q97h2BPG0QbJr/KbLffE6bA8JUasAKyF8rGOqbwhkBWw
	BfaU+ZpMEafAeVX98KnxIPTr5/P9WT/z10ol2a4znBM7naKhjlNNJ48AJ5mClVmMY3LR8zC8joQ
	OWng==
X-Gm-Gg: ASbGnctnNSihXpX4JCsxAkLkDoSJuDhjCv6t6nkSRSgN/1gwRPriAMm20S0eQuccd2W
	Ww3bvptK+TB7LLPH+bHki48O+RrI8R+EbQpMKWScmd2lx6Xboj/l/9BMhAofDpXsrT0NpWp9csp
	l3uPGDK9zcITPhyBTl+4wpDMJMcz/DEuUfw5xehIZz/vxk4QNk3p8FJJMlVmMbTIAyL+BD+s40e
	qWyMfZ3RZr2n7NbKiLsZpNb9/RUkmhdBi1kaPydjlaJmXw6bUSAqMBW/LgKmfPGM29eaaZ9YmNv
	cfoIyd3lVPk2K5RXbSrp/Ys=
X-Received: by 2002:a05:6a21:6daa:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1eed3795347mr546832637.0.1739894650611;
        Tue, 18 Feb 2025 08:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlr8j/FIMrYjFZKCpEiD3ian13qv9GhgmhOTyegL8NA0OLFd302bU08nHMhlRVPDaC/ZBWew==
X-Received: by 2002:a05:6a21:6daa:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1eed3795347mr546798637.0.1739894650131;
        Tue, 18 Feb 2025 08:04:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:ad3a:e902:d78b:b8fa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae01c768020sm3662177a12.73.2025.02.18.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:04:09 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] gpio: sim: convert to use dev-sync-probe utilities
Date: Wed, 19 Feb 2025 01:03:32 +0900
Message-ID: <20250218160333.605829-3-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250218160333.605829-1-koichiro.den@canonical.com>
References: <20250218160333.605829-1-koichiro.den@canonical.com>
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
 drivers/gpio/Kconfig    |  2 +
 drivers/gpio/gpio-sim.c | 84 ++++++-----------------------------------
 2 files changed, 14 insertions(+), 72 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 2e4c5f0a94f7..ba06f052b9ea 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1866,6 +1866,7 @@ endmenu
 # This symbol is selected by drivers that need synchronous fake device creation
 config DEV_SYNC_PROBE
 	tristate "Utilities for synchronous fake device creation"
+	depends on GPIO_SIM
 	help
 	  Common helper functions for drivers that need synchronous fake
 	  device creation.
@@ -1916,6 +1917,7 @@ config GPIO_SIM
 	tristate "GPIO Simulator Module"
 	select IRQ_SIM
 	select CONFIGFS_FS
+	select DEV_SYNC_PROBE
 	help
 	  This enables the GPIO simulator - a configfs-based GPIO testing
 	  driver.
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index a086087ada17..d1cdea450937 100644
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
+	struct dev_sync_probe_data data;
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
+	return !!dev->data.pdev;
 }
 
 static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
@@ -730,7 +691,7 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	pdev = dev->pdev;
+	pdev = dev->data.pdev;
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
+	ret = dev_sync_probe_register(&dev->data, &pdevinfo);
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
+	swnode = dev_fwnode(&dev->data.pdev->dev);
+	dev_sync_probe_unregister(&dev->data);
 	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
-	dev->pdev = NULL;
 }
 
 static void
@@ -1117,7 +1058,7 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	guard(mutex)(&dev->lock);
 
 	if (gpio_sim_device_is_live(dev))
-		return device_for_each_child(&dev->pdev->dev, &ctx,
+		return device_for_each_child(&dev->data.pdev->dev, &ctx,
 					     gpio_sim_emit_chip_name);
 
 	return sprintf(page, "none\n");
@@ -1558,8 +1499,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->bank_list);
 
-	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
-	init_completion(&dev->probe_completion);
+	dev_sync_probe_init(&dev->data);
 
 	return &no_free_ptr(dev)->group;
 }
-- 
2.45.2



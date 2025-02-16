Return-Path: <linux-kernel+bounces-516585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC3A3744C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A78C3AF5FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE51990AB;
	Sun, 16 Feb 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="K/rEkbm7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327B1917D9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710724; cv=none; b=rkTW8Y22YCcXTdLa79gur5EdT4e1hjNv2xQLf4SQDJtSsE+CbVgBSdDqbzUS0f8w0mBGfrexMzj7YMFqYHx/G9ZL4JIIy4ZB/rAVuTUKIeNKFfThMIFQbYVA64i6BQD/+8G/dwSwRZ6FufWbPnhaP6VtA1bMB8VmTQPS8xuZqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710724; c=relaxed/simple;
	bh=QAOA908gNel3y1R7ETsRu2jzdhf2WxIWOfoFCHcP9qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YucJ9mNuPNgWWC2Xp/+S9gTgH3e6nOfq4WKKC6pn/V8ZxGLVjjrB/ynZuAYgM3mQyMylTGfiWABBKgbTir2AnN88PbNNnlgKCYMCp+MlPFVk3/ucNe8oPGLQkGLlW/wOdtLnlrRfhZhAM4xWvoGP5YlvFR6x+k66w3iJsuFSYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=K/rEkbm7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93A733F2A0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710720;
	bh=N0Kj1d8MdTe6Cku6k8Y4hSRN1wAEicDaX3HkzkoJuyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=K/rEkbm7ThcQ5Dl97ITLHjXADsoQ1zziXuk8U6tMGS3BfCK9MwThgAw2Jngnp7uqo
	 xblJ74gCYLq2L5RNc2inH80pIi1riuKLCWEFQ0tsPITRuxlhbRG6WaruKSE9x9XspG
	 81BWo/xIqTUx3ZfyaaUK2uyZlh9LTvJDDUqP9JvHAfMRq0P1lC/L9j8tz1wAkZ33R1
	 8ELWeQwkyvxJS2l8ANeCPFGY8se2eGemm+X6t1XAPqQHBR32owc6CJkkdo2LHccnkE
	 1DM1UjZrR09s/SP2tz5A0qNDV86SwAc/EXHY84mCsrkA8S8sqwqHJHX4SesE+lGlTd
	 hFCur173etkaQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc2e648da3so4025986a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710719; x=1740315519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0Kj1d8MdTe6Cku6k8Y4hSRN1wAEicDaX3HkzkoJuyo=;
        b=cLcVZr8HdysxybHnuPq/9HUol+59eSh9xGO+7R8//rkBUA+nnUYeOFb8x2XKa33NaY
         pxXXtIQo2bMz7pLwkitJsdYuISbVkaneaUohdpV5Gtm86s8Np7AS9nGt2pSyUy7jREXo
         l1a6YzFDZW8Ny78UvRZ8XV8JIeTXlV5GS/Mqx67HTgxsvxKy7eZsQ2LmtWptuH1YLkgB
         b3ompcVrM7Y2yyql/+xaNJmGtKKiK6mh0BRn21tQoWPQZqjNyur6GIpfDCkt5r+Knnsb
         BYtmIQvs0EU0GKsgxYqC8F3YuDV/jta0Y5c74Nz6U7T5D9VCvsF/xj9YvoH/UQrHzr4s
         LSsg==
X-Forwarded-Encrypted: i=1; AJvYcCX3rgDzXGrIQ/UPLD798F/xSEHoBLvvlaCMnU/y6fx76item+jQIqTVgwx8Hg5e9K/kqtHGPbg28wSZJIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcX8Dm8S2pblcbz9KEWphxAeGBXjE9r3kT2uKGGDojwBsT/7p
	FuI6IX/WqoBCvVEMhvtqnSNExImN3l6sVMUcEZfShuseBlqqFCABgc7x1jatlo2Ul1/rM3D5K5R
	5QldS+bPTaKvCNmlGYrtVeNIbAuq22ASPZ7grR9Iu7syVGx9ZiWv7cuDygzcuD+7oRJ4A/EwSe1
	o13w==
X-Gm-Gg: ASbGncvFgQVFqEr5W+7+0dYT/gt+WhsbQeqgkRR2JDvpe3MfcFn4YdwB0N9KVefdrcC
	KUu7FyYjoSIZnCajjgbybYfeVRZQMs185gEzTD6J61n/BeTloPpo+5W8TJe5jkWJU5ZTrQCcsTl
	0hxLFTdVkM28sLfwZXI7PWJCMlri1YF+AWQ5sOLpXZOpHQ/2m85Fzelg7tCdDuIWeC9ms22ThZW
	19t9BPTtRzJtJww1pKex30eSfOuW5HYqAtQ4eeEHMrMkc2tBjzTP+dbN0vgXwcC623Y9iy4WG0m
	W2bWIg==
X-Received: by 2002:a05:6a00:198c:b0:730:7885:d902 with SMTP id d2e1a72fcca58-7326144b262mr10956755b3a.0.1739710718760;
        Sun, 16 Feb 2025 04:58:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNx31ACnol66ZluTW2jPSBmJYZlDsj5AI975Vm2nDmoYYTRm8RaHhWXg3ML7mJhrQFbFiFIA==
X-Received: by 2002:a05:6a00:198c:b0:730:7885:d902 with SMTP id d2e1a72fcca58-7326144b262mr10956735b3a.0.1739710718404;
        Sun, 16 Feb 2025 04:58:38 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:37 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] gpio: sim: convert to use gpio-pseudo utilities
Date: Sun, 16 Feb 2025 21:58:07 +0900
Message-ID: <20250216125816.14430-5-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update gpio-sim to use the new gpio-pseudo helper functions for
synchronized platform device creation, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig    |  1 +
 drivers/gpio/gpio-sim.c | 84 ++++++-----------------------------------
 2 files changed, 13 insertions(+), 72 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1e2c95e03a95..c482e3494bac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1913,6 +1913,7 @@ config GPIO_SIM
 	tristate "GPIO Simulator Module"
 	select IRQ_SIM
 	select CONFIGFS_FS
+	select GPIO_PSEUDO
 	help
 	  This enables the GPIO simulator - a configfs-based GPIO testing
 	  driver.
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index a086087ada17..45dbf16bee12 100644
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
 
+#include "gpio-pseudo.h"
+
 #define GPIO_SIM_NGPIO_MAX	1024
 #define GPIO_SIM_PROP_MAX	4 /* Max 3 properties + sentinel. */
 #define GPIO_SIM_NUM_ATTRS	3 /* value, pull and sentinel */
@@ -541,14 +542,9 @@ static struct platform_driver gpio_sim_driver = {
 };
 
 struct gpio_sim_device {
+	struct pseudo_gpio_common common;
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
+	return !!dev->common.pdev;
 }
 
 static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
@@ -730,7 +691,7 @@ static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	pdev = dev->pdev;
+	pdev = dev->common.pdev;
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
+	ret = pseudo_gpio_register(&dev->common, &pdevinfo);
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
+	swnode = dev_fwnode(&dev->common.pdev->dev);
+	pseudo_gpio_unregister(&dev->common);
 	gpio_sim_remove_hogs(dev);
 	gpio_sim_remove_swnode_recursive(swnode);
-	dev->pdev = NULL;
 }
 
 static void
@@ -1117,7 +1058,7 @@ static ssize_t gpio_sim_bank_config_chip_name_show(struct config_item *item,
 	guard(mutex)(&dev->lock);
 
 	if (gpio_sim_device_is_live(dev))
-		return device_for_each_child(&dev->pdev->dev, &ctx,
+		return device_for_each_child(&dev->common.pdev->dev, &ctx,
 					     gpio_sim_emit_chip_name);
 
 	return sprintf(page, "none\n");
@@ -1558,8 +1499,7 @@ gpio_sim_config_make_device_group(struct config_group *group, const char *name)
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->bank_list);
 
-	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
-	init_completion(&dev->probe_completion);
+	pseudo_gpio_init(&dev->common);
 
 	return &no_free_ptr(dev)->group;
 }
-- 
2.45.2



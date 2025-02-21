Return-Path: <linux-kernel+bounces-525840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 171ACA3F62F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8EF189AB75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D174D20F063;
	Fri, 21 Feb 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mb01lJQd"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D520DD54
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144923; cv=none; b=i7iFXMqJC0TFr0j6/olT6cVydFvYh5fxIPtL4ooGZrMNEOGdGZolYMZwCgrz5rJ5A12Y5uwRVLJ163chb+1poqiH9FHCi0ezrlgONY5a8HtFcd95fjEuzOGoRWehXsaBJV/bcra4sjHM6hRjToGDhQrX5XO+5ikhD28tXZ6YC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144923; c=relaxed/simple;
	bh=2sKNu9pu9EQxq0VJYOxo3RJcm9UNmjRT0MW3Pa1AWpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FM5I97pNyKsxNPS9dk4Plhz2co0lNySijqYt2z1C6EwPJl4HMYF6Lo1Tvz1dNs+O4OXnDMSEqk+gRXpY9dCfXQez1liO63Jjpwm4H7gqs/aQ5UUGxG2zNVhh7MjXhgAal+WzAtEOsBFVSVK5FO34xwyS3sMTiORbax6G9gee6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mb01lJQd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 63EC141231
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740144919;
	bh=BkjT7/jJ++3VQmpRa1vg24+85VM0dA6Mj+g/I8mTwrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mb01lJQdjHVfWVk76EAm1PcZhYTYPLzlyE/KGXFHRvTTVBDBL7n8BiC10f0ROH1HN
	 CA8+9fBBOwofoq4K0xAvZVS3ZkKFTg4cG8Hc391E/PrIYgVL+hElviF77Tl9MG4Vpl
	 Kh6Ke4c6n1m41teNf1dB1PNhlg0jm20O1xjbE5HYKWrKF5K+wKmnfDF2/4iz0tL8oV
	 eTxfdD6KTZKkU1uinvJb7SDXhCOgt2Jtdxzv1R5TAaJ6gxCZMLlSNPJYB616yMtN/Y
	 3A7+TRh51NPEU4nlZY0dXv4v+pALJIN3g9IVVKzzI/ae6oSIUIvbPKgGUPK/GBORlE
	 3LgKScMm4I1HQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso4321084a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144918; x=1740749718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkjT7/jJ++3VQmpRa1vg24+85VM0dA6Mj+g/I8mTwrc=;
        b=CbdHSddoAAIhNvCN1iuqLMd6TjzCoGVOWhKLYtnmyCeLC2A/MxUAzsJOD+Z1KJQWTr
         rQgWHe43sgeq0my20fixcbI/a7GKUJDA22nmNqxce8xwOB9e0AGY13UUb+56I4wyPhX2
         59FzINFdHVJg+ntlofITu+ufUfw7O4w/3j7Q9Fr+K943SopUB3RRjwvOL/czGnruqEVY
         IYTSsVR+GWygZ4C9r+xLeEc2z733fUIEI3H/6SAofCEHaxZPCGwGCRAUe3gBdN8pA6kL
         d24fk3Vz7yZKA9FlH++bq8DNQI15ILSe6RvRcz7s06EbY0G71lpUz8jBFQqGqNTKeDvv
         KLCg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2Z1rmL6Mvzth5LPJATLWcm9QSzuYTfJL1r+jPUcHZ1lwhc+k3reDHYx2DHGmEQ8ItIBNTm810ORhxeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04XTpY3eJyQuUSscWf9kik9Jy+eQ1DCoQ7lsgThO+X0pgwYiy
	XR6AEQu/yFpuRe6sziEFRGNSv/3InztxTg6uSlOaSK/JnUoVBjtEGxYmiKcuUGX2A32OB+zRvx1
	SM2fpbm6597aBMLdnSma80PHDhfdtnWVx38lFUKuJscoFewOBgIUF8t1mVIg8la3CrtBQEQWySE
	gv0A==
X-Gm-Gg: ASbGncvcgQRTNcnwO1MRO0POlFnln430UBuuWqTLSms8qaYFNBC2OfFmzsnHChpTQG5
	SvfofSxUOG1t6gHjZYcS8UsuqhE/w4LRjy91crvwzR5ftJxmvVB8RXFOJgqJXL1WoQ5A3JI4Fdu
	Dc+OC28sOAp0Ocy38Q0yH5+M0tAfbZutBKGOoRaZY6ZHthBDSZe8tyzGyMj1xau40a5RLvjZv8Q
	OoFnu9OmbVA5y+xiDgI9Z1jzacOeQS2eh7cqKUNrjNVcnYaADMGCiDa9tn50aC81va13dENTG0L
	17uLr2tTrDmC6o9Q
X-Received: by 2002:a05:6a00:234c:b0:730:95f1:53ca with SMTP id d2e1a72fcca58-73426cb13f2mr4531978b3a.10.1740144917966;
        Fri, 21 Feb 2025 05:35:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq/r+LR01XwfOEzHEFA7rnHpUVwfkJMQ41uekwZKt7/CGhMgvh25td+6Y1WGU1qj2IhAbDxw==
X-Received: by 2002:a05:6a00:234c:b0:730:95f1:53ca with SMTP id d2e1a72fcca58-73426cb13f2mr4531945b3a.10.1740144917641;
        Fri, 21 Feb 2025 05:35:17 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:2777:7867:71cd:dd56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325d65619bsm12565459b3a.113.2025.02.21.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:35:17 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] gpio: virtuser: convert to use dev-sync-probe utilities
Date: Fri, 21 Feb 2025 22:35:01 +0900
Message-ID: <20250221133501.2203897-4-koichiro.den@canonical.com>
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

Update gpio-virtuser to use the new dev-sync-probe helper functions for
synchronized platform device creation, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig         |  1 +
 drivers/gpio/gpio-virtuser.c | 73 +++++-------------------------------
 2 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 297ad8f78f38..59c48c632197 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1938,6 +1938,7 @@ config GPIO_VIRTUSER
 	select DEBUG_FS
 	select CONFIGFS_FS
 	select IRQ_WORK
+	select DEV_SYNC_PROBE
 	help
 	  Say Y here to enable the configurable, configfs-based virtual GPIO
 	  consumer testing driver.
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index e89f299f2140..13407fd4f0eb 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -11,7 +11,6 @@
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/cleanup.h>
-#include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
@@ -37,6 +36,8 @@
 #include <linux/string_helpers.h>
 #include <linux/types.h>
 
+#include "dev-sync-probe.h"
+
 #define GPIO_VIRTUSER_NAME_BUF_LEN 32
 
 static DEFINE_IDA(gpio_virtuser_ida);
@@ -973,49 +974,17 @@ static struct platform_driver gpio_virtuser_driver = {
 };
 
 struct gpio_virtuser_device {
+	struct dev_sync_probe_data probe_data;
 	struct config_group group;
 
-	struct platform_device *pdev;
 	int id;
 	struct mutex lock;
 
-	struct notifier_block bus_notifier;
-	struct completion probe_completion;
-	bool driver_bound;
-
 	struct gpiod_lookup_table *lookup_table;
 
 	struct list_head lookup_list;
 };
 
-static int gpio_virtuser_bus_notifier_call(struct notifier_block *nb,
-					   unsigned long action, void *data)
-{
-	struct gpio_virtuser_device *vdev;
-	struct device *dev = data;
-	char devname[32];
-
-	vdev = container_of(nb, struct gpio_virtuser_device, bus_notifier);
-	snprintf(devname, sizeof(devname), "gpio-virtuser.%d", vdev->id);
-
-	if (!device_match_name(dev, devname))
-		return NOTIFY_DONE;
-
-	switch (action) {
-	case BUS_NOTIFY_BOUND_DRIVER:
-		vdev->driver_bound = true;
-		break;
-	case BUS_NOTIFY_DRIVER_NOT_BOUND:
-		vdev->driver_bound = false;
-		break;
-	default:
-		return NOTIFY_DONE;
-	}
-
-	complete(&vdev->probe_completion);
-	return NOTIFY_OK;
-}
-
 static struct gpio_virtuser_device *
 to_gpio_virtuser_device(struct config_item *item)
 {
@@ -1029,7 +998,7 @@ gpio_virtuser_device_is_live(struct gpio_virtuser_device *dev)
 {
 	lockdep_assert_held(&dev->lock);
 
-	return !!dev->pdev;
+	return !!dev->probe_data.pdev;
 }
 
 struct gpio_virtuser_lookup {
@@ -1369,7 +1338,7 @@ gpio_virtuser_device_config_dev_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	pdev = dev->pdev;
+	pdev = dev->probe_data.pdev;
 	if (pdev)
 		return sprintf(page, "%s\n", dev_name(&pdev->dev));
 
@@ -1478,7 +1447,6 @@ gpio_virtuser_device_activate(struct gpio_virtuser_device *dev)
 {
 	struct platform_device_info pdevinfo;
 	struct fwnode_handle *swnode;
-	struct platform_device *pdev;
 	int ret;
 
 	lockdep_assert_held(&dev->lock);
@@ -1499,31 +1467,12 @@ gpio_virtuser_device_activate(struct gpio_virtuser_device *dev)
 	if (ret)
 		goto err_remove_swnode;
 
-	reinit_completion(&dev->probe_completion);
-	dev->driver_bound = false;
-	bus_register_notifier(&platform_bus_type, &dev->bus_notifier);
-
-	pdev = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(pdev)) {
-		ret = PTR_ERR(pdev);
-		bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
+	ret = dev_sync_probe_register(&dev->probe_data, &pdevinfo);
+	if (ret)
 		goto err_remove_lookup_table;
-	}
-
-	wait_for_completion(&dev->probe_completion);
-	bus_unregister_notifier(&platform_bus_type, &dev->bus_notifier);
-
-	if (!dev->driver_bound) {
-		ret = -ENXIO;
-		goto err_unregister_pdev;
-	}
-
-	dev->pdev = pdev;
 
 	return 0;
 
-err_unregister_pdev:
-	platform_device_unregister(pdev);
 err_remove_lookup_table:
 	gpio_virtuser_remove_lookup_table(dev);
 err_remove_swnode:
@@ -1539,11 +1488,10 @@ gpio_virtuser_device_deactivate(struct gpio_virtuser_device *dev)
 
 	lockdep_assert_held(&dev->lock);
 
-	swnode = dev_fwnode(&dev->pdev->dev);
-	platform_device_unregister(dev->pdev);
+	swnode = dev_fwnode(&dev->probe_data.pdev->dev);
+	dev_sync_probe_unregister(&dev->probe_data);
 	gpio_virtuser_remove_lookup_table(dev);
 	fwnode_remove_software_node(swnode);
-	dev->pdev = NULL;
 }
 
 static void
@@ -1772,8 +1720,7 @@ gpio_virtuser_config_make_device_group(struct config_group *group,
 				    &gpio_virtuser_device_config_group_type);
 	mutex_init(&dev->lock);
 	INIT_LIST_HEAD(&dev->lookup_list);
-	dev->bus_notifier.notifier_call = gpio_virtuser_bus_notifier_call;
-	init_completion(&dev->probe_completion);
+	dev_sync_probe_init(&dev->probe_data);
 
 	return &no_free_ptr(dev)->group;
 }
-- 
2.45.2



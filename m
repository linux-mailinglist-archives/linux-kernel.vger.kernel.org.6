Return-Path: <linux-kernel+bounces-517837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79243A3867C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E45F3A7234
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD09221DA2;
	Mon, 17 Feb 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kb90MKhK"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92B22068E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802525; cv=none; b=R0ftZ6z6CpVeRLY7+yYJBFX0gFsO4AMXJKdhALNYGoyDzp+SpB0DvoK5tgDp/TFZLlCSGj+lYNS5nQ3+ztTPhLKwm4DLnTIVtOR9lY6N55cIFM4l4U4EJNFyv7h4MWmHGXqYczpj4f1sI0mKdtVu/FpYieNqeehtxUi0f5Fl7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802525; c=relaxed/simple;
	bh=kgTHhR4YUfUQvLTcLHSzDC9nY3pfgiRlMVx62VhpKuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcYEva4HncoISKFc2b1tlUHx7zVGBOah3/Yb2Hrz0/NQ0TDgLC51yfdl/xd1UnXaQ0jYCNayMglUSlKVV6o3oSzwywST0HHMJA1hJugCYr7IQffdt2KaShvJIi744zSFOZpsXsfP4ZUGHEE5oNuvMenHA0ZxdtYfJGKnAU2jBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kb90MKhK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85D0D3F880
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802520;
	bh=ejmbjvPRmedRPsWRD+UddjAoJvDsol1360tkb/DZqGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=kb90MKhK+WhvhhswF/4a24OUY6Xkh+iL0t0CMOkHD97+juu2OY85dYAlSrFYj8YXA
	 z3l8dsaAtYbCBC8CviNWknPk6z8B5W8EvvUJGpi1DNrrvxgxHwb2eyQ50awtNlVqmW
	 BRIUAgTw7JgCUqbgGqTnP4RM79EEVp8h0WyG66fNPTQvcJpqqvWOKjQ/iOqxjll7Qd
	 RnzsF+ZPuTrm0ptIJ5xBedHRXOy/oFiRRqwqZ4YTLyCtM8V88UYTUYb+2aHCkCi46s
	 VSbWWmZ+uAgwZkV7qmJ5dRj48FP3rZbXEDxyoflkVC3JKS534jF9VXPIvtspH9LeFA
	 TH+KOAH6dnZjA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22101839788so50124605ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802518; x=1740407318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejmbjvPRmedRPsWRD+UddjAoJvDsol1360tkb/DZqGw=;
        b=ScuG1Be9cY9Hq++xC7zLvqwME79xySY2t5KD8BY2+uakRnJ3wC6LZt0mE3acw7dU6a
         iuFEz6zNQ3mrIwkCSxmklWlzZgPgodEHKhtMQXk9xK4bqWurjgE2eQy0ClwY6r8TLIzu
         ZUpw3+v9cAz6i7VGrikxZ0Q1cfojyVtpZAgsB+Cw6eP7I9q4Iow/jxKtpZKnspiqPnTS
         uWeOVilWjHbKbKQOons2IzX9qDWvxmJXhlGAAjWjncX8lbcCpFg/ozbZe6EGS2dlW6q5
         BFpfGFJgWe1GS6oOinQvDvnCqbVhrzY+bnXoZiCouZPTXK+tgjzcHKuBfeb1DMdCVjyz
         Z5AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7e9nU3YfmTz/tibwmE8ys/YLnqtluFc2Qi3HgKvXC3CpFJPe4dznG5ki6D23vb4F4TuSMqBQJqMfDPc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9lEa6+gJbjMMOR9JbhVqxEyrlMDqlIDNrsOxznlGIBgaD4AvD
	NMwDqT1lHsSJhM55QyYk65vWHT75y+5kNifdZQB8DbW+jTPtLRbWSD9Wy7kJGUxcyBeyUOzs7S1
	Qsz19KJ7iq7kpKzzvlIVoZV7n/mPPANFYTn6mVHnzhXM/Ofb4y4b3D2152OS8FW16I10tbBkUU8
	vd4GvBj5Bypg==
X-Gm-Gg: ASbGncs5psb7Bpv2t8T63ETqfPrYgOkhX8Lb2Oh0Sd6skY4fhfBDTzAb8qxY3S3wmQk
	sg58+9Q9IeJo2qism3ONaa48GqL1RA1vQNL6/mZQTgLQXfshEVqeoH988iSF/SGW4g40eIVhS/U
	wmWmGLxEdkXm4WRU6jOz0tEpRHw+mzHIYeZ0Neis+Et8oNNCtoL8JQ3kXpdiUn/UoNNtcgySLS/
	OCF6ysNNFcZ7fG+wRpmYRwcDX9IeGcr3uSBc0HxSR1+EmmZ8+FVWUVHPLSmtIOL9mPxCMUGjBdR
	+ceD9teJFGbOTLikLs1go+g=
X-Received: by 2002:a17:902:f612:b0:21f:9c7:2d2e with SMTP id d9443c01a7336-221040bdb68mr172681185ad.40.1739802517930;
        Mon, 17 Feb 2025 06:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOgk8p2bSJvuLs/oEyFap3MbF7dqcx6MlSiZYeTYQTftD3iALVIhnHNeIrILA8yaAsNNn1Bg==
X-Received: by 2002:a17:902:f612:b0:21f:9c7:2d2e with SMTP id d9443c01a7336-221040bdb68mr172680895ad.40.1739802517600;
        Mon, 17 Feb 2025 06:28:37 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm72237735ad.243.2025.02.17.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:28:37 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] gpio: virtuser: convert to use gpio-pseudo utilities
Date: Mon, 17 Feb 2025 23:27:58 +0900
Message-ID: <20250217142758.540601-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217142758.540601-1-koichiro.den@canonical.com>
References: <20250217142758.540601-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update gpio-virtuser to use the new gpio-pseudo helper functions for
synchronized platform device creation, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/Kconfig         |  1 +
 drivers/gpio/gpio-virtuser.c | 73 +++++-------------------------------
 2 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index c482e3494bac..d8fede07149f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1942,6 +1942,7 @@ config GPIO_VIRTUSER
 	select DEBUG_FS
 	select CONFIGFS_FS
 	select IRQ_WORK
+	select GPIO_PSEUDO
 	help
 	  Say Y here to enable the configurable, configfs-based virtual GPIO
 	  consumer testing driver.
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index e89f299f2140..a825edc6fbc5 100644
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
 
+#include "gpio-pseudo.h"
+
 #define GPIO_VIRTUSER_NAME_BUF_LEN 32
 
 static DEFINE_IDA(gpio_virtuser_ida);
@@ -973,49 +974,17 @@ static struct platform_driver gpio_virtuser_driver = {
 };
 
 struct gpio_virtuser_device {
+	struct pseudo_gpio_common common;
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
+	return !!dev->common.pdev;
 }
 
 struct gpio_virtuser_lookup {
@@ -1369,7 +1338,7 @@ gpio_virtuser_device_config_dev_name_show(struct config_item *item,
 
 	guard(mutex)(&dev->lock);
 
-	pdev = dev->pdev;
+	pdev = dev->common.pdev;
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
+	ret = pseudo_gpio_register(&dev->common, &pdevinfo);
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
+	swnode = dev_fwnode(&dev->common.pdev->dev);
+	pseudo_gpio_unregister(&dev->common);
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
+	pseudo_gpio_init(&dev->common);
 
 	return &no_free_ptr(dev)->group;
 }
-- 
2.45.2



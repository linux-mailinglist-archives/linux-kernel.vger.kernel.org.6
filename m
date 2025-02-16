Return-Path: <linux-kernel+bounces-516584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254DFA3745B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170591891BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CE11917F0;
	Sun, 16 Feb 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pE0FEtNV"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEF192B75
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710722; cv=none; b=i7Q0+WEPQLfN08/G4+LYggF7GRd9bg0Kah/R7C8dqvTLDiHCeCbbuMm4+2aN4OGlDb7L1Zpif+twxw+svP9vPa4L5olMGvq1LlJtMduFGLgcZ+ppvfD/ot6JQBG4qGhyV8SsgyG/6T6zG+W0zHMGsWmCljIojkgPXhbwKlN8wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710722; c=relaxed/simple;
	bh=ON0ehqNkL/xvxuSncxnJd1gtNg+6gWPXLCaJXpCE84w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6AwkjaUdWB5QM3p7fJdw9r0TwYJMbndpqhGiY+wmJ0tJWyvvOqzV7Zn46x4QRRwQ+2Ls+uQyL3sXrI8uuphfewHBubAR9BEK6zFJ5KkQMKQB14He1Tb2PbKRsPbeXw1QO5USzh/0Q9nN4/xnIaWMAYJHAwujdW95kB51T6zl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pE0FEtNV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 07C5A3F87A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710713;
	bh=/dv1clno4vwekIxpQT8JlY6+oBRlXDyt/p4pqtLh8l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pE0FEtNVVAIOwUSlri8XNQXUAZjteXxuWkbOAdEhW6rgy1wF45OetBKud5otbKPtJ
	 xU7PAsqiVhBYVdVz+oDzHxGxp2E1gywb0nqlWYB369SJBxM+WDVtxCdARmrzDXedJr
	 DGohQYhIIoIeJEHhkTeEHQ+SI2ZAX4v6evoKTG6haqdQkx4WiNtKYe0u/qd95knkE0
	 Md2g2n/h0HkTN0b42z7TdjOJvDEtPPIVSbCnDul8q2uoeY0BDbg5HhMisoUlYQmTer
	 1Rg053qTKcyhpIbsf8jQzt1LgwUSssresKl3vsc0En731QolLMbsHkwy7j3ye+wmwk
	 wlCnB+ZrN63fQ==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso11007616a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710709; x=1740315509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dv1clno4vwekIxpQT8JlY6+oBRlXDyt/p4pqtLh8l4=;
        b=K4jCzUYNjZLQEU519nSVmzK7bGNMEbdMIu2l5LaeIj+Tb2oIwAg2U4gIozre3qm9kN
         KRmnvXtJ1r394+wDqNHLExClUoq07oTdB716j7axyOVL/vC8iwKEQhowoWevtVI8zZoP
         nCXDfJ/uASsR/XitEvGZLX+5evfMeijIL17Bmo2jXhkzXRDHfCBrBJufV3ITy8f9kRqH
         dQ16izCYuikkSwHALsknXsXjtC1/YxV9Mro6jrkag0soFarDDHR9FQHD88KtkSG0HHpD
         B4R7jkdt6UHKEYUnWxK9dYrvU/xDgWZig611Ijlf/3xlauv7Jv3vWkvEQpAMQQebKpn6
         D5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhY/fFJ0DXf+rDw8v9+2h1z0fFyDKRnaajKwlbrw1MCzJhXrABhVIHrAltffzSLVqKk9E0avlrO7cm7Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0shzBF1SdLD8kFPb7qsmjgClHXgsdO7XiFdpCNIRziWkfruX
	uNffzPTsJ0l1dUHF3071OznVsszrc4dQiNxvUW9ls2HzynqgwpreeW7LMfqbjLQGxw6kgrIimQ4
	tljh04qhQ2PZRqAzsmn1qJXZ0J4Hj5bEEj+/3EI8c3HuSU/3YzmXYNUN8k5SwBVtcgyYMM27EQr
	RBTw==
X-Gm-Gg: ASbGnct4JNWsP4+rjOsozSan2SQPrHpQf5AwemuS0kVnpKl/VVSEQN3d0ylDj2gAKGN
	sgllhX0RhRuGDTq6OQBk0Gve/MJE+gpzx9d43nZ2JuW+xob1IM6il5dHmzr4s9Ii0L5GS3y0HIB
	KlLFVez38i6Qq8huPbru45XIjHAWE5iHkI95Spcfac/JbvLRaw1Up5CVeRo6dKEReG1bwKejLzy
	RzHAUxl2wk8vbRr+GxzUYm8fttGkbPHh4WTqcTb23KYMdq9iM3RNpThWmINSEA9sO1C88ERPUgD
	Sxu4JA==
X-Received: by 2002:a05:6a00:1488:b0:731:771:38f2 with SMTP id d2e1a72fcca58-732617999fdmr11611742b3a.8.1739710709445;
        Sun, 16 Feb 2025 04:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr0sSHEuxQ/iRTDuywgcXZzEo/SyHTpbRxRCvFg9+hwaoEIdP0tYG9nBhVnyE+pI/KYmPfFg==
X-Received: by 2002:a05:6a00:1488:b0:731:771:38f2 with SMTP id d2e1a72fcca58-732617999fdmr11611706b3a.8.1739710709068;
        Sun, 16 Feb 2025 04:58:29 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:28 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] gpio: aggregator: reorder functions to prepare for configfs introduction
Date: Sun, 16 Feb 2025 21:58:04 +0900
Message-ID: <20250216125816.14430-2-koichiro.den@canonical.com>
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

Reorder functions in drivers/gpio/gpio-aggregator.c to prepare for the
configfs-based interface additions in subsequent commits. Arrange the
code so that the configfs implementations will appear above the existing
sysfs-specific code, since the latter will partly depend on the configfs
interface implementations when it starts to expose the settings to
configfs.

The order in drivers/gpio/gpio-aggregator.c will be as follows:

* Basic gpio_aggregator/gpio_aggregator_line representations
* Common utility functions
* GPIO Forwarder implementations
* Configfs interface implementations
* Sysfs interface implementations
* Platform device implementations
* Module init/exit implementations

This separate commit ensures a clean diff for the subsequent commits.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 352 +++++++++++++++++----------------
 1 file changed, 178 insertions(+), 174 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 65f41cc3eafc..570cd1ff8cc2 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -61,180 +61,6 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
 	return 0;
 }
 
-static int aggr_parse(struct gpio_aggregator *aggr)
-{
-	char *args = skip_spaces(aggr->args);
-	char *name, *offsets, *p;
-	unsigned int i, n = 0;
-	int error = 0;
-
-	unsigned long *bitmap __free(bitmap) =
-			bitmap_alloc(AGGREGATOR_MAX_GPIOS, GFP_KERNEL);
-	if (!bitmap)
-		return -ENOMEM;
-
-	args = next_arg(args, &name, &p);
-	while (*args) {
-		args = next_arg(args, &offsets, &p);
-
-		p = get_options(offsets, 0, &error);
-		if (error == 0 || *p) {
-			/* Named GPIO line */
-			error = aggr_add_gpio(aggr, name, U16_MAX, &n);
-			if (error)
-				return error;
-
-			name = offsets;
-			continue;
-		}
-
-		/* GPIO chip + offset(s) */
-		error = bitmap_parselist(offsets, bitmap, AGGREGATOR_MAX_GPIOS);
-		if (error) {
-			pr_err("Cannot parse %s: %d\n", offsets, error);
-			return error;
-		}
-
-		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
-			error = aggr_add_gpio(aggr, name, i, &n);
-			if (error)
-				return error;
-		}
-
-		args = next_arg(args, &name, &p);
-	}
-
-	if (!n) {
-		pr_err("No GPIOs specified\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static ssize_t new_device_store(struct device_driver *driver, const char *buf,
-				size_t count)
-{
-	struct gpio_aggregator *aggr;
-	struct platform_device *pdev;
-	int res, id;
-
-	/* kernfs guarantees string termination, so count + 1 is safe */
-	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
-
-	memcpy(aggr->args, buf, count + 1);
-
-	aggr->lookups = kzalloc(struct_size(aggr->lookups, table, 1),
-				GFP_KERNEL);
-	if (!aggr->lookups) {
-		res = -ENOMEM;
-		goto free_ga;
-	}
-
-	mutex_lock(&gpio_aggregator_lock);
-	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
-	mutex_unlock(&gpio_aggregator_lock);
-
-	if (id < 0) {
-		res = id;
-		goto free_table;
-	}
-
-	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
-	if (!aggr->lookups->dev_id) {
-		res = -ENOMEM;
-		goto remove_idr;
-	}
-
-	res = aggr_parse(aggr);
-	if (res)
-		goto free_dev_id;
-
-	gpiod_add_lookup_table(aggr->lookups);
-
-	pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
-	if (IS_ERR(pdev)) {
-		res = PTR_ERR(pdev);
-		goto remove_table;
-	}
-
-	aggr->pdev = pdev;
-	return count;
-
-remove_table:
-	gpiod_remove_lookup_table(aggr->lookups);
-free_dev_id:
-	kfree(aggr->lookups->dev_id);
-remove_idr:
-	mutex_lock(&gpio_aggregator_lock);
-	idr_remove(&gpio_aggregator_idr, id);
-	mutex_unlock(&gpio_aggregator_lock);
-free_table:
-	kfree(aggr->lookups);
-free_ga:
-	kfree(aggr);
-	return res;
-}
-
-static DRIVER_ATTR_WO(new_device);
-
-static void gpio_aggregator_free(struct gpio_aggregator *aggr)
-{
-	platform_device_unregister(aggr->pdev);
-	gpiod_remove_lookup_table(aggr->lookups);
-	kfree(aggr->lookups->dev_id);
-	kfree(aggr->lookups);
-	kfree(aggr);
-}
-
-static ssize_t delete_device_store(struct device_driver *driver,
-				   const char *buf, size_t count)
-{
-	struct gpio_aggregator *aggr;
-	unsigned int id;
-	int error;
-
-	if (!str_has_prefix(buf, DRV_NAME "."))
-		return -EINVAL;
-
-	error = kstrtouint(buf + strlen(DRV_NAME "."), 10, &id);
-	if (error)
-		return error;
-
-	mutex_lock(&gpio_aggregator_lock);
-	aggr = idr_remove(&gpio_aggregator_idr, id);
-	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
-		return -ENOENT;
-
-	gpio_aggregator_free(aggr);
-	return count;
-}
-static DRIVER_ATTR_WO(delete_device);
-
-static struct attribute *gpio_aggregator_attrs[] = {
-	&driver_attr_new_device.attr,
-	&driver_attr_delete_device.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(gpio_aggregator);
-
-static int __exit gpio_aggregator_idr_remove(int id, void *p, void *data)
-{
-	gpio_aggregator_free(p);
-	return 0;
-}
-
-static void __exit gpio_aggregator_remove_all(void)
-{
-	mutex_lock(&gpio_aggregator_lock);
-	idr_for_each(&gpio_aggregator_idr, gpio_aggregator_idr_remove, NULL);
-	idr_destroy(&gpio_aggregator_idr);
-	mutex_unlock(&gpio_aggregator_lock);
-}
-
 
 /*
  *  GPIO Forwarder
@@ -559,6 +385,170 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
 }
 
 
+/*
+ * Sysfs interface
+ */
+static int aggr_parse(struct gpio_aggregator *aggr)
+{
+	char *args = skip_spaces(aggr->args);
+	char *name, *offsets, *p;
+	unsigned int i, n = 0;
+	int error = 0;
+
+	unsigned long *bitmap __free(bitmap) =
+			bitmap_alloc(AGGREGATOR_MAX_GPIOS, GFP_KERNEL);
+	if (!bitmap)
+		return -ENOMEM;
+
+	args = next_arg(args, &name, &p);
+	while (*args) {
+		args = next_arg(args, &offsets, &p);
+
+		p = get_options(offsets, 0, &error);
+		if (error == 0 || *p) {
+			/* Named GPIO line */
+			error = aggr_add_gpio(aggr, name, U16_MAX, &n);
+			if (error)
+				return error;
+
+			name = offsets;
+			continue;
+		}
+
+		/* GPIO chip + offset(s) */
+		error = bitmap_parselist(offsets, bitmap, AGGREGATOR_MAX_GPIOS);
+		if (error) {
+			pr_err("Cannot parse %s: %d\n", offsets, error);
+			return error;
+		}
+
+		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
+			error = aggr_add_gpio(aggr, name, i, &n);
+			if (error)
+				return error;
+		}
+
+		args = next_arg(args, &name, &p);
+	}
+
+	if (!n) {
+		pr_err("No GPIOs specified\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t new_device_store(struct device_driver *driver, const char *buf,
+				size_t count)
+{
+	struct gpio_aggregator *aggr;
+	struct platform_device *pdev;
+	int res, id;
+
+	/* kernfs guarantees string termination, so count + 1 is safe */
+	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
+	if (!aggr)
+		return -ENOMEM;
+
+	memcpy(aggr->args, buf, count + 1);
+
+	aggr->lookups = kzalloc(struct_size(aggr->lookups, table, 1),
+				GFP_KERNEL);
+	if (!aggr->lookups) {
+		res = -ENOMEM;
+		goto free_ga;
+	}
+
+	mutex_lock(&gpio_aggregator_lock);
+	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
+	mutex_unlock(&gpio_aggregator_lock);
+
+	if (id < 0) {
+		res = id;
+		goto free_table;
+	}
+
+	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
+	if (!aggr->lookups->dev_id) {
+		res = -ENOMEM;
+		goto remove_idr;
+	}
+
+	res = aggr_parse(aggr);
+	if (res)
+		goto free_dev_id;
+
+	gpiod_add_lookup_table(aggr->lookups);
+
+	pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
+	if (IS_ERR(pdev)) {
+		res = PTR_ERR(pdev);
+		goto remove_table;
+	}
+
+	aggr->pdev = pdev;
+	return count;
+
+remove_table:
+	gpiod_remove_lookup_table(aggr->lookups);
+free_dev_id:
+	kfree(aggr->lookups->dev_id);
+remove_idr:
+	mutex_lock(&gpio_aggregator_lock);
+	idr_remove(&gpio_aggregator_idr, id);
+	mutex_unlock(&gpio_aggregator_lock);
+free_table:
+	kfree(aggr->lookups);
+free_ga:
+	kfree(aggr);
+	return res;
+}
+
+static DRIVER_ATTR_WO(new_device);
+
+static void gpio_aggregator_free(struct gpio_aggregator *aggr)
+{
+	platform_device_unregister(aggr->pdev);
+	gpiod_remove_lookup_table(aggr->lookups);
+	kfree(aggr->lookups->dev_id);
+	kfree(aggr->lookups);
+	kfree(aggr);
+}
+
+static ssize_t delete_device_store(struct device_driver *driver,
+				   const char *buf, size_t count)
+{
+	struct gpio_aggregator *aggr;
+	unsigned int id;
+	int error;
+
+	if (!str_has_prefix(buf, DRV_NAME "."))
+		return -EINVAL;
+
+	error = kstrtouint(buf + strlen(DRV_NAME "."), 10, &id);
+	if (error)
+		return error;
+
+	mutex_lock(&gpio_aggregator_lock);
+	aggr = idr_remove(&gpio_aggregator_idr, id);
+	mutex_unlock(&gpio_aggregator_lock);
+	if (!aggr)
+		return -ENOENT;
+
+	gpio_aggregator_free(aggr);
+	return count;
+}
+static DRIVER_ATTR_WO(delete_device);
+
+static struct attribute *gpio_aggregator_attrs[] = {
+	&driver_attr_new_device.attr,
+	&driver_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(gpio_aggregator);
+
+
 /*
  *  GPIO Aggregator platform device
  */
@@ -616,6 +606,20 @@ static struct platform_driver gpio_aggregator_driver = {
 	},
 };
 
+static int __exit gpio_aggregator_idr_remove(int id, void *p, void *data)
+{
+	gpio_aggregator_free(p);
+	return 0;
+}
+
+static void __exit gpio_aggregator_remove_all(void)
+{
+	mutex_lock(&gpio_aggregator_lock);
+	idr_for_each(&gpio_aggregator_idr, gpio_aggregator_idr_remove, NULL);
+	idr_destroy(&gpio_aggregator_idr);
+	mutex_unlock(&gpio_aggregator_lock);
+}
+
 static int __init gpio_aggregator_init(void)
 {
 	return platform_driver_register(&gpio_aggregator_driver);
-- 
2.45.2



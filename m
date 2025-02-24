Return-Path: <linux-kernel+bounces-529374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82AA423EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D88170A56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5818C01D;
	Mon, 24 Feb 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JtrYADiA"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D62A8D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408007; cv=none; b=qDY/7bbkKhoTyMrti0GNizAyxWg/Si6+eDNk4CDjsWzT+OY1wXP5yhiAKSYPvd3JxzOr+r2CEiib5AEXmrTtvm79ceGFN/8F6q2Ll7+dhzJwiV6R5UFcEvkii8iJQzh9WnnFFdYcxPpZKFBQoxNTpZTu+d3ELjvOCWKM5PLX1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408007; c=relaxed/simple;
	bh=t3zTiX5sHGMNY70DRwaiaym4vc9V90iUU2jCySp7s2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa/aHd6S1R6m7kY9s7LHE0iUONfp6vxacI1tKVuChXEaN3oS/YkmNCpR5FGx8SQMMvulgO4Tw2q9PIpHKzpmw1gX10QHty0LOUFSQ2E+SL758ddDgaAkYq0vpQJUaR0Z6O9yMkaJ2QBAL2QNj6kEfvOkDQfHjatOW675IdoFa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JtrYADiA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5E1253F84C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740407509;
	bh=/Zis01mTN9hfdwdw4CsGVb5gEILpfxFjWK2yfeVkHJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=JtrYADiALa/QXCBXUSE+JzItMmz11+GSniUT8ERpk/XCgChl0ep5QqL44qmIP/uIG
	 eonRA0kbeoWKFgQcRLDtM6kOYSzEBYrdHFUf2V/5xlJj4kwDASfiKN6mjCl7gk7EUZ
	 WVZrS09FKAeilj6r8N+pWs+984lzkzTq8/+eCf4qXufZoUS6lpqRq06dNPqEpLWh8m
	 GAiq55k4ntaU4JfLojmdfg+Opv1VJRlJXYl/8rnOsS45hj05M049p0WNd0M0gmk8AV
	 li04V1Arvc0T9SKqHYyScQ9cxiiHvaAWWQF/RXVed/BOEuZyujSqBRlDqPcgDYfLYD
	 xHPvDeiLVhiwg==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22101351b1dso88447735ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407507; x=1741012307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zis01mTN9hfdwdw4CsGVb5gEILpfxFjWK2yfeVkHJw=;
        b=xHGnUW8fonbF2GDpSP3P9pTk3jmpJDfiMh9ZMI9njpE7tAlQc/xTXROheZBe3SPd5n
         mK1Nyzf2QOifF6vCTEzU4sqqkiK5dAZ+natp2beW4KNtgiS8CkcB2aVyUa+282da5N0z
         w2rHPZiEWvUl/44TT32kn6PMeofxa42e5I8GABRH3tBUpPrOTUIYypfVyReX9NZM3p0t
         45AV+s7eKC6rgWk1kEgtEY8zc5PBIanJeBUH1sQAx/BdBWzRCMK5OwI9f1r+1B+UH3T/
         iXk0M2S6eqLKEqsxu7FSNY24bsKGwc8R8HgJlFu/8xxe7fNQGVHPZj40iHMJaBzBEFS1
         MNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAX73DD4YqZbbrCa2rCKIfx9t7iqSPzdrRh8YavHQ+oeJGrPGvWFYLgMbmLW1hPImN4TwlNUhkh4YWQ0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwizlTKVttOCo368xvEYkkBfyoA2OvdZkK4c5atXdP6CsynuOsi
	+uAJNTpX80B7EJixhQoQJJS1za//SBA8xME6+ZIin68yRyZ/X00+pOcSzlfrfhCp8jGfc09zqnz
	Pxtr9HBLEKU5INODDa9sQusyQ4jXrk/LeNj8JhBA8tNuTVl9FmTFVwRasI/CrChHQZd7P/uwy7a
	ghPg==
X-Gm-Gg: ASbGnctD97elJQCgKYltZDwu0hTtb3wpW1db0hTUROtsWPnLwIRBshpkrJ8pinIp7ab
	iP0d21veZOyysEvY+Sg5casVZLAmubYjQsAe88k26KOcK363CehBHFRcZylsQsRxZPMaHxLR67C
	oI/H2Ylzn8U2wfK4yagRpgI/mCo8FsRsdIkodbdwExtr45KYBC6ZXyHJRvvuG/JZiZnkBkKaP1E
	mgNtELr/L93+JSoW6/p+pDYiFpEaQWJC/zqgN+vXqohJ/hNiibuQMYIDKIIZCDE/+BJDb2gfcLv
	UomGJTHddBiirx1m
X-Received: by 2002:a17:902:e88d:b0:220:f91a:4650 with SMTP id d9443c01a7336-2219ff55febmr194362675ad.19.1740407507536;
        Mon, 24 Feb 2025 06:31:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGphQ/PZnVMBQrukUNH4LwkASfNLpLh+p59bv080yBc+b6gas1SufycE7np8ybd/zi8TU36Yg==
X-Received: by 2002:a17:902:e88d:b0:220:f91a:4650 with SMTP id d9443c01a7336-2219ff55febmr194362345ad.19.1740407507138;
        Mon, 24 Feb 2025 06:31:47 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:de7b:58db:ab85:24ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d067sm177613895ad.109.2025.02.24.06.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:31:46 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] gpio: aggregator: reorder functions to prepare for configfs introduction
Date: Mon, 24 Feb 2025 23:31:27 +0900
Message-ID: <20250224143134.3024598-3-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224143134.3024598-1-koichiro.den@canonical.com>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 380 +++++++++++++++++----------------
 1 file changed, 192 insertions(+), 188 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index d668ddb2e81d..893cd56de867 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -61,194 +61,6 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
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
-	if (!try_module_get(THIS_MODULE))
-		return -ENOENT;
-
-	/* kernfs guarantees string termination, so count + 1 is safe */
-	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr) {
-		res = -ENOMEM;
-		goto put_module;
-	}
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
-	module_put(THIS_MODULE);
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
-put_module:
-	module_put(THIS_MODULE);
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
-	if (!try_module_get(THIS_MODULE))
-		return -ENOENT;
-
-	mutex_lock(&gpio_aggregator_lock);
-	aggr = idr_remove(&gpio_aggregator_idr, id);
-	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr) {
-		module_put(THIS_MODULE);
-		return -ENOENT;
-	}
-
-	gpio_aggregator_free(aggr);
-	module_put(THIS_MODULE);
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
@@ -573,6 +385,184 @@ static struct gpiochip_fwd *gpiochip_fwd_create(struct device *dev,
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
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
+	/* kernfs guarantees string termination, so count + 1 is safe */
+	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
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
+	module_put(THIS_MODULE);
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
+put_module:
+	module_put(THIS_MODULE);
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
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
+	mutex_lock(&gpio_aggregator_lock);
+	aggr = idr_remove(&gpio_aggregator_idr, id);
+	mutex_unlock(&gpio_aggregator_lock);
+	if (!aggr) {
+		module_put(THIS_MODULE);
+		return -ENOENT;
+	}
+
+	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
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
@@ -630,6 +620,20 @@ static struct platform_driver gpio_aggregator_driver = {
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



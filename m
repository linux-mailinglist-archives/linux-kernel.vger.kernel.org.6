Return-Path: <linux-kernel+bounces-562667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5AA6302F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A407189AC7D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F22046B1;
	Sat, 15 Mar 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QZdKtUgJ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4CD26D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056913; cv=none; b=adOgAtgeXxgnCJ4Xk8MIUGTpsapFjORqC7Ej5wa5M+GW1pQ1hnafMY5h/rDRU7Gv6r3u99R6l+AHMtwH+KBNe5xmrJqgNR01dtxOMczvgFmkvfe0N/oFvNH5Xz8oGNR7wSJBbxCVDw2pdp8l39ipK7DFKYavf13guobAMlAbrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056913; c=relaxed/simple;
	bh=tZpIixhIz63xwZmTsIFO5W2unoS3No4bx4rWhDwxvBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS3Jzbgz/EoZSN2KxhRYK10bluLnJ8NakKu3HegL0BdiaWfh0Npb4uCgEujT/eLqhRebl3iMqpkOASnIhKVJ9ozHNe6PDjBihsNc9djNyQ+KAQEyy2uYISEgtkenf5SkGfzrY81092xbKqC1UrkVh3zXv0nr3MOEQGJUz6IwEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QZdKtUgJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C6C73F31D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056909;
	bh=YNZ+f28bALe1cBFd+IhRUCCUv+emwMU47KrwcCRAyIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=QZdKtUgJuJ1boOzOiSSDTIBqCv1jFD1NQjgdazMUSNM7JAkqHtbANXWt7L+Kzm1js
	 5jALZchaJUczi64plAv16CCuTdWR6qZslJrJMM3DlcFeagCUBhsVhNCWx/FskCn275
	 yGFHTrtbrmFMB8eP6VUzVbfOcaB1M2IbGvmOv5ofzuHVjHixCMnhRDPp6HTuZzNjqt
	 v0tYeEMxhexOm2joEJhi8zOQQEoymPe9PCUrzhVDfT44ajAzF8uw2/sVebpd/xjS2p
	 J5HQ+952oXn8+S6jXTrbOK5QRqW80S8JPKuPniTBvtiqspqpwXpksGs2VzRpGvZw6N
	 EpZlXhMNLgonw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso2044391a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056907; x=1742661707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNZ+f28bALe1cBFd+IhRUCCUv+emwMU47KrwcCRAyIY=;
        b=Jg7UfOIdqeOvpz9VT1WCAKnnA5m19cmbPwSj4gNmyndbAFNgh0cpFmf2bTu02W6X2P
         PVv9+LbXQJJj0HtGHWWxEbXLLcy7vuSGIHnRVLHKMzu/XDmHwqhZImWBc/LUUIPFEeez
         w+jpW/X9sYFCcZko/censK5lEW1z6tAQNbzbNmH0MLrlsWD4dEOcnujaMsj5FNBaJcQG
         3xPpMam5RbV8d3CuWONc/1mVIxFwtzcrTBeBtMDJ9Q5Ej7DBcZG1cp7IJXj1wP0NW1Sx
         79IiieHx/axwScaSWwZEZwCNad21j8CJMWxl72wlJ0aJn/nPnhY0fkCx6wI00PK7Q4gK
         4M9g==
X-Forwarded-Encrypted: i=1; AJvYcCW3P/UktLUG01v4M6Rrqpuh7+2+wpxUcJty/x+jPCs7umfxc5jXjJZiRKMPjVg3q7PXwlG4bDzvMw7NTJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/yOKw/MaL8YEGL2CEWaK61amwDuSPUa3iDL7pgtZJkBJmFie
	n89PJ5iLvWXmg7VXz02eD6Dd117Vff8VWLFrFP2JsDM9MQVTPLtO1VWwN2AyazDhLichyyED/p9
	pbbohS9+kmkx3WjdKdh+geUiNa5SWKdhfAAVGW2ze36zaLzylfLRHRWPCupOHmKEiI0R5Jp+jzF
	Jx/Q==
X-Gm-Gg: ASbGncsvo9UzoQW6Av5i7YdRQ6bNvajc1vQ0hLLA0i/9VIdMF7m3BRbSvTLC20yBL9Q
	uf3OqwsBLbykxKiRD6HoNDuUJ3PuMpDHmnYMltIcxGBUoAi6u3prf7ypEK3EZl5sk7LC0dJpcQr
	cByCByK1Z58CW0pnRmqaIP/y7cpMLejZ1o12dKT73chM+uZt35G6+s8iXOrCLf/fLn/6dWacO3c
	bI9esnOnRJNJGx+vE3110/YxArzDXXWNOxxUDsGTRBYHFLkxXiFJZj5nJPyXAs4vlYY3BQMBZXY
	VA2Q9cW/N4sf+nxU
X-Received: by 2002:a05:6a21:9014:b0:1f5:87dc:a315 with SMTP id adf61e73a8af0-1f5c1183d5emr9009306637.12.1742056907219;
        Sat, 15 Mar 2025 09:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU0ceoD51BZ11smOJZX/JIzzQoRljOZk4JbL6veMWIaCrSH6Aif/TUrWT0CUiSbp4awP4Kbg==
X-Received: by 2002:a05:6a21:9014:b0:1f5:87dc:a315 with SMTP id adf61e73a8af0-1f5c1183d5emr9009286637.12.1742056906854;
        Sat, 15 Mar 2025 09:41:46 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:46 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] gpio: aggregator: expose aggregator created via legacy sysfs to configfs
Date: Sun, 16 Mar 2025 01:41:20 +0900
Message-ID: <20250315164123.1855142-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250315164123.1855142-1-koichiro.den@canonical.com>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose settings for aggregators created using the sysfs 'new_device'
interface to configfs. Once written to 'new_device', an "_sysfs.<N>" path
appears in the configfs regardless of whether the probe succeeds.
Consequently, users can no longer use that prefix for custom GPIO
aggregator names. The 'live' attribute changes to 1 when the probe
succeeds and the GPIO forwarder is instantiated.

Note that the aggregator device created via sysfs is asynchronous, i.e.
writing into 'new_device' returns without waiting for probe completion,
and the probe may succeed, fail, or eventually succeed via deferred
probe. Thus, the 'live' attribute may change from 0 to 1 asynchronously
without notice. So, editing key/offset/name while it's waiting for
deferred probe is prohibited.

The configfs auto-generation relies on create_default_group(), which
inherently prohibits rmdir(2). To align with the limitation, this commit
also prohibits mkdir(2) for them. When users want to change the number
of lines for an aggregator initialized via 'new_device', they need to
tear down the device using 'delete_device' and reconfigure it from
scratch. This does not break previous behavior; users of legacy sysfs
interface simply gain additional almost read-only configfs exposure.

Still, users can write to the 'live' attribute to toggle the device
unless it's waiting for deferred probe. So once probe succeeds, they can
deactivate it in the same manner as the devices initialized via
configfs.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 133 ++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 7087ac599ace..de693182070c 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -33,6 +33,7 @@
 #include "dev-sync-probe.h"
 
 #define AGGREGATOR_MAX_GPIOS 512
+#define AGGREGATOR_LEGACY_PREFIX "_sysfs"
 
 /*
  * GPIO Aggregator sysfs interface
@@ -131,6 +132,14 @@ static bool aggr_is_active(struct gpio_aggregator *aggr)
 	return aggr->probe_data.pdev && platform_get_drvdata(aggr->probe_data.pdev);
 }
 
+/* Only aggregators created via legacy sysfs can be "activating". */
+static bool aggr_is_activating(struct gpio_aggregator *aggr)
+{
+	lockdep_assert_held(&aggr->lock);
+
+	return aggr->probe_data.pdev && !platform_get_drvdata(aggr->probe_data.pdev);
+}
+
 static size_t aggr_count_lines(struct gpio_aggregator *aggr)
 {
 	lockdep_assert_held(&aggr->lock);
@@ -188,6 +197,30 @@ static void aggr_line_del(struct gpio_aggregator *aggr,
 	list_del(&line->entry);
 }
 
+static void aggr_free_lines(struct gpio_aggregator *aggr)
+{
+	struct gpio_aggregator_line *line, *tmp;
+
+	list_for_each_entry_safe(line, tmp, &aggr->list_head, entry) {
+		configfs_unregister_group(&line->group);
+		/*
+		 * Normally, we acquire aggr->lock within the configfs
+		 * callback. However, in the legacy sysfs interface case,
+		 * calling configfs_(un)register_group while holding
+		 * aggr->lock could cause a deadlock. Fortunately, this is
+		 * unnecessary because the new_device/delete_device path
+		 * and the module unload path are mutually exclusive,
+		 * thanks to an explicit try_module_get. That's why this
+		 * minimal scoped_guard suffices.
+		 */
+		scoped_guard(mutex, &aggr->lock)
+			aggr_line_del(aggr, line);
+		kfree(line->key);
+		kfree(line->name);
+		kfree(line);
+	}
+}
+
 
 /*
  *  GPIO Forwarder
@@ -697,7 +730,7 @@ gpio_aggr_line_key_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	kfree(line->key);
@@ -734,7 +767,7 @@ gpio_aggr_line_name_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	kfree(line->name);
@@ -782,7 +815,7 @@ gpio_aggr_line_offset_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	line->offset = offset;
@@ -841,11 +874,12 @@ gpio_aggr_device_live_store(struct config_item *item, const char *page,
 	if (!try_module_get(THIS_MODULE))
 		return -ENOENT;
 
-	if (live)
+	if (live && !aggr->init_via_sysfs)
 		aggr_lockup_configfs(aggr, true);
 
 	scoped_guard(mutex, &aggr->lock) {
-		if (live == aggr_is_active(aggr))
+		if (aggr_is_activating(aggr) ||
+		    (live == aggr_is_active(aggr)))
 			ret = -EPERM;
 		else if (live)
 			ret = aggr_activate(aggr);
@@ -857,7 +891,7 @@ gpio_aggr_device_live_store(struct config_item *item, const char *page,
 	 * Undepend is required only if device disablement (live == 0)
 	 * succeeds or if device enablement (live == 1) fails.
 	 */
-	if (live == !!ret)
+	if (live == !!ret && !aggr->init_via_sysfs)
 		aggr_lockup_configfs(aggr, false);
 
 	module_put(THIS_MODULE);
@@ -901,7 +935,7 @@ static void gpio_aggr_device_release(struct config_item *item)
 	struct gpio_aggregator *aggr = to_gpio_aggregator(item);
 
 	/*
-	 * If the aggregator is active, this code wouldn't be reached,
+	 * At this point, aggr is neither active nor activating,
 	 * so calling aggr_deactivate() is always unnecessary.
 	 */
 	aggr_free(aggr);
@@ -923,6 +957,15 @@ gpio_aggr_device_make_group(struct config_group *group, const char *name)
 	if (ret != 1 || nchar != strlen(name))
 		return ERR_PTR(-EINVAL);
 
+	if (aggr->init_via_sysfs)
+		/*
+		 * Aggregators created via legacy sysfs interface are exposed as
+		 * default groups, which means rmdir(2) is prohibited for them.
+		 * For simplicity, and to avoid confusion, we also prohibit
+		 * mkdir(2).
+		 */
+		return ERR_PTR(-EPERM);
+
 	guard(mutex)(&aggr->lock);
 
 	if (aggr_is_active(aggr))
@@ -960,6 +1003,14 @@ gpio_aggr_make_group(struct config_group *group, const char *name)
 	struct gpio_aggregator *aggr;
 	int ret;
 
+	/*
+	 * "_sysfs" prefix is reserved for auto-generated config group
+	 * for devices create via legacy sysfs interface.
+	 */
+	if (strncmp(name, AGGREGATOR_LEGACY_PREFIX,
+		    sizeof(AGGREGATOR_LEGACY_PREFIX)) == 0)
+		return ERR_PTR(-EINVAL);
+
 	/* arg space is unneeded */
 	ret = aggr_alloc(&aggr, 0);
 	if (ret)
@@ -996,6 +1047,8 @@ static struct configfs_subsystem gpio_aggr_subsys = {
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
 	char *args = skip_spaces(aggr->args);
+	struct gpio_aggregator_line *line;
+	char name[CONFIGFS_ITEM_NAME_LEN];
 	char *key, *offsets, *p;
 	unsigned int i, n = 0;
 	int error = 0;
@@ -1012,9 +1065,24 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		p = get_options(offsets, 0, &error);
 		if (error == 0 || *p) {
 			/* Named GPIO line */
+			scnprintf(name, sizeof(name), "line%u", n);
+			line = aggr_line_alloc(aggr, n, key, -1);
+			if (!line) {
+				error = -ENOMEM;
+				goto err;
+			}
+			config_group_init_type_name(&line->group, name,
+						    &gpio_aggr_line_type);
+			error = configfs_register_group(&aggr->group,
+							&line->group);
+			if (error)
+				goto err;
+			scoped_guard(mutex, &aggr->lock)
+				aggr_line_add(aggr, line);
+
 			error = aggr_add_gpio(aggr, key, U16_MAX, &n);
 			if (error)
-				return error;
+				goto err;
 
 			key = offsets;
 			continue;
@@ -1028,9 +1096,24 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
+			scnprintf(name, sizeof(name), "line%u", n);
+			line = aggr_line_alloc(aggr, n, key, i);
+			if (!line) {
+				error = -ENOMEM;
+				goto err;
+			}
+			config_group_init_type_name(&line->group, name,
+						    &gpio_aggr_line_type);
+			error = configfs_register_group(&aggr->group,
+							&line->group);
+			if (error)
+				goto err;
+			scoped_guard(mutex, &aggr->lock)
+				aggr_line_add(aggr, line);
+
 			error = aggr_add_gpio(aggr, key, i, &n);
 			if (error)
-				return error;
+				goto err;
 		}
 
 		args = next_arg(args, &key, &p);
@@ -1038,15 +1121,20 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 
 	if (!n) {
 		pr_err("No GPIOs specified\n");
-		return -EINVAL;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	aggr_free_lines(aggr);
+	return error;
 }
 
 static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 				size_t count)
 {
+	char name[CONFIGFS_ITEM_NAME_LEN];
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
 	int res;
@@ -1075,10 +1163,24 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 		goto free_table;
 	}
 
-	res = aggr_parse(aggr);
+	scnprintf(name, sizeof(name), "%s.%d", AGGREGATOR_LEGACY_PREFIX, aggr->id);
+	config_group_init_type_name(&aggr->group, name, &gpio_aggr_device_type);
+
+	/*
+	 * Since the device created by sysfs might be toggled via configfs
+	 * 'live' attribute later, this initialization is needed.
+	 */
+	dev_sync_probe_init(&aggr->probe_data);
+
+	/* Expose to configfs */
+	res = configfs_register_group(&gpio_aggr_subsys.su_group, &aggr->group);
 	if (res)
 		goto free_dev_id;
 
+	res = aggr_parse(aggr);
+	if (res)
+		goto unregister_group;
+
 	gpiod_add_lookup_table(aggr->lookups);
 
 	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
@@ -1093,6 +1195,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 remove_table:
 	gpiod_remove_lookup_table(aggr->lookups);
+unregister_group:
+	configfs_unregister_group(&aggr->group);
 free_dev_id:
 	kfree(aggr->lookups->dev_id);
 free_table:
@@ -1108,7 +1212,12 @@ static DRIVER_ATTR_WO(new_device);
 
 static void gpio_aggregator_free(struct gpio_aggregator *aggr)
 {
-	aggr_deactivate(aggr);
+	scoped_guard(mutex, &aggr->lock) {
+		if (aggr_is_activating(aggr) || aggr_is_active(aggr))
+			aggr_deactivate(aggr);
+	}
+	aggr_free_lines(aggr);
+	configfs_unregister_group(&aggr->group);
 	kfree(aggr);
 }
 
-- 
2.45.2



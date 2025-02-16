Return-Path: <linux-kernel+bounces-516593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B2A37460
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AB33B0CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AD194C78;
	Sun, 16 Feb 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mA/ta2PS"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5F7194A59
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710743; cv=none; b=MB4Oz6KVNmMFk2+W1MCF6DdcxEWCS3s597GXLGSo8ANkVUFoOMmzs9dm0YuxVpq/MPHIojTmGlT4OIpn8yUB9qO7DPl8qaop1/10emijMV9eBwoEumXV1X0x7jZbX8JSUHynYp1NpQdgn1M0UiFLHLnksa5+sDjsyahpbjFhx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710743; c=relaxed/simple;
	bh=lWi8cSb8BfWbLOPOp2GNgU6ysUye4CsGO9grvCFpPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2Ac7m25FtJst0IabAlGjk0DzWgjppKRpkYbp4sDVAM1enDJBUEz+T9SPJpQLV2FsH1LR3qDwnR556Ba5/FbwEX0NTjKSOsikvLn27wuWAaOehLnpMe8bA4UYu++CfInFzc05Wh2+c7S8H4dAePMtO+dyrDCeGZqHXipI2PdSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mA/ta2PS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A91443F2A0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710739;
	bh=xsxLQ8/cIyaXlfRbTYcIHh/jf9fjXDEfeDZdjuEqzxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=mA/ta2PSRlwWyq1ft9QqJSaBgE1zsXxnRDBycmyfkZKa4IEQlzoF144iz0J5z7AnM
	 xsZfWAR+U4Iwdu91prAlwpsnIOKxIbHq6iXF0UJMfnRB2Y8cKQJpk8pcRVvQlzu6eQ
	 OPxKmdRIriBGiTAUpuP3zmI8U/AH+O36+3lRrOty9uoK8zjmMdqazTUaheiUYiRV9f
	 kH7sg1Y6qzSp3FR/YzNz0sLPiFGU37+4jTPgzfl1JCIpjWu/Q0yEp0HxIM1F2oqDFi
	 Kw1IwlvNVDyQYH5oxz18bxXihI709RNmyYNSStmVM2DEkAP7cxcgVx3uYLjlNz82ef
	 PrBG4yIuLDdjw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220cd43c75aso123892115ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710738; x=1740315538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsxLQ8/cIyaXlfRbTYcIHh/jf9fjXDEfeDZdjuEqzxg=;
        b=pfP6OJMUimET2lcrE3vGrPYrz1Wqa7GOAi0BabiWgi0O+eq3qKYQeBuGuNfXeh+UFz
         4WfnzqYmbFL52k3N9UXuN/38miIn/vTAE5PyW76RMCjaL29YyCNIuAp1WFF9GICFfxg4
         rBq0mw2DpSGbwBW8etzZj1LEpCqLxYu7UH8ge+RRllx09HJS1J+TUe75B0yovUOC0dUH
         xEB+xYbjlvKYpbQtFVjjSjawp2NvnxMNNdXnZyy/1ypopTKlM8wsifOqUUar/jafFKet
         lGR0r+9kxxA90tb+Df8D3NDIK+Oz3fDwbMG5Oi1zOiLmwgnLseyCFv9SsFeL1Bsn/JE9
         tFwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUGFApTsWBsWurorx3zzpU/O58gm+IIAjkellj1sT42c21fuI2JjYThPpdSyTCtakxUYSX4JzVRG/EEyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznC+P8FzEguqAPGbMskHnRhugJKjgs4v4hgvcFvDQHEGZUPFFh
	MNQxPH0QwuQyFCpRMQz9Rfvk+eBEs4NwHxeLTy2EKHwdIfv009FBCFyNgAeoY0c0ae8AwKlfdSR
	yvzgqz0CfWYm8XRjrCjMMk4CAY3vBxpZ3w8DWVEb6WsoJIpHQayeYbm5nZ9yxdFXn5RtqzIXDLI
	r0bw==
X-Gm-Gg: ASbGnct3jV4fmk4Rclvbt9G0nO0nkLr7qUJrbBt0We0SBfq6tHKJx0Z1LRTwI+pY8J8
	gGAGJ5zrzFFTsbTNyTdf4Dvmjxrm5Z5L5HY06a5jnDBh2mNO/EzuBarqoEzugLPuvsZNSwonuaP
	ujiG8bxubfkyAUadLLRrO9FJNW5PhOFCGztXVzaWyJieUaf1t4WruyhW+n0QVOqP/x5MB7rUFl5
	BoFQeHv3mgHA6w/kxO21kCuVVnPdiPQRvX1vfTbSTzjhiM4ea4aRVaZhbt9pqQ4u2tJME7YNgbf
	3Z9Hwg==
X-Received: by 2002:a05:6a20:734c:b0:1d8:a9c0:8853 with SMTP id adf61e73a8af0-1ee8cb1738fmr10303060637.23.1739710738244;
        Sun, 16 Feb 2025 04:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX3reIldeUK0by88Q0O41ffSGW5Iq7r2xShkOSx8hGvz+DJc6z8RJ94YczGts59TaJt2Tb7w==
X-Received: by 2002:a05:6a20:734c:b0:1d8:a9c0:8853 with SMTP id adf61e73a8af0-1ee8cb1738fmr10303033637.23.1739710737827;
        Sun, 16 Feb 2025 04:58:57 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:57 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] gpio: aggregator: expose aggregator created via legacy sysfs to configfs
Date: Sun, 16 Feb 2025 21:58:14 +0900
Message-ID: <20250216125816.14430-12-koichiro.den@canonical.com>
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
 drivers/gpio/gpio-aggregator.c | 117 +++++++++++++++++++++++++++++----
 1 file changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 2e993c9a7ce5..8f8793f27211 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -33,6 +33,7 @@
 #include "gpio-pseudo.h"
 
 #define AGGREGATOR_MAX_GPIOS 512
+#define AGGREGATOR_LEGACY_PREFIX "_sysfs"
 
 /*
  * GPIO Aggregator sysfs interface
@@ -131,6 +132,14 @@ static bool aggr_is_active(struct gpio_aggregator *aggr)
 	return aggr->common.pdev && platform_get_drvdata(aggr->common.pdev);
 }
 
+/* Only aggregators created via legacy sysfs can be "activating". */
+static bool aggr_is_activating(struct gpio_aggregator *aggr)
+{
+	lockdep_assert_held(&aggr->lock);
+
+	return aggr->common.pdev && !platform_get_drvdata(aggr->common.pdev);
+}
+
 static size_t aggr_count_lines(struct gpio_aggregator *aggr)
 {
 	lockdep_assert_held(&aggr->lock);
@@ -188,6 +197,18 @@ static void aggr_line_del(struct gpio_aggregator *aggr,
 	list_del(&line->entry);
 }
 
+static void aggr_free_lines(struct gpio_aggregator *aggr)
+{
+	struct gpio_aggregator_line *line, *tmp;
+
+	list_for_each_entry_safe(line, tmp, &aggr->list_head, entry) {
+		configfs_unregister_group(&line->group);
+		aggr_line_del(aggr, line);
+		kfree(line->key);
+		kfree(line);
+	}
+}
+
 
 /*
  *  GPIO Forwarder
@@ -687,7 +708,7 @@ gpio_aggr_line_key_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	kfree(line->key);
@@ -724,7 +745,7 @@ gpio_aggr_line_name_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	kfree(line->name);
@@ -772,7 +793,7 @@ gpio_aggr_line_offset_store(struct config_item *item, const char *page,
 
 	guard(mutex)(&aggr->lock);
 
-	if (aggr_is_active(aggr))
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
 		return -EBUSY;
 
 	line->offset = offset;
@@ -831,11 +852,12 @@ gpio_aggr_device_live_store(struct config_item *item, const char *page,
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
@@ -847,7 +869,7 @@ gpio_aggr_device_live_store(struct config_item *item, const char *page,
 	 * Undepend is required only if device disablement (live == 0)
 	 * succeeds or if device enablement (live == 1) fails.
 	 */
-	if (live == !!ret)
+	if (live == !!ret && !aggr->init_via_sysfs)
 		aggr_lockup_configfs(aggr, false);
 
 	module_put(THIS_MODULE);
@@ -893,7 +915,7 @@ static void gpio_aggr_device_release(struct config_item *item)
 	guard(mutex)(&aggr->lock);
 
 	/*
-	 * If the aggregator is active, this code wouldn't be reached,
+	 * At this point, aggr is neither active nor activating,
 	 * so calling aggr_deactivate() is always unnecessary.
 	 */
 	aggr_free(aggr);
@@ -915,6 +937,15 @@ gpio_aggr_device_make_group(struct config_group *group, const char *name)
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
@@ -952,6 +983,14 @@ gpio_aggr_make_group(struct config_group *group, const char *name)
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
@@ -988,6 +1027,8 @@ static struct configfs_subsystem gpio_aggr_subsys = {
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
 	char *args = skip_spaces(aggr->args);
+	struct gpio_aggregator_line *line;
+	char name[CONFIGFS_ITEM_NAME_LEN];
 	char *key, *offsets, *p;
 	unsigned int i, n = 0;
 	int error = 0;
@@ -999,14 +1040,29 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 
 	args = next_arg(args, &key, &p);
 	while (*args) {
+		scnprintf(name, sizeof(name), "line%u", n);
+
 		args = next_arg(args, &offsets, &p);
 
 		p = get_options(offsets, 0, &error);
 		if (error == 0 || *p) {
 			/* Named GPIO line */
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
+			aggr_line_add(aggr, line);
+
 			error = aggr_add_gpio(aggr, key, U16_MAX, &n);
 			if (error)
-				return error;
+				goto err;
 
 			key = offsets;
 			continue;
@@ -1020,9 +1076,22 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
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
+			aggr_line_add(aggr, line);
+
 			error = aggr_add_gpio(aggr, key, i, &n);
 			if (error)
-				return error;
+				goto err;
 		}
 
 		args = next_arg(args, &key, &p);
@@ -1030,15 +1099,20 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 
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
@@ -1067,10 +1141,24 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
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
+	pseudo_gpio_init(&aggr->common);
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
@@ -1085,6 +1173,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 remove_table:
 	gpiod_remove_lookup_table(aggr->lookups);
+unregister_group:
+	configfs_unregister_group(&aggr->group);
 free_dev_id:
 	kfree(aggr->lookups->dev_id);
 free_table:
@@ -1100,7 +1190,10 @@ static DRIVER_ATTR_WO(new_device);
 
 static void gpio_aggregator_free(struct gpio_aggregator *aggr)
 {
-	aggr_deactivate(aggr);
+	if (aggr_is_activating(aggr) || aggr_is_active(aggr))
+		aggr_deactivate(aggr);
+	aggr_free_lines(aggr);
+	configfs_unregister_group(&aggr->group);
 	kfree(aggr);
 }
 
-- 
2.45.2



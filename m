Return-Path: <linux-kernel+bounces-333882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAD97CF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378661F23081
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B11B2EC1;
	Thu, 19 Sep 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="datHRy11"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB179D2;
	Thu, 19 Sep 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726788496; cv=none; b=giKlDZ2SeSdHXYdqqxFXmRwfxHGpGleFfQzCEr4NwwU7gQRbKSvmmK7K9/OmZBjm/XXNUgVe/6km81FMGShSj/NN/aT1mKQG0R0PShf7CqLlBOg4brZxQhcvsrEpRwPtU00hd34eBQMVJuVQMto/XIeuuE1X9ocn7a2gJOcJFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726788496; c=relaxed/simple;
	bh=SbYRn+1SOvkifxhYhZLFaO/OR1bLhdC+MwYBznDkotk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNUmZWNp2B1iw8uDLSN//SlkaVTxhAtZ/y0w3r2WwmZR06MUODifEi8qq8nj1rxDNlg5EuX79s3ivW2oZ3rYaIjKRuJfxr7JDISADV5FE9JGlghgL6zAcYyYXeiFmJ2ui1SMXzk6SZhK0KAuqHnqFz9za9z+P+MTpYdtxkfR4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=datHRy11; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=oTOh19krILulKkG9jqW7QDHJep+Klu2h7yyfBqgsdO0=; b=datHRy11REAvGdl/
	xYgPhXvIYPJ6d3EhEpDrJ9Itm4VYrebp3qTadgr08IGlJ8SRToFcdon6ZwL471gPFvl8I5qMw2ZOO
	2p01GJ9rVgLl23BRyWnropm/iBN2L4/hKXyprSqxIdU7IBagD+lNzwp6nOGISkTryoNlGVS+KcCiK
	PZlMOleYDjabgz8U2eTgNc4rthHg2LaJr3K2nJhdqj/M/RenDd/EUdecTRhJFqK/3bj33DWnde0rr
	200MD/+34dwHyViCfryVlFQIS/mrRYq80+V4ZeSVghrzbrjOU29yXwQYXVabnTMPZxEJTkpLryBCe
	/U3Ixwg1BVqxYm0W0A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1srQZ5-006U9f-0L;
	Thu, 19 Sep 2024 23:27:59 +0000
From: linux@treblig.org
To: lee@kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	hdegoede@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] backlight: Remove notifier
Date: Fri, 20 Sep 2024 00:27:58 +0100
Message-ID: <20240919232758.639925-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

backlight_register_notifier and backlight_unregister_notifier have
been unused since
  commit 6cb634d0dc85 ("ACPI: video: Remove code to unregister acpi_video
backlight when a native backlight registers")

With those not being called, it means that the backlight_notifier
list is always empty.

Remove the functions, the list itself and the enum used in the
notifications.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/video/backlight/backlight.c | 42 -----------------------------
 include/linux/backlight.h           | 20 --------------
 2 files changed, 62 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index a82934694d05..f699e5827ccb 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -65,7 +65,6 @@
 
 static struct list_head backlight_dev_list;
 static struct mutex backlight_dev_list_mutex;
-static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
 	[BACKLIGHT_RAW] = "raw",
@@ -467,9 +466,6 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
-	blocking_notifier_call_chain(&backlight_notifier,
-				     BACKLIGHT_REGISTERED, new_bd);
-
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
@@ -539,9 +535,6 @@ void backlight_device_unregister(struct backlight_device *bd)
 	mutex_unlock(&pmac_backlight_mutex);
 #endif
 
-	blocking_notifier_call_chain(&backlight_notifier,
-				     BACKLIGHT_UNREGISTERED, bd);
-
 	mutex_lock(&bd->ops_lock);
 	bd->ops = NULL;
 	mutex_unlock(&bd->ops_lock);
@@ -566,40 +559,6 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
-/**
- * backlight_register_notifier - get notified of backlight (un)registration
- * @nb: notifier block with the notifier to call on backlight (un)registration
- *
- * Register a notifier to get notified when backlight devices get registered
- * or unregistered.
- *
- * RETURNS:
- *
- * 0 on success, otherwise a negative error code
- */
-int backlight_register_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&backlight_notifier, nb);
-}
-EXPORT_SYMBOL(backlight_register_notifier);
-
-/**
- * backlight_unregister_notifier - unregister a backlight notifier
- * @nb: notifier block to unregister
- *
- * Register a notifier to get notified when backlight devices get registered
- * or unregistered.
- *
- * RETURNS:
- *
- * 0 on success, otherwise a negative error code
- */
-int backlight_unregister_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
-}
-EXPORT_SYMBOL(backlight_unregister_notifier);
-
 /**
  * devm_backlight_device_register - register a new backlight device
  * @dev: the device to register
@@ -767,7 +726,6 @@ static int __init backlight_class_init(void)
 
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
-	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
 	return 0;
 }
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index ea9c1bc8148e..f5652e5a9060 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -66,24 +66,6 @@ enum backlight_type {
 	BACKLIGHT_TYPE_MAX,
 };
 
-/**
- * enum backlight_notification - the type of notification
- *
- * The notifications that is used for notification sent to the receiver
- * that registered notifications using backlight_register_notifier().
- */
-enum backlight_notification {
-	/**
-	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
-	 */
-	BACKLIGHT_REGISTERED,
-
-	/**
-	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
-	 */
-	BACKLIGHT_UNREGISTERED,
-};
-
 /** enum backlight_scale - the type of scale used for brightness values
  *
  * The type of scale used for brightness values.
@@ -421,8 +403,6 @@ void devm_backlight_device_unregister(struct device *dev,
 				      struct backlight_device *bd);
 void backlight_force_update(struct backlight_device *bd,
 			    enum backlight_update_reason reason);
-int backlight_register_notifier(struct notifier_block *nb);
-int backlight_unregister_notifier(struct notifier_block *nb);
 struct backlight_device *backlight_device_get_by_name(const char *name);
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
 int backlight_device_set_brightness(struct backlight_device *bd,
-- 
2.46.1



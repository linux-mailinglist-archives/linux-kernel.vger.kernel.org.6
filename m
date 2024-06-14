Return-Path: <linux-kernel+bounces-214868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB05908B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD28282423
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EE1991D4;
	Fri, 14 Jun 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEU3u4gF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033612F5A0;
	Fri, 14 Jun 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367124; cv=none; b=jLvOHTrX37occAOpneubj8D76Kmlb8n4BPIvgaDPKHjTIUksELyc7uKQ0pZNwylz1e0IwfNrpXSZAzOfc3khoDJx41CM/D6la8D3hETRCBsKybcjcPNDcf49Olbv5KFS7VHjabdpJCgHT3STi+wi2DHTdffsZwJ93WGwZmH6xF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367124; c=relaxed/simple;
	bh=Gd5g18TGH/pZPAqdChNZNVOCXhmUTuWTaAHU0iifcGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1l7k6HGA2l2DFYDsPI7jos4x+NvBlGjCmnOnECGBjQVCjkR4T9aqS2E71vT5t0gh20VwzWsc1YLaQNf8sLfj5EduQWHJIIdAKOZt3BqyFEcEXMvMvQIDkS7voswM0dxPaHa9X2NKgnRGX/F2Ee6Qw7F9vmQwEV0TWBHVe+U6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEU3u4gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FD2C4AF1A;
	Fri, 14 Jun 2024 12:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718367124;
	bh=Gd5g18TGH/pZPAqdChNZNVOCXhmUTuWTaAHU0iifcGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEU3u4gFTYzvx1nkI7rwYXhuRR26OyBYodsK7FKAQ+1OEvfymtgGoz0LjoKlQ7ijz
	 f9W+bsB1iw0GTzfAZxJYdJR8lpSA92uCOW6fJIU8gCywp27c2kDQ61jdSaGfwsPi66
	 dlm1yGyQ5PFZr0BA/3QaYvuWocSr9GX/ThP1xHgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Oliver Neukum <oneukum@suse.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/4] USB: make single lock for all usb dynamic id lists
Date: Fri, 14 Jun 2024 14:11:51 +0200
Message-ID: <2024061451-heftiness-relight-71b0@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061448-manly-universal-00ad@gregkh>
References: <2024061448-manly-universal-00ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 178
X-Developer-Signature: v=1; a=openpgp-sha256; l=6079; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Gd5g18TGH/pZPAqdChNZNVOCXhmUTuWTaAHU0iifcGI=; b=owGbwMvMwCRo6H6F97bub03G02pJDGk5xh1Mqz68y/q0d0/O0fr2wkuW4almK1YzbgtR8fc46 v7mzIN3HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjAR898Mc4WnLQqub7ygab8n IKhO83A1W+zNpwwLlvdGXPygw2SWJ/Vd/dGXGxeDr7G8BQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

There are a number of places where we accidentally pass in a constant
structure to later cast it off to a dynamic one, and then attempt to
grab a lock on it, which is not a good idea.  To help resolve this, move
the dynamic id lock out of the dynamic id structure for the driver and
into one single lock for all USB dynamic ids.  As this lock should never
have any real contention (it's only every accessed when a device is
added or removed, which is always serialized) there should not be any
difference except for some memory savings.

Cc: Johan Hovold <johan@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Yajun Deng <yajun.deng@linux.dev>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/common.c     |  4 ++++
 drivers/usb/core/driver.c       | 15 +++++----------
 drivers/usb/serial/bus.c        |  4 +---
 drivers/usb/serial/usb-serial.c |  4 +---
 include/linux/usb.h             |  2 +-
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index b84efae26e15..f9f47c1143bf 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -417,9 +417,13 @@ EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 struct dentry *usb_debug_root;
 EXPORT_SYMBOL_GPL(usb_debug_root);
 
+spinlock_t usb_dynids_lock;
+EXPORT_SYMBOL_GPL(usb_dynids_lock);
+
 static int __init usb_common_init(void)
 {
 	usb_debug_root = debugfs_create_dir("usb", NULL);
+	spin_lock_init(&usb_dynids_lock);
 	ledtrig_usb_init();
 	return 0;
 }
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index d0fb2f315d65..3f69b32222f3 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -95,9 +95,9 @@ ssize_t usb_store_new_id(struct usb_dynids *dynids,
 		}
 	}
 
-	spin_lock(&dynids->lock);
+	spin_lock(&usb_dynids_lock);
 	list_add_tail(&dynid->node, &dynids->list);
-	spin_unlock(&dynids->lock);
+	spin_unlock(&usb_dynids_lock);
 
 	retval = driver_attach(driver);
 
@@ -160,7 +160,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	if (fields < 2)
 		return -EINVAL;
 
-	spin_lock(&usb_driver->dynids.lock);
+	guard(spinlock)(&usb_dynids_lock);
 	list_for_each_entry_safe(dynid, n, &usb_driver->dynids.list, node) {
 		struct usb_device_id *id = &dynid->id;
 
@@ -171,7 +171,6 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 			break;
 		}
 	}
-	spin_unlock(&usb_driver->dynids.lock);
 	return count;
 }
 
@@ -220,12 +219,11 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
 {
 	struct usb_dynid *dynid, *n;
 
-	spin_lock(&usb_drv->dynids.lock);
+	guard(spinlock)(&usb_dynids_lock);
 	list_for_each_entry_safe(dynid, n, &usb_drv->dynids.list, node) {
 		list_del(&dynid->node);
 		kfree(dynid);
 	}
-	spin_unlock(&usb_drv->dynids.lock);
 }
 
 static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
@@ -233,14 +231,12 @@ static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *in
 {
 	struct usb_dynid *dynid;
 
-	spin_lock(&drv->dynids.lock);
+	guard(spinlock)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
-			spin_unlock(&drv->dynids.lock);
 			return &dynid->id;
 		}
 	}
-	spin_unlock(&drv->dynids.lock);
 	return NULL;
 }
 
@@ -1062,7 +1058,6 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	new_driver->driver.owner = owner;
 	new_driver->driver.mod_name = mod_name;
 	new_driver->driver.dev_groups = new_driver->dev_groups;
-	spin_lock_init(&new_driver->dynids.lock);
 	INIT_LIST_HEAD(&new_driver->dynids.list);
 
 	retval = driver_register(&new_driver->driver);
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index d200e2c29a8f..c1af1eb6d571 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -136,12 +136,11 @@ static void free_dynids(struct usb_serial_driver *drv)
 {
 	struct usb_dynid *dynid, *n;
 
-	spin_lock(&drv->dynids.lock);
+	guard(spinlock)(&usb_dynids_lock);
 	list_for_each_entry_safe(dynid, n, &drv->dynids.list, node) {
 		list_del(&dynid->node);
 		kfree(dynid);
 	}
-	spin_unlock(&drv->dynids.lock);
 }
 
 const struct bus_type usb_serial_bus_type = {
@@ -157,7 +156,6 @@ int usb_serial_bus_register(struct usb_serial_driver *driver)
 	int retval;
 
 	driver->driver.bus = &usb_serial_bus_type;
-	spin_lock_init(&driver->dynids.lock);
 	INIT_LIST_HEAD(&driver->dynids.list);
 
 	retval = driver_register(&driver->driver);
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f1e91eb7f8a4..ad947efcd80b 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -706,14 +706,12 @@ static const struct usb_device_id *match_dynamic_id(struct usb_interface *intf,
 {
 	struct usb_dynid *dynid;
 
-	spin_lock(&drv->dynids.lock);
+	guard(spinlock)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
-			spin_unlock(&drv->dynids.lock);
 			return &dynid->id;
 		}
 	}
-	spin_unlock(&drv->dynids.lock);
 	return NULL;
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 5c619e8240fe..10fc4db764b5 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1121,8 +1121,8 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 /* ----------------------------------------------------------------------- */
 
 /* Stuff for dynamic usb ids */
+extern spinlock_t usb_dynids_lock;
 struct usb_dynids {
-	spinlock_t lock;
 	struct list_head list;
 };
 
-- 
2.45.2



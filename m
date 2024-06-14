Return-Path: <linux-kernel+bounces-214869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39F8908B50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5567F2827F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E7199E9B;
	Fri, 14 Jun 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQ//u1od"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168C19925F;
	Fri, 14 Jun 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367127; cv=none; b=Suo+erICeG5zdVjm0s24C5WsHtv435ikpNMHFdpNT67r/pVKVYHpiykLb/4WpjnW2XNvybQfMrPK2ifOGz/uWTibkwiEHIk6Fryv8VU5+RFMRMxC3Nbohadoad1B+1dZmAyeSjsaM8CxA3i6OURg+KLzEEOcgkDWQPHhZDYCAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367127; c=relaxed/simple;
	bh=VGLDStxXgNJ8tAvYrgAQKHvsoUpv/2an251VKRTnW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKUdvkXqI+z5eeM+JZFjbPWa+XshBvr8LoTu/XoUKPdJqSKNMQM/i9SeGlZfnC3Is47/M8WT4adoHe+ppQEszrx3x3UW9Cic4zJVngmO1YP0JaYhwztNtIF+9Joqbp/ho+RZJD7aNVgy8oYPGselSuMgivJFQ6awVZjwzzA1yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQ//u1od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1340C3277B;
	Fri, 14 Jun 2024 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718367127;
	bh=VGLDStxXgNJ8tAvYrgAQKHvsoUpv/2an251VKRTnW6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQ//u1odf19te9qFRaRBV2s5TvEiSXIe/WfbSiULEfhnYRZKjthE76V6LChi3xZZ9
	 NQfIa+8sI4WXLHPZOiE8u5SuMVg2UutUO6/T8dMPdtz5avWACW5hBBpWJeaHMENKF0
	 ZWAw2K1j4i30TzdklV+jF4tFW/j/EbLEawk2srSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: [PATCH 4/4] USB: move dynamic ids out of usb driver structures
Date: Fri, 14 Jun 2024 14:11:52 +0200
Message-ID: <2024061452-science-clinking-3b92@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061448-manly-universal-00ad@gregkh>
References: <2024061448-manly-universal-00ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 516
X-Developer-Signature: v=1; a=openpgp-sha256; l=16335; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=VGLDStxXgNJ8tAvYrgAQKHvsoUpv/2an251VKRTnW6c=; b=owGbwMvMwCRo6H6F97bub03G02pJDGk5xh2Krr/zTqoKLd5YOiGez3Lm+cWe22542jyr3Wnx/ GHsbn/TjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIzhkMC7Z4PAziLOX7uP6T 5cmFeqp+m3d9LmWY7+hWeq5ZMf9n1CyHBxfFLDe8ONAVDQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The usb driver structures contain a dynamic id structure that is written
to, preventing them from being able to be constant structures.  To help
resolve this, move the dynamic id structure out of the driver and into a
separate local list, indexed off of the driver * so that all USB
subsystems can use it (i.e. usb-serial).

Overall it moves some duplicated code out of the usb-serial core as it's
already in the usb core, and now the usb dynamic id structures can be
private entirely to the usb core itself.

Cc: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Yajun Deng <yajun.deng@linux.dev>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/common/common.c     |   4 -
 drivers/usb/core/driver.c       | 141 ++++++++++++++++++++++++--------
 drivers/usb/core/usb.c          |   1 +
 drivers/usb/core/usb.h          |   1 +
 drivers/usb/serial/bus.c        |  24 +-----
 drivers/usb/serial/usb-serial.c |  16 +---
 include/linux/usb.h             |  24 ++----
 include/linux/usb/serial.h      |   1 -
 8 files changed, 121 insertions(+), 91 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index f9f47c1143bf..b84efae26e15 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -417,13 +417,9 @@ EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 struct dentry *usb_debug_root;
 EXPORT_SYMBOL_GPL(usb_debug_root);
 
-spinlock_t usb_dynids_lock;
-EXPORT_SYMBOL_GPL(usb_dynids_lock);
-
 static int __init usb_common_init(void)
 {
 	usb_debug_root = debugfs_create_dir("usb", NULL);
-	spin_lock_init(&usb_dynids_lock);
 	ledtrig_usb_init();
 	return 0;
 }
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 3f69b32222f3..8bba102de39f 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -34,17 +34,76 @@
 
 #include "usb.h"
 
+static struct list_head usb_dynids;
+static spinlock_t usb_dynids_lock;
+
+struct usb_dynids {
+	struct list_head node;
+	const struct device_driver *driver;
+	struct list_head list;
+};
+
+struct usb_dynid {
+	struct list_head node;
+	struct usb_device_id id;
+};
+
+void usb_dynids_init(void)
+{
+	spin_lock_init(&usb_dynids_lock);
+	INIT_LIST_HEAD(&usb_dynids);
+}
+
+static struct usb_dynids *usb_find_dynids(const struct device_driver *driver)
+{
+	struct usb_dynids *u;
+
+	/* Loop through the list to find if this driver has an id list already */
+	guard(spinlock)(&usb_dynids_lock);
+	list_for_each_entry(u, &usb_dynids, node) {
+		if (u->driver == driver)
+			return u;
+	}
+	return NULL;
+}
+
+static int store_id(const struct device_driver *driver, const struct usb_device_id *id)
+{
+	struct usb_dynids *u;
+	struct usb_dynid *usb_dynid;
+
+	u = usb_find_dynids(driver);
+	if (!u) {
+		/* This driver has not stored any ids yet, so make a new entry for it */
+		u = kmalloc(sizeof(*u), GFP_KERNEL);
+		if (!u)
+			return -ENOMEM;
+		u->driver = driver;
+		INIT_LIST_HEAD(&u->list);
+		guard(spinlock)(&usb_dynids_lock);
+		list_add_tail(&u->node, &usb_dynids);
+	}
+
+	/* Allocate a new entry and add it to the list of driver ids for this driver */
+	usb_dynid = kmalloc(sizeof(*usb_dynid), GFP_KERNEL);
+	if (!usb_dynid)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&usb_dynid->node);
+	memcpy(&usb_dynid->id, id, sizeof(*id));
+	list_add_tail(&usb_dynid->node, &u->list);
+	return 0;
+}
 
 /*
  * Adds a new dynamic USBdevice ID to this driver,
  * and cause the driver to probe for all devices again.
  */
-ssize_t usb_store_new_id(struct usb_dynids *dynids,
+ssize_t usb_store_new_id(struct device_driver *driver,
 			 const struct usb_device_id *id_table,
-			 struct device_driver *driver,
 			 const char *buf, size_t count)
 {
-	struct usb_dynid *dynid;
+	struct usb_device_id new_id = {};
 	u32 idVendor = 0;
 	u32 idProduct = 0;
 	unsigned int bInterfaceClass = 0;
@@ -57,22 +116,17 @@ ssize_t usb_store_new_id(struct usb_dynids *dynids,
 	if (fields < 2)
 		return -EINVAL;
 
-	dynid = kzalloc(sizeof(*dynid), GFP_KERNEL);
-	if (!dynid)
-		return -ENOMEM;
-
-	INIT_LIST_HEAD(&dynid->node);
-	dynid->id.idVendor = idVendor;
-	dynid->id.idProduct = idProduct;
-	dynid->id.match_flags = USB_DEVICE_ID_MATCH_DEVICE;
+	new_id.idVendor = idVendor;
+	new_id.idProduct = idProduct;
+	new_id.match_flags = USB_DEVICE_ID_MATCH_DEVICE;
 	if (fields > 2 && bInterfaceClass) {
 		if (bInterfaceClass > 255) {
 			retval = -EINVAL;
 			goto fail;
 		}
 
-		dynid->id.bInterfaceClass = (u8)bInterfaceClass;
-		dynid->id.match_flags |= USB_DEVICE_ID_MATCH_INT_CLASS;
+		new_id.bInterfaceClass = (u8)bInterfaceClass;
+		new_id.match_flags |= USB_DEVICE_ID_MATCH_INT_CLASS;
 	}
 
 	if (fields > 4) {
@@ -88,16 +142,16 @@ ssize_t usb_store_new_id(struct usb_dynids *dynids,
 				break;
 
 		if (id->match_flags) {
-			dynid->id.driver_info = id->driver_info;
+			new_id.driver_info = id->driver_info;
 		} else {
 			retval = -ENODEV;
 			goto fail;
 		}
 	}
 
-	spin_lock(&usb_dynids_lock);
-	list_add_tail(&dynid->node, &dynids->list);
-	spin_unlock(&usb_dynids_lock);
+	retval = store_id(driver, &new_id);
+	if (retval)
+		return retval;
 
 	retval = driver_attach(driver);
 
@@ -106,16 +160,20 @@ ssize_t usb_store_new_id(struct usb_dynids *dynids,
 	return count;
 
 fail:
-	kfree(dynid);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(usb_store_new_id);
 
-ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf)
+ssize_t usb_show_dynids(const struct device_driver *driver, char *buf)
 {
+	struct usb_dynids *dynids;
 	struct usb_dynid *dynid;
 	size_t count = 0;
 
+	dynids = usb_find_dynids(driver);
+	if (!dynids)
+		return 0;
+
 	list_for_each_entry(dynid, &dynids->list, node)
 		if (dynid->id.bInterfaceClass != 0)
 			count += scnprintf(&buf[count], PAGE_SIZE - count, "%04x %04x %02x\n",
@@ -130,9 +188,7 @@ EXPORT_SYMBOL_GPL(usb_show_dynids);
 
 static ssize_t new_id_show(struct device_driver *driver, char *buf)
 {
-	struct usb_driver *usb_drv = to_usb_driver(driver);
-
-	return usb_show_dynids(&usb_drv->dynids, buf);
+	return usb_show_dynids(driver, buf);
 }
 
 static ssize_t new_id_store(struct device_driver *driver,
@@ -140,7 +196,7 @@ static ssize_t new_id_store(struct device_driver *driver,
 {
 	struct usb_driver *usb_drv = to_usb_driver(driver);
 
-	return usb_store_new_id(&usb_drv->dynids, usb_drv->id_table, driver, buf, count);
+	return usb_store_new_id(driver, usb_drv->id_table, buf, count);
 }
 static DRIVER_ATTR_RW(new_id);
 
@@ -150,8 +206,8 @@ static DRIVER_ATTR_RW(new_id);
 static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 			       size_t count)
 {
+	struct usb_dynids *dynids;
 	struct usb_dynid *dynid, *n;
-	struct usb_driver *usb_driver = to_usb_driver(driver);
 	u32 idVendor;
 	u32 idProduct;
 	int fields;
@@ -160,8 +216,12 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	if (fields < 2)
 		return -EINVAL;
 
+	dynids = usb_find_dynids(driver);
+	if (!dynids)
+		return count;
+
 	guard(spinlock)(&usb_dynids_lock);
-	list_for_each_entry_safe(dynid, n, &usb_driver->dynids.list, node) {
+	list_for_each_entry_safe(dynid, n, &dynids->list, node) {
 		struct usb_device_id *id = &dynid->id;
 
 		if ((id->idVendor == idVendor) &&
@@ -215,30 +275,44 @@ static void usb_remove_newid_files(struct usb_driver *usb_drv)
 	}
 }
 
-static void usb_free_dynids(struct usb_driver *usb_drv)
+void usb_free_dynids(const struct device_driver *drv)
 {
+	struct usb_dynids *dynids;
 	struct usb_dynid *dynid, *n;
 
+	dynids = usb_find_dynids(drv);
+	if (!dynids)
+		return;
+
 	guard(spinlock)(&usb_dynids_lock);
-	list_for_each_entry_safe(dynid, n, &usb_drv->dynids.list, node) {
+	list_for_each_entry_safe(dynid, n, &dynids->list, node) {
 		list_del(&dynid->node);
 		kfree(dynid);
 	}
+	list_del(&dynids->node);
+	kfree(dynids);
 }
+EXPORT_SYMBOL_GPL(usb_free_dynids);
 
-static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
-							const struct usb_driver *drv)
+const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
+						 const struct device_driver *driver)
 {
+	struct usb_dynids *dynids;
 	struct usb_dynid *dynid;
 
+	dynids = usb_find_dynids(driver);
+	if (!dynids)
+		return NULL;
+
 	guard(spinlock)(&usb_dynids_lock);
-	list_for_each_entry(dynid, &drv->dynids.list, node) {
+	list_for_each_entry(dynid, &dynids->list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
 			return &dynid->id;
 		}
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(usb_match_dynamic_id);
 
 
 /* called from driver core with dev locked */
@@ -339,7 +413,7 @@ static int usb_probe_interface(struct device *dev)
 		return error;
 	}
 
-	id = usb_match_dynamic_id(intf, driver);
+	id = usb_match_dynamic_id(intf, &driver->driver);
 	if (!id)
 		id = usb_match_id(intf, driver->id_table);
 	if (!id)
@@ -890,7 +964,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 		if (id)
 			return 1;
 
-		id = usb_match_dynamic_id(intf, usb_drv);
+		id = usb_match_dynamic_id(intf, &usb_drv->driver);
 		if (id)
 			return 1;
 	}
@@ -1058,7 +1132,6 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	new_driver->driver.owner = owner;
 	new_driver->driver.mod_name = mod_name;
 	new_driver->driver.dev_groups = new_driver->dev_groups;
-	INIT_LIST_HEAD(&new_driver->dynids.list);
 
 	retval = driver_register(&new_driver->driver);
 	if (retval)
@@ -1100,8 +1173,8 @@ void usb_deregister(struct usb_driver *driver)
 			usbcore_name, driver->name);
 
 	usb_remove_newid_files(driver);
+	usb_free_dynids(&driver->driver);
 	driver_unregister(&driver->driver);
-	usb_free_dynids(driver);
 }
 EXPORT_SYMBOL_GPL(usb_deregister);
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index a0c432b14b20..6261696f40f0 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1078,6 +1078,7 @@ static int __init usb_init(void)
 	usb_init_pool_max();
 
 	usb_debugfs_init();
+	usb_dynids_init();
 
 	usb_acpi_register();
 	retval = bus_register(&usb_bus_type);
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index a9b37aeb515b..b904d54133ea 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -89,6 +89,7 @@ extern int usb_major_init(void);
 extern void usb_major_cleanup(void);
 extern int usb_device_supports_lpm(struct usb_device *udev);
 extern int usb_port_disable(struct usb_device *udev);
+void usb_dynids_init(void);
 
 #ifdef	CONFIG_PM
 
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index c1af1eb6d571..0d45e8122068 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -107,22 +107,18 @@ static ssize_t new_id_store(struct device_driver *driver,
 			    const char *buf, size_t count)
 {
 	struct usb_serial_driver *usb_drv = to_usb_serial_driver(driver);
-	ssize_t retval = usb_store_new_id(&usb_drv->dynids, usb_drv->id_table,
-					 driver, buf, count);
+	ssize_t retval = usb_store_new_id(driver, usb_drv->id_table, buf, count);
 
 	if (retval >= 0 && usb_drv->usb_driver != NULL)
-		retval = usb_store_new_id(&usb_drv->usb_driver->dynids,
+		retval = usb_store_new_id(&usb_drv->usb_driver->driver,
 					  usb_drv->usb_driver->id_table,
-					  &usb_drv->usb_driver->driver,
 					  buf, count);
 	return retval;
 }
 
 static ssize_t new_id_show(struct device_driver *driver, char *buf)
 {
-	struct usb_serial_driver *usb_drv = to_usb_serial_driver(driver);
-
-	return usb_show_dynids(&usb_drv->dynids, buf);
+	return usb_show_dynids(driver, buf);
 }
 static DRIVER_ATTR_RW(new_id);
 
@@ -132,17 +128,6 @@ static struct attribute *usb_serial_drv_attrs[] = {
 };
 ATTRIBUTE_GROUPS(usb_serial_drv);
 
-static void free_dynids(struct usb_serial_driver *drv)
-{
-	struct usb_dynid *dynid, *n;
-
-	guard(spinlock)(&usb_dynids_lock);
-	list_for_each_entry_safe(dynid, n, &drv->dynids.list, node) {
-		list_del(&dynid->node);
-		kfree(dynid);
-	}
-}
-
 const struct bus_type usb_serial_bus_type = {
 	.name =		"usb-serial",
 	.match =	usb_serial_device_match,
@@ -156,7 +141,6 @@ int usb_serial_bus_register(struct usb_serial_driver *driver)
 	int retval;
 
 	driver->driver.bus = &usb_serial_bus_type;
-	INIT_LIST_HEAD(&driver->dynids.list);
 
 	retval = driver_register(&driver->driver);
 
@@ -165,7 +149,7 @@ int usb_serial_bus_register(struct usb_serial_driver *driver)
 
 void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 {
-	free_dynids(driver);
+	usb_free_dynids(&driver->driver);
 	driver_unregister(&driver->driver);
 }
 
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index ad947efcd80b..c05138c190e5 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -701,20 +701,6 @@ static struct usb_serial *create_serial(struct usb_device *dev,
 	return serial;
 }
 
-static const struct usb_device_id *match_dynamic_id(struct usb_interface *intf,
-					    struct usb_serial_driver *drv)
-{
-	struct usb_dynid *dynid;
-
-	guard(spinlock)(&usb_dynids_lock);
-	list_for_each_entry(dynid, &drv->dynids.list, node) {
-		if (usb_match_one_id(intf, &dynid->id)) {
-			return &dynid->id;
-		}
-	}
-	return NULL;
-}
-
 static const struct usb_device_id *get_iface_id(struct usb_serial_driver *drv,
 						struct usb_interface *intf)
 {
@@ -725,7 +711,7 @@ static const struct usb_device_id *get_iface_id(struct usb_serial_driver *drv,
 		dev_dbg(&intf->dev, "static descriptor matches\n");
 		goto exit;
 	}
-	id = match_dynamic_id(intf, drv);
+	id = usb_match_dynamic_id(intf, &drv->driver);
 	if (id)
 		dev_dbg(&intf->dev, "dynamic descriptor matches\n");
 exit:
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 10fc4db764b5..735f947c879f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1121,22 +1121,13 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 /* ----------------------------------------------------------------------- */
 
 /* Stuff for dynamic usb ids */
-extern spinlock_t usb_dynids_lock;
-struct usb_dynids {
-	struct list_head list;
-};
-
-struct usb_dynid {
-	struct list_head node;
-	struct usb_device_id id;
-};
-
-extern ssize_t usb_store_new_id(struct usb_dynids *dynids,
-				const struct usb_device_id *id_table,
-				struct device_driver *driver,
-				const char *buf, size_t count);
-
-extern ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf);
+ssize_t usb_store_new_id(struct device_driver *driver,
+			 const struct usb_device_id *id_table,
+			 const char *buf, size_t count);
+ssize_t usb_show_dynids(const struct device_driver *driver, char *buf);
+const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
+						 const struct device_driver *driver);
+void usb_free_dynids(const struct device_driver *driver);
 
 /**
  * struct usb_driver - identifies USB interface driver to usbcore
@@ -1225,7 +1216,6 @@ struct usb_driver {
 	const struct usb_device_id *id_table;
 	const struct attribute_group **dev_groups;
 
-	struct usb_dynids dynids;
 	struct device_driver driver;
 	unsigned int no_dynamic_id:1;
 	unsigned int supports_autosuspend:1;
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1a0a4dc87980..3e8c8c1e3ac6 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -237,7 +237,6 @@ struct usb_serial_driver {
 	struct list_head	driver_list;
 	struct device_driver	driver;
 	struct usb_driver	*usb_driver;
-	struct usb_dynids	dynids;
 
 	unsigned char		num_ports;
 
-- 
2.45.2



Return-Path: <linux-kernel+bounces-407156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931DD9C697A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5063A285D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF81862AE;
	Wed, 13 Nov 2024 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQTrjumQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D02185935;
	Wed, 13 Nov 2024 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480572; cv=none; b=lJy8i7B8Z+8AjvRadfpSGrhHmvh1G491EyWcTBeCPUBsjetTDUUtvJWzNYmi7RfGSBiju5dr6ZfbNnOZLWNOB8bw7bj8eoIA1VPYY0q5jh1KKk/M0QD0f0EzAxev/tq2bpmnhKnjSOPnGtwCbHcRn7ySo7zIspWq4FDynGwEPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480572; c=relaxed/simple;
	bh=xViXkghiRQdxly3kBx7hImifuCWJT20zymJ51VbEP48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOP/zb0Jp7suV5bta7dPU4HMTzTa+mq/pCvS/vG362nR5kPuXLyD0pNYy/lUMoflC8Y2LD5G+s/eaj1o7VCRlNt25Rt2S28+k53lanAGcpG36er83hwlxqGBTrT4GEgI+fPOop08DfFXnOtJgGKFfuBhBrV+JVQdkTwco2yMC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQTrjumQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FAC4CED7;
	Wed, 13 Nov 2024 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731480572;
	bh=xViXkghiRQdxly3kBx7hImifuCWJT20zymJ51VbEP48=;
	h=From:To:Cc:Subject:Date:From;
	b=KQTrjumQVWUBEI0oPN/i0o/UKsXdTA9F+GbSdcGrrq2s/PGBIiPWwwSSp6XTVZ1zO
	 U+/Fls2hq0hpEa6ISqOrnaMZEYiV0l+15me1KoETvWg0h0+WcLvHWiPVOchmdIuNZV
	 9qWE1Vos14752Gjt0HPKtI4adf1HRMOIF4eAz0ww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Grant Grundler <grundler@chromium.org>,
	Oliver Neukum <oneukum@suse.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/2] USB: make single lock for all usb dynamic id lists
Date: Wed, 13 Nov 2024 07:49:22 +0100
Message-ID: <2024111322-kindly-finalist-d247@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 182
X-Developer-Signature: v=1; a=openpgp-sha256; l=6277; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xViXkghiRQdxly3kBx7hImifuCWJT20zymJ51VbEP48=; b=owGbwMvMwCRo6H6F97bub03G02pJDOkm3p/O/jW2ZPGQ+bInuPT90jcekRONlKZd/7FCYrVmh SaH6l2XjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIfiDDLGbLCh2B4lmft8W3 Xi3nbzPqCoj7xzBXNlnwZm2wPEuxeLBFl/68vXwdd/QA
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

Note, this just converts the existing use of the dynamic id lock to the
new static lock, there is one place that is accessing the dynamic id
list without grabbing the lock, that will be fixed up in a follow-on
change.

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
v2: - change to a mutex
    - strip out of larger series

 drivers/usb/common/common.c     |  3 +++
 drivers/usb/core/driver.c       | 15 +++++----------
 drivers/usb/serial/bus.c        |  4 +---
 drivers/usb/serial/usb-serial.c |  4 +---
 include/linux/usb.h             |  2 +-
 5 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index b7bea1015d7c..871cf199b6bf 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -415,6 +415,9 @@ EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 struct dentry *usb_debug_root;
 EXPORT_SYMBOL_GPL(usb_debug_root);
 
+DEFINE_MUTEX(usb_dynids_lock);
+EXPORT_SYMBOL_GPL(usb_dynids_lock);
+
 static int __init usb_common_init(void)
 {
 	usb_debug_root = debugfs_create_dir("usb", NULL);
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 0c3f12daac79..bc3c00580238 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -95,9 +95,9 @@ ssize_t usb_store_new_id(struct usb_dynids *dynids,
 		}
 	}
 
-	spin_lock(&dynids->lock);
+	mutex_lock(&usb_dynids_lock);
 	list_add_tail(&dynid->node, &dynids->list);
-	spin_unlock(&dynids->lock);
+	mutex_unlock(&usb_dynids_lock);
 
 	retval = driver_attach(driver);
 
@@ -160,7 +160,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	if (fields < 2)
 		return -EINVAL;
 
-	spin_lock(&usb_driver->dynids.lock);
+	guard(mutex)(&usb_dynids_lock);
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
+	guard(mutex)(&usb_dynids_lock);
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
+	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (usb_match_one_id(intf, &dynid->id)) {
-			spin_unlock(&drv->dynids.lock);
 			return &dynid->id;
 		}
 	}
-	spin_unlock(&drv->dynids.lock);
 	return NULL;
 }
 
@@ -1076,7 +1072,6 @@ int usb_register_driver(struct usb_driver *new_driver, struct module *owner,
 	new_driver->driver.owner = owner;
 	new_driver->driver.mod_name = mod_name;
 	new_driver->driver.dev_groups = new_driver->dev_groups;
-	spin_lock_init(&new_driver->dynids.lock);
 	INIT_LIST_HEAD(&new_driver->dynids.list);
 
 	retval = driver_register(&new_driver->driver);
diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index d200e2c29a8f..2fea1b1db4a2 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -136,12 +136,11 @@ static void free_dynids(struct usb_serial_driver *drv)
 {
 	struct usb_dynid *dynid, *n;
 
-	spin_lock(&drv->dynids.lock);
+	guard(mutex)(&usb_dynids_lock);
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
index df6a2ae0bf42..7266558d823a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -706,14 +706,12 @@ static const struct usb_device_id *match_dynamic_id(struct usb_interface *intf,
 {
 	struct usb_dynid *dynid;
 
-	spin_lock(&drv->dynids.lock);
+	guard(mutex)(&usb_dynids_lock);
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
index 672d8fc2abdb..b66b1af3e439 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1129,8 +1129,8 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
 /* ----------------------------------------------------------------------- */
 
 /* Stuff for dynamic usb ids */
+extern struct mutex usb_dynids_lock;
 struct usb_dynids {
-	spinlock_t lock;
 	struct list_head list;
 };
 
-- 
2.47.0



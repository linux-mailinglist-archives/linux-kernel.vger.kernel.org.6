Return-Path: <linux-kernel+bounces-210350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393AB9042AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6251C23F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9C455E5B;
	Tue, 11 Jun 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCpYBdc1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214492570
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128047; cv=none; b=hNG1MgvJWy6tzqDOKWsp9Pcas60RzMzuSKgzSL71KiSIGJ9SvlmBOK6ZV3y8i3Lr2c7rq1DFic2OGvvYOyTxHP3gUkc2nvsCcODGqCrUy+Mbp+zpTWwbf8T7egy7rTlH3TgvcKAEN7QUwS46hHKGpQ+fF0Gq1gtj3U576hJ+hOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128047; c=relaxed/simple;
	bh=t+L7NIaw/9Xcx8/x5HGjWxm6QIdJv30b+Dq/l7/04gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o+goSS/7P049e25SBp2lGDnUQDLm7xtAvZ7Ymmp0mSTHQw1nDNNireFIq+0R4Cgf4fMY/ML4Boxn2K2O7T3apZE7F5mMPlErgkMbUgGNSbXTg9gp1vjwrvaBfdacqguToIdlDG+S+mLdsJ4xKJwQjZBzJuKrTdgxtvozohzCf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCpYBdc1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718128047; x=1749664047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+L7NIaw/9Xcx8/x5HGjWxm6QIdJv30b+Dq/l7/04gI=;
  b=FCpYBdc1bmQgAu8shgLsKPqJ5WHhNRXha0PNQMNthtSVT92oqG9ei785
   FWRg9dJqXPEZoD1ITG17YtRJFTXxkJal6ynGKAbzGOpdllJ5WtuwdTIht
   OFh7Y76ljRZJPwM+0sPRJif9lKyTgweomoGswCFLmunGl17hvjrMkYoJ9
   ywhXCUjHozNTxQkuKb0VQE6pGu9V8mBt5mSh8Xhv/Y5rLNk3jFlDYKW0I
   jee3rwpdpdZbAkADXD8V71eoki+vl9k2gvdVYUTg3zOxbTyrrXZt5flxI
   0FLJPDx0Y/uw5KPbnOB8hJEZuuVHLPJS86xhZ5fM9Np9khqyEEkBNghRq
   Q==;
X-CSE-ConnectionGUID: tg4sVOIGTZ2Z4JlG+5nNJg==
X-CSE-MsgGUID: IHL950ypSPeaAdZ4HyE0pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18635924"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18635924"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:47:26 -0700
X-CSE-ConnectionGUID: QMb96u4HRByTto0MruX3uA==
X-CSE-MsgGUID: eJd8QN1lRlWs6EIrAUbaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39614171"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:47:23 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v6 1/2] devcoredump: Add dev_coredumpm_timeout()
Date: Tue, 11 Jun 2024 10:47:15 -0700
Message-ID: <20240611174716.72660-1-jose.souza@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add function to set a custom coredump timeout.

For Xe driver usage, current 5 minutes timeout may be too short for
users to search and understand what needs to be done to capture
coredump to report bugs.

We have plans to automate(distribute a udev script) it but at the end
will be up to distros and users to pack it so having a option to
increase the timeout is a safer option.

v2:
- replace dev_coredump_timeout_set() by dev_coredumpm_timeout() (Mukesh)

v3:
- make dev_coredumpm() static inline (Johannes)

v5:
- rename DEVCOREDUMP_TIMEOUT -> DEVCD_TIMEOUT to avoid redefinition
in include/net/bluetooth/coredump.h

v6:
- fix definition of dev_coredumpm_timeout() when CONFIG_DEV_COREDUMP
is disabled

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 23 ++++++++--------
 include/linux/devcoredump.h | 53 +++++++++++++++++++++++++++++--------
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 82aeb09b3d1b5..c795edad1b969 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -18,9 +18,6 @@ static struct class devcd_class;
 /* global disable flag, for security purposes */
 static bool devcd_disabled;
 
-/* if data isn't read by userspace after 5 minutes then delete it */
-#define DEVCD_TIMEOUT	(HZ * 60 * 5)
-
 struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
@@ -328,7 +325,8 @@ void dev_coredump_put(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_coredump_put);
 
 /**
- * dev_coredumpm - create device coredump with read/free methods
+ * dev_coredumpm_timeout - create device coredump with read/free methods with a
+ * custom timeout.
  * @dev: the struct device for the crashed device
  * @owner: the module that contains the read/free functions, use %THIS_MODULE
  * @data: data cookie for the @read/@free functions
@@ -336,17 +334,20 @@ EXPORT_SYMBOL_GPL(dev_coredump_put);
  * @gfp: allocation flags
  * @read: function to read from the given buffer
  * @free: function to free the given buffer
+ * @timeout: time in jiffies to remove coredump
  *
  * Creates a new device coredump for the given device. If a previous one hasn't
  * been read yet, the new coredump is discarded. The data lifetime is determined
  * by the device coredump framework and when it is no longer needed the @free
  * function will be called to free the data.
  */
-void dev_coredumpm(struct device *dev, struct module *owner,
-		   void *data, size_t datalen, gfp_t gfp,
-		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
-				   void *data, size_t datalen),
-		   void (*free)(void *data))
+void dev_coredumpm_timeout(struct device *dev, struct module *owner,
+			   void *data, size_t datalen, gfp_t gfp,
+			   ssize_t (*read)(char *buffer, loff_t offset,
+					   size_t count, void *data,
+					   size_t datalen),
+			   void (*free)(void *data),
+			   unsigned long timeout)
 {
 	static atomic_t devcd_count = ATOMIC_INIT(0);
 	struct devcd_entry *devcd;
@@ -403,7 +404,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
-	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
+	schedule_delayed_work(&devcd->del_wk, timeout);
 	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
@@ -414,7 +415,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
  free:
 	free(data);
 }
-EXPORT_SYMBOL_GPL(dev_coredumpm);
+EXPORT_SYMBOL_GPL(dev_coredumpm_timeout);
 
 /**
  * dev_coredumpsg - create device coredump that uses scatterlist as data
diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index c8f7eb6cc1915..377892604ff4f 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -12,6 +12,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
+/* if data isn't read by userspace after 5 minutes then delete it */
+#define DEVCD_TIMEOUT	(HZ * 60 * 5)
+
 /*
  * _devcd_free_sgtable - free all the memory of the given scatterlist table
  * (i.e. both pages and scatterlist instances)
@@ -50,16 +53,17 @@ static inline void _devcd_free_sgtable(struct scatterlist *table)
 	kfree(delete_iter);
 }
 
-
 #ifdef CONFIG_DEV_COREDUMP
 void dev_coredumpv(struct device *dev, void *data, size_t datalen,
 		   gfp_t gfp);
 
-void dev_coredumpm(struct device *dev, struct module *owner,
-		   void *data, size_t datalen, gfp_t gfp,
-		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
-				   void *data, size_t datalen),
-		   void (*free)(void *data));
+void dev_coredumpm_timeout(struct device *dev, struct module *owner,
+			   void *data, size_t datalen, gfp_t gfp,
+			   ssize_t (*read)(char *buffer, loff_t offset,
+					   size_t count, void *data,
+					   size_t datalen),
+			   void (*free)(void *data),
+			   unsigned long timeout);
 
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
@@ -73,11 +77,13 @@ static inline void dev_coredumpv(struct device *dev, void *data,
 }
 
 static inline void
-dev_coredumpm(struct device *dev, struct module *owner,
-	      void *data, size_t datalen, gfp_t gfp,
-	      ssize_t (*read)(char *buffer, loff_t offset, size_t count,
-			      void *data, size_t datalen),
-	      void (*free)(void *data))
+dev_coredumpm_timeout(struct device *dev, struct module *owner,
+		      void *data, size_t datalen, gfp_t gfp,
+		      ssize_t (*read)(char *buffer, loff_t offset,
+				      size_t count, void *data,
+				      size_t datalen),
+		      void (*free)(void *data),
+		      unsigned long timeout)
 {
 	free(data);
 }
@@ -92,4 +98,29 @@ static inline void dev_coredump_put(struct device *dev)
 }
 #endif /* CONFIG_DEV_COREDUMP */
 
+/**
+ * dev_coredumpm - create device coredump with read/free methods
+ * @dev: the struct device for the crashed device
+ * @owner: the module that contains the read/free functions, use %THIS_MODULE
+ * @data: data cookie for the @read/@free functions
+ * @datalen: length of the data
+ * @gfp: allocation flags
+ * @read: function to read from the given buffer
+ * @free: function to free the given buffer
+ *
+ * Creates a new device coredump for the given device. If a previous one hasn't
+ * been read yet, the new coredump is discarded. The data lifetime is determined
+ * by the device coredump framework and when it is no longer needed the @free
+ * function will be called to free the data.
+ */
+static inline void dev_coredumpm(struct device *dev, struct module *owner,
+				 void *data, size_t datalen, gfp_t gfp,
+				 ssize_t (*read)(char *buffer, loff_t offset, size_t count,
+						 void *data, size_t datalen),
+				void (*free)(void *data))
+{
+	dev_coredumpm_timeout(dev, owner, data, datalen, gfp, read, free,
+			      DEVCD_TIMEOUT);
+}
+
 #endif /* __DEVCOREDUMP_H */
-- 
2.45.2



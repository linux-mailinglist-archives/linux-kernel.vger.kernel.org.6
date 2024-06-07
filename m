Return-Path: <linux-kernel+bounces-206665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A034900C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61A7284EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F014B958;
	Fri,  7 Jun 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8Et7FOS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBFA1DFEB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788752; cv=none; b=H55jnxmtaMaCgx0VD7Ms59fV8In7XD8nezu/ExUjaDvj+3MOC7CKqI8xehvsCORrBC8HEr6yqhl8wPjJ4kw1tt4ZuLKbGwmrf/PXOlLAGmnSIx3taaUoLeya9tyXcmPvXFC1rDBfF2zu2FZ2J7ly3UGShgcFMS26kG75W5ybJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788752; c=relaxed/simple;
	bh=vZq87tyZokTAER8/mH6NnAwxzfu+Sg7w14ZgjqEZJEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gW88/QhH+pdaN4s3NdlCTn44fKq9TZUiDVQNLglU6d+/GlxsHFQS4oJvzk5nO/Co3aw7lHDL2419rOV+Tn+fn6icVkgYT3X/7GAKFipHlvJo5XUar/nvtOl5zUMkaNRUc5lrjwomZ42hqeqTbtJ38Q0BRHreR8pSu7i+mfQ09bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8Et7FOS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717788751; x=1749324751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZq87tyZokTAER8/mH6NnAwxzfu+Sg7w14ZgjqEZJEY=;
  b=a8Et7FOS4YFGN/AAdPVeQOaDYespFvhR/W0aofm2WGxf6B/TNQAI9tLc
   OpLFmCu7dX/4Yo25LUpirAhDDEodIb9KdOmCO4UTnY93maFuESsLuIy0i
   e0SFG/0r5r/F0xRCSF+ePVMX0jNGm4UkZLg37URMNOY2AoL4dFcL39Mao
   OXN7OsTOaauxmjDgpQMt0XTMaTp8i2R9wA8Qb1Q515olc6aUHI636AJzD
   BzX6s2C6XCQ2jZ7Cs2tFqnfweNI3N3IvURVv4G5NCF1ha3AwqB3Zp/fA3
   mquGHkdoTFReMP4rilWpp+moj4BBL3jp0BAjY2KMvtBrmqTJJH174jxVL
   A==;
X-CSE-ConnectionGUID: rOmFHngMSQmDy64u+Nh31g==
X-CSE-MsgGUID: 8cda2Cq0T9CPnknd5/9u5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14407259"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14407259"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:32:30 -0700
X-CSE-ConnectionGUID: 9dxoUBGVQPKGnmz1n82nIA==
X-CSE-MsgGUID: y+uAv6mhSFWgfEIWFpgBwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="39089268"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:32:28 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v4 1/2] devcoredump: Add dev_coredumpm_timeout()
Date: Fri,  7 Jun 2024 12:32:19 -0700
Message-ID: <20240607193220.229760-1-jose.souza@intel.com>
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

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/base/devcoredump.c  | 23 ++++++++--------
 include/linux/devcoredump.h | 54 ++++++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 23 deletions(-)

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
index c8f7eb6cc1915..56e606eb4640b 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -12,6 +12,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
+/* if data isn't read by userspace after 5 minutes then delete it */
+#define DEVCOREDUMP_TIMEOUT	(HZ * 60 * 5)
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
@@ -72,12 +76,13 @@ static inline void dev_coredumpv(struct device *dev, void *data,
 	vfree(data);
 }
 
-static inline void
-dev_coredumpm(struct device *dev, struct module *owner,
-	      void *data, size_t datalen, gfp_t gfp,
-	      ssize_t (*read)(char *buffer, loff_t offset, size_t count,
-			      void *data, size_t datalen),
-	      void (*free)(void *data))
+void dev_coredumpm_timeout(struct device *dev, struct module *owner,
+			   void *data, size_t datalen, gfp_t gfp,
+			   ssize_t (*read)(char *buffer, loff_t offset,
+					   size_t count, void *data,
+					   size_t datalen),
+			   void (*free)(void *data),
+			   unsigned long timeout)
 {
 	free(data);
 }
@@ -92,4 +97,29 @@ static inline void dev_coredump_put(struct device *dev)
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
+			      DEVCOREDUMP_TIMEOUT);
+}
+
 #endif /* __DEVCOREDUMP_H */
-- 
2.45.2



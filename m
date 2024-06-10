Return-Path: <linux-kernel+bounces-208531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22388902653
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04CE284D07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F63142E60;
	Mon, 10 Jun 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5wiXsE7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38B1DFF7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035905; cv=none; b=IKKmKwBiJyCz71usN2okMiJYm/C/cRfZxL1jeQ/4a7V4kuErm7bVOWumqPyARf0AtEDVuD42CmCFqGsRfr2qE1OiLsonr5TPQdLsXHHwcUYCiZJtj4WWlyrr/F/g2Ms+fmfws8AeYCs+zalUWX+YJ3gXCj5r3xKB1dXMSYDt07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035905; c=relaxed/simple;
	bh=dUsYAftJt41T6AuchTSoENgGxAhOCwtjhSihLZcmOfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rCGwoexnTDGBQrvIjZhr9yR5DAEgs9ZJVfjKnNZ8HQRzSkAGCyhLuZvfu+yGKMT9Zue0+3gAGx9gFU9I7ZfCYiw5OYEmYjtM395o3szaixeMtT5tK2m75Kk0vqtOxK1dVyg/OJpkAuc0wXOjTd2mfF2YxJC7hVte5qkuTWirlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5wiXsE7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718035904; x=1749571904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dUsYAftJt41T6AuchTSoENgGxAhOCwtjhSihLZcmOfc=;
  b=X5wiXsE79d2qlmv2Yt02kjCeDactcgpj0fMueBq1nDanwEqeNUo7tyfI
   l4Ma55SPq2OmH8d3ExsCdzImCZnlamtp8INNYC7twz6K4QbHxcy+G9RTs
   Oz7hyRNWAKwEC+TUulneXw9gqQLptqE7xsA2BfMGxasEptuFpQ/hngP3X
   wwGJrbTsNN7CRZhgqdabyWLTFD3GVFZhjQkrj9pfpFbm4WaN/chApdrJD
   10o9OKLyU12MuIXpcVyNOWEzCh+3Z8/F8lmqDhfpHBbk0jtkAmE72TcM6
   j0kla77vlwl6ptciBg7U8jSLDOedHP9n/zGLaouPSQ6SI1FhpH0dIJrJK
   Q==;
X-CSE-ConnectionGUID: eiE6JXtvQWiiZadmrpJiYw==
X-CSE-MsgGUID: l/ZSC/sKTKik0j4GauOGhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32193224"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="32193224"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:11:44 -0700
X-CSE-ConnectionGUID: sFwIUny1Q6mhDb/Iw9s7xQ==
X-CSE-MsgGUID: omu3LHhJTbCWC/icr8pezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="62281508"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:11:41 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Date: Mon, 10 Jun 2024 09:11:32 -0700
Message-ID: <20240610161133.156566-1-jose.souza@intel.com>
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
index c8f7eb6cc1915..e3de1e545a4a5 100644
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
+			      DEVCD_TIMEOUT);
+}
+
 #endif /* __DEVCOREDUMP_H */
-- 
2.45.2



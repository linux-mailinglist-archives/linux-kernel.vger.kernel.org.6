Return-Path: <linux-kernel+bounces-295851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4A695A212
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00FA1C238AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F71BF80E;
	Wed, 21 Aug 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/aPQ4DD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDC1BAEEF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255328; cv=none; b=BO3BL8XMMuI0feKpRQayvNdQxugg4tZhwKme2mNgq3+jZ6Op0lZ9R7Ewk8mA4C3CbRD31WNViTIRbFe4NKcAEPP8HVI+RRF7gS7TZAx0RNjsxVPEA3gQyg5uJXEoakP8KxuyrUToisUZ8tMijPPhSf9qJnZm0W9Fh1ICqi+u/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255328; c=relaxed/simple;
	bh=IvbQVTKxBadavaVqnza3itzSwqETzToWSwNnsjXbj94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buGsaLCS73Psm7xddP9518S6atJTnw6kjMo/fS7UC3p6AuVYGYlSiAkAJqdLZhHf6vrlPkSXlj5SyUPCUdr0L72er+oppuycRFeMOjOuPTNSNRzzQpi5aT220cOVZiRmyj8ae0huYHeKDVfbxv04eqVrvNbQGdSTj2Fo3kTQD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/aPQ4DD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255328; x=1755791328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IvbQVTKxBadavaVqnza3itzSwqETzToWSwNnsjXbj94=;
  b=X/aPQ4DD+4lOBCDcF3Q1P94qJcxiTsgsg0u6u4GO73J6qHiABJmUJSTE
   lkcaGcB8CgaKzsWLbW7OoW1LeZ+S5bguIA7Bi9CPSF5EmpnzSsc3XE8e6
   qQsTjI0HdUDwyPuXQs2r1oApvsNx/tn3d84sDj0iWLaAlZqUn5Ack0Q6n
   0FOWwjomjRdpprkf1u7k1FiXK0jpFsj6RiT5qC5qN+EYwLaljuWEfcDNx
   449+6RZaBzoGZRL1GMkE0sMYAssbI21+XWIq6JfnX/cbULJS2oKaJeLSs
   c1etYPNAHMhlcQpUBlWUsWx/GP0gzmrUFoca3vZb2enpiT64BGC6TTPrI
   g==;
X-CSE-ConnectionGUID: FDsoPYZuQs2FOTnygMZwbw==
X-CSE-MsgGUID: Uf6fHKN3R3altth0eAQGMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26376282"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26376282"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:44 -0700
X-CSE-ConnectionGUID: b5JaFwwWTfyBQMuVaNPSxg==
X-CSE-MsgGUID: 2kNnkXgEQOCAKyrJLScQww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66080305"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 08:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 26AE6644; Wed, 21 Aug 2024 18:48:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] driver core: Use guards for simple mutex locks
Date: Wed, 21 Aug 2024 18:48:21 +0300
Message-ID: <20240821154839.604259-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guards can help to make the code more readable. So use it wherever they
do so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 50 ++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f5b5b6bcdf35..bff5e53ca0ce 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -98,12 +98,9 @@ static int __fwnode_link_add(struct fwnode_handle *con,
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup,
 		    u8 flags)
 {
-	int ret;
+	guard(mutex)(&fwnode_link_lock);
 
-	mutex_lock(&fwnode_link_lock);
-	ret = __fwnode_link_add(con, sup, flags);
-	mutex_unlock(&fwnode_link_lock);
-	return ret;
+	return __fwnode_link_add(con, sup, flags);
 }
 
 /**
@@ -144,10 +141,10 @@ static void fwnode_links_purge_suppliers(struct fwnode_handle *fwnode)
 {
 	struct fwnode_link *link, *tmp;
 
-	mutex_lock(&fwnode_link_lock);
+	guard(mutex)(&fwnode_link_lock);
+
 	list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook)
 		__fwnode_link_del(link);
-	mutex_unlock(&fwnode_link_lock);
 }
 
 /**
@@ -160,10 +157,10 @@ static void fwnode_links_purge_consumers(struct fwnode_handle *fwnode)
 {
 	struct fwnode_link *link, *tmp;
 
-	mutex_lock(&fwnode_link_lock);
+	guard(mutex)(&fwnode_link_lock);
+
 	list_for_each_entry_safe(link, tmp, &fwnode->consumers, s_hook)
 		__fwnode_link_del(link);
-	mutex_unlock(&fwnode_link_lock);
 }
 
 /**
@@ -1059,20 +1056,16 @@ int device_links_check_suppliers(struct device *dev)
 	 * Device waiting for supplier to become available is not allowed to
 	 * probe.
 	 */
-	mutex_lock(&fwnode_link_lock);
-	sup_fw = fwnode_links_check_suppliers(dev->fwnode);
-	if (sup_fw) {
-		if (!dev_is_best_effort(dev)) {
-			fwnode_ret = -EPROBE_DEFER;
-			dev_err_probe(dev, -EPROBE_DEFER,
-				    "wait for supplier %pfwf\n", sup_fw);
-		} else {
-			fwnode_ret = -EAGAIN;
+	scoped_guard(mutex, &fwnode_link_lock) {
+		sup_fw = fwnode_links_check_suppliers(dev->fwnode);
+		if (sup_fw) {
+			if (dev_is_best_effort(dev))
+				fwnode_ret = -EAGAIN;
+			else
+				return dev_err_probe(dev, -EPROBE_DEFER,
+						     "wait for supplier %pfwf\n", sup_fw);
 		}
 	}
-	mutex_unlock(&fwnode_link_lock);
-	if (fwnode_ret == -EPROBE_DEFER)
-		return fwnode_ret;
 
 	device_links_write_lock();
 
@@ -1247,9 +1240,8 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 	bool val;
 
 	device_lock(dev);
-	mutex_lock(&fwnode_link_lock);
-	val = !!fwnode_links_check_suppliers(dev->fwnode);
-	mutex_unlock(&fwnode_link_lock);
+	scoped_guard(mutex, &fwnode_link_lock)
+		val = !!fwnode_links_check_suppliers(dev->fwnode);
 	device_unlock(dev);
 	return sysfs_emit(buf, "%u\n", val);
 }
@@ -1322,13 +1314,15 @@ void device_links_driver_bound(struct device *dev)
 	 */
 	if (dev->fwnode && dev->fwnode->dev == dev) {
 		struct fwnode_handle *child;
+
 		fwnode_links_purge_suppliers(dev->fwnode);
-		mutex_lock(&fwnode_link_lock);
+
+		guard(mutex)(&fwnode_link_lock);
+
 		fwnode_for_each_available_child_node(dev->fwnode, child)
 			__fw_devlink_pickup_dangling_consumers(child,
 							       dev->fwnode);
 		__fw_devlink_link_to_consumers(dev);
-		mutex_unlock(&fwnode_link_lock);
 	}
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 
@@ -2337,10 +2331,10 @@ static void fw_devlink_link_device(struct device *dev)
 
 	fw_devlink_parse_fwtree(fwnode);
 
-	mutex_lock(&fwnode_link_lock);
+	guard(mutex)(&fwnode_link_lock);
+
 	__fw_devlink_link_to_consumers(dev);
 	__fw_devlink_link_to_suppliers(dev, fwnode);
-	mutex_unlock(&fwnode_link_lock);
 }
 
 /* Device links support end. */
-- 
2.43.0.rc1.1336.g36b5255a03ac



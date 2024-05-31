Return-Path: <linux-kernel+bounces-197010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4288D64DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D09A1C24505
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370757323;
	Fri, 31 May 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpihBMpm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1854656
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167094; cv=none; b=fllwBHtreV4bAuAzO6LXH3iJtkVn0NYl/QDy3JiCKGkbjp4VR6yF8z0EA3P2dUpoFEtIBySvA+IosSm1hf/d1q5SZB7llUDW7YH8ZdRDRK7JtKrrOIavsZr3bwf0ag7l44vt9KWR3d4y8WD70sRpTXEmQs6dx2QaECoVpBwPPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167094; c=relaxed/simple;
	bh=7h1JHvMSQCNajOTO0q9gdjzOivHbmkPn9GprPw6QZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kT7Zq4iMa32b0j+BcXOSCw0yXFkjKrVYQYqWLGks4/2C/scWkJGfw55WJJYb/BXatsyBNZZB/+VMMGP+B3wCkNiNRxarff4R82GXM6wzjlEPIx6BPClqd/ENiqTmHXmRbemB9WBSwLPOFHQ4hBxaGQm6dDUVBv2tV8+RAHKosII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpihBMpm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717167094; x=1748703094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7h1JHvMSQCNajOTO0q9gdjzOivHbmkPn9GprPw6QZ2k=;
  b=SpihBMpm6WLF8iccDYkCIbEmaE9VngWI6Vn4z4xIuqS66XaFZFu6ZVJI
   BgZLA2jJgz+Ov5VkxPS4KZdHIXv8dn4CyoeDJ40Z2x1VtxhOkT3s2dIe8
   xXa/Ec2bjoQmD+XB8lb8Fv2zeeDPegYilXZlktiX1xf4CXAGwrQruRdcL
   Dh5xaPmnWFuikvY7JKJxpjrQT6ko0s3KH6TU3RvoMlEjv0/yvmP/ffWU5
   GkkO10sROqD7cINGWPvO1+oqHCLfVcF1wHFCtERo+Tv+fTaQCID44/pGb
   /s1ChVHhY2wMX3Fus6aTxEh8+scRmmKU5tsuRCrNcDn4kovkrSmMqEq6O
   A==;
X-CSE-ConnectionGUID: j2obHVpZSJ2kaoVgUwgSuw==
X-CSE-MsgGUID: eWPpoUEgQqa8KGMJXyYdUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17543190"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17543190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 07:51:33 -0700
X-CSE-ConnectionGUID: ueK8RTKKTAOv+0hkDjmfLA==
X-CSE-MsgGUID: duUR3BGmS4yumL5UGdQhqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36766507"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 31 May 2024 07:51:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 998A5228; Fri, 31 May 2024 17:51:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: device.h: Group of_node handling declarations and definitions
Date: Fri, 31 May 2024 17:51:29 +0300
Message-ID: <20240531145129.1506733-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few of_node related APIs defined in the driver core.
Group the respective declarations and definitions in the header.
There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index fc3bd7116ab9..56f266429229 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1031,13 +1031,6 @@ static inline void device_lock_assert(struct device *dev)
 	lockdep_assert_held(&dev->mutex);
 }
 
-static inline struct device_node *dev_of_node(struct device *dev)
-{
-	if (!IS_ENABLED(CONFIG_OF) || !dev)
-		return NULL;
-	return dev->of_node;
-}
-
 static inline bool dev_has_sync_state(struct device *dev)
 {
 	if (!dev)
@@ -1144,10 +1137,18 @@ void unlock_device_hotplug(void);
 int lock_device_hotplug_sysfs(void);
 int device_offline(struct device *dev);
 int device_online(struct device *dev);
+
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
 void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwnode);
-void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
 void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
+void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+
+static inline struct device_node *dev_of_node(struct device *dev)
+{
+	if (!IS_ENABLED(CONFIG_OF) || !dev)
+		return NULL;
+	return dev->of_node;
+}
 
 static inline int dev_num_vf(struct device *dev)
 {
-- 
2.43.0.rc1.1336.g36b5255a03ac



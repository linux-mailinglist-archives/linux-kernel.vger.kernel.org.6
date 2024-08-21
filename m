Return-Path: <linux-kernel+bounces-295848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F16695A20F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D991928F5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8C1BE242;
	Wed, 21 Aug 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDxDUqcD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BF15351A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255327; cv=none; b=cGq0hq1IQ5onUwQPXH435R4BoENq/ppPHmu0lcmxSwv9uIZL8XPARKkiRI+Rybx+JztHPazHSOo6z/CYz8TIlvLGQlkSWdQodH1iGInRGPDVArVFyy+ui0I+uVlzM8EnkR9d5UOOra3wj/Tz/CTJeSEp7EoSbfdrqXPXyX1sBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255327; c=relaxed/simple;
	bh=R6OqrPboQJiBPG6d8rzIvuM4XVVf3Y1qoXELO+1nxFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/5BVfkHEx3V/JNAXU6Lt9dJrNVsolreeT4HH12c+a5Mm6gsOJZoWxaN9O0VOLl7ovjgLT1+M39yBbEqsu99eoevN662/XzXNlOockyVNvpdMtAUchrsbIskJnolz+pGckqkJ4n2j7PkycLs/0spWWHIt74sT041M5oWH8oyCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDxDUqcD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255325; x=1755791325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6OqrPboQJiBPG6d8rzIvuM4XVVf3Y1qoXELO+1nxFw=;
  b=GDxDUqcD6LSJKL72L3kXiKdE6lnpbIOe1/W1os/18lnFs6ZfoUmFU922
   PoS3pa6z2GooqeR3muBjvsJ85uGRfz7yO9UK5gWREkdwjngJZH7Wsrmi9
   aoOry7w04TQ0jwjYxoJXm3NqAsc2/6yd51CX17ft6pVH+UgonQs4oRvgE
   iRT+XiIQMIeCTXEDTc1ol6JnWFFxc2wkT8z8qKtrPdc8V8IyXS3yWbV1o
   RLkC65cElPa9+1hGaWC3GgCZCU4Hbty9NHPcOYGS0u/9cRnTxfzwHs4TP
   9A+G/F5v4UpLwyKIP0n4Ki8ezZzMR44f/QroT1X8KBoc/+/ZuXoyJE4M6
   g==;
X-CSE-ConnectionGUID: KPeKWpT5QiKpQwWd8L5JUQ==
X-CSE-MsgGUID: eCEVmebNSlqcQmHi4DcKdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26376278"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="26376278"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:44 -0700
X-CSE-ConnectionGUID: 7Z99zUlTS/OGfy+38nhX9A==
X-CSE-MsgGUID: oMjiuJ+wQc+y7l+eIlalZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66080304"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2024 08:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 17D9F49F; Wed, 21 Aug 2024 18:48:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] driver core: Use kasprintf() instead of fixed buffer formatting
Date: Wed, 21 Aug 2024 18:48:20 +0300
Message-ID: <20240821154839.604259-3-andriy.shevchenko@linux.intel.com>
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

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 70 +++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6b9d3d255135..f5b5b6bcdf35 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/blkdev.h>
+#include <linux/cleanup.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
@@ -563,24 +564,11 @@ static struct class devlink_class = {
 
 static int devlink_add_symlinks(struct device *dev)
 {
+	char *buf_con __free(kfree) = NULL, *buf_sup __free(kfree) = NULL;
 	int ret;
-	size_t len;
 	struct device_link *link = to_devlink(dev);
 	struct device *sup = link->supplier;
 	struct device *con = link->consumer;
-	char *buf;
-
-	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
-		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
-	len += strlen(":");
-	/*
-	 * we kzalloc() memory for symlink name of both supplier and
-	 * consumer, so explicitly take into account both prefix.
-	 */
-	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
-	buf = kzalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 
 	ret = sysfs_create_link(&link->link_dev.kobj, &sup->kobj, "supplier");
 	if (ret)
@@ -590,58 +578,64 @@ static int devlink_add_symlinks(struct device *dev)
 	if (ret)
 		goto err_con;
 
-	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
-	ret = sysfs_create_link(&sup->kobj, &link->link_dev.kobj, buf);
+	buf_con = kasprintf(GFP_KERNEL, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
+	if (!buf_con) {
+		ret = -ENOMEM;
+		goto err_con_dev;
+	}
+
+	ret = sysfs_create_link(&sup->kobj, &link->link_dev.kobj, buf_con);
 	if (ret)
 		goto err_con_dev;
 
-	snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
-	ret = sysfs_create_link(&con->kobj, &link->link_dev.kobj, buf);
+	buf_sup = kasprintf(GFP_KERNEL, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
+	if (!buf_sup) {
+		ret = -ENOMEM;
+		goto err_sup_dev;
+	}
+
+	ret = sysfs_create_link(&con->kobj, &link->link_dev.kobj, buf_sup);
 	if (ret)
 		goto err_sup_dev;
 
 	goto out;
 
 err_sup_dev:
-	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
-	sysfs_remove_link(&sup->kobj, buf);
+	sysfs_remove_link(&sup->kobj, buf_con);
 err_con_dev:
 	sysfs_remove_link(&link->link_dev.kobj, "consumer");
 err_con:
 	sysfs_remove_link(&link->link_dev.kobj, "supplier");
 out:
-	kfree(buf);
 	return ret;
 }
 
 static void devlink_remove_symlinks(struct device *dev)
 {
+	char *buf_con __free(kfree) = NULL, *buf_sup __free(kfree) = NULL;
 	struct device_link *link = to_devlink(dev);
-	size_t len;
 	struct device *sup = link->supplier;
 	struct device *con = link->consumer;
-	char *buf;
 
 	sysfs_remove_link(&link->link_dev.kobj, "consumer");
 	sysfs_remove_link(&link->link_dev.kobj, "supplier");
 
-	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
-		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
-	len += strlen(":");
-	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
-	buf = kzalloc(len, GFP_KERNEL);
-	if (!buf) {
-		WARN(1, "Unable to properly free device link symlinks!\n");
-		return;
+	if (device_is_registered(con)) {
+		buf_sup = kasprintf(GFP_KERNEL, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
+		if (!buf_sup)
+			goto out;
+		sysfs_remove_link(&con->kobj, buf_sup);
 	}
 
-	if (device_is_registered(con)) {
-		snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
-		sysfs_remove_link(&con->kobj, buf);
-	}
-	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
-	sysfs_remove_link(&sup->kobj, buf);
-	kfree(buf);
+	buf_con = kasprintf(GFP_KERNEL, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
+	if (!buf_con)
+		goto out;
+	sysfs_remove_link(&sup->kobj, buf_con);
+
+	return;
+
+out:
+	WARN(1, "Unable to properly free device link symlinks!\n");
 }
 
 static struct class_interface devlink_class_intf = {
-- 
2.43.0.rc1.1336.g36b5255a03ac



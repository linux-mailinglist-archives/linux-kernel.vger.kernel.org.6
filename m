Return-Path: <linux-kernel+bounces-514646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76FA359B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D27188BCB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BABF22D798;
	Fri, 14 Feb 2025 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHWt3UJ5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01382211497;
	Fri, 14 Feb 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524108; cv=none; b=F2VHHbl2LbmK+WBO50RUPFJ3HaybQEbezX2urySJmHoeZr4PypPnzd8rELRCtQ0ouGxFGjLK6PdXbc5Bi3vUuDdzZ77lIUCb9Cwi/fDy5y4vWFo+yWkDwqc8hpNRJUNvk1Rx/6jQx54yCcAGUI9T5TZc7Yz36oKFOMgFVghSdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524108; c=relaxed/simple;
	bh=9GAN2wqhXEOHdcyK7lREPKym8KwXksIObQM5sWX+jrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+sKa1BiJzxGKp2I765e1/4h77Ij6MVylf5DelAZe0TJZV8iNiPGD5Gk9l/dEfZz8z2qD2x75Nu7MOSom6v8kGgX4Nb6tNC1SLsIHPoOIDhDa7nUzCkol0YqNRp3jlW9qctZ4EIJeRWxxsskfWIgfiWHSsaYUJu9z6BZU+Mh/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHWt3UJ5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524106; x=1771060106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9GAN2wqhXEOHdcyK7lREPKym8KwXksIObQM5sWX+jrY=;
  b=cHWt3UJ5QkWnxkyLrkTMVxNbrbSRh5+H9H430tppMDf6mA3zQfIBfnFB
   PFv1ISKxBGICZjaQoKAFAoKPIYfeESOlOlogvBUfEVDPvy4gOKtWvURui
   od3QtgWz3CPzRmJrtCsF/MYDCOhxCAFHPHLiS239p/zNGZyxvru+4wsH2
   mg9QyFeNZS1/6nQrfQUZ6syaW6GPEA8VKCS18ykMbovNmkOi4cO33yv/z
   pfkF4p0RP5Rr2TF5ONhpWW+d7GQny4l4R3rPrQNSmOr/6jp/d546gRJUp
   isk/o7lUisZ//cJ+S/d61S8smlOy6dO7gbo/kP4OERYXb2wOJPCTMeo8u
   g==;
X-CSE-ConnectionGUID: DUNERLhDREGSlQ2D0uOy0w==
X-CSE-MsgGUID: welsIwUDSiKWwoJoQq9M7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51694755"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51694755"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:08:24 -0800
X-CSE-ConnectionGUID: SgEbyHy1RjaiHx/TbP09EA==
X-CSE-MsgGUID: 7H56IjySQpqx84tJFUhDRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114303047"
Received: from inlubt0246.iind.intel.com ([10.191.24.87])
  by orviesa008.jf.intel.com with ESMTP; 14 Feb 2025 01:08:01 -0800
From: subramanian.mohan@intel.com
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	giometti@enneenne.com,
	tglx@linutronix.de,
	corbet@lwn.net
Cc: eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com,
	david.zage@intel.com,
	srinivasan.chinnadurai@intel.com,
	subramanian.mohan@intel.com
Subject: [PATCH v14 1/4] drivers pps/generators: replace copy of pps-gen info struct with const pointer
Date: Fri, 14 Feb 2025 14:37:52 +0530
Message-Id: <20250214090755.37450-2-subramanian.mohan@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214090755.37450-1-subramanian.mohan@intel.com>
References: <20250214090755.37450-1-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Subramanian Mohan <subramanian.mohan@intel.com>

Some PPS generator drivers may need to retrieve a pointer to their
internal data while executing the PPS generator enable() method.

During the driver registration the pps_gen_device pointer is returned
from the framework, and for that reason, there is difficulty in
getting generator driver data back in the enable function. We won't be
able to use container_of macro as it results in static assert, and we
might end up in using static pointer.

To solve the issue and to get back the generator driver data back, we
should not copy the struct pps_gen_source_info within the struct
pps_gen_device during the registration stage, but simply save the
pointer of the driver one. In this manner, driver may get a pointer
to their internal data as shown below:

struct pps_gen_foo_data_s {
        ...
	struct pps_gen_source_info gen_info;
	struct pps_gen_device *pps_gen;
	...
};

static int __init pps_gen_foo_init(void)
{
        struct pps_gen_foo_data_s *foo;
	...
        foo->pps_gen = pps_gen_register_source(&foo->gen_info);
	...
}

Then, in the enable() method, we can retrieve the pointer to the main
struct by using the code below:

static int pps_gen_foo_enable(struct pps_gen_device *pps_gen, bool enable)
{
        struct pps_gen_foo_data_s *foo = container_of(pps_gen->info,
						struct pps_gen_foo_data_s, gen_info);
        ...
}

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
Tested-by: Subramanian Mohan <subramanian.mohan@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
---
 Documentation/driver-api/pps.rst       |  3 +--
 drivers/pps/generators/pps_gen-dummy.c |  2 +-
 drivers/pps/generators/pps_gen.c       | 14 +++++++-------
 drivers/pps/generators/sysfs.c         |  6 +++---
 include/linux/pps_gen_kernel.h         |  4 ++--
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 71ad04c82d6c..04f1b88778fc 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -206,8 +206,7 @@ To do so the class pps-gen has been added. PPS generators can be
 registered in the kernel by defining a struct pps_gen_source_info as
 follows::
 
-    static struct pps_gen_source_info pps_gen_dummy_info = {
-            .name                   = "dummy",
+    static const struct pps_gen_source_info pps_gen_dummy_info = {
             .use_system_clock       = true,
             .get_time               = pps_gen_dummy_get_time,
             .enable                 = pps_gen_dummy_enable,
diff --git a/drivers/pps/generators/pps_gen-dummy.c b/drivers/pps/generators/pps_gen-dummy.c
index b284c200cbe5..55de4aecf35e 100644
--- a/drivers/pps/generators/pps_gen-dummy.c
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -61,7 +61,7 @@ static int pps_gen_dummy_enable(struct pps_gen_device *pps_gen, bool enable)
  * The PPS info struct
  */
 
-static struct pps_gen_source_info pps_gen_dummy_info = {
+static const struct pps_gen_source_info pps_gen_dummy_info = {
 	.use_system_clock	= true,
 	.get_time		= pps_gen_dummy_get_time,
 	.enable			= pps_gen_dummy_enable,
diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index ca592f1736f4..5b8bb454913c 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -66,7 +66,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 		if (ret)
 			return -EFAULT;
 
-		ret = pps_gen->info.enable(pps_gen, status);
+		ret = pps_gen->info->enable(pps_gen, status);
 		if (ret)
 			return ret;
 		pps_gen->enabled = status;
@@ -76,7 +76,7 @@ static long pps_gen_cdev_ioctl(struct file *file,
 	case PPS_GEN_USESYSTEMCLOCK:
 		dev_dbg(pps_gen->dev, "PPS_GEN_USESYSTEMCLOCK\n");
 
-		ret = put_user(pps_gen->info.use_system_clock, uiuarg);
+		ret = put_user(pps_gen->info->use_system_clock, uiuarg);
 		if (ret)
 			return -EFAULT;
 
@@ -175,7 +175,7 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 	devt = MKDEV(MAJOR(pps_gen_devt), pps_gen->id);
 
 	cdev_init(&pps_gen->cdev, &pps_gen_cdev_fops);
-	pps_gen->cdev.owner = pps_gen->info.owner;
+	pps_gen->cdev.owner = pps_gen->info->owner;
 
 	err = cdev_add(&pps_gen->cdev, devt, 1);
 	if (err) {
@@ -183,8 +183,8 @@ static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
 				MAJOR(pps_gen_devt), pps_gen->id);
 		goto free_ida;
 	}
-	pps_gen->dev = device_create(pps_gen_class, pps_gen->info.parent, devt,
-					pps_gen, "pps-gen%d", pps_gen->id);
+	pps_gen->dev = device_create(pps_gen_class, pps_gen->info->parent, devt,
+				     pps_gen, "pps-gen%d", pps_gen->id);
 	if (IS_ERR(pps_gen->dev)) {
 		err = PTR_ERR(pps_gen->dev);
 		goto del_cdev;
@@ -225,7 +225,7 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
  * Return: the PPS generator device in case of success, and ERR_PTR(errno)
  *	 otherwise.
  */
-struct pps_gen_device *pps_gen_register_source(struct pps_gen_source_info *info)
+struct pps_gen_device *pps_gen_register_source(const struct pps_gen_source_info *info)
 {
 	struct pps_gen_device *pps_gen;
 	int err;
@@ -235,7 +235,7 @@ struct pps_gen_device *pps_gen_register_source(struct pps_gen_source_info *info)
 		err = -ENOMEM;
 		goto pps_gen_register_source_exit;
 	}
-	pps_gen->info = *info;
+	pps_gen->info = info;
 	pps_gen->enabled = false;
 
 	init_waitqueue_head(&pps_gen->queue);
diff --git a/drivers/pps/generators/sysfs.c b/drivers/pps/generators/sysfs.c
index faf8b1c6d202..6d6bc0006fea 100644
--- a/drivers/pps/generators/sysfs.c
+++ b/drivers/pps/generators/sysfs.c
@@ -19,7 +19,7 @@ static ssize_t system_show(struct device *dev, struct device_attribute *attr,
 {
 	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%d\n", pps_gen->info.use_system_clock);
+	return sysfs_emit(buf, "%d\n", pps_gen->info->use_system_clock);
 }
 static DEVICE_ATTR_RO(system);
 
@@ -30,7 +30,7 @@ static ssize_t time_show(struct device *dev, struct device_attribute *attr,
 	struct timespec64 time;
 	int ret;
 
-	ret = pps_gen->info.get_time(pps_gen, &time);
+	ret = pps_gen->info->get_time(pps_gen, &time);
 	if (ret)
 		return ret;
 
@@ -49,7 +49,7 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = pps_gen->info.enable(pps_gen, status);
+	ret = pps_gen->info->enable(pps_gen, status);
 	if (ret)
 		return ret;
 	pps_gen->enabled = status;
diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
index 022ea0ac4440..6214c8aa2e02 100644
--- a/include/linux/pps_gen_kernel.h
+++ b/include/linux/pps_gen_kernel.h
@@ -43,7 +43,7 @@ struct pps_gen_source_info {
 
 /* The main struct */
 struct pps_gen_device {
-	struct pps_gen_source_info info;	/* PSS generator info */
+	const struct pps_gen_source_info *info;	/* PSS generator info */
 	bool enabled;				/* PSS generator status */
 
 	unsigned int event;
@@ -70,7 +70,7 @@ extern const struct attribute_group *pps_gen_groups[];
  */
 
 extern struct pps_gen_device *pps_gen_register_source(
-				struct pps_gen_source_info *info);
+				const struct pps_gen_source_info *info);
 extern void pps_gen_unregister_source(struct pps_gen_device *pps_gen);
 extern void pps_gen_event(struct pps_gen_device *pps_gen,
 				unsigned int event, void *data);
-- 
2.35.3



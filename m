Return-Path: <linux-kernel+bounces-344745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6498ADB7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAE11F22137
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DE1A0B12;
	Mon, 30 Sep 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kn1gIw0k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCD1991D2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726718; cv=none; b=dULH/u+KEmyLa2n2zzs3UP4is9Gy752GDgtm014D11EGmkjmzQ7Bf/kGNH1/CF1fPn0X7+VwYdEtdUbczTKcRTgByXZjFa+D/KTkg5FzhDAQT6aH/cEp2Ex9Oc3WelZnIF2f/lVJ4mBSD/HXA52zSIBIvBOrl/bB/tFwZTB49KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726718; c=relaxed/simple;
	bh=dKfDvl4EA/voPo0rHK84DoHeFvMWHo7JZFGw5Is0vpw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=kXzHsCgSvd/XlvJeByP2xApRM2TvE3XL8pM8XPU04KlR2ISqNYkFNScTZe5/f81dgxNSa2KYP7lUILMRMH3OKTDOkgvF1h0zS4pmek0zW4EoS2s6YDPcCr/R9k6esOpCCT5oHgJUAbpTPNViqyLHag7JY/nEFYgABCD3jjFTwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kn1gIw0k; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727726716; x=1759262716;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dKfDvl4EA/voPo0rHK84DoHeFvMWHo7JZFGw5Is0vpw=;
  b=kn1gIw0kvUxBbgS7B82K2EBN3lDZ4BcRwsFt06LNCh2xMvQK9mmRBhwk
   iVIuDZwifPcbl2wW6gbnVmded+49SoNLgufFP75IT8FFmPth5HpAYWGmV
   JusgpWQKVuBoiFbjvjCpKZKwh5SUnd9UkLmDR9uVYCBpmbGoSxHfQMjkb
   TM7BlZed4WF+7gGeLrVBpWI5Kx6+vXqAmon8ngKEmPiUgtQsRT9cuAM96
   ByyxRLfcNuIi/ubQG55lPCOz1S2o62S2kp0ngX/U0ljuhNmfwIjWQtx+6
   VrdazgPqZ4a/Cr7QVwsoK3/57BGej4WQy5BqDYgraEm/lyP9WZMiULNFl
   A==;
X-CSE-ConnectionGUID: US3TCp+KTkuLeTmMzFO4iA==
X-CSE-MsgGUID: eIvqMGZRQxCrPmoFVCq8Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26346945"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26346945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:05:15 -0700
X-CSE-ConnectionGUID: +GLt9lSUTXWHcjdQOu3CEg==
X-CSE-MsgGUID: avD6ikjZQbCMhpvmpT0IHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73680182"
Received: from eamartin-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.184])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:05:15 -0700
Subject: [PATCH] driver core: Fix userspace expectations of uevent_show() as
 a probe barrier
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Date: Mon, 30 Sep 2024 13:05:13 -0700
Message-ID: <172772671177.1003633.7355063154793624707.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Commit "driver core: Fix uevent_show() vs driver detach race" [1]
attempted to fix a lockdep report in uevent_show() by making the lookup
of driver information for a given device lockless. It turns out that
userspace likely depends on the side-effect of uevent_show() flushing
device probing, as evidenced by the removal of the lock causing a
regression initializing USB devices [2].

Introduce a new "locked" type for sysfs attributes that arranges for the
attribute to be called under the device-lock, but without setting up a
reverse locking order dependency with the kernfs_get_active() lock.

This new facility holds a reference on a device while any locked-sysfs
attribute of that device is open. It then takes the lock around sysfs
read/write operations in the following order:

    of->mutex
    of->op_mutex <= device_lock()
    kernfs_get_active()
    <operation>

Compare that to problematic locking order of:

    of->mutex
    kernfs_get_active()
    <operation>
        device_lock()

...which causes potential deadlocks with kernfs_drain() that may be
called while the device_lock() is held.

Note that the synchronize_rcu() in module_remove_driver(), introduced in
the precedubg fix, likely needs to remain since dev_uevent() is not
always called with the device_lock held. Userspace can potentially
trigger use after free by racing module removal against kernel
invocations of kobject_uevent().

Note2, this change effectively allows userspace to test for
CONFIG_DEBUG_KOBJECT_RELEASE-style driver bugs as the lifetime of open
file descriptors on the @uevent attribute keeps the device reference
count elevated indefinitely.

Reported-by: brmails+k
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219244 [2]
Tested-by: brmails+k
Fixes: 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race") [1]
Cc: stable@vger.kernel.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c    |    2 +-
 fs/kernfs/file.c       |   24 +++++++++++++++++++-----
 fs/sysfs/file.c        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/sysfs/group.c       |    4 ++--
 include/linux/device.h |    4 ++++
 include/linux/kernfs.h |    1 +
 include/linux/sysfs.h  |   17 +++++++++++++++++
 7 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8c0733d3aad8..1fd5a18cbb62 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2772,7 +2772,7 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 
 	return count;
 }
-static DEVICE_ATTR_RW(uevent);
+static DEVICE_ATTR_LOCKED_RW(uevent);
 
 static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..eb5c2167beb9 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -142,6 +142,20 @@ static void kernfs_seq_stop_active(struct seq_file *sf, void *v)
 	kernfs_put_active(of->kn);
 }
 
+static void kernfs_open_file_lock(struct kernfs_open_file *of)
+{
+	mutex_lock(&of->mutex);
+	if (of->op_mutex)
+		mutex_lock(of->op_mutex);
+}
+
+static void kernfs_open_file_unlock(struct kernfs_open_file *of)
+{
+	if (of->op_mutex)
+		mutex_unlock(of->op_mutex);
+	mutex_unlock(&of->mutex);
+}
+
 static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 {
 	struct kernfs_open_file *of = sf->private;
@@ -151,7 +165,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
 	 * @of->mutex nests outside active ref and is primarily to ensure that
 	 * the ops aren't called concurrently for the same open file.
 	 */
-	mutex_lock(&of->mutex);
+	kernfs_open_file_lock(of);
 	if (!kernfs_get_active(of->kn))
 		return ERR_PTR(-ENODEV);
 
@@ -193,7 +207,7 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 
 	if (v != ERR_PTR(-ENODEV))
 		kernfs_seq_stop_active(sf, v);
-	mutex_unlock(&of->mutex);
+	kernfs_open_file_unlock(of);
 }
 
 static int kernfs_seq_show(struct seq_file *sf, void *v)
@@ -322,9 +336,9 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	 * @of->mutex nests outside active ref and is used both to ensure that
 	 * the ops aren't called concurrently for the same open file.
 	 */
-	mutex_lock(&of->mutex);
+	kernfs_open_file_lock(of);
 	if (!kernfs_get_active(of->kn)) {
-		mutex_unlock(&of->mutex);
+		kernfs_open_file_unlock(of);
 		len = -ENODEV;
 		goto out_free;
 	}
@@ -336,7 +350,7 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		len = -EINVAL;
 
 	kernfs_put_active(of->kn);
-	mutex_unlock(&of->mutex);
+	kernfs_open_file_unlock(of);
 
 	if (len > 0)
 		iocb->ki_pos += len;
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d1995e2d6c94..1bb878efcf00 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <linux/mm.h>
 
 #include "sysfs.h"
@@ -189,6 +190,26 @@ static int sysfs_kf_bin_open(struct kernfs_open_file *of)
 	return 0;
 }
 
+/* locked attributes are always device attributes */
+static int sysfs_kf_setup_lock(struct kernfs_open_file *of)
+{
+	struct kobject *kobj = of->kn->parent->priv;
+	struct device *dev = kobj_to_dev(kobj);
+
+	get_device(dev);
+	of->op_mutex = &dev->mutex;
+
+	return 0;
+}
+
+static void sysfs_kf_free_lock(struct kernfs_open_file *of)
+{
+	struct kobject *kobj = of->kn->parent->priv;
+	struct device *dev = kobj_to_dev(kobj);
+
+	put_device(dev);
+}
+
 void sysfs_notify(struct kobject *kobj, const char *dir, const char *attr)
 {
 	struct kernfs_node *kn = kobj->sd, *tmp;
@@ -227,6 +248,25 @@ static const struct kernfs_ops sysfs_file_kfops_rw = {
 	.write		= sysfs_kf_write,
 };
 
+static const struct kernfs_ops sysfs_locked_kfops_ro = {
+	.seq_show	= sysfs_kf_seq_show,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
+static const struct kernfs_ops sysfs_locked_kfops_wo = {
+	.write		= sysfs_kf_write,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
+static const struct kernfs_ops sysfs_locked_kfops_rw = {
+	.seq_show	= sysfs_kf_seq_show,
+	.write		= sysfs_kf_write,
+	.open		= sysfs_kf_setup_lock,
+	.release	= sysfs_kf_free_lock,
+};
+
 static const struct kernfs_ops sysfs_prealloc_kfops_ro = {
 	.read		= sysfs_kf_read,
 	.prealloc	= true,
@@ -287,6 +327,13 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 			ops = &sysfs_prealloc_kfops_ro;
 		else if (sysfs_ops->store)
 			ops = &sysfs_prealloc_kfops_wo;
+	} else if (mode & SYSFS_LOCKED) {
+		if (sysfs_ops->show && sysfs_ops->store)
+			ops = &sysfs_locked_kfops_rw;
+		else if (sysfs_ops->show)
+			ops = &sysfs_locked_kfops_ro;
+		else if (sysfs_ops->store)
+			ops = &sysfs_locked_kfops_wo;
 	} else {
 		if (sysfs_ops->show && sysfs_ops->store)
 			ops = &sysfs_file_kfops_rw;
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index d22ad67a0f32..0158367866be 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -68,11 +68,11 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 					continue;
 			}
 
-			WARN(mode & ~(SYSFS_PREALLOC | 0664),
+			WARN(mode & ~(SYSFS_PREALLOC | SYSFS_LOCKED | 0664),
 			     "Attribute %s: Invalid permissions 0%o\n",
 			     (*attr)->name, mode);
 
-			mode &= SYSFS_PREALLOC | 0664;
+			mode &= SYSFS_PREALLOC | SYSFS_LOCKED | 0664;
 			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
 						       gid, NULL);
 			if (unlikely(error))
diff --git a/include/linux/device.h b/include/linux/device.h
index 34eb20f5966f..25e936aa324d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -180,6 +180,10 @@ ssize_t device_show_string(struct device *dev, struct device_attribute *attr,
 #define DEVICE_ATTR_RW(_name) \
 	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
 
+/* Consider using device_driver.dev_groups instead of this */
+#define DEVICE_ATTR_LOCKED_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_LOCKED_RW(_name)
+
 /**
  * DEVICE_ATTR_ADMIN_RW - Define an admin-only read-write device attribute.
  * @_name: Attribute name.
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 87c79d076d6d..df6828a7cd3e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -257,6 +257,7 @@ struct kernfs_open_file {
 
 	/* private fields, do not use outside kernfs proper */
 	struct mutex		mutex;
+	struct mutex		*op_mutex;
 	struct mutex		prealloc_mutex;
 	int			event;
 	struct list_head	list;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index c4e64dc11206..4c6a0a87247d 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -103,6 +103,7 @@ struct attribute_group {
 
 #define SYSFS_PREALLOC		010000
 #define SYSFS_GROUP_INVISIBLE	020000
+#define SYSFS_LOCKED		040000
 
 /*
  * DEFINE_SYSFS_GROUP_VISIBLE(name):
@@ -230,6 +231,20 @@ struct attribute_group {
 	.store	= _store,						\
 }
 
+/*
+ * uevent_show() needs this due to userspace expectations of reading
+ * that attribute flushing device probing, it is not intended to be a
+ * general semantic for other device sysfs attributes. It is broken to
+ * use this with non-device / pure-kobject sysfs attributes, see
+ * sysfs_kf_setup_lock().
+ */
+#define __ATTR_LOCKED(_name, _mode, _show, _store) {			\
+	.attr = {.name = __stringify(_name),				\
+		 .mode = SYSFS_LOCKED | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+	.show	= _show,						\
+	.store	= _store,						\
+}
+
 #define __ATTR_RO(_name) {						\
 	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
 	.show	= _name##_show,						\
@@ -255,6 +270,8 @@ struct attribute_group {
 
 #define __ATTR_RW(_name) __ATTR(_name, 0644, _name##_show, _name##_store)
 
+#define __ATTR_LOCKED_RW(_name) __ATTR_LOCKED(_name, 0644, _name##_show, _name##_store)
+
 #define __ATTR_NULL { .attr = { .name = NULL } }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC



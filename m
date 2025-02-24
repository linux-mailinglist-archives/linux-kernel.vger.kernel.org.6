Return-Path: <linux-kernel+bounces-528132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA3A413F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF9171B50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4201A9B39;
	Mon, 24 Feb 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9ujbI08"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5B157A5C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367321; cv=none; b=oLHrfUFIQCehHuFPPtCfzobN5keQdsPsoewqxgvPxXSp62q6q2Ce0xBe8U10YTp34Jho0/8kJznSz/xmP2b7VvuMSUsnCtbVOkFo1LhuDX6wyP/HAvauSwOA90I1oXg3ReX2zL8NT/Rq+Xk9Fwqir6Qcn+Q5wOVqTlUY4DGqq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367321; c=relaxed/simple;
	bh=JfXnBns1Fax1qPA3yPKSlFeVnjd9t6yOBfyrq6kQx6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J6a2dxKl8hs2w1Te6VzFSzGuKumwU++ThDyKxMnGXXDGawM0aqzlbnZW1rAlWbMeBbG8s0O0PegvNWKDYNpfK9jVBIeAOVk3yaeu9CYXJ9qjvNGISce1E4hHIZ+1TXMti18+KINBSe/KxsAZG67HPJ2O6X9K5C7IgPE6bT8zXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9ujbI08; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740367320; x=1771903320;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JfXnBns1Fax1qPA3yPKSlFeVnjd9t6yOBfyrq6kQx6g=;
  b=P9ujbI08fXt3YTemgzTROXHY7nA6bm27dWd6JCujP0hvMpe1i10TTy3+
   By/hICMafAr0eb7H4sqK9olPWoSTtfXrRtyY7ZCPVgiQc0c5hPWur8AHd
   plGoKjq6BRbXk6URCN7Iavk/PsvrQmke7sW5d4Zz0/PTGMtYOfzBtsbBY
   UgFgCsHhVOByrf5DYyZ1xCf/6acR4PVrJJ1mMXyJD4YBW9cp+YoWaaREu
   tidBtgnTYdjrWb3WIVeN7SxRN7WyArPwdfWY6IWi71dadVgDFIAIlklhi
   CafzaxDcoCLxCp3IEHQ2yeZ2vipWkmUWpoDP6Qvn0CySVTFAvAN+/IgLV
   Q==;
X-CSE-ConnectionGUID: iPx0YTCSRkayXNDdxJSwdw==
X-CSE-MsgGUID: vMsTBKJXQ0GicKAQ65KOXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="28706864"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28706864"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:56 -0800
X-CSE-ConnectionGUID: AYbk5T1iRLGtQP54D+Ck3g==
X-CSE-MsgGUID: 4OrWKWCaQSy1Mx+jhdCcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116441900"
Received: from shanagud-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.117.251])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:14 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Sun, 23 Feb 2025 21:20:12 -0600
Subject: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Middleton <dan.middleton@linux.intel.com>, 
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: b4 0.13.0

Add new TSM APIs for TVM guest drivers to register and expose measurement
registers (MRs) as sysfs attributes (files).

New TSM APIs:

- `tsm_register_measurement(struct tsm_measurement *)`: Register a set of
  MRs with the TSM core.
- `tsm_unregister_measurement(struct tsm_measurement *)`: Unregister a
  previously registered set of MRs.

These APIs are centered around `struct tsm_measurement`, which includes an
array of `struct tsm_measurement_register`s with properties
(`tsm_measurement_register::mr_flags`) like *Readable* (`TSM_MR_F_R`) and
*Extensible* (`TSM_MR_F_X`). For details, see include/linux/tsm.h.

Upon successful registration, the TSM core exposes MRs in sysfs at
/sys/kernel/tsm/MR_PROVIDER/, where MR_PROVIDER is the measurement
provider's name (`tsm_measurement::name`). Each MR is accessible either as
a file (/sys/kernel/tsm/MR_PROVIDER/MR_NAME contains the MR value) or a
directory (/sys/kernel/tsm/MR_PROVIDER/MR_NAME/HASH/digest contains the MR
value) depending on whether `TSM_MR_F_F` is set or cleared (in
`tsm_measurement_register::mr_flags`). MR_NAME is the name
(`tsm_measurement_register::mr_name`) of the MR, while HASH is the hash
algorithm (`tsm_measurement_register::mr_hash`) name in the latter case.

*Crypto Agility* is supported by merging independent MRs with a common name
into a single directory, each represented by its HASH/digest file. Note
that HASH must be distinct or behavior is undefined.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
 MAINTAINERS                                |   2 +-
 drivers/virt/coco/Kconfig                  |  17 +-
 drivers/virt/coco/Makefile                 |   2 +
 drivers/virt/coco/{tsm.c => tsm-core.c}    |   6 +-
 drivers/virt/coco/tsm-mr.c                 | 383 +++++++++++++++++++++++++++++
 include/linux/tsm.h                        |  65 +++++
 7 files changed, 492 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-tsm b/Documentation/ABI/testing/sysfs-kernel-tsm
new file mode 100644
index 000000000000..99735cf4da5c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-tsm
@@ -0,0 +1,20 @@
+What:		/sys/kernel/tsm/<measurement_provider>/<register>
+Date:		February 2025
+Contact:	Cedric Xing <cedric.xing@intel.com>.
+Description:
+		This file contains the value of the measurement register
+		<register>. Depending on the CC architecture, this file may be
+		writable, in which case the value written will be the new value
+		of <register>. Each write must start at the beginning and be of
+		the same size as the file. Partial writes are not permitted.
+
+What:		/sys/kernel/tsm/<measurement_provider>/<register>/<hash>/digest
+Date:		February 2025
+Contact:	Cedric Xing <cedric.xing@intel.com>.
+Description:
+		This file contains the value of the measurement register
+		<register>. Depending on the CC architecture, this file may be
+		writable, in which case any value written may be extended to
+		<register> using <hash>. Each write must start at the beginning
+		and be of the same size as the file. Partial writes are not
+		permitted.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895..a5eef4c7234c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24104,7 +24104,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
-F:	drivers/virt/coco/tsm.c
+F:	drivers/virt/coco/tsm*.c
 F:	include/linux/tsm.h
 
 TRUSTED SERVICES TEE DRIVER
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index ff869d883d95..3fa38fd731b9 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -5,7 +5,22 @@
 
 config TSM_REPORTS
 	select CONFIGFS_FS
-	tristate
+	select CRYPTO_HASH_INFO
+	select CRYPTO
+	tristate "Trusted Security Module (TSM) support"
+
+if TSM_REPORTS
+
+config TSM_MR_MAXBANKS
+	int "Max number of banks of Measurement Registers"
+	range 1 8
+	default 1
+	help
+	  A "bank" is a group of MRs that use the same hash algorithm. This
+	  option specifies the maximal number of banks each Measurement
+	  Register (MR) can support.
+
+endif
 
 source "drivers/virt/coco/efi_secret/Kconfig"
 
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index c3d07cfc087e..4b108d8df1bd 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -2,6 +2,8 @@
 #
 # Confidential computing related collateral
 #
+tsm-y				+= tsm-core.o tsm-mr.o
+
 obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
 obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-core.c
similarity index 99%
rename from drivers/virt/coco/tsm.c
rename to drivers/virt/coco/tsm-core.c
index 9432d4e303f1..ab5269db9c13 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -476,6 +476,9 @@ int tsm_unregister(const struct tsm_ops *ops)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+int tsm_mr_init(void);
+void tsm_mr_exit(void);
+
 static struct config_group *tsm_report_group;
 
 static int __init tsm_init(void)
@@ -497,12 +500,13 @@ static int __init tsm_init(void)
 	}
 	tsm_report_group = tsm;
 
-	return 0;
+	return tsm_mr_init();
 }
 module_init(tsm_init);
 
 static void __exit tsm_exit(void)
 {
+	tsm_mr_exit();
 	configfs_unregister_default_group(tsm_report_group);
 	configfs_unregister_subsystem(&tsm_configfs);
 }
diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
new file mode 100644
index 000000000000..8a96b2a78869
--- /dev/null
+++ b/drivers/virt/coco/tsm-mr.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/hash_info.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/tsm.h>
+
+int tsm_mr_init(void);
+void tsm_mr_exit(void);
+
+enum tmr_dir_battr_index {
+	TMR_DIR_BA_DIGEST,
+	TMR_DIR_BA__COUNT,
+};
+
+struct tmr_dir {
+	struct kobject kobj;
+	struct bin_attribute battrs[CONFIG_TSM_MR_MAXBANKS][TMR_DIR_BA__COUNT];
+	int algo;
+};
+
+struct tmr_provider {
+	struct kset kset;
+	struct rw_semaphore rwsem;
+	struct bin_attribute *mrfiles;
+	struct tsm_measurement *tmr;
+	bool in_sync;
+};
+
+static inline struct tmr_provider *tmr_mr_to_provider(const struct tsm_measurement_register *mr,
+						      struct kobject *kobj)
+{
+	if (mr->mr_flags & TSM_MR_F_F)
+		return container_of(kobj, struct tmr_provider, kset.kobj);
+	else
+		return container_of(kobj->kset, struct tmr_provider, kset);
+}
+
+static inline int tmr_call_refresh(struct tmr_provider *pvd,
+				   const struct tsm_measurement_register *mr)
+{
+	int rc;
+
+	rc = pvd->tmr->refresh(pvd->tmr, mr);
+	if (rc)
+		pr_warn("%s.refresh(%s) failed %d\n", kobject_name(&pvd->kset.kobj), mr->mr_name,
+			rc);
+	return rc;
+}
+
+static inline int tmr_call_extend(struct tmr_provider *pvd,
+				  const struct tsm_measurement_register *mr, const u8 *data)
+{
+	int rc;
+
+	rc = pvd->tmr->extend(pvd->tmr, mr, data);
+	if (rc)
+		pr_warn("%s.extend(%s) failed %d\n", kobject_name(&pvd->kset.kobj), mr->mr_name,
+			rc);
+	return rc;
+}
+
+static ssize_t tmr_digest_read(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
+			       char *buffer, loff_t off, size_t count)
+{
+	const struct tsm_measurement_register *mr;
+	struct tmr_provider *pvd;
+	int rc;
+
+	if (off < 0 || off > attr->size)
+		return -EINVAL;
+
+	count = min(count, attr->size - (size_t)off);
+	if (!count)
+		return count;
+
+	mr = attr->private;
+	pvd = tmr_mr_to_provider(mr, kobj);
+	rc = down_read_interruptible(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	/*
+	 * pvd->in_sync indicates if any MRs have been written/extended since the last
+	 * pvd->refresh() call. When pvd->in_sync is false, pvd->refresh() is necessary to sync the
+	 * cached values of all live (L) MRs with the underlying hardware.
+	 */
+	if ((mr->mr_flags & TSM_MR_F_L) && !pvd->in_sync) {
+		up_read(&pvd->rwsem);
+
+		rc = down_write_killable(&pvd->rwsem);
+		if (rc)
+			return rc;
+
+		if (!pvd->in_sync) {
+			rc = tmr_call_refresh(pvd, mr);
+			pvd->in_sync = !rc;
+		}
+
+		downgrade_write(&pvd->rwsem);
+	}
+
+	if (!rc)
+		memcpy(buffer, mr->mr_value + off, count);
+
+	up_read(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static ssize_t tmr_digest_write(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
+				char *buffer, loff_t off, size_t count)
+{
+	const struct tsm_measurement_register *mr;
+	struct tmr_provider *pvd;
+	ssize_t rc;
+
+	if (off != 0 || count != attr->size)
+		return -EINVAL;
+
+	mr = attr->private;
+	pvd = tmr_mr_to_provider(mr, kobj);
+	rc = down_write_killable(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	if (mr->mr_flags & TSM_MR_F_X)
+		rc = tmr_call_extend(pvd, mr, buffer);
+	else
+		memcpy(mr->mr_value, buffer, count);
+
+	// clear pvd->in_sync so the next read from any live (L) MR will trigger pvd->refresh()
+	if (!rc)
+		pvd->in_sync = false;
+
+	up_write(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static void tmr_dir_release(struct kobject *kobj)
+{
+	struct tmr_dir *mrd;
+
+	mrd = container_of(kobj, typeof(*mrd), kobj);
+	kfree(mrd);
+}
+
+static const struct kobj_type tmr_dir_ktype = {
+	.release = tmr_dir_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct tmr_dir *tmr_dir_create(const struct tsm_measurement_register *mr,
+				      struct tmr_provider *pvd)
+{
+	struct kobject *kobj;
+	struct tmr_dir *mrd;
+
+	kobj = kset_find_obj(&pvd->kset, mr->mr_name);
+	if (kobj) {
+		mrd = container_of(kobj, typeof(*mrd), kobj);
+		kobject_put(kobj);
+		if (++mrd->algo >= CONFIG_TSM_MR_MAXBANKS) {
+			--mrd->algo;
+			return ERR_PTR(-ENOSPC);
+		}
+	} else {
+		int rc;
+
+		mrd = kzalloc(sizeof(*mrd), GFP_KERNEL);
+		if (!mrd)
+			return ERR_PTR(-ENOMEM);
+
+		mrd->kobj.kset = &pvd->kset;
+		rc = kobject_init_and_add(&mrd->kobj, &tmr_dir_ktype, NULL, "%s", mr->mr_name);
+		if (rc) {
+			kfree(mrd);
+			return ERR_PTR(rc);
+		}
+	}
+
+	sysfs_bin_attr_init(&mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST]);
+	mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.name = "digest";
+	if (mr->mr_flags & TSM_MR_F_W)
+		mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.mode |= S_IWUSR | S_IWGRP;
+	if (mr->mr_flags & TSM_MR_F_R)
+		mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.mode |= S_IRUGO;
+
+	mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].size = mr->mr_size;
+	mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].read = tmr_digest_read;
+	mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].write = tmr_digest_write;
+	mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].private = (void *)mr;
+
+	return mrd;
+}
+
+static void tmr_provider_release(struct kobject *kobj)
+{
+	struct tmr_provider *pvd;
+
+	pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	if (!WARN_ON(!list_empty(&pvd->kset.list))) {
+		kfree(pvd->mrfiles);
+		kfree(pvd);
+	}
+}
+
+static const struct kobj_type _mr_provider_ktype = {
+	.release = tmr_provider_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct kset *tmr_sysfs_root;
+
+static struct tmr_provider *tmr_provider_create(struct tsm_measurement *tmr)
+{
+	struct tmr_provider *pvd __free(kfree);
+	int rc;
+
+	pvd = kzalloc(sizeof(*pvd), GFP_KERNEL);
+	if (!pvd)
+		return ERR_PTR(-ENOMEM);
+
+	if (!tmr->name || !tmr->mrs || !tmr->refresh || !tmr->extend)
+		return ERR_PTR(-EINVAL);
+
+	rc = kobject_set_name(&pvd->kset.kobj, "%s", tmr->name);
+	if (rc)
+		return ERR_PTR(rc);
+
+	pvd->kset.kobj.kset = tmr_sysfs_root;
+	pvd->kset.kobj.ktype = &_mr_provider_ktype;
+	pvd->tmr = tmr;
+
+	init_rwsem(&pvd->rwsem);
+
+	rc = kset_register(&pvd->kset);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(pvd);
+}
+
+DEFINE_FREE(_unregister_measurement, struct tmr_provider *,
+	    if (!IS_ERR_OR_NULL(_T)) tsm_unregister_measurement(_T->tmr));
+
+int tsm_register_measurement(struct tsm_measurement *tmr)
+{
+	struct tmr_provider *pvd __free(_unregister_measurement);
+	int rc, nr;
+
+	pvd = tmr_provider_create(tmr);
+	if (IS_ERR(pvd))
+		return PTR_ERR(pvd);
+
+	nr = 0;
+	for (int i = 0; tmr->mrs[i].mr_name; ++i) {
+		// flat files are counted and skipped
+		if (tmr->mrs[i].mr_flags & TSM_MR_F_F) {
+			++nr;
+			continue;
+		}
+
+		struct tmr_dir *mrd;
+		struct bin_attribute *battrs[TMR_DIR_BA__COUNT + 1] = {};
+		struct attribute_group agrp = {
+			.name = hash_algo_name[tmr->mrs[i].mr_hash],
+			.bin_attrs = battrs,
+		};
+
+		mrd = tmr_dir_create(&tmr->mrs[i], pvd);
+		if (IS_ERR(mrd)) {
+			if (WARN_ONCE(PTR_ERR(mrd) == -ENOSPC, "too many banks"))
+				continue;
+
+			return PTR_ERR(mrd);
+		}
+
+		for (int j = 0; j < TMR_DIR_BA__COUNT; ++j)
+			battrs[j] = &mrd->battrs[mrd->algo][j];
+
+		rc = sysfs_create_group(&mrd->kobj, &agrp);
+		if (rc)
+			return rc;
+	}
+
+	if (nr > 0) {
+		struct bin_attribute *mrfiles __free(kfree);
+		struct bin_attribute **battrs __free(kfree);
+
+		mrfiles = kcalloc(nr, sizeof(*mrfiles), GFP_KERNEL);
+		battrs = kcalloc(nr + 1, sizeof(*battrs), GFP_KERNEL);
+		if (!battrs || !mrfiles)
+			return -ENOMEM;
+
+		for (int i = 0, j = 0; tmr->mrs[i].mr_name; ++i) {
+			if (!(tmr->mrs[i].mr_flags & TSM_MR_F_F))
+				continue;
+
+			mrfiles[j].attr.name = tmr->mrs[i].mr_name;
+			mrfiles[j].read = tmr_digest_read;
+			mrfiles[j].write = tmr_digest_write;
+			mrfiles[j].size = tmr->mrs[i].mr_size;
+			mrfiles[j].private = (void *)&tmr->mrs[i];
+			if (tmr->mrs[i].mr_flags & TSM_MR_F_R)
+				mrfiles[j].attr.mode |= S_IRUGO;
+			if (tmr->mrs[i].mr_flags & TSM_MR_F_W)
+				mrfiles[j].attr.mode |= S_IWUSR | S_IWGRP;
+
+			battrs[j] = &mrfiles[j];
+			++j;
+		}
+
+		struct attribute_group agrp = {
+			.bin_attrs = battrs,
+		};
+		rc = sysfs_create_group(&pvd->kset.kobj, &agrp);
+		if (rc)
+			return rc;
+
+		pvd->mrfiles = no_free_ptr(mrfiles);
+	}
+
+	// initial refresh of MRs
+	rc = tmr_call_refresh(pvd, NULL);
+	pvd->in_sync = !rc;
+
+	pvd = NULL; // to avoid being freed automatically
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_register_measurement);
+
+static void tmr_put_children(struct kset *kset)
+{
+	struct kobject *p, *n;
+
+	spin_lock(&kset->list_lock);
+	list_for_each_entry_safe(p, n, &kset->list, entry) {
+		spin_unlock(&kset->list_lock);
+		kobject_put(p);
+		spin_lock(&kset->list_lock);
+	}
+	spin_unlock(&kset->list_lock);
+}
+
+int tsm_unregister_measurement(struct tsm_measurement *tmr)
+{
+	struct kobject *kobj;
+	struct tmr_provider *pvd;
+
+	kobj = kset_find_obj(tmr_sysfs_root, tmr->name);
+	if (!kobj)
+		return -ENOENT;
+
+	pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	if (pvd->tmr != tmr)
+		return -EINVAL;
+
+	tmr_put_children(&pvd->kset);
+	kset_unregister(&pvd->kset);
+	kobject_put(kobj);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister_measurement);
+
+int tsm_mr_init(void)
+{
+	tmr_sysfs_root = kset_create_and_add("tsm", NULL, kernel_kobj);
+	if (!tmr_sysfs_root)
+		return -ENOMEM;
+	return 0;
+}
+
+void tsm_mr_exit(void)
+{
+	kset_unregister(tmr_sysfs_root);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Provide Trusted Security Module measurements via sysfs");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 11b0c525be30..312965d45001 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <uapi/linux/hash_info.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,68 @@ struct tsm_ops {
 
 int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
+
+/**
+ * struct tsm_measurement_register - describes an architectural measurement register (MR)
+ * @mr_name: name of the MR
+ * @mr_value: buffer containing the current value of the MR
+ * @mr_size: size of the MR - typically the digest size of @mr_hash
+ * @mr_flags: bitwise OR of flags defined in enum tsm_measurement_register_flag
+ * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h
+ *
+ * A CC guest driver provides this structure to detail the measurement facility supported by the
+ * underlying CC hardware. After registration via `tsm_register_measurement`, the CC guest driver
+ * must retain this structure until it is unregistered using `tsm_unregister_measurement`.
+ */
+struct tsm_measurement_register {
+	const char *mr_name;
+	void *mr_value;
+	u32 mr_size;
+	u32 mr_flags;
+	enum hash_algo mr_hash;
+};
+
+/**
+ * enum tsm_measurement_register_flag - properties of an MR
+ * @TSM_MR_F_X: this MR supports the extension semantics
+ * @TSM_MR_F_W: the sysfs attribute corresponding to this MR is writable
+ * @TSM_MR_F_R: the sysfs attribute corresponding to this MR is readable
+ * @TSM_MR_F_L: this MR is live - the current value may differ from the last value written so must
+ *              be loaded back from TVM hardware/firmware on read
+ * @TSM_MR_F_F: present this MR as a file (instead of a directory)
+ * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
+ * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
+ */
+enum tsm_measurement_register_flag {
+	TSM_MR_F_X = 1,
+	TSM_MR_F_W = 2,
+	TSM_MR_F_R = 4,
+	TSM_MR_F_L = 8,
+	TSM_MR_F_F = 16,
+	TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
+	TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
+};
+
+#define TSM_MR_(mr, hash)                                                           \
+	.mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, .mr_hash = HASH_ALGO_##hash, \
+	.mr_flags = TSM_MR_F_R
+
+/**
+ * struct tsm_measurement - define CC specific MRs and methods for updating them
+ * @name: name of the measurement provider
+ * @mrs: array of MR definitions ending with mr_name set to %NULL
+ * @refresh: sync/reload MR values in TVM hardware/firmware into the kernel buffers
+ * @extend: extend the specified MR with mr->mr_size bytes stored in mr->mr_value
+ */
+struct tsm_measurement {
+	const char *name;
+	const struct tsm_measurement_register *mrs;
+	int (*refresh)(struct tsm_measurement *tmr, const struct tsm_measurement_register *mr);
+	int (*extend)(struct tsm_measurement *tmr, const struct tsm_measurement_register *mr,
+		      const u8 *data);
+};
+
+int tsm_register_measurement(struct tsm_measurement *tmr);
+int tsm_unregister_measurement(struct tsm_measurement *tmr);
+
 #endif /* __TSM_H */

-- 
2.43.0



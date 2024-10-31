Return-Path: <linux-kernel+bounces-390963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091449B8096
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815841F2212E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399581BE235;
	Thu, 31 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDXznjOF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8CA1B5ED6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393452; cv=none; b=l9jwfEzOM9uap3Nq4ksain7qEcRveJk4hDNPuL2mug8cDv0bW+9+J+jNgDivtA5eCXsFSAQZj4KJu9loiyAvScO2sf6rJCOGtOCvzoMz5Q/D35XXzJpEPZ22HrYmMOCX02Lq/vO6HFJDdBFriuQPyWV2wxe2mUmpOxCwmS9N4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393452; c=relaxed/simple;
	bh=q59xsDFESxWB8f85RsK4byfthxqa6imbWXHUx36bksc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1Ptplw/ARPyPHG4LOEX8d7tnOyOIlF06LEVoNNGdx7JAAOj9sAqoqR79jB42SzletEbHUxsOt8zCzfP1sThwKq96Ue5m3ppkc3nytcmvDdfqUK9R/sxhlRuYa/eF/qCgc90kVJE4neBfKU1SCWozOXkYP9rtoI1GC7TvMfbmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDXznjOF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730393450; x=1761929450;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q59xsDFESxWB8f85RsK4byfthxqa6imbWXHUx36bksc=;
  b=PDXznjOFWskX0r2am0Jmeyo/PZbxofqFzQ9OmXNlknmppgtd9AIZgcWY
   90eI25LLIcoWoCWQ2/Zn0PYdzPJVcGm9lB4MIln1DcLoV5S/ts4d7X1Tr
   mWCUONlx4IKEQaKPP7wzAHEbsehGcJ2dF+5rk4mlEY5VUuF8xSZ6FJY3N
   RrOaDvitVJHtXS0lMZlmTzXBtpeDTkxm/Q+2ehWpjFplMmeAI8KelIqhK
   4hXmDVwvchi+lA2F4ylVndS28I2uFYAj6NilPgI7okqvRJ8mapwSi53Ri
   3ZwfTQ9ORqnRjUYyyRazzlWqAOG4FSgowo+tNG2lJvjKbIYU1yIPW3y1+
   Q==;
X-CSE-ConnectionGUID: HWf0R3/uTcK1gce0dPG96g==
X-CSE-MsgGUID: pjTiOS89RmS2uyr/oc8puA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30312370"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30312370"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:48 -0700
X-CSE-ConnectionGUID: jSH/ZRi5R62p/IOS/IrqdQ==
X-CSE-MsgGUID: LsCHbWAMTFKXlykmDpN0lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82217188"
Received: from eschuber-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.125.64.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:46 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Thu, 31 Oct 2024 11:50:40 -0500
Subject: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
In-Reply-To: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Qinkun Bao <qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
X-Mailer: b4 0.13.0

This commit extends the TSM core with support for CC measurement registers
(MRs).

The newly added APIs are:

- `tsm_register_measurement(struct tsm_measurement *)`
  This function allows a CC guest driver to register a set of measurement
  registers with the TSM core.
- `tsm_unregister_measurement(struct tsm_measurement *)`:
  This function enables a CC guest driver to unregister a previously registered
  set of measurement registers.

`struct tsm_measurement` has been defined to encapsulate the details of
CC-specific MRs. It includes an array of `struct tsm_measurement_register`s and
provides operations for reading and updating these registers. For a
comprehensive understanding of the structure and its usage, refer to the
detailed comments added in `include/linux/tsm.h`.

Upon successful registration of a measurement provider, the TSM core exposes
the MRs through a directory tree in the sysfs filesystem. The root of this tree
is located at `/sys/kernel/tsm/<MR provider>/`, with `<MR provider>` being the
name of the measurement provider. Each MR is made accessible as either a
file or a directory, named after the MR itself. In the former case, the file
content is the MR value, while in the latter case there will be two files in
the directory: `digest` and `hash_algo`. The purpose and content of these files
are self-explanatory.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 drivers/virt/coco/Kconfig               |   3 +-
 drivers/virt/coco/Makefile              |   2 +
 drivers/virt/coco/{tsm.c => tsm-core.c} |  26 ++-
 drivers/virt/coco/tsm-mr.c              | 374 ++++++++++++++++++++++++++++++++
 4 files changed, 394 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index d9ff676bf48d..0609622cbcb9 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -5,7 +5,8 @@
 
 config TSM_REPORTS
 	select CONFIGFS_FS
-	tristate
+	select CRYPTO_HASH_INFO
+	tristate "Trusted Security Module (TSM) sysfs/configfs support"
 
 source "drivers/virt/coco/efi_secret/Kconfig"
 
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index b69c30c1c720..8192d78dff61 100644
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
similarity index 95%
rename from drivers/virt/coco/tsm.c
rename to drivers/virt/coco/tsm-core.c
index 9432d4e303f1..92e961f21507 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm-core.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/tsm.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -166,8 +164,9 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
 }
 CONFIGFS_ATTR_WO(tsm_report_, service_guid);
 
-static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
-							 const char *buf, size_t len)
+static ssize_t
+tsm_report_service_manifest_version_store(struct config_item *cfg,
+					  const char *buf, size_t len)
 {
 	struct tsm_report *report = to_tsm_report(cfg);
 	unsigned int val;
@@ -187,8 +186,8 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
 }
 CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
 
-static ssize_t tsm_report_inblob_write(struct config_item *cfg,
-				       const void *buf, size_t count)
+static ssize_t tsm_report_inblob_write(struct config_item *cfg, const void *buf,
+				       size_t count)
 {
 	struct tsm_report *report = to_tsm_report(cfg);
 	int rc;
@@ -341,7 +340,8 @@ static struct configfs_attribute *tsm_report_attrs[] = {
 	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	[TSM_REPORT_SERVICE_PROVIDER] = &tsm_report_attr_service_provider,
 	[TSM_REPORT_SERVICE_GUID] = &tsm_report_attr_service_guid,
-	[TSM_REPORT_SERVICE_MANIFEST_VER] = &tsm_report_attr_service_manifest_version,
+	[TSM_REPORT_SERVICE_MANIFEST_VER] =
+		&tsm_report_attr_service_manifest_version,
 	NULL,
 };
 
@@ -383,7 +383,8 @@ static bool tsm_report_is_visible(struct config_item *item,
 }
 
 static bool tsm_report_is_bin_visible(struct config_item *item,
-				      struct configfs_bin_attribute *attr, int n)
+				      struct configfs_bin_attribute *attr,
+				      int n)
 {
 	guard(rwsem_read)(&tsm_rwsem);
 	if (!provider.ops)
@@ -478,6 +479,9 @@ EXPORT_SYMBOL_GPL(tsm_unregister);
 
 static struct config_group *tsm_report_group;
 
+extern int tsm_mr_init(void);
+extern void tsm_mr_exit(void);
+
 static int __init tsm_init(void)
 {
 	struct config_group *root = &tsm_configfs.su_group;
@@ -497,16 +501,18 @@ static int __init tsm_init(void)
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
 module_exit(tsm_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
+MODULE_DESCRIPTION(
+	"Provide Trusted Security Module attestation reports via configfs");
diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
new file mode 100644
index 000000000000..a84e923a7782
--- /dev/null
+++ b/drivers/virt/coco/tsm-mr.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#include <linux/tsm.h>
+#include <linux/shmem_fs.h>
+#include <linux/ctype.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+int tsm_mr_init(void);
+void tsm_mr_exit(void);
+
+enum _mrdir_bin_attr_index {
+	_MRDIR_BA_DIGEST,
+	_MRDIR_BA__COUNT,
+};
+
+struct _mrdir {
+	struct kobject kobj;
+	struct bin_attribute battrs[_MRDIR_BA__COUNT];
+};
+
+struct _mr_provider {
+	struct kset kset;
+	struct rw_semaphore rwsem;
+	struct bin_attribute *mrfiles;
+	struct tsm_measurement *tmr;
+	bool in_sync;
+};
+
+static inline const struct tsm_measurement_register *
+_mrdir_mr(const struct _mrdir *mrd)
+{
+	return (struct tsm_measurement_register *)mrd->battrs[_MRDIR_BA_DIGEST]
+		.private;
+}
+
+static inline struct _mr_provider *
+_mr_to_provider(const struct tsm_measurement_register *mr, struct kobject *kobj)
+{
+	if (mr->mr_flags & TSM_MR_F_F)
+		return container_of(kobj, struct _mr_provider, kset.kobj);
+	else
+		return container_of(kobj->kset, struct _mr_provider, kset);
+}
+
+static inline int _call_refresh(struct _mr_provider *pvd,
+				const struct tsm_measurement_register *mr)
+{
+	int rc = pvd->tmr->refresh(pvd->tmr, mr);
+	if (rc)
+		pr_warn(KBUILD_MODNAME ": %s.extend(%s) failed %d\n",
+			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+	return rc;
+}
+
+static inline int _call_extend(struct _mr_provider *pvd,
+			       const struct tsm_measurement_register *mr,
+			       const u8 *data)
+{
+	int rc = pvd->tmr->extend(pvd->tmr, mr, data);
+	if (rc)
+		pr_warn(KBUILD_MODNAME ": %s.extend(%s) failed %d\n",
+			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+	return rc;
+}
+
+static ssize_t hash_algo_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *page)
+{
+	struct _mrdir *mrd;
+	mrd = container_of(kobj, typeof(*mrd), kobj);
+	return sysfs_emit(page, "%s", hash_algo_name[_mrdir_mr(mrd)->mr_hash]);
+}
+
+static ssize_t _mr_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *attr, char *page, loff_t off,
+			size_t count)
+{
+	const struct tsm_measurement_register *mr;
+	struct _mr_provider *pvd;
+	int rc;
+
+	if (off < 0 || off > attr->size)
+		return -EINVAL;
+
+	count = min(count, attr->size - (size_t)off);
+	if (!count)
+		return count;
+
+	mr = (typeof(mr))attr->private;
+	BUG_ON(mr->mr_size != attr->size);
+
+	pvd = _mr_to_provider(mr, kobj);
+	rc = down_read_interruptible(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	if ((mr->mr_flags & TSM_MR_F_L) && !pvd->in_sync) {
+		up_read(&pvd->rwsem);
+
+		rc = down_write_killable(&pvd->rwsem);
+		if (rc)
+			return rc;
+
+		if (!pvd->in_sync) {
+			rc = _call_refresh(pvd, mr);
+			pvd->in_sync = !rc;
+		}
+
+		downgrade_write(&pvd->rwsem);
+	}
+
+	if (!rc)
+		memcpy(page, mr->mr_value + off, count);
+	else
+		pr_debug(KBUILD_MODNAME ": %s.refresh(%s)=%d\n",
+			 kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+
+	up_read(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static ssize_t _mr_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *attr, char *page, loff_t off,
+			 size_t count)
+{
+	const struct tsm_measurement_register *mr;
+	struct _mr_provider *pvd;
+	ssize_t rc;
+
+	if (off != 0 || count != attr->size)
+		return -EINVAL;
+
+	mr = (typeof(mr))attr->private;
+	BUG_ON(mr->mr_size != attr->size);
+
+	pvd = _mr_to_provider(mr, kobj);
+	rc = down_write_killable(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	if (mr->mr_flags & TSM_MR_F_X)
+		rc = _call_extend(pvd, mr, page);
+	else
+		memcpy(mr->mr_value, page, count);
+
+	if (!rc)
+		pvd->in_sync = false;
+
+	up_write(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static void _mrdir_release(struct kobject *kobj)
+{
+	struct _mrdir *mrd;
+	mrd = container_of(kobj, typeof(*mrd), kobj);
+	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
+	kfree(mrd);
+}
+
+static struct kobj_type _mrdir_ktype = {
+	.release = _mrdir_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct _mrdir *_mrdir_create(const struct tsm_measurement_register *mr,
+				    struct _mr_provider *pvd)
+{
+	struct _mrdir *mrd __free(kfree);
+	int rc;
+
+	BUG_ON(mr->mr_flags & TSM_MR_F_F);
+	mrd = kzalloc(sizeof(*mrd), GFP_KERNEL);
+	if (!mrd)
+		return ERR_PTR(-ENOMEM);
+
+	sysfs_bin_attr_init(&mrd->battrs[_MRDIR_BA_DIGEST]);
+	mrd->battrs[_MRDIR_BA_DIGEST].attr.name = "digest";
+	if (mr->mr_flags & TSM_MR_F_W)
+		mrd->battrs[_MRDIR_BA_DIGEST].attr.mode |= S_IWUSR | S_IWGRP;
+	if (mr->mr_flags & TSM_MR_F_R)
+		mrd->battrs[_MRDIR_BA_DIGEST].attr.mode |= S_IRUGO;
+
+	mrd->battrs[_MRDIR_BA_DIGEST].size = mr->mr_size;
+	mrd->battrs[_MRDIR_BA_DIGEST].read = _mr_read;
+	mrd->battrs[_MRDIR_BA_DIGEST].write = _mr_write;
+	mrd->battrs[_MRDIR_BA_DIGEST].private = (void *)mr;
+
+	mrd->kobj.kset = &pvd->kset;
+	rc = kobject_init_and_add(&mrd->kobj, &_mrdir_ktype, NULL, "%s",
+				  mr->mr_name);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(mrd);
+}
+
+static void _mr_provider_release(struct kobject *kobj)
+{
+	struct _mr_provider *pvd;
+	pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
+	BUG_ON(!list_empty(&pvd->kset.list));
+	kfree(pvd->mrfiles);
+	kfree(pvd);
+}
+
+static struct kobj_type _mr_provider_ktype = {
+	.release = _mr_provider_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct kset *_sysfs_tsm;
+
+static struct _mr_provider *_mr_provider_create(struct tsm_measurement *tmr)
+{
+	struct _mr_provider *pvd __free(kfree);
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
+	pvd->kset.kobj.kset = _sysfs_tsm;
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
+DEFINE_FREE(_unregister_measurement, struct _mr_provider *,
+	    if (!IS_ERR_OR_NULL(_T)) tsm_unregister_measurement(_T->tmr));
+
+int tsm_register_measurement(struct tsm_measurement *tmr)
+{
+	static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
+
+	struct _mr_provider *pvd __free(_unregister_measurement);
+	int rc, nr;
+
+	pvd = _mr_provider_create(tmr);
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
+		struct _mrdir *mrd = _mrdir_create(&tmr->mrs[i], pvd);
+		if (IS_ERR(mrd))
+			return PTR_ERR(mrd);
+
+		struct attribute *attrs[] = {
+			&_attr_hash.attr,
+			NULL,
+		};
+		struct bin_attribute *battrs[_MRDIR_BA__COUNT + 1] = {};
+		for (int j = 0; j < _MRDIR_BA__COUNT; ++j)
+			battrs[j] = &mrd->battrs[j];
+		struct attribute_group agrp = {
+			.attrs = attrs,
+			.bin_attrs = battrs,
+		};
+		rc = sysfs_create_group(&mrd->kobj, &agrp);
+		if (rc)
+			return rc;
+	}
+
+	if (nr > 0) {
+		struct bin_attribute *mrfiles __free(kfree);
+		struct bin_attribute **battrs __free(kfree);
+
+		mrfiles = kcalloc(sizeof(*mrfiles), nr, GFP_KERNEL);
+		battrs = kcalloc(sizeof(*battrs), nr + 1, GFP_KERNEL);
+		if (!battrs || !mrfiles)
+			return -ENOMEM;
+
+		for (int i = 0, j = 0; tmr->mrs[i].mr_name; ++i) {
+			if (!(tmr->mrs[i].mr_flags & TSM_MR_F_F))
+				continue;
+
+			mrfiles[j].attr.name = tmr->mrs[i].mr_name;
+			mrfiles[j].read = _mr_read;
+			mrfiles[j].write = _mr_write;
+			mrfiles[j].size = tmr->mrs[i].mr_size;
+			mrfiles[j].private = (void *)&tmr->mrs[i];
+			if (tmr->mrs[i].mr_flags & TSM_MR_F_R)
+				mrfiles[j].attr.mode |= S_IRUGO;
+			if (tmr->mrs[i].mr_flags & TSM_MR_F_W)
+				mrfiles[j].attr.mode |= S_IWUSR | S_IWGRP;
+
+			battrs[j] = &mrfiles[j];
+			++j;
+
+			BUG_ON(j > nr);
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
+	pvd = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_register_measurement);
+
+static void _kset_put_children(struct kset *kset)
+{
+	struct kobject *p, *n;
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
+	struct kobject *kobj = kset_find_obj(_sysfs_tsm, tmr->name);
+	if (!kobj)
+		return -ENOENT;
+
+	struct _mr_provider *pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	BUG_ON(pvd->tmr != tmr);
+
+	_kset_put_children(&pvd->kset);
+	kset_unregister(&pvd->kset);
+	kobject_put(kobj);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister_measurement);
+
+int tsm_mr_init(void)
+{
+	_sysfs_tsm = kset_create_and_add("tsm", NULL, kernel_kobj);
+	if (!_sysfs_tsm)
+		return -ENOMEM;
+	return 0;
+}
+
+void tsm_mr_exit(void)
+{
+	kset_unregister(_sysfs_tsm);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Provide Trusted Security Module measurements via sysfs");

-- 
2.43.0



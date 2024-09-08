Return-Path: <linux-kernel+bounces-320017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F1970519
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1A7B2213C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4557028EC;
	Sun,  8 Sep 2024 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHITgpZm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012483A1B6
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725771473; cv=none; b=qyp4+ChjdDX7ZWYFjc84wVqzgjH1jUIxG7j/tiw1Ia7LUIHmzS11wnWptUGDr/tu99wgj2KDLftiklocwignzlJU999jY+JiVb7nhjC3AvS3IRFWBEYComAuSzlwfoQSW/sdayfi/PusCXqJYPa5bQA+EIJ1byGqDK/h0EPp3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725771473; c=relaxed/simple;
	bh=xD/sz73bewgKRorRh4MBtS0BXrpfPei7LS5GZqG3Qnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QXok5e5J4gOQG9CERuE4dTgYyCpmBifsXyeZxFNAIiA+3Xt6ugyNwFbNue7ER5paWpNHATexDsHJEzuEyaoZCPc14F1YQA+jIlNdd04ziJH2DQKKSZC1d15pyOo1RqjJ/8O2Y7UGF0Q5OPmpQOhsWSsQIzOqsXBwIme2UBA32TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHITgpZm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725771471; x=1757307471;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xD/sz73bewgKRorRh4MBtS0BXrpfPei7LS5GZqG3Qnc=;
  b=VHITgpZmNZ8cZWCKnZ9wl9WjxT3SQqooV/dzCLK21M0CfPZGULj0r228
   vExgRz0rZwgiu9ScPmXFM0BtFiNAy8z+CZVEu3iSQOlGhGc3fnAMRhBHe
   Gdmkw6PmvE5vX6XrQjfTUTmtnTy68CZ74ghquQu20y1Q/N5q4HNEU3PvD
   vSjnkBjXTvY5A8kMckWKxovH4t2UyA0jM41WH+CFrRuodlFOc9prkfsoe
   JPEN7+0iJnnSAJPWuBruLdyUNqJQ5X4KtGe17Pjw7C3Y4UDNy7isZOAW+
   KKSuVvFMTRdWE1vTCUABP/6kgtb+B7gDe3p9gdkuUL0b6Vlw5+Kh4hylD
   A==;
X-CSE-ConnectionGUID: EtC11KrwSgqLrj2qC4duzQ==
X-CSE-MsgGUID: 1r/Ggk4EQIi/Cf8LvnaFlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35152166"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="35152166"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:49 -0700
X-CSE-ConnectionGUID: j/a+WePbQnm4kUd7hfMlsg==
X-CSE-MsgGUID: k7Y5I/V7Slmbl7UuTRPgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70924657"
Received: from ibarbour-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.49])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:49 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Sat, 07 Sep 2024 23:56:19 -0500
Subject: [PATCH RFC 1/3] tsm: Add TVM Measurement Register Support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-tsm-rtmr-v1-1-12fc4d43d4e7@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
In-Reply-To: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
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

- `tsm_register_measurement_provider(struct tsm_measurement_provider *)`
  This function allows a CC guest driver to register a set of measurement
  registers with the TSM core.
- `tsm_unregister_measurement_provider(struct tsm_measurement_provider *)`:
  This function enables a CC guest driver to unregister a previously registered
  set of measurement registers.

The `struct tsm_measurement_provider` has been defined to encapsulate the
details of CC-specific MRs. It includes an array of
`struct tsm_measurement_register`s and provides operations for reading and
updating these registers. For a comprehensive understanding of the structure
and its usage, refer to the detailed comments added in `include/linux/tsm.h`.

Upon successful registration of a measurement provider, the TSM core exposes
the MRs through a directory tree in the sysfs filesystem. The root of this tree
is located at `/sys/kernel/tsm/<MR provider>/`, with `<MR provider>` being the
name of the measurement provider. Each static MR is made accessible as a
read-only file, named after the MR itself. Runtime MRs (RTMRs) are represented
as directories named after the RTMR, containing two files: `digest` and
`hash_algo`. The purpose and content of these files are self-explanatory.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 drivers/virt/coco/Kconfig |   4 +-
 drivers/virt/coco/tsm.c   | 390 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/tsm.h       |  62 ++++++++
 3 files changed, 446 insertions(+), 10 deletions(-)

diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index 87d142c1f932..0ce23c8d5854 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -5,7 +5,9 @@
 
 config TSM_REPORTS
 	select CONFIGFS_FS
-	tristate
+	select SYSFS
+	select CRYPTO_HASH_INFO
+	tristate "Trusted Security Module (TSM) sysfs/configfs support"
 
 source "drivers/virt/coco/efi_secret/Kconfig"
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 9432d4e303f1..e83143f22fad 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/tsm.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -11,6 +9,8 @@
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/configfs.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
@@ -166,8 +166,9 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
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
@@ -187,8 +188,8 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
 }
 CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
 
-static ssize_t tsm_report_inblob_write(struct config_item *cfg,
-				       const void *buf, size_t count)
+static ssize_t tsm_report_inblob_write(struct config_item *cfg, const void *buf,
+				       size_t count)
 {
 	struct tsm_report *report = to_tsm_report(cfg);
 	int rc;
@@ -341,7 +342,8 @@ static struct configfs_attribute *tsm_report_attrs[] = {
 	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	[TSM_REPORT_SERVICE_PROVIDER] = &tsm_report_attr_service_provider,
 	[TSM_REPORT_SERVICE_GUID] = &tsm_report_attr_service_guid,
-	[TSM_REPORT_SERVICE_MANIFEST_VER] = &tsm_report_attr_service_manifest_version,
+	[TSM_REPORT_SERVICE_MANIFEST_VER] =
+		&tsm_report_attr_service_manifest_version,
 	NULL,
 };
 
@@ -383,7 +385,8 @@ static bool tsm_report_is_visible(struct config_item *item,
 }
 
 static bool tsm_report_is_bin_visible(struct config_item *item,
-				      struct configfs_bin_attribute *attr, int n)
+				      struct configfs_bin_attribute *attr,
+				      int n)
 {
 	guard(rwsem_read)(&tsm_rwsem);
 	if (!provider.ops)
@@ -476,7 +479,370 @@ int tsm_unregister(const struct tsm_ops *ops)
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
 
+enum _rtmr_bin_attr_index {
+	_RTMR_BATTR_DIGEST,
+	_RTMR_BATTR__COUNT,
+};
+
+struct _rtmr {
+	struct kobject kobj;
+	struct bin_attribute battrs[_RTMR_BATTR__COUNT];
+};
+
+struct _mr_provider {
+	struct kset kset;
+	struct rw_semaphore rwsem;
+	struct bin_attribute *static_mrs;
+	struct tsm_measurement_provider *provider;
+	bool in_sync;
+};
+
+static inline const struct tsm_measurement_register *
+_rtmr_mr(const struct _rtmr *rtmr)
+{
+	return (struct tsm_measurement_register *)rtmr
+		->battrs[_RTMR_BATTR_DIGEST]
+		.private;
+}
+
+static inline struct _mr_provider *
+_mr_to_group(const struct tsm_measurement_register *mr, struct kobject *kobj)
+{
+	if (!(mr->mr_flags & TSM_MR_F_X))
+		return container_of(kobj, struct _mr_provider, kset.kobj);
+	else
+		return container_of(kobj->kset, struct _mr_provider, kset);
+}
+
+static inline int _call_refresh(struct _mr_provider *pvd,
+				const struct tsm_measurement_register *mr)
+{
+	int rc = pvd->provider->refresh(pvd->provider, mr);
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
+	int rc = pvd->provider->extend(pvd->provider, mr, data);
+	if (rc)
+		pr_warn(KBUILD_MODNAME ": %s.extend(%s) failed %d\n",
+			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+	return rc;
+}
+
+static ssize_t hash_algo_show(struct kobject *kobj, struct kobj_attribute *attr,
+			      char *page)
+{
+	struct _rtmr *rtmr;
+	rtmr = container_of(kobj, typeof(*rtmr), kobj);
+	return sysfs_emit(page, "%s", hash_algo_name[_rtmr_mr(rtmr)->mr_hash]);
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
+	pvd = _mr_to_group(mr, kobj);
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
+		pr_debug(KBUILD_MODNAME ": refresh(%s,%s)=%d\n",
+			 kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+
+	up_read(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static inline size_t snprint_hex(char *sbuf, size_t size, const u8 *data,
+				 size_t len)
+{
+	size_t ret = 0;
+	for (size_t i = 0; i < len; ++i)
+		ret += snprintf(sbuf + ret, size - ret, "%02x", data[i]);
+	return ret;
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
+	pvd = _mr_to_group(mr, kobj);
+	rc = down_write_killable(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	if (mr->mr_flags & TSM_MR_F_X)
+		rc = pvd->provider->extend(pvd->provider, mr, (u8 *)page);
+	else {
+		BUG_ON(!(mr->mr_flags & TSM_MR_F_W));
+		memcpy(mr->mr_value, page, count);
+	}
+
+	if (!rc)
+		pvd->in_sync = false;
+	else
+		pr_warn(KBUILD_MODNAME ": extending %s/%s failed with %ld\n",
+			kobject_name(&pvd->kset.kobj), mr->mr_name, rc);
+
+	up_write(&pvd->rwsem);
+	return rc ?: count;
+}
+
+static void _rtmr_release(struct kobject *kobj)
+{
+	struct _rtmr *rtmr;
+	rtmr = container_of(kobj, typeof(*rtmr), kobj);
+	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
+	kfree(rtmr);
+}
+
+static struct kobj_type _rtmr_ktype = {
+	.release = _rtmr_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct _rtmr *_rtmr_create(const struct tsm_measurement_register *mr,
+				  struct _mr_provider *pvd)
+{
+	struct _rtmr *rtmr __free(kfree);
+	int rc;
+
+	BUG_ON(!(mr->mr_flags & TSM_MR_F_X));
+	rtmr = kzalloc(sizeof(*rtmr), GFP_KERNEL);
+	if (!rtmr)
+		return ERR_PTR(-ENOMEM);
+
+	sysfs_bin_attr_init(&rtmr->battrs[_RTMR_BATTR_DIGEST]);
+	rtmr->battrs[_RTMR_BATTR_DIGEST].attr.name = "digest";
+	if (mr->mr_flags & TSM_MR_F_W)
+	rtmr->battrs[_RTMR_BATTR_DIGEST].attr.mode |= S_IWUSR;
+	if (mr->mr_flags & TSM_MR_F_R)
+		rtmr->battrs[_RTMR_BATTR_DIGEST].attr.mode |= S_IRUGO;
+
+	rtmr->battrs[_RTMR_BATTR_DIGEST].size = mr->mr_size;
+	rtmr->battrs[_RTMR_BATTR_DIGEST].read = _mr_read;
+	rtmr->battrs[_RTMR_BATTR_DIGEST].write = _mr_write;
+	rtmr->battrs[_RTMR_BATTR_DIGEST].private = (void *)mr;
+
+	rtmr->kobj.kset = &pvd->kset;
+	rc = kobject_init_and_add(&rtmr->kobj, &_rtmr_ktype, NULL, "%s",
+				  mr->mr_name);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(rtmr);
+}
+
+static void _mr_provider_release(struct kobject *kobj)
+{
+	struct _mr_provider *pvd;
+	pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
+	BUG_ON(!list_empty(&pvd->kset.list));
+	kfree(pvd->static_mrs);
+	kfree(pvd);
+}
+
+static struct kobj_type _mr_provider_ktype = {
+	.release = _mr_provider_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
 static struct config_group *tsm_report_group;
+static struct kset *_sysfs_tsm;
+
+static struct _mr_provider *
+_mr_provider_create(struct tsm_measurement_provider *tpvd)
+{
+	struct _mr_provider *pvd __free(kfree);
+	int rc;
+
+	pvd = kzalloc(sizeof(*pvd), GFP_KERNEL);
+	if (!pvd)
+		return ERR_PTR(-ENOMEM);
+
+	if (!tpvd->name || !tpvd->mrs || !tpvd->refresh || !tpvd->extend)
+		return ERR_PTR(-EINVAL);
+
+	rc = kobject_set_name(&pvd->kset.kobj, "%s", tpvd->name);
+	if (rc)
+		return ERR_PTR(rc);
+
+	pvd->kset.kobj.kset = _sysfs_tsm;
+	pvd->kset.kobj.ktype = &_mr_provider_ktype;
+	pvd->provider = tpvd;
+
+	rc = kset_register(&pvd->kset);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return_ptr(pvd);
+}
+
+DEFINE_FREE(_unregister_measurement_provider, struct _mr_provider *,
+	    if (!IS_ERR_OR_NULL(_T))
+		    tsm_unregister_measurement_provider(_T->provider));
+
+int tsm_register_measurement_provider(struct tsm_measurement_provider *tpvd)
+{
+	static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
+
+	struct _mr_provider *pvd __free(_unregister_measurement_provider);
+	int rc, nr;
+
+	pvd = _mr_provider_create(tpvd);
+	if (IS_ERR(pvd))
+		return PTR_ERR(pvd);
+
+	nr = 0;
+	for (int i = 0; tpvd->mrs[i].mr_name; ++i) {
+		if (!(tpvd->mrs[i].mr_flags & TSM_MR_F_X)) {
+			++nr;
+			continue;
+		}
+
+		struct _rtmr *rtmr = _rtmr_create(&tpvd->mrs[i], pvd);
+		if (IS_ERR(rtmr))
+			return PTR_ERR(rtmr);
+
+		struct attribute *attrs[] = {
+			&_attr_hash.attr,
+			NULL,
+		};
+		struct bin_attribute
+			*battrs[_RTMR_BATTR__COUNT + 1] = {};
+		for (int j = 0; j < _RTMR_BATTR__COUNT; ++j)
+			battrs[j] = &rtmr->battrs[j];
+		struct attribute_group agrp = {
+			.attrs = attrs,
+			.bin_attrs = battrs,
+		};
+		rc = sysfs_create_group(&rtmr->kobj, &agrp);
+		if (rc)
+			return rc;
+	}
+
+	if (nr > 0) {
+		struct bin_attribute *static_mrs __free(kfree);
+		struct bin_attribute **battrs __free(kfree);
+
+		static_mrs = kcalloc(sizeof(*static_mrs), nr, GFP_KERNEL);
+		battrs = kcalloc(sizeof(*battrs), nr + 1, GFP_KERNEL);
+		if (!battrs || !static_mrs)
+			return -ENOMEM;
+
+		for (int i = 0, j = 0; tpvd->mrs[i].mr_name; ++i) {
+			if (tpvd->mrs[i].mr_flags & TSM_MR_F_X)
+				continue;
+
+			static_mrs[j].attr.name = tpvd->mrs[i].mr_name;
+			if (tpvd->mrs[i].mr_flags & TSM_MR_F_R) {
+				static_mrs[j].attr.mode |= S_IRUGO;
+				static_mrs[j].read = _mr_read;
+			}
+			if (tpvd->mrs[i].mr_flags & TSM_MR_F_W) {
+				static_mrs[j].attr.mode |= S_IWUSR;
+				static_mrs[j].write = _mr_write;
+			}
+			static_mrs[j].size = tpvd->mrs[i].mr_size;
+			static_mrs[j].private = (void *)&tpvd->mrs[i];
+
+			battrs[j] = &static_mrs[j];
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
+		pvd->static_mrs = no_free_ptr(static_mrs);
+	}
+
+	pvd = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_register_measurement_provider);
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
+int tsm_unregister_measurement_provider(struct tsm_measurement_provider *tpvd)
+{
+	struct kobject *kobj = kset_find_obj(_sysfs_tsm, tpvd->name);
+	if (!kobj)
+		return -ENOENT;
+
+	struct _mr_provider *pvd = container_of(kobj, typeof(*pvd), kset.kobj);
+	BUG_ON(pvd->provider != tpvd);
+
+	_kset_put_children(&pvd->kset);
+	kset_unregister(&pvd->kset);
+	kobject_put(kobj);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tsm_unregister_measurement_provider);
 
 static int __init tsm_init(void)
 {
@@ -497,16 +863,22 @@ static int __init tsm_init(void)
 	}
 	tsm_report_group = tsm;
 
+	_sysfs_tsm = kset_create_and_add("tsm", NULL, kernel_kobj);
+	if (!_sysfs_tsm)
+		return -ENOMEM;
+
 	return 0;
 }
 module_init(tsm_init);
 
 static void __exit tsm_exit(void)
 {
+	kset_unregister(_sysfs_tsm);
 	configfs_unregister_default_group(tsm_report_group);
 	configfs_unregister_subsystem(&tsm_configfs);
 }
 module_exit(tsm_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
+MODULE_DESCRIPTION(
+	"Provide Trusted Security Module attestation reports via configfs");
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 11b0c525be30..9fd7a2f0208e 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <uapi/linux/hash_info.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,65 @@ struct tsm_ops {
 
 int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
+
+/**
+ * struct tsm_measurement_register - describes an architectural measurement
+ *                                   register (MR)
+ * @mr_name: name of the MR
+ * @mr_value: buffer containing the current value of the MR
+ * @mr_size: size of the MR - typically the digest size of @mr_hash
+ * @mr_flags: bitwise OR of flags defined in enum tsm_measurement_register_flag
+ * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h
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
+ * @TSM_MR_F_X: this MR is extensible, should be set for RTMRs
+ * @TSM_MR_F_W: this MR is writable, should be set if direct extension to an
+ *              RTMR is allowed
+ * @TSM_MR_F_R: this MR is readable. All MRs should have this flag set
+ * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
+ * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
+ * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
+ */
+enum tsm_measurement_register_flag {
+	TSM_MR_F_X = 1,
+	TSM_MR_F_W = 2,
+	TSM_MR_F_R = 4,
+	TSM_MR_F_L = 8,
+	TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
+	TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
+};
+
+#define TSM_MR_(h, f) .mr_size = h##_DIGEST_SIZE, .mr_flags = (f)
+#define TSM_MR(h) TSM_MR_(h, TSM_MR_F_R)
+#define TSM_RTMR(h) TSM_MR_(h, TSM_MR_F_RTMR), .mr_hash = HASH_ALGO_##h
+
+/**
+ * struct tsm_measurement_provider - define CC specific MRs and methods for
+ *                                   updating them
+ * @name: name of the measurement provider
+ * @mrs: array of MR definitions ending with mr_name set to %NULL
+ * @refresh: invoked to update the specified MR
+ * @extend: invoked to extend the specified MR with mr_size bytes
+ */
+struct tsm_measurement_provider {
+	const char *name;
+	const struct tsm_measurement_register *mrs;
+	int (*refresh)(struct tsm_measurement_provider *,
+		       const struct tsm_measurement_register *);
+	int (*extend)(struct tsm_measurement_provider *,
+		      const struct tsm_measurement_register *, const u8 *);
+};
+
+int tsm_register_measurement_provider(struct tsm_measurement_provider *);
+int tsm_unregister_measurement_provider(struct tsm_measurement_provider *);
+
 #endif /* __TSM_H */

-- 
2.43.0



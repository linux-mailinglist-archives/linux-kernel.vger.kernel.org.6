Return-Path: <linux-kernel+bounces-320018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148A97051A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FF0282CE5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4536CDBA;
	Sun,  8 Sep 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jobAqU28"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DEA4595B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725771474; cv=none; b=Hr5QC/48Y08EOl14HvLJ+zMogKA9U/F9fk78koiShMeLMvJpLUFmUb4Dql+f7PlGuH9VBIcSmlmZSfOhLFJae1kIyHwqrwiM+Ccb4lL37Lx9d7O6VMhJsmv9O0QK4Sk65ZbUgJSbhH/Ek44nkwBpVagpo+zth7F5T/jXFOezO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725771474; c=relaxed/simple;
	bh=g5TC1j1p9H5K2ejsFtwRR8SX6cZRBTzpKxHuFtvAmkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMYVDlKYMf7g5f67PsV/m88/nPNW6DKY9DL3+z/UdCvG0iBOJjtGXIYJ7dlkqmc/7Ru3ppmlvjF6UGN7jvM4qrGA+ZK08AfkpvMx9GRMudETb0gMiiCYrrtMut93YwkvlEIUJxzSI1TpPiJzuZlOx9DRj1Lo+0vzQXBKAFdfqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jobAqU28; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725771473; x=1757307473;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=g5TC1j1p9H5K2ejsFtwRR8SX6cZRBTzpKxHuFtvAmkY=;
  b=jobAqU28Mix9be4x5J3EP+haJPWvM0VA74yFR1rTY1wFgI8I61CKXrD6
   lcy0kruE4nX2ZjbX7FscNhtbRzjQNTr8ZTQfUZyOuTYDH41GGZh3QEejN
   yF7gsl/d6qSkaBw4Qxm0tTw/Wzgf6S/WukFfcD5QbSg1E+YhXTMHWpiar
   E251s3BQG2nf5STh4447CTtgZ2wEORLyAu40P2JfkK9zMTiMDk7OmDWhB
   2goCMlpfXOm5W7EcVfmWW+wD1yxKu+eUpqinHDp8Mc77WpKJ+fVOZDX3s
   yvrCgaDVGN/Y6Pl/Ml9jY+7auWfFXL/rxNrPW+ubz4dKdgtgkezz+1h2o
   Q==;
X-CSE-ConnectionGUID: IjotRfg6SqeBf9T+s7nlfw==
X-CSE-MsgGUID: iG5NM4mKQK6O+5xUUDPjdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35152172"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="35152172"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:50 -0700
X-CSE-ConnectionGUID: b8UHpuTQR9qtokyKo+WlsQ==
X-CSE-MsgGUID: E9V5oA57Riy5M9VW0v5ohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70924660"
Received: from ibarbour-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.49])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:49 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Sat, 07 Sep 2024 23:56:20 -0500
Subject: [PATCH RFC 2/3] tsm: Add RTMR event logging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-tsm-rtmr-v1-2-12fc4d43d4e7@intel.com>
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

An RTMR typically accumulates measurements from multiple software components,
making its value alone less informative without an accompanying log.

The log format design distinguishes between the meaning (semantics) of events
and their storage.

- **Storage**: Specifies how to delineate and hash event records, allowing the
  kernel to accurately maintain logs without interpreting their contents.
- **Semantics**: The internal structure and meaning of records, defined by the
  agreements between applications and verifiers, are not processed by the
  kernel.

Event Log Format:

- Records are lines ending with `\n`.
- Each record (line) is hashed in its entirety (excluding the trailing `\n`)
  and extended to the RTMR.
- The log for an RTMR is stored at
  `/sys/kernel/tsm/<MR group name>/<RTMR name>/event_log` and consists of these
  delineated records.
- Lines that are empty (containing only `\n`) or start with `#` are skipped
  (not hashed or extended).

This patch adds two more files to every RTMR directory:

- `event_log`: A read-only file containing the full event log.
- `append_log`: A write-only file for appending new event records to the log.
  Records will be processed (hashed/extended) according to the format described
  above. Multiple records can be appended in a single write, provided their
  total size doesn't exceed the size limit (PAGE_SIZE). Partial records are not
  permitted - the last line written will always be treated as complete, even if
  not terminated by `\n`.

Special Event Records/Lines:

- A line starting with `SYNC` captures the RTMR value prior to the inclusion of
  that line, providing verifiers with the starting value of the RTMR. This line
  must be hashed/extended to prevent front-end log truncation.
- A line beginning with `# .EXTEND` indicates a direct extension to the RTMR by
  writing to `digest`. The remainder of the line specifies the value extended.
  Direct extensions cause the log to become out of sync; therefore, a `SYNC`
  line will be automatically generated at the next `append_event` write.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 drivers/virt/coco/tsm.c | 230 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 219 insertions(+), 11 deletions(-)

diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index e83143f22fad..28a10330912c 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/configfs.h>
+#include <linux/ctype.h>
 #include <crypto/hash_info.h>
 #include <crypto/hash.h>
 
@@ -481,12 +482,14 @@ EXPORT_SYMBOL_GPL(tsm_unregister);
 
 enum _rtmr_bin_attr_index {
 	_RTMR_BATTR_DIGEST,
+	_RTMR_BATTR_LOG,
 	_RTMR_BATTR__COUNT,
 };
 
 struct _rtmr {
 	struct kobject kobj;
 	struct bin_attribute battrs[_RTMR_BATTR__COUNT];
+	bool log_in_sync;
 };
 
 struct _mr_provider {
@@ -505,8 +508,40 @@ _rtmr_mr(const struct _rtmr *rtmr)
 		.private;
 }
 
+static inline char *_rtmr_log(const struct _rtmr *rtmr)
+{
+	return (char *)rtmr->battrs[_RTMR_BATTR_LOG].private;
+}
+
+static inline size_t _rtmr_log_size(const struct _rtmr *rtmr)
+{
+	return rtmr->battrs[_RTMR_BATTR_LOG].size;
+}
+
+static inline void _rtmr_log_set_buf(struct _rtmr *rtmr, char *log)
+{
+	rtmr->battrs[_RTMR_BATTR_LOG].private = log;
+}
+
+static inline void _rtmr_log_inc_size(struct _rtmr *rtmr, size_t size)
+{
+	rtmr->battrs[_RTMR_BATTR_LOG].size += size;
+}
+
+static inline int _rtmr_log_update_attribute(struct _rtmr *rtmr)
+{
+	struct bin_attribute *attrs_to_update[] = {
+		&rtmr->battrs[_RTMR_BATTR_LOG],
+		NULL,
+	};
+	struct attribute_group agrp = {
+		.bin_attrs = attrs_to_update,
+	};
+	return sysfs_update_group(&rtmr->kobj, &agrp);
+}
+
 static inline struct _mr_provider *
-_mr_to_group(const struct tsm_measurement_register *mr, struct kobject *kobj)
+_mr_to_provider(const struct tsm_measurement_register *mr, struct kobject *kobj)
 {
 	if (!(mr->mr_flags & TSM_MR_F_X))
 		return container_of(kobj, struct _mr_provider, kset.kobj);
@@ -561,7 +596,7 @@ static ssize_t _mr_read(struct file *filp, struct kobject *kobj,
 	mr = (typeof(mr))attr->private;
 	BUG_ON(mr->mr_size != attr->size);
 
-	pvd = _mr_to_group(mr, kobj);
+	pvd = _mr_to_provider(mr, kobj);
 	rc = down_read_interruptible(&pvd->rwsem);
 	if (rc)
 		return rc;
@@ -591,9 +626,66 @@ static ssize_t _mr_read(struct file *filp, struct kobject *kobj,
 	return rc ?: count;
 }
 
-static inline size_t snprint_hex(char *sbuf, size_t size, const u8 *data,
+#define _EVENTLOG_GRANULARITY HPAGE_SIZE
+
+static ssize_t _log_extend_line(struct _rtmr *rtmr, const char *line,
+				const char *end, int newlines,
+				struct crypto_shash *tfm)
+{
+	struct _mr_provider *pvd;
+	pvd = container_of(rtmr->kobj.kset, typeof(*pvd), kset);
+	lockdep_assert_held_write(&pvd->rwsem);
+
+	BUG_ON(line > end);
+
+	while (line < end && isspace(line[0]))
+		++line;
+	while (line < end && isspace(end[-1]))
+		--end;
+	if (line == end)
+		return 0;
+
+	ssize_t count = end - line;
+	char *log = _rtmr_log(rtmr);
+	size_t needed = _rtmr_log_size(rtmr) + count + newlines;
+	if (ksize(log) < needed) {
+		log = krealloc(log,
+			       ALIGN(needed + _EVENTLOG_GRANULARITY / 2,
+				     _EVENTLOG_GRANULARITY),
+			       GFP_KERNEL);
+		if (!log)
+			return -ENOMEM;
+
+		_rtmr_log_set_buf(rtmr, log);
+	}
+
+	log += _rtmr_log_size(rtmr);
+	for (int i = 0; i < newlines; ++i)
+		*log++ = '\n';
+
+	if (*line != '#') {
+		u8 digest[SHA512_DIGEST_SIZE];
+		BUG_ON(tfm == NULL);
+		BUG_ON(sizeof(digest) < crypto_shash_digestsize(tfm));
+
+		int rc = crypto_shash_tfm_digest(tfm, line, count, digest);
+		if (!rc)
+			rc = _call_extend(pvd, _rtmr_mr(rtmr), digest);
+		if (rc)
+			return rc;
+	}
+
+	memcpy(log, line, count);
+	log[count] = '\n';
+	_rtmr_log_inc_size(rtmr, count += newlines + 1);
+
+	return _rtmr_log_update_attribute(rtmr) ?: count;
+}
+
+static inline size_t snprint_hex(char *sbuf, ssize_t size, const u8 *data,
 				 size_t len)
 {
+	BUG_ON(size < len * 2);
 	size_t ret = 0;
 	for (size_t i = 0; i < len; ++i)
 		ret += snprintf(sbuf + ret, size - ret, "%02x", data[i]);
@@ -614,15 +706,26 @@ static ssize_t _mr_write(struct file *filp, struct kobject *kobj,
 	mr = (typeof(mr))attr->private;
 	BUG_ON(mr->mr_size != attr->size);
 
-	pvd = _mr_to_group(mr, kobj);
+	pvd = _mr_to_provider(mr, kobj);
 	rc = down_write_killable(&pvd->rwsem);
 	if (rc)
 		return rc;
 
-	if (mr->mr_flags & TSM_MR_F_X)
-		rc = pvd->provider->extend(pvd->provider, mr, (u8 *)page);
-	else {
-		BUG_ON(!(mr->mr_flags & TSM_MR_F_W));
+	if (mr->mr_flags & TSM_MR_F_X) {
+		struct _rtmr *rtmr;
+		rtmr = container_of(kobj, typeof(*rtmr), kobj);
+
+		char ext_line[0x100] = "# .EXTEND ";
+		size_t len = strnlen(ext_line, sizeof(ext_line));
+		len += snprint_hex(ext_line + len, sizeof(ext_line) - len, page,
+				   count);
+		rc = _log_extend_line(rtmr, ext_line, ext_line + len,
+				      rtmr->log_in_sync, NULL);
+		if (!IS_ERR_VALUE(rc))
+			rc = _call_extend(pvd, mr, page);
+		if (!rc)
+			rtmr->log_in_sync = false;
+	} else {
 		memcpy(mr->mr_value, page, count);
 	}
 
@@ -636,11 +739,110 @@ static ssize_t _mr_write(struct file *filp, struct kobject *kobj,
 	return rc ?: count;
 }
 
+static ssize_t _log_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *attr, char *page, loff_t off,
+			 size_t count)
+{
+	struct _mr_provider *pvd;
+	int rc;
+
+	if (unlikely(off < 0))
+		return -EINVAL;
+
+	if (unlikely(off > attr->size))
+		return 0;
+
+	count = min(count, attr->size - off);
+	if (likely(count > 0)) {
+		pvd = container_of(kobj->kset, typeof(*pvd), kset);
+		rc = down_read_interruptible(&pvd->rwsem);
+		if (rc)
+			return rc;
+
+		memcpy(page, (char *)attr->private + off, count);
+
+		up_read(&pvd->rwsem);
+	}
+
+	return count;
+}
+
+static ssize_t _log_extend(struct _rtmr *rtmr, const char *page, size_t count,
+			   struct crypto_shash *tfm)
+{
+	ssize_t rc = 0, sz = 0;
+	for (size_t i = 0; i < count && !IS_ERR_VALUE(rc);) {
+		size_t j;
+		for (j = i; j < count && (page[j] != '\n' && page[j] != '\r');)
+			++j;
+
+		rc = _log_extend_line(rtmr, &page[i], &page[j], sz == 0, tfm);
+		sz += rc;
+
+		for (i = j; i < count && (page[i] == '\n' || page[i] == '\r');)
+			++i;
+	}
+
+	return IS_ERR_VALUE(rc) ? rc : sz;
+}
+
+DEFINE_FREE(shash, struct crypto_shash *,
+	    if (!IS_ERR(_T)) crypto_free_shash(_T));
+
+static ssize_t append_event_store(struct kobject *kobj,
+				  struct kobj_attribute *attr, const char *page,
+				  size_t count)
+{
+	struct _rtmr *rtmr;
+	rtmr = container_of(kobj, typeof(*rtmr), kobj);
+
+	const struct tsm_measurement_register *mr;
+	mr = _rtmr_mr(rtmr);
+
+	struct crypto_shash *tfm __free(shash) =
+		crypto_alloc_shash(hash_algo_name[mr->mr_hash], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	struct _mr_provider *pvd;
+	pvd = container_of(kobj->kset, typeof(*pvd), kset);
+
+	ssize_t rc = down_write_killable(&pvd->rwsem);
+	if (rc)
+		return rc;
+
+	if (!rtmr->log_in_sync) {
+		if (mr->mr_flags & TSM_MR_F_L)
+			rc = _call_refresh(pvd, mr);
+
+		if (!IS_ERR_VALUE(rc)) {
+			char sync[0x100] = "SYNC ";
+			strncat(sync, hash_algo_name[mr->mr_hash],
+				sizeof(sync));
+			size_t len = strnlen(sync, sizeof(sync));
+			sync[len++] = '/';
+			len += snprint_hex(sync + len, sizeof(sync) - len,
+					   mr->mr_value, mr->mr_size);
+			rc = _log_extend_line(rtmr, sync, sync + len,
+					      _rtmr_log_size(rtmr) > 0, tfm);
+		}
+	}
+
+	if (!IS_ERR_VALUE(rc)) {
+		rtmr->log_in_sync = true;
+		rc = _log_extend(rtmr, page, count, tfm);
+	}
+
+	up_write(&pvd->rwsem);
+	return IS_ERR_VALUE(rc) ? rc : count;
+}
+
 static void _rtmr_release(struct kobject *kobj)
 {
 	struct _rtmr *rtmr;
 	rtmr = container_of(kobj, typeof(*rtmr), kobj);
 	pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
+	kfree(_rtmr_log(rtmr));
 	kfree(rtmr);
 }
 
@@ -663,7 +865,7 @@ static struct _rtmr *_rtmr_create(const struct tsm_measurement_register *mr,
 	sysfs_bin_attr_init(&rtmr->battrs[_RTMR_BATTR_DIGEST]);
 	rtmr->battrs[_RTMR_BATTR_DIGEST].attr.name = "digest";
 	if (mr->mr_flags & TSM_MR_F_W)
-	rtmr->battrs[_RTMR_BATTR_DIGEST].attr.mode |= S_IWUSR;
+		rtmr->battrs[_RTMR_BATTR_DIGEST].attr.mode |= S_IWUSR;
 	if (mr->mr_flags & TSM_MR_F_R)
 		rtmr->battrs[_RTMR_BATTR_DIGEST].attr.mode |= S_IRUGO;
 
@@ -672,6 +874,11 @@ static struct _rtmr *_rtmr_create(const struct tsm_measurement_register *mr,
 	rtmr->battrs[_RTMR_BATTR_DIGEST].write = _mr_write;
 	rtmr->battrs[_RTMR_BATTR_DIGEST].private = (void *)mr;
 
+	sysfs_bin_attr_init(&rtmr->battrs[_RTMR_BATTR_LOG]);
+	rtmr->battrs[_RTMR_BATTR_LOG].attr.name = "event_log";
+	rtmr->battrs[_RTMR_BATTR_LOG].attr.mode = S_IRUGO;
+	rtmr->battrs[_RTMR_BATTR_LOG].read = _log_read;
+
 	rtmr->kobj.kset = &pvd->kset;
 	rc = kobject_init_and_add(&rtmr->kobj, &_rtmr_ktype, NULL, "%s",
 				  mr->mr_name);
@@ -734,6 +941,7 @@ DEFINE_FREE(_unregister_measurement_provider, struct _mr_provider *,
 int tsm_register_measurement_provider(struct tsm_measurement_provider *tpvd)
 {
 	static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
+	static struct kobj_attribute _attr_append = __ATTR_WO(append_event);
 
 	struct _mr_provider *pvd __free(_unregister_measurement_provider);
 	int rc, nr;
@@ -754,11 +962,11 @@ int tsm_register_measurement_provider(struct tsm_measurement_provider *tpvd)
 			return PTR_ERR(rtmr);
 
 		struct attribute *attrs[] = {
+			&_attr_append.attr,
 			&_attr_hash.attr,
 			NULL,
 		};
-		struct bin_attribute
-			*battrs[_RTMR_BATTR__COUNT + 1] = {};
+		struct bin_attribute *battrs[_RTMR_BATTR__COUNT + 1] = {};
 		for (int j = 0; j < _RTMR_BATTR__COUNT; ++j)
 			battrs[j] = &rtmr->battrs[j];
 		struct attribute_group agrp = {

-- 
2.43.0



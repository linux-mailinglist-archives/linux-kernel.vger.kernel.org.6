Return-Path: <linux-kernel+bounces-177157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0E8C3ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC0B2097E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140E14600E;
	Mon, 13 May 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cMPJ0sFh"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB037146A78
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576933; cv=none; b=ErwllU5wInEgfIZZpIMiPzRN50UTSJR/0lWLmrolvppEiDsONjpv88bxu4MkLN/mort/q0YSaM4ryeRNdkQKQMVl13FGbuYWFo0lva/6yqEipLwyZm5WYJLDKhOWQSNACxJVtd/5287690HVTGS72NpbSmLWVi7HfLKQCSww8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576933; c=relaxed/simple;
	bh=53fhbAFF1lEnvUi6VGkjbuCtFkL4NPIw2HdeDB9tm/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/r/QordPMMky7PpFCkLsvwLfwArGHqT8SvEtaj9PqnGF4ax/qgmsgFeaCCe2fXfob6c+YPYKglZSVYLieCm0TwqWuyFZNNP6NSw0aPQHwUtUKGmWrjyo6pJ9sHMdG9GNpk0F/klCnzZxogj55jFr+3E2WsY7w7TiDZjS4BjUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cMPJ0sFh; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576921; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7JnpbcdNJF3PJU4gWLyVFlMg8iu5JgVvM/Myixzu63c=;
	b=cMPJ0sFhOlDRvdYH6C+V6jZSIK37rZqCPUUt/bXfpdrKrY/XmtpywWnXWQ1/qSJUkQ4o9hmNBWTQlh8pFstnAhdNaw57PZDO4R79fd/NZ+Yk1vvOuUos52h7ibPuCjbpbzSAtYBCr1C18kOTdGzc/qOgwFJMYDNdBwYtrWQ5uhI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HFTCU_1715576918;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HFTCU_1715576918)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] mm: shmem: add multi-size THP sysfs interface for anonymous shmem
Date: Mon, 13 May 2024 13:08:14 +0800
Message-Id: <0307b7a2f16e49e0f752869e83682ef39614ea27.1715571279.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support the use of mTHP with anonymous shmem, add a new sysfs interface
'shmem_enabled' in the '/sys/kernel/mm/transparent_hugepage/hugepages-kB/'
directory for each mTHP to control whether shmem is enabled for that mTHP,
with a value similar to the top level 'shmem_enabled', which can be set to:
"always", "inherit (to inherit the top level setting)", "within_size", "advise",
"never", "deny", "force". These values follow the same semantics as the top
level, except the 'deny' is equivalent to 'never', and 'force' is equivalent
to 'always' to keep compatibility.

By default, PMD-sized hugepages have enabled="inherit" and all other hugepage
sizes have enabled="never" for '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/shmem_enabled'.

In addition, if top level value is 'force', then only PMD-sized hugepages
have enabled="inherit", otherwise configuration will be failed and vice versa.
That means now we will avoid using non-PMD sized THP to override the global
huge allocation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 29 +++++++
 include/linux/huge_mm.h                    | 10 +++
 mm/huge_memory.c                           | 11 +--
 mm/shmem.c                                 | 96 ++++++++++++++++++++++
 4 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 076443cc10a6..a28496e15bdb 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -332,6 +332,35 @@ deny
 force
     Force the huge option on for all - very useful for testing;
 
+Anonymous shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob
+to control mTHP allocation: /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled.
+Its value for each mTHP is essentially consistent with the global setting, except
+for the addition of 'inherit' to ensure compatibility with the global settings.
+always
+    Attempt to allocate <size> huge pages every time we need a new page;
+
+inherit
+    Inherit the top-level "shmem_enabled" value. By default, PMD-sized hugepages
+    have enabled="inherit" and all other hugepage sizes have enabled="never";
+
+never
+    Do not allocate <size> huge pages;
+
+within_size
+    Only allocate <size> huge page if it will be fully within i_size.
+    Also respect fadvise()/madvise() hints;
+
+advise
+    Only allocate <size> huge pages if requested with fadvise()/madvise();
+
+deny
+    Has the same semantics as 'never', now mTHP allocation policy is only
+    used for anonymous shmem and no not override tmpfs.
+
+force
+    Has the same semantics as 'always', now mTHP allocation policy is only
+    used for anonymous shmem and no not override tmpfs.
+
 Need of application restart
 ===========================
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 017cee864080..1fce6fee7766 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -6,6 +6,7 @@
 #include <linux/mm_types.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
+#include <linux/kobject.h>
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -63,6 +64,7 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf,
 				  enum transparent_hugepage_flag flag);
 extern struct kobj_attribute shmem_enabled_attr;
+extern struct kobj_attribute thpsize_shmem_enabled_attr;
 
 /*
  * Mask of all large folio orders supported for anonymous THP; all orders up to
@@ -265,6 +267,14 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
 
+struct thpsize {
+	struct kobject kobj;
+	struct list_head node;
+	int order;
+};
+
+#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
+
 enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9efb6fefc391..d3080a8843f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -449,14 +449,6 @@ static void thpsize_release(struct kobject *kobj);
 static DEFINE_SPINLOCK(huge_anon_orders_lock);
 static LIST_HEAD(thpsize_list);
 
-struct thpsize {
-	struct kobject kobj;
-	struct list_head node;
-	int order;
-};
-
-#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
-
 static ssize_t thpsize_enabled_show(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
 {
@@ -517,6 +509,9 @@ static struct kobj_attribute thpsize_enabled_attr =
 
 static struct attribute *thpsize_attrs[] = {
 	&thpsize_enabled_attr.attr,
+#ifdef CONFIG_SHMEM
+	&thpsize_shmem_enabled_attr.attr,
+#endif
 	NULL,
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index a383ea9a89a5..59cc26d44344 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -131,6 +131,14 @@ struct shmem_options {
 #define SHMEM_SEEN_QUOTA 32
 };
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static unsigned long huge_anon_shmem_orders_always __read_mostly;
+static unsigned long huge_anon_shmem_orders_madvise __read_mostly;
+static unsigned long huge_anon_shmem_orders_inherit __read_mostly;
+static unsigned long huge_anon_shmem_orders_within_size __read_mostly;
+static DEFINE_SPINLOCK(huge_anon_shmem_orders_lock);
+#endif
+
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -4687,6 +4695,12 @@ void __init shmem_init(void)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
+
+	/*
+	 * Default to setting PMD-sized THP to inherit the global setting and
+	 * disable all other multi-size THPs, when anonymous shmem uses mTHP.
+	 */
+	huge_anon_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
 #endif
 	return;
 
@@ -4746,6 +4760,11 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
 		return -EINVAL;
 
+	/* Do not override huge allocation policy with non-PMD sized mTHP */
+	if (huge == SHMEM_HUGE_FORCE &&
+	    huge_anon_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
+		return -EINVAL;
+
 	shmem_huge = huge;
 	if (shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
@@ -4753,6 +4772,83 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 }
 
 struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
+
+static ssize_t thpsize_shmem_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	int order = to_thpsize(kobj)->order;
+	const char *output;
+
+	if (test_bit(order, &huge_anon_shmem_orders_always))
+		output = "[always] inherit within_size advise never deny [force]";
+	else if (test_bit(order, &huge_anon_shmem_orders_inherit))
+		output = "always [inherit] within_size advise never deny force";
+	else if (test_bit(order, &huge_anon_shmem_orders_within_size))
+		output = "always inherit [within_size] advise never deny force";
+	else if (test_bit(order, &huge_anon_shmem_orders_madvise))
+		output = "always inherit within_size [advise] never deny force";
+	else
+		output = "always inherit within_size advise [never] [deny] force";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int order = to_thpsize(kobj)->order;
+	ssize_t ret = count;
+
+	if (sysfs_streq(buf, "always") || sysfs_streq(buf, "force")) {
+		spin_lock(&huge_anon_shmem_orders_lock);
+		clear_bit(order, &huge_anon_shmem_orders_inherit);
+		clear_bit(order, &huge_anon_shmem_orders_madvise);
+		clear_bit(order, &huge_anon_shmem_orders_within_size);
+		set_bit(order, &huge_anon_shmem_orders_always);
+		spin_unlock(&huge_anon_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "inherit")) {
+		/* Do not override huge allocation policy with non-PMD sized mTHP */
+		if (shmem_huge == SHMEM_HUGE_FORCE &&
+		    order != HPAGE_PMD_ORDER)
+			return -EINVAL;
+
+		spin_lock(&huge_anon_shmem_orders_lock);
+		clear_bit(order, &huge_anon_shmem_orders_always);
+		clear_bit(order, &huge_anon_shmem_orders_madvise);
+		clear_bit(order, &huge_anon_shmem_orders_within_size);
+		set_bit(order, &huge_anon_shmem_orders_inherit);
+		spin_unlock(&huge_anon_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "within_size")) {
+		spin_lock(&huge_anon_shmem_orders_lock);
+		clear_bit(order, &huge_anon_shmem_orders_always);
+		clear_bit(order, &huge_anon_shmem_orders_inherit);
+		clear_bit(order, &huge_anon_shmem_orders_madvise);
+		set_bit(order, &huge_anon_shmem_orders_within_size);
+		spin_unlock(&huge_anon_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "madvise")) {
+		spin_lock(&huge_anon_shmem_orders_lock);
+		clear_bit(order, &huge_anon_shmem_orders_always);
+		clear_bit(order, &huge_anon_shmem_orders_inherit);
+		clear_bit(order, &huge_anon_shmem_orders_within_size);
+		set_bit(order, &huge_anon_shmem_orders_madvise);
+		spin_unlock(&huge_anon_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "never") || sysfs_streq(buf, "deny")) {
+		spin_lock(&huge_anon_shmem_orders_lock);
+		clear_bit(order, &huge_anon_shmem_orders_always);
+		clear_bit(order, &huge_anon_shmem_orders_inherit);
+		clear_bit(order, &huge_anon_shmem_orders_within_size);
+		clear_bit(order, &huge_anon_shmem_orders_madvise);
+		spin_unlock(&huge_anon_shmem_orders_lock);
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+struct kobj_attribute thpsize_shmem_enabled_attr =
+	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
 #else /* !CONFIG_SHMEM */
-- 
2.39.3



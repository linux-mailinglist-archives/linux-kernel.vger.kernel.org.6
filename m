Return-Path: <linux-kernel+bounces-209613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA723903878
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FCF1F262F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51506178CFD;
	Tue, 11 Jun 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oqx5L5I9"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC744502C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100686; cv=none; b=V/gc0t6+e8cjp5l/FgUsGHjuGVSU3p27kFen+fdhmMDiDKGdYtYYdkgsQpTXXF82FG6VhVo09TiyjanLYxPerh0ABIPhhPkivfqhviT31X8I1JXryFLdaRfShuotE2zS1ecRaY0EsHg/HCu4lHecqZ8XcpNRS2OesaIsMtIRPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100686; c=relaxed/simple;
	bh=T8EKG5DKwUeyYo4U6tRHo+yTe/1Fi0ynMbYlnGXCxNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+XVrpdugflqUZPuj8Z6zu6YADqbw20Sjx4KshNpgC9v72coq0rfW3zY68ZigIu0JhFkcyoL6XmTsH79VqI0EDz3TZoywxeDtkqxdzLm+dIphKBGGi9A/D+ICv0Mq4gT4z8AmEwGutXjEmA9iYhNmgVgvxskvkhYjqwtCpZk41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oqx5L5I9; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718100681; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6yjfO47qpLPy3B0qP6pgcF4Lahv9FnYDIgEE8QuEsvQ=;
	b=oqx5L5I9lKMQAOde54nyDBMrT0xXmOHt1BEj3i5xgpIlEmFTg2TcYL6IxGUYyiVZ6opDx1und6k2xlndYVrhFPZMul9fQX1NBkTB0z1GbFoWuBq1Ipt/2o9+0aXShqUIC9KRmenyffc98nSRtAmXDKktTaiTAJ2zgEgTJ4dZf+E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8G7EMK_1718100678;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8G7EMK_1718100678)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 18:11:18 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] mm: shmem: add multi-size THP sysfs interface for anonymous shmem
Date: Tue, 11 Jun 2024 18:11:07 +0800
Message-Id: <ffddfa8b3cb4266ff963099ab78cfd7184c57ac7.1718090413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
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
"never". An 'inherit' option is added to ensure compatibility with these
global settings, and the options 'force' and 'deny' are dropped, which are
rather testing artifacts from the old ages.

By default, PMD-sized hugepages have enabled="inherit" and all other hugepage
sizes have enabled="never" for '/sys/kernel/mm/transparent_hugepage/hugepages-xxkB/shmem_enabled'.

In addition, if top level value is 'force', then only PMD-sized hugepages
have enabled="inherit", otherwise configuration will be failed and vice versa.
That means now we will avoid using non-PMD sized THP to override the global
huge allocation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 23 ++++++
 include/linux/huge_mm.h                    | 10 +++
 mm/huge_memory.c                           | 11 +--
 mm/shmem.c                                 | 96 ++++++++++++++++++++++
 4 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index d414d3f5592a..b76d15e408b3 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -332,6 +332,29 @@ deny
 force
     Force the huge option on for all - very useful for testing;
 
+Shmem can also use "multi-size THP" (mTHP) by adding a new sysfs knob to control
+mTHP allocation: '/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/shmem_enabled',
+and its value for each mTHP is essentially consistent with the global setting.
+An 'inherit' option is added to ensure compatibility with these global settings.
+Conversely, the options 'force' and 'deny' are dropped, which are rather testing
+artifacts from the old ages.
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
 Need of application restart
 ===========================
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 020e2344eb86..fac21548c5de 100644
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
index 8e49f402d7c7..1360a1903b66 100644
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
index ae358efc397a..bb19ea2770e3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -131,6 +131,14 @@ struct shmem_options {
 #define SHMEM_SEEN_QUOTA 32
 };
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static unsigned long huge_shmem_orders_always __read_mostly;
+static unsigned long huge_shmem_orders_madvise __read_mostly;
+static unsigned long huge_shmem_orders_inherit __read_mostly;
+static unsigned long huge_shmem_orders_within_size __read_mostly;
+static DEFINE_SPINLOCK(huge_shmem_orders_lock);
+#endif
+
 #ifdef CONFIG_TMPFS
 static unsigned long shmem_default_max_blocks(void)
 {
@@ -4672,6 +4680,12 @@ void __init shmem_init(void)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
 	else
 		shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
+
+	/*
+	 * Default to setting PMD-sized THP to inherit the global setting and
+	 * disable all other multi-size THPs.
+	 */
+	huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
 #endif
 	return;
 
@@ -4731,6 +4745,11 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
 		return -EINVAL;
 
+	/* Do not override huge allocation policy with non-PMD sized mTHP */
+	if (huge == SHMEM_HUGE_FORCE &&
+	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
+		return -EINVAL;
+
 	shmem_huge = huge;
 	if (shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
@@ -4738,6 +4757,83 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 }
 
 struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
+
+static ssize_t thpsize_shmem_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	int order = to_thpsize(kobj)->order;
+	const char *output;
+
+	if (test_bit(order, &huge_shmem_orders_always))
+		output = "[always] inherit within_size advise never";
+	else if (test_bit(order, &huge_shmem_orders_inherit))
+		output = "always [inherit] within_size advise never";
+	else if (test_bit(order, &huge_shmem_orders_within_size))
+		output = "always inherit [within_size] advise never";
+	else if (test_bit(order, &huge_shmem_orders_madvise))
+		output = "always inherit within_size [advise] never";
+	else
+		output = "always inherit within_size advise [never]";
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
+	if (sysfs_streq(buf, "always")) {
+		spin_lock(&huge_shmem_orders_lock);
+		clear_bit(order, &huge_shmem_orders_inherit);
+		clear_bit(order, &huge_shmem_orders_madvise);
+		clear_bit(order, &huge_shmem_orders_within_size);
+		set_bit(order, &huge_shmem_orders_always);
+		spin_unlock(&huge_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "inherit")) {
+		/* Do not override huge allocation policy with non-PMD sized mTHP */
+		if (shmem_huge == SHMEM_HUGE_FORCE &&
+		    order != HPAGE_PMD_ORDER)
+			return -EINVAL;
+
+		spin_lock(&huge_shmem_orders_lock);
+		clear_bit(order, &huge_shmem_orders_always);
+		clear_bit(order, &huge_shmem_orders_madvise);
+		clear_bit(order, &huge_shmem_orders_within_size);
+		set_bit(order, &huge_shmem_orders_inherit);
+		spin_unlock(&huge_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "within_size")) {
+		spin_lock(&huge_shmem_orders_lock);
+		clear_bit(order, &huge_shmem_orders_always);
+		clear_bit(order, &huge_shmem_orders_inherit);
+		clear_bit(order, &huge_shmem_orders_madvise);
+		set_bit(order, &huge_shmem_orders_within_size);
+		spin_unlock(&huge_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "madvise")) {
+		spin_lock(&huge_shmem_orders_lock);
+		clear_bit(order, &huge_shmem_orders_always);
+		clear_bit(order, &huge_shmem_orders_inherit);
+		clear_bit(order, &huge_shmem_orders_within_size);
+		set_bit(order, &huge_shmem_orders_madvise);
+		spin_unlock(&huge_shmem_orders_lock);
+	} else if (sysfs_streq(buf, "never")) {
+		spin_lock(&huge_shmem_orders_lock);
+		clear_bit(order, &huge_shmem_orders_always);
+		clear_bit(order, &huge_shmem_orders_inherit);
+		clear_bit(order, &huge_shmem_orders_within_size);
+		clear_bit(order, &huge_shmem_orders_madvise);
+		spin_unlock(&huge_shmem_orders_lock);
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



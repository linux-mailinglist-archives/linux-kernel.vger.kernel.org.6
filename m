Return-Path: <linux-kernel+bounces-248701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFB92E0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7892835DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791B1527A1;
	Thu, 11 Jul 2024 07:29:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEB1494CE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682986; cv=none; b=pa7MOFCWjZAHEL9vOsIMiO+u2UarXDROM/d+KwSTsYJAQ1TnpULTnlKcnOtzaHusMEo8JPs7QDATHU3dgGcsD5MzDwyh5mF+BcnP1h6ERjABYlPf0L6vyLLok2jzyoAFUzFFPUKdJfvQUHBNxXPe1YqlAIRlTR3wfRAVgzNlLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682986; c=relaxed/simple;
	bh=8qFvFCRpkXi6/hU9aoD7nUm6oQWxs9eBFf7SBA+3Vi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqUlEEhCmNtHachzYUOxvSH7vgbL6yLpQoXdgpTWYG9c9EcVtAiyuvkJ09USELp8oI4YI6tR20TuEf+JuQzBmhsPpw8T6WvFXzVD1yhMB9cD0muDXU3zYaZ50EVyCH5KCqIVe1NeL9jCVj4Dsgx3Ll8KuEjEzTzXzneutPHtHms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481C913D5;
	Thu, 11 Jul 2024 00:30:08 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8AB3F762;
	Thu, 11 Jul 2024 00:29:41 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Date: Thu, 11 Jul 2024 08:29:25 +0100
Message-ID: <20240711072929.3590000-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240711072929.3590000-1-ryan.roberts@arm.com>
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose 3 new mTHP stats for file (pagecache) folio allocations:

  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_charge

This will provide some insight on the sizes of large folios being
allocated for file-backed memory, and how often allocation is failing.

All non-order-0 (and most order-0) folio allocations are currently done
through filemap_alloc_folio(), and folios are charged in a subsequent
call to filemap_add_folio(). So count file_fallback when allocation
fails in filemap_alloc_folio() and count file_alloc or
file_fallback_charge in filemap_add_folio(), based on whether charging
succeeded or not. There are some users of filemap_add_folio() that
allocate their own order-0 folio by other means, so we would not count
an allocation failure in this case, but we also don't care about order-0
allocations. This approach feels like it should be good enough and
doesn't require any (impractically large) refactoring.

The existing mTHP stats interface is reused to provide consistency to
users. And because we are reusing the same interface, we can reuse the
same infrastructure on the kernel side. The one small wrinkle is that
the set of folio sizes supported by the pagecache are not identical to
those supported by anon and shmem; pagecache supports order-1, unlike
anon and shmem, and the max pagecache order may be less than PMD-size
(see arm64 with 64K base pages), again unlike anon and shmem. So we now
create a hugepages-*kB directory for the union of the sizes supported by
all 3 memory types and populate it with the relevant stats and controls.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  13 +++
 include/linux/huge_mm.h                    |   6 +-
 include/linux/pagemap.h                    |  17 ++-
 mm/filemap.c                               |   6 +-
 mm/huge_memory.c                           | 117 ++++++++++++++++-----
 5 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..d4857e457add 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -512,6 +512,19 @@ shmem_fallback_charge
 	falls back to using small pages even though the allocation was
 	successful.
 
+file_alloc
+	is incremented every time a file huge page is successfully
+	allocated.
+
+file_fallback
+	is incremented if a file huge page is attempted to be allocated
+	but fails and instead falls back to using small pages.
+
+file_fallback_charge
+	is incremented if a file huge page cannot be charged and instead
+	falls back to using small pages even though the allocation was
+	successful.
+
 split
 	is incremented every time a huge page is successfully split into
 	smaller orders. This can happen for a variety of reasons but a
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cb93b9009ce4..b4fba11976f2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -117,6 +117,9 @@ enum mthp_stat_item {
 	MTHP_STAT_SHMEM_ALLOC,
 	MTHP_STAT_SHMEM_FALLBACK,
 	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
+	MTHP_STAT_FILE_ALLOC,
+	MTHP_STAT_FILE_FALLBACK,
+	MTHP_STAT_FILE_FALLBACK_CHARGE,
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
@@ -292,11 +295,10 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 
 struct thpsize {
 	struct kobject kobj;
-	struct list_head node;
 	int order;
 };
 
-#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
+#define to_thpsize(_kobj) container_of(_kobj, struct thpsize, kobj)
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6e2f72d03176..f45a1ba6d9b6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -365,6 +365,7 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
 #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
+#define PAGECACHE_LARGE_ORDERS	((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
 
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
@@ -562,14 +563,26 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
 #else
-static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	return folio_alloc_noprof(gfp, order);
 }
 #endif
 
+static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+{
+	struct folio *folio;
+
+	folio = __filemap_alloc_folio_noprof(gfp, order);
+
+	if (!folio)
+		count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
+
+	return folio;
+}
+
 #define filemap_alloc_folio(...)				\
 	alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 53d5d0410b51..131d514fca29 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 	int ret;
 
 	ret = mem_cgroup_charge(folio, NULL, gfp);
+	count_mthp_stat(folio_order(folio),
+		ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FILE_ALLOC);
 	if (ret)
 		return ret;
 
@@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 {
 	int n;
 	struct folio *folio;
@@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
 	}
 	return folio_alloc_noprof(gfp, order);
 }
-EXPORT_SYMBOL(filemap_alloc_folio_noprof);
+EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
 #endif
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f9696c94e211..559553e2a662 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -452,8 +452,9 @@ static const struct attribute_group hugepage_attr_group = {
 
 static void hugepage_exit_sysfs(struct kobject *hugepage_kobj);
 static void thpsize_release(struct kobject *kobj);
+static void thpsize_child_release(struct kobject *kobj);
 static DEFINE_SPINLOCK(huge_anon_orders_lock);
-static LIST_HEAD(thpsize_list);
+static LIST_HEAD(thpsize_child_list);
 
 static ssize_t thpsize_enabled_show(struct kobject *kobj,
 				    struct kobj_attribute *attr, char *buf)
@@ -537,6 +538,18 @@ static const struct kobj_type thpsize_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+static const struct kobj_type thpsize_child_ktype = {
+	.release = &thpsize_child_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+struct thpsize_child {
+	struct kobject kobj;
+	struct list_head node;
+};
+
+#define to_thpsize_child(_kobj) container_of(_kobj, struct thpsize, kobj)
+
 DEFINE_PER_CPU(struct mthp_stat, mthp_stats) = {{{0}}};
 
 static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
@@ -557,7 +570,7 @@ static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
 static ssize_t _name##_show(struct kobject *kobj,			\
 			struct kobj_attribute *attr, char *buf)		\
 {									\
-	int order = to_thpsize(kobj)->order;				\
+	int order = to_thpsize(kobj->parent)->order;			\
 									\
 	return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));	\
 }									\
@@ -591,41 +604,93 @@ static struct attribute *stats_attrs[] = {
 };
 
 static struct attribute_group stats_attr_group = {
-	.name = "stats",
 	.attrs = stats_attrs,
 };
 
-static struct thpsize *thpsize_create(int order, struct kobject *parent)
+DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
+
+static struct attribute *file_stats_attrs[] = {
+	&file_alloc_attr.attr,
+	&file_fallback_attr.attr,
+	&file_fallback_charge_attr.attr,
+	NULL,
+};
+
+static struct attribute_group file_stats_attr_group = {
+	.attrs = file_stats_attrs,
+};
+
+static int thpsize_create(int order, struct kobject *parent)
 {
 	unsigned long size = (PAGE_SIZE << order) / SZ_1K;
+	struct thpsize_child *stats;
 	struct thpsize *thpsize;
 	int ret;
 
+	/*
+	 * Each child object (currently only "stats" directory) holds a
+	 * reference to the top-level thpsize object, so we can drop our ref to
+	 * the top-level once stats is setup. Then we just need to drop a
+	 * reference on any children to clean everything up. We can't just use
+	 * the attr group name for the stats subdirectory because there may be
+	 * multiple attribute groups to populate inside stats and overlaying
+	 * using the name property isn't supported in that way; each attr group
+	 * name, if provided, must be unique in the parent directory.
+	 */
+
 	thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
-	if (!thpsize)
-		return ERR_PTR(-ENOMEM);
+	if (!thpsize) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	thpsize->order = order;
 
 	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
 				   "hugepages-%lukB", size);
 	if (ret) {
 		kfree(thpsize);
-		return ERR_PTR(ret);
+		goto err;
 	}
 
-	ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
-	if (ret) {
+	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
+	if (!stats) {
 		kobject_put(&thpsize->kobj);
-		return ERR_PTR(ret);
+		ret = -ENOMEM;
+		goto err;
 	}
 
-	ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
+	ret = kobject_init_and_add(&stats->kobj, &thpsize_child_ktype,
+				   &thpsize->kobj, "stats");
+	kobject_put(&thpsize->kobj);
 	if (ret) {
-		kobject_put(&thpsize->kobj);
-		return ERR_PTR(ret);
+		kfree(stats);
+		goto err;
 	}
 
-	thpsize->order = order;
-	return thpsize;
+	if (BIT(order) & THP_ORDERS_ALL_ANON) {
+		ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
+		if (ret)
+			goto err_put;
+
+		ret = sysfs_create_group(&stats->kobj, &stats_attr_group);
+		if (ret)
+			goto err_put;
+	}
+
+	if (BIT(order) & PAGECACHE_LARGE_ORDERS) {
+		ret = sysfs_create_group(&stats->kobj, &file_stats_attr_group);
+		if (ret)
+			goto err_put;
+	}
+
+	list_add(&stats->node, &thpsize_child_list);
+	return 0;
+err_put:
+	kobject_put(&stats->kobj);
+err:
+	return ret;
 }
 
 static void thpsize_release(struct kobject *kobj)
@@ -633,10 +698,14 @@ static void thpsize_release(struct kobject *kobj)
 	kfree(to_thpsize(kobj));
 }
 
+static void thpsize_child_release(struct kobject *kobj)
+{
+	kfree(to_thpsize_child(kobj));
+}
+
 static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 {
 	int err;
-	struct thpsize *thpsize;
 	unsigned long orders;
 	int order;
 
@@ -665,16 +734,14 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 		goto remove_hp_group;
 	}
 
-	orders = THP_ORDERS_ALL_ANON;
+	orders = THP_ORDERS_ALL_ANON | PAGECACHE_LARGE_ORDERS;
 	order = highest_order(orders);
 	while (orders) {
-		thpsize = thpsize_create(order, *hugepage_kobj);
-		if (IS_ERR(thpsize)) {
+		err = thpsize_create(order, *hugepage_kobj);
+		if (err) {
 			pr_err("failed to create thpsize for order %d\n", order);
-			err = PTR_ERR(thpsize);
 			goto remove_all;
 		}
-		list_add(&thpsize->node, &thpsize_list);
 		order = next_order(&orders, order);
 	}
 
@@ -692,11 +759,11 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 
 static void __init hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 {
-	struct thpsize *thpsize, *tmp;
+	struct thpsize_child *child, *tmp;
 
-	list_for_each_entry_safe(thpsize, tmp, &thpsize_list, node) {
-		list_del(&thpsize->node);
-		kobject_put(&thpsize->kobj);
+	list_for_each_entry_safe(child, tmp, &thpsize_child_list, node) {
+		list_del(&child->node);
+		kobject_put(&child->kobj);
 	}
 
 	sysfs_remove_group(hugepage_kobj, &khugepaged_attr_group);
-- 
2.43.0



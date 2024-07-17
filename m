Return-Path: <linux-kernel+bounces-254794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD399337A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E11F21D67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE371B28A;
	Wed, 17 Jul 2024 07:13:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7E1CAB1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200391; cv=none; b=FE6s2YtofB4opTirSRLMkGimmBtugVFPAnlWoY4hqWLx4Pg2hrF1cFX/Sl922qw2Mgdk9CAYM2VwEwfcJiGYeI2sTiX0pu7laa+I9Zbo85AT8630EOvtQ34aAzmHGs/53wyfIgEjEjCi1I9v90Mp6IND3mtg8sh8tNfkBke4+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200391; c=relaxed/simple;
	bh=Uu0MQeVkFworp7c8D1wbKFGjEsXFtXUpsq3tvSO2rOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n64288xILFBsk9i0y4HkIEHv2Nl87f9+VvUnBWLAtRDD478uB6EntshMHEIR8J0HRP4ldryiIJGywM3l+man4NPLXdpHSdwXvdEj2/7/IIn1Pt2Kfk9uklhe8eElMx8h9VAzcHEJF7UFDFlybgt8+kR50mMwghm0gEa42/j1tMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49719106F;
	Wed, 17 Jul 2024 00:13:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1173F762;
	Wed, 17 Jul 2024 00:13:07 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 1/4] mm: mTHP user controls to configure pagecache large folio sizes
Date: Wed, 17 Jul 2024 08:12:53 +0100
Message-ID: <20240717071257.4141363-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717071257.4141363-1-ryan.roberts@arm.com>
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mTHP controls to sysfs to allow user space to configure the folio
sizes that can be considered for allocation of file-backed memory:

  /sys/kernel/mm/transparent_hugepage/hugepages-*kB/file_enable

For now, the control can be set to either `always` or `never` to enable
or disable that size. More options may be added in future.

By default, at boot, all folio sizes are enabled, and the algorithm used
to select a folio size remains conceptually unchanged; increase by 2
enabled orders each time a readahead marker is hit then reduce to the
closest enabled order to fit within bounds of ra size, index alignment
and EOF. So when all folio sizes are enabled, behavior should be
unchanged. When folio sizes are disabled, the algorithm will never
select them.

Systems such as Android are always under extreme memory pressure and as
a result fragmentation often causes attempts to allocate large folios to
fail and fallback to smaller folios. By fixing the pagecache to one
large folio size (e.g. 64K) plus fallback to small folios, a large
source of this fragmentation can be removed and 64K mTHP allocations
succeed more often, allowing the system to benefit from improved
performance on arm64 and other arches that support "contpte".

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 21 +++++++++
 include/linux/huge_mm.h                    | 50 +++++++++++++---------
 mm/filemap.c                               | 15 ++++---
 mm/huge_memory.c                           | 43 +++++++++++++++++++
 mm/readahead.c                             | 43 +++++++++++++++----
 5 files changed, 138 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index d4857e457add..9f3ed504c646 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -284,6 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::
 
 A higher value may increase memory footprint for some workloads.
 
+File-Backed Hugepages
+---------------------
+
+The kernel will automatically select an appropriate THP size for file-backed
+memory from a set of allowed sizes. By default all THP sizes that the page cache
+supports are allowed, but this set can be modified with one of::
+
+	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/file_enabled
+	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/file_enabled
+
+where <size> is the hugepage size being addressed, the available sizes for which
+vary by system. ``always`` adds the hugepage size to the set of allowed sizes,
+and ``never`` removes the hugepage size from the set of allowed sizes.
+
+In some situations, constraining the allowed sizes can reduce memory
+fragmentation, resulting in fewer allocation fallbacks and improved system
+performance.
+
+Note that any changes to the allowed set of sizes only applies to future
+file-backed THP allocations.
+
 Boot parameter
 ==============
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4f9109fcdded..19ced8192d39 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -114,6 +114,24 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
+static inline int lowest_order(unsigned long orders)
+{
+	if (orders)
+		return __ffs(orders);
+	return -1;
+}
+
+static inline int highest_order(unsigned long orders)
+{
+	return fls_long(orders) - 1;
+}
+
+static inline int next_order(unsigned long *orders, int prev)
+{
+	*orders &= ~BIT(prev);
+	return highest_order(*orders);
+}
+
 enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
@@ -158,6 +176,12 @@ extern unsigned long transparent_hugepage_flags;
 extern unsigned long huge_anon_orders_always;
 extern unsigned long huge_anon_orders_madvise;
 extern unsigned long huge_anon_orders_inherit;
+extern unsigned long huge_file_orders_always;
+
+static inline unsigned long file_orders_always(void)
+{
+	return READ_ONCE(huge_file_orders_always);
+}
 
 static inline bool hugepage_global_enabled(void)
 {
@@ -172,17 +196,6 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
-static inline int highest_order(unsigned long orders)
-{
-	return fls_long(orders) - 1;
-}
-
-static inline int next_order(unsigned long *orders, int prev)
-{
-	*orders &= ~BIT(prev);
-	return highest_order(*orders);
-}
-
 /*
  * Do the below checks:
  *   - For file vma, check if the linear page offset of vma is
@@ -435,6 +448,11 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline unsigned long file_orders_always(void)
+{
+	return 0;
+}
+
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
 	return false;
@@ -578,16 +596,6 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
-
-static inline int highest_order(unsigned long orders)
-{
-	return 0;
-}
-
-static inline int next_order(unsigned long *orders, int prev)
-{
-	return 0;
-}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/filemap.c b/mm/filemap.c
index 131d514fca29..870016fcfdde 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1922,6 +1922,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
 		unsigned order = FGF_GET_ORDER(fgp_flags);
+		unsigned long orders;
 		int err;
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
@@ -1937,13 +1938,15 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (!mapping_large_folio_support(mapping))
 			order = 0;
-		if (order > MAX_PAGECACHE_ORDER)
-			order = MAX_PAGECACHE_ORDER;
+
+		orders = file_orders_always() | BIT(0);
+		orders &= BIT(order + 1) - 1;
 		/* If we're not aligned, allocate a smaller folio */
 		if (index & ((1UL << order) - 1))
-			order = __ffs(index);
+			orders &= BIT(__ffs(index) + 1) - 1;
+		order = highest_order(orders);
 
-		do {
+		while (orders) {
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
@@ -1962,7 +1965,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+
+			order = next_order(&orders, order);
+		};
 
 		if (err == -EEXIST)
 			goto repeat;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26d558e3e80f..e8fe28fe9cf9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -80,6 +80,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+unsigned long huge_file_orders_always __read_mostly;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -525,6 +526,37 @@ static ssize_t anon_enabled_store(struct kobject *kobj,
 	return ret;
 }
 
+static ssize_t file_enabled_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	int order = to_thpsize(kobj)->order;
+	const char *output;
+
+	if (test_bit(order, &huge_file_orders_always))
+		output = "[always] never";
+	else
+		output = "always [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t file_enabled_store(struct kobject *kobj,
+				  struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int order = to_thpsize(kobj)->order;
+	ssize_t ret = count;
+
+	if (sysfs_streq(buf, "always"))
+		set_bit(order, &huge_file_orders_always);
+	else if (sysfs_streq(buf, "never"))
+		clear_bit(order, &huge_file_orders_always);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static struct kobj_attribute anon_enabled_attr =
 	__ATTR(enabled, 0644, anon_enabled_show, anon_enabled_store);
 
@@ -537,7 +569,11 @@ static const struct attribute_group anon_ctrl_attr_grp = {
 	.attrs = anon_ctrl_attrs,
 };
 
+static struct kobj_attribute file_enabled_attr =
+	__ATTR(file_enabled, 0644, file_enabled_show, file_enabled_store);
+
 static struct attribute *file_ctrl_attrs[] = {
+	&file_enabled_attr.attr,
 #ifdef CONFIG_SHMEM
 	&thpsize_shmem_enabled_attr.attr,
 #endif
@@ -712,6 +748,13 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 	 */
 	huge_anon_orders_inherit = BIT(PMD_ORDER);
 
+	/*
+	 * For pagecache, default to enabling all orders. powerpc's PMD_ORDER
+	 * (and therefore THP_ORDERS_ALL_FILE_DEFAULT) isn't a compile-time
+	 * constant so we have to do this here.
+	 */
+	huge_file_orders_always = THP_ORDERS_ALL_FILE_DEFAULT;
+
 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
 		pr_err("failed to create transparent hugepage kobject\n");
diff --git a/mm/readahead.c b/mm/readahead.c
index 517c0be7ce66..e05f85974396 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -432,6 +432,34 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	return 0;
 }
 
+static int select_new_order(int old_order, int max_order, unsigned long orders)
+{
+	unsigned long hi_orders, lo_orders;
+
+	/*
+	 * Select the next order to use from the set in `orders`, while ensuring
+	 * we don't go above max_order. Prefer the next + 1 highest allowed
+	 * order after old_order, unless there isn't one, in which case return
+	 * the closest allowed order, which is either the next highest allowed
+	 * order or less than or equal to old_order. The "next + 1" skip
+	 * behaviour is intended to allow ramping up to large folios quickly.
+	 */
+
+	orders &= BIT(max_order + 1) - 1;
+	VM_WARN_ON(!orders);
+	hi_orders = orders & ~(BIT(old_order + 1) - 1);
+
+	if (hi_orders) {
+		old_order = lowest_order(hi_orders);
+		hi_orders &= ~BIT(old_order);
+		if (hi_orders)
+			return lowest_order(hi_orders);
+	}
+
+	lo_orders = orders & (BIT(old_order + 1) - 1);
+	return highest_order(lo_orders);
+}
+
 void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
@@ -443,17 +471,15 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	unsigned int nofs;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
+	unsigned long orders;
 
-	if (!mapping_large_folio_support(mapping) || ra->size < 4)
+	if (!mapping_large_folio_support(mapping))
 		goto fallback;
 
 	limit = min(limit, index + ra->size - 1);
 
-	if (new_order < MAX_PAGECACHE_ORDER)
-		new_order += 2;
-
-	new_order = min_t(unsigned int, MAX_PAGECACHE_ORDER, new_order);
-	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
+	orders = file_orders_always() | BIT(0);
+	new_order = select_new_order(new_order, ilog2(ra->size), orders);
 
 	/* See comment in page_cache_ra_unbounded() */
 	nofs = memalloc_nofs_save();
@@ -463,9 +489,10 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 		/* Align with smaller pages if needed */
 		if (index & ((1UL << order) - 1))
-			order = __ffs(index);
+			order = select_new_order(order, __ffs(index), orders);
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit)
+		while (index + (1UL << order) - 1 > limit &&
+				(BIT(order) & orders) == 0)
 			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
-- 
2.43.0



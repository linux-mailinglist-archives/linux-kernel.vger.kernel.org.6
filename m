Return-Path: <linux-kernel+bounces-200414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C178FAFB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05661F230D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51001459E4;
	Tue,  4 Jun 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cC3qTG0a"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A250F13247D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496299; cv=none; b=Jr2LsHmT69xXePcQChAIoWQwMa0XR6zvgbFXsLzVcAD3jKhr1gIMRX41wtpnElTTZ2aGBB0gcXb8JMehBS/mT3Wt/aKde/b17gdppDIzQC4Y4fk5dl7s+D5mKg9VoECU5DNivFGhZHgcdigdTqA0sllxXtCSWPL+yA29fU+b4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496299; c=relaxed/simple;
	bh=uGQ7sRts5cNLzsCRoL8CraJK7Uzpeq69KQCPbE76RWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grC/id6UmPwnWGN3Dqs5iSENnDaUrePY4ElcYksRJz0Ndxj2UbeezRLfiqNCtkKQ00A9flhh2og6j8269aGl8l7RFworAHkc4TsLfUN5POjVR2RKA4XltCqM1kOnC5C77Ser6bD9lDWTCweuMmr1/5Y9KWBmFnbThKbAidRbIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cC3qTG0a; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717496291; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=U1fPuNOZf3P7EgFNGhmfPPdzYJEqgGM7sbdyAxnZ0P4=;
	b=cC3qTG0atVBQ/4gMGUyq/lEiYJm1OdHGufaWstgZ1jJRApOI0X55SQKPOyFPXOUBnL5Q6fBIVL+lZSSnfMU8rPvgb/DaUxXqSKzfr6hgX+zp8b7NfXiDAfOVCPWRkWVkZS5MmpK8uw23yfF1taLtG3fJSoBaxJhmJVuXNeFrNU0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7qv1Ys_1717496288;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qv1Ys_1717496288)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 18:18:08 +0800
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
Subject: [PATCH v4 4/6] mm: shmem: add mTHP support for anonymous shmem
Date: Tue,  4 Jun 2024 18:17:48 +0800
Message-Id: <9be6eeacd0304c82a1cb1b7487977a3e14d2b5df.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
can allow THP to be configured through the sysfs interface located at
'/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.

However, the anonymous shmem will ignore the anonymous mTHP rule
configured through the sysfs interface, and can only use the PMD-mapped
THP, that is not reasonable. Users expect to apply the mTHP rule for
all anonymous pages, including the anonymous shmem, in order to enjoy
the benefits of mTHP. For example, lower latency than PMD-mapped THP,
smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
to support all shmem/tmpfs scenarios in the future, especially for the
shmem mmap() case.

The primary strategy is similar to supporting anonymous mTHP. Introduce
a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
which can have almost the same values as the top-level
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
additional "inherit" option and dropping the testing options 'force' and
'deny'. By default all sizes will be set to "never" except PMD size,
which is set to "inherit". This ensures backward compatibility with the
anonymous shmem enabled of the top level, meanwhile also allows independent
control of anonymous shmem enabled for each mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h |  10 +++
 mm/shmem.c              | 187 +++++++++++++++++++++++++++++++++-------
 2 files changed, 167 insertions(+), 30 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fac21548c5de..909cfc67521d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -575,6 +575,16 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
+
+static inline int highest_order(unsigned long orders)
+{
+	return 0;
+}
+
+static inline int next_order(unsigned long *orders, int prev)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/shmem.c b/mm/shmem.c
index 643ff7516b4d..9a8533482208 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1611,6 +1611,107 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 	return result;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge)
+{
+	unsigned long mask = READ_ONCE(huge_anon_shmem_orders_always);
+	unsigned long within_size_orders = READ_ONCE(huge_anon_shmem_orders_within_size);
+	unsigned long vm_flags = vma->vm_flags;
+	/*
+	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
+	 * are enabled for this vma.
+	 */
+	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
+	loff_t i_size;
+	int order;
+
+	if ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+		return 0;
+
+	/* If the hardware/firmware marked hugepage support disabled. */
+	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
+		return 0;
+
+	/*
+	 * Following the 'deny' semantics of the top level, force the huge
+	 * option off from all mounts.
+	 */
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return 0;
+
+	/*
+	 * Only allow inherit orders if the top-level value is 'force', which
+	 * means non-PMD sized THP can not override 'huge' mount option now.
+	 */
+	if (shmem_huge == SHMEM_HUGE_FORCE)
+		return READ_ONCE(huge_anon_shmem_orders_inherit);
+
+	/* Allow mTHP that will be fully within i_size. */
+	order = highest_order(within_size_orders);
+	while (within_size_orders) {
+		index = round_up(index + 1, order);
+		i_size = round_up(i_size_read(inode), PAGE_SIZE);
+		if (i_size >> PAGE_SHIFT >= index) {
+			mask |= within_size_orders;
+			break;
+		}
+
+		order = next_order(&within_size_orders, order);
+	}
+
+	if (vm_flags & VM_HUGEPAGE)
+		mask |= READ_ONCE(huge_anon_shmem_orders_madvise);
+
+	if (global_huge)
+		mask |= READ_ONCE(huge_anon_shmem_orders_inherit);
+
+	return orders & mask;
+}
+
+static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
+					struct address_space *mapping, pgoff_t index,
+					unsigned long orders)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long pages;
+	int order;
+
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	if (!orders)
+		return 0;
+
+	/* Find the highest order that can add into the page cache */
+	order = highest_order(orders);
+	while (orders) {
+		pages = 1UL << order;
+		index = round_down(index, pages);
+		if (!xa_find(&mapping->i_pages, &index,
+			     index + pages - 1, XA_PRESENT))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	return orders;
+}
+#else
+static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge)
+{
+	return 0;
+}
+
+static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
+					struct address_space *mapping, pgoff_t index,
+					unsigned long orders)
+{
+	return 0;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
 		struct shmem_inode_info *info, pgoff_t index)
 {
@@ -1625,38 +1726,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
 	return folio;
 }
 
-static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
-		struct inode *inode, pgoff_t index,
-		struct mm_struct *fault_mm, bool huge)
+static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
+		gfp_t gfp, struct inode *inode, pgoff_t index,
+		struct mm_struct *fault_mm, unsigned long orders)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct folio *folio;
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+	unsigned long suitable_orders = 0;
+	struct folio *folio = NULL;
 	long pages;
-	int error;
+	int error, order;
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-		huge = false;
+		orders = 0;
 
-	if (huge) {
-		pages = HPAGE_PMD_NR;
-		index = round_down(index, HPAGE_PMD_NR);
+	if (orders > 0) {
+		if (vma && vma_is_anon_shmem(vma)) {
+			suitable_orders = anon_shmem_suitable_orders(inode, vmf,
+							mapping, index, orders);
+		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
+			pages = HPAGE_PMD_NR;
+			suitable_orders = BIT(HPAGE_PMD_ORDER);
+			index = round_down(index, HPAGE_PMD_NR);
 
-		/*
-		 * Check for conflict before waiting on a huge allocation.
-		 * Conflict might be that a huge page has just been allocated
-		 * and added to page cache by a racing thread, or that there
-		 * is already at least one small page in the huge extent.
-		 * Be careful to retry when appropriate, but not forever!
-		 * Elsewhere -EEXIST would be the right code, but not here.
-		 */
-		if (xa_find(&mapping->i_pages, &index,
-				index + HPAGE_PMD_NR - 1, XA_PRESENT))
-			return ERR_PTR(-E2BIG);
+			/*
+			 * Check for conflict before waiting on a huge allocation.
+			 * Conflict might be that a huge page has just been allocated
+			 * and added to page cache by a racing thread, or that there
+			 * is already at least one small page in the huge extent.
+			 * Be careful to retry when appropriate, but not forever!
+			 * Elsewhere -EEXIST would be the right code, but not here.
+			 */
+			if (xa_find(&mapping->i_pages, &index,
+				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
+				return ERR_PTR(-E2BIG);
+		}
 
-		folio = shmem_alloc_folio(gfp, HPAGE_PMD_ORDER, info, index);
-		if (!folio && pages == HPAGE_PMD_NR)
-			count_vm_event(THP_FILE_FALLBACK);
+		order = highest_order(suitable_orders);
+		while (suitable_orders) {
+			pages = 1UL << order;
+			index = round_down(index, pages);
+			folio = shmem_alloc_folio(gfp, order, info, index);
+			if (folio)
+				goto allocated;
+
+			if (pages == HPAGE_PMD_NR)
+				count_vm_event(THP_FILE_FALLBACK);
+			order = next_order(&suitable_orders, order);
+		}
 	} else {
 		pages = 1;
 		folio = shmem_alloc_folio(gfp, 0, info, index);
@@ -1664,6 +1782,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
+allocated:
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
@@ -1958,7 +2077,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	struct mm_struct *fault_mm;
 	struct folio *folio;
 	int error;
-	bool alloced;
+	bool alloced, huge;
+	unsigned long orders = 0;
 
 	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
 		return -EINVAL;
@@ -2030,14 +2150,21 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (shmem_is_huge(inode, index, false, fault_mm,
-			  vma ? vma->vm_flags : 0)) {
+	huge = shmem_is_huge(inode, index, false, fault_mm,
+			     vma ? vma->vm_flags : 0);
+	/* Find hugepage orders that are allowed for anonymous shmem. */
+	if (vma && vma_is_anon_shmem(vma))
+		orders = anon_shmem_allowable_huge_orders(inode, vma, index, huge);
+	else if (huge)
+		orders = BIT(HPAGE_PMD_ORDER);
+
+	if (orders > 0) {
 		gfp_t huge_gfp;
 
 		huge_gfp = vma_thp_gfp_mask(vma);
 		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
-		folio = shmem_alloc_and_add_folio(huge_gfp,
-				inode, index, fault_mm, true);
+		folio = shmem_alloc_and_add_folio(vmf, huge_gfp,
+				inode, index, fault_mm, orders);
 		if (!IS_ERR(folio)) {
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_FILE_ALLOC);
@@ -2047,7 +2174,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 			goto repeat;
 	}
 
-	folio = shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
+	folio = shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault_mm, 0);
 	if (IS_ERR(folio)) {
 		error = PTR_ERR(folio);
 		if (error == -EEXIST)
@@ -2058,7 +2185,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 alloced:
 	alloced = true;
-	if (folio_test_pmd_mappable(folio) &&
+	if (folio_test_large(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
 					folio_next_index(folio) - 1) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-- 
2.39.3



Return-Path: <linux-kernel+bounces-258473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534EF938870
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09260281420
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC51803E;
	Mon, 22 Jul 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d/l2iALs"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA21758E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627013; cv=none; b=A//BMVUBwFcOU8onFjEShrhBktaj2GMCv9wTEqO1xkpbAk17QSMw0pwXOTrSKkNneuOQRSgIgcWGA/BvOh2kyl39pK+wE2dy43QUL4/c+BOxmK/AzDfdxfJOVKXuvbtoMfXaAQAwqTOR48ycjqD5HGo5sUv0y1srqBOWF2Zrth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627013; c=relaxed/simple;
	bh=0dXJu3/qKewK3YxkpQ6VE7CMyxJRkqUOrwIrpSytzlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyoRrhrU8BXg3DpsQYrP0veQvMGkebqz14lX3xJf5twFz0j+BphEwkCqPscPyhYsmo8GWAGPVuRwb4sSLVNsATbzGpswQL7mVI5tBwWWQLJ+rNsizOHIhCx5EbzU//PlAlg8x2VAbhpHiGygwVJVvTpbHsIQemPqjv/RVpFy9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d/l2iALs; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721627008; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Vs/dizXu3sRF7w2mzo6J6uL+Sv07j1HZRmB25ivkki0=;
	b=d/l2iALsrZiVWSqoKxN5ZXfyp+OwgSPKP/+7JFGoB1FwHbTbaOb0jbOP5rRAxIuBis4i7dQ4tVA3D5da0b5vlrn2EB9I/gpY26sJP9rFSxtDWVMBtDYYLB37ev39sGVc7dLeqyQn6lAtjP4EVQ1Wh/MkstDW/1rsifbOjceSCBc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAzW.hk_1721627006;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAzW.hk_1721627006)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 13:43:27 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()
Date: Mon, 22 Jul 2024 13:43:19 +0800
Message-Id: <8e825146bb29ee1a1c7bd64d2968ff3e19be7815.1721626645.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1721626645.git.baolin.wang@linux.alibaba.com>
References: <cover.1721626645.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move shmem_huge_global_enabled() into the shmem_allowable_huge_orders() function,
so that shmem_allowable_huge_orders() can also help to find the allowable huge
orders for tmpfs. Moreover the shmem_huge_global_enabled() can become static.
While we are at it, passing the vma instead of mm for shmem_huge_global_enabled()
makes code cleaner.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/shmem_fs.h | 12 ++--------
 mm/huge_memory.c         | 12 +++-------
 mm/shmem.c               | 47 +++++++++++++++++++++++++---------------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 405ee8d3589a..1564d7d3ca61 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -111,21 +111,13 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-				      struct mm_struct *mm, unsigned long vm_flags);
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool global_huge);
+				bool shmem_huge_force);
 #else
-static __always_inline bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-						      bool shmem_huge_force, struct mm_struct *mm,
-						      unsigned long vm_flags)
-{
-	return false;
-}
 static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool global_huge)
+				bool shmem_huge_force)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e8388ea33f50..e555fcdd19d4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -159,16 +159,10 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * Must be done before hugepage flags check since shmem has its
 	 * own flags.
 	 */
-	if (!in_pf && shmem_file(vma->vm_file)) {
-		bool global_huge = shmem_huge_global_enabled(file_inode(vma->vm_file),
-							     vma->vm_pgoff, !enforce_sysfs,
-							     vma->vm_mm, vm_flags);
-
-		if (!vma_is_anon_shmem(vma))
-			return global_huge ? orders : 0;
+	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
-							vma, vma->vm_pgoff, global_huge);
-	}
+						   vma, vma->vm_pgoff,
+						   !enforce_sysfs);
 
 	if (!vma_is_anonymous(vma)) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 1445dcd39b6f..db8f74cac1a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -549,9 +549,10 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
 static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					bool shmem_huge_force, struct mm_struct *mm,
+					bool shmem_huge_force, struct vm_area_struct *vma,
 					unsigned long vm_flags)
 {
+	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
@@ -581,15 +582,15 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 	}
 }
 
-bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-		   bool shmem_huge_force, struct mm_struct *mm,
+static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+		   bool shmem_huge_force, struct vm_area_struct *vma,
 		   unsigned long vm_flags)
 {
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
 		return false;
 
 	return __shmem_huge_global_enabled(inode, index, shmem_huge_force,
-					   mm, vm_flags);
+					   vma, vm_flags);
 }
 
 #if defined(CONFIG_SYSFS)
@@ -772,6 +773,13 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 {
 	return 0;
 }
+
+static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+		bool shmem_huge_force, struct vm_area_struct *vma,
+		unsigned long vm_flags)
+{
+	return false;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
@@ -1625,27 +1633,38 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool global_huge)
+				bool shmem_huge_force)
 {
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
-	unsigned long vm_flags = vma->vm_flags;
+	unsigned long vm_flags = vma ? vma->vm_flags : 0;
 	/*
 	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
 	 * are enabled for this vma.
 	 */
 	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
+	bool global_huge;
 	loff_t i_size;
 	int order;
 
-	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (vma && ((vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return 0;
 
 	/* If the hardware/firmware marked hugepage support disabled. */
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
 		return 0;
 
+	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
+						vma, vm_flags);
+	if (!vma || !vma_is_anon_shmem(vma)) {
+		/*
+		 * For tmpfs, we now only support PMD sized THP if huge page
+		 * is enabled, otherwise fallback to order 0.
+		 */
+		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
+	}
+
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
 	 * option off from all mounts.
@@ -2081,7 +2100,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	struct mm_struct *fault_mm;
 	struct folio *folio;
 	int error;
-	bool alloced, huge;
+	bool alloced;
 	unsigned long orders = 0;
 
 	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
@@ -2154,14 +2173,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	huge = shmem_huge_global_enabled(inode, index, false, fault_mm,
-			     vma ? vma->vm_flags : 0);
-	/* Find hugepage orders that are allowed for anonymous shmem. */
-	if (vma && vma_is_anon_shmem(vma))
-		orders = shmem_allowable_huge_orders(inode, vma, index, huge);
-	else if (huge)
-		orders = BIT(HPAGE_PMD_ORDER);
-
+	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
+	orders = shmem_allowable_huge_orders(inode, vma, index, false);
 	if (orders > 0) {
 		gfp_t huge_gfp;
 
-- 
2.39.3



Return-Path: <linux-kernel+bounces-248613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEE292DFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558B22825A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FB12DDBA;
	Thu, 11 Jul 2024 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mkAiFOSr"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0D77115
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676595; cv=none; b=XPTTe7wcoQ83+bbhIcDrkMr63wVW++adnszzM08kl9Cvd36IitLFCLop+rqOUOhP8mk5QjTLAdo/p0vBdox/Lj9ieivgSQVlkHGSg2cizpKxfx0yFSzaqHoOlcPcAfh3eydMbb9xOwqgBQq1zXS0j5D1Bm01WPK37Dt4oNuOlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676595; c=relaxed/simple;
	bh=QAtPVK2DU57tGv2oS5kfv3qZTbs25J1myBOFz1IdfBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbJB7T3KT9jxpJEctz+HwbFYEd5+oUExCaGWAD1KuCI5rm0aYf3ZryZNIigxiWNCI+fuHq33KxtR0Et0D7FsrxaoRICBo+nRrvLyUHjYdUR3SiSLHq5kO/bp111j1O8Z6kxIn5ZdBKghB2Z1ssBGlVwj8Htd0Vq7hWoAog+VR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mkAiFOSr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676585; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7WxesvSvGAiqBGFGmtnmHTIoOhG04LC4fr9aMiI02FY=;
	b=mkAiFOSrRQ8sv+/feVBowazbUAkFB/SM0CGEWxQYkGvWPkdhsS+wYMpNxlfVHlIxS3nydzLSQtDh3SuV1QYHwek0sShA0njA0rv+kVvS2YaYao1XR6kX/NJkTeJIj4iyNx/vDEJlyBBU/W3fLeZEh/i0RCOFWqaRnlF4fG7ZWv4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAIkxZr_1720676584;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAIkxZr_1720676584)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:43:04 +0800
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
Subject: [PATCH 3/3] mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()
Date: Thu, 11 Jul 2024 13:42:50 +0800
Message-Id: <6e5858d345304d0428c1c2c2a25c289c062b4ea8.1720668581.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720668581.git.baolin.wang@linux.alibaba.com>
References: <cover.1720668581.git.baolin.wang@linux.alibaba.com>
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

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/shmem_fs.h | 12 ++----------
 mm/huge_memory.c         | 12 +++---------
 mm/shmem.c               | 34 ++++++++++++++++++++--------------
 3 files changed, 25 insertions(+), 33 deletions(-)

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
index cc9bad12be75..f69980b5b5fc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -151,16 +151,10 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
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
index 1445dcd39b6f..e9610e2b2a43 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -581,7 +581,7 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 	}
 }
 
-bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 		   bool shmem_huge_force, struct mm_struct *mm,
 		   unsigned long vm_flags)
 {
@@ -1625,27 +1625,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
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
+	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
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
+						fault_mm, vm_flags);
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
@@ -2081,7 +2093,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	struct mm_struct *fault_mm;
 	struct folio *folio;
 	int error;
-	bool alloced, huge;
+	bool alloced;
 	unsigned long orders = 0;
 
 	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
@@ -2154,14 +2166,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
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



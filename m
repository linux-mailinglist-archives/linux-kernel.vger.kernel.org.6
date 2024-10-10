Return-Path: <linux-kernel+bounces-358742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA60998307
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA17C282A22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CC1C1758;
	Thu, 10 Oct 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="liuRLKXC"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E61BFDEB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554311; cv=none; b=AsBMlBKt5WvcfC8kiGcK+gi8VC3FXBYFdzd2CT1LL7YuLT1SYrkEMTHTxEMLatUWBNfhpCodJYEAULFH+AEbqlyis9Tk5QDYkaD8bMQg5SpGcW36Apz7bkdRhD7PPMV2Y9GwLmgz07MBmGaAODT3gXpv1XQcA3esA761mhqp4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554311; c=relaxed/simple;
	bh=fipWSVqfJTIQ/t8ZyHaxcVq5Em65bazNxVMdGA1/PJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1AzmfgxGLM+a9gBmPyjNFUMOfHNChiCl4b5lOmn4COC4FWKER0gOmcni9MQsbC/rYvyEtgAABf/3LpuwEi1TqaU9iKCdAUgzrL0UxJuKN/J/0ar8K9GRDycZuZJYuxTSaBjaFZ5RVo83JGk7XO1uoXXd6p2tGMk43AAJbEScNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=liuRLKXC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728554301; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UsgmxRS9TKs/0ogcQ76wiAy1j6N7MLMM/FjqAS25YQo=;
	b=liuRLKXCh3Z8VQnKAEfRp8eTtKweIxMqov8MQ5rrJWv7TfXTalyE5xxey29UzYimsMr+eh+44lKG5gfG3uLJqN6V5l3fEcuUW5wviI0GKw8+VQV/hGTZkN5IEwhRnEWls/AF18Kw5vFo0/gU3Ki7/VQ4WN6vgfG5R2Qla/AR28w=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGlzQXz_1728554299 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:58:20 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/4] mm: shmem: change shmem_huge_global_enabled() to return huge order bitmap
Date: Thu, 10 Oct 2024 17:58:12 +0800
Message-Id: <b1804b973d3ee800a2f233be45732b71ce3917cb.1728548374.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the shmem_huge_global_enabled() to return the suitable huge
order bitmap, and return 0 if huge pages are not allowed. This is a
preparation for adding a new huge option to support various huge
orders allocation in the following patch.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0613421e09e7..f04935722457 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -548,48 +548,48 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-					loff_t write_end, bool shmem_huge_force,
-					struct vm_area_struct *vma,
-					unsigned long vm_flags)
+static unsigned int __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+						loff_t write_end, bool shmem_huge_force,
+						struct vm_area_struct *vma,
+						unsigned long vm_flags)
 {
 	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
-		return false;
+		return 0;
 	if (mm && ((vm_flags & VM_NOHUGEPAGE) || test_bit(MMF_DISABLE_THP, &mm->flags)))
-		return false;
+		return 0;
 	if (shmem_huge == SHMEM_HUGE_DENY)
-		return false;
+		return 0;
 	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
-		return true;
+		return BIT(HPAGE_PMD_ORDER);
 
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
-		return true;
+		return BIT(HPAGE_PMD_ORDER);
 	case SHMEM_HUGE_WITHIN_SIZE:
 		index = round_up(index + 1, HPAGE_PMD_NR);
 		i_size = max(write_end, i_size_read(inode));
 		i_size = round_up(i_size, PAGE_SIZE);
 		if (i_size >> PAGE_SHIFT >= index)
-			return true;
+			return BIT(HPAGE_PMD_ORDER);
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
 		if (mm && (vm_flags & VM_HUGEPAGE))
-			return true;
+			return BIT(HPAGE_PMD_ORDER);
 		fallthrough;
 	default:
-		return false;
+		return 0;
 	}
 }
 
-static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 		   loff_t write_end, bool shmem_huge_force,
 		   struct vm_area_struct *vma, unsigned long vm_flags)
 {
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
-		return false;
+		return 0;
 
 	return __shmem_huge_global_enabled(inode, index, write_end,
 					   shmem_huge_force, vma, vm_flags);
@@ -771,11 +771,11 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	return 0;
 }
 
-static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 		loff_t write_end, bool shmem_huge_force,
 		struct vm_area_struct *vma, unsigned long vm_flags)
 {
-	return false;
+	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -1170,7 +1170,8 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	generic_fillattr(idmap, request_mask, inode, stat);
 	inode_unlock_shared(inode);
 
-	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
+	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0) ==
+	    BIT(HPAGE_PMD_ORDER))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1679,7 +1680,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
 	unsigned long vm_flags = vma ? vma->vm_flags : 0;
-	bool global_huge;
+	unsigned int global_order;
 	loff_t i_size;
 	int order;
 
@@ -1691,14 +1692,14 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
 		return 0;
 
-	global_huge = shmem_huge_global_enabled(inode, index, write_end,
+	global_order = shmem_huge_global_enabled(inode, index, write_end,
 					shmem_huge_force, vma, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
 		/*
 		 * For tmpfs, we now only support PMD sized THP if huge page
 		 * is enabled, otherwise fallback to order 0.
 		 */
-		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
+		return global_order;
 	}
 
 	/*
@@ -1731,7 +1732,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (vm_flags & VM_HUGEPAGE)
 		mask |= READ_ONCE(huge_shmem_orders_madvise);
 
-	if (global_huge)
+	if (global_order > 0)
 		mask |= READ_ONCE(huge_shmem_orders_inherit);
 
 	return THP_ORDERS_ALL_FILE_DEFAULT & mask;
-- 
2.39.3



Return-Path: <linux-kernel+bounces-424344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A39DB33D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51402282088
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7114D6F6;
	Thu, 28 Nov 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BFfSP/Ew"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182814C5A1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779668; cv=none; b=kyzWCP9QnMBpFitY+UlNeiYPP481Sr0vX1OWPtBJopjLkmn+nNFfpIPLS1Ae8OssCWVGCRjTYZpz/P5vmxK/Xgnbp9DxPKIo8pjwWrBJqsy3jnIVKSKLB47Ujxd5Iu/rguqRoTRTVPZ+kRNUn1fYc1dW0H2M8/RiTIt1lqz3NrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779668; c=relaxed/simple;
	bh=fmE+8kcWAfwmmwGyuEAamj+cnsMWh8q4bxMzmNti21o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrooJHjsRBCQ2u9Rnl23q8Hmki4eI6haA78M9w7pVGQrBaiKiYWooI/h32Izx3IkfoNm0AJVVdB8oNbuP7ZtgoDFaMn4PAvL7lELIK18Wak/sWp0Wna7yKh5Eme8nXthql34lkQbNf5WknlNPX0Ltj2koWyiK3Irjd6YuPEPs1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BFfSP/Ew; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779658; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6HM6mcd3kWqgluzVJQFUY15MBVLtFMN3usvJqqfXf8k=;
	b=BFfSP/EweevsJSGKCfK0f/ZTFDpI3atJtKf6aSZPcTJEZIFmNM5s6rSTLqKfrP/ubsFdAu3mWKyem0m2PRMNyZfXbqUn2x3vfKl5XxIBJkd+c9oEoMAlOJUwtodqqqHYdextsfmjmca3jMPGttk39hbzgDBvaWsq0BmF4KduDc8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKP.Wk0_1732779655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:40:56 +0800
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
Subject: [PATCH v3 2/6] mm: shmem: change shmem_huge_global_enabled() to return huge order bitmap
Date: Thu, 28 Nov 2024 15:40:40 +0800
Message-Id: <9dce1cfad3e9c1587cf1a0ea782ddbebd0e92984.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the shmem_huge_global_enabled() to return the suitable huge
order bitmap, and return 0 if huge pages are not allowed. This is a
preparation for supporting various huge orders allocation of tmpfs
in the following patches.

No functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/shmem.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ccb9629a0f70..7595c3db4c1c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -554,37 +554,37 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-				      loff_t write_end, bool shmem_huge_force,
-				      unsigned long vm_flags)
+static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+					      loff_t write_end, bool shmem_huge_force,
+					      unsigned long vm_flags)
 {
 	loff_t i_size;
 
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
-		return false;
+		return 0;
 	if (!S_ISREG(inode->i_mode))
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
 		if (vm_flags & VM_HUGEPAGE)
-			return true;
+			return BIT(HPAGE_PMD_ORDER);
 		fallthrough;
 	default:
-		return false;
+		return 0;
 	}
 }
 
@@ -779,11 +779,11 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	return 0;
 }
 
-static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
-				      loff_t write_end, bool shmem_huge_force,
-				      unsigned long vm_flags)
+static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+					      loff_t write_end, bool shmem_huge_force,
+					      unsigned long vm_flags)
 {
-	return false;
+	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -1685,21 +1685,21 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
 	unsigned long vm_flags = vma ? vma->vm_flags : 0;
-	bool global_huge;
+	unsigned int global_orders;
 	loff_t i_size;
 	int order;
 
 	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags)))
 		return 0;
 
-	global_huge = shmem_huge_global_enabled(inode, index, write_end,
-						shmem_huge_force, vm_flags);
+	global_orders = shmem_huge_global_enabled(inode, index, write_end,
+						  shmem_huge_force, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
 		/*
 		 * For tmpfs, we now only support PMD sized THP if huge page
 		 * is enabled, otherwise fallback to order 0.
 		 */
-		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
+		return global_orders;
 	}
 
 	/*
@@ -1732,7 +1732,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (vm_flags & VM_HUGEPAGE)
 		mask |= READ_ONCE(huge_shmem_orders_madvise);
 
-	if (global_huge)
+	if (global_orders > 0)
 		mask |= READ_ONCE(huge_shmem_orders_inherit);
 
 	return THP_ORDERS_ALL_FILE_DEFAULT & mask;
-- 
2.39.3



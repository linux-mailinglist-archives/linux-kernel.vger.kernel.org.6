Return-Path: <linux-kernel+bounces-248611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652E92DFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E443E1F23B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FC824AD;
	Thu, 11 Jul 2024 05:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BxrhQxEt"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798E6BB33
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676594; cv=none; b=L7HHXlTuR5aI0cB43zatjrfQjar4tApKX09l1xZ+tPia2oeZKYuuZeDxtRJPuYULoqbHgRngbItD6z8NvCXsRFRY+j/R9GTH7Fu4XLeWfuDwTH46RG1kaesJ/wHrQMN6TK9pEJvi3o6zUjuc1LKy/4ltFhy9Ujq8ANG3RZwTjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676594; c=relaxed/simple;
	bh=XHf0EOHfMZxurw0jxGXTS2u4VOUHYpcwyRa19VHm9gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yr4NUK6XRgRMVMSJ2dUtUjx5g4DlcHJxMDyvOSxrKZZbGlgFl7xbsn4vKWPOwS5NS2bu66hj1vRQQHYEm0TS4Bcnh/eG2HzzmEKAYUOqxKC72tNBuQFECHXtEE6cb+Hqj7IZ/PLY2DF4ESGQkF/0TKI6U6WKbrH1MRLtMzMA5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BxrhQxEt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676584; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Tf+iCn9J1tf0mbYcwxtjryzLvO9qhkxHYDxVzJSYovE=;
	b=BxrhQxEtbli+47xppl0IVX7etc5krAhlGg23/ArjBZZN56d0pBytzcT7Rv3ve58H1hmsqCxNsCCWQhkQ1Y1BI76tcRd0rQq4S7HNO6erksvdEJjR7SDkwXs+Hp2iC+ykqv7ijoa4pedtZkEOgjjI57Om2cgTCy+9Gh4PMQzLTN8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAImoHy_1720676583;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAImoHy_1720676583)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:43:03 +0800
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
Subject: [PATCH 2/3] mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
Date: Thu, 11 Jul 2024 13:42:49 +0800
Message-Id: <26dfca33f394b5cfa68e4dbda60bf5f54e41c534.1720668581.git.baolin.wang@linux.alibaba.com>
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

The shmem_is_huge() is now used to check if the top-level huge page is enabled,
thus rename it to reflect its usage.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/shmem_fs.h |  9 +++++----
 mm/huge_memory.c         |  5 +++--
 mm/shmem.c               | 15 ++++++++-------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1d06b1e5408a..405ee8d3589a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -111,14 +111,15 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-			  struct mm_struct *mm, unsigned long vm_flags);
+extern bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+				      struct mm_struct *mm, unsigned long vm_flags);
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				bool global_huge);
 #else
-static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-					  struct mm_struct *mm, unsigned long vm_flags)
+static __always_inline bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+						      bool shmem_huge_force, struct mm_struct *mm,
+						      unsigned long vm_flags)
 {
 	return false;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f9696c94e211..cc9bad12be75 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -152,8 +152,9 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * own flags.
 	 */
 	if (!in_pf && shmem_file(vma->vm_file)) {
-		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
-							!enforce_sysfs, vma->vm_mm, vm_flags);
+		bool global_huge = shmem_huge_global_enabled(file_inode(vma->vm_file),
+							     vma->vm_pgoff, !enforce_sysfs,
+							     vma->vm_mm, vm_flags);
 
 		if (!vma_is_anon_shmem(vma))
 			return global_huge ? orders : 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index db7e9808830f..1445dcd39b6f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -548,9 +548,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
-			    bool shmem_huge_force, struct mm_struct *mm,
-			    unsigned long vm_flags)
+static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
+					bool shmem_huge_force, struct mm_struct *mm,
+					unsigned long vm_flags)
 {
 	loff_t i_size;
 
@@ -581,14 +581,15 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
 	}
 }
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index,
+bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 		   bool shmem_huge_force, struct mm_struct *mm,
 		   unsigned long vm_flags)
 {
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
 		return false;
 
-	return __shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags);
+	return __shmem_huge_global_enabled(inode, index, shmem_huge_force,
+					   mm, vm_flags);
 }
 
 #if defined(CONFIG_SYSFS)
@@ -1156,7 +1157,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(idmap, request_mask, inode, stat);
 
-	if (shmem_is_huge(inode, 0, false, NULL, 0))
+	if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -2153,7 +2154,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	huge = shmem_is_huge(inode, index, false, fault_mm,
+	huge = shmem_huge_global_enabled(inode, index, false, fault_mm,
 			     vma ? vma->vm_flags : 0);
 	/* Find hugepage orders that are allowed for anonymous shmem. */
 	if (vma && vma_is_anon_shmem(vma))
-- 
2.39.3



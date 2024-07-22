Return-Path: <linux-kernel+bounces-258472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407693886F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12D81F214C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6CA17BA9;
	Mon, 22 Jul 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VX3tETft"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9914F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627012; cv=none; b=nNMydksJIoXVEtgkoUF7VAZq99M/k9UDGcRi0piEKDYX0Zk3T216RHvKwj9yCD6bF2JbxUsrPol6jx5j/xiO6BxWeWpK+i1h/r5KeQkshnfuiCqiGgS875iMjb6Sxtuyyvqt3szPW20X/tKW9lVQwiY7DIeQ80jbq8uN2ZWKNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627012; c=relaxed/simple;
	bh=EP3U98vGFxY59Gx7ky5KCF0xr/ngVb/82bqiTpE9MuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQeGdsJ2fF5z+KyRNz0UgqW+h5c8bfgChppEBLPisUyrv9V6TnPM/Ue4wLyE/zSfEkQuikIzWjD5/oYgdPSY3riaAuXnvRf56cjX5DW+a3hUEhkfTlCPJyScrMMhe8TvVkVHJCKvKABoa73ajBqFRj6XDnRhoL0wUsdoChZDfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VX3tETft; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721627007; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0R5gZULxFaFfXiCneasc1B0qQrqeZpO2sMKXtBQXAHQ=;
	b=VX3tETft68JnLqMQ90bz9ii8s7dfzAo5Y1VfYBz/123/BBGQ4atByOXu8x6w3VeuctvidddSuMm7smVZSHayxsMO34HQSru6dTRTjL76EFCevjGV6XsSoCBMHbkyZhql82gDyECDCFil2YYpxIo4eBNRu8rhiY4KTgTxWO8cWYY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAyvGdz_1721627005;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAyvGdz_1721627005)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 13:43:26 +0800
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
Subject: [PATCH v3 2/3] mm: shmem: rename shmem_is_huge() to shmem_huge_global_enabled()
Date: Mon, 22 Jul 2024 13:43:18 +0800
Message-Id: <da53296e0ab6359aa083561d9dc01e4223d60fbe.1721626645.git.baolin.wang@linux.alibaba.com>
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

The shmem_is_huge() is now used to check if the top-level huge page is enabled,
thus rename it to reflect its usage.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
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
index f4be468e06a4..e8388ea33f50 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -160,8 +160,9 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
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



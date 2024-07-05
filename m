Return-Path: <linux-kernel+bounces-241907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67093928100
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CF9B24909
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F754907;
	Fri,  5 Jul 2024 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="akHYIO09"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4A405F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720151002; cv=none; b=vDMylm8Uzrl6rTDRuFd8wCDtTdsOxbZ+FIBiK+bKotHWqMIK3fWKq87IubMkvFGRk5SGowDseMzlqgvbBUYO3lwpGQ7FIHlhbw/+7Tn8eAyMFHGUFjaQxZ8K5IqqgQM0wSC/j5NgPrPy4VVtx4BIr9VqpUv+tMxLpco1CJsrse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720151002; c=relaxed/simple;
	bh=ZXqZ1PcybXz7895d5I5LrLYVvlrfCfBgScgshJaEiwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rK4SFxb/7djxoDAKoawdP7+c406kcF1Ir2Td4FzOYjPo4a5NhZfni4spG23jadHLd7Yuq4GjF54fpbXrpu0Z4Nt86+I2jpVR4IpYyxhcVID4MHocEw3dcAn7FobP+Bf4eo5eJHWqmJDcb5f6bxFZXs1kYLT7M/gcOn3TSxeKXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=akHYIO09; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1720150990; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PTxaSy/xyHc/dtvyw/JMkIpW3687C+jvVP+ug6ie0xw=;
	b=akHYIO09LEWR0TptyyBBujc2629TTAyOrFrAbJfUGWLYIuIx8YfD+IQavkrwHLeKZpqRAR6VLUNO3CGlyT6mLfpXsKrIQWOqY76DimqH4Eqn38KmXwAYYSsQh2HuFsgNhSN3F+X5JxoodBvkT6y2Q2SN3Q584eriI3Dcpm7A8mo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037136014;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.YHsYYIU_1720150054;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YHsYYIU_1720150054)
          by smtp.aliyun-inc.com;
          Fri, 05 Jul 2024 11:27:35 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: hughd@google.com,
	akpm@linux-foundation.org
Cc:  <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <wangkefeng.wang@huawei.com>,
   <baolin.wang@linux.alibaba.com>,
   <ioworker0@gmail.com>,
   <ziy@nvidia.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v3] mm: thp: support "THPeligible" semantics for mTHP with anonymous shmem
Date: Fri, 05 Jul 2024 11:23:09 +0800
Message-Id: <20240705032309.24933-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
anonymous shmem"), we can configure different policies through
the multi-size THP sysfs interface for anonymous shmem. But
currently "THPeligible" indicates only whether the mapping is
eligible for allocating THP-pages as well as the THP is PMD
mappable or not for anonymous shmem, we need to support semantics
for mTHP with anonymous shmem similar to those for mTHP with
anonymous memory.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
Changes since v2 [2]:
 - Move shmem_allowable_huge_orders() to shmem_fs.h (per Baolin)
 - clean up these coding style issues (per Ryan)

Changes since v1 [1]:
 - Put anonymous shmem mthp related logic into
   thp_vma_allowable_orders() (per David)

[1] https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
[2] https://lore.kernel.org/linux-mm/20240702023401.41553-1-libang.li@antgroup.com/

 include/linux/shmem_fs.h |  9 +++++++++
 mm/huge_memory.c         | 13 +++++++++----
 mm/shmem.c               |  9 +--------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3fb18f7eb73e..1d06b1e5408a 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -113,12 +113,21 @@ int shmem_unuse(unsigned int type);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 			  struct mm_struct *mm, unsigned long vm_flags);
+unsigned long shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge);
 #else
 static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 					  struct mm_struct *mm, unsigned long vm_flags)
 {
 	return false;
 }
+static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SHMEM
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5cbd838e96e6..0985bd75a624 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -151,10 +151,15 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * Must be done before hugepage flags check since shmem has its
 	 * own flags.
 	 */
-	if (!in_pf && shmem_file(vma->vm_file))
-		return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
-				     !enforce_sysfs, vma->vm_mm, vm_flags)
-			? orders : 0;
+	if (!in_pf && shmem_file(vma->vm_file)) {
+		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
+							!enforce_sysfs, vma->vm_mm, vm_flags);
+
+		if (!vma_is_anon_shmem(vma))
+			return global_huge ? orders : 0;
+		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
+							vma, vma->vm_pgoff, global_huge);
+	}
 
 	if (!vma_is_anonymous(vma)) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index f24177e9d5cc..921d59c3d669 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static unsigned long shmem_allowable_huge_orders(struct inode *inode,
+unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				bool global_huge)
 {
@@ -1707,13 +1707,6 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 	return orders;
 }
 #else
-static unsigned long shmem_allowable_huge_orders(struct inode *inode,
-				struct vm_area_struct *vma, pgoff_t index,
-				bool global_huge)
-{
-	return 0;
-}
-
 static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
 					   struct address_space *mapping, pgoff_t index,
 					   unsigned long orders)
-- 
2.19.1.6.gb485710b



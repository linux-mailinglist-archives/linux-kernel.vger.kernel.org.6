Return-Path: <linux-kernel+bounces-233768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E073991BCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA7FB2032B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DC155747;
	Fri, 28 Jun 2024 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="UlZW5/Px"
Received: from out187-2.us.a.mail.aliyun.com (out187-2.us.a.mail.aliyun.com [47.90.187.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750F1459EF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571810; cv=none; b=rw0C6ECLnlf4jSjhnguwoBORp6BrbwYqCFFe0/IB3HsyHCTxVOdDKHVw6znrlWr8EwcEDO+QhnISFMy5QGBbKK9vMbYkKM+6jXOLQwxWFRfmiyfZbrzbZRSUTvdF4r+bUTY52/aTrFHMKJPZgqx+7bNbOMZYnIWiHJwEEazbwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571810; c=relaxed/simple;
	bh=9icl2M1nIaxMsLS/xkjRdnN+tiSDjEtL2rllD0abne4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJFY5CiPvD/7acrJemQFKXmlPXzjrGsK8/cC1dd96z4Uvu2M7VkjJNcwjc5J6dejqmo2mxB0AFTDViv+m8yoyigV4AB5MDE3Sul/iidhRwkbpj0VdKUCLeezlFKat0XwKawMM7fRveAZ1e7S2eOPd8wlVf0nEaBc11Cnais/bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=UlZW5/Px; arc=none smtp.client-ip=47.90.187.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719571789; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PmC6WY0awgsY9XoqlRu++2CjZX1SiBFOFYun5TXen0I=;
	b=UlZW5/Px0r0H/u4/ZMS/FrCQTXdgi314V1Pf7PQVFXGBbcpo2+X/PQbWcjo9xr/r63fpLPGfilqxjPgx4EG2V5fg6xAuVslv9oquBXbTBJr7wmw+R5erUytCmiibE2Qqll8sC0UxdjACYYhB6XiSpG+m2ibmhCH3K7PGZ6TetPk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023108233;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.YCQ5T17_1719571788;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YCQ5T17_1719571788)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 18:49:48 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: hughd@google.com,
	akpm@linux-foundation.org
Cc:  <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <wangkefeng.wang@huawei.com>,
   <baolin.wang@linux.alibaba.com>,
   <ziy@nvidia.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH] support "THPeligible" semantics for mTHP with anonymous shmem
Date: Fri, 28 Jun 2024 18:49:26 +0800
Message-Id: <20240628104926.34209-1-libang.li@antgroup.com>
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
 fs/proc/task_mmu.c      | 10 +++++++---
 include/linux/huge_mm.h | 11 +++++++++++
 mm/shmem.c              |  9 +--------
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 93fb2c61b154..09b5db356886 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
 {
 	struct vm_area_struct *vma = v;
 	struct mem_size_stats mss = {};
+	bool thp_eligible;
 
 	smap_gather_stats(vma, &mss, 0);
 
@@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:    %8u\n",
-		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
-			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
+	thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
+						TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
+	if (vma_is_anon_shmem(vma))
+		thp_eligible = !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
+							vma, vma->vm_pgoff, thp_eligible);
+	seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 212cca384d7e..f87136f38aa1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
 
+unsigned long shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge);
+
 struct thpsize {
 	struct kobject kobj;
 	struct list_head node;
@@ -460,6 +464,13 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return 0;
 }
 
+static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
+				struct vm_area_struct *vma, pgoff_t index,
+				bool global_huge)
+{
+	return 0;
+}
+
 #define transparent_hugepage_flags 0UL
 
 #define thp_get_unmapped_area	NULL
diff --git a/mm/shmem.c b/mm/shmem.c
index d495c0701a83..aa85df9c662a 100644
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



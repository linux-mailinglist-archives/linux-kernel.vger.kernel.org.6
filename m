Return-Path: <linux-kernel+bounces-237168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F491ED01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22111C22306
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697915E85;
	Tue,  2 Jul 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="1GxGAz3S"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA0E101E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887880; cv=none; b=tyAjCr3kVQPD/BWAb9zKA4RFR3eFj3aJ8856EO6QbFNQIUyyfYM47H/w6dnOgk6T01hDykX3RKdfG+2ySYmDTqp6mwpnLu8skVLcmBxiuTDg3/9Gwd9s9AwRrArz+aWMhDl3ZqWvRzTW4Py5/y8dC91Grc9fmbKydnmKzZTpOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887880; c=relaxed/simple;
	bh=DQlNrY6GpPnwFvmd+8wGYRreV8/2u30pY/SEpRMlZbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWC4n6IF0DSV+e24h15U2UJ7pmEmk2Qa3D9tzV0jGjWMclBoddZroiiu547q5AZGL7xLH3ZfedQuZmQL3thnHdVOLiqq9ZPQru5i6NntLQFtjFGxKZXi9C7iGhZcSgeIQkTeX2PwvWU4d6r1IsQaMZfEPdAlhe6eC5mrSgLabwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=1GxGAz3S; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719887875; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=24NgFMDS5S3jO5/FabpLcvF++s2Y5El1WGn9ifWoN/4=;
	b=1GxGAz3SPPmrKqAg1B29gEAVKeniRaFegmcKlSk1x6dZcwqXD0BgIWhypR+rnBv7DkjR7Yk6U7g7WyWJw7IqIQ8CDxdAPd79UIlQ5oAzk85hNWElkj4narvtkDm0emNebFSy0YUDRFuP1wk5+8jTa3vSLCTQeIlisCZdKr5GJQQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.YEjSGUT_1719887873;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YEjSGUT_1719887873)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 10:37:54 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: ughd@google.com,
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
Subject: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with anonymous shmem
Date: Tue, 02 Jul 2024 10:34:01 +0800
Message-Id: <20240702023401.41553-1-libang.li@antgroup.com>
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
Changes since v1 [1]:
 - Put anonymous shmem mthp related logic into
   thp_vma_allowable_orders() (per David)

[1] https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
---
 include/linux/huge_mm.h | 11 +++++++++++
 mm/huge_memory.c        | 13 +++++++++----
 mm/shmem.c              |  9 +--------
 3 files changed, 21 insertions(+), 12 deletions(-)

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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ce28f6b7f3..ea377bb4af91 100644
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
+			return global_huge? orders : 0;
+		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
+							vma, vma->vm_pgoff, global_huge);
+	}
 
 	if (!vma_is_anonymous(vma)) {
 		/*
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



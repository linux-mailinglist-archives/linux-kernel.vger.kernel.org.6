Return-Path: <linux-kernel+bounces-248612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2092DFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74572821F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433F82D93;
	Thu, 11 Jul 2024 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jGG/KTCI"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4876F17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676594; cv=none; b=Kyht9tRkB8vXy79FQYe0Qm8PRiAeG36j6jHcN8o1hCm6zOQ5QMd489tPse90/abRA37+fFx5TBIS10NIUSs6JkQI+ZkI+7+nFUyOy8zLhlmFXDKCRtFCC+wPALnTzqDnPn5zfcnoeJHwi6jS+FfU+uSxkSUM4edAU/T7e/TYWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676594; c=relaxed/simple;
	bh=rnh/gdjtI1oxPoycpAJ+xeQh9rAzDKM3Ht4nketAmOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sdk08X7V/le0h6FRUag0SLTMxwrBtThRSk9UjhPaLORPEm7fAv3y65ndvXSDvwWHhu0NecfB0QV3d+kipW9LMsuY8m7Z7Un+npl3JrGzalF/vnMu7rCnZzdXjmhcMdLPZvkHDCKjkK3yZyq9D2NIHmeXl/ToFVeCmUbbteASuLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jGG/KTCI; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720676584; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Djj9GEjNq9Gnbpe2Z/mIcDmYI8xxQmETjEn+X/PnVoU=;
	b=jGG/KTCIeYyeVBRS3BCCHLtIx8JThb0AKdiik/kunnJXciksjQbwMSc+XIJKyrRnk3n5kO4GahoxmbkVB9hM9dwqsuRx3ZQLUGTqdza++zCy2VynkThvaDcv+wHLDyg289Jr+Kwq5SN2hcL9aCaQdkojCeP4EolAG4d2BY6tslk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAIiL2T_1720676582;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAIiL2T_1720676582)
          by smtp.aliyun-inc.com;
          Thu, 11 Jul 2024 13:43:02 +0800
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
Subject: [PATCH 1/3] mm: shmem: simplify the suitable huge orders validation for tmpfs
Date: Thu, 11 Jul 2024 13:42:48 +0800
Message-Id: <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720668581.git.baolin.wang@linux.alibaba.com>
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

Move the suitable huge orders validation into shmem_suitable_orders() for
tmpfs, which can reuse some code to simplify the logic.

In addition, we don't have special handling for the error code -E2BIG when
checking for conflicts with PMD sized THP in the pagecache for tmpfs, instead,
it will just fallback to order-0 allocations like this patch does, so this
simplification will not add functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f24dfbd387ba..db7e9808830f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1685,19 +1685,29 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
 					   struct address_space *mapping, pgoff_t index,
 					   unsigned long orders)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	unsigned long pages;
 	int order;
 
-	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
-	if (!orders)
-		return 0;
+	if (vma) {
+		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+		if (!orders)
+			return 0;
+	}
 
 	/* Find the highest order that can add into the page cache */
 	order = highest_order(orders);
 	while (orders) {
 		pages = 1UL << order;
 		index = round_down(index, pages);
+		/*
+		 * Check for conflict before waiting on a huge allocation.
+		 * Conflict might be that a huge page has just been allocated
+		 * and added to page cache by a racing thread, or that there
+		 * is already at least one small page in the huge extent.
+		 * Be careful to retry when appropriate, but not forever!
+		 * Elsewhere -EEXIST would be the right code, but not here.
+		 */
 		if (!xa_find(&mapping->i_pages, &index,
 			     index + pages - 1, XA_PRESENT))
 			break;
@@ -1735,7 +1745,6 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
 	unsigned long suitable_orders = 0;
 	struct folio *folio = NULL;
 	long pages;
@@ -1745,26 +1754,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 		orders = 0;
 
 	if (orders > 0) {
-		if (vma && vma_is_anon_shmem(vma)) {
-			suitable_orders = shmem_suitable_orders(inode, vmf,
+		suitable_orders = shmem_suitable_orders(inode, vmf,
 							mapping, index, orders);
-		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
-			pages = HPAGE_PMD_NR;
-			suitable_orders = BIT(HPAGE_PMD_ORDER);
-			index = round_down(index, HPAGE_PMD_NR);
-
-			/*
-			 * Check for conflict before waiting on a huge allocation.
-			 * Conflict might be that a huge page has just been allocated
-			 * and added to page cache by a racing thread, or that there
-			 * is already at least one small page in the huge extent.
-			 * Be careful to retry when appropriate, but not forever!
-			 * Elsewhere -EEXIST would be the right code, but not here.
-			 */
-			if (xa_find(&mapping->i_pages, &index,
-				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
-				return ERR_PTR(-E2BIG);
-		}
 
 		order = highest_order(suitable_orders);
 		while (suitable_orders) {
-- 
2.39.3



Return-Path: <linux-kernel+bounces-258471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A293886E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA712813E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25565179A7;
	Mon, 22 Jul 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B3fXgEfz"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321982CA9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721627011; cv=none; b=g9IsOXoaEMviPjEkhLjTCvswZEDBAXPTuHh5pF7jkXOkrLO4zscedp6iGocbC7c2aOoa8SvNiOUXIt7g6bHfNHVuWkdfIqnWUpIhp0dQO/xMqK8qpsFx9Ad9PCnxdRPtvBoDNCqG0jBD9gJ3Zeb1Cxqq3fddboMh5dZDmbEHATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721627011; c=relaxed/simple;
	bh=ZBtUR8S0+hlO5kRXOi7pJzsYjhDbUXx7IBGwg1X+XbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfwxVRZ9tIX0nv0v2Chnn8SsbTejWp76VXbulJR6evkeYzQAYW16ZuzYssycKsFbwU0QvVEPHFT/0nM6cLYHuhpB0kG5URsjwek0pFCUC9H6iCkM5uq21FR/7+q/I61aTensnG8Z2M5jcgN1hgNkEOz3dlcHOmgWi47/ghDzOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B3fXgEfz; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721627006; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=J5dcVB7jyKKfrkmzqLedgx6fPLHuGxUqgTPplR6Z9pA=;
	b=B3fXgEfzTIVrgcooRFBrfBUun9/qZ832lWydINjVipHJy4VcZAwslQx7/txwODjPu5mAg12CVp3hyS7zgo2N6qC/Zn8uIH0kRnvvtYrbW8KgT3fj0YgCRW42jpOEnNH2pW9xKaYm+f/lUe1j2AI7jMYcVh5Y9/lMtbPPZtcFiRU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAyvGdp_1721627004;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAyvGdp_1721627004)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 13:43:25 +0800
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
Subject: [PATCH v3 1/3] mm: shmem: simplify the suitable huge orders validation for tmpfs
Date: Mon, 22 Jul 2024 13:43:17 +0800
Message-Id: <965985dd6d322929d78a0beee0dafa1c2a1b81e2.1721626645.git.baolin.wang@linux.alibaba.com>
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

Move the suitable huge orders validation into shmem_suitable_orders() for
tmpfs, which can reuse some code to simplify the logic.

In addition, we don't have special handling for the error code -E2BIG when
checking for conflicts with PMD sized THP in the pagecache for tmpfs, instead,
it will just fallback to order-0 allocations like this patch does, so this
simplification will not add functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
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



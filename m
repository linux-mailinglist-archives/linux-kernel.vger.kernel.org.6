Return-Path: <linux-kernel+bounces-251515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051419305C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B061F23B20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC3132C3B;
	Sat, 13 Jul 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wAilkOtJ"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762C71B5B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720877080; cv=none; b=jgDVdx0j78vgDURGtpnZDc60/r1zR5CfGBUf4AMzv63d+0MiVbGMrJHF9v47yrrfjlAxXqDvo37CT1Hd7T+VkFkRK5W+nM7GCc1G4imH7sEXwjCzkTNX4pOZmZzG2H2Y8rd2C4GaxkerDH7WyHmKVTgYRh2LUtOkIIBVakXRTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720877080; c=relaxed/simple;
	bh=rnh/gdjtI1oxPoycpAJ+xeQh9rAzDKM3Ht4nketAmOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+FBiTmLN3eKrI0t9P9wpiJSG0bixWIAMd72gaeLfaLK5hZMkB4iXhtB5HjMcTX6hVdBqD6zg3c8z108nlmIkYBVh15FjDzF6A42Bi7EAbq/2FjWQuSBlIWdmjfz624eNtspPDfSl8yXKwExwG7RYWGUH9Z61M4BdBdi1PJpZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wAilkOtJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720877070; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Djj9GEjNq9Gnbpe2Z/mIcDmYI8xxQmETjEn+X/PnVoU=;
	b=wAilkOtJTLL7pXwDCo1LN7QFdB5662AyGkhO0hP09NlWUEtRDzvrUk5+f/4uqdjQRYFHNU+mAi1QeCoktRS48O7wdb2RxsZYMFv/6EGbjhBhDnhunWFzUJic/CvhT+vSp8mfSfcvh80gfoHo8UjXKoQdzoiAnJcerWFpnyPZ66k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0WAR0qHL_1720877068;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAR0qHL_1720877068)
          by smtp.aliyun-inc.com;
          Sat, 13 Jul 2024 21:24:29 +0800
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
Subject: [PATCH v2 1/3] mm: shmem: simplify the suitable huge orders validation for tmpfs
Date: Sat, 13 Jul 2024 21:24:20 +0800
Message-Id: <ee1b6ac287bb376a9da88a23e1ef16951eb94a4e.1720755678.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
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



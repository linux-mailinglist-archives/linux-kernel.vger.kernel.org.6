Return-Path: <linux-kernel+bounces-330550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0997A008
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7C91F21531
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAA15852E;
	Mon, 16 Sep 2024 11:08:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9B8156669
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484897; cv=none; b=AgrKVr9QX9KDyGP+LfpmtHFwS5cEcN1wk2lIvlDxL3BMgE02KpRAZlcXTi03/UBy9+0rUti2BqdYD69/60KwgWbu+oC+tEwiaX4L/4hE+Y7wVoWsp+e8nk+O+GtNGGNGNqEpkMSYks8L6IoLkG/fSU11TDGgEcs67YcuVnEvlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484897; c=relaxed/simple;
	bh=V6IxSOPgjarAnGow85o/zhAKZ9XcJUJ0lh689/3MORk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kure7b/oDCQilohuuu+x32zuANQEbwOEa5UIXzEEs8+6fEW/Cbkbu7vaA/Pt6X8Abfe57HeI8zQWDCDyvSqQSQmjBtaDgjCsZw4H9r+cT1tpAg/c+oV5pdoSy7rmCEDKAJUU10wqaPYslnIdWzmcHph1x00Iq7uxdVgkX9CmZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F8571516;
	Mon, 16 Sep 2024 04:08:44 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E6013F64C;
	Mon, 16 Sep 2024 04:08:10 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	hughd@google.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com,
	gshan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 2/2] mm: Compute first_set_pte to eliminate evaluating redundant ranges
Date: Mon, 16 Sep 2024 16:37:54 +0530
Message-Id: <20240916110754.1236200-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916110754.1236200-1-dev.jain@arm.com>
References: <20240916110754.1236200-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For an mTHP allocation, we need to check, for every order, whether for
that order, we have enough number of contiguous PTEs empty. Instead of
iterating the while loop for every order, use some information, which
is the first set PTE found, from the previous iteration to eliminate
some cases. The key to understanding the correctness of the patch
is that the ranges we want to examine form a strictly decreasing
sequence of nested intervals.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8bb1236de93c..e81c6abe09ce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4633,10 +4633,11 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	pte_t *first_set_pte = NULL, *align_pte, *pte;
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
-	pte_t *pte;
+	int max_empty;
 	gfp_t gfp;
 	int order;
 
@@ -4671,8 +4672,23 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	order = highest_order(orders);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		if (pte_range_none(pte + pte_index(addr), 1 << order) == 1 << order)
+		align_pte = pte + pte_index(addr);
+
+		/* Range to be scanned known to be empty */
+		if (align_pte + (1 << order) <= first_set_pte)
+			break;
+
+		/* Range to be scanned contains first_set_pte */
+		if (align_pte <= first_set_pte)
+			goto repeat;
+
+		/* align_pte > first_set_pte, so need to check properly */
+		max_empty = pte_range_none(align_pte, 1 << order);
+		if (max_empty == 1 << order)
 			break;
+
+		first_set_pte = align_pte + max_empty;
+repeat:
 		order = next_order(&orders, order);
 	}
 
-- 
2.30.2



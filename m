Return-Path: <linux-kernel+bounces-576456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13641A70F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3B2179486
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1A161321;
	Wed, 26 Mar 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mz6fdK0n"
Received: from out199-18.us.a.mail.aliyun.com (out199-18.us.a.mail.aliyun.com [47.90.199.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1114B96E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960326; cv=none; b=FxbvAHswRl7n7Cn7zHsLSTFy2TtRnWlGAEU6XA1xIH50JvIUZGskjgpC+rxN3KciuaEQpPhSeTrAFwmKk56kgbIJ/y3nYYZvnBeGsUP+ZM/B18XRro4qpWUdHe+80GOmrrOyi1bSS+Wte5/lAHtDf6zD3SnwqrB3StGYvn/db5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960326; c=relaxed/simple;
	bh=kzuBG+mctN9JNDwceI3PhK/fkfhKbsz2BUjJMajn7ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODjrqhvGOJFduxW3WMDTeTVpPDfj6whad69tS11WGJW+aCCtPipjpDVUi21rKYCNTJl1oUOXltv5Af0+kk71Nn/WKtkvn8vcQmDg4KHw6qzfeO7tDqeM5mg+pMmzudy6PTkHSUOwjLJAob7ZJRQt/dyrGlrAKlrMk9LOv7xaCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mz6fdK0n; arc=none smtp.client-ip=47.90.199.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742960304; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5NwoAahKKVIW1jwVHjfRD7hDZG4CMMysDy/7TbSbzCE=;
	b=mz6fdK0n95h+NiUBpVWdTyhVY16F6o1CJAgKqSbaVRiSrqXLg8LNHIv2fVHQa+k7accuCfN5sxOMotAnJQLLYugr54kgBklCjmCqWq4XHXt1GN3Iyf6pWACy12g6HHekujqMzW9a9cK0vdm35TDnzVZAXWc4zrIoVj7i2tQf3CE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WT1p3x3_1742960303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 11:38:24 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: mincore: use folio_pte_batch() to batch process large folios
Date: Wed, 26 Mar 2025 11:38:11 +0800
Message-ID: <7ad05bc9299de5d954fb21a2da57f46dd6ec59d0.1742960003.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1742960003.git.baolin.wang@linux.alibaba.com>
References: <cover.1742960003.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I tested the mincore() syscall, I observed that it takes longer with
64K mTHP enabled on my Arm64 server. The reason is the mincore_pte_range()
still checks each PTE individually, even when the PTEs are contiguous,
which is not efficient.

Thus we can use folio_pte_batch() to get the batch number of the present
contiguous PTEs, which can improve the performance. I tested the mincore()
syscall with 1G anonymous memory populated with 64K mTHP, and observed an
obvious performance improvement:

w/o patch		w/ patch		changes
6022us			1115us			+81%

Moreover, I also tested mincore() with disabling mTHP/THP, and did not
see any obvious regression.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/mincore.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 832f29f46767..88be180b5550 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -21,6 +21,7 @@
 
 #include <linux/uaccess.h>
 #include "swap.h"
+#include "internal.h"
 
 static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
@@ -105,6 +106,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte_t *ptep;
 	unsigned char *vec = walk->private;
 	int nr = (end - addr) >> PAGE_SHIFT;
+	int step, i;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -118,16 +120,31 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
-	for (; addr != end; ptep++, addr += PAGE_SIZE) {
+	for (; addr != end; ptep += step, addr += step * PAGE_SIZE) {
 		pte_t pte = ptep_get(ptep);
 
+		step = 1;
 		/* We need to do cache lookup too for pte markers */
 		if (pte_none_mostly(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
-		else if (pte_present(pte))
-			*vec = 1;
-		else { /* pte is a swap entry */
+		else if (pte_present(pte)) {
+			if (pte_batch_hint(ptep, pte) > 1) {
+				struct folio *folio = vm_normal_folio(vma, addr, pte);
+
+				if (folio && folio_test_large(folio)) {
+					const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
+								FPB_IGNORE_SOFT_DIRTY;
+					int max_nr = (end - addr) / PAGE_SIZE;
+
+					step = folio_pte_batch(folio, addr, ptep, pte,
+							max_nr, fpb_flags, NULL, NULL, NULL);
+				}
+			}
+
+			for (i = 0; i < step; i++)
+				vec[i] = 1;
+		} else { /* pte is a swap entry */
 			swp_entry_t entry = pte_to_swp_entry(pte);
 
 			if (non_swap_entry(entry)) {
@@ -146,7 +163,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 #endif
 			}
 		}
-		vec++;
+		vec += step;
 	}
 	pte_unmap_unlock(ptep - 1, ptl);
 out:
-- 
2.43.5



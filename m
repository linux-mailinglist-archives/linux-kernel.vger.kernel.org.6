Return-Path: <linux-kernel+bounces-293696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF83958332
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632441F24729
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8218D63E;
	Tue, 20 Aug 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I3hrRTUX"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A018C934
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147395; cv=none; b=lEEfvfqkqxWc9eSSHJ0oVc3lhhVQCKrYV52wbK/61+M7ZtT9twUcVAC4zlv9ZwdX5VB2ZPL/YZXICpjDEVwSe9IMcT8xjCqSYfKpqNmIjZ7MpK1fKFlBNCoH3wQ3cyQR+r8J2zbgWricx0cFq+G088doMtUGZvumb8PaREacfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147395; c=relaxed/simple;
	bh=qlwRIO49Vc2lc0IQpiHjd/WQEdaOL+IzAMESQpRaNO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltxE/y9fOeGbkW8lXeTHxfu9UIy8iaqv1o8MJA6+p3h/0yuvrjowzl7FI+n0AvvELjxXZIF6k6YlwOItER0I4iUrp4HW+he/cMWFjh586NQB8qcEud7th02Dq4MPJ+dKgstmfcMNBn8OWxglMHFzgUztpWxbHlZe2yCgqDM/uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I3hrRTUX; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147384; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bSL4r/U095xkuorzmW1ZSPtc/nQFSKSzXorZ/e7zvxM=;
	b=I3hrRTUXt8tNn83cwnt8KcDK2i9qpHVdnVPYfKJpvndmEJ2AJTehY7d6ZLT8+9u8vmelHxNH1wem/ZC5cC3lYzehRHdOfRCwQGexpNZ4B4GSCWv1Ud0I/3bqMuEFSJrsHQ7iH4hj8XwZQ0hSHtmS2+jju3VexQHU17gmL9KwUUw=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDIChLj_1724147383)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:44 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm: khugepaged: support shmem mTHP collapse
Date: Tue, 20 Aug 2024 17:49:16 +0800
Message-Id: <b9da76aab4276eb6e5d12c479af2b5eea5b4575d.1724140601.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
References: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shmem already supports the allocation of mTHP, but khugepaged does not yet
support collapsing mTHP folios. Now khugepaged is ready to support mTHP,
and this patch enables the collapse of shmem mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4996f7487c13..4a83c40d9053 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1843,7 +1843,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} while (1);
 
-	for (index = start; index < end; index++) {
+	for (index = start; index < end;) {
 		xas_set(&xas, index);
 		folio = xas_load(&xas);
 
@@ -1862,6 +1862,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					}
 				}
 				nr_none++;
+				index++;
 				continue;
 			}
 
@@ -1943,12 +1944,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * we locked the first folio, then a THP might be there already.
 		 * This will be discovered on the first iteration.
 		 */
-		if (folio_test_large(folio)) {
-			result = folio_order(folio) == HPAGE_PMD_ORDER &&
-					folio->index == start
-					/* Maybe PMD-mapped */
-					? SCAN_PTE_MAPPED_HUGEPAGE
-					: SCAN_PAGE_COMPOUND;
+		if (folio_order(folio) == HPAGE_PMD_ORDER &&
+		    folio->index == start) {
+			/* Maybe PMD-mapped */
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
 			goto out_unlock;
 		}
 
@@ -2009,6 +2008,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * Accumulate the folios that are being collapsed.
 		 */
 		list_add_tail(&folio->lru, &pagelist);
+		index += folio_nr_pages(folio);
 		continue;
 out_unlock:
 		folio_unlock(folio);
@@ -2261,16 +2261,10 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 			continue;
 		}
 
-		/*
-		 * TODO: khugepaged should compact smaller compound pages
-		 * into a PMD sized page
-		 */
-		if (folio_test_large(folio)) {
-			result = folio_order(folio) == HPAGE_PMD_ORDER &&
-					folio->index == start
-					/* Maybe PMD-mapped */
-					? SCAN_PTE_MAPPED_HUGEPAGE
-					: SCAN_PAGE_COMPOUND;
+		if (folio_order(folio) == HPAGE_PMD_ORDER &&
+		    folio->index == start) {
+			/* Maybe PMD-mapped */
+			result = SCAN_PTE_MAPPED_HUGEPAGE;
 			/*
 			 * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
 			 * by the caller won't touch the page cache, and so
-- 
2.39.3



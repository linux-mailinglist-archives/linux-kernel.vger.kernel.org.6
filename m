Return-Path: <linux-kernel+bounces-291668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BE956559
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DCD1F21DED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840F15B0EC;
	Mon, 19 Aug 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q+71b/vS"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DD15B542
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055300; cv=none; b=r1ZJBvFD2DbbHUP+lHd56Egay0CjNqgUEQF7oKAfgwO+LSDrChOdJ81SRG01r34tnDaAa/o9NFbyegp0o59v9ZLuPUxX12yu+r6mCmt7W6xbHLxUTz/VUp8J5ZxQz8jDZ/hC0FgWuFOVviCHrdxMwHSIeRHI7azR6cVay2fESCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055300; c=relaxed/simple;
	bh=BbsXRtILYWc1jNA6sN6O5EgMT7i8APGH25zxp413B8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkvtEhzm731982HLby5I7GhF6e3tPY8jejxNqI6Qj4LZFfEBceBfe5KVIeyYT4yC2GtrhIKUVy4/Cb+PGyjIgNFwWBAvfu7dSn+mVswVrUTWh9dhv0jIYwgL6shtgvnnQkSPaqOM4jvySAajsdD3+Ymtd7gv3iM65qiqhajvfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q+71b/vS; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724055289; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6V7YyBIVTByMizq9TfzYvtX9oniYv5CXu0xU9TzqEDc=;
	b=Q+71b/vSzeLvPa9Hru58MJMT8WGyNqTkr/emE5ReLwwngGl2f5CbXolV3ePve8ZKtDUjzZFEq6rQelThzmmr6k9EOv4u63cj4NKhgxcumrKoIsQHMDbbfmlby4mnK26Sl6jRuFkp3WIFfqMK6mxvTiMCVvIUotAPsv8zffJynss=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WD9CrIt_1724055288)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 16:14:49 +0800
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
Subject: [PATCH 4/5] mm: khugepaged: support shmem mTHP collapse
Date: Mon, 19 Aug 2024 16:14:05 +0800
Message-Id: <8a2a87affac65f2ecdcea9917b5ae7a261689676.1724054125.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
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
index 91ee672db202..4b35239b5e46 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1847,7 +1847,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 	} while (1);
 
-	for (index = start; index < end; index++) {
+	for (index = start; index < end;) {
 		xas_set(&xas, index);
 		folio = xas_load(&xas);
 
@@ -1866,6 +1866,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					}
 				}
 				nr_none++;
+				index++;
 				continue;
 			}
 
@@ -1947,12 +1948,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
 
@@ -2013,6 +2012,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		 * Accumulate the folios that are being collapsed.
 		 */
 		list_add_tail(&folio->lru, &pagelist);
+		index += folio_nr_pages(folio);
 		continue;
 out_unlock:
 		folio_unlock(folio);
@@ -2265,16 +2265,10 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
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



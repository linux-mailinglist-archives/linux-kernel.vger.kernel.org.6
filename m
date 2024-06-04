Return-Path: <linux-kernel+bounces-200007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FD8FA921
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1855A1F268AF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E8D13E889;
	Tue,  4 Jun 2024 04:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVNkYZ54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18C13E3F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474901; cv=none; b=cpuQYR1JG6gJZXH+qPGU4irxtJOMpqMDBu2CXxLGdewaq2OlBgZX+DqwvfP7QZOfIkxQdW3HN0qc1SdUqIu+ZqS3Pr42EfccTB0zTA9v4UYbYshFHOOWV3k32lZy+B4MV/z3kAMt0KfoinG3UKTlSsZWnxZM9Q6OiuDgfMbSBV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474901; c=relaxed/simple;
	bh=CfvlQ2M9KWnaqxKPXvUUKqZr9diZgDumxJiDtxK8xLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2rLiFrtFOCl+KnRj0qbfGN09UhVyxLmnHe6p0Q353GvjRLCOQshC42rL1WtEQNSHQh0Cw/7yhutXgfbiCgT1N3Yd7gXU/Mmm4Jut5FUQCySxqxc92ya0Krg62iyYZMo57IX3LFxO/Z0g/qo6EUctQZ1+0JRlFQnbATceYsyaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVNkYZ54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F25C32786;
	Tue,  4 Jun 2024 04:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474900;
	bh=CfvlQ2M9KWnaqxKPXvUUKqZr9diZgDumxJiDtxK8xLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LVNkYZ54FWWO0xDgawCPCmAKsUuesOzTQxtIVVhIDWRFB+BRrf0loqYP6nhYl+ZxY
	 4/FZDa5Z71YUuEhj74spNoj9ub6BKUBfz6kLqA4rTWFIZUJHInhVTnX/Q73H75AiZE
	 85lX1fl8SDh3Q25c6Noz3NN0Wl8T/1GRCbq6062CnvkbylpQ2xwZz64V3O1XnQv1GD
	 rbF+PTkdvZSFnKI6OjAVUsldEzoxEUdBOuyOnpHHZA6UHSgFrSTxZfnCboZeZh5zMn
	 hdaK9PWG/w+vABWb3fmiH/Jgh1v2eloKrI0GKrme2D4X1hpN3ameLMF8M7ylbqpR3O
	 9mJ/sbzJPl4rA==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 03/10] mm/ksm: use folio in try_to_merge_one_page
Date: Tue,  4 Jun 2024 12:24:45 +0800
Message-ID: <20240604042454.2012091-4-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

scan_get_next_rmap_item() return folio actually now. So in the calling
path to try_to_merge_one_page() parameter pages are actually folios.
So let's use folio instead of of page in the function to save few
compound checking in callee functions.

The 'page' left here since flush functions still not support folios yet.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 61 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e2fdb9dd98e2..21bfa9bfb210 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1462,24 +1462,29 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 }
 
 /*
- * try_to_merge_one_page - take two pages and merge them into one
- * @vma: the vma that holds the pte pointing to page
- * @page: the PageAnon page that we want to replace with kpage
- * @kpage: the PageKsm page that we want to map instead of page,
- *         or NULL the first time when we want to use page as kpage.
+ * try_to_merge_one_page - take two folios and merge them into one
+ * @vma: the vma that holds the pte pointing to folio
+ * @folio: the PageAnon page that we want to replace with kfolio
+ * @kfolio: the PageKsm page that we want to map instead of folio,
+ *         or NULL the first time when we want to use folio as kfolio.
  *
- * This function returns 0 if the pages were merged, -EFAULT otherwise.
+ * This function returns 0 if the folios were merged, -EFAULT otherwise.
  */
-static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
-				 struct ksm_rmap_item *rmap_item, struct page *kpage)
+static int try_to_merge_one_page(struct vm_area_struct *vma, struct folio *folio,
+				 struct ksm_rmap_item *rmap_item, struct folio *kfolio)
 {
 	pte_t orig_pte = __pte(0);
 	int err = -EFAULT;
+	struct page *page = folio_page(folio, 0);
+	struct page *kpage;
 
-	if (page == kpage)			/* ksm page forked */
+	if (kfolio)
+		kpage = folio_page(kfolio, 0);
+
+	if (folio == kfolio)			/* ksm page forked */
 		return 0;
 
-	if (!PageAnon(page))
+	if (!folio_test_anon(folio))
 		goto out;
 
 	/*
@@ -1489,11 +1494,11 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
 	 * prefer to continue scanning and merging different pages,
 	 * then come back to this page when it is unlocked.
 	 */
-	if (!trylock_page(page))
+	if (!folio_trylock(folio))
 		goto out;
 
-	if (PageTransCompound(page)) {
-		if (split_huge_page(page))
+	if (folio_test_large(folio)) {
+		if (split_folio(folio))
 			goto out_unlock;
 	}
 
@@ -1506,35 +1511,36 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
 	 * ptes are necessarily already write-protected.  But in either
 	 * case, we need to lock and check page_count is not raised.
 	 */
-	if (write_protect_page(vma, page_folio(page), &orig_pte) == 0) {
-		if (!kpage) {
+	if (write_protect_page(vma, folio, &orig_pte) == 0) {
+		if (!kfolio) {
 			/*
 			 * While we hold page lock, upgrade page from
 			 * PageAnon+anon_vma to PageKsm+NULL stable_node:
 			 * stable_tree_insert() will update stable_node.
 			 */
-			folio_set_stable_node(page_folio(page), NULL);
-			mark_page_accessed(page);
+			folio_set_stable_node(folio, NULL);
+			folio_mark_accessed(folio);
 			/*
 			 * Page reclaim just frees a clean page with no dirty
 			 * ptes: make sure that the ksm page would be swapped.
 			 */
-			if (!PageDirty(page))
-				SetPageDirty(page);
+			if (!folio_test_dirty(folio))
+				folio_set_dirty(folio);
 			err = 0;
 		} else if (pages_identical(page, kpage))
 			err = replace_page(vma, page, kpage, orig_pte);
 	}
 
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 out:
 	return err;
 }
 
 /*
  * try_to_merge_with_ksm_page - like try_to_merge_two_pages,
- * but no new kernel page is allocated: kpage must already be a ksm page.
+ * but no new kernel page is allocated, kpage is a ksm page or NULL
+ * if we use page as first ksm page.
  *
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
  */
@@ -1544,13 +1550,17 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	struct mm_struct *mm = rmap_item->mm;
 	struct vm_area_struct *vma;
 	int err = -EFAULT;
+	struct folio *kfolio;
 
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, rmap_item->address);
 	if (!vma)
 		goto out;
 
-	err = try_to_merge_one_page(vma, page, rmap_item, kpage);
+	if (kpage)
+		kfolio = page_folio(kpage);
+
+	err = try_to_merge_one_page(vma, page_folio(page), rmap_item, kfolio);
 	if (err)
 		goto out;
 
@@ -2385,8 +2395,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		mmap_read_lock(mm);
 		vma = find_mergeable_vma(mm, rmap_item->address);
 		if (vma) {
-			err = try_to_merge_one_page(vma, page, rmap_item,
-					ZERO_PAGE(rmap_item->address));
+			err = try_to_merge_one_page(vma, page_folio(page), rmap_item,
+						    page_folio(ZERO_PAGE(rmap_item->address)));
 			trace_ksm_merge_one_page(
 				page_to_pfn(ZERO_PAGE(rmap_item->address)),
 				rmap_item, mm, err);
@@ -2671,8 +2681,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
-					ksm_scan.rmap_list =
-							&rmap_item->rmap_list;
+					ksm_scan.rmap_list = &rmap_item->rmap_list;
 
 					if (should_skip_rmap_item(*page, rmap_item))
 						goto next_page;
-- 
2.43.0



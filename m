Return-Path: <linux-kernel+bounces-200012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447368FA926
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF76A289D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346813D2AA;
	Tue,  4 Jun 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snb8+csf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E91419B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474916; cv=none; b=SE/+ZO2Q0jjPuAyVEZVQCridcXts+VTjCjoYFOw/FY0tj94b2gcwPoyoyzbtsc9Ct0lp3WJkVVYLWmxEEyd2hD4lPDdh5GI3TxYb5KnnPdDpkURs5yT6z2F/olkeKBJ6XrquHOX5g4UXpuOOXU/q+EPVycov6VNLictK8AUxhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474916; c=relaxed/simple;
	bh=+wxYOCQhGAvuabF7WUDH5FG6NDiLukYmLnN5Qc7mdHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hItCiuswP+Uso08l+CwsRgFNt1ikzf9YrbLFyY6sHPikn1XBqgPh2oeXnU778YOd/gplqMIg82lrPUVW1oS47dc98MO4Gwp5tcpdLwBOXING9f2hVTHcD+AvPUFQ9qRbZ4bSnLC2czT/JC7LUusuZTl8F/N904EveAF2LOOvp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snb8+csf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455FCC4AF08;
	Tue,  4 Jun 2024 04:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474915;
	bh=+wxYOCQhGAvuabF7WUDH5FG6NDiLukYmLnN5Qc7mdHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Snb8+csfuq27jG6c8lfDxSgt/4j/QIAj9TQhYFFMh9FFT0v2DENV7qrcE36FqNJ2r
	 1bE47raxT2o35HbYAezf6ONYaO4XuHDqGEBVYscppHzq4Y7XMwccQyYP1ERXNIrTbT
	 RFvF8+Z84L8XaaPM3RcfZ9HCjdVaCoECnBZDoBxEviTQ8tzrh/6ZTdVKmaJIYNmerq
	 7L2s0BkeVPHs7RoKsrQCcFw+ddIyu/Gs4l1Arj+k8Kg+S5tT25HXNzu6XTI3wu26hh
	 0Dih/9LM2Mv/2NLu2Kmwz63CkFfrgCJGwJL8B2MxkYUPExNcSMpPJLyWiT/6uCJ+ea
	 aW7RreqKYOa0Q==
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
Subject: [PATCH 08/10] mm/ksm: use folio in try_to_merge_xx serie funcs
Date: Tue,  4 Jun 2024 12:24:50 +0800
Message-ID: <20240604042454.2012091-9-alexs@kernel.org>
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

The try_to_merge_ serie funcs are using folios, so change the parameter
and variable 'page' to folio to save compound checks.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 54 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 14a7ca53fc91..b9c04ce677b9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1540,22 +1540,18 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct folio *folio
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
  */
 static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
-				      struct page *page, struct page *kpage)
+				      struct folio *folio, struct folio *kfolio)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	struct vm_area_struct *vma;
 	int err = -EFAULT;
-	struct folio *kfolio;
 
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, rmap_item->address);
 	if (!vma)
 		goto out;
 
-	if (kpage)
-		kfolio = page_folio(kpage);
-
-	err = try_to_merge_one_page(vma, page_folio(page), rmap_item, kfolio);
+	err = try_to_merge_one_page(vma, folio, rmap_item, kfolio);
 	if (err)
 		goto out;
 
@@ -1567,8 +1563,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	get_anon_vma(vma->anon_vma);
 out:
 	mmap_read_unlock(mm);
-	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
-				rmap_item, mm, err);
+	trace_ksm_merge_with_ksm_page(kfolio, folio_pfn(kfolio ? kfolio : folio),
+				      rmap_item, mm, err);
 	return err;
 }
 
@@ -1582,17 +1578,17 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
  * Note that this function upgrades page to ksm page: if one of the pages
  * is already a ksm page, try_to_merge_with_ksm_page should be used.
  */
-static struct page *try_to_merge_two_pages(struct ksm_rmap_item *rmap_item,
-					   struct page *page,
+static struct folio *try_to_merge_two_pages(struct ksm_rmap_item *rmap_item,
+					   struct folio *folio,
 					   struct ksm_rmap_item *tree_rmap_item,
-					   struct page *tree_page)
+					   struct folio *tree_folio)
 {
 	int err;
 
-	err = try_to_merge_with_ksm_page(rmap_item, page, NULL);
+	err = try_to_merge_with_ksm_page(rmap_item, folio, NULL);
 	if (!err) {
 		err = try_to_merge_with_ksm_page(tree_rmap_item,
-							tree_page, page);
+							tree_folio, folio);
 		/*
 		 * If that fails, we have a ksm page with only one pte
 		 * pointing to it: so break it.
@@ -1600,7 +1596,7 @@ static struct page *try_to_merge_two_pages(struct ksm_rmap_item *rmap_item,
 		if (err)
 			break_cow(rmap_item);
 	}
-	return err ? NULL : page;
+	return err ? NULL : folio;
 }
 
 static __always_inline
@@ -2310,14 +2306,13 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 {
 	struct mm_struct *mm = rmap_item->mm;
 	struct ksm_rmap_item *tree_rmap_item;
-	struct page *tree_page = NULL;
 	struct folio *tree_folio = NULL;
 	struct ksm_stable_node *stable_node;
-	struct page *kpage;
+	struct folio *kfolio;
 	unsigned int checksum;
 	int err;
 	bool max_page_sharing_bypass = false;
-	struct folio *folio, *kfolio;
+	struct folio *folio;
 
 	folio = page_folio(page);
 	stable_node = folio_stable_node(folio);
@@ -2353,7 +2348,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		if (kfolio == ERR_PTR(-EBUSY))
 			return;
 
-		err = try_to_merge_with_ksm_page(rmap_item, page, folio_page(kfolio, 0));
+		err = try_to_merge_with_ksm_page(rmap_item, folio, kfolio);
 		if (!err) {
 			/*
 			 * The page was successfully merged:
@@ -2415,8 +2410,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	if (tree_rmap_item) {
 		bool split;
 
-		kpage = try_to_merge_two_pages(rmap_item, page,
-						tree_rmap_item, tree_page);
+		kfolio = try_to_merge_two_pages(rmap_item, folio,
+						tree_rmap_item, tree_folio);
 		/*
 		 * If both pages we tried to merge belong to the same compound
 		 * page, then we actually ended up increasing the reference
@@ -2427,23 +2422,22 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		 * afterwards, the reference count will be correct and
 		 * split_huge_page should succeed.
 		 */
-		split = PageTransCompound(page)
-			&& compound_head(page) == compound_head(tree_page);
-		put_page(tree_page);
-		if (kpage) {
+		split = folio_test_large(folio) && folio == kfolio;
+		folio_put(tree_folio);
+		if (kfolio) {
 			/*
 			 * The pages were successfully merged: insert new
 			 * node in the stable tree and add both rmap_items.
 			 */
-			lock_page(kpage);
-			stable_node = stable_tree_insert(page_folio(kpage));
+			folio_lock(kfolio);
+			stable_node = stable_tree_insert(kfolio);
 			if (stable_node) {
 				stable_tree_append(tree_rmap_item, stable_node,
 						   false);
 				stable_tree_append(rmap_item, stable_node,
 						   false);
 			}
-			unlock_page(kpage);
+			folio_unlock(kfolio);
 
 			/*
 			 * If we fail to insert the page into the stable tree,
@@ -2465,10 +2459,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * the page is locked, it is better to skip it and
 			 * perhaps try again later.
 			 */
-			if (!trylock_page(page))
+			if (!folio_trylock(folio))
 				return;
-			split_huge_page(page);
-			unlock_page(page);
+			split_folio(folio);
+			folio_unlock(folio);
 		}
 	}
 }
-- 
2.43.0



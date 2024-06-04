Return-Path: <linux-kernel+bounces-200015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B529B8FA92C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C65289E57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B671420BE;
	Tue,  4 Jun 2024 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1n6Rqkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204513E3F9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474922; cv=none; b=tkce6O5jH2bMd+giLk1tEHA+xPOv7ncKEJlBAdxqwQtTzGk5SXXo72NvPVnK0Copmd8g9hggbyA+ZliI1Qiu+eLvJLqTYSa+JndFnxW5BE2hsNcM5XFer0o9POJTghzFDe2Tcbn+JGq1wqFy8MsgetzhHaWKYFQcPZUyKO8eFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474922; c=relaxed/simple;
	bh=zYmT3lwFo6rWfb+tk0qEdUJ1sHLo1w0Ku5xx7RwN91E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaButu6Ptddsu2mb6h8F4k05DWkGpftBEPDgpZRK2lcanajcbP3nEPp7b776LKLzNVXSy4PAHDKaIzQU/fFzz4mMUUfkeViMCFfT+Wk3MSm51s1OtGEJTmmhMrHgKcG3cUSIqGd69RMtc7fUz9eaYSP7rbt4ZMz0FTUCNAcT08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1n6Rqkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02A6C2BBFC;
	Tue,  4 Jun 2024 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474921;
	bh=zYmT3lwFo6rWfb+tk0qEdUJ1sHLo1w0Ku5xx7RwN91E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1n6RqkdZBqCVuUxiRYbqCsvhoBbYlLF6Tvbv/GcWyfrKGI0NaYyHr/QY8N+fCXeo
	 ZyqzSABKskTK19EVEKFZ0dPpOIG49//2tmiIEI5wj1RjvoGrfxWZMwUvYk3U1fMLZq
	 M0sQEx6nVa6TrVMytPlCJK79PonvX/LOvVR9KZwKxF8cWxEHsRVrel6+djm0sUbqfy
	 l+sZVswL5p6CcvKVP6t8yEMZlFgtcRTcEBMqW8CS1+bnZjfS9f6CSOaJL/axF4ejz7
	 RRoM2ihQmnQSyii+KyuXtFT5x+qw/CElR9Gf/KgRbdPbJIcCsvuGxA0QwKM0IhZkAE
	 bgeMB1Y+dWEFw==
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
Subject: [PATCH 10/10] m/ksm: use folio in ksm scan path
Date: Tue,  4 Jun 2024 12:24:52 +0800
Message-ID: <20240604042454.2012091-11-alexs@kernel.org>
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

Now we could safely use folio in ksm_do_scan path to save a few compound
checks. The 'page' still used since follow_page function still no folio
version.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index dc2b5e6a9659..57904b3b18dc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2304,7 +2304,7 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
  * @page: the page that we are searching identical page to.
  * @rmap_item: the reverse mapping into the virtual address of this page
  */
-static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
+static void cmp_and_merge_page(struct folio *folio, struct ksm_rmap_item *rmap_item)
 {
 	struct mm_struct *mm = rmap_item->mm;
 	struct ksm_rmap_item *tree_rmap_item;
@@ -2314,9 +2314,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	unsigned int checksum;
 	int err;
 	bool max_page_sharing_bypass = false;
-	struct folio *folio;
 
-	folio = page_folio(page);
 	stable_node = folio_stable_node(folio);
 	if (stable_node) {
 		if (stable_node->head != &migrate_nodes &&
@@ -2518,12 +2516,12 @@ static unsigned int skip_age(rmap_age_t age)
 }
 
 /*
- * Determines if a page should be skipped for the current scan.
+ * Determines if a folio should be skipped for the current scan.
  *
- * @page: page to check
- * @rmap_item: associated rmap_item of page
+ * @folio: folio to check
+ * @rmap_item: associated rmap_item of folio
  */
-static bool should_skip_rmap_item(struct page *page,
+static bool should_skip_rmap_item(struct folio *folio,
 				  struct ksm_rmap_item *rmap_item)
 {
 	rmap_age_t age;
@@ -2536,7 +2534,7 @@ static bool should_skip_rmap_item(struct page *page,
 	 * will essentially ignore them, but we still have to process them
 	 * properly.
 	 */
-	if (PageKsm(page))
+	if (folio_test_ksm(folio))
 		return false;
 
 	age = rmap_item->age;
@@ -2566,7 +2564,7 @@ static bool should_skip_rmap_item(struct page *page,
 	return true;
 }
 
-static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
+static struct ksm_rmap_item *scan_get_next_rmap_item(struct folio **folio)
 {
 	struct mm_struct *mm;
 	struct ksm_mm_slot *mm_slot;
@@ -2655,36 +2653,41 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
+			struct page *page;
+
 			if (ksm_test_exit(mm))
 				break;
-			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page)) {
+			page = follow_page(vma, ksm_scan.address, FOLL_GET);
+			if (IS_ERR_OR_NULL(page)) {
 				ksm_scan.address += PAGE_SIZE;
 				cond_resched();
 				continue;
 			}
 
-			VM_WARN_ON(PageTail(*page));
-			nr = compound_nr(*page);
-			if (is_zone_device_page(*page))
+			*folio = page_folio(page);
+			VM_WARN_ON(PageTail(page));
+			nr = folio_nr_pages(*folio);
+
+			if (folio_is_zone_device(*folio))
 				goto next_page;
-			if (PageAnon(*page)) {
+
+			if (folio_test_anon(*folio)) {
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
 					ksm_scan.rmap_list = &rmap_item->rmap_list;
 
-					if (should_skip_rmap_item(*page, rmap_item))
+					if (should_skip_rmap_item(*folio, rmap_item))
 						goto next_page;
 
 					ksm_scan.address += nr * PAGE_SIZE;
 				} else
-					put_page(*page);
+					folio_put(*folio);
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
 next_page:
-			put_page(*page);
+			folio_put(*folio);
 			ksm_scan.address += nr * PAGE_SIZE;
 			cond_resched();
 		}
@@ -2755,16 +2758,16 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 static void ksm_do_scan(unsigned int scan_npages)
 {
 	struct ksm_rmap_item *rmap_item;
-	struct page *page;
+	struct folio *folio;
 	unsigned int npages = scan_npages;
 
 	while (npages-- && likely(!freezing(current))) {
 		cond_resched();
-		rmap_item = scan_get_next_rmap_item(&page);
+		rmap_item = scan_get_next_rmap_item(&folio);
 		if (!rmap_item)
 			return;
-		cmp_and_merge_page(page, rmap_item);
-		put_page(page);
+		cmp_and_merge_page(folio, rmap_item);
+		folio_put(folio);
 	}
 
 	ksm_pages_scanned += scan_npages - npages;
-- 
2.43.0



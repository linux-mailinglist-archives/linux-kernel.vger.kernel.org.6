Return-Path: <linux-kernel+bounces-200009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269988FA923
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FC71C2407D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6885140380;
	Tue,  4 Jun 2024 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDSl5xy6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1814036B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474907; cv=none; b=RXHIIXTr37HHCn5paPq6TAHj3N7XCc+VMWCqwHqyUPMO4bqmqYonrmSGfDeWNRy/6znNPePIhPnyr9bJM4beIYTiumioia5psV1qGmnvgE4Q3DJi+8v7Z+qIMSg51MWXUwL3sKEdTOM1l37wHOzF7sDJzv7HencRX0OfxJgsw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474907; c=relaxed/simple;
	bh=coNrFyNql7rzA+Wu1zS+Imisztx1VEYHkdkeqtcLPJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezmnEAc1eLdIaBdDttsjMccv6OOGSqY0bBzGgzUf+ecId+BFIWRgl/ZR0rtDz7j4lxWAxYh94Wt2YmRvrdhDMbRBSYrCyBB+srBPa7vnF6jSRD2GvGxiM7YBoFmCnVvRIhjGJeOLg9AAgq8/sf2oxx63DLnCyAeC7e19s3Im0WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDSl5xy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F76EC2BBFC;
	Tue,  4 Jun 2024 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474906;
	bh=coNrFyNql7rzA+Wu1zS+Imisztx1VEYHkdkeqtcLPJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDSl5xy6AfvB2jwDYUYciKw0WAPH6HVMDLpvUtKv4MiMW2nJPsr8687kDmSuMgS2i
	 8ir4mEf4IzJsZxyqCpwMRG7zPuqEQoO2FcqBJt1Toe9V6ugm2H3oSFrRFxB0nJRYvO
	 6ZjV1r2iscSWsLM8U1FBXXxPO9kLwGNyw46O7MPHow2J0CcrcBysxPOMtS9OSJHTXn
	 kLsG0fd7lCw5iMa882oNvtx9mV5k5rsta8bJgKJcmH9Tjy3MLvJBxnK5D0J6VcqtKB
	 /pWRYqxUdW7oaEdmPbUUkTDWV9VnNFT8B2tYE9n58p6TzwY1lajVhpANa7W9F7pRhx
	 S/9+Par00zx4g==
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
Subject: [PATCH 05/10] mm/ksm: use folio in stable_tree_search
Date: Tue,  4 Jun 2024 12:24:47 +0800
Message-ID: <20240604042454.2012091-6-alexs@kernel.org>
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

The stable_tree_search() function is actually using folio internal, just
pass the folio parameter from cmp_and_merge_page().

And in cmp_and_merge_page(), the parameter 'page' is actually a folio
too, so use folio to save a few compound check in necessnary context.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2e4790842515..f68779651841 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1825,7 +1825,7 @@ static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
  * This function returns the stable tree node of identical content if found,
  * NULL otherwise.
  */
-static struct page *stable_tree_search(struct page *page)
+static struct folio *stable_tree_search(struct folio *folio)
 {
 	int nid;
 	struct rb_root *root;
@@ -1833,14 +1833,12 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_node *parent;
 	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
 	struct ksm_stable_node *page_node;
-	struct folio *folio;
 
-	folio = page_folio(page);
 	page_node = folio_stable_node(folio);
 	if (page_node && page_node->head != &migrate_nodes) {
 		/* ksm page forked */
 		folio_get(folio);
-		return &folio->page;
+		return folio;
 	}
 
 	nid = get_kpfn_nid(folio_pfn(folio));
@@ -1907,7 +1905,7 @@ static struct page *stable_tree_search(struct page *page)
 			goto again;
 		}
 
-		ret = memcmp_pages(page, &tree_folio->page);
+		ret = memcmp_pages(folio_page(folio, 0), &tree_folio->page);
 		folio_put(tree_folio);
 
 		parent = *new;
@@ -1973,7 +1971,7 @@ static struct page *stable_tree_search(struct page *page)
 				folio_put(tree_folio);
 				goto replace;
 			}
-			return &tree_folio->page;
+			return tree_folio;
 		}
 	}
 
@@ -1987,7 +1985,7 @@ static struct page *stable_tree_search(struct page *page)
 out:
 	if (is_page_sharing_candidate(page_node)) {
 		folio_get(folio);
-		return &folio->page;
+		return folio;
 	} else
 		return NULL;
 
@@ -2037,7 +2035,7 @@ static struct page *stable_tree_search(struct page *page)
 	}
 	stable_node_dup->head = &migrate_nodes;
 	list_add(&stable_node_dup->list, stable_node_dup->head);
-	return &folio->page;
+	return folio;
 
 chain_append:
 	/* stable_node_dup could be null if it reached the limit */
@@ -2324,6 +2322,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	unsigned int checksum;
 	int err;
 	bool max_page_sharing_bypass = false;
+	struct folio *folio, *kfolio;
 
 	stable_node = page_stable_node(page);
 	if (stable_node) {
@@ -2346,30 +2345,31 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 
 	/* We first start with searching the page inside the stable tree */
-	kpage = stable_tree_search(page);
-	if (kpage == page && rmap_item->head == stable_node) {
-		put_page(kpage);
+	folio = page_folio(page);
+	kfolio = stable_tree_search(folio);
+	if (kfolio == folio && rmap_item->head == stable_node) {
+		folio_put(kfolio);
 		return;
 	}
 
 	remove_rmap_item_from_tree(rmap_item);
 
-	if (kpage) {
-		if (PTR_ERR(kpage) == -EBUSY)
+	if (kfolio) {
+		if (kfolio == ERR_PTR(-EBUSY))
 			return;
 
-		err = try_to_merge_with_ksm_page(rmap_item, page, kpage);
+		err = try_to_merge_with_ksm_page(rmap_item, page, folio_page(kfolio, 0));
 		if (!err) {
 			/*
 			 * The page was successfully merged:
 			 * add its rmap_item to the stable tree.
 			 */
-			lock_page(kpage);
-			stable_tree_append(rmap_item, page_stable_node(kpage),
+			folio_lock(kfolio);
+			stable_tree_append(rmap_item, folio_stable_node(kfolio),
 					   max_page_sharing_bypass);
-			unlock_page(kpage);
+			folio_unlock(kfolio);
 		}
-		put_page(kpage);
+		folio_put(kfolio);
 		return;
 	}
 
-- 
2.43.0



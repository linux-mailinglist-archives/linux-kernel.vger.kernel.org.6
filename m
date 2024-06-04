Return-Path: <linux-kernel+bounces-200011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD08FA925
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F911F24BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93941411F6;
	Tue,  4 Jun 2024 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHO3PveI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0D1411E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474913; cv=none; b=osD9GUdjaEU0fLfFUy/iTxVttirP5CFEdTmvofIkxyVbi6Kcq9vup7Iuiba2eEXl3jMKcSZU1JeBkeZy5wGjNJVGOfleBqtWs/Hbu/VjSXwFXtMHsDkPCdOp+lBNTe1nm/wehgXyK+S42QrxbiEpwNW3LsA90ubhPdibSz1QJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474913; c=relaxed/simple;
	bh=LoJfO2Ls93RlnzKSfQa0n7wjB2DL3+BBi16/0XKQwOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCka5KsIHjU/DgmUugv8b3OpJVMpFfJ+GjKTt7qX/EN6VZdR4fLcGFB6LSOcrX9Cr7JlFPws7tO7vPQy2jo58GaDf/G1v8omvVPFORjAiJLjEA+HTEVS0VXm2cZI9ibFoZWT5XDZTjv4aLlkNVbvOH9uWoAyj+/H/RQ9IfS+L9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHO3PveI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B25C32786;
	Tue,  4 Jun 2024 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474912;
	bh=LoJfO2Ls93RlnzKSfQa0n7wjB2DL3+BBi16/0XKQwOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHO3PveI2oavxMNpkEuXKJde+ksLgcEi44dvri14Czc1WMsBGUjH7nsZo+HgzTwk5
	 kfBBUNQ1X2VjlkCaCQICHYJLyHlCcfs2H8EyjLEvhrkJwzbgl4rmrIrXh8KKw4GWgO
	 +B7V62sDNVW43wX7GKXMJgGFTVJ+75KTJIAEthNzgAiuA5wbii6dkqQrRn+CrErtt/
	 njhraJfTdI1oXQjkB2w2DQlBnqUjSaHG3MCsGDWZMPTiVe+phXMDyARlN6r68pExT/
	 RKud+RLAPmKjpo5VaCpohWROwJiE50q3C3lYnqt7siuesgAwYO0z3cbI4Ctydrks5a
	 OfEPkCx5Z9wyQ==
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
Subject: [PATCH 07/10] mm/ksm: use folio in unstable_tree_search_insert
Date: Tue,  4 Jun 2024 12:24:49 +0800
Message-ID: <20240604042454.2012091-8-alexs@kernel.org>
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

The calling path are using folio actually, so start to folio in
unstable_tree_search_insert to save few compound checks.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 24de562b64e1..14a7ca53fc91 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2194,15 +2194,14 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
  */
 static
 struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_item,
-					      struct page *page,
-					      struct page **tree_pagep)
+						  struct folio *folio, struct folio **tree_foliop)
 {
 	struct rb_node **new;
 	struct rb_root *root;
 	struct rb_node *parent = NULL;
 	int nid;
 
-	nid = get_kpfn_nid(page_to_pfn(page));
+	nid = get_kpfn_nid(folio_pfn(folio));
 	root = root_unstable_tree + nid;
 	new = &root->rb_node;
 
@@ -2220,12 +2219,12 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 		/*
 		 * Don't substitute a ksm page for a forked page.
 		 */
-		if (page == tree_page) {
+		if (folio == page_folio(tree_page)) {
 			put_page(tree_page);
 			return NULL;
 		}
 
-		ret = memcmp_pages(page, tree_page);
+		ret = memcmp_pages(folio_page(folio, 0), tree_page);
 
 		parent = *new;
 		if (ret < 0) {
@@ -2244,7 +2243,7 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 			put_page(tree_page);
 			return NULL;
 		} else {
-			*tree_pagep = tree_page;
+			*tree_foliop = page_folio(tree_page);
 			return tree_rmap_item;
 		}
 	}
@@ -2312,6 +2311,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	struct mm_struct *mm = rmap_item->mm;
 	struct ksm_rmap_item *tree_rmap_item;
 	struct page *tree_page = NULL;
+	struct folio *tree_folio = NULL;
 	struct ksm_stable_node *stable_node;
 	struct page *kpage;
 	unsigned int checksum;
@@ -2411,7 +2411,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			return;
 	}
 	tree_rmap_item =
-		unstable_tree_search_insert(rmap_item, page, &tree_page);
+		unstable_tree_search_insert(rmap_item, folio, &tree_folio);
 	if (tree_rmap_item) {
 		bool split;
 
-- 
2.43.0



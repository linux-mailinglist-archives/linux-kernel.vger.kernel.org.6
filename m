Return-Path: <linux-kernel+bounces-224159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06632911DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD2B2500D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB017D8A8;
	Fri, 21 Jun 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TnGrkbwW"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7917D892
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956519; cv=none; b=n6tZ2JiYi/ResVzCx5J3XgRUWnmQjfmBZZ+jUAq6rfLiHcdwrKPldNPlhGUpy3L3b4T5G5PqQuUPjgSleaNuPP2b4MppDB9FrUZMRnKXDo5D/BPko0HZNLCTADX0ap3BCjyFj8ZTOKAnKmXp3j8EtciWwnfSyTZUgqU/MGiLdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956519; c=relaxed/simple;
	bh=aNZtikh89uZPUxDF7c2Rld2Ly+4aFi7EXpdx4+SXheY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csngJs+6ExPHcQTzLZK4vLVsHRBwYCoKhy+rFdKU6NWIY5/Scl1+wW2OLdgCjpUgpr7xJmi4wf3BZyMrg1i/ITjTJDyI718ZS+YLHvyKEjZLcl0LKfpwpt2yfmzhUtggHaM/tiRACmw6Gse1/xpz4neo/57p48qHqHGXEY6+j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TnGrkbwW; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718956515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBTb4+v7Qjp9h/YfZziY90UbHgzMj5tgQ+gOTK4dIwk=;
	b=TnGrkbwW436/Yap5Ue4H98Atcpl4VB9QMsg8iPSTtY0CJAXvj4UHSLInQ2RlqUfxsKFoF0
	y2NKHI+3D+4ZH7Ax3Q5YK+ZakWJ7xkP7qExCAAugC9UzcRh4vSq5ZVQGqDArJoWkafB66U
	VFv5AmeaGMnhhI7TBLLiPwkFjgCsiQ0=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 21 Jun 2024 15:54:31 +0800
Subject: [PATCH v2 3/3] mm/ksm: optimize the chain()/chain_prune()
 interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-b4-ksm-scan-optimize-v2-3-1c328aa9e30b@linux.dev>
References: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
In-Reply-To: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718956503; l=9550;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=aNZtikh89uZPUxDF7c2Rld2Ly+4aFi7EXpdx4+SXheY=;
 b=bOdA9BYysMkUH2+JdBV45OcwVMOTbDIiKLccdbJ5jZ1yl2TbQ/Jxd6AGsGx7IIzzdL+Vo41Jy
 foNRzuyFJIABRcXbo9+eILkdIBTZgC116f0rFUtBWPJbukeeK2Go5wH
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

Now the implementation of stable_node_dup() causes chain()/chain_prune()
interfaces and usages are overcomplicated.

Why? stable_node_dup() only find and return a candidate stable_node for
sharing, so the users have to recheck using stable_node_dup_any() if any
non-candidate stable_node exist. And try to ksm_get_folio() from it again.

Actually, stable_node_dup() can just return a best stable_node as it can,
then the users can check if it's a candidate for sharing or not.

The code is simplified too and fewer corner cases: such as stable_node and
stable_node_dup can't be NULL if returned tree_folio is not NULL.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 152 ++++++++++++---------------------------------------------------
 1 file changed, 27 insertions(+), 125 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2cf836fb1367..8a5d88472223 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1663,7 +1663,6 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
 	struct folio *folio, *tree_folio = NULL;
-	int nr = 0;
 	int found_rmap_hlist_len;
 
 	if (!prune_stale_stable_nodes ||
@@ -1690,33 +1689,26 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 		folio = ksm_get_folio(dup, KSM_GET_FOLIO_NOLOCK);
 		if (!folio)
 			continue;
-		nr += 1;
-		if (is_page_sharing_candidate(dup)) {
-			if (!found ||
-			    dup->rmap_hlist_len > found_rmap_hlist_len) {
-				if (found)
-					folio_put(tree_folio);
-				found = dup;
-				found_rmap_hlist_len = found->rmap_hlist_len;
-				tree_folio = folio;
-
-				/* skip put_page for found dup */
-				if (!prune_stale_stable_nodes)
-					break;
-				continue;
-			}
+		/* Pick the best candidate if possible. */
+		if (!found || (is_page_sharing_candidate(dup) &&
+		    (!is_page_sharing_candidate(found) ||
+		     dup->rmap_hlist_len > found_rmap_hlist_len))) {
+			if (found)
+				folio_put(tree_folio);
+			found = dup;
+			found_rmap_hlist_len = found->rmap_hlist_len;
+			tree_folio = folio;
+			/* skip put_page for found candidate */
+			if (!prune_stale_stable_nodes &&
+			    is_page_sharing_candidate(found))
+				break;
+			continue;
 		}
 		folio_put(folio);
 	}
 
 	if (found) {
-		/*
-		 * nr is counting all dups in the chain only if
-		 * prune_stale_stable_nodes is true, otherwise we may
-		 * break the loop at nr == 1 even if there are
-		 * multiple entries.
-		 */
-		if (prune_stale_stable_nodes && nr == 1) {
+		if (hlist_is_singular_node(&found->hlist_dup, &stable_node->hlist)) {
 			/*
 			 * If there's not just one entry it would
 			 * corrupt memory, better BUG_ON. In KSM
@@ -1768,25 +1760,15 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 			hlist_add_head(&found->hlist_dup,
 				       &stable_node->hlist);
 		}
+	} else {
+		/* Its hlist must be empty if no one found. */
+		free_stable_node_chain(stable_node, root);
 	}
 
 	*_stable_node_dup = found;
 	return tree_folio;
 }
 
-static struct ksm_stable_node *stable_node_dup_any(struct ksm_stable_node *stable_node,
-					       struct rb_root *root)
-{
-	if (!is_stable_node_chain(stable_node))
-		return stable_node;
-	if (hlist_empty(&stable_node->hlist)) {
-		free_stable_node_chain(stable_node, root);
-		return NULL;
-	}
-	return hlist_entry(stable_node->hlist.first,
-			   typeof(*stable_node), hlist_dup);
-}
-
 /*
  * Like for ksm_get_folio, this function can free the *_stable_node and
  * *_stable_node_dup if the returned tree_page is NULL.
@@ -1807,17 +1789,10 @@ static struct folio *__stable_node_chain(struct ksm_stable_node **_stable_node_d
 					 bool prune_stale_stable_nodes)
 {
 	struct ksm_stable_node *stable_node = *_stable_node;
+
 	if (!is_stable_node_chain(stable_node)) {
-		if (is_page_sharing_candidate(stable_node)) {
-			*_stable_node_dup = stable_node;
-			return ksm_get_folio(stable_node, KSM_GET_FOLIO_NOLOCK);
-		}
-		/*
-		 * _stable_node_dup set to NULL means the stable_node
-		 * reached the ksm_max_page_sharing limit.
-		 */
-		*_stable_node_dup = NULL;
-		return NULL;
+		*_stable_node_dup = stable_node;
+		return ksm_get_folio(stable_node, KSM_GET_FOLIO_NOLOCK);
 	}
 	return stable_node_dup(_stable_node_dup, _stable_node, root,
 			       prune_stale_stable_nodes);
@@ -1831,16 +1806,10 @@ static __always_inline struct folio *chain_prune(struct ksm_stable_node **s_n_d,
 }
 
 static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
-					   struct ksm_stable_node *s_n,
+					   struct ksm_stable_node **s_n,
 					   struct rb_root *root)
 {
-	struct ksm_stable_node *old_stable_node = s_n;
-	struct folio *tree_folio;
-
-	tree_folio = __stable_node_chain(s_n_d, &s_n, root, false);
-	/* not pruning dups so s_n cannot have changed */
-	VM_BUG_ON(s_n != old_stable_node);
-	return tree_folio;
+	return __stable_node_chain(s_n_d, s_n, root, false);
 }
 
 /*
@@ -1858,7 +1827,7 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *stable_node, *stable_node_dup;
 	struct ksm_stable_node *page_node;
 	struct folio *folio;
 
@@ -1882,45 +1851,7 @@ static struct page *stable_tree_search(struct page *page)
 
 		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
-		stable_node_any = NULL;
 		tree_folio = chain_prune(&stable_node_dup, &stable_node, root);
-		/*
-		 * NOTE: stable_node may have been freed by
-		 * chain_prune() if the returned stable_node_dup is
-		 * not NULL. stable_node_dup may have been inserted in
-		 * the rbtree instead as a regular stable_node (in
-		 * order to collapse the stable_node chain if a single
-		 * stable_node dup was found in it). In such case the
-		 * stable_node is overwritten by the callee to point
-		 * to the stable_node_dup that was collapsed in the
-		 * stable rbtree and stable_node will be equal to
-		 * stable_node_dup like if the chain never existed.
-		 */
-		if (!stable_node_dup) {
-			/*
-			 * Either all stable_node dups were full in
-			 * this stable_node chain, or this chain was
-			 * empty and should be rb_erased.
-			 */
-			stable_node_any = stable_node_dup_any(stable_node,
-							      root);
-			if (!stable_node_any) {
-				/* rb_erase just run */
-				goto again;
-			}
-			/*
-			 * Take any of the stable_node dups page of
-			 * this stable_node chain to let the tree walk
-			 * continue. All KSM pages belonging to the
-			 * stable_node dups in a stable_node chain
-			 * have the same content and they're
-			 * write protected at all times. Any will work
-			 * fine to continue the walk.
-			 */
-			tree_folio = ksm_get_folio(stable_node_any,
-						   KSM_GET_FOLIO_NOLOCK);
-		}
-		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,
@@ -1958,7 +1889,7 @@ static struct page *stable_tree_search(struct page *page)
 					goto chain_append;
 			}
 
-			if (!stable_node_dup) {
+			if (!is_page_sharing_candidate(stable_node_dup)) {
 				/*
 				 * If the stable_node is a chain and
 				 * we got a payload match in memcmp
@@ -2067,9 +1998,6 @@ static struct page *stable_tree_search(struct page *page)
 	return &folio->page;
 
 chain_append:
-	/* stable_node_dup could be null if it reached the limit */
-	if (!stable_node_dup)
-		stable_node_dup = stable_node_any;
 	/*
 	 * If stable_node was a chain and chain_prune collapsed it,
 	 * stable_node has been updated to be the new regular
@@ -2114,7 +2042,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *stable_node, *stable_node_dup;
 	bool need_chain = false;
 
 	kpfn = folio_pfn(kfolio);
@@ -2130,33 +2058,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 
 		cond_resched();
 		stable_node = rb_entry(*new, struct ksm_stable_node, node);
-		stable_node_any = NULL;
-		tree_folio = chain(&stable_node_dup, stable_node, root);
-		if (!stable_node_dup) {
-			/*
-			 * Either all stable_node dups were full in
-			 * this stable_node chain, or this chain was
-			 * empty and should be rb_erased.
-			 */
-			stable_node_any = stable_node_dup_any(stable_node,
-							      root);
-			if (!stable_node_any) {
-				/* rb_erase just run */
-				goto again;
-			}
-			/*
-			 * Take any of the stable_node dups page of
-			 * this stable_node chain to let the tree walk
-			 * continue. All KSM pages belonging to the
-			 * stable_node dups in a stable_node chain
-			 * have the same content and they're
-			 * write protected at all times. Any will work
-			 * fine to continue the walk.
-			 */
-			tree_folio = ksm_get_folio(stable_node_any,
-						   KSM_GET_FOLIO_NOLOCK);
-		}
-		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
+		tree_folio = chain(&stable_node_dup, &stable_node, root);
 		if (!tree_folio) {
 			/*
 			 * If we walked over a stale stable_node,

-- 
2.45.2



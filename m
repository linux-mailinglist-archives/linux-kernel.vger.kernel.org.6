Return-Path: <linux-kernel+bounces-188495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DA8CE2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CAD28289A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F18612A171;
	Fri, 24 May 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nsleZO40"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDB129E94
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541067; cv=none; b=BH4SNgYalwFMr9qU4cDHW2n2ZwZ4AwW2AxqXtZWoTPHkVaNUNATfUmkvNiVdQ39SouordkSutmJegaX+LlAUeAM8crkqEKyaUMUHX2lmJUYXb4OE92hQoZ1p0DU/q69mYDpzQLKhaRsx+nAC8vcmw3PFt6s01O5PFhdwS3tm3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541067; c=relaxed/simple;
	bh=B3mWul1z83IaYeQ2cUT6DdRB2E/1FafRRpZB8x99BtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaKpNU41K6HJJgiGZKjcRQlOIJSyS57yV+c73brfgLqnlAbaRmcywFItFAuB770AuWlD98JVAplUuoXrp1M/XmQWP14kc/qVNZYQiQB/rE+4OXnX23k/pX67B8pnMiIf2kOAzhG62+8GaK4B+CHVR7Xiok7BEdUrm/e5Blh9Ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nsleZO40; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716541063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kGF9w1QUnOSltohj+L0P/TzAsAcBq0IIlZW6mywScQ=;
	b=nsleZO401TgVx5KF9wb+ceO8era7Jem4f+cMSs9YNzbTHmueEL9+9Y9c8sTtLrNEBtJsGh
	TVWPzIMkfKyekJKQrQz94vOH7zwFzGNrq1TfyoiswZIpfmVgHm/fUh5BoRL9zHDQe9LJkH
	BgwGtPqzyKjQ5I8hRzTnr0ocAj0w5Xo=
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: david@redhat.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 24 May 2024 16:56:52 +0800
Subject: [PATCH 3/4] mm/ksm: optimize the chain()/chain_prune() interfaces
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-ksm-scan-optimize-v1-3-053b31bd7ab4@linux.dev>
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
In-Reply-To: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541051; l=9550;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=B3mWul1z83IaYeQ2cUT6DdRB2E/1FafRRpZB8x99BtA=;
 b=nzbFXMDobe1UukjngEHFuUwYFMRq/StBqzcrTRZ6CxoVvEgcltAoBkvGjF5A0L2B94mAqC+tM
 3OkiFr8H+y1DAWKpNEe8YR0LIoUUYoc9WUzqfX4EpwozFF5S//xFomx
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
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
index 2424081f386e..f923699452ed 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1660,7 +1660,6 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
 	struct ksm_stable_node *dup, *found = NULL, *stable_node = *_stable_node;
 	struct hlist_node *hlist_safe;
 	struct folio *folio, *tree_folio = NULL;
-	int nr = 0;
 	int found_rmap_hlist_len;
 
 	if (!prune_stale_stable_nodes ||
@@ -1687,33 +1686,26 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
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
@@ -1765,25 +1757,15 @@ static struct folio *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
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
@@ -1804,17 +1786,10 @@ static struct folio *__stable_node_chain(struct ksm_stable_node **_stable_node_d
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
@@ -1828,16 +1803,10 @@ static __always_inline struct folio *chain_prune(struct ksm_stable_node **s_n_d,
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
@@ -1855,7 +1824,7 @@ static struct page *stable_tree_search(struct page *page)
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *stable_node, *stable_node_dup;
 	struct ksm_stable_node *page_node;
 	struct folio *folio;
 
@@ -1879,45 +1848,7 @@ static struct page *stable_tree_search(struct page *page)
 
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
@@ -1955,7 +1886,7 @@ static struct page *stable_tree_search(struct page *page)
 					goto chain_append;
 			}
 
-			if (!stable_node_dup) {
+			if (!is_page_sharing_candidate(stable_node_dup)) {
 				/*
 				 * If the stable_node is a chain and
 				 * we got a payload match in memcmp
@@ -2064,9 +1995,6 @@ static struct page *stable_tree_search(struct page *page)
 	return &folio->page;
 
 chain_append:
-	/* stable_node_dup could be null if it reached the limit */
-	if (!stable_node_dup)
-		stable_node_dup = stable_node_any;
 	/*
 	 * If stable_node was a chain and chain_prune collapsed it,
 	 * stable_node has been updated to be the new regular
@@ -2111,7 +2039,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 	struct rb_root *root;
 	struct rb_node **new;
 	struct rb_node *parent;
-	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
+	struct ksm_stable_node *stable_node, *stable_node_dup;
 	bool need_chain = false;
 
 	kpfn = folio_pfn(kfolio);
@@ -2127,33 +2055,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 
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
2.45.1



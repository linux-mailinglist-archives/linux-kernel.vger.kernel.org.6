Return-Path: <linux-kernel+bounces-173152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A728BFC3D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF5F1F2236B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECC282C76;
	Wed,  8 May 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SqGZ8FQl"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF18248F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168277; cv=none; b=JHIoaUaBYn+goLvQlqwcJebgvo5sWZRXqwCo7eDrvNa9fXwSKEa4Kd3NlaFdaGTO0+ub+6ajNksoz0P0yTJPbAHUfK5EnUriKVm3WHhocapKyt3u3cs0u9Y8SBdIemAck+yFjd+F3EAGnIB1GOMapGxxt37UBqoGzUcAMaJQe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168277; c=relaxed/simple;
	bh=D9LRp9I9bsmEz1efkArPgmxaWlXB5jt0gur2nsp9qF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evK6r7VriC1177rf2GK5R8hBsptY0mEtxD5yJxkpWe0aZ0ixDyFZLlq1JhySB2sbRA6IZigXP/CM7IoR8sHhBJ33YbMXAHUSbqYwllg/pzdxoGBR4BVm7VDTG3OeMwD4uDjy9QmJQmBmgRQtK+oMNUsiwNtwUX/V+Jx7zYo5quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SqGZ8FQl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715168272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIIjmNAElQXsSD8PwI0lQYfcP7r/nQH9fPZcjkqWsMg=;
	b=SqGZ8FQlOHa+xVPFT5h/Hx5XD//A7WpJyKilXRNPlWE33c7fr0uqwMYQA4fQG/nwxpkHVz
	shXfsXlr5ZQZ1+G4VeYsUc5DOisjK3xLwwK5o6WplPtYysflyUNnQHTE1Hafs1styy0FH+
	g10gnOP4bTG5XVNzuHhTjyHHxbwcYZ4=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 19:35:41 +0800
Subject: [PATCH 1/2] mm/ksm: re-search unstable tree when tree_rmap_item is
 stale
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-unstable-insert-v1-1-631cdbc2b77f@linux.dev>
References: <20240508-b4-ksm-unstable-insert-v1-0-631cdbc2b77f@linux.dev>
In-Reply-To: <20240508-b4-ksm-unstable-insert-v1-0-631cdbc2b77f@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715168266; l=1516;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=jA3W7oMJI30/U7Ia4BVOJNzApOh6jOjCo9MOgiNhdb0=;
 b=12jMhHwzT9u21DZ+cUWU0t74BSNgENYB7tSujAwgHFh3vUTNwYzyPBwg4lmtSu89lyWdO68id
 ISPO0DpTBD0DMKJkVzXvWnlRoCrekIWEAqHZkIYtzv0abUL6H7Ar0Wa
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

Now unstable_tree_search_insert() will return NULL if encounter a stale
tree_rmap_item, in which case get_mergeable_page() return NULL.

More reasonable handling is to remove stale rmap_item out of unstable
tree and re-search from root. That stale rmap_item will be reclaimed
when next time of scan.

So we can insert our rmap_item successfully instead of returning NULL.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/ksm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index e1034bf1c937..66219983eb3a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2196,12 +2196,14 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 {
 	struct rb_node **new;
 	struct rb_root *root;
-	struct rb_node *parent = NULL;
+	struct rb_node *parent;
 	int nid;
 
 	nid = get_kpfn_nid(page_to_pfn(page));
 	root = root_unstable_tree + nid;
+again:
 	new = &root->rb_node;
+	parent = NULL;
 
 	while (*new) {
 		struct ksm_rmap_item *tree_rmap_item;
@@ -2211,8 +2213,10 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 		cond_resched();
 		tree_rmap_item = rb_entry(*new, struct ksm_rmap_item, node);
 		tree_page = get_mergeable_page(tree_rmap_item);
-		if (!tree_page)
-			return NULL;
+		if (!tree_page) {
+			remove_rmap_item_from_tree(tree_rmap_item);
+			goto again;
+		}
 
 		/*
 		 * Don't substitute a ksm page for a forked page.

-- 
2.45.0



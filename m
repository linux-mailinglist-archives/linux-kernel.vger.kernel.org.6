Return-Path: <linux-kernel+bounces-173153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75948BFC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718472835FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7379C823DD;
	Wed,  8 May 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sGyqLmc/"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1B82D64
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168279; cv=none; b=JIO1VRbwyFolmERoda849n3Jms5NyrCY423cn4BQVoXmMgdRl/H+bjuWq1zFkBOg8DIcnuZ8vtZ5MsiWHMjyZvzl0J0Q6GEl4nK5lX1T5ayitkVtKpdtrdWaQdfSQg7yW+/NVNeGm7crJoW7Bwzz7L1+cx49/fH3pR2a2EdpBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168279; c=relaxed/simple;
	bh=2EmaZSwe/HzmbILQH+QzgMGxCqa7nYLUApNs+LSZ+CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc6a8sONJR+MI/ip0Rmmidh5Qp8ITlTK4dys0CwPfjcCLNhbwl/T+dBlFnMKxSGAvxsBClZxzFvOJjbg48DpCmoFRGLCg1umhG/oScQg32B+nqx0x1t3UYXyUP8uIyYgxYBHdhsPOfJHye89lOWXsvRj7lvY8rCVyKK/H0B1OYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sGyqLmc/; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715168276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rv7ODi3h9Zv4dLUYCuePOTA6Hl0snrx6MrZvSACKHJk=;
	b=sGyqLmc/ob4XobogabL2rrSlIMRKjg02+S9SDgwIWAeXY/S/Y4fNO+7AdahFYG1gt5nQMc
	FeOWgfKlTl/AWHPM5vJ5XSyb188vtNSzd5Gu2Awtw/JK01WBl1bAn4LwP2W6jnFzFQpCzV
	8X6rdSZp8/58VgZd6vhLG0JiDVXmkYw=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 19:35:42 +0800
Subject: [PATCH 2/2] mm/ksm: flush out migrated rmap_item to insert our
 rmap_item
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-unstable-insert-v1-2-631cdbc2b77f@linux.dev>
References: <20240508-b4-ksm-unstable-insert-v1-0-631cdbc2b77f@linux.dev>
In-Reply-To: <20240508-b4-ksm-unstable-insert-v1-0-631cdbc2b77f@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715168266; l=1806;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=DfKRZMh+MWM/THv2xlN2nkqm18FgyrnKseZDpyL0ZnQ=;
 b=6PGv6hC8/MH+G6VHFjqPstHrk9XZsLDwOyKos4BGRZ6lxZ4an2xDm65nTC4XcJaq5kAVlo4W2
 KhIGkkMPYrPAoNo3pgoyAzIgk8bBd2a0sC8o7yToiFqxOUBz2+i6ZkG
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

If tree_page has been migrated to another NUMA node and across_nodes
disabled, flush it out immediately and it will be put in the right
unstable tree when next time.

The good point is that we can retry to insert our rmap_item successfully
to increase the merge possibility, and we don't need to bother to
memcmp_pages() in this case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/ksm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 66219983eb3a..b840fb55e1f4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2226,6 +2226,18 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 			return NULL;
 		}
 
+		/*
+		 * If tree_page has been migrated to another NUMA node and
+		 * across_nodes disabled, flush it out here and it will be
+		 * put in the right unstable tree next time. So we can retry
+		 * to insert our rmap_item successfully.
+		 */
+		if (!ksm_merge_across_nodes &&
+		    page_to_nid(tree_page) != nid) {
+			remove_rmap_item_from_tree(tree_rmap_item);
+			goto again;
+		}
+
 		ret = memcmp_pages(page, tree_page);
 
 		parent = *new;
@@ -2235,15 +2247,6 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 		} else if (ret > 0) {
 			put_page(tree_page);
 			new = &parent->rb_right;
-		} else if (!ksm_merge_across_nodes &&
-			   page_to_nid(tree_page) != nid) {
-			/*
-			 * If tree_page has been migrated to another NUMA node,
-			 * it will be flushed out and put in the right unstable
-			 * tree next time: only merge with it when across_nodes.
-			 */
-			put_page(tree_page);
-			return NULL;
 		} else {
 			*tree_pagep = tree_page;
 			return tree_rmap_item;

-- 
2.45.0



Return-Path: <linux-kernel+bounces-173004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7228BF9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F861F215CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9577F7DD;
	Wed,  8 May 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjcNAsj1"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A67F470
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162202; cv=none; b=K255udX1fGlqMXLa0csu9YpbTKgA/AqRzU9KTrLiv5mOrZaay+79ksa1dcBLop8YgiWV3mhGW1p1Fqvtb9tma9dcev1uDXEYR1Wl1LSwqCWiTZkDNBhyZrOalXHubKKpv/eaAIUUrim8ay7+TgkUVHbwBF/bB1fs+KkYEsv1DX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162202; c=relaxed/simple;
	bh=ss7DfeQ3iIOHVfPafgYrAJPDTsUQSQx+kzwMyH5OwKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4+sQaJ3msLKEBFEm2BVb4/68Mtjn12yjWYfYEi533tfclgZz61dgo1o30tevf0OQ+jdnrn+5enrv4b7oy388dvX+jqUZL5iHS7JBQWLH+qYNUitKPLJDoD2YdCPJYL4uvTaTScI1611sQb30+b1z7j5ZqapEdvHZD5GpzmXFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjcNAsj1; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715162198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsicJzPzSYjb9EaWqN7pAslrOCGTYHDq5WxD1KJCe/4=;
	b=kjcNAsj1cuN9Enofn4z93wcbSAjYLywjhJjN77ua1sIREN682XM4/TUP7KT8khp+C1Lxo9
	/sUFpeSD3NLJqtnOZwJbyj9x/lzghKhbvs6VQjYNuH7/a4A3y3fzWLWWbcQd8hcfO2GpIG
	/os+5isiO/1zThfvmUzmeT4jB804zKw=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 17:55:41 +0800
Subject: [PATCH 4/4] mm/ksm: calculate general_profit more accurately
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-counters-v1-4-e2a9b13f70c5@linux.dev>
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
In-Reply-To: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715162174; l=2381;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=ss7DfeQ3iIOHVfPafgYrAJPDTsUQSQx+kzwMyH5OwKo=;
 b=X6wGm8B+bjpFtCP8g73w6XczYKdiMwJ0vj812mxv/NkXQMbGzsqKeRNtJg3TU4ZL32DX+qm6z
 RzE/1RA0jgRBfO4CzfzJYEvfQ2HcOnx7ltDIHCHSXi8xkvh4KwjavFh
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The memory resource of KSM is mainly ksm_rmap_item, which has to allocate
for each anon page that mm has mapped on. Another memory resource is the
ksm_stable_node, which is much less than the ksm_rmap_item.

We can account it easily to make general_profit calculation more accurate.
This is important when max_page_sharing is limited and so we have more
chained nodes.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 87ffd228944c..a9ce17e6814d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -267,6 +267,9 @@ static unsigned long ksm_pages_unshared;
 /* The number of rmap_items in use: to calculate pages_volatile */
 static unsigned long ksm_rmap_items;
 
+/* The number of stable_node */
+static unsigned long ksm_stable_nodes;
+
 /* The number of stable_node chains */
 static unsigned long ksm_stable_node_chains;
 
@@ -584,12 +587,17 @@ static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 
 static inline struct ksm_stable_node *alloc_stable_node(void)
 {
+	struct ksm_stable_node *node;
+
 	/*
 	 * The allocation can take too long with GFP_KERNEL when memory is under
 	 * pressure, which may lead to hung task warnings.  Adding __GFP_HIGH
 	 * grants access to memory reserves, helping to avoid this problem.
 	 */
-	return kmem_cache_alloc(stable_node_cache, GFP_KERNEL | __GFP_HIGH);
+	node = kmem_cache_alloc(stable_node_cache, GFP_KERNEL | __GFP_HIGH);
+	if (likely(node))
+		ksm_stable_nodes++;
+	return node;
 }
 
 static inline void free_stable_node(struct ksm_stable_node *stable_node)
@@ -597,6 +605,7 @@ static inline void free_stable_node(struct ksm_stable_node *stable_node)
 	VM_BUG_ON(stable_node->rmap_hlist_len &&
 		  !is_stable_node_chain(stable_node));
 	kmem_cache_free(stable_node_cache, stable_node);
+	ksm_stable_nodes--;
 }
 
 /*
@@ -3671,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
 	long general_profit;
 
 	general_profit = (ksm_pages_sharing + get_ksm_zero_pages()) * PAGE_SIZE -
-				ksm_rmap_items * sizeof(struct ksm_rmap_item);
+				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
+				ksm_stable_nodes * sizeof(struct ksm_stable_node);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);
 }

-- 
2.45.0



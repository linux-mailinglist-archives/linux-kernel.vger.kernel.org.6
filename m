Return-Path: <linux-kernel+bounces-571747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD0A6C1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0CB167726
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3B22FF5F;
	Fri, 21 Mar 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnZ0WOkd"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6EE22FDE8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578662; cv=none; b=KZ4cG4JmisCAQZsTiUOPu9+7PpY/HAJQo8Z7GXeGyQjg8cxcK6Xy+5/EMqif0DcHKBeE4SQadqV7kaTg7Ddb00s2GUO0A1l77+bopXNRLtoQGHIS012CcuWKXW9sUd5V8W402Ij3lBuy9hXV/6MvbAy78Vc9fUCsFuM2vOcDFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578662; c=relaxed/simple;
	bh=xG0wWXKoZAwJPsxLwom/7j0KkgqbNPFbSm+fWCi52dc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nnjH7BWxSNoawpxGiEy3/G4vJ/uGz7ivdNAYCxUrpgPxAd9KGYDcKeCD2FKp4IUfndvYj0iYz+7sX4e2TW0o/BicLj3z7VUP8fljPPVOhiz3carGIPNi8l0/reqGEO59QxPXhKBaHY7jwQ/ifY8Se7D513nq6zd/FsI5iHluyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnZ0WOkd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3011bee1751so3467474a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742578660; x=1743183460; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+86G2SUYfeiHLweFc9OnEaVmlu/kSLmPHY1T1dM0HE=;
        b=JnZ0WOkdWtuYnAhAXvjfjcgYoZxoBxQqxO1VpopP0O/Qa5L/96vkROi6Bu2znETjK4
         FEiWmwPDmgBvZCGk+BLbe2lvZI+tpDLajHOB8x9gE4KsUAsSfKQntQv/q9shrx16lOPM
         gIeHVuCDcfqUB4oGdjESHDT398iD5Vbw0rHGaVmJwALxWjQH1Rwq7ZE0N0JswL6NBcYc
         d5ieQDp6aMZXrbTPFb9a1S4JRrlv9ra+8ie7SnhKXrnWkShLlWJq7RnAI+lRgXi7bFaN
         Q+wM3yk89BaXPm8/FoatDuYAnhhpHVMd6ueRdbNB2o57bkh2TVVBhFqauwjHI1haqdLb
         r0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578660; x=1743183460;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+86G2SUYfeiHLweFc9OnEaVmlu/kSLmPHY1T1dM0HE=;
        b=l90UO91c3F3lNA/43TGxboB5VscSOkjmssuO3RI49+oj4323La6F0ee2pT8qcQgfn8
         OsUkXLhkX43UVyyxs++zIcE+FTEZPRfwg0OB7aLWjvNnVpqfAv89/pMB0C4+chc8VYbc
         WSCwfFKXnHKRKtAtNA/vn/btAqIGWXdo5erdZSauI4CV6gSrekem6ufFzcFuZE0Fh6YM
         wYJBDATKZGfA7mQCWDz2O8kU3ovtxiR45LbxUNfTxSuXNxHu5WB3tEsKfW543SwUWy/l
         6YLOOYA73D5/31fnbsjmyCZf91cq44ER7xTnUWwwvUXc29GWEQDefgU59MKFbQvmcoHO
         77Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXt/XHL2uQ//4uq1uWZp9LiqKfZh6HODgKkXamrwb4WUdYdtBa0JwUSCSmpmh0mv5u7ahgU5Htr695l3fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGOSEVAy+f+T3XQKtJDu2g1YrOZilA42tucu8xy6WwcZjPYcL
	kshp3LkC9cntgMPsq0I8J/S8sPrMTloFDeFuvOC8PRvwehNckb23mVS8MjOCiRUDZV7isdlLsLS
	jqFME9JRxYf/ahZGkZz98Sg==
X-Google-Smtp-Source: AGHT+IGm4f7njleqOWwtfaudXh+F/G/hZodt/w5YdBSQxu8dXfprXgYhidXkVGY03bHplMdrG0x4phFmYcftkI/tzg==
X-Received: from pjtd12.prod.google.com ([2002:a17:90b:4c:b0:2fa:27e2:a64d])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5450:b0:2ff:5714:6a with SMTP id 98e67ed59e1d1-3030fe98134mr5881396a91.19.1742578660362;
 Fri, 21 Mar 2025 10:37:40 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:37:27 +0000
In-Reply-To: <20250321173729.3175898-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321173729.3175898-1-souravpanda@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321173729.3175898-5-souravpanda@google.com>
Subject: [RFC PATCH 4/6] mm: create dedicated trees for SELECTIVE KSM partitions
From: Sourav Panda <souravpanda@google.com>
To: mathieu.desnoyers@efficios.com, willy@infradead.org, david@redhat.com, 
	pasha.tatashin@soleen.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com, 
	gthelen@google.com, souravpanda@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Extend ksm to create dedicated unstable and stable trees for
each partition.

Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 mm/ksm.c | 165 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 111 insertions(+), 54 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 927e257c48b5..b575250aaf45 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -144,6 +144,28 @@ struct ksm_scan {
 	unsigned long seqnr;
 };
 
+static struct kobject *ksm_base_kobj;
+
+struct partition_kobj {
+	struct kobject *kobj;
+	struct list_head list;
+	struct rb_root *root_stable_tree;
+	struct rb_root *root_unstable_tree;
+};
+
+static LIST_HEAD(partition_list);
+
+static struct partition_kobj *find_partition_by_kobj(struct kobject *kobj)
+{
+	struct partition_kobj *partition;
+
+	list_for_each_entry(partition, &partition_list, list) {
+		if (partition->kobj == kobj)
+			return partition;
+	}
+	return NULL;
+}
+
 /**
  * struct ksm_stable_node - node of the stable rbtree
  * @node: rb node of this ksm page in the stable tree
@@ -182,6 +204,7 @@ struct ksm_stable_node {
 #ifdef CONFIG_NUMA
 	int nid;
 #endif
+	struct partition_kobj *partition;
 };
 
 /**
@@ -218,6 +241,7 @@ struct ksm_rmap_item {
 			struct hlist_node hlist;
 		};
 	};
+	struct partition_kobj *partition;
 };
 
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
@@ -227,8 +251,6 @@ struct ksm_rmap_item {
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
 static struct rb_root one_unstable_tree[1] = { RB_ROOT };
-static struct rb_root *root_stable_tree = one_stable_tree;
-static struct rb_root *root_unstable_tree = one_unstable_tree;
 
 /* Recently migrated nodes of stable tree, pending proper placement */
 static LIST_HEAD(migrate_nodes);
@@ -555,7 +577,7 @@ static inline void stable_node_dup_del(struct ksm_stable_node *dup)
 	if (is_stable_node_dup(dup))
 		__stable_node_dup_del(dup);
 	else
-		rb_erase(&dup->node, root_stable_tree + NUMA(dup->nid));
+		rb_erase(&dup->node, dup->partition->root_stable_tree + NUMA(dup->nid));
 #ifdef CONFIG_DEBUG_VM
 	dup->head = NULL;
 #endif
@@ -580,14 +602,20 @@ static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
 
-static inline struct ksm_stable_node *alloc_stable_node(void)
+static inline struct ksm_stable_node *alloc_stable_node(struct partition_kobj *partition)
 {
 	/*
 	 * The allocation can take too long with GFP_KERNEL when memory is under
 	 * pressure, which may lead to hung task warnings.  Adding __GFP_HIGH
 	 * grants access to memory reserves, helping to avoid this problem.
 	 */
-	return kmem_cache_alloc(stable_node_cache, GFP_KERNEL | __GFP_HIGH);
+	struct ksm_stable_node *node =  kmem_cache_alloc(stable_node_cache,
+							 GFP_KERNEL | __GFP_HIGH);
+
+	if (node)
+		node->partition = partition;
+
+	return node;
 }
 
 static inline void free_stable_node(struct ksm_stable_node *stable_node)
@@ -777,9 +805,10 @@ static inline int get_kpfn_nid(unsigned long kpfn)
 }
 
 static struct ksm_stable_node *alloc_stable_node_chain(struct ksm_stable_node *dup,
-						   struct rb_root *root)
+						   struct rb_root *root,
+						   struct partition_kobj *partition)
 {
-	struct ksm_stable_node *chain = alloc_stable_node();
+	struct ksm_stable_node *chain = alloc_stable_node(partition);
 	VM_BUG_ON(is_stable_node_chain(dup));
 	if (likely(chain)) {
 		INIT_HLIST_HEAD(&chain->hlist);
@@ -1016,7 +1045,8 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
 		unsigned char age = get_rmap_item_age(rmap_item);
 		if (!age)
 			rb_erase(&rmap_item->node,
-				 root_unstable_tree + NUMA(rmap_item->nid));
+				 rmap_item->partition->root_unstable_tree +
+				 NUMA(rmap_item->nid));
 		ksm_pages_unshared--;
 		rmap_item->address &= PAGE_MASK;
 	}
@@ -1154,17 +1184,23 @@ static int remove_all_stable_nodes(void)
 	struct ksm_stable_node *stable_node, *next;
 	int nid;
 	int err = 0;
-
-	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
-		while (root_stable_tree[nid].rb_node) {
-			stable_node = rb_entry(root_stable_tree[nid].rb_node,
-						struct ksm_stable_node, node);
-			if (remove_stable_node_chain(stable_node,
-						     root_stable_tree + nid)) {
-				err = -EBUSY;
-				break;	/* proceed to next nid */
+	struct partition_kobj *partition;
+	struct rb_root *root_stable_tree;
+
+	list_for_each_entry(partition, &partition_list, list) {
+		root_stable_tree = partition->root_stable_tree;
+
+		for (nid = 0; nid < ksm_nr_node_ids; nid++) {
+			while (root_stable_tree[nid].rb_node) {
+				stable_node = rb_entry(root_stable_tree[nid].rb_node,
+						       struct ksm_stable_node, node);
+				if (remove_stable_node_chain(stable_node,
+							     root_stable_tree + nid)) {
+					err = -EBUSY;
+					break;	/* proceed to next nid */
+				}
+				cond_resched();
 			}
-			cond_resched();
 		}
 	}
 	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
@@ -1802,7 +1838,8 @@ static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
  * This function returns the stable tree node of identical content if found,
  * -EBUSY if the stable node's page is being migrated, NULL otherwise.
  */
-static struct folio *stable_tree_search(struct page *page)
+static struct folio *stable_tree_search(struct page *page,
+					struct partition_kobj *partition)
 {
 	int nid;
 	struct rb_root *root;
@@ -1821,7 +1858,7 @@ static struct folio *stable_tree_search(struct page *page)
 	}
 
 	nid = get_kpfn_nid(folio_pfn(folio));
-	root = root_stable_tree + nid;
+	root = partition->root_stable_tree + nid;
 again:
 	new = &root->rb_node;
 	parent = NULL;
@@ -1991,7 +2028,7 @@ static struct folio *stable_tree_search(struct page *page)
 		VM_BUG_ON(is_stable_node_dup(stable_node_dup));
 		/* chain is missing so create it */
 		stable_node = alloc_stable_node_chain(stable_node_dup,
-						      root);
+						      root, partition);
 		if (!stable_node)
 			return NULL;
 	}
@@ -2016,7 +2053,8 @@ static struct folio *stable_tree_search(struct page *page)
  * This function returns the stable tree node just allocated on success,
  * NULL otherwise.
  */
-static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
+static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio,
+						  struct partition_kobj *partition)
 {
 	int nid;
 	unsigned long kpfn;
@@ -2028,7 +2066,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 
 	kpfn = folio_pfn(kfolio);
 	nid = get_kpfn_nid(kpfn);
-	root = root_stable_tree + nid;
+	root = partition->root_stable_tree + nid;
 again:
 	parent = NULL;
 	new = &root->rb_node;
@@ -2067,7 +2105,7 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 		}
 	}
 
-	stable_node_dup = alloc_stable_node();
+	stable_node_dup = alloc_stable_node(partition);
 	if (!stable_node_dup)
 		return NULL;
 
@@ -2082,7 +2120,8 @@ static struct ksm_stable_node *stable_tree_insert(struct folio *kfolio)
 		if (!is_stable_node_chain(stable_node)) {
 			struct ksm_stable_node *orig = stable_node;
 			/* chain is missing so create it */
-			stable_node = alloc_stable_node_chain(orig, root);
+			stable_node = alloc_stable_node_chain(orig, root,
+							      partition);
 			if (!stable_node) {
 				free_stable_node(stable_node_dup);
 				return NULL;
@@ -2121,7 +2160,7 @@ struct ksm_rmap_item *unstable_tree_search_insert(struct ksm_rmap_item *rmap_ite
 	int nid;
 
 	nid = get_kpfn_nid(page_to_pfn(page));
-	root = root_unstable_tree + nid;
+	root = rmap_item->partition->root_unstable_tree + nid;
 	new = &root->rb_node;
 
 	while (*new) {
@@ -2291,7 +2330,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	}
 
 	/* Start by searching for the folio in the stable tree */
-	kfolio = stable_tree_search(page);
+	kfolio = stable_tree_search(page, rmap_item->partition);
 	if (&kfolio->page == page && rmap_item->head == stable_node) {
 		folio_put(kfolio);
 		return;
@@ -2344,7 +2383,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 			 * node in the stable tree and add both rmap_items.
 			 */
 			folio_lock(kfolio);
-			stable_node = stable_tree_insert(kfolio);
+			stable_node = stable_tree_insert(kfolio,
+							 rmap_item->partition);
 			if (stable_node) {
 				stable_tree_append(tree_rmap_item, stable_node,
 						   false);
@@ -2502,7 +2542,8 @@ static struct ksm_rmap_item *retrieve_rmap_item(struct page **page,
 }
 
 static void ksm_sync_merge(struct mm_struct *mm,
-			   unsigned long start, unsigned long end)
+			   unsigned long start, unsigned long end,
+			   struct partition_kobj *partition)
 {
 	struct ksm_rmap_item *rmap_item;
 	struct page *page;
@@ -2510,6 +2551,7 @@ static void ksm_sync_merge(struct mm_struct *mm,
 	rmap_item = retrieve_rmap_item(&page, mm, start, end);
 	if (!rmap_item)
 		return;
+	rmap_item->partition = partition;
 	cmp_and_merge_page(page, rmap_item);
 	put_page(page);
 }
@@ -3328,19 +3370,23 @@ static void ksm_check_stable_tree(unsigned long start_pfn,
 	struct ksm_stable_node *stable_node, *next;
 	struct rb_node *node;
 	int nid;
-
-	for (nid = 0; nid < ksm_nr_node_ids; nid++) {
-		node = rb_first(root_stable_tree + nid);
-		while (node) {
-			stable_node = rb_entry(node, struct ksm_stable_node, node);
-			if (stable_node_chain_remove_range(stable_node,
-							   start_pfn, end_pfn,
-							   root_stable_tree +
-							   nid))
-				node = rb_first(root_stable_tree + nid);
-			else
-				node = rb_next(node);
-			cond_resched();
+	struct rb_root *root_stable_tree
+
+	list_for_each_entry(partition, &partition_list, list) {
+		root_stable_tree = partition->root_stable_tree;
+
+		for (nid = 0; nid < ksm_nr_node_ids; nid++) {
+			node = rb_first(root_stable_tree + nid);
+			while (node) {
+				stable_node = rb_entry(node, struct ksm_stable_node, node);
+				if (stable_node_chain_remove_range(stable_node,
+								   start_pfn, end_pfn,
+								   root_stable_tree + nid))
+					node = rb_first(root_stable_tree + nid);
+				else
+					node = rb_next(node);
+				cond_resched();
+			}
 		}
 	}
 	list_for_each_entry_safe(stable_node, next, &migrate_nodes, list) {
@@ -3551,6 +3597,7 @@ static ssize_t trigger_merge_store(struct kobject *kobj,
 	int ret;
 	struct task_struct *task;
 	struct mm_struct *mm;
+	struct partition_kobj *partition;
 
 	input = kstrdup(buf, GFP_KERNEL);
 	if (!input)
@@ -3583,9 +3630,13 @@ static ssize_t trigger_merge_store(struct kobject *kobj,
 	if (!mm)
 		return -EINVAL;
 
+	partition = find_partition_by_kobj(kobj);
+	if (!partition)
+		return -EINVAL;
+
 	mutex_lock(&ksm_thread_mutex);
 	wait_while_offlining();
-	ksm_sync_merge(mm, start, end);
+	ksm_sync_merge(mm, start, end, partition);
 	mutex_unlock(&ksm_thread_mutex);
 
 	mmput(mm);
@@ -3606,6 +3657,8 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
 {
 	int err;
 	unsigned long knob;
+	struct rb_root *root_stable_tree;
+	struct partition_kobj *partition;
 
 	err = kstrtoul(buf, 10, &knob);
 	if (err)
@@ -3615,6 +3668,10 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
 
 	mutex_lock(&ksm_thread_mutex);
 	wait_while_offlining();
+
+	partition = find_partition_by_kobj(kobj);
+	root_stable_tree = partition->root_stable_tree;
+
 	if (ksm_merge_across_nodes != knob) {
 		if (ksm_pages_shared || remove_all_stable_nodes())
 			err = -EBUSY;
@@ -3633,10 +3690,10 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
 			if (!buf)
 				err = -ENOMEM;
 			else {
-				root_stable_tree = buf;
-				root_unstable_tree = buf + nr_node_ids;
+				partition->root_stable_tree = buf;
+				partition->root_unstable_tree = buf + nr_node_ids;
 				/* Stable tree is empty but not the unstable */
-				root_unstable_tree[0] = one_unstable_tree[0];
+				partition->root_unstable_tree[0] = one_unstable_tree[0];
 			}
 		}
 		if (!err) {
@@ -3834,14 +3891,6 @@ KSM_ATTR_RO(full_scans);
 
 #ifdef CONFIG_SELECTIVE_KSM
 static struct kobject *ksm_base_kobj;
-
-struct partition_kobj {
-	struct kobject *kobj;
-	struct list_head list;
-};
-
-static LIST_HEAD(partition_list);
-
 #else /* CONFIG_SELECTIVE_KSM */
 static ssize_t smart_scan_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *buf)
@@ -4055,6 +4104,7 @@ static ssize_t add_partition_store(struct kobject *kobj,
 	struct partition_kobj *new_partition_kobj;
 	char partition_name[50];
 	int err;
+	struct rb_root *tree_root;
 
 	mutex_lock(&ksm_thread_mutex);
 
@@ -4081,6 +4131,13 @@ static ssize_t add_partition_store(struct kobject *kobj,
 		goto unlock;
 	}
 
+	tree_root = kcalloc(nr_node_ids + nr_node_ids, sizeof(*tree_root), GFP_KERNEL);
+	if (!tree_root) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+	new_partition_kobj->root_stable_tree = tree_root;
+	new_partition_kobj->root_unstable_tree = tree_root + nr_node_ids;
 	err = sysfs_create_group(new_partition_kobj->kobj, &ksm_attr_group);
 	if (err) {
 		pr_err("ksm: register sysfs failed\n");
-- 
2.49.0.395.g12beb8f557-goog



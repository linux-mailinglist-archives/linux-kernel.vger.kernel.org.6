Return-Path: <linux-kernel+bounces-285766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A061951253
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF33B282984
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35A18059;
	Wed, 14 Aug 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUMWPb+g"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94302364AB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602321; cv=none; b=CRMJxIUOZ3Pr0NMfEEzmddmyyt0x01uw8YOe4YSGMxLSErbnX5nvtJNZH/NxQIIModbdQyKSsAJQd32NKpZAe8hGv2pYU+tQAcNPKup5IFOaazyQXeHu0QkFborC+Nsp/ZkpNMuucOvsVr8PU01mqmYgECfpxSmJbUYuG6x1Y9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602321; c=relaxed/simple;
	bh=YFnJgM0Bk6axYWJ1N8ZrsgfLleljceEDAkq4vooYsnc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kIkHr6PYIWqO0iKyrfmQVr0jglrSQ4D9QG5kyKu+RXgRLZYWprPen3o7YkA4fH+DazHYX645leHjiIFHmbFKgVRpAac/H5h8rHhvr4aEJjWbDgxj/OgTe0/oyJAyVrehMgyeqave00uM6EdlupZwGWM+O3aFwFTlQOZQBPIfUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUMWPb+g; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so713306466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723602317; x=1724207117; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjxnPSupJH/F1PU/VHJ+DWYQUFvtnPi1lvP1Kx1Xehc=;
        b=AUMWPb+gFR0xtEeT/NGgo5jeq2mFMDokiJo1nwc2krGgpDyuCxNsIeBcdjPQRaLoH7
         JYxI70O3C3wVn6wlTbsnQLSYRd7/dbqgDeacPy11uINN/SNlW90QsPdDjIxJqxHBmzPM
         t591WB0cD20XngB6Ka/fYQ4xLl+/aeBVLLYC0Mb6QZvsn5Xee6Wk8J0NuZJxCoLMgI0f
         KYYskQQVUZL1YTJI++d0hvDccOJlTzvCQlC8/34pEngrPk16vmy86qSuFDYnqLYfhXq7
         ZTKhrI0b0wmKJ67K/Dctr3fpIk9ZKLPc26oVC8uLD9N0WWGB/+Np0jpIhh232SYT3GDQ
         nzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602317; x=1724207117;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjxnPSupJH/F1PU/VHJ+DWYQUFvtnPi1lvP1Kx1Xehc=;
        b=BM1YijjYC028+cIw342irn6AhG/er+AwTngqolhEVaMfVRl1J1oCvC8O7ylWUTeIMy
         EBaozU1Gm4GYrgVJ7X/YGIeWL+lBcWb+i1759Vj0p5FDasRVfIj5C5WJMA63HL9QTXKy
         PrzhoSrII54FhKWPowx9KywvO40pcR4ekGt4wJiAeXjucbQpNIas2pVbS+Sd6Le1hGP3
         O5uI2biGCT9q72j8jInq0n4LxjfADQg+OpWlRqPuqVBLkVMUG1pZ71mvXKOGXDSXCae3
         21ftf0l1pGup44xs6xpxLvvNhPS+a5fWk4i4FNIiRhYQv4SHYuhX61srr5zqe94FdvrO
         bjVw==
X-Gm-Message-State: AOJu0Yytq4GGIJ1+MUZJAnQTSSPgNz+agpvjFB1kCf9rh/nYgU7jch90
	GzOvKc4rJmzE49USfA3JqqYf+0UOsERtUpo41mhbmqPedfDPlw75
X-Google-Smtp-Source: AGHT+IE72XD9CL4j10ADEiFxJuXnqk+sw+QWAjDdHPnEA4NFzKa4WKdUVH/NLJ9Kttl1Zw4EsmSDxw==
X-Received: by 2002:a17:906:d246:b0:a77:cf09:9c70 with SMTP id a640c23a62f3a-a8367086cacmr76952666b.43.1723602316112;
        Tue, 13 Aug 2024 19:25:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411bb24sm117589066b.127.2024.08.13.19.25.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2024 19:25:15 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] maple_tree: clean up kernel doc
Date: Wed, 14 Aug 2024 02:25:09 +0000
Message-Id: <20240814022509.3806-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Went through the kernel doc in maple_tree.c, there are several points
needs to be cleaned.

  * kernel-doc should start with '/**'
  * function parameter's count/name not comply with code
  * function parameter should end with ':' instead of '-'
  * void function with return statement

This patch cleans up the format issue of maple_tree.c kernel doc.

There are still some warning from ./scripts/kernel-doc after the
cleanup, since there are several missing explanation on function
parameters. I don't touch it since I am not sure for them.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 365 +++++++++++++++++++++++------------------------
 1 file changed, 179 insertions(+), 186 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3f212bd118fb..7aa68c814e91 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -184,7 +184,7 @@ static void mt_free_rcu(struct rcu_head *head)
 	kmem_cache_free(maple_node_cache, node);
 }
 
-/*
+/**
  * ma_free_rcu() - Use rcu callback to free a maple node
  * @node: The node to free
  *
@@ -291,7 +291,7 @@ static __always_inline struct maple_node *mte_to_node(
 	return (struct maple_node *)((unsigned long)entry & ~MAPLE_NODE_MASK);
 }
 
-/*
+/**
  * mte_to_mat() - Convert a maple encoded node to a maple topiary node.
  * @entry: The maple encoded node
  *
@@ -303,7 +303,7 @@ static inline struct maple_topiary *mte_to_mat(const struct maple_enode *entry)
 		((unsigned long)entry & ~MAPLE_NODE_MASK);
 }
 
-/*
+/**
  * mas_mn() - Get the maple state node.
  * @mas: The maple state
  *
@@ -314,7 +314,7 @@ static inline struct maple_node *mas_mn(const struct ma_state *mas)
 	return mte_to_node(mas->node);
 }
 
-/*
+/**
  * mte_set_node_dead() - Set a maple encoded node as dead.
  * @mn: The maple encoded node.
  */
@@ -416,7 +416,7 @@ static __always_inline bool mt_is_alloc(struct maple_tree *mt)
 #define MAPLE_PARENT_RANGE32		0x04
 #define MAPLE_PARENT_NOT_RANGE16	0x02
 
-/*
+/**
  * mte_parent_shift() - Get the parent shift for the slot storage.
  * @parent: The parent pointer cast as an unsigned long
  * Return: The shift into that pointer to the star to of the slot
@@ -430,7 +430,7 @@ static inline unsigned long mte_parent_shift(unsigned long parent)
 	return MAPLE_PARENT_16B_SLOT_SHIFT;
 }
 
-/*
+/**
  * mte_parent_slot_mask() - Get the slot mask for the parent.
  * @parent: The parent pointer cast as an unsigned long.
  * Return: The slot mask for that parent.
@@ -444,7 +444,7 @@ static inline unsigned long mte_parent_slot_mask(unsigned long parent)
 	return MAPLE_PARENT_16B_SLOT_MASK;
 }
 
-/*
+/**
  * mas_parent_type() - Return the maple_type of the parent from the stored
  * parent type.
  * @mas: The maple state
@@ -472,8 +472,9 @@ enum maple_type mas_parent_type(struct ma_state *mas, struct maple_enode *enode)
 	return 0;
 }
 
-/*
+/**
  * mas_set_parent() - Set the parent node and encode the slot
+ * @mas: The maple state
  * @enode: The encoded maple node.
  * @parent: The encoded maple node that is the parent of @enode.
  * @slot: The slot that @enode resides in @parent.
@@ -511,7 +512,7 @@ void mas_set_parent(struct ma_state *mas, struct maple_enode *enode,
 	mte_to_node(enode)->parent = ma_parent_ptr(val);
 }
 
-/*
+/**
  * mte_parent_slot() - get the parent slot of @enode.
  * @enode: The encoded maple node.
  *
@@ -532,9 +533,9 @@ unsigned int mte_parent_slot(const struct maple_enode *enode)
 	return (val & MAPLE_PARENT_16B_SLOT_MASK) >> mte_parent_shift(val);
 }
 
-/*
+/**
  * mte_parent() - Get the parent of @node.
- * @node: The encoded maple node.
+ * @enode: The encoded maple node.
  *
  * Return: The parent maple node.
  */
@@ -545,9 +546,9 @@ struct maple_node *mte_parent(const struct maple_enode *enode)
 			(mte_to_node(enode)->parent) & ~MAPLE_NODE_MASK);
 }
 
-/*
+/**
  * ma_dead_node() - check if the @enode is dead.
- * @enode: The encoded maple node
+ * @node: The maple node
  *
  * Return: true if dead, false otherwise.
  */
@@ -561,7 +562,7 @@ static __always_inline bool ma_dead_node(const struct maple_node *node)
 	return (parent == node);
 }
 
-/*
+/**
  * mte_dead_node() - check if the @enode is dead.
  * @enode: The encoded maple node
  *
@@ -578,7 +579,7 @@ static __always_inline bool mte_dead_node(const struct maple_enode *enode)
 	return (parent == node);
 }
 
-/*
+/**
  * mas_allocated() - Get the number of nodes allocated in a maple state.
  * @mas: The maple state
  *
@@ -597,7 +598,7 @@ static inline unsigned long mas_allocated(const struct ma_state *mas)
 	return mas->alloc->total;
 }
 
-/*
+/**
  * mas_set_alloc_req() - Set the requested number of allocations.
  * @mas: the maple state
  * @count: the number of allocations.
@@ -620,7 +621,7 @@ static inline void mas_set_alloc_req(struct ma_state *mas, unsigned long count)
 	mas->alloc->request_count = count;
 }
 
-/*
+/**
  * mas_alloc_req() - get the requested number of allocations.
  * @mas: The maple state
  *
@@ -639,10 +640,10 @@ static inline unsigned int mas_alloc_req(const struct ma_state *mas)
 	return 0;
 }
 
-/*
+/**
  * ma_pivots() - Get a pointer to the maple node pivots.
- * @node - the maple node
- * @type - the node type
+ * @node: the maple node
+ * @type: the node type
  *
  * In the event of a dead node, this array may be %NULL
  *
@@ -663,10 +664,10 @@ static inline unsigned long *ma_pivots(struct maple_node *node,
 	return NULL;
 }
 
-/*
+/**
  * ma_gaps() - Get a pointer to the maple node gaps.
- * @node - the maple node
- * @type - the node type
+ * @node: the maple node
+ * @type: the node type
  *
  * Return: A pointer to the maple node gaps
  */
@@ -684,7 +685,7 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
 	return NULL;
 }
 
-/*
+/**
  * mas_safe_pivot() - get the pivot at @piv or mas->max.
  * @mas: The maple state
  * @pivots: The pointer to the maple node pivots
@@ -704,7 +705,7 @@ mas_safe_pivot(const struct ma_state *mas, unsigned long *pivots,
 	return pivots[piv];
 }
 
-/*
+/**
  * mas_safe_min() - Return the minimum for a given offset.
  * @mas: The maple state
  * @pivots: The pointer to the maple node pivots
@@ -721,7 +722,7 @@ mas_safe_min(struct ma_state *mas, unsigned long *pivots, unsigned char offset)
 	return mas->min;
 }
 
-/*
+/**
  * mte_set_pivot() - Set a pivot to a value in an encoded maple node.
  * @mn: The encoded maple node
  * @piv: The pivot offset
@@ -748,7 +749,7 @@ static inline void mte_set_pivot(struct maple_enode *mn, unsigned char piv,
 
 }
 
-/*
+/**
  * ma_slots() - Get a pointer to the maple node slots.
  * @mn: The maple node
  * @mt: The maple node type
@@ -793,7 +794,8 @@ static __always_inline void *mt_slot_locked(struct maple_tree *mt,
 {
 	return rcu_dereference_protected(slots[offset], mt_write_locked(mt));
 }
-/*
+
+/**
  * mas_slot_locked() - Get the slot value when holding the maple tree lock.
  * @mas: The maple state
  * @slots: The pointer to the slots
@@ -807,7 +809,7 @@ static __always_inline void *mas_slot_locked(struct ma_state *mas,
 	return mt_slot_locked(mas->tree, slots, offset);
 }
 
-/*
+/**
  * mas_slot() - Get the slot value when not holding the maple tree lock.
  * @mas: The maple state
  * @slots: The pointer to the slots
@@ -821,7 +823,7 @@ static __always_inline void *mas_slot(struct ma_state *mas, void __rcu **slots,
 	return mt_slot(mas->tree, slots, offset);
 }
 
-/*
+/**
  * mas_root() - Get the maple tree root.
  * @mas: The maple state.
  *
@@ -837,7 +839,7 @@ static inline void *mt_root_locked(struct maple_tree *mt)
 	return rcu_dereference_protected(mt->ma_root, mt_write_locked(mt));
 }
 
-/*
+/**
  * mas_root_locked() - Get the maple tree root when holding the maple tree lock.
  * @mas: The maple state.
  *
@@ -859,7 +861,7 @@ static inline struct maple_metadata *ma_meta(struct maple_node *mn,
 	}
 }
 
-/*
+/**
  * ma_set_meta() - Set the metadata information of a node.
  * @mn: The maple node
  * @mt: The maple node type
@@ -875,13 +877,11 @@ static inline void ma_set_meta(struct maple_node *mn, enum maple_type mt,
 	meta->end = end;
 }
 
-/*
+/**
  * mt_clear_meta() - clear the metadata information of a node, if it exists
  * @mt: The maple tree
  * @mn: The maple node
  * @type: The maple node type
- * @offset: The offset of the highest sub-gap in this node.
- * @end: The end of the data in this node.
  */
 static inline void mt_clear_meta(struct maple_tree *mt, struct maple_node *mn,
 				  enum maple_type type)
@@ -914,7 +914,7 @@ static inline void mt_clear_meta(struct maple_tree *mt, struct maple_node *mn,
 	meta->end = 0;
 }
 
-/*
+/**
  * ma_meta_end() - Get the data end of a node from the metadata
  * @mn: The maple node
  * @mt: The maple node type
@@ -927,7 +927,7 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 	return meta->end;
 }
 
-/*
+/**
  * ma_meta_gap() - Get the largest gap location of a node from the metadata
  * @mn: The maple node
  */
@@ -936,10 +936,10 @@ static inline unsigned char ma_meta_gap(struct maple_node *mn)
 	return mn->ma64.meta.gap;
 }
 
-/*
+/**
  * ma_set_meta_gap() - Set the largest gap location in a nodes metadata
  * @mn: The maple node
- * @mn: The maple node type
+ * @mt: The maple node type
  * @offset: The location of the largest gap.
  */
 static inline void ma_set_meta_gap(struct maple_node *mn, enum maple_type mt,
@@ -951,10 +951,10 @@ static inline void ma_set_meta_gap(struct maple_node *mn, enum maple_type mt,
 	meta->gap = offset;
 }
 
-/*
+/**
  * mat_add() - Add a @dead_enode to the ma_topiary of a list of dead nodes.
- * @mat - the ma_topiary, a linked list of dead nodes.
- * @dead_enode - the node to be marked as dead and added to the tail of the list
+ * @mat: the ma_topiary, a linked list of dead nodes.
+ * @dead_enode: the node to be marked as dead and added to the tail of the list
  *
  * Add the @dead_enode to the linked list in @mat.
  */
@@ -975,10 +975,10 @@ static inline void mat_add(struct ma_topiary *mat,
 static void mt_free_walk(struct rcu_head *head);
 static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 			    bool free);
-/*
+/**
  * mas_mat_destroy() - Free all nodes and subtrees in a dead list.
- * @mas - the maple state
- * @mat - the ma_topiary linked list of dead nodes to free.
+ * @mas: the maple state
+ * @mat: the ma_topiary linked list of dead nodes to free.
  *
  * Destroy walk a dead list.
  */
@@ -997,9 +997,9 @@ static void mas_mat_destroy(struct ma_state *mas, struct ma_topiary *mat)
 		mat->head = next;
 	}
 }
-/*
+/**
  * mas_descend() - Descend into the slot stored in the ma_state.
- * @mas - the maple state.
+ * @mas: the maple state.
  *
  * Note: Not RCU safe, only use in write side or debug code.
  */
@@ -1021,7 +1021,7 @@ static inline void mas_descend(struct ma_state *mas)
 	mas->node = mas_slot(mas, slots, mas->offset);
 }
 
-/*
+/**
  * mte_set_gap() - Set a maple node gap.
  * @mn: The encoded maple node
  * @gap: The offset of the gap to set
@@ -1039,7 +1039,7 @@ static inline void mte_set_gap(const struct maple_enode *mn,
 	}
 }
 
-/*
+/**
  * mas_ascend() - Walk up a level of the tree.
  * @mas: The maple state
  *
@@ -1130,7 +1130,7 @@ static int mas_ascend(struct ma_state *mas)
 	return 0;
 }
 
-/*
+/**
  * mas_pop_node() - Get a previously allocated maple node from the maple state.
  * @mas: The maple state
  *
@@ -1175,7 +1175,7 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
 	return (struct maple_node *)ret;
 }
 
-/*
+/**
  * mas_push_node() - Push a node back on the maple state allocation.
  * @mas: The maple state
  * @used: The used maple node
@@ -1213,7 +1213,7 @@ static inline void mas_push_node(struct ma_state *mas, struct maple_node *used)
 		mas_set_alloc_req(mas, requested - 1);
 }
 
-/*
+/**
  * mas_alloc_nodes() - Allocate nodes into a maple state
  * @mas: The maple state
  * @gfp: The GFP Flags
@@ -1288,7 +1288,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	mas_set_err(mas, -ENOMEM);
 }
 
-/*
+/**
  * mas_free() - Free an encoded maple node
  * @mas: The maple state
  * @used: The encoded maple node to free.
@@ -1306,7 +1306,7 @@ static inline void mas_free(struct ma_state *mas, struct maple_enode *used)
 		mas_push_node(mas, tmp);
 }
 
-/*
+/**
  * mas_node_count_gfp() - Check if enough nodes are allocated and request more
  * if there is not enough nodes.
  * @mas: The maple state
@@ -1323,7 +1323,7 @@ static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gfp)
 	}
 }
 
-/*
+/**
  * mas_node_count() - Check if enough nodes are allocated and request more if
  * there is not enough nodes.
  * @mas: The maple state
@@ -1336,7 +1336,7 @@ static void mas_node_count(struct ma_state *mas, int count)
 	return mas_node_count_gfp(mas, count, GFP_NOWAIT | __GFP_NOWARN);
 }
 
-/*
+/**
  * mas_start() - Sets up maple state for operations.
  * @mas: The maple state.
  *
@@ -1394,7 +1394,7 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
 	return NULL;
 }
 
-/*
+/**
  * ma_data_end() - Find the end of the data in a node.
  * @node: The maple node
  * @type: The maple node type
@@ -1425,7 +1425,7 @@ static __always_inline unsigned char ma_data_end(struct maple_node *node,
 	return mt_pivots[type];
 }
 
-/*
+/**
  * mas_data_end() - Find the end of the data (slot).
  * @mas: the maple state
  *
@@ -1460,9 +1460,9 @@ static inline unsigned char mas_data_end(struct ma_state *mas)
 	return mt_pivots[type];
 }
 
-/*
+/**
  * mas_leaf_max_gap() - Returns the largest gap in a leaf node
- * @mas - the maple state
+ * @mas: the maple state
  *
  * Return: The maximum gap in the leaf.
  */
@@ -1539,12 +1539,12 @@ static unsigned long mas_leaf_max_gap(struct ma_state *mas)
 	return max_gap;
 }
 
-/*
+/**
  * ma_max_gap() - Get the maximum gap in a maple node (non-leaf)
  * @node: The maple node
  * @gaps: The pointer to the gaps
  * @mt: The maple node type
- * @*off: Pointer to store the offset location of the gap.
+ * @off: Pointer to store the offset location of the gap.
  *
  * Uses the metadata data end to scan backwards across set gaps.
  *
@@ -1569,7 +1569,7 @@ ma_max_gap(struct maple_node *node, unsigned long *gaps, enum maple_type mt,
 	return max_gap;
 }
 
-/*
+/**
  * mas_max_gap() - find the largest gap in a non-leaf node and set the slot.
  * @mas: The maple state.
  *
@@ -1593,7 +1593,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 	return gaps[offset];
 }
 
-/*
+/**
  * mas_parent_gap() - Set the parent gap and any gaps above, as needed
  * @mas: The maple state
  * @offset: The gap offset in the parent to set
@@ -1649,9 +1649,9 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 	goto ascend;
 }
 
-/*
+/**
  * mas_update_gap() - Update a nodes gaps and propagate up if necessary.
- * @mas - the maple state.
+ * @mas: the maple state.
  */
 static inline void mas_update_gap(struct ma_state *mas)
 {
@@ -1675,11 +1675,11 @@ static inline void mas_update_gap(struct ma_state *mas)
 		mas_parent_gap(mas, pslot, max_gap);
 }
 
-/*
+/**
  * mas_adopt_children() - Set the parent pointer of all nodes in @parent to
  * @parent with the slot encoded.
- * @mas - the maple state (for the tree)
- * @parent - the maple encoded node containing the children.
+ * @mas: the maple state (for the tree)
+ * @parent: the maple encoded node containing the children.
  */
 static inline void mas_adopt_children(struct ma_state *mas,
 		struct maple_enode *parent)
@@ -1698,11 +1698,11 @@ static inline void mas_adopt_children(struct ma_state *mas,
 	} while (offset--);
 }
 
-/*
+/**
  * mas_put_in_tree() - Put a new node in the tree, smp_wmb(), and mark the old
  * node as dead.
- * @mas - the maple state with the new node
- * @old_enode - The old maple encoded node to replace.
+ * @mas: the maple state with the new node
+ * @old_enode: The old maple encoded node to replace.
  */
 static inline void mas_put_in_tree(struct ma_state *mas,
 		struct maple_enode *old_enode)
@@ -1726,12 +1726,12 @@ static inline void mas_put_in_tree(struct ma_state *mas,
 	mte_set_node_dead(old_enode);
 }
 
-/*
+/**
  * mas_replace_node() - Replace a node by putting it in the tree, marking it
  * dead, and freeing it.
  * the parent encoding to locate the maple node in the tree.
- * @mas - the ma_state with @mas->node pointing to the new node.
- * @old_enode - The old maple encoded node.
+ * @mas: the ma_state with @mas->node pointing to the new node.
+ * @old_enode: The old maple encoded node.
  */
 static inline void mas_replace_node(struct ma_state *mas,
 		struct maple_enode *old_enode)
@@ -1741,7 +1741,7 @@ static inline void mas_replace_node(struct ma_state *mas,
 	mas_free(mas, old_enode);
 }
 
-/*
+/**
  * mas_find_child() - Find a child who has the parent @mas->node.
  * @mas: the maple state with the parent.
  * @child: the maple state to store the child.
@@ -1776,7 +1776,7 @@ static inline bool mas_find_child(struct ma_state *mas, struct ma_state *child)
 	return false;
 }
 
-/*
+/**
  * mab_shift_right() - Shift the data in mab right. Note, does not clean out the
  * old data or set b_node->b_end.
  * @b_node: the maple_big_node
@@ -1793,10 +1793,9 @@ static inline void mab_shift_right(struct maple_big_node *b_node,
 		memmove(b_node->gap + shift, b_node->gap, size);
 }
 
-/*
+/**
  * mab_middle_node() - Check if a middle node is needed (unlikely)
  * @b_node: the maple_big_node that contains the data.
- * @size: the amount of data in the b_node
  * @split: the potential split location
  * @slot_count: the size that can be stored in a single node being considered.
  *
@@ -1816,7 +1815,7 @@ static inline bool mab_middle_node(struct maple_big_node *b_node, int split,
 	return false;
 }
 
-/*
+/**
  * mab_no_null_split() - ensure the split doesn't fall on a NULL
  * @b_node: the maple_big_node with the data
  * @split: the suggested split location
@@ -1841,9 +1840,10 @@ static inline int mab_no_null_split(struct maple_big_node *b_node,
 	return split;
 }
 
-/*
+/**
  * mab_calc_split() - Calculate the split location and if there needs to be two
  * splits.
+ * @mas: The maple state
  * @bn: The maple_big_node with the data
  * @mid_split: The second split, if required.  0 otherwise.
  *
@@ -1910,7 +1910,7 @@ static inline int mab_calc_split(struct ma_state *mas,
 	return split;
 }
 
-/*
+/**
  * mas_mab_cp() - Copy data from a maple state inclusively to a maple_big_node
  * and set @b_node->b_end to the next free slot.
  * @mas: The maple state
@@ -1965,7 +1965,7 @@ static inline void mas_mab_cp(struct ma_state *mas, unsigned char mas_start,
 	}
 }
 
-/*
+/**
  * mas_leaf_set_meta() - Set the metadata of a leaf if possible.
  * @node: The maple node
  * @mt: The maple type
@@ -1978,7 +1978,7 @@ static inline void mas_leaf_set_meta(struct maple_node *node,
 		ma_set_meta(node, mt, 0, end);
 }
 
-/*
+/**
  * mab_mas_cp() - Copy data from maple_big_node to a maple encoded node.
  * @b_node: the maple_big_node that has the data
  * @mab_start: the start location in @b_node.
@@ -2034,7 +2034,7 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
 	}
 }
 
-/*
+/**
  * mas_bulk_rebalance() - Rebalance the end of a tree after a bulk insert.
  * @mas: The maple state
  * @end: The maple node end
@@ -2055,7 +2055,7 @@ static inline void mas_bulk_rebalance(struct ma_state *mas, unsigned char end,
 	}
 }
 
-/*
+/**
  * mas_store_b_node() - Store an @entry into the b_node while also copying the
  * data from a maple encoded node.
  * @wr_mas: the maple write state
@@ -2130,7 +2130,7 @@ static noinline_for_kasan void mas_store_b_node(struct ma_wr_state *wr_mas,
 	b_node->b_end = b_end;
 }
 
-/*
+/**
  * mas_prev_sibling() - Find the previous node with the same parent.
  * @mas: the maple state
  *
@@ -2152,7 +2152,7 @@ static inline bool mas_prev_sibling(struct ma_state *mas)
 	return true;
 }
 
-/*
+/**
  * mas_next_sibling() - Find the next node with the same parent.
  * @mas: the maple state
  *
@@ -2176,8 +2176,9 @@ static inline bool mas_next_sibling(struct ma_state *mas)
 	return true;
 }
 
-/*
- * mte_node_or_none() - Set the enode and state.
+/**
+ * mas_node_or_none() - Set the enode and state.
+ * @mas: the maple state
  * @enode: The encoded maple node.
  *
  * Set the node to the enode and the status.
@@ -2194,7 +2195,7 @@ static inline void mas_node_or_none(struct ma_state *mas,
 	}
 }
 
-/*
+/**
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
  * @wr_mas: The maple write state
  *
@@ -2225,10 +2226,9 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 	wr_mas->offset_end = mas->offset = offset;
 }
 
-/*
+/**
  * mast_rebalance_next() - Rebalance against the next node
  * @mast: The maple subtree state
- * @old_r: The encoded maple node to the right (next node).
  */
 static inline void mast_rebalance_next(struct maple_subtree_state *mast)
 {
@@ -2239,10 +2239,9 @@ static inline void mast_rebalance_next(struct maple_subtree_state *mast)
 	mast->orig_r->last = mast->orig_r->max;
 }
 
-/*
+/**
  * mast_rebalance_prev() - Rebalance against the previous node
  * @mast: The maple subtree state
- * @old_l: The encoded maple node to the left (previous node)
  */
 static inline void mast_rebalance_prev(struct maple_subtree_state *mast)
 {
@@ -2257,7 +2256,7 @@ static inline void mast_rebalance_prev(struct maple_subtree_state *mast)
 	mast->l->offset += end;
 }
 
-/*
+/**
  * mast_spanning_rebalance() - Rebalance nodes with nearest neighbour favouring
  * the node to the right.  Checking the nodes to the right then the left at each
  * level upwards until root is reached.
@@ -2304,7 +2303,7 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
 	return false;
 }
 
-/*
+/**
  * mast_ascend() - Ascend the original left and right maple states.
  * @mast: the maple subtree state.
  *
@@ -2335,7 +2334,7 @@ static inline void mast_ascend(struct maple_subtree_state *mast)
 	mast->bn->type = wr_mas.type;
 }
 
-/*
+/**
  * mas_new_ma_node() - Create and return a new maple node.  Helper function.
  * @mas: the maple state with the allocations.
  * @b_node: the maple_big_node with the type encoding.
@@ -2351,7 +2350,7 @@ static inline struct maple_enode
 	return mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)), b_node->type);
 }
 
-/*
+/**
  * mas_mab_to_node() - Set up right and middle nodes
  *
  * @mas: the maple state that contains the allocations.
@@ -2390,12 +2389,12 @@ static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 
 }
 
-/*
+/**
  * mab_set_b_end() - Add entry to b_node at b_node->b_end and increment the end
  * pointer.
- * @b_node - the big node to add the entry
- * @mas - the maple state to get the pivot (mas->max)
- * @entry - the entry to add, if NULL nothing happens.
+ * @b_node: the big node to add the entry
+ * @mas: the maple state to get the pivot (mas->max)
+ * @entry: the entry to add, if NULL nothing happens.
  */
 static inline void mab_set_b_end(struct maple_big_node *b_node,
 				 struct ma_state *mas,
@@ -2410,15 +2409,15 @@ static inline void mab_set_b_end(struct maple_big_node *b_node,
 	b_node->pivot[b_node->b_end++] = mas->max;
 }
 
-/*
+/**
  * mas_set_split_parent() - combine_then_separate helper function.  Sets the parent
  * of @mas->node to either @left or @right, depending on @slot and @split
  *
- * @mas - the maple state with the node that needs a parent
- * @left - possible parent 1
- * @right - possible parent 2
- * @slot - the slot the mas->node was placed
- * @split - the split location between @left and @right
+ * @mas: the maple state with the node that needs a parent
+ * @left: possible parent 1
+ * @right: possible parent 2
+ * @slot: the slot the mas->node was placed
+ * @split: the split location between @left and @right
  */
 static inline void mas_set_split_parent(struct ma_state *mas,
 					struct maple_enode *left,
@@ -2436,13 +2435,13 @@ static inline void mas_set_split_parent(struct ma_state *mas,
 	(*slot)++;
 }
 
-/*
+/**
  * mte_mid_split_check() - Check if the next node passes the mid-split
- * @**l: Pointer to left encoded maple node.
- * @**m: Pointer to middle encoded maple node.
- * @**r: Pointer to right encoded maple node.
+ * @l: Pointer to left encoded maple node.
+ * @r: Pointer to middle encoded maple node.
+ * @right: Pointer to right encoded maple node.
  * @slot: The offset
- * @*split: The split location.
+ * @split: The split location.
  * @mid_split: The middle split.
  */
 static inline void mte_mid_split_check(struct maple_enode **l,
@@ -2463,13 +2462,13 @@ static inline void mte_mid_split_check(struct maple_enode **l,
 	*split = mid_split;
 }
 
-/*
+/**
  * mast_set_split_parents() - Helper function to set three nodes parents.  Slot
  * is taken from @mast->l.
- * @mast - the maple subtree state
- * @left - the left node
- * @right - the right node
- * @split - the split location.
+ * @mast: the maple subtree state
+ * @left: the left node
+ * @right: the right node
+ * @split: the split location.
  */
 static inline void mast_set_split_parents(struct maple_subtree_state *mast,
 					  struct maple_enode *left,
@@ -2500,10 +2499,9 @@ static inline void mast_set_split_parents(struct maple_subtree_state *mast,
 	mas_set_split_parent(mast->r, l, r, &slot, split);
 }
 
-/*
+/**
  * mas_topiary_node() - Dispose of a single node
  * @mas: The maple state for pushing nodes
- * @enode: The encoded maple node
  * @in_rcu: If the tree is in rcu mode
  *
  * The node will either be RCU freed or pushed back on the maple state.
@@ -2526,7 +2524,7 @@ static inline void mas_topiary_node(struct ma_state *mas,
 		mas_push_node(mas, tmp);
 }
 
-/*
+/**
  * mas_topiary_replace() - Replace the data with new data, then repair the
  * parent links within the new tree.  Iterate over the dead sub-tree and collect
  * the dead subtrees and topiary the nodes that are no longer of use.
@@ -2632,10 +2630,10 @@ static inline void mas_topiary_replace(struct ma_state *mas,
 	mas_mat_destroy(mas, &subtrees);
 }
 
-/*
+/**
  * mas_wmb_replace() - Write memory barrier and replace
  * @mas: The maple state
- * @old: The old maple encoded node that is being replaced.
+ * @old_enode: The old maple encoded node that is being replaced.
  *
  * Updates gap as necessary.
  */
@@ -2651,7 +2649,7 @@ static inline void mas_wmb_replace(struct ma_state *mas,
 	mas_update_gap(mas);
 }
 
-/*
+/**
  * mast_cp_to_nodes() - Copy data out to nodes.
  * @mast: The maple subtree state
  * @left: The left encoded maple node
@@ -2691,7 +2689,7 @@ static inline void mast_cp_to_nodes(struct maple_subtree_state *mast,
 	}
 }
 
-/*
+/**
  * mast_combine_cp_left - Copy in the original left side of the tree into the
  * combined data set in the maple subtree state big node.
  * @mast: The maple subtree state
@@ -2706,7 +2704,7 @@ static inline void mast_combine_cp_left(struct maple_subtree_state *mast)
 	mas_mab_cp(mast->orig_l, 0, l_slot - 1, mast->bn, 0);
 }
 
-/*
+/**
  * mast_combine_cp_right: Copy in the original right side of the tree into the
  * combined data set in the maple subtree state big node.
  * @mast: The maple subtree state
@@ -2722,7 +2720,7 @@ static inline void mast_combine_cp_right(struct maple_subtree_state *mast)
 	mast->orig_r->last = mast->orig_r->max;
 }
 
-/*
+/**
  * mast_sufficient: Check if the maple subtree state has enough data in the big
  * node to create at least one sufficient node
  * @mast: the maple subtree state
@@ -2735,7 +2733,7 @@ static inline bool mast_sufficient(struct maple_subtree_state *mast)
 	return false;
 }
 
-/*
+/**
  * mast_overflow: Check if there is too much data in the subtree state for a
  * single node.
  * @mast: The maple subtree state
@@ -2808,7 +2806,7 @@ static inline void *mtree_range_walk(struct ma_state *mas)
 	return NULL;
 }
 
-/*
+/**
  * mas_spanning_rebalance() - Rebalance across two nodes which may not be peers.
  * @mas: The starting maple state
  * @mast: The maple_subtree_state, keeps track of 4 maple states.
@@ -2945,7 +2943,7 @@ static int mas_spanning_rebalance(struct ma_state *mas,
 	return mast->bn->b_end;
 }
 
-/*
+/**
  * mas_rebalance() - Rebalance a given node.
  * @mas: The maple state
  * @b_node: The big maple node.
@@ -3003,7 +3001,7 @@ static inline int mas_rebalance(struct ma_state *mas,
 	return mas_spanning_rebalance(mas, &mast, empty_count);
 }
 
-/*
+/**
  * mas_destroy_rebalance() - Rebalance left-most node while destroying the maple
  * state.
  * @mas: The maple state
@@ -3127,7 +3125,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	mas_update_gap(mas);
 }
 
-/*
+/**
  * mas_split_final_node() - Split the final node in a subtree operation.
  * @mast: the maple subtree state
  * @mas: The maple state
@@ -3159,7 +3157,7 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
 	mas->offset = mast->bn->b_end - 1;
 }
 
-/*
+/**
  * mast_fill_bnode() - Copy data into the big node in the subtree state
  * @mast: The maple subtree state
  * @mas: the maple state
@@ -3202,7 +3200,7 @@ static inline void mast_fill_bnode(struct maple_subtree_state *mast,
 	mast->bn->type = mte_node_type(mas->node);
 }
 
-/*
+/**
  * mast_split_data() - Split the data in the subtree state big node into regular
  * nodes.
  * @mast: The maple subtree state
@@ -3230,7 +3228,7 @@ static inline void mast_split_data(struct maple_subtree_state *mast,
 			     &p_slot, split);
 }
 
-/*
+/**
  * mas_push_data() - Instead of splitting a node, it is beneficial to push the
  * data to the right or left node if there is room.
  * @mas: The maple state
@@ -3304,7 +3302,7 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
 	return true;
 }
 
-/*
+/**
  * mas_split() - Split data that is too big for one node into two.
  * @mas: The maple state
  * @b_node: The maple big node
@@ -3395,7 +3393,7 @@ static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 	return 1;
 }
 
-/*
+/**
  * mas_reuse_node() - Reuse the node to store the data.
  * @wr_mas: The maple write state
  * @bn: The maple big node
@@ -3422,7 +3420,7 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
 	return true;
 }
 
-/*
+/**
  * mas_commit_b_node() - Commit the big node into the tree.
  * @wr_mas: The maple write state
  * @b_node: The maple big node
@@ -3463,7 +3461,7 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	return 1;
 }
 
-/*
+/**
  * mas_root_expand() - Expand a root to a node
  * @mas: The maple state
  * @entry: The entry to store into the tree
@@ -3523,13 +3521,10 @@ static inline void mas_store_root(struct ma_state *mas, void *entry)
 	}
 }
 
-/*
+/**
  * mas_is_span_wr() - Check if the write needs to be treated as a write that
  * spans the node.
- * @mas: The maple state
- * @piv: The pivot value being written
- * @type: The maple node type
- * @entry: The data to write
+ * @wr_mas: The maple write state
  *
  * Spanning writes are writes that start in one node and end in another OR if
  * the write of a %NULL will cause the node to end with a %NULL.
@@ -3581,7 +3576,8 @@ static inline void mas_wr_walk_traverse(struct ma_wr_state *wr_mas)
 	wr_mas->mas->offset = 0;
 	wr_mas->mas->depth++;
 }
-/*
+
+/**
  * mas_wr_walk() - Walk the tree for a write.
  * @wr_mas: The maple write state
  *
@@ -3624,7 +3620,8 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 	}
 	return true;
 }
-/*
+
+/**
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
  * @l_wr_mas: The left maple write state
  * @r_wr_mas: The right maple write state
@@ -3678,7 +3675,7 @@ static inline void *mas_state_walk(struct ma_state *mas)
 	return mtree_range_walk(mas);
 }
 
-/*
+/**
  * mtree_lookup_walk() - Internal quick lookup that does not keep maple state up
  * to date.
  *
@@ -3723,7 +3720,7 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 }
 
 static void mte_destroy_walk(struct maple_enode *, struct maple_tree *);
-/*
+/**
  * mas_new_root() - Create a new root node that only contains the entry passed
  * in.
  * @mas: The maple state
@@ -3771,7 +3768,8 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 
 	return 1;
 }
-/*
+
+/**
  * mas_wr_spanning_store() - Create a subtree with the store operation completed
  * and new nodes where necessary, then place the sub-tree in the actual tree.
  * Note that mas is expected to point to the node which caused the store to
@@ -3870,7 +3868,7 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	return mas_spanning_rebalance(mas, &mast, height + 1);
 }
 
-/*
+/**
  * mas_wr_node_store() - Attempt to store the value in a node
  * @wr_mas: The maple write state
  *
@@ -3963,7 +3961,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 	return true;
 }
 
-/*
+/**
  * mas_wr_slot_store: Attempt to store a value in a slot.
  * @wr_mas: the maple write state
  *
@@ -4081,7 +4079,7 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 	return new_end;
 }
 
-/*
+/**
  * mas_wr_append: Attempt to append
  * @wr_mas: the maple write state
  * @new_end: The end of the node after the modification
@@ -4142,7 +4140,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 	return  true;
 }
 
-/*
+/**
  * mas_wr_bnode() - Slow path for a modification.
  * @wr_mas: The write maple state
  *
@@ -4196,12 +4194,9 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	mas_wr_bnode(wr_mas);
 }
 
-/*
+/**
  * mas_wr_store_entry() - Internal call to store a value
- * @mas: The maple state
- * @entry: The entry to store.
- *
- * Return: The contents that was stored at the index.
+ * @wr_mas: The maple write state
  */
 static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
@@ -4354,7 +4349,7 @@ static __always_inline bool mas_rewalk_if_dead(struct ma_state *mas,
 	return false;
 }
 
-/*
+/**
  * mas_prev_node() - Find the prev non-null entry at the same level in the
  * tree.  The prev value will be mas->node[mas->offset] or the status will be
  * ma_none.
@@ -4436,13 +4431,12 @@ static int mas_prev_node(struct ma_state *mas, unsigned long min)
 	return 0;
 }
 
-/*
+/**
  * mas_prev_slot() - Get the entry in the previous slot
  *
  * @mas: The maple state
- * @max: The minimum starting range
+ * @min: The minimum starting range
  * @empty: Can be empty
- * @set_underflow: Set the @mas->node to underflow state on limit.
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
@@ -4522,9 +4516,10 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	return NULL;
 }
 
-/*
+/**
  * mas_next_node() - Get the next node at the same level in the tree.
  * @mas: The maple state
+ * @node: The maple node
  * @max: The maximum pivot value to check.
  *
  * The next value will be mas->node[mas->offset] or the status will have
@@ -4609,14 +4604,12 @@ static int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	return 0;
 }
 
-/*
+/**
  * mas_next_slot() - Get the entry in the next slot
  *
  * @mas: The maple state
  * @max: The maximum starting range
  * @empty: Can be empty
- * @set_overflow: Should @mas->node be set to overflow when the limit is
- * reached.
  *
  * Return: The entry in the next slot which is possibly NULL
  */
@@ -4704,7 +4697,7 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 	return entry;
 }
 
-/*
+/**
  * mas_next_entry() - Internal function to get the next entry.
  * @mas: The maple state
  * @limit: The maximum range start.
@@ -4727,7 +4720,7 @@ static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 	return mas_next_slot(mas, limit, false);
 }
 
-/*
+/**
  * mas_rev_awalk() - Internal function.  Reverse allocation walk.  Find the
  * highest gap address of a given size in a given node and descend.
  * @mas: The maple state
@@ -4944,7 +4937,7 @@ static inline bool mas_rewind_node(struct ma_state *mas)
 	return true;
 }
 
-/*
+/**
  * mas_skip_node() - Internal function.  Skip over a node.
  * @mas: The maple state.
  *
@@ -4970,7 +4963,7 @@ static inline bool mas_skip_node(struct ma_state *mas)
 	return true;
 }
 
-/*
+/**
  * mas_awalk() - Allocation walk.  Search from low address to high, for a gap of
  * @size
  * @mas: The maple state
@@ -4997,7 +4990,7 @@ static inline void mas_awalk(struct ma_state *mas, unsigned long size)
 	}
 }
 
-/*
+/**
  * mas_sparse_area() - Internal function.  Return upper or lower limit when
  * searching for a gap in an empty tree.
  * @mas: The maple state
@@ -5030,7 +5023,7 @@ static inline int mas_sparse_area(struct ma_state *mas, unsigned long min,
 	return 0;
 }
 
-/*
+/**
  * mas_empty_area() - Get the lowest address within the range that is
  * sufficient for the size requested.
  * @mas: The maple state
@@ -5087,7 +5080,7 @@ int mas_empty_area(struct ma_state *mas, unsigned long min,
 }
 EXPORT_SYMBOL_GPL(mas_empty_area);
 
-/*
+/**
  * mas_empty_area_rev() - Get the highest address within the range that is
  * sufficient for the size requested.
  * @mas: The maple state
@@ -5148,11 +5141,11 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 }
 EXPORT_SYMBOL_GPL(mas_empty_area_rev);
 
-/*
+/**
  * mte_dead_leaves() - Mark all leaves of a node as dead.
- * @mas: The maple state
+ * @enode: the encoded node
+ * @mt: the maple tree
  * @slots: Pointer to the slot array
- * @type: The maple node type
  *
  * Must hold the write lock.
  *
@@ -5339,7 +5332,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 		mt_clear_meta(mt, node, node->type);
 }
 
-/*
+/**
  * mte_destroy_walk() - Free a tree or sub-tree.
  * @enode: the encoded maple node (maple_enode) to start
  * @mt: the tree to free - needed for node types.
@@ -5564,7 +5557,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(mas_preallocate);
 
-/*
+/**
  * mas_destroy() - destroy a maple state.
  * @mas: The maple state
  *
@@ -5614,7 +5607,7 @@ void mas_destroy(struct ma_state *mas)
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
-/*
+/**
  * mas_expected_entries() - Set the expected number of entries that will be inserted.
  * @mas: The maple state
  * @nr_entries: The number of expected entries.
@@ -6594,7 +6587,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 }
 EXPORT_SYMBOL(mtree_erase);
 
-/*
+/**
  * mas_dup_free() - Free an incomplete duplication of a tree.
  * @mas: The maple state of a incomplete tree.
  *
@@ -6639,7 +6632,7 @@ static void mas_dup_free(struct ma_state *mas)
 	mt_free_one(node);
 }
 
-/*
+/**
  * mas_copy_node() - Copy a maple node and replace the parent.
  * @mas: The maple state of source tree.
  * @new_mas: The maple state of new tree.
@@ -6662,7 +6655,7 @@ static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
 	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
 }
 
-/*
+/**
  * mas_dup_alloc() - Allocate child nodes for a maple node.
  * @mas: The maple state of source tree.
  * @new_mas: The maple state of new tree.
@@ -6702,7 +6695,7 @@ static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
 	}
 }
 
-/*
+/**
  * mas_dup_build() - Build a new maple tree from a source tree
  * @mas: The maple state of source tree, need to be in MAS_START state.
  * @new_mas: The maple state of new tree, need to be in MAS_START state.
@@ -7025,7 +7018,7 @@ void mt_cache_shrink(void)
 {
 }
 #else
-/*
+/**
  * mt_cache_shrink() - For testing, don't use this.
  *
  * Certain testcases can trigger an OOM when combined with other memory
@@ -7041,7 +7034,7 @@ void mt_cache_shrink(void)
 EXPORT_SYMBOL_GPL(mt_cache_shrink);
 
 #endif /* not defined __KERNEL__ */
-/*
+/**
  * mas_get_slot() - Get the entry in the maple state node stored at @offset.
  * @mas: The maple state
  * @offset: The offset into the slot array to fetch.
-- 
2.34.1



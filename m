Return-Path: <linux-kernel+bounces-292565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428E6957155
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76531F2300A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DCE187871;
	Mon, 19 Aug 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TSX+Bcvx"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093732C8B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086799; cv=none; b=VVdtZ1CrnDfpeaYFmbbXXn0zvl1QHFt7LngDRxo8oSvE9+uHC4d5kZdhLfSLkV9ndOoDSWHzqda6F9fG7gJt2TB3N42kgZhmWsaIwPFz6DQoDZRhVWO8SBXjGE5Vn8STNpET/8EPRRs0HAlqZJc0cYX1bl4AloP1tOmU+JikyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086799; c=relaxed/simple;
	bh=n731cSIpPTzFTMyno3qp4hLjr7DK+/a6BT0mOcXArEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ81/Vc7UBzc2j0AtdHqUbzCWvzko5ROVqN4uiqIBmZxBc8kRHWgevJuyz0BvoDdQszAsmH+DA4pGPWK4cWmVazCxe8C9x2zgji8EoT7ZzhWMmUCSO/RqLN+cGkLVeM4tesFQtq0srTvJjyBcuDoeXF4Du/UyxlkEnDwqYvFwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TSX+Bcvx; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNCCaVjvUekOAkBm/WVRQhN2Hqdw6JK2X7nthvgVO5w=;
	b=TSX+BcvxSfjF7ameFNczV3W/kJO7D2GP4GMce0XhrQwJegLlu8srX/JlWjC/kSttRHbWLl
	whh+XuSnsmpdeXSoaSJfDVtLi1j1Uh5iCJSsZHrdoLv6A8tNhItYn5In1+0e3IcyC9TsSm
	ZSruQ2Jre3KW3YF6+8UWhSqzBUhJQYM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] lib/generic-radix-tree.c: genradix_ptr_inlined()
Date: Mon, 19 Aug 2024 12:59:27 -0400
Message-ID: <20240819165939.745801-2-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Provide an inlined fast path

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h | 75 ++++++++++++++++++++++++++++++
 lib/generic-radix-tree.c           | 64 +------------------------
 2 files changed, 76 insertions(+), 63 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index f3512fddf3d7..8a3e1e886d1c 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -48,6 +48,49 @@ struct genradix_root;
 #define GENRADIX_NODE_SHIFT	9
 #define GENRADIX_NODE_SIZE	(1U << GENRADIX_NODE_SHIFT)
 
+#define GENRADIX_ARY		(GENRADIX_NODE_SIZE / sizeof(struct genradix_node *))
+#define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
+
+/* depth that's needed for a genradix that can address up to ULONG_MAX: */
+#define GENRADIX_MAX_DEPTH	\
+	DIV_ROUND_UP(BITS_PER_LONG - GENRADIX_NODE_SHIFT, GENRADIX_ARY_SHIFT)
+
+#define GENRADIX_DEPTH_MASK				\
+	((unsigned long) (roundup_pow_of_two(GENRADIX_MAX_DEPTH + 1) - 1))
+
+static inline int genradix_depth_shift(unsigned depth)
+{
+	return GENRADIX_NODE_SHIFT + GENRADIX_ARY_SHIFT * depth;
+}
+
+/*
+ * Returns size (of data, in bytes) that a tree of a given depth holds:
+ */
+static inline size_t genradix_depth_size(unsigned depth)
+{
+	return 1UL << genradix_depth_shift(depth);
+}
+
+static inline unsigned genradix_root_to_depth(struct genradix_root *r)
+{
+	return (unsigned long) r & GENRADIX_DEPTH_MASK;
+}
+
+static inline struct genradix_node *genradix_root_to_node(struct genradix_root *r)
+{
+	return (void *) ((unsigned long) r & ~GENRADIX_DEPTH_MASK);
+}
+
+struct genradix_node {
+	union {
+		/* Interior node: */
+		struct genradix_node	*children[GENRADIX_ARY];
+
+		/* Leaf: */
+		u8			data[GENRADIX_NODE_SIZE];
+	};
+};
+
 struct __genradix {
 	struct genradix_root		*root;
 };
@@ -128,6 +171,30 @@ static inline size_t __idx_to_offset(size_t idx, size_t obj_size)
 #define __genradix_idx_to_offset(_radix, _idx)			\
 	__idx_to_offset(_idx, __genradix_obj_size(_radix))
 
+static inline void *__genradix_ptr_inlined(struct __genradix *radix, size_t offset)
+{
+	struct genradix_root *r = READ_ONCE(radix->root);
+	struct genradix_node *n = genradix_root_to_node(r);
+	unsigned level		= genradix_root_to_depth(r);
+	unsigned shift		= genradix_depth_shift(level);
+
+	if (unlikely(ilog2(offset) >= genradix_depth_shift(level)))
+		return NULL;
+
+	while (n && shift > GENRADIX_NODE_SHIFT) {
+		shift -= GENRADIX_ARY_SHIFT;
+		n = n->children[offset >> shift];
+		offset &= (1UL << shift) - 1;
+	}
+
+	return n ? &n->data[offset] : NULL;
+}
+
+#define genradix_ptr_inlined(_radix, _idx)			\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr_inlined(&(_radix)->tree,		\
+			__genradix_idx_to_offset(_radix, _idx)))
+
 void *__genradix_ptr(struct __genradix *, size_t);
 
 /**
@@ -144,6 +211,14 @@ void *__genradix_ptr(struct __genradix *, size_t);
 
 void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
 
+#define genradix_ptr_alloc_inlined(_radix, _idx, _gfp)			\
+	(__genradix_cast(_radix)					\
+	 (__genradix_ptr_inlined(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx)) ?:	\
+	  __genradix_ptr_alloc(&(_radix)->tree,				\
+			__genradix_idx_to_offset(_radix, _idx),		\
+			_gfp)))
+
 /**
  * genradix_ptr_alloc - get a pointer to a genradix entry, allocating it
  *			if necessary
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index fa692c86f069..4efae0663049 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -5,75 +5,13 @@
 #include <linux/gfp.h>
 #include <linux/kmemleak.h>
 
-#define GENRADIX_ARY		(GENRADIX_NODE_SIZE / sizeof(struct genradix_node *))
-#define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
-
-struct genradix_node {
-	union {
-		/* Interior node: */
-		struct genradix_node	*children[GENRADIX_ARY];
-
-		/* Leaf: */
-		u8			data[GENRADIX_NODE_SIZE];
-	};
-};
-
-static inline int genradix_depth_shift(unsigned depth)
-{
-	return GENRADIX_NODE_SHIFT + GENRADIX_ARY_SHIFT * depth;
-}
-
-/*
- * Returns size (of data, in bytes) that a tree of a given depth holds:
- */
-static inline size_t genradix_depth_size(unsigned depth)
-{
-	return 1UL << genradix_depth_shift(depth);
-}
-
-/* depth that's needed for a genradix that can address up to ULONG_MAX: */
-#define GENRADIX_MAX_DEPTH	\
-	DIV_ROUND_UP(BITS_PER_LONG - GENRADIX_NODE_SHIFT, GENRADIX_ARY_SHIFT)
-
-#define GENRADIX_DEPTH_MASK				\
-	((unsigned long) (roundup_pow_of_two(GENRADIX_MAX_DEPTH + 1) - 1))
-
-static inline unsigned genradix_root_to_depth(struct genradix_root *r)
-{
-	return (unsigned long) r & GENRADIX_DEPTH_MASK;
-}
-
-static inline struct genradix_node *genradix_root_to_node(struct genradix_root *r)
-{
-	return (void *) ((unsigned long) r & ~GENRADIX_DEPTH_MASK);
-}
-
 /*
  * Returns pointer to the specified byte @offset within @radix, or NULL if not
  * allocated
  */
 void *__genradix_ptr(struct __genradix *radix, size_t offset)
 {
-	struct genradix_root *r = READ_ONCE(radix->root);
-	struct genradix_node *n = genradix_root_to_node(r);
-	unsigned level		= genradix_root_to_depth(r);
-
-	if (ilog2(offset) >= genradix_depth_shift(level))
-		return NULL;
-
-	while (1) {
-		if (!n)
-			return NULL;
-		if (!level)
-			break;
-
-		level--;
-
-		n = n->children[offset >> genradix_depth_shift(level)];
-		offset &= genradix_depth_size(level) - 1;
-	}
-
-	return &n->data[offset];
+	return __genradix_ptr_inlined(radix, offset);
 }
 EXPORT_SYMBOL(__genradix_ptr);
 
-- 
2.45.2



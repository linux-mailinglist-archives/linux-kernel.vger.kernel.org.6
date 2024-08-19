Return-Path: <linux-kernel+bounces-292563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A69957169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047B5B26DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81CA178399;
	Mon, 19 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v4n92dJc"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568D17837D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086796; cv=none; b=k44jWjzIeBQmzxRxJyDjSlBwn33gWSQrU802pqdRfaOY9m/HykP9p0TkoH5tbnU7zTtjdeNfgEWmw48/iRGlqk+IVUWSMHdd0R+YIGAGSsbf0Y9UgDXiMdZiB2F+gQp6UMc9uJ2uSlk7HSsesDf00MbSYteh33w7L2mGmGYYn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086796; c=relaxed/simple;
	bh=Q2Ap5z/7A7txTEKvvHdCh6MsQonmDtIL+y52IshIp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEVyVTVopyKKGAJuCtKbjZGBP3zu9TLmzQotzw+MNVsljwueAKnHjruUzp1OCcCsM8ex4l267X0+PMoL5KaBj7JNxrift6uatR88bkPHFymGZnGQyfrCzC0+JMhVFM+Wxm/p+AOLapnyj2VfHzUw/qYcL/pTGTtDjEi4HhlD4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v4n92dJc; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y8BJGFrfNUpQt3vcVW5ZgcFN87o+Iw49kVkMeQe7aA=;
	b=v4n92dJcj99TWULTM0T7QRl+8Rda+RvzlJAPzkF7yr/xrHFbDdJss9iZOBRJIXR2Q+Shoe
	6DUB30bOVfqZOLHbDCgPpr4T1/hlOOL2xHzAB+MQk7UqTPDJHkWh9pC6hTPZxzDUQwu3tN
	1+vg/PIBKbeZ6LmFWSv5yr7qVTKPkF0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] lib/generic-radix-tree.c: add preallocation
Date: Mon, 19 Aug 2024 12:59:28 -0400
Message-ID: <20240819165939.745801-3-kent.overstreet@linux.dev>
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

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/generic-radix-tree.h | 39 +++++++++++++++++++++++++-----
 lib/generic-radix-tree.c           | 16 ++++--------
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/include/linux/generic-radix-tree.h b/include/linux/generic-radix-tree.h
index 8a3e1e886d1c..340bba5c9735 100644
--- a/include/linux/generic-radix-tree.h
+++ b/include/linux/generic-radix-tree.h
@@ -41,6 +41,7 @@
 #include <linux/limits.h>
 #include <linux/log2.h>
 #include <linux/math.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 struct genradix_root;
@@ -81,6 +82,11 @@ static inline struct genradix_node *genradix_root_to_node(struct genradix_root *
 	return (void *) ((unsigned long) r & ~GENRADIX_DEPTH_MASK);
 }
 
+struct __genradix {
+	struct genradix_root		*root;
+	rwlock_t			free_lock;
+};
+
 struct genradix_node {
 	union {
 		/* Interior node: */
@@ -91,9 +97,15 @@ struct genradix_node {
 	};
 };
 
-struct __genradix {
-	struct genradix_root		*root;
-};
+static inline struct genradix_node *genradix_alloc_node(gfp_t gfp_mask)
+{
+	return kzalloc(GENRADIX_NODE_SIZE, gfp_mask);
+}
+
+static inline void genradix_free_node(struct genradix_node *node)
+{
+	kfree(node);
+}
 
 /*
  * NOTE: currently, sizeof(_type) must not be larger than GENRADIX_NODE_SIZE:
@@ -209,7 +221,8 @@ void *__genradix_ptr(struct __genradix *, size_t);
 	 __genradix_ptr(&(_radix)->tree,			\
 			__genradix_idx_to_offset(_radix, _idx)))
 
-void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
+void *__genradix_ptr_alloc(struct __genradix *, size_t,
+			   struct genradix_node **, gfp_t);
 
 #define genradix_ptr_alloc_inlined(_radix, _idx, _gfp)			\
 	(__genradix_cast(_radix)					\
@@ -217,7 +230,15 @@ void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
 			__genradix_idx_to_offset(_radix, _idx)) ?:	\
 	  __genradix_ptr_alloc(&(_radix)->tree,				\
 			__genradix_idx_to_offset(_radix, _idx),		\
-			_gfp)))
+			NULL, _gfp)))
+
+#define genradix_ptr_alloc_preallocated_inlined(_radix, _idx, _new_node, _gfp)\
+	(__genradix_cast(_radix)					\
+	 (__genradix_ptr_inlined(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx)) ?:	\
+	  __genradix_ptr_alloc(&(_radix)->tree,				\
+			__genradix_idx_to_offset(_radix, _idx),		\
+			_new_node, _gfp)))
 
 /**
  * genradix_ptr_alloc - get a pointer to a genradix entry, allocating it
@@ -232,7 +253,13 @@ void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
 	(__genradix_cast(_radix)				\
 	 __genradix_ptr_alloc(&(_radix)->tree,			\
 			__genradix_idx_to_offset(_radix, _idx),	\
-			_gfp))
+			NULL, _gfp))
+
+#define genradix_ptr_alloc_preallocated(_radix, _idx, _new_node, _gfp)\
+	(__genradix_cast(_radix)				\
+	 __genradix_ptr_alloc(&(_radix)->tree,			\
+			__genradix_idx_to_offset(_radix, _idx),	\
+			_new_node, _gfp))
 
 struct genradix_iter {
 	size_t			offset;
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 4efae0663049..79e067b51488 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -15,27 +15,21 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 }
 EXPORT_SYMBOL(__genradix_ptr);
 
-static inline struct genradix_node *genradix_alloc_node(gfp_t gfp_mask)
-{
-	return kzalloc(GENRADIX_NODE_SIZE, gfp_mask);
-}
-
-static inline void genradix_free_node(struct genradix_node *node)
-{
-	kfree(node);
-}
-
 /*
  * Returns pointer to the specified byte @offset within @radix, allocating it if
  * necessary - newly allocated slots are always zeroed out:
  */
 void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
+			   struct genradix_node **preallocated,
 			   gfp_t gfp_mask)
 {
 	struct genradix_root *v = READ_ONCE(radix->root);
 	struct genradix_node *n, *new_node = NULL;
 	unsigned level;
 
+	if (preallocated)
+		swap(new_node, *preallocated);
+
 	/* Increase tree depth if necessary: */
 	while (1) {
 		struct genradix_root *r = v, *new_root;
@@ -219,7 +213,7 @@ int __genradix_prealloc(struct __genradix *radix, size_t size,
 	size_t offset;
 
 	for (offset = 0; offset < size; offset += GENRADIX_NODE_SIZE)
-		if (!__genradix_ptr_alloc(radix, offset, gfp_mask))
+		if (!__genradix_ptr_alloc(radix, offset, NULL, gfp_mask))
 			return -ENOMEM;
 
 	return 0;
-- 
2.45.2



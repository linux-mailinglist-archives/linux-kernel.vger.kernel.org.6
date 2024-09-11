Return-Path: <linux-kernel+bounces-324280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0F974A91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07074B2190B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FE13A3F9;
	Wed, 11 Sep 2024 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbAem6My"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5367DA6E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037176; cv=none; b=uh8lOmS/O60zis+0Dq3jVF1dT5FOZR1rI7vtIkeMzt9NNBIfjJQkqroMmZQU5ArkQKROCNWSfgDASeoLr7KL1U+z6HAE/MF5J4DyqFag+6Cw5Ahdhhg4wM48YHpgFaedHjLScLFq6RwiPNrwffL6D92yxLAYHaA6b8/uWSPoEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037176; c=relaxed/simple;
	bh=Ag0o94U2BMb2lFyFC32W4EFoRg3K+ZMunlGHmbIXB5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SwZ7NcQ4seFnUSM6h3AfVCHiusDcjHRQQVp+WQOaRhh7RIZxarFBVX8T+0kZYrjxlXm+L34/xDAkZ9g1WwQrgHPQwTo4Pw5u/qqX+UJ55RohmdgO/mtE54QR4FeIhh9LmTwA0zcUXx+C2WQtcICkHo9anVovq+GvjCfTFwtU/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbAem6My; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037174; x=1757573174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ag0o94U2BMb2lFyFC32W4EFoRg3K+ZMunlGHmbIXB5s=;
  b=nbAem6My0wwQaVqgOTOiWV+7dRfqZdcDA7oTXxXWe3FoJlOLv0+vE327
   1qOqV/r09hPHvtYICZ8abmYQ1qgVeAUPU1SGijz3WJhaLVpmoY2HpRahQ
   GP7D2JApE3GkRS4Bsygldhuhu6DXKNS68sfmIGL9g1jJfQrIDa6JGhrzM
   kaY57//H16zLU7yFCz9Urcab4X1X766bnwgi6yZbYrqR85p6YYkzJ6yzk
   UQvZ/rSpfPo1Y8UFCB8FLvM4VoEHtY+PtmniaZgnd7O4RIxmbwPi/37Jn
   Riw10TMON/e8CQgBHCiLm56JW0bJKKlGTBcyYFZLKnVMtsMMJdsCYBahl
   w==;
X-CSE-ConnectionGUID: vj2vtykyQu+ow8+jrdJqLA==
X-CSE-MsgGUID: CNgdb46XS2KUmO2l3xIzug==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36173015"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36173015"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:46:11 -0700
X-CSE-ConnectionGUID: IgyzjmIvSCmBHDIIIAmEIw==
X-CSE-MsgGUID: u/rfH00VRWC+1lv/88CKcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771497"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:45:55 -0700
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2 3/5] mm/slub: Move krealloc() and related code to slub.c
Date: Wed, 11 Sep 2024 14:45:33 +0800
Message-Id: <20240911064535.557650-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911064535.557650-1-feng.tang@intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparation for the following refactoring of krealloc(),
for more efficient function calling as it will call some internal
functions defined in slub.c.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab_common.c | 84 ------------------------------------------------
 mm/slub.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index af6b14769fbd..5734b61a106f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1185,90 +1185,6 @@ module_init(slab_proc_init);
 
 #endif /* CONFIG_SLUB_DEBUG */
 
-static __always_inline __realloc_size(2) void *
-__do_krealloc(const void *p, size_t new_size, gfp_t flags)
-{
-	void *ret;
-	size_t ks;
-
-	/* Check for double-free before calling ksize. */
-	if (likely(!ZERO_OR_NULL_PTR(p))) {
-		if (!kasan_check_byte(p))
-			return NULL;
-		ks = ksize(p);
-	} else
-		ks = 0;
-
-	/* If the object still fits, repoison it precisely. */
-	if (ks >= new_size) {
-		/* Zero out spare memory. */
-		if (want_init_on_alloc(flags)) {
-			kasan_disable_current();
-			memset((void *)p + new_size, 0, ks - new_size);
-			kasan_enable_current();
-		}
-
-		p = kasan_krealloc((void *)p, new_size, flags);
-		return (void *)p;
-	}
-
-	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
-	if (ret && p) {
-		/* Disable KASAN checks as the object's redzone is accessed. */
-		kasan_disable_current();
-		memcpy(ret, kasan_reset_tag(p), ks);
-		kasan_enable_current();
-	}
-
-	return ret;
-}
-
-/**
- * krealloc - reallocate memory. The contents will remain unchanged.
- * @p: object to reallocate memory for.
- * @new_size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- *
- * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
- * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
- *
- * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
- * initial memory allocation, every subsequent call to this API for the same
- * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
- * __GFP_ZERO is not fully honored by this API.
- *
- * This is the case, since krealloc() only knows about the bucket size of an
- * allocation (but not the exact size it was allocated with) and hence
- * implements the following semantics for shrinking and growing buffers with
- * __GFP_ZERO.
- *
- *         new             bucket
- * 0       size             size
- * |--------|----------------|
- * |  keep  |      zero      |
- *
- * In any case, the contents of the object pointed to are preserved up to the
- * lesser of the new and old sizes.
- *
- * Return: pointer to the allocated memory or %NULL in case of error
- */
-void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
-{
-	void *ret;
-
-	if (unlikely(!new_size)) {
-		kfree(p);
-		return ZERO_SIZE_PTR;
-	}
-
-	ret = __do_krealloc(p, new_size, flags);
-	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
-		kfree(p);
-
-	return ret;
-}
-EXPORT_SYMBOL(krealloc_noprof);
-
 /**
  * kfree_sensitive - Clear sensitive information in memory before freeing
  * @p: object to free memory of
diff --git a/mm/slub.c b/mm/slub.c
index 021991e17287..c1796f9dd30f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4712,6 +4712,90 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
+static __always_inline __realloc_size(2) void *
+__do_krealloc(const void *p, size_t new_size, gfp_t flags)
+{
+	void *ret;
+	size_t ks;
+
+	/* Check for double-free before calling ksize. */
+	if (likely(!ZERO_OR_NULL_PTR(p))) {
+		if (!kasan_check_byte(p))
+			return NULL;
+		ks = ksize(p);
+	} else
+		ks = 0;
+
+	/* If the object still fits, repoison it precisely. */
+	if (ks >= new_size) {
+		/* Zero out spare memory. */
+		if (want_init_on_alloc(flags)) {
+			kasan_disable_current();
+			memset((void *)p + new_size, 0, ks - new_size);
+			kasan_enable_current();
+		}
+
+		p = kasan_krealloc((void *)p, new_size, flags);
+		return (void *)p;
+	}
+
+	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
+	if (ret && p) {
+		/* Disable KASAN checks as the object's redzone is accessed. */
+		kasan_disable_current();
+		memcpy(ret, kasan_reset_tag(p), ks);
+		kasan_enable_current();
+	}
+
+	return ret;
+}
+
+/**
+ * krealloc - reallocate memory. The contents will remain unchanged.
+ * @p: object to reallocate memory for.
+ * @new_size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ *
+ * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
+ * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
+ *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * This is the case, since krealloc() only knows about the bucket size of an
+ * allocation (but not the exact size it was allocated with) and hence
+ * implements the following semantics for shrinking and growing buffers with
+ * __GFP_ZERO.
+ *
+ *         new             bucket
+ * 0       size             size
+ * |--------|----------------|
+ * |  keep  |      zero      |
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
+ * Return: pointer to the allocated memory or %NULL in case of error
+ */
+void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
+{
+	void *ret;
+
+	if (unlikely(!new_size)) {
+		kfree(p);
+		return ZERO_SIZE_PTR;
+	}
+
+	ret = __do_krealloc(p, new_size, flags);
+	if (ret && kasan_reset_tag(p) != kasan_reset_tag(ret))
+		kfree(p);
+
+	return ret;
+}
+EXPORT_SYMBOL(krealloc_noprof);
+
 struct detached_freelist {
 	struct slab *slab;
 	void *tail;
-- 
2.34.1



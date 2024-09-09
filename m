Return-Path: <linux-kernel+bounces-320491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24173970B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3738281F11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B012E4A;
	Mon,  9 Sep 2024 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UO0zbAn1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6401BC46
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845417; cv=none; b=LGSTvyCC5uqsU9NcTHpD3TKXwjmO2VzqN9gdOMTdKfg4+tDDV5rW+rM6UOvPiHT2u74dTfwmHQqlBa9JiMPlnqzPtJqpJ7A7TcgQRFBiqewGBrCrJZCCC2kBo5uGLKOnvMpPPKtMy74vGieiJjY4NeYQ9Gqcg8FLoCXiby3nEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845417; c=relaxed/simple;
	bh=B8mgHFZzGD1KfDB0WGMvxSgxbcgttavsuRFve7SsS4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0/PdccIaiUjFZABfBRQ8aaFeSDtynuCIn1ngJfZ0YoSUIYmkH+i5AuxbfRiv27hghCAKcCJvPsFBx4NNqCRUVflv0xQZKhRqyHkZBlmqkMlxX7gCsVvHz7Qyqqo196P92+/AdZ2vMFks3CpGw/nnnz6yw4rr19R9LCw55KOfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UO0zbAn1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845416; x=1757381416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B8mgHFZzGD1KfDB0WGMvxSgxbcgttavsuRFve7SsS4M=;
  b=UO0zbAn1j7vuzTnpmStJmkvfnOxNJ9Op+nqvh7P0xugVc96RZGWWASwb
   z/gE5KNpIX17z6sneuDNeuA3JaBXKEQIgzo7l8xqkQUFH4b/3mVC3dNkV
   OdJ5tM0lu7R912jZUzxPKYiiCB+6PQjPBSpJIsFeTDt5jzctY2JuSj9x5
   Sda12nZMHLEHb0srYy2neudfWm2JQgmCOLuG/XRugpIIUJ7ZvdV0Oiaqp
   S+wza6LXdpf+iZ/2XOKkTzcetf1LbtoowfwjCIjCkA2mYR++ZOy0RfM2k
   hGc5mnrWQm2iuJqGNyLznY592COpxz8ONuNCH80Wmm8bIUKD7SPp6X9EA
   g==;
X-CSE-ConnectionGUID: RTSnSDEjRSuRD8YvWcjSEA==
X-CSE-MsgGUID: 18M8fqxXSZOpgnsjXniTzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258128"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258128"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:16 -0700
X-CSE-ConnectionGUID: cx70BTLlS3CxDDTgPHNKyA==
X-CSE-MsgGUID: E/DBYOyRSA6Yo9pun0F7fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486467"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:30:11 -0700
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
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH 3/5] mm/slub: Improve redzone check and zeroing for krealloc()
Date: Mon,  9 Sep 2024 09:29:56 +0800
Message-Id: <20240909012958.913438-4-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909012958.913438-1-feng.tang@intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For current krealloc(), one problem is its caller doesn't know what's
the actual request size, say the object is 64 bytes kmalloc one, but
the original caller may only requested 48 bytes. And when krealloc()
shrinks or grows in the same object, or allocate a new bigger object,
it lacks this 'original size' information to do accurate data preserving
or zeroing (when __GFP_ZERO is set).

And when some slub debug option is enabled, kmalloc caches do have this
'orig_size' feature. So utilize it to do more accurate data handling,
as well as enforce the kmalloc-redzone sanity check.

The krealloc() related code is moved from slab_common.c to slub.c for
more efficient function calling.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab_common.c |  84 -------------------------------------
 mm/slub.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 84 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ad438ba62485..e59942fb7970 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1297,90 +1297,6 @@ module_init(slab_proc_init);
 
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
index 4cb3822dba08..d4c938dfb89e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4709,6 +4709,112 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
+static __always_inline __realloc_size(2) void *
+__do_krealloc(const void *p, size_t new_size, gfp_t flags)
+{
+	void *ret;
+	size_t ks;
+	int orig_size = 0;
+	struct kmem_cache *s;
+
+	/* Check for double-free before calling ksize. */
+	if (likely(!ZERO_OR_NULL_PTR(p))) {
+		if (!kasan_check_byte(p))
+			return NULL;
+
+		s = virt_to_cache(p);
+		orig_size = get_orig_size(s, (void *)p);
+		ks = s->object_size;
+	} else
+		ks = 0;
+
+	/* If the object doesn't fit, allocate a bigger one */
+	if (new_size > ks)
+		goto alloc_new;
+
+	/* Zero out spare memory. */
+	if (want_init_on_alloc(flags)) {
+		kasan_disable_current();
+		if (orig_size < new_size)
+			memset((void *)p + orig_size, 0, new_size - orig_size);
+		else
+			memset((void *)p + new_size, 0, ks - new_size);
+		kasan_enable_current();
+	}
+
+	if (slub_debug_orig_size(s) && !is_kfence_address(p)) {
+		set_orig_size(s, (void *)p, new_size);
+		if (s->flags & SLAB_RED_ZONE && new_size < ks)
+			memset_no_sanitize_memory((void *)p + new_size,
+						SLUB_RED_ACTIVE, ks - new_size);
+	}
+
+	p = kasan_krealloc((void *)p, new_size, flags);
+	return (void *)p;
+
+alloc_new:
+	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
+	if (ret && p) {
+		/* Disable KASAN checks as the object's redzone is accessed. */
+		kasan_disable_current();
+		if (orig_size)
+			memcpy(ret, kasan_reset_tag(p), orig_size);
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
+ * When slub_debug_orig_size() is off,  since krealloc() only knows about the
+ * bucket size of an allocation (but not the exact size it was allocated with)
+ * and hence implements the following semantics for shrinking and growing
+ * buffers with __GFP_ZERO.
+ *
+ *         new             bucket
+ * 0       size             size
+ * |--------|----------------|
+ * |  keep  |      zero      |
+ *
+ * Otherwize, the original allocation size 'orig_size' could be used to
+ * precisely clear the requested size, and the new size will also be stored as
+ * the new 'orig_size'.
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



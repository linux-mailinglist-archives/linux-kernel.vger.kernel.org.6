Return-Path: <linux-kernel+bounces-368346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF99A0EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59758B217A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559F20F5CF;
	Wed, 16 Oct 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BX2zxsB9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3E20E011
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093327; cv=none; b=kSMf0LeEzd+zm3dzw8DQdfROXlGV0Gu76qLB92JVzpztLExA8tOmyS+lT/uP/a84qZfATOfGM/38KaAQAZ13wyuJrwTv6tyqgdkBN2k6dXvELvbD8y54ddXeFc1+mPlzl9yS9NGZfb8JL1P3ZUQOwX+LUHdMBuZJyoScMJajNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093327; c=relaxed/simple;
	bh=SfN+aazMvPNd5suMLtjlSQgXeOWhjVA+dg6w5Bfb7iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HFMPd3Hl5ASiI5BeKl1gkqW9yS3tBqzx6cvRGQ309d56YjWKDVYVreKhXk553GEnz6ATwxGy6zzeAfS4zs5I+EhOgnOqg6pFJOagnL/PiuSVywrnJZEB/dFIWgO46k0DBS0MhNPgN43mOE+PDXH7FqMma395HxhnOOg9tmQKE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BX2zxsB9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729093326; x=1760629326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SfN+aazMvPNd5suMLtjlSQgXeOWhjVA+dg6w5Bfb7iQ=;
  b=BX2zxsB9MSVHq4CM11S6Xn5XfbvJ48Dmna2VH/NUd/SsLlVy7buX5YpK
   0+V3qyRj3mQW+oQ9vMPp8WM0wwiVetOMimJWycWDo4qI2xVLbxUzHEpYX
   Tn0W32witbu1IqZQ1vwgdqmtDKG2zl0H0PnvkXzA6IMG4ntC5zyZfHbg7
   FjcVJWOm0gQX0WevQ5VXbGWjbBXKxetFwBoOvJyd+djyWhmvUfTIORYWp
   ycI9yNNrDhQJCyOng7MzhLmRL/5wCJ+cd1/yFcjJxyTgaXZGqpFK87oX8
   D5cSJimYPqcN7ri04/lFjr1Ts7BguFaamtYRo3NF474cjk9PYoroiyBW6
   A==;
X-CSE-ConnectionGUID: cA6VbkHNQp6C7MJFjo+SYw==
X-CSE-MsgGUID: ayKFWplPQOOQmNDEkokI4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46021362"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46021362"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 08:42:05 -0700
X-CSE-ConnectionGUID: UUGX2kglTD2IGECAAw+E6g==
X-CSE-MsgGUID: 51KYtXJaTQ6dVWcB49DHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="109018920"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 08:42:01 -0700
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
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Narasimhan.V@amd.com
Cc: linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 2/3] mm/slub: Improve redzone check and zeroing for krealloc()
Date: Wed, 16 Oct 2024 23:41:51 +0800
Message-Id: <20241016154152.1376492-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016154152.1376492-1-feng.tang@intel.com>
References: <20241016154152.1376492-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For current krealloc(), one problem is its caller doesn't pass the old
request size, say the object is 64 bytes kmalloc one, but caller may
only requested 48 bytes. Then when krealloc() shrinks or grows in the
same object, or allocate a new bigger object, it lacks this 'original
size' information to do accurate data preserving or zeroing (when
__GFP_ZERO is set).

Thus with slub debug redzone and object tracking enabled, parts of the
object after krealloc() might contain redzone data instead of zeroes,
which is violating the __GFP_ZERO guarantees. Good thing is in this
case, kmalloc caches do have this 'orig_size' feature. So solve the
problem by utilize 'org_size' to do accurate data zeroing and preserving.

[Thanks to syzbot and V, Narasimhan for discovering kfence and big
 kmalloc related issues in early patch version]

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 84 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 24 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1d348899f7a3..958f7af79fad 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4718,34 +4718,66 @@ static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
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
+	size_t ks = 0;
+	int orig_size = 0;
+	struct kmem_cache *s = NULL;
+
+	/* Check for double-free. */
+	if (unlikely(ZERO_OR_NULL_PTR(p)))
+		goto alloc_new;
+
+	if (!kasan_check_byte(p))
+		return NULL;
+
+	if (is_kfence_address(p)) {
+		ks = orig_size = kfence_ksize(p);
+	} else {
+		struct folio *folio;
+
+		folio = virt_to_folio(p);
+		if (unlikely(!folio_test_slab(folio))) {
+			/* Big kmalloc object */
+			WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE);
+			WARN_ON(p != folio_address(folio));
+			ks = folio_size(folio);
+		} else {
+			s = folio_slab(folio)->slab_cache;
+			orig_size = get_orig_size(s, (void *)p);
+			ks = s->object_size;
+		}
+	}
+
+	/* If the old object doesn't fit, allocate a bigger one */
+	if (new_size > ks)
+		goto alloc_new;
+
+	/* Zero out spare memory. */
+	if (want_init_on_alloc(flags)) {
+		kasan_disable_current();
+		if (orig_size && orig_size < new_size)
+			memset((void *)p + orig_size, 0, new_size - orig_size);
+		else
 			memset((void *)p + new_size, 0, ks - new_size);
-			kasan_enable_current();
-		}
+		kasan_enable_current();
+	}
 
-		p = kasan_krealloc((void *)p, new_size, flags);
-		return (void *)p;
+	/* Setup kmalloc redzone when needed */
+	if (s && slub_debug_orig_size(s)) {
+		set_orig_size(s, (void *)p, new_size);
+		if (s->flags & SLAB_RED_ZONE && new_size < ks)
+			memset_no_sanitize_memory((void *)p + new_size,
+						SLUB_RED_ACTIVE, ks - new_size);
 	}
 
+	p = kasan_krealloc((void *)p, new_size, flags);
+	return (void *)p;
+
+alloc_new:
 	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
-		memcpy(ret, kasan_reset_tag(p), ks);
+		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
 		kasan_enable_current();
 	}
 
@@ -4766,16 +4798,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
  * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
  * __GFP_ZERO is not fully honored by this API.
  *
- * This is the case, since krealloc() only knows about the bucket size of an
- * allocation (but not the exact size it was allocated with) and hence
- * implements the following semantics for shrinking and growing buffers with
- * __GFP_ZERO.
+ * When slub_debug_orig_size() is off, krealloc() only knows about the bucket
+ * size of an allocation (but not the exact size it was allocated with) and
+ * hence implements the following semantics for shrinking and growing buffers
+ * with __GFP_ZERO.
  *
  *         new             bucket
  * 0       size             size
  * |--------|----------------|
  * |  keep  |      zero      |
  *
+ * Otherwise, the original allocation size 'orig_size' could be used to
+ * precisely clear the requested size, and the new size will also be stored
+ * as the new 'orig_size'.
+ *
  * In any case, the contents of the object pointed to are preserved up to the
  * lesser of the new and old sizes.
  *
-- 
2.27.0



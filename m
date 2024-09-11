Return-Path: <linux-kernel+bounces-324279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7622974A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A86C286977
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D881AC8;
	Wed, 11 Sep 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAtxeU2f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162AF127E18
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037174; cv=none; b=hPHsdVmzXdmmBLfl5Qv8KQSBBkwROqFq0K4MunTzEcPyKAdFGBTTwkrQ+DkKBYCWDKWzQOnwnakKdrxx8J7XIsXn12GHd1TkT6wOHBJ5YBv0rwVHgmhuQYyUy6dP5YeqiElJb4tzv9Lw4L8R3J4QJ5DNSEOunQeefv+39A2d8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037174; c=relaxed/simple;
	bh=ZHBD5nxjCn39VoHzOY+ge2IVDv8unPJPEMRErbHaUA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxdBD4Fj4rijmXAOCDoNi6JB0mopBObor5bN83s5L8FydpCyJQ6rN5CNrZvNsDsSIzb+L5LIfI0EdsXPgUWfFSfVTOHPNal8YYOP5yRgsBvWFZh58UjvGSYeXgY9fQkH7lXyZDYySgrLnVWwvn5HFtguQzQNxk6479Hcr9jzO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAtxeU2f; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037173; x=1757573173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZHBD5nxjCn39VoHzOY+ge2IVDv8unPJPEMRErbHaUA4=;
  b=mAtxeU2f8Z7WmpquHWY4nyvM1zqRIlqVBl49pGlAl5nPXPdlfSbdv/+M
   iVjgPTQvxuzlyZYljW594Jgel6PO1SteSfp74AcjfwDE9JbvAECLNZukv
   btTJu2Zo9qeQRvqlhjlzmdrrILhyp8H/olExK9B0wwyaH+yE/ZYtNXw8r
   2I8tTZ3m3HrDZTZBxIP7JzXRBwTL2CaGQ4hS6iamYjLA6QwIjbDc3UWh+
   sW2oxqIxZr24oE0RGsoz8X2+00p3zeJ35hYcfmO7LVECPVl0yh0Dj9pOr
   Rxxn+Yk7t7bQfQsDaGZTWuzzqaPRp5DoJB4U+6I8K3GjwdDIHqBWTaAlH
   Q==;
X-CSE-ConnectionGUID: D4TUMG7lTlSUbwFk9MpS3g==
X-CSE-MsgGUID: mCbQPIbHSgirw1c+H4EPZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36173029"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36173029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:46:11 -0700
X-CSE-ConnectionGUID: v543qwycT2WvE2geGxwVvA==
X-CSE-MsgGUID: Ll8xYtUdRRW3q2YxBIkspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771506"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:46:00 -0700
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
Subject: [PATCH v2 4/5] mm/slub: Improve redzone check and zeroing for krealloc()
Date: Wed, 11 Sep 2024 14:45:34 +0800
Message-Id: <20240911064535.557650-5-feng.tang@intel.com>
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

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slub.c | 54 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c1796f9dd30f..e0fb0a26c796 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4717,33 +4717,51 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 {
 	void *ret;
 	size_t ks;
+	int orig_size = 0;
+	struct kmem_cache *s;
 
-	/* Check for double-free before calling ksize. */
+	/* Check for double-free. */
 	if (likely(!ZERO_OR_NULL_PTR(p))) {
 		if (!kasan_check_byte(p))
 			return NULL;
-		ks = ksize(p);
+
+		s = virt_to_cache(p);
+		orig_size = get_orig_size(s, (void *)p);
+		ks = s->object_size;
 	} else
 		ks = 0;
 
-	/* If the object still fits, repoison it precisely. */
-	if (ks >= new_size) {
-		/* Zero out spare memory. */
-		if (want_init_on_alloc(flags)) {
-			kasan_disable_current();
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
 			memset((void *)p + new_size, 0, ks - new_size);
-			kasan_enable_current();
-		}
+		kasan_enable_current();
+	}
 
-		p = kasan_krealloc((void *)p, new_size, flags);
-		return (void *)p;
+	if (slub_debug_orig_size(s) && !is_kfence_address(p)) {
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
+		if (orig_size)
+			memcpy(ret, kasan_reset_tag(p), orig_size);
 		kasan_enable_current();
 	}
 
@@ -4764,16 +4782,20 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
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
2.34.1



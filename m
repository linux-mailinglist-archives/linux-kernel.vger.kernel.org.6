Return-Path: <linux-kernel+bounces-320489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA8970B38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F378EB21062
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4E17545;
	Mon,  9 Sep 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2sx01ob"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F312B64
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845409; cv=none; b=gVDNz3ySdyZ4XeonpH90DEnrnHCLjaNemS/vh04d0mAiGmXVy8QS29Qw2RrF1PyCgIFZLQ6jYAeuLznzlfMIVqA1RtADJgV+/33wk0CzijZI7EBivGfLkTtsuJt79H54ahrvxKCyoGa3o1Jj5F6t2dfsKLAzWBgKIySXTC+B7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845409; c=relaxed/simple;
	bh=pVsgqwZadHhdmsZUe9yKROnQBO6McnXZ8J3vApLU53I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uy1Eaw6eJVJBLkEcHVJIi+IDABKn9z6zI4Cl6DDec3zmL1pqcdjIgxlOfCkViTCZp0Wvi2vbLlvLYIrO1T4SQDa2ODARHDMyGoMdDhLd4+VhOYNMK2KCl6hgtXeH+qdgs+ENKCWvfLOlwwk0cLV0rvMGKJRPcCNba9NUcOxtJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2sx01ob; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725845408; x=1757381408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVsgqwZadHhdmsZUe9yKROnQBO6McnXZ8J3vApLU53I=;
  b=T2sx01obrcg6hn4YcJPB0+HLOSHNPzDxDRbu8GUa5zptODvli9Tp8q5o
   VXyTupaKHHxrFOBU9zJxE9Jfdcvs2CH76SsiUF/uSvRjgpyAQ5Tr/zE6S
   pXR6qkmjl2xDe7i0YT7CfJieK3G5Vtbg4SU1lnh9TcLamZREHiasEYFf3
   1qmRcaR88nsPAy6rYpgdpH9XbVqbV0plNBwzUJG4xqYUbosKzntNkHj8X
   pW/Md9qD0fu/jgm0Gtn/Izaa3wRtEG0FBp+UVUq715ml0GMpTGLR5AGjp
   wm7Oedb1+vN9QOPu/I2V1RpxgXZdhrtKUna0XpNqklcobfPZPUd8kdNzX
   g==;
X-CSE-ConnectionGUID: n82M5v+1QYuF/TAs1FYRnQ==
X-CSE-MsgGUID: 5BGZMdDjSl674Fpwe3V8sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28258099"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28258099"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 18:30:07 -0700
X-CSE-ConnectionGUID: UowcQFlWTN6ZxGnlayNrVA==
X-CSE-MsgGUID: NSxbVtALS32RTELxfc1T0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66486438"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2024 18:30:03 -0700
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
Subject: [PATCH 1/5] mm/kasan: Don't store metadata inside kmalloc object when slub_debug_orig_size is on
Date: Mon,  9 Sep 2024 09:29:54 +0800
Message-Id: <20240909012958.913438-2-feng.tang@intel.com>
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

For a kmalloc object, when both kasan and slub redzone sanity check
are enabled, they could both manipulate its data space like storing
kasan free meta data and setting up kmalloc redzone, and may affect
accuracy of that object's 'orig_size'.

As an accurate 'orig_size' will be needed by some function like
krealloc() soon, save kasan's free meta data in slub's metadata area
instead of inside object when 'orig_size' is enabled. 

This will make it easier to maintain/understand the code. Size wise,
when these two options are both enabled, the slub meta data space is
already huge, and this just slightly increase the overall size.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/kasan/generic.c |  5 ++++-
 mm/slab.h          |  6 ++++++
 mm/slub.c          | 17 -----------------
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 6310a180278b..cad376199d47 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -393,8 +393,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
 	 *    retain its content until the next allocation.
+	 * 3. It is from a kmalloc cache which enables the debug option
+	 *    to store original size.
 	 */
-	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor) {
+	if ((cache->flags & SLAB_TYPESAFE_BY_RCU) || cache->ctor ||
+	     slub_debug_orig_size(cache)) {
 		cache->kasan_info.free_meta_offset = *size;
 		*size += sizeof(struct kasan_free_meta);
 		goto free_meta_added;
diff --git a/mm/slab.h b/mm/slab.h
index 90f95bda4571..7a0e9b34ba2a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -689,6 +689,12 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
 
+static inline bool slub_debug_orig_size(struct kmem_cache *s)
+{
+	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
+			(s->flags & SLAB_KMALLOC));
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 void skip_orig_size_check(struct kmem_cache *s, const void *object);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 23761533329d..996a72fa6f62 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -230,12 +230,6 @@ static inline bool kmem_cache_debug(struct kmem_cache *s)
 	return kmem_cache_debug_flags(s, SLAB_DEBUG_FLAGS);
 }
 
-static inline bool slub_debug_orig_size(struct kmem_cache *s)
-{
-	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
-			(s->flags & SLAB_KMALLOC));
-}
-
 void *fixup_red_left(struct kmem_cache *s, void *p)
 {
 	if (kmem_cache_debug_flags(s, SLAB_RED_ZONE))
@@ -760,21 +754,10 @@ static inline void set_orig_size(struct kmem_cache *s,
 				void *object, unsigned int orig_size)
 {
 	void *p = kasan_reset_tag(object);
-	unsigned int kasan_meta_size;
 
 	if (!slub_debug_orig_size(s))
 		return;
 
-	/*
-	 * KASAN can save its free meta data inside of the object at offset 0.
-	 * If this meta data size is larger than 'orig_size', it will overlap
-	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
-	 * 'orig_size' to be as at least as big as KASAN's meta data.
-	 */
-	kasan_meta_size = kasan_metadata_size(s, true);
-	if (kasan_meta_size > orig_size)
-		orig_size = kasan_meta_size;
-
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
-- 
2.34.1



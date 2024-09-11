Return-Path: <linux-kernel+bounces-324278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB72974A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB19B21411
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143267DA6E;
	Wed, 11 Sep 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lERXujxi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB897D3F4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037154; cv=none; b=XE3gx/wPRsLUXoFeXAVxJrcS5End/2r03b3yJx3CzoJpMn4dVgk8w66MFe2SFs9IWFJOK1Q93GlL2E+1FTQ+eXkR9mDtscQYf5DYHCMU30gY92kyh8aPLMjoFezTfw5FyHkaX6H1PRPF8KHKVy0GPEntBftUnTfom+6fsw2Apgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037154; c=relaxed/simple;
	bh=dM2adnqSdhHnHwASvqcFoX4V3rfZ14QoQNpiYKbsRgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhXagNs35el3vu2GNHdTRcrdJcX1+9cHvTXpKl8Rhfn/7wH0TjuKBC7Os0AhIHtgxETLSS14P1aApFCvnSd9tzlQzIbLjFgQd6l7YZBHyxQhkOIw9cNMcTW98P2ElnWTDFLJno3XaJWsxuIci73LdwIgykmqRf+OA6wbD1qXMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lERXujxi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726037152; x=1757573152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dM2adnqSdhHnHwASvqcFoX4V3rfZ14QoQNpiYKbsRgQ=;
  b=lERXujxiEE5lGVLbU8Eer02M/WcS1IHRbEmD/cJcZGxq1+4sPUVFCIbZ
   dMs8dPF6+brvSneeNr4qk0reuNILj9EKA6PPzCLfjHBFKOgjcQP7Ol13/
   9iCmSJL6t3ZEcsgXYM+HNDQNtResrSNOvZwVefpg7ppUTYuIE0dcj6PSV
   AIe82cu4WO5aid5ptKbWdOgCdt46232UWL0nhje1Px0KJjduUzGuitFkq
   uialQHs2hro28gKGZztGDoqDsWL5Aq0bOL6UH6otUxABHSUTLaB1n1mJg
   u5+vHsa3s6CLEpem0jkJ15jDWk+1U1CQirr+ZM1cfmN2IIocMLJp0B2AA
   g==;
X-CSE-ConnectionGUID: RwOPG8JyQGSFKioEYsXnpQ==
X-CSE-MsgGUID: /73sftPrQu65GqYvQtxBfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="36172986"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="36172986"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 23:45:52 -0700
X-CSE-ConnectionGUID: wcILiiZ3QmaqfhSIVIcfHw==
X-CSE-MsgGUID: fx8JhJANRZCRTz/LvKdSHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67771485"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa007.jf.intel.com with ESMTP; 10 Sep 2024 23:45:41 -0700
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
Subject: [PATCH v2 1/5] mm/kasan: Don't store metadata inside kmalloc object when slub_debug_orig_size is on
Date: Wed, 11 Sep 2024 14:45:31 +0800
Message-Id: <20240911064535.557650-2-feng.tang@intel.com>
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
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 mm/kasan/generic.c |  7 +++++--
 mm/slab.h          |  6 ++++++
 mm/slub.c          | 17 -----------------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 6310a180278b..8b9e348113b1 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -392,9 +392,12 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	 * 1. Object is SLAB_TYPESAFE_BY_RCU, which means that it can
 	 *    be touched after it was freed, or
 	 * 2. Object has a constructor, which means it's expected to
-	 *    retain its content until the next allocation.
+	 *    retain its content until the next allocation, or
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
index f22fb760b286..f72a8849b988 100644
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
index 21f71cb6cc06..87c95f170f13 100644
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



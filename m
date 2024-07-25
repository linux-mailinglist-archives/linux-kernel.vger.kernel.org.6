Return-Path: <linux-kernel+bounces-262392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABF93C672
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728831F2262D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17119DF54;
	Thu, 25 Jul 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTD8NpEn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360519CD05
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921534; cv=none; b=GxSsyf+x7rxbomoIYxra3pmXFRU2RFVYbl2Z0eGzwonFPIbyxISQCnauCL8TM/BnoIDUrhIgnUuhM60Lit2T5nJt9GL2WR3AwacTd9F5IteqHogTADegTBZ1oCE99YaLaI/H4jqNmxbZgt9QzsFkXALWXkzWSXNLItxBL+lYR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921534; c=relaxed/simple;
	bh=1bRXtV4tCWWgNSqhyt7pXx3h4VTjmHCZzV0fc/A2g00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBFwF0YavqHl1YFPIG5sZ+S9cv7+li1CM6TB5Ndajmpv0k3Zd/0rlQAJqS8UAgWJqZqer17USV7hDFTVjDvi+nqTgFUqbK8/TbPieF4jXt/mewwSHzazY23cevfNRV1YyID1jyTvb0aQOhXpI69iZ14BfvsPo4ina2ZSRCSEzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTD8NpEn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428063f4d71so49215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721921531; x=1722526331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S80DlW207ZEjD96+lTTj/Jsz+nrwgqtEAZpXQKy+x/U=;
        b=FTD8NpEnBcDp23I/GtXx1xAL29iuhsm4y84MRKYD0W5g3PATJEOQwTmJYcb1fiQxYu
         eCQ0JeR2wEs3S9tqtvOFj0CjjV8WrmqKMXEFQDJq6JRW+Xb/0nRGWDvaRRvHInUDyqwf
         S+ET6eHr/zRKlfgiGselbRQNR31dybp7ELuw/bnia1i6EbzMfJj9eNXA2bH9xWotA7QL
         CGlnzjFhByQeROh9lM+NQOtAMdtQD4KYBqSvXnq4Ctado6izgEcrWO0a7uqi17i9cUj3
         y79SzJrbTBsunI4AENsYn4ck503AcfcQlOMYk4XF2nX5ECS7WleVNaDdKoGmg81lSGcY
         moSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921531; x=1722526331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S80DlW207ZEjD96+lTTj/Jsz+nrwgqtEAZpXQKy+x/U=;
        b=iiwTL+1T8moOc9tlLBDdDRGc+CpY5042xBF6U9ks6CQ0TqfVDPJbNmymNv26QCO+gP
         GrXs7Laa2DQ68tXkYdRipVn9A5xZf/bs1PQExQguPiFENIwiZH2vD0svBI7MmuDId8e4
         +G3ePVOFG+2i3fCw9vl4ZRjdaruJd2qMwacknjckimjHDh/EiIzFk43IYKTENfcPX9vX
         lF/NeWQl24mqGJM8kRETx6NzPal6iiwI5KYVmurvynwVmLGFMIF4ZEw0JPrzgnT6EtGM
         f3jEXIbDBUnwOqD+E+ELK98aSFiaj4GS/JkUcxZsGHXu8cWi84RUVK5w50Emx/QqvXAY
         p/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrskP1/8gfKidYNh+2Y5rNmYZ+zYsVfKXy43MBJ0EQK/LL05lK5hkAvucPUR60ea5usqXWDaxjdGziQ+4x+RpGaFvcibrv7CYcTomr
X-Gm-Message-State: AOJu0YxlkCC31aAwHVzm424+8BmdIMJPZsixGNsAoTTRb21oLK77HirN
	9+i4KXtZkDVOesMF+lYeYtTY1XN1ib3p4JfKC0WKud39A+3SMJlZLsvygPHZTA==
X-Google-Smtp-Source: AGHT+IGTgxL68Lab4hAffRvTpBKXqqPX2X+Es5KlprReaPQi71OMRyo31oSEtnMS9ZXhSMSVCevBnQ==
X-Received: by 2002:a05:600c:4f8f:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-42803fa97eemr1598795e9.0.1721921529416;
        Thu, 25 Jul 2024 08:32:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:8b71:b285:2625:c911])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6c81sm40998455e9.34.2024.07.25.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:32:08 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jul 2024 17:31:35 +0200
Subject: [PATCH v3 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-kasan-tsbrcu-v3-2-51c92f8f1101@google.com>
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
In-Reply-To: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev

Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_RCU
slabs because use-after-free is allowed within the RCU grace period by
design.

Add a SLUB debugging feature which RCU-delays every individual
kmem_cache_free() before either actually freeing the object or handing it
off to KASAN, and change KASAN to poison freed objects as normal when this
option is enabled.

For now I've configured Kconfig.debug to default-enable this feature in the
KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_TAGS
mode because I'm not sure if it might have unwanted performance degradation
effects there.

Note that this is mostly useful with KASAN in the quarantine-based GENERIC
mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
(A possible future extension of this work would be to also let SLUB call
the ->ctor() on every allocation instead of only when the slab page is
allocated; then tag-based modes would be able to assign new tags on every
reallocation.)

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 14 ++++++----
 mm/Kconfig.debug      | 29 ++++++++++++++++++++
 mm/kasan/common.c     | 13 +++++----
 mm/kasan/kasan_test.c | 44 +++++++++++++++++++++++++++++
 mm/slab_common.c      | 12 ++++++++
 mm/slub.c             | 76 +++++++++++++++++++++++++++++++++++++++++++++------
 6 files changed, 170 insertions(+), 18 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index ebd93c843e78..c64483d3e2bd 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -186,12 +186,15 @@ static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
 }
 
 bool __kasan_slab_free(struct kmem_cache *s, void *object,
-			unsigned long ip, bool init);
+			unsigned long ip, bool init, bool after_rcu_delay);
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
-						void *object, bool init)
+						void *object, bool init,
+						bool after_rcu_delay)
 {
-	if (kasan_enabled())
-		return __kasan_slab_free(s, object, _RET_IP_, init);
+	if (kasan_enabled()) {
+		return __kasan_slab_free(s, object, _RET_IP_, init,
+				after_rcu_delay);
+	}
 	return false;
 }
 
@@ -387,7 +390,8 @@ static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *object)
 	return false;
 }
 
-static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
+				   bool init, bool after_rcu_delay)
 {
 	return false;
 }
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index afc72fde0f03..0c088532f5a7 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -70,6 +70,35 @@ config SLUB_DEBUG_ON
 	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
 	  "slab_debug=-".
 
+config SLUB_RCU_DEBUG
+	bool "Make use-after-free detection possible in TYPESAFE_BY_RCU caches"
+	depends on SLUB_DEBUG
+	default KASAN_GENERIC || KASAN_SW_TAGS
+	help
+	  Make SLAB_TYPESAFE_BY_RCU caches behave approximately as if the cache
+	  was not marked as SLAB_TYPESAFE_BY_RCU and every caller used
+	  kfree_rcu() instead.
+
+	  This is intended for use in combination with KASAN, to enable KASAN to
+	  detect use-after-free accesses in such caches.
+	  (KFENCE is able to do that independent of this flag.)
+
+	  This might degrade performance.
+	  Unfortunately this also prevents a very specific bug pattern from
+	  triggering (insufficient checks against an object being recycled
+	  within the RCU grace period); so this option can be turned off even on
+	  KASAN builds, in case you want to test for such a bug.
+
+	  If you're using this for testing bugs / fuzzing and care about
+	  catching all the bugs WAY more than performance, you might want to
+	  also turn on CONFIG_RCU_STRICT_GRACE_PERIOD.
+
+	  WARNING:
+	  This is designed as a debugging feature, not a security feature.
+	  Objects are sometimes recycled without RCU delay under memory pressure.
+
+	  If unsure, say N.
+
 config PAGE_OWNER
 	bool "Track page owner"
 	depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 7c7fc6ce7eb7..d92cb2e9189d 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -238,7 +238,8 @@ static enum free_validation_result check_slab_free(struct kmem_cache *cache,
 }
 
 static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
-				      unsigned long ip, bool init)
+				      unsigned long ip, bool init,
+				      bool after_rcu_delay)
 {
 	void *tagged_object = object;
 	enum free_validation_result valid = check_slab_free(cache, object, ip);
@@ -251,7 +252,8 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
 	object = kasan_reset_tag(object);
 
 	/* RCU slabs could be legally used after free within the RCU period. */
-	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
+	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) &&
+	    !after_rcu_delay)
 		return false;
 
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
@@ -270,7 +272,8 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 }
 
 bool __kasan_slab_free(struct kmem_cache *cache, void *object,
-				unsigned long ip, bool init)
+				unsigned long ip, bool init,
+				bool after_rcu_delay)
 {
 	if (is_kfence_address(object))
 		return false;
@@ -280,7 +283,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	 * freelist. The object will thus never be allocated again and its
 	 * metadata will never get released.
 	 */
-	if (poison_slab_object(cache, object, ip, init))
+	if (poison_slab_object(cache, object, ip, init, after_rcu_delay))
 		return true;
 
 	/*
@@ -535,7 +538,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return false;
 
 	slab = folio_slab(folio);
-	return !poison_slab_object(slab->slab_cache, ptr, ip, false);
+	return !poison_slab_object(slab->slab_cache, ptr, ip, false, false);
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7b32be2a3cf0..cba782a4b072 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -996,6 +996,49 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void kmem_cache_rcu_uaf(struct kunit *test)
+{
+	char *p;
+	size_t size = 200;
+	struct kmem_cache *cache;
+
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB_RCU_DEBUG);
+
+	cache = kmem_cache_create("test_cache", size, 0, SLAB_TYPESAFE_BY_RCU,
+				  NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	p = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(cache);
+		return;
+	}
+	*p = 1;
+
+	rcu_read_lock();
+
+	/* Free the object - this will internally schedule an RCU callback. */
+	kmem_cache_free(cache, p);
+
+	/* We should still be allowed to access the object at this point because
+	 * the cache is SLAB_TYPESAFE_BY_RCU and we've been in an RCU read-side
+	 * critical section since before the kmem_cache_free().
+	 */
+	READ_ONCE(*p);
+
+	rcu_read_unlock();
+
+	/* Wait for the RCU callback to execute; after this, the object should
+	 * have actually been freed from KASAN's perspective.
+	 */
+	rcu_barrier();
+
+	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
+
+	kmem_cache_destroy(cache);
+}
+
 static void empty_cache_ctor(void *object) { }
 
 static void kmem_cache_double_destroy(struct kunit *test)
@@ -1937,6 +1980,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmem_cache_oob),
 	KUNIT_CASE(kmem_cache_double_free),
 	KUNIT_CASE(kmem_cache_invalid_free),
+	KUNIT_CASE(kmem_cache_rcu_uaf),
 	KUNIT_CASE(kmem_cache_double_destroy),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1560a1546bb1..19511e34017b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -450,6 +450,18 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 
 static int shutdown_cache(struct kmem_cache *s)
 {
+	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
+	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
+		/*
+		 * Under CONFIG_SLUB_RCU_DEBUG, when objects in a
+		 * SLAB_TYPESAFE_BY_RCU slab are freed, SLUB will internally
+		 * defer their freeing with call_rcu().
+		 * Wait for such call_rcu() invocations here before actually
+		 * destroying the cache.
+		 */
+		rcu_barrier();
+	}
+
 	/* free asan quarantined objects */
 	kasan_cache_shutdown(s);
 
diff --git a/mm/slub.c b/mm/slub.c
index 34724704c52d..f44eec209e3e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2144,15 +2144,26 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+#ifdef CONFIG_SLUB_RCU_DEBUG
+static void slab_free_after_rcu_debug(struct rcu_head *rcu_head);
+
+struct rcu_delayed_free {
+	struct rcu_head head;
+	void *object;
+};
+#endif
+
 /*
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  *
  * Returns true if freeing of the object can proceed, false if its reuse
- * was delayed by KASAN quarantine, or it was returned to KFENCE.
+ * was delayed by CONFIG_SLUB_RCU_DEBUG or KASAN quarantine, or it was returned
+ * to KFENCE.
  */
 static __always_inline
-bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
+bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
+		    bool after_rcu_delay)
 {
 	kmemleak_free_recursive(x, s->flags);
 	kmsan_slab_free(s, x);
@@ -2163,7 +2174,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 		debug_check_no_obj_freed(x, s->object_size);
 
 	/* Use KCSAN to help debug racy use-after-free. */
-	if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
+	if (!(s->flags & SLAB_TYPESAFE_BY_RCU) || after_rcu_delay)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
@@ -2177,6 +2188,28 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	if (kasan_slab_pre_free(s, x))
 		return false;
 
+#ifdef CONFIG_SLUB_RCU_DEBUG
+	if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
+		struct rcu_delayed_free *delayed_free;
+
+		delayed_free = kmalloc(sizeof(*delayed_free), GFP_NOWAIT);
+		if (delayed_free) {
+			/*
+			 * Let KASAN track our call stack as a "related work
+			 * creation", just like if the object had been freed
+			 * normally via kfree_rcu().
+			 * We have to do this manually because the rcu_head is
+			 * not located inside the object.
+			 */
+			kasan_record_aux_stack_noalloc(x);
+
+			delayed_free->object = x;
+			call_rcu(&delayed_free->head, slab_free_after_rcu_debug);
+			return false;
+		}
+	}
+#endif /* CONFIG_SLUB_RCU_DEBUG */
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_free and initialization memset's must be
@@ -2200,7 +2233,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 		       s->size - inuse - rsize);
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return !kasan_slab_free(s, x, init);
+	return !kasan_slab_free(s, x, init, after_rcu_delay);
 }
 
 static __fastpath_inline
@@ -2214,7 +2247,7 @@ bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
 	bool init;
 
 	if (is_kfence_address(next)) {
-		slab_free_hook(s, next, false);
+		slab_free_hook(s, next, false, false);
 		return false;
 	}
 
@@ -2229,7 +2262,7 @@ bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (likely(slab_free_hook(s, object, init))) {
+		if (likely(slab_free_hook(s, object, init, false))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
@@ -4442,7 +4475,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	memcg_slab_free_hook(s, slab, &object, 1);
 	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
@@ -4451,7 +4484,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 static noinline
 void memcg_alloc_abort_single(struct kmem_cache *s, void *object)
 {
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		do_slab_free(s, virt_to_slab(object), object, object, 1, _RET_IP_);
 }
 #endif
@@ -4470,6 +4503,33 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		do_slab_free(s, slab, head, tail, cnt, addr);
 }
 
+#ifdef CONFIG_SLUB_RCU_DEBUG
+static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
+{
+	struct rcu_delayed_free *delayed_free =
+			container_of(rcu_head, struct rcu_delayed_free, head);
+	void *object = delayed_free->object;
+	struct slab *slab = virt_to_slab(object);
+	struct kmem_cache *s;
+
+	if (WARN_ON(is_kfence_address(rcu_head)))
+		return;
+
+	/* find the object and the cache again */
+	if (WARN_ON(!slab))
+		return;
+	s = slab->slab_cache;
+	if (WARN_ON(!(s->flags & SLAB_TYPESAFE_BY_RCU)))
+		return;
+
+	/* resume freeing */
+	if (!slab_free_hook(s, object, slab_want_init_on_free(s), true))
+		return;
+	do_slab_free(s, slab, object, NULL, 1, _THIS_IP_);
+	kfree(delayed_free);
+}
+#endif /* CONFIG_SLUB_RCU_DEBUG */
+
 #ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {

-- 
2.45.2.1089.g2a221341d9-goog



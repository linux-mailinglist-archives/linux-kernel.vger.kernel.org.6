Return-Path: <linux-kernel+bounces-279999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758794C45B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0B1C2381C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF61474B2;
	Thu,  8 Aug 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGDOtOrj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D813AD13
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141880; cv=none; b=L2tCys/UJFl4vRMl4J28bvzTsiS1P2Ihy84F2CjNtoHOB0nz8NR0rNYj6fbYnFmITtvjeGFr/Jznv5y7lJKXZmcZpymDoaSNHlYHOLZLTJGOYvVURx+7FIKsW3Vq3qfoFvliNo37tFrLKHrGu5YRukgKNbU2zceEiWsDtTmQ7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141880; c=relaxed/simple;
	bh=z5bSbkCj94GnaiGWLuFtbBdFDDwX9unmguhfbktiJvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrdSpENCHlY08KV0mp1Qbdl+Jex4rbCuLMYFGTe9kH192RyRVc3/fQOviFDc5qmv2JkhzbyvsJqu37obwnIKOjJCs+JMSn/kvU3eN0NSncv8VPlA2pWaDJcBNb0B6SX+wlBS/u9jxjqJEpGpwbzaOKc7npIFWDLw6Zbmzld2LM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGDOtOrj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so1587a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723141877; x=1723746677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+PyumrqcJpgwsYfmjIw/CKiRtSxZuY78aagcb5lFIE=;
        b=OGDOtOrjtxU/wLYvHW1YF08GN6Kq+Qq+flKhJbW42DaL715U5R+Ntx4rwOJUGjr0MG
         wY6Lq1r6tv80H/fUboJSrNqnLVPxN8riyU1B4Nv5Xf2uCYCIIiDwoXKLeGiDAxTZ17Zy
         jKoymExM+8txef/LC3+LeW8UPTA04qBAXc7CzECbyjJryt0YzTIRYMXqLGxTgVoGfZZk
         h9pQSQ2bwTt5pB/rI4ZUyCaR9ZisGuD6I+Vapb2j7X3S4qBKUdjEKU7YvGDIK3xh36qA
         ooQbOmpeqmo4ERvr/f3b7RNmFflIha9RUoWKPGxC3MIfsZsJFoz5gfinP6NSRZjm2I9J
         72Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141877; x=1723746677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+PyumrqcJpgwsYfmjIw/CKiRtSxZuY78aagcb5lFIE=;
        b=kryTXzp9Vt6p/BIHZ3CWI8cOY7iHIFiiQwhyNzVa0a/pyKfxfj0JszJIblee4GWh+F
         qqF9zeDn4MVhDWV1qgFUcYXrEKoZxFMdIjzd2CHrZ0a4pvy8AGn8fo0WHmdvPQExW2Sv
         hFE8DyTB+tL7Ra2z1e6fyLo1bj3tDqpjc/TG0pd51FTQbcKoILHdHpN4NIswDvmsmHsR
         X4N19jfOI+ePIXdcl6Zb93zoiBfJZgizWv2Yat77EOKouZ1SIp8Xq+Xugs02XWp0QPwk
         EbZkCi/QBLKkOfMbuwdE7NkVV/OTIz830K+PRJAVX2BQfvGaODVjL3Gx10bP1SBhDAWq
         IFJg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxxXd30wte4ibqAv+iZ3BFPU9+TMxWe73ElNQ8RqiPG9DuPFhM1QQkLT4g9Mojp9lVX/XHUXOGOY2ZwiGm6zvFWEqQJPAkaA760/U
X-Gm-Message-State: AOJu0YwnOlonZLi/r75gb9tYKf40PxS08uBoX5nbr6GX3jm+PetGtR1m
	YDzM4/vcOajOpuSUDPVnJ4ThKprnVO41zH7j7pTSCViKee5h7qp72sTlHu1vuw==
X-Google-Smtp-Source: AGHT+IHlQNCsZp7MEVYRAseI9qk6sB+ATmES+HHwFPSE+uyifDt6/F43zyIcNOMLQTZMv8g8I4dmCQ==
X-Received: by 2002:a05:6402:2707:b0:5b8:ccae:a8b8 with SMTP id 4fb4d7f45d1cf-5bbbc87c5b6mr5695a12.3.1723141868622;
        Thu, 08 Aug 2024 11:31:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fc0e:258b:99ae:88ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27208c2fsm2789843f8f.74.2024.08.08.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:31:08 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 08 Aug 2024 20:30:46 +0200
Subject: [PATCH v7 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-kasan-tsbrcu-v7-2-0d0590c54ae6@google.com>
References: <20240808-kasan-tsbrcu-v7-0-0d0590c54ae6@google.com>
In-Reply-To: <20240808-kasan-tsbrcu-v7-0-0d0590c54ae6@google.com>
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
 David Sterba <dsterba@suse.cz>, Jann Horn <jannh@google.com>, 
 syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723141862; l=18413;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=z5bSbkCj94GnaiGWLuFtbBdFDDwX9unmguhfbktiJvc=;
 b=F3SfVhr1qcLR3GRRnzcuAVLHRy01xrdo1AoS8KU+jo1CF/QYoWlNQZLZ6W4V4qE2pTTWu7r02
 hwX2Os8yKMnBrtpeeea2x3qURQee3aaAPWN8/zRKGg9MyojK3xocauf
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

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

Tested-by: syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 17 +++++++----
 mm/Kconfig.debug      | 32 +++++++++++++++++++++
 mm/kasan/common.c     | 11 +++----
 mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++++
 mm/slab_common.c      | 12 ++++++++
 mm/slub.c             | 80 +++++++++++++++++++++++++++++++++++++++++++++------
 6 files changed, 179 insertions(+), 19 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 1570c7191176..00a3bf7c0d8f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -193,40 +193,44 @@ static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
 {
 	if (kasan_enabled())
 		return __kasan_slab_pre_free(s, object, _RET_IP_);
 	return false;
 }
 
-bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
+bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
+		       bool still_accessible);
 /**
  * kasan_slab_free - Poison, initialize, and quarantine a slab object.
  * @object: Object to be freed.
  * @init: Whether to initialize the object.
+ * @still_accessible: Whether the object contents are still accessible.
  *
  * This function informs that a slab object has been freed and is not
- * supposed to be accessed anymore, except for objects in
- * SLAB_TYPESAFE_BY_RCU caches.
+ * supposed to be accessed anymore, except when @still_accessible is set
+ * (indicating that the object is in a SLAB_TYPESAFE_BY_RCU cache and an RCU
+ * grace period might not have passed yet).
  *
  * For KASAN modes that have integrated memory initialization
  * (kasan_has_integrated_init() == true), this function also initializes
  * the object's memory. For other modes, the @init argument is ignored.
  *
  * This function might also take ownership of the object to quarantine it.
  * When this happens, KASAN will defer freeing the object to a later
  * stage and handle it internally until then. The return value indicates
  * whether KASAN took ownership of the object.
  *
  * This function is intended only for use by the slab allocator.
  *
  * @Return true if KASAN took ownership of the object; false otherwise.
  */
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
-						void *object, bool init)
+						void *object, bool init,
+						bool still_accessible)
 {
 	if (kasan_enabled())
-		return __kasan_slab_free(s, object, init);
+		return __kasan_slab_free(s, object, init, still_accessible);
 	return false;
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static __always_inline void kasan_kfree_large(void *ptr)
 {
@@ -416,13 +420,14 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 
 static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *object)
 {
 	return false;
 }
 
-static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
+static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
+				   bool init, bool still_accessible)
 {
 	return false;
 }
 static inline void kasan_kfree_large(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 				   gfp_t flags, bool init)
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index afc72fde0f03..41a58536531d 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -67,12 +67,44 @@ config SLUB_DEBUG_ON
 	  equivalent to specifying the "slab_debug" parameter on boot.
 	  There is no support for more fine grained debug control like
 	  possible with slab_debug=xxx. SLUB debugging may be switched
 	  off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
 	  "slab_debug=-".
 
+config SLUB_RCU_DEBUG
+	bool "Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN)"
+	depends on SLUB_DEBUG
+	# SLUB_RCU_DEBUG should build fine without KASAN, but is currently useless
+	# without KASAN, so mark it as a dependency of KASAN for now.
+	depends on KASAN
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
 	select DEBUG_FS
 	select STACKTRACE
 	select STACKDEPOT
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index f26bbc087b3b..ed4873e18c75 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -227,43 +227,44 @@ static bool check_slab_allocation(struct kmem_cache *cache, void *object,
 	}
 
 	return false;
 }
 
 static inline void poison_slab_object(struct kmem_cache *cache, void *object,
-				      bool init)
+				      bool init, bool still_accessible)
 {
 	void *tagged_object = object;
 
 	object = kasan_reset_tag(object);
 
 	/* RCU slabs could be legally used after free within the RCU period. */
-	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
+	if (unlikely(still_accessible))
 		return;
 
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_FREE, init);
 
 	if (kasan_stack_collection_enabled())
 		kasan_save_free_info(cache, tagged_object);
 }
 
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
 	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
 
-bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init)
+bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
+		       bool still_accessible)
 {
 	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
 
-	poison_slab_object(cache, object, init);
+	poison_slab_object(cache, object, init, still_accessible);
 
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
 	 * onto the freelist for now. The object's metadata is kept until the
 	 * object gets evicted from quarantine.
 	 */
@@ -515,13 +516,13 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 
 	slab = folio_slab(folio);
 
 	if (check_slab_allocation(slab->slab_cache, ptr, ip))
 		return false;
 
-	poison_slab_object(slab->slab_cache, ptr, false);
+	poison_slab_object(slab->slab_cache, ptr, false, false);
 	return true;
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 {
 	struct slab *slab;
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7b32be2a3cf0..567d33b493e2 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -993,12 +993,57 @@ static void kmem_cache_invalid_free(struct kunit *test)
 	 */
 	kmem_cache_free(cache, p);
 
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
+	/*
+	 * We should still be allowed to access the object at this point because
+	 * the cache is SLAB_TYPESAFE_BY_RCU and we've been in an RCU read-side
+	 * critical section since before the kmem_cache_free().
+	 */
+	READ_ONCE(*p);
+
+	rcu_read_unlock();
+
+	/*
+	 * Wait for the RCU callback to execute; after this, the object should
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
 {
 	struct kmem_cache *cache;
 
@@ -1934,12 +1979,13 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(workqueue_uaf),
 	KUNIT_CASE(kfree_via_page),
 	KUNIT_CASE(kfree_via_phys),
 	KUNIT_CASE(kmem_cache_oob),
 	KUNIT_CASE(kmem_cache_double_free),
 	KUNIT_CASE(kmem_cache_invalid_free),
+	KUNIT_CASE(kmem_cache_rcu_uaf),
 	KUNIT_CASE(kmem_cache_double_destroy),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),
 	KUNIT_CASE(mempool_kmalloc_oob_right),
 	KUNIT_CASE(mempool_kmalloc_large_oob_right),
 	KUNIT_CASE(mempool_slab_oob_right),
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..d266fa41e648 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -582,12 +582,24 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
 
 	s->refcount--;
 	if (s->refcount)
 		goto out_unlock;
 
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
 	err = shutdown_cache(s);
 	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
diff --git a/mm/slub.c b/mm/slub.c
index 0c98b6a2124f..eb68f4a69f59 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2197,45 +2197,81 @@ static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
 static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
 #endif /* CONFIG_MEMCG */
 
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
+	/* Are the object contents still accessible? */
+	bool still_accessible = (s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay;
+
 	kmemleak_free_recursive(x, s->flags);
 	kmsan_slab_free(s, x);
 
 	debug_check_no_locks_freed(x, s->object_size);
 
 	if (!(s->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(x, s->object_size);
 
 	/* Use KCSAN to help debug racy use-after-free. */
-	if (!(s->flags & SLAB_TYPESAFE_BY_RCU))
+	if (!still_accessible)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
 	if (kfence_free(x))
 		return false;
 
 	/*
 	 * Give KASAN a chance to notice an invalid free operation before we
 	 * modify the object.
 	 */
 	if (kasan_slab_pre_free(s, x))
 		return false;
 
+#ifdef CONFIG_SLUB_RCU_DEBUG
+	if (still_accessible) {
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
 	 * kept together to avoid discrepancies in behavior.
 	 *
 	 * The initialization memset's clear the object and the metadata,
@@ -2253,42 +2289,42 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 			memset(kasan_reset_tag(x), 0, s->object_size);
 		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return !kasan_slab_free(s, x, init);
+	return !kasan_slab_free(s, x, init, still_accessible);
 }
 
 static __fastpath_inline
 bool slab_free_freelist_hook(struct kmem_cache *s, void **head, void **tail,
 			     int *cnt)
 {
 
 	void *object;
 	void *next = *head;
 	void *old_tail = *tail;
 	bool init;
 
 	if (is_kfence_address(next)) {
-		slab_free_hook(s, next, false);
+		slab_free_hook(s, next, false, false);
 		return false;
 	}
 
 	/* Head and tail of the reconstructed freelist */
 	*head = NULL;
 	*tail = NULL;
 
 	init = slab_want_init_on_free(s);
 
 	do {
 		object = next;
 		next = get_freepointer(s, object);
 
 		/* If object's reuse doesn't have to be delayed */
-		if (likely(slab_free_hook(s, object, init))) {
+		if (likely(slab_free_hook(s, object, init, false))) {
 			/* Move object to the new freelist */
 			set_freepointer(s, object, *head);
 			*head = object;
 			if (!*tail)
 				*tail = object;
 		} else {
@@ -4474,40 +4510,68 @@ static __fastpath_inline
 void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, &object, 1);
 	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
 #ifdef CONFIG_MEMCG
 /* Do not inline the rare memcg charging failed path into the allocation path */
 static noinline
 void memcg_alloc_abort_single(struct kmem_cache *s, void *object)
 {
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		do_slab_free(s, virt_to_slab(object), object, object, 1, _RET_IP_);
 }
 #endif
 
 static __fastpath_inline
 void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 		    void *tail, void **p, int cnt, unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
 	alloc_tagging_slab_free_hook(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
 	 */
 	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
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
+	kfree(delayed_free);
+
+	if (WARN_ON(is_kfence_address(object)))
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
+	do_slab_free(s, slab, object, object, 1, _THIS_IP_);
+}
+#endif /* CONFIG_SLUB_RCU_DEBUG */
+
 #ifdef CONFIG_KASAN_GENERIC
 void ___cache_free(struct kmem_cache *cache, void *x, unsigned long addr)
 {
 	do_slab_free(cache, virt_to_slab(x), x, x, 1, addr);
 }
 #endif

-- 
2.46.0.76.ge559c4bf1a-goog



Return-Path: <linux-kernel+bounces-273085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4CD94646D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB61C20C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1225F58ABF;
	Fri,  2 Aug 2024 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLtpxI+3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A001ABEBB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630738; cv=none; b=Jek0RAdmcG7tZPLGhsLoVWri6ITaM9cEK5n4S542Cm5wBSrF55sTB728nfzM1LdSC/FHwg7iCJPMB7FQaSJv3q9yiRmS0HcJVraskYP1AzHoEOF0uEQx5TkSDBFcXsLYTsOU6VUIQg6nDCv7TD85W+2tyzqF6KRapD1wGdczjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630738; c=relaxed/simple;
	bh=n3HTPxz1vqklcUBCM2b1ohNM905PLTWckUn1zsgT95o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cy9kUtc//2fUcNemroqL9ic4qUyDVGfMaIhQI+wNVD2/gIXSPTha5oRwKebGd3XtJwDLQyD1S9wBTnvcuecS9hCFK1Uf03HCzkTjBxW411YE5XznR9tKihgtev12iFnpJuj6lgQhc4Q3B/F8uqFE1RYfCz4YuQVQGQVggO3Hs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLtpxI+3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso258405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722630734; x=1723235534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtIY/lbfQ818ndlf2SV0BX8ni+uEKDx/O9Hr9lNf93M=;
        b=KLtpxI+3MTrfwb8fBN7LbAGh28+CYvwmoQLE2tSCSI33K0exn1t6nVLFAloFcCSrwH
         KQB9lYE10EzqWlN4VGCwvMgaolmkl5DhmW/tgW/NzXGaDcTUIcnKAMgaJ1p072zhyRGP
         0bC+G4Fy/POJ4G9QNeck9oIQpKIDlROygdfGJIKjkFP7/RBKMSWe/siZCHltpQ1pxD+n
         kMTjdqOPfLu8uyHaY/aB/64U7nr6X9y6ffpoQoSRtX6TX2/gOjS/H6obKV8ODXKehEaS
         9IKxEnrkPj7rQImzeKJcvpzfzkmwGFXBB+I28/OqLmsWxcoT5QBCNT8HE2zcyY7FESuE
         CJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630734; x=1723235534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtIY/lbfQ818ndlf2SV0BX8ni+uEKDx/O9Hr9lNf93M=;
        b=I77grBw8jmiIcgO5cdbAkgEu75AmzBI6Uc1SKeQP+5Yi/tL8ERgDpDZxthCZUNOHVh
         gpjeYytpJgvcoz3RRMPQfzWAmemU62I1vJStZV28c/06iWSJ8qVnhJC8eicRX55DH9w7
         9xkP51QuurEw7HqQQ+HzaZ8S3C3WcEXTcR4MN/nrUqtMgTByQqGTgQkGvWiMJVdfXXMv
         tzKoEBiHuX9rCUUBWInbziMv+LgT/JT0tdshFWYTppFw/I09ChK3qDCkdPGJgJKRQb+F
         RQJXouemq5W40bHxG1HwntgfiFBuL6exfAQizZO3rBgTgYxZSJM+PufKW+yaKcun7q/Z
         DI0g==
X-Forwarded-Encrypted: i=1; AJvYcCUWFFVFfyemCvU4prccopb9YtczN+RS9pKvhUFEzLrkSNzIG7s0PNJCf6lMaT3f2NajmJ8p7rQiYzu+2Nfoo19jlgM0SbA9P8lkst1L
X-Gm-Message-State: AOJu0Yz6BNH7o1JHpX+bk8pOXvbinBxWEvqocEFcJ5mcgu9RrQYLcQ4P
	9yPgOx3VX6BnVnau2GuBsX0zhXZU26hILHQDo/nFglVMBQBzUK90/YR74KJvVQ==
X-Google-Smtp-Source: AGHT+IHgObnJcgoST6ZUYoM69nUyHyMSZdwu3GwWheKkgoMDLPs7gmEI4a2Ly4zw5Ykmyy7wwcJ9iw==
X-Received: by 2002:a05:600c:a08c:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-428ef3cbbdfmr44035e9.4.1722630733443;
        Fri, 02 Aug 2024 13:32:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:9337:bd1:a20d:682d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d1b4sm43954895e9.39.2024.08.02.13.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:32:12 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 02 Aug 2024 22:31:53 +0200
Subject: [PATCH v6 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-kasan-tsbrcu-v6-1-60d86ea78416@google.com>
References: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
In-Reply-To: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722630727; l=8985;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=n3HTPxz1vqklcUBCM2b1ohNM905PLTWckUn1zsgT95o=;
 b=pBuk9xoZ3On9sdWadP+S/JMQOgnWggeyhLUucDdlYyDK+oaS4P6P0S2gqDMVcBntQIES2k5g0
 G7Dzmk5va7PAV+bbKgU4Ounb6xSvRgiyFg+cTwdckFsSVg/xFZitzGz
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, when KASAN is combined with init-on-free behavior, the
initialization happens before KASAN's "invalid free" checks.

More importantly, a subsequent commit will want to RCU-delay the actual
SLUB freeing of an object, and we'd like KASAN to still validate
synchronously that freeing the object is permitted. (Otherwise this
change will make the existing testcase kmem_cache_invalid_free fail.)

So add a new KASAN hook that allows KASAN to pre-validate a
kmem_cache_free() operation before SLUB actually starts modifying the
object or its metadata.

Inside KASAN, this:

 - moves checks from poison_slab_object() into check_slab_allocation()
 - moves kasan_arch_is_ready() up into callers of poison_slab_object()
 - removes "ip" argument of poison_slab_object() and __kasan_slab_free()
   (since those functions no longer do any reporting)

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 54 ++++++++++++++++++++++++++++++++++++++++++---
 mm/kasan/common.c     | 61 ++++++++++++++++++++++++++++++---------------------
 mm/slub.c             |  7 ++++++
 3 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..1570c7191176 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -172,19 +172,61 @@ static __always_inline void * __must_check kasan_init_slab_obj(
 {
 	if (kasan_enabled())
 		return __kasan_init_slab_obj(cache, object);
 	return (void *)object;
 }
 
-bool __kasan_slab_free(struct kmem_cache *s, void *object,
-			unsigned long ip, bool init);
+bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
+			unsigned long ip);
+/**
+ * kasan_slab_pre_free - Check whether freeing a slab object is safe.
+ * @object: Object to be freed.
+ *
+ * This function checks whether freeing the given object is safe. It may
+ * check for double-free and invalid-free bugs and report them.
+ *
+ * This function is intended only for use by the slab allocator.
+ *
+ * @Return true if freeing the object is unsafe; false otherwise.
+ */
+static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
+						void *object)
+{
+	if (kasan_enabled())
+		return __kasan_slab_pre_free(s, object, _RET_IP_);
+	return false;
+}
+
+bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
+/**
+ * kasan_slab_free - Poison, initialize, and quarantine a slab object.
+ * @object: Object to be freed.
+ * @init: Whether to initialize the object.
+ *
+ * This function informs that a slab object has been freed and is not
+ * supposed to be accessed anymore, except for objects in
+ * SLAB_TYPESAFE_BY_RCU caches.
+ *
+ * For KASAN modes that have integrated memory initialization
+ * (kasan_has_integrated_init() == true), this function also initializes
+ * the object's memory. For other modes, the @init argument is ignored.
+ *
+ * This function might also take ownership of the object to quarantine it.
+ * When this happens, KASAN will defer freeing the object to a later
+ * stage and handle it internally until then. The return value indicates
+ * whether KASAN took ownership of the object.
+ *
+ * This function is intended only for use by the slab allocator.
+ *
+ * @Return true if KASAN took ownership of the object; false otherwise.
+ */
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
 						void *object, bool init)
 {
 	if (kasan_enabled())
-		return __kasan_slab_free(s, object, _RET_IP_, init);
+		return __kasan_slab_free(s, object, init);
 	return false;
 }
 
 void __kasan_kfree_large(void *ptr, unsigned long ip);
 static __always_inline void kasan_kfree_large(void *ptr)
 {
@@ -368,12 +410,18 @@ static inline void kasan_poison_new_object(struct kmem_cache *cache,
 					void *object) {}
 static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
 				const void *object)
 {
 	return (void *)object;
 }
+
+static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *object)
+{
+	return false;
+}
+
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object, bool init)
 {
 	return false;
 }
 static inline void kasan_kfree_large(void *ptr) {}
 static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 85e7c6b4575c..f26bbc087b3b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -205,59 +205,65 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
 	object = set_tag(object, assign_tag(cache, object, true));
 
 	return (void *)object;
 }
 
-static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
-				      unsigned long ip, bool init)
+/* Returns true when freeing the object is not safe. */
+static bool check_slab_allocation(struct kmem_cache *cache, void *object,
+				  unsigned long ip)
 {
-	void *tagged_object;
-
-	if (!kasan_arch_is_ready())
-		return false;
+	void *tagged_object = object;
 
-	tagged_object = object;
 	object = kasan_reset_tag(object);
 
 	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) != object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
 	}
 
-	/* RCU slabs could be legally used after free within the RCU period. */
-	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
-		return false;
-
 	if (!kasan_byte_accessible(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
 		return true;
 	}
 
+	return false;
+}
+
+static inline void poison_slab_object(struct kmem_cache *cache, void *object,
+				      bool init)
+{
+	void *tagged_object = object;
+
+	object = kasan_reset_tag(object);
+
+	/* RCU slabs could be legally used after free within the RCU period. */
+	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
+		return;
+
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_FREE, init);
 
 	if (kasan_stack_collection_enabled())
 		kasan_save_free_info(cache, tagged_object);
+}
 
-	return false;
+bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
+				unsigned long ip)
+{
+	if (!kasan_arch_is_ready() || is_kfence_address(object))
+		return false;
+	return check_slab_allocation(cache, object, ip);
 }
 
-bool __kasan_slab_free(struct kmem_cache *cache, void *object,
-				unsigned long ip, bool init)
+bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init)
 {
-	if (is_kfence_address(object))
+	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
 
-	/*
-	 * If the object is buggy, do not let slab put the object onto the
-	 * freelist. The object will thus never be allocated again and its
-	 * metadata will never get released.
-	 */
-	if (poison_slab_object(cache, object, ip, init))
-		return true;
+	poison_slab_object(cache, object, init);
 
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
 	 * onto the freelist for now. The object's metadata is kept until the
 	 * object gets evicted from quarantine.
 	 */
@@ -501,17 +507,22 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		if (check_page_allocation(ptr, ip))
 			return false;
 		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
 		return true;
 	}
 
-	if (is_kfence_address(ptr))
-		return false;
+	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+		return true;
 
 	slab = folio_slab(folio);
-	return !poison_slab_object(slab->slab_cache, ptr, ip, false);
+
+	if (check_slab_allocation(slab->slab_cache, ptr, ip))
+		return false;
+
+	poison_slab_object(slab->slab_cache, ptr, false);
+	return true;
 }
 
 void __kasan_mempool_unpoison_object(void *ptr, size_t size, unsigned long ip)
 {
 	struct slab *slab;
 	gfp_t flags = 0; /* Might be executing under a lock. */
diff --git a/mm/slub.c b/mm/slub.c
index 3520acaf9afa..0c98b6a2124f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2223,12 +2223,19 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 		__kcsan_check_access(x, s->object_size,
 				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
 
 	if (kfence_free(x))
 		return false;
 
+	/*
+	 * Give KASAN a chance to notice an invalid free operation before we
+	 * modify the object.
+	 */
+	if (kasan_slab_pre_free(s, x))
+		return false;
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_free and initialization memset's must be
 	 * kept together to avoid discrepancies in behavior.
 	 *
 	 * The initialization memset's clear the object and the metadata,

-- 
2.46.0.rc2.264.g509ed76dc8-goog



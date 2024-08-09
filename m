Return-Path: <linux-kernel+bounces-281155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F6A94D3B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A3D7B22F94
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30E1990DA;
	Fri,  9 Aug 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJ4iKZIn"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0F198856
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217831; cv=none; b=OXuhbRYx3e2JVtUU5FwD7DF4vHIbozBmX7kj6K/t5AkPsfMT2v9pUwDqR0yxJc2zpKygo7g5ubmw7c4UKjzxiyO8gdBKzY5BOj8OVd8N0vG7fi81EzyBvfmiPSuTcNyRUIpYM9aUP132S1FVt64a3cWlarWMZyhn+oYlneddQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217831; c=relaxed/simple;
	bh=6bMIRMeh/1RVCY2STakwRPDtPkfm0ed8OAz2i9tHk/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqYdTTh9c3t5Fkd2ksWjuvQHDdrqqQmZM0Fku7G8HwF9HvPMHOP4+d3W+KjlL4vjs5rnSCy72sNRA40TVIDop04MHREFqXHTrjEux/wRRdZHcpIuXTpGL42k5KeVtSHCffi9uPWtLLKtmRLH6GvJVC8bG/bgBB4cYym7IHtR7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJ4iKZIn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc9834deso65795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723217827; x=1723822627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04hH29wKOUh4zO671E3nNC0Fq21jgPwt4FhdP1F+2dI=;
        b=eJ4iKZIn/rSyhDmGwpEtOkN+EBUmb+HLMyr1Yaz1KKrRJrDwsM7Syv3aqU4cf9gwUE
         K463CY2y151O9R94odHiY4mnhE/pRqNpj0N7MHhuJJmDZF25FONkKUI1oG0RSdDCMW4S
         7eizJEW9tqNDku5RyZcFzK73kZ3wlXkvaowlPkn9LxTi7V/AXZsW8V9fke7v+Y2+FEqL
         RtFL+xSSkCfHQlaFwXUSrTT9nTYRmdiWxLC/iYvZCH7IyO5wqr4sBmgsZsTSGZj+xSAF
         A7zzEYkGkdt3tGGWe1wJYiWHdvPB4/HcyJdKAFhcs4TTfOjiJLQfeZjeTwuL4BcsgH/4
         5hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217827; x=1723822627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04hH29wKOUh4zO671E3nNC0Fq21jgPwt4FhdP1F+2dI=;
        b=t0zKLjF/DAFbqGOWEldqJfhNOeT5c/Hep+ymcai2/kQQFbDKcVsUCgRCKpsWO2wxC5
         J+BEDL6E/Rh8R/Uxr5yznDdUeLHfigudT6XQff/IUEcjGl/LA45lcq53I4TFOVH4WvfY
         sj0GLSD/f6lUMG543NX+Mrhp2bcrQrVd/y5YY/RrXNNVgeN8U4anxXYl8i/gJpj1Eld7
         yIOyHK/IImzzdyM8YN0lXKXaPJWeZZGyQFTmoWbIm4VpJB7JLjubyaz+SPDwY94OYd+1
         qkYH3sVE9+C5Zxk6hho8MmXneR6xc5Xgt816JOgEa5nxM1uJlCFFWmMNA8dp+2iNTtLr
         xr+A==
X-Forwarded-Encrypted: i=1; AJvYcCUlaxnFBKj4jIcCboeqI0iCwv9nM+sOVHuIuk7bQi9+9FVTiBla2h00fDUb49PalS/uLytQv98j5Wbi2OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMFMZ+Gd6JuwqvRRHd/URybNQb4tc+lYnBLMh/l8Dy6utZH+y
	GRK8Jx06yND+A0tXN9ln2NGqD+DXdLoTJ3pC1zogrrSNTKrPvYhnH2upDinAxw==
X-Google-Smtp-Source: AGHT+IGOr0c0CjkgwTBRF8fGT7noWEp1T+yKhvV1d2VxrR9xYPGziTD7vNkFfcFIeHv6Und2nan4Eg==
X-Received: by 2002:a05:600c:3d0e:b0:426:8ee5:3e9c with SMTP id 5b1f17b1804b1-429c170502fmr1680895e9.6.1723217826322;
        Fri, 09 Aug 2024 08:37:06 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:1cbc:ea05:2b3e:79e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971d06sm131370035e9.19.2024.08.09.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:37:05 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 09 Aug 2024 17:36:55 +0200
Subject: [PATCH v8 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-kasan-tsbrcu-v8-1-aef4593f9532@google.com>
References: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
In-Reply-To: <20240809-kasan-tsbrcu-v8-0-aef4593f9532@google.com>
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
 David Sterba <dsterba@suse.cz>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723217820; l=8980;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=6bMIRMeh/1RVCY2STakwRPDtPkfm0ed8OAz2i9tHk/A=;
 b=cgEyMnkYj8fG04Ew4yST4NXZcj+IbXd0To9wuYcsObX2VYDJHqQIXKwsJaH/bAV6w1Fth+GPk
 VGb/0LWxPB2Cf5nOFT6Ov7qUiEcbqCHMirvJ0P2oCCgijDCf5jxeXGE
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
2.46.0.76.ge559c4bf1a-goog



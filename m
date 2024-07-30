Return-Path: <linux-kernel+bounces-267325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EC0941037
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EEBB22B89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6619B5AC;
	Tue, 30 Jul 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zF6wTQM3"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656E198858
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337597; cv=none; b=lao5AVXhv5dGOizGjOf/3kDltkiR1NGBebCXtDMTH9oj3PKLi0lulSJVtz7d2Hnfs/RsWcKwOJS1frDXc12dg8olX98S3f1FbzsUoJifS4KsrSQ90/V6LHau/Rw4CmwOj+wbuAVHrZS5EhwQGgQOS3e1GSUaYyjvtlqqpVm+dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337597; c=relaxed/simple;
	bh=ECJxXqt4z/+LCQMGUm4UQxfGcZgrkmEz2Ae/EuNJxV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDqdAPlBHqTENk7Z8mIcSM1LMfktyE4fDOA3Nnk42VfNyD6H7LiwFcoFsgrOXYy5UwHXDJsFTR6+7w+QPOUSv1LnhFrBe5dUwFGsReXsSyQIyNpnRqVmw3ye4SZ3CfYAs30vNIStIbkbP4v4Tmb4Ff4NXnqgBnuRj/rnY+mJVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zF6wTQM3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428078ebeb9so52595e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722337594; x=1722942394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNxWbBeV69N1GBya0KWgugonlwiE99usGrtCl3FAeEo=;
        b=zF6wTQM36xxs253ZWfy3GfGkUrYy0WApmgzk4Qgu9S0Q+QCK3oTpt06bldeRfw0fi2
         9+reVEfCfAKDwPIVhG+L0r3xVT0LdW40bs5D6xRgnIogxUtyQ0cakEy97nKAK+pzE3cm
         Lq0d3SrNZXma8/s3xo9oSxpys9ZFX49hBfeTXvFO7IlX8wtbHwagFpkg1lcpqtrSmtoh
         EmLFehOcQ1x0DEUc784RUcPm6GvgpIFvSKu73aaWSzp8G4xNe3wI4KXEAjbWi5TIaofr
         FvpsXMYNhV9LvuhgFHeviQHmTxqS5pRDicmEioShDr/VDDwUEalEjAi+q8yXWgdVTW7B
         nkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337594; x=1722942394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNxWbBeV69N1GBya0KWgugonlwiE99usGrtCl3FAeEo=;
        b=IzGxIJTPRS9izL3tpTbt2xLyVuRCrdVzY3bQpFCHro2euFYbZeeNxZZMafyxgYm3hQ
         Vsc5KokdyJrWbsq+6t/1VvStDmb32HBLLy1ef0d5T5vs7OlorowmD5cqD8qxe8yHAcIx
         n8Pofg6qZoXxEybVZrsJva9avgZwcGUD6ywRZ3lOYsNHSpA6LJGS6/0Dw5yE9Jtb7J/u
         d7xsCCEGCx2K6RzSGf5fUJTA02E9sgASQ3UTwF3MKu/QJKvHdssKvx5A5B3WkX2KMNOi
         nkeckoQjZ+6DVhTEBmEmiz8NopYuXYsjdlfoZDTzaW+ri3cUUIjTWwrOrCrttTDc9dIC
         dvbw==
X-Forwarded-Encrypted: i=1; AJvYcCVg88kgzPmFAviHda9HUqN+LP8MXwZ4Xq+cpZnY+fWsJUXk5NussOVbpJgjpKot32NY9zwneWq+YAbYBkLWP3Rs0bHoWOLmfA099Ga5
X-Gm-Message-State: AOJu0YwNkF0w33W4hZ5ZidA9dlAt8LomFv6uHkojAOSnm+V+PCTynQ/x
	TpgmkwBSMnIZ2ZqaAgQoK3w+6E38AtW3EkGRFXkzdtoXUaTw3RiptJ9u8RUXKEqV32SmPfbcHVS
	Lu7RVqwexKw==
X-Google-Smtp-Source: AGHT+IGX25ec+jxtgUmtMWmzYxEzG1X0DXLgKUM3362sARyoK5H4+Oz4k0JLP3S/tYUHDT17ECHgew==
X-Received: by 2002:a05:600c:1d1a:b0:424:898b:522b with SMTP id 5b1f17b1804b1-42824a359b1mr828395e9.1.1722337593356;
        Tue, 30 Jul 2024 04:06:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:be6a:cd70:bdf:6a62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm209130635e9.0.2024.07.30.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 04:06:32 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Jul 2024 13:06:03 +0200
Subject: [PATCH v5 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com>
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
In-Reply-To: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
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

 - moves checks from poison_slab_object() into check_slab_free()
 - moves kasan_arch_is_ready() up into callers of poison_slab_object()
 - removes "ip" argument of poison_slab_object() and __kasan_slab_free()
   (since those functions no longer do any reporting)
 - renames check_slab_free() to check_slab_allocation()

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 43 ++++++++++++++++++++++++++++++++++---
 mm/kasan/common.c     | 59 +++++++++++++++++++++++++++++++--------------------
 mm/slub.c             |  7 ++++++
 3 files changed, 83 insertions(+), 26 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..34cb7a25aacb 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -172,19 +172,50 @@ static __always_inline void * __must_check kasan_init_slab_obj(
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
+ * kasan_slab_pre_free - Validate a slab object freeing request.
+ * @object: Object to free.
+ *
+ * This function checks whether freeing the given object might be permitted; it
+ * checks things like whether the given object is properly aligned and not
+ * already freed.
+ *
+ * This function is only intended for use by the slab allocator.
+ *
+ * @Return true if freeing the object is known to be invalid; false otherwise.
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
+ * kasan_slab_free - Possibly handle slab object freeing.
+ * @object: Object to free.
+ *
+ * This hook is called from the slab allocator to give KASAN a chance to take
+ * ownership of the object and handle its freeing.
+ * kasan_slab_pre_free() must have already been called on the same object.
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
@@ -368,12 +399,18 @@ static inline void kasan_poison_new_object(struct kmem_cache *cache,
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
index 85e7c6b4575c..8cede1ce00e1 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -205,59 +205,65 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
 	object = set_tag(object, assign_tag(cache, object, true));
 
 	return (void *)object;
 }
 
-static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
-				      unsigned long ip, bool init)
+/* returns true for invalid request */
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
@@ -503,15 +509,22 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FREE, false);
 		return true;
 	}
 
 	if (is_kfence_address(ptr))
 		return false;
+	if (!kasan_arch_is_ready())
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
2.46.0.rc1.232.g9752f9e123-goog



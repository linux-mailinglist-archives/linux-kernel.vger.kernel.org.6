Return-Path: <linux-kernel+bounces-266297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41A93FDD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C9F1F22D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1018754D;
	Mon, 29 Jul 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bou6gnNA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB1183084
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279388; cv=none; b=X6E1Glq4WJIAj7f3vQGTGCy2oCdoCRYMPE5Oe56CGCi/CFILIq9USXGip7zb4o8fOS2gzqB29XonNm1Ipv+5kybkQl0FOodOUflmcNPJXtZj56R+Jxl2Skksn++htl79Wtzrwc/Yeqdm7nd+2v/slB8t/jyCc6VljCrde1E37+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279388; c=relaxed/simple;
	bh=fPjZyaurgq56PHHZ1zRrmXojK3qDrhQqrKucXS+Ocxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YO2w0WhDuNxDvZdVek7/pLZE+Q+Gtbbs5YC/M/YYjr1Ss7yRoQ4kD+X5NpydlSL3i6+jLGI/JR068r5BYB18/IOZ9muLhvoRiPX28lIIW7z/oNMnirYchx5QqOnUBSxrM0xZuwI1FJER0us1O+8kT8ohtBHFNnvgxkMRm2+botc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bou6gnNA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso3053a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722279384; x=1722884184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCoOCGeg30WnFijIytAVeEgtIkuQktWy1Oz+PoUgncg=;
        b=bou6gnNABJQxsRRNcIsJvb1/Hy6Qo9bOPjRM+5BuDMNFPGERLlXeU3u1AwoB+sPv1I
         NDxOTpWFldzLCRxKVzC98BBbPOXKEy6kk6q6VLrwQwTPSy0r1kk7in95yu4l3i/VKkL5
         iJESxol62kOjQ/CTSv8rbHkskK8XI/5FnAJOKHJCaON7zjBXvHqgojaQuhO+BGUVsLP5
         BRfegJOzPapnRursVyIKep5q3DdkiNUaK37Yt5Nb1mJ8bc50O6quwo8myHIQ3h3v+9ec
         oQyih+AyiVBvZJz6ufW/SCWOYW391zJxweoUgolQjm3/Ua4u5ayXm6AxEvI4tpC8Z7Fn
         xNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722279384; x=1722884184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCoOCGeg30WnFijIytAVeEgtIkuQktWy1Oz+PoUgncg=;
        b=k627jMCuwrg9KyNmE+xCQxVMLNjBCKVjrTmRBGfdC8mxkEaLIrObNgIXcGf2cJ9DiS
         Ei1yyK6R56Vb/FM5vCK3RRiY5FwDvRmTf/EX8cc+dAqcK6fCg67dNGEfTuv034fOw0vw
         TauRD0BX+8x9ZUlMfvya2fX6d5Y4H9hyD44fWTjAcGb3/VK3Wx+6LynR07O9cDq0vZUM
         eqPyadY8F8Qtv/0x80DzGLoYNkL+QTaihAc9oSSX2ACmwH8eIvi2gddE5StCgq6fw1lG
         VocnYfSIzDLvjxT0qtT5q62C4aXJv+T6sbCiMj3CmS0Nnt3cO0IVLpkurkBvlj1eQbeU
         J2nw==
X-Forwarded-Encrypted: i=1; AJvYcCWerlFCLcs9l7FGZW7qcK/WHKVpWexgjQYV6tYCyPfgn1q/34gduBZCDdwuUpAdqir+m0AWCRsbD/TKF9HjpaIftuN1NjeejKUVNIA4
X-Gm-Message-State: AOJu0YzuO+zIQ8li+44Tvi7Cdk6Tv3V7w79jh5l98nwufTgqJZR2YG4v
	ymsb8bPRtisXauhDa6TdcO8R8eh2Xa/tTQuxXwQTiMlBDoTmM5ctdoTwoTyFjg==
X-Google-Smtp-Source: AGHT+IG+onbItmvIUtDfdEdb4uATJ1weCR4udl5xW61u6T9tSrynBlWJJKir22zMeH/EyVqa3RcnYQ==
X-Received: by 2002:a05:6402:4314:b0:58b:93:b624 with SMTP id 4fb4d7f45d1cf-5b40b12a598mr84009a12.1.1722279383641;
        Mon, 29 Jul 2024 11:56:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a1f4:32c9:4fcd:ec6c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281a936944sm60963535e9.31.2024.07.29.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 11:56:23 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 29 Jul 2024 20:56:11 +0200
Subject: [PATCH v4 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-kasan-tsbrcu-v4-1-57ec85ef80c6@google.com>
References: <20240729-kasan-tsbrcu-v4-0-57ec85ef80c6@google.com>
In-Reply-To: <20240729-kasan-tsbrcu-v4-0-57ec85ef80c6@google.com>
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
index 4927edec6a8c..34724704c52d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2167,12 +2167,19 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
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



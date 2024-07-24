Return-Path: <linux-kernel+bounces-261283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758393B529
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD8282DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03715F400;
	Wed, 24 Jul 2024 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbG92A4X"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53D15E5D6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838863; cv=none; b=IhnR+65Z7exuNd9qg8sRNGXruQmRR+u2VSh24oZp5B7oxD55DSbiA0PgjlTMyTWPOHuUe/loNpn6BcTFWGekf8vagGDWyAprS9/nAaovfuUZ+0Eh0dkV1o727V4JK6W0nt2QGxfkrF/4IlNKhSk/yIKhZKEMH1ch1Wj3ZmmrOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838863; c=relaxed/simple;
	bh=QEcYy56szqhDopl2AUMM3uJIFVej/bdOaG5NWlUdKXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qy72tl49bLzBxOJxh9Zt20RFNZ9RxGsvGaE+IW5F1oamarzjex0GZURMbDP4j2s6a7qh8r/YkqKyZqIpuUupbCcz2af/5lxeTquIk5xa7BQwlNOyfKrbbIK8sX3l541CHTDYEzuBOX9uA8W3pcAllGeYGGgVZ9QZ7YOZ2idiVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbG92A4X; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428031ff0a3so12935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721838860; x=1722443660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EM+ZpXg0gF/YjekvI/GGKZPQZmJkVX1r6GY58f54Us=;
        b=cbG92A4X5B2h5FtgmMgj7EnuBHNgcFHf2lu1ArIzWPnwiC+Muz+FoDeztmaxaRDLzw
         4B+hzDBiYLyED8uKuAkZppWSciE9FsoAzSUd/rfAgEsjpRHkK4USdM4hCqDw0Z4HzeWh
         lMNEGcl1+qMzo+a4wPk7U4Hh2l6RT/HMvQAQFlZh4i0ZEJmA4A+JzJ4Ok1iDB8O6RgWj
         MPsUgJWll6POpglYKQCDQIt8QG1iys9mFHvJlzN7IqiDOhmf002pWHTIk0gCV9R89hpa
         H4mbKi2WRsVkJ23bFSD6gLdA8Bc8hhFUTn73c/6IztZYbe9th0a0v2oLskqEAdI7UohV
         VTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838860; x=1722443660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EM+ZpXg0gF/YjekvI/GGKZPQZmJkVX1r6GY58f54Us=;
        b=oD++kgemofruHfn+i1BndAm+ukfIRab8TLQCcV+x59cwuGGFiAk9uUuD4K+cxrNgJT
         HUk4nMkCRQE1cYkGS3e0YNE8tN7VlV0qFeBmJRPN1p+FmZSCXwbZucZ4yEz265sMqGOw
         5GyoOn47eXW4ZOCv/9lI1LCYLdiz9QQ6RlFoHZU3auT2NqJOvATrO2ycF57zjWPP+Vvm
         GGv/m2rtpxjI7N7jQ9H9SdhnOLpG15T64AdHs+eE/QAdnxaMkTVkrH0kheAtDcxqmcw6
         zQ7Exo1TOkZM6hAidXI1xRClE05g3Nbx4QwwXrMRZIIM5iARXso7lgikxeLP8MaD6qwL
         ZxTw==
X-Forwarded-Encrypted: i=1; AJvYcCVjp1XpgZReO2+Rn1Jr7JJj9ygV9pR/9SLig4fikspjwkdNO8dwQirQK/wHMZEpB1PGVZwayUNluYNyREGYCUmRbz6Cx2YvtWSeHj7Z
X-Gm-Message-State: AOJu0YwXk91PuF2elziFTtyLtb45LreFX2isATyt5LGFUqIkYnPMmMwg
	4EQjn/AP2nLDhdw6GeZA0sjBITctfA/yYxEZnQUUlBAU8AxdcQtsdGtPpoyyXg==
X-Google-Smtp-Source: AGHT+IGRhEir+wlPPgo0EeIMHbQAc+CssNsUlCHg2jKNK1SbGim7OTROv4D0aUO+HlGcU3hVo9zRjg==
X-Received: by 2002:a05:600c:4454:b0:426:68ce:c97a with SMTP id 5b1f17b1804b1-427f7c5c3b3mr1464825e9.7.1721838859742;
        Wed, 24 Jul 2024 09:34:19 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:7aec:12da:2527:71ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f92c7cb3sm37264285e9.0.2024.07.24.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:34:19 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jul 2024 18:34:12 +0200
Subject: [PATCH v2 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-kasan-tsbrcu-v2-1-45f898064468@google.com>
References: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
In-Reply-To: <20240724-kasan-tsbrcu-v2-0-45f898064468@google.com>
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

More importantly, a subsequent commit will want to use the object metadata
region to store an rcu_head, and we should let KASAN check that the object
pointer is valid before that. (Otherwise that change will make the existing
testcase kmem_cache_invalid_free fail.)

So add a new KASAN hook that allows KASAN to pre-validate a
kmem_cache_free() operation before SLUB actually starts modifying the
object or its metadata.

Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 10 ++++++++++
 mm/kasan/common.c     | 51 +++++++++++++++++++++++++++++++++++++++------------
 mm/slub.c             |  7 +++++++
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..eee8ca1dcb40 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -175,6 +175,16 @@ static __always_inline void * __must_check kasan_init_slab_obj(
 	return (void *)object;
 }
 
+bool __kasan_slab_pre_free(struct kmem_cache *s, void *object,
+			unsigned long ip);
+static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
+						void *object)
+{
+	if (kasan_enabled())
+		return __kasan_slab_pre_free(s, object, _RET_IP_);
+	return false;
+}
+
 bool __kasan_slab_free(struct kmem_cache *s, void *object,
 			unsigned long ip, bool init);
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 85e7c6b4575c..7c7fc6ce7eb7 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -208,31 +208,52 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
 	return (void *)object;
 }
 
-static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
-				      unsigned long ip, bool init)
+enum free_validation_result {
+	KASAN_FREE_IS_IGNORED,
+	KASAN_FREE_IS_VALID,
+	KASAN_FREE_IS_INVALID
+};
+
+static enum free_validation_result check_slab_free(struct kmem_cache *cache,
+						void *object, unsigned long ip)
 {
-	void *tagged_object;
+	void *tagged_object = object;
 
-	if (!kasan_arch_is_ready())
-		return false;
+	if (is_kfence_address(object) || !kasan_arch_is_ready())
+		return KASAN_FREE_IS_IGNORED;
 
-	tagged_object = object;
 	object = kasan_reset_tag(object);
 
 	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) != object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
-		return true;
+		return KASAN_FREE_IS_INVALID;
 	}
 
-	/* RCU slabs could be legally used after free within the RCU period. */
-	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
-		return false;
-
 	if (!kasan_byte_accessible(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
-		return true;
+		return KASAN_FREE_IS_INVALID;
 	}
 
+	return KASAN_FREE_IS_VALID;
+}
+
+static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
+				      unsigned long ip, bool init)
+{
+	void *tagged_object = object;
+	enum free_validation_result valid = check_slab_free(cache, object, ip);
+
+	if (valid == KASAN_FREE_IS_IGNORED)
+		return false;
+	if (valid == KASAN_FREE_IS_INVALID)
+		return true;
+
+	object = kasan_reset_tag(object);
+
+	/* RCU slabs could be legally used after free within the RCU period. */
+	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
+		return false;
+
 	kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZE),
 			KASAN_SLAB_FREE, init);
 
@@ -242,6 +263,12 @@ static inline bool poison_slab_object(struct kmem_cache *cache, void *object,
 	return false;
 }
 
+bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
+				unsigned long ip)
+{
+	return check_slab_free(cache, object, ip) == KASAN_FREE_IS_INVALID;
+}
+
 bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 				unsigned long ip, bool init)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..34724704c52d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2170,6 +2170,13 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
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

-- 
2.45.2.1089.g2a221341d9-goog



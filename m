Return-Path: <linux-kernel+bounces-262391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E5393C671
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22611C21BED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EB419D8A7;
	Thu, 25 Jul 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hT4U5d/b"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A921A04
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921533; cv=none; b=RCYfZgBGFvAFRlbNY25hT3eAGUxlGkxS9EIAFQLRWycF593Jq3H8S1Bi/GTZPuqqxnsCnZxi6q1/EO2x4OZuFXxFfJqL/dRfOB7sNbbyATMe1xXRxBYquUzOGDrgf/qSQ89Po1hVgDNcREKV432cwrjcHKp7U5a5css126HSMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921533; c=relaxed/simple;
	bh=+myUOgVQ6uycMHS3CS0UxqilbTRxxQ4jURMh0jyqy0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBOVkVVaejdxPO/WYxKerpCoOTPuvyxq6UAQAOeyz3WNUZTy4yNi/5wXSAfDNXFCChvvHFnoau6wCriL9yi48OtYNKvkvfiTJUePRM0GoiHU9kfjf5xrDwUWD90kdgDYlviYNu80PVdOKa5z49TfXjXmJ25unuxUadPrQfy+qaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hT4U5d/b; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso30455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721921530; x=1722526330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vTJQJdpFKknSoM6KqvVMqLh+KmmrksaVuFYJyrU9io=;
        b=hT4U5d/b9b5kfAXrSRor1CAKIiQ6P70XLWGyyJwVYYFObI9I5R9orI3FnqvDg9lOBh
         XkWlZzaEdmgApnOoP9JyrXphk73Ny2S9KWvyVoK3eeLaL4Bj5HSH547HXZi9a9cH5XdM
         omIoyl7KKQLxuAdyBUW+qH6zg1r+EHdF3MdVnOkQtYDDO3trsH8G2AxRF7nL4CU2twp6
         E2OfGy0qhPn90FlwUN8wFQvR8iHjaLzlEg5igw/1/7uX27cJ07jxpcJ3ivTEA3b3jqmz
         yGAyH1IC1yvYE11JMJ+Miyf6QA+ecuBNOk1o8WfeqwYBzZrY6eZHkNp9O6T2+eifp1oP
         68+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921530; x=1722526330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vTJQJdpFKknSoM6KqvVMqLh+KmmrksaVuFYJyrU9io=;
        b=YpTJcskEy9xa6Atol9u45/SAjbyoyrX2Y6kb4q6BVkGRgt+/cVzrtzyvsVBkzWeBbt
         aU4v76L1nRCQsxihO6sKEN7Tg8P5cZRwgvEQ2y36gDa9M6/VS2Axev1ADItifLCXx3j4
         hCI1PQg7xytdGrMncQHSIwNakzIlJrWo1XaI0KElZ4O/ZNKalRczXPAFvimxdn2PLZM0
         RcnADUIaJtltk1hwsdjfuZ24/HhH9whjkmCKctatyYh+VynVa7aJQjwcg4dH5lcuGcwD
         EatfZSJFiHS0CV1SrxKyHYAQ8R5Ah9Da3stXjPBV++6PwiW4Vjr0KRgFJX5tEkpAlnHW
         +V/w==
X-Forwarded-Encrypted: i=1; AJvYcCVvR5hxN5zYsUxuDlGM9xExCvZn4ooVJBj/CMVnseHrCITrwy8f9kZTjN08frjGQSPjxIGw0oLQOu0V5fZReufXzUA5Ws2JuR/PyTYi
X-Gm-Message-State: AOJu0YxY1aGXGJnvjTtxNIxJadXIZHnPXdbyaHyipXqBPWq4oS1jUmXD
	xDKv1oWzmUO60cM0XRE3BUdL296WRqMdNgUYvLI2unrIbxk7+W+myooRaqeVJOW3LlOR8dikoll
	wnnwudYc=
X-Google-Smtp-Source: AGHT+IHg46k8yFhhlKmxiau+po7slN/BdUQxlPTCCg1CDEGtwNC/AbIGdPn3T7W50rDLjeoJZ0IR/g==
X-Received: by 2002:a05:600c:5108:b0:426:62a2:dfc with SMTP id 5b1f17b1804b1-42804caec94mr1456125e9.5.1721921527673;
        Thu, 25 Jul 2024 08:32:07 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:8b71:b285:2625:c911])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e65a7sm83054705e9.33.2024.07.25.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:32:07 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jul 2024 17:31:34 +0200
Subject: [PATCH v3 1/2] kasan: catch invalid free before SLUB reinitializes
 the object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-kasan-tsbrcu-v3-1-51c92f8f1101@google.com>
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

Currently, when KASAN is combined with init-on-free behavior, the
initialization happens before KASAN's "invalid free" checks.

More importantly, a subsequent commit will want to use the object metadata
region to store an rcu_head, and we should let KASAN check that the object
pointer is valid before that. (Otherwise that change will make the existing
testcase kmem_cache_invalid_free fail.)

So add a new KASAN hook that allows KASAN to pre-validate a
kmem_cache_free() operation before SLUB actually starts modifying the
object or its metadata.

Acked-by: Vlastimil Babka <vbabka@suse.cz> #slub
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/kasan.h | 16 ++++++++++++++++
 mm/kasan/common.c     | 51 +++++++++++++++++++++++++++++++++++++++------------
 mm/slub.c             |  7 +++++++
 3 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 70d6a8f6e25d..ebd93c843e78 100644
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
@@ -371,6 +381,12 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
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



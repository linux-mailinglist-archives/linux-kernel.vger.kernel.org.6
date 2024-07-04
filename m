Return-Path: <linux-kernel+bounces-241151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACA927794
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABD9283A83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777D1AE87A;
	Thu,  4 Jul 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTZLy6Qx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A861A3BC5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101586; cv=none; b=DtfBfLsxCV5qJdNbJyEnFLHg4V/pVx50Zvqeexuz7U7RimEQFmUUXFIRgRYZXNMXtrZK27Hp+N2gjKYmW8N62UZN3AkWJwT6IAvYdzJe8uF85x9sQQgk2oXrMO+tLTgp4d1HV1XZvwcpTRKqU/tv+dQalGyjJAyH1X8t1s6QrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101586; c=relaxed/simple;
	bh=jJpKvMzKe1sB481o8pdT2BZ3KwviXgpzUqZNHuSnBIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EiwhJbqv2MTehQxWdf66OJDT5I0bbqvtdfoDFnSLeKTpQQsl3C/XLMCjd10NY6bFJU3GO76c7kuafZvCQIJmsK7Yp3BPyd++rGhuNvHpJXz1/VyDA528zIQh5lIy7oHkGeHGCSNUv2HiTIyYTevBY/wDoKXmmV5swEyf2f0rCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTZLy6Qx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-652c6e92147so11726487b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720101584; x=1720706384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LAtQdKc3DWjogtnJ0IRwxqFJsxK6c7FwoZ+WvIyW3Xo=;
        b=CTZLy6QxzyAH5K8HD7f0SBZ/1kgu+ImyboaHJTRE/Iw/ZGW7GK9TXt+Lczx+Kq8cXX
         VPBE/dcv1tW4D7XP9W2ppOfaECDvKOWP8Ziv0o3a3+/1HzagBBlqsv0UUgsqHQvRyR0m
         81b3uuxo3m3lZZA47Qq50/BqUG6cSTRCXIUNaVslCrZeyz8KdASyWqEfzFowHsxEqPzR
         DA1Yp2+UnlkpmIUlz1pv9OM7+P7of0nOx9HV4qUSbZVoHeL4VHDo5Xa2/KUZFVHTK4Pe
         /b69fGELKQPKdH2n7JWmDevZeH3XUnOckxusG6Q288fmbgOze+ln2hTdlw8wgHjzndXQ
         pECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101584; x=1720706384;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LAtQdKc3DWjogtnJ0IRwxqFJsxK6c7FwoZ+WvIyW3Xo=;
        b=m9aRjcGmlmXCFwI7qRNj9TUayuCZPS+PqmXmIKU/z9ai6lCxNAJcFIN3vcFwf4Muqk
         6qitlYQIGwcsbZGGXBYcED80JyWvMp0f1LqQLd0fOD7o5g0aEcTmnCQggHEUMwiqcWJK
         37bwc7GtpBkD5HT3sqqhAA0yQdVxN4Y6FQhsqn/wR9eMLluQI7ODAf0jBSjJ/pEtOl45
         E0C12mePkHEinDMsmywjwg0NgDqhxIMuGg7HfveYJpgNNbyHRDyCp8v3kRAgXh8xQhnF
         kkDBTQmQigCpjRpltb/Ap6/xgckSrRU0alQYU/mIrghgZKmPy3nyRlVbbSiCRZkWBIuo
         zOKA==
X-Forwarded-Encrypted: i=1; AJvYcCVeYx/m/xKinlLj4U/c9fOrBGOdTCN4PZs2unBW5hwMPKIF8VI61AM69ATycpR6sG5Lqv3Gta8PBzPRiaJlhgACjNnq0Hc7PAHO/nxV
X-Gm-Message-State: AOJu0Yxx5pLvAHP6WAJRAfGuUPenIQbTd/HvpdZVXk7buYD4F1Uhxfay
	cQVTdVrUcZXVFnL2ugTFqyMRtKvb7ADf06LfvpojPWVffnjEqP5U0nMk3uSWL9zKozV1NCUZR9G
	Peg==
X-Google-Smtp-Source: AGHT+IHKp+9v7/1jkX7RG5nnKgjFqzydqFYM1oxQOc7v96Ao5/MWhucQyLSdycDsJ6Fj0xxeXCWOwAFBRvc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f773:f667:425:1c44])
 (user=surenb job=sendgmr) by 2002:a81:84ca:0:b0:64a:bd29:c5cf with SMTP id
 00721157ae682-652d572cf58mr79517b3.1.1720101583822; Thu, 04 Jul 2024 06:59:43
 -0700 (PDT)
Date: Thu,  4 Jul 2024 06:59:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240704135941.1145038-1-surenb@google.com>
Subject: [PATCH v2 1/1] mm, slab: move allocation tagging code in the alloc
 path into a hook
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: vbabka@suse.cz, kent.overstreet@linux.dev, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Move allocation tagging specific code in the allocation path into
alloc_tagging_slab_alloc_hook, similar to how freeing path uses
alloc_tagging_slab_free_hook. No functional changes, just code
cleanup.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]
- Moved entire profiling code portion from the slab_post_alloc_hook into
alloc_tagging_slab_alloc_hook, per Vlastimil Babka
- Moved alloc_tagging_slab_free_hook out of CONFIG_SLAB_OBJ_EXT section
and into CONFIG_MEM_ALLOC_PROFILING one, per Vlastimil Babka

[1] https://lore.kernel.org/all/20240703015354.3370503-1-surenb@google.com/

 mm/slub.c | 86 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..98c47ad7ceba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2033,11 +2033,54 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
 }
 
+#else /* CONFIG_SLAB_OBJ_EXT */
+
+static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			       gfp_t gfp, bool new_slab)
+{
+	return 0;
+}
+
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+}
+
+static inline bool need_slab_obj_ext(void)
+{
+	return false;
+}
+
+static inline struct slabobj_ext *
+prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void
+alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
+{
+	if (need_slab_obj_ext()) {
+		struct slabobj_ext *obj_exts;
+
+		obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
+		/*
+		 * Currently obj_exts is used only for allocation profiling.
+		 * If other users appear then mem_alloc_profiling_enabled()
+		 * check should be added before alloc_tag_add().
+		 */
+		if (likely(obj_exts))
+			alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	}
+}
+
 static inline void
 alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			     int objects)
 {
-#ifdef CONFIG_MEM_ALLOC_PROFILING
 	struct slabobj_ext *obj_exts;
 	int i;
 
@@ -2053,30 +2096,13 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 		alloc_tag_sub(&obj_exts[off].ref, s->size);
 	}
-#endif
-}
-
-#else /* CONFIG_SLAB_OBJ_EXT */
-
-static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-			       gfp_t gfp, bool new_slab)
-{
-	return 0;
-}
-
-static inline void free_slab_obj_exts(struct slab *slab)
-{
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
+#else /* CONFIG_MEM_ALLOC_PROFILING */
 
-static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+static inline void
+alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	return NULL;
 }
 
 static inline void
@@ -2085,7 +2111,8 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 {
 }
 
-#endif /* CONFIG_SLAB_OBJ_EXT */
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 
 #ifdef CONFIG_MEMCG_KMEM
 
@@ -3944,20 +3971,7 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
-#ifdef CONFIG_MEM_ALLOC_PROFILING
-		if (need_slab_obj_ext()) {
-			struct slabobj_ext *obj_exts;
-
-			obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
-			/*
-			 * Currently obj_exts is used only for allocation profiling.
-			 * If other users appear then mem_alloc_profiling_enabled()
-			 * check should be added before alloc_tag_add().
-			 */
-			if (likely(obj_exts))
-				alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
-		}
-#endif
+		alloc_tagging_slab_alloc_hook(s, p[i], flags);
 	}
 
 	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);

base-commit: 795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19
-- 
2.45.2.803.g4e1b14247a-goog



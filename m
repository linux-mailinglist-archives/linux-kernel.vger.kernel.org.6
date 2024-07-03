Return-Path: <linux-kernel+bounces-238644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB938924D55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CBE284243
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882F1FAA;
	Wed,  3 Jul 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/KS0MCJ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60F39B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971640; cv=none; b=Bv+gTboHH0VAtKg8vSvOPf6B1LgArPugs9xwlv4IUO8M6Q6N9Hm+Al25cxSyOvyytUwb2C3WqqZ1zmxTUkjHD/kJnkDfcUJWS6htJnFQh9W8n3CFsnHCVZh32kU+fJjux4d31xOlcgevklPCURF7aUdSXVsJe0y0MArSJMCny38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971640; c=relaxed/simple;
	bh=WKXjU/JnO22SnzcW0mGnYiyMafbvjt4FbqoimT7d29Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WT210e1yhK//CwWwo15VD3Chz2U58mWPHcxhU1t102V8s2briO0VE8etmRdQ0YRc697W7p7rYYuxb+YWE+3rmo1XrZlYu+lhhfYNcVzLOvtweiRN4QEIKrbBow2ZvhPQhGoHUZHK7xRoLhuzhQauCbKVtDWBuuoJX+1na6r1izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/KS0MCJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7b5976so292248276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 18:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719971638; x=1720576438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4BVLSgqw94eTxc2ajevJhP5Tdjoc+6UHkyHk7q4GUNA=;
        b=0/KS0MCJg5IVYTpidN7x1TUqxbCWDoTwxYoLOg3HHh+KrKgtdE2iPkPCvW4zHPT1Up
         hZ4xp/4Wxv6hztl17qb/WInKjkbZXsiGPyYaOPK1vc//4uRYc2bSbCcLnGXDjNqdrzjt
         gvmTM/zkcB7KlnG7Fv/6x+TB8ZXsRy5ZoLZd6/FRKxj5LCgq4J/h8EfAaqsABEnm8p0h
         gxFeBToEmLotRW/JS43b0yNgcCwIlbui4LovIc3qmc6pTf/R7SiiKyD5rP8uE6mKTxf+
         DXQ6c7Lmw5JDxzYjdPl3BArJGFdctP72Ckilin9JuBe1G8J8yXB+ClfuQwI9hP+lnP4X
         GKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719971638; x=1720576438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BVLSgqw94eTxc2ajevJhP5Tdjoc+6UHkyHk7q4GUNA=;
        b=FmwFRS1Kd7CqyPeQoEsX4XO9IhbykZfgYDRWmbvRofeWwT9FqxKPLRtYwyJN7LOMLr
         kY7JqVdzBJi5DdLvO/LFzH06mOzTx5s2b9XCr8uLH7DBQxZVr8R3LFZsy5igr65k9/B4
         6PXV08psGGp7qg6uj4IvjVYXUGe6DoSfcvRDKKeemvdskjFpu4GFFTwTz6hi8y0nGM+O
         kTRtDkgpi9VGUOUL/jwV7IIewYiv/dFrksUgx+WRZnlAFXs84vhu4ORdJ/zwKuJpHwYB
         CxOioawMEjUeMjJ1NLx8yIzj7LKreCX6AWHZ3RAz7UriL05jp6qxWGaBIjLBPIdZcW2f
         9FoA==
X-Forwarded-Encrypted: i=1; AJvYcCWdKxTvdazkXknUD6Re0G814UGdoJQSNR0mQ1MW7SbERdUfOALEOTb6Yql8tQ7xjLA0gUei1IwoNC73X/I+aaXlUS3fqGQYPWRm9CP7
X-Gm-Message-State: AOJu0Yyx6P87/qrRsBjOLgqJYHhb+yPaAyRun5utm4gTdhaV8cvfYckT
	hzGFLzF+448FjN3TShPxZIFz+x/L7AU+IjexTf6nXHYQ2pd0llqlyt6jydP/LdEYIRiX+gW6h+t
	Z3A==
X-Google-Smtp-Source: AGHT+IEeZbkreIAhFbscB4qIouzrsQvPZrbQM5suKCIYA5b5GLlh+nCoMvlGLTKiL6KPIeANce5Idc9gJMc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:857f:8d15:eb07:82ef])
 (user=surenb job=sendgmr) by 2002:a05:6902:2b89:b0:dfd:da3f:ad1c with SMTP id
 3f1490d57ef6-e03ad92b77fmr20518276.4.1719971638333; Tue, 02 Jul 2024 18:53:58
 -0700 (PDT)
Date: Tue,  2 Jul 2024 18:53:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703015354.3370503-1-surenb@google.com>
Subject: [PATCH 1/1] mm, slab: move allocation tagging code in the alloc path
 into a hook
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
 mm/slub.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..99d53190cfcf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2033,11 +2033,18 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
 }
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
+static inline void
+alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
+{
+	alloc_tag_add(&obj_exts->ref, current->alloc_tag, size);
+}
+
 static inline void
 alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			     int objects)
 {
-#ifdef CONFIG_MEM_ALLOC_PROFILING
 	struct slabobj_ext *obj_exts;
 	int i;
 
@@ -2053,9 +2060,23 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 		alloc_tag_sub(&obj_exts[off].ref, s->size);
 	}
-#endif
 }
 
+#else /* CONFIG_MEM_ALLOC_PROFILING */
+
+static inline void
+alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
+{
+}
+
+static inline void
+alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
+			     int objects)
+{
+}
+
+#endif /* CONFIG_MEM_ALLOC_PROFILING*/
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -2079,6 +2100,11 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	return NULL;
 }
 
+static inline void
+alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned int size)
+{
+}
+
 static inline void
 alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			     int objects)
@@ -3944,7 +3970,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
-#ifdef CONFIG_MEM_ALLOC_PROFILING
 		if (need_slab_obj_ext()) {
 			struct slabobj_ext *obj_exts;
 
@@ -3955,9 +3980,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			 * check should be added before alloc_tag_add().
 			 */
 			if (likely(obj_exts))
-				alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+				alloc_tagging_slab_alloc_hook(obj_exts, s->size);
 		}
-#endif
 	}
 
 	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);

base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
-- 
2.45.2.803.g4e1b14247a-goog



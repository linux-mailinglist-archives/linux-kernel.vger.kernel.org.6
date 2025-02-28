Return-Path: <linux-kernel+bounces-539163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A211A4A1A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7763E17630B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2781F875A;
	Fri, 28 Feb 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG2b8n+W"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA91F872F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767411; cv=none; b=no9rWLtw6idK5jsqzrdhNZ7iN0daj5O/6NjMUGGLoFJaHZDJN5LIf3dL9diETplP5R1szDoxYG/2KCO9lHNOPYWloyD3aqWazs/LSg0lyT2L3wzsR+z6Jn46NPNKVJ+4KxT4QD6Bnjolafa0v8WrvD/N6K3O7JtiDa9sLJwW8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767411; c=relaxed/simple;
	bh=RyF3/gTbP5gy6tuXi9ooiaMUqPGl0EAWhimbDy1EXjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=go0+XOt+Hly1ibe8eqOzV+sqA3JJaCy3u+uXw8Cry0Wau+IShw3BuESavIwhZ69qH89Il8PDiMwC5NOK86MeAHmMy9xC9b6ngFkRR2uZr5xqpT7i3TKyngs0S3x9iHfizUEGQ633pci3iKxEMk/27m3evwBr2YIA7e6+HxqgXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HG2b8n+W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22349ce68a9so77545315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767409; x=1741372209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K94kLlqGeFQ+aFx16P/h3vYpIISWhF2cF1hUz7z5Syk=;
        b=HG2b8n+WgPyWg9HS0peyJSkkGtJ6PhrA/iVIcGA1Iu5PPOuS/xsBm9Tvs7yktzEEjl
         LxusfyeZ4eWwDToaK+cKSxA+ujgc8QZduE1euoKkqp4ZZwp0QwtrLGSJLyhq3iX5+PEQ
         CaeOeh6hup0UvrzuwlgMyLaybKyMhvzCNCe3/8OpHtZw6omV23760b5gXaraF5AJroX0
         U7ZsiP7yYxQu98j9XUuSYwasnTb1t3cS4M88L7jbHHs14wjCHLhe+/t+dXuQjrUi5PBZ
         R1HvKHtZzvTmuFX5QR8CzAuFzJBm8mrQHOGdxUv5mBMTzwBbXmsOpeUbDDusKXPpqh73
         nviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767409; x=1741372209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K94kLlqGeFQ+aFx16P/h3vYpIISWhF2cF1hUz7z5Syk=;
        b=VDhwITnc8JcyioL7RkoFKukE/NhlkofiUpZTtf1331STdf4WoriYJlA8Yi4CCTrhKT
         sN29b34NprO2HRE/KuEVTaeC7WBqat+ce2y4dgrzWnuxpYql/OzyWrGpW6Ja9AwSg7ME
         riaG0Dq4K6BCjNWfm78HMPyDyqCRVIYzpOLThVNnqpA73FkElO2iLIFcZc1ndvs2d6vC
         C0041S+hfmsQkJ3oWcCgShojhyaJQxtgOdc5Aw4mmlH+ISo0PvgZussk6wgvAnYopCmz
         6rHnHIhBQPQhdhNIC08JLRKzmQTclTTw1jU36+lUjPbRwsOjWoEQxZWazxrtk6+PsInV
         hNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE4nlF0bS0G1edWGbIe6TmUVi0hg+NrVPTWkTxWY6UfnJmE6TeYJgpEdmHycBRtz7Lv0s9u3P8sqa030Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6/aM6Ybe/hZmo+gyf1oZBntTswMmKjlXKmC9laryEczxIJ5e
	9PvU/Ar0v7KLa/Hxuf/QevvJTqbDXhFHFGZLp5QyZKCKT3i+JM3nOYPC0PhOMsp5FBzZQg==
X-Google-Smtp-Source: AGHT+IFDWi4N9QdQQBBc9RlXjvM6dqwf/CPH36DP/o8uLrYBQ+/2fZBTUs+cvUB/toGJpVVERB85nZsx
X-Received: from pjur16.prod.google.com ([2002:a17:90a:d410:b0:2fa:1fac:269c])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e750:b0:21f:ba96:5de9
 with SMTP id d9443c01a7336-2236926f502mr89499265ad.49.1740767408967; Fri, 28
 Feb 2025 10:30:08 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:13 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-13-fvdl@google.com>
Subject: [PATCH v5 12/27] mm: define __init_reserved_page_zone function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Sometimes page structs must be unconditionally initialized
as reserved, regardless of DEFERRED_STRUCT_PAGE_INIT.

Define a function, __init_reserved_page_zone, containing
code that already did all of the work in init_reserved_page,
and make it available for use.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/internal.h |  1 +
 mm/mm_init.c  | 38 +++++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..57662141930e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1448,6 +1448,7 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
+void __meminit __init_reserved_page_zone(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9f1e41c3dde6..925ed6564572 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -650,6 +650,28 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+/*
+ * Initialize a reserved page unconditionally, finding its zone first.
+ */
+void __meminit __init_reserved_page_zone(unsigned long pfn, int nid)
+{
+	pg_data_t *pgdat;
+	int zid;
+
+	pgdat = NODE_DATA(nid);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
+
+		if (zone_spans_pfn(zone, pfn))
+			break;
+	}
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+
+	if (pageblock_aligned(pfn))
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 {
@@ -708,24 +730,10 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 
 static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
-	pg_data_t *pgdat;
-	int zid;
-
 	if (early_page_initialised(pfn, nid))
 		return;
 
-	pgdat = NODE_DATA(nid);
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *zone = &pgdat->node_zones[zid];
-
-		if (zone_spans_pfn(zone, pfn))
-			break;
-	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-
-	if (pageblock_aligned(pfn))
-		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+	__init_reserved_page_zone(pfn, nid);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
-- 
2.48.1.711.g2feabab25a-goog



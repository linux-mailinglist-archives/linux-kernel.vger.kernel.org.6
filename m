Return-Path: <linux-kernel+bounces-382875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7D9B1454
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E255283426
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C213D2B2;
	Sat, 26 Oct 2024 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF+bKFUD"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2B320F
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729913792; cv=none; b=C8fpBwk9XmjnlPG5XIlxFiILPWQ2eriaHZIO2zVgkKk1Pe86EZ8qLlOBxn0gQF/dWkQ3rZiaQ5h7OvIYqnTV2M3Q2Ivogrh/uR4Iu4+4U1gRzFmczPFAm5MFRPOhnPmXBKUFAkju9Qjfp0fETPEsGNHZJwNGU+CojSqr8pXiSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729913792; c=relaxed/simple;
	bh=EWx6NdqB/KNaEbwzWBBuJAmpa6v3YZnvTzumDswBMHo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JWEXvR5fTlUVBRM5DotHNtB2cKRK7GnK67Vid9qQ7mTmUuk6SV3TgqBl+dtzk+1zlxNQwOGrQh22lhRL0KjXp6leJowURiVMmIXKMcgvjVa1frcXQ34iTMW8JaZ3U+K1dHzAYctqjTxZVNWvJgW894oyEjHMyRcPP4nIfEaIh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF+bKFUD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so41368677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729913790; x=1730518590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zJvo8rQelVugAeNPiMO8n98xYiD6Va85kwZA/R+E8fA=;
        b=lF+bKFUDBrxzSH/0UpqoQoDf2mbmTNcLiBLbNfSQNXizBjtoxl/zKuXtWtSAK7/ibK
         gMlWOX5zBWpC/wz55/+Or4Oz0uG+tnZVKnyEqpBlFnAV5W80pUQCwOnKKnepkPndXMvL
         5uE2JUImzGbEi6pAN51b6z9r3yhWHXwSww6ZfIn77+7kiXxgUly4V+AdarMOz7SxzF83
         J8W3an6NIyIDldZOZZsc3ygI9ulPjKR3C3S3qQ7aoyXpVM4k1sPkfBvD4abKTCjSQghl
         NhIZdlD0j+yuTydprxUDP/ZGPmfR0M+EfykMG1Yfc4WpETdjBlw5dy6Iu53lsevfvXII
         5QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729913790; x=1730518590;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJvo8rQelVugAeNPiMO8n98xYiD6Va85kwZA/R+E8fA=;
        b=YIDAkFp2B973jZ69ZO9u8/oN+S9swL7O9AWZ0y7yTfsTIU6FbzpoKv7Zuz27oKh/YN
         C0SvP/hBJaNegoXLi5TciU3c0AXzsiYYasEcOTK2ehczyTQrj1kPPPAdw/VPdIV+DDcy
         O5i5CKUFGKejRipJfLDtM2FIB00ym/7DMG8FCFi989/sqorWd0Vp+t1O2s/le/aFRQ4V
         O3342w8IorzjKSl0yj/sUALHUS9YAG0Pm+RsZuxQ6XuNsFxrwhtCowcA74I8wlt1Kh8p
         ygAlWZ+F2IKRtT5h5H+Gt03jVV8jhcHhXFLSMFUvQ+rbqIxkUGnpNamPgiFbusPmXOhd
         fZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/nnB55gxXXv3IvP0JfnFueeUjqHHzvKgiHOgs9hew7wg5af+fChJJFimoVNcDkzzLcfDT4dpda2YUEec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HR7XYRJEPyx2mCGDSUtdpmbAT49iEXmgKT+vBEM2SjESC1jw
	llqKRT5cm2gfeInJrjIulbcMoiI1IJMMLdDV4+4+QRxYk3aOFWQ9YA3hhm0PNXWrUK6xNJkwFS1
	dkg==
X-Google-Smtp-Source: AGHT+IFjF2xbY+QdTNq0yXUWw8dhcTHCSRZ/2q1qhW0aC06XSt+a7yPkzdJRVZQVGegp4OdYmAxx4N97DDE=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:94d3:b09:4b32:5539])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:1822:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e308784a6eamr1084276.1.1729913789367; Fri, 25 Oct 2024 20:36:29
 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:36:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241026033625.2237102-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2] mm/page_alloc: keep track of free highatomic
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"

OOM kills due to vastly overestimated free highatomic reserves were
observed:

  ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
  Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
  Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB

The second line above shows that the OOM kill was due to the following
condition:

  free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)

And the third line shows there were no free pages in any
MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
'H'. Therefore __zone_watermark_unusable_free() underestimated the
usable free memory by over 1GB, which resulted in the unnecessary OOM
kill above.

The comments in __zone_watermark_unusable_free() warns about the
potential risk, i.e.,

  If the caller does not have rights to reserves below the min
  watermark then subtract the high-atomic reserves. This will
  over-estimate the size of the atomic reserve but it avoids a search.

However, it is possible to keep track of free pages in reserved
highatomic pageblocks with a new per-zone counter nr_free_highatomic
protected by the zone lock, to avoid a search when calculating the
usable free memory. And the cost would be minimal, i.e., simple
arithmetics in the highatomic alloc/free/move paths.

Reported-by: Link Lin <linkl@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 2e8c4307c728..5e8f567753bd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -825,6 +825,7 @@ struct zone {
 	unsigned long watermark_boost;
 
 	unsigned long nr_reserved_highatomic;
+	unsigned long nr_free_highatomic;
 
 	/*
 	 * We don't know if the memory that we're going to allocate will be
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c81762c49b00..43ecc7d75a2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -644,6 +644,18 @@ static inline void account_freepages(struct zone *zone, int nr_pages,
 		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
 }
 
+static void account_highatomic_freepages(struct zone *zone, unsigned int order,
+					 int old_mt, int new_mt)
+{
+	int delta = 1 << order;
+
+	if (is_migrate_highatomic(old_mt))
+		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic - delta);
+
+	if (is_migrate_highatomic(new_mt))
+		WRITE_ONCE(zone->nr_free_highatomic, zone->nr_free_highatomic + delta);
+}
+
 /* Used for pages not on another list */
 static inline void __add_to_free_list(struct page *page, struct zone *zone,
 				      unsigned int order, int migratetype,
@@ -660,6 +672,8 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 	else
 		list_add(&page->buddy_list, &area->free_list[migratetype]);
 	area->nr_free++;
+
+	account_highatomic_freepages(zone, order, -1, migratetype);
 }
 
 /*
@@ -681,6 +695,8 @@ static inline void move_to_free_list(struct page *page, struct zone *zone,
 
 	account_freepages(zone, -(1 << order), old_mt);
 	account_freepages(zone, 1 << order, new_mt);
+
+	account_highatomic_freepages(zone, order, old_mt, new_mt);
 }
 
 static inline void __del_page_from_free_list(struct page *page, struct zone *zone,
@@ -698,6 +714,8 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
 	__ClearPageBuddy(page);
 	set_page_private(page, 0);
 	zone->free_area[order].nr_free--;
+
+	account_highatomic_freepages(zone, order, migratetype, -1);
 }
 
 static inline void del_page_from_free_list(struct page *page, struct zone *zone,
@@ -3119,11 +3137,10 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 
 	/*
 	 * If the caller does not have rights to reserves below the min
-	 * watermark then subtract the high-atomic reserves. This will
-	 * over-estimate the size of the atomic reserve but it avoids a search.
+	 * watermark then subtract the free pages reserved for highatomic.
 	 */
 	if (likely(!(alloc_flags & ALLOC_RESERVES)))
-		unusable_free += z->nr_reserved_highatomic;
+		unusable_free += READ_ONCE(z->nr_free_highatomic);
 
 #ifdef CONFIG_CMA
 	/* If allocation can't use CMA areas don't use free CMA pages */
-- 
2.47.0.163.g1226f6d8fa-goog



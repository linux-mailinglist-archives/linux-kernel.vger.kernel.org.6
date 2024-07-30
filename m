Return-Path: <linux-kernel+bounces-268295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E2E9422EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AD92864CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A75B192B98;
	Tue, 30 Jul 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki4YRieV"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25238190489
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378432; cv=none; b=ayz4K7IKEgDCc8ymHwMGMhUfjYydGpRqzmiYDjcHxR1zyQJ3apcGQI3ZKArMldRMVorgoQ+EdE+b7i/k858xbXxjD2evv/q7ka1guijDzs303DPTqJjRS7Rni+nyMdEoJyEsbiZUOrOIM1BUFWAoP4KfjMPcNj/l8xWhWs4cc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378432; c=relaxed/simple;
	bh=Jtyy/XoalVhbLBoZCK5niVApYZGmKErG13L62RLyiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWUGI6nFdUgqIYwz66zHN2XOL1qqqGluoBn2RUCpQshaPXOJ7Mf1OZWysJhBS1UAMtfW8ur+CO3n9CU/VuIYFot/0K3BVWUjI9DCJjq74DrWEgRjoVn/F0QbMD52ousQ+REGHyrO+Potnj6u3bk0xekAHjD/rZ/REgr2hRNJd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki4YRieV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-66a1842b452so29414557b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378429; x=1722983229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmEtv+cmst1vzae8Xa5+9ouwhHcSggBfq4aRXyVWgVA=;
        b=ki4YRieVm9x6Enh0KnlaDf4QvHO6dunVi/afWUM247kginVNeD41Mi7z3Vn3uK3tW1
         /YaNIngcSQCu0AaaeXwyjZYVVqVes5YmmW3lJJ8j4nL1SZSyMby/jX2FG6ICKLTLmE4d
         A5WV59Qv8Pj34xhT07AD/BTnBXvLJjEEfBNy0b7CTuqNR9dcKDmuvFGhbJQcIIyAj6Ke
         ANm6fbxYtnBl5mDRdDBOUOQASi0jJniNF3bAA8gTNQgJNRaOr0+VIFzsWS9Nejh/2CW3
         QGlEkbRNDwltKui+wjvAZFjWoLBw90Kgw+tIp598YPaDn1axLmyPVPBDPJTqyJQXhI32
         QgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378429; x=1722983229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmEtv+cmst1vzae8Xa5+9ouwhHcSggBfq4aRXyVWgVA=;
        b=iK+UcJyT1GFywukdQjk3rQy2Yt6XdQCCGyvJXlEpDfAamYA9y6a3TmQLD01DtYgpTH
         Jv2qT95buTwyeNrc+ituSbxpJ+2hXydffITdYVKoyShfd/N3DAsp/ZseUi3KNXnpR3MO
         iVtmakT81U2GzSQzyIUnoCcgavdf+bzDFm0S1bxdiO3Bp5z3z1dgBABhwZbZ6JH8aShU
         DcLAwQQoQeho8GtOzXimadbH5yb3wbF1S0OAy1sUsdIkS6MaLdS5PZ1tOWF2aAzryzVU
         46TsSoIohpCS2Cb5cgLuwk+tAxgP6Lssk2ZzSHEIwDeV5QVPsPW6gVb8Xw7DYChFtf3/
         qulw==
X-Forwarded-Encrypted: i=1; AJvYcCWwiXPipSidajWdK+W+K8HLWWET8g2eSNh9X+tkyCcfiDS9Cf/jXhoyselcbgMSVzpyfmf0NEgz7qrL/A07CSQ9/mACa1spskcmuJhR
X-Gm-Message-State: AOJu0YyuL+mWcqfrlos6gYpG3CFcYpUFg4FAaGc1zb7djEf1E87YWJdt
	NNwY5K11G33AA3fTj7ZayStL0BCO+N0E3ESL6M028XfgLz8RWErv
X-Google-Smtp-Source: AGHT+IFJpsFUe9mM5BsvjhMWkYvyxBRomAGh1+/0eSiMUyMc4x53nf4TjFLhJ6bAHDckIOx16kCBKg==
X-Received: by 2002:a05:690c:6c8c:b0:65f:ca2a:9d77 with SMTP id 00721157ae682-67a09783e65mr135573007b3.36.1722378428943;
        Tue, 30 Jul 2024 15:27:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e799sm27449417b3.36.2024.07.30.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:27:08 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v2 1/2] zswap: implement a second chance algorithm for dynamic zswap shrinker
Date: Tue, 30 Jul 2024 15:27:06 -0700
Message-ID: <20240730222707.2324536-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730222707.2324536-1-nphamcs@gmail.com>
References: <20240730222707.2324536-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current zswap shrinker's heuristics to prevent overshrinking is brittle
and inaccurate, specifically in the way we decay the protection size
(i.e making pages in the zswap LRU eligible for reclaim).

We currently decay protection aggressively in zswap_lru_add() calls.
This leads to the following unfortunate effect: when a new batch of
pages enter zswap, the protection size rapidly decays to below 25% of
the zswap LRU size, which is way too low.

We have observed this effect in production, when experimenting with the
zswap shrinker: the rate of shrinking shoots up massively right after a
new batch of zswap stores. This is somewhat the opposite of what we want
originally - when new pages enter zswap, we want to protect both these
new pages AND the pages that are already protected in the zswap LRU.

Replace existing heuristics with a second chance algorithm

1. When a new zswap entry is stored in the zswap pool, its reference bit
   is set.
2. When the zswap shrinker encounters a zswap entry with the reference
   bit set, give it a second chance - only flips the reference bit and
   rotate it in the LRU.
3. If the shrinker encounters the entry again, this time with its
   reference bit unset, then it can reclaim the entry.

In this manner, the aging of the pages in the zswap LRUs are decoupled
from zswap stores, and picks up the pace with increasing memory pressure
(which is what we want).

The second chance scheme allows us to modulate the writeback rate based
on recent pool activities. Entries that recently entered the pool will
be protected, so if the pool is dominated by such entries the writeback
rate will reduce proportionally, protecting the workload's workingset.On
the other hand, stale entries will be written back quickly, which
increases the effective writeback rate.

We will still maintain the count of swapins, which is consumed and
subtracted from the lru size in zswap_shrinker_count(), to further
penalize past overshrinking that led to disk swapins. The idea is that
had we considered this many more pages in the LRU active/protected, they
would not have been written back and we would not have had to swapped
them in.

To test this new heuristics, I built the kernel under a cgroup with
memory.max set to 2G, on a host with 36 cores:

With the old shrinker:

real: 263.89s
user: 4318.11s
sys: 673.29s
swapins: 227300.5

With the second chance algorithm:

real: 244.85s
user: 4327.22s
sys: 664.39s
swapins: 94663

(average over 5 runs)

We observe an 1.3% reduction in kernel CPU usage, and around 7.2%
reduction in real time. Note that the number of swapped in pages
dropped by 58%.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/zswap.h |  16 +++---
 mm/zswap.c            | 110 ++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 6cecb4a4f68b..b94b6ae262d5 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -13,17 +13,15 @@ extern atomic_t zswap_stored_pages;
 
 struct zswap_lruvec_state {
 	/*
-	 * Number of pages in zswap that should be protected from the shrinker.
-	 * This number is an estimate of the following counts:
+	 * Number of swapped in pages, i.e not found in the zswap pool.
 	 *
-	 * a) Recent page faults.
-	 * b) Recent insertion to the zswap LRU. This includes new zswap stores,
-	 *    as well as recent zswap LRU rotations.
-	 *
-	 * These pages are likely to be warm, and might incur IO if the are written
-	 * to swap.
+	 * This is consumed and subtracted from the lru size in
+	 * zswap_shrinker_count() to penalize past overshrinking that led to disk
+	 * swapins. The idea is that had we considered this many more pages in the
+	 * LRU active/protected and not written them back, we would not have had to
+	 * swapped them in.
 	 */
-	atomic_long_t nr_zswap_protected;
+	atomic_long_t nr_swapins;
 };
 
 unsigned long zswap_total_pages(void);
diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..f4e001c9e7e0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -184,6 +184,10 @@ static struct shrinker *zswap_shrinker;
  * page within zswap.
  *
  * swpentry - associated swap entry, the offset indexes into the red-black tree
+ * referenced - true if the entry recently entered the zswap pool. Unset by the
+ *              dynamic shrinker. The entry is only reclaimed by the dynamic
+ *              shrinker if referenced is unset. See comments in the shrinker
+ *              section for context.
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
@@ -196,6 +200,7 @@ static struct shrinker *zswap_shrinker;
 struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
+	bool referenced;
 	struct zswap_pool *pool;
 	union {
 		unsigned long handle;
@@ -700,11 +705,10 @@ static inline int entry_to_nid(struct zswap_entry *entry)
 
 static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
-	atomic_long_t *nr_zswap_protected;
-	unsigned long lru_size, old, new;
 	int nid = entry_to_nid(entry);
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
+
+	entry->referenced = true;
 
 	/*
 	 * Note that it is safe to use rcu_read_lock() here, even in the face of
@@ -722,19 +726,6 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 	memcg = mem_cgroup_from_entry(entry);
 	/* will always succeed */
 	list_lru_add(list_lru, &entry->lru, nid, memcg);
-
-	/* Update the protection area */
-	lru_size = list_lru_count_one(list_lru, nid, memcg);
-	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
-	nr_zswap_protected = &lruvec->zswap_lruvec_state.nr_zswap_protected;
-	old = atomic_long_inc_return(nr_zswap_protected);
-	/*
-	 * Decay to avoid overflow and adapt to changing workloads.
-	 * This is based on LRU reclaim cost decaying heuristics.
-	 */
-	do {
-		new = old > lru_size / 4 ? old / 2 : old;
-	} while (!atomic_long_try_cmpxchg(nr_zswap_protected, &old, new));
 	rcu_read_unlock();
 }
 
@@ -752,7 +743,7 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 
 void zswap_lruvec_state_init(struct lruvec *lruvec)
 {
-	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_swapins, 0);
 }
 
 void zswap_folio_swapin(struct folio *folio)
@@ -761,7 +752,7 @@ void zswap_folio_swapin(struct folio *folio)
 
 	if (folio) {
 		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_swapins);
 	}
 }
 
@@ -1082,6 +1073,28 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 /*********************************
 * shrinker functions
 **********************************/
+/*
+ * The dynamic shrinker is modulated by the following factors:
+ *
+ * 1. Each zswap entry has a referenced bit, which the shrinker unsets (giving
+ *    the entry a second chance) before rotating it in the LRU list. If the
+ *    entry is considered again by the shrinker, with its referenced bit unset,
+ *    it is written back. The writeback rate as a result is dynamically
+ *    adjusted by the pool activities - if the pool is dominated by new entries
+ *    (i.e lots of recent zswapouts), these entries will be protected and
+ *    the writeback rate will slow down. On the other hand, if the pool has a
+ *    lot of stagnant entries, these entries will be reclaimed immediately,
+ *    effectively increasing the writeback rate.
+ *
+ * 2. Swapins counter: If we observe swapins, it is a sign that we are
+ *    overshrinking and should slow down. We maintain a swapins counter, which
+ *    is consumed and subtract from the number of eligible objects on the LRU
+ *    in zswap_shrinker_count().
+ *
+ * 3. Compression ratio. The better the workload compresses, the less gains we
+ *    can expect from writeback. We scale down the number of objects available
+ *    for reclaim by this ratio.
+ */
 static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
 				       spinlock_t *lock, void *arg)
 {
@@ -1091,6 +1104,16 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
 
+	/*
+	 * Second chance algorithm: if the entry has its referenced bit set, give it
+	 * a second chance. Only clear the referenced bit and rotate it in the
+	 * zswap's LRU list.
+	 */
+	if (entry->referenced) {
+		entry->referenced = false;
+		return LRU_ROTATE;
+	}
+
 	/*
 	 * As soon as we drop the LRU lock, the entry can be freed by
 	 * a concurrent invalidation. This means the following:
@@ -1157,8 +1180,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
-	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
-	unsigned long shrink_ret, nr_protected, lru_size;
+	unsigned long shrink_ret;
 	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
@@ -1167,25 +1189,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		return SHRINK_STOP;
 	}
 
-	nr_protected =
-		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	lru_size = list_lru_shrink_count(&zswap_list_lru, sc);
-
-	/*
-	 * Abort if we are shrinking into the protected region.
-	 *
-	 * This short-circuiting is necessary because if we have too many multiple
-	 * concurrent reclaimers getting the freeable zswap object counts at the
-	 * same time (before any of them made reasonable progress), the total
-	 * number of reclaimed objects might be more than the number of unprotected
-	 * objects (i.e the reclaimers will reclaim into the protected area of the
-	 * zswap LRU).
-	 */
-	if (nr_protected >= lru_size - sc->nr_to_scan) {
-		sc->nr_scanned = 0;
-		return SHRINK_STOP;
-	}
-
 	shrink_ret = list_lru_shrink_walk(&zswap_list_lru, sc, &shrink_memcg_cb,
 		&encountered_page_in_swapcache);
 
@@ -1200,7 +1203,8 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 {
 	struct mem_cgroup *memcg = sc->memcg;
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
-	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
+	atomic_long_t *nr_swapins = &lruvec->zswap_lruvec_state.nr_swapins;
+	unsigned long nr_backing, nr_stored, lru_size, nr_swapins_cur, nr_remain;
 
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
@@ -1233,14 +1237,26 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!nr_stored)
 		return 0;
 
-	nr_protected =
-		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	nr_freeable = list_lru_shrink_count(&zswap_list_lru, sc);
+	lru_size = list_lru_shrink_count(&zswap_list_lru, sc);
+	if (!lru_size)
+		return 0;
+
 	/*
-	 * Subtract the lru size by an estimate of the number of pages
-	 * that should be protected.
+	 * Subtract the lru size by the number of pages that are recently swapped
+	 * in. The idea is that had we protect the zswap's LRU by this amount of
+	 * pages, these swap in would not have happened.
 	 */
-	nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
+	nr_swapins_cur = atomic_long_read(nr_swapins);
+	do {
+		if (lru_size >= nr_swapins_cur)
+			nr_remain = 0;
+		else
+			nr_remain = nr_swapins_cur - lru_size;
+	} while (!atomic_long_try_cmpxchg(nr_swapins, &nr_swapins_cur, nr_remain));
+
+	lru_size -= nr_swapins_cur - nr_remain;
+	if (!lru_size)
+		return 0;
 
 	/*
 	 * Scale the number of freeable pages by the memory saving factor.
@@ -1253,7 +1269,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * space. Hence, we may scale nr_freeable down a little bit more than we
 	 * should if we have a lot of same-filled pages.
 	 */
-	return mult_frac(nr_freeable, nr_backing, nr_stored);
+	return mult_frac(lru_size, nr_backing, nr_stored);
 }
 
 static struct shrinker *zswap_alloc_shrinker(void)
-- 
2.43.0


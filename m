Return-Path: <linux-kernel+bounces-262719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA093CB3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F31F21ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED5149DE9;
	Thu, 25 Jul 2024 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNOjxrux"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF39143C7B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721950098; cv=none; b=VD4Pic6imQaXfSmf01N7bVrv8rBG/jpaUEDyfHK39mOYuVCrJf0J+Jdx+yoWsdQQh+hI7AWMCMglbegT/5o0oKsOjP5ihSmSzeE2exKW4QVs1/85iphHNZGB8AoATap1O+KQsqW+xkykMjkRq3lQV28DpEFNl87MzmbYTrPSfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721950098; c=relaxed/simple;
	bh=tc6Pz72YPu5HiVzxCNZ2gpSU/qIxRWZwI5SmZGMb13U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De4urvXXjXfX9W7nJzG1vk/ETd559GLYS9N/tcEFBSTeIGtMq4GQjd4zJDx0uVBGAjmUyqLoZ6baqH5COJ/GZKpV92NRknclKgYCr4Ad9u+rU8Od4lwynz43RNjfT77MNEiJOvDTiSjuw3I4AyK9QoTa/+47D82bcARti7oSfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNOjxrux; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0875778facso1450031276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721950095; x=1722554895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd0se0B6pAl9eKq3UU5NJWQZeWNQhxLBBm8PlHLbzE8=;
        b=FNOjxruxoa5ggkJyYaPq8P9nRZQXqL88HDW3IocU9GPhRwzMCqoXygnqK7+hcBrl52
         ylQp1xNSF6gkhGTslNhyDqaUIsx8K5rGeEiiUhi94CjoLVNE0B4Pukj7uhWnTm6p4vly
         aEAE4dk6+Cr3C446/Xic2mHtVBq80CVW99kfbiIgs4/ndT25KzEAF2wc6nCovYusRbKw
         MB/cn/61Bl+21r+tKde3jLgFE5ozKEYtYAK0TcafrOBBLyRIGUNaLrPfbD7xF0c10/r3
         SfLSXvqdgLO7kqbZ/fOv5498qzH9Ntof3x3nXS+Jy5mGdzl7iZ8y9d1l73BW8MgIvRk9
         Ihbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721950095; x=1722554895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd0se0B6pAl9eKq3UU5NJWQZeWNQhxLBBm8PlHLbzE8=;
        b=wdVlhanJRUTxhn58ZvjNL0owwjKOde9ogqQfsA0wCYtNgGM6NDbiRRDv5v/dvQJRvz
         uqQFxCAf2YI8j3xYyQKTjE18AXVWpabtqlU6hSQJKMfdFxG29rPIBLCE+3lqnIdgj3wm
         xlAZOZ1xZo7Lv7N2srtxEQiwVQ87IhrU4dt6r9yHeqTrTHE/BsC9LvYd8a2vnHKk0idX
         r6sveAOUVg3C9uAdug+VmxPPb7vuIVJqRyIpbdgpDEpkf8S1Ax2worhIiGMKVVtwQymq
         5ttbRM5X4OXOJHB+T7nMLUrQOdjA0cF6Z+DjPCUDgGuvW8oxDTrwXp8eyDdVk8Ne6bvx
         9bdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJQMMWT1ZeRqeZKt0PFy4GQRH2pnNePLCxh+LvrNAllYyi8XpiQ1epsyg0MAeFMva78UeNUmKwZyA+dPfkv68N9sK1KJe/1OqSW7A
X-Gm-Message-State: AOJu0YwSSl21Tj3McUPeHS1a8AoxIn5n//e+GS2FGtYaWEYgMbC0LiGH
	D7UJcBGHgq6+Eqd8KoYPPQh/J6gyMVHvXGX1ivXun6D8rfq0KMto
X-Google-Smtp-Source: AGHT+IH9WaluGBh1oL8ZE/+RPOXB4rk6z9OQv75PVi2VUYQUYkQfC4k2m9suqj59KlukaCdom/feVQ==
X-Received: by 2002:a05:6902:c02:b0:e03:9a95:bc78 with SMTP id 3f1490d57ef6-e0b231a1ed0mr5665481276.36.1721950094786;
        Thu, 25 Jul 2024 16:28:14 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f7a6a2sm509157276.23.2024.07.25.16.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:28:14 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeelb@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com
Subject: [PATCH 1/2] zswap: implement a second chance algorithm for dynamic zswap shrinker
Date: Thu, 25 Jul 2024 16:28:12 -0700
Message-ID: <20240725232813.2260665-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725232813.2260665-1-nphamcs@gmail.com>
References: <20240725232813.2260665-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current zswap shrinker's heursitics to prevent overshrinking is brittle
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
 include/linux/zswap.h | 16 ++++-----
 mm/zswap.c            | 84 +++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 56 deletions(-)

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
index adeaf9c97fde..a24ee015d7bc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -203,6 +203,7 @@ struct zswap_entry {
 	};
 	struct obj_cgroup *objcg;
 	struct list_head lru;
+	bool referenced;
 };
 
 static struct xarray *zswap_trees[MAX_SWAPFILES];
@@ -700,11 +701,10 @@ static inline int entry_to_nid(struct zswap_entry *entry)
 
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
@@ -722,19 +722,6 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
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
 
@@ -752,7 +739,7 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 
 void zswap_lruvec_state_init(struct lruvec *lruvec)
 {
-	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_swapins, 0);
 }
 
 void zswap_folio_swapin(struct folio *folio)
@@ -761,7 +748,7 @@ void zswap_folio_swapin(struct folio *folio)
 
 	if (folio) {
 		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_swapins);
 	}
 }
 
@@ -1091,6 +1078,16 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	enum lru_status ret = LRU_REMOVED_RETRY;
 	int writeback_result;
 
+	/*
+	 * Second chance algorithm: if the entry has its reference bit set, give it
+	 * a second chance. Only clear the reference bit and rotate it in the
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
@@ -1157,8 +1154,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
-	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
-	unsigned long shrink_ret, nr_protected, lru_size;
+	unsigned long shrink_ret;
 	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
@@ -1167,25 +1163,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
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
 
@@ -1200,7 +1177,8 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 {
 	struct mem_cgroup *memcg = sc->memcg;
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
-	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
+	atomic_long_t *nr_swapins = &lruvec->zswap_lruvec_state.nr_swapins;
+	unsigned long nr_backing, nr_stored, lru_size, nr_swapins_cur, nr_remain;
 
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
@@ -1233,14 +1211,26 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
@@ -1253,7 +1243,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * space. Hence, we may scale nr_freeable down a little bit more than we
 	 * should if we have a lot of same-filled pages.
 	 */
-	return mult_frac(nr_freeable, nr_backing, nr_stored);
+	return mult_frac(lru_size, nr_backing, nr_stored);
 }
 
 static struct shrinker *zswap_alloc_shrinker(void)
-- 
2.43.0



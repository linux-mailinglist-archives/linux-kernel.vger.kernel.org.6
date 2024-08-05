Return-Path: <linux-kernel+bounces-275447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E759485D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F9B1C21FB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6514016F0CE;
	Mon,  5 Aug 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj06oS7X"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517721547FB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900168; cv=none; b=eaUUlpgow/gGx2g0NcuKw+tF3MEOKsdKjGlXrOmoh6tOjmJizm/UiDvDwLSVTscZUNDSwfrt0HYltxm9Hs0yVS9oyx/9OCIDTnLltIjD32cnNBDrKW/zT7V6VAB2giJzWRmpHYkOqjZdhpfbodw1gCeDwPK1lFP2AhQHGuXBoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900168; c=relaxed/simple;
	bh=7CJTiXsbt2nkd6pkJ+rZEdv76PIjhj01ZNBYdag1bg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyV+XRBQ/4l563A1ogPCeIWqFd1SfH+1pJwWcDlACW+6YdaoXkeEm8ineHBm8a+yqeit0jzsfjgsk2rasqWiH9yqerxmOBca7A6xoCGGXHAOz+BMSr4J+NyGhzSPUq7jIRfBkqzYCMDI3JSDxGV1z66iCzNu0xhnQprIKjJHn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj06oS7X; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-68aa9c894c7so205307b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722900165; x=1723504965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9jBszB5LLWkkfrks405QdswXL8fPSHh3jU0pMbZKL8=;
        b=Cj06oS7XUKwk5H6SkBJ/kKKXII4Gc/yDks9+RSqWEifOk2dc96lTlGJ+7s0+1nA8Kk
         50dxyy023GJkMs5tvv5RWbplq2jqUSe60t7993nmWnZZ3Rh/wGY1cXawdZ970pQ1oFFX
         Ckf2IDFWhcpJhRfpyvk+sO1PbK/FlOpgFeHkx85hsCxnd1YLsIqVMh5twyczd1ahZpoz
         sA4lrm+618R5D8J/RPwbtEECDR4myMV3B9C2LE1Bizl1sRWmrGoz13ScVqBXqaYs7RYB
         ZcObK77L/c4Q8vkZTqYdvSC+bLl2E6G4271dv5rerfEjSdrXRVMhxSwBKKVPdUihj7ZH
         B7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900165; x=1723504965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9jBszB5LLWkkfrks405QdswXL8fPSHh3jU0pMbZKL8=;
        b=D8Za1IGyjguw7pQnW5v/4rcaPJJ1OWGxfwVG6ricdU1MgNWFJAZHNorB1Ybi1h3HoJ
         ZsyIH6Llt5BJgXqOxvGvjvYCtuSMweJILtn5a5o+Ao5XFioF0pM5oHXUiWEZoNQ/vMli
         QYd6jM4Z01KIxW1mwCsWA9JWKTRzfNg0IiyeYaaZCvr8272K9c3AOch7st1FgAMC59Nd
         E9GXynjWgVXbsgDCfRneQorjaMI1oTwKev3JoTT9ZzRRir/JvzQf5WiMxKg/fgPLH36B
         nch7ESdiaAytipzMjZAnCQ0bSxwcQ4qN66nIz/ttNLi187U0mp6OwYfLnByXH7Na9+Af
         srfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4U+qnS3yPzSpIU5339uey3l90+ZgES3Ae8IbFUM7Fu98Sgf40vqe950q/AkvMDgyghSNFleHaFRXij9wdPD2WNhZaKJLD+kdiSojf
X-Gm-Message-State: AOJu0YyCEH8nxiuZi91veLbprBR5bIYhHW4zAoC8yULqcDy1rAAFVoCu
	YaYKU+XU1+1OiWOZ0VGgUMStC0lKXkglasXZrCk6LI0Ojdi0fcne
X-Google-Smtp-Source: AGHT+IEET/qcu+3/GcjWYDk0MU/fhGCcMkhZvJ8FSa3Q+ZhrpzZxf542Yj8C0aMe8IhCvVZbrmDb+g==
X-Received: by 2002:a0d:dc07:0:b0:65f:8f77:720f with SMTP id 00721157ae682-6895f60d50emr140723007b3.5.1722900165075;
        Mon, 05 Aug 2024 16:22:45 -0700 (PDT)
Received: from localhost (fwdproxy-nha-001.fbsv.net. [2a03:2880:25ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a140613bcsm13712107b3.135.2024.08.05.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:22:44 -0700 (PDT)
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
Subject: [PATCH v3 1/2] zswap: implement a second chance algorithm for dynamic zswap shrinker
Date: Mon,  5 Aug 2024 16:22:42 -0700
Message-ID: <20240805232243.2896283-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805232243.2896283-1-nphamcs@gmail.com>
References: <20240805232243.2896283-1-nphamcs@gmail.com>
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

1. When a new zswap entry is stored in the zswap pool, its referenced
   bit is set.
2. When the zswap shrinker encounters a zswap entry with the referenced
   bit set, give it a second chance - only flips the referenced bit and
   rotate it in the LRU.
3. If the shrinker encounters the entry again, this time with its
   referenced bit unset, then it can reclaim the entry.

In this manner, the aging of the pages in the zswap LRUs are decoupled
from zswap stores, and picks up the pace with increasing memory pressure
(which is what we want).

The second chance scheme allows us to modulate the writeback rate based
on recent pool activities. Entries that recently entered the pool will
be protected, so if the pool is dominated by such entries the writeback
rate will reduce proportionally, protecting the workload's workingset.On
the other hand, stale entries will be written back quickly, which
increases the effective writeback rate.

The referenced bit is added at the hole after the `length` field of
struct zswap_entry, so there is no extra space overhead for this
algorithm.

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
 include/linux/zswap.h |  16 +++----
 mm/zswap.c            | 108 ++++++++++++++++++++++++------------------
 2 files changed, 70 insertions(+), 54 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 6cecb4a4f68b..9cd1beef0654 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -13,17 +13,15 @@ extern atomic_t zswap_stored_pages;
 
 struct zswap_lruvec_state {
 	/*
-	 * Number of pages in zswap that should be protected from the shrinker.
-	 * This number is an estimate of the following counts:
+	 * Number of swapped in pages from disk, i.e not found in the zswap pool.
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
+	atomic_long_t nr_disk_swapins;
 };
 
 unsigned long zswap_total_pages(void);
diff --git a/mm/zswap.c b/mm/zswap.c
index adeaf9c97fde..fb3d9cb88785 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -187,6 +187,10 @@ static struct shrinker *zswap_shrinker;
  * length - the length in bytes of the compressed page data.  Needed during
  *          decompression. For a same value filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
+ * referenced - true if the entry recently entered the zswap pool. Unset by the
+ *              dynamic shrinker. The entry is only reclaimed by the dynamic
+ *              shrinker if referenced is unset. See comments in the shrinker
+ *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
  * value - value of the same-value filled pages which have same content
@@ -196,6 +200,7 @@ static struct shrinker *zswap_shrinker;
 struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
+	bool referenced;
 	struct zswap_pool *pool;
 	union {
 		unsigned long handle;
@@ -700,11 +705,8 @@ static inline int entry_to_nid(struct zswap_entry *entry)
 
 static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
 {
-	atomic_long_t *nr_zswap_protected;
-	unsigned long lru_size, old, new;
 	int nid = entry_to_nid(entry);
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	/*
 	 * Note that it is safe to use rcu_read_lock() here, even in the face of
@@ -722,19 +724,6 @@ static void zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
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
 
@@ -752,7 +741,7 @@ static void zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
 
 void zswap_lruvec_state_init(struct lruvec *lruvec)
 {
-	atomic_long_set(&lruvec->zswap_lruvec_state.nr_zswap_protected, 0);
+	atomic_long_set(&lruvec->zswap_lruvec_state.nr_disk_swapins, 0);
 }
 
 void zswap_folio_swapin(struct folio *folio)
@@ -761,7 +750,7 @@ void zswap_folio_swapin(struct folio *folio)
 
 	if (folio) {
 		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
+		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
 	}
 }
 
@@ -1082,6 +1071,28 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
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
@@ -1091,6 +1102,16 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
@@ -1157,8 +1178,7 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
-	struct lruvec *lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
-	unsigned long shrink_ret, nr_protected, lru_size;
+	unsigned long shrink_ret;
 	bool encountered_page_in_swapcache = false;
 
 	if (!zswap_shrinker_enabled ||
@@ -1167,25 +1187,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
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
 
@@ -1200,7 +1201,10 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 {
 	struct mem_cgroup *memcg = sc->memcg;
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
-	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
+	atomic_long_t *nr_disk_swapins =
+		&lruvec->zswap_lruvec_state.nr_disk_swapins;
+	unsigned long nr_backing, nr_stored, nr_freeable, nr_disk_swapins_cur,
+		nr_remain;
 
 	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
 		return 0;
@@ -1233,14 +1237,27 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!nr_stored)
 		return 0;
 
-	nr_protected =
-		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	nr_freeable = list_lru_shrink_count(&zswap_list_lru, sc);
+	if (!nr_freeable)
+		return 0;
+
 	/*
-	 * Subtract the lru size by an estimate of the number of pages
-	 * that should be protected.
+	 * Subtract from the lru size the number of pages that are recently swapped
+	 * in from disk. The idea is that had we protect the zswap's LRU by this
+	 * amount of pages, these disk swapins would not have happened.
 	 */
-	nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
+	nr_disk_swapins_cur = atomic_long_read(nr_disk_swapins);
+	do {
+		if (nr_freeable >= nr_disk_swapins_cur)
+			nr_remain = 0;
+		else
+			nr_remain = nr_disk_swapins_cur - nr_freeable;
+	} while (!atomic_long_try_cmpxchg(
+		nr_disk_swapins, &nr_disk_swapins_cur, nr_remain));
+
+	nr_freeable -= nr_disk_swapins_cur - nr_remain;
+	if (!nr_freeable)
+		return 0;
 
 	/*
 	 * Scale the number of freeable pages by the memory saving factor.
@@ -1462,6 +1479,7 @@ bool zswap_store(struct folio *folio)
 store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
+	entry->referenced = true;
 
 	old = xa_store(tree, offset, entry, GFP_KERNEL);
 	if (xa_is_err(old)) {
-- 
2.43.0


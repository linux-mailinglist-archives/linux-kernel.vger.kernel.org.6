Return-Path: <linux-kernel+bounces-376884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F29AB70B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C1EB23D04
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B01CB513;
	Tue, 22 Oct 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSu7EDHQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141511A2658
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625890; cv=none; b=Mb4zjr4EnjmhicOnru1S+ydJ5obIgWahdHaXqDyjlZtPFUkIJH3nLUEvUgQLdWcqzauVGUaqUn5yXtOeU1G9fPwRYwCCxwv3y3cT7jtT6Dzzme88C6UluhamVAK/8IghfNlOligUTzKTPfPD7g5UdVQ2jc30bICcALvP1HbL2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625890; c=relaxed/simple;
	bh=aXU7Z0ls8KlQ8Ns0jRYwHjNeqLOCUIXN4azcAvjExM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIs+G6HiJg5AvtGrh3oyhB7sn7RmMpeTFpiaixVH+fhnsVMbEU+mrKEr/HOOPpS8Guw7XZyhYgL7rAdgrXU3V7GrkvkgHm3c7Z7CfDgf6R1roBvYJUxBdLmSnmFkuHtCxsyQpzfO1dkMUKPwocu2eu7gk8wgRL0zo8VeCCS16S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSu7EDHQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cbcd71012so54465315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625888; x=1730230688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R0FBRPvlweV3V63kFRaG7PTBewO1B3m5O3zQjLSkCfw=;
        b=KSu7EDHQ7+3bQiHWRMtH04rDcgWBvcKLL5I+xBFzAqW9/Jo9QK5LyzAKjGRLUN7U4W
         5fbCaQ+iZTPjWi3oZXtzgiPhvgEZzf2L9omTmkIZDXXTntdjWRVDHElbBXZG4XQyX5mj
         jidCq+N0BQ5RJZmHVdZD3n9cuDZX9XiK2tGMtePbIo0e6sPmOdEkzBLVjPCP7u5PsBri
         LYQZO4a4PxC3fREA0Cd5hW90DzmUbBgvwqp8b0LXUJxtLF/Wj0jUP8/lBdDKlm8YMwdk
         F0oi7H0WIYaFeaBpmawr7vy28fJLUZWt5KYNWhzG6154SpFIQUhk3mzvzUG4hZchOKQE
         n8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625888; x=1730230688;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0FBRPvlweV3V63kFRaG7PTBewO1B3m5O3zQjLSkCfw=;
        b=k6/BAaEeTB/s17D0nbgnGU2xiAW8MV1B5Jv9eHZP7QXpkEt21A5aYioTNNIMpqPus0
         kZssfytXu2uYPH2sKrnv92HP3x8Ur7N3EeI0EDnHtCRaZ1MSKlUMgSG4pj8zkk8bseuh
         vwMCUwAVaGj4XC7GHo+8abgTgTtTRkHJYmNCnClyg8fRVgPcmkRDvVyQNEJYhweuBqSj
         yb7yl0NfGEgaABcz9ull/mV6VuRjzpdxNgIDnTVjj2KSIwQ2+U9OW7INjbjjOuPwfbRk
         gAqMWSOCGEqIhuLmmC5wJRFBs4GohMrbsNTXBKQZzh0H/VvXfWKEN3bNczuIly7eNEPJ
         BsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaFbe08VNPXRZyTbPMOVDCc2cugEtW3i5usrHpl250pqYK9XZvd5Evf/AKaegnBb/yJNeFa8YHbkqAy+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkqkEYvb5l3oZZFR69mHUX+B57dCwJTgcHGbbQ+pNnpfhZOPB
	midt46MBnU0td1OUUq6kNvDKdAwZAknmfdhyXvbSZXp2fyDetPy3
X-Google-Smtp-Source: AGHT+IGUJ8AQzwqt8/MUkHuIb89YL1SfVEexjZ9y8Ui4ZXfkWlfD0aA1npA0ZkViny0ezZ6LYCpwQA==
X-Received: by 2002:a17:902:e884:b0:20c:a498:1e4d with SMTP id d9443c01a7336-20fab2e0ed9mr2600735ad.60.1729625888219;
        Tue, 22 Oct 2024 12:38:08 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0ad34sm46201875ad.68.2024.10.22.12.38.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:38:06 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 13/13] mm, swap_slots: remove slot cache for freeing path
Date: Wed, 23 Oct 2024 03:37:42 +0800
Message-ID: <20241022193742.43903-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022192451.38138-1-ryncsn@gmail.com>
References: <20241022192451.38138-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The slot cache for freeing path is mostly for reducing the overhead
of si->lock. As we have basically eliminated the si->lock usage
for freeing path, it can be just removed.

This helps simplify the code, and avoids swap entries from being hold
in cache upon freeing. The delayed freeing of entries have been
causing trouble for further optimizations for zswap [1] and in theory
will also cause more fragmentation, and extra overhead.

Test with build linux kernel showed both performance and fragmentation
is better without the cache:

tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, avg of 4 test run::
Before:
Sys time: 36047.78, Real time: 472.43
After: (-7.6% sys time, -7.3% real time)
Sys time: 33314.76, Real time: 437.67

time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, avg of 4 test run:
Before:
Sys time: 46859.04, Real time: 562.63
hugepages-64kB/stats/swpout: 1783392
hugepages-64kB/stats/swpout_fallback: 240875
After: (-23.3% sys time, -21.3% real time)
Sys time: 35958.87, Real time: 442.69
hugepages-64kB/stats/swpout: 1866267
hugepages-64kB/stats/swpout_fallback: 158330

Sequential SWAP should be also slightly faster, tests didn't show a
measurable difference though, at least no regression:

Swapin 4G zero page on ZRAM (time in us):
Before (avg. 1923756)
1912391 1927023 1927957 1916527 1918263 1914284 1934753 1940813 1921791
After (avg. 1922290):
1919101 1925743 1916810 1917007 1923930 1935152 1917403 1923549 1921913

Link: https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com/[1c]
Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap_slots.h |  3 --
 mm/swap_slots.c            | 78 +++++----------------------------
 mm/swapfile.c              | 89 +++++++++++++++-----------------------
 3 files changed, 44 insertions(+), 126 deletions(-)

diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..840aec3523b2 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -16,15 +16,12 @@ struct swap_slots_cache {
 	swp_entry_t	*slots;
 	int		nr;
 	int		cur;
-	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
-	swp_entry_t	*slots_ret;
 	int		n_ret;
 };
 
 void disable_swap_slots_cache_lock(void);
 void reenable_swap_slots_cache_unlock(void);
 void enable_swap_slots_cache(void);
-void free_swap_slot(swp_entry_t entry);
 
 extern bool swap_slot_cache_enabled;
 
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 13ab3b771409..9c7c171df7ba 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -43,17 +43,15 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
 /* Serialize swap slots cache enable/disable operations */
 static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
 
-static void __drain_swap_slots_cache(unsigned int type);
+static void __drain_swap_slots_cache(void);
 
 #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
-#define SLOTS_CACHE 0x1
-#define SLOTS_CACHE_RET 0x2
 
 static void deactivate_swap_slots_cache(void)
 {
 	mutex_lock(&swap_slots_cache_mutex);
 	swap_slot_cache_active = false;
-	__drain_swap_slots_cache(SLOTS_CACHE|SLOTS_CACHE_RET);
+	__drain_swap_slots_cache();
 	mutex_unlock(&swap_slots_cache_mutex);
 }
 
@@ -72,7 +70,7 @@ void disable_swap_slots_cache_lock(void)
 	if (swap_slot_cache_initialized) {
 		/* serialize with cpu hotplug operations */
 		cpus_read_lock();
-		__drain_swap_slots_cache(SLOTS_CACHE|SLOTS_CACHE_RET);
+		__drain_swap_slots_cache();
 		cpus_read_unlock();
 	}
 }
@@ -113,7 +111,7 @@ static bool check_cache_active(void)
 static int alloc_swap_slot_cache(unsigned int cpu)
 {
 	struct swap_slots_cache *cache;
-	swp_entry_t *slots, *slots_ret;
+	swp_entry_t *slots;
 
 	/*
 	 * Do allocation outside swap_slots_cache_mutex
@@ -125,28 +123,19 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 	if (!slots)
 		return -ENOMEM;
 
-	slots_ret = kvcalloc(SWAP_SLOTS_CACHE_SIZE, sizeof(swp_entry_t),
-			     GFP_KERNEL);
-	if (!slots_ret) {
-		kvfree(slots);
-		return -ENOMEM;
-	}
-
 	mutex_lock(&swap_slots_cache_mutex);
 	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots || cache->slots_ret) {
+	if (cache->slots) {
 		/* cache already allocated */
 		mutex_unlock(&swap_slots_cache_mutex);
 
 		kvfree(slots);
-		kvfree(slots_ret);
 
 		return 0;
 	}
 
 	if (!cache->lock_initialized) {
 		mutex_init(&cache->alloc_lock);
-		spin_lock_init(&cache->free_lock);
 		cache->lock_initialized = true;
 	}
 	cache->nr = 0;
@@ -160,19 +149,16 @@ static int alloc_swap_slot_cache(unsigned int cpu)
 	 */
 	mb();
 	cache->slots = slots;
-	cache->slots_ret = slots_ret;
 	mutex_unlock(&swap_slots_cache_mutex);
 	return 0;
 }
 
-static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
-				  bool free_slots)
+static void drain_slots_cache_cpu(unsigned int cpu, bool free_slots)
 {
 	struct swap_slots_cache *cache;
-	swp_entry_t *slots = NULL;
 
 	cache = &per_cpu(swp_slots, cpu);
-	if ((type & SLOTS_CACHE) && cache->slots) {
+	if (cache->slots) {
 		mutex_lock(&cache->alloc_lock);
 		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
 		cache->cur = 0;
@@ -183,20 +169,9 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 		}
 		mutex_unlock(&cache->alloc_lock);
 	}
-	if ((type & SLOTS_CACHE_RET) && cache->slots_ret) {
-		spin_lock_irq(&cache->free_lock);
-		swapcache_free_entries(cache->slots_ret, cache->n_ret);
-		cache->n_ret = 0;
-		if (free_slots && cache->slots_ret) {
-			slots = cache->slots_ret;
-			cache->slots_ret = NULL;
-		}
-		spin_unlock_irq(&cache->free_lock);
-		kvfree(slots);
-	}
 }
 
-static void __drain_swap_slots_cache(unsigned int type)
+static void __drain_swap_slots_cache(void)
 {
 	unsigned int cpu;
 
@@ -224,13 +199,13 @@ static void __drain_swap_slots_cache(unsigned int type)
 	 * There are no slots on such cpu that need to be drained.
 	 */
 	for_each_online_cpu(cpu)
-		drain_slots_cache_cpu(cpu, type, false);
+		drain_slots_cache_cpu(cpu, false);
 }
 
 static int free_slot_cache(unsigned int cpu)
 {
 	mutex_lock(&swap_slots_cache_mutex);
-	drain_slots_cache_cpu(cpu, SLOTS_CACHE | SLOTS_CACHE_RET, true);
+	drain_slots_cache_cpu(cpu, true);
 	mutex_unlock(&swap_slots_cache_mutex);
 	return 0;
 }
@@ -269,39 +244,6 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	return cache->nr;
 }
 
-void free_swap_slot(swp_entry_t entry)
-{
-	struct swap_slots_cache *cache;
-
-	/* Large folio swap slot is not covered. */
-	zswap_invalidate(entry);
-
-	cache = raw_cpu_ptr(&swp_slots);
-	if (likely(use_swap_slot_cache && cache->slots_ret)) {
-		spin_lock_irq(&cache->free_lock);
-		/* Swap slots cache may be deactivated before acquiring lock */
-		if (!use_swap_slot_cache || !cache->slots_ret) {
-			spin_unlock_irq(&cache->free_lock);
-			goto direct_free;
-		}
-		if (cache->n_ret >= SWAP_SLOTS_CACHE_SIZE) {
-			/*
-			 * Return slots to global pool.
-			 * The current swap_map value is SWAP_HAS_CACHE.
-			 * Set it to 0 to indicate it is available for
-			 * allocation in global pool
-			 */
-			swapcache_free_entries(cache->slots_ret, cache->n_ret);
-			cache->n_ret = 0;
-		}
-		cache->slots_ret[cache->n_ret++] = entry;
-		spin_unlock_irq(&cache->free_lock);
-	} else {
-direct_free:
-		swapcache_free_entries(&entry, 1);
-	}
-}
-
 swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_entry_t entry;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6eb298a222c0..c77b6ec3c83b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -53,14 +53,15 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
-static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry,
-				  unsigned int nr_pages);
+static void swap_entry_range_free(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  swp_entry_t entry, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
 static struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 					      unsigned long offset);
-static void unlock_cluster(struct swap_cluster_info *ci);
+static inline void unlock_cluster(struct swap_cluster_info *ci);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -260,10 +261,9 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	folio_ref_sub(folio, nr_pages);
 	folio_set_dirty(folio);
 
-	/* Only sinple page folio can be backed by zswap */
-	if (nr_pages == 1)
-		zswap_invalidate(entry);
-	swap_entry_range_free(si, entry, nr_pages);
+	ci = lock_cluster(si, offset);
+	swap_entry_range_free(si, ci, entry, nr_pages);
+	unlock_cluster(ci);
 	ret = nr_pages;
 out_unlock:
 	folio_unlock(folio);
@@ -1105,8 +1105,10 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
 	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
 		clear_bit(offset + i, si->zeromap);
+		zswap_invalidate(swp_entry(si->type, offset + i));
+	}
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1410,9 +1412,9 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
 
 	ci = lock_cluster(si, offset);
 	usage = __swap_entry_free_locked(si, offset, 1);
-	unlock_cluster(ci);
 	if (!usage)
-		free_swap_slot(entry);
+		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+	unlock_cluster(ci);
 
 	return usage;
 }
@@ -1440,13 +1442,10 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 	}
 	for (i = 0; i < nr; i++)
 		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
+	if (!has_cache)
+		swap_entry_range_free(si, ci, entry, nr);
 	unlock_cluster(ci);
 
-	if (!has_cache) {
-		for (i = 0; i < nr; i++)
-			zswap_invalidate(swp_entry(si->type, offset + i));
-		swap_entry_range_free(si, entry, nr);
-	}
 	return has_cache;
 
 fallback:
@@ -1466,15 +1465,13 @@ static bool __swap_entries_free(struct swap_info_struct *si,
  * Drop the last HAS_CACHE flag of swap entries, caller have to
  * ensure all entries belong to the same cgroup.
  */
-static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry,
-				  unsigned int nr_pages)
+static void swap_entry_range_free(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  swp_entry_t entry, unsigned int nr_pages)
 {
 	unsigned long offset = swp_offset(entry);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
-	struct swap_cluster_info *ci;
-
-	ci = lock_cluster(si, offset);
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
@@ -1494,7 +1491,6 @@ static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry
 		free_cluster(si, ci);
 	else
 		partial_free_cluster(si, ci);
-	unlock_cluster(ci);
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *si,
@@ -1502,28 +1498,13 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 		unsigned char usage)
 {
 	struct swap_cluster_info *ci;
-	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
-	int i, nr;
+	unsigned long end = offset + nr_pages;
 
 	ci = lock_cluster(si, offset);
-	while (nr_pages) {
-		nr = min(BITS_PER_LONG, nr_pages);
-		for (i = 0; i < nr; i++) {
-			if (!__swap_entry_free_locked(si, offset + i, usage))
-				bitmap_set(to_free, i, 1);
-		}
-		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
-			unlock_cluster(ci);
-			for_each_set_bit(i, to_free, BITS_PER_LONG)
-				free_swap_slot(swp_entry(si->type, offset + i));
-			if (nr == nr_pages)
-				return;
-			bitmap_clear(to_free, 0, BITS_PER_LONG);
-			ci = lock_cluster(si, offset);
-		}
-		offset += nr;
-		nr_pages -= nr;
-	}
+	do {
+		if (!__swap_entry_free_locked(si, offset, usage))
+			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+	} while (++offset < end);
 	unlock_cluster(ci);
 }
 
@@ -1564,18 +1545,12 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 		return;
 
 	ci = lock_cluster(si, offset);
-	if (size > 1 && swap_is_has_cache(si, offset, size)) {
-		unlock_cluster(ci);
-		swap_entry_range_free(si, entry, size);
-		return;
-	}
-	for (int i = 0; i < size; i++, entry.val++) {
-		if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE)) {
-			unlock_cluster(ci);
-			free_swap_slot(entry);
-			if (i == size - 1)
-				return;
-			lock_cluster(si, offset);
+	if (swap_is_has_cache(si, offset, size))
+		swap_entry_range_free(si, ci, entry, size);
+	else {
+		for (int i = 0; i < size; i++, entry.val++) {
+			if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE))
+				swap_entry_range_free(si, ci, entry, 1);
 		}
 	}
 	unlock_cluster(ci);
@@ -1584,6 +1559,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 void swapcache_free_entries(swp_entry_t *entries, int n)
 {
 	int i;
+	struct swap_cluster_info *ci;
 	struct swap_info_struct *si = NULL;
 
 	if (n <= 0)
@@ -1591,8 +1567,11 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 
 	for (i = 0; i < n; ++i) {
 		si = _swap_info_get(entries[i]);
-		if (si)
-			swap_entry_range_free(si, entries[i], 1);
+		if (si) {
+			ci = lock_cluster(si, swp_offset(entries[i]));
+			swap_entry_range_free(si, ci, entries[i], 1);
+			unlock_cluster(ci);
+		}
 	}
 }
 
-- 
2.47.0



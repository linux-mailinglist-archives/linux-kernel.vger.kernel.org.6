Return-Path: <linux-kernel+bounces-515461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED715A3651F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512103AF557
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552E2690ED;
	Fri, 14 Feb 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhYDuFEV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B42686A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555936; cv=none; b=JZD+zNc2Etv0BWyzTHdfd66p2tOGGr4WCCvVSc6L4mtHa0lZyXVtoFptCn3rVHI5UXPRai9J0UczBU/dpJTutQc+o/0E6O+eLYWx54M4T+dCyS4WY2O2NHVptG/jnziDsitSNxT0M36DXNY4CmhhPsgix0nnJfMKZne5QlxXAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555936; c=relaxed/simple;
	bh=5zF08hI2n5nDivExTXRxFcFb2fHoATW+k0qZ9b0JEn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxbWEO3uokXBg62s5GoU+Fh5GA/qkyTUhk6VnfDa8iRKNKlVByR0AJwxzGan+qa1F05hORtewFpnViiXIVB2vSThRQgZLne5MV8Izv1/K/vfPYG1Gxnd1rnEU9GY325B56L+MqtRFgI2MGFCRaZtPdF7oDra00jPkz41ojq5eFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhYDuFEV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e83d65e5so31089525ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555933; x=1740160733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrxkWCsY2BG0TogE7kDNIlucXg1dBLFmlliY7Uuharg=;
        b=jhYDuFEVkjkmCg4ilJ+EYeimGpSs3uEsZHY0U6KlPqSc1XZTT6GSSnlurnS9K5aLJa
         l6recFLTgbCaFrEql6riFawQNbfaVZgA91lfakxcZfYWpTulN4WZE92exCsxEFIuPs44
         E3DUht/yTXFZg4Bds94rQeqOgoToJAcFur6JS3KHw3rDbSucBUxDsnHDmZDv+30kA/a8
         Hyc10SzBtt6BF5xbCIjgJ8MOBtOuo39NpduYaVrp6RKB/o7AWJDYMQRV26uAKiiTaV9p
         J59tvttxyo4Q45LDACfo0An04AtDV/HHbnBG9fWzkpVrWiWkH+gjVSkfJOqEHKDy953N
         2bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555933; x=1740160733;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrxkWCsY2BG0TogE7kDNIlucXg1dBLFmlliY7Uuharg=;
        b=Hok6fCwSAc8LPMiKmuc9p/IT8X4AyJ5YLgziBSE9UCAGcAKCnjXqdRJJzOGUaIEuIv
         7SmLBnjmMMx/TV1Mw6OuSHlmkAcHdOIppkrafHkKiqJ0n7S+9dMEVsg5i0dvs655KHDX
         1wo9h0Eo1lrVcGsYneVfg+6+/eH31f0H2p2n6RPq9yxgD3nbOrJYLz4LSwP3FZNYrDhN
         v/sZUmM35796/pj/WkyjqE1Rpbe1qs2wxDPQup1kcd6KZCn7q1HzGZQMwL3RC1AjrNqf
         7sGPgPY+DIySO0tGLksrT6zZGV7qh4W7xvp+c01SrzqwL5MVb0yXFMfW6rs7Dw9FKVir
         RKKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2+bPsbW7qfuNb16XG+hNg21OpSOeCoV3YR6vyRIUkz/g9UBZE4b5QOoeAbzxIik3R/rbTyWKDEyBtvwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrkn5k4VwOLFTrdFb2vAe5X+y7uWFq5niZRzYmOJKbmS92uk5L
	Pe+qcg7w8Jp29An+O5SgnDFntiGpiGIq4PcbCjswecaQP4M0AUQX
X-Gm-Gg: ASbGnctf3ZBHVMkfyNMM7azBem1zffXyskFwsf4IaEpQ7XxupR0ZRgDmmxa+lMpzZvq
	c8LIWYajJg5VWhOxNay5YDrkk1xPUU1zrvBwXSBkJhvNc+JLst4nWgTdD+3Jc3bN/MZke2PVozD
	HTt9xDoTxbhqDULQQZqG531n3bpaKy1enQxEcxmuOOh81SjR69NL4t2QnYs+v81BjANPDfd8s5v
	lC1uTqpT6paAjNemIkBCj/4anF/FI69byC0LjKBQXxaxl0F08EEwP74wGHynvArBnncySeoHA6g
	KU688lG0Mf4IxuMtH/+Q2Qyi+fAlfe5U4rk3
X-Google-Smtp-Source: AGHT+IFU/H/3lJEuxMEyY0X4vY4k43jZAun4SfbIvrjpzUIvreDXgYLIc7CySd22D5UQYi76P8WUVQ==
X-Received: by 2002:a17:902:cccc:b0:220:be86:a42d with SMTP id d9443c01a7336-22104048ecemr2911695ad.21.1739555932901;
        Fri, 14 Feb 2025 09:58:52 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:52 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 6/7] mm, swap: remove swap slot cache
Date: Sat, 15 Feb 2025 01:57:08 +0800
Message-ID: <20250214175709.76029-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214175709.76029-1-ryncsn@gmail.com>
References: <20250214175709.76029-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Slot cache is no longer needed now, removing it and all related code.

- vm-scalability with: `usemem --init-time -O -y -x -R -31 1G`,
12G memory cgroup using simulated pmem as SWAP (32G pmem, 32 CPUs),
16 test runs for each case, measuring the total throughput:

                      Before (KB/s) (stdev)  After (KB/s) (stdev)
Random (4K):          424907.60 (24410.78)   414745.92  (34554.78)
Random (64K):         163308.82 (11635.72)   167314.50  (18434.99)
Sequential (4K, !-R): 6150056.79 (103205.90) 6321469.06 (115878.16)

The performance changes are below noise level.

- Build linux kernel with make -j96, using 4K folio with 1.5G memory
cgroup limit and 64K folio with 2G memory cgroup limit, on top of tmpfs,
12 test runs, measuring the system time:

                  Before (s) (stdev)  After (s) (stdev)
make -j96 (4K):   6445.69 (61.95)     6408.80 (69.46)
make -j96 (64K):  6841.71 (409.04)    6437.99 (435.55)

Similar to above, 64k mTHP case showed a slight improvement.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h       |   2 -
 include/linux/swap_slots.h |  28 ----
 mm/Makefile                |   2 +-
 mm/swap_slots.c            | 295 -------------------------------------
 mm/swap_state.c            |   8 +-
 mm/swapfile.c              | 173 ++++++++--------------
 6 files changed, 64 insertions(+), 444 deletions(-)
 delete mode 100644 include/linux/swap_slots.h
 delete mode 100644 mm/swap_slots.c

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a8d84f22357e..456833705ea0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -465,7 +465,6 @@ void free_pages_and_swap_cache(struct encoded_page **, int);
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
 extern atomic_t nr_rotate_swap;
-extern bool has_usable_swap(void);
 
 /* Swap 50% full? Release swapcache more aggressively.. */
 static inline bool vm_swap_full(void)
@@ -489,7 +488,6 @@ extern void swap_shmem_alloc(swp_entry_t, int);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
deleted file mode 100644
index 840aec3523b2..000000000000
--- a/include/linux/swap_slots.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SWAP_SLOTS_H
-#define _LINUX_SWAP_SLOTS_H
-
-#include <linux/swap.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
-
-#define SWAP_SLOTS_CACHE_SIZE			SWAP_BATCH
-#define THRESHOLD_ACTIVATE_SWAP_SLOTS_CACHE	(5*SWAP_SLOTS_CACHE_SIZE)
-#define THRESHOLD_DEACTIVATE_SWAP_SLOTS_CACHE	(2*SWAP_SLOTS_CACHE_SIZE)
-
-struct swap_slots_cache {
-	bool		lock_initialized;
-	struct mutex	alloc_lock; /* protects slots, nr, cur */
-	swp_entry_t	*slots;
-	int		nr;
-	int		cur;
-	int		n_ret;
-};
-
-void disable_swap_slots_cache_lock(void);
-void reenable_swap_slots_cache_unlock(void);
-void enable_swap_slots_cache(void);
-
-extern bool swap_slot_cache_enabled;
-
-#endif /* _LINUX_SWAP_SLOTS_H */
diff --git a/mm/Makefile b/mm/Makefile
index 53392d2af3a5..ea16e472b294 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -75,7 +75,7 @@ ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
 
-obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
+obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
deleted file mode 100644
index 9c7c171df7ba..000000000000
--- a/mm/swap_slots.c
+++ /dev/null
@@ -1,295 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Manage cache of swap slots to be used for and returned from
- * swap.
- *
- * Copyright(c) 2016 Intel Corporation.
- *
- * Author: Tim Chen <tim.c.chen@linux.intel.com>
- *
- * We allocate the swap slots from the global pool and put
- * it into local per cpu caches.  This has the advantage
- * of no needing to acquire the swap_info lock every time
- * we need a new slot.
- *
- * There is also opportunity to simply return the slot
- * to local caches without needing to acquire swap_info
- * lock.  We do not reuse the returned slots directly but
- * move them back to the global pool in a batch.  This
- * allows the slots to coalesce and reduce fragmentation.
- *
- * The swap entry allocated is marked with SWAP_HAS_CACHE
- * flag in map_count that prevents it from being allocated
- * again from the global pool.
- *
- * The swap slots cache is protected by a mutex instead of
- * a spin lock as when we search for slots with scan_swap_map,
- * we can possibly sleep.
- */
-
-#include <linux/swap_slots.h>
-#include <linux/cpu.h>
-#include <linux/cpumask.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/mutex.h>
-#include <linux/mm.h>
-
-static DEFINE_PER_CPU(struct swap_slots_cache, swp_slots);
-static bool	swap_slot_cache_active;
-bool	swap_slot_cache_enabled;
-static bool	swap_slot_cache_initialized;
-static DEFINE_MUTEX(swap_slots_cache_mutex);
-/* Serialize swap slots cache enable/disable operations */
-static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
-
-static void __drain_swap_slots_cache(void);
-
-#define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
-
-static void deactivate_swap_slots_cache(void)
-{
-	mutex_lock(&swap_slots_cache_mutex);
-	swap_slot_cache_active = false;
-	__drain_swap_slots_cache();
-	mutex_unlock(&swap_slots_cache_mutex);
-}
-
-static void reactivate_swap_slots_cache(void)
-{
-	mutex_lock(&swap_slots_cache_mutex);
-	swap_slot_cache_active = true;
-	mutex_unlock(&swap_slots_cache_mutex);
-}
-
-/* Must not be called with cpu hot plug lock */
-void disable_swap_slots_cache_lock(void)
-{
-	mutex_lock(&swap_slots_cache_enable_mutex);
-	swap_slot_cache_enabled = false;
-	if (swap_slot_cache_initialized) {
-		/* serialize with cpu hotplug operations */
-		cpus_read_lock();
-		__drain_swap_slots_cache();
-		cpus_read_unlock();
-	}
-}
-
-static void __reenable_swap_slots_cache(void)
-{
-	swap_slot_cache_enabled = has_usable_swap();
-}
-
-void reenable_swap_slots_cache_unlock(void)
-{
-	__reenable_swap_slots_cache();
-	mutex_unlock(&swap_slots_cache_enable_mutex);
-}
-
-static bool check_cache_active(void)
-{
-	long pages;
-
-	if (!swap_slot_cache_enabled)
-		return false;
-
-	pages = get_nr_swap_pages();
-	if (!swap_slot_cache_active) {
-		if (pages > num_online_cpus() *
-		    THRESHOLD_ACTIVATE_SWAP_SLOTS_CACHE)
-			reactivate_swap_slots_cache();
-		goto out;
-	}
-
-	/* if global pool of slot caches too low, deactivate cache */
-	if (pages < num_online_cpus() * THRESHOLD_DEACTIVATE_SWAP_SLOTS_CACHE)
-		deactivate_swap_slots_cache();
-out:
-	return swap_slot_cache_active;
-}
-
-static int alloc_swap_slot_cache(unsigned int cpu)
-{
-	struct swap_slots_cache *cache;
-	swp_entry_t *slots;
-
-	/*
-	 * Do allocation outside swap_slots_cache_mutex
-	 * as kvzalloc could trigger reclaim and folio_alloc_swap,
-	 * which can lock swap_slots_cache_mutex.
-	 */
-	slots = kvcalloc(SWAP_SLOTS_CACHE_SIZE, sizeof(swp_entry_t),
-			 GFP_KERNEL);
-	if (!slots)
-		return -ENOMEM;
-
-	mutex_lock(&swap_slots_cache_mutex);
-	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots) {
-		/* cache already allocated */
-		mutex_unlock(&swap_slots_cache_mutex);
-
-		kvfree(slots);
-
-		return 0;
-	}
-
-	if (!cache->lock_initialized) {
-		mutex_init(&cache->alloc_lock);
-		cache->lock_initialized = true;
-	}
-	cache->nr = 0;
-	cache->cur = 0;
-	cache->n_ret = 0;
-	/*
-	 * We initialized alloc_lock and free_lock earlier.  We use
-	 * !cache->slots or !cache->slots_ret to know if it is safe to acquire
-	 * the corresponding lock and use the cache.  Memory barrier below
-	 * ensures the assumption.
-	 */
-	mb();
-	cache->slots = slots;
-	mutex_unlock(&swap_slots_cache_mutex);
-	return 0;
-}
-
-static void drain_slots_cache_cpu(unsigned int cpu, bool free_slots)
-{
-	struct swap_slots_cache *cache;
-
-	cache = &per_cpu(swp_slots, cpu);
-	if (cache->slots) {
-		mutex_lock(&cache->alloc_lock);
-		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
-		cache->cur = 0;
-		cache->nr = 0;
-		if (free_slots && cache->slots) {
-			kvfree(cache->slots);
-			cache->slots = NULL;
-		}
-		mutex_unlock(&cache->alloc_lock);
-	}
-}
-
-static void __drain_swap_slots_cache(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * This function is called during
-	 *	1) swapoff, when we have to make sure no
-	 *	   left over slots are in cache when we remove
-	 *	   a swap device;
-	 *      2) disabling of swap slot cache, when we run low
-	 *	   on swap slots when allocating memory and need
-	 *	   to return swap slots to global pool.
-	 *
-	 * We cannot acquire cpu hot plug lock here as
-	 * this function can be invoked in the cpu
-	 * hot plug path:
-	 * cpu_up -> lock cpu_hotplug -> cpu hotplug state callback
-	 *   -> memory allocation -> direct reclaim -> folio_alloc_swap
-	 *   -> drain_swap_slots_cache
-	 *
-	 * Hence the loop over current online cpu below could miss cpu that
-	 * is being brought online but not yet marked as online.
-	 * That is okay as we do not schedule and run anything on a
-	 * cpu before it has been marked online. Hence, we will not
-	 * fill any swap slots in slots cache of such cpu.
-	 * There are no slots on such cpu that need to be drained.
-	 */
-	for_each_online_cpu(cpu)
-		drain_slots_cache_cpu(cpu, false);
-}
-
-static int free_slot_cache(unsigned int cpu)
-{
-	mutex_lock(&swap_slots_cache_mutex);
-	drain_slots_cache_cpu(cpu, true);
-	mutex_unlock(&swap_slots_cache_mutex);
-	return 0;
-}
-
-void enable_swap_slots_cache(void)
-{
-	mutex_lock(&swap_slots_cache_enable_mutex);
-	if (!swap_slot_cache_initialized) {
-		int ret;
-
-		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "swap_slots_cache",
-					alloc_swap_slot_cache, free_slot_cache);
-		if (WARN_ONCE(ret < 0, "Cache allocation failed (%s), operating "
-				       "without swap slots cache.\n", __func__))
-			goto out_unlock;
-
-		swap_slot_cache_initialized = true;
-	}
-
-	__reenable_swap_slots_cache();
-out_unlock:
-	mutex_unlock(&swap_slots_cache_enable_mutex);
-}
-
-/* called with swap slot cache's alloc lock held */
-static int refill_swap_slots_cache(struct swap_slots_cache *cache)
-{
-	if (!use_swap_slot_cache)
-		return 0;
-
-	cache->cur = 0;
-	if (swap_slot_cache_active)
-		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
-					   cache->slots, 0);
-
-	return cache->nr;
-}
-
-swp_entry_t folio_alloc_swap(struct folio *folio)
-{
-	swp_entry_t entry;
-	struct swap_slots_cache *cache;
-
-	entry.val = 0;
-
-	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP))
-			get_swap_pages(1, &entry, folio_order(folio));
-		goto out;
-	}
-
-	/*
-	 * Preemption is allowed here, because we may sleep
-	 * in refill_swap_slots_cache().  But it is safe, because
-	 * accesses to the per-CPU data structure are protected by the
-	 * mutex cache->alloc_lock.
-	 *
-	 * The alloc path here does not touch cache->slots_ret
-	 * so cache->free_lock is not taken.
-	 */
-	cache = raw_cpu_ptr(&swp_slots);
-
-	if (likely(check_cache_active() && cache->slots)) {
-		mutex_lock(&cache->alloc_lock);
-		if (cache->slots) {
-repeat:
-			if (cache->nr) {
-				entry = cache->slots[cache->cur];
-				cache->slots[cache->cur++].val = 0;
-				cache->nr--;
-			} else if (refill_swap_slots_cache(cache)) {
-				goto repeat;
-			}
-		}
-		mutex_unlock(&cache->alloc_lock);
-		if (entry.val)
-			goto out;
-	}
-
-	get_swap_pages(1, &entry, 0);
-out:
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		put_swap_folio(folio, entry);
-		entry.val = 0;
-	}
-	return entry;
-}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 50840a2887a5..2b5744e211cd 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -20,7 +20,6 @@
 #include <linux/blkdev.h>
 #include <linux/migrate.h>
 #include <linux/vmalloc.h>
-#include <linux/swap_slots.h>
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
 #include "internal.h"
@@ -447,13 +446,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 
 		/*
 		 * Just skip read ahead for unused swap slot.
-		 * During swap_off when swap_slot_cache is disabled,
-		 * we have to handle the race between putting
-		 * swap entry in swap cache and marking swap slot
-		 * as SWAP_HAS_CACHE.  That's done in later part of code or
-		 * else swap_off will be aborted if we return NULL.
 		 */
-		if (!swap_entry_swapped(si, entry) && swap_slot_cache_enabled)
+		if (!swap_entry_swapped(si, entry))
 			goto put_and_return;
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 791cd7ed5bdf..66c8869ef346 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -37,7 +37,6 @@
 #include <linux/oom.h>
 #include <linux/swapfile.h>
 #include <linux/export.h>
-#include <linux/swap_slots.h>
 #include <linux/sort.h>
 #include <linux/completion.h>
 #include <linux/suspend.h>
@@ -892,6 +891,13 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	struct swap_cluster_info *ci;
 	unsigned int offset, found = 0;
 
+	/*
+	 * Swapfile is not block device so unable
+	 * to allocate large entries.
+	 */
+	if (order && !(si->flags & SWP_BLKDEV))
+		return 0;
+
 	if (!(si->flags & SWP_SOLIDSTATE)) {
 		/* Serialize HDD SWAP allocation for each device. */
 		spin_lock(&si->global_cluster_lock);
@@ -1155,43 +1161,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	swap_usage_sub(si, nr_entries);
 }
 
-static int scan_swap_map_slots(struct swap_info_struct *si,
-			       unsigned char usage, int nr,
-			       swp_entry_t slots[], int order)
-{
-	unsigned int nr_pages = 1 << order;
-	int n_ret = 0;
-
-	if (order > 0) {
-		/*
-		 * Should not even be attempting large allocations when huge
-		 * page swap is disabled.  Warn and fail the allocation.
-		 */
-		if (!IS_ENABLED(CONFIG_THP_SWAP) ||
-		    nr_pages > SWAPFILE_CLUSTER) {
-			VM_WARN_ON_ONCE(1);
-			return 0;
-		}
-
-		/*
-		 * Swapfile is not block device so unable
-		 * to allocate large entries.
-		 */
-		if (!(si->flags & SWP_BLKDEV))
-			return 0;
-	}
-
-	while (n_ret < nr) {
-		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
-
-		if (!offset)
-			break;
-		slots[n_ret++] = swp_entry(si->type, offset);
-	}
-
-	return n_ret;
-}
-
 static bool get_swap_device_info(struct swap_info_struct *si)
 {
 	if (!percpu_ref_tryget_live(&si->users))
@@ -1212,54 +1181,53 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static int swap_alloc_fast(swp_entry_t entries[],
+static int swap_alloc_fast(swp_entry_t *entry,
 			   unsigned char usage,
-			   int order, int n_goal)
+			   int order)
 {
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	unsigned int offset, found;
-	int n_ret = 0;
-
-	n_goal = min(n_goal, SWAP_BATCH);
+	unsigned int offset, found = SWAP_ENTRY_INVALID;
 
 	si = __this_cpu_read(percpu_swap_cluster.si);
 	offset = __this_cpu_read(percpu_swap_cluster.offset[order]);
 	if (!si || !offset || !get_swap_device_info(si))
-		return 0;
+		return false;
 
-	while (offset) {
-		ci = lock_cluster(si, offset);
-		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
-		if (!found)
-			break;
-		entries[n_ret++] = swp_entry(si->type, found);
-		if (n_ret == n_goal)
-			break;
-		offset = __this_cpu_read(percpu_swap_cluster.offset[order]);
-	}
+	ci = lock_cluster(si, offset);
+	found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
+	if (found)
+		*entry = swp_entry(si->type, found);
 
 	put_swap_device(si);
-	return n_ret;
+	return !!found;
 }
 
-int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
+swp_entry_t folio_alloc_swap(struct folio *folio)
 {
-	int order = swap_entry_order(entry_order);
-	unsigned long size = 1 << order;
+	unsigned int order = folio_order(folio);
+	unsigned int size = 1 << order;
 	struct swap_info_struct *si, *next;
-	int n_ret = 0;
+	swp_entry_t entry = {};
+	unsigned long offset;
 	int node;
 
+	if (order) {
+		/*
+		 * Should not even be attempting large allocations when huge
+		 * page swap is disabled. Warn and fail the allocation.
+		 */
+		if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
+			VM_WARN_ON_ONCE(1);
+			return entry;
+		}
+	}
+
 	/* Fast path using percpu cluster */
 	local_lock(&percpu_swap_cluster.lock);
-	n_ret = swap_alloc_fast(swp_entries,
-				SWAP_HAS_CACHE,
-				order, n_goal);
-	if (n_ret == n_goal)
-		goto out;
+	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
+		goto out_alloced;
 
-	n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
 	/* Rotate the device and switch to a new cluster */
 	spin_lock(&swap_avail_lock);
 start_over:
@@ -1268,11 +1236,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
-					swp_entries + n_ret, order);
+			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
 			put_swap_device(si);
-			if (n_ret || size > 1)
-				goto out;
+			if (offset) {
+				entry = swp_entry(si->type, offset);
+				goto out_alloced;
+			}
+			if (order)
+				goto out_failed;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1291,10 +1262,20 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
-out:
+out_failed:
+	local_unlock(&percpu_swap_cluster.lock);
+	return entry;
+
+out_alloced:
 	local_unlock(&percpu_swap_cluster.lock);
-	atomic_long_sub(n_ret * size, &nr_swap_pages);
-	return n_ret;
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		put_swap_folio(folio, entry);
+		entry.val = 0;
+	} else {
+		atomic_long_sub(size, &nr_swap_pages);
+	}
+
+	return entry;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
@@ -1590,25 +1571,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unlock_cluster(ci);
 }
 
-void swapcache_free_entries(swp_entry_t *entries, int n)
-{
-	int i;
-	struct swap_cluster_info *ci;
-	struct swap_info_struct *si = NULL;
-
-	if (n <= 0)
-		return;
-
-	for (i = 0; i < n; ++i) {
-		si = _swap_info_get(entries[i]);
-		if (si) {
-			ci = lock_cluster(si, swp_offset(entries[i]));
-			swap_entry_range_free(si, ci, entries[i], 1);
-			unlock_cluster(ci);
-		}
-	}
-}
-
 int __swap_count(swp_entry_t entry)
 {
 	struct swap_info_struct *si = swp_swap_info(entry);
@@ -1849,6 +1811,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 swp_entry_t get_swap_page_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_swap_info(type);
+	unsigned long offset;
 	swp_entry_t entry = {0};
 
 	if (!si)
@@ -1856,8 +1819,13 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
-		if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
-			atomic_long_dec(&nr_swap_pages);
+		if (si->flags & SWP_WRITEOK) {
+			offset = cluster_alloc_swap_entry(si, 0, 1);
+			if (offset) {
+				entry = swp_entry(si->type, offset);
+				atomic_long_dec(&nr_swap_pages);
+			}
+		}
 		put_swap_device(si);
 	}
 fail:
@@ -2623,16 +2591,6 @@ static bool __has_usable_swap(void)
 	return !plist_head_empty(&swap_active_head);
 }
 
-bool has_usable_swap(void)
-{
-	bool ret;
-
-	spin_lock(&swap_lock);
-	ret = __has_usable_swap();
-	spin_unlock(&swap_lock);
-	return ret;
-}
-
 /*
  * Called after clearing SWP_WRITEOK, ensures cluster_alloc_range
  * see the updated flags, so there will be no more allocations.
@@ -2724,8 +2682,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	wait_for_allocation(p);
 
-	disable_swap_slots_cache_lock();
-
 	set_current_oom_origin();
 	err = try_to_unuse(p->type);
 	clear_current_oom_origin();
@@ -2733,12 +2689,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (err) {
 		/* re-insert swap space back into swap_list */
 		reinsert_swap_info(p);
-		reenable_swap_slots_cache_unlock();
 		goto out_dput;
 	}
 
-	reenable_swap_slots_cache_unlock();
-
 	/*
 	 * Wait for swap operations protected by get/put_swap_device()
 	 * to complete.  Because of synchronize_rcu() here, all swap
@@ -3487,8 +3440,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		putname(name);
 	if (inode)
 		inode_unlock(inode);
-	if (!error)
-		enable_swap_slots_cache();
 	return error;
 }
 
-- 
2.48.1



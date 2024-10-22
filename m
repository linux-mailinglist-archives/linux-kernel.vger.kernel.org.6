Return-Path: <linux-kernel+bounces-376857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E19AB6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD171F21FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1481CB52F;
	Tue, 22 Oct 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqEL2W/L"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA711CC8A8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625408; cv=none; b=Dn0Y6Nr92v/2XlLws+4AM6CeCYlZzWHuIPKvyPlcMDgK8h/p8m3a0KAA6mKP1AAVvQDz8feC+Zz2UdFrw9csLFvLi4GX1slzPOR4nrXFv1AUuhLIQ2OdZPSV1o3pOk32xJZc7mmE+Ck9lERzTjvhR/y/ZBkMQZKkapr4ri/KURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625408; c=relaxed/simple;
	bh=fn6zozrMcwEHwzWYkrPIBo4XzGGhpGTr/HNJIN3LD3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWQyB1qcY6CULM1AOY3RBXFcik9b8SkTvlGmQP+/TuQuUBwqaxlu+5Rfw56mcsZF0BOQEIou7zlFt56iDaUYQnWt4rq1nhflZkQogZBlYp8wdlcV2xk+QwCPNjfMY3ojOARcxeCXs92NUOp2jvKegWYvKpndVrM94bv5xRlbI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqEL2W/L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so52314445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625406; x=1730230206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91RZU9Im1mJOrq2P9uaFSxI4j9qGIThucf4AzLiTGJQ=;
        b=MqEL2W/L0iy5ion+fi28BRZK+DQzLUuw3WPhT9ksSeqHM67l/udPitoU96J0gk1wlL
         lQLS0R+ZZThRvTmWe8gl63v/XacocoTB0wumBRPJzIRR5k/R1a+9J8GStxfpBgJVHfwZ
         NO+6+f7xbzmojhkOHxGBiUox5HRPCzWHy8Qly52M4nwBZQmnz/wwpuekScKRXSjySZxK
         QMIz7YmRz+YHGUpbdWNJOIG0E+zol1cB1AmN6bD0/w9uPS5QjSW3J0DW/rvYfxywNyNw
         TQgi/+c475kqSGYSQ4AHo+ansgezAW8QpMIZL/f2I367zRjpVWozQ3KPQk1dZ8/1XCv0
         d/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625406; x=1730230206;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91RZU9Im1mJOrq2P9uaFSxI4j9qGIThucf4AzLiTGJQ=;
        b=s1CYgm13epjCMcOcsgr63Nsyu0Fo56K6qA5mcpiybAiQvgXV0n76bPGY1UYk6s6rWS
         PQ30QN92Ef6WMmEvmXv4GcSJXhi4owC0rgq1V/BsHdHPPTKgKAa5RVOluFUiLhypVQn1
         uI07Vuqfkbj4QYqS2xPw59xARmbFLuOPgriQS9Hh5K6/GnGXfWKGKewRqb4swNGBeEVh
         qs8OEdPrxY2vEe7tS1Cprfddv30hW2IwokU6zkvRsaERTv0aPzLT8OvgJ3YQ6BevA4iD
         rGMNsXFk2hl47SA86X85hETKmRydG55fl+GJzH8Xpdtq3D7NnBeZFz5cCrm9d7KL1+Q6
         k7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJjcYTYqM9ZnDLv9g0FwQ71cAjvK6woDqQuFY0Gi9JOUTOBudkMnwk3yYr/CyB9QOyjO/3X+fEVX6j3Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMqoCo+6DuU3KeRD6926qvF2SOnkifHBKBukscVxoxjEqL6FG
	1iIJaUwUmo+6RUKejuMHVoGCt5n7dmoJgk8ZdiWA10kvY3swSnuv3PbIZO6m9L4=
X-Google-Smtp-Source: AGHT+IGGKxwhFu82Kx287SIzTLPVnCIKI6xEf3aZnrPozIx88QdOWVORIZasbmDFFI1F9UEgs7b7OA==
X-Received: by 2002:a17:902:e5c6:b0:20c:c834:b107 with SMTP id d9443c01a7336-20fa9e49d8fmr2964315ad.22.1729625405532;
        Tue, 22 Oct 2024 12:30:05 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:05 -0700 (PDT)
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
Subject: [PATCH 06/13] mm, swap: clean up plist removal and adding
Date: Wed, 23 Oct 2024 03:24:44 +0800
Message-ID: <20241022192451.38138-7-ryncsn@gmail.com>
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

When swap device is full (inuse_pages == pages), it should be
removed from the plist. And if any slot is freed, the swap device should
be added back to the plist. On swapoff / swapon, the swap device will
also be force removed / added.

This is currently serialized by si->lock, and some historical sanity
check code are still here. This commit decouple this from the protection
of si->lock and clean it up to prepare for si->lock rework.

Noticing inuse_pages counter is the only thing decides if a device
should be removed from or added to the plist (except swapon / swapoff
as a special case), and inuse_pages is a very hot counter. So to avoid
extra overhead on the counter update hot path, and make it possible to
check and update the plist when the counter value changes, embed the
plist state into the inuse_pages counter, and turn the counter into
an atomic. This way we can check and update the counter with one CAS
and avoid any extra synchronization.

If the counter is full (inuse_pages == pages) with the off-list bit
unset, try to remove it from the plist. If the counter is not full
(inuse_pages != pages) with the off-list bit set, try to add it to
the plist. Removing and adding is serialized with lock as well as the
bit setting. Ordinary counter updates will be lockless.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   2 +-
 mm/swapfile.c        | 182 +++++++++++++++++++++++++++++++------------
 2 files changed, 132 insertions(+), 52 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index c0d49dad7a4b..16dcf8bd1a4e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -306,7 +306,7 @@ struct swap_info_struct {
 					/* list of cluster that are fragmented or contented */
 	unsigned int frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int pages;		/* total of usable pages of swap */
-	unsigned int inuse_pages;	/* number of those currently in use */
+	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e620b41c3120..4e629536a07c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -128,6 +128,25 @@ static inline unsigned char swap_count(unsigned char ent)
 	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
 }
 
+/*
+ * Use the second highest bit of inuse_pages as the indicator
+ * of if one swap device is on the allocation plist.
+ *
+ * inuse_pages is the only thing decides of a device should be on
+ * list or not (except swapoff as a special case). By embedding the
+ * on-list bit into it, updaters don't need any lock to check the
+ * device list status.
+ *
+ * This bit will be set to 1 if the device is not on the plist and not
+ * usable, will be cleared if the device is on the plist.
+ */
+#define SWAP_USAGE_OFFLIST_BIT (1UL << (BITS_PER_TYPE(atomic_t) - 2))
+#define SWAP_USAGE_COUNTER_MASK (~SWAP_USAGE_OFFLIST_BIT)
+static long swap_usage_in_pages(struct swap_info_struct *si)
+{
+	return atomic_long_read(&si->inuse_pages) & SWAP_USAGE_COUNTER_MASK;
+}
+
 /* Reclaim the swap entry anyway if possible */
 #define TTRS_ANYWAY		0x1
 /*
@@ -709,7 +728,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	int nr_reclaim;
 
 	if (force)
-		to_scan = si->inuse_pages / SWAPFILE_CLUSTER;
+		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
 	while (!list_empty(&si->full_clusters)) {
 		ci = list_first_entry(&si->full_clusters, struct swap_cluster_info, list);
@@ -860,42 +879,121 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	return found;
 }
 
-static void __del_from_avail_list(struct swap_info_struct *si)
+/*
+ * SWAP_USAGE_OFFLIST_BIT can only be cleared by this helper and synced with
+ * counter updaters with atomic.
+ */
+static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 {
 	int nid;
 
-	assert_spin_locked(&si->lock);
+	spin_lock(&swap_avail_lock);
+
+	if (swapoff) {
+		/* Clear SWP_WRITEOK so add_to_avail_list won't add it back */
+		si->flags &= ~SWP_WRITEOK;
+
+		/* Force take it off. */
+		atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
+	} else {
+		/*
+		 * If not swapoff, take it off-list only when it's full and
+		 * SWAP_USAGE_OFFLIST_BIT is not set (inuse_pages == pages).
+		 * The cmpxchg below will fail and skip the removal if there
+		 * are slots freed or device is off-listed by someone else.
+		 */
+		if (atomic_long_cmpxchg(&si->inuse_pages, si->pages,
+					si->pages | SWAP_USAGE_OFFLIST_BIT) != si->pages)
+			goto skip;
+	}
+
 	for_each_node(nid)
 		plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]);
+
+skip:
+	spin_unlock(&swap_avail_lock);
 }
 
-static void del_from_avail_list(struct swap_info_struct *si)
+/*
+ * SWAP_USAGE_OFFLIST_BIT can only be set by this helper and synced with
+ * counter updaters with atomic.
+ */
+static void add_to_avail_list(struct swap_info_struct *si, bool swapon)
 {
+	int nid;
+	long val;
+	bool swapoff;
+
 	spin_lock(&swap_avail_lock);
-	__del_from_avail_list(si);
+
+	/* Special handling for swapon / swapoff */
+	if (swapon) {
+		si->flags |= SWP_WRITEOK;
+		swapoff = false;
+	} else {
+		swapoff = !(READ_ONCE(si->flags) & SWP_WRITEOK);
+	}
+
+	if (swapoff)
+		goto skip;
+
+	if (!(atomic_long_read(&si->inuse_pages) & SWAP_USAGE_OFFLIST_BIT))
+		goto skip;
+
+	val = atomic_long_fetch_and_relaxed(~SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
+
+	/*
+	 * When device is full and device is on the plist, only one updater will
+	 * see (inuse_pages == si->pages) and will call del_from_avail_list. If
+	 * that updater happen to be here, just skip adding.
+	 */
+	if (val == si->pages) {
+		/* Just like the cmpxchg in del_from_avail_list */
+		if (atomic_long_cmpxchg(&si->inuse_pages, si->pages,
+					si->pages | SWAP_USAGE_OFFLIST_BIT) == si->pages)
+			goto skip;
+	}
+
+	for_each_node(nid)
+		plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
+
+skip:
 	spin_unlock(&swap_avail_lock);
 }
 
-static void swap_range_alloc(struct swap_info_struct *si,
-			     unsigned int nr_entries)
+/*
+ * swap_usage_add / swap_usage_sub are serialized by ci->lock in each cluster
+ * so the total contribution to the global counter should always be positive.
+ */
+static bool swap_usage_add(struct swap_info_struct *si, unsigned int nr_entries)
 {
-	WRITE_ONCE(si->inuse_pages, si->inuse_pages + nr_entries);
-	if (si->inuse_pages == si->pages) {
-		del_from_avail_list(si);
+	long val = atomic_long_add_return_relaxed(nr_entries, &si->inuse_pages);
 
-		if (vm_swap_full())
-			schedule_work(&si->reclaim_work);
+	/* If device is full, SWAP_USAGE_OFFLIST_BIT not set, try off list it */
+	if (val == si->pages) {
+		del_from_avail_list(si, false);
+		return true;
 	}
+
+	return false;
 }
 
-static void add_to_avail_list(struct swap_info_struct *si)
+static void swap_usage_sub(struct swap_info_struct *si, unsigned int nr_entries)
 {
-	int nid;
+	long val = atomic_long_sub_return_relaxed(nr_entries, &si->inuse_pages);
 
-	spin_lock(&swap_avail_lock);
-	for_each_node(nid)
-		plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
-	spin_unlock(&swap_avail_lock);
+	/* If device is off list, try add it back */
+	if (val & SWAP_USAGE_OFFLIST_BIT)
+		add_to_avail_list(si, false);
+}
+
+static void swap_range_alloc(struct swap_info_struct *si,
+			     unsigned int nr_entries)
+{
+	if (swap_usage_add(si, nr_entries)) {
+		if (vm_swap_full())
+			schedule_work(&si->reclaim_work);
+	}
 }
 
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
@@ -913,8 +1011,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	for (i = 0; i < nr_entries; i++)
 		clear_bit(offset + i, si->zeromap);
 
-	if (si->inuse_pages == si->pages)
-		add_to_avail_list(si);
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
 			si->bdev->bd_disk->fops->swap_slot_free_notify;
@@ -928,13 +1024,13 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	}
 	clear_shadow_from_swap_cache(si->type, begin, end);
 
+	atomic_long_add(nr_entries, &nr_swap_pages);
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
 	 * only after the above cleanups are done.
 	 */
 	smp_wmb();
-	atomic_long_add(nr_entries, &nr_swap_pages);
-	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
+	swap_usage_sub(si, nr_entries);
 }
 
 static int cluster_alloc_swap(struct swap_info_struct *si,
@@ -1020,19 +1116,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		spin_lock(&si->lock);
-		if ((si->inuse_pages == si->pages) || !(si->flags & SWP_WRITEOK)) {
-			spin_lock(&swap_avail_lock);
-			if (plist_node_empty(&si->avail_lists[node])) {
-				spin_unlock(&si->lock);
-				goto nextsi;
-			}
-			WARN(!(si->flags & SWP_WRITEOK),
-			     "swap_info %d in list but !SWP_WRITEOK\n",
-			     si->type);
-			__del_from_avail_list(si);
-			spin_unlock(&si->lock);
-			goto nextsi;
-		}
 		n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
 					    n_goal, swp_entries, order);
 		spin_unlock(&si->lock);
@@ -1041,7 +1124,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		cond_resched();
 
 		spin_lock(&swap_avail_lock);
-nextsi:
 		/*
 		 * if we got here, it's likely that si was almost full before,
 		 * and since scan_swap_map_slots() can drop the si->lock,
@@ -1773,7 +1855,7 @@ unsigned int count_swap_pages(int type, int free)
 		if (sis->flags & SWP_WRITEOK) {
 			n = sis->pages;
 			if (free)
-				n -= sis->inuse_pages;
+				n -= swap_usage_in_pages(sis);
 		}
 		spin_unlock(&sis->lock);
 	}
@@ -2108,7 +2190,7 @@ static int try_to_unuse(unsigned int type)
 	swp_entry_t entry;
 	unsigned int i;
 
-	if (!READ_ONCE(si->inuse_pages))
+	if (!swap_usage_in_pages(si))
 		goto success;
 
 retry:
@@ -2121,7 +2203,7 @@ static int try_to_unuse(unsigned int type)
 
 	spin_lock(&mmlist_lock);
 	p = &init_mm.mmlist;
-	while (READ_ONCE(si->inuse_pages) &&
+	while (swap_usage_in_pages(si) &&
 	       !signal_pending(current) &&
 	       (p = p->next) != &init_mm.mmlist) {
 
@@ -2149,7 +2231,7 @@ static int try_to_unuse(unsigned int type)
 	mmput(prev_mm);
 
 	i = 0;
-	while (READ_ONCE(si->inuse_pages) &&
+	while (swap_usage_in_pages(si) &&
 	       !signal_pending(current) &&
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
@@ -2184,7 +2266,7 @@ static int try_to_unuse(unsigned int type)
 	 * folio_alloc_swap(), temporarily hiding that swap.  It's easy
 	 * and robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (READ_ONCE(si->inuse_pages)) {
+	if (swap_usage_in_pages(si)) {
 		if (!signal_pending(current))
 			goto retry;
 		return -EINTR;
@@ -2193,7 +2275,7 @@ static int try_to_unuse(unsigned int type)
 success:
 	/*
 	 * Make sure that further cleanups after try_to_unuse() returns happen
-	 * after swap_range_free() reduces si->inuse_pages to 0.
+	 * after swap_range_free() reduces inuse_pages to 0.
 	 */
 	smp_mb();
 	return 0;
@@ -2211,7 +2293,7 @@ static void drain_mmlist(void)
 	unsigned int type;
 
 	for (type = 0; type < nr_swapfiles; type++)
-		if (swap_info[type]->inuse_pages)
+		if (swap_usage_in_pages(swap_info[type]))
 			return;
 	spin_lock(&mmlist_lock);
 	list_for_each_safe(p, next, &init_mm.mmlist)
@@ -2390,7 +2472,6 @@ static void setup_swap_info(struct swap_info_struct *si, int prio,
 
 static void _enable_swap_info(struct swap_info_struct *si)
 {
-	si->flags |= SWP_WRITEOK;
 	atomic_long_add(si->pages, &nr_swap_pages);
 	total_swap_pages += si->pages;
 
@@ -2407,9 +2488,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 	 */
 	plist_add(&si->list, &swap_active_head);
 
-	/* add to available list if swap device is not full */
-	if (si->inuse_pages < si->pages)
-		add_to_avail_list(si);
+	/* Add back to available list */
+	add_to_avail_list(si, true);
 }
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
@@ -2507,7 +2587,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		goto out_dput;
 	}
 	spin_lock(&p->lock);
-	del_from_avail_list(p);
+	del_from_avail_list(p, true);
 	if (p->prio < 0) {
 		struct swap_info_struct *si = p;
 		int nid;
@@ -2525,7 +2605,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	plist_del(&p->list, &swap_active_head);
 	atomic_long_sub(p->pages, &nr_swap_pages);
 	total_swap_pages -= p->pages;
-	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
 
@@ -2705,7 +2784,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	}
 
 	bytes = K(si->pages);
-	inuse = K(READ_ONCE(si->inuse_pages));
+	inuse = K(swap_usage_in_pages(si));
 
 	file = si->swap_file;
 	len = seq_file_path(swap, file, " \t\n\\");
@@ -2822,6 +2901,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 	}
 	spin_lock_init(&p->lock);
 	spin_lock_init(&p->cont_lock);
+	atomic_long_set(&p->inuse_pages, SWAP_USAGE_OFFLIST_BIT);
 	init_completion(&p->comp);
 
 	return p;
@@ -3319,7 +3399,7 @@ void si_swapinfo(struct sysinfo *val)
 		struct swap_info_struct *si = swap_info[type];
 
 		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
-			nr_to_be_unused += READ_ONCE(si->inuse_pages);
+			nr_to_be_unused += swap_usage_in_pages(si);
 	}
 	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
 	val->totalswap = total_swap_pages + nr_to_be_unused;
-- 
2.47.0



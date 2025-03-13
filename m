Return-Path: <linux-kernel+bounces-560040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E325BA5FCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469283B66EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE6D155382;
	Thu, 13 Mar 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpEKx1wU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5C269D1F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885308; cv=none; b=Fx/Tir/+l0/IyymXnzlhJj7anipnu9q/3gQnZ3TCy9YtOq+wGAeeDZQDmZbKoUNDR1HoeLWwpfdyk/pKrOjBJEJaSbm2wkeqhYoGlVoUjSD+U6n4DXoIL+SF3SEm/8DwcIh98IJuSVaAMLtKNsEigt8XpdIVnxlsX+DllyX9KtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885308; c=relaxed/simple;
	bh=aIOuQ/xcnK88foK7jgT/0Y0/5Jo5E4EtYH3GjP/WFE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdyBM2BZNMEgl1YX65NVRBnXO9IhwYmLt3+53neH1ZNNv7pPL26wgqJACv69h4tKJmeIgrLFcCspJ9TA0eLc0MkbueFcDVcrBE004OanG9nuSfhbr9mrPrb+SyraZxNKwxXv6SVG4xtxCcdAsTZckQCqud149wL09Zuc/69l4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpEKx1wU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so23228115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741885303; x=1742490103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xT7r++KWm+yhA0y9xoo8iW6UiQaXdC44FZhlKbL5P4=;
        b=IpEKx1wULmzVibx1K+5l3ViooU8/A7fAl+bepDbVnt0AqR9TAsSeCnKO0RUSUWzI/Z
         rES9GT+DdwnYG0jBJvoi0HWDRIVTAHVxKMzEE4ySLu7+6b0uK7FtJQr7QbgQeo1J/jQ8
         06eD1aYvrgUptzEOfRU0lAQLYHIshPa72xXnxkmdWhaNpSeI9w4T/diOfikZCfQnwhy7
         Iw2CZeSdxi5HHzOOD37B77Kv7K66av39cZSY180cRYOnpF+CWRD/5ShAWEJQYuQIpApy
         5SuAQJ6ZstSJ3eJyVWjaj84fxpZcdjKn5eMRaYge06GyZSZBRJa4m3nLe4XisODJkhnk
         XmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885303; x=1742490103;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xT7r++KWm+yhA0y9xoo8iW6UiQaXdC44FZhlKbL5P4=;
        b=tIa5BroilduHYzEL6AoN9lOJqCUJRk0vxZfs+hTs5/ieNzwnejzobHKxCI2wIaDT7J
         hjAwDuWs2aBy3B0R89uYd6KS//0j6uKfn15PN2tYbKOwSM6zU/tPOlsFrKMn0zH6cXad
         DhnCglpcAegK1ZTSVvYJisAMQnYQ/9imYW/GJ4VU6v6K41hI+FNtgEO1+PfoWMIZhLxa
         oEKZqBcivBTDmM35Kl+OoJiGEdMMn+wvGc6BlCd4ySPlLD4YUmakezHcuRcUqRVRmFX3
         WCjnr0JLqtPnG1f9+FbLwnK4bd+gGCGqNf+Kj5FUxAhMQjeei+X3yKVqFH+lplINicCN
         T6/A==
X-Forwarded-Encrypted: i=1; AJvYcCUz2sa2OMdwWCI17LL+BAvngC9CFv4xpzt2DaTmioJcwOL3kkdjze248V2NFtO86LJH0bu1QLH83Ezk/mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9odmKS/0phdTbfrSuu89ddKto/XMbPKK6jA9kj+If9YgXD9Z
	lrkCt7n/x8tML+gVRLM6cRNHhN3Lg3v0kWWga8d43ptf8yhVguoo
X-Gm-Gg: ASbGnctAawXiEz5UgQLMElVCwRtShAVovxho4263h43bodoFonVZrtt6PFD904Zy4bm
	ZedbYH14jbPGHzhky9AS1r1UbvFtDypxvuoQlZ9GyEg7XtZ+sM4T2CVW4SvvV/h30sL52WFB5hD
	yjalG4zjwrI37W5NCblyFPoVyP19hktLGMnBI2JEQHJToIMY9FfzCqNPihmD5Jl4jS4Y+QGlcEz
	PrVWC8aAu3sgy1wco026Fsf1/F2AMvYf98VCvqtzvxEDSk9h6C+apvkKIcXTglDjHMyGwEtdQBu
	vrLD839VK0IFY5/PNFX3WgV0WqKHF8FdtSFtFZmr0tGVdFl7mkmwyMTnu6zjXx5Kmg==
X-Google-Smtp-Source: AGHT+IF3acUoheQV1BNR2DazXaoGGKrp5f62d5qSOJdcT9nhrgJYz8mDk/o5zexLyd1VkZE717bxcg==
X-Received: by 2002:a05:6a00:194c:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-736eb7a0176mr16562303b3a.4.1741885302958;
        Thu, 13 Mar 2025 10:01:42 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1613529b3a.93.2025.03.13.10.01.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Mar 2025 10:01:42 -0700 (PDT)
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
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 5/7] mm, swap: use percpu cluster as allocation fast path
Date: Fri, 14 Mar 2025 00:59:33 +0800
Message-ID: <20250313165935.63303-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313165935.63303-1-ryncsn@gmail.com>
References: <20250313165935.63303-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Current allocation workflow first traverses the plist with a global lock
held, after choosing a device, it uses the percpu cluster on that swap
device.  This commit moves the percpu cluster variable out of being tied
to individual swap devices, making it a global percpu variable, and will
be used directly for allocation as a fast path.

The global percpu cluster variable will never point to a HDD device, and
allocations on a HDD device are still globally serialized.

This improves the allocator performance and prepares for removal of the
slot cache in later commits.  There shouldn't be much observable behavior
change, except one thing: this changes how swap device allocation rotation
works.

Currently, each allocation will rotate the plist, and because of the
existence of slot cache (one order 0 allocation usually returns 64
entries), swap devices of the same priority are rotated for every 64 order
0 entries consumed.  High order allocations are different, they will
bypass the slot cache, and so swap device is rotated for every 16K, 32K,
or up to 2M allocation.

The rotation rule was never clearly defined or documented, it was changed
several times without mentioning.

After this commit, and once slot cache is gone in later commits, swap
device rotation will happen for every consumed cluster.  Ideally non-HDD
devices will be rotated if 2M space has been consumed for each order.
Fragmented clusters will rotate the device faster, which seems OK.  HDD
devices is rotated for every allocation regardless of the allocation
order, which should be OK too and trivial.

This commit also slightly changes allocation behaviour for slot cache.
The new added cluster allocation fast path may allocate entries from
different device to the slot cache, this is not observable from user
space, only impact performance very slightly, and slot cache will be just
gone in next commit, so this can be ignored.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  11 ++-
 mm/swapfile.c        | 158 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 121 insertions(+), 48 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe91c293636..374bffc87427 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -284,12 +284,10 @@ enum swap_cluster_flags {
 #endif
 
 /*
- * We assign a cluster to each CPU, so each CPU can allocate swap entry from
- * its own cluster and swapout sequentially. The purpose is to optimize swapout
- * throughput.
+ * We keep using same cluster for rotational device so IO will be sequential.
+ * The purpose is to optimize SWAP throughput on these device.
  */
-struct percpu_cluster {
-	local_lock_t lock; /* Protect the percpu_cluster above */
+struct swap_sequential_cluster {
 	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
@@ -315,8 +313,7 @@ struct swap_info_struct {
 	atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
-	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
-	struct percpu_cluster *global_cluster; /* Use one global cluster for rotating device */
+	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
 	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index db836670c334..8b296c4c636b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -116,6 +116,18 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
+struct percpu_swap_cluster {
+	struct swap_info_struct *si[SWAP_NR_ORDERS];
+	unsigned long offset[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
+	.si = { NULL },
+	.offset = { SWAP_ENTRY_INVALID },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
 	if (type >= MAX_SWAPFILES)
@@ -539,7 +551,7 @@ static bool swap_do_scheduled_discard(struct swap_info_struct *si)
 		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
 		/*
 		 * Delete the cluster from list to prepare for discard, but keep
-		 * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
+		 * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster could be
 		 * pointing to it, or ran into by relocate_cluster.
 		 */
 		list_del(&ci->list);
@@ -805,10 +817,12 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
-	if (si->flags & SWP_SOLIDSTATE)
-		__this_cpu_write(si->percpu_cluster->next[order], next);
-	else
+	if (si->flags & SWP_SOLIDSTATE) {
+		this_cpu_write(percpu_swap_cluster.offset[order], next);
+		this_cpu_write(percpu_swap_cluster.si[order], si);
+	} else {
 		si->global_cluster->next[order] = next;
+	}
 	return found;
 }
 
@@ -862,20 +876,18 @@ static void swap_reclaim_work(struct work_struct *work)
 }
 
 /*
- * Try to get swap entries with specified order from current cpu's swap entry
- * pool (a cluster). This might involve allocating a new cluster for current CPU
- * too.
+ * Try to allocate swap entries with specified order and try set a new
+ * cluster for current CPU too.
  */
 static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
 					      unsigned char usage)
 {
 	struct swap_cluster_info *ci;
-	unsigned int offset, found = 0;
+	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 
 	if (si->flags & SWP_SOLIDSTATE) {
-		/* Fast path using per CPU cluster */
-		local_lock(&si->percpu_cluster->lock);
-		offset = __this_cpu_read(si->percpu_cluster->next[order]);
+		if (si == this_cpu_read(percpu_swap_cluster.si[order]))
+			offset = this_cpu_read(percpu_swap_cluster.offset[order]);
 	} else {
 		/* Serialize HDD SWAP allocation for each device. */
 		spin_lock(&si->global_cluster_lock);
@@ -973,9 +985,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		}
 	}
 done:
-	if (si->flags & SWP_SOLIDSTATE)
-		local_unlock(&si->percpu_cluster->lock);
-	else
+	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
 	return found;
 }
@@ -1196,6 +1206,51 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	return true;
 }
 
+/*
+ * Fast path try to get swap entries with specified order from current
+ * CPU's swap entry pool (a cluster).
+ */
+static int swap_alloc_fast(swp_entry_t entries[],
+			   unsigned char usage,
+			   int order, int n_goal)
+{
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *si;
+	unsigned int offset, found;
+	int n_ret = 0;
+
+	n_goal = min(n_goal, SWAP_BATCH);
+
+	/*
+	 * Once allocated, swap_info_struct will never be completely freed,
+	 * so checking it's liveness by get_swap_device_info is enough.
+	 */
+	si = this_cpu_read(percpu_swap_cluster.si[order]);
+	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
+	if (!si || !offset || !get_swap_device_info(si))
+		return 0;
+
+	while (offset) {
+		ci = lock_cluster(si, offset);
+		if (!cluster_is_usable(ci, order)) {
+			unlock_cluster(ci);
+			break;
+		}
+		if (cluster_is_empty(ci))
+			offset = cluster_offset(si, ci);
+		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
+		if (!found)
+			break;
+		entries[n_ret++] = swp_entry(si->type, found);
+		if (n_ret == n_goal)
+			break;
+		offset = this_cpu_read(percpu_swap_cluster.offset[order]);
+	}
+
+	put_swap_device(si);
+	return n_ret;
+}
+
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 {
 	int order = swap_entry_order(entry_order);
@@ -1204,19 +1259,36 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	int n_ret = 0;
 	int node;
 
+	/* Fast path using percpu cluster */
+	local_lock(&percpu_swap_cluster.lock);
+	n_ret = swap_alloc_fast(swp_entries,
+				SWAP_HAS_CACHE,
+				order, n_goal);
+	if (n_ret == n_goal)
+		goto out;
+
+	n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
+	/* Rotate the device and switch to a new cluster */
 	spin_lock(&swap_avail_lock);
 start_over:
 	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
-		/* requeue si to after same-priority siblings */
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-					n_goal, swp_entries, order);
+			/*
+			 * For order 0 allocation, try best to fill the request
+			 * as it's used by slot cache.
+			 *
+			 * For mTHP allocation, it always have n_goal == 1,
+			 * and falling a mTHP swapin will just make the caller
+			 * fallback to order 0 allocation, so just bail out.
+			 */
+			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
+					swp_entries + n_ret, order);
 			put_swap_device(si);
 			if (n_ret || size > 1)
-				goto check_out;
+				goto out;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1234,12 +1306,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		if (plist_node_empty(&next->avail_lists[node]))
 			goto start_over;
 	}
-
 	spin_unlock(&swap_avail_lock);
-
-check_out:
+out:
+	local_unlock(&percpu_swap_cluster.lock);
 	atomic_long_sub(n_ret * size, &nr_swap_pages);
-
 	return n_ret;
 }
 
@@ -2597,6 +2667,28 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	}
 }
 
+/*
+ * Called after swap device's reference count is dead, so
+ * neither scan nor allocation will use it.
+ */
+static void flush_percpu_swap_cluster(struct swap_info_struct *si)
+{
+	int cpu, i;
+	struct swap_info_struct **pcp_si;
+
+	for_each_possible_cpu(cpu) {
+		pcp_si = per_cpu_ptr(percpu_swap_cluster.si, cpu);
+		/*
+		 * Invalidate the percpu swap cluster cache, si->users
+		 * is dead, so no new user will point to it, just flush
+		 * any existing user.
+		 */
+		for (i = 0; i < SWAP_NR_ORDERS; i++)
+			cmpxchg(&pcp_si[i], si, NULL);
+	}
+}
+
+
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2698,6 +2790,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	flush_work(&p->discard_work);
 	flush_work(&p->reclaim_work);
+	flush_percpu_swap_cluster(p);
 
 	destroy_swap_extents(p);
 	if (p->flags & SWP_CONTINUED)
@@ -2725,8 +2818,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
@@ -3125,7 +3216,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 	struct swap_cluster_info *cluster_info;
 	unsigned long i, j, idx;
-	int cpu, err = -ENOMEM;
+	int err = -ENOMEM;
 
 	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
@@ -3134,20 +3225,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	if (si->flags & SWP_SOLIDSTATE) {
-		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
-		if (!si->percpu_cluster)
-			goto err_free;
-
-		for_each_possible_cpu(cpu) {
-			struct percpu_cluster *cluster;
-
-			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
-			for (i = 0; i < SWAP_NR_ORDERS; i++)
-				cluster->next[i] = SWAP_ENTRY_INVALID;
-			local_lock_init(&cluster->lock);
-		}
-	} else {
+	if (!(si->flags & SWP_SOLIDSTATE)) {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
 				     GFP_KERNEL);
 		if (!si->global_cluster)
@@ -3424,8 +3502,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-	free_percpu(si->percpu_cluster);
-	si->percpu_cluster = NULL;
 	kfree(si->global_cluster);
 	si->global_cluster = NULL;
 	inode = NULL;
-- 
2.48.1



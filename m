Return-Path: <linux-kernel+bounces-515459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C5A3651B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06783AF585
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66737269AE2;
	Fri, 14 Feb 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKWWNB34"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93E2690CA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555930; cv=none; b=HOmyfkKyE9MD+7/BTxzaJbk6tLkIxOasdbH4L9Fxt3TDgM5lof92/qV0TIx4eaMwIIdXk0cWBghIQnFpR6YmJSKVo2VbHIHxcFP0E/R0b6nDS2m8O6mbwFW+MLmW+haZpuY7WR2H43ap/sNx/vrzBhf2Se41CAsm/v9t2Ckj97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555930; c=relaxed/simple;
	bh=gm86JVcjyCY787R716UEluROgdOhi2sjssZNxy6jE24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSil5CuFCZ/WIPT0Qplt34jFAIW2l5uZmQHFLGPiWdUND7VcvVWMHKyHcWkSZypiSDv7LNTKyG/Y9OXvjywF1FlpgYSKzreQfTh6SoEXfOFt4WJ8uAdRQjHH2/gE5EJX03tgmtUYxaY4SBmthDu3cK7TDXCrkLgLm3h+ZVKXUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKWWNB34; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d398bea9so33916585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555928; x=1740160728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dCFAluMOzAQvK61QbUUUqwSef8skzDGJtN8wrwwO2c=;
        b=lKWWNB34ct0ME56sofgUj8cPtCiS49H5m14lz9wM5W/nVLesxhTB2fLCQfvh5MHH02
         7S1jIUnrJk64+zoCJJqoPqsOi8WCVjOBR2VtfxsanUkcQ64tL1uaJUDtEYS3qABU/kvx
         qQX26aJ57a7PTwf7AgZXBOpUcjMlEAk11cg/ohVxKezCNGp/qTTUhb7xGUgSEIcpxGhc
         fQzpZpCJN0FRdDJH03csYacpjOB7UeM1OH7c+xLdjyq/uBXXQHHoxKN3oH4pG7C+n4uB
         XHbi9/TkfD3CiuZeufLb+o5a6Pc8oO/g1Ea5N3lOToYWGUSYCYeRZRsWpK8+Dw8qvUWi
         cV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555928; x=1740160728;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dCFAluMOzAQvK61QbUUUqwSef8skzDGJtN8wrwwO2c=;
        b=XR9rr6tqBregL6CFsFSVH8gYlcxhYWKvxUAF4FpDVwFDMQpqz/HxGzntyJZ8GDC9Hk
         8xaxmbYcVPEoZUMsibvH3GjaTinupuKgO9QZNUYHMpZijYpPkpZ5FLy4KGURmZoFkhMQ
         AZ13hzMm6QqJAD2Qth0ZutsIIyAMwXeBODN5ZgpJjoddUy06lAaCGjdu9NOwzx8S0lqJ
         fI3ux59ywQUGZnX1aKxSOww76ZlWGeVPZoFYqYmf8J4qtDTZimx6+Bl7Wv6ccEMW4Vjn
         PyQjaaRxmH8fgw1cfGUld6RmM3Ve6OefelalU5uVKCnq9mAXwUSICKkPachriTLnWnY/
         cUMw==
X-Forwarded-Encrypted: i=1; AJvYcCXfu9KTBbSNOMC1Unqjvw9K6IItuWG8irq5ibBbBv5CbLg27PC3ShJza9SKZ56hxixP1nqQR7Y0rtPg5NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjj1cEPCPcY60Cn9Pdx26j4lnS3HlNhi0PbOLR82WHRnUFFraL
	NPa8pFdkxw7NXS/h97ivAm4zd/kdjFn5ghm4hnbi8XNv1Y0JmMGf
X-Gm-Gg: ASbGnctZukrRh25bgotSJmr19fDOvV61vy0xVJ05DJGAb4bMBikUqVtPfIwsEjgnw1t
	SafgxomZ657vm9vkpUm/FBrWqWCWdr+SFsDsmwpPxoNl462zKce1N9ekocLyYIn8zrTlrBoElLf
	sIkCh7iv0q/WZlbi4kuhLTzX0MYLFvwrThaU8z6WTHbbPSscg70q7sX3dqKORy9D5nkfVqgDZRv
	m9I8NmitrxUou1E9yBMGkSfa9tsHYsjpYRzS0IxXi8+St4Ff2W72i3aCxnsCfDZQFM+HH5F5kLL
	N9HtX7Z8CzA6jjNIz6D0Ia+qwTjsEBhTpK+B
X-Google-Smtp-Source: AGHT+IEGQxigwy9i4C5LjKLVWwRE3ILrRt8Bj7f0chMUrukyyWwUbg5alAHyT9i/np1CLUlPEgoenQ==
X-Received: by 2002:a17:903:2301:b0:21f:6ce1:7410 with SMTP id d9443c01a7336-2210405d629mr2962655ad.24.1739555927679;
        Fri, 14 Feb 2025 09:58:47 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55943b5sm31216605ad.246.2025.02.14.09.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 09:58:47 -0800 (PST)
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
Subject: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
Date: Sat, 15 Feb 2025 01:57:07 +0800
Message-ID: <20250214175709.76029-6-ryncsn@gmail.com>
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

Current allocation workflow first traverses the plist with a global lock
held, after choosing a device, it uses the percpu cluster on that swap
device. This commit moves the percpu cluster variable out of being tied
to individual swap devices, making it a global percpu variable, and will
be used directly for allocation as a fast path.

The global percpu cluster variable will never point to a HDD device, and
allocation on HDD devices is still globally serialized.

This improves the allocator performance and prepares for removal of the
slot cache in later commits. There shouldn't be much observable behavior
change, except one thing: this changes how swap device allocation
rotation works.

Currently, each allocation will rotate the plist, and because of the
existence of slot cache (64 entries), swap devices of the same priority
are rotated for every 64 entries consumed. And, high order allocations
are different, they will bypass the slot cache, and so swap device is
rotated for every 16K, 32K, or up to 2M allocation.

The rotation rule was never clearly defined or documented, it was changed
several times without mentioning too.

After this commit, once slot cache is gone in later commits, swap device
rotation will happen for every consumed cluster. Ideally non-HDD devices
will be rotated if 2M space has been consumed for each order, this seems
reasonable. HDD devices is rotated for every allocation regardless of the
allocation order, which should be OK and trivial.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  11 ++--
 mm/swapfile.c        | 120 +++++++++++++++++++++++++++----------------
 2 files changed, 79 insertions(+), 52 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2fe91c293636..a8d84f22357e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -284,12 +284,10 @@ enum swap_cluster_flags {
 #endif
 
 /*
- * We assign a cluster to each CPU, so each CPU can allocate swap entry from
- * its own cluster and swapout sequentially. The purpose is to optimize swapout
- * throughput.
+ * We keep using same cluster for rotating device so swapout will be sequential.
+ * The purpose is to optimize swapout throughput on rotating device.
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
index ae3bd0a862fc..791cd7ed5bdf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -116,6 +116,18 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
+struct percpu_swap_cluster {
+	struct swap_info_struct *si;
+	unsigned long offset[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
+	.si = NULL,
+	.offset = { SWAP_ENTRY_INVALID },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
 	if (type >= MAX_SWAPFILES)
@@ -548,7 +560,7 @@ static bool swap_do_scheduled_discard(struct swap_info_struct *si)
 		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
 		/*
 		 * Delete the cluster from list to prepare for discard, but keep
-		 * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
+		 * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster could be
 		 * pointing to it, or ran into by relocate_cluster.
 		 */
 		list_del(&ci->list);
@@ -815,10 +827,12 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
-	if (si->flags & SWP_SOLIDSTATE)
-		__this_cpu_write(si->percpu_cluster->next[order], next);
-	else
+	if (si->flags & SWP_SOLIDSTATE) {
+		__this_cpu_write(percpu_swap_cluster.si, si);
+		__this_cpu_write(percpu_swap_cluster.offset[order], next);
+	} else {
 		si->global_cluster->next[order] = next;
+	}
 	return found;
 }
 
@@ -869,9 +883,8 @@ static void swap_reclaim_work(struct work_struct *work)
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
@@ -879,18 +892,12 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	struct swap_cluster_info *ci;
 	unsigned int offset, found = 0;
 
-	if (si->flags & SWP_SOLIDSTATE) {
-		/* Fast path using per CPU cluster */
-		local_lock(&si->percpu_cluster->lock);
-		offset = __this_cpu_read(si->percpu_cluster->next[order]);
-	} else {
+	if (!(si->flags & SWP_SOLIDSTATE)) {
 		/* Serialize HDD SWAP allocation for each device. */
 		spin_lock(&si->global_cluster_lock);
 		offset = si->global_cluster->next[order];
-	}
-
-	if (offset) {
 		ci = lock_cluster(si, offset);
+
 		/* Cluster could have been used by another order */
 		if (cluster_is_usable(ci, order)) {
 			if (cluster_is_empty(ci))
@@ -980,9 +987,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
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
@@ -1203,6 +1208,41 @@ static bool get_swap_device_info(struct swap_info_struct *si)
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
+	si = __this_cpu_read(percpu_swap_cluster.si);
+	offset = __this_cpu_read(percpu_swap_cluster.offset[order]);
+	if (!si || !offset || !get_swap_device_info(si))
+		return 0;
+
+	while (offset) {
+		ci = lock_cluster(si, offset);
+		found = alloc_swap_scan_cluster(si, ci, offset, order, usage);
+		if (!found)
+			break;
+		entries[n_ret++] = swp_entry(si->type, found);
+		if (n_ret == n_goal)
+			break;
+		offset = __this_cpu_read(percpu_swap_cluster.offset[order]);
+	}
+
+	put_swap_device(si);
+	return n_ret;
+}
+
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 {
 	int order = swap_entry_order(entry_order);
@@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
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
+			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
+					swp_entries + n_ret, order);
 			put_swap_device(si);
 			if (n_ret || size > 1)
-				goto check_out;
+				goto out;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1241,12 +1290,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
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
 
@@ -2733,8 +2780,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
-	free_percpu(p->percpu_cluster);
-	p->percpu_cluster = NULL;
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
@@ -3133,7 +3178,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 	struct swap_cluster_info *cluster_info;
 	unsigned long i, j, idx;
-	int cpu, err = -ENOMEM;
+	int err = -ENOMEM;
 
 	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
@@ -3142,20 +3187,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
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
@@ -3432,8 +3464,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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



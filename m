Return-Path: <linux-kernel+bounces-376854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95EC9AB6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22605B22D90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CB1CB50A;
	Tue, 22 Oct 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9jCcZT3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668C1CB33F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625397; cv=none; b=gHshAqzOO4o9vdmY1LmC3n7B6VyA9voRAZVvSXg3kWm1l1esZFWtQ7Ks7F3QT88fz21jfLEJk/n9rMqR7tvvF6OiizTqghTZg7X0xEe7AKiK2kJYwCZkpeBO+7VxgKdMI0fCzrtlmYmXF9dCE+8PtAktR9OWj9owxlrdHrVshFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625397; c=relaxed/simple;
	bh=f1FjOYXu1AY1uLFNvK/HRXZ26GdUBZXnpiCZ4GADHhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWcJG/jqjcoOJMCseVoDwr84bffK+Lbn6qeglrM3saHaXCkyyTNkUnN2bvNuE8ks0PM09EFLi+0YyfawnVkzZr4qLz71wABX+eS1DdB18IhjwEC1fqNUnORL7Wq7Do/EIfcKqO6rlLaAaZnvS4Y/i/VKsJDariW8eo21C8mLr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9jCcZT3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c7edf2872so1125485ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625395; x=1730230195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3VbfK94vYMM7w9zgk7A3WhLYxN2WUErtpJ6jwxCUlfQ=;
        b=e9jCcZT3shqUCYQtlTBJhOTA/ErrBnPgkBGhu6eevYqqIxml6P8Lhr/a/Muii5IJ4c
         QnY3VcdnLo1wPcVmd0wfIW7Gv5gdyBvWZNhGuUVirSpJWXXf9WUEQAbjCKGFQI6lEkFk
         SvkIoQ5o7/XKLK49CqHKYC2ojaNRhHWiyczaiTelrcIUWp3wM2hJ/MoTpWwPimx6uS53
         CMH3NwTXdWbOegXSRnSdf/BDZwJisXNv4d6Pjb/M9NC3+qmAwktqdwzct3ePapsey77l
         vquEzQB319NTT0xIUsiQvi+jw4q5dRD1I3Yt60QOE/897jX2MgTkXCUypGk1VPFus9K3
         Svog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625395; x=1730230195;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VbfK94vYMM7w9zgk7A3WhLYxN2WUErtpJ6jwxCUlfQ=;
        b=i56rddzVR3GMhM49tNhi4fgMqlS31BzVuuFSyiskO9vtnzo/WbaZVLmE5UTficpuJp
         lic7k3oYtx8+GU90YLtiBFZmfJp4lpy/jOPgWCOzUYYMKBZOXfB6fBidm4CMf4BwdE0g
         10nls09diPnNTkpH8yVaBxbivjE0ewy58Y8Xwn2XupfSWF15oF5SP0LWCXcsFR4f+XoP
         azwjRyRWogCRZOawaezWmIurqcrn64erx7luyaLD2wXf1Tcex5zakG4yFR1UnhAIduzx
         Rky6JylPsbgO5HQryw2ebuwngfrg/rszR5H7lH9T7i3J007w9smSOO9rtiPfWFzpuMWc
         xqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVWpkQWrF4bMNyyl4mp+tI5TNMxtxkD9ChQ1ynucLVr6Df1h4/g82O5fOtDlPJd2N9aZ/EvUYvN5vTIqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDQ4JsVxWrz18SkTGXZRU/mNFMe8njBppF/mQ3w3bff0VEMvb
	/lH0jK6Ec3Iy2kHQKiDONTjP5JQSkioeXAbT2WmnynL+LdpasNem
X-Google-Smtp-Source: AGHT+IGC2ct67tQlrbrn/euF7RF/i0JZyKYC9YgNS29vka34ew1P1aDh5IqUWUcc+iJ+99k9cKHp5A==
X-Received: by 2002:a17:902:c40f:b0:20b:6c1e:1e13 with SMTP id d9443c01a7336-20e970c794cmr70541015ad.23.1729625394613;
        Tue, 22 Oct 2024 12:29:54 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.29.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:29:54 -0700 (PDT)
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
Subject: [PATCH 03/13] mm, swap: remove old allocation path for HDD
Date: Wed, 23 Oct 2024 03:24:41 +0800
Message-ID: <20241022192451.38138-4-ryncsn@gmail.com>
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

We are currently using different swap allocation algorithm for HDD and
non-HDD. This leads to the existing of different set of locking, and the
code path is heavily bloated, causing troubles for further optimization
and maintenance.

This commit removes all HDD swap allocation and related dead code, and
use cluster allocation algorithm instead.

The performance may drop a little bit temporarily, and should be
negligible: The main advantage of legacy HDD allocation algorithm
is that is tend to use continuous slots, but swap device gets fragmented
quickly anyway, and the attempt to use continuous slots will fail easily.

This commit also enables mTHP swap on HDD, which should be beneficial,
and following commits will adapt and optimize the cluster allocator
for HDD.

Suggested-by: Chris Li <chrisl@kernel.org>
Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   3 -
 mm/swapfile.c        | 235 ++-----------------------------------------
 2 files changed, 9 insertions(+), 229 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f3e0ac20c2e8..3a71198a6957 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -309,9 +309,6 @@ struct swap_info_struct {
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
 	unsigned int inuse_pages;	/* number of those currently in use */
-	unsigned int cluster_next;	/* likely index for next allocation */
-	unsigned int cluster_nr;	/* countdown to next cluster search */
-	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e1e4a1ba4fc5..ffdf7eedecb5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -989,49 +989,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
 }
 
-static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
-{
-	unsigned long prev;
-
-	if (!(si->flags & SWP_SOLIDSTATE)) {
-		si->cluster_next = next;
-		return;
-	}
-
-	prev = this_cpu_read(*si->cluster_next_cpu);
-	/*
-	 * Cross the swap address space size aligned trunk, choose
-	 * another trunk randomly to avoid lock contention on swap
-	 * address space if possible.
-	 */
-	if ((prev >> SWAP_ADDRESS_SPACE_SHIFT) !=
-	    (next >> SWAP_ADDRESS_SPACE_SHIFT)) {
-		/* No free swap slots available */
-		if (si->highest_bit <= si->lowest_bit)
-			return;
-		next = get_random_u32_inclusive(si->lowest_bit, si->highest_bit);
-		next = ALIGN_DOWN(next, SWAP_ADDRESS_SPACE_PAGES);
-		next = max_t(unsigned int, next, si->lowest_bit);
-	}
-	this_cpu_write(*si->cluster_next_cpu, next);
-}
-
-static bool swap_offset_available_and_locked(struct swap_info_struct *si,
-					     unsigned long offset)
-{
-	if (data_race(!si->swap_map[offset])) {
-		spin_lock(&si->lock);
-		return true;
-	}
-
-	if (vm_swap_full() && READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
-		spin_lock(&si->lock);
-		return true;
-	}
-
-	return false;
-}
-
 static int cluster_alloc_swap(struct swap_info_struct *si,
 			     unsigned char usage, int nr,
 			     swp_entry_t slots[], int order)
@@ -1055,13 +1012,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[], int order)
 {
-	unsigned long offset;
-	unsigned long scan_base;
-	unsigned long last_in_cluster = 0;
-	int latency_ration = LATENCY_LIMIT;
 	unsigned int nr_pages = 1 << order;
-	int n_ret = 0;
-	bool scanned_many = false;
 
 	/*
 	 * We try to cluster swap pages by allocating them sequentially
@@ -1073,7 +1024,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	 * But we do now try to find an empty cluster.  -Andrea
 	 * And we let swap pages go all over an SSD partition.  Hugh
 	 */
-
 	if (order > 0) {
 		/*
 		 * Should not even be attempting large allocations when huge
@@ -1093,158 +1043,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			return 0;
 	}
 
-	if (si->cluster_info)
-		return cluster_alloc_swap(si, usage, nr, slots, order);
-
-	si->flags += SWP_SCANNING;
-
-	/* For HDD, sequential access is more important. */
-	scan_base = si->cluster_next;
-	offset = scan_base;
-
-	if (unlikely(!si->cluster_nr--)) {
-		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
-			si->cluster_nr = SWAPFILE_CLUSTER - 1;
-			goto checks;
-		}
-
-		spin_unlock(&si->lock);
-
-		/*
-		 * If seek is expensive, start searching for new cluster from
-		 * start of partition, to minimize the span of allocated swap.
-		 */
-		scan_base = offset = si->lowest_bit;
-		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
-
-		/* Locate the first empty (unaligned) cluster */
-		for (; last_in_cluster <= READ_ONCE(si->highest_bit); offset++) {
-			if (si->swap_map[offset])
-				last_in_cluster = offset + SWAPFILE_CLUSTER;
-			else if (offset == last_in_cluster) {
-				spin_lock(&si->lock);
-				offset -= SWAPFILE_CLUSTER - 1;
-				si->cluster_next = offset;
-				si->cluster_nr = SWAPFILE_CLUSTER - 1;
-				goto checks;
-			}
-			if (unlikely(--latency_ration < 0)) {
-				cond_resched();
-				latency_ration = LATENCY_LIMIT;
-			}
-		}
-
-		offset = scan_base;
-		spin_lock(&si->lock);
-		si->cluster_nr = SWAPFILE_CLUSTER - 1;
-	}
-
-checks:
-	if (!(si->flags & SWP_WRITEOK))
-		goto no_page;
-	if (!si->highest_bit)
-		goto no_page;
-	if (offset > si->highest_bit)
-		scan_base = offset = si->lowest_bit;
-
-	/* reuse swap entry of cache-only swap if not busy. */
-	if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
-		int swap_was_freed;
-		spin_unlock(&si->lock);
-		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT);
-		spin_lock(&si->lock);
-		/* entry was freed successfully, try to use this again */
-		if (swap_was_freed > 0)
-			goto checks;
-		goto scan; /* check next one */
-	}
-
-	if (si->swap_map[offset]) {
-		if (!n_ret)
-			goto scan;
-		else
-			goto done;
-	}
-	memset(si->swap_map + offset, usage, nr_pages);
-
-	swap_range_alloc(si, offset, nr_pages);
-	slots[n_ret++] = swp_entry(si->type, offset);
-
-	/* got enough slots or reach max slots? */
-	if ((n_ret == nr) || (offset >= si->highest_bit))
-		goto done;
-
-	/* search for next available slot */
-
-	/* time to take a break? */
-	if (unlikely(--latency_ration < 0)) {
-		if (n_ret)
-			goto done;
-		spin_unlock(&si->lock);
-		cond_resched();
-		spin_lock(&si->lock);
-		latency_ration = LATENCY_LIMIT;
-	}
-
-	if (si->cluster_nr && !si->swap_map[++offset]) {
-		/* non-ssd case, still more slots in cluster? */
-		--si->cluster_nr;
-		goto checks;
-	}
-
-	/*
-	 * Even if there's no free clusters available (fragmented),
-	 * try to scan a little more quickly with lock held unless we
-	 * have scanned too many slots already.
-	 */
-	if (!scanned_many) {
-		unsigned long scan_limit;
-
-		if (offset < scan_base)
-			scan_limit = scan_base;
-		else
-			scan_limit = si->highest_bit;
-		for (; offset <= scan_limit && --latency_ration > 0;
-		     offset++) {
-			if (!si->swap_map[offset])
-				goto checks;
-		}
-	}
-
-done:
-	if (order == 0)
-		set_cluster_next(si, offset + 1);
-	si->flags -= SWP_SCANNING;
-	return n_ret;
-
-scan:
-	VM_WARN_ON(order > 0);
-	spin_unlock(&si->lock);
-	while (++offset <= READ_ONCE(si->highest_bit)) {
-		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
-			latency_ration = LATENCY_LIMIT;
-			scanned_many = true;
-		}
-		if (swap_offset_available_and_locked(si, offset))
-			goto checks;
-	}
-	offset = si->lowest_bit;
-	while (offset < scan_base) {
-		if (unlikely(--latency_ration < 0)) {
-			cond_resched();
-			latency_ration = LATENCY_LIMIT;
-			scanned_many = true;
-		}
-		if (swap_offset_available_and_locked(si, offset))
-			goto checks;
-		offset++;
-	}
-	spin_lock(&si->lock);
-
-no_page:
-	si->flags -= SWP_SCANNING;
-	return n_ret;
+	return cluster_alloc_swap(si, usage, nr, slots, order);
 }
 
 int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
@@ -2855,8 +2654,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
-	free_percpu(p->cluster_next_cpu);
-	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
 	kvfree(zeromap);
 	kvfree(cluster_info);
@@ -3168,8 +2965,6 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 	}
 
 	si->lowest_bit  = 1;
-	si->cluster_next = 1;
-	si->cluster_nr = 0;
 
 	maxpages = swapfile_maximum_size;
 	last_page = swap_header->info.last_page;
@@ -3255,7 +3050,6 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 						unsigned long maxpages)
 {
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	unsigned long col = si->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
 	struct swap_cluster_info *cluster_info;
 	unsigned long i, j, k, idx;
 	int cpu, err = -ENOMEM;
@@ -3267,15 +3061,6 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	si->cluster_next_cpu = alloc_percpu(unsigned int);
-	if (!si->cluster_next_cpu)
-		goto err_free;
-
-	/* Random start position to help with wear leveling */
-	for_each_possible_cpu(cpu)
-		per_cpu(*si->cluster_next_cpu, cpu) =
-		get_random_u32_inclusive(1, si->highest_bit);
-
 	si->percpu_cluster = alloc_percpu(struct percpu_cluster);
 	if (!si->percpu_cluster)
 		goto err_free;
@@ -3317,7 +3102,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	 * sharing same address space.
 	 */
 	for (k = 0; k < SWAP_CLUSTER_COLS; k++) {
-		j = (k + col) % SWAP_CLUSTER_COLS;
+		j = k % SWAP_CLUSTER_COLS;
 		for (i = 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_COLS); i++) {
 			struct swap_cluster_info *ci;
 			idx = i * SWAP_CLUSTER_COLS + j;
@@ -3467,18 +3252,18 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	if (si->bdev && bdev_nonrot(si->bdev)) {
 		si->flags |= SWP_SOLIDSTATE;
-
-		cluster_info = setup_clusters(si, swap_header, maxpages);
-		if (IS_ERR(cluster_info)) {
-			error = PTR_ERR(cluster_info);
-			cluster_info = NULL;
-			goto bad_swap_unlock_inode;
-		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
 	}
 
+	cluster_info = setup_clusters(si, swap_header, maxpages);
+	if (IS_ERR(cluster_info)) {
+		error = PTR_ERR(cluster_info);
+		cluster_info = NULL;
+		goto bad_swap_unlock_inode;
+	}
+
 	if ((swap_flags & SWAP_FLAG_DISCARD) &&
 	    si->bdev && bdev_max_discard_sectors(si->bdev)) {
 		/*
@@ -3559,8 +3344,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap:
 	free_percpu(si->percpu_cluster);
 	si->percpu_cluster = NULL;
-	free_percpu(si->cluster_next_cpu);
-	si->cluster_next_cpu = NULL;
 	inode = NULL;
 	destroy_swap_extents(si);
 	swap_cgroup_swapoff(si->type);
-- 
2.47.0



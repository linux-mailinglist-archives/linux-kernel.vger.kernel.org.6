Return-Path: <linux-kernel+bounces-376860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00E9AB6CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C41C2336D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC21CB501;
	Tue, 22 Oct 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1F/WHms"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8B1CCECC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625420; cv=none; b=cZmXatVe86t62wI3bD9LQxbI4uudzRU+FykWErRbFTWowoZxjfEpoWdpeBMcW9kQ1qy1e0QgBDmuzsz7055PV57iAYdDNAQtw4X5tFop03U4/A7Bw1S7mW33wEo/VYjBeyhPwLxgK22Vy0F7JNsW+X6pRd5dSL6FWg+0dreXyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625420; c=relaxed/simple;
	bh=mj/CjGxozi3200AqM9jvS9QZ3kbkE9jHXsmJ5+6VXuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee0MFxQp3ZemJiI7POaRzkyS8mMz7HlH2Q/4HlHldheEh88QDm4a2+wIfq6u9Ygbj5OXImwQRRpgjeDyyjLy/J+w+D0HPv1zhH2aM1GTI3apV+6hVAGEh9E8AKSYGBUyra0t2RWzy3D0DfGdSeJJ7Ef+6YkNzZulDX7QfODtAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1F/WHms; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e6981ca77so44522815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625417; x=1730230217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0T5whPPZ1mtfPZDL/Wr67Sgt2fIYamz1vqMoEXoMco4=;
        b=E1F/WHmsY4Kb2LOAeL2Kwc+4ZqLq+3S+odmGCNP+wASts/636JiqA0IGfjkguVUitg
         oavemrly2wrVzo4gd6i84HEwKgAuIJeJqOiDGEKfZtAUqjBKZOBNc7ia2GvGrvXv3h9O
         zzP/KoC9BSvwDXg5r6tNAaPy40MhubrZsQgFFBZvKbNuWjBpvzAD7+PM31nEYku4HBG7
         ycgfrQfDLuqlyH7yn2yw0B71nfor0eBwNDtBHGST03mgFttxqqQChoqDyeArWShk7icW
         JV2oOau+XT10J6pGFkZu0JJmiyYr4FpoXVq7z29ogj27/cHQEGKLLfK81hvHpP0jAOdn
         y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625417; x=1730230217;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0T5whPPZ1mtfPZDL/Wr67Sgt2fIYamz1vqMoEXoMco4=;
        b=txMUxJs41lV6pWvA7zWD8wmJcnX+j/m9uNfjBZGK/FtaiFN13/9cJzasK8LGcT9IxU
         e25YCg3DX6qwtBw6Vmph/qpJxw16KmpxgcrO0OdUjVvWNtANvGauPMUsZn2zR6KJBB8+
         R869D1QfMugHrb1kBNxbwrKp5NiJ9vLk8crSTQNevInX7QPOQwoffa2Sy9P9ghs63l2R
         oCB3LcETgJ5JwWQGUKrYEG4Xa4mI6tGNM6G1Lr+McGsujnJXsVgy6Tastf8SMD6ymK+z
         trWEe1mwLON+RDonBXbeyzUngvdlVbfL7FQCrb0gFMqsGGkpKC6ki3No3tEqE8sBoamc
         es7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT7pAHltRhZGiqNRl64mfoi+pum2oOuO4ekk8+IynNEGWT+chnd/vbuLkD0TFSmkS6Sgv0oij3ZGJgTFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxsFM6Gef504OnChjaThbFpyfICsHL9ICFYrbio0zSQynIIjR
	/57UR4XTSJ4l8ZoA7N1PBDKbuJjb7Kf9qJW4FMQVfGq5twjTexK/
X-Google-Smtp-Source: AGHT+IEkf+8rWb2625GwIb5iPnB6qF5HfrvR5aPCaq44dinbjDAQnyDVMYYmoXwRSMux2JXk+YmbGw==
X-Received: by 2002:a17:902:ea02:b0:20c:7d4c:64db with SMTP id d9443c01a7336-20fab2dba5cmr2570545ad.49.1729625417229;
        Tue, 22 Oct 2024 12:30:17 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:16 -0700 (PDT)
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
Subject: [PATCH 09/13] mm, swap: reduce contention on device lock
Date: Wed, 23 Oct 2024 03:24:47 +0800
Message-ID: <20241022192451.38138-10-ryncsn@gmail.com>
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

Currently swap locking is mainly composed of two locks, cluster
lock (ci->lock) and device lock (si->lock).

Cluster lock is much more fine-grained, so it will be best to use
ci->lock instead of si->lock as much as possible.

Following the new cluster allocator design, many operation doesn't
need to touch si->lock at all. In practise, we only need to take
si->lock when moving clusters between lists.

To archive it, this commit reworked the locking pattern of all si->lock
and ci->lock users, eliminated all usage of ci->lock inside si->lock,
introduce new design to avoid touching si->lock as much as possible.

For minimal contention for allocation and easier understanding, two
ideas are introduced with the corresponding helpers: `isolation`
and `relocation`:

- Clusters will be `isolated` from list upon being scanned for
  allocation, so scanning of on-list cluster no longer need to hold
  the si->lock except the very moment, and hence removed the ci->lock
  usage inside si->lock.

  In the new allocator design, one cluster always get moved after scanning
  (free -> nonfull, nonfull -> frag, frag -> frag tail) so this
  introduces no extra overhead. This also greatly reduced the contention
  of both si->lock and ci->lock as other CPUs won't walk onto the same
  cluster by iterating the list.

  The off-list time window of a cluster is also minimal, one CPU can at
  most hold one cluster while scanning the 512 entries on it, which we
  used to busy wait with a spin lock.

  This is done with `cluster_isolate_lock` on scanning of a new cluster.

  Note: Scanning of per CPU cluster is a special case, it doesn't
  isolation the cluster. That's because it doesn't need to hold the
  si->lock at all, it simply acquire the ci->lock of previously used
  cluster and use it.

- Cluster will be `relocated` after allocation or freeing according to
  it's count and status.

  Allocations no longer holds si->lock now, and may drop ci->lock for
  reclaim, so the cluster could be moved to anywhere. Besides,
  `isolation` clears all flags when it takes the cluster off list
  (The flag must be in-sync with list status, so cluster users don't
  need to touch si->lock for checking its list status. This is important
  for reducing contention on si->lock). So the cluster have to be
  `relocated` according to its usage after being allocation to the
  right list.

  This is done with `relocate_cluster` after allocation, or
  `[partial_]free_cluster` after freeing.

Now except swapon / swapoff and discard, `isolation` and `relocation` are
the only two places that need to take si->lock. And as each CPU will keep
using its per-CPU cluster as much as possible and a cluster have 512
entries to be consumed, si->lock is rarely touched.

The lock contention of si->lock is now barely observable. Test with build
linux kernel with defconfig showed huge performance improvement:

tiem make -j96 / 768M memcg, 4K pages, 10G ZRAM, on Intel 8255C:
Before:
Sys time: 73578.30, Real time: 864.05
After: (-50.7% sys time, -44.8% real time)
Sys time: 36227.49, Real time: 476.66

time make -j96 / 1152M memcg, 64K mTHP, 10G ZRAM, on Intel 8255C:
(avg of 4 test run)
Before:
Sys time: 74044.85, Real time: 846.51
hugepages-64kB/stats/swpout: 1735216
hugepages-64kB/stats/swpout_fallback: 430333

After: (-40.4% sys time, -37.1% real time)
Sys time: 44160.56, Real time: 532.07
hugepages-64kB/stats/swpout: 1786288
hugepages-64kB/stats/swpout_fallback: 243384

time make -j32 / 512M memcg, 4K pages, 5G ZRAM, on AMD 7K62:
Before:
Sys time: 8098.21, Real time: 401.3
After: (-22.6% sys time, -12.8% real time )
Sys time: 6265.02, Real time: 349.83

The allocation success rate also slightly improved as we sanitized the
usage of clusters with new defined helpers and locks, so temporarily
dropped si->lock or ci->lock won't cause cluster order shuffle.

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   5 +-
 mm/swapfile.c        | 418 ++++++++++++++++++++++++-------------------
 2 files changed, 239 insertions(+), 184 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 75fc2da1767d..a3b5d74b095a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -265,6 +265,8 @@ enum swap_cluster_flags {
 	CLUSTER_FLAG_FREE,
 	CLUSTER_FLAG_NONFULL,
 	CLUSTER_FLAG_FRAG,
+	/* Clusters with flags above are allocatable */
+	CLUSTER_FLAG_USABLE = CLUSTER_FLAG_FRAG,
 	CLUSTER_FLAG_FULL,
 	CLUSTER_FLAG_DISCARD,
 	CLUSTER_FLAG_MAX,
@@ -290,6 +292,7 @@ enum swap_cluster_flags {
  * throughput.
  */
 struct percpu_cluster {
+	local_lock_t lock; /* Protect the percpu_cluster above */
 	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
@@ -312,7 +315,7 @@ struct swap_info_struct {
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
-	unsigned int frag_cluster_nr[SWAP_NR_ORDERS];
+	atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 96d8012b003c..a19ee8d5ffd0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -260,12 +260,10 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	folio_ref_sub(folio, nr_pages);
 	folio_set_dirty(folio);
 
-	spin_lock(&si->lock);
 	/* Only sinple page folio can be backed by zswap */
 	if (nr_pages == 1)
 		zswap_invalidate(entry);
 	swap_entry_range_free(si, entry, nr_pages);
-	spin_unlock(&si->lock);
 	ret = nr_pages;
 out_unlock:
 	folio_unlock(folio);
@@ -402,7 +400,21 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 
 static inline bool cluster_is_free(struct swap_cluster_info *info)
 {
-	return info->flags == CLUSTER_FLAG_FREE;
+	return info->count == 0;
+}
+
+static inline bool cluster_is_discard(struct swap_cluster_info *info)
+{
+	return info->flags == CLUSTER_FLAG_DISCARD;
+}
+
+static inline bool cluster_is_usable(struct swap_cluster_info *ci, int order)
+{
+	if (unlikely(ci->flags > CLUSTER_FLAG_USABLE))
+		return false;
+	if (!order)
+		return true;
+	return cluster_is_free(ci) || order == ci->order;
 }
 
 static inline unsigned int cluster_index(struct swap_info_struct *si,
@@ -439,19 +451,20 @@ static void cluster_move(struct swap_info_struct *si,
 {
 	VM_WARN_ON(ci->flags == new_flags);
 	BUILD_BUG_ON(1 << sizeof(ci->flags) * BITS_PER_BYTE < CLUSTER_FLAG_MAX);
+	lockdep_assert_held(&ci->lock);
 
-	if (ci->flags == CLUSTER_FLAG_NONE) {
+	spin_lock(&si->lock);
+	if (ci->flags == CLUSTER_FLAG_NONE)
 		list_add_tail(&ci->list, list);
-	} else {
-		if (ci->flags == CLUSTER_FLAG_FRAG) {
-			VM_WARN_ON(!si->frag_cluster_nr[ci->order]);
-			si->frag_cluster_nr[ci->order]--;
-		}
+	else
 		list_move_tail(&ci->list, list);
-	}
+	spin_unlock(&si->lock);
+
+	if (ci->flags == CLUSTER_FLAG_FRAG)
+		atomic_long_dec(&si->frag_cluster_nr[ci->order]);
+	else if (new_flags == CLUSTER_FLAG_FRAG)
+		atomic_long_inc(&si->frag_cluster_nr[ci->order]);
 	ci->flags = new_flags;
-	if (new_flags == CLUSTER_FLAG_FRAG)
-		si->frag_cluster_nr[ci->order]++;
 }
 
 /* Add a cluster to discard list and schedule it to do discard */
@@ -474,39 +487,82 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
-	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
 	cluster_move(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 	ci->order = 0;
 }
 
+/*
+ * Isolate and lock the first cluster that is not contented on a list,
+ * clean its flag before taken off-list. Cluster flag must be in sync
+ * with list status, so cluster updaters can always know the cluster
+ * list status without touching si lock.
+ *
+ * Note it's possible that all clusters on a list are contented so
+ * this returns NULL for an non-empty list.
+ */
+static struct swap_cluster_info *cluster_isolate_lock(
+		struct swap_info_struct *si, struct list_head *list)
+{
+	struct swap_cluster_info *ci, *ret = NULL;
+
+	spin_lock(&si->lock);
+	list_for_each_entry(ci, list, list) {
+		if (!spin_trylock(&ci->lock))
+			continue;
+
+		/* We may only isolate and clear flags of following lists */
+		VM_BUG_ON(!ci->flags);
+		VM_BUG_ON(ci->flags > CLUSTER_FLAG_USABLE &&
+			  ci->flags != CLUSTER_FLAG_FULL);
+
+		list_del(&ci->list);
+		ci->flags = CLUSTER_FLAG_NONE;
+		ret = ci;
+		break;
+	}
+	spin_unlock(&si->lock);
+
+	return ret;
+}
+
 /*
  * Doing discard actually. After a cluster discard is finished, the cluster
- * will be added to free cluster list. caller should hold si->lock.
-*/
-static void swap_do_scheduled_discard(struct swap_info_struct *si)
+ * will be added to free cluster list. Discard cluster is a bit special as
+ * they don't participate in allocation or reclaim, so clusters marked as
+ * CLUSTER_FLAG_DISCARD must remain off-list or on discard list.
+ */
+static bool swap_do_scheduled_discard(struct swap_info_struct *si)
 {
 	struct swap_cluster_info *ci;
+	bool ret = false;
 	unsigned int idx;
 
+	spin_lock(&si->lock);
 	while (!list_empty(&si->discard_clusters)) {
 		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
+		/*
+		 * Delete the cluster from list but don't clear the flag until
+		 * discard is done, so isolation and relocation will skip it.
+		 */
 		list_del(&ci->list);
-		/* Must clear flag when taking a cluster off-list */
-		ci->flags = CLUSTER_FLAG_NONE;
 		idx = cluster_index(si, ci);
 		spin_unlock(&si->lock);
-
 		discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
 				SWAPFILE_CLUSTER);
 
-		spin_lock(&si->lock);
 		spin_lock(&ci->lock);
-		__free_cluster(si, ci);
+		/* Discard is done, return to list and clear the flag */
+		ci->flags = CLUSTER_FLAG_NONE;
 		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 				0, SWAPFILE_CLUSTER);
+		__free_cluster(si, ci);
 		spin_unlock(&ci->lock);
+		ret = true;
+		spin_lock(&si->lock);
 	}
+	spin_unlock(&si->lock);
+	return ret;
 }
 
 static void swap_discard_work(struct work_struct *work)
@@ -515,9 +571,7 @@ static void swap_discard_work(struct work_struct *work)
 
 	si = container_of(work, struct swap_info_struct, discard_work);
 
-	spin_lock(&si->lock);
 	swap_do_scheduled_discard(si);
-	spin_unlock(&si->lock);
 }
 
 static void swap_users_ref_free(struct percpu_ref *ref)
@@ -528,10 +582,14 @@ static void swap_users_ref_free(struct percpu_ref *ref)
 	complete(&si->comp);
 }
 
+/*
+ * Must be called after freeing if ci->count == 0, puts the cluster to free
+ * or discard list.
+ */
 static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
 	VM_BUG_ON(ci->count != 0);
-	lockdep_assert_held(&si->lock);
+	VM_BUG_ON(ci->flags == CLUSTER_FLAG_FREE);
 	lockdep_assert_held(&ci->lock);
 
 	/*
@@ -548,6 +606,48 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 	__free_cluster(si, ci);
 }
 
+/*
+ * Must be called after freeing if ci->count != 0, puts the cluster to free
+ * or nonfull list.
+ */
+static void partial_free_cluster(struct swap_info_struct *si,
+				 struct swap_cluster_info *ci)
+{
+	VM_BUG_ON(!ci->count || ci->count == SWAPFILE_CLUSTER);
+	lockdep_assert_held(&ci->lock);
+
+	if (ci->flags != CLUSTER_FLAG_NONFULL)
+		cluster_move(si, ci, &si->nonfull_clusters[ci->order],
+			     CLUSTER_FLAG_NONFULL);
+}
+
+/*
+ * Must be called after allocation, put the cluster to full or frag list.
+ * Note: allocation don't need si lock, and may drop the ci lock for reclaim,
+ * so the cluster could end up any where before re-acquiring ci lock.
+ */
+static void relocate_cluster(struct swap_info_struct *si,
+			     struct swap_cluster_info *ci)
+{
+	lockdep_assert_held(&ci->lock);
+
+	/* Discard cluster must remain off-list or on discard list */
+	if (cluster_is_discard(ci))
+		return;
+
+	if (!ci->count) {
+		free_cluster(si, ci);
+	} else if (ci->count != SWAPFILE_CLUSTER) {
+		if (ci->flags != CLUSTER_FLAG_FRAG)
+			cluster_move(si, ci, &si->frag_clusters[ci->order],
+				     CLUSTER_FLAG_FRAG);
+	} else {
+		if (ci->flags != CLUSTER_FLAG_FULL)
+			cluster_move(si, ci, &si->full_clusters,
+				     CLUSTER_FLAG_FULL);
+	}
+}
+
 /*
  * The cluster corresponding to page_nr will be used. The cluster will not be
  * added to free cluster list and its usage counter will be increased by 1.
@@ -566,30 +666,6 @@ static void inc_cluster_info_page(struct swap_info_struct *si,
 	VM_BUG_ON(ci->flags);
 }
 
-/*
- * The cluster ci decreases @nr_pages usage. If the usage counter becomes 0,
- * which means no page in the cluster is in use, we can optionally discard
- * the cluster and add it to free cluster list.
- */
-static void dec_cluster_info_page(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci, int nr_pages)
-{
-	VM_BUG_ON(ci->count < nr_pages);
-	VM_BUG_ON(cluster_is_free(ci));
-	lockdep_assert_held(&si->lock);
-	lockdep_assert_held(&ci->lock);
-	ci->count -= nr_pages;
-
-	if (!ci->count) {
-		free_cluster(si, ci);
-		return;
-	}
-
-	if (ci->flags != CLUSTER_FLAG_NONFULL)
-		cluster_move(si, ci, &si->nonfull_clusters[ci->order],
-			     CLUSTER_FLAG_NONFULL);
-}
-
 static bool cluster_reclaim_range(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
 				  unsigned long start, unsigned long end)
@@ -599,8 +675,6 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 	int nr_reclaim;
 
 	spin_unlock(&ci->lock);
-	spin_unlock(&si->lock);
-
 	do {
 		switch (READ_ONCE(map[offset])) {
 		case 0:
@@ -618,9 +692,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 		}
 	} while (offset < end);
 out:
-	spin_lock(&si->lock);
 	spin_lock(&ci->lock);
-
 	/*
 	 * Recheck the range no matter reclaim succeeded or not, the slot
 	 * could have been be freed while we are not holding the lock.
@@ -634,11 +706,11 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 
 static bool cluster_scan_range(struct swap_info_struct *si,
 			       struct swap_cluster_info *ci,
-			       unsigned long start, unsigned int nr_pages)
+			       unsigned long start, unsigned int nr_pages,
+			       bool *need_reclaim)
 {
 	unsigned long offset, end = start + nr_pages;
 	unsigned char *map = si->swap_map;
-	bool need_reclaim = false;
 
 	for (offset = start; offset < end; offset++) {
 		switch (READ_ONCE(map[offset])) {
@@ -647,16 +719,13 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 		case SWAP_HAS_CACHE:
 			if (!vm_swap_full())
 				return false;
-			need_reclaim = true;
+			*need_reclaim = true;
 			continue;
 		default:
 			return false;
 		}
 	}
 
-	if (need_reclaim)
-		return cluster_reclaim_range(si, ci, start, end);
-
 	return true;
 }
 
@@ -666,23 +735,12 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 {
 	unsigned int nr_pages = 1 << order;
 
-	VM_BUG_ON(ci->flags != CLUSTER_FLAG_FREE &&
-		  ci->flags != CLUSTER_FLAG_NONFULL &&
-		  ci->flags != CLUSTER_FLAG_FRAG);
-
-	if (cluster_is_free(ci)) {
-		if (nr_pages < SWAPFILE_CLUSTER)
-			cluster_move(si, ci, &si->nonfull_clusters[order],
-				     CLUSTER_FLAG_NONFULL);
+	if (cluster_is_free(ci))
 		ci->order = order;
-	}
 
 	memset(si->swap_map + start, usage, nr_pages);
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
-
-	if (ci->count == SWAPFILE_CLUSTER)
-		cluster_move(si, ci, &si->full_clusters, CLUSTER_FLAG_FULL);
 }
 
 static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset,
@@ -692,34 +750,52 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 	unsigned long start = offset & ~(SWAPFILE_CLUSTER - 1);
 	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
 	unsigned int nr_pages = 1 << order;
+	bool need_reclaim, ret;
 	struct swap_cluster_info *ci;
 
-	if (end < nr_pages)
-		return SWAP_NEXT_INVALID;
-	end -= nr_pages;
+	ci = &si->cluster_info[offset / SWAPFILE_CLUSTER];
+	lockdep_assert_held(&ci->lock);
 
-	ci = lock_cluster(si, offset);
-	if (ci->count + nr_pages > SWAPFILE_CLUSTER) {
+	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER) {
 		offset = SWAP_NEXT_INVALID;
-		goto done;
+		goto out;
 	}
 
-	while (offset <= end) {
-		if (cluster_scan_range(si, ci, offset, nr_pages)) {
-			cluster_alloc_range(si, ci, offset, usage, order);
-			*foundp = offset;
-			if (ci->count == SWAPFILE_CLUSTER) {
+	for (end -= nr_pages; offset <= end; offset += nr_pages) {
+		need_reclaim = false;
+		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
+			continue;
+		if (need_reclaim) {
+			ret = cluster_reclaim_range(si, ci, start, end);
+			/*
+			 * Reclaim drops ci->lock and cluster could be used
+			 * by another order. Not checking flag as off-list
+			 * cluster has no flag set, and change of list
+			 * won't cause fragmentation.
+			 */
+			if (!cluster_is_usable(ci, order)) {
 				offset = SWAP_NEXT_INVALID;
-				goto done;
+				goto out;
 			}
-			offset += nr_pages;
-			break;
+			if (cluster_is_free(ci))
+				offset = start;
+			/* Reclaim failed but cluster is usable, try next */
+			if (!ret)
+				continue;
+		}
+		cluster_alloc_range(si, ci, offset, usage, order);
+		*foundp = offset;
+		if (ci->count == SWAPFILE_CLUSTER) {
+			offset = SWAP_NEXT_INVALID;
+			goto out;
 		}
 		offset += nr_pages;
+		break;
 	}
 	if (offset > end)
 		offset = SWAP_NEXT_INVALID;
-done:
+out:
+	relocate_cluster(si, ci);
 	unlock_cluster(ci);
 	return offset;
 }
@@ -736,18 +812,17 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	if (force)
 		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
-	while (!list_empty(&si->full_clusters)) {
-		ci = list_first_entry(&si->full_clusters, struct swap_cluster_info, list);
-		list_move_tail(&ci->list, &si->full_clusters);
+	while ((ci = cluster_isolate_lock(si, &si->full_clusters))) {
 		offset = cluster_offset(si, ci);
 		end = min(si->max, offset + SWAPFILE_CLUSTER);
 		to_scan--;
 
-		spin_unlock(&si->lock);
 		while (offset < end) {
 			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
+				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY | TTRS_DIRECT);
+				spin_lock(&ci->lock);
 				if (nr_reclaim) {
 					offset += abs(nr_reclaim);
 					continue;
@@ -755,8 +830,8 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			}
 			offset++;
 		}
-		spin_lock(&si->lock);
 
+		unlock_cluster(ci);
 		if (to_scan <= 0)
 			break;
 	}
@@ -768,9 +843,7 @@ static void swap_reclaim_work(struct work_struct *work)
 
 	si = container_of(work, struct swap_info_struct, reclaim_work);
 
-	spin_lock(&si->lock);
 	swap_reclaim_full_clusters(si, true);
-	spin_unlock(&si->lock);
 }
 
 /*
@@ -781,23 +854,36 @@ static void swap_reclaim_work(struct work_struct *work)
 static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
 					      unsigned char usage)
 {
-	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
 	unsigned int offset, found = 0;
 
-new_cluster:
-	lockdep_assert_held(&si->lock);
-	cluster = this_cpu_ptr(si->percpu_cluster);
-	offset = cluster->next[order];
+	/* Fast path using per CPU cluster */
+	local_lock(&si->percpu_cluster->lock);
+	offset = __this_cpu_read(si->percpu_cluster->next[order]);
 	if (offset) {
-		offset = alloc_swap_scan_cluster(si, offset, &found, order, usage);
+		ci = lock_cluster(si, offset);
+		/* Cluster could have been used by another order */
+		if (cluster_is_usable(ci, order)) {
+			if (cluster_is_free(ci))
+				offset = cluster_offset(si, ci);
+			offset = alloc_swap_scan_cluster(si, offset, &found,
+							 order, usage);
+		} else {
+			unlock_cluster(ci);
+		}
 		if (found)
 			goto done;
 	}
 
-	if (!list_empty(&si->free_clusters)) {
-		ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
-		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
+new_cluster:
+	ci = cluster_isolate_lock(si, &si->free_clusters);
+	if (ci) {
+		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+						 &found, order, usage);
+		/*
+		 * Allocation from free cluster must never fail and
+		 * cluster lock must remain untouched.
+		 */
 		VM_BUG_ON(!found);
 		goto done;
 	}
@@ -807,49 +893,45 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		swap_reclaim_full_clusters(si, false);
 
 	if (order < PMD_ORDER) {
-		unsigned int frags = 0;
+		unsigned int frags = 0, frags_existing;
 
-		while (!list_empty(&si->nonfull_clusters[order])) {
-			ci = list_first_entry(&si->nonfull_clusters[order],
-					      struct swap_cluster_info, list);
-			cluster_move(si, ci, &si->frag_clusters[order], CLUSTER_FLAG_FRAG);
+		while ((ci = cluster_isolate_lock(si, &si->nonfull_clusters[order]))) {
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, order, usage);
-			frags++;
+			/*
+			 * With `fragmenting` set to true, it will surely take
+			 * the cluster off nonfull list
+			 */
 			if (found)
 				goto done;
+			frags++;
 		}
 
-		/*
-		 * Nonfull clusters are moved to frag tail if we reached
-		 * here, count them too, don't over scan the frag list.
-		 */
-		while (frags < si->frag_cluster_nr[order]) {
-			ci = list_first_entry(&si->frag_clusters[order],
-					      struct swap_cluster_info, list);
+		frags_existing = atomic_long_read(&si->frag_cluster_nr[order]);
+		while (frags < frags_existing &&
+		       (ci = cluster_isolate_lock(si, &si->frag_clusters[order]))) {
+			atomic_long_dec(&si->frag_cluster_nr[order]);
 			/*
-			 * Rotate the frag list to iterate, they were all failing
-			 * high order allocation or moved here due to per-CPU usage,
-			 * this help keeping usable cluster ahead.
+			 * Rotate the frag list to iterate, they were all
+			 * failing high order allocation or moved here due to
+			 * per-CPU usage, but either way they could contain
+			 * usable (eg. lazy-freed swap cache) slots.
 			 */
-			list_move_tail(&ci->list, &si->frag_clusters[order]);
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, order, usage);
-			frags++;
 			if (found)
 				goto done;
+			frags++;
 		}
 	}
 
-	if (!list_empty(&si->discard_clusters)) {
-		/*
-		 * we don't have free cluster but have some clusters in
-		 * discarding, do discard now and reclaim them, then
-		 * reread cluster_next_cpu since we dropped si->lock
-		 */
-		swap_do_scheduled_discard(si);
+	/*
+	 * We don't have free cluster but have some clusters in
+	 * discarding, do discard now and reclaim them, then
+	 * reread cluster_next_cpu since we dropped si->lock
+	 */
+	if ((si->flags & SWP_PAGE_DISCARD) && swap_do_scheduled_discard(si))
 		goto new_cluster;
-	}
 
 	if (order)
 		goto done;
@@ -860,26 +942,25 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		 * Clusters here have at least one usable slots and can't fail order 0
 		 * allocation, but reclaim may drop si->lock and race with another user.
 		 */
-		while (!list_empty(&si->frag_clusters[o])) {
-			ci = list_first_entry(&si->frag_clusters[o],
-					      struct swap_cluster_info, list);
+		while ((ci = cluster_isolate_lock(si, &si->frag_clusters[o]))) {
+			atomic_long_dec(&si->frag_cluster_nr[o]);
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, 0, usage);
+							 &found, order, usage);
 			if (found)
 				goto done;
 		}
 
-		while (!list_empty(&si->nonfull_clusters[o])) {
-			ci = list_first_entry(&si->nonfull_clusters[o],
-					      struct swap_cluster_info, list);
+		while ((ci = cluster_isolate_lock(si, &si->nonfull_clusters[o]))) {
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
-							 &found, 0, usage);
+							 &found, order, usage);
 			if (found)
 				goto done;
 		}
 	}
 done:
-	cluster->next[order] = offset;
+	__this_cpu_write(si->percpu_cluster->next[order], offset);
+	local_unlock(&si->percpu_cluster->lock);
+
 	return found;
 }
 
@@ -1135,14 +1216,11 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			spin_lock(&si->lock);
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
 					n_goal, swp_entries, order);
-			spin_unlock(&si->lock);
 			put_swap_device(si);
 			if (n_ret || size > 1)
 				goto check_out;
-			cond_resched();
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1355,9 +1433,7 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 	if (!has_cache) {
 		for (i = 0; i < nr; i++)
 			zswap_invalidate(swp_entry(si->type, offset + i));
-		spin_lock(&si->lock);
 		swap_entry_range_free(si, entry, nr);
-		spin_unlock(&si->lock);
 	}
 	return has_cache;
 
@@ -1386,16 +1462,27 @@ static void swap_entry_range_free(struct swap_info_struct *si, swp_entry_t entry
 	unsigned char *map_end = map + nr_pages;
 	struct swap_cluster_info *ci;
 
+	/* It should never free entries across different clusters */
+	VM_BUG_ON((offset / SWAPFILE_CLUSTER) != ((offset + nr_pages - 1) / SWAPFILE_CLUSTER));
+
 	ci = lock_cluster(si, offset);
+	VM_BUG_ON(cluster_is_free(ci));
+	VM_BUG_ON(ci->count < nr_pages);
+
+	ci->count -= nr_pages;
 	do {
 		VM_BUG_ON(*map != SWAP_HAS_CACHE);
 		*map = 0;
 	} while (++map < map_end);
-	dec_cluster_info_page(si, ci, nr_pages);
-	unlock_cluster(ci);
 
 	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
+
+	if (!ci->count)
+		free_cluster(si, ci);
+	else
+		partial_free_cluster(si, ci);
+	unlock_cluster(ci);
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *si,
@@ -1467,9 +1554,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	ci = lock_cluster(si, offset);
 	if (size > 1 && swap_is_has_cache(si, offset, size)) {
 		unlock_cluster(ci);
-		spin_lock(&si->lock);
 		swap_entry_range_free(si, entry, size);
-		spin_unlock(&si->lock);
 		return;
 	}
 	for (int i = 0; i < size; i++, entry.val++) {
@@ -1484,46 +1569,19 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unlock_cluster(ci);
 }
 
-static int swp_entry_cmp(const void *ent1, const void *ent2)
-{
-	const swp_entry_t *e1 = ent1, *e2 = ent2;
-
-	return (int)swp_type(*e1) - (int)swp_type(*e2);
-}
-
 void swapcache_free_entries(swp_entry_t *entries, int n)
 {
-	struct swap_info_struct *si, *prev;
 	int i;
+	struct swap_info_struct *si = NULL;
 
 	if (n <= 0)
 		return;
 
-	prev = NULL;
-	si = NULL;
-
-	/*
-	 * Sort swap entries by swap device, so each lock is only taken once.
-	 * nr_swapfiles isn't absolutely correct, but the overhead of sort() is
-	 * so low that it isn't necessary to optimize further.
-	 */
-	if (nr_swapfiles > 1)
-		sort(entries, n, sizeof(entries[0]), swp_entry_cmp, NULL);
 	for (i = 0; i < n; ++i) {
 		si = _swap_info_get(entries[i]);
-
-		if (si != prev) {
-			if (prev != NULL)
-				spin_unlock(&prev->lock);
-			if (si != NULL)
-				spin_lock(&si->lock);
-		}
 		if (si)
 			swap_entry_range_free(si, entries[i], 1);
-		prev = si;
 	}
-	if (si)
-		spin_unlock(&si->lock);
 }
 
 int __swap_count(swp_entry_t entry)
@@ -1775,13 +1833,8 @@ swp_entry_t get_swap_page_of_type(int type)
 		goto fail;
 
 	/* This is called for allocating swap entry, not cache */
-	if (get_swap_device_info(si)) {
-		spin_lock(&si->lock);
-		if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
-			atomic_long_dec(&nr_swap_pages);
-		spin_unlock(&si->lock);
-		put_swap_device(si);
-	}
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
+		atomic_long_dec(&nr_swap_pages);
 fail:
 	return entry;
 }
@@ -3098,6 +3151,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 		cluster = per_cpu_ptr(si->percpu_cluster, cpu);
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
 			cluster->next[i] = SWAP_NEXT_INVALID;
+		local_lock_init(&cluster->lock);
 	}
 
 	/*
@@ -3121,7 +3175,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {
 		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
 		INIT_LIST_HEAD(&si->frag_clusters[i]);
-		si->frag_cluster_nr[i] = 0;
+		atomic_long_set(&si->frag_cluster_nr[i], 0);
 	}
 
 	/*
@@ -3603,7 +3657,6 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 		 */
 		goto outer;
 	}
-	spin_lock(&si->lock);
 
 	offset = swp_offset(entry);
 
@@ -3668,7 +3721,6 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	spin_unlock(&si->cont_lock);
 out:
 	unlock_cluster(ci);
-	spin_unlock(&si->lock);
 	put_swap_device(si);
 outer:
 	if (page)
-- 
2.47.0



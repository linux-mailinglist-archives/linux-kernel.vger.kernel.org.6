Return-Path: <linux-kernel+bounces-376863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AD9AB6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC242843F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850BD1CC144;
	Tue, 22 Oct 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnI53bZa"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742D1CDA24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625430; cv=none; b=S0yLmEP1Sf3UUa+hsG3ZNPstiJjAYdegqKj0DBFDyduZDxJ8qIie+1bi0pFifKx/VEvnJVIthSnmgw/NunZ25BIMtaZh3pdiYd21KYvhxgaFeecfxRF8imX1pG1FQDS/yZgeCXj64jduG0Wtp4UWA2exQKVm8erX1INop0xNMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625430; c=relaxed/simple;
	bh=Pdjx8c/CvfxwkuH9EzMUjmFgl9lyHu/7HtHzPqX/CVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAop05no0G5q2NEcrmtSkH4CUZvwR+ltc8BbIzj8TEu9wA9CYUdUHO7MKAjlqJf4zbbBGVRVgE1NPhnhrgYmF08W3mNrFmWefq20Yef7/sPA6xY6KXMQY9WE/2APznk7K3JWgtdo7ToHHD7YybiRfatwjaTZB44SQxF9Wq8dTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnI53bZa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c77459558so51433965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625428; x=1730230228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2jmxIUhNZxFOtFl07G9SGXSpDqPv8x+3F53EFaJwLQ=;
        b=fnI53bZaicvPHBpzsArDzawy2rkZQxC4nSib3KR3OCYKnTk2gRUMyQPVYhYTDU82KB
         7J8u3I/T+/jOpT4RbKRVwZCM9tENouCHPpY1Mlw43uEjSYlgERkfgnyqSV2M/iIt8Wt5
         T/uY/mVybK/UqgVd9xUvskALARTySEabuZwadb2vpAd8QomFS0Fpa/G9qyn0Em3JrnpC
         jWseahMPgmSCjVOUpVbSlA+2Q6yzcnc931m1W+s5jVo4AHV/zYYmTralCOfoH93mfecl
         4aprBXY+NHdcAnwtWlef2F/nltrxPceuE8DK7XcLsNesGX+iY0yUl43Zwf2zDQBug6HG
         DSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625428; x=1730230228;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2jmxIUhNZxFOtFl07G9SGXSpDqPv8x+3F53EFaJwLQ=;
        b=clqKAKh+WKc/IzhokJdxbSJw2HBbGyh9dkrp0QkPi5AfDyQPm6ze2WUX0mJTTFlLjE
         PlK84MLxhpuK0JprUmAo4Bb3NXvkvkyEdytA1mJXDy1Ssf/eWv1zZHuOAoBsEH7WoLoC
         +il84S1FchhtdZhwcFowboYxMmss9OBmzNhH59u7JKhM5E486D1CmTbs0GCFdsl10+vp
         l9NAWAdrwKTdAoYRsuWN9VAZauA1z4mWsE3vItxL4qlOxwcNMyrLzZHpYB5VRVtYpoyb
         8iyApplWPHeXfRXzKFMaW8K/aiM1m0gfBzL8a9x6L1/f8uPnZkWl8xL/d8+nWETrY62A
         DavQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQKdMSw835YtE/73rKiL3s2bS/R/+GQv/K8DfycFHbJCn0IJT7TtkCzwjpH3GWOU/Xfwu9AYO8JnOAd/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8m+7qvMxxsMl/JMd/Vs9EqVM2xWuHvzTGWRihdhmv6gkMDsE
	J7aDgdbceBNaL2M5HyFDP777Knz8PEmFPWhtavBxck7slkQKi1sh
X-Google-Smtp-Source: AGHT+IFV1ogV52DzmXBw68h0S9N3oYY1APJh2lIGdJCHh5CcSXToC3t30idapf9oyW75V51NGLt65w==
X-Received: by 2002:a17:902:e752:b0:20f:ab2e:14f9 with SMTP id d9443c01a7336-20fab2e150bmr2982245ad.55.1729625428254;
        Tue, 22 Oct 2024 12:30:28 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0d9f05sm45895305ad.186.2024.10.22.12.30.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 12:30:27 -0700 (PDT)
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
Subject: [PATCH 12/13] mm, swap: use a global swap cluster for non-rotation device
Date: Wed, 23 Oct 2024 03:24:50 +0800
Message-ID: <20241022192451.38138-13-ryncsn@gmail.com>
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

Non-rotation (SSD / ZRAM) device can tolerate fragmentations so the goal
of SWAP allocator is to avoid contention of clusters. So it used a
per-CPU cluster design, and each CPU will be using a different cluster
as much as possible.

But HDD is very sensitive to fragmentations, contention is trivial compared
to this. So just use one global cluster instead. This ensured each order
will be wring to a same cluster as much as possible, which helps to make
the IO more continuous.

This ensures the performance of cluster allocator is as good as the old
allocator. Test after this commit compared to before this series:

make -j32 with tinyconfig, using 1G memcg limit and HDD swap:

Before this series:
114.44user 29.11system 39:42.90elapsed 6%CPU (0avgtext+0avgdata 157284maxresident)k
2901232inputs+0outputs (238877major+4227640minor)pagefaults

After this commit:
113.90user 23.81system 38:11.77elapsed 6%CPU (0avgtext+0avgdata 157260maxresident)k
2548728inputs+0outputs (235471major+4238110minor)pagefaults

Suggested-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  2 ++
 mm/swapfile.c        | 48 ++++++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0e6c6bb385f0..9898b1881d4d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -319,6 +319,8 @@ struct swap_info_struct {
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
+	struct percpu_cluster *global_cluster; /* Use one global cluster for rotating device */
+	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f25d697f6736..6eb298a222c0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -798,7 +798,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
-	__this_cpu_write(si->percpu_cluster->next[order], next);
+	if (si->flags & SWP_SOLIDSTATE)
+		__this_cpu_write(si->percpu_cluster->next[order], next);
+	else
+		si->global_cluster->next[order] = next;
 	return found;
 }
 
@@ -860,8 +863,14 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	unsigned int offset, found = 0;
 
 	/* Fast path using per CPU cluster */
-	local_lock(&si->percpu_cluster->lock);
-	offset = __this_cpu_read(si->percpu_cluster->next[order]);
+	if (si->flags & SWP_SOLIDSTATE) {
+		local_lock(&si->percpu_cluster->lock);
+		offset = __this_cpu_read(si->percpu_cluster->next[order]);
+	} else {
+		spin_lock(&si->global_cluster_lock);
+		offset = si->global_cluster->next[order];
+	}
+
 	if (offset) {
 		ci = lock_cluster(si, offset);
 		/* Cluster could have been used by another order */
@@ -960,8 +969,10 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		}
 	}
 done:
-	local_unlock(&si->percpu_cluster->lock);
-
+	if (si->flags & SWP_SOLIDSTATE)
+		local_unlock(&si->percpu_cluster->lock);
+	else
+		spin_unlock(&si->global_cluster_lock);
 	return found;
 }
 
@@ -2737,6 +2748,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	free_percpu(p->percpu_cluster);
 	p->percpu_cluster = NULL;
+	kfree(p->global_cluster);
+	p->global_cluster = NULL;
 	vfree(swap_map);
 	kvfree(zeromap);
 	kvfree(cluster_info);
@@ -3142,17 +3155,24 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	si->percpu_cluster = alloc_percpu(struct percpu_cluster);
-	if (!si->percpu_cluster)
-		goto err_free;
+	if (si->flags & SWP_SOLIDSTATE) {
+		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+		if (!si->percpu_cluster)
+			goto err_free;
 
-	for_each_possible_cpu(cpu) {
-		struct percpu_cluster *cluster;
+		for_each_possible_cpu(cpu) {
+			struct percpu_cluster *cluster;
 
-		cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+			for (i = 0; i < SWAP_NR_ORDERS; i++)
+				cluster->next[i] = SWAP_ENTRY_INVALID;
+			local_lock_init(&cluster->lock);
+		}
+	} else {
+		si->global_cluster = kmalloc(sizeof(*si->global_cluster), GFP_KERNEL);
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			cluster->next[i] = SWAP_ENTRY_INVALID;
-		local_lock_init(&cluster->lock);
+			si->global_cluster->next[i] = SWAP_ENTRY_INVALID;
+		spin_lock_init(&si->global_cluster_lock);
 	}
 
 	/*
@@ -3426,6 +3446,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap:
 	free_percpu(si->percpu_cluster);
 	si->percpu_cluster = NULL;
+	kfree(si->global_cluster);
+	si->global_cluster = NULL;
 	inode = NULL;
 	destroy_swap_extents(si);
 	swap_cgroup_swapoff(si->type);
-- 
2.47.0



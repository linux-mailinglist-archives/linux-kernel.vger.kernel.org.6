Return-Path: <linux-kernel+bounces-339501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74258986602
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE07B225C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841578289A;
	Wed, 25 Sep 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2KfuTsl"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413564A00
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286840; cv=none; b=NGEGZ24fHj/PF9ghAL1G5ms9c+SBA/KcrU/EQX2cdU5wepb8UQs9w+M2bljd/kIMxPsC901AT2cfJEEPpKWMX7rnkinQtV6yaD1l//i0RM1yMmQLRkjqalsZcF44SxN++zAfcqciIczc8cff+Lq2SVqnl0ysfsceAfpq7iTxVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286840; c=relaxed/simple;
	bh=3djwUoJH8oFZgPImAMKv9nQHjfkWpPGNPxY5QUY8KtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgFJMIGzXfknQBvy0gydAPAnQVSbWcxmsKBjBuZsfqjdu4oAQO76EHAit5u4t4o4qHEF8fKktir3sjk05rZzvyGs6nBNtMyk7OJZjxt7jsNNFlZu9pBmcl++Muz1QhFAq2i3ahDLDCe0vD1d0FGorxI2EnBST1BH6f4v5YBCG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2KfuTsl; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so159116a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727286838; x=1727891638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EoHJ7ocju/j5y3k4cYBKQ/0gfv38s9h2AqOIXx1TaY=;
        b=c2KfuTslM0xbomwC3/IRlBCqMxuuhJkxuyk9SXrmzsamc82ZfBY8QttOqWXxrlvzXK
         rGU7FsQWXTIh9v0/aQlv9RoqP1O7gAyMgLG+E/wYjab3Zt1WXm5ejo4pUr4R+s2tenhY
         3KfDC8c2EGMNMs9wADL6WRjFnNRScpmygZCzaF5E25bJbXbWYAG9F94QKjyL5sTrzGEv
         iklNZ1EKK1+CeAxJsKbPAoUqPaKZsi5Mr4KUisO9oioWJ2nEnckeFdQHNM73Cai0hsw+
         Y/WJVr7LieWUvW5P8vkb+2u3ppghbUy/Vo82fKptZy/E2Z2EWKc2abYd2CXdfUofVO4s
         3ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286838; x=1727891638;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EoHJ7ocju/j5y3k4cYBKQ/0gfv38s9h2AqOIXx1TaY=;
        b=GRYIC0NryKIjkvkWNfqqY7R3WtT7a8kvF6L6O0/oKod8TFe8hXcH3vfJIrHgi/o4Am
         gByXwwbSHUTqJ3FNbtRuDhpStxsL2UUPSwvjXjD/BYS4HOB2jAqzNF4RhLJAKYqOmzLt
         2mNmtOouYRC7wAeHaG2U4SZAP951aXuNwbPK9doNm+JgePd47SGit6gKh7PXhNI41Ebv
         oFcfmH+ECD0kDZRXpFhtOyhw9wYRRP4ENP1HrPYMK9OaAfVNODir8yt2sAHH5PA55N/x
         OgyUXML3BVA+PYxskRJ1/mowIaoQRJ7ssP7fKa/3f820CBX3dD3a2gYNiFw4WOf80l04
         VZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBZCldThVkplS7RTqzMK+DeJDTOVQrIg6vpFLCMmR9n/ZznhG9XPstnYvO/n3UrLPvFN2u5g+1hz17Ibg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzX+1KbykYzW7JkiTYIoU/+tXqTmEUv6Qc3luBY1hKBEu7LdM
	UkeyQLL7jNBBwVXbptEacK+sVU+GbhQchY90VHrJ4l9fNS0pnFJd
X-Google-Smtp-Source: AGHT+IHFI+9934Boc8xYNAsNyqEQN0RpyAFGjPw2HgITs7iRGHHX6FBWRyloZk6a7PXfSC+1aFbQuQ==
X-Received: by 2002:a17:90b:3bcb:b0:2d3:d45b:9e31 with SMTP id 98e67ed59e1d1-2e06ae26b0amr4151563a91.2.1727286838435;
        Wed, 25 Sep 2024 10:53:58 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1feeecsm1806245a91.30.2024.09.25.10.53.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 10:53:57 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm, swap: avoid over reclaim of full clusters
Date: Thu, 26 Sep 2024 01:52:41 +0800
Message-ID: <20240925175241.46679-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.46.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

When running low on usable slots, cluster allocator will try to reclaim
the full clusters aggressively to reclaim HAS_CACHE slots. This guarantees
that as long as there are any usable slots, HAS_CACHE or not, the swap
device will be usable and workload won't go OOM.

Before the cluster allocator, swap allocator fails easily if device is
filled up with reclaimable HAS_CACHE slots. Which can be easily
simulated with following simple program:

    #include <stdio.h>
    #include <string.h>
    #include <linux/mman.h>
    #include <sys/mman.h>
    #define SIZE 8192UL * 1024UL * 1024UL
    int main(int argc, char **argv) {
        long tmp;
        char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        memset(p, 0, SIZE);
        madvise(p, SIZE, MADV_PAGEOUT);
        for (unsigned long i = 0; i < SIZE; ++i)
            tmp += p[i];
        getchar(); /* Pause */
        return 0;
    }

Setup a 8G non ramdisk swap, the first run of the program can swapout
8G ram successfully. But run same program again without existing
previous one, it can't swapout all 8G memory as nearly half of the swap
device is occupied by HAS_CACHE. There was a random scan in the old
allocator may reclaim part of the HAS_CACHE by luck, but it's unreliable.

The new allocator's added reclaim of full clusters, but it has a hidden
pitfall. When multiple CPUs are seeing the device is low on usable slots,
they ran into a thundering herd problem, causing performance drop and
delayed OOM kill.

This is observable on large machine with mass parallel workload. Test
using 128G ZRAM on a 96 CPU system, first fill the swap with 124G
place holder data, then run build linux kernel with make -j96 in a 1G
memory Cgroup. The left 4G swap space is far not enough for the workload,
but the OOM won't kick in until the workload hung for about ~5min.

Full cluster reclaim is slower for large device, and every CPU will drop
the si->lock for reclaim, allowed other CPUs to re-entry the reclaim path.
As a result, all CPUs are busy doing the full reclaim. Besides, the current
full reclaim trigger condition is too lenient (available slots < cluster
size, which was suppose to ensure mTHP user won't fail due to HAS_CACHE),
making things more risky.

So, to ensure only one aggressively full cluster reclaim is issued when
device is near full, offload the aggressively reclaim to a kworker instead.
This still ensures in worst case the device won't be unusable because of
HAS_CACHE slots.

And to avoid allocation (especially higher order) suffer from HAS_CACHE
filling up clusters and kworker not responsive enough, do one synchronous
scan every time the free list is drained, and only scan one cluster. This
keeps the full clusters rotated and reclaimed with a minimal latency,
and provide a fair reclaim strategy for most workloads.

Fixes: 2cacbdfdee65 ("mm: swap: add a adaptive full cluster cache reclaim")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 49 +++++++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..f3e0ac20c2e8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -335,6 +335,7 @@ struct swap_info_struct {
 					 * list.
 					 */
 	struct work_struct discard_work; /* discard worker */
+	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..3d9ce12fa95e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -730,15 +730,16 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 	return offset;
 }
 
-static void swap_reclaim_full_clusters(struct swap_info_struct *si)
+/* Return true if reclaimed a whole cluster */
+static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 {
 	long to_scan = 1;
 	unsigned long offset, end;
 	struct swap_cluster_info *ci;
 	unsigned char *map = si->swap_map;
-	int nr_reclaim, total_reclaimed = 0;
+	int nr_reclaim;
 
-	if (atomic_long_read(&nr_swap_pages) <= SWAPFILE_CLUSTER)
+	if (force)
 		to_scan = si->inuse_pages / SWAPFILE_CLUSTER;
 
 	while (!list_empty(&si->full_clusters)) {
@@ -748,28 +749,36 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si)
 		end = min(si->max, offset + SWAPFILE_CLUSTER);
 		to_scan--;
 
+		spin_unlock(&si->lock);
 		while (offset < end) {
 			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
-				spin_unlock(&si->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY | TTRS_DIRECT);
-				spin_lock(&si->lock);
-				if (nr_reclaim > 0) {
-					offset += nr_reclaim;
-					total_reclaimed += nr_reclaim;
-					continue;
-				} else if (nr_reclaim < 0) {
-					offset += -nr_reclaim;
+				if (nr_reclaim) {
+					offset += abs(nr_reclaim);
 					continue;
 				}
 			}
 			offset++;
 		}
-		if (to_scan <= 0 || total_reclaimed)
+		spin_lock(&si->lock);
+
+		if (to_scan <= 0)
 			break;
 	}
 }
 
+static void swap_reclaim_work(struct work_struct *work)
+{
+	struct swap_info_struct *si;
+
+	si = container_of(work, struct swap_info_struct, reclaim_work);
+
+	spin_lock(&si->lock);
+	swap_reclaim_full_clusters(si, true);
+	spin_unlock(&si->lock);
+}
+
 /*
  * Try to get swap entries with specified order from current cpu's swap entry
  * pool (a cluster). This might involve allocating a new cluster for current CPU
@@ -799,6 +808,10 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		goto done;
 	}
 
+	/* Try reclaim from full clusters if free clusters list is drained */
+	if (vm_swap_full())
+		swap_reclaim_full_clusters(si, false);
+
 	if (order < PMD_ORDER) {
 		unsigned int frags = 0;
 
@@ -880,13 +893,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	}
 
 done:
-	/* Try reclaim from full clusters if device is nearfull */
-	if (vm_swap_full() && (!found || (si->pages - si->inuse_pages) < SWAPFILE_CLUSTER)) {
-		swap_reclaim_full_clusters(si);
-		if (!found && !order && si->pages != si->inuse_pages)
-			goto new_cluster;
-	}
-
 	cluster->next[order] = offset;
 	return found;
 }
@@ -921,6 +927,9 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
 		del_from_avail_list(si);
+
+		if (vm_swap_full())
+			schedule_work(&si->reclaim_work);
 	}
 }
 
@@ -2815,6 +2824,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	wait_for_completion(&p->comp);
 
 	flush_work(&p->discard_work);
+	flush_work(&p->reclaim_work);
 
 	destroy_swap_extents(p);
 	if (p->flags & SWP_CONTINUED)
@@ -3375,6 +3385,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		return PTR_ERR(si);
 
 	INIT_WORK(&si->discard_work, swap_discard_work);
+	INIT_WORK(&si->reclaim_work, swap_reclaim_work);
 
 	name = getname(specialfile);
 	if (IS_ERR(name)) {
-- 
2.46.1



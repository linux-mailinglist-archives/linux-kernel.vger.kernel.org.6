Return-Path: <linux-kernel+bounces-376753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D549AB584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD504286950
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0151C6F76;
	Tue, 22 Oct 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZK49nZ+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA61C6F5E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619724; cv=none; b=eD2ikOOyol3VI8BVy6iKGqQIiqFWxaO6bbOQeHzlYtsNQW5w/HSCnbr2Wm7RaRkUrIMXJ83hGSZ6MqXKsNr+0Mh/su7/3nFpXJfw7vsYfypFsLZeBplv7OW2gw6qR5N20jKcruetW+2sdCGx91TxUxCDIahzpJ5uN570fAwYwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619724; c=relaxed/simple;
	bh=+Y+/PcGgJpMk2nEE5XYeoZ6N0UGmnv/pk5IX0E6cZvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3R3cLW8AywFPtwUkalYB0o3CUSgiPAacT0COt93LU0jTHQ6T2SXZ/3E8Y2kiz1MaIhCt7PmlEABl7lk1knzVJxUjKWRoFzDgL72bei+8VFjBp78KYsPUU+rlhT1D3iXsndPqLudbtlqHit57vSH9nMp2kujMKqZiJrR1pAHJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZK49nZ+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71ea2643545so3913722b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729619722; x=1730224522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fR1p2CdHlCuEEst6VnVj+vTqihZCOT2GJV0XoDP9RwQ=;
        b=WZK49nZ+VdOY2Zt5vTehBYlVf+Fuqe5XT9Wfp33WvILCWQStOvXaZcxf2UTjr8J/UX
         gmxYPCOGjPiVzlZeSXybjzFcZJ909G/Z7aCXl48RRfjQK7FtU/zOMhlPuJbAMfjbLS/w
         8YmqG1zfDxBJtTh7FID9Bc4s0FjJen3a4UhQjUsPzULpVDNGvHPiY9yO91jVIpsGQUVJ
         AkR9pmSrhmGCnSrIqsKsKxJzv5+0BnxoFK/OqILm+9divK/5Bg4gvQDdScmZOhEoEX2h
         FDUAYqirPMcdP1rnNra7zxv6obG1+EabUdSoaV0BeZX/S24pv5XKtG/qxJ9f3TFlJsRF
         yTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619722; x=1730224522;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR1p2CdHlCuEEst6VnVj+vTqihZCOT2GJV0XoDP9RwQ=;
        b=jNh+u6v2bx4Utbl6WcVTlwJsB0C2gFYWwew8+ruqR1a9zNb5cgUCmvSRvvx0SMcSAx
         uGmJebsy1iOCxMPIst99yeWTSP09yC81srjnVkKmE3X2dulQy8nXyKOsczLMzAXIcLWW
         wxV7WdOLrqWWszv+GXSN7ipn+EYDNlw8ybRJ2hKcPoNCtQLEZqudlYGddsDSX02hSDBJ
         +I0KNCmhgdKfTXjYsTSZiLAyh9wO70GzoGza/vwVqN47oam1xdQjXPXASE5x43ez9/h/
         pXq/uYV9z78OWqzMWuilkhPQEXsvBW+PAXE6Q0lbdqE1wtHRv4QGRr/+j9I7HxtMYtp8
         x6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVcfuyd8J+CuN54rQXaS3u2BmINMhfLeX24ZtBZ+6e2pEbTfHXQr8N4Mc/PL6NCuADeArfaTeJrByOui6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+EQ+1J8Dh23UXOp0Hdxe0JjgaXLd1xRizNgwzJV40g6iVs0E
	7cOJuHLPOQIqSy/yAwaestbmHRgwr578FqxejMgefnH+10XeacLd
X-Google-Smtp-Source: AGHT+IEiIOJraMTaUAeMRUDZ+DwSmyD/DtDSzP4HDPiKn396oOIVhQfUkOZkRlFZsCHpf+QrfKVVQA==
X-Received: by 2002:a05:6a20:d80c:b0:1d9:239b:a125 with SMTP id adf61e73a8af0-1d92c4df420mr19971012637.15.1729619721093;
        Tue, 22 Oct 2024 10:55:21 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.123.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407da1sm5004535b3a.191.2024.10.22.10.55.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 10:55:20 -0700 (PDT)
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
Subject: [PATCH v2] mm, swap: avoid over reclaim of full clusters
Date: Wed, 23 Oct 2024 01:55:12 +0800
Message-ID: <20241022175512.10398-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
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
device will be usable and workload won't go OOM early.

Before the cluster allocator, swap allocator fails easily if device is
filled up with reclaimable HAS_CACHE slots. Which can be easily
reproduced with following simple program:

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

Setup a 8G non ramdisk swap, the first run of the program will swapout
8G ram successfully. But run same program again after the first run
paused, the second run can't swapout all 8G memory as now half of the
swap device is pinned by HAS_CACHE. There was a random scan in the old
allocator that may reclaim part of the HAS_CACHE by luck, but it's
unreliable.

The new allocator's added reclaim of full clusters when device is low on
usable slots. But when multiple CPUs are seeing the device is low on usable
slots at the same time, they ran into a thundering herd problem.

This is an observable problem on large machine with mass parallel workload,
as full cluster reclaim is slower on large swap device and higher number
of CPUs will also make things worse.

Testing using a 128G ZRAM on a 48c96t system. When the swap device is
very close to full (eg. 124G / 128G), running build linux kernel with
make -j96 in a 1G memory cgroup will hung (not a softlockup though)
spinning in full cluster reclaim for about ~5min before go OOM.

To solve this, split the full reclaim into two parts:

- Instead of do a synchronous aggressively reclaim when device is low,
  do only one aggressively reclaim when device is strictly full with a
  kworker. This still ensures in worst case the device won't be unusable
  because of HAS_CACHE slots.

- To avoid allocation (especially higher order) suffer from HAS_CACHE
  filling up clusters and kworker not responsive enough, do one synchronous
  scan every time the free list is drained, and only scan one cluster. This
  is kind of similar to the random reclaim before, keeps the full clusters
  rotated and has a minimal latency. This should provide a fair reclaim
  strategy suitable for most workloads.

Fixes: 2cacbdfdee65 ("mm: swap: add a adaptive full cluster cache reclaim")
Signed-off-by: Kairui Song <kasong@tencent.com>

---

Update from V1:
https://lore.kernel.org/linux-mm/20240925175241.46679-1-ryncsn@gmail.com/
- Resend patch, minor adjustment of commit message.

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
index b0915f3fab31..46bd4b1a3c07 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -731,15 +731,16 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
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
@@ -749,28 +750,36 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si)
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
@@ -800,6 +809,10 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		goto done;
 	}
 
+	/* Try reclaim from full clusters if free clusters list is drained */
+	if (vm_swap_full())
+		swap_reclaim_full_clusters(si, false);
+
 	if (order < PMD_ORDER) {
 		unsigned int frags = 0;
 
@@ -881,13 +894,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
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
@@ -922,6 +928,9 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
 		del_from_avail_list(si);
+
+		if (vm_swap_full())
+			schedule_work(&si->reclaim_work);
 	}
 }
 
@@ -2816,6 +2825,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	wait_for_completion(&p->comp);
 
 	flush_work(&p->discard_work);
+	flush_work(&p->reclaim_work);
 
 	destroy_swap_extents(p);
 	if (p->flags & SWP_CONTINUED)
@@ -3376,6 +3386,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		return PTR_ERR(si);
 
 	INIT_WORK(&si->discard_work, swap_discard_work);
+	INIT_WORK(&si->reclaim_work, swap_reclaim_work);
 
 	name = getname(specialfile);
 	if (IS_ERR(name)) {
-- 
2.47.0



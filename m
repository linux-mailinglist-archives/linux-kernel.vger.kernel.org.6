Return-Path: <linux-kernel+bounces-383136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB849B17AB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0B5B22856
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318F1D5178;
	Sat, 26 Oct 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnXpZmMz"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60A1D47BB
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943848; cv=none; b=dfu2+xKwFlrKoXZB1D3rcf1D2zXanSR5av9O0e3RNgwHLA+SABGH1kwnbdY0K1lwAQ4SUYoWqm5rb1eLzWeMND1OWOVYAwthlCx/IzhyjWZ7VQdLHkH9gC+w1iDx8uI4S2h8WyE8g+I5q/NVfuN+hIHttATETlGcHofE9fuz7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943848; c=relaxed/simple;
	bh=zQjNjCrVOBEIqrjbQzpcy6iSpNmWOB0RPtUksVOTiKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5xPOf3yHWKhIg2p1FnIfeIGYCdlSCRD7KBZvMMY49t8TTUz3CqfJSe+IcZ4Z2pzVYRg5civTMY4wTyusg9uRpEMrwn8BGerbAwPasTeVGNTBdD7sYGcD76L6kTsa6+MtwYBoXvj4zA9zz83MW+vOUcRtioWy0JLsXvrnDCGOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnXpZmMz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1751215a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729943845; x=1730548645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mojazzZY9EJEZiK2gI73vbSFoW3i9QXTOwDHwlfVGg=;
        b=fnXpZmMznKADArY9o7EJGxkPZp1MkJcaLjS5X1QkCW+iDPHB9GGT0hk7IvvpbZf/vk
         rDcX6p0UhDhYKHHUIjGm0lH695AfE1QXHdtyVUgAcPFRPPjHLu9iOiYXbFGo0ofx5W8r
         qcr0kz8p6B6xyslqfb62KS2FjZ3lAYB3I7PJrGdruiZX/imZ3OIbqwq0rH4BVRmJI9lo
         JWH+xUZhJRgNxDO9kIp5mIkJ+rs342LQrQ9Rx6VPTl4uD5D9jgHUIOzfDaTjhDOT85Zu
         Bp9HczAzAsjC/gS7xu/mDWILL5+oO4yZeVyRmt6Is9p1XsGrOjPf+EPJIZzmIAh8saev
         lpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729943845; x=1730548645;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mojazzZY9EJEZiK2gI73vbSFoW3i9QXTOwDHwlfVGg=;
        b=eapuykLwAyoWQEvvOzl99U2zyV9bFF4DohWvOpJk1tamrhJSDAw/9hjrA6Pse8jULB
         FddJKja4KzStGjsUg4sXqWijOeM4BZ2YoF3qoYJAKr6sNbFaNP/2N62hLT6Pu1FBBilo
         Ldka2Spnt8i4JUnO/bYLiNkZ7en9gwsLHd/XWdlngDz/Pb9mznAcNo2wbNrwxY2hyJEz
         OnNzbMYxf+8QZzj7A8/N+cXws+Q9aJ8qjX33PoxQsV3b801mf2g4kHVqE2Ev/AlP/r+h
         wUechLt1MSbWYhHyLs7wHYoMadbW4H01E2qDBU4UzUN6cyRR+0F37dwarRkTMbUi6yQS
         oH9A==
X-Forwarded-Encrypted: i=1; AJvYcCUFLh8tX3HWkyjDgxVyNfEGkGJR/tuvb1Syg3g02IwQjvsEguda0dG236zzQTaSCUSJdQzWD+Hzt//Wjus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJtb6b94QOmRTny2I7ivyiTM6EhGL6TQrkgM3ODijx8q7dBQu
	kk6ndjV/JXxptciM7uR/SjQ51tI2ASANM224HORI+ieKXxr+59lC
X-Google-Smtp-Source: AGHT+IFSfrbwdJph2pUQUgML3x4x4NmbUTpWB+vHFd1v/uBCN/Xo7vsJ97j04tG9/8BaG1QIbgXEqw==
X-Received: by 2002:a17:90a:c70e:b0:2e5:5ab5:ba4b with SMTP id 98e67ed59e1d1-2e8f107b5b4mr3098886a91.22.1729943844742;
        Sat, 26 Oct 2024 04:57:24 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e374998fsm3294023a91.45.2024.10.26.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 04:57:24 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	kasong@tencent.com,
	linuszeng@tencent.com,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	weixugc@google.com,
	yuzhao@google.com,
	chrisl@kernel.org
Subject: [PATCH v6] mm/vmscan: wake up flushers conditionally to avoid cgroup  OOM
Date: Sat, 26 Oct 2024 19:57:14 +0800
Message-ID: <20241026115714.1437435-1-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.43.5
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
removed the opportunity to wake up flushers during the MGLRU page
reclamation process can lead to an increased likelihood of triggering OOM
when encountering many dirty pages during reclamation on MGLRU.

This leads to premature OOM if there are too many dirty pages in cgroup:
Killed

dd invoked oom-killer: gfp_mask=0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRITE),
order=0, oom_score_adj=0

Call Trace:
  <TASK>
  dump_stack_lvl+0x5f/0x80
  dump_stack+0x14/0x20
  dump_header+0x46/0x1b0
  oom_kill_process+0x104/0x220
  out_of_memory+0x112/0x5a0
  mem_cgroup_out_of_memory+0x13b/0x150
  try_charge_memcg+0x44f/0x5c0
  charge_memcg+0x34/0x50
  __mem_cgroup_charge+0x31/0x90
  filemap_add_folio+0x4b/0xf0
  __filemap_get_folio+0x1a4/0x5b0
  ? srso_return_thunk+0x5/0x5f
  ? __block_commit_write+0x82/0xb0
  ext4_da_write_begin+0xe5/0x270
  generic_perform_write+0x134/0x2b0
  ext4_buffered_write_iter+0x57/0xd0
  ext4_file_write_iter+0x76/0x7d0
  ? selinux_file_permission+0x119/0x150
  ? srso_return_thunk+0x5/0x5f
  ? srso_return_thunk+0x5/0x5f
  vfs_write+0x30c/0x440
  ksys_write+0x65/0xe0
  __x64_sys_write+0x1e/0x30
  x64_sys_call+0x11c2/0x1d50
  do_syscall_64+0x47/0x110
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 memory: usage 308224kB, limit 308224kB, failcnt 2589
 swap: usage 0kB, limit 9007199254740988kB, failcnt 0

  ...
  file_dirty 303247360
  file_writeback 0
  ...

oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=test,
mems_allowed=0,oom_memcg=/test,task_memcg=/test,task=dd,pid=4404,uid=0
Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
oom_score_adj:0

The flusher wake up was removed to decrease SSD wearing, but if we are
seeing all dirty folios at the tail of an LRU, not waking up the flusher
could lead to thrashing easily.  So wake it up when a mem cgroups is about
to OOM due to dirty caches.

I did run the build kernel test[1] on V6, with -j16 1G memcg on my local
branch:

Without the patch(10 times):
user 1449.394
system 368.78 372.58 363.03 362.31 360.84 372.70 368.72 364.94 373.51
366.58 (avg 367.399)
real 164.883

With the V6 patch(10 times):
user 1447.525
system 360.87 360.63 372.39 364.09 368.49 365.15 359.93 362.04 359.72
354.60 (avg 362.79)
real 164.514

Test results show that this patch has about 1% performance improvement,
which should be caused by noise.

---
Changes from v5:
- Make wake-up conditions stricter. [Wei Xu, Jingxiang Zeng]
- Use sc->nr.file_taken to count. [Wei Xu, Jingxiang Zeng]
- Link to v5: https://lore.kernel.org/all/20241018052942.3810740-1-jingxiangzeng.cas@gmail.com/
Changes from v4:
- Add the number of unqueued dirty pages in the shrink_folio_list function
  to sc->nr.unqueued_dirty. [Wei Xu, Jingxiang Zeng]
- Reset sc->nr before calling lru_gen_shrink_node function.
  [Wei Xu, Jingxiang Zeng]
- Modified the conditions for waking up the flusher thread to avoid
  interference from unevictable and anonymous pages.
  [Wei Xu, Jingxiang Zeng]
- Link to v4: https://lore.kernel.org/all/20240929113050.76079-1-jingxiangzeng.cas@gmail.com/
Changes from v3:
- Avoid taking lock and reduce overhead on folio isolation by
  checking the right flags and rework wake up condition, fixing the
  performance regression reported by Chris Li.
  [Chris Li, Kairui Song]
- Move the wake up check to try_to_shrink_lruvec to cover kswapd
  case as well, and update comments. [Kairui Song]
- Link to v3: https://lore.kernel.org/all/20240924121358.30685-1-jingxiangzeng.cas@gmail.com/
Changes from v2:
- Acquire the lock before calling the folio_check_dirty_writeback
  function. [Wei Xu, Jingxiang Zeng]
- Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jingxiangzeng.cas@gmail.com/
Changes from v1:
- Add code to count the number of unqueued_dirty in the sort_folio
  function. [Wei Xu, Jingxiang Zeng]
- Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingxiangzeng.cas@gmail.com/
---

Link: https://lore.kernel.org/all/CACePvbV4L-gRN9UKKuUnksfVJjOTq_5Sti2-e=pb_w51kucLKQ@mail.gmail.com/ [1]
Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 084de0efe59b..794730c8c1de 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4282,6 +4282,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4327,9 +4328,17 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		return true;
 	}
 
+	dirty = folio_test_dirty(folio);
+	writeback = folio_test_writeback(folio);
+	if (type == LRU_GEN_FILE && dirty) {
+		sc->nr.file_taken += delta;
+		if (!writeback)
+			sc->nr.unqueued_dirty += delta;
+	}
+
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+	if (folio_test_locked(folio) || writeback ||
+	    (type == LRU_GEN_FILE && dirty)) {
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4445,7 +4454,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
-
+	if (type == LRU_GEN_FILE)
+		sc->nr.file_taken += isolated;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -4579,6 +4589,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
@@ -4787,6 +4798,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		cond_resched();
 	}
 
+	/*
+	 * If too many file cache in the coldest generation can't be evicted
+	 * due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
@@ -5932,6 +5950,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	bool reclaimable = false;
 
 	if (lru_gen_enabled() && root_reclaim(sc)) {
+		memset(&sc->nr, 0, sizeof(sc->nr));
 		lru_gen_shrink_node(pgdat, sc);
 		return;
 	}
-- 
2.43.5



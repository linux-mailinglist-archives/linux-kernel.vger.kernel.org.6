Return-Path: <linux-kernel+bounces-370954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60E9A343B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399FA285CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB69417BB0D;
	Fri, 18 Oct 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEVFycIv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16015CD74
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229395; cv=none; b=dBTi7CqRsHqgholyqDPJFoq9vuubeIcSV595ZeB1yHap1dVf7/yUvsakNs9WsKZwurs8dc9XP7frVFCdys2Js2T5nKC7TewZ+liEoQMXG8rZOVbjKYYR5rRMyjBEur1xw13Rfa185SloD/GKNNM/DibZpqvSpsOiFmjo/xOXLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229395; c=relaxed/simple;
	bh=iVCC2bJeHk6vVwU8gVLrMihNdsKC9XE+ZBRfm8rYhsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKH/2Ex1T5B4fSyWwJV8fXnXVzAF5w/qEhNKflx8BJhuqPVRW4BtMx0nykYYxuUui19AO+BJyecDPvnz5hA50escD5IE5f0EMCh8vhTvuCSchquXRSU3wwAbyp/uGLKL2l4ASA82UEXcpfBR4Rn6MQQSnPh7Druz6I7IIhoGPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEVFycIv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so1361977a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729229393; x=1729834193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMK51R3vi5oLmBALn45aEZ3BaYW1vEVFexGaGCJTMUY=;
        b=ZEVFycIvGWJSuipaYScBNSbYmorppBL0Fqgy9az7vvfpX11ZxwRfkkNtsvWTiIkQdj
         hWkP9A2BXdeeeFt+kp4FTaKx91vsJ6ZXYIgdJHRZKF4vgPrUEc7fZf//oGxS2eFHslDl
         gAtv0EN3TyDy3yJuIiMMojxKsL2kWM3uVWSX2w0dzbCI0ew+ITnUJjmFWhr2VGhNqN89
         V4yi1NZ3R+HwGOrwuJQtKwKDKDBPac48/4KkGRh1arQdwub+xPahDSNODwE0eaTy4n7b
         VxkDXsJKCJ1/fnPErZswTtNcN2dqSqXg2CRVu8jUe2jxpB0XEuKZPzO846Ap57Z5FgFx
         6/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229393; x=1729834193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMK51R3vi5oLmBALn45aEZ3BaYW1vEVFexGaGCJTMUY=;
        b=CJCGcdwys7ofHD9leyiFEdx8u6YUUL83T6COcoUmNrSMld/IJtHhHllszk24bOVfIz
         pAT8EcjFZjZi69h9DYQBQyZeCZfrUysKqlsadG8U05YX5zpXNqn/huT8DUhi/v2KihAk
         j35ePqr4CjTqMAgbick1usaEabFbqjmYMdyEHqIwWzYPtP/ccxx0b9e/ssQide2B+c2z
         9r7qE04VTS5Cp/xfpHWVTHUp1hNLWoS3b6+hMZpGmZ0Ee8uchDd3W+diOLZUzVkG630B
         diOkFDeSgxiUFkLimxjXpmoPoQOQZahiBdqJUkPS1CaPW8aoURT4qZy2kcTI4pqxgSuH
         ySLw==
X-Forwarded-Encrypted: i=1; AJvYcCX1RiA1wMP8oFO8mKszSitwelIrELc5XQeCIb6tcu9LMAJKFBZ3jPGdsRSVGQrlc6Uo7kuBNqVSVTcs59o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOStGmEKLPFJ4AoPhD3MeEu0f+3DlZhTp81cWXY/uMzj1F+H5
	RoDAWhCB4hXThwjH1Po5SqVU1mVy11HcaOrpiVATtANtb3wgXQblfZFRrt8l
X-Google-Smtp-Source: AGHT+IHQ1FuN57UU+hgXhXlPcRmmLgC1mtvnpNrZqMy8gmnmiGtXNEswAg8iB0EXwi1QByLecQqkmw==
X-Received: by 2002:a17:90a:8d14:b0:2e2:d859:1603 with SMTP id 98e67ed59e1d1-2e561900ccemr1428967a91.25.1729229392616;
        Thu, 17 Oct 2024 22:29:52 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7bf525sm944286a91.15.2024.10.17.22.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:29:52 -0700 (PDT)
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
Subject: [PATCH v5] mm/vmscan: wake up flushers conditionally to avoid cgroup  OOM
Date: Fri, 18 Oct 2024 13:29:42 +0800
Message-ID: <20241018052942.3810740-1-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <Jingxiang Zeng <linuszeng@tencent.com>
References: <Jingxiang Zeng <linuszeng@tencent.com>
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

I did run the build kernel test[1] on V5, with -j16 1G memcg on my local
branch:

Without the patch(10 times):
user 1473.29
system 347.87 339.17 345.28 354.64 352.46 355.63 358.80 359.40 358.28
350.95 (avg 352.248)
real 166.651

With the V5 patch(10 times):
user 1470.7
system 339.13 350.58 350.07 355.58 348.96 344.83 351.78 336.39 350.45
343.31 (avg 347.108)
real 165.821

Test results show that this patch has about 1% performance improvement,
which should be caused by noise.

---
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
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2d0486189804..97e0af338ee0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4292,6 +4292,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4337,9 +4338,14 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		return true;
 	}
 
+	dirty = folio_test_dirty(folio);
+	writeback = folio_test_writeback(folio);
+	if (type == LRU_GEN_FILE && dirty && !writeback)
+		sc->nr.unqueued_dirty += delta;
+
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+	if (folio_test_locked(folio) || writeback ||
+	    (type == LRU_GEN_FILE && dirty)) {
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4455,7 +4461,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
-
+	if (type == LRU_GEN_FILE)
+		sc->nr.taken += isolated;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -4589,6 +4596,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		return scanned;
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
@@ -4797,6 +4805,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		cond_resched();
 	}
 
+	/*
+	 * If too many file cache in the coldest generation can't be evicted
+	 * due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && !sc->nr.taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
@@ -5942,6 +5957,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	bool reclaimable = false;
 
 	if (lru_gen_enabled() && root_reclaim(sc)) {
+		memset(&sc->nr, 0, sizeof(sc->nr));
 		lru_gen_shrink_node(pgdat, sc);
 		return;
 	}
-- 
2.43.5



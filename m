Return-Path: <linux-kernel+bounces-354366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B52993C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A621F23E49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B551CA9C;
	Tue,  8 Oct 2024 01:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEybZ7dP"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99470EC4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352647; cv=none; b=Jo7sSepgZGfGBH+0UMi9J/oec8zd80s699x5xseJWr0qquq48upeAbsxoBlndl7RUJ8zde0gSkf3HSUrlLOCc6woAhd65MHieDMUwKBwlqQDBArMfhrgbiuqDxYhFB5se/UTNTMUTvz2/xQpgYrd45K4CH1O4+NGf9TZdkZqv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352647; c=relaxed/simple;
	bh=ATPYhqhU2xK5OOWSlkZX5DqBmB5A7jTqrErvvMAXsPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Bf+OVekyrwN2dLSjphqSwlvk86ZGYL8wDLgXRes69e8mn6UsRvdKjgOJOS0kSo650te0OvBtGllZLfGkwQ2/GJ/6SKP9STEb2yDQj/jYatst0YKXXeeV8AzPO/fUT2+bZlOJYjlDXqSxeOCKVwAtz22iFqm4u54rNRQc3y3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEybZ7dP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e10ae746aso362477b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728352645; x=1728957445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oO+OwRfE1tRLiIYMV3GpC3hAreDH7qc0g4WcBpwzCHk=;
        b=nEybZ7dPKwE6Gv9zxngfKsjSa8CHx/SlSyJcWJ2/fS8btBoRaUyP4LGyvE1Zww1Hvc
         WuIOe1aeM36J1vz0lhQkhjGCJGC9htjPlc6mVGeZPxl9sdmt1+y75bEQEY4W07ACwldB
         nxyjoKIEa7A8Jj4CqhtaPiv6X+5uDn1Q7J2l38K5auwPgZfaqHExy5IcRgkZ0BUDvZHR
         YFHOCOuEuauvcvYS1tSNXTqgTVlOgHYpXl03UAjt2kOG/MFWvqk4rdA9ofoYimAAGZMj
         2TcZK4IHpYIhK8lPqApLpgjexmgUNkkZv5xUdl07SpzRE1e/FUIQAaL/7m6yKPj8udPT
         u66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352645; x=1728957445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oO+OwRfE1tRLiIYMV3GpC3hAreDH7qc0g4WcBpwzCHk=;
        b=NNpOf5clpZ4o+nYuoY9fWxnMGQAaWGyNRDEs/tZNKFCo5MI8FKfMVDqaRbpKgj916b
         SZrgbc9Lqn4sUxr6Mm433hPvMNORfUf4E5EDjJIxKAb2CnAAXQMcyxKsa87gQxv1OU3u
         rr8DQxzv/xymGSbi3wkWRCMJ1HusErN+qWvMs710WGQ7PO/bxFQsZdyw87UBAizgsoby
         VHeEBVdbbsjRsuCBcCasY7XRdOxIWm+QlDty50tSDWWDsajvZFIGlKHxK88zhL6T/nQi
         ONWA8xlbj7VGqzGQxkybo5vwLWlcAbO1tCpqgdTLOcZNn3qMbKNwbyP+jwyrs9c/2w5H
         zFdA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1Kqx7mIVO5aKD2jlL8dOcKNPGuO3s+QyR2w+CyqhmZsm3IA56xbfmAwykqMiXxlrjOxzZwzw2D6hb0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRC1HY2GhiXSYESVF3CRVcOLG7BVuVwjV79Wt6+itTxzADK18
	Er2oPXHsMCHrxpi7irv35r4bJQcJzObLhxRT8olMIBfv7iRdIspi
X-Google-Smtp-Source: AGHT+IFppnMppS3FFt97vHNG/ldbRYVpwA4EEMaHJ2/W48eBATJnbTDb9BVew4lWT8hy4GmJ0qCfZg==
X-Received: by 2002:a05:6a00:3c81:b0:70d:2a4d:2eeb with SMTP id d2e1a72fcca58-71de23a70a8mr21124857b3a.3.1728352644720;
        Mon, 07 Oct 2024 18:57:24 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c340f7sm5707902a12.73.2024.10.07.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 18:57:24 -0700 (PDT)
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
Subject: [RESEND][PATCH v4] mm/vmscan: wake up flushers conditionally to avoid cgroup  OOM
Date: Tue,  8 Oct 2024 09:56:35 +0800
Message-ID: <20241008015635.2782751-1-jingxiangzeng.cas@gmail.com>
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

From: Jingxiang Zeng <linuszeng@tencent.com>

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

---
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

Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dc7a285b256b..2a5c2fe81467 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4291,6 +4291,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4336,9 +4337,14 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
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
@@ -4454,7 +4460,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
-
+	sc->nr.taken += scanned;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -4796,6 +4802,13 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		cond_resched();
 	}
 
+	/*
+	 * If too many file cache in the coldest generation can't be evicted
+	 * due to being dirty, wake up the flusher.
+	 */
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }
-- 
2.43.5



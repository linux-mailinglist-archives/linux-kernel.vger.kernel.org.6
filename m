Return-Path: <linux-kernel+bounces-342959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0498952A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394EE2828A2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25D143888;
	Sun, 29 Sep 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ZwSlyP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2017736
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609459; cv=none; b=jlLhoa4RQ0UpHsX7mjovha620TmB+8DYUDWT6GPuKb0rkZTXS+LbT7RDXPdqlTe8Xoqtfr5Cp8s/kImZUecbkylckzOHtHnJUPRtjSnTKniyPByjLkfgtPyzb8tG2iq4oFOo25/WpzB4I1XYAzLcCEwVG0GevQAxpP2SmFTr3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609459; c=relaxed/simple;
	bh=lmJ20jjiVIM5WG71V51MQF7cL7ugHDmAA6PRo59UC1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq1zqQN05QyF+BYMhhfOsuHgiGWFcrscoqGK5EYffdHSuy1yuxL2p2CjomrohGeOGcE2IEf5itvj96TnagCr21CfPZPINqXR6aODGE1A0i/HQ1xxp+UPqAMH4hDIsQhj3qYgZrGb5VJ56CWjkzSTRJW/r9aq17WC9IOEpa0WulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ZwSlyP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b64584fd4so4505875ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727609457; x=1728214257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6EbTKSSIMrdfxOrdGxKRCffCAwNII6oo6Oi258NhPg=;
        b=f8ZwSlyPDOmgG8S58u+NWKgLNE0OVThVPFjnHHWcOW2tDp1iXrAu8VHLQ9dnRoKj38
         O3CW3fSsoj91E5wROPO6mWzCa0sz+63TU27QFt+CjKpZpQqov1Pp1N5PQRbwTWDypyfK
         WR+qs7VF40yPPq/aeA82iwRkaTW1GzG5m5TRyWRy9u2PB0xZAbbq/maAPI1GFqB5IP22
         H85De5fyAQrTcnwSIxIOyXyFZ6QgWWNNgyDzirxKcxwbkgSuR//KTAl3tL8V1nrfiBPp
         Gpu8dk39iNIdU5Bj2JWiWMtGGdkIuXEQ6Eh0sN2JdgxbF7Ki+eTEMPRuzmt7Zvrw3Y0h
         c0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727609457; x=1728214257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6EbTKSSIMrdfxOrdGxKRCffCAwNII6oo6Oi258NhPg=;
        b=OLvuX2tucAPwADej7gDSrjn0fqCjVlO1IozCOFO0cp9e8D+AczAaqu8IvX7oYqOXi1
         +PpDkJUqdikx0l+os1q3Kg0LSip5tDBqvuJkkZx9V/mIRQPhfzls/R24BZXPZfpfnPA6
         2GVqajH+HkCB7W6oGuq8/BLhvO3t2BlaylK2lKIcU7Dr3hgNBUgB6a1HT28Kn1vHScpr
         sN7yenAo0r7ibZ3iuNuGAl2cz8f8+5gRPpyZhG7P1dJUnJ1rs6CF54VinknKluFgf2dG
         iQSwCc0Wa28q9soHL2dwg9/hD3XzxGr6ENrYke1+2Qi76H8Pdo4yJIHUxZ+x7DsHll/H
         5F3g==
X-Forwarded-Encrypted: i=1; AJvYcCW58QGXwnSzACBWizpVq5DLmD00FQ/T14EuUjVSOreGYCvKbu7AZ4h/vFZ1yNeMe1TBqupiiU3g57jOMvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdWF/1h/N0kISQi/ZvKDQnVE8pzh8qmWLKgFv1P+RCtXFDABi
	HCJXrqdwNNTK0tOHgXgYKqLDWnW/lCyHPb+N8A/MiMOwB8N1YCVyaTKSXWU0
X-Google-Smtp-Source: AGHT+IFR2v7BqhaWdQKm5lspltn5UFtckVmloEM+GSB4wkBeSTADdB0atrlU9/uQjYfUlVayuxqnBw==
X-Received: by 2002:a17:902:d2d1:b0:20b:849d:48fa with SMTP id d9443c01a7336-20b849d5209mr3487785ad.27.1727609456695;
        Sun, 29 Sep 2024 04:30:56 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d6a0sm38568035ad.169.2024.09.29.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:30:56 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	kasong@tencent.com,
	linuszeng@tencent.com,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	weixugc@google.com,
	yuzhao@google.com
Subject: [PATCH v4] mm/vmscan: wake up flushers conditionally to avoid cgroup  OOM
Date: Sun, 29 Sep 2024 19:30:50 +0800
Message-ID: <20240929113050.76079-1-jingxiangzeng.cas@gmail.com>
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



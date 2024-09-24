Return-Path: <linux-kernel+bounces-337121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734D9845AD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C5A28403C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892B1A7258;
	Tue, 24 Sep 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGMno/o1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D373D1A4F2F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180048; cv=none; b=gYL+D1A1Wj1XaMd/HJ3OaewbGNZsIYrUOMAUFCNGHz0T3jLfdND7D0oPkmE8OjMXsVIG4VIa9SlnafU+rSSiY42JQsetYVZxc+EhxQ39omuZTVlOxMeagHe0lJzfseD0mYPOZ1YbP4l4C4C7rH0vb7Z8g8eMbgtjYnCtFeQLe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180048; c=relaxed/simple;
	bh=GpNCWs+j5gAVZLBCxIb/uryxUevBALvUmx2eAkY2VA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhC5uutylS2CgnozhjVLAGVkHFiqFaao3p0CBjaYOZAziL+K11+Jxj93+HYEXbTzNTZDTOhIcdPo020jmu548AuiyH+zr9g4HlUsl4n2vDaETnLnHtCoXgy3rPZBGW8r8+q+Jdo+y5vAUbeMpB8hSXmFvNAad4SGIQHiSe02yPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGMno/o1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20570b42f24so59730605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727180046; x=1727784846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij5K39dJNQXaF5oy09H6p72Y/tNdpzczJu65QWM5JEs=;
        b=FGMno/o17pYeVlMV8lDSdhPGqUxb/Wj91ak3VWs3X+t+hfNHR4Fft+PSQPozkPLF86
         KAKe7IxV8BVA+4pv8qyUSPc9M2pgUMmgpfyO+ePIheMCG3deIJZwULk3f9Pk7Qb4ZLx+
         u/GyIhHhBfboCZbStLfvppsFAN5f7yLoQUPZozDYUDSZwsWGl8gNIZgN9eG7FAoZjYRK
         GwuBYX6vOfvysiMAGBpmCVtcF82GOWkbTixC8xZqar6f9ioUciQy3Q2886zWJKpdRYoi
         xpHjBSqDWlf3Nx/0aWGXef5CvgasONjFOAS1Z4WS3GkNN9YOtF5AGtjI4Ah3RnSbEtZZ
         uWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727180046; x=1727784846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij5K39dJNQXaF5oy09H6p72Y/tNdpzczJu65QWM5JEs=;
        b=bjmgG7oHuSUvqIgsbJfOXuxv6nQxtxukBEmRmse+TGzfKtbCIQFYNqa49B4njYYZxY
         8Zguz2e4krfZBzgvtwKMjohuWof4YcJxkiVklNQWi+K3hSYnAjZ6vQJqexKzxRyV++/6
         1pc9ws8juobUeQse5ILre7PUUqnSB5rajbRtjVMhlp7rcfeYMJ1qBZGt3sWFh1oTF7hu
         7KYhx7o+Ud53MfnEk5cj2tSxeOaBcgBAWKwXzBTUbau1D3D2xpPwkuZcqFz01LLg+vLf
         nhG+QDGCCr38uNFXPRr4P555tW05Qp1Ecl5Cvmo+js0UceN/VaGZ0EQXrDCpYEn+BZ1Y
         NNbg==
X-Forwarded-Encrypted: i=1; AJvYcCV4bYnAHewDRr7OGFHRrwnomky/LHdkRtXTRJkQTK52YsQc2CNuTJ2zV86Ywmi6hk/qM7Dd53mHwl+iDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6sUULixp31mkdSPy8s5RHDVXGwBjrkeUKeNwkSU8vTeG9mRz
	rWXFuvHRT0YlDG/s+UBSfhzdZwcdUxpaERR9KiE5F7t0bviNk1zi
X-Google-Smtp-Source: AGHT+IFl2YN+Zdem7CJHs6GwVNYDS5112EOg21IFqM3FwWmvFL3Hw4hVFLA+svs4H5kW/Q1BtNZyPA==
X-Received: by 2002:a17:903:2309:b0:205:627c:8001 with SMTP id d9443c01a7336-208d8303cd2mr194458185ad.5.1727180045897;
        Tue, 24 Sep 2024 05:14:05 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1867c1dsm9430045ad.303.2024.09.24.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:14:05 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	kasong@tencent.com,
	linuszeng@tencent.com,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	weixugc@google.com,
	yuzhao@google.com
Subject: [PATCH V3] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
Date: Tue, 24 Sep 2024 20:13:58 +0800
Message-ID: <20240924121358.30685-1-jingxiangzeng.cas@gmail.com>
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

Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.cas@gmail.com
Link: https://lkml.kernel.org/r/20240913084506.3606292-1-jingxiangzeng.cas@gmail.com
Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
Changes from v2:
- Acquire the lock before calling the folio_check_dirty_writeback
  function.
- Link to v2: https://lore.kernel.org/all/20240913084506.3606292-1-jingxiangzeng.cas@gmail.com/
Changes from v1:
- Add code to count the number of unqueued_dirty in the sort_folio
  function.
- Link to v1: https://lore.kernel.org/all/20240829102543.189453-1-jingxiangzeng.cas@gmail.com/
---
 mm/vmscan.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..12c285a96353 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4290,6 +4290,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
+	bool dirty = folio_test_dirty(folio);
+	bool writeback = folio_test_writeback(folio);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
@@ -4330,8 +4332,10 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* waiting for writeback */
-	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
-	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+	if (folio_test_locked(folio) || dirty ||
+	    (type == LRU_GEN_FILE && writeback)) {
+		if (type == LRU_GEN_FILE && dirty && !writeback)
+			sc->nr.unqueued_dirty += delta;
 		gen = folio_inc_gen(lruvec, folio, true);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
@@ -4448,6 +4452,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
+	sc->nr.taken += isolated;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -4920,6 +4925,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
 
+	/*
+	 * If too many pages in the coldest generation that cannot
+	 * be isolated, wake up flusher.
+	 */
+	if (sc->nr.unqueued_dirty > sc->nr.taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-- 
2.43.5



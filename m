Return-Path: <linux-kernel+bounces-327813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57707977B84
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145EF28B1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAB1D88B8;
	Fri, 13 Sep 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTdSqHD6"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7B1D88A4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217118; cv=none; b=f+m0ajmtckW3Ey3kUrVO04M9DkwDczdfWlBSOOlEE+ytX6KiSXGz+czCj2uMP7yHZFvuF49y2DWF4x2Nnj42Aua/KAeTLRWNG8G0Ng3HvM9lPSPc8cl1xTp+TZzOoNIE6vaMnhpc4UFktuEc4IbAN4VpWIJvRczshogOa/tfLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217118; c=relaxed/simple;
	bh=odzaUnYxgwKWpb9lyKm8LsSeHrHNkGsYYV/oDVJ8vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxYFFv8cbwaHyKBUz7GbsmUH3cFstqo9H9kkWXpE8zHX5xtlbwuuQWTZieHNbUfzjK5UfeSELnYfFFmzhG3BD+3+2lsp5v8CPCPasytHmU4TIY7kxnRah1ut8X70HC+SrvSL3KlFdrDpJNh6iQYJH0EDiKN2itJlctgyeJwC/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTdSqHD6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1322036a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726217116; x=1726821916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBaXwW8QjKdmii8I0jDL7B6wKU8ukCvUrMoN+whfYyo=;
        b=XTdSqHD6czgpVX++jmHafuTil5Ds2xObtltoKmf4MT6WUNAeJfyrzRHN5NySoeQZ3X
         C4Zz5OKUOFJFQw/kmMy87zwcAoMSVV0L7l4vLH6auu3sFXyYkIM8LP7fo1b6Y3ScQMZB
         Uz1aakGEPsIdIgX69xLgaPTE8oSM15e+5YUkWYt2qmRlN35MUxLmqxhnknYUIjeJOe0c
         eRS/Mc0nx/IFsI50oKgzsgzaLsLVfMDniIDSuPSVihX87NQCAKk7WJX9UCntuRz2AIEO
         4XIbKs+R9wVgO3oatMvau1e/uQeCT6yMhofGC9rzPZnvgOwprElW3g7WbGlgvG3gBH0C
         0PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726217116; x=1726821916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBaXwW8QjKdmii8I0jDL7B6wKU8ukCvUrMoN+whfYyo=;
        b=HA7C4V2KyiFIxhFG0WrtO3srjKHWPZZnmkwWX1KfSV5Sz9wyI+7dZL9mOSXii7VjHi
         gb3HQCW1ZOSFiC/TdEDagwNCtOuPCRkmAUoNCZlFYuuP1WDnyIPww9VtlG+eYlIDS8Kg
         bnWQ+Z1CYkXdgpkbJkY2sAd0s0yrZaSzDxn3+E6NcHsB/wUuZ75QWtZVlX1Wp2dNiTQO
         hhXDsvj1eKzSZnkwB8mwLt9lNhgCuNdrKaChBKIhWmZL50BiSFbtlrIvQFjbZf/738CS
         M528Lgt41TGabpcAKgkDBrFqGwbA952S2ehLUiGFPqDvpYksF5snL3hI5u5flXpH6Eq/
         2JZg==
X-Forwarded-Encrypted: i=1; AJvYcCXoTZT1NHH2cEwhHboQBzrfMNyMDL18mK9cR/0vKkv5eW7Cr2dowJwsfluWkgOme0SNa05EGGnS++bBXO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/17N5ciQ1GHJwYC0+XE3SHN24KUCk6ff5Egj/yW1raDmys/o
	gu0Rge7cDm1kcTtBViqvFSs3wFXMrfo3CUYhMrcS5ralMO6QKgbA
X-Google-Smtp-Source: AGHT+IEe/ktw1g7ykbDpuyD3WcdpPiVaeAgpfOqsyCOMhflk5+yuFzMnyfckA1sKTTcbC3biWB58Gg==
X-Received: by 2002:a05:6a21:1698:b0:1c0:ec1c:f4a5 with SMTP id adf61e73a8af0-1cf75f00575mr8644130637.25.1726217115686;
        Fri, 13 Sep 2024 01:45:15 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fb9ad9fsm2502679a12.10.2024.09.13.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:45:15 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	kasong@tencent.com,
	linuszeng@tencent.com,
	linux-kernel@vger.kernel.org,
	tjmercier@google.com,
	weixugc@google.com,
	yuzhao@google.com
Subject: [PATCH V2] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
Date: Fri, 13 Sep 2024 16:45:06 +0800
Message-ID: <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
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
could lead to thrashing easily. So wake it up when a mem cgroups is
about to OOM due to dirty caches.

Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.cas@gmail.com
Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: T.J. Mercier <tjmercier@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..ce471d686a88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4284,6 +4284,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		       int tier_idx)
 {
 	bool success;
+	bool dirty, writeback;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
@@ -4332,6 +4333,9 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
+		folio_check_dirty_writeback(folio, &dirty, &writeback);
+		if (dirty && !writeback)
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
@@ -4920,6 +4925,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
 
+	/*
+	 * If too many pages failed to evict due to page being dirty,
+	 * memory pressure have pushed dirty pages to oldest gen,
+	 * wake up flusher.
+	 */
+	if (sc->nr.unqueued_dirty > sc->nr.taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-- 
2.43.5



Return-Path: <linux-kernel+bounces-306673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D805D9641F5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5293E1F2260E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF41922DE;
	Thu, 29 Aug 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyHpG9MS"
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8918F2D3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927154; cv=none; b=jKkXij3zU9t2BqB6NGBDxxuh4GG4fl4M9pIfA3wyGr34g6LuFAcxGpqtzbE8BXo2lq+TBAk/8yMDWY2JU1Ra+N5DPG+pqOgOEfcyzo1Ldpas0hAmHgzwZYYgJKRMhTULG/kCoRt30RGzQXpVZJ80KKMqEBOSg3fA8qzjuRjshaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927154; c=relaxed/simple;
	bh=SYOmoh930tQD+s5ttf0GNd3wvd3oN7ymIjesa7HtAq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dV/aKdZPG0g5VoIsX/zilJIWQINGEe/Q44UnMNi66hBr1Ze/BkvWZAvqadDGGNu+9Tq7eGPUS7LMec+6vwcVPR1q+785DtH4dddJOPHfSB3x4qQ/2CqhpFc/vN4OT6HSQvIaoopW4UySyOmo+6gUWgfONIuVd9c9668R/+gUjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyHpG9MS; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5df9343b5b8so269405eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724927151; x=1725531951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRtWVX/41T5+U+WXO0cDgWlLr0WAJyLIXo4BMUOBCE=;
        b=PyHpG9MSnSsmu3Jb8XOE5/8dkI2MEgU8KRBVutmh1BMv/OCc3QsSiFws/nOxidAgty
         Y4yDIzNJcAxdyuNrmMalB2TOGDJChknOYiWYq8IyzLBMqYnu3C8WSc/RKL199lRBfcVX
         lMjgCYPPHOapKtzu7h+tZdXqjbIj7LbpACpAN7cwyF1JtEnlyJf2Eqi5ZSYHqqxB7vkf
         RnGN3PFWinBfHgrqSrErMP4JtlI2s/buMjXzIs6PBWU4eYpnJsDeIMeTP5IdByF0myEi
         iTYiEmBDnlr7ymQNz83TYsIbLaVeQ3Dp8MPGOTF9C0jy5gjmi3llTyXP4OAJpMlrqbbR
         1uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724927151; x=1725531951;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYRtWVX/41T5+U+WXO0cDgWlLr0WAJyLIXo4BMUOBCE=;
        b=q838hU/eXNlnmJbXjXGwWkJR/2asffqStM6jtI+W24MDV3r2nQjMRUxQjipmYAu13b
         /tOoFCygIxitboQimOrZ5oFiDIhjpyxI1fUnuR1uK+SjFV99M5saH3ylD+NnHZ/n4V5Z
         q3wl4yEACw18fedK/nLRLjCWsQB3czly/g6KrYMdVKdQrqf3nA/sqyYnyLc/Z1T4d6+q
         N35uEywDd13kvbdWIHwmMwyJwAKGwq8isg5zRDs6icetD/2kacAbNZL34fk+/fOdnXF8
         ALhfRMYWJAIq+GgBzAZCJ4KXkIQJID1XcknlW/Ov09OXuob/F7SKTX2tRyFSlAgRFJdU
         9aZw==
X-Forwarded-Encrypted: i=1; AJvYcCVA6BnJuX3nCK9RkmBc0Mmy9MziqCSDtui1mNJfN4/FwhO+gL7mg0VWqY6OvSgN35p8CkrrED9BPM2hAxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhWKg9eijra7XlqMXtxL55m95IkWLQyuT7ObgEy4W9UfFuZkC
	nWozWr5hYmbJ+D8WuxGmZovm/Va9xWzakn7AMxVAVmZNcOEUiFq/
X-Google-Smtp-Source: AGHT+IE2aWk5JqAfpT2qHgBTa8xB3hYzc3d9r11BejHpf6qEenlbPyO8fOLgCPSK5vg4wvWVnd1xJQ==
X-Received: by 2002:a05:6870:c0c4:b0:25e:940:e934 with SMTP id 586e51a60fabf-27790321256mr2657448fac.47.1724927151301;
        Thu, 29 Aug 2024 03:25:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5596d56sm833008b3a.46.2024.08.29.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:25:50 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Wei Xu <weixugc@google.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Kairui Song <kasong@tencent.com>,
	linux-kernel@vger.kernel.org,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
Date: Thu, 29 Aug 2024 18:25:43 +0800
Message-ID: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
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
reclamation process can lead to an increased likelihood of triggering
OOM when encountering many dirty pages during reclamation on MGLRU.

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

MGLRU still suffers OOM issue on latest mm tree, so the test is done
with another fix merged [1].

Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]

Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f27792e77a0f..9cd8c42f67cb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4447,6 +4447,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				scanned, skipped, isolated,
 				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
+	sc->nr.taken += isolated;
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -4919,6 +4920,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
 
+	/*
+	 * If too many pages failed to evict due to page being dirty,
+	 * memory pressure have pushed dirty pages to oldest gen,
+	 * wake up flusher.
+	 */
+	if (sc->nr.unqueued_dirty >= sc->nr.taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-- 
2.43.5



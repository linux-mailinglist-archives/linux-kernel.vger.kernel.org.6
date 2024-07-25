Return-Path: <linux-kernel+bounces-262043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB693BFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BA11C21990
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C81198E6C;
	Thu, 25 Jul 2024 10:29:48 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDC12B95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903387; cv=none; b=HcWtbSIO3dy3zMR74ras2ya48cJ+tMExsD374JIRacsVsikFpAtEdlmauH0D12SF6CRtyXYjzIxGZx0uBtAs0VVLv2GXYJDn8cLIQEvUyfTvIFN8watRFn0Y6cY9msn3K4iTRd6qZnol/KAOuzqm8jJF8MLsu6A9KksPo5HyyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903387; c=relaxed/simple;
	bh=b4qU6vv45nZ3/NzDEK3kLx4DBakGCvmJ5ReYuQG38gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mP8IMQt95T5JAwEfC6TpSstQLzhGx4L2ZQVkjvvzAZhk75Z4mZrfGuzC/m7lmOALunn03YOpSMfPNOGOl3Iu6Qbbaw4BkCoGwN0FC+L0dIdCyizgpY4NHRjXNFIJD8xG8OMgS+LSVHSN5PD9uZQlrqK9atwEiXXi2HzL15c3BKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 46P9xtqC080300
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:59:55 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 46P9xgUY079853;
	Thu, 25 Jul 2024 17:59:42 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WV5nQ2Yfxz2M5vHM;
	Thu, 25 Jul 2024 17:54:02 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 25 Jul 2024 17:59:40 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: <bharata@amd.com>
CC: <Neeraj.Upadhyay@amd.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <kinseyho@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <mgorman@suse.de>, <mjguzik@gmail.com>,
        <nikunj@amd.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <yuzhao@google.com>, <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Date: Thu, 25 Jul 2024 17:59:33 +0800
Message-ID: <20240725095933.2640875-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
References: <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 46P9xgUY079853

>However during the weekend mglru-enabled run (with above fix to 
>isolate_lru_folios() and also the previous two patches: truncate.patch 
>and mglru.patch and the inode fix provided by Mateusz), another hard 
>lockup related to lruvec spinlock was observed.
>
>Here is the hardlock up:
>
>watchdog: Watchdog detected hard LOCKUP on cpu 466
>CPU: 466 PID: 3103929 Comm: fio Not tainted 
>6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
>RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
>Call Trace:
>   <NMI>
>   ? show_regs+0x69/0x80
>   ? watchdog_hardlockup_check+0x1b4/0x3a0
><SNIP>
>   ? native_queued_spin_lock_slowpath+0x2b4/0x300
>   </NMI>
>   <IRQ>
>   _raw_spin_lock_irqsave+0x5b/0x70
>   folio_lruvec_lock_irqsave+0x62/0x90
>   folio_batch_move_lru+0x9d/0x160
>   folio_rotate_reclaimable+0xab/0xf0
>   folio_end_writeback+0x60/0x90
>   end_buffer_async_write+0xaa/0xe0
>   end_bio_bh_io_sync+0x2c/0x50
>   bio_endio+0x108/0x180
>   blk_mq_end_request_batch+0x11f/0x5e0
>   nvme_pci_complete_batch+0xb5/0xd0 [nvme]
>   nvme_irq+0x92/0xe0 [nvme]
>   __handle_irq_event_percpu+0x6e/0x1e0
>   handle_irq_event+0x39/0x80
>   handle_edge_irq+0x8c/0x240
>   __common_interrupt+0x4e/0xf0
>   common_interrupt+0x49/0xc0
>   asm_common_interrupt+0x27/0x40
>
>Here is the lock holder details captured by all-cpu-backtrace:
>
>NMI backtrace for cpu 75
>CPU: 75 PID: 3095650 Comm: fio Not tainted 
>6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
>RIP: 0010:folio_inc_gen+0x142/0x430
>Call Trace:
>   <NMI>
>   ? show_regs+0x69/0x80
>   ? nmi_cpu_backtrace+0xc5/0x130
>   ? nmi_cpu_backtrace_handler+0x11/0x20
>   ? nmi_handle+0x64/0x180
>   ? default_do_nmi+0x45/0x130
>   ? exc_nmi+0x128/0x1a0
>   ? end_repeat_nmi+0xf/0x53
>   ? folio_inc_gen+0x142/0x430
>   ? folio_inc_gen+0x142/0x430
>   ? folio_inc_gen+0x142/0x430
>   </NMI>
>   <TASK>
>   isolate_folios+0x954/0x1630
>   evict_folios+0xa5/0x8c0
>   try_to_shrink_lruvec+0x1be/0x320
>   shrink_one+0x10f/0x1d0
>   shrink_node+0xa4c/0xc90
>   do_try_to_free_pages+0xc0/0x590
>   try_to_free_pages+0xde/0x210
>   __alloc_pages_noprof+0x6ae/0x12c0
>   alloc_pages_mpol_noprof+0xd9/0x220
>   folio_alloc_noprof+0x63/0xe0
>   filemap_alloc_folio_noprof+0xf4/0x100
>   page_cache_ra_unbounded+0xb9/0x1a0
>   page_cache_ra_order+0x26e/0x310
>   ondemand_readahead+0x1a3/0x360
>   page_cache_sync_ra+0x83/0x90
>   filemap_get_pages+0xf0/0x6a0
>   filemap_read+0xe7/0x3d0
>   blkdev_read_iter+0x6f/0x140
>   vfs_read+0x25b/0x340
>   ksys_read+0x67/0xf0
>   __x64_sys_read+0x19/0x20
>   x64_sys_call+0x1771/0x20d0
>   do_syscall_64+0x7e/0x130

From the callstack of lock holder, it is looks like a scability issue rather than a deadlock. Unlike legacy LRU management, there is no throttling mechanism for global reclaim under mglru so far.Could we apply the similar method to throttle the reclaim when it is too aggresive. I am wondering if this patch which is a rough version could help on this?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..827036e21f24 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4520,6 +4520,50 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	return scanned;
 }
 
+static void lru_gen_throttle(pg_data_t *pgdat, struct scan_control *sc)
+{
+	struct lruvec *target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
+	if (current_is_kswapd()) {
+		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
+			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
+
+		/* Allow kswapd to start writing pages during reclaim.*/
+		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+			set_bit(PGDAT_DIRTY, &pgdat->flags);
+
+		if (sc->nr.immediate)
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
+
+	/*
+	 * Tag a node/memcg as congested if all the dirty pages were marked
+	 * for writeback and immediate reclaim (counted in nr.congested).
+	 *
+	 * Legacy memcg will stall in page writeback so avoid forcibly
+	 * stalling in reclaim_throttle().
+	 */
+	if (sc->nr.dirty && (sc->nr.dirty / 2 < sc->nr.congested)) {
+		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc))
+			set_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags);
+
+		if (current_is_kswapd())
+			set_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags);
+	}
+
+	/*
+	 * Stall direct reclaim for IO completions if the lruvec is
+	 * node is congested. Allow kswapd to continue until it
+	 * starts encountering unqueued dirty pages or cycling through
+	 * the LRU too quickly.
+	 */
+	if (!current_is_kswapd() && current_may_throttle() &&
+	    !sc->hibernation_mode &&
+	    (test_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags) ||
+	     test_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags)))
+		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
+}
+
 static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
 {
 	int type;
@@ -4552,6 +4596,16 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+	sc->nr.dirty += stat.nr_dirty;
+	sc->nr.congested += stat.nr_congested;
+	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
+	sc->nr.writeback += stat.nr_writeback;
+	sc->nr.immediate += stat.nr_immediate;
+	sc->nr.taken += scanned;
+
+	if (type)
+		sc->nr.file_taken += scanned;
+
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
 			scanned, reclaimed, &stat, sc->priority,
 			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
@@ -5908,6 +5962,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	if (lru_gen_enabled() && root_reclaim(sc)) {
 		lru_gen_shrink_node(pgdat, sc);
+		lru_gen_throttle(pgdat, sc);
 		return;
 	}
 
-- 
2.25.1



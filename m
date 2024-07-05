Return-Path: <linux-kernel+bounces-242518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757AA928955
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB731F21783
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C8114A622;
	Fri,  5 Jul 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCoTlVsr"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EBC143C79
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184926; cv=none; b=GWpUn1OCKTYWZSGl/u3g3e5WhOyy/z2JGjqi0HMRQ5DeCMmndb13qBA7/1/vAE+6Qd8qeQYgHNEZdIvT0I3Da9A4bWBX3EcgIHOBWgROxWNk19WQYsyR+FPadYzu+tgdksFPp+Nn/xbNzTMYYgVpqE+FeqWoSgEso75OyXz9QDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184926; c=relaxed/simple;
	bh=wXmn/HAgy8K9K61PiXzgKEH2fBfdI6zjZ7TD6WKFapk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jXCY4oP8vft0Gpwwl6i3h7q1f8JwXYxyEBMVroVwTd+4fdGYJ6zV8hIYliJppi6XeZ7LnY0FlHJOP9ejAKXBKy4Mu9VZTrMYqGRWsCuWD/7dzX+3y9VPQNI9rp1gybOYdKo+QkaQKBVBh2rvDzwF2tGh33IYlFP8a068m8NqX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCoTlVsr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso6996945ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720184924; x=1720789724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzMzMen4mMOH7WJ2OeAEXcey8lmVegvshZBU/sBgtQc=;
        b=WCoTlVsrkSUdyE/GZhSsEnRovCaL+5KCrpqsTNJzsI834iqiSFnPzjtifsGwAutOIW
         KSNIhSTQ3rIwyTgiLwSEdbK7BBzfKPQ/7roAvgXdwPXusEdB6NdPY5lUvWPK2hfxw/if
         1Wc30jkixe/fz+ouIIED7Xgy2mWSdp/fgwxxAgabfdAy2bWE2Yk1+EWOJOwzYKb41bq+
         F5zQukvEHCxZVdVX1+/Tc+nlBBvYavHaTrud6Hz3qECeNYHuVXKbAmFIMGk54E0J9c4b
         OZwKiY6wybBBz4zW+3F0NuhcpleZ6FE0zdYAAHPHUOZ4b8Hj96zZAgNYEcsG1eJ9zldR
         GSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720184924; x=1720789724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzMzMen4mMOH7WJ2OeAEXcey8lmVegvshZBU/sBgtQc=;
        b=DcQt+6xf5WzMInB0CqYR9ZqJUhAWSo6RmKBqbbHJwXA/V2jdAGPo4jcuAFp0vXXkGE
         TbkpqkhVvGLWf1topGvk92FAoGteT2puWXGmCufWCY/JhOSz0suz0SZHcpSU46IKq+ce
         +GdKJdG5CNsg/6h5boTlxXa9VDa4XKtJy0MMB/Iv/XmJwXvzhNxXV7zD7gVHjOk4XGk6
         ky8ZU8DMGh2a4eFzIFdBzuQ/1xazXAeYy1HebR4JY+zh12aofxZo0UOATa40czyHFrdp
         OoERG3JwllCBl+ccUkcNY1KN0Rd0cR3amlyIFcAahQ+mOyR0Jlx47LJCl6klP60HQyEs
         sDkw==
X-Forwarded-Encrypted: i=1; AJvYcCVmYwsikE1Md58SSyPPY/tiyqhhJEP0Xg/U6NzChY6l5eaVCvLf6hO4b1mI+MtmtjhwNw8PEDFivSpiPo533b3QeVZymmHszrKmQ2AM
X-Gm-Message-State: AOJu0YyfpxoNC5U6jEOq7SXX0qqf5+G+s//0EJazS5V2p+7MOavRWqUQ
	zDuEFolGH2LyD6UksueLC272ws2FLoG+yq38fs48+plYIMeWkFfc
X-Google-Smtp-Source: AGHT+IGaqK9f9AEo/SmeQn/sKMsjzUFfQfwlv4YVRQtQOAWre9fLO6IoR+GX7FFZZF7pMJHWavIpHQ==
X-Received: by 2002:a17:903:22c7:b0:1fb:1cc3:6482 with SMTP id d9443c01a7336-1fb33efc329mr29022335ad.45.1720184923843;
        Fri, 05 Jul 2024 06:08:43 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-201-219.dynamic-ip.hinet.net. [220.143.201.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8b92sm140147185ad.22.2024.07.05.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:08:43 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node() when enabling kasan
Date: Fri,  5 Jul 2024 21:08:08 +0800
Message-Id: <20240705130808.1581-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When compiling kernel source 'make -j $(nproc)' with the up-and-running
KASAN-enabled kernel on a 256-core machine, the following soft lockup
is shown:

watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
Workqueue: events drain_vmap_area_work
RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
Code: 38 c8 7c 08 84 c9 0f 85 49 08 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 e9 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 d4 06 00 00 8b 45 08 a8 01 75
RSP: 0018:ffffc9000cb3fb60 EFLAGS: 00000202
RAX: 0000000000000011 RBX: ffff8883bc4469c0 RCX: ffffed10776e9949
RDX: 0000000000000002 RSI: ffff8883bb74ca48 RDI: ffffffff8434dc50
RBP: ffff8883bb74ca40 R08: ffff888103585dc0 R09: ffff8884533a1800
R10: 0000000000000004 R11: ffffffffffffffff R12: ffffed1077888d39
R13: dffffc0000000000 R14: ffffed1077888d38 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff8883bc400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005577b5c8d158 CR3: 0000000004850000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 ? watchdog_timer_fn+0x2cd/0x390
 ? __pfx_watchdog_timer_fn+0x10/0x10
 ? __hrtimer_run_queues+0x300/0x6d0
 ? sched_clock_cpu+0x69/0x4e0
 ? __pfx___hrtimer_run_queues+0x10/0x10
 ? srso_return_thunk+0x5/0x5f
 ? ktime_get_update_offsets_now+0x7f/0x2a0
 ? srso_return_thunk+0x5/0x5f
 ? srso_return_thunk+0x5/0x5f
 ? hrtimer_interrupt+0x2ca/0x760
 ? __sysvec_apic_timer_interrupt+0x8c/0x2b0
 ? sysvec_apic_timer_interrupt+0x6a/0x90
 </IRQ>
 <TASK>
 ? asm_sysvec_apic_timer_interrupt+0x16/0x20
 ? smp_call_function_many_cond+0x1d8/0xbb0
 ? __pfx_do_kernel_range_flush+0x10/0x10
 on_each_cpu_cond_mask+0x20/0x40
 flush_tlb_kernel_range+0x19b/0x250
 ? srso_return_thunk+0x5/0x5f
 ? kasan_release_vmalloc+0xa7/0xc0
 purge_vmap_node+0x357/0x820
 ? __pfx_purge_vmap_node+0x10/0x10
 __purge_vmap_area_lazy+0x5b8/0xa10
 drain_vmap_area_work+0x21/0x30
 process_one_work+0x661/0x10b0
 worker_thread+0x844/0x10e0
 ? srso_return_thunk+0x5/0x5f
 ? __kthread_parkme+0x82/0x140
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2a5/0x370
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Debugging Analysis:
 1. [Crash] The call trace indicates CPU #28 is waiting for other CPUs'
    responses by sending an IPI message in order to flush tlb.
    However, crash indicates the target CPU has responded.

     A. CPU #28 is waiting for CPU #2' response.

	crash> cfd_data | grep -w 28
	  [28]: ffff8883bc4469c0
	crash> struct call_function_data ffff8883bc4469c0
	struct call_function_data {
	  csd = 0x4ca40,
	  cpumask = 0xffff888103585e40,
	  cpumask_ipi = 0xffff8881035858c0
	}

        crash> struct __call_single_data 0x4ca40:a | grep ffff8883bb74ca40
        [2]: ffff8883bb74ca40

     B. CPU #2 has responded because the bit 'CSD_FLAG_LOCK' of u_flags
        is cleared.

        crash> struct __call_single_data 0xffff8883bb74ca40
        struct __call_single_data {
          node = {
            ...
            {
              u_flags = 0,
              a_flags = {
                counter = 0
              }
            },
	    ...
          },
          func = 0xffffffff8117b080 <do_kernel_range_flush>,
          info = 0xffff8883bc444940
        }

     C. CPU #2 is running userspace application 'nm'.

        crash> bt -c 2
	PID: 52035  TASK: ffff888194c21ac0  CPU: 2   COMMAND: "nm"
 	#0 [ffffc90043157ea8] crash_nmi_callback at ffffffff81122f42
 	#1 [ffffc90043157eb0] nmi_handle at ffffffff8108c988
	#2 [ffffc90043157f10] default_do_nmi at ffffffff835b3460
 	#3 [ffffc90043157f30] exc_nmi at ffffffff835b3630
 	#4 [ffffc90043157f50] asm_exc_nmi at ffffffff83601573
        RIP: 00007f6261b90d38 RSP: 00007ffe4d1cb180 RFLAGS: 00000202
        RAX: 0000000000000001 RBX: 6e6f2d7865646e69 RCX: 00007f626281f634
        RDX: 00007f6262ba7f67 RSI: 00007f626265f65e RDI: 00007f62648f8a30
        RBP: 2d6f746c6e696874  R8: 00007f62618a4cc0  R9: 0000000000000001
        R10: 00007f627233e488 R11: 00007f627233d768 R12: 000055bee0ff4b90
        R13: 000055bee0fac650 R14: 00007ffe4d1cb280 R15: 0000000000000000
        ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

     D. The soft lockup CPU iteratively traverses 128 vmap_nodes (128 bits
	are set) and flushes tlb. This might be the time-consuming work.

	crash> p /x purge_nodes
	$1 = {
	  bits = {0xffffffffffffffff, 0xffffffffffffffff, 0x0, ...}

 2. [Ftrace] In order to prove that the soft lockup CPU spends too much
    time iterating vmap_nodes and flushing tlb when purging vm_area
    structures, the ftrace confirms the speculation (Some info is trimmed).

     kworker: funcgraph_entry:		    |  drain_vmap_area_work() {
     kworker: funcgraph_entry:              |   mutex_lock() {
     kworker: funcgraph_entry:  1.092 us    |     __cond_resched();
     kworker: funcgraph_exit:   3.306 us    |   }
     ...				        ...
     kworker: funcgraph_entry: 		    |    flush_tlb_kernel_range() {
     ...				 	  ...
     kworker: funcgraph_exit: # 7533.649 us |    }
     ...                                         ...
     kworker: funcgraph_entry:  2.344 us    |   mutex_unlock();
     kworker: funcgraph_exit: $ 23871554 us | }

     The drain_vmap_area_work() spends over 23 seconds.

     There are 2805 flush_tlb_kernel_range() calls in this ftrace log.
       * One is called in __purge_vmap_area_lazy().
       * Others are called in kasan_release_vmalloc().

 3. Extending the soft lockup time can work around the issue (For example,
    # echo 60 > /proc/sys/kernel/watchdog_thresh). This confirms the
    above-mentioned speculation: drain_vmap_area_work() spends too much
    time.

Commit 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
employs an effective vmap node logic. However, current design iterates
128 vmap_nodes and flushes tlb by a single CPU if
vmap_lazy_nr < 2 * lazy_max_pages(). When enabling kasan, this might
trigger the soft lockup because additional tlb flushes of kasan vmalloc
spend much more time if 128 vmap nodes have the available purge list.

Fix the issue by adding preempt point in purge_vmap_node() when
enabling kasan.

Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-and-tested-by: Jiwei Sun <sunjw10@lenovo.com>
---
 mm/vmalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d0cbdd7c1e5b..380bdc317c8d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2193,6 +2193,15 @@ static void purge_vmap_node(struct work_struct *work)
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
+	/*
+	 * Add the preemption point when enabling KASAN. Each vmap_area of
+	 * vmap nodes has to flush tlb when releasing vmalloc, which might
+	 * be the time-consuming work if lots of vamp nodes have the
+	 * available purge list.
+	 */
+	if (kasan_enabled())
+		cond_resched();
+
 	vn->nr_purged = 0;
 
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
-- 
2.34.1



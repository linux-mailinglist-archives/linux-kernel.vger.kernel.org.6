Return-Path: <linux-kernel+bounces-242703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB218928BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB071F25888
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEED16C6A7;
	Fri,  5 Jul 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXTplHGj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979F18AF4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193797; cv=none; b=gWWvSAPdLzqiwHyItxL6u++vX84rdGrhA6XHPqIm39DeH8Zda7crPM+vInPU0AYctYvLpSRo6QbOUbVzvqbqdjQvtp8nIDa0lkfLSnwxaIDPRSLmrbnQgjYhj9gubEGkRtiNSzocJyhJ3SFIeJSRI+SZlUrq5X7YVK44x/Ndp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193797; c=relaxed/simple;
	bh=XPU2WmfxmFUnsnFSplKybijzyaIcRBm62uzXwf5sY38=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAZUTGuPJBQoA7fq6NDlHVFWbaonquoDf1kyUnciXNC/YNDbNZYBuy7Tv1EWqZ1oK9cl6Y5zCawl6cRlr8yfPCulogPotG0MBwLJEpKArU9W6Wa1BqMuszhvp9wbl1H614eWu8GYLwlZtrII0q/Dlc5v29jlpKP4SepClyXsPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXTplHGj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea7bdde68so717359e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720193794; x=1720798594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIZP3joz7yWrDjusAFwphux3IuUyMO032ZfYF3VwyQw=;
        b=ZXTplHGjANQjcyuqRzg2UJ++rauyFb2VvxaK3J+VEePneQufaX1hQwLZCL8pjJO9kl
         1DgPmhBzxKafejfCzi4K3nQrdrqPe1YDcY6maCiYJdEYON5uIzctL5yRKRaoi25QUtbt
         hC4rN5mi+zI5Tx7czDRhhn0jgb4c3k20gd2KmiOC4v0QHuHO7Q+a4/d+jJaF2PAxMqsF
         luwxnBkuNHjiZd1M1hRDCXi72qK6V4hT5JoxIJHa06cDfti8XGHik278BkmntxmUQ8JG
         9hvSStsg7k7agdjacPg3WpTDaEiIziEUUNSpZyh3MdpkAkY8o/9t1e8MnCisTj/EE4z6
         rEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720193794; x=1720798594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIZP3joz7yWrDjusAFwphux3IuUyMO032ZfYF3VwyQw=;
        b=Gy6AMJhLs0nKfqgT6tWXKVVjMgBo9m7k5dkzLKxrNFexoP2UBH0qtFPG9+ub86UZip
         g/XG6El7hW/7BopTQwCWCXvOhF5xE2QrojD7tkUAeTNqjJsRxtOCyFZ5HTi5h3pdwpiA
         P9FflvaL5051WDPTqDY0AElyGuG4nu4sPxlxO5DmkJ3GTTQlnWRfDSMpGx83ohqRGnQ5
         qk3BLE/4H8sUK0NgOE4HDZtskCUQnKeGOV3uVYSHaGMB6+2y3by9/6wA2gJTAUPTPRNO
         CIn16Fsqg7jasGx37ie5WgyMPn6/pmOQhFenTG8FpjRQ6Sck44nli1UnabAU1HLfV7mf
         Jyrg==
X-Forwarded-Encrypted: i=1; AJvYcCVQj/WN2AROjW7+cY1yzGQOJR3qs3jGH9g/VuW7Zyd7D9MNm+ST49DBSG9TlUYwktKlIZX+mkKOQ7bbmeCWEsVW+0YNesLcUS7Yl5F3
X-Gm-Message-State: AOJu0YwsxfdR/h7+uvj2XMItqqN5R4fGbN0EJI8odoQMZXWe8bFW7gxj
	+SKmos8We/e7fQ6Wg8OpllO94j7hlGxA0fqeAUQA8VL9pPkme3UO
X-Google-Smtp-Source: AGHT+IFvc0sePQPs0XiSA4BWWPuO+g4TAgR+1Z4B4ZKB+IN0mOTsPlcAAdDOqlgZ/WAtSAfHJEMSdg==
X-Received: by 2002:a19:5511:0:b0:52e:969c:db83 with SMTP id 2adb3069b0e04-52ea0629f3amr3357579e87.17.1720193793675;
        Fri, 05 Jul 2024 08:36:33 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea1b0bf6fsm524345e87.108.2024.07.05.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:36:33 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 5 Jul 2024 17:36:31 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Add preempt point in purge_vmap_node()
 when enabling kasan
Message-ID: <ZogS_04dP5LlRlXN@pc636>
References: <20240705130808.1581-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705130808.1581-1-ahuang12@lenovo.com>

On Fri, Jul 05, 2024 at 09:08:08PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When compiling kernel source 'make -j $(nproc)' with the up-and-running
> KASAN-enabled kernel on a 256-core machine, the following soft lockup
> is shown:
> 
> watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
> CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
> Workqueue: events drain_vmap_area_work
> RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
> Code: 38 c8 7c 08 84 c9 0f 85 49 08 00 00 8b 45 08 a8 01 74 2e 48 89 f1 49 89 f7 48 c1 e9 03 41 83 e7 07 4c 01 e9 41 83 c7 03 f3 90 <0f> b6 01 41 38 c7 7c 08 84 c0 0f 85 d4 06 00 00 8b 45 08 a8 01 75
> RSP: 0018:ffffc9000cb3fb60 EFLAGS: 00000202
> RAX: 0000000000000011 RBX: ffff8883bc4469c0 RCX: ffffed10776e9949
> RDX: 0000000000000002 RSI: ffff8883bb74ca48 RDI: ffffffff8434dc50
> RBP: ffff8883bb74ca40 R08: ffff888103585dc0 R09: ffff8884533a1800
> R10: 0000000000000004 R11: ffffffffffffffff R12: ffffed1077888d39
> R13: dffffc0000000000 R14: ffffed1077888d38 R15: 0000000000000003
> FS:  0000000000000000(0000) GS:ffff8883bc400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005577b5c8d158 CR3: 0000000004850000 CR4: 0000000000350ef0
> Call Trace:
>  <IRQ>
>  ? watchdog_timer_fn+0x2cd/0x390
>  ? __pfx_watchdog_timer_fn+0x10/0x10
>  ? __hrtimer_run_queues+0x300/0x6d0
>  ? sched_clock_cpu+0x69/0x4e0
>  ? __pfx___hrtimer_run_queues+0x10/0x10
>  ? srso_return_thunk+0x5/0x5f
>  ? ktime_get_update_offsets_now+0x7f/0x2a0
>  ? srso_return_thunk+0x5/0x5f
>  ? srso_return_thunk+0x5/0x5f
>  ? hrtimer_interrupt+0x2ca/0x760
>  ? __sysvec_apic_timer_interrupt+0x8c/0x2b0
>  ? sysvec_apic_timer_interrupt+0x6a/0x90
>  </IRQ>
>  <TASK>
>  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>  ? smp_call_function_many_cond+0x1d8/0xbb0
>  ? __pfx_do_kernel_range_flush+0x10/0x10
>  on_each_cpu_cond_mask+0x20/0x40
>  flush_tlb_kernel_range+0x19b/0x250
>  ? srso_return_thunk+0x5/0x5f
>  ? kasan_release_vmalloc+0xa7/0xc0
>  purge_vmap_node+0x357/0x820
>  ? __pfx_purge_vmap_node+0x10/0x10
>  __purge_vmap_area_lazy+0x5b8/0xa10
>  drain_vmap_area_work+0x21/0x30
>  process_one_work+0x661/0x10b0
>  worker_thread+0x844/0x10e0
>  ? srso_return_thunk+0x5/0x5f
>  ? __kthread_parkme+0x82/0x140
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x2a5/0x370
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x30/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Debugging Analysis:
>  1. [Crash] The call trace indicates CPU #28 is waiting for other CPUs'
>     responses by sending an IPI message in order to flush tlb.
>     However, crash indicates the target CPU has responded.
> 
>      A. CPU #28 is waiting for CPU #2' response.
> 
> 	crash> cfd_data | grep -w 28
> 	  [28]: ffff8883bc4469c0
> 	crash> struct call_function_data ffff8883bc4469c0
> 	struct call_function_data {
> 	  csd = 0x4ca40,
> 	  cpumask = 0xffff888103585e40,
> 	  cpumask_ipi = 0xffff8881035858c0
> 	}
> 
>         crash> struct __call_single_data 0x4ca40:a | grep ffff8883bb74ca40
>         [2]: ffff8883bb74ca40
> 
>      B. CPU #2 has responded because the bit 'CSD_FLAG_LOCK' of u_flags
>         is cleared.
> 
>         crash> struct __call_single_data 0xffff8883bb74ca40
>         struct __call_single_data {
>           node = {
>             ...
>             {
>               u_flags = 0,
>               a_flags = {
>                 counter = 0
>               }
>             },
> 	    ...
>           },
>           func = 0xffffffff8117b080 <do_kernel_range_flush>,
>           info = 0xffff8883bc444940
>         }
> 
>      C. CPU #2 is running userspace application 'nm'.
> 
>         crash> bt -c 2
> 	PID: 52035  TASK: ffff888194c21ac0  CPU: 2   COMMAND: "nm"
>  	#0 [ffffc90043157ea8] crash_nmi_callback at ffffffff81122f42
>  	#1 [ffffc90043157eb0] nmi_handle at ffffffff8108c988
> 	#2 [ffffc90043157f10] default_do_nmi at ffffffff835b3460
>  	#3 [ffffc90043157f30] exc_nmi at ffffffff835b3630
>  	#4 [ffffc90043157f50] asm_exc_nmi at ffffffff83601573
>         RIP: 00007f6261b90d38 RSP: 00007ffe4d1cb180 RFLAGS: 00000202
>         RAX: 0000000000000001 RBX: 6e6f2d7865646e69 RCX: 00007f626281f634
>         RDX: 00007f6262ba7f67 RSI: 00007f626265f65e RDI: 00007f62648f8a30
>         RBP: 2d6f746c6e696874  R8: 00007f62618a4cc0  R9: 0000000000000001
>         R10: 00007f627233e488 R11: 00007f627233d768 R12: 000055bee0ff4b90
>         R13: 000055bee0fac650 R14: 00007ffe4d1cb280 R15: 0000000000000000
>         ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> 
>      D. The soft lockup CPU iteratively traverses 128 vmap_nodes (128 bits
> 	are set) and flushes tlb. This might be the time-consuming work.
> 
> 	crash> p /x purge_nodes
> 	$1 = {
> 	  bits = {0xffffffffffffffff, 0xffffffffffffffff, 0x0, ...}
> 
>  2. [Ftrace] In order to prove that the soft lockup CPU spends too much
>     time iterating vmap_nodes and flushing tlb when purging vm_area
>     structures, the ftrace confirms the speculation (Some info is trimmed).
> 
>      kworker: funcgraph_entry:		    |  drain_vmap_area_work() {
>      kworker: funcgraph_entry:              |   mutex_lock() {
>      kworker: funcgraph_entry:  1.092 us    |     __cond_resched();
>      kworker: funcgraph_exit:   3.306 us    |   }
>      ...				        ...
>      kworker: funcgraph_entry: 		    |    flush_tlb_kernel_range() {
>      ...				 	  ...
>      kworker: funcgraph_exit: # 7533.649 us |    }
>      ...                                         ...
>      kworker: funcgraph_entry:  2.344 us    |   mutex_unlock();
>      kworker: funcgraph_exit: $ 23871554 us | }
> 
>      The drain_vmap_area_work() spends over 23 seconds.
> 
>      There are 2805 flush_tlb_kernel_range() calls in this ftrace log.
>        * One is called in __purge_vmap_area_lazy().
>        * Others are called in kasan_release_vmalloc().
> 
>  3. Extending the soft lockup time can work around the issue (For example,
>     # echo 60 > /proc/sys/kernel/watchdog_thresh). This confirms the
>     above-mentioned speculation: drain_vmap_area_work() spends too much
>     time.
> 
> Commit 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> employs an effective vmap node logic. However, current design iterates
> 128 vmap_nodes and flushes tlb by a single CPU if
> vmap_lazy_nr < 2 * lazy_max_pages(). When enabling kasan, this might
> trigger the soft lockup because additional tlb flushes of kasan vmalloc
> spend much more time if 128 vmap nodes have the available purge list.
> 
> Fix the issue by adding preempt point in purge_vmap_node() when
> enabling kasan.
> 
> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Reviewed-and-tested-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  mm/vmalloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d0cbdd7c1e5b..380bdc317c8d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2193,6 +2193,15 @@ static void purge_vmap_node(struct work_struct *work)
>  	struct vmap_area *va, *n_va;
>  	LIST_HEAD(local_list);
>  
> +	/*
> +	 * Add the preemption point when enabling KASAN. Each vmap_area of
> +	 * vmap nodes has to flush tlb when releasing vmalloc, which might
> +	 * be the time-consuming work if lots of vamp nodes have the
> +	 * available purge list.
> +	 */
> +	if (kasan_enabled())
> +		cond_resched();
> +
>  	vn->nr_purged = 0;
>  
>  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> -- 
> 2.34.1
> 
Thank you for highlighting this. We had a preempt point during purging
process. But it has been removed by the following commit:

<snip>
commit 282631cb2447318e2a55b41a665dbe8571c46d70
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:28 2024 +0100

    mm: vmalloc: remove global purge_vmap_area_root rb-tree
<snip>

and it looks like a decision was wrong. We should restore this.
Could you please test it:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 03b82fb8ecd3..6dc204b8495a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2190,10 +2190,12 @@ static void purge_vmap_node(struct work_struct *work)
 {
 	struct vmap_node *vn = container_of(work,
 		struct vmap_node, purge_work);
+	unsigned long resched_threshold;
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
 	vn->nr_purged = 0;
+	resched_threshold = lazy_max_pages() << 1;
 
 	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
@@ -2210,6 +2212,9 @@ static void purge_vmap_node(struct work_struct *work)
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		vn->nr_purged++;
 
+		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
+			cond_resched();
+
 		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
 			if (node_pool_add_va(vn, va))
 				continue;
<snip>

Thank you in advance!

--
Uladzislau Rezki


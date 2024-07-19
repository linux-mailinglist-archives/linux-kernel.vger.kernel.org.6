Return-Path: <linux-kernel+bounces-257238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D5937735
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2A328134E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A22185931;
	Fri, 19 Jul 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqEkCpBM"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2F1E871
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389227; cv=none; b=R9NLrXa3lxRolpMlcw/xwoc2qhRsS4YCUMxKyQ1lBDLgQq9TTXtX8VaGS5sjLb9p/w2Q1Qkl35vfXN+ufC+FX9O9bozecBxi2yigcqreWCgR0ov3Yy4vb5ca6DCV4GidbjyHvxyk7KzJj+XIJy1jnAlxta1eHmg+43u8S0Tcy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389227; c=relaxed/simple;
	bh=89lTWvaLveT0gvr93j+TT0paAF2UU7nSEFpzgG3+tVM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMam4nETTUVfrhjcm31/dnK0CZXcvj4tjA+faw7ejdR5glWyR03/hjrUq6S7DdlZBHnARFwTVWc/IfyE2sBzAyQ83jQUkQMWjzZR68+0ByjodiiYaF1mQ/5t9OV2lcJ0Es/M6j4SyiKCZbEsJGdyIez/CE6N+I9BP+KbKFzpe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqEkCpBM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so2633972e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721389223; x=1721994023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWGL3RxSq4udT3Nqs0+/yHvDYhzpyGYDeqTroSQKvWY=;
        b=VqEkCpBM0B5YldMgfds75Ne2uxKlKzF8f5E5yUY3+vB4b3l/z8NSLMc4qdf/uupXov
         sw6Shxd+kXdK1RvT4KZpTIGmrClF+xY4JafShKvRHF+cB2T3PRXefxaeQwZ3ANiJJ202
         Wucjb44ex5uYB3XBKTgL1apdqfwRFShPVOthrzaHE6N0oOBu/VxqKU0prfudy0TrbJkA
         FklISKJVRIfVdFDQFEa5bIQSi3QIrcDXsLP+BQ00DTUpDdUJx5cdzIwTgRVXpHshBgcq
         UjJCTvI1/c/ZHoskPF3sr2Y8g/ST3QgKOm8fRvM7A4V+h5Ck9gt2jydOd0OXlhZkzbi8
         kSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721389223; x=1721994023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWGL3RxSq4udT3Nqs0+/yHvDYhzpyGYDeqTroSQKvWY=;
        b=QU8sGqvO3m/ClTcWiT2OOW1yOULyqDCHBF1PEAZIKByK2x2AH7v4pna2el4KlZAZ+z
         FDeQDGwKRb+rpt2pNtbJk0GGkcPu/1oAoXzOJ3dXe2vPhoqcOhvXyI9DRcPuWVUJwunL
         XbHqv9Qarz2Y+/z6K8uqCqDIDpI3zzt2Tj+tUI5dG67eC7YxsP5Ln4lV4E5gwZrtTxPN
         JDUmi1YgP/FpXF+R6oUtPrglRYhGDmS2vN0YVwi19Pm6N0URhPPfpYyy+6plmpTuKCQJ
         876MrfXfKfffDB8zzAoRAg86J0qNuYgn1SM+QpqJmlhTwcpXZOJG58qq10K7OVvghT5m
         EAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVasjekrVVpmxx3497mBKoiZUTjfbv/+Vk/BI041sY02n8gOy/P1Mrz8yPZ/ZOjftLSjyy+xdsFJR928ibZ3M8ciRhAA8xBnnIGPLJB
X-Gm-Message-State: AOJu0YzkKdT3uTcN8ZYmToWfkg/G5ThqSrBJ8jqVTsWkrMpOrTBcNeTu
	ZLFXkwaUR1WkOdfNu94/ScDtJKJo6Lw2LJJEY8vWe5MBLod0tQwS
X-Google-Smtp-Source: AGHT+IFbWxz+q5vCx0cJwZz/HbRLZ1t7Y4HNWMmmj2I/P8Ew8HRzWFHEX0BvEAr5jiiNBxfeIaYqGw==
X-Received: by 2002:a05:6512:6cf:b0:52c:905b:ea5f with SMTP id 2adb3069b0e04-52ee545400amr7351906e87.63.1721389222840;
        Fri, 19 Jul 2024 04:40:22 -0700 (PDT)
Received: from pc636 (host-90-233-210-135.mobileonline.telia.com. [90.233.210.135])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef5577e26sm174543e87.288.2024.07.19.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:40:22 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 19 Jul 2024 13:40:19 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Adrian Huang12 <ahuang12@lenovo.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jiwei JW10 Sun <sunjw10@lenovo.com>
Subject: Re: [External] Re: [PATCH 1/1] mm/vmalloc: Add preempt point in
 purge_vmap_node() when enabling kasan
Message-ID: <ZppQo7Biyg5Yc0Ai@pc636>
References: <20240705130808.1581-1-ahuang12@lenovo.com>
 <ZogS_04dP5LlRlXN@pc636>
 <TYZPR03MB619290520C6552B540870C32B3DA2@TYZPR03MB6192.apcprd03.prod.outlook.com>
 <ZowOnkxaFbqxv6sW@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowOnkxaFbqxv6sW@pc636>

Hello, Peter!

Could you please support here? See below:

> On Mon, Jul 08, 2024 at 01:39:57PM +0000, Adrian Huang12 wrote:
> > Hi,
> > 
> > > Could you please test it:
> > > 
> > > <snip>
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c index 03b82fb8ecd3..6dc204b8495a
> > > 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2190,10 +2190,12 @@ static void purge_vmap_node(struct work_struct
> > > *work)  {
> > >  	struct vmap_node *vn = container_of(work,
> > >  		struct vmap_node, purge_work);
> > > +	unsigned long resched_threshold;
> > >  	struct vmap_area *va, *n_va;
> > >  	LIST_HEAD(local_list);
> > > 
> > >  	vn->nr_purged = 0;
> > > +	resched_threshold = lazy_max_pages() << 1;
> > > 
> > >  	list_for_each_entry_safe(va, n_va, &vn->purge_list, list) {
> > >  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT; @@
> > > -2210,6 +2212,9 @@ static void purge_vmap_node(struct work_struct *work)
> > >  		atomic_long_sub(nr, &vmap_lazy_nr);
> > >  		vn->nr_purged++;
> > > 
> > > +		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
> > > +			cond_resched();
> > > +
> > >  		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
> > >  			if (node_pool_add_va(vn, va))
> > >  				continue;
> > > <snip>
> > 
> > This patch can fix the issue. Feel free to add my tested-by.
> > Tested-by: Adrian Huang <ahuang12@lenovo.com>
> > 
> Thank you. I will add you tested-by!
> 
I tried to simulate the reported splat and i can reproduce it with KASAN
enabled. I use qemu on my 64-core system, it allows me to specify 255
cores while running VM. The kernel is 6.10.0-rc5.

The kernel should be built with CONFIG_KASAN=y and CONFIG_KASAN_VMALLOC=y

The "soft lockup" can be triggered when the kernel is compiled within a
VM using 256 jobs and preemption is disabled:

echo none > /sys/kernel/debug/sched/preempt
make -C coding/linux.git/ -j256 bzImage

<snip>
watchdog: BUG: soft lockup - CPU#28 stuck for 22s! [kworker/28:1:1760]
CPU: 28 PID: 1760 Comm: kworker/28:1 Kdump: loaded Not tainted 6.10.0-rc5 #95
Workqueue: events drain_vmap_area_work
RIP: 0010:smp_call_function_many_cond+0x1d8/0xbb0
...
<snip>

(See the full splat in the beginning of this email-thread). 

After some debugging, i figured out that a CSD lock is taken and not released
for too long. To debug this the kernel should be compiled with CONFIG_CSD_LOCK_WAIT_DEBUG.
The /sys/module/smp/parameters/csd_lock_timeout i set to 1000, i.e. 1 second.

See below the CSD-lock debug-info during running the compiling test:

<snip>
[  163.697057] smp: csd: Detected non-responsive CSD lock (#1) on CPU#206, waiting 1000000292 ns for CPU#17 do_kernel_range_flush+0x0/0xb0(0xffff888dfd943d80).
[  163.697165] smp:     csd: CSD lock (#1) unresponsive.
[  163.697198] Sending NMI from CPU 206 to CPUs 17:
[  163.697214] NMI backtrace for cpu 17
[  163.697223] CPU: 17 PID: 36681 Comm: as Kdump: loaded Tainted: G             L     6.10.0-rc5-00019-g4236f0255ea8-dirty #3439
[  163.697228] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  163.697231] RIP: 0010:native_queued_spin_lock_slowpath+0x2b9/0xae0
[  163.697241] Code: 40 ba 01 00 00 00 ..............<cut>...............
[  163.697244] RSP: 0018:ffffc900396afb98 EFLAGS: 00000002
[  163.697248] RAX: 0000000000000001 RBX: ffffffffb6e0a084 RCX: ffffffffb5eff77c
[  163.697250] RDX: fffffbfff6dc1411 RSI: 0000000000000004 RDI: ffffffffb6e0a084
[  163.697252] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff6dc1410
[  163.697254] R10: ffffffffb6e0a087 R11: ffffffffb80f8112 R12: 1ffff920072d5f75
[  163.697255] R13: 0000000000000007 R14: fffffbfff6dc1410 R15: ffffc900396afbd8
[  163.697260] FS:  0000000000000000(0000) GS:ffff888df7a80000(0000) knlGS:0000000000000000
[  163.697263] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.697266] CR2: 00007f354595c3e8 CR3: 0000000088a44000 CR4: 00000000000006f0
[  163.697268] Call Trace:
[  163.697270]  <NMI>
[  163.697272]  ? nmi_cpu_backtrace+0xd1/0x190
[  163.697277]  ? nmi_cpu_backtrace_handler+0x11/0x20
[  163.697282]  ? nmi_handle+0xb7/0x2a0
[  163.697288]  ? default_do_nmi+0x45/0x110
[  163.697292]  ? exc_nmi+0x104/0x190
[  163.697295]  ? end_repeat_nmi+0xf/0x53
[  163.697299]  ? native_queued_spin_lock_slowpath+0xbc/0xae0
[  163.697303]  ? native_queued_spin_lock_slowpath+0x2b9/0xae0
[  163.697306]  ? native_queued_spin_lock_slowpath+0x2b9/0xae0
[  163.697308]  ? native_queued_spin_lock_slowpath+0x2b9/0xae0
[  163.697311]  </NMI>
[  163.697312]  <TASK>
[  163.697313]  ? __pfx_native_queued_spin_lock_slowpath+0x10/0x10
[  163.697317]  queued_write_lock_slowpath+0x3c6/0x440
[  163.697321]  ? __pfx_queued_write_lock_slowpath+0x10/0x10
[  163.697324]  ? task_rq_lock+0xd0/0x390
[  163.697327]  ? perf_lock_task_context+0x106/0x310
[  163.697333]  _raw_write_lock_irq+0xcf/0xe0
[  163.697335]  ? __pfx__raw_write_lock_irq+0x10/0x10
[  163.697339]  exit_notify+0x86/0x780
[  163.697342]  ? __pfx_exit_notify+0x10/0x10
[  163.697345]  ? exit_tasks_rcu_start+0x173/0x230
[  163.697350]  do_exit+0x707/0xcb0
[  163.697352]  ? __count_memcg_events+0xe1/0x340
[  163.697357]  ? __pfx_do_exit+0x10/0x10
[  163.697359]  ? _raw_spin_lock_irq+0x86/0xe0
[  163.697361]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  163.697364]  ? handle_mm_fault+0x150/0x740
[  163.697368]  do_group_exit+0xac/0x230
[  163.697371]  __x64_sys_exit_group+0x3e/0x50
[  163.697374]  do_syscall_64+0x5f/0x170
[  163.697377]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  163.697381] RIP: 0033:0x7f35457aa349
[  163.697384] Code: Unable to access opcode bytes at 0x7f35457aa31f.
[  163.697385] RSP: 002b:00007ffce767e198 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  163.697388] RAX: ffffffffffffffda RBX: 00007f35458a49e0 RCX: 00007f35457aa349
[  163.697390] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  163.697392] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 00007ffce767e0af
[  163.697394] R10: 00007ffce767e010 R11: 0000000000000246 R12: 00007f35458a49e0
[  163.697395] R13: 00007f35458aa2e0 R14: 0000000000000001 R15: 00007f35458aa2c8
[  163.697399]  </TASK>
<snip>

i see that CPU_17 does not respond waiting in the do_exit() trying to grab
a writing lock. Below one:

<snip>
static void exit_notify(struct task_struct *tsk, int group_dead)
{
	bool autoreap;
	struct task_struct *p, *n;
	LIST_HEAD(dead);

	write_lock_irq(&tasklist_lock);
...
<snip>

As i see it disables interrupts and tries to acquire the rw-lock. In
order to debug this further i built the kernel with CONFIG_LOCK_STAT
to see the contention and waiting time on it:

echo 0 > /proc/lock_stat; echo 1 > /proc/sys/kernel/lock_stat; make -C coding/linux.git/ -j256 bzImage > /dev/null; echo 0 > /proc/sys/kernel/lock_stat;

<snip>
...
class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
...
tasklist_lock-W:         56291          56830           0.23     3352084.59  3191025005.50       56150.36          86555         110489           0.60       65916.78    50226089.66         454.58
tasklist_lock-R:         40925          40987           0.23     3450788.93  2149685495.54       52447.98          73248          88581           0.09       32061.59      237549.19           2.68
     ---------------
     tasklist_lock          21879          [<000000004337def3>] exit_notify+0x86/0x790
     tasklist_lock          40987          [<000000008c6daba0>] __do_wait+0xdc/0x700
     tasklist_lock          17632          [<00000000c86b4505>] release_task+0x106/0x470
     tasklist_lock          17319          [<000000004c9a1afc>] copy_process+0x2a1b/0x4b00
     ---------------
     tasklist_lock          73231          [<000000004337def3>] exit_notify+0x86/0x790
     tasklist_lock          15082          [<00000000c86b4505>] release_task+0x106/0x470
     tasklist_lock           4233          [<000000004c9a1afc>] copy_process+0x2a1b/0x4b00
     tasklist_lock           5271          [<000000008c6daba0>] __do_wait+0xdc/0x700
...
<snip>

A waiting time can be quite long on a kernel built with KASAN. If i
interpret it correctly, the time is in microseconds, so we have 3.3
seconds as a maximum waiting time on the "tasklist_lock.

Since it disables interrupts on a current CPU, do_kernel_range_flush()
on that CPU is delayed thus it delays kworker which does TLB flushing.

Could you please comment on it? Maybe you can give some good input about
long wait on the tasklist_lock(it disables IRQs also) when KASAN is enabled.

Is that something which is expectable for debug kernel?

Thank you in advance!

--
Uladzislau Rezki


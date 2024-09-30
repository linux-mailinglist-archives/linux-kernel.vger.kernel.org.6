Return-Path: <linux-kernel+bounces-344677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339298AC9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14431F220A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E1F19993A;
	Mon, 30 Sep 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="arL/G0cV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274615E97
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723738; cv=none; b=CW2pUohgiaC5n/lgS/gaC/Q0W7F6fg5vIb1t95NOBbxAO/Eko4+XDPQdHLoVqVeKW3sBWIr9oUtCRJb4xX6PlatlsgssyeKL8H/QNLa0Z9YcqaeCOA5j2vrz9CnEo5QbQv0fwLCHfeNpbkxSSQD8dwBjqzF9c/9odtu1K1BTNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723738; c=relaxed/simple;
	bh=KvxOlPIcODPbX0hHNdTwg4Ur/oXI+diPyTxMwxFTomg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvJnwAch3tCiVRhiWXAQ4+2B93IWRcRvAuGakGLCYZoSgjwHXHMKOTrAK6RU27aUzUi5Ys7CfjjrTxh7767v8eeuWMtFJ0yJ2xAo+/77qoIzkO1IrXL5Zpg53wzJfZYuABTedYFDapMVdLoHvvhuY7mJPdMw2jg1rc620B4l83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=arL/G0cV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHX3Mu013463;
	Mon, 30 Sep 2024 19:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=quW7boLT1MDajoS0m4vH2MESBI0
	NGL0W6aU/9NpqT1E=; b=arL/G0cVIHPEHPDYH0gQw1OYxWSaUs00ezqYGDqBvB0
	IjV35d0yTevlHtCjBb6DS8gltwHSziseyBtx3YMlb2qzTxbQfXdf1N5ffNB9o2pG
	b1pt2XKGp4/IlHzR4hnEBUdT+g6nSJDDQE1xSffyzaZ//TghKggmbx9/1REQLcHv
	sFVpAaDWd1Azig3oiF85tLkpxrBOQsUiZQuBi4SgXk7krCIA8CVWqUM7eobHcBzP
	s+gucG7JY9eUasHym/Jk//0D9bRuoN/LKxcb5Xzx53TTMvO7K43Q9Zx1YdWiy8YZ
	zGl5dK0PiPwsQ+Y4yMBo7Ntj3uKcj2gDypb9qu7vNmQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb3r0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:15:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UJFNfX022319;
	Mon, 30 Sep 2024 19:15:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb3r05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:15:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHt306017905;
	Mon, 30 Sep 2024 19:15:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mr9nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:15:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UJFJcl55902504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 19:15:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA92E20040;
	Mon, 30 Sep 2024 19:15:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 477E92004F;
	Mon, 30 Sep 2024 19:15:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.31.120])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 19:15:17 +0000 (GMT)
Date: Tue, 1 Oct 2024 00:45:12 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
 <Zvr2bLBEYyu1gtNz@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvr2bLBEYyu1gtNz@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hzabUrdHXGqmy-ZY04l_A97M4xvZSmyj
X-Proofpoint-ORIG-GUID: fWTlDpwU8aa6sPz1xsR8tjSkdA9Rsegt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300138

On Tue, Oct 01, 2024 at 12:35:16AM +0530, Vishal Chourasia wrote:
> On Mon, Sep 30, 2024 at 04:41:57PM +0200, Peter Zijlstra wrote:
> > On Thu, Sep 26, 2024 at 06:12:19PM +0530, Vishal Chourasia wrote:
> > > I've noticed a kernel panic consistently occurring on the mainline v6.11
> > > kernel (see attached dmesg log below). 
> > > 
> > > The panic occurs almost every time I build the Linux kernel from source.
> > > 
> > > Steps to Reproduce:
> > > 
> > > make clean
> > > ./scripts/config -e LOCALVERSION_AUTO
> > > ./scripts/config --set-str LOCALVERSION -master-with-print
> > > make localmodconfig
> > > make -j8 -s vmlinux modules
> > > 
> > > >From my investigation, it seems that the function pick_eevdf() can return NULL.
> > > Commit f12e1488 ("sched/fair: Prepare pick_next_task() for delayed dequeue") 
> > > introduces an access on the return value of pick_eevdf(). If 'se' was NULL, 
> > > it can lead to a null pointer dereference. 
> > 
> > Even before that commit we relied on that thing not being NULL, notably
> > f12e1488^1 has:
> > 
> >                 se = pick_next_entity(cfs_rq);
> >                 cfs_rq = group_cfs_rq(se);
> > 
> > Which will similarly explode when pick_eevdf() goes wobbly.
> > 
> > > To determine why pick_eevdf() would return NULL, I added a few printk statements
> > > Based on one of the printk logs in the shared dmesg log, it appears that if
> > > pick_eevdf() is called for a 'cfs_rq' whose 'cfs_rq->curr' is NULL and there
> > > are no eligible entities on that 'cfs_rq', it will return NULL. 
> > 
> > Right, that is not a valid state. Which seems to suggest something went
> > sideways with the eligibility thing -- as Luis suggested.
> > 
> > > I have not been able to think of a quick reproducer to trigger a panic
> > > for this case. Hoping if someone can guide me on this.
> > > 
> > > Note: The following dmesg log also contains a warning reported too. Panic
> > > happens later.
> > > 
> > > ------------[ cut here ]------------
> > > !se->on_rq
> > > WARNING: CPU: 1 PID: 92333 at kernel/sched/fair.c:705 update_entity_lag+0xcc/0xf0
> > > Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
> > > CPU: 1 UID: 0 PID: 92333 Comm: genksyms Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
> > > Tainted: [W]=WARN
> > > Hardware name: IBM,9080-HEX POWER10 (architected) hv:phyp pSeries
> > > NIP:  c0000000001cdfcc LR: c0000000001cdfc8 CTR: 0000000000000000
> > > REGS: c00000005c62ee50 TRAP: 0700   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> > > MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 00000005
> > > CFAR: c000000000156a10 IRQMASK: 1
> > > GPR00: c0000000001cdfc8 c00000005c62f0f0 c000000001b57400 000000000000000a
> > > GPR04: 00000000ffff7fff c00000005c62eee0 c00000005c62eed8 00000007fb050000
> > > GPR08: 0000000000000027 0000000000000000 0000000000000000 c000000002758de0
> > > GPR12: c000000002a18d88 c0000007fffef480 0000000000000000 0000000000000000
> > > GPR16: c000000002c56d40 0000000000000000 c00000005c62f5b4 0000000000000000
> > > GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c000000003cd7300
> > > GPR24: 0000000000000000 0000000000000008 c0000007fd1d3f80 0000000000000000
> > > GPR28: 0000000000000001 0000000000000009 c0000007fd1d4080 c0000000656a0000
> > > NIP [c0000000001cdfcc] update_entity_lag+0xcc/0xf0
> > > LR [c0000000001cdfc8] update_entity_lag+0xc8/0xf0
> > > Call Trace:
> > > [c00000005c62f0f0] [c0000000001cdfc8] update_entity_lag+0xc8/0xf0 (unreliable)
> > > [c00000005c62f160] [c0000000001cea80] dequeue_entity+0xb0/0x6d0
> > > [c00000005c62f1f0] [c0000000001cf8b0] dequeue_entities+0x150/0x600
> > > [c00000005c62f2c0] [c0000000001d02a8] dequeue_task_fair+0x158/0x2e0
> > > [c00000005c62f300] [c0000000001b5ea4] dequeue_task+0x64/0x200
> > > [c00000005c62f380] [c0000000001cc950] detach_tasks+0x140/0x420
> > > [c00000005c62f3f0] [c0000000001d6044] sched_balance_rq+0x214/0x7c0
> > > [c00000005c62f550] [c0000000001d6830] sched_balance_newidle+0x240/0x630
> > > [c00000005c62f640] [c0000000001d6d0c] pick_next_task_fair+0x7c/0x4a0
> > > [c00000005c62f6d0] [c0000000001afc50] __pick_next_task+0x60/0x2d0
> > > [c00000005c62f730] [c0000000010e8ce8] __schedule+0x198/0x840
> > > [c00000005c62f810] [c0000000010e93d0] schedule+0x40/0x110
> > > [c00000005c62f880] [c00000000064c574] pipe_read+0x424/0x6a0
> > > [c00000005c62f960] [c00000000063a0fc] vfs_read+0x30c/0x3d0
> > > [c00000005c62fa10] [c00000000063adf4] ksys_read+0x104/0x160
> > > [c00000005c62fa60] [c000000000031678] system_call_exception+0x138/0x2d0
> > > [c00000005c62fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
> > 
> > So that is a 'fun' one, I don't remember seeing that before. It says
> > we're trying to dequeue a task that is not on the runqueue.
> > 
> > The big new thing this merge window -- I'm assuming v6.11 is good -- is
> > DEQUEUE_DELAYED. Does this error go away if you flip that in
> > kernel/sched/features.h ?
> Yes, with the below diff. I didn't see any warnings or kernel panic
> while running the workload
> 
> # git diff
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 290874079f60..38bf8df813d1 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -46,7 +46,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
>   *
>   * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
>   */
> -SCHED_FEAT(DELAY_DEQUEUE, true)
> +SCHED_FEAT(DELAY_DEQUEUE, false)
>  SCHED_FEAT(DELAY_ZERO, true)
> 
>  /*
> 
> 
for sanity, I ran the workload (kernel compilation) on the base commit
where the kernel panic was initially observed, which resulted in a
kernel panic, along with it couple of warnings where also printed on the
console, and a circular locking dependency warning with it.

Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le

------------[ cut here ]------------

======================================================
WARNING: possible circular locking dependency detected
6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
------------------------------------------------------
cc1/27867 is trying to acquire lock:
c000000002950270 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x2c/0x70

but task is already holding lock:
c0000007fb0e6218 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x44/0x130

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->__lock){-.-.}-{2:2}:
       __lock_acquire+0x730/0xf00
       lock_acquire.part.0+0xf0/0x2a0
       _raw_spin_lock_nested+0x64/0x100
       raw_spin_rq_lock_nested+0x44/0x130
       __task_rq_lock+0x7c/0x1e0
       wake_up_new_task+0x1d0/0x560
       kernel_clone+0x1e0/0x5c0
       user_mode_thread+0x84/0xc0
       rest_init+0x40/0x208
       do_initcalls+0x0/0x190
       start_here_common+0x1c/0x20

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __lock_acquire+0x730/0xf00
       lock_acquire.part.0+0xf0/0x2a0
       _raw_spin_lock_irqsave+0x7c/0x130
       try_to_wake_up+0x70/0xa40
       __up.isra.0+0x74/0x90
       up+0x7c/0xa0
       __up_console_sem+0xb8/0x110
       console_unlock+0x140/0x220
       vprintk_emit+0x1e4/0x300
       devkmsg_emit.constprop.0+0x44/0x54
       devkmsg_write+0x11c/0x230
       do_iter_readv_writev+0x194/0x280
       vfs_writev+0x18c/0x4b0
       do_writev+0xa8/0x1f0
       system_call_exception+0x148/0x310
       system_call_vectored_common+0x15c/0x2ec

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add+0x158/0xe70
       validate_chain+0x6b4/0x7e0
       __lock_acquire+0x730/0xf00
       lock_acquire.part.0+0xf0/0x2a0
       _raw_spin_lock_irqsave+0x7c/0x130
       down_trylock+0x2c/0x70
       __down_trylock_console_sem+0x60/0x170
       console_trylock_spinning+0x3c/0x300
       vprintk_emit+0x1a4/0x300
       vprintk+0x58/0xe0
       _printk+0x40/0x54
       __warn_printk+0xd8/0x120
       unthrottle_cfs_rq+0x640/0x660
       distribute_cfs_runtime+0x454/0x8e0
       sched_cfs_period_timer+0x130/0x310
       __run_hrtimer+0x28c/0x4d0
       __hrtimer_run_queues+0xb4/0x140
       hrtimer_interrupt+0x124/0x2f0
       timer_interrupt+0x15c/0x460
       decrementer_common_virt+0x28c/0x290

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

2 locks held by cc1/27867:
 #0: c000000002cd1670 (rcu_read_lock){....}-{1:3}, at: distribute_cfs_runtime+0x10/0x8e0
 #1: c0000007fb0e6218 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x44/0x130

stack backtrace:
CPU: 1 UID: 0 PID: 27867 Comm: cc1 Not tainted 6.11.0-kp-base-10547-g684a64bf32b6 #69
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
Call Trace:
[c0000000f994f210] [c00000000126f0a4] dump_stack_lvl+0xc8/0x130 (unreliable)
[c0000000f994f250] [c00000000024de78] print_circular_bug+0x248/0x2b0
[c0000000f994f2f0] [c00000000024e154] check_noncircular+0x274/0x2a0
[c0000000f994f3c0] [c00000000024f8d8] check_prev_add+0x158/0xe70
[c0000000f994f470] [c000000000250ca4] validate_chain+0x6b4/0x7e0
[c0000000f994f550] [c0000000002542a0] __lock_acquire+0x730/0xf00
[c0000000f994f660] [c000000000254b60] lock_acquire.part.0+0xf0/0x2a0
[c0000000f994f780] [c0000000012bcb2c] _raw_spin_lock_irqsave+0x7c/0x130
[c0000000f994f7c0] [c0000000012b422c] down_trylock+0x2c/0x70
[c0000000f994f7f0] [c000000000267920] __down_trylock_console_sem+0x60/0x170
[c0000000f994f830] [c0000000002698cc] console_trylock_spinning+0x3c/0x300
[c0000000f994f880] [c00000000026ccf4] vprintk_emit+0x1a4/0x300
[c0000000f994f8f0] [c00000000026f318] vprintk+0x58/0xe0
[c0000000f994f920] [c00000000026ee30] _printk+0x40/0x54
[c0000000f994f940] [c000000000160ac8] __warn_printk+0xd8/0x120
[c0000000f994f9b0] [c0000000001f07c0] unthrottle_cfs_rq+0x640/0x660
[c0000000f994fa50] [c0000000001f1314] distribute_cfs_runtime+0x454/0x8e0
[c0000000f994fb60] [c0000000001f1a40] sched_cfs_period_timer+0x130/0x310
[c0000000f994fc00] [c0000000002db5dc] __run_hrtimer+0x28c/0x4d0
[c0000000f994fca0] [c0000000002db8d4] __hrtimer_run_queues+0xb4/0x140
[c0000000f994fd00] [c0000000002dc834] hrtimer_interrupt+0x124/0x2f0
[c0000000f994fdb0] [c000000000029f1c] timer_interrupt+0x15c/0x460
[c0000000f994fe50] [c000000000009f8c] decrementer_common_virt+0x28c/0x290
--- interrupt: 900 at 0x13b4b0108
NIP:  000000013b4b0108 LR: 000000013b4af88c CTR: 000000013b4b00d0
REGS: c0000000f994fe80 TRAP: 0900   Not tainted  (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 88822804  XER: 20040000
CFAR: 0000000000000000 IRQMASK: 0
GPR00: 000000013b4af88c 00007ffff4260530 000000013c9f7a00 00007fff93a70738
GPR04: 00007fff94866708 0000000000000000 0000000000000000 00007fff93a70738
GPR08: 0000000000000008 0000000000000008 0000000000000000 0000000088822804
GPR12: 000000013b4b00d0 00007fff9645cc80 00007fff94c44ad8 0000000000000000
GPR16: 0000000040000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 000000013c948900 000000013c50e818
GPR24: 00007fff94c44ad8 0000000000000000 0000000000000001 000000013ca33ec0
GPR28: 000000013c322130 00007fff94c23408 00007fff93a70738 00007fff94866708
NIP [000000013b4b0108] 0x13b4b0108
LR [000000013b4af88c] 0x13b4af88c
--- interrupt: 900
se->sched_delayed
WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+0x644/0x660
Modules linked in: binfmt_misc bonding tls rfkill pseries_rng ibmveth nd_pmem vmx_crypto nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 1 UID: 0 PID: 27867 Comm: cc1 Not tainted 6.11.0-kp-base-10547-g684a64bf32b6 #69
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
NIP:  c0000000001f07c4 LR: c0000000001f07c0 CTR: 0000000000000000
REGS: c0000000f994f710 TRAP: 0700   Not tainted  (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 24822202  XER: 00000003
CFAR: c000000000160b00 IRQMASK: 3
GPR00: c0000000001f07c0 c0000000f994f9b0 c000000001d57400 0000000000000011
GPR04: 00000000ffff7fff c0000000f994f7b0 c0000000f994f7a8 00000007f8cf0000
GPR08: 0000000000000027 0000000000010002 c00000005bd32000 c000000002950510
GPR12: c000000002c104b8 c0000007fffef480 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000001 0000000000000001 c000000002dd4928 c000000002cd1670
GPR24: 0000000000000000 0000000000000001 0000000000000001 c0000007fb0e6200
GPR28: 0000000000000000 c00000015326d800 c0000007fb0e6380 c0000000572f2400
NIP [c0000000001f07c4] unthrottle_cfs_rq+0x644/0x660
LR [c0000000001f07c0] unthrottle_cfs_rq+0x640/0x660
Call Trace:
[c0000000f994f9b0] [c0000000001f07c0] unthrottle_cfs_rq+0x640/0x660 (unreliable)
[c0000000f994fa50] [c0000000001f1314] distribute_cfs_runtime+0x454/0x8e0
[c0000000f994fb60] [c0000000001f1a40] sched_cfs_period_timer+0x130/0x310
[c0000000f994fc00] [c0000000002db5dc] __run_hrtimer+0x28c/0x4d0
[c0000000f994fca0] [c0000000002db8d4] __hrtimer_run_queues+0xb4/0x140
[c0000000f994fd00] [c0000000002dc834] hrtimer_interrupt+0x124/0x2f0
[c0000000f994fdb0] [c000000000029f1c] timer_interrupt+0x15c/0x460
[c0000000f994fe50] [c000000000009f8c] decrementer_common_virt+0x28c/0x290
--- interrupt: 900 at 0x13b4b0108
NIP:  000000013b4b0108 LR: 000000013b4af88c CTR: 000000013b4b00d0
REGS: c0000000f994fe80 TRAP: 0900   Not tainted  (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 88822804  XER: 20040000
CFAR: 0000000000000000 IRQMASK: 0
GPR00: 000000013b4af88c 00007ffff4260530 000000013c9f7a00 00007fff93a70738
GPR04: 00007fff94866708 0000000000000000 0000000000000000 00007fff93a70738
GPR08: 0000000000000008 0000000000000008 0000000000000000 0000000088822804
GPR12: 000000013b4b00d0 00007fff9645cc80 00007fff94c44ad8 0000000000000000
GPR16: 0000000040000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 000000013c948900 000000013c50e818
GPR24: 00007fff94c44ad8 0000000000000000 0000000000000001 000000013ca33ec0
GPR28: 000000013c322130 00007fff94c23408 00007fff93a70738 00007fff94866708
NIP [000000013b4b0108] 0x13b4b0108
LR [000000013b4af88c] 0x13b4af88c
--- interrupt: 900
Code: 4bfffc40 3d220108 8929d54b 2c090000 4082fccc 3c62ff97 39200001 3d420108 38634718 992ad54b 4bf7023d 60000000 <0fe00000> 4bfffca8 eb010060 4bfffb80
irq event stamp: 42054
hardirqs last  enabled at (42053): [<c0000000000318ac>] interrupt_exit_user_prepare_main+0x7c/0x290
hardirqs last disabled at (42054): [<c000000000029c70>] interrupt_enter_prepare+0x90/0x1e0
softirqs last  enabled at (41856): [<c000000000170710>] handle_softirqs+0x590/0x5f0
softirqs last disabled at (41851): [<c0000000000186e0>] do_softirq_own_stack+0x40/0x60
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
delay && se->sched_delayed
WARNING: CPU: 7 PID: 869 at kernel/sched/fair.c:5493 dequeue_entity+0x598/0x6c0
Modules linked in: binfmt_misc bonding tls rfkill pseries_rng ibmveth nd_pmem vmx_crypto nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 7 UID: 0 PID: 869 Comm: auditd Tainted: G        W          6.11.0-kp-base-10547-g684a64bf32b6 #69
Tainted: [W]=WARN
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
NIP:  c0000000001edae8 LR: c0000000001edae4 CTR: 0000000000000000
REGS: c000000007d76c20 TRAP: 0700   Tainted: G        W           (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002202  XER: 00000005
CFAR: c000000000160b00 IRQMASK: 1
GPR00: c0000000001edae4 c000000007d76ec0 c000000001d57400 000000000000001a
GPR04: 00000000ffff7fff c000000007d76cc0 c000000007d76cb8 00000007f9bf0000
GPR08: 0000000000000027 0000000000000003 c00000005d18f000 c000000002950510
GPR12: c000000002c104b8 c0000007fffe7080 0000000000000000 c000000004088600
GPR16: 0000000000000000 0000000000000007 0000000000000002 0000000000000000
GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c00000000a234800
GPR24: 0000000000000000 0000000000000008 c0000007fb0e6200 0000000000000000
GPR28: 0000000000000001 0000000000000009 c0000007fb0e6380 c0000000572f2400
NIP [c0000000001edae8] dequeue_entity+0x598/0x6c0
LR [c0000000001edae4] dequeue_entity+0x594/0x6c0
Call Trace:
[c000000007d76ec0] [c0000000001edae4] dequeue_entity+0x594/0x6c0 (unreliable)
[c000000007d76f60] [c0000000001edd60] dequeue_entities+0x150/0x600
[c000000007d77030] [c0000000001ee54c] dequeue_task_fair+0x6c/0x310
[c000000007d770c0] [c0000000001cda54] dequeue_task+0x64/0x240
[c000000007d77140] [c0000000001e6e80] detach_tasks+0x1c0/0x4d0
[c000000007d771b0] [c0000000001f52e0] sched_balance_rq+0x250/0x910
[c000000007d77320] [c0000000001f5d50] sched_balance_newidle+0x3b0/0xa90
[c000000007d77410] [c0000000001f651c] pick_next_task_fair+0x7c/0x560
[c000000007d774a0] [c0000000001c3fa0] __pick_next_task+0x60/0x2d0
[c000000007d77500] [c0000000012ae314] __schedule+0x184/0x940
[c000000007d775d0] [c0000000012aeb3c] schedule+0x6c/0x190
[c000000007d77640] [c0000000012aeed4] schedule_preempt_disabled+0x34/0x60
[c000000007d77670] [c0000000012b4de4] rwsem_down_write_slowpath+0x234/0x820
[c000000007d77770] [c00000000024584c] down_write_nested+0x1ec/0x1f0
[c000000007d777b0] [c008000004d65688] xfs_ilock+0x1c0/0x240 [xfs]
[c000000007d77830] [c008000004d60e4c] xfs_buffered_write_iomap_begin+0x184/0xd50 [xfs]
[c000000007d77990] [c0000000007da1a8] iomap_iter+0x118/0x270
[c000000007d77a20] [c0000000007dd63c] iomap_file_buffered_write+0xbc/0x120
[c000000007d77b40] [c008000004d4994c] xfs_file_buffered_write+0xf4/0x3e0 [xfs]
[c000000007d77c10] [c0000000006fa450] new_sync_write+0x160/0x1e0
[c000000007d77ca0] [c0000000006fe524] vfs_write+0x2f4/0x3e0
[c000000007d77d00] [c0000000006fe820] ksys_write+0x90/0x160
[c000000007d77d50] [c000000000032f98] system_call_exception+0x148/0x310
[c000000007d77e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
--- interrupt: 3000 at 0x7fff8894b344
NIP:  00007fff8894b344 LR: 00007fff8894b344 CTR: 0000000000000000
REGS: c000000007d77e80 TRAP: 3000   Tainted: G        W           (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 4a004402  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000004 00007ffff84de490 00007fff88a67100 0000000000000004
GPR04: 0000000122fe9090 0000000000000041 0100000000000000 00007fff88db0180
GPR08: 00007fff88da8ac8 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fff88db0180 0000000000000001 000000011de63d40
GPR16: 00007ffff84e0f00 00007ffff84e0ed0 00007ffff84e0ea0 00007ffff84e0f30
GPR20: 00007ffff84e0e40 00007ffff84e0f60 0000000000000000 00007ffff84e0ff0
GPR24: 0000000000000000 00007ffff84e1118 00007ffff84de828 0000000122fe9090
GPR28: 0000000000000041 0000000122fe9090 0000000000000000 0000000000000004
NIP [00007fff8894b344] 0x7fff8894b344
LR [00007fff8894b344] 0x7fff8894b344
--- interrupt: 3000
Code: 4bff5571 39200001 38600000 993f0051 4bfffc10 3c62ff97 39200001 3d420108 38634818 992ad541 4bf72f19 60000000 <0fe00000> 60000000 4bfffe18 60000000
irq event stamp: 64870392
hardirqs last  enabled at (64870391): [<c000000000031a34>] interrupt_exit_user_prepare_main+0x204/0x290
hardirqs last disabled at (64870392): [<c0000000012ae55c>] __schedule+0x3cc/0x940
softirqs last  enabled at (64867724): [<c000000000170710>] handle_softirqs+0x590/0x5f0
softirqs last disabled at (64867713): [<c0000000000186e0>] do_softirq_own_stack+0x40/0x60
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
!se->on_rq
WARNING: CPU: 0 PID: 870 at kernel/sched/fair.c:704 update_entity_lag+0xcc/0xf0
Modules linked in: binfmt_misc bonding tls rfkill pseries_rng ibmveth nd_pmem vmx_crypto nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 0 UID: 0 PID: 870 Comm: auditd Tainted: G        W          6.11.0-kp-base-10547-g684a64bf32b6 #69
Tainted: [W]=WARN
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
NIP:  c0000000001eacdc LR: c0000000001eacd8 CTR: 0000000000000000
REGS: c00000005a89ebd0 TRAP: 0700   Tainted: G        W           (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24282282  XER: 00000005
CFAR: c000000000160b00 IRQMASK: 1
GPR00: c0000000001eacd8 c00000005a89ee70 c000000001d57400 000000000000000a
GPR04: 00000000ffff7fff c00000005a89ec70 c00000005a89ec68 00000007f8a70000
GPR08: 0000000000000027 0000000000000003 c00000005308f000 c000000002950510
GPR12: c000000002c104b8 c000000003cd0000 0000000000000000 c000000004087800
GPR16: c00000005308f000 0000000000000000 0000000000000002 0000000000000000
GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c00000000a20a000
GPR24: 0000000000000000 0000000000000008 c0000007fb866200 0000000000000000
GPR28: 0000000000000001 0000000000000009 c0000007fb866380 c0000000572ff400
NIP [c0000000001eacdc] update_entity_lag+0xcc/0xf0
LR [c0000000001eacd8] update_entity_lag+0xc8/0xf0
Call Trace:
[c00000005a89ee70] [c0000000001eacd8] update_entity_lag+0xc8/0xf0 (unreliable)
[c00000005a89eee0] [c0000000001ed600] dequeue_entity+0xb0/0x6c0
[c00000005a89ef80] [c0000000001edd60] dequeue_entities+0x150/0x600
[c00000005a89f050] [c0000000001ee54c] dequeue_task_fair+0x6c/0x310
[c00000005a89f0e0] [c0000000001cda54] dequeue_task+0x64/0x240
[c00000005a89f160] [c0000000001e6e80] detach_tasks+0x1c0/0x4d0
[c00000005a89f1d0] [c0000000001f52e0] sched_balance_rq+0x250/0x910
[c00000005a89f340] [c0000000001f5d50] sched_balance_newidle+0x3b0/0xa90
[c00000005a89f430] [c0000000001f651c] pick_next_task_fair+0x7c/0x560
[c00000005a89f4c0] [c0000000001c3fa0] __pick_next_task+0x60/0x2d0
[c00000005a89f520] [c0000000012ae314] __schedule+0x184/0x940
[c00000005a89f5f0] [c0000000012aeb3c] schedule+0x6c/0x190
[c00000005a89f660] [c0000000012aecb4] io_schedule+0x54/0x80
[c00000005a89f690] [c0000000005489b4] folio_wait_bit_common+0x1e4/0x4c0
[c00000005a89f790] [c00000000055d01c] folio_wait_writeback+0x5c/0x150
[c00000005a89f810] [c00000000054811c] __filemap_fdatawait_range+0xcc/0x1c0
[c00000005a89f970] [c00000000054da90] file_write_and_wait_range+0xf0/0x110
[c00000005a89f9c0] [c008000004d475d4] xfs_file_fsync+0x9c/0x380 [xfs]
[c00000005a89fa80] [c000000000774eec] vfs_fsync_range+0x6c/0xf0
[c00000005a89fac0] [c00000000077503c] do_fsync+0x5c/0xd0
[c00000005a89fb00] [c0000000007754c8] sys_fsync+0x28/0x40
[c00000005a89fb20] [c000000000032f98] system_call_exception+0x148/0x310
[c00000005a89fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
--- interrupt: 3000 at 0x7fff8894f6e4
NIP:  00007fff8894f6e4 LR: 00007fff8894f6e4 CTR: 0000000000000000
REGS: c00000005a89fe80 TRAP: 3000   Tainted: G        W           (6.11.0-kp-base-10547-g684a64bf32b6)
MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 42004482  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000076 00007fff87c0e400 00007fff88a67100 0000000000000004
GPR04: 0000000000000081 0000000000000001 0000000000000000 00007fff87c16780
GPR08: 00007fff87c0f0c8 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fff87c16780 0000000000000000 0000000000000000
GPR16: 00007fff87c0f080 00007fff87400000 00007fff87c0efc0 0000000000000000
GPR20: 0000000000000000 00007fff88da0000 000000000080e880 00007fff87400000
GPR24: 0000000000000001 0000000000000000 0000000000000002 00007fff87c0e798
GPR28: 00007fff87c0f3dc 000000011de80d58 0000000000000000 0000000000000004
NIP [00007fff8894f6e4] 0x7fff8894f6e4
LR [00007fff8894f6e4] 0x7fff8894f6e4
--- interrupt: 3000
Code: 4e800020 3d220108 8929d53d 2c090000 4082ff8c 3c62ff97 39200001 3d420108 38634708 992ad53d 4bf75d25 60000000 <0fe00000> 4bffff68 60000000 60000000
irq event stamp: 11088690
hardirqs last  enabled at (11088689): [<c000000000973e74>] blk_account_io_start+0x204/0x260
hardirqs last disabled at (11088690): [<c0000000012bca54>] _raw_spin_lock_irq+0xc4/0x120
softirqs last  enabled at (11087028): [<c000000000170710>] handle_softirqs+0x590/0x5f0
softirqs last disabled at (11087021): [<c0000000000186e0>] do_softirq_own_stack+0x40/0x60
---[ end trace 0000000000000000 ]---

Thanks


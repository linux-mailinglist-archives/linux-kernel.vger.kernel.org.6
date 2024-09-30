Return-Path: <linux-kernel+bounces-344246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725398A76F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AABB1C21F46
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B81922E6;
	Mon, 30 Sep 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xw/JIss8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1A1922DD
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707328; cv=none; b=sCm9HycGry6WANhW+GCNQlAEV7GufPzA3fHodXMntRwn5RYg7jp0LAUo9VmkLx64vWbKjoLkA71daSP+GMu10s0ScRy2L1RkXoEi09xOJdhfiFJEptKhGaHEp3akHc2j16+G+SxzrOO23PJ0GHL1f6zmp76ktZ0noNCupk3AJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707328; c=relaxed/simple;
	bh=C6qQpKHqkBHqhVNimdI3mkVVreeAsBDj05gA85DEJ5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsfPzKh9Rp1tQAc/UUIKGRkifGM4qlaUjzRnLOYDmdeWWyAFH8OWQplk+RjsA2ou3wsPUwBg8uYYjhIqG3NTBxmGPj7oTBTZSZ4UWx7LNNqR/tY1/4neGaOHHATMWWRMkP5eL1/k/lWi0kGYGgVdkjRWLqnwULCwji8vlA+psGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xw/JIss8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KuE8A00LoVkrG3A2icrXP5PbveqUuXX8E9dCmAMheSA=; b=Xw/JIss80m9IEXb+mklZ/5a1sL
	Z6PWfIUF1WxQFtaR/1QuBRZuO8rc3Bv8Uhz2TG/rTGDYJl9T5y2sXiMdLBvFGp2CpDP9I8T7WHPbX
	JgTvhZ+u+H0fYA1PfBFo/x2DW2l4pwq6kZ5XrFCvtlKN1/vOOY46v+AErH1fIzV1QNZqAXWGXHeKG
	c+7jFLuqB7ZLGqWX2WrwgPtgdYXgg9NOnnQwIpHWeRVHTjisaqJ7MuVat108D5uBOKvDyT9tXH5ya
	6xFWFqP4tjaTGgirf5o5XJsiuEofSoQE218+cbXMsVzU/P9znDEjXKmUrCZ1vm9DG0/jy5B931Zx3
	1JDY2C4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svHb4-00000002qQY-0cG4;
	Mon, 30 Sep 2024 14:41:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29521300754; Mon, 30 Sep 2024 16:41:57 +0200 (CEST)
Date: Mon, 30 Sep 2024 16:41:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <20240930144157.GH5594@noisy.programming.kicks-ass.net>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvVWq3WM6zVza_mD@linux.ibm.com>

On Thu, Sep 26, 2024 at 06:12:19PM +0530, Vishal Chourasia wrote:
> I've noticed a kernel panic consistently occurring on the mainline v6.11
> kernel (see attached dmesg log below). 
> 
> The panic occurs almost every time I build the Linux kernel from source.
> 
> Steps to Reproduce:
> 
> make clean
> ./scripts/config -e LOCALVERSION_AUTO
> ./scripts/config --set-str LOCALVERSION -master-with-print
> make localmodconfig
> make -j8 -s vmlinux modules
> 
> >From my investigation, it seems that the function pick_eevdf() can return NULL.
> Commit f12e1488 ("sched/fair: Prepare pick_next_task() for delayed dequeue") 
> introduces an access on the return value of pick_eevdf(). If 'se' was NULL, 
> it can lead to a null pointer dereference. 

Even before that commit we relied on that thing not being NULL, notably
f12e1488^1 has:

                se = pick_next_entity(cfs_rq);
                cfs_rq = group_cfs_rq(se);

Which will similarly explode when pick_eevdf() goes wobbly.

> To determine why pick_eevdf() would return NULL, I added a few printk statements
> Based on one of the printk logs in the shared dmesg log, it appears that if
> pick_eevdf() is called for a 'cfs_rq' whose 'cfs_rq->curr' is NULL and there
> are no eligible entities on that 'cfs_rq', it will return NULL. 

Right, that is not a valid state. Which seems to suggest something went
sideways with the eligibility thing -- as Luis suggested.

> I have not been able to think of a quick reproducer to trigger a panic
> for this case. Hoping if someone can guide me on this.
> 
> Note: The following dmesg log also contains a warning reported too. Panic
> happens later.
> 
> ------------[ cut here ]------------
> !se->on_rq
> WARNING: CPU: 1 PID: 92333 at kernel/sched/fair.c:705 update_entity_lag+0xcc/0xf0
> Modules linked in: binfmt_misc bonding tls rfkill ibmveth pseries_rng vmx_crypto nd_pmem nd_btt dax_pmem loop nfnetlink xfs sd_mod papr_scm libnvdimm ibmvscsi scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
> CPU: 1 UID: 0 PID: 92333 Comm: genksyms Tainted: G        W          6.11.0-master-with-print-10547-g684a64bf32b6-dirty #64
> Tainted: [W]=WARN
> Hardware name: IBM,9080-HEX POWER10 (architected) hv:phyp pSeries
> NIP:  c0000000001cdfcc LR: c0000000001cdfc8 CTR: 0000000000000000
> REGS: c00000005c62ee50 TRAP: 0700   Tainted: G        W           (6.11.0-master-with-print-10547-g684a64bf32b6-dirty)
> MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 00000005
> CFAR: c000000000156a10 IRQMASK: 1
> GPR00: c0000000001cdfc8 c00000005c62f0f0 c000000001b57400 000000000000000a
> GPR04: 00000000ffff7fff c00000005c62eee0 c00000005c62eed8 00000007fb050000
> GPR08: 0000000000000027 0000000000000000 0000000000000000 c000000002758de0
> GPR12: c000000002a18d88 c0000007fffef480 0000000000000000 0000000000000000
> GPR16: c000000002c56d40 0000000000000000 c00000005c62f5b4 0000000000000000
> GPR20: fffffffffffffdef 0000000000000000 0000000000000002 c000000003cd7300
> GPR24: 0000000000000000 0000000000000008 c0000007fd1d3f80 0000000000000000
> GPR28: 0000000000000001 0000000000000009 c0000007fd1d4080 c0000000656a0000
> NIP [c0000000001cdfcc] update_entity_lag+0xcc/0xf0
> LR [c0000000001cdfc8] update_entity_lag+0xc8/0xf0
> Call Trace:
> [c00000005c62f0f0] [c0000000001cdfc8] update_entity_lag+0xc8/0xf0 (unreliable)
> [c00000005c62f160] [c0000000001cea80] dequeue_entity+0xb0/0x6d0
> [c00000005c62f1f0] [c0000000001cf8b0] dequeue_entities+0x150/0x600
> [c00000005c62f2c0] [c0000000001d02a8] dequeue_task_fair+0x158/0x2e0
> [c00000005c62f300] [c0000000001b5ea4] dequeue_task+0x64/0x200
> [c00000005c62f380] [c0000000001cc950] detach_tasks+0x140/0x420
> [c00000005c62f3f0] [c0000000001d6044] sched_balance_rq+0x214/0x7c0
> [c00000005c62f550] [c0000000001d6830] sched_balance_newidle+0x240/0x630
> [c00000005c62f640] [c0000000001d6d0c] pick_next_task_fair+0x7c/0x4a0
> [c00000005c62f6d0] [c0000000001afc50] __pick_next_task+0x60/0x2d0
> [c00000005c62f730] [c0000000010e8ce8] __schedule+0x198/0x840
> [c00000005c62f810] [c0000000010e93d0] schedule+0x40/0x110
> [c00000005c62f880] [c00000000064c574] pipe_read+0x424/0x6a0
> [c00000005c62f960] [c00000000063a0fc] vfs_read+0x30c/0x3d0
> [c00000005c62fa10] [c00000000063adf4] ksys_read+0x104/0x160
> [c00000005c62fa60] [c000000000031678] system_call_exception+0x138/0x2d0
> [c00000005c62fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec

So that is a 'fun' one, I don't remember seeing that before. It says
we're trying to dequeue a task that is not on the runqueue.

The big new thing this merge window -- I'm assuming v6.11 is good -- is
DEQUEUE_DELAYED. Does this error go away if you flip that in
kernel/sched/features.h ?


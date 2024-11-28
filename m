Return-Path: <linux-kernel+bounces-424575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEE09DB621
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB02817A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6119342B;
	Thu, 28 Nov 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oeklf9nt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548C18B495
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791510; cv=none; b=e6dTZ58lh+Tb/te5b/h7pjc3UnHzKKjIssraE4J+7OnigKHqmJXLxT7kGd9CWSaEO4+72OZ4unnYT3DA5tqc2DOS7CohWwFbXHe3yjDUw1hyoE8Wh0JSrOq/RdworM8dYD6g8MCyjzSiCs3LMaY9yd05Q7G/5v2uJei1Vkb7ssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791510; c=relaxed/simple;
	bh=E9zQw1niCwoPDAcDHeXU+yzc3Hz7rAaFqeRBLQDS2v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp3x0loZSsd1rQrwwXfeS0S07cQiyAfCaLhvSt8F7ci4Cr4golK0gt6yDESJDz4B0OXLxKtww2sK0f2vyksZIPgaeFqZrTnJwJcp2unHGjxAIyX1s47r/El+w/un7pkklhUEKDvXv8tjI4DIYN/1yxoS+4MOrDekLZ8jEkaryG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oeklf9nt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oTu5vhmiSWzFZZ4AkjxNlaeIV1jUtnI66NFJiIyfJ0Q=; b=oeklf9ntyBKu7auZbMASzCxfKB
	GzsW2LUZy9pZypphOHCVegjEbJ5gIBte720lnV+KL9dN65VsmpDtWN6Y82Jlz38VkfigtucA2+VQy
	okHljmMlyy893ugDxv01b9oQXQzkaNF1w7jwUFLvwKLAuWhg+cmjAGiU+KEFPrR8QOjNptIxegi9Q
	U8drKCPcliYAys8l50jrT7IcqEczq+C12gYfWJxIOz1fhdJlKu8ib1d9UbRnbGzGyj2gMfYdHe4uQ
	d28o/WnffCQP0hDOTl6XA0/re07Uq8HW1nQPYH02Z5m5xqur3BKCKzbs92vePDAsW18/qSrGogwXN
	LG8awvAQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcDy-00000001aga-0vwG;
	Thu, 28 Nov 2024 10:58:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76068300271; Thu, 28 Nov 2024 11:58:17 +0100 (CET)
Date: Thu, 28 Nov 2024 11:58:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20241128105817.GC35539@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>

On Thu, Nov 28, 2024 at 11:32:10AM +0100, Marcel Ziswiler wrote:

> Resulting in the following crash dump (this is running v6.12.1):
> 
> [   14.652856] sched: DL replenish lagged too much
> [   16.572706] ------------[ cut here ]------------
> [   16.573115] WARNING: CPU: 5 PID: 912 at kernel/sched/deadline.c:1995 enqueue_dl_entity+0x46c/0x55c

> [   16.578350] CPU: 5 UID: 0 PID: 912 Comm: job10 Not tainted 6.12.1-dirty #15
> [   16.578956] Hardware name: radxa Radxa ROCK 5B/Radxa ROCK 5B, BIOS 2024.10-rc3 10/01/2024
> [   16.579667] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   16.580273] pc : enqueue_dl_entity+0x46c/0x55c
> [   16.580661] lr : dl_server_start+0x44/0x12c
> [   16.581028] sp : ffff80008002bc00
> [   16.581318] x29: ffff80008002bc00 x28: dead000000000122 x27: 0000000000000000
> [   16.581941] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000009
> [   16.582563] x23: ffff33c976db0e40 x22: 0000000000000001 x21: 00000000002dc6c0
> [   16.583186] x20: 0000000000000001 x19: ffff33c976db17a8 x18: 0000000000000000
> [   16.583808] x17: ffff5dd9779ac000 x16: ffff800080028000 x15: 11c3485b851e0698
> [   16.584430] x14: 11b4b257e4156000 x13: 0000000000000255 x12: 0000000000000000
> [   16.585053] x11: ffff33c976db0ec0 x10: 0000000000000000 x9 : 0000000000000009
> [   16.585674] x8 : 0000000000000005 x7 : ffff33c976db19a0 x6 : ffff33c78258b440
> [   16.586296] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [   16.586918] x2 : 0000000000000001 x1 : 0000000000000001 x0 : ffff33c798e112f0
> [   16.587540] Call trace:
> [   16.587754]  enqueue_dl_entity+0x46c/0x55c
> [   16.588113]  dl_server_start+0x44/0x12c
> [   16.588449]  enqueue_task_fair+0x124/0x49c
> [   16.588807]  enqueue_task+0x3c/0xe0
> [   16.589113]  ttwu_do_activate.isra.0+0x6c/0x208
> [   16.589511]  try_to_wake_up+0x1d0/0x61c
> [   16.589847]  wake_up_process+0x18/0x24
> [   16.590175]  kick_pool+0x84/0x150
> [   16.590467]  __queue_work+0x2f4/0x544
> [   16.590788]  delayed_work_timer_fn+0x1c/0x28
> [   16.591161]  call_timer_fn+0x34/0x1ac
> [   16.591481]  __run_timer_base+0x20c/0x314
> [   16.591832]  run_timer_softirq+0x3c/0x78
> [   16.592176]  handle_softirqs+0x124/0x35c
> [   16.592520]  __do_softirq+0x14/0x20
> [   16.592827]  ____do_softirq+0x10/0x1c
> [   16.593148]  call_on_irq_stack+0x24/0x4c
> [   16.593490]  do_softirq_own_stack+0x1c/0x2c
> [   16.593857]  irq_exit_rcu+0x8c/0xc0
> [   16.594163]  el0_interrupt+0x48/0xbc
> [   16.594477]  __el0_irq_handler_common+0x18/0x24
> [   16.594874]  el0t_64_irq_handler+0x10/0x1c
> [   16.595232]  el0t_64_irq+0x190/0x194
> [   16.595545] ---[ end trace 0000000000000000 ]---
> [   16.595950] ------------[ cut here ]------------
> 
> It looks like it is trying to enqueue an already queued deadline task. Full serial console log available [1].

Right, I've had a number of these reports, but so far we've not yet
managed to figure out how it's all happening.

> We are running the exact same scheduler stress test both on Intel NUCs
> as well as RADXA ROCK 5B board farms.  While so far we have not seen
> this on amd64 it crashes consistently/reproducible on aarch64.

Oooh, that's something. So far the few reports have not been (easily)
reproducible. If this is readily reproducible on arm64 that would
help a lot. Juri, do you have access to an arm64 test box?

A very long shot:

 https://lkml.kernel.org/r/20241127063740.8278-1-juri.lelli@redhat.com

doesn't help, does it?


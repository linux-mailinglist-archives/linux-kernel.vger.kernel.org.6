Return-Path: <linux-kernel+bounces-297567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BACA95BAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80AA1F228E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3AC1CCB5F;
	Thu, 22 Aug 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vcN6TSqY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF91CC892;
	Thu, 22 Aug 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341769; cv=none; b=HCqStGkH/yUsi9NBHsb5yLcNjSEyTmv11ij+nN1jhazyZF26QOVSRnhO3vVCU1AWuedaZQZwuF3Dnd/oRJBYE4RiOZlZhGA5PDjK6PnsIRd+9tUqZNVv8J1V0ebKi/B+CeqHi46O1QAhB+UR2VejHisH4liwI4tks1WmyFudF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341769; c=relaxed/simple;
	bh=kb/+At/yhpH4fro1jvnObHk9+W2eMayvImHkltIZTc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6T3NodxwZB5vj4wNzR3pEFDyKaMNKDN9tTkltRVtNawWzyrFqNSWXqicertbWn9mpAP52ymF/upmA5774kxei36Hcd1QIJ9LmmO3wsFJAqVOp1/7dTiIi9RjRnDLk6BtfCaJ6QXf3RkRTKLyncc9CDoPCC2iT5rHWWgFGlinGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vcN6TSqY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wo5Or872JRMjs2yvDuW/n+As0PQ5HyrLwv/bvl+wIBc=; b=vcN6TSqYHCgGksehp9Nz/C4610
	rXFMGYO1dlVPO7YYYXQ6njjV/Zn6QDVkQKVZKTvwx8amSiUGTKsYbF4SBfrPVjWz86CdSuHhjn7FW
	jTlX4ruu7oMl7XsadkOrNDheZO0VjIFXaJe/HREN/JdAynLc6ANcKE4f8rC8t1wHDD5dP8RzbXA52
	dgMQiqFcJ+VmhQ5DGRSeNv6vHaqONBDyQz1b+8PafiNLffIa5bTTGOSZWhdMiPxxgDHSF+OLxbp8T
	GXpcqGO57MgiwB4YpljEVUAsGf7n1oHWWYX85PL+ZqoJtfO6mLoEM8VZZn7ECtV6BeqKKoOmDN82Z
	KfSYmRpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shA3w-0000000Ag7l-2GrF;
	Thu, 22 Aug 2024 15:49:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D177300642; Thu, 22 Aug 2024 17:49:23 +0200 (CEST)
Date: Thu, 22 Aug 2024 17:49:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	aubrey.li@linux.intel.com
Subject: Re: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <20240822154923.GB17097@noisy.programming.kicks-ass.net>
References: <202408161619.9ed8b83e-lkp@intel.com>
 <20240817093329.GA32430@noisy.programming.kicks-ass.net>
 <ZsLNtymGVe5wk5vP@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsLNtymGVe5wk5vP@chenyu5-mobl2>

On Mon, Aug 19, 2024 at 12:44:39PM +0800, Chen Yu wrote:
> On 2024-08-17 at 11:33:29 +0200, Peter Zijlstra wrote:
> > On Fri, Aug 16, 2024 at 05:15:12PM +0800, kernel test robot wrote:
> > > kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:
> > > 
> > > commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
> > > https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core
> > 
> > > [   86.252370][  T674] ------------[ cut here ]------------
> > > [ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
> > > [ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
> > 
> > > [ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > > [ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > > [ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > > [ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > [ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
> > > [ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
> > > [ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
> > > [ 86.288138][ T674] kthread (kernel/kthread.c:391) 
> > > [ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
> > > [ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > [ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
> > > [ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
> > > [ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
> > 
> > AFAICT this is a pre-existing issue. Notably that all transcribes to:
> > 
> > kthread_worker_fn()
> >   ...
> > repeat:
> >   set_current_state(TASK_INTERRUPTIBLE);
> >   ...
> >   if (work) { // false
> >     __set_current_state(TASK_RUNNING);
> >     ...
> >   } else if (!freezing(current)) // false -- we are freezing
> >     schedule();
> > 
> >   // so state really is still TASK_INTERRUPTIBLE here
> >   try_to_freeze()
> >     might_sleep() <--- boom, per the above.
> >
> 
> Would the following fix make sense?

Yeah, that looks fine. Could you write it up as a proper patch please?

> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f7be976ff88a..09850b2109c9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -848,6 +848,12 @@ int kthread_worker_fn(void *worker_ptr)
>  	} else if (!freezing(current))
>  		schedule();
>  
> +	/*
> +	 * Explictly set the running state in case we are being frozen
> +	 * and skip the schedule() above. try_to_freeze() expects the
> +	 * current task to be in running state.
> +	 */
> +	__set_current_state(TASK_RUNNING);
>  	try_to_freeze();
>  	cond_resched();
>  	goto repeat;
> -- 
> 2.25.1
> 
> Hi Oliver,
> Could you please help check if above change would make the warning go away?
> 
> thanks,
> Chenyu


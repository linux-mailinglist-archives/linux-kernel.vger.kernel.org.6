Return-Path: <linux-kernel+bounces-353589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C7993004
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB851F223E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A41D9695;
	Mon,  7 Oct 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KJn9MOYS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817C1D79A3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312643; cv=none; b=pUIDXRnnBXXjxvsB+RiLz81GKUppmsIb6p62W6YG+T7aAGxhFLE1ziU1KwYngk5o2gjx9XJFdXiplv0L0fVluZBviz5aUXpVHqEvYxBotNaR/FHbjnViogXyfjUFlbC/+QRbGPl7QHYrLTAApF95t83VveK/cfq8lA+5L9Gx/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312643; c=relaxed/simple;
	bh=gK9hoEg0priWx42GLkqOBUwvyNQE51b/hRgmgx5Ax+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVhc7XTfO6n/wBTSvJmbGlyRGWSpF9CHakinDHZugYYDndvQgHx7RyyEbi6MwBB6o7EtfebgHm6qQ2+BJL+0cECKbByRc9wsZkmsN++2AWT7b4HsDemVCbgr9WBtAe5xarNauim2Jded3ebSJSojSNEkenvr3FpJ4iVVfoTnHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KJn9MOYS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y9UgeiFzI4WPkNDRqjLwa/Dbmn1i6hIhLQDjiPHZq28=; b=KJn9MOYS+kL/cJD1kL/sGomOei
	D2zBI1y2LjWtQzrLzogLxC7jMllNtXd4flSizXUJvsXyVQ1Tsx5FnMWNhjj4KQQ9ETj84gxjvZRzr
	X2SC/TnItOYvBHgLGP0IT9l1krJp+PX1WuTybUTe8I5rUEETkhqmDuhKsRQl/CB7GB39yldLtLee+
	8yMg7Hon4++FIxKTBRM3bEwsiw5woncK9LND5Oqve47l22C3AxrHqoebZFogOifMk3WNVAMi8Uvxb
	XLxQvN5SoKHlj7pxTWdcbM4E9iPMKxeDyB6iYlxCebGPJ7wzn59jOYx+gIiBA402Q010frB6ejism
	uKJmf9kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxp4I-000000002r6-0OX8;
	Mon, 07 Oct 2024 14:50:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1DB930088D; Mon,  7 Oct 2024 16:50:37 +0200 (CEST)
Date: Mon, 7 Oct 2024 16:50:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Message-ID: <20241007145037.GE4879@noisy.programming.kicks-ass.net>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>

On Wed, Oct 02, 2024 at 01:54:16PM -0400, Waiman Long wrote:
> 
> On 10/2/24 05:37, Peter Zijlstra wrote:
> > On Thu, Sep 26, 2024 at 11:13:15AM -0400, Waiman Long wrote:
> > > One reason to use a trylock is to avoid a ABBA deadlock in case we need
> > > to use a locking sequence that is not in the expected locking order. That
> > > requires the use of trylock all the ways in the abnormal locking
> > > sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
> > > it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock. That
> > > will cause a lockdep splat like the following in a PREEMPT_RT kernel:
> > > 
> > > [   63.695668] -> #0 (&lock->wait_lock){-...}-{2:2}:
> > > [   63.695674]        check_prev_add+0x1bd/0x1310
> > > [   63.695678]        validate_chain+0x6cf/0x7c0
> > > [   63.695682]        __lock_acquire+0x879/0xf40
> > > [   63.695686]        lock_acquire.part.0+0xfa/0x2d0
> > > [   63.695690]        _raw_spin_lock_irqsave+0x46/0x90
> > > [   63.695695]        rt_mutex_slowtrylock+0x3f/0xb0
> > > [   63.695699]        rt_spin_trylock+0x13/0xc0
> > > [   63.695702]        rmqueue_pcplist+0x5b/0x180
> > > [   63.695705]        rmqueue+0xb01/0x1040
> > > [   63.695708]        get_page_from_freelist+0x1d0/0xa00
> > > [   63.695712]        __alloc_pages_noprof+0x19a/0x450
> > > [   63.695716]        alloc_pages_mpol_noprof+0xaf/0x1e0
> > > [   63.695721]        stack_depot_save_flags+0x4db/0x520
> > > [   63.695727]        kasan_save_stack+0x3f/0x50
> > > [   63.695731]        __kasan_record_aux_stack+0x8e/0xa0
> > > [   63.695736]        task_work_add+0x1ad/0x240
> > > [   63.695741]        sched_tick+0x1c7/0x500
> > > [   63.695744]        update_process_times+0xf1/0x130
> > > [   63.695750]        tick_nohz_handler+0xf7/0x230
> > > [   63.695754]        __hrtimer_run_queues+0x13b/0x7b0
> > > [   63.695758]        hrtimer_interrupt+0x1c2/0x350
> > > [   63.695763]        __sysvec_apic_timer_interrupt+0xdb/0x340
> > > [   63.695770]        sysvec_apic_timer_interrupt+0x9c/0xd0
> > > [   63.695774]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > > [   63.695780]        __asan_load8+0x8/0xa0
> > > [   63.695784]        mas_wr_end_piv+0x28/0x2c0
> > > [   63.695789]        mas_preallocate+0x3a8/0x680
> > > [   63.695793]        vma_shrink+0x180/0x3f0
> > > [   63.695799]        shift_arg_pages+0x219/0x2c0
> > > [   63.695804]        setup_arg_pages+0x343/0x5e0
> > > [   63.695807]        load_elf_binary+0x5ac/0x15d0
> > > [   63.695813]        search_binary_handler+0x125/0x370
> > > [   63.695818]        exec_binprm+0xc9/0x3d0
> > > [   63.695821]        bprm_execve+0x103/0x230
> > > [   63.695824]        kernel_execve+0x187/0x1c0
> > > [   63.695828]        call_usermodehelper_exec_async+0x145/0x1e0
> > > [   63.695832]        ret_from_fork+0x31/0x60
> > > [   63.695836]        ret_from_fork_asm+0x1a/0x30
> > > [   63.695840]
> > > [   63.695840] other info that might help us debug this:
> > > [   63.695840]
> > > [   63.695842] Chain exists of:
> > > [   63.695842]   &lock->wait_lock --> &p->pi_lock --> &rq->__lock
> > > [   63.695842]
> > > [   63.695850]  Possible unsafe locking scenario:
> > > [   63.695850]
> > > [   63.695851]        CPU0                    CPU1
> > > [   63.695852]        ----                    ----
> > > [   63.695854]   lock(&rq->__lock);
> > > [   63.695857]                                lock(&p->pi_lock);
> > > [   63.695861]                                lock(&rq->__lock);
> > > [   63.695864]   lock(&lock->wait_lock);
> > > [   63.695868]
> > > [   63.695868]  *** DEADLOCK ***
> > > 
> > > Fix it by using raw_spin_trylock_irqsave() instead.
> > That truncated lockdep report doesn't really explain anything. Please
> > just transcribe the full lockdep report into something small and
> > coherent.
> 
> I was trying to show where the offending call is coming from. I will send a
> v2 with a condensed lockdep splat.

No no no... explain the actual problem.

Is the problem that:

	sched_tick()
	  task_tick_mm_cid()
	    task_work_add()
	      kasan_save_stack()
	        idiotic crap while holding rq->__lock ?

Because afaict that is completely insane. And has nothing to do with
rtmutex.

We are not going to change rtmutex because instrumentation shit is shit.


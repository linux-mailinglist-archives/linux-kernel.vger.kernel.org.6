Return-Path: <linux-kernel+bounces-353459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E94992E26
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2604280F67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA71D54D7;
	Mon,  7 Oct 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pR3qhIss"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3C188588
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309689; cv=none; b=FY25hgsMcPM29DZsZFecIsiV6oVgkhxNazggI/TfZX0v6Dzr7zB1I5A7upX5LIgHLjL3aehfZuQnkpsoh3KV0TrzFhiFtR5Gg2ywGVgsMLYPFtxDdgHqR25pg/eI3dyYSvm7H+u7dTQqkyQhEMeeNmILYNxAVCoqmw7ywy0JZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309689; c=relaxed/simple;
	bh=LesQT36rB8beqeBx4XPxIderbJvw2v6FVBEwk5Od1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MulKNa8E3oLYAaHKl4mGB8LlKYsMffuPNwszc+Q4vMEpK1RBEaHjxh1C3j/Ua4I4VdvBF5NoOyMk+ILkkhfuuGW/uE1lp4X3iLPSmltoMduZUUbkN9v0rolJ6yvJMZwLF3kVVTY70htEPWdBfTdS1srMkKKqCmACbNi8HDcItuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pR3qhIss; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zcOI4bw+aCbbx2QN6U7CLCKsS4cn8nG6CpQRv3ayI9c=; b=pR3qhIsspEviyyezLiE/Rs7dI/
	ELlWBbhFHZtdOYg30xKIa+fUF3wM+j2hY2BOjfnp50P/uDXe+VXjkrCbMKFccdcGUD1617RLohNLv
	byTDg5INwJ6qYzrxPAR+Fo2U7gt56LoUvZwVUwuS5NgKqMhpZXNtN3a2m1JrizZ6qD2xWXo7725vN
	nNCT+3Ck1L/eGz8hzwUgEGsDwkQVowTwI//wTW9uNa4zwf3Q+2hbkbD9TtPoojq9UdXjDj7RlSPMN
	Y0XWpH/iJbsvcWnUdSGecp0nBy7ymO9VNNgA2EX2bv40/BEYj66XWBkJMCGFl3KNuY7cWZ7CXXh7/
	pOjqI6vA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoIc-0000000HYjV-06Hb;
	Mon, 07 Oct 2024 14:01:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D7F9C30088D; Mon,  7 Oct 2024 16:01:21 +0200 (CEST)
Date: Mon, 7 Oct 2024 16:01:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [PATCH v2] locking/rtmutex: Always use trylock in
 rt_mutex_trylock()
Message-ID: <20241007140121.GD4879@noisy.programming.kicks-ass.net>
References: <20241002190108.1115386-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002190108.1115386-1-longman@redhat.com>

On Wed, Oct 02, 2024 at 03:01:08PM -0400, Waiman Long wrote:
> One reason to use a trylock is to avoid a ABBA deadlock in case we need
> to use a locking sequence that is not in the expected locking order. That
> requires the use of trylock all the ways in the abnormal locking
> sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
> it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock.

This does not explain anything. lock->wait_lock only serializes the lock
internal state and should be fine to be taken like this.

> There are just a few rt_mutex_trylock() call sites in the stock kernel.
> For PREEMPT_RT kernel, however, all the spin_trylock() calls become
> rt_mutex_trylock(). There are a few hundreds of them. So it will be a lot
> easier to trigger a circular locking lockdep splat like the following.
> 
> [   63.695668] -> #0 (&lock->wait_lock){-...}-{2:2}:
> [   63.695674]        check_prev_add+0x1bd/0x1310
> [   63.695678]        validate_chain+0x6cf/0x7c0
> [   63.695682]        __lock_acquire+0x879/0xf40
> [   63.695686]        lock_acquire.part.0+0xfa/0x2d0
> [   63.695690]        _raw_spin_lock_irqsave+0x46/0x90
> [   63.695695]        rt_mutex_slowtrylock+0x3f/0xb0
> [   63.695699]        rt_spin_trylock+0x13/0xc0
> [   63.695702]        rmqueue_pcplist+0x5b/0x180
> [   63.695705]        rmqueue+0xb01/0x1040
>      :
> [   63.695840] other info that might help us debug this:
> [   63.695840]
> [   63.695842] Chain exists of:
> [   63.695842]   &lock->wait_lock --> &p->pi_lock --> &rq->__lock
> [   63.695842]
> [   63.695850]  Possible unsafe locking scenario:
> [   63.695850]
> [   63.695851]        CPU0                    CPU1
> [   63.695852]        ----                    ----
> [   63.695854]   lock(&rq->__lock);
> [   63.695857]                                lock(&p->pi_lock);
> [   63.695861]                                lock(&rq->__lock);
> [   63.695864]   lock(&lock->wait_lock);
> [   63.695868]
> [   63.695868]  *** DEADLOCK ***
> 

This is still useless crap. Please properly describe the locking problem
without truncated lockdep crud.




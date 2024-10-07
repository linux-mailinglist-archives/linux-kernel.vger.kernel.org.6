Return-Path: <linux-kernel+bounces-353700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5E299314B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1380AB28800
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C01D8E09;
	Mon,  7 Oct 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PdLgtQy0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EB1D8E04
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315227; cv=none; b=TKQAY8w+NzOyLf9usg/L65hXMl4ZWBK1VAp92EZW5S9SeKHWcxwCyo8Qq6L4PNcRnhWP63x56iiRRyQMXD3pOWRbqO/BvJbECykkmZLnpVIX5ykiSvphdnQVp45JDkdc/+0DcCWprsrOOlfiPbPHH6EVLeyJnLSarPzMNehR5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315227; c=relaxed/simple;
	bh=baMP09Br76hwmzbKJJIYnwc+xshp+z4CID0vqWR+C/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX2hjXPkhKvn3RFkYwNAUbu9wzC3TWejD62ZUoHAnlGR6Z/wk4OoUP2YfpPO8Axs8V7B8DhXMlH5UdzNOucdRfzfVaLAMs9sySrR4cMvYm/2sJbC4dMZF5q2LE7mEEBgmn+gHn9QNj5zPjCqk/Zw6PmFxKExaRutFg2fNXjXxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PdLgtQy0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDfpkXn27e414/g2KV7cFJRGjn4EwOwKD9rAiCMLjsQ=; b=PdLgtQy0Cqq1vbOavpYZcCD+a0
	2ttV+Yb3AD2MLFEd/0wZ1esb0xLkVszKssCvZtnj1MwoIDU4oIwt52/wri3FNn5/7XMGaZbP/It2g
	XnxWQhNpqH8XGhitOEKW7VjYSw+uciqk+s0XJog5U20GTaAB/CJpQw1sFbkLPj62pcdJSmhPCuCIV
	wkYqdH4K0x3yNJnm0l712j3OrzmWTS48WpBPmT3/F3ojtn/hrnlC0MSrpAv90nYqR40sUYjeeBHb6
	GYC2wAEwRcHd5jBk1sCp8mDtcXzT7QcZrJZGd2PtCaKyJVTOC4V18Xp1TMTlwYrWbDKdxFKT6CfV8
	y0OcftpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxpjy-000000007ya-0ZaC;
	Mon, 07 Oct 2024 15:33:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C375230088D; Mon,  7 Oct 2024 17:33:41 +0200 (CEST)
Date: Mon, 7 Oct 2024 17:33:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Message-ID: <20241007153341.GA14587@noisy.programming.kicks-ass.net>
References: <20240926151315.507905-1-longman@redhat.com>
 <20241002093745.GO5594@noisy.programming.kicks-ass.net>
 <7918987a-4b66-4191-aa52-798f9434352a@redhat.com>
 <20241007145037.GE4879@noisy.programming.kicks-ass.net>
 <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95365aa5-d039-4d09-8191-516ba01c9e5d@redhat.com>

On Mon, Oct 07, 2024 at 11:23:32AM -0400, Waiman Long wrote:

> > Is the problem that:
> > 
> > 	sched_tick()
          raw_spin_lock(&rq->__lock);
> > 	  task_tick_mm_cid()
> > 	    task_work_add()
> > 	      kasan_save_stack()
> > 	        idiotic crap while holding rq->__lock ?
> > 
> > Because afaict that is completely insane. And has nothing to do with
> > rtmutex.
> > 
> > We are not going to change rtmutex because instrumentation shit is shit.
> 
> Yes, it is because of KASAN that causes page allocation while holding the
> rq->__lock. Maybe we can blame KASAN for this. It is actually not a problem
> for non-PREEMPT_RT kernel because only trylock is being used. However, we
> don't use trylock all the way when rt_spin_trylock() is being used with
> PREEMPT_RT Kernel. 

It has nothing to do with trylock, an everything to do with scheduler
locks being special.

But even so, trying to squirrel a spinlock inside a raw_spinlock is
dodgy at the best of times, yes it mostly works, but should be avoided
whenever possible.

And instrumentation just doesn't count.

> This is certainly a problem that we need to fix as there
> may be other similar case not involving rq->__lock lurking somewhere.

There cannot be, lock order is:

  rtmutex->wait_lock
    task->pi_lock
      rq->__lock

Trying to subvert that order gets you a splat, any other:

  raw_spin_lock(&foo);
  spin_trylock(&bar);

will 'work', despite probably not being a very good idea.

Any case involving the scheduler locks needs to be eradicated, not
worked around.



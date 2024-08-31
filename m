Return-Path: <linux-kernel+bounces-310026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09947967350
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 23:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F14282AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 21:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D1A4500E;
	Sat, 31 Aug 2024 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q97b1QKY"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AB183CA3
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725138911; cv=none; b=dbR1xar4PzSTGpGDOXChZ9TQKtqYd7g1IrxWSykh6yNhDgPgFfkooo3kVPXmtq7dGFFSCSnick6lUuFmpv2bYtClmLWsSp9za8xvNSetyYqi8Wr4x4k4cAElUAwNGzhIcWAyCfKSgaRlEU0idMW6mrvX1EsaX6w2xDPTnchp9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725138911; c=relaxed/simple;
	bh=eQAtaQ/QhzLkIHaTH/Ukw2YOoFb9dNKgMiN/x3u1qOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBcduGtUsc1syIMk3vvYSM8Kc3qzMD/tNluYd8CM3or2sApGnlyJ+mCAdQXUolYSIYJExs7DfItkykezh5o0jMN6rFf3ZGlOqqyKzo+tc1LmFZmDfPG7VZeoa1l5DcaD5ca0SgOXFO9qFrnRMj3kVb9RkRxchuppRN9djUlZAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q97b1QKY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 31 Aug 2024 23:15:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725138906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=33tao4Tmz3HOrHuy5i102D7+HCZMfQIcePtH0bM5gHo=;
	b=Q97b1QKYvJC/kY7q461Bm4CZTJdfjO9Rdcr4uYLVW2uHBHC9L/x/2DDM5scZ7EHLT3tjHL
	i8XOwDGkUAmXTdtV2JNd4h+CRt3s7J2j/yXHfs+iZ1ghfbtP8+FunJui/HICNFnTOv0VF/
	xCQ8Te29MzncUcyzpCNf9gvhm0bk5eI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 10/11] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtOH1YlEgyP45UkU@gpd3>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-11-tj@kernel.org>
 <ZtMpIb38MSn5r4-U@gpd3>
 <ZtNC6l9nUEPnneag@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtNC6l9nUEPnneag@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 31, 2024 at 06:20:58AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sat, Aug 31, 2024 at 04:30:57PM +0200, Andrea Righi wrote:
> ...
> > > @@ -5511,7 +5516,7 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
> > >   * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
> > >   * @p: task_struct to dispatch
> > >   * @dsq_id: DSQ to dispatch to
> > > - * @slice: duration @p can run for in nsecs
> > > + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> > >   * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> > 
> > Maybe allow to keep the current vtime if 0 is passed, similar to slice?
> 
> It's tricky as 0 is a valid vtime. It's unlikely but depending on how vtime
> is defined, it may wrap in a practical amount of time. More on this below.

Ok.

> 
> ...
> > > +	/*
> > > +	 * Can be called from either ops.dispatch() locking this_rq() or any
> > > +	 * context where no rq lock is held. If latter, lock @p's task_rq which
> > > +	 * we'll likely need anyway.
> > > +	 */
> > 
> > About locking, I was wondering if we could provide a similar API
> > (scx_bpf_dispatch_lock()?) to use scx_bpf_dispatch() from any context
> > and not necessarily from ops.select_cpu() / ops.enqueue() or
> > ops.dispatch().
> > 
> > This would be really useful for user-space schedulers, since we could
> > use scx_bpf_dispatch() directly and get rid of the
> > BPF_MAP_TYPE_RINGBUFFER complexity.
> 
> One difference between scx_bpf_dispatch() and scx_bpf_dispatch_from_dsq() is
> that the former is designed to be safe to call from any context under any
> locks by doing the actual dispatches asynchronously. This is primarily to
> allow scx_bpf_dispatch() to be called under BPF locks as they are used to
> transfer the ownership of tasks from the BPF side to the kernel side. This
> makes it more difficult to make scx_bpf_dispatch() more flexible. The way
> BPF locks are currently developing, we might not have to worry about killing
> the system through deadlocks but it'd still be very prone to soft deadlocks
> that kill the BPF scheduler if implemented synchronously. Maybe the solution
> here is bouncing to an irq_work or something. I'll think more on it.

Got it. Well, the idea was to reduce complexity in the user-space
schedulers, but if we need to increase complexity in the kernel to do
so, probably it's not a good idea.

Moreover, using the BPF_MAP_TYPE_RINGBUFFER is really fast now, the
overhead is pretty close to zero, so maybe we can keep this as a low
priority todo.

> 
> ...
> > > +__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
> > > +					   struct task_struct *p, u64 dsq_id,
> > > +					   u64 slice, u64 enq_flags)
> > > +{
> > > +	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
> > > +				     p, dsq_id, slice, 0, enq_flags);
> > > +}
> > > +
> > > +/**
> > > + * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
> > > + * @it__iter: DSQ iterator in progress
> > > + * @p: task to transfer
> > > + * @dsq_id: DSQ to move @p to
> > > + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> > > + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> > > + * @enq_flags: SCX_ENQ_*
> > 
> > Hm... can we pass 6 arguments to a kfunc? I think we're limited to 5,
> > unless I'm missing something here.
> 
> Hah, I actually don't know and didn't test the vtime variant. Maybe I should
> just drop the @slice and @vtime. They can be set by the caller explicitly
> before calling these kfuncs anyway although there are some concerns around
> ownership (ie. the caller can't be sure that the task has already been
> dispatched by someone else before scx_bpf_dispatch_from_dsq() commits). Or
> maybe I should pack the optional arguments into a struct. I'll think more
> about it.

IMHO we can simply drop them, introducing a separate struct makes the
API a bit inconsistent with scx_bpf_dispatch() (and I don't think we
want to change also scx_bpf_dispatch() for that).

About the ownership, true... maybe we can accept a bit of fuzziness
in this case, also considering that this race can happen only when using
scx_bpf_dispatch_from_dsq().

Thanks,
-Andrea


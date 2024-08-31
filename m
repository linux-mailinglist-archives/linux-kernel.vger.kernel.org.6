Return-Path: <linux-kernel+bounces-309975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232799672A6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78761B2225A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9546522;
	Sat, 31 Aug 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5NtHYR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E451DA5F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121260; cv=none; b=RpQQNqzfEkrMVGg7UyKFmyIaOgBFJi6vU7yS4ufzcspc67I7WzgAzc13omYeptdvdjreN+YNJbcOU3BDO9HHonxWes/3fO41zSTkID/TJWx+2tBL+tZhZwd0Po4IXt0iTl10/cv+/F/0uNQtLiks0kNzeNuHjxD81K2QBgbLsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121260; c=relaxed/simple;
	bh=3dr3Vse4tfADc//aMVNvoXW6fQ3jpvCVTfIfodYss1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZ80hJBrzvmgk+CnGaOnPVDCkOTTaKODEoHcId8+4XS95AUvP/D7s5mlPVat5Wj9IJaND4AVaBIuupKuk6pA0mMQSAZnJ+FfYzSeNtd+wksKlELB/ldYN3PS1dLI7vgSxUPq++2CkVBSBsS05SyjcNsqezNjqFGpJizXPtUToCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5NtHYR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9AC4CEC0;
	Sat, 31 Aug 2024 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725121259;
	bh=3dr3Vse4tfADc//aMVNvoXW6fQ3jpvCVTfIfodYss1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5NtHYR2e/7exptHHbCYKd/N4RXcFR3YDyfO7sE8y7JvyZH8ssfftDosDfpe9G1/a
	 djhuJF0i91If/VyyXAxvb6fdQzRKVheA8gVyyg3v4wWVEIBJXyQdbuwprHK0Qs3S8t
	 9OGZWHuthBAidKQ0wQv065L8u219GBjMG9jzehHjbOJTdllQF5wpaOZg8IQ431aToP
	 /11nJEPkSkymjm+LG3IcLP7HD/yLEy3E0Mjq90scsyBmOR6CX0P9feROkpEYF6KoTK
	 qkdIESkGIIkTzpWeNGtUXlhhLdgleIYRcM+/hYIEH3hirLyAT3urpKAeC+6WE7Eq/a
	 +R9XI990EwTBQ==
Date: Sat, 31 Aug 2024 06:20:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: void@manifault.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 10/11] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
Message-ID: <ZtNC6l9nUEPnneag@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-11-tj@kernel.org>
 <ZtMpIb38MSn5r4-U@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtMpIb38MSn5r4-U@gpd3>

Hello,

On Sat, Aug 31, 2024 at 04:30:57PM +0200, Andrea Righi wrote:
...
> > @@ -5511,7 +5516,7 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
> >   * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
> >   * @p: task_struct to dispatch
> >   * @dsq_id: DSQ to dispatch to
> > - * @slice: duration @p can run for in nsecs
> > + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> >   * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> 
> Maybe allow to keep the current vtime if 0 is passed, similar to slice?

It's tricky as 0 is a valid vtime. It's unlikely but depending on how vtime
is defined, it may wrap in a practical amount of time. More on this below.

...
> > +	/*
> > +	 * Can be called from either ops.dispatch() locking this_rq() or any
> > +	 * context where no rq lock is held. If latter, lock @p's task_rq which
> > +	 * we'll likely need anyway.
> > +	 */
> 
> About locking, I was wondering if we could provide a similar API
> (scx_bpf_dispatch_lock()?) to use scx_bpf_dispatch() from any context
> and not necessarily from ops.select_cpu() / ops.enqueue() or
> ops.dispatch().
> 
> This would be really useful for user-space schedulers, since we could
> use scx_bpf_dispatch() directly and get rid of the
> BPF_MAP_TYPE_RINGBUFFER complexity.

One difference between scx_bpf_dispatch() and scx_bpf_dispatch_from_dsq() is
that the former is designed to be safe to call from any context under any
locks by doing the actual dispatches asynchronously. This is primarily to
allow scx_bpf_dispatch() to be called under BPF locks as they are used to
transfer the ownership of tasks from the BPF side to the kernel side. This
makes it more difficult to make scx_bpf_dispatch() more flexible. The way
BPF locks are currently developing, we might not have to worry about killing
the system through deadlocks but it'd still be very prone to soft deadlocks
that kill the BPF scheduler if implemented synchronously. Maybe the solution
here is bouncing to an irq_work or something. I'll think more on it.

...
> > +__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
> > +					   struct task_struct *p, u64 dsq_id,
> > +					   u64 slice, u64 enq_flags)
> > +{
> > +	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
> > +				     p, dsq_id, slice, 0, enq_flags);
> > +}
> > +
> > +/**
> > + * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
> > + * @it__iter: DSQ iterator in progress
> > + * @p: task to transfer
> > + * @dsq_id: DSQ to move @p to
> > + * @slice: duration @p can run for in nsecs, 0 to keep the current value
> > + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
> > + * @enq_flags: SCX_ENQ_*
> 
> Hm... can we pass 6 arguments to a kfunc? I think we're limited to 5,
> unless I'm missing something here.

Hah, I actually don't know and didn't test the vtime variant. Maybe I should
just drop the @slice and @vtime. They can be set by the caller explicitly
before calling these kfuncs anyway although there are some concerns around
ownership (ie. the caller can't be sure that the task has already been
dispatched by someone else before scx_bpf_dispatch_from_dsq() commits). Or
maybe I should pack the optional arguments into a struct. I'll think more
about it.

Thanks.

-- 
tejun


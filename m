Return-Path: <linux-kernel+bounces-403005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB69C2F74
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CB1B21ECD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6219DF8D;
	Sat,  9 Nov 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhwVYJQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2D29CF4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731183468; cv=none; b=ovfZg94pGZZEE2EwOSrA6GtDcLJQ2NtDHytgiqMM4AfANSnAfsqxn4h+kSbHjnnDwuwxFn1FJBvidg+TIp4/LmG1gv5yP4lqUAWlMmEned6vxIJGzu4WY+1ndpinr6LZ0jKr1SVada/gHth+nUQ8E2ij8dMSC8f45obKd0xq590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731183468; c=relaxed/simple;
	bh=UUtoRkVTIu1sdW/UpAiKR+WXSGTv6xapovhkwAmWNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgL6QXs/s9l0Z35SzrrBz8a87yYH87E0YiKLooJJXcV0jVryKF3VzygFCZIPK2dcQ9VqqU2ultfodsLepiCCxOdv8PFnSSlasmb3G+pcBVPLb8mEkbhm5bxp0NxqI4RBZ1OGvYikIrFnWTlA+yERjW7DO0Sq/ZbP0D2ZnY1h3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhwVYJQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D6C4CECE;
	Sat,  9 Nov 2024 20:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731183468;
	bh=UUtoRkVTIu1sdW/UpAiKR+WXSGTv6xapovhkwAmWNxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RhwVYJQ6Mqhf1uNrm3XFBXrvnOmpEaMT6CoYgaBwoss4KFrDk8JxL2RbXntB+P2NO
	 zO4Ms6EGb+hKMv61Y1MPJZ2PNvACkRMAADpV9VE2FZ8V48d2nt4oPxLXb83BMy/aDY
	 15E094oceU8poffJSUeBj8GOJpXMRuFieqPKGRyt0psLlJH2avUhjh4k0Uq4Av+tXT
	 MiBZ+47vOffcdBZIOYpp8We3iVjWSzOIo/2hfYm7LCFRU+ZTcL1Vplp/u0xZu/GssZ
	 FjMeQf91Pv6Sb+lODNeeJiEYT5vjVf5X8BDuQpyqJ3x8H808zIw7wlPzn0ONI+lA1W
	 4aXB17h7lh4fA==
Date: Sat, 9 Nov 2024 10:17:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <Zy_Da_IEJYD2ykgj@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
 <20240905092858.GA15400@noisy.programming.kicks-ass.net>
 <20240905150012.GF4928@noisy.programming.kicks-ass.net>
 <ZtnfRnmo-EpWKcyC@slm.duckdns.org>
 <ZtpYGQ73WQcb95Fe@slm.duckdns.org>
 <20240906090420.GU4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906090420.GU4723@noisy.programming.kicks-ass.net>

Hello, Peter.

On Fri, Sep 06, 2024 at 11:04:20AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 05, 2024 at 03:17:13PM -1000, Tejun Heo wrote:
> > On Thu, Sep 05, 2024 at 06:41:42AM -1000, Tejun Heo wrote:
> > > > @@ -12716,6 +12716,12 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
> > > >  	if (this_rq->cfs.h_nr_running && !pulled_task)
> > > >  		pulled_task = 1;
> > > >  
> > > > +	/*
> > > > +	 * We pulled a task, but it got stolen before we re-acquired rq->lock.
> > > > +	 */
> > > > +	if (!this_rq->cfs.h_nr_running && pulled_task)
> > > > +		pulled_task = 0;
> > > > +
> > > 
> > > Lemme test that.
> > 
> > Did a bit of testing and it seems like it's mostly coming from delayed
> > dequeue handling. pick_next_entity() does this:
> > 
> > 	struct sched_entity *se = pick_eevdf(cfs_rq);
> > 	if (se->sched_delayed) {
> > 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> > 		SCHED_WARN_ON(se->sched_delayed);
> > 		SCHED_WARN_ON(se->on_rq);
> > 		return NULL;
> > 	}
> > 
> > rq->cfs.nr_running includes the number of delay dequeued tasks which aren't
> > really runnable, so it seems like balance_fair() saying yes and
> > pick_next_entity() then hitting a delayed task.
> 
> Duh, yes.
> 
> > Maybe the solution is
> > tracking the number of delayed ones and subtracting that from nr_running?
> 
> That came up yesterday for something else as well. Let me see if I can
> make that happen.
> 
> 
> Anyway, I suppose you keep your patch for now until I've managed to sort
> this out.

This still triggers. I'm going to apply the workaround for now.

Thanks.

-- 
tejun


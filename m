Return-Path: <linux-kernel+bounces-397014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AFC9BD5A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73B3B2192C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE7E1EABD6;
	Tue,  5 Nov 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUQCkz3M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBA1E2007
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833549; cv=none; b=Yb5pv/035JuZ9/Q9Dhwh7Bd7VufVije7LmYWTsKueq/KQmT706eSnxXQHpVteucoyN4moTzsZY6ejSixXtvp3sGFzjBJRHMnMr2PIaUsHEzlSW2ezj/k+wntJQJA034ZktS+m/0ceKTEOdwTUPaBYsTu+0mCL9RhlKyhAfTBneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833549; c=relaxed/simple;
	bh=wZUfq6Isw1kQ4UQM8damyjp8YjoQX8goQDRVh2CtLiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/Lw43P91BvT5z8Lzk4SYFes4AZVOYqv6Ez5NESzhBEibMfHt+PDoKHICfez0iyFFEk12IEwCAfKAHZiBP6k2w3tniG1T0g1FR8HeeXKxkEDK2ikvL600XyWgcm0R9eo19h2nEKugu/lCIv6dpbugbbzeWf6hdbW5qnQqll45Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LUQCkz3M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730833546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4a5GVWXVnUQexXTW5/cfLETYhB7DnaKWLGrc8iNNqRw=;
	b=LUQCkz3MNsDuYMwzi4gw9y9ECVNkxY3xAMeLeJ9IpZoiNgc9bDeHT/oz+mJ8K/rS6jgaEG
	MrQeOrNprUdY4fognkCRxrUXBP7jLEn/4ksTaXr4pPD77hPTz7yvNwHESaxPsjPtrxhEB1
	OfdOK1oC21APN1k0tvRhBiLJpVyR3iU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-yfi62ov0Mb-Yvl7Kd9H2Ow-1; Tue,
 05 Nov 2024 14:05:43 -0500
X-MC-Unique: yfi62ov0Mb-Yvl7Kd9H2Ow-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08A2819560BD;
	Tue,  5 Nov 2024 19:05:41 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.146])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DDF719560AD;
	Tue,  5 Nov 2024 19:05:37 +0000 (UTC)
Date: Tue, 5 Nov 2024 14:05:34 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241105190534.GC33795@pauld.westford.csb>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241105152010.GA33795@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105152010.GA33795@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Nov 05, 2024 at 10:20:10AM -0500 Phil Auld wrote:
> On Tue, Nov 05, 2024 at 05:05:12AM +0100 Mike Galbraith wrote:
> > On Mon, 2024-11-04 at 08:05 -0500, Phil Auld wrote:
> > > On Sat, Nov 02, 2024 at 05:32:14AM +0100 Mike Galbraith wrote:
> > >
> > > >
> > > > The buddy being preempted certainly won't be wakeup migrated...
> > >
> > > Not the waker who gets preempted but the wakee may be a bit more
> > > sticky on his current cpu and thus stack more since he's still
> > > in that runqueue.
> > 
> > Ah, indeed, if wakees don't get scraped off before being awakened, they
> > can and do miss chances at an idle CPU according to trace_printk().
> > 
> > I'm undecided if overall it's boon, bane or even matters, as there is
> > still an ample supply of wakeup migration, but seems it can indeed
> > inject wakeup latency needlessly, so <sharpens stick>...
> > 
> > My box booted and neither become exceptionally noisy nor inexplicably
> > silent in.. oh, minutes now, so surely yours will be perfectly fine.
> > 
> > After one minute of lightly loaded box browsing, trace_printk() said:
> > 
> >   645   - racy peek says there is a room available
> >    11   - cool, reserved room is free
> >   206   - no vacancy or wakee pinned
> > 38807   - SIS accommodates room seeker
> > 
> > The below should improve the odds, but high return seems unlikely.
> >
> 
> Thanks, I'll give it a spin with the nr_cpus_allowed bit.
>

Well that worked pretty well. It actually makes DELAY_DEQUEUE a litte better
than NO_DELAY_DEQUEUE

DELAY_DEQUEUE     ~595MB/s
NO_DELAY_DEQUEUE  ~581MB/s

I left the cpumask_weight becaude vim isn't happy with my terminal to that machine
for some reason I have not found yet. So I couldn't actually edit the darn thing.
This is not my normal build setup. But I'll spin up a real build with this patch
and throw it over the wall to the perf team to have them do their full battery
of tests on it.

Probably "Paul" will be cranky now. 


Thanks,
Phil


> 
> Cheers,
> Phil
> 
> 
> 
> > ---
> >  kernel/sched/core.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3790,7 +3790,13 @@ static int ttwu_runnable(struct task_str
> >  	rq = __task_rq_lock(p, &rf);
> >  	if (task_on_rq_queued(p)) {
> >  		update_rq_clock(rq);
> > -		if (p->se.sched_delayed)
> > +		/*
> > +		 * If wakee is mobile and the room it reserved is occupied, let it try to migrate.
> > +		 */
> > +		if (p->se.sched_delayed && rq->nr_running > 1 && cpumask_weight(p->cpus_ptr) > 1) {
> > +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> > +			goto out_unlock;
> > +		} else if (p->se.sched_delayed)
> >  			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> >  		if (!task_on_cpu(rq, p)) {
> >  			/*
> > @@ -3802,6 +3808,7 @@ static int ttwu_runnable(struct task_str
> >  		ttwu_do_wakeup(p);
> >  		ret = 1;
> >  	}
> > +out_unlock:
> >  	__task_rq_unlock(rq, &rf);
> > 
> >  	return ret;
> > 
> > 
> 
> -- 
> 
> 

-- 



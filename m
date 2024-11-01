Return-Path: <linux-kernel+bounces-392877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 196F99B9926
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A139D282FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C731D365A;
	Fri,  1 Nov 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HquCUdbT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995A1ABEA1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491640; cv=none; b=J4EHtLTrgAjo0eCChp+it3R10asVqdk7C6sZ0Kw8+kh6C6gVfxm/gu+nQ1TvDQ8NatCrr0H3BDUzyHlDQ9io9DQUU93oA/UwrLYYfXKxJ6aDe4spe6tvRK45CX7UWWWIvg7i4dM0/5Ly9zZDl+YsPuYmlFI3XSFrByotQWA2EXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491640; c=relaxed/simple;
	bh=N88GzlmxEE9HtkMlzHArbN+K5hMRhPN+NNP1INNrCOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7kJ1yaD9Pj0JQ3D6/LcZl2RJPiAXHmlKlKvWw5WroapGJVj4zoE/ze6CkdY2MImtY+CitjsHfY0FUQXrPLu4z2nHR0976HDWCdI1o11FDYk5gu541dahPGPwfZ0quUrqf8Cb3ct9+REi6SnKcrOoUqchOxYQ3kKcNoG8eZzRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HquCUdbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730491637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLKNPdZ2ZjYLPtoqDOBfRXehXk2qVxTUmNoRZaqpXHs=;
	b=HquCUdbTpUqP6GCUdImu6QIKKGRd6aQ8nM8FJ5TgwKVEDn+iQrYNlp2WHl/OogE6IU84/e
	mj5Ziiz6xLsu/lQs4CHDFne09NQ8TD0BxOpRp4oDHcyghCIzgk6cVHN+GIp3Fuem5ut3b3
	VAeKhN1uFUD1LzOUYs/2CdGpYWNPO24=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-3qwXkxSxPnKlS1Pan7fHQA-1; Fri,
 01 Nov 2024 16:07:14 -0400
X-MC-Unique: 3qwXkxSxPnKlS1Pan7fHQA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDE4E197703E;
	Fri,  1 Nov 2024 20:07:11 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA98A19560A2;
	Fri,  1 Nov 2024 20:07:07 +0000 (UTC)
Date: Fri, 1 Nov 2024 16:07:04 -0400
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101200704.GE689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Hi Mike,

On Fri, Nov 01, 2024 at 07:08:31PM +0100 Mike Galbraith wrote:
> On Fri, 2024-11-01 at 10:42 -0400, Phil Auld wrote:
> > On Fri, Nov 01, 2024 at 03:26:49PM +0100 Peter Zijlstra wrote:
> > > On Fri, Nov 01, 2024 at 09:38:22AM -0400, Phil Auld wrote:
> > >
> > > > How is delay dequeue causing more preemption?
> > >
> > > The thing delay dequeue does is it keeps !eligible tasks on the runqueue
> > > until they're picked again. Them getting picked means they're eligible.
> > > If at that point they're still not runnable, they're dequeued.
> > >
> > > By keeping them around like this, they can earn back their lag.
> > >
> > > The result is that the moment they get woken up again, they're going to
> > > be eligible and are considered for preemption.
> > >
> > >
> > > The whole thinking behind this is that while 'lag' measures the
> > > mount of service difference from the ideal (positive lag will have less
> > > service, while negative lag will have had too much service), this is
> > > only true for the (constantly) competing task.
> > >
> > > The moment a task leaves, will it still have had too much service? And
> > > after a few seconds of inactivity?
> > >
> > > So by keeping the deactivated tasks (artificially) in the competition
> > > until they're at least at the equal service point, lets them burn off
> > > some of that debt.
> > >
> > > It is not dissimilar to how CFS had sleeper bonus, except that was
> > > walltime based, while this is competition based.
> > >
> > >
> > > Notably, this makes a significant difference for interactive tasks that
> > > only run periodically. If they're not eligible at the point of wakeup,
> > > they'll incur undue latency.
> > >
> > >
> > > Now, I imagine FIO to have tasks blocking on IO, and while they're
> > > blocked, they'll be earning their eligibility, such that when they're
> > > woken they're good to go, preempting whatever.
> > >
> > > Whatever doesn't seem to enjoy this.
> > >
> > >
> > > Given BATCH makes such a terrible mess of things, I'm thinking FIO as a
> > > whole does like preemption -- so now it's a question of figuring out
> > > what exactly it does and doesn't like. Which is never trivial :/
> > >
> >
> > Thanks for that detailed explanation.
> >
> > I can confirm that FIO does like the preemption
> >
> > NO_WAKEUP_P and DELAY    - 427 MB/s
> > NO_WAKEUP_P and NO_DELAY - 498 MB/s
> > WAKEUP_P and DELAY       - 519 MB/s
> > WAKEUP_P and NO_DELAY    - 590 MB/s
> >
> > Something in the delay itself
> > (extra tasks in the queue? not migrating the delayed task? ...)
> 
> I think it's all about short term fairness and asymmetric buddies.

Thanks for jumping in.  My jargon decoder ring seems to be failing me
so I'm not completely sure what you are saying below :)

"buddies" you mean tasks that waking each other up and sleeping.
And one runs for longer than the other, right?

> 
> tbench comparison eevdf vs cfs, 100% apple to apple.
> 
> 1 tbench buddy pair scheduled cross core.
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
> 13770 root      20   0   21424   1920   1792 S 60.13 0.012   0:33.81 3 tbench
> 13771 root      20   0    4720    896    768 S 46.84 0.006   0:26.10 2 tbench_srv
 
> Note 60/47 utilization, now pinned/stacked.
> 
> 6.1.114-cfs
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
>  4407 root      20   0   21424   1980   1772 R 50.00 0.012   0:29.20 3 tbench
>  4408 root      20   0    4720    124      0 R 50.00 0.001   0:28.76 3 tbench_srv

What is the difference between these first two?  The first is on
separate cores so they don't interfere with each other? And the second is
pinned to the same core?

>
> Note what happens to the lighter tbench_srv. Consuming red hot L2 data,
> it can utilize a full 50%, but it must first preempt wide bottom buddy.
>

We've got "light" and "wide" here which is a bit mixed metaphorically :) 
So here CFS is letting the wakee preempt the waker and providing pretty
equal fairness. And hot l2 caching is masking the assymmetry. 

> Now eevdf.  (zero source deltas other than eevdf)
> 6.1.114-eevdf -delay_dequeue
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
>  4988 root      20   0   21424   1948   1736 R 56.44 0.012   0:32.92 3 tbench
>  4989 root      20   0    4720    128      0 R 44.55 0.001   0:25.49 3 tbench_srv
> 6.1.114-eevdf +delay_dequeue
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
>  4934 root      20   0   21424   1952   1736 R 52.00 0.012   0:30.09 3 tbench
>  4935 root      20   0    4720    124      0 R 49.00 0.001   0:28.15 3 tbench_srv
> 
> As Peter noted, delay_dequeue levels the sleeper playing field.  Both
> of these guys are 1:1 sleepers, but they're asymmetric in width.

With wakeup preemption off it doesn't help in my case. I was thinking
maybe the preemption was preventing some batching of IO completions or
initiations. But that was wrong it seems. 

Does it also possibly make wakeup migration less likely and thus increase
stacking?  

> Bottom line, box full of 1:1 buddies pairing up and stacking in L2.
> 
> tbench 8
> 6.1.114-cfs      3674.37 MB/sec
> 6.1.114-eevdf    3505.25 MB/sec -delay_dequeue
>                  3701.66 MB/sec +delay_dequeue
> 
> For tbench, preemption = shorter turnaround = higher throughput.

So here you have a benchmark that gets a ~5% boost from delayed_dequeue.

But I've got one that get's a 20% penalty so I'm not exactly sure what
to make of that. Clearly FIO does not have the same pattern as tbench. 

It's not a special case though, this is one that our perf team runs
regularly to look for regressions. 

I'll be able to poke at it more next week so hopefully I can see what it's
doing. 


Cheers,
Phil


> 
> 	-Mike
> 

-- 



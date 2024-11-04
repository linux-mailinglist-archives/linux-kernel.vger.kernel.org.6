Return-Path: <linux-kernel+bounces-394889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C977E9BB561
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072B11C216C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A501BB6B8;
	Mon,  4 Nov 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5LqlTjs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B061B6CE2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725530; cv=none; b=DTkvxfEXZ3pZOpJRftmmzmLYopWmRF8FkARkVlkfBsFRSqCJUOQw+EZO1oYoNaWciV+f50VT/x3M7sP/ruQzadGwlAbIR/HxD32lb6RS1NdEmpf2g3irWuA5rPu/L66xq614XKppI5zJl/Ju+zE/YksJWbMlcc7TmtYuZ0yYbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725530; c=relaxed/simple;
	bh=65kT3UCN1UtgaJ/frS/Hb1gApAa2Gbw0coDyeGaCn7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epMqLeMRAdAmONPaPs6N4icfisildMFr5hbXJ98CuS3DmrkPv7q7MF1F+UV3XOUTEk9Big+Io3M5NmnFPbYkjRIT6wYD69Br4qD6L418gGYo+q7DHgWizjSntPE5mZ+AAZZxib7urrHIIc0UFOLGVp7Pug9fy4y7WJq5t3uOybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5LqlTjs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730725527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wc/z0Yh/IxzyO8C+d7bRwb2Uka1yAqc+JQjWmkLQCo=;
	b=W5LqlTjs/qYxKXm+ayN8LdKw/e4aawZmY7xUxZPN3C53E4d9/XVPQtjNCQ7+tv5rfOOMbb
	VOv62tWQeImyYHgmKInn8TTFBCVVU+Oa8/fd2RUCXiivkQFvMTuDwUAqJeshliVcZE4PJ6
	3Ylw0HQaPonYYnCDN3xEOovXu3RS98k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-Cw6gChu9N0KiB1bq1B6FxA-1; Mon,
 04 Nov 2024 08:05:24 -0500
X-MC-Unique: Cw6gChu9N0KiB1bq1B6FxA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2080B195608B;
	Mon,  4 Nov 2024 13:05:22 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.138])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A68A219560AD;
	Mon,  4 Nov 2024 13:05:18 +0000 (UTC)
Date: Mon, 4 Nov 2024 08:05:15 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241104130515.GB749675@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Nov 02, 2024 at 05:32:14AM +0100 Mike Galbraith wrote:
> On Fri, 2024-11-01 at 16:07 -0400, Phil Auld wrote:
> 
> 
> > Thanks for jumping in.  My jargon decoder ring seems to be failing me
> > so I'm not completely sure what you are saying below :)
> >
> > "buddies" you mean tasks that waking each other up and sleeping.
> > And one runs for longer than the other, right?
> 
> Yeah, buddies are related waker/wakee 1:1 1:N or M:N, excluding tasks
> happening to be sitting on a CPU where, say a timer fires, an IRQ leads
> to a wakeup of lord knows what, lock wakeups etc etc etc. I think Peter
> coined the term buddy to mean that (less typing), and it stuck.
>

Thanks!

> > > 1 tbench buddy pair scheduled cross core.
> > >
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
> > > 13770 root      20   0   21424   1920   1792 S 60.13 0.012   0:33.81 3 tbench
> > > 13771 root      20   0    4720    896    768 S 46.84 0.006   0:26.10 2 tbench_srv
> >  
> > > Note 60/47 utilization, now pinned/stacked.
> > >
> > > 6.1.114-cfs
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ P COMMAND
> > >  4407 root      20   0   21424   1980   1772 R 50.00 0.012   0:29.20 3 tbench
> > >  4408 root      20   0    4720    124      0 R 50.00 0.001   0:28.76 3 tbench_srv
> >
> > What is the difference between these first two?  The first is on
> > separate cores so they don't interfere with each other? And the second is
> > pinned to the same core?
> 
> Yeah, see 'P'. Given CPU headroom, a tbench pair can consume ~107%.
> They're not fully synchronous.. wouldn't be relevant here/now if they
> were :)
> 
> > > Note what happens to the lighter tbench_srv. Consuming red hot L2 data,
> > > it can utilize a full 50%, but it must first preempt wide bottom buddy.
> > >
> >
> > We've got "light" and "wide" here which is a bit mixed metaphorically
> > :)
> 
> Wide, skinny, feather-weight or lard-ball, they all work for me.
> 
> > So here CFS is letting the wakee preempt the waker and providing pretty
> > equal fairness. And hot l2 caching is masking the assymmetry.
> 
> No, it's way simpler: preemption slices through the only thing it can
> slice through, the post wakeup concurrent bits.. that otherwise sits
> directly in the communication stream as a lump of latency in a latency
> bound operation.
> 
> >
> > With wakeup preemption off it doesn't help in my case. I was thinking
> > maybe the preemption was preventing some batching of IO completions
> > or
> > initiations. But that was wrong it seems.
> 
> Dunno.
> 
> > Does it also possibly make wakeup migration less likely and thus increase
> > stacking?
> 
> The buddy being preempted certainly won't be wakeup migrated, because
> it won't sleep. Two very sleepy tasks when bw constrained becomes one
> 100% hog and one 99.99% hog when CPU constrained.
>

Not the waker who gets preempted but the wakee may be a bit more
sticky on his current cpu and thus stack more since he's still
in that runqueue. But that's just a mental excercise trying to
find things that are directly related to delay dequeue. No observation
other than the over all perf hit. 


> > > Bottom line, box full of 1:1 buddies pairing up and stacking in L2.
> > >
> > > tbench 8
> > > 6.1.114-cfs      3674.37 MB/sec
> > > 6.1.114-eevdf    3505.25 MB/sec -delay_dequeue
> > >                  3701.66 MB/sec +delay_dequeue
> > >
> > > For tbench, preemption = shorter turnaround = higher throughput.
> >
> > So here you have a benchmark that gets a ~5% boost from
> > delayed_dequeue.
> >
> > But I've got one that get's a 20% penalty so I'm not exactly sure what
> > to make of that. Clearly FIO does not have the same pattern as tbench.
> 
> There are basically two options in sched-land, shave fastpath cycles,
> or some variant of Rob Peter to pay Paul ;-)
>

That Peter is cranky :)

Cheers,
Phil


> 	-Mike
> 

-- 



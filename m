Return-Path: <linux-kernel+bounces-396665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D29BD042
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820301F21F6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF11D90B4;
	Tue,  5 Nov 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btW4Nx8Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1573BB21
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820025; cv=none; b=R9ZLV9tuwnSd9E0uIhpXfXmJuLiA7OqyrGbeGVnFIeDXymZdsEqPxKLjgDG5jRiKay/J/FIKUgst4IbDQRXc/vByPgFSj82g9ydJCLajPg15NO1zafmSLFN85O0doQvDBfXATutPUb9H8vUOo6bps4KcUq+IB//WESOP80X+dkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820025; c=relaxed/simple;
	bh=YanKKXkoKhuQbw+Q+AphYa/RjRvIZKnx7zdhP3E98N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3/H5B942UO0OaeBx7yBvkPSFl/oB86w/1sHEpHmE0R9JismXwkvuZuOYS5RGm5A/vzqsL0xQv7NXEN+S+aHdPXpiQ1qmX/pj2ETSunmUZGtYPg8U7z/zSXu0aUcUpB4UFdRnjTENv+90za5XmygIK5/InhkxxxeyClna9kNvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btW4Nx8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730820023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPJAWO0y3Fo1Qrzd7BTp7ngrbG856tbrQ3ZCeLlErTQ=;
	b=btW4Nx8Y1NDhLp7f4N/QO6Wc9YaMODTz+g60cKv0vw77hDQ/cN+G3DxENsN7S3V9grIVBa
	1YElWWVR5DRYFUtXOiSvmzRny+D7qFjp6C09lMwGHlP/QnhbTxQP1JB2yBg0NNho/lzLI6
	jWT9eXsKbRO/AhmpCOcghQ0OvpYe0H8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-lJnmK1AxMSC0Bw-3XCSSkg-1; Tue,
 05 Nov 2024 10:20:21 -0500
X-MC-Unique: lJnmK1AxMSC0Bw-3XCSSkg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62B0D19560A2;
	Tue,  5 Nov 2024 15:20:18 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1AC73000198;
	Tue,  5 Nov 2024 15:20:13 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:20:10 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241105152010.GA33795@pauld.westford.csb>
References: <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Nov 05, 2024 at 05:05:12AM +0100 Mike Galbraith wrote:
> On Mon, 2024-11-04 at 08:05 -0500, Phil Auld wrote:
> > On Sat, Nov 02, 2024 at 05:32:14AM +0100 Mike Galbraith wrote:
> >
> > >
> > > The buddy being preempted certainly won't be wakeup migrated...
> >
> > Not the waker who gets preempted but the wakee may be a bit more
> > sticky on his current cpu and thus stack more since he's still
> > in that runqueue.
> 
> Ah, indeed, if wakees don't get scraped off before being awakened, they
> can and do miss chances at an idle CPU according to trace_printk().
> 
> I'm undecided if overall it's boon, bane or even matters, as there is
> still an ample supply of wakeup migration, but seems it can indeed
> inject wakeup latency needlessly, so <sharpens stick>...
> 
> My box booted and neither become exceptionally noisy nor inexplicably
> silent in.. oh, minutes now, so surely yours will be perfectly fine.
> 
> After one minute of lightly loaded box browsing, trace_printk() said:
> 
>   645   - racy peek says there is a room available
>    11   - cool, reserved room is free
>   206   - no vacancy or wakee pinned
> 38807   - SIS accommodates room seeker
> 
> The below should improve the odds, but high return seems unlikely.
>

Thanks, I'll give it a spin with the nr_cpus_allowed bit.


Cheers,
Phil



> ---
>  kernel/sched/core.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3790,7 +3790,13 @@ static int ttwu_runnable(struct task_str
>  	rq = __task_rq_lock(p, &rf);
>  	if (task_on_rq_queued(p)) {
>  		update_rq_clock(rq);
> -		if (p->se.sched_delayed)
> +		/*
> +		 * If wakee is mobile and the room it reserved is occupied, let it try to migrate.
> +		 */
> +		if (p->se.sched_delayed && rq->nr_running > 1 && cpumask_weight(p->cpus_ptr) > 1) {
> +			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +			goto out_unlock;
> +		} else if (p->se.sched_delayed)
>  			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
>  		if (!task_on_cpu(rq, p)) {
>  			/*
> @@ -3802,6 +3808,7 @@ static int ttwu_runnable(struct task_str
>  		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
> +out_unlock:
>  	__task_rq_unlock(rq, &rf);
> 
>  	return ret;
> 
> 

-- 



Return-Path: <linux-kernel+bounces-414220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E99D24DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5456C1F229B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F81C7B8F;
	Tue, 19 Nov 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzIKs4Wk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB31C7B68
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015831; cv=none; b=i5hX8OnfhmfnY4YGjF0pV1b1dyjY0Zw6r8qWEVaxFjQhsrsfoHd3/86XSC/deJb9rdnWyVamzxiGzluZTWKcM+18Or7dDr+GEfnHmGXv1QgKX7NdbYQbrGI8wHlzvd8a+ABfaDcQDznqPsP1YLfywezAOjeV04tzCME9Ykr+G9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015831; c=relaxed/simple;
	bh=HIYfD8zfAQrBl1HhL53JfNeio/bRDojKsYXuYhS0iQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSpaDT6t5ayczAEqczb6Kt5ek60q4UgEypZPZmukvRTV3hXDtpkXsfFOZhFkJ1b6EdHv5VcKGMr/RoLlg/v09OZZZKNUP9IPX5ck+EVXuZX7BIRTHp75Ko1p8r0YloBwHPyalWi1fWUM3te2ZnAkV9AdiRuST43GrK6muFcye5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PzIKs4Wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732015828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2fjGCyj4ryDlTAusSmytW6XGkiOrW88eIY5tral05U=;
	b=PzIKs4WkppOYQlb6fc9iu8mjk61RWTSBP2eJnaQnojYkbgOpDCqXBkNWvY/sJrZmcNoyY7
	4hXzyK3yq5OjKaMaxXOITmVfLGid5nHyW/lcKzbCp3WOqGgLSL4WFjc9VYeSY9vRMvP54a
	UneYp6GU7s7osemAjLTLCAMKcG94jFM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-1nsoMYq7MTmuqQ4cgG7Q4Q-1; Tue,
 19 Nov 2024 06:30:25 -0500
X-MC-Unique: 1nsoMYq7MTmuqQ4cgG7Q4Q-1
X-Mimecast-MFC-AGG-ID: 1nsoMYq7MTmuqQ4cgG7Q4Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BF0219560BD;
	Tue, 19 Nov 2024 11:30:23 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.162])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C4DD30001A0;
	Tue, 19 Nov 2024 11:30:19 +0000 (UTC)
Date: Tue, 19 Nov 2024 06:30:16 -0500
From: Phil Auld <pauld@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
Message-ID: <20241119113016.GB66918@pauld.westford.csb>
References: <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114112854.GA471026@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 14, 2024 at 06:28:54AM -0500 Phil Auld wrote:
> On Thu, Nov 14, 2024 at 12:07:03PM +0100 Mike Galbraith wrote:
> > On Tue, 2024-11-12 at 17:15 +0100, Mike Galbraith wrote:
> > > On Tue, 2024-11-12 at 10:41 -0500, Phil Auld wrote:
> > > > On Tue, Nov 12, 2024 at 03:23:38PM +0100 Mike Galbraith wrote:
> > > >
> > > > >
> > > > > We don't however have to let sched_delayed block SIS though.  Rendering
> > > > > them transparent in idle_cpu() did NOT wreck the progression, so
> > > > > maaaybe could help your regression.
> > > > >
> > > >
> > > > You mean something like:
> > > >
> > > > if (rq->nr_running > rq->h_nr_delayed)
> > > >        return 0;
> > > >
> > > > in idle_cpu() instead of the straight rq->nr_running check?
> > >
> > > Yeah, close enough.
> > 
> > The below is all you need.
> > 
> > Watching blockage rate during part of a netperf scaling run without, a
> > bit over 2/sec was the highest it got, but with, that drops to the same
> > zero as turning off the feature, so... relevance highly unlikely but
> > not quite impossible?
> >
> 
> I'll give this a try on my issue. This'll be simpler than the other way.
>

This, below, by itself, did not do help and caused a small slowdown on some
other tests.  Did this need to be on top of the wakeup change? 


Cheers,
Phil

> Thanks!
> 
> 
> 
> Cheers,
> Phil
> 
> 
> > ---
> >  kernel/sched/fair.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9454,11 +9454,15 @@ int can_migrate_task(struct task_struct
> > 
> >  	/*
> >  	 * We do not migrate tasks that are:
> > +	 * 0) not runnable (not useful here/now, but are annoying), or
> >  	 * 1) throttled_lb_pair, or
> >  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> >  	 * 3) running (obviously), or
> >  	 * 4) are cache-hot on their current CPU.
> >  	 */
> > +	if (p->se.sched_delayed)
> > +		return 0;
> > +
> >  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
> >  		return 0;
> > 
> > 
> 
> -- 
> 
> 

-- 



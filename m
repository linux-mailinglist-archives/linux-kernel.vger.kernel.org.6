Return-Path: <linux-kernel+bounces-406208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A719C5C21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A72281250
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE902022E8;
	Tue, 12 Nov 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cu7yK5F5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB72022E2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426114; cv=none; b=mi784hlbpkFi6nbSuoWb1aL8yt8yMeY2xc0vyuNUPAXwVOL1FGyRZs1px7xQzh/p/UFLBh4Mkwon/p8Z8DNLgUQO/JwVWi/mxilTpCrc+4Uj69YgEQNLmLQyyCNNMNqQfubKtzTriBPC2+B/k82yCIXHVdFRu/47wH4vrMhMzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426114; c=relaxed/simple;
	bh=uSrW4t6IKjnqEPXYnVBZWhB3u+gDFiNQ/agbI7pg8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+OugLvwq5JOgmYt2AuVsL9Mu448qPZADjKF2KtEqPwXfjRH5e6dJ59rJ6gWRkSZF0JKgPzfuPw0b3x4R4GztW4okibeO4w12TJvCmCfg1uLlJshjxgoofbkoXAeGEQl+kq/TNmHl8a2YO8nDdbXtVV7+BOBEC18StQao3NRBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cu7yK5F5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731426111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5avPtTuYjpQfGNJRl2rioE99ijWM/9jPzTcZajUUx4=;
	b=cu7yK5F5qf9qOdH5UxgLbLtJaWH8UagacQU5Hy4gs8CMZby5yaD3z1BqyuHjAi2+w6P1oC
	0dfCViSxfMEUzQHTXx9EJHjlahBn9U128JMcfh0TcqkUTkgEq3OGBcAwtrcmzO5Ua+n96e
	0Fj7tU6cS49Uq69UsPe4BBW+fvev/6M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-OJ6wSUJvNdKMAwDs0zYd0g-1; Tue,
 12 Nov 2024 10:41:50 -0500
X-MC-Unique: OJ6wSUJvNdKMAwDs0zYd0g-1
X-Mimecast-MFC-AGG-ID: OJ6wSUJvNdKMAwDs0zYd0g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BE911955D52;
	Tue, 12 Nov 2024 15:41:47 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 532701956052;
	Tue, 12 Nov 2024 15:41:43 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:41:40 -0500
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
Message-ID: <20241112154140.GC336451@pauld.westford.csb>
References: <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Nov 12, 2024 at 03:23:38PM +0100 Mike Galbraith wrote:
> On Tue, 2024-11-12 at 07:41 -0500, Phil Auld wrote:
> > On Tue, Nov 12, 2024 at 08:05:04AM +0100 Mike Galbraith wrote:
> > >
> > > Unfortunate change log place holder below aside, I think this patch may
> > > need to be yanked as trading one not readily repeatable regression for
> > > at least one that definitely is, and likely multiple others.
> > >
> > > (adds knob)
> > >
> >
> > Yes, I ws just coming here to reply. I have the results from the first
> > version of the patch (I don't think the later one fundemtally changed
> > enough that it will matter but those results are still pending).
> >
> > Not entirely surprisingly we've traded a ~10% rand write regression for
> > 5-10% rand read regression. This makes sense to me since the reads are
> > more likely to be synchronous and thus be more buddy-like and benefit
> > from flipping back and forth on the same cpu. 
> 
> Ok, that would seem to second "shoot it".
>

Yes, drop it please, I think. Thanks!


> > I'd probably have to take the reads over the writes in such a trade off :)
> >
> > > tbench 8
> > >
> > > NO_MIGRATE_DELAYED    3613.49 MB/sec
> > > MIGRATE_DELAYED       3145.59 MB/sec
> > > NO_DELAY_DEQUEUE      3355.42 MB/sec
> > >
> > > First line is DELAY_DEQUEUE restoring pre-EEVDF tbench throughput as
> > > I've mentioned it doing, but $subject promptly did away with that and
> > > then some.
> > >
> >
> > Yep, that's not pretty.
> 
> Yeah, not to mention annoying.
> 
> I get the "adds bounce cache pain" aspect, but not why pre-EEVDF
> wouldn't be just as heavily affected, it having nothing blocking high
> frequency migration (the eternal scheduler boogieman:).
> 
> Bottom line would appear to be that these survivors should be left
> where they ended up, either due to LB or more likely bog standard
> prev_cpu locality, for they are part and parcel of a progression.
> 
> > > I thought I might be able to do away with the reservation like side
> > > effect of DELAY_DEQUEUE by borrowing h_nr_delayed from...
> > >
> > >      sched/eevdf: More PELT vs DELAYED_DEQUEUE
> > >
> > > ...for cgroups free test config, but Q/D poke at idle_cpu() helped not
> > > at all.
> 
> We don't however have to let sched_delayed block SIS though.  Rendering
> them transparent in idle_cpu() did NOT wreck the progression, so
> maaaybe could help your regression.
>

You mean something like:

if (rq->nr_running > rq->h_nr_delayed)
       return 0;

in idle_cpu() instead of the straight rq->nr_running check? I don't
have the h_nr_delayed stuff yet but can look for it.  I'm not sure
that will help with the delayees being sticky.  But I can try to try
that if I'm understanding you right.

I'll try to dig into it some more regardless.

> > I wonder if the last_wakee stuff could be leveraged here (an idle thought,
> > so to speak). Haven't looked closely enough.
> 
> If you mean heuristics, the less of those we have, the better off we
> are.. they _always_ find a way to embed their teeth in your backside.
>

Sure, I get that. But when you have a trade-off like this being "smarter"
about when to do the dequeue might help. But yes, that could go wrong.

I'm not a fan of knobs either but we could do your patch with the feat
and default it off.


Cheers,
Phil

> 	-Mike
> 

-- 



Return-Path: <linux-kernel+bounces-179753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE138C64D4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644801F24906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12315B5B6;
	Wed, 15 May 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bBwWGOTa"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF55E060
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768013; cv=none; b=piYcsU2oNFsudGVd2x6SMGMNjlnwRNiCBwcixrEd9h1BSga3S/gxs8iJ/zD6ifwflyhhb/ATJmoFum9nl1iDoSN7B5D5kWvIwj4L042YvqIUKUt2uh+1JPZLToDsae4Td5gjLV+Nqp9P7huu6+dMcIUi0H6Vztaenq/zrZ48OoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768013; c=relaxed/simple;
	bh=R6J+n8cvzciTSGKGyfNyOmGXlBPHb1xLPxZyrsPKKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsG22Qyw2DttIK7Zn7kwA6SoHMCj0zb7oBEjssXPDZ82Elp++7AOAUkvJMijWKoDK7XawPz1nex3rSHKO15LWB6jOlgZE79Ip1mVq1IF02dP/hN9LQLjOjrfZQF/Zh7N8asrjo7qkaQYBlivqofmij4BpRtpfo9OsWWmH13gV8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bBwWGOTa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=yn9PlzEiI+jV2QEzgMElYky/iSJE+k1yDY6cuWJfOs4=; b=bBwWGOTal7ohbcYX6S0ZTRpfjn
	Vs1kwtXl5DQxomNJruot7h/WB0xz0G8hX9LNt49xlJ5NAYYkTj5tCzLDEZH/qKZwv6tNfHyS0hycU
	i2UR7sg5WUMxxsZP3u4VpYn4svMno+yfC9DVGXAPl040gKoB+83oGmQIFmbudvfal8Q+eOGIsKnCs
	0bXICyZw5c0ZNWzqV4evWdHe3m/5IBN9+ARZVfj62+ezYJLWW3rkJ++6MGGkteWgwLkmKPTjdCifb
	rNm10OKs7etrvF2qCNisr8W4jazXuCXdfI3kPGEnXOty6Dtik9CiGfViE5pScLOmdny+umRd1ygp3
	jQ3LpAng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7BdE-000000053lQ-3b0U;
	Wed, 15 May 2024 10:13:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DDD583005E3; Wed, 15 May 2024 12:13:05 +0200 (CEST)
Date: Wed, 15 May 2024 12:13:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <20240515101305.GG40213@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
 <22b6408d96ce3913121a4a1b80f343657d1f66ae.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b6408d96ce3913121a4a1b80f343657d1f66ae.camel@gmx.de>

On Tue, May 07, 2024 at 07:34:54AM +0200, Mike Galbraith wrote:
> On Fri, 2024-04-05 at 12:28 +0200, Peter Zijlstra wrote:
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7812,7 +7823,9 @@ static int __sched_setscheduler(struct t
> >          * but store a possible modification of reset_on_fork.
> >          */
> >         if (unlikely(policy == p->policy)) {
> > -               if (fair_policy(policy) && attr->sched_nice != task_nice(p))
> > +               if (fair_policy(policy) &&
> > +                   (attr->sched_nice != task_nice(p) ||
> > +                    (attr->sched_runtime && attr->sched_runtime != p->se.slice)))
> >                         goto change;
> 
> Can we make that only look at attr->sched_runtime != p->se.slice? 
> Doing so lets you clear a custom slice by.. clearing it.. rather than
> making tools rummage about for the proper value to overwrite.

Duh yes. Seems I already did the right thing in __setscheduler_params()
for that.

Done.


Return-Path: <linux-kernel+bounces-317335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2D96DCA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703E71F246C6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78219E7D0;
	Thu,  5 Sep 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gR9bcvWG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD76E614
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548054; cv=none; b=JMuo1nofzYd5AJg41QY4dowbyyCr1jgDsJyprft1ED1iN9AxmV+l2jLWpJMyqR9uCpaq0Eoez30YrpJVCD+Dr0a8krh8W+6nswSdvAIQ0FVyFgaSRwd5ispkVpycZ9XJr1w07cuKnCorZPPrefRZjd2SxzvxIYEQ3ULEtdu3hy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548054; c=relaxed/simple;
	bh=QITvcxupEaJRmjBvAUQYWATD8JWquvWC4j/tYXl3El4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np2JDk3IdFkeCBlRz8ECYmtrAE2Dm5Un5W1DVXPQFrLTR+x5m2vFFjBiFXp1gnW6LSPSbFZkMH7vb98Gc4FO/bQJeZY2PygHhuHzKhSYy1lLGJksNdrb7Si/lHyz9Y2IwUtPG58cc2aA9YalC4wC63VoG0f/UDh0zJ2aO+B9Sj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gR9bcvWG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Udk+uEfHxTbOF+jAUIi5L/lDLCyIKseLghSVqL0zesY=; b=gR9bcvWGrTyDVg0SEbfXvfE4eU
	LXHGZBRz6OMRLX+f93skm+dbOIHBTbpy9+secqM/QhvuLAG+7a/00k8YZz2jEqCFseqGgkrl+LPW8
	0vP8pwFDhgLzhixopvDb3p5mVkRJwahPpVGbKjUkYNM1oPCZTS7mXehS0B+tck1d8tnnqUBylhaYx
	Ejn86ifUECS4vYKYAvbnDv07hPNTYod5h3dsU0OrPGqPgWJR/IzuzQa4F9qvHjAU6N96IaPmJ8gG/
	SFvCO9Wq2PYcOGVxAqE0VLmQVimSbBKTuaMkfQ2cUcNJ1rrcangfc9fUApd15P+vJyrpQcQmEXDT4
	fU5pmpDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smDrv-00000000V9u-1jmg;
	Thu, 05 Sep 2024 14:53:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C75C5300599; Thu,  5 Sep 2024 16:53:54 +0200 (CEST)
Date: Thu, 5 Sep 2024 16:53:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Luis Machado <luis.machado@arm.com>, mingo@redhat.com,
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Message-ID: <20240905145354.GP4723@noisy.programming.kicks-ass.net>
References: <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>

On Thu, Sep 05, 2024 at 04:07:01PM +0200, Dietmar Eggemann wrote:

> > Unfortunately, this is not only about util_est
> > 
> > cfs_rq's runnable_avg is also wrong  because we normally have :
> > cfs_rq's runnable_avg == /Sum se's runnable_avg
> > but cfs_rq's runnable_avg uses cfs_rq's h_nr_running but delayed
> > entities are still accounted in h_nr_running
> 
> Yes, I agree.
> 
> se's runnable_avg should be fine already since:
> 
> se_runnable()
> 
>   if (se->sched_delayed)
>     return false
> 
> But then, like you said, __update_load_avg_cfs_rq() needs correct
> cfs_rq->h_nr_running.

Uff. So yes __update_load_avg_cfs_rq() needs a different number, but
I'll contest that h_nr_running is in fact correct, albeit no longer
suitable for this purpose.

We can track h_nr_delayed I suppose, and subtract that.

> And I guess we need something like:
> 
> se_on_rq()
> 
>   if (se->sched_delayed)
>     return false
> 
> for
> 
> __update_load_avg_se()
> 
> - if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
> + if (___update_load_sum(now, &se->avg, se_on_rq(se), se_runnable(se),
> 
> 
> My hope was we can fix util_est independently since it drives CPU
> frequency. Whereas PELT load_avg and runnable_avg are "only" used for
> load balancing. But I agree, it has to be fixed as well.
> 
> > That also means that cfs_rq's h_nr_running is not accurate anymore
> > because it includes delayed dequeue
> 
> +1
> 
> > and cfs_rq load_avg is kept artificially high which biases
> > load_balance and cgroup's shares
> 
> +1

Again, fundamentally the delayed tasks are delayed because they need to
remain part of the competition in order to 'earn' time. It really is
fully on_rq, and should be for the purpose of load and load-balancing.

It is only special in that it will never run again (until it gets
woken).

Consider (2 CPUs, 4 tasks):

  CPU1		CPU2
   A		 D
   B (delayed)
   C

Then migrating any one of the tasks on CPU1 to CPU2 will make them all
earn time at 1/2 instead of 1/3 vs 1/1. More fair etc.

Yes, I realize this might seem weird, but we're going to be getting a
ton more of this weirdness once proxy execution lands, then we'll be
having the entire block chain still on the runqueue (and actually
consuming time).


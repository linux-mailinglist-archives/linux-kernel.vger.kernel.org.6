Return-Path: <linux-kernel+bounces-315080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A696BDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F6D1F26A05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8969F1DB554;
	Wed,  4 Sep 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEZW5b4D"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E071DA2F4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455109; cv=none; b=YnCHgGKOW0HEkYmyy34bzHM2WD/w1TWa222qJjSz/bKqciE9aeaf7AeLKoW9zbc0cep2Uyw04mlGKOxySn2W7bPQo4VDrpHCOUYWAXY3o/H7R2kcbCCuWnekV6gERt1L6Aq11yAgFxyEDJOsz6zBlIZ1dmwYQn225GyTmsz8Dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455109; c=relaxed/simple;
	bh=fZwVu2iLRzQuC1iju770p0KrMULv6OcHWPT2GzV7uNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLQ/acJHA/abBaWIJSkE9SVrwzg1YL13vEXWtWwbHe7cGuVvhELssuQ6c/4iGRHfq5LoT6sw1UAtfQnocKitgnS0iavwG2EEClL91m0RpbofkjNn6r2dpjfTM9nJhpHMFZSbaBB+Y58zL8xePNulfvuUwWrO8WJcjVJHzJJM5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PEZW5b4D; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kvJgXq1ZQLyV19nA6XMExctPmbJmHmdvCwA+9KF9hb8=; b=PEZW5b4Due09LvMJ/K1UILnuF/
	J2f32lxh6gzvmyTAKhJr39tyKJk2oYP81AgmQBiiUpT4ypGqNqCI3uxk3H/PsRJBYf9pPfK8NOkfR
	cR39Qktg1/48bxI14nWx4SOMLX9frT3+hh4H2A2j/NC23AtQGYiKgBEFEMSgfPjxMO/nP9VvOrO8r
	Q0/qoSC181+y7gvdwHHOco72C7bB7e6z4BWgA6Czrndye6rXUYNUjpF3Imce/rSwWdf/93G7aGp71
	pS9hRoITqP2zOBTcbfFmn+SzXGxExX1D+32I07EO2o1mMYpN87Q4kjsYCtRVToVQN0hKf9IjxWEv2
	ICDAClYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slpgk-00000000Dtl-0ruW;
	Wed, 04 Sep 2024 13:04:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2FD28300642; Wed,  4 Sep 2024 15:04:45 +0200 (CEST)
Date: Wed, 4 Sep 2024 15:04:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <20240904130445.GI4723@noisy.programming.kicks-ass.net>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
 <ZthWKgK9B_AUqSs1@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZthWKgK9B_AUqSs1@localhost.localdomain>

On Wed, Sep 04, 2024 at 02:44:26PM +0200, Frederic Weisbecker wrote:
> Le Tue, Sep 03, 2024 at 09:23:53PM -0400, Waiman Long a écrit :
> > > After discussing with Peter lately, the rules should be:
> > > 
> > > 1) If a nohz_full CPU is part of a multi-CPU domain, then it should
> > >     be part of load balancing. Peter even says that nohz_full should be
> > >     forbidden in this case, because the tick plays a role in the
> > >     load balancing.
> > 
> > My understand is that most users will use nohz_full together with isolcpus.
> > So nohz_full CPUs are also isolated and not in a sched domain. There may
> > still be user setting nohz_full without isolcpus though, but that should be
> > relatively rare.
> 
> Apparently there are users wanting to use isolation along with automatic
> containers deployments such as kubernetes, which doesn't seem to work
> well with isolcpus...

I've been proposing to get rid of isolcpus for at least the last 15
years or so. There just isn't a good reason to ever use it. We were
close and then the whole NOHZ_FULL thing came along.

You can create single CPU partitions using cpusets dynamically.

> > Anyway, all these nohz_full/kernel_nose setting will only apply to CPUs in
> > isolated cpuset partitions which will not be in a sched domain.
> > 
> > > 
> > > 2) Otherwise, if CPU is not part of a domain or it is the only CPU of all its
> > >     domains, then it can be out of the load balancing machinery.
> > I am aware that a single-cpu domain is the same as being isolated with no
> > load balancing.
> 
> By the way is it possible to have a single-cpu domain (sorry I'm a noob here)
> or do such CPU always end up on a null domain?

IIRC they always end up with the null domain; but its been a while. It
simply doesn't make much sense to have a 1 cpu domain. The way the
topology code works is by always building the full domain tree, and then
throwing away all levels that do not contribute, and in the 1 cpu case,
that would be all of them.

Look for 'degenerate' in kernel/sched/topology.c.

> > > 
> > > I'm a bit scared about rule 1) because I know there are existing users of
> > > nohz_full on multi-CPU domains... So I feel a bit trapped.
> > 
> > As stated before, this is not a common use case.
> 
> Not sure and anyway it's not a forbidden usecase. But this is anyway outside
> the scope of this patchset.

Most crucially, it is a completely broken setup. It doesn't actually
work well.

Taking it away will force people to fix their broken. That's a good
thing, no?

> > The isolcpus boot option is deprecated, as stated in kernel-parameters.txt.
> 
> We should undeprecate it, apparently it's still widely used. Perhaps by people
> who can't afford to use cpusets/cgroups.

What is the actual problem with using cpusets? At the very least the
whole nohz_full thing needs to be moved into cpusets so it isn't a fixed
boot time thing anymore.

> > My plan is to deprecate nohz_full as well once we are able to make dynamic
> > CPU isolation via cpuset works almost as good as isolcpus + nohz_full.
> 
> You can't really deprecate such a kernel boot option unfortunately. Believe me
> I wish we could.

Why not? As I said, the only thing that's kept it around, and worse,
made it more popular again, is this nohz_full nonsense. That never
should've used isolcpus, but that's not something we can do anything
about now.

Rigid, boot time only things are teh suck.


Return-Path: <linux-kernel+bounces-318869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F596F460
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC21C233D9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8B31CC897;
	Fri,  6 Sep 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2QLrCDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D21A4E6E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626220; cv=none; b=Z+YCWZuBfXtwKqnVWa9mgmmqkh04xHEWXFIAw/dBPXUZzrF3KTnTBA0YDhq9CmL0Uyqm7aMymvKvSN8MQKkOsRhzoT3hzUigPKVsRSohBwsn0zv+gMmr5TE3h4nY/KULi2YAUDOUXSzqpkF/6HuZb3cep/Vm5iyzz6tLsMn0zpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626220; c=relaxed/simple;
	bh=tJ9daY7WGj0ycxrojbLCpIa6HPeBgYgJObTvkAZ1yDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkdKJJ4Y5Mw40G1IghAWCsBfAD1F66lKgaFSaj9WkgNkMqDlFp6WYta5RZuOAhNnck6Tb+z5Dl6+0lewwWfHAAe867RM6QvR5KD8jtVSbcwgJsdLtOBz7oAFs9d7w1YY/MU7h3gXD4jnczf6oylU+b24kjCxaxGkjLa4Gcw15eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2QLrCDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C7EC4CEC7;
	Fri,  6 Sep 2024 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725626219;
	bh=tJ9daY7WGj0ycxrojbLCpIa6HPeBgYgJObTvkAZ1yDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2QLrCDmMzLSNe5ilBgAQtx2I77NBNaxen3D1zOOhkbp+RXNVlMZfbw5+rzDZ5iEz
	 m3dTp7FCjuEJBSI9vHZGApiGRMfKOWL79xEjxVzREO7/VXqYCSz6t+OsN6Juyh702s
	 soHEfg8Ed6T0PmlxUV5AQyr5ZpdRq+YmjnpPZcJimbAlvIvPKUItZwhyIgriC6NUYn
	 y6Vq6ky0o3zYNbzhiAYZqJoWi0/D1uBnUhfXXEdiS5LDzhq7P4YrbBkm7kQCtQ3puz
	 tbNRKX8Fd5ZmixojkamuL5h4hAwx8W2/8WxyUUtYSmm4JK9/BRJSpDsC9s7yz/hhQb
	 H2N0BzA4nkysw==
Date: Fri, 6 Sep 2024 14:36:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <Ztr3aP7GId1yoDKx@pavilion.home>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
 <ZthWKgK9B_AUqSs1@localhost.localdomain>
 <20240904130445.GI4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240904130445.GI4723@noisy.programming.kicks-ass.net>

Le Wed, Sep 04, 2024 at 03:04:45PM +0200, Peter Zijlstra a écrit :
> On Wed, Sep 04, 2024 at 02:44:26PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Sep 03, 2024 at 09:23:53PM -0400, Waiman Long a écrit :
> > > > After discussing with Peter lately, the rules should be:
> > > > 
> > > > 1) If a nohz_full CPU is part of a multi-CPU domain, then it should
> > > >     be part of load balancing. Peter even says that nohz_full should be
> > > >     forbidden in this case, because the tick plays a role in the
> > > >     load balancing.
> > > 
> > > My understand is that most users will use nohz_full together with isolcpus.
> > > So nohz_full CPUs are also isolated and not in a sched domain. There may
> > > still be user setting nohz_full without isolcpus though, but that should be
> > > relatively rare.
> > 
> > Apparently there are users wanting to use isolation along with automatic
> > containers deployments such as kubernetes, which doesn't seem to work
> > well with isolcpus...
> 
> I've been proposing to get rid of isolcpus for at least the last 15
> years or so. There just isn't a good reason to ever use it. We were
> close and then the whole NOHZ_FULL thing came along.
> 
> You can create single CPU partitions using cpusets dynamically.

I'm not sure we could have removed isolcpus= even back then.
It has always been widely used and we would have broke someone's box.

> 
> > > Anyway, all these nohz_full/kernel_nose setting will only apply to CPUs in
> > > isolated cpuset partitions which will not be in a sched domain.
> > > 
> > > > 
> > > > 2) Otherwise, if CPU is not part of a domain or it is the only CPU of all its
> > > >     domains, then it can be out of the load balancing machinery.
> > > I am aware that a single-cpu domain is the same as being isolated with no
> > > load balancing.
> > 
> > By the way is it possible to have a single-cpu domain (sorry I'm a noob here)
> > or do such CPU always end up on a null domain?
> 
> IIRC they always end up with the null domain; but its been a while. It
> simply doesn't make much sense to have a 1 cpu domain. The way the
> topology code works is by always building the full domain tree, and then
> throwing away all levels that do not contribute, and in the 1 cpu case,
> that would be all of them.
> 
> Look for 'degenerate' in kernel/sched/topology.c.

Ok.

> 
> > > > 
> > > > I'm a bit scared about rule 1) because I know there are existing users of
> > > > nohz_full on multi-CPU domains... So I feel a bit trapped.
> > > 
> > > As stated before, this is not a common use case.
> > 
> > Not sure and anyway it's not a forbidden usecase. But this is anyway outside
> > the scope of this patchset.
> 
> Most crucially, it is a completely broken setup. It doesn't actually
> work well.
> 
> Taking it away will force people to fix their broken. That's a good
> thing, no?

I'm all for it but isn't the rule not to break userspace?

> 
> > > The isolcpus boot option is deprecated, as stated in kernel-parameters.txt.
> > 
> > We should undeprecate it, apparently it's still widely used. Perhaps by people
> > who can't afford to use cpusets/cgroups.
> 
> What is the actual problem with using cpusets? At the very least the
> whole nohz_full thing needs to be moved into cpusets so it isn't a fixed
> boot time thing anymore.

Sure that's the plan.

> 
> > > My plan is to deprecate nohz_full as well once we are able to make dynamic
> > > CPU isolation via cpuset works almost as good as isolcpus + nohz_full.
> > 
> > You can't really deprecate such a kernel boot option unfortunately. Believe me
> > I wish we could.
> 
> Why not? As I said, the only thing that's kept it around, and worse,
> made it more popular again, is this nohz_full nonsense. That never
> should've used isolcpus, but that's not something we can do anything
> about now.
> 
> Rigid, boot time only things are teh suck.

I know...

Thanks.


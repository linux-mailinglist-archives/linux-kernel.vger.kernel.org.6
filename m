Return-Path: <linux-kernel+bounces-315186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591BE96BEFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630521C2533D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2D1DA610;
	Wed,  4 Sep 2024 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abFv7nKG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022C1DB548
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457488; cv=none; b=dF3+AxZG7QDilkhVaT/+y3dh1tWthTMStB9IWm6HUOVYLlIBhTVaGBIoWxKpN25pPtXeF34sqIkGDb9XbrT1O7xeCX9XCy3DLKTDQCYtpi9U7QwJwGxqusu5Owh0ISswsNXAx8S5H7Z13IENOG2NT+DlCGF024DyAVwjq7ugAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457488; c=relaxed/simple;
	bh=9W+H3sK+qBXC42b9qhZvTLHS+cK/ZwCSFEOjhQbiNiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBel3dGQ2Q86ElJfCTudJ9Ef5z1tIoZHPONucEkN76b+odjchPnxGFbH2mL8kbF+x/pMH6LkStPfGucl0mHFxHhXs9zG2XJoj5qlpRPS+HQgXHJJ41AJJzOKNPgC7/4g2NIRLEDgk4UD2iBeYENjKKTOt0zx27JmyS2s0n8Y1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abFv7nKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725457485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxoz+cH6a7qI3Ft7IssyU8SelLVMkevfr8pMNuCOV7Q=;
	b=abFv7nKGR7+n3s3edg6+jy+C4G0HR4IaC2KsDzelBUE8SioqENiiPiBzqfWIsRaVWfV0cs
	yUZJFWlBAUW7BWckB11XM4Ax/XFf4Ucle3sT4AVDEgf4Bn+hrN+b+VW85gKSw9yZCnwoya
	gfxFfOMFK8QrvLX4GBRIS4sJ7oADTjc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-7bH5f9lOPneJ7Bhfh3bk0g-1; Wed,
 04 Sep 2024 09:44:40 -0400
X-MC-Unique: 7bH5f9lOPneJ7Bhfh3bk0g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 647BB1955D5A;
	Wed,  4 Sep 2024 13:44:37 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.39.194.241])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 056B91956086;
	Wed,  4 Sep 2024 13:44:31 +0000 (UTC)
Date: Wed, 4 Sep 2024 09:44:27 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <20240904134427.GA136544@pauld.westford.csb>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


Throwing my 2 cents in ...

On Wed, Sep 04, 2024 at 03:04:45PM +0200 Peter Zijlstra wrote:
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

Definitely this ^^^

> I've been proposing to get rid of isolcpus for at least the last 15
> years or so. There just isn't a good reason to ever use it. We were
> close and then the whole NOHZ_FULL thing came along.
> 
> You can create single CPU partitions using cpusets dynamically.
>

This is somewhat new though...   Although you could turn off load balancing with
groups v1, in v2 you could not. 


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
>

I wonder if people using nohz_full full w/o isolcpus is a bit of a historical
artifact.  It used to be the case that you could use nohz and then turn off load
balancing from userspace using the domain flags.  That allowed it to work w/o
isolcpus. When that ability was removed isolcpus often had to be used as a
replacement. Probably accounts for some of its increased use. 

It takes a while for all of these changes to bubble up and get used by the
layers above. It's generally not download and build the new kernel and adjust
your configuration settings and scripts :)


> > > The isolcpus boot option is deprecated, as stated in kernel-parameters.txt.
> > 
> > We should undeprecate it, apparently it's still widely used. Perhaps by people
> > who can't afford to use cpusets/cgroups.
> 
> What is the actual problem with using cpusets? At the very least the
> whole nohz_full thing needs to be moved into cpusets so it isn't a fixed
> boot time thing anymore.

Until fairly recently you could not do the isolation with cgroups v2.

I agree with the direction Waiman et al. are heading. Getting rid of the
kernel commandline settings for this is a good thing.

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

Deprecate-and-not-remove should be fine. Then in 15 years we can revisit it
like isolcpus ;)

Cheers,
Phil


> 
> Rigid, boot time only things are teh suck.
>


-- 



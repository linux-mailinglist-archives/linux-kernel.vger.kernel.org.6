Return-Path: <linux-kernel+bounces-524123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC7A3DF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F13700F98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372751F9ED2;
	Thu, 20 Feb 2025 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmEBz/mi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BD8F5B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066764; cv=none; b=Rq3Doio6N6d+0TaMA0I+DcuRf4v1EoxuewG15zk8rRHo83YcyPO3MYPMAtyucVoTHSc7eZq/W0McIO928NagJQDplce/1m8KU7w0OExEb4N+2nTTYvWdMMxwWxIYM1TDZWJTMnxWxoo6+zIluwn4rdCd43BaP+HddxYtj6Qbc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066764; c=relaxed/simple;
	bh=nqMLoYyUSVteUWyDESp588+OG8stwgoB6g2nzJC/p08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmP83BT44NWMjNF9JEDO28mhvzPDcMre3NomyQnr/EU/2/UHgfjGGoY8WZs5LBSINVcywWHWH6l3qE3FJY6KCAdGhx5mi3rMlvBZ2IC5RklATLV1Z2ajBgICEfFumG/rykNJbw+JQDMWeY4TMylNemPoz/T3WtCQGwHQ/93dDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmEBz/mi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740066760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXixf/+e+DbNzE964SK6i49ancXo4iPqgPiTeOrCAsc=;
	b=cmEBz/miRYA/FqknuaI6TtjNBlT6nhpITtQgqu2jOiSZ/0zmW1OftM28KK2diA/nJ49iHT
	3hneWRCI3q+alTLBcMB8rf/6Eu3g5svG+ypDUIBz31IzoVMtqh4Qu2mawA2QKjv81XFPMx
	XVsvd38i1MzyzA62BW6GLgdnwuVh0j8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-bKOnWXlBNDqNLJT5yxcJGg-1; Thu,
 20 Feb 2025 10:52:35 -0500
X-MC-Unique: bKOnWXlBNDqNLJT5yxcJGg-1
X-Mimecast-MFC-AGG-ID: bKOnWXlBNDqNLJT5yxcJGg_1740066754
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BF0A1801A10;
	Thu, 20 Feb 2025 15:52:34 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.224])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 823281800D96;
	Thu, 20 Feb 2025 15:52:32 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:52:29 -0500
From: Phil Auld <pauld@redhat.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250220155229.GB89684@pauld.westford.csb>
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb>
 <Z67Wy9Jjn0BZa01A@linux.ibm.com>
 <20250218150059.GC547103@pauld.westford.csb>
 <Z7bz6ECsSfpcqqkc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7bz6ECsSfpcqqkc@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


Hi Vishal,

On Thu, Feb 20, 2025 at 02:50:40PM +0530 Vishal Chourasia wrote:
> On Tue, Feb 18, 2025 at 10:00:59AM -0500, Phil Auld wrote:
> > Hi Vishal.
> > 
> > On Fri, Feb 14, 2025 at 11:08:19AM +0530 Vishal Chourasia wrote:
> > > Hi Phil, Vineeth
> > > 
> > > On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
> > > > On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
> > > > > Hi Phil Auld,
> > > > > 
> > > > > On 11/02/25 19:31, Phil Auld wrote:
> > > > > > The exising code uses housekeeping_any_cpu() to select a cpu for
> > > > > > a given housekeeping task. However, this often ends up calling
> > > > > > cpumask_any_and() which is defined as cpumask_first_and() which has
> > > > > > the effect of alyways using the first cpu among those available.
> > > > > > 
> > > > > > The same applies when multiple NUMA nodes are involved. In that
> > > > > > case the first cpu in the local node is chosen which does provide
> > > > > > a bit of spreading but with multiple HK cpus per node the same
> > > > > > issues arise.
> > > > > > 
> > > > > > Spread the HK work out by having housekeeping_any_cpu() and
> > > > > > sched_numa_find_closest() use cpumask_any_and_distribute()
> > > > > > instead of cpumask_any_and().
> > > > > > 
> > > > > 
> > > > > Got the overall intent of the patch for better load distribution on
> > > > > housekeeping tasks. However, one potential drawback could be that by
> > > > > spreading HK work across multiple CPUs might reduce the time that
> > > > > some cores can spend in deeper idle states which can be beneficial for
> > > > > power-sensitive systems.
> > > > > 
> > > > > Thoughts?
> > > > 
> > > > NOHZ_full setups are not generally used in power sensitive systems I think.
> > > > They aren't in our use cases at least. 
> > > > 
> > > > In cases with many cpus a single housekeeping cpu can not keep up. Having
> > > > other HK cpus in deep idle states while the one in use is overloaded is
> > > > not a win. 
> > > 
> > > To me, an overloaded CPU sounds like where more than one tasks are ready
> > > to run, and a HK CPU is one receiving periodic scheduling clock
> > > ticks, so HP CPU is bound to comes out of any power-saving state it is in.
> > 
> > If the overload is caused by HK and interrupts there is nothing in the
> > system to help. Tasks, sure, can get load balanced.
> > 
> > And as you say, the HK cpus will have generally ticks happening anyway.
> > 
> > > > 
> > > > If your single HK cpu can keep up then only configure that one HK cpu.
> > > > The others will go idle and stay there.  And since they are nohz_full
> > > > might get to stay idle even longer.
> > > While it is good to distribute the load across each HK CPU in the HK 
> > > cpumask (queuing jobs on different CPUs each time), this can cause
> > > jitter in virtualized environments. Unnecessaryily evicting other
> > > tenants, when it's better to overload a VP than to wake up other VPs of a
> > > tenant.
> > > 
> > 
> > Sorry I'm not sure I understand your setup. Are your running virtual
> > tenants on the HK cpus?  nohz_full in the guests? Maybe you only need
> > on HK then it won't matter.
> > 
> Firstly, I am unaware if nohz_full is being used in virtualized environment.
> Please correct me it is. I am not saying it can't or shouldn't be used, it's just
> I don't know if anybody is using it.
>

I've seen some people trying it in various ways and to varying degrees of
success if I recall correctly.


> nohz_full in guests would mean that tick is disabled inside the guest but
> the host might still be getting ticks. So, I am unsure, whether it is a good
> idea to have nohz_full in virtualized environment.
> 
> Nevertheless, the idea of nohz_full is to reduce to the kernel interference
> for CPUs marked as nohz_full. And, it does help with guest interference.
> 
> I would like to mention, In SPLPAR environment, scheduling work on
> different HK CPU each time can caused VM preemption in a multi-tenant
> setup in cases where CPUs in HK cpumask spans across VPs, its better to
> consolidate them within few VPs.
> 
> VP is virtual core/processor.

I have a hard time reconciling you saying you are not using virtualization
and then talking about VMs and VPs ;)

Sometimes I forget how interesting PPC can be...

> 
> > My concern is that currently there is no point in having more than
> > one HK cpu (per node in a NUMA case). The code as currently implemented
> > is just not doing what it needs to.
> > 
> > We have numerous cases where a single HK cpu just cannot keep up and
> > the remote_tick warning fires. It also can lead to the other things
> > (orchastration sw, HA keepalives etc) on the HK cpus getting starved
> > which leads to other issues.  In these cases we recommend increasing
> > the number of HK cpus.  But... that only helps the userspace tasks
> > somewhat. It does not help the actual housekeeping part.
> > 
> > It seems clear to me that the intent of the cpumask_any_and() calls
> > is to pick _any_ cpu in the hk mask. Not just the first, otherwise
> > it would just use cpumask_first_and().
> > 
> > I'm open to alternate suggestions of how to fix this.
> Your approach looks good to me.
> 
> I wanted to mention the case of overcommitted multi-tenant setup
> where this will cause noisy neighbour sort of situation, but this can be
> avoided by carefully selecting HK CPUs.

Yes, it can be configured away, hopefully.

Still, this could easily be a sched feat if that make sense to people.


Thanks for the review!


Cheers,
Phil



> 
> Thanks,
> vishalc
> > 
> > 
> > Cheers,
> > Phil
> > 
> > > > 
> > > > I do have a patch that has this controlled by a sched feature if that
> > > > is of interest. Then it could be disabled if you don't want it.
> > > 
> > > Vishal
> > > > 
> > > > Cheers,
> > > > Phil
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Madadi Vineeth Reddy
> > > > > 
> > > > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > Cc: Waiman Long <longman@redhat.com>
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > ---
> > > > > >  kernel/sched/isolation.c | 2 +-
> > > > > >  kernel/sched/topology.c  | 2 +-
> > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > > > > index 81bc8b329ef1..93b038d48900 100644
> > > > > > --- a/kernel/sched/isolation.c
> > > > > > +++ b/kernel/sched/isolation.c
> > > > > > @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
> > > > > >  			if (cpu < nr_cpu_ids)
> > > > > >  				return cpu;
> > > > > >  
> > > > > > -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > > > > > +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> > > > > >  			if (likely(cpu < nr_cpu_ids))
> > > > > >  				return cpu;
> > > > > >  			/*
> > > > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > > > index c49aea8c1025..94133f843485 100644
> > > > > > --- a/kernel/sched/topology.c
> > > > > > +++ b/kernel/sched/topology.c
> > > > > > @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> > > > > >  	for (i = 0; i < sched_domains_numa_levels; i++) {
> > > > > >  		if (!masks[i][j])
> > > > > >  			break;
> > > > > > -		cpu = cpumask_any_and(cpus, masks[i][j]);
> > > > > > +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
> > > > > >  		if (cpu < nr_cpu_ids) {
> > > > > >  			found = cpu;
> > > > > >  			break;
> > > > > 
> > > > 
> > > > -- 
> > > > 
> > > 
> > 
> > -- 
> > 
> 

-- 



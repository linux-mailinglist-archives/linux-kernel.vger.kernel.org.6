Return-Path: <linux-kernel+bounces-409799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96E9C91D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C123E286CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083E19995B;
	Thu, 14 Nov 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djy6Bhgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FD19993D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609850; cv=none; b=fwFN1umCmGb5wPW9f4Mj5Nr0fp+ThNkcTQ9XEu1EA+V/AP24IblIx2ka4k5KeBWxoG0NgFu06Eob2rbrlqOq9vbIFR/xKJGfp9WlG1OLo08GH3dVi5zWVOTUnu3YqLbxfYluz7v3t4cpfDStvIDdaWimCf2C+r0kxqgtgjYgTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609850; c=relaxed/simple;
	bh=Q03vjJ5s1nrHoyz+1CUz5PPjOeiFkURMvI6nfkE3ZXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7H18Knh064W/kcFEJMoNTIKX7xvxJlJsKAIFXKnb9TpffgRChjCsuUKyUFEmSiu+kXsaweL5ZU2Pl74qMCNpjDOHHzfLL8VSxEEJ8Kj3AS71XKI+IeVzaIrvMiQZqH3eUkv1BfbMPP6In1nX3Nkj0CuSQhJGfmmzo1FPkcjj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Djy6Bhgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731609847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAeVfk02oDfwwY3n4EGA4ZA9KbhiKvVHyPWkd4Y/Xuw=;
	b=Djy6BhgwHOadj4HTgQSjVQh7QDv1jujTIb/8WF/oUxc/Re9mpP9tmkro4sqTZNAbtPpF5b
	ghSFn+dClfNU7IiKC/DBhN7RVBU5ghefJyhmulYojwCNoppkzeU4Q7A44xiqIfESH/35E2
	sIY++Kh7uKyjcahhxQFQh/ym5eLgX/k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-NdgwsRNSNcawzudfg8CLfg-1; Thu,
 14 Nov 2024 13:44:02 -0500
X-MC-Unique: NdgwsRNSNcawzudfg8CLfg-1
X-Mimecast-MFC-AGG-ID: NdgwsRNSNcawzudfg8CLfg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422EA1954B1E;
	Thu, 14 Nov 2024 18:43:59 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D44653003B71;
	Thu, 14 Nov 2024 18:43:53 +0000 (UTC)
Date: Thu, 14 Nov 2024 13:43:50 -0500
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix DEADLINE bandwidth accounting in root domain
 changes and hotplug
Message-ID: <20241114184350.GE471026@pauld.westford.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 14, 2024 at 04:14:00PM +0000 Juri Lelli wrote:
> Thanks Waiman and Phil for the super quick review/test of this v2!
> 
> On 14/11/24 14:28, Juri Lelli wrote:
> 
> ...
> 
> > In all honesty, I still see intermittent issues that seems to however be
> > related to the dance we do in sched_cpu_deactivate(), where we first
> > turn everything related to a cpu/rq off and revert that if
> > cpuset_cpu_inactive() reveals failing DEADLINE checks. But, since these
> > seem to be orthogonal to the original discussion we started from, I
> > wanted to send this out as an hopefully meaningful update/improvement
> > since yesterday. Will continue looking into this.
> 
> About this that I mentioned, it looks like the below cures it (and
> hopefully doesn't regress wrt the other 2 patches).
> 
> What do everybody think?
>

I think that makes sense.  I think it's better not to have that
deadline call buried the cpuset code as well.


Reviewed-by: Phil Auld <pauld@redhat.com>



> ---
> Subject: [PATCH] sched/deadline: Check bandwidth overflow earlier for hotplug
>
> Currently we check for bandwidth overflow potentially due to hotplug
> operations at the end of sched_cpu_deactivate(), after the cpu going
> offline has already been removed from scheduling, active_mask, etc.
> This can create issues for DEADLINE tasks, as there is a substantial
> race window between the start of sched_cpu_deactivate() and the moment
> we possibly decide to roll-back the operation if dl_bw_deactivate()
> returns failure in cpuset_cpu_inactive(). An example is a throttled
> task that sees its replenishment timer firing while the cpu it was
> previously running on is considered offline, but before
> dl_bw_deactivate() had a chance to say no and roll-back happened.
> 
> Fix this by directly calling dl_bw_deactivate() first thing in
> sched_cpu_deactivate() and do the required calculation in the former
> function considering the cpu passed as an argument as offline already.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/core.c     |  9 +++++----
>  kernel/sched/deadline.c | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d1049e784510..43dfb3968eb8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8057,10 +8057,6 @@ static void cpuset_cpu_active(void)
>  static int cpuset_cpu_inactive(unsigned int cpu)
>  {
>  	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_bw_deactivate(cpu);
> -
> -		if (ret)
> -			return ret;
>  		cpuset_update_active_cpus();
>  	} else {
>  		num_cpus_frozen++;
> @@ -8128,6 +8124,11 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	int ret;
>  
> +	ret = dl_bw_deactivate(cpu);
> +
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
>  	 * load balancing when not active
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 267ea8bacaf6..6e988d4cd787 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3505,6 +3505,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  		}
>  		break;
>  	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is not off yet, but we need to do the math by
> +		 * considering it off already (i.e., what would happen if we
> +		 * turn cpu off?).
> +		 */
> +		cap -= arch_scale_cpu_capacity(cpu);
> +
>  		/*
>  		 * cpu is going offline and NORMAL tasks will be moved away
>  		 * from it. We can thus discount dl_server bandwidth
> @@ -3522,9 +3529,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  		if (dl_b->total_bw - fair_server_bw > 0) {
>  			/*
>  			 * Leaving at least one CPU for DEADLINE tasks seems a
> -			 * wise thing to do.
> +			 * wise thing to do. As said above, cpu is not offline
> +			 * yet, so account for that.
>  			 */
> -			if (dl_bw_cpus(cpu))
> +			if (dl_bw_cpus(cpu) - 1)
>  				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
>  			else
>  				overflow = 1;
> 

-- 



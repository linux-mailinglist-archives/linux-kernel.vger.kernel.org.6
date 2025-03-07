Return-Path: <linux-kernel+bounces-550939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599F1A56644
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3413ADBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5AE2153E1;
	Fri,  7 Mar 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hwBRG6rU"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15966215197
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345660; cv=none; b=bgHNNvmTLPnzekjxzppMYNtr7DmubFFrMtYj/4VQI46D8X1LWO66jK4GZ47sjW3znKfFxKomaMyELkzNgGDx6C3bJJrFzc8Wt7xSUg+5kwzj6C10iSL22LdTPXo221S9LYrVRzoHJLBEUApK9YNIAfCvDxdKsz5rRYcRtaTCglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345660; c=relaxed/simple;
	bh=/A415OXCljgCpImr+LiL3rliHR1Kpik1EOR0GpHxRHE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss156NM0ErlHuZDsXQEBiQwzFQAvdxKPDi3QDhH6SCwSzyKZuMEjsUWyyhBhFUsxjRYbsnx1mllj6JjKJMNM5KiqmGd5tisP6dX6fNQUOq+R0jYmelP3K2mIwXgTPNy0RPBNFiCaeFcOpFh7kyoF9w8RpBR0MMXzALlrpnyNX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hwBRG6rU; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741345660; x=1772881660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ozKm3p/1bKf/AhBeeR6IaQNzX87wcW5t5NwVauHrMuk=;
  b=hwBRG6rUpzGjRACj8XXlYAHsD73Ppyk2Gwus6xCaMfJF22DVbh03z6l8
   k3cjD9s9DVqnXXCtvOKX2LCaaK8fj96WwTsylXDmENd9wDGGY+FJiLBrN
   2AK/NlGnbl1SphNjVatUks1sbxJAjgi58AcU/vZ3tDZageK0s0LBoOtR8
   A=;
X-IronPort-AV: E=Sophos;i="6.14,229,1736812800"; 
   d="scan'208";a="384183580"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:07:38 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:15199]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id d0e31d44-bf5a-4bd0-a2a5-1a8b79685ab4; Fri, 7 Mar 2025 11:07:36 +0000 (UTC)
X-Farcaster-Flow-ID: d0e31d44-bf5a-4bd0-a2a5-1a8b79685ab4
Received: from EX19D018EUA001.ant.amazon.com (10.252.50.145) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 11:07:34 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D018EUA001.ant.amazon.com (10.252.50.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 11:07:33 +0000
Received: from email-imr-corp-prod-iad-all-1a-47ca2651.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 11:07:33 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com [10.253.65.58])
	by email-imr-corp-prod-iad-all-1a-47ca2651.us-east-1.amazon.com (Postfix) with ESMTP id 7384D408DF;
	Fri,  7 Mar 2025 11:07:33 +0000 (UTC)
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 2F74120DB5; Fri,  7 Mar 2025 11:07:33 +0000 (UTC)
Date: Fri, 7 Mar 2025 11:07:33 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, "Ben
 Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<abuehaze@amazon.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
Message-ID: <20250307110733.GA10571@amazon.com>
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 06, 2025 at 05:26:35PM +0100, Dietmar Eggemann wrote:
> Hagar reported a 30% drop in UnixBench spawn test with commit
> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> (aarch64) (single level MC sched domain) [1].
> 
> There is an early bail from sched_move_task() if p->sched_task_group is
> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> (Ubuntu '22.04.5 LTS').
> 
> So in:
> 
>   do_exit()
> 
>     sched_autogroup_exit_task()
> 
>       sched_move_task()
> 
>         if sched_get_task_group(p) == p->sched_task_group
>           return
> 
>         /* p is enqueued */
>         dequeue_task()              \
>         sched_change_group()        |
>           task_change_group_fair()  |
>             detach_task_cfs_rq()    |                              (1)
>             set_task_rq()           |
>             attach_task_cfs_rq()    |
>         enqueue_task()              /
> 
> (1) isn't called for p anymore.
> 
> Turns out that the regression is related to sgs->group_util in
> group_is_overloaded() and group_has_capacity(). If (1) isn't called for
> all the 'spawn' tasks then sgs->group_util is ~900 and
> sgs->group_capacity = 1024 (single CPU sched domain) and this leads to
> group_is_overloaded() returning true (2) and group_has_capacity() false
> (3) much more often compared to the case when (1) is called.
> 
> I.e. there are much more cases of 'group_is_overloaded' and
> 'group_fully_busy' in WF_FORK wakeup sched_balance_find_dst_cpu() which
> then returns much more often a CPU != smp_processor_id() (5).
> 
> This isn't good for these extremely short running tasks (FORK + EXIT)
> and also involves calling sched_balance_find_dst_group_cpu() unnecessary
> (single CPU sched domain).
> 
> Instead if (1) is called for 'p->flags & PF_EXITING' then the path
> (4),(6) is taken much more often.
> 
>   select_task_rq_fair(..., wake_flags = WF_FORK)
> 
>     cpu = smp_processor_id()
> 
>     new_cpu = sched_balance_find_dst_cpu(..., cpu, ...)
> 
>       group = sched_balance_find_dst_group(..., cpu)
> 
>         do {
> 
>           update_sg_wakeup_stats()
> 
>             sgs->group_type = group_classify()
> 
>               if group_is_overloaded()                             (2)
>                 return group_overloaded
> 
>               if !group_has_capacity()                             (3)
>                 return group_fully_busy
> 
>               return group_has_spare                               (4)
> 
>         } while group
> 
>         if local_sgs.group_type > idlest_sgs.group_type
>           return idlest                                            (5)
> 
>         case group_has_spare:
> 
>           if local_sgs.idle_cpus >= idlest_sgs.idle_cpus
>             return NULL                                            (6)
> 
> Unixbench Tests './Run -c 4 spawn' on:
> 
> (a) VM AWS instance (m7gd.16xlarge) with v6.13 ('maxcpus=4 nr_cpus=4')
>     and Ubuntu 22.04.5 LTS (aarch64).
> 
>     Shell & test run in '/user.slice/user-1000.slice/session-1.scope'.
> 
>     w/o patch	w/ patch
>     21005	27120
> 
> (b) i7-13700K with tip/sched/core ('nosmt maxcpus=8 nr_cpus=8') and
>     Ubuntu 22.04.5 LTS (x86_64).
> 
>     Shell & test run in '/A'.
> 
>     w/o patch	w/ patch
>     67675	88806
> 
> CONFIG_SCHED_AUTOGROUP=y & /sys/proc/kernel/sched_autogroup_enabled equal
> 0 or 1.
> 
> [1] https://lkml.kernel.org/r/20250205151026.13061-1-hagarhem@amazon.com
> 
> Reported-by: Hagar Hemdan <hagarhem@amazon.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b00f884701a6..ca0e3c2eb94a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9064,7 +9064,7 @@ void sched_move_task(struct task_struct *tsk)
>  	 * group changes.
>  	 */
>  	group = sched_get_task_group(tsk);
> -	if (group == tsk->sched_task_group)
> +	if ((group == tsk->sched_task_group) && !(tsk->flags & PF_EXITING))
>  		return;
>  
>  	update_rq_clock(rq);
> -- 
> 2.34.1
>

Thank you very much for submitting the fix and for all the explanations.

Could you please add the "Fixes:" tag for commit eff6c8ce8d4d to your patch? So that it is backported to the stable 6.12.
And actually this has been discovered internally by <abuehaze@amazon> so please add Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com> and Tested-by: Hagar Hemdan <hagarhem@amazon.com>.

Thanks,
Hagar


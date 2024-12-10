Return-Path: <linux-kernel+bounces-439184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D99EABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916011649C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B9C238721;
	Tue, 10 Dec 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SeoAxLHI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9123496A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822927; cv=none; b=YlyoRciFarlTrivOYYWgM0lwlKBXxRyk4xIPE//QbVzHOQOPciYx+IJpY7V2W47SRdpYAYves7uRDQXmjC1XDfOxTnItM0Dtvn+dIA4a+vHOdS9h+BuHkbQEswNZnGNPV8RrVHPdFHRFP7Y4XfBrqxADLEeSJ7Hi28Bjilq8mAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822927; c=relaxed/simple;
	bh=dVeIkk326Ww3Rb/wCpcZrFCbGiN2kiflAdQPVD33aVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM+Fj1BtgsgYQq8nLzg9VuDMpZXrBY2skTLZMOYmynAKfyQpAvxjPfRvPtJOe1b2wQe4jdSuYYf4R5T8uA4oQcL+B5WkOfu4C9yObSOi3GAMEdpkD/fmYNXzSTwbK39TgDPu9R9LC0bl/P/rg5hhRaYNtVN7dAE98D2LzOklXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SeoAxLHI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1vj61022360;
	Tue, 10 Dec 2024 09:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=J905rk
	7VPZ7dkmD9kpP0LKqQYUt8p7XBAMmFVg6npZY=; b=SeoAxLHIUREbgC0sP+M10h
	gdwYBvQnOaI6MjGPwKHy3fxd7jPpIhYTQWXVHC4m4wUJa1l94Jndb6OnY8HJQOpy
	wDN3rv6zuH+XmIHnzLiSW2rFB1+iy25nXFEAPCGsTNjAlFlSJEAmp9mgp+lxSzMH
	b2Xn3MptHiEtYwrG9RgNeljLEgojhMRlDxAJr+3TZKZHOJq+nChtFO/UUb8KbuCz
	Xn1JJ9/ifuzMyGp2PPk4M2/o/rzgOC7wSUvgHj9lac3xn9nqSA1TUA0OLvobKEwt
	qFB1aU9dNo3Kd0fga9HxZkApNXma16jk50gnpwkFyCJhIl3xOh7vaYD4UVH8Db4A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38p6dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:28:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA9KCDO005247;
	Tue, 10 Dec 2024 09:28:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38p6dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:28:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA7SMaP032590;
	Tue, 10 Dec 2024 09:28:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn2wmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:28:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BA9SLGC16056790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 09:28:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ABD520043;
	Tue, 10 Dec 2024 09:28:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B11D220040;
	Tue, 10 Dec 2024 09:28:17 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.213.186])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Dec 2024 09:28:17 +0000 (GMT)
Date: Tue, 10 Dec 2024 14:58:12 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, sshegde@linux.ibm.com,
        srikar@linux.ibm.com, vineethr@linux.ibm.com
Subject: Re: [PATCH v2] sched/fair: Fix CPU bandwidth limit bypass during CPU
 hotplug
Message-ID: <Z1gJrJ6TyotWzoCu@linux.ibm.com>
References: <20241207052730.1746380-2-vishalc@linux.ibm.com>
 <fb488379-3965-496b-8c6f-259981f3d7e5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb488379-3965-496b-8c6f-259981f3d7e5@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n3GZoUrmDe60iuYh1crNcXvCGETpZJmd
X-Proofpoint-ORIG-GUID: yLTGVmffc786DyUT1oz4MAaWb92biLZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100068

On Tue, Dec 10, 2024 at 02:55:36PM +0800, Zhang Qiao wrote:
> Hi Vishal,
> 
Thanks for looking into this!
> 
> 
> 在 2024/12/7 13:27, Vishal Chourasia 写道:
> > CPU controller limits are not properly enforced during CPU hotplug
> > operations, particularly during CPU offline. When a CPU goes offline,
> > throttled processes are unintentionally being unthrottled across all CPUs
> > in the system, allowing them to exceed their assigned quota limits.
> > 
> 
> I encountered a similar issue where cfs_rq is not in throttled state and the runtime_remaining still
> had plenty remaining, but it was reset to 1 here, causing the runtime_remaining of cfs_rq to be
> quickly depleted and the actual running time slice is smaller than the configured quota limits.
> 
Correct.
> > Consider below for an example,
> > 
> > Assigning 6.25% bandwidth limit to a cgroup
> > in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
> > 100% CPU utilization, expected (user+sys) time = 10 seconds.
> > 
> > $ cat /sys/fs/cgroup/test/cpu.max
> > 50000 100000
> > 
> > $ ./ebizzy -t 8 -S 20        // non-hotplug case
> > real 20.00 s
> > user 10.81 s                 // intended behaviour
> > sys   0.00 s
> > 
> > $ ./ebizzy -t 8 -S 20        // hotplug case
> > real 20.00 s
> > user 14.43 s                 // Workload is able to run for 14 secs
> > sys   0.00 s                 // when it should have only run for 10 secs
> > 
> > During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
> > is called for every active CPU to update the root domain. That ends up
> > calling rq_offline_fair which un-throttles any throttled hierarchies.
> > 
> > Unthrottling should only occur for the CPU being hotplugged to allow its
> > throttled processes to become runnable and get migrated to other CPUs.
> > 
> > With current patch applied,
> > $ ./ebizzy -t 8 -S 20        // hotplug case
> > real 21.00 s
> > user 10.16 s                 // intended behaviour
> > sys   0.00 s
> > 
> > Note: hotplug operation (online, offline) was performed in while(1) loop
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> > 
> > v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
> > 
> > ---
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fbdca89c677f..e28a8e056ebf 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6684,7 +6684,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
> >  	list_for_each_entry_rcu(tg, &task_groups, list) {
> >  		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> >  
> > -		if (!cfs_rq->runtime_enabled)
> > +		/* Only unthrottle the CPU being hotplugged */
> > +		if (!cfs_rq->runtime_enabled || cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
> >  			continue;
> 
> The cpu_of(rq) is  fixed value, so the ret of cpumask_test_cpu() is also a fixed value. We could
> check this before traversing the task_groups list, avoiding unnecessary traversal, is right?
Yes, I will sent out another version. Thanks for pointing it out!
> 
> Something like this:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d16c8545c71..79e9e5323112 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6687,25 +6687,29 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>         rq_clock_start_loop_update(rq);
> 
>         rcu_read_lock();
> -       list_for_each_entry_rcu(tg, &task_groups, list) {
> -               struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> +       if (!cpumask_test_cpu(cpu_of(rq), cpu_active_mask)) {
> +               list_for_each_entry_rcu(tg, &task_groups, list) {
> +                       struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> 
> -               if (!cfs_rq->runtime_enabled)
> -                       continue;
> +                       if (!cfs_rq->runtime_enabled)
> +                               continue;
> 
> -               /*
> -                * clock_task is not advancing so we just need to make sure
> -                * there's some valid quota amount
> -                */
> -               cfs_rq->runtime_remaining = 1;
> -               /*
> -                * Offline rq is schedulable till CPU is completely disabled
> -                * in take_cpu_down(), so we prevent new cfs throttling here.
> -                */
> -               cfs_rq->runtime_enabled = 0;
> +                       /*
> +                        * Offline rq is schedulable till CPU is completely disabled
> +                        * in take_cpu_down(), so we prevent new cfs throttling here.
> +                        */
> +                       cfs_rq->runtime_enabled = 0;
> 
> -               if (cfs_rq_throttled(cfs_rq))
> +                       if (!cfs_rq_throttled(cfs_rq))
> +                               continue;
> +
> +                       /*
> +                        * clock_task is not advancing so we just need to make sure
> +                        * there's some valid quota amount
> +                        */
> +                       cfs_rq->runtime_remaining = 1;
>                         unthrottle_cfs_rq(cfs_rq);
> +               }
>         }
Only traverse the thread group list for inactive CPUs, and if the cfs_rq
is throttled then set it's runtime_remaining to 1 and unthrottle it.

- vishalc
> 
> -- 
> Zhang Qiao
> >  
> >  		/*


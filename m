Return-Path: <linux-kernel+bounces-525169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD291A3EBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E2A167494
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C81FBCB0;
	Fri, 21 Feb 2025 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9+tHnaR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FD1E5739
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112974; cv=none; b=j9Et2kB6ERl7On7F6dOPBiJjuwAVBlgr3hZ16Sf/hxGXYFcAZa6oUrankUETYZJlMplJygWXVNZqU/ek10ktrq8bmzUiRJ2HkNVi4H2md1M2bgFvYSAWibuO7L/hUrEanBR3WwdPe6NBnFnPFcbyjWlxMXXN3UJ9h4tIdKVPWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112974; c=relaxed/simple;
	bh=UgDpChOpC5tEKyETW/BLS2qz5Sfty7CZHhmmJ1xf5gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTn10QTqOgqnnsPAAEGzWBNujxx5meJs/10GZGRuzIRcMcCvOP/+AmGkbG03MouI6riqywpZqKhLMsZpdUwW3S6QMDwMW8UqAJjdPYBPVZEQyYHowRG3ZBcfw2QFMEfkLf2RcjMSwbZPyxjGasccQnc6y3qpDT6Iqtjl6aINRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9+tHnaR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L18VjU027194;
	Fri, 21 Feb 2025 04:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xC3UOSAlk/k6NpGluZ6x1FdHUVDo4Y
	OaXFc5TSTKHpo=; b=a9+tHnaRWFJiWb/gk6kWFBn1FV4iHDYPjOn5PTAH2pNwMr
	vp7VIq2bhU9XYP0yGzMlwXl7Y9SYMh9FmF2nEuH6auumbUkVmJgVQvmPz1MCYwgD
	qycJfWm9yaPBlWCUxEgq6RLFLYoy6phqr524CrDknNdOakQ7MvJSxSF9eUakSsve
	LNYXhSpb4+ZzvH0KD79ZyGuTIoiGPPZIURZvFTQtybwlCgBJSaGs2PpWIsT/EfaA
	/kKE0+JBLpvfIC7OpKEcRDNPgFb3KLhJrd1cmiThaaocKGA4T6TucbWIxABlJ9/v
	1BPK+BsHSzQiNRbriZ5CFn328OIx6QS+AlvKGwEw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xfj9rrt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 04:42:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51L1JWSW005776;
	Fri, 21 Feb 2025 04:42:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w02xnxrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 04:42:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51L4ghkB47186274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 04:42:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B5120040;
	Fri, 21 Feb 2025 04:42:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 895F92004B;
	Fri, 21 Feb 2025 04:42:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Feb 2025 04:42:40 +0000 (GMT)
Date: Fri, 21 Feb 2025 10:12:37 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Phil Auld <pauld@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <Z7gEPXdPrXgM0-yB@linux.ibm.com>
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb>
 <Z67Wy9Jjn0BZa01A@linux.ibm.com>
 <20250218150059.GC547103@pauld.westford.csb>
 <Z7bz6ECsSfpcqqkc@linux.ibm.com>
 <20250220155229.GB89684@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220155229.GB89684@pauld.westford.csb>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x4HfQ0ot1Qj9mdJtJiu3U2PJlMolpjZa
X-Proofpoint-GUID: x4HfQ0ot1Qj9mdJtJiu3U2PJlMolpjZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210031

On Thu, Feb 20, 2025 at 10:52:29AM -0500, Phil Auld wrote:
> 
> Hi Vishal,
> 
> On Thu, Feb 20, 2025 at 02:50:40PM +0530 Vishal Chourasia wrote:
> > On Tue, Feb 18, 2025 at 10:00:59AM -0500, Phil Auld wrote:
> > > Hi Vishal.
> > > 
> > > On Fri, Feb 14, 2025 at 11:08:19AM +0530 Vishal Chourasia wrote:
> > > > Hi Phil, Vineeth
> > > > 
> > > > On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
> > > > > On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
> > > > > > Hi Phil Auld,
> > > > > > 
> > > > > > On 11/02/25 19:31, Phil Auld wrote:
> > > > > > > The exising code uses housekeeping_any_cpu() to select a cpu for
> > > > > > > a given housekeeping task. However, this often ends up calling
> > > > > > > cpumask_any_and() which is defined as cpumask_first_and() which has
> > > > > > > the effect of alyways using the first cpu among those available.
> > > > > > > 
> > > > > > > The same applies when multiple NUMA nodes are involved. In that
> > > > > > > case the first cpu in the local node is chosen which does provide
> > > > > > > a bit of spreading but with multiple HK cpus per node the same
> > > > > > > issues arise.
> > > > > > > 
> > > > > > > Spread the HK work out by having housekeeping_any_cpu() and
> > > > > > > sched_numa_find_closest() use cpumask_any_and_distribute()
> > > > > > > instead of cpumask_any_and().
> > > > > > > 
> > > > > > 
> > > > > > Got the overall intent of the patch for better load distribution on
> > > > > > housekeeping tasks. However, one potential drawback could be that by
> > > > > > spreading HK work across multiple CPUs might reduce the time that
> > > > > > some cores can spend in deeper idle states which can be beneficial for
> > > > > > power-sensitive systems.
> > > > > > 
> > > > > > Thoughts?
> > > > > 
> > > > > NOHZ_full setups are not generally used in power sensitive systems I think.
> > > > > They aren't in our use cases at least. 
> > > > > 
> > > > > In cases with many cpus a single housekeeping cpu can not keep up. Having
> > > > > other HK cpus in deep idle states while the one in use is overloaded is
> > > > > not a win. 
> > > > 
> > > > To me, an overloaded CPU sounds like where more than one tasks are ready
> > > > to run, and a HK CPU is one receiving periodic scheduling clock
> > > > ticks, so HP CPU is bound to comes out of any power-saving state it is in.
> > > 
> > > If the overload is caused by HK and interrupts there is nothing in the
> > > system to help. Tasks, sure, can get load balanced.
> > > 
> > > And as you say, the HK cpus will have generally ticks happening anyway.
> > > 
> > > > > 
> > > > > If your single HK cpu can keep up then only configure that one HK cpu.
> > > > > The others will go idle and stay there.  And since they are nohz_full
> > > > > might get to stay idle even longer.
> > > > While it is good to distribute the load across each HK CPU in the HK 
> > > > cpumask (queuing jobs on different CPUs each time), this can cause
> > > > jitter in virtualized environments. Unnecessaryily evicting other
> > > > tenants, when it's better to overload a VP than to wake up other VPs of a
> > > > tenant.
> > > > 
> > > 
> > > Sorry I'm not sure I understand your setup. Are your running virtual
> > > tenants on the HK cpus?  nohz_full in the guests? Maybe you only need
> > > on HK then it won't matter.
> > > 
> > Firstly, I am unaware if nohz_full is being used in virtualized environment.
> > Please correct me it is. I am not saying it can't or shouldn't be used, it's just
> > I don't know if anybody is using it.
> >
> 
> I've seen some people trying it in various ways and to varying degrees of
> success if I recall correctly.
> 
> 
> > nohz_full in guests would mean that tick is disabled inside the guest but
> > the host might still be getting ticks. So, I am unsure, whether it is a good
> > idea to have nohz_full in virtualized environment.
> > 
> > Nevertheless, the idea of nohz_full is to reduce to the kernel interference
> > for CPUs marked as nohz_full. And, it does help with guest interference.
> > 
> > I would like to mention, In SPLPAR environment, scheduling work on
> > different HK CPU each time can caused VM preemption in a multi-tenant
> > setup in cases where CPUs in HK cpumask spans across VPs, its better to
> > consolidate them within few VPs.
> > 
> > VP is virtual core/processor.
> 
> I have a hard time reconciling you saying you are not using virtualization
> and then talking about VMs and VPs ;)
I was thinking of a possibility in virtualized environments, this isn't
specific to PPC 

Thanks
vishalc :)
> 
> Sometimes I forget how interesting PPC can be...
> 
> > 
> > > My concern is that currently there is no point in having more than
> > > one HK cpu (per node in a NUMA case). The code as currently implemented
> > > is just not doing what it needs to.
> > > 
> > > We have numerous cases where a single HK cpu just cannot keep up and
> > > the remote_tick warning fires. It also can lead to the other things
> > > (orchastration sw, HA keepalives etc) on the HK cpus getting starved
> > > which leads to other issues.  In these cases we recommend increasing
> > > the number of HK cpus.  But... that only helps the userspace tasks
> > > somewhat. It does not help the actual housekeeping part.
> > > 
> > > It seems clear to me that the intent of the cpumask_any_and() calls
> > > is to pick _any_ cpu in the hk mask. Not just the first, otherwise
> > > it would just use cpumask_first_and().
> > > 
> > > I'm open to alternate suggestions of how to fix this.
> > Your approach looks good to me.
> > 
> > I wanted to mention the case of overcommitted multi-tenant setup
> > where this will cause noisy neighbour sort of situation, but this can be
> > avoided by carefully selecting HK CPUs.
> 
> Yes, it can be configured away, hopefully.
> 
> Still, this could easily be a sched feat if that make sense to people.
> 
> 
> Thanks for the review!
> 
> 
> Cheers,
> Phil
> 
> 
> 
> > 
> > Thanks,
> > vishalc
> > > 
> > > 
> > > Cheers,
> > > Phil
> > > 
> > > > > 
> > > > > I do have a patch that has this controlled by a sched feature if that
> > > > > is of interest. Then it could be disabled if you don't want it.
> > > > 
> > > > Vishal
> > > > > 
> > > > > Cheers,
> > > > > Phil
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Madadi Vineeth Reddy
> > > > > > 
> > > > > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > > > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > > > > Cc: Waiman Long <longman@redhat.com>
> > > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > > ---
> > > > > > >  kernel/sched/isolation.c | 2 +-
> > > > > > >  kernel/sched/topology.c  | 2 +-
> > > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > > > > > index 81bc8b329ef1..93b038d48900 100644
> > > > > > > --- a/kernel/sched/isolation.c
> > > > > > > +++ b/kernel/sched/isolation.c
> > > > > > > @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
> > > > > > >  			if (cpu < nr_cpu_ids)
> > > > > > >  				return cpu;
> > > > > > >  
> > > > > > > -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > > > > > > +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> > > > > > >  			if (likely(cpu < nr_cpu_ids))
> > > > > > >  				return cpu;
> > > > > > >  			/*
> > > > > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > > > > index c49aea8c1025..94133f843485 100644
> > > > > > > --- a/kernel/sched/topology.c
> > > > > > > +++ b/kernel/sched/topology.c
> > > > > > > @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> > > > > > >  	for (i = 0; i < sched_domains_numa_levels; i++) {
> > > > > > >  		if (!masks[i][j])
> > > > > > >  			break;
> > > > > > > -		cpu = cpumask_any_and(cpus, masks[i][j]);
> > > > > > > +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
> > > > > > >  		if (cpu < nr_cpu_ids) {
> > > > > > >  			found = cpu;
> > > > > > >  			break;
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > 
> > > > 
> > > 
> > > -- 
> > > 
> > 
> 
> -- 
> 


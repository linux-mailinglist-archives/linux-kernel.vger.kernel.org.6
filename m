Return-Path: <linux-kernel+bounces-514389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3DDA35660
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9883ABF30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2388189528;
	Fri, 14 Feb 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="feMuSj9a"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512638DD8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511519; cv=none; b=R6jCWDbhzRsw/aYWDyaeCajop9hn5Dt9z4TGRMkZcJ4hzGSHlspzpU8fZhdku9orrtBioO+lbH8S3omCifWxW1DVi3SNdaxq+jpvrd9Xq5FK/oWEzDQWB2FGVg3gJMNbwTSqTdk9ZzEgIAfhQgA1FF2Q4oUfZGOr6eIEVNFdg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511519; c=relaxed/simple;
	bh=CQr39ri/OSPGC24wdv1M+mapDC1Cld7r+LVxyyYAHJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWPRVOLDLYEff353Kpia5ZMryoIrQDwNSE9RGPXgZseScF1L9Qk0UQwgqiz/BG/zLAOGnJqtRkDU6X6oRjTYMPzRPJtckRTXtI2/WacEB6PZ3473oiBBiwsinQM0fOhpKjvvIGKLCs3WnTfX2P2KsKBBFYa428FNgea3iLu3eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=feMuSj9a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DH5SLQ015014;
	Fri, 14 Feb 2025 05:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/mxC2ldGkMfd3/8DGsPK//BNOuzFz/
	ScOks2XhQtAhA=; b=feMuSj9aO9cEwhXSs5ictmVl9hggHCrt3mik3m1GMHNHv6
	0DLlrs4jEbGcm5eo46kFjFfq9++Gqarfp0GPOaTwHdBSyVgW63MnplxIVA3mDBk8
	VFWjqj/BEgrTi9t3069EoKQnj190VyNFLWbp7KNA9BDJl+pG0IzzPzJWl+McQmFc
	jUK+KvctS22oGhHvJbLjV4avVvWJi4LsXMW+e+4xdjzjVXSg8bCXrfRvswnCK/zu
	FIcm3I8twfiwIdvh6J3pBaHXO6eXgN6qLp9txghFYqCPaj2JV304koMGBAUqoJEP
	c5efUXw/LbQ4k0/T1PS8O2a4s5vxZQAxzm4tB4ZA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44sceq5veq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 05:38:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E1tOh5021706;
	Fri, 14 Feb 2025 05:38:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkt27fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 05:38:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E5cN2o57082252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 05:38:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7623320049;
	Fri, 14 Feb 2025 05:38:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B37B720040;
	Fri, 14 Feb 2025 05:38:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.203])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Feb 2025 05:38:21 +0000 (GMT)
Date: Fri, 14 Feb 2025 11:08:19 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Phil Auld <pauld@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <Z67Wy9Jjn0BZa01A@linux.ibm.com>
References: <20250211140104.420739-1-pauld@redhat.com>
 <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
 <20250213142653.GA472203@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142653.GA472203@pauld.westford.csb>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LdQcbZi9V1v-Nsk9vnKifDTg0pweo9UH
X-Proofpoint-ORIG-GUID: LdQcbZi9V1v-Nsk9vnKifDTg0pweo9UH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140039

Hi Phil, Vineeth

On Thu, Feb 13, 2025 at 09:26:53AM -0500, Phil Auld wrote:
> On Thu, Feb 13, 2025 at 10:14:04AM +0530 Madadi Vineeth Reddy wrote:
> > Hi Phil Auld,
> > 
> > On 11/02/25 19:31, Phil Auld wrote:
> > > The exising code uses housekeeping_any_cpu() to select a cpu for
> > > a given housekeeping task. However, this often ends up calling
> > > cpumask_any_and() which is defined as cpumask_first_and() which has
> > > the effect of alyways using the first cpu among those available.
> > > 
> > > The same applies when multiple NUMA nodes are involved. In that
> > > case the first cpu in the local node is chosen which does provide
> > > a bit of spreading but with multiple HK cpus per node the same
> > > issues arise.
> > > 
> > > Spread the HK work out by having housekeeping_any_cpu() and
> > > sched_numa_find_closest() use cpumask_any_and_distribute()
> > > instead of cpumask_any_and().
> > > 
> > 
> > Got the overall intent of the patch for better load distribution on
> > housekeeping tasks. However, one potential drawback could be that by
> > spreading HK work across multiple CPUs might reduce the time that
> > some cores can spend in deeper idle states which can be beneficial for
> > power-sensitive systems.
> > 
> > Thoughts?
> 
> NOHZ_full setups are not generally used in power sensitive systems I think.
> They aren't in our use cases at least. 
> 
> In cases with many cpus a single housekeeping cpu can not keep up. Having
> other HK cpus in deep idle states while the one in use is overloaded is
> not a win. 

To me, an overloaded CPU sounds like where more than one tasks are ready
to run, and a HK CPU is one receiving periodic scheduling clock
ticks, so HP CPU is bound to comes out of any power-saving state it is in.
> 
> If your single HK cpu can keep up then only configure that one HK cpu.
> The others will go idle and stay there.  And since they are nohz_full
> might get to stay idle even longer.
While it is good to distribute the load across each HK CPU in the HK 
cpumask (queuing jobs on different CPUs each time), this can cause
jitter in virtualized environments. Unnecessaryily evicting other
tenants, when it's better to overload a VP than to wake up other VPs of a
tenant.

> 
> I do have a patch that has this controlled by a sched feature if that
> is of interest. Then it could be disabled if you don't want it.

Vishal
> 
> Cheers,
> Phil
> 
> > 
> > Thanks,
> > Madadi Vineeth Reddy
> > 
> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/sched/isolation.c | 2 +-
> > >  kernel/sched/topology.c  | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > index 81bc8b329ef1..93b038d48900 100644
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
> > >  			if (cpu < nr_cpu_ids)
> > >  				return cpu;
> > >  
> > > -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > > +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> > >  			if (likely(cpu < nr_cpu_ids))
> > >  				return cpu;
> > >  			/*
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index c49aea8c1025..94133f843485 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> > >  	for (i = 0; i < sched_domains_numa_levels; i++) {
> > >  		if (!masks[i][j])
> > >  			break;
> > > -		cpu = cpumask_any_and(cpus, masks[i][j]);
> > > +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
> > >  		if (cpu < nr_cpu_ids) {
> > >  			found = cpu;
> > >  			break;
> > 
> 
> -- 
> 


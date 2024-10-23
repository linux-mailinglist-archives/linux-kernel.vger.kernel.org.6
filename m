Return-Path: <linux-kernel+bounces-378075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87A9ACB09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62691B2222D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E421AE01B;
	Wed, 23 Oct 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l6sHvuKI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E56159583
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689591; cv=none; b=NihJ5Gm4x5Da3+NDhyaaKztFIgcbejPG7Kiuts09baTvhajAKBUqmowm2W4oDcBYjcisxc0XShfEbKx3vCU1bIrGFQ6/eB9irN8rnUpyljZ9BW/Jn1aloop7G2YUwcX2RPxUJBUS0ca+piNUFypecNcovlNF8wMV4d2ee4uS/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689591; c=relaxed/simple;
	bh=UgFMxLvLCPmwXqrDXa3K9lgwLf3jrSlQBJy8I5mhyWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fap2gPLMTK5U2/B8lEYpKeEjn4MhzDlWa1+3dd4xEUxNaoXLhcpVUbyRLKSiPqO6mTbYZdLmv6vNwmwlgF1NyGy/3CGQfIGVbZLaxYQXw6KYWtr3RXySHHny7K0nFGD5NItkKw3bIQPJjJ/mWY9+I2vYq5IXxLMdfJuxv/7BnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l6sHvuKI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0OhkJ018131;
	Wed, 23 Oct 2024 13:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=llVA6e5PpHMBguB71iXY0BRFvf2DEp
	guYU65x1n53Ec=; b=l6sHvuKItnpzqAVpzDT6DE5pXA8yd+fl000X6n9nG5UU/a
	z8DBA1qquZoKooxAAE4zZyLotkJjI4eQEGuQO8Tyu+Fjs4Bs9pl0si9JTC6zceNJ
	snYd8E2pP8w3Rbf8YoT4cEkfuo2yAR8n7066NabESZE5hVE93ugAgiMHuqRDWLu6
	8e/yQGjGqxTujUJArLxgfv108ym54K8+1jpS0DGOj2iVXuRHpdl4hwrfKMsm/hc2
	cSQYY9vdnjERuotahwlQsPIwl20DBxfa1raTHuxPAJCb10aQj/JtZDV0j7w6kmmP
	Ga6H7WT6/fWZibRm8x29xCY0JFLw/zXBVDIpQ9jw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadu757-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:19:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NDJNQm021600;
	Wed, 23 Oct 2024 13:19:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadu754-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:19:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBlSxM001530;
	Wed, 23 Oct 2024 13:19:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9ayq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 13:19:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NDJKPS30868104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 13:19:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFDE12004B;
	Wed, 23 Oct 2024 13:19:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05A3E20040;
	Wed, 23 Oct 2024 13:19:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.211.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 13:19:17 +0000 (GMT)
Date: Wed, 23 Oct 2024 18:49:15 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <Zxj30yQDRmLd2EGO@linux.ibm.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <ZxJIDwHNzPkuyGrU@linux.ibm.com>
 <ZxZ_arDwEu489GkN@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZ_arDwEu489GkN@swahl-home.5wahls.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NRHiACbmdU7OS4HbOKm-xUJmj-SSy-Lf
X-Proofpoint-GUID: CYTvHrLdoxTFG9J1COsaHlTa9BPvRK2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=811 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230079

On Mon, Oct 21, 2024 at 11:20:58AM -0500, Steve Wahl wrote:
> On Fri, Oct 18, 2024 at 05:05:43PM +0530, Vishal Chourasia wrote:
> > On Thu, Oct 10, 2024 at 10:51:11AM -0500, Steve Wahl wrote:
 > > @@ -2417,9 +2446,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> > >  		sd = NULL;
> > >  		for_each_sd_topology(tl) {
> > >  
> > > -			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> > > -				goto error;
> > > -
> > >  			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
> > >  
> > >  			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> > > @@ -2433,6 +2459,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> > >  		}
> > >  	}
> > >  
> > > +	if (WARN_ON(!topology_span_sane(cpu_map)))
> > > +		goto error;
> > Hi Steve,
> 
> Vishal, thank you for taking the time to review.
> 
> > Is there any reason why above check is done after initializing
> > sched domain struct for all the CPUs in the cpu_map?
> 
> The original check was done in the same for_each_sd_topology(tl) loop
> that calls build_sched_domain().  I had trouble 100% convincing myself
> that calls to build_sched_domain() on the previous levels couldn't
> affect calls to tl->mask() in later levels, so I placed the new check
> after all calls to build_sched_domain were complete.
> 
Yeah, I don't see build_sched_domain() modifying the cpumask
returned from tl->mask(cpu)

> > It looks to me, that this check can be performed before the call to
> > __visit_domain_allocation_hell() in the build_sched_domains()
> > resulting in early return if topology_span_sane() detects incorrect
> > topology.
> 
> This might be OK to do.  I would greatly appreciate somebody well
> versed in this code area telling me for certain that it would work.
> 
Same.

> > Also, the error path in the current code only cleans up d->rd struct, keeping 
> > all the work done by build_sched_domain() inside the loop and __alloc_sdt() 
> > called from __visit_domain_allocation_hell()
> > 
> > is it because we need all that work to remain intact?
> 
> I'm not seeing this.  The return from __visit_domain_allocation_hell()
> is stored in alloc_state immediately checked to be == sa_rootdomain;
> if not, the error path is taken, deallocating everything and
> returning.
> 
> The rest of the function does not touch alloc_state, so any error from
> that point on makes the call to __free_domain_allocs with what ==
> sa_rootdomain, which seems to undo everything.
> 
> Are you possibly missing the fallthroughs in __free_domain_allocs()
> even though they're clearly emphasized?
> 
Yes, you are right. Thank you for pointing that out.

> > static void __free_domain_allocs(struct s_data *d, enum s_alloc what,
> > 				 const struct cpumask *cpu_map)
> > {
> > 	switch (what) {
> > 	case sa_rootdomain:
> > 		if (!atomic_read(&d->rd->refcount))
> > 			free_rootdomain(&d->rd->rcu);
> > 		fallthrough;
> > 	case sa_sd:
> > 		free_percpu(d->sd);
> > 		fallthrough;
> > 	case sa_sd_storage:
> > 		__sdt_free(cpu_map);
> > 		fallthrough;
> > 	case sa_none:
> > 		break;
> > 	}
> > }
> > 
> 
> Thanks,
> 
> --> Steve Wahl
> 
> -- 
> Steve Wahl, Hewlett Packard Enterprise


Return-Path: <linux-kernel+bounces-346067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD898BF14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9737A1F22376
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D031C68A5;
	Tue,  1 Oct 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPRuRoV2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBB2A1D2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791741; cv=none; b=HE+olmda41OCojb5cxGCwuKSnte5g4l3+mD8A6XuJJ6zUIluqWiD9G1vF5uQozbkiLCji3KHiSYVqUNiVe1In55qcsWwOFpKL1RSwadjdzUQV4jvq+2RR51I6DMRA0RotkWREBznJDsP5BoPlEJKAVjdVEs/HTPCIFa3D+Ujs00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791741; c=relaxed/simple;
	bh=6EPCaFAuMzqTqe5Vt5IbJBvDuX/iDueGxt36SNd14wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmGx6+arLp0zV4U1YCnAtGvhDc3oKYi5PwJQ0ITTj5mdA3RttHI1Sd/ZVLiR69boXbcU6YaIdVPdEr4RAYbfqhm6JJgMo9uSF2gzFYYJGKW7tgo1LSN+GuthTSPRsEs76eObDhP1VXrCluN0B7KHoJz26HvTAniGx3eLk2DvwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPRuRoV2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AqPIm000675;
	Tue, 1 Oct 2024 14:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=8VlSY6iKsLVApkVuyQXp2M9m3ap
	zchCe2fKoIeySkWc=; b=lPRuRoV2ILrcvgVN065LcUM7AEv9fUhGR1Z0ootDhvo
	jF65WxTm1wR1vi4ZYVbJ45D3wlhZCixi75MyHIElB1P0hk27jzwBRFgaHKAZUq39
	kSRLoaPrdVklhVQQgNHw74hiPVKmUI+NNQVgEai4Yc+yJOg9E3TFgxWKX/BnxS4Z
	1w3l1EVJMg0hvXKJNZ8BMwZHFmWNcNxECtHNrvDxO6mk8/9iWdueoVEk5lI6Mljn
	uzYKRmoGrMybtuwo3VMzH7UKB0brM/j0TO4A5ktx9D7V934kBjW34NxnF7h3L6Kk
	rUSWq9lJC9mmFS31qWf6YMfdXBAei/hTnfxqE0hGZ0A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s29b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:08:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491E4G3D026696;
	Tue, 1 Oct 2024 14:08:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s295-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:08:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CTuAC007957;
	Tue, 1 Oct 2024 14:08:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxvxbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 14:08:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491E8j6M55836988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 14:08:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A78020043;
	Tue,  1 Oct 2024 14:08:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B390C20040;
	Tue,  1 Oct 2024 14:08:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.29.138])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 14:08:42 +0000 (GMT)
Date: Tue, 1 Oct 2024 19:38:40 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <ZvwCaKkgb2F6pzLP@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
 <Zvr2bLBEYyu1gtNz@linux.ibm.com>
 <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jHAGQj8LJI6GOPC-5PFjrGxjXIPmslPf
X-Proofpoint-GUID: 4OKfyh3Bato2NMtBRqg0AlBvzRwU3SHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=581 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010089

On Tue, Oct 01, 2024 at 10:30:26AM +0200, Mike Galbraith wrote:
> On Tue, 2024-10-01 at 00:45 +0530, Vishal Chourasia wrote:
> > >
> > for sanity, I ran the workload (kernel compilation) on the base commit
> > where the kernel panic was initially observed, which resulted in a
> > kernel panic, along with it couple of warnings where also printed on the
> > console, and a circular locking dependency warning with it.
> >
> > Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le
> >
> > ------------[ cut here ]------------
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
> > ------------------------------------------------------
> 
> ...
> 
> > --- interrupt: 900
> > se->sched_delayed
> > WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+0x644/0x660
> 
> ...that warning also spells eventual doom for the box, here it does
> anyway, running LTPs cfs_bandwidth01 testcase and hackbench together,
> box grinds to a halt in pretty short order.
> 
> With the patchlet below (submitted), I can beat on box to my hearts
> content without meeting throttle/unthrottle woes.
> 
> sched: Fix sched_delayed vs cfs_bandwidth
> 
> Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
> leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
> can proceed as it would have sans DELAY_DEQUEUE treatment.
> 
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
Hello Mike, Thank you the patch!

With the below changes, I don't see any warnings been printed on the
console, along with it, there were no kernel panics

Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/sched/fair.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6058,10 +6058,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> 
> -		if (se->on_rq) {
> -			SCHED_WARN_ON(se->sched_delayed);
> +		/* Handle any unfinished DELAY_DEQUEUE business first. */
> +		if (se->sched_delayed) {
> +			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
> +
> +			dequeue_entity(qcfs_rq, se, flags);
> +		} else if (se->on_rq)
>  			break;
> -		}
>  		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
> 
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
> 


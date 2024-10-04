Return-Path: <linux-kernel+bounces-349948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C198FDB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C481B2135B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B561311A7;
	Fri,  4 Oct 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PL8BNx0y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74013775E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026309; cv=none; b=ls1DrP5IZuAulXNUuwKYrQz9YZv598rGB1lqAm+18yOgDTOqnysUSf2Gbu5WevV3u5HHn6nrcSyRmMMIWOWgxpiaiW5FFbEyj1qsmDvZiZksaiqo2HYVnmiRpRwWdXW1+7yu7Tz+Jfo1gB7I5H18+kFl3wmOt0gQb3mXzOZ3Iys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026309; c=relaxed/simple;
	bh=M8A8nqqCpPKoeerjqd7wTpPyC1e9ptUMSe+itBbXXLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDGZH/e9/RSLxWUjaK+47bzC1Xw8q/zuBrMK6sSy6AdhCQ7aqr7fDqT1KJ/mg7qI4M3MG68i3mMldkCfizeldDvxKm2GF59dJ51O1mVk7RGc05i2OuQ7VNFUlOn1LFls1okFiJ0ODR98pyQIPjZxxr9stfkjuTrUbnqAFfgvpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PL8BNx0y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947IBTS032572;
	Fri, 4 Oct 2024 07:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=TWGE4XmQnG+WrW7DGBLDxFr2uNu
	TGT9jxwW+foVbp7I=; b=PL8BNx0yJRSzdQGFvzqCIoDYdxfmBAy4IojYBUk7uu+
	k+jnR4Wlt75dLPCFYZnW0mBRwQ2XsSTgiUpr0hvMKq2kQuSHL5g2muyLFtKrff6S
	3GQCezoaGktPo3SeFSdcNy+6W0+uVObIG0yuckGwOVytAZsKbFpIHH5UcXMm+RMZ
	O+xbfx9KBsHEnt3ZXUHe6VaIq6xlSje6+9v3q1ZuY1OnHcFhM1KcLIJ8x597v0RO
	J1rGHGhCpi+U+ofZVMbZiRQAm1zW+rzzphE6PK3Lbs5vP8C0v/nx8TOTWqwGZV3K
	V02L5YvnBX0WYndAY4VYoN+PwIa2/Qf12QK54sHp31Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bhbr2m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:18:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4947ASIK018366;
	Fri, 4 Oct 2024 07:18:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422bhbr2m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:18:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49471mGl017912;
	Fri, 4 Oct 2024 07:18:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207jap5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 07:18:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4947I7HH18678102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 07:18:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A0720049;
	Fri,  4 Oct 2024 07:18:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 600CD2004E;
	Fri,  4 Oct 2024 07:18:04 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.214.154])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Oct 2024 07:18:04 +0000 (GMT)
Date: Fri, 4 Oct 2024 12:47:59 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Benjamin Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, luis.machado@arm.com
Subject: Re: sched/fair: Kernel panics in pick_next_entity
Message-ID: <Zv-WpzwtDxjY2SLT@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
 <Zvr2bLBEYyu1gtNz@linux.ibm.com>
 <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
 <xm26msjmm91q.fsf@bsegall.svl.corp.google.com>
 <2ffbd642407a2bc51a387b6f89e74f0f9c9f85cf.camel@gmx.de>
 <acad4ac6a2daea2884e8ae4d031dfc8ae30fc365.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acad4ac6a2daea2884e8ae4d031dfc8ae30fc365.camel@gmx.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oSIEU-SzYdQQyyPJdpzUJCESB82GSDY6
X-Proofpoint-ORIG-GUID: JsPLWGUSH7xmJJFINEoiVVvy6CpgB4UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_05,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=548
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040047

On Thu, Oct 03, 2024 at 11:31:06AM +0200, Mike Galbraith wrote:
> On Thu, 2024-10-03 at 06:41 +0200, Mike Galbraith wrote:
> > On Wed, 2024-10-02 at 15:31 -0700, Benjamin Segall wrote:
> 
> > > Whether dequeue_entity + enqueue_entity is better or worse than
> > > requeue_delayed_entity (+break), I really don't know.
> >
> > Hm, I'd say requeue_delayed_entity() not only fits better, it using
> > less lines gives it an extra brownie point.
> 
> Probable not worth any churn or effort, but it is an option.
> 
> sched: Clean up sched_delayed handling in unthrottle_cfs_rq()
> 
> requeue_delayed_entity() achieves and documents in one line what a less
> clear preparatory dequeue facilitates over several, so use it instead,
> and remove the superfluous comment.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
Hi Mike, thanks for the patch!

I didn't see any warnings or kernel panics in my setup. 

Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/sched/fair.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6058,12 +6058,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> 
> -		/* Handle any unfinished DELAY_DEQUEUE business first. */
> -		if (se->sched_delayed) {
> -			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
> -
> -			dequeue_entity(qcfs_rq, se, flags);
> -		} else if (se->on_rq)
> +		if (se->sched_delayed)
> +			requeue_delayed_entity(se);
> +		if (se->on_rq)
>  			break;
>  		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
> 
> 


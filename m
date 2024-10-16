Return-Path: <linux-kernel+bounces-367709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87F99A05B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCFB25985
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3641206042;
	Wed, 16 Oct 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qcJB6b84"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97260205E34
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071448; cv=none; b=iHSOE8C3faPzQUh2rJwHrW9nC/UPMDmsRLAxzlbJeKB3p8milSLFvhFjp9bBgZ4dKv/5oW+/IR6heVKgpspIIM5REgVUeiPysmmuskxgnguqs3ESSJPiEn6o/Y8ex50cjXz1NbIS4m1DbT9E1D9cU5jsHg/h2ZyYBWVilrDHy6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071448; c=relaxed/simple;
	bh=x3HkUKs3BWy52f5cig8+R+AD5fSBS0XdcrXhOr14bIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJNVHcrw8ME628nDTIgh8VE6K6sz1OntIrVoPBaQQ8J/Ix+Z0/vTeq55L3oWOAqmFthMlAe7Ybee2B32UUdTtNE6CnukMbELBCqf7MkiWqdhkp9YcXTrZNst5PqKbBXH8j0fBtd5l9ZVIxMDgVnrSLs9A0mmEixve9ICXow1XGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qcJB6b84; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9Oi9Z023391;
	Wed, 16 Oct 2024 09:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h+YKoV
	hNt3xxX2DgczZxzAqnAes9SoiFCRdfOzV9Tyc=; b=qcJB6b84ip7InTwPfjNap8
	Ue2Zbwe9eb2GLjWsvJZQDExmnO+zhITU/lfZORZ2hITBlNyUGsh5l+uaosdkUPj9
	IQu2R9nkLxBcdGATwFcOBdd/hqUG5UrjzJQS26U5xPCtEwWDyMzSpDC07pNJAE7n
	zXhvHV4Y/bdsNQiyAs76Gt9hBuhVu65oG7S0qJlSI01Swu8jxDtvliwHK9aqHgyY
	tto7tjQ/zcaS3EKsAFI5dhyci/UWx85ImR5axKyl3FdmBv9xw8oqelsxFYcygwpn
	yWMuMW2xpixPvs4eDgy0b7liAy9EkX+8LJc6frjdmaegicFSBzmtTd0Vqd+arrMg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5r202-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:37:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49G9WWOo004915;
	Wed, 16 Oct 2024 09:37:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5r1yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:37:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8WwhZ005946;
	Wed, 16 Oct 2024 09:37:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42865105sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:37:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G9ax0L18940368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 09:36:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5952F2004B;
	Wed, 16 Oct 2024 09:36:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B31A20040;
	Wed, 16 Oct 2024 09:36:55 +0000 (GMT)
Received: from [9.124.220.43] (unknown [9.124.220.43])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2024 09:36:55 +0000 (GMT)
Message-ID: <c8dd612a-1851-471f-b5c5-f4201593e7b0@linux.ibm.com>
Date: Wed, 16 Oct 2024 15:06:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-2-ankur.a.arora@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241009165411.3426937-2-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JsMaHPEng6uTVByfH41hZVFNX1cOu3dv
X-Proofpoint-GUID: ZQeHq2MQ5hslzMb9JPzVF9oC8q71SHMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160061



On 10/9/24 22:24, Ankur Arora wrote:
> resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
> without rescheduling for more than the latency_warn_ms period.
>

I am bit confused here. Why do we need to warn if LAZY is set for a long 
time?

If lazy set, the subsequent tick, it would be set to upgraded to 
NEED_RESCHED.

Since the value of latency_warn_ms=100ms, that means even on system with 
HZ=100, that means 10 ticks before that warning would be printed no?


IIUC, the changelog c006fac556e40 ("sched: Warn on long periods of 
pending need_resched") has the concern of need_resched set but if it is 
non-preemptible kernel it would spend a lot of time in kernel mode. In 
that case print a warning.

If someone enables Lazy, that means it is preemptible and probably this 
whole notion of resched_latency_warn doesn't apply to lazy. Please 
correct me if i am not understanding this correctly.

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   kernel/sched/core.c  | 2 +-
>   kernel/sched/debug.c | 7 +++++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 694bfcf153cb..1229766b704e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
>   	if (sysctl_resched_latency_warn_once && warned_once)
>   		return 0;
>   
> -	if (!need_resched() || !latency_warn_ms)
> +	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
>   		return 0;
>   
>   	if (system_state == SYSTEM_BOOTING)
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 9abcc6ead11b..f0d551ba64bb 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1293,9 +1293,12 @@ void proc_sched_set_task(struct task_struct *p)
>   void resched_latency_warn(int cpu, u64 latency)
>   {
>   	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
> +	char *nr;
> +
> +	nr = tif_need_resched() ? "need_resched" : "need_resched_lazy";
>   
>   	WARN(__ratelimit(&latency_check_ratelimit),
> -	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
> +	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
>   	     "without schedule\n",
> -	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
> +	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
>   }



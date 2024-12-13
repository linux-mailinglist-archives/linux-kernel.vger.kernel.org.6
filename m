Return-Path: <linux-kernel+bounces-445032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9B9F1027
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1C6162E99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49CF1EC00B;
	Fri, 13 Dec 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KX1702B2"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245A1EB9F7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101900; cv=none; b=lduHsJZAoHyOaziivgB/+b6pVcPzvR8VdIk1d8EpcgAs2dCKyXPILoyr0R2h8Rc9yPlA2c7jcRpNOqvoJX7v1f/cIBb+3uwOxXfnWiOg0IskfkbgoEQKJ74tnA9NrTIKBk1bkid4TmUWWSk7E+WKouNLwrIlXqXImX/pCvzRFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101900; c=relaxed/simple;
	bh=ETrhrfSm8SuXi7TD8b6A7t/bfSYz17h+tkqVOgkdbD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD0XAHEUzXZjss6q6VciUgr+84Z645BaZXNy77Si+4rflSdCGrITviC7Fk+xvwLcHjzcAwx3do5Tv5V7iBZ8bIKDNJnFaLIoBryXQy1EMIIttQiG3nvLj86tv78tck3kuro1yNr1fQZFd6/3qjUHHAaBWYit0nk9eOcG3ty0hNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KX1702B2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIu2Z006419;
	Fri, 13 Dec 2024 14:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iHkuTP
	yAoCmozzxa8vAo5RtIF97SumMfoFb56805b+o=; b=KX1702B2WgbiB+L7iYronb
	SSza/ZCC9xCGa9ohp6hNdQEPx7o982AWGtrnOx5ULJqN5PSU2A+1ik56IltjG0rk
	1Z9w30Xl6Y8k7+ugoPvK2t5c59sO3qCxwDSSUzuZ8HQzbPoNuPEwsSCktboMZgx9
	lIuriejQyfacEnuYVPG6iIq0EuovO4ZXlwGCOdr5eLy1tEm+fA8HNhLJP3UUXthr
	dXfrMv2sdMcY3CLpDpjXEgCT3Crb3Akbh6EhIuSrcbE9fFKBa1z7Fm99qGAv8LNC
	utcK63q/B0foNpu6l6R0YpWQk7o4pq3xFwz7zbp/CVn9F30kV5BSfbIoQUH8n5ew
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9nbbhuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:57:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDEvpbI028689;
	Fri, 13 Dec 2024 14:57:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9nbbhue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:57:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBg69a007865;
	Fri, 13 Dec 2024 14:57:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11ytty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:57:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEvm5x64422160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:57:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96C8A20043;
	Fri, 13 Dec 2024 14:57:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157DC20040;
	Fri, 13 Dec 2024 14:57:44 +0000 (GMT)
Received: from [9.124.213.1] (unknown [9.124.213.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:57:43 +0000 (GMT)
Message-ID: <3ce396ad-162c-4e60-90ee-01fd58a514de@linux.ibm.com>
Date: Fri, 13 Dec 2024 20:27:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] sched/fair: Do not compute overloaded status
 unnecessarily during lb
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-8-kprateek.nayak@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241211185552.4553-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z2ELeCwGM-SYul3EJjpxmm5ilLdvaR_U
X-Proofpoint-ORIG-GUID: OIKc_nmc_xxH4pxCSyVBZ-8RE54qJDn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130103



On 12/12/24 00:25, K Prateek Nayak wrote:
> Only set sg_overloaded when computing sg_lb_stats() at the highest sched
> domain since rd->overloaded status is updated only when load balancing
> at the highest domain. While at it, move setting of sg_overloaded below
> idle_cpu() check since an idle CPU can never be overloaded.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/fair.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ec2a79c8d0e7..3f36805ecdca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   		nr_running = rq->nr_running;
>   		sgs->sum_nr_running += nr_running;
>   
> -		if (nr_running > 1)
> -			*sg_overloaded = 1;
> -
>   		if (cpu_overutilized(i))
>   			*sg_overutilized = 1;

Maybe its worth moving the overutilized too after the idle checks. An 
idle cpu can't be overutilized right?

>   
> @@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>   			continue;
>   		}
>   
> +		/* Overload indicator is only updated at root domain */
> +		if (!env->sd->parent && nr_running > 1)
> +			*sg_overloaded = 1;
> +
>   #ifdef CONFIG_NUMA_BALANCING
>   		/* Only fbq_classify_group() uses this to classify NUMA groups */
>   		if (sd_flags & SD_NUMA) {

Other than the point above,
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


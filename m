Return-Path: <linux-kernel+bounces-527386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE3A40A91
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F7A7AC49B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5BD207DFD;
	Sat, 22 Feb 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BKJSx94p"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AE1B21BD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244441; cv=none; b=B4k74u3fyKpq1lsinUsK1ULGS2Tj5rVdnCaJ9DBCFU2mp4rdpzQiQLbgBIczuPnTayLWmj77928rHyfKEAhTy3QtMzC8inyz/xyMbbMfyyfV0wRPmw3++RUV+lr9lpxjf63dLkl6BLtZIQYRrgfh/JGfl04cl/8OMLYnqk00urU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244441; c=relaxed/simple;
	bh=pAK/Eh+efca8Af2RHyG9P2cnCLEhPMxbSS7tCrOpfLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rV3Zc5ozoVhNzajwJYwA3wVelfnDBZTW+1FCKnUKj53z9ththsJD77zJgGMjesTMZhw9vqahEcWtgwA2KR62MCCOOKmerNiseX/UDxZ9nRw0QSqDhfdwIA8gLJe0BVcyyse5reOI+cI841tFL6VgG3ACOf0kjHiEy5AG0AX81kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BKJSx94p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MFrYe9012369;
	Sat, 22 Feb 2025 17:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=UEUgUvEDZFtzh6EbGpgl93Ca0V5lF5igav9WK5p8ZK8=; b=BKJSx94p1iqj
	ow0VRRdGjQwaH3DoSPN6FF/PCUugY0sWqAT4JPnKZJ9hq5FLrZdxMXzt4qt93Ssv
	ap9coewjiS3S6ZqSsvtOtw1jPOuenbOjvZTtNk5Ckw9AuwLHhkPgfGgR4zw2HGHb
	An24dVBFEJvUGPXrq9m/ZZBbTwrAaRwyGYtKUchkbvYGuuNOWoyeOLU7odLcqkUU
	UtVoaKDbNCa46GQIGm3HLHwUfhLm3L6W1agoiTKjrRwPoGqbDo54/uY+WJBkUK8n
	OxmjmshSySXeRLEE6/AA5nKG0ujg6hr/R9hszFU9D7IUogYOzXuAGWvQR+bDO/pQ
	QAm17fVYiQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y8d79vka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:13:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51MHD1NW004230;
	Sat, 22 Feb 2025 17:13:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y8d79vk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:13:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51MGF1eW002364;
	Sat, 22 Feb 2025 17:13:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xp4wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 17:13:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51MHCxPB19399258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 17:12:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00B8058065;
	Sat, 22 Feb 2025 17:12:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2D3B58052;
	Sat, 22 Feb 2025 17:12:53 +0000 (GMT)
Received: from [9.43.65.232] (unknown [9.43.65.232])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 17:12:53 +0000 (GMT)
Message-ID: <e8451617-a0f8-4650-9347-a2c46aa3898b@linux.ibm.com>
Date: Sat, 22 Feb 2025 22:42:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Do not let idle entities preempt others
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Josh Don <joshdon@google.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-2-wuyun.abel@bytedance.com>
Content-Language: en-US
Reply-To: 20250221111226.64455-2-wuyun.abel@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250221111226.64455-2-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AE59wJU3OkVd8DOvqH7zMU98U0w9nDr1
X-Proofpoint-GUID: qenrpaIV7_dXZMos0dP8h_ByM81Nyq_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=997 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220136

Hi Abel,

On 21/02/25 16:42, Abel Wu wrote:
> A task with SCHED_IDLE policy doesn't preempt others by definition, and
> the semantics are intended to be preserved when extending to cgroups
> introduced in commit 304000390f88 ("sched: Cgroup SCHED_IDLE support").
> 
> But current implementation allows idle entities to preempt each other
> on wakeup, which seems not behave as expected especially after
> commit faa42d29419d ("sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy")
> so fix this by explicitly skip wakeup preemption for idle entities.
> 
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..4340178f29b7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8778,12 +8778,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	pse_is_idle = se_is_idle(pse);
>  
>  	/*
> -	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
> -	 * in the inverse case).
> +	 * Preempt an idle entity in favor of a non-idle entity.
>  	 */
>  	if (cse_is_idle && !pse_is_idle)
>  		goto preempt;
> -	if (cse_is_idle != pse_is_idle)
> +
> +	/*
> +	 * IDLE entities do not preempt others.
> +	 */
> +	if (unlikely(pse_is_idle))
>  		return;

It makes sense that idle tasks don't preempt each other. The patch
preserves the original behavior: preemption occurs when the currently
running entity (cse) is SCHED_IDLE while the waking entity (pse) is not,
and it correctly returns when cse is not SCHED_IDLE while pse is
SCHED_IDLE.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

>  
>  	/*



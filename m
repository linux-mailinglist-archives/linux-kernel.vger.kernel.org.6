Return-Path: <linux-kernel+bounces-274173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCD947469
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 06:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F9F1C20C59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9513DDBD;
	Mon,  5 Aug 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6i52fJD"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EBA3B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832748; cv=none; b=XU42vb4ifrNbGNYjdg38NS28kox0TtApO6d42eA0P1y11FxKhnWzrGWZlXkGbKYz093mgB3ByV7H7YZMvvdW0Zw+WY2yoHx/lZxNibr/r+WoHWN4uyu1wZTUG2AuUkjV8Dxyd/TxrxrLBB7AHrmQTsnn/tqlPZ3NU6j5VXxl7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832748; c=relaxed/simple;
	bh=TmS/rU3y2zZ55dEGb7i+T3flql+xG/BiHcyHmyPweT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GSgZin5lpjEh9L5g6ppe+oBRNxVXJYBG6PWVaqNsXnA2lX2M418OY4Bimx96fEpk/m2JV+bfxWBQq3sOMIqEtRNJr4c6QUDjZ6J7ybWnS9rfkJMHtdV2SyE9ZWvNfXliz5wl9fa/XDUYlkKgyWfv1abkDbpll3YkRkbn4Sd913E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6i52fJD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4754MgP7008368;
	Mon, 5 Aug 2024 04:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:reply-to
	:in-reply-to:content-type:content-transfer-encoding
	:mime-version; s=pp1; bh=HmZTySZ+WAPy2xnrbZct2+B03jTiYzSsSfpUyHK
	ZW5U=; b=P6i52fJDqSfroRsT4b+Jtp6tW3uki6d0iusSfzFZ5W6B48TAI04a609
	MUoHuDdabOnOXmVYIJxtL4AFhqSye2dWZ1IDKVRsODx3ptgZQdzgsmMVRseqq71+
	lN0i9EyC/R8xImH03zEy0q+YiCS45G7NbO4qC3XVikXKaJNoYDJYhH7OxL84R07W
	NGBv7PrLqqLMSBFEQpaOvjC/DxS4Lon6cDJ2iE8F7CL98MXK0xjHXbIhyAl/25j7
	wrzjJoxFsjFKC2cJseyY37dnSgc7aRP6IfunF3F1gROHVqw02gnZyk/qpPq824PR
	QXw8qGeR00OzY238x/x/OB53K0KUcKQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tpv2r3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:38:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4754clmr001034;
	Mon, 5 Aug 2024 04:38:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40tpv2r3fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:38:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4753QsJW018020;
	Mon, 5 Aug 2024 04:38:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cmcktr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 04:38:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4754ciWM52756938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Aug 2024 04:38:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6900A5804E;
	Mon,  5 Aug 2024 04:38:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ABF85803F;
	Mon,  5 Aug 2024 04:38:37 +0000 (GMT)
Received: from [9.43.50.128] (unknown [9.43.50.128])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Aug 2024 04:38:37 +0000 (GMT)
Message-ID: <37d33316-8605-4076-a08c-02bce6ecef4a@linux.ibm.com>
Date: Mon, 5 Aug 2024 10:08:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen
 <tim.c.chen@intel.com>, Yujie Liu <yujie.liu@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: ZoFY/n2S7rMp6ypn@chenyu5-mobl2.wdc07v.mail.ibm.com
In-Reply-To: <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TUpyRAdIUbXHOCnGJxLOMJ9z6cBP8ZSs
X-Proofpoint-GUID: n2qs_KMagpUynncaUMF6-KfXzSwAsp7W
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-04_14,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408050025

Hi Chen Yu,

On 30/06/24 18:39, Chen Yu wrote:
> Hi Mike,
> 
> Thanks for your time and giving the insights.
> 
> On 2024-06-26 at 06:21:43 +0200, Mike Galbraith wrote:
>> On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 0935f9d4bb7b..7399c4143528 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>>>         p->migration_pending = NULL;
>>>  #endif
>>>         init_sched_mm_cid(p);
>>> +       p->prev_sleep_sum_runtime = 0;
>>> +       p->duration_avg = 0;
>>>  }
>>
>> Beginning life biased toward stacking?
>>
> 
> OK, so I should change the short_task() to skip the 0 duration_avg, to avoid
> task stacking in the beginning.
>    
>>>  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 41b58387023d..445877069fbf 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>>
>>> @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>  
>>>  dequeue_throttle:
>>>         util_est_update(&rq->cfs, p, task_sleep);
>>> +       if (task_sleep)
>>> +               dur_avg_update(p);
>>> +
>>>         hrtick_update(rq);
>>>  }
>>>
>>
>> That qualifier looks a bit dangerous.  Microbench components tend to
>> have only one behavior, but the real world goes through all kinds of
>> nutty gyrations, intentional and otherwise.
>>
> 
> Understand. Unfortunately I don't have access to production environment
> so I have to rely on microbenchmarks and a OLTP to check the result. I
> get feedback from Abel that the former version of this patch brought
> benefit to some short tasks like Redis in the production environment[1].
> https://lore.kernel.org/lkml/36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com/

Since the discussion was about real-life workload performance, I ran the DayTrader
workload with three users and three instances. The results show no performance
regression, and a 1% performance gain was observed, which is within the standard
deviation.

Thanks and Regards
Madadi Vineeth Reddy

> 
> I can launch a combination of microbenchmarks in parallel to check the impact.
> 
>> The heuristics in the next patch seem to exhibit a healthy level of
>> paranoia, but these bits could perhaps use a tad more.  Bad experiences
>> springs to mind when I stare at that - sleepers going hog, hogs meet
>> sleeping lock contention, preemption, sync hint not meaning much...



Return-Path: <linux-kernel+bounces-527670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D646FA40E0B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6AF3AD83C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A5203719;
	Sun, 23 Feb 2025 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S53qHt3K"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E191FC3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306368; cv=none; b=Gd5BS2wE7sOy5pvXSnkR7GxYnCEJBn8IZnvhtZhTGNa7kYTVGn5/h9bBIjb6eXF7WWqEoUaS9O3YSpjvYMWJP4xarD3qfIvatURvb8/e4WEaKrBKA+X3hN4XPLYwLDQdDSSta1slJcZgp43t88oznwSIw1+dfR+twtUoJSk+PFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306368; c=relaxed/simple;
	bh=gaNhMU2S/wgp7f+2ks25VlFLvxAQ/ZwgkcyVkyaKNCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFM+r7NPg+bMjQ9bGZeqrRJCHIOFkG5quE9B+lJqM4vzO/UAOq/KKXGhdjO51wWtlXMCrNC9z8QFay/evSztxOi1XKVqu30h1tdA4R/IYmAeb+brXWXpdJPvq0l48LY3c8rE0s93K70S3ZnD9SOZShwx+RgbpaCbgW4yQDGEP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S53qHt3K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N9pCbK006509;
	Sun, 23 Feb 2025 10:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Uq/lHRw172nORp768FZqQfELcCiWo+/hy/IabDy+wEk=; b=S53qHt3Kb87V
	ouexTYwEKn8Zhl/pXOK6GmmMr27UebbsNMK9qT2+adSdc+H0Xy6AcUev3ikr3kfl
	0CQVdbLfja1k+M7OmitZ2BQhUM3rJkENDJo7JZRxFrD3IWZMYGBn0CDXXb13OwtE
	AZvj1DgOREiLLP7UjoSaifAZltUEu/E8LcliRnRQbMz+6ZKcVzoyBiknsKd1M9ok
	dmmBuf//0ojSbDoFdnyLrZIFE1h9EaeLZ7Q0HUQFxVBZIBBY76qNNE+geeweOXLP
	KjNZbH1cGt3Dvk4d+MLZESjVeJSWyNhggUGjQS4MI3xkP/FnnrSG27eZx6Jvmlx6
	qw5E3GmYAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gm1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 10:25:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51NAO848031085;
	Sun, 23 Feb 2025 10:25:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44yxd6gm1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 10:25:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51NA0JVx026285;
	Sun, 23 Feb 2025 10:25:45 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswn1svr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Feb 2025 10:25:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51NAPivm24511076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Feb 2025 10:25:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EE1758058;
	Sun, 23 Feb 2025 10:25:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CA2B58057;
	Sun, 23 Feb 2025 10:25:38 +0000 (GMT)
Received: from [9.43.87.160] (unknown [9.43.87.160])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Feb 2025 10:25:37 +0000 (GMT)
Message-ID: <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
Date: Sun, 23 Feb 2025 15:55:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Josh Don <joshdon@google.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com
In-Reply-To: <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DRzPi2Vwbjy5K2oUU1YOOE66HX49j31E
X-Proofpoint-GUID: mhEkdHzFSChcZJwWwGlg5u4ANyGs17-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=952
 phishscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502230077

On 23/02/25 14:14, Abel Wu wrote:
> Hi Madadi,
> 
> On 2/23/25 2:16 AM, Madadi Vineeth Reddy Wrote:
>> On 21/02/25 21:27, Abel Wu wrote:
>>> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
>>>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>>>
>>>>> Idle tasks are by definition preempted by non-idle tasks whether feat
>>>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
>>>>
>>>> I don't think it's true, only "sched_idle never preempts others" is
>>>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
>>>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
>>>> others at wakeup, idle, batch or normal
>>>
>>> Hi Vincent, thanks for your comment!
>>>
>>> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
>>> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
>>> which said:
>>>
>>>      - no SCHED_IDLE buddies
>>>      - never let SCHED_IDLE preempt on wakeup
>>>      - always preempt SCHED_IDLE on wakeup
>>>      - limit SLEEPER fairness for SCHED_IDLE
>>>
>>> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
>>> The rules were introduced in 2009, and to the best of my knowledge there
>>> seemed no behavior change ever since. Please correct me if I missed
>>> anything.
>>
>> As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
>> it would help to document that SCHED_IDLE tasks are not preempted by non-idle
>> tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
>> preemptions for debugging would be lost.
>>
>> Thoughts?
> 
> I am not sure I really understand the purpose of this debug feature.
> If it wants to provide a way to check whether a performance degrade of
> certain workload is due to overscheduling or not, then do we really
> care about performance of SCHED_IDLE workloads and why?

It's true that we may not be too concerned about performance with
SCHED_IDLE. The issue is preserve the original SCHED_IDLE definition
versus WAKEUP_PREEMPTION, which applies across all policies. Since by
default the feature is true. I am not sure. Either way seems ok to me.

Thanks,
Madadi Vineeth Reddy

> 
> IMHO preempting SCHED_IDLE before WAKEUP_PREEMPTION is to preserve the
> IDLE semantics trying to behave like real idle task. It is somehow
> weird to me that we treat sched-idle cpus as idle while don't let the
> non-idle tasks run immediately on sched-idle cpus on debug case.
> 
> Thanks,
>     Abel
> 



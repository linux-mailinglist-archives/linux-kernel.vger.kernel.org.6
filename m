Return-Path: <linux-kernel+bounces-260457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0593A991
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2BDB1F231A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61996144D15;
	Tue, 23 Jul 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aK7ay1Iz"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D325760
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775669; cv=none; b=JJujyXEcTf8F3wiaGj18aO8z55c8+/nHRg7QknoUPoWYqCASR9o33j7AMTQhQsd0rymdJha+CksspzpjCknccNxshHIo3KXSkt9wt+iVBfPyw3nRJIRYgGcJ5bLu6hf+73kSC5szAteHl1R9TSjmt1jIne59D6PqOnmEk5K/8ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775669; c=relaxed/simple;
	bh=p3o3ikaSbPzYb0KzgZ5Uqx55rSbkN8vhnv4YFITjTvU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tgVyc2cU6HIvxsTM8qaEYZfJKMMchTrtQlggbG/KFJ4IdngvvcE4x3yipQ3KYzwbx3rEWr+Qpg8EvITj4/Zmn0e9v/7Nz+peFUz9WVamYbXFUMIelwicE4aGgzx261p2OvrM6ZtsadC+uVS06ham5vsfMkMGYgb0njVn8xKszm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aK7ay1Iz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NMsSaL014503;
	Tue, 23 Jul 2024 23:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	jeq9mGiBohznLK5HfyWpKm+VLWlp7ixM3DswxdLyJfE=; b=aK7ay1IzfcyDZz9y
	SRXMUYaoFVDRe9SUuBYoIClYoCrFRkQEom4sHLskTdqJFknfLhDwRzl1c/jEgCY9
	fCHp9E99ikgM1UEf/9hUyFI5lbzHgy7mx/uphBhlIaYcox2E+Yj6M24tyDOky6X1
	CEX4vx1kSXcmWtu0UIz7oNHvGAUaTq4noVu3sP/k8DgnwtzEydKwH+0tSrWlQD1w
	jfEgN1c/ie/fKKgswck+zZlW5Gya/I8B/s0oh4QsFpBtq/OM2P0J74NJFsV5RvPu
	pZuSP33GgtHizlFNDkHgLWzUBNbn/mN9aK/BCiFn/1jD2NzaVgVOv9TOrX5NVxYY
	Wk1KLg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j9fq9r96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 23:00:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46NN0e0I024487;
	Tue, 23 Jul 2024 23:00:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j9fq9r91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 23:00:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NKF7lT007070;
	Tue, 23 Jul 2024 23:00:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gx72mtyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 23:00:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NN0aaU31130290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 23:00:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE49958062;
	Tue, 23 Jul 2024 23:00:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF07858098;
	Tue, 23 Jul 2024 23:00:32 +0000 (GMT)
Received: from [9.43.92.6] (unknown [9.43.92.6])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 23:00:32 +0000 (GMT)
Message-ID: <d758614b-73e8-42a3-92d1-5d2424ee4e89@linux.ibm.com>
Date: Wed, 24 Jul 2024 04:30:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, chengming.zhou@linux.dev,
        linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
 <Zp_QzS-DUiE934X2@linux.ibm.com>
 <da5b5683-ed22-4e65-9e89-e22ff7f6cf2b@arm.com>
Content-Language: en-US
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <da5b5683-ed22-4e65-9e89-e22ff7f6cf2b@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tDCdTGp1uSJIJgrO1gPgMGGVM-75FmHX
X-Proofpoint-ORIG-GUID: R2HhIjLy0O33-U8-PBaMzE9mevlMFnVh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_15,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230161

On 24/07/24 2:40 am, Dietmar Eggemann wrote:
> On 23/07/2024 17:48, Vishal Chourasia wrote:
>> On Tue, Jul 23, 2024 at 07:42:47PM +0800, Chuyi Zhou wrote:
>>> In reweight_task(), there are two situations:
>>>
>>> 1. The task was on_rq, then the task's load_avg is accurate because we
>>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>>
>>> 2. The task is sleeping, its load_avg might not have been updated for some
>>> time, which can result in inaccurate dequeue_load_avg() in
>>> reweight_entity().
>>>
>>> This patch solves this by using sync_entity_load_avg() to synchronize the
>>> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
>>> For tasks were on_rq, since we already update load_avg to accurate values
>>> in dequeue_task(), this change will not have other effects due to the short
>>> time interval between the two updates.
>>>
>>> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>> Changes in v3:
>>> - use sync_entity_load_avg() rather than update_load_avg() to sync the
>>> sleeping task with its cfs_rq suggested by Dietmar.
>>> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
>>> Changes in v2:
>>> - change the description in commit log.
>>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>>> suggested by chengming.
>>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>>> ---
>>>  kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
>>>  1 file changed, 24 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 9057584ec06d..da3cdd86ab2e 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>  	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>>>  					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>>>  }
>>> +
>>> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>>> +{
>>> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
>>> +				 cfs_rq->last_update_time_copy);
>>> +}
>>> +
>>> +/*
>>> + * Synchronize entity load avg of dequeued entity without locking
>>> + * the previous rq.
>>> + */
>>> +static void sync_entity_load_avg(struct sched_entity *se)
>>> +{
>>> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>> +	u64 last_update_time;
>>> +
>>> +	last_update_time = cfs_rq_last_update_time(cfs_rq);
>>> +	__update_load_avg_blocked_se(last_update_time, se);
>>> +}
>>> +
>> The difference between using update_load_avg() and
>> sync_entity_load_avg() is:
>> 1. update_load_avg() uses the updated PELT clock value from the rq
>>    structure.  
>> 2. sync_entity_load_avg() uses the last updated time of
>>    the cfs_rq where the scheduling entity (se) is attached.
>>
>> Won't this affect the entity load sync?
> 
> Not sure what you mean exactly by entity load sync here.
load avg sync for the wakee
> 
> The task has been sleeping for a long time, i.e. its PELT values haven't
> been updated or a long time (its last_update_time (lut) value is pretty
> old).
> 
> In this meantime the task's cfs_rq has potentially seen other PELT
> updates due to PELT updates of other non-sleeping tasks related to this
> cfs_rq. I.e. the cfs_rq lut is much more recent.
> 
> What we want to do here is to sync the sleeping task with its cfs_rq. If
> the task was sleeping for more than 1us (1024ns) and we cross a 1ms PELT
> period (1024us) when we use cfs_rq's lut as the 'now' value for
> __update_load_avg_blocked_se() then we will see the task PELT values decay.
> 
> We rely on sync_entity_load_avg() for instance in EAS wakeup where the
> task's util_avg influences on which CPU type the task will run next. So
> we sync the wakee with its cfs_rq to be able to work with a current task
> util_avg.
I was talking about the case where all the tasks on a cfs_rq are sleeping.
In this case, lut of the cfs_rq will be same as, at the time of last dequeue.

And, wakee is been woken up (suppose) after 1us window


I guess, in this case pelt metric would not have changed for the cfs_rq

Thanks
-- vishal.c



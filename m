Return-Path: <linux-kernel+bounces-252567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783A931551
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E54CB210BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0222B18C320;
	Mon, 15 Jul 2024 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahT1SP/X"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3472172BA6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048745; cv=none; b=O+JvMVnheQdybp6yW+3kt1AetpUA3+FFag5z6/UnVqOYlRDOee4HUdGqtWkx6h0QzG6lqHwZLfxJ49AEWE0ZTV+hqRsvIa0WhsWfwq0ojatFr/NtqW7vlHZlXR3XORTaRTqqtxOH9Cl2OJIWJBDykd7bAbDs8PaX2GabN95SC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048745; c=relaxed/simple;
	bh=/1PS59mVRV6Xv1lVlTssQUd2p/SagHtxgxIvX5Ft0Ns=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=m39v75X/XKHpsZg0TE0t5XPtzQgnWdRkh2xY70PGmSespT23Hi0M4zHTUACCe1+PlX6KoOpeZX5Z8bIIqACIR0l4wMVTW0Gk9ND2ktc5HXjZ08NtbN6TZevpP3/hIrUovzuvYXT9RzpCH7RKLfIYOM036EUunznXAYNoXuVo5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahT1SP/X; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7611b6a617cso2528984a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721048743; x=1721653543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8TzOv/RkYZEdAKVPlxezOS+UCgONHV6iTjvvjprWNI=;
        b=ahT1SP/XXjSREStKTKpYrzAvmMO6k1VHH7dgKJ5S5hgMaGTSma7SO3eKClTF4AjJRx
         hdDmtZ4tooC7uQ4rGC1OnlNjagNk3QGm8PWrFNs10CxcijKiAOnsV7RJBgSC86PkPwYM
         MtEyo7sQiuYeIEVqM5MGra15tdFDhx9+nOm6/V0+ISSMB1/CZMJ6Da8iOQxdEzLx0TVY
         CtiHXZO7LFtkeyhKl5tirn9fHVCj/bfDiUKxJ4pWnQi4xZrbacH47Ue6NsRZRuOrKzF3
         6p9nG/1z3GHAiN3ZHSFq6WToXEDWflqExBlRG5f3d7DI49qT5u6y2U/dP57RFq1fBnig
         BgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048743; x=1721653543;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8TzOv/RkYZEdAKVPlxezOS+UCgONHV6iTjvvjprWNI=;
        b=Y4pfu4G7v43+TMQgEJ4sL0DQE3MoYF2UYE2OkWCER+hg9Jax7I8Vogzz2fZzEc0RYc
         etAV5g0ttFuyiIXmgQB3mRrZXT5o2j3usD7/L7uzzAr/zOZXxrC7fjsgGxzjNWYxowhP
         dwaOVkNuvYlnwx6FAkR5SwVtg/xfRifkjUHbYl004OhqGXKLIB9EpB7hxgagY8eFz86P
         5+N4fXUxhdPaDbYRATvQc+iXveS1HXtbUJ1MJI8n0i9rXNoN5j/D6fVB6baZ9Ql7xmyu
         kTqexYR4V+d6zwD0QQqR+RJkZDDfC2loLZVG/eN/UxiHhzRFWfWsF4H4GUxijQ/yS3n0
         Yx+A==
X-Forwarded-Encrypted: i=1; AJvYcCWWr22CU7L2g0i2IJqqsddMsuurJlU8jUrJfEVhFPIjWJize098VYow6UuntAT+sMA9LcgEbGnc2SVgIuEa11hf6eT0SaZSP7GPKLlE
X-Gm-Message-State: AOJu0Yx5L0nbkpB2ZnJVxnWjbddQecqUSU7FIk+IscBnzSfaQOYfbbgf
	ZZAxoxpXqHY1mvFhTqEvdGoqIYgjTQK0LweHqw4eLV0ilpI6Hdv/
X-Google-Smtp-Source: AGHT+IGhIlYVyzNODcuDIe1egfQbfKzXzT3jHQd/TRdcrVb1VM0jAbOottvs5cCYcJiDLyj5GUQKgA==
X-Received: by 2002:a05:6a21:680b:b0:1c0:f785:b2c3 with SMTP id adf61e73a8af0-1c298216488mr16020638637.2.1721048742763;
        Mon, 15 Jul 2024 06:05:42 -0700 (PDT)
Received: from [10.125.112.27] (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9a5d2sm40194595ad.67.2024.07.15.06.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 06:05:42 -0700 (PDT)
Message-ID: <e53a487f-e811-45de-a188-cadffd8a3a97@gmail.com>
Date: Mon, 15 Jul 2024 09:05:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Preempt if the current process is
 ineligible
From: John Stills <johnstills191@gmail.com>
To: Chunxin Zang <spring.cxz@gmail.com>
References: <20240613131437.9555-1-spring.cxz@gmail.com>
 <20240620125155.GY31592@noisy.programming.kicks-ass.net>
 <8B4C4FA2-C261-4723-ABA4-2EF3CBBB2C0E@gmail.com>
 <36B22124-E952-4508-A4A3-5AE2C944FBDF@gmail.com>
 <9e56b874-724e-4c2e-8e7d-db6317cb414c@gmail.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 Chen Yu <yu.c.chen@intel.com>, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 Mike Galbraith <efault@gmx.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Honglei Wang <jameshongleiwang@126.com>, Chen Yang <yangchen11@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>
In-Reply-To: <9e56b874-724e-4c2e-8e7d-db6317cb414c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> On Jun 21, 2024, at 21:53, Chunxin Zang <spring.cxz@gmail.com> wrote:
>
>
>
>> On Jun 20, 2024, at 20:51, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Jun 13, 2024 at 09:14:37PM +0800, Chunxin Zang wrote:
>>> ---
>>> kernel/sched/fair.c | 28 +++++++++++++++++++++-------
>>> 1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..21ef610ddb14 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -745,6 +745,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, 
>>> struct sched_entity *se)
>>> return vruntime_eligible(cfs_rq, se->vruntime);
>>> }
>>>
>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct 
>>> sched_entity *se)
>>> +{
>>> + if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <= 1 ||
>>> +    entity_eligible(cfs_rq, se))
>>> + return false;
>>> +
>>> + return true;
>>> +}
>>> +
>>> static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>>> {
>>> u64 min_vruntime = cfs_rq->min_vruntime;
>>> @@ -974,11 +983,13 @@ static void clear_buddies(struct cfs_rq 
>>> *cfs_rq, struct sched_entity *se);
>>> /*
>>> * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>>> * this is probably good enough.
>>> + *
>>> + * return true if se need preempt
>>> */
>>> -static void update_deadline(struct cfs_rq *cfs_rq, struct 
>>> sched_entity *se)
>>> +static bool update_deadline(struct cfs_rq *cfs_rq, struct 
>>> sched_entity *se)
>>> {
>>> if ((s64)(se->vruntime - se->deadline) < 0)
>>> - return;
>>> + return false;
>>>
>>> /*
>>> * For EEVDF the virtual time slope is determined by w_i (iow.
>>> @@ -995,10 +1006,7 @@ static void update_deadline(struct cfs_rq 
>>> *cfs_rq, struct sched_entity *se)
>>> /*
>>> * The task has consumed its request, reschedule.
>>> */
>>> - if (cfs_rq->nr_running > 1) {
>>> - resched_curr(rq_of(cfs_rq));
>>> - clear_buddies(cfs_rq, se);
>>> - }
>>> + return true;
>>> }
>>>
>>> #include "pelt.h"
>>> @@ -1157,6 +1165,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>> {
>>> struct sched_entity *curr = cfs_rq->curr;
>>> s64 delta_exec;
>>> + bool need_preempt;
>>>
>>> if (unlikely(!curr))
>>> return;
>>> @@ -1166,12 +1175,17 @@ static void update_curr(struct cfs_rq *cfs_rq)
>>> return;
>>>
>>> curr->vruntime += calc_delta_fair(delta_exec, curr);
>>> - update_deadline(cfs_rq, curr);
>>> + need_preempt = update_deadline(cfs_rq, curr);
>>> update_min_vruntime(cfs_rq);
>>>
>>> if (entity_is_task(curr))
>>> update_curr_task(task_of(curr), delta_exec);
>>>
>>> + if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
>>> + resched_curr(rq_of(cfs_rq));
>>> + clear_buddies(cfs_rq, curr);
>>> + }
>>> +
>>> account_cfs_rq_runtime(cfs_rq, delta_exec);
>>> }
>> Yeah sorry no. This will mess up the steady state schedule. At best we
>> can do something like the below which will make PREEMPT_SHORT a little
>> more effective I suppose.
>>
>>
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -985,10 +985,10 @@ static void clear_buddies(struct cfs_rq
>> * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>> * this is probably good enough.
>> */
>> -static void update_deadline(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se)
>> +static bool update_deadline(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se)
>> {
>> if ((s64)(se->vruntime - se->deadline) < 0)
>> - return;
>> + return false;
>>
>> /*
>> * For EEVDF the virtual time slope is determined by w_i (iow.
>> @@ -1005,10 +1005,7 @@ static void update_deadline(struct cfs_r
>> /*
>> * The task has consumed its request, reschedule.
>> */
>> - if (cfs_rq->nr_running > 1) {
>> - resched_curr(rq_of(cfs_rq));
>> - clear_buddies(cfs_rq, se);
>> - }
>> + return true;
>> }
>>
>> #include "pelt.h"
>> @@ -1168,6 +1165,8 @@ static void update_curr(struct cfs_rq *c
>> {
>> struct sched_entity *curr = cfs_rq->curr;
>> s64 delta_exec;
>> + struct rq *rq;
>> + bool resched;
>>
>> if (unlikely(!curr))
>> return;
>> @@ -1177,13 +1176,23 @@ static void update_curr(struct cfs_rq *c
>> return;
>>
>> curr->vruntime += calc_delta_fair(delta_exec, curr);
>> - update_deadline(cfs_rq, curr);
>> + resched = update_deadline(cfs_rq, curr);
>> update_min_vruntime(cfs_rq);
>>
>> if (entity_is_task(curr))
>> update_curr_task(task_of(curr), delta_exec);
>>
>> account_cfs_rq_runtime(cfs_rq, delta_exec);
>> +
>> + rq = rq_of(cfs_rq);
>> + if (rq->nr_running == 1)
>> + return;
>> +
>> + if (resched ||
>> +    (curr->vlag != curr->deadline && !entity_eligible(cfs_rq, curr))) {
>> + resched_curr(rq);
>> + clear_buddies(cfs_rq, curr);
>> + }
>> }
>>
>> static void update_curr_fair(struct rq *rq)
> Hi peter
>
> Got it. If I understand correctly, modifications to basic interfaces 
> like update_curr
> should be appropriate and not too aggressive. Additionally, these 
> changes have
> already shown significant improvements in scheduling delay (test 
> results are at the
> end). How about we limit this patch to these changes for now? 
> Actually, I also want
> to try a more aggressive preemption under NO_RUN_TO_PARITY, but it 
> might be
> better to consider this comprehensively after integrating the changes 
> from your
> latest branch.
>
>
> Comparison of this modification with the mainline EEVDF in cyclictest.
>
>                                  EEVDF      PATCH EEVDF-NO_PARITY  
> PATCH-NO_PARITY
>
>   LNICE(-19)    # Avg Latencies: 00191      00162      00089 00080
>
>   LNICE(0)      # Avg Latencies: 00466      00404      00289 00285
>
>   LNICE(19)     # Avg Latencies: 37151      38781      18293 19315
>
> thanks
> Chunxin
>
>
Hi Chunxin

The latency test results look great. Have you conducted tests in other 
scenarios, such
as performance testing in production networks or machine learning?

-- 
thanks,
John





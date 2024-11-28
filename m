Return-Path: <linux-kernel+bounces-424647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68399DB76C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FF28465B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F81993B1;
	Thu, 28 Nov 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5lGGcmJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B45144D1A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796299; cv=none; b=RSH8hBaLGiQqdaLV6qKJmKsXMEdGE4S7TCZ2DKjcsraqjsrZSBcbe7RDTTsFGTXvU/kHNncYAYhQm35LBLR8/kA/Ako5Qap4eB+c2tcskeMsSlMSDfOHIukHvnBgRmhCGeb70F1GaNC3JybXONsj7xoG96yRG0D2H5lWuhpNxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796299; c=relaxed/simple;
	bh=NnH9GyhWLdeazNa9bR6YDThCX6tojCB8eAUbzgRWlRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrBC1ux4rAHQXV1LxyzGZxF9J/3oXJhnwtM4CXd5Z4uAIEcXbR2k7dG5rhSsuaoVlwAeLCucI/UuBftIHMZLJ38JIn6r5mPQvqjI7UicBh5BgMi8ekzSdPUNnJ/DPuHcYpIFLrywAmsGvNANbziNYBapmBbisRWejgp57KspbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5lGGcmJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2124a86f4cbso6116575ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732796297; x=1733401097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1WUqFXk0TRJjO6Uhse/7Dxkc25tvKDuBA948pFVisA=;
        b=Y5lGGcmJ+qLjb0lTulRy37m9UVCPATik9E31ZOh/dBa+LRyRx4lNDe2GZYetBmTDqD
         MJCFkiAdQWQzrMNhWlu0RZt52pymJ7dmVVgBf3hxiMHP9vcRZUq3OdY08PCw04+LjRlI
         P5Yai7PbRTOBYb4WUDE7KwFfj0UBNP4shg7sCNYPkPkYGGRQmhZLApcugqjpoQ+ncySd
         Uit50/keNHXKisK9FScFs81/Gif57vGaAtqtU38As8fnwe12uu1VQOoMMCMjOINZnQ9+
         G+kny+94LTvFmtWPkMEyL/PFgAFHrr5Li0fgfqmNRLrcYmgEcvC0Vo7kwsfrtRHBUC9D
         zksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732796297; x=1733401097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1WUqFXk0TRJjO6Uhse/7Dxkc25tvKDuBA948pFVisA=;
        b=KEklc7pixNjxYPyGryw8ChlnznXt/wgUto5NMkpNi3U8q7RkTVQihHJmbbyKgq7C1N
         h1/Lv0wvINPHX59p+B4J5oqszlUeIlOorxsaRYIASfa7geq+8edh3ZZ5YGd+wiZw3QRG
         jyuU59LkbdC2s5nW4iFLv2j/bvlHVPt8/Wxv1bOMx28cksDLwfPd/Ju6DYB6y7OOnHqG
         Lgjsm4AA6tU44yZx3pXN9DSgVC00EauoSU3m88vq6ngcRBsCpWn/Om/H6BM+9lqBkzg0
         8usfIG4/73dsUYKOMicAcuW/1LNNbd+5UCh9RGAbIySqUh46ghm63gB2u0W5LIiiqtCm
         YyJA==
X-Forwarded-Encrypted: i=1; AJvYcCXAsHUtQygWJCqdQb6d+2wTC5JNmIuzotmtO0ko6dCaSrNwY1Xlca0Y3cz50hk2+FeHhwZXqBo3Q105ndk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bwp/6fW3ILE9YcXw92c0IVvQc/skKqSFIy2/i0IRVxdAlAtv
	aec3fA+gs+9YVzVvTZlnYMeYR0tX28fkh5O3Kv1ET/7g2yHYMKAG
X-Gm-Gg: ASbGncu7m/vA6sQ2/acDcQjLMruQmjGnXTHyK7qDQJnrXR7ZI3KqdaBJuoGpDvzMJ1o
	Wp6IKfqoool3h9Q2UiE8nx9oUqoO73V1dtqWC1r6Cn084wg9cGu/S50+4x2x5f4ub6nqJkxu5at
	iRPJSUAcsRUvYCQIT7GK/tWLiw3iOCzsamzKbHn7+PKg4saUFI3jDLmS0FTm7MHKFSgPL2ORP+R
	nbkD1ceOohrcwOE+oGwx2BzXuMNAjrRcW/FK4D9VV7xDCc9fBPlqVM9L7lqCY/Pwx4vazGZRyzP
	mfUTQeDqw7K4L54DZlvoejOxqaUs
X-Google-Smtp-Source: AGHT+IFI1l7n7D5h1Aiob7vF3L6/kLv1K7lTjOwvaE1tEKSlo06h5Ng74csWc4nMYM6Wp9Bp3WEK9g==
X-Received: by 2002:a17:903:244d:b0:20b:b93f:300a with SMTP id d9443c01a7336-21501086e30mr80764025ad.7.1732796296750;
        Thu, 28 Nov 2024 04:18:16 -0800 (PST)
Received: from [10.125.112.12] (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521969ea0sm12203835ad.168.2024.11.28.04.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 04:18:16 -0800 (PST)
Message-ID: <18533ecd-0000-47f7-df24-f4f7ed45862e@gmail.com>
Date: Thu, 28 Nov 2024 20:18:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/core: Do not migrate ineligible tasks in
 sched_balance_rq()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, linux-kernel@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20241128084858.25220-1-jiahao.kernel@gmail.com>
 <20241128091929.GA35539@noisy.programming.kicks-ass.net>
 <0d28126d-4324-ba19-fe12-4f7a0ec0192f@gmail.com>
 <20241128114722.GG24400@noisy.programming.kicks-ass.net>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20241128114722.GG24400@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/28 19:47, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 07:30:37PM +0800, Hao Jia wrote:
>>
>>
>> On 2024/11/28 17:19, Peter Zijlstra wrote:
>>> On Thu, Nov 28, 2024 at 04:48:58PM +0800, Hao Jia wrote:
>>>> From: Hao Jia <jiahao1@lixiang.com>
>>>>
>>>> When the PLACE_LAG scheduling feature is enabled, if a task
>>>> is ineligible (lag < 0) on the source cpu runqueue, it will
>>>> also be ineligible when it is migrated to the destination
>>>> cpu runqueue.
>>>>
>>>> Because we will keep the original equivalent lag of
>>>> the task in place_entity(). So if the task was ineligible
>>>> before, it will still be ineligible after migration.
>>>
>>> This is not accurate, it will be eleigible, irrespective of lag, if
>>> there are no other tasks. I think your patch tries to do this, but I'm
>>> fairly sure it got it wrong.
>>
>> Thank you for your reply. The expression in my commit message is inaccurate,
>> and I will correct it in the patch v2. If I understand correctly, a task
>> meeting the following conditions:
>>
>>   sched_feat(PLACE_LAG) && cfs_rq->nr_running && !entity_eligible(cfs_rq,
>> &p->se),
>>
>> will remain ineligible both before and after migration.
>>
>> If I am wrong, please correct me. Thank you!
> 
> Problem is you're checking the wrong nr_running.

Oops, that's my mistake. Thank you very much for pointing it out.

I should be focusing on the nr_running of the destination cfs_rq.

Thanks,
Hao

> 
>>>> @@ -9358,13 +9358,14 @@ static inline int migrate_degrades_locality(struct task_struct *p,
>>>>    static
>>>>    int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>    {
>>>> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> 
> This is task's current cfs_rq. What you're interested in is destination
> cfs_rq. If the destination is empty, then lag is irrelevant.
> 
> You want something like:
> 
> #if CONFIG_FAIR_GROUP_SCHED
> 	struct task_group *tg = task_group(p);
> 	struct cfs_rq *dst_cfs_rq = tg->cfs_rq[env->dst_cpu];
> #else
> 	struct cfs_rq = &env->dst_rq->cfs_rq;
> #endif
> 
> 
> Also, please add benchmark details that show this actually makes a
> difference.
> 
> Notably we keep rq->cfs_tasks in MRU order; most recently ran task is
> head and balancing takes from the tail, the task longest not ran.
> 
> The task longest not ran should have build up eligibility.

Thank you for your suggestion. It might be as you said, that inefficient 
task migrations are relatively rare in load balancing. I will use some 
benchmarks from MMTests for testing.

Thanks,
Hao


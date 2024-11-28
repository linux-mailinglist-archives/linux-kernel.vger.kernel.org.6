Return-Path: <linux-kernel+bounces-424598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB789DB686
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9294164291
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DF9197A92;
	Thu, 28 Nov 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8NhVWw7"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33890190468
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732793446; cv=none; b=Xr4oxwodAehLNqxUskzqXaq7w9w+JSB4gt9prS8KAg6UDnqKezd1V3utZ2XBLiyngZ+USuj1F4GmuIFPLTpUyDEEDic473qmAgpaFKl7SZXpGrIlolOi3Yoj58Q8KCoVQ7cGn90OKf3TRNFYHk1Ekc/e0JEl1WVufWbBrqtLzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732793446; c=relaxed/simple;
	bh=d8v9r+oBH4sHr4d822UtL7n7GNzq2i/4M7noKksPepQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0xMOAxzEhCEatcUx+BkUBx8RQ06Oew/SH0LOslJUBS7ikp+DKWv523MOzjlEIDK9IB2rbvZUrJmEqgrkzTBHiJWfmSiarodC0O/m8SQ8yb3pqydOPO0NlntJc8a2FP8akvojYSXUg29RL8B0ZM3PnkcuRKU/i57mgj0Yeq2YmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8NhVWw7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f0f6300aso845256b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732793444; x=1733398244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc07jtJ0RIHyeJegeBd/bTxNMBc/5zboOnYaN0hUYgg=;
        b=F8NhVWw7KGZMYT2ZDIf5/wv9IPAsICW58ajoI8ZGIZANYm5ovSfMeyYXHHrZxHPPdc
         /Y8ADACK4/m+SsGQg80BPVGuWmgkt3u8/abWd88Ds1AsRyClhv76w+YncidqwyLZjsW6
         tToAjGIsc+FEPVPceodqTEluXsO11oV/Zbwfq5JM74bpklnPITQS8tsCm+19nYoo/uNu
         6J+qGQYbYq30runxWClfnMsXKUqUKJOZmDYIgeDxulQGenMTIgXfk0nsNfMlloXtj7A2
         4Mt2EOsNcUre7/zx3TQEpBjSU4RziKWJN1I/+bJ6nBhnERU+FZNP7MfMMs7xrQaAO0zB
         xYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732793444; x=1733398244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nc07jtJ0RIHyeJegeBd/bTxNMBc/5zboOnYaN0hUYgg=;
        b=m7C3IGN13HrJ64VpKr0ICHi/dD5v2QN/vXGSHt/qQQ4q92rDWSLQKETNXs0uXxGJsH
         xS4FiUa1kkhLkHr/IqSgHkscQB9kwfW0KDR4eIZ1dGY1CeKMKlwJPzToQ5Qd0y9Lfcag
         3f8Qg4JalKP9+Ex7MIjsdJFBRQIPdUwwyz7plktld/7nVs7OpDd+0J8YwVaiA17drVhx
         ANx1jsqDaGLUHWy2d4R4G/ARe3Iy+TF1Zs35YKj2f7+lSxmAYbadPdS5GXpfF/DjN65w
         Dnq35F6i72l3A0QPtlVEmL2/b85H0C2CeF9b1ZO2Bg9/RL29MJG98RrwrYND2mtIu5Xi
         ouBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSuoQ4AxydLKjy7xF0UQA8cqFt6JCFPAuNYPIq39bG37e1qnJWs2cAEJCWrr4XsFAo7blclYfhQ+q+0lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYmbHAuNz71Hi0BgDzor3/2hbCwQmPtC9yzz8AdMF5XMlvmhq
	yMVYXdjmI2emqRbE5CaUyltWLxjVfeU4eq7HKp/k4Ynbt838n7CW
X-Gm-Gg: ASbGnct4oW6TKxPOW+e7g3AFAJI6952o/iELYBJ9iBarOmjm1G+GO1bVE6jAtZy4MRS
	sBcgHiPwl65mKGwzPH26kEpN4veBmej2nYZ3fwPv7DS6L+9GszwTkpWeiEsqvIBeaCy8I4clql3
	xn4m9dxwDHfwI1sIDibrahyjWKcJqEmvS4b6y8gljIcIZ2ohikbhL5wlsirAwHRKjeriK0KkkRk
	vTM17dMU+lIldVtXC61a5oa03rI9yQbmuNs6kZbsFIer0UzvRL6iWNQhcKi/moDkZplFHqkT2qI
	h/qS6gNoWmFdPF/NZ7MHpjiRqt7k
X-Google-Smtp-Source: AGHT+IG7Hqn7AgQZO0w2GF/10fzkTUN05dczXmv+a2ta7UH+V8NOAXHWkl57XNzUirGOQxS1GtHbww==
X-Received: by 2002:a05:6a00:3c89:b0:724:eac3:576a with SMTP id d2e1a72fcca58-725301a5b92mr8616167b3a.25.1732793444215;
        Thu, 28 Nov 2024 03:30:44 -0800 (PST)
Received: from [10.125.112.12] (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254180fbbasm1287202b3a.135.2024.11.28.03.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 03:30:43 -0800 (PST)
Message-ID: <0d28126d-4324-ba19-fe12-4f7a0ec0192f@gmail.com>
Date: Thu, 28 Nov 2024 19:30:37 +0800
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
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20241128091929.GA35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/28 17:19, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 04:48:58PM +0800, Hao Jia wrote:
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> When the PLACE_LAG scheduling feature is enabled, if a task
>> is ineligible (lag < 0) on the source cpu runqueue, it will
>> also be ineligible when it is migrated to the destination
>> cpu runqueue.
>>
>> Because we will keep the original equivalent lag of
>> the task in place_entity(). So if the task was ineligible
>> before, it will still be ineligible after migration.
> 
> This is not accurate, it will be eleigible, irrespective of lag, if
> there are no other tasks. I think your patch tries to do this, but I'm
> fairly sure it got it wrong.


Thank you for your reply. The expression in my commit message is 
inaccurate, and I will correct it in the patch v2. If I understand 
correctly, a task meeting the following conditions:

  sched_feat(PLACE_LAG) && cfs_rq->nr_running && 
!entity_eligible(cfs_rq, &p->se),

will remain ineligible both before and after migration.

If I am wrong, please correct me. Thank you!



> 
>> Therefore, we should skip the migration of ineligible tasks
>> to reduce ineffective task migrations, just like the task
>> throttled by cfs_bandwidth, until they become eligible.
> 
> And this misses an important case too -- load-balancing will try very
> hard to balance load. If you disallow migrating tasks it might fail to
> reach this goal. Since this is not a hard contraint it should eventually
> give in and migrate it anyway.
> 
> That is, I would suggest allowing it when nr_balance_failed is non-zero.
> 

Thank you for your suggestion, I will do it in the patch v2.

Thanks,
Hao

>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>>   kernel/sched/fair.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index fbdca89c677f..5564e16b6fdb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9358,13 +9358,14 @@ static inline int migrate_degrades_locality(struct task_struct *p,
>>   static
>>   int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>   {
>> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
>>   	int tsk_cache_hot;
>>   
>>   	lockdep_assert_rq_held(env->src_rq);
>>   
>>   	/*
>>   	 * We do not migrate tasks that are:
>> -	 * 1) throttled_lb_pair, or
>> +	 * 1) throttled_lb_pair, or task ineligible, or
>>   	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>>   	 * 3) running (obviously), or
>>   	 * 4) are cache-hot on their current CPU.
>> @@ -9372,6 +9373,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>   	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>   		return 0;
>>   
>> +	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running &&
>> +			!entity_eligible(cfs_rq, &p->se))
> 
> Your indenting it wrong, please use: cino=(0:0

I will do it in the patch v2.

Thanks,
Hao

> 
>> +		return 0;
>> +
>>   	/* Disregard percpu kthreads; they are where they need to be. */
>>   	if (kthread_is_per_cpu(p))
>>   		return 0;
>> -- 
>> 2.34.1
>>


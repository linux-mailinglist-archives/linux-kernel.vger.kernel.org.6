Return-Path: <linux-kernel+bounces-517042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A4AA37B40
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2E16C0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0318FDA9;
	Mon, 17 Feb 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoMpOWwD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3711991A1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772806; cv=none; b=EP/6Fiytr0mtgzPq7I4727ySZT8jrp1focFRoIgtwMAEGcV03pJDOWqPSuXjBrpcwm19UPTbccqCHSD85qOVEBheuQ+DKtWoCYoYgUfJkGNM20cN8CjQpCoH2dYoTLRl6da1w6+xJ4SKqRB2Svpna+0VuJDFUwJcweCC7fcd/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772806; c=relaxed/simple;
	bh=Q4IiBCYtEpEAtIMWxJ1HpzqrHOcKLqjdGZ6Ot0Uawqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErUJQi57J6euFAsWq2YcPTFGI0deh16vLJty0Rvxc8j5FKjn/yDkzt5i2wUBNZLw3O5ZoRbFgAU20j+rvB81Pmf6o6pB01jU+kDVdaWxIF3M7cZl0LTbmKbyXaRvduPEkpd28CVriIgQSwKIB2zGgOzI+T7cS89EwcZf013ILCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoMpOWwD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2339dcfdso59691245ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739772804; x=1740377604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm0nvNkFrSwzSJgsa8SfQgEJnPTsraa5R0Oj78qJLKY=;
        b=IoMpOWwDzkwdyCLdzXaPPAA4RqtagGdEQXexmfMeG25k2XaQKWAaDnxNZPYzDwyuuV
         N12gsAbKXRdLQCJi9B+QbVsrn8zgxPH9De6ZPoWpaOZmTU3NF7fDYS1ZWKD8NUX32KcA
         Ja9i9SsH2j6bR/H8b10aPK5VCx/7rZFFzql+Eqpe3WJtwJq7RvYF3k6zopFvFtGtoO75
         AIwtlsKx7n3CglteyzDCPtrLg+3PtdWiTAqe0mvYClAtzAI15qE6AVdv7jbYwPZ2q9k4
         jEpxjxHXNi0UgiAaCODCi+xU6oOyP5CVQMssgfdANydNC1/V5LlBPk3eh8moKbIi81dc
         FEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739772804; x=1740377604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cm0nvNkFrSwzSJgsa8SfQgEJnPTsraa5R0Oj78qJLKY=;
        b=Dw9FqLzNmcAA/b/dSt+l9yyR/8/MPfNf3nNBFr6JiG6nelTebW4nSKyPuTVAi9ynxs
         mxCX7ot0w9X/HXQ96CNgF7f546p5WrSepar1qGsowJSwEr5lw4flhBeEv7TOMF81KfcT
         BvqMIWl4f9Ls4okdwS1Iw+XpNMVaI6dKwabnfgvmbbWyqSInbBYtpi5LEXoCtRHpRYKN
         xeku+FzABIGnO779l0h+3r2+2zLhdEr1QPhTNX41ykLs6v0LgrO5KXlY/pYtWh8Dfrnm
         ly4X5fzuX4++Ma8+R7ASTDtXNepkBquiOQMowOp5jIl5Kq0jM815oeMbv19UbyVJyzaW
         8W2w==
X-Forwarded-Encrypted: i=1; AJvYcCUauwWASYb+oonvL8Vv4X4vdybCRgW/J2gaikCL05fRc8dR3fRyY8ktOGY2S80csvnrMohBxgY8ielkw8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8ysldJPw+cNHANtEU35SeLPtJeD87SjGiOqM2ClQX0ifIpVf
	0VJCvVAlc7LOY+UF74//wNYOHFhAZL1rSIcemhcEUNV9xSO6UbIU
X-Gm-Gg: ASbGncv+3To3+rPMs9RyUCGbgF/21ubN+e7a9LxsfG5gWo5nwQMcrQCmUsrP1xgbkaA
	YOSEvDmpiIhMnwLmY6Ks7zpDP45VQhpyg7n+pHorX94+9RLbihbZfIwoXu6WUnMW2X/ZicDxd86
	dPebK8xDkAMORNRyC6jRdiKU1AJ0od/iEOMh6l/huoLaxELrUuDk1kfkoAfHLK/wY2i58uruzMf
	2VT0ouNca+Tsjqw5zZSMAHEmeN6e8RznCyLpNkm51tjCPz0uu/yINwrI8cZv1kKUaONJoVB0HZh
	FwWsIYyZR6vbspIWASt4Op3hscjwDttp91w=
X-Google-Smtp-Source: AGHT+IFxfaysRUIPQrPibCbrGQEvLzxiRRrHei2NCGy6uFJfG/iQLk4Yh9ACUvXIBtDJCdCQIhu+Rg==
X-Received: by 2002:a17:902:ecc4:b0:215:8847:4377 with SMTP id d9443c01a7336-221045c8b55mr106950725ad.15.1739772803999;
        Sun, 16 Feb 2025 22:13:23 -0800 (PST)
Received: from [10.125.192.21] ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367ecbsm64679305ad.59.2025.02.16.22.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 22:13:23 -0800 (PST)
Message-ID: <5b6d669a-4fb9-5d24-6e08-1dc121438194@gmail.com>
Date: Mon, 17 Feb 2025 14:13:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/core: Prioritize migrating eligible tasks in
 sched_balance_rq()
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
References: <20241223091446.90208-1-jiahao.kernel@gmail.com>
 <597384e3-6519-b10e-081b-30c3f89b6e3f@gmail.com>
 <CAKfTPtAf2dJmdDxnznA9GH2DOp2C0FKkmyMQwFjzOFiXNq7YJA@mail.gmail.com>
 <d0a4beb1-3a35-a510-aa9f-813492751cc4@gmail.com>
 <CAKfTPtCUMHjcHk2QZBC0OXY0OwkMzAX4-h94z4k_4f9df7Z_=w@mail.gmail.com>
 <e2f32928-bd54-a6cc-d6ee-c4578cb7aaa1@gmail.com>
 <CAKfTPtB02uJK6+e8UXiC=9RyRa3RA=LQ6Y3aqa7+PTX=BVPUcg@mail.gmail.com>
 <56d9d6cc-021e-4bd5-7254-aa39c9845500@gmail.com>
 <CAKfTPtAHTTt7mJeBBU4wxrAWrzngKTfp9yXBiwhncaHKXA1yrw@mail.gmail.com>
 <53082ec4-d862-6135-8d22-44dd2742156a@gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <53082ec4-d862-6135-8d22-44dd2742156a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/20 13:48, Hao Jia wrote:
> 
> 
> On 2025/1/16 19:26, Vincent Guittot wrote:
>> On Wed, 15 Jan 2025 at 12:55, Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>
>>>
>>>
>>> On 2025/1/15 17:28, Vincent Guittot wrote:
>>>> On Wed, 15 Jan 2025 at 09:55, Hao Jia <jiahao.kernel@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2025/1/14 16:07, Vincent Guittot wrote:
>>>>>> On Tue, 14 Jan 2025 at 04:18, Hao Jia <jiahao.kernel@gmail.com> 
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2025/1/14 00:40, Vincent Guittot wrote:
>>>>>>>> On Mon, 13 Jan 2025 at 10:21, Hao Jia <jiahao.kernel@gmail.com> 
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> Friendly ping...
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/12/23 17:14, Hao Jia wrote:
>>>>>>>>>> From: Hao Jia <jiahao1@lixiang.com>
>>>>>>>>>>
>>>>>>>>>> When the PLACE_LAG scheduling feature is enabled and
>>>>>>>>>> dst_cfs_rq->nr_queued is greater than 1, if a task is
>>>>>>>>>> ineligible (lag < 0) on the source cpu runqueue, it will
>>>>>>>>>> also be ineligible when it is migrated to the destination
>>>>>>>>>> cpu runqueue. Because we will keep the original equivalent
>>>>>>>>>> lag of the task in place_entity(). So if the task was
>>>>>>>>>> ineligible before, it will still be ineligible after
>>>>>>>>>> migration.
>>>>>>>>>>
>>>>>>>>>> So in sched_balance_rq(), we prioritize migrating eligible
>>>>>>>>>> tasks, and we soft-limit ineligible tasks, allowing them
>>>>>>>>>> to migrate only when nr_balance_failed is non-zero to
>>>>>>>>>> avoid load-balancing trying very hard to balance the load.
>>>>>>>>
>>>>>>>> Could you explain why you think it's better to balance eligible 
>>>>>>>> tasks
>>>>>>>> in priority and potentially skip a load balance ?
>>>>>>>
>>>>>>> In place_entity(), we maintain the task's original equivalent 
>>>>>>> lag, even
>>>>>>> if we migrate the task to dst_rq, this does not change its 
>>>>>>> eligibility
>>>>>>> attribute.
>>>>>>
>>>>>> Yes, but you don't answer the question why it's better to select an
>>>>>> eligible task vs a non eligible task.
>>>>>>
>>>>>>>
>>>>>>> When there are multiple tasks on src_rq, and the dst_cpu has some
>>>>>>> runnable tasks, migrating ineligible tasks to dst_rq will not 
>>>>>>> allow them
>>>>>>> to run. Therefore, such task migration is inefficient. We should
>>>>>>
>>>>>> Why is it inefficient ? load balance is about evenly balancing the
>>>>>> number of tasks or the load between CPUs, it never says that the 
>>>>>> newly
>>>>>> migrated task should run immediately
>>>>>
>>>>>
>>>>> My initial thought is that when we need to migrate some tasks during
>>>>> load balancing, at the current point in time, migrating ineligible 
>>>>> tasks
>>>>> to dst_cpu means they definitely cannot run there. Therefore, I prefer
>>>>> to keep them on src_cpu to reduce the overhead of dequeueing and
>>>>> enqueueing ineligible tasks.
>>>>
>>>> Sorry but I still don't get why it's important and would make a
>>>> difference. They are all runnable but ineligible tasks got more
>>>> runtime than other at that point in time so there is no real
>>>> difference
>>>
>>>
>>> I adopt a lazy strategy for ineligible tasks. At the current point in
>>> time, even if we migrate ineligible tasks to the dst CPU, they still
>>> have to wait on the dst CPU until they become eligible. We do not see
>>> clear benefits from migrating ineligible tasks, but their dequeueing and
>>> enqueueing would instead incur overhead.
>>
>> But your explanation doesn't make sense.
>> Not migrating an ineligible task only make sense for delayed_dequeue
>> tasks because they don't really want to run but only exhaust their lag
>> but this is already taken into account by
>> 61b82dfb6b7e ("sched/fair: Do not try to migrate delayed dequeue task")
>>
> 
> Thank you for your suggestion.
> 
> Yes, as you mentioned, this commit 61b82dfb6b7e ("sched/fair: Do not try 
> to migrate delayed dequeue task") reduces the migration of 
> delayed_dequeue tasks, but it doesn't work for ineligible RUNNING tasks 
> and when the migration_type is migrate_load.
> 
> 
>> Did you run your benchmark on top of this change ?
> 
> My previous benchmark tests were based on the torvalds/linux/master 
> branch, which does not include commit 61b82dfb6b7e ("sched/fair: Do not 
> try to migrate delayed dequeue task"). I will include this commit and 
> retest on my machine after my leave ends.
> 

I'm really sorry for being away for so long. I have retested the 
hackbench on my machine, which includes the commit 61b82dfb6b7e 
("sched/fair: Do not try to migrate delayed dequeue task"). Based on the 
hackbench test results, this patch still brings a slight performance 
improvement.

vanilla: Includes commit 61b82dfb6b7e ("sched/fair: Do not try to 
migrate delayed dequeue task"), but does not include my patch.

patched: Includes both the above commit and my patch.


hackbench-process-pipes
                       vanilla                  patched
Amean     1       0.4087 (   0.00%)      0.4003 (   2.04%)
Amean     4       1.7033 (   0.00%)      1.7100 (  -0.39%)
Amean     7       2.9020 (   0.00%)      2.8750 (   0.93%)
Amean     12      4.2543 (   0.00%)      4.2980 (  -1.03%)
Amean     21      5.8633 (   0.00%)      5.7507 (   1.92%)
Amean     30      7.3757 (   0.00%)      7.2887 (   1.18%)
Amean     48     10.5360 (   0.00%)     10.2647 (   2.58%)
Amean     79     16.5480 (   0.00%)     15.9820 (   3.42%)
Amean     96     19.7873 (   0.00%)     19.1347 (   3.30%)


hackbench-process-sockets
                       vanilla                  patched
Amean     1       0.7520 (   0.00%)      0.7377 (   1.91%)
Amean     4       2.5760 (   0.00%)      2.5103 (   2.55%)
Amean     7       4.3927 (   0.00%)      4.2653 (   2.90%)
Amean     12      7.3923 (   0.00%)      7.1427 (   3.38%)
Amean     21     12.3733 (   0.00%)     11.9760 (   3.21%)
Amean     30     17.2617 (   0.00%)     16.7987 (   2.68%)
Amean     48     28.8577 (   0.00%)     28.1980 (   2.29%)
Amean     79     50.0687 (   0.00%)     49.0887 (   1.96%)
Amean     96     62.1603 (   0.00%)     61.1177 (   1.68%)

FYI.

After the performance tests, I added some code in the can_migrate_task() 
to count the different reasons why tasks could not be migrated during 
the hackbench run.


hit_delayed_dequeue_cnt: Hit if (p->se.sched_delayed) && 
(env->migration_type != migrate_load)


hit_ineligible_cnt: Did not hit "hit_delayed_dequeue" && 
!env->sd->nr_balance_failed && task_is_ineligible_on_dst_cpu()


Count results:

hit_delayed_dequeue_cnt    378432
hit_ineligible_cnt        1862099



Thanks,
Hao


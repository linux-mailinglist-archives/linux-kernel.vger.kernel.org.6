Return-Path: <linux-kernel+bounces-389275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA449B6ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F0B2235D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B321893D;
	Wed, 30 Oct 2024 17:17:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3304215C67
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308672; cv=none; b=png4h2DsqTmA+6KKudo3UVEnu8tFFadBwFLaMP+gzdZRLVIAfJLDPHpiW2vWmjlIo1ZzQ+kTCBn4SQP/j44eZ40c8zdYqkD8NVQ4+BnouHN6E3MgmVtaq0wPfrYgSNDxGGA+gV/lnKF38Yk5by2f+hmDLP/W2W7bSw4703gTXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308672; c=relaxed/simple;
	bh=VYDndjzInsP2QoAyQSI91Ite4cu52AxvLzhBcITzAGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7qfAm/mrHjPr7N45j73H/atKx4aK2SqCDQGf0C1kwZueHyxS2P56fUVQjONeqiJtMEyKWhWReTgy89jkU9MrJpLm8+Vmdpl8OgzVhlRAgy4LnHbAfvrQLgfoSYx+hjeTr8UU3vE3pTvrbVP1FgW7qTypF1jmw0mriOG1ocI/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6518113E;
	Wed, 30 Oct 2024 10:18:17 -0700 (PDT)
Received: from [10.1.33.15] (e127648.arm.com [10.1.33.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61DF33F66E;
	Wed, 30 Oct 2024 10:17:45 -0700 (PDT)
Message-ID: <7e4ebd21-3144-4a1a-a736-d9abef21bd4b@arm.com>
Date: Wed, 30 Oct 2024 17:17:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sched/ext: Fix scx vs sched_delayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, void@manifault.com,
 linux-kernel@vger.kernel.org
References: <20241030151255.300069509@infradead.org>
 <20241030152142.372771313@infradead.org>
 <a20ccb66-0233-4e09-94cd-586133072c3c@arm.com>
 <20241030155403.GO14555@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241030155403.GO14555@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 15:54, Peter Zijlstra wrote:
> On Wed, Oct 30, 2024 at 03:50:05PM +0000, Christian Loehle wrote:
>> On 10/30/24 15:12, Peter Zijlstra wrote:
>>> Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
>>> switched_from_fair()") forgot about scx :/
>>>
>>> Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
>>> Reported-by: Tejun Heo <tj@kernel.org>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net
>>> ---
>>>  kernel/sched/ext.c |   14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> --- a/kernel/sched/ext.c
>>> +++ b/kernel/sched/ext.c
>>> @@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struc
>>>  	scx_task_iter_start(&sti);
>>>  	while ((p = scx_task_iter_next_locked(&sti))) {
>>>  		const struct sched_class *old_class = p->sched_class;
>>> +		const struct sched_class *new_class =
>>> +			__setscheduler_class(p->policy, p->prio);
>>>  		struct sched_enq_and_set_ctx ctx;
>>>  
>>> +		if (old_class != new_class && p->se.sched_delayed)
>>> +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>>> +
>>>  		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
>>>  
>>> -		p->sched_class = __setscheduler_class(p->policy, p->prio);
>>> +		p->sched_class = new_class;
>>>  		check_class_changing(task_rq(p), p, old_class);
>>>  
>>>  		sched_enq_and_set_task(&ctx);
>>> @@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_e
>>>  	scx_task_iter_start(&sti);
>>>  	while ((p = scx_task_iter_next_locked(&sti))) {
>>>  		const struct sched_class *old_class = p->sched_class;
>>> +		const struct sched_class *new_class =
>>> +			__setscheduler_class(p->policy, p->prio);
>>>  		struct sched_enq_and_set_ctx ctx;
>>>  
>>> +		if (old_class != new_class && p->se.sched_delayed)
>>> +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
>>> +
>>
>> s/DEQUEE_DELAYED/DEQUEUE_DELAYED
> 
> Bah, typing so hard..
> 
>> Anyway, no luck for me applying the series onto sched/core scx's for-next or rc5.
>> Any hint or do you mind supplying a branch?
> 
> I think I did it on top of tip/master..

0b9c113ad1c2 (tip/master) Merge branch into tip/master: 'x86/sev'
results in the following diff for me (line number mismatch by 5), stops applying from 2/6:
-- 

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 65334c13ffa5..2b5f1742299a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4494,11 +4494,16 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
        scx_task_iter_start(&sti);
        while ((p = scx_task_iter_next_locked(&sti))) {
                const struct sched_class *old_class = p->sched_class;
+               const struct sched_class *new_class =
+                       __setscheduler_class(p->policy, p->prio);
                struct sched_enq_and_set_ctx ctx;
 
+               if (old_class != new_class && p->se.sched_delayed)
+                       dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
                sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-               p->sched_class = __setscheduler_class(p->policy, p->prio);
+               p->sched_class = new_class;
                check_class_changing(task_rq(p), p, old_class);
 
                sched_enq_and_set_task(&ctx);


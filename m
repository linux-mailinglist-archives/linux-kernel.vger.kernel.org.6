Return-Path: <linux-kernel+bounces-556254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFEBA5C334
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2F1188AF45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECC825A65A;
	Tue, 11 Mar 2025 14:04:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F12571B6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701872; cv=none; b=sarMS8IeUoFQkjH0d/p/u/TDDkfjzVnF+sr3T8OMhcgkxnTFyboIHgc6IGESgju0u5sT8NkpQoUN7U5HG/sQvKYxI1EHhJqxKHhjG7GZFEfr/b7gLZZg/fRwQkN/B3SKD9as85xau3RAkSnYzt9kIvfok0vRA6pS61KkYuNVGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701872; c=relaxed/simple;
	bh=pvHBbvxTB0+7dWDj0wt/2A7BsdPmHiJEacTslZfeqzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gneaz0OdaVzmaLSf5bVFhBMMAdM8XlVRxr/Xj+lzGpXJUr5VagqptG9a8hw/2cpwvLa6PwH3xBLmhZtTeUY/eUFgsENpRyK9gf5gPX55r8AxDROoiz8rES+zdM6LEUsvpAzLTaAuz0ZqqNYwUx7cS5Q6CBYuYsMlDQBnxJNgJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F161516;
	Tue, 11 Mar 2025 07:04:40 -0700 (PDT)
Received: from [10.1.35.43] (e133649.arm.com [10.1.35.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC723F694;
	Tue, 11 Mar 2025 07:04:26 -0700 (PDT)
Message-ID: <132071bd-b5dd-439b-965f-9203b18416c6@arm.com>
Date: Tue, 11 Mar 2025 14:04:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
 <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
 <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
 <CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com>
 <65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com>
 <84a8f306-e2f6-4c9e-a150-72ee3c187b64@arm.com>
 <d2da740a-8786-4726-8467-b7534af3d0e5@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <d2da740a-8786-4726-8467-b7534af3d0e5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2025 12:24, Dietmar Eggemann wrote:
> On 10/03/2025 12:56, Hongyan Xia wrote:
>> On 10/03/2025 11:22, Dietmar Eggemann wrote:
>>> On 10/03/2025 12:03, Xuewen Yan wrote:
>>>> Hi Dietmar,
>>>>
>>>> On Mon, Mar 10, 2025 at 6:53 PM Dietmar Eggemann
>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 10/03/2025 03:41, Xuewen Yan wrote:
>>>>>> On Sat, Mar 8, 2025 at 2:32 AM Dietmar Eggemann
>>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>>
>>>>>>> On 06/03/2025 13:01, Xuewen Yan wrote:
>>>>>>>> On Thu, Mar 6, 2025 at 2:24 AM Dietmar Eggemann
>>>>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>>>>
>>>>>>>>> On 27/02/2025 14:54, Hongyan Xia wrote:
> 
> [...]
> 
>>>> I submitted a patch similar to yours before:
>>>>
>>>> https://lore.kernel.org/all/CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com/
>>>>
>>>> And Hongyan fears that as more complexity goes into each sched_class
>>>> like delayed dequeue,
>>>> so it's better to just let the sched_class handle how uclamp is
>>>> enqueued and dequeued within itself rather than leaking into core.c.
>>>
>>> Ah, OK. Your patch didn't have 'sched' in the subject so I didn't see it
>>> immediately.
>>>
>>> I would prefer that uclamp stays in core.c. ENQUEUE_DELAYED among all
>>> the other flags is already used there (ttwu_runnable()).
>>>
>>> task_struct contains  sched_{,rt_,dl_}entity}. We just have to be
>>> careful when switching policies.
>>
>> I lean towards letting each class handle uclamp. We've seen the trouble
>> with delayed dequeue. Just like the if condition we have for util_est,
>> if uclamp is in each class then we can re-use the condition easily,
>> otherwise we need to carefully synchronize the enqueue/dequeue between
>> core.c and the sub class.
>>
>> Also I think so far we are assuming delayed dequeue is the only trouble
>> maker. If RT and sched_ext have their own corner cases (I think maybe
>> sched_ext is likely because it may eventually want the ext scheduler to
>> be able to decide on uclamp itself) then the uclamp inc/dec in core.c
>> need to cater for that as well. Once a task is in a class, the variables
>> in another class may be in an undefined state, so checking corner cases
>> for all the sub-classes in a centralized place like core.c may not even
>> be easy to get right.
> 
> I do understand your concern with sched_ext but I still prefer the less
> invasive change to get uclamp & util_est aligned for fair.c aligned.
> 
> AFAICS, related to policy changes, we have a
> SCHED_WARN_ON(p->se.sched_delayed) in switched_to_fair() so far.

I'm okay with staying in core.c, but care is needed to make sure uclamp 
inc and dec are balanced. We have been bitten by the unbalanced uclamp 
and util_est during delayed dequeue fixes and we finally made sure 
util_est is balanced (at least so far it seems). Reusing the same logic 
and moving uclamp into fair.c makes sure we don't get bitten again and 
is one reason why I prefer moving into each class.


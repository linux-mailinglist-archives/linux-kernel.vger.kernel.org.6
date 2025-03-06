Return-Path: <linux-kernel+bounces-548709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38511A54871
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474253B05A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF02204F7A;
	Thu,  6 Mar 2025 10:53:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB22040BD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258433; cv=none; b=iDXQMuvVDwJD7aPlQ42m3EWOQffIAnGJFllkq6yJ/DV6uFhEbQYN91CARwFRe2ctyQEIEM9bxgSRC+qxerpCM/nqsZSAgtYNfocnle/YaKJVXr4ej/RwvIzgjiH4XddXAmtv3BSXy9s3fRQsdUWWx9So+N8bx6u8CpLuiaX33zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258433; c=relaxed/simple;
	bh=7Vkkin5fS73NPdakk81hq+ToszA7b+qp0QgWpd30JV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMYrrV/YSCxiptrxOxyim9Wj8RV2rt/on0hvUbgMCi9DGAdJYnobncJEwBAhEqH03rCvqR+qO2gSY/9qGJ7Ua2DShusyAM6vsRYVUKQczZzZ6GatsvH4CMUqpsYd2V3rUI6EDKMeIcBu3xs2nj1SWD+U7cnvetTa5w/1L2RGBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CA7BFEC;
	Thu,  6 Mar 2025 02:54:04 -0800 (PST)
Received: from [10.57.40.132] (unknown [10.57.40.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B52193F66E;
	Thu,  6 Mar 2025 02:53:48 -0800 (PST)
Message-ID: <e123524c-8c27-4ee7-8799-10931375712f@arm.com>
Date: Thu, 6 Mar 2025 10:53:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 18:22, Dietmar Eggemann wrote:
> On 27/02/2025 14:54, Hongyan Xia wrote:
> 
> [...]
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 857808da23d8..7e5a653811ad 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>   	 * Let's add the task's estimated utilization to the cfs_rq's
>>   	 * estimated utilization, before we update schedutil.
>>   	 */
>> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>> +	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
>> +		uclamp_rq_inc(rq, p);
>>   		util_est_enqueue(&rq->cfs, p);
>> +	}
> 
> So you want to have p uclamp-enqueued so that its uclamp_min value
> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
> enqueue_task_fair?
> 
>    if (p->in_iowait)
>      cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> 
>    enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>    cpufreq_update_util()
> 
> But if you do this before requeue_delayed_entity() (1) you will not
> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?

Sorry I'm not sure I'm following. The only condition of the 
uclamp_rq_inc() here should be

     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & 
ENQUEUE_RESTORE))))

Could you elaborate why it doesn't get enqueued?


Return-Path: <linux-kernel+bounces-568080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1AA68DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DEF1B613C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C952566FB;
	Wed, 19 Mar 2025 13:33:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA0210186
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391183; cv=none; b=OI/m1u58L9iB9nWD8SJ7uJ4K9rF+z6+P1uKibfEB/P//OJ0bTYdGCzWtaBVCPfrUSYjMY0pEv3u3OwNkVjvdzk7syCSrS9Lgiol5WOQFMFg9ZzaynzdIuBgTsp9+707TjERzcVUc7DGouV9XoPnUlTtZzouL7HqzXJ1ltt/bQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391183; c=relaxed/simple;
	bh=gDqz679B7Uxk4MUJziXpWUWZLQc0EYr4/6vswwU89fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUvYV+VljEI0iJnN2k5CupJ7Bl0XEd1IKDP7za3WMf6NHDC6uOQK6hVwOwbV6osXYk8XVrFp7fOInzBDjAYmMqGPyy6b48ivt2sOMNHOIpW/QgJhmTFptD8X/vl9ZsCR1sGIuIIyVqxvCpGQ3gsT1CN+4r4NXZ6Ut5tSctbXBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B469B113E;
	Wed, 19 Mar 2025 06:33:08 -0700 (PDT)
Received: from [192.168.3.45] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92F903F673;
	Wed, 19 Mar 2025 06:32:57 -0700 (PDT)
Message-ID: <aa8baf67-a8ec-4ad8-a6a8-afdcd7036771@arm.com>
Date: Wed, 19 Mar 2025 14:32:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/util_est: Do not sub the delayed-task's
 util-est
To: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.co, linux-kernel@vger.kernel.org, hongyan.xia2@arm.com,
 qyousef@layalina.io, ke.wang@unisoc.com, di.shen@unisoc.com,
 xuewen.yan94@gmail.com
References: <20250314090909.8404-1-xuewen.yan@unisoc.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250314090909.8404-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2025 10:09, Xuewen Yan wrote:
> In cpu_util_without, When the task is in rq, we should
> sub the task's util_est, however, the delayed_task->on_rq
> is true, however, the delayed_task's util had been sub
> when sleep, so there is no need to sub the delayed task's
> util-est. So add the checking of delayed-task.
> 
> On the other hand, as said in [1], the logic of util_est's
> enqueue/dequeue could be simplified.
> So simplify it by aligning with the conditions of uclamp.

This flag simplification looks good to me.

IMHO, you should submit this with the uclamp change so that we can call
uclamp_rq_inc() before p->sched_class->enqueue_task(). To make sure the
task which is enqueued with 'flags & ENQUEUE_DELAYED' is considered for
cpufreq_update_util() in enqueue_task_fair() (Hongyan's finding in
https://lkml.kernel.org/r/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com)

I would prefer the less invasive fix you presented here:

https://lkml.kernel.org/r/CAB8ipk9LpbiUDnbcV6+59+Sa=Ai7tFzO===mpLD3obNdV4=J-A@mail.gmail.com

since uclamp is already a core thing (fair + rt), it works for current
max aggregation and it's less invasive.

[...]

> @@ -8037,7 +8037,8 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>  		 */
>  		if (dst_cpu == cpu)
>  			util_est += _task_util_est(p);
> -		else if (p && unlikely(task_on_rq_queued(p) || current == p))
> +		else if (p && unlikely(current == p ||
> +			 (task_on_rq_queued(p) && !p->se.sched_delayed)))
>  			lsub_positive(&util_est, _task_util_est(p));

cpu_util(..., p != NULL, ...) is only used for select_task_rq_fair().
IMHO p->se.sched_delayed is not set there.







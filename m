Return-Path: <linux-kernel+bounces-561470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EB5A6124E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6831B630EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35251FF61E;
	Fri, 14 Mar 2025 13:14:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52F1FE470
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958079; cv=none; b=UFKM4Sw7JEENFt9StrttmvjDafadfBa5SzPvMGIBsy4ixxCYYlUfNnBIE5Bm80TO8BzmZqdSbCJzhKAEs7ezdDxzPQgXZXJgOH2iqa4YBDJnD5VzOdtJdfZke5xJadp+/tp3I72qp4HZ6U2Dgxt1dC1t5t0cM4L5Cvta4GURIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958079; c=relaxed/simple;
	bh=LCOwegfYSlyPxTWUkilJBjC5KUTBoSn6ooShxFJ+aZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skrSawIRqmGrKQLXVvCAxkzKWSHGxGPhsjqyThCe5FQgw+4BwfaY1N7EICoyMHZa8Ulu6fgCK4Xc2mf7tH3mpHH857gF8plb1SC8F/oaylhAHZq1w2qMQ6adiN+EKeiyFVItS9ByPVivHEIH/uyVjpKuLRG+fGgIRhKkOYBzHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40CF71424;
	Fri, 14 Mar 2025 06:14:47 -0700 (PDT)
Received: from [10.57.40.41] (unknown [10.57.40.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B3363F673;
	Fri, 14 Mar 2025 06:14:34 -0700 (PDT)
Message-ID: <7dbd7dd3-dbf7-42e0-97c4-c5eb50250947@arm.com>
Date: Fri, 14 Mar 2025 13:14:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/util_est: Do not sub the delayed-task's
 util-est
To: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com
Cc: rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.co, linux-kernel@vger.kernel.org, qyousef@layalina.io,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
References: <20250314090909.8404-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20250314090909.8404-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 09:09, Xuewen Yan wrote:
> In cpu_util_without, When the task is in rq, we should
> sub the task's util_est, however, the delayed_task->on_rq
> is true, however, the delayed_task's util had been sub
> when sleep, so there is no need to sub the delayed task's
> util-est. So add the checking of delayed-task.
> 
> On the other hand, as said in [1], the logic of util_est's
> enqueue/dequeue could be simplified.
> So simplify it by aligning with the conditions of uclamp.
> 
> [1]https://lore.kernel.org/all/CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com/
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/sched/fair.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d2795243..bebf40a0fa4e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6930,7 +6930,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   	 * Let's add the task's estimated utilization to the cfs_rq's
>   	 * estimated utilization, before we update schedutil.
>   	 */
> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
> +	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
>   		util_est_enqueue(&rq->cfs, p);
>   
>   	if (flags & ENQUEUE_DELAYED) {
> @@ -7168,7 +7168,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>    */
>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   {
> -	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
> +	if (!p->se.sched_delayed)
>   		util_est_dequeue(&rq->cfs, p);
>   
>   	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> @@ -8037,7 +8037,8 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>   		 */
>   		if (dst_cpu == cpu)
>   			util_est += _task_util_est(p);
> -		else if (p && unlikely(task_on_rq_queued(p) || current == p))
> +		else if (p && unlikely(current == p ||
> +			 (task_on_rq_queued(p) && !p->se.sched_delayed)))
>   			lsub_positive(&util_est, _task_util_est(p));
>   
>   		util = max(util, util_est);

Have you tested the above changes to make sure util_est enqueue dequeue 
are balanced? util_est was broken for quite a while when merging delayed 
dequeue because now enqueue_ and dequeue_task() do not always appear in 
pairs. Since then, I always have a local patch like this (may be a bit 
out of date now) to make sure util_est is balanced

https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/


Return-Path: <linux-kernel+bounces-389081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23C9B6852
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6611C2092A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0CF213EEC;
	Wed, 30 Oct 2024 15:50:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A01E570E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303414; cv=none; b=PuGGT74YSffpel6Ne0obUCiynv5JU6K9vG3xHcW+0r9Cq+YCG8cT/b40yi58CNpsSr05ssV4T5jwCdv7imN9Jv7371YZDzS+qlyUwWMZ0dWRIQeeNCNOUJaw72NIJvkM/Lj20Gl0eeqMiRmkbAj2ReKeUB/rip4QxrzRntrubD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303414; c=relaxed/simple;
	bh=5i4kwYqvsLdV1Qv9Txem/GpMbPH2msqXYSWWyDNdb3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smaUpkXiX/Od+uBXZ8ZIr0FL7J0GtrF71Y0ontRsz4tVg1rLOVFV0YnK6VwyyFg4F1OC/z+IdK+ynbbXkckMlMK14gkzEbCZ2p/Qy41TqNtawtXb+t6FW/bjOx4KCvDz3k9iS0L6ZM+VahrTzjfxzveKFVzA8LBhPafcPCYTuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071BE113E;
	Wed, 30 Oct 2024 08:50:40 -0700 (PDT)
Received: from [10.1.33.15] (e127648.arm.com [10.1.33.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91543F528;
	Wed, 30 Oct 2024 08:50:07 -0700 (PDT)
Message-ID: <a20ccb66-0233-4e09-94cd-586133072c3c@arm.com>
Date: Wed, 30 Oct 2024 15:50:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sched/ext: Fix scx vs sched_delayed
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, void@manifault.com,
 linux-kernel@vger.kernel.org
References: <20241030151255.300069509@infradead.org>
 <20241030152142.372771313@infradead.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20241030152142.372771313@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 15:12, Peter Zijlstra wrote:
> Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
> switched_from_fair()") forgot about scx :/
> 
> Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net
> ---
>  kernel/sched/ext.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struc
>  	scx_task_iter_start(&sti);
>  	while ((p = scx_task_iter_next_locked(&sti))) {
>  		const struct sched_class *old_class = p->sched_class;
> +		const struct sched_class *new_class =
> +			__setscheduler_class(p->policy, p->prio);
>  		struct sched_enq_and_set_ctx ctx;
>  
> +		if (old_class != new_class && p->se.sched_delayed)
> +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +
>  		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
>  
> -		p->sched_class = __setscheduler_class(p->policy, p->prio);
> +		p->sched_class = new_class;
>  		check_class_changing(task_rq(p), p, old_class);
>  
>  		sched_enq_and_set_task(&ctx);
> @@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_e
>  	scx_task_iter_start(&sti);
>  	while ((p = scx_task_iter_next_locked(&sti))) {
>  		const struct sched_class *old_class = p->sched_class;
> +		const struct sched_class *new_class =
> +			__setscheduler_class(p->policy, p->prio);
>  		struct sched_enq_and_set_ctx ctx;
>  
> +		if (old_class != new_class && p->se.sched_delayed)
> +			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEE_DELAYED);
> +

s/DEQUEE_DELAYED/DEQUEUE_DELAYED
Anyway, no luck for me applying the series onto sched/core scx's for-next or rc5.
Any hint or do you mind supplying a branch?


Return-Path: <linux-kernel+bounces-253365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC00932015
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF6D1F229CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276617588;
	Tue, 16 Jul 2024 05:33:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299A1C683
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108009; cv=none; b=GF0d/enNmtJoP0AXHOham+lS5rTfJTN9QBr9CfkWLJmp0AQiziV4hWtAajcDZZusKpJaE19C02Rt3tNQ/EReV9j6b+06aq/z/Py1DIVfkI/MEWlmTPahWni6aT0ccgpltOdVhfHDxXfZCA5nC7+ocJrh5r+POq+s79I97WCxdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108009; c=relaxed/simple;
	bh=nCckyQVSl9RWFzxpXeWMuMmk9rCbqGobkRXB/sbEGTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ThhtBpj5JYa+qjulrhqOHdfypl3r0BBGej1MFNvo6IYC1CJDHlSMGK1NFR8hv85rLOMzxshL4OAsT7o34KAD0krhzaIuACAwD/gFDDC0Znvrm+Yix3wq20l94Km+gHbaj/3gcC4pXvbhXD/V8h2nJpDf+zhSXzrHqZzzzBufArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WNSKC6PhVzxSnk;
	Tue, 16 Jul 2024 13:28:31 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 362E81403D1;
	Tue, 16 Jul 2024 13:33:22 +0800 (CST)
Received: from [10.45.179.188] (10.45.179.188) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jul 2024 13:33:20 +0800
Message-ID: <e1297077-8ab3-4bc7-a713-c0d81eda5d97@huawei.com>
Date: Tue, 16 Jul 2024 13:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched: Initialize the vruntime of a new task when it
 is first enqueued
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <Markus.Elfring@web.de>,
	<linux-kernel@vger.kernel.org>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
From: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
In-Reply-To: <20240627133359.1370598-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200007.china.huawei.com (7.202.181.34)

Ping 🙂



在 2024/6/27 21:33, Zhang Qiao 写道:
> When creating a new task, we initialize vruntime of the newly task at
> sched_cgroup_fork(). However, the timing of executing this action is too
> early and may not be accurate.
>
> Because it uses current CPU to init the vruntime, but the new task
> actually runs on the cpu which be assigned at wake_up_new_task().
>
> To optimize this case, we pass ENQUEUE_INITIAL flag to activate_task()
> in wake_up_new_task(), in this way, when place_entity is called in
> enqueue_entity(), the vruntime of the new task will be initialized.
>
> In addition, place_entity() in task_fork_fair() was introduced for two
> reasons:
> 1. Previously, the __enqueue_entity() was in task_new_fair(),
> in order to provide vruntime for enqueueing the newly task, the
> vruntime assignment equation "se->vruntime = cfs_rq->min_vruntime" was
> introduced by commit e9acbff6484d ("sched: introduce se->vruntime").
> This is the initial state of place_entity().
>
> 2. commit 4d78e7b656aa ("sched: new task placement for vruntime") added
> child_runs_first task placement feature which based on vruntime, this
> also requires the new task's vruntime value.
>
> After removing the child_runs_first and enqueue_entity() from
> task_fork_fair(), this place_entity() no longer makes sense, so remove
> it also.
>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---
> v2:
> Improve comments and commit log.
>
> v1: https://lore.kernel.org/lkml/20240606121133.2218723-1-zhangqiao22@huawei.com/
> ---
>   kernel/sched/core.c |  2 +-
>   kernel/sched/fair.c | 15 ---------------
>   2 files changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..b4ff595a2dc8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4897,7 +4897,7 @@ void wake_up_new_task(struct task_struct *p)
>   	update_rq_clock(rq);
>   	post_init_entity_util_avg(p);
>   
> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
> +	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
>   	trace_sched_wakeup_new(p);
>   	wakeup_preempt(rq, p, WF_FORK);
>   #ifdef CONFIG_SMP
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..bb5f376fd51e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12702,22 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>    */
>   static void task_fork_fair(struct task_struct *p)
>   {
> -	struct sched_entity *se = &p->se, *curr;
> -	struct cfs_rq *cfs_rq;
> -	struct rq *rq = this_rq();
> -	struct rq_flags rf;
> -
> -	rq_lock(rq, &rf);
> -	update_rq_clock(rq);
> -
>   	set_task_max_allowed_capacity(p);
> -
> -	cfs_rq = task_cfs_rq(current);
> -	curr = cfs_rq->curr;
> -	if (curr)
> -		update_curr(cfs_rq);
> -	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
> -	rq_unlock(rq, &rf);
>   }
>   
>   /*



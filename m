Return-Path: <linux-kernel+bounces-240711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431992718A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B381C20CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3621A2FA6;
	Thu,  4 Jul 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cRrfuczB"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935740BF2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720080954; cv=none; b=Hi8I8bo/GbxL7eboZK0thEb5YWrLOrnZGa9P+5Xhsh7ITNiixAKbsCJI26xwpYfYx9tTMpvCxpjlK/a7Nrk3o4zxtMBP5lFIngC0qKlHr2QW7DLWpLAY0RaQsAsgA4SifTNI65KDchAp98d4XipUrS3743TVVQWJrkdZ4bjmnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720080954; c=relaxed/simple;
	bh=XHqGwaQmYmQMgT5UnwbhL5emw0ca+fdWudPrSxTUdhA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HEnfMX0xyQyX1Iyb8WDCSAAA1jk2d/gBeAbr3n6qlt/u0b7wOj0ai+iR30nb2ERtpjJ7TS+qAdYEvd4UIWzC0nhQ30kcD1JYAFU+gxJhehDgkenyz5QeHv3H3xDSkt8NhAhVQKrR0LaJLTuM/2t0QoO2z4w7VLpa0jIlqJxYVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cRrfuczB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720080948; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=vXW1yzEsOtMBP6VZGMkwSIPS5R14JQHEPFwNunTTdEw=;
	b=cRrfuczB8wshhQ2TWLlN3Cd3JrBVtYEzF2BZ1YIq/d7cyiaJE4s3JsIaTEx+AKYZdn8J5pp9o5iIgyELrO37Kwfqf0c0tzi97nT8P+SHdyR+tye9xMSTRbSOtNvPXM1jlfzIEi2DN09nC0+epDOPV9F+6J+eWOH10mOmVnJVkmU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W9pvh2H_1720080946;
Received: from 30.97.49.49(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W9pvh2H_1720080946)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 16:15:48 +0800
Message-ID: <8fea90cc-8a57-4cd7-8b60-6179a8eb9cfd@linux.alibaba.com>
Date: Thu, 4 Jul 2024 16:15:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

gentle ping...

On 2024/6/26 10:35, Tianchen Ding wrote:
> Consider the following cgroup:
> 
>                         root
>                          |
>               ------------------------
>               |                      |
>         normal_cgroup            idle_cgroup
>               |                      |
>     SCHED_IDLE task_A           SCHED_NORMAL task_B
> 
> According to the cgroup hierarchy, A should preempt B. But current
> check_preempt_wakeup_fair() treats cgroup se and task separately, so B
> will preempt A unexpectedly.
> Unify the wakeup logic by {c,p}se_is_idle only. This makes SCHED_IDLE of
> a task a relative policy that is effective only within its own cgroup,
> similar to the behavior of NICE.
> 
> Also fix se_is_idle() definition when !CONFIG_FAIR_GROUP_SCHED.
> 
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Reviewed-by: Josh Don <joshdon@google.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> v2:
> Use entity_is_task() to check whether pse is a task.
> Improve comments and commit log.
> 
> v1: https://lore.kernel.org/all/20240624073900.10343-1-dtcccc@linux.alibaba.com/
> ---
>   kernel/sched/fair.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..f0b038de99ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
>   
>   static int se_is_idle(struct sched_entity *se)
>   {
> -	return 0;
> +	return task_has_idle_policy(task_of(se));
>   }
>   
>   #endif	/* CONFIG_FAIR_GROUP_SCHED */
> @@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>   	if (test_tsk_need_resched(curr))
>   		return;
>   
> -	/* Idle tasks are by definition preempted by non-idle tasks. */
> -	if (unlikely(task_has_idle_policy(curr)) &&
> -	    likely(!task_has_idle_policy(p)))
> -		goto preempt;
> -
> -	/*
> -	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
> -	 * is driven by the tick):
> -	 */
> -	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> +	if (!sched_feat(WAKEUP_PREEMPTION))
>   		return;
>   
>   	find_matching_se(&se, &pse);
> @@ -8401,7 +8392,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>   	pse_is_idle = se_is_idle(pse);
>   
>   	/*
> -	 * Preempt an idle group in favor of a non-idle group (and don't preempt
> +	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
>   	 * in the inverse case).
>   	 */
>   	if (cse_is_idle && !pse_is_idle)
> @@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>   	if (cse_is_idle != pse_is_idle)
>   		return;
>   
> +	/*
> +	 * Batch tasks do not preempt non-idle tasks (their preemption
> +	 * is driven by the tick).
> +	 * We've done the check about "only one of the entities is idle",
> +	 * so cse must be non-idle if p is a batch task.
> +	 */
> +	if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
> +		return;
> +
>   	cfs_rq = cfs_rq_of(se);
>   	update_curr(cfs_rq);
>   



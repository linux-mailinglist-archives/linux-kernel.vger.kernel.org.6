Return-Path: <linux-kernel+bounces-260562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D17F93AAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A891F2306D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2917547;
	Wed, 24 Jul 2024 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uwb6XtOb"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B91B813
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786902; cv=none; b=VlMW1bxVEx0a+UhTc/qeAQbB1tNQDK3AXRgHJ6ot3X75WKIYz98bafY9QSB9OgWD01FqQGmDp8oDxiVp93t9fuZB7oNp9Hql6BzkVLCzuIZjzeYArn7gNeZSAGFMGgyEat39LqHiP/dbaAddrOU4uYaspzfv9uUcPEcJgZQyX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786902; c=relaxed/simple;
	bh=mzDFZB9OOghCASrhXpcNqvcOiJQDrOEIRyG0b7jtOwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjRgPIaDZfjSRbA22ArWiazniiprKr9IlFI9Nali1HoV18efFLyOedMsBpUs4AszP198gPbtZ404bVzztxTnAFjd6KZ5VvXXttB6cVc7VT+NF1Mual2oa8UjqFuNrDpfVrEg/0yLdPSupx35IL40djBgpFjObGqvJiSNvSEfKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uwb6XtOb; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <67fda2fc-5224-428f-bd9c-210915e7c963@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721786893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uN0c4BmCBZWSj9LZA+Bzr6lnZ+/hvWMXV3zP1RMm/lA=;
	b=Uwb6XtOb+b+muz1Gf+DMSHRr6Xwg+X0pB8AwamVB3sjSwoFabWgpi6MnG84gN6BGX1BZlK
	6Vuq7UYFbuD2QmJ4Wh8JtuJcVTCuzCJ2JHCNps+/uMg94BuwqbZiTduJIaR1BEHPFAZN5W
	titzP2cXiS74CjvQxzZbzwLcDB6qxMw=
Date: Wed, 24 Jul 2024 10:08:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240723114247.104848-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/23 19:42, Chuyi Zhou wrote:
> In reweight_task(), there are two situations:
> 
> 1. The task was on_rq, then the task's load_avg is accurate because we
> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> 
> 2. The task is sleeping, its load_avg might not have been updated for some
> time, which can result in inaccurate dequeue_load_avg() in
> reweight_entity().
> 
> This patch solves this by using sync_entity_load_avg() to synchronize the
> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
> For tasks were on_rq, since we already update load_avg to accurate values
> in dequeue_task(), this change will not have other effects due to the short
> time interval between the two updates.
> 
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Looks good to me!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
> Changes in v3:
> - use sync_entity_load_avg() rather than update_load_avg() to sync the
> sleeping task with its cfs_rq suggested by Dietmar.
> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
> Changes in v2:
> - change the description in commit log.
> - use update_load_avg() in reweight_task() rather than in reweight_entity
> suggested by chengming.
> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
> ---
>   kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..da3cdd86ab2e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>   					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>   }
> +
> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> +{
> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> +				 cfs_rq->last_update_time_copy);
> +}
> +
> +/*
> + * Synchronize entity load avg of dequeued entity without locking
> + * the previous rq.
> + */
> +static void sync_entity_load_avg(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +	u64 last_update_time;
> +
> +	last_update_time = cfs_rq_last_update_time(cfs_rq);
> +	__update_load_avg_blocked_se(last_update_time, se);
> +}
> +
>   #else
>   static inline void
>   enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
>   static inline void
>   dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
> +static void sync_entity_load_avg(struct sched_entity *se) { }
>   #endif
>   
>   static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
> @@ -3795,7 +3816,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   		if (!curr)
>   			__dequeue_entity(cfs_rq, se);
>   		update_load_sub(&cfs_rq->load, se->load.weight);
> -	}
> +	} else if (entity_is_task(se))
> +		sync_entity_load_avg(se);
> +
>   	dequeue_load_avg(cfs_rq, se);
>   
>   	if (se->on_rq) {
> @@ -4034,11 +4057,6 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
>   	return true;
>   }
>   
> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> -{
> -	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> -				 cfs_rq->last_update_time_copy);
> -}
>   #ifdef CONFIG_FAIR_GROUP_SCHED
>   /*
>    * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> @@ -4773,19 +4791,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>   	}
>   }
>   
> -/*
> - * Synchronize entity load avg of dequeued entity without locking
> - * the previous rq.
> - */
> -static void sync_entity_load_avg(struct sched_entity *se)
> -{
> -	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -	u64 last_update_time;
> -
> -	last_update_time = cfs_rq_last_update_time(cfs_rq);
> -	__update_load_avg_blocked_se(last_update_time, se);
> -}
> -
>   /*
>    * Task first catches up with cfs_rq, and then subtract
>    * itself from the cfs_rq (task must be off the queue now).


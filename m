Return-Path: <linux-kernel+bounces-521237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE7A3B9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CDF3B62AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C41DE2A4;
	Wed, 19 Feb 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bzpFyxp+"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662C1B415A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957196; cv=none; b=PV6o0HsAsuoc/cirkBli3NXuVevzjL4pEN8KRKA5vzhDOdHbO7X2iwamIvYf7ZAwjPr+QLDrAGC9nKNy27+c9QNSD9lSbuVWXciDtouuaQsNPRTgks14rMgLqQSTdVAKzE58ovNnnPJZ4TcmRC6J2+DskEAcPhPewMFCea5yu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957196; c=relaxed/simple;
	bh=PsA/hf5tYLZxnti0cfDMvBwJN4IqI9c/qixBSNa2FgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=schGZ6OoICOpJ95itkD68A2GcNy0kyuBLf9C0ki9q9EAT+bz+TLJrK8acZsjXlAwt8shqJIlPpP1zhM+v135X5EPri+/oexue1ntJY3+0iIrG4/4Y8Q47UjhPzVw3Vxn5n4Nnk/CHw59k2aVkaeS82rxTUIhZuW5m7vxmJPLCOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bzpFyxp+; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbf4d966-172e-4cc3-b7be-d2b59ad31675@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739957191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgH5W427cZ9dv318ZcTl758aB07rFPewmoUa56sg4FQ=;
	b=bzpFyxp+RDdSfGNjG6j2C+UxFSl3WauDlVQ6WfZ/jvc3YAFsLMDB7OMvvjLKxtNGUm7Cyp
	sEW3s+0IB0xwC2muBlGKuG9DFs+T+6dX9yAwSB5YIuA8Y59dqW28AV3UtXryQfzusTJDd7
	K+Ps8ERkWSurUyWT6UICBtvAGOLoyh8=
Date: Wed, 19 Feb 2025 17:26:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched: fix potential use-after-free with cfs bandwidth
To: Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250210195117.1074569-1-joshdon@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250210195117.1074569-1-joshdon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/2/11 03:51, Josh Don wrote:
> We remove the cfs_rq throttled_csd_list entry *before* doing the
> unthrottle. The problem with that is that destroy_bandwidth() does a
> lockless scan of the system for any non-empty CSD lists. As a result,
> it is possible that destroy_bandwidth() returns while we still have a
> cfs_rq from the task group about to be unthrottled.
> 
> For full correctness, we should avoid removal from the list until after
> we're done unthrottling in __cfsb_csd_unthrottle().
> 
> For consistency, we make the same change to distribute_cfs_runtime(),
> even though this should already be safe due to destroy_bandwidth()
> cancelling the bandwidth hrtimers.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Good catch!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

BTW, I just drew the cfs_rq UAF as below:

CPU0                            CPU1
__cfsb_csd_unthrottle()
     rq lock
     for each cfs_rq on list
         list_del_init from list
                                 unregister_fair_sched_group()
                                     destroy_cfs_bandwidth()
                                         if (list_empty(&rq->cfsb_csd_list))
                                             continue; // skip rq0
                                     if (cfs_rq->on_list) // maybe false
     	unthrottle_cfs_rq()
             add cfs_rq to list
     rq unlock
                                 cfs_rq freed after RCU grace period
cfs_rq UAF!

Thanks!

> ---
>   kernel/sched/fair.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 34fe6e9490c2..78f542ab03cf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5917,10 +5917,10 @@ static void __cfsb_csd_unthrottle(void *arg)
>   
>   	list_for_each_entry_safe(cursor, tmp, &rq->cfsb_csd_list,
>   				 throttled_csd_list) {
> -		list_del_init(&cursor->throttled_csd_list);
> -
>   		if (cfs_rq_throttled(cursor))
>   			unthrottle_cfs_rq(cursor);
> +
> +		list_del_init(&cursor->throttled_csd_list);
>   	}
>   
>   	rcu_read_unlock();
> @@ -6034,11 +6034,11 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>   
>   		rq_lock_irqsave(rq, &rf);
>   
> -		list_del_init(&cfs_rq->throttled_csd_list);
> -
>   		if (cfs_rq_throttled(cfs_rq))
>   			unthrottle_cfs_rq(cfs_rq);
>   
> +		list_del_init(&cfs_rq->throttled_csd_list);
> +
>   		rq_unlock_irqrestore(rq, &rf);
>   	}
>   	SCHED_WARN_ON(!list_empty(&local_unthrottle));


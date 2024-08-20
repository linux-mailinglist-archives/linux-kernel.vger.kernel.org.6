Return-Path: <linux-kernel+bounces-293152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA97957B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BB8285194
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3B2421D;
	Tue, 20 Aug 2024 02:15:01 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6796A22339
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120101; cv=none; b=tqj5ap/RMoZbXoGkg0yLm4a2FhwSFDvc/Bz+ODSVcaRGqhm9aKUf30fVHbwGGjWCbFpMrTzrFRFlolUo+IC7FMZuNR2VS46Hr+3pJd0tWQPTjszvydnhqj6/9TVGtDGiX1vaFD8CcJGFu48E0QJ9s0Lfniyvu4v6vsQFYwaK4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120101; c=relaxed/simple;
	bh=MJ8GtQEa2+X6ZlAg8/+UMvuFz0XZ5adGva+x5z9BNTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rCN7LAnZb3X/t2PM1S13WBiGPRYdAbMtNPFk2cX+sEf9SoA3PGYaslLMG9MTSKlgTGCsw6foawr0M3k/+ZprPxNevzpHlAd9wuB7Dd7X4vrXPDNtq/sPHCUUjEjqb9piChPAicOc01OXUF8aoV0+4iWuWZihVr/L58QZbLudqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WntKN48pYz1xvQ3;
	Tue, 20 Aug 2024 10:12:56 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D72F1A0188;
	Tue, 20 Aug 2024 10:14:50 +0800 (CST)
Received: from [10.45.176.45] (10.45.176.45) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Aug
 2024 10:14:49 +0800
Message-ID: <b8fc12fa-57c8-4578-883a-a452f4ff1127@huawei.com>
Date: Tue, 20 Aug 2024 10:14:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/core: change rq->nr_iowait type to
 atomic_long_t
To: Jens Axboe <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <tglx@linutronix.de>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240819154259.215504-3-axboe@kernel.dk>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240819154259.215504-3-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2024/8/19 23:39, Jens Axboe 写道:
> In preparation for storing two separate iowait states in there, bump the
> size from a 32-bit to a 64-bit size, for 64-bit kernels. On 32-bit
> archs, the type remains a 32-bit size.
> 
> Note that on 32-bit, the number of tasks are limited to 0x8000, which
> fits just fine in even half of the existing 32-bit atomic_t. For 64-bit,
> no such limit exists, hence play it safe and make it a 64-bit atomic.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Zhang Qiao <zhangqiao22@huawei.com>

> ---
>  kernel/sched/core.c  | 8 ++++----
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9bf1b67818d0..7e04b84dcc55 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3543,17 +3543,17 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>  
>  static void task_iowait_inc(struct task_struct *p)
>  {
> -	atomic_inc(&task_rq(p)->nr_iowait);
> +	atomic_long_inc(&task_rq(p)->nr_iowait);
>  }
>  
>  static void task_iowait_dec(struct task_struct *p)
>  {
> -	atomic_dec(&task_rq(p)->nr_iowait);
> +	atomic_long_dec(&task_rq(p)->nr_iowait);
>  }
>  
>  int rq_iowait(struct rq *rq)
>  {
> -	return atomic_read(&rq->nr_iowait);
> +	return atomic_long_read(&rq->nr_iowait);
>  }
>  
>  static void
> @@ -8372,7 +8372,7 @@ void __init sched_init(void)
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> -		atomic_set(&rq->nr_iowait, 0);
> +		atomic_long_set(&rq->nr_iowait, 0);
>  		fair_server_init(rq);
>  
>  #ifdef CONFIG_SCHED_CORE
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b6b3b565bcb1..da2e67621f39 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1082,7 +1082,7 @@ struct rq {
>  	u64			clock_idle_copy;
>  #endif
>  
> -	atomic_t		nr_iowait;
> +	atomic_long_t		nr_iowait;>
>  #ifdef CONFIG_SCHED_DEBUG
>  	u64 last_seen_need_resched_ns;


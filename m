Return-Path: <linux-kernel+bounces-291533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB2C9563C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CE41C21324
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48014B97D;
	Mon, 19 Aug 2024 06:31:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C2142E83
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049084; cv=none; b=Xch2w6LRzVdpWhAUy456clZBBSlE9QSs271M4on3g8KLRzGk1nKHulDLoI9szyvgP0BrhCuHdg72uWpnnvD76I4U6vvCNyHNapCiemgy6LrTWdaJwZVvvIQdG3XIsIrYLEeaA1ojCL6yQLRdYw2e/iIUNZsY5F6qdNCxQXZR2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049084; c=relaxed/simple;
	bh=vsnMNXrmrVmq1nWFbU3fJOAqveLwDgDbQvcaU9nbdzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uug21fSWPREGVBbMjOJ0V4rQp7LTfPPtAVhLObcO28QJX8W/dZCIOBRs3xsAd9iY90Zw1G/dUnIVdboq+4V/oTPY1JMhc87mV1VZ7zKFYDNDGO/hOolPy+Ru1KltwZfnQRbVO2GwpBieSmIz4vh+u26C26GZ9A7WieiaLkHAREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WnN5J0Vvbz13Shv;
	Mon, 19 Aug 2024 14:30:44 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 28AAC1800F2;
	Mon, 19 Aug 2024 14:31:20 +0800 (CST)
Received: from [10.45.182.171] (10.45.182.171) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Aug 2024 14:31:19 +0800
Message-ID: <004e1d6a-64ed-4024-b7f7-3f8ed1010e36@huawei.com>
Date: Mon, 19 Aug 2024 14:30:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/core: change rq->nr_iowait type to
 atomic_long_t on 64-bit
To: Jens Axboe <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <tglx@linutronix.de>
References: <20240817204639.132794-1-axboe@kernel.dk>
 <20240817204639.132794-3-axboe@kernel.dk>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240817204639.132794-3-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200007.china.huawei.com (7.202.181.34)

hi,

在 2024/8/18 4:45, Jens Axboe 写道:
> In preparation for storing two separate iowait states in there, bump the
> size from a 32-bit to a 64-bit size, for 64-bit kernels.
> 
> Note that on 32-bit, the number of tasks are limited to 0x8000, which
> fits just fine in even half of the existiing 32-bit atomic_t. For 64-bit,
> no such limit exists, hence play it safe and make it a 64-bit atomic.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/sched/core.c  | 14 +++++++++++++-
>  kernel/sched/sched.h |  4 ++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9bf1b67818d0..ddabf20cd9e0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3543,17 +3543,29 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
>  
>  static void task_iowait_inc(struct task_struct *p)
>  {
> +#ifdef CONFIG_64BIT
> +	atomic_long_inc(&task_rq(p)->nr_iowait);
> +#else
>  	atomic_inc(&task_rq(p)->nr_iowait);
> +#endif>  }
>  
>  static void task_iowait_dec(struct task_struct *p)
>  {
> +#ifdef CONFIG_64BIT
> +	atomic_long_dec(&task_rq(p)->nr_iowait);
> +#else
>  	atomic_dec(&task_rq(p)->nr_iowait);
> +#endif
>  }
>  
>  int rq_iowait(struct rq *rq)
>  {
> +#ifdef CONFIG_64BIT
> +	return atomic_long_read(&rq->nr_iowait);
> +#else
>  	return atomic_read(&rq->nr_iowait);
> +#endif
>  }
>  
>  static void
> @@ -8372,7 +8384,7 @@ void __init sched_init(void)
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> -		atomic_set(&rq->nr_iowait, 0);
> +		atomic_long_set(&rq->nr_iowait, 0);
>  		fair_server_init(rq);
>  
>  #ifdef CONFIG_SCHED_CORE
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b6b3b565bcb1..6a90c2da1eb3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1082,7 +1082,11 @@ struct rq {
>  	u64			clock_idle_copy;
>  #endif
>  
> +#ifdef CONFIG_64BIT
> +	atomic_long_t		nr_iowait;
> +#else
>  	atomic_t		nr_iowait;
> +#endif

When CONFIG_64BIT is not set, the type atomic_long_t as a synonym of the type atomic_t.
Can you directly use atomic_long_t, is right?

Thanks.
Zhang Qiao.

>  
>  #ifdef CONFIG_SCHED_DEBUG
>  	u64 last_seen_need_resched_ns;


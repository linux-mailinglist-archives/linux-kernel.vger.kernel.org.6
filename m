Return-Path: <linux-kernel+bounces-358721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C79982D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66A2283912
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6704C1BCA07;
	Thu, 10 Oct 2024 09:50:47 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B571B5EBC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553847; cv=none; b=XcV/C+kqEzpr1uocRNO6N5Qb33Of7SjvKvbzvBiTSgkmgW5KOs6D1kybatWOYz4/Zw0rYbbF/Z8w495nvg+anuK1XorgcJfZ1c4N9YpZhiplEJDF89yc8xax6XYBX9jVYJHYLo7UZY9n6gZJ6bXVF6SWDWEVPQx+2Sv9iqQZfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553847; c=relaxed/simple;
	bh=NvE7MYWd022sCQTNIVoR6FyIJdXQ9B75aBiUZABNPfs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bre9jPODRplrmO1FXYBljVe7GUFPxzMclo2gl/1HK8hXnJI/lZOrj2bAXBlMoKGMazGiI3k0Lw8gqjqCPnzGT+/lyYEhPl3uXADLqvwwWJR1eAbujCHqmqpMcK0FGhACaq2ZYZiWI+A86N97kZ6h6iEzZbzywXp4NWUw2dAxic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XPQ211NwHz1T8S5;
	Thu, 10 Oct 2024 17:48:57 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id C315D1400D8;
	Thu, 10 Oct 2024 17:50:41 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 17:50:41 +0800
Subject: Re: [patch 22/25] debugobjects: Move pool statistics into global_pool
 struct
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.318776207@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <365d6eb6-7a35-a8a3-1942-2a931a6d9f5d@huawei.com>
Date: Thu, 10 Oct 2024 17:50:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.318776207@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Keep it along with the pool as that's a hot cache line anyway and it makes
> the code more comprehensible.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   85 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 34 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -47,11 +47,18 @@ struct debug_bucket {
>  	raw_spinlock_t		lock;
>  };
>  
> +struct pool_stats {
> +	unsigned int		cur_used;
> +	unsigned int		max_used;
> +	unsigned int		min_fill;
> +};
> +
>  struct obj_pool {
>  	struct hlist_head	objects;
>  	unsigned int		cnt;
>  	unsigned int		min_cnt;
>  	unsigned int		max_cnt;
> +	struct pool_stats	stats;
>  } ____cacheline_aligned;
>  
>  
> @@ -66,8 +73,11 @@ static struct debug_obj		obj_static_pool
>  static DEFINE_RAW_SPINLOCK(pool_lock);
>  
>  static struct obj_pool pool_global = {
> -	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
> -	.max_cnt	= ODEBUG_POOL_SIZE,
> +	.min_cnt		= ODEBUG_POOL_MIN_LEVEL,
> +	.max_cnt		= ODEBUG_POOL_SIZE,
> +	.stats			= {
> +		.min_fill	= ODEBUG_POOL_SIZE,
> +	},
>  };
>  
>  static struct obj_pool pool_to_free = {
> @@ -76,16 +86,6 @@ static struct obj_pool pool_to_free = {
>  
>  static HLIST_HEAD(pool_boot);
>  
> -/*
> - * Because of the presence of percpu free pools, obj_pool_free will
> - * under-count those in the percpu free pools. Similarly, obj_pool_used
> - * will over-count those in the percpu free pools. Adjustments will be
> - * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
> - * can be off.
> - */
> -static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
> -static int			obj_pool_used;
> -static int __data_racy		obj_pool_max_used;
>  static bool			obj_freeing;
>  
>  static int __data_racy			debug_objects_maxchain __read_mostly;
> @@ -231,6 +231,19 @@ static struct debug_obj *__alloc_object(
>  	return obj;
>  }
>  
> +static void pcpu_refill_stats(void)
> +{
> +	struct pool_stats *stats = &pool_global.stats;
> +
> +	WRITE_ONCE(stats->cur_used, stats->cur_used + ODEBUG_BATCH_SIZE);
> +
> +	if (stats->cur_used > stats->max_used)
> +		stats->max_used = stats->cur_used;
> +
> +	if (pool_global.cnt < stats->min_fill)
> +		stats->min_fill = pool_global.cnt;
> +}
> +
>  static struct debug_obj *pcpu_alloc(void)
>  {
>  	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
> @@ -250,13 +263,7 @@ static struct debug_obj *pcpu_alloc(void
>  			if (!pool_move_batch(pcp, &pool_global))
>  				return NULL;
>  		}
> -		obj_pool_used += ODEBUG_BATCH_SIZE;
> -
> -		if (obj_pool_used > obj_pool_max_used)
> -			obj_pool_max_used = obj_pool_used;
> -
> -		if (pool_global.cnt < obj_pool_min_free)
> -			obj_pool_min_free = pool_global.cnt;
> +		pcpu_refill_stats();
>  	}
>  }
>  
> @@ -285,7 +292,7 @@ static void pcpu_free(struct debug_obj *
>  	/* Try to fit the batch into the pool_global first */
>  	if (!pool_move_batch(&pool_global, pcp))
>  		pool_move_batch(&pool_to_free, pcp);
> -	obj_pool_used -= ODEBUG_BATCH_SIZE;
> +	WRITE_ONCE(pool_global.stats.cur_used, pool_global.stats.cur_used - ODEBUG_BATCH_SIZE);
>  }
>  
>  static void free_object_list(struct hlist_head *head)
> @@ -1074,23 +1081,33 @@ void debug_check_no_obj_freed(const void
>  
>  static int debug_stats_show(struct seq_file *m, void *v)
>  {
> -	int cpu, obj_percpu_free = 0;
> +	unsigned int cpu, pool_used, pcp_free = 0;
>  
> +	/*
> +	 * pool_global.stats.cur_used is the number of batches currently
> +	 * handed out to per CPU pools. Convert it to number of objects
> +	 * and subtract the number of free objects in the per CPU pools.
> +	 * As this is lockless the number is an estimate.
> +	 */
>  	for_each_possible_cpu(cpu)
> -		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
> +		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
>  
> -	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
> -	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
> -	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
> -	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
> -	seq_printf(m, "pool_free     :%d\n", pool_count(&pool_global) + obj_percpu_free);
> -	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
> -	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
> -	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
> -	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
> -	seq_printf(m, "on_free_list  :%d\n", pool_count(&pool_to_free));
> -	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
> -	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
> +	pool_used = data_race(pool_global.stats.cur_used);
> +	pcp_free = min(pool_used, pcp_free);
> +	pool_used -= pcp_free;
> +
> +	seq_printf(m, "max_chain     : %d\n", debug_objects_maxchain);
> +	seq_printf(m, "max_checked   : %d\n", debug_objects_maxchecked);
> +	seq_printf(m, "warnings      : %d\n", debug_objects_warnings);
> +	seq_printf(m, "fixups        : %d\n", debug_objects_fixups);
> +	seq_printf(m, "pool_free     : %u\n", pool_count(&pool_global) + pcp_free);
> +	seq_printf(m, "pool_pcp_free : %u\n", pcp_free);
> +	seq_printf(m, "pool_min_free : %u\n", data_race(pool_global.stats.min_fill));
> +	seq_printf(m, "pool_used     : %u\n", pool_used);
> +	seq_printf(m, "pool_max_used : %u\n", data_race(pool_global.stats.max_used));
> +	seq_printf(m, "on_free_list  : %u\n", pool_count(&pool_to_free));
> +	seq_printf(m, "objs_allocated: %d\n", debug_objects_allocated);
> +	seq_printf(m, "objs_freed    : %d\n", debug_objects_freed);
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(debug_stats);
> 
> .
> 

-- 
Regards,
  Zhen Lei


Return-Path: <linux-kernel+bounces-418644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426679D63C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD8A2812D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99B1E00B6;
	Fri, 22 Nov 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL0w1m/r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6F1DF74F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732298689; cv=none; b=X9epSDmDAlaNFbZQXeYIl8eWv1/WkZp+zsElCirpV8oWan8zcbWSvcEh/MOf6t0RKqCKngiS31f6W3C+JdeP30B1nQ9fKIKMZQ/KOnRLcHovbpUMoFLpx43yjKPIhWwVEk08kyrf3rgkeK8TJyuDUpy99rGEKc1uQA7rgUydGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732298689; c=relaxed/simple;
	bh=wbLbmFeqGSARo/6sD4GtabGrwTn1Rj5yrbda9ek0Vk0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GclWZKZW1K4gCdadhD6bmlBC3SXEVlR3l4EBj5ZTLP5WD2qyDPXxVuPlEqVBDf+izjbJ6I5c+pzrqDJ/p8uggHK5xBsefezYiqBkQu61jZNI58Luz6M1gmDUjGp9r+Lxa1Yq1IWVXhoGnUhuPFQ6m7v3/5zBvGV9rdWn6ZJ46+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dL0w1m/r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732298686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgB4Xh16LltpIZ14PxsaottjJCcCZ0sRpmkNwhVZ7wk=;
	b=dL0w1m/rKRzSVTbAPD/zpL9tcofru1CfN4SSftVtFZUnrwIHmuBemPRE3JBrIwE9UXyBTO
	rBRBKn8igWR+4wdNmX9MNImkuJ3WLVLoHm+vQzYuVhk/VlcVH6buSWqb5LawgzkZAypP4M
	bEHMfmzRJNPFdne2gHIvKYD3qsmhRYk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-sIK7YWxOPGOaxmhmU0sa5g-1; Fri, 22 Nov 2024 13:04:43 -0500
X-MC-Unique: sIK7YWxOPGOaxmhmU0sa5g-1
X-Mimecast-MFC-AGG-ID: sIK7YWxOPGOaxmhmU0sa5g
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a808c27so24692375ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732298683; x=1732903483;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgB4Xh16LltpIZ14PxsaottjJCcCZ0sRpmkNwhVZ7wk=;
        b=fEEItw6q+POjLCOh2i37VK0egxoefy37ZMQRIJ8qh0P1YA4sYBxJwXHo69xDiHHrkx
         x2qA82c0W1Nu1/X4Ou7yZITOIccDv7DDlEYexyhgZWHC2LAhrgCGKbLsItp6cu/k1lo+
         S329dFBtdE+3auvBEnNXZsW0ENxtp1P9lOfbvcwLdVKk7BZnwG12DxcojJRYlc3wbDyT
         qM5YI/PlKzdyOeI/SKulKH3Modyrv8NWXue0LW1uxOypRZ1WSQmneYIL47iMTwKp6Auf
         fX/LJo0nfAigK/mgMqwZ9vcUhD0u+dJZ6AIcEnFGZizvNJ0wAra99VtB1Wznz25DUAf1
         3pkw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuTETBBtzbzifL9WCnS56Upn5U9vepn1P7nuorPY+eiUtgkJBM6PAgZ6A9G02nd+JU0qzTKQmUN4TQeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKScPdpdIAxKNYivtKZio0dv76IN+4zmTfo00nV0AKcB8gAoO
	IeHOWPrfX5aIx5ruLr6ORYbBcSQrFO04cw1sQXJ4yjVhvPJI0DJYmfaMYgT/DBC72mLFJ2Yug+W
	R7zxUxqh6BOaud+J0q4vhZb6lwV7Skhcyj30u9dKfQ7ywGFZHqBh7m/b9ivqi6w==
X-Gm-Gg: ASbGncvmj25b7dlBS8wH/HR1rykxj5EcGODaR25YJH8HvwJxfAG1JCU6DRRXJ9uX9d7
	XYsPUaWF0XLYpo4peRYnZ4KrsuP/hGhSdhOmzc4FxV+2pxOFPoGa6qYn8EQhbUlgSnD529trM1m
	pbKqKBdlv7o16kKdOCH3vgcrNMvvVsK8KhMimxkMdJqBX1LGg5DqjmuTrVazYDludP6RNI7nS/f
	lbyehoTJEq39Ik97IGAknKDhpI23pLqqJeezsDtd11J4KfZlcmKeRUeh0Thzo6r4uTJoXwI6fk5
	6EcvMnrFI0Bk+YFPQA==
X-Received: by 2002:a05:6e02:3187:b0:3a7:a553:7dc with SMTP id e9e14a558f8ab-3a7a5530fafmr21839515ab.7.1732298683162;
        Fri, 22 Nov 2024 10:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEycfqbiLDKzC9HEe7UneIN9L0zCzy5DBNTAPREtAcHYE3jCT/+nP1BaSQxpdcOYHj16em97A==
X-Received: by 2002:a05:6e02:3187:b0:3a7:a553:7dc with SMTP id e9e14a558f8ab-3a7a5530fafmr21838975ab.7.1732298682781;
        Fri, 22 Nov 2024 10:04:42 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79ac9735csm5893795ab.50.2024.11.22.10.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:04:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <514c8a18-0b12-481b-94c2-00cabd5a4a42@redhat.com>
Date: Fri, 22 Nov 2024 13:04:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Make kasan_record_aux_stack_noalloc() the
 default behaviour
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, dvyukov@google.com,
 vincenzo.frascino@arm.com, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, josh@joshtriplett.org,
 boqun.feng@gmail.com, urezki@gmail.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, rcu@vger.kernel.org
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com>
 <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz>
 <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com>
 <20241119155701.GYennzPF@linutronix.de>
 <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
 <20241122155451.Mb2pmeyJ@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241122155451.Mb2pmeyJ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/22/24 10:54 AM, Sebastian Andrzej Siewior wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> kasan_record_aux_stack_noalloc() was introduced to record a stack trace
> without allocating memory in the process. It has been added to callers
> which were invoked while a raw_spinlock_t was held.
> More and more callers were identified and changed over time. Is it a
> good thing to have this while functions try their best to do a
> locklessly setup? The only downside of having kasan_record_aux_stack()
> not allocate any memory is that we end up without a stacktrace if
> stackdepot runs out of memory and at the same stacktrace was not
> recorded before To quote Marco Elver from
>     https://lore.kernel.org/all/CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com/
>
> | I'd be in favor, it simplifies things. And stack depot should be
> | able to replenish its pool sufficiently in the "non-aux" cases
> | i.e. regular allocations. Worst case we fail to record some
> | aux stacks, but I think that's only really bad if there's a bug
> | around one of these allocations. In general the probabilities
> | of this being a regression are extremely small [...]
>
> Make the kasan_record_aux_stack_noalloc() behaviour default as
> kasan_record_aux_stack().
>
> [bigeasy: Dressed the diff as patch. ]
>
> Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67275485.050a0220.3c8d68.0a37.GAE@google.com
> Acked-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Fixes: 7cb3007ce2da2 ("kasan: generic: introduce kasan_record_aux_stack_noalloc()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>    - Renamed the patch as per Marco.
>    - Added comment to kasan_record_aux_stack() as per Andrey.
>    - Added fixes tag since Waiman that it is the only user.
>    - Added Marco's quote from the mail to the commit description.
>
>   include/linux/kasan.h     |  2 --
>   include/linux/task_work.h |  3 ---
>   kernel/irq_work.c         |  2 +-
>   kernel/rcu/tiny.c         |  2 +-
>   kernel/rcu/tree.c         |  4 ++--
>   kernel/sched/core.c       |  2 +-
>   kernel/task_work.c        | 14 +-------------
>   kernel/workqueue.c        |  2 +-
>   mm/kasan/generic.c        | 18 ++++++------------
>   mm/slub.c                 |  2 +-
>   10 files changed, 14 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 00a3bf7c0d8f0..1a623818e8b39 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -488,7 +488,6 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>   void kasan_cache_shrink(struct kmem_cache *cache);
>   void kasan_cache_shutdown(struct kmem_cache *cache);
>   void kasan_record_aux_stack(void *ptr);
> -void kasan_record_aux_stack_noalloc(void *ptr);
>   
>   #else /* CONFIG_KASAN_GENERIC */
>   
> @@ -506,7 +505,6 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
>   static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
>   static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>   static inline void kasan_record_aux_stack(void *ptr) {}
> -static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
>   
>   #endif /* CONFIG_KASAN_GENERIC */
>   
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 2964171856e00..0646804860ff1 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -19,9 +19,6 @@ enum task_work_notify_mode {
>   	TWA_SIGNAL,
>   	TWA_SIGNAL_NO_IPI,
>   	TWA_NMI_CURRENT,
> -
> -	TWA_FLAGS = 0xff00,
> -	TWAF_NO_ALLOC = 0x0100,
>   };
>   
>   static inline bool task_work_pending(struct task_struct *task)
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 2f4fb336dda17..73f7e1fd4ab4d 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -147,7 +147,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>   	if (!irq_work_claim(work))
>   		return false;
>   
> -	kasan_record_aux_stack_noalloc(work);
> +	kasan_record_aux_stack(work);
>   
>   	preempt_disable();
>   	if (cpu != smp_processor_id()) {
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index b3b3ce34df631..4b3f319114650 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>   void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>   {
>   	if (head)
> -		kasan_record_aux_stack_noalloc(ptr);
> +		kasan_record_aux_stack(ptr);
>   
>   	__kvfree_call_rcu(head, ptr);
>   }
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1f883fcd9185..7eae9bd818a90 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3083,7 +3083,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>   	}
>   	head->func = func;
>   	head->next = NULL;
> -	kasan_record_aux_stack_noalloc(head);
> +	kasan_record_aux_stack(head);
>   	local_irq_save(flags);
>   	rdp = this_cpu_ptr(&rcu_data);
>   	lazy = lazy_in && !rcu_async_should_hurry();
> @@ -3807,7 +3807,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>   		return;
>   	}
>   
> -	kasan_record_aux_stack_noalloc(ptr);
> +	kasan_record_aux_stack(ptr);
>   	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>   	if (!success) {
>   		run_page_cache_worker(krcp);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a1c353a62c568..3717360a940d2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10485,7 +10485,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
>   		return;
>   
>   	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
> +	task_work_add(curr, work, TWA_RESUME);
>   }
>   
>   void sched_mm_cid_exit_signals(struct task_struct *t)
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index c969f1f26be58..d1efec571a4a4 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -55,26 +55,14 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
>   		  enum task_work_notify_mode notify)
>   {
>   	struct callback_head *head;
> -	int flags = notify & TWA_FLAGS;
>   
> -	notify &= ~TWA_FLAGS;
>   	if (notify == TWA_NMI_CURRENT) {
>   		if (WARN_ON_ONCE(task != current))
>   			return -EINVAL;
>   		if (!IS_ENABLED(CONFIG_IRQ_WORK))
>   			return -EINVAL;
>   	} else {
> -		/*
> -		 * Record the work call stack in order to print it in KASAN
> -		 * reports.
> -		 *
> -		 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
> -		 * is set and new page is needed to expand the stack buffer.
> -		 */
> -		if (flags & TWAF_NO_ALLOC)
> -			kasan_record_aux_stack_noalloc(work);
> -		else
> -			kasan_record_aux_stack(work);
> +		kasan_record_aux_stack(work);
>   	}
>   
>   	head = READ_ONCE(task->task_works);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9949ffad8df09..65b8314b2d538 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2180,7 +2180,7 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
>   	debug_work_activate(work);
>   
>   	/* record the work call stack in order to print it in KASAN reports */
> -	kasan_record_aux_stack_noalloc(work);
> +	kasan_record_aux_stack(work);
>   
>   	/* we own @work, set data and link */
>   	set_work_pwq(work, pwq, extra_flags);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 6310a180278b6..2242249c2d50d 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -521,7 +521,11 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>   			sizeof(struct kasan_free_meta) : 0);
>   }
>   
> -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
> +/*
> + * This function avoids dynamic memory allocations and thus can be called from
> + * contexts that do not allow allocating memory.
> + */
> +void kasan_record_aux_stack(void *addr)
>   {
>   	struct slab *slab = kasan_addr_to_slab(addr);
>   	struct kmem_cache *cache;
> @@ -538,17 +542,7 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
>   		return;
>   
>   	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> -	alloc_meta->aux_stack[0] = kasan_save_stack(0, depot_flags);
> -}
> -
> -void kasan_record_aux_stack(void *addr)
> -{
> -	return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC);
> -}
> -
> -void kasan_record_aux_stack_noalloc(void *addr)
> -{
> -	return __kasan_record_aux_stack(addr, 0);
> +	alloc_meta->aux_stack[0] = kasan_save_stack(0, 0);
>   }
>   
>   void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> diff --git a/mm/slub.c b/mm/slub.c
> index 5b832512044e3..b8c4bf3fe0d07 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2300,7 +2300,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
>   			 * We have to do this manually because the rcu_head is
>   			 * not located inside the object.
>   			 */
> -			kasan_record_aux_stack_noalloc(x);
> +			kasan_record_aux_stack(x);
>   
>   			delayed_free->object = x;
>   			call_rcu(&delayed_free->head, slab_free_after_rcu_debug);

LGTM

Reviewed-by: Waiman Long <longman@redhat.com>



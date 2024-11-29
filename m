Return-Path: <linux-kernel+bounces-414599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41A9D2AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94EF2838C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084A1D04A6;
	Tue, 19 Nov 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUT4XGjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C91CBE9C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033383; cv=none; b=C+cBfuEuLoO0zLLUpgKVFlYD92TzvPT741epprXrJSfy2iXNrdCk0d+APil9EgHkK36iSc+a+Gy/52WtZ8k1onrOBXanyCEQzjQc6eUSV/bQ3r6xYgRU3TOd8ZXkWxbiFFWUtHIi+Ux7DUQASVGdNaNq+YRkVJ6ZpLfsNqnliAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033383; c=relaxed/simple;
	bh=e2K1GP8scyOUCNjsQqVWYxLjHy+GL9YI82KyrRkXV9g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qkicy1szzz/nZzaoRYVzxSIGpsM9Djod7epgmchDLV//ea1y1hZm+g2z2ZdtqjzfxcGTT8tViHjLgAic/PNKgy4X2IPWOF7Pl6CWxfZi4XTld/MDJfygtu45PvX7mvyIOyhcgrJlDTDnHojxjwNA+Oynnc4wYXjkN/F2VdoMWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUT4XGjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732033381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suWdsjJ5WnUgZV8pnJXIYBOLHIoG3Gy/626N1DpjAyk=;
	b=TUT4XGjlK127KVQVnPyE50pxxOkSP53NrIHL/jb39vATleIxhA5ZntHC63C7WZxCGI1YgI
	6OSMjjYkjQ4671RFp+/5fJ7lR1I9fzPlha0Vg1zasynXYCWkmllPmj0N9pgy6E20saCJzx
	5RLqhV8yZ1u0/I2QK5pOqMc09n+9tJ4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-69A7o6hfOf69LKduMG3mbA-1; Tue, 19 Nov 2024 11:22:59 -0500
X-MC-Unique: 69A7o6hfOf69LKduMG3mbA-1
X-Mimecast-MFC-AGG-ID: 69A7o6hfOf69LKduMG3mbA
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77085a3d7so15513445ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033379; x=1732638179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suWdsjJ5WnUgZV8pnJXIYBOLHIoG3Gy/626N1DpjAyk=;
        b=WPq3hOmqB0b/0rsvl7a0pb60JfTTVwuNGV3zfv0pZecfbblJlmrL9S9Bp3YIc3xX2O
         JYJTZa3MERMKe4UE3y8Bw8M5QT7hzN5Tu342p0JIfgU0ndO2RsQuPNz13B3isYdDpeEt
         giTDL7Vsa/o4o6uO0xqpIxD5bcKM8xxS+wHJDO9oUQkGZw8MrL97nhW7/CLxIe/zBciP
         6OwlzLmuXTJWSzvOmk/Wrn0/3nTsb/yNQQHDUwFMlIrP4HHFbWQGAsBH1YEvAjndKGyd
         O4+ysWdm4sHXXx47afRdZ8Jau0RJvyN74VxVVbAahPz/qNGy4HAB0JI8A7jEosN2AU0D
         XYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfbk4wQ6YvzZl1eKp63k3S/8M4wr9Hdvki3ZGwfHz7i/QhxTce1Bp48jYIjjRdqSK0XPUp/x4lmwWMBP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzh34eQ22NIvvyo2iSLBUut6NKjaiaku8h0QsB5ufe43HDMbnn
	bv9ONwhBk7IsEMttr1jERgtDjoBLWSN2rfnE1IPqHLXlDE+JmQpuAg1Nzu6XHkMl2ZHnkOsNcpJ
	ZTKRP7Z4iEfQOf/Z3bP6yOtXZd7VZlzIJB5Y+Mq2tvcuc3tMFT7/x346KZkmVVQ==
X-Received: by 2002:a05:6e02:1526:b0:3a7:645f:6152 with SMTP id e9e14a558f8ab-3a77744e30cmr33621635ab.8.1732033379131;
        Tue, 19 Nov 2024 08:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiseTfVZI8CsQcS8/9Er7MhjJVsr44kaPa/nmeikEF5kUEcerPDk12H3KMCedgJZbYdTUn7w==
X-Received: by 2002:a05:6e02:1526:b0:3a7:645f:6152 with SMTP id e9e14a558f8ab-3a77744e30cmr33621435ab.8.1732033378760;
        Tue, 19 Nov 2024 08:22:58 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a77ffe8df6sm1870915ab.72.2024.11.19.08.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:22:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <95194abd-1ec6-4db3-9f83-4d482b2fac50@redhat.com>
Date: Tue, 19 Nov 2024 11:22:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
 Andrey Konovalov <andreyknvl@gmail.com>,
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
Content-Language: en-US
In-Reply-To: <20241119155701.GYennzPF@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/24 10:57 AM, Sebastian Andrzej Siewior wrote:
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
> recorded before. Marco Elver said in
> 	https://lore.kernel.org/all/20210913112609.2651084-1-elver@google.com/
> that this is rare.
>
> Make the kasan_record_aux_stack_noalloc() behaviour default as
> kasan_record_aux_stack().
>
> [bigeasy: Dressed the diff as patch. ]
>
> Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67275485.050a0220.3c8d68.0a37.GAE@google.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> Didn't add a Fixes tag, didn't want to put
>     7cb3007ce2da2 ("kasan: generic: introduce kasan_record_aux_stack_noalloc()")
>
> there.

Right now task_work_add() is the only caller of 
kasan_record_aux_stack(). So it essentially make all its callers use the 
noalloc version of kasan_record_aux_stack().

Acked-by: Waiman Long <longman@redhat.com>

>   include/linux/kasan.h     |  2 --
>   include/linux/task_work.h |  3 ---
>   kernel/irq_work.c         |  2 +-
>   kernel/rcu/tiny.c         |  2 +-
>   kernel/rcu/tree.c         |  4 ++--
>   kernel/sched/core.c       |  2 +-
>   kernel/task_work.c        | 14 +-------------
>   kernel/workqueue.c        |  2 +-
>   mm/kasan/generic.c        | 14 ++------------
>   mm/slub.c                 |  2 +-
>   10 files changed, 10 insertions(+), 37 deletions(-)
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
> index 6310a180278b6..b18b5944997f8 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -521,7 +521,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>   			sizeof(struct kasan_free_meta) : 0);
>   }
>   
> -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
> +void kasan_record_aux_stack(void *addr)
>   {
>   	struct slab *slab = kasan_addr_to_slab(addr);
>   	struct kmem_cache *cache;
> @@ -538,17 +538,7 @@ static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_flags)
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



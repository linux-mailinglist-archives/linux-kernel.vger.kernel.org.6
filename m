Return-Path: <linux-kernel+bounces-414890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715BB9D2EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD22BB2A3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006191D1E73;
	Tue, 19 Nov 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C96So+aK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250851D1305;
	Tue, 19 Nov 2024 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045032; cv=none; b=PtWqfMQYwH+S9m5hYTO/7unxuaBI/bddIQEwhFrg6hgTHL8b7h7C1j5Le65PVv0gR4rz7ryCbNb5ayvny6pEsCXCnJ5lCE0TNWKAOB3S9PO4Wm8ArbZU/miTFyjCKf6UkLzNHw4pwoZnljSYyp2HLTCjbQ2iF6qB80RuVlSwq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045032; c=relaxed/simple;
	bh=gs5WCRWeIZz1LNyZJBrPdDtMjdcRRIrd9uK7zf9ffTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exg3f5tWV1a8TF0s5b3KN34uwIeSN7Q0CG490mogTWh3GReuzKHdNPv8mysTr+QBq3yIgJdXArZoR9kLaXPPx7GGJgen8mqyRlF7T2wA5jiPNjXUm8xM3hD4K6nSjfIxB5NBq3MRkL6+tbad6eIN4EUbTfPeUKKURub6ZVP2gfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C96So+aK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so12322895e9.1;
        Tue, 19 Nov 2024 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732045028; x=1732649828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdOKblGV+cU/H2wS4BCTlQ23goHv8tshPrwSMll3Yd8=;
        b=C96So+aK/0y4gw+BW855vkeGFDT3PxnJN5oAI+ucQdxdH4leSaAA7TkGAnaXKeuguu
         8cq8AopU7hff5QRBkDwYh4k1fQtBJ3E4/3r0d1SsSDkupM+Q9zSYftKcHiPwuUMyAbtr
         xYwBFKIZDnAHag64g7aaAdmCG1h6UOYLNXbl8SUPwxlQL9xndrk/uu27hUHFeNLX8aUS
         chDrEHqeEfESYfUHoC2UH0VXtQI3LoEK7Fe0b1oG3KFURBpfJO6wdQbJ/ARxBT60KD5Z
         Z871/6i3Ve6pM7b0UBnK7mBo6HT/qfnJGNREGGBAo/zd46H12E1Cnw3eEoNGrWUBWriq
         3tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732045028; x=1732649828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdOKblGV+cU/H2wS4BCTlQ23goHv8tshPrwSMll3Yd8=;
        b=e4i+ILc54J2NaZK2qFanwAze4aMTjykcR4puxApzCxulKL+LPt2cH5prj98D8ssqlP
         tcrFGd5Pr5GYkxn6G+em4TIRwF9egHokMqV/XUWtL2LtMsUxd06Agnwj3ivJAdzGE3kZ
         gK6eX1Ca5n2unBJrmFPnnA9ywsJMWEai3MZ+cvMRFJEJxRQgokW3LnGRAK7aR1gQ+bn0
         eMxQdpnmdOoMbn1j2xcLz9ncLSq+cvwzImeqE3dnUVUVe024EbB5gPH3s63i75TAB4Be
         CkoR//n2keHojM81tqfWsF/PoBPODtFb0tat0tU81D7595zUTc6v4cquELS84nQ5kQm5
         p0kg==
X-Forwarded-Encrypted: i=1; AJvYcCVAIEVNmAVl5xyexTjA8sbXLP91keAhKJxwE2WHZUSHFY6aRCFMHMhKaoxC0II1rEWNwKPEh9Onf47YExA=@vger.kernel.org, AJvYcCWGsEpaT4FYW5D8bGbe3DKciwldR/taz+ZG5yJckvZGOZ43LQYevDwxdzNCJsjeuCfTxiD5@vger.kernel.org
X-Gm-Message-State: AOJu0YylZcBJOlCIwoVnE2X+7EO9A5m/3zGNXGA80E/hZUSbJq8wB1kv
	n7cL8Mcs5bFN4knmq17IvRELHcTmXJ9HM7XfyC3tEG2c95PnwjiFRL2TDwa+SUjD+8pxgL6BhM9
	HUKdah6XacC1p/1nOI0O5q4nyu3s=
X-Google-Smtp-Source: AGHT+IH+0xv4nxzUSBUEH+sZf0d14xb3n4S11il50ZDggLNrmj8liu/Jm0Y4Op8GtAnsbxou5fmbbQuPuIYIRrdK9ok=
X-Received: by 2002:a05:6000:2805:b0:382:2ba9:9d65 with SMTP id
 ffacd0b85a97d-38254afb065mr13810f8f.31.1732045028095; Tue, 19 Nov 2024
 11:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67275485.050a0220.3c8d68.0a37.GAE@google.com> <ee48b6e9-3f7a-49aa-ae5b-058b5ada2172@suse.cz>
 <b9a674c1-860c-4448-aeb2-bf07a78c6fbf@suse.cz> <20241104114506.GC24862@noisy.programming.kicks-ass.net>
 <CANpmjNPmQYJ7pv1N3cuU8cP18u7PP_uoZD8YxwZd4jtbof9nVQ@mail.gmail.com> <20241119155701.GYennzPF@linutronix.de>
In-Reply-To: <20241119155701.GYennzPF@linutronix.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 19 Nov 2024 20:36:56 +0100
Message-ID: <CA+fCnZfzJcbEy0Qmn5GPzPUx9diR+3qw+4ukHa2j5xzzQMF8Kw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Remove kasan_record_aux_stack_noalloc().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, 
	syzbot <syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, kasan-dev <kasan-dev@googlegroups.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Waiman Long <longman@redhat.com>, dvyukov@google.com, vincenzo.frascino@arm.com, 
	paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joel@joelfernandes.org, josh@joshtriplett.org, boqun.feng@gmail.com, 
	urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	Thomas Gleixner <tglx@linutronix.de>, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:57=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
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
>         https://lore.kernel.org/all/20210913112609.2651084-1-elver@google=
.com/
> that this is rare.
>
> Make the kasan_record_aux_stack_noalloc() behaviour default as
> kasan_record_aux_stack().
>
> [bigeasy: Dressed the diff as patch. ]
>
> Reported-by: syzbot+39f85d612b7c20d8db48@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67275485.050a0220.3c8d68.0a37.GAE@goo=
gle.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> Didn't add a Fixes tag, didn't want to put
>    7cb3007ce2da2 ("kasan: generic: introduce kasan_record_aux_stack_noall=
oc()")
>
> there.
>
>  include/linux/kasan.h     |  2 --
>  include/linux/task_work.h |  3 ---
>  kernel/irq_work.c         |  2 +-
>  kernel/rcu/tiny.c         |  2 +-
>  kernel/rcu/tree.c         |  4 ++--
>  kernel/sched/core.c       |  2 +-
>  kernel/task_work.c        | 14 +-------------
>  kernel/workqueue.c        |  2 +-
>  mm/kasan/generic.c        | 14 ++------------
>  mm/slub.c                 |  2 +-
>  10 files changed, 10 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 00a3bf7c0d8f0..1a623818e8b39 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -488,7 +488,6 @@ void kasan_cache_create(struct kmem_cache *cache, uns=
igned int *size,
>  void kasan_cache_shrink(struct kmem_cache *cache);
>  void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_record_aux_stack(void *ptr);
> -void kasan_record_aux_stack_noalloc(void *ptr);
>
>  #else /* CONFIG_KASAN_GENERIC */
>
> @@ -506,7 +505,6 @@ static inline void kasan_cache_create(struct kmem_cac=
he *cache,
>  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
>  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  static inline void kasan_record_aux_stack(void *ptr) {}
> -static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 2964171856e00..0646804860ff1 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -19,9 +19,6 @@ enum task_work_notify_mode {
>         TWA_SIGNAL,
>         TWA_SIGNAL_NO_IPI,
>         TWA_NMI_CURRENT,
> -
> -       TWA_FLAGS =3D 0xff00,
> -       TWAF_NO_ALLOC =3D 0x0100,
>  };
>
>  static inline bool task_work_pending(struct task_struct *task)
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 2f4fb336dda17..73f7e1fd4ab4d 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -147,7 +147,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu=
)
>         if (!irq_work_claim(work))
>                 return false;
>
> -       kasan_record_aux_stack_noalloc(work);
> +       kasan_record_aux_stack(work);
>
>         preempt_disable();
>         if (cpu !=3D smp_processor_id()) {
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index b3b3ce34df631..4b3f319114650 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  {
>         if (head)
> -               kasan_record_aux_stack_noalloc(ptr);
> +               kasan_record_aux_stack(ptr);
>
>         __kvfree_call_rcu(head, ptr);
>  }
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index b1f883fcd9185..7eae9bd818a90 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3083,7 +3083,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callba=
ck_t func, bool lazy_in)
>         }
>         head->func =3D func;
>         head->next =3D NULL;
> -       kasan_record_aux_stack_noalloc(head);
> +       kasan_record_aux_stack(head);
>         local_irq_save(flags);
>         rdp =3D this_cpu_ptr(&rcu_data);
>         lazy =3D lazy_in && !rcu_async_should_hurry();
> @@ -3807,7 +3807,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *p=
tr)
>                 return;
>         }
>
> -       kasan_record_aux_stack_noalloc(ptr);
> +       kasan_record_aux_stack(ptr);
>         success =3D add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>         if (!success) {
>                 run_page_cache_worker(krcp);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a1c353a62c568..3717360a940d2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10485,7 +10485,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_=
struct *curr)
>                 return;
>
>         /* No page allocation under rq lock */
> -       task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
> +       task_work_add(curr, work, TWA_RESUME);
>  }
>
>  void sched_mm_cid_exit_signals(struct task_struct *t)
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index c969f1f26be58..d1efec571a4a4 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -55,26 +55,14 @@ int task_work_add(struct task_struct *task, struct ca=
llback_head *work,
>                   enum task_work_notify_mode notify)
>  {
>         struct callback_head *head;
> -       int flags =3D notify & TWA_FLAGS;
>
> -       notify &=3D ~TWA_FLAGS;
>         if (notify =3D=3D TWA_NMI_CURRENT) {
>                 if (WARN_ON_ONCE(task !=3D current))
>                         return -EINVAL;
>                 if (!IS_ENABLED(CONFIG_IRQ_WORK))
>                         return -EINVAL;
>         } else {
> -               /*
> -                * Record the work call stack in order to print it in KAS=
AN
> -                * reports.
> -                *
> -                * Note that stack allocation can fail if TWAF_NO_ALLOC f=
lag
> -                * is set and new page is needed to expand the stack buff=
er.
> -                */
> -               if (flags & TWAF_NO_ALLOC)
> -                       kasan_record_aux_stack_noalloc(work);
> -               else
> -                       kasan_record_aux_stack(work);
> +               kasan_record_aux_stack(work);
>         }
>
>         head =3D READ_ONCE(task->task_works);
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9949ffad8df09..65b8314b2d538 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2180,7 +2180,7 @@ static void insert_work(struct pool_workqueue *pwq,=
 struct work_struct *work,
>         debug_work_activate(work);
>
>         /* record the work call stack in order to print it in KASAN repor=
ts */
> -       kasan_record_aux_stack_noalloc(work);
> +       kasan_record_aux_stack(work);
>
>         /* we own @work, set data and link */
>         set_work_pwq(work, pwq, extra_flags);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 6310a180278b6..b18b5944997f8 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -521,7 +521,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache, =
bool in_object)
>                         sizeof(struct kasan_free_meta) : 0);
>  }
>
> -static void __kasan_record_aux_stack(void *addr, depot_flags_t depot_fla=
gs)

Could you add a comment here that notes the usage, something like:

"This function avoids dynamic memory allocations and thus can be
called from contexts that do not allow allocating memory."

> +void kasan_record_aux_stack(void *addr)
>  {
>         struct slab *slab =3D kasan_addr_to_slab(addr);
>         struct kmem_cache *cache;
> @@ -538,17 +538,7 @@ static void __kasan_record_aux_stack(void *addr, dep=
ot_flags_t depot_flags)
>                 return;
>
>         alloc_meta->aux_stack[1] =3D alloc_meta->aux_stack[0];
> -       alloc_meta->aux_stack[0] =3D kasan_save_stack(0, depot_flags);
> -}
> -
> -void kasan_record_aux_stack(void *addr)
> -{
> -       return __kasan_record_aux_stack(addr, STACK_DEPOT_FLAG_CAN_ALLOC)=
;
> -}
> -
> -void kasan_record_aux_stack_noalloc(void *addr)
> -{
> -       return __kasan_record_aux_stack(addr, 0);
> +       alloc_meta->aux_stack[0] =3D kasan_save_stack(0, 0);
>  }
>
>  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t=
 flags)
> diff --git a/mm/slub.c b/mm/slub.c
> index 5b832512044e3..b8c4bf3fe0d07 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2300,7 +2300,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, =
bool init,
>                          * We have to do this manually because the rcu_he=
ad is
>                          * not located inside the object.
>                          */
> -                       kasan_record_aux_stack_noalloc(x);
> +                       kasan_record_aux_stack(x);
>
>                         delayed_free->object =3D x;
>                         call_rcu(&delayed_free->head, slab_free_after_rcu=
_debug);
> --
> 2.45.2
>

Otherwise,

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!


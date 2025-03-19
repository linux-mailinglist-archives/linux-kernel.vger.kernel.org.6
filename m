Return-Path: <linux-kernel+bounces-567964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B326A68C81
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B9B19C0798
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161C255E26;
	Wed, 19 Mar 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLraaBf+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82283253F31
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386321; cv=none; b=tkEhgaynAwDCiKsAq5E1vfZOk+CRRVxBzhZlqKdHN+AaWbUotwh4exKGHoF3+AxWiMlC/11YwdVFTnnQEqf3rSwKt/ipqnJ8zez0hY58kQzvXa0cSb89uIqotTZgqp5+j+Es2Lh0KFzGD/b/dknKR8wfDYr/WViEqOxQiqvxuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386321; c=relaxed/simple;
	bh=pp1axcOV5RjgGNkbD5Ivyb+f84yp0OzHkJKOeI+qjBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mthodgRIj4OvNsdiNWxr38KXjs5i+LVa54HfUfxL/6ZRrtWntXJfqy6U13NNSW3CyguDBW1jd0oePVuHZ/nvFn6zB2AoArv3OJhAKg9DjnbAuKz46GoRb+G/HSWBPufMmv9JkUvSzZxEhIhWsa4WL3tRsL1IEBjyvGIha4/BWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLraaBf+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1254415a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742386318; x=1742991118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiBGNxFAGskx4lwl7RKGcXgUBBy3lycDnpHvsa187JE=;
        b=GLraaBf+YnCyLb4J+msuOP+cTuHMRqGYrC63qdRG8GhUukytni6PmL3bOXYVia+/kp
         hI52eyZ/ebIUoo4rHklJqnXxJE7pWlrtkcxK3eGMTYGlMVcW8zr/uJtARht7atN2phAu
         E+hvN+sLWWaoFDkt2GFhN92erfCewhpuZh3PjgROhcE4MHeAnilSoAPXd7oEcKa+UnP8
         nML8mbkFomdv7Ka9V4eodnBmny7S2b8MMO6RVDYeKEdK7I1+RsqoDJE1Shg8wnBmZ0s4
         kcUoYfpO0Yl6JT0aLgV4QNv8AXdcH+dGGf46umAvUKfMoX/7xR/8h/qhQINmaZcf4Kw3
         Ke9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742386318; x=1742991118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiBGNxFAGskx4lwl7RKGcXgUBBy3lycDnpHvsa187JE=;
        b=ZlaBD/uqIS2XlwNfJuRWpF/rQKev//XRZSPQiLB320MJUhHR4HqPwPFgfCqm3bY6w4
         qud3/DwdJ4KzKL1ayvy9iGZhiRYD5jRAATeIvzvXWXVgjDO6PVRAb8pZVDaxXQQohhi5
         HgHavsYxON1ENICv+TUrQd2bUaKPGXxMwYMhfOv3OEyC+hWG0V6OQjkdwV495BicLJyu
         rt5HlXSPRUG8KdtjAI0BR9FhgUkjA8ZUGBPGvFVtkFZFSAbzJ9yrZNj9TJ8WLeo91+A9
         Yp1dTka8k/5CF447FTY4cIavRGBHBiSxss94iz9cGmd2NdqsvR5XqRwTjlp3AbnkLblQ
         FDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPDGMxPeTpeJZfH6sCY0XKirLqGyXFTnN+1Z1dKPOtiP1csjcrS8ospjM8GEiv+PumYQa4XhXpVcK1KHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPww5tRGovKfBgfkXs0Koqz7OlbNe2qiac1sM/HuU6jGZA2tTU
	PD++vA8DqblXe44FqSjOX6vOua8SWdv+UIq4dWGEYSgoi5Yl7jCKbgAjwznIJqimYmLSqIHj57f
	C59ulFswbC082a1QCMB/aKCYdFls=
X-Gm-Gg: ASbGncsBzJBd7ZWsakX2wdqC1DzI608eHWPrD6bqvV0qLQbvL9qa2PZY80AOTaCzo23
	CLAtGCdUCTTypnW+hSaUJh1D8xhM+sjNWfdrBMRypB07EmJnmkE2beG+iq60Mw8s+j7JfMDn4Ns
	wmOo3YUCTKcNZo6yq/qcXbN5amAQ==
X-Google-Smtp-Source: AGHT+IHkT2qoP+GzJL5965gAOECFSDgvjlA+pyoLbmCv4ifffAw4Mm7o39BcnhFDflZrKmaZ9BX6oRXOcsMbzMsJHTg=
X-Received: by 2002:a05:6402:4407:b0:5e5:854d:4d17 with SMTP id
 4fb4d7f45d1cf-5eb1f2463abmr6637534a12.11.1742386317509; Wed, 19 Mar 2025
 05:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314144300.32542-1-ioworker0@gmail.com> <20250314144300.32542-3-ioworker0@gmail.com>
 <20250319205510.4bbb026df166c3f6056060f1@kernel.org>
In-Reply-To: <20250319205510.4bbb026df166c3f6056060f1@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 19 Mar 2025 20:11:21 +0800
X-Gm-Features: AQ5f1Jo5UxU0GcoV2q0ymVOC57rCfTLoKQUVe1YWjcGqJT3PoGq2lmFWBmgxT08
Message-ID: <CAK1f24n2whLCWfUGBJ0rM39UssfO=dbM2qEekGdwQXDZPvQquw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/3] hung_task: show the blocker task if the
 task is hung on semaphore
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:55=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 14 Mar 2025 22:42:59 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > Inspired by mutex blocker tracking[1], this patch makes a trade-off to
> > balance the overhead and utility of the hung task detector.
> >
> > Unlike mutexes, semaphores lack explicit ownership tracking, making it
> > challenging to identify the root cause of hangs. To address this, we
> > introduce a last_holder field to the semaphore structure, which is
> > updated when a task successfully calls down() and cleared during up().
> >
> > The assumption is that if a task is blocked on a semaphore, the holders
> > must not have released it. While this does not guarantee that the last
> > holder is one of the current blockers, it likely provides a practical h=
int
> > for diagnosing semaphore-related stalls.
> >
> > With this change, the hung task detector can now show blocker task's in=
fo
> > like below:
> >
> > [Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked for more than 12=
2 seconds.
> > [Thu Mar 13 15:18:38 2025]       Tainted: G           OE      6.14.0-rc=
3+ #14
> > [Thu Mar 13 15:18:38 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout=
_secs" disables this message.
> > [Thu Mar 13 15:18:38 2025] task:cat             state:D stack:0     pid=
:1803  tgid:1803  ppid:1057   task_flags:0x400000 flags:0x00000004
> > [Thu Mar 13 15:18:38 2025] Call trace:
> > [Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
> > [Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
> > [Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
> > [Thu Mar 13 15:18:38 2025]  schedule_timeout+0x1d0/0x208
> > [Thu Mar 13 15:18:38 2025]  __down_common+0x2d4/0x6f8
> > [Thu Mar 13 15:18:38 2025]  __down+0x24/0x50
> > [Thu Mar 13 15:18:38 2025]  down+0xd0/0x140
> > [Thu Mar 13 15:18:38 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
> > [Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
> > [Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
> > [Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
> > [Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
> > [Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
> > [Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
> > [Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
> > [Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
> > [Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
> > [Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
> > [Thu Mar 13 15:18:38 2025] INFO: task cat:1803 blocked on a semaphore l=
ikely last held by task cat:1802
> > [Thu Mar 13 15:18:38 2025] task:cat             state:S stack:0     pid=
:1802  tgid:1802  ppid:1057   task_flags:0x400000 flags:0x00000004
> > [Thu Mar 13 15:18:38 2025] Call trace:
> > [Thu Mar 13 15:18:38 2025]  __switch_to+0x1ec/0x380 (T)
> > [Thu Mar 13 15:18:38 2025]  __schedule+0xc30/0x44f8
> > [Thu Mar 13 15:18:38 2025]  schedule+0xb8/0x3b0
> > [Thu Mar 13 15:18:38 2025]  schedule_timeout+0xf4/0x208
> > [Thu Mar 13 15:18:38 2025]  msleep_interruptible+0x70/0x130
> > [Thu Mar 13 15:18:38 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
> > [Thu Mar 13 15:18:38 2025]  full_proxy_read+0xfc/0x1d0
> > [Thu Mar 13 15:18:38 2025]  vfs_read+0x1a0/0x858
> > [Thu Mar 13 15:18:38 2025]  ksys_read+0x100/0x220
> > [Thu Mar 13 15:18:38 2025]  __arm64_sys_read+0x78/0xc8
> > [Thu Mar 13 15:18:38 2025]  invoke_syscall+0xd8/0x278
> > [Thu Mar 13 15:18:38 2025]  el0_svc_common.constprop.0+0xb8/0x298
> > [Thu Mar 13 15:18:38 2025]  do_el0_svc+0x4c/0x88
> > [Thu Mar 13 15:18:38 2025]  el0_svc+0x44/0x108
> > [Thu Mar 13 15:18:38 2025]  el0t_64_sync_handler+0x134/0x160
> > [Thu Mar 13 15:18:38 2025]  el0t_64_sync+0x1b8/0x1c0
> >
> > [1] https://lore.kernel.org/all/174046694331.2194069.154729520502408074=
69.stgit@mhiramat.tok.corp.google.com
> >
> > Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/semaphore.h  | 15 ++++++++++-
> >  kernel/hung_task.c         | 45 ++++++++++++++++++++++++-------
> >  kernel/locking/semaphore.c | 55 +++++++++++++++++++++++++++++++++-----
> >  3 files changed, 98 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
> > index 04655faadc2d..89706157e622 100644
> > --- a/include/linux/semaphore.h
> > +++ b/include/linux/semaphore.h
> > @@ -16,13 +16,25 @@ struct semaphore {
> >       raw_spinlock_t          lock;
> >       unsigned int            count;
> >       struct list_head        wait_list;
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     unsigned long           last_holder;
> > +#endif
> >  };
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER                          \
> > +     , .last_holder =3D 0UL
> > +#else
> > +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER
> > +#endif
> > +
> >  #define __SEMAPHORE_INITIALIZER(name, n)                             \
> >  {                                                                    \
> >       .lock           =3D __RAW_SPIN_LOCK_UNLOCKED((name).lock),       =
 \
> >       .count          =3D n,                                           =
 \
> > -     .wait_list      =3D LIST_HEAD_INIT((name).wait_list),            =
 \
> > +     .wait_list      =3D LIST_HEAD_INIT((name).wait_list)             =
 \
> > +     __LAST_HOLDER_SEMAPHORE_INITIALIZER                             \
> >  }
> >
> >  /*
> > @@ -47,5 +59,6 @@ extern int __must_check down_killable(struct semaphor=
e *sem);
> >  extern int __must_check down_trylock(struct semaphore *sem);
> >  extern int __must_check down_timeout(struct semaphore *sem, long jiffi=
es);
> >  extern void up(struct semaphore *sem);
> > +extern unsigned long sem_last_holder(struct semaphore *sem);
> >
> >  #endif /* __LINUX_SEMAPHORE_H */
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 46eb6717564d..f8cb5a0e14f7 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -102,31 +102,56 @@ static struct notifier_block panic_block =3D {
> >  static void debug_show_blocker(struct task_struct *task)
> >  {
> >       struct task_struct *g, *t;
> > -     unsigned long owner, blocker;
> > +     unsigned long owner, blocker, blocker_lock_type;
> >
> >       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> >
> >       blocker =3D READ_ONCE(task->blocker);
> > -     if (!blocker || !hung_task_blocker_is_type(blocker, BLOCKER_TYPE_=
MUTEX))
> > +     if (!blocker)
> >               return;
> >
> > -     owner =3D mutex_get_owner(
> > -             (struct mutex *)hung_task_blocker_to_lock(blocker));
> > +     if (hung_task_blocker_is_type(blocker, BLOCKER_TYPE_MUTEX)) {
> > +             owner =3D mutex_get_owner(
> > +                     (struct mutex *)hung_task_blocker_to_lock(blocker=
));
> > +             blocker_lock_type =3D BLOCKER_TYPE_MUTEX;
> > +     } else if (hung_task_blocker_is_type(blocker, BLOCKER_TYPE_SEM)) =
{
> > +             owner =3D sem_last_holder(
> > +                     (struct semaphore *)hung_task_blocker_to_lock(blo=
cker));
> > +             blocker_lock_type =3D BLOCKER_TYPE_SEM;
> > +     } else
>
> Can't we extract the type from blocker? I think we can just mask it.
> (then, we can use switch-case above)

Yep, I was thinking the same. Will adjust as you suggested ;)

Thanks,
Lance

>
> Others looks good to me.
>
> Thanks,
>
> > +             return;
> >
> >       if (unlikely(!owner)) {
> > -             pr_err("INFO: task %s:%d is blocked on a mutex, but the o=
wner is not found.\n",
> > -                     task->comm, task->pid);
> > +             switch (blocker_lock_type) {
> > +             case BLOCKER_TYPE_MUTEX:
> > +                     pr_err("INFO: task %s:%d is blocked on a mutex, b=
ut the owner is not found.\n",
> > +                            task->comm, task->pid);
> > +                     break;
> > +             case BLOCKER_TYPE_SEM:
> > +                     pr_err("INFO: task %s:%d is blocked on a semaphor=
e, but the last holder is not found.\n",
> > +                            task->comm, task->pid);
> > +                     break;
> > +             }
> >               return;
> >       }
> >
> >       /* Ensure the owner information is correct. */
> >       for_each_process_thread(g, t) {
> > -             if ((unsigned long)t =3D=3D owner) {
> > +             if ((unsigned long)t !=3D owner)
> > +                     continue;
> > +
> > +             switch (blocker_lock_type) {
> > +             case BLOCKER_TYPE_MUTEX:
> >                       pr_err("INFO: task %s:%d is blocked on a mutex li=
kely owned by task %s:%d.\n",
> > -                             task->comm, task->pid, t->comm, t->pid);
> > -                     sched_show_task(t);
> > -                     return;
> > +                            task->comm, task->pid, t->comm, t->pid);
> > +                     break;
> > +             case BLOCKER_TYPE_SEM:
> > +                     pr_err("INFO: task %s:%d blocked on a semaphore l=
ikely last held by task %s:%d\n",
> > +                            task->comm, task->pid, t->comm, t->pid);
> > +                     break;
> >               }
> > +             sched_show_task(t);
> > +             return;
> >       }
> >  }
> >  #else
> > diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> > index 34bfae72f295..87dfb93a812d 100644
> > --- a/kernel/locking/semaphore.c
> > +++ b/kernel/locking/semaphore.c
> > @@ -34,11 +34,16 @@
> >  #include <linux/ftrace.h>
> >  #include <trace/events/lock.h>
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#include <linux/hung_task.h>
> > +#endif
> > +
> >  static noinline void __down(struct semaphore *sem);
> >  static noinline int __down_interruptible(struct semaphore *sem);
> >  static noinline int __down_killable(struct semaphore *sem);
> >  static noinline int __down_timeout(struct semaphore *sem, long timeout=
);
> >  static noinline void __up(struct semaphore *sem);
> > +static inline void __sem_acquire(struct semaphore *sem);
> >
> >  /**
> >   * down - acquire the semaphore
> > @@ -58,7 +63,7 @@ void __sched down(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               __down(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -82,7 +87,7 @@ int __sched down_interruptible(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_interruptible(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -109,7 +114,7 @@ int __sched down_killable(struct semaphore *sem)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_killable(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -139,7 +144,7 @@ int __sched down_trylock(struct semaphore *sem)
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       count =3D sem->count - 1;
> >       if (likely(count >=3D 0))
> > -             sem->count =3D count;
> > +             __sem_acquire(sem);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> >
> >       return (count < 0);
> > @@ -164,7 +169,7 @@ int __sched down_timeout(struct semaphore *sem, lon=
g timeout)
> >       might_sleep();
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> >       if (likely(sem->count > 0))
> > -             sem->count--;
> > +             __sem_acquire(sem);
> >       else
> >               result =3D __down_timeout(sem, timeout);
> >       raw_spin_unlock_irqrestore(&sem->lock, flags);
> > @@ -185,6 +190,12 @@ void __sched up(struct semaphore *sem)
> >       unsigned long flags;
> >
> >       raw_spin_lock_irqsave(&sem->lock, flags);
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     if (READ_ONCE(sem->last_holder) =3D=3D (unsigned long)current)
> > +             WRITE_ONCE(sem->last_holder, 0UL);
> > +#endif
> > +
> >       if (likely(list_empty(&sem->wait_list)))
> >               sem->count++;
> >       else
> > @@ -224,8 +235,12 @@ static inline int __sched ___down_common(struct se=
maphore *sem, long state,
> >               raw_spin_unlock_irq(&sem->lock);
> >               timeout =3D schedule_timeout(timeout);
> >               raw_spin_lock_irq(&sem->lock);
> > -             if (waiter.up)
> > +             if (waiter.up) {
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +                     WRITE_ONCE(sem->last_holder, (unsigned long)curre=
nt);
> > +#endif
> >                       return 0;
> > +             }
> >       }
> >
> >   timed_out:
> > @@ -242,10 +257,18 @@ static inline int __sched __down_common(struct se=
maphore *sem, long state,
> >  {
> >       int ret;
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     hung_task_set_blocker(sem, BLOCKER_TYPE_SEM);
> > +#endif
> > +
> >       trace_contention_begin(sem, 0);
> >       ret =3D ___down_common(sem, state, timeout);
> >       trace_contention_end(sem, ret);
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     hung_task_clear_blocker();
> > +#endif
> > +
> >       return ret;
> >  }
> >
> > @@ -277,3 +300,23 @@ static noinline void __sched __up(struct semaphore=
 *sem)
> >       waiter->up =3D true;
> >       wake_up_process(waiter->task);
> >  }
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +unsigned long sem_last_holder(struct semaphore *sem)
> > +{
> > +     return READ_ONCE(sem->last_holder);
> > +}
> > +#else
> > +unsigned long sem_last_holder(struct semaphore *sem)
> > +{
> > +     return 0UL;
> > +}
> > +#endif
> > +
> > +static inline void __sem_acquire(struct semaphore *sem)
> > +{
> > +     sem->count--;
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +     WRITE_ONCE(sem->last_holder, (unsigned long)current);
> > +#endif
> > +}
> > --
> > 2.45.2
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


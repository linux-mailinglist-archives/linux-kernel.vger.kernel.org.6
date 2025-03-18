Return-Path: <linux-kernel+bounces-566078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D41A672D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600AC189E98F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4620B210;
	Tue, 18 Mar 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bszd/Xx9"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562720B7E6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297773; cv=none; b=nhy1Ba1F+43mw0ZC3f1v3DbQKq2E8x/9USgAJm2DtRpEZFDZJ16sTG92TFhWKBk+snHT2tmqP0PLQzVZszh7OUD79Kr6UfjF4TRGHvfObzFtlSGFYFqRO4OUy+9lcCP301cxUVVCuGw9npem+U2jezUvj9qiIVTYQFstr0kR0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297773; c=relaxed/simple;
	bh=MooOZBjnKa3eOXJRAkG1TbbXmGn7z1BSAcJjhp0XE6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WedRxMHcKnCWDSJEbKHDy3+ySRSTMWgrShecFyYaobw3QxjgROGe8/EULXyI6JC8GeQDcNo4EnxF5UDanfnlaOd/kEZNVADXBPN0rRhQ+/ReBZ7J4sEe+21gQzfii3MnYHG6uUOwTb3ABoYr6CfPm7me0NEiZh6RYhVXuOPi2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bszd/Xx9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso998396a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297769; x=1742902569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThlJbEalfK2xtbJtUuT/lT5PVoKxTwbse0vzB0NBORs=;
        b=bszd/Xx9ZaVjqEAqkoUrTZqCGej+PY1HPbDTx5gY2gRfCm1G7vdnS9iTyf5XiO1V/z
         2qh7blI+HV4qdc4f5Yn//aT/yOUw2mgQA0XPcGbOJQ1tNWiklLjvVKGcN8NmWqlOiThP
         w3b6ZM66xA9az0Yd4mHxpI/BJEBFV1r7oOdU/LRPWGGwW3cwFOSV4NQB6MrkzhD5fD1Q
         dOVAFEWADQBqRE6mhea1alBKwi5ehIYhD5s8VH9pg14bOSN9Y11IWUCy2ZpKiuk0jEi/
         xJVNt3MZtehTPQ1M7+6dHGj2ah0Qx+AeBtxLj28eI2rT4NFeU2I26vZGA3l1zjiiC/15
         nsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297769; x=1742902569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThlJbEalfK2xtbJtUuT/lT5PVoKxTwbse0vzB0NBORs=;
        b=XQQVb7eD0oId7jqq8p8T/e5Ygh1Hq8KcKl9XY+dWzvYOE5cUtcVpfp73CqNTuV3XOL
         X7nr2fa8wnOCa3W7Z+LyxzCcE2Fc+uqRyJyPWGXn6nLqvc311dQq0KZBCzXssroDdS33
         mAcgkQKERw4AQOmrJPmFZHpiL1NR6wORNuIY5qWUZylpsi9ssOzZgbmaLoyOnRx8ZaeE
         s8y0Dyj4wSx2KV4pOwl9Cx3ipvDti8/3Q6DmIq9MwnseM/0CWOIekP5VS2l1hyVHgoR2
         3lgu/u7Q4dMJT1SGkUgYCh8d7Srgd46n8i2vCi80W2Av3XWJnnmBfNBRvtHDkgQ6EX7s
         cYCg==
X-Forwarded-Encrypted: i=1; AJvYcCVC43pfVGGUT3MnzWz8+WCn/71qqcyX3QrcmWYXPkc3owxlixsQ5kqx36zDKgFoynb78eAqw/pbpQ3lBQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO4pWuJzz/x89u9EkGv3rLUxgFEkfSvzBlhEXXfSg79VytpuUg
	dgOjbb0iQhGesWqb2zOUEEHCc7R5Q17G4I4puoEL5vy7rqPeWl6HqJFKSFJ47t184JyQ/E0mgyq
	Mcu/GHmAqb9h/C3fqtqphU3ts0Fk=
X-Gm-Gg: ASbGnctcDURw/ODibFmu2oAJ3Lu+EOYDmLeNMsjIVy62cDZwHy9XEos4vROwTzxZVDK
	lTUbqYFBJccKzSSLRGsnG3KDwG5zf8fOu/C04QZSK39xAMCYgOw4AbYeEd22bQ3YDdRlJkvD+Gw
	BuKsY+ASa9zHGthoLjLx0wfhkR0R2stTWRLNXK9QQ=
X-Google-Smtp-Source: AGHT+IGSeFj/f/d85J+o4uPGPgxXJdKvNNRpMArXOFVpwl1HxboJ8oRGWf1HN2ucAV+UE9W3Drgxeq5I09xGDtzIOis=
X-Received: by 2002:a05:6402:3550:b0:5e5:dea5:3eb0 with SMTP id
 4fb4d7f45d1cf-5e89e6afcf8mr16072700a12.7.1742297768996; Tue, 18 Mar 2025
 04:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314144300.32542-1-ioworker0@gmail.com> <20250314144300.32542-2-ioworker0@gmail.com>
 <20250318184158.e6c1b2d28e2fee311bcd2c30@kernel.org>
In-Reply-To: <20250318184158.e6c1b2d28e2fee311bcd2c30@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 18 Mar 2025 19:35:32 +0800
X-Gm-Features: AQ5f1JpN94WMX5lx9VRssOBEsnKGWsKjE6hfOamcFJV-Rgi06l7tdTJPWesqZBQ
Message-ID: <CAK1f24k7hRD5SZD92tv+DgSakhA8vRjtLibGTymd9AsHizTBAg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] hung_task: replace blocker_mutex with
 encoded blocker
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, amaindex@outlook.com, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:42=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 14 Mar 2025 22:42:58 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > This patch replaces 'struct mutex *blocker_mutex' with 'unsigned long
> > blocker', as only one blocker is active at a time.
> >
> > The blocker filed can store both the lock addrees and the lock type, wi=
th
> > LSB used to encode the type as Masami suggested, making it easier to ex=
tend
> > the feature to cover other types of locks.
> >
> > Also, once the lock type is determined, we can directly extract the add=
ress
> > and cast it to a lock pointer ;)
>
> Hi Lance,
>
> Thanks for update. I added some comments.

Thanks for taking time to review!

>
> >
> > Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/hung_task.h | 94 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/sched.h     |  2 +-
> >  kernel/hung_task.c        | 15 ++++---
> >  kernel/locking/mutex.c    |  8 +++-
> >  4 files changed, 111 insertions(+), 8 deletions(-)
> >  create mode 100644 include/linux/hung_task.h
> >
> > diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> > new file mode 100644
> > index 000000000000..64ced33b0d1f
> > --- /dev/null
> > +++ b/include/linux/hung_task.h
> > @@ -0,0 +1,94 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Detect Hung Task: detecting tasks stuck in D state
> > + *
> > + * Copyright (C) 2025 Tongcheng Travel (www.ly.com)
> > + * Author: Lance Yang <mingzhe.yang@ly.com>
> > + */
> > +#ifndef __LINUX_HUNG_TASK_H
> > +#define __LINUX_HUNG_TASK_H
> > +
> > +#include <linux/bug.h>
> > +#include <linux/sched.h>
> > +#include <linux/compiler.h>
> > +
> > +/*
> > + * @blocker: Combines lock address and blocking type.
> > + *
> > + * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
> > + * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
> > + * always zero. So we can use these bits to encode the specific blocki=
ng
> > + * type.
> > + *
> > + * Type encoding:
> > + * 00 - Blocked on mutex        (BLOCKER_TYPE_MUTEX)
> > + * 01 - Blocked on semaphore    (BLOCKER_TYPE_SEM)
> > + * 10 - Blocked on rt-mutex     (BLOCKER_TYPE_RTMUTEX)
> > + * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
> > + */
> > +#define BLOCKER_TYPE_MUTEX      0x00UL
> > +#define BLOCKER_TYPE_SEM        0x01UL
> > +#define BLOCKER_TYPE_RTMUTEX    0x02UL
> > +#define BLOCKER_TYPE_RWSEM      0x03UL
> > +
> > +#define BLOCKER_TYPE_MASK       0x03UL
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +static inline void hung_task_set_blocker(void *lock, unsigned long typ=
e)
> > +{
> > +     unsigned long lock_ptr =3D (unsigned long)lock;
> > +
> > +     WARN_ON_ONCE(!lock_ptr);
> > +     WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK);
> > +     WARN_ON_ONCE(READ_ONCE(current->blocker));
>
> The last one needs a comment why it is problem.
>
> WARN_ON_ONCE(READ_ONCE(current->blocker),
>         "Task blocker is not cleared. Maybe forgot to clear it somewhere?=
 Type: %d\n",
>         current->blocker);
>
> But I don't think this isn't needed to be checked usually.

Hmm... Looking back, adding it was probably overkill. So let's drop it in
the next version ;)

>
> > +
> > +     /*
> > +      * If the lock pointer matches the BLOCKER_TYPE_MASK, return
> > +      * without writing anything.
> > +      */
> > +     if (lock_ptr & BLOCKER_TYPE_MASK)
> > +             return;
>
> You can use WARN_ON_ONCE for 'if' condition.
>
>   if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
>         return;

Ah, I didn't realize we could do it that way before. That's nice to know!

>
> > +
> > +     WRITE_ONCE(current->blocker, lock_ptr | type);
> > +}
> > +
> > +static inline void hung_task_clear_blocker(void)
> > +{
> > +     WARN_ON_ONCE(!READ_ONCE(current->blocker));
> > +
> > +     WRITE_ONCE(current->blocker, 0UL);
> > +}
> > +
> > +static inline bool hung_task_blocker_is_type(unsigned long blocker,
> > +                                       unsigned long type)
> > +{
> > +     WARN_ON_ONCE(!blocker);
> > +
> > +     return (blocker & BLOCKER_TYPE_MASK) =3D=3D type;
> > +}
> > +
> > +static inline void *hung_task_blocker_to_lock(unsigned long blocker)
> > +{
> > +     WARN_ON_ONCE(!blocker);
> > +
> > +     return (void *)(blocker & ~BLOCKER_TYPE_MASK);
> > +}
> > +#else
> > +static inline void hung_task_set_blocker(void *lock, unsigned long typ=
e)
> > +{
> > +}
> > +static inline void hung_task_clear_blocker(void)
> > +{
> > +}
> > +static inline bool hung_task_blocker_is_type(unsigned long blocker,
> > +                                          unsigned long type)
> > +{
> > +     return false;
> > +}
> > +static inline void *hung_task_blocker_to_lock(unsigned long blocker)
> > +{
> > +     return NULL;
> > +}
> > +#endif
> > +
> > +#endif /* __LINUX_HUNG_TASK_H */
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 1419d94c8e87..f27060dac499 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1218,7 +1218,7 @@ struct task_struct {
> >  #endif
> >
> >  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > -     struct mutex                    *blocker_mutex;
> > +     unsigned long                   blocker;
> >  #endif
> >
> >  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index dc898ec93463..46eb6717564d 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -25,6 +25,10 @@
> >
> >  #include <trace/events/sched.h>
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#include <linux/hung_task.h>
> > +#endif
>
> We don't need this #ifdef, since it is already checked in the
> header file.

Good catch! I completely missed it ;(

>
> > +
> >  /*
> >   * The number of tasks checked:
> >   */
> > @@ -98,16 +102,17 @@ static struct notifier_block panic_block =3D {
> >  static void debug_show_blocker(struct task_struct *task)
> >  {
> >       struct task_struct *g, *t;
> > -     unsigned long owner;
> > -     struct mutex *lock;
> > +     unsigned long owner, blocker;
> >
> >       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> >
> > -     lock =3D READ_ONCE(task->blocker_mutex);
> > -     if (!lock)
> > +     blocker =3D READ_ONCE(task->blocker);
> > +     if (!blocker || !hung_task_blocker_is_type(blocker, BLOCKER_TYPE_=
MUTEX))
> >               return;
> >
> > -     owner =3D mutex_get_owner(lock);
> > +     owner =3D mutex_get_owner(
> > +             (struct mutex *)hung_task_blocker_to_lock(blocker));
> > +
> >       if (unlikely(!owner)) {
> >               pr_err("INFO: task %s:%d is blocked on a mutex, but the o=
wner is not found.\n",
> >                       task->comm, task->pid);
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index 6a543c204a14..642d6398e0dd 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -42,6 +42,10 @@
> >  # define MUTEX_WARN_ON(cond)
> >  #endif
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#include <linux/hung_task.h>
> > +#endif
>
> Ditto.

Yes, you're right. Will remove that as you suggested.

Thanks,
Lance

>
> > +
> >  void
> >  __mutex_init(struct mutex *lock, const char *name, struct lock_class_k=
ey *key)
> >  {
> > @@ -189,7 +193,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex=
_waiter *waiter,
> >                  struct list_head *list)
> >  {
> >  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > -     WRITE_ONCE(current->blocker_mutex, lock);
> > +     hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
> >  #endif
> >       debug_mutex_add_waiter(lock, waiter, current);
> >
> > @@ -207,7 +211,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mu=
tex_waiter *waiter)
> >
> >       debug_mutex_remove_waiter(lock, waiter, current);
> >  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > -     WRITE_ONCE(current->blocker_mutex, NULL);
> > +     hung_task_clear_blocker();
> >  #endif
> >  }
> >
> > --
> > 2.45.2
> >
>
> Thank you,
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


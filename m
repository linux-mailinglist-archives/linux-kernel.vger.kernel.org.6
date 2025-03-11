Return-Path: <linux-kernel+bounces-555469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAC3A5B811
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A67A8249
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA11EA7FF;
	Tue, 11 Mar 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1Aj7MWO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69811E832E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668553; cv=none; b=O/tmIk2S0Z3jhOGL7gMSmvLfCihGbAhxA9xPSjG5BfuDl16aqSmhliBTV0AwyuinSx/GtMA+PNx+heBNlzIY/zpO1VYgQxkMQY+TEANCZm7cSO5cG/fAG5apkFZ2nFwhcyVgWhlkQQ9vsPiuaGrZtQzoWcrxKKNN9j6WYyPc7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668553; c=relaxed/simple;
	bh=s0v1P0TiwyQ4a9mBQrhOvjlaWFHvW4dtqcMHQ4P5yzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyDvcrXCQG47PLSbTAjSWpzg9ZwOKKqVUoAQdDPBmo47dLSjEElSMVdxr/g3h4AAYsc+/glnx/X6L78h7XC7x66ib+WsrKm3c74pWhN/i/u57bA1TrySQCnED8399qgFPS7yyjc5icN3VD8w9WvWM+kZs3j3EQlitHMhHHQgxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1Aj7MWO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2963dc379so254967566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741668550; x=1742273350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HYHOB8qg05oAVQquFKjSNoVM7DIyW4HJG69Awc4kYI=;
        b=P1Aj7MWOofcnfRI6yrbNDsbUF6FmvsqPQ/LtXog14vl68BRRT3bm4JiZDwWQB4+8dd
         dWclM7AhIV5Ojmyni/zu/hxEsklIBN0ppqlP2JgbLB+H0vMHu4SxCVS58sabPcLq8Yrz
         muQVnP62mNVd4QJBBahH8BBzvvWGoC0R1vSnpKVnVV1feLyy4W1NT+3yAmvvvtwhajz7
         xpPSDYViNfgoMpU+BOXmA35Ki92SpzqGf1uIgm5OeKn/P7KR081uSyTYwmoy4ocj04IL
         OyBKnVZFiuo0Zf0voISIgnaXDvzcJgZKEqi7/ld6onTXJbL56GXTuEg8uxa+LulSy9Vg
         ib1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741668550; x=1742273350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HYHOB8qg05oAVQquFKjSNoVM7DIyW4HJG69Awc4kYI=;
        b=O/uF47DZRUnAQvAdtviSCgKu350bvIW4Uj9bcuIywnoU7vt0jWHjJ0u14piTpKxGp3
         /pKcqsyAyCKilWPIEhuUvWkFeLtnCkz9q9y/1DEynp1nEDFrDqsOpEUMvkR8YYOnEI7D
         P/hsqNAQN1sKdfOmDdsw/pPieZlPOQuYu0QkMIc6xmGpxynoTrOM7avXmYaD62p05xgK
         y9UPoI0H/csNxkb1N+c0T/p4Usy+YNvRK9Nqqp6aJ/zDEMOEE4iyTfKASROA38QBt2P7
         GNlkgr3kBG/W5Yioxaaq9nSNcDJy0RGgmr9ZnedgSw7xk+fTaINUMkKyD4c4mKT+gIAa
         zKYw==
X-Forwarded-Encrypted: i=1; AJvYcCWaIMAfpDYFXwja//duF0FDHR5tDn979Wnt2ZkLz3jiPT8KSfxP7sKS2NQa44mcOIFh4fGr7npHHoIzfKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojDZUCxQ+IO1wx5qBAaxnkb8HvIKVqSW17MJoNdHpmh5OF/tG
	It38NAaxshYKp2WBlVhak011x4q+jES5bq3gCIQiZ4VuGccm8PKK1V+b86Skcy5spuWwTSN9w/w
	bb/HnaKzOkGRqg3ZGYxdqwcPiexuKW5TG
X-Gm-Gg: ASbGncuXL/UVJhxOulPHhrFsxUlSsbb8AVD4iw6EC+j4st+viFON7nF8DKNb4mzqEPv
	U25QtZ5QU28YBJb1t/kor2/l2k82gEfiLFhb2Zt40uwQlPN6GjILnPMJ2fQuBtfJYlayuWmtVNK
	nXCB7woXhBY9VkI2hbrOeaNV1jtw==
X-Google-Smtp-Source: AGHT+IE7M1G2WvKEjRgVXR6Ol54KzOHvnZPF8jlGvK8NSYwYctQLLznHnLzo0eaX934KSTm/yHof2gb4eUGyVmzcu6k=
X-Received: by 2002:a05:6402:430b:b0:5df:25e8:26d2 with SMTP id
 4fb4d7f45d1cf-5e5e22a79ccmr38461729a12.5.1741668549658; Mon, 10 Mar 2025
 21:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
 <20250306060542.56435-1-ioworker0@gmail.com> <20250311131958.9cc1318bc62ac46d177e024c@kernel.org>
In-Reply-To: <20250311131958.9cc1318bc62ac46d177e024c@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 11 Mar 2025 12:48:33 +0800
X-Gm-Features: AQ5f1Jr98DUcciNWDLV5foS_Y7fn9Sz7dpDLBoyxQr1iikPqmRlAd_6Y1JuU_ss
Message-ID: <CAK1f24kbb5w76CeFVDJGN79OYuJry-irxp04Jxf=opKQZA3shQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hung_task: show the blocker task if the task is hung
 on semaphore
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: akpm@linux-foundation.org, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
	joel.granados@kernel.org, kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com, 
	mingzhe.yang@ly.com, peterz@infradead.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:20=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Thu,  6 Mar 2025 14:05:42 +0800
> Lance Yang <ioworker0@gmail.com> wrote:
>
> > Hi Masami,
> >
> > Could you give me a quick feedback before sending out the v2?
> >
> > It seems unnecessary to make 'blocker' a union. I replaced 'struct mute=
x
> > *blocker_mutex' with 'unsigned long blocker', as only one blocker is ac=
tive
> > at a time, IIUC ;)
> >
> > The blocker filed can store both the lock addrees and the lock type, wi=
th
> > LSB used to encode the type as you suggested, making it easier to exten=
d
> > the feature to cover other types of locks.
> >
> > Also, once the lock type is determined, we can directly extract the add=
ress
> > and cast it to a lock pointer ;)
>
> Hi Lance,
>
> Sorry I missed to reply.

No worries at all ;p

>
> >
> > ---
> >  include/linux/hung_task.h | 82 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/sched.h     |  2 +-
> >  kernel/hung_task.c        | 15 ++++---
> >  kernel/locking/mutex.c    |  8 +++-
> >  4 files changed, 99 insertions(+), 8 deletions(-)
> >  create mode 100644 include/linux/hung_task.h
> >
> > diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> > new file mode 100644
> > index 000000000000..569d2e579f36
> > --- /dev/null
> > +++ b/include/linux/hung_task.h
> > @@ -0,0 +1,82 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Detect Hung Task: detecting tasks stuck in D state
> > + *
> > + * Copyright 2025 Lance Yang <ioworker0@gmail.com>
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
> > + * 10 - Blocked on rw-mutex     (BLOCKER_TYPE_RWMUTEX)
>
>                       ^ RT-Mutex?

Good catch! It's a typo, sorry ;(

>
> > + * 11 - Blocked on rw-semaphore (BLOCKER_TYPE_RWSEM)
> > + */
> > +#define BLOCKER_TYPE_MUTEX      0x00UL
> > +#define BLOCKER_TYPE_SEM        0x01UL
> > +#define BLOCKER_TYPE_RWMUTEX    0x02UL
>
> Ditto.

Yes. It should have been called BLOCKER_TYPE_RTMUTEX ;)

>
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
>
> If it founds the lock_ptr & BLOCKER_TYPE_MASK is set, it should return
> without writing anything. (WARN_ON_ONCE() is OK)

Yeah, it makes sense to me. Will adjust as you suggested.

>
> > +     WARN_ON_ONCE(READ_ONCE(current->blocker));
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
> > +#define hung_task_set_blocker(lock, type)       do {} while (0)
> > +#define hung_task_clear_blocker()               do {} while (0)
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
> > index ccd7217fcec1..f7fa832261c8 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -25,6 +25,10 @@
> >
> >  #include <trace/events/sched.h>
> >
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +#include <linux/hung_task.h>
> > +#endif
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
>
> Yeah, others look good to me.

Thanks a lot for taking time to review!
Lance

>
> Thank you!
>
>
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
> >
> > Thanks,
> > Lance
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-kernel+bounces-339527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF998666C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2F1C23698
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1B13BAC3;
	Wed, 25 Sep 2024 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUuYfd4j"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6074C1B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289524; cv=none; b=M3+2HEiFOqewiJEWcpJ+5oaC+VkkLuwi/UzvD8Xr16HFQiqkqj63vHSRq8xYlBHoJPck9M9qCW/5RI0fWNN5Fh/9tFvldDTJ0bc+OhXHAeLR+rrO1/ljm9LPogaUC7AaHesx6AB6gwhpCaGVKJPHco+3FexOlIyMDlD0DwWS69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289524; c=relaxed/simple;
	bh=JVKFkjhydaMKPc1PC4D+X35Li+Gx1GS1qnGbfKgICMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRXUPro/hcRR6eVbv8ILUR5r2R8jzN/d0Zj2Yc6UVA8/1K6DaYJv22TyaV8VdXx02v2vV14zQ1Uk7MOCprg/DFQkHEJBU0lIJkgqT3Te5vrphIv/rOEdZUB8voWy9z0jTVT43fzznMYAdskEiJtS8ZNwCK1puQk5x2ROWK3+mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUuYfd4j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-207349fa3d7so27265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727289522; x=1727894322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAwUsCBYvsBvH+rTIy3VTYfawJRtH/z/DBLYTwRvoDQ=;
        b=JUuYfd4jouTYaTk8H61tI7YWNjcw6/0+ziwCnPDbXHFSx505nAJ0ZnBmfPeqLhKY3E
         r1Zj3477byu1zCjpWXsRyFtROoBOAkh1x6/PbkjZGIVPH4+fOZr91bfTb/OQhV4IzykJ
         LKyY2I+NJw3EMBSWppUYMyY9Qfcx72lt7gtu12a8NPRgUULqvqgRB5xHhfhpCJezqeY+
         kUNTouElAYzsy4Y+DQj04aVnX1sReVmuVqRViI4GE7o4WJziQN4P43petuHkwu9VNiku
         PVqdk9y7mKYccUVNPQe65u4F6OrlIhdG28Nambb4kNYtLnmHO81JIKDgRI0hhM4hkYKJ
         Dn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727289522; x=1727894322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAwUsCBYvsBvH+rTIy3VTYfawJRtH/z/DBLYTwRvoDQ=;
        b=pwhqRU8oCRRaT9WfTjmsUjQbU0tau3hcJf29058jnjYINWs8e0Xq/DN9WISbs1lxdp
         i/pZV4Msxk6G0303hzvV/0XPnipujK0/g8oaXXbu84k1HdkQKHI01u3cbBDsuobKG1/Y
         D9GgljtGl5KwvZLRgsi0O65fAj4a/QTs5VdXMUK3kBf3HFZSOwXMqVjWFD1+IO/vvcj2
         HBgTeuFC4NPe5oIztmzxd4iKu2rPBO08qD3lCjIyXmQ9k06RpoqOWN151P3TGkdMKOZ+
         xnacsb9IKqgfKblNe+wZKDkZ7xqEErwugZrfyWBufacAkUawy2sh5MWT5iUfcmpPcRkD
         7RQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZhCv7hoWH02Gq+uovpgJWgGd6q6cdX/WBL/Qn1e4a3PZpNV3zNi9lP9jvhnFKuWTQqp+jcRpcZ62FfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWZGLA8Fa0DtuqrPp5/ijxdTidzHqWM9KdInBEwX1i1er99qN
	yWQSjrrZO0xcsU+vUEsAwwM2AjWiDZmGdQdXLd9k9lvQKQTSDUpHEtA7vXKpVWmt2nrJE6E8If9
	iEXsrbDG8GXVWqXzz+rPh0kz0g2CnroBHgdHH
X-Google-Smtp-Source: AGHT+IEcXCpXotrQE81fnFVdze99a4YZ0Ycn4Rt6hsoKJd9DK86/HBv/Sjnn9Ah1hFKZoWzawUrE9yU6tudDQWMYb1c=
X-Received: by 2002:a17:902:e743:b0:207:14a8:734e with SMTP id
 d9443c01a7336-20b1b35c79cmr326965ad.6.1727289521611; Wed, 25 Sep 2024
 11:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner> <20240919123635.2472105-1-bgeffon@google.com>
In-Reply-To: <20240919123635.2472105-1-bgeffon@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 25 Sep 2024 14:38:02 -0400
Message-ID: <CADyq12w2KRUZCu0hLA8TJH-e+766Jq_vG9SDYtDBYXzR=r9wvg@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: brauner@kernel.org
Cc: bristot@redhat.com, bsegall@google.com, cmllamas@google.com, 
	dietmar.eggemann@arm.com, ebiggers@kernel.org, jack@suse.cz, 
	jing.xia@unisoc.com, juri.lelli@redhat.com, ke.wang@unisoc.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	xuewen.yan94@gmail.com, xuewen.yan@unisoc.com, Benoit Lize <lizeb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this patch really needs help with the commit message, something lik=
e:

wait_queue_func_t accepts 4 arguments (struct wait_queue_entry
*wq_entry, unsigned mode, int flags, void *key);

In the case of poll and select the wait queue function is pollwake in
fs/select.c, this wake function passes
the third argument flags as the sync parameter to the
default_wake_function defined in kernel/sched/core.c. This
argument is passed along to try_to_wake_up which continues to pass
down the wake flags to select_task_rq and finally
in the case of CFS select_task_rq_fair. In select_task_rq_fair the
sync flag is passed down to the wake_affine_* functions
in kernel/sched/fair.c which accept and honor the sync flag.

Epoll however when reciving the WF_SYNC flag completely drops it on
the floor, the wakeup function used
by epoll is defined in fs/eventpoll.c, ep_poll_callback. This callback
receives a sync flag just like pollwake;
however, it never does anything with it. Ultimately it wakes up the
waiting task directly using wake_up.

This shows that there seems to be a divergence between poll/select and
epoll regarding honoring sync wakeups.

I have tested this patch through self tests and numerous runs of the
perf benchmarks for epoll. All tests past and
I did not see any observable performance changes in epoll_wait.

Reviewed-by: Brian Geffon <bgeffon@google.com>
Tested-by: Brian Geffon <bgeffon@google.com>
Reported-by: Benoit Lize <lizeb@google.com>


On Thu, Sep 19, 2024 at 8:36=E2=80=AFAM Brian Geffon <bgeffon@google.com> w=
rote:
>
> We've also observed this issue on ChromeOS, it seems like it might long-s=
tanding epoll bug as it diverges from the behavior of poll. Any chance a ma=
intainer can take a look?
>
> Thanks
> Brian
>
> On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> > Now, the epoll only use wake_up() interface to wake up task.
> > However, sometimes, there are epoll users which want to use
> > the synchronous wakeup flag to hint the scheduler, such as
> > Android binder driver.
> > So add a wake_up_sync() define, and use the wake_up_sync()
> > when the sync is true in ep_poll_callback().
> >
> > Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> > Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  fs/eventpoll.c       | 5 ++++-
> >  include/linux/wait.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 882b89edc52a..9b815e0a1ac5 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *=
wait, unsigned mode, int sync, v
> >                               break;
> >                       }
> >               }
> > -             wake_up(&ep->wq);
> > +             if (sync)
> > +                     wake_up_sync(&ep->wq);
> > +             else
> > +                     wake_up(&ep->wq);
> >       }
> >       if (waitqueue_active(&ep->poll_wait))
> >               pwake++;
> > diff --git a/include/linux/wait.h b/include/linux/wait.h
> > index 8aa3372f21a0..2b322a9b88a2 100644
> > --- a/include/linux/wait.h
> > +++ b/include/linux/wait.h
> > @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_=
head);
> >  #define wake_up_all(x)                       __wake_up(x, TASK_NORMAL,=
 0, NULL)
> >  #define wake_up_locked(x)            __wake_up_locked((x), TASK_NORMAL=
, 1)
> >  #define wake_up_all_locked(x)                __wake_up_locked((x), TAS=
K_NORMAL, 0)
> > +#define wake_up_sync(x)                      __wake_up_sync(x, TASK_NO=
RMAL)
> >
> >  #define wake_up_interruptible(x)     __wake_up(x, TASK_INTERRUPTIBLE, =
1, NULL)
> >  #define wake_up_interruptible_nr(x, nr)      __wake_up(x, TASK_INTERRU=
PTIBLE, nr, NULL)
> > --
> > 2.25.1
> >
>


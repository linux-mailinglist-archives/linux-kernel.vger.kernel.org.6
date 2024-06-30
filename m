Return-Path: <linux-kernel+bounces-235302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E780E91D35A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4BB1F21093
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F11534E6;
	Sun, 30 Jun 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSNTE2HG"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB23987D
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719774746; cv=none; b=S11GSR7C0bDkaBCi/e0Mw1h96Wqhh5IyEqivWlKivuL9k09V8Ai6UiTGqTDVLdXNFNEdOO8BNCGMPdDiW0tI1YtuD5ZGhONXHpMDpOIBgYaxE5nLBcGGx3ruKer5tOVsuC8sPLT3z8aWCvbFXBnGNqz0kY81+YfOACKWzuCabX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719774746; c=relaxed/simple;
	bh=u2TYbH1ptRkB3LN5tQW7yxYEKq/B0XzaXEhQyUUEcAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZSoTm/7YDaj6jyeBY897a2X+OG9Jy8H/VOU8pvfPOPmRGUntMvfO6UnCZVfwNxGnmBe2Do0HZx6E2Hif/wQHCx4flp/hXeG3qAWPkXIgLg56zsTm6pl05uo1cTsVunsWBKATidnWLiC+2442kGne0c0lc9ryxlG8V5sNo4WU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSNTE2HG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-632597a42b8so25757657b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719774744; x=1720379544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jylT6Sa1uxFUyN3G0fBlShYEajYiRSkfKgA5nj6lkZQ=;
        b=FSNTE2HGtec1LfnRnwhTzXk9n55qG1S1rmxUC34nCcRQYaNtuDuXsrrcTsOyb1A6Q+
         l8H77h68j5nJfETMyDuMGg7ng/VxqPnU8X+igsbKk3+Rfeogy4MOM9VcT6hKrSeyira6
         W9oWNErwlb6PXmauVliweyleNhNTfqQ4EIYH89IWO6MEGnE7KBZpSrYGSACzAaE1A03m
         ogJLw+31L1dyAZ6+IEIGjmlJO2kjMC8Ldx43IC2TWqSOz5VLFhYDfKyj5nWDMdXIhCGW
         W6LHTzC7tVkjMv56+MqKvvfTcspIr4gxbvpDyUHw9HKMfdDTVeeuX/Kxxinn8ACnciBK
         b0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719774744; x=1720379544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jylT6Sa1uxFUyN3G0fBlShYEajYiRSkfKgA5nj6lkZQ=;
        b=E97PFjLwb/Z2jgNLMuOH+HO0FEp3pg6CS5FCjgpNkSzE1OaqxACVFqcJIyqjK7AV8J
         chmK/g8Tj2NunE/FpsLhh8mr13PUm01U3/xAKqsLCcA2EA/+hVmdnRL8yYNIssm8v9yy
         1u6jR0MKo3x2IMWN4Y7f7vAz/ec5GZh+LuoqqqlZCGbezJL6Hi+O1CsTlIbQVENm1YZI
         OF4z32nJTQa/4AHwLSTaj4R45vVZ08Zj6Uqc8qAKFIrMmy4nBBXPH+QRZkMrgWBIYsET
         SLEILEGIvV3NwwhVhGUA2nYHDtTQDoxrrsdOSy6Jjr+YapQXeZHKn9BsuX7F8BqNXW7h
         6Phg==
X-Forwarded-Encrypted: i=1; AJvYcCUJoeFhRv0NE/2RNYvAtNttJZKVY/khqf5xvlw1xvUD7esXFVKGzCNdMKPNoZgMoZ6nT+KFRS2xaSRg0Wo7KM43ZPNFtxLZlFZNv6Jd
X-Gm-Message-State: AOJu0Ywrga+iw4D5HZR9VHZ+86nuWEzW3cn5g0XXVY3JuxYkgDpYTiOh
	PUxpHZebnmAVWlPyyQMOCxI8D95xGErriHfKb0N7MFBzwN2+dc86p3TiUzTNs7ym+BJrnDI7mc2
	PX2/++zJtPuks9le8V5UKy4AflKGJkfiTqAG8
X-Google-Smtp-Source: AGHT+IHg060oQtahij/9W2euMF8akvsTumeTk9xJutwMFxbDqH6osbmJmdaZMtLrT1A+NTGwA7o3NE+7gjNZr/C54EQ=
X-Received: by 2002:a05:690c:314:b0:618:2381:2404 with SMTP id
 00721157ae682-64c7331e13emr57939747b3.44.1719774743936; Sun, 30 Jun 2024
 12:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628173247.3507846-1-surenb@google.com> <20240629131247.GA6138@redhat.com>
In-Reply-To: <20240629131247.GA6138@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 30 Jun 2024 12:12:10 -0700
Message-ID: <CAJuCfpGh9EBqij+Ru_D4ieEHTVx7_a0N8odaOLCPYt3g0iVCQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] signal: on exit skip waiting for an ack from the
 tracer if it is frozen
To: Oleg Nesterov <oleg@redhat.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, brauner@kernel.org, 
	tandersen@netflix.com, bigeasy@linutronix.de, vincent.whitchurch@axis.com, 
	ardb@kernel.org, linux-kernel@vger.kernel.org, 
	Martin Liu <liumartin@google.com>, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 6:14=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> Oh, PTRACE_EVENT_EXIT again. I can't even recall how many times
> I mentioned it is broken by design but any possible change is user
> visible...
>
> But I don't really understand this patch.
>
> On 06/28, Suren Baghdasaryan wrote:
> >
> > When a process is being killed or exiting and it has a tracer, it will
> > notify the tracer and wait for an ack from the tracer to proceed. Howev=
er
> > if the tracer is frozen, this ack will not arrive until the tracer gets
> > thawed. This poses a problem especially during memory pressure because
> > resources of the process are not released.
>
> Yes. But how does this differ from situation when the tracer is not
> frozen but just sleeps?

Appreciate the feedback, Oleg!
If the sleep is limited, I guess it's not that bad. With frozen
tracer, the tracee becomes unkillable potentially forever.

> Or it is traced too and its tracer is frozen?

Good question. I'm not an expert in ptracing, so TBH I don't know what
will happen. Will the tracer wake up, acknowledge the tracee and then
try to notify its frozen tracer or will the whole chain stall because
the ultimate parent is frozen?

>
> > Things become even more interesting if OOM killer picks such tracee
> > and adds it into oom_victims. oom_victims counter will get incremented
> > and stay that way until tracee exits. In the meantime, if the system
> > tries to go into suspend, it will call oom_killer_disable() after
> > freezing all processes.
>
> Confused... suspend doesn't use cgroup_freeze/etc, so it seems your
> patch should check frozen() rather than cgroup_task_frozen() ?

Ah, good point. In my particular case the tracer is frozen due to its
cgroup being frozen but frozen() would cover a more general case.

> And what if try_to_freeze_tasks() does freeze_task(tracee->parent)
> right after the check in ptrace_stop() below?

Uh, yeah. At this point we already sent the notification to the
tracer. Maybe we can ensure that the tracer acks all tracee
notifications before going into the freezer?

>
> I think it would better to simply change ptrace_stop() to check TIF_MEMDI=
E
> along with __fatal_signal_pending() and return in this case.

I think this would not fix the case we are experiencing. In our case
the tracee is killed from the userspace (TIF_MEMDIE is not set yet),
gets stuck in ptrace_stop() waiting for an ack from the tracer and
then is picked up by OOM-killer with the abovementioned consequences.
IOW, checking for TIF_MEMDIE in ptrace_stop() will not prevent tracee
from waiting for the ack from a frozen tracer.

>
> Although TIF_MEMDIE is per-thread... perhaps signal->oom_mm !=3D NULL?
>
> Michal, what do you think?
>
> Of course, this won't fix all problems.

As I mentioned, I'm not an expert in ptrace, so I'll gladly try any
better solution if one is proposed.
Thanks,
Suren.

>
> Oleg.
>
> > That call will fail due to positive oom_victims,
> > but not until freeze_timeout_msecs passes. For the whole duration of th=
e
> > freeze_timeout_msecs (20sec by default) the system will appear
> > unresponsive.
> > To fix this problem, skip the ack waiting step in the tracee when it's
> > exiting and the tracer is frozen. Per ptrace(2) manual, the tracer
> > cannot assume that the ptrace-stopped tracee exists. Therefore this
> > change does not break any valid assumptions.
> >
> > Debugged-by: Martin Liu <liumartin@google.com>
> > Debugged-by: Minchan Kim <minchan@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/signal.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 1f9dd41c04be..dd9c18fdaaa5 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2320,6 +2320,19 @@ static int ptrace_stop(int exit_code, int why, u=
nsigned long message,
> >       if (gstop_done && (!current->ptrace || ptrace_reparented(current)=
))
> >               do_notify_parent_cldstop(current, false, why);
> >
> > +     /*
> > +      * If tracer is frozen, it won't ack until it gets unfrozen and i=
f the
> > +      * tracee is exiting this means its resources do not get freed un=
til
> > +      * the tracer is thawed. Skip waiting for the tracer. Per ptrace(=
2)
> > +      * manual, the tracer cannot assume that the ptrace-stopped trace=
e
> > +      * exists, so exiting now should not be an issue.
> > +      */
> > +     if (current->ptrace && (exit_code >> 8) =3D=3D PTRACE_EVENT_EXIT =
&&
> > +         cgroup_task_frozen(current->parent)) {
> > +             read_unlock(&tasklist_lock);
> > +             goto skip_wait;
> > +     }
> > +
> >       /*
> >        * The previous do_notify_parent_cldstop() invocation woke ptrace=
r.
> >        * One a PREEMPTION kernel this can result in preemption requirem=
ent
> > @@ -2356,6 +2369,7 @@ static int ptrace_stop(int exit_code, int why, un=
signed long message,
> >       schedule();
> >       cgroup_leave_frozen(true);
> >
> > +skip_wait:
> >       /*
> >        * We are back.  Now reacquire the siglock before touching
> >        * last_siginfo, so that we are sure to have synchronized with
> >
> > base-commit: 6c0483dbfe7223f2b8390e3d5fe942629d3317b7
> > --
> > 2.45.2.803.g4e1b14247a-goog
> >
>


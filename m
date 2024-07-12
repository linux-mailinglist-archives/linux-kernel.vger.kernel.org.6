Return-Path: <linux-kernel+bounces-251112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E219300B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D081F235B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56BD2E634;
	Fri, 12 Jul 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjUD62sT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F992E400
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811420; cv=none; b=C2EJSecGb1aucy6/tDC8/iWbtCQGhFJhjVO8rBMqRx4u/aoYncy+OPxhXEKhZAkw+b94L3mC9Z4kTXkRpsaPHGmHUoqPlAxSPAJ9veXE4ta+ahqHTUNsZnF2fnpFqwiwrTm3mKs6sAP8U0wsPCR7NHt8VlZuE6yI0DwricAvhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811420; c=relaxed/simple;
	bh=gcvmswoiQU8x6oBa5vjdsZwlHqG692/jExm0tRiT6OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTFTPpR814lqKG51y9c2/3ERYdbQ1I4t/psLVfCQmTe4VuxQeBImdTPpCoA2TW0Blixhk0CxSjVdZs34KYt0/sta8hXvOT/jg6ofrmb1MMyp+RP48NbiuP2s3k1EVwwUWH/K1zN9vpg9hc1EdN1CPgo0V2FDiip8J3Hw9XT9mGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KjUD62sT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42666b89057so13675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720811416; x=1721416216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcmyiPuOprwxlbpSmaZuJm568DV27LYrQ63ts04f3XA=;
        b=KjUD62sTnGboJsK6FFS8BTFjs0YTl/LCwbZHXr39EdPXpwyGw61IytgisoXCYGylHY
         rS9lSXn2yHM09ywymFa5mRxwHAoN8e/COgov5595wa4RDXy/tf1mpaPFUP5EjZ0oDdyi
         OAjnVrfDjP85QmYJI6DgArTnYuIK/wPZ2zuHbr1L99DTc2MtjjUfX37GWPuvu2FCwJ4J
         Be2hpn7EkIJZ5XPwdeGgjdTmCu0oaLvi6G3jLBu7Ys/mAqkMc5UqbiEm+d1NwUlxGztr
         WK5oi8js5i2juyFHfX/IM4GaaIQGJQc9iS+wuXiEulzmSGcrtP6clmAbo5biQFbrxPIZ
         jy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720811416; x=1721416216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcmyiPuOprwxlbpSmaZuJm568DV27LYrQ63ts04f3XA=;
        b=NJldiqSSR9Ihtp7Bf/csi9DmNaGHb9JiTJsuWXnccqDYVIqz6qkj3cEuv1JZ3NaJ//
         s4wXR0OUZX7/vuGaBTOz9rckKU58HmRqTWxnN5AZPMWSF76ayA70+C4zTpNvJy5JWww+
         LNzv8zdRch1X+mI3NEzoHSePt+ViwJ3An+fONhHADWZVLKiZQox7Zk4niewkrSW1Uj9o
         iv7D1bgKodfTMIWx2sEboXZqeaPO8naz19k57PZV8OXSwnvLKikUoFWT6IUt/eWnAze1
         mVpFjFqDaOyZNnZKOU6Zrp0D0rWNCva3F8ipcEHrYntSMS/9V9PVMZegzuofuMEudyXV
         coAw==
X-Gm-Message-State: AOJu0YwrjsiK2yvEJNDLPdwEtXXS6GKJd1BefIe0ixYEewF3pIdzH5f4
	01IYpwB5r7eCLf6FnCOaqUy5mYrqZeVOE7uDWOQKHA5JkFkedI7QRiQpg93Rw7tnFad+B2Emq/l
	KQBFji/dkr8eIZyqPOj1Xfl5pFnkAza5pDXw=
X-Google-Smtp-Source: AGHT+IEBJyyfXaiY90UqeQJnpZaqEr86C7Ykd5Ew8BiHomgkR8znYgG708dRLyvF695EZKql5E+av46uPcUJn99jLE8=
X-Received: by 2002:a7b:cd8f:0:b0:426:6fb6:99f2 with SMTP id
 5b1f17b1804b1-427a4737568mr217015e9.3.1720811416323; Fri, 12 Jul 2024
 12:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com> <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net>
In-Reply-To: <20240712150158.GM27299@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Fri, 12 Jul 2024 12:10:03 -0700
Message-ID: <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Metin Kaya <Metin.Kaya@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 8:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Let's define the scheduling context as all the scheduler state
> > in task_struct for the task selected to run, and the execution
> > context as all state required to actually run the task.
> >
> > Currently both are intertwined in task_struct. We want to
> > logically split these such that we can use the scheduling
> > context of the task selected to be scheduled, but use the
> > execution context of a different task to actually be run.
> >
> > To this purpose, introduce rq_selected() macro to point to the
> > task_struct selected from the runqueue by the scheduler, and
> > will be used for scheduler state, and preserve rq->curr to
> > indicate the execution context of the task that will actually be
> > run.
>
> > * Swapped proxy for selected for clarity
>
> I'm not loving this naming...  what does selected even mean? What was
> wrong with proxy? -- (did we have this conversation before?)

So yeah, this came up earlier:
https://lore.kernel.org/lkml/CANDhNCr3acrEpBYd2LVkY3At=3DHCDZxGWqbMMwzVJ-Mn=
--dv3DA@mail.gmail.com/

My big concern is that the way proxy was used early in the series
seemed to be inverted from how the term is commonly used.

A proxy is one who takes an action on behalf of someone else.

In this case we have a blocked task that was picked to run, but then
we run another task in its place. Intuitively, this makes the proxy
the one that actually runs, not the one that was picked. But the
earliest versions of the patch had this flipped, and caused lots of
conceptual confusion in the discussions I had with folks about what
the patch was doing (as well as my own confusion initially working on
the patch).

So to avoid this, I've minimized the use of the term proxy in the
code, trying to use less confusing terms.

To me, selected is a more straightforward term, as it's the task the
scheduler chose to run (but not necessarily the one that actually
runs).
And curr is fine enough, as it is the currently running task.

But I'm not wedded to any particular name.  "selected", "chosen",
(Valentin suggested "picked" earlier, which I'd be ok with, but wanted
some sense of consensus before I go through to rework it all), but I
do think "proxy" for the scheduler context would make the code
unnecessarily difficult for others to understand.


> > +static inline int task_current_selected(struct rq *rq, struct task_str=
uct *p)
> > +{
> > +     return rq_selected(rq) =3D=3D p;
> > +}
>
>
> And I think I hated on the macros before, and you said you needed them
> to to allow !PROXY builds.
>
> But what about something like:
>
> #ifdef CONFIG_PROXY_EXEC
>         struct task_struct __rcu *proxy;
>         struct task_struct __rcu *curr;
> #else
>         union {
>                 struct task_struct __rcu *proxy;
>                 struct task_struct __rcu *curr;
>         };
> #endif
>
>
> And then we can use rq->proxy and rq->curr like the good old days?

Ok, yeah, we can use a union for that. I tend to think of unions as a
bit overly subtle for this sort of trick (the wrapper functions make
it more clear there's indirection going on), but that's a taste issue
and I'm not picky.

> I realize this is going to be a lot of typing to fix up, and perhaps
> there's a reason to not do this. But...

I have no problems reworking this if it helps get this series unstuck!

I might strongly push back against "proxy" as the name for the
scheduler context, but if it really is your favorite, I'll hold my
nose to move this along.

Do let me know your final preference and I'll go rework it all asap.

Thanks again so much for providing some feedback here! I really appreciate =
it!
-john


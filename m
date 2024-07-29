Return-Path: <linux-kernel+bounces-266576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8A9401D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EF71F231F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F318EFD3;
	Mon, 29 Jul 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlD9ni3k"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63401E49E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722297276; cv=none; b=VGxmfIxHb+vZDUYRYh4KWd62Y/6BF0hfg4diqqb7Nd4MdiScwmHA20dPsfADHZb0KSBDiQqINT2kWWNAelZeEU+WSuQy+KfQQDW1wZquxCF0Oj8x/GMyJR/TGyOdjfas0t6ogLHF4Ak+RjpQOlHp4iTQIRFMl7/bQRgu3CzvGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722297276; c=relaxed/simple;
	bh=banOIsj5nz2JgOAC9kj1hXvC80b7s+Pte5aQjJV7iWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulmLqSRZK1qV5LkHsZGNlLyKlgApIyXq98iK9kzLhBPYugBH+EObjgtVFPXs+ViWirRv5xw2lAwZAxHSqoSiqfcBe5gCsL/t5tNzywiBvi4Dj6bIlkREWIL/mINBnBev+4M9/qKFu/an+z7FPsx8FPAez/ih+DH8Xf+X6RzhaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlD9ni3k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso7965e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722297273; x=1722902073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2UhurdH4LXT8wlRv7Brs1pLfIhw3yKt9l8KVbKLaO4=;
        b=XlD9ni3kd/hZWu1e8Hx4RTw8tIvhtFcsdOh+zqpwUHBmA+yaXmI4mosun8iBjuuVM/
         agq6+09TVUN2dgGFCdpRSfdyixEDDWX/3KfJndkkeMg82qmbXjKuK12a4hzffFiVcdBi
         lhyhB2T4k1xzCni4iB3k/lhvz3wVz0V66oOWq/Mi840ABEjLciOt25+Ms2u00x9XGa+3
         6oqLVfd5FovvsdIHWLpsl4/UFAc4h3SVN723NyiwPLIgUmcp9PcpMg235K8RNAIOv11H
         shmn2RRZjjXt58B+196ES3qCqY6fIQ3UrjmnklyF1aQnSfQC5RYBCZ4RZLiYRW2cCJvL
         Kbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722297273; x=1722902073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2UhurdH4LXT8wlRv7Brs1pLfIhw3yKt9l8KVbKLaO4=;
        b=THmaBq7x0jup1gfdxyTIQkZL7yiClCw2+D7QkGNK3HqsvDb8G4wYwFT1nTQ3YMwVF1
         CP2JOZDzeZF6bPyZFcOuCXBhTXohJHzOAUEsxBVs1MwdXMR0DZZGAh6XoHo9h3q6JupD
         vNClCA3vh+n32cqF+M8bFvMaH1FfD9YNTLRcglcZELRXusHDVGPDYxixmE+0UI8wioFg
         efhBNhuRzj3+JOrGLMioUA1jIsMd6jLGIMZaEoWVcPli+HtDrO9Q3hehCZdapbljuwtX
         vMS+7J2m4nVumM8kCMgTRkZOGWa/hYKTvSsGcf+lbK9dZEF67DJsaKQ0A76IY2awMxEa
         lXfw==
X-Gm-Message-State: AOJu0YwFoGsHxDcYuQzDeiBdeagu/7Q9FH4AYY8/pplN6DmJ5JUXVl3S
	UQRN1/sQua68g2rGp81jvpU1wNzU9gKzC3V88gdA8bE18IKoeSX3oE+/UzDDRjhu3ok39IUN9DC
	tlG2GiEEbQWzb7wRHhTEX3KUy+bPyhOxH5jk=
X-Google-Smtp-Source: AGHT+IHh7cX2XIEvNSvHbct2dqX7lSpZVxQUekczr0VK9c+teP4zobwrz+mEus7paGCvLtIswDARd1UJnTmr/WGoH18=
X-Received: by 2002:a05:600c:1caa:b0:428:31c:5a42 with SMTP id
 5b1f17b1804b1-42824a36697mr36575e9.3.1722297272996; Mon, 29 Jul 2024 16:54:32
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com> <20240709203213.799070-8-jstultz@google.com>
 <20240712150158.GM27299@noisy.programming.kicks-ass.net> <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
In-Reply-To: <CANDhNCrkf1Uz42V3vMFChp1nKnkeHH7ZPxd_gC4KOMmWPcRVgQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 29 Jul 2024 16:54:20 -0700
Message-ID: <CANDhNCq7e5EX5ZsDKZcfbgQjy6Wt-+0hMsM6duuTMwB=O6siKg@mail.gmail.com>
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 12:10=E2=80=AFPM John Stultz <jstultz@google.com> w=
rote:
> On Fri, Jul 12, 2024 at 8:02=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > Let's define the scheduling context as all the scheduler state
> > > in task_struct for the task selected to run, and the execution
> > > context as all state required to actually run the task.
> > >
> > > Currently both are intertwined in task_struct. We want to
> > > logically split these such that we can use the scheduling
> > > context of the task selected to be scheduled, but use the
> > > execution context of a different task to actually be run.
> > >
> > > To this purpose, introduce rq_selected() macro to point to the
> > > task_struct selected from the runqueue by the scheduler, and
> > > will be used for scheduler state, and preserve rq->curr to
> > > indicate the execution context of the task that will actually be
> > > run.
> >
> > > * Swapped proxy for selected for clarity
> >
> > I'm not loving this naming...  what does selected even mean? What was
> > wrong with proxy? -- (did we have this conversation before?)
>
> So yeah, this came up earlier:
> https://lore.kernel.org/lkml/CANDhNCr3acrEpBYd2LVkY3At=3DHCDZxGWqbMMwzVJ-=
Mn--dv3DA@mail.gmail.com/
>
> My big concern is that the way proxy was used early in the series
> seemed to be inverted from how the term is commonly used.
>
> A proxy is one who takes an action on behalf of someone else.
>
> In this case we have a blocked task that was picked to run, but then
> we run another task in its place. Intuitively, this makes the proxy
> the one that actually runs, not the one that was picked. But the
> earliest versions of the patch had this flipped, and caused lots of
> conceptual confusion in the discussions I had with folks about what
> the patch was doing (as well as my own confusion initially working on
> the patch).
>
> So to avoid this, I've minimized the use of the term proxy in the
> code, trying to use less confusing terms.
>
> To me, selected is a more straightforward term, as it's the task the
> scheduler chose to run (but not necessarily the one that actually
> runs).
> And curr is fine enough, as it is the currently running task.
>
> But I'm not wedded to any particular name.  "selected", "chosen",
> (Valentin suggested "picked" earlier, which I'd be ok with, but wanted
> some sense of consensus before I go through to rework it all), but I
> do think "proxy" for the scheduler context would make the code
> unnecessarily difficult for others to understand.
...

> > I realize this is going to be a lot of typing to fix up, and perhaps
> > there's a reason to not do this. But...
>
> I have no problems reworking this if it helps get this series unstuck!
>
> I might strongly push back against "proxy" as the name for the
> scheduler context, but if it really is your favorite, I'll hold my
> nose to move this along.
>
> Do let me know your final preference and I'll go rework it all asap.

Hey Peter,
  Just wanted to check in on this in case the mail slipped by. I'm
eager to rework the naming and get this re-sent, but I just wanted to
confirm your preference here.

thanks
-john


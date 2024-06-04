Return-Path: <linux-kernel+bounces-201014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B548FB82A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998081F21B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07451420C9;
	Tue,  4 Jun 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8Wwitkl"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486AC145B09
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516419; cv=none; b=Vl0yPDxHVORIbv4wki9Sv54fD4jPA64jpykgiFpIfnP1SZtyFUcwtxc+wlFN86xd0xZRpmmt8kwu8zXc72Y2GlszXZ5gXAWJgJ5okaSdlwxO7ASWUHB36wq/HuN3/MthzxwmsrQsh44Y9kQXZXtdISWJ0+Bz/mPzF7Z2HLUoRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516419; c=relaxed/simple;
	bh=POwko8/7ggSGv+vt4kzMAiiU/n7LYzZiHtKFLPuu0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrhgEOz2fWwOZ/NIpEetRTjvmk+QTXqQ0iK/BGS+KgpAACaDiauD1JYvnPoycj4PT8DyZKYgKsVh0n+/yzrdWUd1rckW5pnDiotv8KrHjLDw/pf16Fp/XF+nQOWlpiPpOC5loaq6FJw3QWj7Rsq0LWw0iWYa4JGTMpxQvaDVqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8Wwitkl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4214a7c14c1so116885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717516416; x=1718121216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+EM2XB1oWAl1p5i4m8GXWwSGr8l1SzFI7kbOydQlUM=;
        b=k8Wwitkl265NOrNx4vPByl6VHuqMflGO426yL9lLTM8Dy5s0Ot41GO1P+1VPRaA7Zh
         a9txm6uNB9+JSeXRx/3Y+OgNo8a4j8egwumVmNGpoKa1VJCZw79+xJ83TKmb3TUzB5GO
         fR2iWeono4qWOJjjxaY89dqwx/iw2Me5zutIrYHUL3SGc9CGO6BEjEWJXFBUJXXunsgZ
         KZyj+vCbo7g1XcbAn6ISc7/yg5qldA2VRGHJ4ztKZUtmvYZFOdsLn0APEvLMtwt20Y+w
         DuHPDj0NCbbcZgGUITs7xOSP/dT6MUu2f/V6twQDqTdo2PoLD9yPuXhHgnaqznNXjxG7
         IDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516416; x=1718121216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+EM2XB1oWAl1p5i4m8GXWwSGr8l1SzFI7kbOydQlUM=;
        b=rSaT5jfepVTILe9E01z9IBdBw0jF+bbJHthi75Tdnn1I+w1IoyKbZ/dDW8sm3CPQ28
         7hRG4/UQEKmL2K6P2z3RWokLVV459GLveRS1b8KE4ywKD8CIQZlL2gP3+P+alv5Zzq4p
         vp8x88LHy0zbOA10tvQrSNHzDU6dkYTL6sxVffzN+KJPRDfASFg9RVF+XLmR7mHeOhFs
         J8rmxqPdUNTjXSE+g7S/rJnSrigGjp2t783DdFK1y2tA0EjSVr/p/TDogQ8oIxzH8CkW
         4Qjp0JybGocr8RLtnGhDLOWSfhnjcaIuZIRtoGDp3Fbv34p1/xG7vynhaLZ/oWzRU8qE
         NaOw==
X-Gm-Message-State: AOJu0Yz0aINMn4VKTj+nx/fa2cr4dZZeaecLXO8kl3lPBI1L5xJIa1B5
	7WdZBz4fWLKKjiKLJp/FuhB7y+wAjF3/L9C/5DRGl49bVXpZ6X6hp4ufx5Xph2hGiHc9Fgs9Wfm
	XyM5wL9qhVbAoZDUl3AAbQrlq5XfIH1urXDHsPGYDcb7v1TDlldc=
X-Google-Smtp-Source: AGHT+IFXrMYiy88spkS3ajk2rHbpfp1FtpWk/lNq0Fx1iSRE8hu6lk85iyTB7LjLCuInOVUvGHI86Lbd1j50X/dwgBc=
X-Received: by 2002:a05:600c:2107:b0:421:292d:f1e7 with SMTP id
 5b1f17b1804b1-4214947af3bmr2887895e9.6.1717516416393; Tue, 04 Jun 2024
 08:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507045450.895430-1-jstultz@google.com> <20240507045450.895430-5-jstultz@google.com>
 <20240604131204.n4njtgo4tpo352ht@airbuntu>
In-Reply-To: <20240604131204.n4njtgo4tpo352ht@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Tue, 4 Jun 2024 08:53:22 -0700
Message-ID: <CANDhNCocJCShaAOzd1sU+O+B3wd+YjXSddcGr2pESx9nfCdH4w@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] sched: Add move_queued_task_locked helper
To: Qais Yousef <qyousef@layalina.io>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:12=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
> On 05/06/24 21:54, John Stultz wrote:
> > From: Connor O'Brien <connoro@google.com>
> >
> > Switch logic that deactivates, sets the task cpu,
> > and reactivates a task on a different rq to use a
> > helper that will be later extended to push entire
> > blocked task chains.
> >
> > This patch was broken out from a larger chain migration
> > patch originally by Connor O'Brien.
...
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ae50f212775e..2d41ebe200c7 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3480,5 +3480,16 @@ static inline void init_sched_mm_cid(struct task=
_struct *t) { }
> >
> >  extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
> >  extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity =
*se);
> > +#ifdef CONFIG_SMP
> > +static inline
> > +void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct =
task_struct *task)
> > +{
> > +     lockdep_assert_rq_held(rq);
> > +     lockdep_assert_rq_held(dst_rq);
> > +     deactivate_task(rq, task, 0);
> > +     set_task_cpu(task, dst_rq->cpu);
> > +     activate_task(dst_rq, task, 0);
> > +}
> > +#endif
>
> I see this pattern in __migrate_swap_task() and try_steal_cookie(), shoul=
d they
> be converted to?

Ah! Thanks for pointing it out. I'll include that in the next iteration.

> Beside this
>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>

Thank you so much for the review and feedback!
-john


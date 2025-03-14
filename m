Return-Path: <linux-kernel+bounces-560572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C368A606B2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBF83BC8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5EBBA2E;
	Fri, 14 Mar 2025 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4L71JKt2"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBCBA27
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913352; cv=none; b=NzPS1S2ZfKtgBSrRbBC8C/QIhS1fMUw8wqhkaT7/MVHUM+iRzJUBWH1oSFYygSgYPkquC6o+ndx7+kUzRJF4OXzG6ZcX8OBV1YOzAdKCEkTJUNR83KWzE+OcMXZiJXqEOqzoyu/KsejekqVMcoo8S5mkfNY2ZHi2UEY3lN01238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913352; c=relaxed/simple;
	bh=qBJkENjnIqGSvFN9E/Jrkqaorc9fr43YwB91TwJpvmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlRotDHspak4XGCrd+b5lCDf8R6ASuB+j2ViaycX9K+MR0XYiuMYegKSmOODJgKv5PAdxUYEzb1IC9yoSPGiwgRqfjiEgTBrR75dW1vd3BdEI3XD00hss7Z+jYQrqn1xJyd+5yg12lqmf4OS1CWPKFXHK3NVApl9OhpCHieRQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4L71JKt2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c2d427194so17114741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741913349; x=1742518149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHvR0nMSMsB/8s/BNOWs/apd6Uvvi+MbvN0YChJeLS0=;
        b=4L71JKt2clLE1DtgOR5IZdXbpDs0tutQvGl0HgLUo17sCOCO0ERscX56UoaQEY3W9x
         h08DctAUkGABacXtXYEOMLO60zKqQy985agV6dmipthoqauOxBemB0HsLSAla1CAVJTv
         jweBhf4POYw48PhRPi1WvKt4IsORiYKxaOjmnoiddISHc+TA27+UidnuFN+QDWeomwv+
         lI4kvkug6fAf7UfYAphKEhEf5W97w4EIFl2cUceGnEicdJTCoVBinqpcZzv49cGVq41b
         48BBe8nEMgmklI3iVSF/qLoZJnfAypRMA+t5kkikHYv/m6IAFJC0RqsugFrm38tMuC/G
         dwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741913349; x=1742518149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHvR0nMSMsB/8s/BNOWs/apd6Uvvi+MbvN0YChJeLS0=;
        b=A0qiNuYLHFXYxn55TA8nvQsqzAOCLd0XiObfqmPC7O0LfzxyeQbGmuWFqhHVoIvzZ9
         yILCBLRPY6QFghO24H7xt6WMPMF8jqaX6sUN4jesy9pDqMmQm0Zp8ZxThyqyD5FCihsv
         Hg41CkgmGkPGBKzuFOqyOqSlzzX8J8JayCi7li/+1sKKGKO+Baz6xiCdplEemDhFQ9+z
         rZiVy2+Y57jblpZC0bsNKi20MvXnIi4Fbl43S108E8d0RLKePXwhcAgO87u4dyWZ/B3j
         DB/xsBWOel1/NjmyNAU6MIpa9nUAwDIePTO2U1ZHknGdNu3Ltriwbh5A2D2v0ZWuSL6P
         UCyQ==
X-Gm-Message-State: AOJu0YyLC9quGNM9r/ry+ZTVvaiMGJe+ewriuPC6YiaveIyTtSOmUa7d
	DlFCyhZHdMtqs4ag3uHD2L0tMiBmFRzmbP3cVJrwV1UuEA8ImkKARfxzN/GLmqBo0KlRlk49qlP
	4CeFdl3c7rhJZZFvZZC8sm9NrPItNg9y0pzU=
X-Gm-Gg: ASbGncshQRnu7WO+Kaf80dndHf2bJjz1fWLAjVKE3YMa0UwmYZpvi6eOQYqOfvz3Dt1
	4bB+ko8eJsrKklamRuSK8qg4vERTI+sQOh5fNkpZ6OYMcxIhzHYxqDgPhfOvk/UjiIzRytkIc68
	G8q654U9GupSDBNJ4LFydrsm6vN24B3kciTU42uLLCQBFYvfblte/jr7uC
X-Google-Smtp-Source: AGHT+IHZYVnQcHmOyiK/gk6vbNe4GlNRuQx357W1cZsI8kVT9f01pPELk/Uj0bTdkLa1s+RokvamnSbDdni8F81DwLg=
X-Received: by 2002:a05:6512:ac6:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-549c3989a09mr161863e87.42.1741913348603; Thu, 13 Mar 2025
 17:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com> <20250312221147.1865364-2-jstultz@google.com>
 <20250313060907.6828c62c@batman.local.home>
In-Reply-To: <20250313060907.6828c62c@batman.local.home>
From: John Stultz <jstultz@google.com>
Date: Thu, 13 Mar 2025 17:48:56 -0700
X-Gm-Features: AQ5f1JqBZuJUhf60DNuD56Qf3bhmXE0I5JU53dxzrgJYXkuhyLa6aKAbkybJ-k4
Message-ID: <CANDhNCr_c0y6v0F5y3H5ZRDxLO4Ah7gD0q25d29YiCvUrUPBXA@mail.gmail.com>
Subject: Re: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:09=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 12 Mar 2025 15:11:31 -0700
> John Stultz <jstultz@google.com> wrote:
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index fb8752b42ec85..dcc2443078d00 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6262,6 +6262,11 @@
> >       sa1100ir        [NET]
> >                       See drivers/net/irda/sa1100_ir.c.
> >
> > +     sched_proxy_exec=3D [KNL]
> > +                     Enables or disables "proxy execution" style
> > +                     solution to mutex-based priority inversion.
> > +                     Format: <bool>
>
> To enable, does this require: sched_proxy_exec=3Dtrue
>
> Could we just allow it to be:
>
>                 sched_proxy_exec
>
> Also mean true? That is, both of the above would be true, but to
> disable it, you would need: sched_proxy_exec=3Dfalse.

Currently the flag defaults to true, so I'm not sure if
"sched_proxy_exec" on its own makes as much sense to me.

Though, in the android16-6.12 kernel, I have an additional change that
sets it default to false, which allows "sched_proxy_exec=3Dtrue" to be
useful.  So I'm open to having the argument alone as an enablement
flag (in addition to the explicit setting), but I've personally always
found the mixed conventions there confusing, preferring the explicit
"=3Dtrue" or "=3D1" on boot arguments.


> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b3..b989ddc27444e 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -875,6 +875,16 @@ config UCLAMP_BUCKETS_COUNT
> >
> >         If in doubt, use the default value.
> >
> > +config SCHED_PROXY_EXEC
> > +     bool "Proxy Execution"
> > +     default n
>
> Nit, you don't need "default n" because "default n" is the default ;-)

Ah, thanks I'll drop that!

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 67189907214d3..3968c3967ec38 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_=
tp);
> >
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >
> > +#ifdef CONFIG_SCHED_PROXY_EXEC
> > +DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> > +static int __init setup_proxy_exec(char *str)
> > +{
> > +     bool proxy_enable;
> > +
> > +     if (kstrtobool(str, &proxy_enable)) {
>
> To make it work without adding =3Dtrue, the above could be:
>
>         bool proxy_enable =3D true;
>
>         if (*str && kstrtobool(str, &proxy_enable)) {
>

Ok, I'll give this a shot.

Thanks so much for the review and feedback! Really appreciate it!
-john


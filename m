Return-Path: <linux-kernel+bounces-403512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3D9C36AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26217B2198B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D912A177;
	Mon, 11 Nov 2024 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGSdZUAM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298949625
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731293232; cv=none; b=YY5n2Fl/bfewAU1Gcbm8lBkclf3AmfCtvCV1zeuwYkFtvtVKnmrjARLtW3f7VbMWtGhXOarMlYm43e4fgM+PqOngwfcd5VhOLQuerIu4gPQ7ShxA/oo+mmHDMLI+islQB3u46VxrdyYaQV1SrhW8OgKLC2wnwWFyRzdT6o9ELAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731293232; c=relaxed/simple;
	bh=HrKgSYIcrjdNHTzHsfaeHfmZxbgHCX0bLBuSZp5WAcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IacMgGYiT7ZKt4Wz2MigjuQjn5L6BhVi6vTfkwoDg5SRrJBeKbjGEQVyXY8zCtS2ndfdNVwUnzzVsIWeIhmIUKyxMU+WKDaO4Lx6kEOJUZZ4IIkrUY2Ae+KBlanHLcLRC50i/kZ+KONnlCkvsNSBaqAFqPDhUMr92KFc7ixHtvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGSdZUAM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so627051266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 18:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731293229; x=1731898029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzNy+RCLEluv7usUH1hDTRC+SWDoOAeDA5zkUvwwG4g=;
        b=kGSdZUAMFC4htKO2cfSTmEzd1cZG6fm5L1SWVoky0s01uOn0JSeh4l3loQs4XJ/Lue
         WzJ/Y0x9sWXmj9VpLJ/yO2f7wtWZgovZ5G3yx2CNSbkRs3JquT+mb9oQL9HJNmU6AU7V
         B+qEHxnfQ3qMwWSQjbjaeO1vUj2dFRwcfKNYwzQ3Ae0HGPMMsi5FM+v7EbdTdMsrdw36
         2D0OYu0nQ2T4vsaLGipSRqH7rgdYmIcnFz3TVd5x09aAPV89elSAyyWDldsXWB4Uq6Zx
         OT2s5KgsI4JUm6JjkY8amKCd2PyAkEnP83o/Vxn43fgCFhDv3d6Jr7DVYuekF1iTc83b
         vfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731293229; x=1731898029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzNy+RCLEluv7usUH1hDTRC+SWDoOAeDA5zkUvwwG4g=;
        b=PcyXLX7JYfL6JRJwfYUmW2QXrIwCXSy1YqJeOmDeLpjSXTA9dYU/2lTkq/WXRpm1sN
         5Ks67bZLhbSZDo9VZSuWXtPiN1cFS0YLDv6wPbUSsKvtdKsLs46b963VNmBRQjxg7yy3
         abVSFOCqjqu0sXnRZ2/nL2F1dQm3BDC/v604i7xvmFgwExu2cj7zpLFj7OZ2Y0bV0DPR
         acZpOyXupYQsEbs4jQtl8NLyVWezmkPBN0GcqC3S8PgHsiiSm13VMJoBY/61H/qYVseO
         dkxAoiWebqBmAo35wtyjAESBTfWBucqPq0av3vPxhHNvtTLGWQHuctleWlCMhUNnGlWg
         flHA==
X-Forwarded-Encrypted: i=1; AJvYcCVsGLzRrF/SDEgYELnK7+mpP607HhTXLzBdjsGdldnVcUUQ/EaoQrfxAeXH3F54+GKVqHTpHYbenvAfBys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUDtv420P0qTeAbIk6kAguO/35eYDnawCPDwZeHmem2H5GM94
	OoFVmoXRVBy/nFzudXlEKazi4tcKrSMra/21nWhOHXkLBteDKCXHCz+WrQbMGAnzzekIqeZsjqp
	cnuvHT7VrnXkWTcLhkU445TItLJ0=
X-Google-Smtp-Source: AGHT+IEJkMe77KSZQa1MedkuLVg0uxnVnYAL2Ge+inY6N1V68QafFHwCkkT4f9zswSGTYTCbqYy6Ezr7Kr1JNehSc0M=
X-Received: by 2002:a17:907:7ea7:b0:a9a:4aa3:728b with SMTP id
 a640c23a62f3a-a9ef00190a6mr1052393566b.53.1731293228607; Sun, 10 Nov 2024
 18:47:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101200704.GE689589@pauld.westford.csb> <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb> <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <20241106135346.GL24862@noisy.programming.kicks-ass.net> <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de> <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de> <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
 <20241107140945.GA34695@noisy.programming.kicks-ass.net> <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
In-Reply-To: <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 11 Nov 2024 10:46:57 +0800
Message-ID: <CAB8ipk-rE8+ayPE1ctGKZ=ft2d-Ck0K8KNb4nRiTjg+UpQB=xA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	Xuewen Yan <xuewen.yan@unisoc.com>, Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike and Peter,

On Fri, Nov 8, 2024 at 8:28=E2=80=AFAM Mike Galbraith <efault@gmx.de> wrote=
:
>
> On Thu, 2024-11-07 at 15:09 +0100, Peter Zijlstra wrote:
> > On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> > > On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > > > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > > > >
> > > > > I built that patch out of curiosity, and yeah, set_next_task_fair=
()
> > > > > finding a cfs_rq->curr ends play time pretty quickly.
> > > >
> > > > The below improved uptime, and trace_printk() says it's doing the
> > > > intended, so I suppose I'll add a feature and see what falls out.
> > >
> > > From netperf, I got.. number tabulation practice.  Three runs of each
> > > test with and without produced nothing but variance/noise.
> >
> > Make it go away then.
> >
> > If you could write a Changelog for you inspired bit and stick my cleane=
d
> > up version under it, I'd be much obliged.
>
> Salut, much obliged for eyeball relief.
>
> ---snip---
>
> Phil Auld (Redhat) reported an fio benchmark regression having been found
> to have been caused by addition of the DELAY_DEQUEUE feature, suggested i=
t
> may be related to wakees losing the ability to migrate, and confirmed tha=
t
> restoration of same indeed did restore previous performance.
>
> (de-uglified-a-lot-by)
>
> Reported-by: Phil Auld <pauld@redhat.com>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Link: https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford=
.csb/
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  kernel/sched/core.c  |   48 +++++++++++++++++++++++++++++---------------=
----
>  kernel/sched/sched.h |    5 +++++
>  2 files changed, 34 insertions(+), 19 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3783,28 +3783,38 @@ ttwu_do_activate(struct rq *rq, struct t
>   */
>  static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  {
> -       struct rq_flags rf;
> -       struct rq *rq;
> -       int ret =3D 0;
> -
> -       rq =3D __task_rq_lock(p, &rf);
> -       if (task_on_rq_queued(p)) {
> -               update_rq_clock(rq);
> -               if (p->se.sched_delayed)
> -                       enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DEL=
AYED);
> -               if (!task_on_cpu(rq, p)) {
> -                       /*
> -                        * When on_rq && !on_cpu the task is preempted, s=
ee if
> -                        * it should preempt the task that is current now=
.
> -                        */
> -                       wakeup_preempt(rq, p, wake_flags);
> +       CLASS(__task_rq_lock, rq_guard)(p);
> +       struct rq *rq =3D rq_guard.rq;
> +
> +       if (!task_on_rq_queued(p))
> +               return 0;
> +
> +       update_rq_clock(rq);
> +       if (p->se.sched_delayed) {
> +               int queue_flags =3D ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
> +
> +               /*
> +                * Since sched_delayed means we cannot be current anywher=
e,
> +                * dequeue it here and have it fall through to the
> +                * select_task_rq() case further along the ttwu() path.
> +                */
> +               if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {

For sched_asym_cpucapacity system, need we consider the
task_fits_cpu_capacity there?


> +                       dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
> +                       return 0;
>                 }
> -               ttwu_do_wakeup(p);
> -               ret =3D 1;
> +
> +               enqueue_task(rq, p, queue_flags);
> +       }
> +       if (!task_on_cpu(rq, p)) {
> +               /*
> +                * When on_rq && !on_cpu the task is preempted, see if
> +                * it should preempt the task that is current now.
> +                */
> +               wakeup_preempt(rq, p, wake_flags);
>         }
> -       __task_rq_unlock(rq, &rf);
> +       ttwu_do_wakeup(p);
>
> -       return ret;
> +       return 1;
>  }
>
>  #ifdef CONFIG_SMP
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1779,6 +1779,11 @@ task_rq_unlock(struct rq *rq, struct tas
>         raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
>  }
>
> +DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
> +                   _T->rq =3D __task_rq_lock(_T->lock, &_T->rf),
> +                   __task_rq_unlock(_T->rq, &_T->rf),
> +                   struct rq *rq; struct rq_flags rf)
> +
>  DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
>                     _T->rq =3D task_rq_lock(_T->lock, &_T->rf),
>                     task_rq_unlock(_T->rq, _T->lock, &_T->rf),
>
>
>


Return-Path: <linux-kernel+bounces-441330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DCF9ECCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21489188AA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF349225A5E;
	Wed, 11 Dec 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2jEkI9/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B923FD23
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922891; cv=none; b=kgULWbLo+KjRjOquvoWdELcoOTtCuGDWmNluvX4GXC1J+87tx2nEb3yZjejLaiVR1voOAJ4K7RXP9Y+I3mqd6Yr4++cyW+nrqh9LslQi/NLyHEMLaXULUayBNdsEQkEyoCRLxZojpOBKxlNmiSA9aET+lgMPcYbkwPRH3YpQVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922891; c=relaxed/simple;
	bh=1cJsL42qPkAYlN4l4eUgx6hzjlmM/RqlihnDa95yJ+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvLldvORfMK/njX9RIbuGjci6f75bIYuvxB3euUlPkNL0HEPV57uhxP7MlQD3qIgbDFqc16m5hFjWrI/LRTLZaDVt/5qyanNaWTbRBBFmRjxpE15evmtJm+DlHDEZrI0cBA2CsI2YL3tB3g9hSo7+oAJdGSLsZgpCgs993rYqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2jEkI9/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728e3826211so1413971b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922888; x=1734527688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u/b1zq+0bDFJFXOl9oHeKZXcyYEvpSWomHmwLFPyl8=;
        b=K2jEkI9/lBftJAULHFO27ttIzmP1i++ccgphyZhaYCL61HnO0TsIo3sAkbEiwB01+4
         I2ThNIgF8f5s12LwN6tGl6k2b9C0RuA7jlbvcM4Cy5cNEZflilPbB00ZOqQqjLtbPs94
         +qfPKV/PKyF0cTgJptoMuZ95gZsrp8Xj3J3Xdj4T0wOk1dBqcM4p07qx1MGK3hxUr539
         oGZyT2J5YZAZveEwV5wEnW6vbkmmtDnFbPu5KdEUht84WiA9Aim4qi55UXqNptoBxzyQ
         m9RdRM3CixQm3KHCZrJadX4cXcaHZzGi1r0hGHB2QGDTH8+Uh3KNnB3Bw9zx0V5c7ZFy
         BY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922888; x=1734527688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u/b1zq+0bDFJFXOl9oHeKZXcyYEvpSWomHmwLFPyl8=;
        b=n7hbM3Cc5HUO422tawBuEU+OwNTBMJzd1QYHD/Y3RgivKiRqT0o85NhrtLw9mTKN9B
         sq+24VsfmCTi4h+40lh9+s3XKn+OHhW4VGz3t+UuJOPv/m+wiYbgibfZplTGNsyg8rUB
         mckxzEp+lKH9RR/l7QGG/cv1hKhiyg4nO+MUAT5CTN8OXsAnLtq9DsJAuIk2mqVxUmap
         k9QmjEdHZgnTr/N2s7zXxc2kWS7/j1aaIldf/74HnzwMR/QSUXs1gn1C/MoaQ7/RPRVS
         SCCXWu9cdwW0AZAP21Far/e3f/D/LcS3KDbXjy3ksOmyNXQw6C9FB3OIpPgTho4Gj8Hq
         uIFg==
X-Forwarded-Encrypted: i=1; AJvYcCWBu35NFPgq1P4CScU1/NR35S6Ql7SzsZ9ZWvjZsmx9VNtJgFPsmWP3X8jSzK+FOUH56uKwzfwgSn/vIHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70ZE1n85+OTWRAnoEgoVRVL2GuQqo1MP1Yci1DYhN0TMb82Eb
	Tq2RkTvaHBlJq09RQckeoT7ycA0HKKkt6P+QDpDCEZxtbbikDa3uagDX87kCYyF+ZOXQdymlgGk
	+eH1uyVMxAYVmMdxqnDxxQEs1DiL1kS54NmvtKA==
X-Gm-Gg: ASbGnctRp59vtPBjsl67VtatVFaMOK/M+QBn7LYKuRe/snBJwVPn8uMmZdAdPZwpwtu
	jAx6B9iHs9SKZUXhNB/l0uKTp68bdIm7LagrH7vD+rB59XHN3QpoNCk8Hip7kmCZp
X-Google-Smtp-Source: AGHT+IFCr0PMEZiWSXX8Q8od99eoaeMlkG7ijdiuDBBhPQOeinPc81+0EvXzpfkt7Zweecjlk3U7mCIqa1LTIO7csEA=
X-Received: by 2002:a05:6a00:928b:b0:728:e969:d4ba with SMTP id
 d2e1a72fcca58-728ed4bf36amr3714949b3a.22.1733922888409; Wed, 11 Dec 2024
 05:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126103513.GK38837@noisy.programming.kicks-ass.net> <20241127070534.62903-1-zhouzihan30@jd.com>
In-Reply-To: <20241127070534.62903-1-zhouzihan30@jd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Dec 2024 14:14:37 +0100
Message-ID: <CAKfTPtDcQH==23tWEXNz=dFujBvBC88NESp4KcwEPf83_s6PjA@mail.gmail.com>
Subject: Re: [PATCH] sched: Forward deadline for early tick
To: zhouzihan30 <15645113830zzh@gmail.com>
Cc: peterz@infradead.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	juri.lelli@redhat.com, linux-kernel@vger.kernel.org, mgorman@suse.de, 
	mingo@redhat.com, rostedt@goodmis.org, vschneid@redhat.com, yaozhenguo@jd.com, 
	zhouzihan30@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 at 08:06, zhouzihan30 <15645113830zzh@gmail.com> wrote:
>
> From: zhouzihan <zhouzihan30@jd.com>
>
> Thank you very much for your reply, which has brought me lots
>  of thoughts.
>
> I have reconsidered this issue and believe that the root cause is that
>  the kernel is difficult and unnecessary to implement an ideal eevdf
>  due to real hardware:
> for example,
> an ideal eevdf may bring frequent switching, its cost makes kernel can't
>  really do it.
>
> So I see that the kernel has a very concise and clever implementation:
>  update_deadline, which allows each task to use up the request size
>  as much as possible in one go.
>
> Here, the kernel has actually slightly violated eevdf: we are no longer
>  concerned about whether a task is eligible for the time being.
>
> In the prev patch, it was mentioned that due to tick errors, some tasks
>  run longer than requested. So if we can do this: when a task vruntime

Could you give more details about the tick error ?

Could it be that you have irq accounting enabled  ? In this case the
delta_exec will always be lower than tick because of the time spent in
the irq context. As an example, the delta of rq_clock_task is always
less than 1ms on my system but the delta of rq_clock is sometimes
above and sometime below 1ms

This means that the task didn't effectively get its slice because of
time spent in IRQ context. Would it be better to set a default slice
slightly lower than an integer number of tick



>  approaches the deadline, we check if the task is eligible.
> If it is eligible, we follow the previous logic and do not schedule it.
> However, if it is ineligible, we schedule it because eevdf has the
>  responsibility to not exec ineligible task.
>
> In other words, the kernel has given the task a "benefit" based on the
>  actual situation, and we still have the right to revoke this benefit.
>
> In this way, it actually brings the kernel closer to an ideal eevdf,
> and at the same time, your reply made me realize my mistake:
> The deadline update should be updated using the following function,
> which is more reasonable:
>     vd_i +=3D r_i / w_i
> By using it, our scheduler is still fair,
>  and each task can obtain its own time according to its weight.
>
> About tolerance, I think min(vslice/128, tick/2) is better,
> as your reply, vslice maybe too big, so use it.
>
> However, there is still a new issue here:
> If a se 1 terminates its deadline prematurely due to ineligible,
> and then a se 2 runs, after the end of the run,
> se 1 becomes eligible, but its deadline has already been pushed back,
> which is not earliest eligible,
> so se 1 can't run. This seems to not comply with eevdf specifications.
>
> But I think this is acceptable. In the past, the logic causes a task to
>  run an extra tick (ms), which means other tasks have to wait for an
>  extra tick. Now, a task maybe run less time (us), but it will be
>  compensated for in the next scheduling. In terms of overall accuracy,
>  I think it has improved.
>
> By the way, we may try to solve this by delaying the deadline update,
> which means we schedule a task but not update its deadline,
> util next exec it.
> I am not sure if it is necessary to implement such complex logic here.
> I think it is actually unnecessary,
> because the ideal eevdf may not be suitable for the kernel.
> It is no need to spend so much to solve the error of few time.
> If there is a truly completely accurate system, it should not have
>  tick error, and just closes the FORWARD_DEADLINE feature.
> Of course, if you think it is necessary, I am willing try to implement it=
.
>
> Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
> ---
>  kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/features.h |  7 +++++++
>  2 files changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d16c8545c71..e6e58c7d6d4c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1006,8 +1006,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, s=
truct sched_entity *se);
>   */
>  static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *=
se)
>  {
> -       if ((s64)(se->vruntime - se->deadline) < 0)
> -               return false;
> +
> +       u64 vslice;
> +       u64 tolerance =3D 0;
> +       u64 next_deadline;
>
>         /*
>          * For EEVDF the virtual time slope is determined by w_i (iow.
> @@ -1016,11 +1018,42 @@ static bool update_deadline(struct cfs_rq *cfs_rq=
, struct sched_entity *se)
>          */
>         if (!se->custom_slice)
>                 se->slice =3D sysctl_sched_base_slice;
> +       vslice =3D calc_delta_fair(se->slice, se);
> +
> +       next_deadline =3D se->vruntime + vslice;
> +
> +       if (sched_feat(FORWARD_DEADLINE))
> +               tolerance =3D min(vslice>>7, TICK_NSEC/2);
> +
> +       if ((s64)(se->vruntime + tolerance - se->deadline) < 0)
> +               return false;
>
>         /*
> -        * EEVDF: vd_i =3D ve_i + r_i / w_i
> +        * when se->vruntime + tolerance - se->deadline >=3D 0
> +        * but se->vruntime - se->deadline < 0,
> +        * there is two case: if entity is eligible?
> +        * if entity is not eligible, we don't need wait deadline, becaus=
e
> +        * eevdf don't guarantee
> +        * an ineligible entity can exec its request time in one go.
> +        * but when entity eligible, just let it run, which is the
> +        * same processing logic as before.
>          */
> -       se->deadline =3D se->vruntime + calc_delta_fair(se->slice, se);
> +
> +       if (sched_feat(FORWARD_DEADLINE) && (s64)(se->vruntime - se->dead=
line) < 0) {
> +               if (entity_eligible(cfs_rq, se)) {
> +                       return false;
> +               } else {
> +                       /*
> +                        * in this case, entity's request size does not u=
se light=EF=BC=8C
> +                        * but considering it is not eligible, we don't n=
eed exec it.
> +                        * and we let vd_i +=3D r_i / w_i, make scheduler=
 fairness.
> +                        */
> +                       next_deadline =3D se->deadline + vslice;
> +               }
> +       }
> +
> +
> +       se->deadline =3D next_deadline;
>
>         /*
>          * The task has consumed its request, reschedule.
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 290874079f60..5c74deec7209 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -24,6 +24,13 @@ SCHED_FEAT(RUN_TO_PARITY, true)
>   */
>  SCHED_FEAT(PREEMPT_SHORT, true)
>
> +/*
> + * For some cases where the tick is faster than expected,
> + * move the deadline forward
> + */
> +SCHED_FEAT(FORWARD_DEADLINE, true)
> +
> +
>  /*
>   * Prefer to schedule the task we woke last (assuming it failed
>   * wakeup-preemption), since its likely going to consume data we
> --
> 2.39.3 (Apple Git-146)
>


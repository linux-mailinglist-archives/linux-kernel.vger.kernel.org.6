Return-Path: <linux-kernel+bounces-232654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019491AC63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738011C221CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F105199398;
	Thu, 27 Jun 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml1ceOQW"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FB196438
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504916; cv=none; b=uA8mU5DsbMSmfFFySKt5S34tDIKxF7c6MNyXL8cuWeH/IBe3+8IvZEQ9P9XbBz2TryrqoGKTRuiIdmOtfZ8Xect9DYlUHYhBjO1xc+5C6btEvoITyMxFDUwQMhny6wQkqSOLx+IbqVmOcjQG9AHT7XFUN+GDV3WDNJKMpNOnQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504916; c=relaxed/simple;
	bh=yihghbE7k8cmoGhccq9Cc/jTeWhsUT1cU5ZnE8H7yYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EapM2xGTQ/GweSddJub0o2tSwF3cCggzCZlXdnziOqk/vyRwHu7IysQLuJnGv50rtgMb5Aq38VQfHO0gwCaO7tE4xkKVQDhttXHTXlIDlEljK6lDWZsBWv9KEF3SIYYh54PfYoD+KxKLHxGrd7QJRyeECZMfEEInLQAFpgS9KjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ml1ceOQW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7276c331f78so521218a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719504913; x=1720109713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBw1X3AoVYwdLrbyici3/EE5nEsBYY1hxUhSJ7z0b0g=;
        b=Ml1ceOQWsMcTfT3WAHOTOUQSv0SXg9HJsCmZI/YuNzQLdRHVDMkJWM4cHtpmi66F/Z
         odPv4CH7C+BwHLmg9ofTrYKraeUaPvvxY4i39qlGehrtWvA8r8AY0sSUFATcR7l4zZ2P
         K1I9kTx3rpe4wSNoTsunVbo9y3896LmqcQdjsC6xYeEdn1EiMhdxkyVsSfloyiX4PjDR
         ++95mAWkdNENc2pfu6Xslpv5asnl71sY6bFqDeXtr/hsUyXsBK9NfK8QCZgv4xgmyYJh
         OhrBW3utRc2DwLo3aN1ra2QDv7Koa9wU7Mv9EeQSeIsi0dGHksJ4lvLlHlbeypnaRLQy
         1vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719504913; x=1720109713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBw1X3AoVYwdLrbyici3/EE5nEsBYY1hxUhSJ7z0b0g=;
        b=FVBMWzskVd8Q6PC5KWQgY6eAJdd3GYut5QINQ8c20ArraUHXnTf+Nb8lQpsje8U1gC
         CjT8ZP1A1FXV1v+i3UHdP4WPJL8OEc0geTLOcQZQsbjIE1y9ZSfTAKHES637fGslFV7Y
         Xb629JQSG5tYazGpcEqa/64BxZgmxhevdFSLzzQkug5twDCUqWswDqILuy7ret5+NBTc
         UXR5+VbFAMPF6fPFwTIRxLG8INmp+mGiSPITppqGLLLgh15bTSiOisO535eoxz75mUlx
         8yNlNyPU4vP9guiHhebfZZoKVP/9wBw+OACStnRGQZloRIq50MMwtezxvDKAGxS0vpJl
         yNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW50OCcm2b/78cbdIspxiibcYgmt+QApOZYjwkbt0peMnNNe2CUZQ61E9pFwtEadp/MKtp+Y8gP6pSgk5GzEIaEbSiAvLSbRo9X0/o3
X-Gm-Message-State: AOJu0YxQPQffvz4bdW2FkjHTFU+mAoZBdGNJH6zkdb1dss+CKl4fyO6Y
	E48/qlUugwgcWK/QXf89vG1P5oLFQucupXJJVuBs8uovz//rnrILnoqe/rdZ1UeHbOedgBCGsSe
	pxVtYzahoG/TgzWufKgtrDUY7007xuPRz5Lht3kSZRgvMvpJjjZo=
X-Google-Smtp-Source: AGHT+IE3Ev3H7lfYxe+nJe5F3B4fegFoOeQ1Pp8V/Xau7KBdCIood2OMx1EOdp5bILMzApW1H37VJOs8Id+lyVzXZCg=
X-Received: by 2002:a17:90a:b106:b0:2c6:f5bf:5175 with SMTP id
 98e67ed59e1d1-2c8a2358c37mr13369193a91.10.1719504913047; Thu, 27 Jun 2024
 09:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com> <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
In-Reply-To: <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 27 Jun 2024 18:15:01 +0200
Message-ID: <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, qyousef@layalina.io, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, christian.loehle@arm.com, vincent.donnefort@arm.com, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jun 2024 at 04:02, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> On Tue, Jun 25, 2024 at 9:05=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> > >
> > > Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective uti=
lization in feec()")
> > > changed the PD's util from per-CPU to per-PD capping. But because
> > > the effective_cpu_util() would return a util which maybe bigger
> > > than the actual_cpu_capacity, this could cause the pd_busy_time
> > > calculation errors.
> >
> > I'm still not convinced that this is an error. Your example used for v1=
 is :
> >
> > The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> > of cpufreq-limit, the cpu_actual_cap =3D 512.
> >
> > Then the eenv->cpu_cap =3D 512, the eenv->pd_cap =3D 2048;
> > effective_cpu_util(4) =3D 1024;
> > effective_cpu_util(5) =3D 1024;
> > effective_cpu_util(6) =3D 256;
> > effective_cpu_util(7) =3D 0;
> >
> > so env->pd_busy_time =3D 2304
> >
> > Even if effective_cpu_util(4) =3D 1024; is above the current max comput=
e
> > capacity of 512, this also means that activity of cpu4 will run twice
> > longer . If you cap effective_cpu_util(4) to 512 you miss the
> > information that it will run twice longer at the selected OPP. The
> > extreme case being:
> > effective_cpu_util(4) =3D 1024;
> > effective_cpu_util(5) =3D 1024;
> > effective_cpu_util(6) =3D 1024;
> > effective_cpu_util(7) =3D 1024;
> >
> > in this case env->pd_busy_time =3D 4096
> >
> > If we cap, we can't make any difference between the 2 cases
> >
> > Do you have more details about the problem you are facing ?
>
> Because of the cpufreq-limit, the opp was also limited, and when compute_=
energy:
>
> energy =3D  ps->cost * sum_util =3D  ps->cost * eenv->pd_busy_time;
>
> Because of the cpufreq-limit, the ps->cost is the limited-freq's opp's
> cost instead of the max freq's cost.
> So the energy is determined by pd_busy_time.
>
> Still the example above:
>
> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> of cpufreq-limit, the cpu_actual_cap =3D 512.
>
> Then the eenv->cpu_cap =3D 512, the eenv->pd_cap =3D 2048;
> effective_cpu_util(4) =3D 1024;
> effective_cpu_util(5) =3D 1024;
> effective_cpu_util(6) =3D 256;
> effective_cpu_util(7) =3D 0;
>
> Before the patch:
> env->pd_busy_time =3D min(1024+1024+256, eenv->pd_cap) =3D 2048.
> However, because the effective_cpu_util(7) =3D 0, indeed, the 2048 is big=
ger than
> the actual_cpu_cap.
>
> After the patch:
> cpu_util(4) =3D min(1024, eenv->cpu_cap) =3D 512;
> cpu_util(5) =3D min(1024, eenv->cpu_cap) =3D 512;
> cpu_util(6) =3D min(256, eenv->cpu_cap) =3D 256;
> cpu_util(7) =3D 0;
> env->pd_busy_time =3D min(512+512+256, eenv->pd_cap) =3D 1280.
>
> As a result, without this patch, the energy is bigger than actual_energy.
>
> And even if cpu4 would run twice longer, the energy may not be equal.
> Because:
>  *             ps->power * cpu_max_freq
> *   cpu_nrg =3D ------------------------ * cpu_util           (3)
> *               ps->freq * scale_cpu
>
> the ps->power =3D cfv2, and then:
>
> *                  cv2 * cpu_max_freq
> *   cpu_nrg =3D ------------------------ * cpu_util           (3)
> *                    scale_cpu
>
> because the limited-freq's voltage is not equal to the max-freq's voltage=
.

I'm still struggling to understand why it's wrong. If the frequency is
capped, we will never go above this limited frequency and its
associated voltage so there is no reason to consider max-freq's
voltage. If there is more things to do than the actual capacity can do
per unit of time then we will run more than 1 unit of time.

nrg of PD =3D /Sum(cpu) ps->power * cpu-running-time

ps->power is fixed because of the limited frequency constraint

we estimate cpu-running-time =3D utilization / ps->performance
with
- utilization =3D util_avg
- performance =3D ps->freq / cpu_max_freq * arch_scale_cpu_capacity() =3D
ps->performance

Up to now we were assuming that utilization was always lower than
performance otherwise the system was overutilized andwe fallback in
performance mode. But when the frequency of a cpu is limited by
userspace or thermal mitigation, the utilization can become higher
than the limited capacity which can be translated by cpu will run
longer.

>
> >
> >
> >
> > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > the actual_cpu_capacity.
> > >
> > > Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective uti=
lization in feec()")
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> > > V2:
> > > - change commit message.
> > > - remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
> > > - add Tested-by.
> > > ---
> > >  kernel/sched/fair.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8a5b1ae0aa55..5ca6396ef0b7 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct e=
nergy_env *eenv,
> > >                                      struct cpumask *pd_cpus,
> > >                                      struct task_struct *p)
> > >  {
> > > -       unsigned long busy_time =3D 0;
> > >         int cpu;
> > >
> > > +       eenv->pd_busy_time =3D 0;
> > > +
> > >         for_each_cpu(cpu, pd_cpus) {
> > >                 unsigned long util =3D cpu_util(cpu, p, -1, 0);
> > >
> > > -               busy_time +=3D effective_cpu_util(cpu, util, NULL, NU=
LL);
> > > +               util =3D effective_cpu_util(cpu, util, NULL, NULL);
> > > +               util =3D min(eenv->cpu_cap, util);
> > > +               eenv->pd_busy_time +=3D util;
> > >         }
> > > -
> > > -       eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.25.1
> > >
> > >


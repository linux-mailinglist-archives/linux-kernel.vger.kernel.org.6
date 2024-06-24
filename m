Return-Path: <linux-kernel+bounces-226572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84560914082
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B231C20C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A6A4A3D;
	Mon, 24 Jun 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gODkc2+O"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F982907
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719196076; cv=none; b=IXk1pdUCj0sJjRj44reW6tiurS+e4+3SyOJYMwrlQxjYhCB7bO6rMYnrC6NTETCth9i17G2ATzULaXEYtyWRGSlobNsUNnyaSMcZM1sGCulIjiqhxtcv9mXfsIo2muW5pHOJzxwMATph+gxYqVBSh0VFOgcfsbuYc0NxKSKcUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719196076; c=relaxed/simple;
	bh=UKxYcObFao3qzx/T5bA6vbIn9Qt24lVGgYltISzHnxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQzlKuekw9CcrJnoFnuqsGIg0LGaBZvB1/L8h0wbvZ/XfC88QfEtDAmFcb23jO4Kf39/wH1/qBiTXEH6ULSJeARSOeJftY20wiutUAo508FzEph0WXeYISnqn23mNPF+Vnl+lhi7Ey5I4p7irA8zXUda6FUAKLBpIem1F5YifAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gODkc2+O; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25cae7464f5so2024211fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719196074; x=1719800874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbM0M3xFp82MhHgj2eYSTEpJG54F7AfyDipiSq/qsYo=;
        b=gODkc2+OAkNfH5/t0xQhfnAAUOjf7SsKHqbpltdScsN+wDhKmRWi4jZUDlBDmy3jzA
         Bdho5gB7V8MZew46dPoxux2eejp3Bg+TPHSU/3IEjyMvhuXzl2Ll7wB0JwuJmeiOn2ms
         f7B9u/S3mEdsc0wsKrdLHBeb73kE0fRZhJVynj0/ms8Dxv/fl3yCzYxEtPkdkhpyTLMC
         N1Lf4h5Okt171MZR6nviLWarmjfg9iMx7g3aF0XwOouZCN0masqFxgEsK2rT609rNXcS
         7GobZyZh9lwfKZ0QqhBOeS6Xh7QVYId4jRiX1hN7AwBVaj5ct7AB+R5PLiWoHyl/XBIc
         9r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719196074; x=1719800874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbM0M3xFp82MhHgj2eYSTEpJG54F7AfyDipiSq/qsYo=;
        b=nGNfxgVKQ7ZddPUMMUTUrGQoX5va9lNypl8HRWAGxiJRKI5VfNqK+Yi3TSWgCd+04g
         CbuhtWaPmPuFMhN4Jk04X9RhQijyFM5wWRNpPSaFnI2hR2mPE6N9bEk00GfCMZR6iFvf
         XXA5jslbYBAndBqRyQXvLHw/AAelu1YUZHj8nU1+ULz1hUOMmen3qZ6rStedpw9heSb4
         mF1TS0ccHK7xGD/Bv+z2LULrK3lWEErcacmCeARNMU4WGceX8IvRN9JO2qMbgo+ZrlMN
         3XRF8tIIzkbB1E+rDBaq5Igkw/09uUg+Efsc8qisABQEDgSQBwAogeOKTfcF9XTIsFD/
         iUSw==
X-Forwarded-Encrypted: i=1; AJvYcCUeS4j3E7nM+6+V4/BULkhM0X0F+dDwMsxizWBJEY8kKU8C/ITVJbbsKyUzWfkTDSwHNDF9RcjAUvj1CxZQdRXjCmce81GCOtK2DX56
X-Gm-Message-State: AOJu0YwB4rj9//exT5HRZ7UjdhA+hEfb6ZXNJlXpyq3/J5rt+n5YIYOR
	pskvbGAabsfQxe+tqYSeiqUuGQfU8vOwtIKK0GBAo84kZR2d5bm/2GTuN0DGYNrjYieQoJKHbCJ
	Gvou4nTNPD7pqjn8tEPORcdvVDVw=
X-Google-Smtp-Source: AGHT+IH5XYL8JDHqNtJssU3Kdb0goHyqvf4dAwn9vsbndf14L7w9MQsAN/jlLcBaEWeMFu/VVRc2X//cH5yQWQnWMbs=
X-Received: by 2002:a05:6871:587:b0:254:b91b:ad52 with SMTP id
 586e51a60fabf-25d06e57b70mr3767981fac.45.1719196073927; Sun, 23 Jun 2024
 19:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <0763f870-e30c-46cf-aefa-b879f2ebdba4@arm.com>
 <CAB8ipk_TjqoNetBZ7dbjRxuBHAP=nz9=ZNomnjnaCEikLQSK2A@mail.gmail.com>
 <64115627-c6c7-416b-99f9-0df22cbdca6b@arm.com> <CAB8ipk-86-oJJ2XhJ2y5=ek3QwmMe0OJ+ry9FddmXrrChqu6+A@mail.gmail.com>
 <e2fdb89d-7594-4025-8e20-299dddc80497@arm.com>
In-Reply-To: <e2fdb89d-7594-4025-8e20-299dddc80497@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 24 Jun 2024 10:27:43 +0800
Message-ID: <CAB8ipk-rDR+06mMWgfzGupm8PK=hgtXn2gsZUGVnXuw2YkkesA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	vincent.donnefort@arm.com, qyousef@layalina.io, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:22=E2=80=AFPM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 07/06/2024 12:37, Xuewen Yan wrote:
> > On Fri, Jun 7, 2024 at 6:30=E2=80=AFPM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 07/06/2024 10:20, Xuewen Yan wrote:
> >>> Hi Dietmar
> >>>
> >>> On Fri, Jun 7, 2024 at 3:19=E2=80=AFPM Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 06/06/2024 09:06, Xuewen Yan wrote:
> >>>>> Because the effective_cpu_util() would return a util which
> >>>>> maybe bigger than the actual_cpu_capacity, this could cause
> >>>>> the pd_busy_time calculation errors.
> >>>>
> >>>> Doesn't return effective_cpu_util() either scale or min(scale, util)
> >>>> with scale =3D arch_scale_cpu_capacity(cpu)? So the util sum over th=
e PD
> >>>> cannot exceed eenv->cpu_cap?
> >>>
> >>> In effective_cpu_util, the scale =3D arch_scale_cpu_capacity(cpu);
> >>>  Although there is the clamp of eenv->pd_cap, but let us consider the
> >>> following simple scenario:
> >>> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> >>> of cpufreq-limit,
> >>
> >> Ah, this is due to:
> >>
> >> find_energy_efficient_cpu()
> >>
> >>    ...
> >>    for (; pd; pd =3D pd->next)
> >>        ...
> >>        cpu_actual_cap =3D get_actual_cpu_capacity(cpu)
> >>
> >>        for_each_cpu(cpu, cpus)
> >>            ...
> >>            eenv.pd_cap +=3D cpu_actual_cap
> >>
> >> and:
> >>
> >> get_actual_cpu_capacity()
> >>
> >>    ...
> >>    capacity =3D arch_scale_cpu_capacity(cpu)
> >>
> >>    capacity -=3D max(hw_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cp=
u))
> >>
> >> which got introduced by f1f8d0a22422 ("sched/cpufreq: Take cpufreq
> >> feedback into account").
> >
> > I don't think it was introduced by f1f8d0a22422, because f1f8d0a22422
> > just replaced the cpu_thermal_cap with get_actual_cpu_capacity(cpu).
> > The eenv.cpu_cap was  introduced by 3e8c6c9aac42 ("sched/fair: Remove
> > task_util from effective utilization in feec()").
>
> Yes, you're right. 3e8c6c9aac42 changed it from per-CPU to per-PD
> capping.
>
> In case we want to go back to per-CPU then we should remove the
> eenv->pd_cap capping in eenv_pd_busy_time().
>
> -->8--
>
> @@ -7864,16 +7864,15 @@ static inline void eenv_pd_busy_time(struct energ=
y_env *eenv,
>                                      struct cpumask *pd_cpus,
>                                      struct task_struct *p)
>  {
> -       unsigned long busy_time =3D 0;
>         int cpu;
>
>         for_each_cpu(cpu, pd_cpus) {
>                 unsigned long util =3D cpu_util(cpu, p, -1, 0);
>
> -               busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL);
> +               util =3D effective_cpu_util(cpu, util, NULL, NULL);
> +               util =3D min(util, eenv->cpu_cap);
> +               eenv->pd_busy_time +=3D util;
>         }
> -
> -       eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
>  }

Okay, the pd-busy clamp is indeed unnecessary.

>
>
>
> I'm wondering whether we would need the:
>
> if (dst_cpu >=3D 0)
>     busy_time =3D min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>
> in compute_energy() anymore since we only get a candidate CPU in feec()
> after checking with util_fits_cpu() if cpu can accommodate p :

I think this condition is still necessary, because pd_busy_time is
clamped. If this condition is not added, util may exceed
actual_cpu_cap.

>
> feec()
>
>     ...
>
>     for_each_cpu()
>
>         util =3D cpu_util(cpu, p, cpu, ...)
>         cpu_cap =3D capacity_of()
>
>         ...
>
>         fits =3D util_fits_cpu(util, ..., cpu);
>         if (!fits)
>             continue
>
>         /* check if candidate CPU */


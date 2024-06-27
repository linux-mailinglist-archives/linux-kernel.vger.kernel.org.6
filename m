Return-Path: <linux-kernel+bounces-231738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC9919D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B911282EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B96AC0;
	Thu, 27 Jun 2024 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P553W24E"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B76E556
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453758; cv=none; b=PP2VTNqpmATPg381yGI+epgE3u95UzCTZWPayrVYOMoZZREtD7t7LYEk3tvPKVl7Hn3Fl4FskKYGllrwCjSO4Qi5Qtz4OQkyBFvEvxCDIK/a7/VcwC33VLDqxtKLgcGcw/aEApget5kjyNCDggRiZmBrbP8Xs6MRnviGyFHGdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453758; c=relaxed/simple;
	bh=BJv6Ouu2XrOzSJzDpWNks1X6KhjxYC/Uyi215ZOvf6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T32PVS5EOB1DkAix1j2g+opgF+defCz2vWqeZCUHeo/IfjvPRZ14F1LQTHdiJ64wnjXKOICXHTyLzWLz3Sh7RbiaxIzdcHZLvI0mz0aXv0+k7lLteRsKaLIJOloTSFowwwdGua5H3asqSrSgVcPQBuj59rXYgsyWaCbL9L6lXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P553W24E; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c0dbd2866so3781598fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719453755; x=1720058555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7HkyVgEil1i4DZF+gFUxMu5A4EDhjycWrMLLVNk3KA=;
        b=P553W24E7ERIAFQb0usncgzq/vWHzJLcUnm12cPdkvWwxb+4bZXJbdDaltkrJsRzIm
         6PA1ZI1Nub0agQb1QSRgd3XNdrawH8FimGfu5nMCOj0yQrLezIOKaU9LyneKjLoTInBX
         e7vEcOaCLnyPXGwPZd4cyy3hJQ4yLBzVDTSHwtvyKvtoQfOR9KNZEYU/N5mU1ZPkLpxH
         5PmLbwbGqYbCdK7FbJIYdP4ul7jGq9dBiv/17ACwZ4QKzfXECstVQILnuobUiAi8+cBK
         CnpJzQVIGmHZJJ3udGrnXAfaW9y5lyXpWtpqhbn/3s4cJ0BXkaMbEkrNqAO/JMGhZqFI
         bO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719453755; x=1720058555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7HkyVgEil1i4DZF+gFUxMu5A4EDhjycWrMLLVNk3KA=;
        b=q9XOitznuDYZB03UwMgCulEInt1Yqki5hOrFP9cH3+WjaYrLpkCgATkf/s53r9tbI7
         a2aerP2kjM+J6+NyEP8+zkkKTiq8tc8yN2keu5Oj2HL28qQSEIsKzECGzj7dUsjivoDZ
         xMmEAH8z1VhHMsJNb9qlHWrl1RDQ/UPLvrJgAY/+XYFiCcVX+uMoaxzxURZQnvMgPlIk
         c8tCkeXXjcJplU7AD5d0AKvvq6N69nKRFmyPLUrKCVmq/NzA2vrz8/hoH5SSOxEC6jRT
         vngrUfKg5/FRWGSFEGZr2iB+30qzWvnwEEW7B9TROkqv7Sjg8ZeXElEZXS01CTb8XwLK
         uEEw==
X-Forwarded-Encrypted: i=1; AJvYcCXqeceIVfumr5L03pTnjav2uWr3Tdefl25vA5t5SHyajMTZCy6NCn6zaA6XIcftxbGcuA00xc7cVg1WikNbC40LcnXBBP2R8B2Sd0ci
X-Gm-Message-State: AOJu0Yy+Ghe3Yd6Vxn//GEPvdteV7Fjf31AozcyGUYD0Bb6srO/z9PWc
	GTqi7xF08CwhRzaH+Tqgerft/W0hvgiSpfm65G31E13oJ8HPbrX+E69asHCn19MvkQPpC9YCnh6
	XgRd4QnBwvD2T6d+peB2kDT/6KN4=
X-Google-Smtp-Source: AGHT+IHjIDTJvYZUeiR73WCVoKARTWyv2BpU3BARIjaKuBmztK+Gfix+2S+/nNj0sGjcIOg1eHdJCWGw2knmXYKlrXo=
X-Received: by 2002:a05:6870:148f:b0:254:8f8b:719b with SMTP id
 586e51a60fabf-25cfcf3900fmr13003484fac.37.1719453755287; Wed, 26 Jun 2024
 19:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
In-Reply-To: <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 27 Jun 2024 10:02:24 +0800
Message-ID: <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, qyousef@layalina.io, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, christian.loehle@arm.com, vincent.donnefort@arm.com, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:05=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> >
> > Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utili=
zation in feec()")
> > changed the PD's util from per-CPU to per-PD capping. But because
> > the effective_cpu_util() would return a util which maybe bigger
> > than the actual_cpu_capacity, this could cause the pd_busy_time
> > calculation errors.
>
> I'm still not convinced that this is an error. Your example used for v1 i=
s :
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
> so env->pd_busy_time =3D 2304
>
> Even if effective_cpu_util(4) =3D 1024; is above the current max compute
> capacity of 512, this also means that activity of cpu4 will run twice
> longer . If you cap effective_cpu_util(4) to 512 you miss the
> information that it will run twice longer at the selected OPP. The
> extreme case being:
> effective_cpu_util(4) =3D 1024;
> effective_cpu_util(5) =3D 1024;
> effective_cpu_util(6) =3D 1024;
> effective_cpu_util(7) =3D 1024;
>
> in this case env->pd_busy_time =3D 4096
>
> If we cap, we can't make any difference between the 2 cases
>
> Do you have more details about the problem you are facing ?

Because of the cpufreq-limit, the opp was also limited, and when compute_en=
ergy:

energy =3D  ps->cost * sum_util =3D  ps->cost * eenv->pd_busy_time;

Because of the cpufreq-limit, the ps->cost is the limited-freq's opp's
cost instead of the max freq's cost.
So the energy is determined by pd_busy_time.

Still the example above:

The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
of cpufreq-limit, the cpu_actual_cap =3D 512.

Then the eenv->cpu_cap =3D 512, the eenv->pd_cap =3D 2048;
effective_cpu_util(4) =3D 1024;
effective_cpu_util(5) =3D 1024;
effective_cpu_util(6) =3D 256;
effective_cpu_util(7) =3D 0;

Before the patch:
env->pd_busy_time =3D min(1024+1024+256, eenv->pd_cap) =3D 2048.
However, because the effective_cpu_util(7) =3D 0, indeed, the 2048 is bigge=
r than
the actual_cpu_cap.

After the patch:
cpu_util(4) =3D min(1024, eenv->cpu_cap) =3D 512;
cpu_util(5) =3D min(1024, eenv->cpu_cap) =3D 512;
cpu_util(6) =3D min(256, eenv->cpu_cap) =3D 256;
cpu_util(7) =3D 0;
env->pd_busy_time =3D min(512+512+256, eenv->pd_cap) =3D 1280.

As a result, without this patch, the energy is bigger than actual_energy.

And even if cpu4 would run twice longer, the energy may not be equal.
Because:
 *             ps->power * cpu_max_freq
*   cpu_nrg =3D ------------------------ * cpu_util           (3)
*               ps->freq * scale_cpu

the ps->power =3D cfv2, and then:

*                  cv2 * cpu_max_freq
*   cpu_nrg =3D ------------------------ * cpu_util           (3)
*                    scale_cpu

because the limited-freq's voltage is not equal to the max-freq's voltage.

>
>
>
> > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > the actual_cpu_capacity.
> >
> > Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utili=
zation in feec()")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> > V2:
> > - change commit message.
> > - remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
> > - add Tested-by.
> > ---
> >  kernel/sched/fair.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a5b1ae0aa55..5ca6396ef0b7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct ene=
rgy_env *eenv,
> >                                      struct cpumask *pd_cpus,
> >                                      struct task_struct *p)
> >  {
> > -       unsigned long busy_time =3D 0;
> >         int cpu;
> >
> > +       eenv->pd_busy_time =3D 0;
> > +
> >         for_each_cpu(cpu, pd_cpus) {
> >                 unsigned long util =3D cpu_util(cpu, p, -1, 0);
> >
> > -               busy_time +=3D effective_cpu_util(cpu, util, NULL, NULL=
);
> > +               util =3D effective_cpu_util(cpu, util, NULL, NULL);
> > +               util =3D min(eenv->cpu_cap, util);
> > +               eenv->pd_busy_time +=3D util;
> >         }
> > -
> > -       eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
> >  }
> >
> >  /*
> > --
> > 2.25.1
> >
> >


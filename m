Return-Path: <linux-kernel+bounces-236201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C597791DEAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32182B23589
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332F6F077;
	Mon,  1 Jul 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArneQlzn"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9314E2C2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835242; cv=none; b=fIWW9NnZBpa5P6mAVmCqI8bYPR4PDg1rP2jFCbru6aIMihwSVSPZNdmAf0UhMz78tv7fGhgAIPuUgyADEoxvrmf6srZhCrUhG/QqzfoBFYS+EsYtb5VshPaRORGYIgyMml/lgMHRwB73IerQhZqIy3Gze04KMtOdSM/C6xi4EpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835242; c=relaxed/simple;
	bh=ukdj78NRnFqxqk9l87WICfrpOailevHG6DFkBfKDCaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQwv9jcx2Z/tKdibSDS4KR2rwYzlfgoOFaLQB82dqhC7i3wSoG01MVwaz1AzOEDq6pKqWgRVzOXB7WDqmV8h/6DuuPyJzb1ARDRCxXGp6tnxkFvTBYomJFOVe93hqHJgOlPhQ78kV3wvDiRlKsmGQHJGG5IXpL8dB05UgDs38aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArneQlzn; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d55e2e0327so1634407b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719835239; x=1720440039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp91pDNdhWQ3cGod46Z5Qxap734Ya/j7XEnZ/uo6ceE=;
        b=ArneQlznwQr8G2THOgOwaTemBakgPlivaww44B9jTPZcxDklW33Lunh6fxnPXOE0Hf
         ojRvQ3ZB36cMuQYuIZOm21TojHjGbeC3oXLF7Q7Z+rTw5VJGnY4bP9wQQ6u6Tva+4eZg
         UtjnOlNVOz0l6eqCOypRwCQc7J1AqGgI34ixp60ukettzFTmPJkb53TiN+9tzkZMNwvj
         muXJ94hTaCBeuHx+uauLAVGK+/I8P04wPkUEVtied/S+n+bDEa/6GPGFJKY1hAzLCEnM
         Ym3j7AY3tm+UivA4InjHf+ODHTwL9JUKywfiYA9YWJmiTcZSzxy2gdJWrWKnZd7Ky6SV
         M0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835239; x=1720440039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp91pDNdhWQ3cGod46Z5Qxap734Ya/j7XEnZ/uo6ceE=;
        b=reFjB4fTXiLhlGnJjkQMNBTJfO6704hgJ8ic9MUpKTEpogS862jZVbD4FOWWPGwkBY
         CXI9XaB7CTVXRZt9FIwPQsg+1+8JysCAj6MTKDPCqifXSmkUfxJwkBLErKVxoVQqH/mM
         Wln7YpndWrEP0GWgAAZPaplDPh0IMArETsj6sFFJ3hRg4CKEXxJCv3kZX1tZ1HYNxMaO
         GXM5ODszFW+6rN4AOB7owMR9jMsui2pAU4OwHd5J0IG816Bvn92CN82ro4Z4DuaO9kUM
         pSIt9n9cBMi3MsJK+hVLHtRh89CEdJA0WnIMcD4hNJsJa94ibS6tlxSgT3lwb8GfWYKC
         ezYg==
X-Forwarded-Encrypted: i=1; AJvYcCXUlpEACRB2wHoKhwC0ct9j0Y6NKvUHQU/r61aoOszj3J4GAtIRCHtcC/Disn3WCFJvyUg864YgKY9GkZqmUN9/8SZn3aM3vv4nXc2E
X-Gm-Message-State: AOJu0YwEVtnQw087gT+widYxjZ6R2O639C3uRMHSxV10dLPD5SNJzJ9T
	HmfK9A1i6VOvmJ1GVCFOYM/VDPV21skVnpwQk1J7gykJVbbGqJxOaaN+RLFg7lP5np9DOo7y7Sb
	SzDISa933zZggVsNKAAZx3NeK6kw=
X-Google-Smtp-Source: AGHT+IH5F37P4kBDrQIhzDsuahhlCGESknnnr9FWt8NkuFrHp8sVBju34GK3xb8YA239lLoyW+fO1JuSLcxxyvPzIXk=
X-Received: by 2002:a05:6870:8192:b0:250:3c25:ca61 with SMTP id
 586e51a60fabf-25db33edb8amr5075848fac.6.1719835239191; Mon, 01 Jul 2024
 05:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
 <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com> <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
In-Reply-To: <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 1 Jul 2024 20:00:28 +0800
Message-ID: <CAB8ipk-o-S4epugFa-ViYOW9cpu5Do+M0KRBzEJiDq4k3c=KWg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, qyousef@layalina.io, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, christian.loehle@arm.com, vincent.donnefort@arm.com, 
	ke.wang@unisoc.com, di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:15=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 27 Jun 2024 at 04:02, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 9:05=E2=80=AFPM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrot=
e:
> > > >
> > > > Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective u=
tilization in feec()")
> > > > changed the PD's util from per-CPU to per-PD capping. But because
> > > > the effective_cpu_util() would return a util which maybe bigger
> > > > than the actual_cpu_capacity, this could cause the pd_busy_time
> > > > calculation errors.
> > >
> > > I'm still not convinced that this is an error. Your example used for =
v1 is :
> > >
> > > The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
> > > of cpufreq-limit, the cpu_actual_cap =3D 512.
> > >
> > > Then the eenv->cpu_cap =3D 512, the eenv->pd_cap =3D 2048;
> > > effective_cpu_util(4) =3D 1024;
> > > effective_cpu_util(5) =3D 1024;
> > > effective_cpu_util(6) =3D 256;
> > > effective_cpu_util(7) =3D 0;
> > >
> > > so env->pd_busy_time =3D 2304
> > >
> > > Even if effective_cpu_util(4) =3D 1024; is above the current max comp=
ute
> > > capacity of 512, this also means that activity of cpu4 will run twice
> > > longer . If you cap effective_cpu_util(4) to 512 you miss the
> > > information that it will run twice longer at the selected OPP. The
> > > extreme case being:
> > > effective_cpu_util(4) =3D 1024;
> > > effective_cpu_util(5) =3D 1024;
> > > effective_cpu_util(6) =3D 1024;
> > > effective_cpu_util(7) =3D 1024;
> > >
> > > in this case env->pd_busy_time =3D 4096
> > >
> > > If we cap, we can't make any difference between the 2 cases
> > >
> > > Do you have more details about the problem you are facing ?
> >
> > Because of the cpufreq-limit, the opp was also limited, and when comput=
e_energy:
> >
> > energy =3D  ps->cost * sum_util =3D  ps->cost * eenv->pd_busy_time;
> >
> > Because of the cpufreq-limit, the ps->cost is the limited-freq's opp's
> > cost instead of the max freq's cost.
> > So the energy is determined by pd_busy_time.
> >
> > Still the example above:
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
> > Before the patch:
> > env->pd_busy_time =3D min(1024+1024+256, eenv->pd_cap) =3D 2048.
> > However, because the effective_cpu_util(7) =3D 0, indeed, the 2048 is b=
igger than
> > the actual_cpu_cap.
> >
> > After the patch:
> > cpu_util(4) =3D min(1024, eenv->cpu_cap) =3D 512;
> > cpu_util(5) =3D min(1024, eenv->cpu_cap) =3D 512;
> > cpu_util(6) =3D min(256, eenv->cpu_cap) =3D 256;
> > cpu_util(7) =3D 0;
> > env->pd_busy_time =3D min(512+512+256, eenv->pd_cap) =3D 1280.
> >
> > As a result, without this patch, the energy is bigger than actual_energ=
y.
> >
> > And even if cpu4 would run twice longer, the energy may not be equal.
> > Because:
> >  *             ps->power * cpu_max_freq
> > *   cpu_nrg =3D ------------------------ * cpu_util           (3)
> > *               ps->freq * scale_cpu
> >
> > the ps->power =3D cfv2, and then:
> >
> > *                  cv2 * cpu_max_freq
> > *   cpu_nrg =3D ------------------------ * cpu_util           (3)
> > *                    scale_cpu
> >
> > because the limited-freq's voltage is not equal to the max-freq's volta=
ge.
>
> I'm still struggling to understand why it's wrong. If the frequency is
> capped, we will never go above this limited frequency and its
> associated voltage so there is no reason to consider max-freq's
> voltage. If there is more things to do than the actual capacity can do
> per unit of time then we will run more than 1 unit of time.
>
> nrg of PD =3D /Sum(cpu) ps->power * cpu-running-time
>
> ps->power is fixed because of the limited frequency constraint
>
> we estimate cpu-running-time =3D utilization / ps->performance
> with
> - utilization =3D util_avg
> - performance =3D ps->freq / cpu_max_freq * arch_scale_cpu_capacity() =3D
> ps->performance
>
> Up to now we were assuming that utilization was always lower than
> performance otherwise the system was overutilized andwe fallback in
> performance mode.

Well, with patch2/2,  this patch is no longer needed.
But if we want to remove the restriction of feec() on rd->overutilized
later, this patch should be reconsidered.

> But when the frequency of a cpu is limited by
> userspace or thermal mitigation, the utilization can become higher
> than the limited capacity which can be translated by cpu will run
> longer.
>
> >
> > >
> > >
> > >
> > > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > > the actual_cpu_capacity.
> > > >
> > > > Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective u=
tilization in feec()")
> > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > > ---
> > > > V2:
> > > > - change commit message.
> > > > - remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
> > > > - add Tested-by.
> > > > ---
> > > >  kernel/sched/fair.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 8a5b1ae0aa55..5ca6396ef0b7 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct=
 energy_env *eenv,
> > > >                                      struct cpumask *pd_cpus,
> > > >                                      struct task_struct *p)
> > > >  {
> > > > -       unsigned long busy_time =3D 0;
> > > >         int cpu;
> > > >
> > > > +       eenv->pd_busy_time =3D 0;
> > > > +
> > > >         for_each_cpu(cpu, pd_cpus) {
> > > >                 unsigned long util =3D cpu_util(cpu, p, -1, 0);
> > > >
> > > > -               busy_time +=3D effective_cpu_util(cpu, util, NULL, =
NULL);
> > > > +               util =3D effective_cpu_util(cpu, util, NULL, NULL);
> > > > +               util =3D min(eenv->cpu_cap, util);
> > > > +               eenv->pd_busy_time +=3D util;
> > > >         }
> > > > -
> > > > -       eenv->pd_busy_time =3D min(eenv->pd_cap, busy_time);
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.25.1
> > > >
> > > >


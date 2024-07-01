Return-Path: <linux-kernel+bounces-236215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325691DED4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44A32813D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E3514A0A0;
	Mon,  1 Jul 2024 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9E2m6CW"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EEA14373A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836007; cv=none; b=StFB4+N44d5xJvjGAXROZYZcC6eA+KnMwu4ucEiGaMcb+6egbCsmrf64XBGFeg3omWDpvmLtZ16hqXI02C1qDsSYdhW/eBW0LEvZCrVgEZwiXe7lU3LdtNC6/2lHPvzevoNVxmbaQcO3LjrhBl0+cAO8vSPZ4LIXEu3D3GpbPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836007; c=relaxed/simple;
	bh=bDYmic1FXoGq7jlmHOMll74zWH2WxCkSh+IfmGz3pzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIXxU2Fl6vFmjf1YwsWYU3sOGtqymeqPU2/JGRJCiw4hZ4BxpYe4+eHy48EDi78DOPysbOtUcZ5J9dMsMIeJ0KGl8xIp2wZDzdtCYpq3TTd1D4z+cET05cN02Jl6zrms4IxK/vidhjcPFqaX2L1vUaw+iPaz7wnnHgEBSuTxSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9E2m6CW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c2284616f7so1939897eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836004; x=1720440804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DNN7trhLb/0wTf9+UXZYBheTumE9oV7384hI+GoXms=;
        b=Z9E2m6CWxN5HC1Z1j6oSVl7TfQ29x52+n39EGtz0W/xtzoubrj3LAdLAZsTR/syutE
         NTn5PWDAkbIT+PT/YZJG453dyl5kxBR8vzcACODcJXVYKUs6bUHRUT+ys2UFEJCEDpi5
         EVMefgtfHP9ewg25AYKA4hMGUQehMPJXQbUXTMbLRMRHkx+f/gILsBp3dfZTCRK2w2e6
         2RgApWtZf5/81a41t2gJhzSoN/Xjx2pXI03EGs63PiIPQsnpbnwnMEe21zqbujJ2Ftak
         G0RASUoMn72xnOFBDbvJ/BY0HeC0Xwv4eMzs70QVG93cS9u6jZ8cqkbtaxCc6WeoY/cD
         znUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836004; x=1720440804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DNN7trhLb/0wTf9+UXZYBheTumE9oV7384hI+GoXms=;
        b=DQtfxyu+/uOYxiLPX/QLRlUy2Sy0LwuqLCy0mQNm4boIuWnnV9YK6hZNNb3Sp5NNUq
         WkU3YJNtkUygeblf7A5Bqlhz/duv7Wn32gsSddLmaAWsKnV+3Epn5IK6gsC51IsOjrEl
         55cfFDG7GwBaWirU7GA07sM1L+YXMK/NoQA69DDQD91tTZgRIU3XjT6b82lX36lb1GiG
         oM9tLmYS5GT9NRE+TKQwVszQj+NOajkCOq2Yb6VmKb9XEBYm6azYEJPFpb4olwEIbcoc
         /5OVX37eTU1aaWC32shBaobjf4/9K3VdmFYf7CpTw9DyOePKm94oU8URQn7d9kvNgvJ0
         vSKA==
X-Forwarded-Encrypted: i=1; AJvYcCUSLG9xmWwEMyFN9ObQF/aPCH3hWQF3EaZp0x1yCsyHQV/AByt9QAHyucw5b4bdvVXSTIcndXZ2qb3ShLDM5TAeohZYJr01yLN690Fr
X-Gm-Message-State: AOJu0YyRmZNiQzcWqIx0uKka0Ia12JCcB0XwQZujRdchk8Erc3ogi0D+
	0NwfFm/fJLCc1WMV/n5OgBDWYUguM4eUCPEfIAMAxdvszhvBDjc3pkaUM5Bzpjhj0AvawakNP+Y
	IFlSkKBhjLDnqH0xi50/MgISF5kw=
X-Google-Smtp-Source: AGHT+IHRhqFnNBXVEw2b2Oa7rt9dQO/OndOJPvrPuDJuFwAnUVXXPlOa7LKro7BuU2A0XPfL1ild2yLbg4GlM0pkUOk=
X-Received: by 2002:a05:6870:5688:b0:24c:a8e6:34e7 with SMTP id
 586e51a60fabf-25db348bda7mr4874884fac.26.1719836003922; Mon, 01 Jul 2024
 05:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
In-Reply-To: <20240628012832.37swdtxr4ds2kkp7@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 1 Jul 2024 20:13:12 +0800
Message-ID: <CAB8ipk-p_vT3mq4+BD0AxzgsLiRxpAnHJ1QaTWr1t619JeaL+w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 9:28=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 06/24/24 16:20, Xuewen Yan wrote:
> > Commit f1f8d0a22422 ("sched/cpufreq: Take cpufreq feedback into account=
")
> > introduced get_actual_cpu_capacity(), and it had aggregated the
> > different pressures applied on the capacity of CPUs.
> > And in util_fits_cpu(), it would return true when uclamp_max
> > is smaller than SCHED_CAPACITY_SCALE, althought the uclamp_max
> > is bigger than actual_cpu_capacity.
> >
> > So use actual_cpu_capacity everywhere in util_fits_cpu() to
> > cover all cases.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/fair.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5ca6396ef0b7..9c16ae192217 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4980,7 +4980,7 @@ static inline int util_fits_cpu(unsigned long uti=
l,
> >                               int cpu)
> >  {
> >       unsigned long capacity =3D capacity_of(cpu);
> > -     unsigned long capacity_orig;
> > +     unsigned long capacity_actual;
> >       bool fits, uclamp_max_fits;
> >
> >       /*
> > @@ -4992,15 +4992,15 @@ static inline int util_fits_cpu(unsigned long u=
til,
> >               return fits;
> >
> >       /*
> > -      * We must use arch_scale_cpu_capacity() for comparing against uc=
lamp_min and
> > +      * We must use actual_cpu_capacity() for comparing against uclamp=
_min and
> >        * uclamp_max. We only care about capacity pressure (by using
> >        * capacity_of()) for comparing against the real util.
> >        *
> >        * If a task is boosted to 1024 for example, we don't want a tiny
> >        * pressure to skew the check whether it fits a CPU or not.
> >        *
> > -      * Similarly if a task is capped to arch_scale_cpu_capacity(littl=
e_cpu), it
> > -      * should fit a little cpu even if there's some pressure.
> > +      * Similarly if a task is capped to actual_cpu_capacity, it shoul=
d fit
> > +      * the cpu even if there's some pressure.
>
> This statement is not clear now. We need to be specific since
> actual_cpu_capacity() includes thermal pressure and cpufreq limits.
>
> /even if there's some pressure/even if there is non OPP based pressure ie=
: RT,
> DL or irq/?
>
> >        *
> >        * Only exception is for HW or cpufreq pressure since it has a di=
rect impact
> >        * on available OPP of the system.
> > @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long uti=
l,
> >        * For uclamp_max, we can tolerate a drop in performance level as=
 the
> >        * goal is to cap the task. So it's okay if it's getting less.
> >        */
> > -     capacity_orig =3D arch_scale_cpu_capacity(cpu);
> > +     capacity_actual =3D get_actual_cpu_capacity(cpu);
> >
> >       /*
> >        * We want to force a task to fit a cpu as implied by uclamp_max.
> > @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long uti=
l,
> >        *     uclamp_max request.
> >        *
> >        *   which is what we're enforcing here. A task always fits if
> > -      *   uclamp_max <=3D capacity_orig. But when uclamp_max > capacit=
y_orig,
> > +      *   uclamp_max <=3D capacity_actual. But when uclamp_max > capac=
ity_actual,
> >        *   the normal upmigration rules should withhold still.
> >        *
> >        *   Only exception is when we are on max capacity, then we need =
to be
> > @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long uti=
l,
> >        *     2. The system is being saturated when we're operating near
> >        *        max capacity, it doesn't make sense to block overutiliz=
ed.
> >        */
> > -     uclamp_max_fits =3D (capacity_orig =3D=3D SCHED_CAPACITY_SCALE) &=
& (uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
> > -     uclamp_max_fits =3D !uclamp_max_fits && (uclamp_max <=3D capacity=
_orig);
> > +     uclamp_max_fits =3D (capacity_actual =3D=3D SCHED_CAPACITY_SCALE)=
 && (uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
>
> We should use capacity_orig here. We are checking if the CPU is the max
> capacity CPU.

Maybe we could remove the uclamp_max_fits =3D (capacity_orig =3D=3D
SCHED_CAPACITY_SCALE) && (uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
and just judge the uclamp_max <=3D capacity_actual?

-     uclamp_max_fits =3D (capacity_orig =3D=3D SCHED_CAPACITY_SCALE) &&
(uclamp_max =3D=3D SCHED_CAPACITY_SCALE);
-     uclamp_max_fits =3D !uclamp_max_fits && (uclamp_max <=3D capacity_ori=
g);
+     uclamp_max_fits =3D  (uclamp_max <=3D capacity_actual);


>
> > +     uclamp_max_fits =3D !uclamp_max_fits && (uclamp_max <=3D capacity=
_actual);
> >       fits =3D fits || uclamp_max_fits;
> >
> >       /*
> > @@ -5086,8 +5086,7 @@ static inline int util_fits_cpu(unsigned long uti=
l,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min =3D min(uclamp_min, uclamp_max);
> > -     if (fits && (util < uclamp_min) &&
> > -         (uclamp_min > get_actual_cpu_capacity(cpu)))
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_actual)=
)
> >               return -1;
> >
> >       return fits;
> > --
> > 2.25.1
> >


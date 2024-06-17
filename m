Return-Path: <linux-kernel+bounces-216953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426B90A910
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD118286208
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4EE190682;
	Mon, 17 Jun 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnHJ/6VL"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DD19066E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615236; cv=none; b=fIZFzUiubnC5UFMvfHND5yalQ0CkYlX6WhbAs/ElMMGnyAQGCiaO0WN43EQ/2a3AKFkRAr8PBZGCM72B00Pw4wpWDVR3rZyRt6AvdI1tk0BadEkPjGq1RHX55LGFCO2aOGwW2w4QNjFIMiSXWncYrT2gKjLDPNMeRL6LMeZ3UXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615236; c=relaxed/simple;
	bh=XLzvDF8kZi+U3fNrWuzfEdjxxLWcy1bhGirIeTePGag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnheyJ+5QBpKN6tBtHwup4SAj8yeqezEsNmJy3i7IELdEVjNsAH6E0krfii6YvHondVOMpkbahtljLt/LUiQnpslBNTSsdnttg7d8hBVhnKSwj/z8jc6cg05AnitzBrsGxpegnS+7xEUnP9xNhqjqzZaRBPVJo7j9xsUpGJL0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bnHJ/6VL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso2297964a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718615235; x=1719220035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQNdxrT0o28pFzAhuYz7lp7AFwXeu1279bets+icafI=;
        b=bnHJ/6VL5bpjb+dJn5jrhqQBWowlgmd1CYusPJn/kxnGyGboTtEC8NpPyXejINzugv
         GlyevS7KqBrHCvPRulnF63dSC/ZKTJSQoha3jmIJaH3+jUg1XPLBQbjQekc3caSCTLR9
         bMUQwKFcxn2cWNC3YtiJYUj22SygbSZjIekTa5AyMLslBLK6AM/c6xIhMu3FGvFBDRu4
         l2Xpltb3Vq4c42CuRFAuwTCYPXinbbNzFaw2do2XbsuscUKB8+DCY70khaiahDVHxgvj
         n5M+pN7DLPXOOprv6kDP0UNMug4rWELFZomo/fC50VzL/CB4voT1BrRqhfg/8gxn7O5O
         x3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615235; x=1719220035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQNdxrT0o28pFzAhuYz7lp7AFwXeu1279bets+icafI=;
        b=nmJYWCksoBVeeG05gWvcIVGcUjn3jf98oBzSqSo6z30nSyin5C2K5CVtRQ6HwVKpMm
         EyfZra3VRbkC1GKzwgctPxQP3TEbDCnCgIwx0Bi06zdegxiltL8SajvGbxRsdzPWc7M6
         3+jxURuEdz9QGeLCyowgTkEC0XhUWRJ3yjizqeMFV6eirhjSLbWf5cqgZmSEvCLibWCe
         u1YG5mWAaoNEyqjUFNXxBLqhN1TAgWrASCWAqTzbdFnYVh+iw1uuak4WtUp0SNjva2YS
         GD1w2564iAV79nIBH0djf9fGuybtZw+8LmOXAc1dSuDKY2qYsSuVbi6F5/eHdJWIjf9u
         BgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuZLBdCErv1V9SH6WxR2G6v1dIvi8bWx/8/kO983uFvHhrZWZ98nz/gL/3BDxqsLynhI2DrtSQXDftGKtqtABC57sq3GrJ0NYnKJOy
X-Gm-Message-State: AOJu0YwAkgksuguUm8bPNm01KmryzEPHNskrZzqeGbBMbYJB4hT57XKN
	d/Q9MJzQv3Yc/EANImBNxsE4UjYqcxMqF+G+SMqi73SoPNK/DdKEI4UWUOQI6uROzK5lozp87Hl
	wncx0gsVutkH28WAdBdgRTiWi0BMUMhvRl3EVJw==
X-Google-Smtp-Source: AGHT+IEM8UC6Sfc9KQ99/p/qDZFLnvx0o7i7pv4VaJn59lOUQX1vHM/4nyM8NV5WUDUYB5Bkz/RhjTCtjuKsyYY6Uuw=
X-Received: by 2002:a17:90a:db4a:b0:2bd:8378:af81 with SMTP id
 98e67ed59e1d1-2c4db12c5c8mr8789138a91.4.1718615234621; Mon, 17 Jun 2024
 02:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com> <20240616222003.agcz5osb2nkli75h@airbuntu>
In-Reply-To: <20240616222003.agcz5osb2nkli75h@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 17 Jun 2024 11:07:03 +0200
Message-ID: <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 at 00:20, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/12/24 16:11, Xuewen Yan wrote:
> > Hi Qais
> >
> > On Mon, Jun 10, 2024 at 6:55=E2=80=AFAM Qais Yousef <qyousef@layalina.i=
o> wrote:
> > >
> > > On 06/06/24 15:06, Xuewen Yan wrote:
> > > > Because the effective_cpu_util() would return a util which
> > > > maybe bigger than the actual_cpu_capacity, this could cause
> > > > the pd_busy_time calculation errors.
> > > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > > the actual_cpu_capacity.
> > >
> > > I actually think capping by pd_cap is something we should remove. Sat=
urated
> > > systems aren't calculated properly especially when uclamp_max is used=
.
> > >
> > > But this might a bigger change and out of scope of what you're propos=
ing..
> >
> > I agree, there are other things to consider before doing this.
> >
> > >
> > > Did this 'wrong' calculation cause an actual problem for task placeme=
nt?
> > > I assume the pd looked 'busier' because some CPUs were too busy.
> >
> > This will not only affect calculations in scenarios with high temperatu=
res.
> > Sometimes, users will set scalimg_max_freq to actively limit the CPU fr=
equency,
> > so that even if the CPU load is large, the CPU frequency will not be ve=
ry high.
> > At this time, even if tasks are placed on other CPUs in the same PD,
> > the energy increment may not be too large, thus affecting core selectio=
n.
> >
> > >
> > > Was the system in overutilzied state? Usually if one CPU is that busy
> > > overutilized should be set and we'd skip EAS - unless uclamp_max was =
used.
> >
> > As Christian said, This case occurs not only in the overutil scenario,
> > this scenario holds true as long as the actual-cpu-capacity caused by
> > the reduction in max cpu frequency is smaller than the cpu util.
>
> Hmm. Sorry I might be thick here, but shouldn't fits_capacity() use
> capacity_of() which should return capacity based on get_actual_cpu_capaci=
ty()
> to compare if we are overutilized? If we are higher than this value that =
you
> need to cap, then the CPU must be overutilized and we shouldn't be in fee=
c() in
> the first place, no? Unless the rq is capped with uclamp_max that is.
>
> I generally think our current definition of overutilized is wrong and the=
 use
> case you're talking about should hold true if it's just a single CPU that=
 is
> overutilized. But I can't see how you end up in feec() if the util is hig=
her
> than the CPU in our current code base.
>
> What did I miss?
>
> And should effective_cpu_util() return a value higher than
> get_actual_cpu_capacity()?

I don't think we should because we want to return the effective
utilization not the actual compute capacity.
Having an utilization of the cpu or group of cpus above the actual
capacity or the original capacity mainly means that we will have to
run longer

By capping the utilization we filter this information.

capacity orig =3D 800
util_avg =3D 700

if we cap the capacity to 400 the cpu is expected to run twice longer
for the same amount of work to be done

>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 8b1194c39161..91acc0f92ae4 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -286,7 +286,7 @@ unsigned long effective_cpu_util(int cpu, unsigned lo=
ng util_cfs,
>         unsigned long util, irq, scale;
>         struct rq *rq =3D cpu_rq(cpu);
>
> -       scale =3D arch_scale_cpu_capacity(cpu);
> +       scale =3D get_actual_cpu_capacity(cpu);
>
>         /*
>          * Early check to see if IRQ/steal time saturates the CPU, can be


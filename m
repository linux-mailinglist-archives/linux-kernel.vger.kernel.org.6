Return-Path: <linux-kernel+bounces-216822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26C90A70C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3991C21826
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04718C348;
	Mon, 17 Jun 2024 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aof8NIN3"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CB1384B3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609292; cv=none; b=k5p27SxykAe8Cupa7UXjHiivION07HnpQZXUBIlRtW33FAHIKExPIQCfVUxMTk1XAk7Kiw+mxsVPB0+HHLeewz+gzlmLaO23P4aJcC9h/2BBfFV7Tzbn/qQQQ80dprc+W4dwroEOkmpmFx7LvQewZYEpO+nORzMPtgokTLd+rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609292; c=relaxed/simple;
	bh=SiuSofYi/udLq00l2igsVOnvDwbKw8qorq8uGNV6bV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVqaN/w/WhabxNxkQYMXH/vmN3UfgNFzAJbn7XpWOgcDKjjReByiphfhTO/IVaQ5m0YsjpJqEhR+sn5MNPNen+4dYRFDlNd+/Pjv3SmMc+zzvUhi9Nmpbwkw1CF59+VChFHohiJ7YqO1bg/4ipRcNQZbVxF6D8jXTdcy4jjCOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aof8NIN3; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-254c56efe06so2095667fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718609289; x=1719214089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boaspmVpL01fmzPzrI0mDB6SiOj7wqSr6WkevVAVN8w=;
        b=aof8NIN3CSFNkNTot7qYg+Pl+KT3AfNxB5IVc6etqcJqz6/5PspHfro8gsWOzy3w41
         cjH/9mr+E9L049a8EHoQ90MlH0jfQ+55inMap15QvhhKOjtgV/vup5/HF3zdw7Cmj8hd
         wxy9ChIBe47YtpRF7mHsZ1G5HzBv1OBehL+ANr+9p8bBAm+lUKNu5U5LqPy1Sog32pGC
         3ZqjYFgivmj0BM6wmHVYqcVZ9mix8mlEDvD0sqqs0weKivNECDOJeo+xKq5niRaWay+/
         B8hxwgEihZgQ4OJfu+qHiPT7VvK7syNprEWrvw8Q1WGtm92gHVWSdaeNnwTgkY8bZHoT
         7huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609289; x=1719214089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boaspmVpL01fmzPzrI0mDB6SiOj7wqSr6WkevVAVN8w=;
        b=HzpbHTmRd2gTUTq7RTIYFKTR77j4FKhPA7TB7xIDst1gPt4J2Twq/igMEP3DuP2iu+
         c/1QuNH75BdwI/sfcKzH10iWj9jnMhZ2+yCdQxPC7sv3pI1/5guhD5A1n89p8tsobsbh
         cTkazt2/ztZyOj/CDFmACHRGHzk7+7hP7oq7QKeancNT5ynEVsGmgS+C3QWrR7zVL5gW
         F3ujmUQoD7dz+Hws9BusS1D5Tf0U8noEdEG+MZPafJPDqGyWmbgelcsiZpHlEpHg0ef8
         zN7+fqVc8+nsDyel3nU1xovhFmvYPxNGExOPd7hW1atnNAB8MZfunnlmFbNZVmstDWym
         q2cA==
X-Forwarded-Encrypted: i=1; AJvYcCUjm/TqCAlbZAiyZefaD7eUWLO7xwVSx64P2JsTmatWS0WjqlUU3PSwocesFxo4298y2tiqpdbOR+RP0s5Rg8recxZ1Yd39CEr285rn
X-Gm-Message-State: AOJu0Yx7BadeqFs38+gSkOM49z+97UXOyGPsONry4ivBBmdTvufL10ei
	fII9hjsCXkUh/9rFOvb3QJ0/agD1zFTJzxfLGHhwhTJa9rYFET2UlzvtJlAS5osI23bNWjYZh7U
	5Ucdvgx14lon11zdhARX3lH19z7Y=
X-Google-Smtp-Source: AGHT+IFqiDKVsHuul4tJQm/2/dd4nRCf0hNgwd91Rt0sWe5tcE5inC1U8ETTJaZ0Hvr8bxi1K/ikWffSTPxy8I7hpaI=
X-Received: by 2002:a05:6870:440e:b0:24f:e100:ba2d with SMTP id
 586e51a60fabf-25842b9b48fmr10370377fac.54.1718609289477; Mon, 17 Jun 2024
 00:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com> <20240616222003.agcz5osb2nkli75h@airbuntu>
In-Reply-To: <20240616222003.agcz5osb2nkli75h@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 17 Jun 2024 15:27:57 +0800
Message-ID: <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qais,

On Mon, Jun 17, 2024 at 6:20=E2=80=AFAM Qais Yousef <qyousef@layalina.io> w=
rote:
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

Sorry, I miss the "fits_capacity() use capacity_of()", and without
uclamp_max, the rd is over-utilized,
and would not use feec().
But I notice the uclamp_max, if the rq's uclamp_max is smaller than
SCHED_CAPACITY_SCALE,
and is bigger than actual_cpu_capacity, the util_fits_cpu() would
return true, and the rd is not over-utilized.
Is this setting intentional?

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

I also thought about changing this at first, but because this function
is called in many places,
I am not 100% sure that changing it will not have any unexpected consequenc=
es,
so I only changed feec():)


cheers
---
xuewen

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


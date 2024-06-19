Return-Path: <linux-kernel+bounces-220440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286590E1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098C3284DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E652F7A;
	Wed, 19 Jun 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5eizhIw"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBB80C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766322; cv=none; b=S3wSU6r4zGJ0jS9XssFWPJTT3d9yOnn9Zd6wsxhz7eOihskcMutf1ExnZs84e6z2ImQfF2K2g7XFBixCdUhdGBZcatjvf3xywdslGDwmct9OzGh5h2ayGJAdG2QQ1neewx0Gdwj9gobzGPdFa7IAw+PUbatuwPf1kLXN2YcEBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766322; c=relaxed/simple;
	bh=2KXTFliJoLfR/o3eE3rhPT59Ry9OvYkjB5MIO5US+8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liJvOVBan+P6huOkeVuHfdCrILoVMCvtS5tHrCplPeK5iVKewQ+g/kGgFLnEApe/LVqOwFwPPtZ4ItCjWsObC4lTPpcclAgJylNyN/89ddZ4ZiV1J7ea2MZYW3KR0EHnA0koP0dvlngMeDSKM1M4L3eLrZLHF1HKNyEL6sUYCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5eizhIw; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24cbb884377so3483512fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766320; x=1719371120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwNQJwIKJvK9Mfv6EYsf/oR9vm/UpA+GLb/MQVhTjBU=;
        b=Y5eizhIwJ4ZieErYuAB2xEr0EdmOwU1/Q7nLwaB8sq/fhNTObVLEjePJ7OxUZ6O/JK
         CJKqGlhI92MZWLNV9+umpEXMhzShhD2CC/0dg4E0/QoNvP0vaoCnM+jkrIdEtsZIICjx
         FA959Qs4k8akn3Vub1odH3V6zZwn2MySvbO1OF35C+gmJ7QHYUHe3s7y4cnjOR1bOfSP
         outCADuoiL77jNzQdJ1ccxxT2PnRlwB3lW8J1pJGVVTg5BMpLnw/v9MuRU/F4Pvb3Pda
         NHpywgoVq8vNjHyqxLipICMB2IrmiF6SnJSmwmxyCrmYOEczcXLpA73l+VGqktCYijBn
         vsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766320; x=1719371120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwNQJwIKJvK9Mfv6EYsf/oR9vm/UpA+GLb/MQVhTjBU=;
        b=UQYoAphhlxLD2hs/t6SeiHCq9muCNCIbSviAR5GSY6SKMqxJSQIrwCuylsdzypPGwo
         tao3qU1sco31eAdzI3L/ONM+RJJuagesv5M46QhK3x6TnMe6pKnxkeKhy5NdZEJ0X7m4
         BrXxVNrb9EXsH0BewL1tvpooc7FYf3LRHKPdA3N4Lpua168f9iUEiAQKaOHFx7tDTwEI
         Fn36h0wZd0SNsIHIlJPgSCihZhb5+69CmQK0hCOvG9c9A06llqwhHVUV392rK8u1zHbM
         YK1SAf5+r8qS1efpgUA2JI0xBuZy481QfHKWey5v1ofaGxk869wzmttgPObdwwK0cucc
         KYZw==
X-Forwarded-Encrypted: i=1; AJvYcCWpbLwHD/tLvJGDJfW44ubpjv5P6DVFLbSHyYjcfLpguXGUV7LUMcODIQS5lARUhQMB9eYIGgRDueGFb1MqoFDIOFLrr9VDhlUFr/Bh
X-Gm-Message-State: AOJu0YwvkkUv68e899Nb7VP+A3sFNgZj9a8kXad/mUH2Yjgt/WyEysuY
	kjV+mMhnqgIf66qZK6VKcl/jxkkxZiVJgafkSrmOIH+aKjq1c8S0AxYLOqzfX6/N7/5TrVIOhSO
	vI7fnYk8ovovt761oC9lh0lxCAMA=
X-Google-Smtp-Source: AGHT+IElSrStLwkPPwHRzyV5o45ysw1X4+0H4ilZS+LjkOo51vjuRzN9j/jfaDpxZQdcJ0GL5NC60AD7efT3XWH1Ubc=
X-Received: by 2002:a05:6870:1714:b0:258:4ae8:4af3 with SMTP id
 586e51a60fabf-25c94d04c7emr1774072fac.37.1718766319952; Tue, 18 Jun 2024
 20:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu> <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
 <20240618153931.ub5ezml3imd5mwu7@airbuntu>
In-Reply-To: <20240618153931.ub5ezml3imd5mwu7@airbuntu>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 19 Jun 2024 11:05:08 +0800
Message-ID: <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:39=E2=80=AFPM Qais Yousef <qyousef@layalina.io> =
wrote:
>
> On 06/18/24 17:23, Vincent Guittot wrote:
> > On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 06/17/24 11:07, Vincent Guittot wrote:
> > >
> > > > > And should effective_cpu_util() return a value higher than
> > > > > get_actual_cpu_capacity()?
> > > >
> > > > I don't think we should because we want to return the effective
> > > > utilization not the actual compute capacity.
> > > > Having an utilization of the cpu or group of cpus above the actual
> > > > capacity or the original capacity mainly means that we will have to
> > > > run longer
> > > >
> > > > By capping the utilization we filter this information.
> > > >
> > > > capacity orig =3D 800
> > > > util_avg =3D 700
> > > >
> > > > if we cap the capacity to 400 the cpu is expected to run twice long=
er
> > > > for the same amount of work to be done
> > >
> > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will d=
epend on
> > > min/max freq ratio) though?
> > >
> > > We cap with arch_scale_capacity() still, I guess we know at this stag=
e it is
> > > 100% wrong if we allow returning higher values?
> >
> > I think that capping utilization to max capacity generates some energy
> > estimation error because it filters the fact that we run longer in
> > some cases.
>
> Yes, I think so too and that was my first statement. But I think this is
> a bigger change to do separately.

I saw the the sched_cpu_util() was used by teo.c and cpufreq_cooling.c
If we change the arch_scale_capacity() to actual_cpu_capacity(), it may cau=
se
some errors?

For-example:
In teo:
212 static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
213 {
214         return sched_cpu_util(cpu) > cpu_data->util_threshold;
215 }
It may cause the teo_cpu_is_utilized() to return false forever if the
actual_cpu_capacity is smaller than util_threshold.
However, the util_threshold is frome actual_cpu_capacity.

In cpufreq_cooling.c:
May we should change:

diff --git a/drivers/thermal/cpufreq_cooling.c
b/drivers/thermal/cpufreq_cooling.c
index 280071be30b1..a8546d69cc10 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -164,7 +164,7 @@ static u32 get_load(struct cpufreq_cooling_device
*cpufreq_cdev, int cpu,
 {
        unsigned long util =3D sched_cpu_util(cpu);

-       return (util * 100) / arch_scale_cpu_capacity(cpu);
+       return (util * 100) / get_actual_cpu_capacity(cpu);
 }
 #else /* !CONFIG_SMP */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,


Because if still use arch_scale_cpu_capacity(), the load pct may be decreas=
ed,
It may affect the thermal-IPA-governor's power consideration.

>
> I *think* we have another source of error, we take util/cpu_cap as a perc=
entage
> of time the CPU is busy. We assume an implicit multiplication with a time
> period, T. I am not sure if this implicit assumption is accurate and thin=
gs are
> aligned properly. Especially with how utilization loses the temporal info=
 due
> to invariance. util can be low but actual runtime will be much longer. I'=
m not
> sure if this implicit multiplication is handling this properly. Beside du=
e
> performance domains having shared CPUs, I am not sure this period is alig=
ned
> across all CPUs for this implicit multiplication to work as intended.
>
> I yet to study this properly. But I thought I'll mention it as I think th=
is
> (energy estimation) is increasingly becoming an important area to improve=
 on.


Return-Path: <linux-kernel+bounces-222183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC890FDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC7B24B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41045026;
	Thu, 20 Jun 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm4fhrdo"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DF81803A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869542; cv=none; b=P24+tunFhIrSw9cYXIVG8SGDhh8COHB709AvLwSDb6i+7SBk62baJnSbxHThn6yzAVojf778KK+Dd42uBJxefkUR0Ue2DvppqvgTOYavtf+9Z/mxbyYrjJjtm+EYUH+0cAEyLA88UkDIRg1kJIZPcGW1dk4xhepdXW0AKMmV8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869542; c=relaxed/simple;
	bh=wZECKNJ0nD+PmVWmn7EhuIsgRPMWGnCulkQ2NTdjgj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvUf3JPeJTr3iCaSUnsckAs9mLZ5wrmki9+wPAnRTGCfckwhHgKtiKoi1EMFNnpS+/8ioARLMcKML2BpNEIIkCuBAVzqFy/MY99w5iefJVfbR3YHapbA9WIJb7+dzo/dwrZkpcVQkPQhTQH/KUywH57cMcigHMHdChCiS8l7Fbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wm4fhrdo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c4926bf9bbso417013a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718869539; x=1719474339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMcgg9Qc65gJHF89Yq2Tbw2BxzTPeMMf7knWSATtDck=;
        b=wm4fhrdo77eziQAypK7AVSngKCtvd5O61WH+zsntfbRky2rNUO97hHFhNSz4NOSKBY
         j8Abm744qX+TkljNiA6B0eOej6zaYPDLoZET/TGC7LYZPlnkREGErJvKe/dShfpNkF+M
         GtmGCi20CUgmd6Pr6xdlQvaB5x8xQx2rvQPS4HYGFlIRAPj9DDjX8tlukM496l3m+2n7
         AVJdn1Qlzh5285HrW+e9VmDylDOhNVy9wr6Ob4Knk7xfPeE6UZ+Vz/0nBmdHjozP9bfq
         /YBmGGL3JY7SUNJaU4mR1VhM3a7NSmaKF5AJPo4quJjfyc1zm9qMjdVS90f97HexzMTD
         GcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718869539; x=1719474339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMcgg9Qc65gJHF89Yq2Tbw2BxzTPeMMf7knWSATtDck=;
        b=SymCuvacGeBmhEOMRyeklq2yvkFU6ueModc3Mj5MF8WSQYgUBEm7hwtdolIkaXBJCR
         b4XiVCbnF7/cgEMWCCi+7yH/SVHu9fyFFBp6BsxhYoPqaTQc8wdhd2h3frL9uAlZ2lf5
         XpiECWGPaN+qV7e6wm5G57WerUTp4jjM90gGuoaZ1FxJyEetkju2dPhtxrS1LoCs+jeo
         1HUpIQaqoegl7kGeZ+ITuMZsFgQEGOtz4yvbXSELq/JkD3rAwaQGZb+kelSvpjQtLnN/
         pW2MvJRlT5QJSW07Wp4WXqZhBdSpYt7uf36j7GCXTxjdf8k1/7BtYPuH4gqlJgdqNPLe
         iZog==
X-Forwarded-Encrypted: i=1; AJvYcCWLdudJXkT/5PuN5c+RF0K4vAyLkDlhrlhuEYrPNCK9oJQf0imvzA+oNGE3XWOqiqvYqY4/6qTwcJWU9dOYSEvyqVbjtWuKBBBMbdRO
X-Gm-Message-State: AOJu0YwMGD6K0cBdvrAFst5gGongkjiNVfutMVOZlSGDm8a4ACTUuRMe
	MW/5by4ZYkort/jw4WHnUfZTVrR6YQuMse8TXabV8C/P9ruyki3pvLhOrtcpKtDI/dZyLicSizz
	/YBqPTuEC+/WYadLZFyV+o8GCKc1bseuZG4FnlQ==
X-Google-Smtp-Source: AGHT+IGmWQFXG1Ls19aqYH6vH8l8W3Zj9Z8kAWPpsgDAo91GrT60Lc8NLZOC3nd96V/DQrV8ZMdJehy+NLabG7uXlHA=
X-Received: by 2002:a17:90a:1301:b0:2c4:dc4f:2c0b with SMTP id
 98e67ed59e1d1-2c7b5b147f4mr4425081a91.15.1718869539452; Thu, 20 Jun 2024
 00:45:39 -0700 (PDT)
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
 <20240618153931.ub5ezml3imd5mwu7@airbuntu> <CAB8ipk86jmb6xnEUnv_Vs5=A5EnNfnHTy3FXYZRhKhuEFKhzDw@mail.gmail.com>
 <20240619181021.kxcjxaqe47fkve42@airbuntu>
In-Reply-To: <20240619181021.kxcjxaqe47fkve42@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Jun 2024 09:45:28 +0200
Message-ID: <CAKfTPtA1cKiB=mv-QUAYOLtiwOE+Rcg+HkAirkVW=irTQtqNVw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Jun 2024 at 20:10, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/19/24 11:05, Xuewen Yan wrote:
> > On Tue, Jun 18, 2024 at 11:39=E2=80=AFPM Qais Yousef <qyousef@layalina.=
io> wrote:
> > >
> > > On 06/18/24 17:23, Vincent Guittot wrote:
> > > > On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wro=
te:
> > > > >
> > > > > On 06/17/24 11:07, Vincent Guittot wrote:
> > > > >
> > > > > > > And should effective_cpu_util() return a value higher than
> > > > > > > get_actual_cpu_capacity()?
> > > > > >
> > > > > > I don't think we should because we want to return the effective
> > > > > > utilization not the actual compute capacity.
> > > > > > Having an utilization of the cpu or group of cpus above the act=
ual
> > > > > > capacity or the original capacity mainly means that we will hav=
e to
> > > > > > run longer
> > > > > >
> > > > > > By capping the utilization we filter this information.
> > > > > >
> > > > > > capacity orig =3D 800
> > > > > > util_avg =3D 700
> > > > > >
> > > > > > if we cap the capacity to 400 the cpu is expected to run twice =
longer
> > > > > > for the same amount of work to be done
> > > > >
> > > > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree wi=
ll depend on
> > > > > min/max freq ratio) though?
> > > > >
> > > > > We cap with arch_scale_capacity() still, I guess we know at this =
stage it is
> > > > > 100% wrong if we allow returning higher values?
> > > >
> > > > I think that capping utilization to max capacity generates some ene=
rgy
> > > > estimation error because it filters the fact that we run longer in
> > > > some cases.
> > >
> > > Yes, I think so too and that was my first statement. But I think this=
 is
> > > a bigger change to do separately.
> >
> > I saw the the sched_cpu_util() was used by teo.c and cpufreq_cooling.c
> > If we change the arch_scale_capacity() to actual_cpu_capacity(), it may=
 cause
> > some errors?
>
> The plan to revert this now.
>
> >
> > For-example:
> > In teo:
> > 212 static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> > 213 {
> > 214         return sched_cpu_util(cpu) > cpu_data->util_threshold;
> > 215 }
> > It may cause the teo_cpu_is_utilized() to return false forever if the
> > actual_cpu_capacity is smaller than util_threshold.
> > However, the util_threshold is frome actual_cpu_capacity.
> >
> > In cpufreq_cooling.c:
> > May we should change:
> >
> > diff --git a/drivers/thermal/cpufreq_cooling.c
> > b/drivers/thermal/cpufreq_cooling.c
> > index 280071be30b1..a8546d69cc10 100644
> > --- a/drivers/thermal/cpufreq_cooling.c
> > +++ b/drivers/thermal/cpufreq_cooling.c
> > @@ -164,7 +164,7 @@ static u32 get_load(struct cpufreq_cooling_device
> > *cpufreq_cdev, int cpu,
> >  {
> >         unsigned long util =3D sched_cpu_util(cpu);
> >
> > -       return (util * 100) / arch_scale_cpu_capacity(cpu);
> > +       return (util * 100) / get_actual_cpu_capacity(cpu);
> >  }
> >  #else /* !CONFIG_SMP */
> >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int c=
pu,
> >
> >
> > Because if still use arch_scale_cpu_capacity(), the load pct may be dec=
reased,
> > It may affect the thermal-IPA-governor's power consideration.
>
> I am not sure about this one. But looks plausible. Vincent?

I don't see why we should change them ? We don't want to change
sched_cpu_util() as well
AFAICT, the only outcome of this thread is that we should use
get_actual_cpu_capacity() instead of arch_scale_cpu_capacity() in
util_fits_cpu(). capping the utilization only make the estimation
worse


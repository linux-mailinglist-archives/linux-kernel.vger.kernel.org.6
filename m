Return-Path: <linux-kernel+bounces-219737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE47190D71A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC80B2832C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD803D3BC;
	Tue, 18 Jun 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4MNaDdY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE3E757FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724062; cv=none; b=KPF9VmReXE6D6AWA0zQX+bRl7N3bFMTXXzI1X/mATmRPrqN0tIo6Nyd9m8u3vAP+1XfJZmrb6yljY2ygQAayxrfF18SdnTb5GbY+ekuPeBIj8SuGMnf9BEuNn6aeztoT56B5yr0qbYf2Q4gWKa8b/bFUU6sWtmB47IU/VGbxI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724062; c=relaxed/simple;
	bh=aWKOsFTEJQMOcd+nhqaLsAM16olGUYE9sAIrZtQmnWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu4fecDY6x+ZVLC1NxGj9KgMSExzjZel8ey2jfi6cORv1kmrP1L9vljbAzZpA3QPOUEV4TIdhxSqhJpn19UHwuPiepmuXeRb5918nszm193/UpiZuhIMPlKNf6Lqb3tU/4au2MZxKdlLq0jTM1miI1jU8xcbrysp+b/ezHRT8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4MNaDdY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c4e9dc81c4so3343035a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718724060; x=1719328860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLDbhAstyU2+spu2kChcjnkBG50+2Jh57WO8/dOE4+0=;
        b=U4MNaDdY7x43OvLwIX5mV1GoS4XJM5zojx+3BOe43jwi3VZwsno7CtEyr4wPv+nPua
         yCBNox/zaXAJhodNR5mpVnrzRjcalsQvVjd40EAsdOAaEODWhlUGRY1KM6x9il2MavCC
         dNXvCGB3pHFUJgF/9Hy+79g+cB6uxSmALpuuPAElbMLY/Kg0+Pq4DJWA1BYnLtsuHRY8
         EBnO1U8EuBJMkudXrLeKUAFbG8J2KiDmyGWucqCMHyXJ+wclkjMi+NNpso2SaHZJv06w
         cws2eiG5kDTtQ69JhGbnGPFrDV1jvC91/3YL8q/5BhoXLmE28rFt6jZr4sGeXqm3oR+b
         1g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724060; x=1719328860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLDbhAstyU2+spu2kChcjnkBG50+2Jh57WO8/dOE4+0=;
        b=QKxwZ9RUVhitmGxSeG0DYaI9iKLHAyjIX6tqEAVs0XSaVYlI2JdGfO0s3cmK+sQt1m
         phIEuG1HATxWybOotBCcvYJh/ptZzDG50HRb+EShp5GRjE3TjONYXXHzmo5Bmw+1gUcm
         dT4qGDD8vO9/OVMfXf8VSSeFpXzyqH7JqAtbJqg2GMfdJWP0FZnsZdzp2b6999ZYnIeu
         1QeqnslonWvWWYJ7FoVqBE3IvDjtR1vVWAnGopnNMRbYPDUMCByI8Ht6aoFKgRQVCYKX
         XFsLzX4oTwFdHTI1gL1v/e1rwc7/vaMOfDz1JwIv7WBXxEaxcGPhiOlUHL+mbMzJi4r7
         efzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz/3VcTGppooColWYBPQD8jOadroXC1isyjfCVp45dzdsb+JFMH5yYQpRiMypaobx2972A9BDXnkjUeQXb7q8X/1TgdNu3FPwXjb2v
X-Gm-Message-State: AOJu0YxRJJAdQubsqkFzw0pIzzK32/Jz8forFF3GjDgSYl6VsO0HvOB+
	TLJCEjHvPjoGXFtX9UIImMEJdKUPVpWW8km62fP6k7r3PyP/73634e0lP4ha9wbOdl1QyrrqQ7x
	+p1i83hWGLsw3tPu2kaS2SaNcFS/VJwkrPtUirA==
X-Google-Smtp-Source: AGHT+IGg6dgGz9S3dewGGfmJJkI7EDeIN+QQrlb/XwJSI/uNADXNA0RZIZ+0Cz8W+wVZBqnDrAsDfA+Q7s/ZE8ec5MU=
X-Received: by 2002:a17:90a:ea8f:b0:2bd:d2f9:fa1e with SMTP id
 98e67ed59e1d1-2c7b5d90596mr1438a91.43.1718724060031; Tue, 18 Jun 2024
 08:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606070645.3295-1-xuewen.yan@unisoc.com> <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu> <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu>
In-Reply-To: <20240617110348.pyofhzekzoqda7fo@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 18 Jun 2024 17:20:48 +0200
Message-ID: <CAKfTPtA191thPW4Yw2JpnToQjpAnNTw+oWacMShT9F_z6VrA=g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 at 13:03, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/17/24 15:27, Xuewen Yan wrote:
> > Hi Qais,
> >
> > On Mon, Jun 17, 2024 at 6:20=E2=80=AFAM Qais Yousef <qyousef@layalina.i=
o> wrote:
> > >
> > > On 06/12/24 16:11, Xuewen Yan wrote:
> > > > Hi Qais
> > > >
> > > > On Mon, Jun 10, 2024 at 6:55=E2=80=AFAM Qais Yousef <qyousef@layali=
na.io> wrote:
> > > > >
> > > > > On 06/06/24 15:06, Xuewen Yan wrote:
> > > > > > Because the effective_cpu_util() would return a util which
> > > > > > maybe bigger than the actual_cpu_capacity, this could cause
> > > > > > the pd_busy_time calculation errors.
> > > > > > So clamp the cpu_busy_time with the eenv->cpu_cap, which is
> > > > > > the actual_cpu_capacity.
> > > > >
> > > > > I actually think capping by pd_cap is something we should remove.=
 Saturated
> > > > > systems aren't calculated properly especially when uclamp_max is =
used.
> > > > >
> > > > > But this might a bigger change and out of scope of what you're pr=
oposing..
> > > >
> > > > I agree, there are other things to consider before doing this.
> > > >
> > > > >
> > > > > Did this 'wrong' calculation cause an actual problem for task pla=
cement?
> > > > > I assume the pd looked 'busier' because some CPUs were too busy.
> > > >
> > > > This will not only affect calculations in scenarios with high tempe=
ratures.
> > > > Sometimes, users will set scalimg_max_freq to actively limit the CP=
U frequency,
> > > > so that even if the CPU load is large, the CPU frequency will not b=
e very high.
> > > > At this time, even if tasks are placed on other CPUs in the same PD=
,
> > > > the energy increment may not be too large, thus affecting core sele=
ction.
> > > >
> > > > >
> > > > > Was the system in overutilzied state? Usually if one CPU is that =
busy
> > > > > overutilized should be set and we'd skip EAS - unless uclamp_max =
was used.
> > > >
> > > > As Christian said, This case occurs not only in the overutil scenar=
io,
> > > > this scenario holds true as long as the actual-cpu-capacity caused =
by
> > > > the reduction in max cpu frequency is smaller than the cpu util.
> > >
> > > Hmm. Sorry I might be thick here, but shouldn't fits_capacity() use
> > > capacity_of() which should return capacity based on get_actual_cpu_ca=
pacity()
> > > to compare if we are overutilized? If we are higher than this value t=
hat you
> > > need to cap, then the CPU must be overutilized and we shouldn't be in=
 feec() in
> > > the first place, no? Unless the rq is capped with uclamp_max that is.
> >
> > Sorry, I miss the "fits_capacity() use capacity_of()", and without
> > uclamp_max, the rd is over-utilized,
> > and would not use feec().
> > But I notice the uclamp_max, if the rq's uclamp_max is smaller than
> > SCHED_CAPACITY_SCALE,
> > and is bigger than actual_cpu_capacity, the util_fits_cpu() would
> > return true, and the rd is not over-utilized.
> > Is this setting intentional?
>
> Hmm. To a great extent yes. We didn't want to take all types of rq pressu=
re
> into account for uclamp_max. But this corner case could be debatable.

Shouldn't we use get_actual_cpu_capacity() instead of
arch_scale_cpu_capacity() everywhere in util_fits_cpu().
get_actual_cpu_capacity() appeared recently and there were discussion
about using or not the thermal load_avg but everything is fixed now
and  think that using get_actual_cpu_capacity() everywhere in
util_fits_cpu( would make sense and cover the case reported by Xuewen
just above

>
> Is this the source of your problem? If you change util_fits_cpu() to retu=
rn
> false here, would this fix the problem you're seeing?
>
> >
> > >
> > > I generally think our current definition of overutilized is wrong and=
 the use
> > > case you're talking about should hold true if it's just a single CPU =
that is
> > > overutilized. But I can't see how you end up in feec() if the util is=
 higher
> > > than the CPU in our current code base.
> > >
> > > What did I miss?
> > >
> > > And should effective_cpu_util() return a value higher than
> > > get_actual_cpu_capacity()?
> >
> > I also thought about changing this at first, but because this function
> > is called in many places,
> > I am not 100% sure that changing it will not have any unexpected conseq=
uences,
> > so I only changed feec():)
>
> Yes I had similar doubts. But the question had to be asked :-)


Return-Path: <linux-kernel+bounces-221575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ADF90F5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2A2282EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99F15696F;
	Wed, 19 Jun 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="FOR0aRBa"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1F15252C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820067; cv=none; b=tasa0m4Lg+sXrp9oXAzfDXJcn9KrOKv3gDznUSSgHdSaikR3Oh4hRPf47NyMAMTdX3tpa0DCbCCbACXAH9K+rcyBtLUUYGKwZBHcjZs25t7avR63hJD8MxktFm+hJdv1G8RrwipyespKeVg38jRJas0sG03K6LFcvG8yReWJ/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820067; c=relaxed/simple;
	bh=BnG60unWFeGgbNUtu8ana9ZwvY9i/K795NWrqHwfUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJSnrWUrdIn/AfBdiNvAfidt+nLI7cr+5YUNqdKFDYm3VijCdQJlGJSJZLxGr67wrj4jlyQNyAEj0i/YC3M8LlyC+u5yfd98ROijJerjMrK4vSRwHVV59VdO3W7Fq3npauN/qGpt+IkeQgOG5ceZUlhpNTBXvcPyNfmZPFxtqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=FOR0aRBa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso7893345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718820063; x=1719424863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rQWR8Kk65srCxlQzWBjwPKZPZa87AkqR56jJJtLENA=;
        b=FOR0aRBarY5NqULTRsGgaJ/df/dEFybYhGfHpGhYliWA3YYg9MN7KeqwLwxucbB+F/
         uwU9dcUgv875SDWvFuFIDjRrN/d4nHqH4pytd5LKNBdfyUb/YrOv53a2rC8yGtnHqRGE
         eLJJMa1XPWd96J4m6aqxr4XqTaqfT1PdARZ1QrFqt1dFOpRA6zpZMXRtMHRl3ZvujSKH
         VSUQky/CNFQ305ivU97Ottwnb6eG8aKKEJgkE7nJQHL0uN7gRJAz/goADKowuUqUMt1N
         vaMIH4FsQGSmPFLEp+iqaxJKivVc7C32HQnmyd7rgB30+YUsx5bIPHp66JIYCrxIPWdH
         peow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718820063; x=1719424863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rQWR8Kk65srCxlQzWBjwPKZPZa87AkqR56jJJtLENA=;
        b=rBh6L84Ju03IXHWjFy4Ws5H5P4G9FCY/AOB4sbOQrJHl/VZR6szlj7k+ZuCGhn4FLB
         TLq+9spi0hZSy/8I+W+Ty/TxcSFUTofJbMdn4jWHy7wl8JnyOSHTsiN0bDSPzMktbtpS
         J6xiuUyrGN4Oh6Bhbt94hKegskbtXnunoJHwMWMJUJC/Iq1FlbqMbrLD4j2PcGaGY2WA
         fPmKDWyN88kgqvoY0DgjJBx39OtymrjZswOKRbnw12+byEM06NUubR+GOrpBJ3lA8ORi
         hsBPzBqX+rg3QWBptJsi4JRB0VtK7pjV6vu6XiFquaWI+VEmKEBRMm0qBXteoV0xHYcZ
         D8/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0Y20v+6f9ODTMG6QxSDKksvxjDpQnOhM3xpfIUvPux5N006MUyJwCSCQWYlzr9ATAqa8GKAjKiu0DaqCZx/MZl6NDWIhNq0NF4RLM
X-Gm-Message-State: AOJu0YySWiNNvC1Ul9Ej19AVms7vluk5wxIEebJfZr+kqWZSO1CK8rF3
	zRnJJX8xakyB2LOeEZeZ8BIhkZqr8MA32qn0R4fB0rStdJxM4aRkqK/xcKS64os=
X-Google-Smtp-Source: AGHT+IEg0948q6MW5X9brHl/ckCaBQwq2ZLgOQNEPHFGfqTna2FU7CDkWTAjs06+Nxlzh6csq+H4IA==
X-Received: by 2002:a05:600c:4506:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-4246f56d2b6mr62734745e9.1.1718820063402;
        Wed, 19 Jun 2024 11:01:03 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe92c6sm275067465e9.18.2024.06.19.11.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:01:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 19:01:02 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	vincent.donnefort@arm.com, ke.wang@unisoc.com,
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
Message-ID: <20240619180102.ehh5ogh6n26vofun@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
 <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
 <20240618153931.ub5ezml3imd5mwu7@airbuntu>
 <CAKfTPtAgXHDjjPhNhDPZzWbPX-DNJzb5TH9DeF-cYOcEC=4igg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAgXHDjjPhNhDPZzWbPX-DNJzb5TH9DeF-cYOcEC=4igg@mail.gmail.com>

On 06/18/24 23:05, Vincent Guittot wrote:
> On Tue, 18 Jun 2024 at 17:39, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/18/24 17:23, Vincent Guittot wrote:
> > > On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 06/17/24 11:07, Vincent Guittot wrote:
> > > >
> > > > > > And should effective_cpu_util() return a value higher than
> > > > > > get_actual_cpu_capacity()?
> > > > >
> > > > > I don't think we should because we want to return the effective
> > > > > utilization not the actual compute capacity.
> > > > > Having an utilization of the cpu or group of cpus above the actual
> > > > > capacity or the original capacity mainly means that we will have to
> > > > > run longer
> > > > >
> > > > > By capping the utilization we filter this information.
> > > > >
> > > > > capacity orig = 800
> > > > > util_avg = 700
> > > > >
> > > > > if we cap the capacity to 400 the cpu is expected to run twice longer
> > > > > for the same amount of work to be done
> > > >
> > > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> > > > min/max freq ratio) though?
> > > >
> > > > We cap with arch_scale_capacity() still, I guess we know at this stage it is
> > > > 100% wrong if we allow returning higher values?
> > >
> > > I think that capping utilization to max capacity generates some energy
> > > estimation error because it filters the fact that we run longer in
> > > some cases.
> >
> > Yes, I think so too and that was my first statement. But I think this is
> > a bigger change to do separately.
> >
> > I *think* we have another source of error, we take util/cpu_cap as a percentage
> > of time the CPU is busy. We assume an implicit multiplication with a time
> > period, T. I am not sure if this implicit assumption is accurate and things are
> > aligned properly. Especially with how utilization loses the temporal info due
> > to invariance. util can be low but actual runtime will be much longer. I'm not
> 
> I'm not sure to get what you mean by " how utilization loses the
> temporal info due to invariance"

The utilization value itself doesn't tell us about the length of runtime of the
task. But its compute capacity.

> 
> Utilization aims to estimate the number of instructions to execute
> whatever the CPU of the system, which once divided by the compute

Yes for the number of instructions.

And yes, the *ratio* can potentially be a proxy for *percentage* of time we are
running. But we have no idea about absolute runtime.

AFAIU, there's an assumption that this percentage of running time is multiplied
by 'unidentified' period value to get a proxy of time the perf domain will run
for. This time then multiplied by power we get the energy.

I am just not sure if we're losing informations with all of these
transformations. I need to investigate more.

And we assume a periodic time interval for which this percentage of busy time
we say the CPU will be busy for.

I am not sure if at every wake up this period needs to be aligned.

I think this will matter the most for calculating the base_energy.

I am not sure if this makes sense :).

I need to study the details more anyway and collect some data. But my worry is
generally whether our approximate of runtime is good enough and how to improve
it.

> capacity of the OPP of a CPU will estimate how long it will take to do
> the job. So if the capa of an OPP of a CPU is low, it will reflect
> that the actual runtime will be much longer.  A low utilization means
> that you don't have much instruction to execute but not the speed at
> which you will execute them.

Yes. But I am worried about actual absolute time is being approximated
good enough or not.

> 
> Then, problems start when we cap utilization to the CPU capacity as an
> example because we cap this temporal info.

Yes. We agree on the existence of this problem.

> 
> > sure if this implicit multiplication is handling this properly. Beside due
> > performance domains having shared CPUs, I am not sure this period is aligned
> > across all CPUs for this implicit multiplication to work as intended.
> 
> It's all about average because it's too expensive if not even possible
> to know when the instruction will be executed on the other CPUs. We
> can only take the edge case (currently the worst case)

Yes..

> 
> Beside the impact of uclamp making the selected OPP not always
> sustainable but sometimes temporary
> 
> >
> > I yet to study this properly. But I thought I'll mention it as I think this
> > (energy estimation) is increasingly becoming an important area to improve on.


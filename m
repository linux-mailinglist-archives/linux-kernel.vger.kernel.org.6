Return-Path: <linux-kernel+bounces-220199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3B90DDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283AFB2210D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183161741FF;
	Tue, 18 Jun 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/1ffTEd"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9D15E5CA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744758; cv=none; b=Dwoyb/x/rqlpw9XTh3MiGhfepRj7wLTToyy4UDU0bFKurwuvMygw21rTxnShMCsceguVhM1op+0k2DmTKclo85K0jYUmA8bj4y/a/VcFW6KejFnWErmjguWlYBNlnaqXD73ki9hiS5hH4XIWj0JPTHIiW2N2QjBJhRJOyqzlKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744758; c=relaxed/simple;
	bh=ephjuVUCNI5g9OmET8XQKQoHAS6wUuhtl3/3VU6hlMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRp5AO7X9xeZsczvl3RxFk04SM+rLmwue6KYEnJHwpws6dd5qW+crEeZCkt0JNghKkwTJ2s/VbTwRYSTvpyF6CG1R8bZhcs+6b9LtOIJEgpezzPgL5GPAnFS1gUxVF5VwjFgMvqvfBBBrwBWVWaVuUsDWugyTTrVwkqJh+BHo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/1ffTEd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c3050f4c50so4655769a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718744756; x=1719349556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1HLO6ZiZ3mGv6VRzJAYgv6PhGFKY4aF3Dj1yNL2HBw=;
        b=P/1ffTEdq0rMIDpCjlRTQlKYUWpVKwp3DUVjdzt00PKa0GTqI2X6lb6hgHWPMudqF5
         q/t1Mw3zUEqq7K7oBizHmRWPYeLxskQf7iUWFgm7bPkWAXZ9xpILfsoHJfZ724I05gjO
         nDN9My1jOSkWChHfNFfPMv03IO2/KcrE2ZN0rbSuZhDexr+2RrgQNkLlAm9+LfwFn+FJ
         4Y2pAFUW1CoXrm9jPZzrDKhMB0S0nzYktNq5O0Ed3KrRCcew/+jGHNCwch1vqnQJEx/H
         jGBbSYt/3LN1T2YeDIrfe9qUHJ6LPiNQxd9Xqsu/rcWTov9q89E8WTCZbKClAxx+1xzR
         XK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718744756; x=1719349556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1HLO6ZiZ3mGv6VRzJAYgv6PhGFKY4aF3Dj1yNL2HBw=;
        b=WHDGuaTUWPXWf+Zeb2eBBNF1Yqv64+Qd9Q0opAKLCHL8yFpPb4Wpc1QL36EUfPosAF
         I+gkwrSZWAw3omcADxcQ5Xl/RdCziRwVsC0tRmwZrKQsZC6JGbcq1PJCIpWG0F5sdugX
         kFD8ROTylAB4mOiN/xiMBikFPIIZvSU+uuVHSFHLIjMt5dlKom21QOUBpKkB0VQ0IO5M
         4exTzeMQwPQRPso29MIL8eAl7E4jBK/WUMtTcKl7h9DaVcHKInC6P+1gshRS5W9TP7/4
         U/d4iLVJoBOMMTudPwdFvfMRcJIkuSRTtqwVp1Huo0KyqgzaCuyNjqovdAYrC/FB8B2t
         z0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUPMFYBszSrwnuLHuTmZH3UuMlDdWEENHYhcZXaIoBedpUmWxVa6P8AcLo7xIYNuLNcX4I62A6mVfYdA1oT4Y98Z/edZCnkRboQPiz
X-Gm-Message-State: AOJu0YzaiWVbF178vXBZ6SEwZodpa56Lp6O0JuWI5addFxsY0d4v2Mvz
	CJ5UzND4M1p4FL+xhk/Xb8yQHuXRgD2i45Ak7JXqR1wCMgrQCH1ExXZgM8eypf8Wh/2QQw7PkQ6
	viHFhVSEk+D653n6MFdU4R2FfyPOxRkqU+bHuuQ==
X-Google-Smtp-Source: AGHT+IH7c7AIGjET1dusErKHhBLkEgMToHh2NSoln4tKcsWBFZs3SzmQ+8Wbp0WdnBZvyHrU6VRDcF37Sh/C+IdpdLk=
X-Received: by 2002:a17:90a:1fcc:b0:2c4:ddb5:7bb0 with SMTP id
 98e67ed59e1d1-2c7b5d56bd6mr796987a91.30.1718744755941; Tue, 18 Jun 2024
 14:05:55 -0700 (PDT)
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
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 18 Jun 2024 23:05:44 +0200
Message-ID: <CAKfTPtAgXHDjjPhNhDPZzWbPX-DNJzb5TH9DeF-cYOcEC=4igg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding actual_cpu_capacity
To: Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, christian.loehle@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 17:39, Qais Yousef <qyousef@layalina.io> wrote:
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
> > > > capacity orig = 800
> > > > util_avg = 700
> > > >
> > > > if we cap the capacity to 400 the cpu is expected to run twice longer
> > > > for the same amount of work to be done
> > >
> > > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> > > min/max freq ratio) though?
> > >
> > > We cap with arch_scale_capacity() still, I guess we know at this stage it is
> > > 100% wrong if we allow returning higher values?
> >
> > I think that capping utilization to max capacity generates some energy
> > estimation error because it filters the fact that we run longer in
> > some cases.
>
> Yes, I think so too and that was my first statement. But I think this is
> a bigger change to do separately.
>
> I *think* we have another source of error, we take util/cpu_cap as a percentage
> of time the CPU is busy. We assume an implicit multiplication with a time
> period, T. I am not sure if this implicit assumption is accurate and things are
> aligned properly. Especially with how utilization loses the temporal info due
> to invariance. util can be low but actual runtime will be much longer. I'm not

I'm not sure to get what you mean by " how utilization loses the
temporal info due to invariance"

Utilization aims to estimate the number of instructions to execute
whatever the CPU of the system, which once divided by the compute
capacity of the OPP of a CPU will estimate how long it will take to do
the job. So if the capa of an OPP of a CPU is low, it will reflect
that the actual runtime will be much longer.  A low utilization means
that you don't have much instruction to execute but not the speed at
which you will execute them.

Then, problems start when we cap utilization to the CPU capacity as an
example because we cap this temporal info.

> sure if this implicit multiplication is handling this properly. Beside due
> performance domains having shared CPUs, I am not sure this period is aligned
> across all CPUs for this implicit multiplication to work as intended.

It's all about average because it's too expensive if not even possible
to know when the instruction will be executed on the other CPUs. We
can only take the edge case (currently the worst case)

Beside the impact of uclamp making the selected OPP not always
sustainable but sometimes temporary

>
> I yet to study this properly. But I thought I'll mention it as I think this
> (energy estimation) is increasingly becoming an important area to improve on.


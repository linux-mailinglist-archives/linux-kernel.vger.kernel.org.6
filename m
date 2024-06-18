Return-Path: <linux-kernel+bounces-219765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB990D782
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01C91F23551
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007C44C76;
	Tue, 18 Jun 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Dz+9UNt/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90340851
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725176; cv=none; b=Z7C67zhLkwIW8XqRWSwfBWmhivm+2ftK4j7w4RzhAt+2R7MiQClwcwvZyukbOFwxntucNNH4wT+KUooXxzjLAQfVpk4DLKH2eH+a+nu6a8mZYFQiDldPePKyv6tIy2gmuNzlH7kGfzbCVcU7qbDAyOeFuOZcU/T3y+8cCghzE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725176; c=relaxed/simple;
	bh=As+7Z/GWKpgmc4eYA7JV3Zck6P9jkFY7zg0cSCAzvCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBdbz76VWh3iL4yZC8n2Ou/3LEBH3SCbwAfMyIxR+ecU3I/GtYKlNfbQCtWmFImXPhDWxPPvNSTt+GXUs1Gp3cZKrmYDR2hB3BfCu8GdYAf1w0ICAfpVReLookBhgDlmHM/w2UopH3ADHrYeeU7FJ2MxR7DKzKdNwUNEf5sP814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Dz+9UNt/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217926991fso49887305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718725173; x=1719329973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxHZdMNBySJ1LsjBNozOYRVdFIMjiE62FkJA1FGqOSw=;
        b=Dz+9UNt/+qi+YsWClIA+ORsVpIvEm26cSFfy8uXfuqwp4jZigR3U6Grl+jNK8t5Vg5
         yh9u+Cylr+Pd2Px7mjNd+3IupjtFMM9MZejNh8qPAEFn300VQ1tqqlQbGTrqYfRxTER4
         YD9Lr7R5uv8cbTyDP0VQZYX9IOyFqG5sUWB3YKJ85w8vxBuajJostU6tTFSqNxlMIgfx
         l6fqlnMQYck6l8fKHKiifoEuhOUZBSXVMxQ8YVOmy7G5m11bXLlkYyNL36IfP7IVpD4O
         O6UaXMdaEzUv7ovctvwf2bUnn+2lLF6pDF1XkBHWntvK5N8xx5t99zvWZCnWQVmktZbZ
         P6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725173; x=1719329973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxHZdMNBySJ1LsjBNozOYRVdFIMjiE62FkJA1FGqOSw=;
        b=sEX8NZeD5lPD9UMmT0w9PE/TQh2JiCKNn/Ec8edZOuuQEdXKtG5bTYXG7Yov4hSEbQ
         j5q/HMBmEmDSPqJ+mKKfUf3fuYvjToXO183A5BeM7rtux+qNJqW57IlEOnQSd0vQ5RQU
         sCS1KYHz3YInI4vXL9SElGS1BKVa1F6gwK/BUUA/nhukpfS4veRHR2n9zovzske8s0N2
         mms8CWrbG7BWJOTn+q8eLoPWByMezJ+Qp3BV/koos4qth0Y7h7cnxsgyKdDhmCeYJydZ
         62TTxGIUFlY820WfS140jAEnRP7LvW9YKW6w8CWvrta0gYTDAlcnKTyJPc4DcI6WH6hM
         sjNA==
X-Forwarded-Encrypted: i=1; AJvYcCWjPC78mGpWLgI6xufdYsfQwVUgZ3MlIW7qOllEiupTqmT5f94EwFwERekPh/v4QvbdlHAoP/IU1xYcRb0yFiLaTYbRT/XMCRhSzVac
X-Gm-Message-State: AOJu0YxRur8f41SryvN541UbyEoxkPNd3vC2xTjUhqakmWGtlDuwzM+f
	dQHU5mNh4hXuksUWl+rGryLSKGZmKkZ0fau9snxdXOc5LT9APHoo65KZF1zm5rM=
X-Google-Smtp-Source: AGHT+IHjg4cFTLRxDB2fSjUPCcXKkv6H47mLIdnq+p34kMbFVbOQNv0NTDgn8XKQ+t7kw/FfO/r8hw==
X-Received: by 2002:a05:600c:1c85:b0:421:8007:a640 with SMTP id 5b1f17b1804b1-4230484cf9cmr106805565e9.28.1718725172682;
        Tue, 18 Jun 2024 08:39:32 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm228207895e9.47.2024.06.18.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:39:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:39:31 +0100
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
Message-ID: <20240618153931.ub5ezml3imd5mwu7@airbuntu>
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAKfTPtBikWsyPon6HweEZg5qjSP+QX=WZDQu4NHs7PUcSCqDDA@mail.gmail.com>
 <20240617105348.ebtony3ciwxhvj2w@airbuntu>
 <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDPCPYvCi1c_Nh+Cn01ZVS7E=tAHQeNX-mArBt3BXdjYw@mail.gmail.com>

On 06/18/24 17:23, Vincent Guittot wrote:
> On Mon, 17 Jun 2024 at 12:53, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 06/17/24 11:07, Vincent Guittot wrote:
> >
> > > > And should effective_cpu_util() return a value higher than
> > > > get_actual_cpu_capacity()?
> > >
> > > I don't think we should because we want to return the effective
> > > utilization not the actual compute capacity.
> > > Having an utilization of the cpu or group of cpus above the actual
> > > capacity or the original capacity mainly means that we will have to
> > > run longer
> > >
> > > By capping the utilization we filter this information.
> > >
> > > capacity orig = 800
> > > util_avg = 700
> > >
> > > if we cap the capacity to 400 the cpu is expected to run twice longer
> > > for the same amount of work to be done
> >
> > Okay makes sense. Wouldn't the util be 'wrong' (to what degree will depend on
> > min/max freq ratio) though?
> >
> > We cap with arch_scale_capacity() still, I guess we know at this stage it is
> > 100% wrong if we allow returning higher values?
> 
> I think that capping utilization to max capacity generates some energy
> estimation error because it filters the fact that we run longer in
> some cases.

Yes, I think so too and that was my first statement. But I think this is
a bigger change to do separately.

I *think* we have another source of error, we take util/cpu_cap as a percentage
of time the CPU is busy. We assume an implicit multiplication with a time
period, T. I am not sure if this implicit assumption is accurate and things are
aligned properly. Especially with how utilization loses the temporal info due
to invariance. util can be low but actual runtime will be much longer. I'm not
sure if this implicit multiplication is handling this properly. Beside due
performance domains having shared CPUs, I am not sure this period is aligned
across all CPUs for this implicit multiplication to work as intended.

I yet to study this properly. But I thought I'll mention it as I think this
(energy estimation) is increasingly becoming an important area to improve on.


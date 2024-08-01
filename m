Return-Path: <linux-kernel+bounces-271215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332E944B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CEB1C23EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603131A00F7;
	Thu,  1 Aug 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="lMaaQJbF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0741946C7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514881; cv=none; b=M7ESjEZnVLAM4KZt5ZmTfvaT5Ao8wTKZWyLrWR9RaGc4vcJmEkeWE8MmiEcktdp/LD9OEORdKmuqTtSFeL7d2tfrMEKWKtyEX5AWQOafHds4i8vbD9jdLQp1XzwI8xiJJnQQA+WZLi25GK2v8L0uV0FhRW1W17gYs5p42ElbVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514881; c=relaxed/simple;
	bh=8cgCFWa498dShvwXxuBW2ELETMQBfWHnMupKw2ywoMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5I8NNaVzh4TQ2X93jZGNkB+qyi3vNuTOT32xJgJba7ZDFqYuZ7+i5/yUz02/LqCF2yIblT4XPNR7XP/HHB7amekERtqnn4MKmP0jMUs2kpGoD0RMxuOwqq5g6UP6BaXjpUGV3YWyGnBjTdf0rg1vMr9LyypmAudM8in/cUWMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=lMaaQJbF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso86799381fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722514877; x=1723119677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=do+qBTvWewujd/oPPXP1tL5hyIBO2XhmysEm1NZI9Tg=;
        b=lMaaQJbFUwqmcz+5C5ksRv7jLXYiQALSNJ+XZZMjMHGndvadhZeWNi24L3hmRxrJS7
         FxGHER4uIWCPO4vTSns5HwebwM6ndQMzeAMQQXf5eIFCBaUP1lNH7Z6WrEYYCkhBnGG9
         rSW3RPoGTMM4GUPlrW9dy4fQ3ejm0eIRl2t1Dt/4lDRXVh32LXd1N8CMp3Qf7TCoQa7b
         pwytSU8hbPM+rtDwVjK9nxTU39kG+4AcJAgvXL8GYMRosJDmFXVVhcGAsCrpDXESiriF
         2cpqNgUm2iE89BzKGpd63/WkpAtRTSM4exA5uqV6mqdn4zIZTL5lTMfEU6yGmnTW9fIB
         akbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514877; x=1723119677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=do+qBTvWewujd/oPPXP1tL5hyIBO2XhmysEm1NZI9Tg=;
        b=F8GwQDjiJ0ZlCqQ0ve2AJw9pPZlT9niimvKhOapB+CSluAiqySe4l4UZHqmrrwFO/n
         HOc3ZACl1wT7A3zLVUPYWyDa/sjH8bqxBBn5w0l9YKhumvcm7b1PvBgB0g59SsfIgM9q
         qxzznhpePicMd0D4B+goW2hGv3bph6DVAI+LszTj1TJeLXkRAjZwFOmWU6z6HEdjME4w
         JCcTGYxVj5qmbzyIekhCcRR2luhnyy1SCIgcFqLIKmb3HpNSTAUturNWBo8QbhvKJRVO
         jq/4yBXU8YfhJt45Wi1iyyVxUe8hbkoRPU3IZw+uIzXkwPUxJkQE4SyrdUd8xw5yqnIV
         8RHg==
X-Forwarded-Encrypted: i=1; AJvYcCXyENwznY1jAcGuuWKS/mTQi2QaXedXgDWvpoQ6nyIa7UQYiFj7AYX8keTo01EwRCHPpa6lzJvH+bMhpCnlskrx6iLxfj65TVl+QpDk
X-Gm-Message-State: AOJu0YwXPCjevRDYBz/9GmraMzv1STp8eRFwEDuzMsKwbjScdmFt3yMC
	rLfVxJ3okCjH+jbc9ZVvjzP2F9QVKLawOAXYWbKSaJPEL7qkbRTNcA+c9Tkw80E=
X-Google-Smtp-Source: AGHT+IEwqIH8SthmRl1o3JP3bpeRguKoDVyt+cJv8dJaRagI5zrcwiuQVd+oxB/obG6jLT/7w7t0Cg==
X-Received: by 2002:a2e:9d47:0:b0:2ef:2c62:f058 with SMTP id 38308e7fff4ca-2f15ab03fd7mr414551fa.39.1722514877172;
        Thu, 01 Aug 2024 05:21:17 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b368622c3sm19331809f8f.100.2024.08.01.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:21:16 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:21:15 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	John Stultz <jstultz@google.com>
Subject: Re: [PATCH 2/3] sched/fair: Generalize misfit lb by adding a misfit
 reason
Message-ID: <20240801122115.lfxvc3dxa6b6eesl@airbuntu>
References: <20231209011759.398021-1-qyousef@layalina.io>
 <20231209011759.398021-3-qyousef@layalina.io>
 <CAB8ipk9+4p29iE8HSiRrcc8DanCcO2U3+HRVY5LXLJRWXFMpOw@mail.gmail.com>
 <20240724213530.akr2ghuzabz3mfxw@airbuntu>
 <CAB8ipk-PwCvaAaRQSnCsybBTz_9xGw6aqsn+4p3PM8Amz3OedQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk-PwCvaAaRQSnCsybBTz_9xGw6aqsn+4p3PM8Amz3OedQ@mail.gmail.com>

On 07/29/24 18:47, Xuewen Yan wrote:
> Hi Qais
> 
> On Thu, Jul 25, 2024 at 5:35 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Hi Xuewen
> >
> > On 07/17/24 16:26, Xuewen Yan wrote:
> > > Hi Qais
> > >
> > > On Sat, Dec 9, 2023 at 9:19 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > > > @@ -11008,6 +11025,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > >                  * average load.
> > > >                  */
> > > >                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > > > +                   rq->misfit_reason == MISFIT_PERF &&
> > >
> > > In Android, I found this would cause a task loop to change the CPUs.
> > > Maybe this should be removed. Because for the same capacity cpus, we
> > > should skip this cpu when nr_running=1.
> >
> > Could you explain a bit more? Are you saying this is changing the behavior for
> > some use case? The check will ensure this path is only triggered for misfit
> > upmigration. Which AFAICT the only reason why this path was added.
> >
> > The problem is that to implement another misfit reason, the check for
> > capacity_greater() is not true except for MISFIT_PERF. For MISFIT_POWER, we
> > want the CPU to be smaller.
> 
> Sorry, it was my mistake.

Np, it's always good to hear back in case there's a problem :)

> After debugging, I found that there was a problem with my handling of
> MISFIT_PERF.
> But it is true that due to the influence of rt and irq load,
> capacity_greater() sometimes does cause some confusion.
> Sometimes we find that due to the different capacities between small
> cores, a misfit task will migrate several times between small cores,
> for example:
> If capacity_cpu3 > capacity_cpu2 > capacity_cpu1 >capacity_cpu0,
> the misfit task may migrate as follows: cpu0->cpu1->cpu2->cpu3.
> I don't know if this migration is really necessary, but it does cause
> me some confusion.

It should be cheap in theory.

But have you verified that the load_balance type is misfit and not load balance
trying to distribute load on little cores? I think it is harmless if it is
caused by misfit, but yes looks unnecessary to me too.

I'd love to remove this 5% magic margin, but I have no idea how yet.


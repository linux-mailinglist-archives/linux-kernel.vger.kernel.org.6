Return-Path: <linux-kernel+bounces-538944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1C8A49F16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C8E177873
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B4271815;
	Fri, 28 Feb 2025 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYcYgNIL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0327002E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760781; cv=none; b=EuskjgeV0iuOBYozIHMVMCjQ5CLXgsv0//dZpGXWOAWJc6KZH/ytRGclugiFFvwEZv4NjSWQnJmP1495rCQ8KWGrOl3bdTJd7CPo4t6olAw7R9a6exqRqmsyHhZSMlR8JG2T34Mp6ZGt8qztToqIL+AnqK6HrfmdRSyFsOWLGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760781; c=relaxed/simple;
	bh=rB/kMFq3R9s5RDXmFK3u0alDwSgo63ojRRW9ITcZBW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBxaV1a0Mf80KpDJu7aJfmv5fKkcmCyiN0OslvUTfON1uWwAT9mUBEVdfvqrqQHbwJj/GfvskW8ZZTf3GDvNBMPsK7tK6f+VLEi7gw+QGY82En3HlygnzP/fkT+em1EeUHI3/kDEXZFumQjnJ+/JaReCboUt/24c0RvjtbSr0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jYcYgNIL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf42913e95so75576466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740760777; x=1741365577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6UR2OZwD7+XxsVba8bPXtaKE9m07ilfrFPUuzl5ixk=;
        b=jYcYgNILYSLj0accorOy9J/spkak1z+Xi1Sxi20dAxpkaU/GrkrZbOwwFnfLvjrd4j
         SEJRQQwAe1j29zLtT+jDhsSxjPqGW8y0D2Krck5zxmxoWr+wiqmRZo2tY5tBWflHeoT0
         iV+QdBd4waB2E3i1RKZNWV2vWc7egtp1Y4HyodO8T3UQSSbfUvhGiwv6ANX81x3Vw22x
         et1hSl8aFxP/HJAqyNNEsJbWMzQ1IbEFgPEH+0Mx3iNSq4zAvuQI3hnWwA2gEDv26XLq
         9Z/47Vb71+3b8mf/G1tjdikOgYaBE1zg5ROWhX25+jscsyNu61Xt1AGqADeuDKJXbfBV
         Vyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760777; x=1741365577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6UR2OZwD7+XxsVba8bPXtaKE9m07ilfrFPUuzl5ixk=;
        b=o3f5ogziG32WYyAprvJPORoBph+WJOHMu2gk3/ddMiwsDl2vuk2DmRuehq1tLPSOHr
         NkBwf9pDzpHKBbZtm0HawVy+m4reQfJJadOvLbTfZZzbhTqhN4yxsjHtHh3YIB80l177
         ZUw4PELMcqSMI9j1vl8WrlYnRFRwEZ1TEGKEb7Xos5HWQ+74MyNiautfzh7xg1zArzMC
         tbUytBxwxT8/jorJPcSgAJjUOP1IypC1xvf5tx0MI0NfXyKt4On5ZeZ51ig/CQUpwfCI
         9d5YHv1gbtSrGatEHS4zoqnhpnEa/8beQPyl8Jaez/xThqcrC+PUb9Eq1umu2yrhRY9N
         Ys+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPeLMCWDD6GYA2GfxSt5UIRmpUwSE5IvESB6OfILiiH77QFUYOQquhAMjDSh0eHJ8ApyHDzJ6maCGKJWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMt1HJhIhv47bMA8jHs/LQaunSyavYjhpVail/AwrOv7pJERaO
	GiMh1thgFVnog+IuCeXsSw2jEaZnF0EKEJQpUM+y8DpZE7bNtnfgTmSjXQUyXM6cQ1/8t7Q/fe6
	X213MntFcJWO/y28R7y1QZGOdZVB0NO5sepcZMw==
X-Gm-Gg: ASbGnctwKA0dtEzB3pPJywxdWvbeSmciPJfjEKIdsLvp14YsOlurifN8Cy28sYcuWqO
	0bGGbRntVe4K7DLZ8Ls9jhUxptUMlKf9RuBfPI4mRtRpPhLb92+j5O1M3uhrmc1Vx2xmJ+5ME15
	gMq9uH1cRBDiW1kGZ5I8Ivwud5rBrqqW+7XFrU
X-Google-Smtp-Source: AGHT+IH2B0Wl7/2mhc/dmy61nzYfb9Nb6G3qSwyQkkadVrgaNh2yV/DQQ5NpMTbgCfBM/+NSQqU6gORWSjOu8r8m7hA=
X-Received: by 2002:a17:907:7fa2:b0:aa6:af66:7c89 with SMTP id
 a640c23a62f3a-abf261fba16mr431180566b.5.1740760777391; Fri, 28 Feb 2025
 08:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226024741.2274-1-xuewen.yan@unisoc.com>
In-Reply-To: <20250226024741.2274-1-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 28 Feb 2025 17:39:26 +0100
X-Gm-Features: AQ5f1JoWAaJb-NDIzruSdz-cxOA435FUf7qB7nREUr_0Mxkf00HfWS0WEIj-CfM
Message-ID: <CAKfTPtBB6FH+5G5eRxC-0UA3H_M6Qt=CvKfCNvHy2=Dg0EEMxw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Fixup wake_up_sync vs DELAYED_DEQUEUE
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 03:51, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Delayed dequeued feature keeps a sleeping task enqueued until its
> lag has elapsed. As a result, it stays also visible in rq->nr_running.
> So when in ake_affine_idle(), we should use the real running-tasks

typo: wake_affine_idle

> in rq to check whether we should place the wake-up task to
> current cpu.

fair enough

>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..2d6d5582c3e9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7342,8 +7342,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>         if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>                 return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>
> -       if (sync && cpu_rq(this_cpu)->nr_running == 1)
> -               return this_cpu;
> +       if (sync) {
> +               struct rq *rq = cpu_rq(this_cpu);
> +               int nr_delayed;
> +
> +               nr_delayed = rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable;

Could you encapsulate this in a helper function ? something like below

static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
{
        struct rq *rq = cpu_rq(this_cpu);

        return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
}

> +
> +               if ((rq->nr_running - nr_delayed) == 1)
> +                       return this_cpu;
> +       }
>
>         if (available_idle_cpu(prev_cpu))
>                 return prev_cpu;
> --
> 2.25.1
>
>


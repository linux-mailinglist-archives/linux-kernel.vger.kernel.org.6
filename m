Return-Path: <linux-kernel+bounces-274562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B7947A14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2891F21F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5455153803;
	Mon,  5 Aug 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hysu3CgY"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8281311AC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855382; cv=none; b=YrVEYcQk18GWv9k1BrZwjKOFRewMwVceYmuz39ng12rowOccKgAoJkevYuyqgCe4PKcobn2yy1tFYjska7VZ18ocdITCv96uDtWVxRUEpsfI8zatEgv+XufGYUiw68Z3Z15/MfUd07FGWKFi4uN2ghlZeCuWM/y9nSBOHp4vXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855382; c=relaxed/simple;
	bh=0ZnCX28o0VdHtiHIqixDMQC3VWmh/RlKQ6uygb37BTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gf/lVX011zV+IDT6RMQWX+hVDmFunjO79AVw0c95WV9XJQaby/hbmhTkjgf1xsKme/UMtr2xQ0VXA7kxY1It5mFp9FsbLMtX2lUt4PsA1JUyyfhneR5TVXJ3Hg+zv3/RO+BOPQ42IGQs1kuonrERufRo/gxrXbF9wk+BHIhkCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hysu3CgY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2b921c48so7970525b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 03:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722855380; x=1723460180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DebKR2QCnIbO3IJufUx5D4RwN5BvbXHfrOG2LRYkfVY=;
        b=Hysu3CgYMIbaR1Kn8nkmEyzrZaEWQXaocnoViKsCfyMuLqw94DgTjrMaKei1Txfgdg
         K9GpoZIDNU6/0oU+XKI1HospXePm4wcXtuzsPLzqfZkoNtpUC8FvNLYDlDFKaA/+dvUR
         pEd8ME8JleSvYNkF/0obefz1HsyR/mb9K39fHLJ9E4khqzzQSNxFr8S47SRWC74jcTOV
         t7rVGzT1Ch9zVb+Mrby3UBultgTywnjo1vcVIfKOjhEu9eXo7Z8ukRFU+zQrZLtnxuVv
         QrIl2BiTlezh5JE77uOAFqJtXAigKZFf5BiAI1x/9RCZjAND3nm/WXmV/TqrY/ywq/Gl
         txMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855380; x=1723460180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DebKR2QCnIbO3IJufUx5D4RwN5BvbXHfrOG2LRYkfVY=;
        b=NLmiSDCQ6ya010qJ1Dp7IHv0sGU+FbFzKM9dq1LGlrqd6Q4CpXyMbfR7C3980OzN28
         MAh1xhP8UnWkPonnQQIRhGWOL/PyzFkZ8kZfpHXPh/6CCYULSxEK5yFqltbladKjU4mU
         H2Kabp61r5JjI1unG8HJoahLQ0bPmxAeHQSNjuPSXQqBnk6SBbO8qMkDM9HlPoe7Gde+
         vrmX0eI/wU4eM8Ag4uh53ghEfmrZ6NRVkURqL9SnPDS9BKnoU0e1j4vjmiQ/yoW2bb4Q
         LNv5rGABM6aXBfRjR1XPrJgxiXBeeG1nErsvhbYhv/8k0RMqjHTp0RAAi8cT3/cVH8p4
         CTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf4TNcGfTwBZWpvQ7bDOVDQgd38ckk14v6HGrDlndGZyyZonaCAPBjDs8f+cGHcNHWq6Nr4DXey4O8fwka2UnoONjjxby3JbBK4b9x
X-Gm-Message-State: AOJu0Yw/uO8lG/eMENKk4RcjZqa7He7jZo2uR2n+818Lbz0J/omOYT6U
	cPubygjGWLEKvuRdK2+vZjs2kQyjSMTxf4Yxb9ZYrW40NAmFVdw86qapaNFpdNOBrnsohdFbaa/
	HZxWXESflHn+j4UAWoLlTW5QmMJ+Fs2O1nqQk+g==
X-Google-Smtp-Source: AGHT+IFtDTfxHWzg1qKfoJTY+FRxzlTZ+Y41GXROnL0GzgZWfZnQobvquPcKCrUv3faH01hLW0EnJyagAn1+zpUjbPE=
X-Received: by 2002:a05:6a21:609:b0:1c6:ac08:8dd2 with SMTP id
 adf61e73a8af0-1c6ac088f1emr4301860637.15.1722855380354; Mon, 05 Aug 2024
 03:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729070029.407884-1-yu.c.chen@intel.com>
In-Reply-To: <20240729070029.407884-1-yu.c.chen@intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 5 Aug 2024 12:56:09 +0200
Message-ID: <CAKfTPtD4Vg8rjWVAp=WnaCoMXkee6y2Vd7LT2FyMMtHGtORa5w@mail.gmail.com>
Subject: Re: [PATCH v3] sched/pelt: Use rq_clock_task() for hw_pressure
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Hongyan Xia <hongyan.xia2@arm.com>, Qais Yousef <qyousef@layalina.io>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the late reply on this

On Mon, 29 Jul 2024 at 09:05, Chen Yu <yu.c.chen@intel.com> wrote:
>
> commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> removed the decay_shift for hw_pressure. This commit uses the
> sched_clock_task() in sched_tick() while it replaces the
> sched_clock_task() with rq_clock_pelt() in __update_blocked_others().

Good catch, it should be sched_clock_task() everywhere

> This could bring inconsistence. One possible scenario I can think of
> is in ___update_load_sum():
>
> u64 delta = now - sa->last_update_time
>
> 'now' could be calculated by rq_clock_pelt() from
> __update_blocked_others(), and last_update_time was calculated by
> rq_clock_task() previously from sched_tick(). Usually the former
> chases after the latter, it cause a very large 'delta' and brings
> unexpected behavior.
>
> Fix this by using rq_clock_task() inside update_hw_load_avg(),
> because:

No, don't call the rq_clock_task() inside update_hw_load_avg(), keep
it outside. V2 was the correct solution
Nack for this v3. Please come back on v2

> 1. hw_pressure doesn't care about invariance.
> 2. avoid any inconsistence in the future.
>
> Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> Suggested-by: Qais Yousef <qyousef@layalina.io>
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2>v3:
>   call rq_clock_task() inside update_hw_load_avg() to avoid any
>   inconsistence in the future. (Qais Yousef)
>   Added comments around update_hw_load_avg(). (Qais Yousef)
> v1->v2:
>   Added Hongyan's Reviewed-by tag.
>   Removed the Reported-by/Closes tags because they are not related
>   to this fix.(Hongyan Xia)
> ---
>  kernel/sched/core.c | 2 +-
>  kernel/sched/fair.c | 2 +-
>  kernel/sched/pelt.c | 5 +++--
>  kernel/sched/pelt.h | 6 +++---
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a9f655025607..011d447e065f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5462,7 +5462,7 @@ void sched_tick(void)
>
>         update_rq_clock(rq);
>         hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
> -       update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> +       update_hw_load_avg(rq, hw_pressure);
>         curr->sched_class->task_tick(rq, curr, 0);
>         if (sched_feat(LATENCY_WARN))
>                 resched_latency = cpu_resched_latency(rq);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..193ac2c702d9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>
>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -                 update_hw_load_avg(now, rq, hw_pressure) |
> +                 update_hw_load_avg(rq, hw_pressure) |
>                   update_irq_load_avg(rq, 0);
>
>         if (others_have_blocked(rq))
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index fa52906a4478..06a5fa85327c 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -400,9 +400,10 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>   *                     capped capacity a cpu due to a HW event.
>   */
>
> -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> +int update_hw_load_avg(struct rq *rq, u64 capacity)
>  {
> -       if (___update_load_sum(now, &rq->avg_hw,
> +       /* hw_pressure doesn't care about invariance */
> +       if (___update_load_sum(rq_clock_task(rq), &rq->avg_hw,
>                                capacity,
>                                capacity,
>                                capacity)) {
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 2150062949d4..261172c29f8f 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -8,7 +8,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>
>  #ifdef CONFIG_SCHED_HW_PRESSURE
> -int update_hw_load_avg(u64 now, struct rq *rq, u64 capacity);
> +int update_hw_load_avg(struct rq *rq, u64 capacity);
>
>  static inline u64 hw_load_avg(struct rq *rq)
>  {
> @@ -16,7 +16,7 @@ static inline u64 hw_load_avg(struct rq *rq)
>  }
>  #else
>  static inline int
> -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> +update_hw_load_avg(struct rq *rq, u64 capacity)
>  {
>         return 0;
>  }
> @@ -202,7 +202,7 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  }
>
>  static inline int
> -update_hw_load_avg(u64 now, struct rq *rq, u64 capacity)
> +update_hw_load_avg(struct rq *rq, u64 capacity)
>  {
>         return 0;
>  }
> --
> 2.25.1
>


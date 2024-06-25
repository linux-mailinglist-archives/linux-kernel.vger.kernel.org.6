Return-Path: <linux-kernel+bounces-228556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F48916194
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE1284A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000914A4CC;
	Tue, 25 Jun 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcOu3FrC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C414414A0BD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305178; cv=none; b=rHo9EAUjqMneDArYpq018XUqL69EJZ5x+XoI+Sz+NIAqWYai3TGBij4CRbedo3DHiq1dvfglpgHNSDY/3ybYm6bcL1LtCf7po75DCFgfdoI23/gU4+To4nSowaCkR2RsFhXjdCRnNmbgbAufXGa0v+djnWFtL5TeUQynFwNl1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305178; c=relaxed/simple;
	bh=A8dT2Vj6KX1UPhU1R+tXcw80Gn0PEvLvxaOJNemMGhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2rxsBCJGRJVbMHeooXPUtmTQuPiRYFkIk80nxvui1yvEiYcNvpO/AOgGRyRRW2Dz3kJwViI7Cu+L7bN9YbLZcNSMQfoxQPIsxv9S7N10Ccol4ekA/VdmSiHcVWlWWml5w6lmgGwYN5WHC+ZtJC/cvp7Yngl//QoTkHDrNzkOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gcOu3FrC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7066463c841so2111231b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719305176; x=1719909976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1EuKR7v0qrx0FV/abbpTdHWFw/NHcRuHwFgDNDQL0Mo=;
        b=gcOu3FrCIqu5xkUZp03hSS2BMyNwKvaAlo+8yP5S4vJOMl2sYwZs957bWsLc7OrxDb
         4iwt+56+h6uNdgv5ujwevyS1puw0poXsQACRqGhcUPVyF81mnQMEEzj4ztc1zSL88Cg4
         rakrV56UQZiHaexEIdJEI0krKoSLRY7dnXmiURYFT6LQ1Bey1IOAdxd6UNcJsX6MSqaw
         IL4ZQBZsi8ZKOszs2/msgTDdqIzr6XjJtUoiJEdfvKyUtNHcvDO7GNnEQTL5ssyj4gwE
         gVSk/xJVRbFNlommVbOa3fmrVPeh5fd4yEU/IJXz40O2EJ4PUHPBkg4LnRt8l4irNkDi
         2zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719305176; x=1719909976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EuKR7v0qrx0FV/abbpTdHWFw/NHcRuHwFgDNDQL0Mo=;
        b=kV400dHuKu9ahS/Ml2Xn67Q0VwiquZxK9zOCruse4TlmWxosRkLmjj0YroUqr4VrKj
         3Mg2vrQ/OVhaud46mWE6tzoaBHbcbDfWb5l7ztxHhn2xGlyC4Ssy2BSpBFZBm8ejGjWo
         kF2/Qdo49wdczkBH/hdbjDOGM8FSrFQouVD+zmcAezAEpuOJSb8gQUtOsMpWWJ4BAKVr
         dSYhAKpt26mwTT/lpkCKL4FYUD+cmqHw32RNg/nD9+5E7UTHWoSbeCLOnXw90e8gfMdI
         77YoAiChmC36k4TNNFDQ0ZATBUPYFU0366+5t9qtA/oMlsu/is0fksG+fAwt7yEPEfrU
         HXrg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQAWXCAQAV80u8RtFwkUhZ4vpgi/MwUhqYg8fuBHXerps7ggbFyW79E0v76ScRi4ppJ8wyPhl/cIMQdb+sNRED/+CmtGDkJG258Kg
X-Gm-Message-State: AOJu0YydcaHE+ZgCjWiM03/zpz5ZzUPDW6MbP23RJlJAQxHAmcraVHbI
	J4QvXLSqzfvVmvndxOL2VJhrJ965KYzsOuKqKiXNrbypH4b2bxenvoTqrxwYdP9pcIwrdC1YVI5
	NN/vseWRojEne1hZLS9XvSVVr0g5RmXQMkFtbOA==
X-Google-Smtp-Source: AGHT+IFd8iHnu8mn97BBdf8g38ahhKlAVM76tEYaZS33HNTYfufy9nJIcM5BZVuTgKor6o88K4QUpcNaJett+3Pfv7I=
X-Received: by 2002:a05:6a20:aa91:b0:1bd:226e:4968 with SMTP id
 adf61e73a8af0-1bd226e4ab6mr581503637.45.1719305176054; Tue, 25 Jun 2024
 01:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082011.4990-1-xuewen.yan@unisoc.com> <20240624082011.4990-3-xuewen.yan@unisoc.com>
In-Reply-To: <20240624082011.4990-3-xuewen.yan@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Jun 2024 10:46:05 +0200
Message-ID: <CAKfTPtB+BKvJ=tgn6fPgXOz2YJHz+VPoLgz+h9R-shT6cwXsXg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in util_fits_cpu()
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, qyousef@layalina.io, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com, 
	di.shen@unisoc.com, xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 10:21, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> Commit f1f8d0a22422 ("sched/cpufreq: Take cpufreq feedback into account")
> introduced get_actual_cpu_capacity(), and it had aggregated the
> different pressures applied on the capacity of CPUs.
> And in util_fits_cpu(), it would return true when uclamp_max
> is smaller than SCHED_CAPACITY_SCALE, althought the uclamp_max

s/althought/although/

> is bigger than actual_cpu_capacity.
>
> So use actual_cpu_capacity everywhere in util_fits_cpu() to
> cover all cases.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5ca6396ef0b7..9c16ae192217 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4980,7 +4980,7 @@ static inline int util_fits_cpu(unsigned long util,
>                                 int cpu)
>  {
>         unsigned long capacity = capacity_of(cpu);
> -       unsigned long capacity_orig;
> +       unsigned long capacity_actual;
>         bool fits, uclamp_max_fits;
>
>         /*
> @@ -4992,15 +4992,15 @@ static inline int util_fits_cpu(unsigned long util,
>                 return fits;
>
>         /*
> -        * We must use arch_scale_cpu_capacity() for comparing against uclamp_min and
> +        * We must use actual_cpu_capacity() for comparing against uclamp_min and
>          * uclamp_max. We only care about capacity pressure (by using
>          * capacity_of()) for comparing against the real util.

actual_cpu_capacity() includes capacity pressure so this comment needs
to be changed.

>          *
>          * If a task is boosted to 1024 for example, we don't want a tiny
>          * pressure to skew the check whether it fits a CPU or not.

In think that the pressure in this case is about DL, RT and Irq but
not OPP capping because of thermal pressure for example

Also, the returned value is not a boolean: fit or not fit but a
ternary for the case where it doesn't fit the uclamp min. In the later
case, the CPU is still considered as a candidate

>          *
> -        * Similarly if a task is capped to arch_scale_cpu_capacity(little_cpu), it
> -        * should fit a little cpu even if there's some pressure.
> +        * Similarly if a task is capped to actual_cpu_capacity, it should fit
> +        * the cpu even if there's some pressure.
>          *
>          * Only exception is for HW or cpufreq pressure since it has a direct impact
>          * on available OPP of the system.
> @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
>          * For uclamp_max, we can tolerate a drop in performance level as the
>          * goal is to cap the task. So it's okay if it's getting less.
>          */
> -       capacity_orig = arch_scale_cpu_capacity(cpu);
> +       capacity_actual = get_actual_cpu_capacity(cpu);
>
>         /*
>          * We want to force a task to fit a cpu as implied by uclamp_max.
> @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
>          *     uclamp_max request.
>          *
>          *   which is what we're enforcing here. A task always fits if
> -        *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> +        *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
>          *   the normal upmigration rules should withhold still.
>          *
>          *   Only exception is when we are on max capacity, then we need to be
> @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
>          *     2. The system is being saturated when we're operating near
>          *        max capacity, it doesn't make sense to block overutilized.
>          */
> -       uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> -       uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> +       uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> +       uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_actual);
>         fits = fits || uclamp_max_fits;
>
>         /*
> @@ -5086,8 +5086,7 @@ static inline int util_fits_cpu(unsigned long util,
>          * handle the case uclamp_min > uclamp_max.
>          */
>         uclamp_min = min(uclamp_min, uclamp_max);
> -       if (fits && (util < uclamp_min) &&
> -           (uclamp_min > get_actual_cpu_capacity(cpu)))
> +       if (fits && (util < uclamp_min) && (uclamp_min > capacity_actual))
>                 return -1;
>
>         return fits;
> --
> 2.25.1
>


Return-Path: <linux-kernel+bounces-442965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36F9EE4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C861885C86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DD21146F;
	Thu, 12 Dec 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/CwncCs"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3B1EC4D2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001528; cv=none; b=izv+JM9Bhwr2amXNAK3ErO1t9mQ6wy1GsWH/QxJRHl0ckRRUZWqnhPlpu8wP17DuVLLq0PFvwxu1QuHLfpWuWFPnc/MYPj89lcn3Vmjww3UaForCQbPfHCniMoMfZLvEHoA+RxRPG4InkfrlR7NXpQIpa/envmS2etneYocj+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001528; c=relaxed/simple;
	bh=Ipdeix/XefLKAtjdiRa++0aOFcP2WCZUy1NH8/f5pJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY9no/85lyLc1sjC31JeAPA9AU0A5WeaIvWcHjhlvL06aadunUQJc6tkwV9zeHjD2LcrPGagTLxO33flD2G2ArbyfLvLlS/pqP896H75CWED0gwZAufVWjJXKxAlDq6u0yy8MMbWSDEBUVcAYiuzxOqA+WgOJ1Vap3M7HbeTxVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q/CwncCs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so4490305ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734001526; x=1734606326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTybfhgDRB596CpCi4fjqRRbuOW0bslqmx+ej9n187g=;
        b=Q/CwncCs5Di9Aq0KbtXjuR6VLm6eGlOgD3AWqF9J5KT7cyfhAR/GzCvGIQnDJeNpju
         C40whXwL3FaYSeorwd2TW8IDvacsBen69K6nLyqf2aVeVMh9mY4DMy74ZH2ExMzYjyR/
         3L6TIr0x4VXtVZy1QSOXsdakDFTvjN7h8tM74VZ7MfO6bZtZ/cSMS4cJyRvwFHnWKJeD
         lg5SEL7gCWyksm8ZHHUftI3VzsuSsl6kGGOYgxG7veX8zhY9oXz67GKzDqHuahSGm4Kd
         jZbUOEJGDCoMTE//0kYMJwopROVB2hbpLKFf8GmG08C95dZA0xvbwmX7p2J3u4PpkU4d
         gBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001526; x=1734606326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTybfhgDRB596CpCi4fjqRRbuOW0bslqmx+ej9n187g=;
        b=utmukMdRu2nh/PGD32yXZ5GLQ36YZ0+Q5s/r3azHdILmjbEFxHi+mv/MPtzh5DIfeG
         q2RghN8Zv5zo9iRtvtbuR7V5F9qlaUT+sE5M57ne1KBN6+RLsJZqnCeM+hVIQOKX7quW
         3DK9SG2KXH2J6M6M30kgD4R8RzJzTWkeYHhGvdHXGKi8FzUs3hv39FTiIzsJIvwwm3+e
         Hz11HK1DrCFqoMH/SXZ+CX5bsyX7lvshiEJliF+5RI6ctmfEz/nv9WdpepK5P3yKCt3U
         otRpQskBH1G6nsaBbUd8EIdygdgWKCvVHp/WjNyu0sPT6EYZV0Rz2rpYDeXVTKjTEP/0
         1piQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPcnFpFfKlN4iYOiuspGOoRlo/kGmmVnWSe/+K9j0bx9s/xGeZToNsTgUT3z3OG2G5pt/cchhYRwvMIqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZOQSpUfHFKRm9g8cmAZWB8E0XDSPl5zPYKp2fVf5oFs6s6se
	vw5Mn18+8jPLWAjnTigJOTzB263fXcdkBbxFwyZRSxrAWI/NP+gKJoutRMmNE86yS63JxuGD7Ik
	ttkGvOHaoffU8lWhBtXz6mchn34FDrA4uxLxJ5w==
X-Gm-Gg: ASbGncs+XEbYrmTWO4v9WxILd9xmXiEy4RtR6oCoobPHjFojdbSy2h5eJ/SSo+LRQG2
	tDhBGZywsaNGE7wHsWlADDZVGSyzuKIXI8ihe0w07leLGPsjgkRG56URIgiuNzXVjMNE=
X-Google-Smtp-Source: AGHT+IF93J/ZpITDjD/uAMAA/0HJM3y3IrsdaUyK7n+BQQT4RokGeZlVoLMbB3+Ztund+6jpVgI0Zp9Ol/qddh5hKgQ=
X-Received: by 2002:a17:903:41c3:b0:216:668d:690c with SMTP id
 d9443c01a7336-2178ae80af2mr53927895ad.28.1734001526163; Thu, 12 Dec 2024
 03:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211185552.4553-1-kprateek.nayak@amd.com> <20241211185552.4553-7-kprateek.nayak@amd.com>
In-Reply-To: <20241211185552.4553-7-kprateek.nayak@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 12:05:15 +0100
Message-ID: <CAKfTPtAd-0e4B6qh3e5VeK0N1Q+zsXkV5WdCunV6x9yzY7Y_Ow@mail.gmail.com>
Subject: Re: [PATCH 6/8] sched/fair: Do not compute NUMA Balancing stats
 unnecessarily during lb
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Aggregate nr_numa_running and nr_preferred_running when load balancing
> at NUMA domains only. While at it, also move the aggregation below the
> idle_cpu() check since an idle CPU cannot have any preferred tasks.
>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2c4ebfc82917..ec2a79c8d0e7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10340,7 +10340,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                                       bool *sg_overloaded,
>                                       bool *sg_overutilized)
>  {
> -       int i, nr_running, local_group;
> +       int i, nr_running, local_group, sd_flags = env->sd->flags;
>
>         memset(sgs, 0, sizeof(*sgs));
>
> @@ -10364,10 +10364,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 if (cpu_overutilized(i))
>                         *sg_overutilized = 1;
>
> -#ifdef CONFIG_NUMA_BALANCING
> -               sgs->nr_numa_running += rq->nr_numa_running;
> -               sgs->nr_preferred_running += rq->nr_preferred_running;
> -#endif
>                 /*
>                  * No need to call idle_cpu() if nr_running is not 0
>                  */
> @@ -10377,10 +10373,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                         continue;
>                 }
>
> +#ifdef CONFIG_NUMA_BALANCING
> +               /* Only fbq_classify_group() uses this to classify NUMA groups */

and fbq_classify_rq() which is also used by non-NUMA groups. AFAICT
It doesn't change anything at the end because group type is "all" for
non numa groups but we need some explanations why It's ok to skip numa
stats and default behavior will remain unchanged

> +               if (sd_flags & SD_NUMA) {
> +                       sgs->nr_numa_running += rq->nr_numa_running;
> +                       sgs->nr_preferred_running += rq->nr_preferred_running;
> +               }
> +#endif
>                 if (local_group)
>                         continue;
>
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +               if (sd_flags & SD_ASYM_CPUCAPACITY) {
>                         /* Check for a misfit task on the cpu */
>                         if (sgs->group_misfit_task_load < rq->misfit_task_load) {
>                                 sgs->group_misfit_task_load = rq->misfit_task_load;
> --
> 2.34.1
>


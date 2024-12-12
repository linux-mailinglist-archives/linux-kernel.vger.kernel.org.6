Return-Path: <linux-kernel+bounces-443123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333779EE7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615FC188889B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CC2144AA;
	Thu, 12 Dec 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k30gSIPl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD521421C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010096; cv=none; b=fY2aTka32pCA0SuPdNWhJPG9fok+/rcykZkCvRsQEyOjdlLhg6owUNoVsHtvOjNXalQl2D6ELIhVmnXW60F/pXqUYRa+NELCUdfkODrCMC4tUqJC/aOvx+GPyfN3uT2cMIVwNpXxpnzgDdUotIT3Lk2rVgev0HrctLCigMnBKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010096; c=relaxed/simple;
	bh=gS1eG0NY5UMAZM2QX/wEPLckgnezYmnWRUuer7b0PWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8zaVIGUa2UiLlluW9vAsgZV/5tG3uNCVY90w7iGSeq6PADxon3bxs6MAEMEkmMl5P0fdG2ur4LJEKj8wBSTFpvVU/sVHd7hLk+iEH8zWQ954Mi4cftiCWW0F64r6HMsVvflRohnVfdyCd1HgzbP4diWaaqRNCzXIP51exv50cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k30gSIPl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725abf74334so478502b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734010093; x=1734614893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rck+fGyCtcyfCLQYkWgvo4X14XA/qe70w+Ne3TwE1A4=;
        b=k30gSIPl7PFNV+yNjBaENx0z/1/D1F5sNYgmdx3XWmXFxUaOBOn13UBmgf+lqW3lxT
         R5TQlky6ncclMRY6cstGB8r5XI+wyeOmFMaZ6rClbhmJMrLDj0FB1ay4QPClOvqEuRs2
         ZHu79LG4cgszV+a+607l52DKU33R7iDF7Zwbm1I1PgI+AiTjL3Om+03iRMksJIdrkObH
         HYdRT0lkUhzxxnYGdGHi4cxSlLywzghBFMvRtdbpZIfoHQ+WK23FWABWG1ylTMfqGSLx
         Wxb52nZxXQvf8J7uRSCDnMx3Ycq72bkng44eqMAE01euWHePgIkogGxHcpZBnGs+NDYM
         ujMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010093; x=1734614893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rck+fGyCtcyfCLQYkWgvo4X14XA/qe70w+Ne3TwE1A4=;
        b=PNQhlAnmFLivldvrZvVjjrMJhZhyduHs0FHv6BTvPT2FJ9IfMcdxN0R7LXNT55zhsk
         9LCtqaCQFB/eODZHJriB2jmc5JB5S4Cdgi/nRR5CoFipSNYV0ZUevjN96cv6tNJymvr7
         GBZ+c8kesLQgOdkz5t7iMafPwA+x/UyfdAMLMSOjZwzj91VPc9zs5rOlCedhLWkJCBkJ
         AMKc70C166bGkmz2NmvIOct3slJfM+jBNL23RC8nQGu6LViGYpTLLXkLJdKKYDej1qwA
         oIuDHbD6bWZvZliT5oTyS/eWgm1/zrhsy23PpCTRqtRTP168YcHeP5KibpQl8b+6hqRn
         BVqw==
X-Forwarded-Encrypted: i=1; AJvYcCXDl3m9suxkCwKWAiaiYbdsp/CySjHIO+UOUmgse0RzytHz4f+R9xnHPd/kDP+OcPit9c3EE7EUGIsq5QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFmxLURETnpCLKptkuES+QuM+526EOry77fd8bx1HL7KkDw9+Q
	q+AF7cdV6H0b9etlOkMfxqkRh6ALaVz0kTJfx1ZOrU8WpNerwYJK2p2U3D1dFtbCG72xUV/xSNl
	gAqkFjmE+pdh9VMhH7a8cwLNJiPu/mkJffH/wUg==
X-Gm-Gg: ASbGncvTLgVrvnRXV858piDgCW7+WRLzrLFkAnxx3ZxM+pDfEo1EDq4bPK30YKfk/UB
	m/gh6kM4OgI0IdQpjqkASFFtF8iX7hIGB2S3V9j4JhHPew2YXeuX1957yhEuUVceUP/M=
X-Google-Smtp-Source: AGHT+IFuOhKw3Qt3BdCvrXvaP7JCsfpTLq18r3gk4f/eN8w1rFUkysCnn4ogsRU7l+EELYbDPxECzEdMwgNi5j0Fiwc=
X-Received: by 2002:a05:6a20:6a25:b0:1e0:d105:1f42 with SMTP id
 adf61e73a8af0-1e1dab408bcmr495895637.15.1734010093229; Thu, 12 Dec 2024
 05:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211185552.4553-1-kprateek.nayak@amd.com> <20241211185552.4553-7-kprateek.nayak@amd.com>
 <CAKfTPtAd-0e4B6qh3e5VeK0N1Q+zsXkV5WdCunV6x9yzY7Y_Ow@mail.gmail.com> <b9315505-efcf-479f-b8ee-c660265c8e53@amd.com>
In-Reply-To: <b9315505-efcf-479f-b8ee-c660265c8e53@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Dec 2024 14:28:01 +0100
Message-ID: <CAKfTPtCgkrN3-f86zfZOzDMgWvVHFYdcy84K015c52idqXLioQ@mail.gmail.com>
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

On Thu, 12 Dec 2024 at 12:44, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 12/12/2024 4:35 PM, Vincent Guittot wrote:
> > On Wed, 11 Dec 2024 at 19:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> Aggregate nr_numa_running and nr_preferred_running when load balancing
> >> at NUMA domains only. While at it, also move the aggregation below the
> >> idle_cpu() check since an idle CPU cannot have any preferred tasks.
> >>
> >> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> >> ---
> >>   kernel/sched/fair.c | 15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 2c4ebfc82917..ec2a79c8d0e7 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -10340,7 +10340,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                                        bool *sg_overloaded,
> >>                                        bool *sg_overutilized)
> >>   {
> >> -       int i, nr_running, local_group;
> >> +       int i, nr_running, local_group, sd_flags = env->sd->flags;
> >>
> >>          memset(sgs, 0, sizeof(*sgs));
> >>
> >> @@ -10364,10 +10364,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                  if (cpu_overutilized(i))
> >>                          *sg_overutilized = 1;
> >>
> >> -#ifdef CONFIG_NUMA_BALANCING
> >> -               sgs->nr_numa_running += rq->nr_numa_running;
> >> -               sgs->nr_preferred_running += rq->nr_preferred_running;
> >> -#endif
> >>                  /*
> >>                   * No need to call idle_cpu() if nr_running is not 0
> >>                   */
> >> @@ -10377,10 +10373,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                          continue;
> >>                  }
> >>
> >> +#ifdef CONFIG_NUMA_BALANCING
> >> +               /* Only fbq_classify_group() uses this to classify NUMA groups */
> >
> > and fbq_classify_rq() which is also used by non-NUMA groups.
>
> Yup but that just looks at rq's "nr_numa_running" and
> "nr_preferred_running".

Ah yes, I misread and mixed rq and not sgs.  You can forget my comment

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> > AFAICT
> > It doesn't change anything at the end because group type is "all" for
> > non numa groups but we need some explanations why It's ok to skip numa
> > stats and default behavior will remain unchanged
>
> I'll elaborate that comment with complete details:
>
>         /*
>          * Only fbq_classify_group() uses these NUMA stats to derive the
>          * fbq_type of NUMA groups. By default, it is initialized to
>          * "all" - the highest type. sched_balance_find_src_rq() inhibits
>          * load balancing from runqueue whose fbq_type is found to be
>          * higher than the busiest group's fbq_type but since it is
>          * always initialized to the largest value, and remains same for
>          * non-NUMA groups, skip this aggregation when balancing at
>          * non-NUMA domains.
>          */
>
> --
> Thanks and Regards,
> Prateek
>
> >
> >> +               if (sd_flags & SD_NUMA) {
> >> +                       sgs->nr_numa_running += rq->nr_numa_running;
> >> +                       sgs->nr_preferred_running += rq->nr_preferred_running;
> >> +               }
> >> +#endif
> >>                  if (local_group)
> >>                          continue;
> >>
> >> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> >> +               if (sd_flags & SD_ASYM_CPUCAPACITY) {
> >>                          /* Check for a misfit task on the cpu */
> >>                          if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> >>                                  sgs->group_misfit_task_load = rq->misfit_task_load;
> >> --
> >> 2.34.1
> >>
>
>


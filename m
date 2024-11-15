Return-Path: <linux-kernel+bounces-410221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A39CD691
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37101F22E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95C17BB32;
	Fri, 15 Nov 2024 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkH8nzSM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2017BB38
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648346; cv=none; b=oR3fTrl5EIdigBrygdlIv9aDfTqqXbEoRDUx1S0OusWRWLS5PRFkRQnRPfTzPjxBeFbzrwdUuPYu7Rm0xJ9f3Dza3muiHLtBS2xL6gMQ0PebweKnWYwrY6XzPJIqqFS8gr2bsjLzPxPCVIPLJIOwVMNK2XKgLpiIszczqolce18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648346; c=relaxed/simple;
	bh=r4qE6pAi391fVNTs0ciCtenv4AsvjDv5FIpR9MqaxDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgPv8k5HATVDbL8M8m1kXIcxT0PhlxfVr10hs13yFhHjjFNqxgoAhuEJnyBq/lFP/QGOU18vSom3nW48w9l4MFp0s4e2xZwLas8uNveTMabJ1LHkhPmuSILlYP2pV5sDJZr/W+Ypn1UlX7TI077SqK7kxkRwFqSsW7Iu2Sjds1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkH8nzSM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso1183282a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731648345; x=1732253145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osbOQ205Fj8sGFg52Vh4/TEHRvJRMsj+Q3BRLkDvW50=;
        b=KkH8nzSMrTrFAV1kc8nzRmRK/AnU3ZQHLABWcOpejrZKZhOQi3KpLiZ7Aa5q1G0Qb7
         9P1R/hJ+Juxxn0V+f1Yw+tYru5vO1aapayCqXfcUnXSS7njvWTKCKIIAvL6u7d97zK75
         YM/UzHRWrwfXL1cG0C/xIXRxEmIa3YPO9sp7pLS8ERTCQlU1/tIsFW9JTAouBT5HuL0D
         n3cFzJmM7O3iJ60U9oLg3INhE7BddZ7XjNfYDaYAtlDcZFVZAUinj9O8oAese/3eqhi4
         urrtGcCMlDeDIo0ipiGU7LOTfE+6hzlC6B7TIsYZeQMq7PFnKS5DtKffsCkG1+oBhPuq
         dj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731648345; x=1732253145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osbOQ205Fj8sGFg52Vh4/TEHRvJRMsj+Q3BRLkDvW50=;
        b=dBIE52dGliKcgXHTC5VYcfAqmEBI11nCUBI9nP4s5yZuge6L8KI6acOtk+LyPo6vQW
         fHNXVg9+RPKa2tnfeSiVjTc6fp0dPBppQWDOUwgWcY8pAglzfSwDyquHBorbSt8WJ7Eq
         EJE1+FgWdIexCv3SlXmC6hnNSehAtZTxo8AktV37JP+wuDxz8aAzvhVjFet1O3fnJ6Dm
         7zwNvvsCAVweg7xigv4o4quznxkGO+o9QQZuKiO3CQ88RdM2DMtnSvWBAMh+FWNrXjnm
         OQvcLvqFNiHf4sxJGIV2jlScVrT7WFasEtL6NqZ0U40UVQE89ThQQTuqvz8sVqXbQyFm
         3FKg==
X-Forwarded-Encrypted: i=1; AJvYcCX6/Ph4vWUwqHh3r8PT1RS40NODsmeH3fH4ugRzEjznKPAU1Q5S+WNEV+OyYAbZVXqoVocplUymXNYONWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81rW9zxJrBSpzsFTuDOZ2OIVYDLl9Q/rEGvGY6bZkz6sXlKzD
	U/7I0TkLuHI2hpxIZr0sjvMOqiAl29LaaI6T20vah4UjqhVmWJ84fPgJgc8vjKT73cS2fAJhb8t
	f7/a0+QGsFODGkWPnPCe6vHVcdT+Lp5XjpAUt
X-Google-Smtp-Source: AGHT+IG0soDP7jl1ThlSbrhU7yHrM/RjYPgOdo61Cgh6GPqF9T8/AcBUtb0UrZbwtpcFCcb1NKoZ0uq0LBQemXyYgpA=
X-Received: by 2002:a17:90b:52cf:b0:2e2:d9f5:9cf7 with SMTP id
 98e67ed59e1d1-2ea155662bbmr1679208a91.26.1731648344374; Thu, 14 Nov 2024
 21:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com> <20241114220921.2529905-6-saravanak@google.com>
In-Reply-To: <20241114220921.2529905-6-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Nov 2024 21:25:07 -0800
Message-ID: <CAGETcx8xni1vyoNts=C=dgEaMcfhsfo0B5Ef02jD3in0QqCB1w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, Bird@google.com, 
	Tim <Tim.Bird@sony.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:09=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> As of today, the scheduler doesn't spread out all the kworker threads
> across all the available CPUs during suspend/resume. This causes
> significant resume latency during the dpm_resume*() phases.
>
> System resume latency is a very user-visible event. Reducing the
> latency is more important than trying to be energy aware during that
> period.
>
> Since there are no userspace processes running during this time and
> this is a very short time window, we can simply disable EAS during
> resume so that the parallel resume of the devices is spread across all
> the CPUs.
>
> On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
> plus disabling EAS for resume yields significant improvements:
> +---------------------------+-----------+------------+------------------+
> | Phase                     | Old full sync | New full async | % change |
> |                           |               | + EAS disabled |          |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_suspend*() time |        107 ms |          62 ms |     -42% |
> +---------------------------+-----------+------------+------------------+
> | Total dpm_resume*() time  |         75 ms |          61 ms |     -19% |
> +---------------------------+-----------+------------+------------------+
> | Sum                       |        182 ms |         123 ms |     -32% |
> +---------------------------+-----------+------------+------------------+
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  kernel/power/suspend.c  | 16 ++++++++++++++++
>  kernel/sched/topology.c | 13 +++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..7304dc39958f 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
>         local_irq_enable();
>  }
>
> +/*
> + * Intentionally not part of a header file to avoid risk of abuse by oth=
er
> + * drivers.
> + */
> +void sched_set_energy_aware(unsigned int enable);
> +
>  /**
>   * suspend_enter - Make the system enter the given sleep state.
>   * @state: System sleep state to enter.
> @@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bool=
 *wakeup)
>
>   Platform_wake:
>         platform_resume_noirq(state);
> +       /*
> +        * We do this only for resume instead of suspend and resume for t=
hese
> +        * reasons:
> +        * - Performance is more important than power for resume.
> +        * - Power spent entering suspend is more important for suspend. =
Also,
> +        *   stangely, disabling EAS was making suspent a few millisecond=
s
> +        *   slower in my testing.
> +        */
> +       sched_set_energy_aware(0);
>         dpm_resume_noirq(PMSG_RESUME);
>
>   Platform_early_resume:
> @@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>   Resume_devices:
>         suspend_test_start();
>         dpm_resume_end(PMSG_RESUME);
> +       sched_set_energy_aware(1);
>         suspend_test_finish("resume devices");
>         trace_suspend_resume(TPS("resume_console"), state, true);
>         resume_console();
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..c069c0b17cbf 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
>         mutex_unlock(&sched_energy_mutex);
>  }
>
> +void sched_set_energy_aware(unsigned int enable)

  CC      kernel/sched/build_utility.o
In file included from kernel/sched/build_utility.c:88:
kernel/sched/topology.c:287:6: warning: no previous prototype for
=E2=80=98sched_set_energy_aware=E2=80=99 [-Wmissing-prototypes]
  287 | void sched_set_energy_aware(unsigned int enable)
      |      ^~~~~~~~~~~~~~~~~~~~~~

Peter/Vincent,

I noticed that I'm getting a warning for this line. But I'm not sure
what to do about it. I intentionally didn't put this in a header file
because I'm guessing we don't want to make this available to
drivers/frameworks in general.

Let me know how you want me to handle this.

-Saravana

> +{
> +       int state;
> +
> +       if (!sched_is_eas_possible(cpu_active_mask))
> +               return;
> +
> +       sysctl_sched_energy_aware =3D enable;
> +       state =3D static_branch_unlikely(&sched_energy_present);
> +       if (state !=3D sysctl_sched_energy_aware)
> +               rebuild_sched_domains_energy();
> +}
> +
>  #ifdef CONFIG_PROC_SYSCTL
>  static int sched_energy_aware_handler(const struct ctl_table *table, int=
 write,
>                 void *buffer, size_t *lenp, loff_t *ppos)
> --
> 2.47.0.338.g60cca15819-goog
>


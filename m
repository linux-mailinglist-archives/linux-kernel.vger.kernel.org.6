Return-Path: <linux-kernel+bounces-556533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B0A5CB75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB018978A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2339261597;
	Tue, 11 Mar 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUnz3c/i"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B2260A54
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712338; cv=none; b=o9vNveL8j5Zlk5dJ5DRJVPx8byyeVqWM5sjGdGMcFpHczdch89Aw185LqULkbcbeEsL3HMi2CnkzU0GUalv0jTsdoTjV841M9lbf+DrB1LhmeMKV7Maj/CTC6dt61yfTMk/sY4h3UHw9u3726N4yxK7v/g+Z+JveyaUQ9Eqt5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712338; c=relaxed/simple;
	bh=0jXEMRt6WJlDifuKhxLGG51HiUjQvJkfp1GiY+ZFzlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv3wpJhTveVp73eVnTZS0yRZJTuNp4NDHPBWYBVyahay4hv6nMqrcrQ1RdpUUIxTlaAX92/WjjTp3K48i+pjjDjBSCgpK7jZUS127kufaHSErQAyri8GcbdFw+mXsKX08zbcsC2wI39gv+c69Q7tHuD5BpukGdUq1C5JrgYcSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUnz3c/i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso464156466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741712335; x=1742317135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRLqpDKLAb/VKPsrnJ+FiVi7UcLVBsODIfQ1a3apJwk=;
        b=wUnz3c/iVMwHTB9NUg524sTPI1lMECnXbsA6hIQjt/BVexGnstpr8NT/cTMC69ocTT
         qFkG4hKBgRFpthJrwZbLRohJzhHBfBteL5vyEpj4Goq/xTRZQC0MNAfy70kWHYbSF+ou
         AnBnaRF9YSCXyaGMUOY90wVW+DRGO+H37s45xFNgymAKCs+MT5LQ61SCUa/IpZnckc/r
         vCANAPCo2yUPkSx/zofn5HUY4iecDbghhNSw4WaU8vi3yNGPhySVrEAlih7RY3xLmFD8
         tRxL0ZXgDl6xdkZKC21y6LQ6zs31LRNaFI7syybJQPB4NZTOHFGHoFpbBxJTyAYc8zKB
         Q2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712335; x=1742317135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRLqpDKLAb/VKPsrnJ+FiVi7UcLVBsODIfQ1a3apJwk=;
        b=CI0pC1EMwdFGtkGOzCEHtO2brQRXLGQjcwk0qn6kdXQEze1vzJ+TIBZY8LpKNgkVfe
         k0GoPTrrEnzs/U8juWI+flBcObhnxWy13vjXHTCgytOR/AzFoPMPRUSoiyc+g88Xmh8K
         HkLiOKxRtbvMs41Bq39aNUHDFJWqY01d5z2wmPxpG8bH8hkop8BDY78gbVy60JrmHOFF
         z0qtYcd/cP0l4Vfhq/b3O3Ln4sqi3sOtgZ94+VcMAjRf3kprHaU6tG/HVWTZ5Sn1RErR
         WLc8+2HCztRiN3esbV4xojUxRSonXMdM1LC6KC+Xfz4t4BDiymDlnne8SAqdm6P4A+w3
         vmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdQpW/W6I+WOTqB21/ZORNpGQqzf77QqSXQ9qyG65nQ5yc8nYWPnj2ewO8x3CNxr/KzXgX2UDD/MXIekc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7JJYnU4TjkM4S9kg0AD40HA8eG6yY4AV+TY24nT9j7F6Ych5
	5RzIhffmzP89TDPBBK+VKKyhqhTqvL03EqC9LfjZS1b6pDez9B2M5HQHnfdWpu60wnZYJ3CCnES
	R2x1nYORAg4o6+s0P/MFZlA7HkreXJCbH1KzqVA==
X-Gm-Gg: ASbGncvasw10p2iBff7TrpbIiabS4hB48Z+I7Bqj0boCujwKnuVYThrXje0V8BGif5R
	JL8Wv3vW2MT5nKQLl/SEGh4Pd+vYkir7K73Amoo1HmVyk3KIla4aNDT6G+RCy+AxZBfZojIBnOS
	leEMERNOuGc8Gp7aoeAZ8VBFLds8i3BXnOt0/cIlxWx8oYY6oHdChsXMQ=
X-Google-Smtp-Source: AGHT+IGfA1ra8nleP1GrptoBAFCaA1hbfIZth9qudqsEYiFqekCEme1oUNOvkLm/aVSoBLoi4qi/betdpgjtiLASyG0=
X-Received: by 2002:a17:907:2d92:b0:ac1:fab4:a83 with SMTP id
 a640c23a62f3a-ac252b5a837mr2153449566b.25.1741712334936; Tue, 11 Mar 2025
 09:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074044.3656-1-wuyun.abel@bytedance.com> <20250310074044.3656-2-wuyun.abel@bytedance.com>
In-Reply-To: <20250310074044.3656-2-wuyun.abel@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 11 Mar 2025 17:58:41 +0100
X-Gm-Features: AQ5f1JqFWgiXi8MahHsXwAk1-YEGyRa1b2aHZu5r09uztmq_UjTiaNYxVH4JlUU
Message-ID: <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU selection
 consistent throughout"
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 08:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.
>
> The above commit tried to unify selection policy between idle cpus
> and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
> by treating them equally (although the SCHED_IDLE cpus are turned
> to be given more preference in slowpath). The test results seemed
> solid, but the setup didn't take cgroup hierarchy into account,
> which actually made some of our important services get affected.
>
> The cgroup hierarchy in our production environment looks like below,
> which might be common in modern containerized setup:
>
>                           root
>                         /       \
>                 kubepods        system.slice
>                 /       \\              \
>         guaranteed      besteffort      containerd
>
>         (where 'X=A' means A is SCHED_IDLE cgroup)
>
> The cpu is treated as SCHED_IDLE if only besteffort is running, which
> is given at least equal preference as the idle cpus when deciding where
> to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
> mean they can be preempted soon enough to start serving the wakee, and

Could you give us more details why the SCHED_IDLE cpu which runs only
besteffort can't be preempted soon enough ?

because kubepods vs system.slice is not sched_idle when comparing the
entities ? some maybe the definition of sched_idle_cpu should be fixed
instead

a sched_idle_cpu should be preempted immediately otherwise it's not a
sched idle cpu and the definition is meaningless

> containerd and other services under system.slice are the case that have
> to wait in runqueue since they can not preempt kubepods, while idle cpus
> are possible out there untouched.
>
> So prioritize idle cpus over SCHED_IDLE ones to avoid undesired delay
> like orchestration operations as much as possible.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae0350088ac1..379764bd2795 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7446,7 +7446,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>         unsigned int min_exit_latency = UINT_MAX;
>         u64 latest_idle_timestamp = 0;
>         int least_loaded_cpu = this_cpu;
> -       int shallowest_idle_cpu = -1;
> +       int shallowest_idle_cpu = -1, si_cpu = -1;
>         int i;
>
>         /* Check if we have any choice: */
> @@ -7460,9 +7460,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                 if (!sched_core_cookie_match(rq, p))
>                         continue;
>
> -               if (sched_idle_cpu(i))
> -                       return i;
> -
>                 if (available_idle_cpu(i)) {
>                         struct cpuidle_state *idle = idle_get_state(rq);
>                         if (idle && idle->exit_latency < min_exit_latency) {
> @@ -7484,7 +7481,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                                 latest_idle_timestamp = rq->idle_stamp;
>                                 shallowest_idle_cpu = i;
>                         }
> -               } else if (shallowest_idle_cpu == -1) {
> +               } else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
> +                       if (sched_idle_cpu(i)) {
> +                               si_cpu = i;
> +                               continue;
> +                       }
> +
>                         load = cpu_load(cpu_rq(i));
>                         if (load < min_load) {
>                                 min_load = load;
> @@ -7493,7 +7495,11 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
>                 }
>         }
>
> -       return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
> +       if (shallowest_idle_cpu != -1)
> +               return shallowest_idle_cpu;
> +       if (si_cpu != -1)
> +               return si_cpu;
> +       return least_loaded_cpu;
>  }
>
>  static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
> @@ -7549,11 +7555,14 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>         return new_cpu;
>  }
>
> -static inline int __select_idle_cpu(int cpu, struct task_struct *p)
> +static inline int __select_idle_cpu(int cpu, struct task_struct *p, int *si_cpu)
>  {
> -       if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
> -           sched_cpu_cookie_match(cpu_rq(cpu), p))
> +       if (!sched_cpu_cookie_match(cpu_rq(cpu), p))
> +               return -1;
> +       if (available_idle_cpu(cpu))
>                 return cpu;
> +       if (*si_cpu == -1 && sched_idle_cpu(cpu))
> +               *si_cpu = cpu;
>
>         return -1;
>  }
> @@ -7649,7 +7658,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>   */
>  static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> -       int cpu;
> +       int cpu, si_cpu = -1;
>
>         for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
>                 if (cpu == target)
> @@ -7660,11 +7669,13 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>                  */
>                 if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>                         continue;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +               if (available_idle_cpu(cpu))
>                         return cpu;
> +               if (si_cpu == -1 && sched_idle_cpu(cpu))
> +                       si_cpu = cpu;
>         }
>
> -       return -1;
> +       return si_cpu;
>  }
>
>  #else /* CONFIG_SCHED_SMT */
> @@ -7680,7 +7691,7 @@ static inline bool test_idle_cores(int cpu)
>
>  static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
> -       return __select_idle_cpu(core, p);
> +       return __select_idle_cpu(core, p, idle_cpu);
>  }
>
>  static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> @@ -7728,10 +7739,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                                                 return i;
>                                 } else {
>                                         if (--nr <= 0)
> -                                               return -1;
> -                                       idle_cpu = __select_idle_cpu(cpu, p);
> -                                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
>                                                 return idle_cpu;
> +                                       i = __select_idle_cpu(cpu, p, &idle_cpu);
> +                                       if ((unsigned int)i < nr_cpumask_bits)
> +                                               return i;
>                                 }
>                         }
>                         cpumask_andnot(cpus, cpus, sched_group_span(sg));
> @@ -7746,9 +7757,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>
>                 } else {
>                         if (--nr <= 0)
> -                               return -1;
> -                       idle_cpu = __select_idle_cpu(cpu, p);
> -                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                               return idle_cpu;
> +                       i = __select_idle_cpu(cpu, p, &idle_cpu);
> +                       if ((unsigned int)i < nr_cpumask_bits)
>                                 break;
>                 }
>         }
> --
> 2.37.3
>


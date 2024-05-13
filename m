Return-Path: <linux-kernel+bounces-177270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7078C3C31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968671C211B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542FE146A90;
	Mon, 13 May 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKxlD5Xv"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68833985
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586219; cv=none; b=X4d3qBAVdFQ4erocaF/Th6BI/Xgiz2mP9yUXx1OyPCWEz4uHc6foUC5AR8cdRLKiHX9pSIPjJ9ctKPLdVxm+53kt+lROAzSpV1qvCEkNQk45RGB46FzaNOuY3BsCLxq3XLjcdNr/SOgCJ90gAVvG4NYXhOtnIH7WXZQN0WS5Af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586219; c=relaxed/simple;
	bh=WpDBwHUw9dlwhSz8v9+pYB+n5Z6W0rNlEOZoYAfm/KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsMFjRo7/spzeA89k08/npLymYcwGunNQ3fLK8MgxC8eToOHJPwFVQ0I6rnikhFoSQ/5Ufl16rOWjJlzktqe3lwXc40BLrE2fEAosua/4rYpwBy+O+G1EItIeEy+9MY5GNE/WTHnUDz2L01hqrMmIUXJ5kKoWy/jCKR3qekot24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YKxlD5Xv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-628a551d10cso2835702a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715586217; x=1716191017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hq8zjtnsgNz1Xw65WUzaHDHJhvIuWD3WyVAyFkw2Z2s=;
        b=YKxlD5XvcaxGohBjUPWy1Eh+jYr3BOdUkx8VAMbKR9nvJHgoiL3QBHSnAWPOUA/9f1
         Auf4rcEoUO7zbMeYmeBAVzcUb1NKhoMNAYue7txoP6+VXf12skHc7ghY+0YiMyY1M+M4
         RC1STMjSqGIVShJoC8xvqpR74DPk+zdzxXslBZ6Z0zsFoGzKor1Hh7Wovgfs6eZNe1+I
         nNUA5TCtJH3bq4GDOz6VPQGnFugkyvmF1FRO8/wxeG+Lh47jkvjrkdvqOmZfOoBdCl/4
         DxiqBbA5vfZnnzDdsmzsixePX3fGYTP08D3nTw0VGne8aBgI0BUASFO2KDFmB0iZUwBc
         Pxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715586217; x=1716191017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq8zjtnsgNz1Xw65WUzaHDHJhvIuWD3WyVAyFkw2Z2s=;
        b=XdZr4dsmbCWmk4p9MS8dwWdIA9JZhq7cIQ1Fb4pqYs+ZUqHKVtvygVKDQ3bAKyiFpQ
         pZRYGOLUqhRtv2W1Vut6LAOC91vLWX3tkeZrJwi/N+dlx5hwJ2zlJuISHs0pH7TZVWQi
         ifCMAHz85jU+e6Bmr/Lj0Ay8m11PSDwoJfsLHdGjbMylX9T1FuuuzWvnNecK5+FbDM8U
         EYYqpRcX1/CsbG0cJOYoEIGLFlyFP9ESIDnm6ItE6U3czdv0kuCQtf2IlBDFx3dzDJl9
         hRdIzJDcMJWVmGZAeTvp/QJHC5VPg41GOeTBTMmpbbBIsW7L9NpqaP45UMzbXMRvRlBW
         QqnA==
X-Forwarded-Encrypted: i=1; AJvYcCWsMI9o8T3KXTXl2rXrt7OOwlyKEG3ILRuPaoAAgrq0K4YUkp9M5Dhf5FH9veWSIQJOst/h8Yad5keJ29u7Xu5VepyFMLHBZY39bjYt
X-Gm-Message-State: AOJu0YyE8/Hw278CvJoUdf5LbFZpg/F+9x2m52cGvKNGp+oeGKXW/4LC
	cqmmMW56jlTitCV9qXbKgYeNyjR+Jk3IrQ+UitAfmD/nc8fO11XxtWtWJ8ZTXId447IxBrbpNRN
	AfIPeNtWL98yfjaxKMU8IKXirUqB/dKqxCMR3N6+hTmVVHYnnRGBSSA==
X-Google-Smtp-Source: AGHT+IEoufmdSm85cc5oUbp/wH/IIHJ2oice1oE+8E11ujDyWnyGKy/Eg/800rU12t5TeSoJuoEvoHQTxQKBXT0e2F8=
X-Received: by 2002:a05:6a21:3993:b0:1af:fb2c:facd with SMTP id
 adf61e73a8af0-1affb2cfc20mr1037463637.22.1715586216765; Mon, 13 May 2024
 00:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkG0nxxBPB/03Q/l@gmail.com>
In-Reply-To: <ZkG0nxxBPB/03Q/l@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 13 May 2024 09:43:25 +0200
Message-ID: <CAKfTPtB01UKskH_a1h1LtjoRq6O3NnqQuuh1L50O-yHRLQm-iw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.10
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ingo,

On Mon, 13 May 2024 at 08:35, Ingo Molnar <mingo@kernel.org> wrote:
>
> Linus,
>
> Please pull the latest sched/core Git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-05-13
>
>    # HEAD: 97450eb909658573dcacc1063b06d3d08642c0c1 sched/pelt: Remove shift of thermal clock
>
> Scheduler changes for v6.10:
>
>  - Add cpufreq pressure feedback for the scheduler
>
>  - Rework misfit load-balancing wrt. affinity restrictions
>
>  - Clean up and simplify the code around ::overutilized and
>    ::overload access.
>
>  - Simplify sched_balance_newidle()
>
>  - Bump SCHEDSTAT_VERSION to 16 due to a cleanup of CPU_MAX_IDLE_TYPES
>    handling that changed the output.
>
>  - Rework & clean up <asm/vtime.h> interactions wrt. arch_vtime_task_switch()
>
>  - Reorganize, clean up and unify most of the higher level
>    scheduler balancing function names around the sched_balance_*()
>    prefix.
>
>  - Simplify the balancing flag code (sched_balance_running)
>
>  - Miscellaneous cleanups & fixes
>
>  Thanks,
>
>         Ingo
>
> ------------------>
> Alexander Gordeev (5):
>       sched/vtime: Remove confusing arch_vtime_task_switch() declaration
>       sched/vtime: Get rid of generic vtime_task_switch() implementation
>       s390/vtime: Remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
>       s390/irq,nmi: Include <asm/vtime.h> header directly
>       sched/vtime: Do not include <asm/vtime.h> header
>
> Ingo Molnar (28):
>       sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
>       sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
>       sched/debug: Increase SCHEDSTAT_VERSION to 16
>       sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels
>       sched/balancing: Change comment formatting to not overlap Git conflict marker lines
>       sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
>       sched/balancing: Update run_rebalance_domains() comments
>       sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
>       sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
>       sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
>       sched/balancing: Rename scheduler_tick() => sched_tick()
>       sched/balancing: Rename trigger_load_balance() => sched_balance_trigger()
>       sched/balancing: Rename rebalance_domains() => sched_balance_domains()
>       sched/balancing: Rename load_balance() => sched_balance_rq()
>       sched/balancing: Rename find_busiest_queue() => sched_balance_find_src_rq()
>       sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()
>       sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()
>       sched/balancing: Rename newidle_balance() => sched_balance_newidle()
>       sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()
>       sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()
>       sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()
>       sched/balancing: Fix a couple of outdated function names in comments
>       sched/fair: Fix typos in comments
>       sched/fair: Rename root_domain::overload to ::overloaded
>       sched/fair: Rename {set|get}_rd_overload() to {set|get}_rd_overloaded()
>       sched/fair: Rename SG_OVERLOAD to SG_OVERLOADED
>       sched/fair: Rename set_rd_overutilized_status() to set_rd_overutilized()
>       sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags
>
> Qais Yousef (4):
>       sched/topology: Export asym_cap_list
>       sched/fair: Check if a task has a fitting CPU when updating misfit
>       sched/topology: Remove root_domain::max_cpu_capacity
>       sched/fair: Don't double balance_interval for migrate_misfit
>
> Shrikanth Hegde (7):
>       sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
>       sched/fair: Add EAS checks before updating root_domain::overutilized
>       sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized
>       sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
>       sched/fair: Combine EAS check with root_domain::overutilized access
>       sched/fair: Check root_domain::overload value before update
>       sched/fair: Use helper functions to access root_domain::overload
>
> Vincent Guittot (6):
>       sched/fair: Fix update of rd->sg_overutilized
>       cpufreq: Add a cpufreq pressure feedback for the scheduler
>       sched/cpufreq: Take cpufreq feedback into account
>       thermal/cpufreq: Remove arch_update_thermal_pressure()
>       sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()

There is a fix for the one above:
 https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/

>       sched/pelt: Remove shift of thermal clock
>
>
>  Documentation/admin-guide/kernel-parameters.txt    |   1 +
>  Documentation/scheduler/sched-domains.rst          |  12 +-
>  Documentation/scheduler/sched-stats.rst            |  37 +-
>  .../translations/zh_CN/scheduler/sched-domains.rst |  10 +-
>  .../translations/zh_CN/scheduler/sched-stats.rst   |  30 +-
>  arch/arm/include/asm/topology.h                    |   6 +-
>  arch/arm/kernel/topology.c                         |   2 +-
>  arch/arm64/include/asm/topology.h                  |   6 +-
>  arch/powerpc/include/asm/Kbuild                    |   1 -
>  arch/powerpc/include/asm/cputime.h                 |  13 -
>  arch/powerpc/kernel/time.c                         |  22 +
>  arch/s390/include/asm/vtime.h                      |   2 -
>  arch/s390/kernel/irq.c                             |   1 +
>  arch/s390/kernel/nmi.c                             |   1 +
>  drivers/base/arch_topology.c                       |  26 +-
>  drivers/cpufreq/cpufreq.c                          |  36 ++
>  drivers/cpufreq/qcom-cpufreq-hw.c                  |   4 +-
>  drivers/thermal/cpufreq_cooling.c                  |   3 -
>  include/asm-generic/vtime.h                        |   1 -
>  include/linux/arch_topology.h                      |   8 +-
>  include/linux/cpufreq.h                            |  10 +
>  include/linux/sched.h                              |   3 +-
>  include/linux/sched/idle.h                         |   2 +-
>  include/linux/sched/topology.h                     |  10 +-
>  include/linux/vtime.h                              |   5 -
>  .../events/{thermal_pressure.h => hw_pressure.h}   |  14 +-
>  include/trace/events/sched.h                       |   2 +-
>  init/Kconfig                                       |  12 +-
>  init/init_task.c                                   |   1 +
>  kernel/sched/core.c                                |  14 +-
>  kernel/sched/cputime.c                             |  13 -
>  kernel/sched/fair.c                                | 501 ++++++++++++---------
>  kernel/sched/loadavg.c                             |   2 +-
>  kernel/sched/pelt.c                                |  22 +-
>  kernel/sched/pelt.h                                |  16 +-
>  kernel/sched/sched.h                               |  71 ++-
>  kernel/sched/stats.c                               |   5 +-
>  kernel/sched/topology.c                            |  56 ++-
>  kernel/time/timer.c                                |   2 +-
>  kernel/workqueue.c                                 |   2 +-
>  lib/Kconfig.debug                                  |   2 +-
>  .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |   2 +-
>  42 files changed, 549 insertions(+), 440 deletions(-)
>  delete mode 100644 include/asm-generic/vtime.h
>  rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)


Return-Path: <linux-kernel+bounces-177204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB288C3B69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0048B20D67
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50C47A57;
	Mon, 13 May 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB50fQlv"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCF41A87
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582118; cv=none; b=IVeFkS1+lyDOwKf42ZIlKayLbn+ksvGhpDK84dKdvVrS0jOC1u8gnIXtFVNMkrux8fgbwYSgNRWTOloSUDAkGhVW0jJsSML0YZuVfhWdhzU41EE+e3K4HBdC5aIds7Ax2KlwmTOxGKImMsuKwg3Kmsu60D/P6ev40HjGo/TOc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582118; c=relaxed/simple;
	bh=Cd8Bxm8jrpTu86IwXS31LElcdJHyFFqtl4qkNZ8e89w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nQ0lHcqL59hoYayVfWvCipNNK9ipIKpl3RZbpgKsNeu7jUoY55FrkLwGHal7iwNJUi2BnPDerxqW7CZq8zzaoS4SGItvisQJ/qkzOD0ypek95FenHNZ4I3jZ9Vmwv2FCn/Dw5wCUqdjzZ5C6n56DZWwXCIGGFMEaKKGARWMloTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB50fQlv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so208186166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715582115; x=1716186915; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ztk9v+HpSKQKgbuYukVUThg/x2xjTvOkG28/cibnNsE=;
        b=VB50fQlvhdfO8c7NdYr+5oqirEZPAVEMOuoryxv2voY6NksQmtWqZM2OjNEWEzM1DP
         am0ilJObzSv5xvaaWcXI5ROypgkrILAmtD2B1xc31WOAubyMJ8t6zjl/9j5RpylIu9dH
         hCCHKQA5c5Fz2698YZfyr3G3ssxAfmJg5H5e0QZQR+PYPqN5NdaNHb/782/jRu34s46y
         w+FlO4FOcMC3DIG7G0QpiW2dvdjA2YcGyeqXtGQ7qn/T9EI6/MICRQyBeAPkqIPDBgEg
         BzGhCLLQ6yqvtGOLgJnr8w+WPD34GqX1exUwljJK0t2BS7FmgYjkc/xJ7nJvemjf6IWB
         etqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715582115; x=1716186915;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztk9v+HpSKQKgbuYukVUThg/x2xjTvOkG28/cibnNsE=;
        b=aax8W+C8XCHCkceb7aKiOEDbdLztiOghHLGq7RzWJHFvjz0AjfiFG+NyZkYxfDgTZw
         wf0Ew6rY9O7YnG75RAVwR5E87kthnuN/mfTxTJDzHXoVzKEeGlzrj5HyJlB6TmenkSOx
         p/JYSJHZrzkY7xvk70QCO7T7LLaZsgLcAIYQ2sOjl0DS7wJcL1ouCol8ZJt7XnrYPeV2
         SNCKA7/1qk3MNKxgEx/XlgH/JQ4yfZfImv48RLTuJQUeS8hSviNEyllDAznuwacaMsML
         BM9jM03KnAvolWs4THXDmRzwMoh8dY1F814mn4oEe0p88IpGTBMrP2HAK+VJazYd3CUw
         o3zw==
X-Gm-Message-State: AOJu0Yxm2dJ3ZDKsle64rQ1Rg93Rsx3UU7mJf2+of8wranbfNq9YwtV6
	xMsN9zypvxl4rpAlS9zer9m/ijtAiWzuqduJLyyxoyasA5AIuQMq
X-Google-Smtp-Source: AGHT+IFbmfwXnSkXBy5p92lToPoClK6R+6zINqVwJ5xISiiOj+rOoYjAp2bh0gYUh2/3igizcv4clQ==
X-Received: by 2002:a17:906:37d9:b0:a5a:3ea6:689e with SMTP id a640c23a62f3a-a5a3ea6692amr378137766b.71.1715582114526;
        Sun, 12 May 2024 23:35:14 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d2dcsm550494566b.44.2024.05.12.23.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:35:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:35:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [GIT PULL] Scheduler changes for v6.10
Message-ID: <ZkG0nxxBPB/03Q/l@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-05-13

   # HEAD: 97450eb909658573dcacc1063b06d3d08642c0c1 sched/pelt: Remove shift of thermal clock

Scheduler changes for v6.10:

 - Add cpufreq pressure feedback for the scheduler

 - Rework misfit load-balancing wrt. affinity restrictions

 - Clean up and simplify the code around ::overutilized and
   ::overload access.

 - Simplify sched_balance_newidle()

 - Bump SCHEDSTAT_VERSION to 16 due to a cleanup of CPU_MAX_IDLE_TYPES
   handling that changed the output.

 - Rework & clean up <asm/vtime.h> interactions wrt. arch_vtime_task_switch()

 - Reorganize, clean up and unify most of the higher level
   scheduler balancing function names around the sched_balance_*()
   prefix.

 - Simplify the balancing flag code (sched_balance_running)

 - Miscellaneous cleanups & fixes

 Thanks,

	Ingo

------------------>
Alexander Gordeev (5):
      sched/vtime: Remove confusing arch_vtime_task_switch() declaration
      sched/vtime: Get rid of generic vtime_task_switch() implementation
      s390/vtime: Remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
      s390/irq,nmi: Include <asm/vtime.h> header directly
      sched/vtime: Do not include <asm/vtime.h> header

Ingo Molnar (28):
      sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
      sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
      sched/debug: Increase SCHEDSTAT_VERSION to 16
      sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels
      sched/balancing: Change comment formatting to not overlap Git conflict marker lines
      sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
      sched/balancing: Update run_rebalance_domains() comments
      sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
      sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
      sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
      sched/balancing: Rename scheduler_tick() => sched_tick()
      sched/balancing: Rename trigger_load_balance() => sched_balance_trigger()
      sched/balancing: Rename rebalance_domains() => sched_balance_domains()
      sched/balancing: Rename load_balance() => sched_balance_rq()
      sched/balancing: Rename find_busiest_queue() => sched_balance_find_src_rq()
      sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()
      sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()
      sched/balancing: Rename newidle_balance() => sched_balance_newidle()
      sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()
      sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()
      sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()
      sched/balancing: Fix a couple of outdated function names in comments
      sched/fair: Fix typos in comments
      sched/fair: Rename root_domain::overload to ::overloaded
      sched/fair: Rename {set|get}_rd_overload() to {set|get}_rd_overloaded()
      sched/fair: Rename SG_OVERLOAD to SG_OVERLOADED
      sched/fair: Rename set_rd_overutilized_status() to set_rd_overutilized()
      sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags

Qais Yousef (4):
      sched/topology: Export asym_cap_list
      sched/fair: Check if a task has a fitting CPU when updating misfit
      sched/topology: Remove root_domain::max_cpu_capacity
      sched/fair: Don't double balance_interval for migrate_misfit

Shrikanth Hegde (7):
      sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
      sched/fair: Add EAS checks before updating root_domain::overutilized
      sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized
      sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
      sched/fair: Combine EAS check with root_domain::overutilized access
      sched/fair: Check root_domain::overload value before update
      sched/fair: Use helper functions to access root_domain::overload

Vincent Guittot (6):
      sched/fair: Fix update of rd->sg_overutilized
      cpufreq: Add a cpufreq pressure feedback for the scheduler
      sched/cpufreq: Take cpufreq feedback into account
      thermal/cpufreq: Remove arch_update_thermal_pressure()
      sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
      sched/pelt: Remove shift of thermal clock


 Documentation/admin-guide/kernel-parameters.txt    |   1 +
 Documentation/scheduler/sched-domains.rst          |  12 +-
 Documentation/scheduler/sched-stats.rst            |  37 +-
 .../translations/zh_CN/scheduler/sched-domains.rst |  10 +-
 .../translations/zh_CN/scheduler/sched-stats.rst   |  30 +-
 arch/arm/include/asm/topology.h                    |   6 +-
 arch/arm/kernel/topology.c                         |   2 +-
 arch/arm64/include/asm/topology.h                  |   6 +-
 arch/powerpc/include/asm/Kbuild                    |   1 -
 arch/powerpc/include/asm/cputime.h                 |  13 -
 arch/powerpc/kernel/time.c                         |  22 +
 arch/s390/include/asm/vtime.h                      |   2 -
 arch/s390/kernel/irq.c                             |   1 +
 arch/s390/kernel/nmi.c                             |   1 +
 drivers/base/arch_topology.c                       |  26 +-
 drivers/cpufreq/cpufreq.c                          |  36 ++
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   4 +-
 drivers/thermal/cpufreq_cooling.c                  |   3 -
 include/asm-generic/vtime.h                        |   1 -
 include/linux/arch_topology.h                      |   8 +-
 include/linux/cpufreq.h                            |  10 +
 include/linux/sched.h                              |   3 +-
 include/linux/sched/idle.h                         |   2 +-
 include/linux/sched/topology.h                     |  10 +-
 include/linux/vtime.h                              |   5 -
 .../events/{thermal_pressure.h => hw_pressure.h}   |  14 +-
 include/trace/events/sched.h                       |   2 +-
 init/Kconfig                                       |  12 +-
 init/init_task.c                                   |   1 +
 kernel/sched/core.c                                |  14 +-
 kernel/sched/cputime.c                             |  13 -
 kernel/sched/fair.c                                | 501 ++++++++++++---------
 kernel/sched/loadavg.c                             |   2 +-
 kernel/sched/pelt.c                                |  22 +-
 kernel/sched/pelt.h                                |  16 +-
 kernel/sched/sched.h                               |  71 ++-
 kernel/sched/stats.c                               |   5 +-
 kernel/sched/topology.c                            |  56 ++-
 kernel/time/timer.c                                |   2 +-
 kernel/workqueue.c                                 |   2 +-
 lib/Kconfig.debug                                  |   2 +-
 .../ftrace/test.d/ftrace/func_set_ftrace_file.tc   |   2 +-
 42 files changed, 549 insertions(+), 440 deletions(-)
 delete mode 100644 include/asm-generic/vtime.h
 rename include/trace/events/{thermal_pressure.h => hw_pressure.h} (55%)


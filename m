Return-Path: <linux-kernel+bounces-177388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A0D8C3DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB872849A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C1149C4A;
	Mon, 13 May 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBzkqIMn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467B1487EC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591402; cv=none; b=Zhx4bMP22RXt1kazNjA8CMQWYhRp3TfG5yFmVXH/gmyj8uU51dcyZW9NoZuwpKOfgwEyLZ6KjAApXrZCssVV5atLpu4iqSevx1o2bA8Mr5pRzwPjIKiTNDMxfazm4R8lPkB+whTi7+9sJlt0OdqbiwSTqHExI75E1XmcKmFU1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591402; c=relaxed/simple;
	bh=MvnsIUTYIx86qi1UwqAPeXoIBqXgyya1HBN7fah5cvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3XHgCaSZ4P/jWfrXbemLi1UAcdIm9M73t/lXVg7uJMGRZlZGCXwBlF7rkPf/1WJRs0nR79Tq7KVzW9ydTQOUxxYKXL9QMu5x0xRJMGeHq+MGxpTTmERV1gzq89Xg276O4tc8ofXmgX6OqOAR4qCoW5xBjnRwVsNqTR2PWZe0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBzkqIMn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a2c05006aso358864066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715591398; x=1716196198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ne5ALsr+uIXtyKGw+qnsLVKR96q7nxmFYmWh1as35WM=;
        b=IBzkqIMnYqqFlZhlNh/MbsfN7tmIop8r2c5ZB2fqQFhMWIkEedI/wU2onzGHvZv4zN
         UCX6q6wyPlo+XREoYhBhAfTIBYvZRzlNzazeOWvtg7gTWHgxM99+78SG1W/1iRTGL2pv
         4V5np1FjdfT8KxeaAQjfVqhtKMQ8mDsYvbMc8Gt/t7ImZ0Qlf6Q3+1w1l+7rANEuHFyV
         BzrIF2bi07IkmzMiX+OXlHnHllrdsRmyeui8v1Vm0Xmw+q+bS0oMwbN6nLP65ryor0oJ
         VCfzYtquTbv4emXc0cq4TASiKoGCkDDuueH0n8XN2aORBcgbD0WbFSk0TaoSyo+HKpWl
         bZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715591398; x=1716196198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ne5ALsr+uIXtyKGw+qnsLVKR96q7nxmFYmWh1as35WM=;
        b=C2payEZQe/1wx/73u/6XNOqTTarwMOvwnAkLedCjRMkn0Ig7Z3EHPytNO1XG8dYgcr
         Y5KySPUp1mSV+y3ixFcAFzlE+iN3VDrHmoQmQ9bbMYHQRf3FHHoynwqTS7WEcxcFs8Bu
         HWGQZ7X/9zAWTbizuAXZIpgC6L3/jFX0k3yD/Hhar27mH6kybhwcViAOqwH0uiMKjMlx
         NvXv1g3QPdaQB+AQ9Z6Bp0v9ZH6HowbzRghmu/MRCFh+YEIB9PrWfpPPUhIPVHj5yW50
         KP80Dwo7xlIaswj7OYKCOuZIkrU5vaufaDK1bnRLJWc8tbAX5typkuWuOTTpDyhoRUkp
         hBbA==
X-Forwarded-Encrypted: i=1; AJvYcCW/oHxJ6tMGWuB7b44aAEODPP41Zh2K1HXprYRGpGd7fFDgCAQI2an6YxNnewmFh1yFxLIyKbOeWBvovqkoyzF9QHf2AKTJZ1QTv2gm
X-Gm-Message-State: AOJu0YxT4N7SG2nkmwX7uEwgl8GmuX/7ZENKfHm0q74buraAslcHBLR9
	2ESG1Evhz/fwUh/vsOWPrBHC7KNbEawxbdOLxen2iO+eAdZ8PVeo
X-Google-Smtp-Source: AGHT+IEjOZ30dgyV61if7skQEOVCWbrcvqK0pBdeCDB/c+X4WYQVxS4/Vof5T7wUfhrK+J9UK2sHSw==
X-Received: by 2002:a50:8e59:0:b0:56e:10d3:85e3 with SMTP id 4fb4d7f45d1cf-5734d5c0f52mr7725760a12.13.1715591397977;
        Mon, 13 May 2024 02:09:57 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6592sm5933661a12.2.2024.05.13.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 02:09:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 11:09:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.10
Message-ID: <ZkHY42pybndB1K+J@gmail.com>
References: <ZkG0nxxBPB/03Q/l@gmail.com>
 <CAKfTPtB01UKskH_a1h1LtjoRq6O3NnqQuuh1L50O-yHRLQm-iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB01UKskH_a1h1LtjoRq6O3NnqQuuh1L50O-yHRLQm-iw@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Hi Ingo,
> 
> On Mon, 13 May 2024 at 08:35, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Linus,
> >
> > Please pull the latest sched/core Git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-05-13
> >
> >    # HEAD: 97450eb909658573dcacc1063b06d3d08642c0c1 sched/pelt: Remove shift of thermal clock
> >
> > Scheduler changes for v6.10:
> >
> >  - Add cpufreq pressure feedback for the scheduler
> >
> >  - Rework misfit load-balancing wrt. affinity restrictions
> >
> >  - Clean up and simplify the code around ::overutilized and
> >    ::overload access.
> >
> >  - Simplify sched_balance_newidle()
> >
> >  - Bump SCHEDSTAT_VERSION to 16 due to a cleanup of CPU_MAX_IDLE_TYPES
> >    handling that changed the output.
> >
> >  - Rework & clean up <asm/vtime.h> interactions wrt. arch_vtime_task_switch()
> >
> >  - Reorganize, clean up and unify most of the higher level
> >    scheduler balancing function names around the sched_balance_*()
> >    prefix.
> >
> >  - Simplify the balancing flag code (sched_balance_running)
> >
> >  - Miscellaneous cleanups & fixes
> >
> >  Thanks,
> >
> >         Ingo
> >
> > ------------------>
> > Alexander Gordeev (5):
> >       sched/vtime: Remove confusing arch_vtime_task_switch() declaration
> >       sched/vtime: Get rid of generic vtime_task_switch() implementation
> >       s390/vtime: Remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
> >       s390/irq,nmi: Include <asm/vtime.h> header directly
> >       sched/vtime: Do not include <asm/vtime.h> header
> >
> > Ingo Molnar (28):
> >       sched/balancing: Switch the 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t sched_balance_running' flag
> >       sched/balancing: Change 'enum cpu_idle_type' to have more natural definitions
> >       sched/debug: Increase SCHEDSTAT_VERSION to 16
> >       sched/debug: Allow CONFIG_SCHEDSTATS even on !KERNEL_DEBUG kernels
> >       sched/balancing: Change comment formatting to not overlap Git conflict marker lines
> >       sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
> >       sched/balancing: Update run_rebalance_domains() comments
> >       sched/balancing: Vertically align the comments of 'struct sg_lb_stats' and 'struct sd_lb_stats'
> >       sched/balancing: Update comments in 'struct sg_lb_stats' and 'struct sd_lb_stats'
> >       sched/balancing: Rename run_rebalance_domains() => sched_balance_softirq()
> >       sched/balancing: Rename scheduler_tick() => sched_tick()
> >       sched/balancing: Rename trigger_load_balance() => sched_balance_trigger()
> >       sched/balancing: Rename rebalance_domains() => sched_balance_domains()
> >       sched/balancing: Rename load_balance() => sched_balance_rq()
> >       sched/balancing: Rename find_busiest_queue() => sched_balance_find_src_rq()
> >       sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()
> >       sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()
> >       sched/balancing: Rename newidle_balance() => sched_balance_newidle()
> >       sched/balancing: Rename find_idlest_group_cpu() => sched_balance_find_dst_group_cpu()
> >       sched/balancing: Rename find_idlest_group() => sched_balance_find_dst_group()
> >       sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()
> >       sched/balancing: Fix a couple of outdated function names in comments
> >       sched/fair: Fix typos in comments
> >       sched/fair: Rename root_domain::overload to ::overloaded
> >       sched/fair: Rename {set|get}_rd_overload() to {set|get}_rd_overloaded()
> >       sched/fair: Rename SG_OVERLOAD to SG_OVERLOADED
> >       sched/fair: Rename set_rd_overutilized_status() to set_rd_overutilized()
> >       sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags
> >
> > Qais Yousef (4):
> >       sched/topology: Export asym_cap_list
> >       sched/fair: Check if a task has a fitting CPU when updating misfit
> >       sched/topology: Remove root_domain::max_cpu_capacity
> >       sched/fair: Don't double balance_interval for migrate_misfit
> >
> > Shrikanth Hegde (7):
> >       sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
> >       sched/fair: Add EAS checks before updating root_domain::overutilized
> >       sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized
> >       sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
> >       sched/fair: Combine EAS check with root_domain::overutilized access
> >       sched/fair: Check root_domain::overload value before update
> >       sched/fair: Use helper functions to access root_domain::overload
> >
> > Vincent Guittot (6):
> >       sched/fair: Fix update of rd->sg_overutilized
> >       cpufreq: Add a cpufreq pressure feedback for the scheduler
> >       sched/cpufreq: Take cpufreq feedback into account
> >       thermal/cpufreq: Remove arch_update_thermal_pressure()
> >       sched/cpufreq: Rename arch_update_thermal_pressure() => arch_update_hw_pressure()
> 
> There is a fix for the one above:
>  https://lore.kernel.org/lkml/20240425073709.379016-1-vincent.guittot@linaro.org/

So this is a cleanup in essence, so I delayed it for the next sched/urgent 
pile - will apply it once Linus pulls sched/core.

Thanks,

	Ingo


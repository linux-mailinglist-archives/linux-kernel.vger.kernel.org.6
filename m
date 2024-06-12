Return-Path: <linux-kernel+bounces-211940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E5905926
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4FB22DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7BC181CE5;
	Wed, 12 Jun 2024 16:51:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252C181B9F;
	Wed, 12 Jun 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211093; cv=none; b=e9p/FhEpSTRhwcsKLo16zM5iPixT9PeS2Rb+MoWkWWJcbnRz02LqeODk+2kkOj9ybLfRaTEV6FZQ+cjZlne3G1M1Sz/134oYmuTVk5SyS5G47rNsG/hPVBWLPznagKySdFNr9WGVY15B80Qf8oHGtxl2MIIaA9tw1OIx2UFZiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211093; c=relaxed/simple;
	bh=YrYUtmBscwe/BKDCAeV2DJYBsIYZzcIwLEPbABFZbaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU7l2ksr2BVLEmd7JHlhNMwBfcG6LzYYepyNWJ/89IBqbmkyMqBYUGzFuLmG/c44Q99Vv45gkTn1K6DL7p82FysclDEoFktBJsPpQNvNSJW8pzIglt53XtHkovty72tdidDG8XaLgXBSG8WpPQSg0LKeAed8XNdB30d6fZemwNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE0C116B1;
	Wed, 12 Jun 2024 16:51:31 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:51:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, Dan Carpenter
 <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: LTP tracing crashed on arm64 rk3399-rock-pi-4 - pc :
 ftrace_ops_test
Message-ID: <20240612125130.2c1d6d2d@rorschach.local.home>
In-Reply-To: <CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com>
References: <CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:52:05 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> The following kernel oops and kernel panic noticed while running LTP tracing
> test cases on arm64 rk3399-rock-pi-4 device running Linux next-20240612 tag.

How reproducible is this?  Do you only see it on arm64?

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot and test log:
> --------------
> [    0.000000] Linux version 6.10.0-rc3-next-20240612 (tuxmake@tuxmake)
>  (Debian clang version 18.1.6
>  (++20240518023133+1118c2e05e67-1~exp1~20240518143227.130),
>  Debian LLD 18.1.6) #1 SMP PREEMPT @1718178628
> ...
> trap: SIGUSR1: bad trap
> ftrace-stress-test 1 TINFO: Start pid16=595

ug, I guess I need to try to get LTP working again.


> /opt/ltp/testcases/bin/ftrace_stress/ftrace_tracing_cpumask.sh
> ftrace-stress-test 1 TINFO: Start pid17=598
> /opt/ltp/testcases/bin/ftrace_stress/ftrace_set_ftrace_filter.sh
> [   55.770077] Scheduler tracepoints stat_sleep, stat_iowait,
> stat_blocked and stat_runtime require the kernel parameter
> schedstats=enable or kernel.sched_schedstats=1
> [   55.790580] Scheduler tracepoints stat_sleep, stat_iowait,
> stat_blocked and stat_runtime require the kernel parameter
> schedstats=enable or kernel.sched_schedstats=1
> trap: SIGTERM: bad trap
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> ftrace_buffer_size_kb.sh: 33: echo: echo: I/O error
> [  100.599846] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [  100.599846] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [  100.599846] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [  100.599846] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [  100.599856] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [  100.599866] Mem abort info:
> [  100.599867] Mem abort info:
> [  100.599867] Mem abort info:
> [  100.599874]   ESR = 0x0000000096000004
> [  100.599875]   ESR = 0x0000000096000004
> [  100.599875]   ESR = 0x0000000096000004
> [  100.599883]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  100.599885]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  100.599885]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  100.599892]   SET = 0, FnV = 0
> [  100.599896]   SET = 0, FnV = 0
> [  100.599896]   SET = 0, FnV = 0
> [  100.599899]   EA = 0, S1PTW = 0
> [  100.599906]   EA = 0, S1PTW = 0
> [  100.599906]   EA = 0, S1PTW = 0
> [  100.599906]   FSC = 0x04: level 0 translation fault
> [  100.599914] Data abort info:
> [  100.599915]   FSC = 0x04: level 0 translation fault
> [  100.599915]   FSC = 0x04: level 0 translation fault
> [  100.599920]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  100.599925] Data abort info:
> [  100.599926] Data abort info:
> [  100.599928]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  100.599935]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  100.599935]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  100.599936]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  100.599944]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  100.599946]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  100.599945] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000014fc7000
> [  100.599955]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  100.599955]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  100.599956] [0000000000000008] pgd=0000000000000000
> [  100.599964] , p4d=0000000000000000
> [  100.599966] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000006ce0000
> [  100.599966] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000079ec000
> [  100.599975]
> [  100.599976] [0000000000000008] pgd=0000000000000000
> [  100.599977] [0000000000000008] pgd=0000000000000000
> [  100.599985] , p4d=0000000000000000
> [  100.599986] , p4d=0000000000000000
> [  100.599985] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [  100.599992]
> [  100.599994]
> [  100.599997] Modules linked in: brcmfmac snd_soc_hdmi_codec
> dw_hdmi_cec dw_hdmi_i2s_audio brcmutil crct10dif_ce rockchipdrm
> hci_uart snd_soc_spdif_tx hantro_vpu panfrost snd_soc_simple_card
> snd_soc_audio_graph_card btqca dw_mipi_dsi gpu_sched
> snd_soc_simple_card_utils btbcm v4l2_h264 analogix_dp cfg80211
> drm_shmem_helper dw_hdmi v4l2_vp9 phy_rockchip_pcie bluetooth
> v4l2_mem2mem cec snd_soc_rockchip_i2s videobuf2_v4l2
> drm_display_helper videobuf2_dma_contig drm_dma_helper
> videobuf2_memops rtc_rk808 rfkill snd_soc_es8316 videobuf2_common
> drm_kms_helper rockchip_saradc industrialio_triggered_buffer
> pcie_rockchip_host rockchip_thermal kfifo_buf coresight_cpu_debug drm
> fuse backlight dm_mod ip_tables x_tables
> [  100.600212] CPU: 3 PID: 0 Comm: swapper/3 Not tainted
> 6.10.0-rc3-next-20240612 #1
> [  100.600222] Hardware name: Radxa ROCK Pi 4B (DT)
> [  100.600229] pstate: 800003c5 (Nzcv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  100.600239] pc : ftrace_ops_test+0x34/0x138

Hmm, could you show the exact line of the above code? Specifically we have:

	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
	rcu_assign_pointer(hash.notrace_hash, ops->func_hash->notrace_hash);

Hmm, it's a NULL pointer dereference at 0x8, so ops is likely not NULL,
as func_hash is much farther down. But if func_hash is NULL,
filter_hash is at the 0x8 offset.

So now the question is, how did func_hash become NULL. It should always
be pointing at something. May have to do with the subops. Will investigate.

Thanks,

-- Steve


> [  100.600258] lr : function_graph_enter+0x144/0x208
> [  100.600271] sp : ffff800082fd3730
> [  100.600276] x29: ffff800082fd3770 x28: 0000000000000038 x27: ffff80008271a790
> [  100.600293] x26: ffff800082d24b08 x25: ffffffffffffffff x24: ffff800082d24000
> [  100.600310] x23: 0000000000000001 x22: 0000000000000001 x21: ffff000000cbdf00
> [  100.600326] x20: ffff80008271a3f0 x19: ffff800080163078 x18: 000000000000123d
> [  100.600343] x17: 0000000000000000 x16: 00500072b5503510 x15: 0000000000000000
> [  100.600359] x14: 0000000000000009 x13: 0000000000000037 x12: 0000000000000006
> [  100.600375] x11: 00000000fffffffe x10: ffff800082fd3740 x9 : ffff800082fd3738
> [  100.600391] x8 : 0000000000000000 x7 : 00000072b5503510 x6 : 0000000000300000
> [  100.600407] x5 : 0000000000000000 x4 : ffff8000801ffc20 x3 : ffff800082fd3900
> [  100.600423] x2 : 0000000000000000 x1 : ffff800080163078 x0 : ffff80008271a400
> [  100.600440] Call trace:
> [  100.600445]  ftrace_ops_test+0x34/0x138
> [  100.600455]  function_graph_enter+0x144/0x208
> [  100.600465]  ftrace_graph_func+0x34/0x58
> [  100.600477]  arch_ftrace_ops_list_func+0xd0/0x180
> [  100.600489]  ftrace_caller+0x6c/0x9c
> [  100.600498]  __traceiter_rcu_dyntick+0xc/0x88
> [  100.600511]  trace_rcu_dyntick+0x7c/0xa0
> [  100.600523]  ct_nmi_enter+0x90/0xc0
> [  100.600537]  ct_irq_enter+0x10/0x20
> [  100.600548]  enter_from_kernel_mode+0x30/0x58
> [  100.600560]  el1_abort+0x24/0x60
> [  100.600570]  el1h_64_sync_handler+0x80/0xd0
> [  100.600580]  el1h_64_sync+0x64/0x68
> [  100.600590]  ftrace_ops_test+0x34/0x138
> [  100.600600]  function_graph_enter+0x144/0x208
> [  100.600610]  ftrace_graph_func+0x34/0x58
> [  100.600620]  arch_ftrace_ops_list_func+0xd0/0x180
> [  100.600633] Mem abort info:
> [  100.600630]  ftrace_caller+0x6c/0x9c
> [  100.600639]   ESR = 0x0000000096000004
> [  100.600641]  arch_timer_set_next_event_phys+0xc/0x50
> [  100.600656]  clockevents_program_event+0xa0/0x1e0
> [  100.600669]  tick_program_event+0x5c/0xb0
> [  100.600679]  hrtimer_start_range_ns+0x15c/0x350
> [  100.600691]  tick_nohz_restart_sched_tick+0x90/0xb0
> [  100.600702]  tick_nohz_idle_exit+0xf0/0x168
> [  100.600712]  do_idle+0x238/0x290
> [  100.600721]  cpu_startup_entry+0x40/0x50
> [  100.600730]  secondary_start_kernel+0x13c/0x168
> [  100.600743]  __secondary_switched+0xb8/0xc0
> [  100.600761] Code: f9402c08 a902ffff a901ffff a900ffff (f9400508)
> [  100.600769] ---[ end trace 0000000000000000 ]---
> [  100.600782] Kernel panic - not syncing: Attempted to kill the idle task!
> [  100.600789] SMP: stopping secondary CPUs
> [  101.767463] SMP: failed to stop secondary CPUs 0-1,3-5
> [  101.767476] Kernel Offset: disabled
> [  101.767481] CPU features: 0x04,00001041,60100000,4200421b
> [  101.767489] Memory Limit: none
> [  101.814070] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
> 
> metadata:
> -------
>   git_describe: next-20240612
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 03d44168cbd7fc57d5de56a3730427db758fc7f6
>   kernel-config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2hloyVmgiND3p4zFZFj3KksAgm8/config
>   build-url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2hloyVmgiND3p4zFZFj3KksAgm8/
>   kernel_version: 6.10.0-rc3
>   toolchain: clang-18
> 
> Links:
> ----
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240612/testrun/24277665/suite/log-parser-test/tests/
>  - https://lkft.validation.linaro.org/scheduler/job/7658998#L1508
> 
>  --
> Linaro LKFT
> https://lkft.linaro.org



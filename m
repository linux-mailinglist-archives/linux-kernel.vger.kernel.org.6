Return-Path: <linux-kernel+bounces-315113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC496BE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF89B2A955
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1D1DA0E8;
	Wed,  4 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDlyFwft"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755331D88CC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455883; cv=none; b=bDbOuW0XESpGRv96y65yLF5UR6wjxA/m6tqXLh38L6YUmPsWxje/HfC0t5fkdc9zwqbI4WVGLvd2k5sTi3Sw193G/0pdoV2cDVUA/q139erxaA4eXlfrIjC6+ssmPac/NDh6hk+iqbBh6Js4A7zrTtojVPjs2noB0JZFs31oPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455883; c=relaxed/simple;
	bh=6TbtGF5NJ1v12wSxPmjkuDfsSZv/AZv0W90gtr+S+qo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MMczfIiPcQeih0xv3WAcU0O5NNgQlm9QsGDz6qH/Iqq7HJr7+FYg3USmq48jHH2CVDRHET9015t/OjvesZgFBPVlYkHqTBJJfhIgwV6/r56ld/Uf3eLHzWeA7QYCW1z1u2ix8KZaqECEb2k0zmy3o/N9Cu757QqaHPlIOB5loOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LDlyFwft; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709340f1cb1so2007615a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725455880; x=1726060680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TY4E6jw+2xBNSupUlPT2qMK4koFKe3m5ggASqYa2Zr0=;
        b=LDlyFwftqnJdcBp7O6YLINJmC160+yETmsWNvOWjUhEsw1Grxf8nOUg9a2E1oVl/Y+
         6dMpJ7igm98YbE3iU7KTYeNvvv5XHcPgq4EYFmpF50qhRTso66tIaOkHMKrBYzWZb9Hg
         reg8iZK/Ozp0uvbL9Rvw++0zrfFlzUMD4krs/s5jOIVg2cULiMuCkbTIWAgc9geQ1Vow
         KDtrgAhKhkTFpbaDNZz7s+vLAJWh08w9OVJOpMWMh3Jgx4gEth+QQc14UDJ2R4Xvg8eL
         /rtaoNIHyLbRoc+f+e4WA9IJbizyaWXf04TgWPcyqScdXs8Z6NPsFib031dZ9GbmC+Xn
         GwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455880; x=1726060680;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TY4E6jw+2xBNSupUlPT2qMK4koFKe3m5ggASqYa2Zr0=;
        b=IzJL5oY5No6wxS5AdXmXbA/dv895uyFlvDWT4PUBZhrg+kPbak9XW1qz5fOaORJjwI
         wZnNv+yznYczthrquppZ0FEMuU/aLrBerJiCVR86KB0avyrQ/TaVqGjQr7Z16UVba3yu
         1Ap2fr9JLzKaB3iB3TfJwKNsjQee/e+e2V/NyG0QO0gLneHui6QqzGg4rzZ/SDASOVTO
         T6l6mUgms8QSTP0BixiIVQUqSwKgKuECHaL9GKJGfb/Pq1fK8jptUZKmeZ3/xVGFuV2M
         Ky2O2oLCr9gnr65K4t5FSPEQdKXLszWRPVWgIZH8grkq4Dl/PZsnoYZcx9yWZZ9w0jPt
         euuQ==
X-Gm-Message-State: AOJu0YzRJrNhtL8RBusCArdzSIrGN7k3/VmS6oPKwkL049dr7SjqApsq
	8yFzxM/YZT8gX+/rnUp51I0bQNIvQ0/4Jw3MLX4BVlUykkOVPrLc1t7JNfQU2Urn2XAqFAkT9iN
	NHBuyzeSU/+57qyE7n+8dGc2mgHZOoMWBPUFp5sLIeUZfm/fal1U=
X-Google-Smtp-Source: AGHT+IFnDFVIiaQWiLq3M7wg6u9MGGaiHRmLmqHb//ZBOXNxUWF5HB8ptlw0wd7PMS3gRwPNyh+JDrAoYngmXOJFyQA=
X-Received: by 2002:a05:6808:1687:b0:3dc:15b9:334a with SMTP id
 5614622812f47-3df1b6f43f7mr13317689b6e.6.1725455880103; Wed, 04 Sep 2024
 06:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Sep 2024 18:47:48 +0530
Message-ID: <CA+G9fYtOCNQooW75is8yYBiJkGvNu52b1XoYP+99XwfvHPoNrA@mail.gmail.com>
Subject: next: WARNING: at kernel/sched/fair.c:6058 unthrottle_cfs_rq
 (kernel/sched/fair.c:6058 (discriminator 1))
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	lkft-triage@lists.linaro.org
Cc: Peter Zijlstra <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Richard Palethorpe <rpalethorpe@suse.com>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"

The following kernel warning is noticed on DUT arm64 Juno-r2 and x86 devices
and Virtual environment qemu-arm64 and qemu-x86_64 running Linux next.

This is not a new regression and we have been noticing this warning on
the Linux next kernel as per the available data.

List of devices encountering this kernel warning.
 - dragonboard-410c
 - juno-r2
 - qemu-arm64
 - qemu-riscv64
 - qemu-x86_64
 - x86_64

Anders bisected this down to,
# first bad commit:
  [2e0199df252a536a03f4cb0810324dff523d1e79]
  sched/fair: Prepare exit/cleanup paths for delayed_dequeue

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log qemu-arm64 :
----------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.11.0-rc6-next-20240902
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU
ld (GNU Binutils for Debian) 2.43) #1 SMP PREEMPT @1725295942
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
....
cfs_bandwidth01.c:58: TINFO: Set 'worker1/cpu.max' = '3000 10000'
cfs_bandwidth01.c:58: TINFO: Set 'worker2/cpu.max' = '2000 10000'
cfs_bandwidth01.c:58: TINFO: Set 'worker3/cpu.max' = '3000 10000'
cfs_bandwidth01.c:121: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:58: TINFO: Set 'level2/cpu.max' = '5000 10000'
cfs_bandwidth01.c:133: TPASS: Workers exited
cfs_bandwidth01.c:121: TPASS: Scheduled bandwidth constrained workers
<4>[   76.364066] ------------[ cut here ]------------
<4>[   76.364786] se->sched_delayed
<4>[ 76.365535] WARNING: CPU: 0 PID: 0 at kernel/sched/fair.c:6058
unthrottle_cfs_rq (kernel/sched/fair.c:6058 (discriminator 1))
<4>[   76.366982] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
<4>[   76.369703] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
6.11.0-rc6-next-20240902 #1
<4>[   76.370575] Hardware name: linux,dummy-virt (DT)
<4>[   76.371264] pstate: 624000c9 (nZCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 76.371928] pc : unthrottle_cfs_rq (kernel/sched/fair.c:6058
(discriminator 1))
<4>[ 76.372353] lr : unthrottle_cfs_rq (kernel/sched/fair.c:6058
(discriminator 1))
<4>[   76.372811] sp : ffff800080003d40
<4>[   76.373158] x29: ffff800080003d40 x28: fff00000ff4c8fc0 x27:
ffff942fdc51e4ae
<4>[   76.373978] x26: 0000000000000080 x25: 0000000000000000 x24:
0000000000000001
<4>[   76.374670] x23: fff00000ff4c8fc0 x22: 0000000000000000 x21:
fff0000005eec400
<4>[   76.375312] x20: fff0000005f29800 x19: fff00000044d4c00 x18:
0000000000000006
<4>[   76.375955] x17: fff06bd123665000 x16: ffff800080000000 x15:
ffff8000800036d0
<4>[   76.376600] x14: 0000000000000000 x13: 646579616c65645f x12:
64656863733e2d65
<4>[   76.377284] x11: fffffffffffe0000 x10: ffff942fdbfe0238 x9 :
ffff942fd9944c54
<4>[   76.378034] x8 : 00000000ffffefff x7 : ffff942fdbfde390 x6 :
0000000000000147
<4>[   76.378675] x5 : 0000000000000148 x4 : 40000000fffff147 x3 :
0000000000000000
<4>[   76.379341] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
ffff942fdbf6ab00
<4>[   76.380133] Call trace:
<4>[ 76.380430] unthrottle_cfs_rq (kernel/sched/fair.c:6058 (discriminator 1))
<4>[ 76.380910] distribute_cfs_runtime (kernel/sched/fair.c:6254)
<4>[ 76.381345] sched_cfs_period_timer (kernel/sched/fair.c:6307
kernel/sched/fair.c:6525)
<4>[ 76.381765] __hrtimer_run_queues (kernel/time/hrtimer.c:1691
kernel/time/hrtimer.c:1755)
<4>[ 76.382253] hrtimer_interrupt (kernel/time/hrtimer.c:1820)
<4>[ 76.382629] arch_timer_handler_phys
(drivers/clocksource/arm_arch_timer.c:675
drivers/clocksource/arm_arch_timer.c:692)
<4>[ 76.383040] handle_percpu_devid_irq (kernel/irq/chip.c:942
(discriminator 2))
<4>[ 76.383442] generic_handle_domain_irq (kernel/irq/irqdesc.c:693
kernel/irq/irqdesc.c:748)
<4>[ 76.383858] gic_handle_irq (drivers/irqchip/irq-gic.c:344 (discriminator 1))
<4>[ 76.384219] call_on_irq_stack (arch/arm64/kernel/entry.S:895)
<4>[ 76.384591] do_interrupt_handler (arch/arm64/kernel/entry-common.c:310)
<4>[ 76.385011] el1_interrupt (arch/arm64/kernel/entry-common.c:537
arch/arm64/kernel/entry-common.c:551)
<4>[ 76.385377] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:557)
<4>[ 76.385779] el1h_64_irq (arch/arm64/kernel/entry.S:594)
<4>[ 76.386138] __schedule (kernel/sched/sched.h:1501 kernel/sched/core.c:6681)
<4>[ 76.386481] schedule_idle
(include/asm-generic/bitops/generic-non-atomic.h:128
include/linux/thread_info.h:192 include/linux/sched.h:2109
kernel/sched/core.c:6796)
<4>[ 76.386822] do_idle (kernel/sched/idle.c:358)
<4>[ 76.387149] cpu_startup_entry (kernel/sched/idle.c:423)
<4>[ 76.387510] rest_init (main.c:?)
<4>[ 76.387837] start_kernel (init/main.c:915 (discriminator 1))
<4>[ 76.388183] __primary_switched (arch/arm64/kernel/head.S:244)
<4>[   76.388714] ---[ end trace 0000000000000000 ]---
<4>[   76.391991] ------------[ cut here ]------------
<4>[   76.392496] delay && se->sched_delayed
<4>[ 76.392585] WARNING: CPU: 1 PID: 0 at kernel/sched/fair.c:5486
dequeue_entity (kernel/sched/fair.c:5486 (discriminator 1))
<4>[   76.393578] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight dm_mod ip_tables x_tables
<4>[   76.400266] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G
  W          6.11.0-rc6-next-20240902 #1
<4>[   76.401509] Tainted: [W]=WARN
<4>[   76.402412] Hardware name: linux,dummy-virt (DT)
<4>[   76.403417] pstate: 624000c9 (nZCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=--)
<4>[ 76.404614] pc : dequeue_entity (kernel/sched/fair.c:5486 (discriminator 1))
<4>[ 76.405630] lr : dequeue_entity (kernel/sched/fair.c:5486 (discriminator 1))
<4>[   76.406618] sp : ffff80008000bc00
<4>[   76.407479] x29: ffff80008000bc00 x28: 0000000000000000 x27:
0000000000000009
<4>[   76.408828] x26: fff0000005f29800 x25: fff0000004601300 x24:
0000000000000008
<4>[   76.410693] x23: 0000000000000001 x22: 0000000000000000 x21:
0000000000000009
<4>[   76.411616] x20: fff0000005f29800 x19: fff00000044d4c00 x18:
0000000000000006
<4>[   76.413420] x17: fff06bd123687000 x16: ffff800080008000 x15:
ffff80008000b590
<4>[   76.414827] x14: 0000000000000000 x13: 646579616c65645f x12:
64656863733e2d65
<4>[   76.415752] x11: fffffffffffe0000 x10: ffff942fdbfe0640 x9 :
ffff942fd9944c54
<4>[   76.417555] x8 : 00000000ffffefff x7 : ffff942fdbfde390 x6 :
0000000000000172
<4>[   76.418529] x5 : 0000000000000173 x4 : 40000000fffff172 x3 :
0000000000000000
<4>[   76.419887] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
fff0000003c83900
<4>[   76.421775] Call trace:
<4>[ 76.422157] dequeue_entity (kernel/sched/fair.c:5486 (discriminator 1))
<4>[ 76.423143] dequeue_entities (kernel/sched/fair.c:7099 (discriminator 1))
<4>[ 76.424546] dequeue_task_fair (kernel/sched/fair.c:7187 (discriminator 1))
<4>[ 76.425129] deactivate_task (kernel/sched/core.c:2075)
<4>[ 76.426155] sched_balance_rq (kernel/sched/fair.c:9378
kernel/sched/fair.c:9513 kernel/sched/fair.c:11657)
<4>[ 76.427142] sched_balance_domains (kernel/sched/fair.c:12078
(discriminator 1))
<4>[ 76.428151] sched_balance_softirq (kernel/sched/fair.c:12791)
<4>[ 76.429218] handle_softirqs
(arch/arm64/include/asm/jump_label.h:32 include/linux/jump_label.h:207
include/trace/events/irq.h:142 kernel/softirq.c:555)
<4>[ 76.430268] __do_softirq (kernel/softirq.c:589)
<4>[ 76.431615] ____do_softirq (arch/arm64/kernel/irq.c:82)
<4>[ 76.432535] call_on_irq_stack (arch/arm64/kernel/entry.S:895)
<4>[ 76.433171] do_softirq_own_stack (arch/arm64/kernel/irq.c:87)
<4>[ 76.434232] irq_exit_rcu (kernel/softirq.c:435
kernel/softirq.c:637 kernel/softirq.c:649)
<4>[ 76.435577] el1_interrupt (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/entry-common.c:280
arch/arm64/kernel/entry-common.c:539
arch/arm64/kernel/entry-common.c:551)
<4>[ 76.436496] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:557)
<4>[ 76.437081] el1h_64_irq (arch/arm64/kernel/entry.S:594)
<4>[ 76.438464] default_idle_call (kernel/sched/idle.c:126)
<4>[ 76.439004] do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:326)
<4>[ 76.439910] cpu_startup_entry (kernel/sched/idle.c:423)
<4>[ 76.440930] secondary_start_kernel
(arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 2)
arch/arm64/include/asm/atomic.h:28 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:546 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:994 (discriminator 2)
include/linux/atomic/atomic-instrumented.h:436 (discriminator 2)
include/linux/sched/mm.h:37 (discriminator 2)
arch/arm64/kernel/smp.c:214 (discriminator 2))
<4>[ 76.442456] __secondary_switched (arch/arm64/kernel/head.S:418)
<4>[   76.443021] ---[ end trace 0000000000000000 ]---
cfs_bandwidth01.c:58: TINFO: Set 'level2/cpu.max' = '5000 10000'
cfs_bandwidth01.c:133: TPASS: Workers exited
cfs_bandwidth01.c:121: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:58: TINFO: Set 'level2/cpu.max' = '5000 10000'
cfs_bandwidth01.c:133: TPASS: Workers exited
cfs_bandwidth01.c:121: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:58: TINFO: Set 'level2/cpu.max' = '5000 10000'
cfs_bandwidth01.c:133: TPASS: Workers exited
cfs_bandwidth01.c:121: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:58: TINFO: Set 'level2/cpu.max' = '5000 10000'
cfs_bandwidth01.c:133: TPASS: Workers exited
tst_test.c:1660: TFAIL: Kernel is now tainted.

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39f23ce07b93
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b34cb07dde7c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cbc
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5ab297bab984
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4d22468dae
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fdaba61ef8a2

Summary:
passed   10
failed   1

Links:
------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240902/testrun/25012571/suite/log-parser-test/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240902/testrun/25012571/suite/log-parser-test/test/check-kernel-exception-delay-se-sched_delayed-7f35581d9865db33d9f09972c01ae7b6cb8a509142c92c54add4efc4117697cf/log

Test history compare log:
------------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240902/testrun/25012571/suite/log-parser-test/test/check-kernel-exception-se-sched_delayed/history/

metadata:
----
  git describe: next-20240902
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: ecc768a84f0b8e631986f9ade3118fa37852fef0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3UVei3To0rSt5txVKQouoWS/config
  kernel version: 6.11.0-rc6
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3UVei3To0rSt5txVKQouoWS/
  toolchain: clang-18 and gcc-13
  arch: arm64 and x86_64

Steps to reproduce:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3UVei3To0rSt5txVKQouoWS/tuxmake_reproducer.sh
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lWV3UVei3To0rSt5txVKQouoWS/tux_plan.yaml

--
Linaro LKFT
https://lkft.linaro.org


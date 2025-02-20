Return-Path: <linux-kernel+bounces-524176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21877A3E01C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0AC189C625
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09658200B9C;
	Thu, 20 Feb 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHMEoqUX"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A51FFC4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068022; cv=none; b=HGU/ef7dKQTFaMrMwWw0CzqOGSKTxiPie3AWxs4bS0vlVx8UYUFZt4aiKejPEnV9C87qvjx+xcpfT7Epyak/Yr4qfHiwtPtpphwmKSh7zq2lvpXq8HRUWEzZhP/J5iMMS151h7ZLtFZSFZF2PnqtopkJxcF7SgqpXvETn5Fo8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068022; c=relaxed/simple;
	bh=WJjthDEu0Fp7g6aRbLnGr4v0ahBplluVun4mHaBwH1w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZBG+++x1iy57bEueJOQiLjTUf/q1CH26GmKQgiOVplYzHxZXlClphEGEJMBKbyC2NrwEhp3MOsc3TyPhChT8pyEdyOCKZ1nIiih4I9a4r9UyjuYyskIglil1uqt6Sw1GWLTn6aDa59mmUp5WhbllVtQZqWFccfAlP18jWfJj0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHMEoqUX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5209962eefbso1297927e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068018; x=1740672818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V879Iy5VcztBBIWmczzB/FWi9rCG1hoQENLoZiXnBvA=;
        b=SHMEoqUX/rslKiMZ82tfUz0NB5ExB+b6BK1ZvMlEEDcFJ7Wr9MJMRLqqSnqkxcgrf6
         +4xG8gsh6Z7OHAcQ7aWNPR4gqxHuLxLMJoSuVmOGck8nf5iSFHXwPZKj2umfGUCkY0Cz
         TVBpKEe/6aKcWFUzsfoifAHgho1G2kEuCcYfg5KNPmjiYkp7kwcmTIWTheeTWrcZZdES
         vj8EhS7rCDh2V/yTJm6r02L3dFpfk8jZBNHg6ZJITQseI7oAecZa2tzOteRn27lswiYE
         tK1EZ+bjwU/gZBzfJHuY0wevw06JNGPSB4Fn4FBguQ5GjQK4pwO7HvT96SI9yDMvsiNm
         2scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068018; x=1740672818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V879Iy5VcztBBIWmczzB/FWi9rCG1hoQENLoZiXnBvA=;
        b=hdNVirP3IJyDIFrqLU/b+0ujJhL5HPfnYh77MgwmdO1trvt/vncv+uusmxx0IoE6qt
         O1u0XiuuM2WxLBIn/EfodiHnk6lT4vuTTLRE9tVdTrvDSUp81nAw/9vycOnY49Eb3jI+
         jJyHor1cQ/aKitJqQvW8nPWBn1FVWWHhXEz+AsTxVFtasWBB9rOaXbsXX+9Vdc53qm6B
         TtEk1sY6uLAw7mgNer952WRjt7A0gkhktJLpea+uEyd0HzSt5I0DGhvTYIZ+OB7n55Jo
         3HQV0opeX54G52AgHDIW8SrAWrbUrdS8BsM6qPq2Vm7gLkyfCMiy83F2Z8nijIK5zZs7
         5S0g==
X-Forwarded-Encrypted: i=1; AJvYcCVLRDUdCjDVE6qOM8PjyWnuvPsfvYYa+Z8oSasuFhoi11pakzfRaMbOgopLOL6xTtjg1kWV8dRcwoK1ulY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DbAjg6cHLaYgHfGn45Q/qWK95f2eWNo3edqLkGzFYbnIEgT7
	ajTF4MHBttuZjNy/w3RFitRiWTPN4ILoHuQMVgL8ZFW+1eyCxwoLBr6onIbaf8MvM45Q6JbJqZi
	D7QNgKP8+DGrf5IdGA9bARMn2jlwZbMfSDzNExQ==
X-Gm-Gg: ASbGnctD8UjCO2AdxJxkIKo81LgbUyNNf66zuQrc0twt5SAzqWjfiZ+CnA2vu+e+k8O
	rWqhdHiINaDbwt5xiYrclZdXmwICNTpoiSR04K21janmPrDqWPlgfoHsURPXDEA38yJmtunFtlb
	g39ChPsUW1Ilqr+MBxepKL/5VbuRD4Tw==
X-Google-Smtp-Source: AGHT+IFOiwZCl0rxvNfwH8m/y6qEhO2vlqH8zC1rbxAsDQ/BH7O5MpliguoeJImu0JZ1xu0+r0UbS2zjSMnKnLqd9RA=
X-Received: by 2002:a05:6122:17a7:b0:51e:ffd1:67f3 with SMTP id
 71dfb90a1353d-521dce38ba8mr2135245e0c.7.1740068018212; Thu, 20 Feb 2025
 08:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 21:43:26 +0530
X-Gm-Features: AWEUYZkFcm73g8zLPsZavQg0Lht5rrlBSiureL7_1d0H-gYUnSDy_oWi453RMyo
Message-ID: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Subject: next-20250218: arm64 LTP pids kernel panic loop_free_idle_workers
To: linux-block <linux-block@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	LTP List <ltp@lists.linux.it>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regression on qemu-arm64 the kernel panic noticed while running the
LTP controllers pids.sh test cases on Linux next 20250218 and started
from the next-20250214

Test regression: arm64 LTP pids kernel panic loop_free_idle_workers

Started noticing from next-20250214.
Good: next-20250213
Bad: next-20250213..next-20250218

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
---------
[    0.000000] Linux version 6.14.0-rc2-next-20250214
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-12) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.43.90.20250127) #1 SMP PREEMPT
@1739528119
<trim>
command: pids.sh 6 50 0
<12>[  221.776255] /usr/local/bin/kirk[262]: starting test pids_6_50
(pids.sh 6 50 0)
pids 1 TINFO: Running: pids.sh 6 50 0
pids 1 TINFO: Tested kernel: Linux
runner-ykxhnyexq-project-40964107-concurrent-0
6.14.0-rc2-next-20250214 #1 SMP PREEMPT @1739528119 aarch64 GNU/Linux
pids 1 TINFO: ceiling LTP_TIMEOUT_MUL to 11
pids 1 TINFO: timeout per run is 0h 55m 0s
pids 1 TINFO: test starts with cgroup version 2
pids 1 TINFO: Running testcase 6 with 50 processes
pids 1 TINFO: set a limit that is smaller than current number of pids
<1>[  224.406844] Unable to handle kernel paging request at virtual
address dead000000000108
<1>[  224.407052] Mem abort info:
<1>[  224.407100]   ESR =3D 0x0000000096000044
<1>[  224.407219]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>[  224.407315]   SET =3D 0, FnV =3D 0
<1>[  224.407400]   EA =3D 0, S1PTW =3D 0
<1>[  224.407459]   FSC =3D 0x04: level 0 translation fault
<1>[  224.407536] Data abort info:
<1>[  224.407577]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
<1>[  224.407621]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
<1>[  224.407697]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
<1>[  224.407809] [dead000000000108] address between user and kernel
address ranges
<0>[  224.408307] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
<4>[  224.416979] Modules linked in: btrfs blake2b_generic xor
xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[  224.421352] CPU: 0 UID: 0 PID: 3368 Comm: pids_task2 Not tainted
6.14.0-rc2-next-20250214 #1
<4>[  224.422657] Hardware name: linux,dummy-virt (DT)
<4>[  224.423946] pstate: 224020c9 (nzCv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=3D--)
<4>[ 224.424677] pc : loop_free_idle_workers (include/linux/list.h:195
include/linux/list.h:218 include/linux/list.h:229
drivers/block/loop.c:917)
<4>[ 224.426548] lr : loop_free_idle_workers (drivers/block/loop.c:911
(discriminator 2))
<4>[  224.427338] sp : ffff800080003d50
<4>[  224.427910] x29: ffff800080003d50 x28: fff238a88301c500 x27:
fff238a883084c00
<4>[  224.429587] x26: ffffa298bac57000 x25: ffffffffffffc568 x24:
dead000000000122
<4>[  224.430697] x23: fff238a880370ac8 x22: dead000000000100 x21:
0000000000000000
<4>[  224.432004] x20: fff238a880370ab8 x19: dead0000000000b8 x18:
ffff800083d9bb90
<4>[  224.432538] x17: fff296100496b000 x16: ffff800080000000 x15:
0000ffff8d0a9fff
<4>[  224.433866] x14: 0000000000000000 x13: 1ffe47151065cc61 x12:
fff238a8832e630c
<4>[  224.434769] x11: 003a9cb01550c679 x10: fff238a8bf4b7f70 x9 :
ffffa298b8fc3cd0
<4>[  224.436209] x8 : ffff800080003c28 x7 : 0000000000000101 x6 :
ffff800080003ce0
<4>[  224.437070] x5 : fff238a880eba680 x4 : dead000000000100 x3 :
dead000000000122
<4>[  224.438027] x2 : 0000000000000000 x1 : 00000000ffff50fc x0 :
00000000ffff7b68
<4>[  224.439174] Call trace:
<4>[ 224.439882] loop_free_idle_workers (include/linux/list.h:195
include/linux/list.h:218 include/linux/list.h:229
drivers/block/loop.c:917) (P)
<4>[ 224.440765] loop_free_idle_workers_timer (drivers/block/loop.c:932)
<4>[ 224.441223] call_timer_fn (arch/arm64/include/asm/jump_label.h:36
include/trace/events/timer.h:127 kernel/time/timer.c:1790)
<4>[ 224.441822] __run_timers (kernel/time/timer.c:1841
kernel/time/timer.c:2414)
<4>[ 224.442389] run_timer_base (kernel/time/timer.c:2427
kernel/time/timer.c:2418 kernel/time/timer.c:2435)
<4>[ 224.442855] run_timer_softirq
(arch/arm64/include/asm/jump_label.h:36 kernel/time/timer.c:342
kernel/time/timer.c:2448)
<4>[ 224.443547] handle_softirqs
(arch/arm64/include/asm/jump_label.h:36 include/trace/events/irq.h:142
kernel/softirq.c:562)
<4>[ 224.444121] __do_softirq (kernel/softirq.c:596)
<4>[ 224.444755] ____do_softirq (arch/arm64/kernel/irq.c:82)
<4>[ 224.445204] call_on_irq_stack (arch/arm64/kernel/entry.S:897)
<4>[ 224.445670] do_softirq_own_stack (arch/arm64/kernel/irq.c:87)
<4>[ 224.445964] __irq_exit_rcu (kernel/softirq.c:442 kernel/softirq.c:662)
<4>[ 224.446295] irq_exit_rcu (kernel/softirq.c:680)
<4>[ 224.446808] el1_interrupt (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/entry-common.c:280
arch/arm64/kernel/entry-common.c:563
arch/arm64/kernel/entry-common.c:575)
<4>[ 224.447585] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:581)
<4>[ 224.448079] el1h_64_irq (arch/arm64/kernel/entry.S:596)
<4>[ 224.448796] try_charge_memcg (mm/memcontrol.c:1803
mm/memcontrol.c:2222) (P)
<4>[ 224.449589] charge_memcg (mm/memcontrol.c:4541)
<4>[ 224.450399] __mem_cgroup_charge (include/linux/cgroup_refcnt.h:78
mm/memcontrol.c:4558)
<4>[ 224.451234] __handle_mm_fault (mm/memory.c:1059 (discriminator 1)
mm/memory.c:5462 (discriminator 1) mm/memory.c:5574 (discriminator 1)
mm/memory.c:4091 (discriminator 1) mm/memory.c:5935 (discriminator 1)
mm/memory.c:6078 (discriminator 1))
<4>[ 224.451763] handle_mm_fault (mm/memory.c:6247)
<4>[ 224.452307] do_page_fault (arch/arm64/mm/fault.c:647)
<4>[ 224.452881] do_translation_fault (arch/arm64/mm/fault.c:787)
<4>[ 224.453358] do_mem_abort (arch/arm64/mm/fault.c:919 (discriminator 1))
<4>[ 224.453890] el0_da (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:605 (discriminator 1))
<4>[ 224.454329] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:766=
)
<4>[ 224.454897] el0t_64_sync (arch/arm64/kernel/entry.S:600)
<0>[ 224.455654] Code: 8b190000 eb01001f 54000684 a9448f84 (f9000483)
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 8b190000 add x0, x0, x25
   4: eb01001f cmp x0, x1
   8: 54000684 b.mi 0xd8  // b.first
   c: a9448f84 ldp x4, x3, [x28, #72]
  10:* f9000483 str x3, [x4, #8] <-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: f9000483 str x3, [x4, #8]
<4>[  224.456945] ---[ end trace 0000000000000000 ]---
<0>[  224.458162] Kernel panic - not syncing: Oops: Fatal exception in inte=
rrupt
<2>[  224.459437] SMP: stopping secondary CPUs
<0>[  224.460808] Kernel Offset: 0x229838400000 from 0xffff800080000000
<0>[  224.461525] PHYS_OFFSET: 0xfffdc75880000000
<0>[  224.462166] CPU features: 0x000,000000d0,60bef2f8,cb7e7f3f
<0>[  224.463148] Memory Limit: none
<0>[  224.463861] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

## Source
* Kernel version: 6.14.0-rc2-next-20250214
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
* Git sha: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
* Git describe: next-20250214
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/

## Build
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next=
-20250214/testrun/27292264/suite/log-parser-test/test/panic-multiline-kerne=
l-panic-not-syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef65=
7ef456dab84b63ef36eb42dc7c556dfa0f7a59423da/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/te=
strun/27292264/suite/log-parser-test/test/panic-multiline-kernel-panic-not-=
syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef657ef456dab84b=
63ef36eb42dc7c556dfa0f7a59423da/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/te=
strun/27292264/suite/log-parser-test/test/panic-multiline-kernel-panic-not-=
syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef657ef456dab84b=
63ef36eb42dc7c556dfa0f7a59423da/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2t1m4RtgCbRZ2vhQrdEI=
wwj3DIY/config
* Architecures: arm64
* Toolchain version: gcc-13

--
Linaro LKFT
https://lkft.linaro.org


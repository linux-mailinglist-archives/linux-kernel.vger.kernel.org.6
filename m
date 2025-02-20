Return-Path: <linux-kernel+bounces-524215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28898A3E0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BA5189F3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF9204840;
	Thu, 20 Feb 2025 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHO3cIWr"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8D1361
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068731; cv=none; b=e2wQTcuZ7eloCOVtJeqgch/Gatm/3TXMiir6lsT6xYmHCuswTtwUmjuQ3lH1d/G/HzghFGYDUoKCiClSuetqM1hyBz2KzvhOIkL9RgJ4uucAa4kkCt024CKBGLjYQm1OGN+989sexWMww7FE9mTXLpy5gdftukXJ1xMNDWzbekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068731; c=relaxed/simple;
	bh=XJ1YHwGc4HOgLzYcRMCmQLIo3HHSOhcJrGIu+v08SWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVhfpcw3fVkrkySVbGhQg4hAtXFMQHDVRyJif3GwMAIfVRUkch6e4uNB4kOzyoDVTvNnio1lywb+4pLpCBwoKn81BXGn3pwlyzc3Timoko1XRV9EQEa+2iYUZfljovap8agMIylOzoNwBL9d3y5u2XIqk8nrzEhwUbkEbyM6euE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHO3cIWr; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4ba0eb3b0f9so370971137.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068728; x=1740673528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4NVZ4u4g0mYQeqWa/31JJuaJEaKiBQfTCzwM9NxQa8=;
        b=pHO3cIWr5Vftccyf0V4h29kuVqTcibVwDmK64XvvaGpyVyYRsCcy+ZzD57+hX8fD8U
         S2aSvEo93sAoM+U0aytJLhZ3MW+eVQXPYkaSY4PuogBL/0nxs6IkAxgmnKF1wweZMIm9
         6R/VFxUZCu1JDTDY8gByp7yc4s774IWnwt+2PA2yttpxcl4MmOYnGNKwHcx5oQp4F746
         mRhNd+LuokqWupw6fH+pqH/GFHAdqFJugmdaMf56glHf0F1caVbe2NvHtsKhbbErHNcM
         q1VQs5tA/jRfdgNHumhZ1EgIAfhv2DQuVW8Um93vmyATCVverAkntMiDH3kTs465C/0+
         7Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068728; x=1740673528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4NVZ4u4g0mYQeqWa/31JJuaJEaKiBQfTCzwM9NxQa8=;
        b=GQBa4zMt4K+aacptOWysDHjl8u6jN4ktH52E4e8HWHICoZSIfqnRB8S4nLkwMFlTrz
         G4gFw4ycnKZTME8F400vro3y86EhkYoqRjlWquo3FFlJB9zDn+XQ/pJAi7TT6ChE4YzZ
         nkpbx3BM/RrGIeq6/8mhD6k5nvrUKydjkBHLMoBpI2EKKWzKpcF98rtoDxUqyPYIFrvW
         5GGKnvwkDFIQmQCRpNMT+IE/ujwvZlP/TgPcmBLak5yTEwXl1QEPgSpwDmDTksdqyqtZ
         Ja7r48hsuVwpxP+KJmSKCeMJkPmTcAd5DDmUVlVT/miPYZrWADh+dRFBiaoJX4beBsGW
         N12w==
X-Forwarded-Encrypted: i=1; AJvYcCUu8ly1oYptWMxLAPmEAv/S/k1AgVXmAy0jAG8wUZTUGAfg5n6xrYT6CcM07QkpfAH/DWajo+fIZbZc098=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7SqVPHh9DinR3OR24c66+YmXfMJM3IAYKrs9LGPiqwnY1sj3
	aKRgRC6+yVYe0CNuyWiehYDgUmJ2GRoGHMlM29/qATc6lBl/sfuTKsRUzjL+65fw9yNzPFgyruL
	i5JUifB3e3FTrncHoaW3hDsBXhaq7YQZ0wcUX9Q==
X-Gm-Gg: ASbGncsxtOcPfUhEE4GksWBytxvwuANkQol9NZ+wsJ8Xp7MTc1q9cvvv9ru7XUPtS/h
	q5T8i5e8oVea9snJZtuSdILmCD6EUvn06iC9nBEACxLZZMie/d41BPHlZUNZjNtesXmr8qofx25
	KYARYZzQK7fyR+UQuO7GCHnOjK1ohWxQ==
X-Google-Smtp-Source: AGHT+IGAPsB8fOGFnMsc5bbDL/20Hc4p5mldlRlSsXETttbyejgn8/EaugsjmRRuL/VRAqS5GhQVa3kdI+AXpngBYvA=
X-Received: by 2002:a05:6102:2c82:b0:4ba:9689:8725 with SMTP id
 ada2fe7eead31-4bd3fd51580mr13177418137.14.1740068728182; Thu, 20 Feb 2025
 08:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
In-Reply-To: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 21:55:17 +0530
X-Gm-Features: AWEUYZn1l7Lv2Zb-WyCLSGTtO5qeqIeMQIdyyZsol69LDhzeihx6MkTJeGQixZg
Message-ID: <CA+G9fYs-cbuu+o15E9V+AneYT0kp_e2CQWS+4HTxkM+zuz0cMQ@mail.gmail.com>
Subject: Re: next-20250218: arm64 LTP pids kernel panic loop_free_idle_workers
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

On Thu, 20 Feb 2025 at 21:43, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> Regression on qemu-arm64 the kernel panic noticed while running the
> LTP controllers pids.sh test cases on Linux next 20250218 and started
> from the next-20250214
>
> Test regression: arm64 LTP pids kernel panic loop_free_idle_workers
>
> Started noticing from next-20250214.
> Good: next-20250213
> Bad: next-20250213..next-20250218

[Sorry typo ]
Bad: next-20250214..next-20250218

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Boot log:
> ---------
> [    0.000000] Linux version 6.14.0-rc2-next-20250214
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-12) 13.3.0,
> GNU ld (GNU Binutils for Debian) 2.43.90.20250127) #1 SMP PREEMPT
> @1739528119
> <trim>
> command: pids.sh 6 50 0
> <12>[  221.776255] /usr/local/bin/kirk[262]: starting test pids_6_50
> (pids.sh 6 50 0)
> pids 1 TINFO: Running: pids.sh 6 50 0
> pids 1 TINFO: Tested kernel: Linux
> runner-ykxhnyexq-project-40964107-concurrent-0
> 6.14.0-rc2-next-20250214 #1 SMP PREEMPT @1739528119 aarch64 GNU/Linux
> pids 1 TINFO: ceiling LTP_TIMEOUT_MUL to 11
> pids 1 TINFO: timeout per run is 0h 55m 0s
> pids 1 TINFO: test starts with cgroup version 2
> pids 1 TINFO: Running testcase 6 with 50 processes
> pids 1 TINFO: set a limit that is smaller than current number of pids
> <1>[  224.406844] Unable to handle kernel paging request at virtual
> address dead000000000108
> <1>[  224.407052] Mem abort info:
> <1>[  224.407100]   ESR =3D 0x0000000096000044
> <1>[  224.407219]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> <1>[  224.407315]   SET =3D 0, FnV =3D 0
> <1>[  224.407400]   EA =3D 0, S1PTW =3D 0
> <1>[  224.407459]   FSC =3D 0x04: level 0 translation fault
> <1>[  224.407536] Data abort info:
> <1>[  224.407577]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
> <1>[  224.407621]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> <1>[  224.407697]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> <1>[  224.407809] [dead000000000108] address between user and kernel
> address ranges
> <0>[  224.408307] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> <4>[  224.416979] Modules linked in: btrfs blake2b_generic xor
> xor_neon raid6_pq zstd_compress sm3_ce sm3 sha3_ce sha512_ce
> sha512_arm64 fuse drm backlight ip_tables x_tables
> <4>[  224.421352] CPU: 0 UID: 0 PID: 3368 Comm: pids_task2 Not tainted
> 6.14.0-rc2-next-20250214 #1
> <4>[  224.422657] Hardware name: linux,dummy-virt (DT)
> <4>[  224.423946] pstate: 224020c9 (nzCv daIF +PAN -UAO +TCO -DIT
> -SSBS BTYPE=3D--)
> <4>[ 224.424677] pc : loop_free_idle_workers (include/linux/list.h:195
> include/linux/list.h:218 include/linux/list.h:229
> drivers/block/loop.c:917)
> <4>[ 224.426548] lr : loop_free_idle_workers (drivers/block/loop.c:911
> (discriminator 2))
> <4>[  224.427338] sp : ffff800080003d50
> <4>[  224.427910] x29: ffff800080003d50 x28: fff238a88301c500 x27:
> fff238a883084c00
> <4>[  224.429587] x26: ffffa298bac57000 x25: ffffffffffffc568 x24:
> dead000000000122
> <4>[  224.430697] x23: fff238a880370ac8 x22: dead000000000100 x21:
> 0000000000000000
> <4>[  224.432004] x20: fff238a880370ab8 x19: dead0000000000b8 x18:
> ffff800083d9bb90
> <4>[  224.432538] x17: fff296100496b000 x16: ffff800080000000 x15:
> 0000ffff8d0a9fff
> <4>[  224.433866] x14: 0000000000000000 x13: 1ffe47151065cc61 x12:
> fff238a8832e630c
> <4>[  224.434769] x11: 003a9cb01550c679 x10: fff238a8bf4b7f70 x9 :
> ffffa298b8fc3cd0
> <4>[  224.436209] x8 : ffff800080003c28 x7 : 0000000000000101 x6 :
> ffff800080003ce0
> <4>[  224.437070] x5 : fff238a880eba680 x4 : dead000000000100 x3 :
> dead000000000122
> <4>[  224.438027] x2 : 0000000000000000 x1 : 00000000ffff50fc x0 :
> 00000000ffff7b68
> <4>[  224.439174] Call trace:
> <4>[ 224.439882] loop_free_idle_workers (include/linux/list.h:195
> include/linux/list.h:218 include/linux/list.h:229
> drivers/block/loop.c:917) (P)
> <4>[ 224.440765] loop_free_idle_workers_timer (drivers/block/loop.c:932)
> <4>[ 224.441223] call_timer_fn (arch/arm64/include/asm/jump_label.h:36
> include/trace/events/timer.h:127 kernel/time/timer.c:1790)
> <4>[ 224.441822] __run_timers (kernel/time/timer.c:1841
> kernel/time/timer.c:2414)
> <4>[ 224.442389] run_timer_base (kernel/time/timer.c:2427
> kernel/time/timer.c:2418 kernel/time/timer.c:2435)
> <4>[ 224.442855] run_timer_softirq
> (arch/arm64/include/asm/jump_label.h:36 kernel/time/timer.c:342
> kernel/time/timer.c:2448)
> <4>[ 224.443547] handle_softirqs
> (arch/arm64/include/asm/jump_label.h:36 include/trace/events/irq.h:142
> kernel/softirq.c:562)
> <4>[ 224.444121] __do_softirq (kernel/softirq.c:596)
> <4>[ 224.444755] ____do_softirq (arch/arm64/kernel/irq.c:82)
> <4>[ 224.445204] call_on_irq_stack (arch/arm64/kernel/entry.S:897)
> <4>[ 224.445670] do_softirq_own_stack (arch/arm64/kernel/irq.c:87)
> <4>[ 224.445964] __irq_exit_rcu (kernel/softirq.c:442 kernel/softirq.c:66=
2)
> <4>[ 224.446295] irq_exit_rcu (kernel/softirq.c:680)
> <4>[ 224.446808] el1_interrupt (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/entry-common.c:280
> arch/arm64/kernel/entry-common.c:563
> arch/arm64/kernel/entry-common.c:575)
> <4>[ 224.447585] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:58=
1)
> <4>[ 224.448079] el1h_64_irq (arch/arm64/kernel/entry.S:596)
> <4>[ 224.448796] try_charge_memcg (mm/memcontrol.c:1803
> mm/memcontrol.c:2222) (P)
> <4>[ 224.449589] charge_memcg (mm/memcontrol.c:4541)
> <4>[ 224.450399] __mem_cgroup_charge (include/linux/cgroup_refcnt.h:78
> mm/memcontrol.c:4558)
> <4>[ 224.451234] __handle_mm_fault (mm/memory.c:1059 (discriminator 1)
> mm/memory.c:5462 (discriminator 1) mm/memory.c:5574 (discriminator 1)
> mm/memory.c:4091 (discriminator 1) mm/memory.c:5935 (discriminator 1)
> mm/memory.c:6078 (discriminator 1))
> <4>[ 224.451763] handle_mm_fault (mm/memory.c:6247)
> <4>[ 224.452307] do_page_fault (arch/arm64/mm/fault.c:647)
> <4>[ 224.452881] do_translation_fault (arch/arm64/mm/fault.c:787)
> <4>[ 224.453358] do_mem_abort (arch/arm64/mm/fault.c:919 (discriminator 1=
))
> <4>[ 224.453890] el0_da (arch/arm64/include/asm/irqflags.h:82
> (discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
> 1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
> arch/arm64/kernel/entry-common.c:165 (discriminator 1)
> arch/arm64/kernel/entry-common.c:178 (discriminator 1)
> arch/arm64/kernel/entry-common.c:605 (discriminator 1))
> <4>[ 224.454329] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:7=
66)
> <4>[ 224.454897] el0t_64_sync (arch/arm64/kernel/entry.S:600)
> <0>[ 224.455654] Code: 8b190000 eb01001f 54000684 a9448f84 (f9000483)
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0: 8b190000 add x0, x0, x25
>    4: eb01001f cmp x0, x1
>    8: 54000684 b.mi 0xd8  // b.first
>    c: a9448f84 ldp x4, x3, [x28, #72]
>   10:* f9000483 str x3, [x4, #8] <-- trapping instruction
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0: f9000483 str x3, [x4, #8]
> <4>[  224.456945] ---[ end trace 0000000000000000 ]---
> <0>[  224.458162] Kernel panic - not syncing: Oops: Fatal exception in in=
terrupt
> <2>[  224.459437] SMP: stopping secondary CPUs
> <0>[  224.460808] Kernel Offset: 0x229838400000 from 0xffff800080000000
> <0>[  224.461525] PHYS_OFFSET: 0xfffdc75880000000
> <0>[  224.462166] CPU features: 0x000,000000d0,60bef2f8,cb7e7f3f
> <0>[  224.463148] Memory Limit: none
> <0>[  224.463861] ---[ end Kernel panic - not syncing: Oops: Fatal
> exception in interrupt ]---
>
> ## Source
> * Kernel version: 6.14.0-rc2-next-20250214
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> * Git sha: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
> * Git describe: next-20250214
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/
>
> ## Build
> * Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/ne=
xt-20250214/testrun/27292264/suite/log-parser-test/test/panic-multiline-ker=
nel-panic-not-syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef=
657ef456dab84b63ef36eb42dc7c556dfa0f7a59423da/log
> * Test history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/=
testrun/27292264/suite/log-parser-test/test/panic-multiline-kernel-panic-no=
t-syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef657ef456dab8=
4b63ef36eb42dc7c556dfa0f7a59423da/history/
> * Test details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250214/=
testrun/27292264/suite/log-parser-test/test/panic-multiline-kernel-panic-no=
t-syncing-oops-fatal-exception-in-interrupt-89d94046139a63ab8ef657ef456dab8=
4b63ef36eb42dc7c556dfa0f7a59423da/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2t1m4RtgCbRZ2vhQrd=
EIwwj3DIY/config
> * Architecures: arm64
> * Toolchain version: gcc-13
>
> --
> Linaro LKFT
> https://lkft.linaro.org


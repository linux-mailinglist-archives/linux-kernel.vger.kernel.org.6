Return-Path: <linux-kernel+bounces-344499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A898AA72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D212865CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967019047D;
	Mon, 30 Sep 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFvCt2ge"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028205103F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715703; cv=none; b=Obz0XR0VSbPAM0z1Xw6gjulpkEubM5/TB/0Bfl/VQVqDtxuaIU6i3Op+BCnCCxIObAdUPHtkkJRhJDG343QRx4obqeehKnJgcHK4N6Re2usCUMcWRe0nvB+FIJJucKtVyrhN+jDmWbgsiWcyVPq6FbpAaROsVnhTHadc+xWPaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715703; c=relaxed/simple;
	bh=38KmRRHXvlblfnvJcD+mxDpOBWfdX/B44/Zr+FZ2VII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/WepgWtdPN0I+fFP4h4ePTBKkIYaUdefTkjekeZhOGS95B3iyy49N6CK/xpGwbflViotcB/GSA+IoYS/VU2WXLnmPuHPyj+WG+FUEFiVwwihEaZx15OSv5H8uTjp0GcQ7r5du0CrAAn3/OMcIZ+Sx/qch3lGSzcLGTlBiWQlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFvCt2ge; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ba733b904so3297175ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715701; x=1728320501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6T2wx8uI1uQdrkQC9ayrTYYnyEA/JI69LHyPVacKTZg=;
        b=hFvCt2geMLQ4AItJCEn7Sse24KyWSsapaE7LRrV4JVXEepoltyP6h3kVfhCxvYobKu
         Hh0bmvOVm4QqU4iOezl2O1Fg/jpcCNn0KCVfQfmLI4L0B4HjSaBw2076kjC9u8Wpam1K
         emxSo4qTuNukoMIiyEPaVDNL+Ukx9uf/IuD0Fq/JvKYElXjIkzZRHi4V1boSgmm8rHK3
         FgsyZ07ancg67FKfxHXsxoYWFgthrKdHLZGj6lN2aeFzJ5203DT5eVupbvcHsXJ1TqK5
         wBnZpC8ldzTfwKoBTLbKK7dI7RuKfTP9qcU06vMIACZ9uyomraqsjruDgzFCeGQ/ZXtP
         m8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715701; x=1728320501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T2wx8uI1uQdrkQC9ayrTYYnyEA/JI69LHyPVacKTZg=;
        b=bLnKciaI2kcYiFT7UvS7BAp3qC/gYnB3dq8z4+63gg+ajmBlMQ+fb8FyPmDXJsvHEl
         UKldUOCTmqCYRBnPMJHzyJnJ4Jtk8n2w7CLsnkEcX4ZYf7HFTX/a52TqIM7qimNTFWn6
         0YqQi4jobDV+m4h1LCzrAeSHCO8dZs3U5RnoxZdqeyfFuDdtcPRB11M9cz/sxBP4RDy5
         emUr1T4chNX0DqRYrhAU8s9OHMQXQMjKPtaAH9EscbBQObiDloVHWNG/XqUp6OqZpkOf
         OdW5dyfhgHlcnmEwhQl+a2K5g1deC52rVW+Y124GIs2sN0EIba05mfmJGaIeCv+h0zIu
         lM3w==
X-Gm-Message-State: AOJu0YwUYbyNGhZZr9Wwb4rXBBJlczL8+QvafmMzZSsoTDy6n78VcmD3
	7Z8A5YP04miwJpWRcG34JaeMjSk6NYIGUB8qvIrRPUr8zpcBFtY+CpMiUg==
X-Google-Smtp-Source: AGHT+IFsc4aezuFKRAqYAYQVUViAQAHx9vdIXhUAjLAZW5m3nUuoaoCuT2jLZEYa2VUiT4AsnhZsvw==
X-Received: by 2002:a17:902:ecd2:b0:20b:632d:27b7 with SMTP id d9443c01a7336-20b632d2a25mr140633075ad.33.1727715701074;
        Mon, 30 Sep 2024 10:01:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e20146sm56325275ad.125.2024.09.30.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:01:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 30 Sep 2024 10:01:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.12-rc1
Message-ID: <f73f68a9-d27d-443e-9cb0-fd35e150055c@roeck-us.net>
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>

On Sun, Sep 29, 2024 at 03:51:43PM -0700, Linus Torvalds wrote:
> So two weeks have passed, and rc1 is out - the merge window is closed.
> 
> Despite conference travel (both for me and several maintainers),
> things seemed to go mostly fairly normally. There's a couple of
> notable new features in here: For one thing, PREEMPT_RT is now
> mainlined and enabled as a config option (you do need to enable
> "EXPERT" to get the question). For another, sched_ext also got merged.
> 
> That said, the bulk is - as always - all the plain old regular
> updates, and that obviously means drivers dominate. We've got about
> 55% of the patch being drivers (and another 5% if you count the dts
> files). Add in 5% doc updates, and 10% tooling (mostly perf and
> selftests).
> 
> That leaves about a quarter of the overall changes as core kernel
> code, split between arch updates, filesystems (yes, bcachefs, but also
> btrfs, smb sever and client, netfs updates, xfs and finally core VFS
> updates mostly in the form of 'struct fd' re-organisational cleanups).
> And MM, core networking, Rust, security layer updates etc.
> 
> A little bit of everything, in other words. And nothing really looks
> all that strange. As always, the summary below is just the log of my
> merges, there's too much to list individually (some stats: 11k+
> regular commits,  850+ merges, 1700+ different authors).
> 
> Let's get the testing and calming down period started, ok?
> 

Build results:
	total: 158 pass: 145 fail: 13
Failed builds:
	m68k:defconfig
	m68k:allmodconfig
	m68k:sun3_defconfig
	mips:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	powerpc:allmodconfig
	powerpc:ppc32_allmodconfig
	s390:defconfig
	s390:allmodconfig
	s390:debug_defconfig
	sparc64:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 555 pass: 522 fail: 33
Failed tests:
	<all arm64be>
	<all m68k:q800>
	<all s390>
Unit test results:
	pass: 430107 fail: 1
Failed tests:
	arm:orangepi-pc:vcap_api_iterator_init_test
	arm:orangepi-pc:VCAP_API_Encoding_Testsuite

As far as I can see, all build and qemu test failures are due to the
bcachefs patch that broke big endian builds.

I have not analyzed the vcap unit test failure.

I had to disable a number of kunit tests. Also, there are some new
backtraces. See below for details.

Guenter

---
On mips64, qemu malta machine:

rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=2603 jiffies, g=1077, q=7017 ncpus=1)
rcu: All QSes seen, last rcu_sched kthread activity 2603 (4294942579-4294939976), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_sched kthread starved for 2603 jiffies! g1077 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_sched       state:R  running task     stack:0     pid:14    tgid:14    ppid:2      flags:0x00100000
Stack : 900000000231c498 90000000022f4720 ffffffff813f02f0 90000000032c30a0
        0000000000000000 0000fb5b00000000 ffffffff80f1ea90 0000000000000000
        0000000200000000 00296d890e82bf6f 90000000032c28c0 ffffffff813f0000
        ffffffff813e0000 ffffffff80f20000 0000000000000001 ffffffff81413c98
        ffffffff81410000 0000000000000001 ffffffff81413740 ffffffff80f09158
        ffffffff81410000 00000000ffff9549 ffffffff813e0000 ffffffff80f13128
        0000000000000122 0000000000000000 00000000ffff9549 ffffffff80206c28
        0280000000000000 ffffffff8207bce8 0000000000000000 0000000000000000
        ffffffff81239438 0000000000000000 90000000032c28c0 00296d890e82bf6f
        ffffffff81522748 0000000000000000 ffffffff813e0000 ffffffff813df318
        ...
Call Trace:
[<ffffffff80f08788>] __schedule+0x538/0xeb8
[<ffffffff80f09158>] schedule+0x50/0x1e0
[<ffffffff80f13128>] schedule_timeout+0xc8/0x170
[<ffffffff801e8f50>] rcu_gp_fqs_loop+0x6a0/0xa00
[<ffffffff801ee768>] rcu_gp_kthread+0x1c8/0x378
[<ffffffff8016e3b4>] kthread+0x134/0x160
[<ffffffff80103328>] ret_from_kernel_thread+0x14/0x1c
rcu: Stack dump where RCU GP kthread last ran:

Seen once while running rbtree-default test. Not analyzed.

---
powerpc, with qemu mpc8544ds machine and SMP configurations:

LSM: initializing lsm=lockdown,capability,landlock,yama,loadpin,safesetid,ipe
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/smp.c:807 smp_call_function_many_cond+0x4f4/0x9d0
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc1 #1
Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
NIP:  c017c964 LR: c017ce8c CTR: 00000000
REGS: c267dd40 TRAP: 0700   Not tainted  (6.12.0-rc1)
MSR:  00021000 <CE,ME>  CR: 24004288  XER: 20000000
GPR00: c00225a4 c267de30 c254c5c0 c26924c4 00000000 00000000 00000001 c2690000 
GPR08: 00000000 00000003 c2690000 00000000 84004288 020a6fb8 00000000 00000000 
GPR16: 00000000 00000000 00000000 00000000 c0000000 00000001 00000000 cfffd0c0 
GPR24: c017ce8c c26924c4 c0022544 00000000 00000000 00029000 4bffd2d8 00000000 
NIP [c017c964] smp_call_function_many_cond+0x4f4/0x9d0
LR [c017ce8c] smp_call_function+0x3c/0x58
Call Trace:
[c267de90] [84000282] 0x84000282
[c267dea0] [c00225a4] flush_tlb_kernel_range+0x2c/0x50
[c267deb0] [c0023bb4] patch_mem.constprop.0+0x108/0x1b0
[c267ded0] [c00188ac] arch_static_call_transform+0x10c/0x150
[c267def0] [c2035fa8] security_add_hooks+0x138/0x24c
[c267df20] [c2034dac] capability_init+0x24/0x38
[c267df30] [c20352bc] initialize_lsm+0x48/0x90
[c267df50] [c2035b9c] security_init+0x2e0/0x5b4
[c267dfa0] [c2001154] start_kernel+0x5d4/0x81c
[c267dff0] [c0000478] set_ivor+0x150/0x18c
Code: 91220000 81620004 3d20c209 39293478 556b103a 7c84582e 7c89202e 81220000 2c040000 3929ffff 91220000 40a2fbdc <0fe00000> 4bfffbd4 80e20000 2c070000 
irq event stamp: 1198
hardirqs last  enabled at (1197): [<c11fa128>] _raw_spin_unlock_irqrestore+0x70/0xa8
hardirqs last disabled at (1198): [<c0023bf4>] patch_mem.constprop.0+0x148/0x1b0
softirqs last  enabled at (10): [<c0064c88>] handle_softirqs+0x344/0x500
softirqs last disabled at (3): [<c0006fd8>] do_softirq_own_stack+0x34/0x4c
---[ end trace 0000000000000000 ]---
landlock: Up and running.

I tried to bisect, but did not get anywhere due to build failures and
crashes during the bisect.

---
Overall kunit status in my test bed

- Newly enabled configurations and tests
  Either those are new tests, or a previously observed problem with test
  has been fixed.

  CONFIG_SECURITY_APPARMOR_KUNIT_TEST
  CONFIG_SECURITY_IPE
  CONFIG_SECURITY_IPE_KUNIT_TEST
  CONFIG_PM_QOS_KUNIT_TEST
  CONFIG_EXT4_KUNIT_TESTS
  CONFIG_IIO_GTS_KUNIT_TEST
  
- New, not enabled
  CONFIG_MCTP_SERIAL_TEST
    Crashes in mctp_i2c_get_adapter().

- Partially enabled
  CONFIG_DAMON_KUNIT_TEST
  CONFIG_DAMON_VADDR_KUNIT_TEST
  CONFIG_DAMON_DBGFS_KUNIT_TEST
    Fail with 32-bit configurations and only enabled for 64-bit builds.
  CONFIG_OF_KUNIT_TEST
  CONFIG_OF_OVERLAY_KUNIT_TEST (new)
  CONFIG_CLK_FIXED_RATE_KUNIT_TEST (new)
  CONFIG_CLK_KUNIT_TEST (previously enabled)
    Fail on arm64 when booting through EFI and therefore disabled for
    arm64; still enabled otherwise if COMMON_CLK is enabled.

- Previously enabled, now disabled
  CONFIG_KUNIT_TEST
    Now triggers intentional backtraces.
  CONFIG_TEST_IOV_ITER
    Still enabled everywhere except openrisc, where it crashes.
    Crash is most likely due to an architecture specific problem.
  CONFIG_SLUB_KUNIT_TEST
    Now triggers intentional backtraces, and fails completely when builtin
    and run at boot time because it now needs RCU, but RCU is not yet
    initialized when unit tests are run during boot.
    Patches to fix the problems have been submitted.


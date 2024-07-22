Return-Path: <linux-kernel+bounces-259059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024EF9390A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF824280F46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662C816D4F5;
	Mon, 22 Jul 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZB2hZlDU"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23EB8F6B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658611; cv=none; b=g8W0OA+wrn2Alg5/AWTQTuajYjcxXrl0aAxi3mp5RWaPKQvsWv0NbfiD0VvK9a9PgSJxrCiSer/nRkerUKWczTnaFaKli/nbcJitEeYOZuaPVjbFDcVKowT8F8K0v4EmEwDOLYuyFw+QmyDW6a2LZXvYSBJCnDyYbjMefQ6R1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658611; c=relaxed/simple;
	bh=jc4Vg8pnrmtIFW3yAyOhk5obEdegT8XbOWOdWVUTDMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wj1f8vho5pfPVnwXSx/rTH7SsHNotrHQM5DYWYPIk8ApDpn6DEVhGKGV1xdeiV+0FIWxed1z5ycWAukpuJgdEA3M4bSn8L5UIeI5aEYW3vy/gLMP2h0Qgp5vW6Jlu2dayEILk621uUuO3o4rTPrtjpYrnFjSx50uroaCGRfgvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZB2hZlDU; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49299adf8adso397554137.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721658609; x=1722263409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNQj5L480GiXOYni+r7oo8capetgUsj9Z2Zw/kMU9Lo=;
        b=ZB2hZlDUoJNg8I+OVB2VY7pUrQkYkEK55SzRauZg2rDEIbrv4LJ9VHjHQrerkrNVLc
         Jyez98SmkrvpqT71gKBiRlqxYvFqoRWyfqPiAcpVIwDnC3UM9h9AjYYc15UXIwZJEJxl
         aa6xrrEyvR35u32nOfIWcvzrkj9xujT55diQj7b5Erpj2EcQQW68KjLSuNPPZMScCODO
         swaSjfqgjD+iuyyZGAENbPjZFwwqaFUBuZVjn7L74n6VEjUJLjBpoh+9ScN4UVh/zJaX
         V1j5PKYyEI07GdaPz4v+ls9OYbrz/HzOSvyyxI+0B23KpsgytEJtArvKku1C3FABlEGr
         gpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721658609; x=1722263409;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNQj5L480GiXOYni+r7oo8capetgUsj9Z2Zw/kMU9Lo=;
        b=LdmHfba9xoXHon919PT8MJH/Xg3m/UIq2MjQaXhc528TlHXlTLtSqFHPjNA7xyAuml
         wv28i4OzvQOimPUnjYrJOc3zanNX+C3Lk5sUbQmQm9/61LQA/lT61d+TgvHU21UG98Af
         Ap4zJ8lqfJpolKOcJJByZ2qZcQh8Y4ZbP35IWQ8OAUKm8QdscrTn6ZcW+zGipqtvnr2K
         l+O2LJlx/jArjhCA+M/fzJpatFTSuCWJEKxEkmUKTz4jALaD1VTrO1Iq68s93XenAf+x
         NeurA2AOfjLYutHhLzCZ1942CW6gs/eZl/I+zERPlymOOVWrY2xMegQKGiUACZgdO91N
         556Q==
X-Gm-Message-State: AOJu0YzZWE7O3rj9c5x3UeXJfwNqWfJA/cf9FA/MUvUC0T4J9EbD55Gm
	P1C8cDommqaZiS3yMYaDS7CFaKy/MT53iQwBMkc4YaYQozNUtft3X4/GFLCmjHD4kkeP7WTrkLG
	feT7NCjCf6KZXaVpEWUPP+Pe2Q+t51ftRJY/Ul0Ogn4O6ur3j5qN3dw==
X-Google-Smtp-Source: AGHT+IFus2Eig2CcvD+a8Ar+gdFVn560QbNbPQwuRz7NrBNpKGVdfa/jGlZ7xniv7mXXNeI9EWiqcwMovH8pwOaAJrA=
X-Received: by 2002:a05:6102:36cd:b0:48f:eb37:fd86 with SMTP id
 ada2fe7eead31-4928ba881damr4622730137.30.1721658608416; Mon, 22 Jul 2024
 07:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 22 Jul 2024 19:59:56 +0530
Message-ID: <CA+G9fYsdQ58YL96Kv7dY1nb5Ok3=o7L68JdpOH4yZJ_3nAdExw@mail.gmail.com>
Subject: WARNING: at kernel/time/timer_migration.c:1714 tmigr_cpu_prepare
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following boot warnings noticed on all the devices running today's
Linux next-20240722 tag. The system is stable and booted to console.

First seen on next-20240722.

  GOOD: next-20240719
  BAD: next-20240722

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot log:
-----------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
[    0.000000] Linux version 6.10.0-next-20240722 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT @1721630963
[    0.000000] KASLR enabled
[    0.000000] Machine model: Thundercomm Dragonboard 845c
...
[    0.007393] rcu: Max phase no-delay instances is 1000.
[    0.007773] Timer migration: 1 hierarchy levels; 8 children per
group; 1 crossnode level
[    0.007823] ------------[ cut here ]------------
[    0.007833] WARNING: CPU: 0 PID: 1 at
kernel/time/timer_migration.c:1714 tmigr_cpu_prepare
(kernel/time/timer_migration.c:1714 (discriminator 1))
[    0.007858] Modules linked in:
[    0.007870] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.10.0-next-20240722 #1
[    0.007878] Hardware name: Thundercomm Dragonboard 845c (DT)
[    0.007883] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.007890] pc : tmigr_cpu_prepare
(kernel/time/timer_migration.c:1714 (discriminator 1))
[    0.007896] lr : cpuhp_invoke_callback (kernel/cpu.c:194)
[    0.007907] sp : ffff80008005bb20
[    0.007910] x29: ffff80008005bbb0 x28: ffffa8983a9defd0 x27: ffff422c792f74f8
[    0.007920] x26: ffff99943f4ea000 x25: ffff422c792f2c68 x24: ffffa8983a9e35c0
[    0.007928] x23: ffffa898379aa798 x22: 0000000000000000 x21: ffffa89839e08c68
[    0.007936] x20: ffffa89839e0d000 x19: 0000000000000000 x18: 0000000000000006
[    0.007943] x17: 6f72632031203b70 x16: 756f726720726570 x15: 0720072007200720
[    0.007951] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[    0.007959] x11: 0720072007200720 x10: ffffa8983aa5df30 x9 : ffffa898378b2a88
[    0.007967] x8 : 00000000ffffefff x7 : ffffa8983aa5df30 x6 : 0000000000000001
[    0.007975] x5 : 0000000000000000 x4 : ffffa89839e0d4f8 x3 : ffff99943f4ea000
[    0.007982] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffa89839e0d4f8
[    0.007990] Call trace:
[    0.007993] tmigr_cpu_prepare (kernel/time/timer_migration.c:1714
(discriminator 1))
[    0.007998] cpuhp_invoke_callback (kernel/cpu.c:194)
[    0.008004] cpuhp_issue_call (kernel/cpu.c:2359 kernel/cpu.c:2339)
[    0.008011] __cpuhp_setup_state_cpuslocked (kernel/cpu.c:2505)
[    0.008021] __cpuhp_setup_state (kernel/cpu.c:2534)
[    0.008027] tmigr_init (include/linux/cpuhotplug.h:277
kernel/time/timer_migration.c:1794)
[    0.008040] do_one_initcall (init/main.c:1267)
[    0.008049] kernel_init_freeable (init/main.c:1372 (discriminator
1) init/main.c:1567 (discriminator 1))
[    0.008057] kernel_init (init/main.c:1471)
[    0.008068] ret_from_fork (arch/arm64/kernel/entry.S:861)
[    0.008076] ---[ end trace 0000000000000000 ]---


metadata:
-----
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jagYnqJwwRb1upwVgqd6h6cQoU/
  build-url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jagYnqJwwRb1upwVgqd6h6cQoU/
  build_name: gcc-13-lkftconfig-debug
  git_describe: next-20240722
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: dee7f101b64219f512bb2f842227bd04c14efe30
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jagYnqJwwRb1upwVgqd6h6cQoU/config
  toolchain: gcc-13

Steps to reproduce:
-------
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2jagaCWDNIYL1r8qprPP81YQdaF/reproducer


Full dmesg link:
--------
 - https://lkft.validation.linaro.org/scheduler/job/7753578#L5022
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240722/testrun/24669141/suite/log-parser-boot/test/check-kernel-exception-a189d92b895bd0de96c24e2d262e9caa627c25600bb7fda7c5894f2ce03ebb57/log

--
Linaro LKFT
https://lkft.linaro.org


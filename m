Return-Path: <linux-kernel+bounces-423643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78F9DAAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78350281C73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968040BF2;
	Wed, 27 Nov 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u4WGNtYQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340961BC20
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721457; cv=none; b=IhBd41zkjOq5ySRDAKszXpiviPVOeX+B7KActBDmXMJOdfZOHcpglCAkxwe7BI9TLHQdFKgcjOE//iYdsqgTte/U1pvEVhgtk5t7JX4TbUGDFbu7WASZpndM2w9nKrX9h4ROsOoNtAPyH/hPs6S51BqVWB9mMoYpWWClkhqpXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721457; c=relaxed/simple;
	bh=F9xK8XdaOJCyVB6n4l8OakCGLAOW8KoLYb6LmUwOCK8=;
	h=Date:Subject:CC:From:To:Message-ID; b=rxdiMRmBcVYiWk4zGwKUZuPKQKfiYr2Ix4eu2zbekosBWgTZAZbEDk9WN1ZgtioiUBinYapeT/bfYnbETx9WRW6XDqW2WUaqLe1xvDHmb9jAyRm0Rf8imQ5TXw+X2zFvvkxkn9ZA1lJusWkG6+u66w8bHgJjXzGM6+ey3ufTK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u4WGNtYQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21207f0d949so66287405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732721454; x=1733326254; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbxIRZel9T5dkqcntCDk2OqqDHeP3vTzFbFWVMrRR0k=;
        b=u4WGNtYQO5tNHs9NqjGxVIhedAZHSLJqevY6sEg+qxrHDCYS4qZgkZvPN358kxxD6Q
         8CZI/sUzPaodg4t8wd6on/9FBs4jKUdHDrJCIrle8h4I9g79KotNJPr9YS5Ip/q/NFaW
         IiiThSWmUzfjjC2iIh0c9MHSC9jYVnSZcNm7VizuZhnV1wzP0ti+cLArZZXbzCtm25hJ
         UXANWhNHzJQP1iNkAk2fvR+8eqi530WM1ZXOnqSZ/2l0lNOzu9Ce1wr4k02q6c6oU2aW
         tVgRREyQ24wWUAz0o63vAQBrpSwSkriATpv50vtTPRKaStjly5mLxEBbS332r1f/p6Mo
         q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732721454; x=1733326254;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbxIRZel9T5dkqcntCDk2OqqDHeP3vTzFbFWVMrRR0k=;
        b=Qg9opwgRq5p2fq5OqKwnHxMVJPonZcm3qBQBsw31PM4i1tOIqaHru1fqIeEtj++azv
         c4Vv+/oPVtMcI0z+0ppnZXfsEkESEg93ff2hM+F5MEeT9X9Kalwm40FgjPGkDFlbierg
         HirgrxxCx+FWdo1y4R0JVix4MuMTk0O4W28TPXxFd0BIYrTTYV1bY9E4XA3KPaT0yaHe
         2Jr84NLoa0z/CjezfGDK59/UUPM6Zf3MzlHUh+1yDinoowmYK0n2eJkN5uUQsvFENDZ2
         uqpVZqVMiGpGneYrEVY9bjvBAUEZjuM2SRn8IxaW+zHRXgKMejJs2TY4D/UAjj53hJJR
         LfTw==
X-Forwarded-Encrypted: i=1; AJvYcCW9dH7AaaR1vEAuEqhrnzCCOk6Ni6Gwlz4q0lVWm+B3jhFnOlAfwWQocVE81GwzhT1ojAC/iuwbQvqL+pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZzc/xkwTUGeZrRs9gji2nBLOUpXJN+iaXQNMtxj9nW7npE83
	kqp3SFLkjP/+WasklXk7gvp/qpfRAN9y6mDtT6sLB/gQbizziCpSziQOAOH4tPI=
X-Gm-Gg: ASbGncsh0KbtEBqQBd2t9mTRUC6IzQkO/6b2VI1EJ50nJaLF2etCG/pz0XzmEk8iSWt
	vtEUNBHRQRNTNpn8ShekQUzFhG4YpYaAuCxTC1uzpoco5WTrHbQiZ+PjaHzQk09E9lJoT/S2iAw
	0ePt2wfP3Qhh6UwWCagqxWo1e97HDn5zTbLBbUwDqv3wHmEY1OyeHK002Iw7/MzkxnsuzpNpImA
	2BAAUuf3zJ1mkXhq4HP0e9QJAJWNOcdLi3FfK6RvAaTT3gX
X-Google-Smtp-Source: AGHT+IEKS5ruBNsykjv4PxtNLKybCyk+nwPxsnSoJG0AQq9IJovlSaXdZw4IhgtETh8O+QYsxFfo1w==
X-Received: by 2002:a17:903:22c2:b0:211:f335:ac8 with SMTP id d9443c01a7336-21501385201mr36815565ad.29.1732721454111;
        Wed, 27 Nov 2024 07:30:54 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c7aesm104109355ad.55.2024.11.27.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:30:53 -0800 (PST)
Date: Wed, 27 Nov 2024 07:30:53 -0800 (PST)
X-Google-Original-Date: Wed, 27 Nov 2024 07:21:06 PST (-0800)
Subject: [GIT PULL] RISC-V Paches for the 6.13 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-5c0ea89d-908b-4009-ba23-e4fac45618b4@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.13-mw1

for you to fetch changes up to 8d4f1e05ff821a5d59116ab8c3a30fcae81d8597:

  RISC-V: Remove unnecessary include from compat.h (2024-11-26 11:48:53 -0800)

----------------------------------------------------------------
RISC-V Paches for the 6.13 Merge Window, Part 1

* Support for pointer masking in userspace,
* Support for probing vector misaligned access performance.
* Support for qspinlock on systems with Zacas and Zabha.

----------------------------------------------------------------
There's a handful of fixes working through other trees (the wait/wound lockdep
failures and a tools build fix), but aside from those everything is clean on my
end.  I don't plan on having a part 2, unless there's something else in flight
that blows up.

----------------------------------------------------------------
Alexandre Ghiti (12):
      riscv: Check that vdso does not contain any dynamic relocations
      riscv: Move cpufeature.h macros into their own header
      riscv: Do not fail to build on byte/halfword operations with Zawrs
      riscv: Implement cmpxchg32/64() using Zacas
      dt-bindings: riscv: Add Zabha ISA extension description
      riscv: Implement cmpxchg8/16() using Zabha
      riscv: Improve zacas fully-ordered cmpxchg()
      riscv: Implement arch_cmpxchg128() using Zacas
      riscv: Implement xchg8/16() using Zabha
      riscv: Add ISA extension parsing for Ziccrse
      dt-bindings: riscv: Add Ziccrse ISA extension description
      riscv: Add qspinlock support

Charlie Jenkins (1):
      riscv: Fix default misaligned access trap

Drew Fustini (1):
      riscv: defconfig: enable gpio support for TH1520

Guo Ren (2):
      asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
      asm-generic: ticket-lock: Add separate ticket-lock.h

Jesse Taube (6):
      RISC-V: Check scalar unaligned access on all CPUs
      RISC-V: Scalar unaligned access emulated on hotplug CPUs
      RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
      RISC-V: Detect unaligned vector accesses supported
      RISC-V: Report vector unaligned access speed hwprobe
      RISC-V: hwprobe: Document unaligned vector perf key

Nick Hu (2):
      cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
      cpuidle: riscv-sbi: Add cpuidle_disabled() check

Palmer Dabbelt (7):
      Merge patch series "riscv: Per-thread envcfg CSR support"
      Merge patch series "cpuidle: riscv-sbi: Allow cpuidle pd used by other devices"
      Merge patch series "RISC-V: Detect and report speed of unaligned vector accesses"
      Merge patch series "Prevent dynamic relocations in vDSO"
      Merge patch series "riscv: Userspace pointer masking and tagged address ABI"
      Merge patch series "Zacas/Zabha support and qspinlocks"
      RISC-V: Remove unnecessary include from compat.h

Samuel Holland (13):
      riscv: Enable cbo.zero only when all harts support Zicboz
      riscv: Add support for per-thread envcfg CSR values
      riscv: Call riscv_user_isa_enable() only on the boot hart
      dt-bindings: riscv: Add pointer masking ISA extensions
      riscv: Add ISA extension parsing for pointer masking
      riscv: Add CSR definitions for pointer masking
      riscv: Add support for userspace pointer masking
      riscv: Add support for the tagged address ABI
      riscv: Allow ptrace control of the tagged address ABI
      riscv: selftests: Add a pointer masking test
      riscv: hwprobe: Export the Supm ISA extension
      RISC-V: KVM: Allow Smnpm and Ssnpm extensions for guests
      KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test

 Documentation/arch/riscv/hwprobe.rst               |  19 ++
 Documentation/arch/riscv/uabi.rst                  |  16 +
 .../devicetree/bindings/riscv/extensions.yaml      |  30 ++
 .../locking/queued-spinlocks/arch-support.txt      |   2 +-
 arch/riscv/Kconfig                                 | 138 ++++++++-
 arch/riscv/Makefile                                |   6 +
 arch/riscv/configs/defconfig                       |   1 +
 arch/riscv/include/asm/Kbuild                      |   4 +-
 arch/riscv/include/asm/cmpxchg.h                   | 286 +++++++++++++-----
 arch/riscv/include/asm/compat.h                    |   1 -
 arch/riscv/include/asm/cpufeature-macros.h         |  66 ++++
 arch/riscv/include/asm/cpufeature.h                |  73 +----
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   1 +
 arch/riscv/include/asm/hwcap.h                     |   7 +
 arch/riscv/include/asm/hwprobe.h                   |   2 +-
 arch/riscv/include/asm/mmu.h                       |   7 +
 arch/riscv/include/asm/mmu_context.h               |  13 +
 arch/riscv/include/asm/processor.h                 |   9 +
 arch/riscv/include/asm/spinlock.h                  |  47 +++
 arch/riscv/include/asm/switch_to.h                 |  19 ++
 arch/riscv/include/asm/uaccess.h                   |  43 ++-
 arch/riscv/include/asm/vector.h                    |   2 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   6 +
 arch/riscv/include/uapi/asm/kvm.h                  |   2 +
 arch/riscv/kernel/Makefile                         |   3 +-
 arch/riscv/kernel/copy-unaligned.h                 |   5 +
 arch/riscv/kernel/cpufeature.c                     |  16 +-
 arch/riscv/kernel/fpu.S                            |   4 +-
 arch/riscv/kernel/process.c                        | 154 ++++++++++
 arch/riscv/kernel/ptrace.c                         |  42 +++
 arch/riscv/kernel/setup.c                          |  37 +++
 arch/riscv/kernel/smpboot.c                        |   2 -
 arch/riscv/kernel/suspend.c                        |   4 +-
 arch/riscv/kernel/sys_hwprobe.c                    |  44 +++
 arch/riscv/kernel/traps_misaligned.c               | 139 ++++++++-
 arch/riscv/kernel/unaligned_access_speed.c         | 156 +++++++++-
 arch/riscv/kernel/vdso/Makefile                    |  10 +-
 arch/riscv/kernel/vec-copy-unaligned.S             |  58 ++++
 arch/riscv/kernel/vector.c                         |   2 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   4 +
 drivers/cpuidle/cpuidle-riscv-sbi.c                |  11 +-
 include/asm-generic/qspinlock.h                    |   2 +
 include/asm-generic/spinlock.h                     |  87 +-----
 include/asm-generic/spinlock_types.h               |  12 +-
 include/asm-generic/ticket_spinlock.h              | 105 +++++++
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |   5 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |   8 +
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore       |   1 +
 tools/testing/selftests/riscv/abi/Makefile         |  10 +
 .../testing/selftests/riscv/abi/pointer_masking.c  | 332 +++++++++++++++++++++
 53 files changed, 1790 insertions(+), 282 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature-macros.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S
 create mode 100644 include/asm-generic/ticket_spinlock.h
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/pointer_masking.c


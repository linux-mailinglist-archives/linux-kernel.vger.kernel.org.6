Return-Path: <linux-kernel+bounces-186482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C88CC4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A428050A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0541257CA6;
	Wed, 22 May 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZNpa84gf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41B1F17B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394414; cv=none; b=RM2qGjuQKA9l2H5WGRHKbCSaYFcaT4MxB4+fqTrHpVHpzYYYs76lOaCMRn9afLfPvY591itVJTYwiYRM96SwoJABfXRsWKUBcY6+uhV39RAkBDpG7mvSBI0XvQjsesDfFd9K1uu/FCi6N2FMsntGmdaMeInMpISky0kracaVhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394414; c=relaxed/simple;
	bh=58ockLmgsrUZMMZrH6nylZdylj4gAMkL3TV8TbAU9J8=;
	h=Date:Subject:CC:From:To:Message-ID; b=t6J9jFZs8g1z7IBgc6eCsBeaQAq1aUvL7puzLUSQthm1Q1KNo0rMurYdEyaohQR/istUsvgbWZEV3lhP6iAPYp9Gk7eNwuTrLR4EuJgQL5ioZ9GyxPK8S3au/LlYvJcwLQF1fHfjztsVHBIj1h1LfXsl6s09UZXZROQ+WQrni0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZNpa84gf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-628a551d10cso2162404a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716394410; x=1716999210; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvJV5ZGsuu7yjPkuizDv1ykHrklgDvGswJrEOm3kD5A=;
        b=ZNpa84gfZUsj4/tasahwaOIhjjs5ubA9uUcH7Erw+aMCZmH7U4aXj8mPSq4Sjvc7y+
         ikz4pffKo2zsP6ReZpQWfoZGrGtWPIV4ZW+PxVCE12SlcmmQnP8GUU4ZESJmgFdWL/c/
         XmIHa3M2+1QRRndF9DvUQ+Rem/sCWd4f2BNBfjDWGGKi4wZ6wk/vB5PHG2FQ/gayYCMU
         gIY6imgMn/tBhzpHxj+yfxn4U3VuN+vqN1yPXn2JzUjYHOjUP/GtnmUfipz4lOFe/bsI
         vS8H8ezeaHsEc+c+xialJoFB07mClf+iQHi2LHE1BBuZdEEIU0V9NKeqqkee0RYrNUq4
         jr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716394410; x=1716999210;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvJV5ZGsuu7yjPkuizDv1ykHrklgDvGswJrEOm3kD5A=;
        b=kt7MZpV8ChLDve+vuEVJ4/AKiRjzcfwZ3Vs1tjV2jbTd9fDXELujqffq0zQnJI14Rx
         q79AbLKJVwVe3xj9wfm3eTSihsE5npGv/nV4j3zoUsj31RXaDMMREHkK13fCI08rle1g
         qRiCAxegywx+1qYeaGUvrRwCTlN6PaOSklk/pNcqtbC6k8fKpj4rt+hQAcPmaafwkV5a
         N3gIQUc+YcqH9hw0pW5pvtOvzCSLeeg+VUK/mgyzdlDiQuh3zpT8j9+rhTuJCuuVchQy
         jc3pMsj56uB6eY9sWEysMclzEnw7cKmC+GvP8Uw0Wmk/PmFqnofKRnlfKhPZ8jfmV4yi
         yIWg==
X-Forwarded-Encrypted: i=1; AJvYcCWvLw50EIc/9pbckmgXDB/WPLCDpV8TrHhn2QrWkKKEldhztK5otyc8su/GTgxFUdp0H3QRWiE93CYxfB202vcKYPoPr35KNWTUwEtR
X-Gm-Message-State: AOJu0Yx0siIhJtB96DWyCHyaYK+3zaUMGdVe1zqXr4UkjbWXG1cVQj/z
	P16m/1gIqTLkkoucOu/go8m9k+dcsM7ui/pSuo48NzQJ3u721vuRECq3zeXiHgQGNvY8SdjolL/
	S
X-Google-Smtp-Source: AGHT+IGIo1wZlSPwwSu9xw5c4I51qpXk7ZOigKsyxWm6T8IDrvSKigUlmUGe9S6Z4XUSv7E8Tg4RbA==
X-Received: by 2002:a17:90a:5385:b0:2bd:9648:1fe with SMTP id 98e67ed59e1d1-2bd9f344e7cmr2642563a91.7.1716394409942;
        Wed, 22 May 2024 09:13:29 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd9099a4afsm3665730a91.8.2024.05.22.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:13:28 -0700 (PDT)
Date: Wed, 22 May 2024 09:13:28 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2024 09:13:24 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e73e59bf-92fc-4122-9f9e-a329d20eba55@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw1

for you to fetch changes up to 92cce91949a497a8a4615f9ba5813b03f7a1f1d5:

  riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800 (2024-05-13 14:26:34 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.10 Merge Window, Part 1

* Support for byte/half-word compare-and-exchange, emulated via LR/SC
  loops.
* Support for Rust.
* Support for Zihintpause in hwprobe.
* Support for the PR_RISCV_SET_ICACHE_FLUSH_CTX prctl().
* Support for lockless lockrefs.

----------------------------------------------------------------
This was really meant to be last week's PR, but due to a handful of small
issues.  There's a pair of driver build fixes that are already on the lists and
a report of a ftrace failure that might be triggered by the ftrace/AIA fix, but
seems like we're better off with these than without.  I've got a few other
smaller things queued up for Friday, but I figured it'd be best to get this
moving because there's a handful of merge conflicts.

This first one isn't showing up in a in-flight merge `git diff`, but it looks
pretty straight-forward

    diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
    index c9137710633a..4d1495ded2aa 100644
    --- a/Documentation/rust/arch-support.rst
    +++ b/Documentation/rust/arch-support.rst
    @@ -16,7 +16,8 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
     Architecture   Level of support  Constraints
     =============  ================  ==============================================
     ``arm64``      Maintained        Little Endian only.
    -``loongarch``  Maintained        \-
    +``loongarch``  Maintained        -
    +``riscv``      Maintained        ``riscv64`` only.
     ``um``         Maintained        ``x86_64`` only.
     ``x86``        Maintained        ``x86_64`` only.
     =============  ================  ==============================================

There's also one in the IMSIC driver where there's really no way for git to
pick up the conflict, as it's a far-away API change.  Here's my resolution,
Anup likes it as well
<https://lore.kernel.org/all/CAK9=C2UkTD0hYymjow-yHHfBDh4CtRv-G2BPt=ncstLRmpYgyg@mail.gmail.com/>:

    diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
    index 886418ec06cb..4fbb37074d29 100644
    --- a/drivers/irqchip/irq-riscv-imsic-early.c
    +++ b/drivers/irqchip/irq-riscv-imsic-early.c
    @@ -49,7 +49,7 @@ static int __init imsic_ipi_domain_init(void)
     		return virq < 0 ? virq : -ENOMEM;
     
     	/* Set vIRQ range */
    -	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
    +	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI);
     
     	/* Announce that IMSIC is providing IPIs */
     	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);

The rest show up pretty normally, so here's the regular merge diff output from
how I've resolved them:

    diff --cc arch/riscv/Makefile
    index 1e002d8003c5,321c057e2bdc..000000000000
    --- a/arch/riscv/Makefile
    +++ b/arch/riscv/Makefile
    @@@ -151,20 -166,9 +166,9 @@@ endi
      endif
      
      vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
     -vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
     +vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
      
    - ifneq ($(CONFIG_XIP_KERNEL),y)
    - ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
    - KBUILD_IMAGE := $(boot)/loader.bin
    - else
    - ifeq ($(CONFIG_EFI_ZBOOT),)
    - KBUILD_IMAGE := $(boot)/Image.gz
    - else
    - KBUILD_IMAGE := $(boot)/vmlinuz.efi
    - endif
    - endif
    - endif
    - BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
    + BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
      
      all:	$(notdir $(KBUILD_IMAGE))
      
    diff --cc include/uapi/linux/prctl.h
    index 713d28788df7,524d546d697b..000000000000
    --- a/include/uapi/linux/prctl.h
    +++ b/include/uapi/linux/prctl.h
    @@@ -306,20 -306,10 +306,26 @@@ struct prctl_mm_map 
      # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
      # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
      
    + #define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
    + # define PR_RISCV_CTX_SW_FENCEI_ON	0
    + # define PR_RISCV_CTX_SW_FENCEI_OFF	1
    + # define PR_RISCV_SCOPE_PER_PROCESS	0
    + # define PR_RISCV_SCOPE_PER_THREAD	1
    + 
     +/* PowerPC Dynamic Execution Control Register (DEXCR) controls */
     +#define PR_PPC_GET_DEXCR		72
     +#define PR_PPC_SET_DEXCR		73
     +/* DEXCR aspect to act on */
     +# define PR_PPC_DEXCR_SBHE		0 /* Speculative branch hint enable */
     +# define PR_PPC_DEXCR_IBRTPD		1 /* Indirect branch recurrent target prediction disable */
     +# define PR_PPC_DEXCR_SRAPD		2 /* Subroutine return address prediction disable */
     +# define PR_PPC_DEXCR_NPHIE		3 /* Non-privileged hash instruction enable */
     +/* Action to apply / return */
     +# define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1 /* Aspect can be modified with PR_PPC_SET_DEXCR */
     +# define PR_PPC_DEXCR_CTRL_SET		 0x2 /* Set the aspect for this process */
     +# define PR_PPC_DEXCR_CTRL_CLEAR	 0x4 /* Clear the aspect for this process */
     +# define PR_PPC_DEXCR_CTRL_SET_ONEXEC	 0x8 /* Set the aspect on exec */
     +# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
     +# define PR_PPC_DEXCR_CTRL_MASK		0x1f
     +
      #endif /* _LINUX_PRCTL_H */
    diff --cc kernel/sys.c
    index f9c95410278c,1b7bda0722ca..000000000000
    --- a/kernel/sys.c
    +++ b/kernel/sys.c
    @@@ -146,13 -146,10 +146,15 @@@
      #ifndef RISCV_V_GET_CONTROL
      # define RISCV_V_GET_CONTROL()		(-EINVAL)
      #endif
    + #ifndef RISCV_SET_ICACHE_FLUSH_CTX
    + # define RISCV_SET_ICACHE_FLUSH_CTX(a, b)	(-EINVAL)
    + #endif
     -
     +#ifndef PPC_GET_DEXCR_ASPECT
     +# define PPC_GET_DEXCR_ASPECT(a, b)	(-EINVAL)
     +#endif
     +#ifndef PPC_SET_DEXCR_ASPECT
     +# define PPC_SET_DEXCR_ASPECT(a, b, c)	(-EINVAL)
     +#endif
    - 
      /*
       * this is where the system-wide overflow UID and GID are defined, for
       * architectures that now have 32-bit UID/GID but didn't in the past


----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Remove superfluous smp_mb()
      riscv: Fix text patching when IPI are used

Charlie Jenkins (4):
      riscv: Remove unnecessary irqflags processor.h include
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
      cpumask: Add assign cpu

Clément Léger (2):
      riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code
      riscv: hwprobe: export Zihintpause ISA extension

Dawei Li (2):
      riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
      riscv: Annotate pgtable_l{4,5}_enabled with __ro_after_init

Inochi Amaoto (1):
      riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800

Jisheng Zhang (4):
      riscv: select ARCH_USE_CMPXCHG_LOCKREF
      riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}
      riscv: mm: still create swiotlb buffer for kmalloc() bouncing if required
      riscv: select ARCH_HAS_FAST_MULTIPLIER

Leonardo Bras (5):
      riscv/cmpxchg: Deduplicate xchg() asm functions
      riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
      riscv/atomic.h : Deduplicate arch_atomic.*
      riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
      riscv/cmpxchg: Implement xchg for variables of size 1 and 2

Masahiro Yamada (2):
      riscv: merge two if-blocks for KBUILD_IMAGE
      export.h: remove include/asm-generic/export.h

Miguel Ojeda (1):
      RISC-V: enable building 64-bit kernels with rust support

Palmer Dabbelt (6):
      Merge patch series "Rework & improve riscv cmpxchg.h and atomic.h"
      Merge patch series "riscv: 64-bit NOMMU fixes and enhancements"
      Merge patch series "riscv: fix patching with IPI"
      Merge patch series "riscv: Create and document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl"
      Merge patch series "riscv: enable lockless lockref implementation"
      Merge patch series "riscv: ASID-related and UP-related TLB flush enhancements"

Samuel Holland (18):
      riscv: Fix TASK_SIZE on 64-bit NOMMU
      riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
      riscv: Remove MMU dependency from Zbb and Zicboz
      riscv: Allow NOMMU kernels to run in S-mode
      riscv: Do not save the scratch CSR during suspend
      riscv: Flush the instruction cache during SMP bringup
      riscv: Factor out page table TLB synchronization
      riscv: Use IPIs for remote cache/TLB flushes by default
      riscv: mm: Broadcast kernel TLB flushes only when needed
      riscv: Only send remote fences when some other CPU is online
      riscv: mm: Combine the SMP and UP TLB flush code
      riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
      riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
      riscv: mm: Introduce cntx2asid/cntx2version helper macros
      riscv: mm: Use a fixed layout for the MM context ID
      riscv: mm: Make asid_bits a local variable
      riscv: mm: Preserve global TLB entries when switching contexts
      riscv: mm: Always use an ASID to flush mm contexts

Stafford Horne (1):
      riscv: Remove unused asm/signal.h file

Tanzir Hasan (1):
      riscv: remove unused header

Yangyu Chen (1):
      RISC-V: only flush icache when it has VM_EXEC set

 Documentation/arch/riscv/cmodx.rst    |  98 ++++++++
 Documentation/arch/riscv/hwprobe.rst  |   4 +
 Documentation/arch/riscv/index.rst    |   1 +
 Documentation/rust/arch-support.rst   |   1 +
 arch/riscv/Kconfig                    |  22 +-
 arch/riscv/Makefile                   |  26 ++-
 arch/riscv/configs/defconfig          |   1 +
 arch/riscv/errata/sifive/errata.c     |   5 +
 arch/riscv/include/asm/atomic.h       | 164 ++++++-------
 arch/riscv/include/asm/cache.h        |   2 +-
 arch/riscv/include/asm/cacheflush.h   |   7 +-
 arch/riscv/include/asm/cmpxchg.h      | 422 ++++++++++++----------------------
 arch/riscv/include/asm/errata_list.h  |  12 +-
 arch/riscv/include/asm/irqflags.h     |   1 -
 arch/riscv/include/asm/mmu.h          |   5 +
 arch/riscv/include/asm/page.h         |   2 +-
 arch/riscv/include/asm/patch.h        |   1 +
 arch/riscv/include/asm/pgalloc.h      |  32 ++-
 arch/riscv/include/asm/pgtable.h      |   2 +-
 arch/riscv/include/asm/processor.h    |  10 +
 arch/riscv/include/asm/sbi.h          |   4 +
 arch/riscv/include/asm/signal.h       |  12 -
 arch/riscv/include/asm/smp.h          |  15 +-
 arch/riscv/include/asm/suspend.h      |   1 -
 arch/riscv/include/asm/switch_to.h    |  23 ++
 arch/riscv/include/asm/tlbflush.h     |  52 ++---
 arch/riscv/include/uapi/asm/hwprobe.h |   1 +
 arch/riscv/kernel/ftrace.c            |  44 +++-
 arch/riscv/kernel/patch.c             |  17 +-
 arch/riscv/kernel/sbi-ipi.c           |  11 +-
 arch/riscv/kernel/smp.c               |  11 +-
 arch/riscv/kernel/smpboot.c           |   7 +-
 arch/riscv/kernel/suspend.c           |   3 +-
 arch/riscv/kernel/sys_hwprobe.c       |   1 +
 arch/riscv/kernel/sys_riscv.c         |   1 -
 arch/riscv/kernel/traps_misaligned.c  | 106 ++-------
 arch/riscv/mm/Makefile                |   5 +-
 arch/riscv/mm/cacheflush.c            | 120 +++++++++-
 arch/riscv/mm/context.c               |  42 ++--
 arch/riscv/mm/init.c                  |  22 +-
 arch/riscv/mm/tlbflush.c              |  75 ++----
 drivers/clocksource/timer-clint.c     |   2 +-
 include/asm-generic/export.h          |  11 -
 include/linux/cpumask.h               |  16 ++
 include/uapi/linux/prctl.h            |   6 +
 kernel/sys.c                          |   6 +
 scripts/generate_rust_target.rs       |   6 +
 47 files changed, 757 insertions(+), 681 deletions(-)
 create mode 100644 Documentation/arch/riscv/cmodx.rst
 delete mode 100644 arch/riscv/include/asm/signal.h
 delete mode 100644 include/asm-generic/export.h


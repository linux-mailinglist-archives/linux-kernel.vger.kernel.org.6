Return-Path: <linux-kernel+bounces-337297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB9984855
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F511C213B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFA21AB6C6;
	Tue, 24 Sep 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QZRyYLEQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5E1A4F30
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190862; cv=none; b=SH52V3dJJeLANPHyRffjkA48CCzjuntBEWdkKVoASR6Aes5lp99UYahruIYa/2dSFQCCTAO/A34iLWi/AiokPxIH5SRsl4duDhGOCywnrwP/EGM0rO3irk5RpgiD1+9hLkvsxKutKItLYjWtqrSI4Z0SwGQFGp2mEhikmx2VTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190862; c=relaxed/simple;
	bh=YEuEwlRqnVtUuAGRkFHW/54j8/ZQLc1vlF91A6oX/Jk=;
	h=Date:Subject:CC:From:To:Message-ID; b=tAZogDJrr/W1cazNtp+ilMxB92NABhaEKVOpBduTob/nkr2aSdCNosP7asmY0OOjRC9jLbKtl10alrUNQX/SL1Wr9cCI+TW/aG/iCbJvBd0yJQQDocCh7arT/ymoIKFJXnXxhi+op1tl1ItUP3qF28LQvvNzLoYomtO15DgVc90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QZRyYLEQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053616fa36so68787645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727190858; x=1727795658; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4l+X1VCUBncHtX8uzN7Cxn1jx5yxi3wDCVKx4RZGZw=;
        b=QZRyYLEQoe0NQx6CLSFWMOV7sWTm12HKG+II6g9fPk4j1RbhCeVwU6+IukD7NIpPg3
         ItEoCI9JCiPobZfJy7vdM9XHzqO0rr37mVncalvOvtO0n0USlEPmWnFSTh2CecNM4o6F
         vydXO8NpmNTeaS0rnXh4RYs59/3VJSZWpbcog4oQI+fTGLvaZWCqCqY02S3s6hen4WBJ
         WP8GRy6O92NoPt4oClk82VY2TmZpYnMEAiGjps0x6ymzm4V257llnAh6Rbn0DVdzbpxe
         pcpGXZgniJlIrQ8EAjcf/TbAkW0tyWJOyNYn8Oha1XpLD9pK2rAFYdQqZDUHmWG6722P
         ZNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190858; x=1727795658;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4l+X1VCUBncHtX8uzN7Cxn1jx5yxi3wDCVKx4RZGZw=;
        b=YGZPuQduWhurVvVhOMZEqFkWjAuuLmrsAZHReDxtHOqOngv2tWgU6HwPxYn4yjQbs2
         Ej1pMk2lv6DH5PiER2LLyxPw3W2Mw3y5v6hB2iqOe7l+uRJnOofDKwgQlxRuWHS0dEGn
         lXMSF27UKgDfIFWyMuvvCuid3hYy6fQpeaBNEa/pzlQanO3DrXp8WwZ7+kw8vIaWYd79
         FRwomZ7yNFPNaGHHajAvNRT/cbHwf0JAV55ceNP39TtxGu+UNVLRj7pkvrVI0ZoAt6d2
         rsYvnOgwMYq4vcvuYCv3kO8NhpxyxC+zhz3vGJXYN/zxB9nDS9HoA/wez8FC5LBIA2Ga
         GzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQoC4mutXrlo/tzKcM0YLE+s7ua4+EVeQT/x1SRzGci8mcRhGjE4ZzYOR0LUp376oN/QssE/IfEPGthhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHlzLLD89tVwBUP6AZOJLs5c3Mk9xAMN8SyVV5xKYlrlnFwHD
	HUXudi39OTUHkW8C7oD6Ko0gWAalBl4e2vIw7Sq1LUP5Wfhn3tVe5HCfSmDzjZPCtI/PuAzD3ft
	XLUk=
X-Google-Smtp-Source: AGHT+IE/WYEdpLh4pu0dqCMPDAARpCPpEI0SeDzovukW3ugTzPsoCmkwVyRLyiS/gYPbFyWh4httig==
X-Received: by 2002:a17:902:d491:b0:205:5d12:3f24 with SMTP id d9443c01a7336-208d837546emr227270775ad.20.1727190858269;
        Tue, 24 Sep 2024 08:14:18 -0700 (PDT)
Received: from localhost ([2a01:e0a:de5:d200:87a:d84a:dff5:3827])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1724ca5sm11453005ad.97.2024.09.24.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:14:17 -0700 (PDT)
Date: Tue, 24 Sep 2024 08:14:17 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Sep 2024 08:14:04 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.12 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-664fc7b8-c82b-414e-9c10-8fe7840f2c76@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 57d76bc51fd80824bcc0c84a5b5ec944f1b51edd:

  riscv: change XIP's kernel_map.size to be size of the entire kernel (2024-08-14 13:12:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.12-mw1

for you to fetch changes up to b3f835cd7339919561866252a11831ead72e7073:

  crash: Fix riscv64 crash memory reserve dead loop (2024-09-20 05:58:12 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.12 Merge Window, Part 1

* Support for using Zkr to seed KASLR.
* Support for IPI-triggered CPU backtracing.
* Support for generic CPU vulnerabilities reporting to userspace.
* A few cleanups for missing licenses.
* The size limit on the XIP kernel has been removed.
* Support for tracing userspace stacks.
* Support for the Svvptc extension.
* Various cleanups and fixes throughout the tree.

----------------------------------------------------------------
This is a bit small, but I'm not planning on taking anything else for this
merge window -- we had a few breakages over the last release so having a small
release probably isn't all that bad, and with all the conferences it's just a
bad time to be trying to stuff things in late (though I tell myself that every
cycle).

There are two conflicts here.  The IRQ one seems pretty straight-forward, just
two features colliding.  The testing one is a bit clunky, as I suppose I
probably just shouldn't have picked up the 32-bit fix in the first place given
it just conflicted and resulted in the same code.  Anyway, here's my conflict
results:

diff --cc arch/riscv/include/asm/irq.h
index 8330d16b05b5,7e9a84a005ed..000000000000
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@@ -12,11 -12,8 +12,13 @@@

  #include <asm-generic/irq.h>

+ #define INVALID_CONTEXT UINT_MAX
+
 +#ifdef CONFIG_SMP
 +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
 +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 +#endif
 +
  void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));

  struct fwnode_handle *riscv_get_intc_hwnode(void);
diff --cc tools/testing/selftests/riscv/mm/mmap_test.h
index 1c3313c201d5,75918d15919f..000000000000
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h


----------------------------------------------------------------
Alexandre Ghiti (4):
      riscv: Add ISA extension parsing for Svvptc
      dt-bindings: riscv: Add Svvptc ISA extension description
      riscv: Stop emitting preventive sfence.vma for new vmalloc mappings
      riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc

Changbin Du (1):
      riscv: vdso: do not strip debugging info for vdso.so.dbg

Charlie Jenkins (6):
      riscv: Add license to fence.h
      riscv: Add license to vmalloc.h
      riscv: Make riscv_isa_vendor_ext_andes array static
      selftests: riscv: Allow mmap test to compile on 32-bit
      tools: Add riscv barrier implementation
      tools: Optimize ring buffer for riscv

Geert Uytterhoeven (1):
      riscv: defconfig: Disable RZ/Five peripheral support

Haibo Xu (1):
      ACPI: NUMA: initialize all values of acpi_early_node_map to NUMA_NO_NODE

Hanjun Guo (1):
      ACPI: RISCV: Make acpi_numa_get_nid() to be static

Jesse Taube (4):
      RISC-V: pi: Force hidden visibility for all symbol references
      RISC-V: lib: Add pi aliases for string functions
      RISC-V: pi: Add kernel/pi/pi.h
      RISC-V: Use Zkr to seed KASLR base address

Jinjie Ruan (7):
      riscv: Enable generic CPU vulnerabilites support
      riscv: Fix fp alignment bug in perf_callchain_user()
      riscv: stacktrace: Add USER_STACKTRACE support
      riscv: Remove unused _TIF_WORK_MASK
      RISC-V: Implement kgdb_roundup_cpus() to enable future NMI Roundup
      riscv: Use LIST_HEAD() to simplify code
      crash: Fix riscv64 crash memory reserve dead loop

Jisheng Zhang (4):
      riscv: errata: sifive: Use SYM_*() assembly macros
      riscv: select ARCH_USE_SYM_ANNOTATIONS
      riscv: define ILLEGAL_POINTER_VALUE for 64bit
      riscv: avoid Imbalance in RAS

Mayuresh Chitale (1):
      perf/riscv-sbi: Add platform specific firmware event handling

Nam Cao (8):
      riscv: cleanup XIP_FIXUP macro
      riscv: don't export va_kernel_pa_offset in vmcoreinfo for XIP kernel
      riscv: replace misleading va_kernel_pa_offset on XIP kernel
      riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
      riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
      riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
      riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
      riscv: remove limit on the size of read-only section for XIP kernel

Palmer Dabbelt (8):
      Merge patch series "RISC-V: Parse DT for Zkr to seed KASLR"
      Merge patch series "remove size limit on XIP kernel"
      Merge patch series "riscv: stacktrace: Add USER_STACKTRACE support"
      Merge patch series "riscv: select ARCH_USE_SYM_ANNOTATIONS"
      Merge patch series "Svvptc extension to remove preventive sfence.vma"
      Merge patch series "riscv: Improve KASAN coverage to fix unit tests"
      RISC-V: Don't have MAX_PHYSMEM_BITS exceed phys_addr_t
      Merge patch series "tools: Add barrier implementations for riscv"

Ryo Takakura (1):
      RISC-V: Enable IPI CPU Backtrace

Samuel Holland (2):
      riscv: Omit optimized string routines when using KASAN
      riscv: Enable bitops instrumentation

Steffen Persvold (1):
      riscv: cacheinfo: Add back init_cache_level() function

Stuart Menefy (1):
      riscv: Remove redundant restriction on memory size

Xiao Wang (1):
      drivers/perf: riscv: Remove redundant macro check

Ying Sun (1):
      riscv/kexec_file: Fix relocation type R_RISCV_ADD16 and R_RISCV_SUB16 unknown

Yunhui Cui (1):
      riscv: Randomize lower bits of stack address

 .../devicetree/bindings/riscv/extensions.yaml      |   7 +
 arch/riscv/Kconfig                                 |   8 +
 arch/riscv/configs/defconfig                       |  12 +-
 arch/riscv/errata/sifive/errata_cip_453.S          |   8 +-
 arch/riscv/include/asm/acpi.h                      |   2 -
 arch/riscv/include/asm/bitops.h                    |  43 +++---
 arch/riscv/include/asm/cacheflush.h                |  18 ++-
 arch/riscv/include/asm/exec.h                      |   8 +
 arch/riscv/include/asm/fence.h                     |   1 +
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/irq.h                       |   5 +
 arch/riscv/include/asm/page.h                      |  29 +++-
 arch/riscv/include/asm/pgtable.h                   |  28 ++--
 arch/riscv/include/asm/sbi.h                       |   1 +
 arch/riscv/include/asm/set_memory.h                |   2 +-
 arch/riscv/include/asm/sparsemem.h                 |   2 +-
 arch/riscv/include/asm/string.h                    |   2 +
 arch/riscv/include/asm/thread_info.h               |  11 +-
 arch/riscv/include/asm/vmalloc.h                   |   1 +
 arch/riscv/include/asm/xip_fixup.h                 |  30 +++-
 arch/riscv/kernel/acpi_numa.c                      |   4 +-
 arch/riscv/kernel/asm-offsets.c                    |   7 +
 arch/riscv/kernel/cacheinfo.c                      |   5 +
 arch/riscv/kernel/cpufeature.c                     |   1 +
 arch/riscv/kernel/elf_kexec.c                      |   6 +
 arch/riscv/kernel/entry.S                          |  91 ++++++++++-
 arch/riscv/kernel/module.c                         |   4 +-
 arch/riscv/kernel/perf_callchain.c                 |  46 +-----
 arch/riscv/kernel/pi/Makefile                      |   4 +-
 arch/riscv/kernel/pi/archrandom_early.c            |  30 ++++
 arch/riscv/kernel/pi/cmdline_early.c               |  10 +-
 arch/riscv/kernel/pi/fdt_early.c                   | 167 ++++++++++++++++++++-
 arch/riscv/kernel/pi/pi.h                          |  20 +++
 arch/riscv/kernel/process.c                        |   9 ++
 arch/riscv/kernel/riscv_ksyms.c                    |   3 -
 arch/riscv/kernel/smp.c                            |  43 +++++-
 arch/riscv/kernel/stacktrace.c                     |  43 ++++++
 arch/riscv/kernel/vdso/Makefile                    |   2 +-
 arch/riscv/kernel/vendor_extensions/andes.c        |   2 +-
 arch/riscv/kernel/vmcore_info.c                    |   7 +
 arch/riscv/kernel/vmlinux-xip.lds.S                |   5 +-
 arch/riscv/lib/Makefile                            |   2 +
 arch/riscv/lib/memset.S                            |   2 +
 arch/riscv/lib/strcmp.S                            |   2 +
 arch/riscv/lib/strlen.S                            |   1 +
 arch/riscv/lib/strncmp.S                           |   2 +
 arch/riscv/mm/init.c                               |  28 ++--
 arch/riscv/mm/pgtable.c                            |  13 ++
 arch/riscv/purgatory/Makefile                      |   2 +
 drivers/perf/riscv_pmu.c                           |   2 -
 drivers/perf/riscv_pmu_sbi.c                       |  31 ++--
 kernel/crash_reserve.c                             |   3 +-
 tools/arch/riscv/include/asm/barrier.h             |  39 +++++
 tools/arch/riscv/include/asm/fence.h               |  13 ++
 tools/include/asm/barrier.h                        |   2 +
 tools/include/linux/ring_buffer.h                  |   2 +-
 tools/testing/selftests/riscv/mm/mmap_test.h       |   6 +-
 57 files changed, 707 insertions(+), 171 deletions(-)
 create mode 100644 arch/riscv/include/asm/exec.h
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
 create mode 100644 arch/riscv/kernel/pi/pi.h
 create mode 100644 tools/arch/riscv/include/asm/barrier.h
 create mode 100644 tools/arch/riscv/include/asm/fence.h


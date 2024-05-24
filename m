Return-Path: <linux-kernel+bounces-188898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CB48CE84B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D26281F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562A12E1D9;
	Fri, 24 May 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dOAqTgyS"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0EB12E1C2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566023; cv=none; b=ucSrouvFKHStqYu1a7JWMiiw2UbIuOCFKhygqDam8E+y1N17E8rnCvuz0XakLxLCTtNeFh4W2DHSDueAYx3jAsPolyqV9Rzl4dUCApgReCXk2mpToK6kdebRTLKkuzlCBoWsFlfgdEU8Ul1NJRPXYuXhhUdFNCvgt5jFWr9I/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566023; c=relaxed/simple;
	bh=tR9vssr6Nt3mE39q+nRW86O7XhIQI9tgFx4d/YwRSV4=;
	h=Date:Subject:CC:From:To:Message-ID; b=GY93NstHtyc7QqWU3/GHrymyXuhgQ8lyyRN3n+dAV/ITqKuO8pz34Vezj2yE3s7sYR86I/Y+l9EHrCjjy9RLIrtgPTSfoM4xu/dHApP/q8mRsDGBZ3quCMM2UlZKctzaHSyhF16Gwv5Xurf2ZsX1Fl3rzU0Nq38OgLwxrD1iLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dOAqTgyS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6fbbd937719so253026b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716566021; x=1717170821; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXoRyhGs+xAWpk5PhLe4MnaVpkrSqxHV2dZ2NlYdnoI=;
        b=dOAqTgySTb2RoEYeWUhURCFmyKIIKLZiu/NnxbM04/KJGL53GK8Op4xDx1MuuCPwzl
         pxar6VN+dlgR1yt04IsUJFYB7fdUw24flRxtcHDp1snVsghIR966Q2BrT2XKoEhKrMpZ
         MGplRsI9MvJ2gxlTAgkwmg2DBnkE2enhvNCW5EtW4ei90DE32cstBYAb+nxIqLSyIlYt
         jvMIAnu3teEJJk9AojSsUcZHHzVeFQ9YO2yUD996FmNQ5wKOHjqk5dEeV6rKa3g9CsXy
         SW8aOGjsanz4fBwxz2bzZ1Dbe/HYgVHO4eYeUr8LjbZ9OQ6cntxXq9y1TLcmBM8lagR/
         SUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716566021; x=1717170821;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXoRyhGs+xAWpk5PhLe4MnaVpkrSqxHV2dZ2NlYdnoI=;
        b=JMHcdwo2UrG8aZLeuraGxKIhiuZXI00kPti47L78bMRWNoVhLYk8QMBqVBKR+fmv/p
         YKOY2yijPVSGZJvrVf5OUrf+wvi/wEiLbZGYh49Uk3/kPrl+QvfMgAKDX2n63Ef6EsC7
         zHY23IhjIAKLh+ExnO6Yp6+Wg/oMAhD3fg5vdCynpifIreNsfPgaAQm+ivQeWSXmwJPv
         398BDrz0FcksgDI6N2QCQUf83wzRZPXOMKokXeyjSYSZ2Id4Zj84iyYCTE3KUgjPGCGa
         YWkHA3eTT25w6EfR3LEdjam7N0OXTdVu8RVwD3dwv+GsjRr2jyJjqfeIDGMu9zgy8X+a
         EE+g==
X-Forwarded-Encrypted: i=1; AJvYcCXQJDVYKcVvdXdza+HbOu/VtUXy66RYpfWSZCifHBz6rndoJQ/SDY7B75dN5GLKe6dPICE3yIRLoOPC5yogpBZFr5Bw1l/WCUTeEv8w
X-Gm-Message-State: AOJu0YzEUXpn4lP1juNG9B4D0D5BqrN1z6NLF3JyvypBjFsYyDkfGoJQ
	vFChw1FN/dUbTKGxjyfGjSe8ctPir3SM55frIt/svCx57Buh3VFLXl0O+rDgOVY3x6WYP7bjhIq
	2
X-Google-Smtp-Source: AGHT+IFsCm8hm+Rw/1DIRrNjQGtEYVqvgzlxmlteyPsodv/2TpCnJYSn5uByhISEk9LsfiApIjXaPg==
X-Received: by 2002:a05:6a20:4324:b0:1af:9ec6:afb8 with SMTP id adf61e73a8af0-1b212d0fc4fmr3416115637.23.1716566020686;
        Fri, 24 May 2024 08:53:40 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc05a3d2sm1267260b3a.50.2024.05.24.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:53:40 -0700 (PDT)
Date: Fri, 24 May 2024 08:53:40 -0700 (PDT)
X-Google-Original-Date: Fri, 24 May 2024 08:53:34 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.10 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3c77af8f-340f-41fd-86db-a2add39fdac2@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

merged tag 'riscv-for-linus-6.10-mw1'
The following changes since commit 0bfbc914d9433d8ac2763a9ce99ce7721ee5c8e0:

  Merge tag 'riscv-for-linus-6.10-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2024-05-22 09:56:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-mw2

for you to fetch changes up to 6ca445d8af0ed5950ebf899415fd6bfcd7d9d7a3:

  riscv: Fix early ftrace nop patching (2024-05-23 08:22:17 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.10 Merge Window, Part 2

* The compression format used for boot images is now configurable at
  build time, and these formats are shown in `make help`.
* access_ok() has been optimized.
* A pair of performance bugs have been fixed in the uaccess handlers.
* Various fixes and cleanups, including one for the IMSIC build failure
  and one for the early-boot ftrace illegal NOPs bug.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix early ftrace nop patching

Charlie Jenkins (4):
      riscv: cpufeature: Fix thead vector hwcap removal
      riscv: cpufeature: Fix extension subset checking
      riscv: selftests: Add hwprobe binaries to .gitignore
      riscv: selftests: Add signal handling vector tests

Emil Renner Berthing (2):
      riscv: make image compression configurable
      riscv: show help string for riscv-specific targets

Kefeng Wang (1):
      riscv: mm: accelerate pagefault when badaccess

Matthew Bystrin (1):
      riscv: stacktrace: fixed walk_stackframe()

Nam Cao (2):
      riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled
      riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context

Palmer Dabbelt (4):
      Merge patch series "riscv: access_ok() optimization"
      Merge patch series "riscv: fix debug_pagealloc"
      Merge patch series "riscv: Extension parsing fixes"
      irqchip: riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict

Puranjay Mohan (1):
      ftrace: riscv: move from REGS to ARGS

Qingfang Deng (1):
      riscv: do not select MODULE_SECTIONS by default

Samuel Holland (2):
      riscv: Remove PGDIR_SIZE_L3 and TASK_SIZE_MIN
      riscv: Define TASK_SIZE_MAX for __access_ok()

Xiao Wang (2):
      riscv: uaccess: Allow the last potential unrolled copy
      riscv: uaccess: Relax the threshold for fast path

Xingyou Chen (1):
      riscv: typo in comment for get_f64_reg

Zhao Ke (1):
      Use bool value in set_cpu_online()

 arch/riscv/Kconfig                                 |  11 +-
 arch/riscv/Makefile                                |  44 +++++-
 arch/riscv/boot/install.sh                         |   9 +-
 arch/riscv/include/asm/cacheflush.h                |   6 +
 arch/riscv/include/asm/ftrace.h                    |  76 ++++++++-
 arch/riscv/include/asm/pgtable-64.h                |   2 -
 arch/riscv/include/asm/pgtable.h                   |   3 +-
 arch/riscv/include/asm/sbi.h                       |   2 +
 arch/riscv/kernel/asm-offsets.c                    |  18 +++
 arch/riscv/kernel/cpu.c                            |  40 ++++-
 arch/riscv/kernel/cpufeature.c                     |  10 +-
 arch/riscv/kernel/fpu.S                            |   2 +-
 arch/riscv/kernel/ftrace.c                         |  20 +--
 arch/riscv/kernel/mcount-dyn.S                     | 171 ++++++---------------
 arch/riscv/kernel/smpboot.c                        |   2 +-
 arch/riscv/kernel/stacktrace.c                     |  20 ++-
 arch/riscv/lib/uaccess.S                           |   4 +-
 arch/riscv/mm/fault.c                              |   4 +-
 arch/riscv/mm/init.c                               |   3 +
 arch/riscv/mm/pageattr.c                           |  28 +++-
 drivers/irqchip/irq-riscv-imsic-early.c            |   2 +-
 include/linux/ftrace.h                             |   3 +-
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/hwprobe/.gitignore   |   2 +
 tools/testing/selftests/riscv/sigreturn/.gitignore |   1 +
 tools/testing/selftests/riscv/sigreturn/Makefile   |  12 ++
 .../testing/selftests/riscv/sigreturn/sigreturn.c  |  82 ++++++++++
 27 files changed, 395 insertions(+), 184 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/sigreturn/.gitignore
 create mode 100644 tools/testing/selftests/riscv/sigreturn/Makefile
 create mode 100644 tools/testing/selftests/riscv/sigreturn/sigreturn.c


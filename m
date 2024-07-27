Return-Path: <linux-kernel+bounces-264151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B963693DF8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688922818F0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399615DBC6;
	Sat, 27 Jul 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3E6cPLuZ"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063A15D5C3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722086958; cv=none; b=mEvWcrPjP1VL10x4qoZLXgUMMlXmgve/d3to+giE9rTGDk4euu+UqsLWIqrSem0JFWdF3E9KYhg7TZ+3KbIyMWS8pjZfwgnEjwNMn1UdOCitotQqFvuURVg94RPAbqPazc5TeF4Nh9yQkiWWDFJ3eZHUOithRV55K9L93AlhJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722086958; c=relaxed/simple;
	bh=k0GFnw1ZZwqBFO6sPp1gmqMT3w30tAA3Me+miVC2sNM=;
	h=Date:Subject:CC:From:To:Message-ID; b=GEGLoYHb871URoJH/XojNj/B2iuDpdbI9Zg7xzUlwu6ed6wmguopQD7cwqjtXScqKXXJPWZ9W9KD9ZdcNtXUlPXL+7wGPB4RbZGeXVaBYNNDw1Lm0hsLJiyLecoZs/hjlG101J2CUu5PiF2RFjQF6DWkqX4x3KO0ykJZrY71F6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3E6cPLuZ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5af8a4abbso1251630eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 06:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722086955; x=1722691755; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUGRsq+vCLngtXGB30eSlNXo6L9MN+Jqn7L0QKGWZmA=;
        b=3E6cPLuZIoqYqhwVq0odUlTMWE735M7o0sW+ej28B/z3ZZU4ppNTo7ZyiFnQrP/TPV
         6r2AxfHC1y/abcn1Hq/lMri0oGTqdJb9nc2LrVlsVXWvhGxBrg+A/dxMYVzpviw7PIH+
         AOBccK6YNn1RSNUMnwH5SnVVWpHcBPMITIxEFw3sYnOBEn7oXwo0Wp8+1/Nxa0Ji9UTg
         Sg/sMpFXh45mxfyLo8ubaxYdlqL+xaF+zY7LgGbAgpmMSOiTvK2rjwY8eb7eHMfREiut
         hOn/rcujjskNDMaO/MfsKIvi2CzciVAVLy/QBA4JO+WZlh+HzZumJhmW+zOMjXLHIRXh
         Ow/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722086955; x=1722691755;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUGRsq+vCLngtXGB30eSlNXo6L9MN+Jqn7L0QKGWZmA=;
        b=epGxn2iPKHYFVYUWkA037lTHJG9AjOU6gezdCa2Fn4cU1I9vtoUs4SQpXDGGLFl2cP
         tFsk84diyOhMT8UWlSylrNJo7MXJN4dh562ZDL70p05O2sM9ptEDPh2QxUGEkEhwcSX3
         fsw/1XBlcYU5d0VPxHwHCrZX/zq3pzJPg03qXPh50VZEPSHZT6InptE51IXJcGNgZCFu
         xf1vhuJ0qO1gjsTaxDLWm4YF8/WbpSMjMo4eLwrtSzixY8Ew7qEkfinj+DovniyR2jyn
         Khm0aImKrATmKrdOFPicHo4RIFp9oBvapnQrP4UT+i/rzIGUK4q19ZOPlu1bYMGRwAsk
         VKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVAGG6PemrTV2uvZuYuk8usc4uKxAE9DCrqMM60jQTHvWU/xYHfSYzntVKjE/ep61dmYLuzodmG+gYHFxYFkgc3dUmcvv6f8Qxqx5U
X-Gm-Message-State: AOJu0Yy0SpreJx2MIGRe7UgUcOQaO9Mn+0LdcQLiSocF70u2/0ez40w4
	79BjYPcL8eASrCYtusE2nGq9qoT71lFwavGJoBqiL9umlXzYtwKd2oMxiVmtNg8NUlRH6YMVJ2G
	0
X-Google-Smtp-Source: AGHT+IGCrx5jxQfpDSBIVvqabtCiff+EZ+vTsuBJY29BgRHQ1sU1FWsAf3VMoslAZWqE87SgkxOpmg==
X-Received: by 2002:a05:6870:d0c3:b0:261:211:9d14 with SMTP id 586e51a60fabf-267d4f26f45mr3171453fac.37.1722086955064;
        Sat, 27 Jul 2024 06:29:15 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da19sm3806708a12.32.2024.07.27.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 06:29:14 -0700 (PDT)
Date: Sat, 27 Jul 2024 06:29:14 -0700 (PDT)
X-Google-Original-Date: Sat, 27 Jul 2024 06:28:52 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

merged tag 'riscv-for-linus-6.11-mw1'
The following changes since commit f557af081de6b45a25e27d633b4d8d2dbc2f428e:

  Merge tag 'riscv-for-linus-6.11-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2024-07-20 09:11:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw2

for you to fetch changes up to 52420e483d3e1562f11a208d3c540b27b5e5dbf4:

  RISC-V: Provide the frequency of time CSR via hwprobe (2024-07-26 05:50:51 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.11 Merge Window, Part 2

* Support for NUMA (via SRAT and SLIT), console output (via SPCR), and
  cache info (via PPTT) on ACPI-based systems.
* The trap entry/exit code no longer breaks the return address stack
  predictor on many systems, which results in an improvement to trap
  latency.
* Support for HAVE_ARCH_STACKLEAK.
* The sv39 linear map has been extended to support 128GiB mappings.
* The frequency of the mtime CSR is now visible via hwprobe.

----------------------------------------------------------------
Sorry this one's late again, I'd accidentally picked up a patch that went
through another tree and didn't notice until yesterday morning.  There should
be no post-merge code chages, but I wanted to give it a day for the testers
just in case.

----------------------------------------------------------------
Anton Blanchard (1):
      riscv: Improve exception and system call latency

Charlie Jenkins (4):
      riscv: Extend cpufeature.c to detect vendor extensions
      riscv: Add vendor extensions to /proc/cpuinfo
      riscv: Introduce vendor variants of extension helpers
      riscv: cpufeature: Extract common elements from extension checking

Conor Dooley (2):
      RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0() alphabetically
      RISC-V: run savedefconfig for defconfig

Haibo Xu (4):
      ACPI: RISCV: Add NUMA support based on SRAT and SLIT
      ACPI: NUMA: Add handler for SRAT RINTC affinity structure
      ACPI: NUMA: change the ACPI_NUMA to a hidden option
      ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init

Jinjie Ruan (1):
      trace: riscv: Remove deprecated kprobe on ftrace support

Jisheng Zhang (2):
      riscv: boot: remove duplicated targets line
      riscv: enable HAVE_ARCH_STACKLEAK

Palmer Dabbelt (5):
      Merge patch series "Add ACPI NUMA support for RISC-V"
      Merge patch series "riscv: Separate vendor extensions from standard extensions"
      Merge patch "Enable SPCR table for console output on RISC-V"
      Merge patch series "RISC-V: Select ACPI PPTT drivers"
      RISC-V: Provide the frequency of time CSR via hwprobe

Sia Jee Heng (1):
      RISC-V: ACPI: Enable SPCR table for console output on RISC-V

Stuart Menefy (1):
      riscv: Extend sv39 linear mapping max size to 128G

Yunhui Cui (3):
      riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
      riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
      RISC-V: Select ACPI PPTT drivers

Zhongqiu Han (1):
      riscv: signal: Remove unlikely() from WARN_ON() condition

 Documentation/arch/riscv/hwprobe.rst             |   2 +
 Documentation/arch/riscv/vm-layout.rst           |  11 +-
 arch/arm64/Kconfig                               |   1 -
 arch/loongarch/Kconfig                           |   1 -
 arch/riscv/Kconfig                               |   6 +-
 arch/riscv/Kconfig.vendor                        |  19 +++
 arch/riscv/boot/Makefile                         |   1 -
 arch/riscv/configs/defconfig                     |  26 ++---
 arch/riscv/errata/andes/errata.c                 |   3 +
 arch/riscv/errata/sifive/errata.c                |   3 +
 arch/riscv/errata/thead/errata.c                 |   3 +
 arch/riscv/include/asm/acpi.h                    |  15 ++-
 arch/riscv/include/asm/cpufeature.h              | 103 ++++++++++------
 arch/riscv/include/asm/hwcap.h                   |  25 ++--
 arch/riscv/include/asm/hwprobe.h                 |   2 +-
 arch/riscv/include/asm/page.h                    |   2 +-
 arch/riscv/include/asm/thread_info.h             |   1 +
 arch/riscv/include/asm/vendor_extensions.h       | 104 +++++++++++++++++
 arch/riscv/include/asm/vendor_extensions/andes.h |  19 +++
 arch/riscv/include/uapi/asm/hwprobe.h            |   1 +
 arch/riscv/kernel/Makefile                       |   3 +
 arch/riscv/kernel/acpi.c                         |  17 ++-
 arch/riscv/kernel/acpi_numa.c                    | 131 +++++++++++++++++++++
 arch/riscv/kernel/cacheinfo.c                    |  35 ++++--
 arch/riscv/kernel/cpu.c                          |  35 +++++-
 arch/riscv/kernel/cpufeature.c                   | 143 ++++++++++++++++-------
 arch/riscv/kernel/entry.S                        |  21 ++--
 arch/riscv/kernel/probes/Makefile                |   1 -
 arch/riscv/kernel/probes/ftrace.c                |  65 -----------
 arch/riscv/kernel/setup.c                        |   4 +-
 arch/riscv/kernel/signal.c                       |   2 +-
 arch/riscv/kernel/smpboot.c                      |   2 -
 arch/riscv/kernel/stacktrace.c                   |   4 +-
 arch/riscv/kernel/sys_hwprobe.c                  |  48 ++++----
 arch/riscv/kernel/vendor_extensions.c            |  56 +++++++++
 arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
 arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
 drivers/acpi/numa/Kconfig                        |   5 +-
 drivers/acpi/numa/srat.c                         |  32 ++++-
 drivers/base/arch_numa.c                         |   2 +-
 drivers/firmware/efi/libstub/Makefile            |   3 +-
 drivers/perf/riscv_pmu_sbi.c                     |  11 +-
 include/linux/acpi.h                             |   6 +
 43 files changed, 750 insertions(+), 245 deletions(-)
 create mode 100644 arch/riscv/Kconfig.vendor
 create mode 100644 arch/riscv/include/asm/vendor_extensions.h
 create mode 100644 arch/riscv/include/asm/vendor_extensions/andes.h
 create mode 100644 arch/riscv/kernel/acpi_numa.c
 delete mode 100644 arch/riscv/kernel/probes/ftrace.c
 create mode 100644 arch/riscv/kernel/vendor_extensions.c
 create mode 100644 arch/riscv/kernel/vendor_extensions/Makefile
 create mode 100644 arch/riscv/kernel/vendor_extensions/andes.c


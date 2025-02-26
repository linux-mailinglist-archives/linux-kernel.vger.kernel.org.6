Return-Path: <linux-kernel+bounces-534986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E20A46D99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF4B3AC7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FDC25A34D;
	Wed, 26 Feb 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0GaaDK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67402222D1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605855; cv=none; b=pmEfBAl3rUI6pKPuZeQ7iDj2F3Iu4h8ZsGrccw/Srinn08Ir3T2Gl2ZTN6K03t0ryVAW7SqgHz3zu5WRK3kFOE4oWklZKiemDywoeIpalZmGb5Bytx0ZHgqD5KsskQRupTZ4szmPQyBlK0SCYhbRgPcZZnR9UopEpdJrPCPcB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605855; c=relaxed/simple;
	bh=SLelieoFkSXgVyzrv5Zmko1d/4niMb9Mwq3HC1RSDlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AIsxbhAJUO/ELXEfs3t5vN+rCJD77gnAW3pDHPOYByn4p2CdolbNSnHEf+LeAELbprUVN7YNMlS9h4acBn6DgCsLysKjaTsolT1WkrHo7cvEiWl8+rHnG7S1knuC0K+AGE+BDzSgSroE/C/dOQBGDV0udUia4+pNBKi/bdkGX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0GaaDK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310FFC4CED6;
	Wed, 26 Feb 2025 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605854;
	bh=SLelieoFkSXgVyzrv5Zmko1d/4niMb9Mwq3HC1RSDlA=;
	h=From:To:Cc:Subject:Date:From;
	b=r0GaaDK3c8a/C9lGgGJOJv9QpoLU0VhDlTILFkEhBweBTzzOF77SSAEDUaxUiHBZc
	 WLT5osjqrhVzY7BumGfUcEr3D+j2T5m4khNcoDfkViy6HPAynF41o/1xeHu1ja/bRa
	 Xcx95/cy/0GBDkejSeScI6qgVIjeAkqbSvjpoP2rxD2JOGMXatvZyBfF132QsDgr9h
	 YxxJr5MqqZ7c+ss7EWZRRPDh4jOOiUwdRY2/9YtFqm2atDGnfjtW0fh7/3uFs8WDnx
	 93HuGV7u9G9aongxHs8697upgERzVkKbYXQRiuuPtYIYpibP1Z8cQ3TcGVuz5+kO0u
	 j3FV5g05YrROw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 00/10] x86: 32-bit cleanups
Date: Wed, 26 Feb 2025 22:37:04 +0100
Message-Id: <20250226213714.4040853-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While looking at 32-bit arm cleanups, I came across some related topics
on x86 and ended up making a series for those as well.

Primarily this is about running 32-bit kernels on 64-bit hardware,
which usually works but should probably be discouraged more clearly by
only providing support for features that are used on real 32-bit hardware:

I found only a few 2003-era high-end servers (HP DL740 and DL760 G2)
that were the only possible remaining uses of HIGHMEM64G and BIGSMP after
the removal of 32-bit NUMA machines in 2014. Similarly, there is only
one generation of hardware with support for VT-x.  All these features
can be removed without hurting users.

In the CPU selection, building a 32-bit kernel optimized for AMD K8
or Intel Core2 is anachronistic, so instead only 32-bit CPU types need
to be offered as optimization targets. The "generic" target on 64-bit
turned out to be slightly broken, so I included a fix for that as well.

Changes since v2:

 - Add a patch for EISA
 - keep PHYS_ADDR_T_64BIT enabled for PAE kernels
 - drop the Kconfig.platforms and CONFIG_X86_64_NATIVE patches for now
 - improve changelog texts

Changes since v1:

 - Don't include patch to drop 32-bit KVM support for now
 - Drop patch for 64-bit Silverlake support
 - Drop 64-bit ISA level selection, only fix default
 - Rework MID patch based on comments
 - Add a patch to reorganize platform selection
 - Add a patch to add -march=native compilation


Arnd Bergmann (10):
  x86/Kconfig: Geode CPU has cmpxchg8b
  x86: drop 32-bit "bigsmp" machine support
  x86: rework CONFIG_GENERIC_CPU compiler flags
  x86: drop configuration options for early 64-bit CPUs
  x86: remove HIGHMEM64G support
  x86: drop SWIOTLB for PAE
  x86: drop support for CONFIG_HIGHPTE
  x86: document X86_INTEL_MID as 64-bit-only
  x86: remove old STA2x11 support
  x86: only allow EISA for 32-bit

 Documentation/admin-guide/kdump/kdump.rst     |   4 -
 .../admin-guide/kernel-parameters.txt         |  11 -
 Documentation/arch/x86/usb-legacy-support.rst |  11 +-
 arch/x86/Kconfig                              | 156 +++---------
 arch/x86/Kconfig.cpu                          |  97 ++------
 arch/x86/Makefile                             |  16 +-
 arch/x86/Makefile_32.cpu                      |   5 +-
 arch/x86/configs/xen.config                   |   2 -
 arch/x86/include/asm/page_32_types.h          |   4 +-
 arch/x86/include/asm/pgalloc.h                |   5 -
 arch/x86/include/asm/sta2x11.h                |  13 -
 arch/x86/include/asm/vermagic.h               |   4 -
 arch/x86/kernel/apic/Makefile                 |   3 -
 arch/x86/kernel/apic/apic.c                   |   3 -
 arch/x86/kernel/apic/bigsmp_32.c              | 105 --------
 arch/x86/kernel/apic/local.h                  |  13 -
 arch/x86/kernel/apic/probe_32.c               |  29 ---
 arch/x86/mm/init_32.c                         |   9 +-
 arch/x86/mm/pgtable.c                         |  27 +-
 arch/x86/pci/Makefile                         |   2 -
 arch/x86/pci/sta2x11-fixup.c                  | 233 ------------------
 drivers/misc/mei/Kconfig                      |   2 +-
 22 files changed, 66 insertions(+), 688 deletions(-)
 delete mode 100644 arch/x86/include/asm/sta2x11.h
 delete mode 100644 arch/x86/kernel/apic/bigsmp_32.c
 delete mode 100644 arch/x86/pci/sta2x11-fixup.c

-- 
2.39.5

To: x86@kernel.org 
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>


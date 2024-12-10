Return-Path: <linux-kernel+bounces-439779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120B9EB3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080D41693CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFC1A76AC;
	Tue, 10 Dec 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnSAPSGv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BD519ADA2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842195; cv=none; b=Ih/akL6XdjjCpNswUmrWJfMns+u3twJH47newK/1+CL7vtYNO1bm6HHWiVSULG3SHZzk4yPC0m94voxgFXjmtsym9OW3ge2t/+dQ5SLjQD6XZzzHijQ6RbFsTsxlbNfpsfmxNt7A++m+0PaOKLYAF6uoZfok5UaajKoDjUFYY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842195; c=relaxed/simple;
	bh=tB9YMmrq/xg+M87s/+jG5vhmYN41o7SGIFULf+Z6c7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7Ad2a6MuvFJC/sixOfTMiaKmQ9ZgonKJ3bBsGpzNd81B/UBvP2dPmuJPnHeKKignlCJ4oLdc+iap3/a+4sAztNKg9tzoL6rm52sR0vJqKPxPkpDarkEWxKnyWLX7QQJmFmWkcGG46vYXDzJ5Gm4Gn/7UA2M5J2bLrPIiVZ90gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnSAPSGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663B1C4CEDF;
	Tue, 10 Dec 2024 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842194;
	bh=tB9YMmrq/xg+M87s/+jG5vhmYN41o7SGIFULf+Z6c7k=;
	h=From:To:Cc:Subject:Date:From;
	b=lnSAPSGvnZcyODHDNRjAHPaR773OurWuxcTAHgEXCM6F9ajoU1Ga7TC+JITeGRuI2
	 m38cgCdWUGL9zd3+k5g+HJPU7qdKkio0VMLb8wCOsyUyKgLFe7g/18A7HdThy6U10q
	 eC4nyyupGaMwA1svRalx7SMo9U8l+mcd6LSlkTJhuuFLvZEPs/F1u1vZOvTkU60FvS
	 2OLynkhwKS9Oi7T6YGgJ1fbO+JdlpdIPUTBgKx1Tv7e1Slq2UM9nDWm3b5q6a/5umc
	 50K1a+x3SxgkLBMYgMq86ntcZfo0dnhTHGg+bELh1us8XhlG4y3oYy9etP4qG6lwJu
	 WlQueWNZjQY4g==
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
Subject: [PATCH v2 00/11] x86: 32-bit cleanups
Date: Tue, 10 Dec 2024 15:49:34 +0100
Message-Id: <20241210144945.2325330-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[sorry for sending a duplicate series, I just noticed I had
 dropped lkml from cc when I sent this a few minutes ago]

While looking at 32-bit arm cleanups, I came across some related topics
on x86 and ended up making a series for those as well.

Primarily this is about running 32-bit kernels on 64-bit hardware,
which usually works but should probably be discouraged more clearly by
only providing support for features that are used on real 32-bit hardware:

I found only a few 2003-era high-end servers (HP DL740 and DL760 G2)
that were the only possible remaining uses of HIGHMEM64G and BIGSMP after
the removal of 32-bit NUMA machines in 2014. Similary, there is only
one generation of hardware with support for VT-x.  All these features
can be removed without hurting users.

In the CPU selection, building a 32-bit kernel optimized for AMD K8
or Intel Core2 is anachronistic, so instead only 32-bit CPU types need
to be offered as optimization targets. The "generic" target on 64-bit
turned out to be slightly broken, so I included a fix for that as well.

Changes since v1:

 - Don't include patch to drop 32-bit KVM support for now
 - Drop patch for 64-bit Silverlake support
 - Drop 64-bit ISA level selection, only fix default
 - Rework MID patch based on comments
 - Add a patch to reorganize platform selection
 - Add a patch to add -march=native compilation

Arnd Bergmann (11):
  x86/Kconfig: Geode CPU has cmpxchg8b
  x86: drop 32-bit "bigsmp" machine support
  x86: rework CONFIG_GENERIC_CPU compiler flags
  x86: drop configuration options for early 64-bit CPUs
  x86: add CONFIG_X86_64_NATIVE option
  x86: remove HIGHMEM64G support
  x86: drop SWIOTLB and PHYS_ADDR_T_64BIT for PAE
  x86: drop support for CONFIG_HIGHPTE
  x86: document X86_INTEL_MID as 64-bit-only
  x86: remove old STA2x11 support
  x86: Move platforms to Kconfig.platforms

 Documentation/admin-guide/kdump/kdump.rst     |   4 -
 .../admin-guide/kernel-parameters.txt         |  11 -
 Documentation/arch/x86/usb-legacy-support.rst |  11 +-
 arch/x86/Kconfig                              | 460 +-----------------
 arch/x86/Kconfig.cpu                          | 111 ++---
 arch/x86/Kconfig.platforms                    | 361 ++++++++++++++
 arch/x86/Makefile                             |  21 +-
 arch/x86/Makefile_32.cpu                      |   5 +-
 arch/x86/configs/xen.config                   |   2 -
 arch/x86/include/asm/page_32_types.h          |   4 +-
 arch/x86/include/asm/pgalloc.h                |   5 -
 arch/x86/include/asm/sta2x11.h                |  13 -
 arch/x86/include/asm/vermagic.h               |   4 -
 arch/x86/kernel/apic/Makefile                 |   3 -
 arch/x86/kernel/apic/apic.c                   |   3 -
 arch/x86/kernel/apic/bigsmp_32.c              | 105 ----
 arch/x86/kernel/apic/local.h                  |  13 -
 arch/x86/kernel/apic/probe_32.c               |  29 --
 arch/x86/mm/init_32.c                         |   9 +-
 arch/x86/mm/pgtable.c                         |  32 +-
 arch/x86/pci/Makefile                         |   2 -
 arch/x86/pci/sta2x11-fixup.c                  | 233 ---------
 drivers/misc/mei/Kconfig                      |   2 +-
 include/linux/mm.h                            |   2 +-
 24 files changed, 422 insertions(+), 1023 deletions(-)
 create mode 100644 arch/x86/Kconfig.platforms
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


Return-Path: <linux-kernel+bounces-330629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461AD97A202
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853AEB21188
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02521154429;
	Mon, 16 Sep 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pCbZsS0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F2142903
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488847; cv=none; b=dyDp99bBHsrJwrhyFGj/8gh5aMNXEflICPXmIalC2DOzRcQkacUW0sa3QemeFhUbb3tEhgZxPUtova/WXz5Cu6uSfsGbjsTZUgtr+o1Z3iSor7dAGshEwTJpmueSC0fr1qsI2FWgouQFvCsczqitx8YpGGeL2m2y/urAo7A59jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488847; c=relaxed/simple;
	bh=BVc07mZjaDR/3tdIvUugaXB08Pej4zdMwUK7YmVqUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MigqgGMAcmAaUJ5I4tRgIRxB07nuAzRYAYR6MtevJrvsIqV01Vu4vBbXz9E1n3NxidJ5+mSBiusB/hbimw7zQxuqPAoKALnkG71cQbSzkBZqoFk84tSx5nvWmacqywAO6k/3uhQe/RAM2BNZaGZUHJprkupdWH/uOPIoeaPkSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pCbZsS0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56761C4CEC4;
	Mon, 16 Sep 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pCbZsS0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726488844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iDiqMiOVQ6ytIykMWuIsMcPKnnpSWKrtWYWTUNA0qoM=;
	b=pCbZsS0SN6YMGXpkyzyUUB5fLBPb7EY/VYCcCBtPBWaC5O/+/RoDYZcFAkVbKmVp2S3hYS
	l5Hk9+b8udBUCiSpwfIT4U0vwQuRvewRfYBJxNF8omwFEoUJB5FCSzbnbyFWG9GL1KZrfl
	lMAoqYY2RPCze/muKaJ8HBd9BafGiKc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17393092 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:14:04 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.12-rc1
Date: Mon, 16 Sep 2024 14:13:58 +0200
Message-ID: <20240916121358.3666562-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Originally I'd planned on sending each of the vDSO getrandom() architecture
ports to their respective arch trees. But as we started to work on this, we
found lots of interesting issues in the shared code and infrastructure, the
fixes for which the various archs needed to base their work. So in the end,
this turned into a nice collaborative effort fixing up issues and porting to
5 new architectures -- arm64, powerpc64, powerpc32, s390x, and loongarch64 --
with everybody pitching in and commenting on each other's code. It was a fun
development cycle.

This pull request contains:

- Numerous fixups to the vDSO selftest infrastructure, getting it running
  successfully on more platforms, and fixing bugs in it.

- Additions to the vDSO getrandom & chacha selftests. Basically every time
  manual review unearthed a bug in a revision of an arch patch, or an
  ambiguity, the tests were augmented. By the time the last arch was submitted
  for review, s390x, v1 of the series was essentially fine right out of the
  gate.

- Fixes to the the generic C implementation of vDSO getrandom, to build and
  run successfully on all archs, decoupling it from assumptions we had
  (unintentionally) made on x86_64 that didn't carry through to the other
  architectures.

- Port of vDSO getrandom to LoongArch64, from Xi Ruoyao and acked by Huacai
  Chen.

- Port of vDSO getrandom to ARM64, from Adhemerval Zanella and acked by Will
  Deacon.

- Port of vDSO getrandom to PowerPC, in both 32-bit and 64-bit varieties, from
  Christophe Leroy and acked by Michael Ellerman.

- Port of vDSO getrandom to S390X from Heiko Carstens, the arch maintainer.

While it'd be natural for there to be things to fix up over the course of the
6.12 cycle, these patches got a decent amount of review from a fairly diverse
crew of folks on the mailing lists, and, for the most part, they've been
cooking in linux-next, which has been helpful for ironing out build issues.

In terms of architectures, I think that mostly takes care of the important
64-bit archs with hardware still being produced and running production loads
in settings where vDSO getrandom is likely to help. Arguably there's still
RISC-V left, and we'll see for 6.13 whether they find it useful and submit a
port.

I haven't seen any merge conflicts from Stephen with linux-next. But this pull
does touch lots of different archs, so I was thinking it'd probably make sense
to merge this early in the cycle, before merging the architectures pulls from
the various archs. But you know best there, of course.

On a more personal note, sorry I'm unable to make it to Vienna this year; it
would have been nice to talk about things face to face. We'll see about next
year.

Please pull!

Thanks,
Jason

The following changes since commit d5d547aa7b51467b15d9caa86b116f8c2507c72a:

  Merge tag 'random-6.11-rc6-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random (2024-08-29 13:59:18 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.12-rc1-for-linus

for you to fetch changes up to 210860e7f7337e47e77577fa5bb168767e2d8a1e:

  selftests: vDSO: check cpu caps before running chacha test (2024-09-16 13:22:04 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.12-rc1.
----------------------------------------------------------------

Adhemerval Zanella (1):
      arm64: vDSO: Wire up getrandom() vDSO implementation

Christophe Leroy (21):
      selftests: vDSO: don't hard-code location of vDSO sources
      selftests: vDSO: fix include order in build of test_vdso_chacha
      selftests: vDSO: look for arch-specific function name in getrandom test
      selftests: vDSO: fix vDSO name for powerpc
      selftests: vDSO: fix vdso_config for powerpc
      selftests: vDSO: fix vDSO symbols lookup for powerpc64
      selftests: vDSO: fix the way vDSO functions are called for powerpc
      selftests: vDSO: use parse_vdso.h in vdso_test_abi
      random: vDSO: don't use 64-bit atomics on 32-bit architectures
      random: vDSO: add __arch_get_k_vdso_rng_data() helper for data page access
      random: vDSO: add missing c-getrandom-y in Makefile
      random: vDSO: avoid call to out of line memset()
      random: vDSO: minimize and simplify header includes
      selftests: vDSO: build tests with O2 optimization
      selftests: vDSO: also test counter in vdso_test_chacha
      powerpc/vdso: Fix VDSO data access when running in a non-root time namespace
      mm: Define VM_DROPPABLE for powerpc/32
      powerpc/vdso32: Add crtsavres
      powerpc/vdso: Refactor CFLAGS for CVDSO build
      powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO32
      powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO64

Heiko Carstens (8):
      selftests: vDSO: fix vdso_config for s390
      s390/facility: Disable compile time optimization for decompressor code
      s390/alternatives: Remove ALT_FACILITY_EARLY
      s390/facility: Let test_facility() generate static branch if possible
      s390/module: Provide find_section() helper
      s390/vdso: Allow alternatives in vdso code
      s390/vdso: Move vdso symbol handling to separate header file
      s390/vdso: Wire up getrandom() vdso implementation

Jason A. Donenfeld (11):
      selftests: vDSO: simplify getrandom thread local storage and structs
      selftests: vDSO: separate LDLIBS from CFLAGS for libsodium
      selftests: vDSO: remove unnecessary command line defs from chacha test
      selftests: vDSO: skip getrandom test if architecture is unsupported
      selftests: vDSO: quash clang omitted parameter warning in getrandom test
      selftests: vDSO: ensure vgetrandom works in a time namespace
      random: vDSO: move prototype of arch chacha function to vdso/getrandom.h
      selftests: vDSO: open code basic chacha instead of linking to libsodium
      selftests: vDSO: fix cross build for getrandom and chacha tests
      selftests: vDSO: don't include generated headers for chacha test
      selftests: vDSO: check cpu caps before running chacha test

Jens Remus (1):
      selftests: vDSO: fix ELF hash table entry size for s390x

Mark Rutland (1):
      arm64: alternative: make alternative_has_cap_likely() VDSO compatible

Xi Ruoyao (4):
      selftests: vDSO: add --cflags for pkg-config command querying libsodium
      selftests: vDSO: use KHDR_INCLUDES for UAPI headers for getrandom test
      random: vDSO: add a __vdso_getrandom prototype for all architectures
      LoongArch: vDSO: Wire up getrandom() vDSO implementation

 Documentation/ABI/stable/vdso                      |   8 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/alternative-macros.h        |   4 +
 arch/arm64/include/asm/mman.h                      |   6 +-
 arch/arm64/include/asm/vdso/getrandom.h            |  50 +++
 arch/arm64/include/asm/vdso/vsyscall.h             |  15 +
 arch/arm64/kernel/vdso.c                           |   6 -
 arch/arm64/kernel/vdso/Makefile                    |  25 +-
 arch/arm64/kernel/vdso/vdso.lds.S                  |   4 +
 arch/arm64/kernel/vdso/vgetrandom-chacha.S         | 172 ++++++++++
 arch/arm64/kernel/vdso/vgetrandom.c                |  15 +
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/vdso/getrandom.h        |  39 +++
 arch/loongarch/include/asm/vdso/vdso.h             |   6 +
 arch/loongarch/include/asm/vdso/vsyscall.h         |   8 +
 arch/loongarch/kernel/vdso.c                       |   1 +
 arch/loongarch/vdso/Makefile                       |   7 +-
 arch/loongarch/vdso/vdso.lds.S                     |   1 +
 arch/loongarch/vdso/vgetrandom-chacha.S            | 242 ++++++++++++++
 arch/loongarch/vdso/vgetrandom.c                   |  10 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/mman.h                    |   2 +-
 arch/powerpc/include/asm/vdso/getrandom.h          |  54 +++
 arch/powerpc/include/asm/vdso/vsyscall.h           |   6 +
 arch/powerpc/include/asm/vdso_datapage.h           |  17 +
 arch/powerpc/kernel/asm-offsets.c                  |   3 +
 arch/powerpc/kernel/vdso/Makefile                  |  57 ++--
 arch/powerpc/kernel/vdso/cacheflush.S              |   2 +-
 arch/powerpc/kernel/vdso/datapage.S                |   4 +-
 arch/powerpc/kernel/vdso/getrandom.S               |  58 ++++
 arch/powerpc/kernel/vdso/gettimeofday.S            |  13 -
 arch/powerpc/kernel/vdso/vdso32.lds.S              |   1 +
 arch/powerpc/kernel/vdso/vdso64.lds.S              |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S       | 365 +++++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c              |  14 +
 arch/s390/Kconfig                                  |   1 +
 arch/s390/include/asm/alternative.h                |   6 +-
 arch/s390/include/asm/facility.h                   |  37 ++-
 arch/s390/include/asm/fpu-insn-asm.h               |  22 ++
 arch/s390/include/asm/module.h                     |  14 +
 arch/s390/include/asm/vdso-symbols.h               |  17 +
 arch/s390/include/asm/vdso.h                       |  12 -
 arch/s390/include/asm/vdso/getrandom.h             |  40 +++
 arch/s390/include/asm/vdso/vsyscall.h              |  15 +
 arch/s390/kernel/compat_signal.c                   |   2 +-
 arch/s390/kernel/entry.S                           |   2 +-
 arch/s390/kernel/signal.c                          |   2 +-
 arch/s390/kernel/vdso.c                            |  26 +-
 arch/s390/kernel/vdso64/Makefile                   |   9 +-
 arch/s390/kernel/vdso64/vdso.h                     |   1 +
 arch/s390/kernel/vdso64/vdso64.lds.S               |   7 +
 arch/s390/kernel/vdso64/vgetrandom-chacha.S        | 185 +++++++++++
 arch/s390/kernel/vdso64/vgetrandom.c               |  14 +
 arch/x86/entry/vdso/vgetrandom.c                   |   2 -
 arch/x86/entry/vdso/vma.c                          |   3 +
 arch/x86/include/asm/pvclock.h                     |   1 +
 arch/x86/include/asm/vdso/getrandom.h              |  13 -
 arch/x86/include/asm/vdso/vsyscall.h               |  10 +-
 drivers/char/random.c                              |  12 +-
 fs/proc/task_mmu.c                                 |   4 +-
 include/asm-generic/unaligned.h                    |  11 +-
 include/linux/mm.h                                 |   4 +-
 include/trace/events/mmflags.h                     |   4 +-
 include/vdso/getrandom.h                           |  28 ++
 include/vdso/helpers.h                             |   1 +
 include/vdso/unaligned.h                           |  15 +
 lib/vdso/Makefile                                  |   1 +
 lib/vdso/getrandom.c                               |  27 +-
 tools/arch/arm64/vdso                              |   1 +
 tools/arch/loongarch/vdso                          |   1 +
 tools/arch/powerpc/vdso                            |   1 +
 tools/arch/s390/vdso                               |   1 +
 tools/arch/x86/vdso                                |   1 +
 tools/include/asm/alternative.h                    |  10 +
 tools/include/generated/asm-offsets.h              |   0
 tools/include/generated/asm/cpucap-defs.h          |   0
 tools/include/generated/asm/sysreg-defs.h          |   0
 tools/include/linux/compiler.h                     |   4 +
 tools/include/linux/linkage.h                      |   4 +
 tools/testing/selftests/vDSO/Makefile              |  21 +-
 tools/testing/selftests/vDSO/parse_vdso.c          |  17 +-
 tools/testing/selftests/vDSO/vdso_call.h           |  70 ++++
 tools/testing/selftests/vDSO/vdso_config.h         |  18 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c       |  14 +-
 tools/testing/selftests/vDSO/vdso_test_chacha.c    | 103 +++++-
 .../testing/selftests/vDSO/vdso_test_correctness.c |  21 +-
 tools/testing/selftests/vDSO/vdso_test_getcpu.c    |   3 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 128 +++++---
 .../selftests/vDSO/vdso_test_gettimeofday.c        |   3 +-
 89 files changed, 1949 insertions(+), 239 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
 create mode 100644 arch/loongarch/include/asm/vdso/getrandom.h
 create mode 100644 arch/loongarch/vdso/vgetrandom-chacha.S
 create mode 100644 arch/loongarch/vdso/vgetrandom.c
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c
 create mode 100644 arch/s390/include/asm/vdso-symbols.h
 create mode 100644 arch/s390/include/asm/vdso/getrandom.h
 create mode 100644 arch/s390/kernel/vdso64/vgetrandom-chacha.S
 create mode 100644 arch/s390/kernel/vdso64/vgetrandom.c
 create mode 100644 include/vdso/unaligned.h
 create mode 120000 tools/arch/arm64/vdso
 create mode 120000 tools/arch/loongarch/vdso
 create mode 120000 tools/arch/powerpc/vdso
 create mode 120000 tools/arch/s390/vdso
 create mode 120000 tools/arch/x86/vdso
 create mode 100644 tools/include/generated/asm-offsets.h
 create mode 100644 tools/include/generated/asm/cpucap-defs.h
 create mode 100644 tools/include/generated/asm/sysreg-defs.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_call.h


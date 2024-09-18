Return-Path: <linux-kernel+bounces-332728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BDB97BDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CECD1F2302B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7D9111AA;
	Wed, 18 Sep 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MrjErDPP"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390691097B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669191; cv=none; b=YQU5elr6+H+F0LZsTidGEIpPXQktmAIfKT6xB8R6taMm/D/bSP86AjuJNcob2QuyZMP8+YFpKP21Qz/ux6QgtQxRLm10zDGC0NvTQ9pCXqJD8ToMhEzObE/92+/Uhe5/FV/tk38A3azAjccmjd1+ak4rHgjTBJmLn3DvKV2Ifjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669191; c=relaxed/simple;
	bh=hs1FTABh/GDkKKFqNrSatY5eNfYTEFrTrC62N56jnqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qpi9EFoZ9ZRPHVS2q3bJkdhSX/p9yOwxuaijJ/pDqO9rMVsOK8GR7SdJLrlQnyjR821mbOjd9MfJQ/Pa1ovZ5zG5mn50x2o3WyvBeG579bMWECqNXaQBpXXRKb24lL5q7e3VUIvd9WsEVl3bvthqoCSFvrpGq92NVNb83Q2Pyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=MrjErDPP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726669184;
	bh=xNGrxblZLjGZAqk6sbr/+V0cGACKOR658A4nQUdcHM0=;
	h=From:To:Cc:Subject:Date:From;
	b=MrjErDPPEkZDq1zIOtslEz6QLqJ7h9sk0DPxirUKSQFzsXL+IU0o6j6Z7nstFaKb4
	 XaqE2BZMwk0G2ARM+RNGbSJk3b5aTkur0DwlvgXQzGwVjc2qrs9ZHVfoXRj5UPsE/W
	 lZ4o/dCFGvijMbkPzptVNM9Kv4q3suU3mRQ43CyWXdsg5oxyqbPsKvcseFVK/zmLDE
	 OzfX/1MBUlDDj4U5m7w1EAlXmH8vUxFt1f/KwFV4M4Aypp29mi/XVeSPqTAOh16f4F
	 8u9wIG5v4qW4SMwAGMZNiNOvF+ZSC1C0BZcNXVGIbks9uT0NacIc9oJHzX7pYzpB36
	 6HRufTrsAG0/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X814Y4k2Xz4xVV;
	Thu, 19 Sep 2024 00:19:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: adubey@linux.ibm.com, alexs@kernel.org, arnd@arndb.de,
 bgray@linux.ibm.com, christophe.leroy@csgroup.eu, cuigaosheng1@huawei.com,
 gautam@linux.ibm.com, haren@linux.ibm.com, huangxiaojia2@huawei.com,
 jk@ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, naveen@kernel.org,
 nnmlinux@linux.ibm.com, robh@kernel.org, ruanjinjie@huawei.com,
 tzimmermann@suse.de, u.kleine-koenig@baylibre.com, zhangzekun11@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-1 tag
Date: Thu, 19 Sep 2024 00:19:38 +1000
Message-ID: <8734lxqc1x.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull powerpc updates for 6.12. No conflicts that I'm aware of. The V=
DSO
changes have already been merged via the random tree.

cheers

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.12-1

for you to fetch changes up to 39190ac7cff1fd15135fa8e658030d9646fdb5f2:

  powerpc/atomic: Use YZ constraints for DS-form instructions (2024-09-17 2=
2:17:57 +1000)

- ------------------------------------------------------------------
powerpc updates for 6.12

 - Reduce alignment constraints on STRICT_KERNEL_RWX and speed-up TLB misse=
s on
   8xx and 603.

 - Replace kretprobe code with rethook and enable fprobe.

 - Remove the "fast endian switch" syscall.

 - Handle DLPAR device tree updates in kernel, allowing the deprecation of =
the
   binary /proc/powerpc/ofdt interface.

Thanks to: Abhishek Dubey, Alex Shi, Benjamin Gray, Christophe Leroy, Gaosh=
eng
Cui, Gautam Menghani, Geert Uytterhoeven, Haren Myneni, Hari Bathini, Huang
Xiaojia, Jinjie Ruan, Madhavan Srinivasan, Miguel Ojeda, Mina Almasry, Nara=
yana
Murty N, Naveen Rao, Rob Herring (Arm), Scott Cheloha, Segher Boessenkool,
Stephen Rothwell, Thomas Zimmermann, Uwe Kleine-K=C3=B6nig, Vaibhav Jain, Z=
hang
Zekun.

- ------------------------------------------------------------------
Abhishek Dubey (1):
      powerpc: Replace kretprobe code with rethook on powerpc

Alex Shi (1):
      KVM: PPC: Book3S HV: remove unused varible

Benjamin Gray (5):
      powerpc/code-patching: Add generic memory patching
      powerpc/code-patching: Add data patch alignment check
      powerpc/64: Convert patch_instruction() to patch_u32()
      powerpc/32: Convert patch_instruction() to patch_uint()
      powerpc/code-patching: Add boot selftest for data patching

Christophe Leroy (17):
      powerpc: Remove unused LHZX_BE macro
      powerpc/8xx: Fix initial memory mapping
      powerpc/8xx: Fix kernel vs user address comparison
      powerpc/8xx: Copy kernel PGD entries into all PGDIRs
      Revert "powerpc/8xx: Always pin kernel text TLB"
      powerpc/8xx: Allow setting DATA alignment even with STRICT_KERNEL_RWX
      powerpc/8xx: Reduce default size of module/execmem area
      powerpc/8xx: Preallocate execmem page tables
      powerpc/8xx: Inconditionally use task PGDIR in ITLB misses
      powerpc/8xx: Inconditionally use task PGDIR in DTLB misses
      powerpc/32s: Reduce default size of module/execmem area
      powerpc/603: Copy kernel PGD entries into all PGDIRs and preallocate =
execmem page tables
      powerpc/603: Switch r0 and r3 in TLB miss handlers
      powerpc/603: Inconditionally use task PGDIR in ITLB misses
      powerpc/603: Inconditionally use task PGDIR in DTLB misses
      powerpc/32: Implement validation of emergency stack
      powerpc/vdso: Inconditionally use CFUNC macro

Gaosheng Cui (5):
      powerpc: Remove obsoleted declaration for _get_SP
      powerpc/maple: Remove obsoleted declaration for maple_calibrate_decr()
      powerpc/pasemi: Remove obsoleted declaration for pas_pci_irq_fixup()
      powerpc: Remove obsoleted declarations for use_cop and drop_cop
      powerpc/powernv/pci: Remove obsoleted declaration for pnv_pci_init_io=
da_hub

Gautam Menghani (1):
      KVM: PPC: Book3S HV: Refactor HFSCR emulation for KVM guests

Haren Myneni (3):
      powerpc/pseries: Use correct data types from pseries_hp_errorlog stru=
ct
      powerpc/pseries/dlpar: Remove device tree node for DLPAR IO remove
      powerpc/pseries/dlpar: Add device tree nodes for DLPAR IO add

Huang Xiaojia (3):
      powerpc: Constify struct kobj_type
      powerpc: powernv: Constify struct kobj_type
      powerpc: pseries: Constify struct kobj_type

Jinjie Ruan (1):
      powerpc: Remove useless config comment in asm/percpu.h

Madhavan Srinivasan (2):
      powerpc/xmon: Fix tmpstr length check in scanhex
      selftests/powerpc: Allow building without static libc

Michael Ellerman (13):
      MAINTAINERS: Mark powerpc Cell as orphaned
      MAINTAINERS: Mark powerpc spufs as orphaned
      powerpc/configs/64s: Enable DEFERRED_STRUCT_PAGE_INIT
      powerpc/64s/mm: Move __real_pte stubs into hash-4k.h
      powerpc/64s: Make mmu_hash_ops __ro_after_init
      powerpc/mm/64s: Move THP reqs into a separate symbol
      powerpc/mm/64s: Restrict THP to Radix or HPT w/64K pages
      powerpc/64s: Remove the "fast endian switch" syscall
      powerpc: Stop using no_llseek
      macintosh/via-pmu: register_pmu_pm_ops() can be __init
      Merge branch 'topic/ppc-kvm' into next
      MAINTAINERS: powerpc: Add Maddy
      powerpc/atomic: Use YZ constraints for DS-form instructions

Narayana Murty N (1):
      powerpc/pseries/eeh: Fix pseries_eeh_err_inject

Rob Herring (Arm) (1):
      powerpc: Use of_property_present()

Thomas Zimmermann (2):
      powerpc/traps: Use backlight power constants
      macintosh/via-pmu-backlight: Use backlight power constants

Uwe Kleine-K=C3=B6nig (2):
      powerpc/476: Drop explicit initialization of struct i2c_device_id::dr=
iver_data to 0
      powerpc: Switch back to struct platform_driver::remove()

Zhang Zekun (2):
      powerpc/powermac/pfunc_base: Use helper function for_each_child_of_no=
de()
      powerpc/pseries/dlpar: Use helper function for_each_child_of_node()


 CREDITS                                                  |   6 +
 MAINTAINERS                                              |   9 +-
 arch/powerpc/Kconfig                                     |  32 ++-
 arch/powerpc/Kconfig.debug                               |   6 -
 arch/powerpc/configs/ppc64_defconfig                     |   1 +
 arch/powerpc/include/asm/asm-compat.h                    |   8 +-
 arch/powerpc/include/asm/atomic.h                        |   5 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h             |   3 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h             |  20 ++
 arch/powerpc/include/asm/book3s/64/pgtable.h             |  26 ---
 arch/powerpc/include/asm/code-patching.h                 |  37 ++++
 arch/powerpc/include/asm/eeh.h                           |   1 +
 arch/powerpc/include/asm/mmu_context.h                   |   3 -
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h             |   3 +-
 arch/powerpc/include/asm/nohash/pgalloc.h                |   8 +-
 arch/powerpc/include/asm/percpu.h                        |   2 +-
 arch/powerpc/include/asm/rtas.h                          |   1 +
 arch/powerpc/include/asm/thread_info.h                   |   4 +
 arch/powerpc/include/asm/uaccess.h                       |   7 +-
 arch/powerpc/kernel/Makefile                             |   1 +
 arch/powerpc/kernel/cacheinfo.c                          |   2 +-
 arch/powerpc/kernel/eeh.c                                |  13 +-
 arch/powerpc/kernel/exceptions-64s.S                     |  17 --
 arch/powerpc/kernel/head_8xx.S                           |  78 ++++---
 arch/powerpc/kernel/head_book3s_32.S                     | 144 ++++++------
 arch/powerpc/kernel/kprobes.c                            |  65 +-----
 arch/powerpc/kernel/module_64.c                          |   5 +-
 arch/powerpc/kernel/optprobes.c                          |   2 +-
 arch/powerpc/kernel/process.c                            |  22 +-
 arch/powerpc/kernel/rethook.c                            |  73 ++++++
 arch/powerpc/kernel/secvar-sysfs.c                       |   2 +-
 arch/powerpc/kernel/stacktrace.c                         |   6 +-
 arch/powerpc/kernel/static_call.c                        |   2 +-
 arch/powerpc/kernel/traps.c                              |   2 +-
 arch/powerpc/kernel/vdso/gettimeofday.S                  |   4 -
 arch/powerpc/kvm/book3s_hv.c                             |  18 +-
 arch/powerpc/lib/code-patching.c                         |  70 ++++--
 arch/powerpc/lib/test-code-patching.c                    |  41 ++++
 arch/powerpc/mm/book3s32/mmu.c                           |   2 +
 arch/powerpc/mm/book3s64/hash_utils.c                    |   2 +-
 arch/powerpc/mm/mem.c                                    |  14 ++
 arch/powerpc/mm/nohash/8xx.c                             |   9 +-
 arch/powerpc/platforms/44x/ppc476.c                      |   2 +-
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c            |   2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c                |   1 -
 arch/powerpc/platforms/85xx/sgy_cts1000.c                |   2 +-
 arch/powerpc/platforms/8xx/Kconfig                       |   7 +
 arch/powerpc/platforms/Kconfig.cputype                   |  11 +-
 arch/powerpc/platforms/cell/spufs/file.c                 |  17 --
 arch/powerpc/platforms/maple/maple.h                     |   1 -
 arch/powerpc/platforms/pasemi/gpio_mdio.c                |   2 +-
 arch/powerpc/platforms/pasemi/pasemi.h                   |   1 -
 arch/powerpc/platforms/powermac/pfunc_base.c             |   2 +-
 arch/powerpc/platforms/powermac/smp.c                    |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c             |   3 +-
 arch/powerpc/platforms/powernv/opal-dump.c               |   2 +-
 arch/powerpc/platforms/powernv/opal-elog.c               |   2 +-
 arch/powerpc/platforms/powernv/opal-lpc.c                |   2 +-
 arch/powerpc/platforms/powernv/opal-prd.c                |   2 +-
 arch/powerpc/platforms/powernv/pci.h                     |   1 -
 arch/powerpc/platforms/pseries/dlpar.c                   | 234 +++++++++++=
+++++++--
 arch/powerpc/platforms/pseries/dtl.c                     |   1 -
 arch/powerpc/platforms/pseries/eeh_pseries.c             |  39 +++-
 arch/powerpc/platforms/pseries/hotplug-cpu.c             |   2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c          |  16 +-
 arch/powerpc/platforms/pseries/papr_scm.c                |   2 +-
 arch/powerpc/platforms/pseries/pmem.c                    |   2 +-
 arch/powerpc/platforms/pseries/vas-sysfs.c               |   4 +-
 arch/powerpc/sysdev/fsl_msi.c                            |   2 +-
 arch/powerpc/sysdev/pmi.c                                |   2 +-
 arch/powerpc/xmon/xmon.c                                 |   2 +-
 drivers/macintosh/via-pmu-backlight.c                    |   2 +-
 drivers/macintosh/via-pmu.c                              |   2 +-
 tools/testing/selftests/powerpc/benchmarks/Makefile      |   2 +-
 tools/testing/selftests/powerpc/benchmarks/exec_target.c |  16 +-
 75 files changed, 781 insertions(+), 385 deletions(-)
 create mode 100644 arch/powerpc/kernel/rethook.c
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRjvi15rv0TSTaE+SIF0oADX8seIQUCZurhKAAKCRAF0oADX8se
IZ13AQCm39s+vzO2omeS0Gmy3OGZJclzH1vdPVQgi+NVtWeJXAD+M5Vd6zbpUpw3
5yLOLy25C919Aujgo1bsk1ALg9g/Ugs=3D
=3D0TcI
-----END PGP SIGNATURE-----


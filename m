Return-Path: <linux-kernel+bounces-257962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF893817C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 15:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81A11F21997
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AF212FF71;
	Sat, 20 Jul 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zwuK3pi4"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09026AF1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482512; cv=none; b=RvPbc806hUCUVCghKrP5is1msi2pPr7ns+O5T2QiNoFrHKatsJ9VKisAKpANjg2N9B+k3vZtnTZUoEHOEloJZVK3t3WaW/6HbTudFpK7AZfESAZ/z9rJbt/nNIebKAQaTKtjrxvg/xiWJ98atryhmQaVETl8tHmN7Djk8rtVYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482512; c=relaxed/simple;
	bh=IlOteqTRCXOugvoaxkRpnLteH6MMLUAiiRNi/wZ7YH0=;
	h=Date:Subject:CC:From:To:Message-ID; b=l0QUNX9XLm7ZxGBQZyhKrP24i5T9PAeNd4wbBp56hLRpvxfYnvVs6x2UQ3ckOC1ShqfFCEN1JG1HFRzU4SEtUw4sC3xwl5XNfnKP0+0vhFSRSTm1t7/fLZwfIRf3vfbcfncDX+TUms1/EYgq1DHexfut60RhcfSnHVtok1nUIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zwuK3pi4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af8062039so1167177b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721482509; x=1722087309; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+QWxi2++8QhWnRWs9Zkt59xg1ybIT/ZbG3HIocXw4=;
        b=zwuK3pi43Kc4KAth+l7esR24Uo/xtfCTYZWaUe7/o5MyORdwQCHFw7XNNqm0B2bEW3
         nXVHzV1Hnq2S4dFrZhlBmtlcGeWoLzIFMeiD/hxOQFOapR6aP7xKBU5u7AW8Lnv9bPUY
         ucuxmP9XK8cDgKWXYjuq3Hc26NsbMd7E/zrXnDFNB4ldakN58ogyxCMzoHHE1CpA00gI
         Cn+Kuq3HSaC2mJAQG9A/SZVX0FCoziUilKB2ytykq5Waa5I5QmkicCFo7euaYs4pxXpq
         dRkNFVw7nm7fTU+UBFWYCq3ztbgw+B61jl6jZfjmso1QPfVXGJZx0BsYUt+gd/i49zJ+
         Lg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721482509; x=1722087309;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT+QWxi2++8QhWnRWs9Zkt59xg1ybIT/ZbG3HIocXw4=;
        b=YEtsrneI+GHjU8J2+luyQLwVM2S8hdLhp+LenZ1N7hQ4lF1xHYnw6gFklLZ7ZPXwzQ
         IllAJpfOs/ftO00w4g4ICl0ELiR7oGrpI33TQ9d2+cY0uZmDf/XiaEsL2xTY9kpwK/w5
         5fCQFwj2zAsKNlg7KnXgH8QlkPmCVTyMvTCL3WE8CH3MRyd/Xy+4PelcanlMm9AYZyZm
         YKgNOG9vlp6wxH0Z5LLRZK6LbM69x0MZTt7BR2HDZ3qZw14T8tEWdzsteAHe2N9FLGl7
         MdH2EKx93NB6exctkE0StoCnb+o/dBy4lES7Rz9BZOYOBWT3y9eYvYaQ9UkNC8YKbSGk
         Leig==
X-Forwarded-Encrypted: i=1; AJvYcCVrRrZndwtMW1ffLRSXin5wyEIPuvSkECABqCF842Ndft49b0g08oGKrwYjVzROX2jKZ50vSCXLG3GnMgVy62rvGrwqhCHVypXSTUlT
X-Gm-Message-State: AOJu0Yx5V7TFRB6J0F9AmFrM/NcUoA74wO43TvcqBiNQyXLTh+/g5MZx
	GulLWFRbyPDt0M9C0xHf6bAYIbLoO039J1wzmTEc6ekKLnMkXrGm3IBWrukpQuVNivkcI/vJUn9
	a
X-Google-Smtp-Source: AGHT+IEZYav3ruZbtmqQN5iygn2wn2u5CWvjA9Mzf2EU1a7RSL9nnAGmu9IyL/0yEgWFKSw7ivVb+Q==
X-Received: by 2002:a05:6a20:a12b:b0:1c0:f5fa:d1e9 with SMTP id adf61e73a8af0-1c422896fa0mr3110793637.15.1721482509170;
        Sat, 20 Jul 2024 06:35:09 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25d9e3sm21913895ad.28.2024.07.20.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 06:35:08 -0700 (PDT)
Date: Sat, 20 Jul 2024 06:35:08 -0700 (PDT)
X-Google-Original-Date: Sat, 20 Jul 2024 06:32:45 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-099fa737-a1fc-466d-bf27-9ad62173bb45@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-mw1

for you to fetch changes up to 93b63f68d00a0483b450b446e2ea5386a1b94213:

  riscv: lib: relax assembly constraints in hweight (2024-07-15 08:46:46 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.11 Merge Window, Part 1

* Support for various new ISA extensions:
    * The Zve32[xf] and Zve64[xfd] sub-extensios of the vector
      extension.
    * Zimop and Zcmop for may-be-operations.
    * The Zca, Zcf, Zcd and Zcb sub-extensions of the C extension.
    * Zawrs,
* riscv,cpu-intc is now dtschema.
* A handful of performance improvements and cleanups to text patching.
* Support for memory hot{,un}plug
* The highest user-allocatable virtual address is now visible in
  hwprobe.

----------------------------------------------------------------
Sorry this is a bit late, but I got caught up in a handful of build issues from
other trees that cropped up during the merge window.  Looks like that's mostly
settling down, as usual I've got the fixed stacked up locally until things get
sorted out.  Aside from that everything looks clean on my end.

I have one merge conflict: some of the in-flight text patching
optimizations/cleanups ended up conflicting with the instruction tearing bugs
we found during the last release cycle.  As a result the fences are now inside
the patching functions, which while slow should at least be correct.

Here's my resolution of the actual diff, we could delete the functions but with
more incoming I figured it was best to avoid sticking extra diff in the merge:

diff --cc arch/riscv/kernel/patch.c
index ab03732d06c4,5b3f6406e8c4..000000000000
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@@ -200,12 -186,13 +202,7 @@@ NOKPROBE_SYMBOL(patch_insn_set)

  int patch_text_set_nosync(void *addr, u8 c, size_t len)
  {
- 	u32 *tp = addr;
--	int ret;
--
- 	ret = patch_insn_set(tp, c, len);
 -	ret = patch_insn_set(addr, c, len);
 -	if (!ret)
 -		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
--
--	return ret;
++	return patch_insn_set(addr, c, len);
  }
  NOKPROBE_SYMBOL(patch_text_set_nosync);

@@@ -232,12 -222,13 +232,7 @@@ NOKPROBE_SYMBOL(patch_insn_write)

  int patch_text_nosync(void *addr, const void *insns, size_t len)
  {
- 	u32 *tp = addr;
--	int ret;
--
- 	ret = patch_insn_write(tp, insns, len);
 -	ret = patch_insn_write(addr, insns, len);
 -	if (!ret)
 -		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
--
--	return ret;
++	return patch_insn_write(addr, insns, len);
  }
  NOKPROBE_SYMBOL(patch_text_nosync);

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Implement pte_accessible()
      riscv: Improve sbi_ecall() code generation by reordering arguments

Andrew Jones (5):
      riscv: Provide a definition for 'pause'
      dt-bindings: riscv: Add Zawrs ISA extension description
      riscv: hwprobe: export Zawrs ISA extension
      KVM: riscv: Support guest wrs.nto
      KVM: riscv: selftests: Add Zawrs extension to get-reg-list test

Andy Chiu (8):
      riscv: vector: add a comment when calling riscv_setup_vsize()
      riscv: smp: fail booting up smp if inconsistent vlen is detected
      riscv: cpufeature: call match_isa_ext() for single-letter extensions
      dt-bindings: riscv: add Zve32[xf] Zve64[xfd] ISA extension description
      riscv: cpufeature: add zve32[xf] and zve64[xfd] isa detection
      riscv: hwprobe: add zve Vector subextensions into hwprobe interface
      riscv: vector: adjust minimum Vector requirement to ZVE32X
      selftest: run vector prctl test for ZVE32X

Björn Töpel (11):
      riscv: mm: Properly forward vmemmap_populate() altmap parameter
      riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
      riscv: mm: Change attribute from __init to __meminit for page functions
      riscv: mm: Refactor create_linear_mapping_range() for memory hot add
      riscv: mm: Add pfn_to_kaddr() implementation
      riscv: mm: Add memory hotplugging support
      riscv: mm: Take memory hotplug read-lock during kernel page table dump
      riscv: Enable memory hotplugging for RISC-V
      virtio-mem: Enable virtio-mem for RISC-V
      riscv: mm: Add support for ZONE_DEVICE
      riscv: Enable DAX VMEMMAP optimization

Christoph Müllner (1):
      riscv: Add Zawrs support for spinlocks

Clément Léger (17):
      dt-bindings: riscv: add Zimop ISA extension description
      riscv: add ISA extension parsing for Zimop
      riscv: hwprobe: export Zimop ISA extension
      RISC-V: KVM: Allow Zimop extension for Guest/VM
      KVM: riscv: selftests: Add Zimop extension to get-reg-list test
      dt-bindings: riscv: add Zca, Zcf, Zcd and Zcb ISA extension description
      riscv: add ISA extensions validation callback
      riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
      riscv: hwprobe: export Zca, Zcf, Zcd and Zcb ISA extensions
      RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
      KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test
      dt-bindings: riscv: add Zcmop ISA extension description
      riscv: add ISA extension parsing for Zcmop
      riscv: hwprobe: export Zcmop ISA extension
      RISC-V: KVM: Allow Zcmop extension for Guest/VM
      KVM: riscv: selftests: Add Zcmop extension to get-reg-list test
      riscv: hwprobe: export highest virtual userspace address

Haibo Xu (1):
      riscv: dmi: Add SMBIOS/DMI support

Kanak Shilledar (2):
      dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
      dt-bindings: riscv: cpus: add ref to interrupt-controller

Palmer Dabbelt (6):
      Merge patch series "Support Zve32[xf] and Zve64[xfd] Vector subextensions"
      Merge patch series "dt-bindings: interrupt-controller: riscv,cpu-intc"
      Merge patch series "riscv: Various text patching improvements"
      Merge patch series "Add support for a few Zc* extensions, Zcmop and Zimop"
      Merge patch series "riscv: Memory Hot(Un)Plug support"
      Merge patch series "riscv: Apply Zawrs when available"

Qingfang Deng (1):
      riscv: lib: relax assembly constraints in hweight

Samuel Holland (8):
      riscv: jump_label: Batch icache maintenance
      riscv: jump_label: Simplify assembly syntax
      riscv: kprobes: Use patch_text_nosync() for insn slots
      riscv: Simplify text patching loops
      riscv: Pass patch_text() the length in bytes
      riscv: Use offset_in_page() in text patching functions
      riscv: Remove extra variable in patch_text_nosync()
      riscv: Add tracepoints for SBI calls and returns

Xiao Wang (1):
      riscv: Optimize crc32 with Zbc extension

yang.zhang (1):
      riscv: set trap vector earlier

 Documentation/arch/riscv/hwprobe.rst               |  50 +++
 .../interrupt-controller/riscv,cpu-intc.txt        |  52 ---
 .../interrupt-controller/riscv,cpu-intc.yaml       |  73 +++++
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  21 +-
 .../devicetree/bindings/riscv/extensions.yaml      | 132 ++++++++
 arch/riscv/Kconfig                                 |  59 +++-
 arch/riscv/Makefile                                |   3 -
 arch/riscv/include/asm/arch_hweight.h              |   8 +-
 arch/riscv/include/asm/barrier.h                   |  45 ++-
 arch/riscv/include/asm/cmpxchg.h                   |  58 ++++
 arch/riscv/include/asm/cpufeature.h                |   1 +
 arch/riscv/include/asm/dmi.h                       |  24 ++
 arch/riscv/include/asm/hwcap.h                     |  12 +
 arch/riscv/include/asm/hwprobe.h                   |   2 +-
 arch/riscv/include/asm/insn-def.h                  |   4 +
 arch/riscv/include/asm/jump_label.h                |   4 +-
 arch/riscv/include/asm/kasan.h                     |   4 +-
 arch/riscv/include/asm/kvm_host.h                  |   1 +
 arch/riscv/include/asm/mmu.h                       |   4 +-
 arch/riscv/include/asm/page.h                      |   5 +
 arch/riscv/include/asm/patch.h                     |   2 +-
 arch/riscv/include/asm/pgtable-64.h                |  20 ++
 arch/riscv/include/asm/pgtable-bits.h              |   1 +
 arch/riscv/include/asm/pgtable.h                   |  32 +-
 arch/riscv/include/asm/processor.h                 |   6 +
 arch/riscv/include/asm/sbi.h                       |  10 +-
 arch/riscv/include/asm/trace.h                     |  54 ++++
 arch/riscv/include/asm/vdso/processor.h            |   8 +-
 arch/riscv/include/asm/vector.h                    |  10 +-
 arch/riscv/include/uapi/asm/hwprobe.h              |  13 +
 arch/riscv/include/uapi/asm/kvm.h                  |   7 +
 arch/riscv/kernel/cpufeature.c                     | 328 +++++++++++++------
 arch/riscv/kernel/head.S                           |  22 +-
 arch/riscv/kernel/jump_label.c                     |  16 +-
 arch/riscv/kernel/patch.c                          |  69 ++--
 arch/riscv/kernel/probes/kprobes.c                 |  19 +-
 arch/riscv/kernel/sbi.c                            |  17 +-
 arch/riscv/kernel/smpboot.c                        |  14 +-
 arch/riscv/kernel/sys_hwprobe.c                    |  22 +-
 arch/riscv/kernel/vector.c                         |   5 +-
 arch/riscv/kvm/vcpu.c                              |   1 +
 arch/riscv/kvm/vcpu_insn.c                         |  15 +
 arch/riscv/kvm/vcpu_onereg.c                       |  14 +
 arch/riscv/lib/Makefile                            |   1 +
 arch/riscv/lib/crc32.c                             | 294 +++++++++++++++++
 arch/riscv/lib/uaccess.S                           |   2 +-
 arch/riscv/mm/init.c                               | 347 ++++++++++++++++++---
 arch/riscv/mm/ptdump.c                             |   3 +
 arch/riscv/net/bpf_jit_comp64.c                    |   7 +-
 drivers/firmware/efi/riscv-runtime.c               |  13 +
 drivers/virtio/Kconfig                             |   2 +-
 include/linux/crc32.h                              |   3 +
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  28 ++
 .../testing/selftests/riscv/vector/vstate_prctl.c  |   6 +-
 54 files changed, 1644 insertions(+), 329 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
 create mode 100644 arch/riscv/include/asm/dmi.h
 create mode 100644 arch/riscv/include/asm/trace.h
 create mode 100644 arch/riscv/lib/crc32.c


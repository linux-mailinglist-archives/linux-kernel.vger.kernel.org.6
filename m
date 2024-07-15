Return-Path: <linux-kernel+bounces-252444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC66593132C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C311C21889
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7298189F5D;
	Mon, 15 Jul 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bhGVHCJY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEB188CBA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043415; cv=none; b=amVFjrvdE6/3Ry3XhvToGkwgP9YFCkJPDXi1pl8A7hKxE3SyQXhJFRkSW/KAtXbndi0kMClq08ubLL3VNsoeC0FS2JpoE9t8O3pCCezVNLkr48VZDwR2YanKSaWK+uwctNDSK+6NAXBU3atstrHQ3asl1/iB2xOxAyhXbhQqdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043415; c=relaxed/simple;
	bh=wfcJXya/B1cl9E+80bHHXJa2FnjvkTEmW36pL00mEAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BBwisRiF3wmczjUrdxysO+uXzR98D40etxwzQ0gGPt/BPQUyhl+9JGRoTCl0QJO0dQoPeYAGEP64x/LM/DCQLxe/e8DEwr+zwVnrV/iL4bne9q1NgK9hnyTkNpTagP4GyEEZzC0Es1/KFO2mo9UauWJ17JrKS/erjbTV0sD/URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bhGVHCJY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFA1740E021B;
	Mon, 15 Jul 2024 11:36:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1FCRgngiESKh; Mon, 15 Jul 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721043406; bh=wVNtPXsRWfANqGhXjhREtyO8FzQ41t07I5DJbTV9G/g=;
	h=Date:From:To:Cc:Subject:From;
	b=bhGVHCJYZQMOZF5cChFUyyI1/cBlatUaJGMtj/fxIqBjxWr0R1fkjihOynmPLRc0Z
	 Q5AhU8ydMZ6kqJYdCwESAbm5joYvrCUyd5JOTS2T40OysjfmSDc/g3WQN2xwLEWdrU
	 +OtgyYqw/IMPCZzsv7Mv5WzC1mucGjekJ6Mt1GyNQvjhbsa/Nr17PS3NgrmCk2SnKy
	 luFahqG/yw9asfcOlJ0EfbLdFMmsZ4cqlOdsiWvZ1B9v40M++w0hP5djKRrrFxavts
	 i4h1jN3ffJg3XQlVV3pMzRUuEXtk7RIWHC1AJjpSZqFXBF9yLeldk4AWxzFJEuJm2q
	 ltq9liE4p94aRhvVxRJ6Tc8YIJfzAi3g3tORdakA1YS4Wk5qInFR3cwl0PpLP4v/NF
	 Cgs9uC9BX+6p//IqpjlGf2bKbewEujFXR8TRO7PRaVx+IJMumgYyIGxLlmhuyOgM7Y
	 8senVHkzPohFTyy1PxljbkPNkmDwovHLrDMGCEGEHOA9BjGIb6tFP8O0E1HzAA/9Xl
	 xYVZElUMIVAiLxxvgY4jjMeDts3OyepuQmri7lNvJGPev3u4tg3omezx/t/5bdBpxP
	 mnv7bO4xBZWRVgwYaLEEYP9Yo2ubiHm+C+qJFdxctGH2VJDZUqKnSNm9a6zcc1Hrie
	 xdQswoacwsOG5j1EAIjRmZHM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7773F40E0027;
	Mon, 15 Jul 2024 11:36:43 +0000 (UTC)
Date: Mon, 15 Jul 2024 13:36:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cc for v6.11-rc1
Message-ID: <20240715113637.GAZpUJxSbBiAhXSGPl@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86 confidential computing lineup for v6.11-rc1.

Thx.

---

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cc_for_v6.11_rc1

for you to fetch changes up to 16df35946120fca2346c415fae429c821391eef8:

  ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed (2024-06-17 17:46:28 +0200)

----------------------------------------------------------------
- Unrelated x86/cc changes queued here to avoid ugly cross-merges and
  conflicts:

   - Carve out CPU hotplug function declarations into a separate header
     with the goal to be able to use the lockdep assertions in a more
     flexible manner

   - As a result, refactor cacheinfo code after carving out a function
     to return the cache ID associated with a given cache level

   -  Cleanups

- Add support to be able to kexec TDX guests. For that

   - Expand ACPI MADT CPU offlining support

   - Add machinery to prepare CoCo guests memory before kexec-ing into a new
     kernel

   - Cleanup, readjust and massage related code

----------------------------------------------------------------
Ashish Kalra (1):
      x86/mm: Do not zap page table entries mapping unaccepted memory table during kdump

Borislav Petkov (1):
      x86/relocate_kernel: Use named labels for less confusion

Kirill A. Shutemov (17):
      x86/acpi: Extract ACPI MADT wakeup code into a separate file
      x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
      cpu/hotplug: Add support for declaring CPU offlining not supported
      cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
      x86/kexec: Keep CR4.MCE set during kexec for TDX guest
      x86/mm: Make x86_platform.guest.enc_status_change_*() return an error
      x86/mm: Return correct level from lookup_address() if pte is none
      x86/tdx: Account shared memory
      x86/mm: Add callbacks to prepare encrypted memory for kexec
      x86/tdx: Convert shared memory back to private on kexec
      x86/mm: Make e820__end_ram_pfn() cover E820_TYPE_ACPI ranges
      x86/acpi: Rename fields in the acpi_madt_multiproc_wakeup structure
      x86/acpi: Do not attempt to bring up secondary CPUs in the kexec case
      x86/smp: Add smp_ops.stop_this_cpu() callback
      x86/mm: Introduce kernel_ident_mapping_free()
      x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
      ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed

Nikolay Borisov (1):
      x86/kexec: Remove spurious unconditional JMP from from identity_mapped()

Tony Luck (4):
      cpu: Move CPU hotplug function declarations into their own header
      cpu: Drop "extern" from function declarations in cpuhplock.h
      cacheinfo: Add function to get cacheinfo for a given CPU and cache level
      x86/resctrl: Replace open coded cacheinfo searches

 arch/x86/Kconfig                          |   7 +
 arch/x86/coco/core.c                      |   1 -
 arch/x86/coco/tdx/tdx.c                   | 121 ++++++++++++-
 arch/x86/hyperv/ivm.c                     |  22 +--
 arch/x86/include/asm/acpi.h               |   7 +
 arch/x86/include/asm/init.h               |   3 +
 arch/x86/include/asm/pgtable.h            |   5 +
 arch/x86/include/asm/pgtable_types.h      |   1 +
 arch/x86/include/asm/set_memory.h         |   3 +
 arch/x86/include/asm/smp.h                |   1 +
 arch/x86/include/asm/x86_init.h           |  14 +-
 arch/x86/kernel/acpi/Makefile             |   1 +
 arch/x86/kernel/acpi/boot.c               |  86 +--------
 arch/x86/kernel/acpi/madt_playdead.S      |  28 +++
 arch/x86/kernel/acpi/madt_wakeup.c        | 292 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  17 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  14 +-
 arch/x86/kernel/crash.c                   |  12 ++
 arch/x86/kernel/e820.c                    |   9 +-
 arch/x86/kernel/process.c                 |   7 +
 arch/x86/kernel/reboot.c                  |  18 ++
 arch/x86/kernel/relocate_kernel_64.S      |  27 +--
 arch/x86/kernel/x86_init.c                |   8 +-
 arch/x86/mm/ident_map.c                   |  73 ++++++++
 arch/x86/mm/init_64.c                     |  16 +-
 arch/x86/mm/mem_encrypt_amd.c             |   8 +-
 arch/x86/mm/pat/set_memory.c              |  75 ++++++--
 drivers/acpi/tables.c                     |  14 ++
 include/acpi/actbl2.h                     |  19 +-
 include/linux/cacheinfo.h                 |  25 ++-
 include/linux/cc_platform.h               |  10 -
 include/linux/cpu.h                       |  33 +---
 include/linux/cpuhplock.h                 |  49 +++++
 kernel/cpu.c                              |  12 +-
 34 files changed, 812 insertions(+), 226 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
 create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
 create mode 100644 include/linux/cpuhplock.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


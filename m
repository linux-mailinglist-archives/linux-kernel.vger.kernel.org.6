Return-Path: <linux-kernel+bounces-435461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E39E7813
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79522826AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105E204563;
	Fri,  6 Dec 2024 18:27:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803761FFC67
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509657; cv=none; b=TI7xQM5Gq11HmgWlfgbIsFlRZNb++K6adjJkFYvx26llMVdWiWBf49SleL2i5koCC+hV9p2CChxa0DhUJ/Kf8KrU2oLMtMBO3oJAhTxu0pddI9YuqKutIuLGHnIsK/gqpM4WkhfuhP+rN87I+oBBi8mfJJCTf+NBvgCuzZ9VOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509657; c=relaxed/simple;
	bh=TP6cJB68XMh3erEv6Zr2Biejau8BLyCLLrwZjLbctnA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RBBYHzuVo7iP2aQhFlz7yX0SvcUuvYPVBHcROfW1z1tpium2Cjows0NkENufarem7qsg530/5yqpRWaROPlvucyom6uF7zuQgg04P7Nc0p8Z9HjbX0xtaKcRqlnrYj5JgME4UbFvMGd0PHeoZXnlbWoT36PZuXsqM0zQrCY5BY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B34C4CED1;
	Fri,  6 Dec 2024 18:27:36 +0000 (UTC)
Date: Fri, 6 Dec 2024 18:27:33 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.13-rc2
Message-ID: <Z1NCFeR4iBm5Bxqg@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Nothing major, some left-overs from
the recent merging window (MTE, coco) and some newly found issues like
the ptrace() ones. More details in the tag. Thanks.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to d60624f72d15862a96965b945f6ddfee9a1359e7:

  arm64: ptrace: fix partial SETREGSET for NT_ARM_GCS (2024-12-05 18:05:51 +0000)

----------------------------------------------------------------
arm64 fixes for 6.13-rc2:

- MTE/hugetlbfs:

  - Set VM_MTE_ALLOWED in the arch code and remove it from the core code
    for hugetlbfs mappings

  - Fix copy_highpage() warning when the source is a huge page but not
    MTE tagged, taking the wrong small page path

- drivers/virt/coco:

  - Add the pKVM and Arm CCA drivers under the arm64 maintainership

  - Fix the pkvm driver to fall back to ioremap() (and warn) if the
    MMIO_GUARD hypercall fails

  - Keep the Arm CCA driver default 'n' rather than 'm'

- A series of fixes for the arm64 ptrace() implementation, potentially
  leading to the kernel consuming uninitialised stack variables when
  PTRACE_SETREGSET is invoked with a length of 0

- Fix zone_dma_limit calculation when RAM starts below 4GB and ZONE_DMA
  is capped to this limit

- Fix early boot warning with CONFIG_DEBUG_VIRTUAL=y triggered by a call
  to page_to_phys() (from patch_map()) which checks pfn_valid() before
  vmemmap has been set up

- Do not clobber bits 15:8 of the ASID used for TTBR1_EL1 and TLBI ops
  when the kernel assumes 8-bit ASIDs but running under a hypervisor on
  a system that implements 16-bit ASIDs (found running Linux under
  Parallels on Apple M4)

- ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A as it is
  using the same SMMU PMCG as HIP09 and suffers from the same errata

- Add GCS to cpucap_is_possible(), missed in the recent merge

----------------------------------------------------------------
Catalin Marinas (2):
      arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs
      arm64: mte: Fix copy_highpage() warning on hugetlb folios

Mark Rutland (5):
      arm64: patching: avoid early page_to_phys()
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL
      arm64: ptrace: fix partial SETREGSET for NT_ARM_FPMR
      arm64: ptrace: fix partial SETREGSET for NT_ARM_POE
      arm64: ptrace: fix partial SETREGSET for NT_ARM_GCS

Qinxin Xia (1):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A

Robin Murphy (1):
      arm64: cpufeature: Add GCS to cpucap_is_possible()

Suzuki K Poulose (1):
      coco: virt: arm64: Do not enable cca guest driver by default

Will Deacon (2):
      drivers/virt: pkvm: Don't fail ioremap() call if MMIO_GUARD fails
      MAINTAINERS: Add CCA and pKVM CoCO guest support to the ARM64 entry

Yang Shi (2):
      arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at correct place
      arm64: mm: Fix zone_dma_limit calculation

 Documentation/arch/arm64/silicon-errata.rst   |  5 ++--
 MAINTAINERS                                   |  2 ++
 arch/arm64/include/asm/cpucaps.h              |  2 ++
 arch/arm64/include/asm/cpufeature.h           |  3 +--
 arch/arm64/include/asm/mman.h                 |  3 ++-
 arch/arm64/kernel/patching.c                  | 21 +++++++---------
 arch/arm64/kernel/ptrace.c                    | 36 +++++++++++++++++++++------
 arch/arm64/mm/context.c                       |  4 +--
 arch/arm64/mm/copypage.c                      |  8 +++---
 arch/arm64/mm/init.c                          | 17 ++++++-------
 drivers/acpi/arm64/iort.c                     |  2 ++
 drivers/virt/coco/arm-cca-guest/Kconfig       |  1 -
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c |  6 +----
 fs/hugetlbfs/inode.c                          |  2 +-
 14 files changed, 67 insertions(+), 45 deletions(-)

-- 
Catalin


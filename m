Return-Path: <linux-kernel+bounces-187326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20A8CD039
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC641C222DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F6149E1F;
	Thu, 23 May 2024 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/bUbSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34031411F7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459615; cv=none; b=ppF2xKvB69ScE8MVlAN4ba26nbcFVIO9BgSGjko/Cvh8PXM6u9GAVUiS2kQ2JLWZnD+22KmVWOnPdrYCYWKr/DpgCv5bEhyTplJO4gHc3DJizCfVT/kQ4jy4Q6edhR958XOpZnJzyazeoEfs5JnJYnTQ/u52KsfUXLFSJOu/BPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459615; c=relaxed/simple;
	bh=jjEQ0Wfdyd3FR/66IAorVhPKfpRRMpkT/lxow6xB/pU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jn2SI/62Eq1i5CT315WTxrzd8fFvKChaalPfcu5X3YorzDhV2eS2bu1gn6MY9JQUzB4lDJD4DfjqXHplOrLGQKiYw4GKX/9mSmhQLZzquoiDfvujKp7GccbjTdEiF9OjgKHsI2WLpWkMReyO0N3vfvgEp4dMRJiIun/vBd5gSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/bUbSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245D5C3277B;
	Thu, 23 May 2024 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716459615;
	bh=jjEQ0Wfdyd3FR/66IAorVhPKfpRRMpkT/lxow6xB/pU=;
	h=Date:From:To:Cc:Subject:From;
	b=fH/bUbSOEW60yF/H8RjGtbwG6wRulShrkVssujdv6MpkMj0CGlr+/BaDZg+/cKjiK
	 swGZ6+uBiErCoDqbX00ZhUSmCZM+ceIPgYUze/V9FsxXCu3k0TLeH8vK0LqsKS6giR
	 LdDULaFiOjW2rPd6OsmPK24kav+xdspwcyRFYzynV67mvPFCXuXHcpQxDvVTrFWRmL
	 WAzoT6jKlpfPwWZ/MJggobZTX0h9J/0rnutsEx29dhZVfiCmxSXamND8Yz9wauaif9
	 OeObzuHvsoHNKzuTjOAjjwG7NPjmGM0bXRVqjhJTcrpHiVLi9scA6M2jeEe8L81c5u
	 wX0pJuuA47s3A==
Date: Thu, 23 May 2024 11:20:10 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20240523102010.GA9168@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these arm64 fixes for -rc1. The major fix here is for a
filesystem corruption issue reported on Apple M1 as a result of buggy
management of the floating point register state introduced in 6.8. I
initially reverted one of the offending patches, but in the end Ard
cooked a proper fix so there's a revert+reapply in the series.

Aside from that, we've got some CPU errata workarounds and the rest is
summarised in the tag.

Cheers,

Will

--->8

The following changes since commit 54e1a2aa61a7bf4af2799baf7ab2dc2712844245:

  Merge branch 'for-next/tlbi' into for-next/core (2024-05-09 15:56:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to e92bee9f861b466c676f0200be3e46af7bc4ac6b:

  arm64/fpsimd: Avoid erroneous elide of user state reload (2024-05-22 12:46:39 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Fix broken FP register state tracking which resulted in filesystem
  corruption when dm-crypt is used

- Workarounds for Arm CPU errata affecting the SSBS Spectre mitigation

- Fix lockdep assertion in DMC620 memory controller PMU driver

- Fix alignment of BUG table when CONFIG_DEBUG_BUGVERBOSE is disabled

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/fpsimd: Avoid erroneous elide of user state reload

Jiangfeng Xiao (1):
      arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY

Mark Rutland (4):
      arm64: barrier: Restore spec_bar() macro
      arm64: cputype: Add Cortex-X4 definitions
      arm64: cputype: Add Neoverse-V3 definitions
      arm64: errata: Add workaround for Arm errata 3194386 and 3312417

Namhyung Kim (1):
      perf/arm-dmc620: Fix lockdep assert in ->event_init()

Will Deacon (3):
      Merge branch 'for-next/errata' into for-next/core
      Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"
      Reapply "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"

 Documentation/arch/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                          | 42 +++++++++++++++++++++++++++
 arch/arm64/include/asm/asm-bug.h            |  1 +
 arch/arm64/include/asm/barrier.h            |  4 +++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/include/asm/cputype.h            |  4 +++
 arch/arm64/kernel/cpu_errata.c              | 19 +++++++++++++
 arch/arm64/kernel/cpufeature.c              |  8 ++++++
 arch/arm64/kernel/fpsimd.c                  | 44 ++++++++++++++---------------
 arch/arm64/kernel/proton-pack.c             | 12 ++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 drivers/perf/arm_dmc620_pmu.c               |  9 ++++--
 12 files changed, 125 insertions(+), 25 deletions(-)


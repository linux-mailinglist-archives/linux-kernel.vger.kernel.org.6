Return-Path: <linux-kernel+bounces-263008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B293CFC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E77A28299C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B78176ACD;
	Fri, 26 Jul 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6oWrqV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B75177F11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983372; cv=none; b=GKYjp4iYc9Y+w0piP9th4WRps9b+dXld2OSRt8MN5ABJiLuyKxQkpp1Db38vbhD1iWGDW6u1xC77ZYwohhySQZjAaTof0mt2OUPAhOX+19d0g1CsiaZQvgtRVgbAemsWF7AbTEUx01wjqgCYPNTzrsyze/X9yo4YtfVr1hKrp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983372; c=relaxed/simple;
	bh=QoIuRi8CUUbIE/Yu4ehMOy0mc4yvmBGw7IUZWF5YBrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cu3OKo2PdVySwOMvYGx90uzT/WpkCknkxDkOMbbotWSYKqCfcjcAH0ldmhef3DlWopiC/F+RB3/M9LxCSqhNScD8cWOKWbls5PS6SuM1kTCnGKHv49mTh9CYADB9EowoUp3obn1YMhCIEYpTP/ixyMCFR5Ww44YnnRFAo2SJJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6oWrqV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D32C32782;
	Fri, 26 Jul 2024 08:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721983371;
	bh=QoIuRi8CUUbIE/Yu4ehMOy0mc4yvmBGw7IUZWF5YBrk=;
	h=Date:From:To:Cc:Subject:From;
	b=t6oWrqV12hqqRdZYluCVTkWqIMOpKlxd45ejC3mkC2K4OfeQN8EQX9kVS2tLRTSQi
	 DNZzbTq4/pDyJuTCMyMeTF6WXnON0eGbPoKDHSltAwqkxWhxkpj+xRfv1Z4XNdxC1/
	 9Y8AyoUo3ubYGAG26THMLGPVwHBZQF1mziL4JZvJUNv4iVUnCjkapGNg9QQtJ7ngbY
	 6rGoNBK1FMoV0HU5B/C3QtoJT+Nh3JhC5gD1wQwS2BUm7+ycBNNbSvWLuMyCs00CNr
	 B6gYO/bN2X/XtYIuNEqr6K00y281aP0aQnEkAkccXHM1RTwOysvFF6qvxtQOt3Ol0D
	 cbN5GlfuwRJpw==
Date: Fri, 26 Jul 2024 09:42:46 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc1
Message-ID: <20240726084246.GA29687@willie-the-truck>
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

Please pull these arm64 fixes for -rc1. The usual summary is in the tag,
but the main fix is for the fast GUP lockless page-table walk when we
have a combination of compile-time and run-time folding of the p4d and
the pud respectively.

Cheers,

Will

--->8

The following changes since commit 4f3a6c4de7d932be94cde2c52ae58feeec9c9dbf:

  Merge branch 'for-next/vcpu-hotplug' into for-next/core (2024-07-11 19:10:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 36639013b3462c06ff8e3400a427f775b4fc97f5:

  arm64: mm: Fix lockless walks with static and dynamic page-table folding (2024-07-25 13:20:55 +0100)

----------------------------------------------------------------
arm64 fixes for -rc1

- Remove some redundant Kconfig conditionals

- Fix string output in ptrace selftest

- Fix fast GUP crashes in some page-table configurations

- Remove obsolete linker option when building the vDSO

- Fix some sysreg field definitions for the GIC

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64/Kconfig: Remove redundant 'if HAVE_FUNCTION_GRAPH_TRACER'

Fangrui Song (1):
      arm64/vdso: Remove --hash-style=sysv

Masahiro Yamada (1):
      arm64: remove redundant 'if HAVE_ARCH_KASAN' in Kconfig

Raghavendra Rao Ananta (1):
      arm64/sysreg: Correct the values for GICv4.1

Remington Brasga (1):
      kselftest: missing arg in ptrace.c

Will Deacon (1):
      arm64: mm: Fix lockless walks with static and dynamic page-table folding

 arch/arm64/Kconfig                         |  8 ++++----
 arch/arm64/include/asm/pgtable.h           | 22 ++++++++++++++++++++++
 arch/arm64/kernel/vdso/Makefile            |  2 +-
 arch/arm64/kernel/vdso32/Makefile          |  2 +-
 arch/arm64/tools/sysreg                    |  4 ++--
 tools/testing/selftests/arm64/abi/ptrace.c |  2 +-
 6 files changed, 31 insertions(+), 9 deletions(-)


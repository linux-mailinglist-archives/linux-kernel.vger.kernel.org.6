Return-Path: <linux-kernel+bounces-272951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C289462B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405481F21E29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0425632;
	Fri,  2 Aug 2024 17:46:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95C1AE02E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620762; cv=none; b=qFsZKYMEL3x1DReBR9Or1BBqmxuwD2kAAIpFYtWX5lLxFus31LmmpB/U7Ho5Ew6lFoujOsvrSfn89zVw3c+y8nqLy2F+J9ytWMdC6DIHDeLfclnJ0ZBVL1cWuIlhH0QHMR1yg14pge4IBKzeLuODWd54EbvSE5pO5B4+eQk3T1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620762; c=relaxed/simple;
	bh=wXU781dYeKJR+lQwgY34xZnCbDfR3WTf0NaI2WZG+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DwBli1EdA3Ghp5YRuwpkayR9ZySFEUvxcGFXNX28Q2vxX73h99/sIdKajcpMd2brwySWwnzGVrIDoo32GRDK8h5fhE2eJv3M8ZSyS9oM96RvMrtlH8ElKfZAuKFpv05d6Momp2uSwatrMolETrK9N5xk1dWTCK9mPifXXrCiZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5525C32782;
	Fri,  2 Aug 2024 17:46:00 +0000 (UTC)
Date: Fri, 2 Aug 2024 18:45:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.11-rc2
Message-ID: <Zq0bVlue7gHx6oaz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to cfb00a35786414e7c0e6226b277d9f09657eae74:

  arm64: jump_label: Ensure patched jump_labels are visible to all CPUs (2024-08-02 15:07:01 +0100)

----------------------------------------------------------------
arm64 fixes:

- Expand the speculative SSBS errata workaround to more CPUs

- Ensure jump label changes are visible to all CPUs with a
  kick_all_cpus_sync() (and also enable jump label batching as part of
  the fix)

- The shadow call stack sanitiser is currently incompatible with Rust,
  make CONFIG_RUST conditional on !CONFIG_SHADOW_CALL_STACK

----------------------------------------------------------------
Alice Ryhl (1):
      rust: SHADOW_CALL_STACK is incompatible with Rust

Mark Rutland (3):
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Will Deacon (1):
      arm64: jump_label: Ensure patched jump_labels are visible to all CPUs

 Documentation/arch/arm64/silicon-errata.rst | 18 ++++++++++++++++++
 arch/arm64/Kconfig                          | 22 ++++++++++++++++------
 arch/arm64/include/asm/cputype.h            |  4 ++++
 arch/arm64/include/asm/jump_label.h         |  1 +
 arch/arm64/kernel/cpu_errata.c              | 11 ++++++++++-
 arch/arm64/kernel/jump_label.c              | 11 +++++++++--
 init/Kconfig                                |  1 +
 7 files changed, 59 insertions(+), 9 deletions(-)

-- 
Catalin


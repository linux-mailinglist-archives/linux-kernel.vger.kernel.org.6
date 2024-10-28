Return-Path: <linux-kernel+bounces-384103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550199B244D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A39B21BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197518C928;
	Mon, 28 Oct 2024 05:34:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63881DA5A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093683; cv=none; b=tZdHXjfziBE7ExjnobIlyWoO3BHjSQXZavM0C3Lv2OZrAduoG8wCGXrZMAdJQ4mWxF6RNI6d194CLCYctbBXkDSxnzFEwfsdHDbYGJyPB+HRynJkXmYpgSyEh3gCbAXYoPrmdj3zEF+yXfOoXO6kGfHUMCNDtorVZtnUyPWB+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093683; c=relaxed/simple;
	bh=ACtt5kqYmJZO6B2t8rgM/d2p645lg4GTKdOsCXsFcy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OToOFGavDmqTk5oH6Hk+4tG1qW4h/NTyDDzfHIUdGG/DEkbvm8d+WXCSKpszxxBsAQGeCNBMIwBpn/p9I7JqPlmQaZs0/5qizYoqJbhSaB1/zY/zmV+s6a8ZZCnnbjHQ2y4CvcNjHf9WK09bjN0hzQOkQKMF0XRd7gKF+FMLw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16FE497;
	Sun, 27 Oct 2024 22:35:07 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D7D03F66E;
	Sun, 27 Oct 2024 22:34:34 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev
Subject: [PATCH V2 0/7] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Date: Mon, 28 Oct 2024 11:04:19 +0530
Message-Id: <20241028053426.2486633-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables FEAT_Debugv8p9 thus extending breakpoint and watchpoint
support upto 64. This series is based on v6.12-rc5 although this depends on
FEAT_FGT2 FGU series posted earlier, for MDSELR_EL1 handling in various KVM
guest configurations.

https://lore.kernel.org/all/20241001024356.1096072-1-anshuman.khandual@arm.com/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Changes in V2:

Following changes have been made per review comments from Mark Rutland

- Orr MDCR_EL2_EBWE directly without an intermittent register
- Alphabetically order header files in debug-monitors.c
- Dropped embwe_ref_count mechanism
- Dropped preempt_enable() from AARCH64_DBG_READ
- Dropped preempt_disable() from AARCH64_DBG_WRITE
- Dropped set_bank_index()
- Renamed read/write_wb_reg() as __read/__write_wb_reg()
- Modified read/write_wb_reg() to have MDSELR_E1 based banked read/write
- Added required sysreg tools patches from KVM FEAT_FGT2 series for build

Changes in V1:

https://lore.kernel.org/all/20241001043602.1116991-1-anshuman.khandual@arm.com/

- Changed FTR_STRICT to FTR_NONSTRICT for the following ID_AA64DFR1_EL1
  register fields - ABL_CMPs, DPFZS, PMICNTR, CTX_CMPs, WRPs and BRPs

Changes in RFC V2:

https://lore.kernel.org/linux-arm-kernel/20240620092607.267132-1-anshuman.khandual@arm.com/

- This series has been split from RFC V1 dealing only with arm64 breakpoints
- Restored back DBG_MDSCR_MASK definition (unrelated change)
- Added preempt_disable()/enable() blocks between selecting banks and registers

Changes in RFC:

https://lore.kernel.org/all/20240405080008.1225223-1-anshuman.khandual@arm.com/

Anshuman Khandual (7):
  arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
  arm64/sysreg: Add register fields for MDSELR_EL1
  arm64/sysreg: Add register fields for HDFGRTR2_EL2
  arm64/sysreg: Add register fields for HDFGWTR2_EL2
  arm64/cpufeature: Add field details for ID_AA64DFR1_EL1 register
  arm64/boot: Enable EL2 requirements for FEAT_Debugv8p9
  arm64/hw_breakpoint: Enable FEAT_Debugv8p9

 Documentation/arch/arm64/booting.rst    | 19 +++++++
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/el2_setup.h      | 26 +++++++++
 arch/arm64/include/asm/hw_breakpoint.h  | 46 ++++++++++++----
 arch/arm64/include/asm/kvm_arm.h        |  1 +
 arch/arm64/kernel/cpufeature.c          | 21 ++++++--
 arch/arm64/kernel/debug-monitors.c      | 15 ++++--
 arch/arm64/kernel/hw_breakpoint.c       | 38 +++++++++++++-
 arch/arm64/tools/sysreg                 | 70 +++++++++++++++++++++++++
 9 files changed, 216 insertions(+), 21 deletions(-)

-- 
2.25.1



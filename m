Return-Path: <linux-kernel+bounces-446782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD69F2925
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380671885D61
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FF1BBBD7;
	Mon, 16 Dec 2024 04:08:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C8156F4A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322125; cv=none; b=DhmsyLLLMQRQXx01tN3PxtNI7NwTx/M6YNpHxYk/imFzeDSBhJ11cTIHyd351Z3bmZyKqupItkLa9bf1zlfqGMQTsIjQQHl3u9q/RjqXsCg+QQ3QNoLg/N15+wVmJqZ9uAJ6jJWMjebgcLW6xr9VQdU2xjOnlNxn/wuHepuNoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322125; c=relaxed/simple;
	bh=CZ4eSp91/4F2neH+q+SkUsBpnJbvHGgsDt3x692kCeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j/CAAzK7skm7W1aUesWmNjWC/z+1eJI1583lFl0siHa2GVVW9bILeQ/SyeZnnby8LPzDi/lTkVq+LifYykMPglk6B92zJ6i9Sc7h2fcc5ziQzRlBhPZkZ+MTLd/p/HVQ8ELbX+Wg6iplxviMfWv277QMf4BrQUIvt1XPdtnjIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 553B311FB;
	Sun, 15 Dec 2024 20:09:09 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AE0D3F58B;
	Sun, 15 Dec 2024 20:08:37 -0800 (PST)
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
Subject: [PATCH V3 0/7] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Date: Mon, 16 Dec 2024 09:38:24 +0530
Message-Id: <20241216040831.2448257-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables FEAT_Debugv8p9 thus extending breakpoint and watchpoint
support upto 64. This series is based on v6.13-rc3 although this depends on
FEAT_FGT2 FGU series posted earlier, for MDSELR_EL1 handling in various KVM
guest configurations.

https://lore.kernel.org/all/20241210055311.780688-3-anshuman.khandual@arm.com/

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

Changes in V3:

- Marked ID_AA64DFR1_EL1.ABLE as FTR_NONSTRICT in ftr_id_aa64dfr1[]
- Dropped MDCR_EL3.TDA boot requirement from documentation (separate series)
- Dropped MDCR_EL2_EBWE definition as MDCR_EL2 is now defined in tools sysreg
- Used SYS_FIELD_PREP() in read_wb_reg() and write_wb_reg()
- Added MAX_PER_BANK based BUILD_BUG_ON() tests in arch_hw_breakpoint_init()
- Dropped local variables i.e mdsel_bank and index
- Derived bank and index from MAX_PER_BANK as required

Changes in V2:

https://lore.kernel.org/all/20241028053426.2486633-1-anshuman.khandual@arm.com/

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

 Documentation/arch/arm64/booting.rst    | 18 +++++++
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/el2_setup.h      | 26 +++++++++
 arch/arm64/include/asm/hw_breakpoint.h  | 47 +++++++++++++----
 arch/arm64/kernel/cpufeature.c          | 21 ++++++--
 arch/arm64/kernel/debug-monitors.c      | 15 ++++--
 arch/arm64/kernel/hw_breakpoint.c       | 48 ++++++++++++++++-
 arch/arm64/tools/sysreg                 | 70 +++++++++++++++++++++++++
 8 files changed, 225 insertions(+), 21 deletions(-)

-- 
2.25.1



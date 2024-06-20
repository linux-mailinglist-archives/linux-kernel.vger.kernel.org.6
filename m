Return-Path: <linux-kernel+bounces-222125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA12F90FD28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E55E1F24D57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BD42076;
	Thu, 20 Jun 2024 06:58:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDB40861
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866702; cv=none; b=q46v+EFONlKV21KoKm76spGQunWtS7lomPrUA3uzugC3WmVQCpHfGzQwaMGD5v6EDvdZEmttkA9z1AY5iIiuL+sjqqs8P0dtzhUutC7+n+s1UivHnP8xXb8HSFXYJieSfz/9K0sc7f4f+qrr+avarIHV+TuOqygs/G9gV0hTVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866702; c=relaxed/simple;
	bh=1rR+8QkTlT15Poze9vyELDpz5YZygGThR/Hy7mySGVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BM/mnHi7CtIqxx21kNLS1GM4TwwNcVNFjbGWWMk/9ukZ4xrYqh3BcwNhWyogNIKU2eaOTdwXCUOHWWdF+K7tMPUJPO1GtX2p24dDV7foyTkl1R5oW22TDm3bLxrPe7xMk0ForhiPDVtw5DH8zSP8TfCyWZWR9sfBJgIb7T5XeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB1D4DA7;
	Wed, 19 Jun 2024 23:58:42 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 761973F73B;
	Wed, 19 Jun 2024 23:58:14 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 00/10] KVM: arm64: Enable fine grained undefined for MDSELR_EL1
Date: Thu, 20 Jun 2024 12:27:57 +0530
Message-Id: <20240620065807.151540-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MDSELR_EL1 register access is essential while enabling latest HW breakpoint
via the arch feature FEAT_DebugV8P9. During our previous discussion on this
[1], it was also observed that MDSELR_EL1 access needs to be managed across
various KVM host-guest code paths via the new fine grained trap based UNDEF
mechanism. Besides MDSELR_EL1 access is managed via FEAT_FGT2 based fine
grained registers.

This series has been carved out from the original breakpoint series just to
enable MSELR_EL1 access via fine grained trap control.

All the initial sysreg updates or additions are required while configuring
HDFGRTR2_EL2 and HDFGWTR2_EL2 registers in the last two patches.

This series has been very lightly tested - boots with KVM without warnings
or errors. I am not entirely sure how these fine grained bits would behave
in various paths. The idea is to get the series into discussion, learn and
change as required. All reviews, feedbacks and pointers really appreciated.

Questions and Challenges:

- TRBIDR_EL1.MPAM needs to be probed for setting HDFGRTR2_EL2_nTRBMPAM_EL1
  but kvm_has_feat() does not operate a non-ID register which causes build
  warnings. The same problem exists for probing PMSIDR_EL1.FDS which is
  needed for setting HDFGRTR2_EL2_nPMSDSFR_EL1 as well. Currently both the
  bits mentioned earlier are set, assuming the features are not present in
  nested virtualization. Do we need some new helpers to probe these non-ID
  registers as well ?

- At present both HDFGRTR2_EL2 and HDFGWTR2_EL2 based accesses are enabled
  (MDSELR_E1 was dependent on them) but then there are some more FEAT_FGT2
  registers such HFGRTR2_EL2, HFGWTR2_EL2 and HFGITR2_EL2. Should those be
  handled in this series as well ?

- Probably an entry is needed for SYS_MDSELR_EL1 in encoding_to_fgt[] table
  inside the file arch/arm64/kvm/emulate-nested.c, but while trying to test
  features for all individual bits in HDFGRTR2_EL2, it seemed a lot of new
  register definitions from various features need to be added as well, thus
  expanding the scope further. Should all required new system registers be
  added for completeness ?

[1] https://lore.kernel.org/all/20240405080008.1225223-1-anshuman.khandual@arm.com/

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (10):
  arm64/sysreg: Update ID_AA64MMFR0_EL1 register
  arm64/sysreg: Update ID_AA64DFR0_EL1 register
  arm64/sysreg: Add register fields for ID_AA64DFR2_EL1
  arm64/sysreg: Add register fields for HDFGRTR2_EL2
  arm64/sysreg: Add register fields for HDFGWTR2_EL2
  arm64/sysreg: Add register fields for MDSELR_EL1
  arm64/sysreg: Add register fields for PMSID_EL1
  arm64/sysreg: Add register fields for TRBIDR_EL1
  KVM: arm64: nv: Enable HDFGRTR2_EL2 & HDFGWTR2_EL2 access from virtual EL2
  KVM: arm64: nv: Add new HDFGRTR2_GROUP & HDFGRTR2_GROUP based FGU handling

 arch/arm64/include/asm/kvm_arm.h        |   8 ++
 arch/arm64/include/asm/kvm_host.h       |   5 ++
 arch/arm64/include/asm/vncr_mapping.h   |   2 +
 arch/arm64/kvm/emulate-nested.c         |  14 +++
 arch/arm64/kvm/hyp/include/hyp/switch.h |  10 +++
 arch/arm64/kvm/nested.c                 |  36 ++++++++
 arch/arm64/kvm/sys_regs.c               |  47 ++++++++++
 arch/arm64/tools/sysreg                 | 115 ++++++++++++++++++++++--
 8 files changed, 232 insertions(+), 5 deletions(-)

-- 
2.25.1



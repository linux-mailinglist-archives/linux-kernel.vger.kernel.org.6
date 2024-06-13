Return-Path: <linux-kernel+bounces-212613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A49063EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ADD2838F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C43137756;
	Thu, 13 Jun 2024 06:18:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74588136E1D;
	Thu, 13 Jun 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259494; cv=none; b=fn5VmDgmDN+XsyB2zBsc4dIEXm1dCJthll5hqkYl8neBEG0VEoxg+yYYGrAanqAfQ/CDl2A+rKXiPEBjiLFT3vcTxAHQq99ulkP+zf96zRkQ8A9VYGpO+CdRB6bDvQnXPdRVbzcnY86Z3z44bXeatxxHkzHIqy5HB1bXWYidiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259494; c=relaxed/simple;
	bh=qhBXhccKxvRUSEPkOSbWFc32meqmS1mdGjzuJrBVfoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3tXLrZzSOPbK9Nvsmv76OCyBhFJ5lxCWixROKMGoRHxD8MMsGyBrGctTnRCmAAsCfv/cIoZ9g2C8AVDA30Jaq1Tv6tcy/56VSDZIIAK50UaEvWe57rjyPvzjbkTmgWpIbua84K+DYMKV0tjFLYDT/qafCM2RYJo/I7A6dRHa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 647C81063;
	Wed, 12 Jun 2024 23:18:36 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.44.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A2AB3F5A1;
	Wed, 12 Jun 2024 23:18:05 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-doc@vger.kernel.org
Subject: [PATCH V18 4/9] arm64/boot: Enable EL2 requirements for BRBE
Date: Thu, 13 Jun 2024 11:47:26 +0530
Message-Id: <20240613061731.3109448-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613061731.3109448-1-anshuman.khandual@arm.com>
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fine grained trap control for BRBE registers, and instructions access need
to be configured in HDFGRTR_EL2, HDFGWTR_EL2 and HFGITR_EL2 registers when
kernel enters at EL1 but EL2 is present. This changes __init_el2_fgt() as
required.

Similarly cycle and mis-prediction capture need to be enabled in BRBCR_EL1
and BRBCR_EL2 when the kernel enters either into EL1 or EL2. This adds new
__init_el2_brbe() to achieve this objective.

This also updates Documentation/arch/arm64/booting.rst with all the above
EL2 along with MDRC_EL3.SBRBE requirements.

First this replaces an existing hard encoding (1 << 62) with corresponding
applicable macro HDFGRTR_EL2_nPMSNEVFR_EL1_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V18:

- Dropped ifdef CONFIG_ARM64_BRBE around __init_el2_brbe()
- Updated the in code comment around __init_el2_brbe()
- Dropped the write up for EL2->EL1 transition, moved up the EL3 write up

 Documentation/arch/arm64/booting.rst | 21 +++++++
 arch/arm64/include/asm/el2_setup.h   | 87 +++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..c8a17c021968 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -349,6 +349,27 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
 
+  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
+
+  - If EL3 is present:
+
+    - MDCR_EL3.SBRBE (bits 33:32) must be initialised to 0b11.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
+    - BRBCR_EL2.MPRED (bit 4) must be initialised to 0b1.
+
+    - HDFGRTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+    - HDFGRTR_EL2.nBRBIDR  (bit 59) must be initialised to 0b1.
+
+    - HDFGWTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
+    - HDFGWTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
+
+    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
+    - HFGITR_EL2.nBRBINJ  (bit 55) must be initialised to 0b1.
+
   For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
 
   - If EL3 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index fd87c4b8f984..1c7b131ad2be 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -155,6 +155,40 @@
 .Lskip_set_cptr_\@:
 .endm
 
+/*
+ * Enable BRBE to record cycle counts and branch mispredicts.
+ *
+ * At any EL, to record cycle counts BRBE requires that both
+ * BRBCR_EL2.CC=1 and BRBCR_EL1.CC=1.
+ *
+ * At any EL, to record branch mispredicts BRBE requires that both
+ * BRBCR_EL2.MPRED=1 and BRBCR_EL1.MPRED=1.
+ *
+ * When HCR_EL2.E2H=1, the BRBCR_EL1 encoding is redirected to
+ * BRBCR_EL2, but the {CC,MPRED} bits in the real BRBCR_EL1 register
+ * still apply.
+ *
+ * Set {CC,MPRBED} in both BRBCR_EL2 and BRBCR_EL1 so that at runtime we
+ * only need to enable/disable thse in BRBCR_EL1 regardless of whether
+ * the kernel ends up executing in EL1 or EL2.
+ */
+.macro __init_el2_brbe
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_\@
+
+	mov_q	x0, BRBCR_ELx_CC | BRBCR_ELx_MPRED
+	msr_s	SYS_BRBCR_EL2, x0
+
+	__check_hvhe .Lset_brbe_nvhe_\@, x1
+	msr_s	SYS_BRBCR_EL12, x0	// VHE
+	b	.Lskip_brbe_\@
+
+.Lset_brbe_nvhe_\@:
+	msr_s	SYS_BRBCR_EL1, x0	// NVHE
+.Lskip_brbe_\@:
+.endm
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -162,16 +196,48 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
 	b.lt	.Lset_debug_fgt_\@
+
 	/* Disable PMSNEVFR_EL1 read and write traps */
-	orr	x0, x0, #(1 << 62)
+	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lset_debug_fgt_\@:
+#ifdef CONFIG_ARM64_BRBE
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_reg_fgt_\@
+
+	/*
+	 * Disable read traps for the following registers
+	 *
+	 * [BRBSRC|BRBTGT|RBINF]_EL1
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
+
+	/*
+	 * Disable write traps for the following registers
+	 *
+	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
+	 */
+	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
+
+	/* Disable read and write traps for [BRBCR|BRBFCR]_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
+
+	/* Disable read traps for BRBIDR_EL1 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
+
+.Lskip_brbe_reg_fgt_\@:
+#endif /* CONFIG_ARM64_BRBE */
 	msr_s	SYS_HDFGRTR_EL2, x0
-	msr_s	SYS_HDFGWTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x2
 
 	mov	x0, xzr
 	mrs	x1, id_aa64pfr1_el1
@@ -194,7 +260,21 @@
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-	msr_s	SYS_HFGITR_EL2, xzr
+	mov	x0, xzr
+#ifdef CONFIG_ARM64_BRBE
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_insn_fgt_\@
+
+	/* Disable traps for BRBIALL instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBIALL_MASK
+
+	/* Disable traps for BRBINJ instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBINJ_MASK
+
+.Lskip_brbe_insn_fgt_\@:
+#endif /* CONFIG_ARM64_BRBE */
+	msr_s	SYS_HFGITR_EL2, x0
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
@@ -229,6 +309,7 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+	__init_el2_brbe
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__
-- 
2.25.1



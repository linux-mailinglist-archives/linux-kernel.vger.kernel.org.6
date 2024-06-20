Return-Path: <linux-kernel+bounces-222358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1438C910049
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173821C21D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6161F1A00F6;
	Thu, 20 Jun 2024 09:26:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D5A1A00D5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875594; cv=none; b=W5nGsdDxCxCB/tATv0i/W6MLV3r+21cpAX4PYgOuNDrKSkMFXmmsaIUC5ccyALs39rh/wNOfbdiUhJu4PQgju1vwYBaUciPRoShNdSn+l0G1jiLzM7OOZJaLspNZhVxU15aVikzy9CQ3lXqyPDuiM6VVrSe1CKB26HgSF+1rcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875594; c=relaxed/simple;
	bh=uEQgTpeI2KiK3xwmyb+NOVfGvR3oCgMSDiaJro7gRYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2hiF7VhPwqiAHtYAzNTCM9ZvQFFiHBpBEvDXTS0Z1pXO2Cd1GqLDlRPecKVUzaKIilFdulRK9mGGo4+KlAz+0Bb6rKh9opjaGYZ8V12ig6UerZF409DK40TREllLbihbBHMdoKoWRUQFEM1MKQ6ZLpun2CEwRckc/j0zTHaDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A29C6DA7;
	Thu, 20 Jun 2024 02:26:56 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 607863F6A8;
	Thu, 20 Jun 2024 02:26:27 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
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
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 3/3] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Date: Thu, 20 Jun 2024 14:56:07 +0530
Message-Id: <20240620092607.267132-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620092607.267132-1-anshuman.khandual@arm.com>
References: <20240620092607.267132-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there can be maximum 16 breakpoints, and 16 watchpoints available
on a given platform - as detected from ID_AA64DFR0_EL1.[BRPs|WRPs] register
fields. But these breakpoint, and watchpoints can be extended further up to
64 via a new arch feature FEAT_Debugv8p9.

This first enables banked access for the breakpoint and watchpoint register
set via MDSELR_EL1, extended exceptions via MDSCR_EL1.EMBWE and determining
available breakpoints and watchpoints in the platform from ID_AA64DFR1_EL1,
when FEAT_Debugv8p9 is enabled.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/hw_breakpoint.h  | 50 ++++++++++++++++++++-----
 arch/arm64/kernel/debug-monitors.c      | 16 ++++++--
 arch/arm64/kernel/hw_breakpoint.c       | 33 ++++++++++++++++
 4 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 13d437bcbf58..a14097673ae0 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -20,6 +20,7 @@
 #define DBG_MDSCR_KDE		(1 << 13)
 #define DBG_MDSCR_MDE		(1 << 15)
 #define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
+#define DBG_MDSCR_EMBWE		(1UL << 32)
 
 #define	DBG_ESR_EVT(x)		(((x) >> 27) & 0x7)
 
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index bd81cf17744a..362c4d4a64ac 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -79,8 +79,8 @@ static inline void decode_ctrl_reg(u32 reg,
  * Limits.
  * Changing these will require modifications to the register accessors.
  */
-#define ARM_MAX_BRP		16
-#define ARM_MAX_WRP		16
+#define ARM_MAX_BRP		64
+#define ARM_MAX_WRP		64
 
 /* Virtual debug register bases. */
 #define AARCH64_DBG_REG_BVR	0
@@ -94,13 +94,25 @@ static inline void decode_ctrl_reg(u32 reg,
 #define AARCH64_DBG_REG_NAME_WVR	wvr
 #define AARCH64_DBG_REG_NAME_WCR	wcr
 
+static inline bool is_debug_v8p9_enabled(void)
+{
+	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	int dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
+
+	return dver == ID_AA64DFR0_EL1_DebugVer_V8P9;
+}
+
 /* Accessor macros for the debug registers. */
 #define AARCH64_DBG_READ(N, REG, VAL) do {\
 	VAL = read_sysreg(dbg##REG##N##_el1);\
+	if (is_debug_v8p9_enabled())	\
+		preempt_enable();	\
 } while (0)
 
 #define AARCH64_DBG_WRITE(N, REG, VAL) do {\
 	write_sysreg(VAL, dbg##REG##N##_el1);\
+	if (is_debug_v8p9_enabled())	\
+		preempt_enable();	\
 } while (0)
 
 struct task_struct;
@@ -138,19 +150,37 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
-	return 1 +
-		cpuid_feature_extract_unsigned_field(dfr0,
-						ID_AA64DFR0_EL1_BRPs_SHIFT);
+	u64 dfr0, dfr1;
+	int dver, brps;
+
+	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
+	if (dver == ID_AA64DFR0_EL1_DebugVer_V8P9) {
+		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
+		brps = cpuid_feature_extract_unsigned_field_width(dfr1,
+								  ID_AA64DFR1_EL1_BRPs_SHIFT, 8);
+	} else {
+		brps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRPs_SHIFT);
+	}
+	return 1 + brps;
 }
 
 /* Determine number of WRP registers available. */
 static inline int get_num_wrps(void)
 {
-	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
-	return 1 +
-		cpuid_feature_extract_unsigned_field(dfr0,
-						ID_AA64DFR0_EL1_WRPs_SHIFT);
+	u64 dfr0, dfr1;
+	int dver, wrps;
+
+	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+	dver = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_DebugVer_SHIFT);
+	if (dver == ID_AA64DFR0_EL1_DebugVer_V8P9) {
+		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
+		wrps = cpuid_feature_extract_unsigned_field_width(dfr1,
+								  ID_AA64DFR1_EL1_WRPs_SHIFT, 8);
+	} else {
+		wrps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_WRPs_SHIFT);
+	}
+	return 1 + wrps;
 }
 
 #ifdef CONFIG_CPU_PM
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 64f2ecbdfe5c..3299d1e8dc61 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -23,6 +23,7 @@
 #include <asm/debug-monitors.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
+#include <asm/hw_breakpoint.h>
 
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
@@ -34,7 +35,7 @@ u8 debug_monitors_arch(void)
 /*
  * MDSCR access routines.
  */
-static void mdscr_write(u32 mdscr)
+static void mdscr_write(u64 mdscr)
 {
 	unsigned long flags;
 	flags = local_daif_save();
@@ -43,7 +44,7 @@ static void mdscr_write(u32 mdscr)
 }
 NOKPROBE_SYMBOL(mdscr_write);
 
-static u32 mdscr_read(void)
+static u64 mdscr_read(void)
 {
 	return read_sysreg(mdscr_el1);
 }
@@ -76,10 +77,11 @@ early_param("nodebugmon", early_debug_disable);
  */
 static DEFINE_PER_CPU(int, mde_ref_count);
 static DEFINE_PER_CPU(int, kde_ref_count);
+static DEFINE_PER_CPU(int, embwe_ref_count);
 
 void enable_debug_monitors(enum dbg_active_el el)
 {
-	u32 mdscr, enable = 0;
+	u64 mdscr, enable = 0;
 
 	WARN_ON(preemptible());
 
@@ -90,6 +92,9 @@ void enable_debug_monitors(enum dbg_active_el el)
 	    this_cpu_inc_return(kde_ref_count) == 1)
 		enable |= DBG_MDSCR_KDE;
 
+	if (is_debug_v8p9_enabled() && this_cpu_inc_return(embwe_ref_count) == 1)
+		enable |= DBG_MDSCR_EMBWE;
+
 	if (enable && debug_enabled) {
 		mdscr = mdscr_read();
 		mdscr |= enable;
@@ -100,7 +105,7 @@ NOKPROBE_SYMBOL(enable_debug_monitors);
 
 void disable_debug_monitors(enum dbg_active_el el)
 {
-	u32 mdscr, disable = 0;
+	u64 mdscr, disable = 0;
 
 	WARN_ON(preemptible());
 
@@ -111,6 +116,9 @@ void disable_debug_monitors(enum dbg_active_el el)
 	    this_cpu_dec_return(kde_ref_count) == 0)
 		disable &= ~DBG_MDSCR_KDE;
 
+	if (is_debug_v8p9_enabled() && this_cpu_dec_return(embwe_ref_count) == 0)
+		disable &= ~DBG_MDSCR_EMBWE;
+
 	if (disable) {
 		mdscr = mdscr_read();
 		mdscr &= disable;
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 722ac45f9f7b..30156d732284 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -103,10 +103,40 @@ int hw_breakpoint_slots(int type)
 	WRITE_WB_REG_CASE(OFF, 14, REG, VAL);	\
 	WRITE_WB_REG_CASE(OFF, 15, REG, VAL)
 
+static int set_bank_index(int n)
+{
+	int mdsel_bank;
+	int bank = n / 16, index = n % 16;
+
+	switch (bank) {
+	case 0:
+		mdsel_bank = MDSELR_EL1_BANK_BANK_0;
+		break;
+	case 1:
+		mdsel_bank = MDSELR_EL1_BANK_BANK_1;
+		break;
+	case 2:
+		mdsel_bank = MDSELR_EL1_BANK_BANK_2;
+		break;
+	case 3:
+		mdsel_bank = MDSELR_EL1_BANK_BANK_3;
+		break;
+	default:
+		pr_warn("Unknown register bank %d\n", bank);
+	}
+	preempt_disable();
+	write_sysreg_s(mdsel_bank << MDSELR_EL1_BANK_SHIFT, SYS_MDSELR_EL1);
+	isb();
+	return index;
+}
+
 static u64 read_wb_reg(int reg, int n)
 {
 	u64 val = 0;
 
+	if (is_debug_v8p9_enabled())
+		n = set_bank_index(n);
+
 	switch (reg + n) {
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, val);
@@ -122,6 +152,9 @@ NOKPROBE_SYMBOL(read_wb_reg);
 
 static void write_wb_reg(int reg, int n, u64 val)
 {
+	if (is_debug_v8p9_enabled())
+		n = set_bank_index(n);
+
 	switch (reg + n) {
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BVR, AARCH64_DBG_REG_NAME_BVR, val);
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_BCR, AARCH64_DBG_REG_NAME_BCR, val);
-- 
2.25.1



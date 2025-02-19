Return-Path: <linux-kernel+bounces-521800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C404A3C26C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD013A3B01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25439189906;
	Wed, 19 Feb 2025 14:46:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E917591
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976379; cv=none; b=gjzgHz8P5TQmvri+wlgQZ2/96SSWAlp0LeoB0oYGYdhrCw7fZLx579efWMgEGBLX8Hjwk9WYvyP3lhaD5reE+t7NTG9+W6Y8WcQzsvhj1xppFOmZlyl19VONUawhWowWvNzsqZzz9BiHTbJEEaeyCQMIGGaEmbRUrDAjT94kX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976379; c=relaxed/simple;
	bh=hCZPyxqh7mttYLa+Xb0xJvTh7QAvZGdDsyI13t7V/WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVN1q3SjHGU8j81RhuL2glb4uF0mmETKeNJDR4jUgWAQso6fT/AFDS2Xo2RieWEMbG6fXYcLFQiCmpBzZqs5LS8R5nMaQJ+ZGmuI7BPLCmMFXpsrJa+LYwMeJMpE7hgU3o1auSuZt/hYo26GHnzsFOSFuaL6QjcAqix8cKQkWQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE1C13D5;
	Wed, 19 Feb 2025 06:46:34 -0800 (PST)
Received: from mazurka.cambridge.arm.com (mazurka.cambridge.arm.com [10.2.80.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3DF3F59E;
	Wed, 19 Feb 2025 06:46:13 -0800 (PST)
From: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	joey.gouly@arm.com,
	broonie@kernel.org,
	mark.rutland@arm.com,
	james.morse@arm.com,
	yangyicong@hisilicon.com,
	robin.murphy@arm.com,
	anshuman.khandual@arm.com,
	maz@kernel.org,
	liaochang1@huawei.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	oliver.upton@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>
Subject: [PATCH v1 1/3] arm64: Add BBM Level 2 cpu feature
Date: Wed, 19 Feb 2025 14:38:38 +0000
Message-ID: <20250219143837.44277-5-miko.lenczewski@arm.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250219143837.44277-3-miko.lenczewski@arm.com>
References: <20250219143837.44277-3-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Break-Before-Make cpu feature supports multiple levels (levels 0-2),
and this commit adds a dedicated BBML2 cpufeature to test against
support for.

This is a system feature as we might have a big.LITTLE architecture
where some cores support BBML2 and some don't, but we want all cores to
be available and BBM to default to level 0 (as opposed to having cores
without BBML2 not coming online).

To support BBML2 in as wide a range of contexts as we can, we want not
only the architectural guarantees that BBML2 makes, but additionally
want BBML2 to not create TLB conflict aborts. Not causing aborts avoids
us having to prove that no recursive faults can be induced in any path
that uses BBML2, allowing its use for arbitrary kernel mappings.
Support detection of such CPUs.

Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
---
 arch/arm64/Kconfig                  |  9 ++++++++
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/kernel/cpufeature.c      | 32 +++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 4 files changed, 47 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..84be2c5976f0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2057,6 +2057,15 @@ config ARM64_TLB_RANGE
 	  The feature introduces new assembly instructions, and they were
 	  support when binutils >= 2.30.
 
+config ARM64_ENABLE_BBML2
+	bool "Enable support for Break-Before-Make Level 2 detection and usage"
+	default y
+	help
+	  FEAT_BBM provides detection of support levels for break-before-make
+	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
+	  can be relaxed to improve performance. Selecting N causes the kernel to
+	  fallback to BBM level 0 behaviour even if the system supports BBM level 2.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e0e4478f5fb5..2da872035f2e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -866,6 +866,11 @@ static __always_inline bool system_supports_mpam_hcr(void)
 	return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
 }
 
+static inline bool system_supports_bbml2_noconflict(void)
+{
+	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOCONFLICT);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d561cf3b8ac7..8c337bd95ef7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2176,6 +2176,31 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
+static bool has_bbml2_noconflict(const struct arm64_cpu_capabilities *entry,
+				 int scope)
+{
+	if (!IS_ENABLED(CONFIG_ARM64_ENABLE_BBML2))
+		return false;
+
+	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
+	 * as possible. This list is therefore an allow-list of known-good
+	 * implementations that both support bbml2 and additionally, fulfil the
+	 * extra constraint of never generating TLB conflict aborts when using
+	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
+	 * kernel contexts difficult to prove safe against recursive aborts).
+	 */
+	static const struct midr_range supports_bbml2_without_abort_list[] = {
+		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
+		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		{}
+	};
+
+	if (!is_midr_in_range_list(read_cpuid_id(), supports_bbml2_without_abort_list))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_ARM64_PAN
 static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
@@ -2926,6 +2951,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
 	},
+	{
+		.desc = "BBM Level 2 without conflict abort",
+		.capability = ARM64_HAS_BBML2_NOCONFLICT,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_bbml2_noconflict,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, BBM, 2)
+	},
 	{
 		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
 		.capability = ARM64_HAS_LPA2,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1e65f2fb45bd..8d67bb4448c5 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -26,6 +26,7 @@ HAS_ECV
 HAS_ECV_CNTPOFF
 HAS_EPAN
 HAS_EVT
+HAS_BBML2_NOCONFLICT
 HAS_FPMR
 HAS_FGT
 HAS_FPSIMD
-- 
2.45.3



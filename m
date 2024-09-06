Return-Path: <linux-kernel+bounces-318504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6D96EED0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF46AB22D44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E3A1C7B7C;
	Fri,  6 Sep 2024 09:08:19 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860F1C7B7B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613699; cv=none; b=G8Zx31YK1FYoJ/yEpn+v1hb2CT//yVzYQvYWP8a+2BpygIzd/ciL/QOubuO+sLJ3rHrZ/DxKz8YrErbKPYcjz80ae56thHgEH9h4aU4ZfkWD9BJXTnFzS3bmquHeuqBoDu7BOzrTV5Xs+G37uhNGmq7S5JQzLKMXfm0R+gJlttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613699; c=relaxed/simple;
	bh=qnuBpvBJKRT0oWFfMDjxDQZx6/JApDX2yPGstg7ufDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocrVMERFd1LU6tb8eb9ECW/V7bLuFOWDWMPDZQmAyRByHCQBUvOzX2FyXmTSIIzPuo/tf1MmcCY/DhNUSy5lEF2TXWWHSCj7GBbUeZxHlAw/x8XjIIQFzpXxhzu1FzmRJl5mHBEUbOuS9JOSC4vVhyOQQwFtaR3VTVhbDufyzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0VkG57Ntz2DbrQ;
	Fri,  6 Sep 2024 17:07:50 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id 876191402DE;
	Fri,  6 Sep 2024 17:08:13 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 17:08:13 +0800
From: Tian Tao <tiantao6@hisilicon.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
Subject: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
Date: Fri, 6 Sep 2024 17:08:12 +0800
Message-ID: <20240906090812.249473-1-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100009.china.huawei.com (7.202.181.223)

When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
full name of the Not-aligned access. nAA bit has two values:
0b0 Unaligned accesses by the specified instructions generate an
Alignment fault.
0b1 Unaligned accesses by the specified instructions do not generate
an Alignment fault.

this patch sets the nAA bit to 1,The following instructions will not
generate an Alignment fault if all bytes being accessed are not within
a single 16-byte quantity:
• LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
LDLARH.
• STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 arch/arm64/Kconfig              | 10 ++++++++++
 arch/arm64/include/asm/sysreg.h |  1 +
 arch/arm64/kernel/cpufeature.c  | 18 ++++++++++++++++++
 arch/arm64/tools/cpucaps        |  1 +
 4 files changed, 30 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 77d7ef0b16c2..7afe73ebcd79 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2023,6 +2023,16 @@ config ARM64_TLB_RANGE
 	  The feature introduces new assembly instructions, and they were
 	  support when binutils >= 2.30.
 
+config ARM64_LSE2_NAA
+	bool "Enable support for not-aligned access"
+	depends on AS_HAS_ARMV8_4
+	help
+	 LSE2 is an extension to the original LSE (Large System Extensions) feature,
+	 introduced in ARMv8.4.
+
+	 Enable this feature will not generate an Alignment fault if all bytes being
+	 accessed are not within a single 16-byte quantity.
+
 endmenu # "ARMv8.4 architectural features"
 
 menu "ARMv8.5 architectural features"
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 8cced8aa75a9..42e3a1959aa8 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -854,6 +854,7 @@
 #define SCTLR_ELx_ENDB	 (BIT(13))
 #define SCTLR_ELx_I	 (BIT(12))
 #define SCTLR_ELx_EOS	 (BIT(11))
+#define SCTLR_ELx_nAA    (BIT(6))
 #define SCTLR_ELx_SA	 (BIT(3))
 #define SCTLR_ELx_C	 (BIT(2))
 #define SCTLR_ELx_A	 (BIT(1))
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 646ecd3069fd..558869a7c7f0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2299,6 +2299,14 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_MTE */
 
+#ifdef CONFIG_ARM64_LSE2_NAA
+static void cpu_enable_lse2(const struct arm64_cpu_capabilities *__unused)
+{
+	sysreg_clear_set(sctlr_el2, SCTLR_ELx_nAA, SCTLR_ELx_nAA);
+	isb();
+}
+#endif
+
 static void user_feature_fixup(void)
 {
 	if (cpus_have_cap(ARM64_WORKAROUND_2658417)) {
@@ -2427,6 +2435,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
 	},
 #endif /* CONFIG_ARM64_LSE_ATOMICS */
+#ifdef CONFIG_ARM64_LSE2_NAA
+	{
+		.desc = "Support for not-aligned access",
+		.capability = ARM64_HAS_LSE2,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_lse2,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, AT, IMP)
+	},
+#endif
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index ac3429d892b9..0c7c0a293574 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -41,6 +41,7 @@ HAS_HCX
 HAS_LDAPR
 HAS_LPA2
 HAS_LSE_ATOMICS
+HAS_LSE2
 HAS_MOPS
 HAS_NESTED_VIRT
 HAS_PAN
-- 
2.33.0



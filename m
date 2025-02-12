Return-Path: <linux-kernel+bounces-511603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C472A32D27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369673A8933
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB3255E42;
	Wed, 12 Feb 2025 17:14:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93A271838
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380488; cv=none; b=gepmJ3q9QQw2XPe0BYhu+KxkEc0uewJzGgZfaGeY4XtCPev/p8/hVB7Ld2l+UQI+T+HN3Z8kZdojki9Yj+pYIZPuX8Ri5UxfmnOFO6Yeq0bIrV6b5qT2XDCKM/dKpU22NM22sGZVydSeH1ph81e7SlzivxCzdViRwGngdtssGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380488; c=relaxed/simple;
	bh=HzSGEJK1BpqiQvMvM6l0nyeKuVJ2vdebfzELWH1iLws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBser9/Mb5qLakUuHdYmQlq5hVjiAEEG90Emh1UZEEJwtYtpmwxVI7PjeWwlcy7Gbh6A2Mk4Weqg37OG8a0TZDbvi6rET9lFWf8v4lP9nvF9oMO2fkvoopeKUk9+MbXvgDb9Wj4uEonehgQ+Tb/LFF2XB5xvhjnJSK9zbxoGYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B62F012FC;
	Wed, 12 Feb 2025 09:15:06 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F28E3F5A1;
	Wed, 12 Feb 2025 09:14:44 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: will@kernel.org,
	maz@kernel.org,
	catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	aneesh.kumar@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/1] arm64: realm: Use aliased addresses for device DMA to shared buffers
Date: Wed, 12 Feb 2025 17:14:11 +0000
Message-ID: <20250212171411.951874-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212171411.951874-1-suzuki.poulose@arm.com>
References: <20250212171411.951874-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device performs DMA to a shared buffer using physical addresses,
(without Stage1 translation), the device must use the "{I}PA address" with the
top bit set in Realm. This is to make sure that a trusted device will be able
to write to shared buffers as well as the protected buffers. Thus, a Realm must
always program the full address including the "protection" bit, like AMD SME
encryption bits.

Add the support for this by providing arm64 version of the phys_to_dma(). We
cannot use the __sme_mask as it assumes the "encryption" always "sets a bit",
which is the opposite for CCA. i.e., "set a bit" for "decrypted" address. So,
move the common code that can be reused by all - i.e., add __phys_to_dma() and
__dma_to_phys() - and do the arch specific processing.

Please note that the VMM needs to similarly make sure that the SMMU Stage2 in
the Non-secure world is setup accordingly to map IPA at the unprotected alias.

Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/dma-direct.h | 38 +++++++++++++++++++++++++++++
 include/linux/dma-direct.h          | 35 +++++++++++++++++---------
 3 files changed, 62 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..7befe04106de 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -41,6 +41,7 @@ config ARM64
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
+	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 000000000000..37c3270542b8
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_DMA_DIRECT_H
+#define __ASM_DMA_DIRECT_H
+
+#include <asm/pgtable-prot.h>
+
+static inline unsigned long addr_to_shared(unsigned long addr)
+{
+	if (is_realm_world())
+		addr |= prot_ns_shared;
+	return addr;
+}
+
+static inline unsigned long addr_to_private(unsigned long addr)
+{
+	if (is_realm_world())
+		addr &= prot_ns_shared - 1;
+	return addr;
+}
+
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return __phys_to_dma(dev, paddr);
+}
+
+static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
+						 phys_addr_t paddr)
+{
+	return addr_to_shared(__phys_to_dma(dev, paddr));
+}
+#define phys_to_dma_unencrypted phys_to_dma_unencrypted
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	return addr_to_private(__dma_to_phys(dev, dma_addr));
+}
+
+#endif	/* __ASM_DMA_DIRECT_H */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d7e30d4f7503..3e9bf6ca640e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -72,18 +72,36 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
 	return ret;
 }
 
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	if (dev->dma_range_map)
+		return translate_phys_to_dma(dev, paddr);
+	return paddr;
+}
+
+static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
+{
+	phys_addr_t paddr;
+
+	if (dev->dma_range_map)
+		paddr = translate_dma_to_phys(dev, dma_addr);
+	else
+		paddr = dma_addr;
+
+	return paddr;
+}
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #ifndef phys_to_dma_unencrypted
 #define phys_to_dma_unencrypted		phys_to_dma
 #endif
 #else
+
 static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 		phys_addr_t paddr)
 {
-	if (dev->dma_range_map)
-		return translate_phys_to_dma(dev, paddr);
-	return paddr;
+	return __phys_to_dma(dev, paddr);
 }
 
 /*
@@ -94,19 +112,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
+	return __sme_set(__phys_to_dma(dev, paddr));
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
-	phys_addr_t paddr;
-
-	if (dev->dma_range_map)
-		paddr = translate_dma_to_phys(dev, dma_addr);
-	else
-		paddr = dma_addr;
-
-	return __sme_clr(paddr);
+	return __sme_clr(__dma_to_phys(dev, dma_addr));
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
-- 
2.43.0



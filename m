Return-Path: <linux-kernel+bounces-536619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36289A48237
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BF19C33C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535223CEF9;
	Thu, 27 Feb 2025 14:42:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5E23C8AA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667330; cv=none; b=gfFz5o//PRvEjHn4jYkdFYhkLXcF8ETd15O3Dqay86iZMadLW2gtp9HiVKUOp9Nk/UxcjklyDTBnN9KpluHTlzXfGAUYca3q1/lo5JRYHXgJTipmNy03a4lcZRwbXm2brI6xJ1FfrCYvTOJ7YLhzRSKfklP5sxknM47X8c856+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667330; c=relaxed/simple;
	bh=+tRGgKNs/lw69/8JOfyQngAEocgcBi+SMzNEREVm+ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egwE/hqOzD+oyn9ByNxnyF6eSbv6PKtc5d6MrkHy+f0Oxn52Fu4wpczZbuBk8NVctfEdOV6ysWy3fCBxJhNtt8p1J+ZyvM1ohfO8drNwo24y1MBgKiQrq2Qg4nz/Qzrnd6wEpPXwpFXSiKipEjhY0+p9w4Vtgz3i+Xk/vBarKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D21B2C3A;
	Thu, 27 Feb 2025 06:42:24 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 095A53F673;
	Thu, 27 Feb 2025 06:42:06 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-kernel@vger.kernel.org
Cc: will@kernel.org,
	catalin.marinas@arm.com,
	maz@kernel.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	gshan@redhat.com,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/3] dma: Introduce generic dma_addr_*crypted helpers
Date: Thu, 27 Feb 2025 14:41:49 +0000
Message-ID: <20250227144150.1667735-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227144150.1667735-1-suzuki.poulose@arm.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD SME added __sme_set/__sme_clr primitives to modify the DMA address for
encrypted/decrypted traffic. However this doesn't fit in with other models,
e.g., Arm CCA where the meanings are the opposite. i.e., "decrypted" traffic
has a bit set and "encrypted" traffic has the top bit cleared.

In preparation for adding the support for Arm CCA DMA conversions, convert the
existing primitives to more generic ones that can be provided by the backends.
i.e., add helpers to
 1. dma_addr_encrypted - Convert a DMA address to "encrypted" [ == __sme_set() ]
 2. dma_addr_unencrypted - Convert a DMA address to "decrypted" [ None exists today ]
 3. dma_addr_canonical - Clear any "encryption"/"decryption" bits from DMA
    address [ SME uses __sme_clr() ] and convert to a canonical DMA address.

Since the original __sme_xxx helpers come from linux/mem_encrypt.h, use that
as the home for the new definitions and provide dummy ones when none is provided
by the architectures.

With the above, phys_to_dma_unencrypted() uses the newly added dma_addr_unencrypted()
helper and to make it a bit more easier to read and avoid double conversion,
provide __phys_to_dma().

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
 - Rename helpers- s/dma_*crypted/dma_addr_*crypted (Robin)
---
 include/linux/dma-direct.h  | 12 ++++++++----
 include/linux/mem_encrypt.h | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d20ecc24cb0f..f3bc0bcd7098 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -78,14 +78,18 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
 #define phys_to_dma_unencrypted		phys_to_dma
 #endif
 #else
-static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
-		phys_addr_t paddr)
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (dev->dma_range_map)
 		return translate_phys_to_dma(dev, paddr);
 	return paddr;
 }
 
+static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
+						phys_addr_t paddr)
+{
+	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
+}
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.
@@ -94,14 +98,14 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
+	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	phys_addr_t paddr;
 
-	dma_addr = __sme_clr(dma_addr);
+	dma_addr = dma_addr_canonical(dma_addr);
 	if (dev->dma_range_map)
 		paddr = translate_dma_to_phys(dev, dma_addr);
 	else
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index ae4526389261..07584c5e36fb 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -26,11 +26,34 @@
  */
 #define __sme_set(x)		((x) | sme_me_mask)
 #define __sme_clr(x)		((x) & ~sme_me_mask)
+
+#define dma_addr_encrypted(x)	__sme_set(x)
+#define dma_addr_canonical(x)	__sme_clr(x)
+
 #else
 #define __sme_set(x)		(x)
 #define __sme_clr(x)		(x)
 #endif
 
+/*
+ * dma_addr_encrypted() and dma_addr_unencrypted() are for converting a given DMA
+ * address to the respective type of addressing.
+ *
+ * dma_addr_canonical() is used to reverse any conversions for encrypted/decrypted
+ * back to the canonical address.
+ */
+#ifndef dma_addr_encrypted
+#define dma_addr_encrypted(x)		(x)
+#endif
+
+#ifndef dma_addr_unencrypted
+#define dma_addr_unencrypted(x)		(x)
+#endif
+
+#ifndef dma_addr_canonical
+#define dma_addr_canonical(x)		(x)
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
-- 
2.43.0



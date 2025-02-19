Return-Path: <linux-kernel+bounces-522589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5920CA3CC15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F443BAC67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C303235341;
	Wed, 19 Feb 2025 22:09:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175932586D8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002981; cv=none; b=gPTJ6HEws69mlV9y8MapzoQKEc0orOHMMWOViKKidpc6rM81rowDuv+YqX5kf722Jqc5LAkVTsKCHnrRKAIUX8NReJM4fkuYFtGY6NHuWlF9eXvq5RCBUvPyO4rp2tpiCRdLNqxdcsb6ANTV07x5nizlH/Ly/6NA82kGLe+YHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002981; c=relaxed/simple;
	bh=LZiM/rdW7XeXRPfAUGBlEYO6/j16zSj8soDjaY+L7k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/iWURsQ3seOqu/LnTCzptKbesmS2TiavBq7Enl1lckGPyoI/BQe28JRXqjIDL3Eett84fML3PBfT26+eYJxeR8Kx0yHZclLFmunlMw1En2K/MeUEYNoxkjF8vdMqQ5/oGgGOvqN7JRNWFFGOJAxrOM2fL+4mDPA0FqbnnTNd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA64B1595;
	Wed, 19 Feb 2025 14:09:57 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D106D3F6A8;
	Wed, 19 Feb 2025 14:09:37 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	catalin.marinas@arm.com
Cc: maz@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	aneesh.kumar@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 2/3] dma: Introduce generic dma_decrypted/dma_encrypted helpers
Date: Wed, 19 Feb 2025 22:07:50 +0000
Message-ID: <20250219220751.1276854-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219220751.1276854-1-suzuki.poulose@arm.com>
References: <20250219220751.1276854-1-suzuki.poulose@arm.com>
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
 1. dma_encrypted - Convert a DMA address to "encrypted" [ == __sme_set() ]
 2. dma_decrypted - Convert a DMA address to "decrypted" [ None exists today ]
 3. dma_clear_encryption - Clear any "encryption"/"decryption" bits from DMA
    address [ SME uses __sme_clr() ]

Since the original __sme_xxx helpers come from linux/mem_encrypt.h, use that
as the home for the new definitions and provide dummy ones when none is provided
by the architectures.

With the above, phys_to_dma_unencrypted() uses the newly added dma_decrypted()
helper and to make it a bit more easier to read and avoid double conversion,
provide __phys_to_dma().

No functional changes intended. Compile tested on x86 defconfig with
CONFIG_AMD_MEM_ENCRYPT.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/dma-direct.h  | 12 ++++++++----
 include/linux/mem_encrypt.h | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d20ecc24cb0f..9b5cc0ee86d5 100644
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
+	return dma_decrypted(__phys_to_dma(dev, paddr));
+}
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.
@@ -94,14 +98,14 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
  */
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __sme_set(phys_to_dma_unencrypted(dev, paddr));
+	return dma_encrypted(__phys_to_dma(dev, paddr));
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	phys_addr_t paddr;
 
-	dma_addr = __sme_clr(dma_addr);
+	dma_addr = dma_clear_encryption(dma_addr);
 	if (dev->dma_range_map)
 		paddr = translate_dma_to_phys(dev, dma_addr);
 	else
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index ae4526389261..c8dcc1be695a 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -26,11 +26,34 @@
  */
 #define __sme_set(x)		((x) | sme_me_mask)
 #define __sme_clr(x)		((x) & ~sme_me_mask)
+
+#define dma_encrypted(x)	__sme_set(x)
+#define dma_clear_encryption(x)	__sme_clr(x)
+
 #else
 #define __sme_set(x)		(x)
 #define __sme_clr(x)		(x)
 #endif
 
+/*
+ * dma_encrypted() and dma_decrypted() are for converting a given DMA
+ * address to the respective type of addressing.
+ *
+ * dma_clear_encryption() is used to reverse the conversion back to "normal"
+ * DMA address.
+ */
+#ifndef dma_encrypted
+#define dma_encrypted(x)	(x)
+#endif
+
+#ifndef dma_decrypted
+#define dma_decrypted(x)	(x)
+#endif
+
+#ifndef dma_clear_encryption
+#define dma_clear_encryption(x)	(x)
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
-- 
2.43.0



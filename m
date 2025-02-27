Return-Path: <linux-kernel+bounces-536620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83578A48232
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E159317A83F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470023C8AA;
	Thu, 27 Feb 2025 14:42:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA123CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667332; cv=none; b=O075WmCzlm3dwAaya9LSg+UNbYArR4HR8h74mvAwx4jsCJWh46d/h1GZqvl4z/2Ef3cV8GEZSynCbXUgkmOa9dlFQV9B5Cj/Iy3GOaNP5xhbhqjo4ClgPpvdopPsi0LMWa1lPgI99PX80ZFWciG4nE/sM3GNkOZHcU9aiCWoBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667332; c=relaxed/simple;
	bh=KGfjGgNglULtwKNBSYbC76MripoE1VrbD6UN9FeUQhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHCPR7nYb4jJ9CSan7WK8Dm90vs919zaQn/e9kiM3xzFw2nIjZAa+e27zubv8+HFETtaXwJa5Ze33P9cqV0SyrDfR7AGf5L3RzfP4S/l6ANI8mo/mvUnwMVER99pNXOPV9oExsAZ4jJR455T1BUhTJxBNVKX+28Mgb/Je+E/myI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A722C3D;
	Thu, 27 Feb 2025 06:42:26 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E88453F673;
	Thu, 27 Feb 2025 06:42:08 -0800 (PST)
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
Subject: [PATCH v3 3/3] arm64: realm: Use aliased addresses for device DMA to shared buffers
Date: Thu, 27 Feb 2025 14:41:50 +0000
Message-ID: <20250227144150.1667735-4-suzuki.poulose@arm.com>
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

When a device performs DMA to a shared buffer using physical addresses,
(without Stage1 translation), the device must use the "{I}PA address" with the
top bit set in Realm. This is to make sure that a trusted device will be able
to write to shared buffers as well as the protected buffers. Thus, a Realm must
always program the full address including the "protection" bit, like AMD SME
encryption bits.

Enable this by providing arm64 specific dma_addr_{encrypted, canonical}
helpers for Realms. Please note that the VMM needs to similarly make sure that
the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
unprotected alias.

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
 - Drop dma_addr_encrypted() helper, which is a NOP for CCA ( Aneesh )
 - Only mask the "top" IPA bit and not all the bits beyond top bit. ( Robin )
 - Use PROT_NS_SHARED, now that we only set/clear top bit. (Gavin)
---
 arch/arm64/include/asm/mem_encrypt.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index f8f78f622dd2..a2a1eeb36d4b 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -21,4 +21,15 @@ static inline bool force_dma_unencrypted(struct device *dev)
 	return is_realm_world();
 }
 
+/*
+ * For Arm CCA guests, canonical addresses are "encrypted", so no changes
+ * required for dma_addr_encrypted().
+ * The unencrypted DMA buffers must be accessed via the unprotected IPA,
+ * "top IPA bit" set.
+ */
+#define dma_addr_unencrypted(x)		((x) | PROT_NS_SHARED)
+
+/* Clear the "top" IPA bit while converting back */
+#define dma_addr_canonical(x)		((x) & ~PROT_NS_SHARED)
+
 #endif	/* __ASM_MEM_ENCRYPT_H */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-522590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D234AA3CC16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 371A97A79AA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B272586D8;
	Wed, 19 Feb 2025 22:09:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999B25A2C4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002983; cv=none; b=IAfLtlikm9TEfSQ0Ah9tzPfDGeuP4SqwNdI1e2TrXnAGtCcqKI3q9zYCZhWe9jd19UE+u7FurQVM2/rMIAtkgoHNr9uPOVu022sh1AEzS9Fu6jUVaON+5QO5b6u8irdQnxEBGXDHL8BwXx2K/GwKl6wkcVCaG4yrd5QrfcbPK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002983; c=relaxed/simple;
	bh=82rdocLjg7bYXR3a/TcdwqXAYcr+mVrMdClya9NXNxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h73xmr/om1Gp5VPGFpYjNXBBO3/zT52KzSpZu0TvfstbW7KOn6BwG8Jmnlz3on+Q6psvQfF0GYHLM4+lQPE+gbwibuTJ+d3h8fj2lDpranUmywS60rViBWbEUc9NSNOtnjqqkxi0vH4moSnFPdnAupEglaQ4tJhCtHtR0cc+E7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8989B153B;
	Wed, 19 Feb 2025 14:09:59 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A20153F6A8;
	Wed, 19 Feb 2025 14:09:39 -0800 (PST)
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
Subject: [PATCH v2 3/3] arm64: realm: Use aliased addresses for device DMA to shared buffers
Date: Wed, 19 Feb 2025 22:07:51 +0000
Message-ID: <20250219220751.1276854-4-suzuki.poulose@arm.com>
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

When a device performs DMA to a shared buffer using physical addresses,
(without Stage1 translation), the device must use the "{I}PA address" with the
top bit set in Realm. This is to make sure that a trusted device will be able
to write to shared buffers as well as the protected buffers. Thus, a Realm must
always program the full address including the "protection" bit, like AMD SME
encryption bits.

Enable this by providing arm64 specific dma_{encrypted,decrypted,clear_encryption}
helpers for Realms. Please note that the VMM needs to similarly make sure that
the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
unprotected alias.

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
 arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index f8f78f622dd2..aeda3bba255e 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -21,4 +21,26 @@ static inline bool force_dma_unencrypted(struct device *dev)
 	return is_realm_world();
 }
 
+static inline dma_addr_t dma_decrypted(dma_addr_t daddr)
+{
+	if (is_realm_world())
+		daddr |= prot_ns_shared;
+	return daddr;
+}
+#define dma_decrypted dma_decrypted
+
+static inline dma_addr_t dma_encrypted(dma_addr_t daddr)
+{
+	if (is_realm_world())
+		daddr &= prot_ns_shared - 1;
+	return daddr;
+}
+#define dma_encrypted dma_encrypted
+
+static inline dma_addr_t dma_clear_encryption(dma_addr_t daddr)
+{
+	return dma_encrypted(daddr);
+}
+#define dma_clear_encryption dma_clear_encryption
+
 #endif	/* __ASM_MEM_ENCRYPT_H */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-522588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6E3A3CC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E85189E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943325A2A2;
	Wed, 19 Feb 2025 22:09:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5D235341
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002979; cv=none; b=git6Hh7w52pOOlymSqMDm8vhc4N1C+Sfv/4TPdJVifeQwOR5X9ECIlfxlcKOKYcE/XtnuL3dEqfRUu3JonqSapn7iSlUrov+pfWvWJjhdDvr5OkzQXf3DJqT/qcT42qG+5b+gDi9es2D4o1kfdbGlfa+xpGbvLu/oshlJJaOtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002979; c=relaxed/simple;
	bh=4iMOmaLbt8kCVoGpJtn+wXCpd4nNqDG6hAArQ/zlzR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gid2cxmiI9c4mwVO9SGYnXz6eihmggCF5rJMYNHQx6UOA4R7riODlAFEDCn1jBiVktHc92n+5sTfeawBG8AnZU6bi5YJmNAHF9z69fg/cZgFmuvnUahM2p1GJPNQhLC5V+v8+2dAkMXTqcHio2FG93oLCwqSIKVyNdQ+qS6w2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E74EA153B;
	Wed, 19 Feb 2025 14:09:55 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B9793F6A8;
	Wed, 19 Feb 2025 14:09:35 -0800 (PST)
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
Subject: [PATCH v2 1/3] dma: Fix encryption bit clearing for dma_to_phys
Date: Wed, 19 Feb 2025 22:07:49 +0000
Message-ID: <20250219220751.1276854-2-suzuki.poulose@arm.com>
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

phys_to_dma() sets the encryption bit on the translated DMA address. But
dma_to_phys() clears the encryption bit after it has been translated back
to the physical address, which could fail if the device uses DMA ranges.

Hopefully, AMD SME doesn't use it. Anyways, let us fix it, before cleanup
the infrastructure for supporting other architectures.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Link: https://lkml.kernel.org/r/yq5amsen9stc.fsf@kernel.org
Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/dma-direct.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index d7e30d4f7503..d20ecc24cb0f 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -101,12 +101,13 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	phys_addr_t paddr;
 
+	dma_addr = __sme_clr(dma_addr);
 	if (dev->dma_range_map)
 		paddr = translate_dma_to_phys(dev, dma_addr);
 	else
 		paddr = dma_addr;
 
-	return __sme_clr(paddr);
+	return paddr;
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
-- 
2.43.0



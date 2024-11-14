Return-Path: <linux-kernel+bounces-409298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5449C8B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1288A28639E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D31FAC4B;
	Thu, 14 Nov 2024 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YhRRwXPX"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969E1F9A9B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588685; cv=none; b=O36qSwqzhiCxBBxzUYXMcL9VfPNDmN6Grd5X2ydJD69ympFL7LIcmD8dQ4ygrfc6WRp3Lwd+5MfybOpspwB5CDXsPkKVqDZP5e+pSqabRKjHsU23kLiKZtH0a+qCUQFPphbys4lNL0MTeoMi/A6p2LuO2VDKxTCYejGYxS4hyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588685; c=relaxed/simple;
	bh=MUeZUNJck5VioU3N+TAhZu+kVkx7fuZSOH5NPuLqs70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibAKMElvjKiTmzhd4sc+g1GH91cNLWpi59qQJWblYwKKQ8jFjWTNK0VjdMSeCP9tzcW9Xi28tytnGrdR0isKw2M5oq/LXVAYgoVuu7da+EGDJ8Mx6ScLUIGMOvZMKU7uFy7MGc+TqBzHGczhwT2ybRXISFtFRjlSA9RA340fH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=YhRRwXPX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588677;
	bh=vjWVmIzrzecRAdw0e45UvGpGZnvkStlN4cYjwiHA+hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhRRwXPXdfLhJdcBWfbNTkucAbvE53+MpUwrSdezZytaLa8FWUzy5xGgwx/5QtwbD
	 zSbOzBqMLH6N1mmEYgF9OqvjK7qZU/OuffT6G9B8NznQL/gZ1VzZzOkOhMCgkGGO8f
	 oEKZjQQXbKYI+O9HkMxw1dAm0RPyQYhz4Vd4H4x59LuwpxdQoLKj/chQnOebqwZJvE
	 2WOiaUr9LdPuGv1niL9w77XsUcN9Zpsyt3yjTInrmjRxXOfXPekpZ+CKSMK2amYTMO
	 +NX9b1yIlenvMFRLJOv7d9bnlJF4L8e3+Psz98sHDSucn6X1ch75jZu38nS23hGlU2
	 8J66U6ZxSQ3wA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QF5D0Gz4x3q;
	Thu, 14 Nov 2024 23:51:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 02/20] powerpc: Remove some Cell leftovers
Date: Thu, 14 Nov 2024 23:50:51 +1100
Message-ID: <20241114125111.599093-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that CONFIG_PPC_CELL_NATIVE is removed, iommu_fixed_is_weak will
always be false, so remove it entirely.

Also remove a hack/quirk in the HTAB code that was only used on Cell.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/iommu.h      |  6 ------
 arch/powerpc/kernel/dma-iommu.c       |  2 +-
 arch/powerpc/mm/book3s64/hash_utils.c | 12 ------------
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 04072b5f8962..b410021ad4c6 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -317,12 +317,6 @@ extern void iommu_flush_tce(struct iommu_table *tbl);
 extern enum dma_data_direction iommu_tce_direction(unsigned long tce);
 extern unsigned long iommu_direction_to_tce_perm(enum dma_data_direction dir);
 
-#ifdef CONFIG_PPC_CELL_NATIVE
-extern bool iommu_fixed_is_weak;
-#else
-#define iommu_fixed_is_weak false
-#endif
-
 extern const struct dma_map_ops dma_iommu_ops;
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index f0ae39e77e37..4d64a5db50f3 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -136,7 +136,7 @@ static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
 
-	if (iommu_fixed_is_weak || !phb->controller_ops.iommu_bypass_supported)
+	if (!phb->controller_ops.iommu_bypass_supported)
 		return false;
 	return phb->controller_ops.iommu_bypass_supported(pdev, mask);
 }
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index c8b4fa71d4a7..734610052cf4 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1358,18 +1358,6 @@ static void __init htab_initialize(void)
 	} else {
 		unsigned long limit = MEMBLOCK_ALLOC_ANYWHERE;
 
-#ifdef CONFIG_PPC_CELL
-		/*
-		 * Cell may require the hash table down low when using the
-		 * Axon IOMMU in order to fit the dynamic region over it, see
-		 * comments in cell/iommu.c
-		 */
-		if (fdt_subnode_offset(initial_boot_params, 0, "axon") > 0) {
-			limit = 0x80000000;
-			pr_info("Hash table forced below 2G for Axon IOMMU\n");
-		}
-#endif /* CONFIG_PPC_CELL */
-
 		table = memblock_phys_alloc_range(htab_size_bytes,
 						  htab_size_bytes,
 						  0, limit);
-- 
2.47.0



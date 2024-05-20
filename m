Return-Path: <linux-kernel+bounces-184102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB848CA29E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284AC1F220A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3613956C;
	Mon, 20 May 2024 19:14:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CE13956D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232499; cv=none; b=uwlcbSjOJ+ipEJCEH9r7j1+Z+qaxiZgZkBve3tZEdwabO1waXlHGyTUvGCqtijAr0tFM92iM6w+QO3bb6BBh75SbeyqqD5C0/6e0YDuoZFjuqLGOJz5ifPEEB94Ar4yLd8SG3bjwk+uavcYsnykZJ0jplX38rljHVZoSBQM+lWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232499; c=relaxed/simple;
	bh=aKWSKFKGF6zwX7P7XN89k4m4AaRFffhHWHjbFPxtRpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlxeLt1+ATh6Ub07AB3msM8Z5r/aqyLNvM7jKZIaSL6zw4psH9PGRWFa+KFL2bqOMaISuYO0NuGvdl9Dj5LxkwIZyY88sKTqR1LvPMk1ncNDlRhtdRfak4dxRAG/oQcmKC3Gi/R4LMD5MAEmbjuRT8yTBdt6pws672hzv1Ey9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 361BEDA7;
	Mon, 20 May 2024 12:15:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 57CC43F641;
	Mon, 20 May 2024 12:14:54 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	will@kernel.org,
	linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu/dma: Fix domain init
Date: Mon, 20 May 2024 20:14:44 +0100
Message-Id: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite carefully rewording the kerneldoc to describe the new direct
interaction with dma_range_map, it seems I managed to confuse myself in
removing the redundant force_aperture check and ended up making the code
not do that at all. This led to dma_range_maps inadvertently being able
to set iovad->start_pfn = 0, and all the nonsensical chaos which ensues
from there. Restore the correct behaviour of constraining base_pfn to
the domain aperture regardless of dma_range_map, and not trying to apply
dma_range_map constraints to the basic IOVA domain since they will be
properly handled with reserved regions later.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: e28a114243d1 ("iommu/dma: Make limit checks self-contained")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 89a53c2f2cf9..1ec89ca75c59 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -685,15 +685,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 
 	/* Check the domain allows at least some access to the device... */
 	if (map) {
-		dma_addr_t base = dma_range_map_min(map);
-		if (base > domain->geometry.aperture_end ||
+		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
 		    dma_range_map_max(map) < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
-		/* ...then finally give it a kicking to make sure it fits */
-		base_pfn = max(base, domain->geometry.aperture_start) >> order;
 	}
+	/* ...then finally give it a kicking to make sure it fits */
+	base_pfn = max_t(unsigned long, base_pfn,
+			 domain->geometry.aperture_start >> order);
 
 	/* start_pfn is always nonzero for an already-initialised domain */
 	mutex_lock(&cookie->mutex);
-- 
2.39.2.101.g768bb238c484.dirty



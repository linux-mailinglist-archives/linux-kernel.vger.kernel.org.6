Return-Path: <linux-kernel+bounces-200616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB98FB26F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BA91C23A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1CE146D53;
	Tue,  4 Jun 2024 12:39:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D4145B08
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504769; cv=none; b=KbOaezEM9heCcvRRQ4dNVNelLlgNYVBczzoq8E9Kyh6BNT8ff/scgzS22R4Qz7dG8t3FTAdtIeypwESxEStKlB9My4SXEBGz6SN0FIKmexdlcBjA50g5D/xSqEBr/Za2u2GSRPN95sbar8QXxeiUX/Ug9PMInzDP++IKNdDOJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504769; c=relaxed/simple;
	bh=CJQznAmjsNRBqVvAYQkJGFd2j6BoG6NkYtH9+N8AqEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmLFuPMXO+hXb3wcX4SKQ7SqT6i3TXNeaDyVp1c173CWYixf5mYDcnS6AHtGygqo2sJmpcexPOupOLJXYNQheDgOygdoNDmVQ6IYMEroUWq5JE2PkmMR84/TIkZnckCpK2ANfk1boCZi5Vbb/MhfnQRqLelCct4PZq/dmhg4q9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 683761042;
	Tue,  4 Jun 2024 05:39:51 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 508A33F64C;
	Tue,  4 Jun 2024 05:39:26 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	hch@infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Prune redundant pgprot arguments
Date: Tue,  4 Jun 2024 13:39:09 +0100
Message-Id: <c2a81b72df59a71a13f8bad94f834e627c4c93dd.1717504749.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Somewhere amongst previous refactorings, the pgprot value in
__iommu_dma_alloc_noncontiguous() became entirely unused, and the one
used in iommu_dma_alloc_remap() can be computed locally rather than by
its one remaining caller. Clean 'em up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..a30a2f3c8f97 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -939,8 +939,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
  * but an IOMMU which supports smaller pages might not map the whole thing.
  */
 static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
-		size_t size, struct sg_table *sgt, gfp_t gfp, pgprot_t prot,
-		unsigned long attrs)
+		size_t size, struct sg_table *sgt, gfp_t gfp, unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -1014,15 +1013,14 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 }
 
 static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
-		unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	struct page **pages;
 	struct sg_table sgt;
 	void *vaddr;
+	pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-	pages = __iommu_dma_alloc_noncontiguous(dev, size, &sgt, gfp, prot,
-						attrs);
+	pages = __iommu_dma_alloc_noncontiguous(dev, size, &sgt, gfp, attrs);
 	if (!pages)
 		return NULL;
 	*dma_handle = sgt.sgl->dma_address;
@@ -1049,8 +1047,7 @@ static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
 	if (!sh)
 		return NULL;
 
-	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
-						    PAGE_KERNEL, attrs);
+	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp, attrs);
 	if (!sh->pages) {
 		kfree(sh);
 		return NULL;
@@ -1619,8 +1616,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
-		return iommu_dma_alloc_remap(dev, size, handle, gfp,
-				dma_pgprot(dev, PAGE_KERNEL, attrs), attrs);
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-- 
2.39.2.101.g768bb238c484.dirty



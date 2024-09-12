Return-Path: <linux-kernel+bounces-326108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAED9762B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E914A281A59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E418E04A;
	Thu, 12 Sep 2024 07:30:02 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E218E047
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126202; cv=none; b=r8UMJAva7m++8+ibc3a2aqL+IOyD3pK9/jYbUrob7sAPiQ/b0qw+iHvRUQm9bBEjDgXgtT7WzWan0ghMO54zNeu/FjN3FtbAEO4hJK5slf7kH6BiovQ7E1visFbYPSxYlzs9Iowa5hzdN4huyGw03/bmgT/UoHW5e2SNIUpIBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126202; c=relaxed/simple;
	bh=EJTDZxvDTGO8aKCg3ypB07gV+yLhBoB+tl2vKjYOw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBLcK9XUuyS2u2MZhkr7bHBa/5ZNdBV8y30tNw0MeNYAsK1T4CtbnBkDLkw7izRwFJFyjAG7Tu8zZNY566FD1qybgJVPeOEtSILdFmddN75afx7tzwqaoBSRmKrMr7Eayrk68opQNbnpGcTYg4+SbzrR4b6cc00GuPsU8D/WtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B94E227AAF; Thu, 12 Sep 2024 09:29:55 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:29:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH] dma-mapping: reliably inform about DMA support for
 IOMMU
Message-ID: <20240912072954.GC7614@lst.de>
References: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbedc085ce87b121b9d0cb33eca8fba2fbdddbc.1726049194.git.leonro@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, I've applied this.  I do like the flow of dma_supported even
less with the duplicate condition now.  Can I get a quick review for
this incremental cleanup, please?

---
From d311bfe189d12a836b4add55fdb946f37f8697fa Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 12 Sep 2024 09:21:18 +0200
Subject: dma-mapping: reflow dma_supported

dma_supported has become too much spaghetti for my taste.  Reflow it to
remove the duplicate use_dma_iommu condition and make the main path more
obvious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 022d670f8cad29..cd2a97d362cd24 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -841,20 +841,23 @@ static int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (WARN_ON(ops && use_dma_iommu(dev)))
-		return false;
-
-	if (use_dma_iommu(dev))
+	if (use_dma_iommu(dev)) {
+		if (WARN_ON(ops))
+			return false;
 		return true;
+	}
+
 	/*
-	 * ->dma_supported sets the bypass flag, so we must always call
-	 * into the method here unless the device is truly direct mapped.
+	 * ->dma_supported sets and clears the bypass flag, so ignore it here
+	 * and always call into the method if there is one.
 	 */
-	if (!ops)
-		return dma_direct_supported(dev, mask);
-	if (!ops->dma_supported)
-		return 1;
-	return ops->dma_supported(dev, mask);
+	if (ops) {
+		if (!ops->dma_supported)
+			return 1;
+		return ops->dma_supported(dev, mask);
+	}
+
+	return dma_direct_supported(dev, mask);
 }
 
 bool dma_pci_p2pdma_supported(struct device *dev)
-- 
2.45.2



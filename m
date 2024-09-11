Return-Path: <linux-kernel+bounces-324411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F6974C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83381C25C21
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F2154425;
	Wed, 11 Sep 2024 08:04:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F6153837
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041893; cv=none; b=OPZSABLM26jlLUe5ss6Lc9awWObHogVN9zrV/M2xsKcVONgW99Th6xM6xAon+XAJJfCdb4r8Chyn1wSSAmKtx0Km7Uge1kObOXk9ZsfGI/t00Rm1rCoNKWd3Rb7TPE5+ZHwkPm7y9RwHJsU1cPifddTDGOgWn3HO+qauHziA2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041893; c=relaxed/simple;
	bh=/CSb5i4eKb9gqo1hmpGIH5jyrntUD/keY6VmktfO7S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yke7N9lXkSFTdUTMeMDUcN7fnUhFyVaP3yDfwTq9oen7u1n4nppL3qp91L2pnBOCJq4peRso+xDm05BDZpglFmZZ4TpubkOcT5q8Wqf/DOwphloyL/40XZ64lpVoOrxh3xrvWpfTAN+cM0rwS2cgtpD+K3XaIQlXjLtLpxSgkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25B37227AB5; Wed, 11 Sep 2024 10:04:46 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:04:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240911080445.GA5950@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org> <181e06ff-35a3-434f-b505-672f430bd1cb@notapiano> <20240911064305.GD4026@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911064305.GD4026@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 11, 2024 at 09:43:05AM +0300, Leon Romanovsky wrote:
> Thanks for the report, I'm looking into it. However, it is unclear to me
> why my patch is causing this issue. The change in dma_supported() should
> produce WARN_ON [1] if new path is taken, otherwise, we return to
> previous behavior.

dma-iommu never implemented .dma_supported and thus claims to support
all dma masks.  To restore that behavior we'd need something like the
patch below:

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 7550b5dc5e55df..d23a4d5a6b31a1 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -841,17 +841,19 @@ static int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (WARN_ON(ops && use_dma_iommu(dev)))
-		return false;
 	/*
 	 * ->dma_supported sets the bypass flag, so we must always call
 	 * into the method here unless the device is truly direct mapped.
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
+	if (use_dma_iommu(dev))
+		return true;
+	return dma_direct_supported(dev, mask);
 }
 
 bool dma_pci_p2pdma_supported(struct device *dev)


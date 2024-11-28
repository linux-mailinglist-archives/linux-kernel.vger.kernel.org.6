Return-Path: <linux-kernel+bounces-424242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14F9DB1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF32281010
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD405823D1;
	Thu, 28 Nov 2024 03:50:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAC2563
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732765817; cv=none; b=RfomY8uMNXzoUIkgfUxsxCan4FfC5QalUZYLFT6QfAq4TYQrLvfGLust/8zDL/vvhc9gKQjtG3t6HCsB82sH4vpC+Eb8DkMcgcYAK1Np3uOMX6rk6qBFHCS9rY8adGF/LWMhMCIE8Tvi2AkETpoaz+n81P4TPbP0hPcH9/hZA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732765817; c=relaxed/simple;
	bh=ymCIO7ZdsttFHqVYR81uVpclJfLo47rUglE/eSEYCnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0cZzUKSxAQgNBTzFHRmG4cSyGF1aSZBd+w1nYjn7l+IpV/yNrSloC9sOHNYeuMMeDdP4eVfFQwT4Li/0/ssi7gDGuoO5xNVEWG9frMOwrNf+nZF3+nIy8Vgr6o6rUAcV0vapyNExsjlBjSa8bf/ToMt+ihqnjrH/7qOY1UDrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3294668D05; Thu, 28 Nov 2024 04:50:11 +0100 (CET)
Date: Thu, 28 Nov 2024 04:50:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] dma-debug: fix physical address calculation for struct
 dma_debug_entry
Message-ID: <20241128035011.GA13047@lst.de>
References: <20241127185926.168102-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127185926.168102-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 27, 2024 at 09:59:26PM +0300, Fedor Pchelkin wrote:
> Offset into the page should also be considered while calculating a physical
> address for struct dma_debug_entry. page_to_phys() just shifts the value
> PAGE_SHIFT bits to the left so offset part is zero-filled.
> 
> An example (wrong) debug assertion failure with CONFIG_DMA_API_DEBUG
> enabled which is observed during systemd boot process after recent
> dma-debug changes:

Thanks!

Is it ok for you if I fold in the following cleanup to have a helper
instead of the duplicate very dense expression?

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 27ade2bab531..e43c6de2bce4 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1377,6 +1377,18 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	}
 }
 
+static phys_addr_t virt_to_paddr(void *virt)
+{
+	struct page *page;
+
+	if (is_vmalloc_addr(virt))
+		page = vmalloc_to_page(virt);
+	else
+		page = virt_to_page(virt);
+
+	return page_to_phys(page) + offset_in_page(virt);
+}
+
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
 			      dma_addr_t dma_addr, void *virt,
 			      unsigned long attrs)
@@ -1399,9 +1411,7 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
-	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
-				vmalloc_to_page(virt) : virt_to_page(virt))) +
-				offset_in_page(virt);
+	entry->paddr	 = virt_to_paddr(virt);
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
@@ -1424,9 +1434,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
-	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
-			vmalloc_to_page(virt) : virt_to_page(virt))) +
-			offset_in_page(virt);
+	ref.paddr = virt_to_paddr(virt);
 
 	if (unlikely(dma_debug_disabled()))
 		return;


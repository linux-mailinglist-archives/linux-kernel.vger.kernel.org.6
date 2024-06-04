Return-Path: <linux-kernel+bounces-200260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B488FADC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD76284817
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BD14290A;
	Tue,  4 Jun 2024 08:42:14 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EED611420DA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490534; cv=none; b=n4+OYhScvnBV72anYCanY4ik5JYD8J2S4CLDQPL1U6yFeLu8dAvy3XSSsa3wi3teRpfWJQ6GZHA5kVIEJiKk9SG39jKfibMk+xGN8vR3ly1rOBpQ+//JYNNsLWSsbCWDdOfi1bIYeHFrGz885oxNqaiut64KUYjwI6YW/2vMEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490534; c=relaxed/simple;
	bh=IhCW5tPZwTtj5+YMsXpg5bHM6SkJlvgCSjrTIAYjZ5E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OVQF7pehrpbrV9rGH182l0LNta0d+UrykViC61JVy9+C2evM3EtYhmrnZppFjA8OUvyd6gKCDHUWegD25u4OTde6Yxlbht63PiWFNL2Xs40OQX1XwXgQ1ykMBHpD4Kd+9H9Tb6qi8KEYsxJMG7w4nIzCd1fDx9EGZZlbxITUrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 757C86048992C;
	Tue,  4 Jun 2024 16:41:54 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: kunyu <kunyu@nfschina.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kunyu <kunyu@nfschina.com>
Subject: [PATCH] dma: direct: Optimize the code for the dma_direct_free function
Date: Tue,  4 Jun 2024 16:41:00 +0800
Message-Id: <20240604084100.51464-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The 'is_swiotlb-for-alloc' and 'dev_isdma_coherent' judgment functions
need to be called multiple times, so they are adjusted to variable
judgment, which can improve code conciseness.

Signed-off-by: kunyu <kunyu@nfschina.com>
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4d543b1e9d57..041e316ad4c0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -315,23 +315,24 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int page_order = get_order(size);
+	bool swiotlb_for_alloc = is_swiotlb_for_alloc(dev);
+	bool is_dma_coherent = dev_is_dma_coherent(dev);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	    !force_dma_unencrypted(dev) && !swiotlb_for_alloc) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
-	    !dev_is_dma_coherent(dev) &&
-	    !is_swiotlb_for_alloc(dev)) {
+	    !is_dma_coherent && !swiotlb_for_alloc) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev)) {
+	    !is_dma_coherent) {
 		if (!dma_release_from_global_coherent(page_order, cpu_addr))
 			WARN_ON_ONCE(1);
 		return;
-- 
2.18.2



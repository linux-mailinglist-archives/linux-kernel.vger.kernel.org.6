Return-Path: <linux-kernel+bounces-309846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92AE967107
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49A16B22576
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357D17C222;
	Sat, 31 Aug 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiyEGh9Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80A13B797
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102337; cv=none; b=IGGK0yrVAfaOfYDDXCqPcfn34lMlT57F+LsymMa18DwzM3g6vRNd2u8G6sEXvpJcfIMHCETJeLKq5KXjLaRf4pimBXV9b3s1Lve3Hme+lK/nT6siaL2DOS6MH+IS6dIJhvDN8YAMhreoMT6WzTlMh7q6eQRZCkgaJ0/a/WhVLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102337; c=relaxed/simple;
	bh=QHQ7s5ZnaXIFeUe218UPy0zveOElkOsOBLFx6wV4aNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAZcTM+4fARURMPsQ4W+blY9Qh43G0akyjqWoehQMbehyscctCOKl6vUowzV7+a4YDREzGujxHqGO/LQl/FgjysBsEIBDaiqxFaZMgyHa2f2SRkwvj3nwmfe1vh4t/vcCJFPVzFvSau89jcWsOgbA0fbY0Cj8t6/RNvqOeqKMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiyEGh9Z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725102337; x=1756638337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QHQ7s5ZnaXIFeUe218UPy0zveOElkOsOBLFx6wV4aNk=;
  b=KiyEGh9ZfZi0+nEDrdFOqKT+endA23CsrCFauHCtSNjddFy8bll3q4rK
   37sNDJecFLVIgI80ryZn38uV/pKRZ5V3VHjPMgh6OQSkDTReDMZjhv8LI
   afoKbKyKrUPZirplsQf4bv7DkRddsUTmwi07PqFQm0ilnEIGwQbFRe5xs
   +w7P1MguT0bsxcpMUQaNDSe/aap4xYeo0v2U4xrV2v/R+Bq/3KR7nlYnJ
   kvq77xjKUOwIHYP3nFNgC+BUpZPqlEKdTwko0uxGPCdqC0jAHmmvJPUiT
   O0EZBHxx1G5hkiCYIFdZaAP2A4ozz4jGiU4dZHj8tznc8sPNQ695XrNLY
   A==;
X-CSE-ConnectionGUID: pZfKikygSSS/cEDhIJXwyw==
X-CSE-MsgGUID: Z5XnIeLIQbmM5IdRRkF3iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23902788"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23902788"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 04:05:36 -0700
X-CSE-ConnectionGUID: sOLvF3uBSB69thWdwc+u9A==
X-CSE-MsgGUID: QlDIojO6SXGpGvVAZXHJ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="69034645"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa004.jf.intel.com with ESMTP; 31 Aug 2024 04:05:34 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] dma-direct: fix the page free when it is not addressable
Date: Sat, 31 Aug 2024 19:01:19 +0800
Message-Id: <20240831110119.200377-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the CMA allocation succeeds but isn't addressable, its
buffer has already been released and the page is set to NULL.
So later when the normal page allocation succeeds but isn't
addressable, __free_pages() should be used to free that normal
page rather than freeing continuous page(CMA).

Fixes: 90ae409f9eb3 ("dma-direct: fix zone selection after an unaddressable CMA allocation")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4480a3cd92e0..51f07bf235c0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -140,7 +140,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		page = alloc_pages_node(node, gfp, get_order(size));
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		dma_free_contiguous(dev, page, size);
+		__free_pages(page, get_order(size));
 		page = NULL;
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-- 
2.25.1



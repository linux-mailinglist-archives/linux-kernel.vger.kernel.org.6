Return-Path: <linux-kernel+bounces-191510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40188D1089
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177D41C213FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06F167264;
	Mon, 27 May 2024 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaWyt7+9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBBF41C6E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716852401; cv=none; b=EAVFwgyUza+5ugTWUgZkyGmjvmRRwqIz7pmUFHMAKW7qPXGAIdmDVgG4+UjgA3FgglFVCzip1Upw0pkz6O9wRweDxnuG4B0C4LapxJcYfAYSLRtJ81r+3ZPWyu3gSCbCBMKW9CjoyV32iaMG5l9YOCn7MvM9rBLHyZWotMLXq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716852401; c=relaxed/simple;
	bh=ziUGs70MUhsa3utiTcHful7u5bPjfpCCTk98LwUamcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G10QvgadQURhI2gATIU6qb858L6z/oYVolqORIUy2TvM8HGkR2Hy+8/iwJqDhCM9/lDi0AUjxDmB7tdG10aSD3L9Dn+xPCsSZHgkbjB+y6neuSG8+MG5PRYBmhcoxUgTTOKYYtHBdBe56DpuuZ+EXxdm/xZDYOVLTUCbdTCfONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaWyt7+9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716852399; x=1748388399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ziUGs70MUhsa3utiTcHful7u5bPjfpCCTk98LwUamcc=;
  b=jaWyt7+9TIVAZYp0tuFwB1mW0DyF3Z8xXQ1Nbk+mEEMkNG+Bjamuxu5G
   L3HOTvJw72o1baZnAsrJJtL7oEGIkpRhk3nMfRfeW3q8wMvoBmFHFu/7d
   ttsdBC/L8Vx9VVAAu+o8DcS8jjPPamKg9K0Upi2RyCMGsp7l6VOvP8cCe
   BBRUJzA4b7QKhLNteB8rREnI2SxN2o+CghVbDHHfkLF3g9QvpuUx//wCx
   dqgK1D3qlJKwlCZplWcTFiBovaCJ7bYnu5/oRKA9dVmaqSZFV3ocvfLLL
   7tYr+H3snz1uDfN/+6IEK3risWahyW0BzJ1rujjMxm2b1z3m6HLob/ZaY
   g==;
X-CSE-ConnectionGUID: HUOKOX7uQqaPCxLHtQ77Mg==
X-CSE-MsgGUID: sm+fyDqSRPqL36lkBu+hOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24303127"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="24303127"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 16:26:38 -0700
X-CSE-ConnectionGUID: j+IfclDoTNmkENST37sIYA==
X-CSE-MsgGUID: 18KPs6p+QA2u/Zv8xlJ50Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34954035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 27 May 2024 16:26:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4A180184; Tue, 28 May 2024 02:26:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v1 1/1] iommu/dma: Make SG mapping and syncing robust against empty tables
Date: Tue, 28 May 2024 02:26:25 +0300
Message-ID: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DMA mapping and syncing API might be called for the empty SG table where
number of the original entries is 0 and a pointer to SG list may be not
initialised at all. This all worked until the change to the code that
started dereferensing SG list without checking the number of the
original entries against 0. This might lead to the NULL pointer
dereference if the caller won't perform a preliminary check for that.
Statistically there are only a few cases in the kernel that do such a
check. However, any attempt to make it alinged with the rest 99%+ cases
will be a regression due to above mentioned relatively recent change.
Instead of asking a caller to perform the checks, just return status quo
to SG mapping and syncing callbacks, so they won't crash on
uninitialised SG list.

Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
Fixes: 861370f49ce4 ("iommu/dma: force bouncing if the size is not cacheline-aligned")
Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..83c9013aa341 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1108,6 +1108,9 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (nelems < 1)
+		return;
+
 	if (sg_dma_is_swiotlb(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
@@ -1124,6 +1127,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
+	if (nelems < 1)
+		return;
+
 	if (sg_dma_is_swiotlb(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
@@ -1324,6 +1330,9 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *s;
 	int i;
 
+	if (nents < 1)
+		return nents;
+
 	sg_dma_mark_swiotlb(sg);
 
 	for_each_sg(sg, s, nents, i) {
-- 
2.43.0.rc1.1336.g36b5255a03ac



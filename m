Return-Path: <linux-kernel+bounces-193452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A18D2C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48F3B23C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383E160796;
	Wed, 29 May 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lobssp4S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05115DBC6
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960974; cv=none; b=j9AgpdkCKaMLKlhwo3cQQaOMf9dzWHy468hNnmY7P3hVlmgOPBnVrb472+nOwDpphNBWR6Y+9cZI7FIuV9tC6oB1i0WOwPQsT8fSUab2cEW/oWpHD4Hma1jL+ljbkJeUt2UW6z6XDRY4yHCBqj4xDc5azat+PQMx51s79rs32wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960974; c=relaxed/simple;
	bh=Ku98pK7UgGN8K4Vqi8YCUxqt/MmWDBRD7GnhYQUhVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jd9AtcPrd8S8ZFz/g0WEOe/5Lmgj6HldLStAcKnfvlVONj3+u+Z2mDGG3x7YOX6/5QfbCpOcjcHZ7CU1ZrB0V8gj8EwN224PPv19ueqYHYU1HjoOdE0Chvaq8xZWBA8wRN5Xx7sq4zYimV7f43VMNNkhEes7MHjr25KnzCWmZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lobssp4S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960973; x=1748496973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ku98pK7UgGN8K4Vqi8YCUxqt/MmWDBRD7GnhYQUhVEg=;
  b=lobssp4SlPn4FD1ObriFep3zHr2EfzpftuRLSaiCqAYyercF5DmOen01
   b42zZie6swzm5d5oGOOrZof991iuwvThIkpdTnPTvm8+/PF0mhloFnjtR
   bEfbxJW2ftrZ1SBADTAWdRY7yx8NNotey854+PEXb9300+EDAuVsKaUpa
   dB1jG6gZ9QDmnVOKaG/e6bM7J/IhOPHrw6ttm9zN5rHpcD9gnuZLvA/sf
   ndfXF9kec00CJM0PcfhV5nmq3WjcABjFyPteYbbYl+0dow5ULY6vblbwG
   wGh3ETK4LeoG+5xlxLjmlgVaiavbkZ/XQyFA5k2E6moJo4YjKjJi1ZMJa
   A==;
X-CSE-ConnectionGUID: LodPNojnTai3C9J+76CokQ==
X-CSE-MsgGUID: x3CROmkhQRCiebUEHanP6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568786"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:16 -0700
X-CSE-ConnectionGUID: WiRHsEl4TRC1JXRxiW5i8g==
X-CSE-MsgGUID: 4zBoCP3eR6Ce1YRhsCapLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257489"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:35:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 03/20] vfio/type1: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:33 +0800
Message-Id: <20240529053250.91284-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529053250.91284-1-baolu.lu@linux.intel.com>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace iommu_domain_alloc() with iommu_user_domain_alloc().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3a0218171cfa..1d553f7f7c26 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2135,7 +2135,7 @@ static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
 	struct iommu_domain **domain = data;
 
-	*domain = iommu_domain_alloc(dev->bus);
+	*domain = iommu_user_domain_alloc(dev, 0);
 	return 1; /* Don't iterate */
 }
 
@@ -2192,11 +2192,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * us a representative device for the IOMMU API call. We don't actually
 	 * want to iterate beyond the first device (if any).
 	 */
-	ret = -EIO;
 	iommu_group_for_each_dev(iommu_group, &domain->domain,
 				 vfio_iommu_domain_alloc);
-	if (!domain->domain)
+	if (IS_ERR(domain->domain)) {
+		ret = PTR_ERR(domain->domain);
 		goto out_free_domain;
+	}
 
 	if (iommu->nesting) {
 		ret = iommu_enable_nesting(domain->domain);
-- 
2.34.1



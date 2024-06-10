Return-Path: <linux-kernel+bounces-207890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F0901D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7146F1C21CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163775811;
	Mon, 10 Jun 2024 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROcHXMYK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E7757F5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009908; cv=none; b=cQKTe2RUIT+LEgBNR80L9QvZaR9QI90L++qIQKT7WsRBBki3gw17/3+YDKzb0+u4ruksM6jrV0BwqK6JBqhkWR3x8E6P889SBLAwNhZ9TQsrTrh3Ri6mIL0/OIcPmFsQGPeO1tqHDYrp1IRrr7safnfBh16L1EiszaxAJVThjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009908; c=relaxed/simple;
	bh=V0sWEWGdvvTEoPPivf5bf1akoI1gM9dFCowdFsNKU9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVVgfZ9u/lJopaqWYuJPUl1leH7q7XpeJI6mL3XbtDAt2P3PZuXN9aWgVjomtQOLZUlUWl0uCjhCL/wqZ+Xk6Kn+SoY9N1m3UKlW2kb0q5NVu/3TxPjjL4zjWcMsHGMTWzr9XHwKRyGk1n/oGB5AxVRk+IISh2h17Fu14SmjuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROcHXMYK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718009907; x=1749545907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0sWEWGdvvTEoPPivf5bf1akoI1gM9dFCowdFsNKU9w=;
  b=ROcHXMYKP54nH8Xi+UwodyM6nIL9wO0eCDuKLCEy+OkwwbDvrdHMgus3
   2SDx2dO3BGRh2Sk2vwjCXmmjIDe/AgZtVM2Ohp8soMwitgRnmPLI1sFew
   lc0P5GdaVoJj7Mtda22RjhMkENEOKeM8HZD0gzqdyBITze0lfwNj22G00
   3X3wEpQHcyMv19SxsBLfkUYzah66C7vq7gZHYlN9iKPgZUSuA0aiG00fb
   qH1SwAnex5ilSGzQDeO4vYy0TL5jff9j5TCS5fq7pOzOMZJsu14Pq5rZH
   Rz8+fFZfZ9GlHvjwHULK3NrQWtOxwdqm9W1EFbAxVTlogly5+g37t/1ut
   g==;
X-CSE-ConnectionGUID: ZLuUsjyZTmmlytgtLrPFOA==
X-CSE-MsgGUID: NG03Zw0qTBS+4voIY/MIMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="17581531"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="17581531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 01:58:27 -0700
X-CSE-ConnectionGUID: bhp1h+vXQo6jelkBwQxcTg==
X-CSE-MsgGUID: deHpkp5nSxiuSR3yUuqFZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43432419"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jun 2024 01:58:23 -0700
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
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 02/21] iommufd: Use iommu_paging_domain_alloc()
Date: Mon, 10 Jun 2024 16:55:36 +0800
Message-Id: <20240610085555.88197-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the iommu driver doesn't implement its domain_alloc_user callback,
iommufd_hwpt_paging_alloc() rolls back to allocate an iommu paging domain.
Replace iommu_domain_alloc() with iommu_user_domain_alloc() to pass the
device pointer along the path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..cbddfa3ca95a 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -137,9 +137,10 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		}
 		hwpt->domain->owner = ops;
 	} else {
-		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
-		if (!hwpt->domain) {
-			rc = -ENOMEM;
+		hwpt->domain = iommu_paging_domain_alloc(idev->dev);
+		if (IS_ERR(hwpt->domain)) {
+			rc = PTR_ERR(hwpt->domain);
+			hwpt->domain = NULL;
 			goto out_abort;
 		}
 	}
-- 
2.34.1



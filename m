Return-Path: <linux-kernel+bounces-193464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA88D2C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DC81F26A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F816B747;
	Wed, 29 May 2024 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtjhazK5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D454169ADC
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960985; cv=none; b=OaTZSK3ZfNHjqmD6R6vWfFBpEkxkWqUWXx41yG/G/eu4/tbZ/v5Wndf/VEF3TshKTB7eVrJNDZ3q4R6lb/gMX4fTmj5bQwoMslQV/HJlrwQbvEvWhVbi9btgoq+e4Db/KgWx8mZ/A9ksw42flTQV8wCtdiZ9ea74qo5Q3fJc7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960985; c=relaxed/simple;
	bh=Qwe6Nm71KNXy5AzCovPyBLpaZan5bLchb/yuvu+UWlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKixls+Q0VeWca5nc/Ju2/66oyx0b4OPRAKINwp42cJtqNaYAIpZNxsNOiNzTBfOnM9yeIlS6jHyMGuVVdPSH+DQmkFFC2y4ey0h4dMtAlga66VJGx5I/Av7DAAlSdgkTRlfaS+SDZ7qcosuxQ5Z7TK7Ds1CQRHRb8iDjEZYplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtjhazK5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960984; x=1748496984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qwe6Nm71KNXy5AzCovPyBLpaZan5bLchb/yuvu+UWlE=;
  b=NtjhazK5Rywpw2NEiFC/blbpW74vNqvo02C+dqiVeF2rpvzAnJZSUD9+
   akvkUQXv0xcwP/32JWC45zNcaoAKcuVTA17ZbGvpWJQEDJ8rLp2YaLRG3
   A94miWyW1DV7ZeJOCwYQaxJ9ysn+FbdWXDsPvoNRiZbybcZkMM6aBTyZn
   BXkurbenLinTJ2IUMRSa5Mx2lpsn8usov/zBZseQXSpX3cdEbA4/x/rcQ
   fxWuoc1C6PSmr762i6Nn/rNiUtqXDErLnmUHFhKcufOBuo2WYdZOB+u3q
   Lob3JwHHJbawR1ZWI3UR+1+5BjZBJ51xkTP5HIiA+0/4Se2P3JvR5KXHl
   A==;
X-CSE-ConnectionGUID: 1gQzEs29SNuI6xl9oEoibA==
X-CSE-MsgGUID: dOOBbrOHTASpPeeN18QgDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13569038"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13569038"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:36:08 -0700
X-CSE-ConnectionGUID: 0bpDLxsuTtajCtyXoTqBTA==
X-CSE-MsgGUID: Gw6ILwkESJ6yAzh0j9S2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257745"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:36:03 -0700
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
Subject: [PATCH 14/20] soc/fsl/qbman: Use iommu_paging_domain_alloc()
Date: Wed, 29 May 2024 13:32:44 +0800
Message-Id: <20240529053250.91284-15-baolu.lu@linux.intel.com>
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

An iommu domain is allocated in portal_set_cpu() and is attached to
pcfg->dev in the same function.

Use iommu_paging_domain_alloc() to make it explicit.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/soc/fsl/qbman/qman_portal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e23b60618c1a..91f17cea3744 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -48,8 +48,8 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 	struct device *dev = pcfg->dev;
 	int ret;
 
-	pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
-	if (!pcfg->iommu_domain) {
+	pcfg->iommu_domain = iommu_paging_domain_alloc(dev);
+	if (IS_ERR(pcfg->iommu_domain)) {
 		dev_err(dev, "%s(): iommu_domain_alloc() failed", __func__);
 		goto no_iommu;
 	}
-- 
2.34.1



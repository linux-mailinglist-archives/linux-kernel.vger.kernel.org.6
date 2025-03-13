Return-Path: <linux-kernel+bounces-558775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2549A5EB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA03E18958D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824D1F91E3;
	Thu, 13 Mar 2025 05:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoEnZR5Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD81372
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843182; cv=none; b=rhmtxRa9w6z9zOk5yODqV0Z/2bDPoUUuKRTALU66mGVx4aPHbfpMHMtvDSkNC9tV3Y+bTjiiXs3C1ezwXZvZkUmmNjFd03ShMmhlbO98GWKG6J2x7sD4E/2gosJSGdtKlWtpYPrzNoYPqdzyafYQcqnaOpU8FOqDe9IJopvfUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843182; c=relaxed/simple;
	bh=C1sTURMNg4y9jZ7mt47a+t26kfz9pLw7XyJTaq3HaUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5NHoszpHKn2SWulWNH6ccDPLHugetvtWawMGQDdfTUxZruC8+rAPwYCcMtqOrgTTqOqFdmZnlVDp8zzzoCn9+E3sCvBTU3jld+zZtweMBaJtArBclV6K++R67VA5ETP5jAn5YnMuD07kNgSE7M80REwF5vXDdcBlK66dA5R6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoEnZR5Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843180; x=1773379180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C1sTURMNg4y9jZ7mt47a+t26kfz9pLw7XyJTaq3HaUw=;
  b=LoEnZR5ZmzORtXFvwh2zu33FLsxUboBnxlbBfGv64AXYBCfSAuRxE3vP
   tJzLI0nuZ7rQ+4sSYCc30MHCF7qOb0ebRPD5/84zuoba1npgRHa+SBVtN
   6qj5jIYOBEMsjK6Wo6BxqTApee00CsZQupep3t0kurn6AxzuF1FXaX5ep
   mRu/TM+m2AM9IcvkPguOQJF7oq3k44jh2XyyVekXdat1q2fvfrzFNe+Z5
   ZFZR9ycsTeR86Mudtw4btCUZBYxDhK0Xb0HNliE9ua3/BQIzBT7eq9h7L
   l5kHf8pW9r2glcIMveWEhs1vCh+dqQ38MyMk+M4zScZNsaxwHQ+UH+Lru
   Q==;
X-CSE-ConnectionGUID: +QV0MVeHQHGNMnu1aGrGnA==
X-CSE-MsgGUID: 1DK+5oOpSrOgsYTmIbz5VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323631"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323631"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:19:40 -0700
X-CSE-ConnectionGUID: gF4r/zS8QGKmiEyg6IRmGg==
X-CSE-MsgGUID: xQaO4069S8qA72HD41lQjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807013"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Thu, 13 Mar 2025 13:19:45 +0800
Message-ID: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new method for driver fault reporting support relies on the domain
to specify a iopf_handler. The driver should detect this and setup the
HW when fault capable domains are attached.

Move SMMUv3 to use this method and have VT-D validate support during
attach so that all three fault capable drivers have a no-op FEAT_SVA and
_IOPF. Then remove them.

This was initiated by Jason. I'm following up to remove FEAT_IOPF and
further clean up.

The whole series is also available at github:
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Change log:
v4:
 - Refined arm_smmu_disable_iopf() to improve code clarity.
 - Separate patches for vt-d refactoring have been merged.
 - All patches are based on the latest iommu/next branch to prevent
   potential merge conflicts.

v3: https://lore.kernel.org/linux-iommu/20250228092631.3425464-1-baolu.lu@linux.intel.com/
 - Series has been tested by Zhangfei Gao with arm-smmu-v3 driver.
 - Refined some code according to Kevin's suggestions.
 - No functional change.

v2: https://lore.kernel.org/linux-iommu/20250224051627.2956304-1-baolu.lu@linux.intel.com/
 - Fix removing wrong nesting master_domain in
   arm_smmu_remove_master_domain().
 - Fix iopf enable/disable in iommufd mock driver for domain
   replacement.

v1: https://lore.kernel.org/linux-iommu/20250214061104.1959525-1-baolu.lu@linux.intel.com/

Jason Gunthorpe (2):
  iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
  iommu: Remove IOMMU_DEV_FEAT_SVA

Lu Baolu (6):
  iommu/vt-d: Put iopf enablement in domain attach path
  iommufd/selftest: Put iopf enablement in domain attach path
  dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommu: Remove iommu_dev_enable/disable_feature()

 drivers/accel/amdxdna/aie2_pci.c              |  13 +-
 drivers/dma/idxd/init.c                       |  43 +-----
 drivers/iommu/amd/iommu.c                     |  34 -----
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 137 ++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 +----
 drivers/iommu/intel/iommu.c                   |  71 +++++----
 drivers/iommu/intel/iommu.h                   |  33 +++++
 drivers/iommu/intel/nested.c                  |  16 +-
 drivers/iommu/intel/svm.c                     |   9 +-
 drivers/iommu/iommu-sva.c                     |   3 -
 drivers/iommu/iommu.c                         |  32 ----
 drivers/iommu/iommufd/device.c                |  64 ++++----
 drivers/iommu/iommufd/fault.c                 |  45 ------
 drivers/iommu/iommufd/iommufd_private.h       |   5 -
 drivers/iommu/iommufd/selftest.c              |  64 ++++++--
 drivers/misc/uacce/uacce.c                    |  40 -----
 include/linux/iommu.h                         |  35 -----
 18 files changed, 272 insertions(+), 497 deletions(-)

-- 
2.43.0



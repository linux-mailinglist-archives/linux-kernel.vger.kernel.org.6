Return-Path: <linux-kernel+bounces-514411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2153CA356C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83A616B544
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B31DD88F;
	Fri, 14 Feb 2025 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfBALzGf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D41DD0E7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513462; cv=none; b=dfQr2YrTjMV3UJ+mbn4uSguHz+3y7SW7cbGD9ndpk2ADLtPy+hRlvROhK3tuPaQ4YD9vcAUbQFn+mWKffiRnYftuIYrtJhFBOce1KMzT8VZMy2OL9NMY1F9TVpJDsdPPerlNmebdwQqwpC0Ec3Q8FuNlhHsMxgF53YFZpDBSRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513462; c=relaxed/simple;
	bh=ro5xkK8yo/KndYQDY5G/N/Su5NsLJ2Xcrw1UPYjyoa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NELtD8LBcEUXQXic8rK7kimI09IBTGMkd8soK+u2yTdPKXtmhv3kcejSEHDOMX3JunRu3Yli3zXGNe6dYxrhYvoFo1YWlqWwpipSTHIF9XxqKbqyF1EnlrKJfVuE4pRwyk69dfhddAXnilxTT1LeFbWnb3hiT2cCrQUoWzOg1lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfBALzGf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513460; x=1771049460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ro5xkK8yo/KndYQDY5G/N/Su5NsLJ2Xcrw1UPYjyoa4=;
  b=IfBALzGfz90RuGmneQv+C0p99IoMkTLDsUz+M1gyHTHDtIUZAaa6d/bm
   qslmwDV54oKviBwfnIl4Bm+WzfsRbroyGTRhd0eRB+PFILpv3Bd3rM3gA
   aYvzZLkMOA8yP3DhHFFvtmU1h0aNEIGSQkN5cIyZA2IyUNszLSKFzcgF3
   1qeADSEwON4vKhjasB+yZ0vJFZzHygFh0MNXOtcxw7DKZqdGn6s2tS2d8
   o01usatNv7A9SQ8hPwOify4WfJ25PKJbZKBbH25Ux9z/Gm/E8fE8fXbjF
   WrV1K+QFUa/1rFm1Wfpa0S/mrtz9R5m7k0aGDdchqP5qwCHAMTFDbjJU5
   Q==;
X-CSE-ConnectionGUID: Cznwh/Q/Sui9pmq9cW9Qpw==
X-CSE-MsgGUID: vqnNUTvtSyiHxm1zZ9pWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124447"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124447"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:00 -0800
X-CSE-ConnectionGUID: wVpSM2PQQvCo3DVnaeEv7Q==
X-CSE-MsgGUID: 5ZcLeNMmSKCVjI3nhGwtNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268011"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:10:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Fri, 14 Feb 2025 14:10:52 +0800
Message-ID: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
  iommu/vt-d: Check if SVA is supported when attaching the SVA domain
  iommu: Remove IOMMU_DEV_FEAT_SVA

Lu Baolu (9):
  iommu/vt-d: Move scalable mode ATS enablement to probe path
  iommu/vt-d: Move PRI enablement in probe path
  iommu/vt-d: Cleanup intel_context_flush_present()
  iommu/vt-d: Put iopf enablement in domain attach path
  iommufd/selftest: Put iopf enablement in domain attach path
  dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommu: Remove iommu_dev_enable/disable_feature()

 drivers/accel/amdxdna/aie2_pci.c              |  13 +-
 drivers/dma/idxd/init.c                       |  43 +--
 drivers/iommu/amd/iommu.c                     |  34 --
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 130 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  34 +-
 drivers/iommu/intel/iommu.c                   | 301 ++++++------------
 drivers/iommu/intel/iommu.h                   |  50 ++-
 drivers/iommu/intel/nested.c                  |  16 +-
 drivers/iommu/intel/pasid.c                   |  41 +--
 drivers/iommu/intel/prq.c                     |   2 +-
 drivers/iommu/intel/svm.c                     |  52 ++-
 drivers/iommu/iommu-sva.c                     |   3 -
 drivers/iommu/iommu.c                         |  32 --
 drivers/iommu/iommufd/device.c                |   1 -
 drivers/iommu/iommufd/fault.c                 | 111 ++-----
 drivers/iommu/iommufd/iommufd_private.h       |   3 -
 drivers/iommu/iommufd/selftest.c              |  52 ++-
 drivers/misc/uacce/uacce.c                    |  40 ---
 include/linux/iommu.h                         |  35 --
 20 files changed, 380 insertions(+), 699 deletions(-)

-- 
2.43.0



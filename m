Return-Path: <linux-kernel+bounces-193450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCFA8D2C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C9628AB73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E475615FA91;
	Wed, 29 May 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFUfN7yV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87315DBC0
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960974; cv=none; b=K0ae3cX32CKwyIfWJlv8fwIR3rGqgI3FkH/Mhys2HG9Cc44zPDFOdlT7QBT1Bv+SY7iqQerHjnD+TwjPbiLLA7/SwHE5xALk7EsP4lT2YrMCYCkc5IKyY1R5L0Ese/WULAcj4wxDK8JYims3W4vbComjOimXAM5AEbBX8dqRshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960974; c=relaxed/simple;
	bh=jeXpPTPjJIlOE9JrMGFrdmPdU1WHNyP76S68yxLZIYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kW83Yyc2Umyo3jVWa0D+g41xv565qpTwm7Jvf+YYaCaOk6zO9xU7YODYzCbJQ/wrfVCWw50Fwd8wo14S0RADuUnPfS4mzPlMerM3T+pmzODPhGJXXSlEbRZoGDaWDpnf/t+VDnUzO7QYgOgwJTcqoQhvHYsfJb/5ezHtULEQqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFUfN7yV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716960971; x=1748496971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jeXpPTPjJIlOE9JrMGFrdmPdU1WHNyP76S68yxLZIYk=;
  b=TFUfN7yVG1bwnqYmHQKOxKfxEqRMRg5egyF7l6KfmtPRHs55CclNZ5s+
   SrccswOAUMcYZ0UjhmtfjMoTGM1R04TPdGlzzl+TLUdWwiptPY1UUDlf5
   bfymRIMG48LDcr5NElJhi03g129yUbqliq5nZpJoNJxNEtsqwD1+Z2QgV
   ech6+tNu7cHlHM4ITIujmhsUiP+2yGfK34ArLTcATVs4sPAHU4Swbsisi
   OKxzo0nQWmvWmL2dWmi9HfP+OXgY3aS1rMfbHYUgHUqzMJpZJpU+4OHve
   eFs33WN4ArkNCZUqq3YY8/fK2JHYqYsuq1okPpJYnulvDQmK5xufwlEBi
   Q==;
X-CSE-ConnectionGUID: M2TgG0t5Qp2mKzy8r39v9A==
X-CSE-MsgGUID: NEAtBJBjQJOanRgAoRMLiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13568734"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13568734"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 22:35:02 -0700
X-CSE-ConnectionGUID: COa8Vg/1TJ+DOYohn2WZPQ==
X-CSE-MsgGUID: kjXbaTeoRi+UtA/joP+AHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35257413"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 28 May 2024 22:34:56 -0700
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
Subject: [PATCH 00/20] iommu: Refactoring domain allocation interface
Date: Wed, 29 May 2024 13:32:30 +0800
Message-Id: <20240529053250.91284-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU subsystem has undergone some changes, including the removal
of iommu_ops from the bus structure. Consequently, the existing domain
allocation interface, which relies on a bus type argument, is no longer
relevant:

    struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)

This series is designed to refactor the use of this interface. It
proposes two new interfaces to replace iommu_domain_alloc():

- iommu_user_domain_alloc(): This interface is intended for allocating
  iommu domains managed by userspace for device passthrough scenarios,
  such as those used by iommufd, vfio, and vdpa. It clearly indicates
  that the domain is for user-managed device DMA.

  If an IOMMU driver does not implement iommu_ops->domain_alloc_user,
  this interface will rollback to the generic paging domain allocation.

- iommu_paging_domain_alloc(): This interface is for allocating iommu
  domains managed by kernel drivers for kernel DMA purposes. It takes a
  device pointer as a parameter, which better reflects the current
  design of the IOMMU subsystem.

The majority of device drivers currently using iommu_domain_alloc() do
so to allocate a domain for a specific device and then attach that
domain to the device. These cases can be straightforwardly migrated to
the new interfaces.

However, there are some drivers with more complex use cases that do
not fit neatly into this new scheme. For example:

$ git grep "= iommu_domain_alloc"
arch/arm/mm/dma-mapping.c:      mapping->domain = iommu_domain_alloc(bus);
drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    private->domain = iommu_domain_alloc(private->iommu_dev->bus);
drivers/gpu/drm/tegra/drm.c:            tegra->domain = iommu_domain_alloc(&platform_bus_type);
drivers/infiniband/hw/usnic/usnic_uiom.c:       pd->domain = domain = iommu_domain_alloc(dev->bus);

This series leave those cases unchanged and keep iommu_domain_alloc()
for their usage. But new drivers should not use it anymore.

The whole series is also available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-allocation-refactor-v1

Lu Baolu (20):
  iommu: Add iommu_user_domain_alloc() interface
  iommufd: Use iommu_user_domain_alloc()
  vfio/type1: Use iommu_paging_domain_alloc()
  vhost-vdpa: Use iommu_user_domain_alloc()
  iommu: Add iommu_paging_domain_alloc() interface
  drm/msm: Use iommu_paging_domain_alloc()
  drm/nouveau/tegra: Use iommu_paging_domain_alloc()
  gpu: host1x: Use iommu_paging_domain_alloc()
  media: nvidia: tegra: Use iommu_paging_domain_alloc()
  media: venus: firmware: Use iommu_paging_domain_alloc()
  ath10k: Use iommu_paging_domain_alloc()
  wifi: ath11k: Use iommu_paging_domain_alloc()
  remoteproc: Use iommu_paging_domain_alloc()
  soc/fsl/qbman: Use iommu_paging_domain_alloc()
  iommu/vt-d: Add helper to allocate paging domain
  iommu/vt-d: Add domain_alloc_paging support
  iommu/vt-d: Simplify compatibility check for identity domain
  iommu/vt-d: Enhance compatibility check for paging domain attach
  iommu/vt-d: Remove domain_update_iommu_cap()
  iommu/vt-d: Remove domain_update_iommu_superpage()

 include/linux/iommu.h                         |  12 +
 drivers/gpu/drm/msm/msm_iommu.c               |   8 +-
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   4 +-
 drivers/gpu/host1x/dev.c                      |   6 +-
 drivers/iommu/intel/iommu.c                   | 319 ++++++++----------
 drivers/iommu/intel/pasid.c                   |  28 +-
 drivers/iommu/iommu.c                         |  62 ++++
 drivers/iommu/iommufd/hw_pagetable.c          |  20 +-
 .../media/platform/nvidia/tegra-vde/iommu.c   |   6 +-
 drivers/media/platform/qcom/venus/firmware.c  |   6 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   6 +-
 drivers/net/wireless/ath/ath11k/ahb.c         |   6 +-
 drivers/remoteproc/remoteproc_core.c          |   6 +-
 drivers/soc/fsl/qbman/qman_portal.c           |   4 +-
 drivers/vfio/vfio_iommu_type1.c               |   7 +-
 drivers/vhost/vdpa.c                          |  11 +-
 16 files changed, 253 insertions(+), 258 deletions(-)

-- 
2.34.1



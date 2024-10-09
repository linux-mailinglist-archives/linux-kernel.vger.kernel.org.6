Return-Path: <linux-kernel+bounces-356244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3563E995E7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FF31C21E70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D2413A265;
	Wed,  9 Oct 2024 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4wgdquz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352938DC0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447392; cv=none; b=rOlMaNM0vcnAEilKGaHlv7nvyITGrsKa4rR5cAK45y2m5jveASwiaQq0V2amjM7h0PuLbxm2l7moDVLUT3WXD6h/v3f7qPpxxsvCk9MMj01HkHzzCSDPbFDvhuHlVVXIGXBJhsC/wR/pQF6bgfmAKfXdJRwo2EoHysptjKCqJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447392; c=relaxed/simple;
	bh=M4d2jOZZqfKpzWFfGSamwuRPKlayPZoicYOtG1LSiR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCttRHm1hFuBA4FXCIJkgNayvV60q7vDP7fbFUqd1DbOoAF+GKybs0A2nwAHPA8pxww2cQlZOYR0a0sbima5MXw0SKYJochLZURax3Akygx1M9UouUzZ5sUb9xLP+o/84aIAcpTH5iTMIlQo/oBt0jQQWYxuro+/VOxRI1J7dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4wgdquz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728447391; x=1759983391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4d2jOZZqfKpzWFfGSamwuRPKlayPZoicYOtG1LSiR0=;
  b=j4wgdquzo6lV6A0e8a9o0amfC+DQQmKB8ZodMmrOkycAurD4zL75jUmZ
   cMYD5+jV6zceom25tDrbRWfx3ofmlckF+pl5aoYqYn4OwOC0icTWHOV29
   huEkuvcmanTsD5i5V7rOQyNJUTSqAmJdha6NlItOEYMyzt4Um6SdtJj+C
   L+kMIbt0+BhUYjQAEAJZ4nWNnFc9MFY8GOLXn3mb59ODmCEqlknGG/xVQ
   EyfZlUwUg1Ae8NHNTg5YfQKfkTpRWwDzwwswHLP42pw5sCcCjh1L/aP5g
   SJ5vRDRD0dwcMMdf90BGVdJtaIwB/9sYTliMjFtRI3B0F/MrhT8OqYFBQ
   w==;
X-CSE-ConnectionGUID: bOEE+cBJRhyifHZO+EHQJQ==
X-CSE-MsgGUID: LMjjx0jATkCg8AURlCiPMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="53126966"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="53126966"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 21:16:30 -0700
X-CSE-ConnectionGUID: O9Is6FHoS7CD+qGn6Zcb+Q==
X-CSE-MsgGUID: Nn4HZwF9Ryq5M7Emp5n9Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="80095674"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 08 Oct 2024 21:16:25 -0700
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
	Lyude Paul <lyude@redhat.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/4] iommu: Refactoring domain allocation interface
Date: Wed,  9 Oct 2024 12:11:43 +0800
Message-ID: <20241009041147.28391-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
proposes a new interface iommu_paging_domain_alloc() to replace
iommu_domain_alloc(). This interface is for allocating iommu paging
domains for kernel drivers. It takes a device pointer as a parameter,
which better reflects the current design of the IOMMU subsystem.

The majority of device drivers currently using iommu_domain_alloc() do
so to allocate a domain for a specific device and then attach that
domain to the device. These cases can be straightforwardly migrated to
the new interface.

The drm/tegra driver is a bit different in that the device pointer
passed to the helper, which allocates the iommu domain, is not the one
that will be used for the kernel DMA API. Move the existing logic in
iommu_domain_alloc() into the driver to ensure it works as intended.

Now that all consumers of iommu_domain_alloc() have switched to the new
interface, we can finally remove iommu_domain_alloc(). This removal
paves the way for the IOMMU subsystem to support multiple iommu drivers.
Additionally, the individual iommu driver implementation for domain
allocation could also be simplified, as there will always be a valid
device pointer passed along the path.

Change log:

v4:
 - 4 patches remained in this series. These patches have been reviewed
   and ack'ed but missed the merge window of v6.12-rc1. I resent them in
   a series to make it go through the iommu tree.

v3: https://lore.kernel.org/linux-iommu/20240610085555.88197-1-baolu.lu@linux.intel.com/
 - Remove the proposed iommu_user_domain_alloc() interface.
 - Most of the patches have been merged through the subsystem trees.

v2: https://lore.kernel.org/linux-iommu/20240604015134.164206-1-baolu.lu@linux.intel.com/
 - Drop the vt-d patches which implement paging domain support from this
   series. I will post them in a separate series later.
 - Convert all drivers that call iommu_domain_alloc() to use the new
   interface and remove iommu_domain_alloc() from the tree.
 - For the drm/msm driver, make the code compatible with the no-IOMMU
   case.
 - Various cleanups and refinements.

v1: https://lore.kernel.org/linux-iommu/20240529053250.91284-1-baolu.lu@linux.intel.com/

Lu Baolu (4):
  remoteproc: Use iommu_paging_domain_alloc()
  media: nvidia: tegra: Use iommu_paging_domain_alloc()
  drm/nouveau/tegra: Use iommu_paging_domain_alloc()
  iommu: Remove iommu_domain_alloc()

 include/linux/iommu.h                         |  6 ----
 .../drm/nouveau/nvkm/engine/device/tegra.c    |  4 +--
 drivers/iommu/iommu.c                         | 36 -------------------
 .../media/platform/nvidia/tegra-vde/iommu.c   |  7 ++--
 drivers/remoteproc/remoteproc_core.c          |  6 ++--
 5 files changed, 9 insertions(+), 50 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-280392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9B94C9F5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA84B21A20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69CE16C870;
	Fri,  9 Aug 2024 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fr9ITUW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2B12E7E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183086; cv=none; b=NbP2j7nL0Hleq+GFSQ9E25aafGwAe5V6aHz9qV9S9S7iWfiBzFs8QMcv//qhxG66Vd/Ne0xd8Lx+w0qCkWvrNN5j60T1DObMXBtmoYXw3jdCsWBIpGCozYSojN+FMf9onTxQkCVWgUGvQGNjOxz3+78PgvX3tbNo63OjALfFyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183086; c=relaxed/simple;
	bh=EjNUO1G8fUoOFyVU7/LcFACMKocJfSk95eUy2roxy1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S1KXzdGggBgkrQe8cBkoH7Ger8LEBNH48njR9itMcMD7ndKZLNtqRhrdWD2MRylwfN0eROOm3kUVnrpdL2beNXJ/DZ0T/vcQQogIKn3LQJP5uuYrqgGX8rNa5f9/BjfqF8EiLPRGM19j/YNMT3RlxRml3t/gmO5hX+ooNelP0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fr9ITUW+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183084; x=1754719084;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EjNUO1G8fUoOFyVU7/LcFACMKocJfSk95eUy2roxy1Y=;
  b=Fr9ITUW+HEwNJur2/5fz80IrzydwbfkR1v46hvqJyoqL/xRVCtVZ1Oqn
   AeGUuL07/OOE8FrPkbd6imeQkNt4YC5jIXWeNAChLLmRo5kOBoNaMsN6n
   bHiYvpe29KB8Z/DzaOKyRm9MmMagXDRu2036pJitDF1z96hAIyzlWOYhl
   Zlhzg1sjgOnRjmCw0ekOZpSdAU0L8rzfdSoxL3rbOkHwYzvHQaHKPpCje
   uNFxTr+4YnObJjXlQRtT1ebhlFniiw62o8xz9apt0e9Qbu0zbYbVe7Fgh
   k63tZYULEcV9Wpw0GXXHKnKgKMIZENOy2K2zUlxiZ9TckJjPlB4R8lDFW
   A==;
X-CSE-ConnectionGUID: oWHs9f+FRbeqZmu52MAQ7w==
X-CSE-MsgGUID: hbdT6imhRf6rzNcwG+Bn4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469106"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469106"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:03 -0700
X-CSE-ConnectionGUID: osZSMV3mS3myNWtMYFUlYQ==
X-CSE-MsgGUID: MbrogYbtRT2iNamRqRZ5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540850"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 0/7] iommu/vt-d: Convert to use static identity domain
Date: Fri,  9 Aug 2024 13:54:24 +0800
Message-Id: <20240809055431.36513-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel's IOMMU driver used a special domain called 1:1 mapping domain to
support the domain of type IOMMU_DOMAIN_IDENTITY, which enables device
drivers to directly utilize physical addresses for DMA access despite
the presence of IOMMU units.

The implementation of the 1:1 mapping domain is influenced by hardware
differences. While modern Intel VT-d implementations support hardware
passthrough translation mode, earlier versions lacked this feature,
which requires a more complex implementation approach.

The 1:1 mapping domain for earlier hardware was implemented by associating
a DMA domain with an IOVA (IO Virtual Address) equivalent to the
physical address. While, for most hardware supporting passthrough mode,
simply setting the hardware's passthrough mode is sufficient. These two
modes were merged together in si_domain, which is a special DMA domain
sharing the domain ops of an ordinary DMA domain.

As the iommu core has evolved, it has introduced global static identity
domain with "never fail" attach semantics. This means that the domain is
always available and cannot fail to attach. The iommu driver now assigns
this domain directly at iommu_ops->identity_domain instead of allocating
it through the domain allocation interface.

This converts the Intel IOMMU driver to embrace the global static
identity domain. For early legacy hardwares that don't support
passthrough translation mode, ask the iommu core to use a DMA type of
default domain. For modern hardwares that support passthrough
translation mode, implement a static global identity domain.

The whole series is also available at

https://github.com/LuBaolu/intel-iommu/commits/vtd-static-identity-domain-v4

Change log:
v4:
 - Add a new patch to remove has_iotlb_device flag as suggested by
   Jason.
   https://lore.kernel.org/linux-iommu/20240807121712.GD8473@ziepe.ca/

v3: https://lore.kernel.org/linux-iommu/20240806023941.93454-1-baolu.lu@linux.intel.com/
 - Kevin worried that some graphic devices might still require identity
   domain. Forcing DMA domain for those drivers might break the existing
   functionality.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com/

   After confirmed with the graphic community, we decouple "igfx_off"
   kernel command from graphic identity mapping with the following commits:
   ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic identity mapping")
   4b8d18c0c986 ("iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA").

v2: https://lore.kernel.org/linux-iommu/20231205012203.244584-1-baolu.lu@linux.intel.com/
 - Re-orgnize the patches by removing 1:1 mappings before implementing
   global static domain.

v1: https://lore.kernel.org/linux-iommu/20231120112944.142741-1-baolu.lu@linux.intel.com/ 

Lu Baolu (7):
  iommu/vt-d: Require DMA domain if hardware not support passthrough
  iommu/vt-d: Remove identity mappings from si_domain
  iommu/vt-d: Always reserve a domain ID for identity setup
  iommu/vt-d: Remove has_iotlb_device flag
  iommu/vt-d: Factor out helpers from domain_context_mapping_one()
  iommu/vt-d: Add support for static identity domain
  iommu/vt-d: Cleanup si_domain

 drivers/iommu/intel/iommu.h  |   2 -
 drivers/iommu/intel/iommu.c  | 468 +++++++++++++++--------------------
 drivers/iommu/intel/nested.c |   2 -
 3 files changed, 201 insertions(+), 271 deletions(-)

-- 
2.34.1



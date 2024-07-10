Return-Path: <linux-kernel+bounces-247251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7592CD25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901FFB21581
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290C8120F;
	Wed, 10 Jul 2024 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzRxa/hq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60212A14C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600597; cv=none; b=qWR94iY/OcpZc7BuYETexYmDMDE4tN4deTchlhfYMF+m1Ey4689uuFArRhf11G6hxYHpFFcijlIEwYrdM/15/b3R86GnWuhvJ+NoX5GF9asdEMeA+ahEmgD9+31pX4ZXGkKV7e7QO3ZTtHbw3rItUGky9BK0vVNIKcSoWR6G9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600597; c=relaxed/simple;
	bh=RBBisoNzr9TB3QnmsBQJXxD6dWDj+sa6TbFMt7V32ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cMbOpUwgpplGCXnQjOJY4YyFNNMBRV87isKEdRz9HZaseWj1gp/wOSEJcYRMl11yBkj8iIaCA2VriITGcBPIEqeA3yFxa5HAH+M2Lb7Xcy8RpVKc+kbYvn2hSZ6DZ/+02Evpt6YITmuFUTgKYN5r5qctbfFyLrZ16G/MrSKPuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzRxa/hq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600595; x=1752136595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RBBisoNzr9TB3QnmsBQJXxD6dWDj+sa6TbFMt7V32ak=;
  b=jzRxa/hqYIJiEA7eYRVqRFSiwb1RTf32SbAtEIejRJjDPDec/DsH0wPU
   ft0pKqQVmtV9Yt5IcbPIwLKq7cMuFPwDYvli4gdIboSk4jBGB/LmYfb3y
   aajcyP8LKDs6R6PN2hhRp8Q9ok+ugIFgSYPPBI5VlrcUuQMIHpUiKDpfD
   2+UUqCbui8r1myM5D40uuFDWXkKePH+QMvAuYSTbPhrHv0RHxFnH20Pxm
   gdgl/fFamCqfPhCS5/Rmx/rgI+5FXE3V7eOw0Qz5HGF5Wqjei/opVS4BN
   Uy1/4lMJEVxHGTGf7IGqMUkhY9R4z9RpBdhCn5A9gg4pBQWAtIcDt1St7
   Q==;
X-CSE-ConnectionGUID: tisjaRFHS5SL+9Co0xTgug==
X-CSE-MsgGUID: zoxVTv8uR7yJdSd+3Nkh0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770950"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770950"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:35 -0700
X-CSE-ConnectionGUID: NxrwHnxWQYSYQtgQpnawLQ==
X-CSE-MsgGUID: XUkfYUZHTweasDil1Bb0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236116"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommufd: Avoid PRI Response Failure
Date: Wed, 10 Jul 2024 16:33:38 +0800
Message-Id: <20240710083341.44617-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up for the discussion that happened here.

https://lore.kernel.org/linux-iommu/20240709173643.GI14050@ziepe.ca/

It prevents user space from responding to a group of page faults with a
response code other than IOMMUFD_PAGE_RESP_SUCCESS and
IOMMUFD_PAGE_RESP_INVALID, which will be treated by the device as
Response Failure according to the PCI spec.

Please help review and comment.

Lu Baolu (3):
  iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
  iommufd: Add check on user response code
  iommu: Convert response code from failure to invalid

 include/uapi/linux/iommufd.h  | 4 ----
 drivers/iommu/io-pgfault.c    | 2 +-
 drivers/iommu/iommufd/fault.c | 6 ++++++
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.34.1



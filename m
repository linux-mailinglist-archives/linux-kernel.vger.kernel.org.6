Return-Path: <linux-kernel+bounces-400918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557499C13F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0B7B2443A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741741991D6;
	Fri,  8 Nov 2024 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zc3/zcTu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5DF29CEF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032135; cv=none; b=h1d4DLJDPlat3S0cLAFD+owil0lafYkLDMnmTWwfOjI2dCqbj4CQUeKdQzFreQnPDn+QKo/89S1QyYEOWNWSQ4010hDWy3MdA5H1VK7TmC7Z55Qqf6lW/PL7ARUHds68Y78CGdF8PiQnwnjuMzPvnzNN9uH1TDdLZLkVGr/HinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032135; c=relaxed/simple;
	bh=vLIIkzIeeRGQ2f+7KVZkFTMmDLAJzpo0wxcN3DAX7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czob4XM5JGhk4XOuV7Miyy8jbawqjyWoSNdJbS+JLrQ1fK/s+dRYjG/6s04CjdDKs/iJFGKspCuxfn9iU1p7TI3AHfSfnig3tlgb9asY/UQuA8jlIQdt+yFZKDfN1Lv59QdRr5mesDvX37PlErA25nE0AdEJIZ5/kHHiWxdAk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zc3/zcTu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032135; x=1762568135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLIIkzIeeRGQ2f+7KVZkFTMmDLAJzpo0wxcN3DAX7KU=;
  b=Zc3/zcTu4TdnwZb3NtTdaz5sUUG6N8WsR3NXcy7PqiMNVcpiAuv/rRRo
   OOzUopG81lAXRClkQ9vG4aisTtcwiibeCrHLUA1If4ri4+oh70rPpZqY0
   QzjUKB9Civ/LPiSBecWt0jcly/BLPOHMyNbhL6qvRZs0PdtTPvil+O8dF
   Z3wf0szUyd+3L/32xjokhmo3bmpWuIysIIf0YbBVSsYbhTALKo7b+kd5x
   zcu9GdbJli+yQqNkpX1v8HynIGwLvtEzngqQegpFiv1spBW3Vvoy3Qx/V
   /xHVTKjKkVnjWP538ev7spDjxK1kkjHrnr01mAlz6HmTgW2EakE9MHulA
   g==;
X-CSE-ConnectionGUID: TwnYSU74R2K+ZTCtCea2eg==
X-CSE-MsgGUID: Qie902diThSXSgq6SBoKJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007874"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:24 -0800
X-CSE-ConnectionGUID: v7/dZZN8S12eEBKcucLQLw==
X-CSE-MsgGUID: fYToPKFuRmW65tzcONP0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213852"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:22 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iommu: Make set_dev_pasid op support domain replacement
Date: Fri,  8 Nov 2024 10:14:04 +0800
Message-ID: <20241108021406.173972-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

The iommu core is going to support domain replacement for pasid, it needs
to make the set_dev_pasid op support replacing domain and keep the old
domain config in the failure case.

AMD iommu driver does not support domain replacement for pasid yet, so it
would fail the set_dev_pasid op to keep the old config if the input @old
is non-NULL. Till now, all the set_dev_pasid callbacks can handle the old
parameter and can keep the old config when failed, so update the kdoc of
set_dev_pasid op.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-14-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/pasid.c | 3 +++
 include/linux/iommu.h     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index d1dfc745f55e..8c73a30c2800 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -109,6 +109,9 @@ int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = -EINVAL;
 
+	if (old)
+		return -EOPNOTSUPP;
+
 	/* PASID zero is used for requests from the I/O device without PASID */
 	if (!is_pasid_valid(dev_data, pasid))
 		return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32dce80aa7fd..27f923450a7c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -616,7 +616,8 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @set_dev_pasid: set or replace an iommu domain to a pasid of device. The pasid of
+ *                 the device should be left in the old config in error case.
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
  * @unmap_pages: unmap a number of pages of the same size from an iommu domain
-- 
2.43.0



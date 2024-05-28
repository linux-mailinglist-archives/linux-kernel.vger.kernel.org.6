Return-Path: <linux-kernel+bounces-191735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770D8D134F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C60BEB21A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C518B09;
	Tue, 28 May 2024 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6fp9+cL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F41429B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870475; cv=none; b=EhJJIScwk66XXHKci1O1rmE7Ioj4btYrmw1wQWfDUnC3H8nnvD2R64rM+x5KvBvlYktRUNb5uLJpuViEFgVEfyVLGc0jVA/tF2nAbwEENglnPGKeRyNSZ26TZj990BHyOxCf9k9WJ6Az6u/6YvVHp7kYuhO1G0AdHeUvsF7zuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870475; c=relaxed/simple;
	bh=JCNsiH2D0vh3Vv9zlcQCeIQfB1PxnXtbdN9Go4lozBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RTIrb8mmdNePcoa/qUZgwHsYM9rnfFg8//aPQyDLz7ZkS3mBsAhJ1/sO8m5fn9Jilii8yueHCPKjlGpDducw2eUe/sUP1Z4kN3NdbRo6KOzPavZekpB6wu2G4WS6j7GGCUXyOgAZJ+UPtwR7CDQKXjMbcWb8k2Z9PYFcJzX3f0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6fp9+cL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870473; x=1748406473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JCNsiH2D0vh3Vv9zlcQCeIQfB1PxnXtbdN9Go4lozBY=;
  b=k6fp9+cLamNQm75nhU9pTpi4CBVz0msUnpoPMrGYx90kqQlxxN5CMkAf
   xU2hYXsciY4XIr+QHggLK3jxsMrfz8VsZCZSlel2BCkpT2OH54gOGAwvi
   GVSIF2rbdXE0T37MraDDjB4RO+PZpoT6qIZCtnQVgiiloxPCOFoNLeCxg
   GNsLl2Zv6kmfANnbiASBqzBKpD9lPC2MhyCYpJkDWsh9UYmOBa5dMN1yK
   wsd/7psBR86LMXlgYUmiueRTpuCCVPMfv0zSIkLORLix9Znk4e1uaEbx7
   jpuOQhqUYZqbEdBWEbWlP58hi5sSl/fbGCh5rGTBF//HJQOaQvMX4qGfL
   A==;
X-CSE-ConnectionGUID: zlAMxW/7QKOGbmbxSKWPxQ==
X-CSE-MsgGUID: b+arLwfrT1G3WqSfX1Q48A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13381114"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13381114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:27:52 -0700
X-CSE-ConnectionGUID: hNhDtzs5R1aQ43gxieMjtg==
X-CSE-MsgGUID: 6M2XNb6ORK+I29qQ3xiAng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="72345885"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 27 May 2024 21:27:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Date: Tue, 28 May 2024 12:25:28 +0800
Message-Id: <20240528042528.71396-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_bind_device() should return either a sva bond handle or an
ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
check the return value with IS_ERR(). This could potentially lead to
a kernel NULL pointer dereference issue if the function returns NULL
instead of an error pointer.

In reality, this doesn't cause any problems because iommu_sva_bind_device()
only returns NULL when the kernel is not configured with CONFIG_IOMMU_SVA.
In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
return an error, and the device drivers won't call iommu_sva_bind_device()
at all.

Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..17b3f36ad843 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1533,7 +1533,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
-- 
2.34.1



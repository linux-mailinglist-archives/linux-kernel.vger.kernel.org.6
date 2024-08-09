Return-Path: <linux-kernel+bounces-280323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471494C8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C31F2415F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3D21340;
	Fri,  9 Aug 2024 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Upr2ykow"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2F18654
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172197; cv=none; b=Tu6ZbdN7KTt5X6tfRy0UriM8de914xEQ4+zBTjVcYK80NSFDmhYnfLXCtxwa3l5HZcExJoNvWSvVettdNLFAtEnD+78k5uoTTTlpBkNxAPTm4MZDc47NvY4+W9GgLh3HkexS//B+umgvGN8QBsxDcSPS+BMDELFgQOTDjEJ0Blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172197; c=relaxed/simple;
	bh=nj1nJU3aNBybLvKEXohwrftCV9iqavHOaz5vSyI1PEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJzbjHPj9CADQ/i9z7PSegKNYYzfDubyMZS0UQjDJwU8d9cyLLbgP3bIsvhzyliz6H05VE6Ghz7TQuazUuqCB06+53No7R/egc5mnO5oJauexAKh7kQNZu6OJmnUwA1CN4mCVaKvDFA1+ILI2M2oRvISn6gWP2vrB3DjKutP12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Upr2ykow; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172195; x=1754708195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nj1nJU3aNBybLvKEXohwrftCV9iqavHOaz5vSyI1PEA=;
  b=Upr2ykowZPN79sDdYCKwEzlpFdtfVrkDCLZ5jjuD6NBsvXp5BI4UkDCk
   IWYjIK99EkwCFdH3I9g3JwjQ2JSGT3pZohmlLC1e0wTaXmJi7bP1hT5CY
   IYkX775aCdEy+595g58x9QJIdceP+ktTXtn0EO3ngbSxgOlpp03wcd3Cw
   AMqHCXa4vmm4j2DLJEOzXv4YEYXEJNH/jLSikyYeNwWpB8jxH+T9Fy+/H
   fFDzB4RnTPjGPuDzdS3vWMKbcPdhSboo1Or49D/QQoNNSYWnsmgxBvXmh
   TWI4wbn4eHdu3e4zPFqZhZes1P/FgmKDHmtIfYlqWfWJEdo9L8G4hHXXw
   A==;
X-CSE-ConnectionGUID: Qq/xX32bS5WniGeS+v5uyQ==
X-CSE-MsgGUID: nVl6tv5oRQGAov9pVsxHFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239359"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:35 -0700
X-CSE-ConnectionGUID: lHrhUBJARRKke3w+g1WGIw==
X-CSE-MsgGUID: /RHadu3dTzChHyxZlhlInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072653"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:33 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 4/5] vt-d/iommu: Refactor quirk_extra_dev_tlb_flush()
Date: Fri,  9 Aug 2024 10:54:30 +0800
Message-Id: <20240809025431.14605-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809025431.14605-1-tina.zhang@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the core logic from quirk_extra_dev_tlb_flush() into a new
helper __quirk_extra_dev_tlb_flush(). This helper is for accommodating
for both individual and batched TLB invalidation commands, thereby
streamlining the process for handling device-specific TLB flush quirks.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 55 +++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  4 +++
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..160d569015b4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4875,6 +4875,41 @@ static void __init check_tylersburg_isoch(void)
 	       vtisochctrl);
 }
 
+static inline void __quirk_extra_dev_tlb_flush(struct device_domain_info *info,
+					       unsigned long address, unsigned long mask,
+					       u32 pasid, u16 qdep,
+					       struct qi_batch *batch)
+{
+	u16 sid;
+
+	if (likely(!info->dtlb_extra_inval))
+		return;
+
+	sid = PCI_DEVID(info->bus, info->devfn);
+	if (batch == NULL) {
+		if (pasid == IOMMU_NO_PASID)
+			qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
+					   qdep, address, mask);
+		else
+			qi_flush_dev_iotlb_pasid(info->iommu, sid,
+						 info->pfsid, pasid,
+						 qdep, address, mask);
+	} else {
+		if (pasid == IOMMU_NO_PASID)
+			qi_batch_add_dev_iotlb_desc(info->iommu, sid,
+						    info->pfsid, qdep,
+						    address, mask, batch);
+		else
+			qi_batch_add_dev_iotlb_pasid_desc(info->iommu,
+							  sid,
+							  info->pfsid,
+							  pasid, qdep,
+							  address,
+							  mask,
+							  batch);
+	}
+}
+
 /*
  * Here we deal with a device TLB defect where device may inadvertently issue ATS
  * invalidation completion before posted writes initiated with translated address
@@ -4905,19 +4940,15 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 			       unsigned long address, unsigned long mask,
 			       u32 pasid, u16 qdep)
 {
-	u16 sid;
+	__quirk_extra_dev_tlb_flush(info, address, mask, pasid, qdep, NULL);
+}
 
-	if (likely(!info->dtlb_extra_inval))
-		return;
-
-	sid = PCI_DEVID(info->bus, info->devfn);
-	if (pasid == IOMMU_NO_PASID) {
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, address, mask);
-	} else {
-		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
-					 pasid, qdep, address, mask);
-	}
+void batch_quirk_extra_dev_tlb_flush(struct device_domain_info *info,
+				     unsigned long address, unsigned long mask,
+				     u32 pasid, u16 qdep,
+				     struct qi_batch *batch)
+{
+	__quirk_extra_dev_tlb_flush(info, address, mask, pasid, qdep, batch);
 }
 
 #define ecmd_get_status_code(res)	(((res) & 0xff) >> 1)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cd7c1d0a01c6..04aa1f200124 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1109,6 +1109,10 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 			       unsigned long address, unsigned long pages,
 			       u32 pasid, u16 qdep);
+void batch_quirk_extra_dev_tlb_flush(struct device_domain_info *info,
+				     unsigned long address, unsigned long mask,
+				     u32 pasid, u16 qdep,
+				     struct qi_batch *batch);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
-- 
2.43.0



Return-Path: <linux-kernel+bounces-448495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE499F40F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49AF188AF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3081442F6;
	Tue, 17 Dec 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5L5YT1j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABA13DBB6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403461; cv=none; b=foW6OzBBgyt/St6wRMSF2rShIEUV93JcJcNQsMpzDGG5uv3SKhXj9gczrh53h2XpzkXWxxr0U+QaibZm/JtTuvjJ3xYtXfHTDGi0Rj9G3uuqSXyW6M0ro7i2TrYoE4r3hZBkM3vg3y5lMIMAdMB6B8Iu8VZF7wSjz7wIt0sNm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403461; c=relaxed/simple;
	bh=u5zFDydsK6vmCTeSRK+uKNFVLx0ZTjlNSmurdl6V9dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LY5Of5re1VKAmKWN8BTnRd2t91KHXHpvRZPJvZHys8ooqag7MYklIB7y0VdrGFonl6rFRDtTQO65QKKEzwfrTU5XMQ0y/hq0yU0vUDw+6/sUzfmKCP9twxBfvr1y5gSElAr9AzjcqjwSzbJ/sjqmwaUPtkQOCYxVPCuEhgBdKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5L5YT1j; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734403460; x=1765939460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u5zFDydsK6vmCTeSRK+uKNFVLx0ZTjlNSmurdl6V9dc=;
  b=G5L5YT1jEV2WDvnr4SioBuC8IxfJ8l3rFG7zMSKdg2NnPZ8A15xJ+NTX
   AGbN0CIyFBI9ozcddrfXxqKlHwMiqX/ycdcfnaSTL6DKdYP5wHmIEVpPs
   Km0CBsaFAbWM6NX2NULeaImBrHhm5L/58oQIQmc548ypDEvR61W/NA6aJ
   pa9EIcEWV6qd1Z2fz4/Z/QCQ4Cz9NQsv8qX70MG8u8GoQOdQ41Y+FOeLD
   r5LcbxBOEBXS5gxmT0mAhQGu/oRy6IAwFpvQx4cgsUndr1a1AsgqpFh+5
   UMB8/qF2bvibslmcEVnadMw55O/W70gGcyVo8BKPz0vAin28r20Nc4414
   w==;
X-CSE-ConnectionGUID: 7V53Agj6SDG5h6+6P9gwDg==
X-CSE-MsgGUID: PcQ60oMPRJGtlaI7DuSHlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34848414"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="34848414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 18:44:20 -0800
X-CSE-ConnectionGUID: gj0d1iICTemi6BtiAdqJKQ==
X-CSE-MsgGUID: 84D7txdWQbKfr09PW8v3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134732443"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa001.jf.intel.com with ESMTP; 16 Dec 2024 18:44:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set
Date: Tue, 17 Dec 2024 10:42:40 +0800
Message-ID: <20241217024240.139615-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device uses a PASID for SVA (Shared Virtual Address), it's possible
that the PASID entry is marked as non-present and FPD bit set before the
device flushes all ongoing DMA requests and removes the SVA domain. This
can occur when an exception happens and the process terminates before the
device driver stops DMA and calls the iommu driver to unbind the PASID.

There's no need to drain the PRQ in the mm release path. Instead, the PRQ
will be drained in the SVA unbind path. But in such case,
intel_pasid_tear_down_entry() only checks the presence of the pasid entry
and returns directly.

Add the code to clear the FPD bit and drain the PRQ.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 22 +++++++++++++++++++++-
 drivers/iommu/intel/pasid.h |  6 ++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5b7d85f1e143..fb59a7d35958 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -244,11 +244,31 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+	if (WARN_ON(!pte)) {
 		spin_unlock(&iommu->lock);
 		return;
 	}
 
+	if (!pasid_pte_is_present(pte)) {
+		if (!pasid_pte_is_fault_disabled(pte)) {
+			WARN_ON(READ_ONCE(pte->val[0]) != 0);
+			spin_unlock(&iommu->lock);
+			return;
+		}
+
+		/*
+		 * When a PASID is used for SVA by a device, it's possible
+		 * that the pasid entry is non-present with the Fault
+		 * Processing Disabled bit set. Clear the pasid entry and
+		 * drain the PRQ for the PASID before return.
+		 */
+		pasid_clear_entry(pte);
+		spin_unlock(&iommu->lock);
+		intel_iommu_drain_pasid_prq(dev, pasid);
+
+		return;
+	}
+
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 082f4fe20216..668d8ece6b14 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -73,6 +73,12 @@ static inline bool pasid_pte_is_present(struct pasid_entry *pte)
 	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
 }
 
+/* Get FPD(Fault Processing Disable) bit of a PASID table entry */
+static inline bool pasid_pte_is_fault_disabled(struct pasid_entry *pte)
+{
+	return READ_ONCE(pte->val[0]) & PASID_PTE_FPD;
+}
+
 /* Get PGTT field of a PASID table entry */
 static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
 {
-- 
2.43.0



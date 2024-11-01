Return-Path: <linux-kernel+bounces-391687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3209B8A47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413381C213F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DF1482FE;
	Fri,  1 Nov 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/gYCeAp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777E143C72
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 04:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730436988; cv=none; b=dYSIdKUcoP15LLduac/PMt2Kn+SOO/2VW7APLh5U8KItaj0mbTrSQUHKMVNFskEnZ5ttA/c8uXDT4N6U0U2Bzx86Hx/X5MHstlIiGgYIl3NkQGLXQHR7YSdijiN6eBjt995U6iFxv8kFdQQkN/mL2owxbJqfI4QBFw/MgEZzXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730436988; c=relaxed/simple;
	bh=BGJN0bROOUOoi7Ov1dgXc4Q/UN885FzYMkOaLqMypT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeV3ai0/AdDZY+JssdqGHZi2E58FPv6FEiVmUFrQgQsZtNm30VzxKQMy5ylR2/c1Q3dRCUY0JmjymK0v40ycfEfnSPKiFFR2+xHnK/Gpn05UjZDtuOz0EYxGxOPOr/ROeIhDxoT0NbaCZOwbk9GSIwWx2Iy4UWj0wIRE5ZextTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/gYCeAp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730436986; x=1761972986;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGJN0bROOUOoi7Ov1dgXc4Q/UN885FzYMkOaLqMypT4=;
  b=I/gYCeApM8kpTSDCkVOOkczVMINwP+/g2NELO230ESlh5jbQCMkdFCNY
   1crSEjZlXoNN6x+uyV/c3VMcbKAAwrLuioUhfAmm3179W4Icm1kySHUzg
   kRhd8Vv2Da2jGoA570E1yeL3tRx1P+3Wvu5IdWbUYueezQmcJGomnKRhf
   XqzeWNwpz7KPMniEjXzvnkI9GkipZ9BRtfDbnt5Ta90elRI0Or1Aivyjj
   iGXEgTGf+oLWKcuR3mn1KMlVoGum0q/dX4GEHHBOKvDzozAER9o0qGxwN
   gUy067BJtR6wHXbHBG58hENsxOneIxvyrppDB522H1Um8pOscMT3Cxx0Q
   g==;
X-CSE-ConnectionGUID: mJv2MQKLQoCPbe28i4cwzw==
X-CSE-MsgGUID: InUWTad8QwCRR4UVYn83iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41299906"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41299906"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 21:56:25 -0700
X-CSE-ConnectionGUID: Xe25Z1/uRVqCURTiMSDgqw==
X-CSE-MsgGUID: oq/KlJrrT5CGiN/ii98DHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="113649092"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2024 21:56:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
Date: Fri,  1 Nov 2024 12:55:43 +0800
Message-ID: <20241101045543.70086-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As this iommu driver now supports page faults for requests without
PASID, page requests should be drained when a domain is removed from
the RID2PASID entry.

This results in the intel_iommu_drain_pasid_prq() call being moved to
intel_pasid_tear_down_entry(). This indicates that when a translation
is removed from any PASID entry and the PRI has been enabled on the
device, page requests are drained in the domain detachment path.

The intel_iommu_drain_pasid_prq() helper has been modified to support
sending device TLB invalidation requests for both PASID and non-PASID
cases.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  1 -
 drivers/iommu/intel/pasid.c |  1 +
 drivers/iommu/intel/prq.c   | 26 +++++++++-----------------
 3 files changed, 10 insertions(+), 18 deletions(-)

Change log:
v2:
 - Use iotlb_inv_dsc for prq draining of RID2PASID.
 - Fix a 0day compiling warning.
v1:
 - https://lore.kernel.org/linux-iommu/20241031095139.44220-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87a3563dfe54..3878f35be09d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-	intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 7e76062a7ad2..31665fb62e1c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_iommu_drain_pasid_prq(dev, pasid);
 }
 
 /*
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index b9f2d9400efe..9796556901d9 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -63,26 +63,18 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	struct qi_desc desc[3];
-	struct pci_dev *pdev;
 	int head, tail;
 	u16 sid, did;
-	int qdep;
 
 	info = dev_iommu_priv_get(dev);
-	if (WARN_ON(!info || !dev_is_pci(dev)))
-		return;
-
 	if (!info->pri_enabled)
 		return;
 
 	iommu = info->iommu;
 	domain = info->domain;
-	pdev = to_pci_dev(dev);
 	sid = PCI_DEVID(info->bus, info->devfn);
 	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
 
-	qdep = pci_ats_queue_depth(pdev);
-
 	/*
 	 * Check and wait until all pending page requests in the queue are
 	 * handled by the prq handling thread.
@@ -114,15 +106,15 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
 	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
 			QI_IWD_FENCE |
 			QI_IWD_TYPE;
-	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
-			QI_EIOTLB_DID(did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-			QI_EIOTLB_TYPE;
-	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
-			QI_DEV_EIOTLB_SID(sid) |
-			QI_DEV_EIOTLB_QDEP(qdep) |
-			QI_DEIOTLB_TYPE |
-			QI_DEV_IOTLB_PFSID(info->pfsid);
+	if (pasid == IOMMU_NO_PASID) {
+		qi_desc_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH, &desc[1]);
+		qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
+				  MAX_AGAW_PFN_WIDTH, &desc[2]);
+	} else {
+		qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);
+		qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
+					0, MAX_AGAW_PFN_WIDTH, &desc[2]);
+	}
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
 	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
-- 
2.43.0



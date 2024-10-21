Return-Path: <linux-kernel+bounces-373941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C39A5F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B66284272
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D001E3DE1;
	Mon, 21 Oct 2024 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQTtye2O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBD1E3DC8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500996; cv=none; b=YtWsew6Hj1lifkVSVi+QI06sKUZQ//Q9fHwNrrAi5hOCYrvdHKZjmVMl6ApNsprzRps0VFh97lzMyNfkvwC1IeqAfCjIzpHEUQNWOUIe2lAmHQtwGhkP0r87T/W7j/Poxr4ofV9Bd4W92fhdudz/XDMEcKRcVarwnl2bAh47EZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500996; c=relaxed/simple;
	bh=fcfNrVyM1/xmJ1Udun6SiMd4PW9ryvb/sEJVuLPTZ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSfOQmskQqU/zLUgjcN1PhxQyhGReghWvT9PzgVxT9jYNfO543jp+znAh0hY7kUC3vALKf53ZuscZLrLOi/C6AcA7Sqj/i3YH+GEEzKbcJxTYtvrBB55CJd0tU6MP/8jxeuePpjYUdPNxeIUjXOFgv6FIFCt39cQRwdCdV/w7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQTtye2O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500995; x=1761036995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcfNrVyM1/xmJ1Udun6SiMd4PW9ryvb/sEJVuLPTZ9I=;
  b=BQTtye2OCZ4j7i2CHEUvDvTZ+XOL5Aggk2sZPKnIfQDhbTj8brQ/gPNj
   aIONLCGbA3lvDfAwkXGttwTRqd0WjTEV+eeSNrcQg3RMEhxWnfcMTYCiL
   2WwY0u6cgeRRlw/J1Iu7KXONJv3HKOdHUKkXYjPUlQtiwI5v8jJE4dhDd
   TGeqlL4T0eHZ3ioZKhu5tfL9+3O8zz3hbgLPViqQoEgOP0NWTmmsJeMhU
   +daiBEsftgIaefn/D5LmDP/5GSfogp2y6fANV02Sr8+1Zs+EOoa1liRRJ
   Fc2q3kPyMeeKyWQU+CeYRRP9tMC9c9B4bKYCdXfyxbsWAbAOSpw7QcvMG
   g==;
X-CSE-ConnectionGUID: 3L+5B8RBT7aW2IMF0OX2LA==
X-CSE-MsgGUID: jLqi9DLFRvOLjZ24tqMjGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780371"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780371"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:35 -0700
X-CSE-ConnectionGUID: /xsBfnSGTEeeT+KjF8pecg==
X-CSE-MsgGUID: dMUKqwkDTbiUmePtmya2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812762"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 5/7] iommu/vt-d: Remove domain_update_iommu_superpage()
Date: Mon, 21 Oct 2024 16:51:22 +0800
Message-ID: <20241021085125.192333-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021085125.192333-1-baolu.lu@linux.intel.com>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement for consistent super page support across all the IOMMU
hardware in the system has been removed. In the past, if a new IOMMU
was hot-added and lacked consistent super page capability, the hot-add
process would be aborted. However, with the updated attachment semantics,
it is now permissible for the super page capability to vary among
different IOMMU hardware units.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 39 +------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 756caa24008f..36854b683b11 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -352,36 +352,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static int domain_update_iommu_superpage(struct dmar_domain *domain,
-					 struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int mask = 0x3;
-
-	if (!intel_iommu_superpage)
-		return 0;
-
-	/* set iommu_superpage to the smallest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			if (domain && domain->use_first_level) {
-				if (!cap_fl1gp_support(iommu->cap))
-					mask = 0x1;
-			} else {
-				mask &= cap_super_page_val(iommu->cap);
-			}
-
-			if (!mask)
-				break;
-		}
-	}
-	rcu_read_unlock();
-
-	return fls(mask);
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -2605,20 +2575,13 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
+	int ret;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
 
-	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
-	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("%s: Doesn't support large page.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-- 
2.43.0



Return-Path: <linux-kernel+bounces-360485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A71999BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E881C2209F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB151F4FD8;
	Fri, 11 Oct 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mARAPNSy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779061DFDAB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621127; cv=none; b=YP2QD3PPjBVgD9KRBjMtHJ5iqU1PWkbEX0NwZ/jsYQa8UwNnl9JKjSGICGW6OU0TAovOVN6onb0casWDUVV/Smu3ddSn7ShaYtcXIU+n3tTv6Yb/e01blP7EMmCYPPeWYzrOxYgvy2k1rxxOgcKOfmkiYIFDQf0WHpnmbBMWNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621127; c=relaxed/simple;
	bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK5aWWQW3pA3qP0Z7MQN8PZI/G/616me5lTq55uLGjKaho29b1c2oBaICkq1V5T/SFpkRZTba0p0HD1+KGFyoBES+L6aeFp/wKDY4OOVcG4fKiY5ISaxTjZ4B0vQqZSgto7iFuTegHrXJg+YUz5NqgaCV3A9PipoaqlTSGUVj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mARAPNSy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621126; x=1760157126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
  b=mARAPNSy0FaSjyt8QUsw5KxRSBc5u8HOWuTlXCDbLD2LUb+gqaXL2iLs
   RCRYT9xn5fLZ3drlFgALF+1rMUXwSdUxhLLaIUh1fewiAasu1ULXLQIO6
   S6emyprKdVvPwHKEMrBI6m/xA4siMhfjqoLgnaIqtMGN6GVILImfCYwDS
   bCYXb4OOOD+OJGnrXxRzBbbHxcOSk3DSaU5NVz6MGCetTnODgOQGVtd8J
   jeFNB2sE+wnflYNYXoa4PnrxF9DhmhYD6N4s6qn43nYthdlug3JidDcPS
   qUONNB3e+Tme98NgKqDa8la+HBOrIHHa83z3lte+ecAEqFZgef2ecORXG
   g==;
X-CSE-ConnectionGUID: wDs0L7FuSV64lbpsg/MyZA==
X-CSE-MsgGUID: 9v308O1vQTWR5iQSmGU8Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101747"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101747"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:06 -0700
X-CSE-ConnectionGUID: 0QQBpIGdRcqM6p603pqOfg==
X-CSE-MsgGUID: uxY3ydzKQaSLHRT688k7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412160"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:04 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Date: Fri, 11 Oct 2024 12:27:16 +0800
Message-ID: <20241011042722.73930-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the domain_alloc_paging callback for domain allocation using the
iommu_paging_domain_alloc() interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..4803e0cb8279 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4590,6 +4590,19 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
+static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct dmar_domain *dmar_domain;
+	bool first_stage;
+
+	first_stage = first_level_by_default(0);
+	dmar_domain = paging_domain_alloc(dev, first_stage);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+
+	return &dmar_domain->domain;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4599,6 +4612,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-247254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35092CD28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16940B22658
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E313D8A7;
	Wed, 10 Jul 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4Z8uNUs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49913BACC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600605; cv=none; b=Pb8FSK8ieDw6ngm/O79zksN/hPZGZHabM55KGJfMVhLh7MQWhKJjTmiFF2cHCgTx5TBgix+frxQaHRkYutZ+p2k0ZtZyJRG2tlV9x+evO01zd2EYOEz4gRzm4sGAJbSUJDr44UEUKyEvPmGebcV4zA1H6YGSeLpHqXJJs0vrrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600605; c=relaxed/simple;
	bh=UhCCWJEn6oVsJ1nUvHZvdUm6DfrrEniO2iSlSPYCVNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uf1ALXNHVeuTp4RBmFQS5DdvHBxW+wcRh/JxRhnJktLI/L0oNc5MdI5Wal2Px6ohZ3EI68yYcLS61ofNv6R2zGUcaVypsBZONRce/yWU2/WUaGYSQ1BSuHskNuaFfJshb1sLsYuoWnk93/9Z/AssFlQNoQXMpcbgB/TvnMUEt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4Z8uNUs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600604; x=1752136604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UhCCWJEn6oVsJ1nUvHZvdUm6DfrrEniO2iSlSPYCVNI=;
  b=V4Z8uNUs4nHj/GGZq5UoG4Ye/RO/iF3N2IcAf4VwWpv1Gf23loJ0UJDa
   k/j1NOjBaYiC2g2pObm3E7l72poYrJKLph235+aLWyrfgq0jV3gW3eVu3
   gWwApdWh1f/MT7k+HN+wWb6SCKvzcCrOnzn8pzEZPWaOyRt7A1PB6jotG
   TuQD8+k/mvkio2HzY5cwnYkdA6B2NDFE5HI9WLsCnDa1HKfuTLM/xLStS
   9ulCZmyyz2Qeog6TUgCUEHe42dF9k25BQfvUJrMkDDeoASA/8zXkrsVvF
   /GLOtR3MH7c1WqB2bwzxgnCaVh2wG8b+snIhJL0cUeaTGdpDV0rYuuc/F
   Q==;
X-CSE-ConnectionGUID: wj0nuFI1QRGBq/HbpjXaZQ==
X-CSE-MsgGUID: 8EISheBuR9Gd8M7N8ki+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770984"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770984"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:43 -0700
X-CSE-ConnectionGUID: k01LmxDkRDiwdjUjuq2NIQ==
X-CSE-MsgGUID: j777sBxlT1KXmEU35Rok6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236177"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:40 -0700
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
Subject: [PATCH 3/3] iommu: Convert response code from failure to invalid
Date: Wed, 10 Jul 2024 16:33:41 +0800
Message-Id: <20240710083341.44617-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iopf deliver path, iommu_report_device_fault() currently responds
a code of "Response Failure" to the hardware if it can't find a suitable
iopf-capable domain where the page faults should be handled. The Response
Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error,
and the device will disable PRI for the function.

Failing to dispatch a set of fault messages is not a catastrophic error
and the iommu core has no code to recover the PRI once it is disabled.

Replace it with a response code of "Invalid Response".

Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/io-pgfault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index cd679c13752e..b8270ee5dcdb 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
 			     fault->prm.pasid);
-	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
+	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 	if (group == &abort_group)
 		__iopf_free_group(group);
 	else
-- 
2.34.1



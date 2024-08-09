Return-Path: <linux-kernel+bounces-280395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C894C9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A891BB235D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BA16D323;
	Fri,  9 Aug 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAMEBt5O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1416D301
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183090; cv=none; b=SYfryP+MNj1isR3sC5O1Z4OrE1y+LIKQyLohvH2wV0Ez2y4ORahiHHckIKL4xg1p64FQtxy3NNMVBKIteBQScRttVIl0F+Wt/FPqI/VCffIgZDAdyI7E1nysNYBxLPEJbBRKikiyB/KOrhCY9Yl7JvSPY/I02m/L1BPN2fpez7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183090; c=relaxed/simple;
	bh=WcWlb6fcBHnjPHaTIXbjmbe+unnTFF3EQaDn0B0m0fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiqrS9zQrf8Ee81QIHpkfG1YVwgfT2jXmVB8XLs9Io6ori0zwjO+qy18mxm+9gURZbQle7Yfp1sMEVoQqc6/1qWJ0aV7FL8N8kqdIR5xHFlHkKc6+hEQpbG1H7YCI1p9A686+wTrmkaPcsYp9eq67f52F+TSeJjlE+/AQ1Wdd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAMEBt5O; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723183090; x=1754719090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WcWlb6fcBHnjPHaTIXbjmbe+unnTFF3EQaDn0B0m0fs=;
  b=jAMEBt5Os0wSPC4sG/PEsUGcDP2K2MuSYVjjHtzm7j8xnoIOO8f6US46
   +4yyZr6tdz4/r2BMl8MhEGYje9Go1FlFAxnDTUyFxkEufkIxnOMbaLvwb
   EOEemaNDd3G2pZ8B5GYe5BNZ/w+hZQUdh3RBDzIaOltTvsF6pZPnWBug+
   zsj+Q/Y4K4VwRjxZxW0YpJUYmW3lhryHWYHwPIFKSojXHd9nzOEmPjzjc
   4YEKG0guuzTyVfTUcgPNvqFeq6R96E108L72OtcrjHEF3x4boXVbrzkll
   kUou/6JiPQDK6BYcet75FLy3Z5N5JUusRpkw8B5XQ0GD9vBeC4pskbRAx
   w==;
X-CSE-ConnectionGUID: zEFL7/x8RjW98vxnI9YZdA==
X-CSE-MsgGUID: xTvRbb9BTUWmNX7/xFer/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21469133"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21469133"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 22:58:09 -0700
X-CSE-ConnectionGUID: /S8jRWbMQmy0aB/OaSzn6g==
X-CSE-MsgGUID: Rf5PO/EdRmm+2Mr5ridiig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57540890"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 08 Aug 2024 22:58:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 3/7] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Fri,  9 Aug 2024 13:54:27 +0800
Message-Id: <20240809055431.36513-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use a global static identity domain. Reserve a static domain ID
for it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 723ea9f3f501..c019fb3b3e78 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
-- 
2.34.1



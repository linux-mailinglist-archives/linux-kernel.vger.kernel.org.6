Return-Path: <linux-kernel+bounces-310505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EC967DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516561C21C4A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959D42A9B;
	Mon,  2 Sep 2024 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxhrV+bF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD93BB50
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244286; cv=none; b=fwVrwJk4ckMI/eLevYxD9sQdPzdpvHyzMi+Ox7cLfcYEcpSia5H2gwl5sZcOv1OUyVNpIe+l/NgE74GPuEOwtmI43EfHG267UleXToOJN3pqLOBKhgyQkf4dEoK/BZeqi4FEQcel7hyfbjOhNM3G84d4rMAVzMA5E3roiJCdr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244286; c=relaxed/simple;
	bh=0PZrnab4FudM+5CSpi+Okv7WquImKuGdpCZBN2D7HPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnMkXj5mCGO6thVs58MbrwfT8QjDj0UsxgyDJkKJXYfnPnRBf82/pZVCczKAT9Vc5pELanwa9/5BSWuObvWmre0xJbP5LbxeT8zSFUe7mOAGWeDBXukB5qcz3rVQEQ2tHzUhCAuY9YXlNnHuvf5MbYnwda4MvWkjDlRCL+5QmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxhrV+bF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244285; x=1756780285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0PZrnab4FudM+5CSpi+Okv7WquImKuGdpCZBN2D7HPU=;
  b=lxhrV+bFbX4pzHH3YoCSidEmVb2vVBpLVUvFUwr7z2oc97lBazCDrI6b
   jGhbXLiBl0a+Y1sKLDLzu9ztSxESdN34aBDbZrZonQhid9mjaKqWSV7Xh
   JxuRwVadxepKd9mjkRuHgKS796BjTOR7+533Cw0NkJTA60n0nk5spGJdN
   LQsZUbCgXeuCkwgPRw+fVZ6ktqd6Qz3RQ2KfXbCCcX2h02RffxGmLBjEZ
   f/vTez4rWAydIjmpAwKKeVlm9QxmK3UnW/5Br4wB4ZA5sCc4qM3KbMupI
   dC5XObg67HepxdLVmM+38skBu5IFt21eTYhhrMgU3986IsLZ3Bu02KQBk
   g==;
X-CSE-ConnectionGUID: OMTx5WfmTrWpVtmtOiTlSQ==
X-CSE-MsgGUID: RzcVzVr/SiGZN9Z4BG8xlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994280"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:25 -0700
X-CSE-ConnectionGUID: 1P/ZVzKXRUqkO+nQ/xRdpA==
X-CSE-MsgGUID: CKAJlbw+ReCXxPK1Ac2JDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359283"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] iommu/vt-d: Always reserve a domain ID for identity setup
Date: Mon,  2 Sep 2024 10:27:13 +0800
Message-Id: <20240902022724.67059-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use a global static identity domain. Reserve a static domain ID
for it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-4-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a92da6375efe..baf79c6a5a84 100644
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



Return-Path: <linux-kernel+bounces-250100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC54F92F43F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870F7284707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A654C2C6;
	Fri, 12 Jul 2024 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljYWY0zj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765710F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753278; cv=none; b=XXPBHKIEWPtv5YC+TaqpUUrcJaVRCrGkDgNcjHyDdLHrRbmgeMTSM4qfK6k5E7Sj2ZO2cfNkSZj6gwl/AUXLfYhB6o2nWQk1RgUnEvbWqZJLcxVpOjD0AYJwBijgaJinn/+OmsPSdfcytkhfW4E7Jc2ZSh2sswOTCov9gkHsY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753278; c=relaxed/simple;
	bh=0aEJlDLMG5ZH5CZ9fGepo3Rd17RwlIFau4Z3BJD8RuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2uLEThHvQMiPVeyuLJM1hYByzx48u1Iz4S3L4qiCkUAyx+pDFxmCEwEI8Oak24OwWDpf9DKKL1aoo6QgyKDKwmHB4zGhvzKkBjx7BL0Mx3mWmmTJ4OAiWXtDtYuEiL5GjE8hCR0MZ9HKOfSWcLJo+srhfl7oxXM+3JR0t8T5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljYWY0zj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753277; x=1752289277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0aEJlDLMG5ZH5CZ9fGepo3Rd17RwlIFau4Z3BJD8RuY=;
  b=ljYWY0zjaWWqwj5G45X2e4vBiUjh0+gP0nBskTGw5ikmiOYeL5MDP/Pj
   fXI48MdZFSw1FMc3KPRggj0dqTVtvkpybVEL1WRrPZVk2h5C3S90AyeRn
   ZyohXH+iOSLChxCYU5/kbtxuHW0O9dX6G4bWfW+25KZ5GR4Gdvj/KryY7
   GYwxsbjQOc+re2Z+qd8KxgImPTOqIVRflX6/ZNSbPSIJWYXMRkOohpY8M
   xi9VQJh7Gt1aaxA8jSe4IhyD/kKZ45PURxXIvsHjXZKB+os7SZAwPt808
   2Sl4ObTiMC+Kl33zLVcCKUcOvf9XEo+BDumZZHEOmEL4HVXHeWiPG7fqJ
   w==;
X-CSE-ConnectionGUID: dBnr5tfwQUiU6WGOVjFQUw==
X-CSE-MsgGUID: RUsjcc3uSOi0NMztYJlbnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="40701102"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="40701102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:01:16 -0700
X-CSE-ConnectionGUID: tEflH6Q+Rqe5jncCIYnZrA==
X-CSE-MsgGUID: 2lTr02FLTGOMQHsZiRqyZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48688004"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 11 Jul 2024 20:01:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommufd: Fix error pointer checking
Date: Fri, 12 Jul 2024 10:58:19 +0800
Message-Id: <20240712025819.63147-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch static checker reported below warning:

    drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
    warn: 'handle' is an error pointer or valid

Fix it by checking 'handle' with IS_ERR().

Fixes: b7d8833677ba ("iommufd: Fault-capable hwpt attach/detach/replace")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-iommu/8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index e6bda84865f0..29f522819759 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -128,7 +128,7 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev)
 	struct iommu_attach_handle *handle;
 
 	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
-	if (!handle)
+	if (IS_ERR(handle))
 		return NULL;
 
 	return to_iommufd_handle(handle);
-- 
2.34.1



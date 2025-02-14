Return-Path: <linux-kernel+bounces-514422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3742A356D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A317A557A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B61FDE24;
	Fri, 14 Feb 2025 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFVKv5CB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC01FDE05
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513495; cv=none; b=IUHpLolloe4+nwzAbW2xCvIOPkpD94XVy9bpLtrg7JYSITlrRdceJbJ1ILtlX0oHM+Behua4WJ6dCMbY6D593VP+9eDyquxRUtDclo3+sWLMd/ktsRrgYVWLV0HzcmrM5M/S4wCtCYHQY5hCkPt8NSFW0vbXAAkPkFvpEuPGzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513495; c=relaxed/simple;
	bh=eHTPZGlc4bucKd77w2+UvVId/z3fbuGWY7W1qJYKM9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjniEi62+oUComllOpVVW71yOHCoHMYxsZ1cfjeFqI5HxQh1XKCUSgFUTsuAJuhbVTHC9h3Dj1oho8d2pnUPPAXGH6raC4fKKdZaVyR7agZD4si38IU+SMuDamCHEt3Wce//dlnJZ5NFejh1kDJuVK9agABV/GNCY46mJlya/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFVKv5CB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513494; x=1771049494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eHTPZGlc4bucKd77w2+UvVId/z3fbuGWY7W1qJYKM9M=;
  b=mFVKv5CBuM9rh/HBKG+rjW+K75PGMxhBPtPeK3B3lp45Orzm7RSQnK9e
   yPuZYEst148oQqExdlD64tWcvrUmDDHVQvlFExADajstIsHFWP6rbal3S
   FWHx5eFOzSFOoN/+2Ke39BXsZOis8blHkVCD0FvdLkpVsYPmLCXRTgmvM
   rCMv9KEnD3VdXy9LtSejh5B6q73kIuaOPlJljThHH7fsn7skHY4VGjPe4
   nulEzxp8tLRnseUtZC48u6G0LZoImgfTZ1S/ZFBXcjdrU8xPCkh42pI4B
   OCOickK9ZcLXtMPVGLKIioMw1BhhU20tj/QLlBlMTiuChOfsPk8miN3j0
   Q==;
X-CSE-ConnectionGUID: APyfOKpYT/S4ImcZfQ20SQ==
X-CSE-MsgGUID: 3zEOwciAQ+u1TTL0NAfZFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124593"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:34 -0800
X-CSE-ConnectionGUID: mbkI+N/yRf2nnMMeAp/srQ==
X-CSE-MsgGUID: y7DjvvTWQR2qLM3tm4arEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268166"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Fri, 14 Feb 2025 14:11:02 +0800
Message-ID: <20250214061104.1959525-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/misc/uacce/uacce.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 2a1db2abeeca..42e7d2a2a90c 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -465,31 +465,6 @@ static void uacce_release(struct device *dev)
 	kfree(uacce);
 }
 
-static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
-{
-	int ret;
-
-	if (!(flags & UACCE_DEV_SVA))
-		return flags;
-
-	flags &= ~UACCE_DEV_SVA;
-
-	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
-	if (ret) {
-		dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
-		return flags;
-	}
-	return flags | UACCE_DEV_SVA;
-}
-
-static void uacce_disable_sva(struct uacce_device *uacce)
-{
-	if (!(uacce->flags & UACCE_DEV_SVA))
-		return;
-
-	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
-}
-
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -509,8 +484,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
 
-	flags = uacce_enable_sva(parent, flags);
-
 	uacce->parent = parent;
 	uacce->flags = flags;
 	uacce->ops = interface->ops;
@@ -533,7 +506,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	uacce_disable_sva(uacce);
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -596,9 +568,6 @@ void uacce_remove(struct uacce_device *uacce)
 		unmap_mapping_range(q->mapping, 0, 0, 1);
 	}
 
-	/* disable sva now since no opened queues */
-	uacce_disable_sva(uacce);
-
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
 	xa_erase(&uacce_xa, uacce->dev_id);
-- 
2.43.0



Return-Path: <linux-kernel+bounces-226666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9EC9141EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B85D1C22BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3A18E25;
	Mon, 24 Jun 2024 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU/p8+Em"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DA17BBF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206867; cv=none; b=o1UouyWahDDfI6cgWNIUEvd7t5wnVH5pc2D8Dxr8XIeIVfOKvETZo61uz2/XY4BdPvpJpj4nMFCRUdCYCzhanBUn+1RYhwxdV3icuNe8XSiT+EMRHjIer2M10wfYCdBRWGzGdsu6dh+5wV/HZL+95dJFbzriuAEEPn7qie5FNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206867; c=relaxed/simple;
	bh=sd/FAqFDAs/rycYdMJrag36N1xw45zKs/yUNA9ZLgT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sh2gu+TPnzyN7sNxk79M2U52IlYeCXn3ZxuU2XF7Qc9ZC3VdD4XendsshEj5tGo/6sy3UEMT6OlGFKMn0xLYMCcC7MD62cOQ9p8dqZGpNWbc3o7RRIMrD6NlXTcDcDOK9E7+G7q6seSV65aIp6ZZBoowYh/2D6Rag7CXyAIYRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU/p8+Em; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719206865; x=1750742865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sd/FAqFDAs/rycYdMJrag36N1xw45zKs/yUNA9ZLgT0=;
  b=LU/p8+EmC8hMfiQUDsobDyI38cpetc+uZKL+SxnyFu+BlHJTxJa5vrzV
   yIe3yw64LYwweeDxV1Fkmllaitwa0e4mEVoDa7wYzLtJfnrj+6cZwnbqq
   cPN9LigxWU2DO2cv77JC4QvWF9JjsyaoU2SKOxA0IskiTCf8X1t/tdxR+
   /e/lttiawLNcbw1C49nTPN1BZYrMpr0PozPqwa8E6E0tu+mG9KQmHBWYe
   b+Amzq0WsRGkddw9eXw+6qvZsY3yJkg7c+kiR6hu+r2ggFzyH2BqHHED6
   vAXuh0OTm0wd6KRzZFq3rOR1W3OMIGbp1dfUw93Cc0FBclLpNfsqx8k0L
   Q==;
X-CSE-ConnectionGUID: zwJWCYnKSfKcFrCbEfx7lA==
X-CSE-MsgGUID: 9Nb+OusGTI2HfhQIh5H90w==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16040085"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16040085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 22:27:45 -0700
X-CSE-ConnectionGUID: EStCQbEuScaR4VxzumeY2w==
X-CSE-MsgGUID: 8fWqHsM6Tn+hq07GRmgu+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="48133396"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2024 22:27:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
Date: Mon, 24 Jun 2024 13:25:01 +0800
Message-Id: <20240624052501.253405-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624052501.253405-1-baolu.lu@linux.intel.com>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a device is listed in the SATC table with ATC_REQUIRED flag set, it
indicates that the device has a functional requirement to enable its ATC
(via the ATS capability) for device operation. However, when IOMMU is
running in the legacy mode, ATS could be automatically supported by the
hardware so that the OS has no need to support the ATS functionality.

This is a backward compatibility feature which enables older OSs. Since
Linux VT-d implementation has already supported ATS features for a long
time, there is no need to rely on this compatibility hardware. Remove it
to make the driver future-proof.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 07e394dfccc1..b63347c8bf5d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3056,14 +3056,7 @@ static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 	dev = pci_physfn(dev);
 	satcu = dmar_find_matched_satc_unit(dev);
 	if (satcu)
-		/*
-		 * This device supports ATS as it is in SATC table.
-		 * When IOMMU is in legacy mode, enabling ATS is done
-		 * automatically by HW for the device that requires
-		 * ATS, hence OS should not enable this device ATS
-		 * to avoid duplicated TLB invalidation.
-		 */
-		return !(satcu->atc_required && !sm_supported(iommu));
+		return true;
 
 	for (bus = dev->bus; bus; bus = bus->parent) {
 		bridge = bus->self;
-- 
2.34.1



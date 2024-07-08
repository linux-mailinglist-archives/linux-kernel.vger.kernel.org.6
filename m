Return-Path: <linux-kernel+bounces-244305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375C92A271
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070D41F210CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF47CF3E;
	Mon,  8 Jul 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZtLy5Ko"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D33C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441032; cv=none; b=WSYpy4adHEw4YIYDZsqaJgeKULvCmZNmIQYLY5Cx6CLpVQ4S7IuHpQkWo1BqDFHBtMzDVqjgYt0KVdWiBkQGyyXGhFIc51Y+kMXkTiXE+7szxXPNywsR5FsmZ3VDlj/2Coqd+8HJ/nH8kpwx+C3Hgg6OuZZ8+gRXdXey1zMOjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441032; c=relaxed/simple;
	bh=QXRPhjyeTJAXjPvsuowDft2z1JMupmKnRIyGAGOAty0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F23wujIgVVdVQyeMOt/+V4Jk5xMC9Bczg5RZZjGNqwddPLG6DUG8bGD6jxDM+o0XXq6isJQiNF7Ou2TPzpOkEtymdLvkT454kKwxKjXwz1QNc3IoYI7rTNx3idFFs2JQiw2Emg0405VBqMgc4tCvvNAQkY3VtrGtmpGN31sOzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZtLy5Ko; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720441031; x=1751977031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QXRPhjyeTJAXjPvsuowDft2z1JMupmKnRIyGAGOAty0=;
  b=LZtLy5KoiDhJSyaxBtu3RbkZwv8TtVwE64kjgCg9z30JUYk5GfAXvSrh
   +QEffM1v5s2ln2XgVVMGNq3pK5YWvvz0dhXnyF7OEze43BXa3XEZfuGwO
   f+MfkJB5ELEGnwfB69x7jx41OxW9CH6Q8PMXEdQ1/5nqLPcdCpmZFVmDJ
   U3LljzOno3hU8oFT4V+3ZfocGAFBumZOXudVIcGFHpKjwk3K1S3e8iNPV
   lFVXPJ9bGodxJTCSTW70ew1LQVbXRz+5IS3gXXnWQoSQA7nrz/7oBJJGd
   JYxWfm8DRMgb3GjBk7ZdyhsscmpwZY3kg/uE+OFtIvknOrIaYMIYINuny
   Q==;
X-CSE-ConnectionGUID: bz+ouNH1QXiMZbW9Z4UMeg==
X-CSE-MsgGUID: jZI4bQVGSHqxbmpCEVacjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17843940"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17843940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 05:17:10 -0700
X-CSE-ConnectionGUID: AuI47fOlTlC7raMfskdFXg==
X-CSE-MsgGUID: b41/eL8ARr+xZ4B1Tr+nyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51908113"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2024 05:17:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()
Date: Mon,  8 Jul 2024 20:14:17 +0800
Message-Id: <20240708121417.18705-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper calculate_psi_aligned_address() is used to convert an arbitrary
range into a size-aligned one.

The aligned_pages variable is calculated from input start and end, but is
not adjusted when the start pfn is not aligned and the mask is adjusted,
which results in an incorrect number of pages returned.

The number of pages is used by qi_flush_piotlb() to flush caches for the
first-stage translation. With the wrong number of pages, the cache is not
synchronized, leading to inconsistencies in some cases.

Fixes: c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e8418cdd8331..113834742107 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -246,6 +246,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
 		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+		aligned_pages = 1UL << mask;
 	}
 
 	*_pages = aligned_pages;
-- 
2.34.1



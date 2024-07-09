Return-Path: <linux-kernel+bounces-246166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F2792BE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC321F22D38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF619DF73;
	Tue,  9 Jul 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+yzKqfJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A119DF6B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538983; cv=none; b=BF5i7K7gnkirXZA9OwCiuv3sxBe8Qjpnn+ZYdNzDwlvxCLkU79g1EBudnQXuI0ISLMmyezBhBVZw4giA7STaWs8H+3YdNVAfPsNUqkVnWCBrGX3qhhPTvAZZ7hqgrwLbC/8Qb/qXvWDZJHLbOfGBo80Jp2K63U3+eROzDm2J5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538983; c=relaxed/simple;
	bh=I1LSP78yDNgAjrCn+EJFU50y+ogRvO1jzAZ7VOjf5lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYkfK5ImXLyQ7cIIyqxv3PNFv/4mYmxRlbOGqUhX7pTeKYl9tNGMBC3G+dDu5hYc+Cfc1gZGuYEbO1bg6sDnZbElfNF5B+FEAArUOBBGBZdoKMEuQmm/Eml5KkdjsZmPlHsgq/HQCPBqF2FCvNuMr1aRZYvxf/mTc5P5CGNAFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+yzKqfJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720538982; x=1752074982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I1LSP78yDNgAjrCn+EJFU50y+ogRvO1jzAZ7VOjf5lE=;
  b=V+yzKqfJOrz+zjyde7b1UyUrFwMPokbwngI/Uo63YORgf/t2tST3K6TI
   807rK1+0mkB719rMdSxn7Qfzoy8pKg2vThQFebaSq5XKFoDLi0QzpjyPC
   UicqcP5gi55JtsjCmT8ObrEuoYBnxESk+vV78irL/hx1HC2i2fS2DUCqX
   fhlRM9C/feqjKFe/u9Y71hvH9PnOHzs19p8ly0tAv9ACpS731L+GqQVC0
   c0TmnF+fLQ0QqD3icT7gRpqBgBy0YJOSLF+VAh0NP16NLFXLDOX6HbD4C
   RvIELobdUF59gXbEYRGezC1Efgp7syS36bKoCUrsj5jr7UT9rDx95Lrxk
   A==;
X-CSE-ConnectionGUID: 537RiH8rT0aYJz3FxkQ7ZQ==
X-CSE-MsgGUID: v0hLZenKRGu1AvHu9hzMNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="40321161"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="40321161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:29:42 -0700
X-CSE-ConnectionGUID: pHa/3vIaT1OtFt9meugppA==
X-CSE-MsgGUID: F954ZRBNQvC3XygO4fD3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="48618961"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 09 Jul 2024 08:29:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()
Date: Tue,  9 Jul 2024 23:26:43 +0800
Message-Id: <20240709152643.28109-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709152643.28109-1-baolu.lu@linux.intel.com>
References: <20240709152643.28109-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 0a3bb38a5289..44e92638c0cd 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -246,6 +246,7 @@ static unsigned long calculate_psi_aligned_address(unsigned long start,
 		 */
 		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
 		mask = shared_bits ? __ffs(shared_bits) : MAX_AGAW_PFN_WIDTH;
+		aligned_pages = 1UL << mask;
 	}
 
 	*_pages = aligned_pages;
-- 
2.34.1



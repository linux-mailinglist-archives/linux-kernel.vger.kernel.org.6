Return-Path: <linux-kernel+bounces-367083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B599FE69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3371F2537A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192254673;
	Wed, 16 Oct 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3KAxk92"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2345979
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043266; cv=none; b=WTW1MET982sP+XXnBUzVsDOcg2S252syA8iqvoe4XwT43cDKaf7S5GBl0eycN/pTVfQL74nS/MoXW+w5qIK+M4P2VES7H3Nl+nIESeqMP9y+UpoM28GOLSjD8OcJyZzjz1nsjyb2x4dIKcGN1tlCK5F6vU1GBWyMI+H4u62ULSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043266; c=relaxed/simple;
	bh=FsUvpC75BCkuV7TRUQGh6nKVpL6/GjzefHdecmn7QW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZU3P5BpLiudvK0O2M0uEOI6SlofiOBW0MJDR2jH3EWnxBsscq0q4Fog07lq3FMaUCDSXBkUDZh8KubK2lW/D/surJ23LFLVazAAUlKF34mpzmxulbyslABns1A3+c8Snx6EmEBgdVNd2/T1FTtpVRBwjiWKYkQ1boAly5ha6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3KAxk92; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729043264; x=1760579264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FsUvpC75BCkuV7TRUQGh6nKVpL6/GjzefHdecmn7QW0=;
  b=d3KAxk92kYB93ODD8z+mixEWpxi0ExehGBwSWrCwpgKPhD5UwliwmbFK
   zwreU7z371JlERBmOL0b6d2Qbvw2oDtynI0wBNfmB61vhiNpY6juc//A8
   U3VWfoergZbkSu6moLA8XxmmmBBGtrwWP/AZTKxlInM7kCFletkt/2UG3
   SSXwZXWQwqHqayP8dfYVSO//g0e0Jj6mrObkdsyF70lTzxMx7QsIWTEF2
   iB/9ZZn2VQmU1cU51koPcDZbpHelXDjb9mhDT7Ujenr4bVft9SC1pvl2W
   Qlfq77EJ9hlmbCszJgD8T7yw4D9sZoHbHO+vfkcbFIYjsxc2UqKni4qIh
   w==;
X-CSE-ConnectionGUID: RK9AMb71T3uhQzMKY3DY2g==
X-CSE-MsgGUID: JGfUZdn7SRGN9jGZxcmIdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="45970635"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="45970635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:47:44 -0700
X-CSE-ConnectionGUID: 2+5m82mcQS2/l7HB8/mRLw==
X-CSE-MsgGUID: nUpbUYdtRmmgXcixkmk7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82635661"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:47:41 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH -v2] resource: Remove dependency on SPARSEMEM from GET_FREE_REGION
Date: Wed, 16 Oct 2024 09:47:30 +0800
Message-Id: <20241016014730.339369-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to use the functions (get_free_mem_region()) configured via
GET_FREE_REGION in resource kunit tests.  However, GET_FREE_REGION
depends on SPARSEMEM now.  This makes resource kunit tests cannot be
built on some architectures lacking SPARSEMEM, or causes config
warning as follows,

  WARNING: unmet direct dependencies detected for GET_FREE_REGION
  Depends on [n]: SPARSEMEM [=n]
  Selected by [y]:
  - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]

When get_free_mem_region() was introduced the only consumers were
those looking to pass the address range to memremap_pages(). That
address range needed to be mindful of the maximum addressable platform
physical address which at the time only SPARSMEM defined via
MAX_PHYSMEM_BITS.

Given that memremap_pages() also depended on SPARSEMEM via
ZONE_DEVICE, it was easier to just depend on that definition than
invent a general MAX_PHYSMEM_BITS concept outside of SPARSEMEM.

Turns out that decision was buggy and did not account for KASAN
consumption of physical address space. That problem was resolved
recently with commit ea72ce5da228 ("x86/kaslr: Expose and use the end
of the physical memory address space"), and GET_FREE_REGION dropped
its MAX_PHYSMEM_BITS dependency.

Then commit 99185c10d5d9 ("resource, kunit: add test case for
region_intersects()"), went ahead and fixed up the only remaining
dependency on SPARSEMEM which was usage of the PA_SECTION_SHIFT macro
for setting the default alignment. A PAGE_SIZE fallback is fine in the
SPARSEMEM=n case.

With those build dependencies gone GET_FREE_REGION no longer depends
on SPARSEMEM.  So, the patch removes dependency on SPARSEMEM from
GET_FREE_REGION to fix the build issues.

Link: https://lore.kernel.org/lkml/20240922225041.603186-1-linux@roeck-us.net/
Fixes: 99185c10d5d9 ("resource, kunit: add test case for region_intersects()")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea13271..33fa51d608dc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1085,7 +1085,6 @@ config HMM_MIRROR
 	depends on MMU
 
 config GET_FREE_REGION
-	depends on SPARSEMEM
 	bool
 
 config DEVICE_PRIVATE
-- 
2.39.2



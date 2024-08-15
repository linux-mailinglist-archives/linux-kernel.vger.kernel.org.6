Return-Path: <linux-kernel+bounces-287578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BB952987
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2371F226D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0B179954;
	Thu, 15 Aug 2024 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgDUfvHU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12317A598
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704808; cv=none; b=K1RJL5D/8w9LCXphTlIPh99qtVYLYyse7FcsveYdGqDBCwAT7f4hAR4jU+knesm+jD6A3y6RwlLhtPyZNPJmfWw+DN706lWawbG7t/zELBUuU94pwv3Acg1p8EG/lZ3FX966p6zBssh1D5Rxojcw0i1iXlNfVQkVIUeQTjYDQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704808; c=relaxed/simple;
	bh=qFcJrUH4WadkP/m+n3Mzz7m3Ubyih89a8lYNwrTIZeA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRPEu225TbPgfnQo8tCS8Kg5j10u8H3jm8uCoHmY3HYvrU7qyzLEJEdNiuX+H5PhdEFzS7j9aT6kVOnPm/cVISEf8CPt6uN4F8zACWf4udjfYVW8Md0LKjYz4PuswZSSfOXHnd3VWjc8/YlSBv4eBonEkXgt7W0cbeIcdnc3t+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgDUfvHU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704806; x=1755240806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qFcJrUH4WadkP/m+n3Mzz7m3Ubyih89a8lYNwrTIZeA=;
  b=RgDUfvHUJzQC/R6l6VFz43zqDw0M2BG/FkFbpGdTuevJABRO8jG1LPoj
   gN74OaGaT4Yi6si+3IaSwfhMLWwg51OsPS7t1jZ9/bD9lUEYOSNfndw49
   2xeaLbDN+t0VjhzJ4C5lUp5/UbKu0zy0LTzSJparWOE08GdLU51bnW6+C
   NFAkkeMcOwkm637C/YjilHBBB7ACfNv1C9ZejTQJqj3F6eUWsd6ZhkSGk
   QaSJTdUy0FfNjPkE6dE0qkAVPMsfbF2DjSDpqXI+W4w0jlGnc6gg1Amx7
   bu4Lk2lBWdXredqVMbAvd0k9rY/OWCQXm2aqY5gji0+kQHlCmtN3l7Bl4
   A==;
X-CSE-ConnectionGUID: rb3Zj4S+RjSi6klnK3BVkQ==
X-CSE-MsgGUID: 1g0BP7QxTdmWMw4YXTAXHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32528281"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="32528281"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:53:25 -0700
X-CSE-ConnectionGUID: zfRsGCPwQNSX9uAE2H0lgw==
X-CSE-MsgGUID: bBr1uUjkQdS7cg9uI9ynnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="82471513"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa002.fm.intel.com with ESMTP; 14 Aug 2024 23:53:24 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 0/4] Batch IOTLB/dev-IOTLB invalidation
Date: Thu, 15 Aug 2024 14:52:17 +0800
Message-Id: <20240815065221.50328-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOTLB and dev-IOTLB invalidation operations are performance-critical.
The current implementation in the VT-d driver submits these commands
individually, leading to some inefficiencies due to the IOMMU
programming and invalidation command processing overhead for each
operation.

This patch series enhances the efficiency of Queue Invalidation (QI)
operations by adding support for batch processing. Microbenchmarks
show that with a DSA device working in SVA, batching IOTLB and dev-IOTLB
invalidations can decrease the time spent in qi_submit_sync()
by roughly more than 800 cycles.

Changelog
v3:
 * Rebased on 6.11-rc3.
 * Updated commit messages which are revised by Baolu.
 * Dropped the refactoring quirk_extra_dev_tlb_flush() patch.
 * Added "Add qi_batch for dmar_domain" patch which is provided by Baolu.

v2:
 * Rebased on 6.11-rc2.
 * Updated commit messages.
 * Added changes of refactoring IOTLB/Dev-IOTLB invalidation logic
   and quirk_extra_dev_tlb_flush() logic.

v1:
 https://lore.kernel.org/linux-iommu/20240517003728.251115-1-tina.zhang@intel.com/

Lu Baolu (1):
  iommu/vt-d: Add qi_batch for dmar_domain

Tina Zhang (3):
  iommu/vt-d: Factor out invalidation descriptor composition
  iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
  iommu/vt-d: Introduce batched cache invalidation

 drivers/iommu/intel/cache.c  | 239 ++++++++++++++++++++++++++---------
 drivers/iommu/intel/dmar.c   |  93 +-------------
 drivers/iommu/intel/iommu.c  |   6 +-
 drivers/iommu/intel/iommu.h  | 126 ++++++++++++++++++
 drivers/iommu/intel/nested.c |   1 +
 drivers/iommu/intel/svm.c    |   5 +-
 6 files changed, 316 insertions(+), 154 deletions(-)

-- 
2.34.1



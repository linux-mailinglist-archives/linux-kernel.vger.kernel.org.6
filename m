Return-Path: <linux-kernel+bounces-280319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0194C8AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9821B1F2437C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CE17C79;
	Fri,  9 Aug 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9W2pB41"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38403179BF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172192; cv=none; b=iLPabyz4y4HNlI3WHnq8QC0K6UtGztprAQOCPsLFHwzM8f84uoCAgDEoGNXkmNLZ4FkrCYV3u5RO3YG2rGr5uiYJJAOKOXN7htJ1PAq9Iss/H6dvZbqcqQ2vCPGrWFdCH4jyxX7IF6Y/3GRo3TXZhcbivzyENkE67OIcOE+Ah4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172192; c=relaxed/simple;
	bh=ZHR3bn5YiotMIl1qC+ckMw73ABf9i1FE7xtEpzkgrUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPriwuzpRaGNYMbRzMHLVpu2YzR7g8i0ozwVVA0cs0u0BG5DECQX8IJ+YS++zHrMSl4bfq/7wx3uSyVGaHmBWLZpdTYiBQqIBMCF1lo35M1Lyb3FQhI3wpC8b+3yPOJSWExT4KL+otYjWbCbltDaVxMd0+rCZLVxtxzgYbhdHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9W2pB41; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723172191; x=1754708191;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZHR3bn5YiotMIl1qC+ckMw73ABf9i1FE7xtEpzkgrUY=;
  b=N9W2pB41eXUqcbBIx6/h0Y7LzwuppmzNeV7+K/A/Pvj3+q4CZCIxUq+s
   pKzqCKj6/JBsKjOnIdFoPP9FaS6/RFvB0kPKTkLg9XDo7lyqQDf4vpgFn
   6pECvPpzcYI/joyK12amtXPqgPp7Rk2xDA618llF2q9CN1quL3xernTQd
   z6cdT/aQ7Qv6o9fa39ixwJE1qqw9JzSD3w0aBDJTINY+mWxn/G49zhj7H
   hGO1R+nheAyxWzhYAItNYIWW6ZQQkUiwo72qmCIwZyzSJJofQJo4KN8c5
   oiICcAtYwpz/0DBzYetxJ4vZOWxRP97mZMSqVW89ffxV0qYSMOqegRkOT
   Q==;
X-CSE-ConnectionGUID: MPJ55IgFRKirjKOyWfQD/Q==
X-CSE-MsgGUID: K5NftRG/Qe6iJ3akhUnLeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24239348"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="24239348"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:56:30 -0700
X-CSE-ConnectionGUID: /Iv2pn6fTCWgc2jgCbLPnw==
X-CSE-MsgGUID: IB1TWKU5R/Cx8wAjpvclhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62072641"
Received: from desktoptgl-tinazhang.bj.intel.com ([10.238.156.103])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 19:56:22 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 0/5] Batch IOTLB/dev-IOTLB invalidation
Date: Fri,  9 Aug 2024 10:54:26 +0800
Message-Id: <20240809025431.14605-1-tina.zhang@intel.com>
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
v2:
 * Rebased on 6.11-rc2
 * Updated commit messages
 * Added changes of refactoring IOTLB/Dev-IOTLB invalidation logic
   and quirk_extra_dev_tlb_flush() logic

v1:
 https://lore.kernel.org/linux-iommu/20240517003728.251115-1-tina.zhang@intel.com/

Tina Zhang (5):
  iommu/vt-d: Refactor IOTLB/Dev-IOTLB invalidation command logic
  iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush logic
  iommu/vt-d: Introduce interfaces for QI batching operations
  vt-d/iommu: Refactor quirk_extra_dev_tlb_flush()
  vt-d/iommu: Enable batching of IOTLB/Dev-IOTLB invalidations

 drivers/iommu/intel/cache.c | 269 ++++++++++++++++++++++++++--------
 drivers/iommu/intel/dmar.c  | 281 +++++++++++++++++++++++++-----------
 drivers/iommu/intel/iommu.c |  56 +++++--
 drivers/iommu/intel/iommu.h |  44 ++++++
 drivers/iommu/intel/svm.c   |   5 +-
 5 files changed, 491 insertions(+), 164 deletions(-)

-- 
2.43.0



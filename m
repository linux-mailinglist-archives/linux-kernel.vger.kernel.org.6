Return-Path: <linux-kernel+bounces-231752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CF919D41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9E5B20DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016CDF6C;
	Thu, 27 Jun 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAA//8Fi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941BFBE8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455647; cv=none; b=QVv89vX0xjqn2S2+bPRCvcau6V1o64IG5f+dAmcWAqFQTCV5lhPu03YKGzxHg2jLsZ5rZWEY8DDKlEvHuxkW5LhAY39nRxoi2/ulpAKpeykAdZUdil2JJogbnZcsipqvDqYjA1a+m9xk85jhpd3dtLUxh6WUYRxr+jpsHHaQvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455647; c=relaxed/simple;
	bh=uhT9No+0wyYhMA8btKDJrjBmA4A+FpJc2RdTEzaIQS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HM+WB7/hhfYF1yImF9w6IWasSo/7Dfu6tlBLNLU2jje9HRL5mUi+wg1mSO3YIRtfYumbBJCQxNkbcKjOi+5sHoxPVgpG4l/wENxJcyOeQG0OJjjg2ZXXhB/MplPntxfRg8Z3rXSaWRO1mXOTTWMHtc963x2t/pXppcmUSkeYfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAA//8Fi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719455644; x=1750991644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhT9No+0wyYhMA8btKDJrjBmA4A+FpJc2RdTEzaIQS4=;
  b=WAA//8FiDfrRiqMTlZBVf/hJLJLxOBK2rfAcNSxIFnt0B/eQdlXQSK+G
   ag7RQ7D11xNt6LzgZUcB/7O60mKaowkpzc7MPf7OdwvagLJCut8LjVTe7
   91uytvtrbDEGGQc/9A638sEJa5hIORJ0cP4eT4rXmBX6lIhL9WXB3M2Eh
   uoOVaAElNk+BIBz0b0QvSnje4lVut8O/JkIY+K2zcRqWQVLzoqJCID9M6
   OAx2OALu6FOCHBFNadO+ahQmGKy20HA54ZsZv0d+0JfFhtgKpLETRsxJ+
   GPtJ08ht1gQwExbrR0sjoPXMmOJKXKekyj++DFXQGpEw+AsR4BI5qNPaK
   g==;
X-CSE-ConnectionGUID: DOr9xr+UQs2zDci/CXGQAg==
X-CSE-MsgGUID: htg35OmsReORERfbWoMUiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16786006"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16786006"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:34:04 -0700
X-CSE-ConnectionGUID: gZyHkqiITtOc6a4kO7EhRw==
X-CSE-MsgGUID: 82SAhlGPQbS7AAF/tzb0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="49385420"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2024 19:34:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Refactor PRI enable/disable steps
Date: Thu, 27 Jun 2024 10:31:19 +0800
Message-Id: <20240627023121.50166-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page fault handling framework within the iommu core has defined the
PRI enable and disable flows in the comments for the
iopf_queue_remove_device() interface. This series aims to refactor the
PRI enable/disable steps in the Intel iommu driver to align with these
definitions.

Change log:

v2:
 - The cache invalidation for a context entry change should not affect
   the devices not related to the entry. Fix this by always using
   device-selective cache invalidation.
v1:
 - https://lore.kernel.org/linux-iommu/20240606034019.42795-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Add helper to flush caches for context change
  iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks

 drivers/iommu/intel/iommu.h |  13 +++++
 drivers/iommu/intel/iommu.c |  89 ++++++++++++++++++-------------
 drivers/iommu/intel/pasid.c | 103 ++++++++++++++++++++++++++++--------
 3 files changed, 148 insertions(+), 57 deletions(-)

-- 
2.34.1



Return-Path: <linux-kernel+bounces-236126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A791DDCB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331371F221D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED0113D2A2;
	Mon,  1 Jul 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngoorwwG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2512FF6E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833168; cv=none; b=OWp2W4+irS6hDosRdCYBQB2tbYyM/PNmbledDq+AQX6y5AigI1CGtBCyAXaYpt2rVIwxl+nl5iPBrRbbrbI9dhgd8wbi91k5MqinBt4Ci8WThFvXULw+YAtGcozBOKX7B24OTHuhkhTRBuhbGsKQ2LtIZV0ujehDyMj+3kQBUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833168; c=relaxed/simple;
	bh=UOh6NAvLh2/t+MdkU3eCMHEeuBRILMY37d1QyUjHMks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDThtqpIBhWeeXLgbn5xkdq7yCxGp8Zp4hfYqfm0LdiCOq49fQrrRm84V9pJ8FDNQ4RgWspTD1e92jCM73PHZbmzs/eqx3/XKJHZjg+mDBOFPG2MT0TyEdH28Ix5weUevFnTdymkqrTDBw0R16nWXDBRc1O25miHWl/BOJl7y+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngoorwwG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719833167; x=1751369167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOh6NAvLh2/t+MdkU3eCMHEeuBRILMY37d1QyUjHMks=;
  b=ngoorwwG6lODtaY9X5fyBh5RUup5IO7P2GuVuRjdRPzbLgBREpcyFEgv
   ZC2YyQXypf6SZuHh3u8eTetf5DYYFkgwXLcyknmr5f9cLpEMyk6a5mExh
   BdDcgHX9vmO1qRfp8rYYkVP5HHInUnHJ03vmv9rEVQHRbjpkT4wjtx2nt
   mpGdbyWbGqaNl6prLOYEL+UXFPu8APLd2lCLn6FbjXkKPwAMWDSi8cNKb
   7EPi971BzVtRyL2mzhmAnxqrq6UWb2qkA/ID06j1w0oH0PZ7bW7sZXRC5
   voXTF4K0tRX6t2VP+ntDD9sOCOEM2vrRmvUk1KPOusHrAgf2ainT0nNZJ
   w==;
X-CSE-ConnectionGUID: uptc2m9DRj6IH71kPdEhtQ==
X-CSE-MsgGUID: W8MtdKuzRcm2U5tkCxPBAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17082651"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="17082651"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 04:26:05 -0700
X-CSE-ConnectionGUID: GGVS+OMgSvSTvNdJkxv3BA==
X-CSE-MsgGUID: 5LoLl3lERlyxE8Aty3ywIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45481415"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jul 2024 04:26:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/2] iommu/vt-d: Refactor PRI enable/disable steps
Date: Mon,  1 Jul 2024 19:23:15 +0800
Message-Id: <20240701112317.94022-1-baolu.lu@linux.intel.com>
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
v3:
 - Refine the lock requirement. Only assert the lock when it is
   required.

v2:
 - https://lore.kernel.org/linux-iommu/20240627023121.50166-1-baolu.lu@linux.intel.com/
 - The cache invalidation for a context entry change should not affect
   the devices not related to the entry. Fix this by always using
   device-selective cache invalidation.
v1:
 - https://lore.kernel.org/linux-iommu/20240606034019.42795-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Add helper to flush caches for context change
  iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks

 drivers/iommu/intel/iommu.h |  13 +++++
 drivers/iommu/intel/iommu.c |  89 +++++++++++++++++------------
 drivers/iommu/intel/pasid.c | 108 +++++++++++++++++++++++++++++-------
 3 files changed, 153 insertions(+), 57 deletions(-)

-- 
2.34.1



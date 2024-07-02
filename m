Return-Path: <linux-kernel+bounces-237814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B8923E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1580B1C21B31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E019DF72;
	Tue,  2 Jul 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB+TECet"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11B19D085
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925885; cv=none; b=nZHkpqx1X5nlsC3viRvzyG/AmzAkX35ZWn/niMKkpT4MisAcC1IZHEu5p+RAXJ+tiNeay4bX8OOFZo24yKaRCaxwchSysRfZot/eW5Otc8vDp6EtuDoQnlEbMGVAkAyfj4WuaAoVGKKJMrjZmMX5orjyLVaUmWcils4s7iTlRFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925885; c=relaxed/simple;
	bh=YZn0x+z03ip1L3EiHj1D9rs3c6TN7O0rjwXqtOiBDSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2xdHxe5tjzGM7iPY/H19qRQW3l0b8bWdQ4c3eMgvVLJie2nKNZ9T2UF+iw/Qvu0lSRBaCuV+M13cOG0ad/4fiCKRKG3lMumSdpltQS4Z9xa30SStL1nKqcRfiiVWeTBW3P/1P44XRalIStDkHh7vv3GlBcVkSsQPz4d7bJ3Kt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB+TECet; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925884; x=1751461884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YZn0x+z03ip1L3EiHj1D9rs3c6TN7O0rjwXqtOiBDSg=;
  b=lB+TECet4Ix3Mz3YMMYuD5qbyh7uBrNW5pgCNQcf/vXyjcMbiQFccMtz
   yqSWHtmK/sFSKnuvB/UYyqBgsjHZjwDbkSWj8QPEeDk2tbZK+X9/Twle6
   RPfQMZs+GEYNjXwjyWcfsXlZ1aVc3FsLVCSBptMXIBqDl+h8sS18p6IOW
   vA39vwMCKhjh8sp/b04EpQpNyIRyaGxEriXkBLd3VLQ/skhQeRdMWlZQM
   ofjSCP3XY5Od7VBUyEPXc5krI8R9qVzori9PQG530Ocn3zZgaeWP6XRev
   uiWsUXaaUgD3JfRT+xMC8E53zPpkILQE5UPcXZFaadR889EvOP8biK583
   Q==;
X-CSE-ConnectionGUID: ZaP/gynDRUiZVeL0rObjjg==
X-CSE-MsgGUID: i8Qad9YNQCOZJua1fGOMRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27699990"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27699990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:24 -0700
X-CSE-ConnectionGUID: Cp6LEnc3RneOefPsy3tz8w==
X-CSE-MsgGUID: XrLZzZWXQqOY9qEQ/qDdPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250826"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] [PULL REQUEST] Intel IOMMU updates for v6.11
Date: Tue,  2 Jul 2024 21:08:32 +0800
Message-Id: <20240702130839.108139-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will,

The following changes have been queued for v6.11-rc1. They are all about
small refactoring, including:

 - Use READ_ONCE to read volatile descriptor status
 - Remove support for handling Execute-Requested requests
 - Downgrade warning for pre-enabled interrupt remapping
 - Remove calling iommu_domain_alloc()
 - Refactor the PRI enable/disable flows
 - Cleanups

These patches are based on v6.10-rc5. The complete patches are also
available at:

https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.11

Please consider them for iommu next.

Best regards,
baolu

Jacob Pan (1):
  iommu/vt-d: Handle volatile descriptor status read

Lu Baolu (6):
  iommu/vt-d: Remove comment for def_domain_type
  iommu/vt-d: Remove control over Execute-Requested requests
  iommu/vt-d: Downgrade warning for pre-enabled IR
  iommu/vt-d: Add helper to allocate paging domain
  iommu/vt-d: Add helper to flush caches for context change
  iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks

 drivers/iommu/intel/iommu.h         |  19 ++-
 drivers/iommu/intel/pasid.h         |  10 --
 drivers/iommu/intel/dmar.c          |   2 +-
 drivers/iommu/intel/iommu.c         | 194 +++++++++++++++++++---------
 drivers/iommu/intel/irq_remapping.c |   4 +-
 drivers/iommu/intel/pasid.c         | 109 ++++++++++++----
 6 files changed, 241 insertions(+), 97 deletions(-)

-- 
2.34.1



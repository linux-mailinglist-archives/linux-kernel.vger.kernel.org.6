Return-Path: <linux-kernel+bounces-553504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DE7A58AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 03:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC39188DAA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 02:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D8153BF0;
	Mon, 10 Mar 2025 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2XlNm0Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB242A93
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574865; cv=none; b=PMVmMk+VfB0S5qZolToyU0X4EE7O4ZNKky/9GlrbNFz8FGJJ06VZ+QWbjyMP+ujwabSlVXLBHQ+fwp4901vpmUILun7CvacL+MTrwF2OWtdEUpRFpEQKPXi9T+1ggrl9Alq9msHYUOFD8IpNwnCK79PIToqlUTtju0mby7+eskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574865; c=relaxed/simple;
	bh=LbmK2ae0pXBLOUD1NM6z/Pl0jrpB+bHqVqnVzchGmTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjRrO2o9tFkmUyGiFKdq2fnfcmfqq5PvNXnI1pB2xirmmc1etmc5LQ/22yC/okRHX6oLOREr1t4Jue3EArSaDT1rbxIDDJc4Lf7+To7kLCIgtLUwDgp1xOI1PG1o2X2rYvfSiEgXZYLgUGQO6R+1cPNzUM0z43OXYXX9ACsBN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2XlNm0Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741574863; x=1773110863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbmK2ae0pXBLOUD1NM6z/Pl0jrpB+bHqVqnVzchGmTw=;
  b=j2XlNm0Zgfz5/7I2b0xr8yRE5HejhP1WIstlS1qomi+uQ6esyk075axM
   7x6dbaJ6VktPbDA+/knPBsSVKJp0idQAw1edpO31jjP2W+fb8ZV8CoInC
   rkfJL0VzFPLrkDD0iykoo9Lajdcl8H7ULzfRCIwWPnit/7zRV3Tbkopny
   jHxc57dX6Xz3SHv9i3PA1wPlnhir0w3MwmBHUeI9qwdmPUE+6pE6yKhrD
   TC7vzGPAJ8dijWBoMkQP3E7N1yr9ciVqHRLtxOWk5WIMTX1sNyvlgfypO
   5O6XKQGWcaD21HrIZF1D3+iMQO+rbUkRFFMy3Z4YBPURDEBRuIjHMS9qA
   w==;
X-CSE-ConnectionGUID: ILFKi8U1SemrqiUrIFsiQg==
X-CSE-MsgGUID: yGmnLQd3QEWjwlDeI4q0Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42401588"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42401588"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 19:47:38 -0700
X-CSE-ConnectionGUID: jBWc2Th7RqKSLvyDrCiVhA==
X-CSE-MsgGUID: JSnsBpMyQIGpalNi+xP6bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143079227"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2025 19:47:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] iommu/vt-d: Fix system hang on reboot -f
Date: Mon, 10 Mar 2025 10:47:44 +0800
Message-ID: <20250310024749.3702681-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunhui Cui <cuiyunhui@bytedance.com>

We found that executing the command ./a.out &;reboot -f (where a.out is a
program that only executes a while(1) infinite loop) can probabilistically
cause the system to hang in the intel_iommu_shutdown() function, rendering
it unresponsive. Through analysis, we identified that the factors
contributing to this issue are as follows:

1. The reboot -f command does not prompt the kernel to notify the
application layer to perform cleanup actions, allowing the application to
continue running.

2. When the kernel reaches the intel_iommu_shutdown() function, only the
BSP (Bootstrap Processor) CPU is operational in the system.

3. During the execution of intel_iommu_shutdown(), the function down_write
(&dmar_global_lock) causes the process to sleep and be scheduled out.

4. At this point, though the processor's interrupt flag is not cleared,
 allowing interrupts to be accepted. However, only legacy devices and NMI
(Non-Maskable Interrupt) interrupts could come in, as other interrupts
routing have already been disabled. If no legacy or NMI interrupts occur
at this stage, the scheduler will not be able to run.

5. If the application got scheduled at this time is executing a while(1)-
type loop, it will be unable to be preempted, leading to an infinite loop
and causing the system to become unresponsive.

To resolve this issue, the intel_iommu_shutdown() function should not
execute down_write(), which can potentially cause the process to be
scheduled out. Furthermore, since only the BSP is running during the later
stages of the reboot, there is no need for protection against parallel
access to the DMAR (DMA Remapping) unit. Therefore, the following lines
could be removed:

down_write(&dmar_global_lock);
up_write(&dmar_global_lock);

After testing, the issue has been resolved.

Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
Co-developed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Link: https://lore.kernel.org/r/20250303062421.17929-1-cuiyunhui@bytedance.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bf1f0c814348..25d31f8c129a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2871,16 +2871,19 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
 
-	down_write(&dmar_global_lock);
+	/*
+	 * All other CPUs were brought down, hotplug interrupts were disabled,
+	 * no lock and RCU checking needed anymore
+	 */
+	list_for_each_entry(drhd, &dmar_drhd_units, list) {
+		iommu = drhd->iommu;
 
-	/* Disable PMRs explicitly here. */
-	for_each_iommu(iommu, drhd)
+		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-	/* Make sure the IOMMUs are switched off */
-	intel_disable_iommus();
-
-	up_write(&dmar_global_lock);
+		/* Make sure the IOMMUs are switched off */
+		iommu_disable_translation(iommu);
+	}
 }
 
 static struct intel_iommu *dev_to_intel_iommu(struct device *dev)
-- 
2.43.0



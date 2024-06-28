Return-Path: <linux-kernel+bounces-234627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834191C8B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CF51F2341D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21A1C8FA0;
	Fri, 28 Jun 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhA/bwOQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607C13DDDA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611800; cv=none; b=I7qcYJnuVRGxjtkQd2qcXE9CwN5uSBs4ueHjHVcUOBA+FoLLo6335fdT/N2bEHMrH68zLg6DdkTUbZApi3PD3iin/+BMUULiHSaHyMkbW6jzPSXcnglKDfSGTEB7SpjMIEZzPTEd/Ibu8xEZEavJdoBg5yAsExFWFq2l03iODTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611800; c=relaxed/simple;
	bh=2l7f6lDOELlYeE6YGD7wOuDWjXUX38xsa3dzLbcLFzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=self+mOd5WM4l+MZpHSz0EiE89rgqcQzPp7+Um3IbXxzBI1+a8FShpyCNGlokmTgsGmt9EGu0TAGH3o6e6ZPUrymBmn8ucXTCF9LqB8vjhwgt3x7aay1azRitpHafIWDw6KXTq7ucWiWDkZsXZfC4nCPW0Ruc4q0TrT9J179nE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhA/bwOQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719611799; x=1751147799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2l7f6lDOELlYeE6YGD7wOuDWjXUX38xsa3dzLbcLFzk=;
  b=mhA/bwOQvdbRcKijhWQV9/vn95bnMprKM4dPXMaH5kg2FTPqiaYy278Y
   7PBQmuWjm6pQYYWwkYheWCRGLOaSYNEWnRHv7LvpF+funGEqa6iYOfrHa
   YGv3/UtBmWecXjYuk8jtwzRJXlrO5H7TdXVH6+VpWGsGdx3a5F1tUL2mi
   oLNsKAyheKiGB4PqNFkBLzqr+J/fHzkvd0veyYN98Aoxci84Qtl/g1Ul6
   HIdAeaZIQRV1GVdubG+I/ImKIDTcS/huh8UKk3mLX5G7HVXxY4c7OWb2a
   FAVPXNv2zyQy7ltvzuqj0Mb+8bqVPxoJO9fz+5ivOfFG3IYR+SDyl4eY2
   A==;
X-CSE-ConnectionGUID: xr+W5cWNTCCOWbNsdm/OMg==
X-CSE-MsgGUID: DOLlrOdMQCGmMoN2VNxDNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16762656"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16762656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
X-CSE-ConnectionGUID: CiKeyujKT6mFC6FPuFRhAA==
X-CSE-MsgGUID: 5XLIWAw+T32RV/vwacZ9tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="68065690"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 14:56:28 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v23 19/19] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date: Fri, 28 Jun 2024 14:56:19 -0700
Message-ID: <20240628215619.76401-20-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628215619.76401-1-tony.luck@intel.com>
References: <20240628215619.76401-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Sub-NUMA Cluster (SNC) mode enabled the scope of monitoring resources
is per-NODE instead of per-L3 cache. Backwards compatibility is maintained
by providing files in the mon_L3_XX directories that sum event counts
for all SNC nodes sharing an L3 cache.

New files provide per-SNC node event counts.

Users should be aware that SNC mode also affects the amount of L3 cache
available for allocation within each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 627e23869bca..a824affd741d 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -375,6 +375,10 @@ When monitoring is enabled all MON groups will also contain:
 	all tasks in the group. In CTRL_MON groups these files provide
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
+	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
+	directories for each node (located within the "mon_L3_XX" directory
+	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
+	where "YY" is the node number.
 
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
@@ -484,6 +488,29 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
 each bit represents 5% of the capacity of the cache. You could partition
 the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Notes on Sub-NUMA Cluster mode
+==============================
+When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
+nodes much more readily than between regular NUMA nodes since the CPUs
+on Sub-NUMA nodes share the same L3 cache and the system may report
+the NUMA distance between Sub-NUMA nodes with a lower value than used
+for regular NUMA nodes.
+
+The top-level monitoring files in each "mon_L3_XX" directory provide
+the sum of data across all SNC nodes sharing an L3 cache instance.
+Users who bind tasks to the CPUs of a specific Sub-NUMA node can read
+the "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes" in the
+"mon_sub_L3_YY" directories to get node local data.
+
+Memory bandwidth allocation is still performed at the L3 cache
+level. I.e. throttling controls are applied to all SNC nodes.
+
+L3 cache allocation bitmaps also apply to all SNC nodes. But note that
+the amount of L3 cache represented by each bit is divided by the number
+of SNC nodes per L3 cache. E.g. with a 100MB cache on a system with 10-bit
+allocation masks each bit normally represents 10MB. With SNC mode enabled
+with two SNC nodes per L3 cache, each bit only represents 5MB.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
-- 
2.45.2



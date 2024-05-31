Return-Path: <linux-kernel+bounces-196482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991A8D5CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D1B2884E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FB15098A;
	Fri, 31 May 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGaubPSD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0C1514C9;
	Fri, 31 May 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144563; cv=none; b=d3+hvm+snbWLXk3S5/g6tVNHPy96laRFSQSqiDM02J6HMjRQZvZSmDYEQWLI/R8AfvHGN+WSXghTP1JwdkYs+iOBzVO8a1RMX5yyUJ3/B/AHPdMK8ECW/OGmDeAwAKZBNofFSeEEmwbnjEguiD8LgKrf+uXL5M5LOqva84xjjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144563; c=relaxed/simple;
	bh=oPjqob5N5cGr1+eQPADcKbdsHGnfiLSEJTNGMcq9Vqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKX6Wtq2slSfe3dzGNYwSubANeJo3IQ1iVXDMp+fwuHra/AZMMxkURfTmZKxFz9wVEUfP/d7MvH7u3wpETFg/jVAmQFeEyS6AKODbGSJIuUxYk8xXF5c3FBSCXgkoTE+j/Ib+swn2vQWkHDLdyGdia/vWWcH/zdt4r7bgi73Fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGaubPSD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717144562; x=1748680562;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oPjqob5N5cGr1+eQPADcKbdsHGnfiLSEJTNGMcq9Vqk=;
  b=IGaubPSD5iezZ5dDM5z743ejwqvVgSI4Oo/A//e/WbZ8OphZVRiVhTbw
   KE7eP8ht0/T308K7Kz/mzS0yGLQC+6+OoUbvhy4Bd1JzynOOA7PZOGDdI
   0OvLqEKn5MPMgKEfflfDW8msemIHqNPPHC6/qkpB0syBgZ3HBV0sx6+zV
   eTWMejGSlr1tgpQ7l4R9IKteEXeis81fFyFxKdK2ByoOjMXSaRHLacgMH
   KMsVFRLOeg0hbtVniuuPTADu6eD5FrwOsEjWMQb19Ls6zIO/B4oAMtOeH
   JdMFGpnzfO/b2TnKHzDdTFS6heaL+605snPc0Eu1bv/8QGDYpGgbqccpF
   g==;
X-CSE-ConnectionGUID: cKAbEJemRaOpWGO+IiAc2Q==
X-CSE-MsgGUID: xr3xZXWHQ4qgN9DJ1K+mmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13495952"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13495952"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:36:00 -0700
X-CSE-ConnectionGUID: guMTEGOgSb+G3eMlyWo4ew==
X-CSE-MsgGUID: A0HucA7vSR2wOt4fcnHalQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36193452"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2024 01:36:00 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	rui.zhang@intel.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/3] platform/x86: ISST: Avoid some SkyLake server models
Date: Fri, 31 May 2024 01:35:47 -0700
Message-ID: <20240531083554.1313110-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
References: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SkyLake server variants don't support any SST functionality. No use
of providing any SST related interfaces on them.

All supported SkyLake servers provide mailbox interface via MSR. So check
for the presence of MSR 0xB0 and 0xB1. If not present don't load common
module.

Move defines for MSR_OS_MAILBOX_INTERFACE and MSR_OS_MAILBOX_DATA to
common header file to avoid duplicating them.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
New patch, split from v1 1/2
The mbox MSR defines are moved to common header file to avoid duplicates

 .../x86/intel/speed_select_if/isst_if_common.c      | 13 +++++++++++--
 .../x86/intel/speed_select_if/isst_if_common.h      |  3 +++
 .../x86/intel/speed_select_if/isst_if_mbox_msr.c    |  2 --
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 47f5f26e6c20..7ea058571ab5 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -814,6 +814,7 @@ void isst_if_cdev_unregister(int device_type)
 EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 
 #define SST_HPM_SUPPORTED	0x01
+#define SST_MBOX_SUPPORTED	0x02
 
 static const struct x86_cpu_id isst_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
@@ -824,7 +825,7 @@ static const struct x86_cpu_id isst_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
 	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	0),
-	X86_MATCH_VFM(INTEL_SKYLAKE_X,		0),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		SST_MBOX_SUPPORTED),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, isst_cpu_ids);
@@ -837,8 +838,16 @@ static int __init isst_if_common_init(void)
 	if (!id)
 		return -ENODEV;
 
-	if (id->driver_data == SST_HPM_SUPPORTED)
+	if (id->driver_data == SST_HPM_SUPPORTED) {
 		isst_hpm_support = true;
+	} else if (id->driver_data == SST_MBOX_SUPPORTED) {
+		u64 data;
+
+		/* Can fail only on some Skylake-X generations */
+		if (rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data) ||
+		    rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data))
+			return -ENODEV;
+	}
 
 	return isst_misc_reg();
 }
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
index 1004f2c9cca8..378055fe1d16 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.h
@@ -16,6 +16,9 @@
 #define PCI_DEVICE_ID_INTEL_RAPL_PRIO_DEVID_1	0x3251
 #define PCI_DEVICE_ID_INTEL_CFG_MBOX_DEVID_1	0x3259
 
+#define MSR_OS_MAILBOX_INTERFACE		0xB0
+#define MSR_OS_MAILBOX_DATA			0xB1
+
 /*
  * Validate maximum commands in a single request.
  * This is enough to handle command to every core in one ioctl, or all
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 1b6eab071068..48b608eaca5f 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -21,8 +21,6 @@
 
 #include "isst_if_common.h"
 
-#define MSR_OS_MAILBOX_INTERFACE	0xB0
-#define MSR_OS_MAILBOX_DATA		0xB1
 #define MSR_OS_MAILBOX_BUSY_BIT		31
 
 /*
-- 
2.40.1



Return-Path: <linux-kernel+bounces-572089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D66A6C65B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1122C48403B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9E238D45;
	Fri, 21 Mar 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmErGH10"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEB236A62
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598992; cv=none; b=YKyJihK0SrFbaooY3NXRP68KZJmB+4L3cU8UllONxJKIjlw+kxcjIuZLVVmx0w9Q+lBIVlL6mrGGx++kWq0xtnzXL6/L1mEHr2Ltz/R7yMqurR0rkP3sbhfruBwfVfLwuAMh6Kp7WWhef6vTi14Rqf0HdLS1R6L2ad16+FrXWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598992; c=relaxed/simple;
	bh=zyJSs4pgybNOmlhgq1YSJUekw4r0a/e87UbI4q1QkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3pCy0gB7YGBUWtes01sE8iAw3rMKZFGrnRpw+UuCYNMCSIBD+g16jCbbOuD+Gurjz2BW404GT6g/rd/irB2U22hlnpN9PycZWOZQgM/vbrYF29aP0ZaiQ47Uy61owJv/I9Z9gor7g7tXVxrMPbw/amREoF0CJZPQBiHxBvDOzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmErGH10; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598991; x=1774134991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyJSs4pgybNOmlhgq1YSJUekw4r0a/e87UbI4q1QkN0=;
  b=MmErGH10jd6LzhEepSWq6roQL7HFYH0hkFTM2/5m4qa40Q8c+5/6jOb3
   An32oJ4gIBaDz5okbDImPWWvtbDqKz5oUnXE/V/4i2Xb+nzIsJqvFEu7/
   bTT6Du86n57eVkWGJazxf/ZA/HJ2fELDFxIpdMLqsTUSjpkaI8dV4JKSs
   uSz3abPOT1FjJjbgXnhe+uWBNzyOFqxUh0zJrbfNRlhxVWDKsErHJWRjx
   qJ58LRI1JjC3ZBCyUXIgRW6r0xgno3br0EHBtqeBzOv86YDJ89mtfWY4L
   prtVdWuSDzMK301dOLd7+fw6wVxX67+YReEghK7fiMXmek/zxq7H0BEq/
   Q==;
X-CSE-ConnectionGUID: OYhPaVuMTu6SXrxUJsLeOw==
X-CSE-MsgGUID: +nIcPXc+QOmpTHveZ/ld5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43604655"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43604655"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:25 -0700
X-CSE-ConnectionGUID: U3x594cXR1uLlU/ztr53uQ==
X-CSE-MsgGUID: I6ii42T0QG6dLYNPLYYv6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128354340"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:25 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 16/16] x86/resctrl: Update Documentation for package events
Date: Fri, 21 Mar 2025 16:16:06 -0700
Message-ID: <20250321231609.57418-17-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321231609.57418-1-tony.luck@intel.com>
References: <20250321231609.57418-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each "mon_data" directory is now divided between L3 events and package
events.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/filesystems/resctrl.rst | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 6768fc1fad16..0e915b7c55aa 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -366,15 +366,22 @@ When control is enabled all CTRL_MON groups will also contain:
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
-	directories have one file per event (e.g. "llc_occupancy",
-	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
-	files provide a read out of the current value of the event for
-	all tasks in the group. In CTRL_MON groups these files provide
-	the sum for all tasks in the CTRL_MON group and all tasks in
-	MON groups. Please see example section for more details on usage.
+	This contains a set of directories, one for each instance
+	of an L3 cache, or of a processor package. The L3 cache
+	directories are named "mon_L3_00", "mon_L3_01" etc. The
+	package directories "mon_PKG_00", "mon_PKG_01" etc.
+
+	Within each directory there is one file per event. In
+	the L3 directories: "llc_occupancy", "mbm_total_bytes",
+	and "mbm_local_bytes".	In the PKG directories: "core_energy",
+	"activity", etc.
+
+	In a MON group these files provide a read out of the current
+	value of the event for all tasks in the group. In CTRL_MON groups
+	these files provide the sum for all tasks in the CTRL_MON group
+	and all tasks in MON groups. Please see example section for more
+	details on usage.
+
 	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
 	directories for each node (located within the "mon_L3_XX" directory
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
-- 
2.48.1



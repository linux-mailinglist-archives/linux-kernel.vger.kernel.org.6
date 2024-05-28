Return-Path: <linux-kernel+bounces-193174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754728D27F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318DD28A85E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDED145B07;
	Tue, 28 May 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kj5rdyzj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00141442ED
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934831; cv=none; b=FrwTttjSCLWf4VYdzPmiVk/p9+1GI1ERQTGzYuStpYPHYT0B/ys/OQ4vbzuLDCFDsH/1hk1h5tb9Qszo0Mbhvtm7QApNedGIxlV413tiXHxZXpwK7IuYaiQpYDYPO5PF/ex/S1JMkg01AhoAvl0syZHr7G/54+VD7sCu2CqoVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934831; c=relaxed/simple;
	bh=MEbLVytHgbRbmQpGtYO+XqR9GjkKAJY7wKHhQb0mGU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6o39TLaj6nDL3dxzDvLj/WoS+qhsLZH5GT+EuEaztb/NUZ8vELCbajZU5IYa9Fby053PgAzTUQokwpPjsOnJ6rL1nw/qeNAmAuSFU2nOXiA9CG0C1hQMgDdjupYzgCPL7meLtcEP2moyWpy3Dtzt5qPJQYij0t/jLbxX4q1wPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kj5rdyzj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716934830; x=1748470830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MEbLVytHgbRbmQpGtYO+XqR9GjkKAJY7wKHhQb0mGU0=;
  b=kj5rdyzjRJwAtIgU9qhu64IDb7xmB0jdKdg+sKi8T3kkNljmcB6IKPzJ
   jBNc6RqD2qdG01I+w+Zt47T1AvEiMdloIAv3Oz5H/zgR6AH5Yyo0qRvGs
   RPCWixG/oWxnAlVVJ02Cut2OCTYWPt4BWhunnXmqQ9yjgU+h8dlzlaIxt
   4E6zceQ/omj4rGk8qup+0WE+qe491N7CiDhqV67n1jCJKmcEECL/DsFv6
   ZvGvQO6kqYp3aCDcW7Y8AgX/wSE4A3TBgIM6azi4bgXeNm1/LYJvFFSFt
   UP+Y154IsAzPLnvb+FLFfp1jQkABiO8N86FgbmlNW3OVWNzRuZIlw0xTQ
   Q==;
X-CSE-ConnectionGUID: gl0ZeNWdRo27G+F4VIM2bw==
X-CSE-MsgGUID: nTukjUasReO7twZ0o8kITQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30812275"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="30812275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:20 -0700
X-CSE-ConnectionGUID: RZgDn3zySHetheQ/gIfjEA==
X-CSE-MsgGUID: +eS7IboOT5GvTqmldqgNyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40090800"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:20:20 -0700
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
Subject: [PATCH v19 20/20] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date: Tue, 28 May 2024 15:20:05 -0700
Message-ID: <20240528222006.58283-21-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528222006.58283-1-tony.luck@intel.com>
References: <20240528222006.58283-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
their name refer to Sub-NUMA nodes instead of L3 cache ids.

Users should be aware that SNC mode also affects the amount of L3 cache
available for allocation within each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 627e23869bca..401f6bfb4a3c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -375,6 +375,10 @@ When monitoring is enabled all MON groups will also contain:
 	all tasks in the group. In CTRL_MON groups these files provide
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
+	On systems with Sub-NUMA (SNC) cluster enabled there are extra
+	directories for each node (located within the "mon_L3_XX" directory
+	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
+	where "YY" is the node number.
 
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
@@ -484,6 +488,19 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
 each bit represents 5% of the capacity of the cache. You could partition
 the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Notes on Sub-NUMA Cluster mode
+==============================
+When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
+nodes much more readily than between regular NUMA nodes since the CPUs
+on Sub-NUMA nodes share the same L3 cache and the system may report
+the NUMA distance between Sub-NUMA nodes with a lower value than used
+for regular NUMA nodes.
+The top-level monitoring files in each "mon_L3_XX" directory provide
+the sum of data across all SNC nodes sharing an L3 cache instance.
+Users who bind tasks to the CPUs of a specific Sub-NUMA node can read
+the "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes" in the
+"mon_sub_L3_YY" directories to get node local data.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
-- 
2.45.0



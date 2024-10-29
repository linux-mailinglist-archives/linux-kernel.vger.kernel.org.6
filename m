Return-Path: <linux-kernel+bounces-387407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856279B50D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B681D1C226AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E002076C7;
	Tue, 29 Oct 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJnplrOM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88C20720E;
	Tue, 29 Oct 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222924; cv=none; b=QessTwrB2HJpurzMtgTyt8QTQcmlyhVZlB0BVowOSASzNSq1nmpabSm2WxbHwNZKDst2Rb5fonFsPycPguZe0xQiqGtYkB5O3NYFowe1OjoyomlR2n0qPtCn5VKyjv5vOr3aK8i8a5zGZILZqqnV1yz7EyEZoLjNXWeVwgL4Ud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222924; c=relaxed/simple;
	bh=SHRi/W/hccHUHwXfh2MbFeVEffxuPn8jRJHIpiMoqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdoGn3MmV27AFJiMXrOhMm7iQhVN0zg/JelgzNbJd1mu1IQSFsunPTaSMr8vXbGCC2G5W3GCpu6n/l2RkvEfrRDYYeACV+B6HgOQDeutPmYbJWEhfd655xVHhXya+WlNRh4wrVot2aPLjBAAK64lN3dMDq39uB9wmbjomrcsDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJnplrOM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730222922; x=1761758922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHRi/W/hccHUHwXfh2MbFeVEffxuPn8jRJHIpiMoqm8=;
  b=BJnplrOM1SbhFTeECN0ryKQSWJv0ENqD4b/vKwUI3lMt27O59jfTml35
   g0Fr6DcP3JkeUqPYzHXLevmAHxFVyjJl20Lv0L5LkNFIIGYAH24gh+kEU
   6FewOSZINCbRd7QFwJ/jZkpP4pbDnNnF0W7Lrb3nett27spUwftKfzJUm
   hPxfSiN7fcZQ9iPl4kBPDI2Uwu9BvCv6OhjCMYyDvsn3ANlWB5tJpIVz3
   E5vFNLXIk/TDZDkKRDl4+zSRo/Tyw+fz3ifYZESNBuIX3Q7ZUmFD+3px+
   Fpogpvm8ItJdGTSdbCmn2jTg0j+8TJgOjF8h6Z/dbngreVFzI8YFU64Ta
   Q==;
X-CSE-ConnectionGUID: qI+kAPBoQk+vp8mAHVvJiQ==
X-CSE-MsgGUID: aJXGkaAZS4Ko33lQhsS4HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="17515644"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="17515644"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:28:39 -0700
X-CSE-ConnectionGUID: BOFCIB5QRBKbdxtkvryHQQ==
X-CSE-MsgGUID: xYAeSO2AQSKDliCw3GcSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81585597"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 10:28:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 1/7] x86/resctrl: Prepare for per-ctrl_mon group mba_MBps control
Date: Tue, 29 Oct 2024 10:28:26 -0700
Message-ID: <20241029172832.93963-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029172832.93963-1-tony.luck@intel.com>
References: <20241029172832.93963-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resctrl uses local memory bandwidth event as input to the feedback
loop when the mba_MBps mount option is used. This means that this
mount option cannot be used on systems that only support monitoring
of total bandwidth.

Prepare to allow users to choose the input event independently for
each ctrl_mon group.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                | 2 ++
 arch/x86/kernel/cpu/resctrl/internal.h | 2 ++
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
 4 files changed, 15 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba1c716..fd05b937e2f4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -49,6 +49,8 @@ enum resctrl_event_id {
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
 };
 
+extern enum resctrl_event_id mba_mbps_default_event;
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..a6f051fb2e69 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -283,6 +283,7 @@ struct pseudo_lock_region {
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
  * @mode:			mode of resource group
+ * @mba_mbps_event:		input event id when mba_sc mode is active
  * @plr:			pseudo-locked region
  */
 struct rdtgroup {
@@ -295,6 +296,7 @@ struct rdtgroup {
 	enum rdt_group_type		type;
 	struct mongroup			mon;
 	enum rdtgrp_mode		mode;
+	enum resctrl_event_id		mba_mbps_event;
 	struct pseudo_lock_region	*plr;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b681c2e07dbf..5b55a7ac7013 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -958,6 +958,11 @@ static __init bool get_rdt_mon_resources(void)
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
 		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
 
+	if (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID))
+		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+	else if (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID))
+		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+
 	if (!rdt_mon_features)
 		return false;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7163b764c62..dbfb9d11f3f8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -65,6 +65,8 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+enum resctrl_event_id mba_mbps_default_event;
+
 static bool resctrl_debug;
 
 void rdt_last_cmd_clear(void)
@@ -2665,6 +2667,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (ret)
 		goto out_schemata_free;
 
+	rdtgroup_default.mba_mbps_event = mba_mbps_default_event;
+
 	kernfs_activate(rdtgroup_default.kn);
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
@@ -3624,6 +3628,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 		}
 	}
 
+	rdtgrp->mba_mbps_event = mba_mbps_default_event;
+
 	goto out_unlock;
 
 out_del_list:
-- 
2.47.0



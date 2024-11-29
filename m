Return-Path: <linux-kernel+bounces-418865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C299D667D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2481A28278D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DD1D3565;
	Fri, 22 Nov 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krqK/9q1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576618C351;
	Fri, 22 Nov 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319921; cv=none; b=YJBfgMqBzzKyg/iH+aQvaWWXlA6ZBqihL0F6ngIniYStt8rFmO7VjJjlORLPF3Q+sI6fACq3wHmPIfu/emglLOIyNkhNkN8JlKD/GXQj/LonyucFsDbLLdaJLDNArwldICPHfygVSAFJnskRWqMuCbR1HA0fQx3jiFOGrllny+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319921; c=relaxed/simple;
	bh=i6OS/23JSfExyu1ilEdrupZOnJZBzfqFPJKgl+4PL6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzIZ0VYLwxi+5RIDh7P0nldQsqS+fPOE1E96CzN4I1XO1zAb6LAJdABKfIYatkiThFk+z+Av/o5POKB6TINPEym3QtzmXQDSu1hjktLez55kE8Mx9qWub1JCuFAGZDZjYQ6NlMmzxIyX47fATd7nKTCV1iwEP3rQ6cwAKnv+U1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krqK/9q1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732319920; x=1763855920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6OS/23JSfExyu1ilEdrupZOnJZBzfqFPJKgl+4PL6E=;
  b=krqK/9q1HfpwTscywe6vi5QllCY3oA7n06vyZF0mwfI4BK+q/OAQfYqr
   sWzXpN1QfRFHdifIIBt32oE+DzwsnZC/DuTMS1/krLZfP3RDOmYUxQmpA
   CZ2rXCjCZQWTMcLtSF9mQBb/ywTgsy3Ar2dEYuspGVVOig5e1DeVRdQRY
   QtW1XBeLJzC4SblLNm48hRi6vWPaZQ+p1l2O1KihA/jJI/Gcg/78Uu76r
   x6bkvvEGDSyRk8QpOxy6D+7eNHsYYkTdkqKjXsx0H/gbnIezoSdQm/Cy6
   gFIkSJy7pTJfBXAYeMf8dAFdj++Qh7rf+J0yT/M3NXABnwIS1ZBXTRCuU
   Q==;
X-CSE-ConnectionGUID: IRuNfjI/T1G20IYl9ZCxjA==
X-CSE-MsgGUID: 0tvF4n8aSTauTbyQjlyLOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32642703"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="32642703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:38 -0800
X-CSE-ConnectionGUID: SaNROrlqRlSk2QAlFdACHw==
X-CSE-MsgGUID: fsxFkDZFRH2vfWy0DvrrDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90850895"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:38 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v10 2/8] x86/resctrl: Prepare for per-CTRL_MON group mba_MBps control
Date: Fri, 22 Nov 2024 15:58:26 -0800
Message-ID: <20241122235832.27498-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122235832.27498-1-tony.luck@intel.com>
References: <20241122235832.27498-1-tony.luck@intel.com>
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
each CTRL_MON group by adding a global variable "mba_mbps_default_event"
used to set the default event for each CTRL_MON group, and a new
field "mba_mbps_event" in struct rdtgroup to track which event is
used for each CTRL_MON group.

Notes:
1) Both of these are only used when the user mounts the filesystm with
the "mba_MBps" option.
2) Only check for support of local bandwidth event when initializing
mba_mbps_default_event. Support for total bandwidth event can be added
after other routines in resctrl have been updated to handle total
bandwidth event.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++++++
 4 files changed, 22 insertions(+)

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
index faaff9d64102..485800055a7d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -283,6 +283,7 @@ struct pseudo_lock_region {
  *				monitor only or ctrl_mon group
  * @mon:			mongroup related data
  * @mode:			mode of resource group
+ * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
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
index f3ee5859b69d..94bf559966d6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -963,6 +963,9 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
+	if (is_mbm_local_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+
 	return !rdt_get_mon_l3_config(r);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b198ef95e1e..2d42d69ddbe5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -65,6 +65,17 @@ static void rdtgroup_destroy_root(void);
 
 struct dentry *debugfs_resctrl;
 
+/*
+ * Memory bandwidth monitoring event to use for the
+ * default CTRL_MON group and each new CTRL_MON
+ * group created by the user.
+ * Only relevant when the filesystem is mounted
+ * with the "mba_MBps" option so it does not matter
+ * that it remains uninitialized on systems that do
+ * not support the "mba_MBps" option.
+ */
+enum resctrl_event_id mba_mbps_default_event;
+
 static bool resctrl_debug;
 
 void rdt_last_cmd_clear(void)
@@ -2353,6 +2364,8 @@ static int set_mba_sc(bool mba_sc)
 
 	r->membw.mba_sc = mba_sc;
 
+	rdtgroup_default.mba_mbps_event = mba_mbps_default_event;
+
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		for (i = 0; i < num_closid; i++)
 			d->mbps_val[i] = MBA_MAX_MBPS;
@@ -3611,6 +3624,8 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 			rdt_last_cmd_puts("kernfs subdir error\n");
 			goto out_del_list;
 		}
+		if (is_mba_sc(NULL))
+			rdtgrp->mba_mbps_event = mba_mbps_default_event;
 	}
 
 	goto out_unlock;
-- 
2.47.0



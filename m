Return-Path: <linux-kernel+bounces-572087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ACAA6C658
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C0017948C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA93237701;
	Fri, 21 Mar 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4FavWR8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33B2356AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598990; cv=none; b=BmEr3YbWdbYqrWWA7s7zH5PxOmj4Je5eVvozekADxvYFgEi2m7uS1ItoS0gsL6D8CqWwGpHYxmE9rChAIOmiqbB2ll9m9TwutmRreKI04ICzf/XFC+65IMhL9swy02hrOWbDwNMHzljIu7szaxDSlHiAt1ElMjGzO8Z8BI3EuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598990; c=relaxed/simple;
	bh=Mzo6MdUnv8b60jJzdi+ZYeWJ8nm5Tp+qficcWDvNvL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEN5Yd8ZYppfwR9akGOq/Y1m9tY1kquuNB/uMWFHbLDuQbSyPp0K4UUmRfN/vgwlA45Hc+ICeKxPv5XWnzzhm5ZJv1ps7AF90Le2pGLAIbjwj5vrowZB7QOzyVQw7ATXKZBj3SK+hmYAAgwUL3PByRUis8/NXLElLEeRYkg/tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4FavWR8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742598989; x=1774134989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mzo6MdUnv8b60jJzdi+ZYeWJ8nm5Tp+qficcWDvNvL0=;
  b=f4FavWR8ssbJ861wCefJysyc5v3XO2ykixYDtru2U9EEk88IXRwAiIbY
   twXtp5AfJbtFS3tzjN3y7soDDyq6VQ0y9pbCjUxD1PQvANSr7UOsPEumk
   8+9yiCE48ZQjdtmXKQUhkXL6NXG5ouuy4K6cbyerI7RGyPumhFyHeufY5
   Lej543O30JWulLTrv9huMGOVOI3ZDrkCyXEopcrzIwD3CrLFZ9R1f0wAb
   2ll5eTSdZD4vWDJkLgioEz5SgPDMOcPLcddP5whPug7Qlv2WBoUB9c1Ec
   ZQ+0iZL/3LxKwtBCgsKck5G0W6b/huAc5uUmk2stHO6EwClttDhPfKhQZ
   w==;
X-CSE-ConnectionGUID: p6nzNofXTFuOTDTStagB2g==
X-CSE-MsgGUID: 7vZtz1zNQ/G0D0WvMMYu/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43604640"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43604640"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:25 -0700
X-CSE-ConnectionGUID: yh6M/CxPRSWOEGfBCFBvgw==
X-CSE-MsgGUID: OLWiC+aVRXiIAatVxca0NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="128354333"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:16:24 -0700
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
Subject: [PATCH v2 14/16] x86/resctrl: Add status files to info/PKG_MON
Date: Fri, 21 Mar 2025 16:16:04 -0700
Message-ID: <20250321231609.57418-15-tony.luck@intel.com>
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

Each of the package event groups includes status about the number
of missed events and timestamps (from a 25 MHz clock) on last time
an update was missed and last time an update was processed.

Add a three info files to report per-aggregator values of these
status values.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                 | 12 ++++
 fs/resctrl/internal.h                   |  2 +
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 90 ++++++++++++++++++++++---
 fs/resctrl/rdtgroup.c                   | 21 ++++++
 4 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index e900764393f4..9f6a0b26eec3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -533,10 +533,22 @@ void resctrl_exit(void);
 #ifdef CONFIG_INTEL_AET_RESCTRL
 void rdt_get_intel_aet_mount(void);
 bool intel_aet_read_event(int domid, int rmid, int evtid, u64 *val, bool *fptype);
+int rdtgroup_last_update_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v);
+int rdtgroup_overflows_show(struct kernfs_open_file *of,
+			    struct seq_file *seq, void *v);
+int rdtgroup_overflow_timestamp_show(struct kernfs_open_file *of,
+				     struct seq_file *seq, void *v);
 #else
 static inline void rdt_get_intel_aet_mount(void) { }
 static inline bool intel_aet_read_event(int domid, int rmid, int evtid, u64 *val,
 					bool *fptype) { return false; }
+static inline int rdtgroup_last_update_show(struct kernfs_open_file *of,
+					    struct seq_file *seq, void *v) { return 0; };
+static inline int rdtgroup_overflows_show(struct kernfs_open_file *of,
+					  struct seq_file *seq, void *v) { return 0; };
+static inline int rdtgroup_overflow_timestamp_show(struct kernfs_open_file *of,
+						   struct seq_file *seq, void *v) { return 0; };
 #endif
 
 #endif /* _RESCTRL_H */
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 4d65a781034e..53590b1fa8c3 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -236,6 +236,8 @@ struct rdtgroup {
 
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
 
+#define RFTYPE_PKG_INFO			(RFTYPE_INFO | RFTYPE_RES_PKG)
+
 #define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
 
 #define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 41ebb2ee9b41..28692c6ec425 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -358,6 +358,11 @@ void rdt_get_intel_aet_mount(void)
 	}
 }
 
+enum ops {
+	DO_SUM_EVENT,
+	DO_PRINTVALS
+};
+
 #define VALID_BIT	BIT_ULL(63)
 #define DATA_BITS	GENMASK_ULL(62, 0)
 
@@ -367,22 +372,29 @@ void rdt_get_intel_aet_mount(void)
  * guid and offset).
  * Return failure (~0x0ull) if any counter isn't valid.
  */
-static u64 scan_pmt_devs(int package, int guid, int offset)
+static u64 scan_pmt_devs(struct seq_file *m, int package, int guid, int offset, enum ops op)
 {
-	u64 rval, val;
+	u64 rval = 0, val;
+	char *sep = "";
 	int ndev = 0;
 
-	rval = 0;
-
 	for (int i = 0; i < pkg_info[package].count; i++) {
 		if (pkg_info[package].regions[i].guid != guid)
 			continue;
 		ndev++;
 		val = readq(pkg_info[package].regions[i].addr + offset);
 
-		if (!(val & VALID_BIT))
-			return ~0ull;
-		rval += val & DATA_BITS;
+		switch (op) {
+		case DO_SUM_EVENT:
+			if (!(val & VALID_BIT))
+				return ~0ull;
+			rval += val & DATA_BITS;
+			break;
+		case DO_PRINTVALS:
+			seq_printf(m, "%s0x%llx", sep, val);
+			sep = ",";
+			break;
+		}
 	}
 
 	return ndev ? rval : ~0ull;
@@ -402,7 +414,7 @@ bool intel_aet_read_event(int domid, int rmid, int evtid, u64 *val, bool *fptype
 
 	offset = rmid * EVT_STRIDE(evtid);
 	offset += EVT_OFFSET(evtid);
-	evtcount = scan_pmt_devs(domid, EVT_GUID(evtid), offset);
+	evtcount = scan_pmt_devs(NULL, domid, EVT_GUID(evtid), offset, DO_SUM_EVENT);
 	*fptype = evtid == PMT_EVENT_ENERGY || evtid == PMT_EVENT_ACTIVITY;
 
 	if (evtcount != ~0ull || *val == 0)
@@ -410,3 +422,65 @@ bool intel_aet_read_event(int domid, int rmid, int evtid, u64 *val, bool *fptype
 
 	return evtcount != ~0ull;
 }
+
+static void status_show(struct seq_file *seq, char *name, int guid, int offset)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_INTEL_AET].r_resctrl;
+	struct rdt_mon_domain *d;
+	char *sep = "";
+
+	seq_printf(seq, "%s: ", name);
+
+	cpus_read_lock();
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		seq_printf(seq, "%s%d=[", sep, d->hdr.id);
+		scan_pmt_devs(seq, d->hdr.id, guid, offset, DO_PRINTVALS);
+		seq_puts(seq, "]");
+		sep = ";";
+	}
+	cpus_read_unlock();
+
+	seq_puts(seq, "\n");
+}
+
+int rdtgroup_last_update_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct telem_entry **t;
+
+	for (t = telem_entry; *t; t++) {
+		if (!(*t)->active)
+			continue;
+		status_show(seq, (*t)->name, (*t)->guid, (*t)->last_update_tstamp_off);
+	}
+
+	return 0;
+}
+
+int rdtgroup_overflows_show(struct kernfs_open_file *of,
+			    struct seq_file *seq, void *v)
+{
+	struct telem_entry **t;
+
+	for (t = telem_entry; *t; t++) {
+		if (!(*t)->active)
+			continue;
+		status_show(seq, (*t)->name, (*t)->guid, (*t)->overflow_counter_off);
+	}
+
+	return 0;
+}
+
+int rdtgroup_overflow_timestamp_show(struct kernfs_open_file *of,
+				     struct seq_file *seq, void *v)
+{
+	struct telem_entry **t;
+
+	for (t = telem_entry; *t; t++) {
+		if (!(*t)->active)
+			continue;
+		status_show(seq, (*t)->name, (*t)->guid, (*t)->last_overflow_tstamp_off);
+	}
+
+	return 0;
+}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d3919642aa9b..9021c60fd05b 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1971,6 +1971,27 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_closid_show,
 		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
 	},
+	{
+		.name		= "last_update",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_last_update_show,
+		.fflags		= RFTYPE_PKG_INFO,
+	},
+	{
+		.name		= "overflows",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_overflows_show,
+		.fflags		= RFTYPE_PKG_INFO,
+	},
+	{
+		.name		= "overflow_timestamp",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_overflow_timestamp_show,
+		.fflags		= RFTYPE_PKG_INFO,
+	},
 };
 
 static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-- 
2.48.1



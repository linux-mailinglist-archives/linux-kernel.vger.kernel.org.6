Return-Path: <linux-kernel+bounces-542916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B9BA4CF50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EEA18979CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6E24503A;
	Mon,  3 Mar 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVr4MniR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6F241105
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044899; cv=none; b=Bjhxosskqxo7RH460j+d1oYUFAduL9Ih2KT0wDrMLXazWsdYyXo82D92af9d+jH2IwVKzyZj63WvW/h3hit9V5cVCZFBCf45J/zlQ+MtnIlxrCFS9bCnnEpnwlvRFLM/o+99HFOFgysdsq5HBp5X87mj33+wJUbbBrL4KPhYGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044899; c=relaxed/simple;
	bh=lauvPnS4M2a1QAFyfmef5IVlXcxZNSP43rKCJluwbeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWWxS6VCjSmZkC6DXpTG+lUirXxlrxRMZSASrcjGdttoTwlA76gShcoJw60yFisAZ6k+U3GUNurN1pXPjW0lRuKQF+vOCoJn123tpDfTHy+ZpAfZtc0jlASbW9ntbOot/tsQh3mFDKphAFFGCSX4SGINyGxAmTNhkeD2Xm+OQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVr4MniR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044896; x=1772580896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lauvPnS4M2a1QAFyfmef5IVlXcxZNSP43rKCJluwbeU=;
  b=WVr4MniRQ4kli21m11TGhQQHJAZLiDSLCEWhMCv1OrGWVjdgoo/zipPR
   32Q+ybWY80w12g983sOeKEhojmdUh5kHIrK/xX/Us5pbCsGbW//SVig5H
   Pg+vUkTZ5GJxRRen02NezH2e5xwdUm3CflgsZxFVsISiobaxOKp0DWGDj
   QWpAYKdvlRJegwsOuk8LsrGJs3cLLJExU5WayeJavt2bK8MDhozhlXtvZ
   eLhQP2N8rFgukXt+F84kcg9XFl1zzkwM4qnHbP/qYs5UO7UyUdgRaMsVq
   TemXEuy5bZVJHh+KA5jq2fibfmFEpPQ/wXhOWmS16NZNFym6y3K/IM7Fn
   Q==;
X-CSE-ConnectionGUID: UCaU097fTx+WIXbw8fdRrQ==
X-CSE-MsgGUID: 809m2PcnT+i+FZS90GJkkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835989"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835989"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:47 -0800
X-CSE-ConnectionGUID: Kt6os4qxSvy59sUTBLCEnQ==
X-CSE-MsgGUID: VZ7BVHMISGej9arQPvSFkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982306"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:53 -0800
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
Subject: [RFC PATCH 14/17] x86/resctrl: Add code in rdtgroup_mondata_show() for core monitor events
Date: Mon,  3 Mar 2025 15:33:34 -0800
Message-ID: <20250303233340.333743-15-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303233340.333743-1-tony.luck@intel.com>
References: <20250303233340.333743-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be multiple devices tracking each package, so scan all of them
and add up counters.

Output format depends on the data type. Either a 63 bit integer, or a
fixed point decimal.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +
 arch/x86/kernel/cpu/resctrl/intel_pmt.c   | 88 +++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 24c4ab331c3c..068a47b015e7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -639,11 +639,17 @@ void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 #ifdef CONFIG_INTEL_PMT_RESCTRL
 int rdt_get_intel_pmt_mon_config(void);
+int rdtgroup_intel_pmt_data_show(struct seq_file *m, struct rdt_resource *r,
+				 int domid, struct rdtgroup *rdtgrp, u32 evtid,
+				 struct rmid_read *rr);
 void rdt_get_intel_pmt_mount(void);
 void setup_intel_pmt_mon_domain(int cpu, int id, struct rdt_resource *r, struct list_head *add_pos);
 void rdt_intel_pmt_exit(void);
 #else
 static inline int rdt_get_intel_pmt_mon_config(void) { return 0; }
+static inline int rdtgroup_intel_pmt_data_show(struct seq_file *m, struct rdt_resource *r,
+					       int domid, struct rdtgroup *rdtgrp, u32 evtid,
+					       struct rmid_read *rr) { return 0; }
 static inline void rdt_get_intel_pmt_mount(void) { }
 static inline void setup_intel_pmt_mon_domain(int cpu, int id, struct rdt_resource *r,
 					      struct list_head *add_pos) { }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 515a9bec05cd..0c3d407aca08 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -700,6 +700,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	case RDT_RESOURCE_L3:
 		ret = rdtgroup_l3_data_show(m, r, domid, rdtgrp, evtid, md.u.sum, &rr);
 		break;
+	case RDT_RESOURCE_INTEL_PMT:
+		ret = rdtgroup_intel_pmt_data_show(m, r, domid, rdtgrp, evtid, &rr);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/arch/x86/kernel/cpu/resctrl/intel_pmt.c b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
index c5557d7f5fbe..4067aacd9d80 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_pmt.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
@@ -320,3 +320,91 @@ void setup_intel_pmt_mon_domain(int cpu, int id, struct rdt_resource *r, struct
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		mkdir_mondata_subdir_allrdtgrp(r, &hw_dom->hdr);
 }
+
+#define VALID_BIT	BIT_ULL(63)
+#define DATA_BITS	GENMASK_ULL(62, 0)
+
+static u64 scan_pmt_devs(int package, int guid, int offset)
+{
+	u64 rval, val;
+	int ndev = 0;
+
+	rval = 0;
+
+	for (int i = 0; i < pkg_info[package].count; i++) {
+		if (pkg_info[package].regions[i].guid != guid)
+			continue;
+		ndev++;
+		val = readq(pkg_info[package].regions[i].addr + offset);
+
+		if (!(val & VALID_BIT))
+			return ~0ull;
+		rval += val & DATA_BITS;
+	}
+
+	return ndev ? rval : ~0ull;
+}
+
+#define NUM_FRAC_BITS	18
+#define FRAC_MASK	GENMASK(NUM_FRAC_BITS - 1, 0)
+
+static void print_u46_18(struct seq_file *m, u64 val)
+{
+	u64 frac;
+
+	frac = val & FRAC_MASK;
+	frac = frac * 1000000;
+	frac += 1ul << (NUM_FRAC_BITS - 1);
+	frac >>= NUM_FRAC_BITS;
+
+	seq_printf(m, "%llu.%06llu\n", val >> NUM_FRAC_BITS, frac);
+}
+
+int rdtgroup_intel_pmt_data_show(struct seq_file *m, struct rdt_resource *r,
+				 int domid, struct rdtgroup *rdtgrp, u32 evtid,
+				 struct rmid_read *rr)
+{
+	struct rdtgroup *entry;
+	struct list_head *head;
+	u64 val, cval;
+	int offset;
+
+	if (rdtgrp->mon.rmid >= EVT_NUM_RMIDS(evtid)) {
+		seq_puts(m, "unimplemented\n");
+		return 0;
+	}
+
+	offset = rdtgrp->mon.rmid * EVT_STRIDE(evtid);
+	offset += EVT_OFFSET(evtid);
+
+	val = scan_pmt_devs(domid, EVT_GUID(evtid), offset);
+	if (val == ~0ull) {
+		seq_puts(m, "unavailable\n");
+		return 0;
+	}
+
+	if (rdtgrp->type == RDTCTRL_GROUP) {
+		head = &rdtgrp->mon.crdtgrp_list;
+		list_for_each_entry(entry, head, mon.crdtgrp_list) {
+			offset = entry->mon.rmid * EVT_STRIDE(evtid);
+			offset += EVT_OFFSET(evtid);
+			cval = scan_pmt_devs(domid, EVT_GUID(evtid), offset);
+			if (cval == ~0ull) {
+				seq_puts(m, "unavailable\n");
+				return 0;
+			}
+			val += cval;
+		}
+	}
+
+	switch (EVT_TYPE(evtid)) {
+	case EVT_U64:
+		seq_printf(m, "%llu\n", val);
+		break;
+	case EVT_U46_18:
+		print_u46_18(m, val);
+		break;
+	}
+
+	return 0;
+}
-- 
2.48.1



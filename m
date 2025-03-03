Return-Path: <linux-kernel+bounces-542913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE07A4CF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759403AC83F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C730241C80;
	Mon,  3 Mar 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9biErsM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EB923FC55
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044897; cv=none; b=SBPa2sSdauP2DgQxRUR1J370VRzyHUQC4F8RW1kRe25fHuWsvQkAs+jK+uK55p/o51tH5QFuqirKaBVMh2Ds02S5Xk+6Du9WEb0z1cSJUvZluhRZfdAoXP5AI51tHkLlHjp8yN3jIAUfo1aroPLj0h5YtlsEMCssY8OKxrcJoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044897; c=relaxed/simple;
	bh=1hF9NovdTOsuXEs606/4Dcli0cFwIcM5+7g4ZF3CmC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/RO13KmneKhESMxM0IPTBGnMgjWXyMeRITCPbO1plNKD3tDl2ASy/5Tc+1R0+uN+2Auo57tGR9pHDYJBjHeTQ/TeYRm41XmvEkrfBWW6N2MWCae1aanYGlNRvdWdRY/EcRycZ0V3O71MQb2OFLvCWasVjz/EJEtyPsY94ajuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9biErsM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044896; x=1772580896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hF9NovdTOsuXEs606/4Dcli0cFwIcM5+7g4ZF3CmC0=;
  b=m9biErsMa0P3dMm4xrjqP5vPL7D6HCfhWjzW8lYD3TOeV68lgAgN465F
   7RiMiT/3ou9CW0td2xOF5DJtn1QNysgUcZnuhIsWsiZJPyzE3EJOWnSkr
   gMojTUDTtu2pyuvk61gMJPa2dofXmZhE85ZEnFJ83ug8229Ff/cSR1Pmz
   pVpVbc0Q7ygWEsAnVvayJpSv89VVKtTVeAMRkAzcBgr/8X1G85ZAXpKip
   NCju/7yN76yfa4ZbjEWW+t0m+fZ/DfwpPbwrzMcRMgDjM/zz/AswsOWEQ
   D0uc7cL5Jel4bKjAwUK2Pk4Yjc4donNCJFfnqs0obiNZcFK/AoVCm3fcf
   g==;
X-CSE-ConnectionGUID: UZHmQyKLQpKJFtJLq3IVcA==
X-CSE-MsgGUID: mfT3jh/aQlWoZGPCyg0V3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835973"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:47 -0800
X-CSE-ConnectionGUID: pjvIxtq4R1C1QEITnByiJw==
X-CSE-MsgGUID: Au7//yb8TdOwVjLacEdkzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982300"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:52 -0800
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
Subject: [RFC PATCH 11/17] x86/resctrl: Allocate per-package structures for known events
Date: Mon,  3 Mar 2025 15:33:31 -0800
Message-ID: <20250303233340.333743-12-tony.luck@intel.com>
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

Use the per-package counts of known events to allocate arrays to
make a copy of just the known events.

Add hook into resctrl_exit() to cleanup.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  |  2 +
 arch/x86/kernel/cpu/resctrl/core.c      |  2 +
 arch/x86/kernel/cpu/resctrl/intel_pmt.c | 59 ++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 65bbe223f8a1..24c4ab331c3c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -641,11 +641,13 @@ int rdt_get_mon_l3_config(struct rdt_resource *r);
 int rdt_get_intel_pmt_mon_config(void);
 void rdt_get_intel_pmt_mount(void);
 void setup_intel_pmt_mon_domain(int cpu, int id, struct rdt_resource *r, struct list_head *add_pos);
+void rdt_intel_pmt_exit(void);
 #else
 static inline int rdt_get_intel_pmt_mon_config(void) { return 0; }
 static inline void rdt_get_intel_pmt_mount(void) { }
 static inline void setup_intel_pmt_mon_domain(int cpu, int id, struct rdt_resource *r,
 					      struct list_head *add_pos) { }
+static inline void rdt_intel_pmt_exit(void) { };
 #endif
 void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b6e6a25520f7..da44d00acd98 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -1170,6 +1170,8 @@ static void __exit resctrl_exit(void)
 
 	cpuhp_remove_state(rdt_online);
 
+	rdt_intel_pmt_exit();
+
 	rdtgroup_exit();
 
 	if (r->mon_capable)
diff --git a/arch/x86/kernel/cpu/resctrl/intel_pmt.c b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
index 78ab6d899ee2..754748d858c6 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_pmt.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_pmt.c
@@ -147,6 +147,26 @@ static bool count_events(struct pkg_info *pkg, int max_pkgs, struct pmt_feature_
 	return found;
 }
 
+static int setup(struct pkg_info *pkg, int pkgnum, struct pmt_feature_group *p, int slot)
+{
+	struct telem_entry **tentry;
+
+	for (int i = 0; i < p->count; i++) {
+		for (tentry = telem_entry; *tentry; tentry++) {
+			if (!(*tentry)->active)
+				continue;
+			if (pkgnum != p->regions[i].plat_info.package_id)
+				continue;
+			if (p->regions[i].guid != (*tentry)->guid)
+				continue;
+
+			pkg[pkgnum].regions[slot++] =  p->regions[i];
+		}
+	}
+
+	return slot;
+}
+
 DEFINE_FREE(intel_pmt_put_feature_group, struct pmt_feature_group *,	\
 	if (!IS_ERR_OR_NULL(_T))					\
 		intel_pmt_put_feature_group(_T))
@@ -157,6 +177,8 @@ static bool get_events(void)
 	struct pmt_feature_group *p2 __free(intel_pmt_put_feature_group) = NULL;
 	int num_pkgs = topology_max_packages();
 	struct pkg_info *pkg __free(kfree) = NULL;
+	bool found_known_features = false;
+	int i, slot;
 
 	pkg = kmalloc_array(num_pkgs, sizeof(*pkg_info), GFP_KERNEL | __GFP_ZERO);
 	if (!pkg)
@@ -175,13 +197,32 @@ static bool get_events(void)
 		if (!count_events(pkg, num_pkgs, p2))
 			intel_pmt_put_feature_group(no_free_ptr(p2));
 
+	for (i = 0; i < num_pkgs; i++) {
+		if (!pkg[i].count)
+			continue;
+		found_known_features = true;
+		pkg[i].regions = kmalloc_array(pkg[i].count, sizeof(*pkg[i].regions), GFP_KERNEL);
+		if (!pkg[i].regions)
+			goto fail;
+
+		slot = 0;
+		if (!IS_ERR_VALUE(p1))
+			slot = setup(pkg, i, p1, slot);
+		if (!IS_ERR_VALUE(p2))
+			slot = setup(pkg, i, p2, slot);
+	}
+
 	if (!IS_ERR_OR_NULL(p1))
 		feat_energy = no_free_ptr(p1);
 	if (!IS_ERR_OR_NULL(p2))
 		feat_perf = no_free_ptr(p2);
 	pkg_info = no_free_ptr(pkg);
 
-	return true;
+	return found_known_features;
+fail:
+	while (--i > 0)
+		kfree(pkg[i].regions);
+	return false;
 }
 
 int rdt_get_intel_pmt_mon_config(void)
@@ -193,6 +234,22 @@ int rdt_get_intel_pmt_mon_config(void)
 	return 1;
 }
 
+void rdt_intel_pmt_exit(void)
+{
+	int num_pkgs = topology_max_packages();
+
+	if (pkg_info) {
+		for (int i = 0; i < num_pkgs; i++)
+			kfree(pkg_info[i].regions);
+		kfree(pkg_info);
+	}
+
+	if (feat_energy)
+		intel_pmt_put_feature_group(feat_energy);
+	if (feat_perf)
+		intel_pmt_put_feature_group(feat_perf);
+}
+
 void rdt_get_intel_pmt_mount(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_INTEL_PMT].r_resctrl;
-- 
2.48.1



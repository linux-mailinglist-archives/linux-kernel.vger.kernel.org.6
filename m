Return-Path: <linux-kernel+bounces-542907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536AA4CF48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D7D3ACB01
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95C23ED58;
	Mon,  3 Mar 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVMxkzTM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BB23C8AE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044892; cv=none; b=YXJ9zWHU5sLXYgbxKWzHUrhbTv3+ZX+3ADvBTEAYnKTIP05YRhCwnXFyTrOIU1i1WqaJ+ZsFheSWUJ0XpSL6j5W7hgSW7EFGQ6LSmXzYeHNmeNPIPbIqPZhFkKTSa7+fZEn5Jw+4Wn7oxsjTgG024K63/lXYaKzzP+55tBx2Sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044892; c=relaxed/simple;
	bh=xwrB3g3N8P2uj1c72EBSigEmYxthDVqNCS7AcRoNuIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RptxdzNreue4eYIvGuT3siOQ1nI/xk2NenORZbHZmut+01tTpHXMcfjP9ESF9JWiV70SuHv/yiCI1pNwmvwwy5qfwtoVeZFuxRutOw2QC8bB5oEz44rfGZb1HL3sHrfe2iXcYt1m3BJrk8JA+fFXFL8/vJ1UbOoheiYNCKudjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVMxkzTM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044891; x=1772580891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwrB3g3N8P2uj1c72EBSigEmYxthDVqNCS7AcRoNuIw=;
  b=YVMxkzTM6lQIMxZRpdswATkZJrCmbO+Y+JDlEgOP/eJXCeK+AZPSp2ar
   aSddCOR+bhlLUAVOA4pIiYgGWfIr05wCeKV09JtGhIxISz3VJOxqGfTsf
   ojmblMw2flugRKGZpnXGocjU/tZvc1EcJhMmAAP6PpkkyjG64txwyJkv3
   V1MRoh0e8pUWTv2LnPkWEMONSO9+oogX2GANBKSLP9H1PPEVgey0i7cr8
   r0NyngCw5JukvidO4C9GWaRlI2AK4tZolRfsGOLkEnXOyBNo63JjzaIeJ
   olhuQ13xWZSTkgBj7FqgOI99hX7ExHbQsc4lslReF0SkKS8hI7NbZPQZ3
   w==;
X-CSE-ConnectionGUID: mBgA4og/Q2OBq3s4skup3Q==
X-CSE-MsgGUID: qpjrNUIZR3+NDe8NZYCTBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835935"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835935"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:34:47 -0800
X-CSE-ConnectionGUID: vgRL93H5R+qFsGM4MfPSHg==
X-CSE-MsgGUID: quSvOidiQ4GAyysb0wXXTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117982290"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:33:51 -0800
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
Subject: [RFC PATCH 06/17] x86/resctrl: Add and initialize rdt_resource for package scope core monitor
Date: Mon,  3 Mar 2025 15:33:26 -0800
Message-ID: <20250303233340.333743-7-tony.luck@intel.com>
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

New resource for monitoring core events reported at package level.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a89f0a7e2724..9b64993a6cc8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -180,6 +180,7 @@ enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
 	RESCTRL_L3_NODE,
+	RESCTRL_PACKAGE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 20c898f09b7e..b8f37170f6e5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -317,6 +317,7 @@ struct rdtgroup {
 #define RFTYPE_RES_CACHE		BIT(8)
 #define RFTYPE_RES_MB			BIT(9)
 #define RFTYPE_DEBUG			BIT(10)
+#define RFTYPE_RES_PKG			BIT(11)
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
@@ -517,6 +518,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_INTEL_PMT,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7eddc07d35ee..75a815383427 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -117,6 +117,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_INTEL_PMT] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_INTEL_PMT,
+			.name			= "PKG",
+			.mon_scope		= RESCTRL_PACKAGE,
+			.mon_domains		= mon_domain_init(RDT_RESOURCE_INTEL_PMT),
+			.fflags			= RFTYPE_RES_PKG,
+		},
+	},
 };
 
 u32 resctrl_arch_system_num_rmid_idx(void)
@@ -521,6 +531,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 		return get_cpu_cacheinfo_id(cpu, scope);
 	case RESCTRL_L3_NODE:
 		return cpu_to_node(cpu);
+	case RESCTRL_PACKAGE:
+		return topology_physical_package_id(cpu);
 	default:
 		break;
 	}
-- 
2.48.1



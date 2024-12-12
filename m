Return-Path: <linux-kernel+bounces-443897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B969EFD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D26188CE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD0E1DE3DB;
	Thu, 12 Dec 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fmodC2sl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1F1D88C7;
	Thu, 12 Dec 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034710; cv=fail; b=P+Q87t4wxH7gghv4dceziwmRy81ykwgGRU23urcQndfWjqt/PJMp9J1FyfvfX91Cc9yBhnCA8nFjS6tmyrmTjHgfl8p5ayhnapcSiO1xApbz1IgZIlk9S9hknNGbyi0RmW8dtvisv9AI26IkXxWEG+lzQntWnkkLk7BbHqbP6tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034710; c=relaxed/simple;
	bh=4PKjyYAv9fxd+Tpe+2BijiVCUPSS3j727uo47NQ5qTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWAyJCySLtPXNcEdz23Yn8R/PS7thDorwlQaHsU5WlQ0LDsp8AHfTGM9Q/hM9+9qlY+llEiRl3Vu/JGZvFHouExRgBQfr8G+aab3wDBbki6G8uqyaGagZDwDaYWMzE2RekYgZyi25RMwstBdOrImV/S+mqnTbcsBPbyPBQPcVKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fmodC2sl; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZy/P9gmae09Siccje1Rapy0o+Iauxpbkgi5fPp75DP6B8p4RAk6molSU0IBjxYE0CJS8pI4LrpnNkS4V3RLrBJo0hVRiWNCfQltRfN7ZXCMsn5JKdB7x+m9tiLlDz1y5n2nbx3M9SG/xxdP/WBF8fZ+S1lE9Ms/JOR6LfMlF+QpNaFjBy3T9Yilu0/NAm4bMQ22a2D0iCEcWNHeobI5qtBU+wt5getk3Fjx7IPGxlB6XieGs8O7w2W9np3LC5wiMNORQ3FmgBxAF1zDXsSC7FNfIFHkwXN+cR+oenkmfmdSAd7hietFCfIEyIRVwiV3RvFhnNsOXFPlyATME4awRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwqAq3vSzS0oCoPvB9MB0svvxLa34b/ecpdrJs7R/Ec=;
 b=UcczZb9DViTdsdxRMRZY+qdB3HEwCUbhE1T5S7qPdELLClH+Cx4I7pWgMjuKvJAwthWu7Sl7AkHffs6GhlzkhGFd6j0y1Lzq/hW9GRlbzUdcqLc6BepUBVPzWZtpMOPZUtbfa6Sd5vaDcC64UwaYoN5ycpE9FKOXyFocC2dN0Rkd+FhfBdiimShFa+I7uRGunahLD1tH6NkOa8VN4a5nXLGGPNqjq395IpXZBuyZzOuMaAeIwN/oG/3qqp4dw3QvLpCYlnozjDxEVhUS96EmmE27qiRF0GdK+Ob5dF4gz78LFCWTxUod3023so3YC/O+D7MF5suDuQUengLB++6/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwqAq3vSzS0oCoPvB9MB0svvxLa34b/ecpdrJs7R/Ec=;
 b=fmodC2sl4ci62b0Daa6N80P7V8TJuy1dF1Zr026uPgDmJiHmzScA03RR0w6v+8bkgCFrcGi+wZ6DPN1/+Z/63b901RVg/k+tIv4fqg2nGuB8aRcpjQU119OQ7NtQ2DnSUc7xDuMZKTNYdbIQeZvy9yYaQpL8ArkqJ5olfwMCoG4=
Received: from MN2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:208:178::23)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:18:22 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::d1) by MN2PR19CA0010.outlook.office365.com
 (2603:10b6:208:178::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Thu,
 12 Dec 2024 20:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:18 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 17/24] x86/resctrl: Add the interface to unassign a counter
Date: Thu, 12 Dec 2024 14:15:20 -0600
Message-ID: <0619fcb4307f6d20d214980f61421825c67a969d.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: da1dec82-faf8-4ada-61ec-08dd1aea1fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FZIta1JtaVyj+hYCW2eUJxXdDU77XffwU/q/C6134T+o1gVxES+890P0O35?=
 =?us-ascii?Q?rUJskhaz0HHdH1MKy656T7kWlJJm5SLcRMo9T0/DRfZPvVWisOrtnzn2FCkp?=
 =?us-ascii?Q?gz5dzWAkFWnk6czs+WHoEXIC3+y2AuRU0LHX4KXRpxPuOKcxMCjG6uQgm+qk?=
 =?us-ascii?Q?WlnfI9vj+lGBrWflVdXYOTvrWx4fx6TeO1j8dHzQkrCg6RfluvnLYI0WXkPx?=
 =?us-ascii?Q?lbiyFtTyH3ba0aXDbo1FAcoyDmK9OPXwB1JIrGY99vUh0hsSqOdRFBGFLJbs?=
 =?us-ascii?Q?nff6gY8KXo58dUtbRxkybrHm+d+bCmbEc/sA32c8n3KgL6TPvQSmGoRsFqSG?=
 =?us-ascii?Q?Uq3h+4/jLgrJccsBsWWQeYcAWeamlY6/HxsSTPDTbSK7lWyPzQ9BGaz5mPOK?=
 =?us-ascii?Q?AdikGTkSLYiHXyVfGa2Yh6pqLM91ptFeCPVj+SprwmKocsK/qhIZ4b4rSXOX?=
 =?us-ascii?Q?+9L0gE5MCu0zgGywWOX8Vr4lETsE4E+Wk5o8+xhZj3r0BYAUAL3xkNBZgkul?=
 =?us-ascii?Q?xX9poRva9dBg1W8A/DPhNoc2hGkTMTQi3CRDRPF8a2wRYmlz5QiLzStN5bDU?=
 =?us-ascii?Q?vZq9h4yF9xnnedqc24cWm84l/LpQ7w79w+IlV8fEftz2seN+QBq9nWQ7G2m3?=
 =?us-ascii?Q?N5Zp3tXBz1TlN8NWZJYOtLAqJDWT99ke4M440GohKNqU+5LuPw0xMJrQZ9r4?=
 =?us-ascii?Q?CA5Q9jHceu/o5RmntDtC0HGrt+uKC0TcoL+RmCfYF/zeqUbakewHn5n8Kdn6?=
 =?us-ascii?Q?lxU5vLGK8mDYHCetHkKbwcHL59kJOuqgDWic4VQTC5giNDX/XGRvNIOQRN8l?=
 =?us-ascii?Q?2OygUd7Q2VDQ4piQG7ebzqJHARTZyJbsPbKzDscpPD+QIs0RQrZG0bLmc118?=
 =?us-ascii?Q?veKnbGytVsAOEC+S7Tk3+7qt5WEsTP57SHPz9Nkj4eN88spc81kRn1rnr+Zw?=
 =?us-ascii?Q?Wc75L6aaqohFD7bt2dO+aWABULC6hD360LX8k49ibi19GQ9gyXXcqWkP7TJ9?=
 =?us-ascii?Q?GqjiADwC7AslGMTb2kVA7OVfAilpUb6lXH0GdVruVHibFg+DP3JEdBGi4RI3?=
 =?us-ascii?Q?a5YaZPiGiIq7xjBkk0RkoDbekgta+cyceWh7iuBbrTggd+KJRMO9yL4G46kq?=
 =?us-ascii?Q?85S9Jxeq6edpiMD8Y9S82qNzGe7pwWuK/X+fgaxqT3fJjyTyVqIu8wVlT6/8?=
 =?us-ascii?Q?FmX3JCedQZIalBSSN6qpyMSdv7tRdfXoZA0nQPHczO4e6f8xY/qeWLX83HmQ?=
 =?us-ascii?Q?PceaUttvs7ck+fqcapV7fcwaFmP5QKZ+Ljp5pb1+Lse1+/ENG2EHqETj+HQB?=
 =?us-ascii?Q?9Om6GgontDW/ePlM6EVWrVGGsgdMiPhE1YY/bZwO5rkj6ZajzmE9ajTx1j2i?=
 =?us-ascii?Q?VPPBRcfDIfWkpFtCnbR//6Ot7D87XjDPtnsoqQiY8RzR6mSDmIFzJw/Vh2sI?=
 =?us-ascii?Q?LDu2II8zj8ErTtf0JlaIqmHkm5Hkotxk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:21.4011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1dec82-faf8-4ada-61ec-08dd1aea1fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

The mbm_cntr_assign mode provides a limited number of hardware counters
that can be assigned to an RMID, event pair to monitor bandwidth while
assigned. If all counters are in use, the kernel will show an error
message: "Out of MBM assignable counters" when a new assignment is
requested. To make space for a new assignment, users must unassign an
already assigned counter.

Introduce an interface that allows for the unassignment of counter IDs
from the domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Patch changed again.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     commit message update.

v9: Changes related to addition of new function resctrl_config_cntr().
    The removed rdtgroup_mbm_cntr_is_assigned() as it was introduced
    already.
    Text changes to take care comments.

v8: Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
    Added return error handling in resctrl_arch_config_cntr().

v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 52 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 70d2577fc377..f858098dbe4b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -706,6 +706,8 @@ int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			     u32 cntr_id, bool assign);
 int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 			       struct rdt_mon_domain *d, enum resctrl_event_id evtid);
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
 struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 				u32 rmid, enum resctrl_event_id evtid);
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1c8694a68cf4..a71a8389b649 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1990,6 +1990,20 @@ static void mbm_cntr_free(struct rdt_resource *r, struct rdt_mon_domain *d,
 	}
 }
 
+static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid == evtid)
+			return cntr_id;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Assign a hardware counter to event @evtid of group @rdtgrp.
  * Counter will be assigned to all the domains if rdt_mon_domain is NULL
@@ -2037,6 +2051,44 @@ int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
+/*
+ * Unassign a hardware counter associated with @evtid from the domain and
+ * the group. Unassign the counters from all the domains if rdt_mon_domain
+ * is NULL else unassign from the specific domain.
+ */
+int rdtgroup_unassign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
+{
+	int cntr_id, ret = 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (!mbm_cntr_assigned(r, d, rdtgrp, evtid))
+				continue;
+
+			cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+
+			ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						  rdtgrp->closid, cntr_id, false);
+			if (!ret)
+				mbm_cntr_free(r, d, rdtgrp, evtid);
+		}
+	} else {
+		if (!mbm_cntr_assigned(r, d, rdtgrp, evtid))
+			goto out_done_unassign;
+
+		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+
+		ret = resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+					  rdtgrp->closid, cntr_id, false);
+		if (!ret)
+			mbm_cntr_free(r, d, rdtgrp, evtid);
+	}
+
+out_done_unassign:
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1



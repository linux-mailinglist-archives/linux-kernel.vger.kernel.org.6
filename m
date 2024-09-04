Return-Path: <linux-kernel+bounces-316032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1B96CA35
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37676B24E87
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CB17BECB;
	Wed,  4 Sep 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0bCTjUH"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47817BEB9;
	Wed,  4 Sep 2024 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488551; cv=fail; b=uS+5RMy92DNfwhEbtAU9NwgIAbjr5IuKnPUCO012lMikPedwcqEbsdDHpT2jPYsYCFjWvIkdTJfqgJ8gkDtcMI/g9zT/lcDj8t4GSEALwop8ftLEysML+e6DBD88E8/923aF5945nfeOCpECp3jzeoOVKc0xxw6K7X4XWxRsplA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488551; c=relaxed/simple;
	bh=4RigYsKo87I4eR+sxbx0IOnT1tfe8m0u6vYyyhz0oNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2S5pRYrwgg5KSzSK/KokoXuj9+4jdu4vAaWQiI3SIm0IISt9zWjLEq3dEvki3ErbZ6ZGqK1AFqW8vABLWMN5AY8jUXX/3KAQoxJ0ez/tv3wKvkGMiehz2nik8YYZbCXah2y2isuo348pR+bgfI6UWz0AZEVGP7mw+C7/uq32b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0bCTjUH; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmK6t6w5WySfACPOqZa6aEeSrvCK2e2ENJLWdSKnrQhNBnM8OiWisxfl3qpwsi2ibBPn24MSn8C9OXKsRcOAtfG8bPfZsdnEw3FupnG23QjI5fEuAvQgfH0Xh640uPEmlYn6CPpnudPQ8gUT4DCvTmJ3qfaJG7QySLMSnmV2EOBDA6VOq+TP6eMgSdcn/CEpc5Pbwhfu4fh6ofrSFJ5WUXqjOOU8E/7zJQNypdNyrliDbbEK3d3XHiFh/yYpSXrpcS+kQl9QNxNlmj/dAim2T+SdsqcBgWHXY3m03Ghw1wfZwsm8Xlon1OPoqkJoivVWZnVFsNoYkskDxNYrtJK1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojRJcIPzijPE35rLWs+hTXCPMYDLrbTjkZr3EyZ2plI=;
 b=oaSBX0SwJL9cVOCqel6ecQMYYrxmEDFqOuV2sJjJtz9jNssHkYbTa2ITj0jPw0LFjCDVC9ZBhwbasnJjQkzxuEoMf05D6iO6IjHeddcUbdRnkKh9UWXbrc4etUByQgWvumiIVzEQXv6fjS/S6rETZ8/BApbQpFMbDNAX22Vii8GLyl7O7WE/tK1ci6q8DL2M6knx9yKXMXpIj9F4fl9pj0lomf6rx0Pa2JECwoOAf2TZUP7Yss/En20ZaDOpHu1nlcANXJ9hw3dLvXiPoLFVY2XKhrsSYrEFu9E3D/BjDgqJP5wNTWVPeQ8GpWKtD7nCoKUOGgwYuXUNq8zyeifKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojRJcIPzijPE35rLWs+hTXCPMYDLrbTjkZr3EyZ2plI=;
 b=p0bCTjUHaD7JyZybmwk/lmYpwbA/a55IiIo+skvLyIymvGRT+0VXgMFqnq8wONb+16e/GMTAt1qa0X9useGfkZqdFYSZlHJuZ86XHBbPSPYdaT2uk6xYYJ6ku8J1o9TJcM0RdcpHBKiSKXvOjL8/UWZjMg1/tltYoNKCb7MtXB0=
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:22:25 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cb) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:22:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:22:22 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v7 04/24] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Wed, 4 Sep 2024 17:21:19 -0500
Message-ID: <01aa73f659a24b5c54b5104f1c35c32dd06c3376.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: bed4cd62-e35f-4533-06d7-08dccd300d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GVyVWbPNOJ4qbUTiVPD+lqUtWned7cbO0IgRkZWnHoj++ed2haW5MlU0OnM+?=
 =?us-ascii?Q?juLi0RlaJbN4YIuqNytGUNWy/mqhWqEPSguSgAdEppyQkrBqkCg5It56ExBt?=
 =?us-ascii?Q?Ogsqa//RT3pE71pVJzMYyfcbIYaqaXIA25EB3G6tFk4hIwPxtl9nXFzhmgDA?=
 =?us-ascii?Q?1cCbYA9SkWlTgwz0gU/iXbrhO22QDReIVIbBLnwVhN0qiIpyDjSBafKuU/vX?=
 =?us-ascii?Q?BQqoa4URsf4QpMUYVB9B7ieCKRLSXNsb+mZABs7Yq4BFgy9xBPULhlt5Wpbv?=
 =?us-ascii?Q?5OM8MC/K8PFkjrr8JbyUrXUric8b8IAxjoYe9L8igCURbX9FfNE1Xxo6dXfZ?=
 =?us-ascii?Q?2w3ffXNrXzYtEEqJYGFiT4599dAtt6veLbt7FQqbECdplOaphZ7Y3Cbm/Ee1?=
 =?us-ascii?Q?GiyS7XrHbNLju7FMxgrruIf8Y115DuxxyU2E9hB1FgXgaLdAZeEhoflohGLz?=
 =?us-ascii?Q?4RxAafVNvGYbwdMVQgQg1RGwvdz+jZNswauLFVJFd3eQVX5SCbwjhIeCca9u?=
 =?us-ascii?Q?D+ErCmS3bgzKbEbQ/NicnovxQuYs3Ls81lKCLtlbtpzisQxT4onzWYHPPh9I?=
 =?us-ascii?Q?zruUtouvZcN3EaNYM7fP2RbYS9wwaidFY8JsWGYCs7POmlnl/L2jEMzxlbh1?=
 =?us-ascii?Q?a2bOxLHFB7QxEUWgdbt7bFzOEvIZk7GqSONCMh+497VLSB4tp+rZ4aseBzt+?=
 =?us-ascii?Q?D93woj6npHqXWDBPAw5kYmvzhxDMgD8FjmURTlBZ9dP2CANcW1HXh2jOWd01?=
 =?us-ascii?Q?gd2xcsk1pdqqoceC+YKk9wJgAy94rG0LDsryjXvBODBL9s2L3JFHW+dTK8jM?=
 =?us-ascii?Q?ONCL1+d2MzqtMCIkqMbEEqaaDLBrR1C+WaUB/pmuKeszYPkb5NdUPwxof9rN?=
 =?us-ascii?Q?vquynn02NAe5f0NIfmDc96m6eRjrx6cWZWvtLZqv2dCXeCAXMCqkG2rrG8uS?=
 =?us-ascii?Q?A6Z20in91EmfjcgS4QGXPgW6LciKXXrimDnTjFmFEoyhsEweudLxJpUcUKqV?=
 =?us-ascii?Q?ykvRlNs5bSJXN7AC4e0oX7MQtBw4XfvW0Uqd9mHcTtfFd4jSavGP9AK30C2m?=
 =?us-ascii?Q?Y7Te5f7eDB8gs7NRPuihZR7y8jGm2ntmK8oSr179PHdQn7Msqe6Mti3JNFrx?=
 =?us-ascii?Q?hccf72anKZ6/quCXkvZGgF+J4FX+nh9V4KYl2lLiGjCMy6PGolwtBmnBzhZX?=
 =?us-ascii?Q?McnpbWlW+hbRukkLgw/Foi4LA711PrGHEZK3Q4kVGmczyh+3dvUA9upeKeNa?=
 =?us-ascii?Q?bMMWENoxMl/wWWgFYFM5Grh8W/j/47xgfxpxHUAWYUY/h98v7Bb1foLxIJ+n?=
 =?us-ascii?Q?2n52yYoKnBcUp33yf6G98vPQfVBNlknXkfCk8b1udXET2au+FJbnohEHOdA1?=
 =?us-ascii?Q?4ucPlj8K0H2RXstOsrgLc07b6zZf1iKz6srPSEIKBBMxwutlcGW3RbJXEjda?=
 =?us-ascii?Q?CqSNyQFzHsZJBxNBiZsC+CLfKAIE6bDy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:22:24.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed4cd62-e35f-4533-06d7-08dccd300d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable monitoring counters supported.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

v6: Commit message update.
    Renamed abmc_capable to mbm_cntr_assignable.

v5: Name change num_cntrs to num_mbm_cntrs.
    Moved abmc_capable to resctrl_mon.

v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++++++
 include/linux/resctrl.h               | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 795fe91a8feb..6a792f06f5ce 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1229,6 +1229,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->mon.mbm_cntr_assignable = true;
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 3c2307c7c106..511cfce8fc21 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -185,10 +185,14 @@ enum resctrl_scope {
 /**
  * struct resctrl_mon - Monitoring related data of a resctrl resource
  * @num_rmid:		Number of RMIDs available
+ * @num_mbm_cntrs:	Number of assignable monitoring counters
+ * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 	struct list_head	evt_list;
 };
 
-- 
2.34.1



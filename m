Return-Path: <linux-kernel+bounces-357613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49AE997351
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D860F1C22F70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8551A4F0C;
	Wed,  9 Oct 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZweOXa2U"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05261E1A07;
	Wed,  9 Oct 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495660; cv=fail; b=VsjerQa2n/3+KzI170Qz/NEDUOFgQ8mZV9rpQ8pT1v4hlQTFCOX/aIx8arHq7a2jU6/8bqEHqbuzu7xluqvF+EgF3BCWzeAlrsBIlDBUNfxTUEzhdlMABy7SMvY/PZqs9VKsUXMj6fGEpa9PFg6H6njzwnZDvnK5fj06awOFZNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495660; c=relaxed/simple;
	bh=yNXUjueksUzOnpP6UAfao9Z4EsJi+u12iKkcBxP/n+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3x16exD3N2FdGI/KCAUMy6p6i9P53LcWgXSqoyfnGz75v3XCIrdfvpkHMzE1w4eNiI3Uj+zVmHX6PnrzOvI2MdZbrGdHgOrZEcZR2zDRWjlyGQufqYI8KoSip6BuyJnNX9TpKgyXBNOTxrcxUIvPVrLoBPN9hERwW1CvDEt0OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZweOXa2U; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTN8OfjDqvOedw1E4Vplj3000o0WhQsArXOW9mBfQoQ89bUt1K4nS+U6vEkGGtvObAnr8PmbX8x+zlB/l3EKhWgE5LIpUsKsPVL9zg8cBuA0wjMGHFD9JfDzAgtaCPHFi9LTKAFdRRFkZn5lf+eNabhbyvasovHwHejgoQEX4PtcejygSP1cLrr8eoYkRdSvxEC0UjSUMTLcJwyCAweyImOiq9//GVce/PjAZnOAaIox6oa34fsraZAkXM0rn0lpnH7zH6xK71xhURGk5E0yjff9sZVM9a/EtyHf0dGTwma/TDZtJ3jmGGoVFkQf6s9sqwxZgndLUoZ73pE1ebm+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KcNLlcQm85NvyRJ2mo1C6yPDC2OI0lHKhCXrqtD4fY=;
 b=y1GzU+TzkwhwOxRDw3efoi8wh2YHpRkQv1EO59tQLxGWa/H3Xt85rhiFEnJuG1I2ohR9qZbqUafsZfPGgocjVw5Fyf7JM6p2eEzSYhFoJX/J1D/d0IUyweu9ygIH7CgOUXfi3rX89QTrjtokBfPNbM40uL4fRQDKLvuFQR0K3L8KxLTYROw0SzMV4yAaEC4q0JUcJEadbeBDwdTAwW0TwZ2fsjfoXMwZ2xMKHqB9mowaOuc38N42PZfe9n+Jt45n3e0PgTHNlNWtFUr5fv0p2/vnFT8YikiwkU55DbjMFDjKD9xZCwc+YqZPtbJ2oeVtpvUwJfy2sv+N6vTjn25g9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KcNLlcQm85NvyRJ2mo1C6yPDC2OI0lHKhCXrqtD4fY=;
 b=ZweOXa2U5ysitjXdFyUKbXfMij8gotENZmSEiQ9zJx2mRm0H3BsMjzLip+sKxhSMPga8D7CZgo/xtnIwSd0ljsee/WWcgsROm38EAj8YrUebuB5guFyjFexZu9XTI7CTq2VBF9AHvmd/4ysvSpI0dX59AMBT2/j4T6YkZewAM7w=
Received: from SJ0PR13CA0172.namprd13.prod.outlook.com (2603:10b6:a03:2c7::27)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 17:40:53 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::2f) by SJ0PR13CA0172.outlook.office365.com
 (2603:10b6:a03:2c7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 17:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:40:53 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:40:51 -0500
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
Subject: [PATCH v8 06/25] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Wed, 9 Oct 2024 12:39:31 -0500
Message-ID: <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d9c61c-f7ff-4546-e4eb-08dce88985cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8QKU81Knr6VmNXogoBbZfAVmJzJAjYtEhDJ4kcBZpcSi32tTiIpnlWzOqNW?=
 =?us-ascii?Q?IaixAWIY1SeeImS7o4xrhHTtBSfRlkvbXEzv/BjSsALx3m3K9aUPspzPtZ3c?=
 =?us-ascii?Q?o0N/bHFLV/OjfWHlWMvvKKSq7K+UpED37X2Kixg7rAnTlFlzqkX5zn8MR9nn?=
 =?us-ascii?Q?wzT4kJ+TW82b6gDMW/J+5zCkwWMh+FsDPyNeLj4K2RE78wB8U4hVPffZdMFp?=
 =?us-ascii?Q?grRBImW31LyxAN7kH1aB6ucTfw2OsKzng95IbIQJBojGiM81QcWcu032Pxyq?=
 =?us-ascii?Q?IVhuj0c0U9UqUXjxgQsOS1OHVNPOiCOMGs7DnVGnJYPes1nVISqMekf1839e?=
 =?us-ascii?Q?gUR42iGPJiviVMmRQ4rhlQscgK/mA5vBZQlmk8ybsn1hI0TILxUyVZnmV82m?=
 =?us-ascii?Q?CPnxMlfc8RCx2Oi7qJ9uTKX2TfgcNWXm4OujHlCxmXEooKAAY67ZE53gyuC9?=
 =?us-ascii?Q?0DJLrGHtmHv+GL2hy7atrOu+XKGF8Ak5n9qeHextAKRcBhu6BqFZN1j4tFvC?=
 =?us-ascii?Q?twVeMuGTIWAlgouiACG4x/JdNDvz6usw3tiYPezkRg9Z6qK9WfbbsunS08FB?=
 =?us-ascii?Q?lsHX/KUAkv8fWqKxUkFD54QIVuoKJeLiTEqI6bvFR74F/KSbazjaovILChXh?=
 =?us-ascii?Q?qLLFxUuDRmpHQEh+Sfu8Jx0AFIA70/OJ5KMxKDaCfqe2t/CRcFKHig6FNc5Q?=
 =?us-ascii?Q?+fhvwiTdUhRwb/0JuXRjE+Z70848oPH3b4Vn4Afpv7EIV0mHOouc0jhjANRg?=
 =?us-ascii?Q?ls34BjyJgJSvVEDHG5XD1RyXA+UevlMHkxCEx5/XWGvffrpXq9foDyJcqKRg?=
 =?us-ascii?Q?jBfQZuFDobKn1sdx5ZjRPKlydcE06lUdr4hndQhNKtH5d2A4Ei+iYm6ZbrOm?=
 =?us-ascii?Q?fNSw6vHmJpTMHOFZ3YyC5wrEJY5Kbf8om0MA064KqWpsfpu4oy0pjEEPH+wC?=
 =?us-ascii?Q?W9s+O/q8TkJOYY7U0+mKlIuwi8wYrlxm9wRwr7dPWQIXyLjKbYi7FQQjj1DK?=
 =?us-ascii?Q?ETWImSHHgcw9H1cNfei0XJ2V84Rok9dANxtOW0yZyaqBzxwoc+eYeHAdeM7m?=
 =?us-ascii?Q?S1JhzvnnPK3AuUhj05TKlADdBCI4v4w2g1TCLj+/3/EoEyI7OySisP7v36I2?=
 =?us-ascii?Q?IlrND6cNT5O1ePxwhUfjKUJjsS1VJxDzqRyr5x+eB687Ck0UOcV6fe6htGjN?=
 =?us-ascii?Q?fhUcsF02JOaYzdLraGO8l6t42OtkMTWdPyENX1PEJWCvPf6yIVelc2D8rYr4?=
 =?us-ascii?Q?W3WMoyUW2tK+PQIZV/L6WNMVSbqAw6v7oOd85jbHhbDsNERWQColSPFIz1BW?=
 =?us-ascii?Q?62hattnBFvIyuUQs45YqEbRrAjDxX6k97yEPRCvQFvEHWtO7Qeuihjiyx90K?=
 =?us-ascii?Q?y7Dodx+cdeAljCTKJQ+VvcZTjys+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:40:53.1257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d9c61c-f7ff-4546-e4eb-08dce88985cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

Add the functionality to enable/disable AMD ABMC feature.

AMD ABMC feature is enabled by setting enabled bit(0) in MSR
L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
to be updated on all the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8:
  Commit message update and moved around the comments about L3_QOS_EXT_CFG
  to _resctrl_abmc_enable.

v7:
  Renamed the function
   resctrl_arch_get_abmc_enabled() to resctrl_arch_mbm_cntr_assign_enabled().

  Merged resctrl_arch_mbm_cntr_assign_disable, resctrl_arch_mbm_cntr_assign_disable
  and renamed to resctrl_arch_mbm_cntr_assign_set().

  Moved the function definition to linux/resctrl.h.

  Passed the struct rdt_resource to these functions.
  Removed resctrl_arch_reset_rmid_all() from arch code. This will be done
  from the caller.

v6: Renamed abmc_enabled to mbm_cntr_assign_enabled.
    Used msr_set_bit and msr_clear_bit for msr updates.
    Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
    Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().
    Made _resctrl_abmc_enable to return void.

v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
    Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
    Introduced resctrl_arch_get_abmc_enabled to get abmc state from
    non-arch code.
    Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
    Modified commit log to make it clear about AMD ABMC feature.

v3: No changes.

v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  5 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 36 ++++++++++++++++++++++++++
 include/linux/resctrl.h                |  3 +++
 5 files changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..43c9dc473aba 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1195,6 +1195,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 186d8047578b..49d147e2e4e5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -405,6 +405,11 @@ void rdt_ctrl_update(void *arg)
 	hw_res->msr_update(m);
 }
 
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
+}
+
 /*
  * rdt_find_domain - Search for a domain id in a resource domain list.
  *
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2bd207624eec..a45ae410274c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -56,6 +56,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
+#define ABMC_ENABLE_BIT			0
+
 /**
  * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
  *			        aren't marked nohz_full
@@ -477,6 +480,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @mbm_cntr_assign_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -491,6 +495,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			mbm_cntr_assign_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7e76f8d839fc..6bfa8312a4b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2402,6 +2402,42 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+static void resctrl_abmc_set_one_amd(void *arg)
+{
+	bool *enable = arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+}
+
+/*
+ * Update L3_QOS_EXT_CFG MSR on all the CPUs associated with the monitor
+ * domain.
+ */
+static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_mon_domain *d;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list)
+		on_each_cpu_mask(&d->hdr.cpu_mask,
+				 resctrl_abmc_set_one_amd, &enable, 1);
+}
+
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (r->mon.mbm_cntr_assignable &&
+	    hw_res->mbm_cntr_assign_enabled != enable) {
+		_resctrl_abmc_enable(r, enable);
+		hw_res->mbm_cntr_assign_enabled = enable;
+	}
+
+	return 0;
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 511cfce8fc21..f11d6fdfd977 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -355,4 +355,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable);
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r);
+
 #endif /* _RESCTRL_H */
-- 
2.34.1



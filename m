Return-Path: <linux-kernel+bounces-443879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A969EFD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C9428B393
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78B198E7B;
	Thu, 12 Dec 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vihZqvwh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4FDDDC;
	Thu, 12 Dec 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034579; cv=fail; b=addt+nZqIgXaAjdmQVJYSnmvd7CopW74sO9ReGiapciQP4W+HtvL+W30nW2cIhjMmb5Ykv3T8WVHdw4gO5Lx68OB8wgOCunoNtJjxRRC2zcfILS5e6EqAfmNUeb2Zw/vmFwfmXjIcg8AcI9g57ylk3fMChs5PMutTmI1pl43Fk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034579; c=relaxed/simple;
	bh=GEwOMz5lT6AWEepdlW/PxcKRmfP2HdidBsD3hMXQCHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNBNN66y8rE4r705wOGxycN7Ia/kw+DZ5bhuS/qjOm8JF8+FVKDxJDylhQABp8KkInX3xipfCNkGa929DOOse6JFMsjqCpinzK7LiWjJAFOvCNfHqeZhxDF6q10cVJPC3Q0OgcdAn+YNw/fwhOQ8+nMoBoUjVGNQS0WIHHrlBzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vihZqvwh; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFQdXQQoAxa39Uxb5HlGYdhUob3UvvV9TFCuZOvHVJhHkm//D2sfLa5DQ8487LH/cT2C9+LHXcJZ3bCZYFElZe7KH5RZwYWOB+Xpw5FRnm3f9XXgOyS6J1j6Q33jjcDKpMD1PR5uablrILolLVj4JHZKf9PvDuwiCltjN9/oSAlz1U5KLnlkEGZRst0Rw6O0IaiI6jjSeR7TXkf8gQYFnJ9fTNREabyrIGeRgEFCKufOw+XleSoQfczcnPY5jHTbcojLmXqOgCa4kZbBXFmfOwTGxadrNRA7AJQN46SaIlJOfsSot3WwGR918zogK3F1Cc4O+kyBvTE60FpxlKD2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA0LZaMn5VYv5XdU1rJ/5ilqNhtLRBGh3iNpYBmN/V4=;
 b=CNuo1Ugh0MuCxN79apBF1ypxO0CsMvdBft715g8Vy1OxzfLJEOCRr75rDDhjlUtq5kZBsrJAXP1cjQt28NOAsVsO4RUxRaKZ4WeRSwFbZwv3iFC4IoQFmyJxZdHXy/c3dk1KyWi/ROMEyzzQw4PqI7QDlNcin/1uYd3WmGQyOuW+Ja/YKQd8NphzrgU4s7f0VjRhAXmVHQiM+2bzOsFpuuDfHfyu3/h+a+n/4xy3U4O+UUytWBGQBSy3i41FdoliTD81+fsBVD/8u3lmZfMl2KZbr0N4tzcqiY2lv53W5AySYsMSdu463aasaV2hv+ILI5yCqMPlRzrYoeaLdMlAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA0LZaMn5VYv5XdU1rJ/5ilqNhtLRBGh3iNpYBmN/V4=;
 b=vihZqvwhq9ncoK6EDDy/K3axkCSF7aCvPURJwESQNTO5nj2WsNZ3icYqKIQBt6g+myaTnhomFuriCVYJbpdllt4YsFXI0NGCvok3iK5Zftio+ixgYYNQfn4+XPqhMj9LQ+i3HoS20SN2vZTOYbb8It/424wg7R5JqEpCeN0FpOI=
Received: from MN2PR12CA0003.namprd12.prod.outlook.com (2603:10b6:208:a8::16)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 20:16:14 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:a8:cafe::86) by MN2PR12CA0003.outlook.office365.com
 (2603:10b6:208:a8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.17 via Frontend Transport; Thu,
 12 Dec 2024 20:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:16:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:16:12 -0600
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
Subject: [PATCH v10 01/24] x86/resctrl: Add __init attribute to functions called from resctrl_late_init()
Date: Thu, 12 Dec 2024 14:15:04 -0600
Message-ID: <09c75acd47d270be9843a203f533024926b31bea.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 686963bc-05b7-4724-fb53-08dd1ae9d420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNy3qIRp1IpThZqKvfwuatPQLKtsRXg+Whac0csWL+7tg3RGOFbpAmXT8gA0?=
 =?us-ascii?Q?mrv/gcd+ohGIG6d46vDOn8TaTRFMdEcwvP+YID93b0GOHNTMZDBNxSJiAwam?=
 =?us-ascii?Q?VvNnkB8/jg4K2moxfwKClDSEKoHH4TGOHanV+KZ4jxYCguJ3/RfM+vw9R6pC?=
 =?us-ascii?Q?PcO3hhoJyDkPwYrDIrYHX5imtfacqG2/e+AtI8sLYLVOaul74wIGV6VbQhA3?=
 =?us-ascii?Q?15i4Un1qK7bU17uIu5MFZjH+JqoJ3gyLHfvwpgczXq0uOebKB+b6rwG/K1X5?=
 =?us-ascii?Q?AN9auJNZCjOALmPQdiiy2ofSlSE4HAo4NzG3Tmf+OHK/8ErFjC9+wHQrRPIa?=
 =?us-ascii?Q?I7sNfcbjpnN/u+alZNHy6kP/LfzkkGK4ft1enPvd6Sr1YsgdqTBJpVWY+oTj?=
 =?us-ascii?Q?I4u9WIzkV18FxjvKgL4aeYXrGx/ukW9mCci7RnEbBu9fTAUCviHSMK49Vevs?=
 =?us-ascii?Q?EMWA+LTAam6bKFHFZLBtZCfbJpbskjmeMbsCZsGAJ0JjaJi4hIVOKoM/QRuG?=
 =?us-ascii?Q?+JRJHriudWTwlChWD1hdSqp3CzWgrPSDsCLCdgYGdJGqDNL2cd3gLbtPgXs1?=
 =?us-ascii?Q?zpOOQjzjPHJdem9+WfWyCOaxs43odIR7fu6CDy5ED7tZt1ccOFnPFzIWGTQZ?=
 =?us-ascii?Q?kBhVX4PCH24vFWfEDaRE/kkfWS4Cgho4kdq7em/2VVJO5ZVZ5ExtfB8e7FdG?=
 =?us-ascii?Q?8tcpUfTZNB2Tvrb+dYDcbnaDUZl/GQ/Svg3cve+Gi+WlI9EriYjlv1Wl0gBu?=
 =?us-ascii?Q?2jOeR19/b5Lm9v0Np7ETKRiDDUXutqudwz4MFQIZBtIT2KwcdsLYQinWL1X2?=
 =?us-ascii?Q?v+EkR5UjZM+VYtWPZbeFwKc2rPSXd/n5/SjspGemUr95oB3dr6j1395D5nfR?=
 =?us-ascii?Q?TJe8pXIDn4y54+BoFaBj/qcgzJDndETQnaPILdaS5BADbLkjB7Dv15eteYTl?=
 =?us-ascii?Q?LrbUSpPO6sS+osEWAkBYwsbN799g9xRUV/6ztzUIE6F1DAykV441LpOdO43s?=
 =?us-ascii?Q?yTDRBLPFfVdb6yMC10F3eBCOtUWL7wvqbtKOSMyKxZB8sWDoyerEwl0A2jzH?=
 =?us-ascii?Q?QSHZwm4DvaRtP4Bdgm4XIHq+UBw7kelKGi5U80lotlFchgjszBiKKjY8ZSJ4?=
 =?us-ascii?Q?eqqtB7uQfvBgPqdGeKtDqs7UWoGqiU70dqAkQPZIvPXqQa8DrLazt9OZK7se?=
 =?us-ascii?Q?5s9Es2px5tKTp0tbKLNYLA5mZJkaepXpHI/mVcEIvVTt5AHJ+HyQJA9ZJ7fs?=
 =?us-ascii?Q?qnR4JJVwFZVYvjVygrPq/RabMNtdT8Im2KYU7Z4RFTOgBU1cPsZNLUfbafvy?=
 =?us-ascii?Q?bkL36tHCz3IUUMNvbKFELqblpolpWGZu1M76QxNi31LcPtnZI7hscgFOPoel?=
 =?us-ascii?Q?JSZl7E2lCw8uMzMEMpHFZBHlVDioupUPtIR8M6ewLJSI/osYV0hB9Z9W89z9?=
 =?us-ascii?Q?ST376JTgNxihSQft+1iyb7zyFI73D7rk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:16:14.4486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686963bc-05b7-4724-fb53-08dd1ae9d420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

resctrl_late_init() has the __init attribute, but some of the functions
called from it do not have the __init attribute.

Add the __init attribute to all the functions in the call sequences to
maintain consistency throughout.

Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Text changes.
     Added __init attribute to cache_alloc_hsw_probe()
     Followed function prototype rules (preferred order is storage
     class before return type).

v9: Moved the patch to the begining of the series.
    Fixed all the call sequences. Added additional Fixed tags.

v8: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 +++++-----
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b681c2e07dbf..62f2c5bbe2c6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -145,7 +145,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
  * is always 20 on hsw server parts. The minimum cache bitmask length
  * allowed for HSW server is always 2 bits. Hardcode all of them.
  */
-static inline void cache_alloc_hsw_probe(void)
+static inline __init void cache_alloc_hsw_probe(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
 	struct rdt_resource *r  = &hw_res->r_resctrl;
@@ -275,7 +275,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	return true;
 }
 
-static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
+static __init void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_1_eax eax;
@@ -294,7 +294,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->alloc_capable = true;
 }
 
-static void rdt_get_cdp_config(int level)
+static __init void rdt_get_cdp_config(int level)
 {
 	/*
 	 * By default, CDP is disabled. CDP can be enabled by mount parameter
@@ -304,12 +304,12 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
-static void rdt_get_cdp_l3_config(void)
+static __init void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
 }
 
-static void rdt_get_cdp_l2_config(void)
+static __init void rdt_get_cdp_l2_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L2);
 }
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 955999aecfca..16181b90159a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -627,7 +627,7 @@ int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
-int rdt_get_mon_l3_config(struct rdt_resource *r);
+int __init rdt_get_mon_l3_config(struct rdt_resource *r);
 void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
 void mon_event_count(void *info);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5fcb3d635d91..daf2e8c03d86 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -983,7 +983,7 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
 		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
-static int dom_data_init(struct rdt_resource *r)
+static __init int dom_data_init(struct rdt_resource *r)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	u32 num_closid = resctrl_arch_get_num_closid(r);
@@ -1081,7 +1081,7 @@ static struct mon_evt mbm_local_event = {
  * because as per the SDM the total and local memory bandwidth
  * are enumerated as part of L3 monitoring.
  */
-static void l3_mon_evt_init(struct rdt_resource *r)
+static __init void l3_mon_evt_init(struct rdt_resource *r)
 {
 	INIT_LIST_HEAD(&r->evt_list);
 
-- 
2.34.1



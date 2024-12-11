Return-Path: <linux-kernel+bounces-441960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B879ED61C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7501661B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D420A5EF;
	Wed, 11 Dec 2024 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QA65KUYd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0C20A5CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943377; cv=fail; b=mYXKADICUw7vXYHefKxqNQKqU8C7VP6wKrJn2xZeWHosesrrvH12hlX8J5cY3fezBBZ2TY36ETQfAuyb9Gqe0hzHH9nPU6zIx0JLl+72B8aqxSp0ea5CiiAwxYCwnN+uqp2X/t79xq54PItwKkII1E2MzAclnWdU5qYxe/nlHhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943377; c=relaxed/simple;
	bh=aII3gssnaB0ZvQTV55Ld2wMZVH5ZyfAIW0mV/qw/Nqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YVCgOf1L8UJ6dY4ZU40OKGtQCoKUA3ZcObuyl8eqnz3hUXbvBXjBj0ekyerSm2neSFKV173cgo+eke/fIJES9ZUQTkAQ+h9/fuPRXb08aqn08iJ93s2yiEnro/gd94ubjqNvZNqTfymJTMId6YX8f+vE5MMwccy5SpTdZ6cG2k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QA65KUYd; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPqhX4ZIPG0O9LvMxX2hBGP+w6tpu+MYavW/YNVJo4QjqN0/opQDeP/WRwlPJM3qDmBYExWgQn2Ci4ay2l6JjSjcxscx7sWy/SexHhHu/sRsF4EhixvAdVtrSacZW+XjG45JJ5hL6zuu9MBdXKBAfVpMetfJYI7mzg/fVT/493uy+QQKEGivYllWSgBuHD5drmW5UvTzhA56FCu5aM4A/VIqbmBmVIoJgJlzsahk+iT8sEjm5QKhnrf/YYj+QIEjV1WXjUphXEH5+vV+oAcxTLz6IIPB0e1EuvC6uxu4fa89hJS9zvSzPCv5aNPSQj+f7oSJCh6JtL69AGhw6MiFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vml/Em4B3omoi6qyAlUzVwNrcJ/iVFcm/DVOq+yIn2U=;
 b=baGW5rncwhPEOGoeR1ZlgHzbK8NdgaxnEQNOzja6XAJIbEtR35ijuteSitEH4KuvUMn07DlvNhj5acsu6f5q9B8p464Lw9AMyK47U08cA72uXIuHtMDJQUL6f1YVYaXIapwtNAMoraEkr3e1LJiJXKAfICgwpW81LrP0i8V+gHcmq2a9sKpO+koh8sho3STfTchOpDoEZyOAh5pczX5IpWyL5wcpLehW1LpURO1731994MvI6THda0yAMX879/qFojfhlohE/LKgAE1Dsw31AO66p6HmKXCwhy2VvCkzF+ujp/8xORGA4d0HuF4LmykpzIPN3erebHHBSDG4ghtEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vml/Em4B3omoi6qyAlUzVwNrcJ/iVFcm/DVOq+yIn2U=;
 b=QA65KUYdqTmGl05KoHULqBO3S4d80BPNSvWoxDyr7YHM6iquhgO2KkX0wpBHHFw4G1VZg8ywlUTAE6xMPFS6M4ctMNtj6nulcsCERPMp7LOgaa/gux6CA38RT+1en68xGOjUZnhQuI0m18AD4sf8vIpskVtm6A+4Fk6MJSj9dDk=
Received: from PH7PR13CA0009.namprd13.prod.outlook.com (2603:10b6:510:174::12)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 18:56:07 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::e0) by PH7PR13CA0009.outlook.office365.com
 (2603:10b6:510:174::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 18:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:56:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:55:59 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 0/8] x86, sched: Dynamic ITMT core ranking support and some yak shaving
Date: Wed, 11 Dec 2024 18:55:43 +0000
Message-ID: <20241211185552.4553-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: f36d83d5-8a28-4af1-bef3-08dd1a15781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Qnkv/dDgnQ3h6P3cmrrVqdiDxiH8fGhxcBbwgzt8SjEqCLzzrFW4gzERdzr?=
 =?us-ascii?Q?irFHkk2UKVArHn8JKNkm7ZunptqXZ40BOmnAIjGTZzIeNkCmawKPg/8j829Z?=
 =?us-ascii?Q?PwVaQ3NLs+/rkaJ8/khUYpu2eGULAjY9f7dUqdtQXokGwazQgNqqEJred3g0?=
 =?us-ascii?Q?lX9JmgcIeNX8NebXSbY3sF1+sVnvgmJnI0GiKU2OHPzAoIAP7wjxZkwaobhV?=
 =?us-ascii?Q?w1NP3jjLqjbglOIG5/y4l07CE0gazBS9axh5ao4dhrVUMU+kTtfKeSDQC8ow?=
 =?us-ascii?Q?FbN8qzxOTRC4Dke6Cj15vFUd9gc0A7aEnUz7N43SSIgnjo5CrxAJGB5eYDSJ?=
 =?us-ascii?Q?unbOa34DQ2VeHjpLQqfqinU8pAtuCKmrsNREXIVmm71tsXh4RduR6LbxeZif?=
 =?us-ascii?Q?a+w0YFzOOuYOpTClUjG0pXSAp55wV+g7vXFkc1fNeOPhXAUCsE2UjgMctSAg?=
 =?us-ascii?Q?kTtIeqEOPZYsrvz7hf8bj4OUt/0tJ6cV/QPfe8LH12xWZcrQVTb/aAQgNorU?=
 =?us-ascii?Q?33f3MjqVgWOMaRxcdLgA1qppgporBVDn4v8OLG//6uWk9A3oQ0tyhby00Qjc?=
 =?us-ascii?Q?L14kHJ6mDrlx5j1P4Qoayk/cnByVzhXUJYTArNZHFCRDpJcepTADXrIUdkPE?=
 =?us-ascii?Q?ZivWdNWPIlVg8g2dMNdT2+K7U1SGeKeW7/CoyVICzE0WrVA45g1YVbuRteWi?=
 =?us-ascii?Q?0DODJRd+IMx5sy3DqxcKZlC2j8gXgj1bVP3h1eKOZTc8ld2HbRdQBpxM/WZN?=
 =?us-ascii?Q?OyKHMNPdn2RtGe59oXHerMWqshPIHR8j9BVkXSRpzDUcXuoWR0hInSjqkLvI?=
 =?us-ascii?Q?f8ssXsTuQSXlT67oJ/eMaFiEt4eOQz3budWPNvGRHDPOKXUan9Ey0dC2rEWL?=
 =?us-ascii?Q?JcnsRIw7dKCQsp8Xc1H6hgvTnyWGDI//+n/C2QQQxr0Bsc75rSP8JbC3DXKo?=
 =?us-ascii?Q?WDIL6yvTDMOPqrN9ZWzst9DL02pp3GzaycbM1VJyu77T3H1XS8ri9Hn4sIAv?=
 =?us-ascii?Q?OPQtbIjH1lazQiHMt2zJh31zl3aptxEMn3O5iDx1HZyM7Z6Q00dR6Wi1lgtD?=
 =?us-ascii?Q?jc7a5gkjlwIqDYywcOvQMEfH+EKOdZrIkOvlw6J9UVAIThRjdbWbGJHEYqQN?=
 =?us-ascii?Q?zPEdf58Bn5z6KDqaOtqwSeOXX0h8D9HWW833IgCRyBch1cdvsIWPs7ZkqJs9?=
 =?us-ascii?Q?TyOfgV9SkFyehKecqza5UwZ56EpjJcJhVnkNFzbems3dR6bYc0BG8i9hq20y?=
 =?us-ascii?Q?U3i+ZBHLaSw4SfXD+dDrG5PTP66aPJlrtZBKKkZDr8pDd8z5FClNxZNGl7n8?=
 =?us-ascii?Q?JUQadyhMxUc6SLzptC+wV6Rr4DvR0eYvEWru2BUtiNerDYTVXEhUrh+e2DrP?=
 =?us-ascii?Q?jlBr9/1pG2WNLQa93K35FaHThmiJwuoQ3VlE6ucV7WTylITtUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:56:06.7482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36d83d5-8a28-4af1-bef3-08dd1a15781c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

The ITMT infrastructure currently assumes ITMT rankings to be static and
is set correctly prior to enabling ITMT support which allows the CPU
with the highest core ranking to be cached as the "asym_prefer_cpu" in
the sched_group struct. However, with the introduction of Preferred Core
support in amd-pstate, these rankings can change at runtime.

This series adds support for dynamic ranking in generic scheduler layer
without the need to rebuild the sched domain hierarchy and fixes an
issue with x86_die_flags() on AMD systems that support Preferred Core
ranking with some yak shaving done along the way.

Patch 1 to 4 are independent cleanup around ITMT infrastructure, removal
of x86_smt_flags wrapper, and moving the "sched_itmt_enabled" sysctl to
debugfs.

Patch 5 adds the SD_ASYM_PACKING flag to the PKG domain on all ITMT
enabled systems. The rationale behind the addition is elaborates in the
same. One open question remains is for Intel processors with multiple
Tiles in a PKG which advertises itself as multiple LLCs in a PKG and
supports ITMT - is it okay to set SD_ASYM_PACKING for PKG domain on
these processors?

Patch 6 and 7 are independent possible micro-optimizations discovered
when auditing update_sg_lb_stats()

Patch 8 uncaches the asym_prefer_cpu from the sched_group struct and
finds it during load balancing in update_sg_lb_stats() before it is used
to make any scheduling decisions. This is the simplest approach; an
alternate approach would be to move the asym_prefer_cpu to
sched_domain_shared and allow the first load balancing instance post a
priority change to update the cached asym_prefer_cpu. On systems with
static priorities, this would allow benefits of caching while on systems
with dynamic priorities, it'll reduce the overhead of finding
"asym_prefer_cpu" each time update_sg_lb_stats() is called however the
benefits come with added code complexity which is why Patch 8 is marked
as an RFC.

This series is based on

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core 

at commit 2a77e4be12cb ("sched/fair: Untangle NEXT_BUDDY and
pick_next_task()") and is a spiritual successor to a previous attempt
at fixing the x86_die_flags() on Preferred Core enabled system by Mario
that can be found at
https://lore.kernel.org/lkml/20241203201129.31957-1-mario.limonciello@amd.com/

---
K Prateek Nayak (8):
  x86/itmt: Convert "sysctl_sched_itmt_enabled" to boolean
  x86/itmt: Use guard() for itmt_update_mutex
  x86/itmt: Move the "sched_itmt_enabled" sysctl to debugfs
  x86/topology: Remove x86_smt_flags and use cpu_smt_flags directly
  x86/topology: Use x86_sched_itmt_flags for PKG domain unconditionally
  sched/fair: Do not compute NUMA Balancing stats unnecessarily during
    lb
  sched/fair: Do not compute overloaded status unnecessarily during lb
  sched/fair: Uncache asym_prefer_cpu and find it during
    update_sd_lb_stats()

 arch/x86/include/asm/topology.h |  4 +-
 arch/x86/kernel/itmt.c          | 81 ++++++++++++++-------------------
 arch/x86/kernel/smpboot.c       | 19 +-------
 kernel/sched/fair.c             | 41 +++++++++++++----
 kernel/sched/sched.h            |  1 -
 kernel/sched/topology.c         | 15 +-----
 6 files changed, 69 insertions(+), 92 deletions(-)


base-commit: 2a77e4be12cb58bbf774e7c717c8bb80e128b7a4
-- 
2.34.1



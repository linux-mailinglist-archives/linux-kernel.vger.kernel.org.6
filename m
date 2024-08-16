Return-Path: <linux-kernel+bounces-290028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F731954E96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0438281A07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCB1BCA1C;
	Fri, 16 Aug 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRkzvd6Z"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227942AAA;
	Fri, 16 Aug 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825000; cv=fail; b=t/v51rb1WozMdjpQ2P20J7ykgW3lN/pLyqJJmslx/Etk7C5iFHe+sxDaFdVv4M72mtYzK38xBReiFVnsoeYfZpDSyY3L0ZEGyTnmffCxlxzdHsACmVnijWxJTHsa3R482NFIfzKGlrAjVYk3E3MWCJWgaV4B0yfELk9KCSQBoYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825000; c=relaxed/simple;
	bh=DTi1o3n22cC4yHWpNrxKTpQqBDVo9SBuK4OaYGNKB5U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRMRngI0X8JKS4tTFbs9R3QmLszW+9DuJhcfCCC4G9yrtRrRXFQPKEbG+LQMxeA83zLZbYEwikUmjicXE+eFyFo1OIFJfwLUmsTR9zWf+NDTx5R4RJIbyX+Pjp2lcGGRx5ph0aZmsoIMZqrSed/QYA7wB6e+jkkvIrBLGSI3MLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRkzvd6Z; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5i4v3AwlXKDCISUE+z3YPdpbCE1BLEyHipf3nIpys4FL6mq+czc3C6MN79guHoxLynKerM5IKTyA3iWdWb4dAen/iVb7EqibS7Eb+j8otHu1N8itlp88QjIdNScS9GEejHpHtCzdV2YD/3+OHElVQ1mJliN6RwS9umxTdCReyjO91wybDnCgkuuCo7bpjhcyQO75VLL27lnNfPyElDr5BuYhNBcvxlA+WrM5j7lMN0PdieATDbJ0HnDwf7phiausGNVtZhqvepPbByz3wf2HfkTQn1mA839xejRCUQ2p08eysTcdg/PnEi6fNyFvI5LxulM576j8UXbl4ihgMhF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmvfIbhhF3xNJFFBEQU7J5at07ZT6DuGacR20k4INrA=;
 b=Pwnde/oJBosn/D1rCqLjzk2CYY3IfszJTtVAKYEoNjnxfShMDzrrS5HE/OVxqdIfUYkH5ci5DRzI20AonRrFjUWIwvTyoK5q3/YwfyfhybNcHLhS5eLzwd3MTg45Sux7IK4CQQptETN3DU5l2GJ2sK0EGf81911JcwHeUo14wVFzNtzm6/zKszzWqu6g5OE7R1HgUmom8Y0h5E2LOh//g1eKUGY9IzkcmACmDUqKaVp0odaudy1Ee7/YJuK3cpGT/+tWEdcoCMRMrP/b6qJ8meYWWVJPUdV2nJA2ZyAWvLMZYQnH85fQi8k0TK5a6w+N3cnda0EEQSwvdFCQFSAXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmvfIbhhF3xNJFFBEQU7J5at07ZT6DuGacR20k4INrA=;
 b=xRkzvd6ZMECIySdua5V3m4q0XRr6/BZE9v6icfBNov0yYMEcUT7dV0+aF/abs/MC2rkd/FelD7BHlhbaA5CQqgOA+gw5xb1zLQOSoJXIweIjUYp3217SF30MnN4EjUkzQH1L/VXS4fICLkHNMohMXh99alhYt9cjhR9Yvur1CF0=
Received: from SJ0PR05CA0155.namprd05.prod.outlook.com (2603:10b6:a03:339::10)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 16:16:34 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::71) by SJ0PR05CA0155.outlook.office365.com
 (2603:10b6:a03:339::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10 via Frontend
 Transport; Fri, 16 Aug 2024 16:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:16:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:16:30 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 0/7] x86/resctrl : Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Fri, 16 Aug 2024 11:16:17 -0500
Message-ID: <cover.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0205b2-bff0-4ceb-a321-08dcbe0ecb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYAShvLOnWxFOpXpyeUso80PxmMt/FsOWJLhsu822XZBmtyBF3M2ZBLvX5oA?=
 =?us-ascii?Q?qnx8ZH+nHovaisGqq0xBWfjNSVeZtGZ2KaIbeDc1jUCHdNXqm6FCJ2Frchzm?=
 =?us-ascii?Q?BKIuIbNsAKL30g+5dseFFTQ2LuOyjd5ojZhd9HzRYeBVCd/brZP3Mqdrg86j?=
 =?us-ascii?Q?+AcoFuyuXGa2r+KzLaCDQl13KQ4WJ19HYNSQtfRonsslPyze3F3oNqDER0lR?=
 =?us-ascii?Q?6O70L/SaHL6st3kZidDaVtJZryHSN+nSnoeN5NNI54CnFHwYeqN9FWAQ7Ugn?=
 =?us-ascii?Q?G1XeXfMcMYU4Xr1MtbBqpu/aiDG61LXPgmZOrdYWLr6tYFFm9lyHYWmrkbQv?=
 =?us-ascii?Q?MLfobEZMJQPNONzcJeZaDkCtilcK5smzXvdjIqO2Q3EoBQ4NLygAd7dBtscn?=
 =?us-ascii?Q?QJvmzLGurBR5fG4iScBNhD34b4atWSzyV4rjz1oUEytNjvJBGm6uCabMAwq8?=
 =?us-ascii?Q?YNH/pVOex8zsCRNJaksCMmu5TeXQaSW2d5WQEIVn2rOLsWcMfWIfSQTd2jgP?=
 =?us-ascii?Q?Mk12oAKjxeuAulNqY4X6ho3s/4Oe1ymwAA7BRgHafpqC0K/4mx4IqHUGKTUA?=
 =?us-ascii?Q?dA2lNCd1kQOstivsleYnwW0PiXopOgJwyi3/sZxVvZgbA0WbbNtzY0HL+U5b?=
 =?us-ascii?Q?jCW2TsNgO7QTglqPxpOUS0R9XTsF8YnUdFRQaB8PD3FWPQUHg/Tt/wqWKGqZ?=
 =?us-ascii?Q?GerEUeQpbevo9NquSIa7SdczvOW+z5fBAyXCel+Vimd8TVt6x4r0saAcH1Az?=
 =?us-ascii?Q?tvG38JPafpDuGMCO0h2BjEjjlo+JB25095BfvB69FpVABavZclgE7uTSdCEg?=
 =?us-ascii?Q?J1w/EEqJO8RltbjDg/BeHkCKtzCanu6ztjz7fynB3KXGWenaLD5D0Rkkhj8t?=
 =?us-ascii?Q?xmHq6cXVpwayqJvesh5PFdsLJNdV/1iPt0Kn42XtjhqVPli43VjIccanGQNv?=
 =?us-ascii?Q?ePxCfgz1Buiyd4gVHbn6UnwplzH8HaMG8hY74m+LkDY/a92R9EsFFZ/FQYs+?=
 =?us-ascii?Q?6HHPyHYxBU+IgZseEJEhp/mEFZ6NEB2u6YUcbMb+COF/dOFSYoor4NbjmgFr?=
 =?us-ascii?Q?enAlkDB7G8OUEnPZQz8btpSufnJo7dVO5gdsBAYkd7oJmd+KdgUDNaom/ATv?=
 =?us-ascii?Q?a31WF5HEaIDhzH5lbUrHDkP0uZ+4N1DU29bFHKemxZlUxuB/cbpF6Lzl0FTV?=
 =?us-ascii?Q?Z+tBQywe2EmL4x8DJZtxuHwUdXQ666yQ2vSCF41u97x2U7lvLpT2Th1XEBcI?=
 =?us-ascii?Q?QGeTRZo45oZQG13gc6Lg9CBDCE2eMrbxNeJOg3LHdlxpeCYttMNoYvi3CONV?=
 =?us-ascii?Q?gjmQAcPqnH5FLbIHtwfLCoVSC3jQXn1WiPxHWSLBquFo7cst0XuABMdx9q0i?=
 =?us-ascii?Q?58yDTik7vX9UBPIVb/2AEqKpG1dP/T1EXJtjOPm9mFM9LUo1T/AsL21nZbuc?=
 =?us-ascii?Q?mTWywGP3fc5yIPIp4EGQdd0p82L/mGFlKCPS4hpluhORfxz90TyLZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:16:32.3512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0205b2-bff0-4ceb-a321-08dcbe0ecb0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833


This series adds the support for L3 Smart Data Cache Injection Allocation
Enforcement (SDCIAE) to resctrl infrastructure. 

Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
Smart Data Cache Injection (SDCI) is a mechanism that enables direct
insertion of data from I/O devices into the L3 cache. By directly caching
data from I/O devices rather than first storing the I/O data in DRAM, SDCI
reduces demands on DRAM bandwidth and reduces latency to the processor
consuming the I/O data. The SDCIAE (SDCI Allocation Enforcement) PQE
feature allows system software to limit the portion of the L3 cache used
for SDCI.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The feature requires linux support of TPH (TLP Processing Hints).
The support is ongoing and patches are currently under review.
https://lore.kernel.org/lkml/20240717205511.2541693-2-wei.huang2@amd.com/

The patches are based on top of commit
ad1b4b6ed19f (tip/master) Merge branch into tip/master: 'x86/timers'

Babu Moger (7):
  x86/cpufeatures: Add support for L3 Smart Data Cache Injection
    Allocation Enforcement
  x86/resctrl: Add SDCIAE feature in the command line options
  x86/resctrl: Introduce sdciae_capable in rdt_resource
  x86/resctrl: Implement SDCIAE enable/disable
  x86/resctrl: Add interface to enable/disable SDCIAE
  x86/resctrl: Introduce interface to display SDCIAE Capacity Bit Masks
  x86/resctrl: Introduce interface to modify SDCIAE Capacity Bit Masks

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/arch/x86/resctrl.rst            |  29 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |  10 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   4 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  15 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 298 ++++++++++++++++++
 arch/x86/kernel/cpu/scattered.c               |   1 +
 include/linux/resctrl.h                       |   2 +
 11 files changed, 361 insertions(+), 3 deletions(-)

-- 
2.34.1



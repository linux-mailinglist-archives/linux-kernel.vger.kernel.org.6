Return-Path: <linux-kernel+bounces-344959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E898B0A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508FD283480
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AFC18756E;
	Mon, 30 Sep 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lvBgTQms"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD46183CA4;
	Mon, 30 Sep 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737876; cv=fail; b=kma0pTjoBlAW+dqKOE5zyW4Z9CxIlUZqBuOXGqol/6KYnzSeRdko1IEuveWA0Sqyq5sM7/pn0j/gEEKI0xMwgCXcLUlL8OoLqhJN8wWSs9qnTMYiWTWmNSmHmXorxy+Sb5H+Lt8/kLz1NPJ9xfiOYhjmeCSrMZnK4hMB59Iqsbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737876; c=relaxed/simple;
	bh=fbQ80J68rXmT5YIASRBYNlZc/Xz+hgMejPSzpeemUeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aI7zsIt8LbY3RoEn4KCOhDsIRvFAVOP/ezrAWN8dEZ+nB2NeF+gV2aTbF/0refMY1NWJpEzSZ0zWmW+a+88F5rRDvWkKDLKR2me2MhRHIWwMppBdh8TaNUyiocOgjDUvbGaZJCdZctDX71OLk0F8IgiYVbvkriIRM9xha0leov4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lvBgTQms; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRRTjr5op2CQwaW0apIaC8IfdW+zeqRnH4MVEEAnIPV8YgzBdpnQnb9f4zkNRZwEXEVhXBAPJrG7jSuhgjW/ur+ifLuAq1nsRBXdixhAkqAMAhTp1mkImcKYzyqT5pdntu5es17fWz6ePXpBhOoAQtp2kQH0+GCdX/keLG0xlmynQQT+pKo0eiC9hypS/WBX9jF9qZi2g1NV0fO2uhyLRGitNRtx4+u/ZfPFngXGRYDUyFH/mqU45/cjKmCGHejUnGj2C1wVH4120+e4BEUieQf2sHvSRTUV0P5da/5tom8sAv55+p3/WXiq63x2upAB45Dzl8LlRab+Hqbc0jN/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtMjDKgBrf13RBTJM7nUo6XD7+COGt9BkUSD5fPcMZk=;
 b=ag5sU7dgTC51muXFRoF/W7Jvs+3TqNMzVCtanQ7NjxLMdZKLqXYwt8CKEH3i9sgy6YNBOq/iBZAU7IeqXXv61EWhQOzaQyIBBNY52lU0gATMlPSlIfBZQlTS9IPzHaBbuQmhGvrtJewM/n2jSEjLmYnQDL+ueRd4h3JANXujZVAS6dszgvVtbekOGhwbcZhA2hN+c3YCIAEc42jK5aD+qeO67zoSt7pkYSRrePp44oCoStk3CwK/AaQdiAJxPQ6nR1RRoEelwVkNiZvH1bm6OeSkf5dvpC5PUI3+wBHqV1QdWdsWhvnjJLoGT4WK0JcigEbPHolJgzOifY2pmmcajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtMjDKgBrf13RBTJM7nUo6XD7+COGt9BkUSD5fPcMZk=;
 b=lvBgTQmsWG2USvKyhQuEpNdA98YYClS94HyhFYQ4oA2c4Qt0UxrPmgqZCTLL2ecRebEjrKwpEjmt5I9VbE2AbO7Ugt0z+WkniY0dMkEirWzIpOxzOupa3zJz1UpzqhOklIXw+o9CXv+TVs7qf7hC9bcRtOq17VgBZwcC9iKmzyM=
Received: from CH2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:610:20::39)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 23:11:11 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::96) by CH2PR07CA0026.outlook.office365.com
 (2603:10b6:610:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 23:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 23:11:10 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 18:11:09 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v5 0/2] nosnp sev command line support
Date: Mon, 30 Sep 2024 18:11:00 -0500
Message-ID: <20240930231102.123403-1-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 41444f19-1781-4220-cd13-08dce1a52c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?33M6DxegdKdWvINeiQTpxrtoUIJs+SaFGd5V4PrwR2nIQcrs25wlmOPHtY+/?=
 =?us-ascii?Q?prOPTxMYU/02BCGsShpCGgxp2QbrWgJs7ZSK1+uJxGmzmgVKVXg12EMuSjlR?=
 =?us-ascii?Q?zuEjjwzRA/H5DaTlnhslOO7bLko2AAEO/nhflHlw/NN/98aB/rA0T0L67WPj?=
 =?us-ascii?Q?ug2et78BrllD0NX0/bVWRaqouqpVnx0RsXb2wS6dtpyyi77wB+5qRFjRUY/l?=
 =?us-ascii?Q?U1LihzzZ0p0BMOXdOpCkd7uTrdMALvpnqhueEOVtOJ2E8rtjxZGTBMBxvqld?=
 =?us-ascii?Q?R1ruv2mMf17DYuHospRXdmva06cP/W/4p+UAQR9ey5CkEC1y+5mcX15pWpqN?=
 =?us-ascii?Q?SxtuKi1jSGKSfegRfriwW1aMvibkaEccAfmpxDVrBb8/8raVsrv+qmSLurfd?=
 =?us-ascii?Q?k/aOPXQLIvIM4cGYgGyc8RoEaCVr+GUbK+9tGIxQYtXZpKIkeKawdipXgBAM?=
 =?us-ascii?Q?A5XosBPRxVD8hlZ6TdVxsMS5jLYbGik946vum6YlUgyXJr407LWS5d+24Idk?=
 =?us-ascii?Q?17RUNreaV2DMSDcOeP/DUXfDoLOJF39nmA6YyqkatLVtyQqPRMLzpU68VaKx?=
 =?us-ascii?Q?LjAHLr+KH/GFE/thXQb4fGM/pP+o2789E/BUvCuC6qW8OSkEINPz4jM++G3s?=
 =?us-ascii?Q?ZXtXAVHly4G+JjOHKmdg01wws/P3Xkaac06dTEKR/k4HkjtgSpgO4rPT6+AF?=
 =?us-ascii?Q?JMRtV24npRsrAW+O61hDefvt/uPyjAY25NPW4u/zCik3CdvZ5uvRWYtlwO/E?=
 =?us-ascii?Q?Uq1cVc0jDYu9EQ2Bs17yTkVs2DCMKw8jIHY7R+y6ggolqvY8budJXhSDAgia?=
 =?us-ascii?Q?u2j3X/VyCCqJyvpUcUbkhwzceI5JxMUl28nmSczsQxnvhWfru3K2Rqs3w+Cp?=
 =?us-ascii?Q?urkz5e8gBA9HNPxEzu7ewxixQ/0WpD4h11cL6ovfC9Gn95coJvNMnkpl+uPZ?=
 =?us-ascii?Q?9QGOMS6s+Ts8VGjGZG+mpPrmu5e9EV+xGotFfdeg063tAVy0PNrc2w3mBpco?=
 =?us-ascii?Q?s8NrSo5xdc1/cBc9UR3I+eT/4EpuJzkjZdWCN3hGIERLEJdECuOxf1vCV59F?=
 =?us-ascii?Q?HjxdUeFvLD0qO0LOB3d/VNICeSyse4gA5L0tqwuI8VfuC4pl6QZnmKk9jjLI?=
 =?us-ascii?Q?3R1rroHckwV1dowjPNsF4OY+QhpQ9aiWzoiQhn4GlRQtnzlX27I/NMLC/f1R?=
 =?us-ascii?Q?k7vMQ+HQqGyM6Q1dEowMMFQtobj2CVVSif9Suhvz6LQcgZ2bGVlQFbHYQHP2?=
 =?us-ascii?Q?+nZ03unR/EHVxM6PngASViHgbYXSc/c6if2zyHGUvVMspp8wjLIx50aa36aA?=
 =?us-ascii?Q?wSykgHhbpVwnpxP200glja7upHSy8QPJEo2O7+nUavm2mwzAJNA/cobVQdFn?=
 =?us-ascii?Q?5LjEvocM06tyoD2TT+U721R7sG5N7p6Tyaa2Pq/jDzCr2w9OFpLNafYmUEqL?=
 =?us-ascii?Q?jYRyguxnxH2KQPHBCF1ue2XejX/GwIZjZ9+1gFEhqsuCCztiUjqjIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 23:11:10.8832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41444f19-1781-4220-cd13-08dce1a52c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP[1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP) [1].

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

This patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:
=========
v4->v5:
  * Move __read_mostly attribute to place where sev_cfg is declared (Tom)

v3->v4:
  * Remove an irrelevant header (Boris)
  * Rebase on latest tip/master
  * Link: https://lore.kernel.org/all/20240922033626.29038-1-papaluri@amd.com/

Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  3 ++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 29 ++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 39 ++++++++++++++++
 5 files changed, 72 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: d1b8f40d000887720e0c123c382d75e7fbb75cb6
-- 
2.34.1



Return-Path: <linux-kernel+bounces-271845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8329453DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8090D1C21B30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553EF14AD3E;
	Thu,  1 Aug 2024 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R0WgSkRV"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BE145B28;
	Thu,  1 Aug 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545812; cv=fail; b=q6COTrarljzplz+0cwHtDL2bkDxz7t9bqqFNrbPcHYE5suQD+qNa+inXu0M8mnMLY65dIHNjY9uMqFVtHYsS+Ju5CYMJS8IiFAtBnMDgpVI4fRYV/Zd1OX1KorExrNMijxJ+Yc51AUsly023LVEY3U3UId8rZ4c0+WXjJR3WrTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545812; c=relaxed/simple;
	bh=uXNNsqidmP5TV2vGr6JE5YwK9+G+l6qmdd2SZknjWS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pQq2/BXI2/cdiJwuMPzNCRkYFipwAFtPG+yeyghlhpdxipCKVcNHS+aXMcDKZuJeCDW3hYSOb1OfGI8BbDVhINmEqTWiyzF+2GwM4Hm/+A3JpUKzzNMbxCu8MRevLKczpx8TVavCz7CtxCMFKxA2uDAOlPdr6PJYnJ5N5yMd318=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R0WgSkRV; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU10+RFAQfesFk9BReL9Fp6+T+Dz3klFRiNy8xnkhBoEMS10SiDJihsrkS5rzb9l5Ivbqok1saYABxnrcwKA8/ZRm7ilYWZO7+EfGPG+d3UlCKJN65PLJAdYr/xrX2aTT4K5kIuhF0YoDP4nVDCzCglp4h1xm9JU2/W1hXwaUVpTmoXiCCvJj0sdryMyK+rWezdFu1UHf4hjsXlec76PE+wfY0if3sThE1TaQf/xWHzzTDBya4NT37lYMEJpTiSifwdWEZob0XFHrKCyX4VntlzAA8uaF8tmdSvCQiP5WF53alFYRD2ZhWPzruLW7Trw/gVrJcPrUjL1wGBqonkm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4tCavGrzvQqSKrT/oueHBHRFA8Cs00m0SZQDZKLyls=;
 b=q4azoIm0kZpW3I+yHNsjEaatAHuAfkEmCECIkhGboQcxObA1QGP1GZyi9rH4CGFf2HreWDSij51RS66IjK8/vRwH9eHR4nw1rHztmwz9XHIYy3nlKPdI4QHZ/NhZJO22N/J5fBYKf4Nt3Uz/fe6LWikLdfODzod0AoBYL2ofFiw6pqBY1aLa6O6QK9hfdRasAUTGDDAYpdPq9rUkIuVx3OgEMsqn/HzSsrW1F8vUd2mspn6KnT0/4RJJfYxqQiLyx5GPRbDRtUCaJt1zxOBWtqOeC/Zy/af74E9DTZvnt7QJh7cUE6p6/aK2wq7QFN2eXzB79Ibzw4kDQ7w4Hp1m+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4tCavGrzvQqSKrT/oueHBHRFA8Cs00m0SZQDZKLyls=;
 b=R0WgSkRVlaju6Qxh7ZQUajr0iqocXg2Ud8fij3DKdi6glKsRnu7PNtxQqHvgQt7Nr0pvcRQF+qSknrc8YwsEyyNgfnTVwr/MX63oK/9MI8cO3wabnxyX0wGLxB9v+aJ9Oo51TVB0Y2BD6SzsknLHVQDIJe8ZEfS4CSBHZGtClDQ=
Received: from SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::25)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 20:56:47 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::8d) by SN7P220CA0020.outlook.office365.com
 (2603:10b6:806:123::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 20:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 20:56:47 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 15:56:46 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric Van Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Michael Roth
	<michael.roth@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan Kumar
 Paluri" <papaluri@amd.com>
Subject: [PATCH 0/2] "nosnp" sev command line support
Date: Thu, 1 Aug 2024 15:56:36 -0500
Message-ID: <20240801205638.6603-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 290080bb-c5dd-4b03-486f-08dcb26c7529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y7KAhwLK2ShCIyF1n9Q1D/1TEqzQXVibaDywsZQ07woemFI75/OIDZLtiA64?=
 =?us-ascii?Q?XQfoxdgyB/FnMpAtVmmvtF279btamfi+dDpQovEm/6LEKnM7bcJGzJJHglak?=
 =?us-ascii?Q?4QCBiDi8dUihZqRuhOjyx7wCysoQ1x2S0+ldzTtX4kIZq1syOPExmvVD4wmy?=
 =?us-ascii?Q?fE0xoEuSUwk2Dy1ii9WK9x+oPI7MP/7pBRbZMRC+Si3jb9Ac5pxfqHmDMUbR?=
 =?us-ascii?Q?ZDHOPrS3FBZoFFUs6tlQCPdy3EMWNtzZyjKVrDI+1+9i2NQrYvNRGb11BNXM?=
 =?us-ascii?Q?4z3oXMjScQtVKoK4QFwNBeyc0UCzIXCZNiFcoTtYp68SOS5lj/QEQFNMbxZq?=
 =?us-ascii?Q?S106nlgTsfyJlCvVbje8uqICilPgy+S6gCHySnwolQ0jkWa54t76xq4sAxBT?=
 =?us-ascii?Q?vslVX8tRnu9ci6YxOtef2w8VjC9YTVCn953ZCei262dhJFMnHrKKMw9GA9gY?=
 =?us-ascii?Q?PkticlBy95jpdfxp7yhg+uEufpiM+nPnhvUXWh0ZLja3CmmEf/GX3/KI6HJH?=
 =?us-ascii?Q?fIiUsogma/jfvEYnYF8roUvH+vrT6OF/Dpg+ANCntCyhcoH1XyqMcVrHyaMa?=
 =?us-ascii?Q?jORmcK0PH96eo4xhbzYMN9qAburOgp+mor6Vi0PbLNcb5vLy84fOcMQBd1Xc?=
 =?us-ascii?Q?M7Pzt+0O/Pj4AZ4NGGszspemeIacrMOmhWCyJAUS6ENG7G2FHoP4leip8/5B?=
 =?us-ascii?Q?5JzFbnz4bTZMzdawZLB4YZAz/dv3KZ4LFWdIYyuIMogN6mnTBhvIHu2VWeUU?=
 =?us-ascii?Q?9VASB7Fns+RnxZzy21Y5gN1bPQ2J129nTlKUAZpwCDYzAUSnSj181zYXZAAg?=
 =?us-ascii?Q?/KLT9dCw1ziBjjsfIVZGeKXnwv3c8MrnlqJxqAHvHxvUZYN4uDvRqZLFdrhb?=
 =?us-ascii?Q?4hnLxGbyFel6bI+1Tna1RFeW7PHjbb7ZQedWqRPjXQKPoJfhFOgXf5V7rVd7?=
 =?us-ascii?Q?kiky6NnqoSa1aWTECgZc/EcNbWjEF1NwLUaXCF6WM/f7UyIqgdYHTXRCcjkv?=
 =?us-ascii?Q?ZC6W+igDTOyUhiWkHhax9vpQ4XQfIz4v/+++yd9YWTlqWjSTVDxPvag5ariM?=
 =?us-ascii?Q?a7n12CzSXVK0mzqf5uy+THCzV9O36s/sSfKy/SNasSIT7yS10dyb3SXLcyc9?=
 =?us-ascii?Q?r84w+Bgewu7TK5meCMXind/ZPs6E0DXBVD2CJoIOXsyk7sQ5q15UIfu0eC5S?=
 =?us-ascii?Q?tvdzAkPFnDZ0RI3LHWfEkd05vc03yJ6W4C8ZhuY7q1U/FyoOhu8r/n6d4PkQ?=
 =?us-ascii?Q?Kew60KHfWBHmwfTzKX2EEJ+TouWxOBvi9Odn8LkgYbXo8T6ur1dy+RLWCVju?=
 =?us-ascii?Q?pSIbVEI1x7VtoQhBIiSRrBrYMICsVgCrEXmU2RFAvrdSVIMeWpyA4Uey7tOO?=
 =?us-ascii?Q?4UwZvYphiRtnGxpM/zyJs8lKYIkUEGXRE/wjnqoJeQS/BkdO6MCh0qNn+gE2?=
 =?us-ascii?Q?chWnY2QrWyhjPyg5oCUh+wTlZ5QQp75w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 20:56:47.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290080bb-c5dd-4b03-486f-08dcb26c7529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SNP-capable host kernel from enabling SEV-SNP and initializing
RMP table.

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

This patchset is based on tip/master.

Any feedback is much appreciated.

	Pavan
---
Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  3 ++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 27 ++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 38 ++++++++++++++++
 5 files changed, 69 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: 6d9b02543ea85fcef2595e0a7a63a336ea2ac5e1
-- 
2.34.1



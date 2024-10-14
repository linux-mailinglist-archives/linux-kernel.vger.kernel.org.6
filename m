Return-Path: <linux-kernel+bounces-364103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F075099CB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D76B24F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF11AB6DA;
	Mon, 14 Oct 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fE/TSWGr"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17741AA7B9;
	Mon, 14 Oct 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911404; cv=fail; b=UNTs9NdQfgkPlVPhLaTy+RTPX968YEYokGWhn0UljVtAmbkSNvpZtHPCHMgU/E7VvUl7tlsPj99mQkULu0QHiadbonWkSHi1kKAPnVg1KtaLF3xk4SlXv0UOGxyZpFK5+DUYKGi6BeMj1ryiSVEtkjOf6V+yygyMMhTJinoaB08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911404; c=relaxed/simple;
	bh=+A3I/GiMnQFmkotl7fZFE8H6h77jHgvrz/BYutv6HUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dN9hxqPluNWCKHmTTs59HT65KXAh9eTS+Tj3g3wdOSvKMADLLpVkD/+GMgm4o/fasvXDV0nmw9e9Jvu7Pfku8M4zZuXjGru53mSq8qVoo5kUxSvbz3ktW21ZioY9on/nlrYCLU+rpAIARgShyW37Fe804Gou44aJ3V9RnABG1S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fE/TSWGr; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW2oxZku7+ogbfbRfSmhg1EYqGdW4rISvDCbUMQJAfFtFip1kyC3WgsrWOg54/RqFTVWlfiylhRL1AWlaix5v6XT2/VYlsoTIvIfIexmc6PbeEIybxaFtL7rtJMEYaKcYcBCc4xz17ULvdGb89k0tFGgKQAuOb8iuttoXFoR+TB5EsgR8B+8LrOOLaDcAjvwbFe6WLpHAbYDZroRXgcmIrGduqpuQQDpu8lkUPJ3OKZQ0FBMH9TRT78JluQ4E06EpiCm/3iTJFLjbn0cEv7nhWls6WgcTVT7oLuj4xM2KDz5vGRqZ7Xcx3PoOXqq6MA3r0px3FFUcpaJBtCdTGnEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBanNiKu5mLJ58fMwmuGkEEsdpU7+uUrSYdgFN6qjDg=;
 b=fFSf7C8gXtfyZ/BD1MMGjZOyXne0nYIn+bd/G1xkVrjIO42QZJwAqm3gafCeBCHMvKlYkC2ty7UxqaGIR9koKDfyoFtN0/79EXDNnnKm6+4FJS6/qcbmhnMfomydhDeLbYAgrJtm/oUamoCzX+jEQIbtnHoeOoH+1b2922Vo2XQlnXy0mvprxOdQR2D4huvzRbNEsLoRA+JqRiMr0C5PcgvRAT3Mpr9EWETlRjhWltOj5Izr5+cD1WqXjkM65xrK8XZgj2oLkmjkwYxIUVe7re4/dTi2uuIcJDclltZi8CEB2xjGLVuJNT1t1mkdyAgTJShvERL9vtMYtqRsfM4JTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBanNiKu5mLJ58fMwmuGkEEsdpU7+uUrSYdgFN6qjDg=;
 b=fE/TSWGrILvCWFmBTCNmIfnXnf5DIms3x58LjdwgJ1Y0Yl8j0t4pqU2x6CbiWgp7tgXjowX38UYFj7Xj1Xyf5lLd24oyriPPWWh24GO5RRzMLhLH0NvoGkhYKQGq+f7ivfSOk2A76ZUXj4b0HYSToeTLq5L+nfI7x6LcpMPVPdw=
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 14 Oct
 2024 13:09:57 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::42) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 13:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 13:09:56 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 08:09:55 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-coco@lists.linux.dev>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Eric Van
 Tassell" <Eric.VanTassell@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, "H
 . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "Pavan
 Kumar Paluri" <papaluri@amd.com>, Dhaval Giani <dhaval.giani@amd.com>
Subject: [PATCH v7 0/2] nosnp sev command line support
Date: Mon, 14 Oct 2024 08:09:46 -0500
Message-ID: <20241014130948.1476946-1-papaluri@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 553dea2b-0673-468e-79ed-08dcec518060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cM6Xr9uNVzZREHbahf/H08fP1Lmwi3DjQVkuLitpuAzpinQbL4GeHBEJh9Rf?=
 =?us-ascii?Q?IExllhxV5Vilw8FIsN1IT/bVf4YWtLab8K+iKPeR4ZKuyThCg/AUe7P+4ewR?=
 =?us-ascii?Q?D7sdOJlFpNjkGoDBRD2lcRVz8N5K43cv3S6NKS9kXUdKIeXr5EYfBVZAfXMi?=
 =?us-ascii?Q?Y0PEhBmMB3hg/d1b9A/ha4VCGG6XUtFOx20EEU7fVYIyAIj52CIWwHF3QYbl?=
 =?us-ascii?Q?YbJJA1C5e5/+QfB/UZciOlDNWWQX7mXX9DUStb/oi4Def/R/j8aiy7MwgYHQ?=
 =?us-ascii?Q?LmlRikSz1HuwsPMUxNZS4V0Spge/CgbzyVM2Xs+yf2RrGIqc4LA6KslEkQUM?=
 =?us-ascii?Q?8qrWIJhBqsoOhd1D1v5Gg3Gg/GT23fXzBnyB3a5eyx+FVviqbVVf61kGdRt+?=
 =?us-ascii?Q?zi1y5NRArqaGZitqIR37e3SRRUWwGvwuMw5jfssOwZjWRKmtK9z5L4z1XdEn?=
 =?us-ascii?Q?LWHHQHLCnbB5Ttyo5paltyvbF6m1QTerUbNdHr3vLJe6uvClm96jafEGeEQV?=
 =?us-ascii?Q?vHF6Zu0P0LO3ttOIqTbwutyw2VK5zdd67WUfttfNoCD5hel9a/v4LRLSH7EB?=
 =?us-ascii?Q?Ea6+CHlaXfryejmyfeAVrg208mjvveYeZriQK9SGlzoMPTgBGK5HI+r4xMdD?=
 =?us-ascii?Q?geV1eWKUnuSnlK7B6OeHsypYeOTyTtYCr4tx62VTCEgl5SmbgblHTXwHIF4e?=
 =?us-ascii?Q?TLYBVISNXURi4+3N/a3kbNqBvQct+QYTt3WF6FYqkgVnbFiL4RybBwawWqOb?=
 =?us-ascii?Q?AYpFL3h6pIufZecdjMaUIol0Hd3YGM39bKKZ4NlJ9CWURPE+YGt8h1nNQ22l?=
 =?us-ascii?Q?gyfgaxMS2wQF82Kyoi52oCZqN1waglLTRucvxmrtenLhZoKiMiYTH9vSJ80/?=
 =?us-ascii?Q?nT7nAIIrw6w0gmfOqzCR5HBKuvwdeUTu0Hagp3iwKmPtb6EiaoyVpP1aHHOE?=
 =?us-ascii?Q?Rew11ydLXviPneqqsaKL86zxUIegw5NUgaLDVW8WljQS74rgLGHN7pNQSfoF?=
 =?us-ascii?Q?OdAIrFKVrRcpC9EoAUmadKoxVT3JVx30DdVvqBhKSNLM1rlhs6FtT6r+Nkf4?=
 =?us-ascii?Q?6XGfsCGjf4rU8Vka1AQpQIT2PqhGSbXi+Mvu/LYK8lrF2YRfS7DBH+7WtcoK?=
 =?us-ascii?Q?+UzxBvOHznMteJoyrbfti6+eAe8pjN+oHNtHvH782/D37SR97TYNEMGvBCEI?=
 =?us-ascii?Q?sCwMwX+wgq+tSUR8Hal+X+SRmDSz1CC/wV+cXyia5w/JTqky1Kk/kfGffxoZ?=
 =?us-ascii?Q?xc3v/vmbfproYQL2Jes2V3BEQ/JBzX2FCU8lfaUCvfLI0aVegFoiflzCzEYw?=
 =?us-ascii?Q?ychjhev5R/G5Aizjsh1nHW7rVdZBjZpwMar/uYPlhTYuq+L2Jw6snObbzCLI?=
 =?us-ascii?Q?gG9Zngytk9IUodtj0X7w7EIKV8ko?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 13:09:56.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553dea2b-0673-468e-79ed-08dcec518060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP [1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP)

Setting 'nosnp' avoids the RMP check overhead in memory accesses when
users do not want to run SEV-SNP guests.

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

The patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:
=========
v6:
  * <linux/cache.h> was not included in virt/svm/cmdline.c, which was 
    breaking the progressive build. Fix this issue (Boris)
  * Link: https://lore.kernel.org/all/20241010121455.15795-1-papaluri@amd.com/
 
v5:
  * Update cover-letter and Documentation to include information on why
    nosnp command line option is required (Dave Hansen)
  * Remove <asm/cache.h> stray header introduced in the previous
    versions because of __read_mostly attribute that is now moved into
    virt/svm/cmdline.c
  * Link: https://lore.kernel.org/all/20240930231102.123403-1-papaluri@amd.com/

v4:
  * Move __read_mostly attribute to place where sev_cfg is declared (Tom)
  * Link: https://lore.kernel.org/all/20240922033626.29038-1-papaluri@amd.com/


Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  5 +++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 27 ++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 40 +++++++++++++++++
 5 files changed, 73 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: 00d91979d23c88d3f50870e22fc9cec3f5e26a2a
-- 
2.34.1



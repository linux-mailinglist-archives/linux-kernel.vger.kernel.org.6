Return-Path: <linux-kernel+bounces-550253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38136A55D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7471F18943E5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046614EC62;
	Fri,  7 Mar 2025 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yB5r9No/"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C76BB5B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311460; cv=fail; b=tHFl6aqz3EYP+lUpo27rXzeCsqkm4eUVtKlVMT1qJoniDYBmo8YHO+wZjjMWXLltjhT9za+sMnkS4FzzztVRicaj9C3vZ9DD7nO0Wy2zrGhq2iDKrA+yKkf84kpOOeFT8VU0TzaXl+39QMfV5OP71bRScq8IYRYnXFFdhI3RHAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311460; c=relaxed/simple;
	bh=2QeT1vjQgY6/6wnq96yhq03ZUC7zdiCnMiT0vHeRwfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xd21lCFPx0p0EcWw8PbLSBRVLA99Tk/vbSCbzuCHQxcHIh/lJ+ru/tLjgDBdXnkmcNehXbQWs0A9dDDqgJFKCnzh/oMhOLZ5ZfZD2jFS3oIDiPqAdweLCml8De5mDuBVoUNu2S4J2RGr1d4TCqgIYP188UBQVLLBz2zPEnwsFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yB5r9No/; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxW2YO5Qz9+00yeOE7tW0TikFIEZaTb0pjDWQEsoOd+1veJ7WQjZgBg8BX1i0vcvINEUD6l9usdVKNdGPTCphBiF3m9Py3It+sO9XSdsDX6tfMETvi1a9gIhkYXVGpkhBSH9hkoWFzWX3bFoiDI9CCpCD6ORHSZFqoL1uULA9sv+FpMBM5eHjSzDZZoyuMM3vA5Oh9htqt8C21OnFJntg7oJ8IeWgQDp8wmitpk/m3BDw4Ojw6WMjSgyf+8YDFtH5lBS39JA/yasxiUIEk/O4czU+ndLw8L0YNwyHKi/nifVRGvPxjLSyN4twPoLigNCoyKotm6nMo+u86g8ZHsT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNV+q9wJCK1OCo5VCm+z/orQIJMnWAXrpYHGe2YgTGQ=;
 b=WczLXSY3V53zbVckmaAHwqJtmLSFULaclawPf6hKOMV549VOwHDxNwa278HTj3cZJlfF8/QHEco1IwfkvVSBBHyCEaYWG8zpFBhejTRmLIJrJLxsWoOEaaX5m6hPxtLaE5dTjTMKNxzmSUHtnqn67t2aKeMenhaySCNrzFRnmdJ1sKVtwQnm1AehObCH5v/HelPSXH+fV0pJIPdniiPbXIOe6q7Sqcym44vtgo83s7U/D00fl5RGG3JWyFNe0MZ7jtWTCkAHemx5zi68xX0Z1/F1nvLkKdzOjud4auxG6a2Oy5xEWUKLhVu9Ew5TtP1UYDrANbxV0J4qgn4XDvJWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNV+q9wJCK1OCo5VCm+z/orQIJMnWAXrpYHGe2YgTGQ=;
 b=yB5r9No/meF+O6mS4bR43gui5EPjZYI5mCuj8tLkjQVlTGvDnNIB5VBdvJDETqacGGSQa5Fp3SaTKl3Q+8sfdoBfmb/TgUCz/2QNLWUJD5Q4hyn3m2Upbojq/v5jrtAlqjb9yCB+pM1XOLgpMg+tnL0xWGUbABDM1rzjwxZRRm0=
Received: from MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12)
 by CH1PPFC596BECF8.namprd12.prod.outlook.com (2603:10b6:61f:fc00::621) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 01:37:33 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::d6) by MW4PR03CA0007.outlook.office365.com
 (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Fri,
 7 Mar 2025 01:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 01:37:33 +0000
Received: from aiemdee.l.aik.id.au (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 19:37:25 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Ard Biesheuvel
	<ardb@kernel.org>, Pavan Kumar Paluri <papaluri@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth
	<michael.roth@amd.com>, Kevin Loughlin <kevinloughlin@google.com>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>, Liam Merwick
	<liam.merwick@oracle.com>, "Alexey Kardashevskiy" <aik@amd.com>
Subject: [PATCH 0/2] x86/sev: Rework SNP Guest Request to fix race
Date: Fri, 7 Mar 2025 12:36:58 +1100
Message-ID: <20250307013700.437505-1-aik@amd.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH1PPFC596BECF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d182531-f476-461a-3772-08dd5d18a1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1OlXuc//86VOfuv0gBdE0cGNGKYmTsYTnfJTpj69lRgH244Kq5qlztMCfdh?=
 =?us-ascii?Q?BWVNMp0MzLqaBIF5tn0CeQXtUtG9CsOZKHhI75ssm3oeu+B6WK2lgEmt+/lq?=
 =?us-ascii?Q?WcS9pLzmdPUouC710EF0E5/7N/hbDpzfaHSFRz47sGuKwd2mW+FwrdohN4Y9?=
 =?us-ascii?Q?611VVlFm/ZRPfmRNrB5awKbI2EPZ9bZj6HncCDhBzOSg3HDZ9PPcUUgb7syd?=
 =?us-ascii?Q?/5EGwe87cZoGDY4ng2AT2rjF/5K3gsrurWlyITAaXO6mrCTkh5zx0cTKt4En?=
 =?us-ascii?Q?TfXftPtiQ5pRy4dstnX5rJYRCbIBEtxauETXLti+bzDubnl/ol1IntInKebV?=
 =?us-ascii?Q?GlMK4BnZRXcLAYG2T6ptl2mY4AJLl2oCHbJLRsX9G6QDbp9j5KpdguJ4Rxdj?=
 =?us-ascii?Q?M7EnJ/MYZwFij4Og64bzUxsulGiBaiahiP+YLyG5h53Q6Q1GR3XWt8tPQIxo?=
 =?us-ascii?Q?Ni9JeKYqYcBmU7L4vgPwdLMayg8BE7EBzm6HSxQ3+JXbUXs08S0TxbFKlI7l?=
 =?us-ascii?Q?zp9/JSyXBskTOY9pzTSJvnqYHxcQGB5unYzWU6SlBFXWy5NIoPCqkq2wdaCx?=
 =?us-ascii?Q?+wUq32wcrCGn1Eeaw1BXH7eANCcsGGSYbcq4j9KpxUi96bRb/uuPMNFPaIk5?=
 =?us-ascii?Q?i0WhfyScXa05KB5yTDUS/qWXp5tj5o3mE+7gDPY18ggjxeeTRsBpqc9/ZQuM?=
 =?us-ascii?Q?y8mbFLsU6v49oM8qdRv7kXlXcj6rjerns8Jpq2HCScrdgEVo+s7fuTWGt790?=
 =?us-ascii?Q?TdSI0WO4d/VEX+Q971W6QWLVSpzvfPQAvsWSZJsKJ4z/T3qw/1faZ4eQRv3t?=
 =?us-ascii?Q?GtB7EnLE09pBU5y+CFGQDe079Q2s+GqYiVNyKRome6kBYU6SUZIxNjBOOgg7?=
 =?us-ascii?Q?1Ajua5uPcDc5N7SN4T/wnUL7ncfZdVQX/Cvwl6kvGEQTq1GfnFdoN+G56CKx?=
 =?us-ascii?Q?Lc7s+DPPbmL3MT2lDO5ndEQzjobXAglpWXBR4GqEQm6AIyDlY2oEr7v/KrH8?=
 =?us-ascii?Q?WRZtVzInTT4D7iVyOAB0cFifwVcvmwlG7PHtH71PlGGeNcVMAA9MbSrs8Bk0?=
 =?us-ascii?Q?vdRPURBO3WpvsUttpqZDv7P+LhfQhPQ6Ul/Ccaw6I+qqWiPPqkJF6quBEOMv?=
 =?us-ascii?Q?Cn9bfT1jLM6o8YwN54BAay9Avjfare98Ue2MYjtelmhnUIUy1Xw3xKNvlMEy?=
 =?us-ascii?Q?e14UJQMVw8moRvQ5eABq/UMvZmPRUBtrcfcFsBryPPqN4Qtxa9gwuX1bW1Pp?=
 =?us-ascii?Q?FJPWsr1SAT5rqQh+7A4i1NdReJYT8hIhD9h2Jx0pm0DMqO2YHulfW0udxVV1?=
 =?us-ascii?Q?u6svmUdAsZHZ2eueAZ6T1YFOTykFXRV8KUP9sF3gUxYZ1CbFlEXdDIsTZDux?=
 =?us-ascii?Q?H1tbKneTJhraDv3OivOPp7WoQsZqHbhTi0Z0L/lsGqYJHAHtD7iFtPBdKyT8?=
 =?us-ascii?Q?T0TGk/aQIArDqnqyAetPI/wd2cSdpB9q2EcqYxEl39T9N+VLyb0xPCMFrZUK?=
 =?us-ascii?Q?FfN4xys5z3y/Tm0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 01:37:33.0750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d182531-f476-461a-3772-08dd5d18a1d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC596BECF8

Guest Request is a mechanism for a SNP VM to talk to the PSP described
in the GHCB spec. GHCB allows one request in flight at the time and
there is a mutex for it: msnp_cmd_mutex. Unfortunaty series of events
led to use of shared data outside of this mutex area and recent commit
ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
mutex") broke it.

The shared data includes:

- request structures in snp_guest_dev which was not a problem when
they were introduced as they were put on stack but db10cb9b5746
("virt: sevguest: Fix passing a stack buffer as a scatterlist target")
moved them to snp_guest_dev so they became shared but there was
a mutex so it was ok (not anymore);

- data pages and the number of them in Extended Guest Request.

So here are 2 patches. Reverting ae596615d93d is not an easy option as
the code developed far enough (the mutex moved and secure TSC now
calls the PSP too) to make it rather large.


This is based on sha1
277255aa69e5 Ingo Molnar "Merge branch into tip/master: 'x86/sev'".

Please comment. Thanks.



Alexey Kardashevskiy (1):
  virt: sev-guest: Move SNP Guest Request data pages handling under
    snp_cmd_mutex

Nikunj A Dadhania (1):
  virt: sev-guest: Allocate request data dynamically

 arch/x86/include/asm/sev.h              |  6 +-
 arch/x86/coco/sev/core.c                | 23 +++-----
 drivers/virt/coco/sev-guest/sev-guest.c | 58 +++++++++++++++-----
 3 files changed, 54 insertions(+), 33 deletions(-)

-- 
2.47.1



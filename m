Return-Path: <linux-kernel+bounces-223625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6C9115B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430311F236BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E9149C65;
	Thu, 20 Jun 2024 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z3tI+EqH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF636126
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922240; cv=fail; b=gGXrMINeb/oeMbj5/h6Qjys4PrzJnLKB7Nz6HZFZGQwONYtye/JIVcXqjaAdhKLJf4zKJSZNRmk2FaG2KHYjhGpzACcL761gQgZlOprRkAPrG92tMc3IlnqWeGOx6VD6Ysw6Pk8Eiej/TsqthtiV1ys4MlVcTscGflUcI1EtK9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922240; c=relaxed/simple;
	bh=+BFbLbCLDMC5VnkwI+9iTf66BPCRqtgtgcLjwKOTE5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfmbNdELbbTLYsrgC4qi2TmNmy6B8JfULR0KNWugo1G/b0s12ezod9dqSWiNpgxciRoNhuswijP0LQFo3OuSTyB+wKwKGmZP6kdGHU+nM7Y+1aIo0toj8jVdeyPs/Q3+jcOugMMpPk4hXGvyYXqo79WQdBI6V3yW8HxFaZC1FPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z3tI+EqH; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BumU5Hp37pijfKyFOJCvW0deAYcD91K/eS1rNdfzM6MlBXDYbpWfI+00ZfZC65GUKU78ROYLGLWjoTrVjxGRDMC5ibSfmPusnmsXOOftpUxYr9g/id8lwK2ypl6eToDC5DHj1UIrdN26Doyi7K4lF7zlamScHCg5GU4U0QzFJD9xgveRbC4zBIN1uxGjhLkd6AUyCjUZNB0/r+wZIym1mpxeK9MJocgSbZfkE0HMNg+pXZZrUKw507WLu24yotWe8t3+FdCwKMeU8cYl5mlqQgbg0/13kugeFlNADd4apMksvQE1mifORjJkiQ+pRQaPuF9d215arbfh/R2/b3BgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+OqCByTIXSGPjSRs+PSmPW6wyr2CG2fnV0DiwQ0tww=;
 b=h0gtricxVT4rEmqEe4+63CFCDvb+O0GNF5NSds5lUVIQnzyMMcLAwdx9zalFX2bR/qrpkTslM15gRw489t86FM8p1zzTTf4fOmtsB7oWvAGsMg0AOhfy4OgoI+ew4dGbhVwk6wGaA9q6yS83WgUDl31p4NPhkmN0pMXYzkJQWAzN76nl5l/9pnR7X3JtwqNeOUT6S+954EKW+kHx5phDUAedW9nF4VzSWw6qg+3rTVWHcJGRy6bJZIXfUHvaeZvxxyE6VOOzC8X3Lsn8l0V4v/hPufzMTz+lx/AtDe9BeFI/66xF13qsDqd9nk1CludF0Ff3IdzKkwVJAmy35/4mpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+OqCByTIXSGPjSRs+PSmPW6wyr2CG2fnV0DiwQ0tww=;
 b=z3tI+EqHkHUkBF9r5RUw6zhZgXcYQGbh29B9nF8WbaC1alIcH91n9MGnyEGN3plCSADOOp5YGbYLLekf9XU7EqmRvxZ+Qc6vTS+m9IUxUkIxKaYNL1717Aoax5s/hQNtl8LoDZTEs0l2a6HaoHAiVMNyjcDkXeLlVqLhcRBaG6Y=
Received: from CH2PR14CA0043.namprd14.prod.outlook.com (2603:10b6:610:56::23)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 22:23:54 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::8d) by CH2PR14CA0043.outlook.office365.com
 (2603:10b6:610:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 22:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 22:23:54 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 17:23:53 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/3] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Thu, 20 Jun 2024 22:23:44 +0000
Message-ID: <42f56d2405522cc207b59235506c0b5bec67123f.1718920799.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718920799.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1718920799.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c788689-da41-4d70-a1b7-08dc9177ab7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ew9tk9SerMi38D/uXUA7C2fbXV2TH5TaGjtp3TPNn2RjkrFvgToPtuX9NT3L?=
 =?us-ascii?Q?HB3HTrXD64PXZVlOQmR+R2415PMbpaDiFqh/YNhRAHOhgIhnaydj3CZCB4G7?=
 =?us-ascii?Q?OGCGiRRq5Vl0gOgwChABOKwh3FZD+G1JvaznOwJtP9JDUei7GbIjf2H5/ZTQ?=
 =?us-ascii?Q?FYZBWuEfGLnSTiv4Qxt9eZHTi4HhU/WKHhx0czk0QH0DRSzfcR/OeK+8S/Ue?=
 =?us-ascii?Q?lQP+Ay/eQ8ySaP/mWcUVEcvHbUjy8t1gDjJF2Ha3oaF3KqBKVbERC/4MC1jB?=
 =?us-ascii?Q?cktRo1M/0cI48hXs1vDNjGiXeNbHHIU+Oxw9qQmkL+SwEr7FC2XnqcAMiRev?=
 =?us-ascii?Q?i23mYz2bCd3m+ixScRkwkaM2SGTF9RzMO5yQn6vwFJzuRQcZp3+2jSbJo5uH?=
 =?us-ascii?Q?0VZ8woMl3rkE6vrBKSn6wH568aFbFHLDchotQMvtCYQUKSWIvEpHYXWH5Wpb?=
 =?us-ascii?Q?6ABDwbPm98e8ud5B6RXtl5NGUA2FkckAVrvHKC5Mox8a8aRykncdBB2SNP68?=
 =?us-ascii?Q?5tA7eG/ClBRczhgJA4Ibyei9WtKIPnW5Jk1w1fhFLV61Og/tj7JpHyz15Srv?=
 =?us-ascii?Q?fmOux2Wig1D7BGxfxSzrFu5aXSA9d27ZcFtSUa5MON4n/uxwBhOZPnLcIPJz?=
 =?us-ascii?Q?6t6ffXT362kUHQ15SVC62yXr9NPRAokKOPV2xzTAU+1t8vYRNRaLpcSEsFC/?=
 =?us-ascii?Q?N/c0gRZbzqKb7fh7IL186YWW4Uf2fHOW55QxaVhSrmP4A9g973+h64QUWSVk?=
 =?us-ascii?Q?YdF+y3srLei8Dkh6mifq4hnf7va8PkFFg07MmdP2AfJvzYuIOk+G4m8GBsO8?=
 =?us-ascii?Q?b32Y8Msv7JSCuJ7GfHG2BavhypvqPNpZN8glCZ0uq79KnHp06Em0GbkzlTWX?=
 =?us-ascii?Q?u/+25pkTd3RzwnK/L+oKK6zwULB+bPdY3RheIkGgtXTnFwOk4YazNBqKX4Qk?=
 =?us-ascii?Q?p/xfUOgmL9rEE0Foy6W1nLmzhEgJ4dApBviATU/TKRzGNBtlFct+n2tjW96k?=
 =?us-ascii?Q?MdoQncgYZA79ZyN606J2WTQ4bsg3lu+4tAmTyLSY2PX4mlnYzOU2jyFBBBHB?=
 =?us-ascii?Q?bh0gS5Na4VhPLJ/4hqviWRaIiR0EZO1UdI+bU7JxzILUGD5BT8egXQTVymGp?=
 =?us-ascii?Q?IY3kg2Aj6WcvgYmCbrMg4YGzgfC6AcJQhESH+dZxDry7BSUmhLCVn8WwjRPM?=
 =?us-ascii?Q?zC1+59EyfnzvxgxPcWyKnaUsoumyzT2oKPl/R4mKKuoaZRPRV8zOlZAxmm6k?=
 =?us-ascii?Q?IZ1az0Z+ostY60IAT0VpoOEr8gYfQ/oPVZWTxniMrdBVL7EGdWiAhPn3aHQf?=
 =?us-ascii?Q?IOcOIulV36Dedymklnagn9sxNfz+SvBYHemgONN8qx1vd3nNOJu54R852woS?=
 =?us-ascii?Q?Wr/m9ixqdr7jXqeymdtOqAxLgfIwRfUneOXY7xo8zICtpLRr/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:23:54.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c788689-da41-4d70-a1b7-08dc9177ab7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM in the decompressor causes guest
termination as the boot stage2 #VC handler for SEV-ES/SNP systems does
not support MMIO handling.

This issue is observed during a SEV-ES/SNP guest kexec as kexec -c adds
screen_info to the boot parameters passed to the second kernel, which
causes console output to be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is preferable to
get the console output only on serial, hence, skip accessing the video
RAM during decompressor stage to prevent guest termination.

Serial console output during decompressor stage works as boot stage2 #VC
handler already supports handling port I/O.

  [ bp: Massage. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 944454306ef4..826b4d5cb1f0 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,19 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing video memory causes guest termination because
+	 * the boot stage2 #VC handler of SEV-ES/SNP guests does not
+	 * support MMIO handling and kexec -c adds screen_info to the
+	 * boot parameters passed to the kexec kernel, which causes
+	 * console output to be dumped to both video and serial.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +453,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.34.1



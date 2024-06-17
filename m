Return-Path: <linux-kernel+bounces-218330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A148590BCB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561931F24812
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5681991D2;
	Mon, 17 Jun 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gj9Jr+M"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236814F128
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658929; cv=fail; b=OX9W0Hn8QX3wlzk1v08Rj1P41OdCVZdXSbH0DFEnI7vFLQgrcWFu62sFwSNZXnDcAeUtgtAYMQx5HYYTQK5jnXSYI58owsXWLdxzfBmEatqMg7Vky/ACfrv8znXtLdIQD7ynoUEqYLQJa/BoEnKtky4VxBm3Pu/ctW+8DXmmk5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658929; c=relaxed/simple;
	bh=RGHLWsdL/pI1aMSbj8eqtNdjm7Z2+JiPYzS8rFJwQIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDuA5uJm6AR95G/nZTG2fVEWbaBV3zWKCokhP1nrV/ZXxCUEc5Q6mlOTRb4gzr0JQG+egiqtNMy2OG7Cv/yImZ+N96Sbcc0mPYrapv6mp6axgxbnOdQ1cXwzEVHchW/FDqES38QlnbhFzdW2Y4+CNCr/Nl3dP63YzX2myuDJUPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gj9Jr+M; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLT6STICI+rnt3DaRuMdCr7fcD5AT4RzltVsnY1YSh7nY6t4tUoRaQi9DeD0lTbMMRFt5k28OSIXoZ97P6AGI/GijaKg4mn8p+mx8sgFG7PDeWpvnhzFwdZjN/NIiVITPj8KtBzNcj3VoXdioBeYCYbqkBbeQXaej9LZT11I8mo/ATGQugdFEAmkBEZ6xBsIRsG3FiVbuipxDWWfiplEg2m/h0uQwhrcj9Ke3Rdq3QV480Vga8K8DzVt8e3gxabZExnDDqJ4yTk3gl4pVq+Gw5qgEHB04RM1+ogx2j4ej7bAgWnwCyxasIthaiF1ZV82TlxCAozQe8rfB4g3PrfnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TOD5PJM1KWCuFhklVu5SHyGA2XnTuTn7akrw+m54Ug=;
 b=DKrVBC1JUUwT9HhfxlI7ZbxeYadOxNmEfq43/yVMPmdwCNPPv1O4NK/Q2+d54KcB7VHWlxQ2Dk3PU4WEC/LepXfaGittPDEvRk78g3vIlFsOFOskNBnFRlKxg8o8CRjOgX9ff/nHaZMEqmchzm2ir0xChoWkwZUfSna8ODsavYR4AhHPmXQykP5v7h/NspPHnYb8eBIoLrUr2jCoQoIhKz+mK8HM7/0m9ynEk5pBTFKQ6Ida0dQHK+NVS0o6IusFqpYOHGO0NkU/n0Fbjz/uolsTwXswOLcPWHEYpVlX3i2Ko8rYsripz61HAr8IDyp0rOTHvi6+EkETeMW2k96lsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TOD5PJM1KWCuFhklVu5SHyGA2XnTuTn7akrw+m54Ug=;
 b=2gj9Jr+MSwF7bhlJACqkzGTNEEe/E5pGt/BTadEqhOLsXw28jMowc9Xhvh+b2hmt97lNrRmKFUPzvjuLNhtqKZStzoO0ngtkCT3lALwX/bpHWCIqnDrC13qxzzHig3sRXw4lAVQniPBCtGss5aavI58/GKi0npDtPXY3eT42kek=
Received: from CH2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:610:60::33)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 21:15:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::d3) by CH2PR14CA0023.outlook.office365.com
 (2603:10b6:610:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 21:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 17 Jun 2024 21:15:24 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 16:15:22 -0500
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
Subject: [PATCH v8 1/2] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Mon, 17 Jun 2024 21:15:12 +0000
Message-ID: <ff99398317efde228d3632b3876832676d11cd01.1718657194.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718657194.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1718657194.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: a8658470-7495-4e85-1f5a-08dc8f129a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/aZxPNXRPQqhj9D9DmQv91tjAnaPnW693mwZyMaIx2/f7Kpj4sVLO+zpuoO?=
 =?us-ascii?Q?BEf6EmLBsUxHOxVxF6arPwAgaz5R+N7xqJQIROALqywvAQwQymCrtlMcKgw9?=
 =?us-ascii?Q?R7QEkbcGOYo2afJr02iVs6ODNnItLwmxinrqFsYfANw005CsPVEOgGiP7tSo?=
 =?us-ascii?Q?V+iX0uz8BgpIojtwMaflIuiF049T3loXttAkoUMBN+pX3q8cL/PNUjGgF8iG?=
 =?us-ascii?Q?1xqlsllCynmD7QtPK8LG/73+9e5Xfy6GVu954Ogn0Jgd9VjficNBUUvGyxl4?=
 =?us-ascii?Q?o8tfZYEpdNdXg0vl52jeZ6z7kiyuU8Ce3ZL65C9dAL/7wtubLMtvrRnadWRq?=
 =?us-ascii?Q?b+PGDb4Vp3qH4pyX6SkpCK3gDfsW/o1Bdm40j0ld4CrsViZlKn262KA9ujwB?=
 =?us-ascii?Q?2RKWkiReJ0qEAvH3Y/kzDO5XfWYgF7iHGu6WWdqct3Xvrb5wth/WWw+0LS+6?=
 =?us-ascii?Q?AoK2LaXXDFFOXSPJBKh2lVGCsbRYy1Q/Q/mjqxuUlv+GUPcJ16RxnKC/yKA0?=
 =?us-ascii?Q?t6mGsaWOFYzalNfeAIgdyVfijGzphe8IndI4X5sI28mLY/5vhOtltslOUqKH?=
 =?us-ascii?Q?dzyLyWPTGiXH/X1yiHqg6j7efENEWyG0nD9GXi4F88ZVA1GRfygRz9Rvl9Oy?=
 =?us-ascii?Q?ZguwttDvLpQR4RId3QmWbBDWaBWftHiLZeI3U4AyIlCUMaQKvT9Lxa7PE27L?=
 =?us-ascii?Q?DGMp/AAYOijfmDsWl5KXbyoaT6MYzEvhNjmEeX7dyXslHDbBqcobteucnsri?=
 =?us-ascii?Q?uFnJRJJVFClMK6gRkzB7iKwKO3CoEOAYaXDzdx85Wp3P8OKZX85iaxFZgcWQ?=
 =?us-ascii?Q?5d4/wV2X+PKTE5N+C7Wo2q5YC2+kA8GyJ8co+PBL2gAica7f8IVi2B4hrN5W?=
 =?us-ascii?Q?Ro6cOOHBIXBXgpFp1vgD8DNf5VTtBnR4gmOidYFluSRu4hfbz1kEOs4OcWSU?=
 =?us-ascii?Q?G0k+U0dQknfzZM5Jve6MojCvGpkrYOt/IovuzsPWF1fIEK0aGYt2Zsohl/nI?=
 =?us-ascii?Q?Gq3NOprw5OqFjtJzL1NzHZZoRxBeyvzc+0g7jaLt1m+DiE+nhdaCUyqAZNHh?=
 =?us-ascii?Q?k1/+MED2Uf9fkuZBg2mgSbCOBq/k7LId0jgZYEeUhlRkM3Y4WRI959+MEDs6?=
 =?us-ascii?Q?kBCZ/asH7cBzEr3lJlMeCaQSPNdGIjSUKws4SSHgqksCmwQD+C9b/Yky0dej?=
 =?us-ascii?Q?ZuG5RitNkiOz+Tpi+cZU+BakEaD60upx6oFWSVbCJJoefEy6KAXNmmZYz8U4?=
 =?us-ascii?Q?qPqC3qdxmKJJ/DdiS6k7wYJ79vit3Uo7IuNatjtzpf8LUVtF4hhrsL7mKzQK?=
 =?us-ascii?Q?6YudSEhvreQGj/e+6spAl4eqmM6HkvA+0Ts7UCn7TT+a395hrqkWFb+xnADi?=
 =?us-ascii?Q?Ch4ewu5jYh3AufTwgdeMXl0Fmz2yrxK1A35y/QaixR3A6nGs4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 21:15:24.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8658470-7495-4e85-1f5a-08dc8f129a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM during kernel decompressor
causes guest termination as boot stage2 #VC handler for
SEV-ES/SNP systems does not support MMIO handling.

This issue is observed with SEV-ES/SNP guest kexec as
kexec -c adds screen_info to the boot parameters
passed to the kexec kernel, which causes console output to
be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is
preferable to get the console output only on serial, hence,
skip accessing video RAM during decompressor stage to
prevent guest termination.

Add early_sev_detect() to detect SEV-ES/SNP guest and skip
accessing video RAM during decompressor stage.

Serial console output during decompressor stage works as
boot stage2 #VC handler already supports handling port I/O.

Suggested-by: Borislav Petkov <Borislav.Petkov@amd.com>
Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..bad924f20a3a 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -385,6 +385,27 @@ static void parse_mem_encrypt(struct setup_header *hdr)
 		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
 }
 
+static void early_sev_detect(void)
+{
+	/*
+	 * Accessing guest video memory/RAM during kernel decompressor
+	 * causes guest termination as boot stage2 #VC handler for
+	 * SEV-ES/SNP systems does not support MMIO handling.
+	 *
+	 * This issue is observed with SEV-ES/SNP guest kexec as
+	 * kexec -c adds screen_info to the boot parameters
+	 * passed to the kexec kernel, which causes console output to
+	 * be dumped to both video and serial.
+	 *
+	 * As the decompressor output gets cleared really fast, it is
+	 * preferable to get the console output only on serial, hence,
+	 * skip accessing video RAM during decompressor stage to
+	 * prevent guest termination.
+	 */
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		lines = cols = 0;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -440,6 +461,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 */
 	early_tdx_detect();
 
+	early_sev_detect();
+
 	console_init();
 
 	/*
-- 
2.34.1



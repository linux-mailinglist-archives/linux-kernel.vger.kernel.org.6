Return-Path: <linux-kernel+bounces-238349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E339248A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF81028575C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F191CD5D6;
	Tue,  2 Jul 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvSl+vUU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD14084E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950278; cv=fail; b=en810QCZxERuPGw5xQYSKWesAmoq2IWtoApPFOWwG5oF/jx/2a0XRhvW9fk9ayX0Vj9JNErKqiDK9mUQX4nkQuETAODOKkaQKyp5F1VxslpyuuFvYh3sc8ffSKs5WnJpx0MWKhVP8VVicb4bELN8S3JnaiSPrm+PauPaN1mi078=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950278; c=relaxed/simple;
	bh=KMnNrU51AHoj7SypggOopSsUFQbVOXNKtOWQuOuQMvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSqSDH4kkyZSkOgVHBRk43nYaNSroTtLwZm4XqMEJP8pOE/6CVPNcBMSgsxd8JU7X3ALajYTxTOqfrNdv9RCvS2RvIvjHFLoDIm/KWP8LLFcq2sIq60UWwU+5dX65/33PYU3NdzWDz6NAaRMJ64SULyvGBozGwVFP54exNxbVNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvSl+vUU; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9VK9vdNN2U+9XY/TPU4sMVPSbtW/JB48xPJLa98vd/gjCznfUMx6dkkGl8MiLC/ac6oH4gq9K2LtSYbQXs5TGbi24H8NMK3/8DNuxBFMJdkWI57HAPRlAV221jI+qYJ4qwOmNNRB4qD9wS4QiM72dcWyj7qBUdTYMCcap4ptKYARJQ+zYKAR1tcKXTIpsyG23Xmu+laW+eWb24DjELlTnqGl8M4fmNUFgFQ3O4+7WEFWgoqF7CCy07LxuaEhQg67o/++Felydagq0PWMFitZHcdIPYjdwoX0RESnOLg1h6s0gqz+Mpg8pjWCIFgt55xK8JQVyouGcSaJMn03CVcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=fiwiHkm3A51CVnr6cZ2zYoKNO03m3SJai9V+4AXF5/giq1f13JCqV7QElzTcmcK/Yl2U4zVi53hE+Pm/dn9I8NwYYJu53N5btdEIhluIpTGI45iwtB+MAFAoW1OfsyqKlk/vLIO6fxZpANo6pa42V81MerKjREo7YjqUIn7BZAoPemgtrtm7Xj5f48ze+LBft1UZ3nhfHKbhXjlPSjw7h7MpmvvQ2PmhJI/bhrRtgWlsffB9chJ1xNgeG1yZUopo8JExrMYgQGStxT6k/+U3pZNJ8wUClVmJLw/W1AY6SpKmQ/Bu4xmcfZ3fBY05Hw9dbT85YcoJmjVZ9vQ4v1fKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAW6P1BTBJSfNIUvVl8FqTOvvJPB1XAot5xkWOzWcuA=;
 b=ZvSl+vUURV5P/xSetCZ24Jl/qt/wK0y/f422JHSZLR2q5wxcfa7vFz9lzDIjXw3eiaa1KX4rcNMq96aApsfcjS2j67jqCpAS4EGPU/cBYhXSDjrwXnbzN1u9SFBuO9eyraYtc7X0rP4t/JkUOfz73Sj9NDBFNNIqoc3Jesb4Bic=
Received: from CH2PR20CA0004.namprd20.prod.outlook.com (2603:10b6:610:58::14)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 19:57:49 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::8e) by CH2PR20CA0004.outlook.office365.com
 (2603:10b6:610:58::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 19:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 19:57:48 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 14:57:47 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dave.hansen@linux.intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <x86@kernel.org>
CC: <hpa@zytor.com>, <rafael@kernel.org>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <kirill.shutemov@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <linux-kernel@vger.kernel.org>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<ardb@kernel.org>, <dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <jroedel@suse.de>
Subject: [PATCH v11 1/3] x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
Date: Tue, 2 Jul 2024 19:57:30 +0000
Message-ID: <cc4636ee5a94c8b975ece43b9288a33ad62990cd.1719948376.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719948376.git.ashish.kalra@amd.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com> <cover.1719948376.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: f6158c41-60a4-4869-f942-08dc9ad13fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tbye1GI/sRxulyI8N+5yRNaQ+8sNuzlsr2vwTXihIQri5wdhSKTHi8T8QBKB?=
 =?us-ascii?Q?aL4UX3+LlTGKg300rovCtDj8hg7BCq7YmQLZtMaPYlTomn92LldtXfQ68COk?=
 =?us-ascii?Q?rtqY0rCRjfG1CZPcD0cuqwHP/jlWCxvcqaLWsq87WQToPP92xvM0i9x6b4w+?=
 =?us-ascii?Q?PwCkGgAGQsZ8/Faj1bdewUFNbIaEkHiQ4cXUjswI/tW7e/+okf3RqLbwzH+b?=
 =?us-ascii?Q?LIJxMIkRpRdmC0GmQHdHVTytqxCkNRek8i4+peEindyvSJ4PqT5iz03oWj3P?=
 =?us-ascii?Q?cIgrGOidj98xSHsHju+rzFNgC7zqyZmt9w4VH86P3b6mCKKWoTw/OM9GlxUG?=
 =?us-ascii?Q?W4TL5Mega2x04AFLhABubsKGg4OPRYsJcw17hvBQjV/trnZHvxqjuHmBQSp4?=
 =?us-ascii?Q?CvsUn7IpcProF6Tkln5yFt1I0pd10Vt0IM+LlSjq7JSdUU06JSSpsJ84US+5?=
 =?us-ascii?Q?SsvlMi7PYEYxZ/O3ORL+CROtu2FfxaPVm9B/3tzN+xG48mIPCJ4y9p3ApI+x?=
 =?us-ascii?Q?mdJfWHeRqP3Ll28/y2V8ZP6mxqObwq6RCsDwVaogIgWG9PCUPB79DM5rrz53?=
 =?us-ascii?Q?0y4g7KzPRe0irYSjbJASY2yFRNboKubRzXFxjr46SzYb5rOvFnEKNi+Uuksx?=
 =?us-ascii?Q?oYdoejOo7wPjcociz4bjlGPYJ2yjA6SWiaCzkfN7ttfY/6wy8qcUSnfGgYs0?=
 =?us-ascii?Q?cOgz1B4z+TLUBhS9WmzLW3RbH4qXYqgS1n2wmqd3+SxdtDRNhZB80jMz98uO?=
 =?us-ascii?Q?ni1JQ17xFHZVohiz4ZzL5f53YkOr0n4nspwEdarWmqcFv+ShZAycl8jKrDom?=
 =?us-ascii?Q?pB8ZOpuD+GgUIoQxjPvbz3J1xQ+8MFGg7Yfkr4F2v0mnJtQqfNNpUE+aXUKQ?=
 =?us-ascii?Q?jSEPSjMunaO/XwkGCdGQdZtWBz8B/KKb2ggp7RN0zLDV2UYo8lQFmmQga0mj?=
 =?us-ascii?Q?Jmh7KyWurBpDHwBAYfIRvwH0h7w57EY8GMKdyU2L9XgkAP+D58AJQLudx8Hy?=
 =?us-ascii?Q?lW6+omgPo/Ul/Xe0BRw8TXGGxb3Glxhiw2uVB2nJlxJ9evOHoGJjVcAmeBbV?=
 =?us-ascii?Q?/7P24NmDc3yyg0+WLrovyZ5ECQY5FgRBeXUrCsVHixxYg6S+kkc3aufWYkAu?=
 =?us-ascii?Q?g0oChA8vOyMKj9qF2bqTg+vydmLqqK6Dj4kgq+WWO/2dciNMUkMcUsy79nQf?=
 =?us-ascii?Q?u8gd16ivOoqgckmS+ubTszFvQMyP2nDzyjLsDcwpEgDkNAg3gG1e8OhqFfoN?=
 =?us-ascii?Q?odJRWgcniMrJBHqmEpG250bwRFoLG2jCB5s/5izSA/rRnS28VDwzTw8UD7pw?=
 =?us-ascii?Q?IOl6qS3c4I+OMo8wsCG9/Nw5KoCxY+NMFuLXogfzrVDiWYjaTRQuHqqQeRjK?=
 =?us-ascii?Q?4ux9LFXbm9BeLPmvIfwguJVjM+O3YcWXkqcK0WS6/4vRwAaVy/B0NdxLuW6i?=
 =?us-ascii?Q?bF7UZf6aU6F3NOcEDpXgxcev9rlBxTu0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 19:57:48.7006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6158c41-60a4-4869-f942-08dc9ad13fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

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
Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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



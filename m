Return-Path: <linux-kernel+bounces-292089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF14956AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1245B1F21014
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705A16848B;
	Mon, 19 Aug 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLJUjNds"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076A1487FE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070668; cv=fail; b=ra9DkF8FbxHXELpZ433FtGA/CX1XbKGQ6gkWKASoRXgMpfxMpJCx1ji1I3nattP0jhfIrXRHHbkUFlEW/Qfihx4iyKKjibrNlAF4N8LRXme58+1aDGp4X8Uq2DRfSPPWkPatvDdQEdD4YofphA8qEgkcTa9jzbURmmq5oQRNmmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070668; c=relaxed/simple;
	bh=lwX3QNlGgtQzN4P1h/5R0mW3TxM+CDE7ZwVi82CvDrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AAJ0F59seF/UQuA+6jOplwA8/CevmbAyKPUbUwGgpUzKgC4Y1iJi7lPQ0CCLlCnrFz2eNUoUc08KWlg/3KzeWJaSW5J+JOOlkDEbp6jbE8bFetbg9TwOMO6g+2+0XMebrmJtqwh6zBgPdRF1vGcRupcf/H+ccJiKswtc0fm0y70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLJUjNds; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWAYzBucxdDQvLefeCFAaJDUn5unnyOHY77khKNxs5h5I+acrcqohS55OejVzk6OwzONIN6yGmYBRziQf/LNxO96mXI6M03tKKFgctGXHdBuSAcnsJcbeZTaQseelOiqe8ZmFWhk+BUyYUhTlG+YrYlodGTuNVtILW1gauBz3crcij3sSj61kRD/39P8ZWHhTZAI82ndlwbEY+sAnOm/l5mu/QS75A5UrNNonkMYUb60XDDDZbYjhkPUM3DCvnMhpnAlFY+AAERg//buNw9YBr46N3//mKWVXVoI9Gs+dEJLu3VVPow2z4NbcfzMhknyc3OQKQEkxn1HUOX5DWk+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xWYmNvbgtGWU4rDQIkSWv/1kA0M2SMx/tp0/tcGtoI=;
 b=HS7F87IUZpIG8J8lMNwIABlyeivxyqBj8RQx6ukGMrSu22+HGStm6JovJGf/UxqsKxx3lHnsY0yYJ2t+glQaAzM12ZblOfSVoGdasfYaGEff36uyG8hrBesp0S8Kp6qP0xAb+UMfYnWcMIug16r2DyEEYoM8U9+dATPhcd9qPIV0LW4+NX/FY+cDkJv5FqncXHnMU1qc9JWGmwLhEMgjuvcpnqZVL8Nwmx1ArveHVuJJY3GTwTqooy5G0IMhFr97j5Gg4s/2qtKAGR0TmasffAka6v6ptlms2B1Cz+Oqs4NJhmT3QiQnmlJ0TI6rxLfzdBrpyehn/wgodSMzuG4FRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xWYmNvbgtGWU4rDQIkSWv/1kA0M2SMx/tp0/tcGtoI=;
 b=dLJUjNdsN/QzCrZPFv4pTMObEJS+Vlk8xj6PxlvodJiRJn8CLkStus9FYracRBTCFWvY13O78YWjf+BGkA27peLl7XKrCo1AIYjU76xSYz1AfbucnlqKULaqFocEf4m6qlM7IhfZP5dqZPWu7dnzjy45AVTa0zsHUuJ8ydlJsm4=
Received: from CH0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:32::12)
 by SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:31:01 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::5) by CH0PR07CA0007.outlook.office365.com
 (2603:10b6:610:32::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 12:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 12:31:01 +0000
Received: from cl-16.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 07:31:00 -0500
From: Richard Gong <richard.gong@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<yazen.ghannam@amd.com>, <Shyam-sundar.S-k@amd.com>, <muralidhara.mk@amd.com>
CC: <linux-kernel@vger.kernel.org>, <richard.gong@amd.com>
Subject: [PATCH] x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70h
Date: Mon, 19 Aug 2024 07:30:41 -0500
Message-ID: <20240819123041.915734-1-richard.gong@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA1PR12MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 75cf1fed-83d5-4c10-1e7f-08dcc04ac902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eh0W98+wA60LF8ENK6vIZTEwKiii5NzM5eOxb4WHbCfniQRk14CEnmEsKg8v?=
 =?us-ascii?Q?tcfBEBevi8APYflwg6U6vykR4NoIZ3BoLgFfqfZK/LVfj37oU3DoQ5cAJ4dE?=
 =?us-ascii?Q?Iwl+YZ7roNYHrZxyCRHDM717y7JzCnJYggupLpWSgUSCdGLmIeYV1IWEdmfI?=
 =?us-ascii?Q?eED9F0SU3dN/YMMUgZMQ0YfadttxmVLgv+E/J8HMfCEKyTWM/QDoqOkqFnrl?=
 =?us-ascii?Q?VRT4Uvy54bf5VnCbqcnWruMNSIg5Z7SMDtBb7PKVhoJo3wfrHU2q7fslRMY/?=
 =?us-ascii?Q?+tncUxJz0YAlVT3kyifXn6MCa3mTJjivqp6ba/GUxn36xPnWx2cCdxo2hQVb?=
 =?us-ascii?Q?xKFAg0wOWxkQWz71w9HJYjvUhTARBiMPo9F0rrKDVvaGc2r4SgH4qA7hn+D8?=
 =?us-ascii?Q?g3BaMr44yAGeonGuyaOOnTy8eG8/q7+/LO0LXopBTzTU9BbGY0PUx2S7Ij4S?=
 =?us-ascii?Q?qCcMi8HmBQqLmP0z9erBVSUiey79VJ82hhMmAVTctHht2KMZEDrGUxIhb8W/?=
 =?us-ascii?Q?BWumHpbOFIM0MVAvvW8WKhN6dNto9QWfqLAGgvWMViUx7TG1eLTsY/qYu1ya?=
 =?us-ascii?Q?84nSOdavDTOvoSP0vLuMivFxDHXp3L6LNflcXR3P2i/Zj3SIuCoziTWv2JoC?=
 =?us-ascii?Q?jMWFfEWIhrP8pfzo6v3RceqXtqCbBqyxgMCGF6BqZ6ObxIIK5fignG+Cswyc?=
 =?us-ascii?Q?RTgkkzJHFQz3mxSw9bkvOidQdI0ilP5UiVjUANS/Ygz3A07M9yNg6ZsdSFkw?=
 =?us-ascii?Q?Lfa12aIyjSlVevA1lhtLCJR3qBpA72HM9ETGRCRnHZKehTt01wH9/Vqbgr46?=
 =?us-ascii?Q?+2aD0hl0cCylLE3fsdDyTnorfuCtnFESEPEDV1TKhnd1+sN1aX+7Q/Ww6nlR?=
 =?us-ascii?Q?UmeELgyti2NhYohIw5be5/xZOI4+wAnBD/OTEiAly1GCbDw+NyrmE3C2GGr8?=
 =?us-ascii?Q?fhzd8LFQ/4Cdzv8842hxFWvY1IviOrVagwrtfgrmfob3CJpRioIbupiJ1GZS?=
 =?us-ascii?Q?q7xX4n8O2jNEJpfr8CqIEbF7AC6r9EytKzOK41Cw7rl+BjhFLUao+cWXBFKl?=
 =?us-ascii?Q?ok6fi8N8IID/CJLLge9H3Tj97a+LF9cGwCoso68jIRkOB430Jaf1XQY49xVy?=
 =?us-ascii?Q?fjy0q6xvwSU+DWgQbu6QhmDfKekpgf3ciPYzpQc0w5XaGzu5bHpVvRLVu+dH?=
 =?us-ascii?Q?uQH6mz18IIjaLOg7feS+zSZkjE/72Hykf7aB2kerF3QieJGtMVbj0doZFJ/U?=
 =?us-ascii?Q?X+3lbiDTNoOJw8KJkVmeh0pkbI/vklatuovK62honMUpDaRBVwQt7NlbPQIp?=
 =?us-ascii?Q?+dEo/+6zB9SgJxDZU3EMUzU3ulCKsPySwAFTi02m3dU1FwFgG1jkTkm7JQba?=
 =?us-ascii?Q?dUjc/fofTW3QwDKCC801IewVvGG6/fNEZ9fWOdLUKXeR4p4jMEo5AetCw/hi?=
 =?us-ascii?Q?QLax4PgD4+lqf+c2F4mCaHJffsAL8ST3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:31:01.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf1fed-83d5-4c10-1e7f-08dcc04ac902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6870

Add new PCI IDs for Device 18h and Function 4.

Signed-off-by: Richard Gong <richard.gong@amd.com>
---
(amd_atl driver will not load without a device ID)
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 61eadde08511..dc5d3216af24 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -44,6 +44,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
+#define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
+#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
 #define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
@@ -125,6 +127,8 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
-- 
2.43.0



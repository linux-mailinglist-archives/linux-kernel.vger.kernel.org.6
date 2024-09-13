Return-Path: <linux-kernel+bounces-328562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353EC9785C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6070B1C22D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDB56F2E2;
	Fri, 13 Sep 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="019xD9c7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F841C6D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245020; cv=fail; b=n/g+Howz8BLccv1Z8UwA9aPQ3RAeZz+L5ARWBwqPVWdmgnR3VNqdz5NebX3W9JkkYf+2Ifx5pUoGQTMgRtLc2Hk54KK73YeOpUEMHEUBLjc000SBDn8nxTucW36dPGyF2+RThcFCT47CRAf88Mvle12uSDGgdCjKnkciJaO4Z+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245020; c=relaxed/simple;
	bh=cTSMBIkzcW9Vws1Tib1NSUoJ0ytH5BUzX5Mul7plPis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1jwFenM7rNHrJfWmfj8FXrSRSPZO6Sn0ag9TEnzWVi/oG0ew7hxW2TwLa3LLF9LTxTBTavD8Z8CpPmvUMl6kCQEx140W7W+/RlMp0Wr1KZplK1eCjrQykb3jfw3GAt1uQKDPB9q4o3yTb6L/wkaaMCP1/Vyj3J++y0t1jx9oNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=019xD9c7; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=md1ov5NsLDN7fI/0HAO77Y4Gf/iyNDNXw6pecaTMtPN8jQMYTkUwE4kY+MIBbe9yoMieTRxKQ88pUCGI4xaOjCZB4ck732jM49JOTmqkbjFo3C34NRy3cddZ0t4GlI8yAXY8GzsqDOYtwKFVhIYRg8w8Y1rbSvhUaKgs+bEA9gov7DpnunZK1kNcXt1PFLgu/J7qJxViUejcTvk6o6jnr/GnWFgwe04RBeDzhYg3hmhiU8/1ZVOWo0715kF5MQiT8M2K3rYQkEysvZxgiWJgG7xSdRJnvZXPJfClasCZ67CgP7C3r6zDlX6yVn7pSGAycTsLbM6L90duW5Hp75X+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORj875zQ7eEbZ7ymba9cvI4F89FeXglME11vgKIIsGI=;
 b=bTQm1HWcj9AcgesJ2gfXQJwkiFIdUtvLJzw64RGoIiAT+7EJuHivpruCF5ytjFx+VKLDgVsF2rJ+bkRYzHBauiSOIyl8pemFbbAt3iFUgC0ufC+C0LBmw40TJyyXu9SiTZvoC0bMG3Uw8hdaRz1VHW92WDD+pAfSyFWLBfn9tMfdv8J0Xy0gPHnRYUF95e9MXFV3WfH0iQ14FvsLimscCbnK01gmKp1GqgbMmcPXtG7P6F4e1Qu/sC0efHEY76r9beD23w+cmO03AI1cXcngxUBIT89jwRh/Ly/uoJpXnIan0SozyZpLIH/p2QbhxLoagSPtf3yRFhbXgrfhGTKPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORj875zQ7eEbZ7ymba9cvI4F89FeXglME11vgKIIsGI=;
 b=019xD9c7wehVpH55gMDH1y5QAAbVk3M7iGBJXz4sYyq/Q7sknBO7qw+vyrTAf7w8jKE2c+L7WvuL1kQUlB0lTgJQhEXyPuYnhn9CDh48NalSsUAZM2P5Xmec/Q56ej+llGENawtKOgvFehbH7ZWUqiAM02bF18lZB+NVZYSjF9g=
Received: from SJ0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:a03:39c::13)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 16:30:14 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::d0) by SJ0PR03CA0338.outlook.office365.com
 (2603:10b6:a03:39c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Fri, 13 Sep 2024 16:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 16:30:14 +0000
Received: from cl-16.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 11:30:12 -0500
From: Richard Gong <richard.gong@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<yazen.ghannam@amd.com>, <Shyam-sundar.S-k@amd.com>, <muralidhara.mk@amd.com>
CC: <linux-kernel@vger.kernel.org>, <richard.gong@amd.com>
Subject: [PATCH] x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h
Date: Fri, 13 Sep 2024 11:29:03 -0500
Message-ID: <20240913162903.649519-1-richard.gong@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: fb251247-1ae4-45dd-3904-08dcd411585b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R7ZGs/8rT06r8vfaIsv0bCChDt4oqIdAlE1tUk3hxFQrWBmhxFuyEoLv7+Xt?=
 =?us-ascii?Q?3aS6KLFLEaQ728NRizyQ0D2uGJKOL2U49CWTKpRicXvHKlJaS1ygz//T+s4D?=
 =?us-ascii?Q?aIf0kvOaV4TOFs8VuSpXxaTuvWztwbi3BLZLSDRkLfO/fg72VWqda9dw9vVU?=
 =?us-ascii?Q?kRHKzzVSeOnjKbLgEI+NLXMgdqe9FX/k51uI2rUbLOiHBJlOc24wM7fbrg2X?=
 =?us-ascii?Q?/nqdw8wA6suTBmSvPegc4LjoBLT2ISG/RrvifnF2GVKmr2S7i2u+7EBys9sE?=
 =?us-ascii?Q?bSQUV/Q0pMSZzLxnQ9TCjq14wcRuCZ7UmAdOwD3qglH4/bRWKWdaGwKoI+V+?=
 =?us-ascii?Q?8gwIfUTtZ0PkYwUAXTjN0oeafv6WSp6ijsDJk2yezOr3GEWU+f/li4sfUf9Y?=
 =?us-ascii?Q?/M7GvP7GKcS9zTl7TDxO/Y2o1i0OyoQQWnNGLNib3ETo//LxAY+J3V4b0aBU?=
 =?us-ascii?Q?t/8/Jexb1Dg3SSexXUsIVDyzNO5U9ilC9DYXl80Wsy91AsxE9fqwUYsRwMCy?=
 =?us-ascii?Q?aR1ccpouZJTIyOaIN+fhl0uxV0+8zrCzvQkntEBphhhUlwC+5O0q1loGJL3l?=
 =?us-ascii?Q?pl/SDTRNA0bxax1rMYRUXqyPID3IfAEZXZzAb0VQB2K9O6o9zcMMi4dYlqlI?=
 =?us-ascii?Q?AtoRql+WScqnFfR9+X2ZJTudYWbCRH5PCtKeRUPM2Tz0uNuZlOQ7mjtvzrJI?=
 =?us-ascii?Q?mnntNhm4dmAF03ASJHKRn/gyiXqMwTBlsVWSFYmOHXIBO/h4x5fS1e0gUdoH?=
 =?us-ascii?Q?VgYr4I11thMApIe+/z3KOvpc4HvX0msCptaDCHD66e87efWmaZBcr1TnDWRD?=
 =?us-ascii?Q?6F/p4wOJx4YHgGcavHvSzt6crRhH5U97D7BonrM76o6HfOZ/MS1nS9RhNDlV?=
 =?us-ascii?Q?z0JeQAVkWyL7WDvD/tSv37TuJaVio69geoCNYRaWC5hM9Tk/Kay8A3hd628q?=
 =?us-ascii?Q?US6iHZRbtuiVeROAdpZeacRLOXgtbtpPj/blZRhCGHgVFurpc46Icuk4wHw9?=
 =?us-ascii?Q?hDSSnQMwUURzNRy9wtOrM6kSzotjJFbYlK0ioGAHmXVlF03uIwnjrX2Bb4aS?=
 =?us-ascii?Q?VH8aJOWZmhRzmGrcZmxAyTk/Hd8XMKvCpAaaoz0saPWGpDmgzvFs5ABFLibc?=
 =?us-ascii?Q?sRyUlfV6GGBIlYr31/VApP0M6u4Wxj+Pk21F5BfNHTBqJsdla+E1wxtS6p3k?=
 =?us-ascii?Q?q3Agk58Ii/dchuN4WMwMwwNDixe3UDaQPJ1qtr5TGPSde6xivUnbP0wKrCVu?=
 =?us-ascii?Q?9hZ9hY8KPPgfpXM9gwD4CeuV53wpYInOl/0Iqhk+/6WZTl8+UXswF5ls4aim?=
 =?us-ascii?Q?fgTh70Renn22iOfvjtn+a01q+gpiv/WNmWxl8cNyNzyxkXFgMzZtqAopUwMN?=
 =?us-ascii?Q?k9Z1NPx0ZAGhBMlh0gYGavCTf+Kg7uTPPYlv+A7Jdcv80C3hfiq2+ely+/qA?=
 =?us-ascii?Q?JBmyvzxs2oLiNZ7spslSrF/ZnaoZGR0L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 16:30:14.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb251247-1ae4-45dd-3904-08dcd411585b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

Add new PCI ID for Device 18h and Function 4.

Signed-off-by: Richard Gong <richard.gong@amd.com>
---
(amd_atl driver will not load without a device ID)
---
 arch/x86/kernel/amd_nb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index dc5d3216af24..9fe9972d2071 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -44,6 +44,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
@@ -127,6 +128,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
-- 
2.43.0



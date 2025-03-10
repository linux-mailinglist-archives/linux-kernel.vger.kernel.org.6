Return-Path: <linux-kernel+bounces-554889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D2A5A311
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007DF3AE523
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B308239588;
	Mon, 10 Mar 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQo36ozE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48419235BF4;
	Mon, 10 Mar 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631629; cv=fail; b=HwbNsOcvgywkULICm8mWjbz4Gmc4x3HCjYokoe7sgEDUF+oa7w8Q9F/1VcihcN0acb27KK5vQHKFraLtmgayJuFFtf/+1o3LbM9NUIhLt3kcXtDFcXAPLcor+wy5N5QPDXV9M33MyxGPCPpO8BifUS5VxwqGcCgVB0uqA2DUlJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631629; c=relaxed/simple;
	bh=NcsyDew9mKO+CAhCoXMU8ANxhAqu2pAM5fsIoQvgC30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rejRQtlFJKISNDdCP0uwnL5X0g7DqnCsX33uLcpYITtiTOCN9VGo/G8F6xSKvahyJJPMq+Up0KaWOLkhq6W3eRjCkPoOO+VEbrqRTgKQOUNkrxU0BbndW6sSgaiASIkrK+nL6dfnx3NMuDyQoyf035QPSZWXePBGkaaqFCGW82o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQo36ozE; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC416hF3hmPurxwWCIVSu373dh3hkmqqBrT+ef44iHaxKBurhxe7KpHZdNIcb0lFlehAkWEMnSCCBmVZzVo3NXGT+aHK//7LUETX42GkUy33435MFGxONiyt+qvISZZ4gd8zm6gCJ2RDzwwiOQwYwLCh3o7aEUBs+fzJ0rJU0LOnZlQiHH5Lw2v/x1E+oda+RZt8hyfRf80vZIs1FTizUfAawR8XgJB4hnh4UgJe/l6SrzdzDxXcRmWECj637XnKbgxlSeLcCuSJzoVEA91YdX1NnMgdy4f6BaXDN6DYtItdwiytJU41AzlgdNXzm64/LV8avKUTSoky7BM7NkXnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCNM1m52BnP0EmhtXDapEDWtdqpvLL/RI9/AdYrsuVI=;
 b=mtGmWrvhnNDb2ojF/H4ttJnj52zW8+vo1mq9SvyVkqUVkpvVRUKevIIE65xgCc9w9QXCUocKRk1ZbK0L7s/+WkuSsOzyQ2V1o+n8td5zS2KcNwBAQJQgibmGoAEhgCl66iyFyT9H7RtJE20yogHgkKdTgTJ0KLkMBm9T3BTliKjAfAxqu14GZmVnppTjmZInrGmycJDJveAIVm9L5dyRBbVRj/1eXwp/GnYtGXRf7K+wcmIQ5J8QrD7o/uWpjLhzMkbVUh+sVxYDQg2/H3AMvW3Xk4paeYs1C7qGv7ii9wCXfeox+A3qHxUL5fQRU4kyCRpaWOtbMj9UxNR3p4r3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCNM1m52BnP0EmhtXDapEDWtdqpvLL/RI9/AdYrsuVI=;
 b=VQo36ozEVyRWn+4H65RXFqS7QQP6KPIEO7E81RZ38uz3OhckMFmZNr7aH0wfOFJiwnAdS3xnQOAhP/Fnjjci4Haih5vbk2z+6WDYHG0X49fekAKAhdVpQE4gWc2MZ6+aOPi6G+y/rgR0VRcCmnw14h3rimMttDEDtfXpTJZQCMg=
Received: from BN9PR03CA0707.namprd03.prod.outlook.com (2603:10b6:408:ef::22)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:33:44 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::a7) by BN9PR03CA0707.outlook.office365.com
 (2603:10b6:408:ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 18:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 18:33:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:33:42 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 13:33:38 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Mario.Limonciello@amd.com>, <Vijendar.Mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<ssabakar@amd.com>, Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/14] ASoC: amd: acp: Refactor renoir platform resource structure
Date: Tue, 11 Mar 2025 00:02:00 +0530
Message-ID: <20250310183201.11979-14-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
References: <20250310183201.11979-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb1ba7-4f34-410d-c794-08dd60021602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZF1WvKIg6f89uoK/89tcfp/cfkrxYWO34fDVjACuIbhJYPFI1/DvN14dPtB?=
 =?us-ascii?Q?gUQFHJ5THLIQAI4uCco/xO8iucYI3RliWGJDdDseXAHSGiJdFo/gu/cInLYx?=
 =?us-ascii?Q?n4AbVmn3eOSG/KMsS6147X2Totlzw/x6Qk57MfDrAh8Zb4Ysq0r1k1EKMq2w?=
 =?us-ascii?Q?jwqW5XfZe48DPSWflMP8hJ0vcReBBk/iu1ZkGVzPIf/zQvMqc7ou8uRdrIRo?=
 =?us-ascii?Q?1F+jc5fGp6roJxXZ04RY6C77HtCsQMMZGzXJ/eXMB6LJ6jRlnhP7G78ugmgo?=
 =?us-ascii?Q?4UROh3v4tzkF2d9IT7YBl7KdQzkAhYXI+BxmZlw9heWx/FmTpPcVb63xnPWT?=
 =?us-ascii?Q?ZBHrlgwmSAnAI+37BRitfId9G/7LL41CLbOmb7hcQEEW1MeovUtxOaaywDBE?=
 =?us-ascii?Q?tndru9o/usAp+vddACkKn6iQD6agGqep5GIEAma98VG5e2ER7fYhIeD2OAri?=
 =?us-ascii?Q?YNTUyYfLc3b5+ODLAiG2J+jlRAYzpyZiyyBKQcMv3hvk9xBX59lV3yM/lsG8?=
 =?us-ascii?Q?zBdH429NtzYR4yrZYrZ5KodfbIEtYToDnm6U0vIc90jgyNTBT8VWYBbM8PGn?=
 =?us-ascii?Q?n1IITeA36zxR8P7QS05j+lCsfjRwLIip5b6UxoJTBa+3zR+96g21qImyeESy?=
 =?us-ascii?Q?DCMXtNhgLB/qNhVu65AxL8/FYw+V3H8hH7VPZVg2MNlZVdVL/9xQrcEyQOZu?=
 =?us-ascii?Q?11I2EwbydsNbKwPgplFCxfy+w28KRUuJr7DCgnGRJROCnylOmO+Z/OYKmRIg?=
 =?us-ascii?Q?A36pJGxKy5t5UHvKu3dyhF0B73knzHlS4gi5ZIhIbHBcUtc1ARmzd5m/hA/l?=
 =?us-ascii?Q?1Y4ZO3TxpWdxjyn1WJHLG52HQ611oSk3hTNIiQ5uTNVAnZPsLFCoqBnDQwlL?=
 =?us-ascii?Q?wX5ArzelRWb++mbaeBAuEJ7VGlfwHYIyY8eqz2T+4haQWrlUfGt37r2sEeod?=
 =?us-ascii?Q?0jY9CMwA26j1YE3KlkKghDcKMgeSv9FC6MRBv0HfGIfz2YwDfw9YGPBIDo5o?=
 =?us-ascii?Q?ofEhnIqex3pqGBOBVQ0mzwCBmBdm7rxDwn+QfHXElXo7DncuOWC13w8ItmsY?=
 =?us-ascii?Q?NtPrBQ7q4nFPSesglUPU0z6fEzVW9WSlbB2TFHLKRPioZlqOpA5GVj27Z33s?=
 =?us-ascii?Q?pcX1sCCBcGqyxjAWUHgzh5LHmQbRRLK8dXeEnD28aVEZS6HN3feEyLZXeCrp?=
 =?us-ascii?Q?O9MKgPj5PtZVq+wXqX2j+97WLQr40O1cLv3CRHtEXszQU33buyxAdeE2PhWx?=
 =?us-ascii?Q?HJuchY5ggsY2mYhUbK08pfuHE2IwwRKT6/SXgDqh+Ckqph839d7W1FI0P7pZ?=
 =?us-ascii?Q?ZEv+Vnj+taqTqsZ0W9cpafB2pt87jYVf8d2LRqnhK1Pd12zcwBXQt3a/M1Ct?=
 =?us-ascii?Q?t7Ww9acIhE8A5KEPari/N+64XNTd4wbYjQrnb0OXGgU+/KB5sPZCxZ2vkWsc?=
 =?us-ascii?Q?z3LtKha78ATL3wrE5oXf6hVqUkL7/FekvKIZswglvnOHeUs69Sg5kjnqyhc1?=
 =?us-ascii?Q?ObWjAff86OYQRfg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:33:43.1491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb1ba7-4f34-410d-c794-08dd60021602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256

Refactor renoir platform resource private structure to amd.h
header file.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-pci.c    |  1 +
 sound/soc/amd/acp/acp-renoir.c | 10 ----------
 sound/soc/amd/acp/amd.h        |  9 +++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 6dd905e75f1d..9322379cb36f 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -135,6 +135,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	switch (pci->revision) {
 	case 0x01:
 		chip->name = "acp_asoc_renoir";
+		chip->rsrc = &rn_rsrc;
 		chip->acp_hw_ops_init = acp31_hw_ops_init;
 		chip->machines = snd_soc_acpi_amd_acp_machines;
 		break;
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 970ca613a439..b8ded929d52e 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -27,15 +27,6 @@
 
 #define DRV_NAME "acp_asoc_renoir"
 
-static struct acp_resource rsrc = {
-	.offset = 20,
-	.no_of_ctrls = 1,
-	.irqp_used = 0,
-	.irq_reg_offset = 0x1800,
-	.scratch_reg_offset = 0x12800,
-	.sram_pte_offset = 0x02052800,
-};
-
 static struct snd_soc_dai_driver acp_renoir_dai[] = {
 {
 	.name = "acp-i2s-sp",
@@ -121,7 +112,6 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	}
 
 	chip->dev = dev;
-	chip->rsrc = &rsrc;
 	chip->dai_driver = acp_renoir_dai;
 	chip->num_dai = ARRAY_SIZE(acp_renoir_dai);
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 0cb6d2abf832..796f8efd395c 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -238,6 +238,15 @@ enum acp_config {
 	ACP_CONFIG_20,
 };
 
+struct acp_resource rn_rsrc = {
+	.offset = 20,
+	.no_of_ctrls = 1,
+	.irqp_used = 0,
+	.irq_reg_offset = 0x1800,
+	.scratch_reg_offset = 0x12800,
+	.sram_pte_offset = 0x02052800,
+};
+
 struct acp_resource rmb_rsrc = {
 	.offset = 0,
 	.no_of_ctrls = 2,
-- 
2.39.2



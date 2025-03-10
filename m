Return-Path: <linux-kernel+bounces-553987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631FAA5918B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38EE189021C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634F226CF3;
	Mon, 10 Mar 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3bDGGOY5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D916D9C2;
	Mon, 10 Mar 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603585; cv=fail; b=ieFmCcdeGB4Nak+UZmD0v+dlvM47s7os38TP00QC5YNDtUOFrjTFrj6hG7LGzyjTt41A1/w2OeVWbrh2Biu69YgvCHNzkjr/KbNrgqQ3yF+i4VQys9ieg9CoSYyX6HQBhU/U47Mu4n5/AiKCpX5x6nysrgfRuqt9Pk4Q59rV1dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603585; c=relaxed/simple;
	bh=y5pl5iDJAzplsdCpph2b8Jim/+eL077oC1EMZ6/ostY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsLYk037AP5ctVc9K5GgMssvMXUp7p8CQq5BExS8bX9b7Rb8LHt2/jjuCmz3Udu7yJZjVc2+7+q5lm1wOyMOqObmZb4/3U5hE2UhaQCWCqr2qSFgmRwm0GuWP0Ti/2byn6vkwNoxwzJSnpnHGCwK97gwRMyXOyttxaOUqSQnTBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3bDGGOY5; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSxZOYVwEvWo0GUGOVm5xThpeP1rFi54ktPferc1c6KXykbO376gUZ8QH5rT92/I5b2QYvXOTQMYiJixbEZizvnjIVhuHu0oGINFvhibNFPWFIvKkyYeLDuwniUWm9FbKyI3h43R5quAz1feYK2ORsga4HlKKX4VlaJE7lP+kqTau4ATa7+gi0aH+uTJy3Bejix2tHEVUNwoCAKt3YR/x++xUzyX686VE0tQgCwAEMSEjuc6zrfRT+qY0TYzmVVHn20ggQJXPcLg+muO3BMDX7cZWURohlQE38kEDEDwqtBBygMqcSklmM5FJ1qYsCtQS1nztwJgJyes1sslRs9+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YS4X/yloH8C4V+QS20qHtLzcCIioTgluASvGd4kBy4=;
 b=k/FmF9nvaVh3q2vuIuS4MKragiPnX3iZHbcJS8KHeBuxOj+ws2TO91mH9DLtHNd/xwdKrgQjDiNniN3lYWQw0ucU3uDABYORNc2rhJwVgRJeg+HuWccy37CZOw9LXluuisEaL4zYC79/SF5Op1HvLqBcJg4KGw9xwIXTPaJ5CnjIGgkavpS9Okr4k0wAxgr1z7fR/SGqUSsQ0IoxrpYDns+TEaIB01WpTkbaLuQUxxMPQy+rxA41GBDXKBOzTtUQGp+Aaq9G8DqoSCP4m+FrVa4QoJU0fVlBrCQra8xxDo7YgK+vSagLz7vUuoW/ej/FcB7TXqlQzmY3Z1Ar/wOz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YS4X/yloH8C4V+QS20qHtLzcCIioTgluASvGd4kBy4=;
 b=3bDGGOY5E3a/MEGYsemozyETVflbzHmIEtAxZPGlqDaSzDcJ2N9WJAThfBWmIm8dxp4a5ifJgGprmLlTV7NSaWstFFCyHLBgYqwhoBsuXolGeDU0DkDfVslqnXSAA2lbc8IZkUyWamUHrNncXCxFxsNLG9vtKPLWvzz0nuboeSc=
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by BN3PR12MB9571.namprd12.prod.outlook.com (2603:10b6:408:2ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 10:46:18 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::3a) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 10:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 10:46:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 05:46:17 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 05:46:13 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<syed.sabakareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>, Peter Zijlstra <peterz@infradead.org>, Greg KH
	<gregkh@linuxfoundation.org>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 02/14] ASoC: amd: acp: Implement acp_common_hw_ops support for acp platforms
Date: Mon, 10 Mar 2025 16:15:49 +0530
Message-ID: <20250310104601.7325-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
References: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BN3PR12MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf9a7bf-1d34-4956-76a7-08dd5fc0c9c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nXkrO5FtGlRY6drueGkoGzrgJXR2o16t5EEyY5/u7gLUa8MfifrSmM4kX1GJ?=
 =?us-ascii?Q?E7RyV2+Nn5KxDX73Koi+xUqoV8xmVC1cBmGciXGE1RM9zQV46YBamx6qnzYu?=
 =?us-ascii?Q?8jH92uOpIpl/YvgFNfSOUgSYfvVVvjvQDKYIIB9mY1SzMqrW/9RG7vsY4gVc?=
 =?us-ascii?Q?jFhvzNgIucfR6Pd0WjvQkTG/FCNMHGCYwemrE+WxOkGLHowCNip/oXXBmtbX?=
 =?us-ascii?Q?5US7qBdSmDSsRMht0hosRHltU1DRs7vQ5vQ3kx8/ZNGwvbjk0fSib4RhnubO?=
 =?us-ascii?Q?fOq1asevVOzTg729OYT0QIcef7qmlnLimMhynWxo/8UB9LY5IfaD+Bi7MC5q?=
 =?us-ascii?Q?vGXUeEvEEu9OcWLY9CReCOsnjbbBrSlEhseAa7GqOms5173fnYdi2+h3RvnH?=
 =?us-ascii?Q?f0caaB0teMHD2ba/FMobBzdI///X/q0RR+R0qCI4aoDahcMWSL8Qq7Jw83tU?=
 =?us-ascii?Q?tB0YjHbNN5uRldWYRvtPnCRBCYKWUX+MF/+AT5TOj/ZAkG+2IQP4o6yO1QyL?=
 =?us-ascii?Q?BZfnxscWlPldOPKwcfBqAAesIwYwwG1kDgrIIdl3K5GykZJyJUTS+k9vdrOX?=
 =?us-ascii?Q?QE+n79j/4GAmJbNHvYYpXvgd6ajv5gjXh9p8vUdOwDWTDr9UCEeoNmaG9WXr?=
 =?us-ascii?Q?CLekLmKzUUisOT5k7MyqANvFXUnGWDLqY1UqsYMMWC51hFzZx+lDDqt0evpW?=
 =?us-ascii?Q?S7xR8GmV912TMCVq2prFxsOJBc52VN9KQcEuao+gMnOBt/5DhPFmbdfQQ8SK?=
 =?us-ascii?Q?taNqaLImqK0Q8oiSUcpWXwv3Ae4M3RBKXGN2ItCWiXRix88+XIfGGb1nt/0r?=
 =?us-ascii?Q?ewFJ9cPJlrTPrSe1qcYxvA+ZpdInesbtg9QYpyzl0wQozCCJvFQ08VLnv5SC?=
 =?us-ascii?Q?8R/xBnBLMF8bqONWSErec2WqbpAmMBar2VFosBFq7RkAfgaRt20YuzlEreru?=
 =?us-ascii?Q?/LPVE47wptm6JgFbieR8YrTyWSpmeI22LkMpNFikMn0niQrW+lrIGn5+LUXJ?=
 =?us-ascii?Q?H3JEQJd8l3qZuBGNzDaBmV28aNHKTNxDwDENFyNHaXXhKpcrSMO/mZZnIaAq?=
 =?us-ascii?Q?O+SMIdP/fHwpoW1rTDF03Ip+n8satmBkDuBT9GdGXcBex+BvMD2bIwDshRy0?=
 =?us-ascii?Q?pEyL4Sijeeg2zMS76TSig37WgESk3pJ5ewGMq8Wp78rCfEkW6dqhdEa0rqmO?=
 =?us-ascii?Q?AykWHXKpRoOzaY83+UfUPLXQ1l7xHRS+A3BAcdnTZutwpnTsBzMLYpI9mg+s?=
 =?us-ascii?Q?pGvgq3Fo/ospLITY2e7BK2Z02vPcXusyIeP9FsU4oob10D6oTWR1dEu/2Qwv?=
 =?us-ascii?Q?O1tmd6XJ0lx2ESGbXfXYBpbNOEHvHd6qEjC0Jl3UHARCokpqw+0x6GdUxWA3?=
 =?us-ascii?Q?McFlWeI8KislESNoDaAp5/6c728i85gYORdKCFWH3QjrrfC7gNF7kDWvNP5C?=
 =?us-ascii?Q?rhP8lbAeqEgf0gwN8AO3Zdm7Ie4hYG5zvZsmKYu69oyAlKf4yQsT3cMtZaql?=
 =?us-ascii?Q?c+ETTd2Zlcf8Rbw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:46:17.8955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf9a7bf-1d34-4956-76a7-08dd5fc0c9c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9571

Implement acp common hardware ops for acp_init and acp_deinit
funcions to support commons ops for all platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 50 +++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-pci.c           | 13 ++++---
 sound/soc/amd/acp/amd.h               | 36 +++++++++++++++++++
 3 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 89f5cda18a23..f87a2da8c641 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -21,6 +21,12 @@
 #define ACP63_PDM_ADDR		0x02
 #define ACP70_PDM_ADDR		0x02
 
+const struct snd_acp_hw_ops acp_common_hw_ops = {
+	/* ACP hardware initilizations */
+	.acp_init = acp_init,
+	.acp_deinit = acp_deinit,
+};
+EXPORT_SYMBOL_NS_GPL(acp_common_hw_ops, "SND_SOC_ACP_COMMON");
 void acp_enable_interrupts(struct acp_dev_data *adata)
 {
 	struct acp_resource *rsrc = adata->rsrc;
@@ -463,5 +469,49 @@ void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
 }
 EXPORT_SYMBOL_NS_GPL(check_acp_config, "SND_SOC_ACP_COMMON");
 
+struct snd_acp_hw_ops acp31_common_hw_ops;
+EXPORT_SYMBOL_NS_GPL(acp31_common_hw_ops, "SND_SOC_ACP_COMMON");
+int acp31_hw_ops_init(struct acp_chip_info *chip)
+{
+	memcpy(&acp31_common_hw_ops, &acp_common_hw_ops, sizeof(acp_common_hw_ops));
+	chip->acp_hw_ops = &acp31_common_hw_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp31_hw_ops_init, "SND_SOC_ACP_COMMON");
+
+struct snd_acp_hw_ops acp6x_common_hw_ops;
+EXPORT_SYMBOL_NS_GPL(acp6x_common_hw_ops, "SND_SOC_ACP_COMMON");
+int acp6x_hw_ops_init(struct acp_chip_info *chip)
+{
+	memcpy(&acp6x_common_hw_ops, &acp_common_hw_ops, sizeof(acp_common_hw_ops));
+	chip->acp_hw_ops = &acp6x_common_hw_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp6x_hw_ops_init, "SND_SOC_ACP_COMMON");
+
+struct snd_acp_hw_ops acp63_common_hw_ops;
+EXPORT_SYMBOL_NS_GPL(acp63_common_hw_ops, "SND_SOC_ACP_COMMON");
+int acp63_hw_ops_init(struct acp_chip_info *chip)
+{
+	memcpy(&acp63_common_hw_ops, &acp_common_hw_ops, sizeof(acp_common_hw_ops));
+	chip->acp_hw_ops = &acp63_common_hw_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp63_hw_ops_init, "SND_SOC_ACP_COMMON");
+
+struct snd_acp_hw_ops acp70_common_hw_ops;
+EXPORT_SYMBOL_NS_GPL(acp70_common_hw_ops, "SND_SOC_ACP_COMMON");
+int acp70_hw_ops_init(struct acp_chip_info *chip)
+{
+	memcpy(&acp70_common_hw_ops, &acp_common_hw_ops, sizeof(acp_common_hw_ops));
+	chip->acp_hw_ops = &acp70_common_hw_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(acp70_hw_ops_init, "SND_SOC_ACP_COMMON");
+
 MODULE_DESCRIPTION("AMD ACP legacy common features");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index dcd92d716e78..b5eabd0280bc 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -81,16 +81,20 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	switch (pci->revision) {
 	case 0x01:
 		chip->name = "acp_asoc_renoir";
+		chip->acp_hw_ops_init = acp31_hw_ops_init;
 		break;
 	case 0x6f:
 		chip->name = "acp_asoc_rembrandt";
+		chip->acp_hw_ops_init = acp6x_hw_ops_init;
 		break;
 	case 0x63:
 		chip->name = "acp_asoc_acp63";
+		chip->acp_hw_ops_init = acp63_hw_ops_init;
 		break;
 	case 0x70:
 	case 0x71:
 		chip->name = "acp_asoc_acp70";
+		chip->acp_hw_ops_init = acp70_hw_ops_init;
 		break;
 	default:
 		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
@@ -112,7 +116,8 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 
-	ret = acp_init(chip);
+	chip->acp_hw_ops_init(chip);
+	ret = acp_hw_init(chip);
 	if (ret)
 		goto unregister_dmic_dev;
 
@@ -179,7 +184,7 @@ static int __maybe_unused snd_acp_suspend(struct device *dev)
 	int ret;
 
 	chip = dev_get_drvdata(dev);
-	ret = acp_deinit(chip);
+	ret = acp_hw_deinit(chip);
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
@@ -193,7 +198,7 @@ static int __maybe_unused snd_acp_resume(struct device *dev)
 	int ret;
 
 	chip = dev_get_drvdata(dev);
-	ret = acp_init(chip);
+	ret = acp_hw_init(chip);
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	if (chip->chip_pdev) {
@@ -222,7 +227,7 @@ static void acp_pci_remove(struct pci_dev *pci)
 		platform_device_unregister(dmic_dev);
 	if (pdev)
 		platform_device_unregister(pdev);
-	ret = acp_deinit(chip);
+	ret = acp_hw_deinit(chip);
 	if (ret)
 		dev_err(&pci->dev, "ACP de-init failed\n");
 }
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index c921bcabbcec..2098afdddc60 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -142,6 +142,8 @@ struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
 	void __iomem *base;	/* ACP memory PCI base */
+	struct snd_acp_hw_ops *acp_hw_ops;
+	int (*acp_hw_ops_init)(struct acp_chip_info *chip);
 	struct platform_device *chip_pdev;
 	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
 	bool is_pdm_dev;	/* flag set to true when ACP PDM controller exists */
@@ -203,6 +205,17 @@ struct acp_dev_data {
 	unsigned int flag;
 };
 
+/**
+ * struct snd_acp_hw_ops - ACP PCI driver platform specific ops
+ * @acp_init: ACP initialization
+ * @acp_deinit: ACP de-initialization
+ */
+struct snd_acp_hw_ops {
+	/* ACP hardware initilizations */
+	int (*acp_init)(struct acp_chip_info *chip);
+	int (*acp_deinit)(struct acp_chip_info *chip);
+};
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
@@ -239,6 +252,15 @@ int acp_init(struct acp_chip_info *chip);
 int acp_deinit(struct acp_chip_info *chip);
 void acp_enable_interrupts(struct acp_dev_data *adata);
 void acp_disable_interrupts(struct acp_dev_data *adata);
+
+extern struct snd_acp_hw_ops acp31_common_hw_ops;
+extern struct snd_acp_hw_ops acp6x_common_hw_ops;
+extern struct snd_acp_hw_ops acp63_common_hw_ops;
+extern struct snd_acp_hw_ops acp70_common_hw_ops;
+extern int acp31_hw_ops_init(struct acp_chip_info *chip);
+extern int acp6x_hw_ops_init(struct acp_chip_info *chip);
+extern int acp63_hw_ops_init(struct acp_chip_info *chip);
+extern int acp70_hw_ops_init(struct acp_chip_info *chip);
 /* Machine configuration */
 int snd_amd_acp_find_config(struct pci_dev *pci);
 
@@ -252,6 +274,20 @@ int restore_acp_i2s_params(struct snd_pcm_substream *substream,
 
 void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip);
 
+static inline int acp_hw_init(struct acp_chip_info *chip)
+{
+	if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)
+		return chip->acp_hw_ops->acp_init(chip);
+	return -EOPNOTSUPP;
+}
+
+static inline int acp_hw_deinit(struct acp_chip_info *chip)
+{
+	if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_init)
+		return chip->acp_hw_ops->acp_deinit(chip);
+	return -EOPNOTSUPP;
+}
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count = 0, low = 0, high = 0;
-- 
2.39.2



Return-Path: <linux-kernel+bounces-554875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68CA5A2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE969175568
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3B22FAF8;
	Mon, 10 Mar 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhFFjd9d"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A72AD16;
	Mon, 10 Mar 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631543; cv=fail; b=QGtnW4DU9ZefOU7oytGMWVp7arWEQs/n9EKNQlUK07YetCAr/RlJC8ZMpRjQLJdBnh6sG4PwkY8aEUxuHAeeSAcmVE/U9oftknDsBJ9GZgh5OHqxbX9w6l9kb2mbzj28k+l7tAXoNjm8IUMhFXGe6/oE4oJO38giJ6ID+q6FRv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631543; c=relaxed/simple;
	bh=AeJFi3q47HY4SDYEIFsXss7reFvPIGFUBAjn2Z3t9nU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWzI1Y8Ij+ujHrsmxvwx+NmnZrADodJpsUGV9Ufg8NnYc5/9IXkX8l11tbA47YngOzoS9bRKpUWkeV1MVtMw/t6TDBz63GrwDJygqjXXbr//DCrw8E1Lr3u7IEgVgyARqObO6WP/8zsnfJKu/x+oQqma3pk7TOmMZI4mGGuEWvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhFFjd9d; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImW/fzRk4zDO6F9In16T6EvRkE2EA6EMxZ22/aGrZSAppfPaHyrCwsP1GfSzSK3qoIoMSvbZMPxgK56APy867GbpdJMIqnZoLnx/UjodJFKW5btb8ZzSOPNdrNVT7122p4hxQLYqS1Y7lJbAzBBmZfsH4A9zChEYIZS3rqQAVnyqVMbOIkFg5rP+2y2800LArQeNhpWmdgS4DRPCsePS+SPH1d3e/+TMpjGft+WUTIGzsEOCv+vgEfWTeF9HCbMTIM7TuzfM3+kfScW24u0QLslJ2GiCCga1ACXCl4TNX/mkesQsX7cSl49ByX6tOcH7XD3WK2Szo58chC2QHZwvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVve5xY86B7Vxx7Gmx3H2QvNhiF9Xy+jcYjT50d6wHE=;
 b=i0tMANTvNXq+j5EeP/Q5FggBjPET/TPPpijwHZVFFFjyt3eLjwh8aWKKZeHSaT+a17QerLdUkWOFWa3KkuOsLQnm8iI0eikF64jaW3w4oISVtvfa/qZjYZT3HKH3vXUaWWRQcRG4cB8mh66tZg3YTwlS8kDaqxzJQuWZyK8D6z3Z1kLwHTtxn2H6TU2eyGJ9HjeswOAg+BMlmbTDaB6sUaD1rVMdMT8OO4I3hNtrwtMWiFXHUqC88N9QnIE5uZz/wfKqj4/F68yMkilXmsA/kTMljKtahffm7xnVjRtWTdfVdoErX/rnx0aQ0jq9Ddr1VSCTCR2rnfAfD3/H0jpxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVve5xY86B7Vxx7Gmx3H2QvNhiF9Xy+jcYjT50d6wHE=;
 b=vhFFjd9dyrkKe1EHuc90+bYkDke3aaoiaincSQKgK1duTtYSaWKC+7InenWhRrMNQnOlFy3YMBVznMvcOpJ5R4KgN9TiDWdBZBGpOt5DsrE45VIHZTFaf3cExlGAohtN0yf69DUoCGD0148KEWp+icPQI8jX2hc5A8A8V0Osj7s=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:32:17 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1a) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.18 via Frontend Transport; Mon,
 10 Mar 2025 18:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 18:32:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:32:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 13:32:16 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 13:32:12 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Mario.Limonciello@amd.com>, <Vijendar.Mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<ssabakar@amd.com>, Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/14] ASoC: amd: acp: Implement acp_common_hw_ops support for acp platforms
Date: Tue, 11 Mar 2025 00:01:49 +0530
Message-ID: <20250310183201.11979-3-venkataprasad.potturu@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: e5fd77cc-1bfe-4cb4-3bb8-08dd6001e2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+LNN0JuQ3swK7HMLgpTaBge4XcSZhQkBn6VHaR9qyDDoMlIMBeIKIIp8DQM?=
 =?us-ascii?Q?pcGf5Ws7bNiGXvxcOrb9uKWMhvPZuh9YJZTrlfkcXe44AUBqhlVFDrMuGzvI?=
 =?us-ascii?Q?X7pb+3K+th2iDjFu14T0wGmRzhHCfzxm++zv3IsCtWRAX6mCHypd/nAYHD3+?=
 =?us-ascii?Q?zmcVTnqznnuxfggUJPWFN8/qR+mRRZ1tvL7KxsQXuR49qkVCvg638abPIYCQ?=
 =?us-ascii?Q?A36mvNG6tfjQCh5e9t7QO+WeSn7ogXz7vPPS7qWbEcFkcHILd/DQgPpAQoIw?=
 =?us-ascii?Q?DTX+Hkd90KRXTQ173ksRTqZdjpmtmmGNfNluyGSjN9SLpO9FG3A3hVy7aM7y?=
 =?us-ascii?Q?S0sFAZKABkqmvlGhcpXdlrKqAMMcL5+TakycidahlwWY2x8f7PvrkQg+5Pyv?=
 =?us-ascii?Q?IoeUgf+IIAuu7GzXncm5HT2JiC1Qg28Np84q+PMcWJ4yjNtCltJC8zVbopOc?=
 =?us-ascii?Q?tGmAHUD6Usz18GOlJo/E5sd4sRWDOcdudLRtFmR9GftBeoUks9kR6HzqpHfw?=
 =?us-ascii?Q?9ocIlRDMQAt09T1+4a1s2VA72iuHI0tvBZ3qNYTzQzzC2nXogwx8NbKyMg3B?=
 =?us-ascii?Q?Ilt7fll9Jr50OvADfBAWX028l3rMpUnL3QsI9fsOx+DEPL8xoehzrbnuSRQN?=
 =?us-ascii?Q?EFx24DU+FrOmfLxgDME6pAntcGnZ5hXmkZiVHqOIXlzWvznHWtoggYK9nGS9?=
 =?us-ascii?Q?niZloQWQLMiTwWd8GNLoyoaWjgydrbZOl8HPYtD3G5zQ34t32fOupZdWuotS?=
 =?us-ascii?Q?IU9gtLm2XCznwP/jLiBJ4BEG/Dg3A2oJ7tv/bDECOt8SYTHckxjmgjbxTOte?=
 =?us-ascii?Q?KUGAFOJFLmy3egsjqJhl/mFPEmrOYcZvEy7INQDXcGIYJ2hTWPcZKERLZJmD?=
 =?us-ascii?Q?PNxmT5zkduxeJy8ZjRZaCVnU1suCHKHuP1/uxA+SkFyrBzv8y3E0DdmlGAdI?=
 =?us-ascii?Q?IBekXWSAibIiGq7alu0YhXmuJ8qAeDDfhmUolt28NqIDxyglsKca0rvgD3+3?=
 =?us-ascii?Q?1B6EMTAxc92f9BbBXt9CQOcQfFrpb0o/tDI8R4M82u1OmoueL4N7jyKBOS5h?=
 =?us-ascii?Q?mqo0PAIq2utTljqRAIRMdyogTxACpB4s/VJQv/T6i/EScaHCMeEXIp19UY5q?=
 =?us-ascii?Q?eDfyZcGHDE0xbPGDCWJ4LTjIHDr2TFgjHa8pf7cHi8F0/sYHFxBre/NfG72s?=
 =?us-ascii?Q?3K0eG71HIjPVYu9FW4fKMgPygT/lswvlp2pqQpU3MFtHTLOVUYEbPtgLkqSW?=
 =?us-ascii?Q?71/Xbs4RcwdCIULNi4EaYOLzWp66y7WWrS2N4Zl2RhW7UhsFESrW3jxJd8rh?=
 =?us-ascii?Q?7HK6ZOlGUniFSNj4giN0Owoygft2+Zr1W5bmWNRvkCj1MsuWyYg1wh23GhAP?=
 =?us-ascii?Q?pNV3xxQbAx5PWTo1LVL9OmyqYVKH60ZP9jBGCEPNOqJCpnswUoc3pgkZ+bIn?=
 =?us-ascii?Q?R2uAbBHOot4ZWsCp6J2CcDuqGofeMcV6O4hfmhHiBqyXmMJaOTNnwMlsgQaY?=
 =?us-ascii?Q?MCV61rjoLXPAois=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:32:17.1779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fd77cc-1bfe-4cb4-3bb8-08dd6001e2c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826

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
index c921bcabbcec..3c06567e112c 100644
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
+	if (chip && chip->acp_hw_ops && chip->acp_hw_ops->acp_deinit)
+		return chip->acp_hw_ops->acp_deinit(chip);
+	return -EOPNOTSUPP;
+}
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count = 0, low = 0, high = 0;
-- 
2.39.2



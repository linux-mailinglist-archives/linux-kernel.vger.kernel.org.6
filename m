Return-Path: <linux-kernel+bounces-336605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E252983CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F36F1C21AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D226E614;
	Tue, 24 Sep 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I1lEaA8U"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114154767;
	Tue, 24 Sep 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158731; cv=fail; b=vC5meXiLOtbtwZHxFr1xI/vkg8rXwKbXVnxEWlJEfObZomVoJtRX7QmgC9S7Vm6PtTiYO+qNRidaywXoK1Elnvg/+LwV+35qd9TpI91SDi28iWnKj18qxckREQeqS9/GNhyr2u2zcrFDR4VGj8wYhd8Ex6XsH0nIwMnIgaIfTxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158731; c=relaxed/simple;
	bh=9FniKUlrjazFq6pmMecSwbmKXIuy6lccmoplzJIApc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE+Q2nAVczUPCagc0Ny0FHDPO7dbNM4xtBw7LKl+SEKqIYIJt9rcpwicKBnzXQw/iIQR//O4SKSqf4i7G0eozge+0bi+cuWe2e06M6hEuAiGbv2k1MPAnGKe4naT9I9SYSfNRMbO6Q50nZz5132GVUAIxjnyqCi5gVrFWzj+auk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I1lEaA8U; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atp+mCdKfZKWyYQ76WZ7ppEVtkkDDEstxYg7vqeADCdd+RxL/0HRdUvU4S5iysIgT/UwZGmnyenJwp+qeR2x/Oidrk33PyXcWyUKHC3mdnQiAsKES2mkP+716cvKKbWBF7CJ2Zq4Mj3unXYDoG+dxUsewPUqvTletjXgsPF+GQYpw/9glO6lmBzeGdy5+abc5JpqfpwWr+UR9JQgCUbr+EVCsmkufBpz1Oq6fqDcubd4FBu+q4LyzD21QoFLwif/wy/OoRmyQ1mbtXKVE8XerF5AdhJd71b0CQUQnhHv+nZXtz2dkokrtHpyZESXunqtLa0IYbC1cC9peXW1ZWssGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eGIJ3IVrjjqLH0Za3OQUHa8UGopheQ4Ktf6ylu5E7Y=;
 b=Zg1/IKpKcA4wWYo3f5RklDxGPV7dzj7AAjaCEDfi96/nwQPBucKYTE+PkBCUEc1HYeVvQm2B0dVVIwuKCoW6GhMcJTgPE7fYb1utrBKOfk4om7RFsov94Zz3BefWfx43CmrdclhYgoumj7mueubLlUXTJFAiCsXN+Q1rzB1aoTBExsb0ZS8BGb4SkUwASN4nARKZw1PhVRFranfac4dXyYfKIw6/hM/xBMkKyooWCRLMX5yWf394BT4RGGpCDpXsA0jZcDM6zrVpyAc9G847kaetyPqBwNZHTK8hGMpY5jvii/M/uQzSnkQAGtG95w++TpE5aEEW1iILj390nsZDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eGIJ3IVrjjqLH0Za3OQUHa8UGopheQ4Ktf6ylu5E7Y=;
 b=I1lEaA8UjEu9TROU1i+8QACHCDCquPOmomWZ/jVt4rerkPmq6yNjY+GLtqmVKwpCEQWB5tL1UF4qnedoJ72MeBj5p2gVPA9UKVKYNDkq4gJ0WhPvZMH6+DeMrT5UJHVsmeaKvhcKA0zULydSJ4mQsU81jecOA04y4rZJ++YdsZc=
Received: from SN7PR04CA0205.namprd04.prod.outlook.com (2603:10b6:806:126::30)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:18:44 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::32) by SN7PR04CA0205.outlook.office365.com
 (2603:10b6:806:126::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Tue, 24 Sep 2024 06:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:18:44 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:18:40 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 2/9] ASoC: amd: acp: use acp_rev for platform specific conditional checks
Date: Tue, 24 Sep 2024 11:48:14 +0530
Message-ID: <20240924061821.1127054-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
References: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e650f93-e290-4f24-b42c-08dcdc60be37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBjmPE0zkI6FyLtM9pz7RphDL0uzRbJp4Z8kgpnRm3lLaFXj4YwK7eFTcXiU?=
 =?us-ascii?Q?rAILeoBCdm+bWeSlDugZ4IqpOJ58OJV5Uu1HXnmruid3S4YUGAt2nxAi2XqF?=
 =?us-ascii?Q?xiIjx+oTQKSbcm/R7aHeAGeEDpQL29jSYsI/9ghnIPShpB80emrc1SzC+8yI?=
 =?us-ascii?Q?6f7aZu631DoUMp712f6vhblCmkG7gdqwxrAzjxXjSYfPESrFM1tz1LoU9GtD?=
 =?us-ascii?Q?w/jNRkFfxZ4DgJ+JkiSwyIHptpZiPwrXOvb7H3TT0ziNzvqh/YXLImtX5rVN?=
 =?us-ascii?Q?UGnLL+zH5ZL5ThrytYQIr/ganQaO0Yo6V1fIxAsVxdKdc/Tb8gZpxV9EehAm?=
 =?us-ascii?Q?GqJqfl0JrjaMe13OqEI/o4ak6zcgKxbH1mmipnIU5TH3ZbxzlLQkFzX4m+k2?=
 =?us-ascii?Q?3a/hQKwYha2VKXSliB+6KCi8WXmzRIbCGwpmcEWYAzEjBV/Wvu0HfdY6pS3/?=
 =?us-ascii?Q?zsoHGzSfkTUMbwo85fV31RKiu6SYqFPWiu6qMZOY6cPVk97PdxQxGWgkzQ9S?=
 =?us-ascii?Q?kCEZ2Jsrz8+A9Y1bFv/QjsYOBXyS8ymQatTFCCC0QrClg0GyIXJqHiGVg4Sd?=
 =?us-ascii?Q?pP0e3pPwTGLXtjf75pHbNFFEXjHBOPM+57CjMyIk9Xj5R4ug8QtL/HVgESjH?=
 =?us-ascii?Q?z6zBDwM9mlFUh3qP22YOz4KYuwBhwbdNjYyhmJFxYiC/XMcTMvQGa8nlncNU?=
 =?us-ascii?Q?004RVF6lHH1QgtEJ8OnIlI3mxsfHnBjV7Vk1hIYtxy9aEe9vp9tj2eZB7jZm?=
 =?us-ascii?Q?0lHrEz0pzaNDt+aeNE04Agc5kJQ5+8f+ai1Z7s5sdFmwe3+Oc73YCNShQl/n?=
 =?us-ascii?Q?J7IsbdRh5BDISQ25f44vacM04+vw2rOJCrWtV6uIp4+qereMd3jNXu8dBQwn?=
 =?us-ascii?Q?wepjo10kwsCySCrqZzAzRJHn+SQ/mXqMFOOJrJfj3pPR6tsZ5jdcsa0Swykj?=
 =?us-ascii?Q?11SenLqvAzpWjkbveLzWVQC8BLibc1F19+z4Ad/t6TLIobCFoGc+c6+Lyobq?=
 =?us-ascii?Q?Y6qEWxu144O53Dv88eZXvaSicv2rfVF02ha1C3GLGLGmmjKKeRr4nn+vEXW1?=
 =?us-ascii?Q?hvv3GQiuPbQC+oqxbTc+CYMS84AV8DzD2BL59wsOMK3Xg6O4hmmuFG/dWpI6?=
 =?us-ascii?Q?H3AOdTW081jcpW1qhpYyondSQdQ7onWk2YTI9R19CWlh+PjdSoBz1ubi+3h2?=
 =?us-ascii?Q?SAT1qtwjXaOXCUcPWKMAJBbFJssIUZia8vMeM2rLky0f8nDp1s7irPXhnWSg?=
 =?us-ascii?Q?hUXGT+G6+v6MqfcmNuIEXXrPYnfaCQIqzQxqTU0aOFBGJLh4a/jgocsaegr6?=
 =?us-ascii?Q?GPUmLj6crmxesH53bpA6mDOYkY0FM7Zas0u8TJtBu13zoUl0H+rXjYA3rSE1?=
 =?us-ascii?Q?6jxMNhFkBxGxrQ258uFhnLoV4+WPh7/s9KQYxdfnGKI/2lrGT5pW9YmYoroK?=
 =?us-ascii?Q?IYVOvzflINrJztGK6kTHRmhvYiPxJCy/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:18:44.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e650f93-e290-4f24-b42c-08dcdc60be37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

Add 'acp_rev' as a member in machine driver private data structure to
store acp pci revision id. Replace platform specific conditional checks
by using 'acp_rev' variable.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  2 ++
 sound/soc/amd/acp/acp-mach-common.c | 24 ++++++++++++------------
 sound/soc/amd/acp/acp-mach.h        |  3 +++
 sound/soc/amd/acp/acp-sof-mach.c    |  2 ++
 sound/soc/amd/acp/acp_common.h      | 19 +++++++++++++++++++
 5 files changed, 38 insertions(+), 12 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp_common.h

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index d104f7e8fdcd..2a59f7916e15 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -126,6 +126,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
 	const struct dmi_system_id *dmi_id;
 	struct acp_card_drvdata *acp_card_drvdata;
 	int ret;
@@ -173,6 +174,7 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	if (!strcmp(pdev->name, "acp-pdm-mach"))
 		acp_card_drvdata->platform =  *((int *)dev->platform_data);
 
+	acp_card_drvdata->acp_rev = mach->mach_params.subsystem_rev;
 	dmi_id = dmi_first_match(acp_quirk_table);
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index d4c7a7b79177..2394aa061265 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1471,7 +1471,7 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->amp_cpu_id == I2S_SP) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
-		if (drv_data->platform == RENOIR) {
+		if (drv_data->acp_rev == ACP_RN_PCI_ID) {
 			links[i].cpus = sof_sp;
 			links[i].num_cpus = ARRAY_SIZE(sof_sp);
 		} else {
@@ -1647,12 +1647,12 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		links[i].id = HEADSET_BE_ID;
 		links[i].cpus = i2s_hs;
 		links[i].num_cpus = ARRAY_SIZE(i2s_hs);
-		switch (drv_data->platform) {
-		case REMBRANDT:
+		switch (drv_data->acp_rev) {
+		case ACP_RMB_PCI_ID:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
 			break;
-		case ACP63:
+		case ACP63_PCI_ID:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 			break;
@@ -1719,12 +1719,12 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		links[i].id = AMP_BE_ID;
 		links[i].cpus = i2s_hs;
 		links[i].num_cpus = ARRAY_SIZE(i2s_hs);
-		switch (drv_data->platform) {
-		case REMBRANDT:
+		switch (drv_data->acp_rev) {
+		case ACP_RMB_PCI_ID:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
 			break;
-		case ACP63:
+		case ACP63_PCI_ID:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 			break;
@@ -1770,17 +1770,17 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 		}
 		links[i].cpus = pdm_dmic;
 		links[i].num_cpus = ARRAY_SIZE(pdm_dmic);
-		switch (drv_data->platform) {
-		case REMBRANDT:
+		switch (drv_data->acp_rev) {
+		case ACP_RMB_PCI_ID:
 			links[i].platforms = platform_rmb_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_rmb_component);
 			break;
-		case ACP63:
+		case ACP63_PCI_ID:
 			links[i].platforms = platform_acp63_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp63_component);
 			break;
-		case ACP70:
-		case ACP71:
+		case ACP70_PCI_ID:
+		case ACP71_PCI_ID:
 			links[i].platforms = platform_acp70_component;
 			links[i].num_platforms = ARRAY_SIZE(platform_acp70_component);
 			break;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 93d9e3886b7e..2b6b8b3e1b94 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -18,6 +18,8 @@
 #include <linux/module.h>
 #include <sound/soc.h>
 
+#include "acp_common.h"
+
 #define TDM_CHANNELS	8
 
 #define ACP_OPS(priv, cb)	((priv)->ops.cb)
@@ -78,6 +80,7 @@ struct acp_card_drvdata {
 	unsigned int dmic_codec_id;
 	unsigned int dai_fmt;
 	unsigned int platform;
+	unsigned int acp_rev;
 	struct clk *wclk;
 	struct clk *bclk;
 	struct acp_mach_ops ops;
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index f36750167fa2..49aadbadb7e1 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -94,6 +94,7 @@ static int acp_sof_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
 	const struct dmi_system_id *dmi_id;
 	struct acp_card_drvdata *acp_card_drvdata;
 	int ret;
@@ -116,6 +117,7 @@ static int acp_sof_probe(struct platform_device *pdev)
 	if (dmi_id && dmi_id->driver_data)
 		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
 
+	acp_card_drvdata->acp_rev = mach->mach_params.subsystem_rev;
 	ret = acp_sofdsp_dai_links_create(card);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to create DAI links\n");
diff --git a/sound/soc/amd/acp/acp_common.h b/sound/soc/amd/acp/acp_common.h
new file mode 100644
index 000000000000..f1ae88013f62
--- /dev/null
+++ b/sound/soc/amd/acp/acp_common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) 2024 Advanced Micro Devices, Inc. All rights reserved
+ */
+
+/*
+ * acp_common.h - acp common header file
+ */
+
+#ifndef __ACP_COMMON_H
+#define __ACP_COMMON_H
+
+#define ACP_RN_PCI_ID		0x01
+#define ACP_VANGOGH_PCI_ID	0x50
+#define ACP_RMB_PCI_ID		0x6F
+#define ACP63_PCI_ID		0x63
+#define ACP70_PCI_ID		0x70
+#define ACP71_PCI_ID		0x71
+
+#endif
-- 
2.34.1



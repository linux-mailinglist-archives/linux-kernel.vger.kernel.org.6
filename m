Return-Path: <linux-kernel+bounces-294973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989419594F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217631F21FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D420FA82;
	Wed, 21 Aug 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BO/zCZcE"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F7205E11;
	Wed, 21 Aug 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222833; cv=fail; b=p3bzFH/SGEDD71sSzvxccc8Y8hWRcTmAhyLhAXvit+b8fYprpOmEP/wMrxLGRwAkiB9ZVN0rXV4maelyMGHCD26WXa9ptr0R8bP7gn1x496llw6wvZslrz7Hdg+qDD4Hq25G5xqWuSnmNyxBfbGbKO7JzIBIJRG5QY0wS9NyRF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222833; c=relaxed/simple;
	bh=ieV+xBrhkWPYSpApUkwfDqYXotPUkyJV9b3CxxMkmO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5hVaWdebbaQ0N4+KAYX2ywBrGaW6mqGcCjlw77j46wLDvInFqMZSRR68RrrvSRQjfsaHRhmSgRNB3nmY/O8/mVd7w0dctAY9iPTMsjkOPdSPO+SnoUOwel6/gvqwV1WeEOyE88TCv/5Qsp/M3WkJdUA0lPtJx/OZR3r2QXC+tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BO/zCZcE; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGimCxElGtL5O9YEYsSntUuez+ILkQoibrlUOqx1CSA/n11SaS+KkXBFqHZx/b7HzwYhXCC4jr8LLBVkyGOpgwHv5N42ApCXflhFLvXcEZxiIZO2CbwgCyWqose8belyfqJU1ZSH0C9PHFbsv1JmxPzWzRK4Zo9O+vPFr3HumnATEz94oZVJJJDRU+mHrmGhniw+dFfsGsJ/l11C0IhbT8pfSw1JiCqmXf6Plxbrc5wCn4RNEmZLiEjQRB/V20mh7ToGwaZe5njFv1uImQoJ5MTYsdMFlEGitvDpt0C6SbBlMG9DxaarIv3hgQQyvqEftHO4cwfTOOL9LsSGUKpNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxkBInJSWtS/+2b8sbBeUAK9a3OMWSIdNo6kSvk5wFo=;
 b=s3z7Uss7lIrQNnyok5SrD0HTgNOs4fPJ/Y4bIdc1+h575gzrwaurJi8nfin05CGl1tHFEB7tYu+vbWHTGyfIqfAl+dB14gka1F3CayCPgCiOl70Rv38Z5TrCNZ+gfY1o163Gwi766X1MPKnk2AICK1RCo0efKXoOM+fWSfm6bykmpJJyDB7iaQvyDzlQbuYAXBZqweiT8Sw7KU3dDf56mpqv2QlwSMPlbw+gJE2KFUni2pPxu78uyuC+R7CcRFeLhubOd8wzMeAgwIw447Kcrl3Rmr8DasKkbGzT9BpTyAssc8K1fmFF1nhUSYcDKyAdeqf7Bo5wMReghaFVYBPawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxkBInJSWtS/+2b8sbBeUAK9a3OMWSIdNo6kSvk5wFo=;
 b=BO/zCZcEtyP3DVYjJoSltNHpJyGEv7W8RxzlgHX3yUrCEUfuM32/wrhqp8o7G6vJXSVyyXgg8K1PA5W04xcJTe/orK+ZRx9BKH+6dMNLWvrlkfG+MqbTbHxSmPMH0+yZpaFaiNVYwPig7kaiSz/uAO+AkjXp1Ggvii4X1xrbB/A=
Received: from BN1PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:e1::15)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 06:47:08 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::b3) by BN1PR12CA0010.outlook.office365.com
 (2603:10b6:408:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Wed, 21 Aug 2024 06:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 06:47:07 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 01:47:03 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <cristian.ciocaltea@collabora.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: SOF: amd: remove unused variable from sof_amd_acp_desc structure
Date: Wed, 21 Aug 2024 12:16:50 +0530
Message-ID: <20240821064650.2850310-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a72b80-ef03-43a3-4933-08dcc1ad135f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIePXeEmyD+ER/2vcI5hLEpHTJdHm3x8BxicVC+NHBk00pQYUVNQu+Q24HW2?=
 =?us-ascii?Q?qLd98aSRdO2es6MeUkTI/pr+EslonDShz4RTEp0DYoV/oNLOatDi7x6PTOPF?=
 =?us-ascii?Q?xOk1dToD7HujAq2StoH5L0feIJq5/USvsUvaevcqsknIuclqavfuZlYbvsVE?=
 =?us-ascii?Q?jnfzin73lQSkh01TKIQW3PBnkJJreAvDo04HPSTJNbqapsB/RqOY4qI5LzSz?=
 =?us-ascii?Q?8BWp0sgr5912HrXbQmXjNO5wYKAPrtIiZ17evxpTs/N4OcGVPxxPMEeRf4aK?=
 =?us-ascii?Q?0ePQpSF4Vu8i6Fow8DKqw16b6j/EwzcVpZCUyY1dSaguUMsG9UWIcSjLO2Db?=
 =?us-ascii?Q?uY45usoW62yDqPFl/Tfk0LHuKDDklEnoVHtyN7+BBp+eCcR+tu/oZDn3Jz8O?=
 =?us-ascii?Q?y1vbJM4T2HY39cKsDYEFPC72kGi9p3C7i9zAZOYcH3D7C92n3bjXWoh19sA0?=
 =?us-ascii?Q?sbUxLoQopf/ji5sYV0sWXLiMoV3cHkJbo6gNWHqxowuJb/kRL3TR2DkclL5v?=
 =?us-ascii?Q?FJz4wOdO/QQV/Z9BnYuv8hxejrqh/Dy70p8iCOc78NZPY+hj0ptiNdAkwO3a?=
 =?us-ascii?Q?tZDm9HN5O5girQcKOjEEPqFvLiiqbTiodESLrAgyrgW8yyKgRRt2UO8oLcXn?=
 =?us-ascii?Q?ARa8NMK4DD3n6SH6GeTTmEk9xQlGf5tMaNeOOQHWRfI8J0DFAAL89IRBCg0C?=
 =?us-ascii?Q?kGVh+7SE8Afve0g0oxg+ZcyfWY+64sBTbRgPsPpudc2bHNbBX9iJYPTXe3iy?=
 =?us-ascii?Q?LJxknYJRAIDQzNY5aTOi6BmKLmUJpmxqBdJQmGROUVQ7Sg+d5rhkRRntDikB?=
 =?us-ascii?Q?WnOor/yeHduHxY5WY+vnZLswp7STxNGc5yk8j/U/SLHf+kBKXyIWJL7SmgwW?=
 =?us-ascii?Q?zovGZTPpKBbOfyBOWJDX/XQsVmHFIGbNovJyYKN+G8QeJttY+q4CVcGYkf6P?=
 =?us-ascii?Q?++WqIyoIkynYPanERLdEo3Zah3LhopEIxVx9dxF8nBmR8w2ohpQxuNevA/pS?=
 =?us-ascii?Q?LWYRqsIuRJxGbL86yu9tMdA/4BoXLnbQc4EHm6DfOabG7eX7T0471Rij+TEa?=
 =?us-ascii?Q?ljc6vhnW92XnsDa8D3C+Bev4R+iq0i4FROPzTVTOXBp7q3+RPrAbOcgLOHXw?=
 =?us-ascii?Q?AiWpfsI+hPiVOOispEX3Yx+A/gl6OJSfz3wWQbRJHpC6i61cmM7aZoTU/7GC?=
 =?us-ascii?Q?TgufKXY6VXgjIPS12kbD0OVCcgSpY/+MGPzW0+0d23C8/rQbRdkTIYtSPXT6?=
 =?us-ascii?Q?BFj/0/VjU9Hxe0+yUpDR1AogEeg5l/RGBCyg5leCL64MsTfRIuIRKOZh5Y3/?=
 =?us-ascii?Q?tnXlI0dhv4O14p56VxVk6YOWrx2Q6CVR/4qk8YiTbWVe6p6DSHAv+gVPlLuD?=
 =?us-ascii?Q?qTFsJa6EUf9an6VZKkmm0ipfIms3ZWyEPQ9+HQPeEmTi64bHbIub/GQ6R9KH?=
 =?us-ascii?Q?hgJokvSlBR0dRlmGZpiexuEa50y5cspx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:47:07.7501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a72b80-ef03-43a3-4933-08dcc1ad135f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

Remove unused structure member 'rev' from sof_amd_acp_desc structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/amd/acp.h         | 1 -
 sound/soc/sof/amd/pci-acp63.c   | 1 -
 sound/soc/sof/amd/pci-rmb.c     | 1 -
 sound/soc/sof/amd/pci-rn.c      | 1 -
 sound/soc/sof/amd/pci-vangogh.c | 1 -
 5 files changed, 5 deletions(-)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 321c40cc6d50..11def07efc0f 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -190,7 +190,6 @@ struct acp_dsp_stream {
 };
 
 struct sof_amd_acp_desc {
-	unsigned int rev;
 	const char *name;
 	unsigned int host_bridge_id;
 	u32 pgfsm_base;
diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
index e90658ba2bd7..b54ed61b79ed 100644
--- a/sound/soc/sof/amd/pci-acp63.c
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -28,7 +28,6 @@
 #define ACP6x_REG_END			0x125C000
 
 static const struct sof_amd_acp_desc acp63_chip_info = {
-	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_ACP63,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
 	.ext_intr_enb = ACP6X_EXTERNAL_INTR_ENB,
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index a366f904e6f3..c45256bf4fda 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -28,7 +28,6 @@
 #define ACP6X_FUTURE_REG_ACLK_0	0x1854
 
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
-	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_RMB,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
 	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index 2b7c53470ce8..386a0f1e7ee0 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -28,7 +28,6 @@
 #define ACP3X_FUTURE_REG_ACLK_0	0x1860
 
 static const struct sof_amd_acp_desc renoir_chip_info = {
-	.rev		= 3,
 	.host_bridge_id = HOST_BRIDGE_CZN,
 	.pgfsm_base	= ACP3X_PGFSM_BASE,
 	.ext_intr_stat	= ACP3X_EXT_INTR_STAT,
diff --git a/sound/soc/sof/amd/pci-vangogh.c b/sound/soc/sof/amd/pci-vangogh.c
index eba580840100..cb845f81795e 100644
--- a/sound/soc/sof/amd/pci-vangogh.c
+++ b/sound/soc/sof/amd/pci-vangogh.c
@@ -26,7 +26,6 @@
 #define ACP5X_FUTURE_REG_ACLK_0 0x1864
 
 static const struct sof_amd_acp_desc vangogh_chip_info = {
-	.rev		= 5,
 	.name		= "vangogh",
 	.host_bridge_id = HOST_BRIDGE_VGH,
 	.pgfsm_base	= ACP5X_PGFSM_BASE,
-- 
2.34.1



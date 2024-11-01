Return-Path: <linux-kernel+bounces-391599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A39B891A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8B81F22BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CB13213E;
	Fri,  1 Nov 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SfIzoh1I"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E517C91;
	Fri,  1 Nov 2024 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427012; cv=fail; b=Sda2st2rwHXeS5QFNUnbTXilI0ILQqt6k4bmiSdQloifx6nfX/hO1GxmP+jQ0vPaJ1jXT2NOmZDK3/LT5+qqxTKYUdXI31ZbkjBQSkPeHSEEgyHR1bqq5NdeAj74dBCEFEDoym9U0r/GPW0RTqgghKBGiabWCchD5BkvzEQpCLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427012; c=relaxed/simple;
	bh=1NEo2JeNkkw4bbbA2yKGHx4O4VvcPKHkv8KnO4efVtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqWHpqcutsieSYX3a/eOfepc71sdMcRwhusOuEPLyuYXAG1ibTd97W4Ed33nyxv57svBKVOyj6KjAG9jshlNJOxdJAUQ0+L2pY+Itw9NE8NanVx9YEzEPNUai4WsxX4aaMg6J668Tf40Fq+YtgzAhbSphmSUtP2MG1NnsOSSYmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SfIzoh1I; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoOLNSa5MDZRw7PSaHneIgZteRL8iGFnNCkIiZE/mfXwXtnZvQ1pLuKHKtz7I5ofvsvfR1xttIGil8xbV/nfCP7vFH2smcCAPc9FRMh9gliPe3VVs3AYCvs+3/R2CIvLSjAHKlbwKacZi0tOvetDe3zhH2YDu9joid7NCtULsBbC8ZQKxka47TPJd6MYyUnpjrxMOYoWWUtWx7M1uZCb5XEn4v04VGXJDPlTeW456uMzjef7hNlbQW3EIcM26pgcbx38gMAPBIseNtRtpzDS5veN2SD6JcF8mf+EjMoBGUaNwCn+UgV2EkwPW+krBW8opxZzQpz7nPXKxjK4tyi17w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mPL9Dk4TIDb/iIakDcxkLGlLqgxV7OGgUh4obwrz68=;
 b=G2Y1kMM0bb3I8MBQyHmUV1z9Y1vv4+NF3p+SqquLhwEP3mCUHrp86OkupfF8uPuvfBgksEhYvM4yS/os/ihNUFz0seNUbJ9uu2OdHpDLQB4sLOONIaNrl60IkZXC001rPN47EsuTIG++besRld4AK+gHCzzHCDctjaGdyr6fWKSvsG9Q4ICjLJTEIC9t7rY7IAZbHQAazclpSZ633qPkuypJl8KRxYNLGex2+S4bNG+6eGvT63wYXfcWxAS+UtDAD3rHZtEkkEB2WBBs1mt5h6wdU2IcPIay2gEe5/vOtTSIpIAgFoMTcWZaFNs82uKcGuWs9vps4foj8ivleCOBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mPL9Dk4TIDb/iIakDcxkLGlLqgxV7OGgUh4obwrz68=;
 b=SfIzoh1I8KSKDJMWzvCEHPpXDJve3gZiuU1bSNLrLztRdD6hhEpDNnlnZ+ScdeHQmJRn/j+t6jg/UREjNFCspMEQgKiBE6RQ7QVG+kCJ2xWyZLqeQOb3GRxrxow/g5yB+wGFpPyS2ZXGYMM1btNFIw6++Fd4BHq8dQ598N8IqeU=
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 1 Nov
 2024 02:10:00 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::6b) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Fri, 1 Nov 2024 02:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 02:10:00 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 21:09:12 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<liam.r.girdwood@intel.com>
Subject: [PATCH 2/2] ASoC: sdw_utils: Update stream_name in dai_links structure
Date: Fri, 1 Nov 2024 07:38:02 +0530
Message-ID: <20241101020802.1103181-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101020802.1103181-1-Vijendar.Mukunda@amd.com>
References: <20241101020802.1103181-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc91d34-c129-400a-d2e4-08dcfa1a4a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLr1FhwhTdNStECJWAByL+PeEL20e2qRoij8EXSEi1SqDQLxCmmjc7d/Nczw?=
 =?us-ascii?Q?crLHkMK7sfDq0QU2JbKfeP09dnHS/D8LlkhuS9XdshrgcaPrfdvFafux63Uy?=
 =?us-ascii?Q?fpjeO9Zm9XnxSFusA74mhpPTolfw4rlbYCA8rSQnSm460WQTJnEfy0R8ok5z?=
 =?us-ascii?Q?5DGaEhSEpAUNPj8F7wmiSww0CMbhPD7y4A34hqv3HLUGwXCTwb4QQM5DEvm0?=
 =?us-ascii?Q?yGcmyr2PDxSAx5Hg9PAN3gp3SMIJuE8y//SSEp80rXGcTeROzYbqbqTCCJ9q?=
 =?us-ascii?Q?mbCYn33oTP5Q0I5ps4L/vJ1e69wZdQiKfkW6WhON361F5RyDWZH7L6oSuj7p?=
 =?us-ascii?Q?ZtdTHw/LDDEX4yp3Y/giG623csEls5KA52NRe+1fMr3gTcG0OdyTPsv9T1XZ?=
 =?us-ascii?Q?u/OMtBk/PldJjx1xLCndzbrPX9P8OQsE6gbxdAH0F9Nxoxnf956PmIX/W98g?=
 =?us-ascii?Q?rNiVpVkZ9XhVM5Tljknw1mAv4kyxs2drTKpyZwSXzNlHnS02naybGRWWe1ta?=
 =?us-ascii?Q?XlJoVMbfq3CDpdU8I6lQW19tNL0A0rzJNBbBKTDXopKkSuGGXDbOWN42x9HJ?=
 =?us-ascii?Q?QMw0CbUmedk95RLpvCyhvYWhcHy5va2DUTZHVHYhHHmhTSpOW1WkNXJ0lUVY?=
 =?us-ascii?Q?gdFIuuckmGnFbUXbt5DuCCpe0iMlhPR9QSG1kp1C6MbaK8wqOeSNtqg0vKGh?=
 =?us-ascii?Q?v/hc4SLujMCls2P+dzjIlAaDTP39pZxv2Wbvany8lH9tk87PhH/xgByY2htG?=
 =?us-ascii?Q?EiZuJsawyKYYc3f1vK5glkWJn5FiqdRoaL2pJ6GFDyzko1norYwH5IKPIgw+?=
 =?us-ascii?Q?Wzkqw/R1SEGrOQ3ivxyNg5yV6JYhO3SsxdUZehp6EFvFhDCz809dETniQ9O/?=
 =?us-ascii?Q?l7EpD5AgkCEN6XLXWAu5n10Yn6TlrRs4W9WXIXOickdnW6ElMdp9/qyKys0x?=
 =?us-ascii?Q?H1olXkDpXQC1rUBaAxxHZjthunm/kuu6ga7G+D5Fl4DPHTT5k2aHdo+p7eBv?=
 =?us-ascii?Q?0e7umSmiRV/+GmjBqa2RsxWyK7clrGHTANuPwnkBZqYIAIUDmlQ4Zb2RuU9b?=
 =?us-ascii?Q?X5MheEgoM6+TLIf/oHaTfEsKVtcXLlfkD+I4y9x9z8+y8HrEm6v45AvkxGf1?=
 =?us-ascii?Q?lXoegN3FIh/nioLlN0jGhf0eGprDeti4bTbaoRdQsbutVUhgRNtXjK1vMQAv?=
 =?us-ascii?Q?FYpcijBA59kCj54RVdDDrLir3jZKtZp3V9qSQJ+1kbZWh9FpOc01D/74n7SI?=
 =?us-ascii?Q?DZbWgN9MDmo07Kw0JXQ5qET7KJRAy9Q+ABLxQ1x7IACz7MwqOvLRcnUBP4Mg?=
 =?us-ascii?Q?usQ9JlFfZ9huwuKV8EUbseFGQ+geuqWQcVGyEIH0rpkSp1FEBDgdcUGeJx29?=
 =?us-ascii?Q?867NuWU9Ej8Key3DLI49hX0rtYukCzQLUtBL5y9lQpEElmYE2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:10:00.4033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc91d34-c129-400a-d2e4-08dcfa1a4a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889

For sof stack, dai_link->stream name will be assigned.
For legacy(No DSP enabled) stack, dai_link->stream name should be updated
explicitly. Update the stream_name in dai_link structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index e7f5938701ef..19bd02e2cd6d 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -1022,6 +1022,7 @@ void asoc_sdw_init_dai_link(struct device *dev, struct snd_soc_dai_link *dai_lin
 	dev_dbg(dev, "create dai link %s, id %d\n", name, *be_id);
 	dai_links->id = (*be_id)++;
 	dai_links->name = name;
+	dai_links->stream_name = name;
 	dai_links->platforms = platform_component;
 	dai_links->num_platforms = num_platforms;
 	dai_links->no_pcm = no_pcm;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-571225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69043A6BAA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9517A189680D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A7225788;
	Fri, 21 Mar 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PNDOtClu"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9C1EDA18;
	Fri, 21 Mar 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559919; cv=fail; b=SK8jTT8glcv0bGhZXs74M4hSLfBCoupWJB0IUF6u9OdgxKf1A1HTqs+wAXSX0QlK8xldorEwYnl5z1bziTvS3+szE49VjCc5aiPb3hNlUsgOXSrghBLcZb8bQkE86INRMVhZc+0zNgoKJt9/EwWU77BvTTHBkqxqqjm1isMQNAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559919; c=relaxed/simple;
	bh=oDXyojYWUzTcbcB6nyF9mXuA5DfaSFO8Y137CfwOnAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6sT9DUa7JhuKkT9C3/Y8gUgt4Re6enbhkd4xrYwTXJw9FomYAUyfb5vEvbepSbp3coeyejTE/SzFs2N4DvWmqEvCQh7ZkmnsMQS359WdBRAQBHKXkLwzaXvfUKE38BxKJMl/7mR9Mps33/TPIAQxZ38675qy3TQ/dz5Sn4Melg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNDOtClu; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhEU5BhqJTaaCY6mFt9KRe/uf+SM7delsZUAlnqhmw73vQDAvJFAX6AVZjCtf8CqABVFA/w378MtoRohHx2wI/yFGq4LMhzSy1V23CeQxPmenx9HWj+mVDmEbx3j2PMQsx5jNTBAX0U0Ja/xbbXxDpZb1IIa7TwL1E0RlUq+RPKvVBCYIlFMw/vAMKo7vg1xZvMIIrhJ35Uo/qqVk4WkIkj82f/2/ashezkgT5Y35aMd7zzOxZb0FckdOuqz1fLKGRolpnx2CeyezoGePLPWWxhF54Lvt/lmOirh+ozq/MFLlvgwKdmJQsIBywJm5PPoqWGejzX1y7PXz6xpLUAGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlTYkuIkcjhxAh5Qgtkrf76xhS/Oi2RfVujSTgYdDm8=;
 b=yHM/sezJ0AkokyjLOJ8xkysBIRqYRv7eDM1ZIvXIfdAdVScBSBEh6mwILv1m8q4MorwQF5k2nNKh3sxz2KZDeRevtzrZd77fG8OM2X/Q7QdOJwniyrBwMlZzu4us30LCyAydo9ht6XY2/i1Rxrw8H+6NB1sEevZSy5HIlH4PNypWxegHLG9OrQ+ohTswW3WYIH38HtqV/IZUb6opNRF4rHIhdukGF883Xkbonl8BGWKIQcqXrOOKVJ+2YswagXup3hFB052UzT/yIwWWAuLCuT5gRec9s42i9M+HsY2MbvoHnd0dXPN0vYJiTquhcTAR8tQpSfrFQtEGnIT8Hg5Qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlTYkuIkcjhxAh5Qgtkrf76xhS/Oi2RfVujSTgYdDm8=;
 b=PNDOtClulobBs373dP+c1M77N0MT5rmrYmzbswNF/Oidpx03kEqTNmC3TDuqOAQRpnU4KYFTrJjGTDy+F73HKgLRJffwoFBv6Yqydc2S7LLAK5svn1ZnrJcEs/QVjoNMBjx77+fIEyILa6oDTemG0B55P2aSqV08z9XfKSz72Ms=
Received: from BN0PR04CA0148.namprd04.prod.outlook.com (2603:10b6:408:ed::33)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 12:25:13 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::f8) by BN0PR04CA0148.outlook.office365.com
 (2603:10b6:408:ed::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 12:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Fri, 21 Mar 2025 12:25:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 07:25:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 07:25:11 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Mar 2025 07:25:08 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, Syed Saba kareem <syed.sabakareem@amd.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, end.to.start <end.to.start@mail.ru>, "open list:SOUND
 - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: update quirk data for new Lenovo model
Date: Fri, 21 Mar 2025 17:55:03 +0530
Message-ID: <20250321122507.190193-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: f04bc40b-d556-41d3-0b4a-08dd68736da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ycVFm0MxMKmAHbBrKu39qds4SWpS8JNvn8SsTkjJxGP+ePQmpqkVT2qZFRzN?=
 =?us-ascii?Q?PV2gJjm+sNUpeXvHpIvuIFW4eVQ2W0y+GnK5rVTqAC7WwS8i6SPd73w6QO59?=
 =?us-ascii?Q?W6w6c10ApK7XLWATOhlf16Sw6nMeP7vlg8HeLmy5SNpct7NQ4of4/iAszUWG?=
 =?us-ascii?Q?6ttttZTCKWq5KzzsbcRM9yVdGJE+0+KUSo1ZXjqlqaCr7+0z9jJjacnO4IzR?=
 =?us-ascii?Q?q3C681V2ITldjSEmMi/cMiy2d1oibU9ak3kl0xJ1vnvACw8aZV+Wm/63gV6L?=
 =?us-ascii?Q?4NOmJWpaI9DHpWBcMDUnTLnVXE5ddlNqlAFmTIdCHYey7Z6HqN0wdxiaHRq9?=
 =?us-ascii?Q?Q8t3ySM10HplBSbv4OMc7oNQaW3jITkz+qvxqH/JBvJcW38og9PSTqTXo9gr?=
 =?us-ascii?Q?u/SB80p8aVdp51Vd4lKONGQC4j00rxxPCumcZ7oSy2Ytzv9htuZaINqRDSLg?=
 =?us-ascii?Q?Xx13lSWwFSfTtXkGPhG3fbHruwdVs5CsT38YbloKL0EmesZKsJwbd7igYv8e?=
 =?us-ascii?Q?APODoM2fHnCBnhLeHcutpUsW4+dM70q5DSfmbmqbNHzYezqQERid8WEv5x9g?=
 =?us-ascii?Q?VRqcj5d19KX8ACiT2BOLG5dbYrSquTiHNVKWuBFrIYc6KueZH6oi6GU9DG9V?=
 =?us-ascii?Q?Oy2J4fQSsp0OGixJxr/FBmE5nC578RLzVfsPeNm+MOcS8GHBdDAP0Ic/n2zv?=
 =?us-ascii?Q?sGdGMWGYXJM3U6gf5AucGSwi3Q/A/F0tY8aoZHDRIoKn8vUchcGfMx/iI+1P?=
 =?us-ascii?Q?wjXEISF/WOTSi0p4cqOY3hyF5TSIPGyWY36V0NQzn4/4EbFU2DLu9W7I9Uio?=
 =?us-ascii?Q?CC0RX3UVWqh4LXFU/EMCdjW9ji7s3Dtkygt8wejUV16Arj25joBkIzu9Vhup?=
 =?us-ascii?Q?8fs5aNcpkS2DzKwgnx8N+F8yQu+18aPIB5J4hM1eBch1XojPhEr60/Wehxtz?=
 =?us-ascii?Q?NrrW6+JE6fuhx3W3BWDTmfDmoj1DwKoViAFzdC+RjDAyyN3/eAHJ+kgKydgK?=
 =?us-ascii?Q?ThhP1+EVCMrAFeBclGTnQUI9yFWAnQ02CS3yDFCZoTbYZLIr8YedTy9fFdDl?=
 =?us-ascii?Q?ud3OdkVz5dckEwCPnrqpkwofmBvYV5UFoCH0NUrkp2GhD/m9R9va2V+zwp5m?=
 =?us-ascii?Q?MjYdftOq7Yf83yrFp/IPXdpArmqS9Qk72Mp+Mdzq5isEXdd3cbVQ/yuJAJxE?=
 =?us-ascii?Q?LAHPXhqa9jAxeQWgAkUbudUw1VwiYk8pseYMtmuDRAsagofy0cRbxNUuFlwf?=
 =?us-ascii?Q?CrWZKO3QjCRQac/FEjxFaBjFwxGZGfXLl3XTbhhr18xyVdPJkWP6pCVuRd+A?=
 =?us-ascii?Q?8Dh7/mqEUWjYJuf0eEazowfXToq5j54NO6umUE2GNXy0kKeyOMIRv7GOk6N1?=
 =?us-ascii?Q?wQFOoBm0oUzwtDpjQyET7/hqRm7Tfxa2O/vFdKcdWMvXcjinXUu0k8XwFLlz?=
 =?us-ascii?Q?HUeS9uTq9hqHyoN/9wTGsgyFDi2TEwc5vqHOKjZCFW+cgyN2eP3daVedOuoU?=
 =?us-ascii?Q?Gf2v2K9b0Zn3Xbk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:25:12.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04bc40b-d556-41d3-0b4a-08dd68736da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

From: Syed Saba kareem <syed.sabakareem@amd.com>

Update Quirk data for new Lenovo model 83J2 for YC platform.

Signed-off-by: Syed Saba kareem <syed.sabakareem@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index bd3808f98ec9..e632f16c9102 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0



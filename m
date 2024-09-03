Return-Path: <linux-kernel+bounces-312821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD15969C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39361C23054
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F631C9875;
	Tue,  3 Sep 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WR4ngTzs"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2571A42DB;
	Tue,  3 Sep 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363412; cv=fail; b=dJxeKogxxvk1KEYEviIOyyUz1Gko+11TJeC8s+lSzmVw7QV+uAL6khj+yUKkTDNqJKitZlSVTGzOFUSQxmPvT24LNBINJwnIIF5IIPfehRKLV47+XZabBF+n9rWPMZBtdWU3iYdm3RbDpNrAH/vwOvh2YUdkiMnNNaOjtz9LP0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363412; c=relaxed/simple;
	bh=D4/60wdl5MYHUC1HEvie8mMe6F4I8EbBdJvUH5BWzjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee2N8kBhYAyVeltnWTwX1Mu3dZ8NfjhN7Uj5NuFQr3cyhq8N3OZTwwPnp+FqM0hbrRI9n76kIq5l7Sbfx3A6pr1s3fmIguotDCynfGSEOG6p2+Y5/v7EaJ/l7npl9BvT/9Q7IevJv3ITFRlY9wUYHvUy9INOIYnZX0WWvJYupVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WR4ngTzs; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zr+V0u1/wQ+JyjVt4iVk9fj5vGg3XZNq0dk7jrxBx8AdFtL/qYpTrQwN6u4zGz9sV3GUyNYkWGclv8tZXqyZB/Y6aRSzGlIDCcFbRCQ0UsiiT7KyzipirrdfFi+TtcD53odk1rq1cmMaRUUDSGjUo+7z1svb1736xr1cL3uR7yI68z5/Dmm63GmNKjkiCogQOa5PkMvADyP7JSsuOcOportAkvvY0UktUAUPwupV5dsgvc4x+LuSY3ksUmp+2Z2g5D7Jgtzu82MLCKA+Ci2EAGAAqQ9nXOOQEzIbDyNIEuGt0q6lFNS78y1qgEmhn8lg/7Y0pWa0FEseADPiplxipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWeHSh2dEBZeaGcX1AZKhHMVfLYfNA2BXhFheHpAFMw=;
 b=Zfl7/be0G+Sfl7xclKaQ5V4LkhZBy0UGcBtJ/ON1En/Qp5FOnIdT7dyNEjgjdF3TuZSciCCrHzMGLLo5yh+VeqpUwr6hmBZ2KVKH9ReIf+euH7KuYsI5k33JH9M+Jf9oT2Q5LqjtdjlghUz6Tv+PeuiT1ib34XNK4ZZPSqg+C5gW3HumDVHTKLGqi1+JpMVGTSyj7dbRpN58ISfnwQgcFXJuOzY/RPGB8vMOya7nGz8BmPwi/OAcs6YtiagdHNqqCP4NWPL5lkp/ftPsu2/UEuJ4EQvW2nPNpNtUX5D7EjT7jKiazi5T6zGMpRX+P2XH90NtMDeaLa4IB6ZwdruX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWeHSh2dEBZeaGcX1AZKhHMVfLYfNA2BXhFheHpAFMw=;
 b=WR4ngTzsXWRHdv4YPv2efK4w1gf8VWaIhe1UNxk5YSe56JgrOvBpg574D8GOhOVg+yrnclBA3JsWWKIaNAMo9yYk917GoDGq+I00MT8FgX4QOqa7QIv3aX9zZHP1SOgvw/Nwj3NZX8IvMLk16srX2L6WqgYPeQZk+I0n0Clki3Y=
Received: from BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 11:36:44 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3e) by BY5PR04CA0022.outlook.office365.com
 (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 11:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:36:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:36:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:36:42 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:36:34 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/12] ASoC: amd: acp: Add i2s  master clock generation support for acp7.1 platform
Date: Tue, 3 Sep 2024 17:04:26 +0530
Message-ID: <20240903113427.182997-12-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
References: <20240903113427.182997-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 37be0f11-6928-4420-a058-08dccc0cafbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4NXNsLxh4c/n1g9Yq+xkNKG96gGEOYuDKiSYUyjzVaIv4GO9vXOzKDQyzBHC?=
 =?us-ascii?Q?xkwgTc8LL3GFOCCWJ5Xkd+2RtNcXTDiXONVDttxR1b24YcvZNMlp7hznxJLd?=
 =?us-ascii?Q?K5imKtS3pjpgyGLr8KN7svzDLlcprzwksRwr2lXykNg2zslrZsiX+c+oUHl1?=
 =?us-ascii?Q?4sWC/bbe2mV3IxyzbgPR0m25NEDMrUUxgFx8Vx6P3L67e3VK1fIZVUecJ+0X?=
 =?us-ascii?Q?D3qVAKEwr41UbU63gYLMBI/fSiMG8fwusQncHKJkNSYw0MNwusQOo9Dea0ML?=
 =?us-ascii?Q?sF5rtLrAzqII4kN3x7+GlpgIyMuYorwyUVS7xGRQnnJq0SZjTm/+8aYfveT1?=
 =?us-ascii?Q?NSD0w7QASvZMy/2JbVAya9SrCP1Gf6skh8x4Tiuxo8vPXiWtN2xbzTsgoRBc?=
 =?us-ascii?Q?5nX7MgFBk+ewFHKL1/iUMGzC/cTj5Lc1ibL1h/ETqPMFOyQhgxmoggu6dOCv?=
 =?us-ascii?Q?VmsAMZyM+JY/jIynpBj6FUC2Y5MmdnZ0QO4KzHB6X/KugpIvUTxjIbjWV9Vd?=
 =?us-ascii?Q?lQxJijjFN4jf+ycWNZrqTOvgQR6nsLld/lnjzL5xzFwayOmoitspGsR/exhn?=
 =?us-ascii?Q?WhIM3PJbQ3RXIYDfnJdOX1m2pFt85CVvxQftIVXtye97a1wKBS9ZaqXCxQJ1?=
 =?us-ascii?Q?5fx8ucEwSbtnVqoJEUvZEPxG0Oj0owBR+gbiJ1PjD+IoZwVy/Dw1pP06TYCh?=
 =?us-ascii?Q?icr60IIGJtt1TDzayVBKoozeQ90sIvX+AbNtKBrYLukfWxDOlCqAR8/lIxcY?=
 =?us-ascii?Q?UiLsy9e5MHr73ag49broyNH8kjuU98CI5tMUWDsuz/ex5Vz919hdNy09kuDp?=
 =?us-ascii?Q?GWshmYxG+vVcBg/YxJQnz2cNmR6M3OnJz0DuK4tobgZ0QWBP2WtC8b+USQ7A?=
 =?us-ascii?Q?lxk19ZJEC9pArgxBAArR7DBS6wDJ2QmLA8KCGdkHvT5sDFZ9iNtA5n3y52Wx?=
 =?us-ascii?Q?C2IT3hZG7MoQ2+RN+LJBCxQjMSOfLhNQgj4RP19VZU1PNNCaxa6kpHj2cND9?=
 =?us-ascii?Q?AxiL1qo9OujUdnoKKKj57EKtw85/dJp2FibFKWQKJtGvVe5r7AEyq6D2LK9T?=
 =?us-ascii?Q?PTw6CcVPhETYq3m2M3WIG9UpO1x8O2tYL64I3r5iOxrSq+7VL1PIG11j32EX?=
 =?us-ascii?Q?p70bJNAyEGOAtavYHxV6q9PydYFg8HHKvr5RW+JRefiB4Du9RqDzIG15hpvF?=
 =?us-ascii?Q?ik/L636G/6+omM1PPnmYN7YXWoXnWP+2FFutBlMqDmFsbITpVq0w0K4+oO9v?=
 =?us-ascii?Q?84m5xrpkS4iVsfT2PtXSyzcbh+r9bfNrD8qZbAONPAvn1y5U3W548+nwIX3L?=
 =?us-ascii?Q?XYZVFtBnxyrdS/uB5DyzdbEfFhoepWZgu5eX8XIvfyHi7fcZjDIBTTE4cS17?=
 =?us-ascii?Q?Dj/CT4yG5cV/8FWxGm3bdOOUvbn4Ait/skRTwUjh9UoEL73HOa6+MoGNRTYy?=
 =?us-ascii?Q?isMZvul2y2kwFZTCqxhdGLsYxfbEhola?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:36:43.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37be0f11-6928-4420-a058-08dccc0cafbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Add i2s master generation support for acp7.1 platform based on pci device
id.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp70.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 3b3bd15964fc..1b0b59a22924 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -140,8 +140,17 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 static int acp70_i2s_master_clock_generate(struct acp_dev_data *adata)
 {
 	struct pci_dev *smn_dev;
+	u32 device_id;
+
+	if (adata->platform == ACP70)
+		device_id = 0x1507;
+	else if (adata->platform == ACP71)
+		device_id = 0x1122;
+	else
+		return -ENODEV;
+
+	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, device_id, NULL);
 
-	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1507, NULL);
 	if (!smn_dev)
 		return -ENODEV;
 
-- 
2.39.2



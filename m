Return-Path: <linux-kernel+bounces-312814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9FC969BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4F9B22F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5E1AD254;
	Tue,  3 Sep 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVg9Gr64"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A103195;
	Tue,  3 Sep 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363343; cv=fail; b=o6GrtNrylGUojhKLrtfSsfkFDlMSHe0Z95LnEfOUnNIcgLxIH2zq/DsvvEeXKNSMuwx9l4kPT2rvedtHGOHoKAoQRpmnUKdlu8LKO+4CaWHzayIm+BFD7B3dZ6EjKqq0ilEr45WqGyGBJvGqTIbYuWYYoGF4jp/XwHMzCCi8W38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363343; c=relaxed/simple;
	bh=Huad3TQLOXUYSI5yA4//wXmmG+/q33HbF2TTLxTwJ1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlslOWRHqzGxKKGlN10Nl9geQ3D9OQHgithWVHUWHkG2g70Mn53wiMx5xCOb6KAbEq9hzv0/kQd63Yz8+HfpZ6Biow7o/J3AMUukBnMpJVJwlXod5jgrVNmghk808IH98pxUv8rGUE8ZVgZsV2Of+dy8UYCxXKVRzBAnrjGu54E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVg9Gr64; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On+EVU8RXIgymbu4ueUuJytM5EuCxDj+1kGPb85qgUjtxG/18Q85CgVo0Awwb5qjGH4zqO0kbfhwgMEEnOhpYnF2mIeh0uubXE+NtQLVTf56B/5+/8gYlOeRoOpWBrWHfLy7pWs5GOixBvWGu0i6yIRksCBAHCR8A1biZgZ/3QrjcNDjrYCmSnAK7dOUz0NMMd/gLA03f9OWuWIVpa78BQKwhjH4heK9PI8fBbhcXWY44H+GWfp6vmosL7taXl3i+Jwii6q73ozxslpF2Yt6GK6ku+ZIKzWFqWwDILVufnTie11RmjsK/V2xrKcNlMwWoAYKNVF4tu7PXoRMdR9VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fAzt+/f40TIpGIbhOZZzgwC0/W+Uqe1jVQX0hP95cg=;
 b=DNey3+FNlZV7xxmOO14hrlNtZrjPYgG9DtRR+0E4ykTgfafSWsXdhhvjgIU4F2L25vSNmtJ23NSDrjeiIiNTs5Qp3wRuW5nmFxal+1aaEbxhZKwixR+NGWiqIxGUGdpXkeu1U7xyr1/ZkuxU93Om6fdTHpQxFZjpLSJ+jYAk1baQvJ5m/sCkkowxQpjfMgkBpJR6j5rAu6FQ4FqCnhktAReanELMN7eF/xog7zQT2oKyW0CGD5Ov3aJvenwfRbk7GTAp/fgwbGDCtHUaSCs/3f/Z9IFU6ZOAiJNldmYiLs/ThKozR6B5iIZB3HHqurk5Rkz5MGHCtV+p/i8kZw1obQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fAzt+/f40TIpGIbhOZZzgwC0/W+Uqe1jVQX0hP95cg=;
 b=LVg9Gr642le2Dl0l3xto9gi4pJJv62Jza78wFB/AjtzWWYRjrl3+7hEIOXfj3zAmKTckBeEbGLi1fJcDahMrg6jeXBlQLwaDZLosR7Jd9bgC9GRV1Tq21ZqZiznNJjesOSB/h7l1ZtTOkXICOZB8iVn5KXIh/JyhVakpMuE8O0w=
Received: from DS7PR03CA0359.namprd03.prod.outlook.com (2603:10b6:8:55::35) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 11:35:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::47) by DS7PR03CA0359.outlook.office365.com
 (2603:10b6:8:55::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Tue, 3 Sep 2024 11:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:35:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:35:38 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:35:29 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, "Syed Saba Kareem" <Syed.SabaKareem@amd.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] ASoC: amd: acp: Add I2S master clock generation support for acp7.0 platform
Date: Tue, 3 Sep 2024 17:04:21 +0530
Message-ID: <20240903113427.182997-7-venkataprasad.potturu@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc85768-41f6-4404-f485-08dccc0c8907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8A0kEL1S9wJJhd4s6wOh6Mt5lVYnz2MBkhcHTDgb5TcOCSthszWj3wFgmDS?=
 =?us-ascii?Q?tnhhfhbs5S4Q90mSfyurbYlHVUQ5AiiKdJd64nIIgvtoo4/eLkEt0K1y/g9Z?=
 =?us-ascii?Q?cxCVtudVbdvzN0VjJpmVBdlJLoHaCYUuE8aokykJLSSo743SJWLnQZRvr+KM?=
 =?us-ascii?Q?XLmooJIkYRL9qMWmmyn65GMw+nXxZo+B+TylemWwVcWI/rbp6i/y9+1kAWOg?=
 =?us-ascii?Q?ZBdLTeTyrHMNLeZ2t3ppm73dLhSBewfoeR3DEZf9Wo04dllfJXHlDDeD1kAx?=
 =?us-ascii?Q?Uk6og8GH/bgjNHdZpaDoGMqPjFq+MhpBGrv62kdBO7AIjB4fjkch8tU860rE?=
 =?us-ascii?Q?1B5JxQNHZny7p/j1pPdfVTumH38Uj3Eu7LXH9TVlyL7lBu4pHecLdVG2xTC8?=
 =?us-ascii?Q?Yczw8AtxicBihdcTQuBpuyCjyDblU3192YHJvWIfONwY9/sJxo2Zw4dOmgVv?=
 =?us-ascii?Q?2VKWCf0xxOsRfDwYMPnnV4DhsmmOYLI03MT84osox8AoFqI31m+zL5YPO73E?=
 =?us-ascii?Q?1jIkgrtrZRCbwulJPeftOiVrKJwYcFHyc/BGvl5dYQI+gP7dwyX3e7Ld73e9?=
 =?us-ascii?Q?Sb4TyIcM3oMian1XP4WAb3XTOdJ7SCTu+QNJZw/R7l6Mkreq+kIDcRv9rXUe?=
 =?us-ascii?Q?QkbyNXhZ+U3wEl97M7pDdurXHYc7sgq1WiVYXrnoflzJsMiCIMkDZRm3enK1?=
 =?us-ascii?Q?pAM8sp9l8rqNL0ytwIX+G6EyrGOgj/UVotFH6zkbyxd5XpHTISQmevj/lWjg?=
 =?us-ascii?Q?jY7tSJJ0k4iiT56rHb7gasxX0XfX8Vbk7Ef3KamNx9CGWzG//WTmdPdwmOhE?=
 =?us-ascii?Q?4JzZpELXk7t0hHYkM4CEmZ29Z5kC6mDrLExlPD3N3mKa0yFPKbDfZaSKAPl6?=
 =?us-ascii?Q?z8EDLOnC9+H/it6HwTYyXUGyChyNXu1f6A+8SgXp1BvaQD+6/Y1GfDCEMSSf?=
 =?us-ascii?Q?sKweLjs1d/yDywOb9XGioUu7Tta+7donk9XsGT7rxfoW6IsTWfr1jsAd+/ID?=
 =?us-ascii?Q?V6v3DC5UbFyrY0dRT/wVzaG82CXkkGDOWhJw/MF9mx24BQ2/dqmUfaZ/DQn7?=
 =?us-ascii?Q?kwDNPmMIqV55gzMpupjQiDyUpyim7SRffRXIjme2j9Dj9abLxFw9vGYm9uJe?=
 =?us-ascii?Q?FKdEQCo2LclNkUZGRszOy+iLpikfTXxfyMrr3HVB3zyBHaw54yRhLFcGkm/G?=
 =?us-ascii?Q?q76+3295XqJEtHsrZDsC8ILcKlXRwLzL4qu8FkqYiOYn4YhmU8+2vJxQ9Bwj?=
 =?us-ascii?Q?LTcWCmleT537OMlt+/jp2XP4IKMlAFA2nZ8pVTMgv0xCNtxFSfTM2ckJW1YT?=
 =?us-ascii?Q?/BdLGNYGvOp+EIG1XNAzqpOzrRrX90XE87uWlykJdFT71zfd60ax6L8YXsDm?=
 =?us-ascii?Q?HKzl4vqSN2DDsXjf2C5buafSUlDXO0dlb9LC5Zln7dMGvdIi8UPqQOG38I/5?=
 =?us-ascii?Q?MupEr2CN+tUS7ufALMPmVKbR3jaiBPNY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:35:38.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc85768-41f6-4404-f485-08dccc0c8907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

Add I2S master clock generation support for acp7.0 platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp70.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 81636faa22cd..a9be059889b7 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -25,6 +25,9 @@
 
 #define DRV_NAME "acp_asoc_acp70"
 
+#define CLK7_CLK0_DFS_CNTL_N1		0X0006C1A4
+#define CLK0_DIVIDER			0X19
+
 static struct acp_resource rsrc = {
 	.offset = 0,
 	.no_of_ctrls = 2,
@@ -134,12 +137,27 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 },
 };
 
+static int acp70_i2s_master_clock_generate(struct acp_dev_data *adata)
+{
+	struct pci_dev *smn_dev;
+
+	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x1507, NULL);
+	if (!smn_dev)
+		return -ENODEV;
+
+	/* Set clk7 DFS clock divider register value to get mclk as 196.608MHz*/
+	smn_write(smn_dev, CLK7_CLK0_DFS_CNTL_N1, CLK0_DIVIDER);
+
+	return 0;
+}
+
 static int acp_acp70_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acp_chip_info *chip;
 	struct acp_dev_data *adata;
 	struct resource *res;
+	int ret;
 
 	chip = dev_get_platdata(&pdev->dev);
 	if (!chip || !chip->base) {
@@ -191,6 +209,12 @@ static int acp_acp70_audio_probe(struct platform_device *pdev)
 	acp_machine_select(adata);
 
 	dev_set_drvdata(dev, adata);
+
+	ret = acp70_i2s_master_clock_generate(adata);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to set I2S master clock as 196.608MHz\n");
+		return ret;
+	}
 	acp_enable_interrupts(adata);
 	acp_platform_register(dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
-- 
2.39.2



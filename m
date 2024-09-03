Return-Path: <linux-kernel+bounces-312817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC83969C02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603861F245F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2F31A0BE3;
	Tue,  3 Sep 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FFxyAHPD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F21B9832;
	Tue,  3 Sep 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363368; cv=fail; b=bYKf+CTJlctROWKs9PpupiO/EVzUVJiWk8g4/Ojbe9RAdm5ltW1Yt82RkI9SVAqA+5XQxNQEx46gRw4VZ1YaPp+W5jI6bDB/FFKisCFZ72UMrCGnJaXJgPSjIK935yhoIaGib3poTjv8+4F7a8UH08ywiHrQv/Aqh2fNeZMmWAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363368; c=relaxed/simple;
	bh=8jj3hGlDpc8xvEB4oNd2pNtRgH40vcvlsLeOhWwYHcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWv1D/CI/+txLdqZ0xgFP5atUfAxzT8f6hw8gLM1ok+Pfk+hyruRg2blBOXLpMnssdW8EpEA7uofk3fWKqJTbf+f8W6OaDBaRKkhRDgNi1qS/ikgNjH59exy+47YywBtnpox1R21oqEmaGFKW8nvCaB+PT9xhtn5q1LAwbfxqlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FFxyAHPD; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpvavyQsF6sAM127lvU+lLRjHrEIy4Vb5qV6ueLWKvP85Lhb7Wmg5gZU04SuIwdzXqcHAvY4567p4nfef/jr4U7ZHW4C2nmb1OHbzBu/nqCt2Xgq6fQcHEzGAWxUCzOI735J2VkohTfruz4nYZ/QVF2BFqwFJmizqDc2OU4Cx8MjsicBsaV89uQqYmgpFJ9s2GgEekQRpy86OD1iNkS2h/PzLOdP92na5TF1X8wGIiCrq2ti7gOMR4cYdLe0VTfpopRczddjoziTMBwvLpkfISIwN3XOnhx9spsDaVTfKlMVzShYn1rRboyZ6AoFb7nJFKg1Dr0mwA2rUMt+4nAEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgRp37pmD/yGMBYex1nMEZ3AFNDx0Sl/Mcav039Q0Yg=;
 b=xChw0nVfXJqb9FDQQXc4RwaVYobqaXU/qA7lHQIRUohPINbecQbSVGMxmYDuSAQnFfnpPvB9Pz/2FQLxBilNdinieTn5Nkm7OJSvMAiXPtLVVQoSSHo5BR7eJtHUZkusx0pD/W41CEWftswOq04pjcEeAoJa1v6uC1CY7FLmP4SlhK3xTuvdI7/N9kSyKD5oPxwnAssQpjquDY3mYoM8rJUyNOdcC9ke9XvQir6A5KosoRvTFFKEik8coqNpQORkY7cy57kw0djsUmIz/nN6JoUp4sQTqNe8RKAL0/aPmq+NyDJh47O1A1xMawK41anRmCmyGMLOnljCwOklEw91JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgRp37pmD/yGMBYex1nMEZ3AFNDx0Sl/Mcav039Q0Yg=;
 b=FFxyAHPDYuJ1fOkJXYtxhZzxGA/iSPaXK58RwFnA4TEzXJtIH3aeM1Bsas6E5/p5EMqyUDg0KaQgIPXUOKSykInW6+Har/Qx8pjMMCdTtpoLSGNLTJDedHx9f9JcDXSsS2fJhAMBRqCPq0wkw/Oq9q4QeJNsiBSjHC+TvwVS3LE=
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 11:36:02 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::31) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Tue, 3 Sep 2024 11:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:36:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:36:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:36:01 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:35:52 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/12] ASoC: amd: acp: Modify max channels and sample rate support for acp70 dai driver
Date: Tue, 3 Sep 2024 17:04:23 +0530
Message-ID: <20240903113427.182997-9-venkataprasad.potturu@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: venkataprasad.potturu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: cd108cb2-98cf-473a-9d74-08dccc0c96ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOdvk17WGEgruvUo/Bi9BPVT8DdX8ktH+hU8X3XMoz2kSTxtJTg/a7Q2KTNW?=
 =?us-ascii?Q?w175SWo0dOltyO4E/7d7ah0ehbs0OMQVLp5yEoNAVMP92s2oB6hN3RJpK0C3?=
 =?us-ascii?Q?jrQRde8OtGsDELxQDgOoDqDyZkJXm31pDuDFfb3GndBU2sh71mK9iwcB6fMc?=
 =?us-ascii?Q?R3daaSm5uHGn9OOZnvcAyLqA5IBtgTorhXqCaXK4nKCNK+kfw/3HyehtPm6C?=
 =?us-ascii?Q?UtDv9Ceb1HhUfCKtnOb7XF2Ijlj800mCvWcMW23ahIj48pGrPXnienNaPkKI?=
 =?us-ascii?Q?I0NeHM0uypG5Co4q3AHGCHhU+urklfKqTsJH3yhRv85mXaiwW+rZhlkKafml?=
 =?us-ascii?Q?JYAPq/yvgTQrkLew8l87dONzcnBY7kjV7aQuo5ob5Qz9SxxqRVBHsXDoMcR6?=
 =?us-ascii?Q?yPJIwICPKSNrwgVJxdyKJME2eX3nZ1UjcTCZ6dRJRuC/f06w3CrEwRG20MRQ?=
 =?us-ascii?Q?uwonTnfOziLtreFSUVo/ORCynM8+re1sjRaSQvGWtvpQNkwpmI3is72UAR28?=
 =?us-ascii?Q?kYRSLkpf2zOOYOP2COeG8o+RonlQkS1RCcEwJtuI9d1lZvB5ZuD2O2q0Ecl8?=
 =?us-ascii?Q?P6If519zb5+H4R4OZF6NKj+IyYBbm0/EtUUHxKiN6arBJqzAZlzwlF0e0C9K?=
 =?us-ascii?Q?HokhCgNKn7R7lWpc55AL9iRfb6+oqZbFQ9/LVbWfBQaFUJTBU7+121d3Plsy?=
 =?us-ascii?Q?Cd5j4KjqinFV83NbufQJy8gUUaW+JIMB/RX1zfdR31wO/6aMQ/VweOUW9Pio?=
 =?us-ascii?Q?L2cyuVS37dhQs2k+9EZmvJ4l5mJJAoPNwUmFBbFBYEtHIp8PbjT+nmLfnm0s?=
 =?us-ascii?Q?v4Jtq/uxDG3PLbWq6dbPUQA7+VBgqxeI2XNm172eLZLWuOano6422xpMpRns?=
 =?us-ascii?Q?7xlSFoocC8aYehnbo/eyD2PeodPTSx00ZeoCW9uPMz6QISWGv6iTELjn8MEW?=
 =?us-ascii?Q?7S2nDb4DiQnchzFcBpFx/ahaNTYknBYlVLb1Oua6G93mB1+FsUtv9CCXRg+3?=
 =?us-ascii?Q?A1EG+oYtRZWOSgkyQslJH3AgXAuI/vIV3uiJ+Ezic8fl9DuFpfbeywyW7Grn?=
 =?us-ascii?Q?BQLutcjVnTd8/iBYQktk/TaSk3JNNVP9sCbV7YfDsQqjLqwVEbtf4hcY7HbZ?=
 =?us-ascii?Q?72gsNnhwyefMg+hZn3B2kb8jcyEipqanMCBoNq7uEkkGFmRAv89mZoz8pEiL?=
 =?us-ascii?Q?epzuY3mDpHsWYq3K4Np+BrgDxt3/+640eP98D4PMMn6e2oTxFy91trpBo7aF?=
 =?us-ascii?Q?L1w29dwtqv+vqLeD4W/SRH2Kpeg0aMbqiwaGFNrG6bug1xYA9C8ZJsTJP2Ui?=
 =?us-ascii?Q?b1WW+QJTOzrObvf3YPt6056xv5wBqQgEtpd+0r63O7ha8TIt7X0g49e0zQzj?=
 =?us-ascii?Q?1aGUSQVL4TT23r8dqwJFFxeFTwmdNdQyGoKE/OTJh/jZ7IeDfT9IF/V+Hv+V?=
 =?us-ascii?Q?jAQZxHZvToxheXhJsjgYG5rRfzTqi4UC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:36:02.1837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd108cb2-98cf-473a-9d74-08dccc0c96ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010

Modify max channels and max sample rate support in the dai driver for
acp7.0 platform.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp70.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index a9be059889b7..a662c7db7506 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -52,23 +52,23 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.id = I2S_SP_INSTANCE,
 	.playback = {
 		.stream_name = "I2S SP Playback",
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 8,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 96000,
+		.rate_max = 192000,
 	},
 	.capture = {
 		.stream_name = "I2S SP Capture",
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 48000,
+		.rate_max = 192000,
 	},
 	.ops = &asoc_acp_cpu_dai_ops,
 },
@@ -77,23 +77,23 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.id = I2S_BT_INSTANCE,
 	.playback = {
 		.stream_name = "I2S BT Playback",
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 8,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 96000,
+		.rate_max = 192000,
 	},
 	.capture = {
 		.stream_name = "I2S BT Capture",
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 48000,
+		.rate_max = 192000,
 	},
 	.ops = &asoc_acp_cpu_dai_ops,
 },
@@ -102,23 +102,23 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.id = I2S_HS_INSTANCE,
 	.playback = {
 		.stream_name = "I2S HS Playback",
-		.rates = SNDRV_PCM_RATE_8000_96000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 8,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 96000,
+		.rate_max = 192000,
 	},
 	.capture = {
 		.stream_name = "I2S HS Capture",
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
-		.channels_max = 8,
+		.channels_max = 32,
 		.rate_min = 8000,
-		.rate_max = 48000,
+		.rate_max = 192000,
 	},
 	.ops = &asoc_acp_cpu_dai_ops,
 },
-- 
2.39.2



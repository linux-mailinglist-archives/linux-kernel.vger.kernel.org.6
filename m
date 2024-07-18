Return-Path: <linux-kernel+bounces-256030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA09347F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E1B2228A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EB46F2E7;
	Thu, 18 Jul 2024 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w10szYli"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3A57C9F;
	Thu, 18 Jul 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283631; cv=fail; b=NkXhGHPvOe/q/R62riyaI3BZA/OpUk45b3jrVioYrj+TJis6G0QXU2DKXB9xAWEWtpncLH4jQDj38iwW39GHxL/88KMzDSEVM1fcUSntc6zgBzKFX0vk8UoEflJNn0eARh/0KXGy7izAwqitzqf9PLxOnHFYlOIB5xPIuFdluts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283631; c=relaxed/simple;
	bh=2No4049t4sTE407B4RJ2ZcdeMToJJlGnjkcILZbqhUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glJsEcaFobtYz4xGjyVYm5A3inn6JoxWpYKnSuGzcUDZuhk+tVywJZkSRCGqSJQpNrk8CmM384NedY/8DW6Lf1s2s2H+TUKQO/hs+ZSU7YPMhpIj5xjvsL0iRAPYGSyk7FK3WLcTxjb8EirsTTsUzlRgP/3X9DqQjQGxPsWbDZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w10szYli; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxhXJU33iD0KtxcobXZi70Zx7Gfe9ybxQ7S3yA7GsJRhxz2wi8LM0Cg1zFfSV4idwiDfcSwhHxdhFr3Rw6vImH5MamgQWG8z4wrKFtj/dQ7qqEHarPFSEkLoMhEu4yxmUEK7w0TyCIAy27lGoZJeGYBzmBV2UugRw8D5RVZyh6Zzw4r0pkR1ykzcF6SnFcv6y973ZGf/Wh9TmExzDQ+Z+i7QH8RPHb8abdUWYMJpR/RTjf0KsBPs5709dEC2JkRgmsFmMMTN01+LoYEkf2KPsglU3/3nPP8ApYJDct7UkI9uYNeUNi2YlcDbQy+FyvQt8U3srOWgLcSM1cW8fOcKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNW+V+jM92g1JHhxoY/KhwoLzBT/DQntOEgttqyCegE=;
 b=oCO1F886tADl9J5kAyMbar3VXErBwjZYEH6lqNxQrX8GpL8lfgK5uSEAjzL1BFXFlWMvukRz+W+u5dgtiCfF74rGxhfVADTJFlcrEEWzYLy7c+YuJN3BWZWRgFvgA0I88ktsdFHIEu1oFnN6yeZGptKdNDj/KYv9yy/u/bpVyl5VsnvPiqa4URO2/40fhRF02ALMM/KnrcubWq7tBhPf2mkeEGrycwnbxDxzhmTlb5GZcyLQrck7UTVWs5N4FpzKaI91LrylVoqOG/TFQLQADy7/bJAphe0PYRD5OZ55XdXHP+dKb4VrH/YkvxB4XC8PZ4XHxTK78blbqt5D6URn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNW+V+jM92g1JHhxoY/KhwoLzBT/DQntOEgttqyCegE=;
 b=w10szYli2dDpfYW/ptk3NqjbGsau9iOvgQlzgHfKIOQY2WrRWT8ucRC4dYCTnVlM8JMjy7oeSph3Lp4qXD4v4wXW+lp2DK91c5CrCgk7g95gLYBdCQiA/WXtBvrbzIkrOcAvFIr3cFwsLn6iFPfCrbd0KZyoNbYZ+DLc7+SSGSc=
Received: from CH2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:610:51::27)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 06:20:27 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::63) by CH2PR15CA0017.outlook.office365.com
 (2603:10b6:610:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 06:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 06:20:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 01:20:11 -0500
Received: from prasad-r9-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 18 Jul 2024 01:20:06 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>, "Venkata Prasad
 Potturu" <venkataprasad.potturu@amd.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND -
 SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: sof: amd: fix for firmware reload failure in Vangogh platform
Date: Thu, 18 Jul 2024 11:50:02 +0530
Message-ID: <20240718062004.581685-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 06aa5489-4373-4033-cbfe-08dca6f1b72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NyZZfMkRroofD678oCJWrwlozUXQAfxQMXd0y3ROIdI4njqPyC2fOBTyQc3?=
 =?us-ascii?Q?jmm4Ja76vQ1DRmjsN4q4n7ro2Gb9/c+oF14wdF4NbCDc5qkTn32g5oxg1KbZ?=
 =?us-ascii?Q?szUW6wwirq5p+D8lrBcc8Q6dE5LkOGNvj8cLANXlOUeNEysR7RbLJMfRXAsT?=
 =?us-ascii?Q?+Czd6NcIkfPtjRj3QOZqAVIQh3i0u3GnHkzRBZMDsY6aSYaHTo80cvq2ZOk/?=
 =?us-ascii?Q?PhO8UqWpx9XZkwTTcDtDdrez7K3+2PGMnnsfvAosIBQVBn7EI9f4ikzze/yA?=
 =?us-ascii?Q?Yas3SyyHQP+UapPkUL3w0u0k9mytYUh8pNn/cm3W8GC1MbtElXFtHjPEny3G?=
 =?us-ascii?Q?cBE96rzMUpxAe8/VtersCFlZtKKYaVcRqLY32iYNa1qpzvcdHNuXMktdt5Iv?=
 =?us-ascii?Q?ONuJd9KRoZS8xEw/0AMoC5UEQbL++EloJvV1hqdF6c8sxIf0MFqFtg3DItnD?=
 =?us-ascii?Q?gmi0qhM1C+I0UOAuKdRW3q/lfjk4GS/TxlQxF7Q+a9gWYSTlZVsOMiJiJB7s?=
 =?us-ascii?Q?G3VfkC7zlLlNfl/2Zo90n83lVNDw7pZyTsmVCGAsxCXSAt60WBJb4laJmghb?=
 =?us-ascii?Q?/y5SHPg3MLO5wpMmvlX0WGknIu1S/jihaLDGZb2SIajyOohX+XQJfsAGL1uB?=
 =?us-ascii?Q?U3TLL9t64p089ZO2AJedxVfEBpnluWgW1cuJGLOyHg8AbBknk6GdzQIiUj25?=
 =?us-ascii?Q?an1G8wercON/yx/ykGZ8zrN8Le5qDLix2v44L6ef31SOj3x662PgNxG1aylR?=
 =?us-ascii?Q?rGSPWLnkRUGMJ8qj8F2xSyGTfpo91tMsF1j/zzplm4CylaxLsYd097pcnakJ?=
 =?us-ascii?Q?GqwmJAGm4K7Hc3zQMF6YAxOApj2gaNgfG87Vzf+KHJ+Polur/oD5rxvO9wPX?=
 =?us-ascii?Q?gnNES5i7uIvI12VtLtBcoyAe8bT2ohaqnG5q63xDMXT7pb/CCjBaiM2pFwQU?=
 =?us-ascii?Q?Gv6ZdBHI5vaDAHQJC64Y6q+HoaMUA4V2k9r3oIo+wXaNBpbLR6IAhTQK9md8?=
 =?us-ascii?Q?+wZTno7hmyO+NwPa8gwOUTV8Db58oQIkjT4Nt3K8Ust4FbeLCuGOIoGKZJ0h?=
 =?us-ascii?Q?oLa3hzndCNyRy0bMdwlJ6XvnpXhHB3rMJ4L+mOvrlfoWTjDbrO9V+wcgEQq0?=
 =?us-ascii?Q?4hsayRFvJ3ufewMQXa/geRfXTyRD6Fp9tfL+R9C6ArKXbTZSHn28n0jxHNP6?=
 =?us-ascii?Q?8mj45brYJI2lJ6nvL8Aj4ItCcHs5pXiXdmdMA2ZQXUi3ze2A9h8cR63DDSN/?=
 =?us-ascii?Q?Lk/L8Bd4qYGFcFJ02gLIcmSMB1wB274ph/2IzPbb35PPRIsGkiMvN6/WRTSc?=
 =?us-ascii?Q?ll2CFunqxnaEMiW5m+vMF/B0ST9/oTKAYG8bbNh3bUfgmXstjG7p4eCD18MQ?=
 =?us-ascii?Q?ewEg4BcSFUqwq3lFbJNWzKQlR4rZ8m7laMjVxJIUdcmvsYCnTsPSYQy21DeQ?=
 =?us-ascii?Q?j4YmHKL9UJvC+6NGSgHGXDYyvgcsxFuf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 06:20:26.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aa5489-4373-4033-cbfe-08dca6f1b72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

Setting ACP ACLK as clock source when ACP enters D0 state causing
firmware load failure, as per design clock source should be internal
clock.

Remove acp_clkmux_sel field so that ACP will use internal clock
source when ACP enters into D0 state.

Fixes: d0dab6b76a9f ("ASoC: SOF: amd: Add sof support for vangogh platform")

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/pci-vangogh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/amd/pci-vangogh.c b/sound/soc/sof/amd/pci-vangogh.c
index 16eb2994fbab..eba580840100 100644
--- a/sound/soc/sof/amd/pci-vangogh.c
+++ b/sound/soc/sof/amd/pci-vangogh.c
@@ -34,7 +34,6 @@ static const struct sof_amd_acp_desc vangogh_chip_info = {
 	.dsp_intr_base	= ACP5X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP5X_SRAM_PTE_OFFSET,
 	.hw_semaphore_offset = ACP5X_AXI2DAGB_SEM_0,
-	.acp_clkmux_sel = ACP5X_CLKMUX_SEL,
 	.probe_reg_offset = ACP5X_FUTURE_REG_ACLK_0,
 };
 
-- 
2.39.2



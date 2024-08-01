Return-Path: <linux-kernel+bounces-271163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9B944A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C567F282F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873E18953D;
	Thu,  1 Aug 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u3y8I57o"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B071189539;
	Thu,  1 Aug 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511262; cv=fail; b=rAsAlLtfHGeoSvaX5f/9RLLLbeACO/eX9SW36JY/9ga+naK6snd3hsxQGSoy/KTIgUEEbiynknGd+5H3M2SNr2U4z6Sia09JO9ztcqB3x1INBHmJlQdGgXFdljebZfPTJlOxQuDruPs6nLcTj52wwIfiLATVbN7YofXlJs1dD2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511262; c=relaxed/simple;
	bh=CbYImhZEIlZiKsrtnBHhWoYSCtRUOfibwlmFEjkc2eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiLBWSZ0/QI0DUfqxkQPHlGqF0Trc50z+z2qaLHfU+eFZK0zDR0k72aj20QYEVrc9F3+6sdQxqCMaf+3YAfapj9+NAHTYG1nXs8wXNkFULJwk+01Z1MQa99bo1rdEG6VXAI7ZNZQSxrgWd/T3Iheomeym9dHpxmeQiaaPuxnIp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u3y8I57o; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HylcjWHw0koJjkY9Q06LfxOG+VR2rQ24R+XyW5lBC+g5qKJlXtGM3iwf2x5X0YyASOwKaT9Ony6R5B6WsiYAKHuqckxD/g52gf1zX19Llm8ct/biuu+sGQOSSp402F2UIZBoNWpGhySDl2IeVbMCGYCgRNBfSllIWfAziHUD7PxDcbMVdcEoVJ50Pos8fVKG6CFRjuEqoG+ZcXjbtYKhHOrrNg8nzRcVjU89YmOxRtm7ZRYLYYixd9Laq0pz/dmahi4151/LrUrQlROafnEV2xf3h19kxpG2eBnAql4ie9EKLp+em0Zl+JVpYqdx3BNq9mvQIa0CdF21IZ+9VZUjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUsplPx+YA0cFRGB2LqLmG8miLuC4SkwCzhd7b0Wktg=;
 b=ek7duwUiELTXLUUsM5Wccf6J/kAAVy3lwe29dGjDoZ8UdU0cWeNkpF5wAumAloLxWllCQ7eLdUaJVx69Q7V/KW8LY9YI/DJ0F6wrctDYnIolL8uuMRxBsLfzsNrW3pIcklFCz4+mR/clap3DiaVV8ryw5xHBiztkEnJcBcP7Gok8E/nTGAJwIBAzEW0/4GdEVBxVBMNbRf/jvPps2KyGIwq5M7FOM6zhrlN8+8ZADb8GrumVBGxyfB+x4qBHKVR/whQkf6THp+R5tHGhhMSSJifdM6PgEm7nBF/E7nVhINiOL5wuZkcgTlqAPeNyX0XA5OmjXIF+hew0wyC7gX/RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUsplPx+YA0cFRGB2LqLmG8miLuC4SkwCzhd7b0Wktg=;
 b=u3y8I57oEd15R+q6wmgGY4dfHgZH2G/UQjkeH3gv2GxkGoH0D8P0YKtimeadxHbtOIwJXx09JjW82acStuOxVjUqRRQaISMZN7KQzgIv/BDS5ew5r9R0xVEtGDwXtXvnIpbyukPYhlX07F2c03PYxEJmV64GwtFdxyQHf4g57/g=
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 11:20:57 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::ba) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Thu, 1 Aug 2024 11:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 11:20:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:20:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 06:20:56 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 1 Aug 2024 06:20:46 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vijendar.mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <alsa-devel@alsa-project.org>,
	<pierre-louis.bossart@linux.intel.com>, <venkataprasad.potturu@amd.com>,
	<yung-chuan.liao@linux.intel.com>, <linux-sound@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND -
 SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 29/31] ASoC: SOF: amd: add alternate machines for acp6.3 based platform
Date: Thu, 1 Aug 2024 16:48:15 +0530
Message-ID: <20240801111821.18076-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
References: <20240801091446.10457-1-Vijendar.Mukunda@amd.com>
 <20240801111821.18076-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8b3f57-c999-43b7-b9c3-08dcb21c03af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWKUfMh2avv5O2gajfYayy7nIx8r50hoFKPDSIxTmzMxQ9wCyq3ZNlzl2jOx?=
 =?us-ascii?Q?ZLEplKCdDmP+9eg706UvnsaY6jL6NzrgpEMFKWVxaKV0PysPoL1ctbCMvwYU?=
 =?us-ascii?Q?iYHJhXdEQYKK4Ul8WTjGLXUQkYbMS+swae6BCRRXlVjhRMenTPqt+qaInyEY?=
 =?us-ascii?Q?WvVM3b+MBJ+2lKv5FUL/C2ZXD/lfnO82+7Y+Ko5wnz+/OBSMGGF9+u55da8V?=
 =?us-ascii?Q?fZgyxe/+0IgNyRj3eQ9uqjr9Qsy0FKk4C7HfLQYN0/07kPeRxC15rkoSle2J?=
 =?us-ascii?Q?Gp3MAe12NSeQTIWIR6fbXaeRIKwucCwLshlBKXDMhmGMFHZnvs6E5D2sinJu?=
 =?us-ascii?Q?Odt147stGbcHR8neRE+YTbmsAC2MDMNy7ZUAOyExQImOP9ra9tITxtWemO2x?=
 =?us-ascii?Q?SFe9k5WL/jne4U1dBrFMEQ1Qf8TVtuZtlslXN1KK4z5A9BN+UnTB0NuGe4ZJ?=
 =?us-ascii?Q?8pZeGOvpzLQioZ2EPoM3LdCU5WX0Ue/hkLj39ggVhVEOkLc90FxSZLGtIK63?=
 =?us-ascii?Q?YYkczPqrbpTBiTCictdN6KAskFhPtiLNPgIQ5jR7wCfY7kwUQq6UmZp0JuC0?=
 =?us-ascii?Q?CtNE/2gmMzEPPz2YHRzGVulmHs8VjZbtWXfDG7dRIJiAcKHrnkSv0DHk4IXk?=
 =?us-ascii?Q?644HtuuIwObwr8evnd+hdWU7NUcyuLFg0kYSbYDbP81ECqBfX3XfyDRW0eBL?=
 =?us-ascii?Q?eUAFpG0i3eT/qLzInjQKayZ541oMdkfv9Nuq/cQH/yGQcn670+Fj0AgFXHwk?=
 =?us-ascii?Q?hrbwjG6TObqtIcQJBKS6lIeXgQdE3iR6BYT7+nqvfTkXxZ8hSUii7z2pxKdT?=
 =?us-ascii?Q?tTDpJnum3A/WDOJJS5Zp68lU0lOGgXgn0X+Z23JmSCp16INfvfZv9wqe5dBs?=
 =?us-ascii?Q?X9+YS7f3X6YfnpnT4bTQDNC84cPejYxSgf9VtsNEuS2PjN10OIDco+MpMRBf?=
 =?us-ascii?Q?+oKtg+u84w8sipYzK5/kWo0H7iADhdtkX+BwdP2tt9agQ9BHDlygVgDW1zqW?=
 =?us-ascii?Q?a6ehCML/lbULt3BZSQ6ax/fcrgti+7Y6tMhFmV45Nvz8CPXqePJiiY+x82mF?=
 =?us-ascii?Q?upS0bwSHxADqxHmsTnUk4pPUXIl0zNC9pSKamydBirBZl7aPNbfnVndk0Res?=
 =?us-ascii?Q?8XKBQwZqZWuWMH9DCiqVWO/TmHucCk8OlJ1rWzCtcoFLMG5gh73hgUqUHaoB?=
 =?us-ascii?Q?MU8ipfdLwZHTkF74QB+x8Ma3UdX0LL6KSdguldcueV7wupQIjiAf470RbxIG?=
 =?us-ascii?Q?2MVcJpDuczC4tiVncVov81tgIa6XEEC53yPhwGjofQIzfoURK3SbC+hkwI+u?=
 =?us-ascii?Q?fQZY8jEed2RY5HlhQcfScpEmZ3PAKlcnmvXlW9ar9Fr/jdAXZb1VzaAuNDLJ?=
 =?us-ascii?Q?ingKdqO7Y/2XNi2mzqgl1CXGF0O8KAdPkQxblwwy3fK/Ki7AaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 11:20:56.9662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8b3f57-c999-43b7-b9c3-08dcb21c03af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

Add SoundWire machines as alternate machines for acp6.3 based platform.

Link: https://github.com/thesofproject/linux/pull/5068
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/amd/pci-acp63.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
index fc8984447365..54d42f83ce9e 100644
--- a/sound/soc/sof/amd/pci-acp63.c
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -48,6 +48,7 @@ static const struct sof_amd_acp_desc acp63_chip_info = {
 
 static const struct sof_dev_desc acp63_desc = {
 	.machines		= snd_soc_acpi_amd_acp63_sof_machines,
+	.alt_machines           = snd_soc_acpi_amd_acp63_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.34.1



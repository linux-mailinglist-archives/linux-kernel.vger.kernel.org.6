Return-Path: <linux-kernel+bounces-277302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14930949F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E7C1F212FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA31917F8;
	Wed,  7 Aug 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rSw/VF0P"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201F190464;
	Wed,  7 Aug 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007744; cv=fail; b=qrBhuub7qnzW2u4BuEgiMWEsM5uSTH4rK+YQHSq4FlSqn7h0mocVKSw5tIHtYktNLp+aQ4GX14GaQrJqhxHNDugHFh8HYAAvWxuzMsAi+DgjWAbO7/hePwovtrdRIMKPXhxh9eIz50PNh7Y8E4UtCvnFqWttvElfB6hKIti6+gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007744; c=relaxed/simple;
	bh=QxszdzAXMtanwDxUmQhoRcJ8Iy1ocp7vJQhlv0/g38U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN/nwm1EHOA35NiM6FbNwJYwqAUL/J5R2RuwzR3lIuRajTOm9d/lVYlv8VgkD9BFB1/zb4Z+DW6GUpqvj5Zzn3dyg0JcED68Mx6P9mamIAgGwUWPa3bQbjVPuFiNhPJKMbhoXGI5NQSYjWX4XgnfVSNpkrieUJVfqarSjweOE3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rSw/VF0P; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPFAj0WKooqKpfIVtyTSLXXJUB6OqEECZ1/226G4oQljaLZ1uj8Fqc8gJtAnBVM8X8efo5ElaVxwR1dgL6jlpFPIFkNp8dS4IrLUx5lmc5DpEwh3Z/qaDYRTdnsqzBqYPSMKk/RdEq9+x3oJNdEzvyFeafpzLYq26KQORApNLnikIgjtA5GGUT2iLoGnexsgjvuzS9HC4DUAnUpRgNfeUWXRqCLO20lXsxWmQP8/ypkzS0nSFervFei7qNst0Bhn7IPeK5bCEApDj3w9HNCGOngULs6NbGvQFn+OHq+RfJTK8JxS5MUdsZHuSPTLv7+mjyMJvksfXNcPkz250+m6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBNfv35Z9aYp/a4IbdRFX7G0RUSMVnZLZzGXQqLX6hc=;
 b=UfTbV60a19REG+chXsqYsOhDIsndcSHoRCFwVpLdTEl3FSLxZ0UKpRyNj97GjndTvXZ0x2afWxVulec7riThizutXe+/9IvNILoN+e6ak+r2a/ovDeI2DkJgdEyeBhBqzsos/j8EqOmpwnJBGVwdawlE50fSTU9yKLK+VXXdpMMJANDlvJwglyaJJpa/RXKTWil53oOFc4H4UU+lvHFRywt31MySPC4+aoWXB7ttsTiIVaE9/e4QCg70Gwv1fZWotTs1B4wLxHB8zVEk9SFz8J3gTWgxLEEGEwioY9e5QR5LcxDICiFs3uyk2BmRmMDNZZEdqDr/dSALIp3OGZ6fOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBNfv35Z9aYp/a4IbdRFX7G0RUSMVnZLZzGXQqLX6hc=;
 b=rSw/VF0P6gYh5+JiRSzLmkZ6bUAiSOhTfd7v9dSOh8NjfgOHW5/CHDHjSkiyXmFywfqh4epOzMcstDDK1FZu+33b65wvhgGk/s90ikmCfoiSqsxte27K50+qupkjC2zf8g7ULCN/JEVxhran1XCB1uqn61FMcUDE3Vp18Q4ZMN8=
Received: from BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 05:15:40 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::6b) by BYAPR07CA0042.outlook.office365.com
 (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 05:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 05:15:40 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 00:15:35 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] ASoC: amd: acp: Convert comma to semicolon
Date: Wed, 7 Aug 2024 10:43:20 +0530
Message-ID: <20240807051341.1616925-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1278b9c5-4887-49a1-b6de-08dcb69ffabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CCjfe8bT+0dUWTKqOhhv5kHlwGICHPQACsTOgKv2DsRW9x4PiEIIOREXwsS4?=
 =?us-ascii?Q?k5ZLTriikPHoXy8q7PNN6Xus30J/sjCb/VW6EIg7fxfQFcXcl+CiheI9R+HA?=
 =?us-ascii?Q?3Ge9A1L8xTqnIdpRGo52Xe43raNclaC5BOLtQfxecpm/VKJ4NWhEhxeVusfu?=
 =?us-ascii?Q?XYOlW3nOFu5j2JsH8vZUgXVri9TRKtISl1s7myPy2xzog+MLAAczivYEh8nw?=
 =?us-ascii?Q?TevLAhdjNhvZcOtVRT6QXIGq2VuY9D0yHpMccFLUuhLDB7SZKYasJQkn0IXi?=
 =?us-ascii?Q?QJA9zcYLE2Vn5qadXt9n6mwZwnQTkAYbMb5ZEGGY5WJtHxzjry27CmL+Fzkk?=
 =?us-ascii?Q?S80VB435R/rphxY0Thjs30ZbApbrN8krZSzM3CDzn0Ud54O/znrt2Ep2AA9r?=
 =?us-ascii?Q?1UAkRxFkqMoc50xO36lGFXVAI3MjK7pmsJiDunm5adAFXvRn9cJjRI70T0Om?=
 =?us-ascii?Q?wPG6/deqcY0ZIPPx/w8kWHKToiCMZBM3KRkvmj4SVUYso6aBVwbxkciLfEB+?=
 =?us-ascii?Q?wgSEThIpQb9TzpuIU6aGD/VzkB3F79unCKpBauoq5YRWH+Q9zInJ7MdbrOH3?=
 =?us-ascii?Q?RyQFfIFxxIFZCt9kBTRn3X77NHuCr1MFEtudYNN2ZqRu4BJHG1m7KTbryqP/?=
 =?us-ascii?Q?3V0Pr3st0cvDeJ4LEQmGQCZkkh8ChJIMrE0d+ODLZVO6YURhS59/0hWpMqCb?=
 =?us-ascii?Q?S8mWOalqVgbZXmR1U+wuupJhWxSbSpcflcVDqWZrSqyXr0U0HZPx0diQEkfe?=
 =?us-ascii?Q?3mhmvEqd3LxJNVxrVnX9Q6dQdKb2AOqwCXeMjXP14lDOX84F3GhSE0l7sYmd?=
 =?us-ascii?Q?4N8bn8IHJ2SjUTXnRDwgydP/PqVzHOxScG6cdpWTlMqzgD2kBuO/3zznHvDE?=
 =?us-ascii?Q?x0FNlZAxFWDlQkXCg0CyQI4EFkhc9SHFt0BxmBHvvh9U2SUIow395/Ls/mrE?=
 =?us-ascii?Q?MB8IitmVeuKxSPbyfUYE8s8Gj4dCiTxob2S7BdSEUHoVhjA87m4GSjJ9+OzF?=
 =?us-ascii?Q?5p+rcOJP2HNpG08jpucxKfyBPUAmGly36Trs17GETIakDEcm6avI4eO9TvFG?=
 =?us-ascii?Q?CqUqmlI4MmxRULHA4iK4bGOaPcSr+m1BT6ZFjsvdFZSaP+twZ9bsDMWE48E7?=
 =?us-ascii?Q?rpvEG7NlaelOe7KDRmmq74ZyEycbFFuFWTLZ07Mky0ttgvnyW+pLEU1lqTPj?=
 =?us-ascii?Q?TyGqgUUnK2JWtBt5PLP8w5c2qOhZJsrKUqWW0r8cfY5OJPNqF5smyl4f62aG?=
 =?us-ascii?Q?xwBEdOGWHdoJJLcr0j5IOl1zKekAr6nMN7iFTrb6w/XC3tku0to99+pg4kMr?=
 =?us-ascii?Q?XRwahADTJXAVej0aEiQcdRjIt/oVrP2VV/FX9MYPy7E//F6e4NRsb6NRyYEl?=
 =?us-ascii?Q?MLktjvy1+nHHWM1hnACzMTFQEMtiKNoejbTm6ktmgSYzPYP3KyOjxkL14RGb?=
 =?us-ascii?Q?uSdIUGjyVw+bJB0YYWFqz/pR/lJ8SzRF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 05:15:40.1153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1278b9c5-4887-49a1-b6de-08dcb69ffabd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169

Replace a comma between expression statements by a semicolon.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 3419675e45a9..0995b40d15f3 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -657,9 +657,9 @@ static int mc_probe(struct platform_device *pdev)
 	ctx->private = amd_ctx;
 	card = &ctx->card;
 	card->dev = &pdev->dev;
-	card->name = "amd-soundwire",
-	card->owner = THIS_MODULE,
-	card->late_probe = asoc_sdw_card_late_probe,
+	card->name = "amd-soundwire";
+	card->owner = THIS_MODULE;
+	card->late_probe = asoc_sdw_card_late_probe;
 
 	snd_soc_card_set_drvdata(card, ctx);
 
-- 
2.34.1



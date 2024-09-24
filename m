Return-Path: <linux-kernel+bounces-336609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA60983CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF62827E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6084964D;
	Tue, 24 Sep 2024 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jr4KbNcV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E6770F1;
	Tue, 24 Sep 2024 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158744; cv=fail; b=e2g32vRylCo2nSQgOTf8OGJJVIxkxQUfEkfcv85cw8X8QcmY7lh7dpuISdA/GU55OtSyYnDkpCWE5lS9Lin+uvA0B9j2mCuK04bwV90SI2/2DKWMP5PRTgokQLEsQTQJern6Knjug53iBQUr13xiwvziCjgkvZUzb+BiXP5LI0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158744; c=relaxed/simple;
	bh=DiAKOqiKFPugbD/RAZwSuLANvdC+UC3LkmazT4ORcBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biUd7vIhtteOMftne4vVs+qjzDck4v5XSXcFUrJti+txoHVduaDm65VQ6wQvNNCIn+oKQDuVIezAtorVIzkbSLrAKrGvRlhbikhubSQ2V++aT4l7tfmFweffihYMh8ZmTrpPE2O7TpmL1FVNwmzEvhpkRlX570/CYoRFTwN5/nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jr4KbNcV; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IniRw6TCITl0W95FhAfVEZH3plckLc/3l6CF9GZOsQRO9c71sHxAgJdu3yl9FnCKttQi+pwvt2A+HfD91/AcMJ3xTR2zaaQ8oRSiCO7ybJwJEZCRGxAO3HGZvRzJySmWgl3hxy4s09K+4uZSZodth0+yDTkEZDijP+yOzqejXDKTfYWTuBZkRT1jYLx8JXrhhkamVBgJ5yLrUhQ07KW7gh1NYi1s53Y1ts4P9G7z0fxG+udISsH3pv+BF+QqfPd0m0o8mOOhNkypiYqa3WZJRoadp88emn9hF9bnflCaVVcQBFEFypNSxrgkgrtbHZ9AAsfSplnIEtbGEly15hoNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X46RqgqZ7sreYeGCiFtVznCnB+4XSiFcw4i22prFr1E=;
 b=gvF2hAvfU8hTep9rJOySXbDgK/sH/Vl+F5WDkQsmOzY74Y+udHoHnNX11O7YsyyfukfGUaCCJnXpeemXjUjHU+zkvvFwI2nP43x71JV95DdwzlXWbHm1vpqL+yd/8koOxF6c2epylg+xcoPL250+rBYQ/YxNuWdUmeedm+ksH4wkqGoNWuSyA7AvTVPQn/axLQ9fk2R7m/v2CDU2luFdNzHTkUzC/prmEBbQGlGycjcbOjXbVX6fP6wZTHvSsdO6Vm6TOgguv5HP33b/Gqar/9rnRKaET41vUYlxzMqCecbhQ7Jny+cSHAFJDdp9TT6YHV3IBEKqJvfl+NnmdopIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X46RqgqZ7sreYeGCiFtVznCnB+4XSiFcw4i22prFr1E=;
 b=jr4KbNcVX7D4xvZfoCuV+l0yxvP6kcBSeKDmxxUVWMnUZWcChL5mET7OxN92MZtRjfCUctsWgee4ztpZoJxgkWl8+n2yh2Ejok6XpD4GqNCJ9QyNO4TV6XOTDyh9kUqWwOQ7P16gLezjDG/+czQIwY7us7k5mpS3OmN0W+mY1Ds=
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 06:18:59 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::5d) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Tue, 24 Sep 2024 06:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:18:59 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:18:55 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 6/9] ASoC: amd: acp: update mach_params subsystem_rev field
Date: Tue, 24 Sep 2024 11:48:18 +0530
Message-ID: <20240924061821.1127054-7-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: f2888e9a-a731-46a5-2230-08dcdc60c72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MR7VZNPHiPwTjtpICOrSC9xGCm+kkzopvvkhYrcawVyxMIXe5Zo7a87TjG/a?=
 =?us-ascii?Q?Js6kGWwrkbLIxp1mOzgVUP9tYl732ML6SY+B+HrBL5YA2yv6IHOCG5dV2WM7?=
 =?us-ascii?Q?A+tCwKuYC1RB831OfShW05Wu0Z5BWqJFfRwnFRRVeJdDyRel12S1zuYkobAO?=
 =?us-ascii?Q?ZBp3dTVP/dkVpkwjG6PIFo8GGxYXaL3/AhqShjxxex2PS2VFbqMj6e/iRjCl?=
 =?us-ascii?Q?TJ91SvmwqDwaZIpD8DTyVvBhiTG7nnOMjLvJ/t8u98LDInHpmrvvWB560KZy?=
 =?us-ascii?Q?y5d4xK+40B6HXC3TH6UaRMjV+zsFbtdi7B5JxpoQbRihG32bM/CNkuhsFdOA?=
 =?us-ascii?Q?C3XftIHSPX9gxyJoBCfxE9xkRfEXCPP1yh0+H5O4YI2PAxBkYI6PFaG3zOfz?=
 =?us-ascii?Q?Ktez9pdPR4WZsg+xPh60nfscUpzLntFtqcsu+wHTIuDOnTikeExp9freSGt3?=
 =?us-ascii?Q?wiDiYG4JvNT7e6Asnt8Ng0ekGe6dZI5O/DFlYaZfSVcq8dCUwuBQQZQVANBn?=
 =?us-ascii?Q?+BEJroAGIQ0Zr/RmRAzwmb44MpzaP1aVrQ/NLXVHOcPNns0z1uBP7dY2D4pY?=
 =?us-ascii?Q?BXX8FMFmUoAHDDgztrgFwen/sDn9/f5IHhhZUGFxIpaYvk5BjXxWdczG8iUS?=
 =?us-ascii?Q?fQ27cidSLhV/B3uWDtqfm+Nl91iS+1gnPK8qEUr9zGP5P7ojFtilr9wyKFtL?=
 =?us-ascii?Q?tR/P4ANLz45Izz5TfN5tyWqSbb3qe8Fytv9oTgKFYEZLiqVlG4Q0j/xKFmuJ?=
 =?us-ascii?Q?ipOs3avtxA4SWktnIg712dYtzGUxOpZLnHj95XTmQ8CFdUoRVHw4WVYLZ6GD?=
 =?us-ascii?Q?oaL44kApLg6i9je2OkdFJoCuTaJAz9S5RCSmy655oTk/PBUeKDpD23UMxLGO?=
 =?us-ascii?Q?VxehfN/MnMRIN02haUDFCpHW0Z+5qxccWEIeOXlipTSXcyYbKrM5Mzzakn4E?=
 =?us-ascii?Q?7WGM/FfSMuhI6LcrtapNTdMgj3KPlxc82945t2fYe9irBS5KDrC1nIoLCMjW?=
 =?us-ascii?Q?BxYLKL+Hnhmi/EBhtldSMNGe45WyeH76MakqSuB7GAFsNLpKU+Tf0Bosa6oT?=
 =?us-ascii?Q?UcoaQDOQBzAAlma/PylhRCYpBpEJU8aCyLlldvf5E56RfQGelKcGpeAkwo0j?=
 =?us-ascii?Q?rupkU9x/mWGL26e2/QQ8+h1cBoWL7Y25ZMN3B8hzufaLGi1o4AQ2wjZKlyX4?=
 =?us-ascii?Q?JS67cExQ/MeuhvHlQaCvuMa3xa/dklnqCNrrfLNYU1dxMCf5iHS3p5CRBDho?=
 =?us-ascii?Q?xHtAdrjcuXSP8ntbG2wI0Nax2ccqtKPMQnk/PHOMorlxn/pTs0hYWutqK29K?=
 =?us-ascii?Q?c2dhaBVLLAMvenxXvGVNAjKlNuw0wXfdGWf/x49fWqo67QouQrhXuOFgg9Ri?=
 =?us-ascii?Q?yPWyNzzRb2iJn0wla70hTKJd0Zr/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:18:59.5425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2888e9a-a731-46a5-2230-08dcdc60c72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304

Update mach_params subsystem_rev field in acp_machine_select()
function with acp pci revision id value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index a6e5cb263377..78fcff6ea657 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -125,6 +125,7 @@ int acp_machine_select(struct acp_dev_data *adata)
 			dev_err(adata->dev, "warning: No matching ASoC machine driver found\n");
 			return -EINVAL;
 		}
+		mach->mach_params.subsystem_rev = adata->acp_rev;
 		adata->mach_dev = platform_device_register_data(adata->dev, mach->drv_name,
 								PLATFORM_DEVID_NONE, mach, size);
 	}
-- 
2.34.1



Return-Path: <linux-kernel+bounces-282912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F6194EA73
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ACB1F228E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7616EB5D;
	Mon, 12 Aug 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHHzcnkF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2F16DC26;
	Mon, 12 Aug 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457090; cv=fail; b=kmdS1csalvOIvV7YtZjaEMpZdCaQKnbQT5iOnneOmqLnOHRGgmdnHotr6j1Khht2zkEzHFo1eKjpzQDWshJvkCSFqbIxKWjs3k/0Zllg1kvLT91G68eY2uyYOtfZ3JtjtJKfQP9EZlPlTHQxR4Un+Ta1xSB6/kVWIMPUVPrlS04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457090; c=relaxed/simple;
	bh=pFphKa6qJi6OgcW+BS+FZxBkttZDB6P+4CpWPOvplFE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uhCrNPKCR6rE9Ceo+5TOIWmWkT2n6223h5dhnRZhJ/DtxGsrzHvu5/WpSn5z+HTnZa8jQTZwXycCxRlOUChxJILMXSxXy4xCcgrRf7dQ5k52IR5xaH5wC91QZWn1b3Fh/pSk6Lg+04GN4G89EYcdl/c49l3WAGzNlepLmYWmo20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHHzcnkF; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd14mg9eq72hndL7BpqvcJ2ZaeNSsHCcgwlw/GPDTnu8F4tq8GFDzu3SpvkxJEUH70TotYXXm5xdhyQJl3j+7saLSmppqjEfJEwSKqrR79J2BHYC28bRsJcDAKXuQG8tUMBuJnFI/keS3G7+lu19vXYNatY6uY02mDHK7D6RO+qqH412SFcZqorb6YkIzdtKDuynu5o5iqLKGEhRYByu43TE9w+MSlp312EzVBioSxt80o2Pc5Isgb37NJ0dMdwYu8WhpZZEZWt20Mo7gA821ewlsZiTF/SHDLEEUK2I/wybI44CIyP8b9IR7B60fhRmS+/bdMP5DiuJc59uwpvnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPt72Cimb+2QfkM30b0ByRs6PiQ/Yi2yATKvrS50q9M=;
 b=y87DWE1cZiSYTcf7DlJm58nXnQaMoE4QKcE11T4NJBV1M9+kqyTnmiXTmLIZm3hsqscIXow0yS125CBhTPQtB//FE35jEJzdEfkqDJqFP6eBDBIeRa54NU8q5JVhbuYXetUGIXnGzFWDuM6SgjFiuBuhkFSdUPcdKLff+gha9bOXZ8ZjUhSp7lqRPhsv2WCmx7jUyek+nYCCvgvpLT18utSKVkH37+Wgn8HP+zYYbU0c7Pr6UCeloSpqm8Ze22ovjhJ7IpYt32UqSUkrZOX48XsRqQZmZ6QR6mtWLxnIlVtsY6wZ3aI0OVMJm7Uo7V2Beiv71oaL1KilavYHOxDcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPt72Cimb+2QfkM30b0ByRs6PiQ/Yi2yATKvrS50q9M=;
 b=WHHzcnkFW7wh4YkDoJMv4aLtTu5EIQdR/Az6IhC2TLQT7b9IjdIOryss95JlOipCSK8vI+JziM0dhgqISKHbLGgqbMEhe0bqMKMUzZCXy00Vias93ZRMbR99F82G/fUJb/Ezx2+XKxrYbneN6o2bJGUd46t63cG53iUy+B5yyWA=
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 10:04:47 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::c2) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Mon, 12 Aug 2024 10:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 10:04:46 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 05:04:41 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Sunil-kumar.Dommati@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <venkataprasad.potturu@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Convert comma to semicolon
Date: Mon, 12 Aug 2024 15:34:22 +0530
Message-ID: <20240812100429.2594745-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: efa20020-2f16-4e9f-e2fb-08dcbab631dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pvnyzke4/2boeDTINZcan20y8GEIvVNrYp27L8oYzJSNTz0q/49yOhyvjebV?=
 =?us-ascii?Q?oIdmZbIc6/D5KYHel2+DTMQaVQS03JlRKIXP4iIFx9zyc6AVHvWBi52nS0qa?=
 =?us-ascii?Q?OYgQioWotqABPpK2vSog652Gplya/l8NDaaf3AYzNix6XgUmnN/OOy+8jixo?=
 =?us-ascii?Q?Rv8t/RRief4GJiJNA9RIPz0oRlRDZwu00Hq3xEtSipwTEPH87wSUfSSec+5s?=
 =?us-ascii?Q?KQi1LmDrcexVXDJfp85N3O9rYSda8kEztKNpXQqJCr52vEy+H1TAGwL5b9U2?=
 =?us-ascii?Q?GIGIoBR5hx4IpvugMNEDfCf7h++eh34vy1TPkb04rw3kAdjhtaxFwUOJVzAO?=
 =?us-ascii?Q?1Y/e+QLaNa/71yn9AS+SZegBYd6e1160qCofDVxFRX9+WNkyAwtPN1hTQumf?=
 =?us-ascii?Q?sXDZ6l7pvoGZMlZnFgI0baVby1MEKl1sl2JVtHl2jgkWqvHYu0FsvCgnEqxo?=
 =?us-ascii?Q?nKMGsXrkrlCJGMlFIxREo4/oeIzBQ23K4dk7+fdloxwpr05UDk4pwA2s3vLC?=
 =?us-ascii?Q?bcaCheSipv7d8RAUG3QTZQVLvnxuu0zhkFyO9M+4lBlY2voxbsYNx0zxArHZ?=
 =?us-ascii?Q?T6QBNJ3/MF3OpE1UdajHxa/7YnGUZ8wvQCeQJdhRR9r1rwIj/nk75QFEUD13?=
 =?us-ascii?Q?RwALNIhMeVtqvsfH0/8KI7mV3uyCtwfTmlSh3YgKR0eE87+aneBdQ17gzJAg?=
 =?us-ascii?Q?IECgGLEJNwioVlZIAxGrccDgI+8UYNTM1jjMOHSZmb/l4nBCQG09YMwExMxR?=
 =?us-ascii?Q?fpmiFO0ynftVDzBka+hJ55akykFFIPqLVbHrSACeT1D9o8Cyl0ekSvvEOjbc?=
 =?us-ascii?Q?+jAN/CZmBPMevBJJRAXL9nCkqk3spXUx6+HyzlKq1xh6PQ+bws2UX+rRqr8m?=
 =?us-ascii?Q?ZxucHEw+nw5iADs67EYJqgugL8SPFqdUrYvAuQvYOSeDOmjtrw2CNbrznnTu?=
 =?us-ascii?Q?y7cIJ+qraqURJxVFLuZfwPmVJb0sXRhiJdiXqo0C8EUb/db13jRofCGqqrkX?=
 =?us-ascii?Q?txiAhTzTMfinU8uaGyODU18htXbr5fiWyQxs13kdycjxl6Dh2U0A22jxwHbA?=
 =?us-ascii?Q?gsQCuBn9YJuI+CDZp68y2wsgYOBwv0FhZ3doVmCQMRnzrZ21yKORrkFb705L?=
 =?us-ascii?Q?T0YypyGVaRe3sa4ZcizdPjjvC/iSu9tLwRej+znaxH9kzKXNsNPJjJ4ceDwc?=
 =?us-ascii?Q?O5d2ef03MuPajfYpy+MZ40ObMeioNXH0Gi17KXQVkv/wFg7I3IlZ2ldp/n48?=
 =?us-ascii?Q?ecrjMfRskE41k1iWpBHO5V+RmfBfzI1Sg/7uOM8weEXPRT6o4BSYq9lhZh70?=
 =?us-ascii?Q?v+Ox+dzDWQEkhfT6aDLhv1Dy47lND3v7U5hqXZND+acLgISVOCXA7B+tquX9?=
 =?us-ascii?Q?ex/OLZPs1pq/m4Qi3s9kd/w2XoxZnDMOyS2ZJ8Dd7N4iX/tZ3K2Il0U4OiVZ?=
 =?us-ascii?Q?sjay/s1zBm4fN6vmqbsF1fTFMbj6VAbv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:04:46.2204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa20020-2f16-4e9f-e2fb-08dcbab631dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Replace a comma between expression statements by a semicolon.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index f7e4af850309..08f368b3bbc8 100644
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



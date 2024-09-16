Return-Path: <linux-kernel+bounces-330216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41CD979B09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EFA1F23A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121843ABD;
	Mon, 16 Sep 2024 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLLKUBBX"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723174962C;
	Mon, 16 Sep 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467308; cv=fail; b=e/rcVdEH/Aoiz6Cd5trVj/oBQ+q64fMCNwh0AkG/2VGhljxgoDLi2UHkT4L5a0t888RKXEdYkUe12LFkUPFWQZYI/DM/dgp/3jeIsXnQTuEGo7vV8X8azz/vbHPrJ5NVXINtr6yylkCUEpiCtNxZrO/vkviyq+UGLIs2vJqGe1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467308; c=relaxed/simple;
	bh=QLW6vuKgACG0iXNvva5vMFlfQhIUD354C6HZ67AlXs8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAMFqtWwpNMig+u8ltMBTajP6f+coXdaGAHxRlBikFMpWKkJs+XBSEjrsv0rdbwFuID/Ybh0sBBymTPi4BYwvJpd33RTsEYnIUCtG66bLPNRGQOD02dJ4Nw1QuBRrkUOPuqs7WhkO5u7VH/ajfhtxZZ0I0Y+CHNR7DIoMfavDFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLLKUBBX; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGpxruq0AqNEYYuXaGAWgGWi7tM481YmP+V2PzW6jUWdvUL0oYwShohShwEwirimsk3JX2IptRtab2UW7L7AkR3fznZVijC8S+FoVktb7gwnXWarGiGcCQC8AOgkfZfhpDkjnlZENlSWgaaTuE7gnVbURPv5Fc7zh+frwkX3uipDYS8itfXJs+sJI9Alq7uIZx8w1H9cmQJSyX22Bkx5lqGYHBMPI05rYcZy3QNWRJUpdtIu9eAXFooCTL2nPaw4ZcG362emmO2qw31Jx/737PLhG1ErR02lI/4Xf1EbWnPUbqGI9mFkxydV9x+isYukrXLPI3wlGSGM7IFlWNHbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlx3PnYfTh7yzkk0FktCj7DkfzHVDHr0+3oWxLS+oGU=;
 b=uLZX9S4atum5ikyvx2KsIDe2VjrOS50karrIfUO7hj1Tmx5egmc+hjUSbINK96vZACP0lfd2PvIdeF7MJcakYlUF6The+o4GAMjpzG80PhZIvAZjyFJXW+2QEfKVNtneDSnK4GVv9wLTsUSMvqdi5i9EeHbc7lxLVuBV6Dakpt3UBOn3GziIxljFu16sxU5B7y/ZI+UYTiT0fEE0VnY2f9W2dx3oHMfzlSTcTq6fPtauSa0SKIHUicRp+olvJ8LOvwHSvt/UfcMfgObUomAgQEKwr/TS6DB0j6Hxo8LlVF7qStkpUlEslcPv8K4lCc0qMUHn0J94lt+wmGa0rruX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlx3PnYfTh7yzkk0FktCj7DkfzHVDHr0+3oWxLS+oGU=;
 b=ZLLKUBBXn3RT1ADFh/uEqREpbFiKlx+5QD1mmftlecNSU5zITdM5TXaGAUSQIJg1c8qt/dhJ7s3jGnL5ZWc7lVNdSF7BJbPtYEpBAUFoylqA0qmDp8svi7HCwKNH2hH4LocNkdJFymzsyXLwu6sF5TavZGp5wWuKyPdivrjaqD0=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 06:15:02 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::d8) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Mon, 16 Sep 2024 06:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Mon, 16 Sep 2024 06:15:02 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 01:13:49 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.intel.com>,
	<yung-chuan.liao@linux.intel.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: acp: don't set card long_name
Date: Mon, 16 Sep 2024 11:43:18 +0530
Message-ID: <20240916061318.3147988-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e08e23-8a6a-4b48-9385-08dcd616e67a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cX67xDwURB0ryWIVRlY4IQ9ROScY30IaasPgbDQkd8tr4hEuAfSMw/ARcISj?=
 =?us-ascii?Q?YTWKLpqRWso9bizSgViX8xNAKWMhUjChp6Fl9wvJeZOU8fd/czQnIkhk457l?=
 =?us-ascii?Q?+vxoWLkwOVyT0GeCvOzZuuAgMXML71LZN2ebTpZ8MWRpm2zBI0BtClZBgNa5?=
 =?us-ascii?Q?ugBmIWXxZor1GNTgW9QQOd0nVjaO2Ow1gKY3EB8RK4O8ihrFjywrvA/V/NcP?=
 =?us-ascii?Q?nksvh2KFmmyaSk2cia22G5uRQ5Ur1psB9bfP7kGvlQDFF0ZRFXGlrvGBdkVv?=
 =?us-ascii?Q?g9lrhv5O7K6nOVLA6ktQwWhHusCkLXTWXK+49tqU87eoKKC6bOPgRCX6tr52?=
 =?us-ascii?Q?SSmBG/dyWrmAsTvg+ENx9UMgBKLg26onqh8+GIM7+qNa+C2Gy5Wa93rBmvek?=
 =?us-ascii?Q?aUmp9is1jpmZ7l+snFoWz+QdhvXqPs13qoYEfNiiiptC4/PnlnQYkRSEzvtS?=
 =?us-ascii?Q?wV+MtZ86JxkqyD6mdL4waPni4MkG+C7SrBqFZNZzu2y4nkUz7/lFI7X76YWj?=
 =?us-ascii?Q?WCUUQeTuydtA1ALueXUHTGHoYZ8hXOR986dzxbzuhbMVcoMCbKbfPCPqX7pX?=
 =?us-ascii?Q?6XGLbJxnI7P3sBiMCjwTMNelwfp97hG/pgrs6CZQ26NojVELBDc1Na9MsJ2K?=
 =?us-ascii?Q?e9v9r7cGcKyLg88qeARIspGuyCKE3iUdxwFWtqb/sDyl/Ml2CSchAphFDwpA?=
 =?us-ascii?Q?W5bmFFgcCDMRzqr3iA5Nh/6/aWEJO7Sn5QNC1DIyPrc1vnMnaORG+t5OrM36?=
 =?us-ascii?Q?l+qupglsHhCC3yCpwG4dwbR4m+g7vDQGhDCPaEnwCsVs5PDUTt1/cSB5yLba?=
 =?us-ascii?Q?mx+AUjWpe4txQG4M9u3/ZIlmWzAKa+m7ZJovV1XYVwxoIVtd1VQl2ZUcgPZ1?=
 =?us-ascii?Q?Jz6AZln+VgNzM9j0dUu3PhmEKwi+qWCM2zTKqFtMlUGgVOOqhi9VbKsjvHYk?=
 =?us-ascii?Q?Y6Q/yiZjrLhHL0dqRnRo+I6Tk4Tt1FN+cqhVoe7bgMBcqdROSDtfHag97R2G?=
 =?us-ascii?Q?PkFrVQEMfL6rvB6w+HXFbE/jdOjLHS9SBk+Uvl4M3i9oUhF8Kr17Z24POR1s?=
 =?us-ascii?Q?IdSPdi6/4A8gsiXPys1rCoX8m+ZrHp2upjGaZnc5frTujlp+iJaYfK0H2OVz?=
 =?us-ascii?Q?q79x2Mt+Onkv3CqEpYFZvcSTpclws2kJKJ5RAiIVLR8D1ef5ERfsHtEjiWBa?=
 =?us-ascii?Q?XqhHruKcILgmBFhHYWXapbo1QuJwFSr7Od7mZ9PRI/JGCbvf8F9Eai8xoMkI?=
 =?us-ascii?Q?POnM6nHejG5wcR9bozgT+yLZL9Iir/rPj8Guia1v875HnxESOAU9P3fq3k3+?=
 =?us-ascii?Q?+/jBhyAoObzF3webdJuvU83mHw8pbXzBVhSW4IwGBgVc8TKhYJ7EsO6cz1Hk?=
 =?us-ascii?Q?v5eYas01TCBQCBcD1l5k4qZUe8QDW5fuDvymeve8jfJqnGt58M3S+F9mI1Su?=
 =?us-ascii?Q?yX6usDpEZxMNtCZk6RA/By7pBl3yucFs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 06:15:02.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e08e23-8a6a-4b48-9385-08dcd616e67a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

UCM can load a board-specific file based on the card long_name. Remove
the constant "AMD Soundwire SOF" long_name so that the ASoC core can
set the long_name based on DMI information.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 6c50c8276538..306854fb08e3 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -400,9 +400,6 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	return ret;
 }
 
-/* SoC card */
-static const char sdw_card_long_name[] = "AMD Soundwire SOF";
-
 static int mc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
@@ -463,8 +460,6 @@ static int mc_probe(struct platform_device *pdev)
 	if (!card->components)
 		return -ENOMEM;
 
-	card->long_name = sdw_card_long_name;
-
 	/* Register the card */
 	ret = devm_snd_soc_register_card(card->dev, card);
 	if (ret) {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-353040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210B992795
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF285283806
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93118C035;
	Mon,  7 Oct 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uoOncj5m"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511C218C015;
	Mon,  7 Oct 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291231; cv=fail; b=MPiAkS23xmbrz383gfuQkGqkjb0yq14ij7KWJGT7FNusN/SgmmfZVhq9XtRzIupTfeIE49ysyGhcOsjDam8qb0qxXy5rGSa/02n5xfwV33kZVYg6XtFlY73k8LgQcE0lLGzE7yw/ILHdESGNXOv7BBciHQjYW6MYjmtH/PJI2cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291231; c=relaxed/simple;
	bh=QsrPG+nN03FY9btqeKg1xaLJbXJWbSWRHKBnbuZ9o90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlJyv5+k3qLpb5Ua8ZEMzE5kZfuHqWj3/Qn6cIi6JTGz4ReBEVfYSvKU4PdpHLrOiWDEf3CS2NLd2is8n4lvL6gcVKqQV/hzZAJp2xYSKdhrjrjT+qiGO8fKmVB8GKtjpOVwDevfkhklU1UmZzIxVt8JB2bmD5RliRSdsWCnBGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uoOncj5m; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJygU34GMe2Y2RBudpf89tj1Qgy8TMxf+EEm83JyUQT5lqqDL2yT07077iTeSY95snFb9ClBRrzgIS3C6uYFqXWfqRUbXst8uLEY7GvXE9KydHo80PS8vEg9HqYqUaxCZgxRFrOVeFMe3bcZzgfShLHxWrsVPhfG8Sq7EKv/gVk4OIZSnquN1RXFm/GAd28IDFguwVKPTbE3lp9NYHqsjFxCIK/S1Rse9UysJ744rqZidjAypYJDHKkWWRCSBuBNj40BCEMOOnQGRFs6meXmlufguc5CHRZnke9CZbCGhFIts2MC0hfRs/6vt839OyzbQYOn5JdAoQmdu2zd9BMEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHSN62lhcsxAa4yWYNu60F4Ro33s7NYfkZJYu252SSc=;
 b=W72ORHhG74FQIo6h/U5772cX/zLFgGPiYk44ZuoUCa/lz5BwxML2hDlSBDu6dcu6YIz2r2BhRBOYws2eKGoYUUQo5kWKB8C9SOo/WgcrDNe5m5bStuBZ33eg+zPuNNvDtS6DXk0tqAUHkFZgbiGQQADadecibiUx9YAQOsHe3Xn/PUpHtjPyxUs4SiCOetSEx8sUdghLy2h1xy09b84B7CnV3mjMmkoMO2QH+u+P1f/Cl/VacuV/5DM+M+PHIC/bOB6Z/tZlofTONH86fWCfMuh//YFh6ktO9Ffo07Oawuxt9sg1OZQt9k95XNOaLZHTZtlH68s/v0sg99lBEzPEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHSN62lhcsxAa4yWYNu60F4Ro33s7NYfkZJYu252SSc=;
 b=uoOncj5mUZ93VDFol3DWDVoOsS3WjzOdB/SOmzUc/PfieMni0qEpgReo/umrzu/+j2xnI2WY9I6u/KCVNveLFaFsYCw+SdKQg1I8fwGVreTKRKkabCVpOU/rb8nh1jh4ZFQL9ODl/qRNuKy+r7m6ZGbkqfo2SSQOWEq1KUWdl+I=
Received: from BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 08:53:46 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::dd) by BL1PR13CA0023.outlook.office365.com
 (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.15 via Frontend
 Transport; Mon, 7 Oct 2024 08:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 08:53:46 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 03:53:41 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.dev>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<dan.carpenter@linaro.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 1/3] ASoC: amd: acp: fix for inconsistent indenting
Date: Mon, 7 Oct 2024 14:23:19 +0530
Message-ID: <20241007085321.3991149-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
References: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: bc27497d-96fb-4db8-e16e-08dce6ad8e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F949k9EmAZaT1Wpljzf2lhtEV6q+esmMUDeAN/JxMdE5af8zeAp3Lff9tdj1?=
 =?us-ascii?Q?aJVG/sDh5PYKQcAGxx6KeW/SYbR/SPkkRlxEnNzQ4JyNik9/+KM4RjjpGFJl?=
 =?us-ascii?Q?rW3ZNN5InH37Qa0pzBjUtpAJ4r2pNgfjqSyitp6inbYmuVZGM8DUbNumYKi3?=
 =?us-ascii?Q?N3OQXGJVu8YkmQNqfaZVl/yhQEuGIRzoD2wtPmDnwiOG81mchV5FaF3awH9A?=
 =?us-ascii?Q?xvkEm7vcgdkTu8s0vovyXhO8TKO3AudO6OmVFyEsQ2pn99yzhlf47tnVgYHu?=
 =?us-ascii?Q?F202ZtCls2DFyuTf9ilwDaQm+EDsiQ1YYZZouU2CljA7jE2zWk7CVgxhVdLZ?=
 =?us-ascii?Q?f2Gkop7s026o79Gr+Z5VDVBVG6yoESchHRtEG36N8c0tCFvfO4h2vSVl/Hrq?=
 =?us-ascii?Q?pB4UZdqpdXc4XhZE0nCtUGi5UtdUcsLEjheC0fPnmL7rM1nD7f4bBT82PRrC?=
 =?us-ascii?Q?5GNRvy9qZIycEiRoallgrouAUW5nvzPueMpPsejSW+52L4lvsRQdsNi5tsUz?=
 =?us-ascii?Q?SrFgFj0FtbyHKQ3832W6SlzcffhRQesvVk3dO1wTcx0BQp4HT8FnzIYz+waO?=
 =?us-ascii?Q?xPI8YC/Lk4HmfK51QJ0BNBAfqqnIl8Y+n2vn6jZLFbfihIoKhDDzyNU8MI0K?=
 =?us-ascii?Q?7tWg58Y3drFUowEWGpMXarAx62Em4MWVYypWVjdDQTUqfNAFJw4FkfCp1piO?=
 =?us-ascii?Q?j3/cBt9LYW6yin6lSDknFld70tpDvEqotqX7448ZqEHJ8me7SRjOyZWbdF3r?=
 =?us-ascii?Q?p+fUJMxQTGvX9E7JZxxsHEtjf1xk5Bwa64vSP/S6D4uOa+pWlVLuAMiUGhQy?=
 =?us-ascii?Q?mKeq6n/TbUfMhyYzNXI0LRODtjJoupEy4GmVTB5YDL8HT7P+rPN+CP7O9qY6?=
 =?us-ascii?Q?ha0WJOHxUEUNC1FvtJGokegCJXzw8M5UpqznuKjJ4ZSf19eG7Qmluh8yh6gm?=
 =?us-ascii?Q?OlIhdAV7NfR8WjVcaGqzfMeoUyyuXcZrq8WlDFpFIef1uNAIdxmz4f8XJOH4?=
 =?us-ascii?Q?8pPIJ4vB9ErscI8nsQbudlLCkPXPmkM31nSczDGnNqYAF11BUJmc1D0S9D1r?=
 =?us-ascii?Q?DMYGn4KDND/31i9jbmci6FFwm0ZWX9OE0XgZWrWLOwwgAb4N9fCBkgeU2E4F?=
 =?us-ascii?Q?Mv04IR/kiZrbFlU8l1xHZUd4kjyFCjUDUb71uoo37fJy4bJOU2CTtljRM2mZ?=
 =?us-ascii?Q?xfTz63YBtNepDaUi9XviN9VQQUm9iLIek0/EdwPnbALaR50qCss848ZDw4EI?=
 =?us-ascii?Q?qXtEGxWL/lqc703qPN0LrgP8/58mHQgy3NK+n3OwGCHBAVkJjPp02P0SPLYI?=
 =?us-ascii?Q?hJe5xh7zuTTeGkEgv+GZVCg8ViMXFavR9S9tcqdreQhJhARZu35E4CgPLfQs?=
 =?us-ascii?Q?XIXJruRsy1CjC2OGduVvDT49EYlz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 08:53:46.6515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc27497d-96fb-4db8-e16e-08dce6ad8e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

Fix below Smatch static checker warning:

sound/soc/amd/acp/acp-sdw-sof-mach.c:365 sof_card_dai_links_create()
warn: inconsistent indenting

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/a201e871-375e-43eb-960d-5c048956c2ff@amd.com/T/
Fixes: 6d8348ddc56e ("ASoC: amd: acp: refactor SoundWire machine driver code")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 306854fb08e3..acab2675d1f5 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -362,7 +362,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	dai_links = devm_kcalloc(dev, num_links, sizeof(*dai_links), GFP_KERNEL);
 	if (!dai_links) {
 		ret = -ENOMEM;
-	goto err_end;
+		goto err_end;
 	}
 
 	card->codec_conf = codec_conf;
-- 
2.34.1



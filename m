Return-Path: <linux-kernel+bounces-353039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C001992793
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C498A28381C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B89518BBB7;
	Mon,  7 Oct 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ExpCYC7M"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732DC82485;
	Mon,  7 Oct 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291227; cv=fail; b=LcqtxepvgCL/3j7emb6QXSvy9yg76mTTU0NqwA/bmQBLZotd/lgfO8TPCGuDJP8i8ypVxy3RACvID5FHPDU/9bqpfKfSwZIt5N8e7GqvM2JlYYFzmQXs7bwGOxDzrBXYT7irdePsf4LiwRr3J10qASQVPk0xYHq4CWvccgcLOSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291227; c=relaxed/simple;
	bh=9aov2+c8SZZyFU7dy05oyfwvTugfFW08cHIIdjPGTLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P0Y7AF6qq+T0gh9Ekt7nCu10VgXeWZV2NkSqJ803VFhANLY1/PboKwefPmEW7iIey4Tt4KrfcgfytqG8EMg2GX4EGc0UeZqb8qLL+lzYEs/BPEzhYTW9vPz+1MFbgtkE4N7UE6bleYWhj1gos0XtQfHitJNNMCbp+wFSw3KDnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ExpCYC7M; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxn632u4ld6M1yuBrBgesppFvCnhdlQhwH3UqVLFuxvSlf+B6Xaoeh708Ja7zApCDD7SsA7cimuIR7+pD7Da3O0dfghsA4WzOqpnwiY98zRfMLxU9IT1SRfQlJX/RI5OF9y30AnENE+d6sOBxzYiQjNpRr9o5PDjpFzwOoRw/0ppXZz3mle20g+zEZ5KfLO3bFE1ed7Dy/s8tpVk3zF/ojPkhCfIrWN0I/6ozOcsidQfJLqFNE97WLM/60dSOFHfGE2JQ7DE6rkB7h1dWbZhxGVxTRhC2yjxB9e63VNcMnlXqW6D9RkhpiT7OJANnLGw6delsf/RT3BXoAWSXp6XCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y4hxOiBVN12gJpatf3Xa4RNzPJc7YZuyZMiBm3RvQY=;
 b=X5I835PMynnlbGZCoXEmBNo52oD0WmsG28s/a2Tc+K6V5c/db5JGP5faiiz1q9X/69akRou7gV9XOfcaVS3ESt+acJHgQetgO1ql1ek6Q9edVsiVpo0bJMTWQZ2ivi2MAra9b+s39bDwxjS0NXeClvC5vUynrgUfKsQ0Q7Yj9KMcnSfQNGoZOkA2dnlL+GNkXC9TSx1nefx7zyP4vEhZXq5UJtbmuZT4LMij2cvBpkzcKUQB0bFGUpzR3f+i60xJtktQY8Cazdxi4lIRcTx/6hV8SlLhNRoEgKBtinpA1N/Sz9vQZsu5uTgaUxbRsw9HK0bNdkWoVHqGOKwL96ejDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y4hxOiBVN12gJpatf3Xa4RNzPJc7YZuyZMiBm3RvQY=;
 b=ExpCYC7MIejj3Xy9k7Q/tmc7eOjOJB+Rni/zGKQDeAL8EMVn5Z7GHrdSXm563mfnARj+anrnc96JX1JF9stL0/CFNEW7ijOPYyITbLoBl3yUtOPiqwMwyuS6Ux9SbI3WxKcibFx7+UD7BsdDVtZkCxq7wpKzzV9TlfbAoJxCmsg=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 08:53:42 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::a6) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 08:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 08:53:42 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 03:53:37 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <pierre-louis.bossart@linux.dev>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<dan.carpenter@linaro.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/3] Fixes and improvements related to amd soundwire machine
Date: Mon, 7 Oct 2024 14:23:18 +0530
Message-ID: <20241007085321.3991149-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: ee359e12-a7c4-4efd-ecb6-08dce6ad8b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?abXBV3vL4xUGJsERo4ktpNOPTZuxioI7Y9rdKy4NWDwXWXQCFDmDCrjm5oYF?=
 =?us-ascii?Q?uEeF5qH9FR7WHcTKFJm1OSZFlWf0jpsNOhIXFPH9ACH70Nx0iVAX04vF9Xcc?=
 =?us-ascii?Q?GemsQxqGecSDYRHy2OJZlsty7zp2tLusIG79ljEh1H/J7YgsIo9fl41i+ZgF?=
 =?us-ascii?Q?Wv+hJCIJ27ofQl8wV6h7fl5IZFnt4jbWi7BddTO42Q8/Mff330JT2AwXTgiT?=
 =?us-ascii?Q?dv5lbyg7+HW8sSj7iVMItyNez8Xfd9Nrtd4AKM8xyr5y5eN8MbtwYbkVbURd?=
 =?us-ascii?Q?Z9A8CwRJEqHE5EtuqzE1He3BqmdLKxmiV4JY4Kamgz4qf2st300ybqGea7vz?=
 =?us-ascii?Q?vw7m/ycnYa3IOKiLKJws+E03f79CRB3RPv3ebr4jdsvp9LlUZ76mZTVzWMu0?=
 =?us-ascii?Q?iKZs+sVQlitKbPLUj7Tc6N99Fo/W1KxdU1ksDdWkLfsu3ImUrT6beTmrByXs?=
 =?us-ascii?Q?2yuv4StE+w9Gf7GW04MUiri67whUMj7HD0z6Hpti6LfGqcEdkPNy3195eFYo?=
 =?us-ascii?Q?vjGS3I5NNp2K/cw+WU5dGGawT4g+NqhrgzFAK11ursNuMkiC9MdYuszQXXwA?=
 =?us-ascii?Q?Xp12fIM1zvQIoHdFeX+hWPJtOjXQGO2aXJQ8G1xnyb5358+dafeQQZqV3FSy?=
 =?us-ascii?Q?aRTxh7boGSFmAd/J/CF1aBLMnWJpnOquegijD5BuEvjHk3Vfo/dr6oV4epC9?=
 =?us-ascii?Q?Qd3aJoNyS4Nv75fJDZUBTPYGxhPx/LBJazH5/Mq/Q8u3R9rT5irK5DLFkZZ+?=
 =?us-ascii?Q?Hy7eWW92gTTyNC7IKTgLEi91MMNdfX5+lfm6YA7Nijob59AzsN6t5qAMopNM?=
 =?us-ascii?Q?X3DyJtPLj0oT2+8cCl0iQKhFw7qFz39VXXKIilAGjYXOx8w3NyFRv0mt1ijl?=
 =?us-ascii?Q?gC8e9aqBYyx2PD72es2ze5mlj8StWCu34Lz/OCV6Z5DK/7KzcXtSnMhH7AHX?=
 =?us-ascii?Q?ot1ZK98as0Hzbir+2SlWH3esYL/MPpdBptxlmXPodDziIfmZ0jMLkBxPmco8?=
 =?us-ascii?Q?ccVFcFP9RFdjyj84gdKHNJPHyhzJ8Kske91XUR0lUwZU0nycsJfnXsmYHR2C?=
 =?us-ascii?Q?IYta/m2FdpHGG2pTU/GLten3g2vGxvJ0wjYR8+P/ehPW3NHnunVn+AmDOPsW?=
 =?us-ascii?Q?+SyPHjDiQuCX1KJgY7ipxi6xo6ktQeZur2mArXf0hRridmkDK0pppGClHj5o?=
 =?us-ascii?Q?HD0iwRTu6s5kdk1b8mECD2SkbNV8BnJfAGtu0tJhpOZRqpIt7YSYBl/Lu8eW?=
 =?us-ascii?Q?vUV0XHs07oSLAPMhywTjr/9W2kuL4mclO6B2qbCBMvg4KCAdBn7Nlqkk1MTz?=
 =?us-ascii?Q?Xx+EaBNdB8QqZl21tLzps5ltELCX+S6+0c25hxcX87DCzlSb4mVclyurntDO?=
 =?us-ascii?Q?lvlovRhH6JXypStdZveQY8nbQIjI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 08:53:42.0603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee359e12-a7c4-4efd-ecb6-08dce6ad8b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

This patch series consists of smatch error fixes and code improvements
related to amd soundwire generic machine driver.

Vijendar Mukunda (3):
  ASoC: amd: acp: fix for inconsistent indenting
  ASoC: amd: acp: fix for cpu dai index logic
  ASoC: amd: acp: refactor sof_card_dai_links_create() function

 sound/soc/amd/acp/acp-sdw-sof-mach.c | 47 +++++++++++-----------------
 1 file changed, 18 insertions(+), 29 deletions(-)

-- 
2.34.1



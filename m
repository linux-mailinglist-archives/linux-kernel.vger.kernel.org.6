Return-Path: <linux-kernel+bounces-553986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D2A5918A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DE97A26C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDF226CF3;
	Mon, 10 Mar 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8EOGT+5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D501224234;
	Mon, 10 Mar 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603576; cv=fail; b=qMYKITZ5J+jFFwTzA7P07CMKKCzrZtcY4YaTsILSxBcvjhE8cQB50PNfu7IAarI0ni0NlEZDkjuaaQvasGRYnESg83ikJIPUda6xgqMU17Pf0kJP6GK0L74myreWlvIp2kTX0zF5jk2zdjoMcfvEfSDr1Y5OrxmRpvXJS9QBwLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603576; c=relaxed/simple;
	bh=2BP6YuyeU4WhFXCNvBTr+wMceAJSBSimCl9+O9wmgjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcqZFVSjhnbKw9dEjEDatu6kDsTCjhJKKr4mvvAn5D77hhJpGG89ZoUGJQ/VLxUd8o6PVbPRSTctJ8MfY8VSZgqCen0EGZrH2nV15kFskNeu2MRw/7X2Bh9Khz0Ct3jyhlCBdeT+LAS9TXR8slBrvVMMPkX67snAK10kfYsklVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8EOGT+5; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl1XC574L0d9BO9uQV30LOozNH+4tpswMunaM8Hvk5i0pR1GgYi2jIX+vRge3ytJ7bueN4vxlF+fOo3Ynx/AaZgt4b5b4XH5lfD8c9qyPP9tLGNAmVDLbSBzW3IOb6fp4xoaebDvr6HSDJAaBxdKiGAdPeQ2PFSgv4KAStQDvaMy9DkJ3mdVMY3+QWU0feyj9jwgH+4+YXys6tOB0eEkgGtXytp2V8NdqBdWO8b+21caC17QPuSy74ksLA0vE2yxtKDWr6/ixuQVPj/UJeTPVlejx1+0CFGXckDNMiG2udPtjdJYaia2VqdnMYblHUQeljiiZnyb8bAo4uEVAYM/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+bLPr6B0TtWHXRNqjxV0TEG4yeJkcpDDbO3jsYEi6E=;
 b=ctS8HmxavPfxT1ENXkolxgr5629fbVgU3OaGP5WoNv5YL7c88PppH3inlSpdfRIFJ38Q2lx8SDWsyoVB7zicNLTFXWFmaii4axPTBEb27riEb1bO7z0OBPQTgjr9PqMUzycCZKOk6fJD7ow64IwGRKNM9TNfbB2zgxrOcwhmaHpfGKkwwMZ3DAC1wCigroMlez8ZlchK5nPcE0ne8uKG0n+56lSSf0BVKxCUf8vx6Q0Ifqr+gvXeRpRu/K9Ps8M10NZdk9Wo+mgH1aPD1iKmE2v0ldKiIYELmvquEa7jPrZnPtTr4SxXslP2pAc/Naimx+B4+6lZxrZuvnT5BSohuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+bLPr6B0TtWHXRNqjxV0TEG4yeJkcpDDbO3jsYEi6E=;
 b=Q8EOGT+5I5NAwTTj0ECtJQzTtveOEaPl78VR/qleVKn3KDt0PXiXC+JlzJ7QyfxWwGFfpevLBFGKbYZ+ZXk/UEjnzNatUA8CBIMkBESNdPlgthwuym/YQxF+xJAM1KJXof/zR359l76ncBVogMkyCErRqPmoK8wkXzeK13o4Pbo=
Received: from CH5P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::24)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:46:11 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fc) by CH5P222CA0003.outlook.office365.com
 (2603:10b6:610:1ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 10:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 10:46:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 05:46:10 -0500
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 05:46:06 -0500
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<syed.sabakareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, "Jeff
 Johnson" <quic_jjohnson@quicinc.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 01/14] ASoC: amd: acp: Remove redundant acp70 chip->name
Date: Mon, 10 Mar 2025 16:15:48 +0530
Message-ID: <20250310104601.7325-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
References: <20250310104601.7325-1-venkataprasad.potturu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6cc797-f17c-4376-51cc-08dd5fc0c5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gS1ZR9qIcoA/zj+WZYkJ8AIFCcKSnnVvJPnUsNEPeeti1/f8SErrCljNqJbp?=
 =?us-ascii?Q?vQ8xHrlPL/Y3xIm0pVh+grij8E5A/6DuS/9a9w9aMSlH0/tswOWo9YAeHPOE?=
 =?us-ascii?Q?ZQecnluex68FZ4PId/vnjM75dDhswSS3l4QNvfQr4nkuQqm4bfejTVkDSwN/?=
 =?us-ascii?Q?MKQ4FXCMWi45JeZhI7D+jqmdYMHzU52mRQhObQXJEImdSLjEtr/HJ33twRRY?=
 =?us-ascii?Q?s/0MdFD2mz8T4bKPppgCjd9qg5nWq0hrNwpFukntecpc7+jgO0bKxR8stSvz?=
 =?us-ascii?Q?XTfXL3tU0fvKNtpJJrzL1TQUdsF8hF0feV5Z647dagxrGdDVYe0csDK1WQ+U?=
 =?us-ascii?Q?4VFto631dB4U0F0rDJq168ol1gMxVDijdwVOHiSrYLxEY4TkpQAkHqq/6eWv?=
 =?us-ascii?Q?BPQzlIidkukAmmW8u4uDnD5U/KFBgGIrNGkvD0z+7Zbw/bE1rxKKJgFJKEnf?=
 =?us-ascii?Q?iPAen2kQCV4y9G7UZu/13EOhqOeXxUwEkeI0f6n0/G97rm2Ih9NBWl9+0Ies?=
 =?us-ascii?Q?efCGvYZqGc0KtxCB+OIY/4zLNcM7xF2vj111XeNx2g349Cp7iYos1bxGeJ1a?=
 =?us-ascii?Q?8gFMKNTI2hYPbhg1FPEJkwlpB+zXOPsB5cR/3drx43bExLXWkIaFgsJLLBQ6?=
 =?us-ascii?Q?6HBPfBjtMkbmihXW5+5N1JQcgezIMgplEJYBMkmG+FBML/QUw0ii7tvzzSzq?=
 =?us-ascii?Q?kMs3YU+UdhCObjh7pAZVddWe9ijAsSHnDHGFkWSuAVzjteTojEuLulV/6nJb?=
 =?us-ascii?Q?ljryQKK2IC3n9eTbhXXwERMCypIQpjbplJmRBfKQacXcFHVLKBbwZkqZnbbp?=
 =?us-ascii?Q?URJlEHJKkbHip2JqWtonPOBkw1P+WKm8AXv6RtX3FOAIDOh4nme8rfnR8PrI?=
 =?us-ascii?Q?qXadNHwZVk//ZadSpQfShTdWMcvl+ZeihAgLxh0QJ22r+ZHZTBZ1P7BsHuEc?=
 =?us-ascii?Q?CDp0xoXzGntSwwTv8ki127oCV1uvkfjnWlSoqbUrjomkq53GbBTX3BzZ6hZO?=
 =?us-ascii?Q?Say82t6HtkaTEcPPi2BGrzICVofm4/veYcY9vY1A9ZX35+ZP0NWVHuKHd0HC?=
 =?us-ascii?Q?cZXfcttFBl9CPjQP9IS5nbl07jAfKXSDkYDRreMVZJ0sc4j+jPuZTP7TP/F7?=
 =?us-ascii?Q?mglYNKSrJYP6RQvFfPGD/FPHJFIJhDcRM1F6sfSsi8Ez96+mArwy8YCBGKnJ?=
 =?us-ascii?Q?9kpzyRy280ZZF/s5Wd5wJhYVZxPNkZgh6dOyg6GAAiT1f4p0RiDiOJZD9i6b?=
 =?us-ascii?Q?CaKVKDio/Nz0UwWFZr9dnySc/8sWnuuUNaC8sl4zGuMKRUSE2cwvHwFcC4Eo?=
 =?us-ascii?Q?1TVW9x9Dka+ZPnY7T9jd5arVv1b0n6qq0ooPPh6AOohi8QZ3sQLt/gZc6A6n?=
 =?us-ascii?Q?G9ng1vuMXg6xY3RLZr2chyHOxX74dHf4sXzI2InNq9zZCxz/2Md9nfKD0d58?=
 =?us-ascii?Q?2ijFIzctctRpNQNSFHK6BaBxZAGqDbX0QS16g/f3qJY1/LQHxX9mONE7Wgpo?=
 =?us-ascii?Q?ullPhsHi6fTw0iM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:46:11.3017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6cc797-f17c-4376-51cc-08dd5fc0c5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

As acp71 platform driver uses acp70 platform driver, remove the
redundant chip->name.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index e0fc42d939d3..dcd92d716e78 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -89,8 +89,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		chip->name = "acp_asoc_acp63";
 		break;
 	case 0x70:
-		chip->name = "acp_asoc_acp70";
-		break;
 	case 0x71:
 		chip->name = "acp_asoc_acp70";
 		break;
-- 
2.39.2



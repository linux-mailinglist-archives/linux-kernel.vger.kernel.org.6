Return-Path: <linux-kernel+bounces-282989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EE94EB8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471A4B21F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59126171088;
	Mon, 12 Aug 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qzFhkV0N"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA1380;
	Mon, 12 Aug 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460744; cv=fail; b=qLpT5ztOS3toLphwB48b6aw1O9PSiQOlahkJFvmNGTY+okxi1TGyJvBl41XDfdwf7qO0kY/J2F80cQvKSMDjL+4p4Pm0zqXzHHNzlEaeOAQQqtXHKnHbxjIhuaNhB6Qj2yjM9xuiMYRfG9qU5igEVwdDHAfarlQBO0R3UW2+b4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460744; c=relaxed/simple;
	bh=osgcTZUrkoiD32ZG4ReIvNWe5P9CUkVYN3OBkKc34Mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UO7F03s3X8fUeJEAk0LmByB7OSq9PjJbkjvEhfn882nipDoVBSf44P5Sky2qBQHEBXWUhbJzwUcMxPzQwlw2XV01ZHmsVHl83RQ27taiAQ/+P7iNGg4GEkHicvJDsd3xfJxNU9yOlVQGFnlNN3PHZAvwtP0vZ7p4nu+DxORnU94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qzFhkV0N; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJJkfiyUiGaEq0Pz4DsxJmNhMxPfDmdq53BrbFsJOzzKg7kFlINoNYdf4KaoQ/EXa1BGFmoI6jvwJOSqb77wmh89tQ0PlnWHWSOyrbZiCFjmIU1iybvperjD7ackGu/B4N4pK8CVxA+pNOxodmPwTsfLXrQnIURvU2E+Vy2mfd4jN9/uheNUEFJCQW7hZkIGcSXEySpnGK8ITGmMpNEGa7Qj1UJfX/4XNYBCYTVHj3Nr7Z8vdctZQmmBerze6Z0gBeqx06RVCNhCSl6D/MG17yURxb2G7Tyc4AXgkryZlkHNboOnW+Fu2kviI6rsr8IB3ElrrwAyWywbFcL+gPLrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/7oqyFA2Wkvs7rRwE9BS+U7EDeuAagFVp0/Nq/B1cQ=;
 b=FjAL5Q+K/5n0FiXkZf6fb0gG6Xond6zXASqaGSBN14eWokaTJjGlQw7v3NO9TqnjUglAHumuqxhidRYUcD5UPb3B7T5UyDMc88ahlMbA9vvqnxry0DvqNG6S7+bGeL1tpN+J89DQAqZlF3ziEbvi+tFk9YTLZNBbdUrwIlFlxh1Npr93nUr2eaHyYujWWvUjnN0g9Bcs3cf7aghAkj26gPVm4M7m+rbuMcaF9NFMjxffJgT6jqNQHC6D7bxZirYG3GuKzT72aOPTbWY1ISvtbVQlofp7h3dXSL3mo7HLoY1PIi4bX5nWsgkzw6QHwFsunOOV7zIi3QrupQFQz/tJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/7oqyFA2Wkvs7rRwE9BS+U7EDeuAagFVp0/Nq/B1cQ=;
 b=qzFhkV0NJBm9tXvlpj4QqkgGA0c5YgtIx310c1uGDzeOq+U0fPziPfMm1RU1tP624ogD/LGqJaG5pq/mO5nZ/kRQUNErckJNOfGZwS9+82CdWAVVR2D2puY3lE5j5xlY5rbXrNg+Q1URSSiu619t/gaG+1Fex5SDpsMQGJE35ic=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 11:05:40 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::3c) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13 via Frontend
 Transport; Mon, 12 Aug 2024 11:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 11:05:39 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 06:05:33 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Sunil-kumar.Dommati@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <venkataprasad.potturu@amd.com>,
	<pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<cristian.ciocaltea@collabora.com>, <sound-open-firmware@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kai.vehmanen@linux.intel.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: SOF: amd: move iram-dram fence register programming sequence
Date: Mon, 12 Aug 2024 16:35:09 +0530
Message-ID: <20240812110514.2683056-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4396fd6f-2423-497f-813e-08dcbabeb355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I2BMaDkROUQLrha3uvsF1+VpclzICqKsXJOdxDzXd0y+0POcJfirQjr5rLvH?=
 =?us-ascii?Q?MRDN0dWs2/EEL8QVqFw7DdTLOOfo9W7DFiOPHBskVEGUfcSdwKnlZpLC1H6M?=
 =?us-ascii?Q?eqoNIi9Z1f+VG2LdN/KwCq5RjbOG/5jO6IgSDem2/zdNCs1u9TRY6JOGedpC?=
 =?us-ascii?Q?4Rti8KfTy9nlI1BA6Ycj+PclkLOWdJRWLnXF3r322PuP4B8aPni7pWEpjOa0?=
 =?us-ascii?Q?J6lP3JVfma19JwuJsDAgsdaIjNNXUeB9lnEdr/pcNqZn4gK4lDkTER6zx9ua?=
 =?us-ascii?Q?neAgL6IKKEQjaacyS29cWpGbMtVYH1v9LTTUHdpmhCDAecCzG1Ma7/xCN5Qb?=
 =?us-ascii?Q?kV35wyUkxjKrtVkXNaYBWTOUJND0AcaMZSm01BsXkqlXF3ozJoCZBSzpc09Y?=
 =?us-ascii?Q?BBgRrT/inzOCTMelYCmZBjw2jehL9ekZiP77rW6/FU4etqBdfINsj96wx8uM?=
 =?us-ascii?Q?gkovSokbzXTggAUwJ65KEeJjEch+MjNQnJ4zPsbWuAMVCYnJRZDcZA3bP6HR?=
 =?us-ascii?Q?d7oNj+fmb9LFD0BSO5wIOS0UVXC2NX07pQLK2WShbbIrfEgIhpy//aDTMehg?=
 =?us-ascii?Q?nA4P94AzbL5nWSSBQ+ncffVN8K3dEUJv+aZxYQ+9jNQxW8NcmI39G0iCKCCc?=
 =?us-ascii?Q?CHl5qfQ6xFdGE4JwPwMHgMdiZu6eZeqyqdAh4aNeTT38N9kP25fByIdmunGD?=
 =?us-ascii?Q?UnT3fD5mnLtONpD1k5mahLq76luCMyKFyj6llkniIxQLfGrnLY/hKzn8oKTw?=
 =?us-ascii?Q?3eN/F/QVJhtmqXT9MmwifgK1AmG6f1M8PCfJgVLx3UQzvQpqFjv4oKB3HT3p?=
 =?us-ascii?Q?nOc2Avm//zpz//e4Mw+HwO1wVvH+hML63fYr/35kjsXkwGED6loDXmSQdNMw?=
 =?us-ascii?Q?/Xo0kjQCVqPiHsI7Wnao9qSE/RQTK1/Ypsa3CSsqmkMpY5llz/Nr8LVddFnX?=
 =?us-ascii?Q?2EE2GZrTGGwZL0eAzxddTQKa6bu5RmvTNySnDh97r7E+fJFf9iSgH6YkXwCi?=
 =?us-ascii?Q?cP+PVhE91tCjsnOlig93blGYnv4mFP64NXR9ZnOaJTLHyLnytjGuqJrYcKCs?=
 =?us-ascii?Q?9xj04zrgeCk7OLc3RQN63hrusNhJ7uqb0qQfSmbo5fQcfKrwM2uklUheDKWE?=
 =?us-ascii?Q?4mPB0MR7eOTwjRtd5Ygur3/dWrgmzP40psQVL69/S3PIAaurFyEKfsQOZTgj?=
 =?us-ascii?Q?VFYSiLnCknsDZ7JhPxSUUquork4yXDP3HckHCeKREzQn0qEzR8z71VJX4UHf?=
 =?us-ascii?Q?AfePAEYEe+24oZz55lAYIvi69m2M+IT8aYKTQgCAe0f/VhpgO4nEMaUPOF86?=
 =?us-ascii?Q?mQ9/uvc/Jq3IYrhi4eZKfCqn0gxyjDh6nUjZKvCYW/8QU88RYHAiYzdLS/91?=
 =?us-ascii?Q?ORkVZD87skwUCwjWIFjD3cW/C9WguPuIj5oJB/O9hzVoHn8u8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:05:39.3951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4396fd6f-2423-497f-813e-08dcbabeb355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

As per design, ACP iram-dram fence register sequence should be initiated
before triggering SHA dma. This ensures that IRAM size will programmed
correctly before initiaing SHA dma.

Fixes: 094d11768f74 ("ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 7b122656efd1..b8d4f986f89d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -263,6 +263,17 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_STRT_ADDR, start_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_DESTINATION_ADDR, dest_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_MSG_LENGTH, image_length);
+
+	/* psp_send_cmd only required for vangogh platform (rev - 5) */
+	if (desc->rev == 5 && !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
+		/* Modify IRAM and DRAM size */
+		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
+		if (ret)
+			return ret;
+		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | MBOX_ISREADY_FLAG);
+		if (ret)
+			return ret;
+	}
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_CMD, ACP_SHA_RUN);
 
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_TRANSFER_BYTE_CNT,
@@ -280,17 +291,6 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 			return ret;
 	}
 
-	/* psp_send_cmd only required for vangogh platform (rev - 5) */
-	if (desc->rev == 5 && !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
-		/* Modify IRAM and DRAM size */
-		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
-		if (ret)
-			return ret;
-		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | MBOX_ISREADY_FLAG);
-		if (ret)
-			return ret;
-	}
-
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_DSP_FW_QUALIFIER,
 					    fw_qualifier, fw_qualifier & DSP_FW_RUN_ENABLE,
 					    ACP_REG_POLL_INTERVAL, ACP_DMA_COMPLETE_TIMEOUT_US);
-- 
2.34.1



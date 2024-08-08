Return-Path: <linux-kernel+bounces-279896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45B94C325
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EC5284855
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E919067C;
	Thu,  8 Aug 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EzNrThNF"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AFD191F70;
	Thu,  8 Aug 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136313; cv=fail; b=qQMwj/PTYozZbTLeo/Sr/s07S4zIJDNdplEV9jLAnOwt5EUW3iOK5bvP07LTUC8blkfCj2FEPmy/KuilpOiuF0zMjMSrk9wvyZ03eWxR/ChQJE24tnAd47qqtqttKbW1wAOSp8RxDt7fykmv7bx2ERHJvASQ6ky6c3A/HL8vMn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136313; c=relaxed/simple;
	bh=3Dcu6aJU8X/aJgTk736SCzyefoHjdCUG7aL9wcxERrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8mtwCLVYk6I+SJNMPjsOHGdJl4qeQ7w3Bypc4JC8YJbnIteAgAaim3Y4vb9Eh2XMxdqya1q/hJEhFo1lL3zNAxWv0I8+/8vGnDRln2SeOpoIZGeXQ1VOQHPFDegUvJLz9BWDXTFsIsvhsi3PT0mQGtoCmJF5jFzbJYK+1jIasQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EzNrThNF; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSldk5ncTv4n0aBIGe3Cm2BVxBQCGxX/gvWpks+vmBfN2blu6Rjbxr/KnX58+DKnnIK7kCr5r6vTi4223kPLYabUUqkBaZnWYFZFNrFCy04tjMulZ8XyZcJHfTjDWWvxS8UXXNuilLttNxgdE+ZpFctzPl7bXKz9Iq51mnT/Hlp+StQ+SYdm3+CtG7zGCzqdVoVVIMiFarv9O1wpdGSCTkiFaFHjQLIpLxs/cYkQ7zjvNIq1TSTEVzIl11sH9YX5EvotlODR+fEg17CeusTyGz4oBIwPRmN4Wi0XKqanTuCieLL1FNh9LRUxhkrIlYYY00h58m/7H/VD99rLrLQ3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2KCJG/+YUEu+WHixSrZZlPKZxJ6pb4opybJ0tKtTd4=;
 b=rqykIFEOEWZDyoE3gXusVrRK0C4SszWauoU0a6/5zSV4JdDbBehtjauuYB+zRKcXAmzvcMAEUV+WKEaOZaf6VJX2raCgmjlCguqTAqn5vet6jpfN0S2RfzrvVpxYmfpF5819L0tVrQZPtvi33oM7VCvikspheFG6XGXbQtRkhc/RteSWkJeYi1u76v6CJx2pK06XMFE/OzU0wLLuu8JxgH01W8ouFeSEFcEBb5kOYk5abSfgMkkycBerCCnwBFCHD5m26cJPJ1pBv8c7whV9LtUTA6ZWQ6o/Tmgn9Bw5JolqynU6zp14i5lX5aczM/23SjU79LtBgW6cSy1alWwuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2KCJG/+YUEu+WHixSrZZlPKZxJ6pb4opybJ0tKtTd4=;
 b=EzNrThNFt1tXRFuvHRiGOLjDHAJfciYsqRgVEXKBqy65IIqFBvJ15IRIJ81VK7QRWkfV7A+QNbesPDF2ltqpAgxzguz6/AbCSnaBU9mu3mNwZm7heorBfon8pCKVv0eQbiMjFNgkwhcDM66EzcvFrmmEcreVhc7U7Vz9ooYaoKc=
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 16:58:27 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::ec) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 16:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 16:58:27 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 11:58:22 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <sound-open-firmware@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<pierre-louis.bossart@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
	<ranjani.sridharan@linux.intel.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<lgirdwood@gmail.com>, <kai.vehmanen@linux.intel.com>,
	<daniel.baluta@nxp.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<cristian.ciocaltea@collabora.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>
Subject: [PATCH RESEND 3/8] ASoC: SOF: amd: move iram-dram fence register programming sequence
Date: Thu, 8 Aug 2024 22:27:48 +0530
Message-ID: <20240808165753.3414464-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808165753.3414464-1-Vijendar.Mukunda@amd.com>
References: <20240808165753.3414464-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: a84714e4-e8a9-4620-2654-08dcb7cb52d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKV+OQO2gn/MUaAu5SudUqR+DpNq7ZjyuhcJW4BEWdQvgJWf2vUBtPTYFm0T?=
 =?us-ascii?Q?auKIFcTkfuvexQ9FPEk1rcs14NkQ6fKnC+Th71yUMAUQG93KE/5H/R61Wjvs?=
 =?us-ascii?Q?691dTfc6ZZCO+6hCuGVNTBrowBShGgKKkL2QSJapPD2bgX1jO3JBaFvKnevN?=
 =?us-ascii?Q?fIkx0CpJXprVGyLprVHn0PRKhL6mHJy/3ff87UgmYO1Hp89yBCsFlN2NR/q5?=
 =?us-ascii?Q?bgBjPR0N977UWz6PIdr5CFd47dZbeZH5sl9miQUxo3WoOLa6Ql0HZTGlPdc7?=
 =?us-ascii?Q?BRIaHHdK40gA2OjXKvsg6y8wJUxRkcEM3veU4a7ieqC7CojfBlV/6txeJbyl?=
 =?us-ascii?Q?G9CTNRbpljBpdL/gVwimpfX53J1LJrLwqoq5XJOUTVc+wdIG/Ia/LG4kDCvj?=
 =?us-ascii?Q?FeZNHG4DlDubJWzfd9nErtfZOdjq5dh0ajR5Y8moE0GA9CgZxstfqtOKbogn?=
 =?us-ascii?Q?e6uNwJGsbvlTMEAN85hPCUOh5YPGkry5ywj71wWFLYGDUlZ9BIb/W9Do6doy?=
 =?us-ascii?Q?YXWPw+AsKDaoA28KjG9GUCBQ0ZrhSU64D04fhnnyc9kKWCkhXBVjR3H6R5rr?=
 =?us-ascii?Q?0UK8H3OL1pEdfwGRcOcQxnmx3vrPnE+dwhryCn9N3heKIm0+WK00mkXchPHB?=
 =?us-ascii?Q?7xJDXfWimNNUS9nnHm/NQpsI3A3YC215kNRwoiROLKVNmcI/GydU99l9qVfI?=
 =?us-ascii?Q?YtS6J9t0OTfdoX/FvETw3k2SffhmyZ/Rwdh/ulmBwKcUZ1AlTRj+9CqzqnZJ?=
 =?us-ascii?Q?zgKFdFidzMiU4htlKeMdwx2EoptAdn+yu4TKoTYKKByLS611Yny7ulfBr29q?=
 =?us-ascii?Q?C4cRR94Ie6ZnC1SxiNQ2kQf8QhttjyGcwnWJawcGexORMW/b9Vx5zUmVgesL?=
 =?us-ascii?Q?zBfendkop5msWvThGXjwDlXK6x8if8hxkKINknEzPg+fErBsjznFdCWFX28r?=
 =?us-ascii?Q?kZTlZ5X6mOmO00iJPzZA5bXJ4KZC+TjzMTEHREc7OJKJKUIzm0yFKsGNkcrL?=
 =?us-ascii?Q?eYMqEwilK9CJ9X6G/2UJkCkZ1a3rypUZIAJwxCgLrGJrsqQS0K4O+Cve6Yi/?=
 =?us-ascii?Q?buMA3vmmrb7CE8qH7N7s1r6qlOdi3+Mfon03WNYLdEO5zEFBcYjsRSnKKOs+?=
 =?us-ascii?Q?FEGTN0MabSHMgE22kMLHZxhqMLI/3K1j900b4+NxPz1M3wHp/2KusPgE0LRc?=
 =?us-ascii?Q?XCOZ+ZElSqJuMsZ79RKcQECyT5PcrlMdm/ggkrpJMqxedenJX4EuQGKFCByT?=
 =?us-ascii?Q?039jm4UwITLu5xrzEHTrF7FwjmFAsFJLrId3HN+i61BDFPPFhs/yC71kPRCS?=
 =?us-ascii?Q?Xkoq8E8hhqriysm1YUktvrdzgodz0PFGkHCcF70XYqJBu+nK9U558WBycRzy?=
 =?us-ascii?Q?B+1AfkuSNM6gpWbf+keb10F8wLIEKID32PpQ/JsjLBjDvXQH0GzxZj3iHYVo?=
 =?us-ascii?Q?GWcn5x7iFWzTf/+yPrIybjJlUa0rw1el?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:58:27.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84714e4-e8a9-4620-2654-08dcb7cb52d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548

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
index 9ce8b5ccb3d7..d0ba641ba28c 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -264,6 +264,17 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
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
@@ -281,17 +292,6 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
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



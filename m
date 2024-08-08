Return-Path: <linux-kernel+bounces-279899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0A94C328
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC40B24471
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB91922E5;
	Thu,  8 Aug 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qlq6m0b6"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FB1917C7;
	Thu,  8 Aug 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136328; cv=fail; b=BmlW4RU7tvDh9GsUOa1cXzj2ASou3tzg4/5j85rq6E7FX4Tx/Mv+MgKYrjkb4qhwv0qNdG98KnrD9BdP+EsaS1IyqpyytRmG7BD8VKfUepoQPX3Wsn6SQdNnUhZJyqWI+EMAkc0fklRwN8kgHz5kN5UqEKqOoc8TltlfWIq9I3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136328; c=relaxed/simple;
	bh=Yyh6nCD6uVaoGEFI0zqZzXeuR2btH2C6BgofcihcDmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1CVS+yN6zPQei5/sJd34h0v3g49MdBUXmSLoPJ/lPlzYsyfzxx/wQPL5iS6JVGGR2JI0bBRHLsCGgDjL04JRiRvVIyO16rbltE5zXScXI1TBp68tAiBsanm5fFucc0KQ9x//4+zIqNS4BRcrtkwGNqv/UqwaX07tNQgkfv5f7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qlq6m0b6; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P70PnH46ZFgJoCHPcRp9l5QonDD4iNgIqfKNxtfvv5kfMtsk/2bPInFRkpSavdvAx3g7eJYJhdnKJIs/2WTfGD9V1p/XcPSDBq8p3frfsING6yNwqrDWbPWxRaxSSlOkRh0Nxd8fJA4aIKMmn+Aa7rjyDO5rqEmQT8DwsckOsal1VOH0ZK491J3AxpNixbxxI3JLCYhez/guH7600uH+R6RbdRaT6fVEPZZ8lfjYXUt/yPULuht6dB2HalBiDozY/uTsl8ij2cp2baDgIhg3rmHJL83f79sWbTkWTpVJNbnhTJr7HLGQoQSQDZRFbCE94hUhaVpBybR1SCgtSnliPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+POgkQwJwZYUqG1jCGpOn1i7TKe6P4D3ciPqtPdWC8=;
 b=Z+uNvBnmm8y9hLf7WR2A/CH+q10oS9z3taRCX1cBpWcHskY4rD8vCmXmHtCClmIiLYUNBd5TqP70Z0ilDyITZpafvYmmJ6Ur8nnjwtzhSCxIN23/6nZEKaxapd2OozQ+GK6lI+BnxMH/T+r4T7WhWLrT1yCR1vRahoh+b8KayYgPnJ+ic9y6aHt8sxJhcWlL4/YmOwf0Ij/TR09BZraKelXVveAp/TaiQrVHq3G0y59kHnZ7053EbnLHOXI24aknoSK4G5vX+Ev0/Y9GbOcM1fK/5J3EBcuSr3Pq71wNvYMQg52RZdAc+hEXMo/A2WI1EgQdaLJDNgXJTKZXHYxnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+POgkQwJwZYUqG1jCGpOn1i7TKe6P4D3ciPqtPdWC8=;
 b=Qlq6m0b6qUCvgDVgGWZSgKsuffRx6Ai06V0hcC+PIZ09UiNkFHGzrDV4poFZhrFiWoOzDJ7Tri4t431Zg4yw3+doVft1dGkJJwev2hFOCNJv4M2wPNzSkmu7rRd4N1tP3WfZQfKXNY2GO14VhmrGC+8yPufst4DnA4hvNlCyrRs=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.33; Thu, 8 Aug
 2024 16:58:43 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::72) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 16:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 16:58:43 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 11:58:37 -0500
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
Subject: [PATCH RESEND 6/8] ASoC: SOF: amd: modify psp send command conditional checks
Date: Thu, 8 Aug 2024 22:27:51 +0530
Message-ID: <20240808165753.3414464-7-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef40d4d-8763-41d3-1ed2-08dcb7cb5c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mVb1Cr7/3rcI1TJrbDFtf0lD4H7ylMSW3JewDk7D6NJ0+ScMgpxcFwk6gqqj?=
 =?us-ascii?Q?cnzf6GDHF7gJdCApDS51Jfl8y+fNilhNHahNwoEnhEzzCOCvnOMUuwjpguWS?=
 =?us-ascii?Q?ExnTDZhpA2GbTdFmMdEzl8izorkDEcE3eLEd18twBVfxd7AlPcM/ETThL59y?=
 =?us-ascii?Q?A6ns/PQ0rIMg8YWeuS7KASf4jjo9wJBpBiB9pVHCHlQzGH131VXqK9Az6SBA?=
 =?us-ascii?Q?Bqq0gjxE+2pE3V0dz7ycugd8/jQLStQUBb1MY6T5afdVj6dvYvfPCVS/YfGk?=
 =?us-ascii?Q?69pW2YUfh/IoDHoZuqSXCZqbTp3VkOAjJ4cpP1lhZcRc7jIHARkq3mh8nWNr?=
 =?us-ascii?Q?DgPL+cJa/sP60MRfrkgpNjtKNEKzR2vjcHAWA/aJlqwKlYYvzRm5/rySi5Ga?=
 =?us-ascii?Q?hPFo/UkldE/vPniQGcW8V/WMWTpmqeHgyY3pd7doYIxcnqp25bmEBXUk5hzO?=
 =?us-ascii?Q?TqrAJy1qlPaCusnKkkQ+TfO9Pqagc/IfSLrEn9MO1sZ9gGyP88Nasw1qq01V?=
 =?us-ascii?Q?kSU6i6yM/eHZyUIPvJnVx/1N6qyLrZn5GcXsvH4mKUQQMuNg0CAzf5I+K+qX?=
 =?us-ascii?Q?sQmhKt7M8GoMHex2E4wPHstRQhrgyGDDZvJEk9vXuC5OzwcDavp7ToaUi13B?=
 =?us-ascii?Q?0N91VVAIqnUh6w5qsCFllpowsM3m9ArQz1XA22F2t15rK2EI1NHqQyUt/bSa?=
 =?us-ascii?Q?vtccGsW3cNPTc6MfYjdUS+KowUJ3A22lprSoY/KKMZ3YI3xVBxFKTPwh2tcb?=
 =?us-ascii?Q?AVzzI8sNGgbUkJ1Ob2D9KRhDGq8d2SGiKlpcY8RmS/JL85tmRqPWiiMP0mhh?=
 =?us-ascii?Q?lrfexqfgavvku0Q9Wm2Akhi/7SaDK0XoPIfV9IxJLAsXuQWWKF/i417/BRLQ?=
 =?us-ascii?Q?ZlrOkngudUfzFEJYUKZc1PP1wyA2aLABD57Ebje2yjtkB5HOEhhpzfeXH8ls?=
 =?us-ascii?Q?HrJv6Mkz3GntuQzR0QFvT5U2V9kdryXL0rwqhMnMp9SI2n4RixNBUb4C7bn3?=
 =?us-ascii?Q?Ua1kCsuvBgs8Bss5DxSJrdAJ8cGfdmVedV7dDadjTouNgLyVaYwrGpR/j6+P?=
 =?us-ascii?Q?JfixzLDBqXXtw87/fmhgiob7oQfyhCVNT0FZ8W1P774jnqE0YAjh/9SMIUc5?=
 =?us-ascii?Q?7oL0w/M4umJYRdoAeqpDrl9odJY0MhGfWixfSjktruwCK0Rnt+7tpOjqtctZ?=
 =?us-ascii?Q?KzrOItcsjDujp48F6nEqbKCnACT5FKgxknP2J7rW2SuVd28pUOOrllvc6C3f?=
 =?us-ascii?Q?V8SCO5Vc1bgelpspOcO4iQ7klOc+O0mvPqshjFUb9udKk+ideGwsUV5HKcut?=
 =?us-ascii?Q?3VkTNDebe3tqvUDig16FPIn48/z1vcUjYdulONTH2Fqqr+NlWXQgHthghshd?=
 =?us-ascii?Q?AF44xRoU0gD/rhddVDKAIcQq3M3Rw3/Up3oq46VeChW2hN5aCkeHCFE1lcuI?=
 =?us-ascii?Q?JV/+akjDMxlQ99O2Os/bRBu2NeawL3/H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:58:43.2452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef40d4d-8763-41d3-1ed2-08dcb7cb5c3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958

Modify psp send command conditional checks for Renoir and Vangogh
platforms by replacing desc->rev with acp pci revision id for that
platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index a9f32983b3af..a85f5eb54239 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -236,7 +236,6 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 			      unsigned int image_length)
 {
 	struct snd_sof_dev *sdev = adata->dev;
-	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int tx_count, fw_qualifier, val;
 	int ret;
 
@@ -265,8 +264,9 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_DMA_DESTINATION_ADDR, dest_addr);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SHA_MSG_LENGTH, image_length);
 
-	/* psp_send_cmd only required for vangogh platform (rev - 5) */
-	if (desc->rev == 5 && !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
+	/* psp_send_cmd only required for vangogh platform */
+	if (adata->pci_rev == ACP_VANGOGH_PCI_ID &&
+	    !(adata->quirks && adata->quirks->skip_iram_dram_size_mod)) {
 		/* Modify IRAM and DRAM size */
 		ret = psp_send_cmd(adata, MBOX_ACP_IRAM_DRAM_FENCE_COMMAND | IRAM_DRAM_FENCE_2);
 		if (ret)
@@ -285,8 +285,8 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		return ret;
 	}
 
-	/* psp_send_cmd only required for renoir platform (rev - 3) */
-	if (desc->rev == 3) {
+	/* psp_send_cmd only required for renoir platform*/
+	if (adata->pci_rev == ACP_RN_PCI_ID) {
 		ret = psp_send_cmd(adata, MBOX_ACP_SHA_DMA_COMMAND);
 		if (ret)
 			return ret;
-- 
2.34.1



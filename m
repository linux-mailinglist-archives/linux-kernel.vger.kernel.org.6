Return-Path: <linux-kernel+bounces-332295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C497B7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB471F22669
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC615C14E;
	Wed, 18 Sep 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XQnDn5TK"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F1149C70;
	Wed, 18 Sep 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640565; cv=fail; b=EDKyQbljjWkRZpF1lp+oMwKoKL9/KCbqL4GyYQEAsNmQRdyXDayxO7/Jtsp6f0HxjUZ9sCafDKUgce7GOg0m7+3oaLMgaT3LvpnsqhJFgVBP0gI22TE5FiSjc8JS88ab6XSSGW71i76rFurbf8cONGGiYQur5hBzizoOySQnHB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640565; c=relaxed/simple;
	bh=WjTAS1K2L4UWOtNZuASNRs3zvxWdgoRLi2uw7rJAiE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd3ljUwzMsVC7ndW033eBHKpnBMa6CT5D0fdcbBy5TEKA5uX0NesxexcoHDDu1A1fuZcuCm1aKl+BBBWtAubnfUOpvRg5rGB2cZQ7r/wHk4P81Iuix9PB2NHDDvifsJpkiDaCdSRO2pQmAiPmvQS6pM3e/DJ8IW4s8Lmh6psC68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XQnDn5TK; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTZwGz4Ntmh/lUwQKHseAOTCXDVeu27DzUaGSnNDGcoXLo11YLuoVFLxjIKu0nSVe3liRYgqZqUCQGmNH9UwOwDbXN/hlLZXSWq7qoH4ICsGtBSQ3Y5B9j0dXvSmwRsZ05E1Z4lXSYYP01taFS7KlgkQ3jIsUBdbHYcqiC7BJRCrqRGNw16DwFjRfmm1RDzAFbebO7v4BilK6uvW2bALZcSxHzUh28OOleWrjmh1xR+8v5uKn/SOwaahfPzamIx25GNT/gErpNQ77Iym5SQbDJVhuV43uqQpcJIDVfwvG1U2nlEdV7Wq7C0yogGhl3NMQBRy28OPNQIOrcPYpzKnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xACMO2b4h4TWup/kb8NMxouIM6azWSC3MNSN6Lodgsg=;
 b=l2cL2qSYb0/MyENWz6VlLQ9Fav9//jj7eCNn2IPaSXoGLQ9dJmnu0kujFbYwbwHRgeaAw2BCC1RgZFdgSmRDF8N+48btJDtI8823HuOF7RAXPcXm97FEmvbz7EVF8a9xVRTe6JcXJFAwjkfixFxWh6AnE9JR9JdN3Rge0mG7Z6D/OFIe9h2GtXqfEZBG37SZBDmPH7+SFnd1YsfbGxGo3dXwe9v/4hC6/ZxqbAB2SyYjN67yfHRBCo5Z+QKLBPnFSLjn4LwkBgi4SqU5fUsxeMlxGWe9tMyM6Uxm6JyglcRwrfnP46FT0RFlrTJyOm7a/CP+20S7RpPsDMlEWj0p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xACMO2b4h4TWup/kb8NMxouIM6azWSC3MNSN6Lodgsg=;
 b=XQnDn5TKMjXzuVJOyhqbxMFV3rUqzDpqfwbmRkb1kQJSjgH3MoEQ1h0v3ZzHoXmNMuM0Iv8ChMo2NWqX51dmtLbjTyIAp1hDoMROjh3WVEKD6mQBnGWRQdBPOTyJ/YVQzkMfgIRYd53BB6SR9LyhwUKYlqFLw0ESgOHn677Cg+k=
Received: from LV3P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::34)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 06:22:38 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::d2) by LV3P220CA0013.outlook.office365.com
 (2603:10b6:408:234::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 06:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 06:22:37 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 01:21:52 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 7/8] ASoC: amd: acp: replace adata->platform conditional check
Date: Wed, 18 Sep 2024 11:45:39 +0530
Message-ID: <20240918061540.685579-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
References: <20240918061540.685579-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fa4ea4-5ea7-4409-6df8-08dcd7aa4ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zggmbvynBbTXRwPSf9/LFmVPKgU+CgAo8M7iH8GSyUKOXq20dFidXycWUZ9j?=
 =?us-ascii?Q?LOP9FjBVziW4OsWN1u+hi9f4qtZi2rGaUvmnGm2yc53jZdwsCIvvvhpsDjZS?=
 =?us-ascii?Q?5I5CsXmihFVk2Y7/P5qFlIWJqLYhFbP93qPTmlbdC4+KMCpI48CBwHm+TpP0?=
 =?us-ascii?Q?PppxuEgfdgykxCphHrQGELtR2VX2NagW1SKrxmIkbtNCc/CndHpTfpt0qJvE?=
 =?us-ascii?Q?o3FQxvF/UtgDzLlpRsHec/YukD1mlRb0H17upRgKXzz1MMcdRfR9VgB08ukE?=
 =?us-ascii?Q?qX3/iAHhBhlZeA+08Fws4+9ejET77DpDpCRxTnsiYX3nO9DgpOAWuN2L74y6?=
 =?us-ascii?Q?a1P8PyzbUZtfwFwMk3Jg8P66JcODh6AGGWStWhg/6D6TviKgdBw2rncz11Q7?=
 =?us-ascii?Q?B8M6HGb2ArgQOD3PFcnShL99QMAJtMRheMrMcoTJgPKl5imUuStX4Q2mWWbv?=
 =?us-ascii?Q?D/4Jj/JxQ6aPPZ/jXb/L2ftBzbX//lfP2ENLwU5ZLwFZj3EsTTlFYWIiF8YC?=
 =?us-ascii?Q?QTsVIouY1KgWSjXxki/gC1Fu+Kj5WNFtzkOyUmyijiqMo/WF346pM/Jwpfiu?=
 =?us-ascii?Q?2eltctl5fGo/GjnZTJUyzP8f0bwhmRyBvL6wUovFRCs8cxfGynCKF5Lr3U2H?=
 =?us-ascii?Q?Dsv3+0bDXXCJet5PkvTVIOGkspl9zwsYz5wmWM1LMrh+q8Irz1rjkqqI/QwN?=
 =?us-ascii?Q?qdsQTpSZ0kIhu6d5r8L2g3gS3LMvycE7LFMQExZlpjSkNEkpVeAm5pN+aYud?=
 =?us-ascii?Q?qdXWtBnEwlV3ILOv5hr9fgm88n7FHIu+WKi5WpvHzl3OIJrKayIPYrp2Ld+S?=
 =?us-ascii?Q?Ub7LmkbtYduZbbD6FFUnxaN1cGa5QY8IsEsgh2Tf6lkYFFOl9gvvt8PaTlae?=
 =?us-ascii?Q?SzoE9BjPXACXwSoB9XteIG/+4b+/2TWp8Sj03122/T1SLyOhuWRyJIADP0oN?=
 =?us-ascii?Q?vUYE639bB/klkqc/el54rBsNtR1x70xQxJAz6q6eGI2HQ1j04VdM/n2AMrmk?=
 =?us-ascii?Q?JZ/cMqPht7S2xV+ZG9xL4RaLTGFpOqH6F2g2lFWe37LEDDTDIdossYwAnq5i?=
 =?us-ascii?Q?63Tf7xC53I2Uqpx2WlqjX5Ly4/1/oHXaoX/gcgBSyzEvChd1CpZiXOWvPCFr?=
 =?us-ascii?Q?pxmq17rTNjFh6nmYMc6QyhI77ZsM/o/1FUsy0O8r7CCHf9o1MJVcZLWdmYkd?=
 =?us-ascii?Q?f2iBymusCBGNvSoY6j1TX4UJme1l4nF+jhOjfFSA6XjiuVZAGNNr9x63XDDg?=
 =?us-ascii?Q?ZLNiDzloSfpeiSG64DU6bRUppZ8DBjXiokGDnq4Fj4HTugzV9sotMdaDPRGu?=
 =?us-ascii?Q?0ztaqGbcelIphlTIaxnwfpEol7MR7uLBAx3JLvElrk0/gblbqoTCkwdFRCfh?=
 =?us-ascii?Q?8x2JKtzfjNrV39CebuLrgR3ZwqMC8FYncHrjnHWIDTrv/4DZtaHrZAqw6WBW?=
 =?us-ascii?Q?Pp2gsB4r9j3joq0h2POT2H5Rc13VVIDU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 06:22:37.9489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa4ea4-5ea7-4409-6df8-08dcd7aa4ade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

Replace adata->platform condition check with acp pci revision id
variable in config_acp_dma() & acp70_i2s_master_clock_generate()
functions.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 6 +++---
 sound/soc/amd/acp/acp70.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index a6e5cb263377..b66e7f69ec75 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -204,9 +204,9 @@ void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int s
 	u32 low, high, val;
 	u16 page_idx;
 
-	switch (adata->platform) {
-	case ACP70:
-	case ACP71:
+	switch (adata->acp_rev) {
+	case ACP70_PCI_ID:
+	case ACP71_PCI_ID:
 		switch (stream->dai_id) {
 		case I2S_SP_INSTANCE:
 			if (stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 82c26e4fefc1..db5dd64969b0 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -142,9 +142,9 @@ static int acp70_i2s_master_clock_generate(struct acp_dev_data *adata)
 	struct pci_dev *smn_dev;
 	u32 device_id;
 
-	if (adata->platform == ACP70)
+	if (adata->acp_rev == ACP70_PCI_ID)
 		device_id = 0x1507;
-	else if (adata->platform == ACP71)
+	else if (adata->acp_rev == ACP71_PCI_ID)
 		device_id = 0x1122;
 	else
 		return -ENODEV;
-- 
2.34.1



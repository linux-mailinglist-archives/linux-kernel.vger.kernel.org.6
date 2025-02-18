Return-Path: <linux-kernel+bounces-518636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D35A39269
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AE616DE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89A31B0421;
	Tue, 18 Feb 2025 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sr1I313A"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BD1AC882;
	Tue, 18 Feb 2025 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739855526; cv=fail; b=iViq/loVoKYEr1OHPWYGOmNlQjEMRWCJKE0x5sF1+SbgPw90w0LOkvapEZJvY7dPCsY7KgIvBVrL5WL/KxmdPp9aYBsKIYDuJO4TdMnGfqVZXTSUZugFKUaEVyLJ/YhREqm5Y1ipRCLivCphWW3fs95Ue2wh5gWvMkgxhqdACHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739855526; c=relaxed/simple;
	bh=NQNBrmA08AJnaKeguoVZjoiXNlu6aaRDB2hnkfznkrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kSSKcuHxxDmadKsLwztzHiRNNd+d3p1st6R3z+Ix2VXDJ8u4UN/+51xfVBRRO13oLHIrzlMO8Y0olNA71bkJZ9hNvL+o7+WH+jdZC/ga+nbSI6Ad+Eq83oxKxSzANKlmqHkg203squQV2hw5q12HISr4zruEkhoFlpHBy2Kn9ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sr1I313A; arc=fail smtp.client-ip=40.107.102.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FChrDerF6tpwYuQD+DyfWBwjLGnyNcU5RYuyUzf9xgoiOBT2GmiMRhTYD88b3o6sCeYsHLMQUZbQPCc1tDzG3wu89Qb3srZ0myB8VBEvwbUZM6P1FKXP6iqCMxup78Wx+V9Why4QBMgmSYeQ0wCD1cAzzFQaI8fiNe2UwrQ5kS9PU5R+zy8b71AfitwBlfWf/oTSU+q94dTBbRSGgYr/VsScCdCvNPaVxCBvM4KjPkd0gsKtvUpPLKFC3d3fYxkanZu8xF1CUEB3dIdG9/ajMd6m/JgZHu0jzyLR9AzEtuknfb7nqpwhLsBIVBfkprbxjpX9vg0NuMYensweYIzSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znLxHlOrgSpLn3xlANZIe2Ewij6YgDgv5/qcUlvoxNs=;
 b=QuskOn4TDDTiBLRiTnSQDFovFU+GD+thUbM+MASmgfHozzRSIUnrW0Di4WX7GgNhgfU0IHvZBfjcOoOR9xWiM+A71sVVgnt1ponmoYEj8ImUDSlgcVrMhWRByuz2prScr9lM0IQxIUpT6i60Cq8ww3KCscoZmoz8oBnIkfQkDMpcOm84JsliYWRx56eghSuU9SrJO0wR4oZAsZkmAlFiymuf3vg1xRjhMMeCgElwvkywQ0g3+uoHo7R+5Gmf6SnrzP9Zu1VkK11hJr5GZALR2WAYa9c8lZ1rJjTsUEaMXgAMm3QHSWY3l5jO4YHOduuj/sUv8uzE9sKxHlC6zPyvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znLxHlOrgSpLn3xlANZIe2Ewij6YgDgv5/qcUlvoxNs=;
 b=sr1I313A7RzHQXfBtUiaxaBy/545iC24bn7RdOmS8gK+VAJ+AmT1qsYUKHKEkaHLdfr9x+UxRXdwzn8TWvbobdFtcAJOIfnsLeKrSIEerc1tmIJPY/16IOVpvd5hHH1DW23MTaJNHT5w1bwpEQMqoy1ZyG8Oc4ifRIvle+Cx8F8=
Received: from MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::29)
 by MW4PR12MB6849.namprd12.prod.outlook.com (2603:10b6:303:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 05:12:00 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::bb) by MN0P220CA0001.outlook.office365.com
 (2603:10b6:208:52e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Tue,
 18 Feb 2025 05:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 05:11:41 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Feb 2025 23:10:56 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Mario.Limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: amd: ps: fix inconsistent indenting warning in check_and_handle_sdw_dma_irq()
Date: Tue, 18 Feb 2025 10:40:00 +0530
Message-ID: <20250218051000.254265-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a08bd7b-119a-4d65-3ef5-08dd4fdac5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXnu02xJ42OHmza5vpAyRJuAnIfx0s0Zv86Yp3PD1Z54gysSo8NObDfD33gA?=
 =?us-ascii?Q?hcx04R9dCQS958cCWoMLkSrEeN4mqPX0H36kh+a+k13QAnhel2Wpbk10Gm7b?=
 =?us-ascii?Q?JpRW3n/3wKW4sYzoCjF4X49WE/PyWcj2ufdpJbywI58Vb84cjZXOFMOS3P+s?=
 =?us-ascii?Q?+VsN/2XgdDpAcZL9SsoOSL2hBHxsmA3E7FIuV5MCQpVf3DCUQjgvqobo1mCm?=
 =?us-ascii?Q?lEQ5yTh/51eOVorqnQfoWbl3PrApFV4V3YuvLYiDuDgKHMP4VfDDKggSPhLV?=
 =?us-ascii?Q?kAWN0HliGiVxc/+JPmsU3sivIRJKRQVw7JCT/6m1Rn7EhiUwtCTvGbraJFvr?=
 =?us-ascii?Q?liTmyj5tCPoj/PcBAJTkcy9+rd3VBgzxdKyU5mHl4kNKAcy42C6Og3oIHWrx?=
 =?us-ascii?Q?uyYpU7AbnTnIPQUsTxMJo4QQkLusptZ/zsW+t5D4P28CLb+DNzO9VESWXpnL?=
 =?us-ascii?Q?G4upm+qpyeE5gi62WwuDAfc0sZC8cA2eVFILbmxKxVxYUzApyau7clLYU6BV?=
 =?us-ascii?Q?Fr5JWE6Oqg8wQnlrbBHsSBw21ky7qpvbLeFB4lStGbWrwmymTg+ZS0ZbOTAj?=
 =?us-ascii?Q?WLd1K8U5ssfbSKNWiKRgYu6ASCTuKkQEr0P4B+pjpjYuBauAYKMXX7GAbCw4?=
 =?us-ascii?Q?ClWdGNs62lqOn1q/kxKg8g7VNzl/uqmf0vhEtdBdVJDChTRz6VpHQ5cI+G2T?=
 =?us-ascii?Q?A9drToSJ+ySXxPvATcaZLSyjONMl1j3xpjCN39VKhiCtUT8AFF5Fa8LxW4eD?=
 =?us-ascii?Q?BtCAJA7g1Y3gUXdIzdfe6zk4lRmZ0tucYcs78ks0IP2E9zRqS1sKuoWabX6U?=
 =?us-ascii?Q?Gul8N+LTW+LY3mhwmaTzf4whLJmMZk/okL8HiOCNYHonB/hemz994SUJ0mqN?=
 =?us-ascii?Q?A007lj64bSmoTZj2vIUlqv726zQEB8/IdITLEkV6M8YlMnFSZlrR5WVq7uNT?=
 =?us-ascii?Q?FMXiYPC21uyKwjuJtx/udf6iIWXZPNpEzUXMArwhYLXgqIY13p5Ma1/8FiZb?=
 =?us-ascii?Q?LrXPHP/DNzWXpofhdxu6Pl4YQL3TTeUW5WxGqoHGFybgQ8W+BHPT0yiIFI05?=
 =?us-ascii?Q?dmNDjcsWpau79gqnIhmbV0RNoC/MuOxDpwqsiP4Tihs5zblgjWBDva5rdYcW?=
 =?us-ascii?Q?gElifiTDXv7rdflbwxgZw0o/+UNQGlyXtwKeRc+/Ybl17CUp+4oxHgMvKteb?=
 =?us-ascii?Q?XsXbdDDcHyfZmjBNTRMNXMADXFkZXM6rPCrnA4wzthBQh7BKB4gkD/1u3Igo?=
 =?us-ascii?Q?aHhGX4mhdYE1rMVVar0r/1n0kUjOec0SJOEFndfrIeJ0uAZsS2kWT96aPw8Y?=
 =?us-ascii?Q?8tTDClWKau4nXklznOrPPTuFcBmpIUkVYhElXHWu8xEMQ/3UWlB1Pl87BtrJ?=
 =?us-ascii?Q?R4AbIODnXCsC1sowvFiq9l4cVSroHjdbT9bA2ARx/WDPnfo48zFJRS12VQIa?=
 =?us-ascii?Q?n2QtjNK7FJt8ZRuqbpvCGqwcc2P7Ex8Ny3xuiYQoYaHwdAvGbqwMiSzoSEfX?=
 =?us-ascii?Q?OgL7odL3sYklssM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 05:11:41.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a08bd7b-119a-4d65-3ef5-08dd4fdac5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6849

Fix below inconsistent indenting smatch warning.
smatch warnings:
sound/soc/amd/ps/pci-ps.c:68 check_and_handle_sdw_dma_irq() warn: inconsistent indenting

Fixes: 4516be370ced ("ASoC: amd: ps: refactor soundwire dma interrupt handling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502132134.BlkNw1Iq-lkp@intel.com/
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 2ff8e67c19bd..221c65ff03c9 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -129,7 +129,7 @@ static short int check_and_handle_sdw_dma_irq(struct acp63_dev_data *adata, u32
 		if (ext_intr_stat1 & ACP63_P1_AUDIO1_RX_THRESHOLD) {
 			writel(ACP63_P1_AUDIO1_RX_THRESHOLD,
 			       adata->acp63_base + ACP_EXTERNAL_INTR_STAT1);
-		       adata->acp63_sdw1_dma_intr_stat[ACP63_SDW1_AUDIO1_RX] = 1;
+			adata->acp63_sdw1_dma_intr_stat[ACP63_SDW1_AUDIO1_RX] = 1;
 			sdw_dma_irq_flag = 1;
 		}
 		if (ext_intr_stat1 & ACP63_P1_AUDIO1_TX_THRESHOLD) {
-- 
2.34.1



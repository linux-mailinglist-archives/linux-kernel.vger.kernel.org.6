Return-Path: <linux-kernel+bounces-407495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497F9C6E45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290581F22715
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3595201105;
	Wed, 13 Nov 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHls3LHt"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EAE2003CC;
	Wed, 13 Nov 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498779; cv=fail; b=Cx+YPf0QUdvIMEg08d4KMQd7WM0UEGYpZhjGkvrUgJTVjjHK5Eu27aefM6t3GIJiZ1ADcvXaAoJ/Gs1oIPge3WH6vqFeGvV8hMK+GkuzxCHKmbqiTcfiapgJIpohUVeotI/mu5MZoLqO+/WusKphcIxUa6dw+67HCX/ffSK8+JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498779; c=relaxed/simple;
	bh=UCiXsXvW+4wFXi37PcpEqtEtWafu07eWSuEbxmEcPSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjBu4ncB5dYZRjham7jAIgCJEBPHM+OoqK2z+qaYgfMvGglggLyKwGQZenqpdqr4Fvy4rtg0iS1NETzojvgcyLFX3Z6bg5tJUqN1DFO6Er4LryfsryUOkRd1K/mdoVj5lxispDFRrDdp9nqgaQCrAKeTh1Cn3snvANbRp+vhZeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHls3LHt; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfat5eY5VYelA+KZgVTTU7nD3nPh+f1nOpv56etgmwkfSpG/UB2lR8MtNxDgwh5oMnW+WRiUnJAItoc/gvu/HgvClP4HIYmtXwng1bMPa/EBrSeLxl0AAhbHkGo9WMenNwAEEGPhCej8WwHywCoK7QhOoWNzV7aCtr/uOkYWmvy7EeycBlzilnyW1fnsGrrCF4unZdlxsm5blnojLAXBBdYLfWu80HsOU55uU4FP38rmJhNspQcL8BvcP+XmSSIcEmccGfEyz0W2BOIcpahXDL0Re7BFbYfMDa7jl0UTOdGWjSM65SLmw1nCoY1YqT9qfdrZKXQPa+9RKOtCz69n0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZbyXS8g1vxaU/IBT2PE/QFCSozcpKS5slo1uqhzppw=;
 b=sboyOy95OWoXlvw1HZqI1V1cDsJoyqjcMUgSpMEdO/9vRQPb0FxddXiW66s3hnnH2PrArYswWMS9EMfvFCxqHM7/8PaH33eagoOxgaoyoENoo/ec0Ic6rOFfJVcSv3Wii8tjNuVHJeRn7uZNcPZ+SZ+GzFtekHXaQ+uKTLZJm0aMapsdn6i/T/7inuui5Tjspn3eMWF65t7pky4RfcAo/b0Ceujm4p5PUvC8sR2urT+p18ItTPMCBbhqxYqklcnneUBGu9QaerHfa0dSVG2PYIhFNSOUn2UggGFvuY32mzLLWgqt05C+kwbu96wFpUoEKjAC39dM/kSe5kNVZQQIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZbyXS8g1vxaU/IBT2PE/QFCSozcpKS5slo1uqhzppw=;
 b=WHls3LHtXAxADXBOTglwD2PC32d1kRvMaUUXXjpdZqvD+Dnz7dUjvmgn4v2ZyGGusEgzz/jQpYGPzptEZJybAbKlROrmEYSJLmF57ghCD47h5tf/qLGPjwQzZ8F2wkLPtQgYylSx5Jsi7querkRN2TpvVs6zYWOLB44Qqn2PBLk=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 11:52:54 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::5f) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 11:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 11:52:53 +0000
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 05:52:49 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/6] ASoC: amd: ps: add soundwire machines for acp6.3 platform
Date: Wed, 13 Nov 2024 17:22:20 +0530
Message-ID: <20241113115223.3274868-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
References: <20241113115223.3274868-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 608f27af-b8df-4800-acf2-08dd03d9b511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLQTaegggFrzOjugLxmJP5MTn31X7dnsZWdPS+pavxrUTvirs7/iY8ysAjwg?=
 =?us-ascii?Q?CkAAm41dgTuZFPuLRxPFRsLAIdIQBV/l73HMuUUWeQ1CzjuLrx7xjvM4mzmE?=
 =?us-ascii?Q?aC2dVFTZW/2+6ahZr3e3pQjX7NrVVH1sfXPaRd56qOflIKu2wqJqL+cyePoX?=
 =?us-ascii?Q?34oxkSO2tXuq8+dstshJgk4RmrM6fdHTnLGWkUnidkNRXSbm5zU65u5svB6H?=
 =?us-ascii?Q?4pBEBnXKY5txVjB+rPk8o1LvTbIgFw9ugKPhjXBQiRoEl32gCyxo5ofFs3t/?=
 =?us-ascii?Q?/8eW/4h4lakyjmPvP+hmUxDlaAVQgNk99NrbXrj8T60n1TJBs99V0fgxSlED?=
 =?us-ascii?Q?Cec99RPa/SHw1iEfGabPNU1QzLgW3iRy/snQ6yVmdm6UlbHSrduokqO35HBM?=
 =?us-ascii?Q?vkrNT1mFb0cgs7IG7pF3EGe9Jco4PnD/B1qoyZXaD4NKR+CJ7pX/qQzZ1Ir6?=
 =?us-ascii?Q?dO09+Pu5ze5lwYgZoT36v5BpYaWV9lNtuqvGU+cnsw1tXHf7mfCiYwk3ydh7?=
 =?us-ascii?Q?1eXiNgGMRQu47qT//dICet8t4nnSCPMuZKCDmCZWgAU+dQ5AHIdjvkHoBxue?=
 =?us-ascii?Q?zSkUtv8jBukj5B8t8A6L+DVVruAcwyFlp+iLll28Wj4kfDJKyvdN8t4Z/Yiz?=
 =?us-ascii?Q?0d5qvJfKbN3w1T9Vv83fSDkPGzcxM8UjiNUqjZR2gtn6RYW5QSGB2OXFKKS1?=
 =?us-ascii?Q?7TUZ5xOJy9d/hMaSASfReBpQujG5pSpcWRSKF3kbY9yBWFba287luIaZpjkO?=
 =?us-ascii?Q?03pzOJMtwLnqUe6vQQaGi+AVPWiblIgtnvH7kod6tfDCPxp1lSuIwb0TX+Pr?=
 =?us-ascii?Q?4vTHwG2wU8ViQSlPhdUsjCr2ePcT9Lqbw114F/kniTLU5pwCXtpj6QveK+qb?=
 =?us-ascii?Q?kTScNHO8ZQC05rzdEcud5C+ZiXVDCtbwI4cJN4T9RYcIMJCicSoIwpRZCp+a?=
 =?us-ascii?Q?sEMwGTUeWt02WrhjX9DSHRkTN/L14raTXIUzHFbYERQHtOnr/ugRj35NjhOH?=
 =?us-ascii?Q?Ozum5oKZzz320JAd5num42klfF5PWCrZLS4z63kZSuj4Wp4MJLPM7LlMrigg?=
 =?us-ascii?Q?NGEyG/2yKHK+c73PAu6cadJA+H3YVKHit/tSjqjUxjIO51ocuQMOK0dWfh1L?=
 =?us-ascii?Q?3mPcIfIhp6AaUwtwJqFZtlGiuxshXdwXZAlaVqZ701v5WEXz2ekagjeQQ3K4?=
 =?us-ascii?Q?eloMcCtpOCWWUczRyYF7hFN2x5KhGmssOy4NLO5RUdrSzBZm64MK+Qji0BJ2?=
 =?us-ascii?Q?L6J9O0fsXGzt+MbZUL30E0W8dfK4K7uks0Uol02nBYVIH+VTJwiN9yFlyJox?=
 =?us-ascii?Q?jDzxhiGDERpxGRE8JURZPimOuyVt47jDvz18qtk1h4QW3WT+8bhN9Kd7aOa7?=
 =?us-ascii?Q?uIQr5MOaEkRdRWL7OA7G/srLldfl5O9k0c8Bt6mJDYgcGbcOJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 11:52:53.5380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 608f27af-b8df-4800-acf2-08dd03d9b511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808

Add SoundWire machines for acp 6.3 platform for legacy(No DSP)
stack.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 4365499c8f82..a7583844f5b4 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -598,6 +598,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		dev_err(&pci->dev, "ACP platform devices creation failed\n");
 		goto de_init;
 	}
+	adata->machines = snd_soc_acpi_amd_acp63_sdw_machines;
 	ret = acp63_machine_register(&pci->dev);
 	if (ret) {
 		dev_err(&pci->dev, "ACP machine register failed\n");
-- 
2.34.1



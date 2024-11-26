Return-Path: <linux-kernel+bounces-422752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1759D9DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E058285053
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196811DE891;
	Tue, 26 Nov 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSQEA+Iv"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929E1DE4FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647564; cv=fail; b=p3PwzdF6Jc0++2j5XUmifIprqgqXBlQS/kak5G1+6Qjw5JWEaA8NSpdd6U/w+z+b2n+eGEvACiHZnf63MlH0o8mRn7QLRWA061t5Hb17VONzteGm/POZj3/NB8TyM87cVW+VBd+AluuKD5dILsCh64bt0LVdk51Pee8b4NrSlz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647564; c=relaxed/simple;
	bh=mDkdmQkb1VAw3A0xtMOenNgVEfQaN/YbkNQEWN1A0zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnOjPdkru9phrPMzTJjWdDiVFzWaXXGfGTGg5uPubuNVXOSuNlu4MI0H0W/M19wB8zmNoS97p4z5DPJM3eayTjMpDvfqi6k7uwyqDlr8Sg0+Gx+AHxwwZ/78KIQ3s2uHpHzYrI1EqmgVCSAqDfnNM64RyEM0GCN/MQqPcga1l+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HSQEA+Iv; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxKeMOL5idTdUdG6pOGB+72VqSlkzBNsRoQanEmxTvOtd2i8ybTixQDLiR89NZLUmdXjmHB2jdpktboZZkR1KEXTQoasUoYSDM61NkWOUy/c1kmFI30nJWesBPS0ijCftRK8EFU3vfNqSAAKIhbGN2PRISPz2VnHCq4xxXB4EzLsp2nnsxVvqiv0Nzjx1wdkdljH7iunIy86BHqI/HC8DUHC9QW8E/DlEfWuhqRXPHIk9SwpycSiQJbo0ufEzroqc8KEAet3co+jrgMCeiegdr5pddN1txKNMffWJKxEUYJukZYUMAPKbYwVsKeW8BhsXsyO+LaCswlpPUko+TEpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLCHKYFeNGeoigYSiA7BARrdJSM5jF0eBS/e1C6moy4=;
 b=CQRqb3uusQBtifXgXVdbixJPMhY4YhbetEsQojHxSjgaKqQfMnP4lcj4uVjb6bWefyvgp0KeI6t1zw5JfRK/lCSO4yNR+vmhG9kI26qM9IWuAT8DD12QMUZY6wpiWJuJaWEHbryLcESGAalW/zQ92o2W/pQqvBYEy78DWnW+3sz73ca9KUQckcrKQr9k1v2KmgXA3A43SBrCvngdT1ioNHWKJAebY61tt+RLcEl4Lz5uzpr7CQWbr1S9rR+mek/50sNMHZLTu06Hd68keQGKXm4x56uYLjhSjbHI3whKyAoVJfDjJHv7Bcqu1MxOuWO6RtrGYh8BtvlT7p7bYW1j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLCHKYFeNGeoigYSiA7BARrdJSM5jF0eBS/e1C6moy4=;
 b=HSQEA+IvQj+E1ishgQIz2HsRLcpYD04qcYIzzAUjmUxTGou0yIBJnWqFTlZ8hlcnESWtg8NlrakwJKPqB+1x//8TgZVN8LVI+LHGwr525KOqSfM+/fU352bneLWV0J8gthw9ayYfwKyTJ1Jw9rtLNVpSDII9U+zibudUCigvtbwUnY7yIeAOdpsbuSZt5fNUAI6as92CEBBWLc2lp71StI/ek6NYXm67t/6QGWUfZG4Ys6G83m9PoOXFGQDTyJY0s9Pu8X/bAsTa8ALPW7J3GMhPTKuJXpcX2l0xuIKvWdIUQHZQLuQv3QGoKViPnSmdEyPbu9EoBM6ZR0Pe6GCsWg==
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 18:59:11 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::fa) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Tue,
 26 Nov 2024 18:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 18:59:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:54 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 10:58:50 -0800
From: Vishwaroop A <va@nvidia.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<cmiquel.raynal@bootlin.com>, <thierry.reding@gmail.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 2/3] mtd: spi-nor: Add support for spansion s25fs512s1
Date: Tue, 26 Nov 2024 18:58:33 +0000
Message-ID: <20241126185834.1130949-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241126185834.1130949-1-va@nvidia.com>
References: <20241126185834.1130949-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a950234-2602-43b7-4752-08dd0e4c69ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+Kb7hR2WmrvcGqXCHSiDPdKNtH1hX9J0N1pOD3OIpewiQALmlo9Ud0Fd/YC?=
 =?us-ascii?Q?lQCc8rTdqGFJVz0cY0cm1nLKpdZNrcSNQa1BVzcDQJQY9zPXv6ZRe1VdjcTG?=
 =?us-ascii?Q?aUfAmFBXWJLhAjLJMLa/p2qzE7f5s8/7WV6S9fEdMmcEud1dnlxBypmSpwl3?=
 =?us-ascii?Q?iupyFn8PDaHp/RDlpNOlkQcb/I3iBa63dzB1EFKxF25G0peS5XfkztWjERr+?=
 =?us-ascii?Q?1qf652VBN0LOlx83RkWJkclCQYw/OmL89FCJpFnxm9NgHIO9fQzS6xTQR9/Y?=
 =?us-ascii?Q?dTJ1t4hlKmIT3BVJf2Edhi7L57Xo+efYMesjzBv2dD2S/s74SBrh1KmtEas/?=
 =?us-ascii?Q?4eljPeHoLQw3uwTJfXccHVH2NuQFfjPHBXnqE/Lj5ZPQ4jhT/xhAiFWBc8wF?=
 =?us-ascii?Q?GVD0qBaZymHY5jzwMuYF5a74F3YHtfAqmdYM9wxarqUOiJvIcYwPvSv0/Umw?=
 =?us-ascii?Q?8Vz2z5Ja0EMvy/JPcdMZYC9GD61ZxjPYGPJwh45TQHYz+q058w0pMEeZr/aW?=
 =?us-ascii?Q?9Y7m35UicQZfFuZpJdO14moavMJZMTSv4Qjs7t85zLrS130DgDPd/ZvCP0y6?=
 =?us-ascii?Q?oDoDmDzzrk8kyyeR9QQtRBV8kPSPr5w5ocEDpVwdkKC8+xi0fTPx1BbKvha6?=
 =?us-ascii?Q?yscaRN98JIe6ZK9RFPZWguMQ7qVmfI1inrL4UtRT3zy/emj1gtgwwpXOSYfO?=
 =?us-ascii?Q?O6GdErRgzjv91BmUauhxxZggwjZin3lgV/6dXy/1h8c+nRj+bnk7Rv6Iy3iz?=
 =?us-ascii?Q?VWEOsy62yJ9mEEOEpCzkjrq6DVgX9+sW2Dw9MrFK/yAcFTkSmF0dXSY36ECS?=
 =?us-ascii?Q?II680jCtpzpgTO+7LiwfOFygLe99F3RtmvkoTjC8FD2TbuWL2QncWK/hk+t1?=
 =?us-ascii?Q?kmetKk2F+Ix+kzCSmi8IVY4hXl7yLTxRuEmSnWDCpl6Ne+LQsPQTcyMX1Wgi?=
 =?us-ascii?Q?iKMX5SetusWZBKiz2kC8qHVcrbQVNc90sQFjq9GuJemPgYzxFoBvkAifyrsP?=
 =?us-ascii?Q?Kspd2V4VqpHqjzXd7HYiZ3m6nQLTp4SD0uEt4uF0q0WUJQlK+tV5DtNTcg6x?=
 =?us-ascii?Q?F8oRFveVrnHyBYeVzT22leQHbqypHQvJRa5Iv7woIGH1qMqECdpF0fCtjQDc?=
 =?us-ascii?Q?bTelyvIH1+JuQQcE/zQheKzIOGFNm/+yUIDnzhkSGN0EbVsMF1f8HfdY6TAV?=
 =?us-ascii?Q?lAiNXTAuOaBs04Sd+ctnnLfID5lTBdW1NblXycqHoYH2/bckKnN0CzLnEU1M?=
 =?us-ascii?Q?D+Z2tMCTgaN+bWjBeYQJp6IM8UZXobgI9Eu+mLPD0JGHKDgnSdB9mxl9PV8Y?=
 =?us-ascii?Q?L5btgaX6Lilc7894E1gtfq9b0v+AHU/Z/XcFzvmImu7NEIAWDe00aeneNGKs?=
 =?us-ascii?Q?TpTyOTqc8zkAILk5zu1L/wMLjj5/p/xSPpxhTjS+2vB1gyUv3ZYHVEx2M0fs?=
 =?us-ascii?Q?o2FmD46+4MsHKDtAcQTDJl+r9k67xpXJTdmVOslh6gKhR5DXGjFZBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:59:10.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a950234-2602-43b7-4752-08dd0e4c69ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

Add support for the spansion s25fs512s1 SPI NOR flash. This device has
a 64MB size (SZ_64M), dual/quad read capabilities and apply
s25fs_s_nor_fixups to handle specific chip behavior.

Erasing, reading and writing this flash device has been validated on
the Jetson AGX Orin platform using mtd_debug and dd utilities.

Change-Id: I47ee39b33262c77a5f3601cd9f284e8291da27d5
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/mtd/spi-nor/spansion.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 2e1dd023a1aa..472773891dad 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -901,6 +901,13 @@ static const struct flash_info spansion_nor_parts[] = {
 		.size = SZ_16M,
 		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.mfr_flags = USE_CLSR,
+	}, {
+		.id = SNOR_ID(0x01, 0x02, 0x20, 0x4d, 0x01, 0x81),
+		.name = "s25fs512s1",
+		.size = SZ_64M,
+		.no_sfdp_flags = SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.mfr_flags = USE_CLSR,
+		.fixups = &s25fs_s_nor_fixups,
 	}, {
 		.id = SNOR_ID(0x01, 0x20, 0x18, 0x4d, 0x01, 0x81),
 		.name = "s25fs128s1",
-- 
2.17.1



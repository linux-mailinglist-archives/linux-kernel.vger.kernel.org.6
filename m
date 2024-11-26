Return-Path: <linux-kernel+bounces-422753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF39D9DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD17FB29B93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B7A1DEFC2;
	Tue, 26 Nov 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3Inl/9A"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563A1DE2B3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647566; cv=fail; b=Ka2fb/d0BFTXvFaDecmbasFfRHAH0L0/rRZ/mmgMOfn3yIjXizEwHD+thLZUVfXEx25ts7c4dWyiT227spCvJ0eiR83mARTGbu8TA72Do+pA2XcBEaaRqLae30MU5cXB1IVLyAAd046GetwmnGvZQj/cbfu7TMY28z/fn0xFRqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647566; c=relaxed/simple;
	bh=XYw6BPl1Uw65jQAdilaHgbvVOt3Jm7OTJQSHnJWyLmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACFSZc0N8U4yv/MzzKzR69i7VU7QCtfWZkP7fWcqxcHQm9x3jaSE1J40rIoHl7hwaO5gQkyDpAb9Tar6R55c0XbQNOnwHYwHwfuJSEm3h6ogeiTfLXcxMer2fB/sqNpfc4TBgbm55YITLezLCranCozd3y5+9Kivc1tA/izm4qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3Inl/9A; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFqn62cigoKJ+r/1SdYtwy26OtaXEfXJQxPPz8syJlyb4iE/GJd4y47rxbcXq93FX8TxS2SvKsqG8ixTeuR8eeRWWYlNNzzIixQrkorq3XORloIoXDtlKvYUyzP7A3B/1gT7Rsj79YOrH41iaigu3Pj3OTyfTqH8hExa8OYF1eMxQ0O5OPyaLSQh6tQjWk5RWB3QZi66pfx8pxCWxCyvypxtZLY8t20yKq2gquhHwFBI4pdTERhGEhrRY+DePE5c2/mWP67PzE97IDACCGBfRUvOF6P6at9Icm0SUZOhkL/I0sOjO+ss4sF3YtQ9Ex+YYPrbxP+Y8V1pksBIC7KH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2LWUPSAleIcu364l2pFTWrxiTu1hfE9UMGYMboV1Mg=;
 b=dBZr3KkiMTEJoBtJbRPaXbormG5X4ugMRVgyXWXwLyyDuxGKIUj0UmebZyzhPZFA0bBDpvYP8hrbmjVcPyw+Vx0sBEBI+N7PYo8ePZMzxAx8CUdofuABFvrqZn7nbDeorOOMeIP/uXIJaWQ41PExguDRxX9DvZ2Vze13UhBDILGqOemazN5zHJIGiSR/Y2Ijlip7OS0X2AWVLiamqKUuL+b0v3PNVVM5l89p3E57N2MqfVA3NQyMhIoiJ38XBxpnxEHywr3rcUzf8t6aCEHggD8/q0DqaU7VJ1UKnzLelQhXhMR3JHFxJzgcprqDlCaIMj+a/+f+vyeJMmrdKBX9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2LWUPSAleIcu364l2pFTWrxiTu1hfE9UMGYMboV1Mg=;
 b=q3Inl/9AHklpJua8tnRHUcJHXfvXqcRTm9osGfFboPYckMsBoMMky4f1fqX13ALy+QfVYEjU7Tyuhqv2VQovcfvK4ovLxPXBWz9g1dYGkw4CDiYs4Jm3fSe/V33hwuv5y8rg7L22Pgrl8szi5uXKzpNu8vsvQaNrkmfAK5MexNmlXL7zuAO58ja23WMKY18YhTW9daDKbmlpH8M3DQma88bv5olVW7zmA2akcLToT9pUiI690Cr+TVJz3Cs65/ZpjXVGt9/Vl0gy1LncunThWCzCUbK43w1sylvcsRsL5fz/d1w0OinVhJIa3WFAIrXLQ53Q1yK95+a2dltLJTkdRQ==
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 18:59:20 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::1) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Tue,
 26 Nov 2024 18:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 18:59:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:59:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:59:03 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 10:58:59 -0800
From: Vishwaroop A <va@nvidia.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<cmiquel.raynal@bootlin.com>, <thierry.reding@gmail.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 3/3] mtd: spi-nor: Add support for mx25u51279g
Date: Tue, 26 Nov 2024 18:58:34 +0000
Message-ID: <20241126185834.1130949-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f51e4ca-584d-44ba-812c-08dd0e4c6ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qC9t7lyOSuRuJ/msRPar0lDAl7IWyFi0EQMnPnDXnCU6YXr/3ypGrCiasxvX?=
 =?us-ascii?Q?guUrofunp8UxfseL4HV7UkRdBq9/7JtlMvm7nrcoy7kV3iDFNZlTNYf9o4A2?=
 =?us-ascii?Q?+FvJcXqmyx1lIaZF01kcUgloobuavXDuMEPEp83xynu03DCtcJfDGVfp1TSx?=
 =?us-ascii?Q?ROMHpbhb7YkJctvC5tHdGGPInZwyZ+Ydk+VpIJMD1AN5a7zAjRCq/FxQRUTr?=
 =?us-ascii?Q?4SnwJFAV+yy4JjM2XNC9WJEuwl7tiRZHhkCsT5f2cUlFx4zx0GSy8FWuSyAj?=
 =?us-ascii?Q?OQN18lMEW8NqJbh5INx5F7ksL/TWHkDLSvVm4V3tzLRybKhPNqyyM/rnjvgp?=
 =?us-ascii?Q?6RP3BB/Xgtk9kXTBjJc/GWsFr5dPGNWhyHE10Nn2GM0Ihtwee7zD2Ihb57hp?=
 =?us-ascii?Q?7eSdScDAN3zLhswVB4+gVy/+OQkgexmh8/YBbg4Vg1gGtlRseFvZzN4GqgeH?=
 =?us-ascii?Q?/Rh9RV/imH841REffDxkO35q/03TxG2UqnwPBwUNcUDNZHFeDW3evoYaEEpY?=
 =?us-ascii?Q?g9BRn+rBk5E28vubkTsnmU7LA/jdYtB9/OZdzdTx/ypyr03xW3MYhUndw0dF?=
 =?us-ascii?Q?GOL+sYNlEVtQMhjuvsILI2f33FdvdoXnnnu3T9hZcWLD47RqKo4kOy/GKdZh?=
 =?us-ascii?Q?nfunCl0McNz/fDnBQeOZTZB5Q2EM+9myiT9Sqw8rD/mK4LCSdES3KEeQDHgx?=
 =?us-ascii?Q?/QvJgLOOxz4sFY+ZzDE3lWgMLpqG4ag5Nxk9kn/iVVcem/NEO7OoFcvlxTS8?=
 =?us-ascii?Q?eu18l7Ch9Wf3NDoDMAmtAv+e860DuFJydoalKGkW7ex5dr0Uz13R3qYgqd0e?=
 =?us-ascii?Q?7mEqIzLM9y9kdl928lNwQXW9egl+nZ1klSEDLaMl1niZ+N5V0M5z+kGcPNRU?=
 =?us-ascii?Q?gSEttFYmK0vOBDX1IQouaziVnZJRbsp5EOk7muJ/30Di60PHyEy9TPP+nGNF?=
 =?us-ascii?Q?1aj8t8zKfGD9X5gQhgHtdnPTp1lykXyaHt7/Pf1I4FAz7aNJxjvP38meDyNN?=
 =?us-ascii?Q?o+YqNz2jVAfd2BRgP+hDVyjiC3e7q4Mf2ASStK/PnaW75uv/3A4cdvR/ygd7?=
 =?us-ascii?Q?wZHL3avNC8hH7Naw+fKMmB6y/LTy78CcrccPsUdqV6Y8ISpe85cYB3czpGZn?=
 =?us-ascii?Q?51L96GZdZ/TtXMRHwPq74afVaQ9IJ/4RLR+UavBrmFAXi1TJJPlQYeO/EL3q?=
 =?us-ascii?Q?KXzPZMzKyh0jlHFB+T4frIJyZxs/InRzn150/2o8q7P5svX4skELlXKPNf3+?=
 =?us-ascii?Q?ue5YbzokZSZrW7tz95DPsnFdDw195G1yPCdnUsPluJJuPNsGZ5BrIEvArj6y?=
 =?us-ascii?Q?6xyyAvTpWPTwaRwSkstkYraBKsERm63lf73uXiokSwIGiRGH0RuUx4OOVRLJ?=
 =?us-ascii?Q?fQgQPxsrotpuHq23cfKi09HmWzs2iMGGeqcTSenMvR96oFYrjWsYZYXC62/6?=
 =?us-ascii?Q?SvGK2u6J3B7UFGbhaiAC8PVcE5ocInfuCNVJ39F5vMTbj4W/ixaGNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:59:19.5219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f51e4ca-584d-44ba-812c-08dd0e4c6ee4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

Add support for the Macronix mx25u51279g SPI NOR flash. This device has
a 64MB size with 4K sector erase, dual/quad read capabilities and
support 4-bytes opcodes.

Erasing, reading and writing this flash device has been validated on
the Jetson AGX Orin platform using mtd_debug and dd utilities.

Change-Id: I740269c781d42781431935e593f651573e078372
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/mtd/spi-nor/macronix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 830da21eea08..4a15984f63a8 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -154,6 +154,12 @@ static const struct flash_info macronix_nor_parts[] = {
 		.size = SZ_64M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
 		.fixup_flags = SPI_NOR_4B_OPCODES,
+	}, {
+		.id = SNOR_ID(0xc2, 0x95, 0x3a),
+		.name = "mx25u51279g",
+		.size = SZ_64M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+		.fixup_flags = SPI_NOR_4B_OPCODES,
 	}, {
 		.id = SNOR_ID(0xc2, 0x25, 0x3a),
 		.name = "mx66u51235f",
-- 
2.17.1



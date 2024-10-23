Return-Path: <linux-kernel+bounces-378775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B749AD55A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839BC284ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9691E2610;
	Wed, 23 Oct 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4dY6PKt"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABA1DED61;
	Wed, 23 Oct 2024 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714310; cv=fail; b=gqblY4gSKnYtU0VjMBaVP88MbxbX/jubF5f8KVYrIYYurJPvdAbIaf3RL3gHk/bckyvXDUKQjt4BDHEpHTcIuEpHL9w2hsHxybOxxldW6SihvKk1aOpreefB86yM0BB4Y9azApEenzuK1jZkBk0+jDIzELv8LXbKd+PWjUP4jSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714310; c=relaxed/simple;
	bh=D1jQCG1nQUVbZG1mgq0gm+RV7wpi94oq2P4Duqghn1o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZxAz2mNROGKT0UZY+eGaOBIcB+Xef+VLiJnMxIgG/4pIyz3PDhWNiEOXl4izW61aOed2Ke2CGCh84gvNCQoyj09OuiYBXODVxj2D46Yu7OtS99/byvzF8vbpTkBEDFeYdgxiUQUBc/HQ0DVykKOP0K0GrTRHkpDDPX25oZk/vT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4dY6PKt; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFlJ4mPT3o7+PPTkoYGaGevcL30vpqxU1t/TMfKoSqt5gUQc4WEqR5gCPL1Z5nQuGxmESOzewR64QDwcOgIm71EdiT5DuEip/1Stc1FP/Vfyi86cw9DmYQN9Mgl2o9Tj9Ag9P/iRnLT81UU42K1wy9vz6HPfJEm11r9GEM7XJI2Tyj7PONIly5jW1B0xWg9Koi+0jFoQKrD9odugRDkg7x1w+M14AfcT0hC7x7aFrL3aFx9W0M8REqe53rxswDf2vzW8c+ap0CLcUSOd6h/NpL1OaUFBrMmw+B2c3HGynxQUtOzMeA+uL1TRq24UJf6GMidqcK5hUkzTjwjhoQJcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdGFQlJgqaz6ZKv4/Hh+un6TVzl+St19XAqPrHnDz4w=;
 b=ZyCiLo8w7E5LJlu005O9yOlcVbi9fT0hwk3N7t+8Ie0X8Zl5VbQ7jlOG68KhBARIw1EFrZN5ZgiaChsG9qYJI6Rqi8thtzaSMR+ai0n/8WxAvGGP7aAoIpJlOxNW/dRlbGFopvvP+86Td11ZiHqmueEyuXTzHx+yToQT7lJa/Gyh/koQjCGgUZrveUL57+u8qlAIktrJ5mpAOTJ5D2d8Nz0/ju4sTSpbuWfe3grBk2jva1SO/7hyBT7hgUVUMt5Vr/gr3nJV6rYh3omBuCTQuuNLC+c4+LL5Jn+MFWy3mfYW2UC6bfNcM3WKuM7NOTrrbGqMKWQxHsT7NSSEvjxirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdGFQlJgqaz6ZKv4/Hh+un6TVzl+St19XAqPrHnDz4w=;
 b=h4dY6PKt5JGyOEnCFFN73QulqFSJrcIl4o4wzh4RHOWqFgLlVfuaSo18HN+2uzYj36QC7g/RddbNqC0VSf+N6x31aQy0CgFJBuN+xnIJgIEsDxPSBmgGb9Zf0iwomoTFYMJaAk5SxvngdFmyr9JIWtoI5fUTYMXg3iwioNkBbvLUQ+hfgv/ojzdU3l9gCkPnSRi6xnxBAW/l0EpalWW7I0wCpYcoPUPHcy5CgYXmzycNbrGe2FHg9D3PxoPTlQJgUz3bFW8mGLghnROWCMj86BSWbo4GIPKQa8TR3+qjNXg75iZSjNHyJW9+6fS5V2A2QGq/0Mx1iy0iyI9LIla7wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 20:11:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:11:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v1 1/1] arm64: dts: layerscape: remove en25s64 and only keep jedec,spi-nor compatible string
Date: Wed, 23 Oct 2024 16:11:28 -0400
Message-Id: <20241023201129.1382895-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: a953ae0d-ca3e-4e07-60d4-08dcf39eea25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sFkdZL70i0lN+92A3i++Y8CBHF7GS72IQfxchkjXC0FJTWiWoo5o1bkU1t/?=
 =?us-ascii?Q?cdI8EmfZm7CG5go7/GiHSeW9ggcGT+JdHYGl9pL8AxDXPWquY+1Y6K6uGX0Z?=
 =?us-ascii?Q?ZKGZjI0E9g/4bntLQdeYAkkc6u2CCKQM8lDcL5rrDeVb7C0wuoBr1q4DIuje?=
 =?us-ascii?Q?2g4HOTps7sETrayPaBVCiP+fuZWIC0oxfb7wrFHZY/oBfniJ4p0GT2jZMTRa?=
 =?us-ascii?Q?qWcGiSnhOnsOYJtgnfXuYHFu7Ow9GPAEgRkQ0j08m8kGyws3/TrOpNr0Ok1C?=
 =?us-ascii?Q?4hJI+loJdBc1PCTfXMY81CZZEna0ticDrkwunJ/idSOlJ/1evM9EuXGRqT2F?=
 =?us-ascii?Q?uFt/5lLsCXd1QQ+y25fkiNV4SIWAajOSh15U8yexFTseO6LgFp0CK3LWrMg7?=
 =?us-ascii?Q?cEQhlV1AkLy4zYtewbiQqJbyTaQNZXfrZKhW3LPfMyKjI7MyTqKT/66u1zts?=
 =?us-ascii?Q?f6MA6PyObqSnPzJqZHZj+cb62qleEGq1LwBBlVnfANDzlnKuXtiUW09Y1+gr?=
 =?us-ascii?Q?TqxO1+vWHofNyd1GsyjmJLILAFr+biCJ3WOtTCgVCGh89XVIRhi9dSEcd3Kl?=
 =?us-ascii?Q?GhZv+Czxb9mM1mEENfWaQClBus1qDwEFDyErQfvW+QuSE8toG6rQd5YtAYvH?=
 =?us-ascii?Q?s5cF9wx2B3PhHQxFqikOtfcbDDLHEr4CDaO6ZaC7C4q3MHGTrmukM8bLqMtB?=
 =?us-ascii?Q?pozU19s9l7anN1/36AhApjRXh69vl/vbTkuc1Pdspe8HIJMpxThi6fV4i8uV?=
 =?us-ascii?Q?SVv/NGBD4NZr4Zj9S4dtn6pTYoFG6+sdrW9mFcOGg6e1S8DnkT8Fq6Xpm00x?=
 =?us-ascii?Q?f5qqoP3GbPiwT9CGHT9XGPVnfQrSWY01BP5Ev4B+OQOHF+nZIWTnmiKqpQv+?=
 =?us-ascii?Q?XlZ1X6aVK6zBZP5dTeaKVYGo+Yh3ErdGzTENRq97NJ7fsAgRrYWJeeZDlq/D?=
 =?us-ascii?Q?RgOJvovEKctixUqr+VrqQ8XTI4/voDmLGV0IybnO+Cd/Jafp0R6sDsYJIALq?=
 =?us-ascii?Q?RyBy99L1AilW8jl0loA3db0zWDcr3BtLN5o9WwOCWVs6LcS5sVAi08viZAIU?=
 =?us-ascii?Q?A0AR8cWeCR5Z5xaIu+vqMOZ7hoOSj1lWrsTenmi1ju4mL2tJ7P2fe6QN1+bu?=
 =?us-ascii?Q?6L317Iu2xVzuxOjQwZSfnpf+1l3B39khRZlMmbliGv6odPuFe6FYF849sf/N?=
 =?us-ascii?Q?XZhgNd+X3bYj1TvyE7LgCfaRXwyUA0BHP84K3z/KafOCHINSjG5bYPFUNhXp?=
 =?us-ascii?Q?XX8FQ/8mdYkM27G7LiYFnXriuzIdju5Cb1IHuxXTcDMIIwmQxeTKy/aLMLuV?=
 =?us-ascii?Q?liKJ20540jZ3Tt9Ljhhkrweq+Zmpo3Hznl3IqNMPyFjAonfUa2wuocA9R/gX?=
 =?us-ascii?Q?nKkrEws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zz0EG4dYh8RRE7HcgKQ5exJQIbWfQSq/QipxG5cBUtPPSf7n8xEddiyS2k1r?=
 =?us-ascii?Q?Ucb+6TSG8K//3B7ohza74/NlTaCMR7CHesWvzCr6J2Vj6yn1FZPZM60UtHEy?=
 =?us-ascii?Q?kKfEMWhnLGxcB05sGUylWCRBa/5t+sPv6E7NeS+2Y7q9Z7/36Hg5/ofUV27Y?=
 =?us-ascii?Q?I/U7fjDaOm/uAP+LAzA2cRxOtDzKZVkQeoyfL6nugAF1Hutq94GU62etbtbv?=
 =?us-ascii?Q?7xTDYNIB6HFNdz8+Kx0pzBqGupRa9fPCXD26c3B1fEowdUnJcTyKyE5AxE3/?=
 =?us-ascii?Q?kp9GVncDvmU/zrZHpSE3UnjPp/LFkHMviV6aceeSqRNgff2XO/oVbLTqjv18?=
 =?us-ascii?Q?JSdEbWMrvd07RJBpEsmPOlGwA/GxQviXCXA4M+IB8Q4ENW3t3dnwAhb3SDYP?=
 =?us-ascii?Q?wUZJsNdJQAtND5MBO1Fj/90vlkbD2EsSNJSXjJXvMvDl/u2PAWQeV1fScxcK?=
 =?us-ascii?Q?NeYXVxL5Ldj8mV70f7i3vRWXtK/PfvnaQtKV2cxv/TmerXJM8x1QvFfPyGlB?=
 =?us-ascii?Q?W/M3TinvTTNJDErtRdfyxqTa8EtCytNp5WvRDtRXpFUjAAIYV2rKDVKBALqi?=
 =?us-ascii?Q?s72jDilf/rL1Id59KSnqsu1YIeabt65FFNWDLVicCbuKjzMqIjb18YT53bUk?=
 =?us-ascii?Q?gOT3MaEUNzc5K8rQfdG+Z0ENr6eBhQs7QfrIrTAERrH55A98NIi8QbqPK+ut?=
 =?us-ascii?Q?zBlKBYndIeGWXeyCmSECdMR+OZ71k2yglxE8r3S6Dk7TKC5d7vdxIU5xzA30?=
 =?us-ascii?Q?kk3efbVjwTBYSUlsWq3QLa54BRQpg26Um5q7GvvXeIU3V4zEtqmM1jIanR0t?=
 =?us-ascii?Q?iYQsh/P6vE5OdXISJPWnr1xqH0YdqsyPEZ+TcwqzHjeYlnDvx+6Uk8JeE2Tw?=
 =?us-ascii?Q?b0fz923JQbF0zGVh4epb6PNUOET2DcaovlnwyR70W+LAPQGqXjh0w5A3iqz8?=
 =?us-ascii?Q?S/rv48Qfp5zKTFyRnLWBi4TtMr0ox3RReaVwPfdm2QjWPx5BnZZNja0v3npg?=
 =?us-ascii?Q?535swPm/feslLU962K5LpixmwZmuIHoLA5rmrOTz+GSmC/HyLATLyC5q5QTb?=
 =?us-ascii?Q?lr47692WVt6dm19VWmZEiZimaGmJ8GMDNiznWdpQUVODfVH6wosX9H0e2R+7?=
 =?us-ascii?Q?+805+3CgibQ0lR+wBqGd4h05ODUP2NE6iA39QxJ6y2HzBC8vG1qjXlMn0TJi?=
 =?us-ascii?Q?ZKsrvMyMxQTtEC5xGoGhjHdCq6TMoLYCReYUhrPEZqVuWyv4sknbbNynQ1Eh?=
 =?us-ascii?Q?d/TozpaAAjZAYoKB5hhOwV7KChUdQFBB43jaNm3k4fZNpx0VOZuSqWFZGejt?=
 =?us-ascii?Q?wiRPb6cjNjVS3IlKDo+L0dQDSzROZjOIIeo6I+cptmXVkaL4hP1X7EBWbywH?=
 =?us-ascii?Q?fNVmdqL3BqT6Kzr54PNlmCX2rqiKunaKEAxyyi191fkcF5gBxJbe0A50WKxC?=
 =?us-ascii?Q?CAiiTBRu8N3VZSGHalYofi8KugqNOzhx08SWHNPNa5nPN8etkAqCTKIUcXzz?=
 =?us-ascii?Q?pnHAM7b3lbbfu38TinEcL0ckuf0cbpTL+E2EVAW4gTuQIjLY7/CP8koxse1n?=
 =?us-ascii?Q?0RnHKyo2XiBidDvMl1+MPNqQxZvw2rxS2GL9TcQa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a953ae0d-ca3e-4e07-60d4-08dcf39eea25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:11:43.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQMiR1Uwp+IHbFcxggt4E7jV6wpc/4tCtMC8jyKbuGn96SjitIAUkhdzF6n3lU7N8sJUMxnIfap1uEthIN1vow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

In jedec,spi-nor.yaml:
  SPI NOR flashes compatible with the JEDEC SFDP standard or which may be
  identified with the READ ID opcode (0x9F) do not deserve a specific
  compatible. They should instead only be matched against the generic
  "jedec,spi-nor" compatible.

en25s64 already in drivers/mtd/spi-nor/eon.c. So remove it safely and fix
below warning:
  arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dtb: flash@2: compatible: 'oneOf' conditional failed, one must be fixed:
        ['en25s64', 'jedec,spi-nor'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index bbdf989058ff7..ce59b94d8c228 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -87,7 +87,7 @@ flash@1 {
 	flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "en25s64", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		spi-cpol;
 		spi-cpha;
 		reg = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index a1d9102ff32be..736722b58e77f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -69,7 +69,7 @@ flash@1 {
 	flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "en25s64", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		spi-cpol;
 		spi-cpha;
 		reg = <2>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-218386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69390BDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8D1F237E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D101993B6;
	Mon, 17 Jun 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SmDoDQNX"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2063.outbound.protection.outlook.com [40.107.8.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE419885F;
	Mon, 17 Jun 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663490; cv=fail; b=bmvpJX4PNe+xX4yRGc3Ef6xLXT9SB1uB61C46x1R3c5BpJ+k44KCv7CoMvkUPu1KgJugsSwWNnRuatnQM/Lpu9EKMDO2KT2GhNUvNVI/WdaAvJoqMNk1X6g9MQ2r1JYvkmyhrIuU+VIl9UUH7kcHmQKMy1QJdCogOTmNF21cOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663490; c=relaxed/simple;
	bh=ITlQLZQ+TQlCLweEf7e4yrx8ui2NLdP4HLWAC1d5vX4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mchFXfwqRp5g4LXBas+1lW54qQsJ03fM2lsnrqfjtKTYbSJVIbQz1EfJSVnLEmlj2VNdO9GsuNmAJ3xOyI9PscfMwnOrJU79OWxF5gRUTE7YKsP7dI9ZnZPromhk0vi7ZiyW9u2V26riTFb6Sq6n3KzWO//BQOHl1XkKzFUfMyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SmDoDQNX; arc=fail smtp.client-ip=40.107.8.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3+bxPqcNCl6QJ/IksHz+6ebJLhWVh6xI3tinb9RWGlLmJhQr4RyaPWIqvIwN2jiDVQ7Hyw+35qRH88499uxsvx2ZFUTacL3WMDUcEs+L07w/UdMJ37wnUI5IjBayv3hhvyv5yVn+sJoxoL+6mhuPwjUB2MmTNtFEZRam4pMahp7dcYR1zgJQNoLTAvpRCkzFf5wtCzMLatCq6G45hQoV+zzEtrOvbGeYOqj6uz1RBBxzhGwFMV2TaPH1oPg1zzQYTKyXOhuS0DqbTuDpPDWTwoHrpeK3gyGpCKyxn5Ab3TNX855uEJY2xkCrCWi4pY7A9fusTpXsP+hfti3HbsXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daeXzDV+a30tRYuWk7pXHLY2v9OFKpcygaRSYtWW3ac=;
 b=THltPCpBTbLZF7AfsPUAOIvEoV9ipNAC5NYUnGUlwZmNr0E6ldyQPnVZ5qXxzUd8+8AGQgsYcaRXL/2Ovfonkbp+oR160fC0CQtE29HRQ7DkfN6hCOmhgbWaxRgbUm68c+lCJ4cp3+QlruLlAXgMGrMJB+LHoV6TV0LF9Q7U/zPR4P08ZlwX8SjiW+dNsaZu7nxfngCBVMFCaaUo7inm8aX2XYdlLG653rGgPUSSNIhqY28czv1kje2dg0NyguFALgy/zbiziri069mw83nPQawdEi4b0PBAwh8G2Hk/4R90psBeiAH5E0lSLgDO+0mF+ViyIZDraco8IU6eb6uZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daeXzDV+a30tRYuWk7pXHLY2v9OFKpcygaRSYtWW3ac=;
 b=SmDoDQNXGqtANHqQFqjDigbbBhAGfwW+i38ozBLX6RgYdV1osI08a6b8/fAUWGBFEX+sDUEolGZ5XbrqlKxvbUWdu+bGwI1za/ME2P9glSXswb78TGpa8PS2BCDQ+mYhn58C8zRl0UqN16JHTgdISTygLIdFAf8hj1sZSE882Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 22:31:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 22:31:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] arm64: dts: imx95: add pcie[0,1] and pcie-ep[0,1] support
Date: Mon, 17 Jun 2024 18:30:58 -0400
Message-Id: <20240617223100.1539796-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617223100.1539796-1-Frank.Li@nxp.com>
References: <20240617223100.1539796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: c9702623-40fa-4786-abc7-08dc8f1d38ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|52116011|366013|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyl2vNyUuDwbDgXpecw1sirk50Y6aLASg3KP/P6O1CFQ6/8c5BbkIdnBRxh4?=
 =?us-ascii?Q?q+Rg09+r6pWTygH7Md9lGOhKoRltvhmelo21O/ykt3qYgCIMRlqoJPL6fqEY?=
 =?us-ascii?Q?/aDQrNIE0u9eN2qVSkuppnULMgdfh/QMk5lDwQyrZk2LTJarax1IzmM6uKfK?=
 =?us-ascii?Q?q41gR/3XzSwKyOqg+AfHL1NEnaZniFJ9RHNaVmBllQuN/2ufRKzAO8p4lBL9?=
 =?us-ascii?Q?w1X0ONRqk0MSqnoEUa9GO/5TZzyHuMB8p2Rbv1H4ubn2FDTPT94riw+YgI98?=
 =?us-ascii?Q?hzIYDKLDrS6VS2CsZA8QkPk2DKV4J3gbeyoaGgwyNo+6UQ2pXozMd3kcScCf?=
 =?us-ascii?Q?GQ9XxffHW28ot5tkjNstfSUDmKC01xI6eF5Erc3FS6oskp0irqBSTvzDWf8R?=
 =?us-ascii?Q?YEqYXZyA34o9CCBZGXjTpyzqpnyheNlPmLOSVf68Jq2T8YvlrgbkGak+obuR?=
 =?us-ascii?Q?jHKTxNLTWy28hm5/fZjckL4p+2wQYyCu7G+DlvDJCaq5cuIZ9Qs+lXz2RJLu?=
 =?us-ascii?Q?t0OKbtQinYy+ikUAoNZmMJ8MHPZ+omGH2lTHXXRkYfBzJ6kmoF3pVO+W+1LI?=
 =?us-ascii?Q?ZPYTOsbRpJxMf+1yey7IwNPs4Y/iJzCVYbXWX85lZuLPCvdpuvvSwoTK0jGN?=
 =?us-ascii?Q?iR+7yviXFOzM6fdR4S0QnKXMD21nnRNP4HhjxD3Rp1+xofC0/6+WWCQekh4o?=
 =?us-ascii?Q?etCWljUyA7P7QWkwpM1qWUD6e9VU2aYtihku1xKzu0HpFg7/yvuq6ei2jHCZ?=
 =?us-ascii?Q?0D3GuCcOEDkxCiLAPUDYNfBsnF6gIUL4vVipau98ZpttGtoNx16G/YYpOFcR?=
 =?us-ascii?Q?pbY4ASV41Vv5fwgi1jStGd8EwdFK4RJiN8YDxb33tv+3o6XxLZFy9A0oTJG9?=
 =?us-ascii?Q?UVJCIy8XSDnra9KYmr1n/6ZvUty3MWfqCkDUjXZ90dBeMJ6hqlcwDSRwi1kU?=
 =?us-ascii?Q?C4nGq7Kh/vijaRpeW/T/HV8aNTRyjHAtawCe2gQ6KnvmwUUNSn/DdSFRQto+?=
 =?us-ascii?Q?1gdljRsbkxsw7j9vbvnPghgRIRheyUQOvo2KI60g4Es3TMOxQapuQwVURii8?=
 =?us-ascii?Q?Hkh7aRR9yxC07TJE0wXhulOiUfpvzeNjahcWZFOwrSG59WqAf2hjhjkOWgB4?=
 =?us-ascii?Q?NbEF9uVc28VMHTZYX2ECTQ6GXhNoB6JLGWBHqJPXFww39mJHr9NN3dZtM6aG?=
 =?us-ascii?Q?qSIJ5yfjxf1UhSPRaX2HZ2b77LZcHj+HBGiM2xDurpE5YGkqlo3FogzGUHtl?=
 =?us-ascii?Q?mYDsjEXYlwkf4Us4v0TSpcFUxDsWL/Ku2c+rop8qOVPZe/XdzYmJFVRJSxvA?=
 =?us-ascii?Q?IPx4l6zhul5b8d9Te2AdGPYBUfImwWQLcWxv+gY7RswcRgoh0I/AdcHZexdX?=
 =?us-ascii?Q?Ez3byNKc1kuE2UxQMh5WoWreIXVk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(52116011)(366013)(376011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIPrlSrt0YBf5wkuZEOvzvmcf5fT4FMUmVotZ3owiF62z1WGxkKMBw6OlzMA?=
 =?us-ascii?Q?cW5bPuG9VjlyuMkJk4Bvrt5luvpQsbTXRg7rM95FpIkV/HuKtr1vcshSK7FZ?=
 =?us-ascii?Q?PbbTzoRKkwIwFc/FgfnLuCu8N7+6rnsD509vohIIamLuhFmPInI5AHJlsfF8?=
 =?us-ascii?Q?RfT63s9nAoPhYHz4SiOka6+ppKRTe5aal9or0/TLwyLg+i4YBeR9LJgrjtOg?=
 =?us-ascii?Q?uYpJt+6XlvWN6bYYJm0tOINb/RzSYKnFb7HOyn2QoPZXW5c5AE/xTmt5OdZ3?=
 =?us-ascii?Q?YgQ+1bJSNM3CKzTWpibqUGLljwD+V5SGbPi1baBJ7TTvVuMrXvaaViSDKGbd?=
 =?us-ascii?Q?Bso/N8Zj8+LODceRh4X76o0it1vwO3uwhFd6nhHLGZQpzq5pNvPWHs1o6WFU?=
 =?us-ascii?Q?RAfkRbwEJVlpDCw+OESGnNkDwykyADC3Pt688iAtXh6nbalYxjPoU67zd6xR?=
 =?us-ascii?Q?1VZJ/CRp6ZELR/2sNpJ9fUqbRk/H2n+jxjLulj7gRGMqjYXdNH3i0qEIbLea?=
 =?us-ascii?Q?aeLMBXodQ4hwPBf7wAqodt781ZItfuG5z79YeZky20MQY2VGXoF2xiQs8DEj?=
 =?us-ascii?Q?22mOAObzJxLiYCemfbCab+LysZkF/WAqWnKTIcQraGzcIcMRMOmm08e4BUIj?=
 =?us-ascii?Q?gIgU0nh5Q1y5t1OByD+sLUCYWsR7FPT3aTzPbvvmazxaxXN0c/Da/gDzZ1o9?=
 =?us-ascii?Q?69Eb9BnUqTg/dhziB95V9CqHaRmZ+QQ876DzPVkX7pLIIwEM2vOzUwAvEqbU?=
 =?us-ascii?Q?fGluwJQSvwXFjwYaUEO7BB7np4nkDkTOGbKardGtvUo0ef60VroBstQyMhWl?=
 =?us-ascii?Q?IwtNNOh/S8+opwctWP0kxnZOow64MGRFAS2EspUVm2hTQbVPNIW9K6guaZU5?=
 =?us-ascii?Q?avl5PNQWKAxkh+lrbCKTjLQkCU1Z1nQaPmARVm0rZ5C35o1j3rClT89MerEf?=
 =?us-ascii?Q?IjYZlHLmxIn8yhwmgk0nq7POgaI+1NzlzA4jyqE+rxP6jLspe34IImGbcAQm?=
 =?us-ascii?Q?ceWkZXdO5Mkh2jFepU1OMdsugZsIF4r+ILozNwAw/BMEsUqBY4znzEMsgzb3?=
 =?us-ascii?Q?FVfMFvj4Z88L+N7hcjlkWpnp7ggi55VDa6D9c9IWcLUK8zE6gTiNouPYj/jO?=
 =?us-ascii?Q?fDEeeh5FUzglJQ+7UbTCo6/BcR7JWCCMYZCU2KOdDI9ibg0JLAXrs8VSl3tV?=
 =?us-ascii?Q?bLS2cgqM3rAxWKNfcWouIrauJ0W4PLFeQMVaOM7+j44SMqMpCXI3pepgb+m5?=
 =?us-ascii?Q?VwwMeXLNU2goiv+d9qmyPDarx5insUFzTrhrpnq4Knnf1rj5Y3o5ZGyGMfVx?=
 =?us-ascii?Q?0NQEfRO+P/TWaS7ngsmskDm7HldXaoYOs6B7iW0Peg5DTJhHj1VvO8aXog9y?=
 =?us-ascii?Q?QTl8eqNQuJWItpPcVq3ENxKLQ3Ooe1SMRp/ebkKYSOxXVHGENfMiOJGyvQvU?=
 =?us-ascii?Q?TP5ze49xEiuIJkjq9WZrTbfCEv01tRSVKokWhzOn6/Z01P6cK3ekaasWP/rf?=
 =?us-ascii?Q?yJVkyyukfSVdiesioc6DaEn3IAOQeZT+JcTb80JyRhmfwaKfUbIa/XmeYZi+?=
 =?us-ascii?Q?2KWxBr0B2wH4MW/DLoknDY//Qrzdj5yNOU66w0+L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9702623-40fa-4786-abc7-08dc8f1d38ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:31:25.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBIJ6LNtfueYYW2zIQz4Yd+6cDW5DdzCTTStCH6IOiVArLVVJAsHmwFybbs9DWmAhJbGHBJiX9k78VxV+5XymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

Add pcie[0,1] and pcie-ep[0,1] support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 134 +++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index cc5e829e76cc5..1bbf9a0468f69 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1054,5 +1054,139 @@ smmu: iommu@490d0000 {
 				status = "disabled";
 			};
 		};
+
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x2000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x2000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <8 0x80100000 0 0xfe00000>,
+			      <0 0x4c3e0000 0 0x10000>,
+			      <0 0x4c3c0000 0 0x2000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
+				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x10000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <0 0x4c3e0000 0 0x1000>,
+			      <0 0x4c3a0000 0 0x1000>,
+			      <0 0x4c3c0000 0 0x2000>,
+			      <0 0x4c3f0000 0 0x10000>,
+			      <0xa 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1



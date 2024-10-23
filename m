Return-Path: <linux-kernel+bounces-378352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC819ACEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCCB23553
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3141C6F54;
	Wed, 23 Oct 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmgHQdhT"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEB1BD50D;
	Wed, 23 Oct 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697221; cv=fail; b=GnXOTKcH43nAIhBw99ZM7AlLKOtsre6oSyKbjqLRnJ1WG1rRnQ9wPL3nPxP4bdxQU2lT+4UQRODVG+RhKIm4C+ikzHKw1yDOzQQeoOEAcewNZniGWqttXOBi2m2AajU2b9tOrwn6q71L+EKjaIzh1S54hfPY0wZ41uW8OOCBhUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697221; c=relaxed/simple;
	bh=C51Z7O88CHWKEUSU7v74PNBQlKLmYGauV01rnEXGHug=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jMj8eI2AhEdAhwd9ASTciEktcr7EdQ1BGhvJUqlYH9qLxQpFXtGY1hjrNTgDj9byDsdUuzJTWmSsIsXHHx/JzsvXpyuhC3LHd3xG9jCnEy0LD6OcMg/b7jqjymhQP1VZMoNOsshiJcp2bZKCuy6TMZVqjfvspLAszRRZfQ762dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BmgHQdhT; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7gmsn5ztl8tK6bQP763Kl5YXy0/ys1y4W31qSQ6DtvRgtOD6azTI7e165R3Ns5eDTqMBWyXnVpENx23gr7U2mX4RuNQbjPiwPW+C5naU8SZJLxJgOs8BMe3rz4BV+BSn3w7XCfWbfkF6I99e8K73BhHrbly+eJg2vkMTWwRUZfka0WL0d0ce4z3rqAHh7QFH1L4zmVeoWW3xqbdrClVmkkJgqoGYlU379a45o2h5sn17vJbXn0+RwwDj4qL2uewggBzsGHonlYZR41MfK08yXemzouSlnZvVWv/B4CdXqaEyQqGz8Cl4mreguJPeuB1PdtN31M+XvvxRi7xqmBJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSRbxLpPEwUJI8t8rB9n7TGg2dxmDujJ6x2YMTkzI2Y=;
 b=n7l+xGQtnkbrpnzD+MwvK/UmBESMT7YMH5EDgf+Eu/f0OMJcWfjo6MlHyGrTbvVOILkuLbtH9e6/EKT0on5Sqh+pSjm/4r84mglEcnB+AICurrLnDcYJLDit1dhI4zrWv054ptxCEA7EU2VY8z+BhEJe0CQWgb4oNoUeI6XXNj4EvnykukcVJuy6gN65FdhVm9/Sk+ouJfKzvQeZZ3/pVMc4j8qnT7jAmuN6eHq9h1wV/ujUV3rvxKFun8NtYtijSHRPpFtwYg3jCrexaWV4uHxwzxeoL0IZyxzT9j1yMzTnuxkXyhAFYkB2v0aVn6vFc51sOmcSSxWLBMV+zOL2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSRbxLpPEwUJI8t8rB9n7TGg2dxmDujJ6x2YMTkzI2Y=;
 b=BmgHQdhTMqXP6BL9OA8DpXm86usFiP/vV0pqh8lz/c4oMzEHwa/cmM1ivvpKgH4t1D53LADL0ZKzrNH/HYKlh/jKsdFbrxbCnzG0kt0IvL64qZMFvMBIGENTdJL2gAQSd3EVeS8p9u56FG00dyF56yeu4/ftfyJozBbFTIMJSphzEUx7Xb3Q7SSh6WhHl+BJnUDKcjLWppjJ6Bqm5Ly1eMB9XABa4NskH+4KFjYkSx9R+eDPb8OFCTEl+ROB2v8AGEy3gEscIbCw9shPuxvIAX55gZDfwGl1u21EyLEZ3rJKbzrbsosHuHfE9XTTVPn0HPzTvhVOyWuJkKDTwdSA8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9001.eurprd04.prod.outlook.com (2603:10a6:20b:408::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 15:26:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 15:26:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frieder.schrempf@kontron.de,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH 1/1] arm64: dts: imx8mp-kontron-dl: change touchscreen power-supply to AVDD28-supply
Date: Wed, 23 Oct 2024 11:26:36 -0400
Message-Id: <20241023152637.1301847-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d430c56-0a64-40b5-c996-08dcf37720c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oENdp/odKKjIoeO88d0DJ/CoZ+2qS1q5BAq5rxkhUPgTz+srm6+sS+BhoLWH?=
 =?us-ascii?Q?aDMTP8sJSdqeLnJrf07KzsoF4VQqhlkDxt92MuZX1zPnRTN7vzohkr7z/+4L?=
 =?us-ascii?Q?TH+PaghxFPslDrCS8BUOCCAM3MiOf0jDogJFJkOSvpDgvTInM+Yt7u9Su0Cs?=
 =?us-ascii?Q?xpVETR03ocMOIKzmejljKSYYGXD3Z9kIevprGLwRRS2IQjJg/7R4kdoJHVxe?=
 =?us-ascii?Q?4+MJ5at4lB/zblkCeqZIeZhaPHz560bGJSyEvS50VZZezFRDhQ3XRkaishqu?=
 =?us-ascii?Q?jVaybXh6u5a6Edr/5gHSSM/e7W4JGPTfUiX5vNvRHjDp3IhRhS+1E6A+BWiq?=
 =?us-ascii?Q?5RnV/7zjsAUabWTRAE9yFYrok1FmQSMRGngHjFjsfxhHz6ALhdRBAq4FmIdM?=
 =?us-ascii?Q?aqM6PravT+HmL6QBLmFXsfN/TGSz/7NBvI8YzxLcUfRGNwNbX3K0gdV5LFdQ?=
 =?us-ascii?Q?6CAKa+6IDO1ao6mFViXMQX4wUJ1eDfyBhJzo3PGXCHpwCeOupuDOm2J8MVmc?=
 =?us-ascii?Q?pEN2xnKayfZHVfOTpjCG57qFObiVYVI2YCWnyXXVDDRQOOeIBotydbjS2pu5?=
 =?us-ascii?Q?S5jqnhZfwjRX+YGtKo+Ri2e8uFrVTgcrYT5VLJ8JS2vYbQ9Gdc/1WHgTNoRt?=
 =?us-ascii?Q?j2gf+/+js5Vczurswsf345x2dfFTtK3WINhT7DI0G8IpBxfG0ZkIFa0jF84V?=
 =?us-ascii?Q?+2UhUj8YSgoeoWbuMODvgfOb9d4Qc3tTYQeVCbC+IEXkvPvdgpbnGzMKHeYw?=
 =?us-ascii?Q?zU7tkmEvBGCf8MYWvQpUVsZNq7YdKCiTvuTz/ADCqPWgBa8edCgKww5+ogS0?=
 =?us-ascii?Q?GdJjmS57k856Bzux33qdARYMKJcQ3t2KEbg6Bj9SR+jjBP5h+e03co5enrJU?=
 =?us-ascii?Q?g1r3U/K4Wrlv8UK5he6KtwidkVt5zZhm6wTs25EmzJx0NWXYrp5e1kwyNeLO?=
 =?us-ascii?Q?OZasYFY//kqCkacnZBpibcvzpWBGmrvIBPI9Ox71ykaM9sPZh3DERoTVgM7w?=
 =?us-ascii?Q?vS3R9He/QyKnARyS3jRq4M++3eIu4Q17VtA93UrhprqQ0DK9S/iYqI7CeLFv?=
 =?us-ascii?Q?+LUCEzGWpqsf/SE0yHOk6wqENQvllxDcLfrz43mIE10stpaWTQnLXR5w9DDb?=
 =?us-ascii?Q?LeM8bqxKWnuAtdM5eXtb06vta85xgUy8N5pkslAQ8kVOdPnM5sa01BeEj+ml?=
 =?us-ascii?Q?/AqgYBU9fMCwHh3jGLuQViQP2/Kbe4URdk1iI93y8zqblfdaqbRNeV1j7ncY?=
 =?us-ascii?Q?vVAFlmG68qXePSASOhIOSB5RuSWWnxuy7zwdOfelDMDm4ibeQUoFgUiruVr6?=
 =?us-ascii?Q?/bVdpA4ryIc24PqhIuBp4u2AJ0qAzKAEeaGQ7zObL5VpPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDZABoHhfYuxmdP//lFYshozUe4FvgBAxj0FFs18WpDlWM9UKscEcPHgF/kb?=
 =?us-ascii?Q?ctFUmXSlcxH9Lx+TkM5eZmaYHXUvr96nw6aN7jd4RBahJMMW+zfoF4S8+d7t?=
 =?us-ascii?Q?Yi3szkF+v5Uuh7k9UmJyxZLngSokyBxHS9iwU8ZZwMxeA9xImBPnnLRsLfbP?=
 =?us-ascii?Q?okPB+yBTqg4GLWa4bgcQYnH8NlYxHxhqFK0UrrPrPkNugSyl+C1ExjiFpUxG?=
 =?us-ascii?Q?w7qMEX3k61pX0O9DSxxSY3K0xGuxZ16Oyjtn3XyDVazhTirDQJWEbkJJ+Nsr?=
 =?us-ascii?Q?aDnkbteRdAXn5wJygVtUhu7zm8OfuCWXNBwAagkwCxcCSHsBVWXvQn4kr5oj?=
 =?us-ascii?Q?FlcJ2y0wGXChu2m4XUEIw8/GGbuGGhPkAyR9tPFqTfmRpWY4szNuCd+SxWRo?=
 =?us-ascii?Q?A8jYdEDJHXYgnyB/54mTDg6BvGm1ciexCrcjNdaxGYDxwRypTzqJDx/UIFf9?=
 =?us-ascii?Q?rWlsgafl5X9Le7uVMzFyTiyIFJIoh0UlJIp3y/mi2VsphEb0INtjxdMF6lWq?=
 =?us-ascii?Q?YgRcNjL/82Xefxl6kRVcPpsR6r0p0ymcvZOKvNPfbgVj/ncFNDuVLPYgCvma?=
 =?us-ascii?Q?TbgrOrTLeXlMmgyhac0KEfSF4vrPDPh8lDdAeaqKEOTBBz5UeS+6eUulpdCK?=
 =?us-ascii?Q?gQsmuHe0dJMvJAg4exZGyNTwxlMhKrnEpMouGXV/EEa0u6H5aLBw8ACHKadu?=
 =?us-ascii?Q?b7qXqpNonHJSN9bLFkYK1+w8wOLEwUD4WGOdhIMS/BXkKlkXvZ2MIFpWtAzf?=
 =?us-ascii?Q?j7KjPj08n3PO0OEGhcOLI3WYTSYKkEdy2iIZLvxCFk19JB/YJuQ/J3WtqzVR?=
 =?us-ascii?Q?BBp9g+2rWhAWQLdd9ly/pIRCGO0+utQYF6CYTCAHI5fGtOIQdgeb/YJRWNKJ?=
 =?us-ascii?Q?+xGGxrTIj8vMaDNdrqAUWPvC5fZbrf+ZE3cvOSioRd0cKbJFGH9l2kAk2Xwv?=
 =?us-ascii?Q?h77q9OHJ2iNlFtDpaKdEKkJDvz9xRNhhKjR4ipTdJXkX38n1tyLQlNzgcLk5?=
 =?us-ascii?Q?Mb89j6ejeHgjOrhJZOggTZXrKNRbZp/deVwQ2QFOu7yrDncltuyMAagJErm+?=
 =?us-ascii?Q?w82wBQwopNwVVNGYDPriZN7q9Z27s5twQWxmpBdUwA/X03CPE9a2LCJPEqJG?=
 =?us-ascii?Q?4N8XGlLa0UBclaTBNb8PLtjWb74W48NsrNqF49lZ1VFjWu+ey1oDBW1itfFR?=
 =?us-ascii?Q?Xo4536WA3/6kgp+twOat00G3RuO40UJb+Y6QWCdjtv4FCWWoeMSj5pjgVD73?=
 =?us-ascii?Q?lb3ku097zg6wIzwlk2UJRN/p42uypYi/lUC3iI8c/3pplfz1cnBmSSZFRKF+?=
 =?us-ascii?Q?NCxW8FHRS8gQ6Q62b28rIFuK57Cd8ZwPwkJwKil/tx9ncS86NsrC9j/ZoOVB?=
 =?us-ascii?Q?X+BjsCDPPztVBlU7bqGEmLfbGnwkjiKoR+uPx21nX19GeGOpxPPh9+dJlTxp?=
 =?us-ascii?Q?dX2w0WaKhxexEpcxsq8UdQ6YnnP2874qclUI4pngK4WhmEV6HXJreKzRHVb7?=
 =?us-ascii?Q?Nz+sB6JWKKszVHP+EqFU8JNXUl+zh8F/IJ4Gz35RMUmyVpb83ixxEB3OVUj0?=
 =?us-ascii?Q?FlFoV2eC4WyaPH9iSLwxhbA/WEhKBRyhsQekldGF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d430c56-0a64-40b5-c996-08dcf37720c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:26:55.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2VohvuyqcFbUUGOhEGJEAat89GHd52G94Wcm0zz6oOSsRDD/WT1ecSYY57S0cbEmiJKLKZZOkEwfcx5bTyAjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9001

Update the touchscreen power-supply from 'power-supply' to 'AVDD28-supply' and
'VDDIO-supply' as per the binding documentation in goodix.yaml.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtb: touchscreen@5d:
    'power-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/input/touchscreen/goodix.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
index 134bdf156607c..a3cba41d2b531 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
@@ -80,7 +80,8 @@ touchscreen@5d {
 		interrupt-parent = <&gpio1>;
 		interrupts = <6 8>;
 		irq-gpios = <&gpio1 6 0>;
-		power-supply = <&reg_vcc_panel>;
+		AVDD28-supply = <&reg_vcc_panel>;
+		VDDIO-supply = <&reg_vcc_panel>;
 		reset-gpios = <&gpio1 7 0>;
 	};
 };
-- 
2.34.1



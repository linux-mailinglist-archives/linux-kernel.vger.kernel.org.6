Return-Path: <linux-kernel+bounces-292772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880E957424
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F5AB20FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2DA1D54EA;
	Mon, 19 Aug 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ijd0ndH+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DDD26AD3;
	Mon, 19 Aug 2024 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094430; cv=fail; b=SFnv6mGWG9G+TP0FQeow3MDBu22xdjNm5XtFqSuhMKB/+bw0+CKyxmBZnZZQeSBumBwSLlj4zvZISDIt+XcjQppsGCWHSg4Km6DP/ZLiAD/kiN0RDAl5Y0ZryjwwLTmWx5PWw6n8HNDyVDOYJehJv4smuI0PBZ1oZRCC2bIV2bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094430; c=relaxed/simple;
	bh=PgJyh+IyD9D9EnsZLGv1WpFInjDJiWmimtlLPpqNjB4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N3bzWox7RI5LrFyHGbiACOxi8pbWJsvCnnpDRcr0xmiw31DLhaNNuizA5lRB/OSTNOvviWYTM8irixd8u92uGgHyaV/tCrAiKWfKXYD8K5MRlbdPdejrnNisj0jYpqeeTWgB3I2cXTykaxeeRMBI/RZfva04QIBlOYT+61msF2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ijd0ndH+; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfJJq2QlcIGnc6ANepMHj5RfiPmYZ2zB8+hMCsJtX+1ba+EvDaUNpSOVGN++Por3f09y6/X02sMEuuCHyrTuC1s51ouRrGyCHt5gbgJ4e2XNbpwLYHZyRbTJ/xIn6d9kLXdP6apRxvVexm5Wcf5TPhcMfWatcYIwfYzjAMcuTAcO3rkdEqCXeNVU9LkPapZyCnFH/lr0kTO4s73fxLYwcDhpOLAJI9SOC/xXizfY074ARybqpMwTNaKJJZ1gELNLSkCnT9VHvqlzL4OZCMit5rmDNrIHLTsjnI+9NKfuwaM4u8QkgnG/GyBFypp3bEbhKLVyydZPzz1zlO1Z6tkEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEQTaYiS1RSDTWprC8GBj7M1OhQkhPUS4Wtlk0OYcKs=;
 b=ahKlinLqFU0j8GqJYwJr/uSig18AgAfemOt9VlNvHje+5EshbRSl1U2ZMA+ulPMra6M7vxs6GWcoWIDKY/3orA0aKjVG8DjaUL8s/3ciJ8142Veorjpk1zzKW67rWGf+T/Wc84SudRH++gUv7HycnY3tSXdi3SpRdNOiaWzkQ1Ac5n39p9a851p31mpZXSJitt2D5rX/30nXTiopsYYkrAe/yHoC2DxqwsXY8MtsgtBz/heZe8z9qjF7uwyTZndwAEFMd1wv2/qjaTfshEkF9GeV8r76DNEowvFpx56KOy/YKQNVDow5nKFF/t+qKiXzqn8uQQJqVHgoLz0GuqXN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEQTaYiS1RSDTWprC8GBj7M1OhQkhPUS4Wtlk0OYcKs=;
 b=ijd0ndH+VGBoVy2atbpAReFF1Jc58xYeOxa4jm6ankBCRa60IgDEol2xKydCfDiJe8lZ4uMbGzKzAE5YBgTfxf/HtQSAGLY3AH7lPJVM7dc+QOh2H1TVxx9L2xCR6PASqBFzOW0ylM6+Uqc4WaUBAHrJ2/X0IrJsROlbbC7NYcHJbJHgz0yobX28P7uKaiO1jJSSQNX1BtG1/GGerOs3unTXi9mbOMHO1zv78sH5WnhmtqXciei34dfJdu6rc9qEx2Z5Ptehl6hg/W5LI5q+Eue+4Sbsk9HEI3c8loSsWcdyT12zZNXXdUhUsgjGckkPSYvL+62s+Stc7ozKeFdoZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10414.eurprd04.prod.outlook.com (2603:10a6:102:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 19:07:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:07:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to yaml
Date: Mon, 19 Aug 2024 15:06:51 -0400
Message-Id: <20240819190652.373222-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10414:EE_
X-MS-Office365-Filtering-Correlation-Id: fb536ff1-7367-4171-737e-08dcc0821dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/El6tb19L+7LAzlWhKekeqjNKF5JnV69i847BakjEIcAfuIQ3OoCbD3zYXx?=
 =?us-ascii?Q?KrcUH4+HZMw0jLdnF6evl5tex2/cfpMF47xHHLrp2NhKR990DyHdojZBMonW?=
 =?us-ascii?Q?qRqTAuDZvNVhE5Nn0IR8EmhWYwrtdFJmdrtgpGxiyt1x5vzrgmFCXRTs6m/9?=
 =?us-ascii?Q?I6qKksuumzb7mO2Q9jsMPto3gHhlscx4D12eQci5JCLbVIEl3kYcSMkDldrg?=
 =?us-ascii?Q?PWDZzk9hWPnTvgnTNVfwWbAwNBIsGS4N46j3Yh2xj8BkurnmedyHr2PvtJfI?=
 =?us-ascii?Q?8upkKaHCULXC9RmfRjxqC909XufgCOjPL/fIN/1Y/FwCx4AOpDdqYvcMUw/s?=
 =?us-ascii?Q?T14jElB8P04l+r7B5XYTIrd7xQv3bv7tF6cyh1cWZ99M6CEZkbA11qC8GvTI?=
 =?us-ascii?Q?dmQnWCrKvJ0EeMhSATi33IDaPphXkjgJsl2D6loLkwZFHF1IpzF2aRZNrKEy?=
 =?us-ascii?Q?BZdS2/oc18gq5f6EnbXdFH+F8nPA8g5ZD18AQaIWzTjkc+ffTtfF9bLGwX1n?=
 =?us-ascii?Q?D3GoH3PDX6LL7looBwwdKvgmxitj+NeczL7IZl7mvTcVNrTSUGzH+Px45x0C?=
 =?us-ascii?Q?2/vsi7n9AEAeS8tUFMhVUed13E33MKAx6ZpVqk2ucZmJEk0rdTLJL0Unmpyr?=
 =?us-ascii?Q?mNVpsfX6CSopih3Cvp5LNDFI+7VHQBYjydOymTCNqx6vrWKCuL5EW2QtnKN7?=
 =?us-ascii?Q?SJc7HP7+0IviIT6WEpB3AdZxq8Niy4E+EP9q7bvMTGa6ztXmdrjnzK+aCK4W?=
 =?us-ascii?Q?hzQ6deV1SijRP+F1DvI6FBbc8BU8I3+PpFYkrf7uiLjUVOt3T8vGiCKlcm/q?=
 =?us-ascii?Q?Vy09zuyumh1vcuIfPkyQrWA43OD3R+z+w8ftX/dDmSDQZolwOosx6mslo12z?=
 =?us-ascii?Q?zF9ngFfAfuyL7cpVbfgO6yhR8m78wBWnuVmFfSQ50iNVuMXutw87yNvb0vxK?=
 =?us-ascii?Q?0osSNLFKw5wSo3qz8pa5PBBP8GDwhV39+XR09JjugeZDtsxcJJwf1Pt1bv3m?=
 =?us-ascii?Q?8FBeaUXxOO7un2+Db+6CzvHaXGChkDLLVAn6ZuRBMTMaglyDW1PVejSs8+Vh?=
 =?us-ascii?Q?ch/YUA1fxT3D79C+Uzdt5EBrHq5J6AJB0TKxguwg/Liflo4HZ8g2W6c39itZ?=
 =?us-ascii?Q?wuosUd4pTrsBqhp8Y2RMQLFt6El4lk1b4xCWn5epd5sc77wiy07706DygpOD?=
 =?us-ascii?Q?Ryo4XBFEmaDOTkslB2EL5Ea8rHZFP8PFf3oCYWJevxmwVFDxMqb5knuIqL5v?=
 =?us-ascii?Q?X+7BNc6xoRw0i7TyfZezhB/YGlNbLMo2htMEEAe08FFL37xNI/1xwMSYcmMQ?=
 =?us-ascii?Q?TsEZF06VXwfdjsflUzi58eQ+DZYTrUSPZ8FXqSGrjCO5m+nEtQj0cRpPaEF+?=
 =?us-ascii?Q?HWM45scrpquU6HRC/zgxJxpZJ7C0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuwb2OX4uQuntVDJK9Efl4d8geosEMmbro6F4iGd6d9AH3jbEzP8K1eN1Ea3?=
 =?us-ascii?Q?zK+yIpCeFs6QfiHQ/2fSg9NJHuwkEz0M2Mw1Mvv/rXJPDHz9iRj0H/YJI0j6?=
 =?us-ascii?Q?NN0qD7ApXA23Q36GmXnVvJYdkwA1eBhHBGpvqHhaBJwIMbP3Den68WJHF1xc?=
 =?us-ascii?Q?3txdYJNO8JNzrKTvxgUYZ1FB6StNbwoJbosXFgvvAxRJRMQn0IbhyyJOlCA5?=
 =?us-ascii?Q?z1eEdSDvoNJKnY0HQJn3mQe1iA7YkC9KI2JioVYHabxz2UCQp9bXh4AcgPYY?=
 =?us-ascii?Q?1rbBqE3tw5c5RVhqVhlqrIMvkxzoFrb1zo6WjFihrrlo1ppdbbeZYv2JFOXP?=
 =?us-ascii?Q?QQjlPQG10ZOIAGrOYJU5IomxEN5gaBGST81NHcFZyyvCaJtQMZf6rCQ9TXRM?=
 =?us-ascii?Q?1dR9WgPaonBiPXkbIus9y5kXqFuECir00W4MhOvNE3ZUFCn561gNFAY44j4G?=
 =?us-ascii?Q?Ks0cVyNOZKTJ/rT7EorXc5Vi9E4XrfdNWYqAEhfo4zaPlnAmlcY9gPku/jFp?=
 =?us-ascii?Q?eVeVcNv+9eP1LkRYtt7m2uc885rd0S7VKTrvug+J32+0NzrxlVi1uSP+tNVu?=
 =?us-ascii?Q?VmXIZ2r40VgrXyBLi5pQHf4zrR14hPJar43bM0FshNhFlDdNTBebFR+EYxhh?=
 =?us-ascii?Q?UHDXYpk2QkXsvMfJocrmOJj8GHMwRQjFeF7pUwodmkG0ldzLMduaitMtnXmD?=
 =?us-ascii?Q?9uRD4OfC35tFXXjb94yy1QYqW0yE7MTgsSCrZo9KqW+YsVhGNGlhfWXzSk/0?=
 =?us-ascii?Q?omIcLQnT/U4PDdowBQlHZ85bJ5IXZC9nVuddQNCWiIuH5LS+WCUX4wpsg/N9?=
 =?us-ascii?Q?en3VSPZjTI0KYALzMhNrLosGlQMMIIDyg38g81/zjazGQKcQr0/L/ORTDZ2b?=
 =?us-ascii?Q?z6qq2wXO9AQDBSCLCg3CNi6TvUuqFfqA4Cichtda4DBkPUMPRsLTRQ9hPTLe?=
 =?us-ascii?Q?tdAgFKjc8o6m0LHyz+8z+xQNjEs0Pf6262w6coADGlLItTyAazQgK+V6alLO?=
 =?us-ascii?Q?fYwEo3QOJUuYIZb0JbzxTQSlWRWYo7xwKtOqOxeF2Q4O5mVZ92SPp8LKHAPx?=
 =?us-ascii?Q?3Fuu9+HadRidbVmhQXSrtP/mi8PS5LqLAFrastPgVpdEKlNC5+xMHYAOwJIx?=
 =?us-ascii?Q?qlGs4fw9ug0b20e9sYxpdoKNigxQKXDMRVCceAvK5jqha1XEsKf7rYX2awee?=
 =?us-ascii?Q?PWvFvU4ArWu75VORQ2zJtM6UFs5ZhjiS+kX8dbQvbry7LmT4h4wSkYDhvJer?=
 =?us-ascii?Q?67gGOCFgC4xl5zYiSEF0Y0ABrzaU6LLfQSDpAy3rTpjVIghcjBG26QcSXpJV?=
 =?us-ascii?Q?tUlWcCsfYIKIB2aarD7seZKZ1utjiELPa3AJy22HaBjTyG+BWkhphXHt8F7g?=
 =?us-ascii?Q?Rl0icRi2IzE2GcyTypJKjX9YBaxfxViwarr6TQ+TVmBw5/qIQfi6fPGhqlGS?=
 =?us-ascii?Q?NDISdAnOcNqtexHeLl25OyxW2mk4IUOJJjR2Mh4pDPok9V6ibri0z7oBF+o/?=
 =?us-ascii?Q?J/o2T+2dQkokwyGTwnXXF4zNifVrGeDk5xplVEoE7HSgST/WdiisWj5kiWQ7?=
 =?us-ascii?Q?EZgJZugjmdiJrXmTh+Kk3Kc/TWppCdupxFZ9al1n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb536ff1-7367-4171-737e-08dcc0821dcf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:07:05.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/qPnahJQ1DZJB4XAV4zqtml4H22h9IWhu6al0LmvScda9K//6r1gEUuPn7GNpxNtAER8f+e2EswTF+MokFFpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10414

Convert binding doc ltc2978.txt to yaml format.
Additional change:
- add i2c node.
- basic it is regulator according to example, move it under regulator.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
	failed to match any schema with compatible: ['lltc,ltc3882']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
- update title to (from ltc2978 data sheet).
octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
---
 .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
 .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
 2 files changed, 94 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
deleted file mode 100644
index 4e7f6215a4533..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-ltc2978
-
-Required properties:
-- compatible: should contain one of:
-  * "lltc,ltc2972"
-  * "lltc,ltc2974"
-  * "lltc,ltc2975"
-  * "lltc,ltc2977"
-  * "lltc,ltc2978"
-  * "lltc,ltc2979"
-  * "lltc,ltc2980"
-  * "lltc,ltc3880"
-  * "lltc,ltc3882"
-  * "lltc,ltc3883"
-  * "lltc,ltc3884"
-  * "lltc,ltc3886"
-  * "lltc,ltc3887"
-  * "lltc,ltc3889"
-  * "lltc,ltc7880"
-  * "lltc,ltm2987"
-  * "lltc,ltm4664"
-  * "lltc,ltm4675"
-  * "lltc,ltm4676"
-  * "lltc,ltm4677"
-  * "lltc,ltm4678"
-  * "lltc,ltm4680"
-  * "lltc,ltm4686"
-  * "lltc,ltm4700"
-- reg: I2C slave address
-
-Optional properties:
-- regulators: A node that houses a sub-node for each regulator controlled by
-  the device. Each sub-node is identified using the node's name, with valid
-  values listed below. The content of each sub-node is defined by the
-  standard binding for regulators; see regulator.txt.
-
-Valid names of regulators depend on number of supplies supported per device:
-  * ltc2972 vout0 - vout1
-  * ltc2974, ltc2975 : vout0 - vout3
-  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
-  * ltc2978 : vout0 - vout7
-  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
-  * ltc7880 : vout0 - vout1
-  * ltc3883 : vout0
-  * ltm4664 : vout0 - vout1
-  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
-  * ltm4680, ltm4686 : vout0 - vout1
-  * ltm4700 : vout0 - vout1
-
-Example:
-ltc2978@5e {
-	compatible = "lltc,ltc2978";
-	reg = <0x5e>;
-	regulators {
-		vout0 {
-			regulator-name = "FPGA-2.5V";
-		};
-		vout2 {
-			regulator-name = "FPGA-1.5V";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
new file mode 100644
index 0000000000000..712f70da64a55
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/lltc,ltc2972.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Octal Digital Power-supply monitor/supervisor/sequencer/margin controller.
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2972
+      - lltc,ltc2974
+      - lltc,ltc2975
+      - lltc,ltc2977
+      - lltc,ltc2978
+      - lltc,ltc2979
+      - lltc,ltc2980
+      - lltc,ltc3880
+      - lltc,ltc3882
+      - lltc,ltc3883
+      - lltc,ltc3884
+      - lltc,ltc3886
+      - lltc,ltc3887
+      - lltc,ltc3889
+      - lltc,ltc7880
+      - lltc,ltm2987
+      - lltc,ltm4664
+      - lltc,ltm4675
+      - lltc,ltm4676
+      - lltc,ltm4677
+      - lltc,ltm4678
+      - lltc,ltm4680
+      - lltc,ltm4686
+      - lltc,ltm4700
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller.
+      Valid names of regulators depend on number of supplies supported per device:
+      * ltc2972 vout0 - vout1
+      * ltc2974, ltc2975 : vout0 - vout3
+      * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
+      * ltc2978 : vout0 - vout7
+      * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
+      * ltc7880 : vout0 - vout1
+      * ltc3883 : vout0
+      * ltm4664 : vout0 - vout1
+      * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
+      * ltm4680, ltm4686 : vout0 - vout1
+      * ltm4700 : vout0 - vout1
+
+    patternProperties:
+      "^vout[0-7]$":
+        $ref: regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@5e {
+            compatible = "lltc,ltc2978";
+            reg = <0x5e>;
+
+            regulators {
+                vout0 {
+                     regulator-name = "FPGA-2.5V";
+                };
+                vout2 {
+                     regulator-name = "FPGA-1.5V";
+                };
+            };
+        };
+    };
+
-- 
2.34.1



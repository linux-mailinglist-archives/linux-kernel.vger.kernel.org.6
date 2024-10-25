Return-Path: <linux-kernel+bounces-382696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E39B1254
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBAB1F22807
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415DF21312B;
	Fri, 25 Oct 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzF0I7Ts"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7020C333;
	Fri, 25 Oct 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894114; cv=fail; b=t+Z/8pbr7hMFPxQdmiguWAZKqfOILzls598IRA8/x64Vqks1tnGKR/SAD4KTK5R4jIxP0loyGwnylnDRC8Yo+VbrjQI2AJ+wUyX291RVLjQP/xQXF3ZncbpBKMBvoEj3lzS1EwIHdN6Ur6+rVNb71agyfH/4wygxoC2frl8NVS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894114; c=relaxed/simple;
	bh=IaBfVKHvFNkoRveYoODhovdgctz8C9JBHlZTSkp5b04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZ2W8BXKxA+piWTHdlqPAXa0QSvX1uZZfCPRv2xILrDIfYzZqpyFusGVrxN18NjDz+ISMgL/QWiZtqfjuGWAX4cMuwt4yyYNx6i9w9pHwdAhZ//0FN+OgcvPyIXCOjfBLpGv4/fGUBwER5Rgiosh0INHl373V+LloKECwAHQsyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzF0I7Ts; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7/OZ7PfZJOTyqytfL/J2+Xpj0iVU2sLf5ao3td2aS5e/0vy0ixAXPTgMdIrErc36ui7rsq3IhuKNlIqh5khAFgEAu4q+o5QdpjQkfcmhYYjyb2SUgkafLbI6dNub573RGuyG9NF+6Q7RJhdFI2hvfjpUumUJTvHmmy7pfkwo55XaOSpJCYY8oEn56ZwjS+ayKla5z5Q41lWtlA1CvBiYJYiUlqfUaSSNj/Xp8nYDTafhzmY74VlzBUikMzT7ryIeK09mw7GOUd8GozfF7eJobMxaMoEvtXESajwKEL4z4KkFaUQ+OgbBbXasm6CozKGrL28mQTmzVMRxf6KYx7qXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxsqBDfyV7s3ctQ4sbQEHIBS6W7dmK2bnnofQrJ46GQ=;
 b=lOdJrFhOLWhVAP62nWCAdvwxwcx8qb1k+V5RaWisRm7S74wQ3kcvRQiyLEi8XkB53z7Sbip864KixF7kkAws7gvZ+h5q1FQ/UvP0IeD9IN0pIdRydX3pe3y9wH7bGiLVDHsPuFG6q4iTrDcz1r2HSV3+pVOyCB42i81AeOfJUzS5EkIb2zxBNZ+I/Og8Z221mxBtO//P6YFRAejmGs2RSfUjCcQ+1skMt2fmiVN+CuQ+cZe8xS4fpSFk9h/yt8RXpFYz3rGi7mmK2m5RuDp+XUAvL/SmN2L21XB/MCHMeYNQi/frh05PYncxsVwaVQS+KZYLT3/T5AkD++36cL7DIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxsqBDfyV7s3ctQ4sbQEHIBS6W7dmK2bnnofQrJ46GQ=;
 b=LzF0I7Tshsiq3m5vYSbwL9aOroHJebD5++st0uwQLLllRwi7lAf8zM1ce4z4CLH+bsWLmhHxtY7NTa4lhE1APMvYGQy0lSVw4DMvdD+OFMSZgn0Mr8RqUrhzqAEDpxtj9E0NgFb13bJd0tuO51BQJeDv7qMrImA7kKrpwz0c3JpSmfz/OlLmVWNUZEpgQq8iA3EQjhIMurg1PdgQw8IDjbTHbN64HalfLeJQSyEGVEh4s2AbLBegg1eu7QSraSZNCvV974IIu+DqheHzUsVEtMGxz3FB7Ika6lCxbDM46fCjCY7Q0X0fKs9+/gI+houI1wxKUy5ABiTQKcdoZIRC2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 22:08:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Fri, 25 Oct 2024
 22:08:30 +0000
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
Cc: imx@lists.linux.dev
Subject: [PATCH 2/3] arm64: dts: imx8qm-ss-hsio: fix interrupt-map indent under pci* nodes
Date: Fri, 25 Oct 2024 18:08:09 -0400
Message-Id: <20241025220810.1833819-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025220810.1833819-1-Frank.Li@nxp.com>
References: <20241025220810.1833819-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9d874b-66ed-41d3-e2ce-08dcf5418efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A6fc95UKHA/s8wA2NTp1eKwepP/uhWc4wp1hGaMbUp5J5sQlXbgDssnZxsT3?=
 =?us-ascii?Q?Dt84d5JmgYfHjdejFwgTnD+JUkSXiCLTDjnpl/qmsxcxSwbYY/lb9hY+EHzb?=
 =?us-ascii?Q?7HdDNlF7wPQMQOWlAmHwAxyV/4NNAhpd9tVBspivzMCpqqgZ0Or7A1oWoT9h?=
 =?us-ascii?Q?qeol7wlDEZmw+aniqpxdJ9MsiYAfVxz0Xo9H1Z/KTatBgsKfW2FyBENERyWz?=
 =?us-ascii?Q?rJnqHauE1FcC2VSsYVjDmOXyHgm5zVX2vYJ1v1EdP1hqarT9uvZGnvG7pQT2?=
 =?us-ascii?Q?PsF5FfwWXGueb6h+UwhkUCo+aj8xWCvmkx1E5mPS/3i5dB9SxS2+ZvZD8a4d?=
 =?us-ascii?Q?YM216NpojS82y8NzM0fe7B58eu25RWG0dX2YqjFzQDv4d0aNeQyiH8V4fgTY?=
 =?us-ascii?Q?Jh/XzSc4OrV9lsAo47BlwtAg7FrDmAqekeVfxoAbxxOlOakTF21rsQIXmiWI?=
 =?us-ascii?Q?r4kUNA5mCL6aW2r1HI1kzy1TcXhcb5n6pqzz1Zf1PMjGyRyVoc8myRTfE2nZ?=
 =?us-ascii?Q?AMWvr86A1h5cAw+U26PeJHKOeRVUbPCtWlLIcKgawYrHA2SSq+9RmNGIvU81?=
 =?us-ascii?Q?M886yJ+GG1b90LW4Mh5duKiIomMEZ/125XhVtUD3Ekp+cPgDJH+5Kfm2QHL1?=
 =?us-ascii?Q?/wS8MS7u+tEaj5ltYFMVOw5mtXbCiu5lgzLiM3U5J2waZk9qZxr3Q+pqgTjN?=
 =?us-ascii?Q?uGkr6CPTfGHAnffNgmi0iyt2EV41d02QlK3HnPaSFfU8WDTnGVq2fXI5Up+2?=
 =?us-ascii?Q?8ovnLQUhX8AqJbjSSu9AKifg1cBtyEVPxhOwue6laCKEZ1q02n26aJOBLtoV?=
 =?us-ascii?Q?bD/zFOiNNaSDEOSvGk5luepa+/+CcSyG6e06DeDV3qdKlZnhpQ7uUIfKjGf/?=
 =?us-ascii?Q?V/DFg3Kjzl9Pbq7U6WSkVVybGjk0+FF7E7WDuR96lqKcluBJ1fOvU8/CN1rD?=
 =?us-ascii?Q?7YaLU8oWc0Y33PE9X/BXBeJvdAEJ/G7P//jq08oUnCkS/zZ0ahWq7hCMmtc7?=
 =?us-ascii?Q?3wlXPCoHLlEYzo+UjEnU783jEyXWtQJsCP3Z4dsCB2COCeOzIA1LP7tKBoQn?=
 =?us-ascii?Q?Hv2ZGCLACpWj6iFz9m4HIkmRnpRlmy1/imdT0IT4iZAwGfv3NN9s0BqR8/pD?=
 =?us-ascii?Q?cOrwhoeHnsoN5GKBmYjzjLxbqp+ivSInbhhclEfbdUDX6U3+y6kPXnFthP2O?=
 =?us-ascii?Q?ZpY9zRxKH0GtiQnUSXaENmEcPjULTZbFT8UgN/ngs2oe2R0EjCn9ANojipKD?=
 =?us-ascii?Q?9QhIg4V9ut1KNphYJ5up8IYngHsLOEJ1CW63TeN8A6ZO4ehEi+5B0y13IvX3?=
 =?us-ascii?Q?XjlVak3USA8aJuwNFwTbRixR306T966pSw/Xgnd9Dg3kUGOAVBLhAfhUN0Qb?=
 =?us-ascii?Q?0Jm742l90+jYaUfdynNzrTdoKa1a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQYKx9KLhsgNRfj0ec25CdHqTJEDBDsnUSMxLvPPRNFTptfUcQ2EJj8DE4kR?=
 =?us-ascii?Q?UFec4VhtEnWrE4miDYTCg1HwRGDDv7QZPM1rohPvZ1pbRztJ7UrAkp/wkWWY?=
 =?us-ascii?Q?/8LbMBvR8n47/CoPYeF4lfZFIRFPc8qJee1zZAQGzS1bGmwulR2YXU+pyOV4?=
 =?us-ascii?Q?Awal7VxhfsgfI3xXasOfh9Irx6NIKi/w2O9c0FBHkrsvBvAHcdBoIXEnYNaq?=
 =?us-ascii?Q?7VbaxXTI5Uz+2tQu4hO0ac95b51a5D9/hZ/dNOP0ySMw717CduZXA1guW1sP?=
 =?us-ascii?Q?qZ45vQ6UWEXboxwDO9HMTfsxRJihsKzJ71GeKVEe4mLPlHi8pJwuHyuG2q65?=
 =?us-ascii?Q?Hv/q9qxSKtnd2mS7UKwb3EJ9b6tba6Y0Oks2iQxB8UXbp7F+3wQVnjGT0wRV?=
 =?us-ascii?Q?5ekAHahJtCoIhaRihNeqBO2B143a3CxAV8x4tW5LC/LosYicly+wmcBhcZYY?=
 =?us-ascii?Q?i9/btWJrVvp0/oyLva1pRtx+y5yjooDt1vTSvgFIIKo1TeRdVBiJVsaANi/M?=
 =?us-ascii?Q?BzMdfy0U9mOjuQYK28KkDW0/Ui5Oa42BkXVj9euvufGMw2qM5V3eUiG74HcY?=
 =?us-ascii?Q?7S5CjBgH574L0XYoZunxgyvuZvuAjEapwrL9Ipw0NUY57ZPy5iy1RXtEFOVy?=
 =?us-ascii?Q?V/BPmiAX8koDB7MLJ2+sg0qDnqaPV6jJOD83uBpDbq9Ue53ORXf9IApiDecd?=
 =?us-ascii?Q?Ta0+YHLJRA/LzRHnM/Qwn+qOdgDuQW1MJfdh2lJRVd1boQN7atEVjZra4KLE?=
 =?us-ascii?Q?r2CkmwHDpiQ/fEgDijrc66dal+OY5Wc8Yd6HPXZgwEVt8PoIzfSt7lJxdQbs?=
 =?us-ascii?Q?SgWvfgqnBO+SW+d5lJpnk502VV8Wv3XEKMNu/3/zZWw818Oio+v1FNCYHWT/?=
 =?us-ascii?Q?PfOFw1YL2c5PT6Ja7T0YK/ce5somBBv4JScPweU7SVhrRn7MqOgEeAvhLybW?=
 =?us-ascii?Q?VlZoV1nVTTNCYQEsDSzSrVA830Ix2ET/aPcKtdhfQ2GxudssvGVlloqSaLON?=
 =?us-ascii?Q?bthej1xiZH4AbP7vN1pIOuaRzQovGL8rKAGq6w394aKhPHYoDbRTvIWrsRRt?=
 =?us-ascii?Q?RcrFPwYU3kIbo431elSol9o3GUueRs4tgx5Nr/z/3ZpMSTo448HsdNtBplB2?=
 =?us-ascii?Q?GcxsCX76EIELq8/rtY5gCD/wz8tTPendFocHlYhLuXShqMe/fHT9Q8+/dLmg?=
 =?us-ascii?Q?G6gVNbLgRYZRTH7uZBTwahstlyiaFOgpMlry+62livFcCa4qzo3rm29DMGaU?=
 =?us-ascii?Q?+ScuFmDrbBC7DNGypMWTLgZrqKiK11UPIYYgkzGazQpevEZdSv5N0zaN8481?=
 =?us-ascii?Q?BWRAfEpDQqeL1KyugRvG+72EE/eaj8YySE8mWhi392jjIiMiZXWQgvOwS7uu?=
 =?us-ascii?Q?zM4OxAI18lEGCq6OBB+dZ3NVbaQNOYPZU0chh+5huw2c6R0fi4OVO+LFrXKe?=
 =?us-ascii?Q?gqpCiu6r/oSY0Deq0fyZUunNNbKdyNVI9nZTBcKG/3Kh6oDUN7mFVoPjvFaN?=
 =?us-ascii?Q?vqu6mjCFW9M7FnksmEUwRq0nBZssAULGG+55lgqdYJwLIyb38FfL3iBLx99O?=
 =?us-ascii?Q?HZoLVKZzH8yTd+xGynVWjqa1Cz/If8oB1HzFu3i5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9d874b-66ed-41d3-e2ce-08dcf5418efb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:08:30.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQUD4qsWLlYXjnRbtL3LQJLi/luZmg1sk0S2fhVkEARlKgO0pOdUc2dczoE2p5toP2HmqQVxtzmpW6whDKXM0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

Fix interrupt-map indent under pci* nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Shawn:
	Sorry for that, you can squashed to previous patch if you like.
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index d24d90955c35a..59b6a670462c7 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -31,9 +31,9 @@ pciea: pcie@5f000000 {
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
 		interrupt-map = <0 0 0 1 &gic 0 73 4>,
-				 <0 0 0 2 &gic 0 74 4>,
-				 <0 0 0 3 &gic 0 75 4>,
-				 <0 0 0 4 &gic 0 76 4>;
+				<0 0 0 2 &gic 0 74 4>,
+				<0 0 0 3 &gic 0 75 4>,
+				<0 0 0 4 &gic 0 76 4>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		num-lanes = <1>;
 		num-viewport = <4>;
@@ -61,9 +61,9 @@ pcieb: pcie@5f010000 {
 		bus-range = <0x00 0xff>;
 		device_type = "pci";
 		interrupt-map = <0 0 0 1 &gic 0 105 4>,
-				 <0 0 0 2 &gic 0 106 4>,
-				 <0 0 0 3 &gic 0 107 4>,
-				 <0 0 0 4 &gic 0 108 4>;
+				<0 0 0 2 &gic 0 106 4>,
+				<0 0 0 3 &gic 0 107 4>,
+				<0 0 0 4 &gic 0 108 4>;
 		interrupt-map-mask = <0 0 0 0x7>;
 		num-lanes = <1>;
 		num-viewport = <4>;
-- 
2.34.1



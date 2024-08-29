Return-Path: <linux-kernel+bounces-305999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBF9637D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E211F21218
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825E4503A;
	Thu, 29 Aug 2024 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WhGCkHl9"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599A446A2;
	Thu, 29 Aug 2024 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895229; cv=fail; b=MObVfZyncgXZvfG0S2AIVljbI4VmMRvWdStsDAH9mXBLXJ1ru95aplVNYI8a9kXdpv3+kfnUlcTpPKJTMKCk/B1q5cAI+WFitBGUFRGxzxB7+5f+6N3NmmeihDYNntVTyVzIqDfFJZinC5i0GrB3pYF6z+FGYFWYg4PDX+eNUEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895229; c=relaxed/simple;
	bh=ByQBaFXuKlA2cZp/b8V1MLx3zi1eiQ36+9EDPnjxaFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvLWcpIcxFa1XUjJEo/Df0HVf8xSAgS2UYzTBVof1Nrw2qBQbHCSlhh7ESNtSAcddRpJx9WJOUJ4x3R4yF13Wz9YcBbgFbU060RmGrWMhJZthOb6pBr/PDkrODr0h+zi6eNMNuu+yV8OYOt2z2pgHKSii4xwzsIR8KFyj7aTg2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WhGCkHl9; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQMevFbj25V7FhAyIEVc1/b6VRzic/Ds4u6X9YCikK4YwF5d5SRonFRreReTJ4p9cKgEGeHOAoMNx3fO4y04/xwD5mg48L8KW1pKCaK5gGGATmS8h+M4GaSXDAGjV0ZqnPdiZwckWgr57TECcl+iBpn/tTPDqESOZEjcqx5lsgSvCmVNfT8Tvoa78kZCeoUgmUSJYZPySJ34UaFPGKwY88q3L6JqnbiWX9S3WisVH1wvXYpEFCMpt0kuZ5pDpRpBhoUGpCJaFh25EC30MnIujQtEX47R9I/yKFdOgsby5siyWkva7Q0k6jKgDfqpd28lVQ/cf72QLjN1NOQhHDvjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmAkqxyuI0LQ1sro+sSuZvT1NiteNKtlXCQNcy5rhAM=;
 b=eWHH5jIGkEan7ESIFj8PLngeMIfDZcyAztJyFOcK1GSPoPZNtFDR7UFJNFfsW86aXLxfxePhXNf6v+Jd5bEyeM59NRBXNn9qS+Z6FC0p1+ByIhLneuTkr/9EJAe3b8Ra4uFw9Rth7C2cMDgzWBYiIwtx40r5sOit8QMfFjOz3uRIYr8KM6KgCSJyMJmu9U22NLLHQJ5NlxEBt7jv8MxGAtDwccKqevBUCWX9xed963KO5dI0U1QRFLFxEyZw/X1GD0gEqDTsRHqt91TW/DVdhLeEZ1ky9eeh49u9B7DjYSezO4vUrQTRik+o4oz9bptykoQjlJRsXZsbAl/b440O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmAkqxyuI0LQ1sro+sSuZvT1NiteNKtlXCQNcy5rhAM=;
 b=WhGCkHl9hhyIi21bVHB6CVwRZ/mFVdNcjVqaVFrmkViT0YqJPcLriNU8oGdQPoYUq3orwfV9ViFcJCzMllweLKo6eLyQLyaFZSEB4dJHGcY/FWlUVeYR+CWeucYaKkeHRW1Z879hUbyPJE3NXic0plcKPfYpbKMszOd5D6rYDESs3QdbPLh0nAXXauq8pHH3b6PM6vfQGsgTZgFPgjuepwU5v/6skEVuaDNKIlDjrqpEz6cSy87TzLCh9TSCVmyq+K7qEWqfx7XH4jq+IqAUwQidkGXaDSSaYfEH5V1AT4soLcKB8w4UuYA18Rqi7IMgACaS3Bx4T3Wd7pwsoCa/cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 01:33:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:33:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v3 4/4] arm64: dts: imx95: Add NETCMIX block control support
Date: Thu, 29 Aug 2024 09:18:49 +0800
Message-Id: <20240829011849.364987-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829011849.364987-1-wei.fang@nxp.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3b8426-cb13-4a11-7050-08dcc7ca9e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xgFO5b2DtbZm3WlcF20dPiiOveagbwUXnax0/heSs7RzW5duaFaaNM1cdqmU?=
 =?us-ascii?Q?6IVceabw3I2ClHnUXT/w1OqCqx5/GW6bU4Ujlk2bAjlfHjM2/8deHigUxcYC?=
 =?us-ascii?Q?nzKP80k9m2Y5VnPb/EVuczhWpOxLgvZDZ6poBtYloXCpsIyBBfvTuMjtqtCW?=
 =?us-ascii?Q?7vExbgnkKvW7Vz28N3tfQlIliMwEyHbnCSg+P6WkprichkP5jOEwz9RKGGom?=
 =?us-ascii?Q?pYdb6wjCzwRqbx7tpEj4s+UXPWLTcgAJBsnLIk7y+vk86fjPSZ+q3K0IVp+K?=
 =?us-ascii?Q?5yTQIDW4El1H2nWVUS81mozd8IAc/Hm5urQcsehhEh6AAVmyXZlkB/QXEYxU?=
 =?us-ascii?Q?Ihulanq0dksjYk8y966S7rqFzm0vsL1jj8V672mZ7HByBhywyXFstKOelBus?=
 =?us-ascii?Q?8aDsm5cdGxfpzd4uCXimqlFg6PaOv1G0D04ykeFjcl2jSfVwOSUh61MNUvYO?=
 =?us-ascii?Q?e+q45p9YO1459yS3tfMxr+qsTQEW8kaFvzeQjMvDLfbWUmQlui+MxCXyUc8x?=
 =?us-ascii?Q?FS0+r9/sAJj6DxBKKv7eiL8K72hDm7/alFkkE1lD9XKxuyh2QbGySW2OJ5zV?=
 =?us-ascii?Q?5y7gKMCtVqqAZmiw81n4Q2sCzNamz/o55gEFscAHblksXCbir2yU/eSLhQ45?=
 =?us-ascii?Q?PK2l2BAB07xQLnFz4wa+jU4wiENE1JKYKBy4GlRO3nBnulFKn/+foRA4GYRg?=
 =?us-ascii?Q?48yKn/wYY11eHJjZiSKrl3Nlp3oyrkezBguv5ibfmMKIZcgNKWGgwXOsOSUe?=
 =?us-ascii?Q?/ESmZCw/b9xQhwTJq+8OsxzwbKrjxMX8Q20upkISF+hN+zG+/sXIIJKi93WD?=
 =?us-ascii?Q?PLwsP80u6eZN5hQkDJKMeVNitZu4Rlj6LIIcXkZdfQDCSO+5FOIBl4FmnS5b?=
 =?us-ascii?Q?LL1tSWK9IQR0T7/7OHqSg/QISf14RRmVf3PJ/7m8NlAlU8wyMjDxw5GAlxyw?=
 =?us-ascii?Q?AtklGHBgI3DmnJyDsUrZ9R49wHyeXgksoUdcBNV30ermzSBrdm5+hArcO8Os?=
 =?us-ascii?Q?MMXwEOzyxer2j+OTZwSb7nx8ux+bzbgcoxcCBQwhNnQMhcpCk4ph0ou4U7dr?=
 =?us-ascii?Q?PUT2LBh4QALHJUU4rqQoycGwyfT6QAi9kZacM/T6oVoGYmEkN0h3g7em38UE?=
 =?us-ascii?Q?cqj+LYfe7/YmNg7beF2PHs4/1GlnXNYAl3b2vu0GqoM2Bo1omifVbf6xje6r?=
 =?us-ascii?Q?E3nza3VZc1eFLA54FQXJigaOvSbKKwTdFeZ/NSotX4O3Mtw4gQmYkgIF7rzA?=
 =?us-ascii?Q?SywAVn8aflhlMri6EuZwJvENaZku1gRRTMYm6OguSOZLkPs3jFwDIh8yTaKS?=
 =?us-ascii?Q?lDZZtr0WLMNXt1laweIJI3EoDWxZsRZjLcrop/Wlngjgt1dLt0G2kNZhfE+1?=
 =?us-ascii?Q?N+XpXnT8V8cjRu4gBzCU/Z41COeDS153VBlY4ZXtJalT6tyJEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvBPOaIT74ktOF3csrFrNkbK/mv13mXmMZvfBWk2Ax6E0M0Qq6c4iPo0pMfp?=
 =?us-ascii?Q?O5xIFKZc0uE5eJgmq6Bu8CkBln8qO0znlRxuRXId1JlM2lCIc3hWMrnZgw+9?=
 =?us-ascii?Q?GiEycJHwm0A4hr8VfuRCVU4bz9JWz7Gk6nYoVFm1p8mvpIKTT6OIBqkco7uB?=
 =?us-ascii?Q?ZXXl6cRIyp9NvuWfacJljEfa3iedWGWf0B2jHyyjGXKhUXiQPOweNK9fUen3?=
 =?us-ascii?Q?SwpJM7/WwDDA0gFLUfHT1Yb8W86VXpilbn5IazGu6jMaklAGabsxZxmumdvm?=
 =?us-ascii?Q?ro/4q34fhn5Xzn8JMPEVOp8o1I2YXOLZlecJX9DKEOQvUHkwn+YHh2KjMXYx?=
 =?us-ascii?Q?sk0Jnx32c2z9v4zU3I4RyHBBI3fBySJRhehi9NpfmUhXY6SnkDJRDcptCDii?=
 =?us-ascii?Q?HrPDAqqsi3JP2cR1rIWSYaPe3VUrmUc3QIA/Pxys8SACuOBT/7G1fKQqbPD6?=
 =?us-ascii?Q?0dihJImg+05Bb32YFygDQVwqtLU8DVLgn1/IsJmVPER2aWZyjm0/+SoNc+rW?=
 =?us-ascii?Q?wiaMJNCvhe9t+t9zluPFHDX/YCYG97MaPf4WrbJAJoj4v52tZHFi9SeZzRhr?=
 =?us-ascii?Q?pmOYmTNdttO5oa9uLG944G78NkAXC2CRVa/OwU2dgI8tqTbs2nEyyOaK9LiB?=
 =?us-ascii?Q?Xh6ltm3Hgu0irlaytzFvW8llO3hxdU/JNqjEqiCnDFKSuZ/hidDQPUR5mAbu?=
 =?us-ascii?Q?PFvS1FUJRk+XA2iGdkdtbpMsEyXIPkUnTVrvlX51LOw/RUKyXHEQQqu0vuo0?=
 =?us-ascii?Q?MWxRKTlCtlLvrqPQJatvpWJSBBrhePlb3XQQkdC4lTvXHGEzPx5rcrhXLf39?=
 =?us-ascii?Q?TPk8UNrFHuFlKJiehx8VJeZSvw/MFftLut77/HuTDwVylQSYhbRmToH68L98?=
 =?us-ascii?Q?khb4ur/+klE5eclOOFJHLK+RNRXRJpSFIECiFCG0tXz2XMkWXrPtxdPu/CHt?=
 =?us-ascii?Q?9x59ZHDVU7HijVUjXcFcr1XbBPUcBJggkNpiX1hKRDWHANglato3I7XuGUIY?=
 =?us-ascii?Q?m88paYOGXUOK+hwfx/LCleRvNZt9T+1CCd95AZXnird0XGyxvWkXV2QwVxmF?=
 =?us-ascii?Q?SrkIFhQ9GNQVbgYHSA7P/RhLKKjdspJJqfVe7cGgbRyDb74RFsa1mZYS8zRW?=
 =?us-ascii?Q?oZSMX5ukDuepB3CSZVPK4m4/cENRAiMb6aHKMfUNiKIUUiUcraG0B5NIjq4X?=
 =?us-ascii?Q?vB6fI76EbH+8P8FJo46XdMOWTw1FNECKNYfidew7C44SsZTqlskXPcFaqpq4?=
 =?us-ascii?Q?PxOH8xKjThX5zkZPopQWj8OgUmW/s8TctZvSPuJsyyeZ8WneGfOrgm5/bfHV?=
 =?us-ascii?Q?zd3nt3uao4EUcKKkl8mjcKZPbNqxroJSHSVKDBwfR1kAWbbFmu/8NepcG434?=
 =?us-ascii?Q?T0Y7Hzm1vUk3kSDsrU+7zSXKN3ZvbcECkTt1OdXQrFFEYmijS045hQpSJvpL?=
 =?us-ascii?Q?OLq81Gs/uP159GaTDRAGEfNfJAemRzJ9pMm2weQsEPjXfIgccJhF/JJ3p1HV?=
 =?us-ascii?Q?5h91dE+pVpkm3x2zlCoDhknjMJBO+CUS9SowDeYBVXoPc+3X0wTDmfpHa07m?=
 =?us-ascii?Q?vFFpWEWO/zi7JkXFZrIh0Vax8+uGEuS2EE9YFlA1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b8426-cb13-4a11-7050-08dcc7ca9e7a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:33:43.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cSWiLsThWOIhn9L24LDvv44Kk6X45cBtGlO36I4JXuteuQ41vw14kEgkOr5ENCoV5HPz3XiyiYTSOQJBU+YHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924

Add NETCMIX block control support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V3 no changes
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ecdc6b7b5129..03661e76550f 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1607,6 +1607,18 @@ pcie1_ep: pcie-ep@4c380000 {
 			status = "disabled";
 		};
 
+		netcmix_blk_ctrl: syscon@4c810000 {
+			compatible = "nxp,imx95-netcmix-blk-ctrl", "syscon";
+			reg = <0x0 0x4c810000 0x0 0x10000>;
+			#clock-cells = <1>;
+			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <133333333>;
+			power-domains = <&scmi_devpd IMX95_PD_NETC>;
+			status = "disabled";
+		};
+
 		sai2: sai@4c880000 {
 			compatible = "fsl,imx95-sai";
 			reg = <0x0 0x4c880000 0x0 0x10000>;
-- 
2.34.1



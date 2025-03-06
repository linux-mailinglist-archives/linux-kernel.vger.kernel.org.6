Return-Path: <linux-kernel+bounces-549998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B0CA559B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E859F177E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945127E1A8;
	Thu,  6 Mar 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHljGvJe"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB027D77A;
	Thu,  6 Mar 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299862; cv=fail; b=DygwyCMbA8g3tlx5i9NSAyTjHOFkz8fnyG9smPF/E+kz8nLvTT6mYUVAnnh87viaKv/db/2wpRLww3mWCc5Gr6nowx43gkx5dY24u246MvMxBEXuvsXILJYZigvpKe0xGITOjW5jVSsH38DLV/k+/s2SymQ/5HavhiPwxh66YM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299862; c=relaxed/simple;
	bh=3ggWWNqnYQFDOaR39FICOz577wj9kotWnLsXUz+XTAc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rmcpC4WRjBvOFTMW8q3Qie3pFfGQ5FxvBk/Z4P6U6FB1U8LkvjeLWiLOblY1hGHspo2rmHujDFvz/LZgWAzS7Sdd2uM/t219LBDbYYvDd7zHgXxIJ8QpKrBgn2FxmsQWAgrZvrXnCiGDbvCdXTTyvsY7q3iFlELUjgG/FlqaF2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SHljGvJe; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ9kwMhQjp0uMY+qAKGkc6JQ/t3LnbCgn1vHSi5sr4mkfigU0eD+9tawn6e7XHflVLPBmN7ii7d51NhIJI23gQXQ5/pLcwroYZian/EIDkVcS6xBadOaYShNjw3pgyIZaI8btQaW0iD64bWfniDsNyj/jubPEhSNZYIoSh+XhpCE3mbiWVi+JMIIc2ivjxX4pS+JFTuBgsDLLhg7vCQafWHo+I+5cjRgV1ta9LkiDz6sJ7GdAyffuoveZzbIKlHPORDLNouDiUjsfMrjvG+FLstGfT02iXGdlrqy6HHAfp8R8tyKjtmay3UcSNTXoFHvoPdAC0IiBsMTGD2SdXYF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcvvBdkl+BW8KBssMvpUcKOdXfsESNjAxscOyKlOdR0=;
 b=g1kCkNuH0Nkej43AAkdj2D7+pADDV1qKdPumCLQ/+LmFkeuxt3eOu7x76C1dubJHnXVObk3vsc5Mvtal70pcRctErp1kPQU3nFbQ9RllA2IFAy6xAQEoURw7EIB8SwPAY2aWKh9oMSWaTjMSMm9swVIWdyFT4nHfquUYrk8SxOVoe/2387+OSIWHUO3l1YAH5laWOCLQpSIOH3DruJi7IGtbTEMSHI1ME8XmhGhcP1hE7o2EA4XSHAamwMm5S+dXBDXAxTeyYd/4XcwIp6eejKVwSIVzO8VhNiKNiFufmBSqiO+gxWlW+8Qb2Ac+ObfxACzhIWQ2atoD0P+qMddoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcvvBdkl+BW8KBssMvpUcKOdXfsESNjAxscOyKlOdR0=;
 b=SHljGvJeTobcX18ITR+Sq+QSqZ/weixk8kjNSJ8kcDQBEQ2eosMVi865gprsIHKF9CAlppjhjUSoMOITZaZwYL9uSQ7g8w0tvEolkYHERv4BIcY+HbfYC5CLm1qjsgiVpTii/b8gk1zj6hXqU+Wge5FAMh4FgozmqvSqsejnOrQC5yZfN0cMdiNRbzddQ+kCCGbr0in4OC0qvg28PY5i6YzS59/ZheumkLcAVgw+JghZ8OqBYjlk2bPmzRkzoX0BzylXO9exSChMjKr+ms5TN9WdfAuse6lVQWQzO2e8s1iIEqvu5iy2GKRmLs4694ZvN+TpkMss5ehvRGZ28SgMFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 22:24:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:24:15 +0000
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
Subject: [PATCH] ARM64: dts: imx8mp-evk: add ecspi2 support
Date: Thu,  6 Mar 2025 17:23:58 -0500
Message-Id: <20250306222359.797855-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e5f9d6-3c80-40d4-9a9b-08dd5cfda0de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5EgMtNK9qR2DQFgZoo6jqLLcRiWWGGBbLZESd3uCal/01QoZfZR6ow6zxWIg?=
 =?us-ascii?Q?D1giPpBsvpDjpXc/hH1+DAUFSh/IOKEat+7SWaKjq7bPdCYTzQfF7gH30MSN?=
 =?us-ascii?Q?lYMBeb0dMov2LVfX1NNy97597Dr9RsVEeEPvsisEweho8dFXdYLqMIzKftG6?=
 =?us-ascii?Q?olNnZeKNWCAdgiT6von+EKbh11LCTsyBT3NxnbpV1lHz+o9b2Qevzu6s8jPi?=
 =?us-ascii?Q?gdLBxeCti6VBFznHAOVJ0r7TAx478KJIwBqxMjYMIaOnWvXYBmjVbrHpElHo?=
 =?us-ascii?Q?wJQTnjO9Z9It/1C+eOrIQSM+GO+lWt7U8e4d3T59DqFZ0obFimGgrs8R6Rdb?=
 =?us-ascii?Q?hi4QW/6bFJEJ2dBzzoNZjc09bO2s2OqXe2/K4E17H/TsJMqxgyDdmk+cnR1G?=
 =?us-ascii?Q?Z48//KGQ73131r73aMLRUYKq3kkuJQFs73LtkhCeBchUhtTVXJPVuXmWyQdU?=
 =?us-ascii?Q?I6xWX6VqDdf49DkslIfrSNl8BFWWJ2/sB8gYIKItFubBRtc4Siso3P5nUsRS?=
 =?us-ascii?Q?upeRq1aDb4nr8Q+49nNvk6SZ85uyDHY+U0GCDVJiT6Dc6z1Gwws7tKHsqSRU?=
 =?us-ascii?Q?O4jfRODFgon0sDuM0QGTGuHBIR0qIhIZbrnV9w7aC8A5HFqTBZ6JJkZrf1tL?=
 =?us-ascii?Q?v1iCBkwurpHow27dZF+ACIfg8AsNVLP5uivbfpV0lWY7+exw5pHT4Hhu6vnl?=
 =?us-ascii?Q?EVBiY5XAj34ekr3oxltwI4AAsxSl6VSWaNbKFEazqKM4LZS3Tko+NYVJWj6p?=
 =?us-ascii?Q?XnXSX77zmCrVoQ4tE7zwIGHCb3aGbauL88q1CEen0yDHOEuxiLNpaOYqPfBZ?=
 =?us-ascii?Q?HBNkCEgOS1QJCfy2Ax3LynsVlDxN4sF+CzZEP/h9PPae8yzC1vL/4VYBjCN9?=
 =?us-ascii?Q?d8HzWALyPrtVy5jJguEk9+NSh9nXb+VxhKyQ6RdNDLLmYUVlH7RBsKOnqclg?=
 =?us-ascii?Q?A7riD4LrbALloYWsXtYCzDAYe7suLUQl5X8fjC8zVKaVRNZypPPgHz6DoKEI?=
 =?us-ascii?Q?SykmvK9lonrcQDu67QIxdaJhI96U5+x9wbmONeEctNEG7DF+gC1DIIN7FkkI?=
 =?us-ascii?Q?M4fm75sPy8Bc5ZQpodnQDUEqV1+IukWvwlI3tdXrmzhHg5VLo2K0JwUFxalh?=
 =?us-ascii?Q?5D3riCDkJhZVCUru/bz2k8PSm8Lm21GaKBokWuZfLuY7xufT26OfNrYX/lR8?=
 =?us-ascii?Q?9cE5pIOnFVzgowQ7yyOEqBCjEWSUyKElF4vf/5koUJxa0JySI2u6BzUWsnWe?=
 =?us-ascii?Q?PGMcbcPE7oDuQcHFARFgzlmD3m5u5fef+I4w3p18zSRhLqk0Z7SNZhc0fmbE?=
 =?us-ascii?Q?G8cic+lOhAqHXLNYYgo1StiKp9xUfoEOo2y5rirym2H3cLKaOIEB+tKZIEjc?=
 =?us-ascii?Q?qV6FBGrhCOtSvwI4ZPXR0g6fHEKSR4WT6pyn2zjP5Q7m31kI9PAPzqJpxism?=
 =?us-ascii?Q?nfpWOhxI5LMkpBvnVtOZCsFfmZhAhPs9Dpux0jOI0WtcWcMuy8J4Uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vBYR4ZMFiMvieum1Y9ImIi2VD7PmUZpmfo00i2b1NvDBilsjeEO8HRcrzfXt?=
 =?us-ascii?Q?SPiuBWvSTfewz4xQSlKURiM8jmsQu3cMPzGQIQ7lUzPBkkge8AazckHn7heY?=
 =?us-ascii?Q?gTmiTKpUW99JNMu1v9pR+l3gPsQnipPg0/MyjzdUM0/TT3icfSUZcq6fg7Sw?=
 =?us-ascii?Q?dUKo05IBbBDKxuNkpcL3QvRcR5iVV4APYDWz97DuS6b+VlHe4c9f4keesSXy?=
 =?us-ascii?Q?bFe/vglhTy2Ft2Alt1T84CIO3A4UPyg9KhoZ0/fhJL5nQdVv566neRPB/Bxf?=
 =?us-ascii?Q?zg8fhnxrElziw/SLnZmXncEvHv6SX2Oowaz7CJrDailSVpuYJ2y4iYOSnhlb?=
 =?us-ascii?Q?NwH5I7R0Cy5LRMN9bE2Ui35DALNOksF+FPINa73BBSpKvP7q183XUVY3inDm?=
 =?us-ascii?Q?oK/sHApiLYJFRrKV19fV7B0kzblqwjC0bT69pT4ZRR1G+oTMa04mcpPhM5oY?=
 =?us-ascii?Q?ey1SE+SxWKH44EzdL+1O8ZhQf352n0vJ8N6EwRHz5B1cO5sohBKF5tzflodQ?=
 =?us-ascii?Q?Ho/Xrn6AXkSOcR5y6rECw2gdP2oZ2qfGi6Sw1tW2foxwV8lbIcijyA2NvlRK?=
 =?us-ascii?Q?VMrMbQBRQNhp46d5Oa9S3f/4bfM4JfucSfXg8RlXmWx5qUv+C384/iY5qlvJ?=
 =?us-ascii?Q?4qgghyKmn5IkGQTTrYOmmLDmnoeuPp1DcUDzLGwHuavC7WExxiynCFXisPFc?=
 =?us-ascii?Q?WgrfQIVkWxBWwZ8G/X0Zat3uGBpHOGJe4PmOqv0b6FL7j67aT9hd5tOuFDsV?=
 =?us-ascii?Q?x2U/qd16xqixpDSPGmEkE1PWrmYdRcbITRYvXREA51SPkV2Swi4KUPnq4PTn?=
 =?us-ascii?Q?WcLMVbxUGOWihsvT63hkaXlWkpnSN7i6VSatwS15NdPIkgPAl2pRySJeYP2h?=
 =?us-ascii?Q?HVHToS8lnslsyl1p7fdZcuETDu9FR8QBsdt2ibGiGu4FuQV9wgLUSICrX06H?=
 =?us-ascii?Q?DhMoFAzB8S9J4RMrIA0xVFdSOqwJ8QpiXim2WJoChL9ohBoeA26Rb0JiNAmR?=
 =?us-ascii?Q?pZOnPY7YPzfDicjkJ0BheGZksvQi4tWnteIs1TgMs96Qb757+IbEl3qiPEfy?=
 =?us-ascii?Q?kaTMKoV0+LVenAttLoKtkoVYO7y0xq40fzV5KuNpGYKYA4YOiqh2kM8bKS/e?=
 =?us-ascii?Q?RYf3Q1a2sRJ2fPnujGBlZysczPvv7UZRNcLZyhW23wKKX7CliiGmBrl3Ygsh?=
 =?us-ascii?Q?DNqTQq6gCaA3KidFD/LR5HYY5zPHiV4dwN5KGV7VSHpFgdryG4S/uOEp+c5g?=
 =?us-ascii?Q?XZH0dRkE/4wsR0uz73OcYAT0WO93mzshNDWCeOcq3AUdcgVkDkN9ACpi/A+J?=
 =?us-ascii?Q?IRIQUXNyecbZOLdJGfGxTrnspsePyE3eYv7ZZ21hDgzW9yVkulaYEIgSOzd/?=
 =?us-ascii?Q?/j+F6P5hesOkYET09S6kgljY8de6S1WyYZQ+WGQmLKKbC7x9mfN4TbgYbUmO?=
 =?us-ascii?Q?5JHwA47+4ru0s71C4BUPVI1ysWLyZWssZ/6/7SogUIVIXPY+EpI3Uko36zAP?=
 =?us-ascii?Q?g8rDidqDjj2jkBiJ9MOBHIzkBDwG07ihFXA6PSbgYyVWUfrSvPZUxNJqIAl0?=
 =?us-ascii?Q?zCEJEay/cTtmi1Uyqw+kHuCHbGbvzvfC+mfk54IY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e5f9d6-3c80-40d4-9a9b-08dd5cfda0de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:24:15.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eI8XYMVeUdHg4E935VJozi2K4aUnyrVYpRTuVyIWOiBMt4vMIyFas1VVj+PzLr2xmaHhM+Lk5DDML2+xM3w5ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

From: Clark Wang <xiaoning.wang@nxp.com>

Add ecspi2 node to support ECSPI on i.MX8MP EVK board.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index c26954e5a6056..566fcf6aa5ef6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -309,6 +309,22 @@ &aud2htx {
 	status = "okay";
 };
 
+&ecspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	spidev1: spi@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -835,6 +851,20 @@ MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29		0xd6
 		>;
 	};
 
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
+		>;
+	};
+
+	pinctrl_ecspi2_cs: ecspi2csgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13		0x40000
+		>;
+	};
+
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-- 
2.34.1



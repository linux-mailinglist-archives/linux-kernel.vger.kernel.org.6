Return-Path: <linux-kernel+bounces-374993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18649A72E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFBB28345C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580D1FBC97;
	Mon, 21 Oct 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hVjUxqP5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230691FB3D2;
	Mon, 21 Oct 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537587; cv=fail; b=UBDGD+zJDZZqwb/UgMgwSyP325vujDQXPbrZHWL2xiHutNRMTo5K2TeFivT7ExaZQ/O9LjdIx+/TkcbMxrvYxZtM9HxMbjKOrY3erONXymkbeEYn9wI2dQF+Pc7C4xLmBghnnLvQhcNWpdWxkV9cNlWw9RuSsyGJzBQQBmNZ974=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537587; c=relaxed/simple;
	bh=bmZRY/XJ8Rn77XqVSEyqZA7Ik+OGa0Uhxdlul7eGEis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZYg0jCYjGknueg2RT09Ju2dS8XlX68u4+IUqnjnbelCrkfbDAzKc2P2W7Ia7uHzbrHeUJ73GgvyFefpoO5BDNbq1XpaySBLcpgq7srGtSZpPz9c3Y4QMqvTomO416G56LyfzSxkMvHXy523qcT4pAXElF1f+xlD7ZNQKjT+H4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hVjUxqP5; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVZ4WVSiV4vwA2hKeamcdkvlA61DHdprWI8iJq0zUlWrY70tuI1JxGkqtHzcr/DqerCgElbfobbQs0+7szK7YBPo5Ya0PdFJHiJ17KKkCNYlTBsG9AtmI5srEhvm5pMK0XOQeyZ7gIzK4WgAx1UQP1r8JGWV62Cpe3NNuWyp428bqXrgCafDXPmpNspwF+vsThzqO2JT/e7a/2Kanqi7y93LrEMzpw/JN+vTlttFcZ6dLtK4qiNN1FYrU3iYAR0JRyfAaQSn1t6ThWL7fwUagGizrEXefe1iR0/C7+mZEVeODDvWsovUTXOBB8ek1pJaY5PtohxbbPGfqOqkrl9Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r33u17aMNZMQyd02Mnz2J9upEGhpB6IUh/LYxv+KJ5M=;
 b=JuYuoIcOaZp6BB5ZE2UnhcJxJGIMXIcOjbra0S5ojVvcCf3p1GaZ1w7nqjGi0x0TEZvmZkEXYmsLJ4DsnSes0J/3DM0UL3UoFBTqEZwRzG5tUYETe+IDrhyaOJ7b1DLKRuN2KldHKHs9NjSmOQAI9R3n2/ZCEZK7kfhI5qmHJLy/X1Oh55QVdhA4j2Qlyv+H0fAx4/qZZFXXh9DLNuZ/Gr1CdxDY7b58VlmDBKrXSsO96xsmlZzUpiZElOcZJRA32/lq8CX20df13dAIGt3VoWaYOaU8xeFqc51asu1i5ek9vhHPjaii0bcKl2zAxlOcNsTm8rUtEF21yuSWIyLUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r33u17aMNZMQyd02Mnz2J9upEGhpB6IUh/LYxv+KJ5M=;
 b=hVjUxqP5SSCJExgaVSjCNqRzp1b8ZrpRQWikuWYfardTv8yxdilzrdfF11o+S5DCK7fj5L519w6B1HmfexkNklKtcpzJ+ISu2H40w+pS8dUSm5wKa64dnGYIV+V6lJ13PmwZj4peSOSxoS4WDBfGFWxyrhaVk4dX65QihLPWLed04mvYLUd1HrdKhVlogj02gFcvoxs/P+0tupI82FHejEMjydrPZ5HM5DqQwXdZ+nDwo6AgVWFHj+R+yYPGXGGnK/bfoax4bFk/zqXpb9DYUSAExnJw67cLXGFUHEkZTAcvNhldPtSgpo23iPCIhvZzEDTXDyBdTD2lgG129qpc1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:06:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:06:22 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 2/4] arm64: dts: imx8dxl-evk: Add PCIe support
Date: Mon, 21 Oct 2024 15:06:00 -0400
Message-Id: <20241021190602.1056492-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021190602.1056492-1-Frank.Li@nxp.com>
References: <20241021190602.1056492-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f3cba1-bce9-4cd1-5c96-08dcf20373a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2rlt/lISWfe8MR3ZyMorQppgAg0g11EuBPC6TzOWo9HYg5HWnXHqZadXKsqQ?=
 =?us-ascii?Q?L40STqhTN+gtWXTyZ9gfnMJ1UG8gDnUXmsBLzGdUwmky2sX9n+LX2UzxKdkU?=
 =?us-ascii?Q?FZL43sP+idKV65uDiMy764NkxAXuaVk20chNhJALZuFozWB1zTF9B+0ZAViJ?=
 =?us-ascii?Q?7nnxbBWT/AUj4yb847Curct4LP1Up2/ee99UD9xWUi1pRGyrLRd51cercjvg?=
 =?us-ascii?Q?tXJck0o/Fm+TGYh7E7SiLZnUxpeC57lNdN6C/zFFhnkNs2UHY32YLv6XGtor?=
 =?us-ascii?Q?jDSAq3OLZGI9XfNSuh0l+eJJmDDbA4Xl2sZ4lJe1YYL+tBvEAkclY5UndU38?=
 =?us-ascii?Q?nE7z0X3DOmAv3pApyJgUd7zTUgWrLy3wpzsaiisHT+GPIzV6UOo6sC2Mq1Wc?=
 =?us-ascii?Q?g35qyR/j/ab32+5KVhwF/3/Ew2zluZjpHzprpQRIs8mAbhdN8kfpnaG2RYcH?=
 =?us-ascii?Q?F+pDYCJTcQTE3vqAa021XIO5GyjFT/TkhM9EY9QL9vy7Yp9bJ3Vcw1CsjHaj?=
 =?us-ascii?Q?1p850rkaOv9WRFItiK8Nlb4YPNhEKbUMkSUuBwI4fr3WIDK5KRqUsUE6EWgY?=
 =?us-ascii?Q?jmfRxO7coC2tdP+YXFL72JIunpPcomaFSziJTpn26nC+DgdojXLE4WNJcz+B?=
 =?us-ascii?Q?d0lU02OPOCZY4cwn6gmyhIyYC2+mmiv1xrIf8c48m0FSpN/e/u/D+CED+BFA?=
 =?us-ascii?Q?3OOv/+fxGu1g2NQxawFFZXe5cjF9X0VD4QfSHA8bCDTY6Z7f0EY2MeEbwjFb?=
 =?us-ascii?Q?AxQpYGaMBgaDBZ1lyQdCzTqdPU9JnY632DKb0QHDtLoqSUNhmaXqyN+qDeLg?=
 =?us-ascii?Q?/xtcC7s5/TMjDZ+43Jyzuzpx+2KhnuKXA4m/rPPCpg6PXN4KZGjJIrBgi1GS?=
 =?us-ascii?Q?L49vv/W+JcuskGKiT9awT+g2CogIVpuZWTwXgQ47BotO+3sIPsr3VIMWTWYC?=
 =?us-ascii?Q?/PhNZuvVEvtClLmaddd34C72jCT7BuFg4lwjP+Raw30KndbfDY2gFxxZznK9?=
 =?us-ascii?Q?sBJoyCFkW1kFn0hZ+mnkvo4Ky0GXEa+gnM3wHTwNLB7qC/fG3wWYEpHqyTsq?=
 =?us-ascii?Q?qwfJj+rtn8r2iZf5Asf2Y2Dac40kPjSQGhZwgdf+qDlf7M0qBP6t+HvFLQar?=
 =?us-ascii?Q?vuO/dfXv6IUuxUNrUXf3as1S36sNnp4WC15QXs4Js/d5Z9EHB6KWvMRvCs+V?=
 =?us-ascii?Q?v2UhPqHuydxH9shqYtraKOo4LW4kwQIKEqh4DzUSo99i73iho/3RSbqs6eYN?=
 =?us-ascii?Q?0Z+l9p/+93vMi1XopELpbVx9wFAinB47IadNKdOl0JJDcbwxRQEDLKFHYysX?=
 =?us-ascii?Q?+XAgMwViTVxPMXb5dJmRwnf/CqYWZ+gOolkpu4kqJFf3qYSo1Qq18Cv6NlX8?=
 =?us-ascii?Q?rtyW8fA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ub/wRG2WZ1MyjjMEaRPpTlcQAbuSHOCacHRWzTGKE9a7ALscwmjDltt0nk9G?=
 =?us-ascii?Q?TOjg5BRZSsL9orgA1to77hKJXw37rrWmT5/Sq+UGx8BHNLAjruutVEayFwNS?=
 =?us-ascii?Q?MGFUG6yQCpZEI01tBBoUZbQzqd+I2DXNjW2Ebur97haH3rh+ZmN12c6kWcXr?=
 =?us-ascii?Q?F4hu1EaC9PxTAh1/WJiEsWVPe9jjBIxg/0hGN/ckIybGvjZCI2LbTvG2mY5T?=
 =?us-ascii?Q?14e+3vRikiLdzajyY+4x3D5OYmxLA7hNM5Qm2X9+HCjwqajItKFH6nfdmjSi?=
 =?us-ascii?Q?GtFYLG7FGi58yKueys/yiS19lzAgJG+Tzqdi24iyc82AgSd6gU6fVKMdvAv4?=
 =?us-ascii?Q?IR7Kl3z+LZKLeLeOgedVbuv3XN5xAF6WaQbqd/2s7aClIPKPiQ2tsgDrz9YH?=
 =?us-ascii?Q?MrAXJJs2FOF7Wswx7SqV9DVDT/IX0tODaE5iLA4HY5wmEh4cP+waVJjGqm+2?=
 =?us-ascii?Q?IwsXYtaVTpaNvZ/nfnJxGVwSJNphDCcPIGxMTwuYF7TaRLrumj7JA8V8fmwi?=
 =?us-ascii?Q?MpaNxDcPrby66OVCiy7zbympAJQRxogiTlbo909oAWoBbn0uGgPSHKgoXHDn?=
 =?us-ascii?Q?+2DNouj3xphZKA4eZRbhtY+J8S12y2EmAbCu4pgJYz4N9eIJu081ZRqI1Yg8?=
 =?us-ascii?Q?UvNbvSUqIBw51mE7jzyhBx/V9W7tJzRPSVw7N1jjlrv12rmJUJpa/RqPAC6D?=
 =?us-ascii?Q?bs7Sqvz4yL5NmfJxX9tVAj58mXzN4dOfgShUWNqlxbOzugO9cmyuam5y7pG/?=
 =?us-ascii?Q?ThSlSUBCAo3z1Uu7bTMBM6yW7MDf+/D3MTDa8hReMhr1Wn98+Ttyf8HzZtSV?=
 =?us-ascii?Q?iH6IJLvDLkV9wOYFvrLEkwbmaTK7wcDOZDcyERUieFC/V/GsoYvy+K/kxENY?=
 =?us-ascii?Q?C73JUVS20IIHJVQzeL7gqSwKELukds6itPsNXoOke4pyUJFMwF2qp11hqWMy?=
 =?us-ascii?Q?fa8K8ecLce3rYIzQOVRlstJVfR0yBuJCW9XC2wpy5tH4vkd3uVCXZzOeuEkE?=
 =?us-ascii?Q?dFErrS4NfnHJd9sm2fcfKHW/GuopbF0N2gIYP04xzOdd8AukEG/z+/35k/5y?=
 =?us-ascii?Q?PFi6aYJ+1y+QfLVn+HYcqwtIqjVHhjGLoyLBwb9FJqq7R5dMgw6D4Yoey+7h?=
 =?us-ascii?Q?B5qD+Ovty1Z6hEo1kgV///s/7GdLFc2MKnUJ1CF+f3ROu+oY+n/gEKev1D0q?=
 =?us-ascii?Q?foboUpFtoQzCg6t0EMPCs7e6IoxJZ7Bu3SCDUSu9QcUOoUrGKQNrG/oEkBOZ?=
 =?us-ascii?Q?Z+nF9Yvs+q3LCTJoYVSLFKjkWO+4RalNu41gav0qvDs5eVkeZm2hBqEX6zxV?=
 =?us-ascii?Q?YEVgKwKAjwlYloQhyOXB2qy4pv6OwHGLRV+yesLvDz9kls9WTBarHMBX8dQQ?=
 =?us-ascii?Q?n58DuZY4NLry4B9VURoGlx3NzzEr4LXetI5wBqmEOBimat+c+qEZzTcStN3z?=
 =?us-ascii?Q?PBYZXQ/ohPahKKcAJLSnRDwv5ALv33zlNXFThfMtQUpl0PwKAtIikamUFn/W?=
 =?us-ascii?Q?QIh16giQpJK3OjI9K3/Ij/07hflgYz2s4r2gJrNpnGvxTUAuQSVs5M8+XZOI?=
 =?us-ascii?Q?QDRxx51nYTT8Ry35tjWnbewHNW9MdehZOK3FS4cS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f3cba1-bce9-4cd1-5c96-08dcf20373a1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:06:22.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO3BnZU+iUNfSZuabqILj2oULmYuV7csQMtYTwTNHasR4u0fqMTNBh7dRnhiFG36/CM0jgb/o6bUUiE2+yoT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe support on i.MX8DXL EVK board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- none
chagne from v1 to v2
- supports -> support
- add space before {
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 4caaecc192277..6259186cd4d92 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -182,6 +182,15 @@ mii_select: regulator-4 {
 		regulator-always-on;
 	};
 
+	reg_pcieb: regulator-pcieb {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "reg_pcieb";
+		gpio = <&pca6416_1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	bt_sco_codec: audio-codec-bt {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <1>;
@@ -567,6 +576,12 @@ &flexcan3 {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-x2-pcieb";
+	fsl,refclk-pad-mode = "output";
+	status = "okay";
+};
+
 &cm40_intmux {
 	status = "disabled";
 };
@@ -585,6 +600,16 @@ &lsio_gpio5 {
 	status = "okay";
 };
 
+&pcieb {
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcieb>;
+	status = "okay";
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
@@ -868,6 +893,14 @@ IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
 		>;
 	};
 
+	pinctrl_pcieb: pcieagrp {
+		fsl,pins = <
+			IMX8DXL_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x06000021
+			IMX8DXL_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x06000021
+			IMX8DXL_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000021
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8DXL_SPI0_CS0_ADMA_SAI0_RXD		0x06000060
-- 
2.34.1



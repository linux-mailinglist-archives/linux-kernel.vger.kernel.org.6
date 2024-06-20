Return-Path: <linux-kernel+bounces-223016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C7910BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1439D1F23149
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650C31B14F8;
	Thu, 20 Jun 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h7JCzDio"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2C1AF6BE;
	Thu, 20 Jun 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900212; cv=fail; b=D1L/+i6BL7Jsou4bGTuU9/3h0U+SqZfoQVj4xHOs9DSX24ik7CvHxmXVm9E95/swj8XYQnc4N12rhYBKXRWuWzgo1h5HhOWDUWp2irPVuJjnHKSTzpZ3LkkoTPSJbvhdKho1GDiesntPun+I7cUBM8WWxNn+g8vNguy+M7uoGcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900212; c=relaxed/simple;
	bh=x1yjjRIMXynl57ZU8QxK1Kkw881DCG8JR2Wsa3MRkqA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Edc/AVMYgS0hVJkskhBtq/P8fbRbAgMQ0OAW+zUImHsyvZ0JH1ohyAfuSp36Y4Kkxl+BQ5AvZ4supdKwY2yue98+WXDjj0QkTm1laYJpqix7wlNvEVCKbm+HvW//7y+xjf36yFYpBJ0oT3N6Sma9hXCYmGFO6yazeQzbWJJvIiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h7JCzDio; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd68iyXkQeeyT6rsrxX89VfLc6BDAbgWVWtgjpFNkW52KQZG+xN8VDwiQtNGW+tU/gQBW4Xff2LhuzECLCTWlYTvKsbGokZGerOXWXapMR+0gU3MmGnUhTmF5sR/BG9KH0YCAwucssiUw3fxC5NOvsFE+xAIsUSQi1dqAjA97cCJBFgV1rN4+546ObZ1bLxUlmCg2avoMcuzFgvIbUnqgNCZuwwEt4O0L3bTSxPuBYqX4nylbHuajmfOHg/f3qGBvUQeH2AOMbZPlspgqIArSiUdvC5DODjslD1T6fbvC96UIXu+3ZNW3SQ/GlY4hupbXOUM9VcoaHfdBoYfzpPmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HULu/D6mIzPNEut55OFoL1Y0goqXjceqGlGqZaxwQUY=;
 b=BB9djnM4EwkDHnIh9ZnVEjd8L4OqXOnW94hixvqHuIkx6182k50o+MEpPeOGtvFi5WAMSU2I8vbKonflF2NPwiLqw2W2tZ3wBhAdfGgCI7k+doM9xYzn+yrvIUBuzVDf9vIBgn4sVAQ3iKi9QkAqtT1ofv/r+O6aocgJKen4lzCFDCMKuUNF37tZYBpR0h5akjYytggvNSN9HR3ojGHcw4enLpBh39Wp3JQVqJN1ryrVTXh87uhgHu5ge2NZqOBWtmczs0q7fWJd9ESx/Vn3ghlxcx9rghfNbhRQaY9bSPM8AlxAnXoQXrW5e8OcLlK95txZIPnvxSHwziF/e4vX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HULu/D6mIzPNEut55OFoL1Y0goqXjceqGlGqZaxwQUY=;
 b=h7JCzDiosyo75bBCYLkySdjnuY8tEEDqBxsNcPcyg2GoKewv1pvsesTUTd4XGXifXQUWTozS5Ob+GzUyffdAEcCu4mbRbzne9KJhLgYjqXV5G7b5yUuznFGP/xvDgm5ZyD6ZZzGOHD+Yu6XruJmGAELYBcfLT3jS3HSVDgvGA0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:16:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:16:47 +0000
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
Subject: [PATCH v2 4/4] arm64: dts: imx95-19x19-evk: add PCIe[0,1] support
Date: Thu, 20 Jun 2024 12:16:22 -0400
Message-Id: <20240620161622.3986692-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161622.3986692-1-Frank.Li@nxp.com>
References: <20240620161622.3986692-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0197.namprd05.prod.outlook.com
 (2603:10b6:a03:330::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcfb762-96fa-485d-384e-08dc91446283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uyk0898kxJYMW13fXuMyFhyq3QcCf22iFvLPNZHNCnKKxwvXKMZNAG90nOfc?=
 =?us-ascii?Q?nM4jakqcgeAM/xLI1i23qAvXDtkd+TuYEEA94HMmLDDmqsi/EV/afK2pyB5S?=
 =?us-ascii?Q?BbsXz2nIgfycy+Ohx665MlrTITlHFBDv11XkB+EJ/s+6Soc+hfhSs7fEsO7C?=
 =?us-ascii?Q?KjHH14bAzcBOE0xYeayjt41Lg+RgKpqzhx6GXJTXtqcPNfv2WzQuGLPTVk3f?=
 =?us-ascii?Q?SlJzP0zqpdgIjVBheNQMzALp/8AvNhzbJSjp7vs7A4dbgANAl/UL3aXLEHgu?=
 =?us-ascii?Q?Sumfh76WjFCILkcd5LMHH3ejrjWFUjCgDeKxeuZcSqP4PXTl95riNvaUzb8I?=
 =?us-ascii?Q?UomymjTiWyqgucRllPYLgapckdCtfxmAVHjHLTmevp0PCkdCzqj8p0jHpeYU?=
 =?us-ascii?Q?cUJsp8naZ/PnRaJnmuDUmZ3xEUNIJ38E9Ot6ydL4fEY3o5bIueGqA4vzKp4L?=
 =?us-ascii?Q?TLy29j/7561CsWcNm/2yejvSUCLKTOXQYN0zkPMsL1Of7cCot/T6cJQTkVAS?=
 =?us-ascii?Q?iY0ABqoQeunAJRBpyAhqbPRzIaDDsNryVpPTfd4vWbB1FgqfUhrK/pBCwAz4?=
 =?us-ascii?Q?vXwTOnB29FnV4iRvrKNY7gZMmr+X4NGgjB6aJ9ZxQ+JZGvJuTxUq1DtUQnaS?=
 =?us-ascii?Q?HVXKPt6lXrU0KqTodNY9n9FUxks5yQlgEf+vTQ6yo+wcH94VFgt9fnGVmG1T?=
 =?us-ascii?Q?NgA6r/JAVbX1ZwuEIfG6wmWLpHvKkKpQ05px7QXrVEBU2ZT0Yuj3F31qo9ik?=
 =?us-ascii?Q?Hmdas2pNOFfjrZjpjDtUt4Q2kwsMHrY9sLVoukjbOBjF32z1/wYPWy4Gwt7e?=
 =?us-ascii?Q?RyJdbf4Gc2yakhqHmoqTwfiJ1P1d5JoHFjoQekRfvnsPGiPGj8BFCahwzTP4?=
 =?us-ascii?Q?ym24eqr4ElWj3KsGbfo9Y92+Abk1Wzz/sVAKetg7eqRwTgxiyQ8UG8VzHYZe?=
 =?us-ascii?Q?jIpLbchM0qkWj8nh94GydL7cLapH4wJwau4kiI6KXC8/5rmLJlC/elY8hs4c?=
 =?us-ascii?Q?4LTgsaezi/soA9GHBRjq3S+xAGJ8lmSfprPfs0BFJuBPIcQ3VDGkP2CagcER?=
 =?us-ascii?Q?T9nPaU8r5AJ+2mJXnUN5WnStdDiQRNRiLs+sSWn5fFbhi51BGYqr07aO3kmR?=
 =?us-ascii?Q?/78rDs+JUThSt/jbx9dwG657hC+u/8XmjwAF04m/oNPUw2XSNWY7m+C5XAFu?=
 =?us-ascii?Q?BJfDdr3QX2/pSCHv1CgFx5S/DEVVhr+57N/XlujgoQJAQT0lUBXP9vUBqcnA?=
 =?us-ascii?Q?A2sIA89BOI1XS6Z3VUuziKxm+AJJE/VHiwIFf9ldKXlHtAkMslCoFWt2Jbtu?=
 =?us-ascii?Q?1LxMI4ySaTqdPNBFdtL87il/EtBX2ajLAj0VJ5zIf5cIIMN0DG3uHJbD7JKc?=
 =?us-ascii?Q?o6Xce+Vauw7ZrOM8jhBjmfcQfSrd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrFUkTUb15PMe2zNiIAgwN3l0jKR4aiX0MAOOW0eQ3t7t7oDb3zkwPn0BmYD?=
 =?us-ascii?Q?Yp3BMTepPF4F4/mIbUOvV/VrTi7RCh7VwXDrQg50AR+cqhWxl5TuKy+UUm8r?=
 =?us-ascii?Q?HWutbATX3kIY+Erz/O7YR52LuCkYunglUSldZ31WfTyEezF/3if7sfwjrgJW?=
 =?us-ascii?Q?KV/sfO/HQDWxVLh9mz04NLL4BQYi1BfZKWBd0b/fj69hRx3W5njB9MkOaCV/?=
 =?us-ascii?Q?020kvLqNpctR5qhv5IZ7ZdR1SEXxT7mMqPYaVz0iE6AXdURW1wr5p8BNe9e8?=
 =?us-ascii?Q?US8V8MkpwbQJEyCfytsbBRum6E0agh8ZcIU6byECmrE6CXa44Hc8EYfZt6Qu?=
 =?us-ascii?Q?VMWGDbETmdGNNcAVRljShg9+vhFUEU+d/LPG/MaGKTOJ0UwBSCxStS38IvsN?=
 =?us-ascii?Q?M8CFpRR5FsMuJRPNyiLJ1mA8hp1dJXQfkaKqXGyfIRtAo2o84cjETY1zYgRz?=
 =?us-ascii?Q?UKqAfANe16SUJAlqWgGFNPlBcXjBKvwplxlyZsoUAd/NtY/BF+gzqtNpM5q7?=
 =?us-ascii?Q?DtmfBwwR1dPUwieXHFgi2HagjSehexXZiuBa/Wyb8iZpJi5U/ZPkOciEuAaS?=
 =?us-ascii?Q?09azSywmrrk0Ox6StsWZ31+ow3sBiZH40Ve0JNEYLtr7eCzWCUJfGh+OUOXV?=
 =?us-ascii?Q?C3TO/FanGX3QHyd2IwCTW25eiUPlqIJ7RgORmJpxdxF8opRvWrdlhxMutQP5?=
 =?us-ascii?Q?ONKJpwqMm4xZa8M745hzy7TxJ2jbEwjYJGLJecAxDQtEor/NAWYBNmbwwl2Q?=
 =?us-ascii?Q?uXp+1URTYasgzwEVmuz9DBSASU4s3XpIHGm7e7tnwkKem2z/9Iv8Oh+ggYiH?=
 =?us-ascii?Q?jFDgQmIGI4T8hBEBcbgWBYz9hHSkv7XgpsfchOnG1w+74mqv/e5kmTbigxnH?=
 =?us-ascii?Q?Pf+pqa0rQESFc3RljNJ6mgPPhhsn95GUy9R+DSAWVsU7fXGcsByc/juUHEt5?=
 =?us-ascii?Q?oU5/+KluWrdQ0HtElEIDPZcLzO2pB0XAQkxCsLoMXJKPIFWdSnsy8hTj3zlR?=
 =?us-ascii?Q?Wznesw97MP7totvbWFbB+dakaGq+yYftx4S2NTaRs5ioZkuFZWh/GjFVc5sb?=
 =?us-ascii?Q?0THZ+A7RarCwnsWWP8cPAy1r4gKQtPwHls++YvGCvHDbTviC662EOYC7mX17?=
 =?us-ascii?Q?PsQlr5Sl9IJuz89xPyy6x97LxqlbxG7FNcIqsD3gHKi1+t7muxh2xP0mIWZ9?=
 =?us-ascii?Q?xhaUxC3Ow8SKynaWwupKrwf/NzDRuzsAFTX/FeEscuXGpr4s923rTgdhGeEa?=
 =?us-ascii?Q?dhYfcLirSfHXU0AveDWT807ltZ8RTLn6vx9Macs8QjbgTcBHBiDXZR+xHmk/?=
 =?us-ascii?Q?W77t3xYV1QfsWygekjFYW+GZfpn+E6miUzi7gKjHrv6+5FbM3xNBZN49BkEc?=
 =?us-ascii?Q?juNlp2ivSdSuJxoaMYTiwAmknwaWv5CWBun/TyqJ+iDZSLgO46eO6Rj0owWw?=
 =?us-ascii?Q?v1j5BGwIAbixkXTS7gVWZydL4KvHbYSd+bh5RG/UhsyZskaeqDXTBeQgXkuw?=
 =?us-ascii?Q?LEJ3XRFTQNgbXKMlJWBGF2Fbn9t/9LP+kMh7s0SIJmsg6Dh+m2mHqS9/SUYa?=
 =?us-ascii?Q?KfkKERP44yBCDLUQm88=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcfb762-96fa-485d-384e-08dc91446283
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:47.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Z2imNsT4zRWwdc5+hLy7b45PhJwEzvaePJBEm4w3DFJvPNQf4K4sGYB7dcuSGz2r8GMNBk3pjGyLd1e3TPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

Add PCIe[0,1] and all dependent nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove regulator-always-on
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 750a5255b57ce..d14a54ab4fd47 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -40,6 +40,34 @@ linux_cma: linux,cma {
 		};
 	};
 
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c7_pcal6524 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&i2c7_pcal6524 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_slot_pwr: regulator-slot-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIe slot-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c7_pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -84,6 +112,22 @@ &mu7 {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -128,6 +172,18 @@ IMX95_PAD_GPIO_IO09__LPI2C7_SCL			0x40000b9e
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B		0x4000031e
+		>;
+	};
+
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
-- 
2.34.1



Return-Path: <linux-kernel+bounces-174026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B88C0949
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E11C21463
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F313C693;
	Thu,  9 May 2024 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YLHQ7ooQ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DFE3F9FC;
	Thu,  9 May 2024 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219370; cv=fail; b=jyug+SzBD3fmMlOOkre4XQbjsTH5T71W9k8zueCKSfM4KzbDxb7OLHJSwOZ2nuDLu+ryGqaIB/84hIK+JP4ECGtdVlU4Mwpgv2WOjFeI9iaoHI0mmC5mjVmK27iRP61wPDJxlrUnjHGBO4D5u1jVn0gorPrf2PrK8zLYZ7HKcBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219370; c=relaxed/simple;
	bh=VJ71iT4TaGUqlwW/Dq5pOEehwiqamVJzcp/zcwEAAXM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AUEjCoRpcIlrmiyquzEmyEjs+cOjaKvK8sk/DH+RerneVgDzI6IJE49YrXVbqpkRmkArUYKW83Xg8WP6lSc/z288FeaBVqG9uUzeLfNrzQ4uaFwKEb/U0IsgzSWDKz1HmV/7L371P+1HxoaDPQurZKmWqQnwmpNpw04Wrju4Er8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YLHQ7ooQ; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVGYNSIH2l2NXFt6Yt7eFaKAtu4qFQ82KqHyeZ9J4VpQdZ/BeURZmlwkpHIcMtBgJD1cl5hq+pOl53C2JjVbeBMV3HBWxGtCZf3cQlf8yQYUjw9SArPtXj8NzXkfJIClJRtpj9YXl9J/Q+20OLo4gtBAT1kjKbndhRZ9ZBh+Ab7CZuJPBRH5zIfYcwl5yvlr1brvKTuvo9hU6nU8qgCUDylTkMWtHFUyazLVgVFjpilA83wvN9l5ZafiTOlIE9UtsHwEDcfC04uJwe+2hiLzDvq8CIePn6CtH8GJlhKLqudbDlH9BpLjwwh24JKkZFcIP5Ypbg4cRk13XpkEViOjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m0+tv90vMZFn7i1/6uTfRTSwqocicSApsOPbTk/tsk=;
 b=bnQEQUS1WmeYM7e22r7WYpe4LcO+QTtclOyfGZiGUu8sPKMtR2CmMR58mEiFi+u4biSwpS9NnkhbigwrYylAKvxW7f9gF9LjSjR/wf64JOLajgMUOF0GvtH08pJMuwFCRFb/2GIuGJ/1okVGyPhARYjZC4xEUQefdiVu1zppYhDivQRVEtc1zBkNBhtap3eYL06QPUm2eUCQFrh4WJfhs25rwIYRAHeAODCYvgyJjsTLJO7tny/DDxsrCwMNtyPhMwsSSHwnXk4Lqww/1jyPBBuSRAla2eZOxDgSPMdQSBNhKeSgogQ7WXSMHVYHDnX7T7GiegRBjRvkKjha4BDsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m0+tv90vMZFn7i1/6uTfRTSwqocicSApsOPbTk/tsk=;
 b=YLHQ7ooQ/s+/UFpQ0E25IPNIvQCGr2iRyPxaweNRVOIOPY+Kz1QSCryJt1OlC2ah+Fhv2g4BJHgFhIEYhBe9jy8BfM0GCHIVprMI2O6mCCDTib3YcHoMo0TZxrqVLLeEq4JLai6koyKubKlP3P8FIArco8lCBZKp6sAoLBVLPNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA2PR04MB10087.eurprd04.prod.outlook.com (2603:10a6:102:40b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 01:49:24 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 01:49:24 +0000
From: Joy Zou <joy.zou@nxp.com>
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
Cc: Joy Zou <joy.zou@nxp.com>
Subject: [PATCH] arm64: dts: imx93-11x11-evk: reoder lpi2c2 and lpi2c3 label
Date: Thu,  9 May 2024 09:57:08 +0800
Message-Id: <20240509015709.3668405-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA2PR04MB10087:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be7c87c-10c2-4d1b-6f75-08dc6fca40d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|376005|366007|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0vLi2jX2l/sx9GTx5dm1IEYbCzqrpEuta+fzq5jiwNplq5D+43MsyfYNaBnR?=
 =?us-ascii?Q?krXG4PZk1puGnCtstB6XdfHkZFui2bDmHiWbQypbDktYlD4bOlyWh7Lmoed2?=
 =?us-ascii?Q?rClrhciIscFfTEeCRp6mRDvN9+mGE3n/JHA5UUtZhqzpC5HKg/p3B3ZhqJjS?=
 =?us-ascii?Q?L825ZTdnRNk9Grpo7AkeYhf34vPxEPzunzkT42J9PdYX+k8SoItRnrxm11Pk?=
 =?us-ascii?Q?LMIGUnKiDXEM4TEBLDiMEBUECLntv0bsp2SOtutvJ0+lbBIbi7ofJl/ECVGh?=
 =?us-ascii?Q?KSgR9AYjZkr0uvnNFkKy3aAyC9gFWdsldPLw34NA9/eORoO/yum3D7ksaA3X?=
 =?us-ascii?Q?4H7cAFoBjIL8HLkFAAKi9oCd/nUmWkHickKZjuQS1rOOJN5d00B6kN14yOG5?=
 =?us-ascii?Q?d8OMc6ib16kGEaMdRBgVp0FuysR3g0z/wHtgbpWj27AphE6smS8MYeOSZ7PF?=
 =?us-ascii?Q?uOJUnLFgsqsK5mFHE8kO+pgOsfPAE5O+XGQlqjCZMw850XDKCrGClZHn5pGf?=
 =?us-ascii?Q?LegGe13oP8FU1dxbl3ENvaRNJAFZlBxyItZmaJV6gdQuIEw8IGX2XdWbpW4s?=
 =?us-ascii?Q?d64Fn/AD/abR3svKCc0oxvoc5QsBQdwdP2e2AOWaTvt1EQlT7x+EmUJ0oYqz?=
 =?us-ascii?Q?jxh/OAG9+wW9yH6VxMtSfLIi7xsNEFSI8U60S2gT5MDCYRZNjftI+nE0/Gwe?=
 =?us-ascii?Q?lMysQspm84iOT6rZQEmxGvyHcqV4NCDH7d1Zc1cQumESntChnnygNF1/mh7D?=
 =?us-ascii?Q?R668SU4AVbn1EgxUAcL1fsQLgsTQnVk+6qs/rfM4zfwxUxTTotl4a93ke37N?=
 =?us-ascii?Q?0keUvKAXq/dDKt31M75PY+HObmWV9dVNA042IcMBzqz9FlX8JmCalSiMYZ4N?=
 =?us-ascii?Q?//0/ulekovmkuy2xrBlhwdQKycFxLY0OoThIk0mxxgwqk94zsGE4EMfLt7Lv?=
 =?us-ascii?Q?AbX/TbJJvqmqUyRrIwXPCC375QYWuNKipAvcs9+Xbw69GHiiT9RcUNg5YorK?=
 =?us-ascii?Q?eoQTedPQtd/WtA2e7kanj8tDRdw45Zl0mem6EJM3vCYsnJv1aNVpnB2ahAlx?=
 =?us-ascii?Q?+fNYvOosRlYKO08WhYgfA0VPVVVAn3RE6H/d3VZvrJsh9V2n/5kZluYGSdsU?=
 =?us-ascii?Q?qPWpeuRA+nWkfhoxJ4s4BPfFNk1tFPj313IwJQbmiCgjycovoTx7Iqr2BgLP?=
 =?us-ascii?Q?zEUNuJ+MXCelkkmNpD0YErPrt0a1p6dSY1i5VPxphcV1r4+34IuZ964N9Etn?=
 =?us-ascii?Q?X1nEa7GnL2egpfNlebld4cNzbyp4CxJ5GimUplXQF+pSD5Zyzb93jQwK1IiM?=
 =?us-ascii?Q?kCnwUBBzHOmjQi/31otmte6DkE9AVZP+FnloZY6UTXA6ca9P2GOHSXwYFsNR?=
 =?us-ascii?Q?1b95fGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vxRFiO+R9WApyXUCAc60ohs/VH4Pa0qdnpttWbGJ/fy0HhetC2VWApzJet7?=
 =?us-ascii?Q?v/+xe4P24xSLsi+6RJzOg/YZpSwt0TLHOugvH2c4YgUI/ZzQ3Ut7F7kXATN8?=
 =?us-ascii?Q?LxtyRwK99FSgvMFxkiZiPPAFtz8EVnPmkh36N6Gwd6PL2X8gIDk8aL85HjIG?=
 =?us-ascii?Q?arvLArQNFYmkvXEYigOEKS3O3ZMkso/jPTm2gFowVEKYMcIIbIfAprLjGkk4?=
 =?us-ascii?Q?WThLMWXipfhFRhfStgDy3zopMAFlTXmpPCJk6L6DSp1VeY9JlLT6dQg6vSXk?=
 =?us-ascii?Q?tqMR9iYCLeK0llCOXFc7o6khCCUg/w54PYEBU7aRD2g1hq5w1q4BehboG6VP?=
 =?us-ascii?Q?+aPxYAE88jtEjzZ5ZMD2xyok+SuNXDXfPrFiuhYJmOsy6/GmOOJqk8FelgYI?=
 =?us-ascii?Q?hmvBsCK8STsKy4Oc59krx/fyY2IyvWfdcBBTw5J2ICgQTNWjQHEAiD01Af4O?=
 =?us-ascii?Q?W4y0YzH2kYKBO6LbVmtUbEfE5eRNC7xsxlYVU2LN8oSIywCPlCsBSLZSuxqy?=
 =?us-ascii?Q?0Mf+iQHUwriIyLFOpxXCXT+rkd9lR6cThj6vMOUhtap5SSDgZPyMZIWsinbH?=
 =?us-ascii?Q?tqdKnvezoQqF98FEIq/SviWMQBYIA0e+09KGVkdby6jUS+r5cBXrIYAgmz7e?=
 =?us-ascii?Q?X3VNrFGpPciF0f40U5hJtzwaPkFa6T866KiqkOAri8rP5YVJGvuRBgc/jIha?=
 =?us-ascii?Q?3BBKafbgcpxrXTf4kUDAWXJzdyjE1d+GEtZeqVI21qeIaiaxNZj2HOG4ctJv?=
 =?us-ascii?Q?alVMQvsXLx/NHYF4L8BIOxeXKe/rfZgdh9AKH5Y0EmgQom94s4VNEm3iO8ki?=
 =?us-ascii?Q?B5e3wOT821ctqK1we9Sxj4VTWYBeJxjoo8YwIfcYWHJYGtFz3LOI44GiLs8/?=
 =?us-ascii?Q?t3Q3UNz/9xSoL3Qw5oSl5OM8m038ytmpxYLKtP+93+sT+YuIPal5m22zvbsf?=
 =?us-ascii?Q?jush77//vdtTVLCSod1Z3NvrUDZZasx5fQEI6q5cZBg+MK6dFHXkpYbvSVvR?=
 =?us-ascii?Q?lVrV2sL9z+gDjLCgmS/Hyc1I9+RDe6TXWd1DOJRyIfbIDYLc9vMEuX9/hjfg?=
 =?us-ascii?Q?1aXidWAA5CGh7RD8JpTdnikR/zxAJMqbOOF+3BhzwetO05TFNXE6jK7BNc+I?=
 =?us-ascii?Q?6TyLDbIM4DU7txS3bcoFx19YrxXef+G1eTEU8AT1Ll3h15Ec2qFkmxcaxQZu?=
 =?us-ascii?Q?XHzi269Sik1Pg7Cx8w5Y2uUeOTgEFHky7i9GTbaZrSkx4GsLQWoa7/AUx0Us?=
 =?us-ascii?Q?PsSEfvP6rclhcXX4kKLdpVDW0wRyRZuXv2nHIi6fhDJxiug/FGxTHw0LPLrm?=
 =?us-ascii?Q?5fiHz4qG5tkH396TlO8JSqYSs3h6nXpDze8wrrnuYncjr3LWWfGzGF5T/OtM?=
 =?us-ascii?Q?yY2JEro2q4eJ9lVAtu5YQRea3iMDOWzxK8zaj6AE+xZgzfYtboCAge2ZXQPJ?=
 =?us-ascii?Q?QRFfBVtCKoeFo/B/qpNO6rywT8i2A7rNKogthJmoJn3S9xiuNebq1bW/lVWD?=
 =?us-ascii?Q?LGf6G79r0WkSySxCSLwEgBvQHcBoB3SQoAV3JHFvRyT4jNbS/iUpfS8zmuOq?=
 =?us-ascii?Q?7HNAGpltWtKXBI630gt53+wOKHNxANKcleCPT+lK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be7c87c-10c2-4d1b-6f75-08dc6fca40d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:49:24.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MeMe8dpJ9rbEP1E1Bbp3WY524IS36RWJRI8SqPzGBfua87ZjwOJFA9nGYAq4gDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10087

Reorder lpi2c2 and lpi2c3 label in alphabetical order.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 217 +++++++++---------
 1 file changed, 105 insertions(+), 112 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index d400d85f42a9..6be1eb920c02 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -105,6 +105,104 @@ &mu2 {
 	status = "okay";
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1140000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 &lpi2c3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -113,6 +211,13 @@ &lpi2c3 {
 	pinctrl-0 = <&pinctrl_lpi2c3>;
 	status = "okay";
 
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;
@@ -304,118 +409,6 @@ &wdog3 {
 	status = "okay";
 };
 
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		reg = <0x22>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <610000>;
-				regulator-max-microvolt = <950000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <670000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1060000>;
-				regulator-max-microvolt = <1140000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <1980000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <840000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&lpi2c3 {
-	clock-frequency = <400000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpi2c3>;
-	status = "okay";
-
-	pcf2131: rtc@53 {
-		compatible = "nxp,pcf2131";
-		reg = <0x53>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
-	};
-};
-
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-- 
2.37.1



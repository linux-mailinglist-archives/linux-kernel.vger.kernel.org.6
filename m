Return-Path: <linux-kernel+bounces-218387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346AD90BDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FE5282845
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6819A287;
	Mon, 17 Jun 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IBiTEVS1"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2063.outbound.protection.outlook.com [40.107.8.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6F19939B;
	Mon, 17 Jun 2024 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663492; cv=fail; b=CMD6nk9XwNslDi5A/XX7pXXsreuuEKH/RmDVUa+LHcZ50F1X/z4ILAyE13Jl+7vZpR7Uo0LH40nfDrsssEdqmgpbZdLLQ+6skwjJL+TyOH/JrJBjMl/uon5Mmnxo7D/+vegrjRHP54YSRY2srOP/CCfL/Ans9kZ7+Lpr4PrEkjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663492; c=relaxed/simple;
	bh=cMLIOvUCj/Y4zmra+UheYgD7P+iqAnA+MXctfzTXp4E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dnj12T6vbt4Y04KzUba3Mc/oKziClvi42BR/yPqfCNSvJ9kGksz56uAD+M4dHliM0RQ4xAsQHEmQW+Zkc8Da7hUTLNFJAmsrh0pJKxRuH4U+FlbRdWvpjBYs1aHmRYluxCy1S7Lt1IlYYzFJbsVBwmuWUf2ACjugvI6GZsSQkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IBiTEVS1; arc=fail smtp.client-ip=40.107.8.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hj5YqVXjqTfcNqv9mVWbWwM5k5rmaO7RxlzP6bafAbBc4CRKixhApU3v3I4wIKAARto0XC6h6LIdp4UhhzmciE+w/TlT0E845pcBGhJckESEyOe18o40cozXjHx+Y4r4M3aWmRo6z1IxdogqWacS9gNX+Ex4zhRqV0MjOaUId2ycTNZRTEGAVHZ+1Try+jp8AtgRISR/Wv615KzilPbDuUbQcX/C2oLAiFMhU4/wWGsNUBi1ODifR87UCQMYQvxmSSyJdx2u5/6TqFggjePdn2OFRSRFPt+3Vh0P1SW0N/I98ceEIfjeLG/a7ea4U0WW4ec2uLDmgxLkl5UprFUi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYmxut7514DkHGP1hC7LqCbp5TlWPtrvt2IceGQBlKk=;
 b=klt3+e1g0pZ1kzuxMXPbAdPkY9i4XKqGYmzdQBHCAnRzRU+hyb78Qy4fAvVZt+9wtaapgoE4wO7xX0gVSenDT0w+FHOmBzR9SN6bZrFVVwjf5LrpLUEXtlYMbeQKHafodivFNYSAClKE/B7nb74mr79c4Sfx8a86UDaMQN8OQ4GVlH7OamEzSBOkgBa6fBDbCNrGJ3NlmJhOO3a+0Lemq9KSSu2dxr4AqIZ3Fj3vofPPREyK0c+B/pHxxWjqKBKkeCflvJ9u2MkHeL/v55cT+ky0zXjwplZB7i7V1huo1a0aEB/ZatBbzFKb4kFrveQZ7gOWx2fDuJ+agQI4/akCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYmxut7514DkHGP1hC7LqCbp5TlWPtrvt2IceGQBlKk=;
 b=IBiTEVS16vbOsH6sonfToSjYQRv1ReGB3KwQ+CFTc0CQp/Lr6newN3pQw3mWfepOWyrxbuF1flmFRUSpZaeotIYqsAmerWU5K8xgLxBagsw4tiDhGTXoNo8WW30fP3gfZUCZIGtvefW65kUzQtztJIm/WyQqLUW0PEYJ7MxWpBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 22:31:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 22:31:28 +0000
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
Subject: [PATCH 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and expander gpio pcal6524
Date: Mon, 17 Jun 2024 18:30:59 -0400
Message-Id: <20240617223100.1539796-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 200dbb7e-a28f-4535-e676-08dc8f1d3aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|52116011|366013|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S9e4Gs+da/VPRvCrhtmOzuxCgD/m2LqCZy20NcS7oRWb0u5bRfusnHsdVbim?=
 =?us-ascii?Q?Uk+tH7Fo1LWT1R0hc6MlM/TtDxrthUC1qxjrbi/VV1quYb+BqLguvXj/uPZF?=
 =?us-ascii?Q?M1kHX2ROZiOwx5uwpfMpJ4jfYuVuAMlFvGVJJ3OXYKyfFOWDzRbuBx5JeowS?=
 =?us-ascii?Q?NEiZ4dfhdXjgud9w9lMySYfgl1PPrUl5BeN0qcVou4Adh+e4AsEBRbyWfqh/?=
 =?us-ascii?Q?DP+750OL00mVIKK9L9HDI9HGKuZ4n54T0a0JxVkniuk2iqIKvpHr1NDEUdLS?=
 =?us-ascii?Q?a++im8zJKC3+k0Pe3GdLOBOffR94/WQwuDAVhr0nbfxko1alsiaX5lDvLSws?=
 =?us-ascii?Q?M4VfL0faGGlL3ubXrSuVhzVmdZt9c1j3wjFNYku5HQI3fv+2bOU7J6TbEArz?=
 =?us-ascii?Q?s4LCbz9jVB9yqjhqtZeTTdlgrFMhrV4ES8hiuX9f+5v89ONDW4Yp7m9D7pZ2?=
 =?us-ascii?Q?lEQbsxu3Zbt2Fe2raKrs4gAEw1tJ3EG8XzW7NUyrL37xNFF0nIXaq+kGjhjv?=
 =?us-ascii?Q?yzqZadn6Fhf2KkMOK/YZxiTbawm0wRCfl3/HIDsTHXZSZG4yqKqesNsZHKp0?=
 =?us-ascii?Q?A4qAoJ0+8yw5tWRWLPVRuDPXL3qFjyxL/8+Kk46hPTmS1n6yktOf5tZ613bd?=
 =?us-ascii?Q?m1jiv/96/CkMO2SO2vcg1dHvV8f41dOr5OfYrPBYJY+qTsiWc8CAIfr8efLe?=
 =?us-ascii?Q?XWXYbJO2KAY8XSHvn7iLJQTie+oWjIeXPbYbKYGwfdqehfzQiCGaZGHlpWbT?=
 =?us-ascii?Q?TH68pk5ur4pqye7Yz24FSuepDxcJOhj7c9G2gZ3uLLcIX0/sfVVLLUzP1jOO?=
 =?us-ascii?Q?ET+bLSqcin2PxZwjMMFolZhTU4SNO0tw+OQ7aAdUFScAc2HdXQFavlxmQepi?=
 =?us-ascii?Q?ZDHBoFkzxGSED3oJZPJh/zv34RI5Lvqt9y79VIlsrxhqKn9U+xo5E86jX6zu?=
 =?us-ascii?Q?9EHCxTPn9TBcXanVxceTzsU1xp2caTICEgX8SuV0Cp0sTHCTbdozVcBgO2P8?=
 =?us-ascii?Q?k4MtsREwHhGZ3FKRn+IluWukRwel5NUZoS0BOH0XY6Rv4GxEVgzSbOpSkUqt?=
 =?us-ascii?Q?kdbcRWHhsAbIM0Gg5o+fNIt+tMXK8fJTH1nffQCsefZG9weOYTmTc/hgWeWO?=
 =?us-ascii?Q?rxPkzTLu26QmpZh5taihJo4ExxHzjnkyyTWE2R2HxPQoozwdlgI7AGBTjtlW?=
 =?us-ascii?Q?xnfF5iDwnlndCqhxZl4ljtzjj7uRwqgLoceyXeiNrjEoJBR8YyRlWBaR8op6?=
 =?us-ascii?Q?SWrzKMVGA5mObRVXRadR0KSIMwfVvbYUbDQM2Kno1giEiljjxWnhRUwZU/Dq?=
 =?us-ascii?Q?qvB7+kspegU4ZKo61Pj/etWe//FRHRQd1MoZDkHwDDx6Z06EpX6FTXK/hpYi?=
 =?us-ascii?Q?DbgFsQ0MuIfuCAc0uQibvBIs2bCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(52116011)(366013)(376011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+JMXAtbkoE/363IA1xkCLh1OyCRIkWOiGRIo/auWsiRd+FyDmkYxDdwKbg+p?=
 =?us-ascii?Q?wLZkVXnX6ImrT4Z0BOi4p1AoYumTdvzuJarWKw/Uf1uhUQOqPt+thUuRN8Mz?=
 =?us-ascii?Q?v3w09olNVALF633OL8ckjI3ymn5RBCw/g1F6iCsHgWWstZFb+UfN7QqSWona?=
 =?us-ascii?Q?3iXlzgGhueTugJps4kg1XPme9hMxIxEMu6q69FrHNww3zKpoyOTKl/r0X2zY?=
 =?us-ascii?Q?jJ5ZEtr56/lGnLgqwkn8uoHBKR8MfXRhbNpzypg8hYjaCk4ZZKfQE+AA0slx?=
 =?us-ascii?Q?qnZWMe6zlzuRvqUXJlL+cPt+ROxUFCP9S8h9kEUiGJWxd8IItjCap/i9g+f3?=
 =?us-ascii?Q?2hN7wz1qBE1WJ0+tmjKflD2lkyTBPqWZIU1GCOtMgszsp3omKpTc1pc4UaoC?=
 =?us-ascii?Q?HU5HaSBGPzrqQnaV63Iy6mRdZK1yf5r2Te8mvBMYL5KqxCD47PhjaQHip5x9?=
 =?us-ascii?Q?3YatZEmQvAZRAzBibnJtX2zkBdfv+0DL7M1G3ZCE4K4SJd4A0sXW+gCqo1Ko?=
 =?us-ascii?Q?b+YBN7M6wRwB5mmlTyKmdjTZknRsZTbJqyEr8VojIQ+G2wds1PGtx6UIHMM7?=
 =?us-ascii?Q?+RcRf8zxYAhMIOR5io5AbdDfaCxJJ6ofR1guwNsc/uD0MnRTjgMy+BIvAiP4?=
 =?us-ascii?Q?LXtLk08UoEk8pDseBraAADAZlseI9WNROk8SCDEh7E4ISg608Qrf7HkB3pfn?=
 =?us-ascii?Q?dPVK9nI2CcIXW2AWS1d7784w7wQ/YrL1PntiFrbJZUa5j+ScTJXlaW6Gm3aO?=
 =?us-ascii?Q?THHroKPAxCLAkGSrLXqozo15JEkZqwqSSeXtv8fa0KPYwriAtZ73fgKPV7VW?=
 =?us-ascii?Q?mLcDz/1Ee0lpe4iVR6oJx2fcqcOz0KG7PK924x8VOiMjATTVufHNaJ/I1ePw?=
 =?us-ascii?Q?57C92l9l9h4mK9PZtf39ZTgGKd/pPZsrZM2iJDXHszl3L8ZLOeAk7nhH9FDL?=
 =?us-ascii?Q?0hT6OG4NY4r+nw60UAzVMgz0STtLaxZerG2p5gxZq6pwjCVTlagsiPkWa3MJ?=
 =?us-ascii?Q?gXnQueII9UWBDx9c6yRY8IwfSCihMzdfqZV1il/KlXkkmxL1KUppLoxV5ZdS?=
 =?us-ascii?Q?FY6GhWlXT3Qb3f22jZnWR1GcEGsoP3WBqthshe+DLOklYiK5V/FBW8knf1Ay?=
 =?us-ascii?Q?lTn9TOf1CHSOPtjHHB5Yv5+oHvyYXaAmX//aKOiEWlmS2oQSBJByUVEJfQe8?=
 =?us-ascii?Q?icdD65334VBhGGjOVvxNFBzgX2R5Y6GKo/L3wKJxB78xft1SBWcVjFkERuq7?=
 =?us-ascii?Q?cYgfo25cD5oGJWR7z9w+7JKYp0H1uk2fMK9E1B7XXThjyRztmFz8sqXx67WX?=
 =?us-ascii?Q?56K5HA70KSTMkiy0nNprIf5VGHt+fUSs22fCEg/D7p8WRStv9SN5lWiPEeck?=
 =?us-ascii?Q?TZ/4JLk2fmRAV7W7ly8eh/02H5r6/sMkXfu2g7aF5KXg5c9WKjCIo6lEKGbH?=
 =?us-ascii?Q?Qa+5xMLpW7boVc2FoadVp4aAzVBMa005DhBQLCCxlD4rZu+X0kPGoAj12+hQ?=
 =?us-ascii?Q?X4TUPtPPwSY3O7hnwjmaLAOUXEnaxnQUzKV/f0Vh8n7VA/197jMEXwafb8jQ?=
 =?us-ascii?Q?CmSOmcm38zM5/GzuAZmbP+NaVVI8E0XPNkrBR+X0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200dbb7e-a28f-4535-e676-08dc8f1d3aea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:31:28.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6d+ichqh7tmwKTlUOBdGevsoO+ogPoZ3OZQP9zsSsWObfCV8L2DZbjpNKNT08RkSweQI+tkBA+NsfI0qktGOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

Add lpi2c7 and expander gpio pcal6524.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 675abb70aa18d..636907c852e78 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -53,6 +53,27 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&lpi2c7 {
+	clock-frequency = <1000000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	pinctrl-1 = <&pinctrl_lpi2c7>;
+	status = "okay";
+
+	i2c7_pcal6524: i2c7-gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c7_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &lpuart1 {
 	/* console */
 	pinctrl-names = "default";
@@ -95,6 +116,19 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e
+		>;
+	};
+
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO09__LPI2C7_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
-- 
2.34.1



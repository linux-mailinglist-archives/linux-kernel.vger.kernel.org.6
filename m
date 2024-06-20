Return-Path: <linux-kernel+bounces-223014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A9910BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566E31C249E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E61B3F09;
	Thu, 20 Jun 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cd8tigtX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0591B3735;
	Thu, 20 Jun 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900210; cv=fail; b=eZrdNgzJ5kSNHDEglXMmqXtTFw8ZTE9Mh7oLJmF87e6VKNinb67vAl6U7MZyjRAc8SiTqFzbNNbqD5aPg3oIQ+6feWZtr9xqKr5pSkKpDzoNgXCGafM9px3r9wO2akd3i79gGEfxvM7YWhCjZYkgPerGhAaJFKUEPhD6b1T2bqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900210; c=relaxed/simple;
	bh=Itmy/bUkD6l2DHzODJwkCDfWBFaYBu75X3Sc5izBZhE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAQ0YO0WF1a4pxyVNU9LdLhCwViYMPLEWqEcVkuIfonxJ/luPJZ7Z3W6FXjwcB3Hm+ZYH6+8X38ojLmHXnNDT3XoXlUs0CV+WUrKv1LqpF/aLIjpoQKc90+a+IhXswHB6j0/QL+G73jrtrPPb63IyE/bptdSEbnCEJOkSIFLGaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cd8tigtX; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFLSYYDsVgDVjDidSNivv5kAabOVme1M9CU9i+bToCwiXnyd20mg39MlNq4jrbKMSigiTm3rhmYwb4sxVVkvVwPCNBFUTWSJxSAnDZiLNfTX0GSDo0kvNG3slhHnjuYD/jFY4so61kRb21igova0EFaorREGHwv6s5L8P+Rj93CMFOcpmnhIXtuXRY10VxtaWBurlWcZl/GFPTKEMVshkiPQNOLVGk02iZPDNqyMYRGnt/R8DwwmI7qg094jKkf9N5pGcXiN3HVRUnXl/YWPAot6ITShLmaf9WK1XDPyi343LCxW0Yp+E6LDWgZE/9kigbOHE6j38fIPg+7+acCCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrKCcbgvJ889xlBaONJ5CMggN7dBBOyYruN+q4CkMdI=;
 b=YbNt3TbJAbs8cFeTqKyLOk+DpmdLJMyOjFGzLbDtlhVBQJtlftm9VDeemBW7x1b7P3BSHJCaVM4X2CEBhaE0OhBrrm7Xhh1ujlCL/p27uq08WxrsL2Mj3CneR2PEInCDIyiREcxHj2eQSl3y/Mk/YqKAvz4gg5Q2yTVUceatMcVB1tXSw750kj2zJg65Qja7tQ4hV5c3E3k5cpDVMp5+bEE28+RaxW2evm1nYMnihXC59C1EcliawicAAtdZPnXhUtRZTFzUlXHQXYoq8g+sqoBHboABwe8jqhe16kFv2yQHLCHCOkKo3DTS0H4XWk4zzboBxJx226o+ROYRM3HtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrKCcbgvJ889xlBaONJ5CMggN7dBBOyYruN+q4CkMdI=;
 b=Cd8tigtXmpqganQNjPxTNd/xm5NGjR4D0NtbjRaNGrWIaZjSuOnUV7vWPo5P8M947rGqMU146eAas01Z7R0fhto6xb2h+pxAnDi/29ZVYDsIPAwNyB1kyewBcnbobQb3KtOFV4hOKlA53CB4La4CtRD1hQLcFtwdSTm5Pc5JcP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:16:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:16:44 +0000
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
Subject: [PATCH v2 3/4] arm64: dts: imx95-19x19-evk: add lpi2c7 and expander gpio pcal6524
Date: Thu, 20 Jun 2024 12:16:21 -0400
Message-Id: <20240620161622.3986692-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d8fd4b1-25a7-4057-16be-08dc9144608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zsyhb7Wzk90HXs6jJueM5Rg3uWEU73Drq1D36Ke54n1/Kqj7nBK3GubjH7wE?=
 =?us-ascii?Q?WFTiXH65CuBhhznqSuxHVazBYOEiHpMU3LSBbn5Kf3wAfhHQ8575A810cujk?=
 =?us-ascii?Q?/fo/CNMx2jUV4RIt3h0ui+TWCJff/eKyz3fIxYJZLbS4uyiYpPilJXwp4GOI?=
 =?us-ascii?Q?6V/qClCUiR/GFy9xKJ4Sst0+vZZO6SBVYX1p9mecSGuvBSOupc06zdDMsFLD?=
 =?us-ascii?Q?KC9plEver3JunTAhx1iU6QnBZKual4BPNQegToJAGxnlQAm4ox3jwk7bNtBH?=
 =?us-ascii?Q?ATIuVSfExm3UGPjSiN/MJuSVxJ4vysqlkMExKWJbQ2LZGdAMByPIWq7cKn2s?=
 =?us-ascii?Q?CAMs+3RZOAX0RyNdLCNgbIYDEsm3EXWbLrmVcqighNK7YN+Hnu/aij4RXynU?=
 =?us-ascii?Q?UYtJtvlG8oFnwlAifatPUuG+0zJ8nSeRtr5cj3wPyRi/sVRSJkyVfhORoMUE?=
 =?us-ascii?Q?x7cP/zPhXHtuRYYiLxdLIRsx1scabkPaDmU896NJQPQGABHnOAl4oKFCSsZd?=
 =?us-ascii?Q?onl2xzOCNm/xI86i/gsg45bl027/yVuYoxokEWFfLpgYRvdxlgvauYATlxgb?=
 =?us-ascii?Q?+N0AVbjzgtcZUgUlyqiIDduurX1X867R9KyWT7YEFu3qoilkdYNAliqlXnNM?=
 =?us-ascii?Q?+xfAt7g11qqURCfa5YYZ+fY+fpMETkbKqS7H+R4d76ulE5BFQzZ1B9PN4IUZ?=
 =?us-ascii?Q?viI3CPxhkyH37fIXYYPD7QSF+47It5Nwby0ZIMICgRsYkSACD0tYan0Le8vz?=
 =?us-ascii?Q?0esx4XHqxMuUJain6Ft8h1N0fQ3k+1yZOc2kbcIK7W8cODfVFg+cP+9a7TvX?=
 =?us-ascii?Q?Lv8lfHn72ipFHACvfIctpDi3fdJLGdolBKAgnRVoYe45QqXAYUgR1R53Ua2Q?=
 =?us-ascii?Q?TDcTcdPCPsis8xh2iTD7DfPmZKiyDxWl4/yqHFFt569ouFBOhPkbDnUZL00h?=
 =?us-ascii?Q?jjP+cGJg8RwBNJibEW/EwZiKCRpCFaHaFBYi6V6S92/V5kXckwUQVMPOwS24?=
 =?us-ascii?Q?1sKEyQnFh8W/RZjvHMTbPm+4AUHD23GuBuzdfMvHWyykL9lYubz9oO3IGWjN?=
 =?us-ascii?Q?Z4Qh0sA7/uOojl0ORwI7usi3WsFJ7zU9VrKIhhDMbUj0CWB6fGht5HLyASOf?=
 =?us-ascii?Q?+S8JAhsgUhv3a5gnzNiLo7URl0zo3Cc3pr0PqxEUnSwXuc6VpTOEhcCDc9I1?=
 =?us-ascii?Q?2fMiqL98AUMuoC2tJOImiLUR513MdHl9cpTEf73ucpINLVVCQNgY4vw/dvrz?=
 =?us-ascii?Q?lACShUBD5NSJ1EH1+S4J2QjiHPIXVsM6jSkBL7dvx6JDaOrQkEwBaiZXiGqG?=
 =?us-ascii?Q?l6kqYNbIyVvjgXOCFn9Ojn1rxX+qFjUQRFXEAHC5Agf2U4chc4xCt1DI1I93?=
 =?us-ascii?Q?zRNQ8lOm/aYWM7s4K5NIwm++0h5e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sF+tpV6UEm5OPC83XirSRt7ZV+9h+gl7zeM5V0jY7Cdv+xeisGVTxdZe4ZvU?=
 =?us-ascii?Q?m0mjO89sfhB8+aKRDSe40PMqKGcyuU5GOViBOvZLw0AczSxrXuCqd7Lw/iZu?=
 =?us-ascii?Q?o8kffbBiEXPZSREr16Ker1P4KucvdvTWM18V5mYRAgO3S1an2MQZM3THQk5Q?=
 =?us-ascii?Q?0GDfSP0Nqq9K8XM4CTk++vYGdn3RirADiqUnm6f8oNppUmHo+CFcBSZZvuIo?=
 =?us-ascii?Q?gsIi7bLLt5UQYpvb3FJaddn0PRmCTyPHhumluywQs56r9bMxY98vjDqMtsqZ?=
 =?us-ascii?Q?iCFmqwL92JrrWHW+7fP3s/eSHBcTmYJYmy+sZt03UsfGjhAEZeQHhuY4ViM7?=
 =?us-ascii?Q?Dhzcj/PdmFjlO1AT6TVJy1IgtG+leZ8CwYpXD1wNro/Rdhs6b22s7GRfEyNh?=
 =?us-ascii?Q?aFxLM1VWpWHW7vIhgB7tY2Ei+EEi1h0oG8Gefjys8HNb2kMACbU2P7KFel4M?=
 =?us-ascii?Q?sYyn3kuwaveHhHl8bj+2faFjPCUI4gY9xsv1Q3SAsGjaDPnVrd2IBVplzCLO?=
 =?us-ascii?Q?Xh8CY7hXIL9BRHRqmQtEgjkZSaeN6T5pLwC/sYY+BF/c5Q7P39PruA7W5GD5?=
 =?us-ascii?Q?HXHG8KgYz0MAqNaNmUIvnUPHIaiYGyB7S8SaN3WIJmMpKWXc+EPkRdqeUsoh?=
 =?us-ascii?Q?Kzna7GCiNoxA4uO3/186UdyQQoIiMWAcGOoi4a6AbOmW1qCKtFgKTGVhtKkD?=
 =?us-ascii?Q?5X6SkUBNSjh/3xl3G1SN3xX0W/ohtVVB1lqWPgtLb970bYt64tSV21AVc/ih?=
 =?us-ascii?Q?CSWCW3WYLMmSIDlIEFK6r+KcnyBSqPggbn7Y3/BumL5/FoCcIhBrjFuzzH6s?=
 =?us-ascii?Q?hVICMWDjqArp+q/i16srVu0v1/V9bx9DDq/Cs+wneF2aNs30W1X53liXa2Lw?=
 =?us-ascii?Q?pCsIvZ/pF46KVoeObgrcNGNrS9wDxZYEoL7YUUJnnH+wDdc7kwoqDezQYypo?=
 =?us-ascii?Q?4d/YFvVbe/S3j5jL2dSMwoG/yRIjUb161AVEEI06MLD/xsS/nDKugAEbUIRG?=
 =?us-ascii?Q?G9XuctmX/ewJjsFLppSv08TrNtzuD2QyhWqNbGmiEG42/eTIA1uaJDMtOrbl?=
 =?us-ascii?Q?zYQri3dQl40Xc63z9O1XwisZ32W/76OYQ8YjmMSr6du9Ky99kg/yibYxqZwf?=
 =?us-ascii?Q?nK+gVlDbLgQzZ41J8egMk7QK0dnW4dZWQ5mBAz5O2UCjnuMxodVKnQRJguEH?=
 =?us-ascii?Q?1sydLsLMEg1YIk+dN9ylvPe9ej8/hGpUfaZHaRZZOR9Iuee3XCLjxrO2dySl?=
 =?us-ascii?Q?BLwWbYcpaVdCwbMv1gau4kAuC3z+Ok2roZDHcr17cwAGx35WJ21wLYseE4aM?=
 =?us-ascii?Q?khE9Tefxgshx4+AoDUfrEesOZ+6sIrZzWDBaaPVjvwOSQ4E7HkbvwvOtnMtj?=
 =?us-ascii?Q?AL1X4Hduw/cgyOdiy6PO0NBgYZf5/9vy2LUuGiOvzVHUoDCiUmINi85ibeba?=
 =?us-ascii?Q?Mt3XEnFEZ0Tediz6AKNMYZ4aac3QsX5lcLIj/oQVDI4PUeNSW1yUcDMxdsYw?=
 =?us-ascii?Q?mcy9O72/mkn4WN2/p9M/u2pzuHd2nHkJFyM5FsuwRJJBFPsCBXuYADY8p6pH?=
 =?us-ascii?Q?bv3A1OiuxYjlz2Cq9S0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fd4b1-25a7-4057-16be-08dc9144608a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:44.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WARaZ5IuKha401zIKKcqY+2PbqwgdC7enAAJA9lT1CgNRaqwvt1u6HdIT1O4nWl0yYHPvUYon2CEkXQw1OXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

Add lpi2c7 and expander gpio pcal6524.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove "sleep" pinctrl for i2c
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 675abb70aa18d..750a5255b57ce 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -53,6 +53,26 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&lpi2c7 {
+	clock-frequency = <1000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
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
@@ -95,6 +115,19 @@ &wdog3 {
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



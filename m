Return-Path: <linux-kernel+bounces-223013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F05910BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128691C23593
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938FB1B373E;
	Thu, 20 Jun 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHK1mdu2"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF61B14F8;
	Thu, 20 Jun 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900207; cv=fail; b=tEtsx2V8Oy2CaSwpBEQC5CJyFvNeK5tFpWst3Mnf9s2rVpFu4UmsMhwMGiwav/VwlZ/vOzEzmz01DiP3KahmnN+I8teI+Btn+Y5neA6V3y2Cv3mOfY961XgckVzf/8rIMfhw6QKZhNU4E3Hgu8TSAy0gWbwAm1E8hFjMiMlsGH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900207; c=relaxed/simple;
	bh=ITlQLZQ+TQlCLweEf7e4yrx8ui2NLdP4HLWAC1d5vX4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XS4gbl2PmxZ/D0KpZYS9KWF7TLjbZbl4/QUuDX7tzojOd95EwKokRPBVEzC69c681W5MOeSakmWOQjCprQs0z41v/LST1a+gRMhcOEjJjkkdCIdXNzaRyWQuEdr1KGUKtHWGL5JygPTHE8i5O3SPZqCRRUCax8LwVT00HB2uDu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IHK1mdu2; arc=fail smtp.client-ip=40.107.15.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlYlP/CNMh55LCPOWSjRME3+rUxOWdZnYF0OlJTUTUwzraq4Z2X5clAkWenvEuNxVYy544xgy4aQzHc04QTd00WAKkL66jymut6wckUpBlIImScAt1DK7G0FQKapjuiam3p52f7N5sdXASPGilqSnuE8+Oi7mruapgWfUte10PVsvw6kl33VGo15Ie2+9FssdawXIx7UQnonyK86jx2KZ8HidvsrLQ9QBL6jS+tugOVPzzUzflKPTiANJTTeH9N8CKRhcHp3JgGF8rFNoMOTizbfiPsJ/cTmkC29VA7rQm8oqya+Fy3YlkhlXAAeIm6OZdL5YRmCzfMH1OVv/BPftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daeXzDV+a30tRYuWk7pXHLY2v9OFKpcygaRSYtWW3ac=;
 b=VCVYp8xfCpj+yaOCBl5nAG/o/EEgDdHZd3ztAqI3pbEV4FhGOWHl8oRwfExTb6SDZOM4otFFC5WsoJkBdhZ5q6wyRwhBegrs7c7nFcLU+/XXa4hCimbE0c0mEzrkngziySXl0ytwfbVWBLoDDIawFzcHtsKIuYJfSFmdlBIzGJHA6+mx8W06Bs6856U/HA63/P2niD+OGp6zJIo14SYovj/kFtstmTFfqx5YzvqKAMEKcmNHtUz3LMl/BTmOPD98oK9wFWQBlhx8nTJP6YWfn6IiAUY8pxDoZEgsu7Rq6JDaGG4rjlGgXMVZzWqF8OgM8ZckJuPMNesOI2Dfm10bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daeXzDV+a30tRYuWk7pXHLY2v9OFKpcygaRSYtWW3ac=;
 b=IHK1mdu2vh6yQcj26iZw8XNGn03MaL5s8MR7Qdv/LmRMtAO3CuW/LoDcXsq916mhYLpmgY30B5loLBLQc0+AReod2Z5TmC0vAQKHrZnXzJoslyHvwukBjPcuJivM3IBqhx0UCjmmUNVLE7WThmI96MWd7mSX6IM4d5MaUgC9R8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:16:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:16:41 +0000
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
Subject: [PATCH v2 2/4] arm64: dts: imx95: add pcie[0,1] and pcie-ep[0,1] support
Date: Thu, 20 Jun 2024 12:16:20 -0400
Message-Id: <20240620161622.3986692-2-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fdb0eb-bf36-4ea8-4d35-08dc91445e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pgVtInd1nqM87PEFHgsW9D+Pgv1a2eXMcX0OPl5S00EJvcJL6Z+frhhHGRT+?=
 =?us-ascii?Q?0SlzfDuArCF9Q0P6SAA2B7EUCnbWcpEVY6zYgiFvPS9RCDMaDtoh/Ht8kALU?=
 =?us-ascii?Q?fywDmFOqwwlhclKnyGd0grR8+i3K4v+A/WvCnR8QoTleMDgxkszFgcLFKjZQ?=
 =?us-ascii?Q?AKQ4x6R8zxY+jyjp8LaVamaYKuaqcZRWDOxuDNFZtnsGZyJ04neg12a5Gxys?=
 =?us-ascii?Q?qVt8FCIvONYd3y7CC012gFgr9RST/3T/DgXBloV7x7hD9FyZRmD+CRa1RmfY?=
 =?us-ascii?Q?WNGw6VkEw8C9vTAZin/rQkd8odQfbSoUlFc4XBrC4yWFBbVeEjiIzpA2BXdB?=
 =?us-ascii?Q?FXB8Ny5mWn31Bz05mrL6I6MTCuBq29XRgApqAfqTeY9gWf182Q1PanrlwebB?=
 =?us-ascii?Q?66TlRZuFTEkJ1BTReuCb1r0avnyd8DOjAtECHP5bqYzSwHhunjbna1UKbFph?=
 =?us-ascii?Q?CCP+gCYkoPAfOZje6QDipP6ZKLpTHyYwctrlbgq/+Gjcz1a8hlAr4mTpzSH/?=
 =?us-ascii?Q?s/l8HlsnZds4LWDp0yxWMdGfv5U264MgAKjLIJEw4FSlwFRP5X8eS9b1pxMA?=
 =?us-ascii?Q?Jq0+dKC9O1mzvNitmRJnSiiMSZTQb0yNUWRHCUgouMX3sjF1/746OXBktKVJ?=
 =?us-ascii?Q?ZUrGKgd/oqT6WbF0qh0Nu+C/kuEim8g4Hp4Xlsp+XcHjWihirVFZofpX0nxX?=
 =?us-ascii?Q?otMxwXOBreNrH1pllIvSnKfEaKC5YI4NR8cWIaj8OQWS9jSfRTR2tfG8DLCI?=
 =?us-ascii?Q?kcxNaOb5j7qnnHfjQBvXYG93K9SBdCLnbB7IhCjgT+B0oUcUzhPtE6Ogw89z?=
 =?us-ascii?Q?evutKCxMHjkcjThF7EsGx2juqrH8jPH/cM9lIzzkxCYULOPAr03Q7sGlN0Se?=
 =?us-ascii?Q?ol9zfFRjJ0rNYEjByFVRwB19KQjCekR6cngAC+Q5Wd3IcNtgHT6IqHR4qf6F?=
 =?us-ascii?Q?wyCmItmrN8x2I6QoYLGH6e4agi5dfTMl04TNpTDHOgTqq0OQNie4wGEbw3HZ?=
 =?us-ascii?Q?JP09JLaz49jyj69fLNDIpVj5hTt4OCH2Zm+V4hCOQ6ugGnBVis7DevIYWfT9?=
 =?us-ascii?Q?BNO5PetCPAlJ7+fztSoS5W5Mch7d/hNaG7HZdiEdb8AXh+GXjrNSgSpyKWmu?=
 =?us-ascii?Q?vgyTBltPi3jOmi3qHeddA72/h9X7P7Imqzm+WfoeSuw+HhUGbMA1sFC/0QHv?=
 =?us-ascii?Q?tNg2Bvst2cm98dzTrKk+ONVnAJud1z2BU0PxMNDhn9KRvzPoZnwJ7rMaDZRv?=
 =?us-ascii?Q?7zZ0IYiZBOvQbW6hhLf5HkkBxG81Wu7HDs/mgavbW7zzwWLmoWLFmS5a0gwr?=
 =?us-ascii?Q?IKk/XTkGvyn5INWlq0rN5v/k464JJKdqHZ0Bb7ntNuLPylDKXco803G2lzhi?=
 =?us-ascii?Q?HoyT1rE3ihJncDTRr7b+aucWyHoG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drcssSuNubbIDR9iKJg+wujfCNnLhyIJT4lQITzBcYlIz50mnvvmvbOhnCM2?=
 =?us-ascii?Q?WoZcS7//Qu+/vJNQxikZSNfZcH8X6++Joj+aslFoZlmX6WOZfUjYwMtNZDqL?=
 =?us-ascii?Q?PvgLZYW+0UZjDMM6mxlvw8/qCajbR8ha4DEEtQptRtuar8wcouO9Q3Pgu+ax?=
 =?us-ascii?Q?hYt/SerP26SLb28DPz9Ak9YI05R85I60yYctuNfezEpjPnQqJFYBW5by2nvj?=
 =?us-ascii?Q?eA1NoktGFX5oKV+0HCvAy3bKLoC5q4+7hy7qeYiTpFqHiB0L5et4KyaWHMGI?=
 =?us-ascii?Q?4PuBM57kWJAbF3SH9n79fCl9+bkD3OoHFDV+kHncqEZ0VTpNBCaPEOOmivWT?=
 =?us-ascii?Q?L5nOqfEGicLHNYUa+/HSUs8XhlkD/NMEove91h85hpE8HCLwOiWrKbiuI08L?=
 =?us-ascii?Q?xtsOeQaVVDARGOovl6RCu0uZGeIn6Kd527ELAUwxTfwMMUeAQuPu65xB+MAJ?=
 =?us-ascii?Q?Lb/R+T7GetMdt/PDELdPIBbMQLCv1v8CWGGm3GJ5JJ+4XGKQDJlLLEVvd8Z8?=
 =?us-ascii?Q?yISNEweVHEozCN020bi8J1qpMhuUGv8EwplbfrxcIGdqrM1nBcuynHNu3QsS?=
 =?us-ascii?Q?BDEPpkMwcgPgpXUfMzaeUcj8VkHaP87CsAI2yzAlFdaYWvSyvtOJtr8yWqyv?=
 =?us-ascii?Q?ZDJHFCBj7qJiXunG0+LfZJ0pCqZL4RRqvxsEIZ3apWYZr1cc7tbMHcNWlTg6?=
 =?us-ascii?Q?9bJUt9BR+HuTANc8ar7rKi7zZG6Aqkbj7FxfK0qxlZtUZVUzQrBnR1v15FJj?=
 =?us-ascii?Q?6bPFVLPh0dqLqgwmw2FODd2704OhqJLywjcjbRkUL0Sct5Us3AAHvTuYzi9M?=
 =?us-ascii?Q?BAnHHG3Mtbp4f0mMwKOuwTQ2wLMwiILjkHMDrPpnV83b1uz/oYQlEn3tiUFh?=
 =?us-ascii?Q?7ZbLp12QH8z5rULzuKUJA2dn2FKWDjhA6rOiezd1XGMYpGw++BaG47kTFHPB?=
 =?us-ascii?Q?xlYyi7ymANTznVwbA846DuzpXtJHwdH0hF6Kj5eIcbGGVnXPV6g5GAPCSj0N?=
 =?us-ascii?Q?RJLEzTH70UwV+Uh+xQKXJBuWtB20IGFN2f4OcH/O1F8sVYgLbs8mU6q0+NwY?=
 =?us-ascii?Q?S1hYWHS+rx9Eo1MC2OAzOOwG9NoVQtBcbC7lG2wLiFS8CY4Zj5rFBk7RoKIM?=
 =?us-ascii?Q?d1/pL31Dm/BtwNO6iHw7ts5gnSp3zbgldE6skCJ1GE8tywDVnbXy3I6cZ1Ks?=
 =?us-ascii?Q?EysEzw7D9hY9HI1tRrIVyyNnYD0vlWZ/E/GiSMxQsYsvElCpufREsmjwmMWS?=
 =?us-ascii?Q?a1uryyrrw7gTrGjt1eFH0TeEh00kJJL5qtnlAG01sseER5W2AIyRxp3EzX0P?=
 =?us-ascii?Q?d1ltKaGzLLy1toGw9qQwtjYyDsMQ4SBldzlwxGbQIosS9eKlnFpSuW3nFInK?=
 =?us-ascii?Q?CVV2PSleDtdlKAMLsXhzBOUQM4E/kYYMMlThHK2C8JNnTpWRCGh5+qptv0qO?=
 =?us-ascii?Q?kP+7WZWbahGj3zk7rOybziOtN0LhGy2BkoLe51bsMNqepm0Ui0zac/QWkWfb?=
 =?us-ascii?Q?tO+sb1V9KBqnMtUBb61RauewDXrzDMKcpoAKW7XNMea0lcmnEw77N9CAvh7D?=
 =?us-ascii?Q?V7YXV3uo3X6vuPE8F48=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fdb0eb-bf36-4ea8-4d35-08dc91445e81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:16:41.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4O7662XqwP56Zu+Mcm/+c9hrH77DhKqgjjzAyAWnqc1lBebs8McjwppD3uiDyVtJOlI9WR8FN/qPy0On/IWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230

Add pcie[0,1] and pcie-ep[0,1] support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 134 +++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index cc5e829e76cc5..1bbf9a0468f69 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1054,5 +1054,139 @@ smmu: iommu@490d0000 {
 				status = "disabled";
 			};
 		};
+
+		pcie0: pcie@4c300000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x60100000 0 0xfe00000>,
+			      <0 0x4c360000 0 0x10000>,
+			      <0 0x4c340000 0 0x2000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
+				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie0_ep: pcie-ep@4c300000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c300000 0 0x10000>,
+			      <0 0x4c360000 0 0x1000>,
+			      <0 0x4c320000 0 0x1000>,
+			      <0 0x4c340000 0 0x2000>,
+			      <0 0x4c370000 0 0x10000>,
+			      <0x9 0 1 0>;
+			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			status = "disabled";
+		};
+
+		pcie1: pcie@4c380000 {
+			compatible = "fsl,imx95-pcie";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <8 0x80100000 0 0xfe00000>,
+			      <0 0x4c3e0000 0 0x10000>,
+			      <0 0x4c3c0000 0 0x2000>;
+			reg-names = "dbi", "config", "atu", "app";
+			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
+				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x10000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			linux,pci-domain = <1>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			num-viewport = <8>;
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			fsl,max-link-speed = <3>;
+			status = "disabled";
+		};
+
+		pcie1_ep: pcie-ep@4c380000 {
+			compatible = "fsl,imx95-pcie-ep";
+			reg = <0 0x4c380000 0 0x10000>,
+			      <0 0x4c3e0000 0 0x1000>,
+			      <0 0x4c3a0000 0 0x1000>,
+			      <0 0x4c3c0000 0 0x2000>,
+			      <0 0x4c3f0000 0 0x10000>,
+			      <0xa 0 1 0>;
+			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
+			num-lanes = <1>;
+			interrupts = <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dma";
+			clocks = <&scmi_clk IMX95_CLK_HSIO>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL>,
+				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
+					 <&scmi_clk IMX95_CLK_HSIOPLL>,
+					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
+			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
+			assigned-clock-parents = <0>, <0>,
+						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1



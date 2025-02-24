Return-Path: <linux-kernel+bounces-529640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B570BA42921
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD6442147
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7F725E47D;
	Mon, 24 Feb 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rm4bNI9y"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0D263F5E;
	Mon, 24 Feb 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416892; cv=fail; b=uO9omgYW264DSET9g0/fAuKwVRBHzrd/6JmIQLFs86WQbC+J55DXpkr2upDBpDz9pUW/ESi7uOLuFNdT2AP7IjMiQoiuRxeUokWXN3l/Ca9QChS09pQBa5SqoZlNL3BgZmb+9HoGIA55FVM02n+nFkQtywog4KkJkPpqjJFCNdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416892; c=relaxed/simple;
	bh=9AuGKmwTENAi6OSUZDLPkBw4I7ZjiSVLFv3McpEwQjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YbI7hdD8P1W9tBSl56u0WwmY97+BwqM8YHCQuHZ0Uu1LKKWaou08bS4Ted9KH2p0QmHrS4rgVNbIdIQjg/teuz5fSgMd5USA5jamAyDYeEnxKk4FoVsrNfOhLaM5IcCJf4w38aAu2jOfSA3v1RAZSAx98Zc+MRTInmdVFxipO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rm4bNI9y; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY176L6IFJpy40CXHFaRZGXnfdfox8Zu83mYTzAFbIXMw1rJrht72LjqGPl955J6RaqYZ2YTnz5Fh18+/4zoH6TG1cWZbpMfHybc3FbjI/tCDPmsOu2wXmXQ779r+Oxlxl1JrOCSS+V2J6ly5ZSKpSQ7/WqHUMOp0aluG36F7zd545tIA+wnstBpHjgrVTyq+uSLelgFaT5NOGatjZC10nC+kp7SBzGWQCQy+niNHpK6sgRa9p9YpXMS1hXX4tDnm/lu6sVoibxVLDKIrAf58D0GUq0OKG/4fhLMmGJI3Mm7O8s9jup7XqlY2Adhae1691s7Kt5Rg49Md+plhMwUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX3I9XhWUAW0Xe50FVE9cE1d66q33eXIJUcsa0n7ojA=;
 b=UTKmFyBkyrkrUxhbOe9rT+FEqallwcpVTClZW1Mf7OSdaT+y01C+R12WfTUc93eMmYZgbGuQrsLCLc7cme/pyohohZn5yUFwshjlUFa6IVRPsxY2iUjabbdBLoxterBCU5ra7C1UbCZj/SA+6YSoRA5uDDV/JmOJtkcVK+prol7+Sqcg5fGlIfHHF6zzDQRlEEAFpos1pnMBiY27IDtpRaKjeqFTKzum6Lui/ogcAt/xvJ1fbpEmgBPila4ZCFHnHcmRl5ZuscbhSLgoAsI4XsFmbhWnXXCnUJcSc1xBDBboZW6uii9dbsprby8SdLdOPO6uMujwlu4eMZ1bMVM1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX3I9XhWUAW0Xe50FVE9cE1d66q33eXIJUcsa0n7ojA=;
 b=Rm4bNI9yn6DZfRSv3wrIVtD+9/j6XPfLyBN7wlErBnySARzijr0akuuzrodrSuDhryLjaAWrjMk+F5odAKIB9wh+CDTejKxZLmNP19RC/CtEPbO8+SewNAoCAahzLly+vgVigvXc2ptE/eN4k17o01p8VmaUbnDVrMdjmXVu6mBWfM27twFXb4WQn0pIKfdPFPS2W27q3TOGbHWRx/eMUiynHLiFvUx8BIaZvZTR/7jdizYzevQWelxPgXrdfxV4jVea40FUGOX4InoQGSIhL0lCohV7LwO5KwIYOBVle+RK2PobU0hP+aD6CdSCR+7XHLoFeiQMB+Rtr5TCcSHQbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 17:08:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:08:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH 1/1] arm64: dts: imx95: add ref clock for pcie nodes
Date: Mon, 24 Feb 2025 12:07:51 -0500
Message-Id: <20250224170751.146840-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a07c81-e0b8-4544-8e29-08dd54f5cee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbcjkHMN8MRlk6xBJ1sCGPWpvPEc3BAZ7I5osJ5q8luiQ/oBD0UbNbo1IPkI?=
 =?us-ascii?Q?bpRz0mJ/fKRZA/fOIkx2+uP6xCttLWigXZqM7TffC+paN29pfOcnuMop416H?=
 =?us-ascii?Q?DD2sPj5Ev7JHCe6BNLoP4j7WDc+KQmo0mJGc2ZrsS4S3+MJyTJHLGHq+d00m?=
 =?us-ascii?Q?X2zQtBoNY/nE1hfLYgZnFv+xAespOSQji83ioPClkWvBB5aQ7c7pJOlVI2ow?=
 =?us-ascii?Q?0UGGqc5w30IltYUXMYQlaAMGZLiy1ZfBwKy5pGBc25/JvcGSi+LlxZHY9/wU?=
 =?us-ascii?Q?KJhec/XQW6h1aLnDT+Lf0YJ4+GzNhVcb+ccPZ+1hNDmg9YOoZLAaFXPiwhBP?=
 =?us-ascii?Q?TFIVkXHCJg4e2HaL17jQl1jwM01eWMu3tXmlTuZfRvtHF7cSVO+eBDUEl3vO?=
 =?us-ascii?Q?JSPMyzWJgSwn/drhJyGPT+EPubBSVDE8AbgnCFablayUco8MVKMdMTXAIhk2?=
 =?us-ascii?Q?MbW8G6fT1bSCckEbEt3kmaj1rFQXhDdTrcbYoy+eTg0HS0Z6lRKDAk7a+pbM?=
 =?us-ascii?Q?jdmr4JhEkiqrie00YZUFSGGLdOSDBiUNoD+1TPPFox66vLZeVl1TNn4SFkWf?=
 =?us-ascii?Q?IPG7vFHKov1jeaOYxdkbcSq+fT8m5b0Y+ovDf6f8Lg8oFxo4+kokky+CXvIM?=
 =?us-ascii?Q?tdJW23dFIO6asC7G2z6gTMaIkFzdDhGo6KTTF8PEhd93Kv47GE7e8YoW8CNL?=
 =?us-ascii?Q?WW9WMdJttOygjrBpXKMLWVH0/+/3Ce1sgISyvz+/biMArO5sIKPOtmiGDnSX?=
 =?us-ascii?Q?R8rTmYI6nGTFVrf9RWiiDpBfTjcBQ2C3jDxZ1SX3rixvgZTxNE6nAEuYWRx5?=
 =?us-ascii?Q?ZsViNv54Y9KJ6B6ngYHTIE+8OjrnRJZCIc1JIamJhqWReeS/1wNpEQ7deTCb?=
 =?us-ascii?Q?YrFQVns9rAtRA7SAEqx8LO9Kni5wF7xCA5yVejrgGYrgDfwDHKiq9vshJEFN?=
 =?us-ascii?Q?wlKLuxPjbl+1znpwEr2QKFJq2Ic69eLR7YA4I6Ajdzk++QSXFdNrCyhZePII?=
 =?us-ascii?Q?nhfOmOc+tG0/5z0jpKHXsjzLoxLLHFQj8/HbL8B5MVk2TJTG1cmkEPcHddgY?=
 =?us-ascii?Q?EeOul4V1+RoILivAs+xj0jR/0XaUrZwSG3JcISOG7WnQMpbbdz/lnS9ueTwn?=
 =?us-ascii?Q?aUjV9AsxnGNCLkypLL8tOojCCoTxVRC/VWAffBQX8CDsmf8b7u1SXQ4oosbY?=
 =?us-ascii?Q?xLamdx0ptumdcp8XufKkrM4lH1dJQzpc2BSVbdTdkM8QRArdTNtGyc4QoIi6?=
 =?us-ascii?Q?NFzo4yXacaV+yILdsAa+r1rZy8pJ8OR++ArGeIg2evOxPQwKDFQTu1h2EZaE?=
 =?us-ascii?Q?Lp/cvUPqZJdRC/dl2x3RLe4gLNywdTW4Ibe/+asJiAL6yt1yghXNmg/DHsFw?=
 =?us-ascii?Q?t/5aovw2wEQ4Eb4NyaLHBzWEbWjc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3t0jXrtyvpbqYrC+WlfUJ80/IEfnNXtGBc3gRH89sdx7geAt/aKUW9XjPzR?=
 =?us-ascii?Q?97fgBShD7wvn5n7w4Riy3sDtNrrLTgxPRrU3Zb3ZX8CeGK31NaaAAWKmnor6?=
 =?us-ascii?Q?uWmzov+5vR3C9wSe2bmOIlal8vH6hnCO9TBzUf6/0Su7pER3dCztUwIVB7Mh?=
 =?us-ascii?Q?DZTR6IyyPL1TOcUhGbC2AG1ZDPgmwaEWiFggVM693l+uzHLSa0zoRdlVeYkS?=
 =?us-ascii?Q?OjH4IpyMTfMDHJGQ3Skv2ziUdBRDiRl7wOm97CQoDJzyySJDTX2cjUDpuHnJ?=
 =?us-ascii?Q?UgkqrLxxRVHaLhmVrs+9dRo+7gk5vFcwnMbEzrYHBEN/DOAH//Jh+leQtFj6?=
 =?us-ascii?Q?amue1/SlvcU4KRq7cUTLNI3oYSziyq6ddtQklo4TgCvRXLNIhOTj8o+zk1sd?=
 =?us-ascii?Q?3kHzQ36g8hTZKWXU1OkkbmFwGL5XJ8RImiSSfgsSUP7MsL8JIYog5TbMn4ff?=
 =?us-ascii?Q?tvs7TNRidkkXqMcFU+uINT0z7ITi/8j7lrDqBEv2dXhkazL7s0+rU3PzZP1P?=
 =?us-ascii?Q?FybzU7Pu3RtBB/AU5qq5jQkz5wNq5hBLiP1oLf2BQCKSjMAEsJLLBj49tdlk?=
 =?us-ascii?Q?r1oL8qgpstrrmeoP+huT4/Me1xJDL0LTZXarAGWlzygE8ID2/gZAnlMCVPlj?=
 =?us-ascii?Q?FKTfP4W6UREoz1QXff2MXN+tMzvVAQg1+aEUxicFBR9+Z25qqhgU5LrWI88w?=
 =?us-ascii?Q?hNan68MZxP99xdXQaCccnqDt3Sw++sOmVcoaU+wHPOKGJ4O56US7qMUoRaDw?=
 =?us-ascii?Q?dZAexd3LS47BwqOwT1fvk2i5lnvXVNTvp2juiX6tpNTI5xHZCvGvb1aiTgJ+?=
 =?us-ascii?Q?nhLVwkoM1R7U2XzSedVXmHhsAjzTLLFv7hkdZABqngpoVgyvtmcFWs3PlwJD?=
 =?us-ascii?Q?L4V+nM+GU32xJP0VYHiZXTTRP8ChR/G6Oc/Y11g6InF3HA6F7r/56VlhAiqp?=
 =?us-ascii?Q?UOVN8u03TpiqQ+0YZ1Ebsppm6FCdTUSmUnDrWGwZJDXA9KZJ+ExXWI3chkHX?=
 =?us-ascii?Q?rdvNBkXsKoFxjJb7k/OBGZVI9Z/KUaQv5fznSh8iAM7R4etHRlJ6i16gPaO8?=
 =?us-ascii?Q?c4kVOU+nQGooDICjJU2OuS3Lhb1jyXtnG4r2bhmKhIpiaE06CrboyAlvrpwz?=
 =?us-ascii?Q?WhJVmFPpULL1PS0MpM1mQP+tMmPUo7/cgZFgcfQqz0SjDxC7PExmQa6/EMwC?=
 =?us-ascii?Q?dGZUNkkOB4jk4BZM/buSI5kUHWuDvsPOqaEqL0qzAfhDS5dAbrROi5Acmbi8?=
 =?us-ascii?Q?rerUJ3q9BeK89LQAzhfRSfiooYJk7VnW5u+CCr88jbVuBjhncpDFLe/PZWiv?=
 =?us-ascii?Q?tuHLHf946ZF2kRfOGvcwODpT8ZRX8e1m2HLRGm7VJrh3rUXOJbIdJPjcKRMU?=
 =?us-ascii?Q?MZc1xQ2JFNC0OdZ5m6FtndOMnyYzdUillU7ESuwqtxDl0WQEoSGw91IanegN?=
 =?us-ascii?Q?uyDWC6fk+CpvBzFxGUiLEDR5UQQvLKcqcJA9s5QEFSizUY3v+o2/Vqb22sf4?=
 =?us-ascii?Q?v9jNx3jMzddzjgduD60gt4v+7B0n5kMnxKME1XN3pVr8l1m5+qu3rEFkWawX?=
 =?us-ascii?Q?olGXLafrAIyzQQJ1yehjMsUEM7reD1awEavVJb9S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a07c81-e0b8-4544-8e29-08dd54f5cee4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:08:07.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTiHVCEkhDkCkS5+qKUGkpbv+cEEB0iRl6RTTLEk8SVLu1yVeU+VtNTfadQliFVw6ixMo1cGtnBT1pHeVPAKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890

Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 51625bc9154ec..5800a381036bc 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -291,6 +291,13 @@ sai5_mclk: clock-sai-mclk5 {
 		clock-output-names = "sai5_mclk";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	osc_24m: clock-24m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1595,6 +1602,14 @@ usb3_dwc3: usb@4c100000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x1>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+		};
+
 		usb3_phy: phy@4c1f0040 {
 			compatible = "fsl,imx95-usb-phy", "fsl,imx8mp-usb-phy";
 			reg = <0x0 0x4c1f0040 0x0 0x40>,
@@ -1633,8 +1648,9 @@ pcie0: pcie@4c300000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
@@ -1706,8 +1722,9 @@ pcie1: pcie@4c380000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-- 
2.34.1



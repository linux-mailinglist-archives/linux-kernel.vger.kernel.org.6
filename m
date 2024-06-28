Return-Path: <linux-kernel+bounces-234016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC191C0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BB6B2279C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CDB1BE843;
	Fri, 28 Jun 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L3PLx7wQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6381C0048;
	Fri, 28 Jun 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584913; cv=fail; b=dMsANo35U5Ajki7H8l9XQoDQ0RPszRz4huCfzZ4Wdkx+hk9/zz6981fBUYzlt5tJmbRVKlLoJGoKfB3H2Ctk/THwpLzDmRU5P85CPc4SxHj/dQJQbr27uprwS/DwRt8bRB+ea/baUBIDG4xiDUtCHhp00gEsudMAjzXr7NWPKSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584913; c=relaxed/simple;
	bh=tWrOuUVwqvZ5d7kzzA8R63L4Zux2TjBWYxGu3VEflZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LtfjEs3NLC9mV/gGQRrpujrhC5CSWhHmMh6cpn+PHVw9tsIkUWnodpi9RGJ/xHwha0auVynf9wt1avTgmALAB4UCPt/pOyjj3yO2PdQOxARMpfy9Mwlo8Ipic4YU9Ue9Ft5OHVkCp3HCR9ERbkWUWBUfLFu/ttSEB0e1gpko4wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L3PLx7wQ; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ/0DuNrDm8dQ0hTx34JdJMr1lCt4gu1gR8/wXwdk80NgZdZJZwMb8bwuIfopxID5aOnZ8cSNB1NqNrEeqqe08TIiSeXv3CD+mkas6o10Hg8UP/wdvrtKsw/ztwC/0WmViDhnivSHP2d9HdYsWuAr8dQlklewgY/T13IZ6EIhcXnS/kXgNLTcvpPiKah8l/pbqOmwD6yJnJD986EvmdSZQ6rcmlw8Wz9xdPfifI3xWFuPi5+GnJwNm3d8Z+QjYZDf6oXOSDYkvpNKaBX519TwK24zPrJqHQBJQa5PouH0gRcdVdx9a4tUp+MDdk7KbbuNdi4mGoyTxBGBML2Pq7pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta+tNdtCyaw73tZVmguZt9MLnPgvqHctekMydrimyMM=;
 b=lIHJxPmsf2zVHALHqgAKlepFICd3qNxyH6jVKqjx81tL3hD7hQH6o0MbCH2dt/6e+XCUoJsehvlZWCQTizTpMPF20Oppj0a0i6im8xm4V+V7Kmp7Kx5Ca+Keep82uoeMuyZqXhrN0BuU+6Ts0gwUZf3eDpLJ8Ut75iDi08YogyZIGLrHdmogAmg0iE09JV/XGPQ9CYCLxHqO+g2KvZo3cX/5Cxwpa8zh7AfJ/Mr0bo8qtQKPi9YWAMSCMrK8H1mG2Vpa7viW//ZhY9DjZddGEvAzh783477YrRR42xuJwmximgzbSzq6YD2dPOgLlDWiKkOIQRKyV9QipNohS9rSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta+tNdtCyaw73tZVmguZt9MLnPgvqHctekMydrimyMM=;
 b=L3PLx7wQuHZNvLfO4NcLpSVcvZFffK1T0chbTIMDtsvWrmn/y9eGmLxbr/TzkH3LoHmtSYwb4ZQlqG6aTDp0IDB/Cm2QJw1wO08Woy/kJ8vZlID9yCDoP2Z8oI6SedPAEbiQVD/s26w1ltCEm6U104xLrt8Uoh0nWfN5/8AXRDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 14:28:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:28:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/3] arm64: dts: layerscape: rename rcpm as wakeup-control from power-control
Date: Fri, 28 Jun 2024 10:28:07 -0400
Message-Id: <20240628142809.2327824-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628142809.2327824-1-Frank.Li@nxp.com>
References: <20240628142809.2327824-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:60::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: e80c2541-80db-490e-0c73-08dc977e9460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBv690wQuMDHd/myKr22amOFutno+vqgJY/O9rSfqQTrPX878dTS+/To9+AG?=
 =?us-ascii?Q?ggE7mT/i6d8QvHMTqlGpUbZFiJtupGWCnTCa+uE7DvnskvAY1LLgzeHtYlpP?=
 =?us-ascii?Q?q8j8qiReWBvBZWF1J0jAXEafm5eTIwpd/K2OcZ7IhEWuhJje+W+KHFmAaW0f?=
 =?us-ascii?Q?MPxd1tL2O21MlvnwCTAqMD8V7czJ7yHaA2rSAA3rW5NEFCvmm9PM/TXW3K+R?=
 =?us-ascii?Q?WTB5sNsQi5302bpCkrEV55Y0ElRg6CTUPueU+EJ9r/mD7A42t5kZLYEXLXMl?=
 =?us-ascii?Q?trxIGqTK1Y75XuDpqfb9k+SN8Sv4sgJAR5aM5eITEJIWni1kH9h+DJw7qVli?=
 =?us-ascii?Q?/H8b7QDPRWXP2fYWHqbJca/tog8S+x2ShAX/+0nT91JB2w1Jl8GRlq07Ood7?=
 =?us-ascii?Q?wFeCgJfa2Kv/Di5RLlaUivn5Ol+n+W08dgvQxMIs27qvd0WmjWFyXCkLa1QT?=
 =?us-ascii?Q?UzFavzTZ9HI3dS6DuWlh354zMce8jmEZTTgMO7X/87GpRIXFTW14i+MelHUj?=
 =?us-ascii?Q?aim8t1lWJJxlFBWYRcczL77rpd79yo6ydRYpcTqMDOtSQGQlcnWYbELc4+zs?=
 =?us-ascii?Q?FFa52SPWykisQ5JhBLxbBwJhzNP81MwIRHJNwd0KKeQHh4WkOZOFCNYfVK3M?=
 =?us-ascii?Q?O3K1mei7d22ARNyT7VElW6i1KEpiG2+f0P7jiv33IPwNy5c0GGBdwCS40uMP?=
 =?us-ascii?Q?qYSOcOcL5zu+Ot5pkzdSfHA03Hx8mSN/dIKGu5Pc2FGshpZvqB1KSdk6uqLq?=
 =?us-ascii?Q?2H23g+Vk/aXlU5aeJZNbwIOqkhCeaM/IV2GvHt7zVCJisOp4tAa9MxViPMTZ?=
 =?us-ascii?Q?cdx6oAYNJoKJqwC835m5k+aLWh9rOEYW3Izk3xLROHFhC4EIeR93T/4AMxVg?=
 =?us-ascii?Q?BYY1e1A0MR1HqJJVK2M2ngkKQTA1fuBfsWJytqjMRXGz4MP/l+X+EyLsllpP?=
 =?us-ascii?Q?CIAD+vupeU966hRsUzIODm3lZrxE4ulxNSQiF/McJp1WPNbkKqYH+IrwZXcM?=
 =?us-ascii?Q?587hBYKGBYQ48ArSodR5+wzAe0dtMNee+CAwBANwzPI7dHP5G5vCsN1xT7pu?=
 =?us-ascii?Q?m5mnXKgc3cqmNs4U7LLQt+AW59dKd2CSo1Cjv59j0smL3AP/Tg+/zT2CgH28?=
 =?us-ascii?Q?jkHHEx3yEFN8UzfgqR5n8EiMxF22tJYU9KEzi1B2OdGYTdgJic0Ks/TUh2bK?=
 =?us-ascii?Q?75AKkVd3xwfUSSMu86pv2OY3veKvmGeXKOKQDW2AdxGw4b1tYmxslbGpvbC5?=
 =?us-ascii?Q?vFN44BKgEGbl11vWhUuEWmt8s0X6eYTT7oWh7XBCp/74rYy6mLhq1hQcEJau?=
 =?us-ascii?Q?YdsORVFQMgYvH8aPnC3PMEIl6wxnHytWdjVsI6TCBtBRwf8SEfG+H/cSgl0V?=
 =?us-ascii?Q?0xSo6ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?28JFne7kbtUJ905Xm9EULb0n+YWILZk9S+nPBPqShHBP9/kaDz/5wZWsQWRT?=
 =?us-ascii?Q?tJKeFi7Qggz3Z/1+Fxr9yTq2hvJUDVoHRDAA0oGe7lfmbvgNBq665ns+VeMo?=
 =?us-ascii?Q?acEU3dYsNKpbrU4MB2OVNpFOz7zALuzwXiXgzT/J/EnXPCTN1QRLRbUTVoEV?=
 =?us-ascii?Q?ET5Wh+fjOrU30xLd8lFdd0L5XYNgswv5/k/ldOwa59qAjUg6/9KT/P4VKSMd?=
 =?us-ascii?Q?A0B9yfB4HxHL1IN6l3Qp4uL5WbI1fvnslqBU549xo7fhNIzyXE6jHTWnsFlb?=
 =?us-ascii?Q?L+HB3TYCwWu/ptxnRZU2j4G+cKgOhnrWt6vCmBHY5DkUbnQ0FshPdH0ilX9M?=
 =?us-ascii?Q?1Yf8biUvyXWCaO1XIpePJGcVWbUd1u/UhEOmJ+ssVwTfwdTLnxqx8X3SBtQb?=
 =?us-ascii?Q?xxkJSJo25tfBIbOIg8TzoJP+5nkR1VnXF89VYijD65qSqfTsckEVwBCLDJGM?=
 =?us-ascii?Q?phlsOGUX/hYWNxSTst0nBQ5O3cOLR4i0j2vxI/bNDm0ZaJldcamLfKn64hSx?=
 =?us-ascii?Q?DaAvv8ptNfa/zWzn4AvZLXJ/v+S+ddEJoWUGi4SxzFjeN/nFRKEy22fRmnb5?=
 =?us-ascii?Q?gz4zbg0eTnYcAF3brG9EreVuGc3oTzmpQMFDjeLwXio3wBlZZ59CD81WVqNL?=
 =?us-ascii?Q?5btw2fr6msRBimU9kwNfN++cff68BqFfQt4Aa0PK1xP7Zh6HB0ogp1Tmx9Tp?=
 =?us-ascii?Q?c8HXVI0jnvzD1UEn2E+HjYKwJcNqrSwhUjWwO6Z0ppvNmOnCCJbn4SD+I+VS?=
 =?us-ascii?Q?qKPzzCfJU2OHwr5t5tEdPms9YTqYhsY6OvRWTjNwqkKJT4Hki1RXaCYe8ML+?=
 =?us-ascii?Q?ahjiU/xpIcr6mpnMVZ9J0oc/eEOXYxb1MAvo9EERwv1rD0EF+O1U5NnJW+u/?=
 =?us-ascii?Q?/WHiCXG/8Pq0SC0SJ2HrINiqTVvC3wODv/fk+66HcgvS0lDvAIh+D1Cm5aso?=
 =?us-ascii?Q?9OVnA8z0c7Xk27CefiIsaUIgUrbCT5amQUHUIRhuTol/G96OttJRC31JAgIV?=
 =?us-ascii?Q?eTEnx6Tj7nqGOqE3MnlTX7UUaI/QladMVGnB6RREjMYgUlbf7tCaB8s1y0RV?=
 =?us-ascii?Q?zOlylUgZ4mnDtfyKlybhC673DMAo+AAOW3PN6qDyYmnXeNaqerKlkfNi2nHZ?=
 =?us-ascii?Q?awVhmaXlRbsSLXCtnoK8kJNX89Nwk7M8esRPIOye5FDCxlY5z0kQ03inAkSK?=
 =?us-ascii?Q?cfXthKsOzqyxHXQuD3eDm9YMpjMZyvLr/PHSQZ033EEEwFkxIL3auswc8fG6?=
 =?us-ascii?Q?TUzG5uv3C3gI1CXsogKFH/BqkA9Nzf+29V6Gy1ht64h3LzY1Is9qkl1ZUu7Z?=
 =?us-ascii?Q?cbn376p395IVlFQWOFlOGM3cwUI7TqbFEhTQeu3FQ97TWRKW6xybjVmu6di7?=
 =?us-ascii?Q?KbzT/WUi99Zig75BN9d8OskqLaEEDwxelnlDgzqMd9cGcSNAAxrmuKzhlZUr?=
 =?us-ascii?Q?yhlSvQDjnRn1PYHcWCyhyRTan/PhACrF8FhAcBJT+DjXFaPdIVcU0D9bSp71?=
 =?us-ascii?Q?pp796HARISKrfNU7Rv/GxC1VfXOZto65HWD6iLNh73VaAJV0z8yZY7xYCpon?=
 =?us-ascii?Q?IVOj5ha1FiVp4DTWdBc5qDcyYetm/BOeknMR2rd1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80c2541-80db-490e-0c73-08dc977e9460
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:28:29.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pTrEWPC1okUM8r6Lxn92QqZqnjKl012Vn6++iPoEkHvS3EDqF7etLTOgqPDmTpJsSTcs4n/FIMd66kXgTZ/Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

Invoke power-domain.yaml if node name as 'power-control'.

Rcpm actually are not power domain controller. It just control wakeup
capability. So rename it as wakeup-control. Fix below CHECK_DTBS warning.

power-controller@1ee2140: '#power-domain-cells' is a required property
        from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index e61ea7e0737e4..dfd245b326a0d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -556,7 +556,7 @@ pcie1: pcie@3400000 {
 			status = "disabled";
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6b6e3ee950e53..24e86abe88ea1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1319,7 +1319,7 @@ pwm7: pwm@2870000 {
 			status = "disabled";
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
 			#fsl,rcpm-wakeup-cells = <7>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b19a024525cbc..c176d36f68437 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -983,7 +983,7 @@ qdma: dma-controller@8380000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 6e244dc4832d1..baf9cb90ba8e7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -935,7 +935,7 @@ qdma: dma-controller@8380000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1046a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ce4b6aae79d4..c980f4c5dcfdc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -1033,7 +1033,7 @@ dpmac10: ethernet@a {
 			};
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bde89de2576e1..8691117ffcf76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1218,7 +1218,7 @@ ccn@4000000 {
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..73ee45acfde13 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1078,7 +1078,7 @@ watchdog@23a0000 {
 			timeout-sec = <30>;
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
 			#fsl,rcpm-wakeup-cells = <7>;
-- 
2.34.1



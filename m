Return-Path: <linux-kernel+bounces-203177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E18FD782
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F341C2183A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF515ECD5;
	Wed,  5 Jun 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CmAlUUW3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987015ECC4;
	Wed,  5 Jun 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619245; cv=fail; b=FySWnY1lZssJUi9WrxdtNUvWpMmH4qhwmyHCnqgktnbbzU6tQK5jtJt0P9jAvv9y5LKyUi/tpqa0JWTIFh/cfQ728QieCv+ZS1xVqezlfw+1rQy6yZoJmdUW7Oy523t3SPVGDNga9tt14WdtZtSuyB8MY7tMVtNtLtxMwFmMWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619245; c=relaxed/simple;
	bh=JMTAE3/HY4Xy77heSUmXqktoZicdL7n2jxPWVjWTysQ=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YaSf6KFlUx02sVt5FSh3NftXu62GfRMyhlOeWmVY1gtztah6c9I3Qp+MM2ho6wUBmuHHKjXiwLinZTGusJni2I9ThqVr4E+g0alS1xU0ZFyK2rLhdlzRb7GgphLdk1rPcKQ5LyXu3CDpJnFEwOlJDcXMYlr8h2z561g3UUBcnRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CmAlUUW3; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEPkoJgchAIRFpdOz+5HPBO6V3ddOYmLkD+ou9F2y5XZfvRn4t0EtRGBSCifc4kPEiBTHleBMhia5jV8jXLUqUWW/hOO2keOtGrSeJQ+GF+qzlbX2lKryG6veSxrSuakXoVPvLcbFFwOn60Va85UNWq+78snTB/mKyCVbDNsMq4bppDgImn1jimY5g2dWk1lDYSohotJOJCT0aP4BA6xKAlyrpuHtGm8b0nyK5/NgS0jYypS9HvUs1+aZLVPOMLGm4CTFkyljf89t7ElRwCkHqMVBuEMqZ95K6TTJ0WMUD9AsAApFH0x+sSAazfmWQxxJRYEydwYWhTT3DNro5rPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXc+RS7mX2m+NEGEzDbIEySOU4PFL84lPfkNRE9k474=;
 b=QIEIsF1EnE420oU2CgurcSEMG17L4zKGv46YkugFW+slxCTg78OBeB+Fl33qvLYAr11y7iTgMQL/txWvOfrHK4jlD7fqKV/cPzv8kTVkRYde0nITsvsQggT/AkhQSh2+HY4vsklCXjk70wbr9YPdC6/Ol7RgZbbUF/4UyJSl4kEsKuzjTmbFEn1INJzUbF/Uh8iyMtgMgk33Xd+9X7MR8Sm9fs0eufo/czSPPYIGanK3NiS5oW5OmBDRBLNVZ9DhAHdryDLchcvfbjCRhd+BGzMfDNH7cJVsH0PKejf9AWzCEI6qBO/zQ6AqBt292NSbsFGyoaVq8e5Qhh5wlnnzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXc+RS7mX2m+NEGEzDbIEySOU4PFL84lPfkNRE9k474=;
 b=CmAlUUW3UE1DWxZebFol6h0PmmSfAzgILnxNz5U7Yeng0ak++WXGgyVcSzLizfwUqwhhP4voKFvNnQW6v16OhMs6JE0j9sZpBv5daR8q4LjLLQEY1CckNSXw6cby2DCU5g20KD5WahmkUwFBjXJG1gxpPvcIQtcetdEeFszONhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7680.eurprd04.prod.outlook.com (2603:10a6:102:f3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 20:27:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:27:20 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5, related memory region
Date: Wed,  5 Jun 2024 16:27:03 -0400
Message-Id: <20240605202703.1220203-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d69034-e0da-4105-3e6e-08dc859de640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|366007|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDoJs3EYjvW763/EAVh40yYIYnSPKmzrgCMbcane7LW+kvWlMqCznd7fkqSO?=
 =?us-ascii?Q?f/BUMi5/SFwzEFwEFkOfaB8h+LGdunUxpg98BpaaQSbLJZJ8cUPAFJXbT7GN?=
 =?us-ascii?Q?WhCOp39zBcSAmoI6b73pLugZWYrBEVFaUCurcyu6KEWIikh4YNOdDCifbyJ0?=
 =?us-ascii?Q?lwm1Y/31MiIpWjC24Bas+3pmj0sOJFtGiH1BLuJy7QeAXNptr1oTzq5N+RYw?=
 =?us-ascii?Q?Hvi4wfH/P7zrw0EU25Myvozs9j3IzWHNolwAH5mVMdKYAmvKlxWvhQXeROHd?=
 =?us-ascii?Q?UoUQOOFwUnBi0mK+rNP7OitKiQ8zaaZBY0UPk0IdiB3KyKfaGUN0ae+WfbKm?=
 =?us-ascii?Q?+N3SxS/ZdUdFKwnXJngvUDW2fWVKjk3e+G797tFmo2nIMC4DCnoqiamn1lgA?=
 =?us-ascii?Q?esqjqatphANJSPfvAxmGDMQGCnQ5P6hA5rtdPtD5UvFCFFu/7Fbij/b3wCxe?=
 =?us-ascii?Q?5WTo1W8MEtjz/2LyFPz1eiJp316tzr0YNaR0djQzMXrGqj1/N4SRA4AbTO0Z?=
 =?us-ascii?Q?Z1UAQzsrdVI/tE4nrFfvdWLUSNihEKE607JwL0Waf3Bgwo8nT/9AFZgmwtbw?=
 =?us-ascii?Q?xPVZ5ePthG/4Ay3CVYXDIl3vck2u4pMyn4IcZ36OLasZ3rsNFBe9yu278mWi?=
 =?us-ascii?Q?5g0Xg9o5kwD4Cbum2Dio6g0gzz0xNi+2bGxbWzIJNUbOZ7x4H7Tds8L3u8G+?=
 =?us-ascii?Q?0p8qRga6of0NqiYw2oIokbZbC1hjJaw5ksoSTAcy5N5vb4FREaxw/GJRCuOT?=
 =?us-ascii?Q?nr228U2/VlBPfjaGyF0HmamB49AfwbuQytiqUA+tGNcwi7H+JeJB1h5qn6v6?=
 =?us-ascii?Q?fBV4Itkop/yBjM5d312Wy5TCuSEmk7BlScDnSj2YQ8K3UmK3hde8i/NORObU?=
 =?us-ascii?Q?I2+rVSDXZKM3w6V/HpUbyjiTwFgIDFXNPcgUFiqpTqKAte/h8tFQZRMPjg3M?=
 =?us-ascii?Q?cI04ueLZTcgEq4Gpf3ZV/DZsBaPArmUDpN67ksdV2owkWi0P+TzEemXN/EAD?=
 =?us-ascii?Q?bIubDAZsiXJCUvCCSlVuQk+r7FIhQLGwFt93rrnknUfecIXa75iT7hYg1E7K?=
 =?us-ascii?Q?03XLFsYtNSUnxW+gfJTq2vzLKBFQAKxc12Ywet9ZEZ0dnifx7P0f8aYY92QQ?=
 =?us-ascii?Q?NYIlHDhqRIxHnJGDFWNF+9cPW9Hjify8a8tiVC6H8HMIGCa4Cmhl7K7BK6Hg?=
 =?us-ascii?Q?MdXwyoK2QYeFEKb4NL97/PGEaXJOwKuq8+Q1SN9G9Phl9tTMrnKOMId0D0UG?=
 =?us-ascii?Q?WuqeDJEwATL1oPmDlCLxxxfBz7skblK5BLgvqTwM6Jm6SUSDr30Vd4wPWD2C?=
 =?us-ascii?Q?xCEMmzJ3gtfy5sffiTqtXAKpgTDQ7YeFERBYEqYLgPnAQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2qwDb+daZUtGZp1MvgUlb1OxmeDd8AAhVn5gP5kBR9bzi29QTVEhcZzuj74?=
 =?us-ascii?Q?DuPIEvZGrBrsyv9eC3e+W09OCw7bqzI4gCPLrAQSvncq+U13St6fBuUgi4MO?=
 =?us-ascii?Q?xSFMELYHa3EKV0bgHRjeHBA7WT0Ib0BT4qJa72o17xi+z6AR0S+Ox03ghLP2?=
 =?us-ascii?Q?sKUYVEq27d6L+fgJWwWaKerFEZ2KzV4ihLeDG9QmUihl4TPk6x/SwmqY/mmn?=
 =?us-ascii?Q?YvnAEodt8Gi3lqi0BYJKuGICAFYr2+iVC80pKQ5UoHrqgiNqk0iX2zho9WBf?=
 =?us-ascii?Q?FoP721+/gFIPgc8ESVDgZijihDve/RyxZ/SSwWEBkKx+N3BSKJKB7HReWD1O?=
 =?us-ascii?Q?dNtMnN0bJDGTSDbLnsZWxjFa1GWxSqRLFW9LYH2jwWQEwSRlcMb4zBh3mI7z?=
 =?us-ascii?Q?o0wO++DhOBY07D+UE+D35hO/4md52X14OWeGuU60TPfz67jAEHc7CCjVvpOS?=
 =?us-ascii?Q?6DtNCah51o8l4W3QKzCvknW0iVnXtXML5IhqtKaqRNXk/r//i6bLIFB732+i?=
 =?us-ascii?Q?zSVUDXsoS0ws6Tbgotb13Xd3P8PnSGGFiWyoqvT70YOOCbZOXRsHcZYKlg64?=
 =?us-ascii?Q?04r/eFxc2W0d5FsoQmuFfDopUCQqc3F0owXEk14sRFJpF+FgDeFbVhxfFAtG?=
 =?us-ascii?Q?yqsCW/PYYZeLOfOF2xbChE83aICggb5Y2z80uMPj/R7VSeMe/1qeI6wKIA6W?=
 =?us-ascii?Q?iYzpV648qR+roIWufk+YCCB/z+up5HdI+iAqI8L7R084KVWt6CT02HsxXg8k?=
 =?us-ascii?Q?V+k9ANqOKH7wTBB8HzwlOwI1XoZeruXhAP1fV9/jDo9ZxKmo9NaKheVq/JER?=
 =?us-ascii?Q?5hQ7MfKpkj1sNwHCHgXXTPkFQZlpbd2/hD9104jIqyXKXG+etNnHaSrUUzIo?=
 =?us-ascii?Q?mTb+Ec1ifJe7xL5QgBkOwfv/mD5WDuBCfljm5+fAvrJ5z1Xio9yuHFN7hTTg?=
 =?us-ascii?Q?/0xxqoM2/RYyw0DmP2be8hiIXnfT8xmwXuUvWwU6ZtvpHzeCRDS2u7iffmsD?=
 =?us-ascii?Q?SlGu7aLsII6T0seJUGYBZzyghNJSpUDdgH7Ehd3yYWmkCyybAZVrg+qJ9b5S?=
 =?us-ascii?Q?4YH1X+Q1l8NmiGGvh4/VZ2Aj42xrtzjMJiabO2NRzemcQg6kXZGPwAYo9KNs?=
 =?us-ascii?Q?EPHRXCGtMIQa/hEo9e/9wdtEqwNmwSA+IuiXj0Dii/gnt2DU0vEv8+UG2RvC?=
 =?us-ascii?Q?2DWtXDKC4xjmQ/pk30qfCQ5ajntKgGxB4UnBJarT0dwzvrgOywrUZGJajUYj?=
 =?us-ascii?Q?+C0PC8PQHNlm09mjGK7zTgTdAXJDzq19PvzFzt1DWMu4doUkTKBldcBEHepV?=
 =?us-ascii?Q?6+SXtMMzYhDbF/FVo4mf1ZjNKyhz8Ui6XPEbRjlX2EHQ6TAApGwuiyA7Lqto?=
 =?us-ascii?Q?tmvaiaNYOookF/25s6Xpvfn5UR/eLiWX+4N9uTFC3noO6MCcxssjwPOWHzSG?=
 =?us-ascii?Q?SKupj+E9mAZe9FkJK+2Gpm17BfaMFAxxHgAys2LrF9QgKOtaofZ1QSsCnnLU?=
 =?us-ascii?Q?9kC7TMTjs71xkMsr4nZBL3nG7K8lHh2HegXJRLqxyl51oIT5nCvf06vbIfSu?=
 =?us-ascii?Q?y91QQHrk//STgfZ5hQaXmlPIOC6Uvz81VxigFBX8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d69034-e0da-4105-3e6e-08dc859de640
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:27:20.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePDf9rNQX8C9/5Sv8IdLJbQWCGK/oZVpvZ3uw6mLPFM2eaCUj7fgzOR5DZ6O4m1zpFwDWpADq3pV6Q2Y2Kq5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680

Add imx8dxl_cm4, lsio mu5 and related memory region.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 4ac96a0586294..c5e601b98cf8f 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -24,6 +24,19 @@ chosen {
 		stdout-path = &lpuart0;
 	};
 
+	imx8dxl-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
@@ -51,6 +64,37 @@ linux,cma {
 			alloc-ranges = <0 0x98000000 0 0x14000000>;
 			linux,cma-default;
 		};
+
+		vdev0vring0: memory0@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory-rsc-table@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory-vdevbuffer {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	m2_uart1_sel: regulator-m2uart1sel {
@@ -505,6 +549,10 @@ &lpuart1 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-- 
2.34.1



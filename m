Return-Path: <linux-kernel+bounces-231462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405F7919908
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4C91F22CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2992193073;
	Wed, 26 Jun 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DGo5rotZ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A0194128;
	Wed, 26 Jun 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433570; cv=fail; b=kPNoBdyiNh9fmx1dvTLtVeddOfQGy9stk8DYUg+xj8UTREZHfGOSIWuxGlGxE2cYmJDDDInitHXavDBLDk0Jb0sG0WebQSQq2U5uG+EF6q5Ln2qjsgrsl7/UlUshPXhb3QpKHULWZ1/G6oazV2VLpzCvj/ZBFhbBZWjbTb2B7OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433570; c=relaxed/simple;
	bh=gQx6uOKzzKS0Bll7jaAdB0ziR+MGyleGJaCiGybqzR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBp/RhCulLVr5tuwsxV//hK9sDez5J8C2Ln2hakC4m/Kyz+1prU7WzJ4c2eVo8vmavoH0vMP6lxyvqgQYfHuGu9FlD/q6MR2tzi5D+yhXjTRCLnC/kf1g4kEIEWM8OUHpZ/6u3CVAoEIG9gNqpUG7KKxZDwxswObkzbC+H9xwFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DGo5rotZ; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYbJIFwMlRc0Uq8BRaMVgtzejU2BcJF199RIQvl4WQMDe0R3Fy7cBURQdKlIhpuMZbG38DkXbbaqhIJOfxwgoL1TLTwF3mODSh9GCR8JJ7UhN8bOkk4tRLolfRC8eo+9u+0AJjX+51R+i8bJauyWPXKmWEnGWPMb9Pdy8sDlp+8z4dg/nwTVmP6cuHhiGYu1hpDwjQ32RyxLjq8vkpygnZumTSQra0DPnFlRAb0HDwArLmP60L9cm6VS9USCXtb68Mdntd4ZVaSvbaTkPUJ19EWwPqCyDNq6Ui2/aT8OoKhLz7kwPSTeuXDvYfypgLCyrsQaNc7P9yImnzyf9IYQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qaOxvWcbSXooGjoZ0TzegtRWy2YIfbXYTnfjOw+GaA=;
 b=kOALDGRzHOAgnUG2IK+Mm1+qlvh7JcCkaxivYTxo84TWB2NL6q1f+l3Bn9RgTbbXfnxahDHDK69a37rkPKT1AUW2CVoj2YgD/aRPcankUyl54vm8HuN7BeQ2yX+vR0a48rlrBF4q5yyszVEXwnMRij/zdPsH5YZljxFFQ2VQAG4qK5yyWCpfF2MsWeUNJ8exLFdfYNoDBIMlKgsXCCx+uOWr4Z3s/nrQHQzimPk1Gh9zS/CWMkc+/qOJR7H6xIGrvEokAHnhsQVeYMEjfXueSSjYjHl7kKwTVm4OaExAODQiZOrwizRGziw0ay0BEnPxYfSwai2HPgL4SbhtsYsf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qaOxvWcbSXooGjoZ0TzegtRWy2YIfbXYTnfjOw+GaA=;
 b=DGo5rotZTEOCAvAP5pYLvvwUcnjaon7KefADY3rXleBvUYVVQCiGmGT5I+e3i4SQ2P17ie0m7uJzCIv5ciLExuf7D22Wi/bQb0wID2NHGnXGPIhraiLGTwN7Dd/UBxqVQq4O1WAQLwvHF6EUDIFzQffE2neE6CUbUT5tqGN77wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 06/13] arm64: dts: layerscape: remove compatible string 'fsl,fman-xmdio' for fman3
Date: Wed, 26 Jun 2024 16:25:26 -0400
Message-Id: <20240626202533.2182846-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba5e7d0-9f5d-49f1-24ee-08dc961e35b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?op/4dZD+t1yQqhLQP16XAHZQLDApzBVDc+s8zvZf2Bokt7yFuiGTNPEQV7U7?=
 =?us-ascii?Q?MzmVpdGRaJ7dQvcoK91j+JHhRhntu6XuMy0YNggKJugh5xdV3w0gmeD567v7?=
 =?us-ascii?Q?LnYRDd5nyZXzvnG2YVUmV2KNlyCfQLqA/CRDajtzynejjwckXP/RIn4b6S46?=
 =?us-ascii?Q?r/Ijvopo+yts4Jup+dP14fUp24kesSfcWtg0qhysYsBgv8oe7BAA1d9wb1Lv?=
 =?us-ascii?Q?QruTBOkL3JqmJ+nPJo+MEL1GDTSXQ6F0nstu/pU+nAc6+0td3SpIkehJ3edi?=
 =?us-ascii?Q?g9BaYtfLE7Ao3neeaiIcNeRdrAqlZzY98I8UcFYGkC2bSZIMZF5xACQ0xHM5?=
 =?us-ascii?Q?uFDRf1P5YlhdVM7ipB/AQ6XH1fZ7igJRI24b3T1IbLDODDGij7wW1bb2hvtV?=
 =?us-ascii?Q?XaudBOm6zrmWLBsGH5J8Zc7KaH/65rQYr1USI3j5MYsk9m0MHaWVkUh1KyXH?=
 =?us-ascii?Q?Uj2bcroObNqXOD770sM/c78TgG8OTFmqIFa5ZleiUs0cHp8DO7JF1WxAR/R/?=
 =?us-ascii?Q?Hwl960eXdfgKBIKiA3mTSmqaN8EKW90HSH6/b5N+b2OBPhvlXUoK7066WPRg?=
 =?us-ascii?Q?4fK/c/PKPbROZgmBaX0Ov46Axd1j81+cuSsCjLAPSQFA5pEYYdw949dt7X5y?=
 =?us-ascii?Q?tRws0aOTTE0Di9CwQFYp+bR8Ds3ybpFNhoBnFd1k7NpFEzAjuN6mg3LNkwPO?=
 =?us-ascii?Q?y/8TJOHwwDC9bwrakh/lektRlbKn+f6H2QgGUOUZkcgW9ELbaMUDlhWnyWrz?=
 =?us-ascii?Q?bIXgNBSuo6MxzEWi9xJUD/alBYGI6NED2+u1bbl+gO34tc8YcaGwQB+VqM+t?=
 =?us-ascii?Q?+Rnkj0/PnQqrLkzkmmM724cyiPADhZGQOujgdjpO2KUROPHlu0JnY+/XKiE6?=
 =?us-ascii?Q?ch5wn3FlHKLx0sQ77pXONsV6PkdPGXLid5v/B3XiZF9JCr20ePdQkf4lbw4U?=
 =?us-ascii?Q?8MIK+A9SuMr155Brlr5+qta7hjPthxiSvC1yvpbQ/nj+2LzOEM9bD7DPJymw?=
 =?us-ascii?Q?AkzFQICEzcDqxBbiwr6RswAsApYDa6imPd+m/2PHmCn3u1QRGBB8kyj43ZMr?=
 =?us-ascii?Q?UP2yn5v+gYqLeTVb6tCvyd1JK7si9sd8PYVK+8nMAi3e1swfKdGxdIAzuFa4?=
 =?us-ascii?Q?Qv9nZssfhUz1wnkWK9van065cUT95dBAPz4jeCgFlcfjvM0lKnwNEe4K65pM?=
 =?us-ascii?Q?xocuTdee6CZrgkhk1SmuOCV3ynfRYHQrGKOY/WFL9I0jdJRcpvlU8KBgF7pg?=
 =?us-ascii?Q?i9olqZ7D9RSJ681mXxJ1XnbyUkBAgU4DDZd3QxgEp8YEWhyBXrfI/8Y7FC89?=
 =?us-ascii?Q?1kt9aHUQLtka3BblEUMThXOmeEUIqsKSMAfje6iUHn3IgY6brN/tpQCzDX2W?=
 =?us-ascii?Q?sKIJrsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpd2BQlXSoVTWHmtV3ut2EP+2PdJBwCzsK/LFvi4/hbJHMJsJdZ/fgqI0lY+?=
 =?us-ascii?Q?vV8dQobrmUfLBoSpFhNhA8ekDz9opD0tLrh4uzbCv+Xq8b98gkffCCk0885x?=
 =?us-ascii?Q?LCt2skDV7ERyz1k1f1wMcSMzFWjj3Mka5qMaK9z6w9qjTk7bh9pMxdg004q6?=
 =?us-ascii?Q?OmC1AA7J7TokXIW1Nmz4rTnTRmelQrTnb/bKHjwXTOFNp5s5HsMXFrPPriLo?=
 =?us-ascii?Q?SBSFqn3Q2JC0gbjvYedFwZBb+iWGEWXOTuzRCIycubXzPRgJzjA8NQ7ByHWg?=
 =?us-ascii?Q?CZ0Eo3z+yxYRY/EV/JvOkBX4uTK9iZ++OjntoqKdPKA7KwM3uZp6D3WSGPTu?=
 =?us-ascii?Q?8Yb2FRLJbry/NgamIh/Dhqa3CZkFWQEOHr2SRdNbZuRoLaWZ5GPTMKrbzsSf?=
 =?us-ascii?Q?t9NhC16NKFdw4STwAFGSfmBbFhONjt3doYO87dX3C+GL9cbCS9DCaCu3/05c?=
 =?us-ascii?Q?ZVoEKnHFkpP4A0HxZgt8xyoneWlBfI/dGUSHZTHpYf0vs7W8x1mknxUqqJjB?=
 =?us-ascii?Q?pf75o2woy5ZI9dtX4i29I+2pvoSwJCPnQyK3dGKnnsAWtxMi7i+xAIDfDCcd?=
 =?us-ascii?Q?YcuidH9WN5K+80zINW2oLv64t0lG/lTinIHTFKxEAOn1wykxB2UDZsojuY5o?=
 =?us-ascii?Q?go+IFomHRSWQzXmwekEFLnw+cH49LkP8bBRosbQs7ZuSZjfQ6g464Qpd+bIg?=
 =?us-ascii?Q?WEgtWJj74V6evrZg1UVPanCOD+TEaOAM4n0zs2AGsdl5Oh3sGhPGuYD5v6am?=
 =?us-ascii?Q?VTiODB7Z3YeRyFDCIbDc+xf5xFvRQSeuOyaL0ZK3Fbj4OKsofKjdz0rhBRqZ?=
 =?us-ascii?Q?us1hHa4NdKLK88jcs04mKS9CWplJyo/YLNa077Xu3bxZZoeLjes/JtrwdXZI?=
 =?us-ascii?Q?8V8L6CQmqwx00bjIcuhfWFiDx4laj6rpsFAAqSce/L78TBSshH306ypfQmsu?=
 =?us-ascii?Q?va6VOeOSoFRQk0p0P4nPWsOoKiXkh14e3M8r9/yPic4YBfwlIWNARS2bb0vj?=
 =?us-ascii?Q?/Nr1XnoPZDFV+MT3ECHR0mp9mwb7DK1bDMh7Ax+F22VE0qQHE3zPwVw2gies?=
 =?us-ascii?Q?7svcx7h24onMscHMFzmNWksE3IB9RSYt+a+WgpeF+5pkRSHzujLAicgt7kH7?=
 =?us-ascii?Q?3Y3gyvB96+mZ+dCilZ6u5HnsyodrdD0s6mdaxa+dlcnJtdmnt9QjEdFSHzEV?=
 =?us-ascii?Q?xQj4vY31bIWS6q26b25KM6ydVK6bjtuUXy94EJ64DSlCi4IiPcWS2XeLVYhn?=
 =?us-ascii?Q?gYGDag60pVDJ8xcAXUrwmKeIWrnBpNm4rUV4GCWVbSv6vYBnfmGhJXFlU40F?=
 =?us-ascii?Q?dwFsx+impIC/GW5i7r1FGs0zoWH/Hz3aFr1QAyCbouKN+G5gtJZFe7v5ImoR?=
 =?us-ascii?Q?B+euXymt1d2a3XLPylaURr1uaGJ4QxPzQIONWLx7z7vvj2C3lED74v2S3dI9?=
 =?us-ascii?Q?1FMZCnO9LwzFCOKYlWO5hW0GJDnv6szN7TQzTdaul+E9WuUakleiWiAhBKmN?=
 =?us-ascii?Q?kde62TIs7uX4uA3SbExmO7HpFAgQVmiP0mlm0KdVC4zWWRLBwnZdcvEUtWoj?=
 =?us-ascii?Q?eWbaNdR7cs95ZwaG7+w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba5e7d0-9f5d-49f1-24ee-08dc961e35b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:07.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z82UZXLLI551xwawGfYpcsywJZJozwiiHlNlD1ZjpuXUBLDN27TDDWj21ao5aStHiXkwVvtIkR2oP4lhVc68Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Fman3 should use 'fsl,fman-memac-mdio'. 'fsl,fman-xmdio' is for fman2.
Fix below CHECK_DTBS warning.
fman@1a00000: mdio@eb000:compatible: ['fsl,fman-memac-mdio', 'fsl,fman-xmdio'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi       | 4 ++--
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index dbd2fc3ba790e..65f7b5a50eb51 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -32,7 +32,7 @@ ethernet@f0000 {
 	mdio@f1000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf1000 0x1000>;
 
 		pcsphy6: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 6fc5d25600571..3f70482c98c30 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -32,7 +32,7 @@ ethernet@f2000 {
 	mdio@f3000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xf3000 0x1000>;
 
 		pcsphy7: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 4e02276fcf993..78841c1f32527 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -31,7 +31,7 @@ ethernet@e0000 {
 	mdio@e1000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe1000 0x1000>;
 
 		pcsphy0: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index 0312fa43fa777..1f43fa6662221 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -31,7 +31,7 @@ ethernet@e2000 {
 	mdio@e3000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe3000 0x1000>;
 
 		pcsphy1: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index af2df07971dd9..de0aa017701dd 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -31,7 +31,7 @@ ethernet@e4000 {
 	mdio@e5000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe5000 0x1000>;
 
 		pcsphy2: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 4ac98dc8b2279..6904aa5d8e547 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -31,7 +31,7 @@ ethernet@e6000 {
 	mdio@e7000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe7000 0x1000>;
 
 		pcsphy3: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index bd932d8b0160b..a3d29d470297e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -31,7 +31,7 @@ ethernet@e8000 {
 	mdio@e9000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xe9000 0x1000>;
 
 		pcsphy4: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
index 7de1c5203f3e2..01b78c0463a74 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
@@ -31,7 +31,7 @@ ethernet@ea000 {
 	mdio@eb000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xeb000 0x1000>;
 
 		pcsphy5: ethernet-phy@0 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index ae1c2abaaf362..b0390b711fef4 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -67,14 +67,14 @@ fman0_oh_0x7: port@87000 {
 	mdio0: mdio@fc000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xfc000 0x1000>;
 	};
 
 	xmdio0: mdio@fd000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
+		compatible = "fsl,fman-memac-mdio";
 		reg = <0xfd000 0x1000>;
 	};
 };
-- 
2.34.1



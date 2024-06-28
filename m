Return-Path: <linux-kernel+bounces-234015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158891C0EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B60CB211ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C81C004E;
	Fri, 28 Jun 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NACwPusn"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967F152511;
	Fri, 28 Jun 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584911; cv=fail; b=YsqffEebifeNNoFvU6qBQ0h2m7yGnBwXkOXLm2vNnQ5Cno64ObCfA4owhmuDafCF1A5dgQsrcz9ZjCrHi9OFwTzFrvRuMG835WkmV7Luglir6xfHohFwfIvVrQIssFNTHuyfNRXkMXlF0+SUP1k6Vy86TkhXQePFIIXvQeIVRh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584911; c=relaxed/simple;
	bh=tK2QDAC9IePx5ybM03KsJXkEcS2a354VT4SD8qOyDYU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pC+3T6pe4560l1zjNizfDE/ysr2DuwEUl/r/ucaRseTH/QGlEZMyAw2cRFuOqwK4ONft5IAOHxQnav3A35tYOX5u7XYxcX1/H5z9u8KeRiA2vTFaZV5q5YfePo/aSPTCdZ9LM+OtCLOtvI/hjBudrcj+M+nLkHVIDsbfbEgvwX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NACwPusn; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRtBngetgOOGID/JTeUiPXLNfVhkFy8aT7uvTntm6gxFR7ouoJaXDkx8Z2ER4TgeAl6C3jBe+1CLf6QpSB+JzZHDqRHIw9M/xhSZWu02cboarSUtWnMtizTiwH1E54jwyrmjcgr17lcekbvxYxQwMnPe4vbQ5i4hnPo6somshV/9/iN417mLFf9qID62rD6qGdnv+z1pxNiNI3B2yylKeYGf+22p15P07DgytonhXiu3xkRVNTHhYs57RyyQQU2j75Ie/eJ/i3H2bDUCamcUIWOENcl4qEPjBxCD1IhCWjMWUaAytIqsAkQ0Zeq8BVR5MEsgNmoZWqkXn9i4gds++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSYj8xjqUtuSr4z4ODhf51SKgL0VuMV6U+nv8/egp5M=;
 b=YhO/oV9puaaNKlTAtf4whWErwPH7KhhYuph32aBRMxpnGnIzIyjAma4MjNK8Li7ILJ6BysTpxfdydwirOEK7GbuQK2rK/7juFwOJaKHKN//lU6+OJSmrXEEnuGx0/4SGMFVAzunZdxAKFS08NkPTPIVj2fklS7Odj7M5pMNFWlspYJVV7YaC+07jnuAeZgjv+oQxzFKRdQiS1qUMBFAcHt9a2wvedehz7bHpfdo4IMY2NVz+0HJNVnPy7YSNDw4aw7xciKpFH20aKuB2fCjptKxyNpGAm11Jj+s4WuHgTrqQIhR6E77aLemH9bIgLCOejOL+MiYhM9xJ+9ijm0NRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSYj8xjqUtuSr4z4ODhf51SKgL0VuMV6U+nv8/egp5M=;
 b=NACwPusn5P0492PX0/yGdCv/DI90IfdUAK4mAv5/GK48Slv4jE6F0XCl3qtmzD0PgqEgi2W+Ck/doJtpjYaUUjtl4JxcpUfWsstAwAo6TBnnMhqyVZJTADqhDtLtrVVne0TYgfFEIlWD3nBV9/8o6yLXq2wp2LlHLzrKTNFrrBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 14:28:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:28:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/3] arm64: dts: layerscape: rename aux-bus to bus
Date: Fri, 28 Jun 2024 10:28:06 -0400
Message-Id: <20240628142809.2327824-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 8ba41f2b-c46d-46b9-99da-08dc977e9286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijnOSbNmYo8z2d6dkNaeyO88OLVUNpX0jcPtDRd+j3+2kJegyP5fnmXtM3cX?=
 =?us-ascii?Q?2/eivLerl668i2JBG942tBHeTgoq5tSteaNtDffTRPF5TIpKNuWB4ye8twCi?=
 =?us-ascii?Q?50C0mAMRQKu0CNcZ74qkfEMzi9WISdS8wz/AY7b8SqAlgNTrZzstcIi7UQ7H?=
 =?us-ascii?Q?tQgq9wg4Km3XGcTIqoEbYrDGu2Y0OsIcYxdWJ+40uXFF7cNVUuglrVsczNg5?=
 =?us-ascii?Q?Q2r8d9eATIVCvkTptMAyILnf+h0ao1YkYmjMG8exDJ8nN26mikWGTSczEpT7?=
 =?us-ascii?Q?cScLXhZuaD2StVaGtWft8o3mHhx3ESjd6DwYExHPRvzLic4tEx5jdCF8dwEA?=
 =?us-ascii?Q?jglYK06scEX6bzXFE0CmsSbdlNGftf0TSoCh0JiTibv3I0wmDYM+SpTnsprW?=
 =?us-ascii?Q?fk7UYvaoSfyO+wQHzR+O9h2y1EJuxg8ea0tv2TNHNZ/wY04I8GTpSjHyAGoa?=
 =?us-ascii?Q?u1ZNU6qP+d/pLghb2nYR/HFlkswpynltd7fx5WC+OjZunf8a2OgtISZWCfCe?=
 =?us-ascii?Q?/S4Foq4G1cX9F3r5PPYAZU+jc3hGZIGto4T//m9mKBSjvLNAIxTALV8E2Q9D?=
 =?us-ascii?Q?JLbfFvb7kzLfcAnFep5pYfuvhMTCRLdt7sKjkzdQAfHuE6PRISTERvhnfzVk?=
 =?us-ascii?Q?u7URz38BtWbwHTMqUG3luqaAFK9tpR2+WWzY1Aim1jkQh2FLtnnn1dHUXuDX?=
 =?us-ascii?Q?4M5pO7DsWPfrQ3rstV5rZJ9rt1uDzUNlexFeg2jXaTfjEv7IAvIG9g6YCe5P?=
 =?us-ascii?Q?y4MAZch34HY+TATD2FNq1wa29EzioS+3spmwz6KSD6RWtW+h+l6QrnOuRQul?=
 =?us-ascii?Q?YV/7VLuXjo+TToWrVIdEkGna7CiFPcKJ0qa5qwW4qBZPopxXmIcUNhxrNq9r?=
 =?us-ascii?Q?8nFZ6iqTt926tBD+VoJMNc8/6Eo31Z+nrIrpyucC3yoFRsOTadUs27z70kTs?=
 =?us-ascii?Q?ZecogHEL4uJGecL77ddVp4Tqt3gITTz1/u4fb6U3zB3xH75PtorltNF0oXoH?=
 =?us-ascii?Q?h7Wfx1ClYs0LFA3f8Wtz+VAZjGVZN+RyMxgF5QpqR5/IGXeSvLXTZ1qjxMzX?=
 =?us-ascii?Q?3NFRQig0A64rwyQqWgnGvTrXGk+wAgQn4+r7da42x7QpV2c/TyYvZpCk/cUg?=
 =?us-ascii?Q?fQ+wzkdPFo9FLk1WTno/kpxa+bDVkB9eVWsDj5hbzd4CZhM2zXMvQC9O3X9c?=
 =?us-ascii?Q?LHpei5qXm4AtQZTd3PAGA8rCakBqaDS9A0+CgVkd1Mg4GO/Rbrldy/KEVTCi?=
 =?us-ascii?Q?35XZM2QKb73n2oMYuhy+3JLZ1r/UESextbqsWQBYXsCdA1V0pDb++hyGiE6j?=
 =?us-ascii?Q?PkHLe7EtZq1RrL5CrrBax0Ru94Y7eSdo5yhMPDSmql1yHy7tmkjrrhiYKy1h?=
 =?us-ascii?Q?97ffof8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhMjE2yilf1SupB5ji/JnzM4skZi/dNFL/PysP+Cy5L48nQ5WbSZHCc7PDhd?=
 =?us-ascii?Q?9NpAZPETDtSmYCsM7QQ4H8mCQ+x4Nozp78XH3cyeviC7Qsj/UTG2COg3K+Wq?=
 =?us-ascii?Q?FH5W3nkGkd/BVjSfQ8csCnU6egbJdpDIcAIAfyLCuVCubQwIc9RkZe/r1evH?=
 =?us-ascii?Q?e9PguxR+0My/QUjiTTQJJ08hy6tlgczXXba7hHdH1im41H2DOdhFpQNy85mq?=
 =?us-ascii?Q?T5EHNv1FBhKDEySiCvnyxO80bxX9gcZo10tyhVTwdIqe+dWWlZopJwIhy7jF?=
 =?us-ascii?Q?CCPOvpDtc8rjBXmi2Fk8CFMlZvxkHBsWFUXz8TqPCu08hIk/p8zVZmbLaWCI?=
 =?us-ascii?Q?HsnqLKOd4fwHOVNs7JiCBuphsnKhiZng9OdKUqexa9pT8BSvoplvCFBfxR3y?=
 =?us-ascii?Q?cddV9ZX2K2fQQqqGblpp1jLwY8f7VbV85lmGAhhMv+X5HE+0S8kenflx5SDj?=
 =?us-ascii?Q?4oWsJQnkhZhQXR50zPBdjqTP6cjjVxZJGSX/5fil7ih8pAZ+31LYu2p4jGYM?=
 =?us-ascii?Q?A9ZZER1bItsw666P4e/EHFPNFBFUhdICKovnwWdwQROGAdGlaVP295ViQOCL?=
 =?us-ascii?Q?GTcgjcv4ydPRAmBgzsuRtXwVmsPaf1SnbzlkCMJLD/VuSUr/FTWe+0wZhpAC?=
 =?us-ascii?Q?U5xgC47yfcfQm/Eji7hxSkG6l1LaCHnA8n7UbkuPlpmgNYo1cZ2BCE9K4vDy?=
 =?us-ascii?Q?sAs4GUAnqidBrenpCrqa2QspG1DPDM1LV5Gtwp7TWQ7rtr+GnHLsQgiEMskh?=
 =?us-ascii?Q?MCkpS2edBFsk6asQYj3s3/HiZ441eqNqZou56DDXqQqJ9RMdvWOCIikc+ggy?=
 =?us-ascii?Q?9LZCQTYTRF1snozk8KmbIk+jSDu3LgyHcEHPc0zvuZ4dimlsKe7vUqGshSDn?=
 =?us-ascii?Q?jDpP83V+6lrl/HqlnkTf35ahRMUo/JyaqLa8IilYkKQw3QvJlNvtp+VLr3Oc?=
 =?us-ascii?Q?rNaPbGcJ0SJDJ09BK8AeF4QgECxh7JjsKHjS1bfdNPpbmdRpmLYHvhgHXLQj?=
 =?us-ascii?Q?DG0JdrtAzrKg9cmokv4dEx7kshuJngeqOMZ3UL1b6fETd85O7OcsFQW6MVmX?=
 =?us-ascii?Q?vBcmKcfeBqvv+xW91pRUzgd0cHiueltKH48rtHcrsSc8spijl6hCXuQzjyHq?=
 =?us-ascii?Q?TPfxsA2EJpa6A00HQs7qh/MvHAn43F4gMGc5VmoxhmWl+y3D31Cpgf86ECxr?=
 =?us-ascii?Q?NR9tRyZ+eeGHXuK5d0y+FiyW4OUAvp+Y0JHQyiaCdX4D3mCuC8M2n/dLPIKI?=
 =?us-ascii?Q?GI+lprbwyj5KisevRt/iEdsRdXN82jvW0ZIED0+GM3zaauQd39M9to2/cmrh?=
 =?us-ascii?Q?5BftwAkD0jTud3HOzJ0WafJwodMllaPObcb9znK61gtFtQZ8BZj1e8n3Z4ar?=
 =?us-ascii?Q?mGGHIj1/lz41qCtFMP59f7RUjchJyOeARrLgGUmQB7vzEWgjcvD7gjCPbSw6?=
 =?us-ascii?Q?2pPvGbkMzpfOsvaS1qfjoGwjwTe/KxR0zruBfAY/iol/m+Uu3zzvG7v9xklb?=
 =?us-ascii?Q?xpOgSAxk4J3qJXpJ9Xgwcg/fWduOgZW9J7iOs/4LvHIfjx2h7ZGiQLhctTMV?=
 =?us-ascii?Q?uCOlzx9IksNqsvHqG6V1myGkY+e5TK4iXVANqs+B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba41f2b-c46d-46b9-99da-08dc977e9286
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:28:26.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEbAH58XVbuKQy3nCn5NNy64h8sQ60QsP6i101ao05zhjRUtfalMIV90UwC2O1j/02NutQpWjjQBOzSAs2pD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

The node name 'aux-bus' is special word. It invokes dp-aux-bus.yaml binding
check. Simple change to 'bus' to fix below warning.

aux-bus: '#address-cells', '#size-cells', 'compatible', 'dma-ranges', 'ranges', 'sata@3200000', 'usb@2f00000', 'usb@3000000', 'usb@3100000' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/dp-aux-bus.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Sorry, I have not realized this issue was caused by aux-bus when rename
from aux_bus to aux-bus at previous patch.
https://lore.kernel.org/imx/20240626202533.2182846-11-Frank.Li@nxp.com/T/#u
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 17f4e31711209..b19a024525cbc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -804,7 +804,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 					    QORIQ_CLK_PLL_DIV(1)>;
 		};
 
-		aux_bus: aux-bus {
+		aux_bus: bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f998..6e244dc4832d1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -715,7 +715,7 @@ QORIQ_CLK_PLL_DIV(2)>,
 					    QORIQ_CLK_PLL_DIV(2)>;
 		};
 
-		aux_bus: aux-bus {
+		aux_bus: bus {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			compatible = "simple-bus";
-- 
2.34.1



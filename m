Return-Path: <linux-kernel+bounces-233069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78191B1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521D42847E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F71A2C3A;
	Thu, 27 Jun 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ziv5Mzyl"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757F1A0AF3;
	Thu, 27 Jun 2024 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525630; cv=fail; b=GJ/18pQVpRB2LRetv0TVr+F6GEwiPE6N49vgZwnQKuytffrAlLXNlBHausCJNDSD6F8KeDJeVQneaqSvsZp2OGcDAf9+nfmSFbmS9HWfFUJdgGEfPlGzJp1a95ikjKHHqfEDwFqUuzoC487IXOniXszF7hxKSM8axZw/qduuG3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525630; c=relaxed/simple;
	bh=nx4dPZWSAiv+4+Z8UF9ly2TZk6mI7AnUiy1em9HAIug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChJnHnmyeXZaQgouf+0+ecGK+xCW0VMJu4TB6OmSjaAqiwrFn6Hq4O79GOb9MII8qBd5a8uL5PCvsS6KQqCR3/ZK6gUTPYtgAyVAcKbCrOgsxptpJJkiN9nD5Q3kZIs+iTVuOdhBYYmJZGGf2mLth8RC2pz437HsUYuNZ+6Fy64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ziv5Mzyl; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz45ubhk98CbA/y/pCrbo17hcjpx6pEI1JG2ElNKjb8inWnZpm0ICVBqJjP58ObS7V/0N1brP/5DOLGJCs6Dhg5Etq6blE4O+wy9NQ/0GgAvw+IV7o2rSm5/rrtDl7rDF5plOZFgFD3Q5sDIRN+T1BlH+qF3by4UOlGhOJzZEN5mMM5cQwQVqhlzIYVBvPR/wG/jnLrdyk0U1FPfQJtE98fzUsD068v0ctgyXRbHewPzIr/iaaoQq9FbkvMUH5jj6PV+CEXnuKX1RhlmPBhZkA41ShDNXFUaRKnphwlQwifxbBqNOfWf9xtMBFGtQCirBfJuVsKI3h2UD/NmH4zFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlNEwZMPY1k9qrA/qmc2ubtaI7ivRDXrSuyTKRxTkko=;
 b=frddzhpz9JLE27AWLtGF7Am/RDbrpZP/E6m1b4KnoaV3OKTjUpuZcBi5hq1ZqoWil1UWCrXqJWBjSQT0+MnQBbxa5VaKaXGYxx9j5o7yxucxt0Af66zZMrNQs3Vtf7IfknDpXH6RTeF5dIjgjSEkv4FLuq7f//w3svjm5UZYsKwpdpSrYepaaQtvasOlIg3c9899waV8/67DLcSVCN3QBkLlWjx3ibjcpzRXtPxmDpjugL2G4JA0aRiAb4dp3Ck4+hxwUMXin6vFa/6sGzpoj/6Ce1gtTdLMjLZc7oZii2df3aEy4CXdp/TsLno82iN28tvi4XckuFNPomMMZxEO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlNEwZMPY1k9qrA/qmc2ubtaI7ivRDXrSuyTKRxTkko=;
 b=Ziv5MzylQuAu3AcYu7pgsBQqQQr8cFWaSbD1UEwFBL8YeTqBSD7AwpnYG9XPR4PKbxclfnuN1YcT4aVEHDCwSSq4RWoZ62VEtNVw1pmfkPhbON88+BM0OoBZ9LYE8JELzG3kc6brF5YiK7FjjdkfWSJjmGhmbUkQZgnl2qSKDdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:22 +0000
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
Cc: imx@lists.linux.dev
Subject: [PATCH 4/7] arm64: dts: imx95: add flexspi node
Date: Thu, 27 Jun 2024 17:59:58 -0400
Message-Id: <20240627220001.692875-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627220001.692875-1-Frank.Li@nxp.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 51175c54-7fa6-4001-663c-08dc96f48aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSRV4d2KxAzogY42UqLPqUl6S/jjD3KRCw4rQjE/g3OotuReTUbhgWNaYwHv?=
 =?us-ascii?Q?XxKtFwFGY4sUcJ/UUbGtLqa/Ec8DP250GPPZ3GHaZ9ssgZxcCnBhAEFFNEbH?=
 =?us-ascii?Q?IBLmxQjitJbMEJ6+l7AD2X0gthW2g4plpTtOFppWQV/GMlfwhSKaO1migp8K?=
 =?us-ascii?Q?4ob5uucGy2rI6+YV0zSrTrV6zaXYMjt6TVtElgSeHCIOWMg/a0QRRsxeopaD?=
 =?us-ascii?Q?1KlLgpC23t+9l0+yB71Z0cTrNNqmwKShYs+j9jkaga+o9S8XJWBiqFovwBgd?=
 =?us-ascii?Q?st9lRtS8u4VXASaooievTa1/G5ygKC42BstLXLCrtCqM+atDx7KudA3dA+kv?=
 =?us-ascii?Q?Jyy1RSt9jXZeaMZlYVYT5FsZ34U9CGde5tthdTRZEFmxpWqpJHM0rxqCgXlc?=
 =?us-ascii?Q?fT7BqNAmNdG3PlbsDN9NW2FWUNmIuUj+6b14Q7far8YXJ5PhMaqePeVjAEzD?=
 =?us-ascii?Q?wmrIG7W80165WKoUWvA0N48SgIlsghpMNZa9TILo/2gMLZtE/DuvquKsQUzE?=
 =?us-ascii?Q?r2Db2+Lev0TkNPlYXqGQdB/2V+24KlFdv3GR5fR2K+Hbnc+ZV6PINFujKBVw?=
 =?us-ascii?Q?46g83F1k+cHboUNdxji/Tnaxsz22f6267E8X8DbkTOOJt/NX8F2m0B76R7o+?=
 =?us-ascii?Q?O5pDqPBlMrWs8KWPFThfrq78ZB+/fDinaykrqka4s+9a3BkE8xOed2bF0zru?=
 =?us-ascii?Q?xGAzSJqnfv04YOhtFgKeT7vUaa+9V3tFN0YBAzzKbbV1f19sg9oWLTWRelwd?=
 =?us-ascii?Q?rAxWVLquPPvCNYSakuzJjqXET6mH249a8qkt9gFZwlDkPTDal2Lz9JkrnXNZ?=
 =?us-ascii?Q?VgKgmdXsUOXspmZh6e3j+UBZWcKKRb1mDU7VTkpaRdHkXa+Zz8ulM7NHNhus?=
 =?us-ascii?Q?ZvG9RghLPi7H67v2exeQccCdoFeu6B5CLEKBx69pA57OYH6xjqf21tu6KjdK?=
 =?us-ascii?Q?v9cQTto79ZLQOxrzBpDCgQ/O7Qi+tnY0qqSH84FGa6A2ybP/J4fAIqWlzFzx?=
 =?us-ascii?Q?5w9238TMv4CqXy0ijvocV1ACUftHH81z5dk7UUr0fF0KE/0agTb59maw6wpn?=
 =?us-ascii?Q?qAZycjnRMyj0O4EbzjvUIzroed09xd2JYA0YohbgMbIiShvEIGFSecA1mDQC?=
 =?us-ascii?Q?ZvCFAQEjWMkanPKgmlnD2P052GIoNuP5MV98zy1hqf+fEQm9StpY3YAEuLjM?=
 =?us-ascii?Q?uwbubD/xcWhQ47kXeoqqIFzq6yMJAf0GC41lW1ztRGwPUJgqJ15vBTCQdB7i?=
 =?us-ascii?Q?N7slSpIGUWaCoVlFTxQ6Lq2A2xpMuRTUEaJhpSugk4XegMwlsqX+ZNRDfky+?=
 =?us-ascii?Q?wyGYgmuV4hAoDR0kSWjed0XpzfGLFa/7grGzWRbPiG5X1HCtz+UyR8z9O9wS?=
 =?us-ascii?Q?GgyqnpNQizyG5Zx14tmp1OKw0KNkkC1XMZ7ExwxsMEQFAUN+iI5enOL/jacr?=
 =?us-ascii?Q?4J6eOurC2wg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUs6YmDZn/BY9k1ixJdKTgmH8bJfwIKD6IQudf3rIh1FetCoSr2w/eYsw2JD?=
 =?us-ascii?Q?0i8KxwVMmUa4T9/Z3RT2ffyvS2z8T8ITjCbStQH+v/PiCHSCl0GTyeV1e6Cu?=
 =?us-ascii?Q?1jLd7sS1E8XK+G77osoFGnvSlwQ8U3jWuT+156m/jBS3gETjcSQ0iZszd1+h?=
 =?us-ascii?Q?6gF4MVNrzugrTBckrUQpzHrKUziEf+Qoh191kN7FjmBiDp5Zksi0vdaYpCmw?=
 =?us-ascii?Q?JYFkzPpKfTRhq4mHVaK0I8B3GAGmwKBXTkzw/OX/qkilEJbdQsPTPhNi74gK?=
 =?us-ascii?Q?2myhVpB8nKqDKl7fapb/plXqTppH640BaeEVLYSSw7NFaRWe9nd5BUPeiil0?=
 =?us-ascii?Q?U48mAmXlyUifEOlGeTrV55+Ucc8bZF8X0VKaZEG+Qtj1eqmACeTqONp24Mz1?=
 =?us-ascii?Q?6YhdS9ZcGEmurQatxVdyrbWEFN3zbn/pZ7ejO2OKZCLfv8jou5FI3G1RTlzb?=
 =?us-ascii?Q?9nT1noA3NhBCgnZbHcbjx6QFp+bY+cL4SbO6jzR8oUPOUpMgTYjULRkdfKRH?=
 =?us-ascii?Q?TdNLFxTIwNm67it5DpcAu+0JLhEMTSlHkphqrAn7qXdjXv4zhLNV247z6dk0?=
 =?us-ascii?Q?CNhYjwrT5OQof32MGFcDDMvM90PrrpyHHJq6dFb0Oh5PR9GpeGCPNtkK85G9?=
 =?us-ascii?Q?t9IteZIQdGtzPw3AW0qKWX+Jo+x2PoYqOoRC3Kou9GkQrRvTIspzH0Ec3AMR?=
 =?us-ascii?Q?70YL8Jor2X2Qqo3DakFkn27XhyYcoARa6LtvKp6S4yCci5v6NcE4m8HRolrg?=
 =?us-ascii?Q?1fYp3AMHq+jcN/0UFrLxCIcOSC8vkDTyklKc9Lbh0D5f5tturfswkt3fCjEW?=
 =?us-ascii?Q?FUS2QcOARvhrTzgBzjFoB1zrV/pN/Mvut0VwwJuiK8E55XFR31xAuv4gOvhs?=
 =?us-ascii?Q?o3s3lXmJsywFf6EfTmOQ17CJ1JEEKrtRZD0ixAR5lDTTsyIqCzU5x9ukt0Qf?=
 =?us-ascii?Q?dZIjjSPdBun7Mv5WbDjrODdzVvAnLRijSfcxINwphb6b7qD+LxvRGgJMtJoH?=
 =?us-ascii?Q?WISziI2s1skSKcBvfu1jkrhtDwWZd401IeyXLpaJ2bFGT4cwYlxWLAYKPwOI?=
 =?us-ascii?Q?jAvHEWhU5X3D5+bE4RCmizKDsqbZ+Nmvkz3UbIJU+m7nei2wP7c2swoB8VOw?=
 =?us-ascii?Q?Yk+aeAZGBTT8jmTpMkkNL5ELFlXlMpmHIG4VaKNlZuakVVmvFk1yS6LQr+lv?=
 =?us-ascii?Q?y+C8ppCvx55YYHoRKReC2S4SyGwDwF+GsPApx4ZBJDbHVYMoHho9sN1GV8VL?=
 =?us-ascii?Q?KP30kZUn5TsF2/Pw8YYTVfw9mvQcCWmhADnG7g1OVenvNEjXyZ//pgUKcUMu?=
 =?us-ascii?Q?+RVBNG5E2I7VdauXDl1BH3m/OnTH+DVIIi33r9SzabXpfLLez3uT0j76wtYa?=
 =?us-ascii?Q?UUpd+eaVW4KfFPq42/lsqT0ILKwmXbzDllYZJreOckzacUtUIKzMNPlTDiVE?=
 =?us-ascii?Q?oHixGKK1CHvt9prEmsQ8kQcPULJrR/H/cGja951l1GEZCdY+5vwpAAUvNERZ?=
 =?us-ascii?Q?1SXjstN+ne4S24VgO/hA7AwNa8osFjIdmv/yZnL6C8PxotUXBKvJGKGXaDoA?=
 =?us-ascii?Q?bwSPFNAMbVmO8nvQjlA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51175c54-7fa6-4001-663c-08dc96f48aa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:22.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +T7WmhWZcT2AFpLKRS7ZbXgn34IjNNE4Uf0apJI+nB+2xhz1KBUrFjr0NRynx0KzuFEDooI3kMSHS1z1294X0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add flexspi support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index d32127cf7018a..0870c0d13e041 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -713,6 +713,22 @@ lpuart6: serial@425a0000 {
 				status = "disabled";
 			};
 
+			flexspi1: spi@425e0000 {
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_FLEXSPI1>,
+					 <&scmi_clk IMX95_CLK_FLEXSPI1>;
+				clock-names = "fspi_en", "fspi";
+				assigned-clocks = <&scmi_clk IMX95_CLK_FLEXSPI1>;
+				assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
+				assigned-clock-rates = <200000000>;
+				status = "disabled";
+			};
+
 			sai3: sai@42650000 {
 				compatible = "fsl,imx95-sai";
 				reg = <0x42650000 0x10000>;
-- 
2.34.1



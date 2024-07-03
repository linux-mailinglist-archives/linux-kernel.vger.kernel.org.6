Return-Path: <linux-kernel+bounces-240163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528739269CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DED21C22FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC14D1946B0;
	Wed,  3 Jul 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cQl5YRTh"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D41922E6;
	Wed,  3 Jul 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040352; cv=fail; b=BTT0475/+MUK61EW7fCYJr+WXFGfZHZM26zy+IqKx+qBcsu2GLswzFeGPLTSeaZvUj6pbC1L+1XKJ1YUpU/wP5P9UHD15WRSYXh+ngJJ/sofOzoynTX/SLbMdJpCJk7NOCQmsPdfME7uyLOutOZuAEO3voMUmdCY2dPoNTBk/ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040352; c=relaxed/simple;
	bh=VSfietp3z6HUffS8Bsju/52xSlCZZZaB0BmqKbsp8Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhIGu8j/h+QU/qNw+IXmnxNcJdo+UKryBfuYZjz1/gThI49tNd/HB01iXkR5npkG2EhrdqbPAs+C0Zvz9zNmavnn6Defuw6lzUtCEflcirE3hTUQLg0nVFRtzSGLSsvw3KfvfPTKkqw6ZAJ+CguQzBmPjEistOL+cj9OjVFXHfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cQl5YRTh; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfvypXPaFgC2ddNOr+LfaZGyKq9b8/O+OUJjJ1oSh52u+qUF0HOzXWSHgM8EqpHbohAwUL60POHm+Rq19LuGJHhYisYZMANhx/9kh6cVovmxbcssWA2mP4HovBn5MjrCNCSrLaNtF+XOyu4zKBSaF5f0gf6uiZAs7xVH21XOEiQMARENGvlNDONdWQhB1+vkyeiBMwOkTwhSB0QnTvr9/tZTaL6U3ys07ajuFEzD6wFLE1RWtCNKV8TlGfoRK8uKakoO2JWV/Ddm90XMMTzI4pHBeESrFcBJpyQQoeSGod0KXHwtMYcvjJIZKAHTYB/Oind7qWHTCQ3ajMN8o8h5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4U2z8srIv/CHkBu4/eYO2/Q1d9WYVOgxdGhhQiizYI=;
 b=aMR/QbIRJfKs14BCkxcdA/AuZRez9/AF3PHceUWx9yfo2Bg043u9O/h+EWj2+YHQr40NEFLBhjivTmpVJiUXYHO9DmrndEuDxfFWKddwYsbCONulfUGwr3710bpgvPJgxziODaEELA6ru8kRQhVKOK3eP1kbcP88V4eZdmT+H5CUkjIztOH0WXC4YZ6gfYlscaXvmtFoeqUt/vU7ZOfGNU4bJefVIxAM+Za0mypDPxBCCfg0t+JVqOPoelhyH5YooeNCIRgYl453BfSW61Uu4yCDG6pgqxYpTwaVwFT0GhzBcwxiNjf4i+9PWaqjWqC2H/8GkUApVIZMF0Z/F2BShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4U2z8srIv/CHkBu4/eYO2/Q1d9WYVOgxdGhhQiizYI=;
 b=cQl5YRThPtI9/UPbmQsC2nETmjZoyrH048lmlq6lFTXsED3zJqZ12FtLvhHEOMQxnWQ7pFwK0m/tlkAREY4bJs/9VQfwYrWpGnbO+piN25rpMVPR389hIIS9gOJtkogEBXP+A5Prj4qHWUaCQiFlthKKv4o+ZKYXb3DSfqUo9rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 20:59:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:59:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 4/5] arm64: dts: layersacpe: remove undocumented fsl,ls-pcie-ep
Date: Wed,  3 Jul 2024 16:58:46 -0400
Message-Id: <20240703205847.2826263-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703205847.2826263-1-Frank.Li@nxp.com>
References: <20240703205847.2826263-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0055.namprd04.prod.outlook.com
 (2603:10b6:806:120::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: 808fd2b2-ccb0-4c12-794a-08dc9ba2f99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PFyTmUa69ZFAX2oDD8h/ANAN4nqo/fT1/wGN06m7KaVNJug3F2/nPGxkpWQU?=
 =?us-ascii?Q?SH4FzcKkxWJfa4xSbetTR9NEtU00A5a6zZMBDuh9e/T80obUuJcUut0JcyzU?=
 =?us-ascii?Q?QoDADGIdsSUv1fDqdDwEQtzVfPT3r42THHKO872Zx1Cz8wNR8dNHdF4F3cUW?=
 =?us-ascii?Q?mYjPRh6X/J+ND1Uk1chhktMoKbJJmXUjl0xN9IqMiFw99KAz0K4hQV1ynzoU?=
 =?us-ascii?Q?omxK5SOfeivTN9OvJO8QmL4SXVaiInFYcIXfDG0dOldN2c6XfIjWgr4xlvff?=
 =?us-ascii?Q?VR9696DZPHH7WVMnFafig6NxZ2WogyTmufYM7gMQ0+8V+An2hKgN02V5bjcN?=
 =?us-ascii?Q?PjAtkxO8dIKyfxMI2v7hLHpL8Rf2Pt08bHt9Zk22eb+dLdlxkherM+/XB4Dj?=
 =?us-ascii?Q?mNFVGqDozIIdCLEBv2qYWaicl/ExNSAgx+AHGxZZzxGNobPr4Y7d9WnCM0mU?=
 =?us-ascii?Q?wbZ6Z8STuooyrfeoka/Ejrv69Tyy/vPBMdc9hh6og8wdlCOgBo2JxiLmU60T?=
 =?us-ascii?Q?JgLxs8tFkW3PcMSzNT/CPq7tDempKuKVrZOGCySj5s6qz0zBxjv42cj3bCt8?=
 =?us-ascii?Q?+RAhAszdxYT5yXfhs4DmSB5uRDNmsxL+bGXv32NyrFVwjVDmMaCbNorMrSd4?=
 =?us-ascii?Q?h2/C13W45LuFYkltw4wn+NAgUdm1QVpSNCbxILr+Q7IRPNpt+GCCX1OiLk01?=
 =?us-ascii?Q?IJ0tu8Vi12XGEnrM2uhVNMC1iQeawKiLiOba8rmxpCic85lSNyaAUhcoj5cv?=
 =?us-ascii?Q?Le/JgR/aZvN6Ypkd0iowBe/4E3Wkix89higG9q4U+xtqFWRR+OrZwUmmNkSC?=
 =?us-ascii?Q?O2jkbeZDmWZhEWRuB0W9mEfPOm+de2oFLvEMjqJxJ/ATiLERYuCmUX/CdMEL?=
 =?us-ascii?Q?Ncqz2kWF1vkWXPERL8TcL4U6YKetbXmCj6GSmAblWLPpbVbx/lOUAy+M+LEQ?=
 =?us-ascii?Q?Cp2kE5hqxO7oZqCIKQAR1rkFEe0O7WupwU0jZz2hGqWVFX1bDs0b1QW1D2lp?=
 =?us-ascii?Q?TsjjDaXBZ0ZtpyjNVHGdlpzw543qm5w3lzmJDAiEIGu8Om002lYNY/6K5N6A?=
 =?us-ascii?Q?u01dL3uoFkkf23iQL/Ymsqr2oc0/5RN5a+l5vnCu/LYhRv/Cycrt+ZXbbNVG?=
 =?us-ascii?Q?nxb9RWK0AJBo783oF+3gZ1EV+SQF7iYewigVrhSOT4/UxkehkhsY8t0IJY83?=
 =?us-ascii?Q?rIqZJFvUJAr/cWh5vfScaywLiiA0nkmaeEQakd9jpFu3tBFRtcRWpQuy3F2b?=
 =?us-ascii?Q?2XDjmB6NM3LcCFriTIE1kHgAsz6ArQUS58Ltm5jrslNHkbN2X5dJGO0VpeBQ?=
 =?us-ascii?Q?3j+gEI4wDN1vQT8JMdXvfOB8DSnpgDhZIm/iJAMek4GKicaBsmpUiQ5Gnzba?=
 =?us-ascii?Q?/UgfobM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jh/gGKdebeqtjYjxqM2Lf7/jZbmHDoQn9vfOtj8eh0yLcrrVWuv59X151fDP?=
 =?us-ascii?Q?+9IYI2/PvC4ldvqh5G3CZpNfzAK7oBCe+bUit3ULCeAa1t6GuMWAd3eQBAty?=
 =?us-ascii?Q?QoYO4WFf82rc/jQ3cJ8k7wTBb+6e00ygYIJIMhhcDwnEdYf3mlB1t5ox/dd3?=
 =?us-ascii?Q?JAVnNp9Kj2dLIWFuui4aKcykC6qsXJO18/UwtAkkxz8avSzHm0B9biKU8LMm?=
 =?us-ascii?Q?m7PwSJaIpCjdQv2MnHe/wXDh2sg5W39GmoNsYgXR9jUF7r5fWAnVHAPssJUG?=
 =?us-ascii?Q?4Y9LtgCIblNkySUSXNd10f9VfuYIlHr9ANBRt7/EiI+l/dCIWSzYF8M6lrZ9?=
 =?us-ascii?Q?2Nzl88SLV3lx2NtCqjTtWyrNMxJxlEVBFcxmqcpz+b1zO11r4Mg6AHKtXkLk?=
 =?us-ascii?Q?2+AhjqKeDPH9YcwsKuYhqcZCPKZSUE0l0vGoRJQaQlr/CxA6qqNQL3zhh+tO?=
 =?us-ascii?Q?bxWlqgTFlILT6o6IU0tL2Vk5b9KRNwQxmHVyF7eI0VA2DQ5GjSTxJBhFO0Rm?=
 =?us-ascii?Q?9Mabslu/ikahhNMwebSoQ+77gXAZDAp17rKz3sjIMwE/8cwdAYa738Mw6uvT?=
 =?us-ascii?Q?YPVQAmfdwHboDiusiUjFO/2vwnGNY5FOnn6E7aZIdSRChdIP6SE9miw6yiN4?=
 =?us-ascii?Q?97ndqE4pdXH774ALDJqv3MjvLfKlB5QuLR1NWTWtENGSMfj6eF+Aj+Zy8Zdy?=
 =?us-ascii?Q?B2gp/cnG5RqGvFNEx7/Vondh7j56qoJIIBK9bAkDBoEwfHo/5+HDhtj/sBv4?=
 =?us-ascii?Q?AF05KBnVd3lUbtPEYoNCZy5OhV/CfKDOOtRTmF1TFFE+a8m8VivXq6nktYMY?=
 =?us-ascii?Q?Q16D9NsDqCKAfUCakypIOuaSK2hsOxdW5xNKWIEIiLuCsO8Lbc8WesG6QV5z?=
 =?us-ascii?Q?d9cnePMtuNYMsj6eUKHcMFM+Gs5WeGnSW4c9yEoPNl3tJNmZxLCHWWw9GJPs?=
 =?us-ascii?Q?L5RYnyV1Fcn7uoYfiXFypogzUi0gU6SXKz9+CiYORqXg7qTytXn+MAMwoalh?=
 =?us-ascii?Q?OWd3lYvfmRWtIFAGLVKFAgW2RO7VvW1MCexYR1MLI3oI/n+wmyitJl34euSM?=
 =?us-ascii?Q?/fCjpPhBgrRyNVhtUiuxee0idIXRianxNyyRztSqop0sH5OZg/WfvIf1npkb?=
 =?us-ascii?Q?eBCujZJYCZuXakGg3NyR7g4PMudlWfSKhQcekk0A1WUp+LG8/ahvI8PNlZIO?=
 =?us-ascii?Q?jjyUIR6g6Ex3rv+12CrNVMpJ3f8MXv21MOWowjNQdN9rgGWEJ5cu26wTP7N5?=
 =?us-ascii?Q?J8aOeO79m0CvK/+JLayE97uQ38PCBwRr4m3wEEhLxrdOH68qYg09waUCq3lZ?=
 =?us-ascii?Q?qLIOp8p0tg/FUfqJi+uAlPQZIe3I2nDrYmGs/1yPdHkuB+dtB4tQIaaunwil?=
 =?us-ascii?Q?jdByXoGPjeKxTEDNhXgjTt13xFGFC72RRer82iS9Q3HJdc1ueVFPyD/vqFkd?=
 =?us-ascii?Q?U06u7+WRK77ZusPSWTXBDAA/xBnTR0MmMAmW5HjSF2xQ79GK7vtyuJfX9mCa?=
 =?us-ascii?Q?ays7GnZykfo0j8UJwp7n3y8kB7x5XEU6qnOLtMKSbWdbvmf5Qk6peyOw9Xzh?=
 =?us-ascii?Q?YNz7oV1WWWSeoDzpkn9dLgAI9CPkxZESov6DOtaj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808fd2b2-ccb0-4c12-794a-08dc9ba2f99f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:59:05.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8YsWxc2S711NT4HEVWxmaU6pcg8kXzCYJUDUY6JWzm83KIzixsDD/M1dtfAxqRh/MHxoKO5qgiaCNGmeNoXVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

Remove undocumented compatible string fsl,ls-pcie-ep to fix below
CHECK_DTBS warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: pcie_ep@3400000: compatible: ['fsl,ls1046a-pcie-ep', 'fsl,ls-pcie-ep'] is too long
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie-ep.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 1ae73708bdc60..c77613e98e539 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -820,7 +820,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie_ep1: pcie_ep@3400000 {
-			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x40 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -859,7 +859,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie_ep2: pcie_ep@3500000 {
-			compatible = "fsl,ls1046a-pcie-ep","fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x48 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -898,7 +898,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie_ep3: pcie_ep@3600000 {
-			compatible = "fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1046a-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x50 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c9459e251e59c..c453b59598f17 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -588,7 +588,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie_ep1: pcie-ep@3400000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x20 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -627,7 +627,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie_ep2: pcie-ep@3500000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x28 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
@@ -665,7 +665,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie_ep3: pcie-ep@3600000 {
-			compatible = "fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep";
+			compatible = "fsl,ls1088a-pcie-ep";
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x30 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
-- 
2.34.1



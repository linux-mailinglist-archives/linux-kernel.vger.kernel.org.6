Return-Path: <linux-kernel+bounces-197535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7E8D6BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B491C25453
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64728175B;
	Fri, 31 May 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEocHA1h"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3307F7CA;
	Fri, 31 May 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192241; cv=fail; b=WJDxVjk65yXQJX/f8EjZd1F3HMgSYvPrUjQXIku0YD8KNCEWKodY2lPTfJ1dxshRlapq/jHfAErtmsllo/XHcr4UEOiu8bJYylndc7YWVnC05qDM+Dh3TOaEZS0x2MA+wuaD52b5frUAX6h6FQcyGozp+RCkXLlF/Cmyfo1jGRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192241; c=relaxed/simple;
	bh=TLila5dn125g/eNGyDccY4e3gXFp6ZrmOBjDpPzUy10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TuLn9NPiTzOXhOqH1bmG89p8YEgxipFLXfzOU0FUnXgRJtQL4tl1qFHlJnh2wMl6NtwNqdbTmUQdg7WdiOYzbqd4iDfhFnEbADCHKQcj2k44PTs0qtoDZOkXJ7RGOl2DwVZ0LiTciOLz6+/kwxeFZ9kB9QL/Vx/8JrigWlmVB+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VEocHA1h; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzgxx5ioMtwv+mP2u6aFcg83W8i96psdcM+Fv4BuGoWmKMZ3Yict2UWo70pAAdwO1x+n4TnIm8KK4gYntjembbuFAut39vDSapvQhUht5d9ECKteBDXL/ZHEEGEl9BbRYFGCZw1o2/a7MtH69sbYJLaOw3H83Btm6eHrfwqdwSklc4vOnlkcPBZ13INzNAKEhVnQQ3FEDXB68CVVTccUYU8ZnTrUbbislPZ6aHI7AH6PgHyBvMaGVhwzku/lLQVB81IljsYRA35gcyxecaG9cc+IC82HWksPnyx98JCqziPsJzWF90N8ux2IDk2ii9GHnpQaUMqCkt/djVWI8ebx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeklyVWD8Eu/VE/uMnm8LtLOZ+EAyIpTU5PDlkMrGCU=;
 b=DfB4YRWe7E+0OTM/PUigxLUn9tCpJYy8gvJ7x/9ETqUdfyUPo6zPeChxpVY3YFMfVnEhqgEqRpJ+COtb1PkAZjQzlgAQ5hnljBBLNv652yH/cBzjBdQhtN8jVWfqvnxLmyN62hmMfmgQHJMPRWspmcEftDgAXfvoEYyg4YTBD+h9E3DY4/L4dDWlRc5GrBZta9ZNkbxNmqM8077BXq7z4Q7lzPV1+aaMcdkHIcDJIxOuqCXDnZEjTlF2oDmxZqjdJa5Xr8adRmYA6w42ad3g9Cxlzx0fEwPMLLrbTxRsKMUAEayBlt9D2v3U/j0TCIAYptThdigNzP1adWbra4rvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeklyVWD8Eu/VE/uMnm8LtLOZ+EAyIpTU5PDlkMrGCU=;
 b=VEocHA1h/XIgxrx4vJplm/SU6bhrStrL67PfLN9B5yOC3sIdRlVSTcZPZRboAYDil9Jh1BxSozahSqXDMQjlK13qljt91fv6UWsEYIVeu7Lxt9XEadW/WAHAnxCGwVhr1t1jIRaMRaZp9ba+8eJwUBUTDa0/KJcOc5Q6yTJdZkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:50:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:50:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	shawnguo@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: [PATCH 2/4] arm64: dts: ls1043a: Change I2C clock name to ipg to fix DTB_CHECK warning
Date: Fri, 31 May 2024 17:50:15 -0400
Message-Id: <20240531215017.1969431-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531215017.1969431-1-Frank.Li@nxp.com>
References: <20240531215017.1969431-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da88a6f-b662-44cb-c0a9-08dc81bbb4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FkFuyvtI+54XeoPtAP9yua5gUFYMKfGJmrWSieZMcIlinePLotYpZfrfNnlF?=
 =?us-ascii?Q?XYpyGaIJK0o3/gE84Evp2epRJABAcSFdcC01cNc7OZ8fOSXddF7e3rXaypKJ?=
 =?us-ascii?Q?MWLltaTx60dv9066J+m1PCzzT0bakRfsaAV+hPffnSIf8Og0QBzOpd5eYcAT?=
 =?us-ascii?Q?/ICZkC0Y5MCZg8Ui2ih+J3mvK1BpRdgGLGQew96BL0C6/DczslYzuBVEC+CA?=
 =?us-ascii?Q?Ii1u8NfhP2QVLs4VvaCK0fWpmy2F2CCIrBM83qx4+YZ/92dghRVsWs4ovFkW?=
 =?us-ascii?Q?UTJTmXJzHF6apTm3uTj/XvkWBF1Z3/iYl40fFj+ixc7gL7EsVr+XP6AEu+hY?=
 =?us-ascii?Q?kwAHhmSGFVm/7f6qsHyy8kN49dHgNzT3DYzXW1H7Zv6H7JtWLJJGA+4Rd0Ki?=
 =?us-ascii?Q?gB5X3w7BfcKl/u5n6/Q6djdkmZUqtO5QRvA109sNMy9E9n7mOcpdMYtPDNdh?=
 =?us-ascii?Q?uSG10JSCeae19wa8GMJybNqVCF/yy99iB967t1zTfDEDOVLL44d0yKcnwOy4?=
 =?us-ascii?Q?tGRUrUT3iooKR2UZHxxMwt1tG+89jRi7hIo2ES7Uhe+aUC1t0qAzt7qh11fG?=
 =?us-ascii?Q?1I9SP+NT8YU50iVwMIWE4ohLMTGG1feBcYaFL/sR7hXrGoEuW7kMDHc4tUKZ?=
 =?us-ascii?Q?oo2qKcinkUo0F1s54torgcYRcW9GhTqxTUXblb2d3LvmZijO5G9pmAKINxA4?=
 =?us-ascii?Q?z8glY14SKgUPyjH5ccVAgoBJ7tc+4orAi1ou/snJp0FvVpFg3fr2dFRV/1tC?=
 =?us-ascii?Q?LX1swFcxdLvQKOY2t0XfOu+tdQMV/8zrOMlxZ1yDxYwIUlCmTBYVfKPv5yeR?=
 =?us-ascii?Q?+Ac3bZnu8izWcUOVbYrYTsNlSgJqFQPVsKC422+Pr91+r4MS9PLUQO6Kvaik?=
 =?us-ascii?Q?FJfX/tQS17yIxm1ArmVaX+3IRhTDtP+1r5YtzoHFb+kSAh717d4RHMhhAK0e?=
 =?us-ascii?Q?jTtddMxg4wd+YrIAoMvnjPz9AywdWpszfrXQ7qBW80yN/IWlM91hNsSVuCyW?=
 =?us-ascii?Q?YKwdx9G9CqGKSzmxyPzlS3DQZwVFcTVW76PLPC1u3gMSZ8l2k+smk9AuAk4g?=
 =?us-ascii?Q?WOzQmeincKNUpttg6w5/bk+NMRAgfPw847f10Ia7JHNwFTzlXZVLe6BcPrGu?=
 =?us-ascii?Q?asyEwP0/m55NMykX/gN5RK7LhtkojY5ZHBMvclrbYwu90MTHx/fdH26Ftkrw?=
 =?us-ascii?Q?7VG4x3uScvTss3C+WhjFBJly6vpzgowtO9HyX7N3yYr2UHVwvmEpkbsgvjRk?=
 =?us-ascii?Q?fHS1PdpJAaY2yzHSHf6buFne1U5ALQOpINcJabsWkYmajzxufpZSVgi6X5sR?=
 =?us-ascii?Q?YvJCWPL+Y0TC2WrLG7zEUsWBMr6MmYsNkMOiX3UNcKnnjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKdHlKKM0tPBq18819gqS5xI7m+P8OkxXyI55n065HJfuNHj4HRlx1ffJpS6?=
 =?us-ascii?Q?x1GaWGSEUIwT39XD14j2SdF6BuVzIiehR6OcLx5vOX+xWKtdLrIWyZ/c+XX5?=
 =?us-ascii?Q?iIjKCDf5nnZl3Hi4FF+0SbCXaiT3I+e4F300hMfDWtU8hGf3gfk8JdS+XD3n?=
 =?us-ascii?Q?WoWTFODVtzTqHc+UKTRY9HUTgWdWDd7NROj3hI/1xiOk/fyQBnUwaNgZASX6?=
 =?us-ascii?Q?LSLwhS5PKiBCgn0DRwRfutHhPDFOdW0TifaGzyQMUUDbOwUtb6K87K21aPMt?=
 =?us-ascii?Q?NJiHOTBMXqgapoxaf3fsnKfheEB1zOFMseEeHy31uJLq0WJR2dcmkB4hozaO?=
 =?us-ascii?Q?xH27UcfOwMn9aEG6YtyYr4TBjo7jS69qIDPzHpxN+nh4LEx+zWIu0y9eL3zi?=
 =?us-ascii?Q?+PNjrMOyWEXedR4MrHXtFd1BL88EcJJwKfrhKm1pGmpML/YN7+mFJKgE+LSt?=
 =?us-ascii?Q?WVa9t8vG+4j6tUz9ubDSv8kNJXDbJHiIspRwNSyZeOG0I5lK3KxGGj5QbKtT?=
 =?us-ascii?Q?jr3dJCVk4SzCCYti3RZAI2bY/RF9gIVUWfYyI7Cxo4bBV6QE12Oaew92DJHN?=
 =?us-ascii?Q?4t+UOVzuHFHf97OVhgGNAM/k4u9o5fNQXLM2Zl6GoTpxqlmmeYz54dODVunL?=
 =?us-ascii?Q?scDGn+HRepXDtkr+GmwOunXLuqXD6auwBdHDyKaGQmNc/RdvbgkJqzF3vd0c?=
 =?us-ascii?Q?q0GmIsA4gZjt2zTLHFQIGfNU5HPv2og4Yf/Y1O9VqiLbUDWeJC1xgB9m7e+y?=
 =?us-ascii?Q?EItIdMlcWl+tOH0uhiZujdjDcm0srhbsJ89gbYoesq3wcbFOCjut04HY6Brf?=
 =?us-ascii?Q?5BVszYgII17bJgOL+YoiEzFro/8GP2idv7iRaVkMcc1RlZPP9OSLTc+j4IpC?=
 =?us-ascii?Q?KclAjJtq3BZpb7rKSG7qi/JAluBdtVhGJr9sQVCbplCyhpc1fOfa9o8P2v9m?=
 =?us-ascii?Q?bVkyzx7vY6evZt8qX+pLRKxd9+RZOFJSEqZE3jwG4sx6XWeUlNwsOfFlBxWA?=
 =?us-ascii?Q?iTtv6b10EdSQ7z4vCqZoC8KoplqaTJ9r4QD2eH3050gXbaFWm20U3+TF2Gl/?=
 =?us-ascii?Q?zO966Jt8cjH+BkztyP6SgquUo6a4BlIHdd85I3kN7V4c3VR4vjg7eAzDysJk?=
 =?us-ascii?Q?lat3proVj88DXQp3d16NeVWpyUvGh1os1Z2FUeryRPC00leUNbHQtHxAZRJm?=
 =?us-ascii?Q?Z09JxyewrmMmoBEAvlp0dRdF6ptGyCIr30wFLFED3rBBe0WNU/E/rSLGZ+zw?=
 =?us-ascii?Q?2XvVHZwr2/hhcsJ63qeTZoRRT3iHPM+25CetAispAtFa7/fmCHhuqxfTbCh3?=
 =?us-ascii?Q?N9EX3n6uJNEVjPoqiR1DzU8bPEnFMN5Ex6cONEBWhRZKWvN18JGLjU4l5NUR?=
 =?us-ascii?Q?xaIdY4IM7bKKDPvH3R6j5/sIXf2/StSDFOHRUcnpF7UQps8fIN0iSKMRcfwx?=
 =?us-ascii?Q?qI/dPReP84vWyeonrZk+fEWhG2BDh++MW8ooJaM/ws5p3IW8lMHqnE3GAZ+w?=
 =?us-ascii?Q?OvroIMa/955sZ9NCIZIBLruys3OD1Dfhpa9ontSkTewM6hoMCByjuBakEgsq?=
 =?us-ascii?Q?RATkPN4V/z2alM7AWc+OWb9T1URa6HDpUk8ZbRsN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da88a6f-b662-44cb-c0a9-08dc81bbb4bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:50:37.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgKUEbnSgo8Yj//2+PHsyIkKRsEgx4JenwJ6G9+mFf5CQ5J9Wj+/HRbNZZMfydxhWhzMH4vcVh2mZy7S0/Anew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748

dt_binding require I2C's clock name is "ipg". Change it to "ipg" from "i2c"
to fix below DTB_CHECK warning.
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: i2c@2190000: clock-names:0: 'ipg' was expecte

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 8ee6d8c0ef619..a4a476b04ebe3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -533,7 +533,7 @@ i2c0: i2c@2180000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <0 56 0x4>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			dmas = <&edma0 1 38>,
@@ -548,7 +548,7 @@ i2c1: i2c@2190000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <0 57 0x4>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			scl-gpios = <&gpio4 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -561,7 +561,7 @@ i2c2: i2c@21a0000 {
 			#size-cells = <0>;
 			reg = <0x0 0x21a0000 0x0 0x10000>;
 			interrupts = <0 58 0x4>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			scl-gpios = <&gpio4 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
@@ -574,7 +574,7 @@ i2c3: i2c@21b0000 {
 			#size-cells = <0>;
 			reg = <0x0 0x21b0000 0x0 0x10000>;
 			interrupts = <0 59 0x4>;
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
 			scl-gpios = <&gpio4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-197536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E48D6BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFD288936
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004082490;
	Fri, 31 May 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eciAumpP"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB78120F;
	Fri, 31 May 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192243; cv=fail; b=qaGKno5Y/BXTZIDdLkHbMrvi1+bz1tvJo/no6qNWdEbXW7wFgxHyYxouanUfI1KbvIKnL6q9pQVJfEK4GJScx7/kNJuaqNsE4//fnCc/ULkemf2qPYkitWSuQqjkrzRJfJjFAvfNwoQ6FmvgCGX81YHFF2hm1TzpHitRJhiwiV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192243; c=relaxed/simple;
	bh=yycNzUXf5Sme9HuGzotdm2HFLb9GjXmNlpSpArLkkus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AuAYGMceIu+p4t2RV/r4jppH7ySbT7BwjHEQpgCoZtgy3wJnSW7HK7vAjUoGnFJyMEoWTgnorUClqlWK1GCBs0obrpr0+JTa2LVB5PHo6F3iKdeSE78OnjutYKXhi8zI/1aZxjAFOT+/sLi3OCXSwKcASd4hjaFwJzulgWPtgtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eciAumpP; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2EXpds0EjRD3oQbLZHc1rGmIyKSAtCp3Jp42gq6Z5+sgcoQLEYou7rCVDbhPI1Y71Y3GcJKg+qBNNlZGKoywGOz3Zs1NsM0GcKTb1fKht+0i+SyQlKmZxCzcioy1qCZ9aHjGO4feXg+VJ55UuOI/2sD2hbI7ZuQb6+XMtQr0Y6Ls4FoR3DUZKmxZheJpE6nbIH3jrHsK6oW25yR4FqIhAQm2fcNcCPsDwGFR5qtwrHVhMxB+eKhYmowwBqvyVa9CvfayTKnd9cH+xcZ+4DpCJNpTocrcSB8Xt1/I2cbT0NJX+jX3fZRA+EHaLEpo674b3IoCncV0JIzQEidGaoWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0hgsfQv43en2E885ScYVNBU0pSrIvobF/PPvEQuSy8=;
 b=dK9M24RZ/1mjeqxdD3qYOJbr9AWCU6qOpBof2cQf4WuLtVO3w/RDmAXLNSKYNVkiMT0/nRpUH5YWoHf7trUeDjutn0sL7HMEDlM2cZoCipgzRhZy9PEDtaB8NCSGOzZJ9dTgx+Ycjd9RTAC2v9iYnh/O+S4u7T/ub+vHkVndebdrmwaBgsoKgKyZ7L7MXoB7HBhR919Tkzm41SVf+4+nxfLlLy+R6KBpxmUaofqmO8p8NxOjp2PV5IXD1cN2nsV/BT48+0kZDF3o5HrYoBuJ1XFEcPPgx1dwzPtHOIxvbihvYCs9bcqlQWzvQ2VvtvLALAs+NaqMkZsuMIvRL96pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0hgsfQv43en2E885ScYVNBU0pSrIvobF/PPvEQuSy8=;
 b=eciAumpPbPqSeaMtFfxsHt3AytSbwW1h66684ZoqkHnm9BeEmLN7bh1OS/OMF5sWE/mQGZmeYG9rrqd9MiOAYyst4R4sO3iv7c5xTOMTHWcwTW1WyC8U3l3qD8CF3EkxbU59EV2T+vR+26RvIKXT2yGrZKeQGAYy3WCVFoEFUz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 21:50:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 21:50:39 +0000
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
Subject: [PATCH 3/4] arm64: dts: ls208xa: Change I2C clock name to ipg to fix DTB_CHECK warning
Date: Fri, 31 May 2024 17:50:16 -0400
Message-Id: <20240531215017.1969431-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8732a722-c3f8-414c-484d-08dc81bbb63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUa5ZtcjIPOkarrWzOLWeOkFd6oMWcYBqZQp+uZ+5fcLxjsUHktHU2+ngSR+?=
 =?us-ascii?Q?/y7pyhTE5WS4Yd6KOnHPrCpCXuY0TavDbPA3oGVDU7mMTuoh5+KUUppu0esx?=
 =?us-ascii?Q?HNxMlqMPl39v4hfNo6abseJ+Nv499whDa1q5/NMhlf7fAcB5zrmVHZCvHjPl?=
 =?us-ascii?Q?pVyWmzlGZvtsHhL35B6LgfpsTzetLDv/1/M0bDzvBlH0eLStCmgMSxoWFmym?=
 =?us-ascii?Q?r3DU/6dskNlatw6ZUb1cFLfwKSmbQ19eYEaEgrW4p6Yys8SAIIyolcaTD5jh?=
 =?us-ascii?Q?YBaVPcQ9grnOayq7q8up0zYWV9WBQifBcwYUNiKTthb7DqKLidAoKyXYNt7h?=
 =?us-ascii?Q?zVNmQgnQZz0nMxtSD6o92nuTZBJ+oK0VcCVsiP+UePL1OkVJzz87zZqe/PUr?=
 =?us-ascii?Q?fpb+UMz6Wj8hmD2afttiREmBDj1lEzFOPArigNRpGs1thn3A5ME8S9wa/28c?=
 =?us-ascii?Q?t6+x66Ue+n/3KtmNhcdqxic09KzfaFsYBnI40UZIdyV4mIwpefLhugJBEA+8?=
 =?us-ascii?Q?clBxsTjbXwAmtv3FToAMR01BRdfjrsMHecdohDSckBlaA8RHUjn97MZsudnz?=
 =?us-ascii?Q?2JpmM9pJQAZRQx0XXL8fr4sAbexcZxvJLwqwIKTyYkcBsp+XewxNBxcTNjNG?=
 =?us-ascii?Q?P3evGQAahvIuLeEWgTCE2WNatQQDBuSHN6n811qpx0TzdhQl+gCLTU9rZOid?=
 =?us-ascii?Q?28yrPaUZAkQpl+6g4DELZS90QfKU1UelxS50suAWUPSlquttsrfs5Q/b6Yx9?=
 =?us-ascii?Q?II9UKYyB2ruw62r7r7cRML4/17Sz9kSXsFSZ5SpZkxGCYlItYRo10hen36oB?=
 =?us-ascii?Q?Lh0tEUhPvDhz4AeCQtQ9JkDaAojes2141XZbokfxKhK/QWAE91QRSZwqKpao?=
 =?us-ascii?Q?f/bjttUzz9YzuILPl9esW2epe1NVdAMImb6rg0qqFSUDhOQ7P8FX8M07J+7H?=
 =?us-ascii?Q?fQUYcvIP1qwKIXsO0EaQH6WFQTWn1Xy26HrxRr/rhgluGve1VTM9OEYg2dvZ?=
 =?us-ascii?Q?gFJOFawUWKfgyPHLtY4vp8XW9f8Yk6c/FSpCmnBp3JleSe9DDq2iC1j+XIfo?=
 =?us-ascii?Q?5byRfco0gewq/DEtsdLi5A0xIdhwQncFM5n3Hm4HghIrAobEniBbyfZkRfjv?=
 =?us-ascii?Q?sjFjRklXQad3InmU/H2ot391QS3tUcLWTeXaTJdLQw+kPV4lHptakhtaGUzZ?=
 =?us-ascii?Q?GGUhAkP5L26jo0Q/UsGo6VyOnVA68J9zRgTgYJvcWU+M4SuQrxG6W+lnSmDF?=
 =?us-ascii?Q?KZ6Kl1Kc84kFXQ2+orBgkwKsSYUpN3vNiaFzLYdaCZrpc7cUtrD6xcAPde4Z?=
 =?us-ascii?Q?m0hUaReGFtF3vx8pCTmQzdW0udFg3Rk6rh+eXJ2iETDPcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJRDIuaCwXIK5TgHG4LT7i5UsZDBy11WCZhXCsumtX+TvUoC0qdXnwuMge5i?=
 =?us-ascii?Q?kVs6+Gza4D5fBJcnxIK3BcnVQY82TjrnSAuXkWHmv7JJDlhdcndj9B8sCPxn?=
 =?us-ascii?Q?wWPutsGQ1BSCX/rQ5ILr30fCL9hDbGtBD4pkBdl5Br/dwllsexX/hu5AKny5?=
 =?us-ascii?Q?6snHCDBmrrQR8Ph+lPKfcWVRbX028JC2qCwsevWf8pGuo3wZDKD6opGTtd3H?=
 =?us-ascii?Q?C2cFdmG8+EeVE9TK2AFh4UyALHZcxnSTtP9SZDJfGqhZ9XPVzXQiUtJeC+GI?=
 =?us-ascii?Q?lcSO8KHLEjPF3M7lCwgMwrol3II2RHmJdU6XvOiYPpL65RCJIPFL/4GJm6rd?=
 =?us-ascii?Q?ywg9GzSChA9eWeaSOa8S/W7N1BS+Y5hcnqCXNYWQVliDZXCBQnB9beNYv2+a?=
 =?us-ascii?Q?nLI2XT3byYB811IOgxCzfRPx/soY2yKs+MKRQZxRebBbIFKGdjCtiphV0gMu?=
 =?us-ascii?Q?1iMLCqAA/NxG1KS5ikYX6H17N1yByLF9GLxR+umxhf2Ng6Cvdr/CKsz+epFf?=
 =?us-ascii?Q?4mk9q4QLX9MZbnDWW92NXgNLJ03glGzQvL3iGaNUUkCD7uxYkmqRSwYc3Ogf?=
 =?us-ascii?Q?7MyPz4dtxEjdskVdFHz1DgeD4rzUYEM4IRXnwnmYmzaj5H6aFYRYWmvJd3TG?=
 =?us-ascii?Q?LpPlMqFX2RIaFTJR0tChhwapQ9p3ViOF6KB1qTdhkOpNzpNouSKYI9aJvm+T?=
 =?us-ascii?Q?hbPW2VpWFp7qbSAwKrY15ihe7WhfkqJYVDrQYz6wO3p0aC1I4t8HDQfPgOvK?=
 =?us-ascii?Q?76OL5dYwWb25PmZ+aSEjvr6YPYI54dNwGJx+xadmTOnb/5m6xyHUlUHF9L6N?=
 =?us-ascii?Q?uQJQnhOotGUddOsBJ3n4kMBH6paxen50BbGLiNTA8dxlnRr1rP4dOyDlzgiS?=
 =?us-ascii?Q?FBwjtQfK+rlHbRoG8b1vJKcSe6F70TgY9rZgWTYDz/R2AQ3E2nx9CpZDboRL?=
 =?us-ascii?Q?CGzr57TkT7Qu1ZOyeCuaN4KhSWcYbIhvEARnGk1zGCYhiHj+drFiJuv+o5ft?=
 =?us-ascii?Q?K5VGUFAhGkEPq9r1quE5rAoYaoCd0nzXiByD+iFetsUeCb2lOvd6JJKv1dze?=
 =?us-ascii?Q?AEGk6jMpMl2FxTWGTEWdC+/ncNM11zvl83wpJWRyzcuF0sx3R9CVPCNoicZl?=
 =?us-ascii?Q?19bw1YN/vlvFG9eEDSo0FWsRcVPHxkAQDeIwl6mCFpNqhYg9iqqlX3mAFhUr?=
 =?us-ascii?Q?P3ijGaE9r5wc/6kflpVF4TgswkIBYBm6s5I2ZE3ba6j1+i8gbBuRZR/aMO3J?=
 =?us-ascii?Q?ZQDYopp1i3kdO3P3JTJ2Puf6XMoozD+cbdJKqzwA+ILQvpNpEBy4nnbf5N++?=
 =?us-ascii?Q?9F2CNPeRko14cpbh4rJGQ2wiNppnywwSD3u7QZZQyRNaH0n/X5ABQguEbv+n?=
 =?us-ascii?Q?EPRfKiBip2nxoNGzbSHAswEMQAWUCcO6Oeb96KOY1kxP0mwnrPczmxIpn8oY?=
 =?us-ascii?Q?z6T644Gt29+bmn2Guagm8QyT1O0ubMif9wkiBkbMjjhySdUX/BWifDiyMtHG?=
 =?us-ascii?Q?2nfFXp/JQ8sIb5VJQ0DTqA7pVHGAwsYNWGCo4kA4vI+hRHGuP4uCIrN9626X?=
 =?us-ascii?Q?9nOgwIe/BfAq3o27SakeGAfJyvENK2s9VTHpku9S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8732a722-c3f8-414c-484d-08dc81bbb63d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:50:39.7205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11c2GxVOHKShk19cQThWFfLtFO2YiNbzKt069/oAI8jl4pYcuoX937OBTM3S7OhjNB4GywajtB3mDdNvxsE/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748

dt_binding require I2C's clock name is "ipg". Change it to "ipg" from "i2c"
to fix below DTB_CHECK warning.
arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dtb: i2c@2000000: clock-names:0: 'ipg' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index ccba0a135b247..9064e6de7d107 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1004,7 +1004,7 @@ i2c0: i2c@2000000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2000000 0x0 0x10000>;
 			interrupts = <0 34 0x4>; /* Level high type */
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 		};
@@ -1016,7 +1016,7 @@ i2c1: i2c@2010000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2010000 0x0 0x10000>;
 			interrupts = <0 34 0x4>; /* Level high type */
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 		};
@@ -1028,7 +1028,7 @@ i2c2: i2c@2020000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2020000 0x0 0x10000>;
 			interrupts = <0 35 0x4>; /* Level high type */
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 		};
@@ -1040,7 +1040,7 @@ i2c3: i2c@2030000 {
 			#size-cells = <0>;
 			reg = <0x0 0x2030000 0x0 0x10000>;
 			interrupts = <0 35 0x4>; /* Level high type */
-			clock-names = "i2c";
+			clock-names = "ipg";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(4)>;
 		};
-- 
2.34.1



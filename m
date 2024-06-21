Return-Path: <linux-kernel+bounces-225106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187BA912BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C172C285911
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0F16A943;
	Fri, 21 Jun 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8a6ZHAJ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A2168494;
	Fri, 21 Jun 2024 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988730; cv=fail; b=Lk5lScR8CUaNvQw8bx7VP9Rv63ZjHNcIgYYKgyENRy9ehTkV6ANS5Iw9yyC0tcnIHM9u5ommNVI7Ul6NU8OkfblxhH4YPhHQKtj1Cb6sefCG7x2krqyoBTcd1eifqzV6I2d68AsnEFSwlmHJIyFU71S9dV90frjHXea1zZmV3ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988730; c=relaxed/simple;
	bh=mJVfW5P51FLXiQcAAihOb0pTPCPOomztRM3DyPme8KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q/QL2fyuZ56O8e0wXd5drt6rlhW7xXQUy3O/e5fa4bgUipDVsBmwqTx1U4BeGCQpGbBbWaNew6Mat3mNy9KtOVozKC6amQunZ8w7GFhPMg0+MuPVpa+iP7+857536zersaWZerFWNCJcxQBTEG97lF1cueOVn116RJC81vdxXHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X8a6ZHAJ; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZX8P4FhY2/7sT1eHm5TjDT8HD8A7iBgLDH8zQq6VJNmzzkdkx60eEYAXwOk2IBB2zqKURX50VJ2wWBOiznPEI0LOBF+Yw7Ibnq+x+Qixcn1TS/CLGedkUnsQYMBDVUZ6PKbeVuXEIy80FCIdjNwRxTsvtbTEqUEjuY2iYybqmhc+5NzniKzy1sb2yeBGpqopJRhQftVnkTdIErPx2naGXizNryPVCNK/FgNX8rfrwvPZ0Dn5Gccl+1OlqVAXIxYVKTf9Cv5K06vPZktEpPsobgmh21LFTHnMz5acoNKFRG/GlxUPTi7+ypMQXCiW1RosBnxBaI4QGOXAUvpLQrhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33ieKxx3159pKXeIA0xPnhO4KdWwIwvhFksaUQNlF+s=;
 b=oMgDzVMR6GVc8fGr25D/z3tcJxhUl+kRQaZqhRKP3Kixe/5LOg3i7qUZE0ieYLwPzzwHTi0rDHADeMQBQZTgMyEYwViKzcUrR6bCC78sF2tST5iB4JSm4c9d2Yt1DkdXIBJ+p4UQpdLyNfU2qb90izUNa0D7s4+H1Kam02Rl9ySONbpHhQKWPQT2aP/P/ifGqZaocikYiaPPKh4l2KEfoCV51pgc5+4C58J2PCJbJjsUtjwhvL16Ts/3Uau7tdek9Rqk1Vatm3UcEjOspmGIy6YSkGWYt56DBERQD0q7mAqq6TmfBaGOWDBAsoifX1R/IdaXgbO38Fp/iSjiImr8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33ieKxx3159pKXeIA0xPnhO4KdWwIwvhFksaUQNlF+s=;
 b=X8a6ZHAJqbRJyzyjYF6YNz59+qvh7Sr07WZEKZTIa+6gIq0m8JvveW3rE18dRhLvZIVEPhZnszU7VCCWjSEpNr4SY8KTzUUuqz7AiVvw3F/SYiO8G59F9Kp7OCZ8P45XBHl79OhpiKyxoTVQaYHpUN7xQO55DJK17oqP90KkAz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/6] arm64: dts: layerscape: add platform special compatible string for gpio
Date: Fri, 21 Jun 2024 12:51:44 -0400
Message-Id: <20240621165149.2275794-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 238f8ac0-b29a-44c9-21b7-08dc92127b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gYfOOw86Z7Vkj0A+HHcidam01fjEnuCuM5KrHz2jVVSVtXYIOPCeiu9K/MxX?=
 =?us-ascii?Q?o/RahCHhqjbpvGhFqMKBAqg6dKi+rxYoixtbg3aOxV2Nb1U2oUtFSSwWzBtr?=
 =?us-ascii?Q?0AokbyUOVgBsDdIod/b+BYOm/HLU/xR50jL/dlffHzcCo7T5ZmQHH8Q8Ovmm?=
 =?us-ascii?Q?0+tdqNtzm+cwC8tRGNNtuNiRA5XTKmE0sxH0RzrVW7VICxNqY6xacCqEMJvT?=
 =?us-ascii?Q?qFXrIqJcyLcHGwmylwvrQwjGgRekKo+iZsowPX9bTlf/LZqlYwAecD4YgLFO?=
 =?us-ascii?Q?cYhubBTi1eIpVgeZEOTbPavMYfEz+LxmBIkOX9QISISq0zVnniVPIpT3DAaj?=
 =?us-ascii?Q?/+h/RFHKWctLnXwXrzObJiN/Nmdj0y5cAwn10zbHZhWBXiZLq3T+piVuAvdS?=
 =?us-ascii?Q?VnooV1FQcoJeSen5gr0vRgjP++5+VbcIDYt3v4wmkjj6J35zWD4DioQwC1jb?=
 =?us-ascii?Q?xzxKd2dlR+8bzGYXWzbnVKL4FNEALmYsNN7h+L8tRPyXnCYEYM9CdvnQi8hW?=
 =?us-ascii?Q?ufuWOBUvl3fdi8gjH9f1sphhU4GvBzNKzNzQPHmtGDlDYerYWfmjSEMa78E6?=
 =?us-ascii?Q?7X+LjJB0YQDUI/0p93aWnzlk0VyDIu7yfhDTquTmU7y5+VqFNzEmiuk2uXsd?=
 =?us-ascii?Q?YS0MchiuQU0l6Ks+XYckCAcxaOuEtqs4dl0q5EJ9Xrct0HkPjxoAR0Yul0Bt?=
 =?us-ascii?Q?Ubie1G3oG1hXynurBsI2Ula9mZRWzIRV7Evz2wf8aZyMUJCQ5m/ecwCO9WgY?=
 =?us-ascii?Q?KWIxRXzWExM9pW7/n9MGAeezY4AWK9FiEZNGO9tOXxV56WSvnz/ITHeBNQfn?=
 =?us-ascii?Q?bg+RJv1eQTi7SXwJ8G0J69ObC6BAvwvZ9amvbunGmPvLjJ07zXTPq+7TcUKf?=
 =?us-ascii?Q?mJHzrQztCoL1MAjLXrdFkcsL59rt3qiuqi9jfUqaI3vAz98CNsumTboikFnS?=
 =?us-ascii?Q?mYdby3XTJwZgCdGnsCF2TR7u7L3PRpD3IOmxRMSFb6CT7VUUlhYC+ayDaWEs?=
 =?us-ascii?Q?B3TN/UTHkpXaR0OTN7Uiw5iEaBSfOtYs2iPfPhBJcYwbxCjoXWK0FOjDCI3k?=
 =?us-ascii?Q?Y18XnzoIMrPvz742Suwie+5o0rCaK6ANfs1v5oBAb/M1cStXBUt4SgaGH3Cr?=
 =?us-ascii?Q?tpIjrwB9fkocdafdGSfUntJySCoh3ysMzRhUSqJUECJQPimCNATL1J+G9tXq?=
 =?us-ascii?Q?/wNBFOBIurYHhYOU3xgbbIXpLXQOJGq/JbO0k0KiwncUKxX+wN8VjJE6FGSz?=
 =?us-ascii?Q?WLt4k+2Rmc9/v12Xd+oWWdOrXZWf9SimF0fa+O1n0seAN6CkpSfIboY+/kQZ?=
 =?us-ascii?Q?wz7mZWljgjcBectzV4cLhIm5oDHQET/cwTe7qaCHMiQV3BOg0/CoC5eiyGOd?=
 =?us-ascii?Q?3EsqyoY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AlZJhqXi7etbGJRYskeqtLFkCPw0E1wZtUHL/bWc69ai7QAvwptG4yZqpWwh?=
 =?us-ascii?Q?69YUqC6lB5HtPDScH4jfNVk8qw7e++knLsQ68yOuPdH6BJRR2rE5op96uC2A?=
 =?us-ascii?Q?n3Ob/Vv45/TR5CK2BT32CT6SqCYthZqR/0Us/34V0YjgcdjSB/ivngldfV4P?=
 =?us-ascii?Q?XE+E64QonE/ILStA4+GkRJtKgkCoBQh1aj8eN1h/rbkUPieDrgUBy+9I7bL2?=
 =?us-ascii?Q?7AuTNOLfeVoQavwsJLlRCOoMuh+40/2qRpkwOfoSkLOj9p2ApwSKUeZhGoZT?=
 =?us-ascii?Q?AMOou9hfIzxatAbKo8OPROVxmUmirw8sUcDyqdtvgbyE6imzzNoCpMU25EBd?=
 =?us-ascii?Q?gG+TyKvwKzUJilkkIxY1GodZB+LFIiUi7LzZNizh57CPaorMO4UJGDqw3If/?=
 =?us-ascii?Q?dTzsWqCB9yBL9DhF2bRCeM/bMFqXhzA3pNsooiK8yk2TgSHxXWVxGG9C1szt?=
 =?us-ascii?Q?B86gUB2mPEZpamX9teyE2yGMl0WAajJ2uZMxzp+BPbl8p1/9mVNHWnByYzVe?=
 =?us-ascii?Q?QZAQDS+/3Clqoka/tFiRTwKARf7xVMsB1WVaxAMmL3pt3TCuLA/OT3LellwP?=
 =?us-ascii?Q?IgKa0xIZui+Td5pZkWEXxJ8vjIjYkIpbHTBH3FPf8+Ol83zap83RZmRuFZeY?=
 =?us-ascii?Q?m1ELbmOPMBNPiifqFhwXo0zsXi+720T3L1xVY+brMtIVbyXW1sq6WYqd6FPy?=
 =?us-ascii?Q?oRd5RfOiV0TXdP+cBvC1W9NP54maboEvYxgicDmZl79vcb42NQ3ZoWp+6Y84?=
 =?us-ascii?Q?sGfXvfDesnEWkfzkBFtAtWDhvmmxaxPYdl/UrieM4o2vKN+Q/YU7NNm0HqNt?=
 =?us-ascii?Q?e4MQufV3T8aDYGt0RKVuFZPczZ9okBYcjb5qSLvyrHCD3X8vvkRdX1kVDGXy?=
 =?us-ascii?Q?L5hnIO2NEmW3XCK4hQN2lr6tVlTfoJ2plvpz2qYwRtaf2r9N3y1gsFB6+tv5?=
 =?us-ascii?Q?B9oGREl1Lp4NqtnzY2y/CEd5QAnScjOSCmiJaxli+/6k3yTMWQ7uJQ348snT?=
 =?us-ascii?Q?S99WsobA67ZgrfnfQf9qHi+3ZMkgy64XPecsPG9y9Qeeptte8QELYMoT249y?=
 =?us-ascii?Q?hxg906/9wDKmQtwjA7pbK6IZVNi7eBWWek9l1dqYz0Z6AvggrA6KpYuglz6e?=
 =?us-ascii?Q?pWBmAX1wgz34Coq2aqn6ldVebA36g0JD//TRNSp8EeHtutkjEp1nOt92iViI?=
 =?us-ascii?Q?hGg14M/X3P6/GviFkQJSpzK6UaiZwGjn1mcL1c+DoB2Z2l/ZrA+JKZaHYgiH?=
 =?us-ascii?Q?bF6CKNdYiL584+fs72RmItVCFZ5vBMMz1SBlgVQZdngINr6onHEzufTDnWw7?=
 =?us-ascii?Q?W98IYthIEwwOgvGQuCEe071+S6s4a8jxdkG4LgfQ9ZC/iKswX+I6eAmm3wDu?=
 =?us-ascii?Q?4dKc/bbeKal+WGnlYI9kueusDAf5iLh1tUZ5ZeC2Y/LfA+zGgYyqQ2q53ta9?=
 =?us-ascii?Q?BHxSARd+8Lwav7Fmaw7h4HPzSadRrS7Frw1YYAmwHreNZTOdFiA1nAY+0Wg4?=
 =?us-ascii?Q?/9XjClJyRhciKUmEgSVuGB2QJkqzUmzHzB0W1dAy8QnpyLsEpM2OQ9Fr/Q3e?=
 =?us-ascii?Q?k5KHbq99mDQhLgPlNgMisDHG5O3qBjgN/c+0ixZe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238f8ac0-b29a-44c9-21b7-08dc92127b0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:05.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUUmKvAVhpPGlXtaZvMlP2+IazIHWwkfcdEbE5bdchj0C4X0VY7L6x//05sfxQhFvYSfsC4F4Oy++cbEqqQlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Add platform special compatible string for all gpio controller to fix
below warning.

 gpio@2300000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,qoriq-gpio'] is too short
        'fsl,qoriq-gpio' is not one of ['fsl,mpc5121-gpio', 'fsl,mpc5125-gpio', 'fsl,mpc8349-gpio', 'fsl,mpc8572-gpio', 'fsl,mpc8610-gpio', 'fsl,pq3-gpio']
        'fsl,qoriq-gpio' is not one of ['fsl,ls1021a-gpio', 'fsl,ls1028a-gpio', 'fsl,ls1043a-gpio', 'fsl,ls1088a-gpio', 'fsl,ls2080a-gpio']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index ff74addde3996..1331858add942 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -407,7 +407,7 @@ duart1: serial@21c0600 {
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -417,7 +417,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1021a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f8c9489507e7a..524b44f424272 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -589,7 +589,7 @@ duart3: serial@21d0600 {
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -599,7 +599,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -609,7 +609,7 @@ gpio1: gpio@2310000 {
 		};
 
 		gpio2: gpio@2320000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -619,7 +619,7 @@ gpio2: gpio@2320000 {
 		};
 
 		gpio3: gpio@2330000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls1046a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 0fd1ae2a73e07..83431dd5d2872 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1027,7 +1027,7 @@ QORIQ_CLK_PLL_DIV(8)>,
 		};
 
 		gpio0: gpio@2300000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2300000 0x0 0x10000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1038,7 +1038,7 @@ gpio0: gpio@2300000 {
 		};
 
 		gpio1: gpio@2310000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2310000 0x0 0x10000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1049,7 +1049,7 @@ gpio1: gpio@2310000 {
 		};
 
 		gpio2: gpio@2320000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2320000 0x0 0x10000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
@@ -1060,7 +1060,7 @@ gpio2: gpio@2320000 {
 		};
 
 		gpio3: gpio@2330000 {
-			compatible = "fsl,qoriq-gpio";
+			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
 			reg = <0x0 0x2330000 0x0 0x10000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
-- 
2.34.1



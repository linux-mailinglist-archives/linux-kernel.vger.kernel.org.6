Return-Path: <linux-kernel+bounces-231461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEE919904
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCE21C222C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66521194088;
	Wed, 26 Jun 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RpE5X6eE"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B01940B0;
	Wed, 26 Jun 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433568; cv=fail; b=oMMDukG4R9qSqCA+/xANJc7PDJk+c3BT6j/YsmyRnJ4TszldWM0qhd9lahld4ir5J0vSwm8mn3kTbBsE7a4fPUBwis7Rrtk5mGUwT05opKcawVIjZuayVbfV7ydRBpTwuIPpLqd7W0RzZmSs1D4lK76BCQqKif7bKRAHmx1NUm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433568; c=relaxed/simple;
	bh=b2uL5AlU1pf3cTG0LXP1eyeZ+OD07t3DTdlu+tVAM1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaRJi3tX+7rPaB2J1uXPEV4OX9yOrGBTNGYbORUYMHRfXbfa4QE7nlZ7YoBdfIOMGP+WPfEIbox6NVjJYG24qt7SWOA58ui4PPhl9ftMyIAC2xMS6blWpAKOqtR0EOKzRKiQ6MsWIOKnHfNkknJkMB63c6CyYIwSSbkk3CZUx+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RpE5X6eE; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Lqk2av7yiObud4pj+rW5plupDbe479xLyTu376eWTSvcY6clI4NUapzKrPuttyZrP2H+CTKvP5LCdS3t6cvElfSYB9BPK6ZXUi5l9NSzjOoQQd8EhoLEyw3EM0ER0wi6l2Nhnzad/Nvcd1HxijbRMpwxU9YZeMapN4olwSGqkvytgt/RB4UFZjwLx9O1F3IAP0rwkmW6v7OdiV8ThQlbBc0ezemB6V5hjKO/VGK4rMO2sooUZXpNQXDUrNLwjd6P+3Vov0fzcYmBxArpR97+MCL8oOZpdMy93cCuhTJ5FnMCU/NgL2nHFvmnPdNJUS3hnIc2Z7kykEpY1OSc5vAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MnmMV/d9sEtA6JtwII1u0JYz49RJALgQvcI7F8tG9A=;
 b=H1LQoJKqI0VJFRiEOombR2Eewr9Eu4YrTsNNnwtc0Rpf47Nbx/pl1zFMBioe+d9bT4KAjydNAKBrRvOYLe3PUY2rLDBa9KIiyfBjVxXwPQayrTDcVWe+t+5mNI7+85GY7kZa4QD84jCL9mxAPoPan+pNoyNqldr1AcJabEScJCRD4bhFgOrN5eQrLJmUcL1ThiY1Krs64wmhCVTxNytnNti96LrvAZIkXg3mKs1pt0c/vsVhTnGo4xifeFhkaGuvjZeIOQlagqNhGtRAYMEyjMrzyB2GHgb9eM7sTKR3lnyXzq99xu1GqFkB8dGv7P55KryI8/ybSHbQWfJlsW9wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MnmMV/d9sEtA6JtwII1u0JYz49RJALgQvcI7F8tG9A=;
 b=RpE5X6eEgNH7MxxKe2IHXjs9GxbF9zQYX7zLMo/srffSasaT1tK2JSsNUjB5Hpr09M6NUgXjjeiYQDh1U+4JkAhN5c2eb6C8MsFWkYzhx6I2/HvsHJSbMQavB1h+E61JqShmbHxB/bhRcviyQSeiTTTZDVdFm/KAl0BuHmidvsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 05/13] arm64: dts: layerscape: replace node name 'nor' with 'flash'
Date: Wed, 26 Jun 2024 16:25:25 -0400
Message-Id: <20240626202533.2182846-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c90278ef-0778-445f-7310-08dc961e33bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AhqBeExvaM9oToBywBkR01NR1o+bEPvWieLyPkKn+Z4tHVeBkEb6q4Th/sKn?=
 =?us-ascii?Q?+pfNz8PKIeF5G1dBBgpgZ+sTqORmNI1w5kPlJNa9HPwyjjVhXgKGuq9SQwDP?=
 =?us-ascii?Q?EzXKqiGZkgi4/LhLDcfxIJMr9Td4NNMAl7EAUaFU8qEC6TR5I5BC0vT9iJvv?=
 =?us-ascii?Q?NNtTWS5nFbQ/ay5ZYFk0bOnoX2T/vgxUI1RsmYdeKegEEcFhnfMceKA8RBI/?=
 =?us-ascii?Q?UFj0a4zBZOG3iecBAjZp2j1BhAExsyE+z/7PFLJruNu/YvC6xpKYx4ZsgoVu?=
 =?us-ascii?Q?CmDfiqt3JwfJQeZqvJ3ULFMCBYxU7pcBttQaOIXhLbCzCB+cylnJP+gigUek?=
 =?us-ascii?Q?IPO4NQDbts1NcCsRHhdyeNTXPNqk2UmZdhBg6wMiI/fj4SLRovyAS3tywUfz?=
 =?us-ascii?Q?GLMfxT0Z/d0yDWAGAyO9YBfqXd18g3NlY/v8tk88sA0F8I+GeY+hcXSO27be?=
 =?us-ascii?Q?JCvtRYQ8p3eDd4LOT1wUSgllcQ4Yf1MtgacOh8v4zkRqGllIWsLTDosAf06p?=
 =?us-ascii?Q?qGydVXx++kx417dGmzcjLvmosDseRhsqLHt4ARdtnNbMYWadEM0hcktkkme2?=
 =?us-ascii?Q?eCNlXoOmpAHLsBLstaMj0BII49zscbZ0i3nW5O+KuW6fK3y/UTFdQqdjzvfp?=
 =?us-ascii?Q?PqlaJRIcN2sZ4BYeT2YYPVwZqcNN7JDS28fYZn5E0XFKByTH+TYbiSSIUdtT?=
 =?us-ascii?Q?9Xf3/1WY/QcGiEhvLmckESASD8DOuwWq3rGGmzvmDElS1DhLDtBLoNEBMntB?=
 =?us-ascii?Q?qjjWmUqo5GydTD8yRNRL1B2/Wpcnqzlbal7m5dRe0h74TVt2CRmNBJdneKJw?=
 =?us-ascii?Q?mLj9rnnuM3iXEQf4pTfFFU50WVYjZJThDZLq3v6R8DXtVSmKsnz+mhlYymEc?=
 =?us-ascii?Q?gMXCqebn1jNZyI6CEOHfi9JA6ipTqXxNejNc8id38jWprVBBt4Z44C9XKkAr?=
 =?us-ascii?Q?cgBVa2Qh4QmcqfqcfWYhePwAWh/qLBuDGM4s/e6dE2mPQtv1+dY5LWhXZ1qd?=
 =?us-ascii?Q?r9g9aPHl6MBrR6Z3yoDaURCImJcCU+d9Y4Y+kqgpZfVzo2OVCAa7oMXEVcsy?=
 =?us-ascii?Q?Yq3Ys+HQ8WH5htmPQlSftcnUfMtr9iXmFRAmhWtTPaNz1cD0T0lzSI7B35Cw?=
 =?us-ascii?Q?gJ+EGZhpCCgVczUrmme/3ozG7FqETFGMwbx38F8dWG0bQhE6NbJRR7XVCE9Y?=
 =?us-ascii?Q?prA0Pmq5cVOhSPbtR54fwMJtpVMN+iZ4lRe81+2NJkp4LVLSPVTks2crMbju?=
 =?us-ascii?Q?PjdufJcMY5cPnHZHuTY0XVDYhuhRIOj8FH2jHCR28aEVM2o2ra5dvGZjKHgv?=
 =?us-ascii?Q?Yv79LatXLNvgnzLViB+pYw0HJNcPZEqqWrZrjCYDiG4/nIz0Y+0tRJYsfOlx?=
 =?us-ascii?Q?PFv9Shc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NV+qw/Z/N3IW/G6mj5p8TdVY/N080Z8NWEUF85Jjmzx9dKN/Thft6dKixq4t?=
 =?us-ascii?Q?ig1YMjmhZz0BaQ9q4j9ITw0s0olNR7BPaHEAsEPP9OhBttrsQF0fX6e8XQiW?=
 =?us-ascii?Q?nkTxP+3uw/MbSYNFjFCbsGiiZWk/zgYW7kLQql6CNX6t33jAOOB8rbqiKJVg?=
 =?us-ascii?Q?7fQ4yIlIc9Hw6aA5qpkw11/nlnhQ8pJKkDAjHja27GJ3FZ5ulQ6ZMSyA4FC/?=
 =?us-ascii?Q?A2zEqRdIc2TRZsUzC4dTaQ1sfGL8Yyete1WLKpVyfwE5ZthrDqyIkQ9eczgd?=
 =?us-ascii?Q?UpVBAlIhzg9mc/8RJrOg/EHkWfoDosvpDpsvE9BSHCHV3Vf3Z6t/o70Ixos8?=
 =?us-ascii?Q?uqiQhBaE4V7qEs+yLHmlCoD7mPO8hsMwqli/WPtjGr860MfnZmwDuZcJrJj6?=
 =?us-ascii?Q?rcaPpyKQY10anb4YmZMRyqi6QWU/5cpVnzJgNUMaOc84ES6TSWb9yKr3lopr?=
 =?us-ascii?Q?J6BfTxaFvW7xZyN3OjLPOkt4+6jhimnQjaFZMq2rqcVFVUhIe228n+smi21M?=
 =?us-ascii?Q?erXSIISVr6eJhQj/f5eHcIqf16CPu4vZiGOcFjVcmB7/YcJC2Ro6nB6k5U/4?=
 =?us-ascii?Q?LgjL5P3Yt2cmBZ177fjj8gA97Fu1LQyaWBrWqDHc9/FxSUPPMHj0CaPkhFRl?=
 =?us-ascii?Q?2YV15Xfn21aDY3Pb8uRVr8W/afZQk/L1M0qagyJ1ut05iL4RYlIAmuyOIXO5?=
 =?us-ascii?Q?+xzY9aI5urh6eGHyNeJp78QsFaMFwT8Qcal7RdHZi4Mg3lFBFdXSKbPwI06b?=
 =?us-ascii?Q?CLlQzCp8EmwGVaHCZmij2NUw6cLN5NWG5eSBjyVUzK/8R0CACXXBMmSwvRlH?=
 =?us-ascii?Q?RgOqOCyoHISfiPj73ul4IB0XrolbhDDXRgaieuM2LXaXib++pomnGmv649Ut?=
 =?us-ascii?Q?FxhvoHXnXtj7yQrymYeJPbFP5agOlTFD2k3qSOhGVHWXeFHXCXnlPvoQ0RRW?=
 =?us-ascii?Q?KhidLvGS7eUzHYXPTKFlSBOhPCJoQdFD83ouNvFpzemVDS6tMKb+mOSRQSBJ?=
 =?us-ascii?Q?2pJy6OxkrcssugXBPhOcZZCXSx5S2p4iec4U19YC9YkYzzv6lQ5rlm6pm+CG?=
 =?us-ascii?Q?tn4mpUCQaMDnIDiBCorCdvVEA9Zlt8DCtXgsz1+MCUNWW34czfixrpvXN7ix?=
 =?us-ascii?Q?Iqn+Fpr2XVf6eJ/EFVr4nbeG3zAnAQRVRoef5fd4UTvf7rEyO5iC1TDybaFq?=
 =?us-ascii?Q?spcln8wLuHLaSsHSzNdeEgBjtqg6dODXcDfbBxcyy5em5f/ommHXZG5cfvdA?=
 =?us-ascii?Q?C384gwCATWTbFon4BccMTEEOeGPURSk5poaVceNh6nZdzJM29URBG9SzBcxP?=
 =?us-ascii?Q?EAyXLY3VTJVV85pTMG7qQMGjTQi+fnOiDX/yDXu4rZAaBZXVaXEFBID1Hwu5?=
 =?us-ascii?Q?QfcToDaI4wKZkITd2US3PylLwejrMUnEvR9AxhjJ0FlOv6WHyoFc2nQNw71U?=
 =?us-ascii?Q?Vcj/ss8Nbnhqt/KnYLln38CZbwAX1VyDD+wAWx81XyWpXmHdKWWcdjxgidVE?=
 =?us-ascii?Q?X+VT7vbD3wxDGxncuB+WkqflgSLUiG9jKrZvddQuEADFreTmfmCl+AUoV9bK?=
 =?us-ascii?Q?tRUg3xYScuHlS6IN08M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90278ef-0778-445f-7310-08dc961e33bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:04.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afT/oDWMlIfEcUkqEyoMWX/W4qPV9FElODllWLhXVZeDESZppwCXE6V4zI1l95gYJ2WDPL9fzwo20OL9KCJEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Replace node name 'nor' with 'flash' to fix below CHECK_DTBS warning.
nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dda27ed7aaf2b..11b1356e95d5b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -64,7 +64,7 @@ &ifc {
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		big-endian;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 26f8540cb101b..5f6e57cf91981 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -71,7 +71,7 @@ &ifc {
 		  0x1 0x0 0x0 0x7e800000 0x00010000
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 
-		nor@0,0 {
+		flash@0,0 {
 			compatible = "cfi-flash";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 3b0ed9305f2bd..e5296e51f656f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -151,7 +151,7 @@ &ifc {
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		big-endian;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index aa52ff73ff9e0..d238a8440a814 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -113,7 +113,7 @@ &ifc {
 		  3 0 0x5 0x20000000 0x00010000>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index e2c94da6d6e82..9178cd61c7869 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -43,7 +43,7 @@ &ifc {
 		  0x2 0x0 0x5 0x30000000 0x00010000
 		  0x3 0x0 0x5 0x20000000 0x00010000>;
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 537cecb13dd08..69cd05a30b853 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -21,7 +21,7 @@ &ifc {
 		  0x2 0x0 0x5 0x30000000 0x00010000
 		  0x3 0x0 0x5 0x20000000 0x00010000>;
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
-- 
2.34.1



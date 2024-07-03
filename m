Return-Path: <linux-kernel+bounces-240164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B59269CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C7F1F2496F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8407194A4C;
	Wed,  3 Jul 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaDUZ5vw"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A71946A0;
	Wed,  3 Jul 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040354; cv=fail; b=PPuOLLIk9BWSCRD61UlE2pIhiYex60NfdMt/3SpBKn3IlU7it3w8XySubAqV4HBzCuIKnsg2eS8dVnCDujGwixReqn/YDCqxCTjHJvXQLgRd58qioDPeLN0xW3E57T0yv2Ua3jaYhddDXgtQbDdCwRmwsJc2/7O/L0i1qyHhQBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040354; c=relaxed/simple;
	bh=D5auBb1ldmWMM9VZDxuPaKe0s2kQlahM25sK1O/aJW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/SFfeIKxo6DK/OXzybdJZA4XcUlwyLIL2CsGcD0KoEOAlYycODzsuQfMGwJTRk+hm0n/fxvoBfGKM1Hv5NsBcMwXOo0V3ESyNNCanan2gVSwJRLu6ECH4G9ZmjubKGs6EKlty4b5ICbRK4TP2P8Br6itZyeWFkFqx+9/p2tDjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kaDUZ5vw; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2CK797CYFdIk3QZaNC+tlP8GEVMlmm8oKppj6FK3d7OzfLRiA6J75nGNgaPE9fHBsHsHGrpsX5z1iWiFxO6Km6HJ4ILKe3y0CwON279U/vzgIqTxUebeBI+U1Uy7pGMCGcUQZrO5fyCeHFJLA8FY69Wi9yWVEP6AYRGDw/7pp9Kh0PNbhtF3H2oANkLhZBluVEXyWuTQ1HjIdgfjV1BXmctQAGdPyDSQ/yBSj2ml1EtYyz1GxEf64gUCc6hKIiWeRPZSl/GB91KVwkAIps1GD+sQl73XJkK6FaBf2I66xePDvowA8xKdWDDaW9iNxVXV/DkrZbGv4kOIg+3R4K1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qHc3v1bOx/PxF31TCjayGDvL2v9porYXfk4A4yGY5s=;
 b=iQqSIqRBZ512KgX5RMloD0A8GMCvBrrNCjc7WlL2g/HqsL0WV21Rrxn1Z9V/h1wEgo0yr8bNNWC8ANrq9CuDOPhSVsGpnaiePD0EUdtAY31Bduhs6Ou/B12pT6ViubG7GLVJ25m4JhT/oTTosFJCydQuvd92bn7wyQdBqSrwhjNlqLy1JD+dcggY7HUaNmeLU0QXl+ktrP0bxh1hoOdpzfj33NThLUcJRNAAR+VncuOWWRxvsP4j2RfDF5MmKXQJFALafGrSpnzPBcN8vtTLgtu9aMb4wrkwHwi+6T++69D5SWfFYZhNVHzsmVgFTpa18TSGkaQU+mMKObIBdSClRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qHc3v1bOx/PxF31TCjayGDvL2v9porYXfk4A4yGY5s=;
 b=kaDUZ5vwCTXIrylt3suWIo2JX5xmj4KxrdIAtuVEXXE8Om7h+r/OY5/QpwfCJwNeYxh2UW0+C6ryF7DqYswDLIpI4++WOEBV7JxSyzGBx+2cvmoBtmmQtEf11SECNLWgItwAToAqy8V49gzP812+YE9SlrvaORShJf3ZHWXqIiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10049.eurprd04.prod.outlook.com (2603:10a6:800:1db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Wed, 3 Jul
 2024 20:59:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 20:59:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 5/5] arm64: dts: fsl,ls2085a: remove fsl,ls2085a-pcie
Date: Wed,  3 Jul 2024 16:58:47 -0400
Message-Id: <20240703205847.2826263-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39541eda-c060-41ab-b284-08dc9ba2fabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKubMa6IzxV/A9FkfKd8xinjmFUrIVg02ucHxyYvfX5BQEsfiQVFGARpV70t?=
 =?us-ascii?Q?GDYo9M9vA4rQsPc8++k8+6Y/7fBP0QRicYWjfMGsvc0Qdz2ERa+y8CQdETIr?=
 =?us-ascii?Q?ad8rMjSvIHMct1tbW4Jsiv+8qM7F3b27/9m4LwHojGPL2338quk5QgD1QGm7?=
 =?us-ascii?Q?MBCCixFjtOIRgLHpEklnhWN16QfK1rX2wVS3ReIqU6JGbCuZH4MTvPFEj6EJ?=
 =?us-ascii?Q?y5WqyVMqvAd9vyj/u2qcodyKeuIit3qIfrfqTQXXGM+0A4e+r/RF2FiIITgm?=
 =?us-ascii?Q?COCSqWpCPTmvidnlBsihhg7oE+VeOMmmbbsH95pYiiXu69DF6ka/U0cMY91L?=
 =?us-ascii?Q?okn1naRiYdO/bbWdXWN+4i0ZHak20ZGcnIudEQ8CuFecep9399pUUHlOkV4E?=
 =?us-ascii?Q?nPAVJ4zluZUh4+zAUS4wVoYEbLlpZVmcyFKDZAkU9v62Nd4+oNKP6RHswYAb?=
 =?us-ascii?Q?zUhopS1C7KvaH/G9iyepEYCS/NU01I/l7nPaTVse2qy+sVnYyi4aO2ov3NVM?=
 =?us-ascii?Q?WnQsvr9gQ2uHNry4Ko9mEBXOXQwbaOZdlnEnbwQ/oRm8zS+MCWP1sjzHNLDz?=
 =?us-ascii?Q?n5rwbdyKRh+qWRsHvBHKQgjAYL0jWEnrM67CmxDK9ce2tKhBHiX9Vs/rESyu?=
 =?us-ascii?Q?P/UXt5KZu88YcySYKu0DmEcI1fBqud0LTkmdf+Fgjy45GM7KIRd9Aaa7ITZ8?=
 =?us-ascii?Q?lvLlZJC+YAo2mh6hQxa+vM928z9AgCdmxShlDK7+4FVgFJKUoQMXEXl4shGi?=
 =?us-ascii?Q?vTyHj6cRkK56y3kNdmY9b+1G8FoyTH+nWuhXgS/SNXJxk/SA1uCxXcEylm5w?=
 =?us-ascii?Q?57kKW6L1X0wAGt/Hh3PJ0SWvIGgxfpPsQLtgymauPPdc/LObD/OnlwiJ5a0S?=
 =?us-ascii?Q?zw3wlxVN3P60tiet+dtN3OWj3BRdON82+b0qedI6KWKC/nARMi0wD4XrF7It?=
 =?us-ascii?Q?d6A52QAy5QrQJF/cfbm3OC3N29aFznM7GyNuFtY9/7CCwAdqEvBTlme5yzES?=
 =?us-ascii?Q?WLPEelPvB/pXCcdfXUir2pc13R4dSwFRcZeS5MFbU4juvgNrMvxJpQTfe46t?=
 =?us-ascii?Q?dBq2X9Bcr69ExnHtIkH1Jbjq/EAxjCc8XeemFqZKt02HcLMbNQJy97atQwGN?=
 =?us-ascii?Q?alxqDbw/NOjsbIinvl+3h3vNyuDMPVXQazoAXxHGdw7lvJV0899P3Q3ZfG4W?=
 =?us-ascii?Q?LGEBNu+MNBAIlDCWRvoX1DW4e5cxCix5SYl92lgqijnC95Zc1LKMvjoG/Frh?=
 =?us-ascii?Q?zpj5Fnk/kHS4KW38wX5Ao6EKXDEfP9NGR/NPRN6qkj9LKQyCiTJcKRHmtAlN?=
 =?us-ascii?Q?qZntGBHhnnO8acnXD6U+egCJtnvTvO5J5XJQLkw7+0Tru4S9ccchJd59BlL4?=
 =?us-ascii?Q?eRTZSLE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73JZDeQMHlyCfLFDzAzuJUip+5eyH4C+mbEDAS74Od2iJQ7fn3kmIppzO4ND?=
 =?us-ascii?Q?MOaPypwu/eVPf0650W9fNK/VwZvShfCqhAYmex2CAuU0OwBN21jrCxZRkK8u?=
 =?us-ascii?Q?Y7uyZtKf43NZ3auFYdUTk69x0Ba9Ruf4I3eOn/Rmk+2derKf0Z9aJZ5Vjos3?=
 =?us-ascii?Q?j63s6CuR/NKQzkF7VjbAhljnXFg5VppAsFhC/B5dlPvSXSZQi+uQvsAoKMsl?=
 =?us-ascii?Q?1LAAVk5U1OrycdsY6gIOSmgXrWygNDaaiMm/WEenck7oYRXeCi22HG2L+ewo?=
 =?us-ascii?Q?JKxhOesorNMS+ok/zgnsR+xkV4hBotXacMQifyeKCVIopHk7WUlD1LXLLOUP?=
 =?us-ascii?Q?hg3W/2+HYiNcDBDFo0n/lWofwR6mvLrZHTOM2jNpQ7iLZlYUe4mQ1jffkh42?=
 =?us-ascii?Q?NYmrLTf/qnUvyuGgZa6Y+Cjh1J1hXrowvnQVfn8KMIHTjlZR3/d6cfcA2M/1?=
 =?us-ascii?Q?vBzJ6AxlnGhavZGVyhB9C4ue+C1WVErOLEAy5vsEmNtl0vwAM9qBoKu4N8rH?=
 =?us-ascii?Q?Ltl+cZ26BueLtGVrCkTOzLhL95aWZVHzxmGjQRm/4FAxTfhi2ZbFJRJGknOe?=
 =?us-ascii?Q?WACSD+eWvJ0b/n0vXqZSLvBdwHk/+3axT7tP8TtgXG8nJceyWR2QYlIXhjjk?=
 =?us-ascii?Q?Zf5Cl/oYfaGanLDTHjtjG67FFsH+atul6THZpwEX29Ev90X75ma9cpV/XL7E?=
 =?us-ascii?Q?NpvgnL5wPgzyx5/P16A5pbPXSw+0Px6xbECAKhxEGTtg891melz4OfQJ4kCu?=
 =?us-ascii?Q?UOWNHzr0GpEFE9/Pys12ojWpgeBtkQ8PZqVdEg+QtfuMsLiOV5aAbfbA9c56?=
 =?us-ascii?Q?XcYGSpM9r9Fxh/hP3krx7tu+FZjAZVXR1NuNHE1DOm322vIlkt3fB5mnVICF?=
 =?us-ascii?Q?Xq06jlVrFdEkzbZfMLi50vizjlfNjHVW9gfY2ECEV4sDjx2Q9ZSDRcQ+SwI+?=
 =?us-ascii?Q?30u7P9hD4ldP1S8U0WMf2mF6KeGyD+ZhqzyJnhaip8w2uMwpxpPeIwQ6o3k5?=
 =?us-ascii?Q?e13iTuu0G3H3oKgcOenCajvkqX0+3BrJoRQRZf2Ar3VP5u8MJRAsGHWKWfuL?=
 =?us-ascii?Q?IllXDXDaSD9mekBaxzIk4G/jaez2T8j3R00D4eZ8uoraoT0Pi4VHvMojvE6t?=
 =?us-ascii?Q?4v2OL4wGkCdnrsTlxqCLcMYe6bYP45h/586Da9TBLF+FkM4kKDalOJld76vk?=
 =?us-ascii?Q?+jmXBEbr6pdrV42QzgZe5DaoGEM0xUIwM7kA/Np5wmAlIFEndF1x1MRIjaza?=
 =?us-ascii?Q?HmXR9ko3KU6Ec/+3e45IGfUaC5W20iz8/DzWABLOGZVSBRQJdArV6MAYNk2k?=
 =?us-ascii?Q?np1nnIXzW41yVbIZNT+4xj0Ubxh1Trrt0wmL7Y212M1RdjCWLscTMTmuErSJ?=
 =?us-ascii?Q?Z6lQVy8l8TRqa+IpxvXkzZykSkFo+CHBkx9P/RZd7DdJIwELwQZpTZjaKYbe?=
 =?us-ascii?Q?KCkpcKfmElo0dqq+4G1holCCtAzNHtTVrXExVXGGH3uZhVwHmlzqsCz5NvTg?=
 =?us-ascii?Q?cNCzbEEbh8ZU7750Atfjzu6Rz5CrDN0QTbWdCoQ9fghx9qK3H+JK5tjuGUgO?=
 =?us-ascii?Q?WmA+IbuaBnaYJVM2Iuc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39541eda-c060-41ab-b284-08dc9ba2fabd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 20:59:07.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8dqOsaBxGI14JTGWqDjn8Wik5s1N0g5CXw2jViBmcV+sXvR8RuJdFHUhkfbeB8xglI8L7ub5l5Iu9YS9UPrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10049

fsl,ls2080a-pcie actual is the same as fsl,ls2085a-pcie. Only keep one is
enough, so remove "fsl,ls2085a-pcie" to fix below warnings.

arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb: pcie@3400000: compatible: ['fsl,ls2080a-pcie', 'fsl,ls2085a-pcie'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 8a6c883379c26..679891eef939b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1076,7 +1076,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1098,7 +1098,7 @@ pcie1: pcie@3400000 {
 		};
 
 		pcie2: pcie@3500000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1120,7 +1120,7 @@ pcie2: pcie@3500000 {
 		};
 
 		pcie3: pcie@3600000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
@@ -1142,7 +1142,7 @@ pcie3: pcie@3600000 {
 		};
 
 		pcie4: pcie@3700000 {
-			compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
+			compatible = "fsl,ls2080a-pcie";
 			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "intr";
-- 
2.34.1



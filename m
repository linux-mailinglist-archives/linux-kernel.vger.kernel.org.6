Return-Path: <linux-kernel+bounces-372230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3E59A45EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95830283D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0AF17C7B6;
	Fri, 18 Oct 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NX0nB1lZ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FA1878;
	Fri, 18 Oct 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729276294; cv=fail; b=XN23Jo+grAN2lyEKpXCSdfLSrWSfFMtPgznhqzvmgKyyGhSYcHHCjOIX5zXTXZYSeoqvLAkcfPIv1yIFmZqzgvl34j6wUzrIlZfx1m3I8PFWNMfMtEJldqPq/A6CPtpKSsJ08nytP/leJkZI65dCENfNMsBpj9xZQgfVMMXlXJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729276294; c=relaxed/simple;
	bh=Xi/08OS/D7Gj2Z7hopYH3JwiWf3yz9GosfeE1cpxG0M=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Sjapgr0kaOd4gCuLi+rFWXfOdnXrv9SVixC1/UH/SOl0ICjPDbftx5N+PL25R5HsKerhvNz3tyTGS7OX5LVjW77gGIceYJiOWSZhGXvLj32i6sYV4EXhu2Ktgw+gRyyohKT5UY/sNO6LVZvQk2RRxgi8XppuqEAmd2I2mpVkv5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NX0nB1lZ; arc=fail smtp.client-ip=40.107.105.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIK/ITtSjqzCHP0fxVTOewoNZd0yYsdXK01RSgqqC9El8iBUDwakEWOiG+jhx7rWp3cprwEkD2LW6HukuQ+onBsgqim1bGFfvUqcjpnTxRjk/bgwaEVQcKN62xF/2JeLYDjFtECnGatOm3j6HPEo5tJY/OTbQxlXiNxnlgznTZ7cS4lRE7skJeZeI+9W5Y+MYbf7mgxr0Z1V9K6irkf2AUksLWkfU5EoI3UlvR6Wo3naFhXNOoQ9wHK+NNvLoUuuXIkKhmZnufzelUsGCJ0a1uIKe1IA1JCzZflhbVoimhjksp8uR49X6d8UObRWLHG3CaXAvfHarKOEfTgAKB+T+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBRnyMnbwNi/Kmi+B910l6EIcG16uV1YiMK+zOb0myE=;
 b=Dd5GY853Rh8lIz79EeisPZ6shOcThauAzWMpntmTi/DFc/anwGldQxkaTfvu3Fuy8eqrTYuWS84bhOVll72CAl9GhQ+6qB/ZDRP8XTzH29EIaCWtqCfeYh+ksqGLw3QTi4iERQFpGvjKKt0T3O+PokwMB2z3fT5GNk7+aVGn1H3H23J5tMZzO0Ei/p8Ak7ZlZzUGB/2oXbBtMpUs0P/ozN5KUx9n3Cms8sNNucF0DHLiDYbVWvSjAQGJanfYp51PbkskzWg9gE5AbRDBiSEQYVkYR1O7DHyXIyukrIsLKWxGLi288j980+0yHJNnJyOVrXFh7/oL6pOkurJ0s4AkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBRnyMnbwNi/Kmi+B910l6EIcG16uV1YiMK+zOb0myE=;
 b=NX0nB1lZfmw0OudkZ+tswod4Ge1BeIojL2bEjZM6m/9osG8K5WOEjC5WwFWcwUNF5WJ5RUs9mXToeepVLCL6mmVQO+OffVHLla5ZHkKlJNsoMPwJjiJ7qeQnLJNDC+BEqruZvXJXPpftbLJKMwyF1RPhZExjbODpVR73MzaKRa/KNtx+/XVxqpjTS57v543uHZHsV7VMRCrTU/iMCPbqmFesc6YOtBjmcEuNGYx7dY6NtwnHtLwtFYbY9HruvAGKM5G8j0VhgyO9PTff7VtaLd2dnMHtyeP3bqQCz0PxSPS/3Wm4RhPNF3i2Xyg3XHZX3WiH/2T/t+/M/HHB5zPfUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 18:31:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 18:31:29 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8mq-zii-ultra: remove #address-cells of eeprom@a4
Date: Fri, 18 Oct 2024 14:31:16 -0400
Message-Id: <20241018183117.740439-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10416:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc6cab8-0ab5-49b9-dfb4-08dcefa31548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sw9v+Z2nIENzZ5ZwFRZ9SoQFpaz0KClrt8RbUzcsz6i6GSy04WWNjF7aU+Ti?=
 =?us-ascii?Q?g6aSgOdv0jDgfzxN3+yFEwF4JVCo4cMZBNZ4vg3uERsqHSTt3z1lGxR476zc?=
 =?us-ascii?Q?GVNYdAC5L93N4gq5kDvXh8NNOmqt9w25vFYF5AOzAHnyCmbD5QUye/5m3dGI?=
 =?us-ascii?Q?X5tbTkAX9F/lUmo+L4QfMLqm3zI3Ao4MKzKVo+GU5BkkQoM6huQ/C0R4BXxq?=
 =?us-ascii?Q?PyxBpA5T4aIkIwWla+HsoSWZu0YTSS/Ndo/dTjfEAi0bQrJoIpyzHC16/xBt?=
 =?us-ascii?Q?X0wJfktP5cJWxmzD7BxXCxHqNvXp95N2xX8IIJCYDrOLhheH5sOva+UFOG9N?=
 =?us-ascii?Q?96urXDA5ptQ3EP2jPsFR2enWtAsIdVxJmTDzulnZibr8yVMPUDf3BLl4nS4i?=
 =?us-ascii?Q?Rf0Azz3/LCTk6jvXHsDUe/oFQn5Mi2KJKXYFkYxZOpyrWomy8C3VMySgbFmS?=
 =?us-ascii?Q?VuIkcZpVQMLctG23xT2AXqld+3yUz5vOOPfVFEHMhJDkczGpOF0hV7Xj+ce4?=
 =?us-ascii?Q?siY/mFMLVJFWAX6/23zn+cpT5nnPdmdjdu8PUeB4MDzOYn4O6RLxYncbt8lT?=
 =?us-ascii?Q?dfOoP37hTWUe2ER2QwLkvkGigQRo+bLEajnT252VgSVQ3jTZFdltfAyaAZl6?=
 =?us-ascii?Q?kUKOyF2yA09O4yryM68HI9Q/fWKQScQH4GHKAJvrtx4PWKQn9Og+L/FrhK3n?=
 =?us-ascii?Q?+xmb9tzsk0pjgU9+pjyeE4SOaLA0OVyq26FKiotS/wKjDGdfpNslb0chbxRs?=
 =?us-ascii?Q?XQnrGcFMuxvoIYeGZdNgcToWRQst24wZsIiWj+kV54JAUszCViB+sI5D+8P1?=
 =?us-ascii?Q?+xwpJu4uz6Vjue7vowcJNgGkDbxGkum4ofsK4y/i4rbbwqrN5CaNFcLiTzng?=
 =?us-ascii?Q?pw1RK81ICQtTvR2zxvG1fB3lpn2MWuVxEM+oUDaofmWUMoeYE5ZPzkIeagLv?=
 =?us-ascii?Q?js8LVX4aErL1lC9qF8lrDdCZwamfS/Lp4wCyP+rVmOMRf0+nOpiotpb/JXrG?=
 =?us-ascii?Q?ZwyZGYOgTlSh0i+TJzznYvBiXZ5maUUskYQnNzb6S5DqI7hkHVNGh61EvVA1?=
 =?us-ascii?Q?CwsbE9NQ3e57f2LBHgrKbJXzBVxnt/G04sXPk2UkeZnB73dtJlHuoi8tJcM8?=
 =?us-ascii?Q?L2DToYINmM2sm4EH12DP/vfc7P70a3FPr73FarcWYrlqGXbROJj342SIvOvF?=
 =?us-ascii?Q?H/G7qoUkdEglF8ggKhnMn0Z2PSpXm4etOb81sQ9EBYzj1ID5ogvFPT9UsNoZ?=
 =?us-ascii?Q?imTN0hSx7VR1Zld8u+UwUXDWlShjYY8H4TLJf4868xhogi3EKeBMnjFQmF7g?=
 =?us-ascii?Q?bXjWDBaNP2OLI9JJWLHAunXdR2YaS2E9oFYVeE+RhYTR4Y0DQzrXujIcSww4?=
 =?us-ascii?Q?3LEbUv0pGQOo7mbMQoYWSxm49gvJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qc7DGowBHREX3KUqAMb03wptQRCyk3GnBiRi2OCJihzryf3g3b0LlRT2ULgm?=
 =?us-ascii?Q?Eh3sTTlrnWNI2yH1YMlAD3twG4Prt8//4mD8k2MgOSNg49RaBQgqSgMEQNeH?=
 =?us-ascii?Q?aNV4BNKTX+N9+LbPSnZuMVXGdd6uRoGw28Wxt2uPtbfPGQe8+xfd/dQ+32HB?=
 =?us-ascii?Q?h0oNNP1TzVGD8jWTope3j25pFTqnIOjdtXn72+cO3uNdzNnDrB+skBQt5tQZ?=
 =?us-ascii?Q?ZFr8ty10HQSy/vBPr7MU6K9CXt7uzAd30YB6cyLSu9NJkc3Wp919djI0701q?=
 =?us-ascii?Q?cHO7HMPiLpvTLdGHg5tWAmPB4E7uXTllob9+rIsSp/OWWNtp3DmbEUJ7yqjY?=
 =?us-ascii?Q?jM+ZWctfr5B+JRcwqTg+KalPUli0q0c98EFp0zxMOSWb+zQplXTenFRmEVeW?=
 =?us-ascii?Q?URx9MInmRQcM7ZFbXJt9nxLGhBol4hmyCgRbm3Oi4PduPdMIx89P2ar4irmp?=
 =?us-ascii?Q?wr3xxzGHFeaSP9MNrHNXUYOsaFBUq9yBUd30FB8QH1MYD49/xfIaptGOz/13?=
 =?us-ascii?Q?HSv10PQ+fh3rAm6JyoHYQcIORP/lidgCbqf50JZQ7am2BvP5DCXqQNHUawbq?=
 =?us-ascii?Q?E2++SNDgy9AEafSARcVhZc/hLped4JA72TWLYPdiZJou6iuzZeBjd7av65Y1?=
 =?us-ascii?Q?n1t5ReYXScEEhmyk0Fh2TIfB4odIguKB3ViFm0fzb2sfPtk0xtN3h3VRPdEf?=
 =?us-ascii?Q?c3yX969XAOpVfQaaSA4W1M571qiujvZlr/9xu/s6wyDuh1fpP+2CDYweSPH8?=
 =?us-ascii?Q?iyCN5QPcT7IYig+dF26bJh+xHxC/JvN72cN3lBZgRHvHPqohEd5iXFuIDE7j?=
 =?us-ascii?Q?vb0PY1rC73qH388nFif1bhsTwzjsEhCDop6p5U6A08CWwk6OCnAPQByAgKjD?=
 =?us-ascii?Q?+Mpl9R/DRnUGbxfCvMKyGRJDNNt79sBfAgKnrqpVGXkDpg8OdwtNmDm8TFDw?=
 =?us-ascii?Q?BaS4cXPyJ2OTZ4bWbFdtjH+GqClbP1Q/JEt9VP6QTvr6R2FqfXPX+XFHaQPU?=
 =?us-ascii?Q?xaMP2+nV3Xt6XgGiMk+7QphqVPB+Y1/bLuJmwVwSckFJnm06yqCF9i14tnKP?=
 =?us-ascii?Q?awYriQSCPlV9eEm5U3q/8zyKXffJ/lt7JGYaDbELWnGXpWLIrw8LQEG/FoDl?=
 =?us-ascii?Q?4q4AdY4W63cJCQhy25qene5ZYu/VTnxEemtKIa6OtLJY3RNF0VY1/qC5rN6P?=
 =?us-ascii?Q?q++mkS9t4W/5tg7bi0pIfeWyJbm8EhSUi3edwmuC4yL2DObU9HO1Nj9kBrWR?=
 =?us-ascii?Q?AgYtwcQf3WqjbMb8BZu6DV/1TQVmxcJnH1s5DcAlJH2aT0u2yUquGIGGjA0V?=
 =?us-ascii?Q?u0bckyoY0tAnOBYCwo/8tYMg5Iibim9d3KspjUCzniyFL0VaFNbF8d4TS/GA?=
 =?us-ascii?Q?u0Um9Is2dqv4ruMaOsX0B+Juje1IKkGj3t8lSa8jB/LXDcHm8qUUyH4oh47V?=
 =?us-ascii?Q?UdNJTiVLh1G3mvYuRZB/qPcxQIgPHeRUNATYg0j6a5fBXqzsa/o7n1ls+EWA?=
 =?us-ascii?Q?hPyIdOqkhZ+f4QFSgcC9Wvtacr6f9rAJyJAZff91SYve4LMW9TbRWCuj7Kfm?=
 =?us-ascii?Q?YjELCKi/U+IGuUfmwltnw6DQwLhm8udGXdU317WX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6cab8-0ab5-49b9-dfb4-08dcefa31548
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 18:31:29.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR0ezNpUqkIj3ASoz3KRvH3o7h4aunZnr7jHReoXtI0xWYr/Qu4OfSmmTSrcb90i6zCKkbVUq6iwqLbenCxOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

Remove #address-cells and #size-cells of eeprom@a4 because no children
nodes under eeprom@a4.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 0c960efd9b3d5..c7bbba45f3685 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -517,8 +517,6 @@ eeprom@a3 {
 		eeprom@a4 {
 			compatible = "zii,rave-sp-eeprom";
 			reg = <0xa4 0x4000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
 			zii,eeprom-name = "main-eeprom";
 		};
 	};
-- 
2.34.1



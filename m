Return-Path: <linux-kernel+bounces-349617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6498F91F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ADD1F22722
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F51C245F;
	Thu,  3 Oct 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W0puCa20"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5C1C0DD5;
	Thu,  3 Oct 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991817; cv=fail; b=MGk79mEfepvV+N4l4st+UHtSwNumEcpOuUFfDm0ufec6J9QOJ+T0vqoeC00X5L573SyAGf7TypNR7U5DPpwKlhuWZOijTBvyocjbB68c5WLp1Nmv4znRRdAIjaPti7svx9Q8ttikZZf9i9DvXfNnItBSBcFSej3q48U66MxisRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991817; c=relaxed/simple;
	bh=VVhEzZous+KxdOSaWiLIrNKnCDuLSt+x/Aj+hvRFkLk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WmcKj1m1+A5dMm40wkE4QbwPxMuivPlhcPvbVELGJm1vApRDpH52N4IAs+jiswVGPpljvAPUViHernz+kcKh/BoNHO4mdOCA7WeKncON+cWcxU1qO+GlL0lt4RJvce6kBZdHfuRdxoFScsYcYdG+HwUaiexU9abOiCN7kPWkdPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W0puCa20; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa+ByCdUz6YW70khjoS4vk/lTJCjy09eFelKS00ixD7ap8IdN6Fv69h8SbskmsPg6LLcp+BjAJTUBKltoXEYjPT1yW3gghU2QPDgVd++ASPsjICCln0jxPkT6fwwe+XJHepAh7MqaRrfK9nw1a5yCCVD1oUCpCt5PxVIe1n6LkImhY8QsCtSgM+ZJxUzxtUUaDzRi4kVsvOb7yfeQ3/l1rgfQuoJ1VXA3nm/LEPgD57iA9OeDT8Aj0mBBDFhWxGXei/8UMBM6qPovrGA+qfGJRxZBOScESFkuc+msEatnY6RVBp4LM7qIZDm1ufid3kaCebErT9isFA85/FZ3Xh6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92wW/rKqcb3i7s/DM7dlgaoQ1eUbfEnG6rMmBDQS57U=;
 b=MpOfDb+4pmVRbng19k18C5fw6T5Y/fULvt1reFddkiLQ6IBXQp04darH4K/ze5Z88FN5kG9xUc9fkzSQgz8Lq8p8hmgM7s3+jKHkha19Flrqa5f/ay9QK/PIMprWgirYXpg+S/efEpldrZTf9emTvCE5aRozStR1TwFs5KwdjOoPLjmpkAzTneOulDNIZ3kZoQkHAuSl4bUeSl0eG+FDPzg+1tzkjZMTt84/FIxxPBwJ3niPHRmZ9cT+g+Ey2juEq36ZNYR2JeqpxKL7KHbud1XyfSJLFT7IG6+keL3zuzwbwi5VPXqxBcrjVAgrtPKCXEneWW0v3V5aIGfTxoVBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92wW/rKqcb3i7s/DM7dlgaoQ1eUbfEnG6rMmBDQS57U=;
 b=W0puCa20fm9WC6VR9+JaIXjczU/YBYtYc+DI3G7HLGCWM2WoTC9/s+fu60pbMmZUP1PFFaoRr+nE9yqzohKLaOcWWMlU6DYZPHqwWaH+mfXqDw3agizxBoMVtWEw5vjG2buIU1WxORUkmbT6MZKxr6GmO+ehAyi0EVzWVqfgx53/LQN2640/pk7hUiPKggRDEVm7KRq/x22K2L+b8TqP6ukomsF0LuIJ6KEjMwFwie+VLUm28ZF7B4Dm9peghG+HKp2+Lpt4SkO3Y0abkycJiSL2k10s3+qHBggTEp4A7ya3iOEGwZzscFXX3avrV4a/mBEsbhrIXPiRYfw0Nc3ogA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10633.eurprd04.prod.outlook.com (2603:10a6:150:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 21:43:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 21:43:32 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq: workaround wrong interrupt-map number
Date: Thu,  3 Oct 2024 17:43:15 -0400
Message-Id: <20241003214315.638668-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:a03:167::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10633:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6a2b44-b6a4-4491-da95-08dce3f46d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFOKEIukZp/j4nIwPY8d+lf5GSk9uR0tWIhqo4zwJNAkTYr7+xCbBt+ZVtQi?=
 =?us-ascii?Q?WK8pOllntWZLLSi/pcsWFGn40wTKn2yS3QFReNdOQXS8/dQ2FuQDxDOYsNHc?=
 =?us-ascii?Q?SirjX4hKOhp2m/t5Z+nEXG5psHW5WQhoI9FBv5KOjCWocprAAbffV2CYg1Hw?=
 =?us-ascii?Q?0ZAGQnY6NdsVyS6RlAL4uVvDGLhjjA9w7QtW2ow9x8h10TSlr9cjG4Pczj0w?=
 =?us-ascii?Q?TgzdQ6ifPquepvW4HtkWntXZ9BHs5dpwWN4H6x0iaA0Wiwro7lWwHSNJwkSf?=
 =?us-ascii?Q?VqvoSCYjkMlwx2nDLjwlPaBncIW9Jdt4UysnYjQAlIBawAJC3fKJ8YK8DUID?=
 =?us-ascii?Q?Zn5f0E5FCg/1lYcdkvf0iHuA0vUsDoAS2i1DeNVcbOYn84qBDD+kDvM/cdKH?=
 =?us-ascii?Q?xo8cdgvRRkBizbvgqdVl3Si4EaZOtfe6J0ONSlWFUQeypRq06ROp6C1To1Ik?=
 =?us-ascii?Q?2Q2aK5kPNd7BB7L7RxZw4cCV8Dg4icqOWTlQ2V8DItVUrTnLPEsMta26xcBT?=
 =?us-ascii?Q?jOnGHEsAcuqYJ2jVhsewhAZtX1jxjzAyw71XeB1+WBadsXLI7sFjRrWt7mbe?=
 =?us-ascii?Q?p4ZyKVimiqplJ9ga+6C1n6IHUFulST/X7vKPJeWUrFBNmpY3CVyo4GdPw2Oa?=
 =?us-ascii?Q?mmUiF9uSY9jrjoWnNkgDhJb7q4R4aCiIUqwJKp/SYYie7Ij6VpADsX5nSXRJ?=
 =?us-ascii?Q?Cc2HoeDGpYaYSKN1bsiXzY+njfmVxFY1op1+1idNaG4v/gsXMBlJ9yeEO4Yu?=
 =?us-ascii?Q?vIe4eWaCRMKlU1hAJaH0ilKMi3vDdsUFz/upjNRFRon5eDN6uNgw0H5460LB?=
 =?us-ascii?Q?zqJfiRF0c/KK2zslBoWmAGX87EQ3CQTCjSejwHs3mwi3m27+HlqKG9tZgtWH?=
 =?us-ascii?Q?/d5oJgn0PJmmdEeq/7MEF2JzZ7ssIVtJyFlKGYHWaPRDKwDDcDEvBGc7u4xn?=
 =?us-ascii?Q?tVtBTrX3rdwukZC2l2R7NidxuY2ZQY04Tovjgiz7/0bzdbGDKOUg6EXE05rA?=
 =?us-ascii?Q?QmAB16W+uLZaGBetZ7xdrJIgOXuhW+pPeCpY3InbvAxHyqlbrGQmYM3YxL1U?=
 =?us-ascii?Q?JPYPoLTakm70wVBKocSHRdKANL25R50PSNHLhIhIde6+RdLQ4G35e32RL18K?=
 =?us-ascii?Q?Jjgju15k9R2IR020fTKuDD7rxKdNzSp1hXZNBChJ6cITFTqTQzWI/HDyyQxU?=
 =?us-ascii?Q?hpMXuLQRCYgov7AgkT3V/oJmo5XXtDMGddLCozH6dylqdak/5eHcXW9hEQWh?=
 =?us-ascii?Q?6WuKOjTN6AQfyOunsQtCkln0fVOIY8oWK/KUgPIXRzxxWGxwacxRMgk6dfFL?=
 =?us-ascii?Q?CqWaUrxsuBwUS+SziuvLfofXm5Z85dboMQHFYc6Ql75a2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TSBiBIrraOeej4JaplpIi9jlKc3MvaZoBtBhNQ6LHVxKSUBPrAkbJgPhgBJ2?=
 =?us-ascii?Q?SJ41fK0MeNbbvNIn2oMX1VWvg1ai4lwoyaJyqsBMFxFJ8lCEHfG54bgQXA+s?=
 =?us-ascii?Q?7DQrZUu320YRvyMHuyt5XqL3N7QCZaHKYTxr+ov83ZNU6TDt2/y9Fg4HQyVK?=
 =?us-ascii?Q?eadP5+jm9zzujI1e9ji+lh+UggvzzTC6w2PqJcVJtIYMS/uL4M5Mm7xRJYsM?=
 =?us-ascii?Q?/nheWUPzXkz88VJNH6hUJf/QrgVvTH7kbpcnp2cq/9k1/wG5peMRkj6T1yI/?=
 =?us-ascii?Q?GIUaW+dfKWMavX9TrMSJzKGxpy9Z+WmF+9+I8zeGxTsTXs7wTfpJDTy1gmjl?=
 =?us-ascii?Q?xuqWOM25qVVDT2/EK73Rv2RHQrQUYjr3hvZJsPPtPHee4rNsiBfMVyT8++df?=
 =?us-ascii?Q?gtTOPB09N8pADe5wH6ywGsek5zeJ2EZDPPOrXcYxEkuUyKvlX0cKJzsvNVl1?=
 =?us-ascii?Q?/uTGB50xORnxWz6LHHcT+G/uF8I/tl81EuKHVSsxZfgT4u8mqQjAO2OYVrCv?=
 =?us-ascii?Q?EOTsTttyVGqY9ayEKDpO3uefN5OSmehlYlWYtbRs2pyfl25+nbC2Oh/YL6Sc?=
 =?us-ascii?Q?MQcX5KPw9qq1LtlL13MYviQ2Iz10QNDK17J1kDISyvsWBPzfEjjJezt4r2F+?=
 =?us-ascii?Q?OVPlybOXo3e7ezGmGbNPHBup4k4GkWK5V6eOm0DHgShh8qi91whyDPlQWjLe?=
 =?us-ascii?Q?iTJbEvLXqwIEqyYU1916D0qZEZW3Oy+VP1CAG5s+OMVCz0cJCyuAmdMBjm9n?=
 =?us-ascii?Q?j+2ByHrg0dUyjtz8mkmWNMdQYD7A5VSSsflRY3l4nFVEciXnzTtw1ubGsMBX?=
 =?us-ascii?Q?Me3zqVpSyfWslvfqTB/Qv/zyOHRT5F/uVUYHlV7a6btvKJMegevPxLGnBD/k?=
 =?us-ascii?Q?K/uQ3MrpdKdQPN0121dGX9t/ZVrW0ZnMV1FWm8QbZuPlfQKni6OyH/wgNir/?=
 =?us-ascii?Q?7uyiAitvmxms1Zaav0/30iS1R+f0mdvJxaSdhDhupJN+0dwc1P8hdLq1spTP?=
 =?us-ascii?Q?d4xy1rhjKIKqJL0nSsoP4N53MK/G9kRBtjAKwW2GEdIzB+IHkRYFbGJVH449?=
 =?us-ascii?Q?elNTz/ZriYYLyrBk+W8fY3lm6wL+JlAvgln8CCH5AIuWdv4Q5OLR8sQbAvFn?=
 =?us-ascii?Q?U5T1Dkop3CciY4nBGfjV17Wxt5iYPVSc00VTqZezriMSJT3+PM+akbCl2MZs?=
 =?us-ascii?Q?BfpvMi1wLDvpUPWHHNC9wlpMbNTYgb6ZIKkjqpkWfV9CO6ChIETJ418+SLgk?=
 =?us-ascii?Q?nlQiLcJWKjM9UbXqMrtOhDUKAaxjmoSdCiAXpTNP6jk+E8xMuQFvEqylD1//?=
 =?us-ascii?Q?h3FeZO3TtKNhZ8kwjiWPFEha6hRH8qb+boKrqGiGZk7FkzIm5gaZ2amJ5Lki?=
 =?us-ascii?Q?zEIhaI8Y8d4tvPCyZHKP19dewjCST5p28yufs+T7RrODt7ndaEUPrs8Ud6Pt?=
 =?us-ascii?Q?v1kcPqTFre6gjaDyCGaLhha9UOHKdTsucA2L6Fwo0XhIK1dMXiPCDm3vlR4y?=
 =?us-ascii?Q?ISwFTBnbl/9Vj+2clarCWKfeC9Bm2OSAB/8CBM6f+DTTYV+oSLG41A4btVVi?=
 =?us-ascii?Q?Nm+BugXs+DAxWJ3GVxk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a2b44-b6a4-4491-da95-08dce3f46d00
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:43:32.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /F6RrLlTfZvOfKWTCdOKXrubuPEy/pYCYXyUWikKyjc4568rSI/Ut7MObboLpBjj0dYk29a8H1HEUbj9239v+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10633

The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
function to parser interrupt-map. So it doesn't consider '#address-size'
in parent interrupt controller, such as GIC.

When dt-binding verify interrupt-map, item data matrix is spitted at
incorrect position. So cause below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
is too short

Reduce minItems and maxItems to workaround this warning for
'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
Other keep the same restriction.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove duplicate function in commit message
- only reduce miniItems for after 1088a chips
- maxItems change to 9. Otherwise report too long.
---
 .../interrupt-controller/fsl,ls-extirq.yaml   | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
index 199b34fdbefc4..1bfced6ed620c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -82,14 +82,37 @@ allOf:
             enum:
               - fsl,ls1043a-extirq
               - fsl,ls1046a-extirq
+    then:
+      properties:
+        interrupt-map:
+          minItems: 12
+          maxItems: 12
+        interrupt-map-mask:
+          items:
+            - const: 0xf
+            - const: 0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - fsl,ls1088a-extirq
               - fsl,ls2080a-extirq
               - fsl,lx2160a-extirq
+# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
+# function function to parser interrupt-map. So it doesn't consider
+# '#address-size' in parent interrupt controller, such as GIC.
+#
+# When dt-binding verify interrupt-map, item data matrix is spitted at
+# incorrect position. Reduce minItems and maxItems to workaround this
+# problem.
+
     then:
       properties:
         interrupt-map:
-          minItems: 12
-          maxItems: 12
+          minItems: 8
+          maxItems: 9
         interrupt-map-mask:
           items:
             - const: 0xf
-- 
2.34.1



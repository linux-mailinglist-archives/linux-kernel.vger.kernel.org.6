Return-Path: <linux-kernel+bounces-283686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E987794F7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB24B2137F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871C191F80;
	Mon, 12 Aug 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jZB7efzh"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168A142624;
	Mon, 12 Aug 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492555; cv=fail; b=MHKuhyT3hab20xVN8jzMSi75njcLx7K3/ATQlf0vTZs31dbh8ghzmDFfT4cOQRumCDAJGTU8d4+Od8osiNWFzbzIgnM2SXJvUFzAMQAvLNOWnr5VvjG18OmTK+g+yxYv3T4C5bYguFJX69omkBD2oq0RvaDHx6H5nDpE+nTSPvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492555; c=relaxed/simple;
	bh=To2RUaE5kYAVNLRlmCGImczOdxGxOvnd6eNU9pzkO9w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iKarxVNlSMa/5rJjfFH/4dUv40Dk4BlfPL2id49+esKHkc3dsLuO/gBUSoX0UT56qCL6mkqmDgzTXkotpQvHAdVl/cYENj06GptwYoIEO40TcFJdfH79SCKawyBGDLofbhoOOU/5GDblCHAjHwvrSCLfXwRjJwiMXUI/7l/f/uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jZB7efzh; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IseIrEoqqP0053v0nw5N+oyVdxc7JIWECuXKIZWGfOhOCRKZaWVD7Z21f8CzEGW+TMmna3ElvZMSdkKpsaQkXsYfyuOib0S/qOpRP0qJKewIc2eWUKublFriAr1F8GxkRaCpOh8Bnq/1FyyUTyhtAv16KjwmEsciD0Q1Rml/cNwwH4T1riFV9XK03UqHROXg/OwAwEccfiyn/eewKBT+MjnKo57c7Z4tSKGVmDFagdHPaHnNzTItMxYQ9OXCzGICfn85vJRBSM+/9C7jxour55TVX5+mJIWJQEhpH2V57jSR3rDFL2C1WNBIc7Kzq905fKmlKb+70afojHrRJCVSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa/zebCiwGiIRfTsQXDJUpr2G8WTOzZcAo71KACH0+o=;
 b=vMj6wDlDZ101ZtLQ5uYFZxEALwlfSKCcLNsAOaQUh+M5v95rMEz/guld6vICCyxck/vdU6yMnfhNd3g7dIffprXv1LP1EjaVUWws2+Wnp/FVEIjqAermhJhK222LyZsRosYv9Jo3SUhO8Qhva1SGyGSSVzZjZ03zi2/G2C8yTg9uULn07ZVXmu/hGejiz2qWZwJeF485WLsr8NMcQ/EtffQdIOxvhPk56KYf3iq5bMopKQbpe8+cB6FYzC4E07d5pvUfK8Po+lhoVn3m/1B6czFxiCAl3qFTLtsedFvk8SUsCBiwGEIVv5SxlYYihfkp4xtDfuJ/OQwXi1BLFKilag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa/zebCiwGiIRfTsQXDJUpr2G8WTOzZcAo71KACH0+o=;
 b=jZB7efzh9hyK33lUzALQ9QuJBaVBNykHf0fs68fA86hpmYsHNvOAoNsaO7942X82zdoGi9tbitYt55B9zyFPEptzdzmLDC4WUQO3MNKvVXSj/u+kWe4ifex7IRUnZFvFErJuklDgsxIpfydNv73dm6o3LB30wCFhtr2Qjapk8Yjj4DEsrCJCtJzkn94cd5mZntlm7QhiaK9YF7CEqRruivKGI29/kouOPUqTDpDqscBHHLFqfSFImaG3VO7hPNsnNj2/F8mOyudizxBh+zuSuaOJf/5vjpyTnmjkXfc5fIABgq0C2g2b0E7MUEWgqH8SG9EjD66legVkuZ2w9jN4Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7607.eurprd04.prod.outlook.com (2603:10a6:20b:294::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 19:55:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 19:55:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-binding: memory-controllers: fsl,ifc: add compatible string fsl,ifc-nand
Date: Mon, 12 Aug 2024 15:55:35 -0400
Message-Id: <20240812195536.3827466-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0057.namprd08.prod.outlook.com
 (2603:10b6:a03:117::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d936821-cd19-4ef4-43e4-08dcbb08c42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONYlGM/XHzc/PUkHQLQJgv+fraCZOV29Z75LiqrDTQz0BVMq1J9nbMy99rDK?=
 =?us-ascii?Q?Tav2rVTtkQ1SdsqzXOlu7vbbEnnFk55XztTBRDJMjtECSMGRsX8VoCmzwa3N?=
 =?us-ascii?Q?RM0o1GGcRCSKgrx9y99kB3JCUCRlSy19rnHbLZldDgcDJ26vKBM9uqnEbLjQ?=
 =?us-ascii?Q?EaNxlTMFwJ887tAmg6rtqXXaDkrusqFR6iwImzwfCJr3fzWzMWsHMDu2mmxS?=
 =?us-ascii?Q?pAv2OBVkdzoWZYv2dm/r9/UmJ3PDq6i7yntXWyrfmQQ1YBJHyI7IF6JC1Dto?=
 =?us-ascii?Q?7XGq3nD2d4eGpA5S8lITUrl6E+V16x4UaCWgFnkt4+HEsinYC6r17sfwUurL?=
 =?us-ascii?Q?TqDEACOindygezUTpKSI7vJSr23A9OgvHoWpdHKOBvqV0qPmznMYnDQOfoXX?=
 =?us-ascii?Q?6sQcvkhZSg0lPUnENtb1kjJaIMHITaPlUuIFSPiNaOI05CHwu5dUiySroLs0?=
 =?us-ascii?Q?j1kdOSfTqw6UfUyJC8kOg3SYkal4GI3ABgzD74DUof94cHnhtR11ClxrD6Gk?=
 =?us-ascii?Q?SVZRssnzOywNyW4UG1JSLGyU1QW/bjeWi/AuiayEmmnokgNQ2XchRWlDcxkm?=
 =?us-ascii?Q?a6hP1l3FUU84u3fXV0FDjn5bBhqj/r0Y6EjdtQF9g4/7lZ+tq6XYjFvRk85o?=
 =?us-ascii?Q?RzhVTvnwooCdi34+4r3HephJwNG7gjGfg2WnNNO7rVeo8zbnZ0Dt8jWrS8fj?=
 =?us-ascii?Q?UlICTKyny5+sxz2wZCeXRXZW9yWn3pVRRRSrytPzs3LuosBux75HedM3ajco?=
 =?us-ascii?Q?8qopMkprxtGdXjpPIaYl25hNwttjHphXz3BGhKVMmdtrgxOeiDRJQs5rHeya?=
 =?us-ascii?Q?lhT3mOYkvFc22Y59BCK1UhpEOGXqEcLn9vOSqI07UfuRHBywQONWeE0ll9F4?=
 =?us-ascii?Q?p9D8OsGYjMlhTmvnYEcXF+XkCUXtFoX9YlRC4rt44b5N8iH6fIaL2zSTadLQ?=
 =?us-ascii?Q?sDg+2JUdDo26lT5yuIQNmtI3RtjH1IQJzVFDeKeJPV+ffvsp+xwwmOspxHnC?=
 =?us-ascii?Q?8IBySooLgXg8iSMsZlQZ+KTEAQ4V7I5F+5NorTojzv2xsxRpqb5+jB+ryHC+?=
 =?us-ascii?Q?Yfkk0TfB5EsVV+RufMQVMeNxcjxDy0AQBysOLDlrEhHdB5caUriCgkuNQ64J?=
 =?us-ascii?Q?S7Op9HOYVC7jVGz7C4rCt0Ue6f4DLn1W2F+qHbxIyNNvrGo6TAgjHJzMyGm9?=
 =?us-ascii?Q?qxDp5NqlaRKzk+ckUTYeS8yvaLW3GJf/9d/4sbAm/vsZ+Qjqc81z5nbc/fqC?=
 =?us-ascii?Q?Bc3tdeHO22ssqSh/648QEQL0m0oW1S+ftA2yx9Zr5aIXNN6Cj2mU4cjo9FbK?=
 =?us-ascii?Q?ET1nBL2NcYYtZlK7TE98SMTCOl5zWeqLgR2n/9GEI9vE+OanFFY/Yi9Jzoxz?=
 =?us-ascii?Q?1rn7L5spcoRMboZCUyGUcle000R7EPB+OMPlXFMC5/tmpkYErA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sK0SjZNAlC42hdKEEu6uwQ7RtZyCW/RQOohqCL4XYWUfldSVXDeIM66+EO5C?=
 =?us-ascii?Q?Jk5yAQdiOh9fSmz99hzwek6LJdQqw5R9OHQmO3NIL6U0vvV2kG/eghZbB7wg?=
 =?us-ascii?Q?8WtOX5pvtiDOh9C+hsAsX4CVP2lepW1R6SGI9QnkKadDtpc3j05xSJyFnd50?=
 =?us-ascii?Q?S6M0PN1RGdH35iGScC+HaVqGJZGWC5KR0e/sK0o4s5rOTC5KlQwhik7YieKx?=
 =?us-ascii?Q?u9SKjQQNzrCxDXCrUUnIGIm9mnySqTmXDlL2P9Q7+uEQKux/xVZ1PetEI860?=
 =?us-ascii?Q?CzywtGuvgk/mil+U9WL84QkmChEWNNaJBpHdqvCM7w3fSZU+9lFWKnQKrxvG?=
 =?us-ascii?Q?x49wK35lEFSoL6u7PRNx6Q+qAHFx9SUUYgoOMXKQijDtfiaYTtzt/y3XlE9c?=
 =?us-ascii?Q?ghMDCNmTnbaQlPUgL+imvljGv4cXWR1mMyG3vYgxCDGfYtYck+dzDMpI9OWq?=
 =?us-ascii?Q?2Ord8p8ZCmBTX9CTK8BhG+zXvMHTt/8y3yoQVN7j41h6i+ktQ18azJ1y70H9?=
 =?us-ascii?Q?u8Ik66XPsiqH4LWKBGN20xngg8E2XbJi1R0wKLMNSc/RhHjG0Fos/wpeTBwQ?=
 =?us-ascii?Q?IC48Vt6+B+gJpRpWTJSgunfhlsjLRLminREm5qiD+GhRxGV3VbFZdgel/wQq?=
 =?us-ascii?Q?f6jFUhLVGUjeK8fdVSF69xA9J8tFE3S7belPWbSofGawOA4xPWMSEjN5valA?=
 =?us-ascii?Q?rhe6MuXQtO2DwU7ZOZmIS9zcf8B+m9RxdJfdVODkqVX20OiWmV07VApCCzIE?=
 =?us-ascii?Q?xlNBq2xXEgn6lPBGAa07V96JSsGnET+6BFpcqggsxQfMluYpLbDtUHUNAMEh?=
 =?us-ascii?Q?qBjJVc4HeCXwdO89JNU1hDyOBuoONBjwDq2HJFWTcozUKVLQMqLbB78VEAB1?=
 =?us-ascii?Q?582g/PvNrtLZvbJtzJi0nWY0gwdXNyB76f3G4voVrJg+a2bbY/reDm2PD8YF?=
 =?us-ascii?Q?k1YgJxfruEd2yimjgUCaA++9JLj1NSR+Wb0SLE4ynOjqZodgKPByRgFqJ/HK?=
 =?us-ascii?Q?mRb//iA97VOj3j/skwA+PIeszU0SEh7F6pY1swMFx6ZON96vcbKmXp6dpT1i?=
 =?us-ascii?Q?WtZAJErKl1XKw+02xgcx7s297i02gTmM4FuIQuqOyorhvqKMeT2ed0O2dswt?=
 =?us-ascii?Q?8G6q9ok0CciR9PVMuNif0WYxBW/oA/T4ntMQ4VMf8ykXGjyDPuRGoVCbsvzC?=
 =?us-ascii?Q?MGdSg9dUceMG2az3hE0b8BqwchyeM9ZJjUA/Zcqhuc9/5y5jwbxmiegz/aaF?=
 =?us-ascii?Q?70NM7vY4uVBoZy4zMAcSc/PXFxYIqQ9dOUnpGCB4PYceFTan7C8nqQ0Oi8L1?=
 =?us-ascii?Q?xsMXtNdBnGS5Qn9JIpFUxSBna0oLN3vOmfkmSLCiSnj69lv+0ewqNp5wJ1+f?=
 =?us-ascii?Q?5jliOlzos4U4h81KsFUExQ2ORypuNmw7/eG96oAsH1woBpJfWbfln66jOo19?=
 =?us-ascii?Q?hdDsQwa50iUshbeWViDL5PpF+lgwyVi1Iy32uTFWWjPGMrdQ6VxJX0Zf7d76?=
 =?us-ascii?Q?ucLtFiHO2H3X/Dmwg/+/X2cciWbv8C7TqeaPD9kaS9e2BsPCJufkOtuZeUJm?=
 =?us-ascii?Q?XJ9xHh92Cp5gtasNpws=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d936821-cd19-4ef4-43e4-08dcbb08c42f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 19:55:50.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcAZMGfekt4eie9X1bXHqSlLAgpzYmIkzXCK9/z1bjt8/omixuOxM+WBRjD9PIL2ypJOkOvgAfaVZK/0k2oPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7607

ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
and compatible string "fsl,ifc-nand" when ifc connect to nand flash.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
	failed to match any schema with compatible: ['fsl,ifc-nand']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/memory-controllers/fsl/fsl,ifc.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
index d1c3421bee107..7616a3a0b2a86 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
@@ -58,6 +58,21 @@ properties:
       access window as configured.
 
 patternProperties:
+  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
+    type: object
+    properties:
+      compatible:
+        const: fsl,ifc-nand
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
   "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
     type: object
     description: |
-- 
2.34.1



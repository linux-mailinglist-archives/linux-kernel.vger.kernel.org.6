Return-Path: <linux-kernel+bounces-353806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A39932F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B0A1C22C75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3E1D9323;
	Mon,  7 Oct 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DXgvcaJV"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BF1D4152;
	Mon,  7 Oct 2024 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317924; cv=fail; b=EK9MnrbBliHl3qQHU8rJ6/aGraKH48L1EK3Vu6lgza/dK/sFOa37fXVptoxlt0633WTiA+DL1D8FGqmMqWj0/xkCPJ3jXPFAEClwM3lZHnOczIMVtgFMwUTWLL+bRBrZvTgbYRr1Oa3roZoMmCcsPQc6Gi8lRiA7SnSU316+JIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317924; c=relaxed/simple;
	bh=Su7/lpVX5WLPwhGPv3ctAuwWYIn0aT0Nm8tcPmq80uE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DMDih6auP9lo7roxJl3FX1i+LRMBo85mnCX1C1aVxc4I7DXi+sG4vZB0n2oJNzqNAYHUHbC7Tr6qyM0HhsWp4hd5T/E7V4yxHlizOSPVLulr0Qo77thROrBfAkvjZLncQPuLRChL+YElODCJC1UfhQkMtdGd+irQ9O9Xx4wQD2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DXgvcaJV; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVz9D5TO+83DkQJxtuKQ0N+TGonXz0DrtqNtCIzZ8Jq8ht0THwAsvKa+2j49cd8K9nUWu3uZivFeaWGGSnonqP8ykl1XDQXq18hRBQSrOKyOmIhrNq+ba+axMz4Bz+yzciEl60gAee7c4956/gXFezKjy66uQXhLaApHyFGKNA8FufidPtIjMcEQmlNP5NORW7K52F1nJ0kV+3NOrBMjmMkCkc+3QO9M5r7977KSKa0zC0ZsjAyn2ShtZc2ZcjRgWVhI1Jgk/TIpxC+NKtIEGNHgHJb0kooitkNvDsZGlY/UpHRkbjr5R8t3zs9BSDbC/dJajzp2Hr1zotigregzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1BlkR5H7VbR69PcwYeXfwIXkxTWOPOYmcA6C4j54Eg=;
 b=MK+zQpQVPp58NwYtOC3bdMqqAEBUqnA7i7/AB84HbEsmHuDwCObYX7wFFCv76OCOQ9uA1DTRrtb+EV+S6F7lvl8asLpK2EyEw+9t+wowIyMUyBm2uFq3yQmbt4LHKayib65q6qXWS/Bhfj3uBxzCznPJAPHUECyJgOKNGa8y8+1bmnP5alFqva4Vmh3J5mEm6zVLI8d3UD6qYjlfyxxx6NPRbLoPmWWql6PSjFkd0uNvZyyIEly9a8Qsdw+PY9F+tyU35MVSWi6MesxiM86B+vJWdxNBOpnIh0BkehrjHb7BiEXMezdG7Z8KHpge6zOh+AXw9bOo8KTr2d7bDlOXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1BlkR5H7VbR69PcwYeXfwIXkxTWOPOYmcA6C4j54Eg=;
 b=DXgvcaJVpOGohyY0B6BqRHKNDzB2Nbg4u+bC+T1rpTHMikhdLsgyrlMvW/fsrgO9t7nhCfvL4q7qbvvx96FqhzpDR7quAVChsSiE7o/KZ7EhZuihEqpsXq4NOm0Oi7qavgEZLPFe956RJYqKoFUgTiNY+P1dgqZBdF5yuroVw6FH/LON1hmwwURngkZgr0nek3sy2vRqamjwrYk5veYu1MW8ns57/3HEMuge8mvUyHz3wO74zWNhhTAAGDsjKzuxpi6UiSRGRQ1YJ7JMh88zH/YySZEeRiNPijOZxTw/+M5QmFHtAFJ4Eg3wByY15IJ2w3tuoV+F7v5J0To8RQkz6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10254.eurprd04.prod.outlook.com (2603:10a6:800:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 16:18:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 16:18:39 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl,ls-extirq: workaround wrong interrupt-map number
Date: Mon,  7 Oct 2024 12:18:23 -0400
Message-Id: <20241007161823.811021-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10254:EE_
X-MS-Office365-Filtering-Correlation-Id: b932883a-18fd-4271-56db-08dce6ebb41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIppfB6H2wF87lUdUj0sR7azE2YUsxQsilRNChLiqe1/jyRCTsfIiM4XS9PV?=
 =?us-ascii?Q?RrqAlLSvm14gYh0oxQYcsH5XssBlr0wNvn4kjZEvKvirLkOcudwIZEfpL654?=
 =?us-ascii?Q?vg6O6MWHtT1gCWS2g2jSrCt5ZieMWVWJNX97bfLvUIVpEDqPF3I5Uu8B0RNW?=
 =?us-ascii?Q?5/nUNO/0F0MmNI/rnxwFJFkm5S6BT77jRm5ZZE5SeUFyz6tTZ1NL4aOU+7Pr?=
 =?us-ascii?Q?UbcrqQvumlpUdm0ggxcWZsgT1L7n7sDOAlLaTafbMWzUj2b8a/5GIxOIBNE2?=
 =?us-ascii?Q?dwgptJ78OWctofTN57YpkVBRxTtGwWozXWkGt5tthc1h14auapyPgFUrqnsj?=
 =?us-ascii?Q?9Pu81JG22E9sRTlMqoz1msBzgTUP4EtG2OTVpna044Fqexh3ZQiMuLpQrdiB?=
 =?us-ascii?Q?b6f/TpD6soilAYlm676/YiynbVmiVcq+huwlcVLVhd/w56sampThibNTVQi3?=
 =?us-ascii?Q?sc1bxASn6K7f/gV63qDCKFf/A0Ms/CuxFB3NYtkixImpAvEQa5CvJzW5COCn?=
 =?us-ascii?Q?Bf6pYzzBXJbxfpP3PY+WmlGZ2NtK8cYmq3t1tTxIXYiMhwmnUk5qj0k0WJ01?=
 =?us-ascii?Q?6UQUhK9Sj1TQk/gFaaXW1rtb9V+F5b3aPJkGSepY7yDcjwieG06lcoYQFotS?=
 =?us-ascii?Q?yKHhNzzmldaeQr5lwNr3HcLMaz7blO0XAc20ptCJ9pBDdbIzUwqBKffEDD7X?=
 =?us-ascii?Q?4+eZb/fLzVnLWTrCcnp8VGKArgT0uDkum8xi/sRPYrGn7KyBXykNlQzh99UZ?=
 =?us-ascii?Q?CnO2As/WYnBHz+GNAM7cMQ7nYsfAoRZpH0HBMl8JZjvUXDlWZKC7PdratJX3?=
 =?us-ascii?Q?fvmWCBM8hqt7toGMhr26IyKvTfCQMzSCwACP7GtW9kxExASIk5Vans0tNo0I?=
 =?us-ascii?Q?xUrfBJ+N5hoSJ5aHD3JxrXMlmyTH6d28aP2eziz7da/RHO/bazM8HUZUDvOv?=
 =?us-ascii?Q?ASJmjtnFlc0Nt+EhnnBh8eR5I5cQin8hryrxrfFSiZST3VWwYvofZ9A/tO9l?=
 =?us-ascii?Q?C6ysEsCe6Wagh6itgk0K5lbMYH6E1w4BEJMgLbVZJhWiFQB5g181O4a7KpQn?=
 =?us-ascii?Q?hljwxwohQVS2/jTKFb/kg4kBXW/zZZO8spwajT9qezcI3RPBqdxJq1V6Hh8Y?=
 =?us-ascii?Q?iUeQ48R4+hmF9BC1wvYExWa7YnwBEBunOchlHsLBUML2gyX9GYs9hEjWsQsY?=
 =?us-ascii?Q?oG2Clj1Cfqtc7AHFdmQ1/zkICxg5VZcqfkpmAVy1oiTNHkpE8zBg8EZz0jPV?=
 =?us-ascii?Q?WHE54/nLb4u3GiP3VBPRNPd0vnp3vDzg2rKSgqHIUXVaEz8av7WYDp6+GIWA?=
 =?us-ascii?Q?fWjs7YTzfFpu8f1SXd28txq+PYfrCQ3xbFD/f8l0WG0Mjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?639X42lGv9iNwaMh2z6k6xIW5RP+Jl+ulFZSjD+V9N1ocQeDO5/SfI7dO3BP?=
 =?us-ascii?Q?yyRjRCw2oC1XZ6WVURFFVCa/5ROC6cGUyfJ3mHL6Kne9aU7Q37qOYEs5G/3J?=
 =?us-ascii?Q?MZwH0X0TXKpx6f7fWotaF1NBEpAXdQN4MyLhxgPoDoc27B6PywfhhL2jKI29?=
 =?us-ascii?Q?Hz6Nae1CIowm2k+wSlVLDSHaSmnfH4vipgWUqchfle03lzI3Y6VYVjn9J9B8?=
 =?us-ascii?Q?Ysj1Jm/XvetCllxMxTCXU7O8BUltSaBl2cIwi/2xl10bzxabRuKkkMTjwCmq?=
 =?us-ascii?Q?nAKl2SOmgLbHeB1Ko8DXeVHtwco90tfLApJ0XaFZ/Wl8A8EvkdHP5QUoxe3l?=
 =?us-ascii?Q?HUCBJKCm0weGmx7NCdj1Y5xwwayeEwzPGTINbzVCSpgC0+N3Ee52Z1fjxq7H?=
 =?us-ascii?Q?6bCc4cge4vuaHUbQu/VoPzDVJN0m5GtMjHjFZYYOl+/q4zoHdStQWlUd3uah?=
 =?us-ascii?Q?Hm+qBY+6CmfMRy9hLFk5HPRGcU9FsZ73wTou910Hl1qcfDbghiLOEWFHBdZQ?=
 =?us-ascii?Q?S7h1eWJE23SvWxW2Cc34d46QRZrsix0O0PP7QFSyIRjfQh0Wlag5f5HTV27y?=
 =?us-ascii?Q?vVKW1Gwpdbot8N6L6JL2TfmHagqi0EcX0QQBGFBY2zAw2koleIFKpdwQYMqd?=
 =?us-ascii?Q?AzlcbfREIfYh7tstgODV+4abWLj65sSAC2dCFbAVDrkZ+FVKIQihky+xb67Y?=
 =?us-ascii?Q?h/6dJ4O6OFCKDDkreUeeIyGh+8U1Oz7AJBmrVM6pTEWSsmyVJiKBhID7MshU?=
 =?us-ascii?Q?c4HJzYh5Q0uTSJkrV7q07p26tb7G/QHq81bPNEeBht4nNr+Om1xetp37ECSL?=
 =?us-ascii?Q?l2ty5f6QWf5aw//7VRIH31REPKOuwx1AS/v6ACJPNVxgvLobxT1m01Xk6P+Y?=
 =?us-ascii?Q?UiP3RpWBBQ76GUq0hFYdyMrqIMI6Cd+Dp6t0WoS3atXKbR2k7xGJC67IoG9e?=
 =?us-ascii?Q?OtIg4Pkathz/BrG+REPzS9vAF1PBtFHOWN0f9YyGFIJCzAOG9/QCcr/xW/UB?=
 =?us-ascii?Q?6f4FlVURUEDoSMgnLKpqJZa175yBW4dz7O3zhoNuo8spRxCMfXkzKvtsATl+?=
 =?us-ascii?Q?QzAtzx9Dh0mKMlSImTDcxN4hXHNx9mw/kkdHxcVumocJh/4yzrXbFcsNNyNm?=
 =?us-ascii?Q?bIvzVpSDhYh8+xpTJXBKqchQRXeXLfyqRiT+DA9CTTHV2DM4q9suQVQ8lKlj?=
 =?us-ascii?Q?qg3t+SMWZViGNvRrecUNGsLE2KqIRr60iSJiRfp7fqlRIiSu0rK7HDKPxYat?=
 =?us-ascii?Q?5S5R7pucZrsUO3Sffdyz+k+9hp3AnyymG0A5Xtt60Nc4HyKMSybPrqxMlyqx?=
 =?us-ascii?Q?hxmOOsQjcwCKOT4/0CwhmBnTVRl4IEPeQ97RBq0GcgUiU1/XKQ5djrraZbk8?=
 =?us-ascii?Q?EJ3RBIkUSd406k9lf1jTXPhWntvyJM/4RyxkPzIcTXrVzLAEcw+sseYAV5n7?=
 =?us-ascii?Q?+s3/WFgZk8lB5Gw5nnQYzpmSfzbCcyBA9qgaugqgIxErOj5jQo3M1jRzMFGB?=
 =?us-ascii?Q?Lb36W1dFf7wmzVC6I10asXKxsKBL0Dnv/zBK0sKslKrNDcUyqVmhDzcmteHK?=
 =?us-ascii?Q?SFd/fcA2IsV03dEcU2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b932883a-18fd-4271-56db-08dce6ebb41b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:18:39.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9PCrTs8yLp2T7ZcYb6H00KrXM9aVSw/JV7AEjXBbsHy8+tvqwcfN9v4w/zjTjPlV8FcKvqUgujmE4jFrsN8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10254

The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
function to parser interrupt-map. So it doesn't consider '#address-size'
in parent interrupt controller, such as GIC.

When dt-binding verify interrupt-map, item data matrix is spitted at
incorrect position. So cause below warning:

arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: interrupt-controller@14:
interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 0, 1, 4, 2, 0, 1, 0], ...
is too short

Remove interrupt-map restriction to workaround this warning for
'fsl,ls1088a-extirq', 'fsl,ls2080a-extirq' and fsl,lx2160a-extirq.
Other keep the same restriction.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- remove interrupt-map restriction according rob's suggestion.
Change from v1 to v2
- remove duplicate function in commit message
- only reduce miniItems for after 1088a chips
- maxItems change to 9. Otherwise report too long.
---
 .../interrupt-controller/fsl,ls-extirq.yaml   | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
index 199b34fdbefc4..7ff4efc4758ab 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
@@ -82,9 +82,6 @@ allOf:
             enum:
               - fsl,ls1043a-extirq
               - fsl,ls1046a-extirq
-              - fsl,ls1088a-extirq
-              - fsl,ls2080a-extirq
-              - fsl,lx2160a-extirq
     then:
       properties:
         interrupt-map:
@@ -95,6 +92,29 @@ allOf:
             - const: 0xf
             - const: 0
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,ls1088a-extirq
+              - fsl,ls2080a-extirq
+              - fsl,lx2160a-extirq
+# The driver(drivers/irqchip/irq-ls-extirq.c) have not use standard DT
+# function to parser interrupt-map. So it doesn't consider '#address-size'
+# in parent interrupt controller, such as GIC.
+#
+# When dt-binding verify interrupt-map, item data matrix is spitted at
+# incorrect position. Remove interrupt-map restriction because it always
+# wrong.
+
+    then:
+      properties:
+        interrupt-map-mask:
+          items:
+            - const: 0xf
+            - const: 0
+
 additionalProperties: false
 
 examples:
-- 
2.34.1



Return-Path: <linux-kernel+bounces-309366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2253096695D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D1F1F24981
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B91BDAB9;
	Fri, 30 Aug 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FtnlYLt4"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B821BDAB1;
	Fri, 30 Aug 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045125; cv=fail; b=qv2ZIVtL49wV0dnLECvaXwiPqK8Ex9Uv6GHwiwvSubs90ovOnzZYQ4DakZ577pkU2L8myPxy/3hM73B4Nv6oCf/mAU/AvK0LbqX+Smh/8j7pcxT7ufHDvIRiuAzuBwgBYemvzjj/yQ3labOS9kMMwfyviSbtEbiZql5sdezjx0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045125; c=relaxed/simple;
	bh=jurZ1TmXHZuFJmTlQv1sCLcc6Sl3YMsDQGdzZpKUMls=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QU1QS7A2vCRlHqJ2wdgDsEQJnaM8PjYkOHd6EOTi/2Jdp/l5PRxqT25X9L5O+Rj3I0dKh3gTb7tCSjHf2ac1QuDFElxre/VGt1HCNjFimsjmZ2+9cxwNef/1I2TIml+41w7suY7lQbHGY/b4yK5zV5ruB8R+SVMKK1A1DNX0CZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FtnlYLt4; arc=fail smtp.client-ip=40.107.103.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/e1wpoESPTvTrynb623ac7f5PeVKWW7GPFbhJBZeLkI8KjWYJmAMnSIxppKYapyCQswrURRloaUmtRJWENwPbZWnp8t9ilrvjzhcVTTiu8mgA1nMu5rimKLBRvIXQHMIcredxtczgOVmiQEQbVf0gaUE6rU1Kd8473w8FTLtYbCDQgfPgHqWX0yNQO4QNXAYd91EbVykG4Rs84SsoRSiBGOFwxV6x5kS9lEWgljDUW2sY5h46IK+2GzKCQkrlmoUhuIeHuT2kOprJMzVbjusjLDGD9IcrJ47aamQL3lAk5moYWeQhQYuryGOWmDzYtZY514DcFnkReC/Wi1YTBBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOLyshj89qqVq3kDNzRnTSs3EOZRrptVXoF3pzbIX/c=;
 b=iQRULtabMZ5Op9TwWB/8wQmzOkyuL4ocdYNh4MOIlZDEcYR8+UGShg9aQ6vNtPmcCgjeFscEtOTJ/2U4qAGMalkDfJoWQT/cVAqBo9oHO61tPoMSL2ankrKTpxO3Ik0ZUaof8EovwUCfC5fNn+yNBgm0mDK8e3QFLg+/cfU7sX7jYb6Caucybit7H4UZtEoIkiN9OW8eDzMFLibppoAXNWjv2P2Sbfr5KDLDYqSmIEFhNfzLVsj5UujEwmrLN+OHXeslgl0++FVvytruc8M5Mm1GBgep+5esHbu/POE49Duq8atixe8V2qLaDe9VIherf3bKLOT4um4c8N4ay+V66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOLyshj89qqVq3kDNzRnTSs3EOZRrptVXoF3pzbIX/c=;
 b=FtnlYLt4itdVjmmoHRncvl8PYIxwmA/UA7ibbnVPgK+Qe9cZP13hFFtwJUnFF2xmHi8IXEw8vhPOVIOVgnkWmdPdvAgec8F5ov/IKEMEPC06z/f2DuCJc/qppVHYlSW3MJMPRSXZ0zuQd8+hh/WxF+kkhcA/NUXQ/ttjmaMn4i5Ofi7RCo9NmNvm/yQ+LL7y7wF33TSnreJE0JAq20mrTB9mUT83e4n5+OFwkbb1Ay3drz7mMJ82atzxikyiKYMxpl/YfVsB4ui2Qj0Im98BglbKjsG2s8yVJNa3SmzTl5yxv0kAdG5TA5Ui5i+kvpjdUKDQHS5743LpBg68KdiALQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9637.eurprd04.prod.outlook.com (2603:10a6:102:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 19:11:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 19:11:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: memory-controllers: fsl,ifc: add compatible string fsl,ifc-nand
Date: Fri, 30 Aug 2024 15:11:43 -0400
Message-Id: <20240830191144.1375849-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:a03:167::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7196f75a-e411-4dc0-cd5c-08dcc9279f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/S7C8xutqXKDIBr3hVTLnHrFdbUT4gFH/6icsmettEUOxjFWuUmDVf0q5kCp?=
 =?us-ascii?Q?DNbcl2MLg98ICffsNVZbgcUR74p+7t96yx5jp3BC2aVuId6Sqyra4ysc83ws?=
 =?us-ascii?Q?qpwQthcXqtW3IAXzZAzvy4okAr0xXzkwXy5wAfGlHXfQXmIntRI0NIW+fJsk?=
 =?us-ascii?Q?w3yAmAE/BGxDMJOdmu/u2eIKQRkr5O8SYoX3oif+Dqgplo072OrARIxw4W4d?=
 =?us-ascii?Q?kOfBrmW50mvh6RjelF+f3JU3PjDh6ILjalkBJXNn+UYpC5vL0VumpsHNYs6K?=
 =?us-ascii?Q?XbsWOkX91JKN+JqG/DlYKzVExIuj9fJ5D7ZFRWWReRtXiMZLjhEcse7KJom+?=
 =?us-ascii?Q?TBUZU40c99Z4UswI25nPS0e055CJbRbPriWEVoWsDIDsyD74kmmbZxUv9DJA?=
 =?us-ascii?Q?DRwhEvO1Ty3tQkLhLTP7JgCPuakAw2srjUg+Iex1KQ7ZuoyVlm7l2/4yCbdu?=
 =?us-ascii?Q?1NXFTfqNmtnWxxwVBLsBVrUAAp3I3ax3bPnnO/icDC1DlXQUPdniUreSqX9d?=
 =?us-ascii?Q?zzL3mAK5vaUzNw9Pe3S5KrbPI+JN1eZY0o6dYder8BX/dCicQLXYXAywEgBf?=
 =?us-ascii?Q?WHW48wprIyKyHwQauOnovWll25shTWvTFnczgy1p5Xqks3j4W/Wbw5xn9h4N?=
 =?us-ascii?Q?0HnLiqVwIR83g8NDOS3eGkoHxGJ0yXzraXmJjL5XJDyL5xe2t2c/okvGfQj0?=
 =?us-ascii?Q?JP53UFa0T+oNJWiIv2v7q+YoxP4ihAZJId5Y9NSOo3qQDD7++UpLm0fghpiR?=
 =?us-ascii?Q?BaKhX4mXSdE6JBHd4TVNscJ1iVLytGurJ3Eu0j627fdIitF27GaniUmnKSx6?=
 =?us-ascii?Q?7whxa4dJ3HYcfhrZWTkBztHAt5dnDK3yLRB6n0+D40gI/KbzmoFympd+oVMW?=
 =?us-ascii?Q?X1VJByi+XQqcDfYY79fNPmsnMofwkcKCga5lNkbEMxtgLeW5JJXYfKjHwCKV?=
 =?us-ascii?Q?lCQms8ysvKszY2lwSb8o9yuhvsAZ5h4sRPDzGep4Gi/MWeUSc18z9ZcTOYko?=
 =?us-ascii?Q?SxmRbjSmnMQdZbgaRQVf+VFpH6hhTp+xDQxMVXnwiMYSWWywGB7N842r6KL3?=
 =?us-ascii?Q?4qKOUTcs8OzAdFomCJIGJV4+SGBdWhUT/kfIUXNhDCWce9gPMpEdnbL9pFRq?=
 =?us-ascii?Q?c8tvabZBuDBHWbVvDFBlmtgmCqI/0AUZ20PA5/RiYXbg+EcVAmSt/q9RVYra?=
 =?us-ascii?Q?ZWb4YbQ2jrqH9DGAV0okWFI0tLrZ0NwOoauJj9wW9d9fU4HKtYlB180Uiwxl?=
 =?us-ascii?Q?mrwj6jdU8pYas2WvP2xb//zyjm5jqC1CIW06D3M57sRSUNvgKTmFcQjBTXXt?=
 =?us-ascii?Q?13Bfwtl0kSnByFx5GDd7iT1lHMg9p+yyRsopXXUtegWC9AH4jvcvlSMnZeXw?=
 =?us-ascii?Q?STI+MS1l+lgT4sv9Gk8iOsMmwNO7PSBz+6Nc3OHDOsYeMeKMoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QyCjXYFX4hb38Td3F5pFhJ0RbO5oMXmOgo+rjT51wasSV+kbXKfgG00KzHhZ?=
 =?us-ascii?Q?RAjGjd7niAum9Ljx+FutdrMrbVx1Y+F1d872xcveEsgtHUOYWJLkxrLFs0+/?=
 =?us-ascii?Q?88F8r3DDajeCerjAf8PLVOlUxdwpmmsLOHbEzHNn88ZrRrcMz/V5mpmay/T9?=
 =?us-ascii?Q?qKBLVCmTdQ0ZM72Jt+wIlQsx5K0CBQ/A+so8YU3trVj+2WMOlNqFggmtbV/G?=
 =?us-ascii?Q?6t+4e1NVQ5RFKWxH7/p1zUteMOKEMCKDxnMeyzBzuP+1/dKSi2zb670QcQcQ?=
 =?us-ascii?Q?dAHZNycLw379Ye7CuOvzx5xlyOhC93Ek3SkLNZzFt4e5TXUKap3Oi6jUtNm8?=
 =?us-ascii?Q?OT02eBazBQjK6PU6ryniu3WxBfUgzdSGNSgl3bPjeH6DpH1mA9wV5wqzyA87?=
 =?us-ascii?Q?ZBLoCcMCYKG0N0GgI4oFqtWae08JSN5vxaSYxQqLb45w8aj5adOMAlAIwQqN?=
 =?us-ascii?Q?U+oXfV4wFQINRqJI2zm1H7BTZVDRz3UCP0ilaD1mX7xh4jPsZ1A34XWNlT38?=
 =?us-ascii?Q?OUtaAsyuoR0eDkH8szNWLf6q1mOmr9tDEflezqMkTC9/I/7sa/CyNqppOuCX?=
 =?us-ascii?Q?xZY4y9k9HGJkSUmGlxkYEraMivbPEFWfrLVa0+Cq93xXzVVmCYi2bgcSmb9Y?=
 =?us-ascii?Q?GqbD27NhjOHgd4ivye6o+RjdmCS1OnXJoGFIAah145b6M+3Kt5nYhHEdaB1c?=
 =?us-ascii?Q?jq54xu7N9NiHaNLAPkG1zdHKN7ZltjfBMD8YxGustgS1Np/21gkZm8QY9+1s?=
 =?us-ascii?Q?DRp3UyGeBWdTGOZgAzlKj/QuE7k5gP8jfmAUdzpgLx9VI0ENA0kRiUHIVOf/?=
 =?us-ascii?Q?EXhOLaXuTcjdTePdnQly2z6yBP9aYrik435feIqHjP8LkBcEa0PU42hc1gyG?=
 =?us-ascii?Q?JciKGvqSGZ7MXRwkf8vfy7e6xsY6iVBfeQlMySb1w4APn358nG3M5ZQdIdwF?=
 =?us-ascii?Q?ciESl8TZhA7DHfBNqE6TvQeY4zi69IGKjdQh9eDrVPfZDOxaaVkxn+0NAGOE?=
 =?us-ascii?Q?r1RljvXy+5Og49ZgvEF1Mhp0es47TscMbBosfDNkwdMRznViYw7IvVavwqMF?=
 =?us-ascii?Q?uebsb15m8e4eufqorShPJ4+5n2QgubyC++pvL/8sS6ZY411OdcfbZTfIL8Dn?=
 =?us-ascii?Q?1qf0FZJdiiP92Dg8G10+tapw0Ok2MO5CaBfApvQ8BD+15J1WX4V1PjJqL/mw?=
 =?us-ascii?Q?az2Lo/N9DXvehGVkZpebc4lvdUHqfgBQi01tq85MXPfQB30phdYpj+UVVKne?=
 =?us-ascii?Q?PeRjKbIaZFP6Kd3U9E8VFWgkJBiqFMusr7nzE/3efRpbsEI3Z/a6NEOwU34a?=
 =?us-ascii?Q?iW9uKSeq+Iz6ELbUQMHQgp2v1NfgrI4EZHieSp4cqNf/DWiJS7AplXO4Ggxe?=
 =?us-ascii?Q?PrNyyUVaBlAAPFj8u+WK+2h19O4ImCAXnNZPZMZ6+Nm/1feQUS4dNtLRvC7X?=
 =?us-ascii?Q?F62B7asS/3Gz3YKhfOokh8n6SeSJvpQD8JR/UYJL7yxf1zD+VmkT/f/772+s?=
 =?us-ascii?Q?7MbRynv6KqHyG6M+1/g4ogpyyNHqF/v9jFElSgO+/7Xn8vf4bTDNTxsYJhPh?=
 =?us-ascii?Q?0p10xIi88WwB/yDMKlKMQQnfxOcdhyksrefg5MhD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7196f75a-e411-4dc0-cd5c-08dcc9279f2c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 19:11:59.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slUorxHrilBYUfN5uc7qJNnOyFmVQ2xLOcGbN9JUIUBDn8sQbnXjCdr6/nO0yCymm8HO1fbv/OiMAW6O2TZocw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9637

ifc can connect nor, nand and fpag. Add child node "nand@" under fsl,ifc
and compatible string "fsl,ifc-nand" when ifc connect to nand flash.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
	failed to match any schema with compatible: ['fsl,ifc-nand']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- add partition child node for nand
- Only partition property is used at ppc
Change from v1 to v2
- add address-cells and size-cells
---
 .../memory-controllers/fsl/fsl,ifc.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
index d1c3421bee107..5a11224da8914 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
@@ -58,6 +58,32 @@ properties:
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
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+    patternProperties:
+      "^partition@[0-9a-f]+":
+        $ref: /schemas/mtd/partitions/partition.yaml#
+        deprecated: true
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



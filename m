Return-Path: <linux-kernel+bounces-321801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDD971F99
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6DB22061
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066BC16DC12;
	Mon,  9 Sep 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVhMgk54"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF8165F05;
	Mon,  9 Sep 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900861; cv=fail; b=ZbCVgnZBvGm7gsaGoXc36WktnLEV/tS3rfuULL20JVTACkSO8UWt9EseRh5LYOKFDehc8YQhekdYgnjCx51/4x1K6YW3vhgY3LQUYDDOk3r0a/Htm+BliV3OSzMF6vrxh7354xqZGMkcO6vprArXyq7yRTQMYJRCwpJDN6l0UJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900861; c=relaxed/simple;
	bh=2sQ6x2385TRDB6Pi+TNAawjFIDedTN+aA9CNHoFJaiI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YDy1TaA4ninBnAEsAci2N6B9R2semvsYIaBTq6GFEW1Oufv0eEjxp+b5FZyfpwaXsPdL8q+5H4PmrcqHesvTHjPXoXl8xwUVmBtb3xZaI0ASBLQuyMfPuq7Y7ii913WZ+hwbxzU0dCFIRGxrVV5KII7dJCD2mAQrr82uaenq030=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVhMgk54; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktX6Jja3gobm+LSoqB4i3jaH2ndbtbV7U0rKnimWxiWVI1e7IG8Nv5BXGOOKjmiQfzkJMr9zHh10QWCIxlz8JyJhMx/YGB2CsbmTihv+g4ru0HHBpX41Kln1RBgKUa6Ox0bwjIKZUmx0yg5rBucRshCHwRRfz4vfnpCb77v88ooLtyCMNUiAscSoxz5uuVF5+B5DCSoYyAjEfT/xwu0EfIyq0esFhju10bdOl+r6N1t0QcrdaE3ST/b4aDnlsNUPBesd8vqpKSQ97mhFwKUIw/kCfXkfkvLXX0NbRQJ0DY1t3jeyQRoVB3Sykb8UNKD+uGjMuESxdRnHSYwGU834OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUsx6p72jW9zZ1OMw7FddTTod7HaZJr1vKb7ayHb3QE=;
 b=hyc9XfdzA98RjHxWBiygVeos0rlO9dZ4odLz9n0c2KQB+CHfTiVQxtlNrUAb95AolTCaANnqLaiurEwil1wnzQ8DyRZpUdOx5qh4uSkG9fmCqF4WLjztP3qPvwZ96gAaJ7cCfjfZHdF+LqwHScyiRpwEJ+OuTyw6nzldJIQmLc/ty+4WvJ2HQzT4PYBI2e3uxBjPzTA+TuT3vbj25IGwMeIFV6bRmMLAMOuC1uOQzfzIFpFevQOx8tsyorSpnKmL7ecDmUHE2ZkCMRv2BuuDkg62BB623/LQz+TXFMCHfnaHcJX1KGdi47NjzC5kCBbHTme1k9romRFMorUCp2EQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUsx6p72jW9zZ1OMw7FddTTod7HaZJr1vKb7ayHb3QE=;
 b=RVhMgk54zWU4DPUUiTmqkuPB0oVCdYa+skGvFJk0+pDTOKst5bVrIomfwMQK8Odimt1tDPBSwtch4WRGwtEmFphEGtq9DR1n19SEj5H828tAgIOskr58RQFDRyLaj6dpEn7fcEXeM4MbY0m8wBD16uWuMZfWGN9BK9vqtnN2yR2lJILCtZqJFI+O/flEKXoPt1ZCYZ1Grcn+c4tP8MoFpD1wEVSu7TKUyhEo8a+usugRh9m+KIvV1oWzHMe8TR6vcTaMMM+tj18MAGInyBS+/TXEfMSywsiXKxVjnHRKHYFz4xgl3QPxV+kWSmSbxEufD08yGOn234yAHlnNW8sxTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 16:54:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 16:54:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org (open list:MEMORY CONTROLLER DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v4 1/1] dt-bindings: memory-controllers: fsl,ifc: split child node differences
Date: Mon,  9 Sep 2024 12:53:57 -0400
Message-Id: <20240909165358.2384975-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5af172-b209-4d71-5a52-08dcd0f009f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKf3CYbx1menYxiOAv4fCK6y7Fv3GU+47hhDtJv/iKVTxEgtO7CwDMXHrgPG?=
 =?us-ascii?Q?WqU20GARerM6F+D4MT2YQwdqUtqEZFT3e7+Hlow3LRt72eNqeY1qBtL4Z8T6?=
 =?us-ascii?Q?GBMfsM5aUjYm74P20+k2f/AVlC2OLBvTLySADhDM7Y73sIpKgkWnzauuBDSe?=
 =?us-ascii?Q?DT5x6Dj6YaJSZvWy567H8sN74dtfnRqtaiBbzk9DJzWidN5OwwRfFLlC4uQg?=
 =?us-ascii?Q?4ZiOSzcPsvgPfa5IuGecISRjnu6x/kt1rwlTT6Fil8JbqFBSItU9bPEbsu5W?=
 =?us-ascii?Q?GFeNIGyTA3FzCRNxAVq9Eg4anmZwsjLUcLUvJr2hqLDCXdhsJ3orluTAotRt?=
 =?us-ascii?Q?xB02pf22ByELRgYUk7ranmjP9Xu5yo93PIh/FMdDlJaIiCq2w8H8x5OKAMOZ?=
 =?us-ascii?Q?3CpleCuP8ypz8ufE+GPAdSHxtHsBi/EaEM/SvYQjU29sek9pu1clCWZXhq/n?=
 =?us-ascii?Q?3Kr5H0D5K8dk75b2NiiHuDgJZ8HuI16pP5eoqOD2oZCdi49oDxULSdFROres?=
 =?us-ascii?Q?pr3jF0ozTAlf2W0QDVx68bi+U72KwYFpjOgKaK2RjCWh6rZU4oQG/TaaMTd1?=
 =?us-ascii?Q?1pbO9gkEcH6VPx1KEucVyL+EsNT/QZDoh6KE6k3mGkKLFvXTybdKFFJfREFZ?=
 =?us-ascii?Q?/gmE2q1pQyIl4BqFoZpA/VLO/XctJZFpfs18q2AvwanVoDCQJo8dt+hPead5?=
 =?us-ascii?Q?ub8rVgqngwdO9aeszSjqho1/01Jzx73vtI5shW+9ZHAHC2IBSOBmIqsMjdc8?=
 =?us-ascii?Q?Xce6YGRe7OfOZO1ZqwIE+XSXc9AjeFJYrrd+eF0mIB2pQNsYFB9WsOnbF9QV?=
 =?us-ascii?Q?Pg+Qlc8wIFlewWgn7KN+tK9/zYTM8dt04R9X4FNXE22xGfyR7aJCblDFJMXz?=
 =?us-ascii?Q?eo1yJIVLzfYXRjhQg7bTOZ5+4jB7AUrblHGYceIucskcbDFe3WxnqxDMtVJ/?=
 =?us-ascii?Q?UqLwoB/cfbcZZDf4B7iGzLMNdmTB/fQSasMGj7nBhS2Fo1GYPcLIA2pv5+lv?=
 =?us-ascii?Q?n/peNMJf7bODrTDs0lxemzmk9/ws+sax1wGHegiKZQavkVIvlrmC0tnrylNt?=
 =?us-ascii?Q?mdU18bc4C9MW4uqd7bqPtF1rOXPQCYKkC2LgJCQEGD0u+But2+ZkjYOVIbWA?=
 =?us-ascii?Q?54WsxU14AdbZj7KSffX4FndDIsTlv+J7TDGpiQIHv1cG0L3Sa4+vxqmvivik?=
 =?us-ascii?Q?+B4L0J5M9BCeZeCS8icSuCvl5s2AnM5QJ4AhZFJeMO2u3N83cskf/o7v8QY1?=
 =?us-ascii?Q?HFgjUeZi6liTeuqWM21HLUoNgDXB4Kq8fQjJUkJHgGhDd2gR879yLu2hBoZm?=
 =?us-ascii?Q?5FJLAN/YtcQLRzI0i2x1c8GfJ/ebzWAJ1HO7GTksK1QUxyUAdJEeUvm6ciTP?=
 =?us-ascii?Q?3Iq19YEbOwobfeidJZLB8Sh0XEi1pPznDls4kN9rZKyhEIhADQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77fcemXQ97SX1R7ZMt4m7LPzvc4dG22hXuYEK+G46GV9ncOQtSyIbDg+BFCB?=
 =?us-ascii?Q?xSoIaa9oWXDL2HXHZkWZrO96jspBxLBaGibukmbokSOjK3DkTRVqAFK2LH6T?=
 =?us-ascii?Q?t9u0mK+wgZRt36fMFJd24ySwZTP/4hGaw3AW/bKoQSpMdjBdsuMarlSJlYt3?=
 =?us-ascii?Q?u9RQ7kIlN5JFHZ5zg+4IOFQF6dO5/8GlJR0qoL3bhto0yLaRGiv9uiiCkeoT?=
 =?us-ascii?Q?guYUunLHVvtoZD6tDKiOFB8TIjErk62qNLNlUxaSuLDjdAB0rF2NgACbgXk4?=
 =?us-ascii?Q?fwHIPiHTrs6b9/iFf5lbRGDDIkND3e7RYbHxdmQSG6CvszVij7Ox9RQ7U8Tm?=
 =?us-ascii?Q?oZASQy/2cWdn91amA7SlFRm5mjgX0hTb+GlZJ216aYjnEhze6PYtR+I7PVB0?=
 =?us-ascii?Q?/lluZ28GQMVzs9rCyyuXMA2XOh0JFIHIH3w1uE1VOLPbMm1LTRpq/x4g1F0W?=
 =?us-ascii?Q?iYPYJtSGC+sTby/FSlWGMwsUQYn/HA+z+g906eDaqGAh0BN5C/Flr7fJNL+w?=
 =?us-ascii?Q?vOBpjt4I2XJ4TFeo5L57BJBWqX+OcIUjkuQSk+HXQ7laIOTnooTtTPrhAk13?=
 =?us-ascii?Q?wFpC8JiIQfEnZdDYWxi83V6D6F8n1fWH3cHtYHDTtmrcj+tDUiLTLA9wKB7x?=
 =?us-ascii?Q?E5Q8aRNQEBsCj79Lm0PNwiCseQZlDbHKhQWjSFyiYqMFYtqyqvbEzKPoCQRH?=
 =?us-ascii?Q?z2SNfipLPSsG4f6d4PJ6cvyVFNegluftVfCYnL4oDik+mM2wmhJBRr2gghhX?=
 =?us-ascii?Q?UkBGHtepaR6Kh6+jLQUnt8Xm4UVQivuPcEvDEKR8iCjPP0deLn5wubfytKzB?=
 =?us-ascii?Q?WXKdhjl9TNoZvQvMfW+9K2IR3JXkporftWZlLfdFlMOcsRHV7aV02jrexPAO?=
 =?us-ascii?Q?QPaKn2abJ39My6VobbW2H/SxxaERC4F5MeHUtAdBRXN2LXNlHrAbS0YtAFYc?=
 =?us-ascii?Q?IkicJCTMVN5A0nk+UJh9As3jhNkDZqh5L2Y7DDUmWJB1WzO/hM6sY0c5437U?=
 =?us-ascii?Q?r3K72Us+2+pLPD1FbwGOnociD/YwgtRuN5HRTPQcVSoKdy/KBh6sB6uJxuQd?=
 =?us-ascii?Q?exXV895teh0ybFRSPCyrYvhZZowvER1s/6zYvYedxJKcP38PpyQhr55nVyHn?=
 =?us-ascii?Q?OHrIpS4JoMlwU/atKnr0s5wRR8L4Ky8Xe5gUKEIKDoE3GCTvRTPQ9yb8RO58?=
 =?us-ascii?Q?RYQaTw8crF+f9e9nQv4bhqIRRmRcqwoNqdLdu+6FQdRtAJRxSnb8wADT6qx3?=
 =?us-ascii?Q?zgUW+GbFVJUWW4JGANaCB9vwItsvDdD00kd4ZI6vHSjNiiS5+wezKe66C26B?=
 =?us-ascii?Q?GxbmIO841YDyhENwlgMqhgcHZjNAoLH11T9TsZBCtI5wEfnpkACWCgHF/jZf?=
 =?us-ascii?Q?vS0ugwbD15GBZHfV6/fDfwYTvdXIEkH6+iT7oSipqbP+t3rZitdsKmkNL/77?=
 =?us-ascii?Q?8pP47rO7rhFa3VrHWQdcvbxUHqgh9zI60Bd1OjeWwwT/uJnq5xcdAeT4iu9m?=
 =?us-ascii?Q?+I3XR4nYZiZhChXhDgjWAQ/Y9QQqN/liILqyEpXT3mgmOAMZQ74jZFxf2x+d?=
 =?us-ascii?Q?kBy6Qpj0myrwAxpF61PXFZz31bFBMQs6jXYMnfid?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5af172-b209-4d71-5a52-08dcd0f009f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 16:54:16.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8YEHn4m3KLwcfEE/sb3dLJxe7ZsiLRJBLAm+NZDvLy6oFDEoMd860uWCFi7KetKbmiRhakinaFVbV/6xijFsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854

ifc can connect nor, nand and fpag. Split "^.*@..." into "nand@..." and
"(flash|fpga|board-control|cpld)@..." to better describe the child's node
binding requirements.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
	failed to match any schema with compatible: ['fsl,ifc-nand']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- add pattern property for fpga.
- fine tune commit message.
Change from v2 to v3
- add partition child node for nand
- Only partition property is used at ppc
Change from v1 to v2
- add address-cells and size-cells
---
 .../memory-controllers/fsl/fsl,ifc.yaml       | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
index d1c3421bee107..f7cf0f91c1c02 100644
--- a/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/fsl,ifc.yaml
@@ -58,17 +58,39 @@ properties:
       access window as configured.
 
 patternProperties:
-  "^.*@[a-f0-9]+(,[a-f0-9]+)+$":
+  "^nand@[a-f0-9]+(,[a-f0-9]+)+$":
     type: object
-    description: |
-      Child device nodes describe the devices connected to IFC such as NOR (e.g.
-      cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
-      like FPGAs, CPLDs, etc.
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
 
     required:
       - compatible
       - reg
 
+    additionalProperties: false
+
+  "(flash|fpga|board-control|cpld)@[a-f0-9]+(,[a-f0-9]+)+$":
+    type: object
+    oneOf:
+      - $ref: /schemas/board/fsl,fpga-qixis.yaml#
+      - $ref: /schemas/mtd/mtd-physmap.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
-- 
2.34.1



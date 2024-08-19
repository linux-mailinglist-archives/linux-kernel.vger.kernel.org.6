Return-Path: <linux-kernel+bounces-292767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA3957409
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817641C20F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFE196C7B;
	Mon, 19 Aug 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jPbplp0n"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91130195F0D;
	Mon, 19 Aug 2024 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093873; cv=fail; b=ZuIywr3VzInDLr3a1+/7yKV0SiKv+F0lPYW5JlozotG+zhmTD+MASzrA+TG1qodaLHMYUAQStfkbRvQzruTspTB+wYBGJ18kNSbmHu51x9CSCwhJ/enMqrIxnPkQAAffQM4dQ0R258lQnz15ZAv/9hFTOJCPzxmBTZ26OZ+DS/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093873; c=relaxed/simple;
	bh=1AePEk5+DSQ4vqszgjkJl4Abb6PhERTfOtuyO7Xxsp8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=M7IwpEPkFXHNYDIG4mly6nbKhzgj/6pmDTpexwqDvUlFz66FJ/sXNRb9LpdMEN3WLWHZNnU9NMFcbMVg3zfAj6tsJt2sN16IqLJp0E2Cpbt+4q6NF8MpsZAVR5L8A35szSXzTn7uubNbyf9LFkB7TPOEqCJ4t6DgxqFFt5z5zjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jPbplp0n; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weQvuwDNZravXVFErQMbM9BB1O7jHYuevyEX+3R+wpeLv1409JgQwKz7r2QI5n7gah2JZEde5FyWysl3KJAAR3dNlIM5y17iLY/S3esZtrBOCmvoFGwJQeOE4vJbRKO6uuOL/3u4QbxuKOvpHWz2Mdgp0uZSD4OcSl4yvMmG9IQUuc37z0G84IZyE69GjUDDoWSSUTXEeqtByl/MmDSALmpdxdCL686GrS/k7jHo0Og8jFtcd5empi/5q0Mnx4fioiGIovOigfA45blCNVFH6vVEhYEz1+irbGh3zazEoePwCAa/Ut2+tpwor9vXrtXyPzxWJFueR0vHqaz8sl4lUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSY2s5CK1N/Fdh0q09Z7BSXqKQezcuZ9/39WJCu1xiQ=;
 b=k+AsPH+0oYpzaApG1AQSRZw5crAya1T5yaw+aqw/eOiOHR+Dr/raqexHcH+Al3Ac7yN2RtimXk5XrgFVuBvhc1AuICVsrmkvdiHyQVNTGJ5j0E9ZxsLtA0goMmo3VIzqj5qDO983kbS4WKc1luep5ebNaI3hT5EF/6qY1w8vK67Mx2lEiN6O3/cxB4MQL37jJIr1OoqvjgIAzcB8Gc4gjMhfHUK7nL0pmm4fM0tajXZ0grze87PKyj/mu3xanLyfm5V9Ew+LlSUPp/pgnRb/mv21R2ypQ6FfLeVysSlTpymbcLU6RgtJLolnFLXjGjeYnEB3HHYGjiEfxP7z/cCKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSY2s5CK1N/Fdh0q09Z7BSXqKQezcuZ9/39WJCu1xiQ=;
 b=jPbplp0nc9rOjMWjxiOzbbYR37NGhtvmFhvkNiAMD5zOqOAi75A+AGBGwkYBa5/SLEGpbE6UETV7hhClN/++4Rq4Azc2UhGf2ZoA1eOBFr91OACJ/RdIwugO/u0E5qLGXxlXmw1eHc9XkXA7KnRQGsg/NXqmyUnscCIkCdpqGe+6uQj5aO9ie04y3g6mYMAfOzrg0NeIFVScE5IqCNbnwDsj6CueBZwkGMC2XTQGg0XinTX5iTEka8H6wjQ1kmn4ySpu5QXfdV9RI6BDKMjSGM4d6T9EtYJskBQ7meu6aI2/UtqNaRxRkDkmYEh4IVmG0t3xYmXJ9ksJy/hXCkEUQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10958.eurprd04.prod.outlook.com (2603:10a6:10:581::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:57:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:57:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: extcon: ptn5150: add child node port
Date: Mon, 19 Aug 2024 14:57:34 -0400
Message-Id: <20240819185734.372469-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba793ac-f65e-456a-2c6b-08dcc080d1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmzqlX4ZY+ZShM8oUsnR8pyEY0kAI4tGgNL9zDKvlKG6QpT5xyo+RqkehTw1?=
 =?us-ascii?Q?Y1FcSOmYCt/tvT3EFK6asnbDq7SkgeahM5RbuLS5oUMi6p4edsg4cPgChm7v?=
 =?us-ascii?Q?bAsT8UsmT9cflWDiO60ySb3zC1Yp2WuEm/Fi2+8cLfuGJi/WhVgkfuW46BA4?=
 =?us-ascii?Q?cWa8eU/tNBftzH4X3KdfuSC/F28uyxCAo1QacJ2ovG4kOTzgfikdYkaeABzr?=
 =?us-ascii?Q?6bCG9EUgFfH6F8Dg6gSfPj9YbeXhtElmrPqmUIK4PMNpI/wJRzrN1Xy+pjDA?=
 =?us-ascii?Q?IeJk5/FuCU+M6WttcS4r9qZtpU4yBpaeMUNmiBW9cXtKG/OIqLb7ui5leXPj?=
 =?us-ascii?Q?Pr6A5DrS3vV1HyUF0uT1lFzPYHWOJ1vSeqObxaJY2desMDZYE4tG40Zpg2Na?=
 =?us-ascii?Q?0sjiwR6nwIgd+bsY2LwmEeZKN0npnOv5RYj4ln2SUA5nmoEMAH7RPIE/L3uk?=
 =?us-ascii?Q?K6LNEF6j6LtWxDRmziLd3CLPbzSFykh29C13L+TPq4GdoZVVi6iFMjaBgogd?=
 =?us-ascii?Q?0HNWN5rfG/LSpac23+BrbfE9IBzG4cGtn1tSW/V85C75TBAN71kWsMNoVTyF?=
 =?us-ascii?Q?/rGTyFedxsrhWR3uXZ4Tgl+Wu8U75NprtkqreJMGDPFntgwUD31MMU5g+iOs?=
 =?us-ascii?Q?Gl2JOj0J4+WOwJsJBI120usFeATpuYyVf8mQCHyIXf54FisHkRdPkgEff42M?=
 =?us-ascii?Q?UzTYFFcSx8h/zuYkP5+KIIe/rQp2/dwTeIUwhbHAc6HXa1OFVPd/PaU+knoU?=
 =?us-ascii?Q?2X7vFJ/1Z9mTMxpBDu3ipbw9dJpqiycf0jtiCSgs3QFJrxrC4MHK+3rcombi?=
 =?us-ascii?Q?UQY0E/c+/FotvpvUdYPt2H4sUfdu0GR/d17TNqtTBEpwmLvoV2vQa0FofU6i?=
 =?us-ascii?Q?c5o7JyOS4sJ2Xm8Y7oxuHZr34LxiG/k1S42UfQMti4q9YwCfpJceU/E52fT+?=
 =?us-ascii?Q?PwHpkHbR0gZiaKSvaGEfYuvTxgRo5s6K2oi2LMS0WhfA+Ij6svIUdgfOL3Y0?=
 =?us-ascii?Q?6BxaRxaGJhOKXKQ1DHR8sqP1+uKgmiLg5txZtELdvZg9RTDYutpG+aH8yu0a?=
 =?us-ascii?Q?QaTN7SKcPNfrckCTg1eyhSueU443m4UwbixBWyCHtSOtfAZWMXwlr+pRobGf?=
 =?us-ascii?Q?8GEzWHkIMPvmZZ3jwGfLIP/87bTu/0eBPyGmE2tXNIAjM/u4yDpQTrteJVZ0?=
 =?us-ascii?Q?v8YozSmOYtPJ3LaFQkdfVgunG02gOOqmmQcPmQ6NkfYdtxypHktEdI2lRBpO?=
 =?us-ascii?Q?ntXWpit82O9a+FPL6gRE83FuSBpSskex4A5gBbxw8+Leddd2wad5Ek8n+d0s?=
 =?us-ascii?Q?AoXq5pUCWbfnnAFEF0p188C8QIlrdNmh8FssvGXQ5mMmv+gEKtOX2A09BCHM?=
 =?us-ascii?Q?1+QwRig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxeJYrg2A5Nxskkj1GG8zcHzlLuXp0806lh/XE2K01cUprHiB074io5rK7ph?=
 =?us-ascii?Q?x0q9cDC4z1KNDJevk2c4UQFPSzaUuKvpHfEHF9zJNbp9janUmQoGg+uIKmTP?=
 =?us-ascii?Q?kJtc5cYsvoIVOj/9rZvsv/8BSY3YN+U9N8SC4aPqpJkZpTaYvCOYxeiAOiBJ?=
 =?us-ascii?Q?DLSsDps3JKfObZoUKKjlww49WdpgjntiLVM8HhFKGNrJTTVJdFjHJvuWAwh4?=
 =?us-ascii?Q?4YEPqPEOP5I+OcNVLoZf+47FZuAK7epFwAafQCCvKPSLPWVWKWuQvqz2CPtr?=
 =?us-ascii?Q?Sy7JcCGcWxCGtekWAHL3ElLGYm2qICLncrxjw01XIbIjAJe7pDXY6eFjT8Wd?=
 =?us-ascii?Q?sFmOdGK/OUvzjXBjCX6jBb9IQ4kj37Se80sxumU8i5s4asbAzJK+VNJhSfJl?=
 =?us-ascii?Q?KrkTKv1yxdnm1LBFVvv3x5l7SQ+qzNk9oli6zb0Ke5ty/iQYQizUMg66g4fH?=
 =?us-ascii?Q?1xkFtO59K3barY303w0HvG+Bf+59coBlQLROry7Rills5fwe7eVLY4ETIhp1?=
 =?us-ascii?Q?udgzTl206IxlBjPq+/fYBrr0SUGYLSxVwqXaEo7r09dox9PtbVFEVNzxrda+?=
 =?us-ascii?Q?BgiOn/+yrMTwkSTaDDn6mx4QpKaKd4IDD5dP8WuxmohzJU3TpSvK2s08T3UL?=
 =?us-ascii?Q?TSZ+vUkhna/omVpnwmBAyt/O0Zqzylh3GPkzD2W2N53PEPuei+3KaJH+YIuG?=
 =?us-ascii?Q?h7DwF8QVFV+0uKCWg7ug6j//6nbKlfP55/lx6sUreZLUoeISi4FL3t6cBo14?=
 =?us-ascii?Q?6iE8ONGR87Yl5JeXL9LtNeJi446uJ7oLOrBgFOkZQTdq+qNE7gbI/JfSFuh3?=
 =?us-ascii?Q?8+PkA5UaDCIudAbbN1KRvYkjX7kEk1Eru5RF+RtdOThGEZqwv3BaxPVXKr8n?=
 =?us-ascii?Q?O7UBDhZBPF5i4MPNfvW1ZkYLUNnb+J3VcJVmM5QL0grchl1+OfJVtTzUt4xD?=
 =?us-ascii?Q?aiFg3FYwhdqPE2ryrfhGTIjnRjh353FFjXbkYvlExuZXKDIqIPETYzM5/iK4?=
 =?us-ascii?Q?63vtd9+DiNGlIrT32y+6r21ZCYooseMhs6V5N5wKhdx0SNifMoo2jWnlgv7R?=
 =?us-ascii?Q?hZoJ3UJj3cBlhsm2JsPhONQ9iD0PVwgQZyWupKGabZaQv2panR+o5HjSUjjM?=
 =?us-ascii?Q?68Bqhmtqomijk40T5MfD0hQFIhOmbh8eYr4a9RCqNBQ89gmnAppWkCT1r8BH?=
 =?us-ascii?Q?mIB4KydwngjWr9ThJJtbihcue2sP05DQDahcuMidAGZKmDp+mTCTpTbPKKlZ?=
 =?us-ascii?Q?Uf6owE85e8hnOlld8mXaIPHpy9a/t9NAxFAQ4CEFjFWNALBjgktBHhW4La9Z?=
 =?us-ascii?Q?rWdTmCl6hop3Rxpyv1tWdpSvYT5tChL4U2FmPGhHCkE7CCePSl1f+mC1ps7B?=
 =?us-ascii?Q?jNSWj/ynM6AgklmJ1FcmNwJ2jJv+2g35dXu1FQymFgseNqYaadf5KItvVPJO?=
 =?us-ascii?Q?Ax0UJGrKUt/07KrNsKD+CoOzxcakacHBu/sNoVoxoqGzp/Hii3bz8568VKZo?=
 =?us-ascii?Q?31sC1r9bz2ujD18VqzFWRrxWCF8nbzd0+XwOnNAamYHDlbW8aYSLPcvW9R8e?=
 =?us-ascii?Q?gA7+WkpFkGr1R5Z8Mi3yKDTcHlxNAeyPJnYVnqS5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba793ac-f65e-456a-2c6b-08dcc080d1c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:57:48.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2nn2S/G9i1BWoWpMXiFbeupmQ2grCfCl+2OZc8SRn5SUNZiu0hQzKYbSCOo1KINdQ3HK9lPmwTdOSOZQVFcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10958

Add child node 'port' to allow connect to usb controller to do role-switch
if id pin of ptn5150 have not connected to chip's usb ID function pin.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- only add port to existed example.
Change from v1 to v2
- add example for id pin have not connect to main chip's id example.
- commit 095b96b2b fix "port" warning, but add new warning "connector" is
not exist. And follow commit revert this change.
690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
- I have not board in hand to debug why "connector" is not work.
---
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index d5cfa32ea52dd..0f61cd64e4bc0 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -37,6 +37,11 @@ properties:
       GPIO pin (output) used to control VBUS. If skipped, no such control
       takes place.
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the usb controller for the dual role switch.
+
 required:
   - compatible
   - interrupts
@@ -58,5 +63,12 @@ examples:
             interrupt-parent = <&msmgpio>;
             interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
             vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+
+            port {
+                    endpoint {
+                        remote-endpoint = <&usb1_drd_sw>;
+                 };
+            };
+
         };
     };
-- 
2.34.1



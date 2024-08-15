Return-Path: <linux-kernel+bounces-288546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16E953B81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F311A1F257CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7C14A096;
	Thu, 15 Aug 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZDznGiy0"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013037.outbound.protection.outlook.com [52.101.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158E83CD4;
	Thu, 15 Aug 2024 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753982; cv=fail; b=R8xuFfJLQxsFO2YY0ttM5rKyRVKKVB/hPPWC9GXTAzwmnv4U68v3FmRaIJ4tCFBG65Ut99XsRXBS7u4TQjjOTqqr1Q2pRmzkQs4gdaVT8SWI2n/wKwYa2PTYL+xg4VjyBY5zEyaDeb7SON1Cx8y6ysBgig8qI7nPNTzXKxvRv8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753982; c=relaxed/simple;
	bh=7bLQVp81BZyN7LBGO26JBtFBmNi4jaX8Ns8Zi7VGQG0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fyY31pvhXClsiEUd6v+0FVTkXce7a7NkI58IZcXagBq7iMCmSbqqBM4Zbu7WlOUSxRHjC8wQfltcsSMaq/HqqIMiTCflZgtLMDTtjjL1fp5SLL7J+UNy4v9gThk+12dewVybGciWb98gkbe7acXVtxkxIyL0/p/ad1N55IDJlo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZDznGiy0; arc=fail smtp.client-ip=52.101.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKERp9vtqkuY4Uv3pZpWv1pkh3cid3+FsvXtDEwoKz8kplePU/ZGAqOEMS5ZmHRAATKn/UmGM0dsFWAUMgCVmtca9UANLiZNmximuGhIeVQCPnt06FaG3qrG2Sw6Hi6iOe6gsa9OZDGv720oyG0mMYtNRW4IrTYli9ANxwvcdB5czP/uyZiCWNMS4rxcgb1KaO9s/RDc/7b0SxLXXzkLTT+eh/PgkddOzFDBMfqfgOt2pn5Ig3umWy7c8fp6vqrTk8dQUPA6mVd9R8tm1vfHwsSn5yJpnlBts7ZLbkHrTKEEh4cmctZJ5EWZ8sH5hXZGpdJ7D09+NSSAgFHVv3GD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHXfEeaYeMPh50F7HYUfDdd4MndD4fi3B10Ne7OqKS4=;
 b=Yrno6LDZMhOhfIGPdL8W9XWqLwtI1qIAipo+rT1pftO6wk/B0kUdyGjGWUqaXDcVTB2iOkDfdfHFGbr2nLngXVFKT+/VdA7lqep7pL6TPcEfBmOMpn4trU85WOhpT6BCaE5WLCXxhFiAArjXq57qTQGZq6HQvgRnHew3icYPM/GhRmqG9fE5Ui/+nPpxNL3QJlVXMkImp6pO161mHf/oQkR5O8JD+ULROplgRunaTezx908cC/1GQzaUr5ML/i2vJrho0mjPLg3Am+mBaDXkEX3QajNpyqLd4JKzqN4xrGPaqkGjKnF2xijTa5MijKBYxOa2B9UN9TQ9MOGtmXK/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHXfEeaYeMPh50F7HYUfDdd4MndD4fi3B10Ne7OqKS4=;
 b=ZDznGiy0qGswL7T/+W+wQahJx0SmPUUyJljDVcW7XVGVlLhmhpFlJTk9nYquG3WigVCEL2cyRMs4D1ofLw7dPxlNCjCdv3X/2ctEUTIGEHXu9yM1ujvOeWannNEcsNUiM34HM8vFLcmZZlnK3i1vs2BvZam+uinPsYWBVpKOSDYQZEoDtHRp5X+RinDW8Vjj7ORBW61gcjJ5BCaSSrs/nd01pPchKEJ4X1KvdgC2kqQxwtc2b7ANdx/K1A6YzAezsbyE0o+wNY+lREu5mPcOTV/7nFD4lfrTT4hKfKcGuZy7cAXRMJ/U7kNN/k/gyWFnRSsuexAkSelrpcCmr+w7cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 20:32:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:32:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: extcon: ptn5150: add child node port
Date: Thu, 15 Aug 2024 16:32:44 -0400
Message-Id: <20240815203244.96963-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f4c848-3406-4cd8-76e7-08dcbd697298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0b72d1OfZ9fytKAVGXbnHDGDMp7uD1X6gqYEsXLSTUZOGbJb+IlYlmTaDdD?=
 =?us-ascii?Q?t4wDj7WgigDNlo265bghp39N56xr0+D2c98AFQwvfXT3ZGzNtyvQg6sIdH/p?=
 =?us-ascii?Q?4LeCnrL33xhunb8QZMtum6CqFzv3m4fpSWGJ9tzhj54kl1tKqBKJHoEA2CEC?=
 =?us-ascii?Q?08HF5R4yQcyaGv9tSvgM1dams5bBjZKaLhYLSmbexPYlXP2tqqDlgXvcoNKF?=
 =?us-ascii?Q?0UgnE6uVBh5Dn8fBba/UTcTgqufnut6RWUJpJyzl7lRbkVdtWyZLPaAsg3mA?=
 =?us-ascii?Q?Lem+8b4FXYEmVo1LnznkE+lorcahyjku2b8eOC0QR40BWoMMESjpoCaFecQb?=
 =?us-ascii?Q?55n81ynx3leNT4vjXunQF9bx0UPzqfjcc1OXqxYR0KJkZwus5am27BfUeVQd?=
 =?us-ascii?Q?ZoGjoKdRaGpgYDG+7nvRf7RC99knNc34vNjEF8UzDPC5b9LHQmHqqMn4eNao?=
 =?us-ascii?Q?MeOtYzZR6tOD58Q8ndgo1kKkbdGySaCP29cyek8fssp0zAGdMP9lNz44y8ux?=
 =?us-ascii?Q?lND3eZ5GlQd47ETUZIYKXhD5eA/A1GkrfqIQeJDNsFxvb+dnfuZ568Ry6Dhn?=
 =?us-ascii?Q?w420+jETUociwl4+PbfZMIRvVMmg7DD+txE47e9ynnVrcmfJ5JfIGKMelCnd?=
 =?us-ascii?Q?AFaEtMF7WOowzEgL0S8USJ51GT8AHZqriA04IkO6DN89cD6lFLDlQ3nUQmVA?=
 =?us-ascii?Q?3okSlQ/72M6JSaHoqGbovJyi9mzXeTQ/dU8TAh9XjMrNRXubCVW9QlEZEBv8?=
 =?us-ascii?Q?d1ckGM5oKfwbDebsse/TUgtkYGNQR3CfyPwyqG2Iyy2oVUcZFs0SA6BVNdN0?=
 =?us-ascii?Q?7p4fCyae0S74M6TnztMNMH2ajPwtAbInbi4pe4U/YTz/3yLYB1FcM6201y8d?=
 =?us-ascii?Q?+k/qGehoym86LQbFYQ2rHOzcCbeuX1+5UsdyRT0Vlb6xTvUEkNiSe1RNeUBA?=
 =?us-ascii?Q?uJ1uXtHvRRHC6C8ePVz2mJUfcx5GqBJ3KCKihRmWN5G8zGesyvhlpn/YEfnz?=
 =?us-ascii?Q?taJt5Asdzb8arlU+sr0ag/mz9yV4m1OL+K9oCV5PyQAMA9PF8fXa27LIouM3?=
 =?us-ascii?Q?1l0I8yFhypycAr2yS8hhwrES2y7qlcbY+FdGXfTiM+kT9CpCBj4uSnw626LJ?=
 =?us-ascii?Q?jlWmSUTd8kCotD9q2udG4nB5B8t6ZunOPMRqinRgkVmLtnGIyAtHUifchE5A?=
 =?us-ascii?Q?jOxr0TqveJFbuf7XIPuNae4ZpmzWZp0BY3Gb9mkihdqVcKJ+InORxYpnutVu?=
 =?us-ascii?Q?nyZm7tRAnYjVa1EXlQHyb0IsM6srtIqJTfcpqzETn1RH0cijzkIyCeYjPWy6?=
 =?us-ascii?Q?5dwjjOLVXOCgPuY5PPw3LRp4QOguaBYgT3UlBeMAg16Sb1k+swr/Pvl2d+Tn?=
 =?us-ascii?Q?RLbBdiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KM2hJe+ZHgYhgdyWFFA848rmoYlxtjAsIYw7qQBbwpMlOQpoxkp1F3tlmxa8?=
 =?us-ascii?Q?ow565aMfQ4+qp6Hek62pSskduh1+QFH/6EPwWWq4lx6YDhkVFRpcA1NB9X70?=
 =?us-ascii?Q?w24pUD3QFod/e8ldQX47heYjMaPSVtwr2ZEAV4uFFczZcy0uYKPKplVTsFF/?=
 =?us-ascii?Q?YhrEMb48CIhBlWL1fzAXXOupVc2c87ZuldTiOK0GB2BdS22AQ+jQviFyUT8w?=
 =?us-ascii?Q?GlLN9XF+vkpwY8AuJByxHLw5Vi1+6S5aSpddv0eel0Gp+sMG/EOLbidCFCyZ?=
 =?us-ascii?Q?7qiuo4Epav4B11y3NCfyTOk6dqUQ7QVJo+8KtR8L23N7Wbs4IBWFdUBFI7vs?=
 =?us-ascii?Q?hSvUWRTfAAMQ3qJN6PtdI8N2cnD8Ar1fF8RYHdLn/HaZpM5WwI/i5gWZpgiF?=
 =?us-ascii?Q?PIZn9KQNFL9pp4/9RWEagqpr+ZVdbZ0Y9Hg8di2h9so682LTK4XOWkiFyjv9?=
 =?us-ascii?Q?HrXgdES+yAJJ/j3dUt9rt3YTusK/Z14A5GBxl46WOsdjzLFSfd3+SKsSKpYl?=
 =?us-ascii?Q?i2ofAYNPziDB843p1MDTJfx/jEiVOOGYuONI40O6RxtksyJAHaQzwefmaEGE?=
 =?us-ascii?Q?UeVyiLapjaH/i3+TOIBguJAmGopuBnD+qDovOhXqxkOtMdrSKyKQVUwAU+r2?=
 =?us-ascii?Q?o4cdS7QJXd9iVzvak9DKJlR+pUGfFrQzGWJAuyX16tV2ZRi6RySQ0VnvGUdr?=
 =?us-ascii?Q?3SEKxc8rBhfpqLmxY0Xr0z4Z3s/ZOfD7m9Blc0A0CgXFWGnIx0paxCoqLSCt?=
 =?us-ascii?Q?VLmJdS8po2iXV8M2NLIzag+zt0RuHZK5P5VIR3zd9zYL/x+lzeUvzHnU4H6I?=
 =?us-ascii?Q?av7VM/8l0jG6aCswDVt4DXRCUwL4Nuekc9dsUHyEyaRgJHzpB6wpmHNOjdWt?=
 =?us-ascii?Q?fgjS/BYlp0FoJ+zVzvsNC9G8ScOeeLwHVy39M5EkV4vRrVrYR1crYh+nY42Y?=
 =?us-ascii?Q?g/EaAVbqT8CBM087SmO/BUMnBPkrSqOAuRYORLYHseykYju57N0cCzstxnTn?=
 =?us-ascii?Q?tf11/vzfSqb2Tk6mMWdfnPBBBQBvGPhnfFf4jbsfWfRi+caxBOsqFNw4nSyK?=
 =?us-ascii?Q?Gf0hM4cHpbmtuc7QIMDiiiXWjvPoAaND48RMh6m8Rwba0BMRWEieDjwKnOmY?=
 =?us-ascii?Q?WrCN3W6HrzKuSy35PPumPLCr/yeDJpq5N9d7/Q1he8BYzcIFbM8eQlBALDcg?=
 =?us-ascii?Q?bNbnNFrjfUaaekrfd10zM9XpdTBKewuL8Z1aszefqpF6Yci/zqCuZ19UrrTs?=
 =?us-ascii?Q?thSpNUF2b5TgT1dhsPw7opdvSEEW793YIuGF6QEPG8oZgAdjlDpHYRtUTu+n?=
 =?us-ascii?Q?/jDU77c5hYbJH57M9ziQM7WLb8/YR0dBug6RhP5TQBQ+F4jS0dmuendeZmAE?=
 =?us-ascii?Q?C14kkQYYTRAZ7OAnVIijkM4mBeQ1V0+iBEe//jLxYxfD5kA8Q6iVF8xlatfq?=
 =?us-ascii?Q?YlaRUPdm0QH15kAr9mfTaQ6zkvFErAU25ykmFaEwly1X1qfYUycTMIbYxzQQ?=
 =?us-ascii?Q?1Ng6UAZMaVbDqaUHRF+CZdRNF+4c6fXNWlNHhIUwoCyDPkklLa8eTm1v0aW1?=
 =?us-ascii?Q?5HychK5CGHLTPIP7Wyo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f4c848-3406-4cd8-76e7-08dcbd697298
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:32:57.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz5qU80E64h0iLYbHM2h1FWWzdncfUqAbEMrUR1yU2S8cEb1g/PCBUizjIlf40xmYGmsJKIvGRNeila1Zwz4Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

Add child node 'port' to allow connect to usb controller to do role-switch.
Add example for id pin of ptn5150 have not connect to main chip's usb id
pin.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- add example for id pin have not connect to main chip's id example.
- commit 095b96b2b fix "port" warning, but add new warning "connector" is
not exist. And follow commit revert this change.
690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
- I have not board in hand to debug why "connector" is not work.
---
 .../bindings/extcon/extcon-ptn5150.yaml       | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index d5cfa32ea52dd..39231f9952826 100644
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
@@ -60,3 +65,44 @@ examples:
             vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
         };
     };
+
+  - |
+    /* id pin of ptn5150 have not connected to chip's id pin */
+    #include <dt-bindings/clock/imx8mn-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ptn5150@1d {
+            compatible = "nxp,ptn5150";
+            reg = <0x1d>;
+            interrupt-parent = <&msmgpio>;
+            interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
+            vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+
+            port {
+                    typec1_dr_sw: endpoint {
+                    remote-endpoint = <&usb1_drd_sw>;
+                 };
+            };
+        };
+    };
+
+    usb@32e40000 {
+        compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+        reg = <0x32e40000 0x200>;
+        interrupts = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
+        usb-role-switch;
+
+        port {
+             usb1_drd_sw: endpoint {
+                  remote-endpoint = <&typec1_dr_sw>;
+             };
+        };
+    };
+
-- 
2.34.1



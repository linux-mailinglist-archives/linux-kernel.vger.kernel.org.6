Return-Path: <linux-kernel+bounces-294148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A709589F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205A11F22411
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487119580A;
	Tue, 20 Aug 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5CXhVJ2"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3841191F60;
	Tue, 20 Aug 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164774; cv=fail; b=RQ3YGpe7qTdaEfANb8cidvZKm0FV/TJpGYazvzIlcQ2VtGK78awpPVvrcvTNT1ZaxL7m1wuEigbf5XfS79edrx60kb7CNtZBAUYUXIZ8MZ2AGzr5o7n9h2zDtsJ7qsFO1PX86dNBwpelxHh1pNgjoNrPcIiZBDNj4agukM+ZuoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164774; c=relaxed/simple;
	bh=xU0t4H8Csh0ruSUzggi+mgAfsJx37b398RCpA3BVx98=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L6cr+qEZTE2dmploh2S4Q2e6z/ZPANkJgfP9VnpVjZv1lygNo7c2x7/LEeo5GE/QaXEIOuMLpDDtDPwnH3ZPcGRicf5Nhw72BjAERWhOY5d8zfPPB69XxNRZYRVN1TredL6GYeN6ktinKy8NfFg5pAdAJgHUBB/QXwfVqfuLA8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5CXhVJ2; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxZed9gEYv7+riGUAsz6V3GRxiFyxTF8XIXBiDLSwxnnNXLV6Qe6KALefoO3qYILKMA0O7e1ufdxx9iqW8Ejjbry7ckiJuTSDIKfWzAYIA4vN796mpYXS1dQDTaPmPkwPVdCksaPm0CRIjHpUmtdPm+6EBA/AHf/+ijR/JeZBAhSq036lCXBZDJGa0hYFu1pCc9b4rkV9XfiGkUPMwxQmQtFoKwDoRV6kQVLl4i/DAOah46/R68lNAq05b0HROvwGRTcU39jKohQalDBKryzpBaUVXBjXVqErWbyUZ999QYLwDoY0kp2PPmCzQIWD8I6Hbw/rzQcCmPC2w0wHsJZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDsr8v+Beyti+1EoNjUT6eY0aOr0NYx7EcHq8Quj3QM=;
 b=ndXAa4NW39N5QMH5CETbyxJPBCGO3ESUa1cK4iuDe6EipE+Tq0yAdPhLMRx9WuDy1+Qrl1SAXPMXVsHNrDD3Yz1Z07/ZKRA0gDlzAQ5MdYUh+laUBDzd8jg9gPv+qzra+QrTmSXRkvBKArRRK9rRvyyGZtmHzEHPxcVaDAMdCOZhGDrKoaH4tXOtqwoHgI1OZDZ7VX6C+hAKWusZ2bqNYhssWWUTVqlJVgj5p8Lql/BnWGmJvUONVYf0Gd+kLtjEUkrGHmdZ8u/eBl3KSoLcM9MgWmr32WhTrsD4bZy7YZ7jlQBq+Ryrfmtzr4xd+bQjmQwdFyzuntJJRckj7xN48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDsr8v+Beyti+1EoNjUT6eY0aOr0NYx7EcHq8Quj3QM=;
 b=H5CXhVJ2/WDPnjvP77tT6T0lRhsqfMH6hsHUn3oZdjG/wrNQJVSR0Jbd7V8AQKJrL5FojwuOPkCMK0ILW/c17/r/sBMA1Z1y0kCxED4qjEeD170MC8snbQLKeZWQNtYTD3QJ8mhI9hwPaHT3IX0FR9qG/DCme0f8UZD2oWH7Z4qV7/sSiexGNUkavLpc+l0793KvZpvwDLcaBCu6SSCL/GFWl9xk4kUPL/Y9Y3JOW9IswUehCH4nBY4d2H+UKtFkprkr1JMMjWqcUnDk5U20g+RTgDtos9xQ4JJ4qm1iiCdGFdnXaA7I6LMCFyYTghSTPq7d68+8y5qULBmz3FRVVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:39:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:39:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH v4 1/1] dt-bindings: extcon: ptn5150: add child node port
Date: Tue, 20 Aug 2024 10:39:11 -0400
Message-Id: <20240820143911.444048-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc49473-d631-45d6-c05c-08dcc125e52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yhimVCkmagEXf5xGLU0rQuCKnZiEtCCe+g1fyS2QBHZixS16/MznDLPYE0JB?=
 =?us-ascii?Q?yx6SWejwt7vAcW/TRs0oVBBYiyHkxyifAjNP2TEmu1WbhuxU9y+2lFY3mf4C?=
 =?us-ascii?Q?lLUFof6AzW5gJ6xmzYa4rnFkT5rFCfxotNQ5e4rt/jwfvxc9dUwYuSBXSwxO?=
 =?us-ascii?Q?ZX7N6FXiX0aCUeQC4gj3VzEyilNw0IGxRlVsQINgVsb6yXaAX1HjJKXfVaNn?=
 =?us-ascii?Q?XXBQfu76UndIFg6fE+dV9pxSbSSKBisjdIeZB5JO4idE39fJ3mKsuRgtxAc/?=
 =?us-ascii?Q?+H6DBTK3s/S1Ns5FvFvVAgb/uGbf2geLLO8s0sMNJJlBu71bEnD0ihWQSv/t?=
 =?us-ascii?Q?DjPqwtc3YzTxt1FpG4O6iQbKg2pVXKg6jyqxry8Qenm8cvaUh/dM9TrMRdVB?=
 =?us-ascii?Q?1imKfMHWK63NUMT4W3JEFd/5bTrpScODIOXJjAlPcyXw3TI3vo1xKEEgQ2sq?=
 =?us-ascii?Q?kkZ+9p3awVnR/AIaBxCCzBXSGX7PDYVscZCfjBuaQ5cNncGHohBxhxpembUG?=
 =?us-ascii?Q?9jylEL5Peny1lXQ9uBPcuVoQ0I3rsh7MCuk5r1M9xSYZ+yED9NXgLAVvGJhJ?=
 =?us-ascii?Q?sawIZTtt03bRbo+QOBIL8k4Hej+V77xJf51Zmx8GJo2nJ5McVzVaiXu5nF0r?=
 =?us-ascii?Q?9M14umh+BEaskhMGz6TPlVvVlGl9s3OVA/RgYPbYejulq8uDdTkfY9G4wxmt?=
 =?us-ascii?Q?AYNjLWVpl0fvROqs8Soy8SJiE8hp2hKS/ouvf+prWTMqk9kD4S6S2MxCdyWU?=
 =?us-ascii?Q?KCxt0Acmnl8PdDFdDV+IjFoM4cGyXa1yi2qnEus4RvtZxWoa0tbVrSZsUMx2?=
 =?us-ascii?Q?0LHGvZGmXwOBYysPInP8TRwTidja+o0LmW5VZrQolF3KJprzB2HJq20h6jyK?=
 =?us-ascii?Q?a+qtkXc2Um/ifupXQu8J16iIxRxIZIbB1GU2v3NiKv4f7nRdL6vrDgOqswRw?=
 =?us-ascii?Q?mt4GKp33Lf8/Oe3eCSFCEpXWN6cB178RKuLfJ3t9jQ7HGy94vU4xXlgtgwR3?=
 =?us-ascii?Q?d9KWOOAK4K06inmg4AzfrxLRnZwifTnSlbtzrcltzvKZ2YUAJ5sE8zL6RvxH?=
 =?us-ascii?Q?1byS53M2U9iGWeumZFmUBwy1R6q1lHvKIU/pmj0uWj5dHUWKDS+LBElliZKo?=
 =?us-ascii?Q?7jfTMEuTzIa4N1fRGcQgrwLE+r7E0ElQPeusYCFpSB1ZtzY453dPkXDzR+rS?=
 =?us-ascii?Q?PCFaY+qMZtWJs8wWy0U0sadzUQqdc2WfIBBn0YyhrlzIv2bTdFclahJrRs6K?=
 =?us-ascii?Q?6HZevqpY93RjBf6KAGgxiSS3YVCmZxH+j/dJ/LuAxsreCNuRjW00obcD7YXV?=
 =?us-ascii?Q?mll3SMxQ6hHce8mIX8z3znXMDdAIXfV57r7NSlwiFb9IfiNS91fBxL1Tht3m?=
 =?us-ascii?Q?QC2gklY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyHw3vT7zVUTKknIgeDzfCzHNx+ElXJZrLoE2whOcIAIRf+t6oD9aPrH0ph/?=
 =?us-ascii?Q?xTBP0G1PFC2VhT8MZS95v4M37F6UUYz41PmAThK4uZ71+tx0xt5+pYMccbdu?=
 =?us-ascii?Q?4oGr9NHHjoJ8bdqh7tgS9IrYUIt26iOCyRRsUga1BeJKaoU+C3JtDe7qFs1s?=
 =?us-ascii?Q?0JlxqAvh8dn3U4Ld6Q6l8DFQBPujNT5so7TOjZ7Fg5iZt+VxsT1S7xY2lSKP?=
 =?us-ascii?Q?uNZyKOjdSG6Z/DHG0p4nEi7KqMLWvYy3RCbFqjCF9wXTQArmc2mUjf2gf8DF?=
 =?us-ascii?Q?M6bBeVRXh5a7PV3Ti72QbxOembnapNSniHAAKXhd9ROlFKikI3JqYygU2yoy?=
 =?us-ascii?Q?7QxoMCxp8Qc1geII5jEfTk0JwxMknC0RaZA3vK+3JHhNo2cXxZg2rZA0uLuF?=
 =?us-ascii?Q?bhU/OR62NR03rNHy+41TPugxKFOO7UUprEWq9EPJQge2QroD2PCnzIZyvk6M?=
 =?us-ascii?Q?8agRFCXOOUoU2Xr0JXA7wrtcaFIDm6eqHkZg7ufalgABb5VtIIICv7Pfctw+?=
 =?us-ascii?Q?lkJfWyVfTlJgvJ7k1GfCzE4pvXKHa0kvtbUYGCkM697HpbZtDSvuoSQ7vndZ?=
 =?us-ascii?Q?opuBFob8TqQKR4WjV7arJyGgxiLp22uxAgYNq5KQJzHNYz5W1wsavtcPEYfy?=
 =?us-ascii?Q?AEBfiNZcL8mtiuMTNJPGR9BzPRpYXkBx+PuVemoJf8OQZdaPspAwHJd7ffto?=
 =?us-ascii?Q?Qv9Hwl1i9jGfmxngEExMDv+TbEPWKwuif+/uCdb9jI97MZycBSurLsqxgYgK?=
 =?us-ascii?Q?umItuJiPiEbOqgfNiIO3x2Rg8UD8HL/Oy4LkI7+MvfGAboa2ozUi6wGU2/Fm?=
 =?us-ascii?Q?WSZUrHS403YE1OHRb5zch739lz87mexsJrOu/l8uFdd+S+c5XCZpGGYH2SCS?=
 =?us-ascii?Q?Ekbdjxuv0aYg3sgsRmu1r5c5fKvojrmdsZVmvpY2JHPjSGNIGmgN8+T90PpG?=
 =?us-ascii?Q?zfi0f+tNj43lMkyzf8CWAvP+3EjOV7IOoobt4j7RIN/871N/bqPhYk/+GYMz?=
 =?us-ascii?Q?jLextTuiQeyujNUMiNjBUlB8OrTVqFV945+B7fHThaAVf0m3Qu2OccBvC0D1?=
 =?us-ascii?Q?H38IYMojq9xJDgMBA88+VBRZYa7nTvpxdOv1Y0vjYVrT650HU0wPjtE0nBZK?=
 =?us-ascii?Q?K2zNRHpmIBw9FQSBMGvlFRwUciOgwwWr8lFKUw90tXK5paUrUADey+57OI8s?=
 =?us-ascii?Q?hiMHNmMC1jvUuXMDXoZK5gbxIwWpTgG3Cq7zCgSP/2KkpiHA0/wZMKy1zUea?=
 =?us-ascii?Q?e0+OjrD/hhHzMytmBC6P6HOrkHwdwb1yNZoBb6t4TxoqJ1qBRbsgm6YdCoKr?=
 =?us-ascii?Q?zJEmOGDwTjj/tHXofR3IsjI+d2K0Dcj/6Lb+FAUOOFYVobEybzHPYx4nFb3f?=
 =?us-ascii?Q?pVaRtr6fNnKVJkG72vneJmgYrrLPVWIDnciH3QFDJyLTd6MRDejma1kPra7r?=
 =?us-ascii?Q?YqGDAyr6tC6ByTF15S8AY5UrtREm5PqiUrE1HHKlZ1USL6k4MHwNerbhSQy2?=
 =?us-ascii?Q?VZzYQ0IxZs5wIBwAhOV8WIMBKD0g0oqlbgihgYHnzmjkt6hupYaE7yskjxyz?=
 =?us-ascii?Q?wV81EXCYzyXZdinTM11JZLJLHwy565HhXvm0GC7w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc49473-d631-45d6-c05c-08dcc125e52e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:39:28.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6paQVgccKj+toUu7WmsGXMyGm3B+1KC9YIs6Tix+7/iUcjxWLJAFRr4xfXUDRDWSrcntwgHFUkf28qh9vd5u+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7910

Add child node 'port' to allow connect to usb controller to do role-switch
if id pin of ptn5150 have not connected to chip's usb ID function pin.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- remove extra empty line
- fix Indentation in example
Change from v2 to v3
- only add port to existed example.
Change from v1 to v2
- add example for id pin have not connect to main chip's id example.
- commit 095b96b2b fix "port" warning, but add new warning "connector" is
not exist. And follow commit revert this change.
690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
- I have not board in hand to debug why "connector" is not work.
---
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index d5cfa32ea52dd..072b3c0c5fd03 100644
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
@@ -58,5 +63,11 @@ examples:
             interrupt-parent = <&msmgpio>;
             interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
             vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&usb1_drd_sw>;
+                };
+            };
         };
     };
-- 
2.34.1



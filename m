Return-Path: <linux-kernel+bounces-204680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B078FF243
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930421F26AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3734198E7E;
	Thu,  6 Jun 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONcTPmZq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2088.outbound.protection.outlook.com [40.107.6.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C91957F2;
	Thu,  6 Jun 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690532; cv=fail; b=szetdyJXWN4yeS/kTz1bsVkoMH1CGGBNm/qaEm1U1BLCAFzcx1bUqVFSSHbR11kapq8x4hxIpr7w6Cg17Qh6H5FUQAe1uxG/cHP3OU/6MNpTnMGj7kHlbCvMZaqpO67OYoqSznQXFkQXaLrCRs0mxFT0/6Q65akS6o65jgkDThw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690532; c=relaxed/simple;
	bh=e5HiZAdyuAMAqAqKBMosRkPt7zxPjDxLe0FECa7PRTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZoGx7zBLZm8UCWWK4qc5Uj9WfMSld0aiVNMhaaaFjZzTeJec3ASyEKjbw56jZV9Y3c1jm6UjhGQ6+NIzX46ADbvxru22j1ilycuLQZL2k2xsXnO04auLnsNR72bBExb6TuvO3jG4V4URWXmLW2uxwbV9+ZX8MIxp7DZ6sHxhwVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONcTPmZq; arc=fail smtp.client-ip=40.107.6.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd4pEyP1QD83A9RxHbEHey7HxrJOdc2CvheYzOtwSnGjOtULpK9gRxoWSmmx6y4J+N+3JUopgqpe3sTUWkPsNrUCaMnvhpbgD0T/RrZez1vpKnrcssYZP4Cyk1bES0r49gPzAoGxVxCO/Z1LSIzaFrAd0d6JngVH0FX0t+QTSkFR5C408Ava17lWWPfCoci6x86Vr2ObNgc5ebtQYge6LsF79DhoA3SWokRj5xcfDOc7g0gOmnHq/dPFfqGTqBw4m44kANMgfw0ju9QMnPIavNGGXOx/7MuEp7b4fQ/ewgOvL5Uy7IXBn1PrixS+5JSseJOmu7SnaMyxjemlColt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIabDmCnSVeAXKxuY1kwmP0WgyX2qDFg9qZBQkTWegU=;
 b=gEX3uXLyUv3zl4G40yHPdMEUz3P8IZX2mb+YVyWrnWsXL2JseZtgaAi3fA0TefyaZBqxcuWEKJjCnpec0BSc+o4/yFqUPGYc/I2Y9ZUBOkQwg2j3E40Q7X0f6ZvwIxroqvo0wxkO71v4lmpBN61HZRgKA40hnFdXKpHugS4aIgpcr2Ssm8BB7uUkSqCPXS+DaOoVHe4A9Gks8vXkdBymshaeqX/ZE/fondwnOGl+EvwPDzyC3rr6BDXaYsFNvkQXYe+2lXlQS3l2CM5u+lfOHP90miwshwj2mEASpb20QJzRtJPuJO/lEitKjfm0eTOqHCLlzIjA6nsM1coII+d9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIabDmCnSVeAXKxuY1kwmP0WgyX2qDFg9qZBQkTWegU=;
 b=ONcTPmZq6WLa/EF1HMnQUw2nqB9/qxp5JveMRS6GFtBisIJNPf3vmeCKSjAWo4EYZ3tlSnPDxj/N2g+g5EbFQ9CEWNzJb5fDc5Un381lKSO2vtfzq4oSeqGTvL5Ynul7iHlr9oPY3JyghDbv24ATuZTWWAy2p0PTgoObO01rp1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:15:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 16:15:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: usb: cdns,usb3: use common usb-drd yaml
Date: Thu,  6 Jun 2024 12:15:09 -0400
Message-Id: <20240606161509.3201080-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d65587-f279-4a2c-9a63-08dc8643df5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|52116005|1800799015|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NkINoUrRyJofGq6nFuzcJ0oBTNtxW4JDth5RNga74lcrFJ4aNOuRmy+fzxV3?=
 =?us-ascii?Q?RU2nuUx4V7G+RYRrrZTNG2FbG6y8hg/Yj2YFb1AnlURa3EH84SbQKaBdZt0S?=
 =?us-ascii?Q?INEsOrVgj6QMuvPId1hlnHLh7prPtjEFiz/Q2ic8fqsEF8AmABnTy4d+p7QT?=
 =?us-ascii?Q?1wUqeFqsdXyVX9kf35AcT2D5qimM5juTQKhCRG5A0Ven1EjTrASw89bazgid?=
 =?us-ascii?Q?ta8OFX5hfbNDbGVuSeNvhK3P9tQ5sLrWOKRmFh1hTArMu4uqk3n8JyZz8H5k?=
 =?us-ascii?Q?UGY0kkDeKl7pwPkjFlo5RsTe1tp3cRdtgdoP3cNu9nQqhjYFSVSyHQqjTGh6?=
 =?us-ascii?Q?5tWqmtUY99buovYO4OCjThbC5AopvVkhR/zwtIGPe6Php+YzZAz9JBXzFs6Y?=
 =?us-ascii?Q?XYv449D1OALBCIo6JCIP432Iz/WiqY0DQ7S2RTvXPxX/I5r1WUIat9OcRS2O?=
 =?us-ascii?Q?o5jXuaRRH0hSjy7X7AQBAqXZNPzKzeObOaadp/RZTbXPia6IGs9yl1CJU5ad?=
 =?us-ascii?Q?IdYI9lApw84cO0ZUH/HD5LDPdXAt/ogjQ3giTkhQQxgPWvHOR2c/KMmVPsb4?=
 =?us-ascii?Q?v1UmsnG2aPAgC3fi6r8Au6jrwraUdayi6pzp32v3f85guVrgiyCqIWl6RNGS?=
 =?us-ascii?Q?pFKNYu7L3CbL/Drs4d9WXGmUMmMimRZwiWgWXJTaeKoGLcefuIZZ33vzaKsD?=
 =?us-ascii?Q?8DAr8+gIxhdmrE9U7pW8z50tJSh1WvZ7ybQ2DiMDsvAhjd+98UmPJi1RZ/oO?=
 =?us-ascii?Q?O0ODWilxDi/hprE4f+Bogq+Z2WhNfeIhoWWJHorEKe6LjwOUbXiabjElT1Id?=
 =?us-ascii?Q?9V7V5EvwdbculP1S+BVFvzWn6mZLwC9Wo/G+N63k4/Qn6z0Ej+cG3Lyw8fLT?=
 =?us-ascii?Q?qirrnm7T+hRoJwEdCs3Pny6mm2T0r2ZXAp+29CZV2uI90X5pRJgCvL0pcCkL?=
 =?us-ascii?Q?yTzoxShZ4xvq21OR4hDVcj9EoctWmn35m6G4yK12mVff2FPoxQX3Z1EUdf83?=
 =?us-ascii?Q?Tk5rIspz73NaBtyAr/SfDahj33D069y9khnWkeotDvI+VpzPNavf+r94lACR?=
 =?us-ascii?Q?T7HJxqojw73Vv034GsC04ClJQ8URxyvh3qWeGQ5fDPLe+KaNMqJUVTDpiWPg?=
 =?us-ascii?Q?aR9x4V2g6CPw1gEJCB1bMDNCa5g3l4n5Kwa10+Fsns8tFM+fQ93ITUW1vlYk?=
 =?us-ascii?Q?GatJsv9D6+RUGJSstWMzsfUWtSQxh1SWJcmPmv2+x7+ciBkeI5Q7DenbJd/L?=
 =?us-ascii?Q?FawqbYpJw1/XKxU5YNyhxWrxqBoZD+QqGN1CoLZGOvKY4PQA0mlFJ0WhMSQk?=
 =?us-ascii?Q?cleED4uUp1ZczuO2+ua/6E+nYuvXQ28OgFuE4LyR1RKc5JgLfcxgP+yinera?=
 =?us-ascii?Q?VB/HeWrhpjl/Ta++7AkAnh8wAQIC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(1800799015)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7eB93mmlxNu5yUQBdBEj9Aya29JWear11phPnZB6zugokoXvIQmVyLvLCQR?=
 =?us-ascii?Q?D85zt6Sd+dKcSZajPCGCaambcvkr9Ey4YTmltEGmUEp9DFaQyUB65b4mmejv?=
 =?us-ascii?Q?ty3fwqJPfo5GZc4pBzoUXAjqHAl7wN9XpWbsu5aXsXTbVweKMr998JUmkWdB?=
 =?us-ascii?Q?gqj1HXhhVNJTsfdI3kNbUa38Yn5DpHrqACFamNfE7UsY1W1UR1ujSual2n5z?=
 =?us-ascii?Q?OxVy/Zran/sOOO2ad3LOmie0m0bvtMvyqE9GRZ0c5VBGZkyYtFCaCemLK7WB?=
 =?us-ascii?Q?aNy8rlzO/WOhk+PH5VmQJM+QrsUw9XuJV7VRDi6AEjfLXpXCVhBzwROyOv+5?=
 =?us-ascii?Q?cH1xQfTmyDDPd5MXj7XzLh8ng4QgXWpEhQCpaf+89O4ITvm4TRnaeRsDN37E?=
 =?us-ascii?Q?G32cgBMpJAxZ64uoeNj+EG0JZGjp4Qt0v43whzYPrnKOP/Cj4IGutBMWHPkH?=
 =?us-ascii?Q?kmS1mOitNZbb3XZ/pLeVJo9Y/L5PoYQ0upniw459cEtQxfIy1P3U3gNXzAQJ?=
 =?us-ascii?Q?qmzpbKr9ko43ZnAQUDIhuL0R+W6hcNHtpsP939IrDHTwbF/qH3cx2mrCsP/z?=
 =?us-ascii?Q?G2bWLUSfuaLSDDleW/GHWETQGuTfT1U+68tdEpdTYLjYj1djMaC2uFHt6q3L?=
 =?us-ascii?Q?GbHhSmyBRA0PCxVGXr8kBDbmi3qBeQBZDqmQjl79SD+TbcmFGa5oYYgfD3WA?=
 =?us-ascii?Q?9AW9ZuGuPIwD/ZHDKgRusD10JjPteBh/Tr6wTqR0clV+2NvrfC1HUH1lY9qq?=
 =?us-ascii?Q?0cOKcxbvYQgfJGkKQMeKBp2ulEVgXS+tAqnzeBzl8G2xVhVv/BDxmHxQM6bs?=
 =?us-ascii?Q?Gn1laVhoy/oPg1Xr0vo+bFGvR8c5qf7r9UJggCulPxblbaVRKyZt4JE199SD?=
 =?us-ascii?Q?KP4jolY1C9pFeQHduV6sSQk8ihjAgEyLBOWI/hqnbwtgWkCShOQds0vO5OAi?=
 =?us-ascii?Q?M8M7iN9TsttkjslmpzUeVzcQGGhklh+7hQCcax7CFDMaWdvsEKuvNkdRzuDx?=
 =?us-ascii?Q?RuhKDLUUYue2452HFiDQkPfKAEaivOtXv0f+ZbRqmQrxvv7J13eXW4/DOJqj?=
 =?us-ascii?Q?RPCp9Fh30NhCT/mGVBy8aK6+6FMdSPpZesBByXSVByF1iir3hfI0d7Up/+nh?=
 =?us-ascii?Q?PFZRbYLPS00d04rnVQ2m8uIL8M25I0HuoT8A0ytNbztFLBSHgVp+q6N0cV6M?=
 =?us-ascii?Q?FsfOcvtW2TXOPaj8E+D0PMZmakl5gA0/ZjmUXQQ92zpIm4VWa2gqeFbR2v9u?=
 =?us-ascii?Q?p9vDg7Pq2VaW72G7uiCLO+rDLtqJs7vIySwQSbSQp1kmvDHXk8azEJnrv1s5?=
 =?us-ascii?Q?5LVHhpmSEYfjNWjPMvI6BSv9q8iecnuzIl/Bc9FJ3/Dm9abPz+FxRrQvkeQF?=
 =?us-ascii?Q?hLDQioFoaJKouxqyu4V8Uhbf6IaY84km8t/Xa2B1Xgup7BUg4lrYFLcsSFGj?=
 =?us-ascii?Q?XmMmN2P6+hU3qtulmoh+3igAmMWWaFuXvEbBCR4JVnwNGbY+sRcrIQBqprYL?=
 =?us-ascii?Q?5uTtnhCk1xHPdYgSDDnkF5gtBVVa4xMKJmlkTLs16RVr+gwKPI/5jgHAsuhD?=
 =?us-ascii?Q?nS4cwr5lFp14sDtcsqU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d65587-f279-4a2c-9a63-08dc8643df5d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:15:24.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Weo6hN8q6nUfF/4HWVm3Z6YonBC2/6cvhzvHHtSS+Y3HxkbycWaTlaTi2FioL0fuOige62jQHdFYNue7DImTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034

Use common usb-drd yaml for usb OTG related propteries. Allow propertry
"usb-role-switch" to fix below DTB_CHECK warning.

arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: 'port', 'usb-role-switch' do not match any of the regexes: 'pinctrl-[0-9]+'

Add "port" proptery to use connect type C connector and fix below warning.
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usb@5b110000: usb@5b120000: Unevaluated properties are not allowed ('port' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    pass dt_binding_check
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=cdns,usb3.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/usb/cdns,usb3.example.dts
      DTC_CHK Documentation/devicetree/bindings/usb/cdns,usb3.example.dtb

 .../devicetree/bindings/usb/cdns,usb3.yaml       | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index 69a93a0722f07..38df19bad7c41 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -42,8 +42,15 @@ properties:
       - const: otg
       - const: wakeup
 
-  dr_mode:
-    enum: [host, otg, peripheral]
+  dr_mode: true
+
+  usb-role-switch: true
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      This port is used with the 'usb-role-switch' property  to connect the
+      cdns3 to type C connector.
 
   maximum-speed:
     enum: [super-speed, high-speed, full-speed]
@@ -77,7 +84,10 @@ required:
   - interrupts
   - interrupt-names
 
-additionalProperties: false
+allOf:
+  - $ref: usb-drd.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1



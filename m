Return-Path: <linux-kernel+bounces-218115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00B90B97A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1D7289086
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36218EFEA;
	Mon, 17 Jun 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ayuXjJOH"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0E194094;
	Mon, 17 Jun 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648072; cv=fail; b=A2KmIOmZaRRAJWxUak836VFDESPeoznwI8piWnAGb7okIYurnUIQPkUoNisO6wcZZniG+f4jt4EY800775gIIcNohSdR66ugRFA3i0C95RPpkBbcaNKRqNCfZJQIZPvlLU9hPj2cUiFM3U8SrYoXJWwSCKuNqyqgOc6NaFjtfKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648072; c=relaxed/simple;
	bh=H+aHSUzbpRS4U+KoI38qAZJXF80R9PFNBX5Pq9f16p8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OoVgVyutUmD9xMCCTZAgr+Wh3itEcodM16cKNCmgbWuVFxAZ5t7WsHGNmI+hiXfdSJcebotUlC88qKw/Nmo/JXjS5C/k7li4cCsfIbdM+cY25fYU9ytSoBKxV+djBRDE7sBvOtttz1IUbSz4IzIjGWJJ0540BQ1jHtDBzsJJTY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ayuXjJOH; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWLhlZtm1o22LVfk2wcXnct6lk7YDHK8EasXCeTnGmyFd50zjNP+eQQeYXs8ldukn/6EcQQwQPUYCg9hRI8W7arTzgLk6U4yCMzC0q9/X4064fajD/d/oKtBqeGx718j24cZ/i6Q+nYHYKGPqPM2ohpMjvQQcuAqry8PlFYyb0nb9chb8qyKUrDEEWEkJdcCDb/bM/ocYlPOOKWlFLy788JuR6YSzjFxtEx92365frqQFj6ujqfEJe2qND+pFyaBKGy995TC4/VKqxbC9lyTYShXNLm8ejS82s8yndc5VLwSyv8JJ2C87nfOtronTbF3FDWWwz1L2Sk+KKQMyhPAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dINiiACI9aH8Z7Ebxj6ToYvFW57CtN+hV8eiaNHoh4k=;
 b=eszISDC9G2bnADnxDm4SieSY6VKuPN4Uyw/d6Z9Uux5EzBaMr0hUKI2VZPoxG9o4HFnytc1d34FJTjGKnkz/EEZfK4aCr+uS/9nbkBwJn/mZ/x/FbMhnDsrXyoJUqXbOhf7eSehkIoAPRcLjlMrsiWzXPGbpPOY/5RmS7Vh7r8hE+FgfgEu7WZ1LsfxIwfAYU++2l7Tywj83nPh7cR9lRrgSKBs6jMrrBW8CxkhwEVPoQ8Kgm6c0ZK2+K0VOc+CfdbcNeHXrbvA3DI4I1KCEZ0STlOQ1vYapJRNt/VgHaV3NL8za0LETKoL+eOwsV6lyx2pyMvBJSSOtbwd/w9O0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dINiiACI9aH8Z7Ebxj6ToYvFW57CtN+hV8eiaNHoh4k=;
 b=ayuXjJOHUiEwvweO1nqpN6xn+VaFk+3VFOTsKuqr+EOmZqljMdeFvQuYndIHB6siJ1nNBW2qjgz+tivNnXYAbY9FdHNlvOI5XtwAvbf3M9kvy44yWNSFIMJ8H4wQwpnQnstX6ARUoyKuuHIor9gFbvZzJgII/EnaluyyJNZwfWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 18:14:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 18:14:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: clock: qoriq-clock: convert to yaml format
Date: Mon, 17 Jun 2024 14:14:09 -0400
Message-Id: <20240617181410.921090-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 379b6d2f-8d95-48a4-2af7-08dc8ef95277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rW76Tv+f6ipw0frVfPm3h7ck+ir8tHTOYSqeWqW4y0hDFecry7FUhRoQ+G5P?=
 =?us-ascii?Q?FsOz9zQajnCuZDrCCe7aMVR7lLrHOD1r1fmJFPcnNDJRhoT7OzdEKIojcClw?=
 =?us-ascii?Q?Rb9YS+m2QuOYtKLBgL/yPJMyV5fCo6DPVK930vZ2FW8bnXOPZ4zod6+YlsE5?=
 =?us-ascii?Q?/dssSGl81aaOiQJX/IFVeHrIJZiaobYTdUH4jf+szkLFf3BlIj0/zy3Jz0+z?=
 =?us-ascii?Q?AjLNHB7CCjr+pvLfaOrJkHOUQ4QnQneXHXFyPhGQrRIyjU+WOVcRWZ+i52rW?=
 =?us-ascii?Q?1pLZ01VHesEQq9hNy7D68S4zB8pIge12VzygqgmDx4+MuB0X9JMoECp1+i4+?=
 =?us-ascii?Q?PcDfyg0bSWnMt5EPr5JsvW6hvYe7a+PC0hutckPv95QVRSYW4mleYnZ4sL5R?=
 =?us-ascii?Q?DpGKAQRE3m7xyonlSxOQCebbRPuK1UDZ7Wx30nETKxTHwwIZntUWYpYH6DBK?=
 =?us-ascii?Q?qGG9VcP7/87/sZDIK7wvQg2ClwdecFmjnvPT3sK0LudM93rQcGIRl4uB1WCV?=
 =?us-ascii?Q?1KyJjR1dY/vEO6sWhGsXdTjRmjGZ3lYsjuETL8dG94k6z2Y1eDbCRG0vJCly?=
 =?us-ascii?Q?0Hq7FHRrg1DqnOkpi4v7izJ3zoluOiBdVtDGd7UI1yltF+k3J3YoI/uhC32f?=
 =?us-ascii?Q?I8GEVQdttfbYwPXbluxvtU2y91FT41H0/QJJUH5NFoZh6Xgq67/IVO7Pf/V6?=
 =?us-ascii?Q?3gS/icp6v7mZzqBPzTHVA8gZblCWpektFULuhO6zKSTina83kf9IrFLsvpLp?=
 =?us-ascii?Q?JHA2321fcYN+wlSEVA6oO6Uf3fQLqxMLLw7DhxbLp10L/Ca5I0dpZ2GzGB5f?=
 =?us-ascii?Q?zkiaZsZzEzLmP1Jxml+9dgUPZ63RjwDRZgg6O2zbW3AhaaYAwhy22lQ2EmT/?=
 =?us-ascii?Q?iOVtlRY3qrhtV+v7x19Sh+GNpZECGody1J3htwcIQyBRhKNtJy15fX7dTkDu?=
 =?us-ascii?Q?wNKmPbWs8vsVA6I93PbORBnJDyAJ297iQjlBSf0sQ4Yqw31l8e5CoxiLbsGS?=
 =?us-ascii?Q?Y53JgduGNyzXl4+LosEtPhpjq550O/0Ufz2npKkmD7EJFclYBi2yMIC2ffTW?=
 =?us-ascii?Q?IY+G9JcL8q7vllSeo4g82RKLjWtfoV7/L3tnV0vg2wNUUD4ctIMnmTj0ooeh?=
 =?us-ascii?Q?bQwYe7O/F98DXRPhn1GeMdWC5WhZHbGLlu22vKt4glzO2Mqu72PnCfC7q+rp?=
 =?us-ascii?Q?3nKp+mkjbZ7Qh6rilhgNL4DpIzajPfyquWGKuERuBZzDoXuBRdUeRVb2tPQc?=
 =?us-ascii?Q?HAzxgx/0Pj8S4epoXJM+u1AN1yTQPprQxTo6QILuQEQYy89M1NIQhctEC+FG?=
 =?us-ascii?Q?0xzhIbEec5+V9Nwyx70zej5U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+K38Eg4HVcYnmJKLF7OO/AvLoEM2OmsJj0FZjuBjgqXF+QOSlaB4vrMLSuH?=
 =?us-ascii?Q?en5RmpBzuaBS7batqFuKHPMfjKnsMHfzof1y3Er0tu2+31ZobxliBoZfH1B8?=
 =?us-ascii?Q?CpVuFKZNRL7ab9q/JLAQdaVnpmWSGOiBVHRvQ9DNIhz0TW2mUrWYEyKrebd1?=
 =?us-ascii?Q?PW2mLieT2ulaccAQSkiSCEhYS+BpGH1m2VdUc4yoHuMYYz2nSrL9n60DHOn0?=
 =?us-ascii?Q?VeM+1JgPz5KEUERoqD1vTJsxMa+rvRiFVI4l6cRI+nNYWUi08mpVf1zfj1+B?=
 =?us-ascii?Q?hD/lgFVOo7RlfERaio631xfgS/Lv+QA5kSkcBQgapn+yVgRibmHsiVtRgjzP?=
 =?us-ascii?Q?Lr0YO17W88wteS7b3b/KEkQxKgTMQU1kFdsJuboOl/gIIw8mA/uDvUFvNnRL?=
 =?us-ascii?Q?H7ormCbtcqauuS5msfUWdQTYfxyjGqAfqNUw3Cx1+gLVzGMrIRcYpizq88FU?=
 =?us-ascii?Q?yQvlS43IAgoA4LdpWE74nkUFYcJp1pq4Yo4fbedzzelKAV/kRvA6ZtPmMXs8?=
 =?us-ascii?Q?p78xGG/xhH/eqB9B9TQYZkBoOOY4g76AmTdB5uGW9MP73oHNUgVhJi2nm6PE?=
 =?us-ascii?Q?OvfI1cW+3Zeb2cVv+mXKp+Cv7+T7RQayCI62tY9T711txFb7dZJEQjAA0B+M?=
 =?us-ascii?Q?4p33jljkIAmqyH/W1tvlAgQxGwlSiOKbzHinZtaAhCQf1iDgxMc9CPzQ6XKk?=
 =?us-ascii?Q?4Sd9nxF3ZM42D4o/GLttGefAeFdYLEnDGVcy42Vxlpv63IJXq37IuyjqHgDN?=
 =?us-ascii?Q?sUBx5t6moGYhTjRXbAOnMEJu9FhLWZVGGJ/y9avsIGMTdtnip0+ZtGD4Apef?=
 =?us-ascii?Q?QNVhIcxRmsV3CK0wzTliHqs1TXYWjdVc1xfs8aixjayNCXIAXrK829XMvNQZ?=
 =?us-ascii?Q?6RI50XdF88bqNtAeXQHCWpo6gIncPYsBUHuZKNxjzLlKUn9EvJ9B6MW1+OZl?=
 =?us-ascii?Q?BhqXQBavp9mkVce35qCKQ8eCkJY/0TybXmrd4MCwFJhQWfw6kEn1LGg0sVCy?=
 =?us-ascii?Q?Bx2pj4r4COwZE52Zd3VepND9RktBWRifr10/bUsgd0wbsdxSOPBmzcINhhjo?=
 =?us-ascii?Q?w46IYDrWCnF7XSm32Kn9ovnmE7eqsZjCa0mPTau4NxtXxJYPmylqBn30M/lC?=
 =?us-ascii?Q?HyQlvua0X4wknYNq9yltKlh7dbnJeYv6i2epRHey4LhjX8P/2fuRnAMTyz/p?=
 =?us-ascii?Q?kBfOW6O/0KI0AqXxg7INDtxflpnJQS5UjmUlIX3AJLVwLhy4itApPHuMNPiy?=
 =?us-ascii?Q?8CwQS3GM/Z3v3odhixTvDtsaOXTUAcM19iX1bZ0WJVLh9g9DiMs7VgPCKT2r?=
 =?us-ascii?Q?WHE0+QFOA3UrAPa/A9VDT9BRMhgUDIf1kSXjBzdkHTnIfKd3kDh1EtnmhepJ?=
 =?us-ascii?Q?fhpwAAH3SK85BFBuw08J7caxhhhwV2CkiMn+41kg+wwC4OP2XFs70i8gJUkI?=
 =?us-ascii?Q?VVnyMiAevZAM0tYkmPG5N4UEM/Ab8XPEk/mP5VtwLK8o3U0qDAPOuMWFUBcI?=
 =?us-ascii?Q?vx18hfWGe8TC/MirVaOmupgINloQ1Yby0eAnP/8sPnLNDqOhroEm39ltrEne?=
 =?us-ascii?Q?5s2l5YQDLbr1IALOdps=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379b6d2f-8d95-48a4-2af7-08dc8ef95277
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 18:14:26.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHJ/00Z3BdJj1IeScMES4CobCyunQLuAYYVRSiByoWBOGXJYOlA3teqUB3IYifTpIyrusjwu9wIU92Nj2HPHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022

Convert qoria-clock DT binding to yaml format. Split to two files
qoriq-clock.yaml and qoriq-clock-legancy.yaml.

Addtional change:
- Remove clock consumer part in example
- Fixed example dts error
- Deprecated legancy node

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../clock/fsl,qoriq-clock-legacy.yaml         |  84 +++++++
 .../bindings/clock/fsl,qoriq-clock.yaml       | 203 +++++++++++++++++
 .../devicetree/bindings/clock/qoriq-clock.txt | 212 ------------------
 3 files changed, 287 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qoriq-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
new file mode 100644
index 0000000000000..97b96a1a58254
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock-legacy.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock-legacy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Legacy Clock Block on Freescale QorIQ Platforms
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  These nodes are deprecated.  Kernels should continue to support
+  device trees with these nodes, but new device trees should not use them.
+
+  Most of the bindings are from the common clock binding[1].
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    enum:
+      - fsl,qoriq-core-pll-1.0
+      - fsl,qoriq-core-pll-2.0
+      - fsl,qoriq-core-mux-1.0
+      - fsl,qoriq-core-mux-2.0
+      - fsl,qoriq-sysclk-1.0
+      - fsl,qoriq-sysclk-2.0
+      - fsl,qoriq-platform-pll-1.0
+      - fsl,qoriq-platform-pll-2.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+
+  clock-output-names:
+    minItems: 1
+    maxItems: 8
+
+  '#clock-cells':
+    minimum: 0
+    maximum: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,qoriq-sysclk-1.0
+              - fsl,qoriq-sysclk-2.0
+    then:
+      properties:
+        '#clock-cells':
+          const: 0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,qoriq-core-pll-1.0
+              - fsl,qoriq-core-pll-2.0
+    then:
+      properties:
+        '#clock-cells':
+          const: 1
+          description: |
+            * 0 - equal to the PLL frequency
+            * 1 - equal to the PLL frequency divided by 2
+            * 2 - equal to the PLL frequency divided by 4
+
diff --git a/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
new file mode 100644
index 0000000000000..d641756b04635
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,qoriq-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock Block on Freescale QorIQ Platforms
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+
+description: |
+
+  Freescale QorIQ chips take primary clocking input from the external
+  SYSCLK signal. The SYSCLK input (frequency) is multiplied using
+  multiple phase locked loops (PLL) to create a variety of frequencies
+  which can then be passed to a variety of internal logic, including
+  cores and peripheral IP blocks.
+  Please refer to the Reference Manual for details.
+
+  All references to "1.0" and "2.0" refer to the QorIQ chassis version to
+  which the chip complies.
+
+  Chassis Version    Example Chips
+  ---------------    -------------
+       1.0      p4080, p5020, p5040
+       2.0      t4240, b4860
+
+  Clock Provider
+
+  The clockgen node should act as a clock provider, though in older device
+  trees the children of the clockgen node are the clock providers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,p2041-clockgen
+          - fsl,p3041-clockgen
+          - fsl,p4080-clockgen
+          - fsl,p5020-clockgen
+          - fsl,p5040-clockgen
+          - fsl,t1023-clockgen
+          - fsl,t1024-clockgen
+          - fsl,t1040-clockgen
+          - fsl,t1042-clockgen
+          - fsl,t2080-clockgen
+          - fsl,t2081-clockgen
+          - fsl,t4240-clockgen
+          - fsl,b4420-clockgen
+          - fsl,b4860-clockgen
+          - fsl,ls1012a-clockgen
+          - fsl,ls1021a-clockgen
+          - fsl,ls1028a-clockgen
+          - fsl,ls1043a-clockgen
+          - fsl,ls1046a-clockgen
+          - fsl,ls1088a-clockgen
+          - fsl,ls2080a-clockgen
+          - fsl,lx2160a-clockgen
+      - enum:
+          - fsl,qoriq-clockgen-1.0
+          - fsl,qoriq-clockgen-2.0
+    minItems: 1
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 2
+    description: |
+      The first cell of the clock specifier is the clock type, and the
+      second cell is the clock index for the specified type.
+
+        Type#  Name       Index Cell
+        0  sysclk          must be 0
+        1  cmux            index (n in CLKCnCSR)
+        2  hwaccel         index (n in CLKCGnHWACSR)
+        3  fman            0 for fm1, 1 for fm2
+        4  platform pll    n=pll/(n+1). For example, when n=1,
+                          that means output_freq=PLL_freq/2.
+        5  coreclk         must be 0
+
+  clock-frequency:
+    description: Input system clock frequency (SYSCLK)
+
+  clocks:
+    items:
+      - description:
+          sysclk may be provided as an input clock.  Either clock-frequency
+          or clocks must be provided.
+      - description:
+          A second input clock, called "coreclk", may be provided if
+          core PLLs are based on a different input clock from the
+          platform PLL.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: sysclk
+      - const: coreclk
+
+patternProperties:
+  '^mux[0-9]@[a-f0-9]+$':
+    deprecated: true
+    $ref: fsl,qoriq-clock-legacy.yaml
+
+  '^sysclk+$':
+    deprecated: true
+    $ref: fsl,qoriq-clock-legacy.yaml
+
+  '^pll[0-9]@[a-f0-9]+$':
+    deprecated: true
+    $ref: fsl,qoriq-clock-legacy.yaml
+
+  '^platform\-pll@[a-f0-9]+$':
+    deprecated: true
+    $ref: fsl,qoriq-clock-legacy.yaml
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    /* clock provider example */
+    global-utilities@e1000 {
+        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+        reg = <0xe1000 0x1000>;
+        clock-frequency = <133333333>;
+        #clock-cells = <2>;
+    };
+
+  - |
+    /* Legacy example */
+    global-utilities@e1000 {
+        compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
+        reg = <0xe1000 0x1000>;
+        ranges = <0x0 0xe1000 0x1000>;
+        clock-frequency = <133333333>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #clock-cells = <2>;
+
+        sysclk: sysclk {
+            compatible = "fsl,qoriq-sysclk-1.0";
+            clock-output-names = "sysclk";
+            #clock-cells = <0>;
+        };
+
+        pll0: pll0@800 {
+            compatible = "fsl,qoriq-core-pll-1.0";
+            reg = <0x800 0x4>;
+            #clock-cells = <1>;
+            clocks = <&sysclk>;
+            clock-output-names = "pll0", "pll0-div2";
+        };
+
+        pll1: pll1@820 {
+            compatible = "fsl,qoriq-core-pll-1.0";
+            reg = <0x820 0x4>;
+            #clock-cells = <1>;
+            clocks = <&sysclk>;
+            clock-output-names = "pll1", "pll1-div2";
+        };
+
+        mux0: mux0@0 {
+            compatible = "fsl,qoriq-core-mux-1.0";
+            reg = <0x0 0x4>;
+            #clock-cells = <0>;
+            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+            clock-output-names = "cmux0";
+        };
+
+        mux1: mux1@20 {
+            compatible = "fsl,qoriq-core-mux-1.0";
+            reg = <0x20 0x4>;
+            #clock-cells = <0>;
+            clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
+            clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
+            clock-output-names = "cmux1";
+        };
+
+        platform-pll@c00 {
+            #clock-cells = <1>;
+            reg = <0xc00 0x4>;
+            compatible = "fsl,qoriq-platform-pll-1.0";
+            clocks = <&sysclk>;
+            clock-output-names = "platform-pll", "platform-pll-div2";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
deleted file mode 100644
index 10119d9ef4b11..0000000000000
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ /dev/null
@@ -1,212 +0,0 @@
-* Clock Block on Freescale QorIQ Platforms
-
-Freescale QorIQ chips take primary clocking input from the external
-SYSCLK signal. The SYSCLK input (frequency) is multiplied using
-multiple phase locked loops (PLL) to create a variety of frequencies
-which can then be passed to a variety of internal logic, including
-cores and peripheral IP blocks.
-Please refer to the Reference Manual for details.
-
-All references to "1.0" and "2.0" refer to the QorIQ chassis version to
-which the chip complies.
-
-Chassis Version		Example Chips
----------------		-------------
-1.0			p4080, p5020, p5040
-2.0			t4240, b4860
-
-1. Clock Block Binding
-
-Required properties:
-- compatible: Should contain a chip-specific clock block compatible
-	string and (if applicable) may contain a chassis-version clock
-	compatible string.
-
-	Chip-specific strings are of the form "fsl,<chip>-clockgen", such as:
-	* "fsl,p2041-clockgen"
-	* "fsl,p3041-clockgen"
-	* "fsl,p4080-clockgen"
-	* "fsl,p5020-clockgen"
-	* "fsl,p5040-clockgen"
-	* "fsl,t1023-clockgen"
-	* "fsl,t1024-clockgen"
-	* "fsl,t1040-clockgen"
-	* "fsl,t1042-clockgen"
-	* "fsl,t2080-clockgen"
-	* "fsl,t2081-clockgen"
-	* "fsl,t4240-clockgen"
-	* "fsl,b4420-clockgen"
-	* "fsl,b4860-clockgen"
-	* "fsl,ls1012a-clockgen"
-	* "fsl,ls1021a-clockgen"
-	* "fsl,ls1028a-clockgen"
-	* "fsl,ls1043a-clockgen"
-	* "fsl,ls1046a-clockgen"
-	* "fsl,ls1088a-clockgen"
-	* "fsl,ls2080a-clockgen"
-	* "fsl,lx2160a-clockgen"
-	Chassis-version clock strings include:
-	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
-	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
-- reg: Describes the address of the device's resources within the
-	address space defined by its parent bus, and resource zero
-	represents the clock register set
-
-Optional properties:
-- ranges: Allows valid translation between child's address space and
-	parent's. Must be present if the device has sub-nodes.
-- #address-cells: Specifies the number of cells used to represent
-	physical base addresses.  Must be present if the device has
-	sub-nodes and set to 1 if present
-- #size-cells: Specifies the number of cells used to represent
-	the size of an address. Must be present if the device has
-	sub-nodes and set to 1 if present
-- clock-frequency: Input system clock frequency (SYSCLK)
-- clocks: If clock-frequency is not specified, sysclk may be provided
-	as an input clock.  Either clock-frequency or clocks must be
-	provided.
-	A second input clock, called "coreclk", may be provided if
-	core PLLs are based on a different input clock from the
-	platform PLL.
-- clock-names: Required if a coreclk is present.  Valid names are
-	"sysclk" and "coreclk".
-
-2. Clock Provider
-
-The clockgen node should act as a clock provider, though in older device
-trees the children of the clockgen node are the clock providers.
-
-When the clockgen node is a clock provider, #clock-cells = <2>.
-The first cell of the clock specifier is the clock type, and the
-second cell is the clock index for the specified type.
-
-	Type#	Name		Index Cell
-	0	sysclk		must be 0
-	1	cmux		index (n in CLKCnCSR)
-	2	hwaccel		index (n in CLKCGnHWACSR)
-	3	fman		0 for fm1, 1 for fm2
-	4	platform pll	n=pll/(n+1). For example, when n=1,
-				that means output_freq=PLL_freq/2.
-	5	coreclk		must be 0
-
-3. Example
-
-	clockgen: global-utilities@e1000 {
-		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
-		clock-frequency = <133333333>;
-		reg = <0xe1000 0x1000>;
-		#clock-cells = <2>;
-	};
-
-	fman@400000 {
-		...
-		clocks = <&clockgen 3 0>;
-		...
-	};
-}
-4. Legacy Child Nodes
-
-NOTE: These nodes are deprecated.  Kernels should continue to support
-device trees with these nodes, but new device trees should not use them.
-
-Most of the bindings are from the common clock binding[1].
- [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : Should include one of the following:
-	* "fsl,qoriq-core-pll-1.0" for core PLL clocks (v1.0)
-	* "fsl,qoriq-core-pll-2.0" for core PLL clocks (v2.0)
-	* "fsl,qoriq-core-mux-1.0" for core mux clocks (v1.0)
-	* "fsl,qoriq-core-mux-2.0" for core mux clocks (v2.0)
-	* "fsl,qoriq-sysclk-1.0": for input system clock (v1.0).
-		It takes parent's clock-frequency as its clock.
-	* "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
-		It takes parent's clock-frequency as its clock.
-	* "fsl,qoriq-platform-pll-1.0" for the platform PLL clock (v1.0)
-	* "fsl,qoriq-platform-pll-2.0" for the platform PLL clock (v2.0)
-- #clock-cells: From common clock binding. The number of cells in a
-	clock-specifier. Should be <0> for "fsl,qoriq-sysclk-[1,2].0"
-	clocks, or <1> for "fsl,qoriq-core-pll-[1,2].0" clocks.
-	For "fsl,qoriq-core-pll-[1,2].0" clocks, the single
-	clock-specifier cell may take the following values:
-	* 0 - equal to the PLL frequency
-	* 1 - equal to the PLL frequency divided by 2
-	* 2 - equal to the PLL frequency divided by 4
-
-Recommended properties:
-- clocks: Should be the phandle of input parent clock
-- clock-names: From common clock binding, indicates the clock name
-- clock-output-names: From common clock binding, indicates the names of
-	output clocks
-- reg: Should be the offset and length of clock block base address.
-	The length should be 4.
-
-Legacy Example:
-/ {
-	clockgen: global-utilities@e1000 {
-		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
-		ranges = <0x0 0xe1000 0x1000>;
-		clock-frequency = <133333333>;
-		reg = <0xe1000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		sysclk: sysclk {
-			#clock-cells = <0>;
-			compatible = "fsl,qoriq-sysclk-1.0";
-			clock-output-names = "sysclk";
-		};
-
-		pll0: pll0@800 {
-			#clock-cells = <1>;
-			reg = <0x800 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll0", "pll0-div2";
-		};
-
-		pll1: pll1@820 {
-			#clock-cells = <1>;
-			reg = <0x820 0x4>;
-			compatible = "fsl,qoriq-core-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "pll1", "pll1-div2";
-		};
-
-		mux0: mux0@0 {
-			#clock-cells = <0>;
-			reg = <0x0 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux0";
-		};
-
-		mux1: mux1@20 {
-			#clock-cells = <0>;
-			reg = <0x20 0x4>;
-			compatible = "fsl,qoriq-core-mux-1.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll1 0>, <&pll1 1>;
-			clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
-			clock-output-names = "cmux1";
-		};
-
-		platform-pll: platform-pll@c00 {
-			#clock-cells = <1>;
-			reg = <0xc00 0x4>;
-			compatible = "fsl,qoriq-platform-pll-1.0";
-			clocks = <&sysclk>;
-			clock-output-names = "platform-pll", "platform-pll-div2";
-		};
-	};
-};
-
-Example for legacy clock consumer:
-
-/ {
-	cpu0: PowerPC,e5500@0 {
-		...
-		clocks = <&mux0>;
-		...
-	};
-};
-- 
2.34.1



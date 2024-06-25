Return-Path: <linux-kernel+bounces-229648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE291724E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C60B22220
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D7717DE17;
	Tue, 25 Jun 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eSIH46X9"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2079.outbound.protection.outlook.com [40.107.103.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691517D8B3;
	Tue, 25 Jun 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346250; cv=fail; b=DzJ4z5ll1dqhyERCyqV+aMi2kO2gl8ZJBvUSGgVSK+4HEJlhwMdtrgFPN3omh9hxNWVE/dj+n0KLBhRtGNzrXsJbsV8nRvSdb5knah+XKc/niduvbAdTwOQu6EdG18KHxirPiDPogOKktENZB4Lh+xUrPj6cJ6SMIi9zlofE9CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346250; c=relaxed/simple;
	bh=wGZzobkxEM337hanEMk20Uo5vRNZ3Wb4fLo+R3NlB5E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X9mwUzsK+Hxe/bbEm6zZ1Pgwedhyyl7aHAFMr+r0/ur2XrLJFDa5DeGfYWfkzSI6ZCOBZa0LoRfTlu2aDwvARAfTmN5QVahqBYfNW7ISgGHXrYxOIZeX2N+pboG3WJrX0NOhPJ7Mo4VjXgxIXyo3BCWB7TaCqOZzk3FEQDXTSo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eSIH46X9; arc=fail smtp.client-ip=40.107.103.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hth5Y4mPBZhawbJhr3U4laP/SGN4NXVbzd8GzxDOx6siOpIhcl7dL3x5yzj5HCbz6Bgrz6ljOaJGceU0vu524ahwF6Is4AwB/EXaegq+HljRH/vTpYqnH5ti7mpmb3+aH3+HekqVjfmAyhTBHk3ULtZjgGMNmrmxnNjd6Sv/SO7XuM+zdvcitesM19DCJfxP1ys+sa12D7wzwWFkZ6Uuc9A2rO1s+HnAjIblARnOn3p/8xJ2V76cWOxvbfBaSnFM/DGg5D9jFMasqSIN7pmFWtFdwfEFGpnCeYh5A9IzWtGYMvRYTLbHQ6+RyeYSvVbnwqEXHkI95xXizaLKBUHIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9e2d43TAsPNqKeNY1JDrqy35xKWzjsWD2cIRmZDULs=;
 b=KVNxpk/40kIB5R46orF8jRwrHZpdo7Spk4tSYdTyvSVR+3l0AEc+qZ4SH4S1japl/gsECH1L6JN7FZcc9Ba9py/c5JSHrRhuj6bdCTG8IwfV2Gor3zVQ6eiNfXp8Zw6fSUNVjSOvGtSQo6iFK5O5Rdg5SBt5RrncmxAc/AkUuMB3W2jQp41JTIwOJvz28R+XoUfPyNB1WrZc05k9jfyTA0MVvx8cdYuynCofmHU8GKNm6nHcT3fdoQ2TgWvnhyhawkIzOhoy/Yg6nQoSLRSri5tbr8/50Y490XYiECS1XtdYEndztrxDMGiSSaC5HZuW+4ulAQbgeTmRwNi5s0wHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9e2d43TAsPNqKeNY1JDrqy35xKWzjsWD2cIRmZDULs=;
 b=eSIH46X91vv7lg0kHZ3e3QqRMKa/dUC3puMwJlMZumDEtDvYMCndVZgJoXlw2lE+DUeYiFYCfMCJsoRQc0h+gBybAWiQyjGw5NoZ+mlCBMsnNMo/6H56AsCPzA15StitpLXEfg+XbhxJrK0Bobu+HJyn4Sfvm/0tsKp3UlXeTZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 20:10:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:10:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: interrupt-controller: convert fsl,ls-scfg-msi to yaml
Date: Tue, 25 Jun 2024 16:10:27 -0400
Message-Id: <20240625201028.3923845-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:806:22::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb54644-377e-4e22-198a-08dc9552e42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xkNlvlptDpdbDAWl8ADt/NxLdkbufBE/a9PiLyzvFULh0gdCifREibP/M1Mk?=
 =?us-ascii?Q?Oz4PBtAxF+EMkCpHG8nvMJ/PQ4ljGmjLMtBGPV/L8cIpH1xFJ4kr3pAsMbMG?=
 =?us-ascii?Q?TCELetikweCKxuWhgVnEqKKf3PRxCR7Whuqmfm1kz03xhF0WEHgMBSQnedBy?=
 =?us-ascii?Q?DW3UVDmXrONMsmY3x1iZeHCMM6xS3HnemgqB9Og/Pu504wMVq3BXP1Mxs215?=
 =?us-ascii?Q?cLPQlNBU82tehAf38o0flSpjOqEo6eoeKbmbVsVnjnreGhlo2jbdGW38RpIu?=
 =?us-ascii?Q?a8DgbYRQQPUp/FvEmA9TWjTk/AppkoaM7EXm7YBzAYr2OOAq4nlo9WHqdsCj?=
 =?us-ascii?Q?3qBdj6TN+o0oCDNcWCTx15g17QzEa3qWqE9XuNw9ih63Gs+R51RtF/6Q6Gub?=
 =?us-ascii?Q?WJUN0k4iDjnZCy3h0FpBAQAB5Q5GZJEoUsvB0CaZbTKDP3n+a3vwBokWlqS6?=
 =?us-ascii?Q?XiP9eVagGvGhj6HltWR6ltR5MPxEYYBMDc09NnkhiYgLSQgFxOCkmYeouFwo?=
 =?us-ascii?Q?oLeHRCCn2iAOjuiGFpXGrC629w7WRWE5dyQ2d9PqGyhrkP8mEX+t/bo9fIDt?=
 =?us-ascii?Q?CK4JAwcxS5mnjDw7uHz7WOPAYtKpBIQBV77K7nz6sFTWJBFu7VJ0/3kBcwfW?=
 =?us-ascii?Q?kIjySW/t5PI5m78l/Z3pf9OsMrhL8MgEAaxwESgnxz+romDbQ3qJbJFxXhS1?=
 =?us-ascii?Q?9YEIoTtuwxbkQl47ZywRv1mhCjTHUlRlm56FuJmLp6WuNnsGQBwDGfUuspRb?=
 =?us-ascii?Q?G9BY8sDvAId4FEFP2amif8ztLvFOG3JWFuUEDsVZx/y3QwmmPmVv1Rtv1Jct?=
 =?us-ascii?Q?ko0ElXbIJA56mhpvqvRNLqnH2VEpt2hbBwGg/aTT8Egn6JHh375NWjiJPyyv?=
 =?us-ascii?Q?ridzuV9VSC/T5Lj6AoObQOL8nXhNVrs9jkppQ8fJIEeQQ/Ki2qFqBf7utY6T?=
 =?us-ascii?Q?UaSqNb3uo9wZ2KZiPJgyYzFKhOu5kGF+G1vM20HqPQEOIsJ06vw05aci01oy?=
 =?us-ascii?Q?MfYlF0nLzvAwbunTEy5TkYpdigXruRRWRdvKozhud1e1svhy1aVd4hw+DcHn?=
 =?us-ascii?Q?MCTRRMraDMAnnR+n6yL0EnEAbQLab6kC9ZBYpJhev83t4fSarOBwX1KTwc4s?=
 =?us-ascii?Q?DprVP9YNQUMeh2qYEkI4Soej8Wn83U/zHp5MavMLvK7eVj/91ll7Hkqud/jt?=
 =?us-ascii?Q?UGoutMuVHb5H0ZZyCRiUKyZT9lxXmhxoSnDx2sIWHWfc9WsM4L5zOGOnLLDu?=
 =?us-ascii?Q?7wPBwvXCu73qpP1BIpN8N2CCVWeuBmTk6uDepAc7mi2UVpg/DLRhfRbHbRNG?=
 =?us-ascii?Q?9jhp7HkMvNura7d8VLDIoNyf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jh/oaIStrlD915BgbQAve9QvcN/it6sElMp8JxQqa4vhLsKgtG5/RG5zEL2N?=
 =?us-ascii?Q?+O0JYwdmmd5X3uwuswpxibmWp3COsWe73d/T4iSQIUz0BL+0cMfysaqLlPyW?=
 =?us-ascii?Q?9gwyCYpd08otKc2AofZlCESySQUHWClUOKZJ+v/r0pTCnepFNws1lmOZI4fS?=
 =?us-ascii?Q?b5h6gJKlV1fUWLdYRpxf2YGan45d0XOOuNB1nZEnA+VwOZOMryU2h66HWVdV?=
 =?us-ascii?Q?jspr5FjVJPSSuI9IEoREKh3emv34BhuId0QG6NW4sdoWetcwDjMbqnyYj2q2?=
 =?us-ascii?Q?6CBAdscAs1ipshf3gkr6st5jyfv2Eu5AgZHjMOQ5RVfQpWdipucAKqbchNkM?=
 =?us-ascii?Q?OBwByt8zHhILewutD7NpMO3fEFG5m0WfmHTJsBlh2YGIDeguxDmz/0DSZpNS?=
 =?us-ascii?Q?2fLdqyQ2dEwzZeL5gDWkoq4B5vByOgnSq3WE1c18VrBN/i/Gu2MysuAOJyzi?=
 =?us-ascii?Q?y+3qcwe0/hasxbf+piAUyHUyuCkRdRtOfC8ac3A+hyRVMV5Wy3s20JQVk4wL?=
 =?us-ascii?Q?M80d10A0aEGgcLlsckgtlEokqlLK15CnXJQy1eFEHEUWBHXLwrq8jW/KiUgd?=
 =?us-ascii?Q?Kx4dpaHuTaRwPzkWn7ozvZCiAYNR0vx1wMCoLQQclnpfm9SAuhlHKjjzdvld?=
 =?us-ascii?Q?SIEIwVs8Y32U6QTxztpPc5o/8YB2KcEmC6h8geH1RogKAY+/zO6rzK41IrAz?=
 =?us-ascii?Q?kBVmj3dfVm2i7vscRN7DekPeErz5ET8vgusypLUqcygLlQ8racxOH1VQz1Yp?=
 =?us-ascii?Q?YB9nVi5YprlJTOg2lO9P45f4S6egVRaVWKlCLBRaTWRdVGHjyK0gZqPR82g0?=
 =?us-ascii?Q?rDiuaiaiZXGR+sL5pzs6tsdLcKSWYkqhO9SdzZNIJnous4JfN8kXeubnkiQ9?=
 =?us-ascii?Q?Zsr1Ni+aN880lF5D3ZQO0NYMJxWHzswnlz9+CgRtCMVJEkjXlnrX1mSip9sV?=
 =?us-ascii?Q?xlcbbOVpfVFxOUUt1EHURPMYlDiOuUSAbv2c67IPq/b8ZdPJJuSXmbesgzxp?=
 =?us-ascii?Q?G7GVt70t3ebJpnvqa16G8HvV5tsYQKYf+uNOBo3JHFRtR4AnqqfUjDcD485k?=
 =?us-ascii?Q?u0xKjo+UwHVjAljhmmeQrf97tmB9+9ptVYt0CifS0GZ/ytTJWWDxFWmM0AWQ?=
 =?us-ascii?Q?IzlGMS0BEJCXYKDUJc6G/IgYtKSJSDVOL4/h0I6bFPKahkh9srDnIUJeEZu9?=
 =?us-ascii?Q?Ider3aS/LLqYNvX83ncfFcoTHnUV5FTGV0PTX6nWyhk/YoNYKt9X9VF2j01q?=
 =?us-ascii?Q?CQlRNMzd4gYzaogNNglwhqYB9v/YVC60t33xPNxxdpSaURmZvDChrlI3KV2w?=
 =?us-ascii?Q?t9siUcPtGbW3ss3+Byirz63nzBlw16Mor0i1knFxpdJW6dtnl3ZX0ge/h2Mt?=
 =?us-ascii?Q?aFkytT902+bSyVK8kQIseAowd/jI8wLN6RiZHvTuBZ6TmZZ0THA+wgD2Tj/8?=
 =?us-ascii?Q?7EBpj+45SXCsxh0bCKkAt0X/QFUEs/KBTqYQtF8P0s32BnG61dFjrYgzqGYq?=
 =?us-ascii?Q?9XyUn4CTAkDuTxI5PsJnU5qz4VY/8JZ2qsfv6ac/o7gAKetcHpWacs0g9gpH?=
 =?us-ascii?Q?HnUkqowiM0YSklcRD/0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb54644-377e-4e22-198a-08dc9552e42a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:10:42.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9OLt2N2Vf+2Y311feG79/dR6Yh2RPAR+N3pxnfA5/y3K6KOJQSa674zgWrqFxltc6xY/OWJskZi6LKCbJfMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703

Convert device tree binding fsl,ls-scfg-msi to yaml format.

Additional changes:
- Include gic.h and use predefined macro in example.
- Remove label in example.
- Change node name to interrupt-controller in example.
- Fix error in example.
- ls1046a allow 4 irqs, other platform only 1 irq.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../interrupt-controller/fsl,ls-msi.yaml      | 72 +++++++++++++++++++
 .../interrupt-controller/fsl,ls-scfg-msi.txt  | 30 --------
 2 files changed, 72 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
new file mode 100644
index 0000000000000..d11188826dce0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,ls-msi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape SCFG PCIe MSI controller
+
+description: |
+  This interrupt controller hardware is a second level interrupt controller that
+  is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
+  platforms. If interrupt-parent is not provided, the default parent interrupt
+  controller will be used.
+
+  Each PCIe node needs to have property msi-parent that points to
+  MSI controller node
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1021a-msi
+      - fsl,ls1043a-msi
+      - fsl,ls1046a-msi
+      - fsl,ls1043a-v1.1-msi
+      - fsl,ls1012a-msi
+
+  reg:
+    maxItems: 1
+
+  msi-controller: true
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - interrupts
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,ls1046a-msi
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@1571000 {
+        compatible = "fsl,ls1043a-msi";
+        reg = <0x1571000 0x8>;
+        msi-controller;
+        interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
deleted file mode 100644
index 454ce04d67874..0000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Freescale Layerscape SCFG PCIe MSI controller
-
-Required properties:
-
-- compatible: should be "fsl,<soc-name>-msi" to identify
-	      Layerscape PCIe MSI controller block such as:
-              "fsl,ls1021a-msi"
-              "fsl,ls1043a-msi"
-              "fsl,ls1046a-msi"
-              "fsl,ls1043a-v1.1-msi"
-              "fsl,ls1012a-msi"
-- msi-controller: indicates that this is a PCIe MSI controller node
-- reg: physical base address of the controller and length of memory mapped.
-- interrupts: an interrupt to the parent interrupt controller.
-
-This interrupt controller hardware is a second level interrupt controller that
-is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
-platforms. If interrupt-parent is not provided, the default parent interrupt
-controller will be used.
-Each PCIe node needs to have property msi-parent that points to
-MSI controller node
-
-Examples:
-
-	msi1: msi-controller@1571000 {
-		compatible = "fsl,ls1043a-msi";
-		reg = <0x0 0x1571000 0x0 0x8>,
-		msi-controller;
-		interrupts = <0 116 0x4>;
-	};
-- 
2.34.1



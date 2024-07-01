Return-Path: <linux-kernel+bounces-237017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CC91E9EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1521F222D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3E171658;
	Mon,  1 Jul 2024 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Idi911He"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370691591E3;
	Mon,  1 Jul 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867512; cv=fail; b=hWfHDvfhgsQyvg/ObFI4vQDhZ5ldglwY6AnhiTJFO4Ds+PjXp/fuQapUtI84LrEhNQd00o6o5VVJlMOUYTMpOgx+dy3+TaVzrV0JpfWuXcKBKsEU6w3TBVDOnP7CurCphWNrRdTksRxq1XBQ18/3e8PpdKGiFlbPAGzp/5Y734g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867512; c=relaxed/simple;
	bh=qUnRPmB6C5wMiua7RNzbp7T/IRG1fBIpAa3TxwESc6E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SM+fIzRtkbxkGsmTSA+VgwPN8CTuyKPSZQcjM/wcFawVey8JXhLM5tz3AvN/Uwcr/fSNPnibhW7Fji+0qSd0demlScupBJ8Y91ucnpCY1/DFsyNIEqBxGCcMqhp+rvYNNFArcqUsB+JbEbtayetiUfkagaEIkHjv8Aos8V4bKtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Idi911He; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbiB/ZoftbEl3ZimmT43f5AoKP7j2RdP3oInce0tSgIuzFZE5aCjFthIwMrKYpo/8ZWzHOr2e3gnX5ug93vDEmjCa4HL6dQgpqwWS7iZk+kCrZoBjllZ+5fINjNPb3yrWrIOKIxtfia3WYApDcxCEGAVfD7F19lQjmvEPdHOgc3ijeezRHwnlVPHvrt51QfdWYiQ7VT+gW1QuAhISs6i3kFfti9KJILAiwkdqnTDN3SrSEYtRYKtim+R8XPXwN3AdvYDlqcPcfmyOtQatzw7bKiT80DiS7g7L2z3rpRuZ3I0NBfltj7wckvBPGrpvlNKgRXyAAywY6T3yMZBsv0D+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PKf2+Jus5e9ruxI9WUEGeoBv5u8zxcAC05O/qM4QT4=;
 b=OY1zv9lKnbOzyHnCvSxwKGwh7tauidnHPtFQ/FCzUGKGgH3xJs8yVvY53/KdkjWDvhbA/ifLoGLTQWUdSYE6QKaxfCaM07NJbwjyapIOWKfgE2XvF9HR0qQIb7WDxxZgdUAbHHygbVz70FRsTgKaOLmezujZecCYQU+P0XybW82Jv/Lw/t6OUcvK205WYi5i+Qx/a6cpsyFwceGA8JMpes6pvc/iT+4k88nb/J0zC1E7HjBi8V9xADoBTaU/J8Hu1iUKFQl9ejlEymsQdqSDgfibDf84mLE3epkIoy+37eREebHURoW/k7Iwcuc+AC/r1uxkVsUVaWm4qA0Gsl5tQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PKf2+Jus5e9ruxI9WUEGeoBv5u8zxcAC05O/qM4QT4=;
 b=Idi911HeBcdu3aWG/cEkgXDZc2I1TrflrKOXPVSEagbpVawJbqwvUG9p7Z4O3v4OwxmkAOVaS+Q63iXqToneD7cQVnwkzdz/4aDeNm51UPgu67+XiEhY9JcA6IAXy5ZeHPMaH2gA0lPH/M2kWAIMIJyPBeU7oEeAjTaxivpGWlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 20:58:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:58:25 +0000
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
Subject: [PATCH v2 1/1] dt-bindings: clock: qoriq-clock: convert to yaml format
Date: Mon,  1 Jul 2024 16:58:08 -0400
Message-Id: <20240701205809.1978389-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 808d7808-5978-4ffa-8ede-08dc9a108cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPgO/qs4dw5LCz7KlPTgJ4SmakaSj/iMZxKq0jd6So6v645L6vRDhWiVKOAv?=
 =?us-ascii?Q?dbBKKbSYiWruUDkHWemhzodZ7Qg4fvD7EYMOyOVNNnnBBq48KQ4Ao4hW1GYu?=
 =?us-ascii?Q?6bEFUFb9+ev8J97f6qFcx/uNX1WzkNuBj+N5xwfYLE5jXTmDMJFhXQ3fmZN/?=
 =?us-ascii?Q?vGk8gZYdkvcoLgydsgk4n1/47yoosRorNktWDx8leFWKKuU8GMXp2LhrTeHe?=
 =?us-ascii?Q?5XBV2ZWOCxjsXjSpatQduSU4tULFFBcn9H1ywrzsielYGqEZ/cHFl6HqKaGS?=
 =?us-ascii?Q?kd9qz/Ginuxua6Tg9cVMKnJZB2NbAq/m62cHM/omKYwvImHBeZeWHx0+XiV0?=
 =?us-ascii?Q?vWN0H2w4qGGk4ZzolRhnRWIvJSkgEUFD3KiY//C09MSYMGzYi6Q1Y2FwOwJO?=
 =?us-ascii?Q?b+wNSQmXxcM07Fw/p6jcKqp3Afb8vKxxBN5Itg9mqBJv7B0Tk571JrGDEEvA?=
 =?us-ascii?Q?6jiIHtqz4W1thB5FHhkncYPJyFcrleaw//6hkeWg/thlX2zW6zFPniIusxSI?=
 =?us-ascii?Q?IXmjZfaHvoQC5PCqDjSaR4/ilxl9P05i2zkTVgrkhTnFr3oR64ukJRsJErUr?=
 =?us-ascii?Q?6N+0ucgdBelCXMcCADalxjVRSNPPln4HzV/w6XbT6kyaOIiGMWM/8WlJ3yAl?=
 =?us-ascii?Q?1PN3CUo7Zv3QJ5l7S2v9zko/lsLxdwhTNNlDshoeXWQUE7dI8BC36Xld+Qg3?=
 =?us-ascii?Q?5ECtgwI10MLxKPxTF2rEsnuOnv4LBFidtcFdRracYRb/9J3kiiTrC/YpRBr6?=
 =?us-ascii?Q?0PdZ8VoLqiZdejZkm/gUdvjRXVZV+lTuH9OESaw7y7lBzWZwAUEQdBWR8EXm?=
 =?us-ascii?Q?Q0gk1OBxWiDcAdcbLDKrPLsILoXAC/ZTCBwJgaHpYKzHMJaMdVlta1rPim+u?=
 =?us-ascii?Q?oJUh4DJw/j6xKMIaWNoVVjV9lz+Oyu9Md60CzkFL09z7QD6LDCxVLlQub1xa?=
 =?us-ascii?Q?FoD35ORJKfnfvWy8+ALXHS9VA1keRzn5FAJq/CtY9T5S4MWNSDPQXSlcWu4g?=
 =?us-ascii?Q?SIAXU/eCFcAJIRl+ZjQutSro98aLtelyI17cUhlZ89h0V1aLjntiNBIyUrjb?=
 =?us-ascii?Q?W3RbAoIyMfqE+9Vo2dvfkxI6Ouu/gnussp1qZmGQ3l7isJaG1FvCqfL/j3Cp?=
 =?us-ascii?Q?do925RdYbJuedGYLL3SlpDk3CzFcpsDg5eJGKOE/etOyEMOI4P+KPLOPQHpf?=
 =?us-ascii?Q?IqbGIw26UFMybQvmuRVO01nIbn2snmPA+ULUDz3k0rYEYWUVU9xv35TAYbm3?=
 =?us-ascii?Q?3WiIBBsoktmdAa4E9Bn7ea+Rc1tpLHpTFrdLTyZ7PjWoIt1i0NtiIJKj36Df?=
 =?us-ascii?Q?EJy6yD6Q2HjBa5kFDu8264ONjDMA/k9Ee+qZ6R0QogBiazIHtN38VHbg6OZ7?=
 =?us-ascii?Q?5DQl8Rs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dhxTWP7XjnmlKSG9hlRQjm9FLlUzCYFlHQHeugMf4jzN/ZXIUAvLIMsaOuyo?=
 =?us-ascii?Q?Nu1/Xh5xpw3EXTXbtiRm8ZmWOJCkFW1kbZr6kXBWbiqbxMcVFEcNs2uLQ0Nk?=
 =?us-ascii?Q?MK4Xl8lzcLrHQLGpWOlbwHeELZwqn9cAz7Z5G/VfqPVR5ZyylP0B3ufs7JD6?=
 =?us-ascii?Q?hvSC4p3z+75XYSGe6MOK5U6khWLY+icITS9wlAgAkoFwT7LEFae83UAyEzol?=
 =?us-ascii?Q?s4QJOHnCuXS7Q0VoewtxeH23Cr2beN8fyw9nHnMu8DDhCtqIREFCLfddxbjW?=
 =?us-ascii?Q?i2U4Wf2mLWfgjlLTUJ7pn7/NCK4di3zx+1hvOYQVXmyIL+AN21yw0zP+Avcu?=
 =?us-ascii?Q?Pc2vV9KgF69jUlFbjmxCjPcA+FBRHBruMUTkMxu+7L4Ya4zTy2elkCaCshCg?=
 =?us-ascii?Q?OHEuW8ZeaDjtudw1i2+mYHbdoo5fBOZyEBFCgiSL45dFoEZpkjD4pCkJ6RaK?=
 =?us-ascii?Q?4+Am4RGBQ1TXPPd3Qr64TFQBon2Tt6zdkoMKkigpW2mShSRt7z7Y3r7bUssm?=
 =?us-ascii?Q?VSmyhdNu75n2NqfVsO7/pZZYAzJEepNLTysO/PDC+3tkNVklsvaQoB06daye?=
 =?us-ascii?Q?s/aLA0Z6MJeS9CxS+CNkkJWSyoVFoKtrt9UFP/iHfMdMvnwnMmswa9jZnC8/?=
 =?us-ascii?Q?MTKsum5ZYYWoP9eA/Jt+wlnjs1kNp6y3sBwcExkkiFRJV1cNNmZgxghcNu/p?=
 =?us-ascii?Q?LmVgrN5GgX8DrHUzt3SZJgsxtzoyaHV3kmfVJrd35vQnVAAR8NI3o9sBOsB+?=
 =?us-ascii?Q?p1MHHgU8wZrCUxvy1dxX13b5eURG14vY3y4DcaatLqTe+RoEN4pG21K1yxK9?=
 =?us-ascii?Q?1BPBeIBCcc0JZiu8M3bVlsMcKJpcgkxGAavUDPkxH121h8bOAxzCvO2I/d3S?=
 =?us-ascii?Q?OCH2eRpqGp8OB6bpQNyxnlMH2s9kwosvcLdHuqq2eBtLAO7C99DWU78EjRA4?=
 =?us-ascii?Q?Zmv7hWbRn2GyzxgSdkyU9rZpDlW7LZj9dnJ7F8NA3+3z2rB236/+MhdmyPS2?=
 =?us-ascii?Q?dMj1h+b2+iXxjyuvPahlsB7yHkx3EzzW80X92eybZszUb8teqw11J3W4CRYq?=
 =?us-ascii?Q?lRlFEHT3t/a9KeLJ83yBARshBzCWj5TE25SEmRkpZiTAwtvjEJctdLENcsDb?=
 =?us-ascii?Q?IZVdg/2+TjjUrUiTxYmb2FGe1WNY74bY3q1ZHp/So0wRjFgOxuor4m+iwqDk?=
 =?us-ascii?Q?rap/8NR13yN6iis161EUNXTZfXv1+4y7v2i57oyvevcaWjwTNu4l2oP9DbdL?=
 =?us-ascii?Q?TiMMZ7Lw0A7JilFm25s5k9P9M6WWnOZkpVetrVFefcIigcT9IBeFcccx14G+?=
 =?us-ascii?Q?SmLkiatdJzGXkNCIE9CAEMFhB5V2Cx+1GjpGXAax1ah8e++6FiyHAF+DLpOi?=
 =?us-ascii?Q?ey8KcbT9fpObEjnxrrga/d5TQ1zE952P40jxxtvZOK766CrVYpfxZM5iCL/w?=
 =?us-ascii?Q?SEx/ZE0yZFprUfJB7NUOyK+/7qsP51xgU4uwqX3fEn+p50BvVBrubWgrhv4v?=
 =?us-ascii?Q?NXZ5nJ1D6PboNdhTPZ5iDh6xwa8uZ2oSKtCL2PgCUHm4zTNB/tvh08bCLCRF?=
 =?us-ascii?Q?rywm4AiqYwdja+hTRjI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d7808-5978-4ffa-8ede-08dc9a108cbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:58:25.5667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWQ0NL7ZMlTh9m7HMsfp07fkBlBodFuju/LUe3xY/Lq+xkX5Xwmod/SfzsfUEdZyQER2CQS6gdPrDCHgpvGBwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008

Convert qoria-clock DT binding to yaml format. Split to two files
qoriq-clock.yaml and qoriq-clock-legancy.yaml.

Addtional change:
- Remove clock consumer part in example
- Fixed example dts error
- Deprecated legancy node
- fsl,b4420-clockgen and fsl,b4860-clockgen fallback to fsl,b4-clockgen.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- split comatible to 4 groups.
- drop empty line
- change sysclk pattern
---
 .../clock/fsl,qoriq-clock-legacy.yaml         |  84 +++++++
 .../bindings/clock/fsl,qoriq-clock.yaml       | 207 +++++++++++++++++
 .../devicetree/bindings/clock/qoriq-clock.txt | 212 ------------------
 3 files changed, 291 insertions(+), 212 deletions(-)
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
index 0000000000000..95a3e3b242672
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,qoriq-clock.yaml
@@ -0,0 +1,207 @@
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
+description: |
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
+       1.0          p4080, p5020, p5040
+       2.0          t4240
+
+  Clock Provider
+
+  The clockgen node should act as a clock provider, though in older device
+  trees the children of the clockgen node are the clock providers.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,p2041-clockgen
+              - fsl,p3041-clockgen
+              - fsl,p4080-clockgen
+              - fsl,p5020-clockgen
+              - fsl,p5040-clockgen
+          - const: fsl,qoriq-clockgen-1.0
+      - items:
+          - enum:
+              - fsl,t1023-clockgen
+              - fsl,t1024-clockgen
+              - fsl,t1040-clockgen
+              - fsl,t1042-clockgen
+              - fsl,t2080-clockgen
+              - fsl,t2081-clockgen
+              - fsl,t4240-clockgen
+          - const: fsl,qoriq-clockgen-2.0
+      - items:
+          - enum:
+              - fsl,b4420-clockgen
+              - fsl,b4860-clockgen
+          - const: fsl,b4-clockgen
+      - items:
+          - enum:
+              - fsl,ls1012a-clockgen
+              - fsl,ls1021a-clockgen
+              - fsl,ls1028a-clockgen
+              - fsl,ls1043a-clockgen
+              - fsl,ls1046a-clockgen
+              - fsl,ls1088a-clockgen
+              - fsl,ls2080a-clockgen
+              - fsl,lx2160a-clockgen
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
+  '^sysclk(-[a-z0-9]+)?$':
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



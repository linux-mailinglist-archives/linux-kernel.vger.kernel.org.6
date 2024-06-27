Return-Path: <linux-kernel+bounces-232479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB091A969
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB91E1F272BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2A1196D8E;
	Thu, 27 Jun 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQX5ehhv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AACDDA6;
	Thu, 27 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499350; cv=fail; b=S4sHSuAuVTcDntCrW/fX9RuQSbZG8Y7LmbUDlU/TWoQKqk+7tteVfC0EIvyWbIN4t4AqGwv5b/wHVCXSz9RmB2Wm6Yy9BZgq8qUO0Hf87flQFKYOOGi41YdHIUPEriPg2qf9957nVH/wMGw364JTlmuZQd96e4+uGfZ+TM0zh3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499350; c=relaxed/simple;
	bh=wyIqIOQNnlKRBWV0lVuUH+JBurXaYrTjajYDrZGqAw4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mnIfjm2+fTOe+AJb6gewWY8mgvlkLJ6sV7wIbL2nKITZSNkkD6hlWohjAwuyon26f+/xQG9o4mR2rh2a6kglWU6uEjy76SI1kOp/54dmbgx6pIxSfH8Ph248aFgpjgK0G1wifr//6gbq0/7FTYyxnvP5casgwel2Nh532Qmgxq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TQX5ehhv; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daOwCvTflPqvNb616A3G0N/vELSRR4OvYt4RS/ijuPaeXqQJGjwZq8LL+TWxh48DahaEnOVd5vr5Me/fglsprz+uLn1E2uFtRX/YdM8r+Qx+3aL8UsNvyWEliMlVFeMOF0f5x32B7RHdccArXhMvZu5xfYzWqpvpfzTeQZOY5talg6SYmWFJCX4kCFj/fE+6Hv8iyu5joBTjRUZAEdvEpFZ597vWLwF9J0tcvIMggYHpF0YqOkjhOmJ+mth8Xu0dIXWmHsn/AyUQ38C3JTqpAV7ZCBGRSXi+U89/2ISySgAI0GVzO11CBTzz5k2XvAc6ialm6GhuW/sLfpU3Bl/WtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7W2my2qXRhzpf8sY/t9xZdRf4fFUgJwRoka4gxIPaN4=;
 b=MbINaeXYQKtW2VWv3CikwaVO+xrYQnM6ci8Kg0j5P4KOuOT5y/ASfULD97KxUjrABMcHCiBaAx16YXf6p/T0nGebUSyFZ8QWyT2YZAfe45EI0zdLAaEwrhF+xKB+P5p5j5ynNiWOL0qUF0tmwVyRCs9HkwmH6ev8KATnesRPT6eKtW9MYDjgdibCv/uI6eEAb1XCTyvFehrJRofJXWfJdLSjAqadqI6XXVBlP+KKvqLq1jBDf4oW5zCNlyKHJMWSjL4HxF0tteF33Y+L/IaLE/uA5bmg+gY9Ex/DgjPhY/jtLTNMrwbKeHe745WuaqtVMdudVc0XtU/04KdkXsehSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W2my2qXRhzpf8sY/t9xZdRf4fFUgJwRoka4gxIPaN4=;
 b=TQX5ehhvlSz7X9MLiRqheDgxvkCEOBlElAEbUyjK9uwOHPA6AtpJpPifgyp3dE/dWeGcKM8l+cGQjBybMtbGLqhEhhmmGwTuUQmEC1HuW127O+tJjQ1LGuQmOURMn05BPuSqmMZ3KhoponcpAo8o42xPrb+mZj+T1uyEN7ChgPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10973.eurprd04.prod.outlook.com (2603:10a6:800:25a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:42:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 14:42:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	tglx@linutronix.de
Subject: [PATCH v2 1/1] dt-bindings: interrupt-controller: convert fsl,ls-scfg-msi to yaml
Date: Thu, 27 Jun 2024 10:42:07 -0400
Message-Id: <20240627144207.4003708-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10973:EE_
X-MS-Office365-Filtering-Correlation-Id: 90038cef-abc4-4d5c-6dcc-08dc96b75be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DsBF/+Agptpi6V43seX8HzqdVNPwb0tqyVzzO8gJraFZyTD4wQXAIlW1OCKx?=
 =?us-ascii?Q?LYPVPFJdCnKS/mRk2WzHY3zqR1TZ+pH9Vk7eNiE+2QMIduNomogN8lAXHKt0?=
 =?us-ascii?Q?57PcZUjFRYDkc/Q6TmNNiynPCOe2Z0UuD1cikl9p0AxH6Dgnc37KqfDl2DSU?=
 =?us-ascii?Q?R7GjOVkmBFqA6bVrurvRKeKulqe5ELeTlXok1NMQnqm2eu7xxDIz64mu0bWB?=
 =?us-ascii?Q?p+lU39NKjgLpZ456avCBJ2AU2pAVwbDZF/W0WO05LgfO/1li5BqUB43uAwQ2?=
 =?us-ascii?Q?SvHIXctHcquIKn5pf5E/747LvV2jjKDPnOkrdiymmK1VYIc3ym6Dn6Q6QtET?=
 =?us-ascii?Q?YYexC8pEZhomIKZ966VlXJlSg96jh4cbeZfr4teaKXXQMsY6wtqDszG8BmWz?=
 =?us-ascii?Q?i6Zlde98inuWoGVqU1rMV0eAKcclg1BSPGfClsq7GcWlPpeDsLEInLDe8PK7?=
 =?us-ascii?Q?2SiSmJ8qFqequ+CIvw9Uk9zNFjw/lSwe8j7vrE+zV/U1LO6xncRoW3mTrUb7?=
 =?us-ascii?Q?c9O6djXOoLacvdNsyTS6d6IFY9zCyKoaeNdMWFWenmaLaexL+DiWRmuIHVtp?=
 =?us-ascii?Q?wWCp5hD0Y1L1CnVZbKQiWEuYM1pmNnWg68MwjhY5aLDhi31fSQGbv7gmtP7Q?=
 =?us-ascii?Q?odX1wAGO0DkMbXV6M8MHssJcMvdPHXnAfLBH+e9iODwd6rU9e3w2KlyAcBZ7?=
 =?us-ascii?Q?w8yWV1HYGFMO8UYVRdAA9ruCJnS1gbPVn4DWOgto129LdeKC+cDODaQKslio?=
 =?us-ascii?Q?AfkhvcHbyCxpw5DWpdAmBppePt3rv3VP2yA9kbt9UqRyOEN7TbLv5vI+JAVm?=
 =?us-ascii?Q?cjGocuF/pRDJxv1OP5jkc4ooEGgxHZ4KwckFNi5Z2MgN6rBuBW9gqEs8sDDk?=
 =?us-ascii?Q?M6V1Oy02Rf/7XXpkhV49txlr6MMTaHlogRK4gViPDvM8csqaGiHtGAdHOwCh?=
 =?us-ascii?Q?mWMZyXei1Z52p2m4iCaw9jvtg1pa+WV2QE3k6DuNG8mW8X6RPXgndWKjpcR4?=
 =?us-ascii?Q?OZ5tYbQHzL/HgyNQUr4lNd1hs73CxjtN4B69O3gTyjv84sKpeeOOKklTLvlP?=
 =?us-ascii?Q?GEw6YWQwa4YFdb2fdYQQt4UrNazki7bc9U4j/TpZDT6mGH8dKSrgDKb7x49h?=
 =?us-ascii?Q?8h5Qhb66YUqcalJd3N4sVTnIm89dITCvOEVZSDzeIxcR3MPN6JZhh0nc8JMM?=
 =?us-ascii?Q?LamJzcpW0wGQBYfRUsDPMguG7pG9ioqTdFwzY5yWg669sljB7jeMjLfZvBjl?=
 =?us-ascii?Q?Clx4XwiEA7qJYerftRmc1ENFetSUEb1Q2CSovhDVaHcl5qZdEM2vmwYaUWYI?=
 =?us-ascii?Q?s+2ZvLs6gl471uWmvbiSjaukxOGgp9Nq76McleOQtFZzJAeMiaj4Hfoifokz?=
 =?us-ascii?Q?+RBZJ5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJO4jrTSTx5UL8nvwIMqMltsVaql9qqG8DnUJWbr4IDWabpAV5iFzXfZWyEK?=
 =?us-ascii?Q?trDIuabz7SiqIJok8nEvpSLXS+S6mMSIvIVLzFp6JlJwVRys+d57VGtvwJm7?=
 =?us-ascii?Q?JU9LBV26UjZY2d7w2McOBluFAgnfBNMEoS76fbaSb1JRCs/J8ImtLKT0IYvT?=
 =?us-ascii?Q?DpgpMxraRe+8NkWpWoZ3n3LyNfjta7cVAbSEqYD70QwMwhGW+yD9jMR13vmi?=
 =?us-ascii?Q?QMmeSMhbxDGrj1ltqETAz0Xf1tY/me+wd+z4xwv66FQ7b05lH1wdMWm8R1/O?=
 =?us-ascii?Q?bTBXMmXs54gfQyxfkRQdxzSgYRGqA+5gpUpC3j26dSACd1y/cmmwaKYJodqI?=
 =?us-ascii?Q?u7fEMNCPUJrTNTNBiHNAZ8Vv/g/RfVcA4HIrcWMmRazKWrGPAtGjZNIa+INs?=
 =?us-ascii?Q?G0TtZxl2WnRtRv7SkkzSMUd63FO7dILrZj+M6cTc7mpmcSFO/bZVFZuMgPbg?=
 =?us-ascii?Q?DRmtN9NET+z/PtiFYceoXSN7oeOqItz0D0ecF19MUaB4vm5hIU8F9PDlAJJc?=
 =?us-ascii?Q?N+mG+snGaWujaoclWq9e7lGAyxCyvljEQYxZo++6D7GjwlLHQM2P1UXjlaJZ?=
 =?us-ascii?Q?sIgMacjXjkBsPfLHYfsdsc5bu98yZjP5NAGRli9XGTLFsm1ke2/G5ZArhYSd?=
 =?us-ascii?Q?q82kIgn+nIkmXzPTu6ZtxafwfYIxZZK/j5X9NwMiNg9iMf/odfOURtFJTxyt?=
 =?us-ascii?Q?6nDJcZk3xFOE9UIxbGQ6VU2PmDvb/q0t9pfqMtIgqTfvnkpeX+mVoYY2gGFL?=
 =?us-ascii?Q?hsPwrX1JtpTFM/vp5ZL+7up5/BhhebEj819ri5W4GpWFCscXeGlaNa5+bfI/?=
 =?us-ascii?Q?smxzdHch8SY7MsID8+HO2b5apACmBVHCJCpWEL/QcqTqhiQnNmv+c5+iLeJQ?=
 =?us-ascii?Q?Yk0cfCxrF88LWFUX6SBmpgLOhoiPvxhQrMU340FOhiGSukgtGbeIyHy6RBW7?=
 =?us-ascii?Q?t4kq9f5SXpgvW++j0fwaKA5dFRT1Jten8wJjrdiwXv+UTcD0FOyhdZS/CfFR?=
 =?us-ascii?Q?nkXCxMGSDS3w855Y0qKh0EKXA8eI0EIwPWYAdhVHE1Ha/Jz4vm701+ZudNey?=
 =?us-ascii?Q?ZQ2XgRq5ndxBHe6VNrVTmg9kYImx2/jibM7r3FM1C1D8gDpA/6VmhEtkZhfl?=
 =?us-ascii?Q?SeVPf5jX4mqzUgVY6KEBXdxsTcr/UpgwYQ26XzpyONG+7XbqK/1bJaNv5E6r?=
 =?us-ascii?Q?GsBqYS5/Qy+SPFTQ2MLr9j7D5FwBhOWPvYiIiLqf6L50nYoK7u+1bIHc9wZQ?=
 =?us-ascii?Q?EgUGR4CYDC0v/JC0tXGmwfR3mP1aPWDp2n3f0sy+TYeRjql4lrLe1RJPVY/x?=
 =?us-ascii?Q?JceegABwADPRThs4+5su34ZcqPTnsviIe4SzUnG+OqniuR74++EwotvYjwse?=
 =?us-ascii?Q?n+4jfLE8NmZbXZHgzskXRKyM6cVjNj73bMqkR8+vFVW1/SQ/+9Zt+Qrl3gsP?=
 =?us-ascii?Q?qIZMktH/4A95cg3zKPC6C2Sr4TxlsxXLyuRGndCZCmQneRwUtSMEorP1OwAT?=
 =?us-ascii?Q?AyMswnt8hzImh48DAvErBLulSQvmKRgpD84HHdnvLX0q3u0GZox/UEJOn+05?=
 =?us-ascii?Q?9X5Xnuki0J8ST0i+rOSk6sTrsEihWlzMAhmqKu6D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90038cef-abc4-4d5c-6dcc-08dc96b75be1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:42:24.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6HFHKaAUwhwGGWNm7eKPvVnY+VAxchxRKDs9xixSBK1J6LxC25rEF/xsUpeW8cdPyYmoXo0OvKPSyJqp3XheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10973

Convert device tree binding fsl,ls-scfg-msi to yaml format.

Additional changes:
- Include gic.h and use predefined macro in example.
- Remove label in example.
- Change node name to interrupt-controller in example.
- Fix error in example.
- ls1046a allow 4 irqs, other platform only 1 irq.
- Add $ref: msi-controller.yaml
- Add #msi-cells.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- sort compatible string
- add ref to msi-controller.yaml
- add msi-cells
- add interrupts description
- remove msi-controller, which already in msi-controller.yaml
---
 .../interrupt-controller/fsl,ls-msi.yaml      | 79 +++++++++++++++++++
 .../interrupt-controller/fsl,ls-scfg-msi.txt  | 30 -------
 2 files changed, 79 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
new file mode 100644
index 0000000000000..9ba8d4d73351b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
@@ -0,0 +1,79 @@
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
+      - fsl,ls1012a-msi
+      - fsl,ls1021a-msi
+      - fsl,ls1043a-msi
+      - fsl,ls1043a-v1.1-msi
+      - fsl,ls1046a-msi
+
+  reg:
+    maxItems: 1
+
+  '#msi-cells':
+    const: 1
+
+  interrupts:
+    items:
+      - description: Shared MSI interrupt group 0
+      - description: Shared MSI interrupt group 1
+      - description: Shared MSI interrupt group 2
+      - description: Shared MSI interrupt group 3
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - msi-controller
+  - interrupts
+
+allOf:
+  - $ref: msi-controller.yaml
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    interrupt-controller@1571000 {
+        compatible = "fsl,ls1043a-msi";
+        reg = <0x1571000 0x8>;
+        msi-controller;
+        #msi-cells = <1>;
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



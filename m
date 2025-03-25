Return-Path: <linux-kernel+bounces-575866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE777A70843
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A053B3BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7497525F7B4;
	Tue, 25 Mar 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ipvbmRNb"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11012018.outbound.protection.outlook.com [40.93.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2819E971;
	Tue, 25 Mar 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923916; cv=fail; b=lHruygW4su9z+sXXqiwD+6mPnYu+AE+IhkwOUiW74CYkDZ8qjZQAPUHAmNbd46Vr3LEB4scHxUdO3oe8UO80eF8x3+MWHgIhlfBcx0DoMXyONAh8b2B09UA6fVAGTLJbsiCJuVCDBbW9n2+3CT05zrWUrParR0npyMjYt4Drf/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923916; c=relaxed/simple;
	bh=1OHJy35nowdVJ+aw56W5mUuCJJuErrcXs1RnjVf+kTs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cU97B4cDKhdYOCQJg8+KJEpfxpeNCjoW917/XxZ/BlttYrx7ru4/8uQpaXzKgn/lQhSXGkmtOhEgWCf1Yzvkr1KWOuBIPWKk+WzVCN3k8McNyAw+qWpTxv5zTEwQAqwA87OYggnNGTAfoAsFRiEcaHnvTf+vCIKfjKB+t4Oq94M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ipvbmRNb; arc=fail smtp.client-ip=40.93.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z44rRilSQMqmEZvYLf1KqOpPSavCJ7qNCcniBHUgFQpDOUX3MlgqqNPhixOGJVwml9nnoTRlx+Rs8cUjWc5Lu2Ax7jk9CWWiM//ldEFR4aWqsVqPqh55IJzqap+vd9Kywd+5zyT7n3zfsgJfK71+m9dSuon3AGNBbO4LksEK2g8NHW+tEYEGKCVFVAH/2iWfQdOCe6k4cQYUmn+8rExm+kqpfhG4gDw7jBxtowvqKPW0ltji9hsvk7MwiF7M4yaScT9Gumf5qbb/E42HLdt1AU1uuyEPaBdorys4MYoQ3d4wEQA9oIxjD/D/O7BZHH0XuI6sUo5uOCRqHeXHL4GcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPvpPADYG4eh5Lk2olLFgF2+o1UfNMu1dAT1Ij9UdiU=;
 b=cv2+lO37ZMGZZy+kL+j6OTMBUGOuLn0gvPu7xIvrkdyM9qhYA0DGw9KgignvMPxBbkjBoijyYxbCzld0PoJ8R5bG9YCfcOg5WJ5pBF3jaWC06AF5Tzq8fCfJsVIudfr0hAkWpyzJE0MfKieP+0zULI2oQ9PiynikYYcvA0DR2Qwvj4XcY9y9sZmy6aJJEQmndXCLoLLN92/H+XpJLfxmUVxSwJYQaeTky0Irmb0AUcVYDSFn5OXx50FZoLCO1DyA3063dd0vVaSAXs/GL0CVsW8MeWcPK5uQGq+IysmJ2c3yC0soD1B7CQCvBUqcIvkMyqqe0wursjf+50WxvDn4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPvpPADYG4eh5Lk2olLFgF2+o1UfNMu1dAT1Ij9UdiU=;
 b=ipvbmRNbGVlzm8pPgvGd6lZgeHhzi02nObYT7C4nzsu6PdYCJcVxaoIEYrsaP2eKx8+fRYn6Ex5koqA3p/INOcIppgiRI6RqvUKrwwT1tJfGe0bbxXa4yRb7MbFZVh/fd1ogKplPPqB/pt1vbofoaWPwZUq/vfsd3mdaVxbZhQg78xz5q3Fy94tSPG3VFfiOAxdRat+ykjBcNx3cR61jBSE8nxSEVm+xNZ2mi67XoHxOv2FLc3clq9SOPCyLUJe2JtRFQ4uy0wTjR5Jyh5cUdKKisDDmCKTquCzKl4cOQnatkM4E+i5jJC5czQhbn6eag+Je+ZKnISltqlRifniJeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB5710.namprd03.prod.outlook.com (2603:10b6:a03:2da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:31:50 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 17:31:49 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v3] dt-bindings: edac: altera: socfpga: Convert to YAML
Date: Tue, 25 Mar 2025 10:31:39 -0700
Message-Id: <20250325173139.27634-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::10) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: f981beb4-c871-4318-df21-08dd6bc2ecca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wepUYaslTTh2LzQ1i+ZTSyKcMklBy0tCyT62dURX8rRae2VhcJxJ4gZvyhtj?=
 =?us-ascii?Q?ZGIq5ZOVQ6iTOtWgDV2FpP6l3s6X8yJfxb8nsTXXiIqUn14Rj5Bd3d3i0ToI?=
 =?us-ascii?Q?nqEnsL8KYFatiARYX1EAJ3mJ1FQoih9CORFa3zalcH0kUjzhPjv/AtonrufU?=
 =?us-ascii?Q?YpcigXhLoAA49Bo6Oa0Y1XDKCUqjZKf7i0d0ZzFyKeXaSQWWkyZd0XAaPVAl?=
 =?us-ascii?Q?VrmkMTlQuSVBVXOLsGpB3uEjQtSQqYOWV4sQvN1iP+ffEVrbeDg14BTOPcxE?=
 =?us-ascii?Q?XFdnE8x/H/dcoJnGZ5gTGFTixIaq3ajyBUHyXAZx+E23REZmjy2XUjokFXm2?=
 =?us-ascii?Q?biJqt6wp4YgamSBm2vT/gPLaLXzUFG17IAAEkSciOkH9aIdmHrZ0t4P7rjAa?=
 =?us-ascii?Q?rAQ4Tbuoy4c56c2zKK2cl8QtIe8AbdbON0GIDE2DZVdUfXfncTRAuFtdN/PY?=
 =?us-ascii?Q?qOhhEteGhptMKQRgZIkmK62+aNvHspuSdEhlnVUr8RiiqV0vxUwCGHZ4iaKq?=
 =?us-ascii?Q?LotRNwukZF41avfzJ5ja0sDC3M6wmGd3xNHYDMMK01w7nwWkyvCmjExfYwzw?=
 =?us-ascii?Q?p6DjEJx/X911EqgmpGMiilq1aayvd8H7vrfaXaBZx3d7vkTL7SdratJQkWPq?=
 =?us-ascii?Q?ZNEJyLhmsKuWN9mGoDdQY8aeSZmu2J/uD3nfaJNfkVl8d93qYuJpqwJuE/6m?=
 =?us-ascii?Q?EjmhV7fWK2TQ5JTNs6fuvQ5JAE2uBTpn6nG5SPfrbRTCF2CKDiLWmEPpVtfI?=
 =?us-ascii?Q?WhIjz76G9DA5HbNOqJ8zYgfAqTFhXL7QCE/wca7DrsQlpNcmmYByZNT/V6l0?=
 =?us-ascii?Q?NhBFCbH5FzLyCI8/ly2aOlW6tPO6oH84BqhZbYvjrOQCg6I3jKsDCy92QaLR?=
 =?us-ascii?Q?k9AhlI0dnfvuoBWvWqyfnBvNFCczuXCsKasKd0LMudyx9yJ6E895UWZMFh99?=
 =?us-ascii?Q?JE9SFp8mbqL4zLXgG/K5APKDJfnMg2N8dUj16K9q8QBRYn0iraQDTw9M4Tlw?=
 =?us-ascii?Q?uMbdLT3/PvmPFzWX+aYAGezt3YE2mqITCo4ozaQ9IwX9FGQE+cgfZVlX/GVR?=
 =?us-ascii?Q?l1BfSxQz2VFzIz3PBqoyz4pNrKZ7ueLhnHDl+AHMxonq31+PbgfYgdMGIfHS?=
 =?us-ascii?Q?mVidnBlevofrbZ5fJvPl2n+9GVzCce0/HEqwspt+Py4EdSyZbY3HHBj4Pwbd?=
 =?us-ascii?Q?OyzVucO/2WGRNZnhXOwlavYzZxWXTUx0k60sJK6XnrGODJjJkQ4gVeH5eNqc?=
 =?us-ascii?Q?wwPNRqS74b6XO4qguj8h1NNVp9pc4ig1cElU/Unv6bLqHj8GnlxkJ7mE6jX5?=
 =?us-ascii?Q?x+QN2Fo+WGsKNfixB+W/Urkq/tdPRdzg6M6hfSVB6irnJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpWs0FjqdKNoJJSADGvsjZwcMfRCORoCjwlKHnPvG/lsOAms3X1g5b7d4Qpw?=
 =?us-ascii?Q?GlevjnVLZxLeJsiE6Dk3sw4WyoRWaGfN2iymcHXTvN9fHqPpmv4G9eRIVBz5?=
 =?us-ascii?Q?jbpM0D+se4XBJG41uykvD6ry/57QMDbE+t5EJIovYsNBTjS5n1ExJyVFk+9a?=
 =?us-ascii?Q?gd8HEEnk6NVZ7kt7nwIHQ+R4iXAimbXgqtdX2ywixVz8hOLUhd/Z+yAAXnfz?=
 =?us-ascii?Q?yyZ4WcK0r4Ekoo42zQgnhGZGpnKRTLa6Ehfpe8JmqOJt5m6iAchkDRc6K5/L?=
 =?us-ascii?Q?gHIf96oAdvPe/niQyJRrNtGLUGAahyVSd8cnHsjb93u4sFgWgf9pEwcxjZzj?=
 =?us-ascii?Q?J3Cyb4Ccdo5CbKAIzUD1USqjA3qAq39NUl91O34jOHtU908vof9GLgmsvQNs?=
 =?us-ascii?Q?iaPGHYsPlv67lFPA3cBwsY2l+sL3K82+7uNnW5sq6V6if89jOA9PmU2kfTzH?=
 =?us-ascii?Q?XCjePh1pVBH6J/RUkubzqFKrm0xOISi6My+yw4f/w5u5s0jRHeTigOp9OAtU?=
 =?us-ascii?Q?mAdjxH6hgPFvSvywDVAva+7Jqm0fX9rhg0CDUcvQCMO6YSISltsqFjmzE/Lf?=
 =?us-ascii?Q?05ziMa8Lc05/b1TVRGDekbMqYcPahGGWoNxb+fGFcibXeMgc61uLHuG8pOTc?=
 =?us-ascii?Q?phqy1LP6xIuJtgzj4YVf5phjNJXHm4CAMaajQPvPYYdZGo2fVjNEqJgmnU36?=
 =?us-ascii?Q?YQBNhsHHhgpUG5ig2/gzHXrsgdCZrdd3yjf1Wa/qrjEO9uP8yi4OZydgjy75?=
 =?us-ascii?Q?zFuq91ywATKxYRXPMj14h91+wn8Wr+ZvFgpguDwpm0UMo1I3dkjGeKwvrGVF?=
 =?us-ascii?Q?W4iu5lRbJpuFHMqZo2Yx752aDP8JPYagJNI4jqoGJ7vL9vHHjNAaLsd1WxhM?=
 =?us-ascii?Q?U+xPEfS5wCvuKqVb7mKtOVQexwHtN/hq6Rlot3ldq/OGECRjaZPJ+US0Kdk1?=
 =?us-ascii?Q?xHWjc/6WZg2q8/f0jIDwVmJ3bVYGlHGhgU1fLG6B30aGRR5dAf9/amRd67Uk?=
 =?us-ascii?Q?gYtUYq4x0Gv+BJO4iROEwKaWC+Of4K7Yj0y7sTyIiVIPPfTOeLuKl1lLg/8t?=
 =?us-ascii?Q?pt/xrRQjV95nCdQiLoFFMFFNWPLkiZoFZT4q1fLLleUKxDrDAicEdqYJ5j44?=
 =?us-ascii?Q?ztoPhwPZzODRyA5TItqfXhP8apBn4d0vYDs+ehUlNumJMIFsDt0J1qClN/ap?=
 =?us-ascii?Q?qsHUwugL4vjuR9Xj9Cdu5mo8dhNNykk4IzwxEHvUxcGCzCz0ohEuya2EUqY/?=
 =?us-ascii?Q?ZZPGM1nzApJ3cxJmS0AXj1ImHVO3zNz+XCTnmvhdMeePUELA0u2IX/coTXx9?=
 =?us-ascii?Q?F54exvis0bD6pT1CPXHUEnR2e3/7pxvQA0PQQFFoOxVXie174mZeS0ffsP0L?=
 =?us-ascii?Q?VgJPwRptQ9EciplhiAQjXAVwOt9waT3IVAZWlqXEHFFM0WLv679iEGPEilW9?=
 =?us-ascii?Q?xkS3jdWprZFdup7h6H5tMI8+9DXiwdonvWswWgppxGJzjB0DyrjntutKoz3L?=
 =?us-ascii?Q?C/8M4GDR1F00657DQLkDIsvpnwT4vJtEIy9vLrgmxP2r4Ujmqr2skSFMdxe4?=
 =?us-ascii?Q?bjROnDnreEvFXvX5hC6xVEU0X5dlHABlvUQ6E0itsEeI4o9F3RfXAOELA50M?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f981beb4-c871-4318-df21-08dd6bc2ecca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:31:49.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4SSWkZ5e2OOCEv+VLO/GGjy2/ZdgQVUbkkLLVuypWM6kezDhYIyibejfj5xba2tyv0JBp2AFiInlXkFuNqszhND7VxpeqB9P3Onj9INsCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5710

Convert the device tree bindings for the Altera SoCFPGA ECC
Manager from text to yaml.

Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
v3:
 - Remove redundant $ref and description from compatible entries.
 - Add $ref and description for altr,sysmgr-syscon entry.
 - Fix description of altr,ecc-parent of sdmmca-ecc@ff8c8c00.
 - Successfully validated Cyclone5, Arria5/10, Stratix10, and Agilex.
 - Rename yaml file.

v2:
 - Fix $id: path.
 - Remove unneeded '|'.
 - Move vendor properties last (but before child nodes).
 - Add appropriate blank lines.
 - Don't break ABI.
 - Avoid changing existing DTSI and DTS.
---
 .../edac/altr,socfpga-ecc-manager.yaml        | 323 +++++++++++++++
 .../bindings/edac/socfpga-eccmgr.txt          | 383 ------------------
 MAINTAINERS                                   |   5 +
 3 files changed, 328 insertions(+), 383 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
 delete mode 100644 Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt

diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
new file mode 100644
index 000000000000..ec4634c5fa89
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
@@ -0,0 +1,323 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2025 Altera Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/edac/altr,socfpga-ecc-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera SoCFPGA ECC Manager
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@altera.com>
+
+description:
+  This binding describes the device tree nodes required for the Altera SoCFPGA
+  ECC Manager for the Cyclone5, Arria5, Arria10, Stratix10, and Agilex chip
+  families.
+
+properties:
+
+  compatible:
+    oneOf:
+      - items:
+          - const: altr,socfpga-s10-ecc-manager
+          - const: altr,socfpga-a10-ecc-manager
+      - const: altr,socfpga-a10-ecc-manager
+      - const: altr,socfpga-ecc-manager
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ranges: true
+
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to Stratix10 System Manager Block with the ECC manager registers
+
+  sdramedac:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - altr,sdram-edac-a10
+          - altr,sdram-edac-s10
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      altr,sdr-syscon:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to SDRAM parent
+
+    required:
+      - compatible
+      - interrupts
+      - altr,sdr-syscon
+
+patternProperties:
+  "^ocram-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - const: altr,socfpga-s10-ocram-ecc
+              - const: altr,socfpga-a10-ocram-ecc
+          - const: altr,socfpga-a10-ocram-ecc
+          - const: altr,socfpga-ocram-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      iram:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to OCRAM parent
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to OCRAM parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+
+  "^usb[0-9]-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - const: altr,socfpga-s10-usb-ecc
+              - const: altr,socfpga-usb-ecc
+          - const: altr,socfpga-usb-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to USB parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  "^emac[0-9]-[t,r]x-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - const: altr,socfpga-s10-eth-mac-ecc
+              - const: altr,socfpga-eth-mac-ecc
+          - const: altr,socfpga-eth-mac-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to ethernet parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  "^sdmmc[a-f]-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - const: altr,socfpga-s10-sdmmc-ecc
+              - const: altr,socfpga-sdmmc-ecc
+          - const: altr,socfpga-sdmmc-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        minItems: 2
+        maxItems: 4
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to SD/MMC parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+  "^l2-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        enum:
+          - altr,socfpga-a10-l2-ecc
+          - altr,socfpga-l2-ecc
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 2
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+
+  "^dma-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: altr,socfpga-dma-ecc
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 2
+
+      altr,ecc-parent:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description: phandle to SD/MMC parent
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - altr,ecc-parent
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: altr,socfpga-ecc-manager
+then:
+  required:
+    - compatible
+    - "#address-cells"
+    - "#size-cells"
+    - ranges
+
+else:
+  required:
+    - compatible
+    - "#address-cells"
+    - "#size-cells"
+    - interrupts
+    - interrupt-controller
+    - "#interrupt-cells"
+    - ranges
+    - altr,sysmgr-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    eccmgr {
+        compatible = "altr,socfpga-s10-ecc-manager",
+                     "altr,socfpga-a10-ecc-manager";
+        altr,sysmgr-syscon = <&sysmgr>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        ranges;
+
+        sdramedac {
+            compatible = "altr,sdram-edac-s10";
+            altr,sdr-syscon = <&sdr>;
+            interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        ocram-ecc@ff8cc000 {
+            compatible = "altr,socfpga-s10-ocram-ecc",
+                         "altr,socfpga-a10-ocram-ecc";
+            reg = <0xff8cc000 0x100>;
+            altr,ecc-parent = <&ocram>;
+            interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        usb0-ecc@ff8c4000 {
+            compatible = "altr,socfpga-s10-usb-ecc",
+                         "altr,socfpga-usb-ecc";
+            reg = <0xff8c4000 0x100>;
+            altr,ecc-parent = <&usb0>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-rx-ecc@ff8c0000 {
+            compatible = "altr,socfpga-s10-eth-mac-ecc",
+                         "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0000 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        emac0-tx-ecc@ff8c0400 {
+            compatible = "altr,socfpga-s10-eth-mac-ecc",
+                         "altr,socfpga-eth-mac-ecc";
+            reg = <0xff8c0400 0x100>;
+            altr,ecc-parent = <&gmac0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+        };
+
+        sdmmca-ecc@ff8c8c00 {
+            compatible = "altr,socfpga-s10-sdmmc-ecc",
+                         "altr,socfpga-sdmmc-ecc";
+            reg = <0xff8c8c00 0x100>;
+            altr,ecc-parent = <&mmc>;
+            interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+                         <15 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
deleted file mode 100644
index 8f52206cfd2a..000000000000
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ /dev/null
@@ -1,383 +0,0 @@
-Altera SoCFPGA ECC Manager
-This driver uses the EDAC framework to implement the SOCFPGA ECC Manager.
-The ECC Manager counts and corrects single bit errors and counts/handles
-double bit errors which are uncorrectable.
-
-Cyclone5 and Arria5 ECC Manager
-Required Properties:
-- compatible : Should be "altr,socfpga-ecc-manager"
-- #address-cells: must be 1
-- #size-cells: must be 1
-- ranges : standard definition, should translate from local addresses
-
-Subcomponents:
-
-L2 Cache ECC
-Required Properties:
-- compatible : Should be "altr,socfpga-l2-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt. Note the rising edge type.
-
-On Chip RAM ECC
-Required Properties:
-- compatible : Should be "altr,socfpga-ocram-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- iram : phandle to On-Chip RAM definition.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt. Note the rising edge type.
-
-Example:
-
-	eccmgr: eccmgr@ffd08140 {
-		compatible = "altr,socfpga-ecc-manager";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		l2-ecc@ffd08140 {
-			compatible = "altr,socfpga-l2-ecc";
-			reg = <0xffd08140 0x4>;
-			interrupts = <0 36 1>, <0 37 1>;
-		};
-
-		ocram-ecc@ffd08144 {
-			compatible = "altr,socfpga-ocram-ecc";
-			reg = <0xffd08144 0x4>;
-			iram = <&ocram>;
-			interrupts = <0 178 1>, <0 179 1>;
-		};
-	};
-
-Arria10 SoCFPGA ECC Manager
-The Arria10 SoC ECC Manager handles the IRQs for each peripheral
-in a shared register instead of individual IRQs like the Cyclone5
-and Arria5. Therefore the device tree is different as well.
-
-Required Properties:
-- compatible : Should be "altr,socfpga-a10-ecc-manager"
-- altr,sysgr-syscon : phandle to Arria10 System Manager Block
-	containing the ECC manager registers.
-- #address-cells: must be 1
-- #size-cells: must be 1
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt.
-- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
-- #interrupt-cells : must be set to 2.
-- ranges : standard definition, should translate from local addresses
-
-Subcomponents:
-
-L2 Cache ECC
-Required Properties:
-- compatible : Should be "altr,socfpga-a10-l2-ecc"
-- reg : Address and size for ECC error interrupt clear registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-On-Chip RAM ECC
-Required Properties:
-- compatible : Should be "altr,socfpga-a10-ocram-ecc"
-- reg        : Address and size for ECC block registers.
-- interrupts : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-Ethernet FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-eth-mac-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent Ethernet node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-NAND FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-nand-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent NAND node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-DMA FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-dma-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent DMA node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-USB FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-usb-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent USB node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-QSPI FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-qspi-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent QSPI node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order.
-
-SDMMC FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-sdmmc-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent SD/MMC node.
-- interrupts      : Should be single bit error interrupt, then double bit error
-	interrupt, in this order for port A, and then single bit error interrupt,
-	then double bit error interrupt in this order for port B.
-
-Example:
-
-	eccmgr: eccmgr@ffd06000 {
-		compatible = "altr,socfpga-a10-ecc-manager";
-		altr,sysmgr-syscon = <&sysmgr>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 0 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ranges;
-
-		l2-ecc@ffd06010 {
-			compatible = "altr,socfpga-a10-l2-ecc";
-			reg = <0xffd06010 0x4>;
-			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
-				     <32 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		ocram-ecc@ff8c3000 {
-			compatible = "altr,socfpga-a10-ocram-ecc";
-			reg = <0xff8c3000 0x90>;
-			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>,
-				     <33 IRQ_TYPE_LEVEL_HIGH> ;
-		};
-
-		emac0-rx-ecc@ff8c0800 {
-			compatible = "altr,socfpga-eth-mac-ecc";
-			reg = <0xff8c0800 0x400>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>,
-				     <36 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-tx-ecc@ff8c0c00 {
-			compatible = "altr,socfpga-eth-mac-ecc";
-			reg = <0xff8c0c00 0x400>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>,
-				     <37 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-buf-ecc@ff8c2000 {
-			compatible = "altr,socfpga-nand-ecc";
-			reg = <0xff8c2000 0x400>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>,
-				     <43 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-rd-ecc@ff8c2400 {
-			compatible = "altr,socfpga-nand-ecc";
-			reg = <0xff8c2400 0x400>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>,
-				     <45 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-wr-ecc@ff8c2800 {
-			compatible = "altr,socfpga-nand-ecc";
-			reg = <0xff8c2800 0x400>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
-				     <44 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		dma-ecc@ff8c8000 {
-			compatible = "altr,socfpga-dma-ecc";
-			reg = <0xff8c8000 0x400>;
-			altr,ecc-parent = <&pdma>;
-			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
-				     <42 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb0-ecc@ff8c8800 {
-			compatible = "altr,socfpga-usb-ecc";
-			reg = <0xff8c8800 0x400>;
-			altr,ecc-parent = <&usb0>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
-				     <34 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		qspi-ecc@ff8c8400 {
-			compatible = "altr,socfpga-qspi-ecc";
-			reg = <0xff8c8400 0x400>;
-			altr,ecc-parent = <&qspi>;
-			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-				     <46 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		sdmmc-ecc@ff8c2c00 {
-			compatible = "altr,socfpga-sdmmc-ecc";
-			reg = <0xff8c2c00 0x400>;
-			altr,ecc-parent = <&mmc>;
-			interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
-				     <47 IRQ_TYPE_LEVEL_HIGH>,
-				     <16 IRQ_TYPE_LEVEL_HIGH>,
-				     <48 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-Stratix10 SoCFPGA ECC Manager (ARM64)
-The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
-in a shared register similar to the Arria10. However, Stratix10 ECC
-requires access to registers that can only be read from Secure Monitor
-with SMC calls. Therefore the device tree is slightly different. Note
-that only 1 interrupt is sent in Stratix10 because the double bit errors
-are treated as SErrors in ARM64 instead of IRQs in ARM32.
-
-Required Properties:
-- compatible : Should be "altr,socfpga-s10-ecc-manager"
-- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
-	              containing the ECC manager registers.
-- interrupts : Should be single bit error interrupt.
-- interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
-- #interrupt-cells : must be set to 2.
-- #address-cells: must be 1
-- #size-cells: must be 1
-- ranges : standard definition, should translate from local addresses
-
-Subcomponents:
-
-SDRAM ECC
-Required Properties:
-- compatible : Should be "altr,sdram-edac-s10"
-- interrupts : Should be single bit error interrupt.
-
-On-Chip RAM ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent OCRAM node.
-- interrupts      : Should be single bit error interrupt.
-
-Ethernet FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent Ethernet node.
-- interrupts      : Should be single bit error interrupt.
-
-NAND FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-nand-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent NAND node.
-- interrupts      : Should be single bit error interrupt.
-
-DMA FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-dma-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent DMA node.
-- interrupts      : Should be single bit error interrupt.
-
-USB FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-usb-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent USB node.
-- interrupts      : Should be single bit error interrupt.
-
-SDMMC FIFO ECC
-Required Properties:
-- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
-- reg             : Address and size for ECC block registers.
-- altr,ecc-parent : phandle to parent SD/MMC node.
-- interrupts      : Should be single bit error interrupt for port A
-		    and then single bit error interrupt for port B.
-
-Example:
-
-	eccmgr {
-		compatible = "altr,socfpga-s10-ecc-manager";
-		altr,sysmgr-syscon = <&sysmgr>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupts = <0 15 4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		ranges;
-
-		sdramedac {
-			compatible = "altr,sdram-edac-s10";
-			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		ocram-ecc@ff8cc000 {
-			compatible = "altr,socfpga-s10-ocram-ecc";
-			reg = <ff8cc000 0x100>;
-			altr,ecc-parent = <&ocram>;
-			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-rx-ecc@ff8c0000 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0000 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		emac0-tx-ecc@ff8c0400 {
-			compatible = "altr,socfpga-s10-eth-mac-ecc";
-			reg = <0xff8c0400 0x100>;
-			altr,ecc-parent = <&gmac0>;
-			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
-		};
-
-		nand-buf-ecc@ff8c8000 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8000 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-rd-ecc@ff8c8400 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8400 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		nand-wr-ecc@ff8c8800 {
-			compatible = "altr,socfpga-s10-nand-ecc";
-			reg = <0xff8c8800 0x100>;
-			altr,ecc-parent = <&nand>;
-			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		dma-ecc@ff8c9000 {
-			compatible = "altr,socfpga-s10-dma-ecc";
-			reg = <0xff8c9000 0x100>;
-			altr,ecc-parent = <&pdma>;
-			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
-
-		usb0-ecc@ff8c4000 {
-			compatible = "altr,socfpga-s10-usb-ecc";
-			reg = <0xff8c4000 0x100>;
-			altr,ecc-parent = <&usb0>;
-			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		sdmmc-ecc@ff8c8c00 {
-			compatible = "altr,socfpga-s10-sdmmc-ecc";
-			reg = <0xff8c8c00 0x100>;
-			altr,ecc-parent = <&mmc>;
-			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-				     <15 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a9b8fa5f032..13c62ec3dc89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3192,6 +3192,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
 
+ARM/SOCFPGA EDAC BINDINGS
+M:	Matthew Gerlach <matthew.gerlach@altera.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
+
 ARM/SOCFPGA EDAC SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
-- 
2.35.3



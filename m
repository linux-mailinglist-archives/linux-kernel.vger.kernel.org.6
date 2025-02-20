Return-Path: <linux-kernel+bounces-523200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C36A3D373
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C8016F391
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423F1EEA57;
	Thu, 20 Feb 2025 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="SLfvUGBK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2099.outbound.protection.outlook.com [40.107.215.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759651EBFF8;
	Thu, 20 Feb 2025 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040831; cv=fail; b=q0fwHv0C9Xwn/oA+GjKL94JJavhs/oGT9bS24RlsdfdqAr5PEyuvY/rUjBdxzy24H4XyEMjNFlc1IgQ+KxPx/6L5SOigctQT4q50QTz8c4FdWuyEH7F7McWelf3TVQ71a0lna44kqFnxwxvI5kmAO6gdc3Ig18SAyfJcfazJHuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040831; c=relaxed/simple;
	bh=/zYbKBEOMgFk4uFTWtbPqTsxqT98uTi/ovxlRc/uLRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIj7fyKIuqaE7Zcg0m+U2+s7yjsMRZnREiCT6xuW/SJc5v6uv3TR36WAWgvTTcV8MBnnIqJH9E93VAWAVeFwe1qQBRuBD1vZuI8i1lX9tFn9gbI9AfrsC42EnAPwxyVQSnqbb6uuOvD9YNMJxIl6iaj/WXV2sDVJfKqN+c87EOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=SLfvUGBK; arc=fail smtp.client-ip=40.107.215.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0iGCZE4/qVMrYSFvR1YUSv8b8TEK3LyzWYcG9g8se2b8QUTpdURVOwQ7HLutIV1ZuYlZda/k31R3mr47OlTw/ai9BZlIg5syWWB+S8CnUnbifSbIgCVwOO4Qj4nd6iWKkJZcbbizJPGiGAXm8iG7tIQgCrVBSaiJtpSAS9Khbwiq/8o/fyywRjJRRRllNJyCKGxbrqcF3sntDoT80pekViz9JJuCGJSPr50kitGyR0HTeizF+VrmCUH+5Wd5O2jk7cZ5NtW2eEFo6wwxbVRe30jZ1C90iCxpVlyD6MdDMyNhs2szxYkmB7yvoanAAFGiK5uHAdEFBGpplwUIMVSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWgEbr/VBooNYfdqmVxEjKuCQHBMTXKKYXtYF+yj5mE=;
 b=SlMaHglj0pdV+CsrvveGz+EU6obJV0kuwWHcDinmMeYGflGa8UnP1N8Q44b/sNVZJ3hsvq3CjhK2cFDcCS9xtBRS5w5I7xSEpYK3RmKpjwE2Ir1m6PZSoPxwktCoApYGEs3IRHM5J9Hq8ygeXXWRiQWAuhM1wNCE41NHAaYZpXKK8px66AM7UMvgih25MVFePdFdkn7tU/dO03y0dJ2r7B/LPkGIsG6/+boOqzxNoXF63XXtaGp7yzxJB0CbvpeGHWp9LIaK/qLWsB3B3V5h9NOqDm3ZJ8x69qRNunNPYOLQoFvZNF5gLuW/YMfAVQLJur8U7mULYvuiBFCQlq9jXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWgEbr/VBooNYfdqmVxEjKuCQHBMTXKKYXtYF+yj5mE=;
 b=SLfvUGBKwv49i/Rr2wfwfQhcJg6z+u/4K2eivnIVp8+DXv2IRvhbgaISb26A8bX3rhzP8UrAvkkp2IR3jp/ZZhTK/V974ivuYw1N8s68YmdIGfIfZEjctA95460plZCoYYv2+GUKhzno0tDOpIafnukjRYtTIznCnqMsYNyK3T3ak75HKA+zkDhd3DlQ/i0E1/eqON2A6hRn7Al+cJQKbV3srvisSjkb5DjfPwhGZYRJNR//XkC69ob9VghekFvi1U92wL2D35bfRT7BzwoShaT7vOgagYtq6SnjVtD651EyS//6le+swJrj5bzm660KtErPWNtOpI5Xm8k2AV3Cdw==
Received: from SG2PR02CA0041.apcprd02.prod.outlook.com (2603:1096:3:18::29) by
 OSQPR06MB7230.apcprd06.prod.outlook.com (2603:1096:604:290::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 08:40:23 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::79) by SG2PR02CA0041.outlook.office365.com
 (2603:1096:3:18::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:40:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 7462F41C0A02;
	Thu, 20 Feb 2025 16:40:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH 1/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Date: Thu, 20 Feb 2025 16:40:15 +0800
Message-Id: <20250220084020.628704-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|OSQPR06MB7230:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7861cb90-92eb-4517-6323-08dd518a3636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XBD0wPcDayOpwygVh5RraGGTFPdtmunmz7+AGeIY+nc1ITX0WvmTE8uiSXcv?=
 =?us-ascii?Q?PGCCSdzGXMwHZyox/pK8ayx6XJ9upo6wv4VumRCqJw8gcJ71kDKEprb/y4AR?=
 =?us-ascii?Q?jZx4jN8gHHx1EB7xnmRy0jgBlHKbVCk/DDf+qwRpdJwCVg4SbHMW+4A4w1ZU?=
 =?us-ascii?Q?UKMiJCmKQa91biejR40+vMUaiEk2rGuAypI6P7ARr3Nqf2lfqYNmGtrCsA2U?=
 =?us-ascii?Q?4AIBD8GtkfV3qsjmDOESA6Pvl6b7ItlABkJQ6Quw/YBKMl8t+nB3reRNy6Ab?=
 =?us-ascii?Q?D+2bP4Zg1tmKmZn+NJZa9ZoCAcsjSC0rOam3PGkH4u3RJhiY75zP1wDA3tVs?=
 =?us-ascii?Q?2Ttw6nHi3H9fxX8rnJ6rLY962j2+rt31H+k8KiAxobVCCD4/pzWUQkuFZhfw?=
 =?us-ascii?Q?N0AUKkY2MJAI/LyhI859EwIdshx9aHtmo2gHTKuObGICzyynZEhuo/xmPZ3q?=
 =?us-ascii?Q?IVE66lWZwwinqo89YVPAVeVInb/ALXxphZc74VCPI4CzXS672E2EDp2VXbFA?=
 =?us-ascii?Q?H48a4hYBP6QLBTEAFNoaecS6kzGxpFWWmKDGa30IT6hBNuVx8ypm6K+JeBaA?=
 =?us-ascii?Q?q7nN/hisY9lkc+EuV3JdtLnap6WGA6/aNkFYcRo+yjpW6yZpcIsxrwji9kp0?=
 =?us-ascii?Q?fLnsqdahLnzYz0SV1QoonE2IXD8rQr1zd9Jy4uqfuxjDr8DNdILXmxy49fTM?=
 =?us-ascii?Q?1R1pWW/uNQGCWnlNKuvQs48V2efaWn4KqYsYS2kH+bryvHxm4DCbcxJ23FVY?=
 =?us-ascii?Q?WwfVllByEFKuDxZSYTffOFjap+VRSOHPMvVchYO9ECVw90pDvECI0TwT5TuD?=
 =?us-ascii?Q?qFkwhWJL/rLOhpJwMg9LgNdeZuYB2emnqRHofsNMI/IGZDZe4m3IreA54wpS?=
 =?us-ascii?Q?nQF6rKOw86EwuO29/8x9X2oVBxDMfz4p5e0gruJ605K9XCDIITgX6lpDv89M?=
 =?us-ascii?Q?S99/yEEREieugvB9m7Oq4mEyR75U/Grn9gbnRRTviDGsZeJU9JkoLLJnktQR?=
 =?us-ascii?Q?ogwyBoXSjrhXCyoGdB2lh2pi2Zn9e3C+Mjr4C+HNsDdnR/Wa7mtIFSVCQLP1?=
 =?us-ascii?Q?KLwxlUpRMB/xozojKdNOkZkqHGpOSFh4cpMmJECdg2b8znkvHwLyGuLRhO85?=
 =?us-ascii?Q?nf8G4uXMVuP+MMsIdUDeJ6KtxWOJXQ+2iVWFMpCiQFk6LZ+UDMBFjdaiWw1L?=
 =?us-ascii?Q?ZVeVp1LuYYuxFv0dJWRTA0gpwAOllhDBpNWucXNBZmynV8U0TBXk4+tdeTXU?=
 =?us-ascii?Q?GNBGHjR+CUEuULEErMQVVhlymg6YqUahrwoOPYOxolHGuS9hp1u20+hyLzhw?=
 =?us-ascii?Q?RFxx4wxrNkxmDJxpFPouBo1t7kdZdFkoRNKZMQFv4EWkk0UaXBtlOw0KLZU3?=
 =?us-ascii?Q?zP6mVyjs9C/rNOmvuQ0GjcasN2sXYHoiD6cIK5rhu6tepfYFUUBld1pWhhZr?=
 =?us-ascii?Q?L9GfvBp8/4k=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:40:21.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7861cb90-92eb-4517-6323-08dd518a3636
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7230

Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
it consists several SoC models like CP8180, CD8180, etc.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 .../devicetree/bindings/arm/cix.yaml          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml

diff --git a/Documentation/devicetree/bindings/arm/cix.yaml b/Documentation/devicetree/bindings/arm/cix.yaml
new file mode 100644
index 000000000000..114dab4bc4d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cix.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX platforms
+
+maintainers:
+  - Peter Chen <peter.chen@cixtech.com>
+  - Fugang Duan <fugang.duan@cixtech.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Radxa Orion O6
+        items:
+          - const: radxa,orion-o6
+          - const: cix,sky1
+
+additionalProperties: true
+
+...
-- 
2.25.1



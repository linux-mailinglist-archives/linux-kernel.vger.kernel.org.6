Return-Path: <linux-kernel+bounces-532780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6ACA45224
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CB1189C437
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE418DB12;
	Wed, 26 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="V1452WWI"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2110.outbound.protection.outlook.com [40.107.215.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55189154BF0;
	Wed, 26 Feb 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532905; cv=fail; b=Qmxy0Tk+E2aT61qpAqx69r2/aHG++sB/3+N4kdHQZin1N4FCnwrDN4FN/Yf5N66PA9x8BSl/PRFHno5ZbQxmY6ttnyhBjeLO7Uvkp+dd8x18WkqlzycBc+cXemafWlRlgJgf6QpEZpIM/pfzuB613Zea5ns8roVyJP5BMBasR0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532905; c=relaxed/simple;
	bh=/zYbKBEOMgFk4uFTWtbPqTsxqT98uTi/ovxlRc/uLRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPwihZNFP9iYzThkwKxoJnRVYjJYNTlKd1VVOSikVdc/nHGJv23nKZohvUqnuOILKEZL5mnfAPrBTAcHJgz5Zlf8VWplAajNDqm7jts3d0nGmmyvX2LpSk9BUO0cmONUwl3m5Z/cQvSoxnfWsbXBQ3yLNIyp4bSspNxo5NGt0+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=V1452WWI; arc=fail smtp.client-ip=40.107.215.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYaawxfCyUcpTG3El/vAEBemPeiedF9PzQDBSiFxaq8POy8OHlOqFakGnCppQyvn4VuztEQ5qMAstrUdaPSiptURBQavruWJboEITSUJUVr8+B8pJU/UlLR2DccP+U9jG1x60WCCy+lRZ2pbM3KW7VnZzMqS1I8JJGxXyRXCapPCSB65Ro9fsgSkOESqorOXeRqpJkFbcQe+fVTOW1ko8fyMF4Wh/D8mVI4zNbJ8y2jIgFhOfW4jFBBS41QEIqUYMlVbCZ4gv9YyzH095ZggITh/kXwwc4g1NiU5okgntfa/6Zvb3a3EmkLU0viTcdjeARAzpA0SJDYY9PizlOZvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWgEbr/VBooNYfdqmVxEjKuCQHBMTXKKYXtYF+yj5mE=;
 b=JF4pGePK9qH2bD0hHAJpQUFYjvveaUfW6/IcyKcNoV4yIB4E3lze5eq0jzXN26q+vNenvv3WeleSKEfD4qA8tyZGTMgqhNAQY5cBidvgBfFj6aE7sGHgnfFk5R4XyU3CzVkr2MEvGyHpWE3d4WFGaEDMdMg3H4Rdjnq9W8w2/7zg9AUNk/YQoq6ehxf6p4wa9qE5WSagXR9D9lttH/Fr5EuNS8Q5WHoVaSV3HyuQRUQ3gcjZf3ORU4/jFjMGt6fZXf3m+/lvAEL5emqwdzvKmR6yuNrMYI49HQ3pVud+VYiYgbl/6xaXkoeklSetMMBUBu4LL22ZXdQjQODlaXy+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWgEbr/VBooNYfdqmVxEjKuCQHBMTXKKYXtYF+yj5mE=;
 b=V1452WWIvzzICvnyHpQot/WAjUeDP5YXuJljW+GPKWZoHOg4mENnyhgJvaWN1w6SigzYLPbU1/7Izgyu8ro9XjqDfZtacfUnLDs7eL/hHPo89PUyIaCPBATnneQKL+XZecU5ZlQ762LhQ1dAsCPC+wFfk1hN4pdyUG2iOrdML69GEkhs+BUYGyjLWVoBP/v4JgUHgF6pnWtfYZaEptxSfCohZOy9rnq9ZA2kCZ+oeMFXAJGSCUC1ggv74VXgQqo7rWODdzwr9ebUSvXuW/RiRALJUqkMz7+fWavE7S7tU/atF6IuEzG5dL30VRyW+Mu+LQUg7J+Pe+08pWcztCHEQw==
Received: from SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) by TYZPR06MB5396.apcprd06.prod.outlook.com
 (2603:1096:400:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 01:21:38 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:192:cafe::fe) by SI2PR01CA0027.outlook.office365.com
 (2603:1096:4:192::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 01:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 705C241604F7;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
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
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Date: Wed, 26 Feb 2025 09:21:32 +0800
Message-Id: <20250226012136.854614-3-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TYZPR06MB5396:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1842e245-bcf8-43b4-a536-08dd5603ea5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tRP7nxARA9PgBMheI9AWpnmcC9b8zDlvX4Tgm3jUFri/8QBO9CVId5BA1bTk?=
 =?us-ascii?Q?ZLf77g5ppBEFB0Wj5jnHs6EWlr2LHn7h8pxRGQceAdRyM9ZaCBtw9jrbtE4+?=
 =?us-ascii?Q?XqiFkSkHCWhbSieMYigVB66i4/ZEA5RjQGbwK/vrmVWsjH6aAyRSAMgJkpgi?=
 =?us-ascii?Q?d2L3Ft132p3mSwfCul66du/L87LcLi+7YhkAHZC8Hgo8k65cYGWCC/S42aAW?=
 =?us-ascii?Q?z3oIZxS7o6Eh227krMkUevqq3l2jQ92tklkp/k/0C2k4F3u4xXX5jN05EGzx?=
 =?us-ascii?Q?UkCL45RQBQSPf9PWz90GiqxxR/dStmLeRDe6U38HhMi9D2fk14uTu0o2TZ7k?=
 =?us-ascii?Q?YCGVQv9Zd02CMsi6x+pN63KAD9zo+ksYr/na93XvBNf4b1EtaHa7TpwKs+jJ?=
 =?us-ascii?Q?JAlPJYYpB1su06YQbMsVjvV6JJFajkOGoqXBbh3e6mrG1OQxGSZ8+oquwJYc?=
 =?us-ascii?Q?4A8HMS1Awa3numYnApzXWs2DEYmaSOietCcGeDYT2ggH/RU5SDTX77DAudZr?=
 =?us-ascii?Q?0KCgVTMIuLaTyuBkqUZZ5siKa6zCxpB/VoJtRTNHVQadDuQ0rIKDDs8lNXv7?=
 =?us-ascii?Q?iFD0stoxyHNMAwO3QYi3POsC2qEN0oUIvtFP23aKU+yWYWa0TESKXt66ctAe?=
 =?us-ascii?Q?rDrK0iuW2l3BT+ybSUZLwz+PK3s+aGr5dZSPyDvwvQc+v/PhzmBvd6Bb+irx?=
 =?us-ascii?Q?005u7P5lNPYkbqMpxJieJjl4Kyp+87/yMq3XYQIv2LCrxL/9ozLC/mugv8cg?=
 =?us-ascii?Q?HUTDWh/RqcCvA504F4z50PU3bU6epfKt77dp0rnjw1/qGcrqcdFCr053nLvR?=
 =?us-ascii?Q?LUmgXG3Opl9+zXBvwz1/oQA0FxvY+/EepnsrngWZ6ucW9JqUgIrHnDh8as/o?=
 =?us-ascii?Q?MHbGAlr2ukLedMjg200pZnX3ntSipPnyAfEzw/QsAv0q9bJ/55iKlmKBmjex?=
 =?us-ascii?Q?KJSSqFSxOHl0HmP98Tck9dRoEJNBg5nXaPT0CPJjnBtOgrMwbw2Li44YfmOC?=
 =?us-ascii?Q?SX3fk07yQjg9TdmCOLnGsVv9Nlv0r6kRDc94NzcGcEn8NckSYw3P6e2OhBIl?=
 =?us-ascii?Q?NgauUsTTK8oQJQqpXi3NyNHKtnAGi0iCFaY7KmMRC9bolK47FcsjMrQYGE60?=
 =?us-ascii?Q?rZL4bySK0gumYFo6XQXYTrIgmcywejwSMowxY+mlHfMqM31G2BPOG0gQGZK6?=
 =?us-ascii?Q?Ohym4AwupZkiuzmu3amG2vueItIKIMNytNXxRWUhmpChjbW1bc7/ZNS7tQAa?=
 =?us-ascii?Q?DF7k3v/cB/eimntYzKcpS//mVvu3BOKWxjd5DyRZFuCZDweQbk2ExC/FQbBr?=
 =?us-ascii?Q?DiZUS20n8a1nU1QXnsbhs+0wYwYNGrizJTgh0bdIWU6/TAr9/ulWy8rBZlZV?=
 =?us-ascii?Q?MDVGcs/MT6PO8+49AUVCcKKJB+wzw7x9I05jN/3S85Gofz8YVkeCGONovXCZ?=
 =?us-ascii?Q?J0Ao65rVaSSf9/TLsgFKI69b2RUTyCqs?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:37.1524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842e245-bcf8-43b4-a536-08dd5603ea5b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5396

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



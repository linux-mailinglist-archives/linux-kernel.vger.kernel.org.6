Return-Path: <linux-kernel+bounces-331151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2E97A930
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844F2B2B317
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4C161320;
	Mon, 16 Sep 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sh6xVLDf"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011039.outbound.protection.outlook.com [52.103.64.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26A15DBC1;
	Mon, 16 Sep 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525431; cv=fail; b=i3JEPAhe/GbPcIZ46Zrw525XUWkQdLU4yi+uq/BKWqiZdCWUNo9PK9h0bjS+Khe3DeHwNBhz8HYkSuy/KbwNW4BnELt7ykuU4mkA7ypjCLijkNV1dD2wMhAYAcGrB3/FimRPnFvZUHmyTQbBe/IriGd8YBPsPzup+tAzJot2QxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525431; c=relaxed/simple;
	bh=THzAA/Q430eZBXidVwDrfobY7ncDfasvk9C+IjW/RCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBHrv1ZmSAXcbFPq/uTcPJXW2rINK+DJkRzuTpfxCQbhXeQE9fdNBHuoJiWPlc205nma+ZlEATOeGx5sP8e2B/T1uFN6kEXW9zLMWIIsrbV3ah7NyT+LZ1u/Um7+QQhdu3AKjljLdTJ2RGqYdmEcXqqAU32GpM2ZTIcdtwVakXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sh6xVLDf; arc=fail smtp.client-ip=52.103.64.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+63S1LuA7VB4GXQcVqqeyU/+G/mkz34fep4czgdDEt/kyRiX4AE9K/5nVuhu61LCwGHZO/TT73kDukiCp53eoxS2qNrSep2vV0U5X6fZGjAfiKLxUZvOWxmaOprlWsWmglKCRzqllDOS65MT3AoclLhf4YjbYsAa1oWEnwBHniCZRePOgzGWiIFzA3apyzPkHPzX4UnGW7POTTLJNKF8pt49cM8eXH+JdTzo89aKI822krdZq8ksqOz4pZqetFMSud4dz/2lcoiWH/gAFMRtp7AHyrXQ9oVPVxYuD8dpS1vNH3reXX8+/ig7eBPkQHkj4es6Cd3PY+Woh/sgaInqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HecDGukPMqzi2UJhrVP/Vl13GybGfSaMZ+bzSKTnqlA=;
 b=yY1r/CrnN7mt+WVei6JWR3mf0Q6zvnoPEHVmK5/Qoy0/sWdMA9UuJpULI/kN8wPvv4AbyDH0+bUTBnMMkSu2hEf4m37QGRi9N+j93dKCAqp/bJ/ZJ5LPTbU0W3mfdNM0YMIal7BT2lRsKsvnG8B1ouYn3GMiHJdCRoD5dVPKgxPdH3GphG1b7YaSvlNVXClO5hFZVG7qTLUSFrFeD9ZtY9rqBX1WVsfWoCS/1dmVhtc7mC9z2rCgWXQJaIJj0IHYrw0fUzTqzfMe57iNXGKIx21LuFbRFe2ZLWQ+XLh1tIO7O4kTZTSEfFXW5iT/QyhtiCaGb2LrVl65Ja89P7GpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HecDGukPMqzi2UJhrVP/Vl13GybGfSaMZ+bzSKTnqlA=;
 b=sh6xVLDfmUMjATUvak5ol7+IVqKboeflw1RTQOJpaeQGDiWdA0OhHmlyC3PqiqPNSOxThvXjELiIUAK3Peh3KRGLKCpf+J5vKBkhs9cHe/Nbtir2SOUWGq0pNKj2UZAwNIzncl8Rn9xWnBjh/EK3ZjstIkVPOpKqcSFx+Zfr/KDIjnbjWbKgy/BEqSH2dUtfqnK8u63LnWVZc4zR9Y8DeTVXDAKJY3gVqf8644OG1xvw8yQNxKlSEhrWhHxiLLs4laZgiUKm9eCOp4zMlsyzUjxX8sgFGNIrwhc2SrY7wdJunDJYpm2xs5zRQdN9d1djK6VxHoXlEHCzS1p67aYlmg==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4847.apcprd01.prod.exchangelabs.com
 (2603:1096:400:285::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 22:23:44 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:23:44 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH v2 2/3] dt-bindings: clock: spacemit: Add clock controllers of Spacemit K1 SoC
Date: Mon, 16 Sep 2024 22:23:09 +0000
Message-ID:
 <SEYPR01MB4221BDC11EE244C7D70C229DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240916222309.43259-3-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f01223e-54c0-4722-d46d-08dcd69e39b2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|37102599003|19110799003|5072599009|461199028|8060799006|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	dR1b9ACoW2am3228tuJPPJu3/VfQT+s5gGW7SIHJAScCI8B/hdO7dNzddqEyYS1qbjJYsFTYqoYSPIdFM5fs1TG7f08+t3eAhJAiVPNsII4O6vPylxjs9LU0QknhyROrKM47TkiBfU+zbLzEkps93woRhSZ+Y2y+Z+ln1E3CfCmC2kXo/+Q6crvu6Ts6A7sFa6eFj2Qpy4gaNZWKRik6/hy9q7/z3xerCxpZSvaMKKv/bfc2eyLLi4+fD3V8AAOvLxbyoDipb+GSFiv3VDHftxjdmbK8S0Vnszhn4Xvb+/J6r6q1Tra+XvAPokXUU3wgnJGXQDTJsD0Lf8Br1hq1PiLKTV7q9MmhVmwNwmCznEcDcuusc7ws3azsuj+HVnOPAnssipaRcExeVFfnWYHClKCFNsoZLxycJYWOa9/K2b3EXsd9m89Up6/7oH9oWgo+LoobPVCS+xK5ReUWCleehf1It/wCJG+Yj81gvQe+Eg5qxwfupR0tvSh+uBE5i3VNX9M3ACXZllTK3uRfnMqpshD32oISufJXmu1BxTfi9eKZNq+q7boX0N35Ki1bHWvqI1WwHwb47ElkkSqtD0dvVWKXoK1PeHhvzg3EM8lbqID8yGFevrjOiSSk5/gTuMU321q1AQ6z3qF6/FxG2rKnbVLAfP4f6YJOb9UYMGiY7JOXM2gYXpHjDWiBLqBImf6p0eFE2UJ6SD4XPX73HjVxwGeH8XnaMZvNW+uDyh8UP9X8cjuA2mHXL3bnfMOmw3bY36Z6Htuxp9L/qwvyrgOFCczCodtYqRVPSAQyV7vc0mjwiGE4rYPM9igCnSFE/E3pxV61afFqcI3euaMSE3t+p7tby0Y1KPeto0Lr5txSTMktCUbPTJP9qlNXdNRs2bUQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XaNFv7ZfwgSzGXSClWfY8ZqCCOEAFOF7tS0kPxTZM+oG0HBfz0SnU8o7zt6/?=
 =?us-ascii?Q?AiFPy7LHyKLPUJlvWriF8YGn4thr6k4vl+IJJ5EbIFbCo5rtz1uvW5Ehs0Jb?=
 =?us-ascii?Q?+ULaHKghd9d+O22ATqSDVMdK508rbVGt51+9WfIiM/fv1LeRbNoQeBXlwgWz?=
 =?us-ascii?Q?pRA6jevH5VXyPOO9XmyK7qeUlyZFJkEHFMMiBL7ZfNqvWE3Wf0SM3k24foKx?=
 =?us-ascii?Q?g3tp77hdMA71LiGiTsfmBtkectaQuFl+PPWoRfnx0CD1btUWn1W5/WBDSoPH?=
 =?us-ascii?Q?E2UbqXZQFhqZsJPRLQv6GIfOcTHdoSdFCX0rKjpczObLcVRXuEEgftTvmlqs?=
 =?us-ascii?Q?2YxAQGxwTadCugfl5H86LuE6gM2bDSGt7VvvZT8cj7cnEodP/+E+iwT53RMh?=
 =?us-ascii?Q?QbOm1kDPnYVGOaTmn2KwkBeyh0uubWkwsjDy9Prfd4I/TlkXk3m4CuDVyp0u?=
 =?us-ascii?Q?eTFZx3vobmFSzsgfcFWSIP1tm0CEIqDF0hSlxorlKA05gvxauY/DWjJtC7+z?=
 =?us-ascii?Q?PJ1iLxR5Z3fPYSu5exz8gKTOMH+FJbc/ndvZM+9bTEJKMG8zMa0sMFL158i5?=
 =?us-ascii?Q?hr/6FZoZtdXdatLF9oZeWRVm+0ztgx631qSB8Kc57liDkyFPRbulwQpflh6f?=
 =?us-ascii?Q?YE7EP8uU+wKXnaxzv3vxXzrdN1D033TNZasuebyKxfs4PlMuM5tClyBrubxx?=
 =?us-ascii?Q?vZPesqyD+Wd+UsYxfBLzDoe7BfYJijHxxHP3/CvkO6K2ieFfCT3iMB1dRZxx?=
 =?us-ascii?Q?spCCo+zqv9ui1XTrxNiOy39a4Ljy+M9s4BhfwpdWzE/XzXE1A/IT4/P04sWH?=
 =?us-ascii?Q?qgbcDf2dowVkaNvUQt/xgYXoCAOjzXk3FofLj4AACkAiVbuNPxcJ6PZJ/w6X?=
 =?us-ascii?Q?r37rdjS77q0BFVtgSzzM1zakj9Ai0JhSOSHKaIZBqjt6V+B2HL+i8UrUCtW2?=
 =?us-ascii?Q?euBSKDOPu8w4jjZhEoH4ZirNzroQ+QXjgDgyNhfSTYdqWWfJhlp3S6B7Sh93?=
 =?us-ascii?Q?YY87ZJaNS/s6UYc8KWHC+42e+EfxK5XDVzxZpeeaXW5oy0dfRIOErZobTJ/L?=
 =?us-ascii?Q?AXJMM+4fkuv50ZPVniwLZM0IIGy1hgd4t/AvAfW5/1rvZKhjA6PnkDow4Q+o?=
 =?us-ascii?Q?LEy+2RGqE6IqyXCb4Ja4EzI9ZeNsZ6qkT9PIF00L22H02uBMsbiMgTUUjwWO?=
 =?us-ascii?Q?MOxjJp1BQMfF3hWV5PEKZdolpYbp+WytqFFnsFHrQ1Cu6U5SfTghGQ2Ms38?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f01223e-54c0-4722-d46d-08dcd69e39b2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:23:44.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4847

Add definition for the clock controllers of Spacemit K1 SoC. The clock
tree is managed by several SoC parts, thus different compatible strings
are added for each.

spacemit,k1-syscon.yaml is updated as well to allow clock controller
being its subnode.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 .../bindings/clock/spacemit,k1-ccu.yaml       |  71 +++++++
 .../soc/spacemit/spacemit,k1-syscon.yaml      |   4 +
 include/dt-bindings/clock/spacemit,k1-ccu.h   | 198 ++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
 create mode 100644 include/dt-bindings/clock/spacemit,k1-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
new file mode 100644
index 000000000000..0186722cfd87
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/spacemit,k1-ccu.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/spacemit,k1-ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K1 SoC Clock Controller
+
+maintainers:
+  - Haylen Chu <heylenay@outlook.com>
+
+properties:
+  compatible:
+    enum:
+      - spacemit,k1-ccu-apbs
+      - spacemit,k1-ccu-mpmu
+      - spacemit,k1-ccu-apbc
+      - spacemit,k1-ccu-apmu
+
+  clocks:
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: clk_32k
+      - const: vctcxo_1
+      - const: vctcxo_24
+      - const: vctcxo_3
+
+  spacemit,mpmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing "Main PMU (MPMU)" registers. It is used to
+      check PLL lock status.
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/spacemit,k1-ccu.h> for valid indices.
+
+required:
+  - compatible
+  - "#clock-cells"
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-ccu-apbs
+    then:
+      required:
+        - compatible
+        - "#clock-cells"
+        - spacemit,mpmu
+
+examples:
+  - |
+    syscon_apbs: system-control@d4090000 {
+        compatible = "spacemit,k1-apbs-syscon", "syscon", "simple-mfd";
+        reg = <0x0 0xd4090000 0x0 0x1000>;
+
+        clk_apbs: clock-controller {
+            compatible = "spacemit,k1-ccu-apbs";
+            #clock-cells = <1>;
+            spacemit,mpmu = <&syscon_mpmu>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
index 4e3a72b48aff..08efda207101 100644
--- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -27,6 +27,10 @@ properties:
   reg:
     maxItems: 1
 
+  clock-controller:
+    $ref: /schemas/clock/spacemit,k1-ccu.yaml#
+    type: object
+
   "#address-cells":
     const: 1
 
diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
new file mode 100644
index 000000000000..cb60f440a411
--- /dev/null
+++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
+#define _DT_BINDINGS_SPACEMIT_CCU_H_
+
+/*	APBS clocks	*/
+#define CLK_PLL1		0
+#define CLK_PLL2		1
+#define CLK_PLL3		2
+#define CLK_PLL1_D2		3
+#define CLK_PLL1_D3		4
+#define CLK_PLL1_D4		5
+#define CLK_PLL1_D5		6
+#define CLK_PLL1_D6		7
+#define CLK_PLL1_D7		8
+#define CLK_PLL1_D8		9
+#define CLK_PLL1_D11		10
+#define CLK_PLL1_D13		11
+#define CLK_PLL1_D23		12
+#define CLK_PLL1_D64		13
+#define CLK_PLL1_D10_AUD	14
+#define CLK_PLL1_D100_AUD	15
+#define CLK_PLL2_D1		16
+#define CLK_PLL2_D2		17
+#define CLK_PLL2_D3		18
+#define CLK_PLL2_D4		19
+#define CLK_PLL2_D5		20
+#define CLK_PLL2_D6		21
+#define CLK_PLL2_D7		22
+#define CLK_PLL2_D8		23
+#define CLK_PLL3_D1		24
+#define CLK_PLL3_D2		25
+#define CLK_PLL3_D3		26
+#define CLK_PLL3_D4		27
+#define CLK_PLL3_D5		28
+#define CLK_PLL3_D6		29
+#define CLK_PLL3_D7		30
+#define CLK_PLL3_D8		31
+#define CLK_PLL3_80		32
+#define CLK_PLL3_40		33
+#define CLK_PLL3_20		34
+#define CLK_APBS_NUM		35
+
+/*	MPMU clocks	*/
+#define CLK_PLL1_307P2		0
+#define CLK_PLL1_76P8		1
+#define CLK_PLL1_61P44		2
+#define CLK_PLL1_153P6		3
+#define CLK_PLL1_102P4		4
+#define CLK_PLL1_51P2		5
+#define CLK_PLL1_51P2_AP	6
+#define CLK_PLL1_57P6		7
+#define CLK_PLL1_25P6		8
+#define CLK_PLL1_12P8		9
+#define CLK_PLL1_12P8_WDT	10
+#define CLK_PLL1_6P4		11
+#define CLK_PLL1_3P2		12
+#define CLK_PLL1_1P6		13
+#define CLK_PLL1_0P8		14
+#define CLK_PLL1_351		15
+#define CLK_PLL1_409P6		16
+#define CLK_PLL1_204P8		17
+#define CLK_PLL1_491		18
+#define CLK_PLL1_245P76		19
+#define CLK_PLL1_614		20
+#define CLK_PLL1_47P26		21
+#define CLK_PLL1_31P5		22
+#define CLK_PLL1_819		23
+#define CLK_PLL1_1228		24
+#define CLK_SLOW_UART		25
+#define CLK_SLOW_UART1		26
+#define CLK_SLOW_UART2		27
+#define CLK_WDT			28
+#define CLK_RIPC		29
+#define CLK_I2S_SYSCLK		30
+#define CLK_I2S_BCLK		31
+#define CLK_APB			32
+#define CLK_MPMU_NUM		33
+
+/*	APBC clocks	*/
+#define CLK_UART0		0
+#define CLK_UART2		1
+#define CLK_UART3		2
+#define CLK_UART4		3
+#define CLK_UART5		4
+#define CLK_UART6		5
+#define CLK_UART7		6
+#define CLK_UART8		7
+#define CLK_UART9		8
+#define CLK_GPIO		9
+#define CLK_PWM0		10
+#define CLK_PWM1		11
+#define CLK_PWM2		12
+#define CLK_PWM3		13
+#define CLK_PWM4		14
+#define CLK_PWM5		15
+#define CLK_PWM6		16
+#define CLK_PWM7		17
+#define CLK_PWM8		18
+#define CLK_PWM9		19
+#define CLK_PWM10		20
+#define CLK_PWM11		21
+#define CLK_PWM12		22
+#define CLK_PWM13		23
+#define CLK_PWM14		24
+#define CLK_PWM15		25
+#define CLK_PWM16		26
+#define CLK_PWM17		27
+#define CLK_PWM18		28
+#define CLK_PWM19		29
+#define CLK_SSP3		30
+#define CLK_RTC			31
+#define CLK_TWSI0		32
+#define CLK_TWSI1		33
+#define CLK_TWSI2		34
+#define CLK_TWSI4		35
+#define CLK_TWSI5		36
+#define CLK_TWSI6		37
+#define CLK_TWSI7		38
+#define CLK_TWSI8		39
+#define CLK_TIMERS1		40
+#define CLK_TIMERS2		41
+#define CLK_AIB			42
+#define CLK_ONEWIRE		43
+#define CLK_SSPA0		44
+#define CLK_SSPA1		45
+#define CLK_DRO			46
+#define CLK_IR			47
+#define CLK_TSEN		48
+#define CLK_IPC_AP2AUD		49
+#define CLK_CAN0		50
+#define CLK_CAN0_BUS		51
+#define CLK_APBC_NUM		52
+
+/*	APMU clocks	*/
+#define CLK_CCI550		0
+#define CLK_CPU_C0_HI		1
+#define CLK_CPU_C0_CORE		2
+#define CLK_CPU_C0_ACE		3
+#define CLK_CPU_C0_TCM		4
+#define CLK_CPU_C1_HI		5
+#define CLK_CPU_C1_CORE		6
+#define CLK_CPU_C1_ACE		7
+#define CLK_CCIC_4X		8
+#define CLK_CCIC1PHY		9
+#define CLK_SDH_AXI		10
+#define CLK_SDH0		11
+#define CLK_SDH1		12
+#define CLK_SDH2		13
+#define CLK_USB_P1		14
+#define CLK_USB_AXI		15
+#define CLK_USB30		16
+#define CLK_QSPI		17
+#define CLK_QSPI_BUS		18
+#define CLK_DMA			19
+#define CLK_AES			20
+#define CLK_VPU			21
+#define CLK_GPU			22
+#define CLK_EMMC		23
+#define CLK_EMMC_X		24
+#define CLK_AUDIO		25
+#define CLK_HDMI		26
+#define CLK_PMUA_ACLK		27
+#define CLK_PCIE0		28
+#define CLK_PCIE1		29
+#define CLK_PCIE2		30
+#define CLK_EMAC0_BUS		31
+#define CLK_EMAC0_PTP		32
+#define CLK_EMAC1_BUS		33
+#define CLK_EMAC1_PTP		34
+#define CLK_JPG			35
+#define CLK_JPF_4KAFBC		36
+#define CLK_JPF_2KAFBC		37
+#define CLK_CCIC2PHY		38
+#define CLK_CCIC3PHY		39
+#define CLK_CSI			40
+#define CLK_CAMM0		41
+#define CLK_CAMM1		42
+#define CLK_CAMM2		43
+#define CLK_ISP_CPP		44
+#define CLK_ISP_BUS		45
+#define CLK_ISP			46
+#define CLK_DPU_MCLK		47
+#define CLK_DPU_ESC		48
+#define CLK_DPU_BIT		49
+#define CLK_DPU_PXCLK		50
+#define CLK_DPU_HCLK		51
+#define CLK_DPU_SPI		52
+#define CLK_DPU_SPI_HBUS	53
+#define CLK_DPU_SPIBUS		54
+#define CLK_DPU_SPI_ACLK	55
+#define CLK_V2D			56
+#define CLK_APMU_NUM		57
+
+#endif /* _DT_BINDINGS_SPACEMIT_CCU_H_ */
-- 
2.46.0



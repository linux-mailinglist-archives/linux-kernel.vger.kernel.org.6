Return-Path: <linux-kernel+bounces-309961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F49967279
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD362830A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691693CF63;
	Sat, 31 Aug 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ja8YD+LH"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2068.outbound.protection.outlook.com [40.92.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B19461;
	Sat, 31 Aug 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119258; cv=fail; b=pUXiwl7SrcDpmioKnMzvW0hC5bEXkX7r6IPuFqrVZt26HO4XoOk7gMBHZi2egMKZBzO5VSE1VUvkY0qJUodK7WeDgsg20wiiifSyDJPNkwiq73JXl+7NcU1tKffKEVE34FpeouVhToT2NIBVg2qGlBblk/NzMjPDofIHMN8RAns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119258; c=relaxed/simple;
	bh=HJmj+tWFbQWnagttJBnNeZ1WgIigp7WjBEBn8HN8h4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SM9Ck69M83DYp+Fk8mn0zvKsZHLWqXVXybCbBw/e0QviUVrJ82UEQdVrcQXfm6wu3ARHwi2GJAkQQdtWvqTuMUtYuyzNXtlXYBtScYagchH350Nea3wB7Pu1InmRXWt6MgT2wFmfagqzEiht8SIgWPgPvy557XriPUZXVr3D9Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ja8YD+LH; arc=fail smtp.client-ip=40.92.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGiEH/KH9ZPNYLYO/gna+r9VtqjjkIv6FahRopry/DUs6JuZktHh5WNnUxct9ftQfabtyEVfIUDs6DigOEw+2oY8OsrBsR6sCaxHCKkv9YPBPLsnVSGE/ooITJReVkZ95fNbjNzzsOuhAyJObEV6rpIiyzKDgczJq+yW8kL+thDqV7weVRBQ1lvnFHV+5FEglCvZtQnJ8p6+BSAtMywWqSU8LwwsQNPx4AGNZmg9cvSzbBUYxiHDipWrh+p2uhPSb5X0ZFFddyLf8mGuKyFmUUkMRwRtm/dRfnLHRn1icN++cVTPxXGttL6u5/JYuLGoOWgn7C6L/M0XTa2Fg9fQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3nO3Gp7De/y0auygJM1ePDOEAjpP0TudnKS2YoCaJ4=;
 b=opydMbWYCLzHxyE6R041nHrTYiUN61e6MVQ42OgmTvumCmWN2b/6ljPAlhk879pD7T7R7IXTj0/Rc60HcPVUxMJARtWnbXEIDf5Uti9vUsGKFWwaraOtQR7vihzWIetIBmvYuZ9QaBRL5oNo96Lyg+26RFPvmQyTPmbnyO+sVVTxwTxJWiXSYGzGewMS5RyIbm8UokldRI6JtdnvrAPA4R2tEd3Fgu0DwiDs7JKrDj4xmbVEGfkjBq44wRqqAts27Hw2w7nuRLEP03yVyZupcv+AwUhq8iaX+mQEGcOoYIy4J+1wmMEQdFHxRenEBWjIjxZPzgPcUszl8nss2Hvm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3nO3Gp7De/y0auygJM1ePDOEAjpP0TudnKS2YoCaJ4=;
 b=ja8YD+LHeWFcuVltuQfoWmbJHmN8yfu99+iME5g0A/T2FOC89CFfO4BGbyjy/WAqPPp/ZZE9uTK2y0eNLO0fgVg2zcgfzc6BhH4u4vcLtSS5toduE5aLL4dJB0iX1RDffiCxotqfy5FqA+wslXi+Bi14QcjLrRWEuNTJqH0SQXCjf/g0xFuu2WR2/RglZikBQNHbr8xISKSh1EqytbXglOPDNYkdRM1YKE5Nu3QbDvsh9Dd6cjYdmTKUW+czIFIcRQfy3wzAlKlQtKy4FDChkO3aaGQuer/VjNM/e4e3us6X14PcNfJfKcUylvXmIDZBj1Kca71TLD+AgsjJQQbwUw==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4757.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 15:47:31 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%6]) with mapi id 15.20.7897.027; Sat, 31 Aug 2024
 15:47:31 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH 1/2] dt-bindings: clock: spacemit: Add clock controlers of Spacemit K1 SoC
Date: Sat, 31 Aug 2024 15:47:12 +0000
Message-ID:
 <SEYPR01MB4221019943A7F5361957811FD7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [V9zWJQcl0/4d1sRWTYd8dCgQZ4nnuxtT]
X-ClientProxiedBy: TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::13) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240831154713.24814-1-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: e72679a6-419f-48c5-40c1-08dcc9d43957
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|15080799006|461199028|1602099012|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	AuvIKSiAkzYiHrfHW5o8CppGEww45286R3bdCb6DSFwJVBMqx23iLdsHUeTPSBjykuDxcQq7OL6tMT3bmILZwHx6IPeLnOtlRikfVfvX1Nrc6yqZ2cnlT2yYS79uj7Kd5bZkugYebL0vgx4c9iNyGTM2gFnnG2nNjuZS6Km07baXGo68xhRcPKA85b2I2TZyruSqf2vNe2ez/9TIL/mIgbAQQtMkv9Fg6nSCunZse2BRc4tMOu/l/OrRhl0+jCd/FSmHxY52knBskYImRet8ia6lQ+slgOH0/XYduh/UL0t2nZDV2vaoIeyC6MaAuT0PHLo0ZEGg4qy+c5tt4uZfGGXEeTEIt2Sg690l9T5/QsDSf3CiFj0kBoNO5AEIrhn4Q7jNSDEvER5o6GSvJOLlVBNhUZV9fAh3w/US3k1c5/OBVQn/NMyCthB3jAPKxi5sIXeHcK1nHN9RS74duNUhsq9HBuYxaDvdl7PFgKfBdZLyWOj8eckyWbeO7hAaflfsljUoj1V+ljIJRQ7sjCfJFwI7iKto0Sll9hFrnNVNQuXEWCfsRuZLPN3dwxh4kK+ecm+fJJGgsa5yMHAkwsAd8vm0wEGMNYbFe4naTPcHlorVRS7VKXsL+ASD8jVgehEMcw0bvH8Q/S/gL5O2GwHap++PeBG3v1AeceKM7T+HB6k4T6jCQiMlEBPsL/Qxu5M2+LZBdoIdY27iJoPZNvKqxGmb8A4edxQ0uurGMf0PJQBgwyDLyJu/bdhXtrUiYO5eaFHZmThL1ZJhcdCDpTZ1FnP6VNr4hA//Fp/ceO9LWQm8QPWi6wf7X5E17FwEfJBbbUZSbHLJMC4lwiqr2Z/v8FKizN1CViwmPXEpA6I9E2U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhUwJUOB27DDYe3QKKoWOoEA75Cqt4TzvPdPA2n0rcetQRWaGf8WAKSZNBhU?=
 =?us-ascii?Q?TuSXxqOLITbs6s5nxbb6g6WJN8gfqyPzRvyHqxOqYRTQfGHjfylR93uSqhmS?=
 =?us-ascii?Q?3GOwsnh77KQIWOiavAm2HErhTXT9+8ehLqHMgHFodspbDWiFkTzGnfu6rQso?=
 =?us-ascii?Q?33PvTK3uw3Y9wZaq3BhjT0hlGKdDPBm8Mh9xiOhzLVnSuVa83GxQzVfPSuN6?=
 =?us-ascii?Q?TtDC3TNN9Xdxk+2+3PRq4584RBiT1jIlLlPpwhj2zGe6WkSKoB48qQlsUPv+?=
 =?us-ascii?Q?huWrgAU76rLW/tXGiJtJZijkvObvgTc+SyqmNUvqyL+Xu8L7kKe5NbnhppU2?=
 =?us-ascii?Q?5hkxEa5uEB6BawBGdbhIGlkCr9HX+Oqu/NXT2JzLe5amNssC9QIYVw62DyJa?=
 =?us-ascii?Q?qr3ostAQUJQ/oK30elJAvtakjyhB6SmmDhHoAdXaMp7yvNJenZxPV3aFjTCb?=
 =?us-ascii?Q?vN4nqihRpn5I/lQJ1ZBuQt8AcleDl0H1A0SvnwEA08RxxRT9wcPYj8f23Uso?=
 =?us-ascii?Q?cBZbYP1KpK1+IRRAzHUU3u3TZ8nDPMx8NY90WXWApwBEmgt1uMP/slMkWDkf?=
 =?us-ascii?Q?44gfD8bYSvoLZbuYC3yNFJEYSBEM+vhnx0iUh/5l3qwk4TZsIjpk6Vxdw/l5?=
 =?us-ascii?Q?3LwBIKEYKB80BJOJoYpnRMyPxeBlhohBq5eJUly4Eam4J9iUWr52Y+IjL6Nw?=
 =?us-ascii?Q?OtVX8q5dPyzV9+Za6sM0XHHkcLD+TftOfS34IWG/kl8quxdlK4QaO+ojuxY+?=
 =?us-ascii?Q?BgEdSNSq9XUJu7GL/+ou3C64yi9Ys5zQe1Z7HLHDx1LGxjiwxHG7w87Usy2Y?=
 =?us-ascii?Q?2p834rlWGLwMX2zRlf4c+xL/+JSpNJhWBj5BmMLbCfTXtv7tqzogW19UDUgF?=
 =?us-ascii?Q?APmICm8zpP+46el/vPpbi/AQTHYLNTfB5LqZlQk20+EU7FEvEIscwt4Gk5Uw?=
 =?us-ascii?Q?bW4j+0t1PVe/DJ8BHjmcD0AyO1nQHlBjdSxyx8KSW14dQ904z8sq0l8tb4wk?=
 =?us-ascii?Q?nLJpcMe4kf8I1a7izruTKThp7EgwLe/n62vjpoCalqkzJYQIEYsTEo6yfxWM?=
 =?us-ascii?Q?wGZr6J5RFaq0U36oMF90WdK7W2/6zPVQNz90Jn5puBCOWNjLubb4KKgNnJHT?=
 =?us-ascii?Q?r1LNQ6x0WsbP45nTT1O2u7VSIsKPkrrJFdgTDrDWpSbIS13hBiIHDZibnz0Q?=
 =?us-ascii?Q?ejGtmbyhMo+U3GTB8qV4kIFKwam2kHl33S89F4JfioKq8IEr2SzOtChxHC0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72679a6-419f-48c5-40c1-08dcc9d43957
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 15:47:31.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4757

Add definition for the clock controllers of Spacemit K1 SoC. The clock
tree is managed by several SoC parts, thus different compatible strings
are added for each.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 .../bindings/clock/spacemit,ccu.yaml          | 116 +++++++++++
 include/dt-bindings/clock/spacemit,ccu.h      | 197 ++++++++++++++++++
 2 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
 create mode 100644 include/dt-bindings/clock/spacemit,ccu.h

diff --git a/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
new file mode 100644
index 000000000000..90ddfc5e2a2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/spacemit,ccu.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/spacemit,ccu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit SoC Clock Controller
+
+maintainers:
+  - Haylen Chu <heylenay@outlook.com>
+
+properties:
+  compatible:
+    enum:
+      - spacemit,ccu-apbs
+      - spacemit,ccu-mpmu
+      - spacemit,ccu-apbc
+      - spacemit,ccu-apmu
+
+  clocks: true
+
+  clock-names: true
+
+  spacemit,mpmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing "Main PMU (MPMU)" registers
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/spacemit,ccu.h> for valid indices.
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
+            const: spacemit,ccu-apbs
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: pll1_2457p6_vco
+
+      required:
+        - compatible
+        - clocks
+        - clock-names
+        - "#clock-cells"
+        - spacemit,mpmu
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,ccu-apbc
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+
+        clock-names:
+          items:
+            - const: clk_32k
+            - const: vctcxo_1
+            - const: vctcxo_24
+            - const: vctcxo_3
+
+      required:
+        - compatible
+        - clocks
+        - clock-names
+        - "#clock-cells"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,ccu-apmu
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: vctcxo_24
+
+      required:
+        - compatible
+        - clocks
+        - clock-names
+        - "#clock-cells"
+
+examples:
+  - |
+    syscon_apbs: system-control@d4090000 {
+        compatible = "spacemit,mpmu-syscon", "syscon",
+        "simple-mfd";
+        reg = <0x0 0xd4090000 0x0 0x1000>;
+
+        clk_apbs: clock-controller {
+            compatible = "spacemit,ccu-apbs";
+            clocks = <&pll1_2457p6_vco>;
+            clock-names = "pll1_2457p6_vco";
+            #clock-cells = <1>;
+            spacemit,mpmu = <&syscon_mpmu>;
+        };
+    };
diff --git a/include/dt-bindings/clock/spacemit,ccu.h b/include/dt-bindings/clock/spacemit,ccu.h
new file mode 100644
index 000000000000..ce84690684ff
--- /dev/null
+++ b/include/dt-bindings/clock/spacemit,ccu.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (C) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _DT_BINDINGS_SPACEMIT_CCU_H_
+#define _DT_BINDINGS_SPACEMIT_CCU_H_
+
+/*	APBS clocks	*/
+#define CLK_PLL2		0
+#define CLK_PLL3		1
+#define CLK_PLL1_D2		2
+#define CLK_PLL1_D3		3
+#define CLK_PLL1_D4		4
+#define CLK_PLL1_D5		5
+#define CLK_PLL1_D6		6
+#define CLK_PLL1_D7		7
+#define CLK_PLL1_D8		8
+#define CLK_PLL1_D11		9
+#define CLK_PLL1_D13		10
+#define CLK_PLL1_D23		11
+#define CLK_PLL1_D64		12
+#define CLK_PLL1_D10_AUD	13
+#define CLK_PLL1_D100_AUD	14
+#define CLK_PLL2_D1		15
+#define CLK_PLL2_D2		16
+#define CLK_PLL2_D3		17
+#define CLK_PLL2_D4		18
+#define CLK_PLL2_D5		19
+#define CLK_PLL2_D6		20
+#define CLK_PLL2_D7		21
+#define CLK_PLL2_D8		22
+#define CLK_PLL3_D1		23
+#define CLK_PLL3_D2		24
+#define CLK_PLL3_D3		25
+#define CLK_PLL3_D4		26
+#define CLK_PLL3_D5		27
+#define CLK_PLL3_D6		28
+#define CLK_PLL3_D7		29
+#define CLK_PLL3_D8		30
+#define CLK_PLL3_80		31
+#define CLK_PLL3_40		32
+#define CLK_PLL3_20		33
+#define CLK_APBS_NUM		34
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
+#define CLK_I2S_SySCLK		30
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
+#define CLK_DPU_MCL		47
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



Return-Path: <linux-kernel+bounces-331150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B997A92D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B74A1C2238F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430CB15F308;
	Mon, 16 Sep 2024 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EcozGenq"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011039.outbound.protection.outlook.com [52.103.64.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F55258;
	Mon, 16 Sep 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525429; cv=fail; b=hY0odGQ7p+QwudX/GEDyXPqyyeu7AUJJ0OJBUKYLj/p2n1Az/S78C04GifBhAj0RKxQh8qSH29nR4oSWhHS2USK7J+Tq1JtNWUzSDDBSCYDBUU8HcGCCm1IWQtTXB4TO7X7N8Lv4/+bkcNzttYKnwNAz3T6VJCHDHAFUJOlYJQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525429; c=relaxed/simple;
	bh=89bYxQhykbB587mJqNGtbemhNHnqTSJ/pHLPY2AhCLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aZVkePaiKczi/U37oEhgZbFZNMjRj4zU+0HU0hnvgTpyYzed2cwXn1f541wZNfRRrytVZBVeXlH9yfGFl87bfUlmQXpAmG74JZgBTnf+uYNLa7ztuzOI7p67LHo+DNiBusFX0/K93vZ6JQCNk+8G8BmTqoNz5B2rfEamclNAloc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EcozGenq; arc=fail smtp.client-ip=52.103.64.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alJxBQUKZDC2IHEAi8h1rjUPz1Yx02TqtEm/sEn1KGTtnwFg/+q0NqHjfpXNPa4dsaea64/wLnKG0kLuWk+qgSXejmuDugxQuzzIileNwWZnZMsH+AYA/M6TLay4NEVlUmSEm/qn7H3nlIIyo+mAKTy5MASSxePo8rFxiveH6drBNPKz4+gNhajOY1UnxJT6rOfR8/7kkZ3hPMdWlEliTfdNGjjKASHD1cwESr8lYnykuY5mbgiphkLIriIqMC5cthF/G5B7Q6XKg3wAEVxv/uQzRQSBTGmr8yOp/QeW4ri5fBc6wV55si6pnFlBJb2MJrbZEdQk0aOiph4lovIBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMkXkE+ym+kBbeehwMuFPawz3HA0EZTobv741VQUSUA=;
 b=lyhtxbvHa7sqcwKF20xdYckWzw8KB4L2XR/VTxytEiMpTjK3nmQnXiLw9BXtzWFMNwd6DepLUNG+M2S8A3e4zWbphjMIOUW1cCxmjcDufbAUVh30fDoxtvcF4qszwoQhJe2+dAHpqk410H6YD4veKk31KuCDVxNCS3lCGsXCMNo06hjX8Gr5Ea1SrdP47FvWrR2ucyAtgNLWelMeq7hQG5F2r79ByTFFwpsU9nr9TnE3BOLOhKCm6dvxJoTa+YayKPDxM9pX5tRYSXKrfjCguaBPAhca7C1kRSKiRdDIYteA9GoNnu0IgroMMvj4kpVlwHaTjtH8XFtDmwJ8+74DXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMkXkE+ym+kBbeehwMuFPawz3HA0EZTobv741VQUSUA=;
 b=EcozGenqOg3BVt1tkk2gNmfZ9rbKzuOvOYrBy0cIamVATl4Ju44q8ZvUeLM6XF1dvP4N3WR/6ifzUJkOB2O2ShR5UBH3PTvYzTa8v8fxqDnU/2T8HMU2Puedq0UEvoX1QGQ5gli2xlnt1uySN+FPWzK+5VTqgQ7LrVHpSoe2ESWa9rHP4ApprBpcRd7cMHkxaikQAd9p3S1jCNpNWdC0OD2AWE3KMRdOZwpHkh+GaTy5Nnj1l1mFIGYeut9tZYs8bSR/KFq2P9zbwjOCYIjZQxHXiaqEjPEieRYNGPqJrI1ITQR/vAkCaiCO4lZw/XEhQkVkYh3bJ8EK/uavrXfi5g==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4847.apcprd01.prod.exchangelabs.com
 (2603:1096:400:285::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 22:23:42 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:23:42 +0000
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
Subject: [PATCH v2 1/3] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Date: Mon, 16 Sep 2024 22:23:08 +0000
Message-ID:
 <SEYPR01MB42212A60B191731DF9759B7DD7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240916222309.43259-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa8b857-386d-4c7c-eaf1-08dcd69e384d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|37102599003|19110799003|5072599009|461199028|8060799006|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	3hjoTC5kzJxoeJgqUP2X1c7ClKbK5RdmgKtbeYR9iYYR1yqTVUw2jlseZ63vrkuddiWurEh83g0b6OGEgzgP9jHL6E8WoKE1iK1ccb5QRy/0pniRweUXX8J1qznoKroBS95p3f5G+RZVnpC77aAbELZNcZ41w+cbtYGCXJiGrtUjpA5opd4lw46F+9XbFjgn3RORstPZrwl2BDBKB8OredSokCw/CkQOwjGolmx1n2g/aQop+7RAtpGFhHFsK3pcJyEy/o7GgMT/5cNYpEaKBGW11TFp4OyaBhZ+kcbW/go8jOc/tc3wdKY6d5YsuMVy1I5humRwUlQ86SeZmvnHSD8fLVN437K+YDBNFxdqmxIZYIFWTmdtN8u3kqJqR3x0LWo7VCRyShnyszZ6oOCYlSX6pWBaNMPs3O86Hup0Nin1wCJuHLhG5EcWiN/F0VVE+uN5NZyo73EyHbfKaopfO+bMp1Fvw0L7zV5NT6UeyI2GOCLwPuAZzBpB6+xRwY78qpw1cqjqYfAZ4R0biGkbuLOfNfmkIygrBJnj0Bue7IuFCP4cIqgfKhwfmCS7UoptX8X4GRG2rNQtCCJb8kF2nUcugRuYNWUVDuj4sZEiQd7zmcytZSeQd/V1pvJBSftqRqUV3QgW/9L7x8zi816kseydppLMnU70eBYp1uVsURCh1TmXeF2je+LFFqPw6ewslrORoE9I7lP57lXz5IaPiiO5w+4VRmt71E1T1xl7rsfe+zUNIpw2mxHoYg5hESiSpcaeGPl/J1IO/1b4D4oVOj1nx5GfgIogu87JaIg5XZFi8QdHSsMOu6DTovE3DfehMUhwY8XqKCGrs6HQegOpAgvyDzoIGlxv++/H/PEnXJ3VtOnshBQ4sItnTG5c5Us6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?75ejY7nWRhqKY0nLACMAWao1ig9QhcVWgcARudkfV6xkRy2ORXuzMR3DSNNB?=
 =?us-ascii?Q?vefMB4+B50ID64PBGP9MXd80kRgfpVdjz5d0AjxP4BYMLrM1SFDiF4ng5rWC?=
 =?us-ascii?Q?xn9x1ib9fWWpFE4DVPCDE9grxDCQOWU8cmeus0aA10Ul3Otbg1DcjaQ6ZWfn?=
 =?us-ascii?Q?pNqHkGSbOVdXx3i9XP1gjXm6RIf/qe50Yo08LxBiL/hXkfW5/Rs03/84HfBY?=
 =?us-ascii?Q?0bkwzUjNvmyvVYZSylOisbWpSIFf09UuKnED8lOu2Xzj+IcQAWgC+gJWU1l5?=
 =?us-ascii?Q?lNo6spDx5tf14kczpqUW4SybyOHJtyJrdYQB457xu1CTS27mGJ5TWVO1EpSh?=
 =?us-ascii?Q?ctIltYbUKFBZfpPGEli3XuPp7gb4Q45rD62tEWJhnvqQzgUe5/UI4lR0/6R4?=
 =?us-ascii?Q?gJvHd/tuZY0Oi/5/J1m3TBDy4KLIk3xrwgNmwnFCh/OfHIBqCX3Tb2EV2zfW?=
 =?us-ascii?Q?DiqXnLN66VGOo6c2bxf0JpU0EClFHvH8mqmptb/T1vNV8ders9D1ZxR6MnxF?=
 =?us-ascii?Q?gWYSisWrS6wzAFLlzxP0x2JMtiXWKKYJZ/pj6Q4xa/DIcr5tRxRMIq5PKG/+?=
 =?us-ascii?Q?t1N8x4EAk4xIyyoRB+fdGXNddhCNzZ3ViDwYjY4F/xBDyEeppTc5MtM5b8Pa?=
 =?us-ascii?Q?XdHyQdwAJpUT90BNFZvYTHHAGkzK6XMaRF8HbVOrXpHcm9+lk/JkifIK0Yyk?=
 =?us-ascii?Q?HcyYEM2b8QiCJMdZX4yPltFFgRoaAbz/Db4VElCKKOZfG9thJd/uR7vuaziG?=
 =?us-ascii?Q?BZ62OTXW/yAaRmIfn10JZdYB0gR47A5wTxV0COLyeN/og0MzJui6bC9TyEv2?=
 =?us-ascii?Q?7y0n+auVvoGwosn3EBZKr0xbyv1X8uipiGmw3ZYVKI5njrsxXdRDhJ/eg49W?=
 =?us-ascii?Q?xx3ng3xOA21TQHlwwJL2pjxADiA7DyrxmZtyH/C72WqygtZWDOpKq7qhnYEQ?=
 =?us-ascii?Q?xlhX2TKnJMk79w6ApW5LgNYyTsN7gSqemj5d6825x/mwXe4MSJrRXrhEwzlH?=
 =?us-ascii?Q?ewAnL5aa9UFHRZwv+6hj+J+0qPOzWNh6jnZh9r99KAcJTstQPt61GkG2BNN0?=
 =?us-ascii?Q?Za2SUogQtbVNAzp5cjAHTRdTIUh8jQBKA1+0gf5gpyQ9eitV55DWkcP3VHcd?=
 =?us-ascii?Q?LIUexu1zPqbjkeJ+2HpeRgxRtrUkLk8gsFgb5SerwH4OQnTckHwk2RBMvNUJ?=
 =?us-ascii?Q?E6DtvMIsfC5X0PnAEwgdWbzYTxFYJFqRzO7yfqmPEpeFyGltvCfQRS039vU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa8b857-386d-4c7c-eaf1-08dcd69e384d
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:23:41.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4847

Add documentation to describe Spacemit K1 system controller registers.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 .../soc/spacemit/spacemit,k1-syscon.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
new file mode 100644
index 000000000000..4e3a72b48aff
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/spacemit/spacemit,k1-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spacemit K1 SoC System Controller
+
+maintainers:
+  - Haylen Chu <heylenay@outlook.com>
+
+description:
+  The Spacemit K1 SoC system controller provides access to shared register files
+  for related SoC modules, such as clock controller and reset controller.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - spacemit,k1-apbc-syscon
+          - spacemit,k1-apbs-syscon
+          - spacemit,k1-apmu-syscon
+          - spacemit,k1-mpmu-syscon
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    syscon_mpmu: system-controller@d4050000 {
+        compatible = "spacemit,mpmu-syscon", "syscon", "simple-mfd";
+        reg = <0xd4050000 0x209c>;
+    };
-- 
2.46.0



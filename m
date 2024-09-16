Return-Path: <linux-kernel+bounces-331152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD197A933
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334DF1F22E72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51115B552;
	Mon, 16 Sep 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IPlg5XrJ"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19011039.outbound.protection.outlook.com [52.103.64.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB56166315;
	Mon, 16 Sep 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525436; cv=fail; b=rt/QsxcbVwjBya4y0P7rJDePsmCvFL2r91YVuLQgbg8ehE9pmvk67+b0P70/YkQB5kgr/U0xkZKOIutCdor4oDyk8sAKytI3LX5mteThEEr/ssZ2QGWWcf74TlSx6cSFYFfYUEK+MVCZRXOA5xOYUTKVaPXklCjZ12/CoL06SMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525436; c=relaxed/simple;
	bh=3dEH/nwQZo+YykmHOqDnC+hMqTl+iAVpyYFkwueuTj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJj6nc8fKHXMzc1FsyNhwjmZnvdWzNl414epvxcqbVk9mFcfxC5dKExO6q2yo1rr1G28lf8mtH1dc7N/N0gkaiIy/TFfK2kEOYEf7OvqOwQmnWctywgWKt5IXTq9wdyEZkPMQFAzqfnelEFzVHxkONSotsnDQvAVQ8SxFfeyJLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IPlg5XrJ; arc=fail smtp.client-ip=52.103.64.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp2gNkQdIjjoa5IBWnBV+NNmyFH3xntNdFBW5OwTXacBHYgVv/aHi2aR0hsXzRdfZVzFmdA0AJZH50Q4ZsyEynaiMggIx06PmqvkyM1a5KVNugLDhL194kibmMi1C4pESFiQ4dF8VYgizPM5sLgFJRfbjFN79jP98JV6DSNgNTOJaqzp9GsiBiBISa1AYAV2M0bIL2lm/XZOgnFkgBrokn3y/+v8SmaZ3KzQmA+xRKrFeJeWs01oJGwhv1AU2MrYe0LWL7mF4fAImoXCan0/DcgtIg+VHkaOLE1zUBN1hLPRysUXvGlhXxc+UnkRvj5o4YQ8bD4AmP27JQbOLKDHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIx13VbIm3caEVquTsz0Oc8SFln/s1/9t6MQVC0mj8Y=;
 b=Kjg7Id97p65zAZ5PBN5xoeymJkOEPB4qoYtJZyHT8lHeX2YVdf1voRNPL+D9pcLgAmy0NcSTrYcDR2kPM6t1Yp1J202COJ7G62m/e2idE0Qidwoi+8mGYZPRy2ZhJnvaxlXh5isS/S4ZsKveJuzX5Fyv/jub5oxK4TOKXRoylA5cRxCxf/5Mje8KnJpMJNXv1krcIYdpVgryLz8V8yb/054DZ2bMIxXnmL8I7MIYvaIZVOpOn8jeZKCcmaLlFk8LLZaVQVIlOGL8/Nlt37DNwKV7g45s6HGRjRwIEAWPh9+iNEB5jO1x+WMKyoXXk0lvYSyPUSadqts0TXghEbXoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIx13VbIm3caEVquTsz0Oc8SFln/s1/9t6MQVC0mj8Y=;
 b=IPlg5XrJhSfYIXzltKUBKKDxeuE+M51keWicVk9gtdDVdxGu66dj5V7XxNk79L9Ao4l95SqGKzO0oupvHELrGzG3ZDTqiwmuYZqBthRQptgX3vql6hyOt02WX7CF9MKVUeh7igADrf0/Unc5NrUM3UMb1T9zokDExRiHVEesJb+RWlMOFwsyW5adiDOhLy2Ym4630E+8UWmKpRNe2t3m8yq3Gfrx2bwAwn83rrKAttsE2wdmAB5fgrMrg8tOm5/ZKif+1Qlm3steJqFbOJOB4WBCAACtUA9pqHoDbHkDZNEVytolzVQwE6i732ASEUx491WWdeZTeEXH3aSHSqg8Bw==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by TYZPR01MB4847.apcprd01.prod.exchangelabs.com
 (2603:1096:400:285::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 22:23:47 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%2]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:23:46 +0000
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
Subject: [PATCH v2 3/3] clk: spacemit: Add clock support for Spacemit K1 SoC
Date: Mon, 16 Sep 2024 22:23:10 +0000
Message-ID:
 <SEYPR01MB4221AA2CA9C91A695FEFA777D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221829A2CD4D4C1704BABD7D7602@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240916222309.43259-4-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|TYZPR01MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f6834d-5bd7-4a4a-398a-08dcd69e3b1b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|37102599003|19110799003|5072599009|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	1rF+8jgwSfA5m6xdMYS7dbtbp9jY1gad5W2X8TO0/Epj0Y/OBufzCXLPbm0AT1coLLgXcU0F+576Dtd4bSPP81vV01sH1QsAnCxWLoVtheCLN0rWwL5n2vwiZJkjX7ZKmXG7OZ70ClEvoQcatT1Aql1Ala8+IrTNvnWC4RXpnM5a69Aw1MtDV2iH5KXaaSAupaVMUUQJNExE/we6QxPTBbYbBlzT+hUrv9DFbGWqfCeVRjL8fnlT24744RY0QB1TBXlKqeUCgIITRd7+KCB6Rtz0/KRDtwEitrK9NW7tSVPky3IwZ/zvTj8JcWIgiq+JEXeC/yXPQ+ZM5mn7Uui3XOqtvtRhoZL6HqKSmA/hblNUbmJxZ2IIxDSflegiyTeNxYZchRW0yqdwGVNl5Gta8PldUCyoA4di7RKCweAx1cHUYet701EP2L4osmB/D1nwWICReVXCHDqvorw54U812rIwg5wTTNb6BAMo9vrpDuqdj0dpp1EqUJ3/G8NIFq1TA3mNqGIkBe3YqGoAGsa9BdcrfA1oHa4c3sdo6Gq/Jy+o1idqJsMd07n6hBHaxC369tiMCZ7RORqwMo5+JJurVV7jx3kBhqWUQLIw02QhPuAgBpFjsY88eBHmfNPtoZa7AI3HnsoUSrFuJXjNyNsznh7kprIf0yLdrlmwxgPcuTk9O3xowEoFc8U2Z6fBKz6jKhAUjRxpnRHDQK1nvms5ifG9mYJZ0UevGhcQCuHTuH1NUj+ixya4tAt1GrcC/DdATLbWvO+8dJRFzsii0hJUdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APTpYbMK5inlfUMzJLML6tWIuL7IMCPPeN1vwf2qg24Fi3ERY8a3CZekwJ/d?=
 =?us-ascii?Q?9gk9qQYPdEE5Y2vKWWyFFtP9M6hyJjxXpHGdUH9wMkp8/JjRJSklWuccqq6u?=
 =?us-ascii?Q?nVcKp1x5e0Ry8O+fQ2Z8lDdrSno+L3pzAqVao8S4iFeUnYaxHE8pEf0Nm/dE?=
 =?us-ascii?Q?XY+G0rcbkv5GC4KOV+ZEXimPhsTIgrktxNJzVWoOS+nG+23pGDsF0CNq+GT5?=
 =?us-ascii?Q?aZH7i2Nc7uLrGAI+OKie5fNA7A8mlTx+e3wixPZOkE/a8ljFMWz95L5YLc33?=
 =?us-ascii?Q?w09BXMVtHWmIwmkRhkHu27MHIxFEzkDEdRQiVu/oH7MqSJmCdi76kRb2nLSH?=
 =?us-ascii?Q?oBatpY44oMN/G76XXtRwWEnNtD5XFfWop6NdLi0nJ52G3jeezCkhmCU6qHsc?=
 =?us-ascii?Q?knmjbf7weaDIWoeo3yfHqxAVDl0rbsjKIbu5pPggPKEmzOeiPUK4kUZOiKpO?=
 =?us-ascii?Q?0qX5Xw7DTU4mzNmzuNUc1yHSq47lcWlV4Op+tZOx0soaQCG/uylhxCh+UYPe?=
 =?us-ascii?Q?hb44X4vp+YVnsmchF55B9LoIgK1cLeoElyKPMmo++sxvPRVwJSe+vI+xXDNa?=
 =?us-ascii?Q?9MJ8rPHMj4Yu4izkYWBrUTz4yS1gJjZUg5vU4LvrM8mgiD6xqbcDI3CW87mb?=
 =?us-ascii?Q?W0zvdj/Tdnm1U9rvqTIzqt6npMIt3jFq9LBTJ0RzUw0baf3/nENmrSSeOqri?=
 =?us-ascii?Q?VX35OqZGOWOrLFPQX1jCBVcbdohnr2R039bOrOJ2ZbHi+uBjxov6anAGnL3w?=
 =?us-ascii?Q?NZNs4yIjRoDpuFiSeDRVY9MwIj5rEdzIg9PoaZxB4gLRCFlYpX+v8zZ+bBF0?=
 =?us-ascii?Q?nUawvPrp1v+D/eKuehwl3PgHOlFoAWBQBZ8b19z7ESFrsiBRaYV674HmMaK7?=
 =?us-ascii?Q?wRmrxuI1AIXRaG8u5roIKOad7FxzAGgKFs+pctTI6xWeZ6KHQAskjPqXO9Be?=
 =?us-ascii?Q?IFlzv2PlV1no337iaVLiDslbZzHXmrErHmvGeaAUOBNR5HeISfDQ+f6tbd3T?=
 =?us-ascii?Q?MyGLrI00XZJZ7jsgputcQNlcY2Z9d8diIQPIVRVJGWnp845Y5LeuDIjcr+wH?=
 =?us-ascii?Q?4rRzKrsKCtyfTuxkPBfS5O2mTIlzC/38GUFaI2+vzvH/mewCSZ57TW+3l8Cn?=
 =?us-ascii?Q?wV5wZ9piejcZd6zDrS4HOu+ikzMOUAd2edHOEZG9/02xtw0Cn/GU2LEVinbG?=
 =?us-ascii?Q?sJnV9dUFjNN5sKaQG6YWaTo5yt5yAxyYxaBd31ru0ziFTFmt3meRoQYWl40?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f6834d-5bd7-4a4a-398a-08dcd69e3b1b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:23:46.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4847

The clock tree of K1 SoC contains three main types of clock hardware
(PLL/DDN/MIX) and is managed by several independent controllers in
different SoC parts (APBC, APBS and etc.), thus different compatible
strings are added to distinguish them.

Some controllers may share IO region with reset controller and other low
speed peripherals like watchdog, so all register operations are done
through regmap to avoid competition.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/clk/Kconfig               |    1 +
 drivers/clk/Makefile              |    1 +
 drivers/clk/spacemit/Kconfig      |   20 +
 drivers/clk/spacemit/Makefile     |    5 +
 drivers/clk/spacemit/ccu-k1.c     | 1341 +++++++++++++++++++++++++++++
 drivers/clk/spacemit/ccu_common.h |   55 ++
 drivers/clk/spacemit/ccu_ddn.c    |  166 ++++
 drivers/clk/spacemit/ccu_ddn.h    |   82 ++
 drivers/clk/spacemit/ccu_mix.c    |  336 ++++++++
 drivers/clk/spacemit/ccu_mix.h    |  348 ++++++++
 drivers/clk/spacemit/ccu_pll.c    |  226 +++++
 drivers/clk/spacemit/ccu_pll.h    |   82 ++
 12 files changed, 2663 insertions(+)
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/ccu-k1.c
 create mode 100644 drivers/clk/spacemit/ccu_common.h
 create mode 100644 drivers/clk/spacemit/ccu_ddn.c
 create mode 100644 drivers/clk/spacemit/ccu_ddn.h
 create mode 100644 drivers/clk/spacemit/ccu_mix.c
 create mode 100644 drivers/clk/spacemit/ccu_mix.h
 create mode 100644 drivers/clk/spacemit/ccu_pll.c
 create mode 100644 drivers/clk/spacemit/ccu_pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 983ef4f36d8c..04f4cb2d1127 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -490,6 +490,7 @@ source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
 source "drivers/clk/sophgo/Kconfig"
+source "drivers/clk/spacemit/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f793a16cad40..2b2532ebf5d0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
 obj-y					+= sophgo/
+obj-y					+= spacemit/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
new file mode 100644
index 000000000000..76090cd85668
--- /dev/null
+++ b/drivers/clk/spacemit/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SPACEMIT_CCU
+	tristate "Clock support for Spacemit SoCs"
+	default y
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Say Y to enable clock controller unit support for Spacemit SoCs.
+
+if SPACEMIT_CCU
+
+config SPACEMIT_K1_CCU
+	tristate "Support for Spacemit K1 SoC"
+	default y
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	help
+	  Support for clock controller unit in Spacemit K1 SoC.
+
+endif
diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
new file mode 100644
index 000000000000..9d1d5f759eb1
--- /dev/null
+++ b/drivers/clk/spacemit/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPACEMIT_CCU)	+= ccu_pll.o ccu_mix.o ccu_ddn.o
+
+obj-$(CONFIG_SPACEMIT_K1_CCU)	+= ccu-k1.o
diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
new file mode 100644
index 000000000000..ef6c8bc50a98
--- /dev/null
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -0,0 +1,1341 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+#include "ccu_mix.h"
+#include "ccu_ddn.h"
+
+#include <dt-bindings/clock/spacemit,k1-ccu.h>
+
+/*	APBS register offset	*/
+/*	pll1	*/
+#define APB_SPARE1_REG			0x100
+#define APB_SPARE2_REG			0x104
+#define APB_SPARE3_REG			0x108
+/*	pll2	*/
+#define APB_SPARE7_REG			0x118
+#define APB_SPARE8_REG			0x11c
+#define APB_SPARE9_REG			0x120
+/*	pll3	*/
+#define APB_SPARE10_REG			0x124
+#define APB_SPARE11_REG			0x128
+#define APB_SPARE12_REG			0x12c
+
+/* MPMU register offset */
+#define MPMU_POSR			0x10
+#define POSR_PLL1_LOCK			BIT(27)
+#define POSR_PLL2_LOCK			BIT(28)
+#define POSR_PLL3_LOCK			BIT(29)
+
+#define MPMU_WDTPCR			0x200
+#define MPMU_RIPCCR			0x210
+#define MPMU_ACGR			0x1024
+#define MPMU_SUCCR			0x14
+#define MPMU_ISCCR			0x44
+#define MPMU_SUCCR_1			0x10b0
+#define MPMU_APBCSCR			0x1050
+
+/* APBC register offset */
+#define APBC_UART1_CLK_RST		0x0
+#define APBC_UART2_CLK_RST		0x4
+#define APBC_GPIO_CLK_RST		0x8
+#define APBC_PWM0_CLK_RST		0xc
+#define APBC_PWM1_CLK_RST		0x10
+#define APBC_PWM2_CLK_RST		0x14
+#define APBC_PWM3_CLK_RST		0x18
+#define APBC_TWSI8_CLK_RST		0x20
+#define APBC_UART3_CLK_RST		0x24
+#define APBC_RTC_CLK_RST		0x28
+#define APBC_TWSI0_CLK_RST		0x2c
+#define APBC_TWSI1_CLK_RST		0x30
+#define APBC_TIMERS1_CLK_RST		0x34
+#define APBC_TWSI2_CLK_RST		0x38
+#define APBC_AIB_CLK_RST		0x3c
+#define APBC_TWSI4_CLK_RST		0x40
+#define APBC_TIMERS2_CLK_RST		0x44
+#define APBC_ONEWIRE_CLK_RST		0x48
+#define APBC_TWSI5_CLK_RST		0x4c
+#define APBC_DRO_CLK_RST		0x58
+#define APBC_IR_CLK_RST			0x5c
+#define APBC_TWSI6_CLK_RST		0x60
+#define APBC_COUNTER_CLK_SEL		0x64
+#define APBC_TWSI7_CLK_RST		0x68
+#define APBC_TSEN_CLK_RST		0x6c
+#define APBC_UART4_CLK_RST		0x70
+#define APBC_UART5_CLK_RST		0x74
+#define APBC_UART6_CLK_RST		0x78
+#define APBC_SSP3_CLK_RST		0x7c
+#define APBC_SSPA0_CLK_RST		0x80
+#define APBC_SSPA1_CLK_RST		0x84
+#define APBC_IPC_AP2AUD_CLK_RST		0x90
+#define APBC_UART7_CLK_RST		0x94
+#define APBC_UART8_CLK_RST		0x98
+#define APBC_UART9_CLK_RST		0x9c
+#define APBC_CAN0_CLK_RST		0xa0
+#define APBC_PWM4_CLK_RST		0xa8
+#define APBC_PWM5_CLK_RST		0xac
+#define APBC_PWM6_CLK_RST		0xb0
+#define APBC_PWM7_CLK_RST		0xb4
+#define APBC_PWM8_CLK_RST		0xb8
+#define APBC_PWM9_CLK_RST		0xbc
+#define APBC_PWM10_CLK_RST		0xc0
+#define APBC_PWM11_CLK_RST		0xc4
+#define APBC_PWM12_CLK_RST		0xc8
+#define APBC_PWM13_CLK_RST		0xcc
+#define APBC_PWM14_CLK_RST		0xd0
+#define APBC_PWM15_CLK_RST		0xd4
+#define APBC_PWM16_CLK_RST		0xd8
+#define APBC_PWM17_CLK_RST		0xdc
+#define APBC_PWM18_CLK_RST		0xe0
+#define APBC_PWM19_CLK_RST		0xe4
+
+/* APMU register offset */
+#define APMU_CCI550_CLK_CTRL		0x300
+#define APMU_CPU_C0_CLK_CTRL		0x38C
+#define APMU_CPU_C1_CLK_CTRL		0x390
+#define APMU_JPG_CLK_RES_CTRL		0x20
+#define APMU_CSI_CCIC2_CLK_RES_CTRL	0x24
+#define APMU_ISP_CLK_RES_CTRL		0x38
+#define APMU_LCD_CLK_RES_CTRL1		0x44
+#define APMU_LCD_SPI_CLK_RES_CTRL	0x48
+#define APMU_LCD_CLK_RES_CTRL2		0x4c
+#define APMU_CCIC_CLK_RES_CTRL		0x50
+#define APMU_SDH0_CLK_RES_CTRL		0x54
+#define APMU_SDH1_CLK_RES_CTRL		0x58
+#define APMU_USB_CLK_RES_CTRL		0x5c
+#define APMU_QSPI_CLK_RES_CTRL		0x60
+#define APMU_USB_CLK_RES_CTRL		0x5c
+#define APMU_DMA_CLK_RES_CTRL		0x64
+#define APMU_AES_CLK_RES_CTRL		0x68
+#define APMU_VPU_CLK_RES_CTRL		0xa4
+#define APMU_GPU_CLK_RES_CTRL		0xcc
+#define APMU_SDH2_CLK_RES_CTRL		0xe0
+#define APMU_PMUA_MC_CTRL		0xe8
+#define APMU_PMU_CC2_AP			0x100
+#define APMU_PMUA_EM_CLK_RES_CTRL	0x104
+#define APMU_AUDIO_CLK_RES_CTRL		0x14c
+#define APMU_HDMI_CLK_RES_CTRL		0x1B8
+#define APMU_CCI550_CLK_CTRL		0x300
+#define APMU_ACLK_CLK_CTRL		0x388
+#define APMU_CPU_C0_CLK_CTRL		0x38C
+#define APMU_CPU_C1_CLK_CTRL		0x390
+#define APMU_PCIE_CLK_RES_CTRL_0	0x3cc
+#define APMU_PCIE_CLK_RES_CTRL_1	0x3d4
+#define APMU_PCIE_CLK_RES_CTRL_2	0x3dc
+#define APMU_EMAC0_CLK_RES_CTRL		0x3e4
+#define APMU_EMAC1_CLK_RES_CTRL		0x3ec
+
+/*	APBS clocks start	*/
+
+/* Frequency of pll{1,2} should not be updated at runtime */
+static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
+	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
+};
+
+static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
+};
+
+static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
+	CCU_PLL_RATE(3200000000UL, 0x67, 0xdd, 0x50, 0x00, 0x43, 0xeaaaab),
+	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
+};
+
+static CCU_PLL_DEFINE(pll1, "pll1", pll1_rate_tbl,
+		      APB_SPARE1_REG, APB_SPARE2_REG, APB_SPARE3_REG,
+		      MPMU_POSR, POSR_PLL1_LOCK, 0);
+static CCU_PLL_DEFINE(pll2, "pll2", pll2_rate_tbl,
+		      APB_SPARE7_REG, APB_SPARE8_REG, APB_SPARE9_REG,
+		      MPMU_POSR, POSR_PLL2_LOCK, 0);
+static CCU_PLL_DEFINE(pll3, "pll3", pll3_rate_tbl,
+		      APB_SPARE10_REG, APB_SPARE11_REG, APB_SPARE12_REG,
+		      MPMU_POSR, POSR_PLL3_LOCK, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll1_d2, "pll1_d2", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d3, "pll1_d3", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d4, "pll1_d4", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d5, "pll1_d5", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d6, "pll1_d6", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d7, "pll1_d7", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d8, "pll1_d8", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d11_223p4, "pll1_d11_223p4",
+			      "pll1", APB_SPARE2_REG,
+			      BIT(15), BIT(15), 0, 11, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d13_189, "pll1_d13_189", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(16), BIT(16), 0, 13, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d23_106p8, "pll1_d23_106p8",
+			      "pll1", APB_SPARE2_REG,
+			      BIT(20), BIT(20), 0, 23, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d64_38p4, "pll1_d64_38p4", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(0), BIT(0), 0, 64, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_aud_245p7, "pll1_aud_245p7",
+			      "pll1", APB_SPARE2_REG,
+			      BIT(10), BIT(10), 0, 10, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_aud_24p5, "pll1_aud_24p5", "pll1",
+			      APB_SPARE2_REG,
+			      BIT(11), BIT(11), 0, 100, 1, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll2_d1, "pll2_d1", "pll2", APB_SPARE8_REG,
+			      BIT(0), BIT(0), 0, 1, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d2, "pll2_d2", "pll2", APB_SPARE8_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d3, "pll2_d3", "pll2", APB_SPARE8_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d4, "pll2_d4", "pll2", APB_SPARE8_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d5, "pll2_d5", "pll2", APB_SPARE8_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d6, "pll2_d6", "pll2", APB_SPARE8_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d7, "pll2_d7", "pll2", APB_SPARE8_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d8, "pll2_d8", "pll2", APB_SPARE8_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll3_d1, "pll3_d1", "pll3", APB_SPARE11_REG,
+			      BIT(0), BIT(0), 0, 1, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d2, "pll3_d2", "pll3", APB_SPARE11_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d3, "pll3_d3", "pll3", APB_SPARE11_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d4, "pll3_d4", "pll3", APB_SPARE11_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d5, "pll3_d5", "pll3", APB_SPARE11_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d6, "pll3_d6", "pll3", APB_SPARE11_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d7, "pll3_d7", "pll3", APB_SPARE11_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d8, "pll3_d8", "pll3", APB_SPARE11_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+
+static CCU_FACTOR_DEFINE(pll3_20, "pll3_20", "pll3_d8", 20, 1);
+static CCU_FACTOR_DEFINE(pll3_40, "pll3_40", "pll3_d8", 10, 1);
+static CCU_FACTOR_DEFINE(pll3_80, "pll3_80", "pll3_d8", 5, 1);
+
+/*	APBS clocks end		*/
+
+/*	MPMU clocks start	*/
+static CCU_GATE_DEFINE(pll1_d8_307p2, "pll1_d8_307p2", "pll1_d8",
+	MPMU_ACGR,
+	BIT(13), BIT(13), 0, 0);
+static CCU_FACTOR_DEFINE(pll1_d32_76p8, "pll1_d32_76p8", "pll1_d8_307p2",
+			 4, 1);
+static CCU_FACTOR_DEFINE(pll1_d40_61p44, "pll1_d40_61p44", "pll1_d8_307p2",
+			 5, 1);
+static CCU_FACTOR_DEFINE(pll1_d16_153p6, "pll1_d16_153p6", "pll1_d8",
+			 2, 1);
+static CCU_GATE_FACTOR_DEFINE(pll1_d24_102p4, "pll1_d24_102p4", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(12), BIT(12), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2, "pll1_d48_51p2", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(7), BIT(7), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2_ap, "pll1_d48_51p2_ap", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(11), BIT(11), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_m3d128_57p6, "pll1_m3d128_57p6", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(8), BIT(8), 0, 16, 3, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d96_25p6, "pll1_d96_25p6", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(4), BIT(4), 0, 12, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8, "pll1_d192_12p8", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(3), BIT(3), 0, 24, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8_wdt, "pll1_d192_12p8_wdt",
+			      "pll1_d8", MPMU_ACGR,
+			      BIT(19), BIT(19), 0x0, 24, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d384_6p4, "pll1_d384_6p4", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(2), BIT(2), 0, 48, 1, 0);
+static CCU_FACTOR_DEFINE(pll1_d768_3p2, "pll1_d768_3p2", "pll1_d384_6p4",
+			 2, 1);
+static CCU_FACTOR_DEFINE(pll1_d1536_1p6, "pll1_d1536_1p6", "pll1_d384_6p4",
+			 4, 1);
+static CCU_FACTOR_DEFINE(pll1_d3072_0p8, "pll1_d3072_0p8", "pll1_d384_6p4",
+			 8, 1);
+
+static CCU_FACTOR_DEFINE(pll1_d7_351p08, "pll1_d7_351p08", "pll1_d7",
+			 1, 1);
+
+static CCU_GATE_DEFINE(pll1_d6_409p6, "pll1_d6_409p6", "pll1_d6",
+		       MPMU_ACGR,
+		       BIT(0), BIT(0), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d12_204p8, "pll1_d12_204p8", "pll1_d6",
+			      MPMU_ACGR,
+			      BIT(5), BIT(5), 0, 2, 1, 0);
+
+static CCU_GATE_DEFINE(pll1_d5_491p52, "pll1_d5_491p52", "pll1_d5",
+		       MPMU_ACGR, BIT(21), BIT(21), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d10_245p76, "pll1_d10_245p76", "pll1_d5",
+			      MPMU_ACGR,
+			      BIT(18), BIT(18), 0, 2, 1, 0);
+
+static CCU_GATE_DEFINE(pll1_d4_614p4, "pll1_d4_614p4", "pll1_d4",
+		       MPMU_ACGR,
+		       BIT(15), BIT(15), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d52_47p26, "pll1_d52_47p26", "pll1_d4",
+			      MPMU_ACGR,
+			      BIT(10), BIT(10), 0, 13, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d78_31p5, "pll1_d78_31p5", "pll1_d4",
+			      MPMU_ACGR,
+			      BIT(6), BIT(6), 0, 39, 2, 0);
+
+static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", "pll1_d3",
+		       MPMU_ACGR,
+		       BIT(14), BIT(14), 0, 0);
+
+static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", "pll1_d2",
+		       MPMU_ACGR,
+		       BIT(16), BIT(16), 0, 0);
+
+static struct ccu_ddn_info uart_ddn_mask_info = {
+	.factor		= 2,
+	.num_mask	= 0x1fff,
+	.den_mask	= 0x1fff,
+	.num_shift	= 16,
+	.den_shift	= 0,
+};
+static struct ccu_ddn_tbl slow_uart1_tbl[] = {
+	{ .num = 125, .den = 24 },
+};
+static struct ccu_ddn_tbl slow_uart2_tbl[] = {
+	{ .num = 6144, .den = 960 },
+};
+static CCU_GATE_NO_PARENT_DEFINE(slow_uart, "slow_uart",
+				 MPMU_ACGR,
+				 BIT(1), BIT(1), 0, 0);
+static CCU_DDN_DEFINE(slow_uart1_14p74, "slow_uart1_14p74", "pll1_d16_153p6",
+		      &uart_ddn_mask_info, slow_uart1_tbl,
+		      MPMU_SUCCR, 0);
+static CCU_DDN_DEFINE(slow_uart2_48, "slow_uart2_48", "pll1_d4_614p4",
+		      &uart_ddn_mask_info, slow_uart2_tbl,
+		      MPMU_SUCCR_1, 0);
+
+static CCU_GATE_DEFINE(wdt_clk, "wdt_clk", "pll1_d96_25p6",
+		       MPMU_WDTPCR,
+		       0x3, 0x3, 0x0,
+		       0);
+
+static CCU_GATE_NO_PARENT_DEFINE(ripc_clk, "ripc_clk",
+				 MPMU_RIPCCR,
+				 0x3, 0x3, 0x0,
+				 0);
+
+static CCU_GATE_FACTOR_DEFINE(i2s_sysclk, "i2s_sysclk", "pll1_d16_153p6",
+			      MPMU_ISCCR,
+			      BIT(31), BIT(31), 0x0, 50, 1,
+			      0);
+static CCU_GATE_FACTOR_DEFINE(i2s_bclk, "i2s_bclk", "i2s_sysclk",
+			      MPMU_ISCCR,
+			      BIT(29), BIT(29), 0x0, 1, 1,
+			      0);
+
+static const char * const apb_parent_names[] = {
+	"pll1_d96_25p6", "pll1_d48_51p2", "pll1_d96_25p6", "pll1_d24_102p4"
+};
+static CCU_MUX_DEFINE(apb_clk, "apb_clk", apb_parent_names,
+		      MPMU_APBCSCR,
+		      0, 2,
+		      0);
+/*	MPMU clocks end		*/
+
+/*	APBC clocks start	*/
+static const char * const uart_clk_parents[] = {
+	"pll1_m3d128_57p6", "slow_uart1_14p74", "slow_uart2_48",
+};
+static CCU_MUX_GATE_DEFINE(uart0_clk, "uart0_clk", uart_clk_parents,
+			   APBC_UART1_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart2_clk, "uart2_clk", uart_clk_parents,
+			   APBC_UART2_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart3_clk, "uart3_clk", uart_clk_parents,
+			   APBC_UART3_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart4_clk, "uart4_clk", uart_clk_parents,
+			   APBC_UART4_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart5_clk, "uart5_clk", uart_clk_parents,
+			   APBC_UART5_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart6_clk, "uart6_clk", uart_clk_parents,
+			   APBC_UART6_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart7_clk, "uart7_clk", uart_clk_parents,
+			   APBC_UART7_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart8_clk, "uart8_clk", uart_clk_parents,
+			   APBC_UART8_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart9_clk, "uart9_clk", uart_clk_parents,
+			   APBC_UART9_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+
+static CCU_GATE_DEFINE(gpio_clk, "gpio_clk", "vctcxo_24",
+		       APBC_GPIO_CLK_RST,
+		       0x3, 0x3, 0x0,
+		       0);
+
+static const char * const pwm_parent_names[] = {
+	"pll1_d192_12p8", "clk_32k"
+};
+static CCU_MUX_GATE_DEFINE(pwm0_clk, "pwm0_clk", pwm_parent_names,
+			   APBC_PWM0_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm1_clk, "pwm1_clk", pwm_parent_names,
+			   APBC_PWM1_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm2_clk, "pwm2_clk", pwm_parent_names,
+			   APBC_PWM2_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm3_clk, "pwm3_clk", pwm_parent_names,
+			   APBC_PWM3_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm4_clk, "pwm4_clk", pwm_parent_names,
+			   APBC_PWM4_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm5_clk, "pwm5_clk", pwm_parent_names,
+			   APBC_PWM5_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm6_clk, "pwm6_clk", pwm_parent_names,
+			   APBC_PWM6_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm7_clk, "pwm7_clk", pwm_parent_names,
+			   APBC_PWM7_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm8_clk, "pwm8_clk", pwm_parent_names,
+			   APBC_PWM8_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm9_clk, "pwm9_clk", pwm_parent_names,
+			   APBC_PWM9_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm10_clk, "pwm10_clk", pwm_parent_names,
+			   APBC_PWM10_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm11_clk, "pwm11_clk", pwm_parent_names,
+			   APBC_PWM11_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm12_clk, "pwm12_clk", pwm_parent_names,
+			   APBC_PWM12_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm13_clk, "pwm13_clk", pwm_parent_names,
+			   APBC_PWM13_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm14_clk, "pwm14_clk", pwm_parent_names,
+			   APBC_PWM14_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm15_clk, "pwm15_clk", pwm_parent_names,
+			   APBC_PWM15_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm16_clk, "pwm16_clk", pwm_parent_names,
+			   APBC_PWM16_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm17_clk, "pwm17_clk", pwm_parent_names,
+			   APBC_PWM17_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm18_clk, "pwm18_clk", pwm_parent_names,
+			   APBC_PWM18_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(pwm19_clk, "pwm19_clk", pwm_parent_names,
+			   APBC_PWM19_CLK_RST,
+			   4, 3, 0x2, 0x2, 0x0,
+			   0);
+
+static const char * const ssp_parent_names[] = {
+	"pll1_d384_6p4", "pll1_d192_12p8", "pll1_d96_25p6", "pll1_d48_51p2",
+	"pll1_d768_3p2", "pll1_d1536_1p6", "pll1_d3072_0p8"
+};
+static CCU_MUX_GATE_DEFINE(ssp3_clk, "ssp3_clk", ssp_parent_names,
+			   APBC_SSP3_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+
+static CCU_GATE_DEFINE(rtc_clk, "rtc_clk", "clk_32k",
+		       APBC_RTC_CLK_RST,
+		       0x83, 0x83, 0x0, 0);
+
+static const char * const twsi_parent_names[] = {
+	"pll1_d78_31p5", "pll1_d48_51p2", "pll1_d40_61p44"
+};
+static CCU_MUX_GATE_DEFINE(twsi0_clk, "twsi0_clk", twsi_parent_names,
+			   APBC_TWSI0_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi1_clk, "twsi1_clk", twsi_parent_names,
+			   APBC_TWSI1_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi2_clk, "twsi2_clk", twsi_parent_names,
+			   APBC_TWSI2_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi4_clk, "twsi4_clk", twsi_parent_names,
+			   APBC_TWSI4_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi5_clk, "twsi5_clk", twsi_parent_names,
+			   APBC_TWSI5_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi6_clk, "twsi6_clk", twsi_parent_names,
+			   APBC_TWSI6_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi7_clk, "twsi7_clk", twsi_parent_names,
+			   APBC_TWSI7_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(twsi8_clk, "twsi8_clk", twsi_parent_names,
+			   APBC_TWSI8_CLK_RST,
+			   4, 3, 0x7, 0x3, 0x4,
+			   0);
+
+static const char * const timer_parent_names[] = {
+	"pll1_d192_12p8", "clk_32k", "pll1_d384_6p4", "vctcxo_3", "vctcxo_1"
+};
+static CCU_MUX_GATE_DEFINE(timers1_clk, "timers1_clk", timer_parent_names,
+			   APBC_TIMERS1_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(timers2_clk, "timers2_clk", timer_parent_names,
+			   APBC_TIMERS2_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+
+static CCU_GATE_DEFINE(aib_clk, "aib_clk", "vctcxo_24",
+		       APBC_AIB_CLK_RST,
+		       0x3, 0x3, 0x0, 0);
+
+static CCU_GATE_NO_PARENT_DEFINE(onewire_clk, "onewire_clk",
+				 APBC_ONEWIRE_CLK_RST,
+				 0x3, 0x3, 0x0,
+				 0);
+
+static const char * const sspa_parent_names[] = {
+	"pll1_d384_6p4", "pll1_d192_12p8", "pll1_d96_25p6", "pll1_d48_51p2",
+	"pll1_d768_3p2", "pll1_d1536_1p6", "pll1_d3072_0p8", "i2s_bclk"
+};
+static CCU_MUX_GATE_DEFINE(sspa0_clk, "sspa0_clk", sspa_parent_names,
+			   APBC_SSPA0_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(sspa1_clk, "sspa1_clk", sspa_parent_names,
+			   APBC_SSPA1_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_GATE_NO_PARENT_DEFINE(dro_clk, "dro_clk",
+				 APBC_DRO_CLK_RST,
+				 0x1, 0x1, 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(ir_clk, "ir_clk",
+				 APBC_IR_CLK_RST,
+				 0x1, 0x1, 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(tsen_clk, "tsen_clk",
+				 APBC_TSEN_CLK_RST,
+				 0x3, 0x3, 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(ipc_ap2aud_clk, "ipc_ap2aud_clk",
+				 APBC_IPC_AP2AUD_CLK_RST,
+				 0x3, 0x3, 0x0,
+				 0);
+
+static const char * const can_parent_names[] = {
+	"pll3_20", "pll3_40", "pll3_80"
+};
+static CCU_MUX_GATE_DEFINE(can0_clk, "can0_clk", can_parent_names,
+			   APBC_CAN0_CLK_RST,
+			   4, 3, BIT(1), BIT(1), 0x0,
+			   0);
+static CCU_GATE_NO_PARENT_DEFINE(can0_bus_clk, "can0_bus_clk",
+				 APBC_CAN0_CLK_RST,
+				 BIT(0), BIT(0), 0x0,
+				 0);
+/*	APBC clocks end		*/
+
+/*	APMU clocks start	*/
+static const char * const cci550_clk_parents[] = {
+	"pll1_d5_491p52", "pll1_d4_614p4", "pll1_d3_819p2", "pll2_d3"
+};
+static CCU_DIV_FC_MUX_DEFINE(cci550_clk, "cci550_clk", cci550_clk_parents,
+			     APMU_CCI550_CLK_CTRL,
+			     8, 3, BIT(12), 0, 2, CLK_IS_CRITICAL);
+
+static const char * const cpu_c0_hi_clk_parents[] = { "pll3_d2", "pll3_d1" };
+static CCU_MUX_DEFINE(cpu_c0_hi_clk, "cpu_c0_hi_clk", cpu_c0_hi_clk_parents,
+		      APMU_CPU_C0_CLK_CTRL,
+		      13, 1, 0);
+static const char * const cpu_c0_clk_parents[] = {
+	"pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p52",
+	"pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c0_hi_clk"
+};
+static CCU_MUX_FC_DEFINE(cpu_c0_core_clk, "cpu_c0_core_clk", cpu_c0_clk_parents,
+			 APMU_CPU_C0_CLK_CTRL,
+			 BIT(12), 0, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c0_ace_clk, "cpu_c0_ace_clk", "cpu_c0_core_clk",
+		      APMU_CPU_C0_CLK_CTRL,
+		      6, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c0_tcm_clk, "cpu_c0_tcm_clk", "cpu_c0_core_clk",
+		      APMU_CPU_C0_CLK_CTRL, 9, 3, CLK_IS_CRITICAL);
+
+static const char * const cpu_c1_hi_clk_parents[] = { "pll3_d2", "pll3_d1" };
+static CCU_MUX_DEFINE(cpu_c1_hi_clk, "cpu_c1_hi_clk", cpu_c1_hi_clk_parents,
+		      APMU_CPU_C1_CLK_CTRL,
+		      13, 1, CLK_IS_CRITICAL);
+static const char * const cpu_c1_clk_parents[] = {
+	"pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p52",
+	"pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c1_hi_clk"
+};
+static CCU_MUX_FC_DEFINE(cpu_c1_core_clk, "cpu_c1_core_clk", cpu_c1_clk_parents,
+			 APMU_CPU_C1_CLK_CTRL,
+			 BIT(12), 0, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c1_ace_clk, "cpu_c1_ace_clk", "cpu_c1_core_clk",
+		      APMU_CPU_C1_CLK_CTRL,
+		      6, 3, CLK_IS_CRITICAL);
+
+static const char * const jpg_parent_names[] = {
+	"pll1_d4_614p4", "pll1_d6_409p6", "pll1_d5_491p52", "pll1_d3_819p2",
+	"pll1_d2_1228p8", "pll2_d4", "pll2_d3"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(jpg_clk, "jpg_clk", jpg_parent_names,
+				  APMU_JPG_CLK_RES_CTRL,
+				  5, 3, BIT(15),
+				  2, 3, BIT(1), BIT(1), 0x0,
+				  0);
+static CCU_GATE_NO_PARENT_DEFINE(jpg_4kafbc_clk, "jpg_4kafbc_clk",
+				 APMU_JPG_CLK_RES_CTRL,
+				 BIT(16), BIT(16), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(jpg_2kafbc_clk, "jpg_2kafbc_clk",
+				 APMU_JPG_CLK_RES_CTRL,
+				 BIT(17), BIT(17), 0x0,
+				 0);
+
+static const char * const ccic2phy_parent_names[] = {
+	"pll1_d24_102p4", "pll1_d48_51p2_ap"
+};
+static CCU_MUX_GATE_DEFINE(ccic2phy_clk, "ccic2phy_clk", ccic2phy_parent_names,
+			   APMU_CSI_CCIC2_CLK_RES_CTRL,
+			   7, 1, BIT(5), BIT(5), 0x0,
+			   0);
+
+static const char * const ccic3phy_parent_names[] = {
+	"pll1_d24_102p4", "pll1_d48_51p2_ap"
+};
+static CCU_MUX_GATE_DEFINE(ccic3phy_clk, "ccic3phy_clk", ccic3phy_parent_names,
+			   APMU_CSI_CCIC2_CLK_RES_CTRL,
+			   31, 1, BIT(30), BIT(30), 0x0,
+			   0);
+
+static const char * const csi_parent_names[] = {
+	"pll1_d5_491p52", "pll1_d6_409p6", "pll1_d4_614p4", "pll1_d3_819p2",
+	"pll2_d2", "pll2_d3", "pll2_d4", "pll1_d2_1228p8"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(csi_clk, "csi_clk", csi_parent_names,
+				  APMU_CSI_CCIC2_CLK_RES_CTRL,
+				  20, 3, BIT(15),
+				  16, 3, BIT(4), BIT(4), 0x0,
+				  0);
+
+static const char * const camm_parent_names[] = {
+	"pll1_d8_307p2", "pll2_d5", "pll1_d6_409p6", "vctcxo_24"
+};
+static CCU_DIV_MUX_GATE_DEFINE(camm0_clk, "camm0_clk", camm_parent_names,
+			       APMU_CSI_CCIC2_CLK_RES_CTRL,
+			       23, 4, 8, 2,
+			       BIT(28), BIT(28), 0x0,
+			       0);
+static CCU_DIV_MUX_GATE_DEFINE(camm1_clk, "camm1_clk", camm_parent_names,
+			       APMU_CSI_CCIC2_CLK_RES_CTRL,
+			       23, 4, 8, 2, BIT(6), BIT(6), 0x0,
+			       0);
+static CCU_DIV_MUX_GATE_DEFINE(camm2_clk, "camm2_clk", camm_parent_names,
+			       APMU_CSI_CCIC2_CLK_RES_CTRL,
+			       23, 4, 8, 2, BIT(3), BIT(3), 0x0,
+			       0);
+
+static const char * const isp_cpp_parent_names[] = {
+	"pll1_d8_307p2", "pll1_d6_409p6"
+};
+static CCU_DIV_MUX_GATE_DEFINE(isp_cpp_clk, "isp_cpp_clk", isp_cpp_parent_names,
+			       APMU_ISP_CLK_RES_CTRL,
+			       24, 2, 26, 1, BIT(28), BIT(28), 0x0,
+			       0);
+static const char * const isp_bus_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d5_491p52", "pll1_d8_307p2", "pll1_d10_245p76"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(isp_bus_clk, "isp_bus_clk",
+				  isp_bus_parent_names,
+				  APMU_ISP_CLK_RES_CTRL,
+				  18, 3, BIT(23),
+				  21, 2, BIT(17), BIT(17), 0x0,
+				  0);
+static const char * const isp_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p2"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(isp_clk, "isp_clk", isp_parent_names,
+				  APMU_ISP_CLK_RES_CTRL,
+				  4, 3, BIT(7),
+				  8, 2, BIT(1), BIT(1), 0x0,
+				  0);
+
+static const char * const dpumclk_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p2"
+};
+static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_mclk, "dpu_mclk", dpumclk_parent_names,
+				   APMU_LCD_CLK_RES_CTRL1,
+				   APMU_LCD_CLK_RES_CTRL2,
+				   1, 4, BIT(29),
+				   5, 3, BIT(0), BIT(0), 0x0,
+				   0);
+
+static const char * const dpuesc_parent_names[] = {
+	"pll1_d48_51p2_ap", "pll1_d52_47p26", "pll1_d96_25p6", "pll1_d32_76p8"
+};
+static CCU_MUX_GATE_DEFINE(dpu_esc_clk, "dpu_esc_clk", dpuesc_parent_names,
+			   APMU_LCD_CLK_RES_CTRL1,
+			   0, 2, BIT(2), BIT(2), 0x0,
+			   0);
+
+static const char * const dpubit_parent_names[] = {
+	"pll1_d3_819p2", "pll2_d2", "pll2_d3", "pll1_d2_1228p8", "pll2_d4",
+	"pll2_d5", "pll2_d8", "pll2_d8"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_bit_clk, "dpu_bit_clk",
+				  dpubit_parent_names,
+				  APMU_LCD_CLK_RES_CTRL1,
+				  17, 3, BIT(31),
+				  20, 3, BIT(16), BIT(16), 0x0,
+				  0);
+
+static const char * const dpupx_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p2", "pll2_d7", "pll2_d8"
+};
+static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_pxclk, "dpu_pxclk", dpupx_parent_names,
+				  APMU_LCD_CLK_RES_CTRL1,
+				  APMU_LCD_CLK_RES_CTRL2,
+				  17, 4, BIT(30),
+				  21, 3, BIT(16), BIT(16), 0x0,
+				  0);
+
+static CCU_GATE_NO_PARENT_DEFINE(dpu_hclk, "dpu_hclk",
+				 APMU_LCD_CLK_RES_CTRL1,
+				 BIT(5), BIT(5), 0x0,
+				 0);
+
+static const char * const dpu_spi_parent_names[] = {
+	"pll1_d8_307p2", "pll1_d6_409p6", "pll1_d10_245p76", "pll1_d11_223p4",
+	"pll1_d13_189", "pll1_d23_106p8", "pll2_d3", "pll2_d5"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_spi_clk, "dpu_spi_clk",
+				  dpu_spi_parent_names,
+				  APMU_LCD_SPI_CLK_RES_CTRL,
+				  8, 3, BIT(7),
+				  12, 3, BIT(1), BIT(1), 0x0,
+				  0);
+static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_hbus_clk, "dpu_spi_hbus_clk",
+				 APMU_LCD_SPI_CLK_RES_CTRL,
+				 BIT(3), BIT(3), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_bus_clk, "dpu_spi_bus_clk",
+				 APMU_LCD_SPI_CLK_RES_CTRL,
+				 BIT(5), BIT(5), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(dpu_spi_aclk, "dpu_spi_aclk",
+				 APMU_LCD_SPI_CLK_RES_CTRL,
+				 BIT(6), BIT(6), 0x0,
+				 0);
+
+static const char * const v2d_parent_names[] = {
+	"pll1_d5_491p52", "pll1_d6_409p6", "pll1_d8_307p2", "pll1_d4_614p4",
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(v2d_clk, "v2d_clk", v2d_parent_names,
+				  APMU_LCD_CLK_RES_CTRL1,
+				  9, 3, BIT(28),
+				  12, 2, BIT(8), BIT(8), 0x0,
+				  0);
+
+static const char * const ccic_4x_parent_names[] = {
+	"pll1_d5_491p52", "pll1_d6_409p6", "pll1_d4_614p4", "pll1_d3_819p2",
+	"pll2_d2", "pll2_d3", "pll2_d4", "pll1_d2_1228p8"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(ccic_4x_clk, "ccic_4x_clk",
+				  ccic_4x_parent_names,
+				  APMU_CCIC_CLK_RES_CTRL,
+				  18, 3, BIT(15),
+				  23, 2, BIT(4), BIT(4), 0x0,
+				  0);
+
+static const char * const ccic1phy_parent_names[] = {
+	"pll1_d24_102p4", "pll1_d48_51p2_ap"
+};
+static CCU_MUX_GATE_DEFINE(ccic1phy_clk, "ccic1phy_clk", ccic1phy_parent_names,
+			   APMU_CCIC_CLK_RES_CTRL,
+			   7, 1, BIT(5), BIT(5), 0x0,
+			   0);
+
+static CCU_GATE_NO_PARENT_DEFINE(sdh_axi_aclk, "sdh_axi_aclk",
+				 APMU_SDH0_CLK_RES_CTRL,
+				 BIT(3), BIT(3), 0x0,
+				 0);
+static const char * const sdh01_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d4_614p4", "pll2_d8", "pll2_d5",
+	"pll1_d11_223p4", "pll1_d13_189", "pll1_d23_106p8"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(sdh0_clk, "sdh0_clk", sdh01_parent_names,
+				  APMU_SDH0_CLK_RES_CTRL,
+				  8, 3, BIT(11),
+				  5, 3, BIT(4), BIT(4), 0x0,
+				  0);
+static CCU_DIV_FC_MUX_GATE_DEFINE(sdh1_clk, "sdh1_clk", sdh01_parent_names,
+				  APMU_SDH1_CLK_RES_CTRL,
+				  8, 3, BIT(11),
+				  5, 3, BIT(4), BIT(4), 0x0,
+				  0);
+static const char * const sdh2_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d4_614p4", "pll2_d8", "pll1_d3_819p2",
+	"pll1_d11_223p4", "pll1_d13_189", "pll1_d23_106p8"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(sdh2_clk, "sdh2_clk", sdh2_parent_names,
+				  APMU_SDH2_CLK_RES_CTRL,
+				  8, 3, BIT(11),
+				  5, 3, BIT(4), BIT(4), 0x0,
+				  0);
+
+static CCU_GATE_NO_PARENT_DEFINE(usb_axi_clk, "usb_axi_clk",
+				 APMU_USB_CLK_RES_CTRL,
+				 BIT(1), BIT(1), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(usb_p1_aclk, "usb_p1_aclk",
+				 APMU_USB_CLK_RES_CTRL,
+				 BIT(5), BIT(5), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(usb30_clk, "usb30_clk",
+				 APMU_USB_CLK_RES_CTRL,
+				 BIT(8), BIT(8), 0x0,
+				 0);
+
+static const char * const qspi_parent_names[] = {
+	"pll1_d6_409p6", "pll2_d8", "pll1_d8_307p2", "pll1_d10_245p76",
+	"pll1_d11_223p4", "pll1_d23_106p8", "pll1_d5_491p52", "pll1_d13_189"
+};
+static CCU_DIV_MFC_MUX_GATE_DEFINE(qspi_clk, "qspi_clk", qspi_parent_names,
+				   APMU_QSPI_CLK_RES_CTRL,
+				   9, 3, BIT(12),
+				   6, 3, BIT(4), BIT(4), 0x0,
+				   0);
+static CCU_GATE_NO_PARENT_DEFINE(qspi_bus_clk, "qspi_bus_clk",
+				 APMU_QSPI_CLK_RES_CTRL,
+				 BIT(3), BIT(3), 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(dma_clk, "dma_clk",
+				 APMU_DMA_CLK_RES_CTRL,
+				 BIT(3), BIT(3), 0x0,
+				 0);
+
+static const char * const aes_parent_names[] = {
+	"pll1_d12_204p8", "pll1_d24_102p4"
+};
+static CCU_MUX_GATE_DEFINE(aes_clk, "aes_clk", aes_parent_names,
+			   APMU_AES_CLK_RES_CTRL,
+			   6, 1, BIT(5), BIT(5), 0x0,
+			   0);
+
+static const char * const vpu_parent_names[] = {
+	"pll1_d4_614p4", "pll1_d5_491p52", "pll1_d3_819p2", "pll1_d6_409p6",
+	"pll3_d6", "pll2_d3", "pll2_d4", "pll2_d5"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(vpu_clk, "vpu_clk", vpu_parent_names,
+				  APMU_VPU_CLK_RES_CTRL,
+				  13, 3, BIT(21),
+				  10, 3,
+				  BIT(3), BIT(3), 0x0,
+				  0);
+
+static const char * const gpu_parent_names[] = {
+	"pll1_d4_614p4", "pll1_d5_491p52", "pll1_d3_819p2", "pll1_d6_409p6",
+	"pll3_d6", "pll2_d3", "pll2_d4", "pll2_d5"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(gpu_clk, "gpu_clk", gpu_parent_names,
+				  APMU_GPU_CLK_RES_CTRL,
+				  12, 3, BIT(15),
+				  18, 3,
+				  BIT(4), BIT(4), 0x0,
+				  0);
+
+static const char * const emmc_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d4_614p4", "pll1_d52_47p26", "pll1_d3_819p2"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(emmc_clk, "emmc_clk", emmc_parent_names,
+				  APMU_PMUA_EM_CLK_RES_CTRL,
+				  8, 3, BIT(11),
+				  6, 2,
+				  0x18, 0x18, 0x0,
+				  0);
+static CCU_DIV_GATE_DEFINE(emmc_x_clk, "emmc_x_clk", "pll1_d2_1228p8",
+			   APMU_PMUA_EM_CLK_RES_CTRL,
+			   12, 3, BIT(15), BIT(15), 0x0,
+			   0);
+
+static const char * const audio_parent_names[] = {
+	"pll1_aud_245p7", "pll1_d8_307p2", "pll1_d6_409p6"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(audio_clk, "audio_clk", audio_parent_names,
+				  APMU_AUDIO_CLK_RES_CTRL,
+				  4, 3, BIT(15),
+				  7, 3,
+				  BIT(12), BIT(12), 0x0,
+				  0);
+
+static const char * const hdmi_parent_names[] = {
+	"pll1_d6_409p6", "pll1_d5_491p52", "pll1_d4_614p4", "pll1_d8_307p2"
+};
+static CCU_DIV_FC_MUX_GATE_DEFINE(hdmi_mclk, "hdmi_mclk", hdmi_parent_names,
+				  APMU_HDMI_CLK_RES_CTRL,
+				  1, 4, BIT(29),
+				  5, 3,
+				  BIT(0), BIT(0), 0x0,
+				  0);
+
+static const char * const pmua_aclk_parent_names[] = {
+	"pll1_d10_245p76", "pll1_d8_307p2"
+};
+static CCU_DIV_FC_MUX_DEFINE(pmua_aclk, "pmua_aclk", pmua_aclk_parent_names,
+			     APMU_ACLK_CLK_CTRL,
+			     1, 2, BIT(4),
+			     0, 1,
+			     0);
+
+static CCU_GATE_NO_PARENT_DEFINE(pcie0_clk, "pcie0_clk",
+				 APMU_PCIE_CLK_RES_CTRL_0,
+				 0x7, 0x7, 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(pcie1_clk, "pcie1_clk",
+				 APMU_PCIE_CLK_RES_CTRL_1,
+				 0x7, 0x7, 0x0,
+				 0);
+static CCU_GATE_NO_PARENT_DEFINE(pcie2_clk, "pcie2_clk",
+				 APMU_PCIE_CLK_RES_CTRL_2,
+				 0x7, 0x7, 0x0,
+				 0);
+
+static CCU_GATE_NO_PARENT_DEFINE(emac0_bus_clk, "emac0_bus_clk",
+				 APMU_EMAC0_CLK_RES_CTRL,
+				 BIT(0), BIT(0), 0x0,
+				 0);
+static CCU_GATE_DEFINE(emac0_ptp_clk, "emac0_ptp_clk", "pll2_d6",
+		       APMU_EMAC0_CLK_RES_CTRL,
+		       BIT(15), BIT(15), 0x0,
+		       0);
+static CCU_GATE_NO_PARENT_DEFINE(emac1_bus_clk, "emac1_bus_clk",
+				 APMU_EMAC1_CLK_RES_CTRL,
+				 BIT(0), BIT(0), 0x0,
+				 0);
+static CCU_GATE_DEFINE(emac1_ptp_clk, "emac1_ptp_clk", "pll2_d6",
+		       APMU_EMAC1_CLK_RES_CTRL,
+		       BIT(15), BIT(15), 0x0,
+		       0);
+/*	APMU clocks end		*/
+
+static struct clk_hw_onecell_data k1_ccu_apbs_clks = {
+	.hws = {
+		[CLK_PLL1]		= &pll1.common.hw,
+		[CLK_PLL2]		= &pll2.common.hw,
+		[CLK_PLL3]		= &pll3.common.hw,
+		[CLK_PLL1_D2]		= &pll1_d2.common.hw,
+		[CLK_PLL1_D3]		= &pll1_d3.common.hw,
+		[CLK_PLL1_D4]		= &pll1_d4.common.hw,
+		[CLK_PLL1_D5]		= &pll1_d5.common.hw,
+		[CLK_PLL1_D6]		= &pll1_d6.common.hw,
+		[CLK_PLL1_D7]		= &pll1_d7.common.hw,
+		[CLK_PLL1_D8]		= &pll1_d8.common.hw,
+		[CLK_PLL1_D11]		= &pll1_d11_223p4.common.hw,
+		[CLK_PLL1_D13]		= &pll1_d13_189.common.hw,
+		[CLK_PLL1_D23]		= &pll1_d23_106p8.common.hw,
+		[CLK_PLL1_D64]		= &pll1_d64_38p4.common.hw,
+		[CLK_PLL1_D10_AUD]	= &pll1_aud_245p7.common.hw,
+		[CLK_PLL1_D100_AUD]	= &pll1_aud_24p5.common.hw,
+		[CLK_PLL2_D1]		= &pll2_d1.common.hw,
+		[CLK_PLL2_D2]		= &pll2_d2.common.hw,
+		[CLK_PLL2_D3]		= &pll2_d3.common.hw,
+		[CLK_PLL2_D3]		= &pll2_d4.common.hw,
+		[CLK_PLL2_D5]		= &pll2_d5.common.hw,
+		[CLK_PLL2_D6]		= &pll2_d6.common.hw,
+		[CLK_PLL2_D7]		= &pll2_d7.common.hw,
+		[CLK_PLL2_D8]		= &pll2_d8.common.hw,
+		[CLK_PLL3_D1]		= &pll3_d1.common.hw,
+		[CLK_PLL3_D2]		= &pll3_d2.common.hw,
+		[CLK_PLL3_D3]		= &pll3_d3.common.hw,
+		[CLK_PLL3_D4]		= &pll3_d4.common.hw,
+		[CLK_PLL3_D5]		= &pll3_d5.common.hw,
+		[CLK_PLL3_D6]		= &pll3_d6.common.hw,
+		[CLK_PLL3_D7]		= &pll3_d7.common.hw,
+		[CLK_PLL3_D8]		= &pll3_d8.common.hw,
+		[CLK_PLL3_80]		= &pll3_80.common.hw,
+		[CLK_PLL3_40]		= &pll3_40.common.hw,
+		[CLK_PLL3_20]		= &pll3_20.common.hw,
+
+	},
+	.num = CLK_APBS_NUM,
+};
+
+static struct clk_hw_onecell_data k1_ccu_mpmu_clks = {
+	.hws = {
+		[CLK_PLL1_307P2]	= &pll1_d8_307p2.common.hw,
+		[CLK_PLL1_76P8]		= &pll1_d32_76p8.common.hw,
+		[CLK_PLL1_61P44]	= &pll1_d40_61p44.common.hw,
+		[CLK_PLL1_153P6]	= &pll1_d16_153p6.common.hw,
+		[CLK_PLL1_102P4]	= &pll1_d24_102p4.common.hw,
+		[CLK_PLL1_51P2]		= &pll1_d48_51p2.common.hw,
+		[CLK_PLL1_51P2_AP]	= &pll1_d48_51p2_ap.common.hw,
+		[CLK_PLL1_57P6]		= &pll1_m3d128_57p6.common.hw,
+		[CLK_PLL1_25P6]		= &pll1_d96_25p6.common.hw,
+		[CLK_PLL1_12P8]		= &pll1_d192_12p8.common.hw,
+		[CLK_PLL1_12P8_WDT]	= &pll1_d192_12p8_wdt.common.hw,
+		[CLK_PLL1_6P4]		= &pll1_d384_6p4.common.hw,
+		[CLK_PLL1_3P2]		= &pll1_d768_3p2.common.hw,
+		[CLK_PLL1_1P6]		= &pll1_d1536_1p6.common.hw,
+		[CLK_PLL1_0P8]		= &pll1_d3072_0p8.common.hw,
+		[CLK_PLL1_351]		= &pll1_d7_351p08.common.hw,
+		[CLK_PLL1_409P6]	= &pll1_d6_409p6.common.hw,
+		[CLK_PLL1_204P8]	= &pll1_d12_204p8.common.hw,
+		[CLK_PLL1_491]		= &pll1_d5_491p52.common.hw,
+		[CLK_PLL1_245P76]	= &pll1_d10_245p76.common.hw,
+		[CLK_PLL1_614]		= &pll1_d4_614p4.common.hw,
+		[CLK_PLL1_47P26]	= &pll1_d52_47p26.common.hw,
+		[CLK_PLL1_31P5]		= &pll1_d78_31p5.common.hw,
+		[CLK_PLL1_819]		= &pll1_d3_819p2.common.hw,
+		[CLK_PLL1_1228]		= &pll1_d2_1228p8.common.hw,
+		[CLK_SLOW_UART]		= &slow_uart.common.hw,
+		[CLK_SLOW_UART1]	= &slow_uart1_14p74.common.hw,
+		[CLK_SLOW_UART2]	= &slow_uart2_48.common.hw,
+		[CLK_WDT]		= &wdt_clk.common.hw,
+		[CLK_RIPC]		= &ripc_clk.common.hw,
+		[CLK_I2S_SYSCLK]	= &i2s_sysclk.common.hw,
+		[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
+		[CLK_APB]		= &apb_clk.common.hw,
+	},
+	.num = CLK_MPMU_NUM,
+};
+
+static struct clk_hw_onecell_data k1_ccu_apbc_clks = {
+	.hws = {
+		[CLK_UART0]		= &uart0_clk.common.hw,
+		[CLK_UART2]		= &uart2_clk.common.hw,
+		[CLK_UART3]		= &uart3_clk.common.hw,
+		[CLK_UART4]		= &uart4_clk.common.hw,
+		[CLK_UART5]		= &uart5_clk.common.hw,
+		[CLK_UART6]		= &uart6_clk.common.hw,
+		[CLK_UART7]		= &uart7_clk.common.hw,
+		[CLK_UART8]		= &uart8_clk.common.hw,
+		[CLK_UART9]		= &uart9_clk.common.hw,
+		[CLK_GPIO]		= &gpio_clk.common.hw,
+		[CLK_PWM0]		= &pwm0_clk.common.hw,
+		[CLK_PWM1]		= &pwm1_clk.common.hw,
+		[CLK_PWM2]		= &pwm2_clk.common.hw,
+		[CLK_PWM3]		= &pwm3_clk.common.hw,
+		[CLK_PWM4]		= &pwm4_clk.common.hw,
+		[CLK_PWM5]		= &pwm5_clk.common.hw,
+		[CLK_PWM6]		= &pwm6_clk.common.hw,
+		[CLK_PWM7]		= &pwm7_clk.common.hw,
+		[CLK_PWM8]		= &pwm8_clk.common.hw,
+		[CLK_PWM9]		= &pwm9_clk.common.hw,
+		[CLK_PWM10]		= &pwm10_clk.common.hw,
+		[CLK_PWM11]		= &pwm11_clk.common.hw,
+		[CLK_PWM12]		= &pwm12_clk.common.hw,
+		[CLK_PWM13]		= &pwm13_clk.common.hw,
+		[CLK_PWM14]		= &pwm14_clk.common.hw,
+		[CLK_PWM15]		= &pwm15_clk.common.hw,
+		[CLK_PWM16]		= &pwm16_clk.common.hw,
+		[CLK_PWM17]		= &pwm17_clk.common.hw,
+		[CLK_PWM18]		= &pwm18_clk.common.hw,
+		[CLK_PWM19]		= &pwm19_clk.common.hw,
+		[CLK_SSP3]		= &ssp3_clk.common.hw,
+		[CLK_RTC]		= &rtc_clk.common.hw,
+		[CLK_TWSI0]		= &twsi0_clk.common.hw,
+		[CLK_TWSI1]		= &twsi1_clk.common.hw,
+		[CLK_TWSI2]		= &twsi2_clk.common.hw,
+		[CLK_TWSI4]		= &twsi4_clk.common.hw,
+		[CLK_TWSI5]		= &twsi5_clk.common.hw,
+		[CLK_TWSI6]		= &twsi6_clk.common.hw,
+		[CLK_TWSI7]		= &twsi7_clk.common.hw,
+		[CLK_TWSI8]		= &twsi8_clk.common.hw,
+		[CLK_TIMERS1]		= &timers1_clk.common.hw,
+		[CLK_TIMERS2]		= &timers2_clk.common.hw,
+		[CLK_AIB]		= &aib_clk.common.hw,
+		[CLK_ONEWIRE]		= &onewire_clk.common.hw,
+		[CLK_SSPA0]		= &sspa0_clk.common.hw,
+		[CLK_SSPA1]		= &sspa1_clk.common.hw,
+		[CLK_DRO]		= &dro_clk.common.hw,
+		[CLK_IR]		= &ir_clk.common.hw,
+		[CLK_TSEN]		= &tsen_clk.common.hw,
+		[CLK_IPC_AP2AUD]	= &ipc_ap2aud_clk.common.hw,
+		[CLK_CAN0]		= &can0_clk.common.hw,
+		[CLK_CAN0_BUS]		= &can0_bus_clk.common.hw,
+	},
+	.num = CLK_APBC_NUM,
+};
+
+static struct clk_hw_onecell_data k1_ccu_apmu_clks = {
+	.hws = {
+		[CLK_CCI550]		= &cci550_clk.common.hw,
+		[CLK_CPU_C0_HI]		= &cpu_c0_hi_clk.common.hw,
+		[CLK_CPU_C0_CORE]	= &cpu_c0_core_clk.common.hw,
+		[CLK_CPU_C0_ACE]	= &cpu_c0_ace_clk.common.hw,
+		[CLK_CPU_C0_TCM]	= &cpu_c0_tcm_clk.common.hw,
+		[CLK_CPU_C1_HI]		= &cpu_c1_hi_clk.common.hw,
+		[CLK_CPU_C1_CORE]	= &cpu_c1_core_clk.common.hw,
+		[CLK_CPU_C1_ACE]	= &cpu_c1_ace_clk.common.hw,
+		[CLK_CCIC_4X]		= &ccic_4x_clk.common.hw,
+		[CLK_CCIC1PHY]		= &ccic1phy_clk.common.hw,
+		[CLK_SDH_AXI]		= &sdh_axi_aclk.common.hw,
+		[CLK_SDH0]		= &sdh0_clk.common.hw,
+		[CLK_SDH1]		= &sdh1_clk.common.hw,
+		[CLK_SDH2]		= &sdh2_clk.common.hw,
+		[CLK_USB_P1]		= &usb_p1_aclk.common.hw,
+		[CLK_USB_AXI]		= &usb_axi_clk.common.hw,
+		[CLK_USB30]		= &usb30_clk.common.hw,
+		[CLK_QSPI]		= &qspi_clk.common.hw,
+		[CLK_QSPI_BUS]		= &qspi_bus_clk.common.hw,
+		[CLK_DMA]		= &dma_clk.common.hw,
+		[CLK_AES]		= &aes_clk.common.hw,
+		[CLK_VPU]		= &vpu_clk.common.hw,
+		[CLK_GPU]		= &gpu_clk.common.hw,
+		[CLK_EMMC]		= &emmc_clk.common.hw,
+		[CLK_EMMC_X]		= &emmc_x_clk.common.hw,
+		[CLK_AUDIO]		= &audio_clk.common.hw,
+		[CLK_HDMI]		= &hdmi_mclk.common.hw,
+		[CLK_PMUA_ACLK]		= &pmua_aclk.common.hw,
+		[CLK_PCIE0]		= &pcie0_clk.common.hw,
+		[CLK_PCIE1]		= &pcie1_clk.common.hw,
+		[CLK_PCIE2]		= &pcie2_clk.common.hw,
+		[CLK_EMAC0_BUS]		= &emac0_bus_clk.common.hw,
+		[CLK_EMAC0_PTP]		= &emac0_ptp_clk.common.hw,
+		[CLK_EMAC1_BUS]		= &emac1_bus_clk.common.hw,
+		[CLK_EMAC1_PTP]		= &emac1_ptp_clk.common.hw,
+		[CLK_JPG]		= &jpg_clk.common.hw,
+		[CLK_JPF_4KAFBC]	= &jpg_4kafbc_clk.common.hw,
+		[CLK_JPF_2KAFBC]	= &jpg_2kafbc_clk.common.hw,
+		[CLK_CCIC2PHY]		= &ccic2phy_clk.common.hw,
+		[CLK_CCIC3PHY]		= &ccic3phy_clk.common.hw,
+		[CLK_CSI]		= &csi_clk.common.hw,
+		[CLK_CAMM0]		= &camm0_clk.common.hw,
+		[CLK_CAMM1]		= &camm1_clk.common.hw,
+		[CLK_CAMM2]		= &camm2_clk.common.hw,
+		[CLK_ISP_CPP]		= &isp_cpp_clk.common.hw,
+		[CLK_ISP_BUS]		= &isp_bus_clk.common.hw,
+		[CLK_ISP]		= &isp_clk.common.hw,
+		[CLK_DPU_MCLK]		= &dpu_mclk.common.hw,
+		[CLK_DPU_ESC]		= &dpu_esc_clk.common.hw,
+		[CLK_DPU_BIT]		= &dpu_bit_clk.common.hw,
+		[CLK_DPU_PXCLK]		= &dpu_pxclk.common.hw,
+		[CLK_DPU_HCLK]		= &dpu_hclk.common.hw,
+		[CLK_DPU_SPI]		= &dpu_spi_clk.common.hw,
+		[CLK_DPU_SPI_HBUS]	= &dpu_spi_hbus_clk.common.hw,
+		[CLK_DPU_SPIBUS]	= &dpu_spi_bus_clk.common.hw,
+		[CLK_DPU_SPI_ACLK]	= &dpu_spi_aclk.common.hw,
+		[CLK_V2D]		= &v2d_clk.common.hw,
+	},
+	.num = CLK_APMU_NUM
+};
+
+struct spacemit_ccu_data {
+	struct clk_hw_onecell_data *hw_clks;
+	bool need_pll_lock;
+};
+
+struct spacemit_ccu_priv {
+	const struct spacemit_ccu_data *data;
+	struct regmap *base;
+	struct regmap *lock_base;
+	spinlock_t lock;
+};
+
+static int spacemit_ccu_register(struct device *dev,
+				 struct spacemit_ccu_priv *priv)
+{
+	const struct spacemit_ccu_data *data = priv->data;
+	int i, ret;
+
+	for (i = 0; i < data->hw_clks->num; i++) {
+		struct clk_hw *hw = data->hw_clks->hws[i];
+		struct ccu_common *common;
+		const char *name;
+
+		if (!hw)
+			continue;
+
+		common = hw_to_ccu_common(hw);
+		name = hw->init->name;
+
+		common->lock		= &priv->lock;
+		common->base		= priv->base;
+		common->lock_base	= priv->lock_base;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Cannot register clock %d - %s\n",
+				i, name);
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   data->hw_clks);
+}
+
+static int k1_ccu_probe(struct platform_device *pdev)
+{
+	const struct spacemit_ccu_data *data;
+	struct regmap *base_map, *lock_map;
+	struct device *dev = &pdev->dev;
+	struct spacemit_ccu_priv *priv;
+	struct device_node *parent;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (WARN_ON(!data))
+		return -EINVAL;
+
+	parent   = of_get_parent(dev->of_node);
+	base_map = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+
+	if (IS_ERR(base_map))
+		return dev_err_probe(dev, PTR_ERR(base_map),
+				     "failed to get regmap\n");
+
+	if (data->need_pll_lock) {
+		lock_map = syscon_regmap_lookup_by_phandle(dev->of_node,
+							   "spacemit,mpmu");
+		if (IS_ERR(lock_map))
+			return dev_err_probe(dev, PTR_ERR(lock_map),
+					     "failed to get lock regmap\n");
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data	= data;
+	priv->base	= base_map;
+	priv->lock_base	= lock_map;
+	spin_lock_init(&priv->lock);
+
+	ret = spacemit_ccu_register(dev, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register clocks");
+
+	return 0;
+}
+
+static const struct spacemit_ccu_data k1_ccu_apbs_data = {
+	.need_pll_lock	= true,
+	.hw_clks	= &k1_ccu_apbs_clks,
+};
+
+static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &k1_ccu_mpmu_clks,
+};
+
+static const struct spacemit_ccu_data k1_ccu_apbc_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &k1_ccu_apbc_clks,
+};
+
+static const struct spacemit_ccu_data k1_ccu_apmu_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &k1_ccu_apmu_clks,
+};
+
+static const struct of_device_id of_k1_ccu_match[] = {
+	{
+		.compatible	= "spacemit,k1-ccu-apbs",
+		.data		= &k1_ccu_apbs_data,
+	},
+	{
+		.compatible	= "spacemit,k1-ccu-mpmu",
+		.data		= &k1_ccu_mpmu_data,
+	},
+	{
+		.compatible	= "spacemit,k1-ccu-apbc",
+		.data		= &k1_ccu_apbc_data,
+	},
+	{
+		.compatible	= "spacemit,k1-ccu-apmu",
+		.data		= &k1_ccu_apmu_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
+
+static struct platform_driver k1_ccu_driver = {
+	.driver = {
+		.name		= "spacemit,k1-ccu",
+		.of_match_table = of_k1_ccu_match,
+	},
+	.probe	= k1_ccu_probe,
+};
+module_platform_driver(k1_ccu_driver);
+
+MODULE_DESCRIPTION("Spacemit K1 CCU driver");
+MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
new file mode 100644
index 000000000000..c4406099c3fc
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_common.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_COMMON_H_
+#define _CCU_COMMON_H_
+
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+enum ccu_div_type {
+	CLK_DIV_TYPE_1REG_NOFC_V1 = 0,
+	CLK_DIV_TYPE_1REG_FC_V2,
+	CLK_DIV_TYPE_2REG_NOFC_V3,
+	CLK_DIV_TYPE_2REG_FC_V4,
+	CLK_DIV_TYPE_1REG_FC_DIV_V5,
+	CLK_DIV_TYPE_1REG_FC_MUX_V6,
+};
+
+struct ccu_common {
+	struct regmap *base;
+	struct regmap *lock_base;
+	spinlock_t *lock;
+
+	enum ccu_div_type reg_type;
+	u32 reg_ctrl;
+	u32 reg_sel;
+	u32 reg_xtc;
+	u32 fc;
+	bool is_pll;
+
+	unsigned long flags;
+	const char *name;
+	const char * const *parent_names;
+	int num_parents;
+
+	struct clk_hw hw;
+};
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+#define ccu_read(reg, c, val)	regmap_read((c)->base, (c)->reg_##reg, val)
+#define ccu_write(reg, c, val)	regmap_write((c)->base, (c)->reg_##reg, val)
+#define ccu_update(reg, c, mask, val) \
+	regmap_update_bits((c)->base, (c)->reg_##reg, mask, val)
+#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
+	regmap_read_poll_timeout_atomic((c)->base, (c)->reg_##reg,	\
+					tmp, cond, sleep, timeout)
+
+#endif /* _CCU_COMMON_H_ */
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
new file mode 100644
index 000000000000..2672da6b6179
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type ddn
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_ddn.h"
+
+#define ddn_read_sel(common, val)	ccu_read(sel, common, val)
+#define ddn_read_ctrl(common, val)	ccu_read(ctrl, common, val)
+#define ddn_update_sel(common, m, v)	ccu_update(sel, common, m, v)
+#define ddn_update_ctrl(common, m, v)	ccu_update(ctrl, common, m, v)
+
+/*
+ * It is M/N clock
+ *
+ * Fout from synthesizer can be given from two equations:
+ * numerator/denominator = Fin / (Fout * factor)
+ */
+static void ccu_ddn_disable(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	unsigned long flags;
+
+	if (!ddn->gate)
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	ddn_update_sel(common, ddn->gate, 0);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static int ccu_ddn_enable(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	unsigned long flags;
+
+	if (!ddn->gate)
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	ddn_update_sel(common, ddn->gate, ddn->gate);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static int ccu_ddn_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	u32 tmp;
+
+	if (!ddn->gate)
+		return 1;
+
+	ddn_read_sel(common, &tmp);
+
+	return tmp & ddn->gate;
+}
+
+static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long drate,
+			       unsigned long *prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	unsigned long rate = 0, prev_rate;
+	unsigned long result;
+	int i;
+
+	for (i = 0; i < params->tbl_size; i++) {
+		prev_rate = rate;
+		rate = (((*prate / 10000) * params->tbl[i].den) /
+			(params->tbl[i].num * params->info->factor)) * 10000;
+		if (rate > drate)
+			break;
+	}
+
+	if ((i == 0) || (i == params->tbl_size)) {
+		result = rate;
+	} else {
+		if ((drate - prev_rate) > (rate - drate))
+			result = rate;
+		else
+			result = prev_rate;
+	}
+
+	return result;
+}
+
+static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	unsigned int val, num, den;
+	unsigned long rate;
+
+	ddn_read_ctrl(&ddn->common, &val);
+
+	num = (val >> params->info->num_shift) & params->info->num_mask;
+	den = (val >> params->info->den_shift) & params->info->den_mask;
+
+	if (!den)
+		return 0;
+
+	rate = ((parent_rate / 10000)  * den) / (num * params->info->factor);
+	rate *= 10000;
+
+	return rate;
+}
+
+/* Configures new clock rate*/
+static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long drate,
+			    unsigned long prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	struct ccu_ddn_info *info = params->info;
+	unsigned long prev_rate, rate = 0;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < params->tbl_size; i++) {
+		prev_rate = rate;
+		rate = ((prate / 10000) * params->tbl[i].den) /
+		       (params->tbl[i].num * info->factor);
+		rate *= 10000;
+
+		if (rate > drate)
+			break;
+	}
+
+	if (i > 0)
+		i--;
+
+	spin_lock_irqsave(ddn->common.lock, flags);
+
+	ddn_update_ctrl(&ddn->common,
+			info->num_mask | info->den_mask,
+			(params->tbl[i].num << info->num_shift) |
+			(params->tbl[i].den << info->den_shift));
+
+	spin_unlock_irqrestore(ddn->common.lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops spacemit_ccu_ddn_ops = {
+	.disable	= ccu_ddn_disable,
+	.enable		= ccu_ddn_enable,
+	.is_enabled	= ccu_ddn_is_enabled,
+	.recalc_rate	= clk_ddn_recalc_rate,
+	.round_rate	= clk_ddn_round_rate,
+	.set_rate	= clk_ddn_set_rate,
+};
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
new file mode 100644
index 000000000000..ffbbe073199b
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenayy@outlook.com>
+ */
+
+#ifndef _CCU_DDN_H_
+#define _CCU_DDN_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_ddn_tbl {
+	unsigned int num;
+	unsigned int den;
+};
+
+struct ccu_ddn_info {
+	unsigned int factor;
+	unsigned int num_mask;
+	unsigned int den_mask;
+	unsigned int num_shift;
+	unsigned int den_shift;
+};
+
+struct ccu_ddn_config {
+	struct ccu_ddn_info *info;
+	struct ccu_ddn_tbl *tbl;
+	u32 tbl_size;
+};
+
+struct ccu_ddn {
+	struct ccu_ddn_config  ddn;
+	struct ccu_common	common;
+	u32 gate;
+};
+
+#define CCU_DDN_CONFIG(_info, _table)					\
+	{								\
+		.info		= (struct ccu_ddn_info *)_info,		\
+		.tbl		= (struct ccu_ddn_tbl *)&_table,	\
+		.tbl_size	= ARRAY_SIZE(_table),			\
+	}
+
+#define CCU_DDN_DEFINE(_struct, _name, _parent, _info, _table,		\
+		       _reg_ctrl, _flags)				\
+	struct ccu_ddn _struct = {					\
+		.ddn	= CCU_DDN_CONFIG(_info, _table),		\
+		.common = {						\
+			.reg_ctrl = _reg_ctrl,				\
+			.hw.init  = CLK_HW_INIT(_name, _parent,		\
+					       &spacemit_ccu_ddn_ops,	\
+					       _flags),			\
+		}							\
+	}
+
+#define CCU_DDN_GATE_DEFINE(_struct, _name, _parent, _info, _table,	\
+			    _reg_ddn, _reg_gate, _gate_mask, _flags)	\
+	struct ccu_ddn _struct = {					\
+		.ddn	= CCU_DDN_CONFIG(_info, _table),		\
+		.common = {						\
+			.reg_ctrl	= _reg_ddn,			\
+			.reg_sel	= _reg_gate,			\
+			.hw.init = CLK_HW_INIT(_name, _parent,		\
+					       &spacemit_ccu_ddn_ops,	\
+					       _flags),			\
+		}							\
+		.gate	= _gate_mask,					\
+	}
+
+
+static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_ddn, common);
+}
+
+extern const struct clk_ops spacemit_ccu_ddn_ops;
+
+#endif
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
new file mode 100644
index 000000000000..750882b6ed93
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type mix(div/mux/gate/factor)
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_mix.h"
+
+#define MIX_TIMEOUT	10000
+
+#define mix_read_sel(c, val)		ccu_read(sel, c, val)
+#define mix_read_ctrl(c, val)		ccu_read(ctrl, c, val)
+#define mix_update_sel(c, m, v)		ccu_update(sel, c, m, v)
+#define mix_update_ctrl(c, m, v)	ccu_update(ctrl, c, m, v)
+
+#define mix_hwparam_in_sel(c) \
+	((c)->reg_type == CLK_DIV_TYPE_2REG_NOFC_V3 || \
+	 (c)->reg_type == CLK_DIV_TYPE_2REG_FC_V4)
+
+static void ccu_mix_disable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	unsigned long flags = 0;
+
+	if (!gate)
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, gate->gate_mask, gate->val_disable);
+	else
+		mix_update_ctrl(common, gate->gate_mask, gate->val_disable);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static int ccu_mix_enable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	u32 val_enable, mask;
+	unsigned long flags;
+	u32 tmp;
+
+	if (!gate)
+		return 0;
+
+	val_enable	= gate->val_enable;
+	mask		= gate->gate_mask;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, mask, val_enable);
+	else
+		mix_update_ctrl(common, mask, val_enable);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	if (common->reg_type == CLK_DIV_TYPE_2REG_NOFC_V3 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4)
+		return ccu_poll(sel, common, tmp, (tmp & mask) == val_enable,
+				10, MIX_TIMEOUT);
+	else
+		return ccu_poll(ctrl, common, tmp, (tmp & mask) == val_enable,
+				10, MIX_TIMEOUT);
+}
+
+static int ccu_mix_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	unsigned long flags = 0;
+	u32 tmp;
+
+	if (!gate)
+		return 1;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &tmp);
+	else
+		mix_read_ctrl(common, &tmp);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return (tmp & gate->gate_mask) == gate->val_enable;
+}
+
+static unsigned long ccu_mix_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div;
+	unsigned long val;
+	u32 reg;
+
+	if (!div) {
+		if (mix->factor)
+			return parent_rate * mix->factor->mul / mix->factor->div;
+
+		return parent_rate;
+	}
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &reg);
+	else
+		mix_read_ctrl(common, &reg);
+
+	val = reg >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	val = divider_recalc_rate(hw, parent_rate, val, div->table,
+				  div->flags, div->width);
+
+	return val;
+}
+
+
+static int ccu_mix_trigger_fc(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	int ret = 0, timeout = 50;
+	unsigned int val = 0;
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_DIV_V5 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_MUX_V6) {
+		timeout = 50;
+		mix_update_ctrl(common, common->fc, common->fc);
+
+		ret = ccu_poll(ctrl, common, val, !(val & common->fc),
+			       5, MIX_TIMEOUT);
+	}
+
+	return ret;
+}
+
+static int ccu_mix_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	return 0;
+}
+
+static long ccu_mix_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	return rate;
+}
+
+static unsigned long
+ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate, u32 *mux_val,
+		       u32 *div_val)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div ? mix->div : NULL;
+	struct clk_hw *parent;
+	unsigned long parent_rate = 0, best_rate = 0;
+	u32 i, j, div_max;
+
+	for (i = 0; i < common->num_parents; i++) {
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+
+		if (div)
+			div_max = 1 << div->width;
+		else
+			div_max = 1;
+
+		for (j = 1; j <= div_max; j++) {
+			if (abs(parent_rate/j - rate) < abs(best_rate - rate)) {
+				best_rate = DIV_ROUND_UP_ULL(parent_rate, j);
+				*mux_val = i;
+				*div_val = j - 1;
+			}
+		}
+	}
+
+	return best_rate;
+}
+
+static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div;
+	struct ccu_mux_config *mux = mix->mux;
+	u32 cur_mux, cur_div, mux_val = 0, div_val = 0;
+	unsigned long best_rate = 0;
+	unsigned long flags;
+	int ret = 0, tmp = 0;
+
+	if (!div && !mux)
+		return 0;
+
+	best_rate = ccu_mix_calc_best_rate(hw, rate, &mux_val, &div_val);
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &tmp);
+	else
+		mix_read_ctrl(common, &tmp);
+
+	if (mux) {
+		cur_mux = tmp >> mux->shift;
+		cur_mux &= (1 << mux->width) - 1;
+
+		if (cur_mux != mux_val)
+			clk_hw_set_parent(hw,
+					  clk_hw_get_parent_by_index(hw,
+								     mux_val));
+	}
+
+	if (div) {
+		cur_div = tmp >> div->shift;
+		cur_div &= (1 << div->width) - 1;
+
+		if (cur_div == div_val)
+			return 0;
+	} else {
+		return 0;
+	}
+
+	tmp = GENMASK(div->width + div->shift - 1, div->shift);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, tmp, div_val << div->shift);
+	else
+		mix_update_ctrl(common, tmp, div_val << div->shift);
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_DIV_V5)
+		ret = ccu_mix_trigger_fc(hw);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return ret;
+}
+
+static u8 ccu_mix_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_mux_config *mux = mix->mux;
+	u32 reg;
+	u8 parent;
+
+	if (!mux)
+		return 0;
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &reg);
+	else
+		mix_read_ctrl(common, &reg);
+
+	parent = reg >> mux->shift;
+	parent &= (1 << mux->width) - 1;
+
+	if (mux->table) {
+		int num_parents = clk_hw_get_num_parents(&common->hw);
+		int i;
+
+		for (i = 0; i < num_parents; i++)
+			if (mux->table[i] == parent)
+				return i;
+	}
+
+	return parent;
+}
+
+static int ccu_mix_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_mux_config *mux = mix->mux;
+	unsigned long flags;
+	int ret = 0;
+	u32 mask;
+
+	if (!mux)
+		return 0;
+
+	if (mux->table)
+		index = mux->table[index];
+
+	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, mask, index << mux->shift);
+	else
+		mix_update_ctrl(common, mask, index << mux->shift);
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_MUX_V6)
+		ret = ccu_mix_trigger_fc(hw);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return ret;
+}
+
+const struct clk_ops spacemit_ccu_mix_ops = {
+	.disable	 = ccu_mix_disable,
+	.enable		 = ccu_mix_enable,
+	.is_enabled	 = ccu_mix_is_enabled,
+	.get_parent	 = ccu_mix_get_parent,
+	.set_parent	 = ccu_mix_set_parent,
+	.determine_rate  = ccu_mix_determine_rate,
+	.round_rate	 = ccu_mix_round_rate,
+	.recalc_rate	 = ccu_mix_recalc_rate,
+	.set_rate	 = ccu_mix_set_rate,
+};
+
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
new file mode 100644
index 000000000000..753bc6177df7
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -0,0 +1,348 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_MIX_H_
+#define _CCU_MIX_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_gate_config {
+	u32 gate_mask;
+	u32 val_enable;
+	u32 val_disable;
+	u32 flags;
+};
+
+struct ccu_factor_config {
+	u32 div;
+	u32 mul;
+};
+
+struct ccu_mux_config {
+	const u8 *table;
+	u32 flags;
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_div_config {
+	struct clk_div_table *table;
+	u32 max;
+	u32 offset;
+	u32 flags;
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_mix {
+	struct ccu_factor_config *factor;
+	struct ccu_gate_config *gate;
+	struct ccu_div_config *div;
+	struct ccu_mux_config *mux;
+	struct ccu_common common;
+};
+
+#define CCU_GATE_INIT(_gate_mask, _val_enable, _val_disable, _flags)		\
+	(&(struct ccu_gate_config) {						\
+		.gate_mask   = _gate_mask,					\
+		.val_enable  = _val_enable,					\
+		.val_disable = _val_disable,					\
+		.flags	     = _flags,						\
+	})
+
+#define CCU_FACTOR_INIT(_div, _mul)					\
+	(&(struct ccu_factor_config) {					\
+		.div = _div,						\
+		.mul = _mul,						\
+	})
+
+
+#define CCU_MUX_INIT(_shift, _width, _table, _flags)			\
+	(&(struct ccu_mux_config) {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.table	= _table,					\
+		.flags	= _flags,					\
+	})
+
+#define CCU_DIV_INIT(_shift, _width, _table, _flags)			\
+	(&(struct ccu_div_config) {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+		.table	= _table,					\
+	})
+
+#define CCU_MIX_INITHW(_name, _parent, _flags) \
+	CLK_HW_INIT(_name, _parent, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_MIX_ORPHAN_INITHW(_name, _flags) \
+	CLK_HW_INIT_NO_PARENT(_name, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_MIX_INITHW_PARENTS(_name, _parents, _flags) \
+	CLK_HW_INIT_PARENTS(_name, _parents, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_GATE_DEFINE(_struct, _name, _parent, _reg, _gate_mask,	\
+			 _val_enable, _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.common	= {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent,	\
+						 _flags),		\
+	}								\
+}
+#define CCU_GATE_NO_PARENT_DEFINE(_struct, _name,  _reg, _gate_mask,	\
+				  _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 0,					\
+		.hw.init	= CCU_MIX_ORPHAN_INITHW(_name, _flags)	\
+	}								\
+}
+
+#define CCU_FACTOR_DEFINE(_struct, _name, _parent, _div, _mul)		\
+struct ccu_mix _struct = {						\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent, 0),	\
+	}								\
+}
+
+#define CCU_MUX_DEFINE(_struct, _name, _parents, _reg, _shift, _width,	\
+		       _flags)						\
+struct ccu_mix _struct = {						\
+	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	}								\
+}
+
+#define CCU_DIV_DEFINE(_struct, _name, _parent, _reg, _shift, _width,	\
+		       _flags)						\
+struct ccu_mix _struct = {						\
+	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init = CCU_MIX_INITHW(_name, _parent, _flags)	\
+	}								\
+}
+
+#define CCU_GATE_FACTOR_DEFINE(_struct, _name, _parent, _reg,		\
+			       _gate_mask, _val_enable, _val_disable,	\
+			       _div, _mul, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init = CCU_MIX_INITHW(_name, _parent, _flags)	\
+	}								\
+}
+
+
+#define CCU_MUX_GATE_DEFINE(_struct, _name, _parents, _reg, _shift,	\
+			    _width, _gate_mask, _val_enable,		\
+			    _val_disable, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	}								\
+}
+
+#define CCU_DIV_GATE_DEFINE(_struct, _name, _parent, _reg, _shift,	\
+			    _width, _gate_mask, _val_enable,		\
+			    _val_disable, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent,	\
+						 _flags),		\
+	}								\
+}
+
+
+#define CCU_DIV_MUX_GATE_DEFINE(_struct, _name, _parents,  _reg_ctrl,	\
+				_mshift, _mwidth, _muxshift, _muxwidth,	\
+				_gate_mask, _val_enable, _val_disable,	\
+				_flags)					\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_DIV2_FC_MUX_GATE_DEFINE(_struct, _name, _parents,		\
+				    _reg_ctrl, _reg_sel, _mshift,	\
+				    _mwidth, _fc, _muxshift, _muxwidth,	\
+				    _gate_mask, _val_enable,		\
+				    _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+	    .reg_type = CLK_DIV_TYPE_2REG_FC_V4,			\
+		.reg_ctrl	= _reg_ctrl,				\
+		.reg_sel	= _reg_sel,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+
+#define CCU_DIV_FC_MUX_GATE_DEFINE(_struct, _name, _parents, _reg_ctrl,	\
+				   _mshift, _mwidth, _fc, _muxshift,	\
+				   _muxwidth, _gate_mask, _val_enable,	\
+				   _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_DIV_MFC_MUX_GATE_DEFINE(_struct, _name, _parents,		\
+				    _reg_ctrl, _mshift, _mwidth, _fc,	\
+				    _muxshift, _muxwidth, _gate_mask,	\
+				    _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type = CLK_DIV_TYPE_1REG_FC_MUX_V6,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_DIV_FC_WITH_GATE_DEFINE(_struct, _name, _parent, _reg_ctrl,	\
+				    _mshift, _mwidth, _fc, _gate_mask,	\
+				    _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type = CLK_DIV_TYPE_1REG_FC_V2,			\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIXINITHW(_name, _parent,		\
+						_flags),		\
+	},								\
+}
+
+#define CCU_DIV_FC_MUX_DEFINE(_struct, _name, _parents, _reg_ctrl,	\
+			      _mshift, _mwidth, _fc, _muxshift,		\
+			      _muxwidth, _flags)			\
+struct ccu_mix _struct = {						\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_MUX_FC_DEFINE(_struct, _name, _parents, _reg_ctrl, _fc,	\
+			  _muxshift, _muxwidth, _flags)			\
+struct ccu_mix _struct = {						\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags)		\
+	},								\
+}
+
+static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mix, common);
+}
+
+extern const struct clk_ops spacemit_ccu_mix_ops;
+
+#endif /* _CCU_DIV_H_ */
diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
new file mode 100644
index 000000000000..1f0ece6abcac
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type pll
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+
+#define PLL_MIN_FREQ	600000000
+#define PLL_MAX_FREQ	3400000000
+#define PLL_DELAY_TIME	3000
+
+#define pll_read_swcr1(c, v)	ccu_read(ctrl, c, v)
+#define pll_read_swcr2(c, v)	ccu_read(sel, c, v)
+#define pll_read_swcr3(c, v)	ccu_read(xtc, c, v)
+
+#define pll_update_swcr1(c, m, v)	ccu_update(ctrl, c, m, v)
+#define pll_update_swcr2(c, m, v)	ccu_update(sel, c, m, v)
+#define pll_update_swcr3(c, m, v)	ccu_update(xtc, c, m, v)
+
+#define PLL_SWCR1_REG5_OFF	0
+#define PLL_SWCR1_REG5_MASK	GENMASK(7, 0)
+#define PLL_SWCR1_REG6_OFF	8
+#define PLL_SWCR1_REG6_MASK	GENMASK(15, 8)
+#define PLL_SWCR1_REG7_OFF	16
+#define PLL_SWCR1_REG7_MASK	GENMASK(23, 16)
+#define PLL_SWCR1_REG8_OFF	24
+#define PLL_SWCR1_REG8_MASK	GENMASK(31, 24)
+
+#define PLL_SWCR2_DIVn_EN(n)	BIT(n + 1)
+#define PLL_SWCR2_ATEST_EN	BIT(12)
+#define PLL_SWCR2_CKTEST_EN	BIT(13)
+#define PLL_SWCR2_DTEST_EN	BIT(14)
+
+#define PLL_SWCR3_DIV_FRC_OFF	0
+#define PLL_SWCR3_DIV_FRC_MASK	GENMASK(23, 0)
+#define PLL_SWCR3_DIV_INT_OFF	24
+#define PLL_SWCR3_DIV_INT_MASK	GENMASK(30, 24)
+#define PLL_SWCR3_EN		BIT(31)
+
+static int ccu_pll_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	u32 tmp;
+
+	pll_read_swcr3(&p->common, &tmp);
+
+	return tmp & PLL_SWCR3_EN;
+}
+
+/* frequency unit Mhz, return pll vco freq */
+static unsigned long __get_vco_freq(struct clk_hw *hw)
+{
+	unsigned int reg5, reg6, reg7, reg8, size, i;
+	unsigned int div_int, div_frc;
+	struct ccu_pll_rate_tbl *freq_pll_regs_table;
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	u32 tmp;
+
+	pll_read_swcr1(common, &tmp);
+	reg5 = (tmp & PLL_SWCR1_REG5_MASK) >> PLL_SWCR1_REG5_OFF;
+	reg6 = (tmp & PLL_SWCR1_REG6_MASK) >> PLL_SWCR1_REG6_OFF;
+	reg7 = (tmp & PLL_SWCR1_REG7_MASK) >> PLL_SWCR1_REG7_OFF;
+	reg8 = (tmp & PLL_SWCR1_REG8_MASK) >> PLL_SWCR1_REG8_OFF;
+
+	pll_read_swcr3(common, &tmp);
+	div_int = (tmp & PLL_SWCR3_DIV_INT_MASK) >> PLL_SWCR3_DIV_INT_OFF;
+	div_frc = (tmp & PLL_SWCR3_DIV_FRC_MASK) >> PLL_SWCR3_DIV_FRC_OFF;
+
+	freq_pll_regs_table = p->pll.rate_tbl;
+	size = p->pll.tbl_size;
+
+	for (i = 0; i < size; i++)
+		if ((freq_pll_regs_table[i].reg5 == reg5) &&
+		    (freq_pll_regs_table[i].reg6 == reg6) &&
+		    (freq_pll_regs_table[i].reg7 == reg7) &&
+		    (freq_pll_regs_table[i].reg8 == reg8) &&
+		    (freq_pll_regs_table[i].div_int == div_int) &&
+		    (freq_pll_regs_table[i].div_frac == div_frc))
+			return freq_pll_regs_table[i].rate;
+
+	WARN_ON_ONCE(1);
+
+	return 0;
+}
+
+static int ccu_pll_enable(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	unsigned long flags;
+	unsigned int tmp;
+	int ret;
+
+	if (ccu_pll_is_enabled(hw))
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	pll_update_swcr3(common, PLL_SWCR3_EN, PLL_SWCR3_EN);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	/* check lock status */
+	ret = regmap_read_poll_timeout_atomic(common->lock_base,
+					      p->pll.reg_lock,
+					      tmp,
+					      tmp & p->pll.lock_enable_bit,
+					      5, PLL_DELAY_TIME);
+
+	return ret;
+}
+
+static void ccu_pll_disable(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	unsigned long flags;
+
+	spin_lock_irqsave(p->common.lock, flags);
+
+	pll_update_swcr3(common, PLL_SWCR3_EN, 0);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+/*
+ * pll rate change requires sequence:
+ * clock off -> change rate setting -> clock on
+ * This function doesn't really change rate, but cache the config
+ */
+static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	struct ccu_pll_config *params = &p->pll;
+	struct ccu_pll_rate_tbl *entry;
+	unsigned long old_rate;
+	unsigned long flags;
+	bool found = false;
+	u32 mask, val;
+	int i;
+
+	if (ccu_pll_is_enabled(hw)) {
+		pr_err("%s %s is enabled, ignore the setrate!\n",
+		       __func__, __clk_get_name(hw->clk));
+		return 0;
+	}
+
+	old_rate = __get_vco_freq(hw);
+
+	for (i = 0; i < params->tbl_size; i++) {
+		if (rate == params->rate_tbl[i].rate) {
+			found = true;
+			entry = &params->rate_tbl[i];
+			break;
+		}
+	}
+	WARN_ON_ONCE(!found);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	mask = PLL_SWCR1_REG5_MASK | PLL_SWCR1_REG6_MASK;
+	mask |= PLL_SWCR1_REG7_MASK | PLL_SWCR1_REG8_MASK;
+	val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
+	val |= entry->reg6 << PLL_SWCR1_REG6_OFF;
+	val |= entry->reg7 << PLL_SWCR1_REG7_OFF;
+	val |= entry->reg8 << PLL_SWCR1_REG8_OFF;
+	pll_update_swcr1(common, mask, val);
+
+	mask = PLL_SWCR3_DIV_INT_MASK | PLL_SWCR3_DIV_FRC_MASK;
+	val = entry->div_int << PLL_SWCR3_DIV_INT_OFF;
+	val |= entry->div_frac << PLL_SWCR3_DIV_FRC_OFF;
+	pll_update_swcr3(common, mask, val);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	return __get_vco_freq(hw);
+}
+
+static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_pll_config *params = &p->pll;
+	unsigned long max_rate = 0;
+	unsigned int i;
+
+	if (rate > PLL_MAX_FREQ || rate < PLL_MIN_FREQ) {
+		pr_err("%lu rate out of range!\n", rate);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < params->tbl_size; i++) {
+		if (params->rate_tbl[i].rate <= rate) {
+			if (max_rate < params->rate_tbl[i].rate)
+				max_rate = params->rate_tbl[i].rate;
+		}
+	}
+
+	return max_rate;
+}
+
+const struct clk_ops spacemit_ccu_pll_ops = {
+	.enable = ccu_pll_enable,
+	.disable = ccu_pll_disable,
+	.set_rate = ccu_pll_set_rate,
+	.recalc_rate = ccu_pll_recalc_rate,
+	.round_rate = ccu_pll_round_rate,
+	.is_enabled = ccu_pll_is_enabled,
+};
+
diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
new file mode 100644
index 000000000000..9da534acc41d
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_PLL_H_
+#define _CCU_PLL_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_pll_rate_tbl {
+	unsigned long long rate;
+	u32 reg5;
+	u32 reg6;
+	u32 reg7;
+	u32 reg8;
+	unsigned int div_int;
+	unsigned int div_frac;
+};
+
+struct ccu_pll_config {
+	struct ccu_pll_rate_tbl *rate_tbl;
+	u32 tbl_size;
+	u32 reg_lock;
+	u32 lock_enable_bit;
+};
+
+#define CCU_PLL_RATE(_rate, _reg5, _reg6, _reg7, _reg8, _div_int, _div_frac) \
+	{									\
+		.rate		= (_rate),					\
+		.reg5		= (_reg5),					\
+		.reg6		= (_reg6),					\
+		.reg7		= (_reg7),					\
+		.reg8		= (_reg8),					\
+		.div_int	= (_div_int),				\
+		.div_frac	= (_div_frac),				\
+	}
+
+struct ccu_pll {
+	struct ccu_pll_config	pll;
+	struct ccu_common	common;
+};
+
+#define CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit) \
+	{									\
+		.rate_tbl	 = (struct ccu_pll_rate_tbl *)&(_table),	\
+		.tbl_size	 = ARRAY_SIZE(_table),				\
+		.reg_lock	 = (_reg_lock),					\
+		.lock_enable_bit = (_lock_enable_bit),				\
+	}
+
+#define CCU_PLL_HWINIT(_name, _flags) \
+	CLK_HW_INIT_NO_PARENT(_name, &spacemit_ccu_pll_ops, _flags)
+
+#define CCU_PLL_DEFINE(_struct, _name, _table, _reg_ctrl, _reg_sel,	\
+		       _reg_xtc, _reg_lock, _lock_enable_bit, _flags)		\
+										\
+	struct ccu_pll _struct = {						\
+		.pll	= CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit),	\
+		.common = {							\
+			.reg_ctrl	= _reg_ctrl,				\
+			.reg_sel	= _reg_sel,				\
+			.reg_xtc	= _reg_xtc,				\
+			.is_pll		= true,					\
+			.hw.init	= CCU_PLL_HWINIT(_name, _flags)		\
+		}								\
+	}
+
+
+static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+extern const struct clk_ops spacemit_ccu_pll_ops;
+
+#endif
-- 
2.46.0



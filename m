Return-Path: <linux-kernel+bounces-187276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6356E8CCF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4152F1C220BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524817F6;
	Thu, 23 May 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YwUitsA1"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010001.outbound.protection.outlook.com [52.103.64.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712813D29E;
	Thu, 23 May 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456863; cv=fail; b=h30eyO4BcC0n32riSnSskFUgfgkl+iQA1SnOfszdsEm8I2577AUe7nFuTg0HX99w6CYNZaGxUO0i5gBAPIECQGrGKnRl+TEYBBxj1ckT7hmihOF4wkJu/yB9qSKusEtprAuNkmCH+qyqLGougeR8oNKcrVCzpaF3F5Xe65BqKLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456863; c=relaxed/simple;
	bh=MTDhHoN53Tm6gcWJAP9xVc3capwLN0V50kt8xxAfjg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kai4QfIJdBM5OrE2Xk40GWBWHkCbwq7y/3D/YLJ+fJqKJDmx+ymg4gnOwGATrb1K1072D1T7cBLQ/TRhUFAoGZl9+Zi/CsJlQXK2JRlhUBMcvBQqDwxwtYn0u1cTNJoIzWvRZjTWhYkjgWOC4ONQ0wgj3SGOSeBTmNJ7oIDNXWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YwUitsA1; arc=fail smtp.client-ip=52.103.64.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bncBHqYhUZMtMecFJykDVXbr1dW78hcjvuSY4E7FjRxRF0Gp7zHnv3H59AoYX5V3OzJNS8vRDNGJ/r1UbAoB5+oo842iVkXksWMMb8VJaT6HCsyJizafJYJ666EZhvaSFzmVz0ZkchPp5yWeweAEPW2AIQEi25M/GB2KgHFaEf0E3M2QSNDGwTD3dflk/G8t2V0nelH9Ni9xN0VVGaqNkyc57DNH6Y13YpRW7vHvqIeHsFl79J2EGsshN0syyEQtxaeJBH781fuutwZAySGBpGkH6T7EvBZAAiG3MxeGKsxTmOwCMizymDxrBQWmknikzVKVsZL0Ul1wNuPKLC+Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0dg9AC0rAzauIsWmgexfbl0cx5H9zqIW7ObktfvawE=;
 b=QU/T2zpXcSJjepr3TPN7DNyAVi6+HuZgn2WTsVBMRd4s9pMFkWTU+xbMZOpVxoVWVcQX0w6UF44/hvIqit+BBICxtlLd2Ik5BGTEHsoc0XzOpZVs0rrRrYOtjCP/F74vtYL+e2iEbMDf4qSEXVz5AlER+3ueS5qdt7Hlf4ZwPL49VjHrGL+1TjBX8i973V8G7WVBiPZ6YYFH6rPMyhA6zSwFwADmOTlzndqVCFln0lssHFmLedhe/dnMuiZmjZoxJEFhfY4CkVprBPjOjRWqsZTJjIK/EAsg8WQWkx26uV5MzHhffTVcwM7zNX/OkXq0aBsUhqb/wooXSJamXY/KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0dg9AC0rAzauIsWmgexfbl0cx5H9zqIW7ObktfvawE=;
 b=YwUitsA1v2ERxsdSpxBYhOWQ1Pd42zqfmwMThwWp+R34y7deHzVWVj24dVQzLnwvaVfLNmikwiT+BVKAxnjY1uxN1qRQW6pHwf/48dbG5LX5DHD+WJtxGL+6CnTdFCHCGecVFom0MDA0LQxzs3jqovgLLLSnA/JKn4ySZFQ+LOE1m63b+FleuRIiYQR6XB4kGZ4Ni/VugIR7ekxbdHKkD68EVGPC8dbzEmZdu5WcdBXoPlbaIu17QQyYH4UWBn8VhEaNESiTmDLx+3sFICAH86sHWYGjxFMKdlSecFUt5a11cETRXeUYau/nau6AbSVlF8bMJmfVLdhgwFVgfC0imw==
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com (2603:1096:101:be::7)
 by TYZPR04MB8347.apcprd04.prod.outlook.com (2603:1096:405:e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:34:15 +0000
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5]) by SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5%5]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 09:34:15 +0000
From: Noah Wang <noahwang.wang@outlook.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Noah Wang <noahwang.wang@outlook.com>
Subject: [v2 2/2] hwmon: add MP2891 driver
Date: Thu, 23 May 2024 17:33:48 +0800
Message-ID:
 <SEYPR04MB6482956A833D60133EE47765FAF42@SEYPR04MB6482.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523093348.171024-1-noahwang.wang@outlook.com>
References: <20240523093348.171024-1-noahwang.wang@outlook.com>
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-TMN: [SCb5nZWgIJRy3IosF7F+TyGE8bMKsIf6]
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To SEYPR04MB6482.apcprd04.prod.outlook.com
 (2603:1096:101:be::7)
X-Microsoft-Original-Message-ID:
 <20240523093348.171024-2-noahwang.wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR04MB6482:EE_|TYZPR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0d125f-a7d0-4419-7515-08dc7b0b82ff
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	YJ4GzMlpviqbUdzmwyNGBI71qF09XJY+gIq8AuhaByaAozqEpX08aZZhY83lVgw/y406ueHB1BSWGWD3FZhibelqWNb3JiGb10/4lPt8VcNfkJBH5EhffRAmXi8Ve4gO3iGmwteVtcfQe+zq+jleeBeqz2y+KiC9nKZpovqzcshHMuxiWJuHPK/PXgsf3k8aKEmYKZ7ruTzYrnr6A31AwBxBEB1Ra1YSHC3PoQSWRQwQ1yABg83bAYCUvEH7etJXegY7+ue/kq5tO/ji5oB2kNhFBt0pbSrBcN7fIP1Y0QwRSTnItSI4zEjxP/31VBk+6ln9bdyBIP9OnmlqeQhsbGIMSrlZFa9sbYA3o52uf5OGZQVFv4U1rgnAmdCpVUoFHRe09NMJzqmxpoQ4CPmWi08QNoPt46kWZ1ofX1/8tj+eknoh954aPTGwbLGDE5l1hhO3Yev+SKLwmJ6lb3EobmSJxTpy4TqgxhgD7BWFYkaJCGWeqb2smhPOa5L6svxGJU7BYjgc0cA9qz8r6qz7aT1kwSY1lxZmJ1N2U4dRD1paYS3nzLgIjDQ0+yHinZVHf0R1BsdtZOhee6YhsmIM3wWhjUrYMCL66SqWVETZhRw1QUqfXdAH+JouJYCLa2LkJbB3HHaiDLLfmZe1ZyRQyld9ICgcKCwnvaMQTHor2549CpLQau+UQZDGEa0i8wUT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uK3+pYKdrhhhqIcb8VKUK4zT5Ryxw7gJZYk/fuaNzaTt0RlG5iqAeqoS6Ja/?=
 =?us-ascii?Q?SxZxFmMn9o7vOdfDQUZYPao3WWYJvt8zsuwIX0SOfC/6UUE70R7iJE9Z+LYV?=
 =?us-ascii?Q?BqqQY1oXbV/rTr5+A6k7cCehYhaTD/fFMrtkW0x3oXMPgYxgvDZre+XPMqwM?=
 =?us-ascii?Q?1utaRR6NHPkiNhQSqn9GNAYctVwAQzeXdwlV3mcNH9zawy1wv1vNkk/PPh/Y?=
 =?us-ascii?Q?A+PkPuRduw6XihFTpJNVIAn336x3kEExy1k3sFlaTdgh3M2Eouw7tt8Ukgl5?=
 =?us-ascii?Q?+OboABUckhqrm8f7Ovk1J93xjmKbNpq8MZOoJnCRXt4BEYCieXIHXU8zvjNl?=
 =?us-ascii?Q?V4Hs1+eElHimZIzR8619TJNP3cw+yE5lv/ujkjtxk5YlE7iGFPKomCP0zqSg?=
 =?us-ascii?Q?+vte2WHHwQmtCp0EvciV8nuaQNfS9xifsXr4SwCyG/Cac+1JTUd1/AwmYx0t?=
 =?us-ascii?Q?7TilQuyGjkoJuLaYCPBN6Q0jAbQgM1gEovevq2jstdxXlOIIE+vFCfYvVfBj?=
 =?us-ascii?Q?93YQiSebNWmyybtwV3DzNGRaLlCygOuU8TlZGrXExo9Pr8IIkm/BDbvfy+BJ?=
 =?us-ascii?Q?o74a2npG4JaFkvc5T4JWI3Lc8QV9XgFB3QN1M+GtLTizUGji45kRuaiuL+CY?=
 =?us-ascii?Q?bS6WwZUSmmBNk6XuOm/MzLMnhC3nQuO7y1Dyf5fwdwjFSHxHxaVw2dGjKMWA?=
 =?us-ascii?Q?7FxwJFcYamMPhzBcxbnzz4i0XUgpK+583B9bPF4ZSHnezWk/3Nt/gmSTnseK?=
 =?us-ascii?Q?N+ib/YKA4XaCJWQGWg4MAh5dQu9+F8hXCLgp4S+/vbjlEW/5EBw9g0kfDas9?=
 =?us-ascii?Q?6ylDHkzYXFyyvA9CK/0YFVIZgfZBvDMsOiFGy80dbzQTuYG25A9BpsFwimqC?=
 =?us-ascii?Q?M3KCI7imOEj128fDUdp1bgEQWTNNbbsKKUhQ6f+RGjIKljUJFB+Q0HPpnpNe?=
 =?us-ascii?Q?K49BWbrVeOnwKsJlPRNlN1vNgae3uhOewTXgCKO/i7geMX9ZFZjt/6PZhZvt?=
 =?us-ascii?Q?iY1EfwZm+vCBJtFnm4hBxTjRwaO355hNBAbSBQG4CdF2DRjQSIg9txvf/WsZ?=
 =?us-ascii?Q?6sSAMB2Q0GHpnpPMrBkRDeM4rC3NGGA1YSUMFi7jzjqWPLWVcAWIc4tc7eCp?=
 =?us-ascii?Q?qFIpLdlKvRE2WDFqf7TZ5F1e8ui9XcFvTacWsB0NWWcyL7ndNCZ7sLfxpBZO?=
 =?us-ascii?Q?KHENDXAzyHa6gv+ULrn69aZvl7QQkZjarFyct3xvfeNBUMRltUeDQuWSClsU?=
 =?us-ascii?Q?2rG/gFjvyoi/afq92Bkq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0d125f-a7d0-4419-7515-08dc7b0b82ff
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB6482.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:34:15.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8347

This driver is designed for MPS VR controller mp2891. This driver
exposes telemetry and limit value readings.

Signed-off-by: Noah Wang <noahwang.wang@outlook.com>

V1 -> V2:
    1. add limit register readings
    2. add status register readings
    3. change PSC_CURRENT_OUT format from linear to direct
    4. add more detailed explanation for special processing
    5. remove useless code
    6. move identify vout_scale, iout_scale function to
        identify() callback
    7. update MP2891 datasheet
---
 Documentation/hwmon/index.rst  |   1 +
 Documentation/hwmon/mp2891.rst | 179 +++++++++++++
 drivers/hwmon/pmbus/Kconfig    |   9 +
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp2891.c   | 462 +++++++++++++++++++++++++++++++++
 5 files changed, 652 insertions(+)
 create mode 100644 Documentation/hwmon/mp2891.rst
 create mode 100644 drivers/hwmon/pmbus/mp2891.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 03d313af4..88f70ef60 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -168,6 +168,7 @@ Hardware Monitoring Kernel Drivers
    mp2975
    mp5023
    mp5990
+   mp2891
    mpq8785
    nct6683
    nct6775
diff --git a/Documentation/hwmon/mp2891.rst b/Documentation/hwmon/mp2891.rst
new file mode 100644
index 000000000..a487d5ee8
--- /dev/null
+++ b/Documentation/hwmon/mp2891.rst
@@ -0,0 +1,179 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp2891
+====================
+
+Supported chips:
+
+  * MPS mp2891
+
+    Prefix: 'mp2891'
+
+  * Datasheet
+
+    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp2891.html
+
+Author:
+
+	Noah Wang <noahwang.wang@outlook.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP2891 Multi-phase Digital VR Controller.
+
+Device compliant with:
+
+- PMBus rev 1.3 interface.
+
+Device supports direct and linear format for reading input voltage,
+output voltage, input currect, output current, input power, output
+power, and temperature.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_crit**
+
+**in1_crit_alarm**
+
+**in1_lcrit**
+
+**in1_lcrit_alarm**
+
+**in1_min**
+
+**in1_min_alarm**
+
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_crit**
+
+**in2_crit_alarm**
+
+**in2_lcrit**
+
+**in2_lcrit_alarm**
+
+**in2_min**
+
+**in2_min_alarm**
+
+**in3_input**
+
+**in3_label**
+
+**in3_crit**
+
+**in3_crit_alarm**
+
+**in3_lcrit**
+
+**in3_lcrit_alarm**
+
+**in3_min**
+
+**in3_min_alarm**
+
+The driver provides the following attributes for input current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr1_max**
+
+**curr1_max_alarm**
+
+**curr2_input**
+
+**curr2_label**
+
+**curr2_max**
+
+**curr2_max_alarm**
+
+The driver provides the following attributes for output current:
+
+**curr3_input**
+
+**curr3_label**
+
+**curr3_crit**
+
+**curr3_crit_alarm**
+
+**curr3_max**
+
+**curr3_max_alarm**
+
+**curr4_input**
+
+**curr4_label**
+
+**curr4_crit**
+
+**curr4_crit_alarm**
+
+**curr4_max**
+
+**curr4_max_alarm**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+**power1_max**
+
+**power1_alarm**
+
+**power2_input**
+
+**power2_label**
+
+**power2_max**
+
+**power2_alarm**
+
+The driver provides the following attributes for output power:
+
+**power3_input**
+
+**power3_label**
+
+**power4_input**
+
+**power4_label**
+
+The driver provides the following attributes for temperature:
+
+**temp1_input**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
+
+**temp1_max**
+
+**temp1_max_alarm**
+
+**temp2_input**
+
+**temp2_crit**
+
+**temp2_crit_alarm**
+
+**temp2_max**
+
+**temp2_max_alarm**
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 08e82c457..c0cc673a6 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -371,6 +371,15 @@ config SENSORS_MP5990
 	  This driver can also be built as a module. If so, the module will
 	  be called mp5990.
 
+config SENSORS_MP2891
+    tristate "MPS MP2891"
+    help
+      If you say yes here you get hardware monitoring support for MPS
+      MP2891 Dual Loop Digital Multi-Phase Controller.
+
+      This driver can also be built as a module. If so, the module will
+      be called mp2891.
+
 config SENSORS_MPQ7932_REGULATOR
 	bool "Regulator support for MPQ7932"
 	depends on SENSORS_MPQ7932 && REGULATOR
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 2279b3327..4f680bf06 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
+obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
new file mode 100644
index 000000000..afe49fcb3
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2891.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2891)
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+/*
+ * Vender specific registers, the register MFR_SVI3_IOUT_PRT(0x65),
+ * MFR_VOUT_LOOP_CTRL(0xBD), READ_PIN_EST(0x94)and READ_IIN_EST(0x95)
+ * redefine the standard PMBUS register. The MFR_SVI3_IOUT_PRT(0x65)
+ * is used to identify the iout scale and the MFR_VOUT_LOOP_CTRL(0xBD)
+ * is used to identify the vout scale. The READ_PIN_EST(0x94) is used
+ * to read input power of per rail. The MP2891 does not have standard
+ * READ_IIN register(0x89), the iin telemetry can be obtained through
+ * the vendor redefined register READ_IIN_EST(0x95).
+ */
+#define MFR_VOUT_LOOP_CTRL      0xBD
+#define READ_PIN_EST            0x94
+#define READ_IIN_EST            0x95
+#define MFR_SVI3_IOUT_PRT	    0x65
+
+#define MP2891_TEMP_LIMIT_OFFSET	40
+#define MP2891_PIN_LIMIT_UINT		2
+#define MP2891_IOUT_LIMIT_UINT	    8
+#define MP2891_IOUT_SCALE_DIV       32
+#define MP2891_VOUT_SCALE_DIV       100
+#define MP2891_OVUV_DELTA_SCALE     50
+#define MP2891_OV_LIMIT_SCALE       20
+#define MP2891_UV_LIMIT_SCALE       5
+
+#define MP2891_PAGE_NUM			2
+
+#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
+							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
+							PMBUS_HAVE_IIN | PMBUS_HAVE_STATUS_VOUT | \
+							PMBUS_HAVE_STATUS_IOUT | \
+							PMBUS_HAVE_STATUS_INPUT | \
+							PMBUS_HAVE_STATUS_TEMP)
+
+#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
+							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
+							PMBUS_HAVE_PIN | PMBUS_HAVE_IIN | \
+							PMBUS_HAVE_STATUS_VOUT | \
+							PMBUS_HAVE_STATUS_IOUT | \
+							PMBUS_HAVE_STATUS_INPUT | \
+							PMBUS_HAVE_STATUS_TEMP)
+
+struct mp2891_data {
+	struct pmbus_driver_info info;
+	int vout_scale[MP2891_PAGE_NUM];
+	int iout_scale[MP2891_PAGE_NUM];
+};
+
+#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
+
+#define MAX_LIN_MANTISSA	(1023 * 1000)
+#define MIN_LIN_MANTISSA	(511 * 1000)
+
+/* Converts a milli-unit DIRECT value to LINEAR11 format */
+static u16 mp2891_data2reg_linear11(s64 val)
+{
+	s16 exponent = 0, mantissa;
+	bool negative = false;
+
+	/* simple case */
+	if (val == 0)
+		return 0;
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
+		exponent++;
+		val >>= 1;
+	}
+	/* Increase small mantissa to improve precision */
+	while (val < MIN_LIN_MANTISSA && exponent > -15) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = clamp_val(DIV_ROUND_CLOSEST_ULL(val, 1000), 0, 0x3ff);
+
+	/* restore sign */
+	if (negative)
+		mantissa = -mantissa;
+
+	/* Convert to 5 bit exponent, 11 bit mantissa */
+	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
+}
+
+static int
+mp2891_identify_vout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+										int page)
+{
+	struct mp2891_data *data = to_mp2891_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_VOUT_LOOP_CTRL);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The output voltage is equal to the READ_VOUT(0x8B) register value multiply
+	 * by vout_scale.
+	 * Obtain vout scale from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
+	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vout scale is below:
+	 * 2.5mV/LSB
+	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vout scale is decided by
+	 * MFR_VOUT_LOOP_CTRL[15:14]:
+	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
+	 */
+	if (ret & GENMASK(13, 13)) {
+		data->vout_scale[page] = 250;
+	} else {
+		ret = FIELD_GET(GENMASK(15, 14), ret);
+		if (ret == 0)
+			data->vout_scale[page] = 625;
+		else if (ret == 1)
+			data->vout_scale[page] = 500;
+		else if (ret == 2)
+			data->vout_scale[page] = 200;
+		else
+			data->vout_scale[page] = 100;
+	}
+
+	return 0;
+}
+
+static int
+mp2891_identify_iout_scale(struct i2c_client *client, struct pmbus_driver_info *info,
+										int page)
+{
+	struct mp2891_data *data = to_mp2891_data(info);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, MFR_SVI3_IOUT_PRT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The output current is equal to the READ_IOUT(0x8C) register value
+	 * multiply by iout_scale.
+	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT[2:0].
+	 * The value is selected as below:
+	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
+	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
+	 * 110b - 1A/LSB, 111b - 2A/LSB
+	 */
+	switch (ret & GENMASK(2, 0)) {
+	case 0:
+	case 6:
+		data->iout_scale[page] = 32;
+		break;
+	case 1:
+		data->iout_scale[page] = 1;
+		break;
+	case 2:
+		data->iout_scale[page] = 2;
+		break;
+	case 3:
+		data->iout_scale[page] = 4;
+		break;
+	case 4:
+		data->iout_scale[page] = 8;
+		break;
+	case 5:
+		data->iout_scale[page] = 16;
+		break;
+	default:
+		data->iout_scale[page] = 64;
+		break;
+	}
+
+	return 0;
+}
+
+static int mp2891_identify(struct i2c_client *client, struct pmbus_driver_info *info)
+{
+	int ret;
+
+	/* Identify vout scale for rail 1. */
+	ret = mp2891_identify_vout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify vout scale for rail 2. */
+	ret = mp2891_identify_vout_scale(client, info, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Identify iout scale for rail 1. */
+	ret = mp2891_identify_iout_scale(client, info, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify iout scale for rail 2. */
+	ret = mp2891_identify_iout_scale(client, info, 1);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		/*
+		 * The MP2891 does not follow standard PMBus protocol completely, the
+		 * PMBUS_VOUT_MODE(0x20) in MP2891 is reserved and 0x00 is always be
+		 * returned when the register is read. But the calculation of vout in
+		 * this driver is based on direct format. As a result, the format of
+		 * vout is enforced to direct.
+		 */
+		ret = PB_VOUT_MODE_DIRECT;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2891_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2891_data *data = to_mp2891_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_IIN:
+		/*
+		 * The MP2891 does not have standard PMBUS_READ_IIN register(0x89),
+		 * the iin telemetry can be obtained through the vender redefined
+		 * register READ_IIN_EST(0x95).
+		 */
+		ret = pmbus_read_word_data(client, page, phase, READ_IIN_EST);
+		break;
+	case PMBUS_READ_PIN:
+		/*
+		 * The MP2891 has standard PMBUS_READ_PIN register(0x97), but this
+		 * is not used to read the input power of per rail. The input power
+		 * of per rail is read through the vender redefined register
+		 * READ_PIN_EST(0x94).
+		 */
+		ret = pmbus_read_word_data(client, page, phase, READ_PIN_EST);
+		break;
+	case PMBUS_READ_VOUT:
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST(ret * data->vout_scale[page], MP2891_VOUT_SCALE_DIV);
+		break;
+	case PMBUS_READ_IOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(10, 0)) * data->iout_scale[page],
+								MP2891_IOUT_SCALE_DIV);
+		break;
+	case PMBUS_OT_FAULT_LIMIT:
+	case PMBUS_OT_WARN_LIMIT:
+		/*
+		 * The MP2891 PMBUS_OT_FAULT_LIMIT and PMBUS_OT_WARN_LIMIT are not
+		 * linear11 format, the scale is 1°C/LSB and they have 40°C offset.
+		 * As a result, the limit value is calculated to m°C first, then
+		 * it is converted to linear11 format.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2891_data2reg_linear11(((ret & GENMASK(7, 0)) -
+								MP2891_TEMP_LIMIT_OFFSET) * 1000);
+		break;
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+		/*
+		 * The MP2891 PMBUS_VIN_UV_FAULT_LIMIT and PMBUS_VIN_UV_WARN_LIMIT
+		 * are not linear11 format, the scale is 31.25mV/LSB. As a result,
+		 * the limit value is calculated to mV first, then it is converted
+		 * to linear11 format.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2891_data2reg_linear11(DIV_ROUND_CLOSEST((ret & GENMASK(9, 0)) * 3125,
+										100));
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		/*
+		 * The MP2891 PMBUS_VIN_OV_FAULT_LIMIT are not linear11 format,
+		 * the scale is 125mV/LSB. As a result, the limit value is
+		 * calculated to mV first, then it is converted to linear11
+		 * format.
+		 */
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2891_data2reg_linear11((ret & GENMASK(7, 0)) * 125);
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(11, 8), ret))
+			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE -
+				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
+		else
+			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_UV_LIMIT_SCALE;
+
+		ret = ret < 0 ? 0 : ret;
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		if (FIELD_GET(GENMASK(11, 8), ret))
+			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE +
+				(FIELD_GET(GENMASK(11, 8), ret) + 1) * MP2891_OVUV_DELTA_SCALE;
+		else
+			ret = FIELD_GET(GENMASK(7, 0), ret) * MP2891_OV_LIMIT_SCALE;
+		break;
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST((ret & GENMASK(7, 0)) * data->iout_scale[page] *
+						MP2891_IOUT_LIMIT_UINT, MP2891_IOUT_SCALE_DIV);
+		break;
+	case PMBUS_IIN_OC_WARN_LIMIT:
+		/*
+		 * The MP2891 PMBUS_IIN_OC_WARN_LIMIT are not linear11 format, the
+		 * scale is 0.5V/LSB. As a result, the limit value is calculated to
+		 * mA first, then it is converted to linear11 format.
+		 */
+		ret = pmbus_read_word_data(client, 0, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * 1000 / 2);
+		break;
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		/*
+		 * The MP2891 PMBUS_PIN_OP_WARN_LIMIT are not linear11 format, the
+		 * scale is 2W/LSB. As a result, the limit value is calculated to
+		 * mW first, then it is converted to linear11 format.
+		 */
+		ret = pmbus_read_word_data(client, 0, phase, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = mp2891_data2reg_linear11((ret & GENMASK(9, 0)) * MP2891_PIN_LIMIT_UINT *
+										1000);
+		break;
+	case PMBUS_READ_VIN:
+	case PMBUS_READ_POUT:
+	case PMBUS_READ_TEMPERATURE_1:
+		ret = -ENODATA;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct pmbus_driver_info mp2891_info = {
+	.pages = MP2891_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.b[PSC_VOLTAGE_OUT] = 0,
+
+	.m[PSC_CURRENT_OUT] = 1,
+	.R[PSC_CURRENT_OUT] = 0,
+	.b[PSC_CURRENT_OUT] = 0,
+
+	.func[0] = MP2891_RAIL1_FUNC,
+	.func[1] = MP2891_RAIL2_FUNC,
+	.read_word_data = mp2891_read_word_data,
+	.read_byte_data = mp2891_read_byte_data,
+	.identify = mp2891_identify,
+};
+
+static int mp2891_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp2891_data *data;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2891_info, sizeof(*info));
+	info = &data->info;
+
+	return pmbus_do_probe(client, info);
+}
+
+static const struct i2c_device_id mp2891_id[] = {
+	{"mp2891", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mp2891_id);
+
+static const struct of_device_id __maybe_unused mp2891_of_match[] = {
+	{.compatible = "mps,mp2891"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mp2891_of_match);
+
+static struct i2c_driver mp2891_driver = {
+	.driver = {
+		.name = "mp2891",
+		.of_match_table = mp2891_of_match,
+	},
+	.probe = mp2891_probe,
+	.id_table = mp2891_id,
+};
+
+module_i2c_driver(mp2891_driver);
+
+MODULE_AUTHOR("Noah Wang <noahwang.wang@outlook.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP2891");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
-- 
2.25.1



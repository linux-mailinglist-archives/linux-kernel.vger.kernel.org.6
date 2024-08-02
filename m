Return-Path: <linux-kernel+bounces-272558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74E945DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E5C1F23C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285D1E2887;
	Fri,  2 Aug 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gK0XjmhL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2091.outbound.protection.outlook.com [40.92.42.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103301E3CB9;
	Fri,  2 Aug 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602364; cv=fail; b=eufExsZJuhyrpkbOhh55Q5fy/PLsOuNUXYYbD53Npan2xkPC2dh1v29mvIfJfgeWADWmwsiTQPwu1OoMBq4GeyKI8TwSSKmF0a/Qh9rVlbexMU4gGiROPgHWFx3TBp3UYoq3AZ7gr2XM2R2BYow6LxV/GvIZ8gFbbQzroRPUFe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602364; c=relaxed/simple;
	bh=zIssMli6gSPdOvoddu6McVxrDgxRYUPfjhuYsojKDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMa9RJ14+jqLS/ObtvpydhHYUDaxidU4uY+p3pE3qCXQr1wx5qVRNhUdepxQmzVGz6OA5ZfMnU0ri9KFWRzmRirr4urABQH7eAUi5mO5SfxTr+TV54bFYkwW7kXO7Ov4VWzPrMudUw8Ko52dlbzwYlaoFM+wnH2/ydDiZL3N3c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gK0XjmhL; arc=fail smtp.client-ip=40.92.42.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+Vx88hlJMQ3T3zTWLdRk0F8ocdDz9FnR5iJpJJxr9kftBR/FoR9h0kbx734BaTYLZ2LewHd+kEZekLo875fKa1EQf3gwPRPO9ldYo70HiK/MSK2j4YirqYJhp2mj++Cd03fL5hz/ZS0Lo9Buukut2z0MnEGqSE6I3GIdxKbrPJ5ZKP01nSAN4r5u2SRVWUKUjXBEMUPXcD9QwXvUE2BMseBfhj36M+z4c/XsfpbAQckKiqSwb346r0iDmaLeebG8boP8R2BJh08QcFcnquAGtrMGIh+Ht1LBagGFFE5YJIfz9zInPoEH/Hn428x3b5BLiD5F+T7bCKP9vqmHfPLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2CSHyy7i+DZd+ZKW3QZFHAWPwdtONUrir0CDp4KvtI=;
 b=NsTz9JbVYANzlfMljN426DVqszlVBs0cPxGd+Fn4+aSztMcFwI3NvrOqdOKDeP1HkXWKHvGAit0qiOxHt5S/YTcU8hffH9y2MuxwvoMzmxtW+WnUs4FE97o8YIqjczcnYDZ+m7nm6SNQueXuGKfQl7TwmEqMg67FkFWORA7BEWc2K92/bye0GBuAcYeX/0JbIi1aM5iK7dueRQKxXvlUgRKOItu6Ga60F98FeverTymc9ICO5lgdZCmFtdz84JLrpR+ij7YT7PDXs1gtL+rzSXWjmGM8JykL1hFVusOPRQYkThOWl+TPPwMWHPMgVYQytmF28bOwQaEVdEG3bFt56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2CSHyy7i+DZd+ZKW3QZFHAWPwdtONUrir0CDp4KvtI=;
 b=gK0XjmhL1Benm61SeQsjNRFjWF4ZHplH6t1oyPXGVkqLpDNml3QuEDsNiau2AxvihSax01//z+frxWXdnO3oEaClqYldah99crjjR/QALhcSC2c8oqY75h7D9c95uQX8NoBdMWTENFl0/TMvlg1pRQaK8vJSf/d/takCr8O0A6/R53a2lYFG9Q7/EbUWVUHZE0T1qdSTVLH/zIu+dzZGHxsZfQH/DU/+v5u4n362qmNbkQv0CmCtLPUBbGyvSH42MOOhFrPzvs5Rebyal9s4e9K0ohjoTBj6thoVxKxnPtO4H4PROmhKad5BLhvD9T/eG12KnVVzu+OHZWaDy/IEtA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5499.namprd20.prod.outlook.com (2603:10b6:930:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 12:39:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 12:39:19 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 2/4] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Fri,  2 Aug 2024 20:38:39 +0800
Message-ID:
 <IA1PR20MB4953032E1B5D58D2F6C7393DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Cf3teBs1u7Ul07hwwThgwRR9NKUP9aTqykoQVv0vHmo=]
X-ClientProxiedBy: SG2PR04CA0185.apcprd04.prod.outlook.com
 (2603:1096:4:14::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802123842.1492286-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a51d5bd-7ebd-471f-760a-08dcb2f020a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	R90GDjCSdu6mlNDfCYHZpbZvc3kycg0BaYRVJoeFM3681I73uBHWVaAS4Y9CYlwVin70QKa9uaSmdVqpKbEDGR61kNS8LAwkcD5qkIhcka5kwMg1DUvy86qWtWPC7L4h3G9ycM3qKOPYV+aeg9NgsNSJQH5M0n/NhlGkKOmd1IZut89z+Z/x1DF2SDQtEiokFM2g34GW5eDGgU4TfF6ONrB4RP8/kKBG2FCi+yCvTzu0n9nxEBKQtfVtvDdweQ/2J6i4JysqDuOTFZRrMQyN+65J8k8LBz4uvjSla3FmXXcxiJcBpdHUHYlsqAwpmpEU7Y1+PHz2qIchD5XIZ9TySFlVAIeGD/PO3C893BzA3MSE933MzAo0vmsik+XCD/dWfR+Kg58b6Z1flJTpT4tLWZm3imVHLFTe2jo15j/99c+b1aSljxs5Pg3Dm6mZRKPvykEn4CfOp7jaAl+x8DScPAWnWSPfI3SQ5m/GQfcl1DbxpY5+Wl+cuDcdjVCTbiyFXRjUeG5j7yirxJ8z7YdWecKOmyusgUGNaIwzx790Whaw4ibyEwNIl75tRVD+VrnmT8zqwtcXalKrzoUsoxbRsAO670MC1rxa4q84la+mhX14SHgCI62COYUmauv3LnYGOh87qY5wpssd5h6GxR3R955QOIAnSrrldX2ahkP2afhLhc+xnUdmU9z4hLBTPfoF+XitGHm4ntZsO2wv3eV3cA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOE+ieAbTe1KRMdSdvHSY3bD8+JYkCVB8jEzKdP7Ov0Woyo8whTCQ+J9RhjJ?=
 =?us-ascii?Q?dcIBmMliKZDev16TiuMY6hXrDEj5/eX2044qyhKicdALwbZpmK0zo2FyJUmZ?=
 =?us-ascii?Q?Fbfhe6mhe7mGxEUoPWn/llZbDkv2GLTyGrXNeYqHRowJi3zTIlEJ15L97M8+?=
 =?us-ascii?Q?jEvzv0/ZlMOyYfpdwy850qiXhULUzHQa7GvpE9tiYrFjrVq9dfA6d3qjSp1b?=
 =?us-ascii?Q?gTKvuZcFIlkfk4i+dXTNMVSHv5rGO3u8SJrebdfJJTKIdfCj7dAM48cJYcRo?=
 =?us-ascii?Q?XB2pdMDTGolpS8PdwbdeU04UOGiS29Yp8bT/uvM+o4p0NOH9K8EC+reeEr9d?=
 =?us-ascii?Q?lrYoWkD1Qs/g6ZuHkdKAQiWQEXhsMoZCgiHc8OWweKwKo8IhtBL0nx9x9aAt?=
 =?us-ascii?Q?tulCl4lZZ/0Pu9wrxmPpWRZVjLyJeRyLolrkGrTvBhcZ0iXbJthXhgu2yP1r?=
 =?us-ascii?Q?OWdMj4QsMrSULhizMJ/T9G9YUUbdu71AF+l6pfNvP9U17glF8RYAtffGCP3Y?=
 =?us-ascii?Q?EuQyfgeWJPzNpKqSarifdCyxVcuoj0+BvESpu6AHFVBjI9DRA+F4k3LXn+Pt?=
 =?us-ascii?Q?MQOqOnU0njNQ5V2SmOphkM5PJFamzMm93A7U200gNvvlpPnN+3KwuJ718ihK?=
 =?us-ascii?Q?eIVaCUpDttL1axzSF+U+6deCuO+DJXtFS6YTBz7O5F9LUmUZTkGraqABiBSr?=
 =?us-ascii?Q?Lewg7y/vYiPxBBzC1sSdh+iYVkAp7oIpsmkzZ2GPq+GC99BIwJITIDXoNvfG?=
 =?us-ascii?Q?Wsw47lNZ0zuTQVVKLaIp70+KNMbnN4sx3aPFtGh74QUlYhwJ7MyCttKmg+IS?=
 =?us-ascii?Q?NPdC7WDhTtRFTBRA8CqJFJbfdsYRdHEz4Cuz+YzzSBzs/BPG+Vf2IvNfalda?=
 =?us-ascii?Q?RA4ogZoTZQYPUhSJ5lYBkAlmszzupmk3JnN4AesFtXit3S7lnQqHHVl46nx/?=
 =?us-ascii?Q?gPpCh8bsYe9+sBcElQxLgexSuqQK87w5DOqTVsmJ/qrwZNuTKjCmWzOmeq2A?=
 =?us-ascii?Q?XyH6/iw0FkrGQlBZwLLaR0+bTlHyMWRjMUXd94MJ3bcHzBT1fN0Ae8ll0yTE?=
 =?us-ascii?Q?+G3Kjetu7zMtm9vqzQt1QCCQoHJkO26ZR9Tg0TcXgIAMEzllErGmMJyK2wy8?=
 =?us-ascii?Q?0KGWsjrAEi6Beikw7WVvbS6MpBLhrF4wMatsXhiXX+DbxJa7+kRBYh43YxpN?=
 =?us-ascii?Q?I9cp/8SoBg3Z4fL/mTUHkA+DvCD9vDOXa8iSL/AQFoaX/5f0YAXEBiWZcNkx?=
 =?us-ascii?Q?4cNaYDoQGLkfeBd2A09P?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a51d5bd-7ebd-471f-760a-08dcb2f020a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 12:39:19.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5499

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/sg2042-mcu.rst |  39 +++
 drivers/hwmon/Kconfig              |  11 +
 drivers/hwmon/Makefile             |   1 +
 drivers/hwmon/sg2042-mcu.c         | 394 +++++++++++++++++++++++++++++
 5 files changed, 446 insertions(+)
 create mode 100644 Documentation/hwmon/sg2042-mcu.rst
 create mode 100644 drivers/hwmon/sg2042-mcu.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 913c11390a45..ea3b5be8fe4f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
    sch5636
    scpi-hwmon
    sfctemp
+   sg2042-mcu
    sht15
    sht21
    sht3x
diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
new file mode 100644
index 000000000000..250016b47dd1
--- /dev/null
+++ b/Documentation/hwmon/sg2042-mcu.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver sg2042-mcu
+=====================
+
+Supported chips:
+
+  * Onboard MCU for sg2042
+
+    Addresses scanned: -
+
+    Prefix: 'sg2042-mcu'
+
+Authors:
+
+  - Inochi Amaoto <inochiama@outlook.com>
+
+Description
+-----------
+
+This driver supprts hardware monitoring for onboard MCU with
+i2c interface.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate
+the devices explicitly.
+Please see Documentation/i2c/instantiating-devices.rst for details.
+
+Sysfs Attributes
+----------------
+
+================= =============================================
+temp1_input       Measured temperature of SoC
+temp1_crit        Critical high temperature
+temp1_crit_hyst   hysteresis temperature restore from Critical
+temp2_input       Measured temperature of the base board
+================= =============================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..7aa6c3f322e5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called sfctemp.
 
+config SENSORS_SG2042_MCU
+	tristate "Sophgo onboard MCU support"
+	depends on I2C
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for onboard MCU of Sophgo SG2042 SoCs. This mcu provides
+	  power control and some basic information.
+
+	  This driver can be built as a module. If so, the module
+	  will be called sg2042-mcu.
+
 config SENSORS_SURFACE_FAN
 	tristate "Surface Fan Driver"
 	depends on SURFACE_AGGREGATOR
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..0bbe812a67ae 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
 obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
+obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
 obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
new file mode 100644
index 000000000000..6d8d677f86f3
--- /dev/null
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
+ *
+ * Sophgo power control mcu for SG2042
+ */
+
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+/* fixed MCU registers */
+#define REG_BOARD_TYPE				0x00
+#define REG_MCU_FIRMWARE_VERSION		0x01
+#define REG_PCB_VERSION				0x02
+#define REG_PWR_CTRL				0x03
+#define REG_SOC_TEMP				0x04
+#define REG_BOARD_TEMP				0x05
+#define REG_RST_COUNT				0x0a
+#define REG_UPTIME				0x0b
+#define REG_RESET_REASON			0x0d
+#define REG_MCU_TYPE				0x18
+#define REG_REPOWER_ACTION			0x65
+#define REG_CRITICAL_TEMP			0x66
+#define REG_REPOWER_TEMP			0x67
+
+#define REPOWER_ACTION_REBOOT			1
+#define REPOWER_ACTION_POWEROFF			2
+
+#define MCU_POWER_MAX				0xff
+
+#define DEFINE_MCU_DEBUG_ATTR(_name, _reg, _format)			\
+	static int _name##_show(struct seq_file *seqf,			\
+				    void *unused)			\
+	{								\
+		struct sg2042_mcu_data *mcu = seqf->private;		\
+		int ret;						\
+		ret = i2c_smbus_read_byte_data(mcu->client, (_reg));	\
+		if (ret < 0)						\
+			return ret;					\
+		seq_printf(seqf, _format "\n", ret);			\
+		return 0;						\
+	}								\
+	DEFINE_SHOW_ATTRIBUTE(_name)					\
+
+struct sg2042_mcu_data {
+	struct i2c_client	*client;
+	struct dentry		*debugfs;
+	struct mutex		mutex;
+};
+
+static struct dentry *sgmcu_debugfs;
+
+static ssize_t reset_count_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(mcu->client, REG_RST_COUNT);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t uptime_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 time_val[2];
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
+					    sizeof(time_val), time_val);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n",
+		       (int)(time_val[0]) + (int)(time_val[1] << 8));
+}
+
+static ssize_t reset_reason_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(mcu->client, REG_RESET_REASON);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "0x%02x\n", ret);
+}
+
+static ssize_t repower_action_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+	const char *action;
+
+	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_ACTION);
+	if (ret < 0)
+		return ret;
+
+	if (ret == REPOWER_ACTION_REBOOT)
+		action = "reboot";
+	else if (ret == REPOWER_ACTION_POWEROFF)
+		action = "poweroff";
+	else
+		action = "unknown";
+
+	return sprintf(buf, "%s\n", action);
+}
+
+static ssize_t repower_action_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 value;
+	int ret;
+
+	if (sysfs_streq("reboot", buf))
+		value = REPOWER_ACTION_REBOOT;
+	else if (sysfs_streq("poweroff", buf))
+		value = REPOWER_ACTION_POWEROFF;
+	else
+		return -EINVAL;
+
+	guard(mutex)(&mcu->mutex);
+
+	ret = i2c_smbus_write_byte_data(mcu->client,
+					REG_REPOWER_ACTION, value);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RW(repower_action);
+
+DEFINE_MCU_DEBUG_ATTR(firmware_version, REG_MCU_FIRMWARE_VERSION, "0x%02x");
+DEFINE_MCU_DEBUG_ATTR(pcb_version, REG_PCB_VERSION, "0x%02x");
+DEFINE_MCU_DEBUG_ATTR(board_type, REG_BOARD_TYPE, "0x%02x");
+DEFINE_MCU_DEBUG_ATTR(mcu_type, REG_MCU_TYPE, "%d");
+
+static struct attribute *sg2042_mcu_attrs[] = {
+	&dev_attr_reset_count.attr,
+	&dev_attr_uptime.attr,
+	&dev_attr_reset_reason.attr,
+	&dev_attr_repower_action.attr,
+	NULL
+};
+
+static const struct attribute_group sg2042_mcu_attr_group = {
+	.attrs	= sg2042_mcu_attrs,
+};
+
+static const struct attribute_group *sg2042_mcu_groups[] = {
+	&sg2042_mcu_attr_group,
+	NULL
+};
+
+static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
+					HWMON_T_CRIT_HYST,
+				 HWMON_T_INPUT),
+	NULL
+};
+
+static int sg2042_mcu_read(struct device *dev,
+			   enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int tmp;
+	u8 reg;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
+		break;
+	case hwmon_temp_crit:
+		reg = REG_CRITICAL_TEMP;
+		break;
+	case hwmon_temp_crit_hyst:
+		reg = REG_REPOWER_TEMP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
+	if (tmp < 0)
+		return tmp;
+	*val = tmp * 1000;
+
+	return 0;
+}
+
+static int sg2042_mcu_write(struct device *dev,
+			    enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int temp = val / 1000;
+	int hyst_temp, crit_temp;
+	u8 reg;
+
+	if (temp > MCU_POWER_MAX)
+		temp = MCU_POWER_MAX;
+	else if (temp < 0)
+		temp = 0;
+
+	guard(mutex)(&mcu->mutex);
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
+						     REG_REPOWER_TEMP);
+		if (hyst_temp < 0)
+			return hyst_temp;
+
+		crit_temp = temp;
+		reg = REG_CRITICAL_TEMP;
+		break;
+	case hwmon_temp_crit_hyst:
+		crit_temp = i2c_smbus_read_byte_data(mcu->client,
+						     REG_CRITICAL_TEMP);
+		if (crit_temp < 0)
+			return crit_temp;
+
+		hyst_temp = temp;
+		reg = REG_REPOWER_TEMP;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * ensure hyst_temp is smaller to avoid MCU from
+	 * keeping triggering repower event.
+	 */
+	if (crit_temp < hyst_temp)
+		return -EINVAL;
+
+	return i2c_smbus_write_byte_data(mcu->client, reg, temp);
+}
+
+static umode_t sg2042_mcu_is_visible(const void *_data,
+				     enum hwmon_sensor_types type,
+				     u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			return 0444;
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+			if (channel == 0)
+				return 0664;
+			break;
+		default:
+			return 0;
+		}
+		break;
+	default:
+		return 0;
+	}
+	return 0;
+}
+
+static const struct hwmon_ops sg2042_mcu_ops = {
+	.is_visible = sg2042_mcu_is_visible,
+	.read = sg2042_mcu_read,
+	.write = sg2042_mcu_write,
+};
+
+static const struct hwmon_chip_info sg2042_mcu_chip_info = {
+	.ops = &sg2042_mcu_ops,
+	.info = sg2042_mcu_info,
+};
+
+static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
+				    struct device *dev)
+{
+	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
+	if (mcu->debugfs) {
+		debugfs_create_file("firmware_version", 0444, mcu->debugfs,
+				    mcu, &firmware_version_fops);
+		debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
+				    &pcb_version_fops);
+		debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
+				    &mcu_type_fops);
+		debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
+				    &board_type_fops);
+	}
+}
+
+static int sg2042_mcu_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sg2042_mcu_data *mcu;
+	struct device *hwmon_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+						I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -EIO;
+
+	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mutex_init(&mcu->mutex);
+	mcu->client = client;
+
+	i2c_set_clientdata(client, mcu);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sg2042_mcu",
+							 mcu,
+							 &sg2042_mcu_chip_info,
+							 NULL);
+	if (IS_ERR_OR_NULL(hwmon_dev))
+		return -EFAULT;
+
+	sg2042_mcu_debugfs_init(mcu, dev);
+
+	return 0;
+}
+
+static void sg2042_mcu_i2c_remove(struct i2c_client *client)
+{
+	struct sg2042_mcu_data *mcu = i2c_get_clientdata(client);
+
+	debugfs_remove_recursive(mcu->debugfs);
+}
+
+static const struct i2c_device_id sg2042_mcu_id[] = {
+	{ "sg2042-hwmon-mcu", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
+
+static const struct of_device_id sg2042_mcu_of_id[] = {
+	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
+
+static struct i2c_driver sg2042_mcu_driver = {
+	.driver = {
+		.name = "sg2042-mcu",
+		.of_match_table = sg2042_mcu_of_id,
+		.dev_groups = sg2042_mcu_groups,
+	},
+	.probe = sg2042_mcu_i2c_probe,
+	.remove = sg2042_mcu_i2c_remove,
+	.id_table = sg2042_mcu_id,
+};
+
+static int __init sg2042_mcu_init(void)
+{
+	sgmcu_debugfs = debugfs_create_dir("sg2042-mcu", NULL);
+	return i2c_add_driver(&sg2042_mcu_driver);
+}
+
+static void __exit sg2042_mcu_exit(void)
+{
+	debugfs_remove_recursive(sgmcu_debugfs);
+	i2c_del_driver(&sg2042_mcu_driver);
+}
+
+module_init(sg2042_mcu_init);
+module_exit(sg2042_mcu_exit);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
+MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
+MODULE_LICENSE("GPL");
-- 
2.46.0



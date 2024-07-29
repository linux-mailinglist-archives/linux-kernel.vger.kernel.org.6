Return-Path: <linux-kernel+bounces-265014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E893EB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0AFBB210A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15AF7D07F;
	Mon, 29 Jul 2024 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CoQ9hB2U"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2049.outbound.protection.outlook.com [40.92.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42878C8E;
	Mon, 29 Jul 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219969; cv=fail; b=CN+3LsWR3SU53UbHO2JhDqP2Ikx+AtUZAeV3/VdjE02zo8xtDxENCxWkDL27W+VUcVBLnbbPPvYUdrwGQEAfyiqYljKjxKktjWhIl9tb0KuWr+n4I0A5GLZOZTkqQyexhhzARgaxGP5VYe6Vs4PwO85CGaD9awqvu2oCYBAEHUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219969; c=relaxed/simple;
	bh=c3JafCMLA4E+cdwqf42EWVUUBqkvd4XhDo5D+4+jOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jeoGGFby+Da3fFMJ1Z0mIrBf0Q1rLCj6aJFcF7Bhzduim8P36rqMwvc48M9YPREYxTxnU8xJ1HnIUbBMg8xDNcCtYY08SSAtJlQYcmPWS6iS8l9+qwtKzw9Ae0P5PY1Qbq4A4ayjuxaWZAmWVCNsWHkwN9j5naYX7CxgIuixY7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CoQ9hB2U; arc=fail smtp.client-ip=40.92.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCaR6bsUuwB3T8Sx3wM9+Ddh9YG6fdFucrP3H6vf8fuU/TPDBCCpZMUTUBsi7XXBebdLEMEmaniJhXV+60u/ovcB2hgMXQARwdgRAXQ2eJkPai+5OusQLRPHqYvVorwYuLWc+Gwd8ZQXR2Q9ExakGiqYV13zOHq+ddL84QmLFSAZG1vf17IWZu6HLzT2C57fdW/PnosHBGZRJ0z8uhh64MlZFFh1HIUg+grH/THcpgqSCnKuRgM62cp0kBFXIJEdONC/kb+rULDiDQr6fZ9BZ4rrl0PKfx5Wl5Zh7p7E5LLHKjFJVFxBPxkCk3vCi9C7A7EmKVNsOosbAQRrg0REEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbSqnIXZl0uiN6hfXuXKPbGDXmA19Y7IbvQAybjbSeE=;
 b=s6ptYz3J2jFQ5B1kPy4yhCpNi1Kpjn/Sz3yuwqG7EPL1ipbscZtdi2oWs+wb31iW5aFu71P6apPUxmvNFIzApR88GyLSp0qxm53WGt6ooCSFj8T8C6LDoq215MyU6/b96yd3FndSDhSGfmCZrnuygHF3FPJsnZFCTtb51QjL/dPFT49Et/RI3VtbHgdi1+PfJV6dZwajeRCmTLZfVkuaLu1ae4qOglml/vW5F4DOL/CCGyPmsmJoPIRnMHpgWv12CCKlKjM5UUhkxDFDXpOKQkZc4x8SpQx4LyMOrrZia9Y3JtLpgF8zGTnMfbERJiRsprsfwo/Njz7A+ckjhH42OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbSqnIXZl0uiN6hfXuXKPbGDXmA19Y7IbvQAybjbSeE=;
 b=CoQ9hB2US1bVkC8E8fUyTg+8lHayU9aRFtgHQbMlhnGHgi1fmtM+lucjZ3NeXLdpJ8SbCQsTLUiTzmnHAHGPFf7tBUsYBB3SoJyyQkQCh6GmDtSPkospG1H0hxjeNtXKIlt4fWGplsKWYkMlxs80Sq8G8oKELsZyw4cJOXjvscz3HwNAXIo83LCSOmKDXNNcmTjn3vScIwPgdneYCed3IGBwV808UOcRyetxnaCLtDud8Jy8lMLz2HFDbsvEKaY2a2tUM/NNejnh+Vp07F6AvyjPCiSO+G1DcSE4Qpz+5WrDid2DoEqWcKw7WMSTBzVQtsy/xk0lp23MAY8+ArdQfg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:26:04 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:26:04 +0000
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
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v7 2/4] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Mon, 29 Jul 2024 10:25:31 +0800
Message-ID:
 <IA1PR20MB4953E47D7718F607342B6149BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49534B9F7A3B4A1585467C87BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8yZzUcWUecMjBHEZd8W4HfLTW3tKp8rmaE/9ax2+LIQ=]
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240729022534.842326-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 45146d06-ffb6-46d1-a085-08dcaf75cbc7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599006|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	ppHA4tNfObmvjpGyeaDdNq9AZPI9f8fYXoTkLpgKbnM5fobppG9Lstne/K5bdh9f4Fc1dT21EywJrGmyPAVDXd4ZnBaOX+hZMSA0Kxs4TXOBGxN5keU566X2LorDI991+OGmwSsZj8fc/TGvcdMYHHeYmnkW5hBBABV+fNDYryr+QA8qgs+M6PGdAcy3p4V0IsnsWwEZKztBomO+/ANBs7GcBu31JWy3TcpYQqifv7/M3uvo2x++QcQYXppzRUsXhCytVMWtEgQ1ah+PBYm3yUvq88sYYul+p689w18IF5pyaYdwPjaFDZsUvfvk1LSQ0UpQrXcjjr6JEfsf/wF3+X52VvzWUtElJrzlEGrH6OtZc+9yKP57Yv+BEJpOBhjRGmDq+lGH0vX89y4iEmhbW4B6MZm/fBoWBuInj5zzrCsPXqIG6k3hpe+BPS8B/2Oq2R5CWaU5RsKSIqh1w3C463RF+qrFRx/E7o8ehvLVp5ZUB+QYqFPT/7No0KqfY7OenUBpq2nrHcJ92fW5Aeg+wZatI3Ez8ouHXBOm1i2PXb83OtqvSbGXkm1ehWunqQYheq4LQ6Oe6FgJ/Ow+2kYbkXjaL81+KVVaV3VUKeuZgwnhzV0Zdnz6NABTmWIm9ybpMZuWI/F28XdijgW3RN9LwFXflC57VZF0/GabPhNpv3qt+xgsiapdZo45gCdioKcwe39J85giTZj2g/KL5wLoyA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuqW0OiviQ5Gn9GWmVAlnbdq2RXM9tInH2polvubWEPZgBSpoP6wVVzfSf+a?=
 =?us-ascii?Q?fCUiREb++u88AZmfLl3RvXR+SFbRRbOIWQEqI6Mb81F4tsGhBiXsID1KlG3I?=
 =?us-ascii?Q?2O9wIAlHVbuiCC5UBQskzhtJgB/UznrHYFcdeCQrnZRFhhMTvWDFVnrZ0ZtU?=
 =?us-ascii?Q?3NVvVZg5ATx+5xI4A+k8DMiboIF9ZQbRzqyu1fx0kEo0QJIZ4TaNxrDOuiJY?=
 =?us-ascii?Q?x14jZqf+qxfoH+LCOlU6CCcGWlCIz59fiQEuXTBk+hcwfIwVyfjaPH8cqKtA?=
 =?us-ascii?Q?ewCp4NZm+X+rFymgH5BAnx+bQZEuJaHPT2vBzOJxsiPlgl0oF5UJf9TO2/ww?=
 =?us-ascii?Q?LjkF4cQquXzpoKrYPQw5Pu+NNPgACwQr044ZNbwx4I9q/Z5dG+Ovb+XOFPWl?=
 =?us-ascii?Q?ia+1KV4J3XhFPcP8YpuGTHX58e5kuJeegw/XK22Yf04GN+k2m0h7LKWY57/t?=
 =?us-ascii?Q?qoPd8HzLYX5g2HViI009am2jS1LGyrLMLN2cnJDSHGU1aGOntkvk5WHjpuPF?=
 =?us-ascii?Q?4KyeceRsCdT2ZrNCcaIFRFXMk7qIMn7t7ZGIf8Apwg0ot+dgLYy8f+Mr/cTT?=
 =?us-ascii?Q?atY7ZRXMHaJ0tcLW5JfvpjjyU5R/1+Qg9AaE3KUZfxpOSi4sserWJPaLFeqK?=
 =?us-ascii?Q?A8vHuMUgZnpSjjuWQZ0AaMdj8GLzj/KQSIPn+EL/t0x8nDiQDZypjjYvUl9D?=
 =?us-ascii?Q?LpafWCgal4m4cusOLziWtyw7Q9yH06nKjq8Rf5RmSOW57fT7WKPT3Bt9CHvL?=
 =?us-ascii?Q?WTdX3N2w6Iqe+aepKBWR5acJGT0PHYpjF9i3/oO7vVxiMvgoXiyWWo05IhGk?=
 =?us-ascii?Q?+B34eqsinDjeYPsmTPvukndXEbJkygg3SFvUmwieHV8zmQ3yO7Xg5I552/ud?=
 =?us-ascii?Q?62DRIt05q/lH8s9z7c2UBzEiueIwFSE1tEvrPg8NDTtEGeTZ9vYRNLfOQAPp?=
 =?us-ascii?Q?0ijYf5/L81ZZZffXkbXSfyg9+8qOst4EeffkFOOiOPnIuykDYRqa7lp7+4gL?=
 =?us-ascii?Q?3OPj2++foNhJVcYH0ANjzcOFcrvkz1WvstH/Dbe93GIxdaw4iQ/yM2KsOzDF?=
 =?us-ascii?Q?aL6mbiKijJbSagMPPlWbdMQAp8CGhp/uKY8rBccWv8+b3ODi9uYBih33z2TA?=
 =?us-ascii?Q?FegXLQ4kfY61IYApRjBoFVltmF+o2jMCjTwF8rkbZXBhAZRnsxiAl/27DEb2?=
 =?us-ascii?Q?MLAW39k+66AiXSacqZ1FwmW14VG4Ul1SPwGzoNxgVeB2nc12l3XV/pc3x1xk?=
 =?us-ascii?Q?aI949KetXCd+nO+l/k76?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45146d06-ffb6-46d1-a085-08dcaf75cbc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:26:04.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/sg2042-mcu.rst |  39 +++
 drivers/hwmon/Kconfig              |  11 +
 drivers/hwmon/Makefile             |   1 +
 drivers/hwmon/sg2042-mcu.c         | 399 +++++++++++++++++++++++++++++
 5 files changed, 451 insertions(+)
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
index 000000000000..c8ecf5de1be3
--- /dev/null
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
+ *
+ * Sophgo power control mcu for SG2042
+ */
+
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
+#define REG_CRITICAL_ACTIONS			0x65
+#define REG_CRITICAL_TEMP			0x66
+#define REG_REPOWER_TEMP			0x67
+
+#define CRITICAL_ACTION_REBOOT			1
+#define CRITICAL_ACTION_POWEROFF		2
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
+static ssize_t critical_action_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+	const char *action;
+
+	ret = i2c_smbus_read_byte_data(mcu->client, REG_CRITICAL_ACTIONS);
+	if (ret < 0)
+		return ret;
+
+	if (ret == CRITICAL_ACTION_REBOOT)
+		action = "reboot";
+	else if (ret == CRITICAL_ACTION_POWEROFF)
+		action = "poweroff";
+	else
+		action = "unknown";
+
+	return sprintf(buf, "%s\n", action);
+}
+
+static ssize_t critical_action_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int value;
+
+	if (sysfs_streq("reboot", buf))
+		value = CRITICAL_ACTION_REBOOT;
+	else if (sysfs_streq("poweroff", buf))
+		value = CRITICAL_ACTION_POWEROFF;
+	else
+		return -EINVAL;
+
+	return i2c_smbus_write_byte_data(mcu->client,
+					 REG_CRITICAL_ACTIONS, value);
+}
+
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RW(critical_action);
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
+	&dev_attr_critical_action.attr,
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
+static int sg2042_mcu_read_temp(struct device *dev,
+				u32 attr, int channel,
+				long *val)
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
+static int sg2042_mcu_read(struct device *dev,
+			   enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	return sg2042_mcu_read_temp(dev, attr, channel, val);
+}
+
+static int sg2042_mcu_write(struct device *dev,
+			    enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int temp = val / 1000;
+	int hyst_temp, crit_temp;
+	int ret;
+	u8 reg;
+
+	if (temp > MCU_POWER_MAX)
+		temp = MCU_POWER_MAX;
+
+	mutex_lock(&mcu->mutex);
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
+						     REG_REPOWER_TEMP);
+		if (hyst_temp < 0) {
+			ret = -ENODEV;
+			goto failed;
+		}
+
+		crit_temp = temp;
+		reg = REG_CRITICAL_TEMP;
+		break;
+	case hwmon_temp_crit_hyst:
+		crit_temp = i2c_smbus_read_byte_data(mcu->client,
+						     REG_CRITICAL_TEMP);
+		if (crit_temp < 0) {
+			ret = -ENODEV;
+			goto failed;
+		}
+
+		hyst_temp = temp;
+		reg = REG_REPOWER_TEMP;
+		break;
+	default:
+		mutex_unlock(&mcu->mutex);
+		return -EOPNOTSUPP;
+	}
+
+	if (crit_temp < hyst_temp) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	ret = i2c_smbus_write_byte_data(mcu->client, reg, temp);
+
+failed:
+	mutex_unlock(&mcu->mutex);
+	return ret;
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
2.45.2



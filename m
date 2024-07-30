Return-Path: <linux-kernel+bounces-266950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD6940A44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A6283E55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E57191F98;
	Tue, 30 Jul 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iBMN7l+W"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2030.outbound.protection.outlook.com [40.92.23.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD36191F86;
	Tue, 30 Jul 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325882; cv=fail; b=c8QKEyTAx5AAMNy9+Qfm81h7qmC/JhgeV7aXAUaV5TU9mXhG7vD+Cj2jEbP1lab2DTQ9eqD+WX3UFw1VbbvPB/sZsV494ThTzeH/Be2tL+OrrTNJrsS+4DFlhxmLknuzBbHrx9tVbJAIEZXqg1foamzgYy3eTItfdfskJNbKHHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325882; c=relaxed/simple;
	bh=bp5FldTaOMK4oQtsiU3hPT+9raFFZZEgPPJfmq3dzCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAUyp26AeHGvMNpAPczw+H3BQGBnKYzCwmiynjzJFFWCaY2ZcXZDuzU/vf6po8dMgmCAjcWbxuTEDJ5Kg8u0XmmqX5jaB7v9+Lp2drfQJYltKGWowzK4JscedafegVAEayDth+fHO0jL4uMeB2sQ84/YrVCuSCuufKjxdD8lu3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iBMN7l+W; arc=fail smtp.client-ip=40.92.23.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxGe/0ye3CSMOtqhBU+Zq6ZZlznaB+oh3zt/BkqlVxMac0+SjeDUobDUa7Ap1sVvbmo53IfiSSPxGTrAsW/69OXy4WluWsJMwRrxknFcCN1WjOULroBCzk9QPQ9o1m4vBFHwAwBqQ5bfSXI0mQOeXsq/QAOPY2kGkeZayiZfrWU4meCQQaJx4Fj1g09V2tbwsTeKfq3wGDEyErYjXH5FKiz5bpxn4wxBJq94Rc+G+vYr/8ZBz+IInAnVywWZ50hh0AAPR6oBVXG/jRL+nyYBvWnLn+BEjKm54M56u6+kqd39IoCtyssD75KrtRmm9m95HVQyxejB3JvGcpIvHJlf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EstjeuHfQfO6z6cXhvZ4lH+ZqmhUOk8AW7L62uIBfs=;
 b=Llo84HjjPBvU8VNbd0hzmNZLfIl5Fihux+d179pBrItTH5kSn8Euva5FYf3HUvzm31lkFyX+JHrvhAkfUFpOn7UFLxbQlHsjSa6zfoXMf1n5ZuluDG5dqfVZ7Q0IvzyOYl20QTJtWChHqYYIx+OdcNqNHY6Uqx8cp5tWMY6gV7FSVDAO3AuewlU9jlDLWTkZz/87OLagBDfuW/vQTQuTYkaAoqwuIv5081lug0sPCPK1gxLVBMI8Y6XEvXUvjHU9LwdW/+tq9xmkmnAjIHc+cToiqBkPX3uWWHsmBm2ywGZ5NMmE1wRhAXnryLT4/LjhhXOjVm5NlXSMZKvliK5Jrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EstjeuHfQfO6z6cXhvZ4lH+ZqmhUOk8AW7L62uIBfs=;
 b=iBMN7l+Wc/KEvhYjjr3jrT9Dw5ePaf4H0dppzonihg7DvuJphKMUrw3aME+OgreWcEjGJm1Nj88kuqQOcsMbdW8MNtJygmtGKLAx4ZGk9cCXH2Ed7/IS+oZcVRY3WfJ20S308oUAZBlESUfuviARKEpV7Oevt999Dg0HoUIkrLaTKqoPY8QxxJD0yacZXRwRQ+VSYCT9aRNn12ZQh3zT/LmwFa5dzj4QpNFmHfd6nsnx9S6Edmo1u4eN4d9DuMpFc8EGsXqhPW6p6LPuaDIcbvFaAQhFr64c+leFIk/JMZ1iKLTom0jMXAONIUH6Z1JY5EcIAL2E2bVj0Jwri7+2GA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7552.namprd20.prod.outlook.com (2603:10b6:208:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 30 Jul
 2024 07:51:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:51:18 +0000
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
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 2/4] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Tue, 30 Jul 2024 15:50:38 +0800
Message-ID:
 <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+sZc7L9YX7oQKPnpHTi6pL8W8QFdGjKtLRCJNHhBNeA=]
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240730075041.489815-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd4fdf3-229c-44e7-c0c2-08dcb06c6519
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	RGJwUQceGdtUEpD+F1VGK51uO3aJmq8MGjihPhazR4Rale7Q1uXOmH144BoMPUEVZ8NIRXcctdl5DYjHB7XXdbRRNcdhVqjfE617dmw/7r3pDfvtm4D8Q6deUZFHe2a1T73GdmJXxOjccrtPzhGKsOkmvCLvV54IQKbA3sRSIiux2dGetTop2c1BKJPOD71Ic67iPmYw8MFPgWxLYz9oTvnm8uyxVeWZRd9V6S7yioe4dfgV046GfqZAOtPNY4Tju1ouXvSBsvQS7mSHita4sz0w4/rUEtDVdq08JPhianKum2Jbc4cVd9Ugh6D70HomFkY0QQcZLV1cTrEECwQgXj5ZMlQ7CdIUoGdA3BCSIayyZPxON+s0y2tiudvirxp4m7KYCL5M8Qrk09D7QDkyPVce+KberYUwhDmk9OZBUsxF+5ceEn/rsZpygeXPxTQui50ln03Jd/kjQO6OL4N3wh7eUH5v/+/AukZ13Edfalf694EoOeN1vh8IueUSTgLVE14NlRBrsFeJpBavtrjXE7yOUlY6Rn5JtZD9eKh09UqON40if/SKcw5FgorkuWk2zGCz2X8El+ejFxfW81bP3S+nshB7F2BWxDMQK+q3jWfSqZ1jMRN9SlQLGGbHu51voX1F72CSWSwavUep6t4uQGcrvUggiPIA1wu1zuYSmHlp6Haygl1IFXhnympSl0kpW5dYC4IhillsEM+028NVRg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnDThXkAPgivf7/NTu6UR5CfBu0Cx763iXx9Cq17+Nb0+0B4tp7aLopy9T45?=
 =?us-ascii?Q?jHf1SKSsriypHEZ40TUBC8exDP3nOj2SRmKnLgW2aFU5hb6UY12zwwPQcWTA?=
 =?us-ascii?Q?W9D3HCmvMTfYp3387jSTQtWeUxsJh1Gt0K40gXOBmAtadQSJOODECR17TkOx?=
 =?us-ascii?Q?0MBdxyxZOcP8nQn1ttajJmZW7RTRG8Qzc5jjRB6EIDUQhov5wLPD/h8hKMS5?=
 =?us-ascii?Q?0NSYvpO8oVPjurLQ0hB9Oc66/kA4MjasKcpV8WOQbQeG7x7va1iX9OHodUHk?=
 =?us-ascii?Q?+SGS8d+5BYdixkchSij9xlMyKEaQ3HYf4oaK6n0U5gT3n2WawtBtjVAUtf7Q?=
 =?us-ascii?Q?/wA+26bi5iKBXQ9xzTkWAgS4zW/ap1Ijw4NidkVQvh4df8mXYgBydUGh3jeZ?=
 =?us-ascii?Q?o7Lvv1WiQXJjbYr7UEAl1NCSunzfAR2BJ+6qMMsz5NavakHdCyk8dlPfDdIo?=
 =?us-ascii?Q?ZpBMOkLa26pklfEgHnI3nvhNdLDxTXSICmIweYcWqPgIKq+9MN4SEj2ozuWQ?=
 =?us-ascii?Q?PlRVaMGCTP+1d4fs4hrY1yZxjUXIRSGTwXRY00u3FdGsm+6l20/rXRwH5W/6?=
 =?us-ascii?Q?w1q/HWhJ+K2RUwJ+VTRT3+VQcMe2ELwsBHP/8LdpCmj0vPUW3LZjmVzWrixZ?=
 =?us-ascii?Q?ZILg5x3ORmN14DegBmaB4uSzc6lj5hwyYzZy+DbaYrkq03jcRrs/HKfMVBb4?=
 =?us-ascii?Q?ArU1uql1NzNsW/jbXVc/+0wlJqpW849j7D7o9OFrxuwue9l2x4G2ad5Xd1oB?=
 =?us-ascii?Q?Jt23ypdDGcb87n4ZkYakYJV4FVnAW9Wtbdv9+FoSW81dPJkabjBqy6OwDRS4?=
 =?us-ascii?Q?YYTezc8/Iq//P+pzgwUOpzm3BOAvQ0rEgQwsCs4qBde5ygU98c9tWz8E2I2a?=
 =?us-ascii?Q?A3azT/oZoc+xRjL3pNC9f6+8VG4WeE9GbZtD/tGgHM3kPgrGCsQThPqlP4nS?=
 =?us-ascii?Q?ziwMOhDtLlqAKkQwiCGCpN71YQ2XlbwFfr7bAuOdXikqMlNwxyGDuQKObIG/?=
 =?us-ascii?Q?MC9SjzR7avhZ4MAbjbr7yjxoBvSgio+n5/lZ/iGjF/qTYjlcNItkVhtJ80aV?=
 =?us-ascii?Q?WZGNrWMe7hkNHxqQwQmVAdsjvXfa84tiqwLiqySrJCTwmj6oOLHGshALBimI?=
 =?us-ascii?Q?yW1falr8d4pcIvdROVOEWU5o1KWeq+OBIYNbi0xKdOYVDmJ0mvZavfrWUm2s?=
 =?us-ascii?Q?10z2STdRyIDS1S7y+nWdm/SkurYiaspBnO3yDxtRcj9vNDHvJ9myJmT0IC+w?=
 =?us-ascii?Q?EfSLmIzzIvwT9va/1Sgp?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd4fdf3-229c-44e7-c0c2-08dcb06c6519
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:51:18.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7552

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/sg2042-mcu.rst |  39 +++
 drivers/hwmon/Kconfig              |  11 +
 drivers/hwmon/Makefile             |   1 +
 drivers/hwmon/sg2042-mcu.c         | 406 +++++++++++++++++++++++++++++
 5 files changed, 458 insertions(+)
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
index 000000000000..37fac3e5f233
--- /dev/null
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -0,0 +1,406 @@
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
+	u8 value;
+	int ret;
+
+	if (sysfs_streq("reboot", buf))
+		value = CRITICAL_ACTION_REBOOT;
+	else if (sysfs_streq("poweroff", buf))
+		value = CRITICAL_ACTION_POWEROFF;
+	else
+		return -EINVAL;
+
+	mutex_lock(&mcu->mutex);
+	ret = i2c_smbus_write_byte_data(mcu->client,
+					REG_CRITICAL_ACTIONS, value);
+	mutex_unlock(&mcu->mutex);
+
+	if (ret < 0)
+		return ret;
+	return count;
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



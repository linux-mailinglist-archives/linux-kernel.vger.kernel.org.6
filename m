Return-Path: <linux-kernel+bounces-177179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0E8C3B19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040A4281654
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39924146598;
	Mon, 13 May 2024 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lqxtmUAl"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2076.outbound.protection.outlook.com [40.92.53.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52871CD3D;
	Mon, 13 May 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579563; cv=fail; b=cj0WFCunrqmaqryov6UOuPtXZn7QAuGVDvNYE0VP69ZDInqIrLPn4KPWMAZi/ZPKWf9BEGwaXmqqeJjMilMhDCbqWap90hluvrhh+59FSGS3deL17rZQD4gzJevpejEAUUdXGDa22b8Q9LXxum0oCM969sKLSdrCzzy1j9x7x7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579563; c=relaxed/simple;
	bh=LJ7CWB86vxFVuMQWt40A9/6vPXEXvv80gUbjNAtqxns=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OETJxnnhekgqs2IasMLILVI0qGn3zQy5BCt+G62B4C22PRnquNPbMY924Y17zgORPSD9GHbcfAMIBN9WYT5fM1T19e+VO19Gf+aqJqo8ccTqaWuS62D7GwrhgiKrL6Rlq03H1jlFu24vdPMXjSSg9nlrWUI2bBFRYrykwf+SV30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lqxtmUAl; arc=fail smtp.client-ip=40.92.53.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEECcurqULSH5V65VPk1w+z8E01ogmE61g0Wh/6WMeOc51/bqG0wNjCXwahK4TmKB7sotBm5AJrGwDfG6Jj3AmOt6dzScdjiTtvWFQ02b1Z8KR4mOCbgXdk+0avwOkvBGfYCqwMGVXBu1wIE2H3qkg8hv+76a1DecjGHW0IhKl25pl5MhfWDVWEzfkUuFNQ7ij8Ejde+MKBMiPofn8AVpu1y/pCIkT2VcZhdMiYGD2v1qO/Y6/B5Qibc+G/qsw9Qmv3IAtom82XDu+axxI39ccNtFEuhRs6hTrfxeCOnowSHGapxKc1LxPDiuhdJHnKESRZ9myMxiB1CTHlQ5+WJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZAYe0I4y2zPvzmxalIMgNxaAzkYY9Cwkub7DrGyQCo=;
 b=hqZrnqlDkqpya4Tu2bo/WV/BB5/kpolLLRxSJLtHottByAqX7t/PRp+i4M+zi5rGmmGe6xSpQz+eCdYjV/UcpJAzBHWRvJaeu9j5tWt164xy8wTbifF0eDtT/eiHDby1Y3Pqvrs1T9ku5TbdPOEoHyCNQiJZuaNxjXH0Ep9PDTOgrywJRnq+Q2QHIPwZe9gkUjUr/DemJi4CXQ8PPASWDNclh87vUYIxJRfUhUPFNjujnXr/VBWUMPfdrfORLa87V1SeD/wNvL+DnsznDm7wO49821Hqav1zf8iv0x1r0WK1Uk2WilGBj1wXhz1wojwmsS/BjPJeq3Z0eI+EmZTDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZAYe0I4y2zPvzmxalIMgNxaAzkYY9Cwkub7DrGyQCo=;
 b=lqxtmUAlvbmgSmj1SIiW6HFQREtAOsLcTUSxpnQnT9YZV2rgZFPKf3MtcF/mzZuXLKxDwWgdwKlNZiKkC8Tr9rckmFkb3zOCFk71MRFIvgTYnbjUmb14OU4XU9YGt8YUon5q01uIB8Y9t4XFphdPn6Xe2PqxJPLg3fwC9FMqgFmiLIw3CitfmgmQnUNSZin/VCjxaOKIp2TXuKsV0iNtmtbdMU6Ui88oSZNwstfQK/7RBvwr5oGpJ2zM2HvRESSkHEy6Hkp+XTk89rd5ZNvtCNSNOFifaO7Xy11hBJjBtRGLrHvhDAeUtS7z9wvGa0RoUz0ySia7U0jfh+XNN8m0jQ==
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com (2603:1096:101:be::7)
 by SEYPR04MB7038.apcprd04.prod.outlook.com (2603:1096:101:178::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 05:52:37 +0000
Received: from SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5]) by SEYPR04MB6482.apcprd04.prod.outlook.com
 ([fe80::ca2b:8a48:a7ab:60e5%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 05:52:37 +0000
From: Noah Wang <noahwang.wang@outlook.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Noah Wang <noahwang.wang@outlook.com>
Subject: [PATCH] hwmon: add MP2891 driver
Date: Mon, 13 May 2024 13:52:25 +0800
Message-ID:
 <SEYPR04MB64825A740FDE7282B2FECEE2FAE22@SEYPR04MB6482.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4pKL7c1cD8k7/UH+Fp3QHnWAQeXzfbpK]
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To SEYPR04MB6482.apcprd04.prod.outlook.com
 (2603:1096:101:be::7)
X-Microsoft-Original-Message-ID:
 <20240513055225.320549-1-noahwang.wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR04MB6482:EE_|SEYPR04MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1d1ce2-292c-4943-44cb-08dc7310e481
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	3o/ajM4BDF8Wh+qqsFtdXhC2zo5ArvWXCJg5G0XzNwhEUoxXBz854GEOz2kYe5UJcDmcXLILRvYhUUavL5ePwZqTvHI4cF2j+jU19rZkzq7FbcvVAQuxTw1gcNMl6mXbd8hHsg928w5tANNa9+G59Ic5R54GtnpYIDH5n+9wySpBcwCimaIRRdsHkdj9PXjZTWEPMH47wQBT8Qbov1TinZR9EP+hdt9OIyi0YbUTimFw0BKBKlwR8EJa29ZMm7vrjd0HXc5dgqPKJ6wNM+sGAilqKZs5DBTPYoCoz5x6X3c+K38Qd7cU5QBLaGMimbBJ7BQeFYVRAlhHoEBTkK7N910WwRAAQEBz6udUIWGgDTe5FzAsciehoQ0odZ//bXD/VWNgBjk/cz2nN8I+6M445tRxry3AqZ8xPz0uoKcLtaLkJ/S6PuFsJTxIKcPZ5zWQL6xP2am8eUIpGWRtpK2mcxXZ1HxeIQtpxMKOemWUlmaPnPxVrG8EE+RM3Ck0NRCykaSCdzCdGEcCWlCBvmsfH9lw7mQri/FJdKIUKmU/M0dx5gayoHk7S+0gUEooeqN1yDfTk6dTPLScgrZ6EBIIxc/3jEDJZweryAt8y16G7wlClgfIy3NzcDddxXFKEUMDrS/T7n3vEz7nrFOoD5a6okQNVV2QYXQ5akZSheJ3JD+IY+tIMaw0ZWhh1cE3rs0Z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?176c6hxRd1DFJrsqH8ZmuIOniXD+lAxnJ8xkMiWptnYjE0roX6wwH6r8sSnw?=
 =?us-ascii?Q?acC7xSVA3oMduGpUPBp5w1aqrSayGrTbEoSnfJGg+GxlXRHKwkHNmCNkaLdL?=
 =?us-ascii?Q?a0uwEFtzw5tvWmUpE0HK4mhvYL4VduyK+nWq25gHDy7SdOxkw0WKu3o25TVc?=
 =?us-ascii?Q?qC+PuXnnZeztUcAixz79vMOuqne5muXEUgI5Z7zMqYOGXMrspBPZkN6PFxU0?=
 =?us-ascii?Q?MEEBlBY3PixF9yQU20fhnKwI6+v0rOLVyrKBIkq8K8R88cOELBXebuf9Y+cx?=
 =?us-ascii?Q?+Q/g5kcxsZcnowXstaRtBZ1My7+EC7sDoZCRv4aN4p2HxsKbw6KILGvhcu8b?=
 =?us-ascii?Q?GrLpX1WWE2ijGHc7ithmGYgJlPqmDT1WK7hv49pXabkbHPBS7v7B7QKWrhWz?=
 =?us-ascii?Q?Cq5PeqC2KRJOfnxtzSKwir9Tz/oAoOjUqAUjKZsen+YB5LGcPt31PZesQmyV?=
 =?us-ascii?Q?ZOR5BC4l0qzc54mT8CgYtg4pFyHbJy+96bDUbrFhUwEHO5VIot6okZdsIKKa?=
 =?us-ascii?Q?6fHoiGzF58vJEA95f0IaBpsj+I+ko/IGUdGB6Z+XCmEKchhTku4thdchmSjo?=
 =?us-ascii?Q?QwmuHBqWszjfKxqxI7No2pThwPZyeARTeVUvixOI0rRd9ghMOPbwdfA+jFwF?=
 =?us-ascii?Q?1SdIQKcR9+1dx97pWGAZebWvoH8vaE7YqdIGg03VWsDLh7pbW6QG8W5uXW59?=
 =?us-ascii?Q?zgSqce/0UDIg4x9sdP2+50SjODxaLATxl0YwUjuu3/2Q81kl0pfqF4bzZ2AW?=
 =?us-ascii?Q?5wG/agRa6A3uvU9aIHOVtn6fVAFDOap5bJgIhBojm5gID4ssT6/rFGJqnzMU?=
 =?us-ascii?Q?mduGHvRnReIyyLKjBKhILMFu+6hC0S1p2dt2LgJnQ1tHnsHGPITLLaNNxPkS?=
 =?us-ascii?Q?mOJKm4cMoJNinBbpoFRo36AmgeQbNQE9cxV7kaAFBx425sYTtdzgr6Zu/1Ae?=
 =?us-ascii?Q?rMkn36pvSXPwNDGZ59Fn7kC1p4OnkchJzkEkpY6tfj7rFWCcrA61aY9/ZIL+?=
 =?us-ascii?Q?QGLRyU3C8RZqCF/NxtOCn3cmyLSETNjEmhEcTvx5oZv4aXkOKDifFJTmE2Nx?=
 =?us-ascii?Q?aPXPQqhAVn1Z0Aq3n6vCKo1aOm7i0tVETQy3jKByuW1oJdLR7gIGx7QEIFeL?=
 =?us-ascii?Q?2riSIyo8sf7hXq5TaSBVX+hw40GyGO3m+XZw/w6YwAAWRXV5JnSPAlevTPH9?=
 =?us-ascii?Q?aK3p/kwNXryDrG2oIiinzvl7ns4is1nh5+u5DOfDJKgcH+D24jMvqmwsbA7Z?=
 =?us-ascii?Q?w6jzsgyt4JNspQMARvBk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1d1ce2-292c-4943-44cb-08dc7310e481
X-MS-Exchange-CrossTenant-AuthSource: SEYPR04MB6482.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 05:52:37.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7038

This driver is designed for MPS VR controller mp2891. The input
voltage, output voltage, input current, output current, input
power, output power and temperature of per rail can be obtained
from hwmon sysfs that the driver provided.

Signed-off-by: Noah Wang <noahwang.wang@outlook.com>
---
 Documentation/hwmon/mp2891.rst |  95 +++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |   9 ++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/mp2891.c   | 210 +++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/hwmon/mp2891.rst
 create mode 100644 drivers/hwmon/pmbus/mp2891.c

diff --git a/Documentation/hwmon/mp2891.rst b/Documentation/hwmon/mp2891.rst
new file mode 100644
index 000000000..eaf73fe60
--- /dev/null
+++ b/Documentation/hwmon/mp2891.rst
@@ -0,0 +1,95 @@
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
+The driver provides the following attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in3_input**
+
+**in3_label**
+
+The driver provides the following attributes for input current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr2_input**
+
+**curr2_label**
+
+The driver provides the following attributes for output current:
+
+**curr3_input**
+
+**curr3_label**
+
+**curr4_input**
+
+**curr4_label**
+
+The driver provides the following attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+**power2_input**
+
+**power2_label**
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
+**temp2_input**
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 557ae0c41..b8b6c7724 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -361,6 +361,15 @@ config SENSORS_MP5990
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
index f14ecf03a..57b91c20e 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
 obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
+obj-$(CONFIG_SENSORS_MP2891)   += mp2891.o
 obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
 obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
 obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
new file mode 100644
index 000000000..c98d9ec6b
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp2891.c
@@ -0,0 +1,210 @@
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
+/* Vendor specific registers, the register READ_PIN_EST(0x94),
+ * MFR_VOUT_LOOP_CTRL(0xBD) and READ_IIN_EST(0x95) redefine
+ * the standard PMBUS register.
+ */
+#define MFR_VOUT_LOOP_CTRL      0xBD
+#define READ_PIN_EST            0x94
+#define READ_IIN_EST            0x95
+
+#define MP2891_PAGE_NUM			2
+
+#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
+							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
+							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
+							PMBUS_HAVE_IIN | PMBUS_PHASE_VIRTUAL)
+
+#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
+							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
+							PMBUS_HAVE_IIN | PMBUS_PHASE_VIRTUAL)
+
+struct mp2891_data {
+	struct pmbus_driver_info info;
+};
+
+#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
+
+static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MODE:
+		ret = PB_VOUT_MODE_DIRECT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int mp2891_read_word_data(struct i2c_client *client, int page, int phase,
+			      int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_READ_VIN:
+	case PMBUS_READ_IOUT:
+	case PMBUS_READ_POUT:
+	case PMBUS_READ_VOUT:
+	case PMBUS_READ_TEMPERATURE_1:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		break;
+	case PMBUS_READ_IIN:
+		ret = pmbus_read_word_data(client, page, phase, READ_IIN_EST);
+		break;
+	case PMBUS_READ_PIN:
+		ret = pmbus_read_word_data(client, page, phase, READ_PIN_EST);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mp2891_identify_vout_scale(struct i2c_client *client, struct mp2891_data *data,
+							u32 reg, int page)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Obtain vout scale from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
+	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vout scale is below:
+	 * 2.5mV/LSB
+	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vout scale is decided by
+	 * MFR_VOUT_LOOP_CTRL[15:14]:
+	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
+	 */
+	if (ret & GENMASK(13, 13)) {
+		data->info.m[PSC_VOLTAGE_OUT] = 4;
+		data->info.R[PSC_VOLTAGE_OUT] = -1;
+		data->info.b[PSC_VOLTAGE_OUT] = 0;
+	} else {
+		ret = (ret & GENMASK(15, 14)) >> 14;
+		if (ret == 0) {
+			data->info.m[PSC_VOLTAGE_OUT] = 16;
+			data->info.R[PSC_VOLTAGE_OUT] = -2;
+			data->info.b[PSC_VOLTAGE_OUT] = 0;
+		} else if (ret == 1) {
+			data->info.m[PSC_VOLTAGE_OUT] = 2;
+			data->info.R[PSC_VOLTAGE_OUT] = -1;
+			data->info.b[PSC_VOLTAGE_OUT] = 0;
+		} else if (ret == 2) {
+			data->info.m[PSC_VOLTAGE_OUT] = 5;
+			data->info.R[PSC_VOLTAGE_OUT] = -1;
+			data->info.b[PSC_VOLTAGE_OUT] = 0;
+		} else {
+			data->info.m[PSC_VOLTAGE_OUT] = 1;
+			data->info.R[PSC_VOLTAGE_OUT] = 0;
+			data->info.b[PSC_VOLTAGE_OUT] = 0;
+		}
+	}
+
+	return 0;
+}
+
+static int
+mp2891_identify_rails_vout_scale(struct i2c_client *client, struct mp2891_data *data)
+{
+	int ret;
+
+	/* Identify vout scale from register  MFR_VOUT_LOOP_CTRL. */
+	/* Identify vout scale for rail 1. */
+	ret = mp2891_identify_vout_scale(client, data, MFR_VOUT_LOOP_CTRL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Identify vout scale for rail 2. */
+	ret = mp2891_identify_vout_scale(client, data, MFR_VOUT_LOOP_CTRL, 1);
+
+	return ret;
+}
+
+static struct pmbus_driver_info mp2891_info = {
+	.pages = MP2891_PAGE_NUM,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_POWER] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+
+	.func[0] = MP2891_RAIL1_FUNC,
+	.func[1] = MP2891_RAIL2_FUNC,
+	.read_word_data = mp2891_read_word_data,
+	.read_byte_data = mp2891_read_byte_data,
+};
+
+static int mp2891_probe(struct i2c_client *client)
+{
+	struct pmbus_driver_info *info;
+	struct mp2891_data *data;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memcpy(&data->info, &mp2891_info, sizeof(*info));
+	info = &data->info;
+
+	/* Identify vout scale per rail. */
+	ret = mp2891_identify_rails_vout_scale(client, data);
+	if (ret < 0)
+		return ret;
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
+MODULE_DESCRIPTION("PMBus driver for MPS MP2891 device");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PMBUS);
--
2.25.1



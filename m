Return-Path: <linux-kernel+bounces-238687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42173924DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6672A1C2272F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159EDF49;
	Wed,  3 Jul 2024 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RnOz68jd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2026.outbound.protection.outlook.com [40.92.22.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F99479;
	Wed,  3 Jul 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973884; cv=fail; b=Fkke88NL6pnIW+4NjlEo8HlN3DOcewhj+zpRGxG6vWbqOmOpl+ZhQMpGkq7x8IC9EKdt2S90K73oTIJ3UHy9/zvDm7KHh7pOCRbDVhoONZzIuHS3hZBrRtsI6Ifp/s5Gcqr1wbfkVY3ZGI9rWPdVdsgX5GM8OJGNInjCnshf26k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973884; c=relaxed/simple;
	bh=8i6345wT1HkmtoQTReSZA8KJE5b9Hgt2vQ6ej1HwIjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHGpoj5equLxcnOC5jJ+jbiTStOJOdq05n8CT8YQIbegpyBGB7+6722DWcE8I6yaFARyHmYQIFl+S0dzwCJtKxX2c8O6PIQVY5jlKiPsdcqTECpBpt4lhx3Bq5PbStjYYj0RLCYd7syqmq9JYiek6YMEQzygCDqepJRRYTURe0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RnOz68jd; arc=fail smtp.client-ip=40.92.22.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+Or0qZm00z2EjZ2RCQgiYr55YMgTjwBtzY/Inwy15jBHZXjBxeGlyUoYcORRD/OIT2Hk0hT5V7Yhflnr6+1SbieW26WdhxAbadVPw5dZVxYY7h2Gf2N5uX8saWZXh9VjxERaZhA2jZ1XXR9ec85Pg2XbFTRjiJfvQd+2Eu4J14c8J1e18Nte+0zd6z+1NqjfKPkm+4eaPQRmFMhw8xVZMOAtwPzeJo+zJ3OKdrmIEpIERwHa//S6elgpXHmkZLHqCW8qytX9mMcxItZ7tp7VYW/esfZg47OtLXqHjJ13yc50R1wT3fEt0fMQ1imLkhM/xni6R5WKlke0bf1e6iSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLjGvo/32zR8CVerQOeeFaC2hAi+BM2tszg+x5LJ860=;
 b=D1fJE+U1gdBru3NxXSQ8acHjpI1g2jaB9dO37QUTln2RQnMG03gyWSQCd6v1O46jrFsovWCJZiD9q4DxN1KcUaZAwubo50+AI7gcc7LdiBDSdJrxYtrhuMEdVy3ElkoxAo5o2iCF/krp/5CJiQgS0+qt70OqZasl3lQGz1O+KhNufk2BDoqvBncuLueopeKtsKGbQw0juSNuUjmT4+e+CHT17iCBgbfQsnESpZJKqDMUPCIaPbTKHhs9VEvnuaoWCkl+/A/W3EkvR0S4O95w0eEzSRLbLjgcjk+rsumD4bYDMeJK/TA5oyjkjTEZBxsGzrZ3ec+OS39drfjRQdDLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLjGvo/32zR8CVerQOeeFaC2hAi+BM2tszg+x5LJ860=;
 b=RnOz68jd0Q9RnftbMJCx8wP5LDHuIcp+hjWLQaogxv2P90awxMmWOjpTGrITQ1WNL9z9zIttPzQbytx5P5wIs6Hs4zCW4Kj/hrUWOKGMLuID6+2bs5BDvXrw914OIcK+KRDxFLfBWZz7uRzPCfuH6a5X/P/szx+zE94EqZP2P37QlR2CLvG5SHqf8okspBKp8pPAjSOi0h3xIrFS3hJODgr7KD4ZNQnvfZ/CbERt9Cz5HIf+ExBDfCTWJKoylRnZBs0d1s0uIHtUr2bRqLcw5rOcon1mTwmwQcpe8AATKk4JKnQLxFRapqD9LLGnelK5EuLWbZ4I0dRndlV+4pPXfg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5580.namprd20.prod.outlook.com (2603:10b6:806:29b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Wed, 3 Jul
 2024 02:31:20 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 02:31:20 +0000
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
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Wed,  3 Jul 2024 10:30:44 +0800
Message-ID:
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [+Yz/mSkqmkT4atH5y40PDw5vqt1NoYvtpgLFtUMXn1Q=]
X-ClientProxiedBy: TYAPR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240703023045.272744-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f5a23d-224a-4ee7-fc50-08dc9b0838f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	G/SLnqF5czCmFGD4ygNC6IwdOKv+taKQ+7/os/8Y/PYEhCgdMgYgpvxu9X2qRR4U2jPPBFnFuGcoXXLHlc99nPRLN7lb8iL3/2Kpgc+di/Tk+V6E4Av4A65a2HOMHSGDMFh368G8uYseCC9nvio5QpP7oQB1HD+Ua2kjZAYLXOKJe6assZoFzSEqsuUCjYQRrq9yO4PE/NRgEOkZGfHYq6ylzhFVVU8vJSlp1SdgZq4T29eFB9IRtFdPcwJKIJ+MKCiTjx/Vypq4nG7toCB355j0btT8BwdM7TstUXpRU6Nj5O90S7VmXyGl+KqFtpQn/iJc84CA+DdGkRGpaE1ZQU7NHvqAxMykVWAWinIKbuW+GKkQHRn0aHXjpzxb6m5Jt/7r2SHQF0t5K8G160LRtbDuZ49chcXIo4FEg5H7hb2IF34JlMu6ErNZH4VaPCPHLpUmUOZ6BzeIQRJj9+PpEu9eakGsFN9Lbp//iXgTx+mSDbIFABT8d/rKjuYweF4jWzBXfdQWLGGS2D40kxeuxwbv+NssBRrHBREE4iDZi6a2E2IDa4YvwaZajR96roDfuHVCjTjWJZgWeL1lOa7cdhseOHx4pk/5362RU6273l3tzZVos4BOAQSXbJncGapK2SopX2eXQ0Oo2350iNONWA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2L/tZfQBnQbu/r7xHwVdNDh+PqS6gdCbqZtQG7494N14/nBh1Rd/vRSWSs8n?=
 =?us-ascii?Q?+UmJJDxH0EB8zX6Z2oDvDSj341pzoAhPqGAJ9Cuc7NzK8gELIeXf2EcL+qbW?=
 =?us-ascii?Q?zZdj0veaR9paLGMmoWgzipP/UfEuEfLtPEyMDmaWjQfrei8UwmtN91HZw3X0?=
 =?us-ascii?Q?M0Is8u7H9IRtVcfQyGvT61wOuoM83weTgSdDLxUwhZKX5QD+VYZbRM95NZJm?=
 =?us-ascii?Q?QK8ulBvyFRvr+nhOiZND6PUzjKg/+GHZoTPXO/G3f8dG1+/E+YT5XDEzwg1Q?=
 =?us-ascii?Q?rNbdBaJur4CI3M4fRnx/dWZ4QKx5449n8DjKnGMZw6FUn/3IGcqHpbUUc8Qm?=
 =?us-ascii?Q?GLaO2xmOLD/ltmtSAAdN5XwoMR18qqqynLdU2nfV1r9N3npBtiYw/jvzdYJF?=
 =?us-ascii?Q?wF978AmeajY4wHV3wEb+WJxCrWu9bsVKhytGAVOUAU6+ekDN5VLCeE+xRJ43?=
 =?us-ascii?Q?Py/qClPDzUaWhMHQfOPIismp8i/av+du9WjOa2TgPffNAzRB/BASQBA59ari?=
 =?us-ascii?Q?foAVOs5DBFOje6WTYmKwydfj72tLQBXnoX8U48JVvZczOWGdIqBaMpp/IWrj?=
 =?us-ascii?Q?Wbza/r95LEcXLswD/D8VJkVz7oT6t5NPrQHWExofKEEcsEKenTVrdpdHDU2Q?=
 =?us-ascii?Q?rjR/kYi/lk1zKyJraBwfIw7pnmaiznkvxWIchkT7XNJ5FuwTL4/qhfP5gRTm?=
 =?us-ascii?Q?C9lq9ox3javPihoC1Lfs3zQe+aYtpMMXyUDJdI3GqB1qfBimfWE1TiBZy1bs?=
 =?us-ascii?Q?FfipKIe48EWmXz3LNEMDdSgXySlB8ymVjbR1EriColRUkmzOhQ0pWFc7dQ/W?=
 =?us-ascii?Q?zQO+A+1C2RNcgxoebh4+GNmJs6+Sqoz47F/OeEcTEOnUQmaCl6sXa8y/AbwN?=
 =?us-ascii?Q?a+I5f/n9QbfMbrBRNc1bVok4o+7+d6R7G8214uuLCGttxW7PsgWGygF7wruE?=
 =?us-ascii?Q?lyAXGb3aRN0SpT1iLbmA2uVfdOohCyRu9YHpBOWpRwP1OlJR4VxanooBfR5I?=
 =?us-ascii?Q?4cfUseaPlsLCHwwLzZf8+XvmYZasXETxs0f3ApmleNlYOyY3Yw20UMpsU4CW?=
 =?us-ascii?Q?CWaUn6g1Qd5iWWWRKsSx2AkswqlHvH9Ei++Ea7tpuYYsVDNwtW2OuMYqWmc7?=
 =?us-ascii?Q?hkp007lHJFLaxk0FQk4Q9Sa6bcblh96w3L3RUjV1cTwe1JOHW8u7CimmLEQL?=
 =?us-ascii?Q?NgVrLm2lvvwI1ZHY2xHFGM0v//N790BiUXYOOfCcIjkFWLAcQvIIy6DiIEAm?=
 =?us-ascii?Q?51BGchCfeYPG+aMzXV9G?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f5a23d-224a-4ee7-fc50-08dc9b0838f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:31:20.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5580

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/hwmon/index.rst |   1 +
 Documentation/hwmon/sgmcu.rst |  44 +++
 drivers/hwmon/Kconfig         |  11 +
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
 5 files changed, 642 insertions(+)
 create mode 100644 Documentation/hwmon/sgmcu.rst
 create mode 100644 drivers/hwmon/sgmcu.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 03d313af469a..189626b3a055 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
    sch5636
    scpi-hwmon
    sfctemp
+   sgmcu
    sht15
    sht21
    sht3x
diff --git a/Documentation/hwmon/sgmcu.rst b/Documentation/hwmon/sgmcu.rst
new file mode 100644
index 000000000000..5669dcfb2a33
--- /dev/null
+++ b/Documentation/hwmon/sgmcu.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver sgmcu
+=====================
+
+Supported chips:
+
+  * Onboard MCU for sg2042
+
+    Addresses scanned: -
+
+    Prefix: 'sgmcu'
+
+Authors:
+
+  - Inochi Amaoto <inochiama@outlook.com>
+
+Description
+-----------
+
+This driver supprts hardware monitoring for onboard MCU with
+PMBus interface.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate
+the devices explicitly.
+Please see Documentation/i2c/instantiating-devices.rst for details.
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
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
index e14ae18a973b..1100dd11f7f5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2079,6 +2079,17 @@ config SENSORS_SFCTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called sfctemp.

+config SENSORS_SGMCU
+	tristate "Sophgo onboard MCU support"
+	depends on I2C
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for onboard MCU of Sophgo SoCs. This mcu provides power
+	  control and some basic information.
+
+	  This driver can be built as a module. If so, the module
+	  will be called sgmcu.
+
 config SENSORS_SURFACE_FAN
 	tristate "Surface Fan Driver"
 	depends on SURFACE_AGGREGATOR
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e3f25475d1f0..e9b78ff8338e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -195,6 +195,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
 obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
+obj-$(CONFIG_SENSORS_SGMCU)	+= sgmcu.o
 obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
diff --git a/drivers/hwmon/sgmcu.c b/drivers/hwmon/sgmcu.c
new file mode 100644
index 000000000000..d941d6fe741f
--- /dev/null
+++ b/drivers/hwmon/sgmcu.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
+ *
+ * Sophgo power control mcu for SG2042
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
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
+#define CRITICAL_ACTION_REBOOT			0x1
+#define CRITICAL_ACTION_POWEROFF		0x2
+
+#define DEFAULT_REPOWER_TEMP			60
+#define MAX_REPOWER_TEMP			100
+
+#define sg2042_mcu_read_byte(client, reg)			\
+	i2c_smbus_read_byte_data(client, reg)
+#define sg2042_mcu_write_byte(client, reg, value)		\
+	i2c_smbus_write_byte_data(client, reg, value)
+#define sg2042_mcu_read_block(client, reg, array)		\
+	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
+
+#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
+	static ssize_t _name##_show(struct device *dev,			\
+				    struct device_attribute *attr,	\
+				    char *buf)				\
+	{								\
+		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
+		_type ret;						\
+		ret = sg2042_mcu_get_##_name(mcu->client);		\
+		if (ret < 0)						\
+			return ret;					\
+		return sprintf(buf, _format "\n", ret);			\
+	}
+
+#define DEFINE_MCU_DEBUG_ATTR_READ_FUNC(_name, _type, _format)		\
+	static int _name##_show(struct seq_file *seqf,			\
+				    void *unused)			\
+	{								\
+		struct sg2042_mcu_data *mcu = seqf->private;		\
+		_type ret;						\
+		ret = sg2042_mcu_get_##_name(mcu->client);		\
+		if (ret < 0)						\
+			return ret;					\
+		seq_printf(seqf, _format "\n", ret);			\
+		return 0;						\
+	}
+
+#define _CREATE_DEBUG_ENTRY(name, perm, d, data)			\
+	debugfs_create_file(#name, perm, d, data, &name##_fops)
+
+struct sg2042_mcu_board_data {
+	u8		id;
+	const char	*name;
+};
+
+struct sg2042_mcu_data {
+	struct i2c_client			*client;
+	const struct sg2042_mcu_board_data	*board_info;
+	struct dentry				*debugfs;
+};
+
+static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
+	{
+		.id = 0x80,
+		.name = "SG2042 evb x8",
+	},
+	{
+		.id = 0x81,
+		.name = "SG2042R evb",
+	},
+	{
+		.id = 0x83,
+		.name = "SG2042 evb x4",
+	},
+	{
+		.id = 0x90,
+		.name = "Milk-V Pioneer",
+	},
+};
+
+static const char *sg2042_mcu_reset_reason[8] = {
+	"Power supply overheat",
+	"Power supply failure",
+	"12V power supply failure",
+	"Reset commant",
+	"Unknown",
+	"Unknown",
+	"Unknown",
+	"SoC overheat",
+};
+
+static struct dentry *sgmcu_debugfs;
+
+static int sg2042_mcu_get_board_type(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
+}
+
+static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
+}
+
+static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
+}
+
+static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
+}
+
+static int sg2042_mcu_get_board_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
+}
+
+static int sg2042_mcu_get_reset_count(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
+}
+
+static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
+{
+	int ret;
+	u8 time_val[2];
+
+	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
+	if (ret < 0)
+		return ret;
+
+	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
+}
+
+static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
+}
+
+static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
+}
+
+static int sg2042_mcu_get_soc_crit_action(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
+}
+
+static int sg2042_mcu_get_soc_crit_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
+}
+
+static int sg2042_mcu_get_soc_hyst_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
+}
+
+static int sg2042_mcu_set_soc_crit_action(struct i2c_client *client,
+					  u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
+}
+
+static int sg2042_mcu_set_soc_crit_temp(struct i2c_client *client,
+					u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
+}
+
+static int sg2042_mcu_set_soc_hyst_temp(struct i2c_client *client,
+					u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
+}
+
+DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
+DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
+
+static ssize_t reset_reason_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret, val, i;
+
+	val = sg2042_mcu_get_reset_reason(mcu->client);
+	if (val < 0)
+		return val;
+
+	ret = sprintf(buf, "Reason: 0x%02x\n", val);
+
+	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
+		if (val & BIT(i))
+			ret += sprintf(buf + ret, "bit %d: %s\n", i,
+						  sg2042_mcu_reset_reason[i]);
+	}
+
+	return ret;
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
+	ret = sg2042_mcu_get_soc_crit_action(mcu->client);
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
+	return sg2042_mcu_set_soc_crit_action(mcu->client, value);
+}
+
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RW(critical_action);
+
+DEFINE_MCU_DEBUG_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
+DEFINE_MCU_DEBUG_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
+
+static int board_type_show(struct seq_file *seqf, void *unused)
+{
+	struct sg2042_mcu_data *mcu = seqf->private;
+
+	seq_printf(seqf, "%s\n", mcu->board_info->name ?: "Unknown");
+
+	return 0;
+}
+
+static int mcu_type_show(struct seq_file *seqf, void *unused)
+{
+	struct sg2042_mcu_data *mcu = seqf->private;
+	int ret;
+
+	ret = sg2042_mcu_get_mcu_type(mcu->client);
+	if (ret < 0)
+		return ret;
+
+	seq_puts(seqf, ret ? "GD32\n" : "STM32\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(firmware_version);
+DEFINE_SHOW_ATTRIBUTE(pcb_version);
+DEFINE_SHOW_ATTRIBUTE(mcu_type);
+DEFINE_SHOW_ATTRIBUTE(board_type);
+
+// TODO: to debugfs
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
+static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
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
+	long tmp;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		switch (channel) {
+		case 0:
+			tmp = sg2042_mcu_get_soc_temp(mcu->client);
+			if (tmp < 0)
+				return tmp;
+			*val = tmp * 1000;
+			break;
+		case 1:
+			tmp = sg2042_mcu_get_board_temp(mcu->client);
+			if (tmp < 0)
+				return tmp;
+			*val = tmp * 1000;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp_crit:
+		if (channel)
+			return -EOPNOTSUPP;
+
+		tmp = sg2042_mcu_get_soc_crit_temp(mcu->client);
+		if (tmp < 0)
+			return tmp;
+		*val = tmp * 1000;
+		break;
+	case hwmon_temp_crit_hyst:
+		if (channel)
+			return -EOPNOTSUPP;
+
+		tmp = sg2042_mcu_get_soc_hyst_temp(mcu->client);
+		if (tmp < 0)
+			return tmp;
+		*val = tmp * 1000;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int sg2042_mcu_read(struct device *dev,
+			   enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr != hwmon_chip_update_interval)
+			return -EOPNOTSUPP;
+		*val = 1000;
+		break;
+	case hwmon_temp:
+		return sg2042_mcu_read_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int sg2042_mcu_write(struct device *dev,
+			    enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 down_temp, repower_temp;
+	int ret;
+
+	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
+		return -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_temp_crit:
+		ret = sg2042_mcu_get_soc_hyst_temp(mcu->client);
+		if (ret < 0)
+			repower_temp = DEFAULT_REPOWER_TEMP;
+		else
+			repower_temp = ret;
+
+		down_temp = val / 1000;
+		if (down_temp < repower_temp)
+			return -EINVAL;
+
+		return sg2042_mcu_set_soc_crit_temp(mcu->client,
+						    (u8)(val / 1000));
+	case hwmon_temp_crit_hyst:
+		ret = sg2042_mcu_get_soc_crit_temp(mcu->client);
+		if (ret < 0)
+			return -ENODEV;
+
+		down_temp = ret;
+		repower_temp = val / 1000;
+		if (down_temp < repower_temp)
+			return -EINVAL;
+
+		return sg2042_mcu_set_soc_hyst_temp(mcu->client,
+						    (u8)(val / 1000));
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t sg2042_mcu_is_visible(const void *_data,
+				     enum hwmon_sensor_types type,
+				     u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_chip:
+		if (attr == hwmon_chip_update_interval)
+			return 0444;
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			if (channel < 2)
+				return 0444;
+			break;
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
+		_CREATE_DEBUG_ENTRY(firmware_version, 0444, mcu->debugfs, mcu);
+		_CREATE_DEBUG_ENTRY(pcb_version, 0444, mcu->debugfs, mcu);
+		_CREATE_DEBUG_ENTRY(mcu_type, 0444, mcu->debugfs, mcu);
+		_CREATE_DEBUG_ENTRY(board_type, 0444, mcu->debugfs, mcu);
+	}
+}
+
+static int sg2042_mcu_check_board(u8 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
+		if (sg2042_boards_data[i].id == id)
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int sg2042_mcu_i2c_probe(struct i2c_client *client)
+{
+	int ret;
+	struct device *dev = &client->dev;
+	struct sg2042_mcu_data *mcu;
+	struct device *hwmon_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+						I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -EIO;
+
+	ret = sg2042_mcu_get_board_type(client);
+	if (ret < 0)
+		return ret;
+
+	ret = sg2042_mcu_check_board(ret);
+	if (ret < 0)
+		return ret;
+
+	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mcu->client = client;
+	mcu->board_info = &sg2042_boards_data[ret];
+
+	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
+	if (ret < 0)
+		return ret;
+
+	i2c_set_clientdata(client, mcu);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 mcu,
+							 &sg2042_mcu_chip_info,
+							 NULL);
+
+	sg2042_mcu_debugfs_init(mcu, dev);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static void sg2042_mcu_i2c_remove(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+
+	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
+}
+
+static const struct i2c_device_id sg2042_mcu_id[] = {
+	{ "sg2042_hwmon_mcu", 0 },
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
+	},
+	.probe = sg2042_mcu_i2c_probe,
+	.remove = sg2042_mcu_i2c_remove,
+	.id_table = sg2042_mcu_id,
+};
+
+static int __init sg2042_mcu_init(void)
+{
+	sgmcu_debugfs = debugfs_create_dir("sgmcu", NULL);
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



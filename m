Return-Path: <linux-kernel+bounces-168863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1528BBF02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AEE0B21273
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCD17F6;
	Sun,  5 May 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kyF82xVN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2027.outbound.protection.outlook.com [40.92.41.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C412EBB;
	Sun,  5 May 2024 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714871925; cv=fail; b=hgHgA9YijCvn0LtL+U/W8nXFHq+pr+GayZAPraPGjDVgX5CLL/gE3cYJjM+by1DeR5NbEnFInmrtcI3rG5iINaqE/jKGGax/lLrq81O0KcwOo+mbRb+JDcWNYJ4mD4pVlSEQdt2bsHElmB4rHSuhC8M67r70wzV8BJbO7u72aJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714871925; c=relaxed/simple;
	bh=UOXD7oESxSDM9L1DddGNDAQDyzvfQKom5z72nGzYGEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nq5OiBbd0HxRKelAR/ziy/ACdsigOkRoyaoVkQeaQKJxPUj+ZlDDvsFebAiGJ3EPg3A7tDkLUaF3jPR1emEqVUMQn1hcyR5An5EXKfFOH7HP6YAM4MtE5Qz01xntAhv4atY7ytvhyUEOHCtKFj9AmoTYkzCMAR0GY/vJDPETOzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kyF82xVN; arc=fail smtp.client-ip=40.92.41.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8suHQ+8Al68HUMsTF8ndMjTp+cohatZJEjDiBirtxBsJieszjVpOOAt8ISpSYomTH0RFEmj9WvGb+yEG68fBIDyXEFqPI4lT8h92nE+w/XwDnhAjCEafEqPT2JibFXnH12eH+MGaTZ/aERmFvtqHrWfLiZ5knUfeG9sxHAQMUlg57eKQ4zOegNPQ7Dx+DT5QnHpjEPvp/kC/jfZsHB11vTrtN/Wrf+OkRpH34j7/l/NhJvPNPbiRSxNjeYW9m3vAJVtBTTtABCx8XNIhePBUJB3+wkyr/4v+uLSgJvaUTF5bSyJtcQC65JhLk4D9NpEckXAI/h/c8K5ebvEq2XZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfKGx+3F24RUPtNhntDfK/IPkKknFtR+bbfD4w60T6U=;
 b=E3+FbV8g7ThvnMPmbceLartE7ozUb+gojvgJpjXgioDK6rEQbE+PtNxSimCldbEbhUZ25tHgSppb4eYWda9qREi3PKEqqeCygDAHmLzLKBgbChCB5YTsrP0muDMzOjL/0O8+NCSM09ULY9NlB7xex4aOz6sIZVI0ZMoFQ68rrmBY+RUuvNF6pi9XpJME4S0/ORS8B0Hhd4C8yFwOmu/WVYVhuopJ7fesheB+cl3JTkRlFqRGHuPmna+qHEzasE8PjtZuy8nAhw+0ESfayefiG/1DhVrVkVLEDrUkb0efI7+LBvXkjvb9/fVzeaMTrGCrp/1KlF40Z+meHE+yTpG+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfKGx+3F24RUPtNhntDfK/IPkKknFtR+bbfD4w60T6U=;
 b=kyF82xVNo4I66TRoiAwl+9HGkpuTnvvyga1Ys6QryR70Y2dzKieLpMNA5939+FBgx2YIaPnVh4oqeX6MSmXPtCu1SLuilIIU3tDfRm4dSN+BnManQcD4GMs21vohJFJJmo1s5G3WbYauetBCHPgE7m+Wg0v/qEeGNq4h2GUI7sIpMy1I+Nk9fuYslieJ39NXPQq49Zi876KSbk9b9UOJfvLM/2N6quLiGbll/zuayUJ0Bl7j3E4i5GDzjuf0NUboOkulprmLfRe64XshfI/IlfLUhMmLuWaSm6ucS/woXPiVuG3l9MesUGh+7HkFfeI+BeF9LQBf4JShBbLUuqapog==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6964.namprd20.prod.outlook.com (2603:10b6:806:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 01:18:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 01:18:40 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/2] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Sun,  5 May 2024 09:18:53 +0800
Message-ID:
 <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4C3zlAEnkG6lC5Zz1d0hAP+1Xjo9lyWCaAmKqRzJiTQ=]
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240505011856.359216-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: e01e2763-7b04-4ade-5c80-08dc6ca14ab5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	rN+pKKxZx2wq9zHMqYfe3P9HDn3DC3CBOULH8O2cG6sMwaeiCg7Li8ZK2zGlmTsgt6vhSDtgckeoINAHD/cMFx+NCWqaztXH95oTvezNbjRxVdRYTc4o7ynP4gwbMJ/tVbicjgX7OCzxqCgLgz7Z9EFN7kdp616Jt+DK+FOcUtTKAG10W2dpraSLm2mtugrZLAo8UD7Vb79aizUs1VoxnO9P0CUqc3a8pI1oTCm3v5hV+BfPkg+WJk5/dl84h8RLm3ndrX4RPrp5/z6PGft5cbWOtGto2vjAoMup2kx8x3xi3R2DmlPIfenMovmh3tW/LUO5HAgV6pTbdkf1QvxbKUUm/8WcN1MTkPgXMXIZ2evDHwTkzBuQjoljUSDUfSj9ynFCLzmXTxDOpdCeOtmOgxiaubcGA4cmzlU6XDSoq4FUM+Jn0TOEX8gmhv3zLfL6yqCBRQz599VusDDyS1NPR5xhXHCceFhIwRnmCiFLMASCi2mBUHUzaWIoMH2Sw6LR50cNMa4ioJRNGtZTobwPxm8wsiVsEo+Pl5kiDR/TpK7RV0ot4lHHOBfqpchSGMMjSyw0gRJ2sIc07mISw0V69UIRNLosBsHqEai7b245U7LUx/M1lwEsWBNiNNvccrI3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWZzvW9lzQHwvTelPX8y9XJcnJKi0QuYfS0K/4S2l7GKJuGVtJt4QtxYy6qo?=
 =?us-ascii?Q?30ll+TiRJOjmm/t0D12o+wmRGSuFGAbJ3lyb/l64ggHHP166QhmorF62E9Hc?=
 =?us-ascii?Q?pz3CurAg6YHZs17PzR81J8R3w3glUzF/BlH5n4UwTCR5b+vYRE9xapfWI9g1?=
 =?us-ascii?Q?wDZ68jYxvZzr1k25eEy5mkkCIGkrlDof3s9gNbGtBRK5j/gEJZDASpp4rckb?=
 =?us-ascii?Q?WS61LydPyz8sJn2Qb1FYHRHWOXZ+F5qwaUG5PFaYagqMv4lGH4ehNtigzNBq?=
 =?us-ascii?Q?ir8Q/I397aMBV4Z9JkMcYtUr7ZKAjI48AkCbsHDWhi3AqaLIQtphKVJOrSIy?=
 =?us-ascii?Q?Lr5JQgZt7FBetx1sPFJb18b1A3cquzTn5TYY6TvXnzbniG4nZ3QZUS3WVFxE?=
 =?us-ascii?Q?TZgfxZ3N4TX1OOqk6RG3j8E6c6QDoZ2hYIfOe1F2o/nVUlrpOReSXI7XV39/?=
 =?us-ascii?Q?AZUYutKA6SMVnhMKcWkGeqS9cYTbid5lw/aRyoNO86zb4F5ow+ukDZ+Xgl54?=
 =?us-ascii?Q?qZAFTFXvUUL6FXtxT1aS10mqmGqsvdnEy/7oI2grx7gsxtO9yOyO9IFpt/+Z?=
 =?us-ascii?Q?xuDK0IWGvsUPos0Hu8zZ0MNW+Rpgo9NcjuMm5LyZSat4Joy33yvjesu/nnp0?=
 =?us-ascii?Q?VjkmugzOvDSTdnUwQl3foC4lbdh6uDNs6UbBMNRsy2znWbltysXayXbFNFI0?=
 =?us-ascii?Q?lPvuecl3e3PzfkFL4SX845cxTz3BZJv32kgioyJ3ER//LMMaD1t5oToZMm6f?=
 =?us-ascii?Q?n0c9ol3wlnEbkAT+sV4epAB/31VJIUwtAgjuhLgmV5OOQH1se78ZBbsbGj5H?=
 =?us-ascii?Q?f4odg2UabTIA+ElIHsaSRGhwt8RdV5epdP26VCsxEyIhvEjnmqqUhR08x2+S?=
 =?us-ascii?Q?+Jf+86UYGSI1BhbQjsYEdwDgVQL+UJZWw9Vn8+c0C0py/0V1TdouyFOEWP2T?=
 =?us-ascii?Q?Coea70pUpNFsWI4e5pVKxFeeHl8+RtwaF7WMMr1vTbtgo1XSc5dT9EcMMwF9?=
 =?us-ascii?Q?GOpxjsuODg80F4x1T+wI60U1NzkOgLQu2PKLwOxbils2r4Mb3sn8bTgtSCNi?=
 =?us-ascii?Q?gJe66KlgF9MvUOfBCCdMQbpsAhhvtR02bEWKqAj08RwGnN61VETdH/50neVS?=
 =?us-ascii?Q?el7NoBUdQpKoCeekTlRz6VzGZ6QRxA2BRpdEHoK1SJGKYOx8Q6u6mytSSWkt?=
 =?us-ascii?Q?C5/QnoTHhDD6h2e8vgjCyla12qyqmNWawRS9HlYj8sWymSfYfomgmtx2XeS7?=
 =?us-ascii?Q?pRjjEZAj7omE2p0rCR0f?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01e2763-7b04-4ade-5c80-08dc6ca14ab5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 01:18:40.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6964

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 drivers/hwmon/Kconfig            |  11 +
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++
 3 files changed, 543 insertions(+)
 create mode 100644 drivers/hwmon/sg2042-hwmon-mcu.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..3efaae91cacb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2056,6 +2056,17 @@ config SENSORS_SFCTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called sfctemp.

+config SENSORS_SG2042_HWMON_MCU
+	tristate "SG2042 onboard MCU support"
+	depends on I2C
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Support for SG2042 onboard MCU. This mcu provides power
+	  control and some basic information for SG2042 chip.
+
+	  This driver can be built as a module. If so, the module
+	  will be called sg2042-hwmon-mcu.
+
 config SENSORS_SURFACE_FAN
 	tristate "Surface Fan Driver"
 	depends on SURFACE_AGGREGATOR
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 5c31808f6378..7497b653a2c2 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
 obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
 obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
 obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
+obj-$(CONFIG_SENSORS_SG2042_HWMON_MCU) += sg2042-hwmon-mcu.o
 obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
diff --git a/drivers/hwmon/sg2042-hwmon-mcu.c b/drivers/hwmon/sg2042-hwmon-mcu.c
new file mode 100644
index 000000000000..91c4266333ed
--- /dev/null
+++ b/drivers/hwmon/sg2042-hwmon-mcu.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
+ *
+ * Sophgo power control mcu for SG2042
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/time.h>
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
+struct sg2042_mcu_board_data {
+	u8		id;
+	const char	*name;
+};
+
+struct sg2042_mcu_data {
+	struct i2c_client			*client;
+	const struct sg2042_mcu_board_data	*board_info;
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
+static int sg2042_mcu_get_critical_action(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
+}
+
+static int sg2042_mcu_get_critical_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
+}
+
+static int sg2042_mcu_get_repower_temp(struct i2c_client *client)
+{
+	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
+}
+
+static int sg2042_mcu_set_critical_action(struct i2c_client *client,
+					  u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
+}
+
+static int sg2042_mcu_set_critical_temp(struct i2c_client *client,
+					u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
+}
+
+static int sg2042_mcu_set_repower_temp(struct i2c_client *client,
+				       u8 value)
+{
+	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
+}
+
+static ssize_t board_type_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", mcu->board_info->name ?: "Unknown");
+}
+
+DEFINE_MCU_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
+DEFINE_MCU_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
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
+static ssize_t mcu_type_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = sg2042_mcu_get_mcu_type(mcu->client);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, ret ? "GD32\n" : "STM32\n");
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
+	ret = sg2042_mcu_get_critical_action(mcu->client);
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
+	return sg2042_mcu_set_critical_action(mcu->client, value);
+}
+
+DEFINE_MCU_ATTR_READ_FUNC(repower_temp, u32, "%u");
+
+static ssize_t repower_temp_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val == 0 || val > MAX_REPOWER_TEMP)
+		return -EINVAL;
+
+	return sg2042_mcu_set_repower_temp(mcu->client, val);
+}
+
+static DEVICE_ATTR_RO(board_type);
+static DEVICE_ATTR_RO(firmware_version);
+static DEVICE_ATTR_RO(pcb_version);
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RO(mcu_type);
+static DEVICE_ATTR_RW(critical_action);
+static DEVICE_ATTR_RW(repower_temp);
+
+static struct attribute *sg2042_mcu_attrs[] = {
+	&dev_attr_board_type.attr,
+	&dev_attr_firmware_version.attr,
+	&dev_attr_pcb_version.attr,
+	&dev_attr_reset_count.attr,
+	&dev_attr_uptime.attr,
+	&dev_attr_reset_reason.attr,
+	&dev_attr_mcu_type.attr,
+	&dev_attr_critical_action.attr,
+	&dev_attr_repower_temp.attr,
+	NULL
+};
+
+static const struct attribute_group sg2042_mcu_attr_group = {
+	.attrs	= sg2042_mcu_attrs,
+};
+
+static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT,
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
+		tmp = sg2042_mcu_get_critical_temp(mcu->client);
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
+	ret = sg2042_mcu_get_repower_temp(mcu->client);
+	if (ret < 0)
+		repower_temp = DEFAULT_REPOWER_TEMP;
+	else
+		repower_temp = ret;
+
+	down_temp = val / 1000;
+	if (down_temp < repower_temp)
+		return -EINVAL;
+
+	return sg2042_mcu_set_critical_temp(mcu->client, (u8)(val / 1000));
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
+	},
+	.probe = sg2042_mcu_i2c_probe,
+	.remove = sg2042_mcu_i2c_remove,
+	.id_table = sg2042_mcu_id,
+};
+
+module_i2c_driver(sg2042_mcu_driver);
+
+MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
+MODULE_LICENSE("GPL");
--
2.45.0



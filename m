Return-Path: <linux-kernel+bounces-290511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08629554DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980DF283F15
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378778821;
	Sat, 17 Aug 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jUo2/xtt"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2092.outbound.protection.outlook.com [40.92.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E43208DA;
	Sat, 17 Aug 2024 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861434; cv=fail; b=XMZTYw9HUwXQKWKo23Ir6dF9TRCTtdmfxHBc0qjVrtEXIG4Wv/GXGVx9tTzR32ZFLAJ10bTl+9x618mIYTm+2FbOhK84utD2CD6S/LnqU5/Whj8CL47lplpv+bmXz0aEah/DbJzSl4k1LfAkF4KbxdiXzRTQcjsbJyNKqyCreAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861434; c=relaxed/simple;
	bh=WaJw8AVhBmIQJdTa07HVhtcviX7NQPlx3V6P4mDfuPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAaIU4iydRyjpfNyEPQyn4qCodiZQ7SSezZp2E7MmzboO9cSWHi/yun+AEML4uA1RLtxxeWrb0dBwakPi+FEThQj2+KoCFVWmQeyzUi3r+VgUCiWGuXKBoo2UfJuUo1FFysoMmZgut6AM7JdH/zonpvV63ahvLVluOWuUgq9j5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jUo2/xtt; arc=fail smtp.client-ip=40.92.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucLOvFuL/t6nM1LWyvVR716LeZrXljuWx3H/VUikW8mQc8YSOksBgu9+R8Fjpao+vhNyJw0rP0b6EYG3mzrIpdKBq+4KPAMNgllZjs6+JipSppLG1SduetZfWQVlUkIxU6SaCg9SlFhezsgmWddhEN82viZoMOnmX+LfsURTphyGqTwEHerQLmhYdXPYPTHuScmpY3Hv7vE7zNMtEGmS0XZTYQE7eEBVzbl1Bt4VZCCyTpq4qtoL8TIs4m5D4itNlfeIfzg54qrOEdbywtXnz+l9jSf58P/lGxZ0g0A80jfPvGgk+H5/0TXSlyrgum86KmQIQKVYV0Nz3o6kyqeZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGDBqRcdABcxTb2Qdm8FfhMH1uLiPg8wYMsiJiuFA1M=;
 b=qLx4TZnO7KC9cV7VRvXqwr1q6U9cDTFuWXW2E5qtCBN/uc2GftpaCLfnZVZIPqVz2BGGSMP5QpcGsEUhKb33axOksF45WJHjddkn9ycVGh8xf1qmabHAh7ipVs8c50+HMokogeT+oNgXT/yefIbOnFnoqv3fGNrZcGQ50R66KnvJPrGmEfR+GsOLcF2g5YmMTSpNF1zL4MSOSGbH5YLlIvnNEnE0MlUf+FeEz+0vLmhiUWGhi15247Oefn3QTS/aQHJpCvFV7YQzUosiqmemUDeuVdMioqia6oOiVadR3uPUUb98s19b0rP0G+iczdnvDFj9v/+va66Ki0dil7GQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGDBqRcdABcxTb2Qdm8FfhMH1uLiPg8wYMsiJiuFA1M=;
 b=jUo2/xttE+laxrPOOESHjWrTIXo/3lYADc7Cw7gz8/Am4xgyo14rigpa/d11t8VXnxZjgZ4e5JogMW5hPuYt2Q0iR8eVTHCzos8lCTuFdhz8sZeElYwSCt67PaLaubP7cnb1OQj4rldqRZ9wZJcCc4+Y9eGTDArh0rnLEKNpRmmiXPd0Ly/cRRE2bng44TsSnb4xC16p6H0Ug5+0FbQtDyflAoYdldJTBx2PbNMNBEBGYe4gY8f2IHyxAXEsCJ+WiZxbb7x2m5+bwViqWn8ParLDRmEGSofF49o6TN/V663ybKy2RxxmhBbVqyfK1gdWfBzkq87imjzeaaX3zrUrcQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5337.namprd20.prod.outlook.com (2603:10b6:510:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 02:23:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 02:23:48 +0000
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
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 2/4] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Sat, 17 Aug 2024 10:22:57 +0800
Message-ID:
 <IA1PR20MB49536C786048D1E676BB9C20BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JaK5aj/3TFCDifrVLZUYgDGivP5qyyM0RjqnTsXSUXs=]
X-ClientProxiedBy: TYCP286CA0227.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240817022300.360949-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: cc796215-4c4a-49b8-3c7c-08dcbe63a09e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	wpFq4Z2oe/Mcs4nzHq8RBC3mUNtEzKdo8u7ZZZMzmDUfS68tQragjW7hmbtdPRMEC6MaCtCZzpPM8491galeBps54H/XBzZ65LYLW0qkDd+YLcRG/SoGAu8X7l/MF5gnIO5GoVYTyDJiKx3IY5cAtJOT8eSTYVBFODzM5o6MmQaWeD09y/QNKjeKt1lCqGZ1BdSTglkiD6rgc+dQXUDS/9iycWvxC3ku2DJEIaASzwM4kjOGjxKX7Xccut/oJqZ0lkBpUwp+yZZq2Syxu0VgocZNNNiWcV2C89OcEwX1iB7vy1dscKjOvHW3KznfupYQ8/ynk+H9VCJHcg0uQhjcxDyJQGl0z3CD3BbLUJt//XT1hlEa6m6gfjUZ9eKw0drdAEV5TM6vFBSfx45MeGg+8d0xJc8/YLi2qWU5magKg1cYwpuZXt8f2w3oJb+UheFWHyzxwGaShvylh2hZ2t2cqcrbu+/nBz7b3NSLWkGEAATGTPnet7Y/pDwCJYOr1lsdgAEvrUFrXhuEklRVPOduvna6O5xShZO+y773FX9eUSdd79scX47kyiSL3pETFmSIMa/rCOfb3/hR7Bgc2OVI3MaSISQ86ofI+Jg9eTB3kpmNOS6JjpKaBvyebGTG1rcw8PeNE1NG3nRBWdiy5K9ccUIQydxDEfEB8+pELDJLlafybw/OeEFz/XoOD6z3bO/sBcrgdHSVTAPZ6ge/Pw1v7aPiQDlfMaXyJtZBxHkKVBY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jgN/d1yQOr1tA7xSS5JUunxa6RDZ1hY4zCXj4T95dYN9HGONwXj3tW3hzdrz?=
 =?us-ascii?Q?DQYACZoAr044bESF2nIuPjLy/4WbzhvSJDJMKc6gAJxhMSKGTi5+ZfCvcAIg?=
 =?us-ascii?Q?2uiRuAqZvF0yqRU5hjYNkCKz2iWEht61BuiQJZLCwMrt4CAmtVFpa2AiSLSp?=
 =?us-ascii?Q?1DlGmgJymDoeADSFKdFjJ6J1FYWu5GkV+8Nc9JoZk310VwYM8h1Fwhp/PF5e?=
 =?us-ascii?Q?sU9ZjzwIQFnXW/9NkXNy1HpHUxNXyRVHUE53bDiXklFmtrRemlDH7CgRlmef?=
 =?us-ascii?Q?t+mTjoWJ+DTTCP69fjM6a00T39mErqn4NtdNekXpgoJX/0BJMtr7fBD/Z2H7?=
 =?us-ascii?Q?iNenDm6KOiu9/3H1YBtptnSukX5c54zsvYA0rj10LkejT1bdF/Evnam7yamP?=
 =?us-ascii?Q?pN/7GwGndPlFk6Z8lyPpoLbmjAEXexLh3V7ss/Eot4WlE4AxSqodFe+oo9Hh?=
 =?us-ascii?Q?AkKvZzYWIM+jnPKnEBE2ruSR6tnb9KP9VEuQKHUa2Z3JdjWzLX+kYRu6KfWu?=
 =?us-ascii?Q?qxO0MDDZiMLVLy/wOaDmBiUL9CGd+l4CKFufHG4tIaGOvhFHUODo2u5vQaS7?=
 =?us-ascii?Q?Yik8xAzYhoSG/mwxmMIuNILNzLo8L5BG6od575Y3/KzMAgTI8X7HF9jyLQRu?=
 =?us-ascii?Q?POsGTuIZnzgn6+mRc17XnsjlKHhhMyN/uIsl5DpjrX4+0GBsHecui24pzwBb?=
 =?us-ascii?Q?YDdk6F+Uy3t0sngXiD7ueQR3TmIVxUEXAcWWyI5jTyeCrvIO+OXdVHGERDQh?=
 =?us-ascii?Q?h6FXEI4YvhBRvd4aYN8/lmKL/SlKemXWt3YYS/lsnneMMW0jG9Wn54DfAgFW?=
 =?us-ascii?Q?I0NLMkJakTzRZPkff600IHz8xPZXsnUPuSUJOk0JCHVCFE7gyTQwGg0GN0YM?=
 =?us-ascii?Q?tfCuj91gUViSSeK/xHd0VR/ZjbnwD9wRfz05oiCxBvjGcz9w5b9olcpfSHy6?=
 =?us-ascii?Q?1byrmxwz3M/N0O5te9IBFCEfJWnixL7DZkn8EH9HHPE+tSdwi3qRySwqqoH8?=
 =?us-ascii?Q?PxQCNjAT/km3OPAjc9Or9y7rppeg3LxoCKdE4tJvQu0LTtMBxdQjAtJpejY4?=
 =?us-ascii?Q?HtqXGITu8JNozm0kSA/d8Za3hm7IBwtsL2MfJcrOXp5VYYbYUfCaiJ/hCB/8?=
 =?us-ascii?Q?0W2evvn0SjLHPYmbWHaOuMiFIflonuMT4ro5339L1AvYQsispZTuv1imbV2U?=
 =?us-ascii?Q?s0qbKCwj/8lM6su6/SqjbfKBQ7eLQXnRWC54M+x69uBl2G0Kxzx3EF5xPaG5?=
 =?us-ascii?Q?xQaz4o+OmzD6nXPMobj9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc796215-4c4a-49b8-3c7c-08dcbe63a09e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:23:48.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5337

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/sg2042-mcu.rst |  78 ++++++
 drivers/hwmon/Kconfig              |  11 +
 drivers/hwmon/Makefile             |   1 +
 drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
 5 files changed, 479 insertions(+)
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
index 000000000000..077e79841d2e
--- /dev/null
+++ b/Documentation/hwmon/sg2042-mcu.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver sg2042-mcu
+========================
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
+The following table shows the standard entries support by the driver:
+
+================= =====================================================
+Name              Description
+================= =====================================================
+temp1_input       Measured temperature of SoC
+temp1_crit        Critical high temperature
+temp1_crit_hyst   hysteresis temperature restore from Critical
+temp2_input       Measured temperature of the base board
+================= =====================================================
+
+The following table shows the extra entries support by the driver
+(the MCU device is in i2c subsystem):
+
+================= ======= =============================================
+Name              Perm    Description
+================= ======= =============================================
+reset_count       RO      Reset count of the SoC
+uptime            RO      Seconds after the MCU is powered
+reset_reason      RO      Reset reason for the last reset
+repower_policy    RW      Execution policy when triggering repower
+================= ======= =============================================
+
+``repower_policy``
+  The repower is triggered when the temperature of the SoC falls below
+  the hysteresis temperature after triggering a shutdown due to
+  reaching the critical temperature.
+  The valid values for this entry are "repower" and "keep". "keep" will
+  leave the SoC down when the triggering repower, and "repower" will
+  boot the SoC.
+
+Debugfs Interfaces
+------------------
+
+If debugfs is available, this driver exposes some hardware specific
+data in ``/sys/kernel/debug/sg2042-mcu/*/``.
+
+================= ======= =============================================
+Name              Format  Description
+================= ======= =============================================
+firmware_version  0x%02x  firmware version of the MCU
+pcb_version       0x%02x  version number of the base board
+board_type        0x%02x  identifiers for the base board
+mcu_type          %d      type of the MCU: 0 is STM32, 1 is GD32
+================= ======= =============================================
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
index 000000000000..141045769354
--- /dev/null
+++ b/drivers/hwmon/sg2042-mcu.c
@@ -0,0 +1,388 @@
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
+#define REG_REPOWER_POLICY			0x65
+#define REG_CRITICAL_TEMP			0x66
+#define REG_REPOWER_TEMP			0x67
+
+#define REPOWER_POLICY_REBOOT			1
+#define REPOWER_POLICY_KEEP_OFF			2
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
+		       (time_val[0]) | (time_val[1] << 8));
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
+static ssize_t repower_policy_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	int ret;
+	const char *action;
+
+	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_POLICY);
+	if (ret < 0)
+		return ret;
+
+	if (ret == REPOWER_POLICY_REBOOT)
+		action = "repower";
+	else if (ret == REPOWER_POLICY_KEEP_OFF)
+		action = "keep";
+	else
+		action = "unknown";
+
+	return sprintf(buf, "%s\n", action);
+}
+
+static ssize_t repower_policy_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
+	u8 value;
+	int ret;
+
+	if (sysfs_streq("repower", buf))
+		value = REPOWER_POLICY_REBOOT;
+	else if (sysfs_streq("keep", buf))
+		value = REPOWER_POLICY_KEEP_OFF;
+	else
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(mcu->client,
+					REG_REPOWER_POLICY, value);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(reset_count);
+static DEVICE_ATTR_RO(uptime);
+static DEVICE_ATTR_RO(reset_reason);
+static DEVICE_ATTR_RW(repower_policy);
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
+	&dev_attr_repower_policy.attr,
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
+	temp = clamp_val(temp, 0, MCU_POWER_MAX);
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
+				return 0644;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+			break;
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
+
+	debugfs_create_file("firmware_version", 0444, mcu->debugfs,
+			    mcu, &firmware_version_fops);
+	debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
+			    &pcb_version_fops);
+	debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
+			    &mcu_type_fops);
+	debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
+			    &board_type_fops);
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
+		return -ENODEV;
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
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
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



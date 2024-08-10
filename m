Return-Path: <linux-kernel+bounces-281789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1B94DB58
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3754B281364
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1214C583;
	Sat, 10 Aug 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z2/olUIc"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2012.outbound.protection.outlook.com [40.92.45.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314E14B950;
	Sat, 10 Aug 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277083; cv=fail; b=nh1RC+0iVMrOcoeQn5Llco7LuGG83uYvrj/bYEiKADKcNb/VsjCRFBBccMm/kWsi8/JF/fwFcwl+36KZSJmb8mcBIrKd1NLz4OuDBM3iPvQUmAgHP1yJ+hpZ2zFHsztXZa1AwHOLKIU2ysU1xkiY4G3AnDTLS1jb/B5xkYw5NsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277083; c=relaxed/simple;
	bh=57m44TR4qwVwgqWh036kdcXadjl6jhvy7yZX0A3Mpg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h++QG28fwWh1Uh6YSX7i2SqH5qTgjpkXr1rEJB+jTwBpA5sKz5LhmMv6e6r2jiR+MRyygNKU5BKv8y5FGrMhfaiGjxkaCJcihMYEqNUkESD2ZDUatTOQfD+TZRTsSD3SBHtwV3HUvM5ITwdlepM0kcV7Sem6UrOULoIFss9T98w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z2/olUIc; arc=fail smtp.client-ip=40.92.45.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiUorNKdYxr9P/DJ2hoQ72m8jJuZKetrCuEUP5xdTB9p0a92KsZb+cXVJvry84vIosDh5gQDVGsVoQUgo9HjVyl2WLJAMXSUQmP6385gwsKUx7I7NronTyLvf31jzZV4qdDBFLWCZYau7S/d762YVn4DU8Ia3G8a/7aWBskIgtxM9ocn0hA4lKjJGL9cwF7uRjm8JotsFBWMQdP4R9eJFNIK3I7X2d13++F0575UdN5gQ5bIwEzM1nwClUMsqXG54OMuZeki9ZCfAaSVKBZVAFqud9o2CxIbVhilZoyhKNWOQFXAJ1PJjg7jGRdnRWxo83WcgNF12B97DM4inyjlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUSLdN0Pz1lTnDkJF2bquwJKwZsoHrJIb1FukklMHcQ=;
 b=lv5+1SVBChjqGuxScE4Q0bdbzOuiyanHw1zFcR9FUOIJKUT6W+x2G+voS5G8cCrZh29lGEv3YhsQDApWMwflUDo6eVCo9QJORC84gbLbLSwCm66ti2GFlNbiJ840WTb+EXTFEayPXGLj5IZJEyb7IzeCQZ4f9KABZFVbGwL1GsKFKH/I3zoksMIeJDVq9AFt6wZoXwKoaFEVPSHDBsJ//ftCZRI6zsObu5LYpiWCozLFhleXb1NtJ3xCygia+co4w5jQY7boPlBp21J8PvYx6aFFJa2sfmUoEe/Ii+6x31SmIdyo5MUY5KalziNMPC7pDcYhMAZK63aI19GDWx9Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUSLdN0Pz1lTnDkJF2bquwJKwZsoHrJIb1FukklMHcQ=;
 b=Z2/olUIcmihbderi8zaI4ieJMEWD5KjqOGYGTyVsQinzpRnyj3ONnyjxYdoaL/mOPW/Ey5cLc69P7/2PC8jfVquxxaIUCURhk7GHxsu3mVxgVYzhANneAMPB2SqajYHWutqvpJ/XyufrvfSrWUFMWk2nOGffjZkC9uWRY43GNHw9UrgU+nXBT9dUIDnyYvK0vtnnidaZx+vOnwezeumGxJABq7gAQarQwCge6OS712P2RYUNhwwG0YKk7gJmpbWLlULrRoYX6DZO9zFQzFk5S6lpbXcYGxbAnMtIYC/yJZ2ueGuYISQFIliodQeCyHv2V0lVbMIpjSC1tsPJ8xJDXg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5117.namprd20.prod.outlook.com (2603:10b6:510:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Sat, 10 Aug
 2024 08:04:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:04:37 +0000
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 2/4] drivers: hwmon: sophgo: Add SG2042 external hardware monitor support
Date: Sat, 10 Aug 2024 16:03:51 +0800
Message-ID:
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [c4uYBFSAtPEV9nMJ+PCZ08w8RuMPoYEml1Q3LvIRw6s=]
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240810080354.387820-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5117:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2461f7-bcd9-42fe-f25e-08dcb9131406
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|15080799003|5072599009|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	GgyTAAQCkPplR3zle3uAuIXNXBnZI1t93lEj6sbbMZf1hHpua9NEuPWsEYPa1PRB1g0cJuIp4uTrsbcV3o8+yt/Dt5StUDaS3s2ZLFgxa8Y74RQ8u4bnjtV+hFZ56WT8BWUKCnMoT3/Y79s1rC9fsNspxDvO60fNp9Ny3+ajeZLF4XQmy4D9U/3Ji0JCpNJJdwTNS6eaChb1h7ypKVQCmmcgXZAy5s68htZHU0tlgyx4ee+/IAj0ubDkPwmCSFaKx5WYDf3GSocvoruNK2T3h8YIwb73i5dLOYRZV4u+fj5uFSMzG3dkXMRL9QOP8qEUDfQiJT9N51xQOA4XqC0RaO+q7JVL4sQDSFa9roMydaf7wqFFZtnfAhi19m6ambzojLKSZMyzIB7xsj76eQni6qD82jL3UTSlIq5pc6DnCQpwKfAutbXroqpbcO8ug5CpyEGTwbsgbCKeCAMCglWpOMiqxwQ8V3jTlWMdypxnzD9TneS9+AzR9mvJxUN4SA78iRU1vSngRlCb2og6N77aszzOzGblKReX7WjKyr7NJnpS66NkU9AHtrSUovhTQW7KrGRSGgxPLXX4elmgSBnFWhXbQ8HCTWt0YAgkTr6z+kWOYBEDCoiQDg+603xqksHezj+mMyBaE4HUugOOCZFzF4gK9Jmuddp8b4O8Jnn5m9a1dxvgKnmQMPPZq1KUShzPGNrg8RWQy4MljsUTyGye5/bs2kny8K78x9NRemd6HBY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GE4rCrtRejW4K17rZudF+7zU7ChAWSiuRc2y0Xpo1zuNULZ5788V+gLGxGjX?=
 =?us-ascii?Q?5xTqa/a0BIez1me3SCrSZEeNBessTeN+QwqsUaYZsuxCPnBm4v1Mj6RbMAL1?=
 =?us-ascii?Q?1zsi/AcLuBNQtCwm2dWjXCNM6wvzLgwhN+LBNUtI0+nIwah1ZKuHROU84KDD?=
 =?us-ascii?Q?2sUFPCQuQo0v6eGu7dUue01ac4BTils80c1aHGaE6KkNWdJGfZMCmtbzfR5F?=
 =?us-ascii?Q?YOpDpU4/3P+wnsKXEkI2hVyP7vINDSF6K5i69QutV9hC9VA3uEBW17SHSqZr?=
 =?us-ascii?Q?58XgnQ2f0MSvQTsB0ZXiteQgBMnoM23LXTmRvdQQ+KFVgDD/oQupPpIzFwRy?=
 =?us-ascii?Q?QaTct4mx61n8g5EOM3ob2e4tx3ntFkC1kZjlVWRs15HG1uPEC5VH8Pd3x+dB?=
 =?us-ascii?Q?0ORYfZgDSk9Bddi5UL4nEg7IsAMuNHY6tBp0FTjB0WKqhRNWgU/c7kWbrn17?=
 =?us-ascii?Q?qAnD98Nlffm8rY1lzC7ubTRI9gAedJGNgss4Cqs+mbL69dAKlccm2FmbYwDu?=
 =?us-ascii?Q?D5myx9gnCFAJHnxq1CeP+9chzKEwH+KW5dr1HKnVAku499ciMxyUGBEybdYU?=
 =?us-ascii?Q?PaKeSdTwqGoteYGGdMJQe4/hwuzY1FNQnQRokcgz6gHWceIZ9Ml8bSbhqJB4?=
 =?us-ascii?Q?6y0sknggz273x7W4VgnWhBd48MAt/l0sZGzslM5lQNaVylmiXpqdnDz7i3RU?=
 =?us-ascii?Q?o1+ttz0GgNyP2qz9Vx05XWrpEM3kijss1R1QBmh99AeE56sE7izvqflTjREr?=
 =?us-ascii?Q?vJia2dkp7Vr91lfV8OJtQsAI5XmZqYzsSn6au0jTHQgxVoXTZlLclBVFoovv?=
 =?us-ascii?Q?qnACV0FWn/nGbqTf2LCK3/ybxpTlUUsmQX9q7zB6j1l1/MsWb+b5kX/C89FU?=
 =?us-ascii?Q?5uqJv3meR7Ozsg+appysSzm27c23N0UnjbAutKgxWbgMZKBNi2Aw8NCYdqjE?=
 =?us-ascii?Q?FcFIZGsm0DqzCAEKUd4ToXZ6BLjJNc1QXwPK9MzQeZxJd8EOncBa4RFF0McU?=
 =?us-ascii?Q?M9quhjXItmpcgDoWe+lnBTz/gbFOVGmGyMATk8f/uHNZtgeL26s7aelVz8iO?=
 =?us-ascii?Q?7kgDAR+AeMG0i2l+gMg2WvhbRtZxNUiliryAPwn2FhJiXtmek38SZpXT8uuK?=
 =?us-ascii?Q?2/IR9qdASZeq33+9B+AOIYtFBwWHOcquk78K9WXlFIVtYtny5iCN0tMy1eiL?=
 =?us-ascii?Q?V2uZ7TIqpl+sl9JA/wNZ8Xc/fczvF0absptMGBpf/3bNIjl+C9FQ58/mI6pi?=
 =?us-ascii?Q?tIEUiZNzMdXpAAlPDh9O?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2461f7-bcd9-42fe-f25e-08dcb9131406
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 08:04:37.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5117

SG2042 use an external MCU to provide basic hardware information
and thermal sensors.

Add driver support for the onboard MCU of SG2042.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/hwmon/index.rst      |   1 +
 Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
 drivers/hwmon/Kconfig              |  11 +
 drivers/hwmon/Makefile             |   1 +
 drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
 5 files changed, 478 insertions(+)
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
index 000000000000..18a3578ac213
--- /dev/null
+++ b/Documentation/hwmon/sg2042-mcu.rst
@@ -0,0 +1,77 @@
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
+The following table shows the extra entries support by the platform:
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
+  The valid value for this entry is "repower" or "keep". "keep" will
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
index 000000000000..0a2e072511b6
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
+				return 0664;
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



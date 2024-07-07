Return-Path: <linux-kernel+bounces-243443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D792962F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D73B21301
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C61C3E;
	Sun,  7 Jul 2024 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rVUSOj+I"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2088.outbound.protection.outlook.com [40.92.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25117F7;
	Sun,  7 Jul 2024 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312341; cv=fail; b=UIl4BU/1TBIeBPTRTCtUWo+5zyzWDuWN/GgVoyGof08Jjqz0sVkKXSMF6hpZXJ2T9r7/8xrjlgqR9++6OSVS3D5QGaoO9vMeZdo9U1SMfBHmQVEJqsvFoaKBH3IDlv9qDDJrI7h9QdxLvdcjrS6ByLNYg4bl4k5Mft9jzmpEXi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312341; c=relaxed/simple;
	bh=07qmw2senkYwUwRWqL0NhFfpB33lMdUDnhZpNgMb/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BJuoVfDQHyfpyfos4IUxFU5HpPvxtiX1rwasDRuaZkhFy3TeLghAewHJVtgPl0KWQvaD2XaqweNaymmYUAEDLkWX1W3HF7O5aWeEYCkjH4IkWWcxSATzFVIYCA21H1/qZLBRvmQW+Ms12szi92Na7vOjk/V4ZkpEhhfiZpLW6Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rVUSOj+I; arc=fail smtp.client-ip=40.92.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgWiKvx41nTbxXkE/A2wse7DSSJun0G5Suha5RDyQZ97QksEv8ggK/C1Ftuw4s864ikWOloG7+7OJSXbsbnFVcihqhUZBEs1nXnCPtCvOS1HlENZTMZrXj1k3WuP3Kedh8s6Lpcv5XEB6uDLNna28m0+rp0OqP7opvHmbn3YH/5B0UnqG/lfpmtBC09Bnf67XsVW0KY3fHNPlw3J4EQUXu5WeYDZ7/p/QqEl+2qYtRSjpzhYTPpkvzDA1FH3Xu188VGpzY4Uo8OeOLEXVKqE/uBdH4aEDxFECgLz8HkyU130NYbjR+UuQaZf/ZQ/LogJ9ys0tGboJGFCV+kwuNsTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tBPKjx0iJ7BAwWT++pGH81dg8ZilWm4mD6nwG1T9a4=;
 b=bWXmActQMpjGSgie89N32RZzATXtNqhTgY2wYYCLhuO3XZU4T33I+b2y1xOZEuzGvX0E3Ij1bcqm8GBvMgG/U69Qj9ewefQZrZWGUukxA+/r0aZ/afj899S0ZnB681gXL1vE3ho+Nqvid057tF+hnYO176tpl68JCaq3gdYcAePR3rtqOYECdfzbvU9Nm37eouY6DAd4RQ910CZIQxqG0v99LOYdNPgFGniHEM/CmFC0NuiL8eGuttGA8ZwxonTD4o+yxwf8m61ErYBr3ScuRHagpdG/5FPil2F9yZ3ftsMWFfkWpJVZzG4K0XjGyQZzXOGp2OWntcKmzFUc2kb2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tBPKjx0iJ7BAwWT++pGH81dg8ZilWm4mD6nwG1T9a4=;
 b=rVUSOj+IOyuxbd8U75nsALqQnq/um5E4fHWATuRFrnexmKKJTvvNgsPa0u3X4bFo3YyRd6Z/SJWIpRsYmgSkK3dutq1XQMtGih0gjSj8CPb/S/V2Fc+1M+A+0c+hnutpTbSBTcuTBugtkb1MK8uqc7HxCVcFBpUpnCSEgI3/qQ3YczMXC5EzTMO/okTvvqEOdmrsrVAYbmbdQisQYFwMk9XP6knUexnyyOWA/phFiiyzGz5zN67o2mAI/m0QIpSGtHYof9es4J3/Dx6WaT82ZedPAF3hKSxV2OnO5Pdf1oxOJQ7mI6gll9ZpBXkj1Yb0mtBX2zGQPn3MU0zb4/jQwQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB6486.namprd20.prod.outlook.com (2603:10b6:8:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sun, 7 Jul
 2024 00:32:16 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.017; Sun, 7 Jul 2024
 00:32:16 +0000
Date: Sun, 7 Jul 2024 08:31:40 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953A4C47F52EBB2F200C50DBBD92@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <d2ecc9fd-93cf-4175-8074-b44c06b58313@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ecc9fd-93cf-4175-8074-b44c06b58313@roeck-us.net>
X-TMN: [+zYcRICeYRo0APrXZ5IPDeB5MxV31TYru0eHGFh2AUE=]
X-ClientProxiedBy: OS7PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:604:257::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ziwjoarehugstuhnobq6o275xyalfofmmugpcksc26xrrryha5@cs6wfrzhbaj3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB6486:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b44272-a29f-48d6-8ecd-08dc9e1c407a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	vAeWlLKcbxOlYmm7BCPdWz67TuXbaaSDKEQBALbZte+SLuKP/v8txXRb/l+A5pgXPm/6jq/yHC6M/BVtxY/kCONAaYKjaCIPhX+OubLA0iMSiv5Pd7j2LvdGcjZGJhqQ+8aWZljwY1oX5vBZpI0t8x03jUNHcAIGE+sS1xDT3HwPP6VsA68gv97pcqNOO6cfJFgo/RXRuGQO0qgfEH9wqoVoesD7DeuK311SWhxM+L23JTK8A2uT0mM5J4HFCl/B7N9J3N9C1k0nPjBfptrrxwfNN9QbluOSzSiF7kXL7PxOxkKU/3TCjPDH4f471eNMABSU8EAWITYuE9f5nDs2TXaVjOla/jCzznZ+WgImhHsYgwof0C5Ky3TDacQ6tveLSdiT0sv3GNHxSO2Cr6a1VtOAzw9V35xCVMNz3e/aoLN47xlto224dSh/k04PrvF49EY+ZHAzYhFnyNq1AxpI6sgjzR5/nhDj/P6O6Pegjb9VDfqakiHSyRO4Fwe/nujpK4h0ga+vvzJNpEdL5G7KLCTaFn8i8MAsdkOQO5hUzmpzwuM8gqDHYJ8mse0fbY3njUchVWaH+WsiUNS2slAUL74vmSO0Q9DaWc0xZUOa0pgG58Gbi+plFMQ45bC5ePehra6stlv6RzS9iigh0+fDtD7zIFmqsLdC46Uia2cJ94rNKyPuYMJxIy54Fm5GAFwp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uOx3g6sp9RHEyom+U5zlKxn4OZfPAdqqt5TpAdzbklxuNq1E8uTDcOhYZkQW?=
 =?us-ascii?Q?cCJQoB+y1EvSRWH5eyAR6XAKZRmH3AAw4qYXgaPpeEA2ZrN0lT3mJX4So91j?=
 =?us-ascii?Q?FBJZ8iif7Q/T3lD5gBzbbOBbf7BmGWq9aXjBoFryGXShzM4Bt4mnV0ce9kqn?=
 =?us-ascii?Q?dIu8Va06ZyUi7hshnd7epxGEzbQukNU4x7wgMOaaTVa8uURtv1P0s8rl1NZY?=
 =?us-ascii?Q?i9NCowB9tUCB5KGA3+K8y9d0wKUnNqMIrqfXGj23FbjYUscaKXxbiXrzmpZJ?=
 =?us-ascii?Q?kzJw+YvFFzRj82Jr9IjxY/vh2dHnMtogSpgNaCGNdMpjH+E/XHBDrLSMC59E?=
 =?us-ascii?Q?7sX9cXVnKzX66EQWgUiw8a4hQQbca2efvBrbXx/cKBDqx/llH/CbGVYKTaZU?=
 =?us-ascii?Q?rWZ//UHGyUZ+bC++kRQZy3IsVbibG1KBLS6I2pWYAZ1ucRD3z0lvRqvshiC8?=
 =?us-ascii?Q?JBfxb+oA1KqC00QrQOgR2w12nh0ncB3FLg/X2h+GsF+ZC+GWtU6pE+jXJz8V?=
 =?us-ascii?Q?lVUN3E2pJJ4y//LunLR06bHu67d75sHkg7eJTB1yr+hf/bK2bHdGpwMug5Sc?=
 =?us-ascii?Q?eYogqwQwIwijf/BbVnXax0SxW2vrshESdgjK39REPPyBO93QNeOAr67JrEGg?=
 =?us-ascii?Q?ddjx9Khx4bc03v1oqhvATtpj+D0rti6272Tz8RKW2/3r+PlmpwUDPw9jzrs6?=
 =?us-ascii?Q?8pH9qA61XWLo+I+seAizBlYgL6o165WEFDsunSQg4g+F5LIDHQ63fc+7krrI?=
 =?us-ascii?Q?d0rAPMHly25CXkmvw9Vq0k7RKKSlnHzmeUeuM+Y4puxWmqnQpjCqEUFcvyIF?=
 =?us-ascii?Q?mvhamryDFplvSfpyYeEiUHqEDaZiOxKgjBK7OCZ6665pGhaVN25xrefz8+gV?=
 =?us-ascii?Q?e95ygbLgV6cFeqrsS4I+hivFY5CYzDI7lQJGRAt+0/k8NNR0RQJq/B7qJdy8?=
 =?us-ascii?Q?hNj+xSMV5JR4fNEG8KoLTAgI3ZT+V0hhZo9/nYviMuUMD0pC6iIemj4yQc4i?=
 =?us-ascii?Q?E8DIK8aGwa8RCCM0tpcTvnpFETtmxaWHrvQOa2BqGOO3NQfRC0G/gZ6tU7Iw?=
 =?us-ascii?Q?RgEyns4p4EH6/FsrP282IhHrFDqPwbN6s7ifMzoI4Uttt9/eXAVnlT4dlmHb?=
 =?us-ascii?Q?2hN+Z9hV6Ts4q2pus7QkoKZEwEha84S2tGq09I02ZxOHVGtoy43tPcrA3Tz5?=
 =?us-ascii?Q?hVOYMdWgx/43xkSKLpJaJ9a/0PozafdQIh/3FHJ1BkrWxUpcHpht46JHkAvp?=
 =?us-ascii?Q?e6SO/ZZqU+G8oLF0LHrZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b44272-a29f-48d6-8ecd-08dc9e1c407a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 00:32:16.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6486

On Sat, Jul 06, 2024 at 07:52:47AM GMT, Guenter Roeck wrote:
> On 7/2/24 19:30, Inochi Amaoto wrote:
> > SG2042 use an external MCU to provide basic hardware information
> > and thermal sensors.
> > 
> > Add driver support for the onboard MCU of SG2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >   Documentation/hwmon/index.rst |   1 +
> >   Documentation/hwmon/sgmcu.rst |  44 +++
> >   drivers/hwmon/Kconfig         |  11 +
> >   drivers/hwmon/Makefile        |   1 +
> >   drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
> >   5 files changed, 642 insertions(+)
> >   create mode 100644 Documentation/hwmon/sgmcu.rst
> >   create mode 100644 drivers/hwmon/sgmcu.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 03d313af469a..189626b3a055 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
> >      sch5636
> >      scpi-hwmon
> >      sfctemp
> > +   sgmcu
> >      sht15
> >      sht21
> >      sht3x
> > diff --git a/Documentation/hwmon/sgmcu.rst b/Documentation/hwmon/sgmcu.rst
> > new file mode 100644
> > index 000000000000..5669dcfb2a33
> > --- /dev/null
> > +++ b/Documentation/hwmon/sgmcu.rst
> > @@ -0,0 +1,44 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver sgmcu
> > +=====================
> > +
> > +Supported chips:
> > +
> > +  * Onboard MCU for sg2042
> > +
> > +    Addresses scanned: -
> > +
> > +    Prefix: 'sgmcu'
> > +
> > +Authors:
> > +
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver supprts hardware monitoring for onboard MCU with
> > +PMBus interface.
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not auto-detect devices. You will have to instantiate
> > +the devices explicitly.
> > +Please see Documentation/i2c/instantiating-devices.rst for details.
> > +
> > +Platform data support
> > +---------------------
> > +
> > +The driver supports standard PMBus driver platform data.
> > +
> 
> It doesn't. Where does PMBus come into play ? Is this a cut-and-paste problem ?
> 

Yes, It should be smbus/i2c, I forgot to modify.

> > +Sysfs Attributes
> > +----------------
> > +
> > +================= =============================================
> > +temp1_input       Measured temperature of SoC
> > +temp1_crit        Critical high temperature
> > +temp1_crit_hyst   hysteresis temperature restore from Critical
> > +temp2_input       Measured temperature of the base board
> > +================= =============================================
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index e14ae18a973b..1100dd11f7f5 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -2079,6 +2079,17 @@ config SENSORS_SFCTEMP
> >   	  This driver can also be built as a module.  If so, the module
> >   	  will be called sfctemp.
> > 
> > +config SENSORS_SGMCU
> > +	tristate "Sophgo onboard MCU support"
> > +	depends on I2C
> > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > +	help
> > +	  Support for onboard MCU of Sophgo SoCs. This mcu provides power
> > +	  control and some basic information.
> > +
> > +	  This driver can be built as a module. If so, the module
> > +	  will be called sgmcu.
> > +
> >   config SENSORS_SURFACE_FAN
> >   	tristate "Surface Fan Driver"
> >   	depends on SURFACE_AGGREGATOR
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e3f25475d1f0..e9b78ff8338e 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -195,6 +195,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> >   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> >   obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> >   obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> > +obj-$(CONFIG_SENSORS_SGMCU)	+= sgmcu.o
> >   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
> >   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
> >   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> > diff --git a/drivers/hwmon/sgmcu.c b/drivers/hwmon/sgmcu.c
> > new file mode 100644
> > index 000000000000..d941d6fe741f
> > --- /dev/null
> > +++ b/drivers/hwmon/sgmcu.c
> > @@ -0,0 +1,585 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > + *
> > + * Sophgo power control mcu for SG2042
> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +
> Alphabetic include file order, please.
> 
> > +/* fixed MCU registers */
> > +#define REG_BOARD_TYPE				0x00
> > +#define REG_MCU_FIRMWARE_VERSION		0x01
> > +#define REG_PCB_VERSION				0x02
> > +#define REG_PWR_CTRL				0x03
> > +#define REG_SOC_TEMP				0x04
> > +#define REG_BOARD_TEMP				0x05
> > +#define REG_RST_COUNT				0x0a
> > +#define REG_UPTIME				0x0b
> > +#define REG_RESET_REASON			0x0d
> > +#define REG_MCU_TYPE				0x18
> > +#define REG_CRITICAL_ACTIONS			0x65
> > +#define REG_CRITICAL_TEMP			0x66
> > +#define REG_REPOWER_TEMP			0x67
> > +
> > +#define CRITICAL_ACTION_REBOOT			0x1
> > +#define CRITICAL_ACTION_POWEROFF		0x2
> > +
> 
> Please use BIT() for bit masks.
> 
> > +#define DEFAULT_REPOWER_TEMP			60
> > +#define MAX_REPOWER_TEMP			100
> > +
> > +#define sg2042_mcu_read_byte(client, reg)			\
> > +	i2c_smbus_read_byte_data(client, reg)
> > +#define sg2042_mcu_write_byte(client, reg, value)		\
> > +	i2c_smbus_write_byte_data(client, reg, value)
> > +#define sg2042_mcu_read_block(client, reg, array)		\
> > +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> > +
> 
> Pointless defines. See below.
> 
> > +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> > +	static ssize_t _name##_show(struct device *dev,			\
> > +				    struct device_attribute *attr,	\
> > +				    char *buf)				\
> > +	{								\
> > +		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
> > +		_type ret;						\
> > +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +		return sprintf(buf, _format "\n", ret);			\
> > +	}
> > +
> > +#define DEFINE_MCU_DEBUG_ATTR_READ_FUNC(_name, _type, _format)		\
> > +	static int _name##_show(struct seq_file *seqf,			\
> > +				    void *unused)			\
> > +	{								\
> > +		struct sg2042_mcu_data *mcu = seqf->private;		\
> > +		_type ret;						\
> > +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +		seq_printf(seqf, _format "\n", ret);			\
> > +		return 0;						\
> > +	}
> > +
> > +#define _CREATE_DEBUG_ENTRY(name, perm, d, data)			\
> > +	debugfs_create_file(#name, perm, d, data, &name##_fops)
> > +
> 
> Pointless define. Please do not replace API function names with your own;
> that just makes it harder to find callers.
> 
> > +struct sg2042_mcu_board_data {
> > +	u8		id;
> > +	const char	*name;
> > +};
> > +
> > +struct sg2042_mcu_data {
> > +	struct i2c_client			*client;
> > +	const struct sg2042_mcu_board_data	*board_info;
> > +	struct dentry				*debugfs;
> > +};
> > +
> > +static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> > +	{
> > +		.id = 0x80,
> > +		.name = "SG2042 evb x8",
> > +	},
> > +	{
> > +		.id = 0x81,
> > +		.name = "SG2042R evb",
> > +	},
> > +	{
> > +		.id = 0x83,
> > +		.name = "SG2042 evb x4",
> > +	},
> > +	{
> > +		.id = 0x90,
> > +		.name = "Milk-V Pioneer",
> > +	},
> > +};
> > +
> > +static const char *sg2042_mcu_reset_reason[8] = {
> > +	"Power supply overheat",
> > +	"Power supply failure",
> > +	"12V power supply failure",
> > +	"Reset commant",
> 
> command
> 
> > +	"Unknown",
> > +	"Unknown",
> > +	"Unknown",
> > +	"SoC overheat",
> > +};
> > +
> > +static struct dentry *sgmcu_debugfs;
> > +
> > +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> > +}
> > +
> > +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> > +}
> > +
> > +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> > +}
> > +
> > +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> > +}
> > +
> 
> Those one-line functions are just as pointless.
> 	i2c_smbus_read_byte_data(client, REG_RST_COUNT);
> does exactly the same without extra function and define.
> 
> > +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> > +{
> > +	int ret;
> > +	u8 time_val[2];
> > +
> > +	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> > +}
> > +
> 
> This is the only one of those functions which adds at least some value.
> 
> > +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> > +}
> > +
> > +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> > +}
> > +
> > +static int sg2042_mcu_get_soc_crit_action(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> > +}
> > +
> > +static int sg2042_mcu_get_soc_crit_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_get_soc_hyst_temp(struct i2c_client *client)
> > +{
> > +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> > +}
> > +
> > +static int sg2042_mcu_set_soc_crit_action(struct i2c_client *client,
> > +					  u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> > +}
> > +
> > +static int sg2042_mcu_set_soc_crit_temp(struct i2c_client *client,
> > +					u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> > +}
> > +
> > +static int sg2042_mcu_set_soc_hyst_temp(struct i2c_client *client,
> > +					u8 value)
> > +{
> > +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> > +}
> > +
> > +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> > +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> > +
> > +static ssize_t reset_reason_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret, val, i;
> > +
> > +	val = sg2042_mcu_get_reset_reason(mcu->client);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	ret = sprintf(buf, "Reason: 0x%02x\n", val);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> > +		if (val & BIT(i))
> > +			ret += sprintf(buf + ret, "bit %d: %s\n", i,
> > +						  sg2042_mcu_reset_reason[i]);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> This violates sysfs standards (one word only). If you want that level of detail,
> add it to debugfs.
> 

I think it would be better to change name and leave it in the sysfs.
If a suitable world is not found, I will move it to debugfs.

> > +
> > +static ssize_t critical_action_show(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +	const char *action;
> > +
> > +	ret = sg2042_mcu_get_soc_crit_action(mcu->client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ret == CRITICAL_ACTION_REBOOT)
> > +		action = "reboot";
> > +	else if (ret == CRITICAL_ACTION_POWEROFF)
> > +		action = "poweroff";
> > +	else
> > +		action = "unknown";
> > +
> > +	return sprintf(buf, "%s\n", action);
> > +}
> > +
> > +static ssize_t critical_action_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t count)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int value;
> > +
> > +	if (sysfs_streq("reboot", buf))
> > +		value = CRITICAL_ACTION_REBOOT;
> > +	else if (sysfs_streq("poweroff", buf))
> > +		value = CRITICAL_ACTION_POWEROFF;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return sg2042_mcu_set_soc_crit_action(mcu->client, value);
> > +}
> > +
> > +static DEVICE_ATTR_RO(reset_count);
> > +static DEVICE_ATTR_RO(uptime);
> > +static DEVICE_ATTR_RO(reset_reason);
> > +static DEVICE_ATTR_RW(critical_action);
> > +
> > +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> > +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> > +
> > +static int board_type_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct sg2042_mcu_data *mcu = seqf->private;
> > +
> > +	seq_printf(seqf, "%s\n", mcu->board_info->name ?: "Unknown");
> > +
> > +	return 0;
> > +}
> > +
> > +static int mcu_type_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct sg2042_mcu_data *mcu = seqf->private;
> > +	int ret;
> > +
> > +	ret = sg2042_mcu_get_mcu_type(mcu->client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	seq_puts(seqf, ret ? "GD32\n" : "STM32\n");
> > +
> > +	return 0;
> > +}
> > +
> > +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> > +DEFINE_SHOW_ATTRIBUTE(pcb_version);
> > +DEFINE_SHOW_ATTRIBUTE(mcu_type);
> > +DEFINE_SHOW_ATTRIBUTE(board_type);
> > +
> > +// TODO: to debugfs
> > +
> 
> If there is a TODO left, move the driver to drivers/staging/
> and keep it there until it is complete.
> 

My fault, it is already finished and can be removed.

> > +static struct attribute *sg2042_mcu_attrs[] = {
> > +	&dev_attr_reset_count.attr,
> > +	&dev_attr_uptime.attr,
> > +	&dev_attr_reset_reason.attr,
> > +	&dev_attr_critical_action.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group sg2042_mcu_attr_group = {
> > +	.attrs	= sg2042_mcu_attrs,
> > +};
> > +
> > +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> > +					HWMON_T_CRIT_HYST,
> > +				 HWMON_T_INPUT),
> > +	NULL
> > +};
> > +
> > +static int sg2042_mcu_read_temp(struct device *dev,
> > +				u32 attr, int channel,
> > +				long *val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	long tmp;
> 
> Why long ?
> 

just use to calculate the value.

> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		switch (channel) {
> > +		case 0:
> > +			tmp = sg2042_mcu_get_soc_temp(mcu->client);
> > +			if (tmp < 0)
> > +				return tmp;
> > +			*val = tmp * 1000;
> > +			break;
> > +		case 1:
> > +			tmp = sg2042_mcu_get_board_temp(mcu->client);
> > +			if (tmp < 0)
> > +				return tmp;
> > +			*val = tmp * 1000;
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> 
> This would be much simpler written with something like
> 		tmp = i2c_smbus_read_byte_data(client, channel ? REG_SOC_TEMP : REG_BOARD_TEMP);
> or even
> 		reg = channel ? REG_SOC_TEMP : REG_BOARD_TEMP;
> followed by unified read handling below.
> 

You are right, thanks.

> > +		break;
> > +	case hwmon_temp_crit:
> > +		if (channel)
> > +			return -EOPNOTSUPP;
> > +
> 
> Those checks are unnecessary if the is_visible() function
> does its job. If it doesn't, it is broken and needs to be fixed.
> Returning -EOPNOTSUPP is ok for default: cases, because _something_
> needs to be done, but not as result of extra and unnecessary checks
> like this one.
> 

Thanks for this explanation. I will change it.

> > +		tmp = sg2042_mcu_get_soc_crit_temp(mcu->client);
> > +		if (tmp < 0)
> > +			return tmp;
> > +		*val = tmp * 1000;
> > +		break;
> > +	case hwmon_temp_crit_hyst:
> > +		if (channel)
> > +			return -EOPNOTSUPP;
> > +
> > +		tmp = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> > +		if (tmp < 0)
> > +			return tmp;
> > +		*val = tmp * 1000;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> 
> There is a lot of repetition here. Setting the register in the switch statement, followed
> by
> 	tmp = i2c_smbus_read_byte_data(client, reg);
> 	if (tmp < 0)
> 		return tmp;
> 	*val = tmp * 1000;
> would be much simpler.
> 
> 
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_read(struct device *dev,
> > +			   enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, long *val)
> > +{
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		if (attr != hwmon_chip_update_interval)
> > +			return -EOPNOTSUPP;
> > +		*val = 1000;
> > +		break;
> 
> Pointless attribute. Attributes are only valuable if 1) used and
> 2) written into the chip. This one isn't used for anything.
> 

OK. I will remove this.

> > +	case hwmon_temp:
> > +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_write(struct device *dev,
> > +			    enum hwmon_sensor_types type,
> > +			    u32 attr, int channel, long val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	u8 down_temp, repower_temp;
> > +	int ret;
> > +
> > +	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
> > +		return -EOPNOTSUPP;
> > +
> Pointless check if the is_visible() function does its job.
> 
> Also, this is inconsistent: It only accepts writes if channel > 0,
> but the is_visible code only makes the attributes available for
> channel 0. On top of that, how does this expession ever allow writing
> hwmon_temp_crit_hyst ?
> 
> Either I am missing something, or you did not test this code.
> 

This is my fault. Only channel 0 can be writed.

> > +	switch (attr) {
> > +	case hwmon_temp_crit:
> > +		ret = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> > +		if (ret < 0)
> > +			repower_temp = DEFAULT_REPOWER_TEMP;
> 
> Why is this not an error ? If some of the supported boards
> don't support it, the value should not be read in the first place,
> and the hyst attribute should not be there.
> 

At least for now, all the chip this driver support can get
hyst_temp. So with your advice, I will issue an error.

> > +		else
> > +			repower_temp = ret;
> > +
> > +		down_temp = val / 1000;
> 
> val needs to be range checked.
> 
> > +		if (down_temp < repower_temp)
> > +			return -EINVAL;
> > +
> > +		return sg2042_mcu_set_soc_crit_temp(mcu->client,
> > +						    (u8)(val / 1000));
> 
> A read followed by a write needs to be mutex protected because the other value
> could be changed at the same time from another process. I am not sure if those
> checks are valuable or even make sense, but if you want that compexity you'll
> have to add mutex protection.
> 

Thanks, this is what I forgot.

> Also, what is the point of recalculating down_temp ?
> 

After some real test, I found the sg2042 can not handle the case
when "down_temp < repower_temp", it will keep closing. To avoid
this, I added this check. This is the same for the repower_temp.

> > +	case hwmon_temp_crit_hyst:
> > +		ret = sg2042_mcu_get_soc_crit_temp(mcu->client);
> > +		if (ret < 0)
> > +			return -ENODEV;
> > +
> 
> Do not overwrite error codes. If the attribute does not exist for some of the
> boards, it should not be created in the first place, and no attempt should be
> made to read it.
> 
> > +		down_temp = ret;
> > +		repower_temp = val / 1000;
> 
> val needs to be range checked.
> 
> > +		if (down_temp < repower_temp)
> > +			return -EINVAL;
> > +
> > +		return sg2042_mcu_set_soc_hyst_temp(mcu->client,
> > +						    (u8)(val / 1000));
> 
> What is the point of recalculating repower_temp ?
> 
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > +				     enum hwmon_sensor_types type,
> > +				     u32 attr, int channel)
> > +{
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		if (attr == hwmon_chip_update_interval)
> > +			return 0444;
> > +		break;
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			if (channel < 2)
> > +				return 0444;
> 
> channel is always < 2.
> 
> > +			break;
> > +		case hwmon_temp_crit:
> > +		case hwmon_temp_crit_hyst:
> > +			if (channel == 0)
> > +				return 0664;
> > +			break;
> > +		default:
> > +			return 0;
> > +		}
> > +		break;
> > +	default:
> > +		return 0;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops sg2042_mcu_ops = {
> > +	.is_visible = sg2042_mcu_is_visible,
> > +	.read = sg2042_mcu_read,
> > +	.write = sg2042_mcu_write,
> > +};
> > +
> > +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> > +	.ops = &sg2042_mcu_ops,
> > +	.info = sg2042_mcu_info,
> > +};
> > +
> > +static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
> > +				    struct device *dev)
> > +{
> > +	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
> > +	if (mcu->debugfs) {
> > +		_CREATE_DEBUG_ENTRY(firmware_version, 0444, mcu->debugfs, mcu);
> > +		_CREATE_DEBUG_ENTRY(pcb_version, 0444, mcu->debugfs, mcu);
> > +		_CREATE_DEBUG_ENTRY(mcu_type, 0444, mcu->debugfs, mcu);
> > +		_CREATE_DEBUG_ENTRY(board_type, 0444, mcu->debugfs, mcu);
> > +	}
> > +}
> > +
> > +static int sg2042_mcu_check_board(u8 id)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> > +		if (sg2042_boards_data[i].id == id)
> > +			return i;
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +
> > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > +{
> > +	int ret;
> > +	struct device *dev = &client->dev;
> > +	struct sg2042_mcu_data *mcu;
> > +	struct device *hwmon_dev;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > +		return -EIO;
> > +
> > +	ret = sg2042_mcu_get_board_type(client);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = sg2042_mcu_check_board(ret);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > +	if (!mcu)
> > +		return -ENOMEM;
> > +
> > +	mcu->client = client;
> > +	mcu->board_info = &sg2042_boards_data[ret];
> > +
> > +	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> Why not use .dev_groups provided by struct device_driver ?
> 
> > +	i2c_set_clientdata(client, mcu);
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > +							 mcu,
> > +							 &sg2042_mcu_chip_info,
> > +							 NULL);
> > +
> > +	sg2042_mcu_debugfs_init(mcu, dev);
> > +
> 
> This leaves the debugfs files orphan if the device (not the driver) is removed.
> Also, it is still created even if devm_hwmon_device_register_with_info() returned
> an error.
> 

OK, I forgot this condition, I will add necessary check, thanks.

> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +
> > +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> > +}
> > +
> > +static const struct i2c_device_id sg2042_mcu_id[] = {
> > +	{ "sg2042_hwmon_mcu", 0 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > +
> > +static const struct of_device_id sg2042_mcu_of_id[] = {
> > +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> 
> Based on sg2042_boards_data, this seems wrong. Devicetree data should distinguish the supported
> boards. That is its whole point. The same is true for sg2042_mcu_id; there should be separate
> entries for each of the supported boards.
> 
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > +
> > +static struct i2c_driver sg2042_mcu_driver = {
> > +	.driver = {
> > +		.name = "sg2042-mcu",
> > +		.of_match_table = sg2042_mcu_of_id,
> > +	},
> > +	.probe = sg2042_mcu_i2c_probe,
> > +	.remove = sg2042_mcu_i2c_remove,
> > +	.id_table = sg2042_mcu_id,
> > +};
> > +
> > +static int __init sg2042_mcu_init(void)
> > +{
> > +	sgmcu_debugfs = debugfs_create_dir("sgmcu", NULL);
> > +	return i2c_add_driver(&sg2042_mcu_driver);
> > +}
> > +
> > +static void __exit sg2042_mcu_exit(void)
> > +{
> > +	debugfs_remove_recursive(sgmcu_debugfs);
> > +	i2c_del_driver(&sg2042_mcu_driver);
> > +}
> > +
> > +module_init(sg2042_mcu_init);
> > +module_exit(sg2042_mcu_exit);
> > +
> > +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> > +MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.45.2
> > 
> > 
> 


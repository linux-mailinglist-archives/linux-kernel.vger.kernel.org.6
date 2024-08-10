Return-Path: <linux-kernel+bounces-281778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDA94DB38
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A0E1F211C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E014AD17;
	Sat, 10 Aug 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mhpkTQc6"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2049.outbound.protection.outlook.com [40.92.23.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB191487BE;
	Sat, 10 Aug 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723274611; cv=fail; b=Tqlhf6E6MVrwWym8DRwknvaeCfJ7PUzCZG2ljIThbcA8RlK/88SedVW8Nu3kfh5uvrlurhkj7VkUMJ6wprFlB9CC9Q1dRw0TcdTGzIDb2I9VEKnumfT4ay+GxRTKdo6RmAfg357BVHPZ9JbvBPbF58yVe/cW/nYC7llnIaop39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723274611; c=relaxed/simple;
	bh=iLq4XjgZrHAlyMVDUlvNscM6wabQowyb7KpAJ5my/tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pJmcw+3oDcCQUSSBY01cYIeE/0wIyhXFQvRmMeeqQ4M3vCgsMBvcrwmG7L8ERVdda3Y3ejC+dQCoKoUpg0wXYafo/dF30KxFQlOqptK9NlXeulu5Ih0hUlT1HMFJxArfaX7Ailm3pmane/fbk6B5L32CHykpQZ0mMKNWJk4lVSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mhpkTQc6; arc=fail smtp.client-ip=40.92.23.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QylvjV+lRUWlecPCgR4GPNilyxKTTTNL16ggaGaMBz5uMJP8gw7tCFZw7HKg4ZB6eW77/v2Jcyb/XIUYmMpF+pOEPeLVmj2gCuvSbQCpsTNqL5qvpPLxDrBwFcDZZ8O90dViCg5qe8CjCmxSq+cWNbUeptINBKRqqqEyE65DqSEIpMJim3uKqxsMM0nIddsQfKSCHvkWFBb9ukiR2SWqadPLacSDgFGmKkAR2rhl8c25oHdqa8YYHvl7zMytwtdC3Gsc0r7rK6R9PlEESL1WXQ0A1tja45lzAYAN0hVjxQY+frLFrL2gnNLOybjvhKcx5k6YG6ADOGtMHn2TQ3DmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHqXPXCZQ63SybLg4IunguvOhnh5gyFGvndKBsx8YIo=;
 b=RxgFyEhPxUixBGfiiC8JdGtAIIESJnLVMKmgVkSewEUJBVyozyWYlvudWe0ahrBV3QCgWetUFVstxeNhO/qN+xWYLf63ftlVYqmgRxtN3jI5z4YxdXath4haJ/3w4iuJm1eFa55/OaWSeQvv4QHB0m1HXnID72eurb8IRtPz2jI2secRVZv3eaRiOSZRArv9fKjSkB2coax7GOAY7zkH254tjwNHgqoPpUlryXTiGFXtd2is9ULrKq5p3DglglwcfAXYC+IspPNJQ2MS/lOrEfPs0fKkYz+S1gY4nD/uZqkgz4hnGKiaAbw3sX9F1HpyGYssS4x8hnysy8Ui8t3MMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHqXPXCZQ63SybLg4IunguvOhnh5gyFGvndKBsx8YIo=;
 b=mhpkTQc6pqiLHvErddCiD3u2N5aupod5EDwDMh0hcBkhNamMTvGfSQdXUJFa22vMzlBft3uU7iey/bRxU2CU00LhjkaCaq3xTqGqZwPaTbr4DhFyFQEnueNYF4XUxIs+hSFGcC42OKWsvMhP0EnsckugKMyRbVdW+O8KMSdc0F/W7aqMolQNgrzTZdfsQ0FTaZSOmuS9Omdc0qll3goqwshncOiu2QBgJq/HUJOTRIKa+QbM2+BAHPRxju0dI642T05MS0HAcabVDzoxSf9ioI+jc++KrfstA49WHe7knUGp2trZ9vVL8ZWReH9LujjQkGNgeMDEUwFxIu/ancr94A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB7133.namprd20.prod.outlook.com (2603:10b6:a03:577::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Sat, 10 Aug
 2024 07:23:24 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 07:23:24 +0000
Date: Sat, 10 Aug 2024 15:22:42 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Chao Wei <chao.wei@sophgo.com>, Jinyu Tang <tangjinyu@tinylab.org>, 
	Hal Feng <hal.feng@starfivetech.com>, Yangyu Chen <cyy@cyyself.name>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB49533C4D8296FA2E9B386CEBBBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953032E1B5D58D2F6C7393DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822B30C0665F36B08C8611BFEBE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822B30C0665F36B08C8611BFEBE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [kG7/Wb+Z8K545rLASa+AAXKB4lmFZJLR309MJ/EGNTg=]
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <h32jdmutgxabk72okta3bdn2tgjvt5g6dp5ky3rxvuqkxdt2nv@quvcbjp5mdbe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a9f6a1-01a1-4b57-94be-08dcb90d51f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799003|5072599009|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	CukdaCtBonW594/VfZWo85J0aTq8wyNJ2Aj/0z8DtWsQYke7vqRCesJmNbrCmSrUn7nQVZ9FIkcS4f+1b/Vx3Kr1fqRzJFYtetxbnCxD1eNzJUyjFWwhWI+SoH1Q+CIMwiJTdTN7m78IJR0WaRcop/IocKPlCn+9MgCQGEG872ZF0zawsXmONUgUNeTOWSTG4msXg2+0+GcqBDGBSrFxnFJW7rS16Uid7kz9enDZ96lnY91KaNevLPX4TU/J3S3k8T0gJys0WD6pCO+Ie/RhgEh3Evwr4QWlxVvIfewFVdemn9Ic/UtoV5k7z5iPqOiUTUi6M7uzgfnuCz8DvlfBP3w8ZgQ1jbK4oCc/MtR0RjpiueBAALIwQ3JZuNBfw1EOC9Eh5hTKld4yhvtgjCEsIwGfHogZSFSRKBvDbc/ftvPd2CUfrowfVKUJGNbLavTdprAiASUDicxUnoVLVfYMbTV9bCQMvnEvmYaKPXRnobK9fGfDe72mXtg+Uwuueerm0wmphaJCkrOnQOguU1n1Vtsedj8EIWo9wTSgVtTh/z0w47Ph3xOJ6jThNmgXhoIcTsFz8kvx1ZKeA9p59sI8k8nbs8LhQaA5fsuSltGuAOMuCo97dio5emz70nM3J5iPmZqrLwjdyuTUUYiGt2ij4dTBUkyH/551c0dRl1k00MQWOqq1q2d9j8sqytaglitrdrx3oP2YqGrRudO+s+x6ukdp3tR+aO1hVgi7JPO9wIs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BJpGGFhde7j6eFm8YvlEdDb56oGWdWC72mL0iH2wdThVw9imyW+aeaZdFUqR?=
 =?us-ascii?Q?K0zOXry2ndKkeUTkJx1SPmEQy4aHBmu3doMzB25J2xdyPZueY/2Uef9fJk+h?=
 =?us-ascii?Q?yiA3kZHG8e9wM8DiuSmQu3oGg5UN6SWLoKHsGLDZPQgfAsW9rk8TJwm8VJTQ?=
 =?us-ascii?Q?lAv65x9Us0ZNiYVzSzKKVTNlZCzX8AxeX1lwTVKEp//w6uk50IiSRV8dmxyi?=
 =?us-ascii?Q?+gfZiXcv9QS2Wv5kgjmTqFRo53u6jF3diAsMHMrgyLwpXt7JzIlgXoROmdae?=
 =?us-ascii?Q?qBKqZ9JIyJxehq3b3T4DVNBvjaT8ns9CZKC1JS2skiD6a+aqmCqGDImfdzcW?=
 =?us-ascii?Q?S1AR/gSgO5X0fj1FZgr1PEwfAW9KNQFCah2oLWMGxsMRGm6WSOTHGFn6LSWi?=
 =?us-ascii?Q?WvxbKGCEtNjRb76vg8dXsznD9uvowLr4X3di2AuHhp/qfqr4jeiqoDVxaggT?=
 =?us-ascii?Q?pVoFcijFhejxWAFwBHXP/nw8mRuneyqG4QJJihkZRDbxTyO2/k8/XSX3qkEW?=
 =?us-ascii?Q?ktkEGWS3zDN/YOwkpp2nFkWkELHKYc+YHnWQi+euAAiSWzJ2v9xGC6oqEuPc?=
 =?us-ascii?Q?Ct8SQI6enuNNCLofbwUqjX6KzzvdlgE+upqBoY5eARykLswRM42Q08nNdHve?=
 =?us-ascii?Q?34wXPeHf4XgL6NId/kjdYjwPs4TZhREDfiqIUMR43ZbY7GaqfBcWx5dJ6CYl?=
 =?us-ascii?Q?4dnOd/5WugcDibcFZto5CD112iVTn71HjwwByTLWA8wS22hEsVHKOHyqJ0cx?=
 =?us-ascii?Q?Fmxa07LDwO53ahvs7akDJXxNKUDKK50CNO01tLhMXiNuB+uVKtm77sskWLVi?=
 =?us-ascii?Q?ZsZ5rPyRz0buY+7dv72JxAbnmiXk5wZxKtuboELtCcbUYBn7DiTnVtkmH1kc?=
 =?us-ascii?Q?DyHL+EesB5ylF8Ba6DWZotsTGyRIooHMD//01/fNIvdxNnO9T+2V6MPMws8K?=
 =?us-ascii?Q?IRljXMGFB0wnSXIfh64CeKg1gyAtVBq2l3akzpxMLZgljVZoeV60KK0QWMbO?=
 =?us-ascii?Q?gWWBKU1He5n6RQLXQJigyGYLEMsL4DuHp6f3qhuVLxTExtRtunUhzu3xGjaM?=
 =?us-ascii?Q?LgnzoTLAbSKpad8fiSSHbiOVAJWN4afiq+HN1pZfZ81iQkyCnxKfTPCy8D2s?=
 =?us-ascii?Q?Dzh4Vo7SLHgcE9OfdJz8YdbD6X4Ko6NBfvI3fTbH2569ZFJImzlMV0tmbxz9?=
 =?us-ascii?Q?h2W9WRd12mlKdD9Y4IvLh2yNgxXStEFIhjLBGB8WE4kPaLam2ss5Anjif9te?=
 =?us-ascii?Q?XBPR2VCHo14voBbt/kRU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a9f6a1-01a1-4b57-94be-08dcb90d51f3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 07:23:24.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB7133

On Mon, Aug 05, 2024 at 09:38:03AM GMT, Chen Wang wrote:
> 
> On 2024/8/2 20:38, Inochi Amaoto wrote:
> > SG2042 use an external MCU to provide basic hardware information
> > and thermal sensors.
> > 
> > Add driver support for the onboard MCU of SG2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Tested-by: Chen Wang <unicorn_wang@outlook.com>
> > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >   Documentation/hwmon/index.rst      |   1 +
> >   Documentation/hwmon/sg2042-mcu.rst |  39 +++
> >   drivers/hwmon/Kconfig              |  11 +
> >   drivers/hwmon/Makefile             |   1 +
> >   drivers/hwmon/sg2042-mcu.c         | 394 +++++++++++++++++++++++++++++
> >   5 files changed, 446 insertions(+)
> >   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
> >   create mode 100644 drivers/hwmon/sg2042-mcu.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 913c11390a45..ea3b5be8fe4f 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
> >      sch5636
> >      scpi-hwmon
> >      sfctemp
> > +   sg2042-mcu
> >      sht15
> >      sht21
> >      sht3x
> > diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> > new file mode 100644
> > index 000000000000..250016b47dd1
> > --- /dev/null
> > +++ b/Documentation/hwmon/sg2042-mcu.rst
> > @@ -0,0 +1,39 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver sg2042-mcu
> > +=====================
> > +
> > +Supported chips:
> > +
> > +  * Onboard MCU for sg2042
> > +
> > +    Addresses scanned: -
> > +
> > +    Prefix: 'sg2042-mcu'
> > +
> > +Authors:
> > +
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +Description
> > +-----------
> > +
> > +This driver supprts hardware monitoring for onboard MCU with
> > +i2c interface.
> > +
> > +Usage Notes
> > +-----------
> > +
> > +This driver does not auto-detect devices. You will have to instantiate
> > +the devices explicitly.
> > +Please see Documentation/i2c/instantiating-devices.rst for details.
> > +
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
> > index b60fe2e58ad6..7aa6c3f322e5 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
> >   	  This driver can also be built as a module.  If so, the module
> >   	  will be called sfctemp.
> > +config SENSORS_SG2042_MCU
> > +	tristate "Sophgo onboard MCU support"
> > +	depends on I2C
> > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > +	help
> > +	  Support for onboard MCU of Sophgo SG2042 SoCs. This mcu provides
> > +	  power control and some basic information.
> > +
> > +	  This driver can be built as a module. If so, the module
> > +	  will be called sg2042-mcu.
> > +
> >   config SENSORS_SURFACE_FAN
> >   	tristate "Surface Fan Driver"
> >   	depends on SURFACE_AGGREGATOR
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b1c7056c37db..0bbe812a67ae 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> >   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> >   obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> >   obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> > +obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
> >   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
> >   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
> >   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> > diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
> > new file mode 100644
> > index 000000000000..6d8d677f86f3
> > --- /dev/null
> > +++ b/drivers/hwmon/sg2042-mcu.c
> > @@ -0,0 +1,394 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > + *
> > + * Sophgo power control mcu for SG2042
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +
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
> > +#define REG_REPOWER_ACTION			0x65
> > +#define REG_CRITICAL_TEMP			0x66
> > +#define REG_REPOWER_TEMP			0x67
> As I mentioend in last review, suggest to add some clarification for
> CRITICAL and REPOWER. Due to no document from sophgo, I hope some comments
> in code for memo.

After some struggle, I find it is hard to add some comments here. 
It is useless and the code should be self-explained. Instead, I 
add the comment in the document and rename this reg to "repower 
policy" to make it clear. See it in the next version.

Regards,
Inochi


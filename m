Return-Path: <linux-kernel+bounces-285671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBF951118
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8ED283FFC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE86566A;
	Wed, 14 Aug 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JYCb0jsG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2071.outbound.protection.outlook.com [40.92.21.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6D1879;
	Wed, 14 Aug 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596095; cv=fail; b=LgLvJAAY2CjAy2rYncRRUA7gzwROMDvJIpC8vgrtP15Rr0iAe2xTEkXFaKTbuL18t/WSXtmMU0gUMXNjSbqTYuFw4N7Y9scwmICLiOluxt9JF6Ajorlj+s/Qc4ORTFEIVyvTqgi+43YyaWMQcEf4iEAypRA6oa3Wq0Pw4hf1eek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596095; c=relaxed/simple;
	bh=h9GgSKuOhcPPRWaJblXmVwu1klTKsA5NIxzQ+VGxMHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eLkmyTPoOAeLzKm1fv3KuvOMoAK8LETbYGao6DF5zrCHtBgTOpL6jnIpsBTmbCvVrMZ3enfPgFOD0rZ64nlLz5t8SGL+4bhHQuYZn5EV85sqajsKzCx15BEM61nlFjXko3ZLEF5iA2LgCuqTk9uxXKyYtRxiCYH9HJu80sISa5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JYCb0jsG; arc=fail smtp.client-ip=40.92.21.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saLN1D8SBtnkA8SYEZZlH8akOhifx4xxhBOIXIABFjWq7JQ2lql1wp9fybtRssTU9s2KF7zIDrXENFOLK+ZjQE4w05xVIthaaO8SAP45R0exeCK48HKIZWL26kU9/jhYrqHBpEcJpYNW/SmaO2vbSCqSak34FEjqACgZsRZHH28RJqWkN/UrKswbugrjPfEn4QREsbxRKfW4S8j//T8rrbou9gc0/KSB3AjiWuYu4160FhwGPM3RHWl3oHpipV+6E6kwzytrQkbnruXwgbV7dSBvUL2ZYW3ptBkDWEoRgkQa72MPN7KNO29hblMlUrK9N7+5mIsnNRAgu46zSfOk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JoLnmCf/y/X5foZhrxDU1xi0kAxPKZkhxCXRza7FYY=;
 b=yzKPV/QBcBFUzlRRLyk8V8yak0IolD6Z5dJ/M258YQgji/0aRvT6BjlZMiQ4Vhcy3JzCj2RBl/Hku3Gefv8t/KBeDiLjgBKO2O25eruE0inGn0BODI7G7tLL+1j9FIKc6EORPvnZkY5Bg4wUx8QLPBtI5+tjgzS76Xz5sy/fsGedwfgJYsmZZq35D0y4/BGsBXg+j9zfNvUMlBtXsjTG1+X9SD6/KKL1ab8eaHC8RpPD2FbiEu8s7uy8dbaubjH/VmneDsfiMcx2zwgsIW80caO8shlFSp2J8fOWn4teo3LwPWIU+64UHohXOUkx6xcNtGoa8ar81A5tctrz/5qbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JoLnmCf/y/X5foZhrxDU1xi0kAxPKZkhxCXRza7FYY=;
 b=JYCb0jsG466XMUwB0GAPerK+bma2gXwa4FZAlvncHqheNZY2mHdyOoMNUP1XGMU8gh5KxtyN6NiSJhzOGSsqfv1VDKVudalREUeCEdZPujPRMSqZGDR4aIu+jzfNM3P9KGbxhYQjD/5s+OulhxbqzwaoA3UutJxMvN4hPH2u1Y+JihtZxz7fL+O0iN0ko0WXsG9+dX665Y/qEtwclsf6IbnQAT8kxzvKtNeIftH1abMxCoSmILCSXlBK7pS/Ogp7Ox7o8QuKxVjffQhB79BHiqqfXRtc6rYnSyaFvNEO/BcknFmfcOidjUSxsikmVaNJiWZqFHUtbHPeGxbFfTJkJg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5830.namprd20.prod.outlook.com (2603:10b6:510:274::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 00:41:29 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 00:41:29 +0000
Date: Wed, 14 Aug 2024 08:40:43 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Drew Fustini <dfustini@baylibre.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Hal Feng <hal.feng@starfivetech.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB495356094952242D9CD8A249BB872@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <0e30eab7-e202-4639-863d-85ce28525714@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e30eab7-e202-4639-863d-85ce28525714@roeck-us.net>
X-TMN: [XxWbHDtbcQgG54BDJQWnohBvTXbdGly00CLo8vQeGFA=]
X-ClientProxiedBy: PU1PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <gzigg25xsx6dsjx4smuf5m4rj36qkmqpe7qbd4pbt52gmsiym7@a3p3uzhknmit>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 998ec926-c34e-40fe-57e8-08dcbbf9d5ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	bu+54vBRO7aUB7r4hEA1hJ0GPgRvT/NsZZDc/Y63oaMbMhWwh+ai1Z0U70KvNTwa1ZbqBA4bnTQBG91aeiJbQWHiAWjDFZEpd0AMnw5aVPcF2KV1TBJHrNvqWOeZgRRjyVj5UmYH3GZA/7Jj3l3Z1bGUmJ0VdxUBykWgRhC69lwpg1mbjVFXXsiJCa/isByD7r3bpcXn2E1Z0DYOvY8qU9NC8ljzIhx6Wn9RykECLank0CYpldQ1YqtSo0MiYvPVp+mdgm32KDUEra/tWNECXpLJOur4zBboenFaKniYryDptH4JGWH3Z7CfFR4619B+bfebQ/rtJ/+jd0wk6LJuhzaCBCJlIwH2qy5BJt3KoyNQdMzYekuxtARqZpMJO+gDNhCa+nxoP1Z9DORLSj+ceflpaBlpji4u3X/QRD/Unys0W4AW14XOKSh652++foUXc0I0qKmy2+3ezvpUQ/Z/SyvNQh5A8GIJ9dTeZ9GF5oJXoPVz5r5E3aoPoKUSDjyKx5TM0HtD8uGKidA77tL4P73hvQFf/EBmEp0DER/83TF1wfqQZmF5wTBv8CpYo9Gn6Y9tUBlAiny+XRBpaKPSB1Xu7+JZoim9EkFtR564ERhK76zPBA/8rWJZ1MMLkGC5GafZLcvSUWf7Z0XLBncsICvGWuzHNUlII3UQ/IpdoT2Vxmg7/74gkaOiW2lE5n2BFlWTGXQCZtSbPPRRCAQCAuKSnas9vdULbPqFjSCG8qE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fe2eLSvjiOblsdUdLC0+HB2PnaaKK0aVyOd6wHvPBYmvd90jT/ntigh897fI?=
 =?us-ascii?Q?xIk24HFOam0JCW0rKF/IbP1NxRRgWAC53td4Owahfgv+/f1ccpdYPo69bGkq?=
 =?us-ascii?Q?Wh4p36jRdLUIdIBLtEtPSRw+Tyn9zN+vNd4PEIyO6zWfvRRNaOjUNu2zg/XP?=
 =?us-ascii?Q?sT6t4J/Sk+4FX/yLn00+4O58Axb5QHnTVfYRJ6cwkOrRsXNazVV6hkRnRVI0?=
 =?us-ascii?Q?V/WH0hh00OpPstRTuERBjRAUxf8Fs9AUrKGrxF549xoksTXEYS2K4dRIlvvd?=
 =?us-ascii?Q?Aeqh1gZ93vLwHysuk0ODRxgMh5fnVf8Zo/pz+xZPYkck1Fj3Cy75OCjjH+e7?=
 =?us-ascii?Q?Pu+iNaqFwE6D5NL0X1k2y+hfOKZhXAi++9HdlHq5DHgXWMwRxurz37p5TlNN?=
 =?us-ascii?Q?DVwTn50q68XlglNlmboTlCWg1vRZJjJ0wq5F7cnUWElLj/PEPtLbL2BbqeCz?=
 =?us-ascii?Q?uuN250kvemN99wTSJLZ0vPVnbk6xeV2cT2QUCGZJiE7Ty3WXrFueqlEGUSeg?=
 =?us-ascii?Q?7jJSISGv9piJxUzuiu4aBMKYiwBvPU/Iel48n8JztStrOfp3SD+jTVP0JXgz?=
 =?us-ascii?Q?Rk5ldVku6E7IV+ieQmy12Mt7G3ixLw2m/d+tQ/TMl5LPES05B+ZNF4ufD4W4?=
 =?us-ascii?Q?rYi3QxR6RS7hbqkVJodt+nagY7PqTu8J4eU6FiavLs+vy2pp/IpoZjreVQHI?=
 =?us-ascii?Q?f4YKRRrZ86fRXvG3elZmJzQ50YDM06t5fmJkljh90EdMdjsdUpk2IgfQO3xn?=
 =?us-ascii?Q?cXqMiNips5f/IDnCrrWi2ERuF29m7vuYzUZpLSj2TzFt8XLz3joObZ7hGOXf?=
 =?us-ascii?Q?2Fqgq+Pe/dUeidYX5mV+6c5ISbR+d1EzAj/U4ggyCYRt9OISJO95PzCxO69X?=
 =?us-ascii?Q?BakJpRG1wLEr3aCQbFt4cYIaNrK47ptdkHOldrHAQEPHdoqSIsS1NN8lKcZ/?=
 =?us-ascii?Q?QFc+BPrCtaQ3PTt6C9O/tvGc8rfWMgC3b2OUN4s+BMoYKHAi67nWPYcP3JNH?=
 =?us-ascii?Q?SDPBGuPSqgNSf+8WWU7zgPdWNpoo9wf8PGGEN3Ewg54FzjlxgiLWtRbFHsCI?=
 =?us-ascii?Q?rnWMbhHqU7FznupYDGJyCus4dQZJC7sihX06Hrg3re7McjiWZykesobQQfeU?=
 =?us-ascii?Q?ylXbqAGHB8awwKLQPLkGuf87tBU3/EiUyALejI9P3x98mMgeJ2boi2DHnWQ5?=
 =?us-ascii?Q?Min+0v7+gBJt4C2YEzEPmLpSZA3sFDrBvZY42lcUfUVbwHWumdtcJ3O6To6L?=
 =?us-ascii?Q?hFhaNtm7Hpd2vmviJME4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998ec926-c34e-40fe-57e8-08dcbbf9d5ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 00:41:29.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5830

On Tue, Aug 13, 2024 at 11:27:11AM GMT, Guenter Roeck wrote:
> On Sat, Aug 10, 2024 at 04:03:51PM +0800, Inochi Amaoto wrote:
> > SG2042 use an external MCU to provide basic hardware information
> > and thermal sensors.
> > 
> > Add driver support for the onboard MCU of SG2042.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Tested-by: Chen Wang <unicorn_wang@outlook.com>
> > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >  Documentation/hwmon/index.rst      |   1 +
> >  Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
> >  drivers/hwmon/Kconfig              |  11 +
> >  drivers/hwmon/Makefile             |   1 +
> >  drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
> >  5 files changed, 478 insertions(+)
> >  create mode 100644 Documentation/hwmon/sg2042-mcu.rst
> >  create mode 100644 drivers/hwmon/sg2042-mcu.c
> > 
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 913c11390a45..ea3b5be8fe4f 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
> >     sch5636
> >     scpi-hwmon
> >     sfctemp
> > +   sg2042-mcu
> >     sht15
> >     sht21
> >     sht3x
> > diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> > new file mode 100644
> > index 000000000000..18a3578ac213
> > --- /dev/null
> > +++ b/Documentation/hwmon/sg2042-mcu.rst
> > @@ -0,0 +1,77 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver sg2042-mcu
> > +========================
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
> > +The following table shows the standard entries support by the driver:
> > +
> > +================= =====================================================
> > +Name              Description
> > +================= =====================================================
> > +temp1_input       Measured temperature of SoC
> > +temp1_crit        Critical high temperature
> > +temp1_crit_hyst   hysteresis temperature restore from Critical
> > +temp2_input       Measured temperature of the base board
> > +================= =====================================================
> > +
> > +The following table shows the extra entries support by the platform:
> > +
> 
> Those are attached to the i2c device, which should be mentioned.

I have mentioned this in the Description. Does this need to be 
mentioned here again?

> The terms "driver" and "platform" are really misleading. The attributes
> above are hardware monitoring device attributes, the attributes below are
> i2c device attributes. Both are implemented and thus supported by the
> driver.
> 

Thanks.

> > +================= ======= =============================================
> > +Name              Perm    Description
> > +================= ======= =============================================
> > +reset_count       RO      Reset count of the SoC
> > +uptime            RO      Seconds after the MCU is powered
> > +reset_reason      RO      Reset reason for the last reset
> > +repower_policy    RW      Execution policy when triggering repower
> > +================= ======= =============================================
> > +
> > +``repower_policy``
> > +  The repower is triggered when the temperature of the SoC falls below
> > +  the hysteresis temperature after triggering a shutdown due to
> > +  reaching the critical temperature.
> > +  The valid value for this entry is "repower" or "keep". "keep" will
> > +  leave the SoC down when the triggering repower, and "repower" will
> > +  boot the SoC.
> > +
> > +Debugfs Interfaces
> > +------------------
> > +
> > +If debugfs is available, this driver exposes some hardware specific
> > +data in ``/sys/kernel/debug/sg2042-mcu/*/``.
> > +
> > +================= ======= =============================================
> > +Name              Format  Description
> > +================= ======= =============================================
> > +firmware_version  0x%02x  firmware version of the MCU
> > +pcb_version       0x%02x  version number of the base board
> > +board_type        0x%02x  identifiers for the base board
> > +mcu_type          %d      type of the MCU: 0 is STM32, 1 is GD32
> > +================= ======= =============================================
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index b60fe2e58ad6..7aa6c3f322e5 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called sfctemp.
> >  
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
> >  config SENSORS_SURFACE_FAN
> >  	tristate "Surface Fan Driver"
> >  	depends on SURFACE_AGGREGATOR
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b1c7056c37db..0bbe812a67ae 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> >  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> >  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> >  obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> > +obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
> >  obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
> >  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
> >  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> > diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
> > new file mode 100644
> > index 000000000000..0a2e072511b6
> > --- /dev/null
> > +++ b/drivers/hwmon/sg2042-mcu.c
> > @@ -0,0 +1,388 @@
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
> > +#define REG_REPOWER_POLICY			0x65
> > +#define REG_CRITICAL_TEMP			0x66
> > +#define REG_REPOWER_TEMP			0x67
> > +
> > +#define REPOWER_POLICY_REBOOT			1
> > +#define REPOWER_POLICY_KEEP_OFF			2
> > +
> > +#define MCU_POWER_MAX				0xff
> > +
> > +#define DEFINE_MCU_DEBUG_ATTR(_name, _reg, _format)			\
> > +	static int _name##_show(struct seq_file *seqf,			\
> > +				    void *unused)			\
> > +	{								\
> > +		struct sg2042_mcu_data *mcu = seqf->private;		\
> > +		int ret;						\
> > +		ret = i2c_smbus_read_byte_data(mcu->client, (_reg));	\
> > +		if (ret < 0)						\
> > +			return ret;					\
> > +		seq_printf(seqf, _format "\n", ret);			\
> > +		return 0;						\
> > +	}								\
> > +	DEFINE_SHOW_ATTRIBUTE(_name)					\
> > +
> > +struct sg2042_mcu_data {
> > +	struct i2c_client	*client;
> > +	struct dentry		*debugfs;
> > +	struct mutex		mutex;
> > +};
> > +
> > +static struct dentry *sgmcu_debugfs;
> > +
> > +static ssize_t reset_count_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RST_COUNT);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return sprintf(buf, "%d\n", ret);
> > +}
> > +
> > +static ssize_t uptime_show(struct device *dev,
> > +			   struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	u8 time_val[2];
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
> > +					    sizeof(time_val), time_val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return sprintf(buf, "%d\n",
> > +		       (time_val[0]) | (time_val[1] << 8));
> > +}
> > +
> > +static ssize_t reset_reason_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RESET_REASON);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return sprintf(buf, "0x%02x\n", ret);
> > +}
> > +
> > +static ssize_t repower_policy_show(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   char *buf)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int ret;
> > +	const char *action;
> > +
> > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_POLICY);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ret == REPOWER_POLICY_REBOOT)
> > +		action = "repower";
> > +	else if (ret == REPOWER_POLICY_KEEP_OFF)
> > +		action = "keep";
> > +	else
> > +		action = "unknown";
> > +
> > +	return sprintf(buf, "%s\n", action);
> > +}
> > +
> > +static ssize_t repower_policy_store(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    const char *buf, size_t count)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	u8 value;
> > +	int ret;
> > +
> > +	if (sysfs_streq("repower", buf))
> > +		value = REPOWER_POLICY_REBOOT;
> > +	else if (sysfs_streq("keep", buf))
> > +		value = REPOWER_POLICY_KEEP_OFF;
> > +	else
> > +		return -EINVAL;
> > +
> > +	ret = i2c_smbus_write_byte_data(mcu->client,
> > +					REG_REPOWER_POLICY, value);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR_RO(reset_count);
> > +static DEVICE_ATTR_RO(uptime);
> > +static DEVICE_ATTR_RO(reset_reason);
> > +static DEVICE_ATTR_RW(repower_policy);
> > +
> > +DEFINE_MCU_DEBUG_ATTR(firmware_version, REG_MCU_FIRMWARE_VERSION, "0x%02x");
> > +DEFINE_MCU_DEBUG_ATTR(pcb_version, REG_PCB_VERSION, "0x%02x");
> > +DEFINE_MCU_DEBUG_ATTR(board_type, REG_BOARD_TYPE, "0x%02x");
> > +DEFINE_MCU_DEBUG_ATTR(mcu_type, REG_MCU_TYPE, "%d");
> > +
> > +static struct attribute *sg2042_mcu_attrs[] = {
> > +	&dev_attr_reset_count.attr,
> > +	&dev_attr_uptime.attr,
> > +	&dev_attr_reset_reason.attr,
> > +	&dev_attr_repower_policy.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group sg2042_mcu_attr_group = {
> > +	.attrs	= sg2042_mcu_attrs,
> > +};
> > +
> > +static const struct attribute_group *sg2042_mcu_groups[] = {
> > +	&sg2042_mcu_attr_group,
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> > +					HWMON_T_CRIT_HYST,
> > +				 HWMON_T_INPUT),
> > +	NULL
> > +};
> > +
> > +static int sg2042_mcu_read(struct device *dev,
> > +			   enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, long *val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int tmp;
> > +	u8 reg;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> > +		break;
> > +	case hwmon_temp_crit:
> > +		reg = REG_CRITICAL_TEMP;
> > +		break;
> > +	case hwmon_temp_crit_hyst:
> > +		reg = REG_REPOWER_TEMP;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> > +	if (tmp < 0)
> > +		return tmp;
> > +	*val = tmp * 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sg2042_mcu_write(struct device *dev,
> > +			    enum hwmon_sensor_types type,
> > +			    u32 attr, int channel, long val)
> > +{
> > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > +	int temp = val / 1000;
> > +	int hyst_temp, crit_temp;
> > +	u8 reg;
> > +
> > +	temp = clamp_val(temp, 0, MCU_POWER_MAX);
> > +
> > +	guard(mutex)(&mcu->mutex);
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_crit:
> > +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> > +						     REG_REPOWER_TEMP);
> > +		if (hyst_temp < 0)
> > +			return hyst_temp;
> > +
> > +		crit_temp = temp;
> > +		reg = REG_CRITICAL_TEMP;
> > +		break;
> > +	case hwmon_temp_crit_hyst:
> > +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> > +						     REG_CRITICAL_TEMP);
> > +		if (crit_temp < 0)
> > +			return crit_temp;
> > +
> > +		hyst_temp = temp;
> > +		reg = REG_REPOWER_TEMP;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/*
> > +	 * ensure hyst_temp is smaller to avoid MCU from
> > +	 * keeping triggering repower event.
> > +	 */
> > +	if (crit_temp < hyst_temp)
> > +		return -EINVAL;
> > +
> > +	return i2c_smbus_write_byte_data(mcu->client, reg, temp);
> > +}
> > +
> > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > +				     enum hwmon_sensor_types type,
> > +				     u32 attr, int channel)
> > +{
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			return 0444;
> > +		case hwmon_temp_crit:
> > +		case hwmon_temp_crit_hyst:
> > +			if (channel == 0)
> > +				return 0664;
> 
> 0644, please. Always. We don't permit group write access for sysfs
> attributes.
> 
> 
> 

Thank, it is my mistake.

> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +			break;
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
> > +
> > +	debugfs_create_file("firmware_version", 0444, mcu->debugfs,
> > +			    mcu, &firmware_version_fops);
> > +	debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
> > +			    &pcb_version_fops);
> > +	debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
> > +			    &mcu_type_fops);
> > +	debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
> > +			    &board_type_fops);
> > +}
> > +
> > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct sg2042_mcu_data *mcu;
> > +	struct device *hwmon_dev;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > +		return -ENODEV;
> > +
> > +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > +	if (!mcu)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&mcu->mutex);
> > +	mcu->client = client;
> > +
> > +	i2c_set_clientdata(client, mcu);
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sg2042_mcu",
> > +							 mcu,
> > +							 &sg2042_mcu_chip_info,
> > +							 NULL);
> > +	if (IS_ERR(hwmon_dev))
> > +		return PTR_ERR(hwmon_dev);
> > +
> > +	sg2042_mcu_debugfs_init(mcu, dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct sg2042_mcu_data *mcu = i2c_get_clientdata(client);
> > +
> > +	debugfs_remove_recursive(mcu->debugfs);
> > +}
> > +
> > +static const struct i2c_device_id sg2042_mcu_id[] = {
> > +	{ "sg2042-hwmon-mcu", 0 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > +
> > +static const struct of_device_id sg2042_mcu_of_id[] = {
> > +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > +
> > +static struct i2c_driver sg2042_mcu_driver = {
> > +	.driver = {
> > +		.name = "sg2042-mcu",
> > +		.of_match_table = sg2042_mcu_of_id,
> > +		.dev_groups = sg2042_mcu_groups,
> > +	},
> > +	.probe = sg2042_mcu_i2c_probe,
> > +	.remove = sg2042_mcu_i2c_remove,
> > +	.id_table = sg2042_mcu_id,
> > +};
> > +
> > +static int __init sg2042_mcu_init(void)
> > +{
> > +	sgmcu_debugfs = debugfs_create_dir("sg2042-mcu", NULL);
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


Return-Path: <linux-kernel+bounces-243774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9279929A6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1826A1C20A19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E7138C;
	Mon,  8 Jul 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VrkcOEyv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2067.outbound.protection.outlook.com [40.92.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042218E;
	Mon,  8 Jul 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720400079; cv=fail; b=KtaA62vnlH7nYME0MvSlHyOjsQzB6oPzLkFQ6myDQKOV3j+SJC95YcbGqqaBTSoO7CM2/b1JvGvPJEODhxhq5CRurK43Nd08K7/R0GO440XFwMQdo3uwTif4VNr1NHHHX7iJDL/yVc3iBDHcQrOaT9e43wp0UXom6HL4wNI88Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720400079; c=relaxed/simple;
	bh=Kl7BsptdOhk50c6kGTd79jAX10fG59rlV/765W1FSLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ynw6SqDMfsIoVpJn6IN2k7Mtl5v3PNVUxNOYT8t7vmSyGQ60E8mLkpza3gH4zqENz28i6gyScxqau3TIQCTribNoZOQx2aAk0JwRV0E9Q45SHEbJNMZTviLXQkM5lX+fEahMmGxqWHUZNE5qTyhrve1OMj6E9cu//DCR64wByOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VrkcOEyv; arc=fail smtp.client-ip=40.92.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQi63y7nbmT8qTOSDU664SZvQer56Sg8P789//DYcbZBCOcjETLwRFe/rpxbuq4VDJnUyQycO+vtFkv9gZucCVopREhNlwKcjriO8jYChaDk0nIArdVSbZvZ4hDz7iVkdHcYNgdckc1my/U0ds++Ar6aVLFBl9BWhBGc6eBuNUW81pg/iSnpCBHxny2E+R3LKQw5bC19s49LGL5BD7f6XhpmSxvnezDoVNEAPgr4lb8FL9BJpXU22THpVwXu6G4X37e7gz7sV9jMYosI5GRFxDDs6XelkwWtSpJIR6D/XbC2TQO0bx+fyHGf8efUx2Cy7d1ML7jzFb0zwWjKLHX4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq8n54y7bezz/dqtp3AOKOz3j1keW6hW7yEUhsGBrp8=;
 b=fFtXV7KQk38s8BcuiNSLFJx3B/hQP8KG2/Ed6Xk07s32tzEqBAVbR1680eZCUtBGHhL2UI81Mie+pf6Ar7jHsI/e7PVVc0ET8tXlOFkxUNaVd/iIPk2/FQ2pdhOqWEgR0kkBccmFNgp/RKey4oJGqYzF45yRs7v4MZZsBzuc/Uq6nt2kJN4xqbkGmaoAn5rLWSPIXxyAOpbPG4CBVOhEgwKUeuLdxhTTIfQFX4i55//i//doHpUh2rTLJDKcydDq7w5/ttYXQWHAyi3FWSyNid4QM6gDWr4AFVCdQqD9Xqrs9MZekP/3Wv9WcBQpcsJI8Wtm6lnKdOIEZxCTHhOl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq8n54y7bezz/dqtp3AOKOz3j1keW6hW7yEUhsGBrp8=;
 b=VrkcOEyvsFEagNfWiqYoQH9qz5NFMtk9Mm0pZMcXeBU/kBZvOfsv3n4fCE1A6gAxldBg5Zsg+dTXKsiuAcDlvkAe7mx+Sc4RiTouNMI9Z4nHc99qf3OuVDAkFwMU1RAHJnw7muOMbplLtdCeNJP33S8D0oA09l5cb/48vNLa1QjeBLaQUr0cTw/tea0inQ/yVeX7IKNbdAEhe6BKyWl39Vwrevz9byZpDWrdtiOOLGdbuJirOpAvu0nQycG45YGlB/xYLTfEXfaAjl/5ioxEISgpzEVCHH6DHSgOH8i3F7llpvoaemv6vS60uNmRd22qcq8WQm2tM6BAPHBjmsg+/g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5340.namprd20.prod.outlook.com (2603:10b6:510:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 00:54:33 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 00:54:33 +0000
Date: Mon, 8 Jul 2024 08:53:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953230DCEDD7DF01134A8A9BBDA2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [5pIKicaKQfMplTqfHRA5Nx0u/uGwHLAJ0dymnOwytVk=]
X-ClientProxiedBy: TYAPR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:404:14::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <dvea5ezucmu4oya5swv2cm3v3klg6qnx23shajnlmamnmq4sfd@vzfoymn6ntz4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 998708f5-a311-494e-e132-08dc9ee88806
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	71kSFpinhuUT5VTsXruBnL/8/+HvMAMQ01s60SHHYUjOKnWCG/4lMsRLtwngPDKDExvJY6mLDqukXikfg8T2BNSRUGwB/XVd043eStibqCHBB9L7D0qqV+pOFIyeKWTz9KluEFxsiLBPiZwU10gOjkEiNCw30BIPxoWigDnj2n5T+UANqLpNmySTDRWVdJIfirZgRFfWR6O/lhVj9TWZP9Q9Opxc5xEhcvXG4enLfUadm8EpFXHd4cnr1HL/940fNoNc+0LKSS2UfwTDTjRFYJVytnVa2yYtpMrpiuwy3PQXBC73DSIhuqdTOFnDbEzRhnaS8YuM4O9YpJO7uYo0RJxDyTz/jdgk7rGIOrCyGE3oLPwozk7SUfQphLyquFUbWpH9j/NbgBWLD5eEKHaOydRoWV5KEhSJIuK7Pl0Cq/eQN8/OJvRZ7/vmVjSse1Y34n5EmGZKtIm2uh9JaycpqfMB8Srvpl3BJkAelGQEKPlR2QklkDrz4H3c8aIlGWlhPLeaTKY4xUUZVh2CrDQX0zlE9jGZ8jcb1H0drBBgz0Qq4DGN013Ls6vWDlYmEtWg5MMgl+Pxogc8N4nEE7jfaxfu3UYl65eFgxOLFaLDEZS6frsINejwONcC1pW9D/BlJc0l46KCk0kUGq9rYBkjFxF84NLNuxEGkHGM6hDcS1fk2ILpuV1uZSZWdty5mdyh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A0ZL8UQAcHrUAabcTT/f/KVQnaMNOGbhOv05dg1/U5eEuA7ZYxntydNWQssg?=
 =?us-ascii?Q?aVySP6sRY4cDyXmY6qpeMEVQGIHlInayV6tOk5PaLea2NN/Fgnd+IS6gq07y?=
 =?us-ascii?Q?h1nem2epPcR38X2nkdCiWeUs0Y7HsKW85EhFRowkVd4kw0JaZH5F4oKqn/y9?=
 =?us-ascii?Q?KFqeVWNFHdtN/+1yGLLWjez4KYSPpaRSdc1NSC/RIlhZSM0kRNKOXOFiDQzc?=
 =?us-ascii?Q?Z4oqYrLwt6x2xPotpz7F2YgGiG4oyDRnSY6X5JPhOSbVybvqv0lz+2fM5lh+?=
 =?us-ascii?Q?QnV+3b49RSLsdWIq3bGzmlYnHr2UHJqWDR6vbJ27jK7OV/AS8D/THMODWsTX?=
 =?us-ascii?Q?0fnoyFFpFiBW4muYTPTH7UGZJoxmdzV5VrneIgFKW5taLDU8Cw+YEN4xxLJI?=
 =?us-ascii?Q?7SvjXaAxusoRzU8Qqs09eAlg2oNuMVbkxZAWywR/CsBryGQLYb2UObR1guu6?=
 =?us-ascii?Q?8e2D4a+YOXrjCunyYHL8X07NkAdLba8T1VhBwGx31WvFuKtbuAbtPMHCWpD8?=
 =?us-ascii?Q?uLVUk6kTstF5rzdbVo/Bkc9QFUcgzFivQU3n32U2RcVjG55t/n2awzwncj76?=
 =?us-ascii?Q?6xNCxvTVi2zGuvOfIg57+H2TbGmHL3qYa6SQRT65GC5jZ2bgJUzr5TjmkQQD?=
 =?us-ascii?Q?P8zlMELQiWJp8LqG2iZj7J6M5ldRGN/e9pOYCuxOFopdYiDdnICj9cgkt9wB?=
 =?us-ascii?Q?//bJAB9l3icUsEKKsFB+XkhzAyr70lvRUNRXpQr5U8m6cO6AGQ934zGXe9lQ?=
 =?us-ascii?Q?pmUtccBuyB2rDJeySYKcb1zDZy/ndlLQoIsUe1RexkXsI3Hae1oPiaRQJhc8?=
 =?us-ascii?Q?fIrqRRFi37lNS4ru1zTyHy6+zoYvXthAlQQK2C3RPVKPTOeMyqvJ1Zz5ImF9?=
 =?us-ascii?Q?llFzWi3drUmQvxaNcthVFY8kCzi1mPkoN1RsHTWOkNCwUVtumve9jKOtDVU9?=
 =?us-ascii?Q?MJrCnmOOdpRh9jlSTIg4EGTJbUGB98SCprXnMboCf+NKUO8Qgc5mg/vnYCum?=
 =?us-ascii?Q?sN/iHHL9EWzRf4OjjHdCeJ50ek5Pt2F9MTuysfF7Om3AVuDSJFfejT6+5uL8?=
 =?us-ascii?Q?5qFDVRhXrUqd+q4LP5xTbQREsnoPiN8Hi2QO+hLOAWbsl+4Hh2wbPKdGut/G?=
 =?us-ascii?Q?JRs1tKDtOnkacVBBsvX1xyPnbnYBFxvo10vZp0dnT3FDhzuGueMgVqx3CinJ?=
 =?us-ascii?Q?bZ8TkOznaNiwmKV7zh6yYZ89/VfcjiDdCeBFz04iFqaKzF6KBoRpRE/SCnBO?=
 =?us-ascii?Q?cyMp8eYzbezGEr5hoDPg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998708f5-a311-494e-e132-08dc9ee88806
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 00:54:33.5272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5340

On Mon, Jul 08, 2024 at 08:25:55AM GMT, Chen Wang wrote:
> 
> On 2024/7/3 10:30, Inochi Amaoto wrote:
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
> This driver is for sg2042 only, right? "sgmcu" looks be general for all
> sophgo products.

Yes, according to sophgo, it use this mechanism for multiple products,
so I switch to a general name.

> >      sht15
> >      sht21
> >      sht3x
> > diff --git a/Documentation/hwmon/sgmcu.rst b/Documentation/hwmon/sgmcu.rst
> > new file mode 100644
> > index 000000000000..5669dcfb2a33
> > --- /dev/null
> > +++ b/Documentation/hwmon/sgmcu.rst
> Same question as upon.
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
> Same question as upon.
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
> Same question as upon.
> > +	tristate "Sophgo onboard MCU support"
> Same question as upon.
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
> Same question as upon.
> >   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
> >   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
> >   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> > diff --git a/drivers/hwmon/sgmcu.c b/drivers/hwmon/sgmcu.c
> > new file mode 100644
> > index 000000000000..d941d6fe741f
> > --- /dev/null
> > +++ b/drivers/hwmon/sgmcu.c
> Same question as upon.
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
> 
> Upstream kernel DTS only supports Milk-V pioneer, evb boards are not
> supported in plan. Can we figure a method to let user extend this outside
> kernel or just ask vendor to patch this when necessary?
> 
> > +
> > +static const char *sg2042_mcu_reset_reason[8] = {
> > +	"Power supply overheat",
> > +	"Power supply failure",
> > +	"12V power supply failure",
> > +	"Reset commant",
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
> > +		break;
> > +	case hwmon_temp_crit:
> > +		if (channel)
> > +			return -EOPNOTSUPP;
> > +
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
> > +	switch (attr) {
> > +	case hwmon_temp_crit:
> > +		ret = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> > +		if (ret < 0)
> > +			repower_temp = DEFAULT_REPOWER_TEMP;
> > +		else
> > +			repower_temp = ret;
> > +
> > +		down_temp = val / 1000;
> > +		if (down_temp < repower_temp)
> > +			return -EINVAL;
> > +
> > +		return sg2042_mcu_set_soc_crit_temp(mcu->client,
> > +						    (u8)(val / 1000));
> > +	case hwmon_temp_crit_hyst:
> > +		ret = sg2042_mcu_get_soc_crit_temp(mcu->client);
> > +		if (ret < 0)
> > +			return -ENODEV;
> > +
> > +		down_temp = ret;
> > +		repower_temp = val / 1000;
> > +		if (down_temp < repower_temp)
> > +			return -EINVAL;
> > +
> > +		return sg2042_mcu_set_soc_hyst_temp(mcu->client,
> > +						    (u8)(val / 1000));
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
> > +	i2c_set_clientdata(client, mcu);
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > +							 mcu,
> > +							 &sg2042_mcu_chip_info,
> > +							 NULL);
> > +
> > +	sg2042_mcu_debugfs_init(mcu, dev);
> > +
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


Return-Path: <linux-kernel+bounces-273314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A694674B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7101C20CB3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742012B7F;
	Sat,  3 Aug 2024 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZUIe2H6C"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2049.outbound.protection.outlook.com [40.92.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D410A03;
	Sat,  3 Aug 2024 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722657426; cv=fail; b=OHjmqXNBPw3fxHZ4+hTkCvHEZs6XxYFc4dIX0lcppOcLsos4dc8cHDGgaBYcNcwMsXP5pGLK/LzeDhw25mv/5aZ8Znx30/opHwEGKJ5xWS0XQx/yP98e8K8Nd6lAezhw43xbif1VzkB6xuNFpbN8TMH6MhTgf0Mw3/npfW3XmjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722657426; c=relaxed/simple;
	bh=qxb2T8nmaNle84u1QoEwOYztwcpktDtilbABqHCqXX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=malaLyY1NMG/LTgyGcY5d/udg3eN/cDuocCvVdGUbbNcKxGTQDWqdsBJ2xDgRuPK5gLhBmnoY7uItLF1lAUGt8ole1NmVhYMtuMZ2ozqSWLve0Cky3jggDMzNKMClz16bhQMXZ1log9nFwUqTTU1BaIyUQfq1wjRfjoC+//3UCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZUIe2H6C; arc=fail smtp.client-ip=40.92.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNR4REJmZ6MGlHVdn8wndophvaFJ7kYdskpaKsB5gpGJ3rfQfQM3JFfnWpMV/KHlNTbD0XLMdynSo759xuLCuINQSCyOxXtBV6kiMEDdvWbMXxpAiFOVJpJWZncvn4biW9unvVJhQ4K0JOf30Id3dfyQykon26MjJEhcb9GNlerrwum4PsPHt9kL/WeMWEHNfQxPx+M82JoSFYqA8kk6ygDixxCECWoArA+PwBlltfzmbqJVfyzKkU0/KkoHqvw8LmqQmbaZLogVGZ/Vogqkg8qU18yM2Mu53XwbYTIkgLY3QzYV/sY+6tdKuCC0yU3j4Ix8ZuT5tYYxsRg+4sDI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1HJVouGs04P304TVs8dgWWYzRsGZKOEkuNexk5JEy8=;
 b=wXk+4SCQjjIAMMsDdmo0Ysd6KAxPO2rRoIzrc/FMewH2XQpbqlU7YTE6BwNTwye93YFea7m5DX8PwTYCZz2QzsXoklHoIPQwT3Jr3v6fP1bbvB5pcZYcyUCdnEnePbRpLBj2r8nxE4B5si5zZKpnoz34/PY15WGMLgGejEPmlnqk3IPqvUXGG7llkXSws3O5V8HnhMxkWB0wX9EMK06n28KdvNp1ddkFm3qg3vfSXC2+7N3ddcC2plbw95qVI2eLfMdokPfxdE+HQHz954Mr03aqzoYl8gMayO9M6VHr+ZNgZ1tA8+fux7TNU6g771xymTEQi7mK3baqAEXHGWGDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1HJVouGs04P304TVs8dgWWYzRsGZKOEkuNexk5JEy8=;
 b=ZUIe2H6C+09UNpps4sBBWXUbXEqYcBN9wU2muuNVQHujEfSRsRTjKqx70VB8jfWBQsSmO+NuMkrFG6VGBvte7dTjAKQlP6aka2VzyUhrCClzaqZOhk/AVZ8JIJGb7gnTO8kuP9/GYytnvBNGeSI2eUx4UzxCdAXVmHoRONtSapWlN3ox7s3FJAdQfuWu/k3d/NiAu0rHDGkETzwrCBUlvLQjcSpbLrE3E30RM0+v/yHgmsrLTAWatc3vSDHeDTQGEXldNwqXCzlaiovRET0EAUwfQ0h8tpCJJb6nGytqCG2z+rtr2ZlrWeP+fc+R9CesksNNiiGVliP8tzNT3oHFig==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7271.namprd20.prod.outlook.com (2603:10b6:208:4a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 3 Aug
 2024 03:56:59 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Sat, 3 Aug 2024
 03:56:59 +0000
Date: Sat, 3 Aug 2024 11:56:24 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Guenter Roeck <linux@roeck-us.net>, 
	Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>, 
	Jinyu Tang <tangjinyu@tinylab.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Yangyu Chen <cyy@cyyself.name>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID:
 <IA1PR20MB4953A31C50A63CA370082030BBBC2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953032E1B5D58D2F6C7393DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <c165cc19-d324-47aa-94a4-2d2db79afb0f@roeck-us.net>
 <IA1PR20MB4953DFA5607E92D16E1B31FABBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <87ec50bb-7040-451c-832b-27b93923d5cf@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ec50bb-7040-451c-832b-27b93923d5cf@roeck-us.net>
X-TMN: [dZDJ3vUbDuC4AUgURT70iA9v9Kfq7WxBF7epo7C67J4=]
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <hxev5yxbq4cild2o4eeskamav7xwvwrm5h2qmyxaehg2ldm5n2@obxqnjjc2p6i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 4687bce2-cee8-466a-4d24-08dcb37052e5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	x7kxJZDNFf6WLNnmMuKijUAA7LorKL17644846NkfxqFWRcF2cmd4j47Mpuhg1WWpl/XrzdP1P2Wx+Sm7CiAYojiFdspvbzqYJQcc3IRSGV6tq7IQMY/yZKBxX95Y7V9PbEDqAeTTuBqX8b2+Ba5zrk6aB9dr0Vrgj5J5/v/UzU0UGepeoxeHcMwDQgwPfgYsUi5gsRMLFTMMstnoshOiWFKTBpapIEHNUJyJoMrejck/bcWwk3U49WeelxcB80RvliQtfviPMeIgEwBpfLt78zqL1pKRkYqVehJoa1RF6gpjluD6fPCBchVuFaHcy3VGbjWBXgT5EL8k7a0ekeAKEE0VCBdU6xcvbfzs/Qt+JwAlOiokyoZJPZ6iVcpu3eyQ8oCsRkFVwIehCIkUDDwRVY+lPkFXKrKeA2ngerJiGb06fe8jLYGa0WIfjsVndh3csANa/6JoqkrKBO7xZIeU/1d3agezHcRqVYVlVUGVS7eywxqAq9ZKYVU+/II/r5S29Y/Vk8+tlgUceLocf8qR2j3zD8nsGX5o4bO304DU7ZjHfLscfn8s8idLtV0wqy3TJFCwVrSQ0IQbYTaSzFvanQ0xowy5oNQfxxESu82Xxim3HG59NrHQ+q/LOKlOBs44wBnt2xkUtXyCItJOR7hvysnGIbyky7xNrjkbRaa1l5lf2cPTYrNMKOY/nP4EeHuPhPWeX/JaSYIQdTADu365g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F+YBAh+m/9FmjgNW49ESJFGuL6IYUikG8Z/RvhUk5h8BoQmpj8CW/vR0amLD?=
 =?us-ascii?Q?D+ODHVH4pEmQHNN757uFS99vt2rmDtUvo0xK0NUggfujmtgrNlIoTh8Bvls/?=
 =?us-ascii?Q?ou6EtPqP6jIhPy5YIgahaTFVOOKzGSmtHpdXM1j0ASsKZeemOihSybGe+ZLV?=
 =?us-ascii?Q?mrv+rJjRDjYWRPrm3XrmgrUpBqXlqz1H3bfcHKjkl/pH9aZulyIxP7GRWnOz?=
 =?us-ascii?Q?YrT9KinZQLMZH3+7SNN/jibMFJP/PezZ8/wtCVRSYr2VgXT5n1oBcuuLh7OA?=
 =?us-ascii?Q?EDOSblfRxMdouFiVRDWUGXCYxXainfin3Hf/Jg/lfdKfSH6YFuWqXpMB79Ro?=
 =?us-ascii?Q?v2wylY9KzAfZtoXDcADyeHF0lpMIrTxJ6y+SIcKJlp1qQ9zbewDNFDoee68o?=
 =?us-ascii?Q?JFehScNJIfFr3tO6kIjl8s33xCX0xVF8SUY5ZZoMsjduHS9Iz10kU3BAQZl6?=
 =?us-ascii?Q?sGCY0FdmKwFaq5gv2FgMDuOPfpiHSZoHR57lWKRUM1j0SrDJ+Xl5A8EY+URh?=
 =?us-ascii?Q?Gd8wJcjjZ6NbHW9lx3FWyhy8O5prFOfQWbn1cqFGiyrHKRxyvdG78jdT5ErO?=
 =?us-ascii?Q?zgRUaUJM91YSVda+MMyX94s0rVTN+O1sgcDDj0NqTKW+A3zixEDbzY7bH6d7?=
 =?us-ascii?Q?czg1Ach4qxk//6Ct/b72B3dF8JmfsCcTSnf98zrP60BWfuGY0+06t3/bYyGt?=
 =?us-ascii?Q?Ojmhc2JiCV6F65oLu7jJrRYzbcbEXz5zomb04g+BI9MuhyiP9IZqWFtC2OJ4?=
 =?us-ascii?Q?VcZTBtcqKpe2LmZFCG+SHx2WVb9727YtugTVvuWuE+2QHOavQnVFYBCBB5SF?=
 =?us-ascii?Q?6okLA/4AytWx2FUEOONz6nNwZUeX4qnq1/1i4hN+qa+YhLmr3gkCHll9lKTl?=
 =?us-ascii?Q?FzY7EOjDVknODvTj5aU9j1wC5rdLl3Ulajvtn0T2QNQIM0YiJRJ8+mZRzx7n?=
 =?us-ascii?Q?zhT4koL/W9CkgUMznx1wtAj1AATonDu8Ao+qA3nDNBUDurK1flm8d/ECjYwD?=
 =?us-ascii?Q?VahYaPuPlBPd6YfH/oT/vbcZTzq4xiMWl0y73NWZzPM+dLeRR6CS87PKItXH?=
 =?us-ascii?Q?35QcKjo6E67+D6p32wmll1tnAt8lxbXvFAFZKr/jZnRWSZ1Q8X5VaahqWvFJ?=
 =?us-ascii?Q?nzSU6QtEBAVw3bTuEOljgqQPEKt/SCmvCmeRxRFi2RQyYmIlJEqSfvj+76b4?=
 =?us-ascii?Q?vCZSk1E0RhOL9AslwetfOSJ7PEMoSo5lWRMoOIsTFUJ4eqMLYTwWX6uoPh2A?=
 =?us-ascii?Q?B3o6jftJ8XqBh+wos/ji?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4687bce2-cee8-466a-4d24-08dcb37052e5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 03:56:59.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7271

On Fri, Aug 02, 2024 at 08:47:10PM GMT, Guenter Roeck wrote:
> On 8/2/24 16:28, Inochi Amaoto wrote:
> > On Fri, Aug 02, 2024 at 06:59:22AM GMT, Guenter Roeck wrote:
> > > On 8/2/24 05:38, Inochi Amaoto wrote:
> > > > SG2042 use an external MCU to provide basic hardware information
> > > > and thermal sensors.
> > > > 
> > > > Add driver support for the onboard MCU of SG2042.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > Tested-by: Chen Wang <unicorn_wang@outlook.com>
> > > > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > > > ---
> > > >    Documentation/hwmon/index.rst      |   1 +
> > > >    Documentation/hwmon/sg2042-mcu.rst |  39 +++
> > > >    drivers/hwmon/Kconfig              |  11 +
> > > >    drivers/hwmon/Makefile             |   1 +
> > > >    drivers/hwmon/sg2042-mcu.c         | 394 +++++++++++++++++++++++++++++
> > > >    5 files changed, 446 insertions(+)
> > > >    create mode 100644 Documentation/hwmon/sg2042-mcu.rst
> > > >    create mode 100644 drivers/hwmon/sg2042-mcu.c
> > > > 
> > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > index 913c11390a45..ea3b5be8fe4f 100644
> > > > --- a/Documentation/hwmon/index.rst
> > > > +++ b/Documentation/hwmon/index.rst
> > > > @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
> > > >       sch5636
> > > >       scpi-hwmon
> > > >       sfctemp
> > > > +   sg2042-mcu
> > > >       sht15
> > > >       sht21
> > > >       sht3x
> > > > diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> > > > new file mode 100644
> > > > index 000000000000..250016b47dd1
> > > > --- /dev/null
> > > > +++ b/Documentation/hwmon/sg2042-mcu.rst
> > > > @@ -0,0 +1,39 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +Kernel driver sg2042-mcu
> > > > +=====================
> > > > +
> > > > +Supported chips:
> > > > +
> > > > +  * Onboard MCU for sg2042
> > > > +
> > > > +    Addresses scanned: -
> > > > +
> > > > +    Prefix: 'sg2042-mcu'
> > > > +
> > > > +Authors:
> > > > +
> > > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > > +
> > > > +Description
> > > > +-----------
> > > > +
> > > > +This driver supprts hardware monitoring for onboard MCU with
> > > > +i2c interface.
> > > > +
> > > > +Usage Notes
> > > > +-----------
> > > > +
> > > > +This driver does not auto-detect devices. You will have to instantiate
> > > > +the devices explicitly.
> > > > +Please see Documentation/i2c/instantiating-devices.rst for details.
> > > > +
> > > > +Sysfs Attributes
> > > > +----------------
> > > > +
> > > > +================= =============================================
> > > > +temp1_input       Measured temperature of SoC
> > > > +temp1_crit        Critical high temperature
> > > > +temp1_crit_hyst   hysteresis temperature restore from Critical
> > > > +temp2_input       Measured temperature of the base board
> > > > +================= =============================================
> > > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > > index b60fe2e58ad6..7aa6c3f322e5 100644
> > > > --- a/drivers/hwmon/Kconfig
> > > > +++ b/drivers/hwmon/Kconfig
> > > > @@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
> > > >    	  This driver can also be built as a module.  If so, the module
> > > >    	  will be called sfctemp.
> > > > +config SENSORS_SG2042_MCU
> > > > +	tristate "Sophgo onboard MCU support"
> > > > +	depends on I2C
> > > > +	depends on ARCH_SOPHGO || COMPILE_TEST
> > > > +	help
> > > > +	  Support for onboard MCU of Sophgo SG2042 SoCs. This mcu provides
> > > > +	  power control and some basic information.
> > > > +
> > > > +	  This driver can be built as a module. If so, the module
> > > > +	  will be called sg2042-mcu.
> > > > +
> > > >    config SENSORS_SURFACE_FAN
> > > >    	tristate "Surface Fan Driver"
> > > >    	depends on SURFACE_AGGREGATOR
> > > > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > > > index b1c7056c37db..0bbe812a67ae 100644
> > > > --- a/drivers/hwmon/Makefile
> > > > +++ b/drivers/hwmon/Makefile
> > > > @@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
> > > >    obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
> > > >    obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> > > >    obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> > > > +obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
> > > >    obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
> > > >    obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
> > > >    obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> > > > diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
> > > > new file mode 100644
> > > > index 000000000000..6d8d677f86f3
> > > > --- /dev/null
> > > > +++ b/drivers/hwmon/sg2042-mcu.c
> > > > @@ -0,0 +1,394 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > > > + *
> > > > + * Sophgo power control mcu for SG2042
> > > > + */
> > > > +
> > > > +#include <linux/cleanup.h>
> > > > +#include <linux/debugfs.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/hwmon.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mutex.h>
> > > > +
> > > > +/* fixed MCU registers */
> > > > +#define REG_BOARD_TYPE				0x00
> > > > +#define REG_MCU_FIRMWARE_VERSION		0x01
> > > > +#define REG_PCB_VERSION				0x02
> > > > +#define REG_PWR_CTRL				0x03
> > > > +#define REG_SOC_TEMP				0x04
> > > > +#define REG_BOARD_TEMP				0x05
> > > > +#define REG_RST_COUNT				0x0a
> > > > +#define REG_UPTIME				0x0b
> > > > +#define REG_RESET_REASON			0x0d
> > > > +#define REG_MCU_TYPE				0x18
> > > > +#define REG_REPOWER_ACTION			0x65
> > > > +#define REG_CRITICAL_TEMP			0x66
> > > > +#define REG_REPOWER_TEMP			0x67
> > > > +
> > > > +#define REPOWER_ACTION_REBOOT			1
> > > > +#define REPOWER_ACTION_POWEROFF			2
> > > > +
> > > > +#define MCU_POWER_MAX				0xff
> > > > +
> > > > +#define DEFINE_MCU_DEBUG_ATTR(_name, _reg, _format)			\
> > > > +	static int _name##_show(struct seq_file *seqf,			\
> > > > +				    void *unused)			\
> > > > +	{								\
> > > > +		struct sg2042_mcu_data *mcu = seqf->private;		\
> > > > +		int ret;						\
> > > > +		ret = i2c_smbus_read_byte_data(mcu->client, (_reg));	\
> > > > +		if (ret < 0)						\
> > > > +			return ret;					\
> > > > +		seq_printf(seqf, _format "\n", ret);			\
> > > > +		return 0;						\
> > > > +	}								\
> > > > +	DEFINE_SHOW_ATTRIBUTE(_name)					\
> > > > +
> > > > +struct sg2042_mcu_data {
> > > > +	struct i2c_client	*client;
> > > > +	struct dentry		*debugfs;
> > > > +	struct mutex		mutex;
> > > > +};
> > > > +
> > > > +static struct dentry *sgmcu_debugfs;
> > > > +
> > > > +static ssize_t reset_count_show(struct device *dev,
> > > > +				struct device_attribute *attr,
> > > > +				char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RST_COUNT);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return sprintf(buf, "%d\n", ret);
> > > > +}
> > > > +
> > > > +static ssize_t uptime_show(struct device *dev,
> > > > +			   struct device_attribute *attr,
> > > > +			   char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	u8 time_val[2];
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
> > > > +					    sizeof(time_val), time_val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return sprintf(buf, "%d\n",
> > > > +		       (int)(time_val[0]) + (int)(time_val[1] << 8));
> > > 
> > > Pointless type casts
> > > 
> > > > +}
> > > > +
> > > > +static ssize_t reset_reason_show(struct device *dev,
> > > > +				 struct device_attribute *attr,
> > > > +				 char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RESET_REASON);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return sprintf(buf, "0x%02x\n", ret);
> > > > +}
> > > > +
> > > > +static ssize_t repower_action_show(struct device *dev,
> > > > +				   struct device_attribute *attr,
> > > > +				   char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +	const char *action;
> > > > +
> > > > +	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_ACTION);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (ret == REPOWER_ACTION_REBOOT)
> > > > +		action = "reboot";
> > > > +	else if (ret == REPOWER_ACTION_POWEROFF)
> > > > +		action = "poweroff";
> > > > +	else
> > > > +		action = "unknown";
> > > > +
> > > > +	return sprintf(buf, "%s\n", action);
> > > > +}
> > > > +
> > > > +static ssize_t repower_action_store(struct device *dev,
> > > > +				    struct device_attribute *attr,
> > > > +				    const char *buf, size_t count)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	u8 value;
> > > > +	int ret;
> > > > +
> > > > +	if (sysfs_streq("reboot", buf))
> > > > +		value = REPOWER_ACTION_REBOOT;
> > > > +	else if (sysfs_streq("poweroff", buf))
> > > > +		value = REPOWER_ACTION_POWEROFF;
> > > > +	else
> > > > +		return -EINVAL;
> > > > +
> > > > +	guard(mutex)(&mcu->mutex);
> > > > +
> > > Pointless mutex protection.
> > > 
> > 
> > OK, I have seen the protection in the i2c bus. I will remove this.
> > 
> > > > +	ret = i2c_smbus_write_byte_data(mcu->client,
> > > > +					REG_REPOWER_ACTION, value);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return count;
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RO(reset_count);
> > > > +static DEVICE_ATTR_RO(uptime);
> > > > +static DEVICE_ATTR_RO(reset_reason);
> > > > +static DEVICE_ATTR_RW(repower_action);
> > > > +
> > > > +DEFINE_MCU_DEBUG_ATTR(firmware_version, REG_MCU_FIRMWARE_VERSION, "0x%02x");
> > > > +DEFINE_MCU_DEBUG_ATTR(pcb_version, REG_PCB_VERSION, "0x%02x");
> > > > +DEFINE_MCU_DEBUG_ATTR(board_type, REG_BOARD_TYPE, "0x%02x");
> > > > +DEFINE_MCU_DEBUG_ATTR(mcu_type, REG_MCU_TYPE, "%d");
> > > > +
> > > > +static struct attribute *sg2042_mcu_attrs[] = {
> > > > +	&dev_attr_reset_count.attr,
> > > > +	&dev_attr_uptime.attr,
> > > > +	&dev_attr_reset_reason.attr,
> > > > +	&dev_attr_repower_action.attr,
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group sg2042_mcu_attr_group = {
> > > > +	.attrs	= sg2042_mcu_attrs,
> > > > +};
> > > > +
> > > > +static const struct attribute_group *sg2042_mcu_groups[] = {
> > > > +	&sg2042_mcu_attr_group,
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> > > > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> > > > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> > > > +					HWMON_T_CRIT_HYST,
> > > > +				 HWMON_T_INPUT),
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static int sg2042_mcu_read(struct device *dev,
> > > > +			   enum hwmon_sensor_types type,
> > > > +			   u32 attr, int channel, long *val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int tmp;
> > > > +	u8 reg;
> > > > +
> > > > +	switch (attr) {
> > > > +	case hwmon_temp_input:
> > > > +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit:
> > > > +		reg = REG_CRITICAL_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit_hyst:
> > > > +		reg = REG_REPOWER_TEMP;
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> > > > +	if (tmp < 0)
> > > > +		return tmp;
> > > > +	*val = tmp * 1000;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_write(struct device *dev,
> > > > +			    enum hwmon_sensor_types type,
> > > > +			    u32 attr, int channel, long val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int temp = val / 1000;
> > > > +	int hyst_temp, crit_temp;
> > > > +	u8 reg;
> > > > +
> > > > +	if (temp > MCU_POWER_MAX)
> > > > +		temp = MCU_POWER_MAX;
> > > > +	else if (temp < 0)
> > > > +		temp = 0;
> > > > +
> > > 	temp = clamp_val(temp, 0, MCU_POWER_MAX);
> > > 
> > > > +	guard(mutex)(&mcu->mutex);
> > > > +
> > > > +	switch (attr) {
> > > > +	case hwmon_temp_crit:
> > > > +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> > > > +						     REG_REPOWER_TEMP);
> > > > +		if (hyst_temp < 0)
> > > > +			return hyst_temp;
> > > > +
> > > > +		crit_temp = temp;
> > > > +		reg = REG_CRITICAL_TEMP;
> > > > +		break;
> > > > +	case hwmon_temp_crit_hyst:
> > > > +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> > > > +						     REG_CRITICAL_TEMP);
> > > > +		if (crit_temp < 0)
> > > > +			return crit_temp;
> > > > +
> > > > +		hyst_temp = temp;
> > > > +		reg = REG_REPOWER_TEMP;
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * ensure hyst_temp is smaller to avoid MCU from
> > > > +	 * keeping triggering repower event.
> > > > +	 */
> > > > +	if (crit_temp < hyst_temp)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return i2c_smbus_write_byte_data(mcu->client, reg, temp);
> > > > +}
> > > > +
> > > > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > > > +				     enum hwmon_sensor_types type,
> > > > +				     u32 attr, int channel)
> > > > +{
> > > > +	switch (type) {
> > > > +	case hwmon_temp:
> > > > +		switch (attr) {
> > > > +		case hwmon_temp_input:
> > > > +			return 0444;
> > > > +		case hwmon_temp_crit:
> > > > +		case hwmon_temp_crit_hyst:
> > > > +			if (channel == 0)
> > > > +				return 0664;
> > > > +			break;
> > > 
> > > In practice this is the only break; in this nested switch sequence,
> > > making the return 0; at the end necessary.
> > > 
> > > Please either use break; always when returning 0, or return 0 here
> > > as well and drop the final return 0;
> > > 
> > 
> > Thanks, but I have a question: as this break can be fallthrough to the
> > default, is it better to use break;/return 0;, or just remove this
> > break; and let it fallthrough?
> > 
> 
> Either always use break; when returning 0 or always use "return 0;".
> Please don't rely on fallthrough; it doesn't improve anything since you'd
> have to tag it as fallthrough and you might then as well use break;
> or return 0; directly.
> 
> Guenter
> 

Thanks.

Regards,
Inochi.

> > > > +		default:
> > > > +			return 0;
> > > > +		}
> > > > +		break;
> > > > +	default:
> > > > +		return 0;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct hwmon_ops sg2042_mcu_ops = {
> > > > +	.is_visible = sg2042_mcu_is_visible,
> > > > +	.read = sg2042_mcu_read,
> > > > +	.write = sg2042_mcu_write,
> > > > +};
> > > > +
> > > > +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> > > > +	.ops = &sg2042_mcu_ops,
> > > > +	.info = sg2042_mcu_info,
> > > > +};
> > > > +
> > > > +static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
> > > > +				    struct device *dev)
> > > > +{
> > > > +	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
> > > > +	if (mcu->debugfs) {
> > > 
> > > debugfs_create_dir() returns an ERR_PTR(), which is checked in debugfs_create_file().
> > > This if() is pointless.
> > > 
> > 
> > Thanks.
> > 
> > > > +		debugfs_create_file("firmware_version", 0444, mcu->debugfs,
> > > > +				    mcu, &firmware_version_fops);
> > > > +		debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
> > > > +				    &pcb_version_fops);
> > > > +		debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
> > > > +				    &mcu_type_fops);
> > > > +		debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
> > > > +				    &board_type_fops);
> > > > +	}
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > > > +{
> > > > +	struct device *dev = &client->dev;
> > > > +	struct sg2042_mcu_data *mcu;
> > > > +	struct device *hwmon_dev;
> > > > +
> > > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > > > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > > > +		return -EIO;
> > > > +
> > > 		return -ENODEV;
> > > 
> > > > +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > > > +	if (!mcu)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	mutex_init(&mcu->mutex);
> > > > +	mcu->client = client;
> > > > +
> > > > +	i2c_set_clientdata(client, mcu);
> > > > +
> > > > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sg2042_mcu",
> > > > +							 mcu,
> > > > +							 &sg2042_mcu_chip_info,
> > > > +							 NULL);
> > > > +	if (IS_ERR_OR_NULL(hwmon_dev))
> > > > +		return -EFAULT;
> > > 
> > > devm_hwmon_device_register_with_info() returns an ERR_PTR(), and
> > > returning -EFAULT instead of it is more than wrong (this does not indicate
> > > a "bad address"). This needs to be
> > > 
> > > 	if (IS_ERR(hwmon_dev))
> > > 		return PTR_ERR(hwmon_dev);
> > > 
> > > I am sure I asked before not to overwrite error codes.
> > 
> > Yes, you have asked, it seems that I have missed this code when I
> > check the driver. I apology for this mistake and thanks for your
> > reminder.
> > 
> > > 
> > > > +
> > > > +	sg2042_mcu_debugfs_init(mcu, dev);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = i2c_get_clientdata(client);
> > > > +
> > > > +	debugfs_remove_recursive(mcu->debugfs);
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id sg2042_mcu_id[] = {
> > > > +	{ "sg2042-hwmon-mcu", 0 },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > > > +
> > > > +static const struct of_device_id sg2042_mcu_of_id[] = {
> > > > +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > > > +
> > > > +static struct i2c_driver sg2042_mcu_driver = {
> > > > +	.driver = {
> > > > +		.name = "sg2042-mcu",
> > > > +		.of_match_table = sg2042_mcu_of_id,
> > > > +		.dev_groups = sg2042_mcu_groups,
> > > > +	},
> > > > +	.probe = sg2042_mcu_i2c_probe,
> > > > +	.remove = sg2042_mcu_i2c_remove,
> > > > +	.id_table = sg2042_mcu_id,
> > > > +};
> > > > +
> > > > +static int __init sg2042_mcu_init(void)
> > > > +{
> > > > +	sgmcu_debugfs = debugfs_create_dir("sg2042-mcu", NULL);
> > > > +	return i2c_add_driver(&sg2042_mcu_driver);
> > > > +}
> > > > +
> > > > +static void __exit sg2042_mcu_exit(void)
> > > > +{
> > > > +	debugfs_remove_recursive(sgmcu_debugfs);
> > > > +	i2c_del_driver(&sg2042_mcu_driver);
> > > > +}
> > > > +
> > > > +module_init(sg2042_mcu_init);
> > > > +module_exit(sg2042_mcu_exit);
> > > > +
> > > > +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> > > > +MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
> > > > +MODULE_LICENSE("GPL");
> > > 
> 


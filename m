Return-Path: <linux-kernel+bounces-285692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3C951164
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41531F23AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EBD304;
	Wed, 14 Aug 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z+K83t1l"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2073.outbound.protection.outlook.com [40.92.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FE23AB;
	Wed, 14 Aug 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597655; cv=fail; b=XdOFRpY9LPo2aorWRn+3HRG+WuyyutFRYBOPhjmo/nT6b+PUyYjTGjCfrzlaKxztoV8cBZO0E6Tv1uGGO6EbgP4HH0od9Ue1SlgnsXRVuWkWsfRzIbG9xG05A8xLzrKjpTbZS8wXUq/Q/DURgbPin04r4FMDeDWMOGojgkRt7jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597655; c=relaxed/simple;
	bh=/IWkOyd5Wz/xniQOLVTuUuaU+Gb7PW91wADKa/WKtEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DORnLma6AG/f0ZCwtTnU0gjRbQBJ/v1+8TFdAUa0ArNZx3wfz0Xrj0YctFM2ZvHRnChNPscy2OlSUNjsYnpSalMyEUKRkcgAJxMQEld2UAQYXOJq6ZYxmhzoJGRF3YYWkoquPx8EpOFoIpb/LTifGw1OJ0A9SjZ8oCGTEmcbUck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z+K83t1l; arc=fail smtp.client-ip=40.92.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLNtHd2Fr7YvQvXFC/jJ4ISTh8vZ/xXY2hKvZkBqs5gLKjYANVl8XS5iBhDLGMYRGwmDG6T8y1r5lnlLrIyEWLiA2HKSuoVYSv/dXmQ5d3iZhXZI/TwulUvny7ONXz04jkTw422hakKKUEuQvxTeUqWWaxWju4J/ofeV3c+jLdA4YQjY3uCScKdylUrB/lvKl7e7/iSQ+EP1jm6esy30k3tlXCB9Y1MR0lO9WXIh8OLTz3XzrHNDjqFuVJ5Ds5LflJjxrEz9dr/WikGYgulMz3OjmTdKlOTds+oZwl5zjsVFgqVJNvtPNDdRL49pXPdgCtU8gWnPHl3qtBC3HCWD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/CCAq4mtsaMmxBErVkkmFuQZwi+gHD26Yxjbvy+rbc=;
 b=Po07KjoDczPMN78X2BDvWGqvfmrkC8fuqO72UOafMJyMktr0DjX9odN+GZYpyK9uVzIa33BRHuQuo18mHa6uFU4iDzFE9C14CJ7exRlb0z4NS3EZlmtB+fQ1E0x9BhwMbslG+n+K/TI2RQUXMIi2/JBLj2AMjSMbMUCPj9cGWLvPh57BKg4VPFfApNzyjChTIFLfCY7kUW/HM6tHrFz4PaWNqRMy4Tcl7dMgPUNTeBNtP94K1kAWFJbGNZHxEYkA2zgzYUuDP8Yo9SDCDmTqsDTGu1cAF4yWi7RB6I1wGUrDQ+Vt967solFQjQhBqBnTZsEy9qwCHPeS8lNMuNoKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/CCAq4mtsaMmxBErVkkmFuQZwi+gHD26Yxjbvy+rbc=;
 b=Z+K83t1lMo3gWaZbz8d84SMrxWUtyWnyDKINjnWQguG/wE9HJJyDH/JmUhoub9u97wp0d/vLZ8m2I+17AkqHN5W8WqWncWpkHAdcPSqv8VQryEiMPDE7gN6PZTeo/oMsMgjmQen5GLOE7Nxt9Uh7ICwEn5PHys30P/Fwwzs+W+YusRTeJf1vnjDUjJqJVJraW1VVd2ZgKyTenf4mOydznrkzqUQbcQmSgezraUGDlNk5WFUUnIz+FotWVxGyAsSewyk9bZMAeJggdrby4zA0kv1434JzAvtg6x2Ae8mZ1MELmudnMXUF7uT2T0U7n1geMIRn+EuI/64lqLzUBETqfw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB4535.namprd20.prod.outlook.com (2603:10b6:a03:3ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 01:07:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 01:07:27 +0000
Date: Wed, 14 Aug 2024 09:06:41 +0800
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
 <IA1PR20MB49536A2A4E6F881059461905BB872@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <0e30eab7-e202-4639-863d-85ce28525714@roeck-us.net>
 <IA1PR20MB495356094952242D9CD8A249BB872@IA1PR20MB4953.namprd20.prod.outlook.com>
 <d501bed8-ed06-41aa-b628-37ccd1bbb802@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d501bed8-ed06-41aa-b628-37ccd1bbb802@roeck-us.net>
X-TMN: [2LYm5BSi3x3/W0ekZ+HeYtlNuJWACdKbZbBWse5ThbE=]
X-ClientProxiedBy: TY1PR01CA0200.jpnprd01.prod.outlook.com (2603:1096:403::30)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <lnoayu6mix7cxyam4bmvivqocmhd4bqbk6l2w4gimjzaosb5n4@a62atv24yrfh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: 925feb53-02a3-437c-04a2-08dcbbfd768c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799003|19110799003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	gp97T4VsyyVdYnXZSqOk+/SL9SAMejIaWVFXcHXnUz9xtREyRAt97Zk+Amax1YOAxeMzw4lsiU+KeTe6GJGSc2OfYNUNJORIoNEkypLAE5turIz7Ag84YF2xF/rSa6HNvftLx4ZR5FhxdVZolz3OSfR9X+6v8oN9kFi9Adbu5IbvhQhGtL16ght/z2yze0QX6NqT0dfUK7bTIDpGs6f04QPocvihBAo+kfA2WRmsQbywexjPl/R9zQ68mnFbwX7cHAq3HheAid2cM842XQNkvG2LLyClUtoj72LyfyWY9d8sTH4sjEt2MHzvXoMRRAzpn+xdkqWZubWi9jhEbzypgW+D7CXMMk2pZlBRe/z1eZQzq15pxHg9tErmDf8N82+0URC8WlcDA+94Cxo9oK5/0qOX7oJbuNoc0jsEwc+2IjEXKeNZFkK0xGH8K2VTXeK37pOz1D4OZbObASsQYBhyG4szIDeqZ1HNOnq6j93j72bvk3WPa4t1B+0jIWnm2teT30/ZQNWNbeXUOW85qIxHLRjNCq3twgPvhaswduENtMTVCPVODRXLl8c0jCt2RFHP4AW1UMdRNe3lAT4YG6qwfT25eYktpqZvEdXWohTuVXi7/fCuMuYGVYnvBnVPJ/OCrRrr60nSjvs8XOfAOt+u0iHW2ovLcC/ZfTSRLMMwOv6jZ/M4kWw4uGSbeuGcxrrR5jUgiYUjfc5wzfkNdxqCllq1NB8Zz4sFW9GFai9qaw4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErhbJG30zUVcaqQVZwF8Bsz4nw0CYYsfjKsVxb6b37zOqFYC5ga84vSKpgh4?=
 =?us-ascii?Q?ZaVwYDqksODlASxUS7KCpytmvip1GEvX/8F8p/3R4p+/2hqgXA54g1IveqbN?=
 =?us-ascii?Q?hdgnce7AcbYTiu47KSWjZjbzwQc2pCoqcCye04PcQ0xrWSUfP9yUkVQz84wF?=
 =?us-ascii?Q?Gin/xRustp2SqNAIzJHLtWR9OaBtkJmp9rwSAhVL9JbfI5Bru/z9nU7yJaHa?=
 =?us-ascii?Q?FH0G4TzF76Ldcxdhd8p/xZFsuBK+5mOFXwbO0nEYSU82c2x4WOMi9pKmRXPV?=
 =?us-ascii?Q?RpqSAYyBsrmWE2y6/dhij2wVTffzdUh5vW9/2n1dShODmh447GOKlOOZdb5S?=
 =?us-ascii?Q?8xa0y77QVN8F3X07i0iiu2gFsWzgBi95Z5s4TMsFHNQl+n9JWwaAk1ggob5R?=
 =?us-ascii?Q?lruHeaha2XLFi3536iEvzXL31S3YUqcq9xrKRyLv17o56CTZMks3bG+SxzXu?=
 =?us-ascii?Q?3V70ynORk4W6BtqD+tRuNF8FyCaa+Lst2kE+4z9LpBy603TRQMXOhM+BDWUp?=
 =?us-ascii?Q?/De/Jhs/8C3qIOtxFjCD/sNAR0mXzYa1djBV2C+fFVFfK98czTxTVgZd+Qye?=
 =?us-ascii?Q?Ny1bZN+4/IxE2qqauuzhsmZ0sS7sZpv65g6FXu8uLtt33T2Dv6/yM5VUoAAn?=
 =?us-ascii?Q?2TOKy7oFrpB7EV1EXhPjmyVK/WruzmQGcPekFrtQ8BJ7L1pXtvYlwZa+ZCzV?=
 =?us-ascii?Q?gUY7JY+zbKR/fw0rGR9ISqpg/ctJ1CyKOZYe5zF302/WRWY7FElCTgVZWf9f?=
 =?us-ascii?Q?qZTeXjkVJQIKppG2bh2STZKFRhC+CipSoNj1Y6uXHkxVZ8RF3t5cJLXppgU3?=
 =?us-ascii?Q?occcs9vET5VPCsxT29U66BkXhTYPqBIUFUJkig57BvZFEnb+ZtBXABMH0PNH?=
 =?us-ascii?Q?F6ZnLzEMd1W527Vdo31qJayVKsYvZ3R2/Ab5QT/Y5twU1QrzaDmDCX8IAVv+?=
 =?us-ascii?Q?JR0tIGd6eP5qOBe8galY6l/1D6rJepsBAl6W4OqTiWXtYg85AZiHwhsZ4W5y?=
 =?us-ascii?Q?/r9uD8EzVtpfSHdS1IQWutOjlIQE2ygEwSb6T+Ms9RTLsvVOK6TmH8mXpq5d?=
 =?us-ascii?Q?twKYv5sG1Tw6+pU3dL/Mb1hTqtC2T7M5fCLcGYqr4AYO9XGdMSVL8JSsmEoS?=
 =?us-ascii?Q?BTWDmtHb5NgekboARS+jMoSvqeTvvWnHFim4mVpRUKTgd8QHgkrnKbrd9ZLP?=
 =?us-ascii?Q?LkkJBFS41blXzBAWYAbo9ODPPu6sf9PvwUmCA8UH3dAENBNQxd9LWCbmrSVl?=
 =?us-ascii?Q?VOCs+YWgh22tYmUka3fC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925feb53-02a3-437c-04a2-08dcbbfd768c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 01:07:27.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4535

On Tue, Aug 13, 2024 at 05:51:05PM GMT, Guenter Roeck wrote:
> On 8/13/24 17:40, Inochi Amaoto wrote:
> > On Tue, Aug 13, 2024 at 11:27:11AM GMT, Guenter Roeck wrote:
> > > On Sat, Aug 10, 2024 at 04:03:51PM +0800, Inochi Amaoto wrote:
> > > > SG2042 use an external MCU to provide basic hardware information
> > > > and thermal sensors.
> > > > 
> > > > Add driver support for the onboard MCU of SG2042.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > Tested-by: Chen Wang <unicorn_wang@outlook.com>
> > > > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > > > ---
> > > >   Documentation/hwmon/index.rst      |   1 +
> > > >   Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
> > > >   drivers/hwmon/Kconfig              |  11 +
> > > >   drivers/hwmon/Makefile             |   1 +
> > > >   drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
> > > >   5 files changed, 478 insertions(+)
> > > >   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
> > > >   create mode 100644 drivers/hwmon/sg2042-mcu.c
> > > > 
> > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > index 913c11390a45..ea3b5be8fe4f 100644
> > > > --- a/Documentation/hwmon/index.rst
> > > > +++ b/Documentation/hwmon/index.rst
> > > > @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
> > > >      sch5636
> > > >      scpi-hwmon
> > > >      sfctemp
> > > > +   sg2042-mcu
> > > >      sht15
> > > >      sht21
> > > >      sht3x
> > > > diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> > > > new file mode 100644
> > > > index 000000000000..18a3578ac213
> > > > --- /dev/null
> > > > +++ b/Documentation/hwmon/sg2042-mcu.rst
> > > > @@ -0,0 +1,77 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +Kernel driver sg2042-mcu
> > > > +========================
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
> > > > +The following table shows the standard entries support by the driver:
> > > > +
> > > > +================= =====================================================
> > > > +Name              Description
> > > > +================= =====================================================
> > > > +temp1_input       Measured temperature of SoC
> > > > +temp1_crit        Critical high temperature
> > > > +temp1_crit_hyst   hysteresis temperature restore from Critical
> > > > +temp2_input       Measured temperature of the base board
> > > > +================= =====================================================
> > > > +
> > > > +The following table shows the extra entries support by the platform:
> > > > +
> > > 
> > > Those are attached to the i2c device, which should be mentioned.
> > 
> > I have mentioned this in the Description. Does this need to be
> > mentioned here again?
> > 
> 
> Here is where it is needed.
> 
> Guenter
> 

OK, thanks.

Regard,
Inochi


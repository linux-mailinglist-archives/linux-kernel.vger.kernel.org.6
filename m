Return-Path: <linux-kernel+bounces-243766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0C929A58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 02:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6269F281067
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA81109;
	Mon,  8 Jul 2024 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m0R9v5Zv"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2082.outbound.protection.outlook.com [40.92.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8A6365;
	Mon,  8 Jul 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720398377; cv=fail; b=Wp5rrf6rPVI3eiGt21Ohy2Skgw8ldLILZ3hytiDgsXoo8zsi3gzH6p+2vbTc2CO+sNpt6HkhrU4y6Xaj1aUvf+1uAoV6S/Nza5pmWLXjZTyUN3aPfr+Js0+aL+Wvk5Y7gW+sR+frJU4nbp8szD9czD1g9YAFmzAMuahDwBvGrh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720398377; c=relaxed/simple;
	bh=sOK4HSVO4HOzVZTNRjD++Z57TnRCb5SlY4gmn1oSGiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fd5cHpcaCRH1SyszTSZRj63e3eWiI2xz+omgL52tWfbIXTD6f97c0ISBdks5WRPQNLYlbp3VuY4qKXzz3p0pGmUfd7icFNaGUj/3IUlh6LryhM3gl71gDXxBh5g0iuBgVdsOc3g9/COgFzI3oYl7UmF7ceJfvUsd6CTif0zPa0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m0R9v5Zv; arc=fail smtp.client-ip=40.92.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egQsAH5MYri7O0tVbfy6NTRnaMxCUyV1EJtWavmi0jkWkanwdPw2uGKlYOK+YBti3Mfb8Z7lCjS+LyYK2kZby0/aGz+Wc+dXwnCntcZcL1zsvrwAPHOhMWUPtoy0jpUvmLOk6yVHQ8bfDhYYdB+a84zHfU6gq2NtTkVvGNwdJ19E1o6cm5mubbQKXau0r11QRNYypBr9blrFwrovu10Mbw1KbJEXJOTzEN0u4Hho4AnSYOkZU87SHBVtwE053QW6w35w50i/AnvrhtOQKpZiwVvSYL972WhfjNrPq9qCJRBv/m/hQKnUBe5RhS3NWtWVk0dEO4VfhPHUF038XUYrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upmYSeavjK4SIMyWGP3qWEoQnHfUuQmze9tXDb7FJW4=;
 b=IXG6WtF81v+Te2mVAyArsEtainYDTo0FryQ/VGM6VC2KnroWOLg9PoUt9NEeoR26U7rlBxOpy58SnAbQWzGiKbXb4lwpfIyBV/angmm9Ycqa5QYNJuace/T10xQTxDCyWk4nVVH2hFxUJZFTFBNy14+65d3NQKemEioM9WsqW5wlAM17z+TKXt6tmRO7fu3p7i7RjbVIUQ9ZhqWvMyAI70JrWKSZLT/PZt9arNy+Diwk01ru5oR/uSEQNOGBFnRpneWazT6S5Gn+9ipaaf/i7tRmR6zuDT//0JEq6+LWxJMwzylaqJWa96MMG/dEO+jcKdqpXGcKkQHZp6d85zaAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upmYSeavjK4SIMyWGP3qWEoQnHfUuQmze9tXDb7FJW4=;
 b=m0R9v5ZvCjhg1dfZ4LPU+xlKCITQ+bKlAU3FzeldT7BnaNu+6aaaJ8Mzt/4DWkeIwHjsn6TnaFDxatldV/MIfyyt54wvHWr6ZWUeQmZan+i5GQhSnVZAgIbSA/iqZC6+qlchetewGLmYbBpbpl5nrbgCQ26ro3rX9UXAOTc95Dk9dBQ8m4KANiwqvQJ1PnsdwEhu514pPFUxsdr281p3yZUn1GM8yiNW5+beOYAdk779XN4+w/O36uMMZ0ManBbpMiAXHA1rDqvMr88ROQ9cXbw8PMuA52T54emjBhT/weRaRjj29TackD8dQftHqGCBII22zDFFvp/QEZ5h9BNJQQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0653.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:162::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 00:26:07 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 00:26:07 +0000
Message-ID:
 <MA0P287MB2822935DEA9EE418F3411CFAFEDA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 8 Jul 2024 08:25:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB4953967EA6AF3A6EFAE6AB10BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953EC4C486B8D4B186BB848BBDD2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [JMoqFQ/e/yIZGNIKhthL7ocupKX2TlOF]
X-ClientProxiedBy: TYXPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:403:a::31) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <5a41ac32-6660-4c0f-94c7-7097d9953b38@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0653:EE_
X-MS-Office365-Filtering-Correlation-Id: 13abe859-2f39-4c62-b1d9-08dc9ee48da1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	zesxG79x3aP7nOQ8ZVP31h2dMD6hXvOHSZv+WThNnL26LC5uVNG/ou4AtPOHZtzLDqTc82qTYtxpbn81IxYPLZKQPtHpadwzk81EQEJEMnLMuPmzp74YG/GazUH3Ok/loIXvysMkQE+YAD5lvKY0daM/WR+W+N710N3U3JnSB10gpUnAOH1GBVYKVes3wt8nvP5U822DIhcb3qhaw84Ivi17YBoc6eUh/vwHUessJqCWflOfAdWBuL+VEroWR/4VvKGxP4mtS+0lA/M8sa8kthXPUTRIjhnn63zjBez/8pVx5J5j+JuUwtFYsQ7WWoCkFlbDAFiMK3/ceAdngJebSYC1EkK9+eP2TNXvQfdmrnWN71nCfuwttqgELcPpwkhrqdGxoJwGBI4/MEeb+J3aEIkYEJMxMIvLtkFZCzQetZuOUDlZKPBDgXeNbxUJ430w2Uu0K/M7YbeDrmYJKd22JA+PhxPxfPZvyOrqx03RsAH5UyCKb/XeZlz9kW5saakeLe3TksoevoMXu5N8S+Egk1MCSkg1D6VIWVWXP9cTP5pFFfkdfMo1QB9QiaL+k0vKUQntfO5V0FVYDvR+9o2nr2SSCDxJqJFJQ3xk6w2D3bEdLH+k5xL4bjOpjS+jka0YYXRjOg1PYynzO7v+9XlcGA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENOU2NtZGdxNmRtRlh5bDh4bGhiYnlkREtHY1dSbndoeFNpdkJDMys4K1VY?=
 =?utf-8?B?bHBuN3ZOTDg1cy9lTFMzSS9hcWptK3NUSU9EMGxOODl5OUhLOE5iQ2tTaFJl?=
 =?utf-8?B?dXBlOUpsWS9BTjlFTHNZcjdMY1R5QTFTZmZCTHBBU1BnSElDazA2a1hLRnFh?=
 =?utf-8?B?RjBVelJXNFowcEJMZC9XMy9sbkFrTGRYYjNaRGNCYnU5ZUtkaHZTOUdxcGRW?=
 =?utf-8?B?bkl1K3drVHV3V1BCMEJXb3RkWTRrNmtaMW1xOWVSelErRFh6d29WYitPdGJr?=
 =?utf-8?B?T1J5QUpoZElSazRPdUpqcDVFWlk4dU5HZWtnODJETWNudms3Z0Y0cytrZTVS?=
 =?utf-8?B?QVArQ2llbzJ3OWxoRDB6b0NQVW85ZHErM3NncVlvUzNyb0VhSzU2N3pKRHlB?=
 =?utf-8?B?eWZoVUttS3JqN2RZeFRoQzBDV0RFeEZFcHNOTFFqWnNYajRJM2pCQ3E4WmVT?=
 =?utf-8?B?TGlYdWR2b2ZMK3hNcVQ1YUQ1bll3NXB0Uk8wdEhaRjl2ZVBBdld2S2J0RFh5?=
 =?utf-8?B?R2hwclJwZ2hJaTlxTTRycDJqeHpUZWJVT3dYZDdKaWRnQ2lmdUZLaG0zSmQ3?=
 =?utf-8?B?R29ST0Z3eTNyZG9qSFlaanJmY2FaVkNYdlZzcXhLYUI4cEV2NUNvcURlYkli?=
 =?utf-8?B?d1RoSGgyMlBWMXJMait1YjgzMDYvcVdGQWJSZnFMa1hidFF1TTgxZENiYStJ?=
 =?utf-8?B?NGNmelZseHJUZllNOEJRMnB0TjNuWWNuT1drZ2xNS1VuNXVyM1h2c3FsaTRk?=
 =?utf-8?B?YndUcVRPV2xNQ25pUWNpU1VLSDhtSDA3MGxmMWt4NUlZZzAyZEtXYW81Nkcw?=
 =?utf-8?B?eFhyOWQ2OWpiNFJ6YVlxaFRhUW83eVNtV1N3MDZzcDZ0NlhQN0dtZHFpVnpp?=
 =?utf-8?B?MkFIaTI4T1ZHa096K0ttWXhQV09kVTQvZHdxcmsvZ1FQNGdqN21EeHVNYndH?=
 =?utf-8?B?Y0ZVYXBLK0tma29MeDI1L25CWVRUVWg1bzFNeXVmSzN4ZHhQcXF0dFZjdEFH?=
 =?utf-8?B?a09GbU8xR242YWViUUtEWmMrUVRkelYrWnZ1Nk9hcWlyZGZ0bVRFWktpek91?=
 =?utf-8?B?dEFMRm9PV0ZQcWFpbFBqK05CZUkxK3BuWVh1MVJjaDh3Uks3NDc0MUJ5SXZP?=
 =?utf-8?B?WDVSWE80ck9paThDWE1adzllOXV4d0ltZGFCS0xOQkloVFN4dS9UeEwybnBZ?=
 =?utf-8?B?cmMxdXZMVkxCZy9hM09oSEZUTXd1YjBxWlBjOE90MlRqamlKQ25UcFBkZEpq?=
 =?utf-8?B?alFnTjBVZlQ2dENWcUhkUzlYUWEwcCtXand3enZsOGtQUlAvMm4zbTllQlF3?=
 =?utf-8?B?aGQ2am5JeWl0dGY3aEk4azVyc2dxKzI2N1duRU5jMFAyMHBTRDhpbEpPMnJ5?=
 =?utf-8?B?VXUzd1RGcGZSTlBrUEVvelJ3dVJPQmZycFRIRnZWcVY2SHRoWWVZN1NGaDln?=
 =?utf-8?B?bldUUS96TjBuRVpNdFZNVFRvTFlzT3RlbUhTN245VW5YM0h2VUNrQkNxMVg3?=
 =?utf-8?B?RnArdW50UkhibjIrV2FXSjM0UitIZGh0VTFmTjltV1RvVE1DdW9WQ2lydnBm?=
 =?utf-8?B?OFRMb25QaWRqMU93K013b1VuZWx0WktScXlVUXQxMUMrSDIzUUpJQ05UQUJO?=
 =?utf-8?B?bHpnUHJxckFMckdPcTB0dVQ3ZzFBWk5saEhKQktnWDZVclFVcm9VN0lCNUVn?=
 =?utf-8?Q?M9CMuKCbNnfSpZqJFd7P?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13abe859-2f39-4c62-b1d9-08dc9ee48da1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 00:26:06.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0653


On 2024/7/3 10:30, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
>
> Add driver support for the onboard MCU of SG2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   Documentation/hwmon/index.rst |   1 +
>   Documentation/hwmon/sgmcu.rst |  44 +++
>   drivers/hwmon/Kconfig         |  11 +
>   drivers/hwmon/Makefile        |   1 +
>   drivers/hwmon/sgmcu.c         | 585 ++++++++++++++++++++++++++++++++++
>   5 files changed, 642 insertions(+)
>   create mode 100644 Documentation/hwmon/sgmcu.rst
>   create mode 100644 drivers/hwmon/sgmcu.c
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 03d313af469a..189626b3a055 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -203,6 +203,7 @@ Hardware Monitoring Kernel Drivers
>      sch5636
>      scpi-hwmon
>      sfctemp
> +   sgmcu
This driver is for sg2042 only, right? "sgmcu" looks be general for all 
sophgo products.
>      sht15
>      sht21
>      sht3x
> diff --git a/Documentation/hwmon/sgmcu.rst b/Documentation/hwmon/sgmcu.rst
> new file mode 100644
> index 000000000000..5669dcfb2a33
> --- /dev/null
> +++ b/Documentation/hwmon/sgmcu.rst
Same question as upon.
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sgmcu
> +=====================
> +
> +Supported chips:
> +
> +  * Onboard MCU for sg2042
> +
> +    Addresses scanned: -
> +
> +    Prefix: 'sgmcu'
Same question as upon.
> +
> +Authors:
> +
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +Description
> +-----------
> +
> +This driver supprts hardware monitoring for onboard MCU with
> +PMBus interface.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate
> +the devices explicitly.
> +Please see Documentation/i2c/instantiating-devices.rst for details.
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +Sysfs Attributes
> +----------------
> +
> +================= =============================================
> +temp1_input       Measured temperature of SoC
> +temp1_crit        Critical high temperature
> +temp1_crit_hyst   hysteresis temperature restore from Critical
> +temp2_input       Measured temperature of the base board
> +================= =============================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e14ae18a973b..1100dd11f7f5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2079,6 +2079,17 @@ config SENSORS_SFCTEMP
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called sfctemp.
>
> +config SENSORS_SGMCU
Same question as upon.
> +	tristate "Sophgo onboard MCU support"
Same question as upon.
> +	depends on I2C
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Support for onboard MCU of Sophgo SoCs. This mcu provides power
> +	  control and some basic information.
> +
> +	  This driver can be built as a module. If so, the module
> +	  will be called sgmcu.
> +
>   config SENSORS_SURFACE_FAN
>   	tristate "Surface Fan Driver"
>   	depends on SURFACE_AGGREGATOR
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e3f25475d1f0..e9b78ff8338e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -195,6 +195,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>   obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>   obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> +obj-$(CONFIG_SENSORS_SGMCU)	+= sgmcu.o
Same question as upon.
>   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> diff --git a/drivers/hwmon/sgmcu.c b/drivers/hwmon/sgmcu.c
> new file mode 100644
> index 000000000000..d941d6fe741f
> --- /dev/null
> +++ b/drivers/hwmon/sgmcu.c
Same question as upon.
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> + *
> + * Sophgo power control mcu for SG2042
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +
> +/* fixed MCU registers */
> +#define REG_BOARD_TYPE				0x00
> +#define REG_MCU_FIRMWARE_VERSION		0x01
> +#define REG_PCB_VERSION				0x02
> +#define REG_PWR_CTRL				0x03
> +#define REG_SOC_TEMP				0x04
> +#define REG_BOARD_TEMP				0x05
> +#define REG_RST_COUNT				0x0a
> +#define REG_UPTIME				0x0b
> +#define REG_RESET_REASON			0x0d
> +#define REG_MCU_TYPE				0x18
> +#define REG_CRITICAL_ACTIONS			0x65
> +#define REG_CRITICAL_TEMP			0x66
> +#define REG_REPOWER_TEMP			0x67
> +
> +#define CRITICAL_ACTION_REBOOT			0x1
> +#define CRITICAL_ACTION_POWEROFF		0x2
> +
> +#define DEFAULT_REPOWER_TEMP			60
> +#define MAX_REPOWER_TEMP			100
> +
> +#define sg2042_mcu_read_byte(client, reg)			\
> +	i2c_smbus_read_byte_data(client, reg)
> +#define sg2042_mcu_write_byte(client, reg, value)		\
> +	i2c_smbus_write_byte_data(client, reg, value)
> +#define sg2042_mcu_read_block(client, reg, array)		\
> +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> +
> +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> +	static ssize_t _name##_show(struct device *dev,			\
> +				    struct device_attribute *attr,	\
> +				    char *buf)				\
> +	{								\
> +		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
> +		_type ret;						\
> +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> +		if (ret < 0)						\
> +			return ret;					\
> +		return sprintf(buf, _format "\n", ret);			\
> +	}
> +
> +#define DEFINE_MCU_DEBUG_ATTR_READ_FUNC(_name, _type, _format)		\
> +	static int _name##_show(struct seq_file *seqf,			\
> +				    void *unused)			\
> +	{								\
> +		struct sg2042_mcu_data *mcu = seqf->private;		\
> +		_type ret;						\
> +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> +		if (ret < 0)						\
> +			return ret;					\
> +		seq_printf(seqf, _format "\n", ret);			\
> +		return 0;						\
> +	}
> +
> +#define _CREATE_DEBUG_ENTRY(name, perm, d, data)			\
> +	debugfs_create_file(#name, perm, d, data, &name##_fops)
> +
> +struct sg2042_mcu_board_data {
> +	u8		id;
> +	const char	*name;
> +};
> +
> +struct sg2042_mcu_data {
> +	struct i2c_client			*client;
> +	const struct sg2042_mcu_board_data	*board_info;
> +	struct dentry				*debugfs;
> +};
> +
> +static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> +	{
> +		.id = 0x80,
> +		.name = "SG2042 evb x8",
> +	},
> +	{
> +		.id = 0x81,
> +		.name = "SG2042R evb",
> +	},
> +	{
> +		.id = 0x83,
> +		.name = "SG2042 evb x4",
> +	},
> +	{
> +		.id = 0x90,
> +		.name = "Milk-V Pioneer",
> +	},
> +};

Upstream kernel DTS only supports Milk-V pioneer, evb boards are not 
supported in plan. Can we figure a method to let user extend this 
outside kernel or just ask vendor to patch this when necessary?

> +
> +static const char *sg2042_mcu_reset_reason[8] = {
> +	"Power supply overheat",
> +	"Power supply failure",
> +	"12V power supply failure",
> +	"Reset commant",
> +	"Unknown",
> +	"Unknown",
> +	"Unknown",
> +	"SoC overheat",
> +};
> +
> +static struct dentry *sgmcu_debugfs;
> +
> +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> +}
> +
> +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> +}
> +
> +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> +}
> +
> +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> +}
> +
> +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> +}
> +
> +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> +}
> +
> +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> +{
> +	int ret;
> +	u8 time_val[2];
> +
> +	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> +}
> +
> +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> +}
> +
> +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> +}
> +
> +static int sg2042_mcu_get_soc_crit_action(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> +}
> +
> +static int sg2042_mcu_get_soc_crit_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> +}
> +
> +static int sg2042_mcu_get_soc_hyst_temp(struct i2c_client *client)
> +{
> +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> +}
> +
> +static int sg2042_mcu_set_soc_crit_action(struct i2c_client *client,
> +					  u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> +}
> +
> +static int sg2042_mcu_set_soc_crit_temp(struct i2c_client *client,
> +					u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> +}
> +
> +static int sg2042_mcu_set_soc_hyst_temp(struct i2c_client *client,
> +					u8 value)
> +{
> +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> +}
> +
> +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> +
> +static ssize_t reset_reason_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret, val, i;
> +
> +	val = sg2042_mcu_get_reset_reason(mcu->client);
> +	if (val < 0)
> +		return val;
> +
> +	ret = sprintf(buf, "Reason: 0x%02x\n", val);
> +
> +	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> +		if (val & BIT(i))
> +			ret += sprintf(buf + ret, "bit %d: %s\n", i,
> +						  sg2042_mcu_reset_reason[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t critical_action_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +	const char *action;
> +
> +	ret = sg2042_mcu_get_soc_crit_action(mcu->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == CRITICAL_ACTION_REBOOT)
> +		action = "reboot";
> +	else if (ret == CRITICAL_ACTION_POWEROFF)
> +		action = "poweroff";
> +	else
> +		action = "unknown";
> +
> +	return sprintf(buf, "%s\n", action);
> +}
> +
> +static ssize_t critical_action_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int value;
> +
> +	if (sysfs_streq("reboot", buf))
> +		value = CRITICAL_ACTION_REBOOT;
> +	else if (sysfs_streq("poweroff", buf))
> +		value = CRITICAL_ACTION_POWEROFF;
> +	else
> +		return -EINVAL;
> +
> +	return sg2042_mcu_set_soc_crit_action(mcu->client, value);
> +}
> +
> +static DEVICE_ATTR_RO(reset_count);
> +static DEVICE_ATTR_RO(uptime);
> +static DEVICE_ATTR_RO(reset_reason);
> +static DEVICE_ATTR_RW(critical_action);
> +
> +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> +
> +static int board_type_show(struct seq_file *seqf, void *unused)
> +{
> +	struct sg2042_mcu_data *mcu = seqf->private;
> +
> +	seq_printf(seqf, "%s\n", mcu->board_info->name ?: "Unknown");
> +
> +	return 0;
> +}
> +
> +static int mcu_type_show(struct seq_file *seqf, void *unused)
> +{
> +	struct sg2042_mcu_data *mcu = seqf->private;
> +	int ret;
> +
> +	ret = sg2042_mcu_get_mcu_type(mcu->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(seqf, ret ? "GD32\n" : "STM32\n");
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(firmware_version);
> +DEFINE_SHOW_ATTRIBUTE(pcb_version);
> +DEFINE_SHOW_ATTRIBUTE(mcu_type);
> +DEFINE_SHOW_ATTRIBUTE(board_type);
> +
> +// TODO: to debugfs
> +
> +static struct attribute *sg2042_mcu_attrs[] = {
> +	&dev_attr_reset_count.attr,
> +	&dev_attr_uptime.attr,
> +	&dev_attr_reset_reason.attr,
> +	&dev_attr_critical_action.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sg2042_mcu_attr_group = {
> +	.attrs	= sg2042_mcu_attrs,
> +};
> +
> +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> +					HWMON_T_CRIT_HYST,
> +				 HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static int sg2042_mcu_read_temp(struct device *dev,
> +				u32 attr, int channel,
> +				long *val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	long tmp;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		switch (channel) {
> +		case 0:
> +			tmp = sg2042_mcu_get_soc_temp(mcu->client);
> +			if (tmp < 0)
> +				return tmp;
> +			*val = tmp * 1000;
> +			break;
> +		case 1:
> +			tmp = sg2042_mcu_get_board_temp(mcu->client);
> +			if (tmp < 0)
> +				return tmp;
> +			*val = tmp * 1000;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	case hwmon_temp_crit:
> +		if (channel)
> +			return -EOPNOTSUPP;
> +
> +		tmp = sg2042_mcu_get_soc_crit_temp(mcu->client);
> +		if (tmp < 0)
> +			return tmp;
> +		*val = tmp * 1000;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		if (channel)
> +			return -EOPNOTSUPP;
> +
> +		tmp = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> +		if (tmp < 0)
> +			return tmp;
> +		*val = tmp * 1000;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int sg2042_mcu_read(struct device *dev,
> +			   enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		if (attr != hwmon_chip_update_interval)
> +			return -EOPNOTSUPP;
> +		*val = 1000;
> +		break;
> +	case hwmon_temp:
> +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int sg2042_mcu_write(struct device *dev,
> +			    enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 down_temp, repower_temp;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
> +		return -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		ret = sg2042_mcu_get_soc_hyst_temp(mcu->client);
> +		if (ret < 0)
> +			repower_temp = DEFAULT_REPOWER_TEMP;
> +		else
> +			repower_temp = ret;
> +
> +		down_temp = val / 1000;
> +		if (down_temp < repower_temp)
> +			return -EINVAL;
> +
> +		return sg2042_mcu_set_soc_crit_temp(mcu->client,
> +						    (u8)(val / 1000));
> +	case hwmon_temp_crit_hyst:
> +		ret = sg2042_mcu_get_soc_crit_temp(mcu->client);
> +		if (ret < 0)
> +			return -ENODEV;
> +
> +		down_temp = ret;
> +		repower_temp = val / 1000;
> +		if (down_temp < repower_temp)
> +			return -EINVAL;
> +
> +		return sg2042_mcu_set_soc_hyst_temp(mcu->client,
> +						    (u8)(val / 1000));
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t sg2042_mcu_is_visible(const void *_data,
> +				     enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		if (attr == hwmon_chip_update_interval)
> +			return 0444;
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			if (channel < 2)
> +				return 0444;
> +			break;
> +		case hwmon_temp_crit:
> +		case hwmon_temp_crit_hyst:
> +			if (channel == 0)
> +				return 0664;
> +			break;
> +		default:
> +			return 0;
> +		}
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops sg2042_mcu_ops = {
> +	.is_visible = sg2042_mcu_is_visible,
> +	.read = sg2042_mcu_read,
> +	.write = sg2042_mcu_write,
> +};
> +
> +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> +	.ops = &sg2042_mcu_ops,
> +	.info = sg2042_mcu_info,
> +};
> +
> +static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
> +				    struct device *dev)
> +{
> +	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
> +	if (mcu->debugfs) {
> +		_CREATE_DEBUG_ENTRY(firmware_version, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(pcb_version, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(mcu_type, 0444, mcu->debugfs, mcu);
> +		_CREATE_DEBUG_ENTRY(board_type, 0444, mcu->debugfs, mcu);
> +	}
> +}
> +
> +static int sg2042_mcu_check_board(u8 id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> +		if (sg2042_boards_data[i].id == id)
> +			return i;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct device *dev = &client->dev;
> +	struct sg2042_mcu_data *mcu;
> +	struct device *hwmon_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -EIO;
> +
> +	ret = sg2042_mcu_get_board_type(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sg2042_mcu_check_board(ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> +	if (!mcu)
> +		return -ENOMEM;
> +
> +	mcu->client = client;
> +	mcu->board_info = &sg2042_boards_data[ret];
> +
> +	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> +	if (ret < 0)
> +		return ret;
> +
> +	i2c_set_clientdata(client, mcu);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> +							 mcu,
> +							 &sg2042_mcu_chip_info,
> +							 NULL);
> +
> +	sg2042_mcu_debugfs_init(mcu, dev);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +
> +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> +}
> +
> +static const struct i2c_device_id sg2042_mcu_id[] = {
> +	{ "sg2042_hwmon_mcu", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> +
> +static const struct of_device_id sg2042_mcu_of_id[] = {
> +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> +
> +static struct i2c_driver sg2042_mcu_driver = {
> +	.driver = {
> +		.name = "sg2042-mcu",
> +		.of_match_table = sg2042_mcu_of_id,
> +	},
> +	.probe = sg2042_mcu_i2c_probe,
> +	.remove = sg2042_mcu_i2c_remove,
> +	.id_table = sg2042_mcu_id,
> +};
> +
> +static int __init sg2042_mcu_init(void)
> +{
> +	sgmcu_debugfs = debugfs_create_dir("sgmcu", NULL);
> +	return i2c_add_driver(&sg2042_mcu_driver);
> +}
> +
> +static void __exit sg2042_mcu_exit(void)
> +{
> +	debugfs_remove_recursive(sgmcu_debugfs);
> +	i2c_del_driver(&sg2042_mcu_driver);
> +}
> +
> +module_init(sg2042_mcu_init);
> +module_exit(sg2042_mcu_exit);
> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> +MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
> +MODULE_LICENSE("GPL");
> --
> 2.45.2
>


Return-Path: <linux-kernel+bounces-274073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2794731C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7239F280EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752B13CFA1;
	Mon,  5 Aug 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TgQDCz9m"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2030.outbound.protection.outlook.com [40.92.102.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F720B0F;
	Mon,  5 Aug 2024 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821901; cv=fail; b=GP+jp5CdgzpKCXVdAmqYN0Jy7YZI5I8SjK2bh6C4OSbbD21qSMJgIru3lpQ4OL8DOqnUE/N/4r1PDci4zAMA456fFxC2o2ZYEv3dkTysOKN9eWkXwigT5z0doLWAnVy/Le2E1paN5gc8FO3zz7B3wtlE8A4QqbAhV5tz+wYnj2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821901; c=relaxed/simple;
	bh=BPvALf2phmibUwIPbcV0+zuTvQMfIEbyS62/w7rg/bI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=POx88XlGGyAEommSVNAtNgfwfHjWsQQO40Itz2aXCHWItf3ITky5xzln2ckbrULdjhsowyYqSNVPjjt8RgI3TZ6nyb7+c+pupDmj5slu4MPE+dHQ9Gs8mffRM9I3DfHxfTO2RrydSG4lRe3OWVvb9K0mo+Kb8L/V2+IBzOKZ1+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TgQDCz9m; arc=fail smtp.client-ip=40.92.102.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keRMDcO4w4aEtdNu/ubPLsE3A+6IcNZMOxxI6GdsjTyEvRxrEMWBNtAXx4hOl81RsrAwo96nMauGghF7mNQ8xtW5OZPW8DUBLaHr1POoLC8M08B7wi/vRWPIePGgptmT5uvL9OyclQWyYxQseMbB9pP643pPkIAF7k8pgeMAHvjHMXoDEUJjKUhpvgLwRppMJehvfWjYMT/xIHdzEYbs9958uZp12agTuu/3QXPEHOLgQqd4hb1+aFNFZJxA5ek59+46QpWDjIEOKV+VfrCUUw484aJ7sT5P/MBLgRVesJtUYvQbZAPpN4xCjxUEb+usni89FeB3IRaEpSgIn6NxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4uioZ5dKm6aUPH+BBB/tD5x7+kOSaHicUA2CwOFH58=;
 b=eXXcD2T7wyVjdCIt0VqMEzs+6a7X3et+yqA/2bAUieezPCLV+a+F7Eu421oyoRSW+NZc2Pjk3mXGaZQuVwczcuztE1W2GKA9+PPlE1XpcdqdhMKDfPz5+1admhYzzJgHfHlPIJ62nnHxQH1npMoGuurx3fY1OAZz2+Kgn7nr5vR2FjNWBnW5qjp7JWlY/7/jI8Ce2zrPj9yy8R5WlUihbxsh0P2BJ0rEe5nWAM8fYvH3rl5zyQcT7WERZUDZ8lYGO4HtXqPyXLEpJlTT3gqHxTpZqMBq0CLfDjsLR3zzA/1xjxdYf/BbIp2E/m51TRi9jJ5pYLH9RpAJ/XLIC4DRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4uioZ5dKm6aUPH+BBB/tD5x7+kOSaHicUA2CwOFH58=;
 b=TgQDCz9mzV54/MeuXX60ykoxAhYayBPOXujdAsWO5/K5UdxNTazcrL+IKRWKpSr7riifzRfkmAVHTp1NMgLOWuJQpMwHR5+mH+3skaeY6m2rfs8G09bR+9s5WyF1h9eb3CI3RgWVM9R83sUqphnMlZ0DvxY9NLC4z5ESMf02bTBhT+baZIwiNu+LH+tBMg+92uIH6wf/FuliMW0/LysEoWRZWxGXoBVXy+gpgl1w07+7Q7iiyJ043B60Piv6ELwIoMRlfF0/Ex68eBrqfsH1ksK6+382fNTFW98qms45sWqD94Dg3rCCvvEc4B0gULWu5fZFtabZrARvdTII6qDJwQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1137.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 01:38:07 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 01:38:07 +0000
Message-ID:
 <MA0P287MB2822B30C0665F36B08C8611BFEBE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 5 Aug 2024 09:38:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Jinyu Tang <tangjinyu@tinylab.org>, Hal Feng <hal.feng@starfivetech.com>,
 Yangyu Chen <cyy@cyyself.name>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB495337877FFC8D787A045C15BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953032E1B5D58D2F6C7393DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953032E1B5D58D2F6C7393DBBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [qvxCqMU9sLO7LFTVGeg3AZIw1J/3oYQF]
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d6ae7fb7-8fcc-408e-a550-4f344fd8ffef@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1137:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b27eae0-0d9c-4661-83e1-08dcb4ef4191
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	NAuP3zDFkuWoz7UJTFpLZc/Opa70KTnFKzA6M3BxEWMSiyhMMHLUiYAx+3andZnMx+a34ZTUt962KQXMUM8dPC7JvTTlKiA+p2nfWyWD4wVsaYz8R0T8rxm93W2lNABJwGQ8G6feu7Obx5QQXsIEuBkUWsaWxGZ7xY40bYxGyBxty47PDEfxAVaMrPq7CGxqWaTqSD/jflQ4hQnIFOWYLbahxLCL9chIExU1yPpDQ8Osl3pQorImmUpXhvcmgoLEM37wrjYW+jAcP1EpdGVeEocC4eF9mkH9kwGdocQCJ26UmcJzwTbAS7bvVOTwWQFZFgj9CJ96LCgUDWAuc/E4siMCR/q1yxevI3XeQMlf6tQvywt7+FYVsad9NEUyqZYT+5n/jqusQjVj6ZokXxXBJ72l1N9QZazqtyplpAX3xXioh9taXh6UZUSRrHJ29oSBzUgpP/3rPzOgRORnsU/W96XgsW+HneKUmVy4Zlbgk6qJZlkGxAas8N1b/xD9bk4s3HjZKmwfhr0nkrsgk6iIDBbRG63O4RTvXbXpdZphQQWD7dOmZH3zpyMeGkuygcPlc9/9HIlun12S0D2dGWXbq06xOmweyUkU1W++HXLgAK6YU5/V1ijU1v1t/j7vGeV8HYErkOEOE+tz4yPC1JSOWQsgEFOZP+Ajp0X9354dsYkt5MjRtVHeSDp44BkmzJrC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTJaUmYvbUJRMzN3WlNYVldNSzR1Q3pPamtxSVFHanoxZ1Z6ZWlMWlIzSzNh?=
 =?utf-8?B?TXRwWDZQM29pKy8yNTBKd1VuVklub0VZeHpIQ09ZQ1dXU0trR3BPNlhkNjBK?=
 =?utf-8?B?YVcvU1hEcHd3Y0MwTmkxcWExbi9ySWlaSjRLUHI0K0h2dkJTSkt4Z3Q5Q0NN?=
 =?utf-8?B?QUUyaFJweENNUmtvNWJmK0dsOEN1QjNNa2s1aFFNbnprSTB5KzRUSTBnbkpt?=
 =?utf-8?B?VlV2bXhIbWNNaFc1ZHFUc0xwN2dRVENzYzZVMDZuZGRnYjNhWGNrMTd3RGcx?=
 =?utf-8?B?YXBsVno1cUlaY2RZaVZQUmFnbjE1ODM3YzEzTkFObndKRUgrSy9vcGtFUTJm?=
 =?utf-8?B?QU1oejk1Qnh6eDVuakRFZ3Y0VkVWQ0VQWlZ1QjJuU2c3dU1scC9kVkJIQzZH?=
 =?utf-8?B?eTNzU1U3TCtic0hJeFhpVlNHdU9Yc2k4eDNVQVQ1eVViUVpoYWpMZ1p5ZUJH?=
 =?utf-8?B?R3ZKZWFOckJBZ1ljQUVlM0w5SHRCZEVDQ2VldUk1bzNZRklVV1NLR3BRK3Nv?=
 =?utf-8?B?Y1BIRkJrMFRMTStQZVd3c0NMYXNwdEMvQlhYbldIdFBRdUppWmhWMXhiUEJF?=
 =?utf-8?B?T1ZLSi9xWUk5dVRhTFlMaHlVcnBvaTBvNURveFNGcnBHVmVyNnlQOC85bWpt?=
 =?utf-8?B?U04wamp4Sjg3U0F5T1BIcFdKYUxsZkIrVEpVdm9PdCtwY01rWDdBRXN3Y2hB?=
 =?utf-8?B?UVFiNEc5YmhJZndRQUZLcXR2c0MrZjF3czNPQnN1cEFvOEhwNjJCeGY4SHdR?=
 =?utf-8?B?dXltUkJKT3l2dWljeWdtajlFUnk2bkNFWU9lTklXcnRTZCtpYlppRlV5Tm41?=
 =?utf-8?B?eEpsRVQyamdnNFFvOUNMOURwWUhDYldmVVRXN3UvenpvSUdCTmpUdjM0QnpI?=
 =?utf-8?B?a1VGM0dOUzhMVWlMZ2RWcFNUWnYrYkdvRS9YNkhwRmVCSEZHQlI0Z29jNXFz?=
 =?utf-8?B?R1Z4c3V1cTN4UVNvc0YxdFYrSzZySDZmdjBTdmxWM2kxWDhzMzJ4cVJUS0N3?=
 =?utf-8?B?OXVoeEFHZFVlVTJqa2J5d1V2T2ZaMlU5WHBRVUJNQnIxZTBFN1RpOU8wVk12?=
 =?utf-8?B?b0h5NUF3K1YrT25IK0JWNy9kUVZvMU5vRVRoek04NDM2d2lPSDFGa2dLZmFT?=
 =?utf-8?B?NlVvWHlHVGFTSlBHYm1oV2ZvRjl2MnFYRnBqempTK040bFpBc1REOW9obGtn?=
 =?utf-8?B?M3VMVFpXVnpCaWlzR0o2RzFNSFVBQmpveFYyNzZvd2xMU3A2STJmMENvU01O?=
 =?utf-8?B?eUQrbzZOaHNWREJLRk9ocVc3eVZ6eWZuektDQWNubnRuQkUyRWhhT0FFY1Mx?=
 =?utf-8?B?cGh6REJmenhDRkdpazFEbXpQZk5GTFhUdzQ0K052SXhCYS83emxuQWlzM3NT?=
 =?utf-8?B?VEFUbnJvR2ZCaUgyS3dZb05ZUVNyT3JXUDdqQ0ZvVGlQSkxtZEMwL1g4Y295?=
 =?utf-8?B?bnhiSzFnUDc4R2tPSk14c3dPVDVteU53T095SXlrYzBTdkQ1NkpueXpPaE52?=
 =?utf-8?B?dklRRDFKdkhEN29nT29oN3kzWUR2UTViUlo5SjY4K054SFdpalRZV0tGaXNT?=
 =?utf-8?B?TmZKbjRnbmY0RFZ4UkhCNjdzVVNMNkFsSysyM3FxZnpHdytLMHFJV1lOaEZP?=
 =?utf-8?B?K3ZFVTNaT04vQWlpKzkwM0owZW41THlVMUoyeFlSWFlZdTNlQ1FuMGt2cjN3?=
 =?utf-8?Q?nwPtzmF/4yGG8UxCTxM3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b27eae0-0d9c-4661-83e1-08dcb4ef4191
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 01:38:07.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1137


On 2024/8/2 20:38, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
>
> Add driver support for the onboard MCU of SG2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Tested-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   Documentation/hwmon/index.rst      |   1 +
>   Documentation/hwmon/sg2042-mcu.rst |  39 +++
>   drivers/hwmon/Kconfig              |  11 +
>   drivers/hwmon/Makefile             |   1 +
>   drivers/hwmon/sg2042-mcu.c         | 394 +++++++++++++++++++++++++++++
>   5 files changed, 446 insertions(+)
>   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
>   create mode 100644 drivers/hwmon/sg2042-mcu.c
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 913c11390a45..ea3b5be8fe4f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
>      sch5636
>      scpi-hwmon
>      sfctemp
> +   sg2042-mcu
>      sht15
>      sht21
>      sht3x
> diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> new file mode 100644
> index 000000000000..250016b47dd1
> --- /dev/null
> +++ b/Documentation/hwmon/sg2042-mcu.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sg2042-mcu
> +=====================
> +
> +Supported chips:
> +
> +  * Onboard MCU for sg2042
> +
> +    Addresses scanned: -
> +
> +    Prefix: 'sg2042-mcu'
> +
> +Authors:
> +
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +Description
> +-----------
> +
> +This driver supprts hardware monitoring for onboard MCU with
> +i2c interface.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate
> +the devices explicitly.
> +Please see Documentation/i2c/instantiating-devices.rst for details.
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
> index b60fe2e58ad6..7aa6c3f322e5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called sfctemp.
>   
> +config SENSORS_SG2042_MCU
> +	tristate "Sophgo onboard MCU support"
> +	depends on I2C
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Support for onboard MCU of Sophgo SG2042 SoCs. This mcu provides
> +	  power control and some basic information.
> +
> +	  This driver can be built as a module. If so, the module
> +	  will be called sg2042-mcu.
> +
>   config SENSORS_SURFACE_FAN
>   	tristate "Surface Fan Driver"
>   	depends on SURFACE_AGGREGATOR
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..0bbe812a67ae 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>   obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>   obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>   obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> +obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
>   obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
> new file mode 100644
> index 000000000000..6d8d677f86f3
> --- /dev/null
> +++ b/drivers/hwmon/sg2042-mcu.c
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> + *
> + * Sophgo power control mcu for SG2042
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
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
> +#define REG_REPOWER_ACTION			0x65
> +#define REG_CRITICAL_TEMP			0x66
> +#define REG_REPOWER_TEMP			0x67
As I mentioend in last review, suggest to add some clarification for 
CRITICAL and REPOWER. Due to no document from sophgo, I hope some 
comments in code for memo.
> +
> +#define REPOWER_ACTION_REBOOT			1
> +#define REPOWER_ACTION_POWEROFF			2
> +
> +#define MCU_POWER_MAX				0xff
> +
> +#define DEFINE_MCU_DEBUG_ATTR(_name, _reg, _format)			\
> +	static int _name##_show(struct seq_file *seqf,			\
> +				    void *unused)			\
> +	{								\
> +		struct sg2042_mcu_data *mcu = seqf->private;		\
> +		int ret;						\
> +		ret = i2c_smbus_read_byte_data(mcu->client, (_reg));	\
> +		if (ret < 0)						\
> +			return ret;					\
> +		seq_printf(seqf, _format "\n", ret);			\
> +		return 0;						\
> +	}								\
> +	DEFINE_SHOW_ATTRIBUTE(_name)					\
> +
> +struct sg2042_mcu_data {
> +	struct i2c_client	*client;
> +	struct dentry		*debugfs;
> +	struct mutex		mutex;
> +};
> +
> +static struct dentry *sgmcu_debugfs;
> +
> +static ssize_t reset_count_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RST_COUNT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
> +static ssize_t uptime_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 time_val[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
> +					    sizeof(time_val), time_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n",
> +		       (int)(time_val[0]) + (int)(time_val[1] << 8));
> +}
> +
> +static ssize_t reset_reason_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RESET_REASON);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "0x%02x\n", ret);
> +}
> +
> +static ssize_t repower_action_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +	const char *action;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_ACTION);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == REPOWER_ACTION_REBOOT)
> +		action = "reboot";
> +	else if (ret == REPOWER_ACTION_POWEROFF)
> +		action = "poweroff";
> +	else
> +		action = "unknown";
> +
> +	return sprintf(buf, "%s\n", action);
> +}
> +
> +static ssize_t repower_action_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 value;
> +	int ret;
> +
> +	if (sysfs_streq("reboot", buf))
> +		value = REPOWER_ACTION_REBOOT;
> +	else if (sysfs_streq("poweroff", buf))
> +		value = REPOWER_ACTION_POWEROFF;
> +	else
> +		return -EINVAL;
> +
> +	guard(mutex)(&mcu->mutex);
> +
> +	ret = i2c_smbus_write_byte_data(mcu->client,
> +					REG_REPOWER_ACTION, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RO(reset_count);
> +static DEVICE_ATTR_RO(uptime);
> +static DEVICE_ATTR_RO(reset_reason);
> +static DEVICE_ATTR_RW(repower_action);
> +
> +DEFINE_MCU_DEBUG_ATTR(firmware_version, REG_MCU_FIRMWARE_VERSION, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(pcb_version, REG_PCB_VERSION, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(board_type, REG_BOARD_TYPE, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(mcu_type, REG_MCU_TYPE, "%d");
> +
> +static struct attribute *sg2042_mcu_attrs[] = {
> +	&dev_attr_reset_count.attr,
> +	&dev_attr_uptime.attr,
> +	&dev_attr_reset_reason.attr,
> +	&dev_attr_repower_action.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sg2042_mcu_attr_group = {
> +	.attrs	= sg2042_mcu_attrs,
> +};
> +
> +static const struct attribute_group *sg2042_mcu_groups[] = {
> +	&sg2042_mcu_attr_group,
> +	NULL
> +};
> +
> +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> +					HWMON_T_CRIT_HYST,
> +				 HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static int sg2042_mcu_read(struct device *dev,
> +			   enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int tmp;
> +	u8 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> +		break;
> +	case hwmon_temp_crit:
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +	*val = tmp * 1000;
> +
> +	return 0;
> +}
> +
> +static int sg2042_mcu_write(struct device *dev,
> +			    enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int temp = val / 1000;
> +	int hyst_temp, crit_temp;
> +	u8 reg;
> +
> +	if (temp > MCU_POWER_MAX)
> +		temp = MCU_POWER_MAX;
> +	else if (temp < 0)
> +		temp = 0;
> +
> +	guard(mutex)(&mcu->mutex);
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_REPOWER_TEMP);
> +		if (hyst_temp < 0)
> +			return hyst_temp;
> +
> +		crit_temp = temp;
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_CRITICAL_TEMP);
> +		if (crit_temp < 0)
> +			return crit_temp;
> +
> +		hyst_temp = temp;
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * ensure hyst_temp is smaller to avoid MCU from
> +	 * keeping triggering repower event.
> +	 */
> +	if (crit_temp < hyst_temp)
> +		return -EINVAL;
> +
> +	return i2c_smbus_write_byte_data(mcu->client, reg, temp);
> +}
> +
> +static umode_t sg2042_mcu_is_visible(const void *_data,
> +				     enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
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
> +		debugfs_create_file("firmware_version", 0444, mcu->debugfs,
> +				    mcu, &firmware_version_fops);
> +		debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
> +				    &pcb_version_fops);
> +		debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
> +				    &mcu_type_fops);
> +		debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
> +				    &board_type_fops);
> +	}
> +}
> +
> +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct sg2042_mcu_data *mcu;
> +	struct device *hwmon_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -EIO;
> +
> +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> +	if (!mcu)
> +		return -ENOMEM;
> +
> +	mutex_init(&mcu->mutex);
> +	mcu->client = client;
> +
> +	i2c_set_clientdata(client, mcu);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sg2042_mcu",
> +							 mcu,
> +							 &sg2042_mcu_chip_info,
> +							 NULL);
> +	if (IS_ERR_OR_NULL(hwmon_dev))
> +		return -EFAULT;
> +
> +	sg2042_mcu_debugfs_init(mcu, dev);
> +
> +	return 0;
> +}
> +
> +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> +{
> +	struct sg2042_mcu_data *mcu = i2c_get_clientdata(client);
> +
> +	debugfs_remove_recursive(mcu->debugfs);
> +}
> +
> +static const struct i2c_device_id sg2042_mcu_id[] = {
> +	{ "sg2042-hwmon-mcu", 0 },
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
> +		.dev_groups = sg2042_mcu_groups,
> +	},
> +	.probe = sg2042_mcu_i2c_probe,
> +	.remove = sg2042_mcu_i2c_remove,
> +	.id_table = sg2042_mcu_id,
> +};
> +
> +static int __init sg2042_mcu_init(void)
> +{
> +	sgmcu_debugfs = debugfs_create_dir("sg2042-mcu", NULL);
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


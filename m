Return-Path: <linux-kernel+bounces-189183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287108CEC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450B31C21773
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA860129A8E;
	Fri, 24 May 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="W0Mu7I7q"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2168.outbound.protection.outlook.com [40.92.63.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBC2CA5;
	Fri, 24 May 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716592402; cv=fail; b=D/Jxs+rD1OYE/X80ckdhycX+FjWqq04lnbGqgH9pJwjvNk4IuHrVNQsaHDAyDpvijPbtI4ryHzuLNiJgfRRwqcKXhaZaVN29W+ovK4Dnf8cQufAXJ6KsSXzPSMwz3EBH0kepLrypYHyjDquf07US12fP52WScX3joZLtiVoW2PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716592402; c=relaxed/simple;
	bh=csAaxym4dNDNsm+zpSMT65bZPhZn7UXFByfyGDKWvZY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdPkPvi5Jb/uj2cjVbGC40C35HNI4HaDtrZXlj+Swu8x4tyfXU9LJs69NNmKTTMzuARmr2/ijglqGrinJCPQyl1KhIq601+VGfmgpOBicwjoX9shmS1A3J3htmw2a47TXMcJsC57OCwc7bCqPCuKudC40TXUkn1Z/sxZteoRR18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=W0Mu7I7q; arc=fail smtp.client-ip=40.92.63.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ57MgKTdkfeKrx0RlOwuCUkrpHcqGvbsynYbd/M+nVlhjxw4vKSyzwU50dRFNQJnpzJc5+ACWgMHjx03Owvooekb8ZOMtm2IXeVHsR+zfVKb4BI9us3eInZm9d4OKX7sXy2zSjRQ3Ar1RD/F7YvPrD4YS/Gr5OAxhPP09axezXU7NJnHN6RB1c7oC0zg57X5HmGR2X6kd8exx2YvlkmydSdwu32YMptZk1WRApfH6ad4gJCnIkmmlUnQKV+i5r9cag37nBgAzyLjZnVKBIWAoO8e+KmiKliem4PqlTaE8lJP2WISgpSwhNTfAkanyFAOUNuDPuId3JvuyOtx3xpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nyWITULXFAt4VCapvHEJp1UqO+1KOy0c/EFJlPx29o=;
 b=F3HTPz2UNxZ46hXXZzvRVeRDyNxvqSgtSiFygXfbRtrsifZrTGIMObRDALwLRASISXM+DB8Jh0uC6IFH3/q4F46HQPtmPjKJ5QExGFd1T67NnU1TL9/rJOXltY4dZWvPzGJU71CAgIhyblV6JyIPv/hSsC5XRKbMbt7CL6UuYl3wajbdbTum6DiJyWcbGqq75RobAXtz+20jK5ikdEtlBOYL0vDIN5K136i5eVd/DKQDss9YPN7pO4tNcE97I3WYmzD0W1a5bzHxqy+CRuHEYh/X4j63w9i5Jy3TwkUrO+lfnnphf517eYJKIsy1Xsjw0npko1bCfI86F3XUI4MkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nyWITULXFAt4VCapvHEJp1UqO+1KOy0c/EFJlPx29o=;
 b=W0Mu7I7qep7PmwOFQxP9zDPaMcknxiC4A3at6oMbegUyzE7hq2cS2IO0QWQekEApRFu9uCfnxvLELtXiiqfPmlcWbuP6E6wh8pSY0oq7WEvC0sXNzO+gZrpiwhWANG/vsYwLSBogdKLfn71xoa0wGx0F2p5dpMkWk+Ct0aaiCIlRGu8qnb0vjNCTm5C4YAKqPeD8vKgmBCtLRjok6lJMuT5T1GcZafAvAjlReCJczGRokp/iS8oM5x9iVpX9QxhUQs/v+Gty+2bTCdO0mvfFV7xFduUy82Ll0MN4tXLdW89hE5mYN6NbU9VE83R2PoqdmW5Y/eexMZuEqt+/INzfuA==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SYYP282MB1534.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:dd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Fri, 24 May 2024 23:13:13 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%3]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 23:13:13 +0000
Message-ID:
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Sat, 25 May 2024 09:13:09 +1000
User-Agent: Mozilla Thunderbird
From: Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
 Dustin Howett <dustin@howett.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Moritz Fischer <mdf@kernel.org>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [8dmodNvU81XLQ/SOLpCp2nXX4mS/WQaOxdqEJhN9vpjUJfb1ZV1qcbVD/alxJRPXxUCUwsSHV7Y=]
X-ClientProxiedBy: SY6PR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:10:110::12) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <5286705f-8e96-40de-8b2b-3cab25895fc4@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SYYP282MB1534:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1cfc11-6b4d-4c83-6ad8-08dc7c47160c
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	QWYXT31o5S0Q04w+GbLvdvOPRmjLJUSNStCxawqc9v6d9cEsheJRKiVKeBVCQYKI89oLvruQmOL+T01diL4QBvp7c9Fv2WpOaKXx7jMg9gfP11EW5kGq4XjfM5e7TR5/28U9wPi0nlJBixuWtxY9xZtHhaF854hLzLbF6oL0xxDLmKH7MoL6rPjCmnAv2den7HNerd3xfgohEC4VwtVLrPmjM/jTmcV7MTAP2eDOjrZAGvWerZXh4uIn7UeeKArK6QEdNHnkHOxG7g/sAvZ+eqZNVOyPp7nEfhDQflNPeGWjfcd+OcNeCYjYoe85HDJo8yJC523QbjapNaa/tga/OCMxuCdb/CUh0yZHQOy51hb3pxOtkzhoTsVTdWnTRgqQQTGEvDvToweq3OXHbuWE1yncGIImMY2d7ZTO5NXmckDbds3faNA+0Uh3t3VX0Fuq4bcbxXGBNOzM5fVeIPDTQLOVQXIvOYi5nDWf9GCl3cR1HxU1X2BwBcjd7xuz801iPA3dnKogm5jMsEQmzpNqNXOjhvrWPKFTr1b+r4Nz3ZWR0P6xMDcusdI24y7FRM71
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpjeTdRNy9nS0pUWllyNWVBam9zMDVHVXB0WSs4QThiZEhtWHI5aHYwdHlF?=
 =?utf-8?B?dVlWSE9jektwR21rVjNNbjAxRjVpSHMyaU5vbkFyY0dFQW5hN216b3dvVFkv?=
 =?utf-8?B?SURkT0M3WTg1MGQyc21ZTjJZM00xTm40RkFJQ2ZPV1ZCL0pnYmpMa0p2N21z?=
 =?utf-8?B?aENydE1XaTdKQ3g4ODEzTFpEcmpwZTVUdCtGZWs1cUt0Q3pCK0Y3TU5ER292?=
 =?utf-8?B?M3cwNHlMYjlia3Q0Q1NndlFXTEx1YlpyY2dIbGJPenJmKzd4WnVjRHIxL09z?=
 =?utf-8?B?VVc1TjNKcUkxR3Q3cnUyN1hRdjg4WjdMWE9HTytQRkdjWGxmY0xlTVlVYjJJ?=
 =?utf-8?B?dUFuVFkwUnVQNHcvU1N0aTRDMlArTitGSnk1eGdRWFFPdFZZS2w3Tml5V0Ru?=
 =?utf-8?B?Y2I3c3A5OUhhS25nWG9VOGxvZ09LSTNKYldJYU40b0dRbXZpdzJwMFA3SzAz?=
 =?utf-8?B?VGRnOEVBekJRd2tzVVkyWVlMT1hGKzB3MFFPZDZhT1BhSmNIWWlLSVdvd0Vo?=
 =?utf-8?B?K0ZFcFMzQ1dCSzNWNWNESlJnZjQzTHhqc1ZzcmhSeFpRTDhrV0RxSVdKckFo?=
 =?utf-8?B?QU1IekVKMjNIOHZJRWVRaUpRNHFYN1NlMEpHVDJZSXZzMmFJaXNsZGI0dFNk?=
 =?utf-8?B?K1VTYnBvenkzWFRONjRaWDVCWVB6SkpKKzZqd1F0VGZteXBsUGUxTGc1dGlD?=
 =?utf-8?B?VjFXMGx2ZGZoYk1MTG42aGhGMldkWitiRDJUbFBDb1Z6cUdSZzdYbjhzQ01r?=
 =?utf-8?B?Wm9XdVh5VENyUlo3Zk0xZXFxNXdycmpZb29vMGh1K0IwRCtoNXJlazNaVzRl?=
 =?utf-8?B?K2NpS2FtVmRKSUpqaXNra3JIU1hSWkJCMHBNaCtrQlVXN2gvQWgyK2RDUW01?=
 =?utf-8?B?Z2tNQ1h3M2R1VG00YXh3QlYrU2pBdmxrdmZpZW1CRVdqUVZKemo0MXRnRUZJ?=
 =?utf-8?B?K1hwVFVIL3NXQVp0cmdNeVZubkdhY21VMmVxc25jckZWVDd5b0ZyVW1uYzRO?=
 =?utf-8?B?ZVBuUjFURDlZQWZjQjY1QzIvUlZHZ2Y5UU1aUElINkVIUGxPRzNVQUtLQVZw?=
 =?utf-8?B?RmErUkZRRU1NYUZuTUtGd2Y4dmI3NUVYNWwwazhnZUlBQ2NId1dLUGt0Q3px?=
 =?utf-8?B?RmdRWUx1ZUNvRVRoblJBOHhjZlJqbjBZcWNNakd0Z1NJN1ZCZE5ucmVnWjVp?=
 =?utf-8?B?QS9iMjVKOUlkTUE3Q0E5U3NYTzFIUlFRbHNmOEluOGEyWFdueHBEM2tqK3Q5?=
 =?utf-8?B?eWowanJPMml4bTVHRlBhSGh2U0FzamZMSlFLWDBtOXF5b25tM09Yd0dIWkdu?=
 =?utf-8?B?NytwVFpUVXdFRUptR3FwVkR3NDFweWgzTnB1UGJPNHI0TmR6RVVIbTVKbUFs?=
 =?utf-8?B?WVM4Si9UNUVGeTJRN2FSb2lDRVA0ZDNpSUl2bVBrUVk3RWFRbmRRczdmODYz?=
 =?utf-8?B?eHVNVlZRMWhDK1ZyY0MxR05rMGVocjlsR2lHalpZS2JIUzZxRHV2STljZjVD?=
 =?utf-8?B?MmhPK2o4ZEd4U0hhMnRvdVV5eWNtaFpkMGxzMjFucm4wM2lPUW9DblFnZjN0?=
 =?utf-8?B?KzdMTEo0WWt1S2RjamV5T3lQWFdQYUJocnlJZFh3b3lvQ1BYSmRpYjFWUVNm?=
 =?utf-8?B?RmJWM29zbWtRcWdXNFkvS2VKM0ZsWkxLUk1oVGZka21OSjdqOWVIckFNeTBp?=
 =?utf-8?B?NXE4QW9jUzJ6QnZiZHVpUGQxczZMSFNUUU1jd2dZS0JzZnQ3Qm90QXdsdGN0?=
 =?utf-8?Q?7GJbX9Dq/I1pyBhZvo+49S7r0bdGSPj+Lnc5vH0?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1cfc11-6b4d-4c83-6ad8-08dc7c47160c
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 23:13:13.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1534

Hi Thomas,

I was the one to implement fan monitoring/control into Dustin's driver, 
and just had a quick comment for your driver:

On 8/5/24 02:29, Thomas Weißschuh wrote:
> The ChromeOS Embedded Controller exposes fan speed and temperature
> readings.
> Expose this data through the hwmon subsystem.
> 
> The driver is designed to be probed via the cros_ec mfd device.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
>   Documentation/hwmon/index.rst         |   1 +
>   MAINTAINERS                           |   8 +
>   drivers/hwmon/Kconfig                 |  11 ++
>   drivers/hwmon/Makefile                |   1 +
>   drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
>   6 files changed, 316 insertions(+)
> 
> diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
> new file mode 100644
> index 000000000000..aeb88c79d11b
> --- /dev/null
> +++ b/Documentation/hwmon/cros_ec_hwmon.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver cros_ec_hwmon
> +===========================
> +
> +Supported chips:
> +
> +  * ChromeOS embedded controllers connected via LPC
> +
> +    Prefix: 'cros_ec'
> +
> +    Addresses scanned: -
> +
> +Author:
> +
> +  - Thomas Weißschuh <linux@weissschuh.net>
> +
> +Description
> +-----------
> +
> +This driver implements support for hardware monitoring commands exposed by the
> +ChromeOS embedded controller used in Chromebooks and other devices.
> +
> +The channel labels exposed via hwmon are retrieved from the EC itself.
> +
> +Fan and temperature readings are supported.
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 1ca7a4fe1f8f..355a83e66928 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -57,6 +57,7 @@ Hardware Monitoring Kernel Drivers
>      coretemp
>      corsair-cpro
>      corsair-psu
> +   cros_ec_hwmon
>      da9052
>      da9055
>      dell-smm-hwmon
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c23fda1aa1f0..aa5689169eca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4988,6 +4988,14 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>   F:	sound/soc/codecs/cros_ec_codec.*
>   
> +CHROMEOS EC HARDWARE MONITORING
> +M:	Thomas Weißschuh <thomas@weissschuh.net>
> +L:	chrome-platform@lists.linux.dev
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/chros_ec_hwmon.rst
> +F:	drivers/hwmon/cros_ec_hwmon.c
> +
>   CHROMEOS EC SUBDRIVERS
>   M:	Benson Leung <bleung@chromium.org>
>   R:	Guenter Roeck <groeck@chromium.org>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 83945397b6eb..c1284d42697f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -506,6 +506,17 @@ config SENSORS_CORSAIR_PSU
>   	  This driver can also be built as a module. If so, the module
>   	  will be called corsair-psu.
>   
> +config SENSORS_CROS_EC
> +	tristate "ChromeOS Embedded Controller sensors"
> +	depends on MFD_CROS_EC_DEV
> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say yes here you get support for ChromeOS Embedded Controller
> +	  sensors.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called cros_ec_hwmon.
> +
>   config SENSORS_DRIVETEMP
>   	tristate "Hard disk drives with temperature sensors"
>   	depends on SCSI && ATA
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 5c31808f6378..8519a6b36c00 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
>   obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>   obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
>   obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
> +obj-$(CONFIG_SENSORS_CROS_EC)	+= cros_ec_hwmon.o
>   obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>   obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>   obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> new file mode 100644
> index 000000000000..d59d39df2ac4
> --- /dev/null
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  ChromesOS EC driver for hwmon
> + *
> + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/units.h>
> +
> +#define DRV_NAME	"cros-ec-hwmon"
> +
> +struct cros_ec_hwmon_priv {
> +	struct cros_ec_device *cros_ec;
> +	u8 thermal_version;
> +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> +};
> +
> +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = le16_to_cpu(data);
> +
> +	if (data == EC_FAN_SPEED_NOT_PRESENT)
> +		return -ENODEV;
> +

Don't forget it can also return `EC_FAN_SPEED_STALLED`.
Like Guenter, I also don't like returning `-ENODEV`, but I don't have a 
problem with checking for `EC_FAN_SPEED_NOT_PRESENT` in case it was 
removed since init or something.
My approach was to return the speed as `0`, since the fan probably isn't 
spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and 
HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
No idea if this is correct though.

> +	*speed = data;
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 thermal_version,
> +				   u8 index, u8 *data)
> +{
> +	unsigned int offset;
> +	int ret;
> +
> +	if (index < EC_TEMP_SENSOR_ENTRIES)
> +		offset = EC_MEMMAP_TEMP_SENSOR + index;
> +	else
> +		offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
> +
> +	ret = cros_ec->cmd_readmem(cros_ec, offset, 1, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (*data == EC_TEMP_SENSOR_NOT_PRESENT ||
> +	    *data == EC_TEMP_SENSOR_ERROR ||
> +	    *data == EC_TEMP_SENSOR_NOT_POWERED ||
> +	    *data == EC_TEMP_SENSOR_NOT_CALIBRATED)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +	int ret = -ENODATA;
> +	u16 speed;
> +	u8 temp;
> +
> +	if (type == hwmon_fan) {
> +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> +		if (ret == 0)
> +			*val = speed;
> +	} else if (type == hwmon_temp) {
> +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, channel, &temp);
> +		if (ret == 0)
> +			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
> +	}
> +
> +	return ret;
> +}
> +
> +static int cros_ec_hwmon_get_temp_sensor_info(struct cros_ec_device *cros_ec, u8 id,
> +					      struct ec_response_temp_sensor_get_info *resp)
> +{
> +	int ret;
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_temp_sensor_get_info req;
> +			struct ec_response_temp_sensor_get_info resp;
> +		} __packed data;
> +	} __packed buf = {
> +		.msg = {
> +			.version = 0,
> +			.command = EC_CMD_TEMP_SENSOR_GET_INFO,
> +			.insize  = sizeof(buf.data.resp),
> +			.outsize = sizeof(buf.data.req),
> +		},
> +		.data.req.id = id,
> +	};
> +
> +	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*resp = buf.data.resp;
> +	return 0;
> +}
> +
> +static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +				     u32 attr, int channel, const char **str)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +
> +	if (type == hwmon_temp && attr == hwmon_temp_label) {
> +		*str = priv->temp_sensor_names[channel];
> +		return 0;
> +	}
> +
> +	return -ENODATA;
> +}
> +
> +static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +					u32 attr, int channel)
> +{
> +	const struct cros_ec_hwmon_priv *priv = data;
> +	u16 speed;
> +
> +	if (type == hwmon_fan) {
> +		if (cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed) == 0)
> +			return 0444;
> +	} else if (type == hwmon_temp) {
> +		if (priv->temp_sensor_names[channel])
> +			return 0444;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT,
> +			   HWMON_F_INPUT),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops cros_ec_hwmon_ops = {
> +	.read = cros_ec_hwmon_read,
> +	.read_string = cros_ec_hwmon_read_string,
> +	.is_visible = cros_ec_hwmon_is_visible,
> +};
> +
> +static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
> +	.ops = &cros_ec_hwmon_ops,
> +	.info = cros_ec_hwmon_info,
> +};
> +
> +static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv)
> +{
> +	struct ec_response_temp_sensor_get_info info;
> +	size_t candidates, i;
> +	int ret;
> +	u8 temp;
> +
> +	if (priv->thermal_version < 2)
> +		candidates = EC_TEMP_SENSOR_ENTRIES;
> +	else
> +		candidates = ARRAY_SIZE(priv->temp_sensor_names);
> +
> +	for (i = 0; i < candidates; i++) {
> +		if (cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, i, &temp) != 0)
> +			continue;
> +
> +		ret = cros_ec_hwmon_get_temp_sensor_info(priv->cros_ec, i, &info);
> +		if (ret < 0)
> +			continue;
> +
> +		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
> +							    (int)sizeof(info.sensor_name),
> +							    info.sensor_name);
> +	}
> +}
> +
> +static int cros_ec_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct cros_ec_hwmon_priv *priv;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	/* Not every platform supports direct reads */
> +	if (!cros_ec->cmd_readmem)
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->cros_ec = cros_ec;
> +
> +	ret = priv->cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_THERMAL_VERSION,
> +					 1, &priv->thermal_version);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Covers both fan and temp sensors */
> +	if (!priv->thermal_version)
> +		return -ENODEV;
> +
> +	cros_ec_hwmon_probe_temp_sensors(dev, priv);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
> +							 &cros_ec_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_hwmon_id[] = {
> +	{ DRV_NAME, 0 },
> +	{ }
> +};
> +
> +static struct platform_driver cros_ec_hwmon_driver = {
> +	.driver.name	= DRV_NAME,
> +	.probe		= cros_ec_hwmon_probe,
> +	.id_table	= cros_ec_hwmon_id,
> +};
> +module_platform_driver(cros_ec_hwmon_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_ec_hwmon_id);
> +MODULE_DESCRIPTION("ChromeOS EC Hardware Monitoring Driver");
> +MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net");
> +MODULE_LICENSE("GPL");
> 

But feel free to ignore me if I'm completly wrong about this, since I 
really don't have much experience with kernel dev.

Thanks,
Steve


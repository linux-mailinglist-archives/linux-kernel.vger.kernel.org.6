Return-Path: <linux-kernel+bounces-193279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2588D29B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFDC1C21BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8715A855;
	Wed, 29 May 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="s40PDuUC"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2143.outbound.protection.outlook.com [40.92.62.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148D2F2A;
	Wed, 29 May 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944319; cv=fail; b=fFHBS+X/rpb62tgmnxXmR/CMDEqukPbvWfdOIG5hcJC4Pxn2GQWwk4b24iCQWdfcUjkYuYEFQ13SIyE7nnA6rJchPYCWCms+ZsdVlkSsgFsLZVxNpFUpnoESd8WC8C9UwlihxRxRzKv6Vd5h4mcrWRj9x8l3WwdhM1606o1EldE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944319; c=relaxed/simple;
	bh=fn85pvff5ZRZa/WSv5iuBlHu28RBeLbz48LajbqNv8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TEM1RdEe7dIkRfKGqYCaTh8rPNH/oQ/QyPh2DV//6tkHkod8aa8jU7YPCAmHLHanHl1Ywyvj6McOInNFd3m1E6fEU1IJ0VnSh2y4FBhMBoz+13zHt2PYwKo6IHRm0nl2cyOgsmW/uxykTFHNSKw9XO8Wp8al1lVrm+LhbmvcoIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=s40PDuUC; arc=fail smtp.client-ip=40.92.62.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGdts9H0vsL51Urs3cIUqOEFQGY+9pMIx8uafY7X2EbWPGSMpWdKl33SoJXMxJbndQr2cI8q462/VzNlmGiNbhPohsMi9+PouaJO5UtXEVML4iK1OUM7jz11XXGFuZfRCfMWOzuIVG9xhIVU60nacg8a84oWFGhICT5lIdMb4sd3c5rf6Wyn1HXro5TMhcGA+5CY4KAycU9fJZyrhkurA6TYV0VAF24LqLm2Fyl5ln6kawDe8z2cZybi+Z1pghnQxXlI71i33S6VDcNCjIKSM1u0FaA1I/w7reEwTg4uZTDMbvREwRcPcEMer7Xh4dRR8kssUYJVdKBFB5SGmDdsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWeEVSlW96/E+/iPdYxgjndPup7n1XSwkI7ZE0+n8Tk=;
 b=PO8D9twgIKOAzmc6Z57IydPMyAuMwNhLxrCI0bkzwsZA1+eLHS46xgTZR2UwSteBbh3UatXXMIQZ+jmDGxLQbDwXQ+KEN0mIJjNKUQCA1mwqEjZ7wtvOqIaJCFCRyguWEDQWsbYD9HuuSgyuREajkXHA/g5AYeTernAMGqTBXlnZLE1SJ1sR05xH9/pZmcZ8t5mzZFJdXIR/LoQYEbo6C7ApIPoH5RwYFlJak33jPj01ykfwT+FNeeaVHB/DuQnUH98aQG6LV0kTWVR3SuudsZ4wMW71RRYpa7rEq+bDt906qs/Xjx5WKl/5EmTr46IVnvjhGjPtE43BGFQGOOVzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWeEVSlW96/E+/iPdYxgjndPup7n1XSwkI7ZE0+n8Tk=;
 b=s40PDuUCkr9QwADGxx5xFWyIj3ml6w16tELCRYa5V86wR5ArAu1FQTN69xiI9ZR5Wj3/5JhRvHEg2L1Ey7zbKU/v6mLZp0NQ1o4ZIpdrGqQyd264y0WNed2+Eh7e9fkHkR+Oc8f2LrIopQxueIJqvtw5svXwKpky2AWZUqjQ1WzDNTrwcA9b+LCt3bps7FCczDTWkk+TzG0WYv96B+SoJrLbtEQKd+svFjvA0biwVmFz9DhrJMYk7KkaSV/wXH0HvFj5N1ZyWWceeNEaE77JU4LBvEWb/IyneJXt5dOi6+3rOwd926CnLcCxQwZHh4RYXHgHuuLpkH3u8DrZHEQVXg==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY4P282MB3890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:192::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.17; Wed, 29 May 2024 00:58:31 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 00:58:31 +0000
Message-ID:
 <SY4P282MB30638301303268093B6D1ABFC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Wed, 29 May 2024 10:58:23 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
To: Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>,
 Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 chrome-platform@lists.linux.dev, Dustin Howett <dustin@howett.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Moritz Fischer <mdf@kernel.org>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
 <SY4P282MB306325BB023A95198F25A21DC5F12@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <c9b110eb-ff0e-41f2-9492-8a5d8c3c01d0@roeck-us.net>
 <b8072b36-688f-41b8-8b32-40fc4fa4d148@t-8ch.de>
 <6824f030-92da-4439-af3b-8c2498f4382e@roeck-us.net>
Content-Language: en-US, en-AU, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <6824f030-92da-4439-af3b-8c2498f4382e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [fIrBzQF835DN1v6Pu6DSA/RGOIKzgMKkq+tUgkAEwKz0VnfGWoK8lnUs+MAjpmLg5YjTKNNAax8=]
X-ClientProxiedBy: SYBPR01CA0126.ausprd01.prod.outlook.com
 (2603:10c6:10:5::18) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <eec75b2b-0f45-44df-822c-4d84a18ae245@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY4P282MB3890:EE_
X-MS-Office365-Filtering-Correlation-Id: d1813196-6899-4780-5fb1-08dc7f7a751e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003;
X-Microsoft-Antispam-Message-Info:
	D+b/wSiIAd0U7ur5Ga6D1Eg3RID/PMCkGmHhZ4kU7tVIxV2lSPSsMVbtsRCv2bVDvAWorpveOkHJJBQvKhMcKE9W7SPrdHKZFDu57kn2tmGNOk6yKYaV6b17c2VN2lScxzcwiDCGPleNaPQxZoJVRV8ouJKf/2oKl8dGcwWDeOsYPo7m7wO0BWnJqeDXGyTatdc76Ckt4NlyPa/M4pbG7nAB7aPVvPP6xZK59RkNABi9Ee2WCMD25E81aaGwkZQb098Y3Rq6PTHHzDscm4sLxkIyWQv0UHGtiObqbtjAD/QEFEWTCAqmmVDteI3l9AF01Y3u4bvdMpEwphPWwRSygTzM5bxuVarBPUKVsu1y1iaHixZXHZjRrAvtG2QJob7QNrGnpSkY+RrakJZ7qpumPEIxSa80giTQv3dVp0NqFN955udMuaW6MYwEYJDU4MwtU303KV/69sB60ADgxpB8q0YrSTo/dSClr0YMaNJ2PZvCkbFam4Rg0MSUpB5wBcsZXFK1F5yI0a2QJB0x4wt9vpb1XIS+Hh6CbuJwH6wq5T5IQy9Ez/0+JxN7ezOZYLUUTz1H5cwEAXyCSQfBCUTbsADMqbRNyHtAvruJPJVB6yiJzSd1uFu0hZGjO96M/dhRhwH646udhhLo0/QQXIxo1pUTnF8kX3doY5GLiQz4gvs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bThJV1hFL203cTdRMXBqdkxwTGdRdDR4UlBTM1hVMzdKR2JuN0RjWEZFYm5L?=
 =?utf-8?B?R01EcjRCLzlSU2R0QXphdkVhaHBjSElCeG5Xa2lqME5veVV1d3hNRGdDdFBN?=
 =?utf-8?B?REp3MVZVUWR5eDhlQkJQb2NOZnU2NjI4Tjk4bFAvRTlKcUs4RXJPZ1QrMUdq?=
 =?utf-8?B?dzRkZTZxOFhPbi84Wk1IUHQvclpidXdYcGltK3lNdXNKaFdxYVBxWHQ5QzZV?=
 =?utf-8?B?emtvNXI4NkJlWUVIbUlnZVAvT1Nid2lGanNkbFlrNUFmd0tVTXdhT1hpZWpt?=
 =?utf-8?B?Tnl3ZklBNW1mVTAvakpyaEVJZUNPbTA4M2lOZ3ArNnh0ZHF4dHlFRmVucmFa?=
 =?utf-8?B?R25qamJnY3llWlpVampFOEJGSUQxLzMvb2EwRTZWYUVKa3pFWk0rdm51UFdk?=
 =?utf-8?B?d3Q4WG16enUyajRyVzIyRmpzZ2N5MC81Y0p4Y2Evc2tIS2dBT0VIWUdCMmg0?=
 =?utf-8?B?RlN5ZmdTbXZkVTA4Zmt3bWJLSElJOWQ1YytyNTc5c2p0blV6S3NOQzBVeTVv?=
 =?utf-8?B?REdJRjh4RjRvMTBjUUtBTlIvM1RKczNHc2pDUURBeC9WbGlSczl1MER3TVV2?=
 =?utf-8?B?VGs4RFZrQ1BtOUVzYWk2UjN2ck5tR2pzWnowbzVqQXI2Y1FPbC9OK0JRL0do?=
 =?utf-8?B?YTk4SW1Uem9DVDR0S3ltUDY0UnJqcUQ1aGxzcmU5Zm5iZnRzZEsyMnMzaG1J?=
 =?utf-8?B?OVJ5RnltcU5Pc2RjRkJ6VnNWUStKSlMwM3RTODNXa0tGdkxEeHEwc3N0K29x?=
 =?utf-8?B?SS93K09OaEpVNExFYngzVjdwRVlsNWdjck45bFJEcDB5RXNmRXlCTHpuam8x?=
 =?utf-8?B?eFRCZnNxZ3Y0WlAvWWNnQUMyUXBDQnBtbnBJbnpReDNMREZOcngwR3Z1VXVN?=
 =?utf-8?B?VXBLcWNaTVl5ZU1wQVlYdTM2dFh5VkRDWWVma0RMRWlYb2dKT2RLNVV3NlRp?=
 =?utf-8?B?ajRPK3lPbzVvam1ya0NIdGhXdjZwbFMrd0QxbDRJK213OGQrd1k4U2Q1SEwv?=
 =?utf-8?B?bGZiNGc3Wnl0eTI1S21wV1RvSVJjSElqK1dtTHJzbHErOGs5VHMvOXVKRnFU?=
 =?utf-8?B?MjBqUmEzeVJpUk4vem5RZGhnQU4wMXUzOCtDU2VqaWRkd3krK3M5MER1Rkla?=
 =?utf-8?B?bzZ4QXU1eHJlVjhmMWdBc1lpOVlpZWVqM3liS0kwekROTnRtblB2cGFxUjZ6?=
 =?utf-8?B?N28rYUhkRk5ndEdrbjBMT3FPVEdBV1hRY25iSm1uN05YcVJFbGgvU3NFQ002?=
 =?utf-8?B?OEErMU9wYnBIa1c5ZWhLWEs4d2lsbGk4amVKSlBKNG9UREJuRFJFSnBaS0tp?=
 =?utf-8?B?RERIZDljbkJjKyt3a1FqQld4Vzkyc2ROWnpxczBIV3daVy9qT0h1dG5kQkR1?=
 =?utf-8?B?ckZnMGNzazVjRmNxdjZuTElVanJtQmNkYXNsZEZ4ZWlxbXk0d0ZiYUE2YlM1?=
 =?utf-8?B?Mjl2TndKZ0tJcEYyYlZrbzhZVXdYUWlTem1PSHBlTE0xb1hEUC94UGh6SFE1?=
 =?utf-8?B?TW5WYklKR0xUQXhFY0c5ZlZXUm1UTDE2eEtZMEhSVDdqU2wvUWcyQ0NCNGxi?=
 =?utf-8?B?VW5pTUw3eEVlMzA3TXFHMmc1aEVkQ2FsN1hHSCszMHFIRDRITFEwWnUxei8v?=
 =?utf-8?B?UncvYVFndy9EaFE2cGJkZnFyTkd1c2wzSW5sWHJFTDZKaWhxdHVab2FaWU1S?=
 =?utf-8?B?Ulp1MlQ1N01Udk5scnVqeGlWWkFXZngzb2I3TUhCUUhNRHJ5VDNxcXhlSUNn?=
 =?utf-8?Q?I44a3ZbhFF0ggY70lqrbA0Gv0umanNPTLmF4908?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d1813196-6899-4780-5fb1-08dc7f7a751e
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:58:30.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3890

Hi Guenter,

On 29/5/24 09:29, Guenter Roeck wrote:
> On 5/28/24 09:15, Thomas Weißschuh wrote:
>> On 2024-05-28 08:50:49+0000, Guenter Roeck wrote:
>>> On 5/27/24 17:15, Stephen Horvath wrote:
>>>> On 28/5/24 05:24, Thomas Weißschuh wrote:
>>>>> On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
>>>>>> I was the one to implement fan monitoring/control into Dustin's 
>>>>>> driver, and
>>>>>> just had a quick comment for your driver:
>>>>>>
>>>>>> On 8/5/24 02:29, Thomas Weißschuh wrote:
>>>>>>> The ChromeOS Embedded Controller exposes fan speed and temperature
>>>>>>> readings.
>>>>>>> Expose this data through the hwmon subsystem.
>>>>>>>
>>>>>>> The driver is designed to be probed via the cros_ec mfd device.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>>>>>> ---
>>>>>>>     Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
>>>>>>>     Documentation/hwmon/index.rst         |   1 +
>>>>>>>     MAINTAINERS                           |   8 +
>>>>>>>     drivers/hwmon/Kconfig                 |  11 ++
>>>>>>>     drivers/hwmon/Makefile                |   1 +
>>>>>>>     drivers/hwmon/cros_ec_hwmon.c         | 269 
>>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>>     6 files changed, 316 insertions(+)
>>>>>>>
>>>>>
>>>>> <snip>
>>>>>
>>>>>>> diff --git a/drivers/hwmon/cros_ec_hwmon.c 
>>>>>>> b/drivers/hwmon/cros_ec_hwmon.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..d59d39df2ac4
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/hwmon/cros_ec_hwmon.c
>>>>>>> @@ -0,0 +1,269 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>>>> +/*
>>>>>>> + *  ChromesOS EC driver for hwmon
>>>>>>> + *
>>>>>>> + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/device.h>
>>>>>>> +#include <linux/hwmon.h>
>>>>>>> +#include <linux/kernel.h>
>>>>>>> +#include <linux/mod_devicetable.h>
>>>>>>> +#include <linux/module.h>
>>>>>>> +#include <linux/platform_device.h>
>>>>>>> +#include <linux/platform_data/cros_ec_commands.h>
>>>>>>> +#include <linux/platform_data/cros_ec_proto.h>
>>>>>>> +#include <linux/units.h>
>>>>>>> +
>>>>>>> +#define DRV_NAME    "cros-ec-hwmon"
>>>>>>> +
>>>>>>> +struct cros_ec_hwmon_priv {
>>>>>>> +    struct cros_ec_device *cros_ec;
>>>>>>> +    u8 thermal_version;
>>>>>>> +    const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + 
>>>>>>> EC_TEMP_SENSOR_B_ENTRIES];
>>>>>>> +};
>>>>>>> +
>>>>>>> +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device 
>>>>>>> *cros_ec, u8 index, u16 *speed)
>>>>>>> +{
>>>>>>> +    u16 data;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 
>>>>>>> 2, 2, &data);
>>>>>>> +    if (ret < 0)
>>>>>>> +        return ret;
>>>>>>> +
>>>>>>> +    data = le16_to_cpu(data);
>>>>>>> +
>>>>>>> +    if (data == EC_FAN_SPEED_NOT_PRESENT)
>>>>>>> +        return -ENODEV;
>>>>>>> +
>>>>>>
>>>>>> Don't forget it can also return `EC_FAN_SPEED_STALLED`.
>>>>>
>>>>> Thanks for the hint. I'll need to think about how to handle this 
>>>>> better.
>>>>>
>>>>>> Like Guenter, I also don't like returning `-ENODEV`, but I don't 
>>>>>> have a
>>>>>> problem with checking for `EC_FAN_SPEED_NOT_PRESENT` in case it 
>>>>>> was removed
>>>>>> since init or something.
>>>>>
>>>
>>> That won't happen. Chromebooks are not servers, where one might be 
>>> able to
>>> replace a fan tray while the system is running.
>>
>> In one of my testruns this actually happened.
>> When running on battery, one specific of the CPU sensors sporadically
>> returned EC_FAN_SPEED_NOT_PRESENT.
>>
> 
> What Chromebook was that ? I can't see the code path in the EC source
> that would get me there.
> 

I believe Thomas and I both have the Framework 13 AMD, the source code 
is here: 
https://github.com/FrameworkComputer/EmbeddedController/tree/lotus-zephyr

The organisation confuses me a little, but Dustin has previous said on 
the framework forums 
(https://community.frame.work/t/what-ec-is-used/38574/2):

"This one is based on the Zephyr port of the ChromeOS EC, and tracks 
mainline more closely. It is in the branch lotus-zephyr.
All of the model-specific code lives in zephyr/program/lotus.
The 13"-specific code lives in a few subdirectories off the main tree 
named azalea."


Also I just unplugged my fan and you are definitely correct, the EC only 
generates EC_FAN_SPEED_NOT_PRESENT for fans it does not have the 
capability to support. Even after a reboot it just returns 0 RPM for an 
unplugged fan. I thought about simulating a stall too, but I was mildly 
scared I was going to break one of the tiny blades.

>>>>> Ok.
>>>>>
>>>>>> My approach was to return the speed as `0`, since the fan probably 
>>>>>> isn't
>>>>>> spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
>>>>>> HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
>>>>>> No idea if this is correct though.
>>>>>
>>>>> I'm not a fan of returning a speed of 0 in case of errors.
>>>>> Rather -EIO which can't be mistaken.
>>>>> Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which should never 
>>>>> happen)
>>>>> and also for EC_FAN_SPEED_STALLED.
>>>>
>>>> Yeah, that's pretty reasonable.
>>>>
>>>
>>> -EIO is an i/o error. I have trouble reconciling that with
>>> EC_FAN_SPEED_NOT_PRESENT or EC_FAN_SPEED_STALLED.
>>>
>>> Looking into the EC source code [1], I see:
>>>
>>> EC_FAN_SPEED_NOT_PRESENT means that the fan is not present.
>>> That should return -ENODEV in the above code, but only for
>>> the purpose of making the attribute invisible.
>>>
>>> EC_FAN_SPEED_STALLED means exactly that, i.e., that the fan
>>> is present but not turning. The EC code does not expect that
>>> to happen and generates a thermal event in case it does.
>>> Given that, it does make sense to set the fault flag.
>>> The actual fan speed value should then be reported as 0 or
>>> possibly -ENODATA. It should _not_ generate any other error
>>> because that would trip up the "sensors" command for no
>>> good reason.
>>
>> Ack.
>>
>> Currently I have the following logic (for both fans and temp):
>>
>> if NOT_PRESENT during probing:
>>    make the attribute invisible.
>>
>> if any error during runtime (including NOT_PRESENT):
>>    return -ENODATA and a FAULT
>>
>> This should also handle the sporadic NOT_PRESENT failures.
>>
>> What do you think?
>>
>> Is there any other feedback to this revision or should I send the next?
>>
> 
> No, except I'd really like to know which Chromebook randomly generates
> a EC_FAN_SPEED_NOT_PRESENT response because that really looks like a bug.
> Also, can you reproduce the problem with the ectool command ?

I have a feeling it was related to the concurrency problems between ACPI 
and the CrOS code that are being fixed in another patch by Ben Walsh, I 
was also seeing some weird behaviour sometimes but I *believe* it was 
fixed by that.

Thanks,
Steve


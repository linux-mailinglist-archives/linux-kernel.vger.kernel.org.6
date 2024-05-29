Return-Path: <linux-kernel+bounces-193604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6DF8D2E83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEB01C221C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEB0168C24;
	Wed, 29 May 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="NyqAMAie"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2162.outbound.protection.outlook.com [40.92.62.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A127167DAB;
	Wed, 29 May 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968428; cv=fail; b=Lzi0OkA1MjjoHPhZQAYn1J8gZihZs8CDz+OVEiiq/B1TXAv6u6PaTQB9X5lh8draoCnMWqxx5DXdPZtmsXCGzV1mcTh0J+D5A1XYuU5Jy+lIH868rh+CU3CGS39yEtjWFN5ImSnLkTSBo5Q2I193Ai3hyL/G7n2Trn8n8Vihmrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968428; c=relaxed/simple;
	bh=z05svW3AQWr6HjAHcqqVA50+Ji+XIL4CC9+8JASQab4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cNOvJplupuwOOM97+OcFLeCmsGasstrjq/+5wRoNIC1/bmk/rNc6cQS78WCo8s113qkp/3jHDZOo6jux0jr/UeXqjbhdjHOQCCHaUP8hnkgASDbQSnS2L59lAcFn5KRN7cpvd677Lmun4nzuyLjNshvmgvHXpVlsI4CHWxB3LcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=NyqAMAie; arc=fail smtp.client-ip=40.92.62.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGmJlRO+niZzPA1/qAgB/quFU5m2hEKFm/ApkOieTmc5AA6it+pcvZxXDIVQ5btroSF9YyqwRkRe+DrDnL3tgJLJrIpY9Uzm2tD7y+Germ1EMH/wSZmjMOOfuDSRKROTkywoBm1cjP3i7Fv6Lk3EKyILIQfkX8Ov2HOnJCadYCNqaMkW2pni18jiBd18Icq3YAlyxuDcj1f9mvmySxOJ9euylvED00DSel3wqxHS4OjYA44ADf6y+MSUtMmNs0KwCh39xE9y11QbFxNLN7cDSU50U9xJyMbdgDF3IGpLMepxJPZF8Ltf9zy1r7vUs5lYl4OFUeoICkJhrIAJXVByFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrUTTxlqPy9Sgk3B/ch+IC3JsPHAWaMQnaLMKuR7ggw=;
 b=XJqF3/0Y1oGdT0SzHHEY/c/tvr1AORwJCD17MNQK+X9zihSZbA2h+YoaHbu2x/gPyhEjlD0MYTSU2pAzhlSSPlMU6UAE6qp8pj0tjmmTsJm0fHC4L/PSXDQf8GRMoyZXJP3UXd1XOceIsIML1uiY1BNyaSRtQBHQswQ5VU2bi1pe3leEEiddr0iOUsfhrZ+hUDCJX3y7OQy3qx7lg5ljkEMhQ5/n3V930hjxipL/4Erg0yE2c4NlaF+StjnLUPHx0TxIgiaPZAupposUg39dnp5vGByBSDaC8KFmeOCIJnXSCeUX1I+8CaM/HQQKY5SdfdIPm6WXi9Riu/JwJ6mTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrUTTxlqPy9Sgk3B/ch+IC3JsPHAWaMQnaLMKuR7ggw=;
 b=NyqAMAieas15lMXZ4F3mVGduVStDgMqkgsnBgWoavYTLzSVmyLVW+v+Zcg8ehpawsA5XRcWOOlwfRjn+CuqL/uHpvbIZBNjncVyl8dlXrww3WfCbEeAHTpm4c18V/Vs1wIh4DHIKFadV/vXa4V02lukZNcdu8sGJFpTtG7Cw8nNj1yFI3hwE5+vCvqUfWooLYMBTk1bUUhmU8otde/wOFwbDzvPcSzVLFBwhhzRcSOhq0roU3RevtcOb+4x0otsiojqz+S1k6fS4KW/Tk4mfvrP0xo8ikfNat/GvU0T2ARl71ExCazIgF9JaYlKoN5b/LmahGAZ4p41W39O5sW2/8A==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY7P282MB5422.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2aa::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.32; Wed, 29 May 2024 07:40:20 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 07:40:20 +0000
Message-ID:
 <SY4P282MB30634D9D9873C9C8DC41D4EEC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Wed, 29 May 2024 17:40:17 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Guenter Roeck <linux@roeck-us.net>
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
 <SY4P282MB30638301303268093B6D1ABFC5F22@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <22a16af6-93c4-454c-853b-5959a5c018d3@t-8ch.de>
Content-Language: en-AU, en-US, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <22a16af6-93c4-454c-853b-5959a5c018d3@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [PWnOvbn639UiqV6EpRMzE8ns8KSl9u7fkHKh1+9XzVbifkSxFn/HGfi0EaXTxJ9Atmi6958qNuM=]
X-ClientProxiedBy: SYBPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:10:1::15) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <7d54b16d-c2f5-41be-a931-a24f74916adc@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY7P282MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e657bc2-6743-4b65-08d5-08dc7fb2976e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	Hen3c/i1itJvNLMC+FZJ8cYtuYvUZbtCDpcSPmApyK9pijMA4JskDlbHHdDVi0nWxuikoN3PiZ9VQeJOhNx2ijWK0ZiKxzxf0ERK01sae436cNB/IfH855kbeBYMlKOCtE6e+Q+DAKTlix+uc71Yi1hWvJmRUsMHT7LqtT+vdsskOz4naNQuB06Oodd/kYe3GuF/mvm1kkvGDCxRJxUPtth7hqFFIwXrYI0d9uHOxd2rYI8zLRU7NYrC/g/yfxq7n+v5g+lnqds64QKtutnyppRLrlb8NI5gOl9f8gZQ8VNYI62dW79BZh9q2OeXMtGjZeOBCsVPHqJHUGUHwNMAFlBOJOC75kOYT1en+PeXtL5uZOMRTp+Ki9aWJ6VGKiuFQFRARA7a8kxs3kKSpSk+6JRtcDrD4XuzM4LdjK8ijtgBHjKIhRcB4Fp7w+BOk3xECdh2Jgg59Nzxoplfm1xtd83ZNyaPodqXSS/3kJracBAMcArMl3saxHlY5FVI20ADbLjYx1/qBmNCBUjz9agYptau6CMQ51X/9w7+isYIYSMmpdvf8jqepkqn/4d7fU9p5vymx/ZOLx2LO2Tp7ERdnmYUTGQCkXuI6i+4lXG6fSywjj4GTjscYOxAPWuEms5ZyD0ywXXFhEIqOdRTOw+vwehmhMZQrzn2BQ3OflXXfuE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHBwSXNwcDVncFI3K1h3VnNETTRPaTZOemZ4YUg0S29aQWg3QzEzNitKUjBs?=
 =?utf-8?B?ZzUzUHFwR0FGWnA2TmNIWWZsWHc5OXJxYy81UklSeWtGMUNFNU1lOXZGYTRC?=
 =?utf-8?B?aCtzZ085SFQ4SlNNeldqSVErMWVha3pCY1kxajIzbWR6N0V3M05kS2VvM0t0?=
 =?utf-8?B?SEdLMWlLL1NBVkY4VWk3R3BNT2lGQzJvNlllZ2pnT1p3emhITk95QklLMmR1?=
 =?utf-8?B?K2wza2dxKzJmMDdFM2tlSndkbkYrUmszRzNBbzlnQ212ZU8yNWVTalhDdzh2?=
 =?utf-8?B?NFNYcEwwb1lUT29DcEx5azZuenpDeXo3b25uZUgrUUNZcmxPSFhYRTVDZGdq?=
 =?utf-8?B?NnJkVUw0MnlmYjdKL05UK053bjdBM1JsdC9DMmpOeWJJTUU5VDRTbHlOemx1?=
 =?utf-8?B?WkwvUWNUeEZ2Tm9waXVvTWhZYUpvcnI5UXFmdFNFWWtRdlkwM3BhamF2dmdj?=
 =?utf-8?B?Ui9BU2NnYWxSU09XN3dZLzV3WGRITmVxSEkyY2xnT3Yvb21QeWxkQXNEcy9X?=
 =?utf-8?B?VGV3Z3dEK0tZWFRNUThlUnVrY2ljUVc1VkF2WEF1MjVFNGoySmNid2dGeFRF?=
 =?utf-8?B?NGxLWDJRdWI5VGpkRHJFaEhtRGRDSFNTK3ZoTkx5bDJDSk9VMmpidFFmNmR4?=
 =?utf-8?B?Y1YrbnNkZUZKWHI1S0xtVHYyQlJYc2xnR085ajFWQ1FVQnVOTkp6ZkZMaXRw?=
 =?utf-8?B?WVhQVk1FZDhDVkFtVEVZdkN4REFoaEtKRnMyNkNxbDdEOXNVdGp5OTJuUEV3?=
 =?utf-8?B?NW1LejRUWjNTWW5IMkhIYk1OY2JPNDVWSXpMUWJETjNsdVdxaUZLVHB0MjE5?=
 =?utf-8?B?SXlMMzlEMjZrdjhzTURuSHQxa3Y2QWRTenk5aXlqTGNnK2kvUHc0dUVIZ20w?=
 =?utf-8?B?QXNVa0pkb1FKZ1FrNityaEx3V3hlWENZL3dQeDZuV1NlbHIybHd2NzhmbnlV?=
 =?utf-8?B?Z2plNkYvR3hibmw2MVV0RmF1OHc4Mll3YnFMUXR4MEFJSXQ2bHU2cGphZzl5?=
 =?utf-8?B?TVY5akRyNmRyNDlldjROa2szUDloTDJNcTdUajFDUWNacklxcXVnQndIMlNB?=
 =?utf-8?B?QmdhMlhpZUFMS1J5NjdsYlQ2U3Vpa2k0eFIzeGFjcnJiaUJqcVlFc08rNXFO?=
 =?utf-8?B?cndlUlhyenpBZDRWV0JSeFpvRUtPdm45ZHkyNk5GaVVhQ1F5MEY0ZFFUakxp?=
 =?utf-8?B?Y2tvelIybDhJVEtzRHRPTVZOUzluY05oelNNVmg4YXI3WTNYcnB6ZW5ZZFBQ?=
 =?utf-8?B?S2hRekE5cDBuSEw5VDk0ZHZ5aGZpSFE0RUcwc2JQdldpMnpGb0xpNjk0L3lo?=
 =?utf-8?B?TVF0U05kRHRndjJENGNrbmh4c0l4dEE5NmdFWUkwZTJrTXUrM1paOGNxV0NJ?=
 =?utf-8?B?bWtaL2JmTjRHM2xmc2l1NmtnN1M2TDFwYlZlbERKc2dIdSt1RjNSNWlTTGsw?=
 =?utf-8?B?MnhMRC9MaUhrMURvay9jSGhDVERKVStUSW91aHgzRkhEOFVhNUJERldBQXky?=
 =?utf-8?B?dEFjM2p6VWlaakJxQU1mNXJEZmplclpaa1Y0L0FHOVViaDV3VE9leWl5bTJT?=
 =?utf-8?B?eHBDOEhibzFTUGErN1NUc3R6NHhPeUc1SElhUEo3U21pSWNXdTZrd2IvL2pZ?=
 =?utf-8?B?Z0N0R1kwMlM0RzM4KzVYQjRVTUthWFV6cE42S0JCdEp2b3pTWlordkZVK3dF?=
 =?utf-8?B?aVlIOG0rMFE2aXd3UHJBZjNDaDBKdEd3QXhlY0ZmZG1ST0xXUmUxTFdCelpP?=
 =?utf-8?Q?pZhCek+wistyWoZWSSmkIDIqstTDKrQaLPuA8vv?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e657bc2-6743-4b65-08d5-08dc7fb2976e
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 07:40:20.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5422

Hi Thomas,

On 29/5/24 16:23, Thomas Weißschuh wrote:
> On 2024-05-29 10:58:23+0000, Stephen Horvath wrote:
>> On 29/5/24 09:29, Guenter Roeck wrote:
>>> On 5/28/24 09:15, Thomas Weißschuh wrote:
>>>> On 2024-05-28 08:50:49+0000, Guenter Roeck wrote:
>>>>> On 5/27/24 17:15, Stephen Horvath wrote:
>>>>>> On 28/5/24 05:24, Thomas Weißschuh wrote:
>>>>>>> On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
>>>>>>>> Don't forget it can also return `EC_FAN_SPEED_STALLED`.
> 
> <snip>
> 
>>>>>>>
>>>>>>> Thanks for the hint. I'll need to think about how to
>>>>>>> handle this better.
>>>>>>>
>>>>>>>> Like Guenter, I also don't like returning `-ENODEV`,
>>>>>>>> but I don't have a
>>>>>>>> problem with checking for `EC_FAN_SPEED_NOT_PRESENT`
>>>>>>>> in case it was removed
>>>>>>>> since init or something.
>>>>>>>
>>>>>
>>>>> That won't happen. Chromebooks are not servers, where one might
>>>>> be able to
>>>>> replace a fan tray while the system is running.
>>>>
>>>> In one of my testruns this actually happened.
>>>> When running on battery, one specific of the CPU sensors sporadically
>>>> returned EC_FAN_SPEED_NOT_PRESENT.
>>>>
>>>
>>> What Chromebook was that ? I can't see the code path in the EC source
>>> that would get me there.
>>>
>>
>> I believe Thomas and I both have the Framework 13 AMD, the source code is
>> here:
>> https://github.com/FrameworkComputer/EmbeddedController/tree/lotus-zephyr
> 
> Correct.
> 
>> The organisation confuses me a little, but Dustin has previous said on the
>> framework forums (https://community.frame.work/t/what-ec-is-used/38574/2):
>>
>> "This one is based on the Zephyr port of the ChromeOS EC, and tracks
>> mainline more closely. It is in the branch lotus-zephyr.
>> All of the model-specific code lives in zephyr/program/lotus.
>> The 13"-specific code lives in a few subdirectories off the main tree named
>> azalea."
> 
> The EC code is at [0]:
> 
> $ ectool version
> RO version:    azalea_v3.4.113353-ec:b4c1fb,os
> RW version:    azalea_v3.4.113353-ec:b4c1fb,os
> Firmware copy: RO
> Build info:    azalea_v3.4.113353-ec:b4c1fb,os:7b88e1,cmsis:4aa3ff 2024-03-26 07:10:22 lotus@ip-172-26-3-226
> Tool version:  0.0.1-isolate May  6 2024 none

I can confirm mine is the same build too.

>  From the build info I gather it should be commit b4c1fb, which is the
> current HEAD of the lotus-zephyr branch.
> Lotus is the Framework 16 AMD, which is very similar to Azalea, the
> Framework 13 AMD, which I tested this against.
> Both share the same codebase.
> 
>> Also I just unplugged my fan and you are definitely correct, the EC only
>> generates EC_FAN_SPEED_NOT_PRESENT for fans it does not have the capability
>> to support. Even after a reboot it just returns 0 RPM for an unplugged fan.
>> I thought about simulating a stall too, but I was mildly scared I was going
>> to break one of the tiny blades.
> 
> I get the error when unplugging *the charger*.
> 
> To be more precise:
> 
> It does not happen always.
> It does not happen instantly on unplugging.
> It goes away after a few seconds/minutes.
> During the issue, one specific sensor reads 0xffff.
> 

Oh I see, I haven't played around with the temp sensors until now, but I 
can confirm the last temp sensor (cpu@4c / temp4) will randomly (every 
~2-15 seconds) return EC_TEMP_SENSOR_ERROR (0xfe).
Unplugging the charger doesn't seem to have any impact for me.
The related ACPI sensor also says 180.8°C.
I'll probably create an issue or something shortly.

I was mildly confused by 'CPU sensors' and 'EC_FAN_SPEED_NOT_PRESENT' in 
the same sentence, but I'm now assuming you mean the temp sensor?

>>>>>>> Ok.
>>>>>>>
>>>>>>>> My approach was to return the speed as `0`, since
>>>>>>>> the fan probably isn't
>>>>>>>> spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
>>>>>>>> HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
>>>>>>>> No idea if this is correct though.
>>>>>>>
>>>>>>> I'm not a fan of returning a speed of 0 in case of errors.
>>>>>>> Rather -EIO which can't be mistaken.
>>>>>>> Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which
>>>>>>> should never happen)
>>>>>>> and also for EC_FAN_SPEED_STALLED.
>>>>>>
>>>>>> Yeah, that's pretty reasonable.
>>>>>>
>>>>>
>>>>> -EIO is an i/o error. I have trouble reconciling that with
>>>>> EC_FAN_SPEED_NOT_PRESENT or EC_FAN_SPEED_STALLED.
>>>>>
>>>>> Looking into the EC source code [1], I see:
>>>>>
>>>>> EC_FAN_SPEED_NOT_PRESENT means that the fan is not present.
>>>>> That should return -ENODEV in the above code, but only for
>>>>> the purpose of making the attribute invisible.
>>>>>
>>>>> EC_FAN_SPEED_STALLED means exactly that, i.e., that the fan
>>>>> is present but not turning. The EC code does not expect that
>>>>> to happen and generates a thermal event in case it does.
>>>>> Given that, it does make sense to set the fault flag.
>>>>> The actual fan speed value should then be reported as 0 or
>>>>> possibly -ENODATA. It should _not_ generate any other error
>>>>> because that would trip up the "sensors" command for no
>>>>> good reason.
>>>>
>>>> Ack.
>>>>
>>>> Currently I have the following logic (for both fans and temp):
>>>>
>>>> if NOT_PRESENT during probing:
>>>>     make the attribute invisible.
>>>>
>>>> if any error during runtime (including NOT_PRESENT):
>>>>     return -ENODATA and a FAULT
>>>>
>>>> This should also handle the sporadic NOT_PRESENT failures.
>>>>
>>>> What do you think?
>>>>
>>>> Is there any other feedback to this revision or should I send the next?
>>>>
>>>
>>> No, except I'd really like to know which Chromebook randomly generates
>>> a EC_FAN_SPEED_NOT_PRESENT response because that really looks like a bug.
>>> Also, can you reproduce the problem with the ectool command ?
> 
> Yes, the ectool command reports the same issue at the same time.
> 
> The fan affected was always the sensor cpu@4c, which is
> compatible = "amd,sb-tsi".
> 
>> I have a feeling it was related to the concurrency problems between ACPI and
>> the CrOS code that are being fixed in another patch by Ben Walsh, I was also
>> seeing some weird behaviour sometimes but I *believe* it was fixed by that.
> 
> I don't think it's this issue.
> Ben's series at [1], is for MEC ECs which are the older Intel
> Frameworks, not the Framework 13 AMD.

Yeah sorry, I saw it mentioned AMD and threw it into my kernel, I also 
thought it stopped the 'packet too long' messages (for 
EC_CMD_CONSOLE_SNAPSHOT) but it did not.

Thanks,
Steve


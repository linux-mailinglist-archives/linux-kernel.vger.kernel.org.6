Return-Path: <linux-kernel+bounces-191536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C008D10CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4873B1C219C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A5524C;
	Tue, 28 May 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="IPZtpYY0"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2175.outbound.protection.outlook.com [40.92.62.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698C1C2E;
	Tue, 28 May 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855319; cv=fail; b=ZzrTzxJNRLIlMKsiUKL1OkPNnAH9+OyNUxr0Ofwg97+pcOIyQ4TSJ199onv1e1y1IqAExK6IE7FGSXX8ydbN6wpi/0DSP593hql40g82lwyIzYGRLVrhRIP/bbHcV6uL525ps4S7Z4OPPON83sl4TugtKozHfclZ+37lPl0dPOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855319; c=relaxed/simple;
	bh=90e6m1KDJT4xqokGbtqOX7cBcOuGv7j4mKkFzHj64cY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZN6atGb4FzE3nJmdWFJUKRXCZqk1bqg7zUMLh2sf/ID8yJBrioDg8sNu6uFEM8/sOndgg26doToFoed7ZQs/67N/I/RI82jX6VPgxqhNDckp7aivbl2TANQwuh6GBYaTWnvjxUSYv8ZgmipnrL7Pum+igJM1jc+mxV9pMq5xQWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=IPZtpYY0; arc=fail smtp.client-ip=40.92.62.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx5rnUi22r/CM0y7z+sIUhLGzfQE5brqJc5qztmc5NYHMdrRdST1f99ymOMfrnddWFSJ35XAbl2vgIuHhP5sn0rsvE2V7mVhwuUx9I6YrDfpoeJWKT7XCj39Eqq7l6iEZA4eD8sGd7vuwFJ6TBKoO+P1Q+ei2uA0XKM9DWTz4tV5uCHDatOreF45orJvVAJRlBuI1IKEFZvP3zOxeccq8pdZOBMl28GCy1la6yuplOdbbQVINCENLCkLWEOp5tCfvoAyG3/Kxs63NXrWfW+N1pEatJRupCDqWL4WX5+G9u/MSGWOcP8UQmjP3MAyTWJKis3zitt3ehMTVWSRw/56EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeuRbDbRPSeoN/NQPerRg+mE5D4j9YQnmsHKZARBN4I=;
 b=SMemRRnziKcq9uxwbgVl+QcHZlfLH88VIqj2mDSCesfOaCoinGcIf5oBgPy/W6edbVf6iTx9mwdqpfqY75GxOl+kc+aDJbVQnRzAJ1jjdUTRjaDpWe5V7oluuou/wJGr+sYpJ48UB4OamWjPG7wr0pHv9vsA3HDB+LuwLUJ5ojVuyd/uTH9o5o6Hk9wSYEQ7hJe1FQHaI9fQhSKBhTh2sDxE+mfH0cUS9mlsgl5QUoKcvbN30A6RTT3zXo11Z2Gh7OFfDRaJ53zbDdtEwpKeMNvn2diprv+3X5HG9yLQNNwiQucKxOUc4Vp4latbslaaUSjiKRKcjXGwxAA+QiumiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeuRbDbRPSeoN/NQPerRg+mE5D4j9YQnmsHKZARBN4I=;
 b=IPZtpYY0oCmCrGa5po7FXsgamylAvAledmvf6N3+gpUEcPwrKzFDEx2ie0OPHVeA4dXjzPuUoeI9n96V9HDGkfX5dLTS6aZTFHLKWRa0rVtOzBJTg+wWPrvHO4Qv22OZEeufn2vdzomP0TKLxWBXvUVC3cdl2FT/WU8qP3CquhS+0C/jx/nj4KmeTOP4Dv/0RhTyAeWv9/l+yGEP9eVvqVpOLsA0CSf3AmKjR1u38arkYlcpQk2I7H2G51opUX5C+io0giV/YF361mYg7eDE4v8SK7ySmZBsIDCiFqs5EfiK1ZnoBm8aTLWQ9uPtheQwDRzKf+mcYAbt/nmPaebOdg==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY4P282MB4063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 00:15:12 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%3]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:15:12 +0000
Message-ID:
 <SY4P282MB306325BB023A95198F25A21DC5F12@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 28 May 2024 10:15:07 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
 Dustin Howett <dustin@howett.net>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Moritz Fischer <mdf@kernel.org>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
Content-Language: en-US, en-AU, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [BTsNHsXHuhtysAkuhLqjXdner2haDh0n]
X-ClientProxiedBy: SY5P282CA0187.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::8) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <a03afa01-7fac-4334-8a43-14f82381ec5a@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY4P282MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 5145812a-4d6c-4940-55f6-08dc7eab3da2
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	lb3rXTXutQwqhmqITuTSdjJU43+1YSYp2b8Zid0fpwpcQ76A43PXZBJcZujAa62meYLShl8WgDzEqz59+OJuip4P2CIZteRImzOk4nP7IHEG8PXD+v+/m2M3+MbxIeW7dTFijdmdeWdnl3HWxWwRPgxp4XxgDZh7WbAN362xgfeDAICciAONsQRoe8jRWYSDz02PS6JAdn52I9ivjSQr0N2/BlcrEZ/IA07fPxtR2RkvPc1OV4iJXAnmqdNVJDvBDBX4Aj2d1x7m1XQIcCHhf8qmt7X7Dk2ggcE983qHVfbwy6O6qedZnU2JUE1i9fWv9dSWl3w/hmquGy/gjPikfdvF7LXTb4FjG1WI5o00Vja0Htn7vGSx8bC1zXvUWthlMm/53NvPdmfDcI5U7I9zHQxFnwxdWnY1LBvlWLsInyfM0FtYFz4T6XhCkpXmR29LVR7efvFctGAir4HKIGi8w+NbFB/jWtGqECBQn5NeK7d8lbzAK6u0k1tr4XrUJOu8ys3RtHJyN66dyGjJU89Ytlt6auknYwPkJy8Pq72jSVq7kGP9VB38Tuqsy9vAzHZX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmsxYXhkY0VFN1ROYjQ4ZUZDRVJzalRNREdvWFNlWE0rTW5JQ2lUdlhXT0Vp?=
 =?utf-8?B?Z0F2dTdiSGhOcXFNSlpHUDhzSldpWVdFRzhxQk43UnNWK1I0T3IrUXVIQStl?=
 =?utf-8?B?T1NrQmZVYVNZTmltWVV5Ty93ODU3UnlBUXJiQWRBZW4zUzVINlQwSnAxQnp4?=
 =?utf-8?B?dDdYL0JIOHNURW8yYnhJT010bzBlOVRKT0NZdGljbmFmQ3lSd1lmSks3b2Zt?=
 =?utf-8?B?czQ1SUd4ZENFbzhEbVVrTmM5QTNrdjZOOS9aaWx2WFk3aUMybVRmeElzN1Fa?=
 =?utf-8?B?OEVQQ2VWektIeDYwYllnZFk4UVBleFZGbXpOVWZ6aWFiSGlWOUxEd0NHcEpo?=
 =?utf-8?B?QzFyNEFobTdjTjJWRkg3THhEd0daa3JWSlFSZms1eDA4Ym5nVkVRYWQ1bmxD?=
 =?utf-8?B?OVZGSUYxTXB6ZDBoMHhMWFRnSUVZbVc0U0QwYkJFbGJ1UlZhdDMydHcxS0Qr?=
 =?utf-8?B?RTltQzU0dmlVMXZtM2JCZG1DSk1mcXJzeXRCbFZPcWxIK3dYZzlJSjdiYldK?=
 =?utf-8?B?cW5KYVRZck1nbW1RMEk1RGlmbFhZSVBDb0tBUlU2dkgwMlhxdlhYRWFBRDNi?=
 =?utf-8?B?NjRUVG10UmdlaFlhNDBqVUkwT0RyQXlRb0JHd1Z6OUt5OEwxZitFWG5WY3pr?=
 =?utf-8?B?bFA5RkN1SWpZTzVGOW1kUVBwUUMyWE9iR2JjZnNBemVnVjZIaC90c2FlTXBP?=
 =?utf-8?B?aGFyeS85RmdBMGc1ekE5bng1dEpweTZsb3h5bitTWVNreUJOaGtCRTF5eXFk?=
 =?utf-8?B?Qzk2SGdhUGptR3FpcE0yZ3dnMXVncitZR1cxL2E2eDMvUEtrUGQ5UkFWaEtP?=
 =?utf-8?B?YzJSb0w5R2s5WXB3NGx4dWZobUd1RCt5ZkNNZTU5cmlqbGVGK2JwSjV5TE4v?=
 =?utf-8?B?Z1JkNDg3MGtXMUUvVW9Gd0duQjZucEtidU5FYlkzaWR0SnRDRHU5M25iOHhh?=
 =?utf-8?B?QU5oNnE3YmZjOHVlNjlpemk3MGNoMzhmc20yd1pSWThKYVpBVTVMemN2YjBB?=
 =?utf-8?B?dktVUHVoME80KzQ0SlBhS3dlTHZTUXZyVGpZT1ViaitrWjdOc1dLdFh1QUFv?=
 =?utf-8?B?SFFxeFJ2WUxTdlc3eEdrZjluZkdYWU1xaW9rSVVOSkkwdnRIamlWOGo0OW1B?=
 =?utf-8?B?U01WR2U4eTZCYzl2c0NRaEFWazJqdVgzMlJSMXU5bW9Sd1F5bG80bGtCQjRF?=
 =?utf-8?B?QXh3eSsyYUIrYUc5NHhRa0NseDJyUFp4Y0FGOW9uY2M4VUJYalJFLzdYU1Fk?=
 =?utf-8?B?V21icFpqZ2lyQkVCWjFCa3QzL243UWhNMG8zMzJ3SlZMeWNBeUhKVDFGY29i?=
 =?utf-8?B?eExMZ2NocGVHclRHUUdzaDl4eGtLN3RxQUxLaXd6QmxaUC9LZDBGd2IybmJC?=
 =?utf-8?B?Um1lRnNPOVpuTGpmbkNDMXlSRFJTczYwZWZiaUFSYTNGdS9ZSHd4NkdhUFRN?=
 =?utf-8?B?S0FXQ1ZQU25QS2g4WnRtS0VZTmdQQmJZNWI5bXZXUUJheWw0azM2QXFJY0Fk?=
 =?utf-8?B?RkN5ZmZhYmlYbGw4ZTE2WEJkNmFCbllOTkpUWWZRWXNkRTVuUTVhNWQ0c2RZ?=
 =?utf-8?B?UGJWblJHZWxUdVlZSU9ibHdrakFydXZDWnc5SDB1NnZONkNlOW0zSVZkMzJq?=
 =?utf-8?B?Rm5zVmNkRGNxemg1RzAwS3Q4aldRN0lVazBPQkh0cDc0ei9BcWpLVmFsQ3Rj?=
 =?utf-8?Q?KbripUbmzXX/Bs5FEEpq?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5145812a-4d6c-4940-55f6-08dc7eab3da2
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:15:12.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4063

Hi Thomas,

On 28/5/24 05:24, Thomas Weißschuh wrote:
> Hi Stephen,
> 
> On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
>> I was the one to implement fan monitoring/control into Dustin's driver, and
>> just had a quick comment for your driver:
>>
>> On 8/5/24 02:29, Thomas Weißschuh wrote:
>>> The ChromeOS Embedded Controller exposes fan speed and temperature
>>> readings.
>>> Expose this data through the hwmon subsystem.
>>>
>>> The driver is designed to be probed via the cros_ec mfd device.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
>>>    Documentation/hwmon/index.rst         |   1 +
>>>    MAINTAINERS                           |   8 +
>>>    drivers/hwmon/Kconfig                 |  11 ++
>>>    drivers/hwmon/Makefile                |   1 +
>>>    drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
>>>    6 files changed, 316 insertions(+)
>>>
> 
> <snip>
> 
>>> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
>>> new file mode 100644
>>> index 000000000000..d59d39df2ac4
>>> --- /dev/null
>>> +++ b/drivers/hwmon/cros_ec_hwmon.c
>>> @@ -0,0 +1,269 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + *  ChromesOS EC driver for hwmon
>>> + *
>>> + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/platform_data/cros_ec_commands.h>
>>> +#include <linux/platform_data/cros_ec_proto.h>
>>> +#include <linux/units.h>
>>> +
>>> +#define DRV_NAME	"cros-ec-hwmon"
>>> +
>>> +struct cros_ec_hwmon_priv {
>>> +	struct cros_ec_device *cros_ec;
>>> +	u8 thermal_version;
>>> +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
>>> +};
>>> +
>>> +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
>>> +{
>>> +	u16 data;
>>> +	int ret;
>>> +
>>> +	ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	data = le16_to_cpu(data);
>>> +
>>> +	if (data == EC_FAN_SPEED_NOT_PRESENT)
>>> +		return -ENODEV;
>>> +
>>
>> Don't forget it can also return `EC_FAN_SPEED_STALLED`.
> 
> Thanks for the hint. I'll need to think about how to handle this better.
> 
>> Like Guenter, I also don't like returning `-ENODEV`, but I don't have a
>> problem with checking for `EC_FAN_SPEED_NOT_PRESENT` in case it was removed
>> since init or something.
> 
> Ok.
> 
>> My approach was to return the speed as `0`, since the fan probably isn't
>> spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
>> HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
>> No idea if this is correct though.
> 
> I'm not a fan of returning a speed of 0 in case of errors.
> Rather -EIO which can't be mistaken.
> Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which should never happen)
> and also for EC_FAN_SPEED_STALLED.

Yeah, that's pretty reasonable.

> And EC_FAN_SPEED_STALLED also sets HWMON_F_FAULT.
> HWMON_F_ALARM doesn't seem right to me.

Fair enough, I thought I copied the behaviour off another driver, but I 
can't find which one, so maybe I just made it up. I do agree with you 
though.

> But if Guenter has a preference, that will do, too.

Of course!

>>
>>> +	*speed = data;
>>> +	return 0;
>>> +}
>>> +
> 
> <snip>
> 
>> But feel free to ignore me if I'm completly wrong about this, since I really
>> don't have much experience with kernel dev.
> 
> Thanks for your feedback!
> 
> Would you mind if I Cc you on further revisions?

Sure, I don't mind at all!
To be honest, I wouldn't mind a Cc on the other Framework related stuff 
too, but I don't mind either way.

Thanks,
Steve


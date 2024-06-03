Return-Path: <linux-kernel+bounces-199112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DD8D824A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EF1285B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A84E84E1C;
	Mon,  3 Jun 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="MWGe5PeM"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2176.outbound.protection.outlook.com [40.92.62.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFD8060D;
	Mon,  3 Jun 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417921; cv=fail; b=taAjcJPqbX/OhQBjI/o5Ylx3/s+urAGqyG5pVX1jKkOWNSTpt7p5hpqNSdhTxdo7Cy4DVhS0u7l/WZs0DzodDWEznbeHruibWMDFobeIlvLbminASnYRAyovEmFcjiNMwZiVjxmjxAbU/PDtOqZZpAzqPGkPEZxqdJCmvL8ogHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417921; c=relaxed/simple;
	bh=JbCtl178Sb4OKM7R04qsA6KleFuUPQxilHm1z46IxQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XHyAXj5lKgr2d7Y/2veUpw7y4mO7jUOh2tNBTp1lC1N+5lhj0UjJTBrpqXmJeKAOCUpWH7i20GGIJ7ZHa7AYy66u2OmFGozWyKbBLPtmVPy6HH0MByNYgRtr8Y4/iz0f0Q9n63aLLyJmE+KxQHai86hKiUkvnHMHvK1UPhZkE3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=MWGe5PeM; arc=fail smtp.client-ip=40.92.62.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emKlwN8ptZ1XadpLr7qrnRAoOqN5ZtjjwVo71SRKh+DHptOJ8Hmcyuy2LzyIktIvdKRsM0Asbo5ZrmEVB056jOr2nZU2Wuj24KfWwpU5D+g3fbet5Ni1frajXvVsOw2PDivQlArjdVjvDw2bGTYti/4tylKg5miFV2z95EEym06wp/d7LsOJHSYvVnadUQgXkrENc1KMohblqmUapJjYjWqRJ0dPA0ZnyURQWw1L8aB2pa+wFnhDdP5lRDQdh/2c1ItpdGyD7zBW4XnyqCPnO9ml1k8Jy8Yu1AB4JTKqm2Z5/VhzTPEVNC4eY6KRFc5CuomVlyGK+C6OWc+dK3+hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPZ9AhXQOPpv11GjrYqc+CLAJ54dgjbr5HJKAD89fRU=;
 b=cRMWWeQjCekhmB7Jd4JOzPmwwMkbzauM/+drUJDWcF1EEdpmAzMgShZoxGmjUIyNYJXDubcdQAgqhSJDx8IeWZzNXAluAuG/83jlg2zQk0kIsoNlZrGe4lO5aroEiHpoABRK0PWnvKXKsJEM7PNAdMAPCVja1NQyjQRutHguAugEGgJE13tesR6ahV3A7d9mQQHYJujWuTylHejt/fi7IiB4CUL1XrZpE+p2lH7SzYGJ8BBw7cz1n4buhlad9VmOkO7x617TdZJQk6gAVrm1B2gFNxr8svLs/U+v/BIjOEW5MOZWUM3epPUkgnRuXIeeble88VAUjKKoR4PKq1NL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPZ9AhXQOPpv11GjrYqc+CLAJ54dgjbr5HJKAD89fRU=;
 b=MWGe5PeMGq4lCTrI6tLxvkLKp32rbLIdKYmeA7GzRV/aZH60srmIx7+tnTCXXsjDIhNlSj2eAoSqQuLzBGytidF7DlDZCFkZBzJ51Olz+e8G+5MmaA9tpws1OfQimuk32vyWhwa1zsxxpT7AEhSfF413SbgqrNnYtZ8KS7GslcaAMCWFeT7PHM8SkDAbsacoE2jWtpDwOydpqtWwvh4tIbweTSaVyfQBPUCpjOszVeaaal65AlPRtqBopEW+xgods+8Mb3t4P0OuFQqz4FwAJPaZHNb8Yg1Ojc6pmIasVIJVo3h/nO26btpYVKybf8T+W/zB3aD5egarKZopGDXDZA==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 ME0P282MB4880.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 3 Jun 2024 12:31:53 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 12:31:53 +0000
Message-ID:
 <SY4P282MB30638F9B99B76CB33DB6C115C5FF2@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Mon, 3 Jun 2024 22:31:50 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v3 3/4] hwmon: (spd5118) Add suspend/resume support
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240531230556.1409532-1-linux@roeck-us.net>
 <20240531230556.1409532-4-linux@roeck-us.net>
Content-Language: en-AU, en-US, en-GB
From: Stephen Horvath <s.horvath@outlook.com.au>
In-Reply-To: <20240531230556.1409532-4-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [vDfmsyOYtmOU0t3nkPUJQQRdNkxsCPsQrcfsYd/EWjdDMnUjEd+fPdFVhdbiklidD4ZXHI+CKB8=]
X-ClientProxiedBy: SY5P282CA0192.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::18) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <8884b0f5-17fb-4e40-ba78-375e1637a496@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|ME0P282MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3d50cb-8164-4009-9429-08dc83c925f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uSLmJFy5ScjcBU6yxKFLgba9ZrHUACdcABe9Qidd5GXolV67mNEZXr4aPwMD5DeIUpBmvSeX8ex5cS8xu4SdTDNuPxbHMTsTtFUU1SEq1uFcn/FFbuNAhI3bGfRwnezg5RE1ZcxyrEB9UiQvDKsULxqB6zArHX8Z9Pmbm1hsXZu8dO09PeT85Rj/AomPtpgE0d7RoX3rcYZ516YXASMi/2/y8oSn8W8nlwsARIopt9FnHaVCrmBgtqMQeYIKtXOQljPqWr3PvrcQa3mcy1aAmOVBrKSPegcxhnrt0/DfAWxdH6OMtQfxN0My6LdmnEfzB6zG9vygD9a74WHoVUJghBr/UCRugQ3cJu44wIPu8CYYBBSzRq1tKWi9uGSWQjXQBVX2B+f+K2EhQ2AFKbYrPYXvfHydQezqmbTvt0oNJGksNBLkn5KLbjJfm/1+VozfeXhFdVV9pXyjRHgWrGhvl+IBw2Grd0ZI5D1erWp1+W2dYcytX3yUsb+xBy8d3BcpfS3ExsWYDb+ncLzYIfsRXZNreAsnfkH9tWwjrq1monJk1J2q6oRPM8QNhnUzNA8d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZxbmtCTHd6WUdLRzdJYnlVZDdRMWgyYVc4dUdDK2ZtMkk3VU1IYVZnSVpU?=
 =?utf-8?B?Y1hCTzhGeXlqRGVUVjE2SzZPOUhPbGtFSWZydURKamlTMUgyVzRCMUdKWjM3?=
 =?utf-8?B?Qkt1OEhuQjV2SmZqbStHcEtZRXQvdGhtb0xDWXpHZEhuN1k5WnVBN1VkZVN6?=
 =?utf-8?B?L25idzVZWmZPQTNxM0lFYmUreUg0VWFYMzdRbDhFcWl4by85WTBLMFJUeXpD?=
 =?utf-8?B?WFQwRmIzUWNXdElCNnBpWWFqOS93Wnc0TVdqSXlOYld2YTB1U0k3WExaQlYr?=
 =?utf-8?B?MlJqYnhiVzMrNkFyeHE4N3lyaVlJL1NQWjhPNjlXc1Exd21lc1YzRUJUdXRv?=
 =?utf-8?B?RVR6SnByYkFOVDZrRjl4NHNLaWI0c3ViVlpQbXpwU0dVYmJmTDk5ejRlNmY5?=
 =?utf-8?B?NzVyU0hRUGhnaWZhV1U1d1B6eXFLR3FwMWdTNmxvZUk4L3QyVG9ORktFZDJY?=
 =?utf-8?B?ZVIyL2ovWUxMNE8yajlOdEw1L0hGcm9KaHpPRzlYbWdwVEY4dzZJcGtVRWwy?=
 =?utf-8?B?VExuQ1VNOXRrSjZ1UHRia29ld2dEcEJoY2thbEV1N1hHRy9nenFQanArKytU?=
 =?utf-8?B?d2VwYVpnelVPU0E3Z3RET1AyUDh3Z24wNTBodlBUUnpuSExSci9ybzdUTnJl?=
 =?utf-8?B?Vmg0SFRRY2lONkZTY0JXSFQwYi9LOEhQSEk0QUd6SXpQRWwxbSsrMEpZNStz?=
 =?utf-8?B?NlFpODBFS0EyTzYvUGZLSzkvMFd1WEZDQ3E5dkgwRnRIVlFFU1VUczQ4ei8r?=
 =?utf-8?B?L2JTMzdVeCt4SWI2cGYwYnJJcGJtcTFoU3VJbXNHU0lSMG8wQ3U4SDRXT1NS?=
 =?utf-8?B?ZldBNEx2bGtEdktIOHZxWHV1RnFWWlV0c295cjN2RWpNdG5TS2VkMHFJTi9z?=
 =?utf-8?B?L0JRVkdTZnl3N2Q1SXcybnE3YzlrZFB2R1BwZ1hxT1JvbUQvRmp2RXNZU1d0?=
 =?utf-8?B?c1FEN3BEdkFMMzdwWTlJODRkVjVNc3BmNmtqRS9LclNQamUxMlE3dy9ZOUpr?=
 =?utf-8?B?R0xTMVRDdVkrYVdnR0x6VllyT0pDaE93TWZzZlF5aTBYajFLdnNNSy9GbGRy?=
 =?utf-8?B?L3BxN2IvcWpVbzVPamZtNzVHT0tUQWsyeXdpRDMzVit0ektlSmwvaFpyMkNt?=
 =?utf-8?B?OTZLRkJKWEVnTG5tWkwzUlRFYnd2WnovZ3pTeFNIdmtWcHBreGF1bDRVd1Zo?=
 =?utf-8?B?cDdyT3hRUmo3aWFyV3gvamcxSVliYTBGWWtJQjJLTm5icTR1QWVZekc2alJv?=
 =?utf-8?B?dkxhNG5RY3ozZzBkdHNSd1kwU2FiYzErRWhNTTZXZFZ5ay9KR3BHVEpJL3Fy?=
 =?utf-8?B?dzJvWW1ZNFFER3BEelVhZXhOeGdKRWozNWlxZmpvZXBSaWk4T2ZWTDNqK0RX?=
 =?utf-8?B?LytKK0dVQWhuRWxLcllyK3FWOXdNUGNMQlR1TkFvNGJGRkV2d3pTSFZoREsv?=
 =?utf-8?B?T281b2dWemRxcEIrQm1VdG5EZ2QrbFR1V0NXT2owTWlYRENYL05WNTllSFcx?=
 =?utf-8?B?Z0lnRFVJazVIcUh0WVZtSGpNeWJOYXhuQTdYejE3UDJuOXA0cmtLcnJCYXpa?=
 =?utf-8?B?SGx1bytESHR2ZjFxQktEbE14RGVXbjg2QWZTc3EzNktTVWpyYWNWeVpqVERL?=
 =?utf-8?B?WXdHMks5N3NiTWNyRDFtUGZwNTFWU2FyejV6Qlk1RjRKSXVWTmwrejN5cEEw?=
 =?utf-8?B?M2gyWU5NdkRxVHZONXFheXdnZnJaU3U5aWJWdDJTdklXSFJvNkpINGRldGtY?=
 =?utf-8?Q?dElEu7Ht3ef067mnyLDNuQMIPwhrxHM7w0ugK1u?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3d50cb-8164-4009-9429-08dc83c925f9
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 12:31:53.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB4880

Hi,

On 1/6/24 09:05, Guenter Roeck wrote:
> Add suspend/resume support to ensure that limit and configuration
> registers are updated and synchronized after a suspend/resume cycle.
> 
> Cc: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: No change
> 
> v2: New patch
> 
> RFT: I tested the patch through a suspend/resume cycle, and it seems
>       to work, but I am not sure if that had any effect because,
>       after all, the memory is still active during suspend/resume.
>       I was unable to test a hibernation cycle with my system.
> 

For me, the driver just reports 0°C after suspend/resume, but works fine 
beforehand, tested on both my desktop and laptop, with kernel 6.9.3 and 
6.10.0-rc2 (on the laptop only).

Hibernation does seem to work fine though (at least on 6.9.3).

>   drivers/hwmon/spd5118.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
> index d3fc0ae17743..baa315172298 100644
> --- a/drivers/hwmon/spd5118.c
> +++ b/drivers/hwmon/spd5118.c
> @@ -20,6 +20,7 @@
>   #include <linux/i2c.h>
>   #include <linux/hwmon.h>
>   #include <linux/module.h>
> +#include <linux/pm.h>
>   #include <linux/regmap.h>
>   #include <linux/units.h>
>   
> @@ -432,6 +433,8 @@ static int spd5118_probe(struct i2c_client *client)
>   	if (!spd5118_vendor_valid(bank, vendor))
>   		return -ENODEV;
>   
> +	dev_set_drvdata(dev, regmap);
> +
>   	hwmon_dev = devm_hwmon_device_register_with_info(dev, "spd5118",
>   							 regmap, &spd5118_chip_info,
>   							 NULL);
> @@ -449,6 +452,31 @@ static int spd5118_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> +static int spd5118_suspend(struct device *dev)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +
> +	regcache_cache_bypass(regmap, true);
> +	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE,
> +			   SPD5118_TS_DISABLE);
> +	regcache_cache_bypass(regmap, false);
> +
> +	regcache_cache_only(regmap, true);
> +	regcache_mark_dirty(regmap);
> +
> +	return 0;
> +}
> +
> +static int spd5118_resume(struct device *dev)
> +{
> +	struct regmap *regmap = dev_get_drvdata(dev);
> +
> +	regcache_cache_only(regmap, false);

Adding something like this fixes the readings after resume for me:

	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE, 0);

But that was just the naive solution I thought of.

> +	return regcache_sync(regmap);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, spd5118_resume);
> +
>   static const struct i2c_device_id spd5118_id[] = {
>   	{ "spd5118", 0 },
>   	{ }
> @@ -466,6 +494,7 @@ static struct i2c_driver spd5118_driver = {
>   	.driver = {
>   		.name	= "spd5118",
>   		.of_match_table = spd5118_of_ids,
> +		.pm = pm_sleep_ptr(&spd5118_pm_ops),
>   	},
>   	.probe		= spd5118_probe,
>   	.id_table	= spd5118_id,


For reference: I believe both my devices also have Montage Technology 
M88SPD5118 chips; the desktop has Kingston KF560C36-32 RAM, the laptop 
has Crucial CT16G56C46S5.

Thanks,
Steve


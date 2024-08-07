Return-Path: <linux-kernel+bounces-277136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922DD949D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21F328508A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1870BE4E;
	Wed,  7 Aug 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lQsCVtml"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2053.outbound.protection.outlook.com [40.92.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418A2904
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991525; cv=fail; b=KMXmk9IYERzJAoywJZdBJb5oqMpewRXG7zFinveWI273JsRe8+bBd4EOVfR1/EzDr7y6G4n9lAcYL1amjam6H7vHzWmSsotXGFPNZb318q257kxNNbcALP/f7ueSBLmvRM7fgXkKlhedus63KYdsP5mCWf079vSm3INhz+QIju0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991525; c=relaxed/simple;
	bh=CRLWpu0vZXDL2EWRUFQcPUDsauWxe04mnUaa1alh8lU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B4hbTo8O3mdxZWtk6SL6UUyj2ln3n5bfRxR03gbpTusISZFILTgqp+NMKbs/0g+HwZDGeq10hGNtqmG1YxYPdB2VI8ECW17jvrV2uuYdh/ZZIkD9owQhnUMK+vEHTbtiUm6jWKS/AHRF3OHQu380jhYWwNYW6eNQzaTE5YCu6uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lQsCVtml; arc=fail smtp.client-ip=40.92.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQDHakEqk6ZJEQHTaJfkEGKQMIg6Sc87m7+cfb1lwEqbGTURzRE0wytq7GP8qyk0C2lID0cFgI8/RZXm6bGJoblWcukKGzyDEru7qNjZ2zI3xoIqE0EwzbcJqlKK20CpwRTM573Jko5GPVb2+QYk2YjPo96cWuhvD2vwUCiFt2iw2QT11HKB84oXE9+BUIr1mVrczIitog2fpUZ2jVSA5879ufEugP+uMk7GvWf+lJFTDY6PdR0XyCgyurlegWo1P70GfMTTLOgXVI9RAzMiUSAa4YKuKKM4EkCIv7ePmxv/nj3aNEFTWKtSSY1w/bxnV+ovXy3SHlMA/UcArtIYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiF21TtNb86REmVZZwB5Vak5VKFYFPcRNcTcbHECtFs=;
 b=rl4JoGEPg3J/ntYy/E3UikVHUS/AolI4IBLcvRXJMRNZkVvewpjzfNCpo8sOEeihoO7nKw6Bc03Ahj3/R7HcxFQ8hKAjZMp3/qX8g01zAiFItaDTiG8Jr7bvtjhid6dMiDdo71cult6pmyUN199T8YXcCvXIaDgXchfuTNdsRWSk51Q0sOWhtAsV+wS3Jd6bE2yjtpeP9pTBf5Yf90XhbyiGAfwnu+BmI7kQUhv1CfPUbHxtoXc2veo/d6ZCvlMKeegHXbbSGr8yv2YySAXqhWPSghWAjrPkh0zcDJqrK7BOUofKbcj9AMHPAnmm0WSS13dcxoCa571B0aAsCUXOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiF21TtNb86REmVZZwB5Vak5VKFYFPcRNcTcbHECtFs=;
 b=lQsCVtmlL1S+FJq1Xs3QeTojWxkHp7b+c0StqpoyGXwWSiL31T2U6IQzpYUsneH+Q1ZdFTxCPXmHDn7CBLZz/b4iDvUYcrbDX71HoROVUnQWlkFgKQjDemUFJJI26fC0ZPwGNOpOHQFLAa0eERf2MVOVagKphcxgjWPoF1lpNdQAXp+l09PcYr1XI6qHO1NP/S2kDBL/ZVupflgvoPeQ85Cusrb9E7qdx5rPJLvTrJE2HHjZBhbn7Lj0Sszy5cmyeDAQ9yI7LxwoF4+miRbe16P9BxcArjLT1ea4FYfoKRl9UG8JGRu0HXIBL9gee1hY/y9O0fYYVOlHJabKMQkPwg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1009.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Wed, 7 Aug
 2024 00:45:16 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 00:45:16 +0000
Message-ID:
 <MA0P287MB2822764331021A4A67266115FEB82@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 7 Aug 2024 08:45:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: defconfig: sophgo: enable clks for sg2042
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 inochiama@outlook.com, conor.dooley@microchip.com, guoren@kernel.org,
 apatel@ventanamicro.com, hal.feng@starfivetech.com, dfustini@baylibre.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com
References: <20240805023320.1287061-1-unicornxw@gmail.com>
 <CAJM55Z9_sDT2wUy-GMT=mi4FcWth-O_LUbmVtbdZRipQrUzh4A@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAJM55Z9_sDT2wUy-GMT=mi4FcWth-O_LUbmVtbdZRipQrUzh4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [6A4W7iPgy7+LZAqHk5oUA0K+HppLmHEz]
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0a96616c-4114-4435-9c22-679031b464d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1009:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fa3511-0628-40d0-8418-08dcb67a339f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|5072599009|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	dKfx3cp5k92Ocsi7o3cik6WdAzOA3vk8jlHQdWri8j5fQz93Ad1YGVUFrJqnWf1qHh8QseaDPA0O6cwoeGyULP6Ktc0dcya6u3XEAE5R2rjzm7FT/lBZj8eG47jbWCtwkSmj4i715sQN7CwoGVZjSZAXQf9by7efNsQveENb6M+RG1o3oQNVR1JSnMRIWVYwPq749yvN3ChHkToOXSSHD0yrMFtNEAEMVMHHNqip3SYuvVmEVxAP1nlTjffGU/55V7VOyQYrG06eh3a78RwurAVpxJ6fd8EK+VYXEA4Icn81hFuDBJm4NbGBK4w7Q8RvF4eZM0SF91yu/V7kg65yzZPA3c4Eb5YFO4TAjUW0Oupgnj/DGACLXhiSYcsEkH8oL9j1zb/nhGKIh1iPfXja6rZ8n7iWzEVL0uyg6PojHMWdWN5qL2pMKpqXZT2+SBZo4+WJfkbmR7Y6qJ3qzsi0nQ+SUOX8BrDBH7u1cGCCkZo4TYECmlavIzot2WvSENHDUCUk2l7kPEnqutHfswdWtIvbsTWJfCJJge42/B71q7z6zkq+zB2D4ZQXxNW9B5w8O68zQHhxnJBvQQEscRCWbcLvbwQtewK4iH8ExZjiCa18cnzgVwwNAqInZIlBzDaA7KSqIZ8LEJYnZgCSnMSp34GdQhehlwNkRX8GrYRGWpR13NJ5hHQYAjWfx7fAc7mE1wmuzEvSMrkgCzSPAh+IF5T7fzLBX2WAjPaKFlMj8k7J6pTsirpG7gFbMlVOGiiw5pkNKahsFNavSHBKmPr/uc59CPLZGxk4HDgSjbx5UVo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NwNml6elZGQThxTTJWUmJsV3RHNnoyUVgrbDdRSCttZWRXKzEwaVFSY3k0?=
 =?utf-8?B?OW9IMEdBZUoyb3EwaXFuY1JuWkNGRTJnaXhjTVl6YWpvcVQ4UUZaczd3WkFq?=
 =?utf-8?B?dkRCZW1jNm9SRFhIZFAzV25wRU8vSXRFZi9KUytwRWgvYXlpK1FYTUFRcHZG?=
 =?utf-8?B?OU0yQ2txZ2xvTXdFQUZTSDI5UmlYVERaRnd4bnpwWm53dndzRXozZi9mNjNJ?=
 =?utf-8?B?UGFkSFBiV3VEVlNIQWJFQUkreWRuTmoxRzJTL2hpeGV1WU54R2xER2locWFH?=
 =?utf-8?B?RnphTGtHamtSVUtoK1BjRGpZOTUzTjZxVlNjN09zdzR3aGZJZ1VVeEtRNGxv?=
 =?utf-8?B?ZHltb2EvOGxjTmYyaW5td2gxSVIvcmtlc1RwWXVVK0NqVlBySDRkR0M1eFVs?=
 =?utf-8?B?bHpxUXlzV2VFQVhIZ1RyVDUyQlhBSXBPVnhmTk5ISGJpWW5tYjRVTEN2dW45?=
 =?utf-8?B?N2V1dVljQ2U3dXJBc3UwRm50TDA5QjF0ZXZaZzFnMWFqODRJQ2djZmh4WFNW?=
 =?utf-8?B?b1F6ZDNZN3d4eFJPM2hrTHVjTlhOL1RHYXVTRXB3MUUvZER3NE1jenZ6aVdm?=
 =?utf-8?B?SDhTaFlneVNYMDZQS1dKTjJ2OWtFdjNaeERVZndHby9MODduZG9lQXg5Vjk0?=
 =?utf-8?B?OHJNV0tlMEN4RUcwU1RIbVNOSExCMXlsZDd2M0UxTHp0bUt0UkVXY09MVlgr?=
 =?utf-8?B?Z2wybFdmbi9MaEtacW5kSnF4bmFmRENUTFA1cENyTWtTZTh0WXFMTXBUeGx6?=
 =?utf-8?B?NlZzcWVwcmNzUjJwaWdBUHlHWm5RYmRocWpkV2lDTGlSMktNUXArMXZ3dFdN?=
 =?utf-8?B?ekJwM2gwaVRKZUt6R3VxaVV1cndTWGJIbElyRm1pb0xBMTVzY2FEMmpma1gx?=
 =?utf-8?B?TUpObzg4K29XTDBwb2ZlQUIwK0hOV2FMRmhrQzMvMVl5bThRNUNTMmdkWHIy?=
 =?utf-8?B?VjhlMmRwRlJNV3h6M3VHZSs0MzJPaWZpdkdNcElzSGpRU0RtN0g1eENiL3Nz?=
 =?utf-8?B?RFRKMWg3THpHMmhUU2F1eFlVazVhZHcySTB5YmlaQ3N3aW1QVGhBYXN2VlNH?=
 =?utf-8?B?bFhuWk5WWEpYZlQ2VkFBaU0yU1Exc1p5Y0VNQmQzZUpwOXhYN2xsS1lqNExw?=
 =?utf-8?B?OFhhVlBhL2JMYzVFL05uMUFwZVJ4YjNmZGx2VndZR0tLM0xGeitsRG9NMldX?=
 =?utf-8?B?RmhJbCs5NUJYRWFMWEhEOG0rbkp3eUlsWENvVlpJNUhIY1Znc2plOEl1OTlq?=
 =?utf-8?B?Q0YrY2M5L1hyaTZmWjNnRy8ybnoyay9QWUErMVJILzNvWkVXSGp4UnYvYzRz?=
 =?utf-8?B?WkxFbkozS3RERSsxZkwyWnJGVEs0UGRmT0k0TFB4bHhDUHdYczQ3TWRTeFFv?=
 =?utf-8?B?bUJ2b0p5V1h6QitsUHpPa3hwSjlwY1EySC8yWTJ0YVVkZXBUL251WWRxRnRt?=
 =?utf-8?B?bmJ2Q21zbGFvUS94VjdtZ3NHVGtITU1CRTBwUkdJUk5nank3UDk2dUVhbVJO?=
 =?utf-8?B?WjB4d0xCWVE1OEFtZVhCeEtieEtYVnZUR0NUMkg3VkxDcTRwNU94elltYlBJ?=
 =?utf-8?B?VUYwWE14elZGcXhpMU0wcVVhL2x0cjVOVHF6VnJkcWZNbzdvMzgzd3hQd0ZO?=
 =?utf-8?B?am1SUWczS2hwRTBVc2ZJTFg5bGRXUzQrRHVFbStOVVZ0Z1E4cnRBa09FS1JQ?=
 =?utf-8?Q?qU1uHYwY3TwrV+dqHcVk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fa3511-0628-40d0-8418-08dcb67a339f
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 00:45:16.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1009


On 2024/8/6 17:30, Emil Renner Berthing wrote:
> Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Enable clk generators for sg2042 due to many peripherals rely on
>> these clocks.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   arch/riscv/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index 0d678325444f..d43a028909e5 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -249,6 +249,9 @@ CONFIG_VIRTIO_BALLOON=y
>>   CONFIG_VIRTIO_INPUT=y
>>   CONFIG_VIRTIO_MMIO=y
>>   CONFIG_CLK_SOPHGO_CV1800=y
>> +CONFIG_CLK_SOPHGO_SG2042_PLL=y
>> +CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
>> +CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
>>   CONFIG_SUN8I_DE2_CCU=m
>>   CONFIG_RENESAS_OSTM=y
>>   CONFIG_SUN50I_IOMMU=y
> Are these all critical to boot or could they be modules?
>
> /Emil

Since 6.11, sg2042.dtsi has been changed and uart now has dependency on 
clocks and boot into minimal console will fail without this.

The sg2042 clock is configured as builtin to facilitate bootup in 
initramfs with defconfig build.

Regards.

Chen

>> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


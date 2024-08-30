Return-Path: <linux-kernel+bounces-308410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB6965C96
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3AE283558
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F32172BAE;
	Fri, 30 Aug 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j0SYs6ZJ"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2100.outbound.protection.outlook.com [40.92.103.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86416F909;
	Fri, 30 Aug 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009742; cv=fail; b=cqZuFRDPNE4oSWOtnMFvrxXbkaHObzoM2LWfLHIPYlXZPO5DaOD96UJ0z36AqVao/FZtvpkhW2Uuf4X+v3UbUbAz4Xc5Da8WdXu8bnoLZHTy0ZpmzNkNMMoAw0S+2jmglvTKqBhz5brp4oCIaDr1fuKiKr6Dwwol/xdWalBvDzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009742; c=relaxed/simple;
	bh=TXJOkk+HGZDU0vbnwsHRmlIj2mNvR4VZOTbWt0KQ13s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amJM2xU+LH+vscX+dGMmIMgxjohZnyWL0voNtuptmjDWDvThJ2PHDPFDjI7EmCZff+8GgN7egPHqgIhNT0WIpL1+r3lImfvrvnJ9x2GNyVBr4nSIVL5nBcDkCNSObyeg8twBipmOHH0zNVgSpDdMamN/iXp95uFmwfzw/bnVqeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j0SYs6ZJ; arc=fail smtp.client-ip=40.92.103.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRzGtmQqSGkQuxwbrITJjCyjQm2MRi1+NeTea282jLTu/DwVpfZCMZYMouaTv5dXHIZxlCbh31d5qSsCL4QU+0rYBwrZC6+kPR+wHf0jUWCnjwuAhOPw4usa4YfVhsiyB6pL9s7hU9XdqkJppfIEozw0ldXt/MPTVG7qyL4PFtHQDGjn6kokEHD7sYLp0SWm4qKRLnkiXWhHLBFMd+Lsbh8HvqXo0mBIuFFdr3LaE7l0mIOojLncZpN4b8Ma/BxhoVm+5XCdGGuG2hEnJ34TTNFf5sb02ztpnteARuF+X3nw62U/QcQY2C5l+O20uwC5a+R+wxeAaJCHseUkIRngnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npiffF0hWFrgm8MozfhJ+1kSAcTV+i+0C1q7G4xT9qE=;
 b=vwKdOA/5Z8pLqwd3jqULQpvP7u0R+K+tMmOxjqW2hO8OaCOxNL67DstMtHlT+YZA7CB6JHLIpLhIRNYT2ucqcl9GwVtPPw00BLj26FQ9AREjhgg6wSdvgA6wdAEyPmHBulUgJA1VkYDjjZcLZddfhFnNhQ5OiOJV5Kp2P5QYpqKzxRDVwmLO0JV2G1wFWwNdSV2mSO7hkbgCs61QLauCsH4pFukbWBGuwkMIqorD3i1pV/gspR4rNOL1IZnVIEsT2SA1E2dPUvAeZWqG2pJ/22IsdOpAW3Ko17n7vW2XDSmkuggtBhJYzLnl2AYbzyUfvV3KoSi33oYq5A1KsH/joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npiffF0hWFrgm8MozfhJ+1kSAcTV+i+0C1q7G4xT9qE=;
 b=j0SYs6ZJK+bRz4/M0qxb3oRg+IvWkaclo9l0PDmFzDTqQo42vQwJwUuFRWOZmPrc9VWXhd0JHGyNwztCm3W06rs/kgkGZzQImSEf7H91YzPl0jom7bdK5JzQ/301mh/3kNpgmdq1VXDrQW3K31IKeJWhpjS9QE90Dz62IaGwOrj6waMqdBIUn8PB/HNHsJEt0J1p/ke1WMrwnLKATpycBwLQXtzXwMWGjEBUWrKnkgeqztBmW8QIDgVqIvjOb6swgoNkvqT6XCMn3rxQ4liO+kafz/kWn6qlwQtFS+jQEGls/QU3gC50T6vEatdfFjeQvFEhee9KEBkl+HXXiP5N4A==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0722.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 09:22:13 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%7]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:22:13 +0000
Message-ID:
 <MA0P287MB2822919DFEBDA9B9663F8333FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 30 Aug 2024 17:22:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <20240711-sg2002-v4-4-d97ec2367095@bootlin.com>
 <IA1PR20MB4953612773890B94FFD0C9EABB962@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822AC58BC43FDE03802E773FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <1b202582-0487-483c-ba80-47125551eb5d@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1b202582-0487-483c-ba80-47125551eb5d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [vyBi7WWVjZZvLUQo/o/t37iBEe2jmFm4]
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <a6fcb025-5781-44aa-a297-8ac6e27fa7e2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0722:EE_
X-MS-Office365-Filtering-Correlation-Id: 598fcaef-cd43-4013-40b6-08dcc8d53a84
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|6090799003|15080799006|19110799003|8022599003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	/01JoDbh6dT6avYDcg92v+9j7i5LMxa83GAhWFSznuOQKPMlFEj9kwF4XD9veGfDRWdS0AjOJpzj6QilJMJliVJRby3x/5HkSwKLvwVwGC0tvKyuhpuR+jimZm764rsPfWifYaYbvlfo5ZNtstAVFZOX535zG4cgWJ0GCBuiXJcs3NOKqi9rO8tKst5333npFTCmuFeAbqYu/peOAbKmaXmwrpQYPcMvcHc9GCLcJilAM4eqF2XIXvNNa1zBn+dr7m/quUJdEUMjk+XGXSmNQlmTQXbWsQU+Rqt3D9E41EkoQ8/+UEmJnlQ0CCPyaNV7ZVAbZHFmc7418D5QCEMaTbBGVnmisAd0WM9B96v1nyDxrlwjZIX5DiQm71tt6lh8rlJFd5UcPD5Noxa69fevt4oV5YYLb6sDowqevQqxoKRE43nM6xwZISaHO0UOtwEvd1fHWGcoVH8AOKZvTBVv+yKrEKSLGrJ7aGGqIDYL0Vd1FFwcQRQXjKiNQF0dE0dsUrJOfnr5z9+1ZNRMidYZB25BJw4WGYfYb9XuhM1PTBZufQyNBQfBhu3RN194XlFHfGvUDZz0dVDqOWWJFdKsALFYOuxGJi5O9if5BUAEhD+ww63wmBi7bTuvaG6Yy+H6doweS52RDSTzGCVkLFMr6YyrRoOk0L9wrYP6JU34B3MNS6orS311TxJkmZQjiLdeBMIIMqsmeNVWhsPrYqlRHs7g7vZOWuR3GZdJMCJGsrUNvWpbr8ALsSs4GiaSk2IjECdm113mynWhSGQesh1h5g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU45bXVzREF6RDVycS9BTXZHcGZlMWxSTWhTWkRUWkM0UzNrWWR6YWFvTVNx?=
 =?utf-8?B?bWdEMysxQnY1TnVKSm9ydytrR21WazRxWVdKMGwvODVEWjI2WVBMSjd0U01u?=
 =?utf-8?B?YkJZMkNVUzZ2TkxJOVl2ak80NzJMTnVoRXUvQ2k4YVl2TDN6enVzems1ZHE0?=
 =?utf-8?B?UCtDcWpBT1hxM1lmUm4yTDN0ekNxSC9kSlpJM2NmRjBydFZEclJWZDIyRk5R?=
 =?utf-8?B?cHA2ZmxmaTJ2aTduMWFhOHR2c0h5U0JJWXV3VThuK05yWDRqNUM1SnBaTHhN?=
 =?utf-8?B?RHZUSWZFSkxxWHZyZ2lFbHBXaW9JcTRTWndHblMrbHFNaFVObnp0ODdManUr?=
 =?utf-8?B?MWlVRXFPUHYzY0JYNkN6TjZ6ZlJ6Z1NNRDh6bUJjWWRhRVNBTE9OZlprS2Qz?=
 =?utf-8?B?SExmZGNtNGlYdldxazNPc2d4eVpkQ2g0VGlNR0dkcmUrVlBwa2dWTEovNUJr?=
 =?utf-8?B?YnEyeVNIYWVRSDVXM3ZlYXlxWHRic1pHd0ZaSm1hZ3RWWFZTN1BqODNrRW5z?=
 =?utf-8?B?ZHFPYkVhRlBJZmRQS3h5TkdHK3V3b2UrNlVaZ2dmaHV1cjA2WjFwYjV1TFQ1?=
 =?utf-8?B?cUhENU9uandRbzlaSFV2TDJVc2hFWU1ULzAraUx2TlorM2diY3hBYkZjMTdX?=
 =?utf-8?B?WWRlZ3lQaWFPcGdhdmhsMU9rb0FBVEt1OXFzdmVnWWZOYmlDNEZjVzlpY0Nu?=
 =?utf-8?B?K2lqUHBzQXhXei8vSFcvTDR1akdGbzVqWFM2TGVtcWhuYWlXRDNldTB5bkRP?=
 =?utf-8?B?UzFWV1pyMklOUkFIang3dXNUcWVHbHdLbGVubHNGOWw0aThMcTQzWjA2TTds?=
 =?utf-8?B?Umt3eDllUDhpbkdXTlFoNk9aVEUyaStqMmNaOEYzT0ROczhjS21DaW8vczJ1?=
 =?utf-8?B?U2NpS1JDRjdzODFGWmFCZU45WVRvU3RxVEdPNGN3dUJSU1FsNDRhZTQ3NXVt?=
 =?utf-8?B?dU0vWWRDTmswMk9SQjlKMVo3YkhlYTJZTTljZXV5aWM2VWNtQnJ3eENWbnFX?=
 =?utf-8?B?Y1ZIOER4QUhPZ294cWNjQlhZVi9PN2sxWnNqT2hISXB0ZXplUW1BN2NxOWQx?=
 =?utf-8?B?S3NGSUNhK01vZ2tlVlFqWi80bGVhNjl6cnZtNGJLZnFsaXAwVmtVMmd0cWc4?=
 =?utf-8?B?STBaTkhtMHhKZGV4NmlDd2RvSEdrTkZVWTJOSW9Jc2FTRXdvRDVDbEYyNnYr?=
 =?utf-8?B?MHhRbmdWeERTYTRRcEwxMUExeEdNSEZHOVB5SGhmV0F3dUJ4WDMzMmhnLzRz?=
 =?utf-8?B?a0VFQ2NPenBCSlpVMmlPT0M2emo3S3UyUWRiWG44ZGJDejhZajZoVjBZWHpL?=
 =?utf-8?B?d3p6VVFtM0o3VEN1bVUwcVlQVmVIOFVSY0lER0l5TzVWcGtzdk9na3dUY2c2?=
 =?utf-8?B?eVhBdlFnVktqaUczb09JZjJ1MWVWYUwzYjc0SzRKZ0dwYnBPWHo4Z3FRTGsy?=
 =?utf-8?B?R2hDVTdQa0VEYyt5YkJzbGc4WWxFVndGVlJvNklJa3VFS0Fselg2bWJKUTVQ?=
 =?utf-8?B?VkhUMEtmclBYMGwvOGdzK01aU1cwYTlYYVdiRU1uYlY4OGFUZ3NhV2V1b0ox?=
 =?utf-8?B?VUYxekdDSmljSHFkVlRGT2pIRGdaOHFKWGpCcHZVYnhrQ3ptR28xbGwwZ0xa?=
 =?utf-8?B?QjBOeTY1VVhXKzhLL1piWEFOdktiU200NmhYUWZXZk1NMnc0U2phMXRMOFJF?=
 =?utf-8?Q?m8EgNQJgoVjYOk6Yeffh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598fcaef-cd43-4013-40b6-08dcc8d53a84
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:22:13.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0722


On 2024/8/30 16:06, Thomas Bonnefille wrote:
>>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2024 Thomas Bonnefille 
>>>> <thomas.bonnefille@bootlin.com>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "sg2002.dtsi"
>>>> +
>>>> +/ {
>>>> +    model = "LicheeRV Nano B";
>>>> +    compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", 
>>>> "sophgo,sg2002";
>>>> +
>>>> +    aliases {
>>>> +        gpio0 = &gpio0;
>>>> +        gpio1 = &gpio1;
>>>> +        gpio2 = &gpio2;
>>>> +        gpio3 = &gpio3;
>>>> +        serial0 = &uart0;
>>>> +        serial1 = &uart1;
>>>> +        serial2 = &uart2;
>>>> +        serial3 = &uart3;
>>>> +        serial4 = &uart4;
>>>> +    };
>>>> +
>>>> +    chosen {
>>>> +        stdout-path = "serial0:115200n8";
>>>> +    };
>>>> +};
>>>> +
>>>> +&osc {
>>>> +    clock-frequency = <25000000>;
>>>> +};
>>>> +
>>>> +&sdhci0 {
>>>> +    status = "okay";
>>>> +    bus-width = <4>;
>>>> +    no-1-8-v;
>>>> +    no-mmc;
>>>> +    no-sdio;
>>>> +    disable-wp;
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&uart1 {
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>> +&i2c0 {
>>>> +    status = "okay";
>>>> +};
>>>>
>>>> -- 
>>>> 2.45.2
>>>>
>>> Have you test you patch with a real board? Especially
>>> for device "uart1" and "i2c0", I suspect your
>>> configuartion does not work by default.
>>
>> Hi, Thomas Bonnefille,
>>
>> Can you please double check and feedback, I want to confirm this 
>> before acking this change.
>>
>> As you know, rc6 will come next week and I'm planning a pr next week.
>>
>> Regards,
>>
>> Chen
>>
> Hello Chen and Inochi,
>
> I'm really sorry, indeed, those nodes certainly don't work, it was a 
> mistake on my side introduced between v1 and v2.
> However, I can ensure that "uart0" and "sdhci0" are working fine.
> May I suggest to remove those two nodes? I can send a new iteration if 
> it's easier for you to handle?

I'm fine with this, just go ahead please.

Thanks,

Chen



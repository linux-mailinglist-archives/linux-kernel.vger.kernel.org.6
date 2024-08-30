Return-Path: <linux-kernel+bounces-307863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95DE96541C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6411F25209
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EEF4A1D;
	Fri, 30 Aug 2024 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ef7eWCdt"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2094.outbound.protection.outlook.com [40.92.103.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609364690;
	Fri, 30 Aug 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978294; cv=fail; b=gpemzOP7jnP84OKLfFEPXSg7vf5LGxut0W5kKyI60TN+C5HaSzXFpukC7MAS+EhJT/yjZoSbfJ9JpU0CTG3pqvlsygjq8BfUgu4Q9Vyl66xWdLvfqp0X3lgrY5bm5z9+yqFVG2roGf/hkxyXwr8FCL96XyvgxEevtUnDRHS/dzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978294; c=relaxed/simple;
	bh=1Jt3qmxDRII6BcYejnLo0jgQTn1UNscU1quDA/DUpbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=daDcVFTCJYiBiKV4k06upmZfUObCf0Sf26cVvaw70M/ZRB/Y2Z9ssDfdVCIUHXq/0I7bvaaQa9yM6wjY4KCh1HF9NnJa+6SEMJwWQaNweoauJBT+iwlKk+eX7EgCwdHCG53al8LwWBE+WZmpDZQ8BkKdTZPkwvhEUJqjRl3OxPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ef7eWCdt; arc=fail smtp.client-ip=40.92.103.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ltie8+sMpsyscBktnoms4Nj2MT4cKgkRBb0VPeRWOyk8gCDn6X1C91gASVPeF405ZdbMiwA7jvCXeJgChXH2ugKz0GGc/7ytlO0zwM//ThC4Whizbd29cBzSE0gxxZw/SawCgm8zJttBdpEYrsQc56G6/FXgQ4i0ow+L4DUDYndmk1HcyvsQmfDTYk4P3TU4IukUBlS+5DYzJYoOFXmTC2nXtAf8YDzTibyml7+NQGF8IEQd02agkUIzf6FaAbNomx/EMTSiGNXCdTp2oMVyyNspmCXywlrt0qN5enN47whhiXhad+gzDy7dGbH6lKyHGlMiA1CxfjR85WmM+NVklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubaVuQ8h27Ml98HZcEN9lYK8gHSIrxa/JRN3erGOcnU=;
 b=Xowv4I27gIOmhOk36Ol8HJbdHmetgz7d25DclnHwO7qblvGpm0maOOqNyk+HY99wgxcGFNWM8+E7EmslvWfb42vSMH7QGW2UiT6NH/UbDzyT05liWll1gCusC3omhiVxZHaTCisor2M04CuJJBa2ZLd0CGBBGz4fM8epSdwAmJaj7miTFBrOGCzhr4HBdEoSNAcJlwdB5CeuF2yLXflefKgt5G1jSx2oFbcH0/KuZ6dabd19fEa06IiajX6fxWqRGv1HYDfr5rA1KSH+mGtCaV6IUMxM5jgfQEova+FEuiS994nCisKHWlBzVXKn7gC3k/T/ROfsOlIM2UD6Rc0epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubaVuQ8h27Ml98HZcEN9lYK8gHSIrxa/JRN3erGOcnU=;
 b=ef7eWCdt9XpU6pK3A+WXkx/XFWU6zJZMH2VV9CTzic0nujBq6kigMUhFCfR3k3NwJnnwJb0cZk5lASvOmJtpRs3l5HrOAaFnFg26pjQOoCE2gBHGb2XmGwmpG24HjNIsXHTDuLqF+SSqC94ERXR4FYwglh7Ix3MQjfcMeKdvjoXMIhc2BQz+e7g8FKY6LdGV/hMli0hQFh8ELrs1ywxA9P0ickuHoh7W0tbT2lt3DZnXK9hjOep+4fQ55XZ2cMIrIk2UEYhdOYihENxVssmIten7n1+y+qTHGBlybGeCfK+vZfgYLX3HlnbkqJTwNmZyQ/69hOPs2Vb2UG4vkaQulg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1576.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 00:37:45 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 00:37:45 +0000
Message-ID:
 <MA0P287MB2822AC58BC43FDE03802E773FE972@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 30 Aug 2024 08:37:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
To: Inochi Amaoto <inochiama@outlook.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Chao Wei <chao.wei@sophgo.com>,
 Conor Dooley <conor@kernel.org>
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
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953612773890B94FFD0C9EABB962@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [c5DH7VgKmTay6Wqzg3F09+5gjkHXCPRJ]
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <a3296aad-a576-4999-8d45-47ad6c97f41a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1576:EE_
X-MS-Office365-Filtering-Correlation-Id: 913bc18d-d5ba-4830-3740-08dcc88bf748
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|19110799003|6090799003|461199028|1602099012|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	4fgmQtVxbfE0ROywALEv40kgQkP7NjvGbpDBN3gdVrGXChSZ139PAC8DuL5YedpyldAu3sm1hCA9l0khZAYC1GdmFxCXc5tQowpnCtlEkPCFhqMBGvIJPL8MUQuF4h6GhKF8ftwhz2ZNV8KoQZ7pJccLnEUcKJtnqEjggG6d8urBIHbWDij2NxYVIRYxv2FBeogNyaSzYOiLiJPd6oVov4+n8uIRYaYzn/eRh7PrPe7li2uwLh+ef/s/m6cxLe3VbH0mLQvyahzC6fAmAJuD3zrsQ1mSbVuvuzStcOGt8KOfHGTF4vbbThKcdkuZM4fTGaL+3MfvNipR1VM0GH6AvRlQ+IRmi7x5e1fpO1JuZm0PP3UoezQQIKY8zFJLZ3X26aVo5d+3r6Qy8apZ+ZHsLEGfRwCSZ0k8CHwNjmazsNJ3df4UCYhP9EtQezigtLW7ZGsxXzFgjirVA/sSHhH1rCbEBMoJORJ/CSNKDHLOxpsUnIHa8DaPTYjd3uWdhh3bFddaCERyytxEE4eLZaXS63C51YpB22JgeXL467rBAFejDquLpCV5CjbBUdZXHlzIt3WNNdEJQqgojofhLSdFCnzXTqbc+AnjGckJBwjCqACvmgXdBuU7cgTItApoEA/hokXg2+TnquwEC/xMucuQtdUIZA+7B1Cw51Q9ro1ozyj9Bjv03UILoqxQYGy/QvpdvuQ+vJAcLOSLx0hmz9Fmkei+j9D3nvJfaAGKTrxF9b1sFN411pW5beNoj5BmXwebyA5fx6ca/PuSitHzzp0DlCLZvGfoA3k9RnWXWrLgnAZZeZxV8Ir0Bb6tqib/9Hi7MMUCyKeugIj1BmEAcEtLEg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDUxeUlKb3g5Q0hXVW1kL0RKdkVFcE43VWgzdzNZaDM3ay9ES00yWXhYajB4?=
 =?utf-8?B?K2FqQnd3UmUrYTlRWmRtU2tvMHBGUUpTV1Q2VjAzc3BXU21jUFF5bVM2bklw?=
 =?utf-8?B?T0twNG1QbkR1T2ovTFdYZCs2TDNXZ2t3ZW82SnJSMktJSytKZ2lhazdQZXA3?=
 =?utf-8?B?LytPUElpTURkeU90YXVkWlJ5UEI0VHYzcXhTbkhRbWdQNDRSSUpZSWhrdmJy?=
 =?utf-8?B?MXBlNkFobi9VcW8wdUdGRW1aY0x0a0VzV2U3OXhUdTJGUVpWZkxoNVdRRCtt?=
 =?utf-8?B?ZlJqZEoyLzE5NTA0NVRCNzlqYUdTQThEL0VwSHE3VTN6eldjeWJSTkRwSlNt?=
 =?utf-8?B?MWdGdEhIYkpxZ0RTV2kxZGdLS2J0NEpQbENoUlVRZTNmRzVqNEhBZTE2Q2Vx?=
 =?utf-8?B?TjEvbVZWUExOMzlzS2kwZ3cyYjRFQlZDTVJKaWhSV0l2ZHU0RXBnbHZoejJL?=
 =?utf-8?B?eHFOTWFFNTVaTU43MjJTWjYxZjdsalJaWUoxdmJRdVZqL0V0SGJxUkhENHZG?=
 =?utf-8?B?eHZHcHZBdlJ1dFVsVGFMbEFpZE9JWmRJbVBnZ0Z2MFZsYXBBOUlBS2VBUXRU?=
 =?utf-8?B?aFFra2NoL1VDWFlCS0I5T0VCbE9qUUMzNzdMSWExYzNUUWVHdnl2Slo4Rk5E?=
 =?utf-8?B?M1RDZXRUVE4vUjMwcm9oeVlNY1N0YWdzblJqUVd6RDhudXVGVzNnL21VUCtx?=
 =?utf-8?B?MThFQ3JNZmwrMmZsaVJPRUpyWXBjNit2VFQyMXVZL3diNExPOWtPMVQ1UlNB?=
 =?utf-8?B?YWZlSmx3bXhrOG4zYkdVVVhRd1FUWW5jaWc2UWNibmlmNkZKUHp4eHBudnYv?=
 =?utf-8?B?QnhDQk9ZRmJ2bVgzYWN6dkJLYWlBMG94RXJPQ2ZHSVFRQXh6dkJ2T0tMUHRU?=
 =?utf-8?B?MXpWa2Y1M0NQalg2ZVVOeFRaS0NJYjhrWHUyTVNXeHBiSlV4K3JhTTVxdkIy?=
 =?utf-8?B?MUdob0N0S2gycVVXeHdXWVZEWklXZXJBaTN3VVZSV2lZc1ZrWDVJSXJpbU1a?=
 =?utf-8?B?WUE4RVNsQzZTYWhQN01QbWN5c0hPZEJya1F0cFlCL1FucmJQQzB1c0lqYUh0?=
 =?utf-8?B?eWlPS3VqamdoK0RZMjMwNjFWMFNCWmpnV2piVjVISi9qWXRuQ01lUW9nZHg0?=
 =?utf-8?B?SXhadENseHVqSW1sVFZvSVJPSENZZUxUc25JdDJlRWdoNFc2eFFhdUY2ZXlo?=
 =?utf-8?B?QTdsY3FCZ3h5THdzWlF5VUZRc3hRd0RDNTRkTk84bDY4eU5YUnNkcDdOejht?=
 =?utf-8?B?TGorU05xWjdrQ2ZJOTMrRElTMmdpR2c4YkV0VzFvS1FOS2RLVXlXNlB0WTEy?=
 =?utf-8?B?REREMXlZNk91VWNINWhud2sxWkNUbFlST211YU9CR0Z4bDQvVDV1Q2JYN2la?=
 =?utf-8?B?WW9TNzE4aTA4STNBQWw3VDJKd3NmclFMNVBQR2hqQVliS1BIR2lNUjRPZ0tL?=
 =?utf-8?B?ZkZmMmgxMDBSM0JqYW9LcTZBSFNPSUJnNWlIOVRsMVJTTzFsRjhJK1B0NVRB?=
 =?utf-8?B?STNzRzdqT1VKY2hrUEUrQjF0REZjdjRkVUlRdXNBNjVtMjZYc1hIR2M1L0NE?=
 =?utf-8?B?S0VGY2l5NzZENUtsVGh3dXRaU2JpTFl4OGgvYU9xQnhLSzgvbTdlazV1ZTJD?=
 =?utf-8?B?WWJ5bHhYWEdISTI4TytGRlRSMEkzVXVoV1BmV2tKUWlsUktuOTA3blV6SVp3?=
 =?utf-8?Q?f8X1DVb/CMJ02VxeRf3g?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913bc18d-d5ba-4830-3740-08dcc88bf748
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 00:37:45.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1576


On 2024/8/29 13:52, Inochi Amaoto wrote:
> On Thu, Jul 11, 2024 at 12:01:31PM GMT, Thomas Bonnefille wrote:
>> LicheeRV Nano B [1] is an embedded development platform based on the SOPHGO
>> SG2002 chip, the B(ase) version is deprived of Wifi/Bluetooth and Ethernet.
>>
>> Add only support for UART and SDHCI.
>>
>> Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html [1]
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>>   arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>>   .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
>> index 57ad82a61ea6..47d4243a8f35 100644
>> --- a/arch/riscv/boot/dts/sophgo/Makefile
>> +++ b/arch/riscv/boot/dts/sophgo/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
>> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano-b.dtb
>>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
>> new file mode 100644
>> index 000000000000..fc98b6a0ddf7
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dts
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sg2002.dtsi"
>> +
>> +/ {
>> +	model = "LicheeRV Nano B";
>> +	compatible = "sipeed,licheerv-nano-b", "sipeed,licheerv-nano", "sophgo,sg2002";
>> +
>> +	aliases {
>> +		gpio0 = &gpio0;
>> +		gpio1 = &gpio1;
>> +		gpio2 = &gpio2;
>> +		gpio3 = &gpio3;
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
>> +		serial3 = &uart3;
>> +		serial4 = &uart4;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&osc {
>> +	clock-frequency = <25000000>;
>> +};
>> +
>> +&sdhci0 {
>> +	status = "okay";
>> +	bus-width = <4>;
>> +	no-1-8-v;
>> +	no-mmc;
>> +	no-sdio;
>> +	disable-wp;
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.45.2
>>
> Have you test you patch with a real board? Especially
> for device "uart1" and "i2c0", I suspect your
> configuartion does not work by default.

Hi, Thomas Bonnefille,

Can you please double check and feedback, I want to confirm this before 
acking this change.

As you know, rc6 will come next week and I'm planning a pr next week.

Regards,

Chen




Return-Path: <linux-kernel+bounces-261830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3B93BCB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCD9286F72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE916D9DC;
	Thu, 25 Jul 2024 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aUQZVNCZ"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2094.outbound.protection.outlook.com [40.92.102.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C163C7;
	Thu, 25 Jul 2024 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889708; cv=fail; b=juLWsK/x+WAhi1WOFEQUaUQOc1zFQq7ag+oz1+sHbm+8BnFfdxP/9xl1z5/dsK6J2+G+ioS3yYhHe2/IbWlM6Xy28VDxVYA+Q8EfZuj3f9n+ql2H2ZaR4PbreaVXeRT93X3fa1rqGuC7wT+mcqWJhoj88aOSUFyRTOqS2KlEEiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889708; c=relaxed/simple;
	bh=tNrBCE/NbHSn/eBmnK4bBLZ6kO7jZspAGenJ8EfCPO0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nIQf7gzroCXdlW8MO2Vczic1VNkB9vXS/1zA2CHUv+oWWVhvWyMIaPOb5NVAL/64elcVPtWRfWspFC/H1cTV63oCR/ECZIRlKoTy27CsNU9mE3w9f8MhFmrf45Cmz7/2BSJb3/pbI1uiiREN8Y/4kprCTmMV2LOzbNV1E9rP0jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aUQZVNCZ; arc=fail smtp.client-ip=40.92.102.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THDzwdXqiHL+KDu80Ks2C30fhIYWNrYToCMKB7TPxGZZyQqq/plj60p00yKGF8s2wbNDObmJzjSK3ikRpSyjqjCnAPIr/NcPOEg7Uu1JYbxx93T7z1Dqh9LGcuy9xMyaqd1S5HbELSpU52/VSGuRU8kXuv4dd/ucH7zZWugdN5mQ2/0QO0jVgc70UJmDdXK+a3GlyXyuk3T6mnT1qLEV7Gokq9JzT3wz55Z2C38tZT03rsXZUuHo96kLgMlDKxH4ulzP2BMLc8Umj2EZUTj22nVIFGe6VKwx6fPLdTB3rfqB/u9Hjk7Kuh1Gyj0dqNan/qmyl0J5kbpgAcDyPmQtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJXRZq0AFEHan0a2ngKZspxYaZNavttdsRnWllBl5BM=;
 b=Io6aecL7IbI/BDdg8s4A8t7Uppsibt0FLZKCm2+CSQpJYO+qDcLw+nof/0fyxt6SWXWX8ePP/Odk2E4N+lAnervFFOI46Lkvya/xU2vqGol1APDe0hnIEBW2NtP+LnraW4gysoG0mU37DDq/DIuRKeFu4TAopF/yU2LYnkSXud+HfMIi2TBLTe8QdmXfCn36YV5niUVum1Uct4OrPhhxnT6Vfhf/spIGQTXTEmtQNVFNIpWkisK/OyGegjs36MUCBBCGN84A8kBdYg5LoXBTEZSZpKJ/dfTmA+vb5g50193I7YdHD0qFk1Elr9yDlVUO8Gwy/EbUXB3MuVuOoxo3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJXRZq0AFEHan0a2ngKZspxYaZNavttdsRnWllBl5BM=;
 b=aUQZVNCZJDWciD3EcVB8Whylksqg7nW6e45VQVCpB2apqw8xkZjQp8Z7AdUvnj31YQFMoHssujARmcyI0H91vevEZYLzyulSver9g1c7O6+gXPogXpCJtTTcsvh0sUycyY/SzvpdomGhFIlEltUSJrvtTztlSW4PodkfdWQw3YJEtr9d94zJor9OFO8VbYRy+crwDM3F63l5XhALSbgjCCmC/mBrc6xpJlGpfAzbLycDywTUC3etMF81Gqlq3LQ8O23jVsd0Eh8tr29BOp9nUW8Ts3kgVkI8xXH9M+w9MFtmeA/rg1pvGbYb/tCAuRUZ8J6IErKued86/ZY2smcybA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1626.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 06:41:39 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 06:41:39 +0000
Message-ID:
 <MA0P287MB2822C12B909AA82D6602FC12FEAB2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 25 Jul 2024 14:41:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: Add sdhci0 configuration for Huanshan
 Pi
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [lUQxT4mEGb8wJ0SB4hUQ7l/hr4LfYngI]
X-ClientProxiedBy: TYCPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:405:2::27) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <d0b8c23a-e20c-48d2-a26b-17dd1fdfad77@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1626:EE_
X-MS-Office365-Filtering-Correlation-Id: b523b46e-a2fd-4754-a0c4-08dcac74d544
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599006|461199028|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	03lXVCHoWYFyAY5szPIYJO4rO882HXx4bIOuUDjwXxK60DUbeP6hdz7ZnjPjx5aJgFHoAIuP20uewWpWYSGGOpYle1NH+vha1X3U6KfHKCL77xZIkTh7rUeQ4u0Xqq4mG+jngT57LsruB1HwS8ECR60lkZVHx7GHrLojpR7pow5ZCINrXUkA4HVdS0xppk4yRmy/hHByeOBtdxt7NkgGTC7HidiQz7MEbr0xyhZaxsoBSv2YP+kYb2yNuRl0zbHqO0FWrCfcIW/pmmRvvhWGuaWTmbnaYHtzFM1k+WnK9DRtuCW1EMn/g8HzAx7szjva5aTyK7/RmA2MwAiQotC23pyrR1R8jDYL6587K2eO9kbb/TqZV+EJeoPE4/Z077CugCLWQsybj+gfqcv4ALft7dHjRGN151SjLuDMsXi727kBKKnVXW63pPUm0npKz5eL//Uc4qc57Hial/YP9KnGdSs+phrMQrE+XFc6pSouIeikQWAjM7hocdH32kp9vv9llbFUF6JkHRGUTQmVbfnhIK2ANi1qAQZayOalt9+rb3kMV62VJygdsmC7BEtPdGasaTnFkSPXd5TL10b4dcTck9Dd+VYr29vEHwbO1qWZNcC8M9NUfhMWfoBKMCyaCnKhrTk2B5dCXmmyZr5p7iPiRs+UmlhNafpmCajunqZMc5tygru5jlp3zr45F+b6SnAP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlA3bUxIUkdEb0hSTnFOaGtnNVA3blBMc3dVaEFXNGZWaXBRaG1sbmhicGlF?=
 =?utf-8?B?M2dYanRTWlE0Z1hhZk9mTlNCam1SNUs2YzgzdmVQMm80cy9WNWlwOWNkc1FC?=
 =?utf-8?B?MElQL1dUSUR5RUEvUWtPcDBxMzZ1R0ZzTE4vMzJpVkh1Z0JSNEI5MkZnRVVB?=
 =?utf-8?B?R0g1RTkyYUd0RnI3cHVsU2I2RzNLV1hqdWdkdGFva0lBakVTK3J3TmhtQ2Y5?=
 =?utf-8?B?OWY0YkJtZTVMVkFoT0tGTmNKN1llaituYjRmVVBwU1h6WEFoMnk0Zyt5OEtw?=
 =?utf-8?B?bDVTRFNWUzh4ZUhRVkNYamJEV0EzMEdDMytEb2RuUzIwSldUa2Fzb1hDTzRr?=
 =?utf-8?B?b3AxeVJHMXdvN1ZZRkxEWnNWNmJGV3JUOTExcTl1QldoZkhWVWMwampsZkxJ?=
 =?utf-8?B?QWRGUUFpazc0RnljdnluRlFydkp2bndkd0hWczZiVEQycEJOOUpkbEtZd21u?=
 =?utf-8?B?TzJIbDhLd1MvVkIwT2VocFBYSkxIZUdCTnN0akJmUlNIcnJiOVVCNVg1YWo1?=
 =?utf-8?B?dDJxWlhuWWhnYjhWWUhSZ0F6ZnFtUUV1U1pRSmE0UUhpOSs2YlNmSENnR3hT?=
 =?utf-8?B?R05WUUpIUEx5M2JMSjdBVy9MYXBFVDlpQkx0c0p1djhWc1VGOHNqR3JscUlP?=
 =?utf-8?B?YzFRdnU5cVg1em5YbXdjWUFSR3VTY1B4bnNob3pyRFE1aHVTbWYxRVFnSmE5?=
 =?utf-8?B?WG96YTNzbHZQanh5aVRYcmc0LzFVWlBKSVA0cW82RHBaampXVEZHRHlBUWhr?=
 =?utf-8?B?UzRZK1ZEeURvekxnUHJNKzZvTDlzM1c4Zms2dnNZaHl5cnJNQS8xaU5sTW9J?=
 =?utf-8?B?RE81QnNxUURBRFdKVGdpUHNSN241TmcxUkVjMnpnUnJjM0hYTFpiUDRYYUVh?=
 =?utf-8?B?U3orMDdHQ2RVN3BnUFFTT2RzU0RTNWpTcEsxekpjUHU2dlVMcDl4WVNiTDJE?=
 =?utf-8?B?WkFZNjFWZWdwVXVGZUxFVjY2NnM4U05CR2JuMUlhWEhWT2tXbmhha0cwTjc3?=
 =?utf-8?B?TVg2aDI3cUZ6a0JkampTeEc5UDU2d3p6QXRocWlHM1F3RHlvalhpYzJienlt?=
 =?utf-8?B?RVVBRER0TzZYdzhsT2xMTkxVRzhyTWw0bHFQdXl3MzFrSmlUZjZ6S0RjeVlI?=
 =?utf-8?B?eGhRQ2EvQkx6THkvb2toK1NuK2dYRklJTENmVWtFT2RxUVV6UVVNVzVobUZo?=
 =?utf-8?B?dHpUdXJkYUhZTVVsalJoUXhwTEJwM0VwYVVjNWVOVG04Q0xwQkhnSlpxNFZG?=
 =?utf-8?B?UDF6UzVtajZ6ZUY3c2dRYWdGbnlWdWwvRDRybU9EMHE3a2x3NlVzaW92b2tQ?=
 =?utf-8?B?Z1dUb01yNXlrUjd4akMrU3FZcVEvb1hxbjJKdStIMWNUQUdqSzZBVkE4TGx0?=
 =?utf-8?B?eWw2UmY1QUxDY25JTTJFazdWSE5acUVtbm5qVzNseE0vVGZGUkRzbi9vVS9R?=
 =?utf-8?B?bkxJWk4xY243NXJ0a05HZEV0TFFNOVFjT1h3RU1uZWlJUXhwRjZkdmV1Rzd4?=
 =?utf-8?B?Tklsb3dhS0NaaUZwVmY3Q0gwM0NTQ3RKcExQNDBmbDVxd0djK1lrcXhJY0FJ?=
 =?utf-8?B?QXpla1kzY1ppY2FBR21aa1U5T0YrSWJQb2RCMlJXZ2RqdVBZdzdrR0FkOFUx?=
 =?utf-8?B?QXRXRnN6SHhjY3VpRzN0WUd2akRpQW16WExVMWV0d3JjNFRqalFRUXpuQmF0?=
 =?utf-8?Q?k70p/jPRajzkXxuXurJD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b523b46e-a2fd-4754-a0c4-08dcac74d544
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:41:39.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1626


On 2024/7/23 10:18, Inochi Amaoto wrote:
> Add configuration for sdhci0 for Huanshan Pi to support sd card.

Huanshan -> Huashan

Others LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen

>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> index aa361f3a86bb..7b5f57853690 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> @@ -43,6 +43,15 @@ &osc {
>   	clock-frequency = <25000000>;
>   };
>
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	no-mmc;
> +	no-sdio;
> +	disable-wp;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
> --
> 2.45.2
>


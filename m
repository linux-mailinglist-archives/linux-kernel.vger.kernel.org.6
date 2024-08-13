Return-Path: <linux-kernel+bounces-283953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65194FB06
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE41C22208
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189C749C;
	Tue, 13 Aug 2024 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TZgCPM85"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2107.outbound.protection.outlook.com [40.92.103.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A0ED8;
	Tue, 13 Aug 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512170; cv=fail; b=qb21/+HUy5zIwcde1t+OMmc0pDExCvPX8Btt88ey27NqWLVKjHmzZfEUqPI2O7hcmwZOXW/6d2j+EwqpG51/U0IY9LOjucE1T4LcXqGHW8CMpZE8ZZ6K2EWKBIyim2L/1O+/AQbeY0MNsrmjNFtjJuV5RyRrVN6jY+TGkWpemzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512170; c=relaxed/simple;
	bh=2r2NuubDBmSsQrsQcGaoCCuEKaoGbnOcZk9EN73REis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GI1chcV0wircpJQanbfOQJQbhkIviSiTKzaWIhQnXkiXIWPyWv687H75IAcQjrSc3GM5lvlsivU/bUjyGaK7iDAsZQ3K+hCUZoQSWz8f1uacnCnxrQjf9gyGgEhVX6e+c3LFgqOaAivV0eAiLlvvlDB1csuuW84DGl7S9JM2stM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TZgCPM85; arc=fail smtp.client-ip=40.92.103.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoPTGSQoykr9pBMYUzLidXLmlG2Edp4Il7d1JW9fAksZWH28HaYNcrRFttALzjXtK087bIOAlyCVoqEQ6j0kKQdzjFkSW2TVXWSDV8zwcno8SySLEjG9XzxWgvJzOlnDuD/mR96XnYiv/B9QMAkiixguVoqC3LnMtF4t+7hon50tra8Q9KXlHYZOtkMkAl9i3aHFqeWLWLdIU2LsEO7nZc5cMgBeK1A/lvS8UcRo4G4raso5tT5TrKkuiDfNoAnpx5EAXn61aqq67RbZCN8Gswl5Da2SxDyr2xug+GzeB7CfST+uuFv3Zwy7leL4z54TDlgeGUD5iLaYSbioRxU98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGnbdLqP8bk2cqKGU4VlwgjIwlKbgoL4CvX5JGhB6Yk=;
 b=FBJSn2dNXetkQq5xv1RykcOKYnHJprBNCJZGR5Wr5w2pJ+86ZVX4vq7Vjs0DVurWkgCYmEQ1tWOkBdaE8HBhSACdRF1iXK/FafjhRx1zLb51AkfbM1f4e7739NzdIZgviNt2ggKFDDjc3mKrByf25LeVZVa2uVF7JhsB4edMm2MKJjZhuk5BwteyiCfuCrdwvXACwYnBU58DJSk+W/5WUZm62XqvmS2wrj9GGepB/NnhY61fJhWgCaffuNEXHTeA0ZFrtlTOFhg1jAckhqvV//DRDm+qJRReMu8k2g4lCqgF12/B6Rtd99s0tO3lcHRWaqE7EaFPaV35FmGq6r+KNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGnbdLqP8bk2cqKGU4VlwgjIwlKbgoL4CvX5JGhB6Yk=;
 b=TZgCPM85FBPxEvuupL6lWZC4BCI3RVE49bRCOMLrVDoWSxSooOkxV8AjtPBRbE/dkwRCaGC/hGgd783a3e5f6qGRxdh0vY8Kt8Ye114fTB+ggxzytpOJqn1/LD5aQZsMdNIa087GiXnpIQMd7GvcdqqeJtLIqoRZ7EdJhXrb5Lzo6gDZu4xS3pQgDiXroY0Ifckpr71k7z/DVdvKWMZWkEG2Yj5zezOkTZM9Gdk57pXZb1hJ2h60Obexjm+0tyPKg3wuODDxh9lSq7z/U76nDX2ElViLniON1MqxPa7fUzW9WB08EvVTORjHylyFcT/MRYpSaC9x9cacfLjmxRCdjg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB2040.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 01:22:40 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 01:22:40 +0000
Message-ID:
 <MA0P287MB28225D1113B42EE5C80B27AAFE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 13 Aug 2024 09:22:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Drew Fustini <dfustini@baylibre.com>, Sunil V L <sunilvl@ventanamicro.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [6jq9R3Ao730EtpC99+kBCEJhs+7JrI+c]
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <76b9f6a2-e36f-48b2-a94f-2445abc0b901@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB2040:EE_
X-MS-Office365-Filtering-Correlation-Id: 372e9400-9756-451c-91f6-08dcbb366b66
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	Q+NdYm1ymozKAh3XcRlAqDn27PzGwVxGH4Bbryy34nmeuPhUWxk9B2LaGKsrKuOWDffUythMQtuWca1LYbypiPTJRu/pv0ysmEznZEnjtr6BxnKr1jRmdb5USCTUSIt+XDDBZv18vENLymdQ8kvhRx2ppIaEoOwvJFUA1syp5KEbo8KFxehESv5jx7QKujE5dhkgir+CWABB5BPDDQzXzo4z6jVATdKad5UZbuoYIgwhHGKmtp8WSLPCXOKRxQrr0M37iwyI1Def6AeE/kksbcDpJoO6C3OWYsKbkEv+UMr2Xr/ag0AmZu9Jiu4k5GUWMBcn9XphLNGXdGFfHL0XvkqS+PRvZVzcDYqzhO4+T2N5AtXR5eh1Jhb7xjykP+BzxPoTm8nWMI7e4Ryg17gHfz05c062UpKtgv6mcrmQo+fnpVHF5c8sAhFEDhcnWjlODqspK/OmWIEoy9LOcq8Cev6zWfT+bHDJCBcNiTgas/dxOmlrJPp5kVZFH4Tly8S9PsK5Fu2XTuX8Msi8KERmj/yhm3tA/xBgwl79CtMA7LY1zzELZcgsv84cbCWD10vOhyRmtYNP3htYVyfI3Byj3R3ERGAz4sIeKvnVGLAfiq4twJXPz7mIJaUVJ/HK4YmkOi5QK8h4iDMyo2WOKHUUJp6v83guLeOnJpIPivk75Sxw6bmMxS8mnuWHbfGaT6cUJJpYSGLAw1Rw8AMSmOjsig==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUNlTTdqM2RkQTlCTFhQMnFyNGxHWFVMV3B0U05idGN5UTYxOTROc2pnTGY0?=
 =?utf-8?B?QVhrc3ZPNXYwMHQrUysrSUJncjVuRng4eTl2S1hSNGdZUHczV05UUTB5aG9K?=
 =?utf-8?B?MTdjTEptbzNId3JSWXdTOVpCQWNaZFV3RWpZY1BLOVNoSXNLc2h5ZTFOZVR5?=
 =?utf-8?B?bWNqclNXYzlXUVlaZFFPVmRNVUtMY1AvbFlJUHIwM0dhN1RTYjFZV3hvUWxm?=
 =?utf-8?B?Q1U3MkpyYlpyRUY0S3BxbHFVV2x4RStEelJqSXdiMmZYbEVHcWNpTkt4OFFS?=
 =?utf-8?B?SHR3eWpIT3h1UUJ3TU02UGtoY0lHYnR0d0I5bGZRQTRYZmNOT3FaVExCeHRj?=
 =?utf-8?B?RktQMllocjRBRmZNcUNURWJQL2xxZ3lleUNSd2RrTm05aTdwMlF2UW1RWGpr?=
 =?utf-8?B?aldqVGdwOGRra2pEbHZhVGJSVWhYVExMNmtYUXc4K1RWUjNZWTVZa3Q5WnRu?=
 =?utf-8?B?ZXBaaWZ2RWJEc3NxVXlER2MrNlhJYUQxdVBndG1LR2dVT2gzbHRzUzZtbi8z?=
 =?utf-8?B?OFlJNGwyYUViL1hkVnl4VDFRSkRzcEkvdFVpYm9wT0lsWmExeFcrYitpSVpy?=
 =?utf-8?B?Y1llZWRrNHp6MVl2dTdxN0U2UWh3ZmdQR0NlbDZINHdBSDVrQy9rVGEybXpY?=
 =?utf-8?B?S2d0d3pwZ0ZpRktQNk5TWHo3akRCN2ZjMnJsaU5qb1RiYXNkLzNWYW5wWDNU?=
 =?utf-8?B?V3Z5RjFvVkNGZlFvdEVHWXdRSHRjdnZWMHJBSnZJOGFRUUpKeEZnKzV5ZStY?=
 =?utf-8?B?UjlWcTV0UGhJYThzbEJsZzU4aDJkUkJpbnY1RiswMzdESk4wY21qZ1YxWjN3?=
 =?utf-8?B?alU1b0F0NmVEWHY4Vzk2dC9ybWUyNUxPN0hGWEpvdmxSa3JJcTBTR1crZmFG?=
 =?utf-8?B?cUpaOWJHZXc3NWYrRG9oMVloNHJrbHliczdmYmJScFVZcHpKYng5dG1UZjVY?=
 =?utf-8?B?ckhTQmVvMERWbjI4SmJnODl1TVZmbEtYSUNwYUFqSmVzMnRJZ1FGQ0xKRzds?=
 =?utf-8?B?V1BMNDd3NVg1cklzaUZRdkpzTkdFdVlOSlpMU3VFbDd2Q21nN0F5R1RrRWxM?=
 =?utf-8?B?cm9XWUIzeXJ5Mjl5STgxU3dwUnlRWlZiTFNHaG5zT1BsemJvY05XaU8rM1Mx?=
 =?utf-8?B?RDYxNjkxNHRGYTFML1dzR3hWcytjcFdOSXdoOEo1K0J2YXFNekVjQUFlQzBR?=
 =?utf-8?B?YjJ6NG1aU0thL0FlaGVqUG9SeS9SdVdYa2lENTVOSkIvTHRFbHE1UGtMekxC?=
 =?utf-8?B?MGJoaVQybUQyaGF1N1BMTllGN0xiMGZSVmdaQWpPT2dPclBpbFR6WWVIODZw?=
 =?utf-8?B?OFpoZmRSb2pKN2Z4V0lsS1J5N0JhNnhDZkw3dVBQYjFmYjMweFBndGV1SkxU?=
 =?utf-8?B?QXZkankvVEF4T1dTbDJJZlFtcytMbnN0RzZiTjdXc2xNSE9paUk4UXRFb3lO?=
 =?utf-8?B?LzY0b3NIeGVMb25nbDFMVHRMUXhieGVyTmNVak9MZGZyL0crWlNyQzlBaVc5?=
 =?utf-8?B?am1iRytsYjlSRXJxcDFvYnFJNTUwVEJhTzlMTE1JZ3R5UTlQZm9Vcjg2ejd0?=
 =?utf-8?B?cTNrMEt0WEs4aW5vWWNmYzgvU3Qyd3Rlc2JQNlo5ZmloU2YrWUZrSUd3SDlJ?=
 =?utf-8?B?THVETzNRb2N3UDJXd2FMMWNhUkdIdXVSNFNvTVJMTCtGQkRINzVOUHVKRXBY?=
 =?utf-8?Q?paD4ntbFakUSxs/rVPm2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372e9400-9756-451c-91f6-08dcbb366b66
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:22:40.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2040


On 2024/8/10 16:03, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
>
> Add driver support for the onboard MCU of SG2042.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   Documentation/hwmon/index.rst      |   1 +
>   Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
>   drivers/hwmon/Kconfig              |  11 +
>   drivers/hwmon/Makefile             |   1 +
>   drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
>   5 files changed, 478 insertions(+)
>   create mode 100644 Documentation/hwmon/sg2042-mcu.rst
>   create mode 100644 drivers/hwmon/sg2042-mcu.c

[......]




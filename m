Return-Path: <linux-kernel+bounces-543104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4CA4D18F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5A01663A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678817C7CA;
	Tue,  4 Mar 2025 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="svSStuOB"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDB73176;
	Tue,  4 Mar 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054614; cv=fail; b=eHKLbXkZVTbwot4HdkH5yIbWz/ZMutYnGyGdqPpU0mBgMOnTA5H6Rx9CrZ813WFSK6P1FQ6LD2IHYogu/9VCzhbtcKQh/UriUUJzrZoN2PhD8efRAiEgTo+gPLH9H1GJLSGH8t+HbuNBQ60ZdKDVat0g01ObDOQe7nUP+NSCDk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054614; c=relaxed/simple;
	bh=XUQTEvmKWoHbFZuG4CDFBTAEEq5zMxWOU2F7GZzhEH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OhZxyVQCWNTDi/FjDJFCje/oPi4svEqA4AYr1Uj+JxN1Dfg7ifjwtGEFh+2JzJdKgaUB7u6YhVTJLz5roKzchR0YEmN1eUCbTRYUbAQruKLxpeI8v4Om2ae6sa9bYe1v5W0Ri9DGkxcntn0Q2UOqizyEsTZIcfOBm9wOcIZr5qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=svSStuOB; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7kIX6jMvcsFVux57mWvIIf7SgC/cACVqvqqmyyC5WwoMC4GJ6xqUu0DIM9lQwKVSqTw9j7y8Y71m558XzPSsTFV3Kmi7lj/oCEf9MJ4dvo1G28MnByfq3Xxbr2sPXRKJc2ynhFqBlB1knWZtvwkmZTCGKUU7lWyIyuxUC6oa4x6jDYr5EJ86Mx5zzChXL/4tlFp6KQGRnGdMkctXL9ixkh71kV5rGY1lj3TAFogZx7fZJQl8mhUumMkICOiwNIwA8BtNj/auTIVHpQ7tiZnhUEjQ84YIC35nt/9J4w3iatPtKrYQvZLzfTBSb6RI8qQ/yc9LcRVL4Q595twGNxiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFbR1KW5BwCNEUqibjjZCichG/zm9zw8HEkGtdf8dSc=;
 b=X/0vRLGbu3+2WtcTeKK/S6E5zWrVjmXAKpUVjEea3fPnZ3Jj7N0pyBrVj7RzLVDq1SWKpgtUMbhqyVpuCNgD2yIv1ZwksU6e3WvY9NlNve84nQdHPtBj2/fue6D2UI+QbMDL8FUeXxOF/x5agNVW1kGHqhDqzNEVz+f71CSvaCyFH55YigVFYgXlXDDfV+CXdTYuAjEghvRqOiyJNlE4Nt3GFgxgsIURHF1LWItsvg7f/2ekuxCDgG81vhHm5YoboRpI2VBMtAq7FvSo00K+QNNf0HhUuz6r+tl6ledUVsTk2oafrmbghDZTgt/keYqahCSGPSXw2zq98JJ/LYGklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFbR1KW5BwCNEUqibjjZCichG/zm9zw8HEkGtdf8dSc=;
 b=svSStuOBxcT1ozWJWE/COfVM5k+n8FkH6KcQ9WG24+WCTbZMHx7PI+ZJ8INNMKgSfz6a26B+TnIZf3l+S2ndZDKcs4KXFcUxV4AZYD3los1Py0ki7zybZ5u4AYXxvQSgP3SnSgJ1CB7ElF1I7zBsZJdhHAKT3ODunXTkx1oZhWS4QczzikkTMIO8O/96J/6McaP8OJx45OPYrWp6d1TANcv3bmAjCJwS5bda0c5tE7nR+uLnP8NdsNV5oDtxHkZEPn4WlwFDm+SFawN1UdRnxcwVhzHsPoNipCP2HtSeRKXVHqL/S1o4dgmpBYaXef/IcxyTISLIqQIyzqB0L6bfRA==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB8920.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:cd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 02:16:46 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 02:16:46 +0000
Message-ID:
 <PN0PR01MB1039343DAAEFC794E30056ED5FEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 10:16:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250303111648.1337543-1-inochiama@gmail.com>
 <20250303111648.1337543-3-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250303111648.1337543-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <c14be9dc-3134-45ed-9790-9b5f493d88cd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: ed69441b-89b0-4925-ae26-08dd5ac29be2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|8022599003|8060799006|7092599003|461199028|5072599009|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFhmR0dDZ3VGN0g3aFMvSW42UjR2V3lZTWhCM0dGK0dwM3NyQlVNMGhKRTI3?=
 =?utf-8?B?U21WWHRzS3RxN04yYndSY05sQmJHMDFVL2dMZXdEdGpuaDcwa0RMVzhHQVAx?=
 =?utf-8?B?UHhmdWRjekRwcHBvcktYL3RJYWZiQjZNUWhEMGEzS1JQZG93Z3JBQmZpVDVT?=
 =?utf-8?B?eVRQdFNDbkZpQ2xhWE9tMitRcEMxRHpxdUJiRVlUN0FEaXppUXJUT1Y2MTQ4?=
 =?utf-8?B?YjljaTNDektEQ3NIY0ladmhncFZLRkFHbFlRQnJWc3dZcVVFTktKck92YmR3?=
 =?utf-8?B?SlZub0NKeVV3VTRqdjhtZDdNZFZFSUtLZ3lLb1Y5S3pYdU5nbUpuYWc3aWxF?=
 =?utf-8?B?Q2JjYWJTdUp1dTRONW9UcGx4VXNBKzFyVStFbmIzaUh6a2FTdkVWd1RUSU1S?=
 =?utf-8?B?dENST0s3UFV6elRHNXM1NGw1UWJhM1h2RlcxSDh5UG1pSjAyc2p4UVV0RmZI?=
 =?utf-8?B?WDF4d2hDN3BDVG5jMlRRWWxBQ2wrTWk1S2g1aEl2Rmt6bjljcU9YS3ZCSTNp?=
 =?utf-8?B?cFdEUG1wQXNmVU0wSmR0c1NVQ3l6ejBIdU14a203VVQ3am5CQ2pnYUZDSkxY?=
 =?utf-8?B?S1NtL0pjTkxqV0oyZE9YWERRclovd1M0aHlwZ3JwNVZuSzFTNkZzSVkzdURT?=
 =?utf-8?B?bUxuRTlVMmk4TlBrRXNmeEtVWjBaOUY3TjdYV256SWV2LzM4ekl0ZTI2Rm1h?=
 =?utf-8?B?RUFnZTUzWWhyclNwL0ZIUEU0SXNhRVJZdmhFdmdFbzg5T1JWMitYd2I3aFpT?=
 =?utf-8?B?UEt1MkNUa0hQdGZSczFWWlJ2N2RGc1BITTNnc0pjVVpHemN1WC82UWxTWXRC?=
 =?utf-8?B?cHE0K3Z4SEFlOXlCYjBWaVZicU95by9nQmI0MkVvM2F5aE0vUjNWSlNXQ0pw?=
 =?utf-8?B?dkR6SWJVQ3FTMStPZjhrNUZ6M3dzUDBHZU5aU2FDcDNmZll2c2xlS2Juc0VB?=
 =?utf-8?B?RFNWdXZiSW5uc1EvTkM0WE14TENaV3V4MEUyb1pwZTVjSUdJWUFGVGZQK1Zv?=
 =?utf-8?B?KzRTd1VOWXlZNDc5dU93V2J3UitoUkJlSHphRHY4RW8xbExUM1IrU0VOQTc4?=
 =?utf-8?B?dDF1Vm03S0JBVWNNSjh1VWN0MTA5NkFyZHpqUjh6aW56MmZmZ0ZqVThrZ3BX?=
 =?utf-8?B?S2hySVd5b052Z0RGS0xvTUJPQmdCL1NnRWU0Wnl5UmJ0SHRicEw3cWNXSFJK?=
 =?utf-8?B?d1B6K2lDbm1NREZ6QU5lMnIrcmk1YjcvRjVuaXpmMmxEeHRiUUNHQ0grbjB4?=
 =?utf-8?B?L1hPZkVCSVc5MnJlcllxaDI5aDB6Wjc0NEI4OHpPNVpZdGYvREd6WXlOa0VU?=
 =?utf-8?B?bnYrWGpadkErRExxWDBLZTNYdjBGMTF1Z0J6TlNzUGFUdXRON0pjWnBRb0VZ?=
 =?utf-8?B?T1gzZVh5WHRhNi9ONFBPeFhwZ3crMXF6OWE0ajdXWXdnYW1kVUhZeElzMkFi?=
 =?utf-8?B?eWpaRWcvMVlQOUt2NUVSUWxYbU5YR1lGT2NUbVN0c203UzI0MmJWVVBqU2VZ?=
 =?utf-8?Q?weM4QBnjZA7gSkyda7NIfe5sTrG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUhueXJaV3pyS2RnRFVnK3JMcmhacWZMeUE3dnUvZzFtSzZtczJvdVNLMms2?=
 =?utf-8?B?WnIxR0pTZXJXRmZvVGZIVmZkSVNzN2Ewc2ZXUm83ZDFIU3ZrSFdBOVdGTkFW?=
 =?utf-8?B?YVRsb3hVTjFpSEZMZTVDaVE4cTR4bzNCOHlQcTBwRWVqNzZIY0pJK21uTUov?=
 =?utf-8?B?K0tDTk05dTJ3SkU1YTRxM1l1NTVGbVpiY1pmUmVTNEtuakprblN3azVDK2Zi?=
 =?utf-8?B?dkVISFNNa2VkYk9xQzNZd1c5K05lVGx2em1RTkdhd1F0bzJpMW1HcVRRZHFN?=
 =?utf-8?B?dnJ0b2xkc2VhdFNLRnp4K1p3V2plYzdSVU1qY0paN056Rzk5eWJxTUx2OTVo?=
 =?utf-8?B?ZnhrQ0pwRmJVcVNCM2w5VlhZMExrSUxYZmJoNmdTLzJSeWp4M01vZjlRNTdL?=
 =?utf-8?B?ZytRQjJGTUNiMWNuUUgzR0crdFMyWHU1VUN3c25BKzc1R1FsbEhUaGcveTIz?=
 =?utf-8?B?MjdBSkxUTmY4WE03amlXNjMzZ1lYM1lwM2k1TC9ZSDVuOGljSGMzNWpLMURo?=
 =?utf-8?B?NkRvY0ptVWc3aEJBU01uaVl2MFdKN0c2WE5LMWNpNmdZcE80cnlybmdaQ1Bw?=
 =?utf-8?B?SlM4YzZEUWN2Szd5V055bC9kVlFTMFRLT1FEYldkRVp3QlVMbnNaMFJlZFpv?=
 =?utf-8?B?L1ZFOE1RSDVrNUVmL2tIRHVaeTlGU1BjbURIUHJzNE9KeXE5bWI1cGJGbCs5?=
 =?utf-8?B?YVlrVlFBZGJyVmpFK2tiV05iQlU0cVg2OGZQc2RNcGRqUmg2THdhT2hWWTJZ?=
 =?utf-8?B?NlFldHRIZE8zWmI4SGNYL0dkbWZ6UmU1SjVuc1BXbWg0Z2NkSHlGOWxaUVRl?=
 =?utf-8?B?L2Z1TFBXdmlvSk1ma28yeXBWL3Fja3hLQnVnZ0d6cjBDcEdhaVUzd1kyejRn?=
 =?utf-8?B?OWk5QUlDSDBlcHlJb2x4RnhmQ3FmRGpqNFVuU2pkZEV6SzByWmF0RVBYOTAr?=
 =?utf-8?B?UTgralJYQ1dpeGllRlNlVlNYVVpEUExQUnVacjNuSnowTFZGc2NYbzNDblhP?=
 =?utf-8?B?cmdCd2UxZ205OXFqZzBidVh5a2JJSHY2MklSMityY2JCeEpqcDJON092Snhz?=
 =?utf-8?B?NnVkdUNOc2pCOXNxL2NDaW9LZmV1SHo5ZktKbVl0TUhFaGNBWndQL3BXNDky?=
 =?utf-8?B?V1ZBZjVDcks0WVZpVDlSM0c1dkw2V0ZUTEVIazlwQTBEdll2V2xhOUloQUtp?=
 =?utf-8?B?Wm5vVmZUNVJHZE1Mb1ZhZlI2SkVqSzVteEJndC9jeHFlcE5PMDhkdE5zOW4r?=
 =?utf-8?B?QzZVcjFRMHVEY0V4ZlJqZzFCbWR3ZmFKRzRVSzJSN0dhWXJwN2VKQUpYWE9W?=
 =?utf-8?B?QUlPZVQxbVJTRkpuaURVSUoraXA2UXBRV0ZTUWNFUkNWcFdUZjFQMzVLWXhV?=
 =?utf-8?B?aHNTeGthOFdTNVcwa0RyYmFpUHkvYXd4M2JTcytGTU5MelVTRDlPRmNCNU9y?=
 =?utf-8?B?cjJVUi9NTHBtVUpERUFId2lsVmFDUUxTSGxZdXBDbjFuN2pFTkZrOGJkcnB1?=
 =?utf-8?B?b29MdVRINGpJSmp5MTI3ZVAyQmxuRGhFa0E5NkZ1S1NYYWxvY2k0dmZyVGxo?=
 =?utf-8?B?ZHlGQlRkcFREUkYzME5IbElmNnhQcktiQ1l1Y0lheHRQeVllSlVrUUxPbHdt?=
 =?utf-8?B?LzlVNUg2Y2lxRWdyZHFKRjZGS1A4cUl0aW5COWR6T0YycksxcmV5UUdOS0p6?=
 =?utf-8?B?NS9wMzlacXQ4cThLUkxjM3djZXErcEQycThBVjYyRWxHaE1aVGdqbEVJMmlG?=
 =?utf-8?Q?9YYR4Qz7hEqqm4ll/nj+1Uc985XMTKDHf2GYL0n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed69441b-89b0-4925-ae26-08dd5ac29be2
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 02:16:46.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8920


On 2025/3/3 19:16, Inochi Amaoto wrote:
> Add support for Sophgo SG2044 MSI interrupt controller.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   drivers/irqchip/irq-sg2042-msi.c | 86 ++++++++++++++++++++++++++++++--
>   1 file changed, 82 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
> index 9c0a5f2777a4..4b3992821797 100644
> --- a/drivers/irqchip/irq-sg2042-msi.c
> +++ b/drivers/irqchip/irq-sg2042-msi.c
> @@ -21,6 +21,11 @@
>   
>   #define SG2042_MAX_MSI_VECTOR	32

Drop this since it is useless now.

[......]

Chen



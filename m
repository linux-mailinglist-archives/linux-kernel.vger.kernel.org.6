Return-Path: <linux-kernel+bounces-510654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD16A32008
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0679D161E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF1204685;
	Wed, 12 Feb 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Px43CXp/"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DC1DACB1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345638; cv=fail; b=qSZ21lBjg6kS1GZnMQ8tYa4FmOXtWLGvJv2DqgF5/NedPoMYjh6aIRBwehBwHs7yQy0XSog2su7pyd+ql76MP28DZcuXwVQuKikwrNfMQ3rRaoNpGqpWaRsqb3UIYGY+9mgbTjumTED2PwjtrdeMvJTXkqicQ6FlPHa9GZKQMIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345638; c=relaxed/simple;
	bh=BgaLAbRLwaA5a0zWM/DR4mcu7XaV1XeBjrHPocBES8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IcJhRHHZPBaMXRGZ4BAkH9qJIEfPVt8VVxzsC6O4QoJYO1qNfAZTzjzHVYAlBnL1r8SDzpMt2t9lO1qXbuFJdOl49yrDjOGwIf2MwRBLCt9XZTIYrxj04Rbeth8/iMLIoV37/aObW+2KGt8yIAX5lS4oAAD1SbxbqYMHVjch0tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Px43CXp/; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvEWExig/5Ni+qHmZkLTQzzJVlj/tagzZgc2q7CFKdCNz7c7GgrIjc7HXKKGUIDGUnakHjV1Wz1Pe0o78PEzoBxBeO4bCj0kx+VqyHhRsUO1hk7th9VkNrK3inCjBq/qvQDtSpxAqdg1hsWALoaajfAaJ2td2SmerXLVYPl7l9reePg3jhWl/c3JhzzCiPkVGTfrDKhN2qniIGxVB+KkxByYFm2+yuys+HlqGsIP84xCYQ0pgEqU4cmCvq1AYGvro2ER3XMmKV/t/bXhCCX8YHfNwdnjRmIVXHQoaUXCE1+AXTF2VWW6hVuA2/k7/vqeRvUjRBF3QQwTQsDOtoGXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKbkZeEHrIPsNWomsKlKyKKjbyZT9zy/R8hDpIqmxLA=;
 b=qHuF6Iuz2yQN7GY1nHKWJmtN5e//xoV6c1Ic4kNmXM/aeETx8XKo0xd4hOqdgKj95TxQZPfyjsTTxOyFlFbctwY+0ypYNhZR/9bjC4nHK3Dp9hneqtrgVbuo/epIJ5PUgnYWGVtkGrxqW7c4f3y//ntqce48xs4Z72lS6PG8uRkUARzDawnpwExIu36RwUGiNXjLsRzeAD3061/t/UJBWGQKESI0FAS2YQgG76oDxr2o5QLSg65kS5ycJCjuzMr/bR9zxHpZN+ylKIUaIA4HlY+YlBRG2E5hnF0pZpjukZC8Xkk+NE3klVCjhx9edwfzSK5dOf9XaGxL2jJc5sOn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKbkZeEHrIPsNWomsKlKyKKjbyZT9zy/R8hDpIqmxLA=;
 b=Px43CXp/QOZhJtNwsxZ0YhK0Eto0HLynNaL52txuWx/P7L/vU91KNWGstpyZ4Wywsq02QTID/SmUQTnhNtrLJiN/JwgNtaCLUSHelXHcsNkSNlvovbwSMlQLJeHIAhgQw5Llcqz4qGzzb/v/2YS5kJNYVPUQE63t2Ja0KFm1aVcV7xjG1VHhpo2dDQXNXjfB7nq1JZZkK+rV+sxtFjSP4lmyNgIjfLHm7xosLdUPGn6Bjy9Ul7QsV2w1M4X2qaoh47F3TFlZ+hwJ2W1WRzX3IrlDaB1lIT6r1GchxJwOjwNWXnjvBrqAT4vI4rID0af/8Py+C8XU6SWjoxJ3FSrduA==
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
 by PN3PR01MB7239.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 07:33:51 +0000
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71]) by BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 07:33:51 +0000
Message-ID:
 <BMXPR01MB2440D2844398CD07EDA3443FFEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Feb 2025 15:33:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update info for SOPHGO DEVICETREES and
 DRIVERS
To: Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20250212022831.244143-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250212022831.244143-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:3a::19)
X-Microsoft-Original-Message-ID:
 <9df68f6e-0085-44dc-8f85-0c3a4cbd846c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2440:EE_|PN3PR01MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: accc0557-9e9f-4b46-fb61-08dd4b379869
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|5072599009|8060799006|19110799003|6090799003|1602099012|440099028|3412199025|4302099013|10035399004|21061999003|12071999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnZEajhKNERPTlZibDl6UHkwZk1CdUdZWlZQKzhuZ0VpeFVNb1Y5Uml4cmU2?=
 =?utf-8?B?b2ZGSTRxdkNDMEtUNjl4eVhDR1Bhek5LN0d2aitjYzJtcHdLNXBRQ1dHQTMz?=
 =?utf-8?B?aTl1anIxS0cxNnZzUWJVWEdoN1JVQ1JpTGtOeUJUMFJKQXY1aS84UFRGV3VR?=
 =?utf-8?B?QkJ5YVlRL1J1Zm1naHdCU2ZDZmJMREo0RzhONm50djB0SE5SZHB1NGdudUNy?=
 =?utf-8?B?THFiNC9rVFNFRG1XU1pzUUNaanVZcHdnVE4yanpCNlJqNXI0ZS9ldDJRaS9z?=
 =?utf-8?B?RHN5b3lNWHMrLzdsbFlSemEySTNyMVZBS3NMckVMb25ac1JJc3Z3QVV6amRF?=
 =?utf-8?B?cFpSNTdCQjRPOXJIVlZEb0VNVkdpeFJWMlJtVFNrN3V5a1JqemptelBNUFYy?=
 =?utf-8?B?UzltYzRwQTlBWHl2cHRoWkY4Zy9aVUM1eUVtRzFBRithV1lLSlNvZ1BYY2pr?=
 =?utf-8?B?bEJZZTc3aVFvaGVRZXFFZjAvbzZPckw1REhZaUxCemN6KzFoaTJtbXJaV01V?=
 =?utf-8?B?MTFCSVNydUhrK1daNDBFU0dZemNvUk5PU1d6Q2lHNHpUUkFYMkpHc2sweEYv?=
 =?utf-8?B?ZUZYTEJSNjdibWRNdlk4YmlRZVNFTzRmdnpGT21tY3d0NFNSVmtEanRJaVJm?=
 =?utf-8?B?bW1ONzRVQ2c5a1JidHR6UkUycGUvc3FpSkNpOWprU1BmRG0zV2tGbzRmM1FZ?=
 =?utf-8?B?VnRQR1pYK1NHVW9GeCt6Z1hCWUZ5ZHBOK2pLcTdxa1VRWWRSV3hlbnJuVTY3?=
 =?utf-8?B?TzFaMVRQV2hOK0JMTWtIYlh2Y1phUUdnY2I1dU01MVhxUGZrUjRzRUVRMnpz?=
 =?utf-8?B?TUNsZlJtcUI5Wk9TZE9NS0xSbzN3elpCUkdkRDVKQlo5QWliWklWMVJtbHR0?=
 =?utf-8?B?VGQwekJrd0FrYlRUbkVESXlDdlYySmdSY0dWR2kvc0tqOTB0QVFFUktpeThK?=
 =?utf-8?B?RkhYcU1UYUN1bE5Ta0VTZzdlMGhNRWlSamREUTFRSW1IUjNCNXlSUVZnT0dv?=
 =?utf-8?B?ZTVIc0tLS2NWcWdQeHZNMzkvajNuc3lBcHNYR1AxeEd1WXgvNEtXUUx0djh5?=
 =?utf-8?B?amVncm5Beis1TjBrR1BGd1BXL21xYVdVTHlPQzBqblVRUHg0ekFORlhITU5H?=
 =?utf-8?B?L0NXQVJGQStpcE5ONlErcU5wQXVtQjk1TWY1RjZKWXhhTU8vMHBlOUR6Y3ND?=
 =?utf-8?B?cjRDaHpHcEF1WjZFOHNOZzJSZHpqOHh1ZWVhb3p1OG5lMGV5MGlLYmQ1d0hM?=
 =?utf-8?B?STZ3QXo2WWVUenVRaTNJMFZLd1BHSDZ1YnE3R3RoanE4RC9Yb1pidHp0WktN?=
 =?utf-8?B?ZHl1c3VFbkNqV2QxV2RsTjBiSVI2RzNXdEhKNnYrb1grcHNMZTFyQklEUHpu?=
 =?utf-8?B?Z2cxb2JXcTcxaklhbHlPNlZoWWRWOG9mRGx3VUFGSFlZc2pBUGwrMEZJcmF2?=
 =?utf-8?B?cFVHZFdBNFhuRHNaNktIcVRXaHVGWUY2ZEQ5QW5yRS90bEIwVkluZWZWT2Vr?=
 =?utf-8?B?OFNwZjVEN0o3WlZLYXYrU0NZVVBqNDVOTVh4cG1zc0lKaHBBZ1V0ZVE1bC9j?=
 =?utf-8?B?ZWRkRU44d1lIYzFUc1NHZ2pzckw4WFpaTzF4d1dFdktLR0Q0aWh6ODBTOGFJ?=
 =?utf-8?B?WmMrNHFxSFFnczBuWnVuUkRNak96Zis0b3ltemMyWUdUZ1A3VEVuZDI1UzVJ?=
 =?utf-8?B?OTgrZUIrbDBQUitjbEptZnppTmtad1pIeFBxbGlFYWppM1JwcWJXOWNyOEVL?=
 =?utf-8?Q?O0PPdSJkJUNVikvzgI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjVtczlBVEkyVTB4b083NFY4QngvdERuTHBmaExQMVFqd0pKOHNEVWlCeHhC?=
 =?utf-8?B?Z3JPS2s3M0ZQS245bFNqbEEySzg5MEVDVDJXUzFCRDMxWk4zbU1Hbi9TcnpG?=
 =?utf-8?B?RVk1SGhMNjNOUVdDS25PcnZRN040bFhaS1hSUXNBekJlcVNtUVhPMFpqREpy?=
 =?utf-8?B?NG1jSlJacTZBVFlieEZwZGVpV0cwaStPSDhMRTN4T2I2ODN5YlcyeXJLM3RM?=
 =?utf-8?B?enVvYmN2UXJxZTBidXJXbVdOYzcxbmtDdld2M2h5ZUNjeFZjNzlHb0xaM05T?=
 =?utf-8?B?QnBnSUdzNUZJdjFwcWN3UXJHV1ZXQUZDaGRWaHJoU2VsOTV0R3lQbWZEcGU2?=
 =?utf-8?B?RzE1Q0loc1IwMWxENGlpMU5UNnh6aThmV3lOcXRkNEhqbGNOSVJTcnJyYTcv?=
 =?utf-8?B?em5tQUlLZmVScnBrY25NNXhpeEZCY2ZrNlZUSXAveUMvY3FMSGY4YTF5dXdr?=
 =?utf-8?B?bDNOY0NCZFBMdEQrSWtJS01DcmFvVFh2VkpQb2g3SHUwTVo4aU9OZittSUJS?=
 =?utf-8?B?bE1zZ3ZCaWZqaXNGVEFNVG5kRE1uakJjY2hDZ2VWaEhwWFNNblBMR1ZnY3RV?=
 =?utf-8?B?aXNnOU43RGxRZ2ZxYjNFeTNzOVQxamNsMmtQeURRUS9TWUpReEh6Q0F1RjJz?=
 =?utf-8?B?R2syWGZ5d21sV1RaV21ESG1YYlpiK2c4SFZYQmNjYUJ4YVp3aXNWb0lVS2ly?=
 =?utf-8?B?cjVML24wTllacWdDblkxWjRuc3NUWk5aem56akJtSmFmM3dTWWtHUm9uRWFE?=
 =?utf-8?B?RVlla0xHa29VU1d5dHZIT0JmWEk3M0lGSTdRZkNQemswRU5zbWFIc0JsZS9m?=
 =?utf-8?B?RFJMYlpsTHZuTFptN3BBaEdMVFRwMUJka2RQamRYdml6dWxkTWkxUmw4c0dO?=
 =?utf-8?B?c2dySVREeU9SbnhNUTJ2VTJTa1N5dVRiS2J6T08vTkhuYzRaUWJKcURUWkpl?=
 =?utf-8?B?dTBKZzZzNEZqbytJTWtKSEEveFAxditHczRrSEc3OW1JSTdrZDV0a1kwbi9q?=
 =?utf-8?B?TndHU2RSVVg2UURVc3RHR21LU3RtL2NQdktQcnJ2WGliK3JFY3JIMEFsR0Iz?=
 =?utf-8?B?SkFJd3RjLzF2eHczVmUrU1Nram8yTkNWcFZocFJVcytBMmgwekZ1THBUQW1u?=
 =?utf-8?B?S1B1bVBUUXVNcWJDMHFyby9NV2hva0NsZk9yem9jZ2hCSWpFNUczdS9aL05N?=
 =?utf-8?B?M0JnQVUzaExZVzhXa0hFbUZlWjdGN212d2crRHVsWkprK1lmWXI0YzZBazFi?=
 =?utf-8?B?NGhPeEZ2b3lwMmFlZ045L3k1YlJaOTlna2RwaENLRVh1RnBLY1IzU0ZNaXdw?=
 =?utf-8?B?b0YrVHRsWC9MR2k4K2FvM2k4TWRkdjkxb2w3NGU1T05Kak93NThJc245UVZQ?=
 =?utf-8?B?M2tzdHNQN21ZaFlacDkwbFlURERzOCtnNDNzNnRaSGZENUhNc3BRRUR5dGh4?=
 =?utf-8?B?NUUwcU5uSzVCVU0zdGxkeENXNFRKOVJlaEpNSkM1Yk5oMWVic21jdHZtNGRM?=
 =?utf-8?B?MTNvMTJqRThMMGdOa0VuU1hHa3A1eitvZStOS1BCK0NBQjBqRUJkTVl4SjZJ?=
 =?utf-8?B?ekV5MXhsMWpTRjhmYWhGNUxNeUxKOUVYSnJqSmZtNy9VaUV6WkhmbEtyTHFM?=
 =?utf-8?B?K1Rtd3crMC9Ya3JhaytPSE5CcGJvYlJkdlJnOXVmeTNOS3FDV1dxVjlVNmN3?=
 =?utf-8?B?MHUyQnNHUlF3c3V0bStaemhBYmZRUzdBVG93ZGVGaVIvN0ZsdHRjR0xUY1Fj?=
 =?utf-8?Q?DBP7L46VwMankJkfe3O6r2H8iEWVhwMSOWpZuDL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accc0557-9e9f-4b46-fb61-08dd4b379869
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:33:51.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7239


On 2025/2/12 10:28, Inochi Amaoto wrote:
> Add mail list and wiki info for SOPHGO entry. Also change Inochi's
> email as the old one can not be accessed.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..6b79681877d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22097,7 +22097,9 @@ F:	include/linux/sony-laptop.h
>   
>   SOPHGO DEVICETREES and DRIVERS
>   M:	Chen Wang <unicorn_wang@outlook.com>
> -M:	Inochi Amaoto <inochiama@outlook.com>
> +M:	Inochi Amaoto <inochiama@gmail.com>
> +L:	sophgo@lists.linux.dev
> +W:	https://github.com/sophgo/linux/wiki
>   T:	git https://github.com/sophgo/linux.git
>   S:	Maintained
>   N:	sophgo


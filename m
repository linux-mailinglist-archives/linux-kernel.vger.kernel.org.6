Return-Path: <linux-kernel+bounces-550554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55DA5610F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F327A3AF635
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDDE19F13F;
	Fri,  7 Mar 2025 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="E1GDCpwE"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DE1925AC;
	Fri,  7 Mar 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329869; cv=fail; b=DaZ7uMKVYr2DdXf3Jg4Qa/Hz4TDX9uZJLSI2h68C2QtBzDN/HJSvEUmSpSlRYX4bx6A1H4GEGjbdQMr+pvqFinIkEZ1GO/K53wN6gHPIcOhmHqkR1UV8vxeH1VeKcT4nZu9dmnIr5SdflfwX5QUR/Bks5ZIzBy8yfDs3cc6xBxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329869; c=relaxed/simple;
	bh=ZFQdnC1L1182zSNeczOENqGuXj3/LR6hF+1MnHfSo64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sfk0IL/1ilPjWd9Y5fNMpkXHxWelaOpna9wJELa32HMaKT7C767XUF/aLx5h5tZfkF9GxX/8HwEqVN2phmsdIXwc1fKNztyDtejYUXmy+Dvx7DDXN5wLwtvnfsc/suTsKiBEx5N6vMlKqLauVxsFNQGMAG7Yk6+29aE25d0CyDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=E1GDCpwE; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wct2gtHCq/tYdotrqzrTB5cPC0kQ83EWSdPsRyC8uy56LMOW9i/EPAXPmR9JloV2pUA5GcHgzQEDiSj2f5AM4X5k30F0sH8ufR+X535N9DtHCue1K9Ue5UKrTs9j6bxXEG57wK31iGfJyKImfRG+kbrsWwh0wtAOdxB+Oivz5o+6auzG1lry+qt3eXAKsUkXMQ++3qwEBFLLR/pS35R66ywAfhTjEWtGFcI2SwNVYcnaeJtb1iCivyB4TDUPz9XJPQ5HY5s+SenxC6G+rmC8xltouicuRBhK7fZWKqhZ5Z+Eekcfy5EOnffmB82DC1y16Jk3tAkegtsos9V65mKmvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnGhBmkXuhU1sE/zRnFaRexqTJLCB7SesL7Atj0KET0=;
 b=RO5aEfWQtwc1WV6iXy16iVF2cI2LgxiBWnCkCjDWcrSYdf5s2S4W5nw4PlHuELYK55uDakSczgKdanbS655OejzENtezw2F6rjBuZboydiRwnCUZOIFThKFL8w/9sqSzP6mOqzK7HRDxj8IEc698OFTNL5HQw9becSh7dqswb7RijXgRFTd/rlMay2pY1HZTWqybEy4tZv+XBnaSRH9DGy89/bvUrZm3Nx17MhQEXB/4eeKzs8esig29+JX1TltAUqv3hmMo/d216inwfgkLfioor2VEmmZNDakF3Ej2XhfLLr2fl04ubtdSY9X6d9Yc6b3UZeFapYbLFSN0Wz9faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnGhBmkXuhU1sE/zRnFaRexqTJLCB7SesL7Atj0KET0=;
 b=E1GDCpwEmlZ0SPjITtxxd3cfwmmsSjE9GGy35nTtiCfml76hVh5p5DbcgpYWJ2T0RHdiz4msPP+pzxQwbXBl8rEplciJsZpDy2bAxjKgVp2gF8WAQmc8OFkH+t/S7WC6bR+6bNjW9QYF8uS1+/J4USRgTVWXz8jPZAzDIi8jwmDNz17I+WbcpKh9OWxnNl6GU040IU0F5RxcvTZ64Y8FDwRldIivapdwHDd3QnoiaFc5aPgIYD6szdpaKVl1sLhI5GxqfqCWhZLlMFQorqwI7JBb40mRbO0MpV68uR73+EOfoI9lEIOlftwZOunXQxKtT606tkBxr/ULcV+38+2Vkg==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB7684.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 06:44:21 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 06:44:21 +0000
Message-ID:
 <PN0PR01MB1039307E64829A685052433CAFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 7 Mar 2025 14:44:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250307010649.422359-1-inochiama@gmail.com>
 <20250307010649.422359-3-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250307010649.422359-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <3b1825c4-f3e5-45f5-a3f8-5116f1557b0a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 553b97ac-95fb-4bb1-f948-08dd5d437da5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799006|19110799003|7092599003|8060799006|5072599009|3412199025|440099028|12091999003|19111999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlVhemxkbTB5YlBWNG1HM282QUQ1YlgrNi9DZzVHeDFEbmxKaGJ4NXpmMlRk?=
 =?utf-8?B?K3lHZVQrN3hxR0lQd3hrNE5BYnpoSzRNelA4UWtiUzBhRGt6MW9KREp2SzhE?=
 =?utf-8?B?RjZ1blBiMlZDSW5ZdDRXaEZBQnJ2OHNHUXVkbDY1YzNqTUdwbDZaUVJPVUhL?=
 =?utf-8?B?UUpjNCtCeTZGbHVLT2dkQXpHbDNJNkNkOTVNWmtyZmE1Rk5nclppUkJRdmtD?=
 =?utf-8?B?cG10RldMNElKZVVHT1VKWHVLVVRvM1BMSjNaemFuaXhFSktTR2V1djNwT0VC?=
 =?utf-8?B?VUJFWHNKSWh6SGo2N3JwOU0vcWNNVmFsbkZ1RUJaMjdPaWt2SjhQOE5oWnRB?=
 =?utf-8?B?cHZ1SVY2SUkzOHFzck90R2s4WWFKclR3UmlzenhETmR3eTF5ajduUEZFUERs?=
 =?utf-8?B?K3F3ZkhjS2FsSzhndW9nOXNqL1BIT2JFa29uckRsL211TjNoZEc1WXNwN2x2?=
 =?utf-8?B?b21QM0E5YVJUSTdDRE5ZdGJJb0l4TEZrTnoyWHoyYm1xSnRobHA3REpIbkhJ?=
 =?utf-8?B?anZ3L3R3WUtkbzNnc3ZBVlp1UFBsZFJFQ2IreGRCcWVPUmJpS1pDSUdWSTI5?=
 =?utf-8?B?VGNKMFUvT0NJSm5NS2ovUVlJTWZ2c0tMcEZlQWRxRmZRN3NySTdDTXZrT1JF?=
 =?utf-8?B?QnRrWW1XQXQvZmVZQ0lWR1JFZUJHYUs0SE1reERPekhRZG1hdEJEem9nV0la?=
 =?utf-8?B?alRxb3VQeGFuYUxzQzlGa1NoakpUb0U4eGUvMkdjcXlsbng1UW4wU0g1eWJM?=
 =?utf-8?B?UCs1akxMdGMrM1ZqbzkrSWk1dC9DaHNrbUxyRmRsV1d5NVNJb051empreTd4?=
 =?utf-8?B?UnQ4bGZ3VGZwNWJrL2hmcGdsak5NTFY2NWxxcXJtd1U1bE9qa0paTzRxaW9J?=
 =?utf-8?B?THg1NFZ4bzF2c3RaTnJQc25TK1hpeG5pdlJWTUtUVVZrcDQ0ZUFHSFM0d3pt?=
 =?utf-8?B?aGJSRUNjbmtDMy9QbGZ2UGFENVVhZWJneDZzNzBLTzhFY081R0IvSEw3MjF1?=
 =?utf-8?B?WVFOaVpEY3h1emZRMHlkZ3FaTjVGWjIyalArZmxpblJ1RVQ1Y0kxZGxNNDdK?=
 =?utf-8?B?YS9CTHZVT0kzMlFJcEQ3OEpqaFZNcGJZUEluN0gwdkY4dnBEaUppSE5SUEY5?=
 =?utf-8?B?Zjd4UE53SUp5azIwZHRLQ0FNM1NFUVBHbTArZzhxcjlvTk1EUXloTWtaSnpN?=
 =?utf-8?B?eU5mQUVvbW1xdlJsRDBmWHlrYjZ0S0hDVE00NlA0aVBWL09uVUNPYkZBaDls?=
 =?utf-8?B?emh2TFl3aWUzNmdUcjFpVm45OEpxN0RnUDNsOXRTUkhGVm9OU05VSTlBSnFK?=
 =?utf-8?B?VitFdFAvMjF3MXRGTWNaZDY0QnA5SkxDMCt2YzJGbkU1eS9XVHBuNEZlLzBp?=
 =?utf-8?B?cW96d0FzQU5ab3BoZThaQjhqdHBUSHQrWmkwcE9qTDhtNGFQQnNzVXNrclgx?=
 =?utf-8?B?ZmhaQnN3Y1pXdXBEL0pWZ080ckd5eDRZZUVwVG9BNlptNTdXMEYxb1lPMTRS?=
 =?utf-8?B?dzlvU2p1NkVkR3NrY083cXp2OWNoRXJBZVJpUTZoWjZMQXhDellRcS80YjBs?=
 =?utf-8?B?eC84RVN6YUFmQWw5ZTJyTXFUdkltN3U0Q0VzVlFZTU1HWENoRXdpSyt4cGs4?=
 =?utf-8?B?NTVpSzJSMlVBVk1WSWVyTnZTMVdIblE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmVTQ2RYWThUaUxhelAwZFFxMzZBMm12bGloM3ZrUy9yT3hjaWpnZlN1cHhX?=
 =?utf-8?B?emNvc1JWL0JmTzNHZVMzZTZzUE1hcVF1UUJJanlsdUs3ZTZCNlN0VnVwSlA1?=
 =?utf-8?B?QnlCT1hENXFyVzN6dW8vb3ltbUdqdFlKUSsrTmc0WHIzV3AzdWJZanNLQml3?=
 =?utf-8?B?QVBHU09hWDQwdC9oMi9FNkFEWkMrMDVmS1JSZHZCOTlXbm1XN04yUHpRZE45?=
 =?utf-8?B?SDdsVUtyWWxYZWx1aXpXQmtMam5KSzR1eTJMOHp3SEFkYkhZWEhSakMwbnAz?=
 =?utf-8?B?NXRjUmZ1T0JzR1lRbGhHR3JJdjhiTnVTbGkrcHBSbjE3NlR3NG92ZkdLMHhs?=
 =?utf-8?B?T0lrbVQ3aWpmK2RlM2pxY2lYWFR5YTZDNzVVMjFZTjNkelE1aVdWeHNHSTRr?=
 =?utf-8?B?NG5PeFFXdEZRb3BEckFCeWxFWXE1Y2hWZ0Q5anNWZ3VVb3NWUmtva0g2citp?=
 =?utf-8?B?NFVQMm9sRXBFRmxmRkp4Q2M2SFVvZ2krRHRDSVM2ZUxlYTlyU2JCYUdwWWFX?=
 =?utf-8?B?c1dJeXQzNHd0UXJWakxSejErYkovRmFPSE1GRWNQZlNyOFF1Q1hMTTQvdE9M?=
 =?utf-8?B?Y2dVT3FFdldONVEzV3BHTjBIbDRReGZnSUhsYS80eGRjQ20yME5xYko2ZmRY?=
 =?utf-8?B?cVJLS0p6N2pxYTM3ZG82S0RlblZtQUo3NlBRdVZta3UwK28zelBUMUFGU1gz?=
 =?utf-8?B?NEkvU1ZaNllzdGZGQkRtYkxkdkUxZlRQczZSYTJpQmE0SzdlWXB4aWd6RmR5?=
 =?utf-8?B?amN6cVM1RmM1aDl5TjdCQTVDSnhTclBrNXZXN2dCSHpSRzFLU01CYmJyYjlL?=
 =?utf-8?B?dkZBQ2xoc2NpTmJaeXJqYUk0akFyaFBiblc1QjlsL1BLS2hIQjQ0VmRZOU54?=
 =?utf-8?B?UEFOMG1sOTlORVFoL1NsZjBrdWt2ak42VnI4KzdQN2tER2dCQ3VILzMyYXVs?=
 =?utf-8?B?YlNoUkVQMmFUZXR5ek1pL3NuTDVJY2VoSG1RK1Z0a2RTZW00bmFwbkJtdnhh?=
 =?utf-8?B?T0pGMVZCSlo2SUVnQzFheUY0Rk0zdlpqRFpSNkNEb3o2WWFXc2ZaeVBZdGNQ?=
 =?utf-8?B?aHBObzhiYW1UOEFMMmZPczNmaWVLWUhTMUV4ODVrNEJlTHlyb3BGTU1md1Fr?=
 =?utf-8?B?eGtZQURxNGZzZ1pwU0pTYTM3UGlKYXpybkxWQWVrSktLMlV2N2l1K3lQcHVE?=
 =?utf-8?B?bytZSVluZVlSWmttYmQzbXNvcjhvM3MvNEhINTVVYWtZQ3d3dHVQMVdHaEUz?=
 =?utf-8?B?YVB6aUFSYi8yM0ZCM0tqRUlIdFJNMjNNNkdvNE5zTzFzSndFaDNOaWpWdlhy?=
 =?utf-8?B?SU42eWgxUlFVc1A5YzRKbEU2V0ZTNTZzbTQ2bXAyM1NvRmpIc2ZraS9hby9p?=
 =?utf-8?B?aU1ldFFhLzIvZGUwY2lIdGR5bnRRZDRHU2hCVUd6UWx0djhVL1dJMjJ3blVB?=
 =?utf-8?B?T2NaVHlNWGhJWjNnblJQZ1NTNjhzN0RrMVU1bDExYWcwcHk0MVRKVnZUQnpu?=
 =?utf-8?B?YmtseU1DZjdQeUp2VlE2OUYvWHhJZGs2V2VXTzQyeEgzU3FzVmRzaDl4QTN5?=
 =?utf-8?B?OGFhYTZhU1ZGK0ZmdURZcWc4dHVycS9JMERsWGxzWEZaR3JsMkFRdmZhK2hj?=
 =?utf-8?B?dlRJUUdRZ2pHSlhIVGRrenIyaFRCTGJsc2ZWSThEbU8zSHJ6VHN5NHVTelhi?=
 =?utf-8?B?dk83NnFRK0ZGc1l4bmljTGJkR1dyd0ZrZUFGY1lpMHBkWU5Zc0FGQWdWYWdX?=
 =?utf-8?Q?od1eJ1BwJriyyQhtCcr/IaSaFND8vSP5TslQQZd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553b97ac-95fb-4bb1-f948-08dd5d437da5
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:44:21.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7684


On 2025/3/7 9:06, Inochi Amaoto wrote:
> Add support for Sophgo SG2044 MSI interrupt controller.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>   drivers/irqchip/irq-sg2042-msi.c | 124 +++++++++++++++++++++++++------
>   1 file changed, 103 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
> index ee682e87eb8b..183002efd86c 100644
> --- a/drivers/irqchip/irq-sg2042-msi.c
> +++ b/drivers/irqchip/irq-sg2042-msi.c
> @@ -19,21 +19,36 @@
>   
>   #include "irq-msi-lib.h"
>   
> -#define SG2042_MAX_MSI_VECTOR	32
> +struct sg2042_msi_chip_info {
> +	const struct irq_chip		*irqchip;
> +	const struct msi_parent_ops	*parent_ops;
> +};
> +

For this new structure type, recommend to name it as "sg204x_msi_chip_info".

Others LGTM.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

> +/**
> + * struct sg204x_msi_chipdata - chip data for the SG204x MSI IRQ controller
> + * @reg_clr:		clear reg, see TRM, 10.1.33, GP_INTR0_CLR
> + * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
> + * @irq_first:		First vectors number that MSIs starts
> + * @num_irqs:		Number of vectors for MSIs
> + * @msi_map:		mapping for allocated MSI vectors.
> + * @msi_map_lock:	Lock for msi_map
> + * @chip_info:		chip specific infomations
> + */
> +struct sg204x_msi_chipdata {
> +	void __iomem				*reg_clr;
>   
> -struct sg2042_msi_chipdata {
> -	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
> +	phys_addr_t				doorbell_addr;
>   
> -	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
> +	u32					irq_first;
> +	u32					num_irqs;
>   
> -	u32		irq_first;	// The vector number that MSIs starts
> -	u32		num_irqs;	// The number of vectors for MSIs
> +	unsigned long				*msi_map;
> +	struct mutex				msi_map_lock;
>   
> -	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
> -	struct mutex	msi_map_lock;	// lock for msi_map
> +	const struct sg2042_msi_chip_info	*chip_info;
>   };
>   
> -static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
> +static int sg2042_msi_allocate_hwirq(struct sg204x_msi_chipdata *data, int num_req)
>   {
>   	int first;
>   
> @@ -43,7 +58,7 @@ static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_r
>   	return first >= 0 ? first : -ENOSPC;
>   }
>   
> -static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, int num_req)
> +static void sg2042_msi_free_hwirq(struct sg204x_msi_chipdata *data, int hwirq, int num_req)
>   {
>   	guard(mutex)(&data->msi_map_lock);
>   	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
> @@ -51,7 +66,7 @@ static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, i
>   
>   static void sg2042_msi_irq_ack(struct irq_data *d)
>   {
> -	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
> +	struct sg204x_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
>   	int bit_off = d->hwirq;
>   
>   	writel(1 << bit_off, data->reg_clr);
> @@ -61,7 +76,7 @@ static void sg2042_msi_irq_ack(struct irq_data *d)
>   
>   static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>   {
> -	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
>   
>   	msg->address_hi = upper_32_bits(data->doorbell_addr);
>   	msg->address_lo = lower_32_bits(data->doorbell_addr);
> @@ -79,9 +94,38 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
>   	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
>   };
>   
> +static void sg2044_msi_irq_ack(struct irq_data *d)
> +{
> +	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +
> +	writel(0, (unsigned int *)data->reg_clr + d->hwirq);
> +	irq_chip_ack_parent(d);
> +}
> +
> +static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +	phys_addr_t doorbell = data->doorbell_addr +  4 * (d->hwirq / 32);
> +
> +	msg->address_lo = lower_32_bits(doorbell);
> +	msg->address_hi = upper_32_bits(doorbell);
> +	msg->data = d->hwirq % 32;
> +}
> +
> +static struct irq_chip sg2044_msi_middle_irq_chip = {
> +	.name			= "SG2044 MSI",
> +	.irq_ack		= sg2044_msi_irq_ack,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +#endif
> +	.irq_compose_msi_msg	= sg2044_msi_irq_compose_msi_msg,
> +};
> +
>   static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
>   {
> -	struct sg2042_msi_chipdata *data = domain->host_data;
> +	struct sg204x_msi_chipdata *data = domain->host_data;
>   	struct irq_fwspec fwspec;
>   	struct irq_data *d;
>   	int ret;
> @@ -102,7 +146,7 @@ static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned in
>   static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
>   					  unsigned int nr_irqs, void *args)
>   {
> -	struct sg2042_msi_chipdata *data = domain->host_data;
> +	struct sg204x_msi_chipdata *data = domain->host_data;
>   	int hwirq, err, i;
>   
>   	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
> @@ -115,7 +159,7 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned in
>   			goto err_hwirq;
>   
>   		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> -					      &sg2042_msi_middle_irq_chip, data);
> +					      data->chip_info->irqchip, data);
>   	}
>   
>   	return 0;
> @@ -131,7 +175,7 @@ static void sg2042_msi_middle_domain_free(struct irq_domain *domain, unsigned in
>   					  unsigned int nr_irqs)
>   {
>   	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> +	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
>   
>   	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>   	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
> @@ -157,7 +201,22 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
>   	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
>   };
>   
> -static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
> +#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> +				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +
> +#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
> +				    MSI_FLAG_PCI_MSIX)
> +
> +static const struct msi_parent_ops sg2044_msi_parent_ops = {
> +	.required_flags		= SG2044_MSI_FLAGS_REQUIRED,
> +	.supported_flags	= SG2044_MSI_FLAGS_SUPPORTED,
> +	.bus_select_mask	= MATCH_PCI_MSI,
> +	.bus_select_token	= DOMAIN_BUS_NEXUS,
> +	.prefix			= "SG2044-",
> +	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
> +};
> +
> +static int sg2042_msi_init_domains(struct sg204x_msi_chipdata *data,
>   				   struct irq_domain *plic_domain, struct device *dev)
>   {
>   	struct fwnode_handle *fwnode = dev_fwnode(dev);
> @@ -173,7 +232,7 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
>   	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
>   
>   	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> -	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
> +	middle_domain->msi_parent_ops = data->chip_info->parent_ops;
>   
>   	return 0;
>   }
> @@ -181,16 +240,22 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
>   static int sg2042_msi_probe(struct platform_device *pdev)
>   {
>   	struct fwnode_reference_args args = { };
> -	struct sg2042_msi_chipdata *data;
> +	struct sg204x_msi_chipdata *data;
>   	struct device *dev = &pdev->dev;
>   	struct irq_domain *plic_domain;
>   	struct resource *res;
>   	int ret;
>   
> -	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(struct sg204x_msi_chipdata), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> +	data->chip_info = device_get_match_data(&pdev->dev);
> +	if (!data->chip_info) {
> +		dev_err(&pdev->dev, "Failed to get irqchip\n");
> +		return -EINVAL;
> +	}
> +
>   	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
>   	if (IS_ERR(data->reg_clr)) {
>   		dev_err(dev, "Failed to map clear register\n");
> @@ -231,11 +296,28 @@ static int sg2042_msi_probe(struct platform_device *pdev)
>   
>   	mutex_init(&data->msi_map_lock);
>   
> +	data->msi_map = devm_bitmap_zalloc(&pdev->dev, data->num_irqs, GFP_KERNEL);
> +	if (!data->msi_map) {
> +		dev_err(&pdev->dev, "Unable to allocate msi mapping\n");
> +		return -ENOMEM;
> +	}
> +
>   	return sg2042_msi_init_domains(data, plic_domain, dev);
>   }
>   
> +static const struct sg2042_msi_chip_info sg2042_of_data = {
> +	.irqchip	= &sg2042_msi_middle_irq_chip,
> +	.parent_ops	= &sg2042_msi_parent_ops,
> +};
> +
> +static const struct sg2042_msi_chip_info sg2044_of_data = {
> +	.irqchip	= &sg2044_msi_middle_irq_chip,
> +	.parent_ops	= &sg2044_msi_parent_ops,
> +};
> +
>   static const struct of_device_id sg2042_msi_of_match[] = {
> -	{ .compatible	= "sophgo,sg2042-msi" },
> +	{ .compatible	= "sophgo,sg2042-msi", .data	= &sg2042_of_data },
> +	{ .compatible	= "sophgo,sg2044-msi", .data	= &sg2044_of_data },
>   	{ }
>   };
>   


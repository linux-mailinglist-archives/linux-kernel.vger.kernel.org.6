Return-Path: <linux-kernel+bounces-256187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50372934A65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1254B23FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63812C478;
	Thu, 18 Jul 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y8ObGMNl"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2068.outbound.protection.outlook.com [40.92.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D480028;
	Thu, 18 Jul 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292509; cv=fail; b=QilvoR0E4hGZZloqW57Vy6e8tM1bTr9qHiOh2SpEKLYfQ8MAQZsCz/I3iTSc7xJYuALFTS19MrhkzB2E8zy6KQ2ynrGOWTKsqgrZZXp9zMLjYKKFLeREA1paOgxCHhTmjntKh85IYHcwHilA/9Peva/8u/ztFJIvNkvJK7D29Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292509; c=relaxed/simple;
	bh=kwtDF/g66S+e/6mD8Cqmufm4mxVO6FagL+8Wwdp6ib0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T78srLhEWyBgaY9vJrmPBulrkUFvEQfDxI2CS+MDnBe8VMCpE6o6WlhGXfhE2eoVSiDgvu7xFarmy0rROkFZSXA46pFhn0h7clBjzSni63iU0eu7Ke0zK1CUlrldJUkkPdwrENtEu8+yYQkaOuuOSyocWbDl5X47JQA2vswV8NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y8ObGMNl; arc=fail smtp.client-ip=40.92.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3FKEPxxC1Q8y6+pE7iE/J1fFTzf9339GpIApGD7W0oyygOU8oABaGvPD9vWdNQVy/HUwBi23b+cr3ktCNdRiGDiDc0Ei/SbwsyXyHgF8heb4w5bY3JT+HUCAIoXruEIVC1TTcoerm/K3TgeSY84FYs2G2f+gOArNpITmQN7qiR2phtfvkDYEZlJdt4vTrE2+FcqWVnDEpgbZkiV0ib9kwjML8RFoUcv2szRzO9X5YZWZiGoSfnTjRT4TKnTvTN3Cq/iOXTpOF+SIk9xXOyLl7YntDE2oOur4kuH5nsmZZtxuGwjQoDt3CZseU0shHrh1VBpdtxOVQzXqwYm6KGhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WITdROI8ebkmF4dGVy4gwwxUmWcYjRvIHJAew95TJSc=;
 b=FlHAUkyTnJ1ElxDc1NbhQs3G3qEH8QvGRUk+YmD+vmEgCWBbNfgOQU7gSm+j5cN2BCKgX+DJJo0ErtKphSLLmgMCbcPIJHirQtcPj+kRmt9dpTVm8o7BTSrx2Kv5nyiVliNbJCcqKM2K+EehHFIVAnZsaXOFlquH7+HHASXNGpdYvydIog0Q41EZIoQSja5qhVH5bsYXcQkSC7z8exVzrILBYlgeakvvz4cbLVwb6seq3PRHxC248dm/5/XCgAKep0CA0uMv0fS5h/0HU5C2kxAiacrLQ65WuNcMbYAFfvRWxsA0Ucw7Rs8ob3HijwRxtZMZDChqJS31hc/qd4iVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WITdROI8ebkmF4dGVy4gwwxUmWcYjRvIHJAew95TJSc=;
 b=Y8ObGMNlMIqd7ygm0Evc+xHJkPVJs2k8Wrl+UXMyCsWpSIDCle4rdyTvo1qcWbGtc3P5ynp/6r9c80zqIlmu4oaahEPk4jYZYk1B0KmicRI0E1uCv73xZV3yNhsTw6GrBPUlwTNHWftZRMYB05czVTGYUZ9NdDRBgYbUkNAwyDtl6l8Z8Lix97BQ1fU1AEWLWtMorVd7SeCM7f0bmKVX74zcSWGr24CeN79crqLPbk24V6zlVWsuecMR6+TkmfoeZXFQu3rts7BO4oLadjkavdPsh6nOdTiebnnya7/Tb6p5wqdY+XydnhbeAj2hIUEtQjfqzOUsEpPIzCXRpKEC4A==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1553.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:180::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 08:48:21 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 08:48:21 +0000
Message-ID:
 <MA0P287MB2822E6317E7167B69BCD75EFFEAC2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 18 Jul 2024 16:48:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: sophgo: clk-sg2042-pll: Fix uninitialized variable
 in debug output
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <baf0a490-d5ba-4528-90ba-80399684692d@stanley.mountain>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <baf0a490-d5ba-4528-90ba-80399684692d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [D5c9CCdoVTmZ676xbgBOks07gPfsjmK9]
X-ClientProxiedBy: TY2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:404:a6::34) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <f7dd655a-216b-4170-920c-0110616fe81b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1553:EE_
X-MS-Office365-Filtering-Correlation-Id: ee50e31a-a222-4a47-ed82-08dca7065fe6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	q9q30iUO7YubKE9VCM2TMVDjWqAAh/RNrk7MEz1CTix6K1vltwOmgNe1oY/qLstgneceLaRgbhIbed5vjjgZqgCzo4JIzYCL3liEd3TZneeL28LA1L5eUlZsOXpnNC9uCw1IYpk1aaAAYvd7DAfFoUtVB0V3jUAEX+JdKxlo7b1dh+U7f73dVmpcLG0EPNL+vxXeRze9GeBPeFRrgHyYO7/JvY6qrYNJxfV6hd3OoYEo0XlK1DBHJxV8HI7FocnQgjqFt1d8QL/wphNOOxF3uje/EQYBkdWuZ7Xq2PZZOS1Ge69LbER91ALHSsMw51o91G+7a6ZRDZy8ZQEP+6oThGrF7UWLbd+ftZYFUKCqRjVYNBr2B9lYUZUq+pNJEH7rZi+J7PeA638vu87mZSwDZCi5nDaH/OFEyBSuQYLtLd54jvF6NKaHtK9KwBoVstdfanjDIEHHoLTfcEW3HUavtU1SXe7m/3/uiDQU1UKw5MZfQ9Sgaqxq6ceMM5Uxx30JSwzd3NjBLLbxkxOCJ0nmof9XcWlKoNmILLGZcqx6IJD8CJJYT10CLFbU9iacHJBcflV6LraSJPnREoR62+glzhiYQaLcV0IIBfJdX/4eTA1TYB9FBFkEjg88YagcBG/lYgSUG3EHvZT91EQRMIi96A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhPYXN6cmVvRVZHa2xuV2VrVkFIT0dzdUlta08wakFnWjAxME5mbEF5Y0g0?=
 =?utf-8?B?RGdhOFVVemx3bTFFcXJoaWZsaXdOcWNXUndhaDFhN21YZE41b3ozMDNHellk?=
 =?utf-8?B?aXoxTmxDb2JWUlA0NXNDd0ttUllWaGJwdmp4L1VCMUM2dUpqN0swRk1VdU16?=
 =?utf-8?B?cmNvQmR2MjdBZk9KazRmU1hvM01yVndmaXZhUUFtRm5CUDcvNVV1Z3NSQzhQ?=
 =?utf-8?B?ZGh3TllSRzVuMzVNS2tOaFF2Z1Bzcmg0bFZYNEdwTkMyZmFtcnU4My9ZL21O?=
 =?utf-8?B?YllHOUpieHZYdWRDZExyWEcyUlZFNEJvRVYyQ1ViOVNzbm9Tc1BrZFNZMmlk?=
 =?utf-8?B?K2RuWVRIZ1lNUlRoMkthcE8ybUdFMVVrSDZVU1lPRXZadmVWNm92MmhiL3Bu?=
 =?utf-8?B?N1dsa3Y4OTM3MGdvY0p0c3owSldzWTBUU3FrNjdhaUs5QUVBanVpV2NiUHV2?=
 =?utf-8?B?WnM0YS9xZURlOFNHZGdOak5RVzNvNk5OeHpvcWpYQVJ5OC9qVzh5ODB6UDZD?=
 =?utf-8?B?WE9uWGZnMVNPR1g2cmxKTlV5SmxHTTJQSDdSZjBGT0pYa3hRa0VHazhjV1VL?=
 =?utf-8?B?TEplYTU0U0RwWC9GSUx6YjBTMWNiOTA1N3dxR0ZORFArb1pHM3BPeHphYXBQ?=
 =?utf-8?B?S1BrcGFnTWJ5UU1FZmpnNTJIdlFYNDI3OGhzU0ZBOGFYTFVvTkE2SXhWdTRl?=
 =?utf-8?B?UGpIdm5pejh1UTgvWTRMcXl4UU54bVRydU1PY2ZXTG83VkhzOFhJa3AraE1Y?=
 =?utf-8?B?cTlEaklPT0VpREY0WDZ6NTdBQU9RbFY4RDNQeGxaNW5yZGhsVUdFeGF5ckxB?=
 =?utf-8?B?T01HQ2VGendlckk0QzF3TGV2dGUyQUJzYUZZeWhwTDdCaDFrc044NzhUdG50?=
 =?utf-8?B?ZXNRZWQ4WEJjRkU2NTVIcG9sSzllam5RS01qWnloc2pFbUUxQ3BoMFZGcTJ6?=
 =?utf-8?B?SWVSZlVFWkExZXBnM3JwTEdXUGpnUGZKT0lRbkk2cGZRYXZxdWlFaEtSU0dm?=
 =?utf-8?B?UEUxT1hMRjJVWTBhV0hLaGFoYitTckRpK1VLRTI0UW1XTjdqY1dvdnFIbklP?=
 =?utf-8?B?MmdYY21Ea2dMMFJJektETW9JeDJsUzdmNUxVYUZqblZ6OTFZNkFxdnNsZTcx?=
 =?utf-8?B?cDJhNHhOdldzMGtUWElHbWlJYXUyekRVdlVQa2o2UDdKVWU0dXNtOEwyWDhH?=
 =?utf-8?B?dERKb1RSTnl1T2h6QnJEakNsQ3dHRUpBeFZ0MlBpQld0ZzhpY1JqT2VaSHlU?=
 =?utf-8?B?bmlBUVJWR0dLQzM1b1FYMXhsTEtpQkNNbnJXWXl4U2pnYWlXR3RtT1NwaFE5?=
 =?utf-8?B?bWVSMTYvbzE3azB3MGhoV1laTHI4ZXBaRXRvNktHTGJ0U05xdjR1V2JSRnhi?=
 =?utf-8?B?cHpWMFdsSU84TzV6TEh6Tm95elJyNndqeGo0UWF5VUJFUzc1RWZtdUhWQUZk?=
 =?utf-8?B?dVJhdDhXUmpHQmxkaTFjRk9yWkxLS0lDOEtBVFhMalpUNjIrMkVyVlJDK0dh?=
 =?utf-8?B?SWZJSmlUMjduUEYwcC9nUWFBcnUrNEN5YWNHYXRVS3ZmVktRZUFNODB3MU9M?=
 =?utf-8?B?RWlCYURMTjJET044NEgyOFJ0dWFCT2JkdkJRM05GQnJXYUdhOGlwaGx5ZHFw?=
 =?utf-8?B?NCtRL0E0UEQyYnEzdTZkNVNZaFRiVDI5WmZNMHpSRWZBZmExelFJYW1YV0ky?=
 =?utf-8?Q?TFzw/TFNVp6F1Al+JMxi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee50e31a-a222-4a47-ed82-08dca7065fe6
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 08:48:21.5369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1553


On 2024/7/18 10:25, Dan Carpenter wrote:
> If sg2042_get_pll_ctl_setting() fails then "value" isn't initialized and
> it is printed in the debug output.  Initialize it to zero.
>
> Fixes: 48cf7e01386e ("clk: sophgo: Add SG2042 clock driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/clk/sophgo/clk-sg2042-pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sophgo/clk-sg2042-pll.c b/drivers/clk/sophgo/clk-sg2042-pll.c
> index aa142897aa5e..24b0eab6154b 100644
> --- a/drivers/clk/sophgo/clk-sg2042-pll.c
> +++ b/drivers/clk/sophgo/clk-sg2042-pll.c
> @@ -387,7 +387,7 @@ static int sg2042_clk_pll_set_rate(struct clk_hw *hw,
>   	struct sg2042_pll_clock *pll = to_sg2042_pll_clk(hw);
>   	struct sg2042_pll_ctrl pctrl_table;
>   	unsigned long flags;
> -	u32 value;
> +	u32 value = 0;
>   	int ret;
>   
>   	spin_lock_irqsave(pll->lock, flags);

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thank you Dan.

Regards,

Chen



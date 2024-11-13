Return-Path: <linux-kernel+bounces-408440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBC9C7EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A8281554
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81C18D621;
	Wed, 13 Nov 2024 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LilRTAyl"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010006.outbound.protection.outlook.com [52.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF818C330;
	Wed, 13 Nov 2024 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541470; cv=fail; b=PYqMlxsce15JQd+iBNRPlGa8s84c2VLOESK7tyrk6ekwm8g6Tk88zGEgA4F2CR1RKBsZgplAridXW2+eEf0QMDKIhZu78yyhWJ0LSSVvw1NKFC2dSZ9ePD3FeQZNPxobQ48VVsjbDWic4Hwts1YIW979+8Wbtd/JO41zy8Dqk7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541470; c=relaxed/simple;
	bh=chhXj1FnQl2H094l+5+tiydX9htFPjl9NBIPqBlD2F8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PVMcoKxVU1t/nHxyS4t2yx0tmlUPng3WP/gmUFYoaVCWuLZmeuB0lPDbphcOxC1eCAtVaB71775wMlfEMrElc/b3E7nBX4sWyda4K1ZBAKk0asAw9JRIGdybRJaRY6qGOCmDkfSAJUJK32dhGJOFevdYuILaoImlrgqT/O/qN3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LilRTAyl; arc=fail smtp.client-ip=52.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La4T8kpFbcrm11FOD2flOFGxWny+487suZgiJN/dYlxA+/xbzxibooKhW7OSOV8TphVjv7SOWTBJlYjd9tAX2LwRGuGlImJcqF47k840M7WKkgvPDlhz/DSCkLoJfLe/OZYPqBGeOUDKV5jJC3InPQz3Gj8Pn4KDFU4tC7/pnyK1Gwx1pDQtcz1ayDVHBSUQAGvCN/GFQDi0CaO7XtYzQUhcyeHmNypIYZj1yqhYatcvwOWxb6csF/6vuLQyPaFL3KJEJh85df0zR5G0mKd0m2WKfG0dnppy+E8ugTJ5XjIK+P2W5aRl1fPu6/YJbAmc9oBwhfcx2xl+QW2EJFIqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUFRHpVvu7TSrVQyK0i6vGybxXyl67FNTYhf5kGbXU4=;
 b=F9gpdS0QI2zdqBRdn6xeMJq0xrnXCKdVvjjruTP64BqLLeiHZFvOc9HjyPYhbjxX6EPXy13BhRo1H/5hrhpmEtBTq2x6uUC12HNkKcajXm5Zu7LfbhFhheZq9pPmHJIKBYSzV1oTcxC8fCnaZ973Pgjw2yJ+in+kBu06OVjip5BC6nv9E9XdfXRAR0SShQQj0F9D+xDogXGBC8sknATpBeVffSFRE3g1x0hev7eb33/0/VM+yDjkAnS2A2uyH7rkaYbtA8Etg6fxSaa3PTQhaFG2JsGMRNHyYbstTyV0HiAOnkU1wRjUQmm9eFAjwY0AnzbG4THCkt+7V336fSc/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUFRHpVvu7TSrVQyK0i6vGybxXyl67FNTYhf5kGbXU4=;
 b=LilRTAyll26cuwCw+VmE2E16Q0HAqH+tXnRfEkJUeWw8TrIq1Cm+XTITWHwjdY77AAndOdabFKZ6ZCQCmLrGgaGivEX2z0Zeu8jJwQtUeCVtur00MEyc/Kj01TPX9IY4qyjf/hoBdlp9luUAH+DfIs6pXTre8p4pbE8oskkTu0VxHPbsK+42C4oO78zJ0PD4cpKeIzwWlK5ogkFLwBpEsJkoDSPHh0Z2uDJcnUu17Zgaap+Kp9Mkpg7uJawgX0jRmJ2xhh3Tg+IDB/YbPXUm9TPE0Z/kh4sl3Reg4bNVLv4clQeoK8ggHUI6A5GcBCVqiTq8YYqZ7B6SxTwY9OfW/Q==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1477.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 23:44:24 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 23:44:24 +0000
Message-ID:
 <MA0P287MB28229437858DBCD00CB05757FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 14 Nov 2024 07:44:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk:sophgo: Remove uninitialized variable for CV1800 PLL
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113184617.3745423-1-ragavendra.bn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241113184617.3745423-1-ragavendra.bn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0174.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <4bad9389-528e-423c-81d9-6917ff1b3985@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1477:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eea3fd5-db28-4e48-e0d9-08dd043d1a8b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|6090799003|19110799003|5072599009|7092599003|15080799006|440099028|3412199025|4302099013|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3pRU2JRY2g5OVVsZjhCdTR0cUd3WWNEWlNlQVllSHd4VFpTdGNYVDdYQnNC?=
 =?utf-8?B?Wm1FN3J4VW84cTdaakhkbkNDZ3cwa1dzT05LbW5QOWoybHpnZXg4ZEsrd1Fk?=
 =?utf-8?B?aWdyN1RUdDZyTG90NTdpZ1pEOVplWUFQNlI0Y3FONFRrWDJIbkYzR2I4cDBS?=
 =?utf-8?B?akV0Rkg5L3pzRTk2bkVTaWo0d1AyeWtKZkEwd0dNRU56T1dheGxaaDF3OHdq?=
 =?utf-8?B?TDYvVXpkRFpQN0Z3M3A3R09SOVowQ1FiYlQreDdWam00ZWZZS1lsN3NYaWVy?=
 =?utf-8?B?QmdOQWxNa1BGMXpTOFJFRk9HM1Nob081dU1ObmxqWkFETmRwMEtmdGVKN0Zq?=
 =?utf-8?B?c1J5Mk1sYWxXVi9FdFdnYzBVemxub2haZGttTWd2SUxCRnQ3L0lJVk12VEN2?=
 =?utf-8?B?S3ArN2o3UlZ0TnB3cVhBbllWUEIwbW0wWGowUUN5Z3JiU3ZnNzRKeXdtc2Ns?=
 =?utf-8?B?L0Q3MGdDU3FyTTZFWlV5WU5Tc0JqQUZJektDTHZybXU3Qkx3SXJwQktEb3cw?=
 =?utf-8?B?dmhFSklhZlc2Qjk4Q0dGdmo4LzAxandIZ1YrWGJiTlRVZjVPVVNkWTNCaGZM?=
 =?utf-8?B?cUs2NmwzampJaHpNZU9JM1BMbTBrTTRNNUNacEJPYU1FeWVYMmQyaUJ2T1h1?=
 =?utf-8?B?amR4dHBLRGlxTG5nRmFBQVlQMHB0aWU4ZThaTkk5MEw0ZGwzdTlKVEM0MFEz?=
 =?utf-8?B?Y3dXUjI2TlUzVlVpemRBT2ZxY2IzNlhGT0JQZG5yRy9NLzBYc05OMStHMXRT?=
 =?utf-8?B?dnpROXRWeldmUjFvUWRDclkzdDk0V3UrS1NVSlY2TGl1dCtDMGROaUxvYVcr?=
 =?utf-8?B?NHhEWTJNRFFCUjN0MHhpV2NPVEF4N1FZbklsZUZvQ2Mzb2JIRFhValoyMUNM?=
 =?utf-8?B?QUlOWE5PdlFZbVdJRFZlSnl2NEc0NXZPdTRhRC9vVEZ6SDBtZ1FrTzV1TmlL?=
 =?utf-8?B?YVluQ0hxMHhiQzJPcGgwQndoSTVJVEN1Q2t1TGd2MGFwVnNmNTkySEl3NWY4?=
 =?utf-8?B?QzBYaFlOUVNTa1lqNjYrSFVJWUhtbmpaWDVWWENIdXFVd3cvQW9nYjNrWmFM?=
 =?utf-8?B?MW1IaGEweEQ4djFQc0VhU0xSNVg2eVRVbVZGQnc0N1p3NEgycmh0UnRUTDg0?=
 =?utf-8?B?cWw4RHNtUENVaVFiT0F1aFQxRGVtZXRFbmsrL0NtR1UzZ1Z2UEN0UHo5NUZR?=
 =?utf-8?B?SXdDZzVjNjl0TjA4VUhQMHlGZHdldUQyVG9pK1J1ODJBdGZxWjFXdnVpVkdI?=
 =?utf-8?B?ZlRmd29iNDdyMGZtZ3ZXV2tHeUYwQ2ZvL20vekpEeW02QkRHb0hWMGNKeEVm?=
 =?utf-8?B?T0dqQTluVmZKOGZDTVJsWXhLMkViRVNCSWhrRzBxWHpHR29XaG1jeENkZXg3?=
 =?utf-8?B?U0xEL1pyZDgxdDY4NStEdC8yQ3k1SC8yUEMvcTVsQVdzZHZZdzVLMGJmNXJM?=
 =?utf-8?B?b3lGOGlhL1hNUU45WnNXYjR0YUhHOU5rUzVqYnV3UjBHU3k1b00yZ0poclAv?=
 =?utf-8?B?aERVWlNxRlVrY3RFTWtCdm9DNlBQWUY3N01ZRTJWTXVWMnNLdG1OZUFsVm96?=
 =?utf-8?Q?sC4KmxRj+M3/Y9ZCk2UNzGZM8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWMvSGhBdEN2bVJCWHJiS1BaL2o3YTJJMTIrcld0RmEvNGM5R25Xc0c2Z1Jk?=
 =?utf-8?B?cDhUSlN6UTFMeFFZb3ZzcmhiYjhTNTBEM3o1K2lFeHhQLzBreWtkN3RhTDhY?=
 =?utf-8?B?L1UraEE0TnQ2d01iWkQ1MUNOdE1xU2N4OVJlRHZFUXZwZTBiYytqUjhLb3da?=
 =?utf-8?B?M2MzTUlIa0x3ZDBGSzg0NUYvanUxMFg0RUJlcUFNN0tyK0tjbGtDVGFlQzQ1?=
 =?utf-8?B?dnBmem5qM1IwaDZNVXpxTHZNUTU5QWVEQ2tFUUplc0pNU1R2b1o1U0E0RjBs?=
 =?utf-8?B?MklLS0Zuc1ZIaUlDT1l6WjU3MitVUExDMER1UG9Tbm15eG1zU0IwSmJzZTJU?=
 =?utf-8?B?RXdqeU9COWJ1QmR5UGlseERVdkhkKzNZYWI0NmFxWk9zVTlXR1JZRnhBK3pW?=
 =?utf-8?B?NlJSN0RWVFBBSllNKzdYbmVGSWhlTENMYStiZUsrZjRjR29DTHYxUjhWY0Fw?=
 =?utf-8?B?ZXd6b0RpaFBFRTd2VzBRUFovdXFMTmdQNHNBVksrSkp3dXFudTg2MjBtQmdw?=
 =?utf-8?B?YldlMlJYRmtBbllOenlabHF2TTFGM2orVSt2dmQrZVJkZ0YrWlJpclp5Q2NN?=
 =?utf-8?B?TDdoU1RuSGJMMTFVM3JMZFhjN3MxN0VDRmltd0h0Q0VwWERYaGo1NUtickx1?=
 =?utf-8?B?MkJMNFRVMXk0TTE3VDRsMFBmV3B4YkQ0bVJFUVNSR2g2QnBHS3lRd0tna2F3?=
 =?utf-8?B?WU1mdlBLTVE3M2NuYVQrN084a3BLbkkzMnJYNGdKN21naitlUkRLSis4TFdB?=
 =?utf-8?B?VGZFZnN1NnFkVHZ4RUFzWVZOV0VJOWUxK0JwMEQ5bExRb0hlbmp1Z3FqRlhC?=
 =?utf-8?B?WE0yU3hpNHNBdFd1cTMrZVYrVStRWUphYVhuRnVnR0c1U2JHSU95WjhnL0hM?=
 =?utf-8?B?RXBUR3VwTjc5ZDVFU1RVaXRWTzRhZlN1dGlVZWdRZ1d2WXAyNUN3aEwxZ2pK?=
 =?utf-8?B?VFV0YS9vSUdKTnZ5K0NHemRxOU9qbnl2cjY0L1dmTThEdk1TQ3c2Qlg0YVU2?=
 =?utf-8?B?U05iR3VCUTFVM1dHcUU4VURzSHBDbHd4ZE9VZHlSSWxUZ0tPRGFzckYwbWtY?=
 =?utf-8?B?ZW80bmtiUGlsUGs4VE42RCtxM3lzMTBWTVcvcndhU2FZb1V5cWFhajhHT3JU?=
 =?utf-8?B?cU11KzdnWUlGSWpQazd3czVwOGRHRzM5ZHBONy9DZFZ0dWVjUFlzTXdUcnJH?=
 =?utf-8?B?V3VTS3dSbHZJeW1kQjVsNGtyYjlZSHVwNGhxdE9zK2xtRnRrSGFwejdZa0Z2?=
 =?utf-8?B?MEszNEhxNXdsd3FZaElTTmNLcTNkNGZ2QWwzdGdlM0F1WE5FdXhNaFltK2pV?=
 =?utf-8?B?c1JQMmRWZGV4MVBpSENlUUszOXV4Rm9ia0pIOXordFBBRE84VkxydEgzcVpw?=
 =?utf-8?B?OEEvbXdqQkIxczVhT29aeVdFcVc3MWh4Yi9DQkprdmc4SXJCMXBFRkRTOFVr?=
 =?utf-8?B?aDQxUVdyc1RGaUJ1c0dCbStiZ1hDVGdpelRnV3JxRHVybTF3eW1LQmk5M0Q4?=
 =?utf-8?B?cGsrczVJT042SmY4dVdIVExzdGdYdURKcGJMWEJaV1dzR1FzZnBHRjk5cXlT?=
 =?utf-8?B?YkpxRjFhQ2kwNm1LVVRsdEp4bERCclhRVno4ZHl6Y2RCakxQWGhBTUtoMmFD?=
 =?utf-8?B?em5BZlNiSC9yUFJYR1ZELytYNVdJQ2FKdmIxZVV2aVoxcjl4Z2Q3NDZJL0Q4?=
 =?utf-8?Q?NmpqFMIjXRfB5E4mjuFX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eea3fd5-db28-4e48-e0d9-08dd043d1a8b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 23:44:24.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1477

Hi, Ragavendra,

This patch should be revision for another 
https://lore.kernel.org/linux-clk/20241113025947.3670504-1-ragavendra.bn@gmail.com, 
right? If so you need add version info in the patch title and changelogs 
etc. Please read 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format 
carefully and re-post the patch.

Kindly reminder, better declare dropping of this patch email and repost v2.

Thanks,

Chen

On 2024/11/14 2:46, Ragavendra wrote:
> Updating the detected value to 0 in the ipll_find_rate and removing it
> from the method parameters as it does not depend on external input.
> Updating the calls to ipll_find_rate as well and removing the u32 val
> variable from ipll_determine_rate.
>
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>   drivers/clk/sophgo/clk-cv18xx-pll.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> index 29e24098bf5f..350195d4ac46 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> @@ -45,14 +45,13 @@ static unsigned long ipll_recalc_rate(struct clk_hw *hw,
>   }
>   
>   static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
> -			  unsigned long prate, unsigned long *rate,
> -			  u32 *value)
> +			  unsigned long prate, unsigned long *rate)
>   {
>   	unsigned long best_rate = 0;
>   	unsigned long trate = *rate;
>   	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
>   	unsigned long pre, div, post;
> -	u32 detected = *value;
> +	u32 detected = 0;
>   	unsigned long tmp;
>   
>   	for_each_pll_limit_range(pre, &limit->pre_div) {
> @@ -77,7 +76,6 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
>   		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
>   		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
>   		detected = PLL_SET_DIV_SEL(detected, div_sel);
> -		*value = detected;
>   		*rate = best_rate;
>   		return 0;
>   	}
> @@ -87,11 +85,10 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
>   
>   static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>   {
> -	u32 val;
>   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>   
>   	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
> -			      &req->rate, &val);
> +			      &req->rate);
>   }
>   
>   static void pll_get_mode_ctrl(unsigned long div_sel,
> @@ -134,7 +131,7 @@ static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
>   	unsigned long flags;
>   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>   
> -	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
> +	ipll_find_rate(pll->pll_limit, parent_rate, &rate);
>   	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
>   			  ipll_check_mode_ctrl_restrict,
>   			  pll->pll_limit, &detected);


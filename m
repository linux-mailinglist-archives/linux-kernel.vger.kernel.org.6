Return-Path: <linux-kernel+bounces-406919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427239C6612
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61281F21A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B5A936;
	Wed, 13 Nov 2024 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WOFdqqwS"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3364430;
	Wed, 13 Nov 2024 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731458046; cv=fail; b=thLkOSMDskNutlAflMvssnvGLwTaDMY38p09H9Ja6z4CM75xlC5IyoGok8efYcyPKPVp1yufs6b2nCNMnwAdmDA+WgoMiinasOW9HYseuqGztSIpxBJhoWVt2eVla6P0tX9SfLKiTtVjB2GKVab2MMSkyZpvARi9CMU8Ei8Qe6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731458046; c=relaxed/simple;
	bh=dMP9gigajsqZ8cQa8SkOJghLyQmiv8KGWanT+puKaw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWfwrmg/VpeahI/dan7Vkf2Pn4dPvqzSiQ1X/IG26EWYe4htnWzDFQYEeemZPSTw5eexZAYun9Dub/YDISBqMyTNnWHvFkD43+t0Z3aEOtZqSDmFoN15AHlxCr491h3AycRmhl+nPDtL6AFDAWjcSC/jhjZAj3FP4nDFcHKf9ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WOFdqqwS; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHoNGkpNUukZ4vvd+VoNsSrhqAGAX1CseiTRbJdL0m24cke1eLoHZXLzMbrvpiGcwuy4+qTO8VmQu2QfWaOSz5bVJPlh2XDUlu6qfUnOvHN/Y3x/lZBVupV4LOtNbFef+RRELTxMuF4OTrac+TSo6QT2O+Wt3a5MTmmoXNKVR25I1idXRjM6v4HmB+rEZjtMPVbjloyrUagO6oqd7Ac/n2L1RQHUP4M51BunGlLlc6CRdTKexDEhMeo/iTSgT9Ay/UE0T0RHj6OHzLThxpKNiXZ8vZuKB6Pv6Al0RCNzYmxUQXPXfOCdXAnitVsQWJg3wqdAs2kB/gISaYa2h4WozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7S4gF+PHiiTv9XIyVOfGCba6QOianYlIQwqPJyjjcc=;
 b=OyxK0VGVyeYGlFWmsTfWFZ87Doj7FcpDcXfB2yRYXhiTESYJspQc5ADcp2Jknp7Irf5dt4oHY56EbRnNEJukNLg9Ct4u0FOWA6KitWvVratBanykMsoYCkcq7JRqeSd4it8cKcQqCK+MoIPYm9mVrGKgu8aI0B3cLriSWOMLg4BYZEhhfAkdL/8mxW6anNWpkWZ6S2tanb2ec7L+40e29PWUeH5Vy6zOkNkjY4WBKKXKi4PekmafsysAxrud95KqCaO7RZjJUKjYFBqyuDJC364Exo/FBlX/u90UCMpyCANJQRuNMXT8JFkCY4KZzmhugYgyf0Dvy7cYKpvyqLop1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7S4gF+PHiiTv9XIyVOfGCba6QOianYlIQwqPJyjjcc=;
 b=WOFdqqwSRxetIPvegJH0VYafzpHV6WBq/W7+C9Sw9fmhbgjT2DAYYwfRxnPWv7OQlOe1KRUddAv8UtoXGd2/IcVNfL0VBJ3y/ph8ZURhogyF+IZQxHQM8QtVEh4L/9U/QMv51dxKNI+O+/nx/VGOUhMIAtFjHHJx82O3P9yD6GQxiHtB0t6VmZ0YqTrIa0uQCPrxekwYbHDZ9nQ8W/08OjTY23kzz2G4iMNBdYFbc0lvLqLA9/kFi8NbBCol57JEmbTXS07wApZfNmw9gG/V06IPtIefOtHnwkihfZfUnQDDB10z+0Zeg2Mv05vwGMKPT6Y0ofpgKufUkKvsQC2+4w==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1201.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:190::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 00:33:56 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 00:33:56 +0000
Message-ID:
 <MA0P287MB2822EBB6FE58EB4C3BFB7BC7FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 13 Nov 2024 08:33:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112225832.3518658-1-ragavendra.bn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241112225832.3518658-1-ragavendra.bn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <4b29601c-38f0-4aa1-9011-2393f174e452@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: d3273cd8-dc4f-4b76-489f-08dd037adb75
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|8060799006|5072599009|19110799003|461199028|6090799003|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVFUWjRLR3Y2TC83OURHczQ0TEhEaWUwTDZ5UWNGUUNZUmRWWGJnM3Y1RkNp?=
 =?utf-8?B?UGl6NDQvWXA3MXZZNFZWNjhxSXhyN2Z5cDNWaExGZzA2Sk5VWW41L1Y2Nmlu?=
 =?utf-8?B?VmpzV3NXZHprdEtQV1RhSStsUkVpNnpKQlVPdE9haklPcmRrZVBnYmxmRlV0?=
 =?utf-8?B?Wkc4dW9paFAveWdMYUlocFZ4Y1hSUUc4alNQdkNLbzJCSkFFNVhZbHJPdnFW?=
 =?utf-8?B?QlNqQ3J2eW1rNWRVRUZxUmI5aWk4dE9JeFpVN2RoNjRUdzZIWnhhclpXdUlo?=
 =?utf-8?B?TCs0ZWFsZTZDb2hjazNERlFkYUcwa2pLenE0QzZ6NTIzdmQ5cThDZk5lbTdN?=
 =?utf-8?B?RUVtV3NWbFh6OXU3dWlZWHlYeDd5ODBRTCtvVzY3SjVUa0xUVjRBUWZOZVJX?=
 =?utf-8?B?eTgrNU9DTHNwR2NtOG9vUVRkaVN0NWRLVElMVVhtbk0wZlNsRzVPV0M0VFRY?=
 =?utf-8?B?blozaENGd0ZPZFcvRlBKQi8rZjdOZEtpL3I1VnUzbzU5aFVQUUhYcVM0MkJ4?=
 =?utf-8?B?cTAvMkhCUWdPR29mMEF1VXpvTDN2ekRyOXlKeVc1WXpMbnE0WHd4VzEwMGZp?=
 =?utf-8?B?aEN5d09TWnZ1VGdQVDZseUpRVGdSZVRwSVpBSWJaRkxsWUFjQ1V5OGV2NHRs?=
 =?utf-8?B?MUxVVUtRQmxCeEpzTnF1SUF0R3VwaVB4SjhVQnVvU1p0SEhyWHE5RmFnQWlJ?=
 =?utf-8?B?Q0twQ1RRR091aDlGcUIyb293NlExUVlGaHNPSlZNUkRROVB5YWNnUHphdkJl?=
 =?utf-8?B?Zkp5VWpsOWZNanZESllUb3VlQVBFMmVBajduTDNaVXdKMDFvTkZQSWcyUUda?=
 =?utf-8?B?OVR3SXRqVkhKVFlhaVZNUnNsUzdOTDZQZ1BuaVB6NllDZzQwSlgrRlZEaVhO?=
 =?utf-8?B?UWJyRndLK21TL3RYZWtJUnNmYW12K21TL2VrOHFZTlJEdzM3T2VkZm43d1hN?=
 =?utf-8?B?N1kzYWpRQ2czcWthMDRkN2djWVUxcGIrQVNnR2gyNzRZaDl1RmFYWHRKTTNS?=
 =?utf-8?B?K3VzcTJQaHVmRWtrVWszNFZ0WkNVMzFVVS9HQ2srZlRkcXFrVndQeWx2aHhD?=
 =?utf-8?B?WGNEREFCczZJTFA0MjBoTUxLelZKZ29mcGxTaWZ2ZWEyTDNNQkF6cWwzOXk0?=
 =?utf-8?B?RUdWb1VXOTk1MzFoRUxnRzBjdUtSRmlacUk3TzlZNHRFQ3h6TTJMWHpmMUJp?=
 =?utf-8?B?MXJvWDVLZC9sNHptUW54amZhcGxDSEEzSXBqYlhEeXpGZytldmwzdzF3YXdW?=
 =?utf-8?B?cFFzYUM4dHNBZWFoOWZWdldSMERQSFo2bDRHZXM0d010K1Q5NFVhMHpWaXRT?=
 =?utf-8?B?MWYzbVBLYzVvcDk2ZkxyVWJFY1U5bUtJVkE1cUIrK2R2cnczK016VzdzT1c5?=
 =?utf-8?B?cDJKUjhkZ0xTSWxGUWtRaFdSLy9rV2lpcXlpdUtzUVJubnZxOU9wVkVkN2FX?=
 =?utf-8?B?R2hKTkczN05jcXp2b2xvRDl6blU3aitLNXpQRk8xTjNnV0NFR3haRU5ML3dP?=
 =?utf-8?B?WEptWFFYd2ZibGpGNWxXSUNDQlhXcmRpaFJlTGJFL0NxaXhScDZqeldKelQy?=
 =?utf-8?B?RGVHWVVOUk9TeWNsNWJ3ekpzQ1E3UUdtMmQvWm5kMzNjRUIxUVRFVlZLMUpZ?=
 =?utf-8?Q?QaosOOa/KeNxUhQGVgP+BDGdI++/pLtyASceLqBG61aE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1zaHkxajFGZDdwQm5DK1NJVHNLMDhpQXNYcW1RdHB0MUE5QW9MQ05SemRw?=
 =?utf-8?B?dXhXOGYwczVpZDdyNGNiT0xCSzBMNithdGVYRWt0a2I3R0RqanlHTFBDMTJK?=
 =?utf-8?B?VkV0a3hxNTMvS2p0Tm1LZDJNd3grM0VnNGtmL0djenFISFpYV2VUV1g0Rk54?=
 =?utf-8?B?dkhjekJSTWdBRHNNUjhPMUFUeFFIbFFGdHhUWUZuV28zWFVycVRpcjJOMVJM?=
 =?utf-8?B?MFF4QTlpQW1SOUNYOUdrcUJwWWdWbjFRMk5UN21TY3g2ZTdCRXAyNzBWV215?=
 =?utf-8?B?VVVyb29EVk82cEdNTTJydUtyRHQ5L0pZSzZtWk1UbUt4OEZpN24yMUpVT0c2?=
 =?utf-8?B?ZHBuRFFRTm1ZNXUyc05WRDNSY1pRUmV0cjNYUTdSSlM3ZGF3QWdDdVFPcEp5?=
 =?utf-8?B?cHRLWGVNbTc4VDg5MjBubFRDNHJTenVGTUhvUWN0Q1NuWE9qL0gwRStjM2Vn?=
 =?utf-8?B?cjBicWw5T2pNMjFCUGc0aVkybUxzRXEybktmQThYRklDTjB0cll5dDJQbDFh?=
 =?utf-8?B?NU5tRmVsclBmcmxkaHg5bnRXeENGdzdvUkVhMllibG5xaVBMUUxMOFRQOHox?=
 =?utf-8?B?MUVObVRIbjZsMHNhYXhCdzVOdTExbExobFhUdmJEcHRZb2o2S2ZBT0lEdU9q?=
 =?utf-8?B?ejlXQytzaHpCMU1uSzBVSmJvc1ErMVJWRzNRdUlKS25lOFR5dHVuZHl2em1q?=
 =?utf-8?B?VEtEdzdISEV5b3NKaXdWT0djS3gyU0V5amdLME40YkJQMTd4WmdPMkRJbWFp?=
 =?utf-8?B?QkFjSEtUc2tYZkxNNTczVHVmNzhUd1lMR0kvOWNQSUhnVnEzQ3BtYmg0cWdw?=
 =?utf-8?B?NDhSMTQrcVhJT2JwODRWMkE3Mk9HaEkybVg4cmgyVVQ0OGlHSitXNzNIdHdv?=
 =?utf-8?B?WXBmY0c5bXNPYjBaQm5BZnpaNkZtV2lGUnFjZ252ejZvTCszVzAzeWRDSDND?=
 =?utf-8?B?akZLVU81eWc5NHdTbEh1MHE1b3FWMU41Sm5hVXpLVmFrcFFUMGVxWE1IMm5V?=
 =?utf-8?B?dVFDVHlKK2d3aWU0S2VEc3FsZmxlb3dzcnJTUEh4NE54L0lYekNQbG5KRzRU?=
 =?utf-8?B?YTdjUkJBSWdnTjNEemtTdmJKcEFPUDB6WGJQVGhSZHJ2UDV1WFJKMDdhbWIr?=
 =?utf-8?B?RGpVRkFwVHEwWk1KMjFMbHpuM0xONFZHUERFenJOY3NoK3JCTkVmN0puL2FS?=
 =?utf-8?B?VS9KYUdFYTVZRlY3ZUhqdUduMFpKaDFJVlY2ays5MkdmQTVxVVdab2lyZWVx?=
 =?utf-8?B?Y2ZIOXlST2h4RFJOZlFXbEkzdG0zT01XeWZEZXZvRmREOWVnRHZzRHFFc1dG?=
 =?utf-8?B?UlJjdXA0ckJNWTdwVjNpUXZqNzNuS2ZwYUNFRmdGcDcxZll1NFRIVjU1c21k?=
 =?utf-8?B?c1R6TjhEWkJBYzkwSXZNQXVvTFcrQkZhbkI0anpOWmlvdGJmcU04aDVmODI2?=
 =?utf-8?B?YlBIOW9naUJidVRBcExxS2lxUHRJUlFmQlBIK1BHZ3YvTXM4YkhDeFFMY0R6?=
 =?utf-8?B?OXByaG1BY1JNZEk0eks2MEhnV0VIeDFxVmY0cUVrMVkwclRUeFY0MVZBRlJp?=
 =?utf-8?B?S2RSa3VlOUNkS24rUUg1QnJoWDNkcWw5SHliT1NmZytDSkpNdXV1WGQxVVNy?=
 =?utf-8?B?ZmdYc1pnZnV6ekw5aHErSXk1aTBueFBEMHNUdlBxaW1sL3cxc0VOSVBmV2Vj?=
 =?utf-8?Q?NUBHfKIklHDyzQZgtzyP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3273cd8-dc4f-4b76-489f-08dd037adb75
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 00:33:56.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1201

Pleas improve the patch title and just write "fix..." instead of listing 
the file name changed.

On 2024/11/13 6:58, Ragavendra wrote:
> Initializing the val variable of type u32 as it was not initialized.
>
Please add "Fixes" tag here, see 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html.
> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
> ---
>   drivers/clk/sophgo/clk-cv18xx-pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
> index 29e24098bf5f..04a0419cab4e 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-pll.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
> @@ -87,7 +87,7 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
>   
>   static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>   {
> -	u32 val;
> +	u32 val = 0;
>   	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
>   
>   	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,

I looked at ipll_find_rate() and found that the parameters 
"rate"/"value" are both input and output parameters, which is really a 
place that needs to be treated with caution.

Seems this patch change is correct, otherwise the value of "detected" in 
the function will be random after calling ipll_find_rate here.  Actually 
I suggest adding some comments for ipll_find_rate() to emphasize it. 
Otherwise, it is easy to think that "rate" and "value" are only output 
parameters at first glance.

But I raised a question here: In ipll_find_rate(), do we really need to 
make "detected" depend on the value of external input? Inochi, can you 
please comment on this, due to you are the author of this code.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen



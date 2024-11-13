Return-Path: <linux-kernel+bounces-408434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276849C7ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC05C284079
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695B18C926;
	Wed, 13 Nov 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IsNv9Whf"
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010008.outbound.protection.outlook.com [52.103.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FC18C021;
	Wed, 13 Nov 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541001; cv=fail; b=Y86bidQ+MV7bBfIE+V368+WWyfHKC8UnpS315g6KIP49+iKDp6iKwJjpYJ2/0zNgAPjgptlYy+2l0L7OmjzD1m9shCsaCCddEkKWzi+LXNZKHCwEqvX6r3hsE1Z0bCbIc5aCDLM5r/RhspKYVxLHYkOvPpXXjAzUG5bWZojbE44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541001; c=relaxed/simple;
	bh=3pWJu/86qaFudGIzfqSEIFd0l6mLfwEuul4bev9Uv+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jw/R6fmGQapNa3J0PJrF5Rnv5r3LHVy4JzTHI3EfSf3UPrdA897bggByDvbaktxQsW3NAYOKFU7VYWs3S4cSr75IQ/nbRyyafh6+FAxaA7Cftsapbi711XtSalLRIALtRfkJ7Z9ET5RbsvTgrF/h5/vZ2Rx+KN1PS9OrKpuW+mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IsNv9Whf; arc=fail smtp.client-ip=52.103.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIJEimTgbu01gO2jvJdtrPrUzIPEgrSgTQFBwpSuFcth4Wiei5f5Uxe2auieUZ6qwqVI7pNSSjQt9LZqyHfwCatzUgbFi+azbC61wA2sTf5GPzmnsJqvP7sr5+exYQdFJ+9gACRBkOArhURgpTVoDBp/HyzdCIUNmEpMeSr0vQMHSO8kg5oveT0uGCV6Av4byciMAjo6wtiF/NqrUsLgZ7AGtnmTn7ala/gIVmsEyOCCTnlYi1cf8FfTPs+dSXiBjLZmSG3a6oyKd/OsmEMikAY5crrNKK0NNlb81h6omzUnkpaBYsekfHpFJm/hzjogIF1OnY4oxeKpZC4vXr5OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG4eLA47FLYtqJPzyTjvSinOqsecTm9sFq8s9uUqY9w=;
 b=Q8q59155gdjgd2Jf1frrrewVtCMlunlaafHZc5gs4jpBxCnaabd/IEFrFMzTKGMYQc/0Kz+8LoLlG1w2r74thpC1KxLI03ljZRI6MfaZO8pMjz7a2yLJUBHg1OBlu4NEWOcP4Pi9es95latFcrh36tKdKn0arJ88446g8SxHRGId6kLMN0HnTvIJz7p5rz5w1PlYXno29ON5fVGUYHwd8foXZCysiPV47mLoiUgbrciLNwV3VbyT0x4Olyc4PNIiC4bjELaADMA7oW/LiKUMiHk7+tPNtlX7+ELtCAc43/vEG8bp8La8cMyHOIBIYGvL+4F8tZY+75lmp9KSNDR2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG4eLA47FLYtqJPzyTjvSinOqsecTm9sFq8s9uUqY9w=;
 b=IsNv9Whf/44q8AHWEjJk7X/5fnDxpHaDQ6kO1hIEpHNDDAAGYcbZBM/B6i2sV4or40xVKhd/GylH+GcWX+4JPqjOTG+6+WEhFxwOVg3250ddIU7Q1HlGbOjni1bBMg0je+WDBSS8ul7QtpF4WfS7hosN/2yqlhCxAkX1686c861FLav6h6DCvMcIWj4cCYHLpcQvxp+bzChuJbEw6VjYTGRQL3IOmpchqyrAdb+5khq+6LfAqxrunZvFhs8mJvoKqTNaiBv906NEiII0b2RRoHl4CBi2/aVvkrB8OpoK3k6yX5TuzvGoN/o3xX9v9b6fszA4LxH+yzLQ74LO570fjg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1158.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 23:36:35 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 23:36:35 +0000
Message-ID:
 <MA0P287MB2822D976E1A3379DEAC28666FE5A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 14 Nov 2024 07:36:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll: fix unitialized u32 variable
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113020233.3646527-1-ragavendra.bn@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241113020233.3646527-1-ragavendra.bn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::27) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b2d7d8e5-b7d0-4fb0-bc88-a82f155a7cb8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1158:EE_
X-MS-Office365-Filtering-Correlation-Id: 38798179-cd5c-4b81-0f59-08dd043c01be
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|8060799006|5072599009|461199028|15080799006|8022599003|7092599003|4302099013|3412199025|10035399004|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRGOTVzTlN5eURuY0E5WW1JdlRrZlNBVzVObFVBemZrMjFCeEhqY1EwbFIr?=
 =?utf-8?B?VlNKYzlpY1REY0RQaUFYMkJvVEMvdTZTeVN1ejl6SEhJY2hWa0RFaTY1UUU1?=
 =?utf-8?B?dFU2VTVQNEJEN1RjWStQVmorbERPWitoak5lUUJVMnhZTXVuWUpyUnBid2F5?=
 =?utf-8?B?OVM1c2Mwc1puZFg4d0pHUlN1bnJ6ekxIdStWVEJiZ1QrdGl1QUF6T3JSV1lo?=
 =?utf-8?B?b2pUb2pxcmMvOFZrMnozQXBWT1dsVkQ4c1htS2NFc0RrZU10cm5nMzhDVlRt?=
 =?utf-8?B?Nk9XajAwSVNWOHhMK2E0M3NZOEFYWnFyeFBLZkdQR016dkFkdkRhV2c3b2Rq?=
 =?utf-8?B?akRIdGM3dTZqakp4a0pzb0lDN3labVNRWDFocmVudWNLT0Zya1JPeVJmZ0dX?=
 =?utf-8?B?Qm1COEcvMkF3dXFmWkNySU4wSGVrdlpNUUZ5TEh6Yll5UXRVYzA4djM5MW9T?=
 =?utf-8?B?UVdEa2JTUTVnL1psS1hzWnVuWWtSRlhpelBHOTF0NGJWYzZtSGl3ZDJlTW5U?=
 =?utf-8?B?NzI2aVd3c1NOUVk1YWJ2VWhNdEVETEcvYU9FMzRjc0NpZzV3cUwyaERLK1Nu?=
 =?utf-8?B?bXIwRXVGcjQ3OG1CbXFab0todm1iWDA0YWd0VlY1ckR3dm5sWmVPWXlVREUv?=
 =?utf-8?B?emUzNFg5Q2hEOEVXVDl2Q09YOXZKQTRiWGJRTDJucVlHeFNOY1Y5eHRDQnoy?=
 =?utf-8?B?YnM3L0lkeUhLdWxYK3hIN1RMbjZqdDVXY3dqbVR3M1FoOUhSZ1UzcG1wKzMv?=
 =?utf-8?B?RWdHclZuMjlrRGZ3VFNhZTV4bXBOV0hMbXA4NHNLL29jS1ptVVREUFV2bTR4?=
 =?utf-8?B?SnY2bVZWdnJRR1lYU2Fjaml6QmhVSDlvaGxTekpqdDg2M0NYNkFYUDl4clVJ?=
 =?utf-8?B?UnVZL3dxS1JYdHlSVjFxamovVmVNdExjK21aR09UZU9sbXUyYlhVRU5kV05G?=
 =?utf-8?B?KzUwOUl6WnZGUlc2c2ZnbUNRR0dqcDRXSVMyOGc1TXVSYmRTaklQcThtUGND?=
 =?utf-8?B?REtkaTlJMDhuZnNKOUZtcEtkSFAwaUd0YXhvZHhISlIvMEFMeXVhMHE3WEc3?=
 =?utf-8?B?RGZRcS82cGIrTmxzbzlhT2t4bjNpWGE2emtFVFpWZkNkc3hUUGxRb3IyL1lB?=
 =?utf-8?B?T2pXN3FyY1pPRjhmWHl1c0FVQ1EyMnBVU1lkZFM4dTVMYnI4VTYvdEtQRUVn?=
 =?utf-8?B?ZDFlT0Nhd2JQd3VzdUhYb0ZIeGl4Tk83enF3a3ZjZWlneDd0MitrbGozT04x?=
 =?utf-8?B?UlBlRHovdE1XNkZpVnpWdi9QTHY3VDZyUk1oMVQrc0xITHBRaHErUVFsd01X?=
 =?utf-8?B?a2YrSDhDdVkwdHVESDFZdG1kU0tlT0VwWEFzMEhkZng4czBMK0c3OEJ0UEVx?=
 =?utf-8?B?VklTWDcxdXlEY0h6MUoxSWZQd2RDZ0V1U1dpR3o1YXlyV01RcXF1aDN6OGsr?=
 =?utf-8?B?MEU4MDZUSmFDeFJ4ejNaN2NPeFgycG9tTk01d3l2NG1Cc01mVXVZaWZGU1Y0?=
 =?utf-8?B?S2F5N0FBRVh1aFZEbWcvTzQ3MXdCQnhlcERiRTR5ZkpSTUlXNnVodmMrWmNj?=
 =?utf-8?B?WTNVSTEzMWdBUlNWYlZ0QlBCZUVZTUtpcUFacTZMbHlnY2VXOGRTdUdMZkR0?=
 =?utf-8?B?WXVvVG9sOTVHdVVseXdxQlhiSUR4WjR6dDNyQ2tUUzVkL1Ivd2tHVlJ3NXRx?=
 =?utf-8?Q?H/LaUYrtjoKL3XbItf3K?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZ2Q2JEU29GQUxsNWlFcnE1aGxJTjlBdGdzY1FpTm8yUGFNekhYVXRUOVhx?=
 =?utf-8?B?Tk1uck1jVVYxU0l1aTNPUUIwcXRoaFZYN041b01xaVJZNHVBdzlzeU1oNjls?=
 =?utf-8?B?eUpWUGRCck5SVk82ZFBTZTk4WUgwVHdvcFVlVG03cHY4WFA5RVRhMVVzSk9x?=
 =?utf-8?B?THcwK0hnTmk4Tk5MYmlrTy9DOTlPVG53VVpDak85bmlQYnpVeHk5Q1lpUlAz?=
 =?utf-8?B?ZVlTU1c3ZmVjOHkyanh4enQ5ZnBCaG9YWW15dXFiNTAxK1pkc1NOWm8vZytO?=
 =?utf-8?B?TUZFdmpObDlVbTRzTFJjTW42S1Z3ZHpCRWVGdWdYR0hudHZaa1d0dkNtSFFR?=
 =?utf-8?B?VFVYcFhBcjBqK0JNSTBld3ErQyttZ0FkT2s0TXlwUlI2QjdQUDFqK1FxZGR4?=
 =?utf-8?B?QWtEZ3hUeWVTVXVzUyt1STV1NEkzZkNVcG96UTg1czhPQk9KWUVKMENnT1Zn?=
 =?utf-8?B?eWNySTBhL1k2cVd5M3YyR2pCc0RTSG5UQkx0UGZGYjI2S3NQaWQ5akg5Umg5?=
 =?utf-8?B?d21OVEcrcG9zWFQ5bEhUZDRKZklpdWIvRzl2ZGxBNHl4N2VFaEFqZStlZ29I?=
 =?utf-8?B?T1NFU2p5Zk1MaDlCdnFJNXU2MDgwK0ZXelBibzJpT3l2ek9NaUd2d0czSjF1?=
 =?utf-8?B?TW1OdW1VWWFlUVJ4Ymx1SFFSSDhEd08xWnZiaVBKL0Z0VWNvNkY2bzFwdjNM?=
 =?utf-8?B?MGp2d0xNQ0xUTW4rQ1ZrdXlCRE51S3JGR0lpSlBrM1hobWwxdDVqb01JOFI3?=
 =?utf-8?B?WC9WNUw1NFQveHVRcmY3RDBlZmU5ekV3QSt4Nk96ZVBVRldHR0xHaGtWOTBP?=
 =?utf-8?B?MjdYZDFyd2hUUjhhbWNRMnloWEZsK01KQjdpNnlCZVBWcXNnNVNuRkRsdzZi?=
 =?utf-8?B?SGlBTnFiRjg2ZWRnMW5YRndjWmUwNFo1K3VhdnVzdXVSaVBFYUdjVlkrdGNE?=
 =?utf-8?B?NHlxWS9YZGo1L3VUdk9TT2N1U3dWZTBSL3VnRDVjM3hxTGQ1eFJYRmhhY1pn?=
 =?utf-8?B?QmV0N0NYQU9UcVVHbkRnekJIRmZrYXZ2bk5tck1ENGFBY3c4ZS9WUHI5aFNC?=
 =?utf-8?B?MjFlVHhPOVN0cmFERkVPdlF2bWhJMndoZ2J2UG9NSkF3VDZzdERHVXlqRUp2?=
 =?utf-8?B?WEl4L2JnOGtlay9JUHBEMjNqSG42RHY1T0gyZDlsVEZBV3ErbWYyZ0J0YkU4?=
 =?utf-8?B?bUVPSDZOZzRvQm5OYTdhV0FqM0treHFVVXJvMU54UzR2OEpmcG9kaiszOHRq?=
 =?utf-8?B?eU82ZlJ6bTlxaHpKYThzRnBGUno2QlJZRS9ublpGQ3hFVTU2RysrcWRVNEZw?=
 =?utf-8?B?dHlEZVJEbm5ZQXNaUnZmMjQ3azUrcVpPaFJQZEVwRitxRWQ1WUt3OTJ0QTZC?=
 =?utf-8?B?NnpUVFBZbUUwSy9vamRGSm5KdTZvZE0ycThtaUdNcEFzMjR4cElSMzhWY1pw?=
 =?utf-8?B?MGFkQ1h6bnRWdThyOHR5ejhQN3U1QnpqQVBFRVQvdER3cDFDMmE5c0JhdXJI?=
 =?utf-8?B?Tmt5Vi9OTjdpNWJBTFFXS0sxVkRvRldpOFEyd3VsbVFzRTF4V3pXbStNVEtp?=
 =?utf-8?B?Q0hnNVZMVS9zdnNFaVZadGdWbm5MZkNLaHc2WjZsL3RCZThoODRxK0FKN0U1?=
 =?utf-8?B?c0ZXZUlsWkhaTGVLV3BmU2ZkRTRsVUxOUTNWZUxhaitJcDNsUFZlZ1dPK3Bx?=
 =?utf-8?Q?awAlZt+qnOjDut1bOriv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38798179-cd5c-4b81-0f59-08dd043c01be
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 23:36:34.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1158

Hi, Ragavendra,

This patch should be dropped, right? I see a new patch 
https://lore.kernel.org/linux-clk/20241113184617.3745423-1-ragavendra.bn@gmail.com/ 
should have covered this.

Suggest you reply this patch email and declare the dropping to avoid 
confusion.

On 2024/11/13 10:02, Ragavendra wrote:
> Initializing the val variable of type u32 as it was not initialized.
>
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
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


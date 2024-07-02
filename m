Return-Path: <linux-kernel+bounces-237415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1E91F0BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46511C21DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33814B950;
	Tue,  2 Jul 2024 08:04:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A64148311
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907454; cv=none; b=FdNUBx8eqLd2RI+ULyHEH25ZcvscjH9LeoxCIDen6uzvoVnUUnlCmlZNJvOJDjdjdwRBS+42Dw2ornjbIfuovoZ/sr1EkzGfS7IczRY4t1nchn9d9aqEXSnGYLlibyhkBetOxODfA1CPuMaOw/X6FjbY+hlorwGgbSlB7FPBqfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907454; c=relaxed/simple;
	bh=T/v6aLQeJkcufU4wheleZvvlW+a4m9q9gimchSO1kiA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=knTZuf8CqXv8r0+LLaWpO8GlRlqr62VcfCYd2bAlwLdcxAdddCESka/xC5SVTIDEk+qJPFN+gyqXUjql/saVB+aqivZjZl8xR5PZfumVKrcguvEy7kVgiulVzcOnr62dMrszyB1ZJl2TPhb2VPrChZ1OdEJU3+UY1MXjw8BohTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WCwKv4cR7z1T4lb;
	Tue,  2 Jul 2024 15:59:31 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 7ABD31400C9;
	Tue,  2 Jul 2024 16:04:03 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jul 2024 16:04:02 +0800
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from emergency
 reserves
To: Andrew Morton <akpm@linux-foundation.org>
CC: Rui Qi <qirui.001@bytedance.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <nao.horiguchi@gmail.com>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
 <d7fb45a9-2d16-a2d5-59f4-f1e7a4362e33@huawei.com>
 <20240702001940.43a9447a76b51a871d8dec97@linux-foundation.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <070697f1-83f5-ff8e-dfc0-2f99c98c448c@huawei.com>
Date: Tue, 2 Jul 2024 16:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702001940.43a9447a76b51a871d8dec97@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/7/2 15:19, Andrew Morton wrote:
> On Sat, 29 Jun 2024 10:09:46 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2024/6/25 10:23, Rui Qi wrote:
>>> From: Rui Qi <qirui.001@bytedance.com>
>>>
>>> we hope that memory errors can be successfully handled quickly, using
>>> __GFP_MEMALLOC can help us improve the success rate of processing
>>
>> Comments of __GFP_MEMALLOC says:
>>
>>  * Users of this flag have to be extremely careful to not deplete the reserve
>>  * completely and implement a throttling mechanism which controls the
>>  * consumption of the reserve based on the amount of freed memory.
>>
>> It seems there's no such throttling mechanism in memory_failure.
>>
>>> under memory pressure, because to_kill struct is freed very quickly,
>>> so using __GFP_MEMALLOC will not exacerbate memory pressure for a long time,
>>> and  more memory will be freed after killed task exiting, which will also
>>
>> Tasks might not be killed even to_kill struct is allocated.
>>
>> ...
>>
>>> -	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>>> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC | __GFP_MEMALLOC);
>>
>> In already hardware poisoned code path, raw_hwp can be allocated to store raw page info
>> without killing anything. So __GFP_MEMALLOC might not be suitable to use.
>> Or am I miss something?
> 
> Yes, I'm doubtful about this patch.  I think that rather than poking at a
> particular implementation, it would be helpful for us to see a complete
> description of the issues which were observed, please.  Let's see the
> bug report and we can discuss fixes later.

I agree with you, Andrew. Thanks. :)
.



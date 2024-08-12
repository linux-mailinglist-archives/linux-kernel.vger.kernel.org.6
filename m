Return-Path: <linux-kernel+bounces-282997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6B94EBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567D71F222ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17826172BD8;
	Mon, 12 Aug 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="pfbdHsxN"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1D43AA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461558; cv=none; b=Jy32nZV9JKmrP9aiChXERW3R9AOgVEznV7xm5Ln0drGui/VNTWRr5NisU6s5ENuu2cG9HQmD7VuzRMrFYbrFHEkJTZf3ZZHRjNtIuvXRASiNZR0mzg+Hjonr+Ib/zwaE2G8iiyM7nsM9+mMLQso52rCPvdin8RrFp49y0xbG9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461558; c=relaxed/simple;
	bh=QvGn/qoVttutvZDBm7HGeBc6QWXpyiqrPTzwbaOaupc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXkmkIT83qobfjnbJ02bXXtpujfIrQ5dUOzYN3v+5a005sLEb4hxkiDT2qkObeTyr6HQRVL98BZqtUZl6j2/ul+Rx0jmFCPx4fewyjd5UbgvHQoICoB2ElcrpGTfpBwJzL4mzJbC84ghESXjtkKB5R2wOu/erCAoFgPQ5wIBkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=pfbdHsxN; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=IL9OspOx/VC40//vfa2y5PuttDGamF8h+QZuJpZ3aGY=;
	b=pfbdHsxNRvAvw8vq54dv5RdQwoB4/sNJ2pE9kS0Jd1viPkD17gm2Cb5sIOdfZg
	UBMx4C6fLRTqOvWxRsr8WVuaVr4/TdGQnV/wDrLaSZPvYCvT4FTrDFgIB6JbVMW/
	j9OPOxX+CLeg311YmVY2J0K5egjrH67jhysploMqQYNyw=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzsmtp1 (Coremail) with SMTP id pSkvCgDXn5KR77lmm4e1AA--.47343S2;
	Mon, 12 Aug 2024 19:18:42 +0800 (CST)
Message-ID: <792b62dd-ef63-4609-a1eb-e2ccfd90b5ee@126.com>
Date: Mon, 12 Aug 2024 19:18:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/swap: take folio refcount after testing the LRU flag
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1723270558-31674-1-git-send-email-yangge1116@126.com>
 <8e987e3f-6899-41d1-9ba4-c49cb91f7815@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <8e987e3f-6899-41d1-9ba4-c49cb91f7815@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pSkvCgDXn5KR77lmm4e1AA--.47343S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyxtw4rur1xZr1xur18Grg_yoW8Wr4xpF
	48GFnxuF4kGF12ka47Z3WYyFyj9FW09F4kJa1fAwn7uFn8XrnFkF1xKw15uay5uryxWF10
	vFWYq3WkXF13AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5-BNUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhk5G2VEyJbDtgABsK



在 2024/8/12 17:10, David Hildenbrand 写道:
> On 10.08.24 08:15, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> Whoever passes a folio to __folio_batch_add_and_move() must hold
>> a reference, otherwise something else would already be messed up.
>> If the folio is referenced, it will not be freed elsewhere, so we
>> can safely clear the folio's lru flag. As discussed with David
>> in [1], we should take the reference after testing the LRU flag,
>> not before.
>>
>> Link: 
>> https://lore.kernel.org/lkml/d41865b4-d6fa-49ba-890a-921eefad27dd@redhat.com/ [1]
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/swap.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 67a2467..6b83898 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -226,12 +226,10 @@ static void __folio_batch_add_and_move(struct 
>> folio_batch __percpu *fbatch,
>>   {
>>       unsigned long flags;
>> -    folio_get(folio);
>> -
>> -    if (on_lru && !folio_test_clear_lru(folio)) {
>> -        folio_put(folio);
>> +    if (on_lru && !folio_test_clear_lru(folio))
>>           return;
>> -    }
>> +
>> +    folio_get(folio);
>>       if (disable_irq)
>>           local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
> 
> Ah, "mm/swap: remove boilerplate" reduced them to a single instance, good.
> 
> You can throw in a
> 
> VM_WARN_ON_ONCE(!folio_ref_count(folio));
> 
> before the folio_get(folio)
> 
> so we would realize when something very unexpected happens.

Ok, thanks.

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 



Return-Path: <linux-kernel+bounces-408980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6F9C85F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139C21F22022
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F161F6660;
	Thu, 14 Nov 2024 09:21:56 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE81E9092
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576115; cv=none; b=Nln3tJtrD4QZ5dR1UevduEOyUVOCzHvdrrgt6suEdzeDnqdCVdzEl4zxLTbMmiCDNNM0n0PXlcdVGmSXOgP1s76qjLmJR2a2OwPYaBEUdT11n6U0sKyUjRoclaISxqp/F7ZxCEmqut4wkd86Ibb9L4wTJwWNW6+b8pyNO4VBf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576115; c=relaxed/simple;
	bh=3J1ZUIYKNQfn1onJrV/8ejMXLJdoGHhJt31hk08ta6Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bNZYpajq/3TNdi6QsFVJkE6CuFL9Zx3Gd4Y1vJ4eqC4GNGyzO1kdwooHQ2iRKg9zn7u0r3/WmdcNiRG2JU2Sc7zyCy0ZxscsxNDMcEa7idL94sVIIn6LEZUed4a3ZSRkcbasTU822bgXAct9mEIGICr/9rmPgtX2oQQ8Kog73hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xpvm94gl5z4f3nZp
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:21:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CB01C1A0568
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:21:48 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgA3l+MrwTVn9jH2Bg--.34094S2;
	Thu, 14 Nov 2024 17:21:48 +0800 (CST)
Subject: Re: [PATCH v2] mm/compaction: remove unnecessary detection code.
To: Vlastimil Babka <vbabka@suse.cz>, Qiang Liu <liuq131@chinatelecom.cn>,
 baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20241114065720.3665-1-liuq131@chinatelecom.cn>
 <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <56ee8988-fd25-76bf-08a8-b84732fd2170@huaweicloud.com>
Date: Thu, 14 Nov 2024 17:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2b6ca5b1-f421-4dda-a2a2-865af97b2db8@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3l+MrwTVn9jH2Bg--.34094S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3XFy8Ww4kGF4fXw4kXrb_yoW8ZF4Dpa
	4DKa4xWF18u34j9FnFyw45ZF47Z392yF47Jws8KFy8AFnYyas7tr90yry8ZryqqrnxArWq
	vrsrKFZxCan0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/


Hello
on 11/14/2024 3:44 PM, Vlastimil Babka wrote:
> On 11/14/24 07:57, Qiang Liu wrote:
>> It is impossible for the situation where blockpfn > end_pfn to arise,
>> The if statement here is not only unnecessary, but may also lead to
>> a misunderstanding that blockpfn > end_pfn could potentially happen.
>> so these unnecessary checking code should be removed.
>>
>> Signed-off-by: Qiang Liu <liuq131@chinatelecom.cn>
> 
As stride could 32, if isolate_freepages_range() is called with start_pfn not
aligned with 32, we could bail out look with blockpfn > end_pfn in
isolate_freepages_block(). Please correct if I miss something.
> I see that's since 3da0272a4c7d ("mm/compaction: correctly return failure
> with bogus compound_order in strict mode")
> 
> I think that commit introduced a risk of overflow due to a bogus order
> (which we read in a racy way), and once blockpfn overflows it will satisfy
> <= end_pfn and might e.g. end up scanning a completely different zone?
> 
>                         if (blockpfn + (1UL << order) <= end_pfn) {
> 
>                                 blockpfn += (1UL << order) - 1;
>                                 page += (1UL << order) - 1;
>                                 nr_scanned += (1UL << order) - 1;
>                         }
> 
> We should better add back the MAX_ORDER sanity check?
As order of pageblock is <= MAX_ORDER, if bogus order is > MAX_ORDER, then
blockpfn + (1UL << order) must be > end_pfn, I think the sanity check is
not needed.

Thanks.
Kemeng
> 
>> ---
>>  mm/compaction.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index a2b16b08cbbf..baeda7132252 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -682,12 +682,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>  	if (locked)
>>  		spin_unlock_irqrestore(&cc->zone->lock, flags);
>>  
>> -	/*
>> -	 * Be careful to not go outside of the pageblock.
>> -	 */
>> -	if (unlikely(blockpfn > end_pfn))
>> -		blockpfn = end_pfn;
>> -
>>  	trace_mm_compaction_isolate_freepages(*start_pfn, blockpfn,
>>  					nr_scanned, total_isolated);
>>  
> 



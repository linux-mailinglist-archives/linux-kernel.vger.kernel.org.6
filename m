Return-Path: <linux-kernel+bounces-380830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E0C9AF6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D933D1F2295A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52781ADA;
	Fri, 25 Oct 2024 01:22:46 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3A82485
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819366; cv=none; b=XIIh/ASi/a5ZvznLAeTrhL68zux8ninrELVW3JewPXJ1nfUD51SzGKwTFgLXQIJr4wumZ7He4aqryvI0gHFboRwRcSeu5Duy/EVk9+s1sRt1y6xgNjRVOTSGdFuseS56T08rfNaOHMpDy0RmK/JfPjnlU7PmxjeWi42Ur/9raWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819366; c=relaxed/simple;
	bh=l4aT2ax3ymf7fFdq7Q7PT55NBKiLUz0XzmMHWvK2QRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdjWn7HM+aOL4M3SWIw5XQ6IyOBl3R7641t0FoEbiVq3RXPb9SaVepcIhIQ2VJ6/1d2pxQfqekVuaulT32w2/jyHnAvWsVyxxYwzN7i7k6Lok5jNiArXMxJV9OHuszJs0rdufJiR91q1Pcxp3U+WbUOjAweFlH57sVxiIIKBipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZQ4X5g4Xz4f3lfZ
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:22:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1C1131A018D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:22:39 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDnZVvb8hpnVB4aFA--.37378S2;
	Fri, 25 Oct 2024 09:22:36 +0800 (CST)
Message-ID: <b57f30e4-b1c3-4ceb-abb0-bd300cb80645@huaweicloud.com>
Date: Fri, 25 Oct 2024 09:22:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
To: Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>, akpm@linux-foundation.org,
 david@fromorbit.com
Cc: Muchun Song <muchun.song@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, zhengqi.arch@bytedance.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, wangweiyang2@huawei.com
References: <fff87be9-fdc8-4c27-8335-17b0c7e16413@suse.cz>
 <1BD74B20-879A-4159-B957-1223553217C1@linux.dev>
 <0b883f9e-451f-41c2-805f-7f5bc7eebee2@suse.cz> <Zw_4fOm_4ifT1uft@google.com>
 <e919c9ba-1d93-4e68-9146-33d1e28103dc@huaweicloud.com>
 <1625e2e0-06ad-459c-b941-41fadea2008d@suse.cz>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <1625e2e0-06ad-459c-b941-41fadea2008d@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnZVvb8hpnVB4aFA--.37378S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fZrWktF13Gr4kZF47Arb_yoW8Wr4Upr
	WFgFW2kF4kJr17CFn2gw13ZFWFv3yftw13Wrn5tryku3Z8trnaqrW7KF1q9F95uFnYkF42
	93yUXr9Iyw4YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/24 17:08, Vlastimil Babka wrote:
> On 10/24/24 03:26, Chen Ridong wrote:
>>>>> For example, if we use his v1 proposal, we should do
>>>>> the cleanups again for info. But for goto-based
>>>>> version, we just add another label to do the
>>>>> cleanups and go to the new label for failure case. goto-based fix is what I insisted on. I copied my previous suggested fix here to clarify my opinion.
>>>>
>>>> Again, info is a loop-iteration-local variable, v1 fix making it truly local
>>>> is the way to go. If there are further cleanups added in the loop itself in
>>>> the future, they could hopefully keep being local to the loop as well.
>>>> Cleanup of info outside the loop iteration is breaking its real scope.
>>>
>>> +1 to that.
>>>
>>> I don't think it's such a big deal and both versions are ok, but I strongly
>>> prefer the original version (without introduction of a new label).
>>>
>>> Please, feel free to use
>>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>>> with the original version.
>>>
>>> Thanks!
>>
>> I agree with Roman.
>> Hello, Andrew and Dave, Do you have any opinions?
>>
>> The original version:
>> https://lore.kernel.org/linux-kernel/4184c61f-80f7-4adc-8929-c29f959cb8df@huawei.com/
> 
> Hi,
> 
> Can you resend the v1 as v3, but also move the declaration of "struct
> shrinker_info *info;" inside the for_each_node() block? Also you can add all
> the acks collected for that version and mine too:
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks.
> 
>> Best regards,
>> Ridong
>>
>>

Will update, Thanks.

Best regards,
Ridong



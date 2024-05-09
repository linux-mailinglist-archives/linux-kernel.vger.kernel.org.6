Return-Path: <linux-kernel+bounces-174120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961E98C0A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C729A1C21ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23181482EA;
	Thu,  9 May 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WlnvHTte"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6511E4A4
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228356; cv=none; b=moJtVkbTGMqa7dlsrfvNOQHo4pn7UcVpg28B/bHfKMmwb10IIA2ZqcsYdonjbmyyzWLJjWqKjtIe0eyVdFzUG6MwexDgTde+JWWOAmGlPovAWHDVsC2S9rjiHlxEOd5I+IZROfAYEcfoAZcYK9c03FrCdMehS5xPpir1Igz35NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228356; c=relaxed/simple;
	bh=t6X6Z9zekKog4v4Cd99gC/6aeRTVc7xC0att6kMZxXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcWKumuVOM00wZAQAdhCi9nDqsf+Y8h6Pd6i5e1zUGfMCRarDEaJVUDVQJBMwKrP97je1mBiqVuNpitvj+Jw9ApflbSloRQHNNYzkEQlbpSSinPzCj8xA+S8yBHQr4X0iRnZEAnJJoXHKEmhBGqb9JmmtX6aUgJ5ueFu/f3T8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WlnvHTte; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715228345; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MlG1jzYm3DvAdthJlhJIxmB4JV1uRQxd2gQtWVSOmrE=;
	b=WlnvHTtecf/AL6NiukuNt2iXr5XV/w6df5iV4DbA3RtrzUv9d8wjE1mdiI6BeIdiwooF15H+DnQ22hLl0wTHcV5Fk+L0Fag85Hg30LuN6W6ZBXHsc6r800+VjeGCzwpC/sy1EBd4YeTbiBCvsOEYJ1JWLL/LqxsKw1Vfwu4RFVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W65Okvh_1715228343;
Received: from 30.97.48.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W65Okvh_1715228343)
          by smtp.aliyun-inc.com;
          Thu, 09 May 2024 12:19:04 +0800
Message-ID: <4fdc3040-4d20-4e9f-8002-e791e7a93c29@linux.alibaba.com>
Date: Thu, 9 May 2024 12:19:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>, Hailong Liu <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 xiang@kernel.org, chao@kernel.org, Oven <liyangouwen1@oppo.com>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
 <20240509033328.q2gwgaurpeg2mqqi@oppo.com>
 <CAGsJ_4xjaPfGPaPiAn69U1LoLZRPGAjCCd5iYajXhZh1qY8JBw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xjaPfGPaPiAn69U1LoLZRPGAjCCd5iYajXhZh1qY8JBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/9 11:48, Barry Song wrote:
> On Thu, May 9, 2024 at 3:33 PM Hailong Liu <hailong.liu@oppo.com> wrote:
>>
>> On Thu, 09. May 14:20, Barry Song wrote:
>>> On Thu, May 9, 2024 at 12:58 AM <hailong.liu@oppo.com> wrote:
>>>>
>>>> From: "Hailong.Liu" <hailong.liu@oppo.com>
>>>>
>>>> Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
>>>> includes support for __GFP_NOFAIL, but it presents a conflict with
>>>> commit dd544141b9eb ("vmalloc: back off when the current task is
>>>> OOM-killed"). A possible scenario is as belows:
>>>>
>>>> process-a
>>>> kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
>>>>      __vmalloc_node_range()
>>>>          __vmalloc_area_node()
>>>>              vm_area_alloc_pages()
>>>>              --> oom-killer send SIGKILL to process-a
>>>>              if (fatal_signal_pending(current)) break;
>>>> --> return NULL;
>>>>
>>>> to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
>>>> if __GFP_NOFAIL set.
>>>>
>>>> Reported-by: Oven <liyangouwen1@oppo.com>
>>>> Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
>>>> ---
>>>>   mm/vmalloc.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 6641be0ca80b..2f359d08bf8d 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>
>>>>          /* High-order pages or fallback path if "bulk" fails. */
>>>>          while (nr_allocated < nr_pages) {
>>>> -               if (fatal_signal_pending(current))
>>>> +               if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>>>>                          break;
>>>
>>> why not !nofail ?
>>
>> if order = 0, nofail would not be set true in bulk allocator. in such a case,
>> it is still possible to break early
>>
>>>
>>> This seems a correct fix, but it undermines the assumption made in
>>> commit dd544141b9eb
>>>   ("vmalloc: back off when the current task is OOM-killed")
>>>
>>> "
>>>      This may trigger some hidden problems, when caller does not handle
>>>      vmalloc failures, or when rollaback after failed vmalloc calls own
>>>      vmallocs inside.  However all of these scenarios are incorrect: vmalloc
>>>      does not guarantee successful allocation, it has never been called with
>>>      __GFP_NOFAIL and threfore either should not be used for any rollbacks or
>>>      should handle such errors correctly and not lead to critical failures.
>>> "
>>>
>>> If a significant kvmalloc operation is performed with the NOFAIL flag, it risks
>>> reverting the fix intended to address the OOM-killer issue in commit
>>> dd544141b9eb.
>>> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?
>>
>> IMO, if we encounter this issue, it should be fixed by the
>> caller, not here.
> 
> I agree. but could we WARN_ON a large kvmalloc(NOFAIL) allocation?

For me, kvmalloc(~24k) sounds good to handle extreme cases (for extreme
compression), only specific users for file archiving (and fuzzers) are
expected to use this configuration.

Anyway, it's just my own ideas.

Thanks,
Gao Xiang

> 
>>>
>>
>>>
>>> Thanks
>>> Barry
>>
>> --
>>
>> Best Regards,
>> Hailong.


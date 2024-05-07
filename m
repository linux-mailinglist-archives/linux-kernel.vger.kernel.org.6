Return-Path: <linux-kernel+bounces-171067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DB8BDF68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C198281F56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771F14EC49;
	Tue,  7 May 2024 10:08:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248F2F2F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076496; cv=none; b=ssxeVLJkK/JMy0LpzVQrlhk/kbA3k5IIqHqNqpdZbkRxr+A42Jb3n9FfS5c023m+Dkf7+Y/JPUhu4yE6/hPBXwolUxi9NBnoHLJIpTZi/85Kev7dg0UzXrt7E2n10vfePMldtJRJ7DL0/R1jVn9B7biIeKoVkehrYsDceQxpqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076496; c=relaxed/simple;
	bh=mH+rnRpAmktSVvD6LdRGQDuv9wGU4kt3wjrnPZU0WRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjGf0sUQIr6yXFzVMCLl5km457hhUCdyXkkSsYGdj6OvbvNVkMRoQx6XMllvm02B/sq/1/JZkaVUYLfTdIaU5FMSXs5oXjve1AKDx8yJn1AnvBMjU1dz7iVD1PmB5vA/vikD0mpbmeeDHLrHSfnU0I1uPm4rCCN6dzawkAXTVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CEEA1063;
	Tue,  7 May 2024 03:08:40 -0700 (PDT)
Received: from [10.1.34.181] (unknown [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D32593F587;
	Tue,  7 May 2024 03:08:12 -0700 (PDT)
Message-ID: <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com>
Date: Tue, 7 May 2024 11:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ze Zuo <zuoze1@huawei.com>
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
 <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
 <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 09:25, Kefeng Wang wrote:
> Hi Ryan, Yang and all,
> 
> We see another regression on arm64(no issue on x86) when test memory
> latency from lmbench,
> 
> ./lat_mem_rd -P 1 512M 128

Do you know exectly what this test is doing?

> 
> memory latency(smaller is better)
> 
> MiB     6.9-rc7    6.9-rc7+revert

And what exactly have you reverted? I'm guessing just commit efa7df3e3bb5 ("mm:
align larger anonymous mappings on THP boundaries")?

> 0.00049    1.539     1.539
> 0.00098    1.539     1.539
> 0.00195    1.539     1.539
> 0.00293    1.539     1.539
> 0.00391    1.539     1.539
> 0.00586    1.539     1.539
> 0.00781    1.539     1.539
> 0.01172    1.539     1.539
> 0.01562    1.539     1.539
> 0.02344    1.539     1.539
> 0.03125    1.539     1.539
> 0.04688    1.539     1.539
> 0.0625    1.540     1.540
> 0.09375    3.634     3.086

So the first regression is for 96K - I'm guessing that's the mmap size? That
size shouldn't even be affected by this patch, apart from a few adds and a
compare which determines the size is too small to do PMD alignment for.

> 0.125   3.874     3.175
> 0.1875  3.544     3.288
> 0.25    3.556     3.461
> 0.375   3.641     3.644
> 0.5     4.125     3.851
> 0.75    4.968     4.323
> 1       5.143     4.686
> 1.5     5.309     4.957
> 2       5.370     5.116
> 3       5.430     5.471
> 4       5.457     5.671
> 6       6.100     6.170
> 8       6.496     6.468
> 
> -----------------------s
> * L1 cache = 8M, it is no big changes below 8M *
> * but the latency reduce a lot when revert this patch from L2 *
> 
> 12      6.917     6.840
> 16      7.268     7.077
> 24      7.536     7.345
> 32      10.723     9.421
> 48      14.220     11.350
> 64      16.253     12.189
> 96      14.494     12.507
> 128     14.630     12.560
> 192     15.402     12.967
> 256     16.178     12.957
> 384     15.177     13.346
> 512     15.235     13.233
> 
> After quickly check the smaps, but don't find any clues, any suggestion?

Without knowing exactly what the test does, it's difficult to know what to
suggest. If you want to try something semi-randomly; it might be useful to rule
out the arm64 contpte feature. I don't see how that would be interacting here if
mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disable with
ARM64_CONTPTE (needs EXPERT) at compile time.

> 
> Thanks.
> 
> On 2024/1/24 1:26, Ryan Roberts wrote:
>> On 23/01/2024 17:14, Yang Shi wrote:
>>> On Tue, Jan 23, 2024 at 1:41 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 22/01/2024 19:43, Yang Shi wrote:
>>>>> On Mon, Jan 22, 2024 at 3:37 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 20/01/2024 16:39, Matthew Wilcox wrote:
>>>>>>> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
>>>>>>>> However, after this patch, each allocation is in its own VMA, and there
>>>>>>>> is a 2M
>>>>>>>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slower
>>>>>>>> because there are so many VMAs to check to find a new 1G gap. 2) It
>>>>>>>> fails once
>>>>>>>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit then
>>>>>>>> causes a subsequent calloc() to fail, which causes the test to fail.
>>>>>>>>
>>>>>>>> Looking at the code, I think the problem is that arm64 selects
>>>>>>>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area()
>>>>>>>> allocates
>>>>>>>> len+2M then always aligns to the bottom of the discovered gap. That
>>>>>>>> causes the
>>>>>>>> 2M hole. As far as I can see, x86 allocates bottom up, so you don't get
>>>>>>>> a hole.
>>>>>>>
>>>>>>> As a quick hack, perhaps
>>>>>>> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>>>>>>> take-the-top-half
>>>>>>> #else
>>>>>>> current-take-bottom-half-code
>>>>>>> #endif
>>>>>>>
>>>>>>> ?
>>>>>
>>>>> Thanks for the suggestion. It makes sense to me. Doing the alignment
>>>>> needs to take into account this.
>>>>>
>>>>>>
>>>>>> There is a general problem though that there is a trade-off between abutting
>>>>>> VMAs, and aligning them to PMD boundaries. This patch has decided that in
>>>>>> general the latter is preferable. The case I'm hitting is special though, in
>>>>>> that both requirements could be achieved but currently are not.
>>>>>>
>>>>>> The below fixes it, but I feel like there should be some bitwise magic that
>>>>>> would give the correct answer without the conditional - but my head is
>>>>>> gone and
>>>>>> I can't see it. Any thoughts?
>>>>>
>>>>> Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
>>>>> the conditional either.
>>>>>
>>>>>>
>>>>>> Beyond this, though, there is also a latent bug where the offset provided to
>>>>>> mmap() is carried all the way through to the get_unmapped_area()
>>>>>> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
>>>>>> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for arches
>>>>>> that use the default get_unmapped_area(), any non-zero offset would not have
>>>>>> been used. But this change starts using it, which is incorrect. That said,
>>>>>> there
>>>>>> are some arches that override the default get_unmapped_area() and do use the
>>>>>> offset. So I'm not sure if this is a bug or a feature that user space can
>>>>>> pass
>>>>>> an arbitrary value to the implementation for anon memory??
>>>>>
>>>>> Thanks for noticing this. If I read the code correctly, the pgoff used
>>>>> by some arches to workaround VIPT caches, and it looks like it is for
>>>>> shared mapping only (just checked arm and mips). And I believe
>>>>> everybody assumes 0 should be used when doing anonymous mapping. The
>>>>> offset should have nothing to do with seeking proper unmapped virtual
>>>>> area. But the pgoff does make sense for file THP due to the alignment
>>>>> requirements. I think it should be zero'ed for anonymous mappings,
>>>>> like:
>>>>>
>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>> index 2ff79b1d1564..a9ed353ce627 100644
>>>>> --- a/mm/mmap.c
>>>>> +++ b/mm/mmap.c
>>>>> @@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
>>>>> long addr, unsigned long len,
>>>>>                  pgoff = 0;
>>>>>                  get_area = shmem_get_unmapped_area;
>>>>>          } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>>>>> +               pgoff = 0;
>>>>>                  /* Ensures that larger anonymous mappings are THP aligned. */
>>>>>                  get_area = thp_get_unmapped_area;
>>>>>          }
>>>>
>>>> I think it would be cleaner to just zero pgoff if file==NULL, then it covers
>>>> the
>>>> shared case, the THP case, and the non-THP case properly. I'll prepare a
>>>> separate patch for this.
>>>
>>> IIUC I don't think this is ok for those arches which have to
>>> workaround VIPT cache since MAP_ANONYMOUS | MAP_SHARED with NULL file
>>> pointer is a common case for creating tmpfs mapping. For example,
>>> arm's arch_get_unmapped_area() has:
>>>
>>> if (aliasing)
>>>          do_align = filp || (flags & MAP_SHARED);
>>>
>>> The pgoff is needed if do_align is true. So we should just zero pgoff
>>> iff !file && !MAP_SHARED like what my patch does, we can move the
>>> zeroing to a better place.
>>
>> We crossed streams - I sent out the patch just as you sent this. My patch is
>> implemented as I proposed.
>>
>> I'm not sure I agree with what you are saying. The mmap man page says this:
>>
>>    The  contents  of  a file mapping (as opposed to an anonymous mapping; see
>>    MAP_ANONYMOUS below), are initialized using length bytes starting at offset
>>    offset in the file (or other object) referred to by the file descriptor fd.
>>
>> So that implies offset is only relavent when a file is provided. It then goes on
>> to say:
>>
>>    MAP_ANONYMOUS
>>    The mapping is not backed by any file; its contents are initialized to zero.
>>    The fd argument is ignored; however, some implementations require fd to be -1
>>    if MAP_ANONYMOUS (or MAP_ANON) is specified, and portable applications should
>>    ensure this. The offset argument should be zero.
>>
>> So users are expected to pass offset=0 when mapping anon memory, for both shared
>> and private cases.
>>
>> Infact, in the line above where you made your proposed change, pgoff is also
>> being zeroed for the (!file && (flags & MAP_SHARED)) case.
>>
>>
>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Finally, the second test failure I reported (ksm_tests) is actually caused
>>>>>> by a
>>>>>> bug in the test code, but provoked by this change. So I'll send out a fix for
>>>>>> the test code separately.
>>>>>>
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 4f542444a91f..68ac54117c77 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struct
>>>>>> file *filp,
>>>>>>   {
>>>>>>          loff_t off_end = off + len;
>>>>>>          loff_t off_align = round_up(off, size);
>>>>>> -       unsigned long len_pad, ret;
>>>>>> +       unsigned long len_pad, ret, off_sub;
>>>>>>
>>>>>>          if (off_end <= off_align || (off_end - off_align) < size)
>>>>>>                  return 0;
>>>>>> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(struct
>>>>>> file *filp,
>>>>>>          if (ret == addr)
>>>>>>                  return addr;
>>>>>>
>>>>>> -       ret += (off - ret) & (size - 1);
>>>>>> +       off_sub = (off - ret) & (size - 1);
>>>>>> +
>>>>>> +       if (current->mm->get_unmapped_area ==
>>>>>> arch_get_unmapped_area_topdown &&
>>>>>> +           !off_sub)
>>>>>> +               return ret + size;
>>>>>> +
>>>>>> +       ret += off_sub;
>>>>>>          return ret;
>>>>>>   }
>>>>>
>>>>> I didn't spot any problem, would you please come up with a formal patch?
>>>>
>>>> Yeah, I'll aim to post today.
>>>
>>> Thanks!
>>>
>>>>
>>>>
>>
>>



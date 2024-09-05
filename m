Return-Path: <linux-kernel+bounces-316851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661D96D635
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30644B22AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38793196446;
	Thu,  5 Sep 2024 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUv7EXdN"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB05194125
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532626; cv=none; b=pgjhqfmJnp/cfnwoS5rwHxv6j3/+c51B6Gu7JbOflHKLQoN874GXZiQrUfPscLa66bqRa4M68qM9joOj8qUOB+eLShxs/7dJl2DrvpAByUJamdjNspM+xnyOLdEWJ9XGIvCy0fbY6uA1sVfSNS46RGwcQxz0cZDmyQGYHk+IiCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532626; c=relaxed/simple;
	bh=fBvM/USdz5m8lsdm097fxXumAyf4eAz9ESmBTneOMp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF67RhAKtoSjSvRVy8rk5avvI/ZZ9eSQ69NfQm0+qoi96s9OH8BULHe9ziqTwNOqV/x4O8UKssUsK7Ei4mXmfffQwA3t1gikLV5R/JECJ7iSPgzk9jevM3TOoMtbaBnuW+ku81LdG0TlECnU0pYA4t8xqR+3OHx7qPX8FJCSado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUv7EXdN; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8695cc91c8so80001566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725532623; x=1726137423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUORu/jqoGKPwKhVnK7PLu247h5guV9J5aj50WxnErg=;
        b=fUv7EXdNK0cB2ykpQzJGTJy4wNYoIA+L3sorCXAsQYbROKzfJkFYtXaD/JxlMstdYg
         5aBZV4rIK4+VXrhvnpvCMpF6qWgUgnSirWTB88ETzFVY8tNCusMh3zJeB3sDd46kW+W4
         e4hzc6R0/5E4+qy3CQL9wYZCyCVTAEkf+5JnvUF0tSAFEkR/FqpHFkQJKTp5+UjDdCqU
         vwiCTwTZHnUYIbZUt0a9rI3EV8QxMdikpgtdSn4rmif4Xo9Q08UVIxGaU9cyk4ehMyRo
         yz00SIKHWN1fCZmlm0yxy8oQ1tnyrrTqUgjVf3sEnooVGfv2iQChJsL9TG95C1iMjU9T
         derw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532623; x=1726137423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUORu/jqoGKPwKhVnK7PLu247h5guV9J5aj50WxnErg=;
        b=JxPX/SzHXXXn31OSvnibBxQR+jYkBwfR9Y9Hk3jvsLshb7ItqP6ej1D4wjo1bMv0Bh
         oLWyMkS6vjhtAJH/cJGPFbRuvTZJnSl+1QgB0RpRW3JpVXu4feib4M8jS1cmjztA1n5i
         OCDhAN/NU5wULhVMpELWMkvP7NVmUBVIzwPN43mGUA7kc9AVcmErqauhm7okoRK7zrId
         h8v3FBZ6coxb0gvznZScvTxemdcny9u0iOKg02eOq50YoUOZHas4KoK9AyVo15/CypN2
         mlKQEpsR32Z9loiyv2IK9p9tEtvc6DOq/gccDsy/r3NDJ3SGtypO14mjNVVLLPtshWv0
         g2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj2gZGEOCPQV3q4IfrbBdrsYUV3YPTZO/s8kPRRYixvuze3nn15K/ayYHvaM1IdYBSxuThtAsZCVjJHA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/m643ejnuoPThglZH92fWpVetWVh4h1KuzWg4pyW2Tokp2LQ
	te2XcV6xpc6h3p6vj0HyiABMKU8LR0NErelN5Gvw9wcA8eJ7sqGr
X-Google-Smtp-Source: AGHT+IHd718s6Q4+33HKUDRVZO02S1SHFvi5QxUyKe6gJ1pbw54ABPxN7a9BPOu+q85JhAO/UdS4RQ==
X-Received: by 2002:a17:907:1c0a:b0:a7a:ab8a:380 with SMTP id a640c23a62f3a-a897fad872amr1930715066b.69.1725532621667;
        Thu, 05 Sep 2024 03:37:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:decd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e286dsm117164466b.211.2024.09.05.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:37:01 -0700 (PDT)
Message-ID: <ccbe7ec4-1a27-40d7-88dd-b2299e96a558@gmail.com>
Date: Thu, 5 Sep 2024 11:37:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
 shakeel.butt@linux.dev, willy@infradead.org, ying.huang@intel.com,
 hanchuanhua@oppo.com
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com>
 <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2024 11:10, Barry Song wrote:
> On Thu, Sep 5, 2024 at 8:49 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> On Thu, Sep 5, 2024 at 7:55 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>
>>> On Thu, Sep 5, 2024 at 12:03 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> On Thu, Sep 5, 2024 at 5:41 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>
>>>>> [..]
>>>>>>> I understand the point of doing this to unblock the synchronous large
>>>>>>> folio swapin support work, but at some point we're gonna have to
>>>>>>> actually handle the cases where a large folio being swapped in is
>>>>>>> partially in the swap cache, zswap, the zeromap, etc.
>>>>>>>
>>>>>>> All these cases will need similar-ish handling, and I suspect we won't
>>>>>>> just skip swapping in large folios in all these cases.
>>>>>>
>>>>>> I agree that this is definitely the goal. `swap_read_folio()` should be a
>>>>>> dependable API that always returns reliable data, regardless of whether
>>>>>> `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-in shouldn't
>>>>>> be held back. Significant efforts are underway to support large folios in
>>>>>> `zswap`, and progress is being made. Not to mention we've already allowed
>>>>>> `zeromap` to proceed, even though it doesn't support large folios.
>>>>>>
>>>>>> It's genuinely unfair to let the lack of mTHP support in `zeromap` and
>>>>>> `zswap` hold swap-in hostage.
>>>>>
>>>>
>>>> Hi Yosry,
>>>>
>>>>> Well, two points here:
>>>>>
>>>>> 1. I did not say that we should block the synchronous mTHP swapin work
>>>>> for this :) I said the next item on the TODO list for mTHP swapin
>>>>> support should be handling these cases.
>>>>
>>>> Thanks for your clarification!
>>>>
>>>>>
>>>>> 2. I think two things are getting conflated here. Zswap needs to
>>>>> support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What is
>>>>> truly, and is outside the scope of zswap/zeromap, is being able to
>>>>> support hybrid mTHP swapin.
>>>>>
>>>>> When swapping in an mTHP, the swapped entries can be on disk, in the
>>>>> swapcache, in zswap, or in the zeromap. Even if all these things
>>>>> support mTHPs individually, we essentially need support to form an
>>>>> mTHP from swap entries in different backends. That's what I meant.
>>>>> Actually if we have that, we may not really need mTHP swapin support
>>>>> in zswap, because we can just form the large folio in the swap layer
>>>>> from multiple zswap entries.
>>>>>
>>>>
>>>> After further consideration, I've actually started to disagree with the idea
>>>> of supporting hybrid swapin (forming an mTHP from swap entries in different
>>>> backends). My reasoning is as follows:
>>>
>>> I do not have any data about this, so you could very well be right
>>> here. Handling hybrid swapin could be simply falling back to the
>>> smallest order we can swapin from a single backend. We can at least
>>> start with this, and collect data about how many mTHP swapins fallback
>>> due to hybrid backends. This way we only take the complexity if
>>> needed.
>>>
>>> I did imagine though that it's possible for two virtually contiguous
>>> folios to be swapped out to contiguous swap entries and end up in
>>> different media (e.g. if only one of them is zero-filled). I am not
>>> sure how rare it would be in practice.
>>>
>>>>
>>>> 1. The scenario where an mTHP is partially zeromap, partially zswap, etc.,
>>>> would be an extremely rare case, as long as we're swapping out the mTHP as
>>>> a whole and all the modules are handling it accordingly. It's highly
>>>> unlikely to form this mix of zeromap, zswap, and swapcache unless the
>>>> contiguous VMA virtual address happens to get some small folios with
>>>> aligned and contiguous swap slots. Even then, they would need to be
>>>> partially zeromap and partially non-zeromap, zswap, etc.
>>>
>>> As I mentioned, we can start simple and collect data for this. If it's
>>> rare and we don't need to handle it, that's good.
>>>
>>>>
>>>> As you mentioned, zeromap handles mTHP as a whole during swapping
>>>> out, marking all subpages of the entire mTHP as zeromap rather than just
>>>> a subset of them.
>>>>
>>>> And swap-in can also entirely map a swapcache which is a large folio based
>>>> on our previous patchset which has been in mainline:
>>>> "mm: swap: entirely map large folios found in swapcache"
>>>> https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.com/
>>>>
>>>> It seems the only thing we're missing is zswap support for mTHP.
>>>
>>> It is still possible for two virtually contiguous folios to be swapped
>>> out to contiguous swap entries. It is also possible that a large folio
>>> is swapped out as a whole, then only a part of it is swapped in later
>>> due to memory pressure. If that part is later reclaimed again and gets
>>> added to the swapcache, we can run into the hybrid swapin situation.
>>> There may be other scenarios as well, I did not think this through.
>>>
>>>>
>>>> 2. Implementing hybrid swap-in would be extremely tricky and could disrupt
>>>> several software layers. I can share some pseudo code below:
>>>
>>> Yeah it definitely would be complex, so we need proper justification for it.
>>>
>>>>
>>>> swap_read_folio()
>>>> {
>>>>        if (zeromap_full)
>>>>                folio_read_from_zeromap()
>>>>        else if (zswap_map_full)
>>>>               folio_read_from_zswap()
>>>>        else {
>>>>               folio_read_from_swapfile()
>>>>               if (zeromap_partial)
>>>>                        folio_read_from_zeromap_fixup()  /* fill zero
>>>> for partially zeromap subpages */
>>>>               if (zwap_partial)
>>>>                        folio_read_from_zswap_fixup()  /* zswap_load
>>>> for partially zswap-mapped subpages */
>>>>
>>>>                folio_mark_uptodate()
>>>>                folio_unlock()
>>>> }
>>>>
>>>> We'd also need to modify folio_read_from_swapfile() to skip
>>>> folio_mark_uptodate()
>>>> and folio_unlock() after completing the BIO. This approach seems to
>>>> entirely disrupt
>>>> the software layers.
>>>>
>>>> This could also lead to unnecessary IO operations for subpages that
>>>> require fixup.
>>>> Since such cases are quite rare, I believe the added complexity isn't worth it.
>>>>
>>>> My point is that we should simply check that all PTEs have consistent zeromap,
>>>> zswap, and swapcache statuses before proceeding, otherwise fall back to the next
>>>> lower order if needed. This approach improves performance and avoids complex
>>>> corner cases.
>>>
>>> Agree that we should start with that, although we should probably
>>> fallback to the largest order we can swapin from a single backend,
>>> rather than the next lower order.
>>>
>>>>
>>>> So once zswap mTHP is there, I would also expect an API similar to
>>>> swap_zeromap_entries_check()
>>>> for example:
>>>> zswap_entries_check(entry, nr) which can return if we are having
>>>> full, non, and partial zswap to replace the existing
>>>> zswap_never_enabled().
>>>
>>> I think a better API would be similar to what Usama had. Basically
>>> take in (entry, nr) and return how much of it is in zswap starting at
>>> entry, so that we can decide the swapin order.
>>>
>>> Maybe we can adjust your proposed swap_zeromap_entries_check() as well
>>> to do that? Basically return the number of swap entries in the zeromap
>>> starting at 'entry'. If 'entry' itself is not in the zeromap we return
>>> 0 naturally. That would be a small adjustment/fix over what Usama had,
>>> but implementing it with bitmap operations like you did would be
>>> better.
>>
>> I assume you means the below
>>
>> /*
>>  * Return the number of contiguous zeromap entries started from entry
>>  */
>> static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
>> {
>>         struct swap_info_struct *sis = swp_swap_info(entry);
>>         unsigned long start = swp_offset(entry);
>>         unsigned long end = start + nr;
>>         unsigned long idx;
>>
>>         idx = find_next_bit(sis->zeromap, end, start);
>>         if (idx != start)
>>                 return 0;
>>
>>         return find_next_zero_bit(sis->zeromap, end, start) - idx;
>> }
>>
>> If yes, I really like this idea.
>>
>> It seems much better than using an enum, which would require adding a new
>> data structure :-) Additionally, returning the number allows callers
>> to fall back
>> to the largest possible order, rather than trying next lower orders
>> sequentially.
> 
> No, returning 0 after only checking first entry would still reintroduce
> the current bug, where the start entry is zeromap but other entries
> might not be. We need another value to indicate whether the entries
> are consistent if we want to avoid the enum:
> 
> /*
>  * Return the number of contiguous zeromap entries started from entry;
>  * If all entries have consistent zeromap, *consistent will be true;
>  * otherwise, false;
>  */
> static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry,
>                 int nr, bool *consistent)
> {
>         struct swap_info_struct *sis = swp_swap_info(entry);
>         unsigned long start = swp_offset(entry);
>         unsigned long end = start + nr;
>         unsigned long s_idx, c_idx;
> 
>         s_idx = find_next_bit(sis->zeromap, end, start);

In all of the implementations you sent, you are using find_next_bit(..,end, start), but
I believe it should be find_next_bit(..,nr, start)?

TBH, I liked the enum implementation you had in https://lore.kernel.org/all/20240905002926.1055-1-21cnbao@gmail.com/
Its the easiest to review and understand, and least likely to introduce any bugs.
But it could be a personal preference.
The likelihood of having contiguous zeromap entries *that* is less than nr is very low right?
If so we could go with the enum implementation?


>         if (s_idx == end) {
>                 *consistent = true;
>                 return 0;
>         }
> 
>         c_idx = find_next_zero_bit(sis->zeromap, end, start);
>         if (c_idx == end) {
>                 *consistent = true;
>                 return nr;
>         }
> 
>         *consistent = false;
>         if (s_idx == start)
>                 return 0;
>         return c_idx - s_idx;
> }
> 
> I can actually switch the places of the "consistent" and returned
> number if that looks
> better.
> 
>>
>> Hi Usama,
>> what is your take on this?
>>
>>>
>>>>
>>>> Though I am not sure how cheap zswap can implement it,
>>>> swap_zeromap_entries_check()
>>>> could be two simple bit operations:
>>>>
>>>> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_t
>>>> entry, int nr)
>>>> +{
>>>> +       struct swap_info_struct *sis = swp_swap_info(entry);
>>>> +       unsigned long start = swp_offset(entry);
>>>> +       unsigned long end = start + nr;
>>>> +
>>>> +       if (find_next_bit(sis->zeromap, end, start) == end)
>>>> +               return SWAP_ZEROMAP_NON;
>>>> +       if (find_next_zero_bit(sis->zeromap, end, start) == end)
>>>> +               return SWAP_ZEROMAP_FULL;
>>>> +
>>>> +       return SWAP_ZEROMAP_PARTIAL;
>>>> +}
>>>>
>>>> 3. swapcache is different from zeromap and zswap. Swapcache indicates
>>>> that the memory
>>>> is still available and should be re-mapped rather than allocating a
>>>> new folio. Our previous
>>>> patchset has implemented a full re-map of an mTHP in do_swap_page() as mentioned
>>>> in 1.
>>>>
>>>> For the same reason as point 1, partial swapcache is a rare edge case.
>>>> Not re-mapping it
>>>> and instead allocating a new folio would add significant complexity.
>>>>
>>>>>>
>>>>>> Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeromap`, we
>>>>>> permit almost all mTHP swap-ins, except for those rare situations where
>>>>>> small folios that were swapped out happen to have contiguous and aligned
>>>>>> swap slots.
>>>>>>
>>>>>> swapcache is another quite different story, since our user scenarios begin from
>>>>>> the simplest sync io on mobile phones, we don't quite care about swapcache.
>>>>>
>>>>> Right. The reason I bring this up is as I mentioned above, there is a
>>>>> common problem of forming large folios from different sources, which
>>>>> includes the swap cache. The fact that synchronous swapin does not use
>>>>> the swapcache was a happy coincidence for you, as you can add support
>>>>> mTHP swapins without handling this case yet ;)
>>>>
>>>> As I mentioned above, I'd really rather filter out those corner cases
>>>> than support
>>>> them, not just for the current situation to unlock swap-in series :-)
>>>
>>> If they are indeed corner cases, then I definitely agree.
>>
>> Thanks
>> Barry



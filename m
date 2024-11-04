Return-Path: <linux-kernel+bounces-395573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EF9BBFF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3D51C218C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0451FCC63;
	Mon,  4 Nov 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAK73Xg4"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DE1FCC56
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755447; cv=none; b=Tf7+IcBj+9cWtNsLSCFDQlt6dKgzRhtAoQNS+8yKWcgsrdErDf67k3tr1bOYGG13QHx9/v5CeeOhElPTciwfgOeKiz3HFyQ8+qnk8dj9QI4oEJF9vMAreqNdDMD8uXdHmaE+UiciV9EKiDk4f08uEtD+umcCO8baPH3LELhKF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755447; c=relaxed/simple;
	bh=T4JaBfS/7QNEWz/7/vyx2x9vMuzg6nsLyg9CA96NUkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RC0Y+PcPwWbHe8C2lePX+o6qEWpCRx3k4VszSo7hP9cIHiGEhbDCxGiBRv+Oh6Goh5nVgU/6yuLhcF9XTwNNRJHaxlIY8kNiTyTfRywezaG5pP/3Mj51X8zcMB4TNdZkFJr7Zm6kYu7EmRWIKaAdBDCu6kOQxm/FCqw/kBM8ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAK73Xg4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso4002937f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755444; x=1731360244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/2yu7UvclEjFD80MpaPkf/0nw6X3u5y/74H0s6nPtE=;
        b=bAK73Xg4RKAsd8pmj0I6dNOHojLCdqRnasL8q2uz56HvablBN8ATHMr9QTMhv+as+0
         w+TBld5IEwUpoNFUvJDy7v7S+33PdhRbzHswaTbU+9YegequHykdqaLhoN75YK57XvM9
         KaQ6VyfEh2mfVPCLg/oG4aijuqjz4JMd8d3uMdwc5GAKuwOcTGHIenLxtHQlOmCf3Orp
         5zDYcNj8yOrKqqVoeZXRyfa9UuulwOhWDq8KSLzvEqx2LiiqzUBGWg6bz9RZjZQ5xjeU
         PF0WoZQ5PhfpRIWldzgRElY6sJQOVp7ffP3GEfLnlIWN6B23sM8mCLapQ1BXmclZ7OxA
         8Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755444; x=1731360244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/2yu7UvclEjFD80MpaPkf/0nw6X3u5y/74H0s6nPtE=;
        b=kr1kOHlRZaPVvu9i+BR55uwS0LlithNcSAPN+bxqQxqJrbKmyt7ZMDgLMmyn4PWGw/
         AuJFPAsjTonYjTPYX6X4KWBF0lomo9QmbqoG1W8k4XwUtEuAcyVrcY6+JORpbXz2iueP
         YFZfdISGIrHT3EchYGf9USswjJ8naEKgOo6EEOXK0DLa65FPEaDIaqxWWSVu1IlHc6tV
         fF4r6iJl5SZ+PVpGeA3GS/aGB9WZM3kNtGKgws01F8tms4FNULwhMXtvmZHIqbR4G2yu
         CHn8TiQ3D2ak+Y2X3LWrA97cKm0m8c+lmgIzPATdwqbroZ6XV/gvvesFCum4f/XhBxsh
         uywA==
X-Forwarded-Encrypted: i=1; AJvYcCV0i6JkJ3A4jp9VR0iNtBNzh8Qq6Z9HtzBsh4DLKFsvhV69RpmwqaH9cNA5smwF3r8/3UY0MpCyWmVhTM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTK3iEJ01j+bDUrOJQhrTc/kIQhMq1qMjPPYt0YhhK/Da+W2x
	N4XRWzp/7ucXzQvUTKUwRq7JZ8LkLr9nZh271L0FD7G2B/O4N3BE
X-Google-Smtp-Source: AGHT+IEtoXGebHuHOKWu8sWKvgbachVIM1d0ifzwpPlcjVESbb9RWPN7ltg5rPUimEiiVmwZDqQ9Ug==
X-Received: by 2002:a5d:5847:0:b0:37d:4619:f975 with SMTP id ffacd0b85a97d-381c7a5d351mr16267861f8f.19.1730755443715;
        Mon, 04 Nov 2024 13:24:03 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40casm14211218f8f.27.2024.11.04.13.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:24:03 -0800 (PST)
Message-ID: <79deed1a-9b0e-42e0-be2f-f0c3ef5fee11@gmail.com>
Date: Mon, 4 Nov 2024 21:24:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
 <20241104163402.GA810664@cmpxchg.org>
 <c9c5bea0-7542-4587-9d02-0dc25574c548@redhat.com>
 <3ac28c1a-44d4-4b10-966e-0907df716da0@gmail.com>
 <410abcf1-d43c-4368-b217-4ff894903440@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <410abcf1-d43c-4368-b217-4ff894903440@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/2024 20:56, David Hildenbrand wrote:
> On 04.11.24 19:48, Usama Arif wrote:
>>
>>
>> On 04/11/2024 17:10, David Hildenbrand wrote:
>>> On 04.11.24 17:34, Johannes Weiner wrote:
>>>> On Mon, Nov 04, 2024 at 01:42:08PM +0100, David Hildenbrand wrote:
>>>>> On 02.11.24 11:12, Barry Song wrote:
>>>>>> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
>>>>>>           pglazyfreed (npn)
>>>>>>             Amount of reclaimed lazyfree pages
>>>>>>     +      swpin_zero
>>>>>> +        Number of pages moved into memory with zero content, meaning no
>>>>>> +        copy exists in the backend swapfile, allowing swap-in to avoid
>>>>>> +        I/O read overhead.
>>>>>> +
>>>>>> +      swpout_zero
>>>>>> +        Number of pages moved out of memory with zero content, meaning no
>>>>>> +        copy is needed in the backend swapfile, allowing swap-out to avoid
>>>>>> +        I/O write overhead.
>>>>>
>>>>> Hm, can make it a bit clearer that this is a pure optimization and refer
>>>>> to the other counters?
>>>>>
>>>>> swpin_zero
>>>>>      Portion of "pswpin" pages for which I/O was optimized out
>>>>>      because the page content was detected to be zero during swapout.
>>>>
>>>> AFAICS the zeropages currently don't show up in pswpin/pswpout, so
>>>> these are independent counters, not subsets.
>>>
>>> Ah. now I understand the problem. The whole "move out of memory" "move into memory" here is quite confusing TBH. We're not moving anything, we're optimizing out the move completely ... yes, you could call it compression (below).
>>>
>>>>
>>>> I'm leaning towards Barry's side on the fixes tag.
>>>
>>> I think the documentation when to use the Fixes: tag is pretty clear.
>>>
>>> Introducing new counters can hardly be considered a bugfix. Missing to adjust some counters that *existing tools* would know/use might be  IMO (below).
>>>
>>>>   When zswap handled
>>>> the same-filled pages, we would count them in zswpin/out. From a user
>>>> POV, especially one using zswap, the behavior didn't change, but the
>>>> counts giving insight into this (potentially significant) VM activity
>>>> disappeared. This is arguably a regression.
>>>>>> swpout_zero
>>>>>      Portion of "pswout" pages for which I/O was optimized out
>>>>>      because the page content was detected to be zero.
>>>>
>>>> Are we sure we want to commit to the "zero" in the name here? Until
>>>> very recently, zswap optimized all same-filled pages. It's possible
>>>> somebody might want to bring that back down the line.
>>>
>>> Agreed.
>>>
>>>>
>>>> In reference to the above, I'd actually prefer putting them back into
>>>> zswpin/zswpout. Sure, they're not handled by zswap.c proper, but this
>>>> is arguably just an implementation detail; from a user POV this is
>>>> still just (a form of) compression in lieu of IO to the swap backend.
>>>>
>>>> IMO there is no need for coming up with a separate category. Just add
>>>> them to zswpin/zswpout and remove the CONFIG_ZSWAP guards from them?
>>>
>>
>> hmm, I actually don't like the idea of using zswpin/zswpout. Its a
>> bit confusing if zswap is disabled and zswap counters are incrementing?
>>
>> Also, it means that when zswap is enabled, you won't be able to distinguish
>> between zswap and zeropage optimization.
> 
> Does it matter? Because in the past the same would have happened, no (back when this was done in zswap code)?
> 

When it was in zswap code, there was zswap_same_filled_pages stat as well to see
how many zero-filled pages were part of zswap. (Not the same as counter, but you
could still get a good idea about same filled page usage).

The other thing is it affects zram as well..

Maybe We could have a hybrid approach?
i.e. have the zswpin/zswpout counter incremented at zero filled pages as suggested,
but then also have a zero_swapped stat that tells how much of the zeromap is 
currently set (similar to zswapped).



Return-Path: <linux-kernel+bounces-395403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17F9BBD7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099A61C21762
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FC51CACE5;
	Mon,  4 Nov 2024 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpQHRsJy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830251C07DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746127; cv=none; b=oUOl4NdVTKPAUBL6Hx4O6Dr1A+RSp55gTLTpOmFqMoktdP5JU96H3uve998a4d1k08/h0JwVdB9u26Yhbks2JzNUpn6zHtIw6uvuiJz7gdFD6wraVytMw9AYEVvubsJsVz0Vt+KaW0B7Z05m6G6PSHBWOkrFB2miIotgc1d+pvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746127; c=relaxed/simple;
	bh=FSwGp8al57Wusy2EPtMojmX4ZarlPLD0U+4J++rlup4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+zS1mxVLwG8bNFHR/EqkjjotMGgj2bayjPr1+sfma9vctgveTHhew5eDZG8YRRWFEP62nZrcHxD//Jzx+4NzBISUnv2s1Jh+e5oxj2ROXehBgiYCaDe7lm4gd9hezbkXV0BSmleSbfFBP+6y0YCRgP4JhTL9eFskU9ynSm1Ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpQHRsJy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a68480164so717851566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730746124; x=1731350924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1grBaj9tmVZjme5LsYUeCJ8WPXc1t/fLGncF4nFHtc=;
        b=LpQHRsJy1wUiE1gcDuhJ3d+Ah8SrGKjyXjN6m3XlGPDD/7vE+4T0b4efQgoEh0ma1b
         WiG1GFdJZhoiQ28UJbxT6AQzZ5dp6aUePCFEikzHhmQhbOOUu1SyEozJQ7n3Q+R6NNfm
         +Y4v4NMh9Bd86lVdVu7+YKNUTdXZOxLJaeF83u74wFzNMc3nnxSwe8c6AdbbEv0q2kzo
         8seYSIh6Ag6xkiMcrVmx2b+eNq/EOZhRKQPNoD92xSbs5G0UCwcWch6IK4NzHqJQNzVY
         ICx9/aSuaOC7Xs84iDcI1Vh2b7c2S0owflG0AIHHXLDBT9DgDsfM4MEir0HWgXcNHDnU
         Va7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730746124; x=1731350924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1grBaj9tmVZjme5LsYUeCJ8WPXc1t/fLGncF4nFHtc=;
        b=vEPat6sZOaRQOqvWk/OWRGb+2ZHWU/L/51TdTzOYGRW3AZ1f+dsUZDpQheCNxUF//a
         wyTvkurXZr47g+j7XzvnNMoB0tLdLrhyFtog3LfGSjKWXHDgjZAt6ybXGFmTxKZzYCt0
         7dqwFySCh+4VPKIssPYW6M0ziSNt9RO32IxvA6MEMw6cjB3FTxxFJ/y4TsDsuKeX0o6I
         l2e/997lVrjOJ7oQlzVpbkO7EYxGTZrfgiC7pN7tFCkv9v1wamJecHrl2dIOO729HIhn
         v9AVQPyAhqJTSOp05VXgEK6EMzVg7ryNFFDRhkcv3mSEVEDiGd49KKix996vrn0EnPI6
         x28g==
X-Forwarded-Encrypted: i=1; AJvYcCU9v0DhWMvxcL1arU6SnCEd4xL58mBqD3j03DUOc2fZKwSvpHPuRsAmFtrVBJgsQxRdCG6WvorYm+//hCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDBYkiBlGCM8AqNDUQGWpSbXxGj0YdcJvC6vMobnEgdlT/60T
	UdZ/M/hcmNe3Va04G7BED9cWO0OsGItgJcxSzIX853p0uHOXnHO2
X-Google-Smtp-Source: AGHT+IHs3NQ88ui7RfqRgWZ4U1BVrC8/PJErJCqRk5UTyyA8xYwSVnWZom1uOI53L5D3IDTjbfaZEQ==
X-Received: by 2002:a17:907:8689:b0:a9a:188f:efd9 with SMTP id a640c23a62f3a-a9de5edcfdcmr3472433066b.29.1730746123361;
        Mon, 04 Nov 2024 10:48:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:76d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17d7328sm16184766b.129.2024.11.04.10.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 10:48:42 -0800 (PST)
Message-ID: <3ac28c1a-44d4-4b10-966e-0907df716da0@gmail.com>
Date: Mon, 4 Nov 2024 18:48:42 +0000
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
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <c7a90ccf-c1b1-480c-9f2a-88ef37c3d89e@redhat.com>
 <20241104163402.GA810664@cmpxchg.org>
 <c9c5bea0-7542-4587-9d02-0dc25574c548@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <c9c5bea0-7542-4587-9d02-0dc25574c548@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/2024 17:10, David Hildenbrand wrote:
> On 04.11.24 17:34, Johannes Weiner wrote:
>> On Mon, Nov 04, 2024 at 01:42:08PM +0100, David Hildenbrand wrote:
>>> On 02.11.24 11:12, Barry Song wrote:
>>>> @@ -1599,6 +1599,16 @@ The following nested keys are defined.
>>>>          pglazyfreed (npn)
>>>>            Amount of reclaimed lazyfree pages
>>>>    +      swpin_zero
>>>> +        Number of pages moved into memory with zero content, meaning no
>>>> +        copy exists in the backend swapfile, allowing swap-in to avoid
>>>> +        I/O read overhead.
>>>> +
>>>> +      swpout_zero
>>>> +        Number of pages moved out of memory with zero content, meaning no
>>>> +        copy is needed in the backend swapfile, allowing swap-out to avoid
>>>> +        I/O write overhead.
>>>
>>> Hm, can make it a bit clearer that this is a pure optimization and refer
>>> to the other counters?
>>>
>>> swpin_zero
>>>     Portion of "pswpin" pages for which I/O was optimized out
>>>     because the page content was detected to be zero during swapout.
>>
>> AFAICS the zeropages currently don't show up in pswpin/pswpout, so
>> these are independent counters, not subsets.
> 
> Ah. now I understand the problem. The whole "move out of memory" "move into memory" here is quite confusing TBH. We're not moving anything, we're optimizing out the move completely ... yes, you could call it compression (below).
> 
>>
>> I'm leaning towards Barry's side on the fixes tag.
> 
> I think the documentation when to use the Fixes: tag is pretty clear.
> 
> Introducing new counters can hardly be considered a bugfix. Missing to adjust some counters that *existing tools* would know/use might be  IMO (below).
> 
>>  When zswap handled
>> the same-filled pages, we would count them in zswpin/out. From a user
>> POV, especially one using zswap, the behavior didn't change, but the
>> counts giving insight into this (potentially significant) VM activity
>> disappeared. This is arguably a regression.
>> >> swpout_zero
>>>     Portion of "pswout" pages for which I/O was optimized out
>>>     because the page content was detected to be zero.
>>
>> Are we sure we want to commit to the "zero" in the name here? Until
>> very recently, zswap optimized all same-filled pages. It's possible
>> somebody might want to bring that back down the line.
> 
> Agreed.
> 
>>
>> In reference to the above, I'd actually prefer putting them back into
>> zswpin/zswpout. Sure, they're not handled by zswap.c proper, but this
>> is arguably just an implementation detail; from a user POV this is
>> still just (a form of) compression in lieu of IO to the swap backend.
>>
>> IMO there is no need for coming up with a separate category. Just add
>> them to zswpin/zswpout and remove the CONFIG_ZSWAP guards from them?
> 

hmm, I actually don't like the idea of using zswpin/zswpout. Its a
bit confusing if zswap is disabled and zswap counters are incrementing?

Also, it means that when zswap is enabled, you won't be able to distinguish
between zswap and zeropage optimization.

> Would work for me, although it might be a bit confusing if no zswap is configured. Maybe just needs to be documented.
> 



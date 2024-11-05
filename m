Return-Path: <linux-kernel+bounces-396281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2A9BCABD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCC8B225BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646A1D2B2A;
	Tue,  5 Nov 2024 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWZfEvjG"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F61D2B03
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803499; cv=none; b=tCGdxju37CdY4cSidiNypZcxrZT4OVIpUXqojdf79/4ZDG/z3rtStscSxq81j/HBIGB66Yqcgr22URRRLrS+L1TrWukZPdM077iAcZBgc7/9uWso/8AgzS/VPCiKdWJnMspbQnNHWilteSep+c3wRf0qvvOpy0E+qyOZQbUhAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803499; c=relaxed/simple;
	bh=ufOAYxGKiC3bjhA/e0mRcv8w8sjiLjO3uogea/3qHNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqKHZf4IgBSIioXTM4m4SOOhCGx1x8OlWdtNaRUgqL/70GuozBAVILwlE7WniFSQ90b+c2on+RxgeMGrO6RqtKOjxV2w5sH68Zu6e27pAVn6va06VvXskxEO8VIeYxyLEgm74rkMYOznu6xheSyd+XXFxG7MLsBue2owCfK4slQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWZfEvjG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so7515981a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730803496; x=1731408296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4rdU83y0/hJku5ReZd9jrrZkW+8qfyuFGOI6c1YskI=;
        b=DWZfEvjGSqAaQeSOp5u2NGqGJCE7ITgKJUok3TaosegIm7noz8Qi13QRIkLjyX7W4g
         aCQHLdMAfJktc/n19U8B4EMx/yYVQAKvTA+EufvqtYP2/t94XHXNvXfFGISxG5gG8jMX
         hHH5LIY27lhRSpnZp+0/Jx3L88SUdRio3qaEQje6iTYRS7sqBNxuELBAT5Wew1bNZ93P
         irPO/Ys1DleJp5J6U7SSSGMdmJThd4FQ1xhwZSkr2FwJ08AxFj1IBDmj9k+5yswO0X1b
         1LsU5mVKPX06GiZdBjewlFIe5zQKONKXtvft76varGVH8PmL3/C642ZGgFKuix4prYgs
         qf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803496; x=1731408296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4rdU83y0/hJku5ReZd9jrrZkW+8qfyuFGOI6c1YskI=;
        b=kaR6gWfFvPf3iOfsXpj98dUAW6rYG2j40fPp01E8GLto9Q3V9SEKbwmPx+HuVFcCbE
         NoHRE8vAncXjFGKXgacOmmonZ5rDvEzvNsfMiFUwNIhnYYqo7vaPF5bnhm3eFzBvcwDb
         E04xmMxtPN5nO2PlIvUN7SG9mZ4i0qplqG0kTCuLxgOxTDcaCJU3tTgOT9xgRgiEt3nT
         UR8DsGzPecMCQSfbDO9v9gxVWjmVhdPCQrZgvnjGWCsy4kymoC9SlorpGM6eh8sSLHxD
         p3IPA5MsKTDrsDngcbQ98TO0Yxon4WvW7uYNG+V8efRKlrNxPPw3Q9QjNEGgEgoRmxBq
         bVNA==
X-Forwarded-Encrypted: i=1; AJvYcCWHou50P9/RwyALhGJUuWTKBZRdOQ2xJAKy15GG0pgVabpuUboj9DtSW3akvGErNLQj0a0nCv85oDq5zeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDZxsRK6uqQrWqAmBfQyOYey7gX2iCc40L0WOsGyUF1PNML6h
	UUBPIbWf5DBsgjg1Q668rxleNGtZSs2/hdmzV28jABTHEqCQShqZ
X-Google-Smtp-Source: AGHT+IH7z8nVS3sO8gLWCgeiw+5r/u6WLQWs5v4XPjqhjv6BoX0tHqPso7RViFH9EBKKCBbHs3OBQg==
X-Received: by 2002:a17:906:da8b:b0:a9d:e01c:470c with SMTP id a640c23a62f3a-a9de5f36832mr3913434066b.39.1730803495969;
        Tue, 05 Nov 2024 02:44:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:efee])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb18140a6sm115057366b.195.2024.11.05.02.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:44:55 -0800 (PST)
Message-ID: <11bd51b2-fa2d-4d99-912a-563521aaa6da@gmail.com>
Date: Tue, 5 Nov 2024 10:44:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Andi Kleen <ak@linux.intel.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241102101240.35072-1-21cnbao@gmail.com>
 <6c14ab2c-7917-489b-b51e-401d208067f3@gmail.com>
 <CAGsJ_4wpdf6Fky7jj8O6OuLc0WTBjKXTfEqxE0cXiUjxxuLgZA@mail.gmail.com>
 <3f943f72-59d6-4124-96b2-e0bb8d7a5ebd@redhat.com>
 <20241104194024.0284288a28a71a70a3eab9b0@linux-foundation.org>
 <942f8355-4b23-4fd9-b00e-1121552d89ee@redhat.com>
 <CAGsJ_4yzq35ng77LjOi0jj0A6-9o+s5jKgP=S2Cx9fSsJtyzeA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGsJ_4yzq35ng77LjOi0jj0A6-9o+s5jKgP=S2Cx9fSsJtyzeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/11/2024 09:15, Barry Song wrote:
> On Tue, Nov 5, 2024 at 9:23 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.11.24 04:40, Andrew Morton wrote:
>>> On Mon, 4 Nov 2024 13:32:55 +0100 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>> As mentioned above, this isn't about fixing a bug; it's simply to ensure
>>>>> that swap-related metrics don't disappear.
>>>>
>>>> Documentation/process/submitting-patches.rst:
>>>>
>>>> "A Fixes: tag indicates that the patch fixes an issue in a previous
>>>> commit. It is used to make it easy to determine where a bug originated,
>>>> which can help review a bug fix."
>>>>
>>>> If there is no BUG, I'm afraid you are abusing that tag.
>>>
>>> I think the abuse is reasonable.  We have no Should-be-included-with:.
>>
>> A "Belongs-to:" might make sense, for this kind of stuff that is still
>> only in an RFC. Or we update the doc to explicitly spell out this
>> special case of using "Fixes" to sort out something into the RC.
>>
>> Because if this would be already in a released kernel, it would get a
>> bit trickier: stable rules explicitly spell out "fix a real bug".
>>
>>>
>>> 0ca0c24e3211 is only in 6.12-rcX so this is the time to make
>>> userspace-visible tweaks, so the 6.12 interfaces are the same as the
>>> 6.13+ interfaces (which is what I think is happening here?)
>>  > > And including the Fixes in this patch might be useful to someone who is
>>> backporting 0ca0c24e3211 into some earlier kernel for their own
>>> purposes.
>>
>> Just to be clear: adding new counters would hardly be fixing existing
>> tools that perform calculations based on existing counters. So we are
>> already changing the "userspace-visible" portion in some way, and I have
>> no idea what in vmstat we consider "stable".
>>
>> But I still don't think it's all that big of a deal except in some
>> handcrafted scenarios hardly anybody cares about; the cover letter is
>> also pretty clear on that.
> 
> I may have been mistaken in the cover letter. According to the zswap data Usama
> provided for servers, zero-filled pages accounted for about 1%.

10% not 1% (https://lore.kernel.org/all/20240612124750.2220726-1-usamaarif642@gmail.com/).

> So
> really doesn't
> matter too much, but I just checked with Hailong from our team—he has data
> on same-page-filled usage in Android apps, which on average show 3-4%
> same-page-filled, with over 85% being zero-filled. Some apps even reach
> 6-7% zero-filled pages. We previously used these counters to profile
> optimizations, but with zeromap now serving as the frontend for swap files,
> those counters will disappear entirely from both zRAM and pswpin/pswpout
> metrics, as folios are filtered earlier.
> 
This is what I meant in https://lore.kernel.org/all/79deed1a-9b0e-42e0-be2f-f0c3ef5fee11@gmail.com/
when I said it affects zram as well!

I am happy with the current version of the patch, just need the change
in Documentation/admin-guide/cgroup-v2.rst.

Thanks,
Usama

> Hailong essentially has a table that looks like the below which could be
> collected from the existing counters:
> 
> com.xxx.app     5% same-page-filled.    88% zero
> com.yyy.app     6% same-page-filled.     85% zero
> com.zzz.map   6.7 same-page-filled.       88% zero
> ....
> 
> Anyone on 6.12 will be unable to track zero-filled pages unless they
> backport this patch from a newer kernel version if it doesn’t make it
> into 6.12.
> 
> Whether it's marked as 'Belongs-to:' or 'Fixes:', I'd prefer we aim to
> land it in
> 6.12 :-)
> 
>>
>> So I'll shut up now and let people figure out the naming first, and if a
>> new counter is required at all :)
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>
> 
> Thanks
> Barry



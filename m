Return-Path: <linux-kernel+bounces-317741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EED96E31B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB891C230EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFBB18D656;
	Thu,  5 Sep 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAoZOyj4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0818037;
	Thu,  5 Sep 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564294; cv=none; b=siswqzN9Q0ag8IBUdPJSZVEw3SldBE5lmphEToKr/0hypJkpJYkv1kuDweRIAdKBexI4IzuoGrI4naWn9+8ySBdcnoEqedn8Zw/oE/ER4az9JReoNKTBbrliUa8rgtvc/HtFNDAUuPf7MVNgpPPh05QeN/Rf4fagiNU+lgOHk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564294; c=relaxed/simple;
	bh=rVqsUhOV9LZSBwXHthn2eX3X1YxvCMvvqNhKmkvsDQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYHVC+YqJgOdCb9/HKwaPq4UL3tYguUVo16Rt02pzD7JO3QrFT4yLdDT4JI1ZI3JD7Ebp1zBo7t9ShCNofZ5Idx/i3C9xkxBNjT7pqm4O+CjiVz1FxxBkkSWLkPkab3MkJc0NsQ5EmN140utCZECFN3eFAF4BSAcxTs4fmnJ1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAoZOyj4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so9052125e9.3;
        Thu, 05 Sep 2024 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725564291; x=1726169091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbVNl1AsNveIurDxg2UqvATkpgD+3xfOD/Vx+6xl1Ys=;
        b=YAoZOyj43BPJ8GqiWVaI+H7oR2xOrHfLbUoDPhyLuLO4XTr/+QI19VLIJH/fGnfSL1
         pQgakVOVICn+SvAOe7yRJ3nqTkpHheKEIJNwNmm4ENbicBMZO6EhWxmdNCKn72wHclFA
         kGMEgFdCADFClHcr7FZj4NeYLFmTqET+Ypz+FB6qLMgddMOxo3nfoCXaAgkyFRGufxBY
         h5yiceNILf9eVmaxQpqfYddhu/yj+xLFl8X0LckVv7mz+0fy8eJZQ3XiJ5SWU34KTO8n
         s11SoNjYzZ/OaZ81NLPpxI5n7mPT+xtkZOqz8+9q16aQROpMax1V+XHhv5WeXNoOUE+I
         KaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564291; x=1726169091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbVNl1AsNveIurDxg2UqvATkpgD+3xfOD/Vx+6xl1Ys=;
        b=Y5lVPjx90R9i+qVTfixuqidKrpEymgzCUVFrTWwVqRfdYxSgvT9cldY50SD22vSf3T
         Rz8oaiFNA/B/vPQhHFHtHw9bedYJ2x//z3B9fDxWNk1LnHBMW2wRfvdP5iknmE0mwB/1
         9HBrt9I37eSv3oYXsmvncl3zB77ob1oZLmoQrepj6/40nL2JzVVIFdkXTDYojVpzjez5
         00H/0u8sszZV7HQk+jXw8WWiJU1IVSDgB2cAxJpstWY3XMvreLNS9LZqyY5zVJMjMbiW
         bXjfH/WuJd8sY9EE65NLsWEuAWUJlV4UcJNfXAUWDA7wbMflwttWNrOZQGw3VP1zOtyo
         aUIw==
X-Forwarded-Encrypted: i=1; AJvYcCU99Q70+M7pIOjsZRxU8slRyDMrkYwpvm7ockrY2JRDbdrDBP0Ez9gZft3mo/lY2iVN1Js+2+Nhqr0=@vger.kernel.org, AJvYcCVDCQp5uv4HIZnjYN4E46EtDHrybSLdLdilWrQe/6Psq6dP5U5bx3ORuccHwZjqHibTrejgFZNeHcB77OBa@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlHVdPHmzk7lQpYlNFc1VlWTlfLXmw2KprZrWofczggxda6Uq
	rE+fRcuzvjo6r1Sy/7rz1W8F0AGAhZ+ZkZIxDzZJkpMRkhk/abTz
X-Google-Smtp-Source: AGHT+IHZa/rGu6zLqp1a+czg0eJcLBEk6NINPiW6JvwpJnLQEhN78I2SNiqDWkiUB3iGN4vbyXkRLA==
X-Received: by 2002:a5d:5244:0:b0:374:c1cc:2eb7 with SMTP id ffacd0b85a97d-374c1cc2f6cmr11980228f8f.35.1725564290600;
        Thu, 05 Sep 2024 12:24:50 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378885ee8bdsm228660f8f.68.2024.09.05.12.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 12:24:50 -0700 (PDT)
Message-ID: <25da676b-f87d-4cbc-8df7-93528c601d62@gmail.com>
Date: Thu, 5 Sep 2024 20:24:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] mm: free zapped tail pages when splitting isolated
 thp
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>,
 linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, roman.gushchin@linux.dev, david@redhat.com,
 npache@redhat.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Shuang Zhai <zhais@google.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
 <20240830100438.3623486-2-usamaarif642@gmail.com>
 <1d490ab5-5cf8-4c16-65d0-37a62999fcd5@google.com>
 <1ffdf94d-ce3f-4dac-8ed3-0681f98beebf@gmail.com>
 <5efa255b-3689-0c91-1980-c0f0562d84e9@google.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <5efa255b-3689-0c91-1980-c0f0562d84e9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2024 19:05, Hugh Dickins wrote:
> On Thu, 5 Sep 2024, Usama Arif wrote:
>> On 05/09/2024 09:46, Hugh Dickins wrote:
>>> On Fri, 30 Aug 2024, Usama Arif wrote:
>>>
>>>> From: Yu Zhao <yuzhao@google.com>
>>>>
>>>> If a tail page has only two references left, one inherited from the
>>>> isolation of its head and the other from lru_add_page_tail() which we
>>>> are about to drop, it means this tail page was concurrently zapped.
>>>> Then we can safely free it and save page reclaim or migration the
>>>> trouble of trying it.
>>>>
>>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>>> Tested-by: Shuang Zhai <zhais@google.com>
>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>
>>> I'm sorry, but I think this patch (just this 1/6) needs to be dropped:
>>> it is only an optimization, and unless a persuasive performance case
>>> can be made to extend it, it ought to go (perhaps revisited later).
>>>
>>
>> I am ok for patch 1 only to be dropped. Patches 2-6 are not dependent on it.
>>
>> Its an optimization and underused shrinker doesn't depend on it.
>> Its possible that folio->new_folio below might fix it? But if it doesn't,
>> I can retry later on to make this work and resend it only if it alone shows
>> a significant performance improvement.
>>
>> Thanks a lot for debugging this! and sorry it caused an issue.
>>
>>
>>> The problem I kept hitting was that all my work, requiring compaction and
>>> reclaim, got (killably) stuck in or repeatedly calling reclaim_throttle():
>>> because nr_isolated_anon had grown high - and remained high even when the
>>> load had all been killed.
>>>
>>> Bisection led to the 2/6 (remap to shared zeropage), but I'd say this 1/6
>>> is the one to blame. I was intending to send this patch to "fix" it:
>>>
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3295,6 +3295,8 @@ static void __split_huge_page(struct pag
>>>  			folio_clear_active(new_folio);
>>>  			folio_clear_unevictable(new_folio);
>>>  			list_del(&new_folio->lru);
>>> +			node_stat_sub_folio(folio, NR_ISOLATED_ANON +
>>> +						folio_is_file_lru(folio));
>>
>> Maybe this should have been below? (Notice the folio->new_folio)
>>
>> +			node_stat_sub_folio(new_folio, NR_ISOLATED_ANON +
>> +						folio_is_file_lru(new_folio));
> 
> Yes, how very stupid of me (I'm well aware of the earlier bugfixes here,
> and ought not to have done a blind copy and paste of those lines): thanks.
> 
> However... it makes no difference. I gave yours a run, expecting a
> much smaller negative number, but actually it works out much the same:
> because, of course, by this point in the code "folio" is left pointing
> to a small folio, and is almost equivalent to new_folio for the
> node_stat calculations.
> 
> (I say "almost" because I guess there's a chance that the page at
> folio got reused as part of a larger folio meanwhile, which would
> throw the stats off (if they weren't off already).)
> 
> So, even with your fix to my fix, this code doesn't work.
> Whereas a revert of this 1/6 does work: nr_isolated_anon and
> nr_isolated_file come to 0 when the system is at rest, as expected
> (and as silence from vmstat_refresh confirms - /proc/vmstat itself
> presents negative stats as 0, in order to hide transient oddities).
> 
> Hugh

Thanks for trying. I was hoping you had mTHPs enabled and then
the folio -> new_folio change would have fixed it.

Happy for patch 1 only to be dropped. I can try to figure it out
later and send if I can actually show any performance numbers
for the fixed version on real world cases.

Thanks,
Usama
> 
>>
>>>  			if (!folio_batch_add(&free_folios, new_folio)) {
>>>  				mem_cgroup_uncharge_folios(&free_folios);
>>>  				free_unref_folios(&free_folios);
>>>
>>> And that ran nicely, until I terminated the run and did
>>> grep nr_isolated /proc/sys/vm/stat_refresh /proc/vmstat
>>> at the end: stat_refresh kindly left a pr_warn in dmesg to say
>>> nr_isolated_anon -334013737
>>>
>>> My patch is not good enough. IIUC, some split_huge_pagers (reclaim?)
>>> know how many pages they isolated and decremented the stats by, and
>>> increment by that same number at the end; whereas other split_huge_pagers
>>> (migration?) decrement one by one as they go through the list afterwards.
>>>
>>> I've run out of time (I'm about to take a break): I gave up researching
>>> who needs what, and was already feeling this optimization does too much
>>> second guessing of what's needed (and its array of VM_WARN_ON_ONCE_FOLIOs
>>> rather admits to that).
>>>
>>> And I don't think it's as simple as moving the node_stat_sub_folio()
>>> into 2/6 where the zero pte is substituted: that would probably handle
>>> the vast majority of cases, but aren't there others which pass the
>>> folio_ref_freeze(new_folio, 2) test - the title's zapped tail pages,
>>> or racily truncated now that the folio has been unlocked, for example?
>>>
>>> Hugh



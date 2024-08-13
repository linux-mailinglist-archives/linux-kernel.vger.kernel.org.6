Return-Path: <linux-kernel+bounces-284623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6DD950336
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD866284FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C590196D8F;
	Tue, 13 Aug 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekNAEM5i"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6121345
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547077; cv=none; b=UZqfrtno9D06vMgFMslNXQSYK0I0XSpQ1XNaTmuwYjcZztmut3S1JhXcUS5qekUWQYMNt7a9jP7oA4PdVVhLkLoR2eXLbq8xLHHmtrt4cD9fFog3tEpWgEmMyZ+ulXkOJShcoGhGOqkW/hpTw420NrH8KarRN6q4IomKo6Y6tUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547077; c=relaxed/simple;
	bh=dDUMPKe3hATiQYMHoQUGPdmbTbp8c+DYTx3CaoyggoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxFNHZmIkx8zNIgonHhIjURS5FMXO3sFSdExL9C5XzU4hsXSOq4HEAkyr/ld2OeI3GiAfb1W9fFSxyjS/Jqu+GuaavhVX9Qm/ikAO3jMdBpx0/mOeh/0iFLTyvvnHWaKVGhAjngpe6WTO9urN5qFrSbeJGOSglCtNxRPlfMjCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekNAEM5i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36dd8a35722so1879169f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723547074; x=1724151874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRZJg0PF5C+Q/wLolSP2P0QFHIseDVqe88AMmYIa5J4=;
        b=ekNAEM5iS0YmYT2XL+v8Gk0kJSnonIyH1OflU5+6rh9HzetOzUMLGymKiNw+KqZIDj
         rtiIub583rSbRlcwtIbyiItsSeW/W209KP1/Vcn0yZSQ75sjmBjUa64tcs2kVS1Tj7wO
         +H7f6lvsj8iGGHiJnmpmQKhggfhrfry5cfaQTBE8TXZA7if3ORHVxEMUMwMlCvjtLkMj
         p+az8EfjXRYgSDAHtELPPQNfiUhE8b1Fz0NNcfaTdBLOza3OynRkUMhFsS5xkC3DKKWA
         es1YCnS0bDyDKIxxXT+yneFONeW68hElETkg6h3P9kubPjXAAWqORaRWv+AMi+iezJrn
         3nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723547074; x=1724151874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRZJg0PF5C+Q/wLolSP2P0QFHIseDVqe88AMmYIa5J4=;
        b=dEOpUoxQ0/Vikrj3RlaJ0AM/RTeddusm126ty7tm3GM0SQrORL6emlzeWJe665Ce0j
         C9cpB7DCuaVhRW06bIz+Bqbo8R86j2zGy+tcnNahIkxJmBKqWdk2yR3OOatsh9nrgYsn
         X+TsNZ+rLQFOTqctvMNIfr0nNRLgYcgY8rM6FHAJNS6V6wqTyU/rjXIfoD4E7zZdDHdC
         GOJHhiDmjL1S0z97Y4oZZcrusCgoz3IthTO8TsDEVHfOyo237E7a4mgdR6g95vvw8yET
         OQZngZIOQ21Y9Zscymn/HZQP9b2Sq0qp9Rv1ohn0Rrjzjiv67ebTZ3Ldfh1zHduD4jcl
         2GFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvECR/m/QTieRxa9L4H+QANZUu7AQMEodNwiTyF0eAO1q5294N1CWVgwc9pEgwt4JQAm9TIotNig5Pm4/IUnmD+O3rIajGcbQARLFS
X-Gm-Message-State: AOJu0YxnsKnsPNATwt3oRXo5GjfL22dLCR30MHgdkadmiq0TDTchDjD0
	4h2ik7uFIT7KFpBftv8PFWLZngiH8E6L0vTaAxImqhtrpxtfxZ2H
X-Google-Smtp-Source: AGHT+IEz839ACn+M9vUI6m6H0zHceIH7b/tAJn+ns5L4kLoKAUfv3y1iOdbbyqTyERxFRLCw45wb0A==
X-Received: by 2002:a05:6000:1284:b0:368:4d33:9aac with SMTP id ffacd0b85a97d-3716ccfa3f5mr2037742f8f.31.1723547073508;
        Tue, 13 Aug 2024 04:04:33 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938665sm9813034f8f.40.2024.08.13.04.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:04:33 -0700 (PDT)
Message-ID: <0702c85c-abca-4a33-b91b-dadf68670364@gmail.com>
Date: Tue, 13 Aug 2024 12:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>, Bharata B Rao <bharata@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>, leitao@debian.org
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
 <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/07/2024 06:58, Yu Zhao wrote:
> On Mon, Jul 8, 2024 at 10:31 PM Bharata B Rao <bharata@amd.com> wrote:
>>
>> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
>>> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>
>>>> Hi Yu Zhao,
>>>>
>>>> Thanks for your patches. See below...
>>>>
>>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>>>> Hi Bharata,
>>>>>
>>>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>>
>>>> <snip>
>>>>>>
>>>>>> Some experiments tried
>>>>>> ======================
>>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>>>
>>>>> This is not really an MGLRU issue -- can you please try one of the
>>>>> attached patches? It (truncate.patch) should help with or without
>>>>> MGLRU.
>>>>
>>>> With truncate.patch and default LRU scheme, a few hard lockups are seen.
>>>
>>> Thanks.
>>>
>>> In your original report, you said:
>>>
>>>    Most of the times the two contended locks are lruvec and
>>>    inode->i_lock spinlocks.
>>>    ...
>>>    Often times, the perf output at the time of the problem shows
>>>    heavy contention on lruvec spin lock. Similar contention is
>>>    also observed with inode i_lock (in clear_shadow_entry path)
>>>
>>> Based on this new report, does it mean the i_lock is not as contended,
>>> for the same path (truncation) you tested? If so, I'll post
>>> truncate.patch and add reported-by and tested-by you, unless you have
>>> objections.
>>
>> truncate.patch has been tested on two systems with default LRU scheme
>> and the lockup due to inode->i_lock hasn't been seen yet after 24 hours run.
> 
> Thanks.
> 
>>>
>>> The two paths below were contended on the LRU lock, but they already
>>> batch their operations. So I don't know what else we can do surgically
>>> to improve them.
>>
>> What has been seen with this workload is that the lruvec spinlock is
>> held for a long time from shrink_[active/inactive]_list path. In this
>> path, there is a case in isolate_lru_folios() where scanning of LRU
>> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
>> scanning/skipping of more than 150 million folios were seen. There is
>> already a comment in there which explains why nr_skipped shouldn't be
>> counted, but is there any possibility of re-looking at this condition?
> 
> For this specific case, probably this can help:
> 
> @@ -1659,8 +1659,15 @@ static unsigned long
> isolate_lru_folios(unsigned long nr_to_scan,
>                 if (folio_zonenum(folio) > sc->reclaim_idx ||
>                                 skip_cma(folio, sc)) {
>                         nr_skipped[folio_zonenum(folio)] += nr_pages;
> -                       move_to = &folios_skipped;
> -                       goto move;
> +                       list_move(&folio->lru, &folios_skipped);
> +                       if (spin_is_contended(&lruvec->lru_lock)) {
> +                               if (!list_empty(dst))
> +                                       break;
> +                               spin_unlock_irq(&lruvec->lru_lock);
> +                               cond_resched();
> +                               spin_lock_irq(&lruvec->lru_lock);
> +                       }
> +                       continue;
>                 }
> 

Hi Yu,

We are seeing lockups and high memory pressure in Meta production due to this lock contention as well. My colleague highlighted it in https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/ and was pointed to this fix.

We removed skip_cma check as a temporary measure, but this is a proper fix. I might have missed it but didn't see this as a patch on the mailing list. Just wanted to check if you were planning to send it as a patch? Happy to send it on your behalf as well.

Thanks


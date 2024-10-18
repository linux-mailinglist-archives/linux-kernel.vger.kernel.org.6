Return-Path: <linux-kernel+bounces-371574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E59A3CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B341F25D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99C200CA4;
	Fri, 18 Oct 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRBqZLji"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BD20403B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249489; cv=none; b=NUcOS1TL6BslQMInfo8aEnwuAZes6MbPspdhwThwesc/r84CUbPs9XDESDk+1rJfG2iJdcp8wMV15PgpJEj22wuKCIhTbyCTJ7DUX7W/NYwOY5dBuIzqVPwZLlOIAc9gqlbKikJQkNWzp6BFCl32xHvZ4vybk9YGrvqESL9E7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249489; c=relaxed/simple;
	bh=WppxXQv4JJMLQ6hSgSCQY/dM71RH4qkHILwYDL7NXJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gO7XChNZdo7MJZopqoaCVx+rbXB6tHtEoIsGuXUBKZLMe241ID4SswV5mNdd//dxpMrXDVJZFcK8mLS2Y41hq6uYQjBeSGTxVBwsGX3Xftd3j7Ulv6Ig6vbVUsY8ItCHG+wEWUYCqLLow0Gijgxln4dKUKu7zchSDZswfJx5EZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRBqZLji; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so12192555e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729249486; x=1729854286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNhaoaRhKrIF607df26klFatcehnnD14Q9wMSR2cO70=;
        b=LRBqZLjizhJlp+iJjaJIRKrrRAvi4C3NxDD/i72E8e2QLt6z1AEFVxT2MLhINXp7W0
         ZQd4V8ZDZJnFUOcV79XkbIGwT+lDYmkmCKeRFBzC/cJ6/6i3vOBAjee6B2Ede+K5tIoA
         Ff725+xmqohzAsAfIU8yP+a9G7P0i7lou+/mx6pWUN7iwfdJ7gKgb6Ps2A161AH0rbIn
         J03n44vJeXRH4NI0taKrNBqSHqB1dEmPe8HRJL6jGTDSylOESqeg/UPQXnl2UXQ6UX3O
         MtBYJ/EDozG9PE/aY0alFCROBI5g0TzMmFbkH77cMYi3mpqQnex47x7vY98GQ/OZ4+Q7
         zjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249486; x=1729854286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNhaoaRhKrIF607df26klFatcehnnD14Q9wMSR2cO70=;
        b=OLeLxs0973JoibCs8P1DryJysueB2Y6TzCcnV80fCVML6utCFb5XvO4EpjQc4Yj2kN
         em+T2UU3ab8dda24Z9h0Rj3Bv3NXau4DChfyGMhDLUaSRMPeg7MXR2CHPqYN1A21UoPZ
         UyM0CWUSohXEMyfxHuLRTKm58Bc457KB8ZfUpfOLtbJNDIwYUlReo12+se35lOSCT2hO
         T6GvVgDIRUohBHcCvFzhvalpuU/OhB9BvQsFAIg3kRI4zvAEFGL64pm8qEDzZR0BpBvq
         67ZqVOqYvgoA88R4Dkz5AfYhibZhrVzsaGj1wUzYeGkpymIV5U70XJXf+B33Gq4niJKX
         aKGA==
X-Forwarded-Encrypted: i=1; AJvYcCWIUhIeVqJoWWcJkUHJISYvuO4MLFy8wQ0OZh77g+oR/q0ozMhagpC9Er+imjYfIKCVXpLEr0OqaqA/VrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fv1Sp9bzAa776AZlq/pbLwdQUjulZ1Q5rjhDTvJONLnJF7EK
	mGDe3K4S64puyHtoakrcdu7qQsZ5AD2bOi8kDDhBJxhMEwm4YcnQ
X-Google-Smtp-Source: AGHT+IFigNDiYj/lNol/uMQcVkQ+uqcoMN9HliMxjSyZ7sbUd08wSWdHnrNRmXltTKvebhDKV0HMAA==
X-Received: by 2002:a05:600c:35d3:b0:431:5f9e:3f76 with SMTP id 5b1f17b1804b1-43161669464mr17026595e9.16.1729249485735;
        Fri, 18 Oct 2024 04:04:45 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606d58f9sm24522935e9.44.2024.10.18.04.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 04:04:45 -0700 (PDT)
Message-ID: <169e5cb6-701a-474c-a703-60daee8b4d3f@gmail.com>
Date: Fri, 18 Oct 2024 12:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/7] mm: do_swap_page() calls swapin_readahead()
 zswap load batching interface.
To: David Hildenbrand <david@redhat.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 bfoster@redhat.com, dchinner@redhat.com, chrisl@kernel.org
Cc: wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
 <20241018064805.336490-7-kanchana.p.sridhar@intel.com>
 <71bcbd3f-a8bd-4014-aabe-081006cc62f8@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <71bcbd3f-a8bd-4014-aabe-081006cc62f8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/10/2024 08:26, David Hildenbrand wrote:
> On 18.10.24 08:48, Kanchana P Sridhar wrote:
>> This patch invokes the swapin_readahead() based batching interface to
>> prefetch a batch of 4K folios for zswap load with batch decompressions
>> in parallel using IAA hardware. swapin_readahead() prefetches folios based
>> on vm.page-cluster and the usefulness of prior prefetches to the
>> workload. As folios are created in the swapcache and the readahead code
>> calls swap_read_folio() with a "zswap_batch" and a "non_zswap_batch", the
>> respective folio_batches get populated with the folios to be read.
>>
>> Finally, the swapin_readahead() procedures will call the newly added
>> process_ra_batch_of_same_type() which:
>>
>>   1) Reads all the non_zswap_batch folios sequentially by calling
>>      swap_read_folio().
>>   2) Calls swap_read_zswap_batch_unplug() with the zswap_batch which calls
>>      zswap_finish_load_batch() that finally decompresses each
>>      SWAP_CRYPTO_SUB_BATCH_SIZE sub-batch (i.e. upto 8 pages in a prefetch
>>      batch of say, 32 folios) in parallel with IAA.
>>
>> Within do_swap_page(), we try to benefit from batch decompressions in both
>> these scenarios:
>>
>>   1) single-mapped, SWP_SYNCHRONOUS_IO:
>>        We call swapin_readahead() with "single_mapped_path = true". This is
>>        done only in the !zswap_never_enabled() case.
>>   2) Shared and/or non-SWP_SYNCHRONOUS_IO folios:
>>        We call swapin_readahead() with "single_mapped_path = false".
>>
>> This will place folios in the swapcache: a design choice that handles cases
>> where a folio that is "single-mapped" in process 1 could be prefetched in
>> process 2; and handles highly contended server scenarios with stability.
>> There are checks added at the end of do_swap_page(), after the folio has
>> been successfully loaded, to detect if the single-mapped swapcache folio is
>> still single-mapped, and if so, folio_free_swap() is called on the folio.
>>
>> Within the swapin_readahead() functions, if single_mapped_path is true, and
>> either the platform does not have IAA, or, if the platform has IAA and the
>> user selects a software compressor for zswap (details of sysfs knob
>> follow), readahead/batching are skipped and the folio is loaded using
>> zswap_load().
>>
>> A new swap parameter "singlemapped_ra_enabled" (false by default) is added
>> for platforms that have IAA, zswap_load_batching_enabled() is true, and we
>> want to give the user the option to run experiments with IAA and with
>> software compressors for zswap (swap device is SWP_SYNCHRONOUS_IO):
>>
>> For IAA:
>>   echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled
>>
>> For software compressors:
>>   echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled
>>
>> If "singlemapped_ra_enabled" is set to false, swapin_readahead() will skip
>> prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO" do_swap_page()
>> path.
>>
>> Thanks Ying Huang for the really helpful brainstorming discussions on the
>> swap_read_folio() plug design.
>>
>> Suggested-by: Ying Huang <ying.huang@intel.com>
>> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>> ---
>>   mm/memory.c     | 187 +++++++++++++++++++++++++++++++++++++-----------
>>   mm/shmem.c      |   2 +-
>>   mm/swap.h       |  12 ++--
>>   mm/swap_state.c | 157 ++++++++++++++++++++++++++++++++++++----
>>   mm/swapfile.c   |   2 +-
>>   5 files changed, 299 insertions(+), 61 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index b5745b9ffdf7..9655b85fc243 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3924,6 +3924,42 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>>       return 0;
>>   }
>>   +/*
>> + * swapin readahead based batching interface for zswap batched loads using IAA:
>> + *
>> + * Should only be called for and if the faulting swap entry in do_swap_page
>> + * is single-mapped and SWP_SYNCHRONOUS_IO.
>> + *
>> + * Detect if the folio is in the swapcache, is still mapped to only this
>> + * process, and further, there are no additional references to this folio
>> + * (for e.g. if another process simultaneously readahead this swap entry
>> + * while this process was handling the page-fault, and got a pointer to the
>> + * folio allocated by this process in the swapcache), besides the references
>> + * that were obtained within __read_swap_cache_async() by this process that is
>> + * faulting in this single-mapped swap entry.
>> + */
> 
> How is this supposed to work for large folios?
> 

Hi,

I was looking at zswapin large folio support and have posted a RFC in [1].
I got bogged down with some prod stuff, so wasn't able to send it earlier.

It looks quite different, and I think simpler from this series, so might be
a good comparison.

[1] https://lore.kernel.org/all/20241018105026.2521366-1-usamaarif642@gmail.com/

Thanks,
Usama


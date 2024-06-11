Return-Path: <linux-kernel+bounces-209808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F85903B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DF42889E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504C17C212;
	Tue, 11 Jun 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH4VMQoF"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45E17B4E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106574; cv=none; b=DHuyGm05mskzL36xZcm7DFJgXFHeBoJJSk42nZgv9nSeJvX0YAa+bS0P0a/ynzLc2CLneQAFSL+ev9JvnwNR7s6izeUTYuPqKNkOlC0WdzhthQtV4g15XexQ2ODmcKnsFXxJxyY9iaOz9FL5V0L/WlTA6qS84rgmo5uG3jh5Ouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106574; c=relaxed/simple;
	bh=ewWyf1JfY3LyL1pjAMWp9/aI1mRNEwZhQAt+DO/D7YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+F8AKeZZphkl95sxVIDiyngwYZ5v3IfzINwYfluPPop17J1Tw2X86f4gH9TY3Zs//5+XTKl6V9SHR3A3hg0YExIT8PuQYFxMUCcIeX/F4xFZF7hkYxB1gNFo4a2GA2Ib8Myyy1ubyIid2geFfuTd6oT7qU59BYyfmoLt0e7vDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH4VMQoF; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797e2834c4eso32100385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718106571; x=1718711371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zM6sCCNyz3zbF+OseHVD84e8m7rxxZxvUuiGGqpJ9HQ=;
        b=AH4VMQoFmUKrPxx4iJHx/vNnFohEIlRvKIUKANIInLg4YoVpSiolPiyII2aS7FYELK
         GE0IAjLYPL3XTMT+7aoJ8oOG1xsWcfnLxiyndXQOOiyv585pb17APkMKKisYL/pRq9pS
         X9IzI5MBUSmMDYo7aDn4FUP4t0323KP7U3MZpBLDcRFcmNOBLISZPj0c6T6O54DOuBgK
         jd9s2RR1reEWnddfDENjXQ6KV9kNDh3pF10BhaCZOENIOU/8SAtLVpu0WcG5uyXg2zaM
         auUjMr619ZndkQeyAyGwbQp25sL8Xh6ImTyEVaYs1pw2JbddTf2g0Zecr9+v9Vyv80wT
         2lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106571; x=1718711371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM6sCCNyz3zbF+OseHVD84e8m7rxxZxvUuiGGqpJ9HQ=;
        b=hlUmEYXac5Lo+31GtWJmsJ9szOw8VC9eF0vG7KzvI84g88v4soxZpAcE8EbOjVOnHv
         dgrafIi2qpLZsXu7FkSLi4Alfyn27kJxxj1fc9QTrJkNuVG5MGYBwDjAzUKN6AkuNkyR
         PnTmuqlr2AnDN6hz3CN8cMq+ge7Bpl5EywvhqBYTw5hy2Pb8n4c9Ve+movBl1V7rtFgk
         9RrhnhpjmtMAn7D33N9EuYrTjXjPwnTd8pHGgLjA4wtgGJJN7z3ym9ww7GAzw9NfhPQM
         e/+cDbMGpqy4d4aPum3UocJdD9cYLW3uBL6UzN4at5XlD2+e9Pk8jkL+8N8ReR8NVS2B
         J5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS/IQ7eLtqJwL1HTjHQHy9uJeYtqPDHZCXS6f+3SPv0H6PoY3SDD8uZWqsxiT3QMEpyDSqVhvupbAGBqEDW9dZPPC4C3E3kBqJMkKb
X-Gm-Message-State: AOJu0Yx4rSng7LOVaA2m0RNfY4wV8L07Jo8PwB5mI9OWUTXr974BWDyG
	SDttTTESH9nXwCTt34om95My23JAZ1UO1VZl7egXuCo9H/jfFDon
X-Google-Smtp-Source: AGHT+IFuaZm4PTedWMppwN/psDVDjWpYw00uONK9hGyy3bG0MxfKy7XPv6flRcWLbA6h3RpenoRhkQ==
X-Received: by 2002:a05:620a:191a:b0:795:5de4:6625 with SMTP id af79cd13be357-797c2d6271emr434035585a.5.1718106571390;
        Tue, 11 Jun 2024 04:49:31 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:57b4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-797ee6619ddsm17525485a.99.2024.06.11.04.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 04:49:31 -0700 (PDT)
Message-ID: <9ddfe544-636d-4638-ae0e-053674e47322@gmail.com>
Date: Tue, 11 Jun 2024 12:49:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>, 21cnbao@gmail.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
 <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com>
 <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

@@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool 
synchronous,
>>>>                   psi_memstall_enter(&pflags);
>>>>           }
>>>>           delayacct_swapin_start();
>>>> -
>>>> -       if (zswap_load(folio)) {
>>>> +       if (swap_zeromap_folio_test(folio)) {
>>>> +               folio_zero_fill(folio);
>>>> +               folio_mark_uptodate(folio);
>>>> +               folio_unlock(folio);
>>> We don't currently support swapping in large folios, but it is a work
>>> in progress, and this will break once we have it.
>>> swap_zeromap_folio_test() will return false even if parts of the folio
>>> are in fact zero-filled. Then, we will go read those from disk swap,
>>> essentially corrupting data.
>> So yes, with this patch I tested swap out of large zero folio, but when
>> swapping in it was page by page. My assumption was that swap_read_folio
>> (when support is added) would only pass a large folio that was earlier
>> swapped out as a large folio. So if a zero filled large folio was
>> swapped out, the zeromap will be set for all the pages in that folio,
>> and at large folio swap in (when it is supported), it will see that all
>> the bits in the zeromap for that folio are set,  and will just
>> folio_zero_fill.
>>
>> If even a single page in large folio has non-zero data then zeromap will
>> not store it and it will go to either zswap or disk, and at read time as
>> all the bits in zeromap are not set, it will still goto either zswap or
>> disk, so I think this works?
>>
>> Is my assumption wrong that only large folios can be swapped in only if
>> they were swapped out as large? I think this code works in that case.
> I think the assumption is incorrect. I think we would just check if
> contiguous PTEs have contiguous swap entries and swapin the folio as a
> large folio in this case. It is likely that the swap entries are
> contiguous because it was swapped out as a large folio, but I don't
> think it's guaranteed.

Yes, makes sense. Thanks for explaining this.

>
> For example, here is a patch that implements large swapin support for
> the synchronous swapin case, and I think it just checks that the PTEs
> have contiguous swap entries:
> https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.com/
>
> This makes a lot of sense because otherwise you'd have to keep track
> of how the folios were composed at the time of swapout, to be able to
> swap the same folios back in.

I think the solution to large folio swap-in for this optimization and 
zswap is not in swap_read_folio in this patch-series or any call further 
down the stack, as its too late by the time you reach here, but in 
Barrys' patch. This needs to happen much earlier when deciding the size 
of the folio at folio creation in alloc_swap_folio, after Barry checks

     if (is_zswap_enabled())
         goto fallback;

once the order is decided, we would need to check the indexes in the 
zeromap array starting from swap_offset(entry) and ending at 
swap_offset(entry) + 2^order are set. If no bits are set, or all bits 
are set, then we allocate large folio. Otherwise, we goto fallback.

I think its better to handle this in Barrys patch. I feel this series is 
close to its final state, i.e. the only diff I have for the next 
revision is below to remove start/end_writeback for zer_filled case. I 
will comment on Barrys patch once the I send out the next revision of this.


diff --git a/mm/page_io.c b/mm/page_io.c
index 2cac1e11fb85..08a3772ddcf7 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -274,9 +274,7 @@ int swap_writepage(struct page *page, struct 
writeback_control *wbc)

         if (is_folio_zero_filled(folio)) {
                 swap_zeromap_folio_set(folio);
-               folio_start_writeback(folio);
                 folio_unlock(folio);
-               folio_end_writeback(folio);
                 return 0;
         }
         swap_zeromap_folio_clear(folio);




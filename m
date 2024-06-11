Return-Path: <linux-kernel+bounces-210277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE49041C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684F41F2626F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61E444376;
	Tue, 11 Jun 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNpo3is+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11740861
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124745; cv=none; b=AQW1unkhF90PiwCx5Mn2UxNqAyl9SLI8ZTbkpPGGKqTiMHOcntJjhqnmMI6PB0ql8Y2SWOhEEutVJbiVw3HXppKep5xVzrW/umxhS/XIVWFfNF4g2Favo8wW8/pMDpWjKjM4/H+vhA76lpXHtE+VUwb4dvCLMcvuOj59BTVipqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124745; c=relaxed/simple;
	bh=2Uuzv+S5byIsN7xvZeJFeJXG5XpXDZ1YZJnFtLPnAJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKEXHvqCPqSv6b6F2uI5J6B+7xHTh5jNnZZJxjplElQwP5uSPB2JoL0nAgA3vZmJH8OGNfxPgliL9UQnDQLHmbXbal3OuxrJ1XHGvZwd01Pl9e5+B2dY9pw6/fXse/6GX7E8nawONln4JsD3ZRMZ1H/9QHE9BAptkaDuufuU3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNpo3is+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c82101407so5466372e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718124742; x=1718729542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OM5fL+OasdGiX0Yjubme1KK8azWbu6kXziuSZJqJ0pI=;
        b=HNpo3is+FFxTTN5fDO2F51v+tk7hJUCDVJcCfBydDHp2nWfPKtCPBN9r1muozoIi1U
         6yYiVfWUAR5QfGnmcdjuvQ2L1FDnsI7+Snk3Ljea1Iyq9SB/PwKAyMXanzrszUTRUjk8
         MGKzZhKRCFEicp0nQOOyRn02Lb7EhmIGsDkbwcnxO7ynXI94CHAty+paM9Ks3ZPtDR3n
         7Ri4edCxZ1c9bpaBlrWuPDai17dL8bDW5CXJzgdHRPu/qQUp7MEGD8WL35/Rn74Lqhn7
         bxUxklx2uph3I0zt6OjFAC3pW+QVZj8jgEwZ8r/jIm+kruTE2ddnbM1NRs4VP1iGtiKC
         lhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124742; x=1718729542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM5fL+OasdGiX0Yjubme1KK8azWbu6kXziuSZJqJ0pI=;
        b=atuC3M4zriiK3QHX9KVPU6eQpVxrFqV1XFCMyOWK5d2grYWIDu2SU4B1jPLqEu4PXT
         Zsr77kmMUKGAGUmLhnaG6RHT32GDrq/ApXNATtHoj8kaqi+vkOlk6i2Hvhu8wOL90uY1
         mffbPiJ0jlnhcE3BPeNzzOQJWe3pfoBmbK+2XpZEZFp82/7fsJ+QPZDkSHpdNPvXZSuA
         cQo2QA2d7KESCJllhje2rvyRah9cLnalPfK6MoB7tLeLDzgDnpCc3gVTDYq+kmAC9kgh
         4F7DXRGMOtbQw/w7RGZVdqI3g3h8xhyYiFhOKduRKVdVXs6x5yx2j3tSiDB0pWtXC8RI
         glQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh0UoNIKNGIgv5z5BXhlS5vPz9OJH/9hb5V7yNMMAdWL4sW0y+953E2XrDps4pnLBk67DidR6DlKhk8iTVKHV7XBBrufhkC65pQc3k
X-Gm-Message-State: AOJu0YwErqlQLk/9/4HgDmwmnCQo+d0Gl9PLorc/Dlx5sQP+Kx/5GuKV
	+vTzj84zA9e5UBD2m/L/u0VhYLI4tCN6CMaXkdZ2R2VHGL2q0cd3
X-Google-Smtp-Source: AGHT+IHZhKb/zNl+HHrFFjpaoUWIukSeMequbtGMtPNNY3asyqjFnBzEMVvw+aly1fDiFFxZTCMvzg==
X-Received: by 2002:ac2:4a69:0:b0:52b:bfa7:66a1 with SMTP id 2adb3069b0e04-52bbfa766f7mr8601373e87.5.1718124741606;
        Tue, 11 Jun 2024 09:52:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:57b4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0f5ee702sm428034866b.52.2024.06.11.09.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 09:52:21 -0700 (PDT)
Message-ID: <08ea43f2-13d2-4b27-ae62-42cebc185c7b@gmail.com>
Date: Tue, 11 Jun 2024 17:52:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
 <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com>
 <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
 <9ddfe544-636d-4638-ae0e-053674e47322@gmail.com>
 <CAJD7tkY0F-Tczq4j861HxKATzEOfkVv=76m8zFcJHuh8E3VMEw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkY0F-Tczq4j861HxKATzEOfkVv=76m8zFcJHuh8E3VMEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/06/2024 16:42, Yosry Ahmed wrote:
> On Tue, Jun 11, 2024 at 4:49 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> @@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool
>> synchronous,
>>>>>>                    psi_memstall_enter(&pflags);
>>>>>>            }
>>>>>>            delayacct_swapin_start();
>>>>>> -
>>>>>> -       if (zswap_load(folio)) {
>>>>>> +       if (swap_zeromap_folio_test(folio)) {
>>>>>> +               folio_zero_fill(folio);
>>>>>> +               folio_mark_uptodate(folio);
>>>>>> +               folio_unlock(folio);
>>>>> We don't currently support swapping in large folios, but it is a work
>>>>> in progress, and this will break once we have it.
>>>>> swap_zeromap_folio_test() will return false even if parts of the folio
>>>>> are in fact zero-filled. Then, we will go read those from disk swap,
>>>>> essentially corrupting data.
>>>> So yes, with this patch I tested swap out of large zero folio, but when
>>>> swapping in it was page by page. My assumption was that swap_read_folio
>>>> (when support is added) would only pass a large folio that was earlier
>>>> swapped out as a large folio. So if a zero filled large folio was
>>>> swapped out, the zeromap will be set for all the pages in that folio,
>>>> and at large folio swap in (when it is supported), it will see that all
>>>> the bits in the zeromap for that folio are set,  and will just
>>>> folio_zero_fill.
>>>>
>>>> If even a single page in large folio has non-zero data then zeromap will
>>>> not store it and it will go to either zswap or disk, and at read time as
>>>> all the bits in zeromap are not set, it will still goto either zswap or
>>>> disk, so I think this works?
>>>>
>>>> Is my assumption wrong that only large folios can be swapped in only if
>>>> they were swapped out as large? I think this code works in that case.
>>> I think the assumption is incorrect. I think we would just check if
>>> contiguous PTEs have contiguous swap entries and swapin the folio as a
>>> large folio in this case. It is likely that the swap entries are
>>> contiguous because it was swapped out as a large folio, but I don't
>>> think it's guaranteed.
>> Yes, makes sense. Thanks for explaining this.
>>
>>> For example, here is a patch that implements large swapin support for
>>> the synchronous swapin case, and I think it just checks that the PTEs
>>> have contiguous swap entries:
>>> https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.com/
>>>
>>> This makes a lot of sense because otherwise you'd have to keep track
>>> of how the folios were composed at the time of swapout, to be able to
>>> swap the same folios back in.
>> I think the solution to large folio swap-in for this optimization and
>> zswap is not in swap_read_folio in this patch-series or any call further
>> down the stack, as its too late by the time you reach here, but in
>> Barrys' patch. This needs to happen much earlier when deciding the size
>> of the folio at folio creation in alloc_swap_folio, after Barry checks
>>
>>       if (is_zswap_enabled())
>>           goto fallback;
>>
>> once the order is decided, we would need to check the indexes in the
>> zeromap array starting from swap_offset(entry) and ending at
>> swap_offset(entry) + 2^order are set. If no bits are set, or all bits
>> are set, then we allocate large folio. Otherwise, we goto fallback.
>>
>> I think its better to handle this in Barrys patch. I feel this series is
>> close to its final state, i.e. the only diff I have for the next
>> revision is below to remove start/end_writeback for zer_filled case. I
>> will comment on Barrys patch once the I send out the next revision of this.
> Sorry I did not make myself clearer. I did not mean that you should
> handle the large folio swapin here. This needs to be handled at a
> higher level because as you mentioned, a large folio may be partially
> in the zeromap, zswap, swapcache, disk, etc.
>
> What I meant is that we should probably have a debug check to make
> sure this doesn't go unhandled. For zswap, I am trying to add a
> warning and fail the swapin operation if a large folio slips through
> to zswap. We can do something similar here if folks agree this is the
> right way in the interim:
> https://lore.kernel.org/lkml/20240611024516.1375191-3-yosryahmed@google.com/.
>
> Maybe I am too paranoid, but I think it's easy to mess up these things
> when working on large folio swapin imo.

So there is a difference between zswap and this optimization. In this 
optimization, if the zeromap is set for all the folio bits, then we 
should do large folio swapin. There still needs to be a change in Barrys 
patch in alloc_swap_folio, but apart from that does the below diff over 
v3 make it better? I will send a v4 with this if it sounds good.


diff --git a/mm/page_io.c b/mm/page_io.c
index 6400be6e4291..bf01364748a9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -234,18 +234,24 @@ static void swap_zeromap_folio_clear(struct folio 
*folio)
         }
  }

-static bool swap_zeromap_folio_test(struct folio *folio)
+/*
+ * Return the index of the first subpage which is not zero-filled
+ * according to swap_info_struct->zeromap.
+ * If all pages are zero-filled according to zeromap, it will return
+ * folio_nr_pages(folio).
+ */
+static long swap_zeromap_folio_test(struct folio *folio)
  {
         struct swap_info_struct *sis = swp_swap_info(folio->swap);
         swp_entry_t entry;
-       unsigned int i;
+       long i;

         for (i = 0; i < folio_nr_pages(folio); i++) {
                 entry = page_swap_entry(folio_page(folio, i));
                 if (!test_bit(swp_offset(entry), sis->zeromap))
-                       return false;
+                       return i;
         }
-       return true;
+       return i;
  }

  /*
@@ -581,6 +587,7 @@ void swap_read_folio(struct folio *folio, bool 
synchronous,
  {
         struct swap_info_struct *sis = swp_swap_info(folio->swap);
         bool workingset = folio_test_workingset(folio);
+       long first_non_zero_page_idx;
         unsigned long pflags;
         bool in_thrashing;

@@ -598,10 +605,19 @@ void swap_read_folio(struct folio *folio, bool 
synchronous,
                 psi_memstall_enter(&pflags);
         }
         delayacct_swapin_start();
-       if (swap_zeromap_folio_test(folio)) {
+       first_non_zero_page_idx = swap_zeromap_folio_test(folio);
+       if (first_non_zero_page_idx == folio_nr_pages(folio)) {
                 folio_zero_fill(folio);
                 folio_mark_uptodate(folio);
                 folio_unlock(folio);
+       } else if (first_non_zero_page_idx != 0) {
+               /*
+                * The case for when only *some* of subpages being 
swapped-in were recorded
+                * in sis->zeromap, while the rest are in zswap/disk is 
currently not handled.
+                * WARN in this case and return without marking the 
folio uptodate so that
+                * an IO error is emitted (e.g. do_swap_page() will sigbus).
+                */
+                WARN_ON_ONCE(1);
         } else if (zswap_load(folio)) {
                 folio_mark_uptodate(folio);
                 folio_unlock(folio);




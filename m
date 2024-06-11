Return-Path: <linux-kernel+bounces-210456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5039043E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA701C254FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88474432;
	Tue, 11 Jun 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkDd2u3G"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D838FA1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131426; cv=none; b=oBz/X4mLDxZ6pTXdeTwtzD3MWSf6XqsQBY6YeDKWAL9Fq9MFyzeHOwkn6eRTOHxGuHjnlzB7/ohDmRMLJrBm/b5d6WiW7FerMuvBTHSG8Exg/asG0dnVLrthXe4w6vzcFKHq0vuYOeo1kPa4lWlSRoafgNhVqlrFTlLcJ8uwLos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131426; c=relaxed/simple;
	bh=W6u7PIhX5knHCDdAk1xxEbG7NBM76Nhk0BJW4zS9M6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te7W8axOOyKvXN1H/RoSW65+sz1rJBGHGn5LqN8S89EWNwSawDxSXN0uV7w29DZ8WfSTsC3KvOItPTsc8R759dXv2VopehiZX5CEXDge6+Uxak4dgapxfT1VEpRkqHgIxMi241FsknLsE8z+n+2rCJVOMo2s0ARY/OZwtBXV8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkDd2u3G; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so5232568a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718131422; x=1718736222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3B4dRZiAZKLlssSkuibM6VAi10SgS6TbPgd/0zmbDxc=;
        b=YkDd2u3GcT+fPLhCfaRNDe/2UaCJ1hLINto4gANqaDTTGP6M7HENnB9SBVwdOPyktf
         x4XuDfj2hgVbLedKcCx0FMU3zBw9AaHprE+jOTrZacx7JrkIjP5PuusKwSfv3Fq9gCxh
         ENKMgqdHdDUCjo49WAWFd+Peh1pOlTkWwDKqMln9y6dj7goI/sfsFjB6OritODiEDQyx
         eqoJiyUMG/cfB34wXwCVY2aVqCyAsH3sm5DHtY4IEGAi06ENAowpEo4SHoNMJ6Wp1vsT
         11lx5qDnagYlLJPsHOp23lYBwwsiUXzMmcDQAZJCoxtBBp1C/Q+DeAAGuo501ueNhPuA
         Uypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131422; x=1718736222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3B4dRZiAZKLlssSkuibM6VAi10SgS6TbPgd/0zmbDxc=;
        b=VpoHR6LuqjnzeXG0ynIIGlFeVqsSn8Hwfq3uFbNpERJCWJ9ly191tw+2haBihECZEJ
         35Lbje99u2c12DFf99fwEnydp4cRZDAN9tMkqSw6Z1U+xXkrtQTP5eAMMESlUy2s0ebf
         D1ZxGlVGzr2xu5iHHj1RLGDtIl6wlKLghN2K3s2eLXQeQ35W+eRRniCdeyCHmxAnw05/
         Z7IqRR3BBSFtTif/72aOVVK99rIdKYaVH/0k8hlUZTEXq9AOH1ns3gXNbwRhwOVsHhue
         Ysicyt43Up8e3LCRXZMrVxO1ri4A6aQPdijlVEWwvene5kFsn+SwcpVlJCH0TfrEMGc1
         ku8g==
X-Forwarded-Encrypted: i=1; AJvYcCWg3WhOYB/S/2Q9/Gat2qX3qIWIawCOeFf45UyUhzktwVgLxngBxISsW6jQyW4tBVG5mcj1IWFjDuV7lOHTefLLlxZKAaJZQlhrRQUI
X-Gm-Message-State: AOJu0Yz0M+6I9QDmbzwt6zPYclV5N7t0pEFGcaXliymd9wEUR1ShzALw
	2r3XEFevl0nZVmPJLNQCSFdVNvC4kdwHE2sdfCaiEhMshDZqckj7
X-Google-Smtp-Source: AGHT+IE3zSTRh8xAH8Py1sMJDx/BjKoKZNHDkSiAjCEUIwefZi48SYXnfFRQ122iGGSTZAIEXbm/XA==
X-Received: by 2002:a50:8e11:0:b0:57c:8049:a9a with SMTP id 4fb4d7f45d1cf-57c80490adfmr4008291a12.2.1718131422174;
        Tue, 11 Jun 2024 11:43:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:57b4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7fcfc67fsm4635790a12.31.2024.06.11.11.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:43:41 -0700 (PDT)
Message-ID: <622bc591-ad14-448e-a9f3-988976fbb98a@gmail.com>
Date: Tue, 11 Jun 2024 19:43:41 +0100
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
 <08ea43f2-13d2-4b27-ae62-42cebc185c7b@gmail.com>
 <CAJD7tkZC8e8ZTBSOGZH-1srTeC=jqxwWchd-BjvNsV2FR0oT8Q@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZC8e8ZTBSOGZH-1srTeC=jqxwWchd-BjvNsV2FR0oT8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/06/2024 18:51, Yosry Ahmed wrote:
> [..]
>>>> I think its better to handle this in Barrys patch. I feel this series is
>>>> close to its final state, i.e. the only diff I have for the next
>>>> revision is below to remove start/end_writeback for zer_filled case. I
>>>> will comment on Barrys patch once the I send out the next revision of this.
>>> Sorry I did not make myself clearer. I did not mean that you should
>>> handle the large folio swapin here. This needs to be handled at a
>>> higher level because as you mentioned, a large folio may be partially
>>> in the zeromap, zswap, swapcache, disk, etc.
>>>
>>> What I meant is that we should probably have a debug check to make
>>> sure this doesn't go unhandled. For zswap, I am trying to add a
>>> warning and fail the swapin operation if a large folio slips through
>>> to zswap. We can do something similar here if folks agree this is the
>>> right way in the interim:
>>> https://lore.kernel.org/lkml/20240611024516.1375191-3-yosryahmed@google.com/.
>>>
>>> Maybe I am too paranoid, but I think it's easy to mess up these things
>>> when working on large folio swapin imo.
>> So there is a difference between zswap and this optimization. In this
>> optimization, if the zeromap is set for all the folio bits, then we
>> should do large folio swapin. There still needs to be a change in Barrys
>> patch in alloc_swap_folio, but apart from that does the below diff over
>> v3 make it better? I will send a v4 with this if it sounds good.
>>
>>
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 6400be6e4291..bf01364748a9 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -234,18 +234,24 @@ static void swap_zeromap_folio_clear(struct folio
>> *folio)
>>           }
>>    }
>>
>> -static bool swap_zeromap_folio_test(struct folio *folio)
>> +/*
>> + * Return the index of the first subpage which is not zero-filled
>> + * according to swap_info_struct->zeromap.
>> + * If all pages are zero-filled according to zeromap, it will return
>> + * folio_nr_pages(folio).
>> + */
>> +static long swap_zeromap_folio_test(struct folio *folio)
>>    {
>>           struct swap_info_struct *sis = swp_swap_info(folio->swap);
>>           swp_entry_t entry;
>> -       unsigned int i;
>> +       long i;
> Why long?


folio_nr_pages returns long, but I just checked that 
folio->_folio_nr_pages is unsigned int, but that will probably be 
typecasted to long :). I will switch to unsigned int as its not really 
going to go to long for CONFIG_64BIT

>>           for (i = 0; i < folio_nr_pages(folio); i++) {
>>                   entry = page_swap_entry(folio_page(folio, i));
>>                   if (!test_bit(swp_offset(entry), sis->zeromap))
>> -                       return false;
>> +                       return i;
>>           }
>> -       return true;
>> +       return i;
>>    }
>>
>>    /*
>> @@ -581,6 +587,7 @@ void swap_read_folio(struct folio *folio, bool
>> synchronous,
>>    {
>>           struct swap_info_struct *sis = swp_swap_info(folio->swap);
>>           bool workingset = folio_test_workingset(folio);
>> +       long first_non_zero_page_idx;
>>           unsigned long pflags;
>>           bool in_thrashing;
>>
>> @@ -598,10 +605,19 @@ void swap_read_folio(struct folio *folio, bool
>> synchronous,
>>                   psi_memstall_enter(&pflags);
>>           }
>>           delayacct_swapin_start();
>> -       if (swap_zeromap_folio_test(folio)) {
>> +       first_non_zero_page_idx = swap_zeromap_folio_test(folio);
>> +       if (first_non_zero_page_idx == folio_nr_pages(folio)) {
>>                   folio_zero_fill(folio);
>>                   folio_mark_uptodate(folio);
>>                   folio_unlock(folio);
>> +       } else if (first_non_zero_page_idx != 0) {
>> +               /*
>> +                * The case for when only *some* of subpages being
>> swapped-in were recorded
>> +                * in sis->zeromap, while the rest are in zswap/disk is
>> currently not handled.
>> +                * WARN in this case and return without marking the
>> folio uptodate so that
>> +                * an IO error is emitted (e.g. do_swap_page() will sigbus).
>> +                */
>> +                WARN_ON_ONCE(1);
>>           } else if (zswap_load(folio)) {
>>                   folio_mark_uptodate(folio);
>>                   folio_unlock(folio);
>>
>>
> This is too much noise for swap_read_folio(). How about adding
> swap_read_folio_zeromap() that takes care of this and decides whether
> or not to call folio_mark_uptodate()?

Sounds good, will do as below. Thanks!

>
> -static bool swap_zeromap_folio_test(struct folio *folio)
> +/*
> + * Return the index of the first subpage which is not zero-filled according to
> + * swap_info_struct->zeromap.  If all pages are zero-filled according to
> + * zeromap, it will return folio_nr_pages(folio).
> + */
> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
>   {
>          struct swap_info_struct *sis = swp_swap_info(folio->swap);
>          swp_entry_t entry;
> @@ -243,9 +248,9 @@ static bool swap_zeromap_folio_test(struct folio *folio)
>          for (i = 0; i < folio_nr_pages(folio); i++) {
>                  entry = page_swap_entry(folio_page(folio, i));
>                  if (!test_bit(swp_offset(entry), sis->zeromap))
> -                       return false;
> +                       return i;
>          }
> -       return true;
> +       return i;
>   }
>
>   /*
> @@ -511,6 +516,25 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>          mempool_free(sio, sio_pool);
>   }
>
> +static bool swap_read_folio_zeromap(struct folio *folio)
> +{
> +       unsigned int idx = swap_zeromap_folio_test(folio);
> +
> +       if (idx == 0)
> +               return false;
> +
> +       /*
> +        * Swapping in a large folio that is partially in the zeromap is not
> +        * currently handled. Return true without marking the folio uptodate so
> +        * that an IO error is emitted (e.g.  do_swap_page() will sigbus).
> +        */
> +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +               return true;
> +
> +       folio_zero_fill(folio);
> +       folio_mark_uptodate(folio);
> +       return true
> +}
> +
>   static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
>   {
>          struct swap_info_struct *sis = swp_swap_info(folio->swap);
> @@ -600,9 +624,7 @@ void swap_read_folio(struct folio *folio, bool synchronous,
>                  psi_memstall_enter(&pflags);
>          }
>          delayacct_swapin_start();
> -       if (swap_zeromap_folio_test(folio)) {
> -               folio_zero_fill(folio);
> -               folio_mark_uptodate(folio);
> +       if (swap_read_folio_zeromap(folio)) {
>                  folio_unlock(folio);
>          } else if (zswap_load(folio)) {
>                  folio_mark_uptodate(folio);


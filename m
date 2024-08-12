Return-Path: <linux-kernel+bounces-282618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0994E680
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCAB282793
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CE14D435;
	Mon, 12 Aug 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NUs9lllk"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840E27457
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443675; cv=none; b=FoBlEmne4kSY1lX3XIiGP5hMyEmhhxcc2IVtBiPqLHBgJgkeWPzVokxZVNZfqbOrqZgOtbtdXYUGecGnYJ/nzqPS1YBTF0PMzot8lzDSEhjeuvR5rsJrrDOUS2Ply1w2EmJaVt1LpzaVqyPyV1nebh8xCMJyEI1QpQvgQPN7jp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443675; c=relaxed/simple;
	bh=IUMqUmgGIZNbYwBr+n1ZWHy0H4fDY1v4tvJ9Mslw0Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCTqbBN0QADpZX6sGlQHm8FnGjM+y0XIJyeMeMFlrJstiJEH1UvTUOcF4pTlN7Fts6tCwa1RpdIr8xbISJhvflb0fIgfUsR+CVzJ5g3Hyc+H4jXJo0xI/BRoKv33nDx0xj0uFXLERTKf+/RoaV0DqjZKxlth5hhRU4l1AzJ9XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NUs9lllk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2635abdc742so458067fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723443672; x=1724048472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQlCdV65LEz1kHk47bwY6iHdSZ8qzDbLv2CS0ac6kI8=;
        b=NUs9lllkZ9TZzbq/uY//BWZEZWp3tYXB8gnh+gAFUTqBeWUpNShrzwvj3/7OMYqZ01
         cNGotNDxjlQGmw5wAEGXyv/BHX2sdnnRZf1i+i6/FtnLZiCcF7p4iJSejcpm7JKhGYTo
         J3/kE8Lwv2ExZyUvInTdii7L0oI+rr6yOM1iOdFIfbzdKWqpNzkFfT4J/mX7Z75jfLgw
         nniQpBnELqy8maorJBN8idSM1QAbWyc1Edu+1/vFp12KNhOQ7VVHKuFU0C66y8yuLB7l
         WvMHIM/z/9M4YQkyMlirWHfrB9PpsMLIUNYUjFQ/mxMEXbHnwkyxyakxwHpsqunMny5d
         KZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723443672; x=1724048472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQlCdV65LEz1kHk47bwY6iHdSZ8qzDbLv2CS0ac6kI8=;
        b=nWXQG2Vq+j8vxV7PFIki4GbH4TdWtqu2Z34ClhvUcdpULp2aWhqz5Xd5Tgh2R8fgZe
         ZGDtzHz0mrgYXm3jqcsKsrmkN1GVbKfJFXF01TpQckoqPo5fvIXgpdf9bWYivS8rC4gF
         NAaEKSPWvQtKoWTo3GFR7R/FGl5C0EbrpynhSAMgY3Sl6ce5TafeoBmdByRac/tsrihH
         kubTM9mmEHE6hWdcb1FPytP/Ft4t7TSgxlSz05i/SDV31UIBrFz+B/xQ1FCNzZkv5J5x
         SImngVpi0YTbSHPGNEWuivVlLIQXibkt2Rp9vKAarVfRlrjkX5y3JxkOqBi96EhYrX6P
         oozw==
X-Forwarded-Encrypted: i=1; AJvYcCXrKndG2GiZnduo7Fe/joFMrfl+RJlE+Dc0LPl6hcPQ2PMHRtB5wwePrI0Q5PDANHe223ZokWwT+oIlm9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wj74/iHZHAPdhvfFq4szSAFjOBS704rsPxXfhCjCdqgNrp9m
	4hpKIC5B4xIYQEGyVhTLxnlmMTpupdY1Qvs1RXzArc5N6p6+zw3sZB/deoAbPZ0=
X-Google-Smtp-Source: AGHT+IFmB5BoVq6D14NtSCtkb6BEh80Rryr97W+EDEWN3kH2nMQUF8wgurMj4XoRqHWBBaDrHk6YBQ==
X-Received: by 2002:a05:6870:658d:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-26c62f1afa6mr5545965fac.6.1723443672322;
        Sun, 11 Aug 2024 23:21:12 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe12e80sm3506101a12.24.2024.08.11.23.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 23:21:11 -0700 (PDT)
Message-ID: <3e8253c4-9181-4027-84ee-28e1fc488f61@bytedance.com>
Date: Mon, 12 Aug 2024 14:21:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] mm: pgtable: make pte_offset_map_nolock()
 return pmdval
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <d101b185eb55438b18faa2029e4303b7453bd5f5.1722861064.git.zhengqi.arch@bytedance.com>
 <0e8e0503-5796-4b61-bb5b-249e285f5d21@redhat.com>
 <39281a4d-d896-46fd-80a5-8cd547d1625f@bytedance.com>
 <0f467510-a0d0-4a98-8517-43813fa4c131@redhat.com>
 <f6c05526-5ac9-4597-9e80-099ea22fa0ae@bytedance.com>
 <f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <f79bbfc9-bb4c-4da4-9902-2e73817dd135@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/10 00:54, David Hildenbrand wrote:
> On 07.08.24 05:08, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/8/6 22:16, David Hildenbrand wrote:
>>> On 06.08.24 04:40, Qi Zheng wrote:
>>>> Hi David,
>>>>
>>>> On 2024/8/5 22:43, David Hildenbrand wrote:
>>>>> On 05.08.24 14:55, Qi Zheng wrote:
>>>>>> Make pte_offset_map_nolock() return pmdval so that we can recheck the
>>>>>> *pmd once the lock is taken. This is a preparation for freeing empty
>>>>>> PTE pages, no functional changes are expected.
>>>>>
>>>>> Skimming the patches, only patch #4 updates one of the callsites
>>>>> (collapse_pte_mapped_thp).
>>>>
>>>> In addition, retract_page_tables() and reclaim_pgtables_pmd_entry()
>>>> also used the pmdval returned by pte_offset_map_nolock().
>>>
>>> Right, and I am questioning if only touching these two is sufficient,
>>> and how we can make it clearer when someone actually has to recheck the
>>> PMD.
>>>
>>>>
>>>>>
>>>>> Wouldn't we have to recheck if the PMD val changed in more cases after
>>>>> taking the PTL?
>>>>>
>>>>> If not, would it make sense to have a separate function that 
>>>>> returns the
>>>>> pmdval and we won't have to update each and every callsite?
>>>>
>>>> pte_offset_map_nolock() had already obtained the pmdval previously, 
>>>> just
>>>> hadn't returned it. And updating those callsite is simple, so I think
>>>> there may not be a need to add a separate function.
>>>
>>> Let me ask this way: why is retract_page_tables() and
>>> reclaim_pgtables_pmd_entry() different to the other ones, and how would
>>> someone using pte_offset_map_nolock() know what's to do here?
>>
>> If we acuqire the PTL (PTE or PMD lock) after calling
>> pte_offset_map_nolock(), it means we may be modifying the corresponding
>> pte or pmd entry. In that case, we need to perform a pmd_same() check
>> after holding the PTL, just like in pte_offset_map_lock(), to prevent
>> the possibility of the PTE page being reclaimed at that time.
> 
> Okay, what I thought.
> 
>>
>> If we call pte_offset_map_nolock() and do not need to acquire the PTL
>> afterwards, it means we are only reading the PTE page. In this case, the
>> rcu_read_lock() in pte_offset_map_nolock() will ensure that the PTE page
>> cannot be reclaimed.
>>
>>>
>>> IIUC, we must check the PMDVAL after taking the PTL in case
>>>
>>> (a) we want to modify the page table to turn pte_none() entries to
>>>       !pte_none(). Because it could be that the page table was 
>>> removed and
>>>       now is all pte_none()
>>>
>>> (b) we want to remove the page table ourselves and want to check if it
>>>       has already been removed.
>>>
>>> Is that it?
>>
>> Yes.
>>
>>>
>>> So my thinking is if another function variant can make that clearer.
>>
>> OK, how about naming it pte_offset_map_before_lock?
> 
> That's the issue with some of the code: for example in 
> filemap_fault_recheck_pte_none() we'll call pte_offset_map_nolock() and 
> conditionally take the PTL. But we won't be modifying the pages tables.
> 
> Maybe something like:
> 
> pte_offset_map_readonly_nolock()
> 
> and
> 
> pte_offset_map_maywrite_nolock()
> 
> The latter would require you to pass the PMD pointer such that you have 
> to really mess up to ignore what to do with it (check PMD same or not 
> check PMD same if you really know what you are douing).
> 
> The first would not take a PMD pointer at all, because there is no need to.

These two function names LGTM. Will do in the next version.

Thanks,
Qi

> 


Return-Path: <linux-kernel+bounces-306073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577749638CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61092B226CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5694D8AD;
	Thu, 29 Aug 2024 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a/RiLINm"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570E1428E7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902079; cv=none; b=al1XefspsrdqLNMfGiucHS8uqlSmmJgvK2Q7qI0xeJ4EUMlrnl+7ZrZ+OI/P+e8yOtpgwsNV4sb/s8De6zRBM3XG7dnoYdmM5zVB9qV5gJfCfQY+VqkNsgO6OjGxB94tPgOIVTLIiPN6OeMixg+ENyEnd2ErtqOs8GVrrO2ga1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902079; c=relaxed/simple;
	bh=auxUxU3gHTQYHH1lQb9smx/CNmWiTZi01lo7jC2cqnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqVFGJ28B7a06Ou09bjvcWCBm20cQEBCugNuSxVhVd9qqrG0Hwvyrau0ge2CQNcHizFSH1GXz1hmOpVKUqxj4BUI13wUasmSoAxJsBG7/+oIMm1uzYfHr+ptRD3IwZQxbTpEGqe9BZRTFnWvfqrNyP0KBH7CwgwQVKQ5lvckLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a/RiLINm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2704b6a6fe6so109584fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724902076; x=1725506876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUSlIPY0I0p/J1gM+q6b9ZwgCjkUVZv6zdCV16DJSmE=;
        b=a/RiLINmhsMN2BWp3Q8blsnEMHFYwECo6cgDzU5ts4a1TuPoFaxFxlsSlfkK0CYRFj
         wa02pahmvubu2NEMW3EIfaBGwpfe2M3L/Qt+0H4fbJZQRZTaBNwc4ZaXaHsuqAbiPrVV
         u7Yk42ZzEmHLhxJ5fR+tIc9Uk2B4d+tr2PZMZTbtqSCxAXVXfw5cqq3ZZAVCt2r33+vi
         7fIrqUdrrn4SkOawzBTQhDXHoVnvdKkrX/L83bE666K24bFAVa9iwt6bGPTXL8PbZYt3
         y7eU4akFcAZQUURnWH1iKX/7UN+YVDTv5Z2grc0yLxiVTOismSaswwIac1mazy87yvfG
         GYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902076; x=1725506876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUSlIPY0I0p/J1gM+q6b9ZwgCjkUVZv6zdCV16DJSmE=;
        b=bt+sa1prSyBqaFGU5McwWTwi8k0yjHHpCD/PQYtWb4WKnkZ3Ar0QTORyrz4VEmGKPe
         76LEC4fj8ug564zDNIhRCYzHaCGoxBkmDID5V5M3NF3njusbdfCOmJmvyY3TJF9F4seP
         ZBt7I7PgATKpHhxFzlrVS6EVVGmfJaU3cS7kW+DPjvD4TWV4ibAv29HnGWE6F33FI0Z6
         smQHOq7PQqENepgf40chB9A36mWzLpaMcycoWhLADxukp38GCZfUvER+W7I8VCnlTXU8
         ULcZMryaqVRq4TYJydAFGMljRe+q7MBnGCKdyerbONNJ6Emw8HdlbhV2qvuCzbZfSFjZ
         xtPw==
X-Forwarded-Encrypted: i=1; AJvYcCUDMmSxyf1+pkXj2BIRD/sSgV1B8vVk1LNXwG3qdk3uVusTyMvmOCzON1Q8giQI8sWnVTd4JQ9IsWwQbCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHUYuDvOzztTZ5fbeZmunBT5fF9L/U4XgEqdiMuOIo0DRBZPr
	4Rlofe03SwdJOIuxc6zrCmsuPU/Vd5HWQcn5pxaeiFUArwLeGLtWBW1A5GpWiAA=
X-Google-Smtp-Source: AGHT+IGZPCEcwowFRJHQOC2QH+v2+Ysm2wJ5TBLKGyXexoQWGql8ItSqdv/XlmWonkjQbasTqI0R6g==
X-Received: by 2002:a05:6870:2011:b0:25e:1c9d:f180 with SMTP id 586e51a60fabf-277903675a4mr1814959fac.50.1724902075836;
        Wed, 28 Aug 2024 20:27:55 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a4548sm203799b3a.59.2024.08.28.20.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 20:27:55 -0700 (PDT)
Message-ID: <469e0ab5-af2c-4996-bfd4-fe7ab6a7bc8c@bytedance.com>
Date: Thu, 29 Aug 2024 11:27:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, muchun.song@linux.dev
Cc: hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
 <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
 <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
 <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/28 18:48, David Hildenbrand wrote:
> On 27.08.24 06:33, Qi Zheng wrote:
>> Hi David,
>>
>> On 2024/8/26 23:21, David Hildenbrand wrote:
>>> On 22.08.24 09:13, Qi Zheng wrote:
>>>> Currently, the usage of pte_offset_map_nolock() can be divided into the
>>>> following two cases:
>>>>
>>>> 1) After acquiring PTL, only read-only operations are performed on the
>>>> PTE
>>>>      page. In this case, the RCU lock in pte_offset_map_nolock() will
>>>> ensure
>>>>      that the PTE page will not be freed, and there is no need to worry
>>>>      about whether the pmd entry is modified.
>>>
>>> There is also the usage where we don't grab the PTL at all, and only do
>>> a racy (read-only) lookup.
>>
>> IIUC, pte_offset_map() should be used instead of pte_offset_map_nolock()
>> in this case.
> 
> Yes, but the filemap.c thingy conditionally wants to lock later. But I 
> agree that pte_offset_map() is better when not even wanting to lock.
> 
> [...]
> 
>>>> accessor functions:
>>>>     - pte_offset_map_nolock()
>>>>        maps PTE, returns pointer to PTE with pointer to its PTE table
>>>>        lock (not taken), or returns NULL if no PTE table;
>>>
>>> What will happen to pte_offset_map_nolock() after this series? Does it
>>> still exist or will it become an internal helper?
>>
>> I choose to remove it completely in [PATCH v2 13/14].
>>
> 
> Ah, great.
> 
> [...]
> 
>>> If someone thinks not requiring a non-NULL pointer is better, please
>>> speak up, I'm not married to that idea :)
>>>
>>>> +    pte = __pte_offset_map(pmd, addr, &pmdval);
>>>> +    if (likely(pte))
>>>> +        *ptlp = pte_lockptr(mm, &pmdval);
>>>> +    *pmdvalp = pmdval;
>>>> +    return pte;
>>>> +}
>>>> +
>>>>    /*
>>>>     * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal
>>>> implementation
>>>>     * __pte_offset_map_lock() below, is usually called with the pmd
>>>> pointer for
>>>> @@ -356,6 +383,22 @@ pte_t *pte_offset_map_nolock(struct mm_struct
>>>> *mm, pmd_t *pmd,
>>>>     * recheck *pmd once the lock is taken; in practice, no callsite
>>>> needs that -
>>>>     * either the mmap_lock for write, or pte_same() check on contents,
>>>> is enough.
>>>>     *
>>>> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
>>>> + * pte_offset_map(); but when successful, it also outputs a pointer
>>>> to the
>>>> + * spinlock in ptlp - as pte_offset_map_lock() does, but in this case
>>>> without
>>>> + * locking it.  This helps the caller to avoid a later
>>>> pte_lockptr(mm, *pmd),
>>>> + * which might by that time act on a changed *pmd:
>>>> pte_offset_map_ro_nolock()
>>>> + * provides the correct spinlock pointer for the page table that it
>>>> returns.
>>>> + * For readonly case, the caller does not need to recheck *pmd after
>>>> the lock is
>>>> + * taken, because the RCU lock will ensure that the PTE page will not
>>>> be freed. > + *
>>>> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is
>>>> like
>>>> + * pte_offset_map_ro_nolock(); but when successful, it also outputs 
>>>> the
>>>> + * pdmval. For cases where pte or pmd entries may be modified, that
>>>> is, maywrite
>>>> + * case, this can help the caller recheck *pmd once the lock is
>>>> taken. In some
>>>> + * cases, that is, either the mmap_lock for write, or pte_same()
>>>> check on
>>>> + * contents, is also enough to ensure that the pmd entry is stable.
>>>> + *
>>>>     * Note that free_pgtables(), used after unmapping detached vmas, or
>>>> when
>>>>     * exiting the whole mm, does not take page table lock before
>>>> freeing a page
>>>>     * table, and may not use RCU at all: "outsiders" like khugepaged
>>>> should avoid
>>>
>>> In general to me a step into the right direction. Likely the
>>> documentation could be further clarified in some aspects:
>>>
>>> Like that the use of pte_offset_map_ro_nolock() does not allow to easily
>>> identify if the page table was replaced in the meantime. Even after
>>> grabbing the PTL, we might be looking either at a page table that is
>>> still mapped or one that was unmapped and is about to get freed. But for
>>> R/O access this is usually sufficient AFAIUK.
>>>
>>> Or that "RO" / "RW" expresses the intended semantics, not that the
>>> *kmap* will be RO/RW protected.
>>
>> How about the following:
>>
>> pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
>> pte_offset_map(); but when successful, it also outputs a pointer to the
>> spinlock in ptlp - as pte_offset_map_lock() does, but in this case
>> without locking it.  This helps the caller to avoid a later
>> pte_lockptr(mm, *pmd), which might by that time act on a changed *pmd:
>> pte_offset_map_ro_nolock() provides the correct spinlock pointer for the
>> page table that it returns. Even after grabbing the spinlock, we might
>> be looking either at a page table that is still mapped or one that was
>> unmapped and is about to get freed. But for R/O access this is usually
>> sufficient AFAIUK.
> 
> Drop the "AFAIUK" :)
> 
> "For R/O access this is sufficient."

OK.

> 
>>
>> pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
>> pte_offset_map_ro_nolock(); but when successful, it also outputs the
>> pdmval. For R/W access, the callers can not accept that the page table
>> it sees has been unmapped and is about to get freed. The pmdval can help
>> callers to recheck pmd_same() to identify this case once the spinlock is
>> taken. For some cases where exclusivity is already guaranteed, such as
>> holding the write lock of mmap_lock, or in cases where checking is
>> sufficient, such as a !pte_none() pte will be rechecked after the
>> spinlock is taken, there is no need to recheck pdmval.
> 
> Right, using pte_same() one can achieve a similar result, assuming that 
> the freed page table gets all ptes set to pte_none().
> 
> page_table_check_pte_clear_range() before pte_free_defer() in 
> retract_page_tables/collapse_pte_mapped_thp() sanity checks that I think.
> 
> In collapse_huge_page() that is not the case. But here, we also 
> currently grab all heavily locks, to prevent any concurrent page table 
> walker.

Yes.

> 
>>
>> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
>> will be RO/RW protected.
> 
> 
> Good. Please also incorporate the feedback from Muchun.

OK, I will change it in v3 to the following:

pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
pte_offset_map(); but when successful, it also outputs a pointer to the
spinlock in ptlp - as pte_offset_map_lock() does, but in this case
without locking it.  This helps the caller to avoid a later
pte_lockptr(mm, *pmd), which might by that time act on a changed *pmd:
pte_offset_map_ro_nolock() provides the correct spinlock pointer for the
page table that it returns. Even after grabbing the spinlock, we might
be looking either at a page table that is still mapped or one that was 
unmapped and is about to get freed. But for R/O access this is
sufficient. So it is only applicable for read-only cases where any 
modification operations to the page table are not allowed even if
the corresponding spinlock is held afterwards.

pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
pte_offset_map_ro_nolock(); but when successful, it also outputs the
pdmval. It is applicable for may-write cases where any modification
operations to the page table may happen after the corresponding spinlock
is held afterwards. But the users should make sure the page table is
stable like holding mmap_lock for write or checking pte_same() or
checking pmd_same() by using the output pmdval before performing the
write operations.

Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
will be read-only/read-write protected.


> 


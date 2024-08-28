Return-Path: <linux-kernel+bounces-304814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFB096253D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531721C2191E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CE16BE35;
	Wed, 28 Aug 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES2Uth4R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD016A37C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842142; cv=none; b=YLFNfhf+ZpL0xjUsnT+BiwCx7OwQVtecWNCpMQmNk1qHlu7yyRrqSoEXvjD48gkF2XFppFwzqDO3ahfG0T2N7A5/FjMdWKAgrrvADqwXm7v7z4L17YyYQT+zMHUYq09ajuc/owV7HlYSxDY1F2ZZzqrkWheCmvffoM6VYguhMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842142; c=relaxed/simple;
	bh=I7NwsmOWQF9SQ+vAkMVgevHVS6irMTE3H5Pe8w98qi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwe8GcYb40K4jJ6lnAwY1OyXK0XbxplRbO/O2++5vjRJQ7SNYy2GS7NEOF5mAHR2yPQg8d0idTAr2F8YUTfR/I+LFBUqLa1Jk76aX2EKYu9M1l96ohETAZeVHcxIzgSzQN45ZU4jLagDIM8iXt2OX1jFM8rKcepIlwgxCUCpq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES2Uth4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724842140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wvYsNaL9w1gkGPGglv5zQzpSgbJlfB/etLX3d1fPOrc=;
	b=ES2Uth4Rs8NuVA8cMsBXkZglBgiPIZ1VGOPvExWTdw0O77dhSZxXNNKWAR8PSSgZXZ4gWJ
	g0EcZGkbweUsPhwN5PpZ5GSc9L/KkJwBdJsC/usVSgUeIWukBeKJbuz/QwJhhEb4B6yUnH
	ASxzzWUmP+sBP5xlghB5QyxoJtKl/Ww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-TFKLgKn3Po2xWcm-X5VQRA-1; Wed, 28 Aug 2024 06:48:58 -0400
X-MC-Unique: TFKLgKn3Po2xWcm-X5VQRA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718c1637caso4001988f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842138; x=1725446938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvYsNaL9w1gkGPGglv5zQzpSgbJlfB/etLX3d1fPOrc=;
        b=RicqOUw6KudGlLlG48znxkGlKpiJ97Jh98J6sr5RTm1ivVex8Dm/KXPGbYHNAQFCM5
         2tCQMZWCkeRppdbFKWhgkqtcInyBmmKGFT3gk3u3kNbP9keCzkkNCO+feCs2nbZQgBHx
         d+7LLGB2DQ0sdYJfJY5ANaDMQc1YrKqM9e7WzE5R+gGvUJ94LNbah9ExYSMwi+31vru5
         kdUXtsLylTwig2faIFy+wfaKQoAVHmkHZEPatRptDKUlG0L38SN7fdvk9+y6XW88cHBc
         W5zKsZUlqC2p5TLTB88+Wmc8H7tNQ6Fn3ZQqcbZIrHK6SedWcDMTwCbZ5E1jMFyu6ZjS
         jPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwiVC8UQ/5QIe9Ca+ud0qv9WC4fxkTrhxTnqDdhIdeA9e6UgSoc7oSRvAejaV4AoLdaF5jIhD4Jr5bfJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6BuyyxThEornXq/Clf2QOwnneg/q3NO47fifgUMUe5LB9ipf
	Unp4DJ1hLdiU/QiHJ/3rzLWgwi0rgPPN+sattiYN2bW8XdUafxgpqmFMST2NX/R3n7PKDIrtkvs
	FCs8+CaaSKjMvXfP0zJEgAYzLidL2KIxIVzaNQUxGa6cDAtrP7PWQS0gtVf76YQ==
X-Received: by 2002:a5d:63c8:0:b0:371:86bc:6c05 with SMTP id ffacd0b85a97d-37311840242mr10099959f8f.10.1724842137588;
        Wed, 28 Aug 2024 03:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7EFzajU9R0cIfi0WpVWAwu9xU6E8957dEvkMylSwWZUSBfj7al0N2kiYw185R28Bx93YG8g==
X-Received: by 2002:a5d:63c8:0:b0:371:86bc:6c05 with SMTP id ffacd0b85a97d-37311840242mr10099930f8f.10.1724842136774;
        Wed, 28 Aug 2024 03:48:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a? (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de. [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba61c0666sm18312685e9.0.2024.08.28.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 03:48:56 -0700 (PDT)
Message-ID: <42aba316-2b01-4fdb-9aff-9e670aac4c6e@redhat.com>
Date: Wed, 28 Aug 2024 12:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: pgtable: introduce
 pte_offset_map_{ro|rw}_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hughd@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
 <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
 <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.24 06:33, Qi Zheng wrote:
> Hi David,
> 
> On 2024/8/26 23:21, David Hildenbrand wrote:
>> On 22.08.24 09:13, Qi Zheng wrote:
>>> Currently, the usage of pte_offset_map_nolock() can be divided into the
>>> following two cases:
>>>
>>> 1) After acquiring PTL, only read-only operations are performed on the
>>> PTE
>>>      page. In this case, the RCU lock in pte_offset_map_nolock() will
>>> ensure
>>>      that the PTE page will not be freed, and there is no need to worry
>>>      about whether the pmd entry is modified.
>>
>> There is also the usage where we don't grab the PTL at all, and only do
>> a racy (read-only) lookup.
> 
> IIUC, pte_offset_map() should be used instead of pte_offset_map_nolock()
> in this case.

Yes, but the filemap.c thingy conditionally wants to lock later. But I 
agree that pte_offset_map() is better when not even wanting to lock.

[...]

>>> accessor functions:
>>>     - pte_offset_map_nolock()
>>>        maps PTE, returns pointer to PTE with pointer to its PTE table
>>>        lock (not taken), or returns NULL if no PTE table;
>>
>> What will happen to pte_offset_map_nolock() after this series? Does it
>> still exist or will it become an internal helper?
> 
> I choose to remove it completely in [PATCH v2 13/14].
> 

Ah, great.

[...]

>> If someone thinks not requiring a non-NULL pointer is better, please
>> speak up, I'm not married to that idea :)
>>
>>> +    pte = __pte_offset_map(pmd, addr, &pmdval);
>>> +    if (likely(pte))
>>> +        *ptlp = pte_lockptr(mm, &pmdval);
>>> +    *pmdvalp = pmdval;
>>> +    return pte;
>>> +}
>>> +
>>>    /*
>>>     * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal
>>> implementation
>>>     * __pte_offset_map_lock() below, is usually called with the pmd
>>> pointer for
>>> @@ -356,6 +383,22 @@ pte_t *pte_offset_map_nolock(struct mm_struct
>>> *mm, pmd_t *pmd,
>>>     * recheck *pmd once the lock is taken; in practice, no callsite
>>> needs that -
>>>     * either the mmap_lock for write, or pte_same() check on contents,
>>> is enough.
>>>     *
>>> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
>>> + * pte_offset_map(); but when successful, it also outputs a pointer
>>> to the
>>> + * spinlock in ptlp - as pte_offset_map_lock() does, but in this case
>>> without
>>> + * locking it.  This helps the caller to avoid a later
>>> pte_lockptr(mm, *pmd),
>>> + * which might by that time act on a changed *pmd:
>>> pte_offset_map_ro_nolock()
>>> + * provides the correct spinlock pointer for the page table that it
>>> returns.
>>> + * For readonly case, the caller does not need to recheck *pmd after
>>> the lock is
>>> + * taken, because the RCU lock will ensure that the PTE page will not
>>> be freed. > + *
>>> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is
>>> like
>>> + * pte_offset_map_ro_nolock(); but when successful, it also outputs the
>>> + * pdmval. For cases where pte or pmd entries may be modified, that
>>> is, maywrite
>>> + * case, this can help the caller recheck *pmd once the lock is
>>> taken. In some
>>> + * cases, that is, either the mmap_lock for write, or pte_same()
>>> check on
>>> + * contents, is also enough to ensure that the pmd entry is stable.
>>> + *
>>>     * Note that free_pgtables(), used after unmapping detached vmas, or
>>> when
>>>     * exiting the whole mm, does not take page table lock before
>>> freeing a page
>>>     * table, and may not use RCU at all: "outsiders" like khugepaged
>>> should avoid
>>
>> In general to me a step into the right direction. Likely the
>> documentation could be further clarified in some aspects:
>>
>> Like that the use of pte_offset_map_ro_nolock() does not allow to easily
>> identify if the page table was replaced in the meantime. Even after
>> grabbing the PTL, we might be looking either at a page table that is
>> still mapped or one that was unmapped and is about to get freed. But for
>> R/O access this is usually sufficient AFAIUK.
>>
>> Or that "RO" / "RW" expresses the intended semantics, not that the
>> *kmap* will be RO/RW protected.
> 
> How about the following:
> 
> pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
> pte_offset_map(); but when successful, it also outputs a pointer to the
> spinlock in ptlp - as pte_offset_map_lock() does, but in this case
> without locking it.  This helps the caller to avoid a later
> pte_lockptr(mm, *pmd), which might by that time act on a changed *pmd:
> pte_offset_map_ro_nolock() provides the correct spinlock pointer for the
> page table that it returns. Even after grabbing the spinlock, we might
> be looking either at a page table that is still mapped or one that was
> unmapped and is about to get freed. But for R/O access this is usually
> sufficient AFAIUK.

Drop the "AFAIUK" :)

"For R/O access this is sufficient."

> 
> pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
> pte_offset_map_ro_nolock(); but when successful, it also outputs the
> pdmval. For R/W access, the callers can not accept that the page table
> it sees has been unmapped and is about to get freed. The pmdval can help
> callers to recheck pmd_same() to identify this case once the spinlock is
> taken. For some cases where exclusivity is already guaranteed, such as
> holding the write lock of mmap_lock, or in cases where checking is
> sufficient, such as a !pte_none() pte will be rechecked after the
> spinlock is taken, there is no need to recheck pdmval.

Right, using pte_same() one can achieve a similar result, assuming that 
the freed page table gets all ptes set to pte_none().

page_table_check_pte_clear_range() before pte_free_defer() in 
retract_page_tables/collapse_pte_mapped_thp() sanity checks that I think.

In collapse_huge_page() that is not the case. But here, we also 
currently grab all heavily locks, to prevent any concurrent page table 
walker.

> 
> Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
> will be RO/RW protected.


Good. Please also incorporate the feedback from Muchun.

-- 
Cheers,

David / dhildenb



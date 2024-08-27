Return-Path: <linux-kernel+bounces-302559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC2960057
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DF928342F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8E4AEDA;
	Tue, 27 Aug 2024 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OUWPwCRn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BC179A8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733244; cv=none; b=nvMUodhYkcK8dyg12Z4IEnxaysc8FyPKHrICf9+CFsliUxuqzZlGeOnpErPDH6q6BDkxAFLbd7QcbRUjGdb6RQ1vuIxtbq77++6bBKYhem8eQh22DW0dpQ/0Z+LrHoYjzsnXpRE50vIOo03gR1CjPN05QGe+4y6FdH3HRvoI3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733244; c=relaxed/simple;
	bh=MO5I2e9ONvRAoB2XZAEH4wscyTi2MOzeke37ZdaJM1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL5NQYUa3m7VYC1zX1PkD7bOGVnc6JWVnt9nPzfVBPQcmtU9TlB90a1TObGNYPKLC6SlNvqk2pb0mYpiMEEJ3jLzCDbDmdDtVvjc94YUWlI0qwnYYb+6VNs5OfcYIqB3Wlxo+dfrXpulnTOtILHCWX2+XHCPnLRisW9k67a7vyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OUWPwCRn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2020ac89cabso44844545ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724733241; x=1725338041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq87ZON6ZNMLSUnrDlDs3pHFeMkFR+bTi97+RCtdjic=;
        b=OUWPwCRnCWpPbFcHZ3oDNLW4oxQf8kTuMkLJQ4UcTADaJBeHIOd+IPtVwWKEmUUwvC
         P8yQV7uBpSKlOs4209RmavS7NiTsAclDZTxXvAJbE/uGQzGgXcGzKl5t0MPlHGJCw1fc
         +5JIG/3+83TMgjy9Ai0Eivw5K7Ad+yxppYMuGGE94KhOl3gIQqw0x98NnlXo7KU0lCWB
         RM1nLz2FoxV7ZA+SMEoiRdAJU1LUpVhQfEhTt1F2yMvdBwH4JzP5xlQwCU4IFIMnNWt7
         ozzQBFuTSlTWaNZW4A7jjjlptsqYbUQX9i3L/anKauwDD8XX11ZGnUxGEUt3ANvBNzku
         kuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724733241; x=1725338041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq87ZON6ZNMLSUnrDlDs3pHFeMkFR+bTi97+RCtdjic=;
        b=q6ct830NsyIVQMRHBWTxfZBJXfBGLMRQRif3ZHBf872ZqNaS9qFWlXGomHBz/vNVFX
         1Z5RKAsH8QqOnDfUW6Wq1KWKM2pE3BeRKf2SrFlf72PeOedKKrqCRF3DOLrjTgoOb/Xb
         M82VhOZeKMSeuMM7/DoB+3fewPAyKVrzzTlyv9Z7Z8M+kuQNKPNr4en4dTOjBLw1/TUi
         a7z0c1NaGkJhKUESNgJTnr3bxZoV0v1k7VrfW8159yzaAz4bftWcz0+YKPl49OiB67JV
         AIrinG7BOuei544SRudZ+gBavm9aYYz3FIYRbhW5KQp191CTEX7cRa2vY21yS16bDSUG
         8DUA==
X-Forwarded-Encrypted: i=1; AJvYcCXXrJveFsI+AYgS+hzfi9uFt4NIXGb4y/AVg5gcBcCBUhThj8JkOug0i7fk+Q8dBYT4C35XQsoVqQs0xPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsULRFtK+Gvb5yT5gwCeTsiwI3GKkVvJIgzFpUU3quOzX2BOmx
	isLWyleGzAOf/TTlph7b5bdIzsjQPzJCtmJ3zGVZiIMGFDXvmmRIiFZ695SMaOQ=
X-Google-Smtp-Source: AGHT+IGrjg/3DusjsTQ/CyMwBnOzZDq+gba6Du2dXt4+TdxTJQagehvc1DJvTP0xEmtvYDB7oJxjZw==
X-Received: by 2002:a17:902:db0d:b0:201:df0b:2b5d with SMTP id d9443c01a7336-2039e52da6cmr106666295ad.64.1724733241304;
        Mon, 26 Aug 2024 21:34:01 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df793sm75232815ad.155.2024.08.26.21.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 21:34:00 -0700 (PDT)
Message-ID: <4481a0e4-a7a5-4223-a8ab-d1215d7c6352@bytedance.com>
Date: Tue, 27 Aug 2024 12:33:53 +0800
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
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
 <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <f318f65d-4198-481c-98a0-00415664614c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

On 2024/8/26 23:21, David Hildenbrand wrote:
> On 22.08.24 09:13, Qi Zheng wrote:
>> Currently, the usage of pte_offset_map_nolock() can be divided into the
>> following two cases:
>>
>> 1) After acquiring PTL, only read-only operations are performed on the 
>> PTE
>>     page. In this case, the RCU lock in pte_offset_map_nolock() will 
>> ensure
>>     that the PTE page will not be freed, and there is no need to worry
>>     about whether the pmd entry is modified.
> 
> There is also the usage where we don't grab the PTL at all, and only do 
> a racy (read-only) lookup.

IIUC, pte_offset_map() should be used instead of pte_offset_map_nolock()
in this case.

> 
>>
>> 2) After acquiring PTL, the pte or pmd entries may be modified. At this
>>     time, we need to ensure that the pmd entry has not been modified
>>     concurrently.
>>
>> To more clearing distinguish between these two cases, this commit
>> introduces two new helper functions to replace pte_offset_map_nolock().
>> For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
>> to changing the name to pte_offset_map_rw_nolock(), it also outputs the
>> pmdval when successful. This can help the caller recheck *pmd once the 
>> PTL
>> is taken. In some cases, that is, either the mmap_lock for write, or
>> pte_same() check on contents, is also enough to ensure that the pmd entry
>> is stable. But in order to prevent the interface from being abused, we
>> choose to pass in a dummy local variable instead of NULL.
>>
>> Subsequent commits will convert pte_offset_map_nolock() into the above
>> two functions one by one, and finally completely delete it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   Documentation/mm/split_page_table_lock.rst |  7 ++++
>>   include/linux/mm.h                         |  5 +++
>>   mm/pgtable-generic.c                       | 43 ++++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/Documentation/mm/split_page_table_lock.rst 
>> b/Documentation/mm/split_page_table_lock.rst
>> index e4f6972eb6c04..08d0e706a32db 100644
>> --- a/Documentation/mm/split_page_table_lock.rst
>> +++ b/Documentation/mm/split_page_table_lock.rst
>> @@ -19,6 +19,13 @@ There are helpers to lock/unlock a table and other 
>> accessor functions:
>>    - pte_offset_map_nolock()
>>       maps PTE, returns pointer to PTE with pointer to its PTE table
>>       lock (not taken), or returns NULL if no PTE table;
> 
> What will happen to pte_offset_map_nolock() after this series? Does it 
> still exist or will it become an internal helper?

I choose to remove it completely in [PATCH v2 13/14].

> 
>> + - pte_offset_map_ro_nolock()
>> +    maps PTE, returns pointer to PTE with pointer to its PTE table
>> +    lock (not taken), or returns NULL if no PTE table;
>> + - pte_offset_map_rw_nolock()
>> +    maps PTE, returns pointer to PTE with pointer to its PTE table
>> +    lock (not taken) and the value of its pmd entry, or returns NULL
>> +    if no PTE table;
> 
> [...]
> 
>> +pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>> +                unsigned long addr, pmd_t *pmdvalp,
>> +                spinlock_t **ptlp)
>> +{
>> +    pmd_t pmdval;
>> +    pte_t *pte;
>> +
>> +    BUG_ON(!pmdvalp);
> 
> As raised, no BUG_ON please. VM_WARN_ON_ONCE() is helpful during early 
> testing and should catch these kind of things.

OK, this patch was sent before you pointed out this, will use
VM_WARN_ON_ONCE() instead of BUG_ON() in v3.

> 
> If someone thinks not requiring a non-NULL pointer is better, please 
> speak up, I'm not married to that idea :)
> 
>> +    pte = __pte_offset_map(pmd, addr, &pmdval);
>> +    if (likely(pte))
>> +        *ptlp = pte_lockptr(mm, &pmdval);
>> +    *pmdvalp = pmdval;
>> +    return pte;
>> +}
>> +
>>   /*
>>    * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal 
>> implementation
>>    * __pte_offset_map_lock() below, is usually called with the pmd 
>> pointer for
>> @@ -356,6 +383,22 @@ pte_t *pte_offset_map_nolock(struct mm_struct 
>> *mm, pmd_t *pmd,
>>    * recheck *pmd once the lock is taken; in practice, no callsite 
>> needs that -
>>    * either the mmap_lock for write, or pte_same() check on contents, 
>> is enough.
>>    *
>> + * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
>> + * pte_offset_map(); but when successful, it also outputs a pointer 
>> to the
>> + * spinlock in ptlp - as pte_offset_map_lock() does, but in this case 
>> without
>> + * locking it.  This helps the caller to avoid a later 
>> pte_lockptr(mm, *pmd),
>> + * which might by that time act on a changed *pmd: 
>> pte_offset_map_ro_nolock()
>> + * provides the correct spinlock pointer for the page table that it 
>> returns.
>> + * For readonly case, the caller does not need to recheck *pmd after 
>> the lock is
>> + * taken, because the RCU lock will ensure that the PTE page will not 
>> be freed. > + *
>> + * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is 
>> like
>> + * pte_offset_map_ro_nolock(); but when successful, it also outputs the
>> + * pdmval. For cases where pte or pmd entries may be modified, that 
>> is, maywrite
>> + * case, this can help the caller recheck *pmd once the lock is 
>> taken. In some
>> + * cases, that is, either the mmap_lock for write, or pte_same() 
>> check on
>> + * contents, is also enough to ensure that the pmd entry is stable.
>> + *
>>    * Note that free_pgtables(), used after unmapping detached vmas, or 
>> when
>>    * exiting the whole mm, does not take page table lock before 
>> freeing a page
>>    * table, and may not use RCU at all: "outsiders" like khugepaged 
>> should avoid
> 
> In general to me a step into the right direction. Likely the 
> documentation could be further clarified in some aspects:
> 
> Like that the use of pte_offset_map_ro_nolock() does not allow to easily 
> identify if the page table was replaced in the meantime. Even after 
> grabbing the PTL, we might be looking either at a page table that is 
> still mapped or one that was unmapped and is about to get freed. But for 
> R/O access this is usually sufficient AFAIUK.
> 
> Or that "RO" / "RW" expresses the intended semantics, not that the 
> *kmap* will be RO/RW protected.

How about the following:

pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
pte_offset_map(); but when successful, it also outputs a pointer to the
spinlock in ptlp - as pte_offset_map_lock() does, but in this case
without locking it.  This helps the caller to avoid a later
pte_lockptr(mm, *pmd), which might by that time act on a changed *pmd:
pte_offset_map_ro_nolock() provides the correct spinlock pointer for the
page table that it returns. Even after grabbing the spinlock, we might
be looking either at a page table that is still mapped or one that was 
unmapped and is about to get freed. But for R/O access this is usually
sufficient AFAIUK.

pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
pte_offset_map_ro_nolock(); but when successful, it also outputs the
pdmval. For R/W access, the callers can not accept that the page table
it sees has been unmapped and is about to get freed. The pmdval can help
callers to recheck pmd_same() to identify this case once the spinlock is
taken. For some cases where exclusivity is already guaranteed, such as
holding the write lock of mmap_lock, or in cases where checking is
sufficient, such as a !pte_none() pte will be rechecked after the
spinlock is taken, there is no need to recheck pdmval.

Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
will be RO/RW protected.

Thanks,
Qi

> 


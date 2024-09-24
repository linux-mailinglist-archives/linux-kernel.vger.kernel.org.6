Return-Path: <linux-kernel+bounces-336765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E744E984090
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793B2B22640
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CE1487FE;
	Tue, 24 Sep 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xxl4SDVe"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A14286
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166843; cv=none; b=RqTXDsxtmAIqpAfjL6JtNMMi+7NFCskOdd5B4dbi7Hd27MdU3p03c+3454dc83UufAjmY5w9lSXxMyI25aJucZxZi96DLzRmxsW64JKmntG2FhzzdgdtxisLI4ErgH2y+1RxKqPNNWfL948YFF4YT0jiwkESscQ9HrCeinj7Ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166843; c=relaxed/simple;
	bh=k0Kf7Z7yRo1RyzHNmkcQBvttuX4s9D4GgvIem/3oP7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bD6plIYBJhOapB65LooX3sEXVtC+pcvQuAyqFtyEau5RavPqjI9UxgJ3nnALWmcm0OoSuy94dt/2GjPa3kw80kqCTFnKsBjGmnQrqI08mxfsmA/jaDWOwZK4a2SwsQdJo3ZTEmYPtZ3ZqveBOu8UvN9I/b8i/aJjvO9/VndpfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xxl4SDVe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206e614953aso50514075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727166840; x=1727771640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBUNOy5kKW7QWknxeNIjK0yZwggERJ1vSRDkc0sCRPc=;
        b=Xxl4SDVekwLQ1Qp7zhv8r7qPBa3tG9Chw1s9Nj7o4MjCbWGxKmdm11yquo7Naz4eOL
         0eX+qHPFMF4kEvtGwNMZ3yUPa4s8Eh++NWelpjbXjIBbGKCc0XIMYNXaxUFpatvVAUXo
         a4/KqkJh1PprYMF0A91aFbyanizvZpvlIm5um2/D670/ks2NkC6FYboRcuXnmzdadyVt
         CkKdd6YjXHVqI/vwXxbTDX0+S00yDUR2BDhnFZP+X/IL15hvDbSJ0GvGa5eVjaIvXzsu
         jzfY8W/sxEXT2VRlsRV69bTx/ikMHzMGjvT6jT+HuEzXq4yr5HB2E8XwnjKTIsXZelku
         yLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727166840; x=1727771640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBUNOy5kKW7QWknxeNIjK0yZwggERJ1vSRDkc0sCRPc=;
        b=Zwk7grzqsHS4KjFB6VDsXALvhp9mP51Y36L/ChDfrQv419peXavL9x3rhSA7mZCVo/
         DR7ZktigHnAqlr5Vg6LbKti1GyQ5JFkjxRCTCdTmN24u6LkRKzkzrnRl/FLME6RkyaDh
         1v00Ri7SK4RUI4DNc3AdXvrO6N8tAG5q3/Mi8J00aV1RGsmNkE0r2J+aWPG3WuFIIQcE
         T2daOZ8lUhYw8b+hmYYXo9qm5OUIlVMtdWtHie6OuKe/hP0WGVU4eby9bJrqaU1kQWuA
         1D9eGJYEVySpfzfUvfyJwyqE1MGOViN4zvMtwcvtJq1WhSyl8p2U2xpQAPKsVJ54hKpw
         RHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2kkv39O+2i2Z0OJqwS41vyetXPdN8NYRnGpuFbPXU76rtZRoJqDhNXNml3z+3Fsmt/xYCCrwzDtHwHCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln0yo+ieRlDcBqERLo4d5pZ5Cxh+B4uQBWSVhM1dlP2zdyqXr
	A9mMcgj76ibpEjH2i1f5CcDYx5Rgx5Wx/KXCNmRjlia3M6jYkMpZQ9wkLfHkeXxYY0T4+SDAypU
	X
X-Google-Smtp-Source: AGHT+IGA58OvjKH0J4J2cIX3fLSuJFJn0gN/GxxZsycyrte2t3fRU9GFiUDq/Yj/11t+E+u1iwSoVA==
X-Received: by 2002:a17:90a:744d:b0:2d8:b075:7862 with SMTP id 98e67ed59e1d1-2dd7f380806mr18925374a91.5.1727166840378;
        Tue, 24 Sep 2024 01:34:00 -0700 (PDT)
Received: from [10.68.125.128] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058f2e2f5sm953563a91.24.2024.09.24.01.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:33:59 -0700 (PDT)
Message-ID: <cccc53fc-29c2-43c0-83d4-d330bade70c7@bytedance.com>
Date: Tue, 24 Sep 2024 16:33:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] mm: page_vma_mapped_walk: map_pte() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <ecffb7d71363fa79048c0a929780215e0fa93491.1727148662.git.zhengqi.arch@bytedance.com>
 <E2AAD3DA-4C73-4785-939C-13164FA8543D@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <E2AAD3DA-4C73-4785-939C-13164FA8543D@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 16:25, Muchun Song wrote:
> 
> 
>> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> ﻿In the caller of map_pte(), we may modify the pvmw->pte after acquiring
>> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
>> this time, the pte_same() check is not performed after the pvmw->ptl held,
>> so we should get pmdval and do pmd_same() check to ensure the stability of
>> pvmw->pmd.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> mm/page_vma_mapped.c | 25 ++++++++++++++++++++-----
>> 1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index ae5cc42aa2087..6410f29b37c1b 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
>>     return false;
>> }
>>
>> -static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>> +static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>> +            spinlock_t **ptlp)
>> {
>>     pte_t ptent;
>> +    pmd_t pmdval;
> 
> Why declare a new variable? Can’t we use *pmdvalp instead?

It's just a coding habit, both are fine for me.

> 
>>
>>     if (pvmw->flags & PVMW_SYNC) {
>>         /* Use the stricter lookup */
>> @@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>         return !!pvmw->pte;
>>     }
>>
>> +again:
>>     /*
>>      * It is important to return the ptl corresponding to pte,
>>      * in case *pvmw->pmd changes underneath us; so we need to
>> @@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>      * proceeds to loop over next ptes, and finds a match later.
>>      * Though, in most cases, page lock already protects this.
>>      */
>> -    pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>> -                      pvmw->address, ptlp);
>> +    pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>> +                         pvmw->address, &pmdval, ptlp);
>>     if (!pvmw->pte)
>>         return false;
>> +    *pmdvalp = pmdval;
>>
>>     ptent = ptep_get(pvmw->pte);
>>
>> @@ -67,8 +71,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>     } else if (!pte_present(ptent)) {
>>         return false;
>>     }
>> +    spin_lock(*ptlp);
>> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
>> +        pte_unmap_unlock(pvmw->pte, *ptlp);
>> +        goto again;
>> +    }
>>     pvmw->ptl = *ptlp;
>> -    spin_lock(pvmw->ptl);
>> +
>>     return true;
>> }
>>
>> @@ -278,7 +287,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>             step_forward(pvmw, PMD_SIZE);
>>             continue;
>>         }
>> -        if (!map_pte(pvmw, &ptl)) {
>> +        if (!map_pte(pvmw, &pmde, &ptl)) {
>>             if (!pvmw->pte)
>>                 goto restart;
>>             goto next_pte;
>> @@ -307,6 +316,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>         if (!pvmw->ptl) {
>>             pvmw->ptl = ptl;
>>             spin_lock(pvmw->ptl);
>> +            if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
>> +                pte_unmap_unlock(pvmw->pte, pvmw->ptl);
>> +                pvmw->ptl = NULL;
>> +                pvmw->pte = NULL;
>> +                goto restart;
>> +            }
>>         }
>>         goto this_pte;
>>     } while (pvmw->address < end);
>> --
>> 2.20.1
>>


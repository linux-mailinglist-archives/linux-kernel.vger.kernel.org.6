Return-Path: <linux-kernel+bounces-316880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E496D678
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0BFB24E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670419923A;
	Thu,  5 Sep 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MHyRPsjM"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65168198E9B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533724; cv=none; b=HZ4EY0bFMJ+m/iQw6CjOSTVn5xooelb6sCldStFMgHlbijIjDl/OiGoHQEMBNdVanKT+mHpRXuCJTnQaYG+UKd9gSEnWtX8p8BcWIwtQBCC3sTeVK4KkP1xnYmk1pA7w2Ol+SAs4nPiz4Oo1DsvQ0ZMMaU0STv3kiBLtt+6xYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533724; c=relaxed/simple;
	bh=zLBIXrBgJg+hAvxM3CbryB/TdYdOAdqUb7SIvpkEOtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGsgI8lPUm/SkSonvQeroFLLInsxVANEVHqX1+d6YtFo5cha2L21xMP0mtq0Ek3s+7xEn5lZr0d31NXWJHZLyNBn/r/JYhZVzm9HzyEwKZcfD+w97pChaGp35955aDOeOMTScVpnjcrNXBfZJuoD/k70SFlOpO4B88sj0UgxooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MHyRPsjM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so448751a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725533721; x=1726138521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXAtAu/pzenP53Rc519mW1EiWpptEkcfZ6dVtHtfUqo=;
        b=MHyRPsjMYeAq0TuyubiRIicg3SN2EOghigaY3JXQo0Md4M5nTPqxhp/1zgqFW0GkeH
         gaQzQFP9JHY+NkL5qaZMV5Uwo9B6MijARZkZh7lycqulmd4KH5Zd6UBjx+EAJqinugWO
         IVQ8JWKwBtRvx3HlbOjeXwvNw+aXnFpjPtJuVUmVRGLohSkiLXPJ0R/gVQfUWwTQsEXj
         cFDAgj/AIo1/9iWDq+zregH2IIUrvcY26N1P4KLOHgTjHf4dCkE8Ts7FSZCAW30IrSiL
         gvGDW9C6XEmh4bwOR3o4ji0Bq5amZjV0sLN00bIzn449cyZ84Wymg11QIvAZYqWD9kBG
         AB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533721; x=1726138521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXAtAu/pzenP53Rc519mW1EiWpptEkcfZ6dVtHtfUqo=;
        b=jDbZwEh/2EtNVCsHoCpfYAGAh22w0ZLfDKmjgM65js6YRjfwfUgkEM8nEbL6RVNhU1
         +yDVLnW84T2LOcMA9hwQlIWADVJx+dVBXF94GSpCliLHppI2Z/ivNf99htDINIadOaE+
         bN7RZdJozkMsHmYQ5JatUUxUoJswlGc0wv4YYVZMepjQC0nQgLKqTAGQAeAVgdb9iNhv
         A/11Lp6a2Vnb6t7PCfKGNkz6jgTIDymihFA0IZLuxW+XoK1ppVSpn7Vaicfs0FU5SNAs
         SrB/rC72SOmogPxL0j6kjwg+8maMXi8sE+vw7SxH0WWaTL7Dyro/0ran5YM2Z9ukbkpB
         bX2Q==
X-Gm-Message-State: AOJu0Yz8J5WxULN57wDdTjF+qIPUBVrXBD1K7rYA0ezlRFmccJZOHSpV
	lo4dmZbLVb/metwTUQnDhQusA4tqKcUiQ3jrQNhWfAyFUEZ3NmeOQ2AQP+LVfCA=
X-Google-Smtp-Source: AGHT+IEWI9EEiau/fdkKJLT8cSCi5xdgACnD/Y6KuBmHJCn7wH50I5yB/XRIbn+3AgAGKvj46vvmDA==
X-Received: by 2002:a17:90a:780b:b0:2d8:bb95:56f6 with SMTP id 98e67ed59e1d1-2da74cfc83dmr8851317a91.30.1725533721492;
        Thu, 05 Sep 2024 03:55:21 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b8fe1f68sm9312094a91.31.2024.09.05.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:55:21 -0700 (PDT)
Message-ID: <03ebc281-c8e1-461b-a716-be6162947d31@bytedance.com>
Date: Thu, 5 Sep 2024 18:55:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-9-zhengqi.arch@bytedance.com>
 <d8e2ef66-c345-43f0-9989-f20f16df34d3@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d8e2ef66-c345-43f0-9989-f20f16df34d3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/5 16:57, Muchun Song wrote:
> 
> 
> On 2024/9/4 16:40, Qi Zheng wrote:
>> In copy_pte_range(), we may modify the src_pte entry after holding the
>> src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we may
>> free the PTE page in retract_page_tables() without holding the read lock
>> of mmap_lock, so we still need to get pmdval and do pmd_same() check 
>> after
>> the ptl is held.
> 
> See commit 3db82b9374ca92, copy_pte_range and retract_page_tables
> are using vma->anon_vma to be exclusive.
> 
> retract_page_tables()                    copy_page_range()
>      vma_interval_tree_foreach()              if (!vma_needs_copy())
>          if (READ_ONCE(vma->anon_vma))            return 0;
>              continue;                        copy_pte_range()
> 
> So I think mmap write lock here is also used for keeping ->anon_vma stable.
> And we do not need pmd_same().

Indeed, will change it in v4. Thanks!

> 
> Muchun,
> Thanks.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> Hi Muchun, since the code has changed, I dropped your Reviewed-by tag 
>> here.
>>
>>   mm/memory.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 06674f94b7a4e..47974cc4bd7f2 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1082,6 +1082,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, 
>> struct vm_area_struct *src_vma,
>>       struct mm_struct *src_mm = src_vma->vm_mm;
>>       pte_t *orig_src_pte, *orig_dst_pte;
>>       pte_t *src_pte, *dst_pte;
>> +    pmd_t pmdval;
>>       pte_t ptent;
>>       spinlock_t *src_ptl, *dst_ptl;
>>       int progress, max_nr, ret = 0;
>> @@ -1107,13 +1108,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, 
>> struct vm_area_struct *src_vma,
>>           ret = -ENOMEM;
>>           goto out;
>>       }
>> -    src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
>> +
>> +    /*
>> +     * Since we may free the PTE page in retract_page_tables() without
>> +     * holding the read lock of mmap_lock, so we still need to do a
>> +     * pmd_same() check after holding the PTL.
>> +     */
>> +    src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &pmdval,
>> +                       &src_ptl);
>>       if (!src_pte) {
>>           pte_unmap_unlock(dst_pte, dst_ptl);
>>           /* ret == 0 */
>>           goto out;
>>       }
>>       spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>> +
>> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(src_pmd)))) {
>> +        pte_unmap_unlock(src_pte, src_ptl);
>> +        pte_unmap_unlock(dst_pte, dst_ptl);
>> +        /* ret == 0 */
>> +        goto out;
>> +    }
>> +
>>       orig_src_pte = src_pte;
>>       orig_dst_pte = dst_pte;
>>       arch_enter_lazy_mmu_mode();
> 


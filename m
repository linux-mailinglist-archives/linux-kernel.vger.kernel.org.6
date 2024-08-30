Return-Path: <linux-kernel+bounces-308148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042D79657D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DA0B23552
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D661531C3;
	Fri, 30 Aug 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gdOgsTx+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68A14F9CA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000869; cv=none; b=YZnaiUdZ6GR0OjuNbkjd7riJJ+8BE3dco5h9y09iEwojhu7Fg9LQhGn/GTwUTL4QJtZuNar067z6p69lV4upOaRbnPs5GvaXHxiKg8y8p7OYQY3XCcqwZ97J+o5VQhaYGF6fN5KhboljC7LQmtoyhEdOkLsKzxxk6TZdRgV77I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000869; c=relaxed/simple;
	bh=2ecgnUADCd1piMzvWRREU+g9VZtrSftc73RwwPKI0N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMmTx01CXYr8tmGoAyfnka5MQ918KVkzFCaqINkTm49+hGNHQg1C9FlV8PiWdsZcoKhVzCC4OG5kcJaoqgGuiu0J8Mo3wVn7XRkcYnQCxiZl6dvxVl6dCEELzJBRHWMU8Yw03JBge7o/UxfhfrWiuz+LG0Ts6yqIAcMcWgq0jT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gdOgsTx+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fba05363so13166525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725000867; x=1725605667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JXsfI13QxQMuq1bhCiFBSW4jYSMwXLCeILFvF2AASUw=;
        b=gdOgsTx+X8CaMaXTyJuy468DmeCyYBKeumvbrn/tw1vFGvp4ufrMY4pJ5SY2xJa2Hq
         8kOAKbQuZ24O1wLECC1Zi9224UTtzGBjJ0KZjp7m1IDk2RnSIGQqGF/UGooQhhO8g73L
         aMgFthjB4BF9lrSJIMVX/anFyHW92KhpixAigFQgM+RXlCMecaEWwQVcl+sPnO5cDiQC
         3BdasVPSKQVu6N7tFsOrqTR4gz6YfKKsPXY3tV8ZGPwwwiMHGm8BhcMY1ZLx8iP2k2tG
         56prflDumkYAYCqtuPQQGBpADnwVtD3DNWoAidwjOFklZpTSDqs4aLcLCKOJRAb3/YHO
         nRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000867; x=1725605667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXsfI13QxQMuq1bhCiFBSW4jYSMwXLCeILFvF2AASUw=;
        b=Vv8QWk11tL3xFA8Tqv+aFbZC1CD4aY5ulEWs+ZnGCkoqM82xdc6dInkVtFAN8CJkcU
         3vBrGyqpukMMe3R3jygpijMA25ekfLhepnN6yn7WOkdTZUx0APDm26Tu3sPcnQNJrRqb
         J/BVk3VPzv2KeFqLenWnWGPtpEJ0JDyXEbateAvSIuRFksgNgtJfcbPpFpuFi8DueV81
         pvBGAK8IEKWPY2QvbFgm/ZLX9WrAPEENMsRp9pYvmdX+pA6kyXlmZsbP2nlKSriCb2Sn
         HXwyoG7aWASSNbRvocVPTB0zisRzsUm/IYD7C4UgOPzowz1jNTD4CfTBfycVnETkxWyJ
         MamA==
X-Forwarded-Encrypted: i=1; AJvYcCXHMFDhoUSpNH986aqe0eQX9ra/g36KN+d8qu35EXbRNUpE2os93fL5DFLgtFat2M9lBKFH4rRJbc62eC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzWj1+GhMb35JTsiuxiTlq48Gxb6Jzl5WXVdYDW720liAXef8
	fYr015Z/99lQCYcEbh+hiY+gXSLYyebZBccXQ0WgNTvcmTp4T3OOvnsyj75Us2MekxERVn9MFIf
	Y
X-Google-Smtp-Source: AGHT+IHQyky+Kk9qEKi7IWE1UWr/UmQJSB+2gVrWMjTiY9kash16TX5475rtXBjRZ94+FApWIS8qXA==
X-Received: by 2002:a17:902:e5c3:b0:202:35cb:b0c6 with SMTP id d9443c01a7336-2050c3bf6e5mr52764945ad.34.1725000866519;
        Thu, 29 Aug 2024 23:54:26 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155452ecsm20825575ad.219.2024.08.29.23.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 23:54:26 -0700 (PDT)
Message-ID: <cd137540-ae01-46a1-93d2-062bc21b827c@bytedance.com>
Date: Fri, 30 Aug 2024 14:54:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <c377dab2bf55950e6155ea051aba3887ed5a2773.1724310149.git.zhengqi.arch@bytedance.com>
 <24be821f-a95f-47f1-879a-c392a79072cc@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <24be821f-a95f-47f1-879a-c392a79072cc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/29 16:10, Muchun Song wrote:
> 
> 
> On 2024/8/22 15:13, Qi Zheng wrote:
>> In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
>> this time, the write lock of mmap_lock is not held, and the pte_same()
>> check is not performed after the PTL held. So we should get pgt_pmd 
>> and do
>> pmd_same() check after the ptl held.
>>
>> For the case where the ptl is released first and then the pml is 
>> acquired,
>> the PTE page may have been freed, so we must do pmd_same() check before
>> reacquiring the ptl.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/khugepaged.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 53bfa7f4b7f82..15d3f7f3c65f2 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1604,7 +1604,7 @@ int collapse_pte_mapped_thp(struct mm_struct 
>> *mm, unsigned long addr,
>>       if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>           pml = pmd_lock(mm, pmd);
>> -    start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>> +    start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, 
>> &ptl);
>>       if (!start_pte)        /* mmap_lock + page lock should prevent 
>> this */
>>           goto abort;
>>       if (!pml)
>> @@ -1612,6 +1612,9 @@ int collapse_pte_mapped_thp(struct mm_struct 
>> *mm, unsigned long addr,
>>       else if (ptl != pml)
>>           spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>> +        goto abort;
>> +
>>       /* step 2: clear page table and adjust rmap */
>>       for (i = 0, addr = haddr, pte = start_pte;
>>            i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>> @@ -1657,6 +1660,16 @@ int collapse_pte_mapped_thp(struct mm_struct 
>> *mm, unsigned long addr,
>>       /* step 4: remove empty page table */
>>       if (!pml) {
>>           pml = pmd_lock(mm, pmd);
>> +        /*
>> +         * We called pte_unmap() and release the ptl before acquiring
>> +         * the pml, which means we left the RCU critical section, so the
>> +         * PTE page may have been freed, so we must do pmd_same() check
>> +         * before reacquiring the ptl.
>> +         */
>> +        if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>> +            spin_unlock(pml);
>> +            goto pmd_change;
> 
> Seems we forget to flush TLB since we've cleared some pte entry?

See comment above the ptep_clear():

/*
  * Must clear entry, or a racing truncate may re-remove it.
  * TLB flush can be left until pmdp_collapse_flush() does it.
  * PTE dirty? Shmem page is already dirty; file is read-only.
  */

The TLB flush was handed over to pmdp_collapse_flush(). If a
concurrent thread free the PTE page at this time, the TLB will
also be flushed after pmd_clear().

> 
>> +        }
>>           if (ptl != pml)
>>               spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>       }
>> @@ -1688,6 +1701,7 @@ int collapse_pte_mapped_thp(struct mm_struct 
>> *mm, unsigned long addr,
>>           pte_unmap_unlock(start_pte, ptl);
>>       if (pml && pml != ptl)
>>           spin_unlock(pml);
>> +pmd_change:
>>       if (notified)
>>           mmu_notifier_invalidate_range_end(&range);
>>   drop_folio:
> 


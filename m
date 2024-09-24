Return-Path: <linux-kernel+bounces-336674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC2983F13
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B441F22646
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3A145B2E;
	Tue, 24 Sep 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XcAmLw5R"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC89145B1F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162965; cv=none; b=PqJOaqvnkM/KdnZve9TMtpcHNpMul8XWMGKUuuqvWv7pYLWYlwGuI/L3gRj0BUSU1/bEAg8VZqqzVnHeuKQaXbkqx+fnvcMS7hX9mLdLwpw5z2TjKx1LqM2RqwsV5Z2L1sZC0fJ7CACnKJFcVU81ocWr7xzP1U93IAZBX9ifakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162965; c=relaxed/simple;
	bh=q0EI1LKXCsv9I/M7oRqMz7tDEz22v9H6CIUT9f0P1AI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOjy/QxrsDLqEXIBhoXb66zoHpPGzh4DDbVD+4cj65+KJ0bO0pBAKPCuKib7FHnVl62GMqX4Sam75Np+tA3DpLrZztPGeU9oum8dQq7CCwAsCPc4K/4YAWQRc3J7ol6kX6w4y9XlvrSf0amIEhe6j8G/Sx0kf+QYYL3shof3zZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XcAmLw5R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7191fb54147so3818799b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727162962; x=1727767762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2PX+4bvLDBXLZ7VO01vqg1hyq+vLyU3jjzE13L5vTo=;
        b=XcAmLw5R5d1TtqzXU2Y946fwQijOep6x/NjHABHPI8FhHB4UaaGB2rKYxlRyR52HvH
         5X116PKlA4g3s/xKZWMLTTec6WdWAyTXuHi83QC41jUsEhujllbIexfnjRmAGyzmj5Pg
         puWM2X+FKMIgNNjK22k6iFvscJd1j42tqMX7aH+Busy1Gm0iScN6mqp0bxLleJpcqXdV
         8oGxeEPYEDeQjo9CM7nzHKU4a+9fUT3RL1cELOKo7A0vjPS8Za40xjRiUFHOWFbOrxBx
         hy3qt3gWe3GRfKpd5Od7xBGWdbtV8NphpqLLHU8k9hG+bmkPst2mtnkF+GKd2h11cyXl
         6Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162962; x=1727767762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2PX+4bvLDBXLZ7VO01vqg1hyq+vLyU3jjzE13L5vTo=;
        b=CF9GqHELOJsLfwzc7EH9uCmuGEXFqy81yw4A8OvawQa9Y6CTYR2qV7zdKcRAQ8GvFh
         Qy/rhVDbw/mC5I3V4YOxfj0of2GqSRsWLmx0wpM2UaWaM7oSBMnjROspr1xlhcNCgdR9
         ThX3ZQcOOgxLTQvS9sF9gQwllbR30+zRif6vN2OYlGCm8VjgeOi5iIraRLDXaFuz2CRW
         6vXlCg9ueu8sb1d6Wl0QrKKU9Wne17dcsdmYnYUx9svzhCt0kaUPSRc7a2RB7eL0DUwW
         yoc1pIhB6gwMgD8CkJKuNCUGM7DacflTHwOGVOBZ4/XImDM+cuVaw195zoekBt9GF/ig
         zWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQtTI73rVMXxRjhpSvRevuRyW3N9MNYSfGbJ/TNd7DwV7NB3RR0S9wI3GKOsFSTcaHndpMeZkTDwqlDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbvcOANAMWy7QB6BdqRwMNJrxNyGS5VswKEKdN/ok2uoCFFR3
	o1qJcId1amM7zRsE7UIbiNDIH7uFS8a2dz4WLwBQ8oV2opIv8nSUeYUvpRzsADI=
X-Google-Smtp-Source: AGHT+IGKRBBYcFOAYtGkDsa6YaiDH1UmP5mz9dhjFWfJvV6oCsckH+MIyF++jOSsJbB5DKwqj/mXKA==
X-Received: by 2002:a05:6a00:1701:b0:70d:2892:402b with SMTP id d2e1a72fcca58-7199cd6ad79mr23305104b3a.7.1727162962602;
        Tue, 24 Sep 2024 00:29:22 -0700 (PDT)
Received: from [10.68.125.128] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9390cfsm665902b3a.118.2024.09.24.00.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:29:22 -0700 (PDT)
Message-ID: <2343da2e-f91f-4861-bb22-28f77db98c52@bytedance.com>
Date: Tue, 24 Sep 2024 15:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] mm: khugepaged: collapse_pte_mapped_thp() use
 pte_offset_map_rw_nolock()
To: Muchun Song <muchun.song@linux.dev>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org,
 vbabka@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
 vishal.moola@gmail.com, peterx@redhat.com, ryan.roberts@arm.com,
 christophe.leroy2@cs-soprasteria.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <07d975c50fe09c246e087303b39998430b1a66bd.1727148662.git.zhengqi.arch@bytedance.com>
 <79699B24-0D99-4051-91F3-5695D32D62AC@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <79699B24-0D99-4051-91F3-5695D32D62AC@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 15:14, Muchun Song wrote:
> 
> 
>> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> ﻿In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
>> acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
>> this time, the pte_same() check is not performed after the PTL held. So we
>> should get pgt_pmd and do pmd_same() check after the ptl held.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> mm/khugepaged.c | 14 +++++++++++---
>> 1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 6498721d4783a..8ab79c13d077f 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>     if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
>>         pml = pmd_lock(mm, pmd);
>>
>> -    start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
>> +    start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
>>     if (!start_pte)        /* mmap_lock + page lock should prevent this */
>>         goto abort;
>>     if (!pml)
>> @@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>     else if (ptl != pml)
>>         spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>
>> +    if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
>> +        goto abort;
>> +
>>     /* step 2: clear page table and adjust rmap */
>>     for (i = 0, addr = haddr, pte = start_pte;
>>          i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>> @@ -1645,7 +1648,6 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>         nr_ptes++;
>>     }
>>
>> -    pte_unmap(start_pte);
>>     if (!pml)
>>         spin_unlock(ptl);
>>
>> @@ -1658,13 +1660,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>     /* step 4: remove empty page table */
>>     if (!pml) {
>>         pml = pmd_lock(mm, pmd);
>> -        if (ptl != pml)
>> +        if (ptl != pml) {
>>             spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>> +            if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
>> +                spin_unlock(pml);
>> +                goto abort;
> 
> Drop the reference of folio and the mm counter twice at the label of abort and the step 3.

My bad, should set nr_ptes to 0 and call flush_tlb_mm() here, right?

> 
>> +            }
>> +        }
>>     }
>>     pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
>>     pmdp_get_lockless_sync();
>>     if (ptl != pml)
>>         spin_unlock(ptl);
>> +    pte_unmap(start_pte);
>>     spin_unlock(pml);
> 
> Why not?
> 
> pte_unmap_unlock(start_pte, ptl);
> if (pml != ptl)
>          spin_unlock(pml);

Both are fine, will do.

Thanks,
Qi

> 
>>
>>     mmu_notifier_invalidate_range_end(&range);
>> --
>> 2.20.1


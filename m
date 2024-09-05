Return-Path: <linux-kernel+bounces-316883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2F96D67F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17FA3B233BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F61990CE;
	Thu,  5 Sep 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lTOykkDp"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D9198E9B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533783; cv=none; b=BBN0ZDPy4ey+/fPLrSa00h+ql1oumMvmycQ9xTM9+t9g4ZB1SSOjOBak2C7JLi2h6yKbn4yAGDQXdri2AQ5wg7yerRlHbscf2e5qL/ReaSLIilf1ftBqe0N05+aVONSRiyyjOwmkDmxlx7jdLxKyjOkVSybviSEi2jwiME9l4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533783; c=relaxed/simple;
	bh=JQVHGS+/u4y5usFp3Q4hM7h7PUsjd09BzTFUGJkjqJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTsc2tpbJds1vlvAkscvPslyEzg2FoxGNt3zsblupKFqE4KcefWhBp0BZtPxuIOsHnZxJr98KDd5E//zmbeiHwrCykiHiJqfMt57e07xAZwW5yvLDxDsprmOA5FCw/n90Xa1nRHhPXGNXzyE0L57yOkToGR+QL3gZ3i15b0H/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lTOykkDp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d86f713557so405192a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725533780; x=1726138580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DJPppfvsq3bVrU8OAZnr57xaqKDJESryIS8WamVFSc=;
        b=lTOykkDpUSpOcaPpyneEEZCGE4pQLMBdyWu3lRyXcnWnVZKIdiGoZgACvY+9cvMLpW
         jgw1sacc8rNSGWUysZg/brBrVeX/7/d+Mio8kIWbUpgDDY9Zn0xz4tEVwkWv5YIGgzHr
         TlX9OBw+t9DDXm/SsNYXboMrLw1edp6luRZttJYX+o2Q7a9DS8XkoOvWwDKvoLQ3wDeb
         jVfPN15Jtz9l24IyqNT8vUdLE+qeewrZKX2Xak9bzOCuYF5JMk9UDHtUPlqGFfM0Vg9e
         kereiEJw9/MEAx4VnkMHDa+TH5/RTxWzr/mWOIozKFF5yjnPUZujvoO4/YaU++WwMCDo
         t80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533780; x=1726138580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DJPppfvsq3bVrU8OAZnr57xaqKDJESryIS8WamVFSc=;
        b=xUWYjfoDQUFPOM4z+aoXM4ZOh4C9WhQoErkK2GU9LVCoQZ0+78JLL/xEKelCmztiXY
         jdgTVFvXOsY7ieqWrMtmZ7vEGvkrqKn39KgCeUvXiSdG0/36vTzyKpW9xpz1zc43ExJN
         vkqZT6tn663CacPFOg2NT+lfh8wCENNKnRaoO8LE5PTtblezY6MxaSKkWuqgsDD3lKUI
         YUe5GEXX6KsnL3QNyJAxi1MutRvL0I9h7LuC1yf/qzs/SCb5gcTK7sBsueojLz9pOy7t
         3pjdAmSMaY7qWbhgAlcuFSMFBB9P8ZlPOKowJ21GQHD1tvoEmYNspYFiCvetPw/Av/1p
         5L0g==
X-Gm-Message-State: AOJu0Yxe5hgBM/8ye3opeIlprirCeVY7/etMx64Hfq4m0KBd7Ak7VNl/
	iyd8XRdshmY1x7n7hvM9a6blYbEtRr6vm9+0jp3q3hbkzNWWyWv4UavSIj8+lFc=
X-Google-Smtp-Source: AGHT+IHilYsBgfadCapwrPljiidrpCa41K0Hyb98p/0x3xNpGLLwKBsqtfV83jJC0DRLwz+P6VWrRQ==
X-Received: by 2002:a17:90a:de8c:b0:2d8:7307:3f73 with SMTP id 98e67ed59e1d1-2d8906204f6mr17130275a91.39.1725533780409;
        Thu, 05 Sep 2024 03:56:20 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b8fe1f68sm9312094a91.31.2024.09.05.03.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:56:20 -0700 (PDT)
Message-ID: <cccc16ad-21fb-4c99-8c49-91ee15c202cc@bytedance.com>
Date: Thu, 5 Sep 2024 18:56:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] mm: mremap: move_ptes() use
 pte_offset_map_rw_nolock()
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-10-zhengqi.arch@bytedance.com>
 <1b03a7de-1278-4e36-8068-885dd1c29742@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1b03a7de-1278-4e36-8068-885dd1c29742@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/5 17:25, Muchun Song wrote:
> 
> 
> On 2024/9/4 16:40, Qi Zheng wrote:
>> In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
>> convert it to using pte_offset_map_rw_nolock(). Since we may free the PTE
>> page in retract_page_tables() without holding the read lock of mmap_lock,
>> so we still need to do a pmd_same() check after holding the PTL.
> 
> retract_page_tables() and move_ptes() are synchronized with
> i_mmap_lock, right?

Right, will remove the pmd_same() check in v4. Thanks!

> 
> Muchun,
> Thanks.
> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/mremap.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mremap.c b/mm/mremap.c
>> index 24712f8dbb6b5..16e54151395ad 100644
>> --- a/mm/mremap.c
>> +++ b/mm/mremap.c
>> @@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, 
>> pmd_t *old_pmd,
>>       spinlock_t *old_ptl, *new_ptl;
>>       bool force_flush = false;
>>       unsigned long len = old_end - old_addr;
>> +    pmd_t pmdval;
>>       int err = 0;
>>       /*
>> @@ -175,14 +176,29 @@ static int move_ptes(struct vm_area_struct *vma, 
>> pmd_t *old_pmd,
>>           err = -EAGAIN;
>>           goto out;
>>       }
>> -    new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
>> +    /*
>> +     * Since we may free the PTE page in retract_page_tables() without
>> +     * holding the read lock of mmap_lock, so we still need to do a
>> +     * pmd_same() check after holding the PTL.
>> +     */
>> +    new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &pmdval,
>> +                       &new_ptl);
>>       if (!new_pte) {
>>           pte_unmap_unlock(old_pte, old_ptl);
>>           err = -EAGAIN;
>>           goto out;
>>       }
>> -    if (new_ptl != old_ptl)
>> +    if (new_ptl != old_ptl) {
>>           spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>> +
>> +        if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(new_pmd)))) {
>> +            pte_unmap_unlock(new_pte, new_ptl);
>> +            pte_unmap_unlock(old_pte, old_ptl);
>> +            err = -EAGAIN;
>> +            goto out;
>> +        }
>> +    }
>> +
>>       flush_tlb_batched_pending(vma->vm_mm);
>>       arch_enter_lazy_mmu_mode();
> 


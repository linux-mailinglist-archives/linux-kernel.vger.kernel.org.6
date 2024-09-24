Return-Path: <linux-kernel+bounces-336789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DE89840DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952A11F22104
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77515278E;
	Tue, 24 Sep 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lWycDBiq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D1450EE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167514; cv=none; b=KG/4GGWNbikLH6ZzBhMxD5KTOI3VSGOENLqdV+29Xh6brVUOQZIs5G/kN2BWCb8DmrH9RbXp+AehIwfAYNkucU25lGoIshoeOGMfW4L4sjOJH0OTpJbgRj1lTHiLv7MYJ47TuKG/wd5YYSDmPB/QDqN4GM5BnKcwVVkhHdKhl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167514; c=relaxed/simple;
	bh=uhxfRBtjgIHJuE1oMszFKyxh9pruoivNs5NAeF5QsYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBSBK4q7pCC7P7i298nvT72q5cezbgNr14139zm8HXk2O4PEVV/kbQWP9MVTNDWGIlFcZRLGqvCz/+x1I3MqqBUd9AsAeU8APQQu//zwlszXSK5euYollOEmf5nY2idzWkoLr+0swc5J+FaRdsjki5p0JBzzBO5D9ViZ7DaQaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lWycDBiq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2059112f0a7so46799785ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727167511; x=1727772311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2nQE9aToLO8F86J/y/Pv+vvJWva/3rLYd5MS5wex68=;
        b=lWycDBiqF+3+eSu78oCib+2sPFQUf/wQRpL8jWiJxVQBCVOhpJ/vcMwcYl7kB2bIdm
         CTCylDp/6imQOBN5ANs+zd+wV6vGT7GnEmqR9BlDp2MTcnuzV/i8oQhfu5P/PnPA8InU
         mhT8lpxg99FLftHbDSQC6XjB2ruv802zUAxqTho/gIzDYdAhPru6ZkH3R2/2vWigJxZ3
         ixgT2CrurQssdCMBF9uEOlX5dS/10Tg/2Uzb337i2eeCSl+lLmY9jV1HhVn/JcL8lqpy
         gFv4QSFn/ehtr0hXoAIkS1t6QhIjVIxBJSLq3T41yL350PgW4NRcPP1GnMHAl0t1wSYM
         m1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727167511; x=1727772311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2nQE9aToLO8F86J/y/Pv+vvJWva/3rLYd5MS5wex68=;
        b=mgUcNjE3A7p5BcO3o2es94TmC72hW//Xlp/IOfax5jbwtTnHnPkFnwjJs4I0JRJqaG
         OgYuKHtzDgywQhZlAx2fyR840kOjiWXFwbGbCqVNCtDdHL7QVm5F6Fd9xqotwUrUzRUm
         8oqHePh9+zDtlueEevLuB1e2HvkorHWt0EJCKHfV/wqhOpXjRPzau7l4NN6Xm9Exw1Jz
         sopy2yYNAzG9T9mcHI/sxG8nQ47UHBUKfyScdKmQzCFvNxy92Z/DQWmMfXMdEVYOgFjQ
         X9CuClj/An7d5tM8/8o/8OkoyPDD1Lsn3S8+L3cXceBxHqOIaAzf1q/w4TbX/hxlhnrp
         ac/A==
X-Forwarded-Encrypted: i=1; AJvYcCXu8z/XARSIOR+jYQs2uaUGPIPimP9BvpQfA3UmLm7+IucsbgxKFFvYiAjyqmxruPRwFA2XteazDhBOLDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSThLMzprX/4U6fJ41QorcL64i7G7wqUGULzPu6wkMpJUvhVQ
	smOjItpPt0DlBFDapwUdb3Y2Tx+WT7CAJmACH5VdYvm4b6HdNMmPx7bokvTjEEg=
X-Google-Smtp-Source: AGHT+IHo2ftEdEocasBZgbxVxDZL2Zt2IqqMpv0cagmh9vhh6c4h0pR5iAzOHA5lidbuQIZfPE+d7A==
X-Received: by 2002:a17:902:e543:b0:206:a574:b4fd with SMTP id d9443c01a7336-208d832a9bbmr214723865ad.9.1727167511212;
        Tue, 24 Sep 2024 01:45:11 -0700 (PDT)
Received: from [10.68.125.128] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17e3272sm6659695ad.179.2024.09.24.01.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:45:10 -0700 (PDT)
Message-ID: <ddc6a307-9520-4f5e-bc41-ef380b0d826a@bytedance.com>
Date: Tue, 24 Sep 2024 16:45:03 +0800
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
 <cccc53fc-29c2-43c0-83d4-d330bade70c7@bytedance.com>
 <2CBAEE27-9C4E-4902-B6BB-B6029FD42E8D@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2CBAEE27-9C4E-4902-B6BB-B6029FD42E8D@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 16:39, Muchun Song wrote:
> 
> 
>> On Sep 24, 2024, at 16:33, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>>
>>
>> On 2024/9/24 16:25, Muchun Song wrote:
>>>> On Sep 24, 2024, at 14:11, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>>
>>>> ﻿In the caller of map_pte(), we may modify the pvmw->pte after acquiring
>>>> the pvmw->ptl, so convert it to using pte_offset_map_rw_nolock(). At
>>>> this time, the pte_same() check is not performed after the pvmw->ptl held,
>>>> so we should get pmdval and do pmd_same() check to ensure the stability of
>>>> pvmw->pmd.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>> mm/page_vma_mapped.c | 25 ++++++++++++++++++++-----
>>>> 1 file changed, 20 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>>> index ae5cc42aa2087..6410f29b37c1b 100644
>>>> --- a/mm/page_vma_mapped.c
>>>> +++ b/mm/page_vma_mapped.c
>>>> @@ -13,9 +13,11 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
>>>>     return false;
>>>> }
>>>>
>>>> -static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>>> +static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
>>>> +            spinlock_t **ptlp)
>>>> {
>>>>     pte_t ptent;
>>>> +    pmd_t pmdval;
>>> Why declare a new variable? Can’t we use *pmdvalp instead?
>>
>> It's just a coding habit, both are fine for me.
> 
> Agree. But sometime it could make code look a little simpler.
> 
>>
>>>>
>>>>     if (pvmw->flags & PVMW_SYNC) {
>>>>         /* Use the stricter lookup */
>>>> @@ -25,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>>>         return !!pvmw->pte;
>>>>     }
>>>>
>>>> +again:
>>>>     /*
>>>>      * It is important to return the ptl corresponding to pte,
>>>>      * in case *pvmw->pmd changes underneath us; so we need to
>>>> @@ -32,10 +35,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>>>      * proceeds to loop over next ptes, and finds a match later.
>>>>      * Though, in most cases, page lock already protects this.
>>>>      */
>>>> -    pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>>>> -                      pvmw->address, ptlp);
>>>> +    pvmw->pte = pte_offset_map_rw_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>>>> +                         pvmw->address, &pmdval, ptlp);
>>>>     if (!pvmw->pte)
>>>>         return false;
>>>> +    *pmdvalp = pmdval;
> 
> For instance, here, it is unnecessary if pmdvalp is passed directly to
> pte_offset_map_rw_nolock.

OK, will use pmdvalp directly. ;)

> 
>>>>
>>>>     ptent = ptep_get(pvmw->pte);
>>>>
>>>> @@ -67,8 +71,13 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
>>>>     } else if (!pte_present(ptent)) {
>>>>         return false;
>>>>     }
>>>> +    spin_lock(*ptlp);
>>>> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pvmw->pmd)))) {
>>>> +        pte_unmap_unlock(pvmw->pte, *ptlp);
>>>> +        goto again;
>>>> +    }
>>>>     pvmw->ptl = *ptlp;
>>>> -    spin_lock(pvmw->ptl);
>>>> +
>>>>     return true;
>>>> }
>>>>
>>>> @@ -278,7 +287,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>             step_forward(pvmw, PMD_SIZE);
>>>>             continue;
>>>>         }
>>>> -        if (!map_pte(pvmw, &ptl)) {
>>>> +        if (!map_pte(pvmw, &pmde, &ptl)) {
>>>>             if (!pvmw->pte)
>>>>                 goto restart;
>>>>             goto next_pte;
>>>> @@ -307,6 +316,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>>         if (!pvmw->ptl) {
>>>>             pvmw->ptl = ptl;
>>>>             spin_lock(pvmw->ptl);
>>>> +            if (unlikely(!pmd_same(pmde, pmdp_get_lockless(pvmw->pmd)))) {
>>>> +                pte_unmap_unlock(pvmw->pte, pvmw->ptl);
>>>> +                pvmw->ptl = NULL;
>>>> +                pvmw->pte = NULL;
>>>> +                goto restart;
>>>> +            }
>>>>         }
>>>>         goto this_pte;
>>>>     } while (pvmw->address < end);
>>>> --
>>>> 2.20.1
> 
> 


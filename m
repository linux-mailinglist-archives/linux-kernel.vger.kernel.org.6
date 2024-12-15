Return-Path: <linux-kernel+bounces-446310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4469F2270
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ABC1886D63
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7518AE2;
	Sun, 15 Dec 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cV+e+7l0"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC818E0E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734244204; cv=none; b=qT2IV3rBemE7HZr9zYWSlfxtrgZkepq1YgG9gFF5sSGScYBzOwL760UHlTb/e+dnk8Bzh5QQAPU6Na/jmmaO1C5VJurQ/bq1CQxiYpJX8ACj/SGYQAH344m1/ppMv0kTBSnlq9aVDwh1lo1fD+cejiFGgeU9kDJmvx0l4ajI9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734244204; c=relaxed/simple;
	bh=LEBUuqQK0aAq3QVG4Yc41XBVtrujyJmyC34cjq+zEPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldg/wpv39X7hQFoA3xGvFIbw3/EZgUreh33pWfqal/H1C46vnM/gTwKByn1+PFHiq9Kgqw7g/EfbOkFmijMMzFAue9FsCKtxl+R4wGJqQ7u4EJdzht8rgIzALB2FJfbTzMdH/ymk4+u1bqDqI/HIBfL1Mpn1L207h/+1dH2IKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cV+e+7l0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728ea1573c0so2570843b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734244202; x=1734849002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwNYe1XDDHCxQqM+OnwDDhWm8Wr5Z1XvjowB1bcfSd0=;
        b=cV+e+7l0ZQroRhnwNios4vmH6JQSXsczHKrz2yh5ow34kUMFXA7PRCiMqVSpCbpihA
         5QIENHJaR43emYooJ+IjW2UwnST7a5UJZB8jFAMr7mup9uieFx1CodLXuqeXNGJE4lZE
         za7R6k6GAOOoiVwtSPszoQYWlM/o81S6Q9pwWqN28bY5v0eTWYgDa5VOASAV27bEOyyU
         cC6fh88jz2QjxkJKojIPtHNSU/fTZj3got+Ak78ytTNCTHdAWlvstoSrG1A620msmk7u
         qr1bk5ODDeoJPRywwO1MzctNWevMy3VHly3D+DW8I8lEdi+Jsx8DCMBzpNepFWJD4IHw
         uA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734244202; x=1734849002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwNYe1XDDHCxQqM+OnwDDhWm8Wr5Z1XvjowB1bcfSd0=;
        b=ikem+0XeVgqGd4FZAa2jHSJcZVN8S8o5//I9czPsQoQJWboHsDWDV4119ReOLUN8qq
         f1X2xNSxF7C2JYb6rIj5tbsV0ny3XcTIWzXPo/B3Pzjgsiiutx7nmGlQ0hnINUfzCH34
         Vkzm5ShdpWoCPQPBahIlL6fkj62TFaeBzA/v+NkSu8W2lWqmVmhVyrbuUKvTNyO3mPkW
         hTBOG+2t8So/KfS5aE9D3Q6Dab3chQMgPd7WdovXP8EazjV9rbUS3PwZ/rnFkAxFP6Fl
         CW4Dne4QK75GA5rXcfzBgWvRm0bJkxlJ8xY9A92hcs9S9Hx1YVBQS+cemrKbDkIhvpAL
         e9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWMqxoeJdqxPfbO0LbXFUlVKulPvNk+EKirCzbPfBR0IpK3k1Pd8L78mlJGrinrTGy30zkYuQVEqGFS0io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01QQ6vAzY4wqfeQnfjsw1NtO5qASR61+jqk4zT4iL253oo4DP
	tfl+yx3mVTj5fLIohpFjyJy/IryOw0wNckfTJ2Hfe+UjDwKtZKAoh+LSZx8254I=
X-Gm-Gg: ASbGnctdlJHukWoUw5IvJtdiKQBiz/4dP5jxsC+95RbQAWNtWuQQ3O8SWGuefmpHD4j
	NyV26r+hQH5bGM1cdk8p7/XJziC5lg3+tlZRQiEu8qJKSVbcqRaAmjuy/vGu2VQc/jd0rm/FH6O
	gA2m0hq8kx5JqaP3MxfEJKLKGkM/Ee5w3nCkIlDthyaV9bgMv2vtJCIbpDcDf7r9ydx7XaCLDb5
	dC/LdQdCEmOubc8wisKX06DpnI/O6HZLKpeV+2zfz7zLzzokdE17eT1QottC2hqWRNdtgp5GLJ2
	YvIJf+GERas51Bbe9NelAoNwHBTTysVhVSGSkpDHzb9LKqn5kJgtQME=
X-Google-Smtp-Source: AGHT+IEyhC05pRlCoG7uiWXEq03tySPT5h+dGj8fQf3nkjF7E7tyWGU0NclNvArd44iS5Pxk6GDf5A==
X-Received: by 2002:a17:903:32cd:b0:215:cbbf:8926 with SMTP id d9443c01a7336-21892a543f6mr128401865ad.35.1734244202084;
        Sat, 14 Dec 2024 22:30:02 -0800 (PST)
Received: from ?IPV6:2409:8a28:f4f:a9a4:11bc:4825:e7fe:2e0e? ([2409:8a28:f4f:a9a4:11bc:4825:e7fe:2e0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e4ffd9sm21702895ad.142.2024.12.14.22.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 22:30:01 -0800 (PST)
Message-ID: <18bc52f4-ab02-495f-8f8f-87f69ea5b914@bytedance.com>
Date: Sun, 15 Dec 2024 14:29:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: peterz@infradead.org, tglx@linutronix.de, david@redhat.com,
 jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
 <CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/15 02:29, Yu Zhao wrote:
> On Sat, Dec 14, 2024 at 2:03 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Bloating struct pt_lock is unnecessary. Glad to see it's reverted.

Indeed!

> 
> Acked-by: Yu Zhao <yuzhao@google.com>

Thanks! Once the review of this patch series is completed, we can simply
drop "mm: pgtable: make ptlock be freed by RCU" from mm tree.

> 
> 
>> ---
>>   include/linux/mm.h       |  2 +-
>>   include/linux/mm_types.h |  9 +--------
>>   mm/memory.c              | 22 ++++++----------------
>>   3 files changed, 8 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e7902980439cc..5e73e53c34e9e 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2988,7 +2988,7 @@ void ptlock_free(struct ptdesc *ptdesc);
>>
>>   static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>>   {
>> -       return &(ptdesc->ptl->ptl);
>> +       return ptdesc->ptl;
>>   }
>>   #else /* ALLOC_SPLIT_PTLOCKS */
>>   static inline void ptlock_cache_init(void)
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index df8f5152644ec..5d8779997266e 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
>>   FOLIO_MATCH(compound_head, _head_2a);
>>   #undef FOLIO_MATCH
>>
>> -#if ALLOC_SPLIT_PTLOCKS
>> -struct pt_lock {
>> -       spinlock_t ptl;
>> -       struct rcu_head rcu;
>> -};
>> -#endif
>> -
>>   /**
>>    * struct ptdesc -    Memory descriptor for page tables.
>>    * @__page_flags:     Same as page flags. Powerpc only.
>> @@ -485,7 +478,7 @@ struct ptdesc {
>>          union {
>>                  unsigned long _pt_pad_2;
>>   #if ALLOC_SPLIT_PTLOCKS
>> -               struct pt_lock *ptl;
>> +               spinlock_t *ptl;
>>   #else
>>                  spinlock_t ptl;
>>   #endif
>> diff --git a/mm/memory.c b/mm/memory.c
>> index d9af83dd86bbf..83765632e20b0 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -7041,34 +7041,24 @@ static struct kmem_cache *page_ptl_cachep;
>>
>>   void __init ptlock_cache_init(void)
>>   {
>> -       page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
>> +       page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
>>                          SLAB_PANIC, NULL);
>>   }
>>
>>   bool ptlock_alloc(struct ptdesc *ptdesc)
>>   {
>> -       struct pt_lock *pt_lock;
>> +       spinlock_t *ptl;
>>
>> -       pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
>> -       if (!pt_lock)
>> +       ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
>> +       if (!ptl)
>>                  return false;
>> -       ptdesc->ptl = pt_lock;
>> +       ptdesc->ptl = ptl;
>>          return true;
>>   }
>>
>> -static void ptlock_free_rcu(struct rcu_head *head)
>> -{
>> -       struct pt_lock *pt_lock;
>> -
>> -       pt_lock = container_of(head, struct pt_lock, rcu);
>> -       kmem_cache_free(page_ptl_cachep, pt_lock);
>> -}
>> -
>>   void ptlock_free(struct ptdesc *ptdesc)
>>   {
>> -       struct pt_lock *pt_lock = ptdesc->ptl;
>> -
>> -       call_rcu(&pt_lock->rcu, ptlock_free_rcu);
>> +       kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
>>   }
>>   #endif
>>
>> --
>> 2.20.1
>>


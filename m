Return-Path: <linux-kernel+bounces-407011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5459C6766
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D542282F66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2C1514EE;
	Wed, 13 Nov 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R1/eV+Yo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA81531C8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731465635; cv=none; b=ZsDBo+iyxlrJdb0uZbhR/WxqY1EHVnbD6Hf4EwQxu9hj73IB50v+NvEbdL3S4o8tmkhmEAQ/Wx5fWJFYsBfVLLi0tLo8reYjcvfvuThihtkKUCCaSrjSxzuLMrwAgDD+QrftJQ+Fbm0cTN/XHHRE7Q7XfCkrtFchr+ETRmfkXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731465635; c=relaxed/simple;
	bh=8FHvPGnvQCGXz1+Wdzwa04HkEiMdwfECMWnLiHIfqeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOdVl5WYtc65fbgbVnNANb099JPPHtY643bPfoLGhujuYKhYUG9axNtYUrwXB4lZI1fAXRjCYunFvF+AN+P6qH2jEY6t1+/G24WIlwKWiFeMjVJT2Bg3SEwr7bKWnp4QGimv3TCIQx7lfqPPmJYnLrUHaFm7AVXmNbWK3qJfbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R1/eV+Yo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdb889222so63628935ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731465632; x=1732070432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHNeKpFyR0+MmuArDeQLqD+4LUq6iWaLcm/HCxIALi0=;
        b=R1/eV+Yo/m5tf4Q/XyVs2IHv3eqBv+BkU7pHsgOYCs6SGwaSa27C48WoqSvzqnQfDv
         a04B58GgQ3Qb6LtqD8czxQ/dcWAtbtbg0UJtWcGMySpQvF7GmHlGg1Z7mkxRrKH0AC0b
         t55rcgy8neW8EIsuAlx4diThMMRSpPrftP7e79WfotWBtKUbMAtaMfMg5AOXA1mU3oyU
         jaONs5/fjMFot3SGgAyKU/0fHnFTbnj74bGYPX49bdBh6stC0EEC6iU4a7jmn6eKscjO
         RALXXYS8Y4itgyXGyFjwEuBkh0uKVQrAUk8xolyr74RCec170h35gC7jR/VZFyvMk5jz
         vL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731465632; x=1732070432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHNeKpFyR0+MmuArDeQLqD+4LUq6iWaLcm/HCxIALi0=;
        b=UBhoc6KEdLvIoynfg7/RMvvXz87Nt7pfos99RImaFJtsFIr8Gt4LNk4tjiHrtYSLX+
         OZHxM9r6revUWggx6nWcaNesIT/qy2aDiuHx/4mqnminV5WyXMr0qHtLiFG7aDq1gUrP
         ZClekKszA+OUoHevFPt6VtAgbivICjBgUv5m3ZNOZyBz3GYcKFyViR1FGOyRKx3Sqxii
         kc/aTOySTtZgkxflEKdcNG4PUv9XIXML12iJ76Lf1Ki/r0w5bae6PRyqMwp9DYZR8W/4
         GxvaFb3fCVPNn993snvHE5L5tYooIOpM4KBMiHYO0cTVbGOCA1wZLMjZIB++B5XoyUUe
         x6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfAGkJUQiZ88a7EbUjoYCtmCcpOO4+IT1dZkVISaYF1mTq5fS5rz8T3bl0L6ftGj37avYMrKRsH2/0mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qhOrxQN6q71vy98tZPc9IitI5d3SmyDws92wwX5yb0zyM5Wz
	biOJ96hIfqT5r3UOMziG1Fbb7BloTRQk+NLE8gvlYx6jprbLG8/vcI8wJyVKNxQ=
X-Google-Smtp-Source: AGHT+IEK3xvoBXSD70It46TNFzV++Z8Gp+mEI8YBiYgxVl6WCjiryIZ3WdBsvqFEtqV5s8CFHDHs/A==
X-Received: by 2002:a17:90b:268b:b0:2d3:c638:ec67 with SMTP id 98e67ed59e1d1-2e9f2b3e437mr1834275a91.0.1731465632343;
        Tue, 12 Nov 2024 18:40:32 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3ef1da1sm306289a91.26.2024.11.12.18.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 18:40:31 -0800 (PST)
Message-ID: <2fd11f54-8c0c-401d-8635-e54ebf7facc2@bytedance.com>
Date: Wed, 13 Nov 2024 10:40:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
 <db3cd6c1-03d6-48fd-9591-ab3e90d7e10f@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <db3cd6c1-03d6-48fd-9591-ab3e90d7e10f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/13 01:00, David Hildenbrand wrote:
> On 31.10.24 09:13, Qi Zheng wrote:
>> This commit introduces do_zap_pte_range() to actually zap the PTEs, which
>> will help improve code readability and facilitate secondary checking of
>> the processed PTEs in the future.
>>
>> No functional change.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index bd9ebe0f4471f..c1150e62dd073 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct 
>> mmu_gather *tlb,
>>       return nr;
>>   }
>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>> +                   struct vm_area_struct *vma, pte_t *pte,
>> +                   unsigned long addr, unsigned long end,
>> +                   struct zap_details *details, int *rss,
>> +                   bool *force_flush, bool *force_break)
>> +{
>> +    pte_t ptent = ptep_get(pte);
>> +    int max_nr = (end - addr) / PAGE_SIZE;
>> +
>> +    if (pte_none(ptent))
>> +        return 1;
> 
> Maybe we should just skip all applicable pte_none() here directly.

Do you mean we should keep pte_none() case in zap_pte_range()? Like
below:

diff --git a/mm/memory.c b/mm/memory.c
index 002aa4f454fa0..2ccdcf37b7a46 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1666,9 +1666,6 @@ static inline int do_zap_pte_range(struct 
mmu_gather *tlb,
         pte_t ptent = ptep_get(pte);
         int max_nr = (end - addr) / PAGE_SIZE;

-       if (pte_none(ptent))
-               return 1;
-
         if (pte_present(ptent))
                 return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
                                         addr, details, rss, force_flush,
@@ -1704,11 +1701,15 @@ static unsigned long zap_pte_range(struct 
mmu_gather *tlb,
                 if (need_resched())
                         break;

-               nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, 
rss,
-                                     &force_flush, &force_break);
-               if (unlikely(force_break)) {
-                       addr += nr * PAGE_SIZE;
-                       break;
+               if (pte_none(ptep_get(pte))) {
+                       nr = 1;
+               } else {
+                       nr = do_zap_pte_range(tlb, vma, pte, addr, end, 
details,
+                                             rss, &force_flush, 
&force_break);
+                       if (unlikely(force_break)) {
+                               addr += nr * PAGE_SIZE;
+                               break;
+                       }
                 }
         } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);

This avoids repeated checks for pte_none() later. Both are fine for
me, will change to this in the next version.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> 


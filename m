Return-Path: <linux-kernel+bounces-407562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0259C6EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF2B32D07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAE2010EE;
	Wed, 13 Nov 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ioW7d68k"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54120101B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500411; cv=none; b=hu/hq1RDxIjVt7mngn/zIvJ1QY4EV63WxOs96TyP1t752MGKTiNhIDRCrlgyQ00xCdl1jHXfPqSNYfcQmZtM4WSCbZ5U/RQlpd2ElWhae1B/pcx1+HaJCD6dnVyCo9EyWbK5KsilR8R57blfrooAJdhHD8DiQNRCabzrO1zKN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500411; c=relaxed/simple;
	bh=Xj6fRMG/T7N6N8nU2XmfytKbrZeVhrRXAujkzpPC9lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuxKfyb2kwUKfSRE+Z05g864/8EN8VB+KOec5EydPu7dzrLa0ItjYz08TGe7gJbY+T7OfqAx2DN6I5xw++238DvRus4raOuqF9sXnQaUgHKoO1c5hs8HgoSXCSeVIA4M8/Y/VXQEY3KTiAvymentqVVUMr8F9lPHKTbztOqgcC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ioW7d68k; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72097a5ca74so5682320b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731500409; x=1732105209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44idHlU+avyOzhoCNle7NKo00WtYnFE29wGtuv5rhUg=;
        b=ioW7d68kzT+uI8L9Ph5AA8lTsJ0aCUlWus6qSsQr3evoCK0NE1umKVELaCxinpJXUe
         9oEAxD4+L9TY5R65ajfxA5sGDFNKUzbDdY/AR4piTvnQIlk4HIR1RbzMo26RFuJnE0wl
         wjZIkb5ADMvrIcLmVmRP0Ljy57ytHEswtRyUjCKMAp+BsVBzmKmhw4zGZeHNtU4+/tw3
         0FZthIcwWV8WJkdFzeN6mpwJ9rwId6cAg/F5Oe0oaOFqf47g8bDQqgzfj26L6DCs7Md9
         y/k95uQO/N03j9hbY5MadOAtFbz/drr3cSomdLRJ7p+oIExxbBBT4SsS6x8fzr63VYO0
         LTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731500409; x=1732105209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44idHlU+avyOzhoCNle7NKo00WtYnFE29wGtuv5rhUg=;
        b=b8j/+aM88lag+e5V5GWPjhhREWdp4MUnPs3MvhT0SCRqLihrQgFeMZNiM9FT/w6p/t
         qkPk23M43gjEZVNRNyPtcq78JXBQaRHhyIERlf0ueo7SpYd204iQkkyghexL6xxmWnSE
         WvvSCpqxLefwd/39SE4A5WjNeORhLzCgIqVsMfjqNurVXz9mgGfT2f8yUhf0W6tmvrtc
         6JA8r057i/dCNlzwbmAu22zYf+iS2FUvqTLoJZmdGETka/64GiPKP/pDDQb73l4FNOvL
         J4qytGF56PGdpA1OO0EOizbaP4z5f9A9kStQLr2BFrrT20r+9A8/ssmTazPG0+c0Jr+u
         ekvw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KBNc+DLVa17S8bZgRykOmAyN8jyNyD6kOoR2zmQq6aaCJoJbrR78/y16qnF+uRS0DYUj6T2pfN+UcGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcJ+4czF8ayaYOxYOn0+df/ELDE5uLaztRJ5gfiSUyer1QLl6
	+hfIXJkeVk9MszmdQsJj3gsaEPZrLLcKvutcZR6fevu8VZsjxNXNlhl6cbn0oZU=
X-Google-Smtp-Source: AGHT+IGU1/C3z5Xuj00yzrIJjZiSkzODeiRfgtWw0s+UCt4n5GgEqa5Ttt6Z10SB7L8TXSqB78Fpng==
X-Received: by 2002:a05:6a00:23c4:b0:71d:fb29:9f07 with SMTP id d2e1a72fcca58-724132cd842mr26883002b3a.15.1731500408789;
        Wed, 13 Nov 2024 04:20:08 -0800 (PST)
Received: from [10.84.149.95] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7245fe8e286sm678323b3a.16.2024.11.13.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 04:20:08 -0800 (PST)
Message-ID: <303bff80-b535-48a2-bc38-d305cc3fc5c6@bytedance.com>
Date: Wed, 13 Nov 2024 20:19:57 +0800
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
 <2fd11f54-8c0c-401d-8635-e54ebf7facc2@bytedance.com>
 <6e9c649f-5fc9-4fcc-928c-c4f46a74ca66@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6e9c649f-5fc9-4fcc-928c-c4f46a74ca66@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/13 19:43, David Hildenbrand wrote:
> On 13.11.24 03:40, Qi Zheng wrote:
>>
>>
>> On 2024/11/13 01:00, David Hildenbrand wrote:
>>> On 31.10.24 09:13, Qi Zheng wrote:
>>>> This commit introduces do_zap_pte_range() to actually zap the PTEs, 
>>>> which
>>>> will help improve code readability and facilitate secondary checking of
>>>> the processed PTEs in the future.
>>>>
>>>> No functional change.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
>>>>    1 file changed, 26 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index bd9ebe0f4471f..c1150e62dd073 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct
>>>> mmu_gather *tlb,
>>>>        return nr;
>>>>    }
>>>> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
>>>> +                   struct vm_area_struct *vma, pte_t *pte,
>>>> +                   unsigned long addr, unsigned long end,
>>>> +                   struct zap_details *details, int *rss,
>>>> +                   bool *force_flush, bool *force_break)
>>>> +{
>>>> +    pte_t ptent = ptep_get(pte);
>>>> +    int max_nr = (end - addr) / PAGE_SIZE;
>>>> +
>>>> +    if (pte_none(ptent))
>>>> +        return 1;
>>>
>>> Maybe we should just skip all applicable pte_none() here directly.
>>
>> Do you mean we should keep pte_none() case in zap_pte_range()? Like
>> below:
>>
> 
> No rather an addon patch that will simply skip over all
> consecutive pte_none, like:
> 
> if (pte_none(ptent)) {
>      int nr;
> 
>      for (nr = 1; nr < max_nr; nr++) {
>          ptent = ptep_get(pte + nr);
>          if (pte_none(ptent))
>              continue;
>      }
> 
>      max_nr -= nr;
>      if (!max_nr)
>          return nr;
>      addr += nr * PAGE_SIZE;
>      pte += nr;
> }
> 
> Assuming that it's likely more common to have larger pte_none() holes 
> that single ones, optimizing out the 
> need_resched()+force_break+incremental pte/addr increments etc.

Ah, got it. And I agree with you, will change to it in the next version.

Thanks!

> 


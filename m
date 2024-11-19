Return-Path: <linux-kernel+bounces-414086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1939D22D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30DDB21B71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CD1B654E;
	Tue, 19 Nov 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbHKh0na"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E61CA84
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010144; cv=none; b=Rhy9j+SL2GZRy59b7/8wFfFlW2j0lCdpBYDWEL7WoDSGvtt3wMID/lGQ3HlDeybGpoxf6xPxkzhh9VRkNLY5vFHbbG7e9R1leCHJ0hCCY55+2v3q1N2jGHsqyjLBDEFMN/B7j7x6n5pIpp0X871aH7czQg2E0ba6VBRxJvtP7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010144; c=relaxed/simple;
	bh=3n/KzQM9e8s6DbnSS3ztR8tl8NGjuWodXe1gUPCkeEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyLeX/ki9L/dRM5ngXsVrJ5lhlWkeiwxi4kgQrJyD5ZGaElifBO9LBazzKphRvoVhJnjKJ//qoxjRmn+8AbmFSb2QLShD8+BOTyp9teE2oQzn3RzEitEMtA7QgAWgwOELbR0dd/L6nAN8ZokjRm1ehJmAMPTw5qdjLfI3ecvrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbHKh0na; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732010141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6nGPI4QnXV5oc1GkhBs0z8YWpViNXGdnTtQrcN+bgVw=;
	b=hbHKh0naCneEv3bXaww3UL4/3aAmDfMxAmuT6OPGUvZho6+Cm/bEIJ7XtwyBaSmxwayzmM
	XQ4KgTmagvE5wLC8qQuaYF3AL3gd0Cf3wW5GSqf3IPRIkJx0pLvlYGr9oTcKacikSlFhSU
	dyN1CqtBuoPxsh826ElWkWlm2FVCBy0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ssKJSHtWPZOe1pFElQOhFw-1; Tue, 19 Nov 2024 04:55:39 -0500
X-MC-Unique: ssKJSHtWPZOe1pFElQOhFw-1
X-Mimecast-MFC-AGG-ID: ssKJSHtWPZOe1pFElQOhFw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso5665345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732010138; x=1732614938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nGPI4QnXV5oc1GkhBs0z8YWpViNXGdnTtQrcN+bgVw=;
        b=H4DrKCqwAsVulIFLbBbis79rBYH16IQMnhXQs6HwyN2GbUQa1tuZMSWikRRtDizz2l
         pBXoxXB6018N7h/e30KpBLVi5McBBOKCi6Wj8/SKSA0wzD8MC7bXHi5olnwSsR91Nogg
         JGrMs7gqY7XgRYBYLtKlW0zVNdlJgxPF0A0YkK6daV+fkKzDa1TF51yMX51pH9zSMO29
         AkJqodb0eHRbMd7YpYmKAtSpXdupGL4GACGsyRNkPZweAqIjqbx6CKBTNNqeBbUjKfct
         5Goy1lEPJbPDeYbx/Z0QLwBkBWvNi1K2Y4OQtvV+YXLlm+duMeN/ay5xRvdFbg+WwNwH
         Nufg==
X-Forwarded-Encrypted: i=1; AJvYcCU6U/xqhua2PdxKJgCpTIuMYkZ6PHYvfIDiRKyeNhGIi5pFU8V6yr0X3sKXrRbRe6EnuXe6gJxKydUbzXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedVA71zHf6JgjFEtC651qdXZw22jsZXVpQHBZ00tpVj6ZeyF3
	GCrcEp/krgfB54jCzqQWsLJ2etN9xXeas3AHbw5WcFOZgs7vPV5ol0IcALUzeykfL/7nWAvwsVW
	5p73QsyVkwiyRgaWZnI3NNgKmbEDYhHVPqnzzCEenW2k1VIPEsnKSm8OzsI1MwA==
X-Received: by 2002:a05:600c:348c:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-432df7906f0mr124500545e9.29.1732010137742;
        Tue, 19 Nov 2024 01:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+DRt85yY09ELSZcncFP954Sunrtltciu/GXArm4CiiPdPr0qWExcEN6T3eDzHyQ/5notiQw==
X-Received: by 2002:a05:600c:348c:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-432df7906f0mr124500315e9.29.1732010137324;
        Tue, 19 Nov 2024 01:55:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae04sm185377065e9.33.2024.11.19.01.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 01:55:36 -0800 (PST)
Message-ID: <b5da4118-2b63-4383-8617-ac98d7e62c64@redhat.com>
Date: Tue, 19 Nov 2024 10:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] mm: introduce skip_none_ptes()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: jannh@google.com, hughd@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, zokeefe@google.com,
 rientjes@google.com
References: <cover.1731566457.git.zhengqi.arch@bytedance.com>
 <574bc9b646c87d878a5048edb63698a1f8483e10.1731566457.git.zhengqi.arch@bytedance.com>
 <c7eeac93-3619-4443-896f-ef2e02f0bef0@redhat.com>
 <617a063e-bd84-4da5-acf4-6ff516512055@bytedance.com>
 <fa3fc933-cd51-4be5-944e-250da9289eda@redhat.com>
 <b524a568-fa3b-4618-80cc-e8c31ea4eeac@bytedance.com>
 <d27a75fa-b968-43d3-bbd3-cc607feee495@redhat.com>
 <253e5fd0-7e98-43fd-b0d7-8a5b739ae4aa@bytedance.com>
 <77b1eddf-7c1b-43e9-9352-229998ce3fc7@redhat.com>
 <5a3428bd-743a-4d51-8b75-163ab560bca7@bytedance.com>
 <4edccc1a-2761-4a5a-89a6-7869c1b6b08a@redhat.com>
 <2b48d313-4f66-47c8-98d8-8aa78db62b1b@bytedance.com>
 <995804f4-b658-44b2-bb40-c84b8a322616@redhat.com>
 <f3adf382-d252-4007-b8ca-c557814cb5c8@bytedance.com>
 <4ee60b7b-a81e-4b94-96c9-52b1bd9d5061@redhat.com>
 <e2870a81-840a-4b33-b65b-318a4a526c26@bytedance.com>
 <332cbacb-cad3-4522-a74b-b5ad5efee4af@redhat.com>
 <d897a1d3-bf72-48f2-b4df-1f7acb3ac311@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d897a1d3-bf72-48f2-b4df-1f7acb3ac311@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.11.24 12:13, Qi Zheng wrote:
> 
> 
> On 2024/11/18 18:59, David Hildenbrand wrote:
>> On 18.11.24 11:56, Qi Zheng wrote:
>>>
>>>
>>> On 2024/11/18 18:41, David Hildenbrand wrote:
>>>> On 18.11.24 11:34, Qi Zheng wrote:
>>>>>
>>>>>
>>>>> On 2024/11/18 17:29, David Hildenbrand wrote:
>>>>>> On 18.11.24 04:35, Qi Zheng wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2024/11/15 22:59, David Hildenbrand wrote:
>>>>>>>> On 15.11.24 15:41, Qi Zheng wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/11/15 18:22, David Hildenbrand wrote:
>>>>>>>>>>>>> *nr_skip = nr;
>>>>>>>>>>>>>
>>>>>>>>>>>>> and then:
>>>>>>>>>>>>>
>>>>>>>>>>>>> zap_pte_range
>>>>>>>>>>>>> --> nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
>>>>>>>>>>>>> &skip_nr,
>>>>>>>>>>>>>                                rss, &force_flush, &force_break);
>>>>>>>>>>>>>             if (can_reclaim_pt) {
>>>>>>>>>>>>>                 none_nr += count_pte_none(pte, nr);
>>>>>>>>>>>>>                 none_nr += nr_skip;
>>>>>>>>>>>>>             }
>>>>>>>>>>>>>
>>>>>>>>>>>>> Right?
>>>>>>>>>>>>
>>>>>>>>>>>> Yes. I did not look closely at the patch that adds the
>>>>>>>>>>>> counting of
>>>>>>>>>>>
>>>>>>>>>>> Got it.
>>>>>>>>>>>
>>>>>>>>>>>> pte_none though (to digest why it is required :) ).
>>>>>>>>>>>
>>>>>>>>>>> Because 'none_nr == PTRS_PER_PTE' is used in patch #7 to detect
>>>>>>>>>>> empty PTE page.
>>>>>>>>>>
>>>>>>>>>> Okay, so the problem is that "nr" would be "all processed
>>>>>>>>>> entries" but
>>>>>>>>>> there are cases where we "process an entry but not zap it".
>>>>>>>>>>
>>>>>>>>>> What you really only want to know is "was any entry not zapped",
>>>>>>>>>> which
>>>>>>>>>> could be a simple input boolean variable passed into
>>>>>>>>>> do_zap_pte_range?
>>>>>>>>>>
>>>>>>>>>> Because as soon as any entry was processed but  no zapped, you can
>>>>>>>>>> immediately give up on reclaiming that table.
>>>>>>>>>
>>>>>>>>> Yes, we can set can_reclaim_pt to false when a !pte_none() entry is
>>>>>>>>> found in count_pte_none().
>>>>>>>>
>>>>>>>> I'm not sure if well need cont_pte_none(), but I'll have to take a
>>>>>>>> look
>>>>>>>> at your new patch to see how this fits together with doing the
>>>>>>>> pte_none
>>>>>>>> detection+skipping in do_zap_pte_range().
>>>>>>>>
>>>>>>>> I was wondering if you cannot simply avoid the additional
>>>>>>>> scanning and
>>>>>>>> simply set "can_reclaim_pt" if you skip a zap.
>>>>>>>
>>>>>>> Maybe we can return the information whether the zap was skipped from
>>>>>>> zap_present_ptes() and zap_nonpresent_ptes() through parameters
>>>>>>> like I
>>>>>>> did in [PATCH v1 3/7] and [PATCH v1 4/7].
>>>>>>>
>>>>>>> In theory, we can detect empty PTE pages in the following two ways:
>>>>>>>
>>>>>>> 1) If no zap is skipped, it means that all pte entries have been
>>>>>>>         zap, and the PTE page must be empty.
>>>>>>> 2) If all pte entries are detected to be none, then the PTE page is
>>>>>>>         empty.
>>>>>>>
>>>>>>> In the error case, 1) may cause non-empty PTE pages to be reclaimed
>>>>>>> (which is unacceptable), while the 2) will at most cause empty PTE
>>>>>>> pages
>>>>>>> to not be reclaimed.
>>>>>>>
>>>>>>> So the most reliable and efficient method may be:
>>>>>>>
>>>>>>> a. If there is a zap that is skipped, stop scanning and do not
>>>>>>> reclaim
>>>>>>>         the PTE page;
>>>>>>> b. Otherwise, as now, detect the empty PTE page through
>>>>>>> count_pte_none()
>>>>>>
>>>>>> Is there a need for count_pte_none() that I am missing?
>>>>>
>>>>> When any_skipped == false, at least add VM_BUG_ON() to recheck none
>>>>> ptes.
>>>>>
>>>>>>
>>>>>> Assume we have
>>>>>>
>>>>>> nr = do_zap_pte_range(&any_skipped)
>>>>>>
>>>>>>
>>>>>> If "nr" is the number of processed entries (including pte_none()), and
>>>>>> "any_skipped" is set whenever we skipped to zap a !pte_none entry, we
>>>>>> can detect what we need, no?
>>>>>>
>>>>>> If any_skipped == false after the call, we now have "nr" pte_none()
>>>>>> entries. -> We can continue trying to reclaim
>>>>>
>>>>> I prefer that "nr" should not include pte_none().
>>>>>
>>>>
>>>> Why? do_zap_pte_range() should tell you how far to advance, nothing
>>>> less, nothing more.
>>>>
>>>> Let's just keep it simple and avoid count_pte_none().
>>>>
>>>> I'm probably missing something important?
>>>
>>> As we discussed before, we should skip all consecutive none ptes,
>>   > pte and addr are already incremented before returning.
>>
>> It's probably best to send the resulting patch so I can either
>> understand why count_pte_none() is required or comment on how to get rid
>> of it.
> 
> Something like this:
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bd9ebe0f4471f..e9bec3cd49d44 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1657,6 +1657,66 @@ static inline int zap_nonpresent_ptes(struct
> mmu_gather *tlb,
>           return nr;
>    }
> 
> +static inline int do_zap_pte_range(struct mmu_gather *tlb,
> +                                  struct vm_area_struct *vma, pte_t *pte,
> +                                  unsigned long addr, unsigned long end,
> +                                  struct zap_details *details, int *rss,
> +                                  bool *force_flush, bool *force_break,
> +                                  bool *any_skipped)
> +{
> +       pte_t ptent = ptep_get(pte);
> +       int max_nr = (end - addr) / PAGE_SIZE;

I'd do here:

	  int nr = 0;

> +
> +       /* Skip all consecutive pte_none(). */
> +       if (pte_none(ptent)) {
> +

instead of the "int nr" here

> +               for (nr = 1; nr < max_nr; nr++) {
> +                       ptent = ptep_get(pte + nr);
> +                       if (!pte_none(ptent))
> +                               break;
> +               }
> +               max_nr -= nr;
> +               if (!max_nr)
> +                       return 0;
> +               pte += nr;
> +               addr += nr * PAGE_SIZE;
> +       }
> +
> +       if (pte_present(ptent))
> +               return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
> +                                       addr, details, rss, force_flush,
> +                                       force_break, any_skipped);

and here:

if (pte_present(ptent))
	nr += zap_present_ptes(...)
else
	nr += zap_nonpresent_ptes();
return nr;

So you really return the number of processed items -- how much the 
caller should advance.

> +
> +       return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
> +                                  details, rss, any_skipped);
> +}
> +
> +static inline int count_pte_none(pte_t *pte, int nr)
> +{
> +       int none_nr = 0;
> +
> +       /*
> +        * If PTE_MARKER_UFFD_WP is enabled, the uffd-wp PTEs may be
> +        * re-installed, so we need to check pte_none() one by one.
> +        * Otherwise, checking a single PTE in a batch is sufficient.
> +        */
> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
> +       for (;;) {
> +               if (pte_none(ptep_get(pte)))
> +                       none_nr++;
> +               if (--nr == 0)
> +                       break;
> +               pte++;
> +       }
> +#else
> +       if (pte_none(ptep_get(pte)))
> +               none_nr = nr;
> +#endif
> +       return none_nr;
> +}
> +
> +
>    static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                                   struct vm_area_struct *vma, pmd_t *pmd,
>                                   unsigned long addr, unsigned long end,
> @@ -1667,6 +1727,7 @@ static unsigned long zap_pte_range(struct
> mmu_gather *tlb,
>           int rss[NR_MM_COUNTERS];
>           spinlock_t *ptl;
>           pte_t *start_pte;
> +       bool can_reclaim_pt;
>           pte_t *pte;
>           int nr;
> 
> @@ -1679,28 +1740,22 @@ static unsigned long zap_pte_range(struct
> mmu_gather *tlb,
>           flush_tlb_batched_pending(mm);
>           arch_enter_lazy_mmu_mode();
>           do {
> -               pte_t ptent = ptep_get(pte);
> -               int max_nr;
> -
> -               nr = 1;
> -               if (pte_none(ptent))
> -                       continue;
> +               bool any_skipped;
> 
>                   if (need_resched())
>                           break;
> 
> -               max_nr = (end - addr) / PAGE_SIZE;
> -               if (pte_present(ptent)) {
> -                       nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
> -                                             addr, details, rss,
> &force_flush,
> -                                             &force_break);
> -                       if (unlikely(force_break)) {
> -                               addr += nr * PAGE_SIZE;
> -                               break;
> -                       }
> -               } else {
> -                       nr = zap_nonpresent_ptes(tlb, vma, pte, ptent,
> max_nr,
> -                                                addr, details, rss);
> +               nr = do_zap_pte_range(tlb, vma, pte, addr, end, details,
> +                                     rss, &force_flush, &force_break,
> +                                     &any_skipped);
> +               if (can_reclaim_pt) {
> +                       VM_BUG_ON(!any_skipped && count_pte_none(pte,
> nr) == nr);

Okay, so this is really only for debugging then? So we can safely drop 
that for now.

I assume it would make sense to check when reclaiming a page table with 
CONFIG_DEBUG_VM, that the table is actually all-pte_none instead?

(as a side note: no VM_BUG_ON, please :) )

-- 
Cheers,

David / dhildenb



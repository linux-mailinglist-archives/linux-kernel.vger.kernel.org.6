Return-Path: <linux-kernel+bounces-402609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84A9C29A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B471C219C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D14086A;
	Sat,  9 Nov 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D8EalKeC"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D417FE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121760; cv=none; b=dZfRcw/A080SOjmLHfXbQP3VqeQ2RQnDJRiBcD0sGeMqD83HGZbp8x8sDGh67ZQypny3zDkYTH7O3tPb8kthcVug/cY4SKHti7yiASVBx7ophnrM2d/wWxH+IidIPBXpQ2C/YaiJhzzYeMa6YKrF7O35ls8AKGC8Bz4EG6M5cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121760; c=relaxed/simple;
	bh=wtsz5kJS1TnFHPa37iq/iVFAJk5wPpvVhlxVnOkmF8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tU45KGhBfb+AEyLQbcOb6omHfEWbzwK7Du6PxmMc0anEBFWJFQgeTqeHsKvfzjpnTxUp/7PvEv5tuGSKauy3512iMKCqMdXSpHYx4DXCVPsajZGhD2eq3dAPKyuEl47Y1UBgKhXxbG9aUA5BPR6OISHj9gOXSB+Q4RqUaWNGws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D8EalKeC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720be27db74so2232331b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 19:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731121758; x=1731726558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gox0zaors/Usl9NjGMbl7yQXcq9+RVKH7P6QUdPGdOk=;
        b=D8EalKeC911MS4W6Mje47/PwgaRv8T2AsB6kBohLOXUZ09FZM6BVvEirQKKhzCAi1O
         z+5Ul03eBN983ONagMDBqvXMypCBu+UmmrWbguF8qBmRAG1CB7kPPrfUMHEbE/K8QqEL
         z16LrSDGBp+RATwjc+lv+u3D7eOXzfiUdTcaJG4b9oVLIjyE/EYzNWd9oRqbJZlPC+j/
         2DmrgCOJXr22bHW7cOgfjy4yY6w10aK4pYt7IA/9TIjwwyBFQHnc/tfJj+D1U2QbJ75I
         6qXhpF2ghzjkGf5uXo4liwnWffohc/wz6BENvak12c9PdZxnPsP/AxVDCFd51hZHOnjz
         FmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731121758; x=1731726558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gox0zaors/Usl9NjGMbl7yQXcq9+RVKH7P6QUdPGdOk=;
        b=uMVTLFjaX9/H1qBDxtu2rjH7NhLRq846fEWCivusYnp6jhOe6ixrjxKJnEpaOj0Jx9
         tZ0iU1euzRgT7u4zmxr8IGKVDLsl3R6UhHtIVANOvoLhKuZMcZoybN7zZdnMyhldEnj8
         Uadyg0l2AfUPLkK4+qIFBTu9ds7ZffgfIp3axztMuNMJSvHE2EyiqagtE5MiaxAwTppE
         +4Gidwnr9FCOxXozv2nfBw/xpETMqqhdd6WlvuU2dD+/8Se/WBFdi9nH/o5EAKmc/pzt
         YwOWueERxkMOZQbwrqwyY5nvRh5l+lnX4NsMb9PCx++4FQ8ddyUQItozFfo4wqyddWkm
         OlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxiUXzWo8vGri0QGE8hMW92aJbfkxEwfKe+sRLEQlSnUn/8F1ZLNDQdYRh3LR/2pI7xEg/H6qrSBbjUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1oiL5qnNtcE+YIW9VvONOEDbrTxEnWCzIkcm1JHqvnqbT/Uf
	hDAEA+pQWEgCnI1tXIm8biCdntuyUfFx1PQX8Ib1f/WAuEGZPAIap/xbbXxrDXE=
X-Google-Smtp-Source: AGHT+IHdWXqVIIaaZW1uhG5g6QJs/KSB3EfnuHdAfZjDvz3rUX095jDt/0SkT/bqCMEnbRcuDuZNsg==
X-Received: by 2002:a05:6a00:3a18:b0:71e:5573:8dcd with SMTP id d2e1a72fcca58-72413f4c4eamr7905372b3a.2.1731121758351;
        Fri, 08 Nov 2024 19:09:18 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5b3f8fsm4256894a12.19.2024.11.08.19.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 19:09:17 -0800 (PST)
Message-ID: <cb59ffb5-b7ce-4ed8-a241-70917166be42@bytedance.com>
Date: Sat, 9 Nov 2024 11:07:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mm: pgtable: try to reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, peterx@redhat.com,
 catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0bv_y1k3cqMCsj0sJGPR4iK9zmHTa6124+N6i+s4+bTA@mail.gmail.com>
 <5d371247-853d-49ca-a28c-689a709905d4@bytedance.com>
 <CAG48ez3sG_=G6gttsEZnvUE4J-yHEUqyaNQfsdXR-LT-EqY2Yw@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAG48ez3sG_=G6gttsEZnvUE4J-yHEUqyaNQfsdXR-LT-EqY2Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/9 02:04, Jann Horn wrote:
> On Fri, Nov 8, 2024 at 8:13 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2024/11/8 07:35, Jann Horn wrote:
>>> On Thu, Oct 31, 2024 at 9:14 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>> As a first step, this commit aims to synchronously free the empty PTE
>>>> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
>>>> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
>>>> cases other than madvise(MADV_DONTNEED).
>>>>
>>>> Once an empty PTE is detected, we first try to hold the pmd lock within
>>>> the pte lock. If successful, we clear the pmd entry directly (fast path).
>>>> Otherwise, we wait until the pte lock is released, then re-hold the pmd
>>>> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detect
>>>> whether the PTE page is empty and free it (slow path).
>>>
>>> How does this interact with move_pages_pte()? I am looking at your
>>> series applied on top of next-20241106, and it looks to me like
>>> move_pages_pte() uses pte_offset_map_rw_nolock() and assumes that the
>>> PMD entry can't change. You can clearly see this assumption at the
>>> WARN_ON_ONCE(pmd_none(*dst_pmd)). And if we race the wrong way, I
>>
>> In move_pages_pte(), the following conditions may indeed be triggered:
>>
>>          /* Sanity checks before the operation */
>>          if (WARN_ON_ONCE(pmd_none(*dst_pmd)) || WARN_ON_ONCE(pmd_none(*src_pmd)) ||
>>              WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) ||
>> WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
>>                  err = -EINVAL;
>>                  goto out;
>>          }
>>
>> But maybe we can just remove the WARN_ON_ONCE(), because...
>>
>>> think for example move_present_pte() can end up moving a present PTE
>>> into a page table that has already been scheduled for RCU freeing.
>>
>> ...this situation is impossible to happen. Before performing move
>> operation, the pte_same() check will be performed after holding the
>> pte lock, which can ensure that the PTE page is stable:
>>
>> CPU 0                    CPU 1
>>
>> zap_pte_range
>>
>>                          orig_src_pte = ptep_get(src_pte);
>>
>> pmd_lock
>> pte_lock
>> check if all PTEs are pte_none()
>> --> clear pmd entry
>> unlock pte
>> unlock pmd
>>
>>                          src_pte_lock
>>                          pte_same(orig_src_pte, ptep_get(src_pte))
>>                          --> return false and will skip the move op
> 
> Yes, that works for the source PTE. But what about the destination?
> 
> Operations on the destination PTE in move_pages_pte() are, when moving
> a normal present source PTE pointing to an order-0 page, and assuming
> that the optimistic folio_trylock(src_folio) and
> anon_vma_trylock_write(src_anon_vma) succeed:
> 
> dst_pte = pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr,
> &dummy_pmdval, &dst_ptl)
> [check that dst_pte is non-NULL]
> some racy WARN_ON_ONCE() checks
> spin_lock(dst_ptl);
> orig_dst_pte = ptep_get(dst_pte);
> spin_unlock(dst_ptl);
> [bail if orig_dst_pte isn't none]
> double_pt_lock(dst_ptl, src_ptl)
> [check pte_same(ptep_get(dst_pte), orig_dst_pte)]
> 
> and then we're past the point of no return. Note that there is a
> pte_same() check against orig_dst_pte, but pte_none(orig_dst_pte) is
> intentionally pte_none(), so the pte_same() check does not guarantee
> that the destination page table is still linked in.

OK, now I got what you mean. This is indeed a problem. In this case,
it is still necessary to recheck pmd_same() to ensure the stability
of dst_pte page. Will fix it.

> 
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 002aa4f454fa0..c4a8c18fbcfd7 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1436,7 +1436,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>>>>    static inline bool should_zap_cows(struct zap_details *details)
>>>>    {
>>>>           /* By default, zap all pages */
>>>> -       if (!details)
>>>> +       if (!details || details->reclaim_pt)
>>>>                   return true;
>>>>
>>>>           /* Or, we zap COWed pages only if the caller wants to */
>>>
>>> This looks hacky - when we have a "details" object, its ->even_cows
>>> member is supposed to indicate whether COW pages should be zapped. So
>>> please instead set .even_cows=true in madvise_dontneed_single_vma().
>>
>> But the details->reclaim_pt should continue to be set, right? Because
>> we need to use .reclaim_pt to indicate whether the empty PTE page
>> should be reclaimed.
> 
> Yeah, you should set both.

OK.

Thanks!



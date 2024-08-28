Return-Path: <linux-kernel+bounces-305286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10227962C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7801C24129
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305219ADB6;
	Wed, 28 Aug 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJgvKUiM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2313D889
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859053; cv=none; b=oE2qv+w19z3gpGjiI3XMmm7rP4FdPr38YIlZAo7lFm7j+dNqwdRRbDT34v7KsnRj34birHGKFBTtkI72qyxuExL1uYCw82gmSUgijX6sCyqVPnft1l7td7NxlDAR4rJYnnSiL0ocnfWj/cxG9njdVNNVYRl52ryGx3YJLfokl/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859053; c=relaxed/simple;
	bh=xaeaqZl9Q4gDJsceMVKCzuIjb41VywrJfI4xjnEmVKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SacWi4WD0O6xkSIScZg2CGjz8oJ3g7xkfDpfhBfrvPrPganY7pMUqs0HHIa15OepIRnvOD4RcQN9UL4oeYpZWYu6usGIVZvw5kZywnZAeT2BCqdrsP+7DOe5S+n6XuB4qYWXFoiRj3Yt7eXphj+D5Wfw3p+rBgIlB6ziRAlmZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJgvKUiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724859049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQrY6fTjtMffITk65cE3lIhCjtNWs7f3wl30Hqmd/6A=;
	b=PJgvKUiMTGqXc5C72Dr9VkILhqhDDm+Yobfc77Z3X5XISDbdJq/1tljzVviPs+IEitCbbi
	riFK4ldGJ+x5k2LdtU/Gi+zoLI7u7ExgQQCVPNEOzuMDwKrifHetHxmGFhhIwimz+at0gQ
	RMrYO64Fh1MHctLL088ymNGpTo8Qxio=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-_vBF7VbaPzOeOkhMsDZeRw-1; Wed, 28 Aug 2024 11:30:48 -0400
X-MC-Unique: _vBF7VbaPzOeOkhMsDZeRw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42817980766so63160445e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859047; x=1725463847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQrY6fTjtMffITk65cE3lIhCjtNWs7f3wl30Hqmd/6A=;
        b=MiLM7PcuXMygLGS7PxHtGlZ5Sk7gVsRQVWQlebskNX+NcTRIORaF/wxbE6dWp/ESFE
         WxVLBcDOt/WKFgbAKGnR6tWMe9ICuQ650Dyw7WKJ8m2jxU2jkrvRbgqynYTPBRfs/pGN
         eUFdLC0kyewaFhYSAm07QLGUCkPmnRL4gXwTX+r5cnszF6G8hrFtzk8VHLJSZ8Gr840P
         REyjtTiTWwwK6AKMriEwDZt8RgwPUbo/cPdOifYe30rlURnl/sw3XdV0XQXeO7g3Jg+y
         rhh+GIE0DAjLaXdMtR/7a1oIUKtJ6rIumB0zUPfLPkBMkjYZx+BhIcG4EkBGpLm1VA1B
         Nqtg==
X-Gm-Message-State: AOJu0YzvkG8uwvmveFaFGKvF1Gz9aygifzY/Ry92Y5UagWlQJgDpVeKh
	ujTa96D3Fz3ULQf+pTDG3suJogX6LKOMF+tOl3gR5TjFJvefQmY0aLSleXH69nI8OTlOYgXrBZu
	iQiuiHk4QDn44W8prpiuP2k6XI+bpXmpkG/rO//WLmddGC5kybl2FIOZEs385Jg==
X-Received: by 2002:a7b:c449:0:b0:42b:aecb:d280 with SMTP id 5b1f17b1804b1-42bb27a1021mr77515e9.27.1724859046901;
        Wed, 28 Aug 2024 08:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcYrQAeqH4qohLw4p+ce1kbOV4E+qFSa8CCj124NKCzqOMjYPmc8sWetHU7svLzvNl292dQQ==
X-Received: by 2002:a7b:c449:0:b0:42b:aecb:d280 with SMTP id 5b1f17b1804b1-42bb27a1021mr76905e9.27.1724859045944;
        Wed, 28 Aug 2024 08:30:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a? (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de. [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639687csm24322545e9.8.2024.08.28.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 08:30:45 -0700 (PDT)
Message-ID: <c1d8220c-e292-48af-bbab-21f4bb9c7dc5@redhat.com>
Date: Wed, 28 Aug 2024 17:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/19] mm/pagewalk: Check pfnmap for folio_walk_start()
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Gavin Shan <gshan@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alistair Popple <apopple@nvidia.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-7-peterx@redhat.com>
 <9f9d7e96-b135-4830-b528-37418ae7bbfd@redhat.com> <Zs8zBT1aDh1v9Eje@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zs8zBT1aDh1v9Eje@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> This one is correct; I overlooked this comment which can be obsolete.  I
> can either refine this patch or add one patch on top to refine the comment
> at least.

Probably best if you use what you consider reasonable in your patch.

> 
>> +       if (IS_ENABLED(CONFIG_ARCH_HAS_PMD_SPECIAL)) {
> 
> We don't yet have CONFIG_ARCH_HAS_PMD_SPECIAL, but I get your point.
> 
>> +               if (likely(!pmd_special(pmd)))
>> +                       goto check_pfn;
>> +               if (vma->vm_ops && vma->vm_ops->find_special_page)
>> +                       return vma->vm_ops->find_special_page(vma, addr);
> 
> Why do we ever need this?  This is so far destined to be totally a waste of
> cycles.  I think it's better we leave that until either xen/gntdev.c or any
> new driver start to use it, rather than keeping dead code around.

I just copy-pasted what we had in vm_normal_page() to showcase. If not 
required, good, we can add a comment we this is not required.

> 
>> +               if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> +                       return NULL;
>> +               if (is_huge_zero_pmd(pmd))
>> +                       return NULL;
> 
> This is meaningless too until we make huge zero pmd apply special bit
> first, which does sound like to be outside the scope of this series.

Again, copy-paste, but ...

> 
>> +               if (pmd_devmap(pmd))
>> +                       /* See vm_normal_page() */
>> +                       return NULL;
> 
> When will it be pmd_devmap() if it's already pmd_special()?
> 
>> +               return NULL;
> 
> And see this one.. it's after:
> 
>    if (xxx)
>        return NULL;
>    if (yyy)
>        return NULL;
>    if (zzz)
>        return NULL;
>    return NULL;
> 
> Hmm??  If so, what's the difference if we simply check pmd_special and
> return NULL..

Yes, they all return NULL. The compiler likely optimizes it all out. 
Maybe we have it like that for pure documentation purposes. But yeah, we 
should simply return NULL and think about cleaning up vm_normal_page() 
as well, it does look strange.

> 
>> +       }
>> +
>> +       /* !CONFIG_ARCH_HAS_PMD_SPECIAL case follows: */
>> +
>>          if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>>                  if (vma->vm_flags & VM_MIXEDMAP) {
>>                          if (!pfn_valid(pfn))
>>                                  return NULL;
>> +                       if (is_huge_zero_pmd(pmd))
>> +                               return NULL;
> 
> I'd rather not touch here as this series doesn't change anything for
> MIXEDMAP yet..

Yes, that can be a separate change.

> 
>>                          goto out;
>>                  } else {
>>                          unsigned long off;
>> @@ -692,6 +706,11 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>>                  }
>>          }
>> +       /*
>> +        * For historical reasons, these might not have pmd_special() set,
>> +        * so we'll check them manually, in contrast to vm_normal_page().
>> +        */
>> +check_pfn:
>>          if (pmd_devmap(pmd))
>>                  return NULL;
>>          if (is_huge_zero_pmd(pmd))
>>
>>
>>
>> We should then look into mapping huge zeropages also with pmd_special.
>> pmd_devmap we'll leave alone until removed. But that's indeoendent of your series.
> 
> This does look reasonable to match what we do with pte zeropage.  Could you
> remind me what might be the benefit when we switch to using special bit for
> pmd zero pages?

See below. It's the way to tell the VM that a page is special, so you 
can avoid a separate check at relevant places, like GUP-fast or in 
vm_normal_*.

> 
>>
>> I wonder if CONFIG_ARCH_HAS_PTE_SPECIAL is sufficient and we don't need additional
>> CONFIG_ARCH_HAS_PMD_SPECIAL.
> 
> The hope is we can always reuse the bit in the pte to work the same for
> pmd/pud.
> 
> Now we require arch to select ARCH_SUPPORTS_HUGE_PFNMAP to say "pmd/pud has
> the same special bit defined".

Note that pte_special() is the way to signalize to the VM that a PTE 
does not reference a refcounted page, or is similarly special and shall 
mostly be ignored. It doesn't imply that it is a PFNAMP pte, not at all.

The shared zeropage is usually not refcounted (except during GUP 
FOLL_GET ... but not FOLL_PIN) and the huge zeropage is usually also not 
refcounted (but FOLL_PIN still does it). Both are special.


If you take a look at the history pte_special(), it was introduced for 
VM_MIXEDMAP handling on s390x, because pfn_valid() to identify "special" 
pages did not work:

commit 7e675137a8e1a4d45822746456dd389b65745bf6
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Mon Apr 28 02:13:00 2008 -0700

     mm: introduce pte_special pte bit


In the meantime, it's required for architectures that wants to support 
GUP-fast I think, to make GUP-fast bail out and fallback to the slow 
path where we do a vm_normal_page() -- or fail right at the VMA check 
for now (VM_PFNMAP).

An architecture that doesn't implement pte_special() can support pfnmaps 
but not GUP-fast. Similarly, an architecture that doesn't implement 
pmd_special() can support huge pfnmaps, but not GUP-fast.

If you take a closer look, really the only two code paths that look at 
pte_special() are GUP-fast and vm_normal_page().

If we use pmd_special/pud_special in other code than that, we are 
diverging from the pte_special() model, and are likely doing something 
wrong.

I see how you arrived at the current approach, focusing exclusively on 
x86. But I think this just adds inconsistency.

So my point is that we use the same model, where we limit

* pmd_special() to GUP-fast and vm_normal_page_pmd()
* pud_special() to GUP-fast and vm_normal_page_pud()

And simply do the exact same thing as we do for pte_special().

If an arch supports pmd_special() and pud_special() we can support both 
types of hugepfn mappings. If not, an architecture *might* support it, 
depending on support for GUP-fast and maybe depending on MIXEDMAP 
support (again, just like pte_special()). Not your task to worry about, 
you will only "unlock" x86.

So maybe we do want CONFIG_ARCH_HAS_PMD_SPECIAL as well, maybe it can be 
glued to CONFIG_ARCH_HAS_PTE_SPECIAL (but I'm afraid it can't unless all 
archs support both). I'll leave that up to you.

> 
>>
>> As I said, if you need someone to add vm_normal_page_pud(), I can handle that.
> 
> I'm pretty confused why we need that for this series alone.

See above.

> 
> If you prefer vm_normal_page_pud() to be defined and check pud_special()
> there, I can do that.  But again, I don't yet see how that can make a
> functional difference considering the so far very limited usage of the
> special bit, and wonder whether we can do that on top when it became
> necessary (and when we start to have functional requirement of such).

I hope my explanation why pte_special() even exists and how it is used 
makes it clearer.

It's not that much code to handle it like pte_special(), really. I don't 
expect you to teach GUP-slow about vm_normal_page() etc.

If you want me to just takeover some stuff, let me know.

-- 
Cheers,

David / dhildenb



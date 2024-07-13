Return-Path: <linux-kernel+bounces-251284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BE9302FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D853B28326F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876EDF59;
	Sat, 13 Jul 2024 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyCwcHDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B8C13C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720833507; cv=none; b=dK4sPzrkChwiZfHOjONCuWC+yh4hu+imPTAAZlHRdVbsvSSAUDHSI1ycn2exZdKVarF+rx5sufFuIYwTfnRhUUUy0v7id7CXWnkdPdOZOyHDq3X68xuWRuyRV0kVs4C7IzfOvZVmh8GS0nFusTcqQnhk0uhUEzViM0B2yu3aPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720833507; c=relaxed/simple;
	bh=9DtT3Em9XhrGwTdfmCYyFNSr7+rE+af+/1h4QouJCNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VihraaFast8sWwMIHa+IFExKRJJES+Gd80dngxS5uk2reZZb79eTyYz0douEyypeNF6WE/2mPEcK5oKihPA6P3aYQsd2W+fN6ooefpAnKajmtmSWD+KonPJIaWzr/CVrC/XeVZqgUwvPX0i6eeHzaWO8DBpuTBQ+UIgPX/s4iyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AyCwcHDe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720833503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yg3PnT1gxuKol1jHQF+qBk4w5qitgE0wByJpI44X15g=;
	b=AyCwcHDe32nqHQaYG5xZw5OSw4Wd/0/n4dtpS7uSEnKv/NWEz0X9C4e1lbrUfb3dR9MXpu
	QfeOukDgIJm9jITTbLCJ2G6RvA7yum2zXZXPJJxaWNmz4t4BL8Lphs1WszHqwBTdv/Gn3X
	rJhwgyWr/q0EjXxqPo7pQGwUBEQwJ+E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-NInbCWN3PAq0KguhuyoyRQ-1; Fri, 12 Jul 2024 21:18:21 -0400
X-MC-Unique: NInbCWN3PAq0KguhuyoyRQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f6810e43e0so20026575ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720833500; x=1721438300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yg3PnT1gxuKol1jHQF+qBk4w5qitgE0wByJpI44X15g=;
        b=TTyjBBkCsrhMg1+tS7IfkUIhjboaij6gl5Uq8QVrN7NpcPQqHwdmuq8iyAcKo3m0iP
         SLH+8mMseLq1Fd7avof1WK8WUFjMtvrV9EK9yRUHUt6nowQ0yalqHQpBCA7+BlTvtYIu
         U3T4rVfawSodXHrHOl1vuhNRB+JIb32eQmgMLtNByaMzcXJzzNbXOcrZ/7RGzsjIFvvb
         oY5TjesWgDwc/QJ8r880aqgFod5BcOR4VqQB4YxDtAqxR72GPnLjKCFldeNwOF43JWw5
         E7dKXGthaXqzXSPyYP34Ghzj4I+Z4EF9YfmNczgmvwmwJTjeaXP6oGLnttalqjn+ne09
         Ph+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBy3eKxI0OvMCmBVDyQMQNyst16huoIE86TgYDNWfNIReEYfJU1wfDUU6w9R3UaWDOfy2ME8Ymbf8ZwPx6npzrIGm1RergHy7kbncQ
X-Gm-Message-State: AOJu0YyPKNO+MVQlmpEPR8e7FN8zS+PLhcT7rD7C/d+zV0AMAz6B5irD
	iJ/z4PjnP7KsPHiRKfggqfPkeqGGmWBhnw1YyYHmsVf1YtWq+3NCPX69zE2JWnbNpaUK2YagJEl
	zCFYIu3IfGIKIoQciWqonO5Egn7LF/cro6H5pUlIC2e8/oFN/janUp3uOyPsEDQ==
X-Received: by 2002:a17:902:e74b:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-1fc0b58dabfmr3965385ad.22.1720833500583;
        Fri, 12 Jul 2024 18:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+1jtEh2mTJyPIQQfuZSo++BlCWGQeaMWBJdJnKzCTi4OX+RWimSnqxG7zdl9lg2VSucVdWg==
X-Received: by 2002:a17:902:e74b:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-1fc0b58dabfmr3965175ad.22.1720833500166;
        Fri, 12 Jul 2024 18:18:20 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fdc9sm661685ad.52.2024.07.12.18.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 18:18:19 -0700 (PDT)
Message-ID: <52c8e760-1747-4ca2-97bd-77818bcc8926@redhat.com>
Date: Sat, 13 Jul 2024 03:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, x86@kernel.org, Yan Zhao <yan.y.zhao@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
 David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20240712144244.3090089-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240712144244.3090089-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.07.24 16:42, Peter Xu wrote:
> This patch is one patch of an old series [1] that got reposted standalone
> here, with the hope to fix some reported untrack_pfn() issues reported
> recently [2,3], where there used to be other fix [4] but unfortunately
> which looks like to cause other issues.  The hope is this patch can fix it
> the right way.
> 
> X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> start at mmap() of device drivers, then untracked when munmap().  However
> in the current code the untrack is done in unmap_single_vma().  This might
> be problematic.
> 
> For example, unmap_single_vma() can be used nowadays even for zapping a
> single page rather than the whole vmas.  It's very confusing to do whole
> vma untracking in this function even if a caller would like to zap one
> page.  It could simply be wrong.
> 
> Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> for pfnmaps and it'll fail the madvise() already before reaching here.
> However looks like it can be triggered like what was reported where invoked
> from an unmap request from a file vma.
> 
> There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> pgtables before an munmap(), in which case we may not want to untrack the
> pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> pfn tracking information as those pfn mappings can be restored later with
> the same vma object.  Currently it's not an immediate problem for VFIO, as
> VFIO uses UC- by default, but it looks like there's plan to extend that in
> the near future.
> 
> IIUC, this was overlooked when zap_page_range_single() was introduced,
> while in the past it was only used in the munmap() path which wants to
> always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> zap_page_range() callers that act on a single VMA use separate helper") is
> the initial commit that introduced unmap_single_vma(), in which the chunk
> of untrack_pfn() was moved over from unmap_vmas().
> 
> Recover that behavior to untrack pfnmap only when unmap regions.
> 
> [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: x86@kernel.org
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Pei Li <peili.dev@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Wang <00107082@163.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> NOTE: I massaged the commit message comparing to the rfc post [1], the
> patch itself is untouched.  Also removed rfc tag, and added more people
> into the loop. Please kindly help test this patch if you have a reproducer,
> as I can't reproduce it myself even with the syzbot reproducer on top of
> mm-unstable.  Instead of further check on the reproducer, I decided to send
> this out first as we have a bunch of reproducers on the list now..
> ---
>   mm/memory.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4bcd79619574..f57cc304b318 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>   	if (vma->vm_file)
>   		uprobe_munmap(vma, start, end);
>   
> -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> -
>   	if (start != end) {
>   		if (unlikely(is_vm_hugetlb_page(vma))) {
>   			/*
> @@ -1894,6 +1891,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>   		unsigned long start = start_addr;
>   		unsigned long end = end_addr;
>   		hugetlb_zap_begin(vma, &start, &end);
> +		if (unlikely(vma->vm_flags & VM_PFNMAP))
> +			untrack_pfn(vma, 0, 0, mm_wr_locked);
>   		unmap_single_vma(tlb, vma, start, end, &details,
>   				 mm_wr_locked);
>   		hugetlb_zap_end(vma, &details);


Yes, I would prefer that, and it makes sense to me.

Should we then have a "Fixes:" tag (at least my commit, maybe the 
original commit that made this also be called in wrong context)?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



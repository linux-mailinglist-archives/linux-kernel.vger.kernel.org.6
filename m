Return-Path: <linux-kernel+bounces-435250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6689E7516
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707A01623B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80F20C00D;
	Fri,  6 Dec 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKH62KFT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43DF20DD43
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501042; cv=none; b=OCHeMHnBYNU0pxfJRwpT/VAjig/B3w9aPDZ4XbJMTFXN5+KHrpUkbSeFJrlI4GIqkt/xVlRxeoeNHi2Jb8mDNIaa3dcSkqqG1YA2qbj+fyjU5Mei/h0qIMKhmWAtR7UnLt3WUzvQfA4/3soYv6afMy9a3RK1/aFho1JSX9QuBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501042; c=relaxed/simple;
	bh=afiIYH5eSDQoUw71co21Jytpmu/gi4zkvN1pjqNswi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbAWDAaaKQFtx9NAcMWKA+zu5kjxM6BGN+9I0Hu0tGp6yDq6lWke+RvVZCSA15ZlGjD1iBRWeez7dKpPIsdsxnsqypRgnlU8fY1vyM6behXkZshJbM0Fg3XyDRbJJ8YNlBaJfw7DHeLw9J9T2tgWyls5UM3n3nvkzUXq0U0vHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKH62KFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733501039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k+adP35zR2zQlyOhfBGiAnpN/hIukFG9TUTEXZ4dwEk=;
	b=BKH62KFTJ7v7UPHNfrk4Dix33A7UlkyMReH7C9Bdmu0dJKH/wvL5G4XBrkH3MiotU7NFQI
	Gzc96g6hVQmCDOa/HjcOFed0pKQifrAo3osURxCWDSbzrnWrRinI7Ku4KOxKfOYLQmcc3u
	eFsiTDcxGAp+cLsvepgiPT/lGJZx8RY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-F8cB2USNPM2IHDUkbN1T4g-1; Fri, 06 Dec 2024 11:03:58 -0500
X-MC-Unique: F8cB2USNPM2IHDUkbN1T4g-1
X-Mimecast-MFC-AGG-ID: F8cB2USNPM2IHDUkbN1T4g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349cbf726cso14476815e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501037; x=1734105837;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k+adP35zR2zQlyOhfBGiAnpN/hIukFG9TUTEXZ4dwEk=;
        b=rx9P/BbeS/oCW+I80OLAMGeLhMG/ht4Lx00Rwnu9jFjGpALaubV8uubob5MltnyQa+
         +qerOeb+Dz0LB9wX2BJKgGmSpVM89r0GdlzVYbWv4kNKdWOzFE1g8pnEZ6/PfxvFgpFF
         Gr0vRcZ+mu3uzwO24c+MQXFvfU/Wkk+1AJmbCPf9f8TsE8eST2dgtmAommP/Yc+33D/s
         iEl3n7S8HI0c7Uh/jnf6GBukvnlt7MHl/x6MALFjB5H3K+uuFF2Akeus9DL8uYedUtNq
         g40MZVzjVeSFKV8LqVR5VWmzXHm9Z/f+RgyD1zaYhNf7AP8wLsaFRsREXTjrZhk+uhEm
         Jk1g==
X-Forwarded-Encrypted: i=1; AJvYcCXN+QLMHRrNWB4iPSSOYst31PJnzcMJjx2x+m16d1SJ7SpbFoOH2nKUzyHHbBc17c4KqesgMdtCoNi2UjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tbJyDEH9Ymcr3FaVEdP35C955+Dp3dbukTmiCGEdTFSG6G03
	IiLg8mR3zt6MD+K45mPII3aVKDuDfjfUZpGgyBDQcgg+yNdPpdcrwr6ZkVb5XGjJfYqheTxMaC2
	vFRQAv8VI32WmqKPj3qCPRDFXbOJGB92MjshKp8FgnXvL2hhyFHNrAiovPunAXQ==
X-Gm-Gg: ASbGncuw+DQLa5sAFwVonvbDav5WVt2/2iFdM3iJ2vcZdkKG3+Cqa6N1yfuR3gQ0Dul
	FzATMoG2ek66Z3lAkvjfomFRy1zdM1I3T/nhrFf7QI7y7iWDTFeTZxZdKPfJKXvp6g6w+dyVFrR
	RXKqiK9FVOQZrOY5Lw3R8CN2e2nWUsJe4iPKlKouuHEjPRhXSNxf5RuziP/sFdniZHmJJTzcQq4
	xh50G5xgUjQoQjh97yrxRTsh5JxqPhDSB8cjZCDwoFQknLfpW8QpRQNDMO62M2ZeeJkCHAN/ZyD
	yPeByFTjCYU839dXw4kXYrnI12xeOQcPOfaoVPAGlN8nXPlAXr/eT5SvIzwIuJmwXdH10LwkLPJ
	SSg==
X-Received: by 2002:a05:600c:1c0e:b0:434:a378:51a8 with SMTP id 5b1f17b1804b1-434dded5d0emr32151555e9.27.1733501036961;
        Fri, 06 Dec 2024 08:03:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv36Qi/GQneGq9bATglVFTQS/fXeOiFfQylsx9fBe93k0Qrr1y7r5aMLEG1Pc/st3unUEnuQ==
X-Received: by 2002:a05:600c:1c0e:b0:434:a378:51a8 with SMTP id 5b1f17b1804b1-434dded5d0emr32150975e9.27.1733501036502;
        Fri, 06 Dec 2024 08:03:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7? (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219096adsm4974931f8f.85.2024.12.06.08.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:03:55 -0800 (PST)
Message-ID: <8395af7d-328a-425c-84a7-517e78a602b1@redhat.com>
Date: Fri, 6 Dec 2024 17:03:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
To: Guillaume Morin <guillaume@morinfr.org>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Eric Hagberg <ehagberg@janestreet.com>
References: <Z1MO5slZh8uWl8LH@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z1MO5slZh8uWl8LH@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.12.24 15:49, Guillaume Morin wrote:
> Eric reported that PTRACE_POKETEXT fails when applications use hugetlb
> for mapping text using huge pages. Before commit 1d8d14641fd9
> ("mm/hugetlb: support write-faults in shared mappings"), PTRACE_POKETEXT
> worked by accident, but it was buggy and silently ended up mapping pages
> writable into the page tables even though VM_WRITE was not set.
> 
> In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb.
> Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that
> what used to work in the past by accident now properly works, allowing
> applications using hugetlb for text etc. to get properly debugged.
> 
> This change might also be required to implement uprobes support for
> hugetlb [1].
> 
> [1] https://lore.kernel.org/lkml/ZiK50qob9yl5e0Xz@bender.morinfr.org/
> 
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> ---
> Changes in v2:
>   - Improved commit message
> Changes in v3:
>   - Fix potential unitialized mem access in follow_huge_pud
>   - define pud_soft_dirty when soft dirty is not enabled
> Changes in v4:
>   - Remove the soft dirty pud check
>   - Remove the pud_soft_dirty added in v3
> 
>   mm/gup.c     | 95 +++++++++++++++++++++++++---------------------------
>   mm/hugetlb.c | 20 ++++++-----
>   2 files changed, 57 insertions(+), 58 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 746070a1d8bf..63c705ff4162 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -587,6 +587,33 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
>   }
>   #endif	/* CONFIG_HAVE_GUP_FAST */
>   
> +/* Common code for can_follow_write_* */
> +static inline bool can_follow_write_common(struct page *page,
> +		struct vm_area_struct *vma, unsigned int flags)
> +{
> +	/* Maybe FOLL_FORCE is set to override it? */
> +	if (!(flags & FOLL_FORCE))
> +		return false;
> +
> +	/* But FOLL_FORCE has no effect on shared mappings */
> +	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> +		return false;
> +
> +	/* ... or read-only private ones */
> +	if (!(vma->vm_flags & VM_MAYWRITE))
> +		return false;
> +
> +	/* ... or already writable ones that just need to take a write fault */
> +	if (vma->vm_flags & VM_WRITE)
> +		return false;
> +
> +	/*
> +	 * See can_change_pte_writable(): we broke COW and could map the page
> +	 * writable if we have an exclusive anonymous page ...
> +	 */
> +	return page && PageAnon(page) && PageAnonExclusive(page);
> +}
> +
>   static struct page *no_page_table(struct vm_area_struct *vma,
>   				  unsigned int flags, unsigned long address)
>   {
> @@ -613,6 +640,18 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>   }
>   
>   #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
> +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
> +					struct vm_area_struct *vma,
> +					unsigned int flags)
> +{
> +	/* If the pud is writable, we can write to the page. */
> +	if (pud_write(pud))
> +		return true;
> +
> +	return can_follow_write_common(page, vma, flags);
> +}
> +
>   static struct page *follow_huge_pud(struct vm_area_struct *vma,
>   				    unsigned long addr, pud_t *pudp,
>   				    int flags, struct follow_page_context *ctx)
> @@ -625,13 +664,16 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
>   
>   	assert_spin_locked(pud_lockptr(mm, pudp));
>   
> -	if ((flags & FOLL_WRITE) && !pud_write(pud))
> +	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> +	page = pfn_to_page(pfn);
> +
> +	if ((flags & FOLL_WRITE) &&
> +	    !can_follow_write_pud(pud, page, vma, flags))
>   		return NULL;
>   
>   	if (!pud_present(pud))
>   		return NULL;
>   
> -	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;

That looks wrong. See follow_huge_pmd() for reference

(1) You must not do a pfn_to_page() before we verified that we have a
     present PUD.

(2) can_follow_write_pud() must be called with the first mapped page. It
     would currently with hugetlb not be strictly required, but is not
     future proof.



It must be likely be something like:


if (!pud_present(pud))
	return NULL;

if ((flags & FOLL_WRITE) &&
     !can_follow_write_pud(pud, pfn_to_page(pfn), vma, flags))
	return NULL;

pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
page = pfn_to_page(pfn);


>   
>   		delayacct_wpcopy_end();
>   		return 0;
> @@ -5943,7 +5944,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>   	spin_lock(vmf->ptl);
>   	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
>   	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
> -		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
> +		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
> +		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
);

You probably missed my earlier comment. After the recent changes to 
make_huge_pte() that are already in mm/mm-unstable, this hunk can be 
dropped and left unchanged. make_huge_pte() will perform the VM_WRITE check.

-- 
Cheers,

David / dhildenb



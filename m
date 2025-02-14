Return-Path: <linux-kernel+bounces-515389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A9A3643B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A4B188E95E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C5267F47;
	Fri, 14 Feb 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKniw/7W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACD7E0ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553464; cv=none; b=ULlq4xbX+L42VfhCeOUQimaZ2qpezbxFAeLfBmlrJtDuAiLNsIQ2p746Qbt1ox90hFY1kjf/M5Xglrem/oQMwdx1nAW2TebzdziAt+IYXMnjqPoNd2Sig9XaPwQqVNyzWMJxvQNJg5/tuK38t7dl91YRB2dk3qs8KYhPzfLzk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553464; c=relaxed/simple;
	bh=hSKHANdhOa4GbGIBCUy5VHKi/BUtKMbSGMapb2R/3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOV+kcJa+rw5o0cmtYdAJ98GKGRGYJucAFEwX3ADjqZiiosy22oAzWYvE9TPNZlnDlV0WdTP7zxkedGnsz062I2KH12oO0Z3Fe7bjfymooHKRqQFZwOT73mEm0CWNW6c5GKVi7U2pF7uRx/d+bDqhWj/Ida3zmEYAKBYJuRn+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKniw/7W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739553461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vPfsF1K7YUp9R9mQX+7RKyz57Btz7H8JUY3WuYwgCK4=;
	b=LKniw/7WHErFcNLGPhIKkMpChPZQc92i+LPuqEGhUiTcgLilgBxJpM2MZEnd0QicCJ4Ml1
	bAauEF4TEmXIGd94YCWPGbnv94SbuNJ4ZqdaPumRgkYy8+hhu4U95EDsmB3Kv3zC0m/Xjw
	aYZJey40NGC8J+w0OrH6dkaoKMx7fDM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-8Q6NsINANe62086ZS8SYKg-1; Fri, 14 Feb 2025 12:17:39 -0500
X-MC-Unique: 8Q6NsINANe62086ZS8SYKg-1
X-Mimecast-MFC-AGG-ID: 8Q6NsINANe62086ZS8SYKg_1739553459
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85537a78aa8so2320539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739553459; x=1740158259;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPfsF1K7YUp9R9mQX+7RKyz57Btz7H8JUY3WuYwgCK4=;
        b=qmdbLfnEtXsSNi8YYm2hyHOxup1nlMW/3GNJqy3NzdVuGIRG3MYXt8g7jEQTmR9rQm
         21tJqNWPqd3nkjM7ss9KwJ2BCnrjot0SjhS/eiv5+kqmR1sF2E6gabVUQbee0M56so0y
         rub8Maz0cDAdnwoCceUdlpM4U3rKfvOgUvwz6oAovZCpV5+X2Rb9yEBunQxnd7yerL32
         Vr69uNZLLfd0k2Ok4NbIoT4XO5dH/P6pRhS1+2dEEFTPK9v7JhX5OvGqFn6gWMMaUcNh
         vBLtwPocIilRMOQWrev/uCe72wbw5Sl4UrNamC8NG/UkHNTQ5XzkUlJkPtMSOJfYPbam
         u/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV8sYpQ92LLIA4MygyoS0Lql/doROqC1OGd94dzdeXnqPPgMkt5UpQjmwPvnrnVIUr0r5M+vigH2V5X1Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/hcuEQycPrewKU3GyTMZk0FsIKVRtwYEgEZVas01gPgROgzX
	tB77+6S9t5Zix5vaZeOABN29MNpOKgIXZqJHf6PNBqOmHUE7sWxNtKnawD4DROJlFQ156VTJimL
	JZLjI3NkvptvIyXwAnGQ6w6s9QIoORd0veEvNuBo7YKSq7f7fZfSFiznKFDOeoA==
X-Gm-Gg: ASbGncuNU68cY1Rv0RVPbapgZ2I4k/Ijn8l5JYCbgRPTroxgehEjONhRQ8B++TBUEwC
	+uDOpxbFjMmmiemO1Zpu1n88c3JPERLKsgTRw1Va8d+Qs3BqkbTGHrP/vekNrss7y/sgXzk4XpM
	k46UUoqLHvoDRD8bAPegsrUaRnhkLXJkJqF9/EkO8k/hymaeGKqixq1LNgGSabipe0Bm2v8jWSA
	wexL8VM6rtDERooeLt7zql+sxJWmt8mJsNndnoWQffgW28iwhFVmF8m+CDtxR3M0bB+qeCF6VLl
	qsX/bImj
X-Received: by 2002:a05:6e02:1d13:b0:3d1:8bf1:46f9 with SMTP id e9e14a558f8ab-3d280987dcdmr318245ab.7.1739553458417;
        Fri, 14 Feb 2025 09:17:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Qz9VO3Ey/mEXhAHSN+HIg08dAc+H18Eqqwc7ITCwAustrikXMJraW28xXpxtim+2NFB8yg==
X-Received: by 2002:a05:6e02:1d13:b0:3d1:8bf1:46f9 with SMTP id e9e14a558f8ab-3d280987dcdmr318125ab.7.1739553458021;
        Fri, 14 Feb 2025 09:17:38 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed282d7b4bsm902182173.115.2025.02.14.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:17:37 -0800 (PST)
Date: Fri, 14 Feb 2025 10:17:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] mm: Provide page mask in struct follow_pfnmap_args
Message-ID: <20250214101735.4b180123.alex.williamson@redhat.com>
In-Reply-To: <20250205231728.2527186-5-alex.williamson@redhat.com>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
	<20250205231728.2527186-5-alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Nudge.  Peter Xu provided an R-b for the series.  Would any other mm
folks like to chime in here to provide objection or approval for this
change and merging it through the vfio tree?  Series[1].  Thanks!

Alex

[1]https://lore.kernel.org/all/20250205231728.2527186-1-alex.williamson@redhat.com/

On Wed,  5 Feb 2025 16:17:20 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> follow_pfnmap_start() walks the page table for a given address and
> fills out the struct follow_pfnmap_args in pfnmap_args_setup().
> The page mask of the page table level is already provided to this
> latter function for calculating the pfn.  This page mask can also be
> useful for the caller to determine the extent of the contiguous
> mapping.
> 
> For example, vfio-pci now supports huge_fault for pfnmaps and is able
> to insert pud and pmd mappings.  When we DMA map these pfnmaps, ex.
> PCI MMIO BARs, we iterate follow_pfnmap_start() to get each pfn to test
> for a contiguous pfn range.  Providing the mapping page mask allows us
> to skip the extent of the mapping level.  Assuming a 1GB pud level and
> 4KB page size, iterations are reduced by a factor of 256K.  In wall
> clock time, mapping a 32GB PCI BAR is reduced from ~1s to <1ms.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/linux/mm.h | 2 ++
>  mm/memory.c        | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b1c3db9cf355..0ef7e7a0b4eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2416,11 +2416,13 @@ struct follow_pfnmap_args {
>  	 * Outputs:
>  	 *
>  	 * @pfn: the PFN of the address
> +	 * @pgmask: page mask covering pfn
>  	 * @pgprot: the pgprot_t of the mapping
>  	 * @writable: whether the mapping is writable
>  	 * @special: whether the mapping is a special mapping (real PFN maps)
>  	 */
>  	unsigned long pfn;
> +	unsigned long pgmask;
>  	pgprot_t pgprot;
>  	bool writable;
>  	bool special;
> diff --git a/mm/memory.c b/mm/memory.c
> index 398c031be9ba..97ccd43761b2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6388,6 +6388,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>  	args->lock = lock;
>  	args->ptep = ptep;
>  	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
> +	args->pgmask = addr_mask;
>  	args->pgprot = pgprot;
>  	args->writable = writable;
>  	args->special = special;



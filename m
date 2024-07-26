Return-Path: <linux-kernel+bounces-263753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A937093DA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70474285431
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E22149C5A;
	Fri, 26 Jul 2024 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4FfBEvg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8E748A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029336; cv=none; b=eZCfaUJCxe/wVtApdJTl9I6ZjxjQ2PUlAwMnbzLavhId5PEhx3iUSrFF2bB3/GWlQWqpOmB1aVycGhzKDC9CfQ65tGMGeHkXmMn+keUBLSTA8vilLJYeihXLFe/W7d3apTVbWRBVHRbB/AT7i3U5n5cIyv+Xh5ABU48jzEs991A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029336; c=relaxed/simple;
	bh=BSWSuKq3GdETVVD+bBDGO4tkeDnaegLbXieUBwwRVeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP1eV5mv2eUim/vW6RAbxOh9Lu3uTc49a/li4PL/rQXzag7TWR2JIrqMKgpPIuixjQAKpAwuZtwwEEuY+ORmdfqTg/Amo0ME8O1q6Shq+gYIj2gzPhadRBypzee5vuE+xLBsrr0u/S0q8ledyhIom1RhRKG7oOBTnZoE/StMLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4FfBEvg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722029333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq8fcYg7vmbu2tY0cVnCTlYYMnfwT6dNzxghIL6A57Y=;
	b=M4FfBEvgdRCwMF5Im/zHaxS5tP6DcSdr9qpN+/O1PnRMlg3T4owibzy2KsnR+Tg32Xy9fe
	+iC/ZCGGQgZehMvO7F76w4uQW7pkSwA5YK3mvUVO/O+2K+4uvikIQliBlen0KdUlPerpPV
	8cpcXat/DjcYn+3ojUXrBmr49fk6pGE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-UmZvnWegONmt6E8jGL6iAg-1; Fri, 26 Jul 2024 17:28:51 -0400
X-MC-Unique: UmZvnWegONmt6E8jGL6iAg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7ad98c1f8so2161376d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722029331; x=1722634131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq8fcYg7vmbu2tY0cVnCTlYYMnfwT6dNzxghIL6A57Y=;
        b=q+euOvb2ZQNEp5ClwE87JOZL9lm2ic6cmk4LT18+PpuU/d+KQz3BCNwR466EGI8Ii3
         dUbkR8R6bXllK8bfpgKUm+hj4MrB+YiXYniADX3YRgKjbLmi1lIc/O7Fme1a04sPinfs
         vlCC/nstKyAOthvKA3AUJB+LIKyYTvHsZlTf0OVmU90aJsT3I4AsOc88/fGEkR56GRN+
         X6AiE0BMUNbIikkaVEUWN76Uwzvx7cZO43wAdpSpb5li+Ggxgj0gYlUPc4gmJabIOtO0
         iVmSNixlB5a/FJY7cphgq/c/H8m47lZipCBAmL3ABixi7jo0W9jt19LzAT31hOM8GjYT
         Nbiw==
X-Gm-Message-State: AOJu0YxXCuOvqhMbWhQQB+c0eLIlUkruWAgAFDrhLKj9dbe6BiKx8c8O
	ofSGmN5oQ5lqA8nKpxZUzf1SJhdvX8PKXe7YeHb5MpKMazBacC7m0XygJKDde2/dGDEwLh/9NAX
	7hGCJyYChqAYDSKzKYZEu6CHe4RIsKk9ktVarbilf6yOmrYyBncoIBBGxTjgG7w==
X-Received: by 2002:a05:620a:1a9f:b0:79e:fc9c:4bc2 with SMTP id af79cd13be357-7a1d690cf22mr524519985a.4.1722029330776;
        Fri, 26 Jul 2024 14:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyiXPUaaUBgyOseIoBqy+vK4d5h7x2HpItD5MjFagg5KiFr43MKWqy7glmFCF3oJgLIGdk3A==
X-Received: by 2002:a05:620a:1a9f:b0:79e:fc9c:4bc2 with SMTP id af79cd13be357-7a1d690cf22mr524518985a.4.1722029330388;
        Fri, 26 Jul 2024 14:28:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe840cd64sm16520281cf.81.2024.07.26.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:28:49 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:28:47 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
Message-ID: <ZqQVDwv4RM-wIW7S@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <ZqPCjd35OdNRrcfl@x1n>
 <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf2069ed-f2b8-49d4-baf0-dbd2189362f9@redhat.com>

On Fri, Jul 26, 2024 at 06:02:17PM +0200, David Hildenbrand wrote:
> On 26.07.24 17:36, Peter Xu wrote:
> > On Thu, Jul 25, 2024 at 08:39:54PM +0200, David Hildenbrand wrote:
> > > pte_lockptr() is the only *_lockptr() function that doesn't consume
> > > what would be expected: it consumes a pmd_t pointer instead of a pte_t
> > > pointer.
> > > 
> > > Let's change that. The two callers in pgtable-generic.c are easily
> > > adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
> > > pte_offset_map_nolock() to obtain the lock, even though we won't actually
> > > be traversing the page table.
> > > 
> > > This makes the code more similar to the other variants and avoids other
> > > hacks to make the new pte_lockptr() version happy. pte_lockptr() users
> > > reside now only in  pgtable-generic.c.
> > > 
> > > Maybe, using pte_offset_map_nolock() is the right thing to do because
> > > the PTE table could have been removed in the meantime? At least it sounds
> > > more future proof if we ever have other means of page table reclaim.
> > 
> > I think it can't change, because anyone who wants to race against this
> > should try to take the pmd lock first (which was held already)?
> 
> That doesn't explain why it is safe for us to assume that after we took the
> PMD lock that the PMD actually still points at a completely empty page
> table. Likely it currently works by accident, because we only have a single
> such user that makes this assumption. It might certainly be a different once
> we asynchronously reclaim page tables.

I think it's safe because find_pmd_or_thp_or_none() returned SUCCEED, and
we're holding i_mmap lock for read.  I don't see any way that this pmd can
become a non-pgtable-page.

I meant, AFAIU tearing down pgtable in whatever sane way will need to at
least take both mmap write lock and i_mmap write lock (in this case, a file
mapping), no?

> 
> But yes, the PMD cannot get modified while we hold the PMD lock, otherwise
> we'd be in trouble
> 
> > 
> > I wonder an open coded "ptlock_ptr(page_ptdesc(pmd_page(*pmd)))" would be
> > nicer here, but only if my understanding is correct.
> 
> I really don't like open-coding that. Fortunately we were able to limit the
> use of ptlock_ptr to a single user outside of arch/x86/xen/mmu_pv.c so far.

I'm fine if you prefer like that; I don't see it a huge deal to me.

Thanks,

-- 
Peter Xu



Return-Path: <linux-kernel+bounces-296068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E695A51B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3072816B1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595D16DED2;
	Wed, 21 Aug 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG+FoLKV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588179CD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267452; cv=none; b=G+vZhbpfEtjlnHqigeOJfF7qQNnSAjaYGi/mJRdhX5DwkXVDeK3xtfl35dpvbjz68+dTT2DCPhPXPX/RPukaAYtPV8y4UVWqLqdyimnmJXwirzDMy4kvFGyel8ZfaN7DvFdBW0yBGQfykqGSqPpScgc8PdxkwMASgnR0tV2PqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267452; c=relaxed/simple;
	bh=hL4gVnMX0lonKO+Xr56sF/EGBpa9lOCldCHEZWgHhnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOFjBxqgzibpqL2ea9oEr+bthNuYMV1/YozBWXh/jGFTALMwmFxvtc6T4uPXwCI9TFbmF7CVxjadRPLLv/Ur8UkNon2oObfG7rUp+oJbfesC3N9mdXm4FJHB28NCE9Sbn/mjsWgGvgRPccX/uqLmWOOS8cUfvtlBscrd5AThEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG+FoLKV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724267450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAq367Lg1/3EfbDlw0i1dZv1l3nmGW6xuUPajxTPQeg=;
	b=hG+FoLKVuTIMvQov1W8xqodNd0cGHoOzuLOp2TnO6z1/gO7ibvtWRWY3Kqu+jQo1rpO9nV
	yJ755+oSRWH+ZBupu4wLh6OD9pJqrOP/T9WXEZmnlTV6veuhT2wwy7jX1mkWoyh4V86Sde
	KOq/1h9uxIn5PnLMpfc9SdFeAhuTO9A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-LBUlSkrsMIOqQDLudmFMIw-1; Wed, 21 Aug 2024 15:10:47 -0400
X-MC-Unique: LBUlSkrsMIOqQDLudmFMIw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6bf8cef1c5cso52951526d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267447; x=1724872247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAq367Lg1/3EfbDlw0i1dZv1l3nmGW6xuUPajxTPQeg=;
        b=iCiCE7xQcNXooVilvv2qzT+QxKJNV2GwZdw6LyhiKG2xdRLq0LEcBjt05sMUq9abdX
         OwLW50LyQ7gLUXkMWgHM68MMFEA+wY8qKkUTm04ruO310TuGdEPy/pqJ9FZtwSBqBBqb
         owTWXq9/VqD1oql06en9mi0AOcgxUmSwRMc6ferixRKKhkkXFlvAnsV+Nc/xQ7HdUoT5
         2DMn/SXtt+pUU0d0JHhhQMN8Za+bPRppi+afhEg2o6KiX5hlRK5pym3qWVgHsLtTl5n1
         ZSxO8iQ38gghZcN7Yym1njbCi0e/NDlqmwwcrq5TYeifzyK2je1o6MC6AWfzsETknXWG
         nsfw==
X-Forwarded-Encrypted: i=1; AJvYcCW2F3u0LteFTbGmw2lIfbqPApNJmv65vN3IX+HGbnnJAFGxA5gP6/jGrIppWCeiVZQWewoJay+HVKRccAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMdFOJlJoZtXgdMDKAdI30XX99VN2mfA+NLf5K7Vt/Lz2vhHs
	OzevrKUKFhZfB06y5Msn48bHU2LtrTwKlD/kzin9KtpGtsKz3t6pdF3gIEgBCtEztMUwi8ihy9U
	wW5yTXQZV6ADCYd7tHYoUA+QXBWcXBq9A1WiFfR9RSN8ibPK7vnRlxh0hu1Wy8Q==
X-Received: by 2002:a05:6214:4881:b0:6bf:7cc0:7283 with SMTP id 6a1803df08f44-6c155d5b159mr43529586d6.6.1724267447178;
        Wed, 21 Aug 2024 12:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0EFUeCwlBx0qAmDzBtd+l4FNnqw758KbLszeGCNNuUW9zuat7gLyeNsx6mlWpwsnSymqf3g==
X-Received: by 2002:a05:6214:4881:b0:6bf:7cc0:7283 with SMTP id 6a1803df08f44-6c155d5b159mr43529176d6.6.1724267446788;
        Wed, 21 Aug 2024 12:10:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe1bb00sm64630186d6.55.2024.08.21.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:10:46 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:10:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH 09/19] mm: New follow_pfnmap API
Message-ID: <ZsY7swHd4ldRmBle@x1n>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-10-peterx@redhat.com>
 <Zr_c2C06eusc_b1l@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr_c2C06eusc_b1l@google.com>

On Fri, Aug 16, 2024 at 04:12:24PM -0700, Sean Christopherson wrote:
> On Fri, Aug 09, 2024, Peter Xu wrote:
> > Introduce a pair of APIs to follow pfn mappings to get entry information.
> > It's very similar to what follow_pte() does before, but different in that
> > it recognizes huge pfn mappings.
> 
> ...
> 
> > +int follow_pfnmap_start(struct follow_pfnmap_args *args);
> > +void follow_pfnmap_end(struct follow_pfnmap_args *args);
> 
> I find the start+end() terminology to be unintuitive.  E.g. I had to look at the
> implementation to understand why KVM invoke fixup_user_fault() if follow_pfnmap_start()
> failed.
> 
> What about follow_pfnmap_and_lock()?  And then maybe follow_pfnmap_unlock()?
> Though that second one reads a little weird.

If to go with the _lock() I tend to drop "and" to follow_pfnmap_[un]lock().
However looks like David preferred me keeping the name, so we don't reach a
quorum yet.  I'm happy to change the name as long as we have enough votes..

> 
> > + * Return: zero on success, -ve otherwise.
> 
> ve?

This one came from the old follow_pte() and I kept it. I only knew this
after search: a short way to write "negative" (while positive is "+ve").

Doesn't look like something productive.. I'll spell it out in the next
version.

> 
> > +int follow_pfnmap_start(struct follow_pfnmap_args *args)
> > +{
> > +	struct vm_area_struct *vma = args->vma;
> > +	unsigned long address = args->address;
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	spinlock_t *lock;
> > +	pgd_t *pgdp;
> > +	p4d_t *p4dp, p4d;
> > +	pud_t *pudp, pud;
> > +	pmd_t *pmdp, pmd;
> > +	pte_t *ptep, pte;
> > +
> > +	pfnmap_lockdep_assert(vma);
> > +
> > +	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
> > +		goto out;
> > +
> > +	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
> > +		goto out;
> 
> Why use goto intead of simply?
> 
> 		return -EINVAL;
> 
> That's relevant because I think the cases where no PxE is found should return
> -ENOENT, not -EINVAL.  E.g. if the caller doesn't precheck, then it can bail
> immediately on EINVAL, but know that it's worth trying to fault-in the pfn on
> ENOENT. 

I tend to avoid changing the retval in this series to make the goal of this
patchset simple.

One issue is I _think_ there's one ioctl() that will rely on this retval:

      acrn_dev_ioctl ->
        acrn_vm_memseg_map ->
          acrn_vm_ram_map ->
            follow_pfnmap_start

So we may want to try check with people to not break it..

Thanks,

-- 
Peter Xu



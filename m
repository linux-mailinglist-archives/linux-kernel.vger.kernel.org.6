Return-Path: <linux-kernel+bounces-225013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9045912A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5E28350E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80615664A;
	Fri, 21 Jun 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3X7MeWl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4D3B1A3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984740; cv=none; b=ZCnftTqVPz8RfZ9sPtubx3mZr6Pr0S70rj7+ZzcbwBYJMc7khlENi79X8A8DqqiJTxb4d9ka9mDIgDtdRC5anDAN6AjlKPv9vl1yGQM75u0ECze13y5KVY0M09QmF8omB4WFjJjO2YRmSC370lFgSevi1bYP3M+LV8HkMmgL8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984740; c=relaxed/simple;
	bh=lHyZQMFyQBIxGe/1Uk4NATAezI0CXjn57rf0CWpPxnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcON9ghYdnH2NOAAJOrCXww/Ct4vXFCHPxOn/QsqZLcgM2Eu0+6k+bTrQLGpOigSUtC8KHDh+Ld+M9bakfexdBFZlCHJJyto7SyHbmLhqa/I+DIadXKVvRkbtH5eHGz0vbJ8NM53ofUo79cQ03IN3iJFicL0/7kJD7TDIMbwFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3X7MeWl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718984737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvV7QxN2N8EkXiFQ37jwVC1N3GHUF6ZxiwTS9PAYN+c=;
	b=B3X7MeWlJqosfUIRCa32iQ/ZFFFdZ6xehvr8ykD64zFuA/8L3c0810LUP/g+FkZGfwjBOE
	8B7mMIP33kEQfbtnOnp0uoAf5KjPYqRlngeW5BYhaKG8jyqqjoVJPniHltAJPr6FSLPyNV
	ZKmcuV6ncs4Sj5L4m7O7FF+W4RGMHG4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-oVa9R-9PM9G_iCRy3zLxaw-1; Fri, 21 Jun 2024 11:45:36 -0400
X-MC-Unique: oVa9R-9PM9G_iCRy3zLxaw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4449d9e372eso2813901cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718984736; x=1719589536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvV7QxN2N8EkXiFQ37jwVC1N3GHUF6ZxiwTS9PAYN+c=;
        b=v8Q/Bzzj7Tjy99dQLQD3itR8dvS52vhhdpGpcTQt2llcYowcQw2/8AUZX8ukfpOL7Y
         Md1BW5RcEZoj2kJCkKmh5vO3750tvVahCDw4YekdWvMVshGzAyZLcFSDOX2n+scFNreL
         ee5pLm0YnrhRRY0ISg4xBV1YHHzRMKzTOqhbZxJm6h5g9RLN2g3CX2F2ziR09qN4jhIx
         IZO+2LV9N260DcqTsQPA6bR6dQDSpt5B49Fhk/4DYTK7JQPW3wJMYGtsHxQRiZ3Hjppz
         yXdUk608/ZXoN7qgP7jCVORna3rlvOzvUrA9guWi9B4KRfyDygaEtnqLH6Hnd7eJSpve
         TWIA==
X-Gm-Message-State: AOJu0YyyRaxhIz3PpqXifENOnRjJva/2wTQ3LFXVZvE4uo7bnHZH62Fv
	zvwq7zXIZ6ObJ95K2dl2R5npcoEehsBQGiiWTf+wqtK0JBhb02mHfmqsMQZnR3F3FGmPvKATxod
	MLh0yEMOXzZccMXttqSos9T7nDXXfsOXHIseL4WNhEzEpl99URf6e5HNVbcUWRQ==
X-Received: by 2002:ad4:5be2:0:b0:6b2:bfe2:70c3 with SMTP id 6a1803df08f44-6b501ede972mr90358016d6.4.1718984735675;
        Fri, 21 Jun 2024 08:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB4nZlIY0H/jVph74+0l9c524qednI2eEp5OI3eX2TFxMHuOsOPAnloJuGVmQCrkbVd6KN2g==
X-Received: by 2002:ad4:5be2:0:b0:6b2:bfe2:70c3 with SMTP id 6a1803df08f44-6b501ede972mr90357756d6.4.1718984735058;
        Fri, 21 Jun 2024 08:45:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef4b1f7sm9609536d6.108.2024.06.21.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:45:34 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:45:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 6/7] mm/x86: Add missing pud helpers
Message-ID: <ZnWgG7WmZWS-xWJU@x1n>
References: <20240621142504.1940209-1-peterx@redhat.com>
 <20240621142504.1940209-7-peterx@redhat.com>
 <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com>

On Fri, Jun 21, 2024 at 07:51:26AM -0700, Dave Hansen wrote:
> On 6/21/24 07:25, Peter Xu wrote:
> > These new helpers will be needed for pud entry updates soon.  Namely:
> > 
> > - pudp_invalidate()
> > - pud_modify()
> 
> I think it's also definitely worth noting where you got this code from.
> Presumably you copied, pasted and modified the PMD code.  That's fine,
> but it should be called out.

Yes that's from PMD ones.  Sure, I will add that.

> 
> ...
> > +static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
> > +{
> > +	pudval_t val = pud_val(pud), oldval = val;
> > +
> > +	/*
> > +	 * NOTE: no need to consider shadow stack complexities because it
> > +	 * doesn't support 1G mappings.
> > +	 */
> > +	val &= _HPAGE_CHG_MASK;
> > +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> > +	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
> > +
> > +	return __pud(val);
> > +}
> 
> First of all, the comment to explain what you didn't do here is as many
> lines as the code to _actually_ implement it.
> 
> Second, I believe this might have missed the purpose of the "shadow
> stack complexities".  The pmd/pte code is there not to support modifying
> shadow stack mappings, it's there to avoid inadvertent shadow stack
> mapping creation.
> 
> That "NOTE:" is ambiguous as to whether the shadow stacks aren't
> supported on 1G mappings in Linux or the hardware (I just checked the
> hardware docs and don't see anything making 1G mappings special, btw).

Right this could be ambiguous indeed; I was trying to refer to the fact
where shadow stack is only supported on anon, and anon doesn't support 1G.
But looks like I'm more than wrong than that..

> 
> But, still, what if you take a Dirty=1,Write=1 pud and pud_modify() it
> to make it Dirty=1,Write=0?  What prevents that from being
> misinterpreted by the hardware as being a valid 1G shadow stack mapping?

Thanks for pointing that out.  I think I was thinking it will only take
effect on VM_SHADOW_STACK first, so it's not?

I was indeed trying to find more information on shadow stack at that time
but I can't find as much on the pgtable implications, on e.g. whether "D=1
+ W=0" globally will be recognized as shadow stack.  At least on SDM March
2024 version Vol3 Chap4 pgtable entries still don't explain these details,
or maybe I missed it.  Please let me know if there's suggestion on what I
can read before I post a v2.

So if it's globally taking effect, indeed we'll need to handle them in PUDs
too.

Asides, not sure whether it's off-topic to ask here, but... why shadow
stack doesn't reuse an old soft-bit to explicitly mark "this is shadow
stack ptes" when designing the spec?  Now it consumed bit 58 anyway for
caching dirty. IIUC we can avoid all these "move back and forth" issue on
dirty bit if so.

> 
> >  /*
> >   * mprotect needs to preserve PAT and encryption bits when updating
> >   * vm_page_prot
> > @@ -1377,10 +1398,25 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> >  }
> >  #endif
> >  
> > +static inline pud_t pudp_establish(struct vm_area_struct *vma,
> > +		unsigned long address, pud_t *pudp, pud_t pud)
> > +{
> > +	if (IS_ENABLED(CONFIG_SMP)) {
> > +		return xchg(pudp, pud);
> > +	} else {
> > +		pud_t old = *pudp;
> > +		WRITE_ONCE(*pudp, pud);
> > +		return old;
> > +	}
> > +}
> 
> Why is there no:
> 
> 	page_table_check_pud_set(vma->vm_mm, pudp, pud);
> 
> ?  Sure, it doesn't _do_ anything today.  But the PMD code has it today.
>  So leaving it out creates a divergence that honestly can only serve to
> bite us in the future and will create a head-scratching delta for anyone
> that is comparing PUD and PMD implementations in the future.

Good question, I really don't remember why I didn't have that, since I
should have referenced the pmd helper.  I'll add them and see whether I'll
hit something otherwise.

Thanks for the review.

-- 
Peter Xu



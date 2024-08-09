Return-Path: <linux-kernel+bounces-281323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE4A94D57B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9E41C21460
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEF75809;
	Fri,  9 Aug 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upiWoNgv"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C93C099
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224783; cv=none; b=NYr4cjN88HoG8fZWaaiH5tFc+5cr0wutgsbPn0cQHjZaXyZwnWD6ZAJ99LqU3yaX5cf9zKfwputiCEFViUNB2+IZVZ6OnUd1sM19rjFjv5s603O1cd1f5KJGeOb3HLsn/w1tIVduaZXPUDhmy/6wX5Qyrw4OLzN4g5bso4BzeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224783; c=relaxed/simple;
	bh=l1NWlvMLHaGqa7dyNqVER4Hf/rYQEvSPJ5tYisoEuag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYNiITi057ZGWFDvpYjswjJcmldpo7280Cwc79fKA+5Jwgi1n6Otb9o2oPn+/nlgjuJfDv/DnzqVmYE20o04NaEPMcIJaNlwaJG9Gw4Ra/dmS3EBR0NLlkN3fmhFv+pqMD/MQqMwtVDeqQIhzEmV2fN+7A59oqKTyUAoR4ON4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upiWoNgv; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so306848266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723224780; x=1723829580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ereUzNK4DWvTNzQWOYCjmYPYZhGEXynrCwHRHEGdXSA=;
        b=upiWoNgvKkR31/RiGfySV9r5MmWkpiyJBzvOfnsD2n+ZkX+O7bIp6ww20ddmMaavU3
         PcSU49PbnoqqOAiOBbBnjE9fJ9oqjaFgcMaTUHLqeUidxLoMTMbKDYwE50a+ULQ5zmHf
         1gav2IeIh0zJIgesXIXaXzHSuGSF9tHsxAddj8WY+5F4jnPiuMpouARJJp/ApY7JXZ11
         NpDoOW8uLSpG+dK+Ih1WL8kwa1y5CVruAV1yOlxs/Z+YkAmMQjE8gLSg4m2KH7ZNRjIg
         nzKfABAt6xoNvSa2xI63eE7N2ZNnBvT4RBsvLKOH8mYuZsRdXI5cLszoAxn1KCT+lJvO
         2QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224780; x=1723829580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ereUzNK4DWvTNzQWOYCjmYPYZhGEXynrCwHRHEGdXSA=;
        b=GWb566U6uaOc/Z+oBr7DUrrlmgsDO+534BH4qC8d4ggUayfBlz4N+ade7LTUTfdW5K
         1T1wjADzQEe65tDMRt8nV8eiOZOSPj12kdGdgky5zyQFpcHSEV4lWmMhJ6wPrTunl169
         pNnMJK+eVw+KDKyiam0Mhk6ijxlw7VY/PCxgyNIUsjocqLQzBhrKBu0WuW5gUmoG0rlS
         3G0zr9MXsWcubNFPcm1ceS5jiKfya8njppDRbOPFWRgXjFHlGMywbwM+Gy8jzHiFearx
         L69fRrrvm+oSgi+Koctd0yY5yh1SYUtkXWV9R0mDG2Ar4vs1duCW8lLl5IjrOnO8593u
         Rqiw==
X-Forwarded-Encrypted: i=1; AJvYcCXHhbnmjYEr6zH0rlIGWe6HmOCjvp9DtYKXNG1GmsQTVzyX+bVS3fM3mhLMn0nHKfpnh3kyZV3v59LNLU/KBFaXF91vM0xgkJmcsli+
X-Gm-Message-State: AOJu0YzjclrO7zfQ+ZLKvMW5v1QeB5IZIa4SRf/QlS6Z/tDFA4Q2O3Il
	iT1xLZ56et1pXWqVeXeSt7j0HS9day8k5kDMEftrACrfpnXyzw+lbi3NmuWK4g==
X-Google-Smtp-Source: AGHT+IHFg5ZujV87Lfz0/UJ1zhNH6C90AvUFHjbvuKyFoGTnYvm4K3OoNMdP/d9n94ARppYJWiagMQ==
X-Received: by 2002:a17:907:e6d9:b0:a77:dafb:2bf9 with SMTP id a640c23a62f3a-a80aa65cf46mr193394466b.49.1723224779425;
        Fri, 09 Aug 2024 10:32:59 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8884sm858359766b.193.2024.08.09.10.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:32:59 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:32:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: g@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
	surenb@google.com
Subject: Re: [PATCH v2 08/40] mm/memory: page_add_file_rmap() ->
 folio_add_file_rmap_[pte|pmd]()
Message-ID: <ZrZSx7T8EjFrIFAE@google.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-9-david@redhat.com>
 <ZrZOUaj2Kfe0CimQ@google.com>
 <341acdcc-1745-436b-a3c7-26916b675175@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341acdcc-1745-436b-a3c7-26916b675175@redhat.com>

On Fri, Aug 09, 2024 at 07:27:27PM +0200, David Hildenbrand wrote:
> On 09.08.24 19:13, Vincent Donnefort wrote:
> > Hi,
> > 
> > Sorry, reviving this thread as I have ran into something weird:
> > 
> > On Wed, Dec 20, 2023 at 11:44:32PM +0100, David Hildenbrand wrote:
> > > Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
> > > perform some folio conversion.
> > > 
> > > Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> > > Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   mm/memory.c | 14 ++++++++------
> > >   1 file changed, 8 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 7f957e5a84311..c77d3952d261f 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > 
> > [...]
> > 
> > >   vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > >   {
> > > +	struct folio *folio = page_folio(page);
> > >   	struct vm_area_struct *vma = vmf->vma;
> > >   	bool write = vmf->flags & FAULT_FLAG_WRITE;
> > >   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> > > @@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> > >   		return ret;
> > > -	page = compound_head(page);
> > > -	if (compound_order(page) != HPAGE_PMD_ORDER)
> > > +	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > >   		return ret;
> > 
> > Is this `page != &folio->page` expected? I believe this check wasn't there
> > before as we had `page = compound_head()`.
> > 
> > It breaks the installation of a PMD level mapping for shmem when the fault
> > address is in the middle of this block. In its fault path, shmem sets
> > 
> >    vmf->page = folio_file_page(folio, vmf->pgoff)
> > 
> > which fails this test above.
> 
> Already fixed? :)
> 
> commit ab1ffc86cb5bec1c92387b9811d9036512f8f4eb (tag:
> mm-hotfixes-stable-2024-06-26-17-28)
> Author: Andrew Bresticker <abrestic@rivosinc.com>
> Date:   Tue Jun 11 08:32:16 2024 -0700
> 
>     mm/memory: don't require head page for do_set_pmd()
> 

Duh of course I haven't looked anything recent enough, my bad!

Thanks for your quick answer!

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


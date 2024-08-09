Return-Path: <linux-kernel+bounces-281301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394F94D53F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39481F21C98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBAC3B1BC;
	Fri,  9 Aug 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1e5bAvB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EC38FA3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223647; cv=none; b=YRFuGZzEW/Tp4ihkCQB4KAcibPdyHSypB8nuVHCb+wRWr4WffIhYHYhO0AJ4owsDJ8/VYHNu2aEUpvKnsJrLJdWeoQ5TQs6bHGE+ZhgD3sHUh8ZQ+X9kbPvKuoY442GuNXgKEAiYfWI1zcUUlC309pNyP6YpDOP6RFnD4jmZMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223647; c=relaxed/simple;
	bh=6ZVFTNlPC8QWczI2Ic4bBKucKgX6CwLc7PFcrjI1BwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3yDvQs5QAW1BHcjhRxRNdA3f9fYxt5Ek/J/rWlITXxrBML46Z98cumRQk/N/UROkT1aKEZFcR1UER4RamMIqReTg6sX/vEw++u0KLrg8GUmFC4DxPPCblJ/C3154VWY0aUHm8iMAmGILKs542OHENUjLjSsqX543HZvvIb4CfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1e5bAvB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428e3129851so16556015e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723223644; x=1723828444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X82rK3vly3bHNJXevneup4t5s+6w7V3sCCQPbEHfLcQ=;
        b=o1e5bAvBX1S+79xYSSYAZO/OV5/In7tO5lidTJjspDVk7FpF7tzE3+EtPebbZ8oGqE
         vnP89Cak/esQgyppjAg6zTitFnwPPJ31iRojqaAJb2TTkw//oEKluUMe1srB/aizQdHQ
         ABBEoZfzu964h6ywIR67dW48Mq1ZnntBk851m0HY4z4ZEZ2uzpTCubktg86vm37AMNfm
         byWbtK5QxvL0zWC6KMJbk5xSpDNfiYhGAg5TRdvbkkR+FQ6Mbg7ars3s2IbJQSopIAjs
         o9wgDPaTxmTb4TB8d6rGHXPfLCCPASAk8t4v3NW85W3xYRirED151KkUt2sdgixQWpWO
         Sebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223644; x=1723828444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X82rK3vly3bHNJXevneup4t5s+6w7V3sCCQPbEHfLcQ=;
        b=JXsZ3TXNSiqYtyR66HsecIM88/tDWlipQ1Wb2a5YdwUl49q36S1zxfdS8QqoIRrUrW
         MkmbiBI2fY1sA6YaM8uNc6REkCYkUDeXHaKdNmcbE4J8DXrbbXIMVAyuAvYj++46q0R2
         vXbV/M5wbzI39QUYEUUtqU8MvXce6IypR0/xxWb8Bgh3PHmWjiNYDZKnNHB5+hroyag5
         orvHq2JKYeIAooFCbmXVuffFWa2wD6+QkIlfBu1WSlnXld/D8+UGLXQOa+6YLhGmoky8
         2RdOb2F3beJddniESy0VHcAi3hoamQ8+v883+L/4T+Zxkh7LoZHkI/e1mnL7gpVn78NR
         wqRw==
X-Gm-Message-State: AOJu0YxLHdD89vXK8ejXXmEs8rCYXtMoH/XctLPccLC/Vl9jRXH2sSrz
	bH0ZgbZiHJUIXmIYtAWxRTUQr1sFxMAVa3Tn2MinErQMDQ8s0LxpqvvdM3RidA==
X-Google-Smtp-Source: AGHT+IHkIcnpn2ila8zjxAIDAcXfD2VxBs3tHbDTxk8bRQdeit1pwxjEHXAXVNITEiRV7TV5IPZOyA==
X-Received: by 2002:a05:600c:46c5:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-429c39c4341mr18452555e9.0.1723223643580;
        Fri, 09 Aug 2024 10:14:03 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cd2b3sm135730695e9.44.2024.08.09.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:14:02 -0700 (PDT)
Date: Fri, 9 Aug 2024 18:13:53 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>, g@google.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
Message-ID: <ZrZOUaj2Kfe0CimQ@google.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-9-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220224504.646757-9-david@redhat.com>

Hi,

Sorry, reviving this thread as I have ran into something weird:

On Wed, Dec 20, 2023 at 11:44:32PM +0100, David Hildenbrand wrote:
> Let's convert insert_page_into_pte_locked() and do_set_pmd(). While at it,
> perform some folio conversion.
> 
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7f957e5a84311..c77d3952d261f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

[...]

>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
>  	struct vm_area_struct *vma = vmf->vma;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> @@ -4418,8 +4421,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>  		return ret;
>  
> -	page = compound_head(page);
> -	if (compound_order(page) != HPAGE_PMD_ORDER)
> +	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>  		return ret;

Is this `page != &folio->page` expected? I believe this check wasn't there
before as we had `page = compound_head()`.

It breaks the installation of a PMD level mapping for shmem when the fault
address is in the middle of this block. In its fault path, shmem sets

  vmf->page = folio_file_page(folio, vmf->pgoff)

which fails this test above.

>  
>  	/*
> @@ -4428,7 +4430,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	 * check.  This kind of THP just can be PTE mapped.  Access to
>  	 * the corrupted subpage should trigger SIGBUS as expected.
>  	 */
> -	if (unlikely(PageHasHWPoisoned(page)))
> +	if (unlikely(folio_test_has_hwpoisoned(folio)))
>  		return ret;
>  
>  	/*
> @@ -4452,7 +4454,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>  
>  	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
> -	page_add_file_rmap(page, vma, true);
> +	folio_add_file_rmap_pmd(folio, page, vma);
>  
>  	/*
>  	 * deposit and withdraw with pmd lock held
> -- 
> 2.43.0
> 


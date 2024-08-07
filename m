Return-Path: <linux-kernel+bounces-278484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B594B0DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F641F238DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAB0145FED;
	Wed,  7 Aug 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="OEbqjA82"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4D84A51
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060970; cv=none; b=Uo7WGOWNmbSF0BqXo//WJkmRB0aIhEAApzA5RQb5IpEa9Goxp56BY6kc3ACBMqK/PjFI3rTCMC4BX5KSNBHQVB69/q2nseUZvGBics+v6XHwqjt/9xGAjZbD0faqP+RtGXAnLkho/ZYqpjZcUP5p1pnprNpoF+2VtFBKYZpTOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060970; c=relaxed/simple;
	bh=loW4ytgswoIfwflAl9gmrh62vfKV9olE17s/r6GLh+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX17/FHyohJ6U3SZYwKYnmsHtgWywyQHd0EgiIqPfiSZ8z4SD0qlG3XzCcgyYaETs4fnBmBE7X1ca3jxRGObUyvmzhlnRp5ExN7lGpCqJE8iTJk99rcu/tCaLN7Px4rLFPo4f1KImDLMn7gMT1SssyPHcacgveRfS6WhLgtuEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=OEbqjA82; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-260e1b5576aso202885fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1723060966; x=1723665766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+brkYlGx1yVizPmds0/xrvR0e4BjjJDeJcomNPr/5ig=;
        b=OEbqjA823YV/vkMXce/5bu2D8FXsDQojRBGZm4A1JTRpmAru/qEGZEAaDwhNA9oaAG
         RhMtH3buxRcJ02+9ep5sEIVVhNhDdqs4RMz6+Zda7SmD8NXxbmaWo+Th0qKtzMZMg1mv
         +uAVESh2Wz1TAl2KLJiqZosFAi7uFM1I5E5lzVoYm3v1IO9HYKe7I+pIyMOeSAxEAgCG
         BfurDcfDambxAKsrwS43xZNFu45pq6CntR2WK1p3X4u6G6woJtSptgVr43JQTncs+tek
         VLzNcG3tIKJ3B0JSUL3opMJOnYav59BdVfUMv+58jNhYKzzFXSp9QvEcvjXdWq2no6ZL
         Wx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060966; x=1723665766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+brkYlGx1yVizPmds0/xrvR0e4BjjJDeJcomNPr/5ig=;
        b=G7vDaeqUqEECeuhC/5SghOYHCpePHyH/G44XoxsnQpgHqUJ/66L4nBh5uPz+FnFT1e
         eS/c/8Z2UF/TEhFXPUplzVGwKqwuW1esh93t173/Li9RhUCGOXeUb4x0VrM+Ppj1kk8Z
         p3Fl7wP/s3fDsKAHydeHsM0bS/sB3eZhQeR1KzDVrde1R9FBaOt7y75eJ7rRuruf0y1E
         hiwNsoXIli9GlHlQ3xMHRmA5k/xhehnxk64L/5qQpsEtdk5I3shpVHFdW+4kftNR2tAo
         qXYdM8Mlu73h9YdV0Yi7l63yksNu1RYNEazzlHC6ovLnBe5yfjtpIGfF9RTw+g9f8WlZ
         1pMA==
X-Forwarded-Encrypted: i=1; AJvYcCWb7jyT33cGOJ7dvWW7RJ0lIknXpaNGpMxMXz//Mjc/XcyYdylps8pt0JA3MNv+wh5194ORn0hXkHgl3htM+Q/DhKf940/Rv+30XO89
X-Gm-Message-State: AOJu0YzXh25Dr9P0dlCftNYrRKytHsyqr7q3hMAV9Cy54kQOV/PtkVWT
	6Kw3QNz02jgay/oydEgdUBJmen0HFmiVptIC19Qhl/aSTeplIGtoEFg3bf0Aq74=
X-Google-Smtp-Source: AGHT+IHm4lElGrpdy1ljKvesf4jnIf+MFP8g8N3ZxqP6Eg0GFYz2mWkRMbwWAscXaxzdAv4QdJpU/Q==
X-Received: by 2002:a05:6870:96a5:b0:261:515:d311 with SMTP id 586e51a60fabf-26891d3db7dmr23503501fac.18.1723060966402;
        Wed, 07 Aug 2024 13:02:46 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e350asm88774785a.39.2024.08.07.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 13:02:45 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:02:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, riel@surriel.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yuzhao@google.com,
	david@redhat.com, baohua@kernel.org, ryan.roberts@arm.com,
	rppt@kernel.org, willy@infradead.org, cerasuolodomenico@gmail.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH v2 2/4] mm: remap unused subpages to shared zeropage when
 splitting isolated thp
Message-ID: <20240807200241.GB1828817@cmpxchg.org>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-3-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807134732.3292797-3-usamaarif642@gmail.com>

On Wed, Aug 07, 2024 at 02:46:47PM +0100, Usama Arif wrote:
> @@ -177,13 +177,56 @@ void putback_movable_pages(struct list_head *l)
>  	}
>  }
>  
> +static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
> +					  struct folio *folio,
> +					  unsigned long idx)
> +{
> +	struct page *page = folio_page(folio, idx);
> +	bool contains_data;
> +	pte_t newpte;
> +	void *addr;
> +
> +	VM_BUG_ON_PAGE(PageCompound(page), page);
> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +
> +	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
> +		return false;
> +
> +	/*
> +	 * The pmd entry mapping the old thp was flushed and the pte mapping
> +	 * this subpage has been non present. If the subpage is only zero-filled
> +	 * then map it to the shared zeropage.
> +	 */
> +	addr = kmap_local_page(page);
> +	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
> +	kunmap_local(addr);
> +
> +	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
> +		return false;
> +
> +	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
> +					pvmw->vma->vm_page_prot));

Why not use my_zero_pfn() here? On many configurations this just
returns zero_pfn and avoids the indirection through mem_map.

> @@ -904,7 +958,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
>  	 * At this point we know that the migration attempt cannot
>  	 * be successful.
>  	 */
> -	remove_migration_ptes(folio, folio, false);
> +	remove_migration_ptes(folio, folio, false, false);

bool params are not great for callsite readability.

How about a flags parameter and using names?

enum rmp_flags {
	RMP_LOCKED	= 1 << 0,
	RMP_ZEROPAGES	= 1 << 1,
}

